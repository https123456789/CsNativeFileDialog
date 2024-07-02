set windows-shell := ["powershell.exe", "-c"]
target_os := os()
target_arch := arch()

[private]
default:
    @just --list

[private]
lib:
    cd rust-lib && cargo build

[doc("Build in normal mode. See unity-build for Unity support")]
build: lib
	cd CsNativeFileDialog && dotnet build

[doc("Build the project but following Unity conventions")]
unity-build assets-dir: lib
    mkdir -p {{assets-dir}}/Plugins/{{target_os}}/{{target_arch}}
    cp rust-lib/target/debug/libnative_file_dialog.so \
        {{assets-dir}}/Plugins/{{target_os}}/{{target_arch}}
