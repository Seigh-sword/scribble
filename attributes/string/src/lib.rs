#[no_mangle]
pub extern "C" fn string_length(s: *const u8) -> i32 {
    if let Ok(s_str) = unsafe { std::ffi::CStr::from_ptr(s as *const i8).to_str() } {
        s_str.len() as i32
    } else {
        0
    }
}

#[no_mangle]
pub extern "C" fn string_upper(s: *const u8) -> *const u8 {
    if let Ok(s_str) = unsafe { std::ffi::CStr::from_ptr(s as *const i8).to_str() } {
        let upper = s_str.to_uppercase();
        let boxed = Box::leak(upper.into_boxed_str());
        return boxed.as_ptr();
    }
    b"\0".as_ptr()
}

#[no_mangle]
pub extern "C" fn string_lower(s: *const u8) -> *const u8 {
    if let Ok(s_str) = unsafe { std::ffi::CStr::from_ptr(s as *const i8).to_str() } {
        let lower = s_str.to_lowercase();
        let boxed = Box::leak(lower.into_boxed_str());
        return boxed.as_ptr();
    }
    b"\0".as_ptr()
}

#[no_mangle]
pub extern "C" fn string_trim(s: *const u8) -> *const u8 {
    if let Ok(s_str) = unsafe { std::ffi::CStr::from_ptr(s as *const i8).to_str() } {
        let trimmed = s_str.trim();
        let boxed = Box::leak(trimmed.to_string().into_boxed_str());
        return boxed.as_ptr();
    }
    b"\0".as_ptr()
}

#[no_mangle]
pub extern "C" fn string_contains(s: *const u8, substr: *const u8) -> bool {
    if let (Ok(s_str), Ok(sub_str)) = (
        unsafe { std::ffi::CStr::from_ptr(s as *const i8).to_str() },
        unsafe { std::ffi::CStr::from_ptr(substr as *const i8).to_str() },
    ) {
        s_str.contains(sub_str)
    } else {
        false
    }
}

#[no_mangle]
pub extern "C" fn string_startswith(s: *const u8, prefix: *const u8) -> bool {
    if let (Ok(s_str), Ok(pre_str)) = (
        unsafe { std::ffi::CStr::from_ptr(s as *const i8).to_str() },
        unsafe { std::ffi::CStr::from_ptr(prefix as *const i8).to_str() },
    ) {
        s_str.starts_with(pre_str)
    } else {
        false
    }
}

#[no_mangle]
pub extern "C" fn string_endswith(s: *const u8, suffix: *const u8) -> bool {
    if let (Ok(s_str), Ok(suf_str)) = (
        unsafe { std::ffi::CStr::from_ptr(s as *const i8).to_str() },
        unsafe { std::ffi::CStr::from_ptr(suffix as *const i8).to_str() },
    ) {
        s_str.ends_with(suf_str)
    } else {
        false
    }
}

#[no_mangle]
pub extern "C" fn string_replace(s: *const u8, old: *const u8, new: *const u8) -> *const u8 {
    if let (Ok(s_str), Ok(old_str), Ok(new_str)) = (
        unsafe { std::ffi::CStr::from_ptr(s as *const i8).to_str() },
        unsafe { std::ffi::CStr::from_ptr(old as *const i8).to_str() },
        unsafe { std::ffi::CStr::from_ptr(new as *const i8).to_str() },
    ) {
        let replaced = s_str.replace(old_str, new_str);
        let boxed = Box::leak(replaced.into_boxed_str());
        return boxed.as_ptr();
    }
    b"\0".as_ptr()
}

#[no_mangle]
pub extern "C" fn string_index(s: *const u8, substr: *const u8) -> i32 {
    if let (Ok(s_str), Ok(sub_str)) = (
        unsafe { std::ffi::CStr::from_ptr(s as *const i8).to_str() },
        unsafe { std::ffi::CStr::from_ptr(substr as *const i8).to_str() },
    ) {
        if let Some(idx) = s_str.find(sub_str) {
            return idx as i32;
        }
    }
    -1
}

#[no_mangle]
pub extern "C" fn string_reverse(s: *const u8) -> *const u8 {
    if let Ok(s_str) = unsafe { std::ffi::CStr::from_ptr(s as *const i8).to_str() } {
        let reversed: String = s_str.chars().rev().collect();
        let boxed = Box::leak(reversed.into_boxed_str());
        return boxed.as_ptr();
    }
    b"\0".as_ptr()
}

#[no_mangle]
pub extern "C" fn string_repeat(s: *const u8, count: i32) -> *const u8 {
    if let Ok(s_str) = unsafe { std::ffi::CStr::from_ptr(s as *const i8).to_str() } {
        let repeated = s_str.repeat(count.max(0) as usize);
        let boxed = Box::leak(repeated.into_boxed_str());
        return boxed.as_ptr();
    }
    b"\0".as_ptr()
}

#[no_mangle]
pub extern "C" fn string_tonum(s: *const u8) -> f64 {
    if let Ok(s_str) = unsafe { std::ffi::CStr::from_ptr(s as *const i8).to_str() } {
        if let Ok(num) = s_str.parse::<f64>() {
            return num;
        }
    }
    0.0
}

#[no_mangle]
pub extern "C" fn string_fromnum(n: f64) -> *const u8 {
    let s = n.to_string();
    let boxed = Box::leak(s.into_boxed_str());
    boxed.as_ptr()
}
