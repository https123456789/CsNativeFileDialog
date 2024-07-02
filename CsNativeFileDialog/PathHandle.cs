using System;
using System.Runtime.InteropServices;
using System.Text;

namespace CsNativeFileDialog {
    public class PathHandle: SafeHandle {
        public PathHandle():  base(IntPtr.Zero, true) {}

        public override bool IsInvalid {
            get { return this.handle == IntPtr.Zero; }
        }

        public string AsString() {
            int length = 0;
            while (Marshal.ReadByte(handle, length) != 0) {
                length++;
            }
            byte[] buffer = new byte[length];
            Marshal.Copy(handle, buffer, 0, buffer.Length);
            return Encoding.UTF8.GetString(buffer);
        }

        protected override bool ReleaseHandle() {
            if (!this.IsInvalid) {
                unsafe {
                    FileDialog.pick_file_free((byte*) this.handle);
                }
            }

            return true;
        }
    }
}
