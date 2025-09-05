# Hyper Hash — Pool

Stratum mining pool for Hyper Hash.  
Supports SV1 and SV2 miners with Hyper lanes for optimized hashing.

## Features
- SV1 & SV2 protocol lanes
- Hyper Hash optimizations
- Share validation & block submission
- Configurable pool fee (default 2%)
- Miner format: `<payoutAddress.worker>`

## Config Example
```toml
[bitcoind]
rpc_host = "127.0.0.1"
rpc_port = 8332
rpc_user = "user"
rpc_pass = "pass"

[pool]
fee_bps = 200
listen_sv1 = "0.0.0.0:3333"
listen_sv2 = "0.0.0.0:3335"
