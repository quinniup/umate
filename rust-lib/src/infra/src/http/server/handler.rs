use actix_web::{post, web, HttpRequest, Responder};


#[post("/tst/api/v1/3rd/devices/{third_cloud}")]
pub async fn third_cloud_handler(req: HttpRequest, payload: web::Payload) -> impl Responder {
    let third_cloud = req.match_info().get("third_cloud").unwrap();

    let p: web::Bytes = payload.to_bytes().await.unwrap();
    let body = String::from_utf8(p.to_vec()).unwrap();
    println!("third_cloud[{}] request:\n\t {}", third_cloud, body);

    "OK"
}



