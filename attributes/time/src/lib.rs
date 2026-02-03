use std::time::{SystemTime, UNIX_EPOCH};

#[no_mangle]
pub extern "C" fn time_now() -> f64 {
    SystemTime::now()
        .duration_since(UNIX_EPOCH)
        .unwrap_or_default()
        .as_secs_f64()
}

#[no_mangle]
pub extern "C" fn time_year() -> i32 {
    // Simplified: use standard library
    let secs = time_now() as u64;
    let days = secs / 86400;
    1970 + (days / 365) as i32
}

#[no_mangle]
pub extern "C" fn time_month() -> i32 {
    // Placeholder: 1-12
    ((time_now() / 2592000.0) as i32 % 12) + 1
}

#[no_mangle]
pub extern "C" fn time_day() -> i32 {
    ((time_now() / 86400.0) as i32 % 30) + 1
}

#[no_mangle]
pub extern "C" fn time_hour() -> i32 {
    ((time_now() as i32 / 3600) % 24)
}

#[no_mangle]
pub extern "C" fn time_minute() -> i32 {
    ((time_now() as i32 / 60) % 60)
}

#[no_mangle]
pub extern "C" fn time_second() -> i32 {
    (time_now() as i32 % 60)
}

#[no_mangle]
pub extern "C" fn time_weekday() -> i32 {
    // 0 = Monday, 6 = Sunday
    ((time_now() / 86400.0) as i32 + 3) % 7
}
