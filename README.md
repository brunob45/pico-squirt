# pico-squirt

Sandbox project for Raspberry Pi Pico

# Rust dependencies
- [Embedded Rust Book](https://docs.rust-embedded.org/book/interoperability/rust-with-c.html)
- [Tutorial](https://www.kevsrobots.com/learn/rust/11_rust_for_pico.html)

## Install Rust target
```console
$ rustup target add thumbv6m-none-eabi
```

## Create project
```console
$ cargo new your_crate --lib
```

```toml
[lib]
name = "your_crate"
crate-type = ["cdylib"]      # Creates dynamic lib
# crate-type = ["staticlib"] # Creates static lib
```

## Create library
```rust
#[no_mangle]
pub extern "C" fn rust_function() {
  ...
}
```

## Build project
```console
$ cargo build --release --target thumbv6m-none-eabi
```

## cbindgen
Generate C header file
