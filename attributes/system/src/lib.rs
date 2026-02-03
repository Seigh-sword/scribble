use std::env;
use std::fs;
use std::path::Path;
use std::process::Command;

#[no_mangle]
pub extern "C" fn system_getcwd() -> *const u8 {
    if let Ok(cwd) = env::current_dir() {
        if let Some(path_str) = cwd.to_str() {
            let boxed = Box::leak(path_str.to_string().into_boxed_str());
            return boxed.as_ptr();
        }
    }
    b"\0".as_ptr()
}

#[no_mangle]
pub extern "C" fn system_exists(path: *const u8) -> bool {
    if let Ok(path_str) = unsafe { std::ffi::CStr::from_ptr(path as *const i8).to_str() } {
        Path::new(path_str).exists()
    } else {
        false
    }
}

#[no_mangle]
pub extern "C" fn system_isfile(path: *const u8) -> bool {
    if let Ok(path_str) = unsafe { std::ffi::CStr::from_ptr(path as *const i8).to_str() } {
        Path::new(path_str).is_file()
    } else {
        false
    }
}

#[no_mangle]
pub extern "C" fn system_isdir(path: *const u8) -> bool {
    if let Ok(path_str) = unsafe { std::ffi::CStr::from_ptr(path as *const i8).to_str() } {
        Path::new(path_str).is_dir()
    } else {
        false
    }
}

#[no_mangle]
pub extern "C" fn system_mkdir(path: *const u8) -> bool {
    if let Ok(path_str) = unsafe { std::ffi::CStr::from_ptr(path as *const i8).to_str() } {
        fs::create_dir_all(path_str).is_ok()
    } else {
        false
    }
}

#[no_mangle]
pub extern "C" fn system_remove(path: *const u8) -> bool {
    if let Ok(path_str) = unsafe { std::ffi::CStr::from_ptr(path as *const i8).to_str() } {
        fs::remove_file(path_str).is_ok()
    } else {
        false
    }
}

#[no_mangle]
pub extern "C" fn system_rmdir(path: *const u8) -> bool {
    if let Ok(path_str) = unsafe { std::ffi::CStr::from_ptr(path as *const i8).to_str() } {
        fs::remove_dir_all(path_str).is_ok()
    } else {
        false
    }
}

#[no_mangle]
pub extern "C" fn system_getenv(name: *const u8) -> *const u8 {
    if let Ok(name_str) = unsafe { std::ffi::CStr::from_ptr(name as *const i8).to_str() } {
        if let Ok(value) = env::var(name_str) {
            let boxed = Box::leak(value.into_boxed_str());
            return boxed.as_ptr();
        }
    }
    b"\0".as_ptr()
}

#[no_mangle]
pub extern "C" fn system_setenv(name: *const u8, value: *const u8) -> bool {
    if let (Ok(name_str), Ok(value_str)) = (
        unsafe { std::ffi::CStr::from_ptr(name as *const i8).to_str() },
        unsafe { std::ffi::CStr::from_ptr(value as *const i8).to_str() },
    ) {
        env::set_var(name_str, value_str);
        true
    } else {
        false
    }
}

#[no_mangle]
pub extern "C" fn system_execute(cmd: *const u8) -> i32 {
    if let Ok(cmd_str) = unsafe { std::ffi::CStr::from_ptr(cmd as *const i8).to_str() } {
        match Command::new("sh").arg("-c").arg(cmd_str).status() {
            Ok(status) => status.code().unwrap_or(-1),
            Err(_) => -1,
        }
    } else {
        -1
    }
}

#[no_mangle]
pub extern "C" fn system_hostname() -> *const u8 {
    use std::process::Command;
    match Command::new("hostname").output() {
        Ok(output) => {
            if let Ok(s) = String::from_utf8(output.stdout) {
                let hostname = s.trim().to_string();
                let boxed = Box::leak(hostname.into_boxed_str());
                return boxed.as_ptr();
            }
        }
        Err(_) => {}
    }
    b"unknown\0".as_ptr()
}

#[no_mangle]
pub extern "C" fn system_platform() -> *const u8 {
    let platform = env::consts::OS;
    let boxed = Box::leak(platform.to_string().into_boxed_str());
    boxed.as_ptr()
}
