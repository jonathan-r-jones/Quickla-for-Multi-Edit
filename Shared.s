macro_file Shared; // (!sh)

// Shared utilities.

#include Aliases.sh
#include WinExec.sh // Used by 'Execprog'.



//;

/*

Metadata: Track Size (!tssh)

    Date       Lines    Bytes     Macros  Notes
 -----------  ------  ---------  -------  ---------------------------------------------------

: Jan-1-2019   4,301     72,254      194

: Jul-1-2018   4,320     71,897      196

:May-17-2018   4,286     71,353      194

: Apr-3-2018   4,286     71,293      195

: Jan-3-2018   4,168     68,916      191

:Jun-25-2017   4,165     68,806      191

:Mar-31-2017   4,148     68,550      190

:Nov-17-2016   4,056     67,610      182

: Oct-7-2016   4,021     66,839      181

: Apr-8-2016   3,793     62,597      172

:Dec-31-2015   3,700     60,929      169

: Oct-5-2015   3,686     60,612      169

: Jul-1-2015   3,660     59,926      168

: Apr-1-2015   3,536     58,035      160

:Jan-16-2015   3,274     53,719      135

: Oct-1-2014   3,276     53,861      132

: Jul-1-2014   3,260     53,689      132

:Apr-10-2014   3,215     53,287      129

: Oct-1-2013   3,342     55,032      129

: Jul-1-2013   3,340     54,988      129

: Apr-1-2013   3,315     54,332      129

: Jan-2-2013   3,312     54,210      129

: Oct-1-2012   3,279     53,767      127

:Aug-18-2012   3,343     53,068      129

*/



//;

void
@footer()
{
pop_undo;

// This repetition of lines is apparently necessary. - JRJ Feb-25-2009
// To turn off centering, comment out the 2 "centering" lines below.
@center_line;
refresh=true;
@center_line;
refresh=true;
//redraw; // I saw this line in the Multi-Edit newsletter on May-27-2010.
}



//;+ Is Stuff



//;;

int
@is_bullet_file()
{
str fp = 'Verify that the user is in a file that contains bullets.';

switch(@filename_extension)
{
  case "asc":
    break;
  default:
    @say('This macro only works on bullet type files.');
    return(0);
}
return(1);
}



//;;

int
@is_bull_file()
{
return(@is_bullet_file);
}



//;;

int
@is_text_file()
{
str fp = 'Verify that the user is in a file with a white list extension.';

switch(lower(get_extension(File_name)))
{
  case 'asc':
    @say('This macro only works on text type files.');
    return(0);
    break
  default:
}

return(1);
}



//;;

int
@is_content_area_file()
{
str fp = 'Verify that the user is in a file type that supports content areas.';

switch(@filename_extension)
{
  case '':
  case 'asc':
  case 'bat':
  case 'htm':
  case 'ps1':
  case 's':
  case 'sql':
  case 'xml':
  case 'xsl':
    break;
  default:
    @say('This macro only works on files that support content areas.');
    return(0);
}
return(1);
}



//;;

int
@is_rubric_file()
{
str fp = 'Is rubric file.';

switch(@filename_extension)
{
  case "": // Jenkinsfile
  case "asc":
  case "bat":
  case "ps1":
  case "s":
  case "xsl":
    break;
  default:
    @say('This macro only works on files with rubrics.');
    return(0);
}

return(1);
}



//;;

int
@is_markup_file(str filename_Extension)
{
str fp = 'Is markup file.';
switch(filename_Extension)
{
  case "config":
  case "htm":
  case "xaml":
  case "xml":
  case "xsl":
  case "xslt":
    return(1);
    break;
}
@say(fp + ' (false) ');
return(0);
}



//;;

int
@is_s_file()
{
str fp = 'Verify that the user is in a file with a "s" extension.';
if(lower(get_extension(File_name)) != 's')
{
  return(0);
}
@say(fp + ' True.');
return(1);
}



//;;

int
@is_sql_file()
{
str fp = 'Verify that the user is in a file with a "sql" extension.';
if(lower(get_extension(File_name)) != 'sql')
{
  @say('This macro only works on "sql" type files.');
  return(0);
}
@say(fp + ' True.');
return(1);
}



//;;

int
@is_batch_file()
{
str fp = 'Verify that the user is in a file with a "bat" extension.';
if(@filename_extension != 'bat')
{
  @say('This macro only works on "bat" type files.');
  return(0);
}
@say(fp + ' True.');
return(1);
}



//;;

int
@is_jenkinsfile()
{
str fp = 'Verify that the user is in a jenkinsfile.';
if(@filename != 'jenkinsfile')
{
  @say('This macro only works on jenkinsfiles.');
  return(0);
}
@say(fp + ' True.');
return(1);
}



//;

str
@constant_function_aborted()
{
// fcd: Dec-2-2016
return("Function aborted.");
}



//;+ Is Code



//;;

int
@is_code_file()
{
str fp = 'Verify that the user is in a file with a code file.';
switch(lower(get_extension(File_name)))
{
  case '':
  case 'bat':
  case 'cs':
  case 'js':
  case 'ps1':
  case 's':
  case 'sql':
  case 'xsl':
  case 'xslt':
    break;
  default:
    @say('This macro only works on code type files.');
    return(0);
}
@say(fp + ' True.');
return(1);
}



//;;

int
@is_code_indentation()
{
str fp = "Is code indentation.";

if(!@is_code_file)
{
  return(0);
}

if((cur_char == ' ') and (@previous_character == ' '))
{
  return(true);
}

if((cur_char == ' ') and (@current_column == 1))
{
  return(true);
}

@say(fp + ' (0)');
return(false);
}



//;

void
@position_cursor_on_a_valid_word()
{
str fp = "Position cursor on a valid word.";

str Permanent_Word_Delimits = word_delimits;

// What this does in effect is that if you are BEYOND EOL, go left to EOL.
if(at_eol)
{
  // This tricky code says If you are past eol, then go to the TRUE eol. Also,
  // if there is a semicolon, it will move left as to grab a meaningful search term.
  eol;
  left;
  left;
}

if(@current_column < 3)
{
  goto_col(3);
}

while(@is_code_indentation == 1)
{
  right;
}

// We are not at the beginning of the word, so move left to the beginning of the word.
if(@is_alphanumeric_character(@previous_character))
{
  /* 
  Sep-28-2010: I took out the period from the following line in order to support the following
  construction (from the end of the line hit Ctrl+W and notice that the whole e-mail address
  gets selected):

  */

  word_delimits = "{ (:)\\'!/[]&;\"<>=";
  word_left;
  word_delimits = Permanent_Word_Delimits;
}

@say(fp);
}



//;+ Casing



//;;

str
@ucase(str string)
{
return(caps(string));
}



//;;

str
@upper(str string)
{
return(caps(string));
}



//;;

str
@upper_case(str string)
{
return(caps(string));
}



//;;

int
@contains(str source, str sc)
{
str fp = "Does a case insensitive comparison of whether passed in string contains sc.";
// fcd: Apr-30-2014
sc = @upper(sc);
source = @upper(source);
return (xpos(sc, source, 1));
}



//;;

str
@lower(str string)
{
return(lower(string));
}



//;;

str
@lowercase(str string)
{
return(lower(string));
}



//;

int
@length(str parameter)
{
return(length(parameter));
}



//;

int
@at_bol()
{
str fp = 'At beginning of line.';
if(@current_column == 1)
{
  return(1);
}
@say(fp);
return(0);
}



//;+ Replacing



//;; On Aug-23-2012 this worked better than @replace.

str
@commute_character(str original_string, str old_character, str new_character)
{
str fp = 'You pass in the string, the character portion you wish to discard and
the new character you wish to replace it with. Then, the fixed-up string is returned to you.';

/* skw old_character, old_string, swap, in_string, replace_in_string, replace_string, 
replace_character */

int Countdown = length(original_String);
str Current_Character;
str Fixed_Up_String;

while(Countdown)
{
  Current_Character = str_char(original_String, Countdown);
  if(str_char(original_String, Countdown) == old_Character)
  {
    Current_Character = new_Character;
  }
  Fixed_Up_String = Current_Character + Fixed_Up_String;
  Countdown--;
}

return(remove_space(Fixed_Up_String));
}



//;;

str
@replace(str original_string, str old_characters, str new_characters)
{
str fp = 'Pass in a string and get back a new one with ALL occurrences of old characers 
  replaced with new ones.';

str rv = original_String;
int Position_of_Old_Characters = 0;

int Length_of_Old_Characters = @length(old_Characters);

while(xpos(old_Characters, rv, 1))
{
  Position_of_Old_Characters = xpos(old_Characters, rv, 1);
  rv = str_del(rv, Position_of_Old_Characters, Length_of_Old_Characters);
  rv = str_ins(new_Characters, rv, Position_of_Old_Characters);
}

return(rv);
}



//;;

str
@replace_once(str original_string, str old_characters, str new_characters)
{
str fp = 'Pass in a string and get back a new one with ALL occurrences of old characers 
  replaced with new ones.';

str rv = original_string;
int position_of_old_characters = 0;

int length_of_old_characters = @length(old_characters);

position_of_old_characters = xpos(old_characters, rv, 1);
rv = str_del(rv, position_of_old_characters, length_of_old_characters);
rv = str_ins(new_characters, rv, position_of_old_characters);

return(rv);
}



//;+ BOF, EOF, MOF



//;;

void
@bof()
{
str fp = 'Go to the beginning of the file.';
tof;
}



//;;

void
@tof()
{
str fp = 'Go to the beginning of the file.';
tof;
}



//;;

int
@at_bof()
{
str fp = 'At beginning of file.';
if(@current_line_number == 1)
{
  return(1);
}
return(0);
@say(fp);
}



//;;

void
@eof()
{
str fp = 'Go to the end of the file.';
eof;
}



//;;

void
@mof
{
str fp = "Go to the middle of the file";
@header;

eof;
int median_line_number = @current_line_number / 2;
goto_line(median_line_number);

@footer;
@say(fp);
}



//;

str
@first_character(str parameter)
{
return(copy(parameter, 1, 1));
}



//;

str
@first_character_in_line()
{
return(@first_character(get_line));
}



//;

void
@bol()
{
str fp = 'Go to the beginning of the line.';
goto_col(1);
}



//;

int
@current_line_contains_regex(str parameter)
{
str fp = "Current line contains the passed in string.";
// fcd: Jun-2-2014
@bol;
return (find_text(parameter, 1, _regexp));
}



//;

int
@position_of_regex(str regexParameter)
{
str fp = "Returns the position of the regex parameter on the current line.";

// fcd: Jun-6-2014

mark_pos;

@bol;

if(find_text(regexParameter, 1, _regexp))
{
  int current_column = @current_column;
  goto_mark;
  return(current_column);
}
pop_mark;
return (0);

@say(fp);
}



//;

str
@second_character(str parameter)
{
return(Copy(parameter, 2, 1));
}



//;

void
@eol()
{
str fp = 'Go to the end of the line.';
eol;
@say(fp);
}



//;

int
@file_is_read_only(str &introduction)
{
str fp = 'Verify that the user is in a file with that is not read-only.';

if(read_only)
{
  introduction += ' Error: File is read-only.';
  return(1);
}

return(0);
}



//;

int
@position_of_last_occurrence(str parameter, str character)
{
int Position_of_Last_Occurrence = 0;
int Counter = length(parameter);

while(Counter > 0)
{
  if(@get_character_at_position(parameter, counter) == character)
  {
    Position_of_Last_Occurrence = Counter;
    break;
  }
  Counter--;
}

return(Position_of_Last_Occurrence);
}



//;+ Trim Stuff



//;;

str
@trim(str string)
{
str fp = 'Trims leading and trailing spaces.';
string = @trim_leading_spaces(string);
string = @trim_trailing_spaces(string);
return(String);
}



//;;

str
@delete_nonmeaningful_term_chars(str parameter)
{
str fp = "Delete nonmeaningful terminatining characters.";

// fcd: Mar-28-2014

parameter = @trim(parameter);

parameter = @trim_after_character(parameter, " lk#");
parameter = @trim_after_character(parameter, " ^");

parameter = @trim_period(parameter);

return(parameter);
}



//;;

str
@trim_colon_et_al(str parameter)
{
str fp = 'Trim parameter INCLUDING AND after the terminating character in question.';

// Last Updated: Mar-28-2014

// Colon
int Position_of_Termination_Char = xpos(char(58), parameter, 1);
parameter = str_del(parameter, position_of_termination_char, 999);

// Open Parenthesis
int position_of_termination_char = xpos(char(40), parameter, 1);
parameter = str_del(parameter, position_of_termination_char, 999);

// Question Mark
/* I commented the question mark code out so that Google searches would use the question mark. 
Dec-30-2011 Then I uncommented this because question mark exactly search were messed up. 
Jun-29-2012 */
int position_of_termination_char = xpos(char(63), parameter, 1);
parameter = str_del(parameter, position_of_termination_char, 999);

// Double Comma
int position_of_termination_char = xpos(',,', parameter, 1);
parameter = str_del(parameter, position_of_termination_char, 999);

// Space Comma
int position_of_termination_char = xpos(' ,', parameter, 1);
parameter = str_del(parameter, position_of_termination_char, 999);

// Exclamation Point
int position_of_termination_char = xpos('!', parameter, 1);
parameter = str_del(parameter, position_of_termination_char, 999);

parameter = @delete_nonmeaningful_term_chars(parameter);

// Period. The period is no longer a subject termination character. Please
// let this bugaboo go away. Mar-26-2014
//int position_of_termination_char = xpos(char(46), parameter, 1);
//parameter = str_del(parameter, position_of_termination_char, 999);

return(parameter);
}



//;+ More Trimming



//;;

int
@colon_is_found(str string)
{
str fp = "Colon is found.";

int Position_of_Colon = xpos(char(58), string, 1);

if(Position_of_Colon == 0)
{
  fp += ' Error: No colon found in subject string.';
  string = '';
  return(false);
}

return(true);
@say(fp);
}



//;;

str
@trim_preobject_phrase(str string)
{
str fp = 'Return object portion of passed in string.';

string = @trim_leading_colons_et_al(string);

int character_counter = length(string);

int end_condition_is_satisfied = false;

if(!@colon_is_found(string))
{
  return(string);
}

str new_string = @trim_before_character(string, ":");
new_string = @trim(new_string);
return(new_string);
}



//;

void
@eos()
{
str fp = 'Start at BOL and move the cursor right until you come to the end of the spaces.';

@bol;

while(cur_char == ' ')
{
  right;
}

}



//;+ Save Location



//;;

void
@save_location()
{
// Used in conjuction with "@restore_location".
set_global_str('filename', truncate_path(file_name));
set_global_int('initial window number', @current_window_number);
set_global_int('initial row number', @current_row);
set_global_int('initial column number', @current_column);
}



//;;

void
@save_column()
{
// Used in conjuction with "@restore_column".
Set_Global_Int('initial column number 2', @current_column);
}



//;;

void
@save_highlighted_text()
{
// This method is not working properly. What it needs to do is remember the block
// start and end points not remember the string as it does now.
// Used in conjuction with "@+load_highlighted_text".

int First_Column_of_Block = 0;
int Last_Column_of_Block = 0;

if(@text_is_selected)
{
  First_Column_of_Block = block_col1;
  Last_Column_of_Block = block_col2;
}

str Highlighted_Text = str(First_Column_of_Block) + ", " + str(Last_Column_of_Block);
Set_Global_Str('highlighted_text', Highlighted_Text);
// In rcc use the load_selected text to get selected text?
//Set_Global_Str('selected_text', @get_selected_text);
}



//;;

void
@load_highlighted_text()
{
// This method is not working properly. What it needs to do is actually highlight the 
// block, not return the string.
// Used in conjuction with "@+save_highlighted_text".

str First_Part_of_String;
int First_Column_of_Block;
str Last_Part_of_String;
Int Last_Column_of_Block;

block_off;

First_Part_of_String = @trim_after_character(global_str('highlighted_text'), ",");
Last_Part_of_String = @trim_before_character(global_str('highlighted_text'), ",");

val(first_column_of_block, first_part_of_string);
@go_to_column(First_Column_of_Block);
col_block_begin;
val(Last_Column_of_Block, Last_Part_of_String);
@go_to_column(Last_Column_of_Block);
block_end; // Added Jan-5-2012.
}



//;;

void
@clear_highlighted_text()
{
// Used in conjuction with "@+save_highlighted_text".
Set_Global_Str('highlighted_text', "");
}



//;+ Load Location



//;;

int
@switch_to_named_window(str name_of_Window = parse_str('/1=', mparm_str))
{
str fp = 'Switch to named window.';

// skw: window_name, switch_to_n, switch_to_window, go_to_window, find_window

int Window_Is_Found = 0;
str Name_of_File;
int initial_window = @current_window;

do
{
  Name_of_File = Truncate_Path(File_Name);
  // Apparently, these parameters have a maxlength of 11 characters.
  if(caps(copy(Name_of_File, 1, 11)) == caps(copy(name_of_Window, 1, 11)))
  {
    // Notice that it returns "1" if the window is found, and "0" if not.
    Window_Is_Found = 1;
    @clear_markers;
    break;
  }
  rm('NextWin');
} while(cur_window != Initial_Window);
@bol;
return(Window_Is_Found);
}



//;;

void
@restore_location()
{
// Used in conjuction with "@save_location".
str fp = "Load previously saved location.";
//@next_window;

@switch_to_named_window(Global_Str('Filename'));
goto_col(global_int('initial column number'));
goto_line(global_int('initial row number'));
}



//;;

void
@recall_location()
{
@restore_location();
}



//;;

void
@restore_column()
{
// Used in conjuction with "@save_column".
str fp = "Recall initial column number.";
goto_col(Global_int('initial column number 2'));
}



//;; (skw return home, return_home)

void
@@restore_location
{
str fp = 'Restore location.';
@header;
@restore_location;
@footer;
@say(fp);
}



//;+ Cut, Copy and Paste



//;;(!cutt)

void
@cut()
{
str fp = 'Cut line or selected text to clipboard.';
rm('CutPlus /M=1');
@say(fp);
}



//;;

void
@copy()
{
str fp = 'Copy line or selected text to clipboard.';
rm('CutPlus');
@say(fp);
}



//;; (skw @copy_without)

void
@copy_with_marking_left_on()
{
str fp = "Copy line or selected text to buffer with marking left on.";

rm('CutPlus /O=0');

@say(fp);
}



//;;

void
@paste()
{
str fp = 'Paste from buffer using Windows clipboard paste.';
win3_paste;
block_off;
}



//;;

void
@paste_at_bol()
{
str fp = "Go to bol then paste.";
@header;
@save_location;
@bol; 
@paste;
@restore_location;
@footer;
@say(fp);
}



//;;

void
@super_paste()
{
str fp = 'Super paste. Context aware paste plus more.';

if(@text_is_selected)
{
  @copy;
  goto_line(block_line1);
  block_off;
  @bol;
  @paste;
  @say(fp + ' Block is selected, copy, move down 1 line, BOL, then paste.');
  return();
}
@paste_at_bol;

@say(fp);
}



//;;

void
@@super_paste
{
@header;
@super_paste;
@footer;
}



//;;

void
@@paste
{
@header;

if(@text_is_selected)
{
  delete_block;
}
@paste;
block_off;

@footer;
}



//;;

void
@paste_using_windows_clipboard()
{
str fp = 'Paste using Windows Clipboard.';

rm('Paste /WC=1');
}



//;+ Current Window



//;;

int
@current_window()
{
return(cur_Window);
}



//;;

int
@current_window_number()
{
return(cur_window);
}



//;

void
@log(str text_to_write)
{
/*
For performance reasons, I will turn off the log when I am not using it by simply commenting 
the call to @log. In this way I can preserve my crafted Log statements without suffering a 
performance hit.

*/

str fp = 'Create log.';

int Amount;
int Handle;

str Name_of_File = 'c:\a\j3.txt';

if(!file_exists(name_of_file))
{
  S_Create_File(Name_of_File, Handle);
}

s_open_file(Name_of_File, 01, Handle);

s_move_file_ptr(Handle, 2, 0);

/*
s_move_file_ptr(Han, Mode, Of(nteger function

Moves the file pointer in the file whose handle is Han by the amount Ofs. If Mode is 0, will
move from the start of the file, if 1, will move from present location, if 2, will move from
the end. Returns 0 if no error, otherwise, the Dos error code.

*/

S_Write_Bytes(LINE_TERMINATOR, Handle, Amount);
S_Write_Bytes(Text_to_Write, Handle, Amount);
S_Write_Bytes(LINE_TERMINATOR, Handle, Amount);
S_Close_File(Handle);

/* Use Case(s)
//_Log+1('this');
//_Log+1('that');
*/

}



//;+ Open Files



//;;

void
@open_file(str filename)
{
str fp = 'Open file.';

int handle;

int file_is_already_open = switch_file(Filename);

if(!file_is_already_open)
{
  if(!file_exists(filename))
  {
    fp += ' Code path 1.';
    s_create_file(filename, handle);
    s_close_file(handle);
  }
    rm('makewin /NL=1');
    return_str = filename;
    rm('ldfiles'); // Load the file.
}

fp += ' (' + filename + ')';
@say(fp);
}



//;;

int
@open_file_parameter_way()
{
str fp = 'Open file.';

str Filename[128] = parse_str("/FN=", mparm_str);

if(!switch_file(Filename))
{
  if(FILE_EXISTS(Filename))
  {
    rm('MakeWin /NL=1');
    Return_Str = filename;
    RM('LdFiles'); // Load the file.
    if(Error_Level != 0)
    {
      RM('MEERROR');
    }
    else
    {
      switch_file(Filename);
    }
  }
}

@say(fp);
}



//;;

int
@open_file_with_writability()
{
str fp = 'Open file and make it writeable.';

str Filename[128] = parse_str("/FN=", mparm_str);

fp=Filename;
if(!switch_file(Filename))
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
    else
    {
      switch_file(Filename);
    }
  }
}

read_only = false;
@say(fp);
}



//;

int
@is_number(str character)
{
//0-9, i.e. numbers
if((ascii(character)>= 48) && (ascii(character)<= 57))
{
  return(1);
}

return(0);
}



//;

str
@convert_read_key_to_ascii()
{
if(key2 == 1) // No other key pressed.
{
  switch(key1)
  {
    case 186: return(";");
             break;
    case 187: return("=");
             break;
    case 188: return(",");
             break;
    case 189: return("-");
             break;
    case 190: return(".");
             break;
    case 191: return("/");
             break;
    case 219: return("[");
             break;
    case 220: return("\\");
             break;
    case 221: return("]");
             break;
    case 222: return("'");
             break;
  }
}
else if(key2 == 3) // Shift key pressed.
{
  switch(key1)
  {
    case 48: return(")");
             break;
    case 49: return("!");
             break;
    case 50: return("@");
             break;
    case 51: return("#");
             break;
    case 52: return("$");
             break;
    case 54: return("^");
             break;
    case 56: return("*");
             break;
    case 57: return("(");
             break;
    case 186: return(":");
             break;
    case 187: return("+");
             break;
    case 188: return("<");
             break;
    case 189: return("_");
             break;
    case 191: return("?");
             break;
    case 220: return("|");
             break;
    case 222: return('"');
             break;
    default:
             return(caps(char(key1)));
  }
}
return(lower(char(key1)));
}



//;

str
@resolve_environment_variable(str command_line)
{
str fp = 'Resolve environment variable. Returns resolved string.';

int Position_of_First_Percent = xpos(char(37), command_Line, 1);

if (Position_of_First_Percent == 0)
{
  return(command_Line);
}

int Position_of_Second_Percent = xpos(char(37), command_Line,
  Position_of_First_Percent + 1);

// There is only one percent sign, so do not evaluate.
if (Position_of_Second_Percent < Position_of_First_Percent)
{
  return(command_Line);
}

str Translated_Environment_Variable;
str EV_with_Percents;
EV_with_Percents = Copy(command_Line, Position_of_First_Percent, Position_of_Second_Percent
  - Position_of_First_Percent + 1);

if (@first_3_characters(EV_with_Percents) == "%22")
{
  @say(fp + " Hooty's House Exception.");
  return(command_Line);
}

Translated_Environment_Variable = EV_with_Percents;
Translated_Environment_Variable = @trim_first_character(Translated_Environment_Variable);
Translated_Environment_Variable = @trim_last_character(Translated_Environment_Variable);
Translated_Environment_Variable = Get_Environment(Translated_Environment_Variable);

str Command_Line_Prefix = str_del(command_Line, Position_of_First_Percent, 999);
str Command_Line_Suffix = str_del(command_Line, 1, Position_of_Second_Percent);

/* Use Case(s)
%SystemRoot%\system32\calc.exe

*/

// I commented out the following line because it's overriding some of the more significant
// status messages I would rather see.
return(Command_Line_Prefix + Translated_Environment_Variable + Command_Line_Suffix);
}



//; Has a 256 character limit.

str
@concatenate_multiple_lines()
{
str fp = 'Concatenate multiple lines.';

str current_line;
str line_to_return;
mark_pos;
goto_col(1);
do
{
  current_line = get_line;
  line_to_return += current_line;
  down;
} while(remove_space(current_line) != '');
goto_mark;

return(line_to_return);

@say(fp);
}



//;

str
@escape_slashes(str rv)
{
str fp = 'Escape slashes.';
rv = @commute_character(rv, '/', '//');
return(rv);
}



//;+ EOC



//;;

void
@eoc()
{
str fp = 'Move the cursor right until you come to the end of the colons.';

@bol;

while((cur_char == ':') or (cur_char == ';') or (cur_char == '+') or (cur_char == ' '))
{
  right;
}

}



//;;

int
@get_eoc()
{
str fp = 'Get column of eoc.';
@eoc;
return(@current_column);
}



//;+ The Gets



//;; (skw Format_Date)

str
@get_formatted_date()
{
str fp = 'Get formatted date just the way I like it.';

/*
This function should support 2 input date formats, namely the default Microsoft Windows
U.S. format which is M/d/yyyy and the default PX format which is dd/MM/yyyy.
*/

int Position_of_First_Slash = xpos("/", date, 1);
int Position_of_Second_Slash = xpos("/", date, Position_of_First_Slash+1);

str Month = str_del(date, Position_of_First_Slash, 14);
str Day = str_del(date, Position_of_Second_Slash, 14);
Day = str_del(Day, 1, Position_of_First_Slash);
str Year = str_del(Date, 1, Position_of_Second_Slash);

// An alternative to doing it this way would be to run a batch file that runs a custom C#
// program that sets an environment variable to the date format that we could then read
// with the CMAC Get_Environment command.

switch(get_environment("computername"))
{
  case "JONATHAN":
  case "JONATHANS-HP":
  case "JONATHANS_HP2":
  case "TEAMWORK":
    str Month_Unchanged = Month;
    Month = Day;
    Day = Month_Unchanged;
    break;
}

// Strip leading zeros from the month field.
if(str_char(Month, 1) == '0')
{
  // Delete the first character because it is a zero.
  Month = str_del(Month, 1, 1);
}

// Strip leading zeros from the day field.
if(str_char(Day, 1) == '0')
{
  // Delete the first character because it is a zero.
  Day = str_del(Day, 1, 1);
}

/* Use Cases: Date Possibilities

Default U.S. Windows Date Format: m/d/yyyy

PX Machine (i.e. my laptop)Date Format: dd/mm/yyyy

My Preferred Savannah Format: mmm-d-yyyy, e.g. Jan-4-2008

04/01/2008
01-4-2008
123456(Position)
1/3/2005
1/13/2005
12/3/2005
12/13/2005

17-09-2007

*/

switch(Month)
{
  case "1": Month = "Jan";
    break;
  case "2": Month = "Feb";
    break;
  case "3": Month = "Mar";
    break;
  case "4": Month = "Apr";
    break;
  case "5": Month = "May";
    break;
  case "6": Month = "Jun";
    break;
  case "7": Month = "Jul";
    break;
  case "8": Month = "Aug";
    break;
  case "9": Month = "Sep";
    break;
  case "10": Month = "Oct";
    break;
  case "11": Month = "Nov";
    break;
  case "12": Month = "Dec";
    break;
}

str Fully_Constructed_Date = Month + "-" + Day + "-" + Year;

return(Fully_Constructed_Date);
}



//;;

str
@get_fixed_width_date()
{
str fp = "Get fixed width date.";

// fcd: May-3-2016

str formatted_date = @get_formatted_date();
int length_of_date = length(@get_formatted_date);
if(length_of_date == 10)
{
  formatted_date = @left(formatted_date, 4) + '0' + @right(formatted_date, 6);
}

return(formatted_date);
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



//;;

str
@get_current_line()
{
str rv = get_line;
rv = @trim_leading_colons_et_al(rv);
rv = @resolve_environment_variable(rv);
//rv = @escape_slashes(rv);
// The above line was preventing 'ie,cl' from working on Feb-25-2015. So I commented it.
set_global_str('cmac_return_value', rv);
return(rv);
}



//;;

int
@is_blank_line()
{
str fp = 'Indicates whether or not the current line is blank.';
if(length(@get_current_line) == 0)
{
  return(true);
}
return(false);
}



//;;

str
@get_date()
{
str rv = @get_formatted_date;
set_global_str('cmac_return_value', rv);
return(rv);
}



//;;

str
@get_time()
{
str fp = 'Get time.';

str formatted_time = time;

str ampm = @right(formatted_time, 2);

int length_of_formatted_time = length(formatted_time);

formatted_time = @left(formatted_time, length_of_formatted_time - 5);

formatted_time += " " + ampm;

set_global_str('cmac_return_value', formatted_time);
return(formatted_time);
}



//;;

str
@get_formatted_time()
{
str fp = "Get formatted time.";

str formatted_time = time;

if((@left(time, 2) != '10') and (@left(time, 2) != '11') and (@left(time, 2) != '12'))
{
  formatted_time = ' ' + time;
}

str ampm = @right(formatted_time, 2);

int length_of_formatted_time = length(formatted_time);

formatted_time = @left(formatted_time, length_of_formatted_time - 5);

formatted_time += " " + ampm;

return(formatted_time);
}



//;;

str
@get_fixed_width_time()
{
str fp = "Get fixed width time.";

str formatted_time = time;

if((@left(time, 2) != '10') and (@left(time, 2) != '11') and (@left(time, 2) != '12'))
{
  formatted_time = ' ' + time;
}

str ampm = @right(formatted_time, 2);

int length_of_formatted_time = length(formatted_time);

formatted_time = @left(formatted_time, length_of_formatted_time - 5);

formatted_time += " " + ampm;

if(@left(formatted_time, 2) == ' 0')
{
  formatted_time = @trim_left(formatted_time, 2);
  formatted_time = '12' + formatted_time;
}
return(formatted_time);
}



//;;

str
@get_formatted_time_with_no_pm()
{
str fp = "Get formatted time.";

str fp = "time";

str Formatted_Time = time;

str AmPm = @right(Formatted_Time, 2);

int Length_of_Formatted_Time = length(Formatted_Time);

Formatted_Time = @left(Formatted_Time, Length_of_Formatted_Time - 5);

return(formatted_time);
}



//;;

str
@get_formatted_date_as_fct_name()
{
str fp = 'Get formatted date as function name.';

str function_name = @get_formatted_date();
function_name = @commute_character(function_name, "-", "_");
function_name += "_" + @get_formatted_time();
function_name = @commute_character(function_name, ":", "_");
function_name = @commute_character(function_name, " ", "_");

return(function_name);
}



//;;

str
@get_date_with_time()
{
str rv = @get_formatted_date + ' ' + @get_time();
set_global_str('cmac_return_value', rv);
return(rv);
}



//;;

str
@get_date_and_time()
{
return(@get_date_with_time);
}



//;;

str
@get_global_search_string()
{
str rv = global_str('search_str');
set_global_str('cmac_return_value', rv);
return(rv);
}



//;;

str
@get_subject()
{
str fp = 'Get subject.';
str rv = get_line;
rv = @trim_leading_colons_et_al(rv);
rv = @trim_colon_et_al(rv); 
set_global_str('cmac_return_value', rv);
return(rv);
}



//;;

int
@get_sj_start_column(str line_parameter)
{
str fp = "Get subject start column.";

// fcd: Apr-10-2014

for (int i = 1; i < length(line_parameter); i++)
{
  switch(@get_character_at_position(line_parameter, i))
  {
    case ' ':
    case '+':
    case ':':
    case ';':
      continue;
      break;
    default:
      return(i);
  } 
}

@say(fp);
return(1);
}



//;;

int
@get_sj_end_column(str line_parameter, int start_position)
{
str fp = "Get simple subject end column.";

// fcd: Apr-10-2014

int first_terminating_character = 200;
int position_of_terminating_char = 0;

position_of_terminating_char = xpos('=', line_parameter, 3);
if(position_of_terminating_char != 0)
{
  if(position_of_terminating_char < first_terminating_character)
  {
    first_terminating_character = position_of_terminating_char - 1;
  }
}

// Jan-28-2015
position_of_terminating_char = xpos(' w,', line_parameter, 3);
if(position_of_terminating_char != 0)
{
  if(position_of_terminating_char < first_terminating_character)
  {
    first_terminating_character = position_of_terminating_char - 1;
  }
}

position_of_terminating_char = xpos(' ,', line_parameter, 3);
if(position_of_terminating_char != 0)
{
  if(position_of_terminating_char < first_terminating_character)
  {
    first_terminating_character = position_of_terminating_char - 1;
  }
}

position_of_terminating_char = xpos(':', line_parameter, 3);
if(position_of_terminating_char != 0)
{
  if(position_of_terminating_char < first_terminating_character)
  {
    first_terminating_character = position_of_terminating_char - 1;
  }
}

position_of_terminating_char = xpos('(', line_parameter, 3);
if(position_of_terminating_char != 0)
{
  if(position_of_terminating_char < first_terminating_character)
  {
    first_terminating_character = position_of_terminating_char - 1;
  }
}

position_of_terminating_char = xpos('!', line_parameter, 3);
if(position_of_terminating_char != 0)
{
  if(position_of_terminating_char < first_terminating_character)
  {
    first_terminating_character = position_of_terminating_char - 1;
  }
}

if(first_terminating_character == 200)
{
  return(@length(line_parameter) + 1);
}

return(first_terminating_character);
}



//;;

int
@get_sj_cutoff_column()
{
str fp = "Parse and Analyze SJ with the goal of finding the column where the subject ends.";

// fcd: Mar-28-2014

// Assert: This return value must be no greater than @get_sj_end_column.

int start_column = @get_sj_start_column(get_line);

int end_column = @get_sj_end_column(get_line, start_column);

str trimmed_parameter = @left(get_line, end_column);

trimmed_parameter = @delete_nonmeaningful_term_chars(trimmed_parameter);

return(length(trimmed_parameter) + 1);
}



//;; (skw get_subject_2)

str
@get_sj()
{
str fp = "Get subject 2.";
// fcd: Jan-28-2015
int eoc = @get_eoc;
return(copy(get_line, eoc, @get_sj_cutoff_column - eoc));
}



//;;

str
@get_multiline_object()
{
str fp = 'Get multiline object.';
str rv = @concatenate_multiple_lines;
rv = @trim_preobject_phrase(rv);
rv = @resolve_environment_variable(rv);
set_global_str('cmac_return_value', rv);
return(rv);
}



//;;

str
@get_oj()
{
return(@get_multiline_object);
}



//;;

str
@get_object()
{
str fp = 'Get object, that is, post colon phrase.';
str rv = get_line;
rv = @trim_preobject_phrase(rv);
set_global_str('cmac_return_value', rv);
return(rv);
}



//;; (!wost) (skw get word or block under cursor, get_word_or_block_uc)

str
@get_wost()
{

str fp = 'Get word under cursor or selected text.';

str sc;

if(@text_is_selected)
{
  // (skw show selection, block selection, getting the selected block)
  sc = copy(get_line, block_col1, block_col2 + 1 - block_col1);
}
else
{
  @position_cursor_on_a_valid_word;
  sc = get_word_in(@define_what_a_word_is);
  @say("Get word: " + char(34) + sc + char(34));
  goto_mark;
}

set_global_str('cmac_return_value', sc);
@say(fp + "(" + sc + ")");
return(sc);
}



//;;

str
@get_formatted_full_time()
{
str fp = "Get formatted time.";

str fp = "time";

str Formatted_Time = time;

str AmPm = @right(Formatted_Time, 2);

int Length_of_Formatted_Time = length(Formatted_Time);

Formatted_Time = @left(Formatted_Time, Length_of_Formatted_Time - 2);

Formatted_Time += " " + AmPm;

return(formatted_time);
}



//;+ (skw Get User Input, input_from_the_user)



//;; (skw prompt_user)

str
@get_user_input_raw(str introduction)
{
str fp = 'Get user input and display it in the status bar. Spaces allowed.';

int Countdown = 1;
introduction = @trim_last_character(introduction) + ':';

@say(introduction);
str sc;

while(Countdown <= 155)
{
  Read_Key;
  Countdown++;

  if(key1 == 27) // Escape Key
  {
    return("Function aborted.");
  }
  else if(key1 == 112) // F1 key (You accidentally hit it again.)
  {
    Countdown--;
  }
  else if(key1 == 113) // F2 key. I changed my mind in the middle of the command, so sue me.
  {
    return("Function aborted.");
  }
  else if((key1 == 8) && (key2 == 1)) // Backspace Key
  {
    sc = str_del(sc, length(sc), 1);
    Countdown--;
    Countdown--;
  }
  else if(key1 == 38) // Arrow Up Key
  {
    // Works similar to hitting the arrow up key on the command line. Aug-21-2015
    sc += Global_Str('SEARCH_STR');
  }
  else if(key1 == 40) // Arrow Down Key
  {
    return("Function aborted.");
  }
  else if((key1 == 90) && (key2 == 5)) // Control + "Z", the undo command (CTRL+Z)
  {
    return("Function aborted.");
  }
  else if((key1 == 8) && (key2 == 5)) // Control + Backspace, delete word backwards.
  {
    // Reset the whole operation.
    sc = '';
    Countdown = 0;
  }
  else if((key2 == 5) && (key1 == 86)) // ctrl+v
  {
    //sc += 'test Jan-1-2019';
    sc += global_str('search_str');
  }
  else if((key2 == 9) && (key1 == 86)) // alt+v, alternative paste command
  {
    // This is a hack.
    cr;
    cr;
    up;
    @paste;
    sc += get_line;
    undo;
    undo;
    undo;
    undo;
  }
  else if(key1 == 13) // the enter key
  {
    @say('Begin search.');
    break;
  }
  else // Normal Alphabetic keys, presumably.
  {
    sc += @convert_read_key_to_ascii;
  }

  @say(Introduction + " " + sc);
}

return(sc);
}



//;;

str
@get_user_input_nonspace(str introduction)
{
str fp = 'Get user input. Separator spaces are not allowed and launch codes are separated by a 
  comma.';

fp = 'Type verb and noun launch codes separated by a comma. No spaces allowed.';

int Countdown = 1;
str rv;

introduction = @trim_last_character(introduction) + ':';

@say(introduction);

while(Countdown <= 155)
{
  Read_Key;
  Countdown++;

  if(key1 == 27) // Escape Key
  {
    return(@constant_function_aborted);
    break;
  }
  else if(key1 == 112) // F1 key (You accidentally hit it again.)
  {
    // Just start over.
    Countdown = 1;
    rv = "";
  }
  else if(key1 == 113) // F2 key. I changed my mind in the middle of the command, so sue me.
  {
    return("Function aborted.");
  }
  else if((key1 == 8) && (key2 == 1)) // Backspace Key
  {
    rv = str_del(rv, length(rv), 1);
    Countdown--;
    Countdown--;
  }
  else if((key1 == 13) && (countdown == 2)) // semicolon then enter "trick" (!2msetr)
  {
    return(';');
  }
  else if((key1 == 32) && (countdown == 2)) // space bar "trick"
  {
    // (!sptr) (skw space bar trick)
    return('rfcwl');
  }
  // If you make a mistake and want to start over, hit the F1 key.
  else if (key1 == 186) // You hit the ";" key again, so reset the string.
  {
    if(Countdown == 2)
    {
      // (skw semicolon trick)
      return('rfcwl');
    }
    else
    {
      return(rv);
    }
    // Start over. deprecated
    //    Countdown = 1;
    //    rv = "";
  }
  else if(key1 == 38) // up arrow key
  {
    return(global_str('status_bar_text'));
  }
  else if(key1 == 40) // down arrow key
  {
    return("Function aborted.");
  }
  else if((key1 == 90) && (key2 == 5)) // Control + "Z", the undo command (CTRL+Z)
  {
    return("Function aborted.");
  }
  else if((key1 == 8) && (key2 == 5)) // Control + Backspace, delete word backwards.
  {
    // Reset the whole operation.
    rv = '';
    Countdown = 0;
  }
  else if((key2 == 5) && (key1 == 86)) // ctrl+v
  {
    rv += global_str('search_str');
  }
  else if((key2 == 9) && (key1 == 86)) // alt+v, alternative paste command
  {
    // This is a hack.
    cr;
    cr;
    up;
    @paste;
    rv += get_line;
    undo;
    undo;
    undo;
    undo;
  }
  else if(key1 == 13) // enter key
  {
    break;
  }
  else if(key1 == 32) // space bar
  {
    break;
  }
  else // Normal Alphabetic keys, presumably.
  {
    rv += @convert_read_key_to_ascii;
  }
  @say(Introduction + " " + rv);
}
return(rv);
}



//;

str
@equate_spaces_and_dashes(str sc)
{
int length_of_sc = length(sc);
int number_of_dashes = 1;
int position_counter = 1;

str accommodate_special_chars;
str current_character;

if(xpos(")", sc, 1) > 0)
{
  // This prevents recursive string manipulation.
  return(sc);
}

while(position_counter <= length_of_sc)
{
  current_character = str_char(sc, position_counter);
  if(current_character == ' ' or (current_character == '-') and (number_of_dashes <= 2))
  {
    if((current_character == ' ') and (position_counter == length_of_sc))
    {
      // user is intentionally searching with a blank at the end of the string, so leave them
      // alone.
      accommodate_special_chars += '( )';
      break;
    }
    accommodate_special_chars += '()||( )||(-)';
    number_of_dashes++;
  }
  else
  {
    accommodate_special_chars += current_character;
  }
  position_counter += 1;
}
return(accommodate_special_chars);
}



//;

str
@equate_spaces_and_dashes_wcl(str sc)
{
str fp = 'Decorate the string with special character with cross-line searching support.';

int length_of_sc = length(sc);
int number_of_dashes = 1;
int position_counter = 1;

str accommodate_special_chars;
str current_character;

if(xpos(')', sc, 1) > 0)
{
  // This prevents recursive string maniputlation.
  return(sc);
}

while(position_counter <= length_of_sc)
{
  current_character = str_char(sc, position_counter);
  if(current_character == ' ' or (current_character == '-') and (number_of_dashes <= 4))
  {
    if((current_character == ' ') and (position_counter == length_of_sc))
    {
      // user is intentionally searching with a blank at the end of the string, so leave them
      // alone.
      accommodate_special_chars += '( )';
      break;
    }
    if((current_character == '-') and (position_counter == length_of_sc))
    {
      // User is intentionally searching with a dash at the end of the string, so leave them
      // alone.
      accommodate_special_chars += '(-)';
      break;
    }
    // The following line was modified on Jun-15-2010 to support the replacement of 
    // space_bracket and bracket_space issues.
    accommodate_special_chars += '()||([\ \-])||($)||([\ \-]$)';
    number_of_dashes++;
  }
  else
  {
    accommodate_special_chars += current_character;
  }
  position_counter += 1;
}
return(accommodate_special_chars);
}



//; (!2mum4)

str
@equate_spaces_and_underscores(str space_filled_string)
{
str fp = "Replace spaces with dashes.";

// fcd: Jan-13-2016

str underscore_filled_string = "";
int position_counter = 1;
int length_of_sc = length(space_filled_string);
str current_character;

while(position_counter <= length_of_sc)
{
  current_character = str_char(space_filled_string, position_counter);
  if(current_character == ' ')
  {
    underscore_filled_string += '()||( )||(_)';
  }
  else
  {
    underscore_filled_string += current_character;
  }
  position_counter++;
}
return(underscore_filled_string);
}



//;

void
@add_text_date
{
str fp = 'Add text date.';

if(@text_is_selected)
{
  delete_block;
}

//if(@previous_character != ' ')
if((@previous_character != ' ') and (@previous_character != ':') and (@previous_character != ';'))
{
  text(' ');
}
text(@get_formatted_date);
@say(fp);
}



//; (prettify skw)

str
@distill_lc(str lc)
{
str fp = 'Distill launch code to the minimum by removing all regex characters.';

lc = @trim_after_character(lc, ",");

if(@first_character(lc) == '(')
{
  lc = @trim_first_character(lc);
}

if(@first_character(lc) == '!')
{
  lc = @trim_first_character(lc);
}

if(@last_character(lc) == ')')
{
  lc = @trim_last_character(lc);
}

// I commented the following line on Mar-10-2010 because it was annoying me when 
// I hit the escape button.
return(lc);
}



//;

void
@my_customized_backspace
{
str fp = 'My customized backspace.';
rm('bskey');
@say(fp);
}



//;

void
@cursor_pagedown_with_center
{
str fp = 'Pagedown with center.';
@header;

page_down;

@footer;
@say(fp);
}



//;

void
@cursor_pageup_with_center
{
str fp = 'Pageup with center.';
@header;

page_up;

@footer;
@say(fp);
}



//;

void
@cursor_to_my_eof
{
str fp = 'Go to the end of the file.';
int current_Column_Number = @current_Column_Number;
@header;

eof;
@bol;

goto_col(current_Column_Number);
@footer;
@say(fp);
}



//;+ Copy and Paste Line



//;;

void
@copy_and_paste_line()
{
str fp = 'Copy and paste line.';
@copy;
@bol;
@paste;
@say(fp);
}



//;;

void
@@copy_and_paste_line
{
@header;
@copy_and_paste_line;
@footer;
}



//;

void
@next_window()
{
str fp = 'Move to next window.';
rm('nextwin');
}



//;+ Previous Window



//;;

void
@previous_window()
{
str fp = 'Previous window.';

rm('lastwin');

@say(fp);
}



//;;

void
@switch_to_previous_window()
{
str fp = 'Switch to previous window.';

rm('lastwin');

@say(fp);
}



//;+ Cursor Movement



//;;

void
@cursor_down
{
str fp = 'Cursor down.';
@header;
down;
@footer;
@say(fp);
}



//;;

void
@cursor_up
{
str fp = 'Cursor up.';
@header;
up;
@footer;
@say(fp);
}



//;;

void
@cursor_up_1_line()
{
str fp = 'Cursor up one line.';
up;
if(@previous_character == ';')
{
  left;
}
@say(fp);
}



//;+ Create files.



//;;

void
@create_work_documents_file(str filename = parse_str('/1=', mparm_str))
{
str fp = 'Create new file in the work documents folder.';

str full_filename[128] = get_environment('savannah') + '\work documents\' + filename;

if(file_exists(full_filename))
{
  filename = filename + '_' + @get_formatted_date_as_fct_name;
  full_filename = get_environment('dropbox') + '\work\wk\documents\' + filename;
}

int handle;
s_create_file(full_filename, handle);
s_close_file(handle);
rm('makewin /NL=1');
if(file_exists(full_filename))
{
  return_str = full_filename;
  rm('LdFiles'); // Load the file.
  if(Error_Level != 0)
  {
    rm('meerror');
  }
}

}



//;; (skw temporary files)

void
@create_timestamped_file()
{
str fp = 'Create new txt file.';
str str_time = time;
str str_Date = Date;
str_time = str_del(str_time, xpos(":", str_time, 1), 1);
str_time = str_del(str_time, xpos(":", str_time, 1), 1);
str_date = str_del(str_date, xpos("/", str_date, 1), 1);
str_date = str_del(str_date, xpos("/", str_date, 1), 1);

str filename[128] = get_environment('temp') + '\JRJ_' + str_Date + '_' + str_Time + '.txt';

int handle;
s_create_file(filename, handle);
s_close_file(handle);

rm('makewin /NL=1');
if(file_exists(filename))
{
  return_str = filename;
  rm('LdFiles'); // Load the file.
  if(Error_Level != 0)
  {
    rm('meerror');
  }
}

}



//;;

void
@create_timestamped_file_in_work()
{
str fp = 'Create timestamped file in work folder.';
str str_time = time;
str str_Date = Date;
str_time = str_del(str_time, xpos(":", str_time, 1), 1);
str_time = str_del(str_time, xpos(":", str_time, 1), 1);
str_date = str_del(str_date, xpos("/", str_date, 1), 1);
str_date = str_del(str_date, xpos("/", str_date, 1), 1);

str filename[128] = 'C:\Users\jonathan.r.jones\Documents\Dropbox\NES\Documents' + '\JRJ_' + str_Date + '_' + str_Time + '.txt';

//Last Updated: Sep-22-2016

int handle;
s_create_file(filename, handle);
s_close_file(handle);

rm('makewin /NL=1');
if(file_exists(filename))
{
  return_str = filename;
  rm('LdFiles'); // Load the file.
  if(Error_Level != 0)
  {
    rm('meerror');
  }
}

}



//;;

void
@create_new_file
{
str fp = 'Create new txt file.';
str str_Time = Time;
str str_Date = Date;
str_Time = str_del(str_Time, xpos(":", str_Time, 1), 1);
str_Time = str_del(str_Time, xpos(":", str_Time, 1), 1);
str_Date = str_del(str_Date, xpos("/", str_Date, 1), 1);
str_Date = str_del(str_Date, xpos("/", str_Date, 1), 1);

str filename[128] = 'c:\a' + '\JRJ_' + str_Date + '_' + str_Time + '.txt';

int handle;
s_create_file(filename, handle);
s_close_file(handle);

rm('makewin /NL=1');
if(file_exists(filename))
{
  return_str = filename;
  rm('LdFiles'); // Load the file.
  if(Error_Level != 0)
  {
    rm('meerror');
  }
}

}



//;;

void
@create_reusable_temporary_file()
{
str fp = 'Create new temporary file.';
str filename[128] = 'c:\a\JRJ_Temporary_File' + '.txt';
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
str filename2 = 'JRJ_Temporary_File.txt';
@switch_to_named_window(filename2);
tof;
}



//;; (skw no_right_margin, gmail)

void
@create_new_long_line_file()
{
str fp = "Create new long line file.";
str str_Time = Time;
str str_Date = Date;
str_Time = str_del(str_Time, xpos(":", str_Time, 1), 1);
str_Time = str_del(str_Time, xpos(":", str_Time, 1), 1);
str_Date = str_del(str_Date, xpos("/", str_Date, 1), 1);
str_Date = str_del(str_Date, xpos("/", str_Date, 1), 1);

str filename[128] = Get_Environment('temp') + '\JRJ_' + str_Date + '_' + str_Time + '.llf';
int Handle;
S_Create_File(filename, Handle);
S_Close_File(Handle);

rm('MakeWin /NL=1');
if(FILE_EXISTS(filename))
{
  Return_Str = filename;
  RM('LdFiles'); // Load the file.
  if(Error_Level != 0)
  {
    RM('MEERROR');
  }
}

}



//;;

void
@create_new_no_word_wrap_file
{
str fp = "Create new no word wrap file.";
str str_Time = Time;
str str_Date = Date;
str_Time = str_del(str_Time, xpos(":", str_Time, 1), 1);
str_Time = str_del(str_Time, xpos(":", str_Time, 1), 1);
str_Date = str_del(str_Date, xpos("/", str_Date, 1), 1);
str_Date = str_del(str_Date, xpos("/", str_Date, 1), 1);

str filename[128] = Get_Environment('temp') + '\JRJ_' + str_Date + '_' + str_Time + '.nww';
int Handle;
S_Create_File(filename, Handle);
S_Close_File(Handle);

rm('MakeWin /NL=1');
if(FILE_EXISTS(filename))
{
  Return_Str = filename;
  RM('LdFiles'); // Load the file.
  if(Error_Level != 0)
  {
    RM('MEERROR');
  }
}

}



//;

void
@highlight_current_line()
{
str fp = 'Highlight current line.';
eol;
block_begin;
@bol;
block_end;
@say(fp);
}



//;

void
@show_key_assignment()
{
@header;
str fp = 'Find key assignment.';
@say(fp);
rm('@find_key_assignment /T=1');
@footer;
}



//;

void
@increment_lookup_counter
{
str fp = 'Increment lookup counter.';

@header;

str Found_String;

int Number_to_Increment;

mark_pos;

@bol;

if(!(find_text('lk\#[0-9][0-9]*', 1, _regexp)))
{
  @eoc;
  if(find_text(':', 1, _regexp))
  {
    right;
    right;
    text('lk#2');
    if(!at_eol)
    {
      text(' ');
    }
  }
  else if(find_text('\?', 1, _regexp))
  {
    right;
    right;
    text('lk#2');
    if(!at_eol)
    {
      text(' ');
    }
  }
  else if(find_text('\!', 1, _regexp))
  {
    right;
    right;
    text('lk#2');
    if(!at_eol)
    {
      text(' ');
    }
  }
  else
  {
    eol;
    if(@previous_character != '.')
    {
      text(':');
    }
    text(' lk#2');
  }
}
else
{
  Found_String = Found_Str;
  val(Number_to_Increment, Str_Del(Found_String, 1, 3)); // Chops off "lk#".
  Number_to_Increment++;
  replace("lk#" + str(Number_to_Increment));
}
rm('reformat');
goto_mark;

@footer;
@say(fp);
}



//;+ Delete Backwords



//;;

void
@delete_word_backwards()
{
str fp = 'Delete word backwards. ';
int Counter = 0;
int Current_Column = @current_column;
int Number_of_Spaces_Deleted = 0;

if(@current_column != 1)
{
  while(Counter < 2)
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
        back_space;
    }
    Counter++;
  }
}

rm('BsWord');

Number_of_Spaces_Deleted = Current_Column - @current_column;

// If Number_of_Spaces_Deleted is less than 0, that means we've crossed lines, in which
// case this block will do nothing.
if((Number_of_Spaces_Deleted > 0) and (Number_of_Spaces_Deleted < 3))
{
  switch(@previous_character)
  {
    case "'":
      Back_Space;
      rm('BsWord');
      break;
  }
}

/* Use Case(s)

hey now "shut up"

*/

@say(fp);
}



//;;

void
@delete_word_backwards_xstrength()
{
str fp = 'Deletes word backwards and helps in those situation with the "lk".';
Back_Space;
while(@previous_character != ':')
{
  Back_Space;
}
rm('BsWord');

/* Use case(s)

hey-now: lk#2 hey/now hey/now

*/
}



//;;

void
@delete_word_conservatively()
{
str fp = 'Delete word conservatively.';

int Cursor_is_at_EOL = false;

if(at_eol)
{
  Cursor_is_at_EOL = true;
}
else
{
  del_char;
}

str_block_begin;
str Permanent_Word_Delimits = word_delimits;

word_delimits = "/ (:)\\'!.,<>";

word_delimits += char(34);  // Double quote character.

get_word(word_delimits);

// Deals with contractions.
if(@current_character == "'")
{
  switch(@next_character)
  {
    case 't':
    case 's':
      right;
      right;
      break;
    default:
  }
}

block_end;
delete_block;

while(@current_character == ' ')
{
  del_char;
}

if(at_eol and Cursor_is_at_EOL)
{
  del_char;
}

word_delimits = Permanent_Word_Delimits;

/* Use Case(s)

- Use Case Oct-20-2009: Don't delete whole dates like below.
- 10/22/2006

- Use Case Apr-23-2009: Make control + delete work across lines.

- Use Case Apr-14-2009: Why does nothing get deleted in the following string?
'@;@'

- Use Case Apr-10-2009: Given "A journey", only "a " should be deleted.
journey

- Use Case Mar-18-2009: Delete double colons.
- hey now

- Use Case Mar-18-2009: Apostrophe "s".
It's not so bad if you can get past the [blank].

- Use Case Mar-18-2009: Period at bol.
.Net Reflector

- Use Case Mar-17-2009: Delete the quote character and 't' in contractions.
haven't heard

- Use Case Jan-7-2009: Don't delete trailing periods.
Hi there.

- Use Case: If the cursor resides on the test, it should only the whole word "test", but not
the second double quote mark.
"test"

- Use case: It should delete test, but not the remaining 3 characters.
test.';

- Use case: Don't leave the cursor on a space. Sep-11-2008

blah blah

- Use Case: If the cursor starts on a space, this macro should delete that space.

- Use Case: Don't delete text after and including double quotes.
buddy" now go

1. If the cursor rests directly after the "n" in "PLug-in" this macro should delete up to the
first non-alphanumeric character, in this case the closing double quote mark.

for example[object].Text = gs.GetResourceString("An_Plugin__Expand") where gs

*/

@say(fp);
}



//;+ Home Key



//;;

void
@home_key
{
str fp = "Home key.";

if(@is_bullet_file)
{
  @eoc;
}
else
{
  goto_col(1);
}

@say(fp);
}



//;;

void
@home
{
str fp = "Home key.";

goto_col(1);

@say(fp);
}



//;

int
@window_count()
{
str fp = "My window counting function.";

/* The following code block doesn't which is why I had to roll my own window counting 
function.

int Window_Counter = 0;
while(Window_Counter < Window_Count)
{
  @next_window;
  Window_Counter++;
}
*/

int window_counter = 0;
int initial_window = cur_window;

do
{
  Window_Counter++;
  @next_window;
} while(cur_window != Initial_Window);

return(window_counter);
}



//;+ Close Window



//;;

void
@close_window()
{
str fp = "Close window.";
delete_window;
}



//;;

void
@close_file()
{
str fp = "Close file.";
delete_window;
}



//;;

void
@close_and_save_file_wo_prompt()
{
str fp = "Close and save the file without prompting the user.";
if(file_changed)
{
  save_file;
}
delete_window;
@say(fp);
}



//;;

void
@@close_and_save_file_wo_prompt
{
@header;
@close_and_save_file_wo_prompt;
@footer;
}



//;;

int
@i_am_on_my_home_computer()
{
str fp = "I am at my home computer.";

switch(@lower(Get_Environment("ComputerName")))
{
  case "vaio":
    return(1);
    @say(fp);
    break;
}

@say("I am NOT at my home computer.");
return(0);
}



//;

str
@strip_off_filename(str full_Path)
{
str fp = "Strip off filename.";
str rv = 'Returns path only, i.e. without filename.';

str path_only;

if(xpos('.', full_Path, 1) == 0)
{
  @say(fp + ' Period NOT found.');
  return(full_path);
}

// Now we need to strip out the full_Path.
int column_Number = length(full_Path);

while(column_Number)
{
  if(str_char(full_Path, column_Number) == '\')
  {
    path_only = str_del(full_Path, column_Number, length(full_Path));
    break;
  }
  Column_Number--;
}

return(path_only);
}



//;+ Run Application



//;;

void
@run_application_3p(str application, str parameter, int is_windows_explorer)
{
str fp = "Run application, 3 parameter version.";

if(!is_windows_explorer)
{
  application = char(34) + application + char(34);
  if(@length(parameter) > 0)
  {
    parameter = char(34) + parameter + char(34);
  }
}

ExecProg(application + char(32) + parameter,
  Get_Environment("temp"),
  Get_Environment("TEMP") + '\\multi-edit output.txt',
  Get_Environment("TEMP") + '\\multi-edit error.txt',
  _ep_flags_dontwait | _ep_flags_exewin);

}



//;;

void
@run_application_3p_tn
{
str fp = "";

// fcd: May-12-2015

str application = get_environment("windir") +  "\\explorer.exe /n, /e, ";

//str path = '\\fuji\shared\usr\jrj\';
str path = '\\fuji\shared';

@run_application_3p(application, path, true);

@say(fp);
}



//;;

void
@run_application_2p(str application, str parameter)
{
str fp = "Run application, 2 parameter version.";
@run_application_3p(application, parameter, false);
//@say(fp);
}



//;;

void
@run_application_1p(str sc = parse_str('/1=', mparm_str))
{
str fp = "Run application, 1 parameter version.";
@run_application_3p(sc, "", false);
fp += ' (' + sc + ')';
set_global_str('inner_status_message', fp);
}



//;;

void
@test_harness_for_run_applicat
{
str fp = "Test harness for run application.";

str application;
str parameter;

application = get_environment("windir") +  "\\explorer.exe /n, /e, ";

//application = "c:\\program files (x86)\\microsoft office\\office12\\winword.exe";

//parameter = "c:\\!";
//parameter = "c:\\!\\a.docx";
parameter = "C:\\Documents and Settings\\jrj\\My Documents";

//@run_application_1p(application);
//@run_application_2p(application, parameter);
@run_application_3p(application, parameter, 1);

@say(application);
}



//;

str
@get_chrome_path()
{
str fp = "Get chrome path.";

// fcd: Jun-13-2014

str return_string = "C:\\Program Files (x86)\\Google\\Chrome\\Application\\chrome.exe";

switch(@lower(Get_Environment("ComputerName")))
{
  case "w8":
    return_string = 
      "C:\\Users\\Jonathan\\AppData\\Local\\Google\\Chrome\\Application\\chrome.exe";
  break;
}

return(return_string);

@say(fp);
}



//;

str
@get_path_opera()
{
str fp = "Get file path for opera executable.";

// lu: Nov-5-2018

str possible_file_path = "";

// Program files path.
possible_file_path = "c:\\program files\\opera\\launcher.exe";
if(file_exists(possible_file_path))
{
  fp += ' Program files file exists.';
  return(possible_file_path);
}

// Program files (x86) path.
possible_file_path = "c:\\program files (x86)\\opera\\launcher.exe";
if(file_exists(possible_file_path))
{
  fp += ' Program files (x86) file exists.';
  return(possible_file_path);
}

fp += ' Path NOT found.';
return("");

@say(fp);
}



//; (!surf)

void
@surf(str url = parse_str('/1=', mparm_str), int browser_number = parse_int('/2=', mparm_str)) 
{

str Command_Line = '';

/* Use Case(s)

- Browser Audition

- Answers reverse copy

- Multiple windows, not multiple tabs

- Speed

- download Opera

- Safari Download

- Internet Explorer Download
- Chrome Download

- join forces

- under what conditions

*/

// Assign the default browser here. (!sebr, !bro, !brows, !debr, !defa)
int default_browser = 1;

if(browser_number == 0)
{
  browser_number = default_browser;
}

switch(browser_number) // This list is ordered by how much i like them.
{
  case 1: // Chrome (Opens in a new tab.)
    command_line = @get_chrome_path;
    break;
  case 2: // Firefox (Opens in a new window.)
    Command_Line = "C:\\Program Files\\Mozilla Firefox\\firefox.exe";
    break;
  case 3: // Internet Explorer (Opens in a new window.)
    Command_Line = Get_Environment("ProgramFiles") + "\\Internet Explorer\\IEXPLORE.EXE";
    break;
  case 4: // Opera (Opens in a new tab.)
    command_line = @get_path_opera;
    break;
  case 5: // Safari
    Command_Line = Get_Environment("ProgramFiles") + "\\Safari\\Safari.exe";
    break;
  case 6: // Vivaldi
    Command_Line = Get_Environment("LOCALAPPDATA") + "\\Vivaldi\\Application\\vivaldi.exe";
    break;
}

/* Use Case(s)

http://www.cnn.com

*/

ExecProg(char(34) + Command_Line + char(34) + " " + char(34) + URL + char(34),
  Get_Environment("TEMP"),
  Get_Environment("TEMP") + '\\multi-edit output.txt',
  Get_Environment("TEMP") + '\\multi-edit error.txt',
  _EP_Flags_NoBypass | _EP_Flags_DontWait);

}



//; (skw first_col, block_begin, get_sel, get_high, get_block)

str
@get_selected_text()
{
str fp = "Get selected text.";
// Note: This only works on a single line of highlighted text.

str rv;

if(!@text_is_selected)
{
  @say(fp += " No text is selected.");
  rv = '';
  set_global_str('cmac_return_value', rv);
  return(rv);
}

str rv = get_line;
int block_Difference = block_col2 - block_col1 + 1;
rv = Copy(rv, block_col1, block_Difference);

set_global_str('cmac_return_value', rv);
set_global_str('inner_status_message', rv);

// This line is causing a crash. Nov-1-2013
//@set_clipboard(rv);

return(rv);
}



//;+ Get Stuff



//;;

str
@get_precomma_string(str string, str &em_rp)
{
str fp = 'Get precomma string.';

str rv = @trim_leading_colons_et_al(string);

int Position_of_Comma = xpos(char(44), rv, 1);

if(Position_of_Comma == 0)
{
  em_rp = 'Error: No comma found in precomma string.';
  rv = '';
  return(rv);
}

str new_String;
int loop_Counter = 1;
int length_of_String = length(rv);

while(loop_Counter < length_of_String)
{
  if(str_char(string, loop_Counter) != ",")
  {
    new_String += str_char(rv, loop_Counter);
  }
  else
  {
    break;
  }
  loop_Counter ++;
}

if(new_String == '')
{
  em_rp = 'Error: Verb is missing.';
  rv = '';
  return(rv);
}

rv = new_String;

return(rv);
}



//;;

str
@get_postcomma_string(str string, str &em_rp)
{
str fp = 'Get post comma string.';

str rv = @trim_leading_colons_et_al(string);

int Position_of_Comma = xpos(char(44), string, 1);

if(Position_of_Comma == 0)
{
  em_rp = 'Error: No comma found in postcomma string.';
  rv = '';
  return(rv);
}

str new_String;

int loop_Counter = Position_of_Comma + 1;
int length_of_String = length(rv);

while(loop_Counter <= length_of_String)
{
  new_String += str_char(rv, loop_Counter);
  loop_Counter ++;
}

if(new_String == '')
{
  em_rp = 'Error: Noun is missing.';
  rv = '';
  return(rv);
}

rv = new_String;

return(rv);
}



//;; Work in progress.

str
@get_second_parameter_of_csv(str csv_String, str &em_rp)
{
str fp = 'Get second parameter of a comma separated list passed in.';

str rv = @trim_leading_colons_et_al(csv_String);

int Position_of_Comma_1 = xpos(char(44), csv_String, 1);

if(Position_of_Comma_1 == 0)
{
  em_rp = fp + ' Error: No comma found in string.';
  rv = '';
  return(rv);
}

str new_String;

int loop_Counter = Position_of_Comma_1 + 1;

int Position_of_Comma_2 = xpos(char(44), csv_String, 1);

int length_of_String = length(rv);

if(new_String == '')
{
  em_rp = 'Error: Noun is missing.';
  rv = '';
  return(rv);
}

rv = new_String;

return(rv);
}



//;;

void
@get_second_parameter_of_csv_tm
{

str fp = "brown chicken";

str em_rp = '';

str parameter_2 = @get_second_parameter_of_csv(fp, em_rp);

}



//;;

str
@hc_line()
{
str fp = "Copy line with marking left on.";
str rv = 'Returns current line.';

goto_col(1);
str_block_begin;
@eol;
block_end;
@copy_with_marking_left_on;

@say(fp);
rv = @get_selected_text;
return(rv);
}



//;;

void
@set_clipboard(str text_to_set = parse_str('/1=', mparm_str))
{
str fp = "Set clipboard text.";

@create_timestamped_file;

text(text_to_set);

@hc_line;

@close_and_save_file_wo_prompt;

set_global_str('cmac_return_value', text_To_Set);

fp += ' (' + text_To_Set + ')';

set_global_str('inner_status_message', fp);

@say(fp);
}



//;;

str
@get_uc()
{
str fp = 'Get word under the cursor.';

str sc;

@position_cursor_on_a_valid_word;
sc = get_word_in(@define_what_a_word_is);
@say("Get word: " + char(34) + sc + char(34));

set_global_str('cmac_return_value', sc);
// I commented the following line because it was causing an issue. Mar-10-2016
//@set_clipboard(sc);
@say(fp + "(" + sc + ")");
return(sc);
}



//;+ Parse Arguments Family



//;;

void
@parse_arguments(str arguments, str separating_character, str &argument_1, str &argument_2)
{
str fp = "Parse arguments.";

// (skw parm_1, parameter_1, parse parameters, parameter parsing)

// fcd: Aug-3-2015

// parse_parameters: skw

argument_1 = @trim_after_character(arguments, separating_character);
argument_2 = @trim_before_character(arguments, separating_character);

if(!@contains(arguments, separating_character))
{
  argument_2 = '';
}

@say(fp);
}



//;;

void
@parse_arguments_4_parameters(str arguments, str separating_character, 
  str &arg_1, str &arg_2,
  str &arg_3, str &arg_4)
{
str fp = "Parse arguments.";

// (skw parm_1, parameter_1, parse parameters, parameter parsing)

// fcd: Aug-3-2015

arg_1 = @trim_after_character(arguments, separating_character);
arg_2 = @trim_before_character(arguments, separating_character);

if(!@contains(arguments, separating_character))
{
  arg_2 = '';
}

if(@contains(arg_2, '.'))
{
  arguments = arg_2;
  @parse_arguments(arguments, ".", arg_2, arg_3);
  @say('arg 2: ' + arg_2 + ', arg 3: ' + arg_3);
  //  return();
}

if(@contains(arg_3, '.'))
{
  arguments = arg_3;
  @parse_arguments(arguments, ".", arg_3, arg_4);
  @say('contains');
  @say('arg 3: ' + arg_3 + ', arg 4: ' + arg_4);
  //  return();
}

@say(fp);
}



//;;

void
@parse_arguments_th()
{
str fp = "Parse arguments test harness.";

// fcd: Aug-3-2015
str arguments = 'hello';
arguments = 'hello,world';
arguments = 'test';
arguments = 'test.';
arguments = 'test.tube.baby';
arguments = 'test.tube';
arguments = 'test.tube.baby.wow!';

str argument_1, argument_2, argument_3, argument_4;

@parse_arguments(arguments, ".", argument_1, argument_2);

if(@contains(argument_2, '.'))
{
  arguments = argument_2;
  @parse_arguments(arguments, ".", argument_2, argument_3);
  @say('contains');
  @say('arg 2: ' + argument_2 + ', arg 3: ' + argument_3);
//  return();
}

if(@contains(argument_3, '.'))
{
  arguments = argument_3;
  @parse_arguments(arguments, ".", argument_3, argument_4);
  @say('contains');
  @say('arg 3: ' + argument_3 + ', arg 4: ' + argument_4);
//  return();
}

@say(fp);
@say('a1: ' + argument_1 + ', a2: ' + argument_2 + ', a3: ' + argument_3 + ', a4: ' + argument_4);
}



//;

str
@constant_not_a_bullet()
{
// fcd: Jan-25-2017
return('This macro only works on bullets.');
}



//;

str
@constant_lc_not_found()
{
// fcd: Jan-25-2017
return('LC NOT found.');
}



//;

void
@escape()
{
str fp = 'You pressed the escape key.';
block_off;
fp = @trim_period(fp);
fp += ' at ' + @get_formatted_full_time + '.';
@say(fp);
}



//;

str
@initial_window_and_line_number
{
str fp = "Initial window and line number.";

// fcd: "Feb-18-2017

int initial_window_number = @current_window_number;
int initial_row_number = @current_row_number;
str return_value = str(initial_window_number) + '-' + str(@current_row_number);
@say(fp + ' (' + return_value + ')');
return(return_value);
}



//;

int
@int(str conversion_candidate = parse_str('/1=', mparm_str))
{
str fp = "Convert string to integer type variable.";

// fcd: Jun-19-2017

// skw: convert to integer

int destination_integer;
int first_digit;

if (val(destination_integer, conversion_candidate) == 0)
{
  first_digit = destination_integer;
}

return(first_digit);
}



//;

str
@get_date_smas_format()
{
str fp = 'Get formatted date for the SMAS website.';

int Position_of_First_Slash = xpos("/", date, 1);
int Position_of_Second_Slash = xpos("/", date, Position_of_First_Slash+1);

str Month = str_del(date, Position_of_First_Slash, 14);
str Day = str_del(date, Position_of_Second_Slash, 14);
Day = str_del(Day, 1, Position_of_First_Slash);
str Year = str_del(Date, 1, Position_of_Second_Slash);

// An alternative to doing it this way would be to run a batch file that runs a custom C#
// program that sets an environment variable to the date format that we could then read
// with the CMAC Get_Environment command.

// Strip leading zeros from the month field.
if(str_char(Month, 1) == '0')
{
  // Delete the first character because it is a zero.
  Month = str_del(Month, 1, 1);
}

// Strip leading zeros from the day field.
if(str_char(Day, 1) == '0')
{
  // Delete the first character because it is a zero.
  Day = str_del(Day, 1, 1);
}

str fully_constructed_date;
str fully_constructed_display_date;

int one_week_later_day = @int(day) + 7;
int one_month_later_month = @int(month) + 1;

if(one_week_later_day > 28)
{
  one_week_later_day = 3;
  fully_constructed_date = str(one_month_later_month) + "/" + str(one_week_later_day) + "/" + year;
}
else
{
  fully_constructed_date = month + "/" + str(one_week_later_day) + "/" + year;
  fully_constructed_display_date = month + "//" + str(one_week_later_day) + "//" + year;
}

set_global_str('cmac_return_value', fully_constructed_display_date);

return(fully_constructed_date);
}



//;

void
@delete_all()
{
str fp = "Delete all file content.";

// lu: Jan-31-2019

if(!@is_text_file)
{
  return();
}

@select_all;

@delete;

@say(fp);
}



//; (!efsh)