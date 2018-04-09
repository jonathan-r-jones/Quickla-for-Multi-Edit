macro_file Aliases; // (!rfal, !al, !bfal)

// A wrapper around Multi-Edit commands.
// Contains no calls to any "@" (my macros) functions. The order of the functions in this file 
// should not matter for compilation success.



//; Macro File Glass Ceiling



//;

/*

Metadata: Track Size (!tsal)

     Date      Lines    Bytes     Macros  Notes
 -----------  ------  ---------  -------  ---------------------------------------------------

: Apr-3-2018     944     11,847       72

: Jan-3-2018     925     11,635       71

:Jun-25-2017     922     11,540       71

:Mar-31-2017     889     10,966       69

:Nov-17-2016     885     11,099       68

: Oct-7-2016     881     11,009       68

: Apr-8-2016     878     10,963       68

:Dec-31-2015     865     10,825       67

: Oct-5-2015     863     10,781       67

: Jul-1-2015     849     10,570       66

:Apr-14-2015     849     10,527       65

: Apr-1-2015     847     10,483       65

:Jan-16-2015     827     10,398       60

: Oct-1-2014     825     10,388       60

: Jul-1-2014     823     10,344       60

:Apr-10-2014     757      9,483       54

: Apr-1-2014     755      9,439       54

: Oct-1-2013     739      9,261       52

: Jul-1-2013     737      9,217       52

: Apr-1-2013     735      9,173       52

: Jan-2-2013     733      9,129       52

: Oct-1-2012     721      8,997       51

:Aug-18-2012     534      6,706       41  Split this file into 2 pieces. See shared.s.

: Jul-2-2012   3,982     61,086      179

: Apr-2-2012   3,987     60,860      178

- Jan-2-2012   4,166    63,978     186

- Dec-20-2011  3,770    57,083     176

- Oct-3-2011   3,584    54,241     168

- Aug-1-2011   3,561    53,647     167

- Jul-15-2011  3,559    53,602     167

- Jun-1-2011   3,499    52,727     164

- Apr-7-2011   3,341    50,334     158

- Feb-2-2011   3,365    50,733     156

- Jan-3-2011   2,471    38,207     120

- Jul-1-2010   2,401    37,193     115

- Jun-1-2010   2,396    37,014     115

- May-3-2010   2,391    36,858     115

- Apr-1-2010   2,278    34,935     113

- Mar-1-2010   2,265    34,760     112

- Feb-1-2010   2,239    34,396     111

- Jan-8-2010   2,227    34,483     109

*/



//;+ Filename Family



//;;

str
@filename()
{
str fp = 'Returns the lowercased filename only.';
str rv = lower(Truncate_Path(file_name));
return(rv);
}



//;;

str
@full_filename()
{
str fp = 'Returns the full filename.';
str rv = file_name;
return(rv);
}



//;;

str
@filename_extension()
{
str fp = "Get filename extension of current file.";

// file_extension, fileextension: skw
str rv = 'Return the filename extension.';
return(lower(get_extension(File_name)));
}



//;+ Trimming Family



//;; (skw @delete_leading_colons)

str
@trim_leading_colons_et_al(str string)
{
while(str_char(String, 1) == ":")
{
  String = str_del(String, 1, 1);
}
while(str_char(String, 1) == ";")
{
  String = str_del(String, 1, 1);
}
while(str_char(String, 1) == "+")
{
  String = str_del(String, 1, 1);
}
return(String);
}



//;;

str
@trim_colons(str string)
{
return(@trim_leading_colons_et_al(string));
}



//;;

str
@trim_after_character(str string, str cutoff_character)
{
str fp = 'Trim after leftmost occurrence of character.';
int Position_Of_Cutoff_Character = xpos(cutoff_Character, String, 1);
String = str_del(String, Position_Of_Cutoff_Character, 999);
return(String);
}



//;;

str
@trim_after_phrase(str whole_string, str phrase)
{
int position_of_phrase = xpos(phrase, whole_string, 1);
whole_string = str_del(whole_string, position_of_phrase + length(phrase), 999);
return(whole_string);
}



//;;

str
@trim_before_character(str string, str character)
{
int position_of_character = xpos(character, string, 1);

if(Position_of_Character == 0)
{
  return (string);
}

string = str_del(string, 1, position_of_character);
return(String);
}



//;;

str
@trim_before_phrase(str whole_string, str phrase)
{
int position_of_phrase = xpos(phrase, whole_string, 1);

if(position_of_phrase == 0)
{
  return (whole_string);
}

whole_string = str_del(whole_string, 1, position_of_phrase - 1);

return(whole_string);
}



//;;

str
@previous_character()
{
return(copy(get_line, c_col - 1, 1));
}



//;;

str
@current_character()
{
return(cur_char);
}



//;;

str
@get_character_at_position(str string_to_analyze, int position)
{
return(copy(string_to_analyze, position, 1));
}



//;;

str
@trim_after_first_sentence(str string)
{
int Position_of_Character = xpos(".", String, 1);
String = str_del(String, Position_of_Character + 1, 999);
return(String);
}



//;;

str
@trim_string_after_open_paren(str string)
{
int Position_Of_Colon = xpos(char(40), String, 1);
String = str_del(String, Position_Of_Colon, 999);
return(String);
}



//;; (skw delete_period, remove_period)

str
@trim_period(str string)
{
// Trim the period, if present.
if(str_char(string, length(string)) == '.')
{
  string = str_del(string, length(string), 1);
}
return(string);
}



//;;

str
@first_2_characters(str parameter)
{
return(copy(parameter, 1, 2));
}



//;;

str
@first_3_characters(str parameter)
{
return(copy(parameter, 1, 3));
}



//;;

str
@first_4_characters(str parameter)
{
return(copy(parameter, 1, 4));
}



//;;

str
@first_5_characters(str parameter)
{
return(copy(parameter, 1, 5));
}



//;;

str
@fourth_to_last_character(str parameter)
{
return(copy(parameter, length(parameter) - 3, 1));
}



//;; (skw truncate_leftmost_character, truncate_first_character)

str
@trim_first_character(str parameter)
{
return(str_del(parameter, 1, 1));
}



//;;

str
@trim_left(str string, int number_of_characters_to_trim)
{
return(str_del(string, 1, number_of_Characters_To_Trim));
}



//;;

str
@left(str string, int right_boundary)
{
return(copy(string, 1, right_boundary));
}



//;; (skw truncate_rightmost_character, delete_last_character)

str
@trim_last_character(str parameter)
{
return(str_del(parameter, length(parameter), 1));
}



//;;

str
@last_character(str parameter)
{
return(str_char(parameter, length(parameter)));
}



//;;

str
@trim_leading_spaces(str string)
{
while(str_char(String, 1) == " ")
{
  String = str_del(String, 1, 1);
}
return(String);
}



//;;

str
@trim_trailing_spaces(str string)
{
while(Str_Char(String, length(String)) == ' ')
{
  String = str_del(String, length(String), 1);
}
return(String);
}



//;;

str
@right(str string, int number_of_characters)
{
return(Copy(string, length(string) - number_of_Characters + 1, number_of_Characters));
}



//;

str
@previous_six_characters(str parameter, int current_position_on_line)
{
// Chop off the last part of the line.
parameter = copy(parameter, 1, current_position_on_line);

// Chop off the first part of the line.
parameter = str_del(parameter, 1, current_position_on_line - 6);

//return(str_del(parameter, 1, current_position_on_line - 6));
return(parameter);
}



//;+ Define a Word



//;;

str
@define_what_a_word_is()
{
str fp = "Define the characters in a word.";

str rv = '';

rv += 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
rv += '0123456789';
rv += '$-@_.?';
rv += 'ÄÚÜİàáâäåæçèéêëíïñóôöøùúüı';

return(rv);
}



//;;

void
@word_delimit_tester
{
str fp = "Tests Multi-Edit's word delimits.";

str Permanent_Word_Delimits = word_delimits;

word_delimits = ":=.?;( )\,'%/";

/*

HellrainH/ello Spain.//Hello slash.

*/

//word_delimits += char(34);  // Double quote character.
word_right;

word_delimits = permanent_word_delimits;

}



//;+ Columns and Lines



//;;

int
@current_column()
{
return(c_col);
}



//;; (skw Current Line)

int
@current_line_number()
{
return(c_line);
}



//;

int
@current_row_number()
{
return(c_line);
}



//;

int
@current_row()
{
return(c_line);
}



//;

int
@column()
{
return(c_col);
}



//;

int
@current_column_number()
{
return(c_col);
}



//;+ Next Characters



//;;

str
@next_character()
{
return(copy(get_line, c_col + 1, 1));
}



//;;

str
@next_2_characters()
{
return(copy(get_line, c_col, 2));
}



//;;

str
@next_3_characters()
{
return(copy(get_line, c_col, 3));
}



//;+ Delete Stuff



//;;

void
@delete_character()
{
del_char;
}



//;;

void
@delete_current_character()
{
del_char;
}



//;+ Backspace and Deleting



//;;

void
@backspace()
{
str fp = 'My customized backspace.';
rm('bskey');
}



//;;

void
@delete_previous_character()
{
rm('bskey');
}



//;;

void
@delete_block()
{
delete_block;
}



//;;

void
@delete_previous_line()
{
up;
del_line;
}



//;;

void
@delete_line()
{
del_line;
}



//;

int
@current_line()
{
return(c_line);
}



//;

int
@is_alphanumeric_character(str prms_character)
{
//0-9, i.e. numbers
if((ascii(prms_Character)>= 48) && (ascii(prms_Character)<= 57))
{
  return(1);
}

// Uppercase letters.
if((ascii(prms_Character)>= 65) && (ascii(prms_Character)<= 90))
{
  return(1);
}

// Lowercase letters.
if((ascii(prms_Character)>= 97) && (ascii(prms_Character)<= 122))
{
  return(1);
}

// At symbol "@"
if(ascii(prms_Character) == 64)
{
  return(1);
}

// Dash "-"
if(ascii(prms_Character) == 45)
{
  return(1);
}

// Dollar Sign
if(ascii(prms_Character) == 36)
{
  return(1);
}

// Line Feed
if(ascii(prms_Character) == 1)
{
  return(1);
}

// Underscore Character "_"
if(ascii(prms_Character) == 95)
{
  return(1);
}

return(0);
}



//;+ Header



//;;

void
@header()
{
refresh=false;
insert_mode=1;
working;
push_undo;
}



//;;

void
@header_bloff()
{
str fp = 'Header that turns block highlighting off.';
refresh=false;
working;
push_undo;
block_off;
}



//;;

void
@center_line()
{
str fp = 'Center line.';

// The 2 Centerln statements are repeated intentionally due to their not working when executed
// just once. - JRJ Dec-3-2008

// This macro mysteriously and annoyingly turns off block highlighting.
// This repetition of lines is apparently necessary. - JRJ Apr-18-2011
rm('CenterLn');
rm('CenterLn');
}



//;

void
@select_all()
{
rm('Block^SelectAll');
}



//;

void
@go_to_column(int column_Number)
{
goto_col(column_Number);
}



//;

int
@text_is_selected()
{
str fp = 'Indicates whether or not a block is selected.';
if(block_stat)
{
  return(true);
}
return(false);
}



//;

int
@is_selected()
{
return(@text_is_selected);
}



//;

void
@go_to_the_beginning_of_block
{
str fp = "Go to the beginning of the block.";
goto_line(block_line1);
}



//; An easier to type alias for make_message.

void
@say(str message = parse_str('/1=', mparm_str))
{
make_message(message);
}



//;

void
@clear_markers()
{
str fp = 'Clear markers.';
pop_mark;
pop_mark;
pop_mark;
pop_mark;
pop_mark;
pop_mark;
pop_mark;
pop_mark;
pop_mark;
pop_mark;
pop_mark;
pop_mark;
pop_mark;
pop_mark;
pop_mark;
}



//;

int
@current_line_contains(str parameter)
{
str fp = "Current line contains passed in string.";
// fcd: Apr-30-2014
return (xpos(parameter, get_line, 1));
}



//;

void
@add_carriage_return()
{
cr;
goto_col(1);
}



//;

void
@delete
{
str fp = "Delete block.";

// lu: Feb-15-2018

delete_block;

@say(fp);
}



//; (!efal)