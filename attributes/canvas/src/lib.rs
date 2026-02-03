use std::ffi::c_void;

#[no_mangle]
pub extern "C" fn canvas_init(width: i32, height: i32, title: *const u8) -> bool {
    println!("[canvas] init {}x{}", width, height);
    true
}

#[no_mangle]
pub extern "C" fn canvas_close() {
    println!("[canvas] close");
}

#[no_mangle]
pub extern "C" fn canvas_clear(r: i32, g: i32, b: i32) {
    println!("[canvas] clear RGB({}, {}, {})", r, g, b);
}

#[no_mangle]
pub extern "C" fn canvas_flush() {
    println!("[canvas] flush");
}

#[no_mangle]
pub extern "C" fn canvas_line(x1: i32, y1: i32, x2: i32, y2: i32, r: i32, g: i32, b: i32) {
    println!("[canvas] line ({},{}) -> ({},{})", x1, y1, x2, y2);
}

#[no_mangle]
pub extern "C" fn canvas_rect(x: i32, y: i32, w: i32, h: i32, r: i32, g: i32, b: i32, fill: bool) {
    println!("[canvas] rect x={} y={} w={} h={} fill={}", x, y, w, h, fill);
}

#[no_mangle]
pub extern "C" fn canvas_circle(x: i32, y: i32, radius: i32, r: i32, g: i32, b: i32, fill: bool) {
    println!("[canvas] circle x={} y={} r={} fill={}", x, y, radius, fill);
}

#[no_mangle]
pub extern "C" fn canvas_polygon(points: *const i32, count: i32, r: i32, g: i32, b: i32, fill: bool) {
    println!("[canvas] polygon points={} fill={}", count, fill);
}

#[no_mangle]
pub extern "C" fn canvas_text(x: i32, y: i32, text: *const u8, size: i32, r: i32, g: i32, b: i32) {
    println!("[canvas] text at ({},{}) size={}", x, y, size);
}

#[no_mangle]
pub extern "C" fn canvas_image(x: i32, y: i32, path: *const u8) {
    println!("[canvas] image at ({},{})", x, y);
}

#[no_mangle]
pub extern "C" fn canvas_icon(x: i32, y: i32, icon_name: *const u8, size: i32) {
    println!("[canvas] icon at ({},{}) size={}", x, y, size);
}

#[no_mangle]
pub extern "C" fn canvas_key_pressed(key: *const u8) -> bool {
    false
}

#[no_mangle]
pub extern "C" fn canvas_mouse_x() -> i32 {
    0
}

#[no_mangle]
pub extern "C" fn canvas_mouse_y() -> i32 {
    0
}

#[no_mangle]
pub extern "C" fn canvas_mouse_button(button: i32) -> bool {
    false
}

#[no_mangle]
pub extern "C" fn canvas_set_stroke(width: f32, r: i32, g: i32, b: i32) {
    println!("[canvas] set_stroke width={}", width);
}

#[no_mangle]
pub extern "C" fn canvas_set_fill(r: i32, g: i32, b: i32) {
    println!("[canvas] set_fill RGB({}, {}, {})", r, g, b);
}

#[no_mangle]
pub extern "C" fn canvas_set_font(family: *const u8, size: i32, bold: bool, italic: bool) {
    println!("[canvas] set_font size={} bold={} italic={}", size, bold, italic);
}
