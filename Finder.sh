prototype Finder
{
  void @bobs();
  void @determine_if_lc_is_unique();
  int  @find_cmac_definition(str macro_Name, int is_exact_search);
  int  @find_continuum(int search_precision, str starting_position);
  void @find_from_here_ui();
  void @find_in_big_segment_header_uc(str sc);
  int  @find_lc(str lc);
  int  @find_lc_ui(str introduction);
  int  @find_lc_known(str &introduction, str lc);
  str  @find_lc_core(str lc, int &Search_Criterion_Was_Found, str introduction);
  str  @find_long_line();
  void @find_next_blank_line();
  str  @find_next_bullet();
  int  @find_next_long_line();
  void @find_rightmost_colon_on_curline();
  str  @find_special_character(str sc);
  str  @get_indicated_lc_2();
  str  @hc_word_uc();
  void @open_cmac_files();
//qq-1
  str  @replace(str original_String, str old_Characters, str new_Characters);
  str  @replace_all_occurrences_in_file(str character_to_Replace, str new_Character);
  str  @replace_all_occurrs_inf_one_tof(str character_to_Replace, str new_Character);
  str  @replace_next_occurrence_only(str sc, str replace_String_Regex);
  int  @replace_string_in_file_int(str old_String, str new_String);
  int  @replace_string_in_file_cs(str old_String, str new_String);
  int  @seek(str sc);
  int  @seek_from_bof(str sc);
  int  @seek_in_all_files_2_arguments(str sc, str &so);
  int  @seek_in_all_files_batch_files_o(str sc, str &so, str &fs);
  int  @seek_in_all_files_core(str sc, str &so, str &fs);
  void @seek_in_all_files_descriptive(str fp, str sc);
  void @seek_in_all_files_simplest(str sc);
  int  @seek_next(str sc, str &so);
  int  @seek_previous(str sC, str &sO);
  int  @seek_with_case_sensitivity(str sc, str &so);
  void @word_wrap();
  void @word_wrap_file();
  void @word_wrap_file_hard_core();
}