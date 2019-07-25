//;;

void
@delete_colon()
{
str fp = "Subtract colon.";

// lu: Jul-18-2018

mark_pos;

@bol;

if(@first_2_characters(get_line) == '::')
{
  @delete_character;
  goto_mark;
  if(@current_column != 1)
  {
    left;
  }
}
else
{
  fp += ' Cannot delete the sole remaining colon.';
  goto_mark;
}

@say(fp);
}



//;

void
@rtm2
{
str fp = "x";

// lu: Jul-5-2019

str sc = '1way';
str distilled_lc = '1waytest';
distilled_lc = @replace(distilled_lc, sc, '');
//qq-1

@say(distilled_lc);
}



//;

void
@rtm
{
str fp = "x";

// lu: Jul-5-2019

str sc = '1way.+,';
str distilled_lc;
str remote_lc_partner;

@bol;

if(find_text(sc, 2, _regexp))
{
  distilled_lc = @distill_lc(found_str);
  remote_lc_partner = @replace(distilled_lc, '1way', '');
}

goto_mark;

@say(distilled_lc);
}



//;;

str
@get_formatted_date_as_fct_na_th
{
str fp = "Test harness.";

str function_name = @get_formatted_date();
function_name = @commute_character(function_name, "-", "");

@say(function_name);
return(function_name);
}



//;

str
@modify_lc_based_on_computername(str lc = parse_str('/1=', mparm_str))
{
str fp = "Modify lc based on what computer you are working on.";

// lu: Dec-30-2018

switch(@first_4_characters(get_environment("computername")))
{
  case "LIPT":
    lc = "gfe" + lc;
    break;
}

@say(fp);
return(lc);
}



//;

void
@close_and_save_file_goto_task()
{
str fp = "Close and save the file, then go to task location.";
@header;
save_file;
Delete_Window;
@footer;
@say(fp);
}



//;

void
@open_pretty_sett_file_l1
{
@open_pretty_sett_file;
@open_file('c:\a\j');
@tof;
@replace_semicolons_with_crs;
@tof;
@seek('^PATH=');
@bol;
cr;
@tof;
}



//;;

void
@@ff_here_ui
{
@header;
@ff_here_ui;
@footer;
}



//;;

void
@ff_lc_ui
{
str fp = 'Begin a search from a particular user inputted launch code.';
@header;

str lc = @get_user_input_nonspace('Search from launch code.');

if((lc == 'Function aborted.'))
{
  @say(lc);
  return();
}

@header;

int search_criterion_was_found;
str so = @find_lc_core(lc, search_criterion_was_found, fp);

if(search_criterion_was_found)
{
  @find_continuum(9, '');
}

@footer;
@say(fp + ' ' + so);
}



//;;

void
@ff_lc_known(str lc = parse_str('/1=', mparm_str), 
  str sc = parse_str('/2=', mparm_str))
{
str fp = 'Find from known launch code.';

if(!@find_lc_known(fp, lc)) 
{
  return();
}

if(sc == '')
{
  sc = @craft_search_string(9);
}

str so;
int rv = @seek_in_all_files_2_arguments(sc, so);

@say(fp + ' ' + so);
}



//;;

void
@ff_lc_sj(str lc = parse_str('/1=', mparm_str))
{
str fp = 'Begin a search on the sj from a particular user inputted launch code.';

str sc = @get_subject;

set_global_str('search_str', sc);

@header;

int search_criterion_was_found;
str so = @find_lc_core(lc, search_criterion_was_found, fp);

if(search_criterion_was_found)
{
  @find_continuum(12, '');
}

@say(fp + ' ' + so);
}



//;;

void
@ff_lc_arguments(str lc = parse_str('/1=', mparm_str))
{
str fp = 'Search from lc with reserved word sc.';

// Sample Usage: f.al.sj
// If the second parameter is left blank, the subject is used by default.

str sc = @get_sj;

@find_lc(lc);

// I commented this out on Aug-30-2017 because it couldn't search "and time" correctly.
//sc = @equate_spaces_and_dashes_wcl(sc);
sc = make_literal_x(sc);

@seek_in_all_files_2_arguments(sc, fp);

@say(fp + ' (' + sc + ')');
}



//;

void
@ff_lc_with_cascade_search(str lc = parse_str('/1=', mparm_str))
{
str fp = 'Find from lc with cascade search 2.';

// lu: Aug-1-2018

str sc = @get_sj;

@find_lc(lc);

@cascade_search_2(sc);

//@say(fp);
}



//;; (skw find_from_here_backwards) This functions seems to work. - JJ Sep-19-2008

void
@find_backwards_from_here_ui
{

str fp = 'Search BACKWARDS from here using user input in this file only.';
@header;

str sc = @get_user_input_raw(fp);

if((sc == "Function aborted."))
{
  @say(sc);
  return();
}

mark_pos;

sc = @equate_spaces_and_dashes_wcl(sc);

set_global_str('search_str', sc);

if(find_text(sc, 0, _regexp | _backward))
{
  pop_mark;
  fp = 'Found in this file.';
}
else
{
  goto_mark;
  fp = "NOT found in this file.";
}

@footer;
@say(fp);
}



//;;

void
@find_again_backwards_from_eof
{
//qjq-1
str fp = 'Find again backwards from eof.';
@header;

@eof;
if(!find_text(global_str('search_str'), 0, _regexp | _backward))
{
  fp += ' NOT found. May be first occurrence in file. (' + global_str('search_str') + ')';
  down;
}

@footer;
@say(fp);
}



//; (!2mum2)

void
@find_backwards(str arguments = parse_str('/1=', mparm_str))
{
//qjq-1
str fp = "Find backwards wost at lc.";

@header;

// fcd: Sep-21-2016

str first_parameter, second_parameter;

@parse_arguments(arguments, ".", first_parameter, second_parameter);

str lc = first_parameter; // location here (default) versus remote

str sc;

str option = second_parameter;

if(option == 'u')
{
  sc = @get_user_input_raw(fp);
}
else
{
  sc = second_parameter;
  //  sc = @get_wost; // default, a. k. a. nothing
}

if(lc == '')
{
  up;  // default, a. k. a. from here
}
else if (lc == 'rfeof')
{
  @eof;
}
else
{
  @find_lc(lc);
}

set_global_str('search_str', sc);

if(find_text(sc, 0, _regexp | _backward))
{
  fp += ' Found: ' + found_str + '.';
  right;
}
else
{
   fp += ' "' + sc + '"' + ' NOT found in this file. ';
}

@footer;

@say(fp);
}



//;

void
@rtm
{
str fp = "x";

// lu: Mar-12-2019

@say(fp);
}



//;

void
@delete_file_remotely
{
str fp = 'Delete file remotely.';
@header;

@save_location;

if(!@find_lc_ui(fp))
{
  @footer;
  return();
}

@delete_file;

@restore_location;

@footer;
@say(fp);
}



//;

void
@open_t_bat_with_new_function
{
str fp = 'Open t.bat file with a new function added.';
@header;
@open_file(get_environment('savannah') + '\belfry\t.bat');
@add_batch_file_stub_generic;
@footer;
}



//;

void
@go_to_a_specific_path_in_a_cpw(str initial_folder = parse_str('/1=', mparm_str))
{
str fp = 'Go to a specific path in a command prompt window.';

str Command_String = 'c:\windows\system32\cmd.exe /k ';
str Set_My_Path = "%savannah%\\belfry\\set_my_path_2.bat";
Set_My_Path = char(34) + @resolve_environment_variable(Set_My_Path) + char(34);
Command_String += Set_My_Path;

ExecProg(
  Command_String, 
  initial_folder, 
  '', 
  '', 
  _EP_FLAGS_EXEWIN | 
  _EP_Flags_NoBypass);

@say(fp);
}



//;

void
@delete_file()
{

str fp = 'Open folder under cursor in a command prompt.';
str Command_String = 'c:\windows\system32\cmd.exe /k ';
str Set_My_Path = "%savannah%\\belfry\\set_my_path_2.bat";
Set_My_Path = char(34) + @resolve_environment_variable(Set_My_Path) + char(34);

Command_String += Set_My_Path; //qcq

str Clif_Block = @concatenate_multiple_lines;
Clif_Block = @trim_leading_colons_et_al(Clif_Block);

If(!xpos('http', Clif_Block, 1))
{
  Clif_Block = @resolve_environment_variable(Clif_Block);
}

if(!xpos(char(92), Clif_Block, 1))
{
  @say("No folder seems to be present, so let's go look for one.");
  @save_location;
  if(@find_lc_ui(fp))
  {
    Clif_Block = @concatenate_multiple_lines;
    Clif_Block = @trim_leading_colons_et_al(Clif_Block);
    If(!xpos('http', Clif_Block, 1))
    {
      Clif_Block = @resolve_environment_variable(Clif_Block);
    }
    @restore_location;
  }
  else
  {
    return();
  }
}

// Character 92 is the backslash.
fp = 'Open a folder in the file system.';

// Now we need to strip out the filename, if it is there.
if(@fourth_to_last_character(Clif_Block) == '.')
{
  int Column_Number = length(Clif_Block);

  while(Column_Number)
  {
    if(str_char(Clif_Block, Column_Number) == '\')
    {
      Clif_Block = str_del(Clif_Block, Column_Number, length(Clif_Block));
      break;
    }
    Column_Number--;
  }
}

int Position_of_Last_Colon = 0;

if(xpos(char(92) + char(92), Clif_Block, 1)) // Network Locations ************************
{
  Position_of_Last_Colon = @position_of_last_occurrence(Clif_Block, ':') + 1;
  fp += ' Network folder.';
  Clif_Block = str_del(Clif_Block, 1, Position_of_Last_Colon);
}
else // Local File Locations, e.g. C and E drives. ****************************************
{
  Position_of_Last_Colon = @position_of_last_occurrence(Clif_Block, ':');
  Clif_Block = str_del(Clif_Block, 1, Position_of_Last_Colon - 2);
  fp += ' Local folder.';
}

Change_Dir(Clif_Block);

if (Error_Level != 0)
{
  fp += ' NOT found (Site 5).';
  Error_Level = 0;
  @say(fp + ' - ' + Clif_Block);
  @footer;
  return();
}

fp += ' ' + Clif_Block;

ExecProg(Command_String,
  Clif_Block,
  Get_Environment("TEMP") + '\\multi-edit output.txt',
  Get_Environment("TEMP") + '\\multi-edit error.txt',
  _EP_FLAGS_DONTWAIT | _EP_FLAGS_EXEWIN);

}



//;

void
@move_bullet_down_3_bullets
{
str fp = "Move bullet down 3 bullets.";
@header;

// fcd: Feb-11-2015

@save_location;

@cut_bullet;
@find_next_bullet;
@find_next_bullet;
@find_next_bullet;
@bol;
@paste;

@restore_location;

@footer;
@say(fp);
}



//;

void
@move_bullet_to_lc
{
str fp = "Move bullet to lc.";
@header;

// lu: Nov-12-2018

str user_input = @get_user_input_nonspace(fp);

if((user_input == "Function aborted."))
{
  @say(user_input);
  return();
}

@run_bullet_action_model_2(user_input);

@footer;
@say(fp + ' (' + user_input + ')');
}



//;

void
@open_text_message_to_phone
{
str fp = "Run message to phone macro.";

str filename[128] = Get_Environment('savannah') + '\reach out\text message to phone.txt';

@open_file(filename);

rm('block^selectall');

delete_block;

@paste;

@bof;

while(@current_character == ':')
{
  @delete_character;
}

@delete_carriage_return_char_su;

@say(fp);
}



//;;

void
@@bobsr
{
@header;
@bobsr;
@footer;
}



//;; Deprecated: Please use "@find_previous_bobs" or "@boca" going forward.

str
@bobsr()
{
str fp = 'Go to the beginning of the current bullet, subbullet or rubric.';

str current_bsr_type = '';

while(current_bsr_type == '')
{
  switch(@first_character(get_line))
  {
    case ';':
      current_bsr_type = 'rubric';
      break;
    case '/':
      if(@is_bullet_file)
      {
        break;
      }
      @bol;
      right;
      right;
      if(@current_character == ';')
      {
        current_bsr_type = 'rubric';
      }
      break;
    case '-':
      @bol;
      right;
      right;
      if(@current_character == ';')
      {
        current_bsr_type = 'rubric';
      }
      break;
    case ':':
      current_bsr_type = 'bullet';
      if(@second_character(get_line) == ':')
      {
        current_bsr_type = 'subbullet';
      }
      // For batch file rubrics.
      if(@second_character(get_line) == '_')
      {
        switch(lower(get_extension(file_name)))
        {
          case 'bat':
            current_bsr_type = 'rubric';
        }
      }
      break;
  }
  if(current_bsr_type == '')
  {
    up;
  }
}
@bol;

return(Current_BSR_Type);
}



//;;

void
@move_down_old()
{
str fp = 'Move down.';

int initial_column = @current_column;

if(!@is_structured_line)
{
  @move_line_down;
  return();
}

int is_last_rubric_element = false;
str query_next_area;

str initial_area_type = @current_area_type;

switch(initial_area_type)
{
  case 'bullet':
    fp = 'Move bullet down.';
    if(@query_next_br == 'rubric')
    {
      is_last_rubric_element = true;
    }
    @cut_bullet;
    break;
  case 'subbullet':
    fp = 'Move subbullet down.';
    if(@Query_Next_BSR == 'rubric')
    {
      is_last_rubric_element = true;
    }
    @cut_subbullet;
    break;
  case 'rubric':
    @move_rubric_down;
    return();
  case 'subrubric':
    @move_subrubric_down;
    return();
  default:
    @say('This macro only works with bullets or subbullets.');
    @footer;
    return();
}

switch(initial_area_type)
{
  case 'bullet':
    query_next_area = @find_next_bobs;
    break;
  case 'subbullet':
    query_next_area = @find_next_bsr;
    break;
}

if(Is_Last_Rubric_Element)
{
  // Don't cross the rubric because you're not the last element, that is,
  // you are the penultimate element. This if/else block handle crossing rubrics.
  query_next_area = @find_next_bsr;
  // This accounts for empty rubrics.
  if((query_next_area == 'rubric') || (query_next_area == 'subrubric'))
  {
    up;
    up;
  }
}
else if((query_next_area == 'rubric') || (query_next_area == 'subrubric') and (!is_last_rubric_element))
{ 
  up;
  up;
}

@bol;
@paste;

switch(initial_area_type)
{
  case 'bullet':
    up;
    @bob;
    break;
  case 'subbullet':
    @find_previous_subbullet;
    break;
}

goto_col(initial_column);

@say(fp);
}



//;

void
@move_bullet_to_comp_items()
{
str fp = "Move bullet to completed items.";

// lu: Aug-19-2018

mark_pos;

@cut_bullet;

str lc = 'co';
lc = @transform_a_string_into_an_lc(lc);

if(!@find_lc(lc))
{
  fp += ' LC NOT found!';
}

@paste_after;

goto_mark;

@say(fp + ' (' + @distill_lc(lc) + ')');
}



//;

void
@add_bullet_below_and_paste_ww
{
str fp = "Add bullet below and paste without wrapping.";

@header;

@add_bullet_below;
@paste;
@delete_line;
@bob;

@footer;

@say(fp);
}



//;

void
@cascade_search_2(str sc = parse_str('/1=', mparm_str))
{
str fp = "Cascade search 2.";

// lu: Aug-1-2018

int find_result = @find_continuum_2(sc, 'most_precise');

if((find_result == 0) or (find_result == 2))
{
  find_result = @find_continuum_2(sc, 'medium_precise');
}

if((find_result == 0) or (find_result == 2))
{
  find_result = @find_continuum_2(sc, 'least_precise');
}

if((find_result == 0) or (find_result == 2))
{
  @say('Sui generis.');
}

//@say(fp);
}



//;

void
@cursor_left_quickly
{
str fp = "Cursor left quickly.";
@header;

int i = 0;

while(i < 47)
{
  if(@current_column == 1)
  {
    break;
  }
  left;
  i++;
}

@footer;
@say(fp);
}



//;;

void
@cursor_right_quickly
{
str fp = "Cursor right quickly.";
@header;

int i = 0;

while(i < 47)
{
  right;
  i++;
}

if(at_eol)
{
  eol;
}

@footer;
@say(fp);
}



//;

void
@rtm
{
str fp = "Run last updated and close window.";

// This doesn't work but I can't figure out why not.

// lu: Jun-10-2018

@run_clif_internally('lu');
@switch_to_named_window('last updated.asc');
@close_and_save_file_wo_prompt;

@say(fp);
}



//;

void
@rm2
{
str fp = "";
fp = "Oct-31-2017";

// fcd: Sep-13-2017

fp = Get_Environment("Prompt") + "\\Mozilla Firefox\\firefox.exe";
fp = Get_Environment("ProgramFiles") + "\\Mozilla Firefox\\firefox.exe";

@say(fp);
}



//;

void
@rm3
{
str fp = "Remove extra echo statements.";

// lu: Nov-14-2017

str rs;
str sc;

@header;

tof;

sc = 'echo\.$echo';

@eol;

rs = 'echo';

@replace_all_occurrs_inf_one_tof(sc, rs);
return();
@replace_next_occurrence_only(sc, rs);
@seek(sc);
int is_found = @seek_in_all_files_2_arguments(sc, fp);

@footer;
@say(found_str);
@say(fp);
}



//;

void
@rm
{
str fp = "";
  fp = "Dec-5-2017 3:30 PM";
// lu: Dec-5-2017
str rs;
str sc;

@header;
sc = '^.+form.down';
@eol;
rs = 'form.down';

@replace_next_occurrence_only(sc, rs);
return();
@seek(sc);
@replace_all_occurrs_inf_one_tof(sc, rs);
int is_found = @seek_in_all_files_2_arguments(sc, fp);

@footer;
@say(found_str);
@say(fp);
}



//;

void
@rm
{
str fp = "";
fp = "Dec-4-2017 5:06 PM";

// lu: Dec-4-2017

str test = get_line;
@eol;
cr;
@bol;
text(test);
goto_col(@get_sj_cutoff_column);
str_block_begin;
@eol;
block_end;
@delete_block;
text('=');
@paste;

@say(fp);
}



//;

void
@rm5
{
str fp = "";
  fp = "Nov-21-2017 3:14 PM";
// lu: Nov-21-2017
str rs;
str sc;

@header;
sc = '^.# "';
sc = '".+$';
sc = '$^';
sc = "'";
sc = '$';
rs = "$                    submission_string += '";
rs = "'\\&";
rs = "=' + myForm.down('#').getValue();";
@eol;

@replace_next_occurrence_only(sc, rs);
down;
return();
@replace_all_occurrs_inf_one_tof(sc, rs);
int is_found = @seek_in_all_files_2_arguments(sc, fp);
@seek(sc);

@footer;
@say(found_str);
@say(fp);
}



//;;

void
@format_carriage_returnless_file()
{
str fp = 'Format a file to remove carriage returns.";
';

if(@current_character == ':')
{
  @delete_character;
}

@delete_carriage_returns;

@say(fp);
}



//;;

void
@search_google_and_append_cs(str sc = parse_str('/1=', mparm_str))
{
str fp = 'Search google and append C#.';
@search_google_main(0, 0, @get_sj + ' c#');
@say(fp);
}



//;;

void
@search_google_and_append_java(str sc = parse_str('/1=', mparm_str))
{
@search_google_main(0, 0, @get_sj + ' java');
}



//;;

void
@search_google_and_append_sencha(str sc = parse_str('/1=', mparm_str))
{
@search_google_main(0, 0, @get_sj + ' sencha');
}



//;;

void
@search_google_append_download(str sc = parse_str('/1=', mparm_str))
{
@search_google_main(0, 0, @get_sj + ' download');
}



//;;

void
@move_to_lastp_old(int return_home = parse_int('/1=', mparm_str))
{
str fp = "Move context object to last position.";

// fcd: Nov-18-2014

@header;

switch(lower(get_extension(File_name)))
{
  case 'bat':
    @bor;
    @cut_rubric;
    eof;
    @bol;
    @paste;
    up;
    @bor;
    @footer;
    @say(fp);
    return();
    break;
  case 's':
    @bor;
    @cut_rubric;
    @eof;
    @bol;
    @paste;
    up;
    @bor;
    @footer;
    return();
    break;
  default:
    break;
}

if(!@is_bullet_file)
{
  if(return_home)
  {
    @move_line_to_lastp_alone;
  }
  else
  {
    @move_line_to_lastp_wme;
  }
}
else
{
  switch(@current_line_type)
  {
    case 'subbullet':
      if(return_home)
      {
        @move_subbullet_to_lastp_alone;
      }
      else
      {
        @move_subbullet_to_lastp_wme;
      }
      break;
    case 'bullet':
      if(return_home)
      {
        @@run_bullet_action_model('-4');
      }
      else
      {
        @@run_bullet_action_model('-4w');
      }
      break;
    case 'subrubric':
      if(return_home)
      {
        @move_subrubric_to_lastp_alone;
      }
      else
      {
        @move_subrubric_to_lastp_wme;
      }
      break;
    case 'rubric':
      if(return_home)
      {
        @move_rubric_to_lastp_alone;
      }
      else
      {
        @move_rubric_to_lastp_wme;
      }
      break;
  }
}
@footer;
}



//;

void
@copy_j1_into_j2
{
str fp = "Copy j1.txt into j2.txt.";

// fcd: "Mar-29-2017
@header;

@open_file('c:\a\j1.txt');
@select_all;
@copy;
@close_and_save_file_wo_prompt;

@open_file('c:\a\j2.txt');
@select_all;
delete_block;
@paste;
@bof;

@footer;
@say(fp);
}



//;

void
@words_with_friends_helper
{
str fp = "Words with Friends Word Finder.";
  fp = "Feb-18-2017 10:55 PM";
// fcd: Feb-18-2017

// Problem: Grammar should be unaccaptable because it has a double m.

str rs;
str sc;

@header;
sc = '[. .][armyhag][armyhag][armyhag][armyhag][armyhag][armyhag][armyhag][. .]';
@eol;

int is_found = @seek_in_all_files_2_arguments(sc, fp);

if(@contains(found_str, 'mm'))
{
  @seek_in_all_files_2_arguments(sc, fp);
}
@footer;
return();
@seek(sc);
@replace_next_occurrence_only(sc, rs);
@replace_all_occurrs_inf_no_tof(sc, rs);

rs = '\0';
@say(found_str);
@say(fp);
}



//;

void
@add_text_close_bracket
{
str fp = 'Add text close bracket.';
text(']');
}



//;

void
@search_google_images_exactly(str parameter = parse_str('/1=', mparm_str))
{

str fp = 'Search Google images using and exact phrase.';

// fcd: Apr-17-2017

str URL = 'https://play.google.com/store/search?q=';

str sc = parameter;

if(sc == '')
{
  sc = @get_subject_or_selected_text;
}

str Pretty_sc = sc;
sc = @commute_character(sc, ' ', '+');

URL += sc;
URL += '&num=35&lr=&hl=en&source=lnms&tbm=isch&sa=X&ved=0ahUKEwiQ8qm3j6zTAhVD_WMKHVh1B9IQ_AUICCgB&biw=1415&bih=700';

@surf(URL, 0);

/* Use Cases

Server Beacon

*/

@say(@trim_period(fp) + ' for "' + pretty_sc + '".');
}



//;

str
@space_close_bracket(str &regex_Description, str &rS)
{
str fp = 'Space close bracket.';
str sc = char(32) + '(\' + char(93) + ')';
rS = '\0';
regex_Description = fp;
return(sc);
}



//;;

void
@open_verizon_an_easier_way
{
str fp = "Open Deltek with cell number prepasted into buffer.";

str URL = 'http://www.verizonwireless.com/myverizon';

//@set_clipboard('');

@surf(URL, 0);

@say(fp);
}



//;

void
@open_deltek_an_easier_way
{
str fp = "Open Deltek an easier way.";

str URL = 'https://tcg9.hostedaccess.com/DeltekTC/welcome.msv';

//@set_clipboard('[Interplay goes here].');

@surf(URL, 1);

@say(fp);
}



//;

void
@open_japan_an_easier_way
{
str fp = "Open JP an easier way.";

str URL = 'http://mercury-jp.dreamhammer.com';

@set_clipboard('');

@surf(URL, 1);

@say(fp);
}



//;;

void
@open_outlook_an_easier_way
{
str fp = "Open Outlook with interplay prepasted into buffer.";
fp = "Open Outlook an easier way.";

str URL = 'https://outlook.office365.com/owa/?realm=nesassociates.com&exsvurl=1&ll-cc=1033&modurl=0&path=/mail/inbox';

@set_clipboard('DCCapsApril19');

@surf(URL, 3);

@footer;

}



//; (skw how to run a batch file from CMAC)

void
@synchronize()
{
str fp = "Synchronize my Savannah files in the background.";

str command_String = 'c:\windows\system32\cmd.exe /k';

str parameter = Get_Environment("savannah") + '\belfry\synchronize_layer_of_abstraction.bat';

@run_application_2p(command_String, parameter);

@say(fp);
}



//;;

void
@delete_lines(str sc = parse_str('/1=', mparm_str), int is_Matching_Line = parse_int('/2=', mparm_str))
{
str fp = 'Delete lines.';

/*
(skw 
beginning_with
delete certain lines
delete lines
delete lines beginning with
delete_line_containing 
delete_lines
delete_lines_b
delete_lines_containing
lines with
lines_beginning
lines_with
)
*/

if(!@is_text_file)
{
  return();
}

@header;

if(is_Matching_Line)
{
  fp = @delete_matching_lines(sc);
  //fp = 'branch 1. (' + str(is_matching_line) + ')';
}
else
{
  fp = @delete_nonmatching_lines(sc); 
  //fp = 'branch 2. (' + str(is_matching_line) + ')';
}

@footer;
//fp = sc;
//fp = str(is_Matching_Line);
@say(fp);
}



//;

void
@configure_file_delete_carrets
{
str fp = "Configure File - Delete Carriage Returns.";

str filename[128] = Get_Environment('savannah') + '\reach out\delete carriage returns.txt';

@open_file(filename);

rm('block^selectall');

delete_block;

@paste;

@bof;

while(@current_character == ':')
{
  @delete_character;
}

@format_carriage_returnless_file;

@say(fp);
}



//;

void
@find_batch_file_label()
{
str fp = "Find batch file label.";

eol;
str sc = ':' + @get_word_uc_or_st;
@seek_in_all_files_simplest(sc);

@say(fp);
}



//;;

void
@add_text_for_if_code_block
{
str fp = "Add text for 'if' code block.";

@header;

text("if()");
cr;
text("{");
cr;
cr;
text("}");
cr;
up;
up;
up;
up;
@eol;
left;

@footer;

@say(fp)
}



//;;

void
@add_text_sp_definitions
{
str fp = "Add text 'sp definitions'.";

@header;

@save_location;

str lc = "msob";
if(!@find_lc_known(fp, lc))
{
  return();
}

@eol;
cr;
cr;
text("exec sp_ms_marksystemobject '");
@paste;
@eol;
text("'");
cr;
text("go");

lc = "grex";
if(!@find_lc_known(fp, lc))
{
  return();
}

@eol;
cr;
cr;
text("grant execute on ");
@paste;
@eol;
text(" to public");
cr;
text("go");

@recall_location;

/* Use Case(s)


*/

@footer;
@say(fp);
}



//;;

void
@add_text_use_case
{
str fp = 'Add text use case.';
@header;

@bol;
cr;
cr;
up;
text('/* ');
text('Use Case(s)');
cr;
cr;
@add_text_use_case_bullet;
cr;
cr;
text('*/');
up;
up;
@bol;

@footer;
@say(fp);
}



//;;

void
@add_text_use_case_bullet()
{
str fp = 'Add text use case bullet.';

@bol;
text('2. Use Case on ' + @get_formatted_date + ':');
cr;

@say(fp);
}



//;;

void
@add_text_firefox
{
str fp = 'Add text Firefox.';

if(@text_is_selected)
{
  delete_block;
}

text('%programfiles%\mozilla firefox\firefox.exe ' + char(34));

@say(fp);
}



//;;

void
@add_text_multiedit()
{
str fp = 'Add text Multi-Edit.';

if(@text_is_selected)
{
  delete_block;
}

text('c:\Program Files (x86)\Multi-Edit 2008\Mew32.exe ' + char(34));
cr;

@say(fp);
}



//;;

void
@add_text_safari
{
str fp = 'Add text safari.';

if(@text_is_selected)
{
  delete_block;
}

text('%programfiles%\safari\safari.exe ' + char(34));

@say(fp);
}



//;;

void
@add_text_internet_explorer()
{
str fp = 'Add text internet explorer.';

if(@text_is_selected)
{
  delete_block;
}

// Note that it says %programfiles% and not "program files". This is because
// the first directs towards the 32-bit version of IE, which is for some reason required
// by the Windows Update site. - JRJ Jan-4-2011
text('%programfiles%\internet explorer\iexplore.exe ' + char(34));

@say(fp);
}



//;;

void
@add_text_skw
{
str fp = 'Add text skw.';
@add_text_at_eol('skw');
}



//;; (skw Universal_Window, Universal Window, Window Universal)

int
@switch_to_task_window()
{
str fp = 'Switch to task window.';
str Named_Window;

named_window = 'ne.asc';

if(@switch_to_named_window(Named_Window) == 0)
{
  Named_Window = 'ne.asc';
  @switch_to_named_window(Named_Window);
  @say('Tried to switch to ' + Named_Window + ', but could not find it.');
  return(0);
}

@cursor_to_my_bof;

@center_line;
@say(fp);
return(1);

}



//;;

void
@open_or_close_cmac_files
{
str fp = "Open or close CMAC files.";

@header;

// fcd: Aug-6-2015

if(@window_count > 13)
{
  fp += " Excess files are open, so close them.";
  @close_excess_windows;
}
else
{
  fp += " CMAC macros are closed so open them.";
  @open_cmac_files;
}

@footer;

@say(fp);
}



//;;

void
@replace_space_curly_brace()
{
str fp = "Replace space curly brace with newline curly brace.";

// fcd: Aug-29-2016

str rs;
str sc;
str so;
int efbo = true; // execute first block only

sc = ' {';
rs = '${';
@eol;

if(efbo){ so = @replace_all_occurrences_no_tof(sc, rs); efbo = 0; }
if(efbo){ so = @replace_next_occurrence_only(sc, rs); efbo = 0; }
if(efbo){ @seek_next(sc, so); efbo = false; }
if(efbo){ int is_found = @seek_in_all_files_2_arguments(sc, fp); efbo = 0; }

@say(found_str);
@say(so);
@say(fp);
}



//;

str
@peek_ahead_2()
{
str fp = 'Looks for bullets, subbullets and rubrics.';

str return_string = 'rubric';

mark_pos;

if((Cur_Char == ':') or (Cur_Char == ';') or (Cur_Char == '/'))
{
  right;
}

find_text('()||(^;)||(^//;)', 0, _regexp);
str First_Character = Copy(found_str, 1, 1);
str Second_Character = Copy(get_line, 2, 1);
if(First_Character == ':')
{
  Return_String = 'bullet';
}
if(Second_Character == ':')
{
  Return_String = 'subbullet';
}

goto_mark;

@say(fp);
return(Return_String);
// return(found_str);
}



//;

void
@rtm
{
str fp = "";
str rs;
str sc;
str so;
int efbo = true; // execute first block only

@header;
down;
sc = '^ÃÄÄÄ.*$ÃÄÄÄ';
sc = 'ÃÄÄÄtest';
sc = '^ÃÄÄÄ.+$';
sc = '(^À)||(^Ä)';
sc = '^À';
sc = '^Ã||^À';
sc = '^(Ã)||(À).+$(À)';
sc = '^(Ã)||(À).+$((Ã)||(À))';
rs = '\0';
@eol;

if(efbo){ @seek_next(sc, so); efbo = false; }
if(efbo){ so = @replace_next_occurrence_only(sc, rs); efbo = 0; }
if(efbo){ so = @replace_all_occurrences_no_tof(sc, rs); efbo = 0; }
if(efbo){ int is_found = @seek_in_all_files_2_arguments(sc, fp); efbo = 0; }

@footer;
@say(found_str);
@say(so);
@say(fp);
}



//;

void
@go_to_my_weekly_schedule
{
str fp = "Go to my weekly schedule.";
@header;

// fcd: Jan-5-2016

@find_lc('refernow');
@find_next_bullet;

@footer;
@say(fp);
}



//;;

void
@@paste_without_wrapping
{
@header;
@paste_without_wrapping;
@footer;
}



//;;

void
@paste_without_wrapping()
{
str fp = "Paste without wrapping.";

if(!@is_bullet_file)
{
  return();
}

@eol;

cr;
cr;

//@save_location;

@create_timestamped_file;
//qjq-1

@paste;

@delete_space_at_bol;
@subdivide_long_line_wow_in_file;

str description;
str rs;
str sc = @read_more_answers_dot_com(description, rs);
@replace_next_occurrence_only(sc, rs);
@replace_2_blank_lines_with_1;
@replace_2_spaces_with_1;
@delete_blank_lines_near_eof;

// On Jun-25-2013, this was removing a necessary comma.
@replace_all_special_characters;

rm('Block^SelectAll');
@copy;
@close_and_save_file_wo_prompt;

//@recall_location;
//qjq-1

@paste;
@delete_line;

@boca;
eol;
@fix_fat_colon;

@boca;

@eoc;

@say(fp);
}



//;

void
@move_bullet_or_sub_to_workspace
{
str fp = "Move bullet or subbullet to the general workspace.";
@header;

// fcd: Mar-18-2016

int is_bullet = false;
int is_subbullet = false;

@save_location;

if(@is_bullet)
{
  @cut_bullet;
  is_bullet = true;
}
else if(@is_subbullet)
{
  @cut_subbullet;
  is_subbullet = true;
}
else
{
  fp += ' Must be a bullet or a subbullet.';
  @say(fp);
  return();
}

@find_lc('referj');

down;
down;
@bol;
@paste;

@find_lc('referk');

down;
down;
@bol;

right;
if(@current_character == ':')
{
  @delete_character;
}

@recall_location;

@footer;
@say(fp);
}



//;;

str
@read_more_answers_dot_com(str &regex_Description, str &rS)
{
str fp = "Read more answers dot come garabage addendum.";
str sc = '^$' + 'Read more: http://www.answers.com.+$';
regex_Description = fp;
rs = "";
return(sc);
}



//;

void
@move_rubric_to_last_updated_pos
{
str fp = "Move rubric to last updated position";

@header;

// fcd: Sep-1-2016

switch(@filename_extension)
{
  case "bat":
    @bor;
    @cut_big_segment;
    eof;
    @bor;
    @paste;
    @bor;
    break;
  default:
    //@say('This macro only works on bullet type files.');
}

@footer;
@say(fp);
}



//;

void
@find_from_focal_point
{
str fp = "Find from focal point.";

@header;
// fcd: Dec-9-2015
@find_lc('focal_point');
str so;
@seek_next('yyyy', so);

@footer;

@say(fp);
}



//;

void
@rtm
{
str fp = "Find Pcarss table.";
@header;

// fcd: Sep-15-2016

str sc = 'CREATE TABLE PCARSS.';
str so;

sc += @get_word_uc_or_st;

@save_location;

@find_lc('tomt');

if(!@seek_next(sc, so))
{
  fp += ' NOT found.';
  @recall_location;
}

@footer;
@say(fp + ' (' + sc + ')');
}



  if((@current_area_type == 'rubric') or (@current_area_type == 'subrubric'))
  {
    @find_next_bullet;
  }



//;

void
@add_text_bracket
{
str fp = 'Add bracket.';
text('[');
}



//;;

void
@add_rubric(str lc = parse_str('/1=', mparm_str))
{
@add_rubric_below(lc);
}



//;;

void
@format_mappings_file_member
{
str fp = "Format a line in the mappings file.";
@header;

@bol;
down;
@bol;
cr;
up;
up;
@word_wrap;

@footer;
@say(fp);
}



//;;

void
@format_report_header()
{
@format_report("");
@format_report(" _/)       _/)      _/)");
@format_report("~~~~~~~~~~~~~~~~~~~~~~~~");
}



//;;

void
@format_report(str text_to_write)
{
str fp = 'Append data to a report giving the outcome of format file.';

int Amount;
int Handle;

str Name_of_File = 'c:\!\Format Report.txt';

if(!File_Exists(Name_of_File))
{
  s_create_file(name_of_file, handle);
}

s_open_file(Name_of_File, 01, Handle);

s_move_file_ptr(Handle, 2, 0);

/*
s_move_file_ptr(Han, Mode, Of) integer function

Moves the file pointer in the file whose handle is Han by the amount Ofs. If Mode is 0, will
move from the start of the file, if 1, will move from present location, if 2, will move from
the end. Returns 0 if no error, otherwise, the Dos error code.

*/

S_Write_Bytes(LINE_TERMINATOR, Handle, Amount);
S_Write_Bytes(Text_to_Write, Handle, Amount);
S_Write_Bytes(LINE_TERMINATOR, Handle, Amount);
S_Close_File(Handle);

@say(fp);
}



//;

void
@format_mappings_file
{
str fp = "Format TMT Mappings file.";

if(@filename != 'tmtmappings.config')
{
  @say('This macro only works on the file "tmtmappings.config".');
  return();
}

@header;

@say(fp + ' Please wait . . . ');
//@delete_space_at_bol;
@delete_blank_lines;
// Word wrapping twice is intentional here. Apr-10-2012
//@word_wrap_file;
//@word_wrap_file;
@add_2_blank_lines_before_each_e();

@footer;
@say(fp + " Completed.");
}



//;;

void
@hc_bullet_content_dinc()
{
str fp = 'Highcopy bullet content do not INCLUDE first line.';

// Dependency Note: this macro requires that "Customize | Editing | Blocks | Persistent
// Blocks" be enabled.

refresh=false;

block_off;

if(@find_next_bobs != 'bullet')
{
  up;
  up;
  up;
}
@bol;
left;

str_block_begin;
@bob;
down;
down;

if(at_eol)
{
  down;
  down;
  @bol;
}

rm('CenterLn');
rm('CenterLn');

@copy_with_marking_left_on;

refresh=true;

@say(fp);
}



//;

void
@add_text_double_slash
{
str fp = 'Add double slash.';
text('/');
}



//;

void
@read_some_headlines
{
str fp = "Read some headlines.";

// Multiple tabs doesn't work with Safari, but does with Chrome, with my current settings. 
// May-6-2014

@run_clif_internally('referbbc');
@run_clif_internally('refercnn');
@run_clif_internally('referfran');
@run_clif_internally('refernyt');
@run_clif_internally('referfox');
@run_clif_internally('refertech');
@run_clif_internally('referwash');

@say(fp);
}



//;

str
@get_date_format_mm_dd_yyyy()
{
str fp = "";

// fcd: Jan-25-2016

str return_date = "test";

str date_portion = date;

return_date = date_portion;

return(return_date);
@say(fp);
}



//;;

void
@add_colons()
{
str fp = 'Add colon before every nonblank line.';

int Line_Counter;

if(!@is_text_file)
{
  return();
}

tof;
while(!at_eof)
{
  if(@trim(@first_character(get_line)) != '')
  {
    line_counter++;
    @bol;
    text(':');
    @say(fp + ' (' + str(Line_Counter) + ')');
  }
  down;
}

/* skw nonblank_line, non_blank_line, blank_line, add colon before, add_colons

nonblank

non_blank

add_bullets

add_bullet

add_bullets

into_bul

into_a_bul

*/

}



//;

void
@extend_highlighted_text
{
str fp = "false";

// fcd: Apr-14-2016

if(@text_is_selected)
{
//  @block_on;
  word_right;
  word_right;
//  rm('14');
  fp = 'true';
}
// hey now
//@copy_with_marking_left_on;
//selected

@say(fp);
}



//;;

void
@add_blank_lines()
{
str fp = 'Separate each line in subject file with a blank line.';

/*
Usage note: Since this macro is fairly powerful, we may not want to assign it a keystoke,
so as to prevent if from being accidentally used.
*/

if(!@is_text_file)
{
  return();
}

tof;
while(!at_eof)
{
  if(find_text("$^", 0, _regexp))
  {
    Replace("$$");
  }
  else
  {
    break;
  }
}
// Now take away extra lines because we don't want to get carried away.
@replace_2_blank_lines_with_1;
tof;

@say(fp);
}



//;

void
@add_c_bullet_and_paste
{
str fp = "Add c bullet and paste.";
@header;

// fcd: Mar-19-2015

@add_bullet_at_lc('c');
@paste_with_wikipedia_format;

@footer;
@say(fp);
}



//;

str
@look_up_credentials_source_lc(int &source_lc_is_found)
{
str fp = "Look up credentials source launch code.";

str distilled_lc;
str sc = '!cred.+';
str so;

mark_pos;
@bol;

source_lc_is_found = 0;
if(find_text(sc, 3, _regexp))
{
  Distilled_lc = @distill_lc(found_str);;
  Distilled_lc = @trim_after_character(Distilled_lc, ')');
  Distilled_lc = str_del(distilled_lc, 1, 4);
  source_lc_is_found = 1;
}

goto_mark;

@say(distilled_lc);
return(Distilled_lc);
}



//;

void
@add_text_generic_credentials
{
str fp = "Add text generic credentials.";

// fcd: Jan-7-2016

// skw: add_text_credentials

@header;

@add_bullet_below;
text(' Credentials (!z, !2q)');
@add_subbullet_below;
text('raybass8@gmail.com: macrocosm');
@add_subbullet_below;
text('becharming: oblique');
@bob;
right;

@footer;
@say(fp);
}



//;

void
@go_to_credentials_rubric
{
str fp = "Go to source of credentials.";
@header;

// fcd: Aug-5-2015

@save_location;

int source_lc_is_found;

str lc = @look_up_credentials_source_lc(source_lc_is_found);

if(source_lc_is_found)
{
  @find_lc(lc);
}
else
{
  fp += ' This lc has an associated credentials destination. (' + lc + ')';
}

@footer;
@say(fp + ' (' + lc + ')');
}



//;

str
@uppercase_clif(str &regex_Description, str &rS)
{
str fp = "Uppercased clifs.";
str sc = '![A-Z]+[A-Za-z]*,||\)';
//rs = ''
regex_Description = fp;
return(sc);
}



//;

void
@add_text_credential_at_lc(str lc = parse_str('/1=', mparm_str))
{
str fp = "Add text credential at remote lc.";
@header;

// fcd: Aug-19-2015

@find_lc(lc);
@add_bullet_below;
@add_subbullet_below;
text(": macrocosm");
@add_subbullet_below;
text(": oblique");
@bob;
@eoc;

@footer;
@say(fp);
}



//;

void
@make_the_current_line_lc_unique()
{
str fp = "Make the current line's LC unique in all open files.";
@header;

// fcd: Sep-7-2015

@save_location;
@determine_if_lc_is_unique;
@delete_text_lc_on_cl;
@recall_location;

@footer;
@say(fp);
}



//;;

void
@add_new_lc_to_cl_and_mk_unique(str lc = parse_str('/1=', mparm_str))
{
str fp = "Add new launch code to current line and make it unique.";

// fcd: Sep-15-2015
@add_text_lc_on_current_line(lc);
@make_the_current_line_lc_unique;

@say(fp);
}



//;

void
@add_new_lc_to_cl_and_ck_unique(str lc = parse_str('/1=', mparm_str))
{
str fp = "Add new launch code to current line and check if it is unique.";

// fcd: Sep-15-2015
@add_text_lc_on_current_line(lc);
@find_lc(lc);

@say(fp);
}



//;;

void
@add_text_tr_lc_on_current_line
{
str fp = "Add text 'tr' launch code on current line and remove current occurrence.";

@header;

mark_pos;

if(@find_lc('tr'))
{
  @delete_text_lc_on_cl;
}

goto_mark;

@add_text_lc_on_current_line('tr');

@footer;

@say(fp);
}



//;

void
@find_tsql_definition_uc
{
str fp = 'Go to T-SQL definition, for word under cursor or selected block.';

@header;

str sc = @get_word_under_cursor_or_st;

sc = make_literal_x(sc);

sc = ".*" + sc;

@find_tsql_definition(sc);

@footer;
}



//;;

str
@get_cj_and_interim_text()
{
str fp = "Get CJ and interim text.";
int lc_Is_Found;
str expanded_object = @get_remote_oj_using_klc('cj', lc_is_found);
expanded_Object += ' interim check-in.';
set_global_str('cmac_return_value', expanded_Object);
return(expanded_Object);
}



//;;

str
@get_official_information
{
str fp = "Add text with remote subject.";

// fcd: Apr-14-2015

@header;

@save_location;

str lc = 'cj';

if(!@find_lc_known(fp, lc))
{
  @recall_location;
  @footer;
  @say(" Error: Launch code not found. (" + lc + ")");
  return('');
}

str sj = @hc_subject;

str rv = '// JRJ, ';
rv += @get_date;
rv += ', ';
rv += sj;
rv += '. ';

@set_clipboard(rv);

@recall_location;

@footer;
@say(fp + ' (' + rv + ')');
}



//;

void
@get_sj_end_column_tn
{
str fp = "";

// fcd: May-22-2015

str test = str(@get_sj_end_column(get_line, 0));
@say(test);
}



//;

void
@update_tortoise_build_number_bk
{
str fp = "Update Tortoise's build number bookmark.";
@header;

// fcd: Aug-20-2015
@determine_if_lc_is_unique;
@eol;
@backspace;

@footer;
@say(fp);
}



//;;

void
@add_rubric_below(str lc = parse_str('/1=', mparm_str))
{
str fp = 'Add rubric below.';

if(lc == '')
{
  lc = 'ggch';
}

if(lc == 'bf')
{
  @bof;
}
else if(lc != '')
{
  if(!@find_lc_known(fp, lc))
  {
    @footer;
    return();
  }
}

@find_next_rubric;
@add_rubric_above('');

@say(fp);
}



//;

void
@start_new_now_playing
{
str fp = "";
fp = "Start new Now Playing.";

@header;

@find_lc('np');
@eoc;
text('Old ');
@delete_text_lc_on_cl;
@add_bullet_above;
text('Now Playing File:');
@add_text_lc_on_current_line('np');
eol;
cr;
cr;
@paste;
up;
@bol;
@footer;
@say(fp);
}



//;;

void
@show_message(str lc = parse_str('/1=', mparm_str))
{
str fp = "Show status bar message for remote subject.";

// fcd: Apr-14-2015

@save_location;

if(!@find_lc_known(fp, lc))
{
  @recall_location;
  @footer;
  @say(" Error: Launch code not found. (" + lc + ")");
  return();
}

str sj = @hc_subject;

@recall_location;

@say(fp + ' (' + sj + ')');
}



//;

void
@change_case
{
str fp = "Open Multi-Edit dialogue box for changing case.";

// fcd: Aug-6-2015

rm('ChangeCaseBtnDlg');

@say(fp);
}



void
//;;

@switch_to_the_mappings_window()
{
str fp = "Switch to the Mappings window.";

rm('@switch_to_named_window /1=TMTMappings.config');

@say(fp);
}



//;;

void
@add_colons_old()
{
str fp = "Add colon at BOL after every blank line / nonblank line.";

@header;

str so = '';
str sc = '';
sc = '^$[a-zA-Z0-9\-\[:]';
tof;

while(@seek_next(sc, so))
{
  down;
  @bol;
  text(':');
  right;
}

@footer;
@say(fp);
}



//;

void
@wota_complete_macro
{
str fp = "Wota complete macro.";
@header;

// fcd: Aug-14-2014

@find_lc('ta');
@hc_big_segment_content;
@create_new_file;
@paste;
@delete_carriage_returns;
@select_all;
@copy;

str application = "c:\\program files\\microsoft office\\office14\\winword.exe";
@run_application_2p(application, 
  'C:\Users\jrj.GCITECH\documents\!savannah\work documents\toastmasters.docx');

@footer;
@say(fp);
}



//;;

void
@find_last_read_item_in_jira(str lc = parse_str('/1=', mparm_str))
{
str fp = "Find last read item in Jira.";

@set_clipboard('MT-2581');

@search_jira('');

@say(fp);
}



//;;

void
@open_folder_router_old
{
str fp = "Open folder router.";

str path;

// Use case 1.
if(@text_is_selected)
{
  path = @get_selected_text;
  path = @resolve_environment_variable(path);
  @open_folder(path);
  @say(fp + ' Path 1.');
  return();
}

// Use case 2.
if(@is_bullet_file)
{
  if((@first_character(get_line) != ';') && (@first_character(get_line) != ':'))
  {
    mark_pos;
    @bobsr; //qcq
    @anatomize_clif(2, fp);
    goto_mark;
    @say(fp);
    return();
  }
  else
  {
    @anatomize_clif(2, fp);
    @say(fp);
    return();
  }
}

@say(fp + ' Path 2.');

// Use case 3.
path = get_line;

path = @resolve_environment_variable(path); 
@open_folder(path);

/* Use Cases

- Use Case on Feb-18-2013:

%my documents%

- Use Case on Feb-18-2013:

%my documents%\


Use Case 1: Dec-9-2011:

c:\!

*/

}



//;;

void
@open_microsoft_excel_for_jira
{
str fp = "Open Microsoft Excel for Jira items.";

str lc = 'cj';

@header;

@save_location;

if(!@find_lc_known(fp, lc))
{
  @recall_location;  
  @say(" Error: Launch code not found. (" + lc + ")");
  @footer;
  return();
}

str filename = @get_subject_or_selected_text;

@open_microsoft_product_for_jira(filename, 'excel', 'xlsx');

@recall_location;

@footer;

}



//;;

void
@open_microsoft_word_for_jira
{
str fp = "Open Microsoft Word for Jira items.";

str lc = 'cj';

@header;

@save_location;

if(!@find_lc_known(fp, lc))
{
  @recall_location;  
  @say(" Error: Launch code not found. (" + lc + ")");
  @footer;
  return();
}

str filename = @get_subject_or_selected_text;

@open_microsoft_product_for_jira(filename, 'winword', 'docx');

@recall_location;

@footer;

}



//;;

void
@open_microsoft_onenote_for_jira
{
str fp = "Open Microsoft OneNote for Jira items.";

str lc = 'cj';

@header;

@save_location;

if(!@find_lc_known(fp, lc))
{
  @recall_location;  
  @say(" Error: Launch code not found. (" + lc + ")");
  @footer;
  return();
}

str filename = @get_subject_or_selected_text;

@open_microsoft_product_for_jira(filename, 'onenote', 'one');

@recall_location;

@footer;

}



//;;

void
@open_microsoft_visio_for_jira(str parameter = parse_str('/1=', mparm_str))
{

str fp = "Open Microsoft Visio for Jira items.";

str filename = parameter;

if(filename == '')
{
  filename = @get_subject_or_selected_text;
}

if(@right(filename, 4) != '.vsd')
{
  filename += '.vsd'; 
}

str filepath = '%savannah%\work documents';

filepath = @resolve_environment_variable(filepath);

str fullfilepath = filepath + '\' + filename;

str application = "c:\\program files\\microsoft office\\office15\\visio.exe";

@run_application_2p(application, fullfilepath);

/* Use Cases

*/

set_global_str('inner_status_message', fp);
@say(fp);
}



//;;

void
@open_microsoft_ppoint_for_jira(str parameter = parse_str('/1=', mparm_str))
{

str fp = "Open Microsoft Excel for Jira items.";

str filename = parameter;

if(filename == '')
{
  filename = @get_subject_or_selected_text;
}

if(@right(filename, 5) != '.xlsx')
{
  filename += '.pptx'; 
}

str filepath = '%savannah%\work documents';

filepath = @resolve_environment_variable(filepath);

str fullfilepath = filepath + '\' + filename;

str application = "c:\\program files\\microsoft office\\office14\\powerpnt.exe";

@run_application_2p(application, fullfilepath);

/* Use Cases

*/

set_global_str('inner_status_message', fp);
@say(fp);
}



//;;

void
@open_microsoft_excel_for_jira(str parameter = parse_str('/1=', mparm_str))
{

str fp = "Open Microsoft Excel for Jira items.";

str filename = parameter;

if(filename == '')
{
  filename = @get_subject_or_selected_text;
}

if(@right(filename, 5) != '.xlsx')
{
  filename += '.xlsx'; 
}

str filepath = '%savannah%\work documents';

filepath = @resolve_environment_variable(filepath);

str fullfilepath = filepath + '\' + filename;

str application = "c:\\program files\\microsoft office\\office14\\excel.exe";

@run_application_2p(application, fullfilepath);

/* Use Cases

- 1. Use Case on Dec-12-2011: This file DOES already exist.
MT-4737

- 2. Use Case on Dec-12-2011: This file DOESN'T already exist.
MT-4751

*/

set_global_str('inner_status_message', fp);
@say(fp);
}



//;

void
@open_microsoft_word_for_ss
{

str fp = "Open Microsoft Word for word under cursor or selected text.";

str filename = @get_subject_or_selected_text;

if(@right(filename, 5) != '.docx')
{
  filename += '.docx'; 
}

str filepath = '%savannah%\work documents';

filepath = @resolve_environment_variable(filepath);

str fullfilepath = filepath + '\' + filename;

str application = "c:\\program files (x86)\\microsoft office\\office12\\winword.exe";

@run_application_2p(application, fullfilepath);

/* Use Cases

- 1. Use Case on Dec-12-2011: This file DOES already exist.
MT-4737

- 2. Use Case on Dec-12-2011: This file DOESN'T already exist.
MT-4751

*/

@say(fp);
}



//;;

void
@open_microsoft_word(str parameter = parse_str('/1=', mparm_str))
{

str fp = "Open Microsoft Word.";

str filename = parameter;

if(filename == '')
{
  filename = @get_subject_or_selected_text;
}

if(@right(filename, 5) != '.docx')
{
  filename += '.docx'; 
}

str filepath = '%savannah%\work documents';

filepath = @resolve_environment_variable(filepath);

str fullfilepath = filepath + '\' + filename;

str application = "c:\\program files\\microsoft office\\office14\\winword.exe";

@run_application_2p(application, fullfilepath);

/* Use Cases

- 1. Use Case on Dec-12-2011: This file DOES already exist.
MT-4737

- 2. Use Case on Dec-12-2011: This file DOESN'T already exist.
MT-4751

*/

set_global_str('inner_status_message', fp);
@say(fp);
}



//;;

void
@open_microsoft_onenote_for_jira
{

str fp = "Open Microsoft OneNote for Jira items.";

@save_location;

str lc = 'cj';

if(!@find_lc_known(fp, lc))
{
  @recall_location;
  @footer;
  @say(" Error: Launch code not found. (" + lc + ")");
  return();
}

str filename = @get_subject_or_selected_text;
//qjq-1

if(@right(filename, 4) != '.one')
{
  filename += '.one'; 
}

str filepath = '%savannah%\work documents';

filepath = @resolve_environment_variable(filepath);

str fullfilepath = filepath + '\' + filename;

str application = "c:\\program files\\microsoft office\\office14\\onenote.exe";

@run_application_2p(application, fullfilepath);

/* Use Cases

*/

@recall_location;

@say(fp);
}



//;

void
@rtm2
{
str fp = "";

// fcd: Apr-23-2015

@find_lc_with_built_in_return_hc('cj');

@say(fp);
}



//;

void
@find_lc_with_built_in_return_hc(str lc = parse_str('/1=', mparm_str))
{
str fp = "Find lc with built-in return home capability.";

// fcd: Apr-23-2015

@save_location;

@find_lc(lc);

@recall_location;

@say(fp);
}



//;

void
@find_lc_from_multiedit_diag(str lc = parse_str('/1=', mparm_str))
{

str fp = 'Find Launch Code from the Multi-Edit commands dialogue box using known launch 
  code "' + lc + '".';

// Abbreviated version for the status bar.
fp = 'Find Launch Code "' + lc + '" from dialogue.';

int search_criterion_was_found;

@header;

str so = @find_lc_core(lc, search_criterion_was_found, fp);

if(search_criterion_was_found)
{
  @seek_next(@bullet, fp); //qcq
  eol;
}

str Distilled_lc = @distill_lc(lc);

fp += ' ' + so;

@footer;

@say(fp);

}



//;;

void
@add_cmac_stub_6
{
str fp = 'Add CMAC stub for a test harness.';

block_off;
@find_next_big_segment;

@bol;
cr;
up;
text('//;');
cr;
cr;
text('void');
cr;
text('@r' + 'tm');
eol;
cr;
text('{');
cr;
text('str fp = "');
text(@get_formatted_date);
text('.";');
cr;
@paste;
eol;
text('();');
cr;
text('//q' + 'q');
cr;
text('}');
cr;
cr;
cr;

up;
up;
up;
up;
up;
eol;
left;
left;

@say(fp);
}



//;;

str
@get_official_information()
{
str fp = "Get official information.";

str rv = 'Return official string.';

int lc_Is_Found;

str rv = '//// JRJ, ';
rv += @get_date;
rv += ', ';
rv += @get_remote_sj_using_klc('cj', lc_Is_Found);
rv += '. ';

@set_clipboard(rv);
return(rv);
}



//;;

void
@add_text(str parameter_1 = parse_str('/1=', mparm_str))
{
str fp = "Add text 'the modern way' macro.";
text(parameter_1);
// The following eols don't work because the position is controlled by the bookmark.
// I think you would need to change code in RCC in order to get cursor positioning to work.
eol;
eol;
fp += ' (' + parameter_1 + ')';
set_global_str('inner_status_message', fp);
@say(fp);
}



//;

void
@load_clipboard_with_remote_oj(str lc = parse_str('/1=', mparm_str))
{
str fp = 'Load clipboard with remote object.';

int Search_Criterion_Was_Found;
int Initial_Window = @current_window;

@header;

str so = @find_lc_core(lc, Search_Criterion_Was_Found, fp);

if(Search_Criterion_Was_Found)
{
  @hc_object();
}
else
{
  fp += ' ' + so;
}

switch_window(Initial_Window);

@footer;
@say(fp);
}



//;;

str
@lp_catch_block()
{
str fp = "Load clipboard - Catch block.";

str sc = 'variable_current_date_with_time';
str rs = @get_date_with_time;
str rv;

@header;

@save_location;

@find_lc('tryc');

@hc_small_segment_content_dinc;

@create_reusable_temporary_file;

@paste;

@bof;

@replace_next_occurrence_only(sc, rs);

@select_all;

@copy;

@close_and_save_file_wo_prompt;

@load_location;

@footer;

return(rv);
}



//;;

str
@lp_tddn_method()
{
str fp = "Load clipboard - Test Driven Dot Net test.";
str rv;

int lc_Is_Found;

@save_location;

@create_reusable_temporary_file;

text('/// <summary>');
cr;
text('/// Function Creation Date: ');
@add_text_date;
cr;
text('/// </summary>');
cr;
text('public void ');
str underscore_date = @replace(@get_formatted_date, '-', '');
text('PlayingWith');
text('()');
cr;
text('{');
cr;
text('Debug.WriteLine("JRJ - ' + @get_formatted_date + " " + @get_formatted_time + '");');
cr;
text('}');
cr;
cr;

@select_all;

@copy;

@close_and_save_file_wo_prompt;

@load_location;

@say(fp);
return(rv);
}



//;;

str
@get_remote_post_rm_colon_phrase(str lc)
{
str fp = "Get remote object portion using known launch code.";

@save_location;

str object_Portion;

if(!@find_lc_known(fp, lc))
{
  @load_location;
  @footer;
  return(" Error: Launch code not found.");
}

// Load clipboard.
@hc_object;
object_Portion = @get_selected_text;

@load_location;
return(object_Portion);
}



//;;

void
@get_remote_oj_using_klc_tm
{
str fp = "Jan-12-2012.";
int is_Found;
str lc = 'tq';
str fp = @get_remote_oj_using_klc(lc, is_Found);
@say(fp);
}



//;;

void
@get_remote_oj_test
{
str fp = 'Get remote oj test.';

@header;
int lc_Is_Found;
fp = @get_remote_oj_using_klc('z', lc_Is_Found);

fp = @trim_leading_colons_et_al(fp);
fp = @trim_preobject_phrase(fp);

@footer;
@say(fp);

/* Use Case(s)

- 1. Use Case on Jan-6-2012:
- Back up Source Code files to Backup folder: 
%savannah%\belfry\Back up source code to 2 places.bat

*/

}



//;

void
@tm3
{
str fp = "Finds all rubrics that have children that DON'T have the plus sign.";


int Initial_Line_Number = @current_line_number;
int Initial_Window = @current_window;
int parent_identified_properly = false;
int Window_Counter = 1;

str fs;
str sc = @rubric;
str so;

str child_area_type;
str original_area_type;

@header;

tof;
@seek_next(sc, sO);
return();
original_area_type = @current_area_type;
parent_identified_properly = false;
if(@current_line_contains('+'))
{
  parent_identified_properly = true;
}
@find_next_big_segment;
child_area_type = @current_area_type;
if((original_area_type == 'rubric') && (child_area_type == 'subrubric'))
{
  if(!parent_identified_properly)
  {
    fp += ' Found noncompliant parent rubric.';
    @say(fp);
    @footer;
    return();
  }
  else
  {
    fp += ' Found compliant parent rubric.';
    @say(fp);
    @footer;
    return();
  }
}

//rm('NextWin');
//while (@current_window != Initial_Window)
//{
//  //  fp += ' 2';
//  while(@seek_next(sc, sO))
//  {
//    fp += ' 3';
//    original_area_type = @current_area_type;
//    parent_identified_properly = false;
//    if(@current_line_contains('+'))
//    {
//      parent_identified_properly = true;
//    }
//    @find_next_big_segment;
//    child_area_type = @current_area_type;
//    if((original_area_type == 'rubric') && (child_area_type == 'subrubric'))
//    {
//      fp += ' 4';
//      if(!parent_identified_properly)
//      {
//        fp += ' 5';
//        fp += ' Found noncompliant parent rubric.';
//        @say(fp);
//        return();
//      }
//    }
//  }
//  rm('NextWin');
//}

@say(fp);
@footer;
}



//;

void
@create_invisible_file()
{
str fp = 'Create new temporary file.';
str filename[128] = 'c:\!\JRJ_Temporary_File' + '.txt';
int Handle;
s_create_file(filename, handle);
s_close_file(handle);
rm('makewin /NL=1');
if(file_exists(filename))
{
  return_str = filename;
  rm('ldfiles'); // load the file.
  if(error_level != 0)
  {
    rm('meerror');
  }
}
}



//;

void
@stnw
{
str fp = "stnw";

// fcd: Mar-20-2015

str filename[128] = 'c:\!\JRJ_Temporary_File' + '.txt';
str filename2 = 'JRJ_Temporary_File.txt';

@switch_to_named_window('GCI.asc');
@switch_to_named_window(filename2);

@say(fp);
}



//;;

void
@add_text_backup_bullet
{
str fp = 'Add text backup bullet.';

@header;

@bol;
cr;
up;
text(':');
text(', ');
text(@get_formatted_date);
cr;
text('set subject_path=');
@paste;
cr;
text('set subject_filename=');
cr;
text('call "%savannah%\belfry\back up source code.bat" "%subject_path%"');
text(' "%subject_filename%"');
cr;
up;
up;
up;
@eol;
up;
@eoc;
@save_location;
@find_lc_known(fp, 'cj');
//eol;
@hc_object;
@load_location;
@paste;
down;
eol;
@hc_word_under_cursor;
@cut;
down;
eol;
@paste;
up;
up;
eol;

@footer;
@say(fp);
}



//;

void
@highcopy
{

/*

int row_1 = parse_int('/3=', mparm_str), 
int column_1 = parse_int('/1=', mparm_str), 
int row_2 = parse_int('/4=', mparm_str))
int column_2 = parse_int('/2=', mparm_str),

*/

str fp = "Highlight and copy.";

goto_line(Global_int('highcopy row 1'));
goto_col(Global_int('highcopy column 1'));

str_block_begin;

goto_line(Global_int('highcopy row 2'));
goto_col(Global_int('highcopy column 2'));

@copy_with_marking_left_on;

@say(fp);
}



//;

void
@archive_cmac_rubric()
{
str fp = "Add the current function cmac code graveyard.bul.";

/* I need to add to the function so that it includes regular big segments, not just *.s type 
segments. I may want to do that by checking the file extension of the current file, and
adjusting the destination file accordingly. - Jul-3-2012

*/

@save_location;

@bor;

@cut_rubric;

rm("@open_file_with_writability /FN=" + Get_Environment('savannah') +
  "\\cmac\\source code\\cmac code graveyard.s");

@bof;

@paste;

@close_and_save_file_wo_prompt;

@load_location;

@bobs;

@say(fp);
}



//;

void
@archive_bullet_rubric()
{
str fp = "Archive rubric to the file historical rubrics.bul.";

@save_location;

@bor;

@cut_rubric;

rm("@open_file_with_writability /FN=" + Get_Environment('savannah') +
  "\\miscellany\\historical rubrics.asc");

@bof;

@paste;

@close_and_save_file_wo_prompt;

@load_location;

@say(fp);
}



//;

void
@move_to_lastp(int return_home)
{
str fp = "Move the conext object to the last position.";

// fdob: Nov-5-2014

@save_location;

if(!@is_bullet_file)
{
  block_off;
  @cut;
  eof;
  cr;
  @paste;
  up;
  if(return_home)
  {
    @load_location;
  }
  if(at_eof)
  {
    up;
  }
  @footer;
  @say(fp);
  return();
}

switch(@current_line_type)
{
  case 'rubric':
    @cut_rubric;
    @eof;
    @bol;
    @paste;
    up;
    @bor;
    break;
  case 'subrubric':
    @cut_big_segment;
    @find_next_rubric;
    @bol;
    @paste;
    up;
    @bobs;
    break;
  case 'subbullet':
    @move_subbullet_to_last_ps_wme
    break;
  case 'bullet':
    if(return_home)
    {
      @run_bullet_action_model('8');
    }
    else
    {
      @run_bullet_action_model('8w');
    }
    break;
  default:
}

eol;

if(return_home)
{
  @load_location;
}

@say(fp);
}



//;

void
@move_bullet_to_neor_wme
{
str fp = 'Move bullet to next eor with me.';

if(!@is_bullet_File)
{
  return();
}

if(!@is_bullet_or_subbullet)
{
  return();
}

@header;

@cut_bullet;

@find_next_big_segment;

@eor;

// The following line helps in the case where you have a multiple line rubric header.
@find_next_blank_line;

down;
@bol;
@paste;

up;
@bobsr;

@footer;
@say(fp);
}



//;+

void
@move_bullet_to_neor_alone
{
str fp = 'Move bullet to next eor.';

if(!@is_bullet_File)
{
  return();
}

if(!@is_bullet_or_subbullet)
{
  return();
}

@header;

@cut_bullet;

mark_pos;
@find_next_big_segment;
@find_next_big_segment;

@find_previous_content_area;
@paste_after;

goto_mark;

@bobsr;

@footer;
@say(fp);
}



//;;

void
@move_bullet_to_nmor_alone
{
str fp = 'Move bullet to the next mor.';

if(!@is_bullet_File)
{
  return();
}

if(!@is_bullet_or_subbullet)
{
  return();
}

@header;

@cut_bullet;

mark_pos;
@find_next_big_segment;

@mor;

@paste;
goto_mark;
@bob;

@footer;
@say(fp);
}



//;;

void
@move_bullet_to_nbor_wme
{
str fp = 'Move bullet to next bor with me.';

if(!@is_bullet_File)
{
  return();
}

if(!@is_bullet_or_subbullet)
{
  return();
}

@header;

@cut_bullet;

@find_next_big_segment;

// The following line helps in the case where you have a multiple line rubric header.
@find_next_blank_line;

down;
@bol;
@paste;

up;
@bobsr;

@footer;
@say(fp);
}



//;;

void
@move_bullet_to_nbor_alone
{

str fp = 'Move bullet to the next bor.';

if(!@is_bullet_File)
{
  return();
}

if(!@is_bullet_or_subbullet)
{
  return();
}

@header;

@cut_bullet;

mark_pos;
@find_next_big_segment;

// The following line helps in the case where you have a multiple line rubric header.
@find_next_blank_line;

down;
@bol;
@paste;
goto_mark;
@bobsr;

@footer;
@say(fp);
}



//;;

void
@move_bullet_to_plast_alone()
{
str fp = "Move bullet to plast alone.";

// fdob: Nov-18-2014

@header;

@save_location;

@move_bullet_to_plast_wme();

@load_location;

@footer;

}



//;;

void
@move_bullet_to_plast_wme()
{
str fp = 'Move bullet to last position with me.';

// fdob: Nov-18-2014

@cut_bullet;
@find_next_big_segment;
@find_previous_content_area;
@paste_after;
goto_col(1);

@say(fp);
}



//;;

void
@move_bullet_to_eor_wme()
{
str fp = 'Move bullet to eor with me.';

@highcopy_bullet;
rm('CutPlus /M=1');
if(@find_next_big_segment)
{
  up;
  up;
}
else
{
  eof;
  down;
}
goto_col(1);
rm('Paste');

@say(fp);
}



//;;

void
@move_bullet_to_eor_alone()
{
str fp = 'Move bullet to eor.';

@header;

@save_location;

@move_bullet_to_eor_wme;

@load_location;

@footer;

@say(fp);
}



//;;

void
@move_bullet_to_mor_wme
{
str fp = 'Move bullet to mor with me.';

if(!@is_bullet_File)
{
  return();
}

if(!@is_bullet_or_subbullet)
{
  return();
}

@header;

@cut_bullet;
@mor;
@find_next_bullet;
@bol;
@paste;
@find_previous_bullet;

@footer;

@say(fp);
}



//;;

void
@move_bullet_to_mor_alone
{
str fp = 'Move bullet to mor.';

if(!@is_bullet_File)
{
  return();
}

if(!@is_bullet_or_subbullet)
{
  return();
}

@header;

@save_location;

@cut_bullet;
@mor;
@find_next_bullet;
@bol;
@paste;

@load_location;

@footer;
@say(fp);
}



//;;

void
@move_bullet_to_bor
{
@header;
@move_bullet_to_p1_alone;
@footer;
}



//;;

void
@move_bullet_to_p1_alone()
{
str fp = "Move bullet to p1 alone.";

// fdob: Nov-18-2014

@header;

@save_location;

@move_bullet_to_p1_wme();

@load_location;

if(!@is_structured_line)
{
  @find_next_content_area;
}

@footer;

}



//;;

void
@move_bullet_to_bor_wme
{
@header;
@move_bullet_to_p1_wme;
@footer;
}



//;;

void
@move_bullet_to_p1_wme()
{
str fp = 'Move bullet to first position with me.';

// fdob: Nov-18-2014

@cut_bullet;
left;
@bobs;
@paste_after;
goto_col(1);
@bob;

@say(fp);
}



//;

void
@move_bullet_to_peor_alone
{
str fp = 'Move bullet to previous eor.';

if(!@is_bullet_file)
{
  return();
}

if(!@is_bullet_or_subbullet)
{
  return();
}

@header;

@cut_bullet;

mark_pos;

@bobs;

@find_previous_content_area;
@paste_after;

goto_mark;
@bobsr;

@footer;
@say(fp);
}



//;;

void
@move_bullet_to_pmor_alone
{
str fp = 'Move bullet to previous mor.';

if(!@is_bullet_File)
{
  return();
}

if(!@is_bullet_or_subbullet)
{
  return();
}

@header;

@cut_bullet;

mark_pos;
@bobs;
@find_previous_big_segment;

@mor;
@paste_after;

goto_mark;

@bobsr;

@footer;
@say(fp);
}



//;

void
@move_bullet_to_pbor_wme
{
str fp = 'Move bullet to previous bor with me.';

if(!@is_bullet_file)
{
  return();
}

if(!@is_bullet_or_subbullet)
{
  return();
}

@header;

@cut_bullet;

@find_previous_big_segment;

@paste_after;

@footer;
@say(fp);
}



//;

void
@move_bullet_to_pbor_alone
{
str fp = 'Move bullet to previous bor.';

if(!@is_bullet_file)
{
  return();
}

if(!@is_bullet_or_subbullet)
{
  return();
}

@header;

@cut_bullet;

mark_pos;

@find_previous_big_segment;

@paste_after;

goto_mark;

@footer;
@say(fp);
}



//;;

void
@move_bullet_to_lc(int return_Home = parse_int('/1=', mparm_str))
{
str fp = 'Move bullet to lc, the outer layer.';

@header;

if(return_Home)
{
  @save_location;
  @move_bullet_to_lc_alone;
}
else
{
//  @move_bullet_to_lc_wme;  
  if(!@is_structured_line)
  {
    @find_previous_content_area;
  }
}

if(return_Home)
{
  @load_location;
}

@footer;
}



//;;

str
@get_intelligent_guess()
{
str fp = "Get intelligently guessed text of the current cursor position.";

str sc;

if(@text_is_selected)
{
  sc = @get_selected_text;
  @set_clipboard(sc);
  return(sc);
}

sc = get_line;
sc = @trim_leading_colons_et_al(sc);
if(@first_4_characters(sc) == 'http')
{
  @set_clipboard(sc);
  return(sc);
}

mark_pos;
down;
if(@is_blank_line)
{
  goto_mark;
  sc = @get_object;
  @set_clipboard(sc);
  return(sc);
}
else
{
  pop_mark;
}

sc = @get_multiline_object;
@set_clipboard(sc);
return(sc);
}



//;+



//;;

void
@move_bullet_to_bor
{
str fp = 'Promote bullet or subbullet to the first position alone. This method uses
  context sensitivity.';

@header;

if(!@is_bullet_file)
{
  mark_pos;
  block_off;
  @cut;
  tof;
  @paste;
  up;
  goto_mark;
  @say(fp);
  if(at_eof)
  {
    up;
  }
  @footer;
  return();
}

if(@is_bullet)
{
  @move_bullet_to_p1;
}
else
{
  @move_subbullet_to_p1;
}

if(@is_last_small_segment)
{
  @bobsr;
}
@eoc;

@footer;
@say(fp);
}



//;;

void
@move_bullet_to_bor_wme()
{
str fp = 'Move bullet to bor with me.';

if(!@is_bullet_file)
{
  return();
}

@cut_bullet;

@bobs;
@paste_after;

@eol;

@say(fp);
}



//;;

void
@promote_bos_wme
{
str fp = 'Promote bullet or subbullet to the first position with me. This method uses context
  sensitivity.';

@header;

if(!@is_bullet_file)
{
  block_off;
  @cut;
  tof;
  @paste;
  up;
  @say(fp);
  @footer;
  return();
}

switch(@current_area_type)
{
  case 'bullet':
    @move_bullet_to_bor_wme;
    break;
  case 'subbullet':
    @move_subbullet_to_p1_wme;
    break;
  case 'rubric':
    @move_rubric_to_p1_wme;
    break;
  case 'subrubric':
    @move_subrubric_to_p1_wme;
    break;
}

eol;

@footer;
}



//;;

void
@move_to_first_position_alone_de
{
str fp = "Move to first position alone deprecated.";

// fdob: Nov-5-2014

@header;

@save_location;

if(!@is_bullet_file)
{
  mark_pos;
  block_off;
  @cut;
  tof;
  @paste;
  up;
  goto_mark;
  @say(fp);
  if(at_eof)
  {
    up;
  }
  @footer;
  return();
}

switch(@current_line_type)
{
  case 'rubric':
    mark_pos;
    @bor;
    @cut_rubric;
    @bof;
    @find_next_rubric;
    @bol;
    @paste;
    goto_mark;
    if(@current_line_type != 'rubric')
    {
      @find_next_rubric;
    }
    break;
  case 'subrubric':
    mark_pos;
    @cut_big_segment;
    up;
    @bor;
    @find_next_big_segment;
    @bol;
    @paste;
    goto_mark;
    @find_previous_big_segment;
    break;
  case 'bullet':
    @move_bullet_to_bobs;
    break;
  case 'subbullet':
    @move_subbullet_2p1@;
    break;
  default:
}

if(@is_last_small_segment)
{
  @bobsr;
}
@eoc;

eol;

@footer;

@say(fp);
}



//;;

void
@compare_lck_for_bullet
{
str fp = "Does the current small segment have the largest lck?";

if(!@is_bullet_or_subbullet)
{
  return();
}

@header;

int current_line_lk_number = 0;
int number_of_lines_to_search;
int starting_line_lk_number;

mark_pos;

@bob;

int first_line_in_bullet = @current_line;

goto_mark;

int number_of_lines_in_bullet = @count_lines_in_bullet;

mark_pos;

if(find_text(@lookup_counter, 1, _regexp))
{
  starting_line_lk_number = @get_lk_number_uc;
  down;
}
else
{
  fp += ' NO lookup counters found.';
  @say(fp);
  @footer;
  return();
}

while(starting_line_lk_number >= current_line_lk_number)
{
  number_of_lines_to_search = number_of_lines_in_bullet - (@current_line - 
    first_line_in_bullet);
  if(find_text(@lookup_counter, number_of_lines_to_search, _regexp))
  {
    current_line_lk_number = @get_lk_number_uc;
    if(current_line_lk_number > starting_line_lk_number)
    {
      fp += ' Found greater lc.';
      break;
    }
    else
    {
      down;
    }
  }
  else
  {
    fp += ' Yes.';
    goto_mark;
    break;
  }
}
pop_mark;

@footer;
@say(fp);
}



//;;

void
@context_sv_delete_previous
{
str fp = 'Context sensitive delete previous.';
@header;
{
  @find_previous_bullet;
  @delete_bullet;
}
else
{
  @delete_previous_line;
}
@footer;
@say(fp);
}



//;;

void
@move_to_last_position_alone_old
{
str fp = "Move to last position alone.";

// fdob: Nov-5-2014

@header;

if(!@is_bullet_file)
{
  mark_pos;
  block_off;
  @cut;
  eof;
  cr;
  @paste;
  up;
  goto_mark;
  @say(fp);
  if(at_eof)
  {
    up;
  }
  @footer;
  return();
}

switch(@current_line_type)
{
  case 'rubric':
    mark_pos;
    @cut_rubric;
    @eof;
    @bol;
    @paste;
    goto_mark;
    break;
  case 'subrubric':
    mark_pos;
    @cut_big_segment;
    @find_next_rubric;
    @bol;
    @paste;
    goto_mark;
    break;
  case 'subbullet':
    @move_subbullet_to_last_ps_wme
    break;
  case 'bullet':
    @move_bullet_to_eor_wme;
    break;
  default:
}

eol;

@footer;

@say(fp);
}



//;;

void
@promote_bos_alone
{
str fp = 'Promote bullet or subbullet to the first postion alone. This method uses
  context sensitivity.';

@header;

@save_location;

if(!@is_bullet_file)
{
  mark_pos;
  block_off;
  @cut;
  tof;
  @paste;
  up;
  goto_mark;
  @say(fp);
  if(at_eof)
  {
    up;
  }
  @footer;
  return();
}

if(@is_bullet)
{
  @move_bullet_to_bobs;
}
else
{
  @move_subbullet_2p1@;
}

if(@is_last_small_segment)
{
  @bobsr;
}
@eoc;

@load_location;

@footer;
@say(fp);
}



//;;

void
@demote_bos_wme
{
str fp = 'Demote bullet or subbullet to the last position with me. This method uses context
  sensitivity.';

@header;

if(!@is_bullet_file)
{
  block_off;
  @cut;
  eof;
  cr;
  @paste;
  up;
  @say(fp);
  if(at_eof)
  {
    up;
  }
  @footer;
  return();
}

if(@is_bullet)
{
  @move_bullet_to_eor_wme;
}
else
{
  @move_subbullet_to_last_ps_wme;
}

@footer;
}



//;;

void
@demote_bos_alone()
{
str fp = 'Demote bullet or subbullet to the last position without me. This method uses context
  sensitivity.';

if(@is_bullet)
{
  @move_bullet_to_eor_alone;
}
else
{
  @move_subbullet_to_last_pos;
}

eol;
}



//;

void
@find_lc_for_given_caret
{
str fp = "Find lc for given caret.";

// fdob: Nov-3-2014

@header;

@save_location;

if(@current_line_contains('^'))
{
  str lc = @get_indicated_lc_2;
  @find_lc(lc);
}

@footer;

@say(fp);
}



//;;

void
@open_microsoft_word_for_jira(str parameter = parse_str('/1=', mparm_str))
{

str fp = "Open Microsoft Word for Jira items.";

str filename = parameter;

if(filename == '')
{
  filename = @get_subject_or_selected_text;
}

if(@right(filename, 5) != '.docx')
{
  filename += '.docx'; 
}

str filepath = '%savannah%\work documents';

filepath = @resolve_environment_variable(filepath);

str fullfilepath = filepath + '\' + filename;

str application = "c:\\program files\\microsoft office\\office14\\winword.exe";

@run_application_2p(application, fullfilepath);

/* Use Cases

- 1. Use Case on Dec-12-2011: This file DOES already exist.
MT-4737

- 2. Use Case on Dec-12-2011: This file DOESN'T already exist.
MT-4751

*/

set_global_str('inner_status_message', fp);
@say(fp);
}



//;;

void
@add_text_return_double_q
{
str fp = 'Add text return and double q.';
@header;

@eol;
cr;
text("@say('" + @get_date + ": '); return(); //q" + "q");
cr;

@footer;
@say(fp);
}



//;;

void
@open_tmtp_file_old()
{
str fp = 'Create new message to phone file.';

//str Filename = Get_Environment('savannah') + '\reach out\Savannah Summary.txt';
//str filename[128] = Get_Environment('savannah') + '\reach out\text_message_to_phone.now';
rm("@open_file_with_writability /FN=" + Get_Environment('reach out') + "\\text_message_to_phone.now");

//rm('MakeWin /NL=1');
//if(file_exists(filename))
//{
//  return_str = filename;
//  rm('LdFiles'); // Load the file.
//  if(Error_Level != 0)
//  {
//    rm('meerror');
//  }
//}

}



//;;

void
@open_tmtp_file()
{
str fp = "Open J File with pasted text.";

//@header;

str filename[128] = Get_Environment('savannah') + '\reach out\text_message_to_phone.now';
@open_file(filename);
//@open_file('c:\!\j.txt');
//@select_all;
//delete_block;
//@paste;
//@bof;

//@footer;
@say(fp);
}



//;;

void
@@cursor_down_context_sensitive
{
@header;
@cursor_down_context_sensitive;
@footer;
}



//;

str
@small_arrow_space(str &regex_Description, str &rS)
{
str fp = "Small arrow.";
str sc = "»";
regex_Description = fp;
rs = "";
return(sc);
}



//;

str
@empty_rubric(str &regex_Description, str &rS)
{
str fp = "Empty rubric.";
str sc = '^;[^»].@$$$$^;';
//rs = ''
regex_Description = fp;
return(sc);
}



1.
<marriages crumble> See crumble defined 
for English-language learners Examples of CRUMBLE

2.
one published by a periodical c : discussion See symposium defined for English-language 
learners Examples of SYMPOSIUM

3.
- examination; especially : a general physical examination See checkup defined for 
English-language learners Examples of CHECKUP

4.
- a food rich in sugar: as a : a candied or crystallized fruit b : candy, confection See 
sweetmeat defined for English-language learners »



//;

void
@find_macro_names_containing_boo
{
str fp = "Find macro names containing bookend ampersands.";

str rs;
str sc;
str so;
int EFBO = true; // Execute First Block Only

@header;
sc = '@[a-z_A-Z^ ' + ']+\@';

rs = '\0';
@eol;

if(EFBO){ int Is_Found = @seek_in_all_files_2_arguments(sc, fp); EFBO = 0; }
if(EFBO){ @seek_next(sc, so); EFBO = false; }
if(EFBO){ so = @replace_next_occurrence_only(sc, rs); EFBO = 0; }
if(EFBO){ so = @replace_all_occurrences_no_tof(sc, rs); EFBO = 0; }

@footer;
@say(found_str);
@say(so);
@say(fp);
}



//;

void
@add_text_weekly_itinerary
{
str fp = 'Paste your weekly itinerary to its proper place.';
@header;

int active_window;
int temporary_refresh;
int temporary_window;
int kill_count;

@seek_in_all_files_simplest('!' + 'wrer');
goto_col(1);
cr;
cr;
cr;
up;
up;
up;

active_window = @current_window;
create_window;
file_name = '!! [] splice!!.tmp';
temporary_window = @current_window;
return_int = 0;
error_level = 0;
return_str = get_environment('reach out') + '\weekly_itinerary.bul';

set_global_int('load_count', 0);
rm("ldfiles /nws=1/lc=0/mc=1/nw=1/nc=1/pre=1/xl=1");
if(error_level != 0)
{
  rm('meerror^beeps /c=1');
  error_level = 0;
  fp = 'File not found, or error loading.';
}
else
{
  tof;
  block_begin;
  eof;
  block_end;
  switch_window(active_window);
  messages = false;
  window_copy(temporary_window);
  switch_window(temporary_window);
  delete_window;
  fp = '"' + file_name + '" inserted into file.';
  //@seek_next('q' + 'q', fp);
}
rm('setwindownames');
switch_window(active_window);
refresh = temporary_refresh;
return_int = 1;

@footer;
@say(fp);
}



//;

void
@add_rubric_at_chartreuse
{
str fp = "Add rubric at Chartreuse.";
@header;

@add_rubric@('ch');

@footer;
@say(fp);
}



//;;

void
@add_a_carriage_return_after_cl
{
str fp = "Add a carriage return after current line.";

@header;

eol;
cr;

@footer;
@say(fp);
}



//;;

void
@add_text_delete_file
{
str fp = 'Add text delete file.';
@header;

str so;
@seek_previous(':Delete', so);

@bol;

cr;
cr;
up;
up;
text(':Delete a single File.');
cr;
text('set file_to_delete=');
cr;
text('if exist "%savannah%\%file_to_delete%" del /ah /a /f "%savannah%\%file_to_delete%"');
cr;
text('if exist "%thumb_drive%\!savannah\%file_to_delete%" del /ah /a /f 
  "%thumb_drive%\!savannah\%file_to_delete%"');

up;
up;
eol;
@paste@;

@footer;
@say(fp + ' ' + so);
}



//;;

void
@add_text_travel_agent_prompted
{
str fp = 'Add text travel agent.';
@header;

@bol;
text('if(!@find_lc_ui(fp))');
cr;
text('{');
cr;
text('  return();');
cr;
text('}');
cr;

@footer;
@say(fp);
}



//;;

void
@add_text_return_statement
{
str fp = 'Add text return statement and so much more.';

@bol;
text("@say('hey now');");
text(" return();");
text(" //q" + "q");
cr;

@say(fp);
}



//;;

void
@add_text_shrinkster
{
str fp = 'Add Shrinkster text.';
@header;

text('http://www.shrinkster.com/');

@footer;
@say(fp);
}



//;;

void
@add_text_read_only
{
str fp = 'Add text read-only.';
@header;

text('if(@file_is_read_only(fp))');
cr;
text('{');
cr;
text('  return();');
cr;
text('}');
cr;

/* Use Case(s)

*/

@footer;
@say(fp);
}



//;;

void
@add_text_ray_bass
{
str fp = 'Add text Ray Bass.';
text('raybass7@gmail.com');
@say(fp);
}



//;;

void
@add_text_pretty_search_string
{
str fp = 'Add text pretty search string, you know the VALUE.';
text(global_str('pretty_sc'));
@say(fp);
}



//;;

void
@add_text_lc2
{
str fp = 'Add text lc as a parameter.';

@eol;
text("(str lc = parse_str('/1=', mparm_str))");

@say(fp);
}



//;;

void
@add_text_xs_function
{
str fp = 'Add text xsl function code.';

@bol;
cr;
up;

text('    <xsl:template name="">');
cr;
text('      <xsl:param name="sourceString" select="$sourceString"/>');
cr;
text('      <xsl:param name ="valueString" select="$valueString"/>');
cr;
text('    </xsl:template>');
cr;
cr;
cr;

up;
up;
up;
up;
up;
up;
eol;
left;
left;

@say(fp);
}



//;;

void
@add_text_xs_call
{
str fp = 'Add text xsl function call code.';

text('      <xsl:call-template name="">');
cr;
text('        <xsl:with-param name="sourceString" select="$sourceString"/>');
cr;
text('        <xsl:with-param name ="valueString" select="$valueString"/>');
cr;
text('      </xsl:call-template>');
cr;

up;
up;
up;
up;
eol;
left;
left;

@say(fp);
}



//;;

void
@add_text_fp
{
str fp = 'Add text for function purpose.';

text("  fp += ' Branch ");
@add_text_date@;
text(".';");

@say(fp);
}



//;;

void
@add_text_br_before_enbl()
{
str fp = 'Add text br before every nonblank line.';

if(!@is_text_file)
{
  return();
}

tof;
while(!at_eof)
{
  if(@trim@(@first_character(get_line)) != '')
  {
    @bol;
    cr;
    up;
    text('<br>');
    down;
  }
  down;
}

@say(fp);
}



//;

void
@search_answers_dot_com_with_hig
{
str fp = "Search answers dot com with highcopy_word_under_cursor.";

@highcopy_word_under_cursor;
@search_answers_dot_com@(@get_selected_text);

@say(fp);
}



//;+

void
@search_answers_dot_com@(str parameter = parse_str('/1=', mparm_str))
{
str fp = 'Search Answers.com';

str URL = 'http://www.answers.com/';

str sc = parameter;

if(sc == '')
{
  sc = @get_subject_or_selected_text;
}

str Pretty_sc = sc;

sc = @commute_character(sc, ' ', '+');

URL += sc;

int Browser_Number = 0;

//Browser_Number = 1;
Browser_Number = 2;
//Browser_Number = 3;
//Browser_Number = 4;
//Browser_Number = 5;

// I implemented this conditional because of the issue where Chrome is installed 
// at different locations on my home versus work computer.
if(@i_am_on_my_home_computer)
{
//  Browser_Number = 3;
}

@surf(URL, Browser_Number);

/* Use Case(s)

on the Q.T.

test line

test line. hey now

test line colon: hey now

test line period. hey now:

- animal life

- space station

*/

make_message(@trim_period(fp) + ' for "' + Pretty_sc + '".');
}



//;

void
@move_bullet_to_bor_old()
{
str fp = 'Move bullet to bor.';

@header;

mark_pos;
@highcopy_bullet@;
rm('CutPlus /M=1');
@find_next_big_segment;
@find_next_bullet;
goto_col(1);
rm('paste');
goto_mark;
@bob@;

@footer;

@say(fp);
}



//;;

void
@load_location_2()
{
// Used in conjuction with "@save_location_2".
str fp = "Load previous window's location.";
@switch_to_named_window@(Global_Str('Filename'));
pop_mark;
goto_mark;
}



//;;

void
@save_location_2()
{
// Used in conjuction with "@load_location_2".
mark_pos;
mark_pos;
Set_Global_Str('Filename', Truncate_Path(File_Name));
}



//;

void
@search_jira_using_the_object_cl
{
str fp = "Search jira using the object on current line.";

str sc = @hc_object;
@search_jira(sc);

@say(fp);
}



//;

void
@ride_the_bullet_bus
{
str fp = "Ride the bullet bus.";

// fdob: Apr-7-2014";

@header;

if(@exclamation_point_is_present())
{
  @move_bullet_to_appropriate_lc;
  return();
}
else
{
  @move_bullet_to_calendar;
}

@footer;
}



//;;

void
@rxx
{
str fp = "Parse and Analyze SJ.";

// fdob: Apr-9-2014";

int start_column = @get_sj_start_column(get_line);
int end_column = @get_sj_end_column(get_line, start_column);
//str trimmed_parameter = @left(get_line, sj_end_column);
//str trimmed_parameter = @left(get_line, 2);

//@say(str(end_column));
//@say(trimmed_parameter);
goto_col(@get_sj_cuttoff_column);
}



//;;

void
@go_to_sj_termination_col_for_cl
{
str fp = "";
fp = "Test harness for get_sj_termination_column.";
// fdob = Mar-25-2014 4:56 PM";

int column_truncation_number = @get_sj_termination_column(get_line);

goto_col(column_truncation_number);

@say(fp + ' Column terminator = ' + str(column_truncation_number));
}



//;+

int
@get_sj_termination_column_old(str raw_string)
{
int return_integer = 1000;
int position_of_termination_char = 0;
str fp = "";
fp = "Mar-25-2014 4:53 PM";
// fb = Mar-25-2014 4:56 PM";

str string_to_analyze = @trim_leading_colons_et_al(raw_string);

int length_of_leading_characters = @length(raw_string) - @length(string_to_analyze);

// Period
position_of_termination_char = xpos(char(46), string_to_analyze, 1);
if((position_of_termination_char > 0) && (position_of_termination_char < return_integer))
{
  // Email addresses don't count.
  if(@get_character_at_position(string_to_analyze, position_of_termination_char + 1) == ' ')
  {
    return_integer = position_of_termination_char;
  }
}

// Open Parenthesis
position_of_termination_char = xpos(char(40), string_to_analyze, 1);
if((position_of_termination_char > 0) && (position_of_termination_char < return_integer))
{
  return_integer = position_of_termination_char;
}

// Colon
position_of_termination_char = xpos(char(58), string_to_analyze, 1);
if((position_of_termination_char > 0) && (position_of_termination_char < return_integer))
{
  return_integer = position_of_termination_char;
}

// Question Mark
position_of_termination_char = xpos(char(63), string_to_analyze, 1);
if((position_of_termination_char > 0) && (position_of_termination_char < return_integer))
{
  return_integer = position_of_termination_char;
}

if(return_integer == 1000)
{
  return_integer = @length(string_to_analyze) + 1;
}

return_integer += length_of_leading_characters;

@say(fp);
return(return_integer);
}



//;

int
@is_sj_terminator_character(str character)
{

switch(character)
{
  case '.':
    if(@next_character == ' ')
    {
      return(true);      
    }
    return(false);
    break;
  case ':':
  case '(':
    return(true);
    break;
}
return (false);
}



//;;

str
@remove_nonmeaningful_term_chars(str parameter)
{
str fp = "Remove nonmeaningful terminatining characters.";

// fdob = Mar-28-2014 2:21 PM";

parameter = @trim_trailing_spaces(parameter);

parameter = @trim_period(parameter);

parameter = @trim_after_character(parameter, "lk#");

parameter = @trim_trailing_spaces(parameter);

parameter = @trim_period(parameter);

@say(fp);
return(parameter);
}



//;;

void
@compare_lc_for_bullet_old
{
str fp = "Determine if parent bullet is the one with the largest lookup counter in this 
  bullet.";

if(!@is_bullet_or_subbullet)
{
  return();
}

@header;

int current_line_lk_number = 0;
int number_of_lines_to_search;
int starting_line_lk_number;

@bob@;

int first_line_in_bullet = @current_line;

int number_of_lines_in_bullet = @count_lines_in_bullet;

if(find_text(@lookup_counter, 1, _regexp))
{
  starting_line_lk_number = @get_lk_number_uc;
  down;
}
else
{
  fp += ' NO lookup counters found.';
  @say(fp);
  @footer;
  return();
}

while(starting_line_lk_number >= current_line_lk_number)
{
  number_of_lines_to_search = number_of_lines_in_bullet - (@current_line - 
    first_line_in_bullet);
  if(find_text(@lookup_counter, number_of_lines_to_search, _regexp))
  {
    current_line_lk_number = @get_lk_number_uc;
    if(current_line_lk_number > starting_line_lk_number)
    {
      fp += ' Found greater lc.';
      break;
    }
    else
    {
      down;
    }
  }
  else
  {
    fp += ' It is.';
    @bob@;
    break;
  }
}

@footer;
@say(fp);
}



//;

void
@rxx
{
str fp = "";
fp = "Mar-25-2014 5:52 PM";
// fdob = Mar-25-2014 5:52 PM";
//x x

str string_to_analyze = get_line;
int position_of_termination_char = 0;
int return_integer = 0;
str char_at_position;

// Period
int position_of_termination_char = xpos(char(46), string_to_analyze, 1);
if((position_of_termination_char > 0) && (position_of_termination_char < return_integer))
{
  // Email addresses don't count.
  char_at_position = @get_character_at_position(string_to_analyze, position_of_termination_char);
  if(char_at_position == '.')
  {
    return_integer = position_of_termination_char;
  }
}

char_at_position = @get_character_at_position(string_to_analyze, 4);

@say("'" + @get_character_at_position(get_line, 2) + "'");
@say("'" + char_at_position + "'");
}



//;

str
@get_character_at_position(str input_string, int key_position)
{
str fp = "Get character at a certain position of a passed in string.";
fp = "Mar-25-2014 5:52 PM";
// fdob = Mar-25-2014 5:52 PM";

str return_string = str_del(input_string, key_position + 1, 1000);
return_string = str_del(return_string, key_position - 1, 1);
return(return_string);
}



//;

void
@go_to_mor
{
str fp = 'Go to the middle of current rubric.';

if(!@is_bullet_file)
{
  return();
}

@header;

@bobs@;

int Number_of_Bullets_in_Rubric = @count_bullets;
int Counter = 0;
while(Counter < (Number_of_Bullets_in_Rubric / 2))
{
  @find_next_bullet;
  Counter++;
}

@footer;
@say(fp);
}



//;;

void
@add_text_quarterly_itinerary_old
{
str fp = 'Paste your quarterly itinerary to its proper place.';
@header;

int Active_Window;
int temporary_refresh;
int Temporary_Window;
int kill_count;

@bob@;
cr;
up;

Active_Window = @current_window;
create_window;
file_name = '!! [] splice!!.tmp';
Temporary_Window = @current_window;
return_int = 0;
error_level = 0;
return_str = get_environment('reach out') + '\quarterly itinerary.bul';

set_global_int('load_count', 0);
rm("ldfiles /nws=1/lc=0/mc=1/nw=1/nc=1/pre=1/xl=1");
if(error_level != 0)
{
  rm('meerror^beeps /c=1');
  error_level = 0;
  fp = 'File not found, or error loading.';
}
else
{
  tof;
  block_begin;
  eof;
  block_end;
  switch_window(Active_Window);
  messages = false;
  window_copy(Temporary_Window);
  switch_window(Temporary_Window);
  delete_window;
  fp = '"' + file_name + '" inserted into file.';
}
rm('setwindownames');
switch_window(Active_Window);
refresh = temporary_refresh;
return_int = 1;

@footer;
@say(fp);
}



//;;

void
@add_text_monthly_itinerary_old
{
str fp = 'Paste your monthly itinerary to its proper place.';
@header;

int Active_Window;
int temporary_refresh;
int Temporary_Window;
int kill_count;

@bob@;

cr;

up;

Active_Window = @current_window;
create_window;
file_name = '!! []] splice!!.tmp';
Temporary_Window = @current_window;
return_int = 0;
error_level = 0;
return_str = get_environment('reach out') + '\monthly_itinerary.bul';

set_global_int('load_count', 0);
rm("ldfiles /nws=1/lc=0/mc=1/nw=1/nc=1/pre=1/xl=1");
if(error_level != 0)
{
  rm('meerror^beeps /c=1');
  error_level = 0;
  fp = 'File not found or error loading.';
}
else
{
  tof;
  block_begin;
  eof;
  block_end;
  switch_window(Active_Window);
  messages = false;
  window_copy(Temporary_Window);
  switch_window(Temporary_Window);
  delete_window;
  fp = '"' + file_name + '" inserted into file.';
}
rm('setwindownames');
switch_window(Active_Window);
refresh = temporary_refresh;
return_int = 1;

@footer;
@say(fp);
}



//;;

void
@look_up_information_in_a_csw
{
str fp = "Look up information in a context sensitive way.";
@header;

if(@is_subbullet)
{
  @look_up_bullet_information;
  return();
}

if(@is_bullet@)
{
  @look_up_bullet_information;
  return();
}

if(@is_rubric@)
{
  @look_up_rubric_information;
  return();
}

if(@is_big_segment)
{
  @look_up_bs_information;
  return();
}

@footer;
@say(fp);
}



//;;

void
@@open_file_oceanfront
{
@header;
@open_file_oceanfront;
@footer;
}



//;+

int
@open_file_oceanfront()
{
str fp = 'Switch to window Oceanfront.bul.';

switch(@lower(Get_Environment("ComputerName")))
{
  case "jam-d820":
  case "jrj-hp2":
  case "vaio":
    break;
  default:
    @switch_to_task_window;
    @say("I don't want this function to work on my laptop, so instead switched to Universal 
      Window.");
    return(0);
}

rm("@open_file_with_writability /FN=" + Get_Environment('reach out') + "\\Oceanfront.bul");

goto_line(3);
eol;

@say(fp);
return(1);
}



//;;

void
@run_clif_from_multiedit_diag(str lc = parse_str('/1=', mparm_str))
{

/*
Deprecated on Jan-20-2014. Going forward, please use Use @quick_launcher_router.

Because this method has calls to the methods @header and @footer, it should NOT be called by
other macros. For that purpose use "@run_clif_internally".
*/

str fp = 'Run Clif from the Multi-Edit commands dialogue box using known launch code "' + 
  lc + '".';

// Status bar version shortened version.
fp = 'Run Clif from dialogue using launch code "' + lc + '".';

@header;

@save_location;

if(!@find_lc_known(fp, lc))
{
  @footer;
  return();
}

str Operation_Outcome;
@run_clif_under_cursor(Operation_Outcome);

@load_location;

@footer;
@say(fp);
}



//;;

void
@run_launch_code_again
{
str fp = 'Run launch code again.';
@header;
@run_clif_internally(global_str('lc'));
@footer;
@say(fp);
}



//;;

void
@@rcc_wrapper(str compositional_string = parse_str('/1=', mparm_str))
{
@header;
@rcc_wrapper(compositional_string);
@footer;
}



//;;

void
@rcc_wrapper(str compositional_string = parse_str('/1=', mparm_str))
{
str fp = 'Run clif compositionally wrapper.';
@save_location
int return_home = 1;
int show_outer_status_message = 1;
if(compositional_string == '')
{
  compositional_string = Global_Str('rcc_user_input');
}
@run_clif_compositionally(compositional_string, return_home, fp, show_outer_status_message, 
  1); 
}



//;;

void
@move_bullet_to_cj
{
str fp = 'Move bullet to its respective overflow rubric.';

int return_home = 1;

if(!@is_bullet_File)
{
  return();
}

if(!@is_bullet_or_subbullet)
{
  return();
}

@header;

int Initial_Window = cur_Window;
int Search_Criterion_Was_Found;
str Destination_lc = '';

Destination_lc = 'cj';

int Current_Line_Number = 0;

if(return_home == 1)
{
  mark_pos;
}

Current_Line_Number = @current_line_number;
@cut_bullet;

if(!@find_lc_known(fp, Destination_lc))
{
  switch_window(Initial_Window);
  rm('paste');
  fp += ' Error: Cannot find known launch code.';
}
else
{
  if(@file_is_read_only(fp))
  {
    switch_window(Initial_Window);
    rm('paste');
    fp += ' Error: File is read-only.';
  }
  else
  {
    @paste_after@;
    fp += ' (' + Destination_lc + ')';
    if(return_home == 1)
    {
      switch_window(Initial_Window);
      goto_mark;
      @bob@;
      @boca;
      if(@current_line_type == 'rubric')
      {
        @find_next_bullet;
      }
    }
  }
}

@footer;

@say(fp);
}



//;+

void
@move_bullet_down_4_bullets@
{
str fp = 'Move bullet down 4 bullets.';

if(!@is_bullet_file)
{
  return();
}

@header;

mark_pos;
@cut_bullet;
@find_next_bullet;
@find_next_bullet;
@find_next_bullet;
@find_next_bullet;
@find_next_bullet;
@find_next_bullet;
@bol;
@paste@;
goto_mark;

@footer;
@say(fp);
}



//;;

void
@move_bullet_down_4_bullets_wme
{
str fp = 'Move bullet down 4 bullets with me.';

if(!@is_bullet_file)
{
  return();
}

@header;

@cut_bullet;
@find_next_bullet;
@find_next_bullet;
@find_next_bullet;
@find_next_bullet;
@bol;
@paste@;

@footer;
@say(fp);
}



//;;

void
@move_bullet_down_8_bullets@
{
str fp = 'Move bullet down 8 bullets.';

if(!@is_bullet_file)
{
  return();
}

@header;

mark_pos;
@cut_bullet;
@find_next_bullet;
@find_next_bullet;
@find_next_bullet;
@find_next_bullet;
@find_next_bullet;
@find_next_bullet;
@find_next_bullet;
@find_next_bullet;
@bol;
@paste@;
goto_mark;

@footer;
@say(fp);
}



//;;

void
@move_bullet_down_8_bullets_wme
{
str fp = 'Move bullet down 8 bullets with me.';

if(!@is_bullet_file)
{
  return();
}

@header;

@cut_bullet;
@find_next_bullet;
@find_next_bullet;
@find_next_bullet;
@find_next_bullet;
@find_next_bullet;
@find_next_bullet;
@find_next_bullet;
@find_next_bullet;
@bol;
@paste@;

@footer;
@say(fp);
}



//;;

void
@move_bullet_to_cj
{
str fp = 'Move bullet to its respective destination rubric.';

int return_home = 1;

if(!@is_bullet_File)
{
  return();
}

if(!@is_bullet_or_subbullet)
{
  return();
}

@header;

int Initial_Window = cur_Window;
int Search_Criterion_Was_Found;
str Destination_lc = '';

Destination_lc = 'cj';

int Current_Line_Number = 0;

if(return_home == 1)
{
  mark_pos;
}

Current_Line_Number = @current_line_number;
@cut_bullet;

if(!@find_lc_known(fp, Destination_lc))
{
  switch_window(Initial_Window);
  rm('paste');
  fp += ' Error: Cannot find known launch code.';
}
else
{
  if(@file_is_read_only(fp))
  {
    switch_window(Initial_Window);
    rm('paste');
    fp += ' Error: File is read-only.';
  }
  else
  {
    @paste_after@;
    fp += ' (' + Destination_lc + ')';
    if(return_home == 1)
    {
      switch_window(Initial_Window);
      goto_mark;
      @bob@;
      @boca;
      if(@current_line_type == 'rubric')
      {
        @find_next_bullet;
      }
    }
  }
}

@footer;

@say(fp);
}



//;

void
@move_bullet_down_4_bullets_wme
{
str fp = 'Move bullet down 4 bullets with me.';

if(!@is_bullet_file)
{
  return();
}

@header;

@cut_bullet;
@find_next_bullet;
@find_next_bullet;
@find_next_bullet;
@find_next_bullet;
@bol;
@paste@;

@footer;
@say(fp);
}



//;+ Move Bullets Family



//;;

void
@move_bullet_down_4_bullets@
{
str fp = 'Move bullet down 4 bullets.';

if(!@is_bullet_file)
{
  return();
}

@header;

mark_pos;
@cut_bullet;
@find_next_bullet;
@find_next_bullet;
@find_next_bullet;
@find_next_bullet;
@find_next_bullet;
@find_next_bullet;
@bol;
@paste@;
goto_mark;

@footer;
@say(fp);
}



//;;

void
@move_bullet_down_8_bullets_wme
{
str fp = 'Move bullet down 8 bullets with me.';

if(!@is_bullet_file)
{
  return();
}

@header;

@cut_bullet;
@find_next_bullet;
@find_next_bullet;
@find_next_bullet;
@find_next_bullet;
@find_next_bullet;
@find_next_bullet;
@find_next_bullet;
@find_next_bullet;
@bol;
@paste@;

@footer;
@say(fp);
}



//;;

void
@move_bullet_down_8_bullets@
{
str fp = 'Move bullet down 8 bullets.';

if(!@is_bullet_file)
{
  return();
}

@header;

mark_pos;
@cut_bullet;
@find_next_bullet;
@find_next_bullet;
@find_next_bullet;
@find_next_bullet;
@find_next_bullet;
@find_next_bullet;
@find_next_bullet;
@find_next_bullet;
@bol;
@paste@;
goto_mark;

@footer;
@say(fp);
}



//;;

str
@convert_line_to_proper_cs_old()
{
str fp = 'Convert line to proper case, old version.';

int current_Column;
int length_of_Word_Chunk;
int loop_Counter;

str word_Chunk = '';
str line_Product = '';
str current_Line = get_line;

mark_pos;
goto_col(1);

while(!at_eol)
{
  word_Chunk = get_word(word_delimits);
  if(length(word_Chunk))
  {
    word_Chunk = caps(str_char(word_Chunk, 1)) + lower(str_del(word_Chunk, 1, 1));
    length_of_Word_Chunk = length(word_Chunk);
    if(length_of_Word_Chunk > 1)
    {
      for(loop_Counter = 2; loop_Counter < length_of_Word_Chunk; loop_Counter++)
      {
        if(str_char(word_Chunk, loop_Counter) == '_')
        {
          word_Chunk = copy(word_Chunk, 1, loop_Counter) + caps(str_char(word_Chunk, 
            loop_Counter + 1)) + copy(word_Chunk, loop_Counter + 2, 
            length_of_Word_Chunk - loop_Counter - 1);
        }
      }
    }
  }
  else
  {
    current_Column = c_col;
    word_right;
    word_Chunk += Copy(current_Line, current_Column, c_col - current_Column);
  }
  line_Product += word_Chunk;
}
put_line(line_Product);
goto_mark;

@say(fp);
return(line_Product);
}



//;;

void
@load_clipboard_with_bullet_cont(str lc = parse_str('/1=', mparm_str))
{
str fp = "Set clipboard with bullet type content.";
@header;
@save_location;

if(!@find_lc_known(fp, lc))
{
  @footer;
  return();
}

@highcopy_bullet_content_dinc;

@load_location;

@footer;

@say(fp);
}



//;;

void
@set_clipboard_discreetly(str sc = parse_str('/1=', mparm_str))
{
str fp = "Set clipboard text.";
// This trick entail overwriting the status bar.
@set_clipboard(sc);
set_global_str('inner_status_message', fp);
@say(fp);
}



//;;

void
@perform_custom_lc_processing_2(str lc)
{
str fp = "Perform custom processing per launch code.";

switch(lc)
{
  case 'jdxx':
    break;
  default:
    if(@first_character_in_line == ";")
    {
      @seek_next(@bullet, fp);
    }
    eol;
    break;
}
//@say(fp);
}



//;;

str
@highcopy_precolon_phrase()
{
str fp = 'Highlight and copy the precolon portion of the current area type.';
str rv = 'Returns the highlighted text.';

@eoc;
str_block_begin;

while((@current_Character != ':') and (!at_eol))
{
  right;
}

block_end;

@copy_with_marking_left_on;

@say(fp);
return(@get_selected_text);

/* Use Case(s)

- 2. Use Case on Jan-4-2012:
;+ MT-4596: Text Level Sourcing: MT-4596

- 1.
tesext2: hey

*/
}



//;;

void
@copy_and_paste_postcolon_phrase()
{
str fp = "Copy and paste postcolon phrase and turn it into a child subbullet.";

if(!@is_bullet_File)
{
  return();
}

if(!@is_bullet_or_subbullet)
{
  return();
}

@header;

str Colon_Or_Not = '';

if(@is_bullet@)
{
  Colon_Or_Not = ':';
}

if(@is_bullet@)
{
  fp += ' Branch 1.';
  @copy_and_paste_small_segment;
}
else
{
  fp += ' Branch 2.';
  @copy_and_paste_subbullet; 
}

@highcopy_sj;

@delete_block;
right;
@delete_character;
@eol;

@footer;

@say(fp);
}



//;;

str
@hc_object()
{
// Note: This actually meant multiline object.
str fp = 'Highcopy OJ.';
str rv = 'Returns the highlighted text.';

@boca;
@eoc;


while(@current_character != ':')
{
  right;
  if(@current_column == 80)
  {
    fp += ' Error: No colon found in current line.';
    eol;
    @say(fp);
    return('');
  }
}

right;
right;

str_block_begin;

right;

do
{
  down;
} while(remove_space(get_line) != '');

@bol;
left;
block_end;

@copy_with_marking_left_on;

/* Use Case(s)

- 2. Use Case on Jan-4-2012:

- MT-4596 File of interest 3: c:\tortoise\vpd\dataaccessobjects\
sourcelist.cs

- 1. Use Case on Dec-29-2011:

- test: high

*/
return(@get_selected_text);
}



//;; (skw @add_bullet_at_lc_ui, @add_bullet_at_lc)

void
@add_bullet_at_ui_lc(str lc = parse_str('/1=', mparm_str))
{
str fp = 'Add bullet at user inputted launch code.';
@header;

if(!@find_lc_known(fp, lc))
{
  @footer;
  return();
}

@add_bullet_below;

@say(fp);
@footer;
}



//;;

void
@add_bullet_at_double_q
{
str fp = 'Add bullet at double q.';
@header;

@add_bullet_at_known_lc('q' + 'q');

@footer;
@say(fp);
}



//;;

void
@add_bullet_at_end_of_now
{
str fp = "Add bullet at end of now.";
@header;

str sc = 'n';

@find_lc_known(fp, sc);
@add_bullet_at_eor;

@footer;
@say(fp);
}



//;;

void
@add_bullet_at_now
{
str fp = 'Add bullet at now.';

@header;

@find_lc_known(fp, 'n');
@add_bullet_below;

@footer;
}



//;;

void
@@add_bullet_at_bof
{
@header;
@add_bullet_at_bof;
@footer;
}



//;;

void
@add_bullet_at_bof()
{
str fp = 'Add bullet at BOF.';

if(!@is_bullet_file)
{
  return();
}

tof;
@find_next_blank_line;
cr;
cr;
up;
text(':');

@say(fp);
}



//;;

void
@@add_bullet_at_task_window
{
@header;
@add_bullet_at_task_window;
@footer;
}



//;;

void
@add_bullet_at_task_window()
{
str fp = 'Add bullet at task window.';

block_off;

// This means that, wherever I am, be it at home, at work, I want to add a bullet at the
// appropriate place. When I am at home that means this macro needs to figure out
// whether or not I have the conch. If I am at work, this macro needs to figure out
// which machine I am on an add the bullet at the appropriate place.
insert_mode=1;

if(@switch_to_task_window == 0)
{
  return();
}

@add_bullet_at_bof;

@say(fp);
}



//;;

void
@add_text_blank_url_at_junk
{
str fp = 'Add blank browser text.';
@header;

@add_bullet_at_task_window;

text('http://www..com');
left;
left;
left;
left;

@footer;
@say(fp);
}



//;;

void
@add_bullet_at_jd
{
str fp = "Add bullet at JD.";
@header;

@add_bullet_at_known_lc('jd');

@footer;
@say(fp);
}



//;;

void
@delete_commented_lines()
{
str fp = 'Delete commented lines from file.';
str sc = '^[\*/]';
int test = @delete_matching_lines(sc);
}



//;

int
@replace_with_double_quotes_if()
{
str fp = 'Replaces characters 147 and 148 with double quotes.';

int Number_of_Replacements = 0;
Number_of_Replacements = @replace_string_in_file_int(char(147), char(34));
Number_of_Replacements += @replace_string_in_file_int(char(148), char(34));
fp = 'Number of replacements = ' + str(Number_of_Replacements);

@say(fp);
return(Number_of_Replacements);
}



//;

void
@cursor_down_1_line()
{
str fp = 'Cursor down one line.';

down;

//if(@previous_character == ';')
//{
//  left;
//}

@say(fp);
}



//;

void
@@find_next_bsr
{
@header;
@find_next_bsr;
@footer;
}



//;

str
@trim_string_after_colon@(str string)
{
// Colon
int Position_of_Termination_Char = xpos(char(58), String, 1);
String = str_del(String, Position_of_Termination_Char, 999);

String = @trim@(String);

return(String);
}



//;

void
@add_text_cj_launch_code
{
str fp = "Add text cj launch code.";

eol;
left;
while(@current_character != ':')
{
  left;
}
text(' (!' + 'cj)');

@say(fp);
}



//; (skw @search_encarta)

void
@search_msn_dictionary(str parameter = parse_str('/1=', mparm_str))
{
str fp = 'Search MSN dictionary.';

str URL =
'http://encarta.msn.com/encnet/features/dictionary/DictionaryResults.aspx?search=';

/*

 http://uk.encarta.msn.com/encnet/features/dictionary/dictionaryhome.aspx

separable

 http://encarta.msn.com/encnet/features/dictionary/DictionaryResults.aspx?lextype=3&search=
partisan
*/

str sc = parameter;

if(sc == '')
{
  sc = @get_ss;
}

URL += sc;

@surf(url, 3);

/* Use Case(s)

- emulate

- onomatopoeia

- empty sella syndrome

*/

make_message(@trim_period(fp) + ' for "' + sc + '".');
}



//;

void
@switch_to_named_window_gci
{
str fp = "Switch to named window GCI.";

@header;

rm('@switch_to_named_window /1=gci.bul');
@cursor_to_initial_file_open_pos;

@footer;
@say(fp);
}



@switch_to_named_window@@switch_to_named_window@//;; content_sensitive = true;

void
@find_next_big_thing()
{
str fp = 'Find next big thing.';

@header;

if(@is_big_segment)
{
  @find_next_rubric;
}
else
{
  @find_next_bobs;
}
@footer;
@say(fp);
}



//;;

void
@append_bullet_family_to_eocb
{
str fp = "Append bullet family to end of current bullet.";
@header;

if(!@is_bullet_file)
{
  return();
}

@find_next_bullet;
@find_previous_bullet_or_subbull;
@paste_after_with_subbullet;

@footer;
@say(fp);
}



//;; content_sensitive = true;

void
@find_previous_big_thing
{
str fp = 'Find previous big thing.';

@header;

if(@is_big_segment)
{
  @find_bor_or_previous_rubric;
}
else
{
  @find_previous_bobs;
}
@footer;
@say(fp);
}



//;

str
@load_clipboard_by_reflecting_fn
{
str fp = "Load clipboard by reflecting on full file path.";

set_global_str('cmac_return_value', file_name);
return(file_name);
@say(fp);
}



//;

void
@paste_before_first_bullet()
{
str fp = 'Paste block to before first bullet.';

@find_next_bullet;
goto_col(1);
rm('paste');

@say(fp);
}



//;

int
@is_last_segment()
{
str fp = 'True if the user is on the last bullet or subbullet of a rubric.';

if(@peek_ahead_2 == 'rubric')
{
  @say('You are on the last segment.');
  return(1);
}

@say('You are not on the last segment.');
return(0);
}



//;

void
@add_link
{
str fp = "Add link.";
@header;

@find_lc_known(fp, 'l');
@add_bullet_below;
text('http://www.');

@footer;
@say(fp);
}



//;;

void
@@find_previous_rubric
{
@header;
@find_previous_rubric;
@footer;
}



//;; Deprecated: Please use @@find_bor_or_previous_rubric. Jul-12-2012

void
@find_previous_rubric()
{
str fp = 'Find previous rubric.';

if(!@is_rubric_file)
{
  return();
}

int Current_Line_Number = @Current_Line_Number;
@bor@;

// We have't moved up, therefore the user wants to go somewhere right? They're not
// just hitting keys.
if(Current_Line_Number == @Current_Line_Number)
{
  up;
  @bor@;
}
if(Current_Line_Number == @Current_Line_Number)
{
  fp += ' You are at the first rubric.';
}
@say(fp);
}



//;

void
@make_folder_readonly(str fullPath = parse_str('/1=', mparm_str))
{
str fp = "Make folder read-only.";

str path_Only = @strip_off_filename(fullPath);

@open_folder@(path_Only);

@say(fp);
}



//;+

void
@find_boss_location
{
str fp = "Find boss location.";

@header;
@find_lc_known(fp, "c");
@find_next_bullet;
@footer;

@say(fp);
}



//;

void
@move_rubric_to_saic_eof
{
str fp = "Move rubric to SAIC eof.";
@header;

@cut_big_segment;

rm('@Switch_To_Named_Window@ /1=SAIC.bul');
@eof;
@bol;

@paste@;

@footer;
@say(fp);
}



//;;

void
@add_rubric_to_graveyard
{
str fp = "Add the current rubric to the rubric graveyard.bul.";

if(!@is_bullet_file)
{
  return();
}

@header;

@save_location;

@cut_big_segment;

rm("@open_file_with_writability /FN=" + Get_Environment('savannah') +
  "\\reach out\\rubric graveyard.bul");

@bof;

@paste@;

@close_and_save_file_wo_prompt;

@load_location;

@bobs@;

@footer;
@say(fp);
}



//;

void
@search_automatedly
{
str fp = 'Search automatedly.';
str rs;
str sc;
str so;
@header;

right;
sc = 'lk\#2';
rs = '\0';
//@seek_next(sc, so);
//so = @replace_next_occurrence_only(sc, rs);
//so = @replace_all_occurrences_in_file(sc, rs);
int Is_Found = @seek_in_all_files_2_arguments(sc, fp);
//so = @seek_with_case_sensitivity(sc, so);

@footer;
@say(so);
}



//;

void
@tab_left_from_anywhere
{
str fp = 'Tab left from anywhere on the line.';
@header;

mark_pos;
@bol;
if(@current_character == ' ')
{
  @delete_character;
}
if(@current_character == ' ')
{
  @delete_character;
}
goto_mark;
if(@current_column != 1)
{
  left;
}
if(@current_column != 1)
{
  left;
}

/* Use Case(s)

test

*/

@footer;
@say(fp);
}



//;

void
@tab_right_from_anywhere
{
str fp = 'Tab right from anywhere on the line.';
@header;

mark_pos;
@bol;
text('  ');
goto_mark;
right;
right;

@footer;
@say(fp);
}



//;

str
@upper_case_first_character(str my_Line)
{
str fp = "Capitalize first character in passed in string.";

str fp = 'Convert first character to upper case.';
str Current_Line = my_Line;
str First_Character = caps(@first_character(Current_Line));
Current_Line = @trim_first_character(Current_Line);
my_Line = First_Character + Current_Line;
return(my_Line);

@say(fp);
}



//;;

void
@delete_word_from_middle
{
str fp = 'Delete word, when the cursor is on the middle of the word.';
@header;

str @previous_character = copy(get_line, c_col - 1, 1);

while(@is_alphanumeric_character(@previous_character) && (c_col != 1))
{
  left;
  @previous_character = copy(get_line, c_col - 1, 1);
}

str_block_begin;
get_word(word_delimits);
block_end;

delete_block;

/* Use Case(s)

I am a variable ('blah')

*/

@footer;
@say(fp);
}



//;

str
@lower_case_first_character(str my_Line)
{
str fp = "Lower case first character in passed in string.";

str fp = 'Convert first character to lower case.';
str Current_Line = my_Line;
str First_Character = @lower(@first_character(Current_Line));
Current_Line = @trim_first_character(Current_Line);
my_Line = First_Character + Current_Line;
return(my_Line);

@say(fp);
}



//;

str
@is_mismatched_file(str actual, str required)
{
str em = '';
if(Actual != Required)
{
  em = 'This macro only works on "' + Required + '" type files.';
  @say(em);
}
return(em);
}



//;

void
@aliases_say_version
{
str fp = "Aliases.s v. Mar-9-2010.";

@say(fp)
}



//;;

str
@lcase(str string)
{
return(lower(string));
}



//;+ (skw ucase, upper)

str
@convert_to_uppercase(str string)
{
return(caps(string));
}



//; (skw lcase)

str
@convert_to_lowercase(str string)
{
return(lower(string));
}



//;; (skw convert_line_to_low)

void
@convert_lob_to_lowercase()
{
str fp = 'Convert line or selected text to lower case.';
str sc;

if(@text_is_selected)
{
  // Note: Due to the shortcoming of the Clif architecture, this block will only work when
  // using the Ctrl+Shift+L key combination and NOT the !+cl launch code.
  sc = copy(get_line, block_col1, block_col2 + 1 - block_col1);
  delete_block;
  sc = lower(sc);
  text(sc);
}
else
{
  put_line(lower(get_line));
}

/* Use Case(s)

xxfp

*/

@say(fp);
}



//;;

void
@convert_line_to_nonsentence
{
str fp = "Convert current line to a non-sentence.";
@header;

@eoc;
str First_Character = @first_character_in_line;
First_Character = @lower(First_Character);
//Current_Line = @trim_first_character(Current_Line);
//Current_Line = First_Character + Current_Line;
del_line;
cr;
up;
//put_line(Current_Line);

/* Use Case - Jan-23-2011

find the key

*/

@footer;
@say(fp);
}



//;;

void
@add_text_f3_string
{
str fp = "Add text 'F3' string.";
@header;

@eoc;
text(global_str('search_str'));

@footer;
@say(fp);
}



//;;

str
@convert_sentence_to_fun_name_2
{
str fp = 'Convert sentence to function name 2. Remove space and use proper case.';

@convert_line_to_proper_case;
str Current_Line = get_line;
Current_Line = @commute_character(Current_Line, ' ', '');
Current_Line = @commute_character(Current_Line, ',', '');
Current_Line = @trim_after_character(Current_Line, '.');

put_line(Current_Line);
@eol;
@highcopy_word_under_cursor;

@say(fp);
}



//;

void
@load_searcher
{
str fp = "Load the searcher macro.";
@say(fp)
}



//;

void
@load_listmgr
{
str fp = "Load the ListMgr macro.";
@say(fp)
}



//;;

void
@@add_bullet_below
{
@header;
@add_bullet_below;
@footer;
}



//;;

void
@add_bullet_below()
{
str fp = 'Add bullet below. This enforces the requirement that bullets are never inserted
before subbullets.';

if(!@is_bullet_file)
{
//  eol;
//  cr;
//  return();
}

insert_mode=1;

right;
switch(@peek_ahead())
{
  case 'bullet':
    @find_next_bullet;
    @bol;
    cr;
    cr;
    up;
    up;
    text(':');
    eol;
    fp += 'Found bullet.';
    break;
  case 'rubric':
    @find_next_big_segment;
    fp = 'Found rubric.';
    up;
    up;
    cr;
    up;
    cr;
    up;
    text(':');
    break;
}

@say(fp);
}



//;;

void
@add_text_update_aff_and_inotes
{
str fp = 'Add text update Affinity and iNotes.';
@header;

@bol;
text(':Update Affinity.');
cr;
cr;
text(':Update iNotes.');
cr;
cr;
@find_previous_bullet@;

@footer;
@say(fp);
}



//;;

void
@add_text_update_inotes
{
str fp = 'Add text update iNotes.';
@header;

@bol;
text(':Update iNotes.');
cr;
cr;
@find_previous_bullet@;

@footer;
@say(fp);
}



//;;

void
@add_text_update_aff
{
str fp = 'Add text update affinity files and iNotes.';
@header;

@bol;
text(':Update Aff.');
cr;
cr;
@find_previous_bullet@;

@footer;
@say(fp);
}



//;

void
@go_to_the_last_bullet_in_rub
{
str fp = "Go to the last bullet in the rubric.";

if(!@is_bullet_file)
{
  return();
}

@header;

@find_next_big_segment;

@find_previous_bullet@;

@footer;
@say(fp);
}



//;;

int
@bob@()
{
str fp = 'Go to beginning of bullet.';

while(!@at_bof)
{
  if(@bobsr == 'bullet')
  {
    return(1);
  }
  else
  {
    up;
  }
}

@say(fp + ' Bullet NOT found.');
return(0);
}



//;;

void
@move_up_old()
{
str fp = 'Move bullet or line up.';

if(@current_line_type == '')
{
  fp = 'Move line up.';
  @move_line_up;
  @footer;
  return();
}

if(@is_bullet_file)
{
  @boca;
}

@bobsr;
if(@current_line_number == 3)
{
  @say('You are ALREADY the first bullet in the file.');
  @footer;
  return();
}

int Is_First_Bullet_in_Rubric = false;
str Query_Previous_BSR;

if(@query_previous_bsr == 'rubric')
{
  Is_First_Bullet_in_Rubric = true;
}

str current_area_type = @current_area_type;

switch(@current_area_type)
{
  case 'bullet':
    fp = 'Move bullet up.';
    @cut_bullet;
    @find_previous_bullet@;
    break;
  case 'subbullet':
    @cut_subbullet;
    @find_previous_bs@;
    break;
  default:
    @say(fp + ' This macro only works with bullets or subbullets.');
    @footer;
    return();
}

if(Is_First_Bullet_in_Rubric)
{
  up;
  up;
}
else if((Query_Previous_BSR == 'rubric') and (!Is_First_Bullet_in_Rubric))
{
  // Don't cross the rubric because you're not the first element, but rather the second
  // element.
  @find_previous_bsr;
}

@bol;
@paste@;

switch(current_area_type)
{
  case 'bullet':
    fp = 'Move bullet up.';
    @find_previous_bullet@;
    break;
  case 'subbullet':
    @find_previous_subbullet;
    break;
  default:
    @say(fp + ' This macro only works with bullets or subbullets.');
    return();
}

eol;

@say(fp);
}



//; (skw special processing, special_processing)

void
@perform_custom_lc_process1(str lc = parse_str('/1=', mparm_str))
{
str fp = "Perform custom processing per launch code.";

// What do I call this feature? Auto-Rubric-Population? (skw January) (!arpo)
switch(lc) //qcq
{
  case 'apr':
    @go_to_mor;
    @add_bullet_below;
    text('Apr-');
    break;
  case 'aug':
    @go_to_mor;
    @add_bullet_below;
    text('Aug-');
    break;
  case 'dec':
    @go_to_mor;
    @add_bullet_below;
    text('Dec-');
    break;
  case 'diar':
    @add_bullet_below;
    @add_text_date@;
    break;
  case 'edit':
    @add_bullet_below;
    cr;
    @add_text_multiedit;
    break;
  case 'feb':
    @go_to_mor;
    @add_bullet_below;
    text('Feb-');
    break;
  case 'jan':
    @go_to_mor;
    @add_bullet_below;
    text('Jan-');
    break;
  case 'jun':
    @go_to_mor;
    @add_bullet_below;
    text('Jun-');
    break;
  case 'jul':
    @go_to_mor;
    @add_bullet_below;
    text('Jul-');
    break;
  case 'l':
    @add_bullet_below;
    @add_text_blank_url_here;
    break;
  case 'mar':
    @go_to_mor;
    @add_bullet_below;
    text('Mar-');
    break;
  case 'may':
    @go_to_mor;
    @add_bullet_below;
    text('May-');
    break;
  case 'nov':
    @go_to_mor;
    @add_bullet_below;
    text('Nov-');
    break;
  case 'oct':
    @go_to_mor;
    @add_bullet_below;
    text('Oct-');
    break;
  case 'sep':
    @go_to_mor;
    @add_bullet_below;
    text('Sep-');
    break;
  case 'shon':
    @add_bullet_below;
    @add_text_date@;
    break;
  case 'tsql':
    @add_bullet_below;
    text('transact-sql 2005 ');
    break;
  default:
    @add_bullet_below;
    break;
}

@say(fp);
}



//;;

void
@convert_line_to_proper_case_wu
{
str fp = 'Convert line to proper case with underscores.';
@header;

@convert_line_to_proper_case;
goto_col(1);
/* Use Cases
bullshit more bullshit

hey asswipe
*/

@footer;
@say(fp);
}



//;

void
@rxx
{
str fp = "x";

//@say(str(@count_big_segments));
//@say(str(@get_current_bs_index));
//@say('bsi: ' + str(@get_current_bs_index) + ' cbs: ' + str(@count_big_segments));
@say(str(@is_last_big_segment));
}



//;;

void
@add_subrubric_below
{
str fp = 'Add subrubric below.';
@header;
@find_next_big_segment;
@add_rubric_above;
text(';');
@footer;
@say(fp);
}



//;;

void
@add_rubric_near_bof(str lc = parse_str('/1=', mparm_str))
{

str fp = 'Add Rubric near BOF for launch code "' + lc + '".';

@header;

if(lc != '')
{
  if(!@find_lc_known(fp, lc))
  {
    @footer;
    return();
  }
}

tof;

switch(@filename)
{
  case 'gci.bul':
    @find_next_big_segment;
    break;
}

@add_rubric_below('');

@footer;
@say(fp);
}



//;;

void
@add_rubric_here()
{
str fp = 'Add rubric here.';

insert_mode=1;

@bol;

cr;
cr;
cr;
cr;
up;
up;
up;
up;
text(@rubric_text);

@say(fp);
}



//;;

void
@add_rubric_near_bof(str lc = parse_str('/1=', mparm_str))
{

str fp = 'Add Rubric near BOF for launch code "' + lc + '".';

@header;

if(lc != '')
{
  if(!@find_lc_known(fp, lc))
  {
    @footer;
    return();
  }
}

tof;

switch(@filename)
{
  case 'gci.bul':
    @find_next_big_segment;
    break;
}

@add_rubric('');

@footer;
@say(fp);
}



//;

void
@validate_headers_and_footers
{
str fp = 'Validate that there are no illegal headers or footers in this macro file.';
int First_Only = true;
str rs;
str sc;
str so;
sc = '^\@footer';
rs = '\0';

if(find_text(sC, 0, _regexp | _backward))
{
  @find_bor_or_previous_rubric;
}

@say(so);
}



//; Deprecated on Jan-8-2012. Going forward please use: @get_user_input_nonspace.

str
@get_up_to_4_chars_from_the_user(str calling_function_description)
{
str fp = 'Get up to 4 characters from the user.';

int Countdown = 1;
str Four_Characters = "!";
str fa = "Function aborted.";

calling_Function_Description += ' Type 4 or fewer characters';

@say(Calling_Function_Description + " " + Four_Characters);

while(Countdown <= 4)
{
  Read_Key;
  Countdown++;

  if(key1 == 27) // Escape Key
  {
    return(fa);
  }
  else if((key1 == 38) or (key1 == 40)) // Up or down arrow key.
  {
    return(fa);
  }
  else if(key2 == 5) // Control Key
  {
    return(fa);
  }
  else if(key2 == 9) // Alt Key
  {
    return(fa);
  }
  else if(key1 == 113) // F2 key: I changed my mind in the middle of the command, so abort.
  {
    return("Function aborted.");
  }
  else if(key1 == 112) // F1 key: You accidentally hit the F1 key again.
  {
    // Just start over dude.
    Countdown = 1;
    Four_Characters = "!";
  }
  // If you make a mistake and want to start over, hit the F1 or semicolon key.
  else if (key1 == 186) // You hit the ";" key again, so reset the string.
  {
    // Just start over dude.
    Countdown = 1;
    Four_Characters = "!";
  }
  else if((key1 == 8) && (key2 == 1)) // Backspace key
  {
    // Do not let the user delete the exclamation point.
    if (@last_character(Four_Characters) != '!')
    {
      Four_Characters = str_del(Four_Characters, length(Four_Characters), 1);
      Countdown--;
    }
    Countdown--;
  }
  else if((key1 == 32) && (Countdown == 2)) // Semicolon Space Bar "Trick"
  {
    Four_Characters += ';';
    break;
  }
  else if((key1 == 13) && (Countdown == 2)) // Semicolon Enter "Trick"
  {
    Four_Characters += ';';
    break;
  }
  else if((key1 == 13) && (Countdown > 2)) // Enter Key
  {
    break; // This allows for fewer than 4 character hot codes.
  }
  else if((key1 == 32) && (Countdown > 2)) // Space Bar
  {
    break; // This allows for fewer than 4 character hot codes.
  }
  else // Normal Alphabetic keys, presumably.
  {
    Four_Characters += @convert_Read_Key_To_Ascii;
  }
  @say(Calling_Function_Description + " " + Four_Characters);
}

return(Four_Characters + ",|\\)");
}



//;;

  case 'wjx':
    fp += ' Use Microsoft Word to open Jira word documents my working folder.';
    expanded_Noun = '%savannah%\work documents\' + expanded_Noun + '.docx';
    expanded_Verb = @get_remote_oj_using_klc('wo', lc_Is_Found);
    if(!lc_Is_Found)
    {
      @say(fp + expanded_Verb + ' (Verb)');
      @footer;
      return();
    }
    expanded_Verb = @resolve_environment_variable(expanded_Verb);
    @run_application_2p(expanded_Verb, expanded_Noun);
    @say(fp);
    @footer;
    return();
    break;



//;;

void
@highcopy_postcolon_phrase()
{
str fp = 'Copy phrase from rightmost colon until eol.';

@eol;
str_block_begin;

while (@current_character != ':')
{
  if(@current_column == 1)
  {
    return();
  }
  left;
}

if(@next_character != ' ')
{
  if(@current_column == 1)
  {
    return();
  }
  right;
}
else
{
  right;
}

while (@previous_character != ' ')
{
  if(@current_column == 1)
  {
    return();    
  }
left;
}

@copy_with_marking_left_on;

/* Use Case(s)

:In the following example, Black_dwarf is adding an carriage return, which is not wanted. 
Nov-22-2011

:Use Case 1: blah blah: black_dwarf
            
I don't want to find the last colon, rather I want to find the next colon after the leading
colons.

:Tools: c:\_dev\_bin\tools.dll

:Use Case 2: lunar landing: (!+wc) bm: The primary concern of any moon landing

:Use Case 3: CNN: http://www.cnn.com

*/

@say(fp);
}



//; old?

str
@get_sj(str &string)
{
str fp = 'Get SJ.';

string = @trim_leading_colons_et_al(string);

int Position_of_Colon = xpos(char(58), string, 1);

//@say(str(Position_of_Colon));

if(Position_of_Colon == 0)
{
  fp += ' Error: No colon found in subject string.';
  string = '';
  return(fp);
}

str new_String;
int loop_Counter = 1;
int length_of_String = length(string);

while(loop_Counter < length_of_String)
{
  if(str_char(string, loop_Counter) != ":")
  {
    new_String += str_char(string, loop_Counter);
  }
  else
  {
    break;
  }
  loop_Counter ++;
}

string = new_String;

return(fp);
}



//;;

str
@get_postcolon_phrase(str &string)
{
str fp = 'Get post colon phrase.';

string = @trim_leading_colons_et_al(string);

int Position_of_Colon = xpos(char(58), string, 1);

if(Position_of_Colon == 0)
{
  fp += ' Error: No colon found in subject string.';
  string = '';
  return(fp);
}

//string = @trim_precolon_phrase_old(string);

return(fp);
}



//;;

void
@@highcopy_postcolon_phrase
{
@header;
@highcopy_postcolon_phrase;
@footer;
}



//;;

void
@highcopy_precolon_phrase_return(str selected_text)
{
str fp = 'Return the highlighted precolon phrase.';

@highcopy_sj;
selected_Text = @get_Selected_Text;

@say(fp);
}



//;;

void
@highcopy_line_after_colons
{
str fp = 'Highcopy the current line after the colons.';

@eoc;

str_block_begin;

eol;

@copy_with_marking_left_on;

@say(fp);
}



//;;

str
@get_first_sentence()
{
str fp = "Get first sentence.";
str rv = "Returns the first sentence.";

rv = get_line;
rv = @trim_leading_colons_et_al(rv);
if(!xpos('.', rv, 1))
{
  return(rv);
}

rv = @trim_after_first_sentence(rv);

@say(fp);
return(rv);

/* Use Case(s)

:2. Use Case on Jan-5-2012:
I like dogs.

:1. Use Case on Jan-5-2012:
Hey now Francine. I like dogs.

*/
}



//;

void
@find_last_colon()
{
str fp = 'Find the last colon on the current line while excluding URLs.';

eol;
while(!@at_bol)
{
  if(@current_character == ':')
  {
    break;
  }
  left;
}

//@say(@previous_six_characters(get_line, @current_column - 1))
// Make an exception for 'http' lines.
if(@previous_six_characters(get_line, @current_column - 1) == ': http')
{
  left;
  left;
  left;
  left;
  left;
  left;
}

if(@current_column == 1)
{
  fp += ' No colons found.';
}

/* Use Case(s)

Hey Bossman:
CNN: http://www.cnn.com

*/

@say(fp);
}



//;;

void
@import_and_format_innovatio_old
{
str fp = "Import and format innovation data.";

@header;

@open_file@(Get_Environment('reach out') + '\\For iPhone\\Innovator.txt');
tof;
@select_all;
@copy@;

delete_window;
@create_new_file;
@paste@;

@format_elements_file;
@close_and_save_file_wo_prompt;

rm("@open_file_with_writability /FN=" + Get_Environment('reach out') + "\\Gci.bul");

tof;
@paste_after@;
tof;
@fix_fat_colon;
@find_next_big_segment;
@bol;
@cursor_to_my_bof

@footer;
@say(fp);
}



//;

str
@ss()
{
str fp = 'Spoof string for saving me having to type strings I do not plan on using.';
return('');
}



//;;

void
@delete_word_aggressively
{
str fp = 'Delete word.';
@header;

if(at_eol)
{
  del_char;
}

if(@is_alphanumeric_character(cur_char))
{
  while(@is_alphanumeric_character(cur_char))
  {
    del_char;
  }
}
else
{
  str_block_begin;
  get_word(word_delimits);
  block_end;
  delete_block;
}

while((@is_alphanumeric_character(cur_char)) and (cur_char != '('))
{
  del_char;
}

/* Use Case(s)

Use Case 2: Fix the "Delete Word" macro so it doesn't delete "Hello" with the following
string starting at @bol:

   Hello

Use Case #1
I don't want to delete the open paren here: Webcasts My Favorite Presenters

although a classic, it's awesome

Windows Shortcuts are abolutely easy to use and fine for simple operations for a handful of

terrific editor. I have been using it since 1995.

Rommel's Panzerarmee

*/

@footer;
@say(fp);
}



//;

void
@rtx
{
str fp = "x";

fp = @get_ss;
@say(fp);
}



//;;

str
@formatted_search_line_for_wolf()
{
str fp = "Returns a properly formatted 'get_line' or block, as the case may be.";

str sc;

if(@text_is_selected)
{
  sc = @get_word_under_cursor_or_st;
}
else
{
  sc = get_line;
  sc = @trim_leading_colons_et_al(sc);
  sc = @trim_string_after_colon@(sc);
}

return(sc);
}



//;;

str
@get_ss_old()
{
str fp = "Returns a properly formatted 'get_line' or block, as the case may be.";

str sc;

if(@text_is_selected)
{
  sc = @get_selected_text;
}
else
{
  sc = get_line;
  sc = @trim_leading_colons_et_al(sc);
  sc = @trim_string_after_colon_et_al(sc);
}

return(sc);
}



//;

void
@rtx
{
str fp = 'blah before"blah after';

str new_String = @trim_before_character(fp, '"');

@say(new_String);
}



//;;

str
@previous_x_characters(str parameter, int current_position_on_line, int number_of_Characters)
{
// Chop off the last part of the line.
parameter = copy(parameter, 1, current_position_on_line);

// Chop off the first part of the line.
parameter = str_del(parameter, 1, current_position_on_line - number_of_Characters);

//return(str_del(parameter, 1, current_position_on_line - number_of_Characters));
return(parameter);
}



//;;

str
@last_6_characters(str parameter)
{
return(str_del(parameter, 1, length(parameter) - 6));
}



//;;

str
@last_4_characters(str parameter)
{
return(str_del(parameter, 1, length(parameter) - 4));
}



//;;

str
@first_2_characters(str parameter)
{
return(copy(parameter, 1, 2));
}



//;;

str
@first_4_characters(str parameter)
{
return(copy(parameter, 1, 4));
}



//;

str
@trim_string_after_the_colon(str string)
{
int Position_Of_Colon = xpos(char(58), String, 1);
String = str_del(String, Position_Of_Colon, 999);
return(String);
}



//;

str
@trim_question_mark(str string)
{
// Trim the period, if present.
if(Str_Char(String, length(String)) == '?')
{
  String = str_del(String, length(String), 1);
}
return(String);
}



//;;

str
@trim_precolon_phrase_old(str string)
{
str fp = 'Trim precolon phrase.';

string = @trim_leading_colons_et_al(string);

while(str_char(string, 1) != ":")
{
  string = str_del(string, 1, 1);
}
string = str_del(string, 1, 1);

if(str_char(string, 1) == " ")
{
  string = str_del(string, 1, 1);
}

return(string);
}



//;

void
@surf_block_under_cursor
{
str fp = "Surf block under cursor.";
@header;

str uRL = @get_word_under_cursor_or_st;

@surf(uRL, 0);

/* Use Case - Jun-10-2011

http://www.cnn.com

*/

@footer;
@say(fp);
}



//;;

str
@trim_precolon_phrase@(str string)
{
str fp = 'Trim precolon phrase starting from the right side with intelligence.';

string = @trim_leading_colons_et_al(string);

int character_Counter = svl(string);

if(!@colon_Is_Found(string))
{
  return(string); 
}

str new_String = '';

str current_Character = str_char(string, character_Counter);

while(current_Character != ":")
{
  new_String = current_Character + new_String;
  character_Counter--;
  current_Character = str_char(string, character_Counter);
}

if(current_Character == ":")
{
  while(current_Character != " ")
  {
    new_String = current_Character + new_String;
    if(character_Counter == 1)
    {
      break;
    }
    character_Counter--;
    current_Character = str_char(string, character_Counter);
  }
}

return(@trim@(new_String));
}



//;;

str
@get_oj_old()
{
str fp = 'Get OJ.';

//@highcopy_oj;
return(@get_selected_text);

}



//;;

void
@tm
{
str fp;
fp = 'no colon content';
fp = '::bla1 ::: bla2: a test content';
fp = 'no colon: content';
fp = '::bla1 ::: bla2: c://www.test content';
fp = '::bla1 ::: bla2: c:\j.txt';
fp = '::bla1 ::: bla2: http://www.test content';
fp = @trim_precolon_phrase@(fp);
@say(fp);
}



//;

void
@convert_line_to_proper_case()
{
str fp = 'Convert line to proper case.';

mark_pos;
int tl, lx, t_x;
str tstr = '';
str cctstr = '';
str cctstr2 = get_line;
goto_col(1);
while(!at_eol)
{
  tstr = get_word(word_delimits);
  if(svl(tstr))
  {
    tstr = caps(str_char(tstr,1)) + lower(str_del(tstr,1,1));
    tl = svl(tstr);
    if(tl > 1)
    {
      for(lx = 2; lx < tl; lx++)
      {
        if(str_char(tstr, lx) == '_')
        {
          tstr = copy(tstr, 1, lx) +
                  caps(str_char(tstr, lx+1)) +
                  copy(tstr, lx+2, tl-lx-1);
        }
      }
    }
  }
  else
  {
    t_x = c_col;
    word_right;
    tstr += Copy(cctstr2, t_x, c_col-t_x);
  }
  cctstr += tstr;
}
put_line(cctstr);
goto_mark;

@say(fp);
}



//;

void
@tm
{
str fp = "x";

@strip_off_filename('c:\!\j.txt');


//@say(fp);
}



//;

void
@load_clipboard_with_oblique(str lc = parse_str('/1=', mparm_str))
{
str fp = "Load clipboard.";
@header;

@save_location;

if(!@find_launch_code_ui(fp))
{
  @footer;
  return();
}

@highcopy_postcolon_phrase;
str oblique = @get_selected_text;

@load_location;

@footer;
@say(fp + ' Buffer is now loaded with oblique. (' + oblique + ')');
}



//;

void
@tm
{
str fp = "switch statement experiment.";

switch(fp)
{
  case "oj": // Prosecute object.
    fp += 'oj';
    break;
  case "ss": // Prosecute subject.
    fp += 'ss';
    break;
  default:
    fp += 'default';
    break;
}


//switch(fp)
//{
//  case 'a':
//    break;
//  case 'b':
//    break;
//  case 'x':
//    fp += 'here';
//    break;
//  default:
//    fp += ' here by default';
//    break;
//}

@say(fp);
}



//;

void
@tm
{
str fp = "x";

//fp = @get_remote_ss_using_klc('alja');
fp = @get_remote_ss_using_klc('wash');
//long_Noun = @get_remote_ss_using_klc(launch_Code_Noun);

@say(fp);
}



//;

void
@run_browser(str browser = parse_str('/1=', mparm_str))
{
str fp = "Run browser.";
@header;

str application;
str uRL;

if(@text_is_selected)
{
  uRL = @get_selected_text; 
}
else
{
  @highcopy_postcolon_phrase;
  uRL = @get_selected_text;
}

switch(@lower(browser))
{
  case 'fi':
    application = 
    "%programfiles%\\mozilla firefox\\firefox.exe";
    break;
  case 'ie':
    application = 
    "%programfiles%\\internet explorer\\iexplore.exe";
    break;
  case 'kh':
    application = 
    "%userprofile%\\Local Settings\\Application 
    Data\\Google\\Chrome\\Application\\chrome.exe";
    break;
  case 'op':
    application = Get_Environment("ProgramFiles") + "\\Opera\\opera.exe";
    break;
  case 'sa':
    application = 
    "%programfiles%\\safari\\safari.exe";
    break;
}

application = @resolve_environment_variable(application);
//application = make_literal_x(application);

@run_application_2p(application, uRL);


/* Use Case(s)

:1. Use Case on Dec-13-2011:
  http://www.cnn.com: http://www.washingtonpost.com

*/

@footer;
@say(browser);
@say(application);
@say(fp);
}



//;

void
@tm
{
str fp = "x";

fp = @get_oj;
@say(fp);
}



//;

void
@tm2
{
str fp = "x";

int text_Is_Selected;

if(@text_is_selected)
{
  @save_highlighted_text;
  text_is_selected = true;
}

mark_pos;
down;
down;
goto_mark;

if(text_is_selected)
{
  @load_highlighted_text; 
}

@say(fp);
}



//;

void
@tm
{
str fp = "x";

str long_Noun = @get_subject_or_selected_text;

@say(long_Noun);
}



//;

void
@tm
{
str fp = "rtm";

str test;
test = '::::aa:bb';
test = 'aabb';
test = 'a:abb';
test = ':aabb';
test = 'azza:cbbx';
test = 'aa:bb';

str em = @get_postcolon_phrase(test);

if(length(test) == 0)
{
  @say(em);
  return();
}
@say(test);
}



//;

void
@tmprecolon
{
str fp = "rtm";

str test;
test = '::::aa:bb';
test = 'aabb';
test = 'a:abb';
test = 'aa:bb';
test = ':aabb';
test = 'azza:bb';

str em = @get_sj(test);

@get_postcolon_phrase

if(length(test) == 0)
{
  @say(em);
  return();
}
@say(test);
}



//;

void
@tm
{
str fp = "x";

fp = @concatenate_multiple_lines;
fp = @trim_precolon_phrase(fp);
//text(fp);
@say(fp);
}



//;;

void
@add_text_chrome
{
str fp = 'Add text chrome.';
@header;

if(@text_is_selected)
{
  delete_block;
}

str Chrome_Path = '%userprofile%\Local Settings\Application 
  Data\Google\Chrome\Application\chrome.exe ';

switch(Get_Environment("ComputerName"))
{
  case "VAIO":
    //fp = 'vaio!';
    Chrome_Path = 
    break;
}

text(Chrome_Path + char(34));

@footer;
@say(fp);
}



//;+

void
@load_clipboard@(str lc = parse_str('/1=', mparm_str))
{
str fp = "Load clipboard.";
@header;

@save_location;

if(!@find_launch_code_known(fp, lc))
{
  @footer;
  return();
}

@highcopy_postcolon_phrase;

str st = @get_selected_text;

@load_location;

@footer;
@say(fp + ' Buffer is now loaded. (' + st + ')');
}



//;;

void
@run_clif_compositionally_uc
{
str fp = "Run Clif compositionally using word under cursor or selected text.";
@header;

str noun;
str verb;

str user_Input = @get_user_input(fp);

if(length(user_Input) == 4)
{
  verb = @left(user_Input, 2);
  noun = @right(user_Input, 2);  
}
else
{
  verb = @left(user_Input, 2);
  noun = @get_word_under_cursor_or_st;

}

@run_clif_compositionally_core(verb, noun);

@footer;
@say(fp);
}



//;;

void
@run_clif_compositionally_pp
{
str fp = "Run Clif compositionally using precolon phrase or selected text.";
@header;

str noun;
str verb;

str user_Input = @get_user_input(fp);

if(length(user_Input) == 4)
{
  verb = @left(user_Input, 2);
  noun = @right(user_Input, 2);  
}
else
{
  verb = @left(user_Input, 2);
  noun = @get_precolon_phrase_or_st;
}

@run_clif_compositionally_core(verb, noun);

@footer;
@say(fp);
}



//;;

void
@run_clif_compositionally_ui
{
str fp = "Run Clif compositionally using user input only.";
@header;

str noun;
str verb;

str user_Input = @get_up_to_4_chars_from_the_user(fp);
user_Input = @distill_Launch_Code(user_Input);

if(length(user_Input) != 4)
{
  @say(fp + ' Error: input must be exactly 4 characters. (' + user_Input + ')');
  return();
}

verb = @left(user_Input, 2);
noun = @right(user_Input, 2);  

@run_clif_compositionally_core(verb, noun);

@footer;
//@say(fp);
}



//;

void
@find_other_instances_of_this_lc
{
str fp = "Find other instances of this lauch code.";
@header;

str so;
str sc = '![a-z]*,||\)';            // Launch code

@seek_next(sc, so);

sc = found_str;

sc = @distill_launch_code(sc);

if(!@find_launch_code_known(fp, sc))
{
  return();
}

@footer;
@say(fp);
@say(sc);
}



//;+

void
@run_application(str application, str parameter)
{
str fp = "Run application.";

ExecProg(application + ' ' + parameter,
  Get_Environment("userprofile") + '\my documents\!savannah\belfry',
  Get_Environment("TEMP") + '\\multi-edit output.txt',
  Get_Environment("TEMP") + '\\multi-edit error.txt',
  _ep_flags_dontwait | _ep_flags_exewin);

//  _ep_flags_dontwait | _ep_flags_exewin | _ep_flags_maximized);

@say(fp);
}



//;

void
@run_application2(str application, str parameter)
{
str fp = "Run application WITH parameter simple as possible.";

ExecProg(application + ' ' + parameter,
  Get_Environment("userprofile") + '\my documents\!savannah\belfry',
  Get_Environment("TEMP") + '\\multi-edit output.txt',
  Get_Environment("TEMP") + '\\multi-edit error.txt',
  _ep_flags_dontwait | _ep_flags_exewin);

@say(fp);
}



//;

void
@run_application1(str application)
{
str fp = "Run application simple as possible.";

ExecProg(application,
  Get_Environment("userprofile") + '\my documents\!savannah\belfry',
  Get_Environment("TEMP") + '\\multi-edit output.txt',
  Get_Environment("TEMP") + '\\multi-edit error.txt',
  _ep_flags_dontwait | _ep_flags_exewin);

@say(fp);
}



//;

void
@run_application3(str application, str parameter)
{
str fp = "Run application WITH parameter. Add double quotes if space is found.";

if(xpos(' ', application, 1))
{
  application = char(34) + application + char(34);
}

if(xpos(' ', parameter, 1))
{
  parameter = char(34) + parameter + char(34);
}

ExecProg(application + ' ' + parameter,
  Get_Environment("userprofile") + '\my documents\!savannah\belfry',
  Get_Environment("TEMP") + '\\multi-edit output.txt',
  Get_Environment("TEMP") + '\\multi-edit error.txt',
  _ep_flags_dontwait | _ep_flags_exewin);

@say(fp);
}



//;

void
@run_application4(str application, str parameter)
{
str fp = "Run application WITH parameter. Add double quotes in join.";

ExecProg(application + " " + parameter,
  Get_Environment("userprofile") + '\my documents\!savannah\belfry',
  Get_Environment("TEMP") + '\\multi-edit output.txt',
  Get_Environment("TEMP") + '\\multi-edit error.txt',
  _ep_flags_dontwait | _ep_flags_exewin);

@say(fp);
}



//;

void
@tmworks
{
str fp = "App test.";

str application;
str parameter;

//application = get_environment("windir") +  "\\explorer.exe";

application = get_environment("windir") +  "\\explorer.exe /n, /e, ";

//application = "c:\\windows\\explorer.exe /n, /e, C:\\Documents and Settings\\jrj\\My Documents";

application = "c:\\program files (x86)\\microsoft office\\office12\\winword.exe";

//parameter = "c:\\!";
parameter = "c:\\!\\a.docx";
//parameter = "C:\\Documents and Settings\\jrj\\My Documents";

//@run_application1(application);
//@run_application2(application, parameter);
//@run_application3(application, parameter);
//@run_application4(application, parameter);
@run_application5(application, parameter, 0);

@say(application);
}



//;

void
@tm
{
str fp = "Synchronize my Savannah files in the background.";

str command_string = 'c:\windows\system32\cmd.exe /k';

str parameter = Get_Environment("savannah") + '\belfry\test.bat';

@run_application(command_string, parameter);

//ExecProg(Command_String,
//  Get_Environment("userprofile") + '\my documents\!savannah\belfry',
//  Get_Environment("TEMP") + '\\multi-edit output.txt',
//  Get_Environment("TEMP") + '\\multi-edit error.txt',
//  _EP_FLAGS_DONTWAIT | _EP_FLAGS_EXEWIN);

@say(fp);
}



//;

void
@open_gci_files()
{
str fp = "Open GCI files.";

str application = 'c:\windows\system32\cmd.exe /k';

str parameter = get_environment("savannah") + '\belfry\open_files_gci_box.bat';

@run_application(application, parameter);

@say(fp);
}



//;

void
@run_this_ps1_file_with_no_exit
{
str fp = 'Run this PS1 file: ' + file_name;

if(lower(Get_Extension(file_name)) != 'ps1')
{
  fp = 'You must be working in a PS1 file for this function to work.';
  @say(fp);
  return();
}

@header;

int flag = _ep_flags_dontwait | _ep_flags_exewin;

str Application = 'c:\windows\system32\WindowsPowerShell\v1.0\powershell.exe ' +
  '-NoExit -OutputFormat Text ';

str Parameter = truncate_path(file_name);

str Application_Plus_Parameter = Application + ' .\' + Parameter;

ExecProg(Application_Plus_Parameter,
  Get_Path(file_name),
  Get_Environment("TEMP") + '\\multi-edit output.txt',
  Get_Environment("TEMP") + '\\multi-edit error.txt',
  flag);

@footer;
//@say(fp);
}



//;;

void
@open_folder_under_cursor
{
str fp = 'Open folder cursor.';

if(@text_is_selected)
{
  @anatomize_clif(2, fp);
  return();
}

if((@first_character(get_line) != ';') && (@first_character(get_line) != ':'))
{
  mark_pos;
  @bobsr; //qcq
  @anatomize_clif(2, fp);
  goto_mark;
}
else
{
  @anatomize_clif(2, fp);
}

@say(fp);
}



//;

void
@open_both_email_links
{
str fp = 'Open both email links.';
@header;

//@run_clif_internally('gmai');
// Turns out the not-being-able to open both links was a Firefox issue.
//@run_clif_internally('hotm');

@footer;
@say(fp);
}



//;

void
@go_to_folder_of_current_file
{
str fp = "Go to the folder of the current file. Cool.";

str file_Path = get_path(file_name);
@open_folder(file_Path);

@say(fp);
}



//;

void
@open_folder(str path)
{
str fp = "Open folder.";

str Application = Get_Environment("WinDir") +  "\\explorer.exe /n, /e, ";
int int_EP_Return = ExecProg(Application + " " + char(34) + path + char(34),
  Get_Environment("TEMP"),
  Get_Environment("TEMP") + '\\multi-edit output.txt',
  Get_Environment("TEMP") + '\\multi-edit error.txt',
  _EP_FLAGS_DONTWAIT | _EP_Flags_ExeWin);

@say(fp);
}



//;

void
@scroll_window_max_left_gocol_95
{
str fp = "Scroll window all the way to the left and go to column 95.";
@bol;
goto_col(95);

@say(fp);
}



//;;

void
rtx4
{
str fp = "Visible window count.";

int Window_Counter;
int Total_Windows;
Total_Windows = window_count;
Total_Windows = @count_visible_windows;

while(Window_Counter < Total_Windows)
{
  @next_window;
  Window_Counter++;
}

fp = str(window_count);
@previous_window;
@say(fp);
}



//;;

int
@count_visible_windows()
{
str fp = "Count visible windows.";

int Window_Counter;
int Total_Windows;
Total_Windows = window_count;

while(Window_Counter < Total_Windows)
{
  @next_window;
  Window_Counter++;
}

return(Window_Counter);
@say(fp);
}



//;;

void
rtx
{
str fp = "x";

@header;

rtx1;
@switch_to_last_window;
//@switch_to_first_window;
//@next_window;
down;
down;
down;
down;
@select_all;

@switch_to_last_window;
@select_all;

//@footer;

@say(fp);
}



//;+ Inability to really switch to the last window issue.

void
rtx1()
{
str fp = "x";

str Command_String = 'c:\windows\system32\cmd.exe /k ' + char(34) +
  Get_Environment("savannah") +
  '\belfry\back up innovation.bat' + char(34);

ExecProg(Command_String,
  Get_Environment("userprofile") + '\my documents\!savannah\belfry',
  Get_Environment("TEMP") + '\\multi-edit output.txt',
  Get_Environment("TEMP") + '\\multi-edit error.txt',
  _EP_FLAGS_DONTWAIT | _EP_FLAGS_EXEWIN);

@say(fp);
}



//;;

void
@paste_before_with_subbullet()
{
str fp = 'Paste before current BSR while converting the pasted text into a subbullet.';

@super_paste;
@bol;
text(':');

@say(fp);
}



//;;

void
@paste_before_with_subbull_wnoc
{
str fp = 'Paste before with subbullet with no connection, that is WITHOUT turning the current
bullet into a subbullet.';

if(@is_rubric_or_subrubric)
{
  fp += " This macro doesn't work with rubrics.";
  @say(fp);
  return();
}

@header;

@find_previous_bsr;
@bobsr;
@paste_after_with_subbullet;

@footer;
@say(fp);
}



//;;

int
@is_sh_file()
{
str fp = 'Verify that the user is in a file with a "sh" extension.';
if(lower(get_extension(File_name)) != 'sh')
{
  @say('This macro only works on "sh" type files.');
  return(0);
}
@say(fp);
return(1);
}



//;

void
@prepare_email
{
str fp = "Prepare e-mail.";

if(!@is_bullet@)
{
  return();
}

@highcopy_bullet_continc;
@create_new_long_line_file;
@paste@;
@word_wrap_file@;
rm('Block^SelectAll');
@copy@;
@close_and_save_file_wo_prompt;

@say(fp);
}



//;

void
@delete_bullet_and_close_file
{
str fp = "Delete bullet and close file.";
@header;

if(@filename != 'broadcast_from_offline.bul')
{
  fp += ' Error: This macro only works with the file "broadcast_from_offline.bul".';
  @say(fp);
  return();
}

if(@is_bullet@)
{
  @delete_bullet;
}

@close_and_save_file_wo_prompt;

// This line seems superflous to me, but without it, I get crashes. - JRJ Nov-24-2010
@switch_to_task_window;

@go_to_task_location;

@footer;
@say(fp);
}



//;;

void
@highcopy_postcolon_phrase()
{
str fp = 'Copy phrase from rightmost colon until eol.';

@eoc;

while (@current_character != ':')
{
  right;
  if(@column > 200)
  {
    @eoc;
    left;
    break;
  }
}

right;

if(@current_character == ' ')
{
  right;
}

col_block_begin;
while (!at_eol)
{
  right;
}
left;

@copy_with_marking_left_on;

/* Use Case(s)

:

Black_dwarf is adding an carriage return, which is not wanted. Nov-22-2011
:blah blah: black_dwarf

I don't want to find the last colon, rather I want to find the next colon after the leading
colons.

:Tools: c:\_dev\_bin\tools.dll

:lunar landing: (!+wc) bm: The primary concern of any moon landing

:CNN: http://www.cnn.com

*/

@say(fp);
}



//;

void
@cursor_to_center_column
{
str fp = "Cursor to center column on screen.";

goto_col(47);

@say(fp);
}



//;

void
@correctly_case_first_characters()
{
str fp = "Correctly case first characters in a Google Docs file.";

if(!@is_text_file)
{
  return();
}

tof;

while(!at_eof)
{
  switch(@last_character(get_line))
  {
    case '.':
    case '!':
    case '?':
      break;
    default:
      put_line(@lower_case_first_character(get_line));
  }
  down;
}

@say(fp);
}



//; (skw has rubrics, has_rubrics)

int
@is_rubric_file()
{
str fp = 'Verify that the user is in a file with rubrics.';

switch(lower(get_extension(File_name)))
{
  case "bat":
  case "bul":
  case "jpg":
  case "s":
  case "sh":
  case "sql":
  case "xml":
    break;
  default:
    @say('This macro only works on files with rubrics.');
    return(0);
}
return(1);
}



//;

void
@@find_previous_bullet_or_bigxxx
{
@header;
@find_previous_bullet_or_big_seg;
@footer;
}



@find_previous_bullet_or_big_seg//;;

void
@@find_next_bullet_or_big_segmx
{
@header;
@find_next_bullet_or_big_segment;
@footer;
}



//;

void
@highcopy_small_segment_content()
{
str fp = 'Highlight and copy small segment content.';

block_off;
@bobsr;
@find_next_blank_line;
down;
block_begin;
right;

if(@find_next_bsr == 'rubric')
{
  up;
  up;
}
up;
@bol;
left;
@center_line;
//block_end;
@copy_with_marking_left_on;

@say(fp);

}



//;

void
@find_launch_code_know_for_F11(str launch_Code = parse_str('/1=', mparm_str))
{
str fp = "Find known launch code for use by an F11 function.";
@header;

str sc = launch_Code;

if(!@find_launch_code_known(fp, sc))
{
  return();
}

@find_next_bullet;

@footer;
@say(fp + ' (' + sc + ')');
}



//;

void
@cut_bs()
{
str fp = 'Cut bullet or subbullet to buffer.';

@highcopy_small_segment@;

@say(fp);
}



//;;

void
@move_subbullet_up()
{
str fp = 'Move subbullet up.';

// lu: Sep-18-2018

int is_first_subbullet = @is_first_subbullet;

int current_line_number = @current_line_number;

@cut_bs;

@bobsr;

if (@current_line_number == current_Line_Number)
{
  @find_previous_bs@;
}

@home;
@paste@;
@find_previous_subbullet;
@say(fp);
}



//;

void
@delete_segment()
{
str fp = "Delete segment.";

@highcopy_small_segment;
delete_block;

@say(fp);
}



//;

void
@add_new_rubric_for_completed_it
{
str fp = "Add new rubric for completed items.";
@header;

str Launch_Code = "comp";
if(!@find_launch_code_known(fp, Launch_Code))
{
  return();
}

@backspace;
@backspace;
del_char;
del_char;
del_char;
del_char;
del_char;
del_char;

@add_rubric_above;

text('Completed Items (!' + 'comp) for Week of ');
@add_text_date@;
text(' - Ordered Newest to Oldest');

@footer;
@say(fp);
}



//;

str
@decode_html_url_encodng_refs(str Clif_Block)
{
str fp = "In order to resolve conficts with environment variables, 
  replace HTML URL Encoding references with the appropriate character.";

// Fix hexadecimal issues with URL strings BEFORE resolving environment variables.
//Clif_Block = @decode_html_url_encodng_refs(Clif_Block);

// HTML URL Encoding Reference: http://www.w3schools.com/TAGS/ref_urlencode.asp


Clif_Block = @replace@(Clif_Block, "%20", " ");
Clif_Block = @replace@(Clif_Block, "%21", "!");

Clif_Block = @replace@(Clif_Block, "%2c", ",");
Clif_Block = @replace@(Clif_Block, "%2C", ",");

Clif_Block = @replace@(Clif_Block, "%2f", "/");
Clif_Block = @replace@(Clif_Block, "%2F", "/");


Clif_Block = @replace@(Clif_Block, "%3a", ":");
Clif_Block = @replace@(Clif_Block, "%3A", ":");

Clif_Block = @replace@(Clif_Block, "%3d", "=");
Clif_Block = @replace@(Clif_Block, "%3D", "=");

return(Clif_Block);
@say(fp);
}



//;;

void
@add_text_dnrtv()
{

str fp = 'Add text DNRTV.';

if(@block_is_selected)
{
  delete_block;
}

if((@previous_character != ' ') and (@previous_character != ':') and (@previous_character !=
  ';'))
{
  text(' ');
}

@add_subbullet_below;
@add_text_internet_explorer;
cr;
text('http://dnrtv.com/dnrtvplayer/player.aspx?ShowNum=0116');

@say(fp);
}



//;;

void
@find_starting_point
{
str fp = 'Find starting point.'; // Explicit message to the user.
@header;

find_text('!' + 'stpt', 0, _regexp);

if(@filename == 'synchronize_affinity_on_local_with_affinity_on_usb.bat')
{
  @find_next_bullet; 
  @find_next_bullet; 
}
else
{
  down;
  down;
  @bol;
}

@footer;
@say(fp);
}



//;

void
@copy_line_essence_to_buffer
{
str fp = 'Copy line essence to buffer.';
@header;

mark_pos;
@eoc;
col_block_begin;
str sc = get_word_in(@define_what_a_word_is);
left;
while(@previous_character == ' ')
{
  left;
}
@copy@;
goto_mark;

/* Use Case(s) hey now buddy xx (

::hey now buddy x1

::hey now buddy x2 ( abc

::hey now buddy x3( abc

::hey now buddy x4: abc

*/

@footer;
@say(sc);
}



//;;

int
@truncate_spaces_after_column_95
{
str fp = "Truncate spaces that extend past column 95.";

@header;

int Number_of_Replacements = 0;
tof;
while(!at_eof)
{
    eol;
    if(c_col > 96)
    {
      goto_col(95);
      while (@current_character == " ")
      {
        @delete_character;
      }
      Number_of_Replacements++;
    }
    down;
}

@say(fp + " Number of replacements: " + str(Number_of_Replacements));
@footer;

return(Number_of_Replacements);

}



//; (skw Who_am_I, Who am I)

str
@current_bsr()
{
str fp = 'Identifies the current bullet, subbullet or rubric categorization.';

/*
Deprecated: From now on, please use @current_area_type.
*/

mark_pos;
str Current_BSR = @bobsr;
goto_mark;

return(Current_BSR);
}



//;

void
@delete_dissonance_gap
{
str fp = 'Delete current bullet or subbullet and eveything up until the first bullet AFTER the
  next rubric.';

if(lower(file_name) != lower((Get_Environment('reach out') + '\dissonance.bul')))
{
  @say('This macro only works with Dissonance.bul.');
  return();
}

@header;

@bobsr;
if(@current_area_type == 'rubric')
{
  down;
  cr;
}
str_block_begin;
@find_next_big_segment;
@find_next_bullet;
@bol;
block_end;
delete_block;

@footer;
@say(fp);
}



//;

int
@is_rubric()
{
str fp = 'Verifies that the cursor is on a rubric.';

if(@current_area_type != 'rubric')
{
  //@say('The cursor is not residing on a rubric.');
  return(0);
}

@say(fp);
return(1);
}



//;

void
@format_mappings_file_old
{
str fp = "Format the TMT Mappings file.";
str rs;
str so;
int EFBO = true; // Execute First Block Only

if(!@is_text_file)
{
  return();
}

@say(fp);

@header;

tof;

str sc = '';

//@format_report_header;

//@format_report@(fp);

//@format_report@(@delete_space_at_bol);
@delete_space_at_bol;

tof;
sc = '(^<)';
rs = '$\0';
so = @replace_all_occurrences_in_file(sc, rs);

@format_report@(so);

@format_report@(@replace_2_spaces_with_1);

@format_report@("");

@obey_right_margin_bad_cop;

@replace_2_blank_lines_with_1;

sc = '(<entity' + ' )';
rs = '$\0';
so = @replace_all_occurrences_in_file(sc, rs);

tof;

@footer;
@say(fp + ' Finished.');
}



//;;

void
@alt_home_key
{
str fp = "Alt home key.";

if(@is_bullet_file)
{
  @eoc;
}
else
{
  @eos;
}

@say(fp);
}



//;

void
@tm
{
str fp = "rtm1";

int Number_of_Windows = 0;
int Window_Counter = @window_count;

do
{
  Number_of_Windows++;
  @close_window;
//  @next_window;
} while(Number_of_Windows < Window_Counter);

@say(str(Number_of_Windows));
}



//;;

void
@control_cut_pb
{
str fp = 'Control key plus contextually aware cut perimeter button.';

int Context = 0;

@header;

if(@is_bullet_File)
{
  switch(@current_bsr)
  {
    case 'bullet':
      Context = 1;
      @cut_parent;
  }
}

@footer;

if(Context == 0)
{
  @say(fp + ' Context is undefined.');
}

}



//;;

void
@shift_tab
{
str fp = "Shift tab.";
mark_pos;
@bol;
  if(@current_character == ' ')
  {
    del_char;
  }
  if(@current_character == ' ')
  {
    del_char;
  }

rm('Tab /M=1');
goto_mark;
left;
left;
@say(fp);
}



//;

void
@tab@
{
str fp = "Tab.";
mark_pos;
@bol;
rm('Tab /M=0');
goto_mark;
right;
right;
@say(fp);
}



//;

void
@control_jay
{
str fp = "Contextually aware delete button.";

@header;

if(@is_bullet_File)
{
  switch(@current_bsr)
  {
    case 'bullet':
        @delete_bullet;
        break;
    case 'subbullet':
        @delete_subbullet;
      break;
    default:
      fp += 'This macro only works with bullets and subbullets.';
  }
}

@footer;
@say(fp);
}



//;;

void
@control_delete_pb
{
str fp = 'Control key plus contextually aware delete perimeter button.';

int Context = 0;

@header;

if(@is_bullet_File)
{
  switch(@current_bsr)
  {
    case 'bullet':
      Context = 1;
      @delete_parent;
  }
}

@footer;

if(Context == 0)
{
  @say(fp + ' Context is undefined.');
}

}



//;

void
@rtz //
{
// Permanent. Please close this window when you are not using it.

str fp = "";
str rs;
str so;
int EFBO = true; // Execute First Block Only

@header;
str sc;

//1.
sc += '(\(' + char(32) + '\!)';

//2.
sc += '||';
sc += '(\(\!' + char(32) + ')';

//3.
sc += '||';
sc += '(!' + '.....,)';

//4.
sc += '||';
sc += '(!' + '.....\))';

/* Use Case - May-5-2011


:1. Space before the exclamation point and after the open parenthesis.

([]!blah


:2. Space after the exclamation point.

(![]blah blah


:3. 5 character launch code in the non-last position.

:4. 5 character launch code in the last position.

!abcd,

!abcd)

![]abcde,

![]abcde)

*/

@footer;
@say(found_str);
@say(so);
}



//;;

void
@log2(str text_to_write)
{
// This is the same as turning the log off.
}



//;

str
@broken_launch_code_0_parm()
{
str fP = "Broken launch code, the simplest way to call it.";
str regex_Description, rS;
str sc = @broken_launch_code@(regex_Description, rs);
//rS = ' ';
regex_Description = fp;
return(sc);
}



//;

void
@find_broken_launch_codes_in_af
{
str fp = "Find broken launch codes in all files.";

str so;

@header;

str sc = @broken_launch_code_0_parm;

@say(fp + ' Please wait . . .');

if(@seek_in_all_files_2_arguments(sc, so))
{
  fp += ' ' + so;
}
else
{
  fp += ' NONE found.'; 
}

@footer;
@say(fp);
}



//;;

void
@find_end_of_current_rs
{
str fp = 'Find end of current rubric or subrubric.';

if(!@is_rubric_file)
{
  return();
}

@header;

@find_next_big_segment;

if(@is_bullet_file)
{
  up;
  @bobsr; 
}
else
{
  up;
  up;
  up;
  up;
  up;
  up;
  up;
  @bol;
}

@footer;
}



//;;

void
@center_line()
{
str fp = 'Center line.'; // Rewritten/stolen code - JRJ Apr-20-2011

int height = win_cheight()/2;

if(height <= 0)
{
  return();
}

if(c_line > height)
{
  int old_current_row = -1;
  while ((c_row > height) && (c_row != old_current_row))
  {
    old_current_row = c_row;
    up;
  }
  old_current_row = -1;
  while ((c_row < height) && (c_row != old_current_row)) 
  {
    old_current_row = c_row;
    down;
  }
}
}



//;

int
@replace_string_in_file_int(str old_String, str new_String)
{
str fp = 'Replace all occurrences of a particular string or special character in a file.';

int Number_of_Replacements = 0;
tof;
while(!at_eof)
{
  if(find_text(old_String, 0, _regexp || _CaseSensitive))
  {
    Ignore_Case = false;
    Replace(new_String);
    Number_of_Replacements++;
    tof;
    // This block imposes the limitation that only ONE occcurence of this case-sensitive 
    // string will be replaced per line.
    right;
    if(@lowercase(old_String) != @lowercase(new_String))
    {
      // old_String is completely "inside" new string, cannot go to tof.
      if(!xpos(@lcase(old_String), @lcase(new_String), 1))
      {
        tof;
      }
    }
  }
  else
  {
    break;
  }
}

return(Number_of_Replacements);
}



//;

void
@search_appleman(int is_Exact_Search)
{
str fp = "Search Appleman's website.";

str URL =
  "http://www.searchdotnet.com/results.aspx?cx=002213837942349435108%3Ajki1okx03jq&q=";

str sc = @formatted_search_line;

str Pretty_sc = sc;
sc = @commute_character(sc, ' ', '+');
sc = @commute_character(sc, '#', '%23');

if(is_Exact_Search)
{
  fp += ' exactly';
  sc = '%22' + sc + '%22';
}
else
{
  fp += ' liberally';
}
fp += '.';

URL += sc + "&sa=Search+.NET+sites&cof=FORID%3A9#1115";

@surf(URL, 0);

/* Use Case(s)

:generics

:Generics in the .NET Framework

:Class Library Generics in the .NET Framework

*/

make_message(@trim_period(fp) + ' for "' + Pretty_sc + '".');
}



//;

void
@search_appleman_exactly
{
@search_appleman(true);
}



//;

void
@search_appleman_liberally
{
@search_appleman(false);
}



//;;

void
@process_google_docs_cboard_data
{
str fp = "Process Google Docs clipboard data.";
@header;

if(!@is_text_file)
{
  return(); 
}

tof;
@delete_line;
@select_all;
@copy@;

Delete_Window;
@create_new_file;
@paste@;
@prepare_google_doc;
@close_and_save_file_wo_prompt;

rm("@open_file_with_writability /FN=" + Get_Environment('reach out') + "\\Gci.bul");

tof;
@paste_after@;
tof;
@fix_fat_colon;
@find_next_big_segment;
@bol;
@cursor_to_my_bof

@footer;
@say(fp);
}



//;

str
@period_space_period_eol
{
str fp = "Period space period EOL.";
str sc = '\. \.$';
return(sc);
}



//;

void
@highcopy_bullet_content()
{
str fp = 'Highlight and copy bullet content.';

if(Cur_Char == ':')
{
  right;
}
find_text('(^:[^:])||(^;)||(^:$)', 0, _regexp);
if(found_str == ';')
{
  up;
  up;
}
up;
up;
block_begin;
@find_previous_bullet;
down;
down;
@center_line;
block_end;

@copy_with_marking_left_on;

@say(fp);
}



//;

void
@find_launch_code_begin_with_uc
{
str fp = 'Find launch codes that begin with word under cursor.';
@header;

str sc = @get_word_under_cursor_or_block;
sc = ' ||\(\!' + sc;

int Is_Found = @seek_in_all_files_2_arguments(sc, fp);

/* Use Case(s)

db

:use my natal credit for juval class or JP trip.

(!db2)

*/

@footer;
@say(fp);
}



//;;

void
@add_colon_after_every_nbl()
{
str fp = 'Add colon after every nonblank line.';

if(!@is_text_file)
{
  return();
}

tof;
while(!at_eof)
{
  if(@trim@(@first_character(get_line)) != '')
  {
    eol;
    text(':');
  }
  down;
}

@say(fp);
}



//;

int
@open_file_unobtrusively()
{
str fp = 'Open file unobtrusively.';

str Filename[128] = parse_str("/FN=", mparm_str);

if(!switch_file(filename))
{
  if(FILE_EXISTS(filename))
  {
    rm('MakeWin /NL=1');
    Return_Str = filename;
    RM('LdFiles'); // Load the file.
    if(Error_Level != 0)
    {
      RM('MEERROR');
    }
  }
}

@say(fp);
}



//;

void
@real_batch_file_tester
{
str fp = "REAL batch file tester.";
@header;

str Clif_Block = 'C:\Documents and Settings\jrj\My Documents\!Savannah\belfry\test.bat';

str Application = Get_Environment("WinDir") +  "\\explorer.exe /n, /e, ";
int int_EP_Return = ExecProg(Application + " " + char(34) + Clif_Block + char(34),
  Get_Environment("TEMP"),
  Get_Environment("TEMP") + '\\multi-edit output.txt',
  Get_Environment("TEMP") + '\\multi-edit error.txt',
  _EP_FLAGS_DONTWAIT | _EP_Flags_ExeWin);

@footer;
@say(fp);
}



//;

void
@fix_bolded_menu()
{
str fp = 'Fix bolded menu.';

str Command_String = 'c:\windows\system32\cmd.exe /k ' + char(34) +
  Get_Environment("savannah") +
  '\belfry\set_my_path_for_bolded_menu.bat' + char(34);

ExecProg(Command_String,
  Get_Environment("userprofile") + '\my documents\!savannah\belfry',
  Get_Environment("TEMP") + '\\multi-edit output.txt',
  Get_Environment("TEMP") + '\\multi-edit error.txt',
  _EP_FLAGS_DONTWAIT | _EP_FLAGS_EXEWIN);

@say(fp);
}



//;

void
@clean_up_the_trid_report
{
str fp = "Clean up the trid report.";

if(!@is_text_file)
{
  return();
}

@header;

int Number_of_Deletions = 0;

Number_of_Deletions += @delete_matching_lines('M.Pontello');
Number_of_Deletions += @delete_matching_lines('Definitions found:  ');
Number_of_Deletions += @delete_matching_lines('Analyzing...');

int File_Counter = @replace_string_in_file_int('Collecting data from ', '');
Number_of_Deletions += File_Counter;

@delete_blank_lines@;

@replace_string_in_file_int('file:', '$:file:');

tof;

fp += ' Deletions made: ' + str(Number_of_Deletions) + '.';
fp += ' Number of Files analyzed: ' + str(File_Counter) + '.';
@footer;
@say(fp);
}



//;

void
@turn_thin_colons_into_subbulls()
{
str fp = "Turn thin colons into subbullets.";

str rs;
str sc;
str so;

sc = '(.)$^(:)';
rs = '\0$$\1:';
right;
so = @replace_all_occurrences_in_file(sc, rs);

@say(so);
}



//;

void
@format_log_file
{
str fp = "Format log file.";
@header;

if(!@is_text_file)
{
  return();
}

@add_blank_line_before_every_nbl;
tof;

tof;
while(!at_eof)
{
  rm('reformat');
}

tof;

@footer;
@say(fp);
}



//;

void
@format_wikipedia_article
{
str fp = 'Format Wikipedia article.';

if(!@is_text_file)
{
  return();
}

@header;

@add_blank_line_before_every_nbl;
@replace_2_blank_lines_with_1;
str sc = '\[edit\] ';
sc = ':';

@footer;
}



//; (skw Format norm file)

void
@format_no_right_margin_file
{
str fp = 'Format no-right-margin file.';
str rs;
str sc;

if(!@is_text_file)
{
  return();
}

@header;
sc = '($^)([^$])';
rs = '\1';

while (!at_eof)
{
  if(find_text(sC, 0, _regexp))
  {
    Replace(rs);
  }
  else
  {
    break;
  }
}

@add_blank_line_before_every_nbl;
tof;
@delete_line;
eof;
@delete_line;

@footer;
@say(fp);
}



//;;

void
@format_rudder_for_printing
{
str fp = 'Format rudder for printing.';
@header;

tof;
while(!at_eof)
{
  if(find_text('::', 0, _regexp))
  {
    Replace('');
    tof;
  }
  else
  {
    break;
  }
}
@delete_blank_lines_in_file;
@add_blank_line_before_every_nbl;

while(!at_eof)
{
  rm('Reformat');
}

@footer;
@say(fp);
}



//;

void
@paste_with_formatting
{
str fp = 'Format clipboard paste.';
@header;

@save_location;
@create_new_file;
@paste@;

@format_text_file;

rm('SelectAll');
rm('CutPlus');
delete_window;

@load_location;

eol;
if(@current_column > 2)
{
  text(': ');
}
mark_pos;
cr;
@paste@;
@negative_twofer;
goto_mark;
del_char;
mark_pos;
@wrap_text;
goto_mark;

@footer;
@say(fp);
}



//; Warning: Dangerous Macro

void
@format_text_file()
{
str fp = 'Format the entire text file.';

if(!@is_text_file)
{
  return();
}

tof;

int Number_of_Replacements = 0;
Number_of_Replacements += @Replace_All_Special_Characters;

@replace_2_blank_lines_with_1;
Number_of_Replacements += @find_Long_Lines_and_format;
// This line has been intentionally repeated. - JRJ Apr-17-2008
Number_of_Replacements += @find_Long_Lines_and_format;
Number_of_Replacements += @hard_format_long_lines_in_file;

// The order of these methods matters in order to properly clean up a file.
@delete_tabs_and_line_feeds_if;
@delete_spaces_at_bol;

Number_of_Replacements = @replace_string_in_file_int('\( ', '(');
Number_of_Replacements = @replace_string_in_file_int('  ', ' ');

tof;
while(!at_eof)
{
  rm('reformat');
}

@say(fp + ' Number of replacements: ' + str(Number_of_Replacements));
}



//;

void
@format_pasted_error_message
{
str fp = 'Format pasted error message.';

if(!@is_text_file)
{
  return();
}

@header;
@replace_2_blank_lines_with_1;

while(@find_next_long_line)
{
  goto_col(95);
  cr;
  tof;
}

@footer;
@say(fp);
}



//;

void
@paste_with_atomica_formatting()
{
str fp = 'Paste with Answers.com formatting.';

mark_pos;
eol;

// Check for an existing colon, before inserting a new one.
str Action_Line = get_line;

Action_Line = @trim_leading_colons(Action_Line);

int Add_Colon = true;
int Add_Space = true;

switch(@last_character(Action_Line))
{
  case ':':
  case '?':
  case '.':
    Add_Colon = false;
    Add_Space = true;
    break;
  case ' ':
    Add_Colon = false;
    Add_Space = false;
    break;
}

if(XPos('lk#', Action_Line, 1))
{
  Add_Colon = false;
  Add_Space = true;
}

if(@column == 2)
{
  Add_Colon = false;
  Add_Space = false;
}

if(Add_Colon)
{
  text(':');
}

if(Add_Space)
{
  text(' ');
}

int Temporary_Cursor_Eob = Global_Int("CURSOR_EOB");

Set_Global_Int('Cursor_Eob', 1); // End of Block

rm('PastePlus /WC=1');

Set_Global_Int('Cursor_Eob', Temporary_Cursor_Eob);

block_begin;
goto_mark;

@format_block@;

@say(fp);
}



//;;

void
@@paste_with_atomica_formatting
{
@header;
@paste_with_atomica_formatting;
@footer;
}



//;

void
@format_block@()
{
str fp = 'Format block.';

if(!@block_is_selected)
{
  return();
}

int Block_Length = block_line2 - block_line1;

goto_line(block_line1);

goto_col(1);

while(find_text('$^', 2, _regexp) + (Block_Length))
{
  Replace(' ');
  Block_Length = Block_Length - 1;
  eol;
}

cr;

goto_line(block_line1);
put_line(remove_space(get_line));

word_wrap_line(0, 1);
goto_line(block_line1);
goto_col(1);
block_off;

@say(fp);
}



//;

void
@format_block_newer()
{
str fp = 'Format block.';

if(!@block_is_selected)
{
  return();
}

int Block_Length = block_line2 - block_line1 + 1;

int Top_of_Block = block_line1;

//@say(str(Block_Length));

word_wrap_line(0, 1);

goto_line(block_line2);

word_wrap_line(0, 1);

int Loop_Counter = 1;

while (@current_line_number >= Top_of_Block)
{
  if(@current_line_number < Top_of_Block)
  {
    fp = 'Broken. LC: ' + str(Loop_Counter);
    break;
  }
  up;
  word_wrap_line(0, 1);
  Loop_Counter++;
}

//@say(fp + ' - LC: ' + str(Loop_Counter) + ' - Top B: ' + str(Top_of_Block) + ' - CL: ' + 
//  str(@current_line_number));

goto_line(Top_of_Block);
@eoc;

block_off;

@say(fp);
}



//;

void
@verify_wild_files_format
{
str fp = "Verify wild file's format.";
@header;

str em = '';

if(length(em) == 0)
{
  em = @find_long_line@;
}
if(length(em) == 0)
{
  em = @find_special_character(char(10));
}
if(length(em) == 0)
{
  em = @find_special_character(char(13));
}
if(length(em) == 0)
{
  em = @find_special_character(char(139));
}
if(length(em) == 0)
{
  em = @find_special_character(char(147));
}
if(length(em) == 0)
{
  em = @find_special_character(char(148));
}

if(length(em) == 0)
{
  fp = 'This wild file is free of annoying content.';
}
else
{
  fp = em;
}

@footer;
@say(fp);
}



//;

void
@format_macro_header_file_addit
{
str fp = "Prepare Macro Header file addition.";

str Regex_Description;
str rs;
str so;

if(!@is_sh_file)
{
  return();
}

@header;

str_block_begin;
eol;

@seek_next(@cmac_function_header, so);

@bol;

delete_block;

@eol;

if(@first_3_characters(found_str) != 'voi')
{
  text(' ');
}

text(' ');
del_char;
@eol;
left;

if(@current_character == ')')
{
  right;
}
else
{
  right; 
  text('()');
}

text(';');
cr;

@footer;
@say(fp);
}



//;

void
@replace_space_at_eof()
{
str fp = "Replace space at EOF.";
@eof;

fp += ' Space NOT FOUND.';
if(@previous_character == ' ')
{
  @backspace;
  fp += ' Space FOUND and REPLACED.';
}

@say(fp);
}



//;

str
@look_up_hexadecimal_replacement(str original_String)
{
str fp = "Look up hexadecimal replacement string.";
str rs;
switch(sc)
{
  case "%3D":
    rs = 'ü';
    break;
  default:
    rs = '-';
}
return(rs);
}



//;;

void
@add_text_bullet_or_block
{
str fp = 'Add text bullet or block.';
@header;

@bol;
text('if(@block_is_selected)');
cr;
text('{');
cr;
text('  @cut;');
cr;
text('}');
cr;
text('else');
cr;
text('{');
cr;
text('  @cut_bullet;');
cr;
text('}');
cr;

@footer;
@say(fp);
}



//;;

void
@add_text_is_not_bullet_file
{
str fp = 'Add text is not bullet file.';
@header;

@bol;
text('if(!@is_bullet_file)');
cr;
text('{');
cr;
text('  return();');
cr;
text('}');
cr;

@footer;
@say(fp);
}



//;;

void
@format_document_2()
{

str fp = 'Format pasted data from a web page in a temporary window.';

if(!@is_text_file)
{
  return();
}

@add_blank_line_if_ln_exceeds_96;
@replace_2_blank_lines_with_1;
while(!at_eof)
{
  rm('reformat');
}
@replace_all_special_characters;

@say(fp);
}



//; (delete_underscores)

void
@commute_underscores_with_spaces
{
str fp = "Replace underscores with spaces on current line.";
@header;

str Subject_Line = get_line;
@bol;
@delete_line;
Subject_Line = @commute_character(Subject_Line, '_', ' ');
put_line(Subject_Line);
eol;
cr;
up;

/* Use Case(s)

test the brick bitch

*/

@footer;
@say(fp);
}



//;

void
@highlight_and_copy_subbullet()
{
str fp = 'Highlight and copy subbullet.';

@highlight_segment;
rm('CutPlus'); // CutPlus without the M=1 means copy('Copy')
@highlight_segment;

@say(fp);
}



//;

void
@delete_bs()
{
str fp = "Delete bullet or subbullet.";

@highlight_segment;
delete_block;

@say(fp);
}



//;

void
@@delete_bs
{
@header;
@delete_bs;
@footer;
}



//;

void
@highlight_segment()
{
str fp = 'Highlight segment.';

@bobsr;
block_begin;

find_text('(^;)||(^:)||(^\#)', 0, _regexp);
if(found_str == ';')
{
  up;
  up;
}
left;

@center_line;
block_end;

@say(fp);
}



//;

str
@current_cursor_position()
{
str fp = "Current cursor position.";

str rv = '';

if(@is_bullet_file)
{
  if(@first_character(found_str) == ':')
  {
    rv = 'bullet';
  }
  else
  {
    rv = 'rubric'; 
  }
}else if(@is_batch_file)
{
  if(@first_character(found_str) == ':')
  {
    rv = 'bullet';
    if(@second_character(found_str) == '_')
    {
      rv = 'rubric';
    }
  }
}

@say(fp);
return(rv);
}



//;

void
@delete_parent_without_children()
{
str fp = 'Delete parent without children.';

if(!@is_bullet_File)
{
  return();
}

if(!@is_bullet)
{
  return();
}

@highlight_segment;
delete_block;

@say(fp);
}



//;

str
@canpaste_parent_without_child()
{
str fp = 'Copy and paste parent without children.';

if(!@is_bullet)
{
  return('');
}

@highlight_segment;
@copy@;
if(@find_next_bsr == 'rubric')
{
  up;
  up;
}
@bol;
@paste@;
text(':');
eol;

@say(fp);
return(fp);
}



//;

void
@copy_and_paste_parent_wo_childr()
{
str fp = 'Copy parent without children.';

if(!@is_bullet)
{
  return();
}

@highlight_segment;
rm('CutPlus');
@highlight_segment;

@say(fp);
}



//;

void
@cut_parent_without_children()
{
str fp = 'Cut parent without children to buffer.';

if(!@is_bullet)
{
  return();
}

@highlight_segment;
rm('CutPlus /M=1');

@say(fp);
}



//;;

void
@copy_manually()
{
str fp = 'Copy manually.';
@copy@;
down;
@say(fp);
}



//;

void
@highlight_rubric@()
{
str fp = 'Highlight rubric.';

right;
find_text(@big_segment, 0, _regexp | _backward);
block_begin;
down;

// This helps for the last Rubric in a file.
if(find_text(@big_segment, 0, _regexp) == 0)
{
  eof;
  down;
}
up;

@say(fp);
}



//;

void
@highlight_rubric_2()
{
str fp = 'Highlight rubric.';

// The reason this sort of works backwards is so that you can see the header in the middle of
// the page.

@find_next_big_segment;
up;
@bol;
block_begin;
@bobs@;
block_end;

@say(fp);
}



//;

void
@highlight_segment_content()
{
str fp = 'Highlight segment content.';

@bobsr;
down;
block_begin;
right;

if(@find_next_bsr == 'rubric')
{
  up;
  up;
}

up;
@bol;
left;
@center_line;
block_end;

@say(fp);
}



//;

void
@@copy_subbullet_now
{
@header;
@copy_and_paste_subbullet;
@footer;
}



//;

void
@copy_rubric_header_below
{
str fp = 'Copy rubric header below.';

if(!@is_rubric_file)
{
  return();
}

@header;

@bobs@;

str Subject_Line = get_line;
str Edited_Subject_Line = Subject_Line;

@find_next_big_segment;

@bol;
cr;
cr;
cr;
cr;
up;
up;
up;
up;

str Current_Character;
int Cursor_Position = 1;
int Position_of_Open_Paren = 0;
str Colon_String = '';
int Length_of_Edited_Subject_Line = length(Edited_Subject_Line);

while(Cursor_Position <= Length_of_Edited_Subject_Line)
{
  Current_Character = Str_Char(Edited_Subject_Line, Cursor_Position);
  if(Current_Character == '(')
  {
    Position_of_Open_Paren = Cursor_Position;
  }
  Cursor_Position += 1;
}

if(Position_of_Open_Paren > 0)
{
  Edited_Subject_Line = str_del(Edited_Subject_Line, Position_of_Open_Paren, 999);
  Edited_Subject_Line = Edited_Subject_Line + '(!)';
}

text(Subject_Line);
goto_col(1);
word_right;
word_right;

@footer;
@say(fp);
}



//;

void
@copy_rubric_header
{
str fp = 'Copy rubric header.';
@header;

goto_col(1);
if(cur_char != ';')
{
  @say('You must be on a rubric line for this macro to work.');
  return();
}

str Subject_Line = get_line;
str Edited_Subject_Line = Subject_Line;
cr;
cr;
cr;
cr;
up;
up;
up;
up;

str Current_Character;
int Cursor_Position = 1;
int Position_of_Open_Paren = 0;
str Colon_String = '';
int Length_of_Edited_Subject_Line = length(Edited_Subject_Line);

while(Cursor_Position <= Length_of_Edited_Subject_Line)
{
  Current_Character = Str_Char(Edited_Subject_Line, Cursor_Position);
  if(Current_Character == '(')
  {
    Position_of_Open_Paren = Cursor_Position;
  }
  Cursor_Position += 1;
}

if(Position_of_Open_Paren > 0)
{
  Edited_Subject_Line = str_del(Edited_Subject_Line, Position_of_Open_Paren, 999);
  Edited_Subject_Line = Edited_Subject_Line + '(!)';
}

text(Subject_Line);
goto_col(1);
word_right;
word_right;
/* Use case(s)
include melib
*/

@footer;
@say(fp);
}



//;

str
@copy_word_under_cursor_to_buf()
{
str fp = 'Copy the following word under the cursor to buffer.';

str Permanent_Word_Delimits = word_delimits;

// What this does in effect is that if you are BEYOND EOL, go left to EOL.
if(at_eol)
{
  eol;
}

if(@at_bol)
{
  @eoc;
}

while((@previous_character == ' ') and (@current_character == ' '))
{
  right;
}

// We are not at the beginning of the word, so move left to the beginning of the word.
if(@is_alphanumeric_character(@previous_character))
{
  word_delimits = "{ (:)\\'!/[]&\"";
  word_left;
  word_delimits = Permanent_Word_Delimits;
}
str_block_begin;
str sc = get_word_in(@define_what_a_word_is);

// Saw this cool line of code in the forums: Forward_Till(Word_Delimits);
if(@previous_character == '.')
{
  left;
}
@copy_with_marking_left_on;

/* Use Case(s)

Use Case - Jan-20-2010
Bob Shook: boshoo@cox.net

Use Case - Dec-24-2009
Königsberg

Use Case - Dec-2-2009: Ampersand should be highlighted.
&regex_Description

Use Case - Sep-2-2009

[_pad_before]

Use Case: If the cursor resides on the letter "L", it should pick up the word
"Label__Communicators".
//Label__Communicators

Use Case: I don't want the final period to show up.
See document: link_double_click.doc.

Use Case:
$test case
test

Use Case:
"%savannah%\Transact_SQL\Add_Data_Package_tiny.sql

rm("@xind_key_assignment /T=1');

rm('@xind_key_assignment /T=1');

:Use Case: Try to get "@first_character".
if((@first_character(get_line)

:e-mail: 7039271233@vtext.com

:Mediterranean

Use Case
first second

*/

@say(@trim_period(fp) + ' "' + sc + '".');
return(sc);
}



//;

void
@highlight_and_copy_current_rubr
{
str fp = "Highlight and copy current rubric.";
@header;

@bor@;
str_block_begin;
@find_next_rubric@;
@bol;

@footer;
@say(fp);
}



//;

void
@copy_rubric_now_2
{
str fp = 'Copy and paste rubric now.';
@header;

@highlight_rubric@;
rm('CutPlus'); // CutPlus without the M=1 means copy('Copy')
down;
rm('PastePlus /WC=1');

@footer;
@say(fp);
}



//;

void
@copy_line
{
str fp = "Copy line.";
@header;

eol;
str_block_begin;
@bol;

@footer;
@say(fp);
}



//;

void
@copy_line_without_colons_to_buf
{
str fp = 'Copy line without colons to buffer.';
@header;

mark_pos;
@eoc;
col_block_begin;
eol;
@copy@;
goto_mark;

/* Use Case(s)

::hey now buddy

*/

@footer;
@say(fp);
}



//;

void
@copy_bullshit_password
{
str fp = 'Copy Bullshit Password.';
@header;

eol;
mark_pos;
str_block_begin;
text('ray479');
block_end;
@copy@;
goto_mark;
str_block_begin;
eol;
delete_block;

/* Use Case(s)

*/

@footer;
@say(fp);
}



//;

void
@copy_with_highlight()
{
str fp = 'Copy with highlight.';
rm('CutPlus');
@highlight_current_line;
@say(fp);
}



//;

void
@highcopy_subbullet_content()
{
str fp = 'Highlight bullet or subbullet contents.';

@bobsr;

int Initial_Line_Number = @current_line_number;

down;
@bol;
if(@find_next_bsr == 'rubric')
{
  up;
  up;
}
if(@current_line_number == Initial_Line_Number)
{
  fp = 'There is no content to highlight.';
}
else
{
  block_begin;
  @bobsr;
  down;
  @center_line;
}

@copy_with_marking_left_on;

@say(fp);
}



//;

void
@highlight_bullet_4@()
{
str fp = 'Highlight bullet.';

block_off;

@bob@;

block_begin;

if(@find_next_br == 'rubric')
{
  up;
  up;
}

@bol;
left;
rm('CenterLn');
rm('CenterLn');

block_end;
}



//;

void
@convert_block_to_uppercase
{
str fp = 'Convert block to uppercase.';
@header;

if(!@block_is_selected)
{
  return();
}

str Subject_Word = copy(get_line, block_col1, block_col2 + 1 - block_col1);
delete_block;
text(caps(Subject_Word));

@footer;
@say(fp);
}



//;

void
@copy_bs_content()
{
str fp = 'Highlight and copy subbullet content.';

@highlight_bs_content;
@copy_with_marking_left_on;

@say(fp);
}



//;

void
@copy_now_without_drag_right
{
str fp = 'Copy now with drag right.';
@header;

if(@is_bullet_File)
{
  @say('This is branch 1 of the wrapper for copy now.');
  @copy_and_paste_bullet;
  @find_next_bullet;
  eol;
}

@footer;
@say(fp);
}



//;

void
@alt_key_copy_wrapper
{
str fp = 'Context sensitive alt key copy.';

//Putting "@header" or "@footer" in this macro messes up "@copy_bullet@" below.

if(@is_bullet_File)
{
  switch(@current_bsr)
  {
    case 'rubric':
      fp += ' Currently undefined.';
      @say(fp);
      break;
    case 'bullet':
      @copy_parent_without_children;
      break;
    case 'subbullet':
      @copy_bullet@;
  }
}
else
{
  // This line is so that bullets in batch files also works.
  @copy_bullet@;
}
}



//;;

void
@control_copy
{
str fp = 'Control plus copy key.';

if(@is_rubric_file)
{
  fp += ' ' + @copy_rubric@;
}
else
{
  fp += ' Currently undefined.';
}

// Don't put a footer here because it turns off the block marking in "s" files.
@say(fp);
}



//;;

void
@alt_key_copy_now_wrapper
{
str fp = 'Alt key copy now wrapper.';
@header;

if(@is_bullet_File)
{
  switch(@current_bsr)
  {
    case 'rubric':
      fp += ' Currently undefined.';
      @say(fp);
      break;
    case 'bullet':
      @copy_parent_without_kids_now;
      break;
    case 'subbullet':
      @copy_and_paste_bullet;
  }
}
else
{
  @copy_and_paste_bullet;
}

@footer;
}



//;

void
@delete_rubric_content
{
str fp = 'Delete rubric content.';
@header;

if(!@is_bullet_file)
{
  return();
}

@highlight_rubric_content;
delete_block;

@bobsr;
eol;

@footer;
@say(fp);
}



//;;

void
@cut_rubric_content
{
str fp = 'Cut rubric content.';
@header;

@highlight_rubric_content;
@cut;

@footer;
@say(fp);
}



//;

void
@copy_la_object_to_lcode_unac()
{
str fp = 'Copy location aware object to launch code unaccompanied.';

int Search_Criterion_Was_Found = 0;
int Initial_Window = @current_window;
int Initial_Line_Number = @current_line_number;
int initial_column = @current_column;

if(@block_is_selected)
{
  @copy_with_marking_left_on;
}
else
{
  @context_aware_highlight_and_cop;
}

// Note this header is late in the game to preserve the block highlighting which is a
// warm and fuzzy for the user.
@header;

str so = @find_launch_code_service_cellar('', search_criterion_was_found, fp);

if(Search_Criterion_Was_Found)
{

  if(@file_is_read_only(fp))
  {
    switch_window(Initial_Window);
    @paste@;
  }
  else
  {
    @paste_before_first_bullet;
    switch_window(Initial_Window);
    goto_col(initial_column);
    goto_line(Initial_Line_Number);
    fp += ' ' + so;
  }
}
else
{
  switch_window(Initial_Window);
  @paste@;
  fp += ' ' + so;
}

@footer;
@say(fp);
}



//;

void
@control_cut
{
str fp = 'Control plus cut key.';
@header;

if(@is_rubric_file)
{
  fp += ' ' + @cut_rubric@;
}
else
{
  fp += ' Currently undefined.';
}

@footer;
@say(fp);
}



//;

void
@control_delete_cs
{
str fp = 'Context sensitive control plus delete key.';
@header;

if(@is_rubric_file)
{
  fp += ' ' + @delete_rubric;
}
else
{
  fp += ' Currently undefined.';
}

@footer;
@say(fp);
}



//;

void
@highlight_rubric_content()
{
str fp = 'Highlight rubric content.';

// I realize there is no "@header" or "@footer" calls here and that there is no function 
// called "@@highlight_rubric_content". When I do create a function with that name, it
// fails to work properly. - JRJ Nov-29-2010

right;
find_text(@big_segment, 0, _regexp | _backward);
down;
down;
block_begin;
down;
// This helps for the last Rubric in a file.

if(find_text(@big_segment, 0, _regexp) == 0)
{
  eof;
  down;
}
up;
up;
up;
//block_end;
rm('CenterLn');
//@center_line;
//MEW_Set_C_Row(cur_Window, 56);

@say(fp);
}



//;

str
@truncate_last_character(str parameter)
{
return(str_del(parameter, length(parameter), 1));
}



//;

void
@find_previous_search_criterion
{
str fp = 'Find previous search criterion.';
@header;

@seek_in_all_files@(Global_Str('previous_search_str'));

@footer;
@say(fp);
}



//;;

void
@add_text_travel_agent_known_lc
{
str fp = 'Add text travel agent for known launch codes.';
@header;

@bol;
text('str Launch_Code = "";');
cr;
text('if(!@find_launch_code_known(fp, Launch_Code))');
cr;
text('{');
cr;
text('  return();');
cr;
text('}');
cr;

str so;
@seek_previous('str Launch_Code', so);
@eol;
left;
left;

@footer;
@say(fp + ' ' + so);
}



//;

void
@add_text_misspelling
{
str fp = 'Add text misspelling.';
@header;

@eol;
left;
if(@current_character != ':')
{
  right;
  text(':');
}
else
{
  right;
}

text(' msp');

@footer;
@say(fp);
}



//;

void
@switch_to_offline_window
{
str fp = "Switch to offline window.";
str Named_Window;

Named_Window = 'broadcast_from_offline.bul';

if(@switch_to_named_window(Named_Window) == 0)
{
  Named_Window = 'GCI.bul';
  @switch_to_named_window(Named_Window);
  @say('Tried to switch to ' + Named_Window + ', but could not find it.');
  return();
}

goto_col(1);
goto_line(3);
@center_line;
@say(fp);

@say(fp);
}



//;

void
@add_bullet_at_offline
{
str fp = "Add bullet at offline.";
@header;

rm("@open_file_with_writability /FN=" + Get_Environment('reach out') +
  "\\Broadcast_from_Offline.bul");

@add_bullet_at_bof;

@footer;
@say(fp);
}



//;

void
@clear_bolded_font_on_toolbar()
{
str fp = "Clear bolded font on toolbar.";

str Command_String = 'c:\windows\system32\cmd.exe /k ' + char(34) +
  Get_Environment("savannah") +
  '\belfry\set_my_path_for_bolded_menu.bat' + char(34);

ExecProg(Command_String,
  Get_Environment("userprofile") + '\my documents\!savannah\belfry',
  Get_Environment("TEMP") + '\\multi-edit output.txt',
  Get_Environment("TEMP") + '\\multi-edit error.txt',
  _EP_FLAGS_DONTWAIT | _EP_FLAGS_EXEWIN);

@say(fp);
}



//;

void
@go_to_next_windows_end_of_file
{
str fp = "Go to next window's end of file.";
@header;

rm('NextWin');
eof;

@footer;
@say(fp);
}



//; (skw return value test)

void
@if_test_macro
{
str fp = "If test macro.";
@header;

int Answer;

Answer = -2;
if(Answer)
{
  fp += ' Answer is: ' + str(Answer);
}

Answer = -1;
if(Answer)
{
  fp += ' Answer is: ' + str(Answer);
}

Answer = 0;
if(Answer)
{
  fp += ' Answer is: ' + str(Answer);
}

Answer = 1;
if(Answer)
{
  fp += ' Answer is: ' + str(Answer);
}

Answer = 2;
if(Answer)
{
  fp += ' Answer is: ' + str(Answer);
}

@footer;
@say(fp);
}



//;

void
@replace_2_spaces_w_1_in_block
{
str fp = "Replace 2 spaces with 1 in BLOCK.";

str rs;
str sc;
str Regex_Description;

if(!@block_is_selected)
{
  return();
}

sc = @space_space@(Regex_Description, rs);

int Block_Length = block_line2 - block_line1 + 1;
int Number_of_Replacements = 0;

@say(str(Block_Length));

goto_line(block_line1);
goto_col(1);

while(find_text(sc, Block_Length, _regexp))
{
  Replace(' ');
  Number_of_Replacements++;
  goto_line(block_line1);
  goto_col(1);
}


/* Use Case(s)

test

tes t

tes t

test

*/

@say(fp + ' Number of replacements: ' + str(Number_of_Replacements) + '.');
}



//;

void
@replace_bracketed_numbers
{
str fp = 'Replace bracketed numbers.';

if(lower(file_name) == lower((Get_Environment('reach out') + '\IT.bul')))
{
  @say('This macro should not be run against the file IT.bul.');
  return();
}

str rs;
str sc;
str so;

@header;
sc = '\[[1-9]\]';
rs = '';
right;

so = @replace_all_occurrences_in_file(sc, rs);

@footer;
@say(fp + ' ' + so);
}



//;

str
@decorate_for_crossline_support(str sC)
{
str fp = 'Decorate for crossline support.';

int Length_of_SC = length(sC);
int Number_of_Dashes = 1;
int Position_Counter = 1;

str rv;
str Current_Character;

while(Position_Counter <= Length_of_SC)
{
  Current_Character = Str_Char(sC, Position_Counter);
  if((Current_Character == ' ') and (Number_of_Dashes <= 4))
  {
    if((Current_Character == ' ') and (Position_Counter == Length_of_SC))
    {
      // User is intentionally searching with a blank at the end of the string, so leave them
      // alone.
      rv += '( )';
      break;
    }
    if((Current_Character == '-') and (Position_Counter == Length_of_SC))
    {
      // User is intentionally searching with a dash at the end of the string, so leave them
      // alone.
      rv += '(-)';
      break;
    }

    // The following line was modified on Jun-15-2010 to support the replacement of 
    // space_bracket and bracket_space issues.
    rv += '()||([\ \-])||($)||([\ \-]$)';
    Number_of_Dashes++;
  }
  else
  {
    rv += Current_Character;
  }
  Position_Counter += 1;
}

return(rv);
@say(fp);
}



//;

str
@get_phrase()
{
str fp = 'Get phrase.';
// Returns text between colons or current line, if second colon is not present.

str rv = '';

@eoc;
while (@current_character != ':' and !at_eol)
{
  rv += @current_character;
  right;
}

@say(fp + ' Phrase: "' + rv + '".');
return(rv);
}



//;

void
@get_phrase_starting_point_searc
{
str fp = 'Get phrase and begin a search for it from a particular launch code.';

str sc = @get_phrase;
sc = @decorate_for_crossline_support(sc);
str launch_Code = @get_up_to_4_chars_from_the_user('Starting point launch code needed.');

if((Launch_Code == 'Function aborted.'))
{
  @say(Launch_Code);
  return();
}

@header;

int Search_Criterion_Was_Found;
str so = @find_launch_code_service_cellar(launch_Code, Search_Criterion_Was_Found, fp);
if(Search_Criterion_Was_Found)
{
   @seek_next(sc, so);
}

@footer;
@say(fp + ' ' + so);
}



//;

void
@go_to_almost_eof
{
str fp = 'Go to almost EOF.';
@header;
eof;
up;
up;
up;
up;
up;
up;
up;
up;
up;
up;
up;
up;
up;
up;
up;
up;
up;
up;
up;
up;
up;
up;
up;
up;
up;
up;
up;
eol;

@footer;
@say(fp);
}



//;

void
@delete_space_at_eol
{
str fp = 'Delete space at eol.';
str rs;
str sc;

if(!@is_s_file)
{
  return();
}

@header;
sc = ' $';
rs = '';

str so = @replace_all_occurrences_in_file(sc, rs);

@footer;
@say(fp + ' ' + so);
}



//;

void
@delete_ambient_spaces
{
str fp = 'Delete ambient spaces.';
@header;

while (@current_character == ' ')
{
  del_char;
}
while (@previous_character == ' ')
{
  back_space;
}

/* Use Case(s)

hey now

*/

@footer;
@say(fp);
}



//;

void
_add_credentials
{
str fp = 'Add credentials.';
@header;

text('Macrocosm: raybass7@gmail.com Oblique: ray479');

@footer;
@say(fp);
}



//;

int
@add_char_before_every_match(str sc, str string_to_Add)
{
str fp = "Add character before every matching line.";

if(!@is_text_file)
{
  return(0);
}

int Number_of_Additions = 0;

tof;
while(!at_eof)
{
  if(find_text(sC, 0, _regexp))
  {
    Replace(string_to_Add);
    Number_of_Additions++;
    down;
  }
  else
  {
    break;
  }
}

str rv = 'Number of lines modified = ' + str(Number_of_Additions) + '.';
@say(rv);
return(Number_of_Additions);

@say(fp);
}



//; (up to, skw portion)

void
_delete_beginning_part_of_line
{
str fp = 'Delete beginning portion of line.';

if(length(@is_mismatched_file(lower(get_extension(File_name)), 'txt')) > 0)
{
  return();
}

@header;

while (!at_eol)
{
  if(cur_char == '"')
  {
    down;
    @bol;
  }
  del_char;
}

@footer;
@say(fp);
}



//;

void
_add_mapquest_template_text
{
str fp = 'Add MapQuest template text.';
@header;
text('http://www.mapquest.com/maps/map.adp?searchtype=address&country=US');
cr;
text('&address=');
cr;
text('&city=');
cr;
text('&state=');
cr;
text('&zipcode=');
up;
up;
up;

@footer;
@say(fp);
}



//;

void
_expose_ascii_character
{
str fp = 'This macro shows the windows equivalent of an ASCII character.';
@header;

fp = char(156);
fp = char(6);
fp = char(150);
fp = char(151);

/* Use Case(s)
*/

@footer;
//text(fp);
@say(fp);
}



//;

void
_open_cmck_unobtrusively
{
rm('@open_file_unobtrusively /FN=%userprofile%\my documents\Savannah
Reach Out\cmac code keepers.bul');
}



//;

str
_find_character_139()
{
str fp = 'Find character 139.';
str em = '';

tof;

if(find_text(char(139), 0, _regexp))
{
  fp = 'Found character 139.';
  em = fp;
}
else
{
  fp = 'Character 139 NOT found.';
}

/* Use Case(s)

*/

@say(fp);
return(em);
}



//;

void
_highlight_and_copy_rubric
{
str fp = 'Highlight and copy rubric.';
@header;

@highlight_rubric@;
rm('CutPlus'); // CutPlus without the M=1 means copy.
@highlight_rubric@;

@footer;
@say(fp);
}



//;

void
_cursor_to_column_47
{
str fp = 'Cursor to column 47.';
@header;

goto_col(47);

@footer;
@say(fp);
}



//;

str
_find_2_blank_lines_in_a_row()
{
str fp = 'Find 2 blank lines in a row.';
str em = '';

str sc = '$$$[^;]';

if(find_text(sc, 0, _regexp))
{
  fp = 'Found blank colon.';
  em = fp;
}
else
{
  fp = '2 blank lines in a row NOT found.';
}

/* Use Case(s)

:
horseshit

:horseshit

:Java based, but similar to C-Sharp.

*/

@say(fp);
return(em);
}



//;

void
_eof()
{
eof;
@center_line;
}



//;

void
@launch_both_audible_apps
{
str fp = 'Launch both audible applications.';

@header;
@run_clif_internally('audl');
@run_clif_internally('audi');
@footer;

@say(fp);
}



//;

void
_find_previous_bsr_shift_key
{
str fp = 'Find previous BSR shift key.';
@header;

if(!@block_is_selected)
{
  block_begin;
}
str found_string = @find_previous_bsr;
up;
if(Found_String == 'rubric')
{
  up;
  up;
}
block_end;

@footer;
@say(fp);
}



//;

void
@replace_subsubbullets_with_subb
{
str fp = 'Replace subsubbullets with subbullets in file.';
str rs;
str sc;
str so;

@header;

tof;
sc = '^:::+';
rs = '::';

so = @replace_all_occurrences_in_file(sc, rs);

/* Use Case(s)

*/

@footer;
@say(fp + ' ' + so);
}



//;

void
_add_daily_rubric_jd_no_bullet
{
str fp = 'Add daily rubric in Junk Drawer with no bullet.';
@header;

@switch_to_named_window('JD.bul');
tof;
eol;
cr;
cr;
cr;
cr;
text(';');
eol;
@add_text_date@;

@footer;
@say(fp);
}



//;

void
_add_daily_rubric_jd
{
str fp = 'Add daily rubric in Junk Drawer.';
@header;

@switch_to_named_window('JD.bul');
tof;
eol;
cr;
cr;
cr;
cr;
text(';');
eol;
@add_text_date@;
tof;
@add_bullet_below;

@footer;
@say(fp);
}



//;

void
_slide_bs_down_to_bs
{
str fp = 'Slide BS down to next BS.';
@header;

@cut_bs;
str Found_BSR = @peek_ahead_2;
if(Found_BSR == 'rubric')
{
  @find_next_big_segment;
  up;
  up;
  fp = 'Found rubric. ' + fp;
}
else
{
  @find_next_bsr;
  fp = 'Find next BSR. ' + fp;
}
rm('paste');

@footer;
@say(fp);
}



//; deprecated

void
@find_launch_code_from_mu_diag(str launch_Code = parse_str('/1=', mparm_str))
{

str fp = 'Find launch code via commands dialogue.';
// Find launch code via commands dialogue box using launch code.

// fp = 'Find Launch Code "' + launch_Code + '" from dialogue.';


int Search_Criterion_Was_Found;

@header;

str so = @find_launch_code_service_cellar(launch_Code, Search_Criterion_Was_Found, fp);

if(Search_Criterion_Was_Found)
{
  @perform_custom_lc_processing_2(@distill_launch_code(launch_Code)); //qkq
}

str Distilled_Launch_Code = @distill_launch_code(launch_Code);

fp = @trim_period(fp) + ' ' + char(34) + Distilled_Launch_Code + char(34) + '. ' + so;

@footer;

@say(fp);
}



//;

void
@copy_bob_to_remote_eor_alone
{
str fp = 'Copy bullet to remote EOR alone.';

if(!@is_bullet_file)
{
  return();
}

int Search_Criterion_Was_Found;
int Initial_Window = @current_window;

int Initial_Line_Number = @current_line_number;
int initial_column = @current_column;

@header;

@copy_bullet@;

str so = @find_launch_code_service_cellar('', Search_Criterion_Was_Found, fp);

if(Search_Criterion_Was_Found)
{
  if(!@file_is_read_only(fp))
  {
    @paste_to_eor;
  }
}
else
{
  fp += ' ' + so; 
}

switch_window(Initial_Window);
goto_line(initial_line_number);
goto_col(initial_column);

@footer;
@say(fp);
}



//;

void
@find_duplicate_launch_code
{
str fp = 'Get launch code on current line and see if it is a duplicate in all open files. ';
str sc = @launch_code;
str Launch_Code;
str so = '';
@header;

if(@is_bullet_file)
{
  //@bobsr; //qkq
}
else
{
}
@bol;

@seek_next(sc, so);
right;
Launch_Code = @copy_word_under_cursor_to_buf;

@seek_in_all_files_2_arguments('!' + Launch_Code + ",|\\)", so);

@footer;
@say(fp + so);
}



//; qkq Remove hardcoded path.

void
@run_current_line_cmac_macro()
{
str fp = 'Run current line CMAC macro.';

str Macro_Name = get_line;

//Macro_Name = Make_Literal_X(Macro_Name);
Macro_Name = @truncate_after_character(Macro_Name, '(');

str Command_Line = "C:\\Program Files\\Multi-Edit 2008\\Mew32.exe";

ExecProg(char(34) + Command_Line + char(34) + ' /R' + Macro_Name,
  Get_Environment("TEMP"),
  Get_Environment("TEMP") + '\\multi-edit output.txt',
  Get_Environment("TEMP") + '\\multi-edit error.txt',
  _EP_FLAGS_DONTWAIT | _EP_Flags_ExeWin);

@say(Macro_Name);
}



//;

void
_move_bs_up_to_bullet
{
str fp = 'Move BS up to bullet.';
@header;

@cut_bs;
str Found_BSR = @find_previous_bullet;
rm('paste');
if(Found_BSR == ";")
{
  fp = 'Invalid operation.';
}

@footer;
@say(fp);
}



//;

void
_move_bs_up
{
str fp = 'Move BS up.';
@header;

@cut_bs;
str Found_BSR = @find_previous_bsr;
if(Found_BSR == 'rubric')
{
  down;
  down;
  @say('Invalid operation.');
}
rm('paste');

@footer;
@say(fp);
}



//;

void
_move_bs_down
{
str fp = 'Move BS down.';
@header;

@cut_bs;
str Found_BSR = @find_next_bsr;
if(Found_BSR == 'rubric')
{
  up;
  up;
}
rm('paste');
@eoc;

@footer;
@say(fp);
}



//;

void
@run_a_batch_of_clifs3
{
str Function_Purpose = "Run a batch of Clifs.";
@header;

@run_clif_internally('calc');
@run_clif_internally('prfx');
@run_clif_internally('mexx');
@run_clif_internally('otme');

@footer;
@say(Function_Purpose);
}



//; (Save_File_With_No_Questions_Asked)

void
_save_file
{
str fp = 'Save file to my temporary location with no questions asked using the first line
 in the file as the filename.';
@header;

goto_line(1);
File_Name = Get_Environment('my_documents') + '\' + get_line() + '.txt';
save_file;

@footer;
@say(fp);
}



//;

void
_cursor_to_first_bsr
{
str fp = 'Cursor to first BSR.';
@header;

tof;
@find_next_bsr;

@footer;
@say(fp);
}



//;

void
_find_again_in_this_file_only
{
str fp = 'Find again, in this file only.';
@header;

mark_pos;
down;

if(find_text(global_str('search_str'), 0, _regexp))
{
  fp = '"' + Global_Str('SEARCH_STR') + '" was found in this file.';
  pop_mark;
}
else
{
  fp = '"' + Global_Str('SEARCH_STR') + '" was NOT found again in this file.';
  goto_mark;
}

@footer;
@say(fp);
}



//; Created primarily to address the cross-rubric line deleting issue. May-23-2007

void
_delete_everything_from_the_end
{
str fp = 'Delete everything from the end of this bullet until the bullet after the next
  rubric.';
@header;

mark_pos;
if(@peek_ahead == 'rubric')
{
  @eor;
  cr;
}
else
{
  @find_next_bullet;
  @bol;
}
block_begin;
@find_next_big_segment;
up;
block_end;
delete_block;
del_line;
del_line;
goto_mark;

@footer;
@center_line;
@say(fp);
}



//; Created primarily to address the cross-rubric line deleting issue. May-23-2007

void
_delete_all_until_next_bullet
{
str fp = 'Delete everything from here until the next rubric bullet.';
@header;
block_begin;
@find_next_big_segment;
up;
block_end;
delete_block;
del_line;
del_line;
@footer;
@center_line;
@say(fp);
}



//;

void
@search_the_suffic_rubric
{
str fp = "Search the Suffic rubric.";
@header;

str Launch_Code = "suff";
if(!@find_launch_code_known(fp, Launch_Code))
{
  return();
}

@find_continuum(9, '');

@footer;
@say(fp);
}



//;

void
@find_next_semicolon()
{
str fp = 'Find next semicolon.';

find_text("^;", 0, _regexp);

@say(fp);
}



//;

void
_add_bullet_at_end_of_now
{
str fp = 'Add bullet at end of now.';
@header;

int Search_Criterion_Was_Found = 0;
int Initial_Window = @current_window;
int Initial_Line_Number = @current_line_number;
int initial_column = @current_column;

str so = @find_launch_code_service_cellar('n', Search_Criterion_Was_Found, fp);

if(Search_Criterion_Was_Found)
{
  if(@file_is_read_only(fp))
  {
    switch_window(Initial_Window);
    @paste@;
  }
  else
  {
    @add_bullet_at_eor;
    fp += ' ' + so;
  }
}
else
{
  switch_window(Initial_Window);
  fp += ' ' + so;
}

@footer;
@say(fp);
}



//;

void
@move_bob_to_completed_items()
{
str fp = 'Move bullet or block to Completed Items.';

if(@is_text_File)
{
  return();
}

if(!@is_bullet_or_subbullet)
{
  return();
}

@header;

int Initial_Window = cur_Window;
int Search_Criterion_Was_Found;
str Destination_Launch_Code = 'comp';

int Current_Line_Number = 0;

if(@block_is_selected)
{
  @cut;
  Current_Line_Number = @current_line_number;
}
else
{
  mark_pos;
  Current_Line_Number = @current_line_number;
  @cut_bullet;
}

if(!@find_launch_code_known(fp, Destination_Launch_Code))
{
  switch_window(Initial_Window);
  rm('paste');
  fp += ' Error.';
}
else
{
  if(@file_is_read_only(fp))
  {
    switch_window(Initial_Window);
    rm('paste');
    fp += ' Error: File is read-only.';
  }
  else
  {
    @paste_after@;
    fp += ' (' + Destination_Launch_Code + ')';
    switch_window(Initial_Window);
    goto_mark;
    @bobsr;
  }
}

@footer;

@say(fp);
}



//;

void
@move_bob_to_jd()
{
str fp = 'Move bullet or block to Junk Drawer.';

if(@is_text_File)
{
  return();
}

if(!@is_bullet_or_subbullet)
{
  return();
}

@header;

int Initial_Window = cur_Window;
int Search_Criterion_Was_Found;
str Destination_Launch_Code = 'jd';

int Current_Line_Number = 0;

if(@block_is_selected)
{
  @cut;
  Current_Line_Number = @current_line_number;
}
else
{
  mark_pos;
  Current_Line_Number = @current_line_number;
  @cut_bullet;
}

if(!@find_launch_code_known(fp, Destination_Launch_Code))
{
  switch_window(Initial_Window);
  rm('paste');
  fp += ' Error.';
}
else
{
  if(@file_is_read_only(fp))
  {
    switch_window(Initial_Window);
    rm('paste');
    fp += ' Error: File is read-only.';
  }
  else
  {
    @paste_after@;
    fp += ' (' + Destination_Launch_Code + ')';
    switch_window(Initial_Window);
    goto_mark;
    @bobsr;
  }
}

@footer;

@say(fp);
}



//;

void
@switch_to_window_saic
{
str fp = 'Switch to window SAIC.';

// Please do not "tomb" this function because I like to contrast this function with the
// function below "@switch_to_named_window_gci".

@header;
@switch_to_named_window('SAIC.bul');
goto_line(3);
@footer;
}



//;

void
@find_double_q@()
{
str fp = 'Find double q.';


str so = '';
str sc = 'q' + 'q';

down;
down;

if(@seek_in_all_files_2_arguments(sc, so))
{
  if(@is_bullet_file)
  {
    @find_next_bsr;
  }
  else
  {
    up;
    @bol;
  }
}
else
{
  so = 'Could not find it, so switch to universal window.';
  @switch_to_universal_window;
  goto_line(3);
  @eoc;
}

@say(fp + ' ' + so);
}



//;

void
@@move_bob_to_completed_items
{
@header;

@move_bob_to_completed_items;

@footer;
}



//;

void
@move_bob_to_completed_items_wme
{
str fp = 'Move bob to completed items with me.';
@header;

@move_bob_to_completed_items;

str Launch_Code = 'jd';

if(lower(file_name) == lower((Get_Environment('reach out') + '\SAIC.bul')))
{
  Launch_Code = 'comp';
}

if(!@find_launch_code_known(fp, Launch_Code))
{
  return();
}

@find_next_bullet;

@footer;
@say(fp);
}



//;

void
@load_buffer_with_Server_2008
{
str fp = 'Load the buffer with the SQL Server 2008 Server name.';
@header;

eol;
mark_pos;
str_block_begin;
text('JONATHANS_HP2\MSSQL_2008');
block_end;
@copy@;
goto_mark;
str_block_begin;
eol;
delete_block;

/* Use Case(s)

*/

@footer;
@say(fp);
}



//;

void
@find_launch_code_ending_2_ltrs
{
str fp = "Find launch code ending in a particular 2 letters.";
str rs;
str so;
int EFBO = true; // Execute First Block Only

@header;
//str sc = '\(||,';
str sc = '';
sc = @launch_code_ending_in_2_letters('sp');
right;

@seek_in_all_files_2_arguments(sc, fp);

/* Use Case(s)

*/

@footer;
@say(found_str);
@say(so);
}



//;

void
@delete_launch_code_from_curline
{
str fp = "Delete launch code from current line.";

@header;

goto_col(1);

str sc = @launch_code;

@say(fp);
if(find_text(sc, 1, _regexp))
{
  str_block_begin;
  while (@current_character != ')')
  {
    right;
  }
  right;
  @delete_block;
}

@footer;
}



//;

void
@find_launch_code_ui()
{
str fp = "Find launch code using user input.";

block_off;

str Launch_Code = @get_up_to_4_chars_from_the_user(fp);
str Distilled_Launch_Code = @distill_launch_code(Launch_Code);

fp = @trim_period(fp) + ' "' + Distilled_Launch_Code + '".';

if(!@find_launch_code_known(fp, Launch_Code))
{
  @say(fp);
  if(Launch_Code == 'Function aborted.')
  {
    @say(Launch_Code);
  }
  return();
}

@say(fp);
}



//;

void
@@find_launch_code_ui
{
@header;
@find_launch_code_ui;
@footer;
}



//;

int
@get_launch_code_from_user(str parm)
{
str fp = 'Get launch code from user.';

str Launch_Code = @get_up_to_4_chars_from_the_user(parm);
if((Launch_Code == "Function aborted."))
{
  @say(Launch_Code);
  return(0);
}

@say(fp);
return(1);
}



//;

void
@convert_ns_lines_to_lowercase()
{
str fp = "Convert nonsentenced lines to lower case, that lines that don't contain a period.";

if(!XPos( ".", get_line,  1))
{
  put_line(lower(get_line));
}

@say(fp);
}



//;

void
@capitalize_first_letter_in_all()
{
str fp = "Capitalize first letter in all lines ending in a period or question mark.";

tof;
while (!at_eof)
{
  if(@last_character(get_line) == '.')
  {
    @convert_line_to_sentence_case;
  }
  down;
}

tof;
while (!at_eof)
{
  if(@last_character(get_line) == '?')
  {
    @convert_line_to_sentence_case;
  }
  down;
}

@say(fp);
}



//;

void
@go_to_macro_definition_uc
{
str fp = 'Go to macro definition, for word under cursor or block.';

@header;

str Macro_Name = @get_word_under_cursor_or_block;

if(@filename == 'project x analysis installation.sql')
{
  @go_to_tsql_definition_loa0(Macro_Name);
}
else
{
  @find_macro_definition@(Macro_Name); 
}

@footer;
}



//; (skw macro header)

str
@find_macro_definition_ui(str sC)
{
str fp = 'Find in macro headers use user input.';
str so = '';

if(sc == '')
{
  sc = @get_user_input(fp);
}

if((sc == "Function aborted."))
{
  @say(sc);
  return('');
}

sc = @cmac_function_header + sc;

@seek_in_all_files_2_arguments(sc, so);

return(so);
@say(fp + ' ' + so);
}



//;

void
@find_in_rubric_headers_use_uc
{
str fp = 'Find in rubric headers, use word or block under cursor.';

@header;

str sc = @get_word_under_cursor_or_block;
fp += ' ' + @find_rubric_header_uc(sc);

@footer;
@say(fp);
}



//; Currently not in use.

void
@paste_before
{
str fp = 'Paste right before next BSR.';
@header;

str Found_String = @find_next_bsr;
if(Found_String == 'rubric')
{
  up;
  up;
}
rm('paste');

@footer;
@say(fp);
}



;(!cg)



//;

void
@find_WOB_from_jonathans_macros()
{
str fp = "Find WOB form BOF of Jonathan's_Macros.s.";

str sc = @get_word_under_cursor_or_block;
str so = '';

@header;

@save_location;

rm("@open_file_with_writability /FN=" + Get_Environment('savannah') +
  "\\cmac\\source code\\Jonathan's_Macros.s");

@bof;

if(!@seek_next(sc, so))
{
  @load_location;
}

@footer;
}



//;

void
@find_wob_from_eof
{
str fp = 'Find word under cursor or block, starting at the end of file and only search this
  file.';

@header;

str sc;
sc = @get_word_under_cursor_or_block;

mark_pos;
eof;

sc = @equate_dashes_and_spaces_wcl(sc);

if(@first_character(sC) == '@')
{
  sC = '\' + sC;
}

set_global_str('search_str', sc);

if(find_text(sc, 0, _regexp | _backward))
{
  pop_mark;
  fp = 'Found in this file.';
}
else
{
  goto_mark;
  fp = "NOT found in this file.";
}

/* Use Case(s)
test

sc = @get_word_under_cursor_or_block;

test
*/

@footer;
@say(fp);
}



//;

void
_find_continuously
{
str fp = 'Find continuously the hardcoded text.';
@header;

str sc = 'working';

Set_Global_Str('SEARCH_STR', sc);

right;
if(find_text(sc, 0, _regexp))
{
  fp = 'Found.';
}
else
{
  fp = 'Hardcoded text NOT found.';
}

@footer;
@say(fp);
}



//;

void
_toggle_universal_window
{
str fp = 'Sets universal window to one of 2 choices.';
@header;

if(Global_Str('Is_Junk_Drawer_Window') == 'True')
{
  Set_Global_Str('Is_Junk_Drawer_Window', 'False');
}
else
{
  Set_Global_Str('Is_Junk_Drawer_Window', 'True');
}

fp = fp + '(' + Global_Str('Is_Junk_Drawer_Window') + ')';

@footer;
@say(fp);
}



//;

void
@toggle_cursor_movement
{
str fp = 'Sets toggle switch to move the cursor down or up one line at a time.';
@header;

if(Global_Str('Move_Cursor_One_Line_At_A_Time') == 'True')
{
  Set_Global_Str('Move_Cursor_One_Line_At_A_Time', 'False');
}
else
{
  Set_Global_Str('Move_Cursor_One_Line_At_A_Time', 'True');
}

fp = fp + '(' + Global_Str('Move_Cursor_One_Line_At_A_Time') + ')';

@footer;
@say(fp);
}



//;

void
_mark_block_to_eof
{
str fp = 'Mark block to EOF.';
@header;

block_begin;
eof;
block_end;

@say(fp);
}



//;

str
@define_word_delimiters()
{
str fp = "Define the word delimiters for a word.";

str rv = '';

rv += "{ (:)\\'!/[]&\";

return(rv);
}



//;

str
@distill_launch_code@(str launch_Code)
{
str fp = 'Distill launch code.';

if(@first_character(launch_Code) == '!')
{
  launch_Code = @trim_first_character(launch_Code);
}

if(@last_character(launch_Code) == ',')
{
  launch_Code = @trim_last_character(launch_Code);
}

if(@last_character(launch_Code) == char(41))
{
  launch_Code = @trim_last_character(launch_Code);
}

@say(fp);
return(launch_Code);
}



//;

str
_decorate_wcl_2(str sc)
{
// Decorate the string with special character and (WITH) cross-line searching enabled.
int Length_of_SC = length(sC);
int Number_of_Dashes = 1;
int Position_Counter = 1;

str Accommodate_Special_Chars;
str Current_Character;

if(xpos(')', sC, 1) > 0)
{
  // Version "2" allows ")". This prevents recursive string maniputlation.
  // return(sC);
}

while(Position_Counter <= Length_of_SC)
{
  Current_Character = Str_Char(sC, Position_Counter);
  if(Current_Character == ' ' or (Current_Character == '-') and (Number_of_Dashes <= 4))
  {
    if((Current_Character == ' ') and (Position_Counter == Length_of_SC))
    {
      // User is intentionally searching with a blank at the end of the string, so leave them
      // alone.
      Accommodate_Special_Chars += '( )';
      break;
    }
    if((Current_Character == '-') and (Position_Counter == Length_of_SC))
    {
      // User is intentionally searching with a dash at the end of the string, so leave them
      // alone.
      Accommodate_Special_Chars += '(-)';
      break;
    }

    // The following line was modified on Jun-15-2010 to support the replacement of 
    // space_bracket and bracket_space issues.
    Accommodate_Special_Chars += '()||([\ \-])||($)||([\ \-]$)';
    Number_of_Dashes++;
  }
  else
  {
    Accommodate_Special_Chars += Current_Character;
  }
  Position_Counter += 1;
}
return(Accommodate_Special_Chars);
}



//;

void
_concatenate_multiple_lines_2()
{
str fp = 'This is the inverse function of Subdivide_Long_Lines and it circuments the 256
  character line limit of the first version of this method.';

@bol;
while(!find_text('$$', 1, _regexp))
{
  eol;
  del_char;
  @bol;
}

@say(fp);
}



//; (skw Replace_Character_in_Argument, Replace Character in Argument)

str
@replace_2_spaces_with_1_in_str(str string)
{
str fp = '';

int Countdown = length(String);
str Current_Character;
str Fixed_Up_String;
str Previous_Character;

while(Countdown)
{
  Current_Character = str_char(String, Countdown);
  if(!((Current_Character == ' ') and (Previous_Character == ' ')))
  {
    Fixed_Up_String = Current_Character + Fixed_Up_String;
  }
  Previous_Character = Current_Character;
  Countdown--;
}

return(Fixed_Up_String);
}



//;

str
@distill_launch_code_old(str launch_Code)
{
str fp = 'Distill launch code.';
str rv = launch_Code;
rv = @trim_first_character(rv);
rv = @trim_after_character(rv, ',');

@say(fp);
return(rv);
}



//;

str
@process_launch_code(str launch_code, int desired_action, str &sO, int initial_window,
  int &Search_Criterion_Was_Found)
{
/*
Historically, this function was broken off from the Execute_Clif funtion in order for
this function to be called independently of that function.

*/

str fp = 'Process launch code.';
str Traceable_Status_Message = '';
str Descriptive_Status_Message = so;

str Pretty_Launch_Code = @truncate_after_character(@trim_first_character(launch_Code), ',');
Traceable_Status_Message = 'Launch Code: ' + Pretty_Launch_Code;

int Initial_Line_Number = @current_line_number;
int initial_column = @current_column;

if(!@seek_in_all_files_2_arguments(launch_Code, sO))
{
  @center_line;
  Search_Criterion_Was_Found = false;
  Traceable_Status_Message += ' PLC Branch 1. Search Outcome: ' + sO;
  Descriptive_Status_Message = ' Launch code was NOT found.';
  return(Descriptive_Status_Message);
}

Search_Criterion_Was_Found = true;

if(Desired_Action == 1)
{
  @center_line;
  Traceable_Status_Message += ' PLC Branch 2. Search Outcome: ' + sO;
  Descriptive_Status_Message = 'Launch code found.';

  if(@is_bullet_file)
  {
    if(@is_rubric)
    {
      @find_next_bsr;
      eol;
    }
    else
    {
      str so2;
      @seek_previous('\(', so2);
    }

  }
  else
  {
    //down;
  }

  return(Descriptive_Status_Message);
}

if(@anatomize_clif(Desired_Action, sO) == 6)
{
  @center_line;
  Traceable_Status_Message += ' PLC Branch 3. Search Outcome: ' + sO;
  Descriptive_Status_Message = 'Add bullet at launch code. ' + 'Launch code: (' +
    @distill_launch_code_old(launch_Code) + ')';

  // What do I call this feature? Auto-Rubric-Population? (skw January) (!arpo)
  switch(@distill_launch_code_old(launch_Code))
  {
    case 'ap':
      text('Apr-');
      @move_bob_to_mor_with_me; // (skw qkq) Remove from production Clif.
      @eol;
      break;
    case 'au':
      text('Aug-');
      @move_bob_to_mor_with_me;
      @eol;
      break;
    case 'de':
      text('Dec-');
      @move_bob_to_mor_with_me;
      @eol;
      break;
    case 'diar':
      @add_text_date@;
      break;
    case 'fe':
      text('Feb-');
      @move_bob_to_mor_with_me;
      @eol;
      break;
    case 'ja':
      text('Jan-');
      @move_bob_to_mor_with_me;
      @eol;
      break;
    case 'ju':
      text('Jun-');
      @move_bob_to_mor_with_me;
      @eol;
      break;
    case 'jul':
      text('Jul-');
      @move_bob_to_mor_with_me;
      @eol;
      break;
    case 'l':
      @add_text_blank_url_here;
      break;
    case 'ma':
      text('May-');
      @move_bob_to_mor_with_me;
      @eol;
      break;
    case 'mar':
      text('Mar-');
      @move_bob_to_mor_with_me;
      @eol;
      break;
    case 'mo': // The seven days of the week.
    case 'tu':
    case 'we':
    case 'th':
    case 'fr':
    case 'sa':
    case 'su':
      @move_bob_to_mor_with_me;
      @eol;
      break;
    case 'no':
      text('Nov-');
      @move_bob_to_mor_with_me;
      @eol;
      break;
    case 'oc':
      text('Oct-');
      @move_bob_to_mor_with_me;
      @eol;
      break;
    case 'se':
      text('Sep-');
      @move_bob_to_mor_with_me;
      @eol;
      break;
    case 'shon':
      @add_text_date@;
      break;
    case 'tsql':
      text('transact-sql 2005 ');
      break;
    default:
  }

  return(Descriptive_Status_Message);
}

// Return home.
switch_window(Initial_Window);
goto_line(Initial_Line_Number);
goto_col(initial_column);
@center_line;

/* Use Case(s)

1. !+p from Contretemps. The cursor should not move in Contretemps.

2. Ctrl+U (Same window). The cursur should stay in your original place.

3. run !+isaa from another window. The Isaac Clif should not be hightlighted unless that's
where you started from.

4. !+macw from Self-Assured. The should not stray from your original position.

*/

return(sO);
}



//;

void
@run_launch_code_internally(str launch_code)
{
str fp = 'Run launch code. Notice the absence of the "header" and "footer" in this method.';
str so;
int Search_Criterion_Was_Found;

int Initial_Window = cur_window;
if(@first_character(launch_Code) != '!')
{
  launch_Code = '!' + launch_Code + ',||\)';
}
@process_launch_code(launch_Code, 0, so, Initial_Window, Search_Criterion_Was_Found);

@say(fp + ' ' + so);
}



//;

str
@clif_router(int desired_action, str launch_code, int &Search_Criterion_Was_Found)
{

// Unknown action determined by structure of the clif line.
int Initial_Window = cur_Window;
int Counter = 1;
str fp = 'EXECUTE Clif remotely.';
str Introduction = fp;
str Launch_Code;
str so;
str Status_Message;

switch(desired_Action)
{
//  case 1: Introduction = 'Find launch code.';
//           break;
  case 2: Introduction = 'Open folder remotely.';
           break;
  case 3: Introduction = 'Edit file remotely.';
           break;
  //case 4: Introduction = 'Open root link.'; Deprecated.
  //         break;
  //case 5: Introduction = "Copy bullet's content to buffer."; Deprecated
  //         break;
  //  case 6: Introduction = 'ADD BULLET at Clif.';
  //           break;
  case 7: Introduction = 'Find launch code AND execute clif.';
           break;
}

if(launch_Code != '')
{
  Launch_Code = launch_Code;
}
else
{
  Launch_Code = @get_up_to_4_chars_from_the_user(Introduction);
}

if((Launch_Code == 'Function aborted.'))
{
  @say(Launch_Code);
  return('Function aborted.');
}

so = Introduction;
Status_Message = @process_launch_code(launch_Code, desired_Action, so, initial_Window,
  Search_Criterion_Was_Found);

@say(Status_Message);
@footer; // This is an exception to the rule standalone footer.
return(Status_Message);
}



//;

str
@execute_clif_remotely_old(int desired_action = parse_int('/DA=', mparm_str), str 
launch_code_arg) { int Seach_Criterion_Was_Found = false; return(@clif_router(desired_Action, 
launch_Code_Arg, Seach_Criterion_Was_Found)); 
}



//;

void
@open_folder_remotely
{
@header;
@execute_clif_remotely_old(2, '');
@footer;
}



//;

void
@edit_file_remotely
{
@header;
@execute_clif_remotely_old(3, '');
@footer;
}



//;

str
@@execute_clif_remotely
{
int Seach_Criterion_Was_Found = false;
@header;
return(@execute_clif_remotely_old(0, ''));
@footer;
}



//; WNB stands for 'with no bullet'.

str
@run_launch_code_wnb(str launch_code = parse_str('/ca=', mparm_str),
                      int &Search_Criterion_Was_Found)
{
str fp = 'Run Launch Code without adding a bullet. ' + caps(launch_Code);

str so;

int Initial_Window = cur_window;

launch_Code = '!' + launch_Code + ',||\)';
@process_launch_code(launch_Code, 1, so, Initial_Window, Search_Criterion_Was_Found);

@say(fp + ' ' + so);
return(so);
}



//; WNB stands for 'with no bullet'.

str
@run_launch_code_wnb_2(str launch_code = parse_str('/ca=', mparm_str),
                      int &Search_Criterion_Was_Found)
{
str fp = 'Run Launch Code without adding a bullet. ' + caps(launch_Code);

str so;

int Initial_Window = cur_window;

launch_Code = '!' + launch_Code + ',||\)';
@process_launch_code(launch_Code, 1, so, Initial_Window, Search_Criterion_Was_Found);

@say(fp + ' ' + so);
return(so);
}



//;

void
@run_launch_code@(str launch_code = parse_str('/parm=', mparm_str))
{
/*
Because this method has calls to the methods @header and @footer, it should NOT be called by
other macros. For that purpose use "@run_launch_code_internally".
*/
str fp = 'Run launch code "' + caps(launch_Code) + '" from menu item.';
str so;
int Search_Criterion_Was_Found;
int Initial_Window = cur_window;

@header;

launch_Code = '!' + launch_Code + ',||\)';
@process_launch_code(launch_Code, 0, so, Initial_Window, Search_Criterion_Was_Found);

@footer;
@say(fp + ' ' + so);
}



//;
/* Use Case(s)

:Since the problem here is a "mispathed" document, Clif should tell us as much.

:C:\Documents and Settings\jonesjona.PXLAB\My Documents\!Savannah\!Work Documents\Plugin
Requirements.doc

[This use case is under debate.]
3. Whether or not there is a period at the beginning of the follwoing line should make no
difference for running in place:

http://msdn.microsoft.com/en-us/library/bb762153(VS.85).aspx

:http://msdn.microsoft.com/en-us/library/bb762153(VS.85).aspx


2.

::CMAC User Guide: C:\Program Files\Multi-Edit 2008\Doc\CMac User Guide.pdf

*/



//;

str
@find_launch_code_service@(str launch_code = parse_str('/parm=', mparm_str))
{
int Search_Criterion_Was_Found = 0;
return (@find_launch_code_service_cellar(launch_Code, Search_Criterion_Was_Found, ''));
}



//; What is the purpose of this macro? Nov-24-2009

void
@find_then_run_clif
{
str fp = 'Find then run Clif.';
@header;

str Clif_to_Find = @get_up_to_4_chars_from_the_user('Enter Clif to find.');
str Clif_to_Run = @get_up_to_4_chars_from_the_user('Enter Clif to run.');

@find_launch_code_service@(Clif_to_Find);
@run_launch_code_internally(Clif_to_Run);

@footer;
@say(fp + ' ' + Clif_to_Find);
}



//;

void
_move_line_to_eof
{
str fp = 'Move bullet to end of file.';
@header;

mark_pos;
@context_sensitive_cut;
eof;
down;
goto_col(1);
rm('Paste');
goto_mark;

@footer;
@say(fp);
}



//; Deprecated: please use "Find_Launch_Code" service.

str
@find_clif_acronym_service_1(str launch_code = parse_str('/CA=', mparm_str),
                    int &Search_Criterion_Was_Found,
                    str Introduction)
{
str fp = 'Find Launch Code with service. ' + caps(launch_Code);

str so;

int Initial_Window = cur_window;

if(launch_Code == '')
{
  launch_Code = @get_up_to_4_chars_from_the_user(Introduction);
}
else
{
  launch_Code = '!' + launch_Code + ',||\)';
}
if((launch_Code == "Function aborted."))
{
  @say(launch_Code);
  return(launch_Code);
}

@process_launch_code(launch_Code, 1, so, Initial_Window, Search_Criterion_Was_Found);

@say(fp + ' ' + so);
return(so);
}



//;

void
_find_rubric_beginning_with
{
str fp = 'Type first letter of rubric where you wish to go:';
@header;

@say(fp);
Read_Key;
str String_to_Find;
String_to_Find = '^';

if(lower(get_extension(File_name)) == "s")
{
  String_to_Find += '//;';
}
else
{
  String_to_Find += ';»';
}

String_to_Find += char(key1);
mark_pos;
tof;
if(Find_Text(String_to_Find,0,_regexp))
{
  fp = 'Found: ' + String_to_Find;
}
else
{
  fp = 'Could NOT Find: ' + String_to_Find;
  goto_mark;
}
right;

@footer;
@say(fp);
}



//;

void
@find_function
{
str fp = 'Find function.';
@header;

int Initial_Window = cur_Window;
int Search_Criterion_Was_Found;

mark_pos;

str so = @find_clif_acronym_service_1('', Search_Criterion_Was_Found, fp);

if(Search_Criterion_Was_Found)
{
  down;
  @bol;
  str_block_begin;
  right;
  str sc = get_word(word_delimits);
  block_end;
  sc = '_' + sc;
  eol;
  @seek_in_all_files@(sc);
}
else
{
  switch_window(Initial_Window);
  rm('paste');
  fp = 'Error: ' + so;
}

@footer;
@say(fp);
}



//;

void
@clif_husk(int desired_action)
{
str fp;
@anatomize_clif(desired_Action, fp);
@say(fp);
}



//;

  case 4: // Go to root link.
    while(Column_Number)
    {
      if(str_char(Clif_Block, Column_Number) == ':')
      {
        Argument = str_del(Clif_Block, 1, Column_Number - 5);
        break;
      }
      Column_Number--;
    }
    // We now have to isolate the base link.
    Clif_Block = Argument;
    Column_Number = 8;
    while(Column_Number < length(Clif_Block))
    {
      if(str_char(Clif_Block, Column_Number) == '/')
      {
        Argument = str_del(Clif_Block, Column_Number, length(Clif_Block));
        break;
      }
      Column_Number++;
    }
    // Root Website: http://www.calavas.com/blah/blah
    Clif_Block = Argument;
    break;
  case 5: // Take a snapshot of the bullet content.
    // @copy_bs_content;
    return(0);
    break;



//; Deprecated: Henceforth, please use "@seek_in_all_files".

int
@find_core(str sc, str &search_outcome, int set_Global_Search_Tag, int search_flags)
{
int Search_Criterion_Was_Found = false;

// Exits the routine if the Global String has not been set at first run.
if(sc == '')
{
  search_Outcome =  'You are searching for nothing.';
  return(Search_Criterion_Was_Found);
}

return(@seek_in_all_files_2_arguments(sC, search_Outcome));
}



//;

int
@find_text_with_search_tag(str sc, str &so, int set_Global_Search_Tag)
{
str fp = 'Find text, search all windows, with search tag.';
int rv = @find_core(sC, sO, set_Global_Search_Tag, _regexp);
return(rv);
}



//;

int
_find_text(str sc, str &so)
{
str fp = 'Find text, search all windows.';
int rv = @find_core(sC, sO, 1, _regexp);
return(rv);
}



//;

int
_find_deprecated(str sc, str calling_function_description)
{
/*
This function is deprecated. Please use "Find_Me_Outer" or "_Find_Core" from now
on. c. Nov-19-2008

*/
str search_Outcome;
int rv = @Find_Text_With_Search_Tag(sc, search_Outcome, 1);
@say(calling_Function_Description + search_Outcome);
return(rv);
}



//;

int
_is_alphabetic_character(str prms_character)
{
// Uppercase letters.
if((ascii(prms_Character)>= 65) && (ascii(prms_Character)<= 90))
{
  return(1);
}

// Lowercase letters.
else if((ascii(prms_Character)>= 97) && (ascii(prms_Character)<= 122))
{
  return(1);
}

// Underscore Character "_"
else if(ascii(prms_Character) == 95)
{
  return(1);
}

// Dash "-"
else if(ascii(prms_Character) == 45)
{
  return(1);
}

return(0);
}



//;

void
_clif_add_bs
{
str fp = 'Add bullet at Clif.';
@header;

str Launch_Code = @get_up_to_4_chars_from_the_user(fp);
if((Launch_Code == "Function aborted."))
{
  @say(Launch_Code);
  return();
}

mark_pos;

If(_find_deprecated(Launch_Code, fp))
{
  goto_col(1);
  if(Cur_Char == ':')
  {
    @add_subbullet_below;
  }
  else
  {
    @add_bullet_below;
  }
}

@footer;
@say(fp);
}



//;

void
_find_normally
{
str fp = 'Find normally.';
@header;

str Text_Between_the_Colons = Get_Line;

Text_Between_the_Colons = @trim_leading_colons(Text_Between_the_Colons);
int Position_Of_Colon = xpos(":", Text_Between_the_Colons, 1);

// This code block allows me to search for Urls.
if(str_del(Text_Between_the_Colons, 5, 999) == 'http')
{
  Position_Of_Colon = 998;
}

Text_Between_the_Colons = str_del(Text_Between_the_Colons, Position_of_Colon, 999);

int Length_of_TBC; // Length of the Text_Between_the_Colons
int Number_of_Dashes = 1;
int Position_Counter = 1;

// Text_Between_the_Colons modified to Accommodate spaces and dashes.

str TBC_Modified_to_Accommodate_SD;

str Current_Character;
Length_of_TBC = length(Text_Between_the_Colons);

while(Position_Counter <= Length_of_TBC)
{
  Current_Character = Str_Char(Text_Between_the_Colons, Position_Counter);
  if((Current_Character == ' ')|(Current_Character == '-') && (Number_of_Dashes <= 4))
  {
    // Working Original - DO NOT DELETE
    // TBC_Modified_to_Accommodate_SD += '()||(-)';

    // Therefore, as a search tip, if you are not sure whether or not life cycle is one word
    // or two, you should type it in as TWO words, and leverage the power of this search
    // function.

    // This Regex will find lifecycle, life cycle or life-cycle.
    // These work: life[\-]*cycle, life *-*cycle

    TBC_Modified_to_Accommodate_SD += '()||(-)||()';

    Number_of_Dashes++;
  }
  else if((Current_Character == '[')|(Current_Character == ']'))
  {
    TBC_Modified_to_Accommodate_SD += '\' + Current_Character;
  }
  else
  {
    TBC_Modified_to_Accommodate_SD += Current_Character;
  }
  Position_Counter += 1;
}

str str_Search_Line = '(^)(:#)||(;)' + TBC_Modified_to_Accommodate_SD;

_find_deprecated(str_Search_Line, "Normal Search: ");

@footer;
@say(fp);
}



//;

void
_find_precisely
{
str fp = "Find precisely. So what we are saying is that, for the purposes of a precise
search, periods, dashes and colons don't matter.";

@header;

str sc = @formatted_search_line;

sc = @decorate_for_special_characters(sc);
sc = '^:@' + sc;
sc += '((:)||($)||(\.))';

_find_deprecated(sc, 'Precise search. ');

@footer;
@say(fp);

/* Use Cases

:better-off

::better off

::better off dead

hi

hi.

ahi

aahi

big hi

hi

:hi

hit

hi.

:hit

::hi.

*/
}



//;

void
_clif_open_root_link_here()
{
@clif_husk(4);
@say('Open root link here.');
}



//;

void
_clif_copy_bullet_content_wp()
{
if(@clif_execute_remotely(5, '')!= 'Function aborted.')
{
  rm('paste');
}
}



//;

void
_clif_copy_bullet_content
{
@header;
@clif_execute_remotely(5, '');
@footer;
}



//;

void
_add_bullet_at_eob
{
str fp = 'Add bullet at end of bullet.';
@header;

@find_next_bullet;
@add_subbullet_above;

@footer;
@say(fp);
}



//;

  if(File_Exists(Clif_Block) == 1)
  {
    fp = 'Run a script file via a file association: ' + Clif_Block;
    switch(lower(Get_Extension(Clif_Block))) // Executable Files *****************
    {
      case 'bat':
      case 'ps1':
      case 'sql':
        @run_this_executable_File(Clif_Block);
        break;
      default:
        // This is useful for opening files with defined file open associations.
        em = ShellExecute(0, "Open", Clif_Block, "", "", 0);
    }
  }



//;

void
_delete_until_next_blank_line
{
str fp = 'Delete everything from here until next blank line.';
@header;

str_block_begin;
@find_next_blank_line;
left;
block_end;
delete_block;

@footer;
@say(fp);
}



//;

void
@paste_to_bor
{
str fp = 'Paste to BOR.';
@header;

@bor;
@find_next_bullet;
@paste@;

@footer;
@say(fp);
}



//;

void
@paste_with_bol
{
str fp = 'Paste after first going to @bol.';
@header;

@bol;
@paste@;

@footer;
@say(fp);
}



//; Somewhat unreliable.

void
@paste_to_rubric_now()
{
str fp = 'Paste block to rubric now.';

goto_col(1);
rm('paste');

@say(fp);
}



//;

void
@move_bullet_or_block_to_junk_dr
{
str fp = 'Move bullet or block to Junk Drawer as subbullet.';

if(!@is_bullet_file)
{
  return();
}

@header;

@save_location;

if(@block_is_selected)
{
  @cut;
}
else
{
  @cut_bullet;
}

if(!@find_known_launch_code@(fp, 'jd'))
{
  @paste@;
  @say(fp);
  @footer;
  return();
}

if(@file_is_read_only(fp))
{
  @load_location;
  @bobsr;
  @paste@;
  @footer;
  @say(fp);
  return();
}

@paste_to_rubric_now;
@load_location;

@footer;
@say(fp);
}



//;

void
@paste_to_rubric
{
str fp = 'Paste block to rubric.';

int Initial_Window = cur_Window;
mark_pos;
str em = @clif_execute_remotely(1, '');
if(em != 'Launch Code NOT found.')
{
  @paste_to_rubric_now;
}
else
{
  fp = em;
}
switch_window(Initial_Window);
goto_mark;

@say(fp);
}



//;

void
@test_trim_first_character
{
str fp = "Test trim first character.";

fp = @trim_first_character('obvious');

@say(fp);
}



//;

void
@test_trim_last_character
{
str fp = "Test trim last character.";

fp = @trim_last_character('obvious');

@say(fp);
}



//;

void
_find_next_bsr_shift_key
{
str fp = 'Find next BSR shift key.';
@header;

if(!@block_is_selected)
{
  block_begin;
}
down;
str Found_String = @find_next_bsr;
up;
if(Found_String == ";")
{
  up;
  up;
}

@footer;
@say(fp);
}



//;

void
@look_up_bullet_or_subbull_info()
{
str fp = 'Look up context sensitive bullet or subbullet information.';

if(!@is_bullet_file)
{
  return();
}

if(@is_rubric)
{
  return();
}

@header;

@look_up_subbullet_information;

@footer;
}



//;

void
@paste_new_bookmark
{
str fp = 'Paste new bookmark.';
@header;

str Launch_Code = "wc";
if(!@find_known_launch_code@(fp, Launch_Code))
{
  return();
}

@delete_current_ln_fr_colon_2eol;
@paste_with_atomica_formatting;

@footer;
@say(fp);
}



//;

str
@find_thin_semicolon()
{
str fp = 'Find line-beginning semicolon with fewer than 3 blank lines before it.';
str em = '';

if(!@is_bullet_file)
{
  return(em);
}

if(find_text('.$^;', 0, _regexp))
{
  fp = 'Use case 1. Found thin semicolon.';
  em = fp;
}
else
{
  fp = 'Use case 1. Thin semicolon NOT found.';
}

if(find_text('.$$^;', 0, _regexp))
{
  fp = 'Use case 2. Found thin semicolon.';
  em = fp;
}
else
{
  fp = 'Use case 2. Thin semicolon NOT found.';
}

if(find_text('.$$$^;', 0, _regexp))
{
  fp = 'Use case 3. Thin semicolon.';
  em = fp;
}
else
{
  fp = 'Use case 3. Thin semicolon NOT found.';
}

/* Use Case(s)

*/

@say(fp);
return(em);
}



//;

str
@find_thin_colon()
{
str fp = 'Find line-beginning colon with fewer than one blank line before it.';
str em = '';

if(!@is_bullet_file)
{
  return(em);
}

if(find_text('.$^:', 0, _regexp))
{
  fp = 'Found thin colon.';
  em = fp;
}
else
{
  fp = 'Thin colon NOT found.';
}

/* Use Case(s)

:Heynow 1

:Heynow 2

*/

@say(fp);
return(em);
}



//;

str
@find_wikipedia_annotation()
{
str fp = 'Find Wikipedia annotations.';
str em = '';

switch(@filename)
{
  case 'cmac code keepers.bul':
  case 'c# code keepers.bul':
  case 'it.bul':
  case "jonathan's_macros.s":
  case 'saic.bul':
    @say('The does not work with this file.');
    return(em);
    break;
}

// Widkipedia Annotation
str sc = '\[[1-9]\]';

if(find_text(sc, 0, _regexp))
{
  fp = 'Found Wikipedia annotation.';
  right;
  em = fp;
}
else
{
  fp = 'Wikipedia annotation NOT found.';
}

@say(fp);
return(em);
}



//;

str
@find_space_at_eol_before_blank()
{
str fp = 'Find space at EOL before blank line.';

// This is valid for both bullet and non-bullet files.

str em = '';
str sc = '.# $$';
str so = '';

if(@seek_next(sc, so))
{
  fp = fp + ' ' + so;
  em = fp;
}
else
{
  fp += ' NOT found.';
}

eol;

/* Use Case(s)

false positive
xx



;positive

:positive

positive

*/

@say(fp);
return(em);
}



//;

str
@find_broken_launch_code()
{
str fp = 'Find broken launch code.';
str em = '';

str sc = '\(!' + char(32);

if(find_text(sc, 0, _regexp))
{
  fp = 'Found broken launch code.';
  right;
  em = fp;
}
else
{
  fp = 'Broken launch code NOT found.';
}

/* Use Case(s)

! ctes)

*/

@say(fp);
return(em);
}



//;

void
@add_cmac_stub_5
{
str fp = 'Add alias CMAC stub.';
str so;

@header;

rm("@open_file_with_writability /FN=" + Get_Environment('reach out') +
  "\\Jonathan's_Macros.s");

@bof;
@seek_next('!' + 'calv', so);
@bol;
cr;
cr;
up;
up;
text('//;');
cr;
cr;
text('void');
cr;
text('@');
@paste@;
eol;
cr;
text('{');
cr;
text('str fp = "Alias function for "');
eol;
@paste@;
eol;
text('.";');
cr;
@paste@;
eol;
text(';');
cr;
text("@say(fp)");
cr;
text('}');
cr;
cr;
@bol;

/* Use Case(s)

delete_block;

*/

@footer;
@say(fp);
}



//;

void
@find_from_jonathans_macros()
{
str fp = "Begin at BOF of Jonathan's_Macros.s.";

rm("@open_file_with_writability /FN=" + Get_Environment('reach out') +
  "\\Jonathan's_Macros.s");

fp = "(Jonathan's_Macros.s)";

@find_continuum(9, 'bof');

@footer;
}



//;

void
@format_block()
{
str fp = 'Format block.';

if(!block_stat)
{
  @say('Error: No block is marked.');
  return();
}

return();

int Block_Length = block_line2 - block_line1;

//goto_col(1);

while(find_text('$^', 2, _regexp) + (Block_Length))
{
  Replace(' ');
  Block_Length = Block_Length - 1;
  eol;
}

cr;
goto_line(block_line1);
put_line(remove_space(get_line));

word_wrap_line(0, 1);
goto_line(block_line1);
goto_col(1);
block_off;

@say(fp);
}



//;

void
@move_bob_to_bor_alone()
{
str fp = 'Move bullet or block to beginning of current rubric alone.';

mark_pos;

if(!block_stat)
{
  @highlight_bullet@;
}

@cut;
@find_previous_rubric;
@find_next_bullet;
goto_col(1);
rm('Paste');
goto_mark;
@bobsr;

@say(fp);
}



//;

void
@@find_from_bof
{
@header;
@find_from_bof('');
@footer;
}



//;

void
@find_wob_from_bof()
{
str fp = 'Find word under cursor or block, starting at the beginning of file.';
str so;

@header;

str sc = @get_word_under_cursor_or_block;

@bof;

@seek_next(sc, so);

@footer;

@say(fp + " " + so + " (" + sc + ")");
}



//;

void
@find_from_bof_with_wob
{
str fp = 'Find from BOF word or block under cursor.';
@header;
@find_from_bof(fp);
@footer;
// test
}



//;

void
@find_dialoglessly()
{
str fp = 'Find in open files: ';
str so = '';

str sc;
if(Parse_Str("/Start_at_BOF=", MParm_Str) == 'True')
{
  fp = 'Find from TOF: ';
}
else if(Parse_Str("/Start_at_Rubric=", MParm_Str) == 'True')
{
  fp = 'Find from beginning of rubric: ';
}

if(Parse_Str("/Find_in_Rubric=", MParm_Str) == 'True')
{
  fp = 'Find in (Rubric header of) open files: ';
}

str sc = @get_user_input(fp);

if((sc == "Function aborted."))
{
  @say(sc);
  return();
}

mark_pos;

if(Parse_Str("/Start_at_BOF=", MParm_Str) == 'True')
{
  tof;
}
else if(Parse_Str("/Start_at_Rubric=", MParm_Str) == 'True')
{
  @find_previous_rubric;
}

sc = @decorate_for_special_chars_wcl(sc);

if(_Find_Text(sc, so))
{
  pop_mark;
}
else
{
  goto_mark;
}

@say(fp + so);
}



//;

void
@@find_dialoglessly
{
@header;
@find_dialoglessly;
@footer;
}



//;

void
@look_up_bullet_information()
{
str fp = 'Look up bullet information.';

str Filename = Truncate_Path(File_Name);

if(Filename == 'JD.bul')
{
  @say('You are in Junk Drawer. There are no true rubrics here.');
  return();
}

fp = @look_up_rubric_information;
fp += ' - ' + @count_bullets;

@say(fp);
}



//;

str
@unified_orred_rubric()
{
str Batch_File_Rubric = "^:_";
str Bullet_File_Rubric = "^;";
str CMAC_and_Javascript_Rubric = "^//;";
str Transact_SQL_Rubric = "^--;";

str Return_String = "(" + Bullet_File_Rubric + ")|(" + Batch_File_Rubric + ")|(" +
  CMAC_and_Javascript_Rubric + ")|(" + Transact_SQL_Rubric + ")";

return(Return_String);
}



//;

void
@create_blank_line_for_pasted_te
{
str fp = 'Create blank line for pasted text.';

@header;
@bol;
cr;
up;
@paste;

@footer;
@say(fp);
}



//;

void
@find_word_under_cursor@()
{
str fp = 'Find word under cursor.';

str so;

str Previous_Character;
str sc;

if(block_stat)
{
  sc = copy(get_line, block_col1, block_col2 + 1 - block_col1);
  str Modified_to_Enable_Crossline;
  str Current_Character;
  int Position_Counter = 1;
  int Length_of_Search_String = length(sc);

  while(Position_Counter <= Length_of_Search_String)
  {
    Current_Character = Str_Char(sc, Position_Counter);

    if(Current_Character == ' ')
    {
      Modified_to_Enable_Crossline += '()||($^)||($^)';
    }
    else if((Current_Character == '[')|(Current_Character == ']'))
    {
      Modified_to_Enable_Crossline += '(\' + Current_Character + ')';
    }
    else
    {
      Modified_to_Enable_Crossline += Current_Character;
    }
    Position_Counter += 1;
  }
  sc = Modified_to_Enable_Crossline;
}
else
{
  sc = @copy_word_under_cursor_to_buf;
  sc = make_literal_x(sc);
  down;
  goto_col(1);
}

if(Parse_Str("/parm=", MParm_Str) == 'bof')
{
  tof;
}

if(Parse_Str("/parm=", MParm_Str) == 'bor')
{
  if(@current_bsr != 'rubric')
  {
    @find_previous_rubric;
  }
}

@seek_next(sc, so);

@say(fp + " " + so + " (" + sc + ")");
}



//;

void
rtx
{

text(lower(file_name));
cr;
text(lower((Get_Environment('savannah') + "\\Jonathan's_Macros.s")));
cr;
text(lower((Get_Environment('savannah') + '\SAIC.bul')));
@say('b');
if(lower(file_name) == lower((Get_Environment('savannah') + "\\Jonathan's_Macros.s")))
{
  @say('h');
}

/* Use Case(s)

c:\documents and settings\jonesjona.pxlab\my documents\!savannah\jonathan's_macros.s
c:\documents and settings\jonesjona.pxlab\my documents\!savannah\jonathan's_macros.s
c:\documents and settings\jonesjona.pxlab\my documents\!savannah\saic.bul
*/

}



//;

void
RT
{
goto_col(140);
while (!at_eol)
{
  if(cur_char == '/')
  {
    down;
    goto_col(140);
  }
  del_char;
}
}



//; WARNING: DANGEROUS MACRO

void
@swap_all_occurrences_in_file(str search_Criterion, str replace_String_Regex)
{
//Function Purpose: Swap all occurrences of a particular search criterion in a file.

int Number_of_Replacements = 0;
tof;
while(!at_eof)
{
  if(find_text(search_Criterion, 0, _regexp))
  {
    Replace(replace_String_Regex);
    Number_of_Replacements++;
    left;
    left;
  }
  else
  {
    break;
  }
}

make_message('Swap all. Number of replacements: ' + str(Number_of_Replacements) + '.');
}



//; WARNING: DANGEROUS MACRO

int
@swap_all_occurrences_in_file_2(str search_Criterion, str replace_String_Regex)
{
//Function Purpose: Swap all occurrences of a particular search criterion in a file.

int Number_of_Replacements = 0;
tof;
while(!at_eof)
{
  if(find_text(search_Criterion, 0, _regexp))
  {
    Replace(replace_String_Regex);
    Number_of_Replacements++;
    left;
    left;
  }
  else
  {
    break;
  }
}

return(Number_of_Replacements);
}



//;

void
RTx
{
@header;

str fp = 'Not found.';
int First_Only = true;
str sc = ' _[A-Z]';
str so = '';
str rs = '\0;';

@find_text_with_case_sensitivity(sc, so);

//if(First_Only){@seek_next(sc, so) fp = 'Next!'; First_Only = false;}
//if(First_Only){@swap_next_occurrence_only(sc, rs); First_Only = false;}
//if(First_Only){@seek_in_all_files_2p(sc, fp); First_Only = false;}
//if(First_Only){@swap_all_occurrences_in_file(sc, rs); First_Only = false;}

@say(fp);

/* Use Case(s)

 _a
 _b
 _C

*/

@footer;
}



//;

void
RTx
{
str fpe = '';
int First_Only = true;
str fp = _Truncate_After_First_Sentence(fpe);
_header;

str SC = 'GetResourceString *\("[1-9]';
str RS = '\0';

if(First_Only){_Seek(SC); First_Only = false;}
if(First_Only){_Swap(SC, RS); First_Only = false;}
if(First_Only){_Swap_ALL(SC, RS); First_Only = false;}

/* Use Case(s)

#2.
GetResourceString("1
1 through 9
GetResourceString("9
but not
GetResourceString("a

#1.
GetResourceString ("2

GetResourceString ("3
but not
GetResourceString("b
*/

_footer;
//say(fp);
}



//;

void
RT
{
str fpe = '';
int First_Only = true;
str fp = _Truncate_After_First_Sentence(fpe);
_header;
str SC = '(")([0-9]#)"\)\;';
str RS = '& //\1';
//if(First_Only){_Seek_Next(SC); First_Only = false;}
//eol;
//text(' ' + '\1');
//if(First_Only){_Swap_Next_Occurrence_Only(SC, RS); First_Only = false;}
if(First_Only){_Swap_All_Occurrences_In_File(SC, RS); First_Only = false;}

/* Use Case(s)

*/

_footer;
//say(fp);
}



//;

void
RT
{
str fpe = '';
int First_Only = true;
str fp = _Truncate_After_First_Sentence(fpe);
_header;
str SC = '(")([0-9]#)("\) \+.+//)(.+)';
str RS = '\0\1\2\1 + \3';
//if(First_Only){_Seek_Next(SC); First_Only = false;}
//if(First_Only){_Swap_Next_Occurrence_Only(SC, RS); First_Only = false;}
if(First_Only){_Swap_All_Occurrences_In_File(SC, RS); First_Only = false;}

/* Use Case(s)

*/

_footer;
//say(fp);
}



//;

void
RT
{

str Currcfa = Hex_Str(Cur_File_Attr);
str makecopy;
str cfatype;

switch (cfa)
{
  case "1":
    cfatype = "Read-Only ";
    break;
  case "2":
    cfatype = "Hidden ";
    break;
  case "4":
    cfatype = "System ";
    break;
  case "20":
    cfatype = "Archive ";
    break;
  default:
    cfatype = "Directory, or combination ";
    break;
}
Make_Message ( "File type: " + cfatype + ", and file size: " +
str(Cur_File_Size) + " bytes.");
}



//;

void 
@Highlight_BS()
{
str fp = 'Highlight bullet or subbullet.';

@go_to_beginning_of_bsr;

if((Cur_Char == ':') or (Cur_Char == ';') or (Cur_Char == '#'))
{
  right;
}
find_text('(^;)||(^:)||(^\#)', 0, _RegExp);
if(found_str == ';')
{
  up;
  up;
}
up;
block_begin;
@Find_Previous_BSR;
@center_line;
block_end;

@say(fp);
}



//;

void
RTxM
{

Requirements.doc';

str My_Path = '';

int Counter = length(Test_the_Path);
while(Counter)
{
  if(str_char(Test_the_Path, Counter) == '\')
  {
    break;
  }
  Counter--;
}

My_Path = copy(Test_the_Path, 1, --Counter);

//@say(My_Path);
//return();

Change_Dir(My_Path);
if (Error_Level != 0)
{
  Make_Message('Error changing directory');
  Error_Level = 0;
}
/* Use Case(s)

::C:\Documents and Settings\jonesjona.PXLAB\My Documents\!Savannah\!Work Documents\Plugin 
Requirements.doc


*/
}



//;

void 
_Paste_Rubric_Content_Here()
{
str fp = 'Paste remote rubric content here.';
@header;

str Launch_Code = _Get_Up_To_4_Chars_From_User(fp);

if((Launch_Code == "Function aborted."))
{
  @say(Launch_Code);
  return();
}
int Initial_Window = cur_Window;
mark_pos;

if(!_Find_Deprecated(Launch_Code, fp))
{
  return();
}

_copy_rubric_content;

switch_window(Initial_Window);
goto_mark;

insert_mode=1;
goto_col(1);
del_line;
del_line;
rm('paste');

@footer;
@say(fp);
}



//;

void 
_Paste_Daily_Rubric_Here()
{
str fp = 'Paste rubric daily here';
@header;

int Initial_Window = cur_window;
mark_pos;

if(!_Find_Deprecated('!' + 'dail', fp))
{
  return();
}

_copy_rubric_content;

switch_window(Initial_Window);
goto_mark;

insert_mode=1;
goto_col(1);
del_line;
del_line;
rm('paste');

@footer;
@say(fp);
}



//;

  while(cur_char == ':')
  {
    right;
  }
  Previous_Character = copy(get_line, c_col - 1, 1);
  while(_Is_Alphanumeric_Character(@Previous_Character) && (c_col != 1))
  {
    left;
    Previous_Character = copy(get_line, c_col - 1, 1);
  }
  SC = get_word_in('@é-_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');



//;

void 
_Move_BS_Up_and_Reverse_Roles()
{
str fp = 'Move BS up and reverse roles.';
@header;

@eoc;
if(c_col == 2)
{
  @Find_Next_BSR();
}
goto_col(1);
_Cut_BS();
str Found_BSR = @Find_Previous_BSR();
if(Found_BSR == 'rubric')
{
  down;
  down;
  @say('Invalid operation.');
}
rm('paste');
goto_col(1);
del_char;
@Find_Next_Bullet();
text(':');
@Find_Previous_BSR();

@footer;
@say(fp);
}



//;

void
_Add_Rubric_Below_Clif_Acronym()
{
str fp = 'Add rubric below Launch Code.';

int Initial_Window = cur_Window;
int Search_Criterion_Was_Found;
mark_pos;

str SO = _Find_Clif_Acronym_Service_1('', Search_Criterion_Was_Found, fp);

if(Search_Criterion_Was_Found)
{
  str Current_File_Attribute = Hex_Str(Cur_File_Attr);
  if(Current_File_Attribute == '1')
  {
    switch_window(Initial_Window);
    rm('paste');
    _say('Error: File is read-only, so cannot paste.');
  }
  else
  {
    _Add_Rubric_Below;
    _say(fp);
  }
}
else
{
  switch_window(Initial_Window);
  rm('paste');
  _say('Error: ' + SO);
}
}



#include win32.sh
#include dialog.sh
#include Messages.sh
#define ECombo1 2001
#define EButton1 2002
void initwindow(int dlg = parse_int( "/DLGHANDLE=", mparm_str ) )
{
int hctrl = GetDlgItem(dlg, ECombo1);
str n = 'Another Item';
SendMessageStr( hctrl, cb_addstring, 0, n);
n = 'Last Item';
SendMessageStr( hctrl, cb_addstring, 0, n);
}



//;

void
RTestM
{
//str test = str(SendMessage( GetParent( 0 ), wm_gettext, 250, 0));

//str test = str(SendMessage (Window_Handle, wm_GetText, 0, 0)); 
//text(test);0
//SendMessage( ctrl.whandle, lb_SetHorizontalExt, jx * font_width, 0 );
}



//; This is how you run a shortcut through Multi-Edit. Oct-17-2008

void 
_run_shortcut_link_file_in_me
{
// (skw how to do shortcuts in Multi-Edit.
str Command_String = 'c:\windows\system32\cmd.exe /c' + 'c:\\ex.lnk';
ExecProg(Command_String,
  Get_Environment("userprofile") + '\my documents\!savannah\belfry',
  Get_Environment("TEMP") + '\\multi-edit output.txt',
  Get_Environment("TEMP") + '\\multi-edit error.txt',
  _EP_FLAGS_DONTWAIT | _EP_FLAGS_EXEWIN);
_say('test at: ' + time);
}



//; Commented Seek code.

//if(Desired_Action == 6) 
//{
//  Status_Message += ' PLC Branch 2. Search Outcome: ' + sO;
//  Descriptive_Status_Message = 'Add bullet at launch code.';
//  return(Descriptive_Status_Message);
//}
//
//
//if(_Clif_Kernel(Desired_Action, sO))
//{
//  Status_Message += 'PLC Branch 3. Search Outcome: ' + sO;
//  Descriptive_Status_Message = 'This block executes Clifs. DO NOT delete.';
//  return(Descriptive_Status_Message);
//}




//if(_Seek_In_All_Files(sC, search_Outcome) == 1)
//{
//  return(1);
//}


//search_Outcome = 'Search criterion was NOT found.';
//_say(search_Outcome);
//return(Search_Criterion_Was_Found);

//int Initial_Line_Number = _Current_Line_Number;
//int Window_Counter = 0;
//mark_pos;
//right;
//
//do
//{
//  Window_Counter++;
//  // Search bottom part of the file.
//  if(_Seek_Next(sC))
//  {
//    search_Outcome = 'Found in window #' + str(Window_Counter) + '.';
//    pop_mark;
//    return(1);
//  }
//  else
//  {
//    goto_mark;
//    rm('NextWin');
//    mark_pos;
//    tof;
//  }
//} while(cur_window != Initial_Window);
//
//// Search top part of initial window.
//if(_Seek_Next(sC))
//{
//  search_Outcome = 'Found in top part of initial window.';
//  if((_Current_Line_Number == Initial_Line_Number) or (_Current_Line_Number == 
//    Initial_Line_Number - 2)) 
//  { 
//    search_Outcome = 'This is the ONLY occurrence in all open files.';
//    _say(search_Outcome);
//  } 
//  pop_mark;
//  return(1);
//} 
//else 
//{ 
//  goto_mark;
//}



//; Orignal Multi-Window Find Text

str Starting_File_Position = "File: " + file_name + " at Line " + str(c_line);
mark_pos;
eol;

// Search current window first.
If(find_text(SC, 0, search_Flags))
{
  right;
  search_Outcome = 'FOUND in bottom part of initial window.';
  Search_Criterion_Was_Found = true;
  pop_mark;
  return(Search_Criterion_Was_Found);
}
else
{
  goto_mark;
  rm('NextWin');
}

// If cur_window equals Initial_Window, then you know that all of the windows have been
// searched so you exit the routine and need not execute the while loop.
while(cur_window != Initial_Window)
{
  mark_pos;
  tof;
  If(find_text(SC, 0, search_Flags))
  {
    pop_mark;
    right;
    search_Outcome = 'FOUND in another window.';
    Search_Criterion_Was_Found = true;
    return(Search_Criterion_Was_Found);
  }
  else
  {
    goto_mark;
    rm('NextWin');
  }
}

// Search initial window from BOF to marked position.
mark_pos;
tof;
if(find_text(SC, 0, search_Flags))
{
  pop_mark;
  str Ending_File_Position = "File: " + file_name + " at Line " + str(c_line);

  if(Starting_File_Position == Ending_File_Position)
  {
    search_Outcome = 'This is the ONLY occurrence in all open files.';
  }
  else
  {
    search_Outcome = 'FOUND in top part of initial window.';
  }
  Search_Criterion_Was_Found = true;
  return(Search_Criterion_Was_Found);
}
else
{
  goto_mark;
}



//;

void
_Find_Double_Q()
{
str fp = 'Find double q.';
str SO; // SO stands for Search Outcome.
_header;

int Found=true;
block_off;

_Save_Window_Location();

//if( _Find_Text_With_Search_Tag('qg' + 'q', SO, 0))
//{
//  fp = 'Find gold medal q.';
//}
if (_Find_Text_With_Search_Tag(char(113) + char(113), SO, 0))
{
  fp = 'Find double q.'; // Silver medal q.
}
//else if (_Find_Text_With_Search_Tag('qb' + 'q', SO, 0))
//{
//  fp = 'Find bronze medal q.';
//}
//else if (_Find_Text_With_Search_Tag('ql' + 'q', SO, 0))
//{
//  fp = 'Find q with move down a line.';
//  if(_Is_Bullet_Type_File)
//  {
//    _Find_Next_BSR;
//  }
//  else
//  {
//    down;
//  }
//}
//else if (_Find_Text_With_Search_Tag('^rt' + 'm', SO, 0))
//{
//  fp = 'Find rt+m.';
//}
//else if (_Find_Text_With_Search_Tag('Non-Affinity File ' + 'Flag', SO, 0))
//{
//  fp = 'Find Non-Affinity File.';
//}
else
{
  SO = 'Could not find what I was looking for, so switched to universal window.';
  _Switch_to_Window_Universal();
  _EOC;
}

/* Use Case(s)

#2. q bq

#1. q bq

*/

_Clear_Markers();

_footer;
_say(fp + ' ' + SO);
}



//;

int
_Seek_In_All_Files(str sC, str &sO)
{
str fp = 'Find in all files.';
_header;

int Current_Line = _Current_Line_Number;
int Initial_Window = cur_Window;
int Window_Counter = 0;

do
{
  Window_Counter++;
  mark_pos;
  if(_Seek_Next(sC))
  {
    pop_mark;
    sO = 'Found in window #' + str(Window_Counter) + '.';
    return(1);
  }
  else
  {
    goto_mark;
    rm('NextWin');
    tof;
  }
} while(cur_window != Initial_Window);

mark_pos;
tof;
if(_Seek_Next(sC))
{
  if(_Current_Line_Number == Current_Line)
  {
    sO = 'Only occurrence in all open files.';
    _say(sO); 
  }
  pop_mark;
  return(1); 
}
else
{
  goto_mark;
}

_footer;
sO = 'Search criterion NOT found.';
_say(sO);
return(0);
}



//;

void
RTx
{
//str_block_begin;
//str SC = get_word(word_delimits);
rm('Cut /NEM=1');
//right;
//_copy;
}



//;

void 
_Move_Bullet_To_Next_Rubric()
{
str fp = 'Move bullet to next rubric.';
_header;

mark_pos;
_Highlight_Bullet;
rm('CutPlus /M=1');
delete_block;
_Find_Next_Rubric();

/* Use Case(s)

1. Rubric may be empty.

2. Rubric header; may span more than a single line.

*/

_Paste_Block_To_Rubric_Now();
goto_mark;

_footer;
_say(fp);
}



//;

void
_Add_Text_An_Plugin()
{
str fp = 'Add text AN Plugin.';
_header;

text('AN_Plugin__');

/* Use Case(s)

*/

_footer;
_say(fp);
}



//;

void
_Select_Next_Bs()
{
str fp = 'Select next bs.';
_header;

_bol;
if(!block_stat) // A block is marked.
{
  str_block_begin;
}
if(_find_next_bsr == 'Rubric')
{
  up;
  up; 
}
_bol;

/* Use Case(s)

*/

_footer;
_say(fp); 
}



//;

void
_Put_a_Space_Before_Equal_Signs
{
str fpe = '';
int First_Only = true;
str fp = _Truncate_After_First_Sentence(fpe);
_header;
str SC = '';
str RS = '\0';
if(First_Only){_Seek_Next(SC); First_Only = false;}
if(First_Only){_Swap_Next_Occurrence_Only(SC, RS); First_Only = false;}
if(First_Only){_Swap_All_Occurrences_In_File(SC, RS); First_Only = false;}

/* Use Case(s)

*/

_footer;
//say(fp);
}



//;
//#include Win32.sh

void _Run_Program_in_Background()
{
int Result;
str Command_String;

//Command_String = 'C:\\Program Files\\mozilla.org\\SeaMonkey\\seamonkey.exe';

Command_String = 'c:\\windows\\system32\\calc.exe'; 
Command_String = 'c:\\windows\\system32\\mspaint.exe'; 
Command_String = "c:\\program files\\safari\\safari.exe";
Command_String = "c:\\program files\\mozilla firefox\\firefox.exe"; 
Command_String = 'c:\\program files\\internet explorer\\iexplore.exe';

//This works.
//Result = ShellExecute( 0, "open", Command_String, "", "", sw_ShowMaximized );
//Result = ShellExecute( 0, "open", Command_String, "", "", sw_Maximize );

//These don't work.
//Result = ShellExecute( 0, "open", Command_String, "", "", sw_Hide );
//Result = ShellExecute( 0, "open", Command_String, "", "", sw_ShowNormal);
//Result = ShellExecute( 0, "open", Command_String, "", "", sw_ShowMinimized );
//Result = ShellExecute( 0, "open", Command_String, "", "", sw_ShowNoActivate );
//Result = ShellExecute( 0, "open", Command_String, "", "", sw_Show );
//Result = ShellExecute( 0, "open", Command_String, "", "", sw_Minimize );
//Result = ShellExecute( 0, "open", Command_String, "", "", sw_ShowMinNoActive );
//Result = ShellExecute( 0, "open", Command_String, "", "", sw_ShowNA );
//Result = ShellExecute( 0, "open", Command_String, "", "", sw_Restore );
//Result = ShellExecute( 0, "open", Command_String, "", "", sw_ShowDefault );
//Result = ShellExecute( 0, "open", Command_String, "", "", sw_Max );

int Flags;

Flags |= _EP_Flags_Minimized; // Show window in minimized state.
Flags |= _EP_Flags_Hide;      // Hide window.

/*
Annoyingly enough Microsoft paint works like you'd expect it. However, I couldn't any of the 
three browser to respect the sw_ShowMinNoActive command. They would respect the maximize 
command, which is a big help.

worked like a chump

up a tree without a paddle

Flags |= _EP_Flags_NoBypass;  // Do not display Bypass dialog.
Flags |= _EP_Flags_DontWait;  // Do not wait for program to complete.
Flags |= _EP_Flags_RunBkg;    // Run program in the background.

//Command_String = 'c:\\windows\\system32\\calc.exe'; 
Command_String = "c:\\program files\\mozilla firefox\\firefox.exe";

ExecProg(char(34) + Command_String + char(34), '', '', '', Flags);
*/


/* ShowWindow( ) Commands
#define   sw_Hide             0
#define   sw_ShowNormal       1
#define   sw_Normal           1
#define   sw_ShowMinimized    2
#define   sw_ShowMaximized    3
#define   sw_Maximize         3
#define   sw_ShowNoActivate   4
#define   sw_Show             5
#define   sw_Minimize         6
#define   sw_ShowMinNoActive  7
#define   sw_ShowNA           8
#define   sw_Restore          9
#define   sw_ShowDefault      10
#define   sw_Max              10
*/

/*
 Returns a value greater than 32 if successful, or an error value that is less than or equal 
 to 32 otherwise. http://msdn.microsoft.com/en-us/library/bb762153(VS.85).aspx

*/

make_message("Result="+str(Result));
}



//;

void
_Remove_All_Skws_From_File()
{
str fpe = 'Remove all SKWs from file. Warning: Dangerous macro.';

if(length(_Is_Mismatched_File(lower(get_extension(File_name)), 'txt')) > 0)
{
  return();
}

_header;

int First_Only = true;
str fp = _Truncate_After_First_Sentence(fpe);
str sc = ' \(.+\)';
str RS = '';

sc = _Decorate_WCL_2(sc);
_Log2('SC Jul-7-2008:' + sc);

if(First_Only){_Swap_All_Occurrences_In_File(SC, RS); First_Only = false;}

_footer;
//say(fp);
}



//;

void
_Remove_Remaining_Blank_Lines_IF()
{
str fpe = 'Remove remaining blank lines in the file.';
int First_Only = true;
str fp = _Truncate_After_First_Sentence(fpe);
_header;
str SC = '$$';
str RS = '';

while(!at_eof)
{
  _Swap_Next_Occurrence_Only(SC, RS);
  _bol;
  down;
}

_footer;
_say(fp);
}



//;

void
_Copy_Bullet_Essence_Now()
{
str fp = 'Copy bullet essence now.';
str qs = _Truncate_After_First_Sentence(fp);
_header;
str Bullet_Essence = get_line;
Bullet_Essence = _Trim_Leading_Colons(Bullet_Essence);
Bullet_Essence = _Truncate_After_Character(Bullet_Essence, ':');
_Add_Subbullet_Below();
text(Bullet_Essence);

/* Use Case(s)

:birds of a feather: blah blah

*/

_footer;
_say(qs);
}



//;

void
_Hello_World_from_a_Test_Macro
{
str fp = 'Hello World from a test macro.';
_say(fp);
}



//; (Remove Blank Lines, _Remove_Blank_Lines, Remove All Blank Lines)

void
_Remove_All_Blank_Lines_fr_File()
{
str fp = 'Remove all blank lines from file.';

if(length(_Is_Mismatched_File(get_extension(File_name), 'txt')) > 0)
{
  return();
}

_header;

int First_Only = true;
str SC = '';
str RS = '';
SC = '$$';
RS = '\0';
if(First_Only){_Swap_All_Occurrences_In_File(SC, RS); First_Only = false;}
_footer;
_say(fp);
}



//;

void
_Add_SKW()
{
str fp = 'Add skw here.';
_header;

text(' (!)');
left;

_footer;
_say(fp);
}



//;

void
_Find_Date_Format_1()
{
str fp = '';
_header;

str SC = '^:[0-9]*[0-9]/[0-9]*[0-9]/[0-9][0-9]+';
right;
if(find_text(SC, 0, _RegExp))
{
  fp = 'Found: ' + found_str + '.';
}
else
{
  fp = 'NOT found.';
}
Set_Global_Str('SEARCH_STR', SC);

_footer;
_say(fp);
}



//;

void
_Add_Bullet_To_Cerain_Lines()
{
str fp = 'Add bullet to cerain lines.';
_header;

str SC = '^.*100 Best Restaurants';
int Number_of_Replacements = 0;
tof;
while(!at_eof)
{
  if(find_text(SC, 0, _RegExp))
  {
    replace(':&');
    Number_of_Replacements++;
  }
  else
  {
    break;
  }
}
fp = 'Number of replacements = ' + str(Number_of_Replacements);


/* Use Case(s)

*/

_footer;
_say(fp);
}



//;

void
_Add_Blank_Line_Before_Cetain_Ln()
{
str fp = 'Add blank line before cetain lines.';
_header;

str SC = '';
SC = '^.+100 Best';
int Number_of_Replacements = 0;
tof;

while(!at_eof)
{
  if(find_text(SC, 0, _RegExp))
  {
    Replace('$&');
    fp = 'Found: ' + found_str + '.';
  }
  else
  {
    break;
    fp = 'NOT found.';
  }
}

fp = 'Number of replacements = ' + str(Number_of_Replacements);

_footer;
_say(fp);
}



//;

void
_Find_Missing_Else_Statements()
{
str fp = 'Find missing else statements.';
_header;

str SC = '';
SC = '}${';
tof;
if(find_text(SC, 0, _RegExp))
{
  fp = 'Found: ' + found_str + '.';
}
else
{
  fp = 'NOT found.';
}

/* Use Case(s)

}
{

*/

_footer;
_say(fp);
}



//;

void
_Find_Misformatted_Things()
{
str fp = 'Find misfrmatted things. ';
str SO = '';
_header;

str SC = '';
SC = '([^0-9:] nid)||([^0-9:] msp)||([^0-9:] pym)';

if(_Find_Text(SC, SO))
{
  fp = 'Found: ' + found_str + '.';
}
else
{
  fp = 'NOT found.';
}

_footer;
_say(fp + SO);
}



//;

void
_Find_Case_of_Missing_Parens()
{
str fp = "Find cases of 'skw' where the parentheses are missing.";
str SO = '';
_header;

str SC = '\(![^)]+$[^)]*$[^)]*$';

/* Use Case(s)

File (!tfcm, 
! cmac) Non-Affinity File

File (!tfcm, 
!cmax Non-Affinity File

(!abcd)

no space
(!abc

with space
(!abc

(s)

(s

no space
(!

bb

aa

aabb

with space
(!

(!)

(!))

File () Non-Affinity File

File (!tfxx

File (!tfc

*/

if(_Find_Text(SC, SO))
{
  fp = 'FOUND SKW string.';
}
else
{
  fp = 'SKW string NOT found.';
}

_footer;
_say(fp + ' ' + SO);
}



//;

void
_Shell_Execute()
{
//rm('LaunchURL /M=0');

str str_URL = get_line();
//ShellExecute( 0, "open", str_URL, "", "c:\\!", 0 );

//This works.
int Error_Message; 
Error_Message = ShellExecute( 0, "open", str_URL, "", "", 0 );

/* Use Case(s)

:%userprofile%\my documents\!Savannah\Clif Version 3\test.txt

:%userprofile%\my documents\!Savannah\Clif Version 3\test.bul

:%userprofile%\my documents\!Savannah\Chartreuse.bul

:c:\windows\system32\notepad.exe "%userprofile%\my 
documents\!Savannah\Chartreuse.bul"

:http:\\www.cnn.com

%userprofile%\my documents\!Savannah\Chartreuse.bul


C:\Program Files\system
http://www.cnn.com 
c:\!\j.txt
*/
//_Log(str(Error_Message));
_say(str(Error_Message));
}



//;

void
_Make_Bullets()
{
str fp = 'Make bullets.';
_header;
int First_Only = true;
str SC = '';
str RS = '';
SC = '^[^:]';
RS = '$:&';
if(First_Only){_Swap_Next_Occurrence_Only(SC, RS); First_Only = false;}

_footer;
//say(fp);
}



//;

void
_Fix_Numbers_Without_Line_Breaks()
{
str fp = 'Fix numbers without line breaks.';
_header;
str SC;
str RS;
// Numbers Without Line Breaks
SC = '([1-9][0-9]*\.)';
RS = '$$:\0';
_Swap_Next_Occurrence_Only(SC, RS);

_footer;
_say(fp);
}



//;

void
_Fix_Missing_Blank_Lines()
{
str fp = 'Fix missing BOL colons.';
_header;
str SC = '^.';
str RS = '$&';
_Swap_Next_Occurrence_Only(SC, RS);
_footer;
_say(fp);
}



//;

void
_Fix_Missingbol_Colons()
{
str fp = 'Fix missing BOL colons.';
_header;
str SC = '';
str RS = '';
// Missing BOL Colons
SC = '$$([^;:])';
RS = '$$:\0';
_Swap_Next_Occurrence_Only(SC, RS);
_footer;
_say(fp);
}



//;

void
_Delete_Word_Multiple_Times()
{
str fp = 'Delete word multiple times.';
_header;

_Delete_Word_Aggressively;
_Delete_Word_Aggressively;
_Delete_Word_Aggressively;

/* Use Case(s)

There is a whole lot of horseshit, including lumpy shit, on this line that I want to get rid 
There is a whole lot of horseshit, including lumpy shit, on this line that I want to get rid 
of yeah.

*/

_footer;
_say(fp);
}



//;

void
_Put_A_Space_Before_Comments()
{
str fp = 'Put a space before comments.';
_header;

str SC = '';
SC = '(//)([A-Z])';
int Number_of_Replacements = 0;
tof;
while(!at_eof)
{
  if(find_text(SC, 0, _RegExp))
  {
    Replace('\0 \1');
    Number_of_Replacements++;
    tof;
  }
  else
  {
    break;
  }
}
fp = 'Number of replacements = ' + str(Number_of_Replacements);

_footer;
_say(fp);
}



//;

void
_Remove_Carriage_Returns()
{
str fp = 'Remove carriage returns.';
_header;

int Number_of_Replacements = 0;
tof;
while(!at_eof)
{
  if(find_text('(.)($)(.)', 0, _RegExp))
  {
    replace('\0\2');
    Number_of_Replacements++;
    tof;
  }
  else
  {
    break;
  }
}
fp = 'Number of replacements = ' + str(Number_of_Replacements);

_footer;
_say(fp);
}



//;

void
_Find_International_Phone_Number()
{
str fp = 'Find International Phone Number.';
_header;

// Pattern = 2x6x6x1
str SC = '(\D) +(\D) +'; 
str SC = '([0-9\(])[0-9\-\(\)][0-9\-\(\)][0-9\-\(\)]';

str SC = 
'^[0-9\(]([^a-zA-Z#]*[0-9\-\(\)])([^a-zA-Z#]*[0-9\-\(\)])([^a-zA-Z#]*[0-9\-\(\)]+)([0-9])$';

str SC = 
'^[^a-zA-Z#]*[0-9\-\(\)]+[^a-zA-Z#]*$';

if(find_text(SC, 0, _RegExp))
{
  fp = 'Found: ' + found_str;
  down;
  _bol;
}
else
{
  fp = 'International phone number NOT found.';
}

/* Use Case(s)

Fake International Phone Numbers
1
22
333
4444
55555
x5-209900-176148-1
35-x09900-176148-23
35-209900-x76148-1
35-209900-176148-c3
35#209900-176148-c3

Real International Phone Numbers

35-209900-176148-1

35-209900-176148-23

011-(703)-209900-176148-23

(703)-209900-176148-23



*/

_footer;
_say(fp);
}



//;

void
_Find_IMEI()
{
str fp = 'Find IMEI.';
_header;

// Pattern = 2x6x6x1
str SC = 
'^([0-9][0-9]-[0-9][0-9][0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9][0-9][0-9]-[0-9]+)$'; 
// tof; 
if(find_text(SC, 0, _RegExp))
{
  fp = 'Found: ' + found_str;
  down;
  _bol;
}
else
{
  fp = 'IMEI NOT found.';
}

/* Use Case(s)

Fake IMEIs

5-209900-176148-1
35-09900-176148-23
35-209900-76148-1
35-209900-176148-

135-209900-176148-1
35-1209900-176148-23
35-209900-2176148-1
35-209900-176148-323

x5-209900-176148-1
35-x09900-176148-23
35-209900-x76148-1
35-209900-176148-c3
35#209900-176148-c3

Real IMEI

35-209900-176148-1

35-209900-176148-23



*/

_footer;
_say(fp);
}



//;

void
_Add_footer()
{
str fp = 'Add footer;.';
_header;

eol;
cr;
cr;
text('footer;');
cr;
text("say(fp);");
_bol;

_footer;
_say(fp);
}



//;

void
_Add_header()
{
str fp = 'Add header;.';
_header;

_bol;
cr;
up;
text("str fp = '';");
cr;
text('header;');
down;
_bol;
cr;
up;
up;
up;

_footer;
_say(fp);
}



//;

void
_Fix_Date_Formats_in_Junk_Drwr()
{
str fp = 'Fix date formats in Junk Drawer';
_header;

int Number_of_Replacements = 0;
tof;
while(!at_eof)
{
  if(find_text('^(:)(././..)$', 0, _RegExp))
  {
    Replace('$$;\1'); 
    Number_of_Replacements++;
    tof;
  }
  else
  {
    break;
  }
}

_footer;
_say('Number of Fixed Dates: ' + str(Number_of_Replacements));
}



//;

void
__Reformat_Junk_Mar_27_2008()
{
str fp = 'Reformat JD.bul on Mar-27-2008.';
_header;

if(_Is_Wrong_File_Type_Deprecated(lower(get_extension(File_name)), 'bul'))
{
  return();
}

int Number_of_Replacements = 0;
tof;
while(!at_eof)
{
  if(find_text('(.)($$)(;)', 0, _RegExp))
  {
    replace('\0$$$$\2');
    Number_of_Replacements++;
    tof;
  }
  else
  {
    break;
  }
}
fp = 'Number of replacements = ' + str(Number_of_Replacements);

_footer;
_say(fp);
}



//;

void
_Find_Rubric_Without_3_Lines_Ws()
{
str fp = 'Find rubric with less or more than 3 lines of white space.';
_header;

tof;
// right;
if(find_text('.$$$^;', 0, _RegExp))
{
  down;
  down;
  down;
  _bol;
  fp = 'Fewer than 3 lines of white space.';
}
else if(find_text('.$$$$$^;', 0, _RegExp))
{
  down;
  down;
  down;
  down;
  down;
  _bol;
  fp = 'More than 3 lines of white space.';
}

/* Use Case(s)

*/

_footer;
_say(fp);
}



//;

void 
_Run_Shortcut_For_CDDD()
{
_Run_Shortcut('CDDD');
_say("Run shortcut to open CDDD.");
}



//;

void 
_Run_Shortcut_For_TEMP()
{
_Run_Shortcut('TEMP');
_say("Run shortcut to open TEMP.");
}



//;

void 
_Run_Shortcut_For_COMM()
{
_Run_Shortcut('COMM');
_say("Run shortcut to open COMM.");
}



//;

void
_Cursor_to_Line_3()
{
str fp = 'Move cursor to line 3.';
_header;

goto_line(3);
_bol;

_footer;
_say(fp);
}



//;

void
_Make_Child()
{
str fp = 'Make child.';
_header;

_bol;
text(':');

_footer;
_say(fp);
}



//;

void
_List_Jonathans_Macros()
{
str fp = 'List all of my macros in a alphabetically sorted file.';
_header;

int Amount;
int Handle;

str Name_of_File = 'c:\!\Jonathans_Macros_List.txt';
S_Create_File(Name_of_File, Handle);

int Number_of_Occurrences = 0;
tof;
while(!at_eof)
{
  if(find_text('^_.+\)$', 0, _RegExp))
  {
    S_Write_Bytes(get_line, Handle, Amount);
    S_Write_Bytes(LINE_TERMINATOR, Handle, Amount);
    Number_of_Occurrences++;
    down;
  }
  else
  {
    break;
  }
}
S_Close_File(Handle);
rm('MakeWin /NL=1');
load_file(Name_of_File);
_sort_file();
fp = 'Number of occurrences = ' + str(Number_of_Occurrences);

_footer;
_say(fp);
}



//;

void
_Count_Characters()
{
str fp = 'Count characters unitl a blank line is found.';
_header;

int Length_of_Line = 0;

_bol;
Length_of_Line = length(get_line);
while(!find_text('$$', 1, _RegExp))
{
  down;
  Length_of_Line += length(get_line);
} 
fp = str(Length_of_Line) + ' characters were found.';

_footer;
_say(fp);
}



//;

void
_Format_Powerpoint_Slides()
{
str fp = 'Format PowerPoint slides into my bullet format.';
_header;

_Delete_All_Blank_Lines_In_File();
_Add_Blank_Lines_for_LBWNC();
_Format_File();
_Add_Space_Before_Numbers();
tof;
block_begin;
find_text('^;2 ', 0, _RegExp);
up;
goto_col(1);
block_end;
delete_block;

int Number_of_Replacements = 0;
tof;
while(!at_eof)
{
  if(find_text('^;.+' + char(34), 0, _RegExp))
  {
    find_text(char(34), 0, _RegExp);
    col_block_begin;
    right;
    find_text(char(34), 0, _RegExp);
    block_end;
    delete_block;
    down;
  }
  else
  {
    break;
  }
}
fp = 'Number of replacements = ' + str(Number_of_Replacements);

_footer;
_say(fp);
}



//;

void
_Add_Space_Before_Numbers()
{
str fp = 'Replace lines beginning with:[0-9] with 2 blank lines and a semicolon.';
_header;

int Number_of_Replacements = 0;
tof;
while(!at_eof)
{
  if(find_text('^(:)([0-9])', 0, _RegExp))
  {
    Replace('$$;\1');                  // Note that the single quotes are REQUIRED here.
    Number_of_Replacements++;
  }
  else
  {
    break;
  }
}
fp = 'Number of replacements = ' + str(Number_of_Replacements);

_footer;
_say(fp);
}



//;

void
_Add_Clif_Acronym()
{
str fp = 'Horseshit#12:00:46PM';
_header;

goto_col(1);
find_text("skw ", 0, _RegExp);
right;
right;
right;
right;
text('!, ');
left;
left;

/* Use Cases:-)
*/

_footer;
_say(fp);
}



//;

void
_Set_My_Variables()
{
str fp = 'Sets my variables.';
switch(Get_Environment("ComputerName"))
{
  case "Jonathan_Home":
    Set_Global_Str('Mode', '_Home_Normal');
    break;
  case "JONATHAN":
  case "JONATHANS_HP":
    Set_Global_Str('Mode', '_Laptop_Normal');
    break;
  default:
    Set_Global_Str('Mode', '_Desktop_Normal');
}
}



//;

void 
_Run_This_TSQL_File()
{
str fp = 'Run this TSQL file: ' + file_name;
_header;

if(lower(Get_Extension(file_name)) != 'sql')
{
  fp = 'For data security reasons, you must be working in a SQL file ' + 
    'for this function to work.';
  _say(fp);
  return();
}

int flag = _EP_FLAGS_DONTWAIT | _EP_Flags_ExeWin;

ExecProg('c:\windows\system32\cmd.exe /k %userprofile%\my 
documents\!Savannah\belfry\run_tsql_2.bat ' + file_name, 'C:\\!', 
  'c:\\!\\multi-edit_temp_out.txt', 'c:\\!\\multi-edit_temp_err.txt', flag);

_footer;
_say(fp);
}



//;

void 
_Run_This_PS1_File()
{
str fp = 'Run this PS1 file: ' + file_name;
_header;

if(lower(Get_Extension(file_name)) != 'ps1')
{
  fp = 'You must be working in a PS1 file for this function to work.';
  _say(fp);
  return();
}

int flag = _EP_FLAGS_DONTWAIT | _EP_Flags_ExeWin;

ExecProg('c:\windows\system32\WindowsPowerShell\v1.0\powershell.exe -OutputFormat Text ' + 
  file_name,
  'C:\\!',
  'c:\\!\\multi-edit_temp_out.txt',
  'c:\\!\\multi-edit_temp_err.txt',
  flag);

_footer;
_say(fp);
}



//;

void 
_Run_This_Batch_File()
{
str fp = '_Run_This_Batch_File';
_header;

if(lower(Get_Extension(file_name)) != 'bat')
{
  fp = 'You must be working in a batch file for this function to work.';
  _say(fp);
  return();
}

fp = 'Run this batch file: ' + file_name;
// int flag = _EP_FLAGS_DONTWAIT | _EP_Flags_ExeWin | _EP_Flags_RunBkg;
int flag = _EP_FLAGS_DONTWAIT | _EP_Flags_ExeWin;

ExecProg('c:\windows\system32\cmd.exe /k ' + file_name,
  'C:\\!affinity\\Belfry',
  'c:\\!\\multi-edit_temp_out.txt',
  'c:\\!\\multi-edit_temp_err.txt',
  flag);

_footer;
_say(fp);
}



//;

void 
_Cursor_Scroll_Left()
{
str fp = 'Scroll left.';
goto_col(left_offset);
left;
left;
left;
_Cursor_Center_Horizontally();

/* Use Cases:-)
asdfasfdjk asdf;jkasdf;ljasdf adf;jasdf; asl;j asd;jasdf;ljasdfl;jkasdf;ldjf ;asdfjklasd;
*/
_say(str(left_offset));
_say(fp);
}



//;

void 
_Cursor_Scroll_Right()
{
str fp = 'Scroll right.';
goto_col(97 + left_offset);
right;
right;
_Cursor_Center_Horizontally();
_say(fp);
}



//;

void 
_Cursor_Center_Horizontally()
{
str fp = 'Center cursor horizontally.';
goto_col(left_offset + 46);
_say(fp);
}



//;

void 
_Truncate_Until_Subject_Char()
{
str fp = 'Truncate every line until you find this character.';
_header;

str Action_Line = get_line;
int Position_Of_Subject_Character;

tof;

while(!at_eof)
{
  goto_col(1);
  Action_Line = get_line;
  Position_Of_Subject_Character = xpos('<', Action_Line, 1);
  if(!(Position_of_Subject_Character == 0))
  {
    del_line;
    cr;
    up;
    text(str_del(Action_Line, 1, Position_of_Subject_Character - 1));
  }
  down;
}

/* Use Cases:-)

*/

_footer;
_say(fp);
}



//;

void 
_Add_Blank_Line_Here()
{
str fp = 'Add blank lines when you want room to see what you are typing.';
_header;
mark_pos;
cr;
cr;
goto_mark;

/* Use Cases:-)

hey now

*/

_footer;
_say(fp);
}



//;

void 
_Copy_Template_Rubric_Content(str Clif_Acronym)
{
str fp = 'Copy template rubric content for ' + caps(Clif_Acronym) + ' here.'; 
_header;

int Initial_Window = cur_window;
Clif_Acronym = '!' + Clif_Acronym;

If(!_Find_Deprecated(Clif_Acronym, fp))
{
  return();
}

mark_pos;
_Clif_Husk(0);
_Copy_Rubric_Content();
switch_window(Initial_Window);
goto_mark;

_footer;
_say(fp);
}



//;

void 
_Copy_Template_Wrapper()
{
_Copy_Template_Rubric_Content('P5CL');
_say("Copy Template Rubric Content for P5CL.");
}



//;

void 
_Append_Bullet_to_Buffer()
{
str fp = 'Append bullet to buffer.'; // Explicit message to the user.
_Highlight_Bullet();
rm('Cut /A=1');                      // Append to buffer.
_Highlight_Bullet();
delete_block;
_say(fp);
}



//;

void 
_Run_Shortcut_For_MULF()
{
_Run_Shortcut('MULF');
_say("Run shortcut to open MULF");
}



//;

void 
_Run_Shortcut_For_Cale()
{
_Run_Shortcut('cale');
_say("Run shortcut open 'cale'.");
goto_line(3);
}



//;

void 
_Run_Shortcut_For_MECS()
{
_Run_Shortcut('MECS');
_say("Run shortcut to open MECS");
}



//;

void 
_Run_Shortcut_For_MECL()
{
_Run_Shortcut('MECL');
_say("Run shortcut to open MECL");
}



//;

void 
_Run_Shortcut_For_USBB()
{
_Run_Shortcut('USBB');
_say("Run shortcut to open USBB.");
}



//;

void 
_Run_Shortcut_For_BUIL()
{
_Run_Shortcut('BUIL');
_say("Run shortcut to open BUIL.");
}



//;

void
_Format_Wikipedia_Article()
{
str fp = 'Horseshit#11:25:28AM';
_header;

_Delete_All_Blank_Lines_In_File();

// Add a blank line before every occurrence of lines beginning with "A-Z".
tof;
while(!at_eof)
{
  right;
  if(find_text("(^[a-z])", 0, _RegExp))
  {
    Replace('$\0');
  }
  else
  {
    break;
  }
}

tof;
while(!at_eof)
{
  rm('Reformat');
}

_footer;
_say(fp);
}



//;

void
_Add_Space_Before_Numbers_2()
{
str fp = 'Replace lines beginning with:[0-9] with 2 blank lines and a semicolon.';
_header;

int Number_of_Replacements = 0;
tof;
while(!at_eof)
{
  if(find_text('([0-9])||([0-9][0-9])\)', 0, _RegExp))
  {
    Replace('$$:' + found_str); 
    right;
    right;
    Number_of_Replacements++;
  }
  else
  {
    break;
  }
}
fp = 'Number of replacements = ' + str(Number_of_Replacements);

_Format_File();
_Delete_More_Than_1_Blank_Line();
right;

_footer;
_say(fp);
}



//; (Format_File_1)

void
_Put_Blank_Lines_Before_Numbers()
{
str fp = 'Put blank lines before numbered items.';
_header;

str SC = '';
SC = '[0-9][0-9]*\.';

int Number_of_Replacements = 0;
tof;
while(!at_eof)
{
  if(find_text(SC, 0, _RegExp))
  {
    Replace('$$:&');
    Number_of_Replacements++;
    //tof;
  }
  else
  {
    break;
  }
}
fp = 'Number of replacements = ' + str(Number_of_Replacements);
tof;
_Format_File();

_footer;
_say(fp);
}



//; (Format_File_2)

void
_Format_File_2()
{
str fp = 'Put blank lines before numbered items.';
_header;

tof;
_Format_File();

str SC = '';
SC = '[0-9][0-9]*\.';

int Number_of_Replacements = 0;
tof;
while(!at_eof)
{
  if(find_text(SC, 0, _RegExp))
  {
    Replace('$$:&');
    Number_of_Replacements++;
    //tof;
  }
  else
  {
    break;
  }
}
fp = 'Number of replacements = ' + str(Number_of_Replacements);

tof;
_Format_File();

_footer;
_say(fp);
}



//; (Format_File_3)

void
_Format_File_3()
{
str fp = '';
_header;

str SC = '( )([A-Z])';

int Number_of_Replacements = 0;
tof;
while(!at_eof)
{
  if(find_text(SC, 0, _RegExp | _CaseSensitive))
  {
    Replace('.$$:\1');
    Number_of_Replacements++;
  }
  else
  {
    break;
  }
}

tof;
_Format_File();

fp = 'Number of replacements = ' + str(Number_of_Replacements);

_footer;
_say(fp);
}



//;  (Format_File_4)

void
_Replace_Parens_With_Periods()
{
str fp = 'Replace open parens with periods';
_header;

str SC = '$^([1-9][0-9]*)\)';

int Number_of_Replacements = 0;
tof;
while(!at_eof)
{
  if(find_text(SC, 0, _RegExp))
  {
    Replace('$:\0.');
    Number_of_Replacements++;
    // The following command is often used here.
    //tof;
  }
  else
  {
    break;
  }
}
fp = 'Number of replacements = ' + str(Number_of_Replacements);

_footer;
_say(fp);
}



//;

void
_Get_Starting_Position()
{
str fp = 'Get starting position.';

_Switch_to_Named_Window(Global_Str('Starting_Window'));
Get_Mark(1);

_say(fp + ': ' + Global_Str('Starting_Window'));
}



//;

void
_Set_Starting_Position()
{
str fp = 'Set starting position.';

Set_Mark(1);
Set_Global_Str('Starting_Window', Truncate_Path(File_Name));

_say(fp);
}



//;

void 
_Run_Clif_Batch_2()
{
_Clif_Run_Acronym('met1');
_Clif_Run_Acronym('met2');
}



//;

void Run_Program_in_Background()
{
int Flags;
str Command_String;

Flags |= _EP_Flags_DontWait;  // Do not wait for program to complete.
//Flags |= _EP_Flags_Hide;      // Hide window.
//Flags |= _EP_Flags_Minimized; // Show window in minimized state.
//Flags |= _EP_Flags_NoBypass;  // Do not display Bypass dialog.
Flags |= _EP_Flags_RunBkg;    // Run program in the background.

//Command_String = 'c:\\windows\\system32\\calc.exe'; 
Command_String = "c:\\program files\\mozilla firefox\\firefox.exe";

ExecProg(char(34) + Command_String + char(34), '', '', '', Flags);
}



//;

void 
tm1()
{
str fp = 'Try to run browsers in the background using the simplest possible scenarios.
  Result failed on Jul-28-2008.';

str Command_String;
int Flag;

Flag = _EP_Flags_RunBkg;
Flag = _EP_Flags_DontWait | _EP_Flags_ExeWin | _EP_Flags_RunBkg;

Command_String = "c:\\program files\\internet explorer\\iexplore.exe";
Command_String = "c:\\program files\\safari\\safari.exe";
Command_String = "c:\\program files\\mozilla firefox\\firefox.exe";
//Command_String = 'c:\windows\system32\calc.exe'; //This works.

ExecProg(char(34) + Command_String + char(34),
  Get_Environment("TEMP"),
  Get_Environment("TEMP") + '\\temp_out.txt',
  Get_Environment("TEMP") + '\\temp_err.txt',
  Flag);

_say(fp);
}



//;

void 
_Cut_Plus()
{
goto_col(1);
rm('CutPlus');
block_off;
}



//;

void 
_Comment_Out_Choice_Lines()
{

tof;
while(!at_eof)
{
  // Comment out "Choice" lines.
  if(find_text("^Choice(.*)$", 0, _RegExp))
  {
    Replace("//&");
  }
  else
  {
    break;
  }
}

tof;
while(!at_eof)
{
  // Comment out the ellipsis.
  if(find_text("\\.\\.\\.", 0, _RegExp))
  {
    Replace("//&");
  }
  else
  {
    break;
  }
}

tof;
}



//;

void 
_Compile_Phone_List_5()
{
str fp = 'Compile phone list.';
_header;

str str_Search_Line = '<' + 'plb>';
// The splitting of the first open bracket from the following text
// is done so as to avoid this line showing up in the resultant phone file.

int int_Found_Counter = 0;
int int_Counter = 0;
int int_Starting_Window = cur_window;

int int_Han, int_Result, int_Amount;

int_Result = S_Create_File('c:\!\Phone_List.txt', int_Han);

str str_Line;
str Cumulative_Line;

while(int_Counter < Window_Count)
{
  Switch_Window(int_Counter);
  if(!(Window_Attr & 0x81)) //
  {
    mark_pos;
    tof;
    while(find_text(str_Search_Line, 0, _RegExp))
    {
      down;
      Cumulative_Line = '';
      str_Line = _Trim_Leading_Colons(Get_Line);
      // Cumulative_Line += str_Line;

      int_Result = S_Write_Bytes(str_Line, int_Han, int_Amount);
      int_Result = S_Write_Bytes(LINE_TERMINATOR, int_Han, int_Amount);

      down;
      goto_col(1);

      while(!find_text("</plb>", 1, _RegExp))
      {

        str_Line = _Trim_Leading_Colons(Get_Line);
        // Cumulative_Line += str_Line;

        if(str_Line != "")
        {
          int_Result = S_Write_Bytes(str_Line, int_Han, int_Amount);
          int_Result = S_Write_Bytes(LINE_TERMINATOR, int_Han, int_Amount);


          // My printer at home cuts off at 102. *> Jonathan 04-03-04
//          if(length(Cumulative_Line)> 50)
  //        {
    //        int_Result = S_Write_Bytes(LINE_TERMINATOR, int_Han, int_Amount);
      //      Cumulative_Line = '';
        //  }
        }

        down;
      }

      int_Found_Counter++;
      down;
//      int_Result = S_Write_Bytes(LINE_TERMINATOR, int_Han, int_Amount);
    }
    goto_mark;
  }
  int_Counter++;
}

switch_window(int_Starting_Window);
fp = 'Your phone list has compiled. Number of finds = ' + str(int_Found_Counter);
int_Result = S_Close_File(int_Han);
rm('MakeWin /NL=1');
load_file("c:\\!\\Phone_List.txt");

_footer;
_say(fp);
}



//;

int 
_Set_Color()
{
int int_Army_Gray = 6506797;
int int_Black = 0;
int int_Blue = 16711680;
int int_DarkBlue = 9109504;
int int_DarkSeaGreen = 9419919;
int int_Gold = 55295;
int int_Gray = 8421504;
int int_Green = 32768;
int int_MidnightBlue = 7346457;
int int_Orangy = 1005;
int int_Red = 255;
int int_Sienna = 2970272;
int int_Teal = 8421376;

str str_Color_Name;
int int_Color_Value;

Set_Mew_Attr(0, 0, int_MidnightBlue, int_DarkSeaGreen, 0);
Set_Mew_Attr(0, 0, int_Black, int_DarkSeaGreen, 0);

// int_Test = Set_Mew_Attr(0, 0, 0, 10506797, 0);
// int_Test = Set_Mew_Attr(0, 8800, 16777216, 9506797, 0);
// This works.
// int_Test = Set_Mew_Attr(0, 0, 16777215, 7506797, 0);
}



//;

#include Stddlgs.sh  //  File where msgdlg macro prototype is defined.

void 
HelloWorld() // trans2
/* type = void,
   name = HelloWorld
   This macro doesn't take parameters.
   attribute = trans2
*/
{
// macro statements
    msgdlg("Hello World Bitch", "Sample Macro","", 0);
      return(); // optional
}



//;

void 
_Add_HTML_Table()
{
goto_col(1);
cr;
up;

goto_col(1);
text("<table align='center' border='0' cellspacing='1' cellpadding='1' hspace='0' vspace='0'
 width='100%'>");

cr;

goto_col(1);
text('<tr>');
cr;

goto_col(1);
text('<td>');
cr;

cr;

goto_col(1);
text('</td>');
cr;

goto_col(1);
text('<td>');
cr;

cr;

goto_col(1);
text('</td>');
cr;

goto_col(1);
text('</tr>');
cr;

goto_col(1);
text('</table>');
cr;

up;
up;
up;
up;
up;
up;
up;
goto_col(1);
}



//;

void 
_Open_ME_Search_Dialogue_Box()
{
rm('Search');
}



//; skw: Link

void 
_Decode_URL()
{

goto_col(1);

while(find_text('%2526',1,_RegExp))
{
  Replace('\&');
  goto_col(1);
}

while(find_text('%253d',1,_RegExp))
{
  Replace('=');
  goto_col(1);
}

while(find_text('%253f',1,_RegExp))
{
  Replace('?');
  goto_col(1);
}

while(find_text('%253a',1,_RegExp))
{
  Replace(':');
  goto_col(1);
}

while(find_text('%3a',1,_RegExp))
{
  Replace(':');
  goto_col(1);
}

while(find_text('%252f',1,_RegExp))
{
  Replace('/');
  goto_col(1);
}

while(find_text('%2f',1,_RegExp))
{
  Replace('/');
  goto_col(1);
}

while(find_text('%252e',1,_RegExp))
{
  Replace('.');
  goto_col(1);
}

while(find_text('%2e',1,_RegExp))
{
  Replace('.');
  goto_col(1);
}

while(find_text('%3f',1,_RegExp))
{
  Replace('?');
  goto_col(1);
}

while(find_text('%3d',1,_RegExp))
{
  Replace('=');
  goto_col(1);
}

while(find_text('%26',1,_RegExp))
{
  Replace('\&');
  goto_col(1);
}

while(find_text('%5F',1,_RegExp))
{
  Replace('_');
  goto_col(1);
}

while(find_text('%2D',1,_RegExp))
{
  Replace('-');
  goto_col(1);
}

}



//;

void 
_Reference_Parameter()
{
str fp = 'Reference parameter example.';
_header;

int bln_Is_Location = 0;
add_5_to_int(bln_Is_Location);
fp = str(bln_Is_Location); // Show result

_footer;
_say(fp);
}



//; Reference Parameter Example

void 
add_5_to_int(int &bln_Is_Location)
{
bln_Is_Location = 1;
}



//;

void
_CLW2()
{
str fp = 'Replace spaces and make proper case the current line.';
_header;

_Convert_Line_to_Proper_Case();
_Replace_Spaces_With_Unders_CL();
eol;
text('()');
_bol;
text('_');
/* Use Case
Hello man where are you from
Hello man where are you from
*/

_footer;
_say(fp);
}



//;

void 
_Renumber_Milestone_Markers()
{
str fp = 'Renumber milestone markers.';
_header;

int int_DLN_Counter = 1;
mark_pos;
tof;
while(!at_eof)
{

  // Debug Location Number
  if(find_text('Milestone_Marker_[0-9][0-9]*', 0, _RegExp))
  {
    replace("Milestone_Marker_" + str(int_DLN_Counter));
    int_DLN_Counter++;
  }
  else
  {
    break;
  }
}
goto_mark;

_footer;
_say(fp);
}



//;

void 
_Replace_With_Uppercase_Equiv()
{
str mwu = 'Search for the phrases(Contact Info)!ci[x] where x is an alphabetic character.
and replaces x with its uppercase equivalent.';

mark_pos;
tof;
while(!at_eof)
{
  if(find_text("(!c i)([a-z])", 0, _RegExp))
  {
    Replace(caps(found_str));
  }
  else
  {
    break;
  }
}
goto_mark;
}



//;

void 
_Replace_Spaces_With_Unders_CL()
{
str fp = 'Replace spaces and dashes with underscores on the current line.';
_header;

// Periods
goto_col(1);
while(!at_eol)
{
  if(find_text('\.', 1, _RegExp))
  {
    Replace('_');
    goto_col(1);
  }
  else
  {
    break;
  }
}

// Spaces
goto_col(1);
while(!at_eol)
{
  if(find_text(' ', 1, _RegExp))
  {
    Replace('_');
    goto_col(1);
  }
  else
  {
    break;
  }
}

// Dashes
goto_col(1);
while(!at_eol)
{
  if(find_text('-', 1, _RegExp))
  {
    Replace('_');
    goto_col(1);
  }
  else
  {
    break;
  }
}

// Double Underscores
goto_col(1);
while(!at_eol)
{
  if(find_text('__', 1, _RegExp))
  {
    Replace('_');
    goto_col(1);
  }
  else
  {
    break;
  }
}

_footer;
_say(fp);
}



//;

int
_Replace_Special_Chars_One_Pass(str character_To_Replace, str master_Character)
{
str fp = 'Replace special characters while making only 1 pass through the file.';
_header;

int Number_of_Replacements = 0;
tof;
while(!at_eof)
{
  if(find_text(Character_to_Replace, 0, _RegExp))
  {
    Replace(master_Character);
    Number_of_Replacements++;
  }
  else
  {
    break;
  }
}

_footer;
_say(fp);
return(Number_of_Replacements);
}



//;

int 
_Get_Decimal_Equivalent(str prms_Hex_Character)
{
int int_Return;
val(int_Return, prms_Hex_Character);
switch(prms_Hex_Character)
{
  case "A": return(10);
           break;
  case "B": return(11);
           break;
  case "C": return(12);
           break;
  case "D": return(13);
           break;
  case "E": return(14);
           break;
  case "F": return(15);
           break;
  default: return(int_Return);
}
}



//;

int 
_Is_Hexidecimal_Character(str prms_Character)
{
// New way as of 07-22-02
// This works.
// int_Test = $A9F7;
// int_Test = 0xA9F7;

// A-F
if((ascii(prms_Character)>= 65) && (ascii(prms_Character)<= 70))
{
  return(1);
}
//0-9
else if((ascii(prms_Character)>= 48) && (ascii(prms_Character)<= 57))
{
  return(1);
}
return(0);
}



//;

void
_Find_Previous_Blank_Line()
{
// I could not get this function to work as expected. Jun-10-2008
str fp = 'Find previous blank line.';

if(length(get_line) == 0)
{
  _say('You must begin on a non-blank line.');
  return();
}

up;
if(length(get_line) == 0)
{
  down;
  _say(fp);
  return();
}

str SC = '$^$^';
_bol;
if(find_text(SC, 0, _RegExp | _Backward))
{
  fp = 'Found: ' + found_str + '.';
  down;
  down;
  _bol;
}
else
{
  fp = 'NOT found.';
}

/* Use Case(s)

1. Notice if the cursor is placed on the close brace, this function does not work as 
expected.
  _say(fp);
  return();
}

SC = '$^$^.';

//if(Search_Bwd(SC, 0))
if(find_text(SC, 0, _RegExp))
{
  down;
  down;
  _bol;
  m2u = 'Found: ' + found_str + '.';
}
else
{
  m2u = 'NOT found.';
}

*/

_say(fp);
}



//;

void
_Delete_Word_Old()
{
str fp = 'Delete word.';
_header;

str Current_Character_History = cur_char;

//if (cur_char == ' ')
//{
//  right;
//}
right;

str Previous_Character_History = copy(get_line, c_col - 1, 1);
str Previous_Character = copy(get_line, c_col - 1, 1);

while(_Is_Alphanumeric_Character(Previous_Character) && (c_col != 1))
{
  left;
  Previous_Character = copy(get_line, c_col - 1, 1);
}

// Word beginning.
str_block_begin;
get_word(word_delimits); //:=.";( )\,'%/[] as Jun-6-2008
block_end;

_say(str(block_col2 - block_col1));

delete_block;

if((block_col2 - block_col1) < 0)
{
  del_char;
}

//while (cur_char == ' ')
//{
//  del_char;
//}

if (Current_Character_History == ' ')
{
  left;
}

Previous_Character = copy(get_line, c_col - 1, 1);

if (cur_char == ' ')
{
  del_char;
}

/* Use Case(s)

although not a classic, it's awesome

Windows Shortcuts are abolutely easy to use and fine for simple operations for a handful of

terrific editor. I've been using it since 1995.

:Fix delete word to work with this 
  switch(lower(Get_Extension("ComputerName")))
  { 
  zz

  switch(lower(Get_Extension("ComputerName")))
  { 
  aa

::c:\!Hello

s Panzerarmee

s Panzerarmee

's Panzerarmee

s Panzerarmee

Rommel's Panzerarmee

::
British army

::,

:a

:jonathan()

:dear,

*/

_footer;
//say(fp);
}



//;

void 
_Delete_Line_Slidingly_Old()
{
str fp = 'Delete line slidingly.';
_header;

down;
del_line;
up;

_footer;
_say(fp);
}



//; Displays a message to the user WITH TIME APPENDED.

void 
_Talk(str Message)
{
Message = _Trim_Period(Message);
make_message(Message + ' at ' + time + '.');
}



//; Not working properly.

void
_Delete_SKW()
{
str fp = 'Delete the next SKW I can find.';
_header;

up;
eol;
str sc = ' \(.+\)';
if(find_text(SC, 0, _RegExp))
{
  replace(' (!)');
  left;
}

/* Use Case(s)

:Washington Post: http://www.washingtonpost.com

::Washington Post Macrocosm: jonathan_rae@hotmail.com Oblique: x2HjpGcz

::New York Times: http://www.nytimes.com/

*/

_footer;
_say(fp);
}



//; Under construction.

void
RT_Sep_17_2008
{
str fp = 'Find broken launch codes in all files.';
int First_Only = true;
_header;

str SC = '[\(\,]! [a-z0-9]';

int Initial_Window = cur_Window;

do
{

if(_Seek_Next(SC))
{
  return(); 
}


/* Use Case(s)

falsifiable test: Nora said jump?! Jake said how high?

I could not figure out how to write the regex to make this following line falsifiable.
falsifiable #2: while(!crashed) {

(!a
(!1
(!Z

*/

  rm('NextWin');

} while(cur_window != Initial_Window);

fp = 'All open and relevant files has been verified to be in the correct format.';


_footer;
//_say(fp);
}



//;

void
_Set_ReadOnly_Attribute_To_False()
{
str fp = 'Set read-only attribute to false.';
_header;

read_only = false;

/* Use Case(s)

*/

_footer;
_say(fp);
}



//;

void 
_Paste_Extra()
{
home;
Win3_Paste();
}



//;

int 
_find_text_multiwindow(str sc)
{
str sO;
str fp = 'Find text, search all windows.';
int RV = _find_core(sC, sO, 1, _regexp);
return(RV);
}



//;

void
_search_without_dialog()
{
refresh=false;
_find_text_multiwindow(@get_user_input('Search Criterion: '));
refresh=true;
}



//;

void
@my_custom_highlight_block_macro
{
str fp = 'My custom highlight block macro.';
@header;

if(@is_bullet_file)
{
  rm('MarkBlck');
  @find_next_bs;
  left;
}
else
{
  rm('ShiftCursor'); 
}
@footer;
//@say('hey');
}



//;

void
rtx
{
str fp = "Format Kurt and Jeffrey's script e-mailed to Mexico on c. Jan-29-2009.";

if(length(@is_mismatched_file(get_extension(File_name), 'sql')) > 0)
{
  return();
}

@header;

str sc;
str rs;

//@say(@replace_2_spaces_with_1_in_file);
//@say(@replace_2_blank_lines_with_1);
//sc = '(,)([0-9@a-zA-Z])';
//rs = '\0 \1';
//@say("Add space after commas." + @replace_string_in_file(sc, rs));
//@say("Indent raiseerror." + @replace_string_in_file('^raiserror', '  raiserror'));
//@say("Indent " + @replace_string_in_file('^goto Error_Handler', '  goto Error_Handler'));

//sc = '(\))([0-9@a-zA-Z])';
//rs = '\0 \1';
//@say("Add space after." + @replace_string_in_file(sc, rs));

//sc = '^close';
//rs = '  close';
//@say("" + @replace_string_in_file(sc, rs));
//
//sc = '^deallocate';
//rs = '  deallocate';
//@say("" + @replace_string_in_file(sc, rs));

//sc = '([a-zA-Z0-9])($)(begin catch)';
//rs = '\0$$\2';
//@say(@replace_string_in_file(sc, rs));

//sc = '([a-zA-Z0-9])($)(if)';
//rs = '\0$$\2';
//@say(@replace_string_in_file(sc, rs));

//sc = '([a-zA-Z0-9])($)(begin try)';
//rs = '\0$$\2';
//@say(@replace_string_in_file(sc, rs));

//sc = '([a-zA-Z0-9])($)(begin try)';
//rs = '\0$$\2';
//@say(@replace_string_in_file(sc, rs));

//sc = '^set \@message';
//rs = '  set @message';
//@say(@replace_string_in_file(sc, rs));

sc = '[^]  ';
rs = ' ';
@say('Replace nonident spaces. ' + @replace_string_in_file(sc, rs));

@footer;
}



//;

void
@select_all_and_copy
{
str fp = 'Select all AND copy.';
rm('Block^SelectAll');
@copy_with_marking_left_on;
}



//; Deprecated, please use "@run_launch_code@" instead.

void 
_run_shortcut(str launch_code = parse_str('/CA=', mparm_str))
{
str fp = 'Run Clif shortcut ' + caps(launch_Code) + ' at ' + time + '.';
int Search_Criterion_Was_Found;

int Initial_Window = cur_window;
launch_Code = '!' + launch_Code;
@process_launch_code(launch_Code, 0, fp, Initial_Window, Search_Criterion_Was_Found);

@say(fp);
}



//; This works. Mar-21-2008

void 
_run_shortcut_for_gc_2()
{
_run_shortcut('goog');
_run_shortcut('calc');
}



//;

void 
_open_both_email_links()
{
str fp = 'Open both email links.';

_clif_run_acronym('gmai');
// Turns out the not-being-able to open both links was a Firefox issue.
_clif_run_acronym('hotm');
//_clif_run_acronym('hotm');

@say(fp);
}



//;

void 
_run_shortcut_for_docu()
{
_run_shortcut('DOCU');
@say("Run shortcut to open DOCU.");
}



//;

void 
_run_shortcut_for_shar()
{
_run_shortcut('SHAR');
@say("Run shortcut to open SHAR.");
}



//;

void 
_run_shortcut_for_afff()
{
_run_shortcut('AFFF');
@say("Run shortcut to open AFFF.");
}



//;

void 
_run_current_task()
{
_run_shortcut('h4vs');
@say("Run current task");
}



//;

void 
_run_shortcut_for_macr()
{
_run_shortcut('macr');
@say("Run shortcut to open Jonathan's Macro's");
}



//;

void 
_run_shortcut_for_goog()
{
_run_shortcut('goog');
@say("Run shortcut to open GOOG.");
}



//; Deprecated. Please use "@run_launch_code@" instead.

void 
_clif_run_acronym(str launch_code = parse_str('/CA=', mparm_str))
{
str fp = 'Run Launch Code: ' + char(34) + caps(launch_Code) + char(34);

int Search_Criterion_Was_Found;
str so;

/*
Purpose of This Macro: This allows the user to assign a keypad key to frequently used Clifs.
For some mysterious reason, this works for Gmail and Hotmail, but Run_Shortcut does not.
*/

int Initial_Window = cur_window;
launch_Code = '!' + launch_Code + ',||\)';
@process_launch_code(launch_Code, 0, so, Initial_Window, Search_Criterion_Was_Found);

@say(fp + ' ' + so);
}



//;

void 
_run_clif_batch()
{
_clif_run_acronym('meto');
_clif_run_acronym('mech');
}



//;

void 
_run_clif_as_a_batch()
{
  _clif_run_acronym('pain');
  _clif_run_acronym('optf');
  _clif_run_acronym('me');
  _clif_run_acronym('prf');
  _clif_run_acronym('hwtm');
}



//;

void 
_run_shortcut_for_gc
{
_clif_run_acronym('goog');
_clif_run_acronym('calc');
make_message("Run shortcut to open Google and the Calculator.");
}



//;

void 
_run_bc_for_cmac()
{
_clif_run_acronym('macr');
}



//;

void 
_run_both_email_apps()
{
str fp = 'Checking my Hotmail and Gmail accounts.';
@header;

str Command_String = '%userprofile%\my documents\!Savannah\Pounders\Open_Both_Email_Apps.exe';
ExecProg(Command_String,
  Get_Environment("TEMP"),
  Get_Environment("TEMP") + '\\multi-edit output.txt',
  Get_Environment("TEMP") + '\\multi-edit error.txt',
  _EP_FLAGS_DONTWAIT);

@footer;
@say(fp);
}



//;

void 
@highlight_bullet()
{
str fp = 'Highlight bullet.';

//bobsr;

if(Cur_Char == ':')
{
  right;
}
find_text('(^:[^:])||(^;)||(^:$)', 0, _regexp);
if(found_str == ';')
{
  up;
  up;
}
up;
block_begin;
@find_previous_bullet;
//@center_line;
//block_end;

@say(fp);
}



//;

void
_delete_character()
{
str fp = 'Delete character with an efficiency enhancement for double qs.';

str Current_Line = @right(get_line, 3);

if(@is_bullet_File)
{
  if(Current_Line == (':q' + 'q'))
  {
    @delete_bs;
    @say('Branch 1. ' + fp);
    return();
  }
}
else
{
  if(Current_Line == ('/q' + 'q'))
  {
    @delete_line;
    return();
  }
}

if((@current_character == 'q') and (@next_character == 'q'))
{
  rm('del');
  rm('del');
  @say('Branch 3. ' + fp);
  return();
}

if((@current_character == 'q') and (@previous_character == 'q'))
{
  left;
  rm('del');
  rm('del');
  if(@previous_character == ' ')
  {
    left;
    rm('del');
  }
  @say('Branch 4. ' + fp);
  return();
}

rm('del');

/* Use Case(s)

Use Case 5: Delete double qs from the middle position in column 1.
q q

Use Case 4: Delete double qs from the first position in column 1.
q q

Use Case 3: Delete double qs from the first position.
 q q

Use Case 2: Delete double qs from the middle position.
 q q

Use Case 1: q resides in column 1. We don't want the cursor to jump to the previous line.
q

*/

@say(fp);
}



//;

void 
_move_bs_down_to_bullet
{
str fp = 'Move BS down to bullet.';
@header;

@cut_bs;
str Found_BSR = @peek_ahead;
if(Found_BSR == 'rubric')
{
  @find_next_rubric;
  up;
  up;
}
else
{
  @find_next_bullet;
}
rm('paste');

@footer;
@say(fp);
}



;Use cases for moving bullets, subbullets and families up and down in bullet files.

:* * * * * * * * * * * * * * *  Dividing Line:

:Test bullets moving up through empty rubrics.

:Test penultimate subbullets moving down.

:Test bullets moving down.

:Test subbullets moving down across rubrics.

:Test subbullets moving down.

:Test first child subbullet moving up through rubrics.

:Test subbullets moving up through families.

:Test subbullets moving down through empty rubrics.

:Test subbullets moving up through empty rubrics.

:Test bullets moving down across families.

:Test bullets moving down across rubrics.

:Test bullets with children moving down.

:Test bullets with children moving down across rubrics

:Test subbullets moving up.

:Test subbullets moving up across rubrics.

:Test bullets moving up.

:Test bullets moving up across rubrics.

:Test bullets with children moving up.

:Test bullets with children moving up across rubrics



//;

int 
@is_read_only_file()
{
str fp = 'Verify that the current file is NOT read-only.';
if(Hex_Str(Cur_File_Attr) == '1')
{
  @say('Current file is READ-ONLY.');
  return(0);
}
@say(fp + ' True.');
return(1);
}



//;

void
@delete_word_backwards()
{
str fp = 'Delete word backwards.';
int Counter = 0;
int Current_Column = @current_column;
int Number_of_Spaces_Deleted = 0;

if(@current_column != 1)
{
  while (Counter < 2)
  {
    switch(@previous_character)
    {
      case "'":
      case ':':
      case ' ':
      case '-':
      case '.':
      case ',':
      case '/':
        Back_Space;
        break;
    }
    Counter++;
  }
}

rm('BsWord');

//Number_of_Spaces_Deleted = Current_Column - @current_column;
@say(str(Number_of_Spaces_Deleted));

/* Use case(s)

:Use move

Fourscore and seven years ago our fathers brought forth on this continent a 
altogether fitting and proper dedicate, we cannot consecrate, we cannot hallow this ground. 
The brave men, living and dead, who struggled here have consecrated it far above will little 
note nor long remember what we say here, but it can never forget what they did here. It is for 
us the living rather to be dedicated here to the unfinished work 
have thus far so nobly advanced. It is rather for us to be here dedicated to the great task 
remaining before us -- that from these honored dead we take increased devotion to that resolve 
that these dead shall not have died in vain, that this nation not perish from the earth.

Penn Jillette is the taller, louder half of the magic and comedy act Penn and Teller. He is a
research fellow at the Cato Institute and has lectured at Oxford and MIT. Penn has co-authored
three best-selling books and is executive producer of the documentary film The Aristocrats.

Morning Edition, November 21, 2005 · I believe that there is no God. I'm beyond Atheism.
Atheism is not believing in God. Not believing in God is easy -- you can't prove a negative,
so there's no work to do. You can't prove that there isn't an elephant inside the trunk of my
car. You sure? How about now? Maybe he was just hiding before. Check again. Did I mention
that my personal heartfelt definition of the word "elephant" includes mystery, order,
goodness, love and a spare tire?

So, anyone with a love for truth outside of herself has to start with no belief in God and
then look for evidence of God. She needs to search for some objective evidence of a
supernatural power. All the people I write e-mails to often are still stuck at this searching
stage. The Atheism part is easy.

But, this "This I Believe" thing seems to demand something more 
that helps one see life's big picture, some rules to live by. So, I'm saying, "This I believe:
I believe there is no God."

Having taken that step, it informs every moment of my life. I'm not greedy. I have love, blue
skies, rainbows and Hallmark cards, and that has to be enough. It has to be enough, but it's
everything in the world and everything in the world is plenty for me. It seems just rude to
beg the invisible for more. Just the love of my family that raised me and the family I'm
raising now is enough that I don't need heaven. I won the huge genetic lottery and I get joy
every day.

Believing there's no God means I can't really be forgiven except by kindness and faulty
memories. That's good; it makes me want to be more thoughtful
right the first time around.

Believing there's no God stops me from being solipsistic. I can read ideas from all different
people from all different cultures. Without God, we can agree on reality, and 
can say or do can shake my faith." That's just a long-winded religious way to say, "shut up,"
or another two words that the FCC likes less. But all obscenity is less insulting than, "How I
was brought up and my imaginary friend means more to me than anything you can ever say or do."
So, believing there is no God lets me be proven wrong and that's always fun. It means I'm
learning something.

Believing there is no God means the suffering I've seen in my family, and indeed all the
suffering in the world, isn't caused by an omniscient, omnipresent, omnipotent force that
isn't bothered to help or is just testing us, but rather something we all may be able to help
others with in the future. No God means the possibility of less suffering in the future.

Believing there is no God gives me more 
beauty, sex, Jell-o and all the other things I can prove and

*/

//@say(fp);
}



//;

void
@copy_phrase
{
str fp = 'Copy phrase.';
@header;

@eoc;
col_block_begin;
while (@current_character != ':' and !at_eol)
{
  right;
}
left;

@copy_with_marking_left_on;

@say(fp);
}



//;

void
@multiple_line_separation
{
str fp = 'Multiple line separation.';
str rs;
str sc;
str so;
@header;
sc = '\)${$^\@header;';
sc = '\)$(^.*$)*\@h';
sc = '\)${$(^.@$)@\@h';
sc = '\)$(^.*$)*\@h';
sc = '\)$(^.*$)#\@h';
sc = '\)$(^.*$)+\@h';
sc = '\)$(^.*$)@\@h';

// This finds header with exactly 2 lines away from the close paren.
sc = '\)$(^.*$)(^.*$)\@header';
sc = '\)$(^.*$)(^.*$)(^.*$)\@header';

@seek_next(sc, so);

/* Use Case(s)

i
i

)
{

@header;

)
{
aaa
@header;

)
{
f

i
i
i


)
{


@header;


*/

@footer;
@say(so);
}



//;

void
@find_next_rubric_and_place_curs
{
str fp = 'Find next rubric and place cursor in a useful place.';
@header;

@find_next_rubric;

if(lower(get_extension(File_name)) == "s")
{
  down;
  if(at_eof)
  {
    up;
    fp += 'You are at the last rubric.';
  }
  else
  {
    down;
    down;
  }
  eol;
  if(at_eof)
  {
    @bol;
  }
}

@footer;
@say(fp);
}



//;

void
@find_previous_rubric_and_place
{
str fp = 'Find previous rubric and place cursor in a useful place.';
@header;

if(lower(Get_Extension(File_Name)) == 's')
{
  up;
  up;
  up;
  up;
}

@find_previous_rubric;

if(lower(Get_Extension(File_Name)) == 's')
{
  down;
  down;
  down;
  eol;
}

@footer;
@say(fp);
}



//;

void
@cross_line_search_experimentation
{
str fp = '';
str rs;
str sc;
str so;
@header;
sc = 'head($^)*first';
sc = '\)$(^.*$)*\@header';
sc = '\)$(^.*$)*';
sc = '\)${(^.*$)*';
sc = '\(\)${(^.*$)*';
sc = '\(\)${(^.*$)@';

if(find_text(sC, 0, _regexp | _backward))
{
  fp = 'Found: ' + found_str + '.';
  sO = @left(get_line, 35);
  left;
}

/* Use Case(s)

)
header

)

header

)
x
header

)


header
aaa

)
{
@header

}

)
{

@header

)
{
x
@header

header
headfirst

head
first

head
x
first


head

first



head


first

*/

@footer;
@say(so);
}



//; (Rubric_header;)

void
@find_word_or_block_in_rubric_hd
{
str fp = 'Find word or block in rubric headers.';
str so;

@header;

str sc = @get_word_or_block_under_cursr;

/*
sc = ';' + sc;
sc = '^;.@($)||().+($)||().@' + sc;             // ORIGINAL - DO NOT MODIFY
sc = '^;.@($)||().+($)||().@' + sc;             // Stops at Use Cases    2, 3,    5, 6, 7, 8
sc = ';.*' + sc;
sc = '^;.@(())' + sc;                           // Stops at Use Cases    2, 3, 4
sc = '^;.@(()||($))' + sc;                      // Stops at Use Cases    2, 3, 4, 5
sc = '^;.@(()||($.@))' + sc;                    // Stops at Use Cases    2, 3, 4, 5, 6
sc = '^;.@(()||($.@)||($$.@))' + sc;            // Stops at Use Cases 1, 2, 3, 4, 5, 6
sc = '^;.@(()||($.@)||($.+$))' + sc;            // Stops at Use Cases    2, 3, 4, 5, 6, 7
*/

sc = '^;.@(()||($.@)||($.+$.@))' + sc;          // Stops at Use Cases    2, 3, 4, 5, 6, 7, 8

@save_window_location;

if(_find_text(sc, so))
{
  pop_mark;
}
else
{
  goto_mark;
}

@footer;

@say(fp + ' ' + so);
}



//; (extrovert skw Compile_Phone_List)

void
_compile_phone_list_6
{
str fp = 'Compile phone list.';
@header;

// The splitting of the first open bracket from the following text
// is done so as to avoid this line showing up in the resultant phone file.
str sc = '<' + 'plb>';

int Window_Counter = 0;
int Found_Counter = 0;
int Starting_Window = cur_window;

int Handle, Result, Amount;

Result = S_Create_File(Get_Environment('my_documents') + '\Phone_List.txt', Handle);

str Line;
str Cumulative_Line;

while(Window_Counter < Window_Count)
{
  Switch_Window(Window_Counter);
  if(!(Window_Attr & 0x81))
  {
    mark_pos;
    tof;
    while(find_text(sc, 0, _regexp))
    {
      down;
      Line = @trim_leading_colons(Get_Line);
      Result = S_Write_Bytes(Line, Handle, Amount);
      Result = S_Write_Bytes(LINE_TERMINATOR, Handle, Amount);
      down;
      @bol;
      while(!find_text('</plb>', 1, _regexp))
      {
        Line = @trim_leading_colons(Get_Line);
        if(Line != '')
        {
          Result = S_Write_Bytes(Line, Handle, Amount);
          Result = S_Write_Bytes(LINE_TERMINATOR, Handle, Amount);
        }
        down;
      }
      Found_Counter++;
      down;
    }
    goto_mark;
  }
  Window_Counter++;
}

switch_window(Starting_Window);
fp = 'Your phone list has compiled. Number of finds = ' + str(Found_Counter);
Result = S_Close_File(Handle);
rm('MakeWin /NL=1');
load_file("c:\\!\\Phone_List.txt");

@footer;
@say(fp);
}



//;

void
@sort_bullets_in_rubric
{
str fp = 'Sort bullets in current rubric.';

if(!@is_bullet_file)
{
  return();
}

@header;

int ASCII_Value_of_First_Bullet = 0;
int ASCII_Value_of_Second_Bullet = 0;

@bor;

while(true)
{
  if(@find_next_br == 'rubric')
  {
    break;
  }
  ASCII_Value_of_First_Bullet = @get_ascii_value_of_first_char;

  if(@find_next_br == 'rubric')
  {
    break;
  }
  ASCII_Value_of_Second_Bullet = @get_ascii_value_of_first_char;

  @find_previous_bullet;

  if(ASCII_Value_of_First_Bullet > ASCII_Value_of_Second_Bullet)
  {
    @move_bullet_to_eor_wom;
    @bor;
  }
}

@find_previous_rubric;

@footer;
@say(fp);
}



//;

void
@highlight_bullet_or_block()
{
str fp = 'Highlight bullet or block.';

if(Cur_Char == ':')
{
  right;
}
find_text('(^:[^:])||(^;)||(^:$)', 0, _regexp);
if(found_str == ';')
{
  up;
  up;
}
up;
block_begin;
@find_previous_bullet;
@center_line;
block_end;

@say(fp);
}

:
  if(length(em) == 0)
  {
    // Find space at eol.
    em = @find_special_character(' $');
  }



;if(length(Command_Line) == 0)
{
  // The way I have structured this function, this may be an unreachable code block.
  int em;
  em = ShellExecute( 0, "Open", URL, "", "", 7);
}
else
{
  ExecProg(char(34) + Command_Line + char(34) + " " + URL,
    Get_Environment("TEMP"),
    Get_Environment("TEMP") + '\\multi-edit output.txt',
    Get_Environment("TEMP") + '\\multi-edit error.txt',
    _EP_Flags_NoBypass | _EP_Flags_DontWait);
}



//; (skw Format date, date format, date_format, format_date)

void
@format_dates_in_junk_drawer_rub
{
str fp = 'Format dates in Junk Drawer rubrics.';

if(!@is_bullet_file)
{
  return();
}

int First_Only = true;
str fp = '';
str rs;
str sc;
str so;

//if(First_Only){@swap_next_occurrence_only(sc, rs); First_Only = false;}
//if(First_Only){@seek_next(sc, so); First_Only = false;}

//sc = '^(;[0-9][0-9]@)(/)([0-9][0-9]@)(/)([0-9][0-9]@)';
//rs = '\0-\2-\4';
//@say("Replace slashes with dashes in file." + @replace_string_in_file(sc, rs));

//sc = '^(;[0-9][0-9]@)(-)([0-9][0-9]@)(-)([0-9][0-9])$';
//rs = '\0-\2-20\4';
//@say("Replace 2 digit years with 4 digit years." + @replace_string_in_file(sc, rs));

//rs = '\0Jan-\3-\5';
//if(First_Only){@seek_next(sc, so); First_Only = false;}
//@say("Replace '01' with 'Jan'." + @replace_string_in_file(sc, rs));

//rs = '\0Feb-\3-\5';
//@say("Replace '11' with 'Nov'." + @replace_string_in_file(sc, rs));

//rs = '\0Mar-\3-\5';
//@say("Replace '11' with 'Nov'." + @replace_string_in_file(sc, rs));

//rs = '\0Apr-\3-\5';
//@say("Replace '11' with 'Nov'." + @replace_string_in_file(sc, rs));

//rs = '\0May-\3-\5';
//@say("" + @replace_string_in_file(sc, rs));

//rs = '\0Jun-\3-\5';
//@say("" + @replace_string_in_file(sc, rs));

//rs = '\0Feb-\3-\5';
//@say("" + @replace_string_in_file(sc, rs));

rs = '\0Mar-\3-\5';
@say("" + @replace_string_in_file(sc, rs));

rs = '\0Apr-\3-\5';
@say("" + @replace_string_in_file(sc, rs));

rs = '\0May-\3-\5';
@say("" + @replace_string_in_file(sc, rs));

//rs = '\0Sep-\3-\5';
//@say("" + @replace_string_in_file(sc, rs));

//rs = '\0Oct-\3-\5';
//@say("" + @replace_string_in_file(sc, rs));

//sc = '^(;[a-z][a-z][a-z]-)([0])([1-9]@-[0-9][0-9])';
//rs = '\0\2';
//@say("Replace '0' as date placeholder with nothing." + @replace_string_in_file(sc, rs));

//rs = '\0Nov-\3-\5';
//if(First_Only){@seek_next(sc, so); First_Only = false;}
//@say("Replace '11' with 'Nov'." + @replace_string_in_file(sc, rs));

//rs = '\0Dec-\3-\5';
//@say("Replace '11' with 'Nov'." + @replace_string_in_file(sc, rs));

}



//; QJQ Please close this file so you don't compile it or thiink it's active.

/*
;Metadata: Track Size on a Monthly Basis (!tscg)


   Date        Lines     Bytes    Macros  Notes
 -----------  ------  ---------  -------  ----------------------------------------------------

: Jun-2-2019  22,650    322,553      771

:Jun-25-2017  21,392    304,142      730

: Dec-2-2016  21,201    301,163      721

: Apr-1-2016  20,164    287,897      684

: Apr-1-2015  18,890    270,028      642

:Jan-16-2015  18,603    265,543      633

:Aug-30-2012  15,189    220,599      523

: Jul-3-2012  14,908    217,145      510

: Jan-3-2012  13,557    198,194      464

: Dec-8-2011  12,366    179,314      410

:Jan-18-2011  9,050   136,192     300

:Jul-1-2010   6,925   108,543     224

:Jun-1-2010   6,920   108,365     224

:May-3-2010   6,918   108,324     224

:Mar-1-2010   6,921   108,430     224

:Feb-1-2010   6,886   108,129     222

:Jan-8-2010   6,858   108,012     220

*/



//;EOF << (!cgef)