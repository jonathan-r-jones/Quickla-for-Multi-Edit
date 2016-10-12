prototype Format
{
  void @add_colons();
  void @add_colon_before_every_nbl();
  void @add_commas_to_a_number(str &str_commas_added);
  str  @comment_characters();
  void @delete_blank_line_at_eof();
  void @delete_blank_lines();
  str  @delete_matching_lines(str sc);
  str  @delete_nonmatching_lines(str sc);
  void @delete_region_directives();
  str  @delete_space_at_bol();
  str  @delete_space_at_eol();
  void @drag_left();
  void @drag_left_wrapper();
  void @drag_right();
  void @drag_right_wrapper();
  void @format_file();
  int  @hard_format_long_lines_in_file();
  int  @replace_all_special_characters();
  void @replace_2_blank_lines_with_1();
  str  @replace_2_spaces_with_1();
  void @subdivide_long_line_wow_in_file();
}