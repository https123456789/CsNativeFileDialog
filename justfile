[private]
default:
    @just --list

lib:
    cd rust-lib && cargo build
    cp rust-lib/target/debug/libnative_file_dialog.so FileDialogDemo/bin/Debug/net8.0

build: lib
	cd CsNativeFileDialog && dotnet build
	cd FileDialogDemo && dotnet build

run: build
	dotnet run --project FileDialogDemo/FileDialogDemo.csproj
