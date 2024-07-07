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

    // Correct the generated signature for `pick_file`
    let file_contents = std::fs::read_to_string("../CsNativeFileDialog/Runtime/Generated/NativeMethods.g.cs")
        .expect("The generated bindings file should be readable");
    let new_contents = file_contents.replacen("byte* pick_file(", "PathHandle pick_file(", 1);
    std::fs::write("../CsNativeFileDialog/Runtime/Generated/NativeMethods.g.cs", new_contents)
        .expect("The generated bindings file should be writable");
}
