use base64::prelude::*;
use csv::Error;
use http_body_util::BodyExt;
use hyper::{header, Request};
use hyper_util::rt::TokioIo;
use std::io::Read;
use tokio::net::TcpStream;

#[tokio::test]
async fn test_tdengine_data() {
    // Parse our URL...
    let url = "http://localhost:6041/rest/sql/iot_core"
        .parse::<hyper::Uri>()
        .unwrap();

    let host = url.host().expect("uri has no host");
    let port = url.port_u16().unwrap_or(80);
    let addr = format!("{}:{}", host, port);
    let stream = TcpStream::connect(addr).await.unwrap();
    let io = TokioIo::new(stream);

    let (mut sender, conn) = hyper::client::conn::http1::handshake(io).await.unwrap();
    tokio::task::spawn(async move {
        if let Err(err) = conn.await {
            println!("Connection failed: {:?}", err);
        }
    });
    let authority = url.authority().unwrap().clone();
    let sql = "select `_ts`, `realm_device_id`, last(`ZigbeeInfo`) from `history_shadow_xmkc8tdmb5xacpvj` where _ts > 1721093283000 group by `realm_device_id` limit 500".to_string();

    let auth_token = BASE64_STANDARD.encode(b"root:hXuGapRcWj4tODOl");
    // Create an HTTP request with an empty body and a HOST header
    let req = Request::post(url)
        .header(hyper::header::HOST, authority.as_str())
        .header(header::AUTHORIZATION, format!("Basic {}", auth_token))
        //.header(header::CONTENT_TYPE, "application/json")
        .body(sql)
        .unwrap();
    println!("Headers: {:#?}\n", req.headers());
    println!("Body: {:#?}\n", req.body());

    // Await the response...
    let mut res = sender.send_request(req).await.unwrap();

    println!("Headers: {:#?}\n", res.headers());
    println!("Response status: {}", res.status());

    let mut b: Vec<u8> = Vec::new();
    while let Some(next) = res.frame().await {
        let frame = next.unwrap();
        if let Some(chunk) = frame.data_ref() {
            chunk.bytes().for_each(|a| b.push(a.unwrap()));
        }
    }

    let td_result = TDResult::from_bytes(b);
    println!("TDResult::code {}", td_result.code);
    // println!("TDResult::column_meta {:#?}", td_result.column_meta);
    // println!("TDResult::data {:#?}", td_result.data);
    println!("TDResult::rows {}", td_result.rows);

    let mut dev_infos: Vec<DeviceInfo> = Vec::new();
    td_result
        .data
        .iter()
        .map(|row| {
            let zigbee_info = row[2].clone();
            let decode_hex = BASE64_STANDARD.decode(zigbee_info.clone()).unwrap();
            let hex_str = hex::encode(decode_hex.clone());
            if hex_str.contains(r"0844") || hex_str.contains(r"4408") {
                println!("Found 0x0844, device_id = {}", row[1].clone());
            }
            return DeviceInfo::new(row[1].clone(), zigbee_info.clone(), hex_str);
        })
        .for_each(|row| {
            dev_infos.push(row);
        });
    // println!("PanId is 0x0844 of device ids: {:?}", dev_infos);
    _ = write_device_info_csv(dev_infos);
}

pub fn write_device_info_csv(recodes: Vec<DeviceInfo>) -> Result<(), Error> {
    let path = "/Users/gongtai/csv/device_zigbee_info.csv";
    let mut wtr = csv::Writer::from_path(path).unwrap();
    for r in recodes {
        wtr.serialize(r)?;
    }
    wtr.flush().unwrap();
    Ok(())
}

#[derive(serde::Deserialize, serde::Serialize, Debug)]
struct DeviceInfo {
    device_id: String,
    zigbee_info: String,
    pan_id: String,
}

impl DeviceInfo {
    fn new(device_id: String, zigbee_info: String, pan_id: String) -> Self {
        Self {
            device_id,
            zigbee_info,
            pan_id,
        }
    }
}

#[derive(serde::Deserialize, serde::Serialize, Debug)]
struct ColumnMeta {
    name: String,
    data_type: String,
    length: i32,
}

#[derive(serde::Deserialize, serde::Serialize)]
struct TDResult {
    code: i32,
    column_meta: Vec<Box<ColumnMeta>>,
    data: Vec<Vec<String>>,
    rows: i32,
}

impl Default for TDResult {
    fn default() -> Self {
        Self {
            code: 0,
            column_meta: Vec::new(),
            data: Vec::new(),
            rows: 0,
        }
    }
}

impl TDResult {
    fn from_bytes(bytes: Vec<u8>) -> Self {
        let s = String::from_utf8(bytes).unwrap();
        println!("Response body: {}", s);
        serde_json::from_str(&s).unwrap()
    }
}
