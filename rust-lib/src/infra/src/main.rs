use actix_web::{middleware, App, HttpServer};
use infra::http::server::handler;

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    env_logger::init_from_env(env_logger::Env::new().default_filter_or("info"));

    log::info!("starting HTTP server at http://localhost:8080");

    HttpServer::new(|| {
        App::new()
            .service(handler::third_cloud_handler)
            .wrap(middleware::Logger::default())
    })
    .bind(("127.0.0.1", 8080))?
    .run()
    .await
}
