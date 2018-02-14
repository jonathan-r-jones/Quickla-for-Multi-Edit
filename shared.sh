prototype Shared
{
  void @add_text_blank_url_here();
  void @add_text_date();
  int  @at_bof();
  int  @at_bol();
  void @backspace();
  void @bof();
  void @bol();
  void @center_line();
  void @clear_highlighted_text();
  void @close_and_save_file_wo_prompt();
  void @close_window();
  str  @commute_character(str string, str old_character, str new_character);
  str  @commute_common_characters(str sc);
  str  @concatenate_multiple_lines();
  str  @constant_function_aborted();
  str  @constant_lc_not_found();
  str  @constant_not_a_bullet();
  int  @contains(str source, str sc);
  void @copy();
  void @copy_and_paste_line();
  void @copy_with_marking_left_on();
  void @create_invisible_file();
  void @create_new_file();
  void @create_reusable_temporary_file();
  void @create_new_long_line_file();
  void @create_timestamped_file();
  void @create_work_documents_file(str filename);
  void @cursor_up_1_line();
  void @cut();
  void @delete_word_conservatively();
  str  @equate_spaces_and_dashes(str sc);
  str  @equate_spaces_and_dashes_wcl(str sc);
  str  @escape_slashes(str sc);
  void @delete_line();
  void @delete_word_backwards();
  str  @distill_lc(str lc);
  void @eoc();
  void @eof();
  void @eol();
  void @eos();
  str  @equate_spaces_and_underscores(str space_filled_string);
  int  @file_is_read_only(str &introduction);
  void @footer();
  str  @get_current_line();
  str  @get_date();
  str  @get_date_and_time();
  str  @get_date_smas_format();
  str  @get_date_with_time();
  int  @get_eoc();
  str  @get_fixed_width_date();
  str  @get_fixed_width_time();
  str  @get_formatted_date();
  str  @get_formatted_date_as_fct_name();
  str  @get_formatted_time();
  str  @get_formatted_time_with_no_pm();
  str  @get_formatted_full_time();
  str  @get_multiline_object();
  str  @get_object();
  str  @get_postcomma_string(str string, str &em_rp);
  str  @get_precomma_string(str string, str &em_rp);
  str  @get_sj();
  int  @get_sj_cutoff_column();
  int  @get_sj_end_column(str line_parameter, int start_position);
  str  @get_subject();
  str  @get_subject_or_selected_text();
  str  @get_selected_text();
  str  @get_time();
  str  @get_user_input_raw(str introduction);
  str  @get_user_input_nonspace(str introduction);
  str  @get_uc();
  str  @get_wost();
  str  @highcopy_current_line();
  str  @highcopy_first_sentence();
  str  @highcopy_word_under_cursor();
  void @highlight_current_line();
  void @home();
  int  @i_am_on_my_home_computer();
  int  @int(str conversion_candidate);
  int  @is_batch_file();
  int  @is_blank_line();
  int  @is_bul_file();
  int  @is_bullet_file();
  int  @is_code_file();
  int  @is_code_indentation();
  int  @is_content_area_file();
  int  @is_number(str character);
  int  @is_rubric_file();
  int  @is_s_file();
  int  @is_sql_file();
  int  @is_text_file();
  int  @is_markup_file(str filename_Extension);
  int  @length(str string);
  void @load_highlighted_text();
  void @log(str text_to_write);
  str  @lower(str string);
  str  @lowercase(str string);
  void @multi_edit_paste();
  // (!sp) qq-1
  void @open_file(str filename);
  int  @open_file_with_writability();
  void @parse_arguments(str arguments, str separating_character, str &argument_1, str &argument_2);
  void @parse_arguments_4_parameters(str arguments, str separating_character, str &arg_1, str &arg_2, str &arg_3, str &arg_4);
  void @paste();
  void @paste_using_windows_clipboard();
  void @position_cursor_on_a_valid_word();
  int  @position_of_last_occurrence(str parameter, str character);
  int  @position_of_regex(str parameter);
  void @previous_window();
  void @restore_column();
  void @recall_location();
  void @restore_location();
  str  @remove_nonmeaningful_term_chars(str parameter);
  str  @replace(str original_String, str old_Characters, str new_Characters);
  str  @resolve_environment_variable(str command_line);
  void @run_application_1p(str application);
  void @run_application_2p(str application, str parameter);
  void @run_application_3p(str application, str parameter, int is_Windows_Explorer);
  void @save_highlighted_text();
  void @save_column();
  void @save_location();
  str  @second_character(str parameter);
  void @set_clipboard(str text_to_set);
  str  @strip_off_filename(str string);
  void @super_paste();
  void @surf(str uRL, int browser_Number);
  int  @switch_to_named_window(str name_of_Window);
  void @tof();
  str  @trim(str string);
  str  @trim_colon_et_al(str string);
  str  @trim_preobject_phrase(str string);
  str  @upper(str string);
  str  @upper_case(str string);
  int  @window_count();
}