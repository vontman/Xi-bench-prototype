
extern crate xi_core_lib;
extern crate xi_rpc;


use std::io;
use std::process;
use xi_core_lib::XiCore;
use xi_rpc::RpcLoop;

fn main() {

    let mut state = XiCore::new();
    let stdin = io::stdin();
    let stdout = io::stdout();
    let mut rpc_looper = RpcLoop::new(stdout);



    match rpc_looper.mainloop(|| stdin.lock(), &mut state) {
        Ok(_) => (),
        Err(err) => {
            println!("xi-core exited with error:\n{:?}", err);
            process::exit(1);
        }
    }
}
