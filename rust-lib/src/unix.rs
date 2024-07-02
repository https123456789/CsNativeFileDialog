use rfd::FileDialog;
use std::ffi::CString;
use std::os::unix::ffi::OsStrExt;
use libc::c_char;

#[no_mangle]
pub extern "C" fn pick_file() -> *mut c_char {
    let file = FileDialog::new().pick_file().unwrap_or_default();
    let os_string = file.into_os_string();
    let bytes = os_string.as_os_str().as_bytes();
    let cstring = CString::new(bytes).unwrap();
    cstring.into_raw()
}

#[no_mangle]
pub extern "C" fn pick_file_free(ptr: *mut c_char) {
    unsafe {
        if ptr.is_null() {
            return;
        }

        CString::from_raw(ptr);
    }
}
