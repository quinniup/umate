
use std::fs::File;
use std::io::BufReader;
use serde::{Deserialize, Serialize};
use csv::Error;

#[derive(Deserialize, Debug)]
pub struct GatewayRecord {
    pub name: String,
    pub node_id: String,
    pub product_id: String,
}



pub fn read_gateway_csv() -> Result<Vec<GatewayRecord>, Error> {
    let path = "/Users/gongtai/csv/gateway.csv";
    let input = File::open(path).unwrap();
    let buffered = BufReader::new(input);
    let mut rdr = csv::Reader::from_reader(buffered);
    let mut records = Vec::new();
    for r in rdr.deserialize() {
        let record:GatewayRecord = r.unwrap();
        records.push(record);
    }
    Ok(records)
}

#[derive(Deserialize, Debug)]
pub struct EmsDeviceRecord {
    pub parent_node_id: String,
    pub parent_id: String,
    pub parent_name: String,
    pub name_prefix: String,
    pub name: String,
    pub iot_code: String,
    pub product_id: String,
}

pub fn read_ems_csv() -> Result<Vec<EmsDeviceRecord>, Error> {
    let path = "/Users/gongtai/csv/ems_devices.csv";
    let input = File::open(path).unwrap();
    let buffered = BufReader::new(input);
    let mut rdr = csv::Reader::from_reader(buffered);
    let mut records = Vec::new();
    for r in rdr.deserialize() {
        let record:EmsDeviceRecord = r.unwrap();
        records.push(record);
    }
    Ok(records)
}



#[derive(Deserialize, Serialize, Debug, Clone)]
pub struct GatewayMQTTRecord {
    pub device_id: String,
    pub device_sn: String,
    pub name: String,
    pub configuration: String,
    pub client_id: String,
    pub password: String,
    pub up_topic: String,
    pub down_topic: String,
}


#[derive(Deserialize, Serialize, Debug, Clone)]
pub struct Configuration {
    pub secureId: String,
    pub secureKey: String
}


pub fn read_gateway_mqtt_csv() -> Result<Vec<GatewayMQTTRecord>, Error> {
    let path = "/Users/gongtai/csv/dbdev_device_instance.csv";
    let input = File::open(path).unwrap();
    let buffered = BufReader::new(input);
    let mut rdr = csv::Reader::from_reader(buffered);
    let mut records = Vec::new();
    for r in rdr.deserialize() {
        let record:GatewayMQTTRecord = r.unwrap();
        records.push(record);
    }
    Ok(records)
}


pub fn write_gateway_mqtt_csv(recodes: Vec<GatewayMQTTRecord>) -> Result<(), Error> {
    let path = "/Users/gongtai/csv/dbdev_device_instance_cp.csv";
    let mut wtr = csv::Writer::from_path(path).unwrap();
    for r in recodes {
        wtr.serialize(r)?;
    } 
    wtr.flush().unwrap();
    Ok(())
}