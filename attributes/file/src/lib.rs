use std::fs;
use std::io::{Read, Write};

#[no_mangle]
pub extern "C" fn file_read(path: *const u8) -> *const u8 {
    if let Ok(path_str) = unsafe { std::ffi::CStr::from_ptr(path as *const i8).to_str() } {
        if let Ok(mut content) = fs::read_to_string(path_str) {
            content.push('\0'); // Ensure C-string compatibility
            let boxed = Box::leak(content.into_boxed_str());
            return boxed.as_ptr();
        }
    }
    b"\0".as_ptr()
}

#[no_mangle]
pub extern "C" fn file_write(path: *const u8, content: *const u8) -> bool {
    if let (Ok(path_str), Ok(content_str)) = (
        unsafe { std::ffi::CStr::from_ptr(path as *const i8).to_str() },
        unsafe { std::ffi::CStr::from_ptr(content as *const i8).to_str() },
    ) {
        fs::write(path_str, content_str).is_ok()
    } else {
        false
    }
}

#[no_mangle]
pub extern "C" fn file_append(path: *const u8, content: *const u8) -> bool {
    if let (Ok(path_str), Ok(content_str)) = (
        unsafe { std::ffi::CStr::from_ptr(path as *const i8).to_str() },
        unsafe { std::ffi::CStr::from_ptr(content as *const i8).to_str() },
    ) {
        if let Ok(mut file) = fs::OpenOptions::new()
            .create(true)
            .append(true)
            .open(path_str)
        {
            return file.write_all(content_str.as_bytes()).is_ok();
        }
    }
    false
}

#[no_mangle]
pub extern "C" fn file_size(path: *const u8) -> i32 {
    if let Ok(path_str) = unsafe { std::ffi::CStr::from_ptr(path as *const i8).to_str() } {
        if let Ok(metadata) = fs::metadata(path_str) {
            return metadata.len() as i32;
        }
    }
    -1
}

#[no_mangle]
pub extern "C" fn file_delete(path: *const u8) -> bool {
    if let Ok(path_str) = unsafe { std::ffi::CStr::from_ptr(path as *const i8).to_str() } {
        fs::remove_file(path_str).is_ok()
    } else {
        false
    }
}

#[no_mangle]
pub extern "C" fn file_copy(src: *const u8, dst: *const u8) -> bool {
    if let (Ok(src_str), Ok(dst_str)) = (
        unsafe { std::ffi::CStr::from_ptr(src as *const i8).to_str() },
        unsafe { std::ffi::CStr::from_ptr(dst as *const i8).to_str() },
    ) {
        fs::copy(src_str, dst_str).is_ok()
    } else {
        false
    }
}

#[no_mangle]
pub extern "C" fn file_rename(old: *const u8, new: *const u8) -> bool {
    if let (Ok(old_str), Ok(new_str)) = (
        unsafe { std::ffi::CStr::from_ptr(old as *const i8).to_str() },
        unsafe { std::ffi::CStr::from_ptr(new as *const i8).to_str() },
    ) {
        fs::rename(old_str, new_str).is_ok()
    } else {
        false
    }
}
