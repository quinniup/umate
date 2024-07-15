
use google::protobuf::{Int32Value, StringValue};
use com::changyuan::feilun::iotcore::client::grpc::device_instance_service_client::DeviceInstanceServiceClient;
use com::changyuan::feilun::iotcore::client::grpc::DeviceInstanceCreatePb;

pub mod google{
    pub mod protobuf{
        include!(concat!(env!("OUT_DIR"), "/google.protobuf.rs"));
    }
}

pub mod com{
    pub mod changyuan{
        pub mod feilun{
            pub mod iotcore{
                pub mod client{
                    pub mod grpc{
                        include!(concat!(env!("OUT_DIR"), "/com.changyuan.feilun.iotcore.client.grpc.rs"));
                    }
                }
            }
        
        }
    }
}


async fn connect() -> DeviceInstanceServiceClient<tonic::transport::Channel> {
    let channel = tonic::transport::Channel::from_static("http://localhost:9090")
        .connect()
        .await
        .unwrap();
    DeviceInstanceServiceClient::new(channel)
}

async fn create_device_instance() -> Result<(), Box<dyn std::error::Error>> {
    
    let mut req_msg = DeviceInstanceCreatePb::default();
    req_msg.name = Option::Some(StringValue{value: "name".to_string()});
    req_msg.product_id = "device_id".to_string();
    req_msg.device_sn = "third_device_id".to_string();
    req_msg.node_id = Option::Some(StringValue{value: "third_device_id".to_string()});
    req_msg.instance_type = Option::Some(Int32Value{value: 1});

    let request = tonic::Request::new(req_msg);
    let mut client = connect().await;
    let response = client.create(request).await?;

    println!("RESPONSE={:?}", response);
    Ok(())
}



#[tokio::test]
async fn test_create_device_instance() {
    create_device_instance().await.unwrap();
}