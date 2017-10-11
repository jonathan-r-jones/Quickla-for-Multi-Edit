prototype Clif
{
  int  @anatomize_clif(int desired_action, str &fp);
  void @edit_file_remotely();
  void @edit_file_under_cursor();
  void @find_backwards(str args);
  int  @folder_exists(str path);
  str  @get_line();
  str  @get_path_using_lw();
  str  @get_remote_oj_using_klc(str lc, int &lc_Is_Found);
  str  @get_subject_or_selected_text();
  int  @is_paste_before_in_same_window();
  void @load_my_macros_into_memory_1(); //(skw qkq) Remove from production Clif.
  int  @open_folder(str path);
  void @open_folder_remotely();
  void @repeat_command();
  void @set_clipboard(str stringToSet);
  int  @run_clif_under_cursor(str &operation_outcome);
  void @run_clif_internally(str lc);
}