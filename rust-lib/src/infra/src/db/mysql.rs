use once_cell::sync::Lazy;
use sqlx::{
    mysql::{MySqlConnectOptions, MySqlPoolOptions},
    ConnectOptions, MySql, Pool,
};
use std::str::FromStr;

pub static CLIENT: Lazy<Pool<MySql>> = Lazy::new(connect);

fn connect() -> Pool<MySql> {
    let url = "mysql://user@hostname:password@hostname:5432/database".to_string();
    let db_opts = MySqlConnectOptions::from_str(&url)
        .expect("mysql connect options create failed")
        .disable_statement_logging();

    MySqlPoolOptions::new().connect_lazy_with(db_opts)
}

pub struct MySqlDriver {}

impl MySqlDriver {
    pub fn new() -> Self {
        Self {}
    }
}
