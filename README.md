# HTTP Template

This is a project template for developing servers.

## Prerequisites

In addition to MoonBit toolchain, you will need:
- [wasm-tools](https://github.com/bytecodealliance/wasm-tools)
- [wasmtime](https://wasmtime.dev/)
- (Optional) [just](https://just.systems/)
- (Optional) [hurl](https://hurl.dev/)

## Get started

Execute `just serve` to have a running server listening at port 8080. Execute `just test` in another terminal to check the output.
Execute `just build release` to get a release build under `target/server.wasm`. 

- Modify the `top` function in `src/stub.mbt` to implement your CLI application.
- Modify the `serve` function if you need finer control on the event loop.