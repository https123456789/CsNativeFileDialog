set windows-shell := ["powershell.exe", "-c"]
target_os := os()
target_arch := arch()

[private]
default:
    @just --list

[private]
[unix]
lib:
    cd rust-lib~ && cargo build

[private]
[windows]
lib:
    cd rust-lib~; if($?) {cargo build}

[doc("Build in normal mode. See unity-build for Unity support")]
[unix]
build: lib
	cd CsNativeFileDialog && dotnet build

[doc("Build in normal mode. See unity-build for Unity support")]
[windows]
build: lib
	cd CsNativeFileDialog; if($?) {dotnet build}

[doc("Build the project but following Unity conventions")]
[unix]
unity-build assets-dir: lib
    mkdir -p {{assets-dir}}/Plugins/{{target_os}}/{{target_arch}}
    cp rust-lib~/target/debug/libnative_file_dialog.so \
        {{assets-dir}}/Plugins/{{target_os}}/{{target_arch}}

[doc("Build the project but following Unity conventions")]
[windows]
unity-build assets-dir: lib
    New-Item -ItemType Directory -Force -Path {{assets-dir}}/Plugins/{{target_os}}/{{target_arch}}
    cp rust-lib~/target/debug/native_file_dialog.dll \
        {{assets-dir}}/Plugins/{{target_os}}/{{target_arch}}

[unix]
clean:
    cd rust-lib~ && cargo clean
    rm CsNativeFileDialog/Runtime/Generated -rf

[windows]
clean:
    cd rust-lib~; if($?) {cargo clean}
    del CsNativeFileDialog/Runtime/Generated
