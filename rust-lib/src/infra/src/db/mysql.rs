use sqlx::{
    mysql::{MySqlConnectOptions, MySqlPoolOptions},
    ConnectOptions, MySql, Pool,
};
use once_cell::sync::Lazy;

pub static CLIENT: Lazy<Pool<MySql>> = Lazy::new(connect);


fn connect() -> Pool<MySql> {
    let db_opts = MySqlConnectOptions::from_str(r"")
        .expect("mysql connect options create failed")
        .disable_statement_logging();

    MySqlPoolOptions::new()
        .connect_lazy_with(db_opts)
}


pub struct MySqlDriver {}

impl MySqlDriver {
    pub fn new() -> Self {
        Self {}
    }  
}


