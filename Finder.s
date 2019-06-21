macro_file Finder; // (!fi) 

// Find stuff locally as opposed to searching on the internet.

#include Aliases.sh
#include Regexes.sh
#include Shared.sh

// The following are used by @find[]_key_assignment.
#include DbTools.sh
#include Dialog.sh
#include melib.sh

#ifdef _Mew32_
  #include Mew.sh
  #include Win32.sh
  #include Messages.sh
#endif



//;

/*

Metadata: Track Size (!tsfi)

     Date      Lines     Bytes    Macros  Notes
 -----------  ------  ---------  -------  ----------------------------------------------------

:Apr-26-2019   3,829     61,789      111

: Jan-1-2019   3,820     61,964      111

: Jul-1-2018   3,789     61,619      109

:May-17-2018   3,785     61,457      109

: Apr-3-2018   3,775     61,242      109

: Jan-3-2018   3,777     61,262      109

:Jun-25-2017   3,776     61,246      109

:Mar-31-2017   3,774     61,201      109

:Nov-17-2016   3,645     59,070      106

: Oct-7-2016   3,413     54,741      106

: Apr-8-2016   3,376     54,224      103

:Dec-31-2015   3,266     52,506       99

: Oct-5-2015   3,254     52,205       99

: Jul-1-2015   3,231     52,053       99

: Apr-1-2015   3,261     52,714       99

:Jan-16-2015   3,213     52,130       89

: Oct-1-2014   3,177     51,795       88

: Jul-1-2014   3,086     50,244       88

:Apr-10-2014   3,077     50,037       88

: Oct-1-2013   3,029     49,271       88

: Jul-1-2013   3,027     49,227       88

: Apr-1-2013   2,995     48,676       87

: Jan-2-2013   2,994     48,597       87

: Oct-1-2012   2,947     48,013       85

: Jul-2-2012   2,868     46,887       78

: Apr-2-2012   2,786     45,739       75

- Jan-2-2012   2,626    44,273      69

- Dec-20-2011  2,648    44,625      70

- Oct-3-2011   2,461    42,091      63

- Aug-1-2011   2,481    42,372      64

- Jul-15-2011  2,473    42,248      64

- Jun-1-2011   2,429    40,989      62

- Apr-7-2011   2,495    41,582      64

- Feb-2-2011   2,488    41,112      63

- Jan-5-2011   2,531    41,459      65

- Jan-4-2011   2,529    41,418      65

- Jan-3-2011     543     9,091      18

- Jul-1-2010     462     7,940      15

- Jun-1-2010     460     7,899      15

- May-3-2010     458     7,858      15

- Mar-1-2010     442     7,684      14

- Feb-1-2010     440     7,643      14

- Jan-8-2010     444     7,779      14

*/



//;+ Seeking



//;;

int
@seek_next(str sc, str &so)
{
str fp = 'Seek next.';
int rv = 0;

if(@first_character(sc) == '@')
{
  sc = '\' + sc;
}

if(find_text(sc, 0, _regexp))
{
  fp = 'Found: ' + found_str + '.';
  sO = @left(get_line, 35);
  right;
  rv = 1;
}
else
{
  sO = 'The seek method could not find your search criterion.';
  fp += ' ' + sO;
}

int Set_Global_Search_Tag = true;
str First_Character = @first_character(sc);

// Prevent launch codes from setting the global search string.
if((First_Character == '!'))
{
  Set_Global_Search_Tag = false;
  set_global_str('lc', sc);
}

// If you implement this block of code you will prevent the "F3" key from working 
// when running the macro "@find_cmac_definition_uc". - JRJ Apr-8-2011
//@log("sc1 = " + sc);
//@log("sgst = " + str(Set_Global_Search_Tag));
if(First_Character == '!')
{
  Set_Global_Search_Tag = false;
}

// This is a hack, but it works. May-6-2011
if(sc == '(^:$)||(^:[^:])')
{
  Set_Global_Search_Tag = false;
}

// This is a also hack, but it works. Notice that in this case, surround the tested condition 
// with double quotes instead of single quotes worked. Nov-14-2011
// Use case justification for this code block. If I search on "authorize", Then go to the 
// "!jd" window, then hit f3, f3 doesn't work.
if(sc == "(^:$)|(^:[^:_])")
{
  Set_Global_Search_Tag = false;
  //@log("gst = false");
}

// I don't want double q to "usurp" the buffer for "find again". So this is what this
// if block accomplishes.
if(@contains(sc, 'q' + 'q'))
{
  set_global_search_tag = false;
}

if(Set_Global_Search_Tag)
{
  // This should enable "F3" repeat searches to work.
  if(sc != global_str('search_str'))
  {
    set_global_str('previous_search_str', global_str('search_str'));
    set_global_str('search_str', sc);
    //@log("sc3 = " + sc);
    //@log("set gs3 = " + sc);
  }
}

return(rv);
}



//;;

int
@seek(str sc = parse_str('/1=', mparm_str))
{
str fp = 'Easier seek.';
str so;

// Last Updated: Sep-23-2016

return(@seek_next(sc, so));
}



//;;

int
@seek_from_bof(str sc = parse_str('/1=', mparm_str))
{
str fp = 'Seek from bof.';
str so;

//Last Updated: Sep-23-2016

@bof;

return(@seek_next(sc, so));
}



//;;

int
@seek_in_all_files_core(str sc, str &so, str &fs)
{
str fp = 'Seek in all files.';

int Initial_Line_Number = @current_line_number;
int Initial_Window = @current_window;
int window_counter = 1;

mark_pos;
eol;

if(@seek_next(sc, sO))
{
  so = 'Found in bottom part of initial window.';
  fs = Found_Str;
  pop_mark;
  return(1);
}
else
{
  goto_mark;
  rm('NextWin');
  window_counter++;
}

while(@current_window != Initial_Window)
{
  mark_pos;
  tof;
  if(@seek_next(sc, sO))
  {
    so = 'Found in win. #' + str(window_counter) + '.';
    so += ' @(' + @left(get_line, 32) + ')';
    fs = Found_Str;
    pop_mark;
    return(1);
  }
  else
  {
    goto_mark;
    rm('NextWin');
    Window_Counter++;
  }
}

mark_pos;
tof;
// Search top part of initial window.
if(@seek_next(sc, sO))
{
  fs = Found_Str;
  pop_mark;
  if((@current_line_number == initial_line_number))
  {
    sO = 'This is the ONLY occurrence in all open files.';
    return(2);
  }
  else
  {
    sO = 'Found in top part of initial window.';
  }
  return(1);
}
else
{
  goto_mark;
}

so = 'Search criterion NOT found.';

@say(so);
return(0);
}



//;;

int
@seek_in_all_files_batch_files_o(str sc, str &so, str &fs)
{
str fp = 'Seek in all files batch files only.';

int initial_line_number = @current_line_number;
int initial_window = @current_window;
int window_counter = 1;

mark_pos;
eol;

if(@filename_extension != 'bat')
{
  goto_mark;
  rm('NextWin');
  window_counter++;
}
else if(@seek_next(sc, so))
{
  so = 'Found in bottom part of initial window.';
  fs = Found_Str;
  pop_mark;
  return(1);
}
else
{
  goto_mark;
  rm('NextWin');
  window_counter++;
}

while(@current_window != Initial_Window)
{
  mark_pos;
  tof;
  if(@filename_extension != 'bat')
  {
    goto_mark;
    rm('NextWin');
    window_counter++;
  }
  else if(@seek_next(sc, sO))
  {
    so = 'Found in win. #' + str(window_counter) + '.';
    so += ' @(' + @left(get_line, 32) + ')';
    fs = Found_Str;
    pop_mark;
    return(1);
  }
  else
  {
    goto_mark;
    rm('NextWin');
    Window_Counter++;
  }
}

mark_pos;
tof;
// Search top part of initial window.
if(@seek_next(sc, sO))
{
  fs = Found_Str;
  pop_mark;
  if((@current_line_number == initial_line_number))
  {
    sO = 'This is the ONLY occurrence in all open files.';
    return(2);
  }
  else
  {
    sO = 'Found in top part of initial window.';
  }
  return(1);
}
else
{
  goto_mark;
}

so = 'Search criterion NOT found.';

@say(so);
return(0);
}



//;;

void
@seek_in_all_files_descriptive(str fp, str sc)
{
//str fp = 'Seek in all files simple caller.';

@say(fp + ' Please wait . . .');
str fs;
str so = fp;
@seek_in_all_files_core(sc, so, fs);

@say(fp + ' ' + so);
}



//;;

void
@seek_in_all_files_simplest(str sc)
{
str fp = 'Seek in all files simplest caller.';

@say(fp + ' Please wait . . .');
str fs;
str so = fp;
@seek_in_all_files_core(sc, so, fs);

@say(fp + ' ' + so);
}



//;;

int
@seek_in_all_files_2_arguments(str sc, str &so)
{
str fs = '';
return(@seek_in_all_files_core(sc, sO, fs));
}



//;

str
@hc_word_uc()
{
str fp = 'Highcopy the word under the cursor to the clipboard.';
fp = 'Highcopy word uc.';
str rv = 'Return word under cursor';

@position_cursor_on_a_valid_word;

str_block_begin;

str sc;

sc = get_word_in(@define_what_a_word_is);

// Saw this cool line of code in the forums: Forward_Till(Word_Delimits);

switch(@previous_character)
{
  // I uncommented the following line on Apr-23-2014.
  case '.':
  case '%':
  case ',':
    left;
    break;
}

@copy_with_marking_left_on;

block_end;

rv = @get_selected_text;
@say(fp + ' (length = ' + str(length(rv)) + ')');
return(rv);

/* Use Case(s)

3. Dec-11-2013: Equals signs in batch files. In the following line "testcase" should be 
highcopied.

set case=testcase

2. May-13-2013: If you start on the right of the string, email address should be highlighted.
raybass8@gmail.com

- 1. Jan-5-2012: Cursor is at eol and I want the function name to be highlighted.
str  @hc_word_uc();

*/

}



//;

void
@determine_if_bf_label_is_unique()
{
str fp = "Determine if batch file label is unique.";

int current_column_number = @current_column_number;
int current_line_number = @current_line_number;

str sc;

sc = @hc_word_uc;
sc = make_literal_x(sc);
sc = @batch_file_label + sc + '$';

@bof;

@seek(sc);

if(@current_line_number == current_line_number)
{
  if(!@seek(sc))
  {
    fp += ' It is.';
    goto_col(current_column_number);
  }
  else
  {
    fp += ' It is NOT 1.';
  }
}
else
{
  fp += ' It is NOT 2.';
}

@say(fp);
}



//;+ Find LC



//;;

str
@find_lc_core(str lc = parse_str('/parm=', mparm_str), int &search_criterion_was_found, str 
introduction)
{

str fp = 'Find Launch Code with user prompted input: ' + caps(lc);

// The difference between this and the original service is that this one
// uses my new "Seek" method which attempts to avoid the placement of
// extra bookmarks for "out-of-orginal" window finds.

str so;
str Distilled_lc;

int Initial_Window = @current_window;

if(lc == '')
{
  lc = @get_user_input_nonspace(Introduction);
}

if((lc == "Function aborted."))
{
  search_criterion_was_found = 0;
  @say(lc);
  return(lc);
}

if(@first_character(lc) != '!')
{
  lc = '!' + lc + ',||\)';
}

search_criterion_was_found = @seek_in_all_files_2_arguments(lc, so);

@say(introduction + ' ' + so);
return(so);
}



//;;

int
@find_lc(str lc = parse_str('/1=', mparm_str))
{

/*
skw find_known_lc
*/

str fp = "Find LC.";
// Prompt for, then find launch code.

int search_criterion_was_found = 0;

if(lc == '')
{
  lc = @get_user_input_nonspace(fp);
}

if(lc == 'Function aborted.')
{
  @say(lc);
  return(0);
}

str so = @find_lc_core(lc, search_criterion_was_found, fp);

str Distilled_lc = @distill_lc(lc);

fp = @trim_period(fp) + ' ' + char(34) + Distilled_lc + char(34) + '. ' + so;

@say(fp);
return(search_criterion_was_found);
}



//;;

void
@@find_lc(str lc = parse_str('/1=', mparm_str))
{
str fp = "Find launch code.";
@header;
int search_criterion_was_found = @find_lc(lc);
@footer;
}



//;; (skw lc_known, known_launch_code, launch_code_known)

int
@find_lc_known(str &introduction, str lc)
{
str fp = 'Find known launch code.';

int search_criterion_was_found = 0;

str so = @find_lc_core(lc, search_criterion_was_found, introduction);

if(search_criterion_was_found)
{
  return(search_criterion_was_found);
}

introduction += ' ' + so;

return(0);
}



//;;

int
@find_lc_ui(str introduction)
{
str fp = "Find launch code using user input. For internal use.";

int search_criterion_was_found = 0;

str lc = @get_user_input_nonspace(introduction);

if(lc == 'Function aborted.')
{
  @say(introduction + ' ' + lc);
  return(0);
}

str so = @find_lc_core(lc, search_criterion_was_found, introduction);

if(search_criterion_was_found)
{
  return(1);
}

introduction += ' ' + so;

@say(introduction);

return(0);
}



//;;

void
@find_lc_ending_in_ui
{
str fp = "Find launch codes ending in 2 characters inputted by user.";

str rs;
str so;
int EFBO = true; // Execute First Block Only

@header;

str sc = '!..' + @get_user_input_raw(fp);

right;

if(EFBO){ int Is_Found = @seek_in_all_files_2_arguments(sc, so); EFBO = 0; }

/* Use Case(s)

*/

fp = 'Find launch codes ending in. (' + @distill_lc(sc) + ')';

@footer;
@say(found_str);
@say(fp + ' ' + so);
}



//;;

void
@find_lc_end_with_uc
{
str fp = 'Find launch codes that end with word under cursor.';

/*

Notice that there is no "@find_lc_begin_with_uc". There used to be, but I moved it to 
the code graveyard.

(skw prime time)

To find launch codes beginning with a particular sequence of characters, just use Ctrl+F + 
"!fv" for example. I removed the macros that specifically do this because they are overkill 
when such and easy and straightfoward method exists.

*/

@header;

str sc = @get_wost;
sc = ' ||\(\!.+' + sc + ',||\)';

int Is_Found = @seek_in_all_files_2_arguments(sc, fp);

@footer;
@say(fp);
}



//;;

void
@find_lc_with_uc
{
str fp = 'Find launch codes with word under cursor.';

// fcd: Aug-21-2015

@header;
@save_location;
if(!@find_lc(@get_wost))
{
  fp += ' NOT found.';
}

@footer;
@say(fp);
}



//;;

void
@find_lc_again
{
str fp = 'Find again for Launch Codes. ';
str so = '';
@header;

@seek_in_all_files_2_arguments(global_str('lc'), so);

@footer;
@say(fp + so);
}



//;;

str
@get_lc_on_current_line(str &lc)
{
str fp = "Get FIRST launch code on current line.";

@bol;

if(find_text(@lc, 1, _RegExp))
{
  lc =  found_str;
  lc = @distill_lc(lc);
  return(lc);
}
else
{
  fp += ' LC NOT found on current line.';
  return("");
}

@say(fp);
}



//;;

str
@get_indicated_lc_2()
{
str fp = "Get indicated lc.";

// fcd: Aug-12-2014

str indicated_lc;

int position_of_caret = xpos('^', get_line, 1);

if(!position_of_caret)
{
  position_of_caret = xpos('&', get_line, 1);
}

goto_col(position_of_caret + 1);

while(!at_eol)
{
  indicated_lc += @current_character; 
  right;
}

indicated_lc = @trim_period(indicated_lc);

/* Use Case(s)

:Noble Hustle !+a

:Noble Hustle !+au

:Noble Hustle !+im2

:Miguel De Icaza !+gi34

:Miguel De Icaza !+gi

*/

return(indicated_lc);
}



//;;

void
@determine_if_lc_is_unique()
{
str fp = "Determine if lc is unique.";

str lc;
str so;

if((@first_character(get_line) == ':') && (@is_batch_file))
{
  @determine_if_bf_label_is_unique;
  return();
}

@save_location;

str so = @get_lc_on_current_line(lc);

if(length(lc) == 0)
{
  fp += ' No launch code was found on current line.';
  @say(lc);
  @say(fp);
  return();
}

//@say(fp + ' lc: ' + lc + ' (Jan-17-2017 1:09 PM)');return();

fp += ' (' + lc + ')';

if(@find_lc_known(so, lc) == 2)
{
  fp += ' It is.';
}
else
{
  fp += " It's NOT.";
}

/* Use Case(s)

- 1. Use Case on Dec-16-2011:

blah (!zpx, !ttt)

blah (!tttx)

*/

@say(fp);
}



//;;

void
@@determine_if_lc_is_unique
{
@header;
@determine_if_lc_is_unique;
@footer;
}



//;

int
@seek_previous(str sc, str &sO)
{
str fp = 'Seek previous.';
int Return_Value = 0;

if(@first_character(sc) == '@')
{
  sc = '\' + sc;
}

if(@last_character(sc) == '@')
{
//sc = @trim_last_character(sc) + '\' + @last_character(sc);
}

if(find_text(sc, 0, _regexp | _backward))
{
  fp = 'Found: ' + found_str + '.';
  sO = 'Found at: ' + @left(get_line, 35);
  right;
  Return_Value = 1;
}
else
{
  sO = 'NOT found.';
  fp += ' ' + sO;
}

int Set_Global_Search_Tag = true;
str First_Character = @first_character(sc);
if(First_Character == '!')
{
  Set_Global_Search_Tag = false;
  set_global_str('lc', sc);
}

// I don't want double q to "usurp" the buffer for "find again". So this is what this
// if block accomplishes.
if(sc == ('(q' + 'q)'))
{
  Set_Global_Search_Tag = false;
}

if(Set_Global_Search_Tag == true)
{
  set_global_str('search_str', sc);
}

@say(fp);
return(Return_Value);
}



//;+ Replace



//;;

int
@replace_string_in_file_int(str old_String, str new_String)
{
str fp = 'Replace all occurrences of a particular string or special character in a file.';

int Number_of_Replacements = 0;
tof;

while(find_text(old_String, 0, _regexp || _CaseSensitive))
{
  Replace(new_String);
  Number_of_Replacements++;
  // This statement causes a problem with case sensitive only type searches and
  // with searches inserting blank lines. Use "@replace_string_in_file_cs"
  // for those type of search-and-replace functions.
  tof; 
}

return(Number_of_Replacements);
}



//;;

int
@replace_string_in_file_cs(str old_String, str new_String)
{
str fp = 'Replace all occurrences of a particular string or special character in a file. This 
  is specially designed for case-sensitive searches or searches such adding blank lines
  before certain found strings that will go into an endless loop if you go back to TOF 
  after each search.';

int Number_of_Replacements = 0;
tof;

while(find_text(old_String, 0, _regexp || _CaseSensitive))
{
  Replace(new_String);
  Number_of_Replacements++;
  //tof; // This statement causes a problem with case sensitive only type searches.
  // That is why it is commented.
}

return(Number_of_Replacements);
}



//;+ Replace All



//;;

str
@replace_all_occurrences_in_file(str character_to_Replace, str new_Character)
{
return("Replace '" + character_to_Replace + "' with '" + new_Character + "'. Number of 
  Replacements: " + str(@replace_string_in_file_int(character_to_Replace, new_Character)) + 
  "."); 
}



//;;

str
@replace_all_occurrs_inf_one_tof(str character_to_Replace, str new_Character)
{
str fp = 'Replace all occurrences in file without going to tof.';
return("Replace '" + character_to_Replace + "' with '" + new_Character + "'. Number of 
  Replacements: " + str(@replace_string_in_file_cs(character_to_Replace, new_Character)) + 
  "."); 
}



//;

str
@replace_next_occurrence_only(str sc, str replace_String_Regex)
{
str fp = 'Swap 1 occurrence of a particular sc in a file.';

int Number_of_Replacements = 0;
if(find_text(sc, 0, _regexp))
{
  Replace(replace_String_Regex);
  Number_of_Replacements++;
}

fp = ' Number of replacements: ' + str(Number_of_Replacements);
@say(fp);
return(fp);
}



//;

void
@finder_say_version
{
str fp = "Finder.s v. Mar-9-2010.";
@say(fp)
}



//;+ Find Next



//;; (skw find_blank_line)

void
@find_next_blank_line()
{
str fp = "Find next blank line.";
str rs = "";
str so = "";
find_text(@blank_line(fp, rs), 0, _regexp)
down;
@bol;
}



//;;

void
@find_rightmost_colon_on_curline()
{
str fp = "Find rightmost colon on current line.";

@eol;

while(!@at_bol)
{
  if((@current_character == ':') and (@next_character == ' '))
  {
    // Leave cursor positioned on the first letter of the post-rightmost colon phrase.
    right;
    right;
    break;
  }
  left; 
}

@say(fp);
}



//;;

str
@find_next_bullet()
{
str fp = 'Find next bullet.';
str rv = "";

int Current_Line_Number = @current_line_number;

if((Cur_Char == ':')|(Cur_Char == ';'))
{
  right;
}
find_text('(^:$)||(^:[^:])', 0, _regexp);
@eoc;

// That is, the cursor has not moved.
if(Current_Line_Number == @current_line_number)
{
  rv = 'at_eof';
  fp += ' Cursor has reached the last bullet.';
}

//@say(fp);
return(rv);
}



//;;

void
@find_next_eof_marker
{
str fp = 'Find next marker.';
str rs;
str sc;
str so;
@header;

sc = '!' + 'ef';

right;
int Is_Found = @seek_in_all_files_2_arguments(sc, fp);

@footer;
@say(so);
}



//;

void
@find_phrases_ending_in_uc
{
str fp = 'Find phrases ending in the word under the cursor.';
@header;

str sc = @get_wost;
sc = ' ' + sc;

int Is_Found = @seek_in_all_files_2_arguments(sc, fp);

@footer;
@say(fp);
}



//;

str
@find_special_character(str sc)
{
str fp = 'Find occurrence of a particular special character or string in a file.';
str em = '';

tof;
if(find_text(sc, 0, _regexp))
{
  fp = 'Found character "' + sc + '".';
  em = fp;
}
else
{
  fp = 'NOT found character "' + sc + '".';
}

@say(fp);
return(em);
}



//;+ Find From



//;;

void
@ff_top(str sc)
{
str fp = 'Find from top. Start at BOF and only search this file.';

// lu: Mar-18-2019

str so;

mark_pos;
tof;

sc = make_literal_x(sc);
Set_Global_Str('SEARCH_STR', sc);

if(find_text(sc, 0, _regexp))
{
  so = 'Found in this file.';
  pop_mark;
}
else
{
  so = '"' + sc + '"' + ' NOT found in this file. ';
  goto_mark;
}

@say(fp + ' ' + so);
}



//;;

void
@ff_top_ui
{
str fp = 'Find from top using ui.';

// lu: Mar-18-2019

@header;

str sc = @get_user_input_raw(fp);

@ff_top(sc);

@footer;

//@say(fp + ' (' + sc + ')');
}



//;;

void
@ff_top_wost
{
str fp = 'Find from top using wost.';

// lu: Mar-18-2019

@header;

str wost = @get_wost;

@ff_top(wost);

@footer;

@say(fp + ' (' + wost + ')');
}



//;+ More Find



//;;

void
@find_again
{
str fp = 'Find again.';

str so = '';

@header;

@seek_in_all_files_2_arguments(global_str('search_str'), so);

if(@current_column == 2)
{
  eol;
}

@footer;

@say(fp + ' ' + so);
}



//;;

void
@find_backwards(str sc = parse_str('/1=', mparm_str))
{
str fp = 'Find backwards.';

mark_pos;

up;
eol;

sc = make_literal_x(sc);

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

@say(fp);
}



//;;

void
@ff_here_backwards_ui
{

str fp = 'Find from here backwards using ui.';

@header;

str sc = @get_user_input_raw(fp);

@find_backwards(sc);

@footer;

@say(fp);
}



//;;

void
@ff_here_backwards_wost
{

str fp = 'Find from here backwards using wost.';

@header;

@find_backwards(@get_wost);

@footer;

@say(fp);
}



//;;

void
@find_again_backwards
{
str fp = 'Find again backwards.';

@header;

up;
if(!find_text(global_str('search_str'), 0, _regexp | _backward))
{
  fp += ' NOT found. May be first occurrence in file. (' + global_str('search_str') + ')';
  down;
}

@footer;

@say(fp);
}



//;

void
@ff_here_ui()
{
str fp = 'Find beginning here and only search this file: ';

str sc = @get_user_input_raw(fp);
if(sc == 'Function aborted.')
{
  @say(sc);
  return();
}

mark_pos;

set_global_str('search_str', sc);

if(find_text(sc, 0, _regexp))
{
  fp = 'Found in this file.';
  pop_mark;
}
else
{
  fp = 'Not found in this file.';
  goto_mark;
}

@say(fp);
}



//;

void
@find_with_block_marking()
{
str fp = 'Find with block marking.';

/*
(skw

find with
from here till
from_here
mark block
search with marking
search_with_marking
with_highlight

)
*/

rm('MStrBlck');
down;
@ff_here_ui;

@say(fp);
}



//;

str
@find_uppercased_clifs()
{
str fp = 'Find uppercased launch codes.';
str so = '';
str em = '';

str sc = '![A-Z]+[A-Za-z]*,||\)';
right;
if(find_text(sc, 0, _regexp | _casesensitive))
{
  em = fp;
}

/* Use Cases

*/

@say(fp);
return(em);
}



//;

void
@find_phrases_ending_in
{
str fp = 'Find last part of word. This is a more liberal version of "Find_Last_Word".';
@header;

str sc = @get_wost;
sc = sc + ':||$';

int Is_Found = @seek_in_all_files_2_arguments(sc, fp);

/* Use Case(s)

ware

test

crapware

*/

@footer;
@say(fp);
}



//; (skw find_most_number, most number)

void
@find_words_with_many_lookups
{
str fp = 'Find words with many lookups.';

str sc;
str so;

@header;

sc = 'lk\#[1-9][0-9]';

int Is_Found = @seek_in_all_files_2_arguments(sc, fp);

@footer;
@say(fp);
}



//; (!cmrx, !reg, !regex) (skw universal_search_criterion, regex collection, regex list, not in the list)

void
@find_minor_league_regex
{
str fp = "Temporary but commonly searched for search criteria. Temporary because this is a 
step below my permanent regexes. If I use something from here a lot, it should be incorporated 
into my regexes. This is like the minor leagues for my regexes.";

int EFBO = true; // Execute First Block Only

str fp = "";
str rs;
str sc;
str so;

if(@current_line > 14000)
{
//  tof;
}

@header;
sc = '';
//sc = '[^}]$$$';                 // 2 blanks spaces that are not part of standard rubric 
                                  //   whitespace.
//sc = '^:.+ - ';                 // Misformed bullets
//sc = '\(||,!..' + 'cl';         // Old Style Clifs
//sc = '\(||,!..' + 'fo';         // Old Style Folders
//sc = '(\?||\.):';               // Old Style Colons
//sc = '!..' + '77';              // Old Style Credentials
//sc = '!..' + 'fv';              // Old Style Favorites
//sc = '\(||,!..' + 'lk';         // Old Style Links
//sc = '\(||,!..' + 'mi';         // Old Style Miscellany
//sc = '(\.)([^ ' + '])';         // Period Succeeded by non-space Character
//sc = '\[[1-9]\]';               // Wikipedia Annotations

fp = "Big League Lookup Counters";
sc = 'lk\#' + '10'; // many hits
sc = 'lk\#' + '11';
sc = 'lk\#' + '12';
sc = 'lk\#' + '13';
sc = 'lk\#' + '14';
sc = 'lk\#' + '15';
sc = 'lk\#' + '16';
sc = 'lk\#' + '17';
sc = 'lk\#' + '18';
sc = 'lk\#' + '19'; // 1 hit
sc = 'lk\#' + '20'; // 1 hit
sc = 'lk\#' + '21'; // 0 hits
sc = 'lk\#' + '22'; // 0 hits
sc = 'lk\#' + '3[0-9]'; // 1 hits
sc = 'lk\#' + '2[0-9]'; // 0 hits

sc = '2' + '2[0-9]'; // Body weight in the 220s. Hits = 0
sc = '2' + '3[0-9]'; // Body weight in the 230s. Hits = 1
sc = '2' + '4[0-9]'; // Body weight in the 240s. Hits = 16 Mar-13-2015
sc = '2' + '6[0-9]'; // Body weight in the 260s. Hits = 3
rs = '\0';
right;

if(EFBO){ int Is_Found = @seek_in_all_files_2_arguments(sc, so); EFBO = 0; }
if(EFBO){ @seek_next(sc, so); EFBO = false; }
if(EFBO){ so = @replace_next_occurrence_only(sc, rs); EFBO = 0; }
if(EFBO){ so = @replace_all_occurrences_in_file(sc, rs); EFBO = 0; }

@footer;
@say(fp + ' ' + so);
}



//;+ Find In Big Segment Headers (skw rubric header, the mother function)



//;;

void
@find_in_cmac_big_segment_header(str sc)
{
str fp = 'Find in CMAC big segment headers.';
str so;

if(sc == '')
{
  sc = @get_user_input_raw(fp);
}

if((sc == "Function aborted."))
{
  @say(sc);
  return();
}

sc = @equate_spaces_and_dashes_wcl(sc);

// The following regex enables cross-line searching up to 3 lines long.
// This only works based on the file type you're in!
//sc = @big_segment + sc;
str rs;
sc = '^//;' + @anything(fp, rs) + sc;
//sc = '^;.@(()||($.@)||($.+$.@))' + sc;

@seek_in_all_files_2_arguments(sc, so);

@say(fp + ' ' + so);
}



//;;

void
@@find_in_cmac_big_segment_head
{
@header;
@find_in_cmac_big_segment_header('');
@footer;
}



//;;

void
@find_in_big_segment_header(str sc)
{
str fp = 'Find in big segment headers.';
str so;

if(sc == '')
{
  sc = @get_user_input_raw(fp);
}

if((sc == "Function aborted."))
{
  @say(sc);
  return();
}

sc = @equate_spaces_and_dashes_wcl(sc);

sc = '^;.@(()||($.@)||($.+$.@))' + sc;

@seek_in_all_files_2_arguments(sc, so);

@say(fp + ' ' + so);
}



//;;

void
@find_in_rubric_header(str sc)
{
str fp = 'Find in rubric headers.';
str so;

if(sc == '')
{
  sc = @get_user_input_raw(fp);
}

if((sc == "Function aborted."))
{
  @say(sc);
  return();
}

sc = @equate_spaces_and_dashes_wcl(sc);

sc = @big_segment + '.@' + sc;

@seek_in_all_files_2_arguments(sc, so);

@say(fp + ' ' + so);
}



//;;

void
@find_in_rubric_header_ss
{
str fp = 'Find in big segment header ss.';
@header;

str sc = @get_subject_or_selected_text;

@find_in_rubric_header(sc);

@footer;
}



//;;

void
@find_in_big_segment_header_uc(str sc = parse_str('/1=', mparm_str))
{
str fp = 'Find in big segment headers using the word under the cursor.';
@header;
if(sc == '')
{
  sc = @get_subject_or_selected_text;
}
@find_in_big_segment_header(sc);
@footer;
}



//;;

void
@find_in_big_segment_header_ui
{
@header;
@find_in_big_segment_header('');
@footer;
}



//;;

void
@find_in_rubric_header_ui
{
@header;
@find_in_rubric_header('');
@footer;
}



//;+

void
@open_cmac_files()
{
str fp = "Open CMAC files.";

rm("@open_file_parameter_way /FN=" + Get_Environment('savannah') +
  "\\cmac\\Quickla-for-Multi-Edit\\\Aliases.s");

rm("@open_file_parameter_way /FN=" + Get_Environment('savannah') +
  "\\cmac\\Quickla-for-Multi-Edit\\\Shared.s");

rm("@open_file_parameter_way /FN=" + Get_Environment('savannah') +
  "\\cmac\\Quickla-for-Multi-Edit\\\Regexes.s");

rm("@open_file_parameter_way /FN=" + Get_Environment('savannah') +
  "\\cmac\\Quickla-for-Multi-Edit\\\Finder.s");

rm("@open_file_parameter_way /FN=" + Get_Environment('savannah') +
  "\\cmac\\Quickla-for-Multi-Edit\\\Format.s");

rm("@open_file_parameter_way /FN=" + Get_Environment('savannah') +
  "\\cmac\\Quickla-for-Multi-Edit\\\ListMgr.s");

rm("@open_file_parameter_way /FN=" + Get_Environment('savannah') +
  "\\cmac\\Quickla-for-Multi-Edit\\\Searcher.s");

rm("@open_file_parameter_way /FN=" + Get_Environment('savannah') +
  "\\cmac\\Quickla-for-Multi-Edit\\\Clif.s");

rm("@open_file_parameter_way /FN=" + Get_Environment('savannah') +
  "\\cmac\\Quickla-for-Multi-Edit\\\Jonathan's_Macros.s");

@say(fp);
}



//;;

void
@@open_cmac_files
{
@header;
@save_location;
@open_cmac_files;
@restore_location;
@footer;
}



//;+ Find Definition



//;;

int
@find_cmac_definition(str macro_Name, int is_exact_search)
{
str fp = 'Find macro definition.';

str so;
int rv;

str distilled_macro_name = macro_name;

macro_Name = @cmac_function_header + macro_Name;

// Note: The F12 key is a whole word matching function.
if(is_exact_search)
{
  macro_Name += '$||\(';
}

@save_location;

@open_cmac_files;

@restore_location;

fp = 'Find macro definition for ' + '"' + Distilled_Macro_Name + '".';

if(@seek_in_all_files_2_arguments(macro_Name, so))
{
  down;
  left;
  rv = 1;
}
else
{
  @restore_location;
  fp += ' NOT found.';
  rv = 0;
}

@say(fp);

/* Use Case(s)

2. Use Case on Jan-16-2012: F12 this.
@ rt m

1. Use Case on Jan-16-2012: Ctrl+F12 this.
big_segment

*/

return(rv);
}



//;;

void
@find_template_definition_core(str sc)
{
str fp = 'Find in template definition.';

str so;

@save_location;

tof;

sc = @big_segment + sc;

if(@seek_in_all_files_2_arguments(sc, so))
{
  right;
  left;
}
else
{
  @restore_location;
  fp += ' NOT found.';
}

@say(fp);
}



//;;

void
@find_template_definition
{
str fp = "Find template definition.";

@header;
@find_template_definition_core(@get_wost);

@footer;
}



//;

void
@find_tsql_definition(str function_Name)
{
str fp = 'Go to TSQL definition, level of abstraction zero.';

str so;

@save_location;

rm("@open_file_parameter_way /FN=" + Get_Environment('savannah') +
  "\\Transact_SQL\\Project X Analysis Installation.sql");

tof;

function_Name = '^create (procedure)||(function) ' + function_Name;

fp = 'Find T-SQL definition for ' + '"' + function_Name + '".';

if(!@seek_in_all_files_2_arguments(function_Name, so))
{
  fp += ' NOT found.';
  @restore_location;
}

@say(fp);
}



//;

void
@find_macro_content_uc
{
str fp = 'Find macro content, use word under cursor or selected block.';

@header;

str sc = Global_Str('highlighted_text');
if(sc == "")
{
  sc = @get_wost;
}

str so;

@save_location;

fp = 'Find macro content for ' + '"' + sc + '".';

@open_cmac_files;

@restore_location;
eol;

if(!@seek_in_all_files_2_arguments(sc, so))
{
  @restore_location;
  fp += ' NOT found.';
}

@footer;
@say(fp + ' ' + so);
}



//;

void
@find_tsql_definition_ui
{
str fp = 'Go to T-SQL definition, for word under cursor or selected block.';

@header;

str sc = @get_user_input_raw(fp);
if(sc == 'Function aborted.')
{
  @say(sc);
  return();
}

sc = '.*' + sc;

@find_tsql_definition(sc);

@footer;
}



//;

int
@seek_with_case_sensitivity(str sc, str &sO)
{
if(find_text(sc, 0, _regexp | _CaseSensitive))
{
  sO = 'Found: ' + found_str + '.';
  right;
  return (1);
}
return (0);
}



//;+ Work Related



//;;

void
@find_entity_type(str sc = parse_str('/1=', mparm_str))
{
str fp = "Find entity type.";
str so;

@header;

if(sc == '')
{
  sc = @get_user_input_raw(fp);
}

sc = '<entity type="Tmt.Dao.' + sc;
tof;
@seek_next(sc, so);

@footer;

fp += ' (' + sc + ')';
set_global_str('inner_status_message', fp);

@say(fp + ' ' + so);
}



//;;

void
@find_xsl_template(str sc = parse_str('/1=', mparm_str))
{
str fp = "Find XSL template.";
str so;

@header;

if(sc == '')
{
  sc = @get_user_input_raw(fp);
}

str rs;
sc = @big_segment + @anything(fp, rs) + sc;
@seek_in_all_files_2_arguments(sc, so);

@footer;
@say(fp + ' ' + so);
}



//;+ Routers



//;;

void
@find_definition_router(str function_Name, str filename_Extension)
{
str fp = "Find definition, search exactly.";

if(@is_markup_file(filename_Extension))
{
  @find_template_definition_core(function_Name);
  return();
}

if(@first_character(function_Name) == '@')
{
  @find_cmac_definition(function_Name, 1);
}
else if(@left(function_Name, 3) == 'sp_')
{
  @find_tsql_definition(function_Name);
}
else
{
  @find_in_big_segment_header(function_Name);
}

}



//;; F12 Key

void
@find_definition_cx()
{
str fp = "Find definition under cursor, search exactly.";

str sc = @get_wost;

@find_definition_router(sc, @filename_extension);
}



//;;

void
@@find_definition_cx
{
@header;
@find_definition_cx;
@footer;
}



//;;

void
@find_cmac_definition_ux
{
str fp = "Find definition ux for cmac.";
@header;

str sc = @get_user_input_raw(fp);
if(sc == 'Function aborted.')
{
  @say(sc);
  return();
}

while(@first_character(sc) == '@')
{
  sc = @trim_first_character(sc);
}

sc = make_literal_x(sc);

@find_cmac_definition(sc, 0);

@footer;
}



//;;

void
@find_cmac_definition_uc
{
str fp = 'Find macro definition, use word under cursor or selected block.';

@header;

str sc = @get_wost;

while(@first_character(sc) == '@')
{
  sc = @trim_first_character(sc);
}

sc = make_literal_x(sc);

sc = '.*' + sc;

@find_cmac_definition(sc, 0);

/* Use Case(s)

- 2. Use Case on Jan-16-2012:
big_segment

- 1. Use Case on Jan-16-2012:
rt m

*/

@footer;
}



//;;

void
@find_cmac_definition_ui
{
str fp = 'Go to macro definition.';

@header;

str sc = @get_user_input_raw(fp);
sc = ".*" + sc;

@find_cmac_definition(sc, 0);

@footer;
}



//;

void
@find_tsql_definition_uc
{
str fp = 'Go to T-SQL definition, for word under cursor or selected block.';

@header;

str sc = @get_wost;

sc = make_literal_x(sc);

sc = ".*" + sc;

@find_tsql_definition(sc);

@footer;
}



//;

void
@find_tsql_definition_uc
{
str fp = 'Go to T-SQL definition, for word under cursor or selected block.';

@header;

str sc = @get_wost;

sc = make_literal_x(sc);

sc = ".*" + sc;

@find_tsql_definition(sc);

@footer;
}



//;

void
@find_definition_ui_exactly
{
str fp = "Find definition ui exactly.";
@header;

str sc = @get_user_input_raw(fp);
if(sc == 'Function aborted.')
{
  @say(sc);
  return();
}

@find_definition_router(sc, @filename_extension);

@footer;
}



//;

void
@find_key_assignment(int findtag = parse_int( "/T=", mparm_str) ) trans2
/*******************************************************************************
                               Multi-Edit Macro
                               06-Mar-98  16:34

  Function: Show the macro assigned to specified key.
  Author: Dan Hughes

             Copyright (C) 2002-2004 by Multi Edit Software, Inc.
 ********************************************************************(ldh)***/
{
  str TStr;
  str Name;
  str macro_name = "";
  str Cmdline;
  str MsgStr = "No Key Assignment";

  int TKey;
  int K1;
  int K2;
  int WCmd;
  int Flags;
  int ModeFlag;

  struct TMsg Msg;

  // Clear out return in queue
  while(PeekMessage( &Msg, 0, wm_Mew_DlgReturn, wm_Mew_DlgReturn, pm_Remove) );

//  do {
    ModeFlag = false;
    TStr = Set_KeyCode(TStr, Frame_Handle, "Check Key Assignment",
        sk_NoCurrentAssign | sk_NoDelete);
    if (Svl(TStr) != 0) {
      K1    = Parse_Int( "/K1=", TStr);
      K2    = Parse_Int( "/K2=", TStr);
      TKey  = K1 | (K2 << 8);

      Inq_Key(K1, K2, 0, Name);         // Check for recorded macros etc.

      if (Svl(Name) == 0) {
        WCmd = WCmd_Key(Cur_Window, TKey);  // Check window list
        if (WCmd) {
          Beep;
          if (WCmd_Find(Cur_Window, WCmd, Flags, K1, K2, Cmdline, TStr) ) {
            MsgStr = Cmdline;
          }
        }
        else {
          WCmd = WCmd_Key(0, TKey);     // Check main cmd list
          if (WCmd) {
            if (WCmd_Find(0, WCmd, Flags, K1, K2, Cmdline, TStr) ) {
              switch (Parse_Int( "\x7F" + "TYPE=", TStr) ) {

                case _db_ct_Macro:
                  MsgStr = "Macro: " + CmdLine;
                  macro_name = CmdLine;
                  break;

                case _db_ct_Program:
                  MsgStr = "Program: " + CmdLine;
                  break;

                case _db_ct_Command:
                  MsgStr = "Command: " + Hex_Str(Ascii(Cmdline) );
                  break;

                case _db_ct_Mode:
                  MsgStr = "Mode: " + Parse_Str( "\x7F" + "NAME=", TStr);
                  ModeFlag = true;
                  break;

                default:
                  MsgStr = CmdLine;
              }
            }
          }
        }
      }
      else {
        int recnum = 0;
        int flags  = 0;
        if (DBGetRecord (_ConfigFile, "KEYMAC.DB", "KEY", tStr, RecNum, flags, "") ==
          _NoError) {

          MsgStr = "Permanent Keystroke Macro: " + Parse_Str( "D=", tstr);
        }
        else if (Str_Char(Name, 1) == "\x7F" ) {
          MsgStr = "Temporary Keystroke Macro";
        }
        else {
          MsgStr = "Window macro: " + Name;
          macro_name = Name;
        }

      }
      Make_Message(MsgStr);
      if (FindTag && (macro_name != "" ) ) {

        // try to locate macro using tags
        int Position;

        macro_name = Remove_Space(macro_name);
        if ( (Position = XPos( "^", macro_name, 1) ) != 0) {

          // Delete the file name from command line because tags don't handle it.
          macro_name = str_del(macro_name, 1, position);
      }
      // Here is the beginning of my modified code. - JRJ Nov-3-2008
      make_message(Cmdline);
      str lc = '';
      int Position_of_Equal_Sign;
      if((Position = XPos( " ", macro_name,  1)) != 0)
      {
        Position_of_Equal_Sign = XPos( "=", macro_name,  1);
        lc = Copy(macro_name, Position_of_Equal_Sign + 1, length(macro_name));
        Set_Global_Str('lc', '!' + lc + ',||\)');
        // Delete macro parameters, if any.
        macro_name = Copy(macro_name, 1, Position - 1);
      }
      @header;

      if(@first_2_characters(macro_name) == '@@')
      {
        macro_name = @trim_first_character(macro_name);
      }

      macro_name = make_literal_x(macro_name);

      @find_cmac_definition(macro_name, 1);
      @footer;
      @say('Find CMAC definition for ' + '"' + @trim_first_character(macro_name) + '".');
      }
    }
//  } while(ModeFla(;

}  // Find_Assign



//;+ Find Duplicate



//;;

void
@find_next_duplicate_line
{
str fp = 'Find next duplicate line.';

@header;

while(!at_eof)
{
  str str_Line_1 = get_line;
  down;
  str str_Line_2 = get_line;
  if(str_Line_1 == str_Line_2)
  {
    fp = "Duplicate found at line # " + str(c_line) + ".";
    break;
  }
  else
  {
    fp = 'No duplicates found.';
  }
}

@footer;

@say(fp);
}



//;;

void
@find_duplicate_line
{
str fp = 'Find duplicate line.';
@header;

tof;
while(!at_eof)
{
  str str_Line_1 = get_line;
  down;
  str str_Line_2 = get_line;
  if(str_Line_1 == str_Line_2)
  {
    fp = "Duplicate found at line # " + str(c_line) + ".";
    break;
  }
  else
  {
    fp = 'No duplicates found.';
  }
}

@footer;
@say(fp);
}



//;+ Find Long Line



//;;

str
@find_long_line()
{
str fp = 'Find lines that exceed the right margin.';
str em = '';

tof;
while(!at_eof)
{
  eol;
  if(c_col > 96)
  {
    goto_col(1);
    fp = 'Found long line.';
    em = fp;
    @say(fp);
    return(em);
  }
  else if (c_col == 96)
  {
    left;
    if(cur_char != ' ')
    {
      fp = 'Found long line.';
      em = fp;
      @say(fp);
      return(em);
    }
  }
  down;
}
fp = 'Long line NOT found.';
tof;

return(em);
}



//;;

int
@find_next_long_line()
{
str fp = 'Find next line that exceeds the right margin.';

mark_pos;

while(!at_eof)
{
    eol;
    if(c_col >= 96 && (@previous_character != ' '))
    {
      goto_col(1);
      fp += ' Found long line.';
      @say(fp);
      pop_mark;
      return(true);
    }
    down;
}

goto_mark;

fp += ' Long line NOT found.';
@say(fp);
return(false);
}



//;;

void
@@find_next_long_line
{
@header;
@find_next_long_line;
@footer;
}



//;;

void
@find_wide_line_in_file
{
str fp = 'Find wide line in file.';

@header;

while(!at_eof)
{
  eol;
  if(@current_column > 96)
  {
    @bol;
    break;
  }
  down;
}
@footer;

@say(fp);
}



//; This is the equivalent of verify that files are well-formed.

void
@validate_format_of_open_files
{

/* As a sidebar, this method is useful to verify that my bul files have not been somehow
corrupted or tampered with. */

@header;

@find_lc('rfal');

str fp = "Validate the format and content of open files.";

@say(fp + ' Please wait . . .');

int Number_of_Windows = 0;
int Window_Counter = @window_count;

str em = '';
str Regex_Description = '';
str rs = '';
str sc;
str so = '';

do
{
  Number_of_Windows++;

  if(length(em) == 0)
  {
    tof;
  }

  // ********* Individual evaluations - Arranged alphabetically by title.

  if(length(em) == 0)
  {
    sc = 'All Words ' + 'Near';
    if(@seek_next(sc, so))
    {
      em = sc;
    }
  }

  if(length(em) == 0)
  {
    if(@seek_next(@alphabetic_character_space_lk(Regex_Description, rs), so))
    {
      em = Regex_Description;
    }
  }

  if(length(em) == 0)
  {
    if(@seek_next(@alphanumeric_space_period(Regex_Description, rs), so))
    {
      em = Regex_Description;
    }
  }

  if(length(em) == 0)
  {
    if(@seek_next(@bol_comma(Regex_Description, rs), so))
    {
      em = Regex_Description;
    }
  }

  if(length(em) == 0)
  {
    if(@seek_next(@bol_space_eol(Regex_Description, rs), so))
    {
      em = Regex_Description;
    }
  }

  if(length(em) == 0)
  {
    if(@seek_next(@broken_cmac_macro(Regex_Description, rs), so))
    {
      em = Regex_Description;
    }
  }

  if(length(em) == 0)
  {
    if(@seek_next(@broken_lc(Regex_Description, rs), so))
    {
      em = Regex_Description;
    }
  }

  if(length(em) == 0)
  {
    if(@filename != 'cs.asc')
    {
      if(@seek_next(@close_parenthesis_number(Regex_Description, rs), so))
      {
        em = Regex_Description;
      }
    }
  }

  if(length(em) == 0)
  {
    if(@seek_next('\[edit\]', so))
    {
      em = '[' + 'edit]';
    }
  }

  if(length(em) == 0)
  {
    if(@seek_next(@defined_for_kids(Regex_Description, rs), so))
    {
      em = Regex_Description;
    }
  }

  if(length(em) == 0)
  {
    if(@is_bullet_file)
    {
      if(@seek_next(@fat_bullet(Regex_Description, rs), so))
      {
        em = Regex_Description;
      }
    }
  }

  if(length(em) == 0)
  {
    if(@seek_next(@fat_rubric(Regex_Description, rs), so))
    {
      em = Regex_Description;
    }
  }

  if(length(em) == 0)
  {
    if(!@is_s_file)
    {
      em = @find_long_line;
    }
  }

  if(length(em) == 0)
  {
    if(@seek_next(@first_known_use(Regex_Description, rs), so))
    {
      em = Regex_Description;
    }
  }

  if(length(em) == 0)
  {
    sc = 'from ' + 'wikipedia';
    if(@seek_next(sc, so))
    {
      em = sc;
    }
  }

  if(length(em) == 0)
  {
    if(@seek_next('\[hide\]', so))
    {
      em = '[' + 'hide]';
    }
  }

  if(length(em) == 0)
  {
    if(@seek_next(@informal_followed_by_a_crowding(regex_description, rs), so))
    {
      em = Regex_Description;
    }
  }

  if(length(em) == 0)
  {
    if(@seek_next(@language_learner(Regex_Description, rs), so))
    {
      em = Regex_Description;
    }
  }

  if(length(em) == 0)
  {
    if(@seek_next(@letter_space_close_parenthesis(Regex_Description, rs), so))
    {
      em = Regex_Description;
    }
  }

  if(length(em) == 0)
  {
    if(@seek_next('meaning \#', so))
    {
      em = 'Meaning ' + '#';
    }
  }

  if(length(em) == 0)
  {
    if(@seek_next('\[\+\]more', so))
    {
      em = 'Plus more.';
    }
  }

  if(length(em) == 0)
  {
    sc = 'Next Word in the ' + 'Dictionary';
    if(@seek_next(sc, so))
    {
      em = sc;
    }
  }

  if(length(em) == 0)
  {
    sc = ' noun[a-rt-z]';
    if(@seek_next(sc, so))
    {
      em = 'Noun followed by an alphabetic character.';
    }
  }

  if(length(em) == 0)
  {
    if(@seek_next(@open_bracket_space(Regex_Description, rs), so))
    {
      em = Regex_Description;
    }
  }

  if(length(em) == 0)
  {
    if(@seek_next(@open_parenthesis_space_letter(Regex_Description, rs), so))
    {
      em = Regex_Description;
    }
  }

  if(length(em) == 0)
  {
    if(@seek_next(@period_colon(Regex_Description, rs), so))
    {
      em = Regex_Description;
    }
  }

  if(length(em) == 0)
  {
    if(@seek_next(@period_space_space_alpha_char(Regex_Description, rs), so))
    {
      em = Regex_Description;
    }
  }

  if(length(em) == 0)
  {
    sc = 'Previous Word in the ' + 'Dictionary';
    if(@seek_next(sc, so))
    {
      em = sc;
    }
  }

  if(length(em) == 0)
  {
    if(@seek_next(@question_mark_colon_space_lk(Regex_Description, rs), so))
    {
      em = Regex_Description;
    }
  }

  if(length(em) == 0)
  {
    if(@seek_next('See .* def' + 'ined', so))
    {
      em = 'Defined preceded by see.';
    }
  }

  if(length(em) == 0)
  {
    sc = 'Share on ' + 'twitter';
    if(@seek_next(sc, so))
    {
      em = sc;
    }
  }

  if(length(em) == 0)
  {
    if(@seek_next(@show_ipa(Regex_Description, rs), so))
    {
      em = Regex_Description;
    }
  }

  if(length(em) == 0)
  {
    if(@seek_next(@space_eol_blank_line(Regex_Description, rs), so))
    {
      em = Regex_Description;
    }
  }

  if(length(em) == 0)
  {
    if(@filename == 'jd.asc')
    {
      if(@seek_next(@space_space_dash_space_space(Regex_Description, rs), so))
      {
        em = Regex_Description;
      }
    }
  }

  if(length(em) == 0)
  {
    if(@seek_next(@space_space_eol(Regex_Description, rs), so))
    {
      em = Regex_Description;
    }
  }

  if(length(em) == 0)
  {
    if(@seek_next(@special_character(Regex_Description, rs, char(4)), so))
    {
      em = Regex_Description;
    }
  }

  if(length(em) == 0)
  {
    if(@seek_next(@special_character(Regex_Description, rs, char(3)), so))
    {
      em = Regex_Description;
    }
  }

  if(length(em) == 0)
  {
    if(@seek_next(@special_character(Regex_Description, rs, char(6)), so))
    {
      em = Regex_Description;
    }
  }

  if(length(em) == 0)
  {
    if(@seek_next(@special_character(Regex_Description, rs, char(10)), so))
    {
      em = Regex_Description;
    }
  }

  if(length(em) == 0)
  {
    if(@seek_next(@special_character(Regex_Description, rs, char(13)), so))
    {
      em = Regex_Description;
    }
  }

  if(length(em) == 0)
  {
    if(@seek_next(@special_character(Regex_Description, rs, char(27)), so))
    {
      em = Regex_Description;
    }
  }

  if(length(em) == 0)
  {
    if(@seek_next(@special_character(Regex_Description, rs, char(29)), so))
    {
      em = Regex_Description;
    }
  }

  if(length(em) == 0)
  {
    if(@seek_next(@special_character(Regex_Description, rs, char(129)), so))
    {
      em = Regex_Description;
    }
  }

  if(length(em) == 0)
  {
    if(@seek_next(@special_character(Regex_Description, rs, char(130)), so))
    {
      em = Regex_Description;
    }
  }

  if(length(em) == 0)
  {
    if(@seek_next(@special_character(Regex_Description, rs, char(132)), so))
    {
      em = Regex_Description;
    }
  }

  if(length(em) == 0)
  {
    if(@seek_next(@special_character(Regex_Description, rs, char(133)), so))
    {
      em = Regex_Description;
    }
  }

  if(length(em) == 0)
  {
    if(@seek_next(@special_character(Regex_Description, rs, char(139)), so))
    {
      em = Regex_Description;
    }
  }

  if(length(em) == 0)
  {
    if(@seek_next(@special_character(Regex_Description, rs, char(147)), so))
    {
      em = Regex_Description;
    }
  }

  if(length(em) == 0)
  {
    if(@seek_next(@special_character(Regex_Description, rs, char(148)), so))
    {
      em = Regex_Description;
    }
  }

  if(length(em) == 0)
  {
    if(@seek_next(@special_character(Regex_Description, rs, char(149)), so))
    {
      em = Regex_Description;
    }
  }

  if(length(em) == 0)
  {
    if(@seek_next(@special_character(Regex_Description, rs, char(150)), so))
    {
      em = Regex_Description;
    }
  }

  if(length(em) == 0)
  {
    if(@seek_next(@special_character(Regex_Description, rs, char(151)), so))
    {
      em = Regex_Description;
    }
  }

  if(length(em) == 0)
  {
    if(@seek_next(@special_character(Regex_Description, rs, char(153)), so))
    {
      em = Regex_Description;
    }
  }

  if(length(em) == 0)
  {
    if(@seek_next(@special_character(Regex_Description, rs, char(154)), so))
    {
      em = Regex_Description;
    }
  }

  if(length(em) == 0)
  {
    if(@seek_next(@special_character(Regex_Description, rs, char(156)), so))
    {
      em = Regex_Description;
    }
  }

  if(length(em) == 0)
  {
    if(@seek_next(@special_character(Regex_Description, rs, char(158)), so))
    {
      em = Regex_Description;
    }
  }

  if(length(em) == 0)
  {
    if(@seek_next(@special_character(Regex_Description, rs, char(171)), so))
    {
      em = Regex_Description;
    }
  }

  if(length(em) == 0)
  {
    if(@seek_next(@special_character(Regex_Description, rs, char(187)), so))
    {
      em = Regex_Description;
    }
  }

  if(length(em) == 0)
  {
    if(@seek_next('/' + 'submit', so))
    {
      em = ' slash submit';
    }
  }

  if(length(em) == 0)
  {
    if(@seek_next(' the' + ' the ', so))
    {
      em = ' the' + ' the ';
    }
  }

  if(length(em) == 0)
  {
    if(@is_bullet_file)
    {
      if(@seek_next(@thin_bullet(Regex_Description, rs), so))
      {
        em = Regex_Description;
      }
    }
  }

  if(length(em) == 0)
  {
    if(@seek_next(@thin_rubric(Regex_Description, rs), so))
    {
      em = Regex_Description;
    }
  }

  if(length(em) == 0)
  {
    if(@seek_next(@thinner_rubric(Regex_Description, rs), so))
    {
      em = Regex_Description;
    }
  }

  if(length(em) == 0)
  {
    if(@seek_next(@thinnest_rubric(Regex_Description, rs), so))
    {
      em = Regex_Description;
    }
  }

  // Three special characters, e. g. degree symbol, e as in nee.
  if(length(em) == 0)
  {
    sc = 'ï¿' + '½';
    if(@seek_next(sc, so))
    {
      em = 'Three special characters.';
    }
  }

  if(length(em) == 0)
  {
    sc = 'tr\.' + 'v';
    if(@seek_next(sc, so))
    {
      em = "'Trv' without a nice separating space.";
    }
  }

  if(length(em) == 0)
  {
    sc = 'v\.' + 'intr';
    if(@seek_next(sc, so))
    {
      em = "'Vintr' without a nice separating space.";
    }
  }

  if(length(em) == 0)
  {
    sc = 'v\.' + 'tr';
    if(@seek_next(sc, so))
    {
      em = "'Vtr' without a nice separating space.";
    }
  }

  if(length(em) == 0)
  {
    switch(@filename)
    {
      case 'cm.asc':
      case 'cs.asc':
      case 'gc.asc':
      case 'it.asc':
      case "jonathan's_macros.s":
      case 'ne.asc':
        break;
      default:
        if(@seek_next(@wikipedia_annotation(Regex_Description, rs), so))
        {
          em = Regex_Description;
        }
        break;
    }
  }

  if(length(em) == 0)
  {
    if(@seek_next(@wikipedia_citation(Regex_Description, rs), so))
    {
      em = Regex_Description;
    }
  }

  if(length(em) == 0)
  {
    if(@seek_next(@synonyms_space_space(Regex_Description, rs), so))
    {
      em = Regex_Description;
    }
  }

  if(length(em) == 0)
  {
    if(@seek_next(@word_history_space_space(Regex_Description, rs), so))
    {
      em = Regex_Description;
    }
  }

  // ********** End of the evaluations.

  if(length(em) == 0)
  {
    refresh=true;
    fp = 'File "' + @filename + 
      '" is in the correct format. Evaluate next file. Please wait . . .';
    @say(fp);
    refresh=true;
    refresh=true;
    refresh=false;
    refresh=false;
    @next_window; 
  }
  else
  {
    @say(em);
    eol;
    @footer;
    return();
  }
} while(Number_of_Windows < Window_Counter);

fp = 'All ' + str(Number_of_Windows) + 
  ' open files have been verified to be in the correct format.';

@footer;
@say(fp);
}



//;+ CMAC Finders



//;;

void
@find_cmac_helper
{
str fp = 'Find CMAC helper.';

@header;

str so;
str sc = @get_subject_or_selected_text;
sc = @equate_spaces_and_underscores(sc);

@open_cmac_files;

if(!@find_lc_known(fp, 'al')) 
{
  @say('Hardcoded lc NOT found.');
  return();
}

int rv = @seek_in_all_files_2_arguments(sc, so);

@footer;

@say(fp + ' ' + so);
}



//;;

void
@find_cmac_definition_ss
{
str fp = 'Go to macro definition with ss.';

@header;

str sc = @get_subject_or_selected_text;
sc = @equate_spaces_and_underscores(sc);

sc = ".*" + sc;

@find_cmac_definition(sc, 0);

@footer;
}



//;

void
@bobs()
{
str fp = 'Go to the beginning of the current big segment. ';
find_text(@big_segment, 0, _regexp | _backward);
}



//;

int
@find_continuum(int find_precision = parse_int('/1=', mparm_str), 
  str starting_position_of_search = parse_str('/2=', mparm_str))
{
str fp = 'Find continuum.';
str fp = '';

// Find with a gradient of search strengths (1-3), with 1 being the most precise.

// I realize that there is no @restore_location in this method. The @restore_location is
// actually called manually after this method. - JRJ Feb-9-2011

// What about search direction, i.e. forwards or backwards? Mar-18-2019

@save_location;

int text_is_selected = false;

if(@text_is_selected)
{
  @save_highlighted_text;
  text_is_selected = true;
}

switch(starting_Position_of_Search)
{
  case 'bof':
    fp += ' Begin at BOF.';
    break;
  case 'bor':
    fp += ' Begin at BOR.';
    break;
  case '':
    fp += ' Begin at current position.';
    break;
  default:
    fp += ' Begin at "' + starting_Position_of_Search + '".';
}

switch(find_precision)
{
  case 1:
    fp += ' Find precisely (fp1).';
    break;
  case 2:
    fp += ' Find normally (fp2).';
    break;
  case 3:
    fp += ' Find liberally (fp3).';
    break;
  case 4:
    fp += ' Find precisely (fp4).';
    break;
  case 5:
    fp += ' Find normally (fp5).';
    break;
  case 6:
    fp += ' Find liberally (fp6).';
    break;
  case 7:
    fp += ' Find precisely using user input (fp7).';
    break;
  case 8:
    fp += ' Find normally using user input (fp8).';
    break;
  case 9:
    fp += ' Find liberally using user input (fp9).';
    break;
  case 12:
    fp += ' Find liberally using Global Search String (fp10).';
    break;
}

str Name_of_File = Truncate_Path(File_Name);

str sc;

if(find_Precision > 9)
{
  sc = global_str('search_str');
  if(sc == 'Function aborted.')
  {
    @say(sc);
    return(0);
  }
  find_Precision -= 9;
}
else if(find_Precision > 6)
{
  sc = @get_user_input_raw(fp);
  if(sc == 'Function aborted.')
  {
    @say(sc);
    return(0);
  }
  find_Precision -= 6;
}
else if(find_Precision > 3)
{
  if(@text_is_selected)
  {
    sc = @get_selected_text;
  }
  else
  {
    sc = @get_wost;
    sc = @trim_colon_et_al(sc);
  }
  find_Precision -= 3;
}
else if(find_Precision <= 3)
{
  sc = @get_subject_or_selected_text;
}

str Pretty_sc = sc;
set_global_str('pretty_sc', sc);

sc = make_literal_x(sc);

// This enforces the idea that 3 will ALWAYS return at least as many as 2 which will ALWAYS
// return at least as many results as 1.

switch(find_Precision)
{
  case 1:
    sc = @equate_spaces_and_dashes(sc);
    //Last Updated: Sep-26-2016
    sc = '^((:#)||(;#)||(:\+ @)||(;\+ @))' + sc;
    sc += '((:)||($)||(!)||(\.)||(\?)||( \())';
      // sc += '((:)||($)||(!)||(\.)||(\?)||( \()||(,))'; Prior to May-18-2018. I removed
      // the comma option.
    break;
  case 2:
    sc = @equate_spaces_and_dashes(sc);
    sc = '^((:#)||(;#))' + sc;
    break;
  case 3:
    sc = @equate_spaces_and_dashes_wcl(sc);
    break;
}

//@log('sp Aug-4-2009 = ' + sc);

/* Use Cases for the ALL 3 types of finds.

test88

- Use Case Dec-29-2008: "wallow in the mire " should find "wallow in the mire". The
trailing space in the search phrase should be truncated for LIBERAL searches only.

wallow in the mire

Use Case Sep-2-2008: If you highlight "c\:" and search, it should not find "c\system" as is
currently the case in the following example.

c\:

c:\

c:\windows\assembly\gac\system.windows.forms\

Use Case #16. If the cursor is at column 1 in the following line, Ctrl+Shift+F should NOT
find this line itself.

searchxx3

searchxx2

Use Case #15:
searchxx

searchxx

Use Case #1: Plain Jane
Emancipate Now

Use Case #2: trailing spaces
Emancipate Now

Use Case #3: Leading colons

Emancipate Now

Use Case #4: dash
Emancipate-Now

Use Case #5: Additional Text
Emancipate Now I hate ticketmaster.

Use Case #6: Cross Line Instance - Unvarnished
Emancipate
Now

Use Case #7: Cross Line Instance With a Space after the first line
Emancipate
Now

Use Case #8: Cross Line Instance With a dash after the first line
Emancipate-
Now

Use Case #9: Nada
Emancipatenow

Use Case #10: Dash Plus Additional Text
Emancipate-Now I hate ticketmaster.

Use Case #11: Nada Plus Additional Text
EmancipateNow I hate ticketmaster.

Use Case #12: Nada Plus Additional Text
EmancipateNow I hate ticketmaster.

Use Case #13: Leading colons Plus Dash Plus Period
Emancipate-Now.

Use Case #14: Not at the beginning of the line
hey now Emancipate-Now.

Search Use Case #14: Intentional Trailing Space
Emancipate

you can't afford not

you can't afford not to

*/

switch(starting_Position_of_Search)
{
  case 'bof':
    @bof;
    break;
  case 'bor':
    @bobs;
    break;
  case '':
    break;
  default:
    if(!@find_lc_known(fp, starting_Position_of_Search)) 
    {
      return(0);
    }
}

str so;
int rv;

rv = @seek_in_all_files_2_arguments(sc, so);

if(rv == 2)
{
  @restore_location;
}

if((text_is_selected) && (rv == 2))
{
  @load_highlighted_text; 
}

@say(fp += ' ' + so + ' (' + Pretty_sc + ')');
return(rv);
}



//;

void
@find_cmac_definition_f12_key()
{
str fp = 'Find macro definition, use word under cursor or selected block.';

if(!@current_line_contains('@'))
{ 
  //  down;
}

str sc = @get_wost;

if(@first_2_characters(sc) == '@@')
{
  sc = @trim_first_character(sc);
}

sc = make_literal_x(sc);

@find_cmac_definition(sc, 1);
}



//;

void
@@find_cmac_definition_f12_key
{
@header;
@find_cmac_definition_f12_key;
@footer;
}



//;

void
@find_batch_file_label()
{
str fp = "Find batch file label.";
@header;

// fcd: Nov-28-2016

str sc = @hc_word_uc();

@bof;

sc = make_literal_x(sc);

str first_sc = sc;

if(@first_character(sc) != ':')
{
  //sc = '^:' + sc + '$';
  //sc = '^:cart$^.#$'; // definition
  //sc = '$$:' + sc + '$'; // definition only!
  sc = '^:' + sc + '$^.*$^set fp'; // works
}

if(!@seek_in_all_files_2_arguments(sc, fp)){
  first_sc = '^:' + first_sc + '$';
  @next_window;
  @seek_in_all_files_2_arguments(first_sc, fp);
}

@footer;
@say('sc: ' + sc);
@say(fp);
}



//;

void
@find_jenkinsfile_function()
{
str fp = "Find Jenkinsfile function.";
@header;

// lu: Mar-22-2019

str sc = @hc_word_uc();

@bof;

sc = make_literal_x(sc);

sc = '^def ' + sc;

@seek_in_all_files_2_arguments(sc, fp);

@footer;
@say('sc: ' + sc);
@say(fp);
}



//;

void
@find_mappings_file_definition()
{
str fp = 'Find mappings file definition.';

str sc = @get_wost;

@bof;

@say(sc);
}



//;

void
@go_to_definition
{
str fp = 'Go to definition';

@header;

if(@first_character(@get_wost) == '@')
{
  @find_cmac_definition_f12_key;
  @footer;
  return();
}

switch(@filename_extension)
{
  case '':
    @find_jenkinsfile_function;
    break;
  case 'bat':
    @find_batch_file_label;
    break;
  case 'config':
    @find_mappings_file_definition;
    break;
  case 's':
  case 'sh':
    @find_cmac_definition_f12_key;
    break;
  default:
    @find_continuum(4, '');
    break;
}

@footer;

}



//;

void
@find_cmac_definition_lc
{
str fp = "Go to macro definition via it's launch code.";

@header;

if(!@find_lc_ui(fp))
{
  @footer;
  return();
}

str so;
@bol;
@seek_next("@", so);

right;

@find_cmac_definition_f12_key;

@footer;
}



//; (!effi)