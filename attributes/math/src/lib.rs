use std::f64::consts::PI;

#[no_mangle]
pub extern "C" fn math_abs(x: f64) -> f64 {
    x.abs()
}

#[no_mangle]
pub extern "C" fn math_sqrt(x: f64) -> f64 {
    x.sqrt()
}

#[no_mangle]
pub extern "C" fn math_pow(base: f64, exp: f64) -> f64 {
    base.powf(exp)
}

#[no_mangle]
pub extern "C" fn math_floor(x: f64) -> i32 {
    x.floor() as i32
}

#[no_mangle]
pub extern "C" fn math_ceil(x: f64) -> i32 {
    x.ceil() as i32
}

#[no_mangle]
pub extern "C" fn math_round(x: f64) -> i32 {
    x.round() as i32
}

#[no_mangle]
pub extern "C" fn math_sin(x: f64) -> f64 {
    x.sin()
}

#[no_mangle]
pub extern "C" fn math_cos(x: f64) -> f64 {
    x.cos()
}

#[no_mangle]
pub extern "C" fn math_tan(x: f64) -> f64 {
    x.tan()
}

#[no_mangle]
pub extern "C" fn math_asin(x: f64) -> f64 {
    x.asin()
}

#[no_mangle]
pub extern "C" fn math_acos(x: f64) -> f64 {
    x.acos()
}

#[no_mangle]
pub extern "C" fn math_atan(x: f64) -> f64 {
    x.atan()
}

#[no_mangle]
pub extern "C" fn math_log(x: f64) -> f64 {
    x.ln()
}

#[no_mangle]
pub extern "C" fn math_log10(x: f64) -> f64 {
    x.log10()
}

#[no_mangle]
pub extern "C" fn math_exp(x: f64) -> f64 {
    x.exp()
}

#[no_mangle]
pub extern "C" fn math_random(min: i32, max: i32) -> i32 {
    use std::time::{SystemTime, UNIX_EPOCH};
    let nanos = SystemTime::now()
        .duration_since(UNIX_EPOCH)
        .unwrap_or_default()
        .subsec_nanos();
    let range = (max - min).max(1);
    min + (nanos as i32 % range)
}

#[no_mangle]
pub extern "C" fn math_random_float() -> f64 {
    use std::time::{SystemTime, UNIX_EPOCH};
    let nanos = SystemTime::now()
        .duration_since(UNIX_EPOCH)
        .unwrap_or_default()
        .subsec_nanos();
    (nanos as f64 % 1000000.0) / 1000000.0
}

#[no_mangle]
pub extern "C" fn math_min(a: f64, b: f64) -> f64 {
    a.min(b)
}

#[no_mangle]
pub extern "C" fn math_max(a: f64, b: f64) -> f64 {
    a.max(b)
}
