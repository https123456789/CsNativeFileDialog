using CsNativeFileDialog;

public class Program {
    public static void Main() {
        unsafe {
            PathHandle path = FileDialog.pick_file();
            string s = path.AsString();
            path.Close();
            Console.WriteLine(s);
            // FileDialog.pick_file_free(path);
        }
    }
}
