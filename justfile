serve target=("debug"): (build target)
    wasmtime serve target/server.wasm

build target=("debug"):
    @echo 'Building targeting {{ target }}'
    moon build --target wasm --{{ target }}
    wasm-tools component embed --encoding utf16 wit target/wasm/{{ target }}/build/http-server.wasm -o target/server.core.wasm
    wasm-tools component new target/server.core.wasm -o target/server.wasm

test:
    hurl --test test.hurl

clean:
    @echo 'Cleaning project'
    moon clean
