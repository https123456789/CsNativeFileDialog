use std::process::Command;

fn main() {
    csbindgen::Builder::default()
        .input_extern_file("src/lib.rs")
        .input_extern_file("src/unix.rs")
        .csharp_dll_name("native_file_dialog")
        .csharp_class_accessibility("public")
        .csharp_class_name("FileDialog")
        .csharp_namespace("CsNativeFileDialog")
        .csharp_use_function_pointer(false)
        .generate_csharp_file("../CsNativeFileDialog/Runtime/Generated/NativeMethods.g.cs")
        .unwrap();

    // TODO: add windows support
    if !cfg!(target_os = "windows") {
        Command::new("sed")
            .args(["-i", "-e", "s/byte\\* pick_file/PathHandle pick_file/", "../CsNativeFileDialog/Generated/NativeMethods.g.cs"])
            .output()
            .expect("Failed to execute process");
    }
}
