macro_file Format; // (!fm)

// Format text.

#include Aliases.sh
#include Finder.sh
#include Regexes.sh
#include Shared.sh



//;

/*

Metadata: Track Size (!tsfm)

    Date       Lines     Bytes    Macros   Notes
 -----------  ------  ---------  -------  ----------------------------------------------------

: Jan-4-2021   2,346     37,171       75

:Oct-12-2020   2,341     37,000       75

: Jul-2-2020   2,327     36,532       75

: Apr-8-2020   2,320     36,362       75

:Nov-11-2019   2,343     36,526       76

:Jun-23-2019   2,362     36,546       77

:Apr-26-2019   2,347     36,302       77

: Jan-1-2019   2,340     36,195       77

: Jul-1-2018   2,226     35,335       73

:May-17-2018   2,223     35,275       73

: May-7-2018   2,225     35,267       74

: Apr-3-2018   2,223     35,230       74

: Jan-3-2018   2,219     35,162       74

:Jun-25-2017   2,200     34,785       74

:Mar-31-2017   2,198     34,740       74

:Nov-17-2016   2,127     34,195       71

: Oct-7-2016   2,125     34,156       71

: Apr-8-2016   2,230     35,765       74

:Dec-31-2015   2,249     35,923       75

: Oct-5-2015   2,247     35,880       75

: Jul-1-2015   2,208     35,204       74

: Apr-1-2015   2,225     35,363       74

:Jan-16-2015   2,186     35,120       65

: Oct-1-2014   2,205     35,840       64

: Jul-1-2014   2,161     34,454       64

:Apr-10-2014   2,264     35,709       69

: Oct-1-2013   2,255     35,947       69

: Jul-1-2013   2,253     35,903       69

: Apr-1-2013   2,251     35,859       69

: Jan-2-2013   2,264     35,947       70

: Oct-1-2012   2,259     35,776       70

: Jul-2-2012   2,191     35,369       66

: Apr-2-2012   2,150     34,971       65

- Jan-2-2012   2,141    34,539      65

- Dec-20-2011  2,141    34,538      65

- Oct-3-2011   2,008    31,896      61

- Aug-1-2011   1,994    31,682      60

- Jul-15-2011  1,992    31,641      60

- Jun-1-2011   1,837    29,609      52

- Apr-7-2011   1,633    26,683      45

- Mar-17-2011  1,661    26,867      45 Moved a bunch of obsolete macros to the graveyard.

- Jan-18-2011  2,121    32,802      58

*/



//;+ Word Wrap



//;;(!ww)

void
@word_wrap()
{
str fp = 'This is my version of reformat.';
rm('Reformat');
@say(fp);
}



//;; (skw @comply_with_right_margin, obey right margin, wordwrap, obey_right_margin)

void
@word_wrap_file()
{
str fp = 'Make all lines in the file obey the right margin.';

tof;
while(!at_eof)
{
  rm('reformat');
}

@say(fp);
}



//;;

void
@subdivide_long_line_w_format()
{
str fp = 'Subdivide long lines into multiple lines. Uses the format command.';

int Number_of_Long_Lines;
int Line_Length = length(get_line);
if(Line_Length < 95)
{
  fp = 'This is a short line, so there is nothing to format.';
  @say(fp);
  return();
}

@bol;
mark_pos;
rm('reformat');
goto_mark;

int Line_Length = length(get_line);

if(Line_Length < 95)
{
  fp = 'Normal format worked, so there is nothing to hard reformat.';
  @say(fp);
  return();
}

int Column_Pointer = 1;
@bol;

while(Column_Pointer < Line_Length)
{
  goto_col(94);
  cr;
  Column_Pointer += 94;
}
if (Column_Pointer > 96)
{
  del_line;
}

/* Use Case(s)

1. Notice that the following line is exactly 95 characters long. So even though the right
margin is set to 95, 94 is a sort of practical limit.

*/

@say(fp);
}



//;; File Word Wrap Macro 3 of 4

int
@hard_format_long_lines_in_file()
{
str fp = 'Find lines that exceed the right margin and hard format them.';

if(!@is_text_file)
{
  return(0);
}

int Number_of_Replacements = 0;
tof;
while(!at_eof)
{
    eol;
    if(c_col > 96)
    {
      @bol;
      @subdivide_long_line_w_format;
      Number_of_Replacements++;
      tof;
    }
    down;
}

return(Number_of_Replacements);
}



//;;

int
@find_long_lines_and_format()
{
str fp = 'Find lines that exceed the right margin and reformat them.';

int Number_of_Replacements = 0;
tof;
while(!at_eof)
{
    eol;
    if(c_col > 96)
    {
      @bol;
      rm('Reformat');
      Number_of_Replacements++;
    }
    down;
}

return(Number_of_Replacements);
}



//;;

void
@find_long_line_and_wrap
{
str fp = "Find long line and wrap.";
@header;

// fcd: Apr-6-2016
@find_long_line;
@word_wrap;

@footer;
@say(fp);
}



//;; (format_long_line)

int
@force_word_wrap_of_current_line()
{
str fp = 'Force the current line to word wrap.';

int Number_of_Replacements;

// Try a simple single line format, to see if that fixes the problem.
mark_pos;
down;
@bol;
cr;
up;
up;
rm('reformat');
goto_mark;

@delete_next_blank_line;

int Current_Line_Length = length(get_line);
if(Current_Line_Length < 95)
{
  fp = 'Either the reformat code above worked or this is a short line, so there is nothing to 
  format.';
  @say(fp);
  down;
  return(0);
}

while(Current_Line_Length >= 95)
{
  goto_col(95);
  cr;
  Current_Line_Length = length(get_line);
}

/* Use Case(s)

- Crime Reports Dot Com:
http://www.crimereports.com/map?search=22042&searchButton.x=32&searchButton.y=7&searchButton=S
EARCH

*/

@bol;
@say(fp);
return(Number_of_Replacements);
}



//;;

void
@@force_word_wrap_of_current_lin
{
@header;
@force_word_wrap_of_current_line;
@footer;
}



//;; File Word Wrap Macro 4 of 4

void
@subdivide_long_line_wow_in_file()
{
str fp = 'Chop format the entire file.';

tof;

while(@find_next_long_line)
{
  @force_word_wrap_of_current_line; 
}

@bof;

}



//;; File Word Wrap Macro 1 of 4

void
@word_wrap_file_hard_core()
{
str fp = 'Make all lines in the file obey the right margin definitively.';

tof;

while(!at_eof)
{
  rm('reformat');
}

@hard_format_long_lines_in_file;

@say(fp);
}



//;+ Formatters



//;

void
@make_blank_looking_lines_actual()
{
str fp = 'Make blank looking lines actually so.';

int Number_of_Replacements = 0;

tof;
while(!at_eof)
{
  if(find_text('^ +$', 0, _regexp))
  {
    replace('');
    Number_of_Replacements++;
    tof;
  }
  else
  {
    break;
  }
}
fp += ' Number of replacements = ' + str(Number_of_Replacements);

@say(fp);
}



//;+ Delete Macros



//;;

str
@delete_blank_lines()
{

str fp = 'Delete all blank lines in this file.';

/*

(skw remove blank lines, _remove_blank_lines, remove all blank lines, delete blank lines)

*/

// Warning: Dangerous macro.

if(!@is_text_file)
{
  return('');
}

int Number_of_Replacements = 0;

@make_blank_looking_lines_actual;

tof;

str rs = "";

int Number_of_Replacements = 0;

str fpx = "";

Number_of_Replacements += @replace_string_in_file_int(@blank_line(fpx, rs), rs);

fp += ' Number of blank lines deleted: ' + str(Number_of_Replacements) + '.';

@say(fp);
return(fp);
}



//;;

void
@@delete_blank_lines
{
@header;
@delete_blank_lines;
@footer;
}



//;;

str
@delete_matching_lines(str sc = parse_str('/1=', mparm_str))
{
str fp = 'Delete lines in this file containing the passed in string.';

fp = 'Delete lines in this text file containing ';

/*
skw delete matching, delete lines containing, delete line containing, delete line having

*/

if(!@is_text_file)
{
  return("Must be text file.");
}

int Number_of_Deletions = 0;

if(sc == "")
{
  sc = 'WriteLineIfContainsValue';
}

tof;
while(!at_eof)
{
  if(find_text(sc, 0, _regexp))
  {
    del_line;
    up;
    Number_of_Deletions++;
  }
  else
  {
    break;
  }
}

str rv = fp + '"' + sc + '". # of lines deleted: ' + str(Number_of_Deletions) + '.';
return(rv);
}



//;;

void
@prepare_for_delete_matching_ln
{
str fp = 'Prepare for delete matchling lines.';

if(!@text_is_selected)
{
  @say(fp + ' Text must be selected.');
  return();
}

@header;
mark_pos;
fp = @delete_matching_lines(@get_selected_text);
goto_mark;
@footer;

@say(fp);
}



//;;

str
@delete_nonmatching_lines(str sc = parse_str('/1=', mparm_str))
{
str fp = 'Delete lines that DO NOT contain certain strings from a file.';

fp = 'Delete lines that DO NOT contain ';

if(!@is_text_file)
{
  return('');
}

int Number_of_Deletions = 0;

tof;
while(!at_eof)
{
  if(xpos(@lower(sc), @lower(Get_Line), 1) == 0)
  {
    del_line;
    up;
    Number_of_Deletions++;
  }
  else
  {
    down;
  }
}

str rv = fp + '"' + sc + '". # of lines deleted: ' + str(Number_of_Deletions) + '.';

@say(rv);
return(rv);
}



//;;

void
@prepare_for_delete_nonmatching
{
str fp = 'Prepare for delete nonmatchling lines.';

if(!@text_is_selected)
{
  @say(fp + ' Text must be selected.');
  return();
}

@header;
mark_pos;
fp = @delete_nonmatching_lines(@get_selected_text);
goto_mark;
@footer;

@say(fp);
}



//;;

void
@delete_tabs_and_line_feeds_if()
{
str fp = 'Replace tabs and line feeds with nothing in a file.';

int Number_of_Replacements = @replace_string_in_file_int(char(13), ''); // Tab
Number_of_Replacements += @replace_string_in_file_int(char(10), ''); // Line Feed
fp = 'Number of replacements = ' + str(Number_of_Replacements);

@say(fp);
}



//;;

void
@delete_next_blank_line()
{
str fp = 'Delete next blank line.';
str qs = @trim_after_first_sentence(fp);
str sc = '$^$';
str rs = '';
@replace_next_occurrence_only(sc, rs);
}



//;+ Sorts



//;; (sort block)

void
@sort_block
{
str fp = 'Sort the selected block of text.';
@header;

if(!@text_is_selected)
{
  return();
}

// I might also have used the ME function "QSort_Lines".
// This is the old way.
// rm('Sor+tMenu');
rm('textsort /B');

@footer;
@say(fp);
}



//;; Warning: Dangerous Macro

void
@sort_file()
{
str fp = 'Sort the entire file.';

if(!@is_text_file)
{
  return();
}

@tof;

rm('textsort');
@delete_blank_lines;

@say(fp);
}



//; (skw search_results, search results, format visual studio, format_visual_studio)

void
@format_vstudio_find_results
{
str fp = "Format VStudio 2008's find results by deleting the filename and whitespace.";

if(!@is_text_file)
{
  return();
}

@header;

tof;
del_line;

@delete_matching_lines("Total files searched:");
@delete_blank_lines;

tof;

while(!at_eof)
{
  @delete_character;
  @delete_character;
  @delete_character;
  @delete_character;
  // Now delete characters until you get to the second colon.
  while(@current_character != ':')
  {
    @delete_character;
  }
  @delete_character;
  while(@current_character == ' ')
  {
    @delete_character;
  }
  down;
}

tof;

@footer;

@say(fp);
}



//;+ Replace All



//;;(!repl)

int
@replace_all_special_characters()
{
// Replaces all of the instances of these special characters in a file.
str fp = 'Replace all special characters in file.';

/* skw
replace all special characters, replace special characters, replace_spec
*/

str fp2 = ' Please wait . . .';

int number_of_replacements = 0;
str replacement_description = '';

str rs = '';
str sc;

@say(fp + fp2);
// Insert code after this line. (!icx) Replacements are listed alphabetically by title.

// Alphanumeric
Number_of_Replacements += 
  @replace_string_in_file_int(@alphanumeric_space_period(Replacement_Description, rs), rs);

Number_of_Replacements += 
  @replace_string_in_file_int(@bol_comma(Replacement_Description, rs), rs);

Number_of_Replacements += 
  @replace_string_in_file_int(@bol_space_eol(Replacement_Description, rs), rs);

number_of_replacements += 
  @replace_string_in_file_int(@close_parenthesis_number(Replacement_Description, rs), rs);

// Crowded
number_of_replacements += 
  @replace_string_in_file_int(@crowded_noun(replacement_description, rs), rs);

Number_of_Replacements += 
  @replace_string_in_file_int(@defined_for_kids(Replacement_Description, rs), rs);

//qjq
Number_of_Replacements += 
  @replace_string_in_file_int(@citation_needed(Replacement_Description, rs), rs);

Number_of_Replacements += 
  @replace_string_in_file_int(@clarification_needed(Replacement_Description, rs), rs);

number_of_replacements += 
  @replace_string_in_file_int('\[edit\]', '');

number_of_replacements += 
  @replace_string_in_file_int('â-"', "'");

number_of_replacements += 
  @replace_string_in_file_int(@first_known_use(replacement_description, rs), rs);

// Informal
number_of_replacements += 
  @replace_string_in_file_int(@informal_followed_by_a_crowding(replacement_description, rs), rs);

number_of_replacements += 
  @replace_string_in_file_int(@language_learner(replacement_description, rs), rs);

Number_of_Replacements += 
  @replace_string_in_file_int(@letter_space_close_parenthesis(Replacement_Description, rs), rs);

// Open
Number_of_Replacements += 
  @replace_string_in_file_int(@open_bracket_space(Replacement_Description, rs), rs);

Number_of_Replacements += 
  @replace_string_in_file_int(@period_space_eol(Replacement_Description, rs), rs);

Number_of_Replacements += 
  @replace_string_in_file_int(@period_space_space_alpha_char(Replacement_Description, rs), 
  rs);

Number_of_Replacements += 
  @replace_string_in_file_int(@rhymes_with(Replacement_Description, rs), rs);

Number_of_Replacements += 
  @replace_string_in_file_int('/' + 'submit', '');

// Space
Number_of_Replacements += 
  @replace_string_in_file_cs(@space_eol_blank_line(Replacement_Description, rs), rs);

Number_of_Replacements += 
  @replace_string_in_file_int(@show_ipa(Replacement_Description, rs), rs);

number_of_replacements += 
  @replace_string_in_file_int(@space_eol_blank_line(replacement_description, rs), rs);

Number_of_Replacements += 
  @replace_string_in_file_int(@space_space_eol(Replacement_Description, rs), rs);

// Special (first)
Number_of_Replacements += 
  @replace_string_in_file_int(@special_character(Replacement_Description, rs, char(6)), rs);

Number_of_Replacements += 
  @replace_string_in_file_int(@special_character(Replacement_Description, rs, char(27)), rs);

Number_of_Replacements += 
  @replace_string_in_file_int(@special_character(Replacement_Description, rs, char(128)), rs);

Number_of_Replacements += 
  @replace_string_in_file_int(@special_character(Replacement_Description, rs, char(129)), rs);

Number_of_Replacements += 
  @replace_string_in_file_int(@special_character(Replacement_Description, rs, char(130)), rs);

Number_of_Replacements += 
  @replace_string_in_file_int(@special_character(Replacement_Description, rs, char(131)), rs);

Number_of_Replacements += 
  @replace_string_in_file_int(@special_character(Replacement_Description, rs, char(132)), rs);

Number_of_Replacements += 
  @replace_string_in_file_int(@special_character(Replacement_Description, rs, char(133)), rs);

Number_of_Replacements += 
  @replace_string_in_file_int(@special_character(Replacement_Description, rs, char(134)), rs);

Number_of_Replacements += 
  @replace_string_in_file_int(@special_character(Replacement_Description, rs, char(135)), rs);

Number_of_Replacements += 
  @replace_string_in_file_int(@special_character(Replacement_Description, rs, char(136)), rs);

Number_of_Replacements += 
  @replace_string_in_file_int(@special_character(Replacement_Description, rs, char(137)), rs);

Number_of_Replacements += 
  @replace_string_in_file_int(@special_character(Replacement_Description, rs, char(139)), rs);

Number_of_Replacements += 
  @replace_string_in_file_int(@special_character(Replacement_Description, rs, char(140)), rs);

Number_of_Replacements += 
  @replace_string_in_file_int(@special_character(Replacement_Description, rs, char(146)), rs);

Number_of_Replacements += 
  @replace_string_in_file_int(@special_character(Replacement_Description, rs, char(147)), rs);

Number_of_Replacements += 
  @replace_string_in_file_int(@special_character(Replacement_Description, rs, char(148)), rs);

Number_of_Replacements += 
  @replace_string_in_file_int(@special_character(Replacement_Description, rs, char(149)), rs);

Number_of_Replacements += 
  @replace_string_in_file_int(@special_character(Replacement_Description, rs, char(150)), rs);

Number_of_Replacements += 
  @replace_string_in_file_int(@special_character(Replacement_Description, rs, char(151)), rs);

Number_of_Replacements += 
  @replace_string_in_file_int(@special_character(Replacement_Description, rs, char(152)), rs);

Number_of_Replacements += 
  @replace_string_in_file_int(@special_character(Replacement_Description, rs, char(153)), rs);

Number_of_Replacements += 
  @replace_string_in_file_int(@special_character(Replacement_Description, rs, char(154)), rs);

Number_of_Replacements += 
  @replace_string_in_file_int(@special_character(Replacement_Description, rs, char(155)), rs);

Number_of_Replacements += 
  @replace_string_in_file_int(@special_character(Replacement_Description, rs, char(156)), rs);

Number_of_Replacements += 
  @replace_string_in_file_int(@special_character(Replacement_Description, rs, char(158)), rs);

number_of_replacements += 
  @replace_string_in_file_int(@special_character(replacement_description, rs, char(171)), rs);

number_of_replacements += 
  @replace_string_in_file_int(@special_character(replacement_description, rs, char(183)), ' ');

number_of_replacements += 
  @replace_string_in_file_int(@special_character(replacement_description, rs, char(187)), rs);

// Example of how to change the replacement character.
number_of_replacements += 
  @replace_string_in_file_int(@special_character(replacement_description, rs, char(194)), '');

number_of_replacements += 
  @replace_string_in_file_int(@synonyms_space_space(replacement_description, rs), rs);

number_of_replacements += 
  @replace_string_in_file_int('tr\.' + 'v', 'tr. v');

number_of_replacements += 
  @replace_string_in_file_int('v\.' + 'intr', 'v. intr');

number_of_replacements += 
  @replace_string_in_file_int('v\.' + 'tr', 'v. tr');

// Three special characters.
number_of_replacements += 
  @replace_string_in_file_int('ï' + '¿½', '·');

// Word
number_of_replacements += 
  @replace_string_in_file_int(@word_history_space_space(replacement_description, rs), rs);

switch(@filename)
{
  case 'cm.asc':
  case 'cs.asc':
  case 'gc.asc':
  case 'it.asc':
  case "jonathan's_macros.s":
  case 'ne.asc':
    // This replacement does not work with these files.
    break;
  default:
    Number_of_Replacements += 
      @replace_string_in_file_int(@wikipedia_annotation(Replacement_Description, rs), rs);
    Number_of_Replacements += 
      @replace_string_in_file_int(@wikipedia_annotation_2_digits(Replacement_Description, rs), rs);

}

Number_of_Replacements += 
  @replace_string_in_file_int(@wikipedia_citation(Replacement_Description, rs), rs);

// I am putting this evaluation last because I think some previous evaluations (such as 
// Wikipedia annotation) may create the need for this evaluation remediation.

fp += ' Number of replacements = ' + str(Number_of_Replacements);

@say(fp);
return(Number_of_Replacements);
}



//;;

void
@@replace_all_special_characters
{
@header;
tof;
@replace_all_special_characters;
@footer;
}



//;+ Replace 2



//;;(!spac) (skw with one, replace_2_spaces_with_1)

str
@replace_2_spaces_with_1()
{
str fp = 'Replace 2 spaces with 1 in a file.';

if(!@is_text_file)
{
  return("Not a text file.");
}

@say(fp + " This could take some time. Please wait . . .");

fp += ' Number of replacements = ' + str(@replace_string_in_file_int('  ', ' ')) + '.';

@say(fp);
return(fp);
}



//;;

void
@@replace_2_spaces_with_1
{
@header;
@replace_2_spaces_with_1;
@footer;
}



//;; (skw 2 with 1, with one, 2_with_1, @replace_2_lines_with_1): lk#2

void
@replace_2_blank_lines_with_1()
{
str fp = 'Replace 2 blank lines with 1 in file.';

if(!@is_text_file)
{
  return();
}

// Prepare the file.
@make_blank_looking_lines_actual;

fp += @replace_all_occurrences_in_file('^$^$', '');

@say(fp);
}



//;

void
@add_blank_lines()
{
str fp = 'Add a blank line before every nonblank line.';

if(!@is_text_file)
{
  return();
}

tof;
while(!at_eof)
{
  if(@trim(@first_character(get_line)) != '')
  {
    @bol;
    cr;
  }
  down;
}

@say(fp);
}



//;

void
@add_text_blank_lines_before_cl()
{
str fp = 'Add blank lines before certain lines.';
str rs;
str sc;
str so;
int efbo = true; // execute first block only

@header;

sc = @get_selected_text;

if(@trim(sc) == '')
{
  fp += ' No text was selected.';
  @say(fp);
  return();
}

sc = '(' + @get_selected_text + ')';
block_off;
rs = '$\0';

tof;
if(efbo){ so = @replace_all_occurrs_inf_one_tof(sc, rs); efbo = 0; }

@footer;
@say(fp);
}



//;

void
@add_blank_line_if_ln_exceeds_96()
{
str fp = 'Add blank line before every nonblank line if the line length exceeds 96.';

if(!@is_text_file)
{
  return();
}

int Number_of_Lines_Added = 0;

tof;
while(!at_eof)
{
  eol;
  if((@first_character(get_line) != '') and (@current_column > 96))
  {
    Number_of_Lines_Added++;
    @bol;
    cr;
    down;
    @bol;
    cr;
  }
  down;
}

@say(fp + ' Number of lines added: ' + str(Number_of_Lines_Added) + '.');
}



//;+ Delete Spaces



//;;(skw delete_spaces, delete spaces)

str
@delete_space_at_bol()
{
str fp = 'Delete spaces at the beginning of lines in a file.';

if(!@is_text_file)
{
  return('');
}

fp += ' Number of replacements = ' + str(@replace_string_in_file_int('^ ', '')) + '.';

@say(fp);
return(fp);
}



//;;

void
@@delete_space_at_bol
{
@header;
@delete_space_at_bol;
@footer;
}



//;;

str
@delete_space_at_eol()
{
str fp = 'Delete spaces at the end of lines in a file.';

str rs;
str Replacement_Description;
fp = 'Number of replacements = ' + 
  str(@replace_string_in_file_int(@space_eol_blank_line(Replacement_Description, rs), rs));

@say(fp);
return(fp);
}



//;

void
@delete_blank_line_at_eof()
{
str fp = "Delete blank line at eof.";

eof;
@eol;
if(@current_column == 1)
{
  @delete_line;
}

@say(fp);
}



//;

void
@delete_the_word_wikipedia()
{
str fp = "Delete the word Wikipedia.";

// fcd: Mar-9-2016

eof;
@eol;
str wuc = @get_uc;
if(wuc == 'Wikipedia')
{
  @delete_word_backwards;
}

@say(fp);
}



//;

void
@add_blank_line_at_every_other_l()
{
str fp = "Add blank line at every other line.";

// fcd: Mar-29-2017

str rs;
str sc;

sc = '$^';

rs = '$$';

@tof;

@eol;

@replace_all_occurrs_inf_one_tof(sc, rs);
@say(fp);
return();
}



//;+ Format File



//;;

void
@format_file_2()
{
str fp = 'Format text file according to my new rules.';

// fcd: "Mar-16-2017
/*
skw Format document, @format_document, @format_text_file, format text file), format_file, 
reformat_file, reformat file

*/

if(!@is_text_file)
{
  return();
}

@header;

@add_blank_lines;
@word_wrap_file;
@add_blank_line_if_ln_exceeds_96;
@add_blank_line_if_ln_exceeds_96;
@hard_format_long_lines_in_file;
@delete_blank_lines;

@footer;

@say(fp);
}



//;;

void
@format_file_for_wildfly_errors()
{

str fp = 'Format file for wildfly erros.';

// fcd: Mar-29-2017

if(!@is_text_file)
{
  return();
}

@header;

@add_blank_line_at_every_other_l;
@word_wrap_file;
@hard_format_long_lines_in_file;
@replace_2_blank_lines_with_1;

@tof;

@footer;

@say(fp);
}



//;;

void
@format_file()
{
str fp = 'Format text file according to my rules.';

/*
skw Format document, @format_document, @format_text_file, format text file), format_file, 
reformat_file, reformat file

*/

if(!@is_text_file)
{
  return();
}

@add_blank_line_if_ln_exceeds_96;

@word_wrap_file;

@replace_2_blank_lines_with_1;

@replace_2_spaces_with_1;

@replace_all_special_characters;

@delete_space_at_bol;

@delete_space_at_eol;

@delete_blank_line_at_eof;

@delete_the_word_wikipedia;

@bof;

if(@current_character == ':')
{
  @delete_character; 
}

@say(fp);
}



//;;

void
@@format_file
{
@header;
@format_file;
@footer;
}



//;+ Add Colons



//;;

void
@add_colons()
{
str fp = "Add colon at BOL after every blank line / nonblank line.";

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

@say(fp);
}



//;;

void
@@add_colons
{
@header;
@add_colons
@footer;
}



//;

void
@add_commas_to_a_number(str &str_commas_added)
{
str fp = 'Add commas to a number with none.';

if(length(str_Commas_Added) < 4)
{
  @say('You do not need commas because your number has fewer than 3 places.');
  return();
}
str str_Proper_Output = copy(str_Commas_Added, length(str_Commas_Added)- 2,
  length(str_Commas_Added));

str str_Shortened = str_del(str_Commas_Added, length(str_Commas_Added)- 2,
  length(str_Commas_Added));

while(length(str_Shortened)> 3)
{
  str_Proper_Output = copy(str_Shortened, length(str_Shortened)- 2, length(str_Shortened)) +
    ',' + str_Proper_Output;

  str_Shortened = str_del(str_Shortened, length(str_Shortened)- 2, length(str_Shortened));
}
str_Commas_Added = str_Shortened + ',' + str_Proper_Output;

@say(fp);
}



//;+ Comment



//;;

str
@comment_characters()
{
str fp = "Comment character for different types of files.";

str rv;

switch(lower(Get_Extension(File_name)))
{
  case 'asc':
    rv = ':';
    break;
  case 'bat':
    rv = 'rem ';
    break;
  case 'config':
  case 'htm':
  case 'html':
  case 'xaml':
  case 'xml':
  case 'xsl':
  case 'xslt':
    rv = '<!-- ';
    break;
  case '':
  case 'cs':
  case 'java':
  case 'js':
  case 's':
  case 'sh':
    rv = '//';
    break;
  case 'erb':
  case 'ps1':
  case 'rb':
  case 'tf':
  case 'yml':
    rv = '#';
    break;
  case 'sql':
    rv = '--';
    break;
}

@say(fp);
return(rv);
}



//;;

void
@add_colon()
{
str fp = "Add colon.";

// lu: Jul-18-2018

mark_pos;

@bol;

if(@first_2_characters(get_line) == '::')
{
  fp += ' Cannot add more than 2 colons.';
  goto_mark;
}
else
{
  text(':');
  goto_mark;
  right;
}

@say(fp);
}



//;;

void
@add_semicolon()
{
str fp = "Add semicolon.";

// lu: Aug-14-2018

mark_pos;

@bol;

if(@first_2_characters(get_line) == ';;')
{
  fp += ' Cannot add more than 2 semicolons.';
  goto_mark;
}
else
{
  text(';');
  goto_mark;
  right;
}

@say(fp);
}



//;;

void
@drag_right()
{
str fp = 'Drag right.';

// lu: Aug-30-2019

if(@first_character(get_line) == ':')
{
  @add_colon;
  return();
}

if(@first_character(get_line) == ';')
{
  @add_semicolon;
  return();
}

if(@first_3_characters(get_line) == '//;')
{
  if(@first_4_characters(get_line) == '//;;')
  {
    @say(fp += ' Invalid sequence.');
    return();
  }
  mark_pos;
  @eol;
  text(';');
  goto_mark;
  @say(fp += ' Semicolon added.');
  return();
}

switch(lower(get_extension(File_name)))
{
  case 'asc':
  case 'rb':
  case 'tf':
  case 'yml':
    @bol;
    text(@comment_characters);
    break;
  case 'bat':
    @bol;
    if(@current_character == ' ')
    {
      word_right;
    }
    text(@comment_characters);
    break;
  case 'ps1':
    text('#');
    text('#');
    break;
  case '':
  case 's':
  case 'sh':
    if(@next_character != '/')
    {
      @eos;
      text('//');
    }
    else
    {
      eol;
      text(';');
    }
    break;
  case 'sql':
    if(@next_character != '-')
    {
      text('--');
    }
    break;
}

@say(fp);
}



//;;

void
@add_comment_characters()
{

str fp = 'Add or delete comment slashes just like CodeRush does.';

if(!@is_code_file)
{
  return();
}

mark_pos;

if(!@text_is_selected)
{
  @highlight_current_line;
}

goto_line(Block_Line2);
@bol;

while(!at_eol)
{
  if(@current_character == ' ')
  {
    right;
  }
  else
  {
    break;
  }
}

str Comment_Determinant = @current_character + @next_character;

int block_height = block_line2 - block_line1 + 1;

goto_line(Block_Line1);

@bol;

str Comment_Characters = @comment_characters;

if(Comment_Determinant != @left(Comment_Characters, 2)) // Comment the block.
{
  while(c_line <= Block_Line2)
  {
    Find_Text('^', 1, _regexp);
    Replace(Comment_Characters);
    if(@is_markup_file(@filename_extension))
    {
      eol;
      text('-->');
    }
    goto_col(1);
    down;
  }
  up;
}
else
{
  eol;
  text(';');
}

/* Use Case(s)

//nonindented block

//indented block;

*/

goto_mark;
right;
right;

@say(fp);
}



//;;

void
@delete_comment_characters()
{

str fp = 'Add or delete comment slashes just like CodeRush does.';

if(!@is_code_file)
{
  return();
}

mark_pos;

if(!@text_is_selected)
{
  @highlight_current_line;
}

goto_line(Block_Line2);
@bol;

while(!at_eol)
{
  if(@current_character == ' ')
  {
    right;
  }
  else
  {
    break;
  }
}

str Comment_Determinant = cur_char + @next_character;

int block_height = block_line2 - block_line1 + 1;

goto_line(Block_Line1);

@bol;

str Comment_Characters = @comment_characters;

if(Comment_Determinant == @left(Comment_Characters, 2)) // Uncomment the block.
{
  while(c_line <= Block_Line2)
  {
    Find_Text(Comment_Characters, 1, 0);
    Replace('');
    if(@is_markup_file(@filename_extension))
    {
      @eol;
      @backspace;
      @backspace;
      @backspace;
    }
    goto_col(1);
    down;
  }
  up;
}

/* Use Case(s)

nonindented block

      indented block

*/

goto_mark;
left;
left;

@say(fp);
}



//;;

void
@add_or_delete_comments_markers()
{

str fp = 'Add or delete comment slashes just like CodeRush does.';

if(!@is_code_file)
{
  return();
}

@header;

if(!@text_is_selected)
{
  @highlight_current_line;
}

goto_line(Block_Line2);
@eos;

int is_Already_Commented = false;
char comment_character = @left(@comment_characters, 1);

char comment_determinant = cur_char;

if(@is_markup_file(@filename_extension))
{
  right;
  if(@current_character == '!')
  {
    is_already_commented = true;
  }
}
else
{
  if(comment_determinant == comment_character)
  {
    is_already_commented = true;
  }
}

int block_length = block_line2 - block_line1 + 1;

goto_line(Block_Line1);

@bol;

if(is_already_commented) // uncomment the block.
{
  while(c_line <= Block_Line2)
  {
    if(@is_markup_file(@filename_extension))
    {
      Find_Text(@comment_characters, 1, 0);
      Replace('');
      eol;
      @backspace;
      @backspace;
      @backspace;
    }
    else
    {
      find_text(comment_character + comment_character, 1, 0);
      Replace('');
    }
    goto_col(1);
    down;
  }
  up;
}
else // Comment the block.
{
  while(c_line <= Block_Line2)
  {
    if(@is_markup_file(@filename_extension))
    {
      Find_Text('', 1, _regexp);
      Replace(@comment_characters);
      eol;
      text('-->');
    }
    else
    {
      // This code is buggy so I commented it until I get it right. Nov-28-2011
      //Find_Text('^( #)([A-Za-z{}])', 1, _regexp);
      //Replace('\0' + Comment_Character + Comment_Character + '\1');
      Find_Text('^', 1, _regexp);
      Replace(@comment_characters);
    }
    goto_col(1);
    down;
  }
  up;
}

/* Use Case(s)

//nonindented block

//      indented block

*/

@footer;
@say(fp);
}



//;+ Dragging



//;;

void
@drag_right_wrapper
{
str fp = "Drag right wrapper.";

if(@is_bullet_file)
{
  @drag_right;
}
else
{
  @add_comment_characters; 
}
}



//;;

void
@drag_left()
{
str fp = 'Drag left.';

if(@first_character(get_line) == ':')
{
  @bol;
  @delete_character;
  return();
}

if(@first_4_characters(get_line) == '//;;')
{
  mark_pos;
  @eol;
  @backspace;
  goto_mark;
  @say(fp += ' Semicolon deleted.');
  return();
}

switch(lower(get_extension(File_name)))
{
  case 'bat':
    if(@first_4_characters(get_line) == @comment_characters)
    {
      mark_pos;
      @bol;
      del_char;
      del_char;
      del_char;
      del_char;
      goto_mark;
    }
    break;
  case 'rb':
  case 'tf':
  case 'yml':
    @bol;
    if(@first_character(get_line) == '#')
    {
      del_char;
      return();
    }
    break;
  case 'asc':
    if(@first_2_characters(get_line) == ';;')
    {
      @bol;
      @delete_character;
    }
    break;
  case 's':
  case '':
    @eos;
    int character_Was_Deleted = false;
    if(@current_character == '/')
    {
      del_char;
      character_Was_Deleted = true;
    }
    if(@current_character == '/')
    {
      del_char;
      character_Was_Deleted = true;
    }
    if(!character_Was_Deleted)
    {
      @bol;
      if(@current_character == ' ')
      {
        del_char;
      }
      if(@current_character == ' ')
      {
        del_char;
      }
    }
    break;
  case 'sh':
  case 'sql':
    if(@current_character == ' ')
    {
      del_char;
    }
    if(@current_character == ' ')
    {
      del_char;
    }
    if(@current_character == '-')
    {
      del_char;
    }
    if(@current_character == '-')
    {
      del_char;
    }
    break;
  default:
    if((@current_character == ' '))
    {
      del_char;
    }
}

@say(fp);
}



//;;

void
@drag_left_wrapper
{
str fp = "Drag left wrapper.";

if(@is_bullet_file)
{
  @drag_left;
}
else
{
  @delete_comment_characters; 
}

/* Use Case

- 1. Use Case on Dec-5-2011: Fix alt+left from column 2 of a subbullet.

*/

}



//;

void
@format_next_long_line
{
str fp = 'Format next long line.';
@header;

if(length(@find_long_line) > 0)
{
  eol;
  cr;
  up;
  rm('reformat');
}

@footer;
@say(fp);
}



//; (skw negative twofer)

void
@negative_twofer()
{
str fp = 'Replace next occurrence of two blank lines with one.';

str sc = '$^$^$';
str rs = '$';

@replace_next_occurrence_only(sc, rs);

@say(fp);
}



//;

void
@format_c_sharp_code_for_pasting
{
str fp = "Format c# code for pasting into C# Code Keepers.bul.";

if(!@is_text_file)
{
  return();
}

@header;

@save_location;

@create_reusable_temporary_file;
@paste;
@delete_space_at_bol;
@delete_blank_lines;
@select_all;
@copy;
@close_and_save_file_wo_prompt;

@restore_location;

@paste;

@footer;
@say(fp);
}



//;+ Format XSL File Rubric Header



//;;

void
@add_2_blank_lines_before_templa()
{
str fp = "Add 2 blank lines before template blocks.";
str rs;
str so;
int EFBO = true; // Execute First Block Only

str sc = '';
sc = '(<xsl:template)';
rs = '$$\0';
right;

@say(fp);

so = @replace_all_occurrs_inf_one_tof(sc, rs);

@say(found_str);
@say(so);
}



//;;

void
@format_xsl_file
{
str fp = "Format XSL file.";
@header;

@add_2_blank_lines_before_templa;

@footer;
@say(fp);
}



//; (skw long lines, fix all long lines) - File Word Wrap Macro 2 of 4

void
@fix_all_long_lines_in_file
{
str fp = "Fix all long lines in file.";

@header;

int long_Line_Counter = 0;

tof;

while(@find_next_long_line)
{
  @word_wrap;
  @say(fp + ' Number of long lines wrapped = ' + str(long_Line_Counter) + '.');
  long_Line_Counter++;
}

@footer;

@say(fp + ' Number of long lines wrapped = ' + str(long_Line_Counter) + '.');
}



//;

void
@add_2_blank_lines_before_each_e()
{
str fp = "Add 2 blank lines before each entity type.";
str rs;
str sc;
str so;
int EFBO = true; // Execute First Block Only

if(@current_line > 14000)
{
  tof;
}

sc = '(<entity type)';
rs = '$$\0';
right;

if(EFBO){ so = @replace_all_occurrs_inf_one_tof(sc, rs); EFBO = 0; }

@say(found_str);
@say(so);
@say(fp);
}



//; (skw paste_news)

void
@format_and_paste_a_news_story
{
str fp = "Format and paste a news story.";
@header;

if(!@is_text_file)
{
  return();
}

@paste;

@add_blank_lines;

@subdivide_long_line_wow_in_file;

str description;
str rs;
str sc = @read_more_answers_dot_com(description, rs);
@replace_next_occurrence_only(sc, rs);
@replace_all_special_characters;
@replace_2_blank_lines_with_1;
//@delete_blank_lines_near_eof;

@footer;
@say(fp);
}



//;

void
@add_blank_lines_and_colons
{
str fp = "Add blank lines and colons.";

// lu: Jul-23-2018

@header;

@add_blank_lines;

@add_colons;

@footer;
@say(fp);
}



//; (!effm)
