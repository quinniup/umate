use com::device::client::grpc::device_instance_service_client::DeviceInstanceServiceClient;
use com::device::client::grpc::DeviceInstanceCreatePb;
use google::protobuf::{Int32Value, StringValue};

use crate::csv_file;

pub mod google {
    pub mod protobuf {
        include!(concat!(env!("OUT_DIR"), "/google.protobuf.rs"));
    }
}

pub mod com {
    pub mod device {
        pub mod client {
            pub mod grpc {
                include!(concat!(env!("OUT_DIR"), "/com.device.client.grpc.rs"));
            }
        }
    }
}

async fn connect() -> DeviceInstanceServiceClient<tonic::transport::Channel> {
    let channel = tonic::transport::Channel::from_static("http://127.0.0.1:9009")
        .connect()
        .await
        .unwrap();
    DeviceInstanceServiceClient::new(channel)
}

async fn create_device_instance(ins: DeviceCreate) -> Result<String, Box<dyn std::error::Error>> {
    let mut req_msg = DeviceInstanceCreatePb::default();
    req_msg.name = Option::Some(StringValue { value: ins.name });
    req_msg.product_id = ins.product_id;
    req_msg.device_sn = ins.device_sn;
    req_msg.node_id = Option::Some(StringValue { value: ins.node_id });
    req_msg.instance_type = Option::Some(Int32Value { value: 1 });
    req_msg.parent_id = Option::Some(StringValue {
        value: ins.parent_id,
    });
    req_msg.space_id = "feilun_default".to_string();
    req_msg.describe = Option::Some(StringValue {
        value: ins.parent_node_id,
    });

    let request = tonic::Request::new(req_msg);
    let mut client = connect().await;
    let response = client.create(request).await?;

    println!("RESPONSE={:?}", response);
    Ok(response.into_inner().value)
}

#[derive(Debug, Clone)]
struct DeviceCreate {
    name: String,
    node_id: String,
    device_sn: String,
    product_id: String,
    parent_id: String,
    id: String,
    parent_node_id: String,
}

#[tokio::test]
async fn test_create_device_instance() {
    //create_device_instance().await.unwrap();

    // Import the necessary modules

    let rs = csv_file::read_gateway_csv().unwrap();
    println!("{:?}", rs.len());
    for r in rs {
        let ins = DeviceCreate {
            name: r.name,
            node_id: r.node_id.clone(),
            device_sn: r.node_id.clone(),
            product_id: r.product_id,
            parent_id: "".to_string(),
            id: "".to_string(),
            parent_node_id: "".to_string(),
        };

        let devid = create_device_instance(ins.clone()).await.unwrap();

        let mut inss = ins.clone();
        inss.id = devid;
        println!("{:?}", inss);
    }
}

#[tokio::test]
async fn test_create_ems_device_instace() {
    let rs = csv_file::read_ems_csv().unwrap();
    println!("{:?}", rs.len());
    let mut counter = 0;
    for r in rs {
        if r.iot_code.is_empty() {
            println!("{:?}", r);
            continue;
        }

        let name = r.name_prefix + "-" + &r.name;
        let desc = r.parent_name + ":" + &r.parent_node_id;

        let ins = DeviceCreate {
            name: name,
            node_id: r.iot_code.clone(),
            device_sn: r.iot_code.clone(),
            product_id: r.product_id,
            parent_id: r.parent_id.clone(),
            id: "".to_string(),
            parent_node_id: desc,
        };

        let devid = create_device_instance(ins.clone()).await.unwrap();
        let mut inss = ins.clone();
        inss.id = devid;
        println!("{:?}", inss);
        counter += 1;
    }
    println!("{:?}", counter);
}
