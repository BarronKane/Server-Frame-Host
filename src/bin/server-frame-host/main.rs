use util;

use actix_files as fs;
use actix_web::{web, App, Error, HttpRequest, HttpResponse, HttpServer, Result};

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    let mut dir = util::env::get_cwd().unwrap();
    dir.push("app");

    println!("Serving on: 127.0.0.1:8080");
    HttpServer::new(move || {
        App::new()
            .service(fs::Files::new("/", dir.to_str().unwrap()).index_file("index.html"))
    })
        .bind("127.0.0.1:8080")?
        .run()
        .await
}
