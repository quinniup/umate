use actix_web::{middleware, App, HttpServer};
use infra::http::server::handler;

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    // env_logger::init_from_env(env_logger::Env::new().default_filter_or("info"));
    use env_logger::{Builder, Env};

    use std::io::Write;
    fn init_logger() {
        let env = Env::default()
            .filter("MY_LOG_LEVEL")
            .write_style("MY_LOG_STYLE");

        Builder::from_env(env)
            .format(|buf, record| {
                // We are reusing `anstyle` but there are `anstyle-*` crates to adapt it to your
                // preferred styling crate.
                let warn_style = buf.default_level_style(log::Level::Warn);

                writeln!(
                    buf,
                    "{warn_style}{}{warn_style:#}",
                    record.args()
                )
            })
            .init();
    }

    init_logger();

    log::info!("starting HTTP server at http://localhost:8080");

    HttpServer::new(|| {
        App::new()
            .service(handler::third_cloud_handler)
            .wrap(middleware::Logger::default())
    })
    .bind(("0.0.0.0", 8086))?
    .run()
    .await
}
