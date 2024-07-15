use std::io::Result;
use std::{env, path::PathBuf};


fn main() -> Result<()> {
    println!("cargo:rerun-if-changed=build.rs");
    println!("cargo:rerun-if-changed=proto");
    let out = PathBuf::from(env::var("OUT_DIR").unwrap());

    tonic_build::configure()
    .protoc_arg("--experimental_allow_proto3_optional")
    .type_attribute(".","#[derive(serde::Serialize,serde::Deserialize)]")
    .file_descriptor_set_path(out.join("descriptors.bin"))
    // .extern_path(".google.protobuf.Any", "::google::protobuf::Any")
    .build_client(true)
    .build_server(false)
    .compile_well_known_types(true)
    .compile(
        &[
        "proto/device/instance.proto"
        ],
        &["proto/"],)
        .unwrap();

    Ok(())
}