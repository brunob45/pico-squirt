#![no_std]
#![no_main]

use panic_halt as _;

#[no_mangle]
pub extern "C" fn add(left: cty::uint32_t, right: cty::uint32_t) -> cty::uint32_t {
    left + right
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn it_works() {
        let result = add(2, 2);
        assert_eq!(result, 4);
    }
}
