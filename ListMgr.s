macro_file ListMgr; // (!lm)

#include Aliases.sh
#include Finder.sh
#include Format.sh
#include Regexes.sh
#include Shared.sh



//; Macro File Glass Ceiling



//;

/*

Metadata: Track Size (!tsli, !tslm)

    Date       Lines     Bytes     Macros  Notes
 -----------  ------  ---------  -------  ----------------------------------------------------

:Nov-17-2016  12,562    165,515      461

: Oct-7-2016  12,857    170,830      464

: Apr-8-2016  12,591    167,310      452

:Dec-31-2015  12,541    166,355      451

: Oct-5-2015  12,545    166,344      451

: Jul-1-2015  12,513    165,883      451

: Apr-1-2015  12,335    163,431      443

:Jan-16-2015  12,132    162,171      410

: Oct-1-2014  11,988    158,787      394

: Jul-1-2014  11,886    157,871      390

:Apr-10-2014  11,343    148,677      374

: Oct-1-2013  11,293    148,357      364

: Jul-1-2013  11,328    149,327      364

: Apr-1-2013  11,391    149,619      373

: Jan-2-2013  11,377    149,314      373

: Oct-1-2012  11,325    148,624      371

: Jul-2-2012  10,793    142,162      353

:Jun-22-2012  10,755    141,023      353

: Apr-2-2012 10,902   143,272     352

- Jan-2-2012  10,235   135,244     330

- Dec-20-2011 10,206   135,008     329

- Dec-8-2011  10,043   132,451     327

- Nov-29-2011 10,146   133,841     329 At 65 lines per page, that's 165 pages.

- Oct-3-2011   8,818   117,699     279

- Aug-1-2011   8,490   113,845     269

- Jul-15-2011  8,488   113,692     269

- Jun-1-2011   8,394   112,345     267

- Apr-7-2011   8,163   108,629     262

- Jan-18-2011  8,266   107,742     281

- Jan-18-2011  7,535    98,985     259

- Jan-18-2011  6,815    89,061     243

- Jan-5-2011   6,135    76,241     216

- Jan-4-2011   6,133    76,200     216

- Mar-1-2010   2,093    26,038      86

- Feb-1-2010   2,051    25,524      85

- Jan-8-2010   2,049    25,483      85

*/



//;

int
@find_next_big_segment()
{
str fp = "Find next big segment.";
int rv;

right;
if(find_text(@big_segment, 0, _regexp))
{
  rm('CenterLn');
  rv = 1;
}
else // No more rubrics.
{
  left;
  fp += ' You are at the last Rubric.';
  rv = 0;
}

switch(lower(Get_Extension(File_Name)))
{
  case 'config':
    break;
  default:
    @eol;
}

return(rv);
}



//;+ Current Area Type, Current Content Type, Current Line Type



//;; (skw current_content_area, @is_structured_line)

str
@current_line_type()
{
str fp = 'Identifies the current line type.';

str rv = '';

int current_column = @current_column;
@bol;
if(find_text(@bullet, 1, _regexp))
{
  rv = 'bullet';
}
else if(find_text(@subbullet, 1, _regexp))
{
  rv = 'subbullet';
}
else if(find_text(@rubric, 1, _regexp))
{
  rv = 'rubric';
}
else if(find_text(@subrubric, 1, _regexp))
{
  rv = 'subrubric';
}
goto_col(current_column);

@say(rv);
return(rv);
}



//;;

int
@is_structured_line()
{
str fp = 'Current line type is structured.';
if(@current_line_type == '')
{
  return(0);
}
return(1);
}



//;;

str
@current_area_type()
{
str fp = 'Go to the beginning of the current bullet, subbullet or rubric.';

str current_line_type = @current_line_type;

mark_pos;

while(Current_Line_Type == '')
{
  if(@at_bof)
  {
    break;
  }
  up;
  current_line_type = @current_line_type;
}

goto_mark;

return(current_line_type);
}



//;+ Bobs



//;; (skw beginning of rubric)

void
@bor()
{
str fp = 'Go to the beginning of the current rubric.';

find_text(@rubric, 0, _regexp | _backward);

@say(fp);
}



//;;

void
@bobbs()
{
str fp = 'Go to the beginning of the current bullet or big segment.';

find_text(@bullet_or_big_segment, 0, _regexp | _backward);

@say(fp);
}



//;;

void
@@bobs
{
@header;
@bobs;
@footer;
}



//;;

void
@bob()
{
str fp = 'Go to the beginning of the bullet.';

find_text(@bullet, 0, _regexp | _backward);

@say(fp);
}



//;; Deprecated: Please use "@find_previous_bobs" or "@boca" going forward.

str
@bobsr()
{
str fp = 'Go to the beginning of the current bullet, subbullet or rubric.';

str Current_BSR_Type = '';

while(Current_BSR_Type == '')
{
  switch(@first_character(get_line))
  {
    case ';':
      Current_BSR_Type = 'rubric';
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
        Current_BSR_Type = 'rubric';
      }
      break;
    case '-':
      @bol;
      right;
      right;
      if(@current_character == ';')
      {
        Current_BSR_Type = 'rubric';
      }
      break;
    case ':':
      Current_BSR_Type = 'bullet';
      if(@second_character(get_line) == ':')
      {
        Current_BSR_Type = 'subbullet';
      }
      // For batch file rubrics.
      if(@second_character(get_line) == '_')
      {
        switch(lower(Get_Extension(File_name)))
        {
          case 'bat':
            Current_BSR_Type = 'rubric';
        }
      }
      break;
  }
  if(Current_BSR_Type == '')
  {
    up;
  }
}
@bol;

return(Current_BSR_Type);
}



//;;

void
@@bobsr
{
@header;
@bobsr;
@footer;
}



//;; Note: What you may want is: "@find_bobs_or_previous_bs".

str
@boca()
{
str fp = "Go to the beginning of content area.";
str rv = @current_line_type;
while(rv == '' and !@at_bof)
{
  up; 
  rv = @current_line_type;
}
@bol;
return(rv);
}



//;+ Find Previous



//;;

str
@find_previous_bullet()
{
str fp = 'Find previous bullet. Note: this will find the previous, not the current, bullet.';

find_text(@bullet, 0, _regexp | _backward);
if(@current_line > 3)
{
  up;
  find_text(@bullet, 0, _regexp | _backward);
}

return(found_str);
}



//;; (skw bullet freeway, bullet expressway)

str
@find_previous_bobs()
{
str fp = 'Find previous bullet or big segment.';
str rv = '';

int found_Correct_Area = false;

do {
  up;
  @boca;
  rv = @current_line_type;
  switch (rv)
  {
    case 'bullet':
    case 'rubric':
    case 'subrubric':
      found_Correct_Area = true;
      break;
    default:
      up;
  }
  if(found_Correct_Area)
  {
    break;
  }

} while(!@at_bof);

@say(fp + ' (' + rv + ' found.)');
return(rv);
}



//;;

void
@@find_previous_bobs
{
str fp = 'Find previous bullet or big segment.';
@header;
@find_previous_bobs;
@footer;
@say(fp);
}



//;;

str
@find_previous_big_segment()
{
str fp = 'Find previous big segment.';

@bobs;

if(@at_bof)
{
  return('Error: Your are at BOF.'); 
}

up;
@bobs;
return(''); 
}



//;;

str
@find_previous_content_area()
{
str fp = 'Find previous content area.';
@boca;
up;
str rv = @boca;
return(rv);
}



//;;

str
@find_previous_bullet_or_subbull()
{
str fp = 'Find previous bullet or subbullet.';

@bobsr;
up;
str rv = @bobsr;

if(rv == 'rubric')
{
  up;
  rv = @bobsr;
}

@say(fp + ' (' + rv + ' found.)');
return(rv);
}



//;;

str
@find_previous_subbullet()
{
str fp = 'Find previous bullet.';

@bol;
if((Cur_Char == ':') or (Cur_Char == ';'))
{
  left;
}
find_text(@subbullet, 0, _regexp | _backward);
@eoc;

@say(fp);
return(found_str);
}



//;;

void
@@find_previous_content_area
{
@header;
@find_previous_content_area;
@footer;
}



//;; (skw @find_previous_rubric)

void
@find_bor_or_previous_rubric()
{
str fp = "Find BOR or previous rubric.";

int Initial_Line_Number = @current_line_number;

@bor;

if(@current_line_number == Initial_Line_Number)
{
  up;
  @bor;
  if(@current_line_number == Initial_Line_Number)
  {
    fp += " You are at the first rubric in the file.";
  }
}

@eol;

if(lower(Get_Extension(File_Name)) == 's')
{
  @bol;
}

@say(fp);
}



//;;

void
@find_previous_wrapper
{
str fp = 'Find previous.';
str Current_Line_Type = '';
@header;

if(@is_bullet_file)
{
  // The Control Key
  if((key2 == 133) or (Global_Str('Move_Cursor_One_Line_At_A_Time') == 'True'))
  {
    @cursor_up_1_line;
  }
  else  // The control key was not pressed.
  {
    Current_Line_Type = @current_line_type;
    if(Current_Line_Type == '')
    {
      up;
    }
    else
    {
      @find_previous_content_area;
      @eol;
    }
  }
}
else // All non-bullet type files.
{
  if((key2 != 133)) // Control Key
  {
    @cursor_up_1_line;
  }
  else  // The control key was pressed, so do the opposite.
  {
    @find_bor_or_previous_rubric;
  }
}

@footer;
}



//;;

void
@@find_previous_bullet
{
@header;
@find_previous_bullet;
@footer;
}



//;;

void
@@find_previous_big_segment
{
@header;
@find_previous_big_segment;
@footer;
}



//;+ Is Rubric



//;;

int
@is_rubric()
{
str fp = "Current area type is rubric.";

switch(@current_area_type)
{
  case 'rubric':
    return(1); 
    break;
}

return(0);
@say(fp);
}



//;;

int
@is_big_segment()
{
str fp = "Current boundary type is either or a rubric or subrubric.";
switch(@current_area_type)
{
  case 'rubric':
  case 'subrubric':
    return(1); 
    break;
}
return(0);
@say(fp);
}



//;;

int
@is_rubric_or_subrubric()
{
return(@is_big_segment);
}



//;+ Find Next Rubric



//;;

int
@find_next_rubric()
{
str fp = 'Find next rubric.';

int rv;

right;
if(find_text(@rubric, 0, _regexp))
{
  rm('CenterLn');
  rv = 1;
}
else // No more rubrics.
{
  left;
  fp += ' You are at the last Rubric.';
  rv = 0;
}
eol;

@say(fp);
return(rv);
}



//;;

void
@@find_next_rubric()

{
@header;
@find_next_rubric();
@footer;
}



//;+ Add Rubrics and Subrubrics



//;;

void
@add_rubric_above(str lc = parse_str('/1=', mparm_str))
{
str fp = 'Add rubric above.';

if(lc != '')
{
  @find_lc(lc);
}

insert_mode=1;
@bobs;
cr;
cr;
cr;
cr;
up;
up;
up;
up;
text(@rubric_text);
eol;
@say(fp);
}



//;;

void
@add_family_rubric_above(str lc = parse_str('/1=', mparm_str))
{
str fp = 'Add family rubric above.';

if(lc != '')
{
  @find_lc(lc);
}

insert_mode=1;
@bobs;
cr;
cr;
cr;
cr;
up;
up;
up;
up;
text(@family_rubric_text);
eol;
@say(fp);
}



//;;

void
@add_rubric_below(str lc = parse_str('/1=', mparm_str))
{
str fp = 'Add rubric below.';

@find_next_rubric;
@add_rubric_above('');

@say(fp);
}



//;;

void
@add_rubric(str lc = parse_str('/1=', mparm_str))
{
@header;
if(lc == '')
{
  lc = 'ggch';
}
switch(lc)
{
  case 'ch':
    lc = 'ggch';
    break;
  case 'ne':
    lc = 'ggne';
    break;
  default:
}
@find_lc(lc);
@add_rubric_below(lc);
@footer;
}



//;;

void
@@add_rubric(str lc = parse_str('/1=', mparm_str))
{
@header;
@add_rubric(lc);
@footer;
}



//;;

void
@add_subrubric_above()
{
str fp = 'Add subrubric above.';

insert_mode=1;

@bobs;

cr;
cr;
cr;
cr;
up;
up;
up;
up;
text(@subrubric_text);

@say(fp);
}



//;;

void
@add_subrubric_below(str lc = parse_str('/1=', mparm_str))
{
str fp = 'Add subrubric below.';

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

@find_next_big_segment;
@add_subrubric_above;

@say(fp);
}



//;;

void
@add_subrubric(str lc = parse_str('/1=', mparm_str))
{
@add_subrubric_below(lc);
}



//;;

void
@@add_subrubric(str lc = parse_str('/1=', mparm_str))
{
@header;
@add_subrubric_below(lc);
@footer;
}



//;

str
@find_next_small_segment()
{
str fp = 'Find next small segment.';
str rv = 'bullet';

/*
skw
@find_next_bs,
@find_next_bullet_or_subbullet
*/

right;
find_text(@small_segment, 0, _regexp);

if(@next_character == ':')
{
  rv = 'subbullet';
}

@say(fp + '(' + rv + ')');
return(rv);
}



//;

void
@eor()
{
str fp = 'Go to the end of the rubric.';

@find_next_big_segment;
@find_previous_content_area;

@say(fp);
}



//;

str
@query_previous_bsr()
{
str fp = 'Look at previous bullet, subbullet or rubric.';

mark_pos;
@bobsr;
str rv = @find_previous_content_area;
goto_mark;

@say(fp);
return(rv);
}



//; Deprecated. lk#2 Going forward, please use '@find_next_content_area'.

str
@find_next_bsr()
{
str fp = 'Find next bullet, subbullet or rubric.';

str rv = 'rubric';
// If I am on a line before a bullet, the down arrow should advance me one line.
right;

find_text(@bsr, 0, _regexp);
if(found_str == ':')
{
  rv = 'bullet';
  if(@second_character(get_line) == ':')
  {
    rv = 'subbullet';
  }
}

//@eoc;

@say(fp + ' (' + rv + ' found.)');
return(rv);
}



//;

str
@query_next_bsr()
{
str fp = 'Look at next bullet, subbullet or rubric.';

mark_pos;
@bobsr;
str rv = @find_next_bsr;
goto_mark;

@say(fp);
return(rv);
}



//;+ Is Bullet



//;;

int
@is_bullet()
{
str fp = 'Verify that the user is in on a bullet.';
if(@current_area_type != 'bullet')
{
  @say(@constant_not_a_bullet());
  return(0);
}
@say(fp + ' True.');
return(1);
}



//;;

int
@is_subbullet()
{
str fp = 'Verify that the user is on a subbullet.';
if(@current_area_type != 'subbullet')
{
  @say('This macro only works on subbullets.');
  return(0);
}
@say(fp + ' True.');
return(1);
}



//;;

int
@is_bullet_or_subbullet()
{
str fp = 'Verify that the user is on a bullet or subbullet.';
switch(@current_area_type)
{
  case 'bullet':
  case 'subbullet':
    break;
  default:
    @say('This method only works for bullets and subbullets.');
    return(0);
}
@say(fp + ' True.');
return(1);
}



//;

int
@is_bs()
{
// This is an alias function for "@is_bullet_or_subbullet()"
return(@is_bullet_or_subbullet);
}



//;

str
@peek_ahead()
{
str fp = 'Looks ONLY for bullets and rubrics, not subbullets.';

str Return_String = 'rubric';
mark_pos;
while((Cur_Char == ':') or (Cur_Char == ';') or (Cur_Char == '/'))
{
  right;
}

find_text('($)||([])||(^;)||(^//;)', 0, _regexp);
if(@first_character(get_line) == ':')
{
  Return_String = 'bullet';
}
goto_mark;

@say(fp);
return(Return_String);
}



//;

str
@query_next_br()
{
str fp = 'Looks ONLY for bullets and rubrics, not subbullets.';

str Return_String = 'rubric';
mark_pos;
while((Cur_Char == ':') or (Cur_Char == ';') or (Cur_Char == '/'))
{
  right;
}

find_text(@bullet_or_big_segment, 0, _regexp);

if(@first_character(get_line) == ':')
{
  return_string = 'bullet';
}
goto_mark;

@say(fp);
return(return_string);
}



//;

void
@find_next_content_area()
{
str fp = "Find next content area.";
down;
find_text(@content_area, 0, _regexp);
@say(fp);
}



//;

str
@peek_ahead_3()
{
str fp = 'Looks at what the next content area is.';

str return_string = 'rubric';

mark_pos;

@find_next_content_area;

if(@current_character == ':')
{
  return_string = 'bullet';
  right;
}
if(@current_character == ':')
{
  return_string = 'subbullet';
}

goto_mark;

@say(fp);
return(return_string);
}



//;

int
@is_last_bullet()
{
str fp = 'True if the user is on the last bullet of a rubric.';

if(@peek_ahead_3 == 'rubric')
{
  @say('You are on the last bullet.');
  return(1);
}

@say('You are NOT on the last bullet.');
return(0);
}



//;+ Content Area



//;;

void
@@find_next_content_area
{
@header;
@find_next_content_area;
@footer;
}



//;

int
@is_last_small_segment()
{
str fp = 'True if the user is on the last bullet or subbullet of a rubric.';
fp = "Next content area is big segment.";
int rv = 0;

mark_pos;
@find_next_content_area;

if(@is_big_segment)
{
  rv = 1;
}
goto_mark;

return(rv);
}



//;+ Cursor Context Sensitive Movement



//;;

void
@cursor_down_context_sensitively
{
str fp = 'Cursor down in a context sensitive fashion.';

str Current_Line_Type;

int current_Column_Number = @current_Column_Number;

@header;

if(@is_bullet_file && @is_structured_line)
{
  @find_next_content_area;
}
else
{
  down;
}

goto_col(current_Column_Number);

@footer;

@say(fp);
}



//;;

void
@cursor_up_context_sensitively
{
str fp = 'Cursor up in a context sensitive fashion.';

int current_Column_Number = @current_Column_Number;

str Current_Line_Type = '';

@header;

if(@is_bullet_file && @is_structured_line)
{
  @find_previous_content_area;
}
else
{
  up;
}

goto_col(current_Column_Number);

@footer;
@say(fp);
}



//;;

void
@cursor_up_transitionally
{
str fp = 'Cursor up transitionally.';

int current_Column_Number = @current_Column_Number;

str Current_Line_Type = '';

@header;

if(@is_structured_line)
{
  up;
}
else
{
  @boca;
}

goto_col(current_Column_Number);

@footer;
@say(fp);
}



//;;

void
@cursor_down_transitionally
{
str fp = 'Cursor down transitionally.';

int current_Column_Number = @current_Column_Number;

str Current_Line_Type = '';

@header;

if(@is_structured_line)
{
  down;
}
else
{
  @find_next_content_area;
}

goto_col(current_Column_Number);

@footer;
@say(fp);
}



//;;

void
@cursor_up_quickly
{
str fp = 'Cursor up quickly.';

int current_Column_Number = @current_Column_Number;

str Current_Line_Type = '';

@header;

up;
@bobbs;

goto_col(current_Column_Number);

@footer;
@say(fp);
}



//;;

void
@cursor_down_quickly
{
str fp = 'Cursor down quickly.';

int current_Column_Number = @current_Column_Number;

str Current_Line_Type = '';

@header;

if(@is_bullet_file && !@is_structured_line)
{
  down;
  @find_next_content_area;
}
else
{
  @find_next_bullet;
}

goto_col(current_Column_Number);

@footer;
@say(fp);
}



//;

int
@is_bullet_file_descriptive(str &error_message)
{
int is_bullet_Type_File = @is_bullet_File;

if(!is_bullet_Type_File)
{
  error_Message = 'This macro only works on bullet type files.';
}
return(is_bullet_Type_File);
}



//;+ Find Next Bobs



//;;

str
@find_next_bobs()
{
str fp = 'Find next bullet or big segment.';

// (skw find next bullet, find_next_bsr, find_next_br, find_next_bullet_or_rubric, find next 
// bullet or rubric)

str rv;

right;

find_text(@bullet_or_big_segment, 0, _regexp);

rv = @current_line_type;

@eoc;

// I commented the following line because it was causing a pretty bad flicker with
// the Alt+O operation on Oct-15-2009.
return(rv);
}



//;;

void
@@find_next_bobs
{
str fp = 'Find next bullet or big segment.';
@header;
@find_next_bobs;
@footer;
@say(fp);
}



//;+ Highcopy Family (!fyhc)



//;; (skw @copy_bullet)

void
@hc_bullet()
{
str fp = 'Highcopy bullet.';

// Dependency Note: this macro requires that "Customize | Editing | Blocks | Persistent
// Blocks" be enabled.

block_off;

if(@find_next_bobs != 'bullet')
{
  up;
  up;
}
@bol;
left;

block_begin;
@bob;

rm('CenterLn');
rm('CenterLn');

@copy_with_marking_left_on;

@say(fp);
}



//;;

void
@hc_small_segment()
{
str fp = 'Highlight small segment.';

@bobsr;
block_begin;
right;

if(@find_next_bsr == 'rubric')
{
  up;
  up;
}
@bol;
left;
@center_line;
block_end;

@copy_with_marking_left_on;

@say(fp);
}



//;;

void
@hc_subbullet()
{
str fp = 'Highcopy subbullet.';

if(!@is_subbullet)
{
  return();
}

block_off;

if(@find_next_bsr == 'rubric')
{
  up;
  up;
}
@bol;
left;

block_begin;
@boca;

@copy_with_marking_left_on;

@say(fp);
}



//;

int
@count_bullets()
{
str fp = 'Count bullets, returns an integer instead of a string.';
str rv = '';
int Bullet_Counter = 0;
int Initial_Bullet_Number = 0;

if(!@is_bullet_file)
{
  return(0);
}

mark_pos;
int Initial_Line = @current_line_number;
@bobs;

while(@find_next_bobs == 'bullet')
{
  Bullet_Counter++;
  if(@current_line_number <= Initial_Line)
  {
    Initial_Bullet_Number = Bullet_Counter;
  }
}
goto_mark;

rv = 'My Bullet ' + str(Initial_Bullet_Number) + ' of ' + str(Bullet_Counter);
@say(fp + ' ' + rv);
return(Bullet_Counter);
}



//;+ MOR



//;;

void
@mor()
{
str fp = 'Go to the middle of the current rubric.';

int Number_of_Bullets_in_Rubric = @count_bullets;
int Counter = 0;

@bobs;

if(number_of_bullets_in_rubric != 0)
{
  while(counter <= (number_of_bullets_in_rubric / 2))
  {
    @find_next_bullet;
    counter++;
  }

  @bob;
}

@say(fp);
}



//;;

void
@@mor
{
@header;
@mor;
@footer;
}



//;+ Count Lines



//;;

int
@count_lines_in_rubric()
{
str fp = 'Count number of lines in current rubric.';

int First_Line_in_Rubric;
int Last_Line_in_Rubric;
int Number_of_Lines_in_Rubric;

mark_pos;

@bor;
First_Line_in_Rubric = @current_line_number;
@find_next_rubric;
Last_Line_in_Rubric = @current_line_number;
Number_of_Lines_in_Rubric = Last_Line_in_Rubric - First_Line_in_Rubric;

goto_mark;

if(Number_of_Lines_in_Rubric == 0)
{
  Number_of_Lines_in_Rubric = 1;
}

return(Number_of_Lines_in_Rubric);
}



//;;

int
@count_lines_in_bs()
{
str fp = 'Count number of lines in big segment.';

int first_line_in_bs;
int last_line_in_bs;
int number_of_lines_in_bs = 0;

mark_pos;

@bobs;

first_line_in_bs = @current_line_number;
@find_next_big_segment;
last_line_in_bs = @current_line_number;
number_of_lines_in_bs = last_line_in_bs - first_line_in_bs;

goto_mark;

if(number_of_lines_in_bs == 0)
{
  number_of_lines_in_bs = 1;
}

return(Number_of_Lines_in_bs);
}



//;

int
@count_rubrics()
{
str fp = 'Count the number of rubrics in this file.';

int Number_of_Rubrics = 0;
int Previous_Line_Number;

mark_pos;

@bof;
down;

while(true)
{
  Previous_Line_Number = @current_line_number;
  @find_next_big_segment;
  Number_of_Rubrics++;

  // We haven't moved, so let's get out of here.
  if(Previous_Line_Number == @current_line_number)
  {
    break;
  }
}

Number_of_Rubrics--;

if(@is_s_file)
{
  Number_of_Rubrics--;
}

goto_mark;

@say(fp + ' (' + str(Number_of_Rubrics) + ')');
return(Number_of_Rubrics);
}



//;

str
@count_bullets_string()
{
str fp = 'Count bullets.';
str rv = '';
int Bullet_Counter = 0;
int Initial_Bullet_Number = 0;

mark_pos;
int Initial_Line = @current_line_number;
@bobs;

while(@find_next_bobs == 'bullet')
{
  Bullet_Counter++;
  if(@current_line_number <= Initial_Line)
  {
    Initial_Bullet_Number = Bullet_Counter;
  }
}
goto_mark;

rv = 'Bullet ' + str(Initial_Bullet_Number) + ' of ' + str(Bullet_Counter);
return(rv);
}



//;

str
@count_subbullets_str() trans2
{
str fp = 'Count subbullets.';
str rv = '';
int Subbullet_Counter = 0;
int Subbullet_Number = 0;

mark_pos;
int Initial_Line = @current_line_number;
@bob;

while(@find_next_small_segment != 'bullet')
{
  Subbullet_Counter++;
  if(@current_line_number <= Initial_Line)
  {
    Subbullet_Number = Subbullet_Counter;
  }
}
goto_mark;

rv = 'Subbullet ' + str(Subbullet_Number) + ' of ' + str(Subbullet_Counter);

@say(fp + ' ' + rv);
return(rv);
}



//;

int
@count_subbullets_int()
{
str fp = 'Count subbullets.';
str rv = '';
int Subbullet_Counter = 0;
int Initial_Bullet_Number = 0;

mark_pos;
int Initial_Line = @current_line_number;
@bob;

while(@find_next_small_segment != 'bullet')
{
  Subbullet_Counter++;
  if(@current_line_number <= Initial_Line)
  {
    Initial_Bullet_Number = Subbullet_Counter;
  }
}
goto_mark;

@say(fp + ' ' + rv);
return(Subbullet_Counter);
}



//;

str
@get_current_ln_num_in_rubric()
{
str fp = "Get current line number in rubric.";

mark_pos;
int Current_Line_Number = @current_line_number;
int Rubric_Line_Number = 0;
@bobs;
while(Current_Line_Number > @current_line_number)
{
  down;
  Rubric_Line_Number++;
}
goto_mark;

return(str(Rubric_Line_Number));
}



//;

void
@report_current_ln_num_in_rubric
{
str fp = "Report current line number in rubric.";
@header;
@say(fp + ' (' + @get_current_ln_num_in_rubric + ')');
@footer;
}



//;+ Look Up Information



//;;

void
@look_up_bullet_information
{
str fp = 'Look up bullet information.';

@header;

if(!@is_bullet_file)
{
  return();
}

str Message_to_User;
str subbullets_string;

int Initial_Line_Number = @current_line_number;

@bob;

int Bullet_Header_Line_Number = @current_line_number;
int Number_of_Lines_in_Bullet = 0;

str Bullet_Heading = Get_Line;

@find_next_bobs;

Number_of_Lines_in_Bullet += @current_line_number - Bullet_Header_Line_Number - 1;

real Decimal_Number_of_Lines = real_i(Number_of_Lines_in_Bullet) / 65.0;

goto_line(Initial_Line_Number);

subbullets_string = @count_subbullets_str + ', ';

message_to_user = '"' + @left(bullet_heading, 30) + '", ' + subbullets_string + 
rstr(Decimal_Number_of_Lines, 3, 1) + " Pages ";

@footer;
@say("Bullet Info: " + message_to_user);
}



//;;

void
@look_up_bs_information()
{
str fp = 'Calculate the size of the current big segment.';

// This macro does work on "s" and "sql" files.

str rubric_heading;

str Filename = Truncate_Path(File_Name);

if(Filename == 'JD.asc')
{
  @say('You are in Junk Drawer. There are no true rubrics here.');
  @footer;
  return();
}

mark_pos;

@bobs;

int Rubric_Header_Line_Number = @current_line_number;
int Number_of_Lines_in_Rubric = 0;

if(@is_s_file)
{
  down;
  down;
  down;
  number_of_lines_in_rubric -= 2;
}

if(@is_sql_file)
{
  down;
  down;
  down;
  down;
  down;
  down;
  down;

}

rubric_heading = get_line;

str original_area_type = @current_area_type;

@find_next_big_segment;
number_of_lines_in_rubric += @current_line_number - rubric_header_line_number - 3;

// "Bastard" big segment recognition code.
str header_prefix = '';
str child_area_type = @current_area_type;

if(child_area_type == 'subrubric')
{
  if((original_area_type == 'rubric') && (!xpos('+', rubric_heading, 1)))
  {
    header_prefix = 'Bastard ';
  }
}

if((original_area_type == 'rubric') && (child_area_type == 'rubric'))
{
  header_prefix = 'Childless ';
}

goto_mark;

real decimal_number_of_lines = real_i(number_of_lines_in_rubric) / 65.0;
if(decimal_number_of_lines < 0.0)
{
  decimal_number_of_lines = 0.0;
}

str bullets_string = '';
if(@is_bullet_file)
{
  bullets_string = @count_bullets_string + ', ';
}

str message_to_user = '"' + @left(rubric_heading, 30) + '", ' + bullets_string + 
rstr(decimal_number_of_lines, 3, 1) + " Pages ";

@say(header_prefix + "BS Info: " + message_to_user);
}



//;;

void
@@look_up_bs_information
{
@header;
@look_up_bs_information;
@footer;
}



//;;

int
@count_big_segments()
{
str fp = "Count big segments.";

int big_Segment_Counter = 0;

mark_pos;

@bor;

@find_next_big_segment;

if(@current_area_type != 'subrubric')
{
  goto_mark;
  return(big_Segment_Counter); 
}

while(@current_line_type == 'subrubric')
{
  Big_Segment_Counter++; 
  @find_next_big_segment;
}

goto_mark;

@say(fp + ' Number of big segments: ' + str(Big_Segment_Counter));
return(Big_Segment_Counter);
}



//;;

int
@get_current_bs_index()
{
str fp = "Get current big segment index.";

int rv = 0;

mark_pos;

@bobs;
int current_Line_Number = @current_Line_Number;

if(@current_Area_Type == 'rubric')
{
  goto_mark;
  return(rv);
}

@bor;
@find_next_big_segment;
rv++;

while(current_Line_Number != @current_Line_Number)
{
  @find_next_big_segment; 
  rv++;
}

goto_mark;

@say(fp);
return(rv);
}



//;;

int
@is_last_big_segment()
{
str fp = "Is last big segment.";
int rv = false;

if(@get_current_bs_index == @count_big_segments)
{
  rv = true;
}

@say(fp + ' ' + ' (rv = ' + str(rv) + ')');
return(rv);
}



//;;

void
@look_up_rubric_information()
{
str fp = 'Calculate current rubric name and size.';

str Rubric_Heading;

str Filename = Truncate_Path(File_Name);

if(Filename == 'JD.asc')
{
  @say('You are in Junk Drawer. There are no true rubrics here.');
  @footer;
  return();
}

mark_pos;

@bor;

int Rubric_Header_Line_Number = @current_line_number;
int Number_of_Lines_in_Rubric = 0;

if(@is_s_file)
{
  Number_of_Lines_in_Rubric -= 2;
}

if(@is_sql_file)
{
  down;
  down;
  down;
  down;
  down;
  down;
  down;

}

Rubric_Heading = Get_Line;

@find_next_rubric;
Number_of_Lines_in_Rubric += @current_line_number - Rubric_Header_Line_Number - 3;
goto_mark;

real Decimal_Number_of_Lines = real_i(Number_of_Lines_in_Rubric) / 65.0;

str subrubrics_string = 'Subrubric ' + str(@get_current_bs_index) + ' of ' + 
str(@count_big_segments);

str message_to_user = '"' + @left(rubric_heading, 30) + '", ' + subrubrics_string + ', ' + 
rstr(decimal_number_of_lines, 3, 1) + " Pages ";

@say("Rubric Info: " + message_to_user);
}



//;;

void
@@look_up_rubric_information
{
@header;
@look_up_rubric_information;
@footer;
}



//;

void
@cut_bullet()
{
str fp = 'Cut bullet to buffer.';

@hc_bullet;
rm('CutPlus /M=1');

@say(fp);
}



//;

void
@copy_and_paste_bullet()
{
str fp = "Copy and paste bullet.";
@hc_bullet;
@copy;
@paste;
up;
@bob;
@say(fp);
}



//;+ Cursor To



//;;

void
@cursor_to_my_bof()
{
str fp = 'Cursor to my BOF.';

int current_Column_Number = @current_Column_Number;

@bof;

if(@is_bullet_File)
{
  @find_next_bullet;

  // This code block makes it so that for "broadcast" files the cursor isn't uselessly 
  // left near EOF.
  down;
  if(at_eof)
  {
    goto_line(1);
  }
  else
  {
    up;
  }
}

goto_col(current_Column_Number);
@say(fp);
}



//;; (skw smart_place, smart place, find my place)

void
@put_cursor_somewhere_useful()
{
str fp = "Put the cursor somewhere useful.";

if(!@is_bullet_file)
{
  return();
}

int current_column = @current_column;

if(!@is_structured_line)
{
  @bobbs;
}

if(@first_4_characters(get_line) == ';Gen')
{
  @find_next_bullet;
}

goto_col(current_column);

}



//;+ Delete Bullet and Subbullet



//;;

str
@delete_bullet()
{
str fp = 'Delete bullet.';

@hc_bullet;
delete_block;

@put_cursor_somewhere_useful;

@eoc;
@say(fp);
return(fp);
}



//;;

str
@delete_subbullet()
{
str fp = "Delete subbullet.";

if(!@is_subbullet)
{
  return('Not a subbullet.');
}

@hc_small_segment;
delete_block;

@boca;

@eol;

@say(fp);
return(fp);
}



//;

void
@paste_as_bullet_below_here()
{
str fp = 'Paste as bullet below here.';

@find_next_blank_line;
down;
goto_col(1);
rm('paste');

@say(fp);
}



//;+ Visiual Studio Macros



//;;

void
@delete_region_directives()
{
str fp = "Delete region directives.";

if(!@is_text_file)
{
  return();
}
int number_of_replacements = @replace_string_in_file_int('\#.*region.*$', '');
fp = fp + ' Number of replacements: ' + str(number_of_replacements) + '.';
@say(fp);
}



//;;

void
@delete_empty_summary_xml_commts()
{
str fp = "Delete empty summary XML comments.";

if(!@is_text_file)
{
  return();
}
str sc = '/// <summary>$        /// </summary>';
int number_of_replacements = @replace_string_in_file_int(sc, '');
fp = fp + ' Number of replacements: ' + str(number_of_replacements) + '.';
@say(fp);
}



//;;

void
@format_vstudio_code_file()
{
str fp = 'Format Visual Studio code file.";
';

if(!@is_text_file)
{
  return();
}

@delete_region_directives;
@delete_empty_summary_xml_commts;
@delete_blank_lines;
@select_all;
@copy;

@say(fp);
}



//;;

void
@put_catch_keyword_on_newline()
{
str fp = "Put catch keyword on newline.";
str rs;
str sc;
str so;
int efbo = true; // execute first block only

sc = '} catch';
rs = '}$catch';
@eol;

if(efbo){ so = @replace_all_occurrs_inf_no_tof(sc, rs); efbo = 0; }
if(efbo){ so = @replace_next_occurrence_only(sc, rs); efbo = 0; }
if(efbo){ @seek_next(sc, so); efbo = false; }
if(efbo){ int is_found = @seek_in_all_files_2_arguments(sc, fp); efbo = 0; }

@say(found_str);
@say(so);
@say(fp);
}



//;;

void
@put_else_keyword_on_newline()
{
str fp = "Put else keyword on newline.";
str rs;
str sc;
str so;
int efbo = true; // execute first block only

sc = '} else';
rs = '}$else';
@eol;

if(efbo){ so = @replace_all_occurrs_inf_no_tof(sc, rs); efbo = 0; }
if(efbo){ so = @replace_next_occurrence_only(sc, rs); efbo = 0; }
if(efbo){ @seek_next(sc, so); efbo = false; }
if(efbo){ int is_found = @seek_in_all_files_2_arguments(sc, fp); efbo = 0; }

@say(found_str);
@say(so);
@say(fp);
}



//;;

void
@put_opening_braces_on_new_line()
{
str fp = "Put opening braces on new line.";
str rs;
str sc;
str so;
int efbo = true; // execute first block only

sc = '(\)) ({)$';
rs = '\0$  \1';
@eol;

if(efbo){ so = @replace_all_occurrs_inf_no_tof(sc, rs); efbo = 0; }
if(efbo){ so = @replace_next_occurrence_only(sc, rs); efbo = 0; }
if(efbo){ @seek_next(sc, so); efbo = false; }
if(efbo){ int is_found = @seek_in_all_files_2_arguments(sc, fp); efbo = 0; }

@say(found_str);
@say(so);
@say(fp);
}



//;;

void
@format_eclipse_code_file()
{
str fp = 'Format Eclipse code file.';

if(!@is_text_file)
{
  return();
}

@put_catch_keyword_on_newline;
@put_else_keyword_on_newline;
@delete_blank_lines;
@delete_blank_line_at_eof;
@put_opening_braces_on_new_line;

@select_all;
@copy;

@say(fp);
}



//;;

void
@delete_carriage_returns()
{
str fp = "Delete text eof characters but NOT paragraph separating ones.";

if(!@is_text_file)
{
  return();
}

str sc = '(.)$(.)';
str rs = '\0 \1';

str so = @replace_all_occurrs_inf_no_tof(sc, rs);
str so = @replace_all_occurrs_inf_no_tof("  ", " ");

@tof;

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

@select_all;

@copy;

@say(fp);
}



//;+ Formatting Pasted Text Family



//;;

void
@format_data_sent_via_mobile_dev()
{
str fp = 'Prepare google doc.';

if(!@is_text_file)
{
  return();
}

str rs;
str replacement_description;

@replace_all_occurrences_in_file('^0', ":");
@replace_all_occurrences_in_file('((^)||( ))(arent)(( )||($))', '\0aren' + char(39) + 't\4');
@replace_all_occurrences_in_file('((^)||( ))(b)(( )||($)||(\?))', '\0be\4');
@replace_all_occurrences_in_file('blk', '[blank]');
@replace_all_occurrences_in_file('((^)||( ))(bout)(( )||($))', '\0about\4');
@replace_all_occurrences_in_file('((^)||( ))(c)(( )||($))', '\0see\4');
@replace_all_occurrences_in_file('((^)||( ))(cant)(( )||($))', '\0can' + char(39) + 't\4');
@replace_all_occurrences_in_file('((^)||( ))(cud)(( )||($))', '\0could\4');
@replace_all_occurrences_in_file('((^)||( ))(cudnt)(( )||($))', '\0couldn' + char(39) + 't\4');
@replace_all_occurrences_in_file('((^)||( ))(cudve)(( )||($))', '\0could' + char(39) + 've\4');
@replace_all_occurrences_in_file('((^)||( ))(cuz)(( )||($))', '\0because\4');
@replace_all_occurrences_in_file('didnt', "didn't");
@replace_all_occurrences_in_file('((^)||( ))(doesnt)(( )||($))', '\0doesn' + char(39) + 't\4');
@replace_all_occurrences_in_file('((^)||( ))(dont)(( )||($))', '\0don' + char(39) + 't\4');
@replace_all_occurrences_in_file('((^)||( ))(fr)(( )||($))', '\0from\4');
@replace_all_occurrences_in_file('((^)||( ))(f)(( )||($))', '\0of\4');

@replace_string_in_file_cs(' i ', ' I ');
@replace_string_in_file_cs('^i ', 'I ');

@replace_all_occurrences_in_file('((^)||( ))(im)(( )||($))', '\0i' + char(39) + 'm\4');
@replace_all_occurrs_inf_no_tof('\.\.', ":");
@replace_all_occurrences_in_file('^ive ', "I've ");
@replace_all_occurrences_in_file(' ive ', " I've ");
@replace_all_occurrences_in_file('^itll', "it'll");
@replace_all_occurrences_in_file('isnt', "isn't");
@replace_all_occurrences_in_file('((^)||( ))(m)(( )||($))', '\0am\4');
@replace_all_occurrences_in_file('((^)||( ))(n)(( )||($))', '\0and\4');
@replace_all_occurrences_in_file('((^)||( ))(nd)(( )||($))', '\0and\4');
@replace_all_occurrences_in_file('((^)||( ))(nto)(( )||($))', '\0into\4');
@replace_all_occurrences_in_file('((^)||( ))(nuther)(( )||($))', '\0another\4');
@replace_all_occurrences_in_file('((^)||( ))(ones)(( )||($))', '\0one' + char(39) + 's\4');
@replace_all_occurrences_in_file('ouldnt', "ouldn't");
@replace_all_occurrences_in_file('((^)||( ))(r)(( )||($))', '\0are\4');
@replace_all_occurrences_in_file(' s ', " is ");
@replace_all_occurrences_in_file('((^)||( ))(shud)(( )||($))', '\0should\4');
@replace_all_occurrences_in_file('((^)||( ))(shudve)(( )||($))', '\0should' + char(39) + 've\4');
@replace_all_occurrences_in_file('thats', "that's");
@replace_all_occurrences_in_file('theres ', "there's ");
@replace_all_occurrences_in_file('((^)||( ))(u)(( )||($))', '\0you\4');
@replace_all_occurrences_in_file('((^)||( ))(ur)(( )||($))', '\0your\4');
@replace_all_occurrences_in_file('((^)||( ))(u r)(( )||($))', '\0you' + char(39) + 're\4');
@replace_all_occurrences_in_file('via CloudMagic Email', "");
@replace_all_occurrences_in_file('^w ', "with ");
@replace_all_occurrences_in_file(' w ', " with ");
@replace_all_occurrences_in_file('((^)||( ))(weve)(( )||($))', '\0we' + char(39) + 've\4');
@replace_all_occurrences_in_file('((^)||( ))(wasnt)(( )||($))', '\0wasn' + char(39) + 't\4');
@replace_all_occurrences_in_file('((^)||( ))(whats)(( )||($))', '\0what' + char(39) + 's\4');
@replace_all_occurrences_in_file(' wo ', " without ");
@replace_all_occurrences_in_file('((^)||( ))(wont)(( )||($))', '\0won' + char(39) + 't\4');
@replace_all_occurrences_in_file('((^)||( ))(wud)(( )||($))', '\0would\4');
@replace_all_occurrences_in_file('((^)||( ))(wudnt)(( )||($))', '\0wouldn' + char(39) + 't\4');
@replace_all_occurrences_in_file('((^)||( ))(wudve)(( )||($))', '\0would' + char(39) + 've\4');
@replace_all_occurrences_in_file('youre', "you're");
@replace_all_occurrences_in_file('youll', "you'll");
@replace_all_occurrences_in_file('youve', "you've");
@replace_string_in_file_int(@mobile_colon(replacement_description, rs), rs);

@format_file;

@add_colons;

@word_wrap_file;

eof;
cr;
cr;

@replace_2_blank_lines_with_1;

rm('Block^SelectAll');
@copy;
@bof;

@say(fp);
}



//;;

void
@format_data_for_monthly_itin()
{
str fp = 'Format data for monthly itinerary.';

if(!@is_text_file)
{
  return();
}

@get_date
@replace_all_occurrences_in_file('\[Month Name\]', @left(@get_formatted_date, 3));

eof;
cr;
cr;

@replace_2_blank_lines_with_1;

rm('Block^SelectAll');
@copy;
@bof;

@say(fp);
}



//;;

void
@format_data_2()
{
str fp = 'Format data 2.';

if(!@is_text_file)
{
  return();
}

@replace_all_occurrences_in_file('\[Date Name As Function Name\]', @get_formatted_date_as_fct_name);
@replace_all_occurrences_in_file('\[Date Name\]', @get_formatted_date);
@replace_all_occurrences_in_file('\[Time Name\]', @get_formatted_time_with_no_pm);

eof;
cr;

rm('Block^SelectAll');
@copy;
@bof;

@say(fp);
}



//;+ Open J File Family (new file family, new j file family)



//;;

void
@open_j_file_in_an_empty_state
{
str fp = "Open J File in an empty state.";
@header;
@open_file('c:\a\j');
@select_all;
delete_block;
@footer;
@say(fp);
}



//;;

void
@open_j_file_with_pasted_text()
{
str fp = "Open J File with pasted text.";
@open_file('c:\a\j');
@select_all;
delete_block;
@paste;
@bof;
@say(fp);
}



//;;

void
@@open_j_file_with_pasted_text
{
@header;
@open_j_file_with_pasted_text;
@footer;
}



//;;

void
@paste_trace
{
str fp = "Paste trace.";
@header;

// fcd: Sep-16-2016

//Last Updated: Sep-20-2016

@open_j_file_with_pasted_text();
@tof;
cr;
down;
cr;

@hard_format_long_lines_in_file();
@tof;
down;

@footer;
@say(fp);
}



//;

void
@process_visual_studio_file
{
str fp = "Process Visual Studio code file.";

// fcd: Apr-17-2015

@header;

@create_timestamped_file;

@paste;

@bof;

@format_vstudio_code_file;

@close_and_save_file_wo_prompt;

@footer;

@say(fp);
}



//;

void
@process_eclipse_file
{
str fp = "Process Eclipse code file.";

// fcd: Aug-29-2016

@header;

@create_timestamped_file;

@paste;

@bof;

@format_eclipse_code_file;

@close_and_save_file_wo_prompt;

@footer;

@say(fp);
}



//;

void
@fix_fat_colon()
{
str fp = "Fix fat colon or semicolon.";

if(!@is_bullet_file)
{
  return();
}

mark_pos;

@find_next_small_segment;
up;
up;

while(true)
{
  if(length(get_line) == 0)
  {
    del_line;
    up;
  }
  else
  {
    break;
  }
}

goto_mark;

@say(fp);
}



//;+ Paste



//;;

void
@paste_after()
{
str fp = 'Paste after.';

// This applies to bullets. I don't want to be pasting content in the middle of a bullet
// family.

if(!@is_content_area_file)
{
  return();
}

right;
str found_string = @find_next_bobs;
if((found_string == 'rubric') or (found_string == 'subrubric'))
{
  up;
  up;
}
@bol;
rm('paste');
@bobsr;

@say(fp);
}



//;;

void
@@paste_after
{
@header;
@paste_after;
@footer;
}



//;;

void
@import_and_format_innovation_da
{
str fp = "Import and format innovation data.";

@header;

@create_timestamped_file;

cr;
@paste;

@format_data_sent_via_mobile_dev;

@close_and_save_file_wo_prompt;

rm("@open_file_with_writability /FN=" + get_environment('reach out') + "\\ne.asc");

tof;
@paste_after;
tof;
@fix_fat_colon;
@find_next_big_segment;
@bol;
@cursor_to_my_bof

@footer;
@say(fp);
}



//;;

void
@multiedit_paste()
{
str fp = 'Paste from buffer using the Multi-Edit command.';
rm('PastePlus');
block_off;
}



//;;

void
@paste_after_with_subbullet()
{
str fp = 'Paste after current BSR while converting the pasted text into a subbullet, if 
  appropriate.';

int is_bullet_or_subbullet = false;

if(@is_bullet_or_subbullet)
{
  is_bullet_or_subbullet = true;
}

right;
if(@find_next_bsr == 'rubric')
{
  up;
  up;
}
@bol;
@multiedit_paste;

// It only makes sense to add a colon in this case.
if(is_bullet_or_subbullet)
{
  goto_col(2);
  if(@is_bullet)
  {
    text(':');
    //fp = fp + ": Code Path 1"; 
  }
}
rm('reformat');

@find_previous_content_area;

@say(fp);
}



//;;

void
@paste_before_with_subbullet
{
str fp = 'Paste before and turn the bottom family into a subbullet.';

@header;

if(@is_bullet)
{
  @bob;
  @paste;
  text(':');
  @bob;
  @eoc;
}
else
{
  @bol;
  @paste;
  left;
  @boca;
  right;
  if(@current_character != ':')
  {
    text(':');
  }
  @say(fp);
  return();
}

@footer;
@say(fp);
}



//;

void
@@paste_after_with_subbullet
{
@header;
@paste_after_with_subbullet;
@footer;
}



//;

void
@paste_to_eor()
{
str fp = 'Paste block to the last position in the rubric.';

@find_next_big_segment;
up;
up;
rm('paste');

@say(fp);
}



//;

void
@go_to_the_first_bullet_in_rub
{
str fp = "Go to the first bullet in the rubric.";

if(!@is_bullet_file)
{
  return();
}

@header;

@bobs;

@find_next_bullet;

@footer;
@say(fp);
}



//;

void
@listmgr_say_version
{
str fp = "ListMgr.s v. Mar-9-2010.";

@say(fp)
}



//;

void
@fix_fat_rubric();
{
str fp = "Fix fat rubric.";

str Replacement_Description = '';
str rs = '';

if(@peek_ahead == 'rubric')
{
  mark_pos;
  @replace_string_in_file_int(@fat_rubric(Replacement_Description, rs), rs);
  goto_mark;
}

@say(fp);
}



//;

void
@hc_big_segment_content()
{
str fp = 'Highcopy big segment content.';

if(!@is_bullet_file)
{
  return();
}

if(!@count_bullets)
{
  @say(fp + ' This big segment has no content, or bullets at least.');
  return(); 
}

@find_next_big_segment;
@bol;
up;
up;
up;
block_begin;
@bobs;
@find_next_bullet;
@copy_with_marking_left_on;

@say(fp);
}



//;

void
@cut_subbullet()
{
str fp = 'Cut BS to buffer.';

@hc_small_segment;
@cut;

@say(fp);
}



//;+ Move bullets (!movebullets)



//;;

void
@move_bullet_to_lc_wme(str lc = parse_str('/1=', mparm_str))
{
str fp = 'Move bullet to lc with me.';

int search_criterion_was_found = 0;
int Initial_Window = @current_window;
int initial_column = @current_column;

if(!@is_bullet_file)
{
  return();
}

if(!@is_bullet_or_subbullet)
{
  return();
}

if(@text_is_selected)
{
  @cut;
}
else
{
  @cut_bullet;
}

str so = @find_lc_core(lc, search_criterion_was_found, fp);

if(search_criterion_was_found)
{
  if(@file_is_read_only(fp))
  {
    switch_window(Initial_Window);
    @paste;
  }
  else
  {
    @paste_as_bullet_below_here;
    fp += ' ' + so;
  }
}
else
{
  switch_window(Initial_Window);
  @paste;
  @bob;
  @find_previous_bullet;
  fp += ' ' + so;
}

goto_col(initial_column);

@say(fp);
}



//;;

void
@@move_bullet_to_lc_wme(str lc = parse_str('/1=', mparm_str))
{
@header;
@move_bullet_to_lc_wme(lc);
@footer;
}



//;;

void
@cut_and_go_to_lc(str parameter = parse_str('/1=', mparm_str))
{
str fp = 'Move bullet to launch code alone.';

if(!@is_bullet_file)
{
  return();
}

@header;

@cut_bullet;

int search_criterion_was_found = 0;
int Initial_Window = @current_window;

mark_pos;

str so = @find_lc_core(parameter, search_criterion_was_found, fp);

if(search_criterion_was_found)
{
  if(@file_is_read_only(fp))
  {
    switch_window(Initial_Window);
    @paste;
    pop_mark;
  }
  else
  {
    @paste_as_bullet_below_here;
    switch_window(Initial_Window);
    goto_mark;
    @bobsr;
    fp += ' ' + so;
  }
}
else
{
  switch_window(Initial_Window);
  @paste;
  @bob;
  fp += ' ' + so;
  pop_mark;
}

@footer;
@say(fp);
}



//;;

void
@move_bullet_to_lc_alone(str lc = parse_str('/1=', mparm_str))
{
str fp = 'Move bullet to lc alone. (' + lc + ')';

@save_location;

@move_bullet_to_lc_wme(lc);

@restore_location;

if(!@is_structured_line)
{
  @boca;
}

@say(fp);
}



//;;

void
@@move_bullet_to_lc_alone(str sc = parse_str('/1=', mparm_str))
{
@header;
@move_bullet_to_lc_alone(sc);
@footer;
}



//;

void
@move_bullet_to_next_rubric_chro
{
str fp = 'Move bullet to next rubric, while preserving the chronological order in
  which the bullet was executed.';
@header;

mark_pos;
@cut_bullet;
@find_next_big_segment;
@find_next_big_segment;
up;
up;
@bol;
@paste;
goto_mark;

@footer;
@say(fp);
}



//;

void
@delete_next_rubric_header()
{
str fp = 'Delete next rubric header.';

if(!@is_bullet_File)
{
  return();
}

mark_pos;
@find_next_big_segment;
@find_next_blank_line;
@bol;
str_block_begin;
@bobs;
@bol;
block_end;
delete_block;
@delete_previous_line;
@delete_previous_line;
@delete_previous_line;
goto_mark;

@say(fp);
}



//;

str
@look_previous()
{
str fp = "Returns the previous BSR's line type.";

str em;
if(!@is_bullet_File_Descriptive(em))
{
  return(em);
}

mark_pos;
@find_previous_content_area;
str Current_Line_Type = @current_area_type;
goto_mark;

return(Current_Line_Type);
}



//;+ Find Bobs and Bor



//;;

void
@find_bobs_or_previous_bs()
{
str fp = "Find the beginning of this or the previous big segment.";

int Initial_Line_Number = @current_line_number;

@bobs;

if(@current_line_number == Initial_Line_Number)
{
  up;
  @bobs;
  if(@current_line_number == Initial_Line_Number)
  {
    fp += " You are at the first rubric in the file.";
  }
}

switch(lower(Get_Extension(File_Name)))
{
  case 'config':
    @bol;
    break;
  default:
    @eol;
}

@say(fp);
}



//;;

void
@@find_bobs_or_previous_bs
{
@header;
@find_bobs_or_previous_bs;
@footer;
}



//;;

void
@@find_bor_or_previous_rubric
{
@header;
@find_bor_or_previous_rubric;
@footer;
}



//;

void
@@find_next_bullet
{
@header;
@find_next_bullet;
@footer;
}



//;

void
@convert_subbullet_to_bullet
{
str fp = 'Convert subbullet to bullet.';

if(!@is_subbullet)
{
  return();
}

@header;

@cut_subbullet;

// This is needed in the case where I just cut the last subbullet.
if(!@is_bullet)
{
  @bob;
}

@paste;
@bol;
@find_previous_subbullet;
@bol;
del_char;

@footer;

@say(fp);
}



//;

void
@paste_to_remote_eor_wme
{
str fp = 'Paste to remote EOR with me.';
@header;

int search_criterion_was_found = 0;
int Initial_Window = @current_window;
int Initial_Line_Number = @current_line_number;
int initial_column = @current_column;

str so = @find_lc_core('', search_criterion_was_found, fp);

if(search_criterion_was_found)
{
  if(@file_is_read_only(fp))
  {
    switch_window(Initial_Window);
    @paste;
  }
  else
  {
    @eor;
    @paste;
    switch_window(Initial_Window);
    goto_col(initial_column);
    goto_line(Initial_Line_Number);
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
@@find_next_rubric
{
@header;
@find_next_big_segment;
@footer;
}



//;

void
@find_first_bullet_in_rubric()
{
str fp = 'Find first bullet in rubric.';

@bobs;
@find_next_bullet;

@say(fp);
}



//;

void
@find_duplicate_bullets_in_sr
{
str fp = 'Find duplicate bullets in a sorted rubric.';

if(!@is_bullet_file)
{
  return();
}

@header;

int Duplicate_Found = false;
str First_Bullet;
str Second_Bullet;

@bobs;

while(true)
{
  if(@find_next_bobs != 'bullet')
  {
    break;
  }
  First_Bullet = get_line;

  if(@find_next_bobs != 'bullet')
  {
    break;
  }
  Second_Bullet = get_line;

  @bob;

  if(First_Bullet == Second_Bullet)
  {
    Duplicate_Found = true;
    break;
  }
}

if(Duplicate_Found)
{
  fp += ' Duplicate found.';
}
else
{
  fp += ' No duplicates found.';
  @bobs;
}

@footer;
@say(fp);
}



//;

void
@go_to_the_last_rubric
{
str fp = 'Go to the last rubric.';

if(!@is_bullet_file)
{
  return();
}

@header;

eof;
@bobs;

@footer;
@say(fp);
}



//;

void
@go_to_biggest_rubric
{
str fp = 'Go to biggest rubric.';
@header;

int Biggest_Rubric = 0;
int Biggest_Rubric_Line_Number = 0;
int Rubric_Size = 0;

tof;
do
{
  if(Rubric_Size > Biggest_Rubric)
  {
    Biggest_Rubric = Rubric_Size;
    Biggest_Rubric_Line_Number = @current_line_number;
  }
  @find_next_big_segment;
  Rubric_Size = @count_lines_in_rubric;
} while(Rubric_Size > 0);

fp += ' Biggest rubric found at line: ' + str(Biggest_Rubric_Line_Number) + '.';

goto_line(Biggest_Rubric_Line_Number);

@footer;
@say(fp);
}



//; (skw short_rubrics, short rubrics)

int
@find_small_rubrics()
{
str fp = 'Find small rubrics.';

@header;

while(!at_eof)
{
  @find_next_big_segment;
  down;
  if(at_eof)
  {
    break;
  }
  if(@count_lines_in_rubric < 54)
  {
    fp += ' Small rubric found.';
    return(true);
  }
}

@footer;

@say(fp + ' NOT found.');
return(false);
}



//;

void
@convert_subbullets_to_bullets
{
str fp = 'Convert ALL subbullets to bullets in current rubric.';
@header;

if(!@is_bullet_file)
{
  return();
}

int Number_of_Subbullets_Converted = 0;

@bobs;
str Next_BSR = @find_next_bsr;
while(Next_BSR != 'rubric')
{
  if(Next_BSR == 'subbullet')
  {
    @bol;
    @delete_character;
    Number_of_Subbullets_Converted++;
  }
  Next_BSR = @find_next_bsr;
}

@bobs;

@footer;
@say(fp + ' Number of conversions: ' + str(Number_of_Subbullets_Converted) + '.');
}



//;

void
@find_large_subbullet_collection
{
str fp = 'Find large subbullet collections.';
@header;

while(@find_next_bullet != 'at_eof')
{
  if(@count_subbullets_int() > 30)
  {
    fp += ' Found.';
   break;
  }
}

@footer;
@say(fp);
}



//;

void
@fix_small_rubrics
{
str fp = 'Fix small rubrics.';
@header;

if(@find_small_rubrics)
{
  @delete_next_rubric_header;
}

@footer;
@say(fp);
}



//;+ Moving Bullets



//;;

void
@copy_bullet_to_next_mor_alone
{
str fp = 'Copy bullet to next MOR alone.';

if(!@is_bullet_file)
{
  return();
}

int Initial_Line_Number = @current_line_number;
int initial_column = @current_column;

@header;

@hc_bullet;

@find_next_big_segment;

@mor;

@paste_as_bullet_below_here;

goto_line(initial_line_number);
goto_col(initial_column);

@footer;
@say(fp);
}



//;+ Bullet Action Model



//;;

str
@digits_only(str raw_string)
{
str fp = "Return digits only.";

// fcd: Dec-2-2014

str digits_only_string;
int i;

while(i < length(raw_string))
{
  i++;
  switch(str_char(raw_string, i))
  {
    case '1':
    case '2':
    case '3':
    case '4':
    case '5':
    case '6':
    case '7':
    case '8':
    case '9':
    case '0':
      digits_only_string += str_char(raw_string, i);
      break;
  }
}

return (digits_only_string);
}



//;; (!2mbam)

void
@run_bullet_action_model(str raw_sc = parse_str('/1=', mparm_str))
{

str fp = "BAM. Move bullet to ";

// fcd: Dec-2-2014

int search_criterion_was_found = 0;
int initial_column = @current_column;
int initial_row = @current_row;
int initial_window = @current_window;

int is_lc_action = 0;

if(!@is_bullet_file)
{
  return();
}

if(@is_subbullet)
{
  @bob;
}

if(!@is_bullet)
{
  return();
}

str lc;
str sc;
str sc_digits_only = @digits_only(raw_sc);
str sc_prefix;
str sc_suffix;
str so;

@save_location;
mark_pos;

switch(@first_character(raw_sc))
{
  case 'a':
    break;
  case 'c':
    break;
  case 'g':
    break;
  default:
}

if(@text_is_selected)
{
  @cut;
}
else
{
  @cut_bullet;
}

if(@first_character(raw_sc) != '-')
{
  lc = raw_sc;
}

// Go somewhere.
switch(sc_digits_only)
{
  case '1':
    @find_previous_big_segment;
    @paste_after;
    fp += 'previous bor';
    break;
  case '15':
    @find_previous_big_segment;
    @find_previous_big_segment;
    @mor;
    @paste_after;
    fp += 'previous mor';
    break;
  case '3':
    left;
    @bobs;
    @paste_after;
    goto_col(1);
    @bob;
    fp += 'bor';
    break;
  case '35':
    @mor;
    @find_next_bullet;
    @bol;
    @paste;
    fp += 'mor';
    break;
  case '4':
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
    fp += 'eor';
    break;
  case '5':
    @find_next_big_segment;
    // The following line helps in the case where you have a multiple line rubric header.
    @paste_after;
    fp += 'next bor';
    break;
  case '55':
    @find_next_big_segment;
    @mor;
    @paste_after;
    fp += 'next mor';
    break;
  case '6':
    @find_next_big_segment;
    @eor;
    @paste_after;
    fp += 'next eor';
    break;
  case '7':
    is_lc_action = 1;
    fp += 'lc ';
    break;
}

if(is_lc_action || (lc != ''))
{
  so = @find_lc_core(lc, search_criterion_was_found, fp);
  if(search_criterion_was_found)
  {
    if(@file_is_read_only(fp))
    {
      switch_window(initial_window);
      @paste;
    }
    else
    {
      @paste_as_bullet_below_here;
    }
  }
  else
  {
    switch_window(initial_window);
    @paste;
    @bob;
    @find_previous_bullet;
  }
}

if(@lower(@last_character(raw_sc)) == 'w')
{
  fp += 'with me.';
  pop_mark;
}
else
{
  fp += ' alone.';
  int destination_row = @current_row;
  int destination_window = @current_window;
  @restore_location;
  if(initial_window == destination_window)
  {
    if(initial_row > destination_row)
    {
      @find_next_bullet;
    }
  }
}

fp += ' ' + so;

if(@current_line_type != 'bullet')
{
  // I changed this to "@bob" instead of "@find_next_bullet" because of ;+5 when you are the 
  // last bullet. Jan-27-2016
  @bob;
}

goto_col(initial_column);
@put_cursor_somewhere_useful;

@say(fp + '.');
}



//;;

void
@@run_bullet_action_model(str raw_sc = parse_str('/1=', mparm_str))
{
@header;
@run_bullet_action_model(raw_sc);
@footer;
}



//;

void
@go_to_bullet_at_remote_eor(str parameter = parse_str('/1=', mparm_str))
{
str fp = 'Go to bullet at remote EOR.';

// fcd = Nov-17-2009

int search_criterion_was_found = 0;

@header;

str so = @find_lc_core(parameter, search_criterion_was_found, fp);

if(!search_criterion_was_found)
{
  @footer;
  return();
}

@find_next_big_segment;
@find_previous_bullet_or_subbull;

@footer;
@say(fp);
}



//;+ JD



//;; (skw @paste_subbullet)

void
@move_bullet_to_jd_and_turn_subb
{
str fp = "Move bullet to JD and turn him into a subbullet of the first bullet.";
@header;

if(!@is_bullet_file)
{
  return();
}

@cut_bullet;

@save_location;

@switch_to_named_window('JD.asc');

@bof;

@find_next_bullet;

@paste_after_with_subbullet;

@restore_location;

@bobsr;

@footer;
@say(fp);
}



//;;

void
@move_bullet_to_dq_and_turn_subb
{
str fp = "Move bullet to double q and turn him into a subbullet of the first bullet.";
@header;

if(!@is_bullet_file)
{
  return();
}

@cut_bullet;

@save_location;

@seek_in_all_files_simplest('bf' + 'of');

@find_next_bullet;

@paste_after_with_subbullet;

@restore_location;

@bobsr;

@footer;
@say(fp);
}



//;;

void
@move_bullet_to_dq_and_tsub_wme
{
str fp = "Move bullet to double q and turn him into a subbullet of the first bullet with me.";
@header;

if(!@is_bullet_file)
{
  return();
}

@cut_bullet;

@seek_in_all_files_simplest('bf' + 'of');

@find_next_bullet;

@paste_after_with_subbullet;

@bobsr;

@footer;
@say(fp);
}



//;;

void
@move_bullet_to_jd_and_tsub_wme
{
str fp = "Move bullet to JD and turn him into a subbullet of the first bullet with me.";
@header;

if(!@is_bullet_file)
{
  return();
}

@cut_bullet;

@switch_to_named_window('JD.asc');

@bof;

@find_next_bullet;

@paste_after_with_subbullet;

@footer;
@say(fp);
}



//;

int
@get_ascii_value_of_first_char()
{
str fp = 'Get ASCII value of first non-colon character of current bullet.';

@bobsr; // We know we are on a bullet.
@eoc;
int rv = ascii(@current_character);
fp += ' Value: ' + str(rv) + '.';

@say(fp);
return(rv);
}



//;

void
@capitalize_first_letter_of_buls
{
str fp = 'Capitalize first letter of all bullets in current rubric.';

if(!@is_bullet_file)
{
  return();
}

@header;

str Current_Character = '';

@bobs;

while(@find_next_bobs == 'bullet')
{
  Current_Character = @current_character;
  del_char;
  text(@upper(Current_Character));
}

@bobs;

@footer;
@say(fp);
}



//;

void
@@cursor_to_my_bof
{
@header;
@cursor_to_my_bof;
@footer;
}



//;

void
@@find_next_big_segment
{
str fp = 'Find next big segment.';
@header;
@find_next_big_segment;
@footer;
@say(fp);
}



//;

str
@craft_search_string(int find_Precision = parse_int('/1=', mparm_str))
{
str fp = 'Find gradation.';

// I realize that there is no @restore_location in this method. The @restore_location is
// actually called manually after this method. - JRJ Feb-9-2011
@save_location;

switch(find_Precision)
{
  case 1:
    fp += ' Find precisely (c1).';
    break;
  case 2:
    fp += ' Find normally (c2).';
    break;
  case 3:
    fp += ' Find liberally (c3).';
    break;
  case 4:
    fp += ' Find precisely (c4): ';
    break;
  case 5:
    fp += ' Find normally (c5): ';
    break;
  case 6:
    fp += ' Find liberally (c6): ';
    break;
  case 7:
    fp += ' Find precisely using user input (c7):';
    break;
  case 8:
    fp += ' Find normally using user input (c8):';
    break;
  case 9:
    fp += ' Find liberally using user input (c9):';
    break;
  case 12:
    fp += ' Find liberally using Global Search String (c12):';
    break;
}

str Name_of_File = Truncate_Path(File_Name);

str sc = @get_subject_or_selected_text;

if(find_Precision > 9)
{
  sc = global_str('search_str');
  if(sc == 'Function aborted.')
  {
    @say(sc);
    return("");
  }
  find_Precision -= 9;
}
else if(find_Precision > 6)
{
  sc = @get_user_input_raw(fp);
  if(sc == 'Function aborted.')
  {
    @say(sc);
    return("");
  }
  find_Precision -= 6;
}
else if(find_Precision > 3)
{
  sc = @get_wost;
  fp += '"' + sc + '".';
  find_Precision -= 3;
}

str Pretty_sc = sc;
sc = make_literal_x(sc);

switch(find_Precision)
{
  case 1:
    sc = @equate_spaces_and_dashes(sc);
    sc = '^((:#)||(;#))' + sc;
    sc += '((:)||($)||(\.)||(\?)||( \()||(,))';
    break;
  case 2:
    sc = @equate_spaces_and_dashes(sc);
    sc = '@;@' + sc;
    break;
  case 3:
    sc = @trim_trailing_spaces(sc);
    sc = @trim_string_after_open_paren(sc);
    sc = @equate_spaces_and_dashes_wcl(sc);
    break;
}

//@log('sp Aug-4-2009 = ' + sc);
return(sc);

}



//;+ Find From



//;;

void
@find_from_lc_known(str lc = parse_str('/1=', mparm_str), 
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
@find_from_lc_ui
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
@find_from_lc_uc
{
str fp = 'Begin a search on the word under cursor from a particular user inputted launch code.';
@header;

str  sc = @get_wost;
set_global_str('search_str', sc);

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
  @find_continuum(12, '');
}

@footer;
@say(fp + ' ' + so);
}



//;;

void
@find_from_lc_sj(str lc = parse_str('/1=', mparm_str))
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



//;

int
@@find_continuum(int find_Precision = parse_int('/1=', mparm_str), 
  str starting_Position_of_Search = parse_str('/2=', mparm_str))
{
@header;
int rv = @find_continuum(find_Precision, starting_Position_of_Search);
@footer;
return(rv);
}



//; (skw cascade search) Thinking as opposed to acting.

void
@cascade_search
{
str fp = "Cascade search.";

// fcd: Jan-3-2016

@header;

int find_result = @find_continuum(1, "");

if((find_result == 0) or (find_result == 2))
{
  find_result = @find_continuum(2, "");
}

if((find_result == 0) or (find_result == 2))
{
  find_result = @find_continuum(3, "");
}

@footer;

if((find_result == 0) or (find_result == 2))
{
  @say('Sui generis.');
}

}



//;

void
@find_next_wrapper
{
str fp = 'Find next wrapper.';
@header;

switch(lower(get_extension(File_name)))
{
  case "jpg":
  case "asc":
    // The Control Key
    if((key2 == 133) or (Global_Str('Move_Cursor_One_Line_At_A_Time') == 'True'))
    {
      down;
    }
    else
    {
      if(@text_is_selected)
      {
        down;
        @bol;
      }
      else
      {
        if(!@is_structured_line)
        {
          down;
        }
        else
        {
          @find_next_content_area;
          eol;
        }
      }
    }
    break;
  default: // That is, all other types of files.
    if((key2 == 133)) // Control Key
    {
      @find_next_big_segment;
    }
    else  // The control key was not pressed.
    {
      down;
    }
    break;
}

@footer;
}



//;+ Find From



//;;

void
@find_from_bobs_ui
{
str fp = 'Find from beginning of big segment and only search this big segment.';
str so;

@header;

str sc = @get_user_input_raw(fp);
if(sc == 'Function aborted.')
{
  @say(sc);
  return();
}

set_global_str('search_str', sc);

int Number_of_Lines_in_bs = @count_lines_in_bs;

mark_pos;
@bobs;

if(find_text(sc, Number_of_Lines_in_bs, _regexp))
{
  so = 'FOUND in this bs.';
  pop_mark;
}
else
{
  so = 'NOT found in this bs.';
  goto_mark;
}

@footer;
@say(fp + ' ' + so);
}



//;;

void
@find_from_bor_ui
{
str fp = 'Find from BOR.';
str so;

@header;

str sc = @get_user_input_raw(fp);
if(sc == 'Function aborted.')
{
  @say(sc);
  return();
}

set_global_str('search_str', sc);

int Number_of_Lines_in_Rubric = @count_lines_in_rubric;

mark_pos;
@bor;

if(find_text(sc, Number_of_Lines_in_Rubric, _regexp))
{
  so = 'FOUND.';
  pop_mark;
}
else
{
  so = '(' + sc + ') NOT found.';
  goto_mark;
}

@footer;
@say(fp + ' ' + so);
}



//;;

void
@find_from_bor_uc
{
str fp = 'Starting at the beginning of this big segment, find word or block under cursor.';
str so;

@header;

int Number_of_Lines_in_Rubric = @count_lines_in_rubric;

str sc = @get_wost;
set_global_str('search_str', sc);

mark_pos;

@bobs;

if(find_text(sc, Number_of_Lines_in_Rubric + 3, _regexp))
{
  so = 'FOUND in this rubric.';
  pop_mark;
}
else
{
  so = 'NOT found in this rubric.';
  goto_mark;
}

@footer;

@say(fp + " " + so + " (" + sc + ")");
}



//;+ Highcopy



//;;

void
@hc_big_segment()
{
str fp = 'Highcopy big segment.';

// Note: this function has the built-in ability to highlight multiple rubrics.
// Hit shift+F5, then simply hold down the key and continuously press F5 for multiple
// rubric highlights.

if(@text_is_selected)
{
  down;
  @find_next_big_segment;
  up;
}
else
{
  // The reason this sort of works backwards is so that you can see the header in the middle 
  // of the page.

  @find_next_big_segment;
  up;
  @bol;
  block_begin;
  @bobs;
  block_end;
  @copy_with_marking_left_on;
}

@say(fp);
}



//;; (skw highcopy_rubric)

void
@hc_rubric()
{
str fp = 'Highcopy rubric.';

@find_next_rubric;
up;
@bol;
block_begin;
@bor;
block_end;
@copy_with_marking_left_on;

@say(fp);
}



//;;

void
@cut_rubric()
{
str fp = 'Cut rubric to buffer.';
@hc_rubric;
rm('CutPlus /M=1');
@say(fp);
}



//;;

void
@copy_and_paste_rubric()
{
str fp = 'Copy and paste rubric.';

@hc_rubric;
@paste;

@say(fp);
}



//;+ Paste With Wiki Format



//;;

void
@paste_with_wikipedia_format()
{
str fp = 'Paste with Wikipedia.com formatting.';

if(!@is_bullet_file)
{
  return();
}

@save_location;

eol;

// Check for an existing colon, before inserting a new one.
str action_line = get_line;

action_line = @trim_leading_colons_et_al(action_line);

int add_colon = true;
int add_space = true;

switch(@current_column)
{
  case 1:
  case 2:
  case 3:
    add_colon = false;
    add_space = false;
    break;
}

switch(@last_character(action_line))
{
  case ':':
  case '?':
  case '.':
    add_colon = false;
    add_space = true;
    break;
  case ' ':
    add_colon = false;
    add_space = false;
    break;
}

if(xpos('lk#', action_line, 1))
{
  add_colon = false;
  add_space = true;
}

if(add_colon)
{
  text(':');
}

if(add_space)
{
  text(' ');
}

@create_timestamped_file;
@paste;

str description;
str rs;
str sc;

tof;
@replace_next_occurrence_only('search results', rs);

tof;
str sc = @share_american_heritage_dot_com(description, rs);
@replace_next_occurrence_only(sc, rs);

tof;
str sc = @bol_colon(description, rs);
@replace_all_occurrences_in_file(sc, rs);

// The @format_file call may mess up the replacement that needs to be done by 
// @read_more_answers_dot_com. For this reason the @format_file call needs to be made AFTER
// the call to @read_more_answers_dot_com. Nov-16-2011

@format_file;

@eof;
if(at_eol and @current_column == 1)
{
  @delete_character;
  @say('eol');
}

@eof;
left;
if(@current_character == ' ')
{
  @delete_character;
}

@eof;
left;
if(@current_character == ' ')
{
  @delete_character;
}

str replacement_description, rs;
@replace_string_in_file_int(@space_eol_blank_line(replacement_description, rs), rs);

rm('Block^SelectAll');
@copy;
@close_and_save_file_wo_prompt;

@restore_location;
eol;
@paste;

@backspace;

@fix_fat_colon;
@restore_location;
@word_wrap;
@restore_location;
@fix_fat_rubric;
@restore_location;

switch(@current_column)
{
  case 2:
  case 3:
    if(@current_character == ' ')
    {
      @delete_character;
    }
    break;
}

@say(fp);
}



//;;

void
@@paste_with_wikipedia_format
{
@header;
@paste_with_wikipedia_format;
@footer;
}



//;+ Big Segment Stuff



//;; (@delete_lc_on_cl)

void
@delete_text_lc_on_cl()
{
str fp = "Delete text launch code on current line.";

@bol;

if(!find_text(@lc, 1, _RegExp))
{
  fp += ' Error: LC NOT found on current line.';
  @say(fp);
  return();
}

left;
str_block_begin;
while(@current_character != ")")
{
  if(@current_column == 300)
  {
    fp += ' Error: Close parenthesis NOT found on current line.';
    @say(fp);
    return();
  }
  right;
}
right;

@delete_block;

@say(fp);
}



//;;

str
@copy_and_paste_big_segment()
{
str fp = 'Copy and paste rubric.';
@hc_big_segment;
block_off;
@paste;
@delete_text_lc_on_cl;
@say(fp);
return(fp);
}



//;;

str
@delete_big_segment()
{
str fp = 'Delete big segment.';

@hc_big_segment;
delete_block;
down;
if(at_eof)
{
  up;
  up;
  up;
  up;
  up;
  up;
  up;
  up;
  up;
}
else
{
  up;
}

@say(fp);
return(fp);
}



//;;

str
@delete_rubric()
{
str fp = 'Delete rubric.';

@hc_rubric;
delete_block;
down;
if(at_eof)
{
  up;
  up;
  up;
  up;
  up;
  up;
  up;
  up;
  up;
}
else
{
  up;
}

@say(fp);
return(fp);
}



//;;

void
@@delete_big_segment()
{
@header;
@delete_big_segment;
@footer;
}



//;+ Copaste



//;;

void
@coppaste_rubric_header_above()
{
str fp = "Copy and paste the current rubric header above.";
@header;

@bobs;
@copy;
@bobs;
put_line(@replace(get_line, '+ ', ';'));
@bobs;
put_line(@replace(get_line, '+', ';'));
@bobs;
cr;
cr;
cr;
up;
up;
up;
@paste;
left;
put_line(@replace(get_line, ' Miscellany', ''));
@bobs;
//@delete_text_lc_on_cl;
eol;

@footer;
@say(fp);
}



//;;

void
@coppaste_rubric_header_below
{
str fp = "Copy and paste the current rubric header below.";
@header;

@bobs;
@copy;

@find_next_big_segment;

@bol;
cr;
cr;
cr;
up;
up;
up;
@paste;
@eol;
left;

@footer;
@say(fp);
}



//;+ Coppaste Subbullet



//;;

void
@copy_and_paste_subbullet()
{
str fp = 'Copy and paste subbullet.';

@hc_small_segment;

if(@find_next_bsr == 'rubric')
{
  up;
  up;
}
@bol;
@paste;
@find_previous_subbullet;

@say(fp);
}



//;;

void
@copy_and_paste_small_segment()
{
str fp = 'Copy and paste segment.';

@hc_small_segment;

if(@find_next_bsr == 'rubric')
{
  up;
  up;
}
@bol;
@paste;
left;
@boca;

@say(fp);
}



//;+ Highcopy Macros



//;;

int
@get_sj_termination_column()
{

str fp = "Get subject termination column.";

// Deprecated: Please use @get_sj_cutoff_column going forward. Apr-10-2014

// fcd: Mar-28-2014

int length_of_line = length(get_line);

int length_of_line_post_trunc = length(@trim_leading_colons_et_al(get_line));

int number_of_leading_chars_trun = length_of_line - length_of_line_post_trunc;

str sc = @trim_leading_colons_et_al(get_line);

sc = @trim_colon_et_al(sc);

int column_position = length(sc);

return(column_position + number_of_leading_chars_trun + 1);
}



//;;

str
@hc_subject()
{
str fp = 'Highlight and copy subject portion of the current area type.';
str rv = 'Returns the highlighted text.';

@eoc;

str_block_begin;

goto_col(@get_sj_cutoff_column);

block_end;

@copy_with_marking_left_on;

str rv = @get_selected_text;

@say(fp + ' (length = ' + str(length(rv)) + ')');
return(rv);

/* Use Case(s)

- 8. Use Case on Oct-22-2014:
::Hey bears no ,ash

- 7. Use Case on Oct-22-2014:
::Hey bears! blah blah

- 6. Use Case on Oct-22-2014:
::rivers\jrjones: macrocosm (For Deltek, don't use the "rivers" portion.)

- 5. Use Case on Oct-22-2014:
::DCCapsApril44 (zdel): oblique

- 4. Use Case on Oct-22-2014:
:Zeta Deltek Credentials

- 3. Use Case on Oct-22-2014:
::Test!: hey

- 2. Use Case on Jan-4-2012:
;+ MT-4596: Text Level Sourcing: MT-4596

- 1. Use Case on Jan-4-2012:
tesext2: hey

*/
}



//;;

str
@hc_multiline_object
{
// This macro has not been fully tested. Apr-29-2013
str fp = 'Copy phrase from rightmost colon until eol.';

@find_rightmost_colon_on_curline;

str_block_begin;

@find_next_blank_line;

@copy_with_marking_left_on;

return(@get_selected_text);
}



//;;

str
@hc_object()
{
// Formerly called "@hc_post_rm_colon_phrase()".

str fp = 'Highlight and copy phrase from rightmost colon until eol.';

fp = 'Highlight object.';

@eol;

if(@previous_character == ':')
{
  down;
  @bol;
  str_block_begin;
  @eol;
}
else
{
  str_block_begin;
  // This is defined as the mirror image of subject.
  int position_of_colon_space = xpos(": ", get_line, 1);
  goto_col(position_of_colon_space);
  right;
  right;
  if(@current_column == 3)
  {
    left;
    if(@current_character == ":")
    {
      right;
    }
  }
}

@copy_with_marking_left_on;

@say(fp);

/* Use Case(s)

:http://www.dmvnow.com/#/

::http://www.dmvnow.com/#/

:Use Case 4: A subject separated by some launch codes.

Debug WriteLine (!+dw, !+deb): System.Diagnostics.Debug.WriteLine("");


Use Case 3: File paths - I don't want to find the last colon, rather I want to find the next 
colon after the leading colons.

Tools: c:\_dev\_bin\tools.dll


Use Case 2: Links

CNN: http://www.cnn.com


Use Case 1: Black_dwarf is adding an carriage return, which is not wanted. Nov-22-2011

blah blah: black_dwarf

*/

str rv = @get_selected_text;

set_global_str('cmac_return_value', rv);

return(rv);

}



//;;

str
@hc_subject_inverse()
{
// Formerly called "@hc_post_rm_colon_phrase()".

str fp = 'Highlight and copy phrase that is the inverse of the subject.';

@eol;
str_block_begin;

// This is defined as the mirror image of subject.
goto_col(@get_sj_cutoff_column);

if(@current_character != '=')
{
  right;
}
right;

@copy_with_marking_left_on;

@say(fp);

/* Use Case(s)


Use Case 1:

set configuration=configuration_tmt

*/

str rv = @get_selected_text;

set_global_str('cmac_return_value', rv);

return(rv);

}



//;+ Definition



//;;

void
@delete_definition_keep_lkctr()
{
str fp = "Delete the definition portion of a word's definition and keep the lookup counter.";

if(!@is_bullet_file)
{
  return();
}

str so;

block_off;

@bobsr;

if(find_text(@lookup_counter, 1, _regexp))
{
  right;
  right;
  right;
  while(@is_number(@current_character))
  {
    right;
  }
}
else
{
  @eoc;
  while((@current_character != ':') and !at_eol)
  {
    right;
  }
}

str_block_begin;
if(@find_next_bsr == 'rubric')
{
  up;
  up;
}
@bol;
left;
left;
delete_block;

@say(fp);
}



//;;

void
@@delete_definition_keep_lkctr
{
@header;
@delete_definition_keep_lkctr;
@footer;
}



//;;

void
@delete_definition()
{
str fp = "Delete the definition portion of a word's definition.";

block_off;
@bobsr;
@eoc;
goto_col(@get_sj_termination_column);

str_block_begin;
if(@find_next_bsr == 'rubric')
{
  up;
  up;
}
@bol;
left;
left;
delete_block;

@say(fp);
}



//;;

void
@@delete_definition
{
@header;
@delete_definition;
@footer;
}



//;;

void
@replace_definition
{
str fp = "Replace current definition with clipboard definition.";
// This is a good example of a beautiful and composed macro.
@header;
@delete_definition_keep_lkctr;
@paste_with_wikipedia_format;
@footer;
@say(fp);
}



//;+ Copy and Paste SJ



//;; skw copy and paste subject

void
@copy_and_paste_sj()
{
str fp = "Copy and paste sj only and turn it into a child subbullet.";

if(!@is_bullet_File)
{
  return();
}

if(!@is_bullet_or_subbullet)
{
  return();
}

str Colon_Or_Not = '';

if(@is_bullet)
{
  Colon_Or_Not = ':';
}

if(@is_bullet)
{
  fp += ' Branch 1.';
  @copy_and_paste_small_segment;
}
else
{
  fp += ' Branch 2.';
  @copy_and_paste_subbullet; 
}

@delete_definition;
@bol;
text(Colon_or_Not);
eol;

@say(fp);
}



//;;

void
@@copy_and_paste_sj
{
@header;
@copy_and_paste_sj;
@footer;
}



//;+ Copy and Paste OJ



//;; skw copy and paste oj

void
@copy_and_paste_oj()
{
str fp = "Copy and paste sj only and turn it into a child subbullet.";

if(!@is_bullet_File)
{
  return();
}

if(!@is_bullet_or_subbullet)
{
  return();
}

str colon_or_not = '';

if(@is_bullet)
{
  colon_or_not = ':';
}

if(@is_bullet)
{
  @copy_and_paste_small_segment;
}
else
{
  @copy_and_paste_subbullet; 
}

@hc_subject;
@delete_block;
right;
@delete_character;

if(@is_bullet)
{
  @backspace;
}
else
{
}

if(@next_3_characters == 'lk#')
{
  @delete_word_conservatively;
}

@say(fp);
}



//;;

void
@@copy_and_paste_oj
{
@header;
@copy_and_paste_oj;
@footer;
}



//;

int
@has_subbullets(str &sm)
{
str fp = 'Has subbullets.';

// Returns true if current bullet has subbullets. False otherwise.

if(!@count_subbullets_int)
{
  sm = 'This bullet has no subbullets';
  return(false);
}

return(true);
}



//;+ Move Bullet



//;;

void
@move_bullet_to_remote_eor_wme(str lc = parse_str('/1=', mparm_str))
{
str fp = 'Move bullet to remote eor with me.';

int search_criterion_was_found;
int Initial_Window = @current_window;

int Initial_Line_Number = @current_line_number;
int initial_column = @current_column;

if(!@is_bullet_file)
{
  return();
}

@header;

@cut_bullet;

str so = @find_lc_core(lc, search_criterion_was_found, fp);

if(search_criterion_was_found)
{
  if(@file_is_read_only(fp))
  {
    switch_window(Initial_Window);
    goto_line(initial_line_number);
    goto_col(initial_column);
    rm('paste');
    fp = 'Error: File is read-only, so cannot paste.';
  }
  else
  {
    @paste_to_eor;
  }
}
else
{
  switch_window(Initial_Window);
  goto_line(initial_line_number);
  goto_col(initial_column);
  rm('paste');
  fp += ' ' + so;
}

@footer;
@say(fp);
}



//;;

void
@move_bullet_to_remote_eor_alone(str lc = parse_str('/1=', mparm_str))
{
str fp = 'Move bullet to remote eor alone.';

if(!@is_bullet_File)
{
  return();
}

if(!@is_bullet_or_subbullet)
{
  return();
}

@header;

mark_pos;

int search_criterion_was_found;
int Initial_Window = @current_window;

int There_Was_A_Problem = false;

if(@text_is_selected)
{
  @cut;
}
else
{
  @cut_bullet;
}

str so = @find_lc_core(lc, search_criterion_was_found, fp);

if(search_criterion_was_found)
{
  if(@file_is_read_only(fp))
  {
    There_Was_A_Problem = true;
    fp = 'Error: File is read-only, so cannot paste.';
  }
  else
  {
    @paste_to_eor;
  }
}
else
{
  There_Was_A_Problem = true;
  fp += ' ' + so;
}

switch_window(initial_window);

goto_mark;

if(there_was_a_problem)
{
  rm('paste');
}

@put_cursor_somewhere_useful;

@footer;
@say(fp);
}



//;;

void
@move_bullet_to_remote_mor_alone(str lc = parse_str('/1=', mparm_str))
{
str fp = 'Move bullet to remote mor.';

int search_criterion_was_found;
int initial_window = @current_window;

int there_was_a_problem = false;

if(!@is_bullet_File)
{
  return();
}

if(!@is_bullet_or_subbullet)
{
  return();
}

@header;

mark_pos;

@cut_bullet;

str so = @find_lc_core(lc, search_criterion_was_found, fp);

if(search_criterion_was_found)
{
  if(@file_is_read_only(fp))
  {
    there_was_a_problem = true;
  }
  else
  {
    @mor;
    @paste;
  }
}
else
{
  there_was_a_problem = true;
  fp += ' ' + so;
}

switch_window(initial_window);

goto_mark;

@put_cursor_somewhere_useful;

if(there_was_a_problem)
{
  rm('paste');
}

@footer;
@say(fp + '(' + lc + ')');
}



//;

void
@move_line_up()
{
str fp = 'Move line up.';

int Is_Open_Brace = false;
int Is_Close_Brace = false;

rm('CutPlus /M=1');
up;

if(@first_character(@trim(get_line())) == '{')
{
  Is_Open_Brace = true;
}
if(@first_character(@trim(get_line())) == '}')
{
  Is_Close_Brace = true;
}

rm('paste');

if(Is_Open_Brace)
{
  @bol;
  if(@first_character(get_line) == ' ')
  {
    del_char;
  }
  if(@first_character(get_line) == ' ')
  {
    del_char;
  }
}
if(Is_Close_Brace)
{
  @bol;
  text('  ');
}

/* Use Cases
a
}
b
if()
{
  f
}
c
d
*/

@say(fp);
}



//;+ Move Stuff Up



//;;

str
@cut_big_segment()
{
str fp = 'Cut rubric.';
@hc_big_segment;
rm('CutPlus /M=1'); // Cut to buffer.
@say(fp);
return(fp);
}



//;;

void
@move_current_rubric_to_eof
{
str fp = "Move current rubric to eof.";
@header;

if(!@is_bullet_file)
{
  return();
}

@save_location;

@cut_big_segment;
@eof;
@bol;
@paste;

@restore_location;

@footer;
@say(fp);
}



//;; (skw first_child, first_sibling, first_amoung_siblings, sibling)

int
@is_first_subbullet()
{
if(@query_previous_bsr == 'bullet')
{
  @say('You are the first child subbullet.');
  return(1);
}
return(0);
}



//;;

void
@move_rubric_up()
{
str fp = 'Move rubric up.';

// fcd: Aug-13-2014

@cut_rubric;
@find_bor_or_previous_rubric;
@bol;
@paste;
@find_bor_or_previous_rubric;

@say(fp);
}



//;;

void
@move_subrubric_up()
{
str fp = 'Move subrubric up.';

// fcd: May-19-2014

@cut_big_segment;
@find_previous_big_segment;
@paste;
@find_previous_big_segment;


@say(fp);
}



//;+ (skw first_child, first_sibling, first_amoung_siblings, sibling)



//;;

void
@move_bullet_up()
{
str fp = 'Move bullet up.';

// fcd: Nov-6-2014

if(@current_line_number == 3)
{
  fp = ' You are at BOF.';
  @say(fp);
  return();
}

@cut_bullet;
up;
@bobbs;
str current_area_type = @current_area_type;
if((current_area_type == 'subrubric') or (current_area_type == 'rubric'))
{
  up;
  up;
}
@bol;
@paste;
left;
@bob;

@say(fp);
}



//;;

void
@move_subbullet_up()
{
str fp = "Move subbulet up.";

// fcd: Jul-1-2016

int is_last_small_segment = false;

if(@is_last_small_segment)
{
  is_last_small_segment = true;
}

@cut_subbullet;

if(is_last_small_segment)
{
  @boca;
}
else
{
  @find_previous_bullet_or_subbull; 
}

int initial_column = @current_column;
str current_area_type = @current_area_type;

@paste;

if((current_area_type == 'subrubric') or (current_area_type == 'rubric'))
{
  @bob;
}

if(current_area_type == 'bullet') 
{
  @find_previous_subbullet;
}

if(current_area_type == 'subbullet') 
{
  @find_previous_subbullet;
}

goto_col(initial_column);

@say(fp);
}



//;;

void
@move_up()
{
str fp = 'Move bullet or line up.';

if(!@is_structured_line)
{
  @move_line_up;
  return();
}

int initial_column = @current_column;

switch(@current_area_type)
{
  case 'bullet':
    @move_bullet_up;
    break;
  case 'subbullet':
    @move_subbullet_up;
    break;
  case 'rubric':
    @move_rubric_up;
    break;
  case 'subrubric':
    @move_subrubric_up;
    break;
  default:
    @say(fp + " This macro doesn't work with all category types.");
}

goto_col(initial_column);

@say(fp);
}



//;;

void
@@move_up
{
@header;
@move_up;
@footer;
}



//;

void
@move_line_down()
{
str fp = 'Move line down.';
int Is_Open_Brace = false;
int Is_Close_Brace = false;

rm('CutPlus /M=1'); // Cut to buffer.

if(@first_character(@trim(get_line())) == '{')
{
  Is_Open_Brace = true;
}
if(@first_character(@trim(get_line())) == '}')
{
  Is_Close_Brace = true;
}
down;
rm('paste');
if(Is_Open_Brace)
{
  @bol;
  text('  ');
}
if(Is_Close_Brace)
{
  @bol;
  if(@first_character(get_line) == ' ')
  {
    del_char;
  }
  if(@first_character(get_line) == ' ')
  {
    del_char;
  }
}

@say(fp);
}



//;

void
@move_subrubric_down()
{
str fp = "Move subrubric down.";
@header;

@cut_big_segment;
@find_next_big_segment;
@bol;
@paste;
@find_previous_big_segment;

@footer;
@say(fp);
}



//;

void
@move_rubric_down()
{
str fp = "Move rubric down.";

@header;

@cut_rubric;
@find_next_rubric;
@bol;
@paste;
@find_bor_or_previous_rubric;

@footer;
@say(fp);
}



//;+ Move Down



//;;

void
@move_down()
{
str fp = 'Move down.';

int initial_column = @current_column;

if(!@is_structured_line)
{
  @move_line_down;
  return();
}

if(@is_bullet_file)
{
  @boca;
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
else if((query_next_area == 'rubric') || (query_next_area == 'subrubric') and 
(!is_last_rubric_element))
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



//;;

void
@@move_down
{
@header;
@move_down;
@footer;
}



//;

void
@move_bookmark_down
{
str fp = 'Move bookmark down. To make my life easier, bookmarks should always be subbullets.';

@header;
if(@is_bullet_file)
{
  @find_previous_content_area;
  @move_down;
  @find_next_content_area;
}
else
{
  down;
  @move_line_down;
  up;
}

@footer;
@say(fp);
}



//;

void
@delete_previous_bullsub
{
str fp = 'Context sensitive delete previous bullet or subbulltet.';

@header;

if(!@is_bullet_file)
{
  @delete_previous_line;
  @footer;
  return();
}

if(@is_subbullet)
{
  if(@query_previous_bsr == 'bullet')
  {
    @say(fp + ' You are ALREADY the first child subbullet.');
    @footer;
    return();
  }
  mark_pos;
  @bobsr;
  up;
  @delete_subbullet;

  goto_mark;
  @footer;
  return();
}

// Is bullet.
if(@query_previous_bsr == 'rubric')
{
  @say(fp + ' You are ALREADY the first child bullet.');

  goto_mark;
  @footer;
  return();
}

mark_pos;

@bobsr;
up;
@delete_bullet;
goto_mark;

@footer;
@say(fp);
}



//; (skw replace 2 colons with 1)

void
@replace_2_colons_with_1_in_rub
{
str fp = 'Replace 2 colons with 1 in current rubric.';

if(!@is_bullet_file)
{
  return();
}

@header;

int Number_of_Replacements = 0;
int Number_of_Lines_in_Rubric = @count_lines_in_rubric;

@bobs;

while(find_text(':', Number_of_Lines_in_Rubric, _regexp))
{
  replace(':');
  Number_of_Replacements++;
  @bobs;
}

fp += ' Number of replacements: ' + str(Number_of_Replacements);

@footer;
@say(fp);
}



//;

void
@move_bullet_to_remote_mor_wme(str lc = parse_str('/1=', mparm_str))
{
str fp = 'Move bullet to remote mor with me.';

int search_criterion_was_found;
int Initial_Window = @current_window;

int Initial_Line_Number = @current_line_number;
int initial_column = @current_column;
int There_Was_A_Problem = false;

if(!@is_bullet_file)
{
  return();
}

@header;

@save_location;

if(@text_is_selected)
{
  @cut;
}
else
{
  @cut_bullet;
}

str so = @find_lc_core(lc, search_criterion_was_found, fp);

if(search_criterion_was_found)
{
  if(@file_is_read_only(fp))
  {
    There_Was_A_Problem = true;
  }
  else
  {
    @mor;
    @paste;
    @find_previous_bullet;
  }
}
else
{
  There_Was_A_Problem = true;
  fp += ' ' + so;
}

if(There_Was_A_Problem)
{
  @restore_location;
  rm('paste');
}

@footer;
@say(fp);
}



//;

void
@go_to_remote_bobs
{
str fp = "Go to remote BOBS.";

@header;
@find_lc_ui(fp);
@bobs;
@footer;
@say(fp);
}



//;

void
@go_to_remote_mor(str lc = parse_str('/1=', mparm_str))
{
str fp = 'Go to remote MOR.';

@header;

str so;
int search_criterion_was_found = 0;

so = @find_lc_core(lc, search_criterion_was_found, fp);

if(search_criterion_was_found)
{
  @mor;
}

@footer;
@say(fp);
}



//;

str
@look_up_rubrics_lc()
{
str fp = "Get rubric's launch code.";

// This function assumes that the active launch code appears FIRST.

str Distilled_lc;
str sc = @lc;
str so;

mark_pos;
@bobs;
@seek_next(sc, so);
goto_mark;

Distilled_lc = @distill_lc(found_str);

return(Distilled_lc);
}



//;

str
@look_up_rubrics_source_lc(int &source_lc_is_found)
{
str fp = "Get rubric's source launch code.";

// This function assumes that the active launch code appears FIRST.

str Distilled_lc;
str sc = '!sour.+';
str so;

mark_pos;
@bobs;

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

str
@look_up_rubrics_asap_lc(int &source_lc_is_found)
{
str fp = "Get rubric's associated application launch code.";

// This function assumes that the active launch code appears FIRST.

str Distilled_lc;
str sc = '!asap.+';
str so;

mark_pos;
@bobs;

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



//;+ Move More Bullets



//;;

str
@get_location_refiner()
{
str fp = "Get location refiner.";

// fcd: May-13-2014

int position_of_comma_lc = @position_of_regex(@comma_lc);

goto_col(position_of_comma_lc);

str location_refiner;

while(@current_character != ',')
{
  location_refiner += @current_character;
  right;
}

return(location_refiner);
}



//;;

void
@move_bullet_to_appropriate_lc(int return_home = parse_int('/1=', mparm_str))
{
str fp = "Move bullet to appropriate lc.";

// fcd: Apr-7-2014

@save_location;

str modifier;

str current_line = get_line;

goto_col(@position_of_regex(@comma_lc));

while(@current_character != ',')
{
  right; 
}

str lc = str_del(current_line, 1, @current_column);

str location_refiner = @get_location_refiner;

str line_without_lc = str_del(current_line, @current_column - 
length(@trim(location_refiner)), length(current_line));

@cut_bullet;

if(!@find_lc_known(fp, lc))
{
  @paste;
  @find_previous_bullet;
  return();
}

switch(@trim(location_refiner))
{
  case 'ew':
  case 'we':
    return_home = false;
  case 'e':
    @eor;
    modifier = ' (eor @ lc ' + lc + ')';
    break;
  case 'w': // This means Go to, a.k.a. remain, at lc location.
    return_home = false;
    break;
  case 'wm':
  case 'mw':
    return_home = false;
  case 'm':
    @mor;
    modifier = ' (mor @ lc ' + lc + ')';
    break;
  default:
    modifier = ' (' + lc + ')';
}

@paste_after;
//left;
//@bob;
del_line;
cr;
up;
text(@trim(line_without_lc));

if(return_home)
{
  @restore_location;
  if(!@is_structured_line)
  {
    @bobbs;
  }
}

@say(fp + modifier);
}



//;;

void
@@move_bullet_to_appropriate_lc
{
@header;
@move_bullet_to_appropriate_lc(true);
@footer;
}



//;

int
@first_5_characters_is_month()
{
str fp = "The first 5 characters on the current line is a month abbreviation.";

// fcd: Apr-30-2014

int is_month = 0;

switch(@first_5_characters(@lower(get_line)))
{
  case ':jan-':
  case ':feb-':
  case ':mar-':
  case ':apr-':
  case ':may-':
  case ':jun-':
  case ':jul-':
  case ':aug-':
  case ':sep-':
  case ':oct-':
  case ':nov-':
  case ':dec-':
    is_month = 1;
}

return (is_month);
}



//;+ Move bullets.



//;;

void
@capitalize_first_character()
{
str fp = "Capitalize first character.";

// fcd: Mar-15-2016

@eoc;
str current_character = @current_character;
@delete_character;
text(@upper(current_character));

@say(fp);
}



//;;

void
@move_bullet_to_calendar(int return_home)
{
str fp = "Move bullet to calendar.";

@bob;

str sc = get_line;
sc = @trim_leading_colons_et_al(sc);
sc = @first_3_characters(sc);
//str first_character = @upper(@first_character(sc));
//sc = first_character + @right(sc, 2);

if(@last_character(get_line) == 'w')
{
  return_home = false;
}

goto_col(6);

str day_date_string = @current_character;
right;
if(@current_character != ':')
{
  day_date_string += @current_character;
}

int original_integer;
if (Val(original_integer, day_date_string) == 0)
{
}

@capitalize_first_character;
@cut_bullet;

@save_location;

@find_lc(sc);

int current_line_integer = 0;
int previous_current_line_integer;

str day_date_string_2;

while(current_line_integer <= original_integer)
{
  if(@find_next_bobs != 'bullet')
  {
    up;
    up;
    break;
  }
  goto_col(6);
  day_date_string_2 = @current_character;
  right;
  if((@current_character != ':') && ( @current_character != '-'))
  {
    day_date_string_2 += @current_character;
  }
  previous_current_line_integer = current_line_integer;
  if (val(current_line_integer, day_date_string_2) != 0)
  {
  }
  if(current_line_integer >= original_integer)
  {
    if(previous_current_line_integer >= current_line_integer)
    {
      break;
    }
  }
}

@bol;

@paste;

if(return_home)
{
  @restore_location; 
}
else
{
  @find_previous_bullet;
  if(@last_character(get_line) == 'w')
  {
    @eol;
    @backspace;
  }
}

if(@current_line_type != 'bullet')
{
  @find_next_bullet;
}

@eoc;

@say(fp);
}



//;;

void
@move_bullet_to_appropriate_wme
{
str fp = "Move bullet to appropriate calendar spot with me.";
@header;

@bob;

str sc = get_line;
sc = @trim_leading_colons_et_al(sc);
sc = @first_3_characters(sc);

goto_col(6);

str day_date_string = @current_character;
right;
if(@current_character != ':')
{
  day_date_string += @current_character;
}

int original_integer;
if (Val(original_integer, day_date_string) == 0)
{
}

@cut_bullet;

@find_lc(sc);

@find_next_bullet;

int current_line_integer = 0;
int previous_current_line_integer;

str day_date_string_2;

while(current_line_integer <= original_integer)
{
  goto_col(6);
  day_date_string_2 = @current_character;
  right;
  if((@current_character != ':') && ( @current_character != '-'))
  {
    day_date_string_2 += @current_character;
  }
  previous_current_line_integer = current_line_integer;
  if (val(current_line_integer, day_date_string_2) != 0)
  {
  }
  if(current_line_integer <= original_integer)
  {
    if(previous_current_line_integer <= current_line_integer)
    {
      @find_next_bullet;
    }
  }
}

@bol;

@paste;

@find_previous_bullet;

@footer;
@say(fp);
}



//;;

void
@move_bullet_to_previous_eor_wme
{
str fp = 'Move bullet to previous eor with me.';

@header;

if(!@is_bullet_file)
{
  return();
}

@cut_bullet;

@bobs;

@find_previous_content_area;

@paste_after;

@eol;

@footer;

@say(fp);
}



//;

void
@sort_bullets_in_rubric
{
str fp = 'Sort bullets in current rubric. Only sorts by the first character.';

if(!@is_bullet_file)
{
  return();
}

@header;

int ascii_value_of_first_bullet = 0;
int ascii_value_of_second_bullet = 0;

@bobs;

while(@find_next_bobs == 'bullet')
{
  ascii_value_of_first_bullet = @get_ascii_value_of_first_char;
  fp += ' a3';
  if(@find_next_bobs != 'bullet')
  {
    fp += ' b3';
    break;
  }
  ascii_value_of_second_bullet = @get_ascii_value_of_first_char;
  @bob;
  if(ascii_value_of_first_bullet > ascii_value_of_second_bullet)
  {
    fp += ' c3';
    @@run_bullet_action_model('4');
    @bobs;
  }
}

up;
@bobs;

@footer;
@say(fp);
}



//;+ Parents



//;;

void
@hc_parent()
{
str fp = "Highcopy the parent bullet.";
str es;

if(!@is_bullet_file)
{
  return();
}

if(!@is_bullet)
{
  return();
}

if(!@has_subbullets(es))
{
  @say(fp + ' ' + es);
  return();
}

block_off;

@find_next_content_area;
@bol;
left;

block_begin;
@bob;

rm('CenterLn');
rm('CenterLn');

@copy_with_marking_left_on;

@say(fp);
}



//;;

void
@hc_parent_content_include()
{
str fp = "Highcopy the parent bullet content and include the first line.";
str es;

if(!@is_bullet_file)
{
  return();
}

if(!@is_bullet)
{
  return();
}

if(!@has_subbullets(es))
{
  @say(fp + ' ' + es);
  return();
}

block_off;

@find_next_small_segment;
@bol;
left;

str_block_begin;
@bob;
right;

rm('CenterLn');
rm('CenterLn');

@copy_with_marking_left_on;

@say(fp);
}



//;;

void
@cut_parent()
{
str fp = "Cut the parent bullet and make the first child the new parent.";
str es;

if(!@is_bullet_file)
{
  return();
}

if(!@is_bullet)
{
  return();
}

if(!@has_subbullets(es))
{
  @say(fp + ' ' + es);
  return();
}

@bob;
@hc_parent;
@cut;
@delete_character;

@say(fp);
}



//;;

void
@delete_parent()
{
str fp = "Delete the parent bullet and make the first child the new parent.";
str es;

if(!@is_bullet_file)
{
  return();
}

if(!@is_bullet)
{
  return();
}

if(!@has_subbullets(es))
{
  @say(fp + ' ' + es);
  return();
}

@bob;
@hc_parent;
delete_block;
@bol;
@delete_current_character;
@eoc;

@say(fp);
}



//;;

void
@copy_and_paste_parent_bullet()
{
str fp = "Copy and paste the parent bullet.";
str es;

if(!@is_bullet_file)
{
  return();
}

if(!@is_bullet)
{
  return();
}

if(!@has_subbullets(es))
{
  @say(fp + ' ' + es);
  return();
}

@hc_parent;
block_off;
@paste;
//@find_next_bullet;
text(':');
@eol;

@say(fp);
}



//;;

void
@copy_and_paste_and_detach_the_p
{
str fp = "Copy and paste and detach the parent bullet.";
str es;

if(!@is_bullet_file)
{
  return();
}

if(!@is_bullet)
{
  return();
}

if(!@has_subbullets(es))
{
  @say(fp + ' ' + es);
  return();
}

@hc_parent;
block_off;
@paste;
@bob;
@eol;

@say(fp);
}



//;+ Highcopy



//;;

void
@hc_bullet_content_inc()
{
str fp = 'Highcopy bullet content include first line.';

// Dependency Note: this macro requires that "Customize | Editing | Blocks | Persistent
// Blocks" be enabled.

block_off;

if(@find_next_bobs != 'bullet')
{
  up;
  up;
}

@bol;
left;

str_block_begin;
@bob;
right;

rm('CenterLn');
rm('CenterLn');

@copy_with_marking_left_on;

@say(fp);
}



//;;

void
@hc_small_segment_con_inc()
{
str fp = 'Highcopy small segment content include first line.';

// Dependency Note: this macro requires that "Customize | Editing | Blocks | Persistent
// Blocks" be enabled.

block_off;

if(@find_next_bsr == 'rubric')
{
  up;
  up;
}

@bol;
left;

str_block_begin;
@bobsr;
@eoc;

rm('CenterLn');
rm('CenterLn');

@copy_with_marking_left_on;

@say(fp);
}



//;; (skw export, purposes)

void
@delete_carriage_returns_for_sms
{
str fp = "Delete carriage returns for small segment for external pasting.";

// fcd: May-15-2015

@header;

@save_location;

@hc_small_segment_con_inc;

@create_timestamped_file;

@paste;

@bof;

@format_carriage_returnless_file;

@close_and_save_file_wo_prompt;

@restore_location;

@footer;

@say(fp);
}



//;;

void
@hc_small_segment_content_dinc()
{
str fp = "Highcopy small segment content don't include first line.";

// Dependency Note: this macro requires that "Customize | Editing | Blocks | Persistent
// Blocks" be enabled.

refresh=false;

block_off;

if(@find_next_bsr == 'rubric')
{
  up;
  up;
}
@bol;
left;

str_block_begin;
@boca;
down;
down;

rm('CenterLn');
rm('CenterLn');

@copy_with_marking_left_on;

refresh=true;

@say(fp);
}



//;+ Delete



//;;

str
@delete_small_segment_slidingly()
{
str fp = 'Delete small segment slidingly.';

if(@is_last_small_segment)
{
  fp += ' This operation is invalid when run from the last segment position.';
  return(fp);
}

mark_pos;

@bobsr;

@find_next_small_segment;

if(@is_bullet)
{
  fp += ' ' + @delete_bullet;
}
else
{
  fp += ' ' + @delete_subbullet;
}

goto_mark;

@say(fp);
return(fp);
}



//;;

void
@delete_segment_or_line_sliding()
{
str fp = 'Delete segment or line slidingly.';

@header;

if(@is_bullet_file)
{
  switch(@query_next_bsr)
  {
    case 'rubric':
      fp += ' Does not work when a rubric is the next BSR.';
      break;
    case 'bullet':
      mark_pos;
      @find_next_bullet;
      @delete_bullet;
      goto_mark;
      break;
    case 'subbullet':
      @delete_small_segment_slidingly;
      break;
    default:
  }
}
else // (skw delete_next_line, delete next line)
{
  down;
  @delete_line;
  up;
}

@footer;

@say(fp);
}



//;+ Perimeter Button Family



//;;

str
@hc_current_line()
{
str fp = "Copy line with marking left on.";
str rv = 'Returns current line.';

block_off;

@bol;

str_block_begin;

down;

// Nov-14-2016: I UNCOMMENTED the following line to make the 'highcopy' work.
// Without this line, only the highlight works.
rm('CutPlus /O=0');

block_end;

@say(fp);
rv = @get_selected_text;
return(rv);
}



//;;

void
@hc_perimeter_button()
{
str fp = "Contextually aware highcopy perimeter button.";

//@header; //This is commented because it messes up the highligthing. Mar-4-2011

str current_line_type = @current_line_type;

if(!@is_content_area_file)
{
  current_line_type = ''; 
}

switch(current_line_type)
{
  case 'rubric':
    @hc_rubric;
    break;
  case 'subrubric':
    @hc_big_segment;
    break;
  case 'bullet':
    @hc_bullet;
    break;
  case 'subbullet':
    @hc_subbullet;
    break;
  default:
    @hc_current_line;
}

//@footer; This is commented because it messes up the highlighting.
refresh=true;

int number_of_rows_in_block = block_line2 - block_line1 + 1;

@say(fp + ' ' + 'Block height: ' + str(number_of_rows_in_block) + ' row(s).');
}



//;;

void
@cut_pb
{
str fp = "Contextually aware cut perimeter button.";

@header;

str current_line_type = @current_line_type;

if(!@is_content_area_file)
{
  current_line_type = ''; 
}

switch(current_line_type)
{
  case 'rubric':
    @cut_rubric;
    break;
  case 'subrubric':
    @cut_big_segment;
    break;
  case 'bullet':
    @cut_bullet;
    break;
  case 'subbullet':
    @cut_subbullet;
    break;
  default:
    @cut;
}

@put_cursor_somewhere_useful;

@say(fp);
@footer;
}



//;;

void
@delete_pb
{
str fp = "Contextually aware delete.";

@header;

int current_column = @current_column;

str current_line_type = @current_line_type;

if(!@is_content_area_file)
{
  current_line_type = ''; 
}

switch(current_line_type)
{
  case 'bullet':
    if(key2 == 13) // The alt+control key was pressed.
    {
      @delete_parent;
    }
    else
    {
      @delete_bullet;
    }
    break;
  case 'rubric':
    fp += ' ' + @delete_rubric;
    break;
  case 'subbullet':
    if(key2 == 13) // The alt+control key was pressed.
    {
      @delete_bullet;
    }
    else
    {
      @delete_subbullet;
    }
    break;
  case 'subrubric':
    fp += ' ' + @delete_big_segment;
    break;
  default:
    @delete_line;
    @footer;
    return();
}

@put_cursor_somewhere_useful;

goto_col(current_column);

@footer;
@say(fp);
}



//;;

void
@copy_and_paste_pb
{
str fp = 'Contextually aware copy and paste perimeter button.';

if(@is_selected)
{
  @super_paste;
  return();
}

@header;

str current_line_type = @current_line_type;

if(!@is_content_area_file)
{
  current_line_type = ''; 
}

switch(current_line_type)
{
  case 'rubric':
    @copy_and_paste_rubric;
    break;
  case 'subrubric':
    @copy_and_paste_big_segment;
    break;
  case 'bullet':
    @copy_and_paste_bullet;
    eol;
    break;
  case 'subbullet':
    @copy_and_paste_subbullet;
    break;
  default:
    @copy_and_paste_line;
}

eol;

@footer;

}



//;;

void
@hc_current_area_type()
{
str fp = "Highcopy current area type.";

@boca;
@hc_perimeter_button;

@say(fp);
}



//;;

void
@control_highcopy_pb
{
str fp = 'Control key plus contextually aware highcopy perimeter button.';

if(@is_bullet_File)
{
  @hc_current_line;
}
else
{
  @hc_current_area_type;
}

@say(fp);
}



//;;

void
@control_copy_and_paste_pb
{
str fp = 'Control key plus copy and paste perimeter button.';

if(@is_bullet_File)
{
  @copy_and_paste_line;
}
else
{
  @hc_current_area_type;
  @paste;
}

@say(fp);
}



//;;

void
@control_delete_pb
{
str fp = 'Control key plus contextually aware delete perimeter button.';

@header;

if(@is_bullet_File)
{
  fp = @delete_small_segment_slidingly;
}
else
{
  @hc_current_area_type;
  @delete_block;
}

@footer;

@say(fp);
}



//;;

void
@control_cut_pb
{
str fp = 'Control key plus contextually aware cut perimeter button.';

if(@is_bullet_File)
{
  @cut;
}
else
{
  @hc_current_area_type;
  @cut;
}

@say(fp);
}



//;;

void
@alt_highcopy_pb
{
str fp = 'Alt key plus contextually aware highcopy perimeter button.';

switch(@current_area_type)
{
  case 'bullet':
    @hc_parent;
    break;
  case 'subbullet':
    @hc_bullet;
    break;
  case 'rubric':
    @hc_big_segment;
    break;
  case 'subrubric':
    @hc_rubric;
    break;
  default:
    fp += ' Context is undefined.';
}

}



//;;

void
@alt_cut_pb
{
str fp = 'Alt key plus contextually aware cut perimeter button.';

int Context = 0;

if(@is_bullet_File)
{
  switch(@current_area_type)
  {
    case 'bullet':
      Context = 1;
      @cut_parent;
      break;
    case 'subbullet':
      Context = 1;
      @cut_bullet;
      break;
    case 'rubric':
      Context = 1;
      @cut_big_segment;
      break;
    case 'subrubric':
      Context = 1;
      @cut_rubric;
      break;
  }
}

@put_cursor_somewhere_useful;

if(Context == 0)
{
  @say(fp + ' Context is undefined.');
}

}



//;;

void
@alt_delete_pb
{
str fp = 'Alt key plus contextually aware delete perimeter button.';

int Context = 0;

@header;

switch(@current_area_type)
{
  case 'bullet':
    @delete_parent;
    break;
  case 'subbullet':
    @delete_bullet;
    break;
  case 'rubric':
    @delete_big_segment;
    break;
  default:
    fp += ' Context is undefined.';
}

@footer;

@say(fp);
}



//;;

void
@alt_copy_and_paste_pb
{
str fp = 'Alt key plus contextually aware copy-and-paste perimeter button.';

int Context = 1;

@header;

switch(@current_area_type)
{
  case 'rubric':
    @coppaste_rubric_header_above;
    break;
  case 'bullet':
    @copy_and_paste_small_segment;
    @drag_right_wrapper;
    @eol;
    break;
  case 'subbullet':
    @copy_and_paste_bullet;
    break;
  default:
    Context = 0;
}

if(Context == 0)
{
  @say(fp + ' Context is undefined.');
}

@footer;

}



//;;

void
@control_shift_key_plus_pbh
{
str fp = 'Ctrl+Shift key plus contextually aware highcopy perimeter button.';

//Turning on @header or footer here for some reason turns off highlighting. - JRJ May-24-2011
refresh=false;

str sm = '';

if(@is_bullet_file())
{
  switch(@current_area_type)
  {
    case 'bullet':
    case 'subbullet':
      @hc_small_segment_content_dinc;
      break;
    case 'rubric':
    case 'subrubric':
      @hc_big_segment_content;
      break;
  }
}
else
{
  fp += ' Currently undefined.';
}

refresh=true;

int number_of_rows_in_block = block_line2 - block_line1;

@say(fp + ' ' + 'Block height: ' + str(number_of_rows_in_block) + ' row(s).');

}



//;;

void
@control_key_plus_pbh
{
str fp = 'Ctrl+ key plus contextually aware highcopy perimeter button.';

//Turning on @header or footer here for some reason turns off highlighting. - JRJ May-24-2011
refresh=false;

if(@is_bullet_file())
{
  switch(@current_area_type)
  {
    case 'bullet':
      @hc_small_segment_content_dinc;
      break;
    case 'rubric':
    case 'subrubric':
      fp += ' Undefined.';
      break;
    case 'subbullet':
      @hc_small_segment_content_dinc;
      break;
  }
}
else
{
  fp += ' Currently undefined.';
}

refresh=true;

@say(fp);
}



//;;

void
@control_shift_key_plus_pbc
{
str fp = 'Ctrl+Shift key plus contextually aware cut perimeter button.';

@header;

if(@is_bullet_File())
{
  switch(@current_area_type)
  {
    case 'rubric':
    case 'subrubric':
      @hc_big_segment_content;
      @cut;
      break;
    default:
      fp += ' Currently undefined.';
  }
}

@put_cursor_somewhere_useful;

@footer;

@say(fp);
}



//;;

void
@control_shift_key_plus_pbd
{
str fp = 'Ctrl+Shift key plus contextually aware delete perimeter button.';

@header;

@save_location;

if(@is_bullet_File())
{
  switch(@current_area_type)
  {
    case 'bullet':
      @delete_definition_keep_lkctr;
      fp += ' Delete bullet content.';
      break;
    case 'subbullet':
      @hc_small_segment_content_dinc;
      delete_block;
      @delete_line;
      eol;
      cr;
      up;
      eol;
      fp += ' Delete small segment content.';
      break;
    case 'rubric':
    case 'subrubric':
      @hc_big_segment_content;
      delete_block;
      @bobsr;
      fp += ' Delete rubric content.';
      break;
    default:
      fp += ' Currently undefined.';
  }
}

@restore_location;

@footer;

@say(fp);
}



//;

int
@get_bullet_height()
{
str fp = "Get bullet height.";

// fcd: Jan-27-2016

int number_lines_in_bullet = -1;
int offset = 0;

mark_pos;

@bob;

int initial_line_number = @current_line_number;

if(@find_next_bobs != 'bullet')
{
  offset++;
  offset++;
}

number_lines_in_bullet = @current_line_number - initial_line_number;

goto_mark;

return(number_lines_in_bullet - offset);
@say(fp);
}



//;+ Copy Bullet



//;;

void
@copy_bullet_to_pbor_alone
{
str fp = 'Copy bullet to previous BOR alone.';

if(!@is_bullet_file)
{
  return();
}

int Initial_Line_Number = @current_line_number;
int initial_column = @current_column;

@header;

@hc_bullet;

@find_previous_big_segment;

@paste_as_bullet_below_here;

goto_line(initial_line_number);
goto_col(initial_column);

@find_next_bullet;

@footer;
@say(fp);
}



//;;

void
@copy_bullet_to_peor_alone
{
str fp = 'Copy bullet to previous EOR alone.';

if(!@is_bullet_file)
{
  return();
}

@header;

mark_pos;

@hc_bullet;

@find_previous_big_segment;
@eor;

@paste_after;

goto_mark;

@footer;
@say(fp);
}



//;;

void
@copy_bullet_to_bor_alone
{
str fp = 'Copy bullet to BOR alone.';

if(!@is_bullet_file)
{
  return();
}

mark_pos;

@header;

@hc_bullet;

@bobs;

@paste_after;

goto_mark;

@footer;
@say(fp);
}



//;;

void
@copy_bullet_to_eor_alone
{
str fp = 'Copy bullet to EOR alone.';

if(!@is_bullet_file)
{
  return();
}

mark_pos;

@header;

@hc_bullet;

@eor;

@paste_after;

goto_mark;

@footer;
@say(fp);
}



//;;

void
@copy_bullet_to_next_bor_alone
{
str fp = 'Copy bullet to next BOR alone.';

if(!@is_bullet_file)
{
  return();
}

int Initial_Line_Number = @current_line_number;
int initial_column = @current_column;

@header;

@hc_bullet;

@find_next_big_segment;

@paste_as_bullet_below_here;

goto_line(initial_line_number);
goto_col(initial_column);

@footer;
@say(fp);
}



//;;

void
@copy_bullet_to_next_bor_wme
{
str fp = 'Copy bullet to next BOR with me.';

if(!@is_bullet_file)
{
  return();
}

int Initial_Line_Number = @current_line_number;
int initial_column = @current_column;

@header;

@hc_bullet;

@find_next_big_segment;

@paste_as_bullet_below_here;

@footer;
@say(fp);
}



//;;

void
@copy_bullet_to_next_eor_alone
{
str fp = 'Copy bullet to next EOR alone.';

if(!@is_bullet_file)
{
  return();
}

@header;

mark_pos;

@hc_bullet;

@find_next_big_segment;
@eor;

@paste_after;

goto_mark;

@footer;
@say(fp);
}



//;;

void
@copy_bullet_to_remote_bor_alone(str lc = parse_str('/1=', mparm_str))
{
str fp = 'Copy bullet to remote BOR alone.';

if(!@is_bullet_file)
{
  return();
}

@header;

int search_criterion_was_found;
int initial_window = @current_window;
int initial_window_is_current_window = false;

@save_location;

@hc_bullet;

str so = @find_lc_core(lc, search_criterion_was_found, fp);

if(search_criterion_was_found)
{
  @paste_as_bullet_below_here;
  if(initial_window == @current_window)
  {
    initial_window_is_current_window = true;
  }
}
else
{
  fp += ' ' + so;
}

@restore_location;

if(initial_window_is_current_window)
{
  @find_next_bullet;
}

@footer;
@say(fp);
}



//;;

void
@copy_bullet_to_remote_bor_wme(str lc = parse_str('/1=', mparm_str))
{
str fp = 'Copy bullet to remote BOR with me.';

if(!@is_bullet_file)
{
  return();
}

int search_criterion_was_found;
int Initial_Window = @current_window;

int Initial_Line_Number = @current_line_number;
int initial_column = @current_column;

@header;

@hc_bullet;

str so = @find_lc_core(lc, search_criterion_was_found, fp);

if(search_criterion_was_found)
{
  if(@file_is_read_only(fp))
  {
    switch_window(Initial_Window);
    goto_line(initial_line_number);
    goto_col(initial_column);
  }
  else
  {
    @paste_as_bullet_below_here;
    @eoc;
  }
}
else
{
  switch_window(Initial_Window);
  goto_line(initial_line_number);
  goto_col(initial_column);
  fp += ' ' + so;
}

@footer;
@say(fp);
}



//;;

void
@copy_bullet_to_remote_mor_alone(str lc = parse_str('/1=', mparm_str))
{
str fp = 'Copy bullet to the middle of a remote rubric alone.';

if(!@is_bullet_file)
{
  return();
}

@header;

@save_location;

int paste_at_line_number = -1;
int initial_window = @current_window;
int number_of_lines_in_bullet;
int counter = 0;

number_of_lines_in_bullet = @get_bullet_height;
@hc_bullet;

if(!@find_lc_known(fp, lc))
{
  @footer;
  return();
}

@mor;

int destination_row = @current_row;

str destination_filename = @filename;

@paste;

paste_at_line_number = @current_line_number;

@restore_location;

//if(destination_filename == lower(global_str('filename')))
//{
//  if(destination_row < global_int('initial row number'))
//  {
//    @find_next_bullet;
//  }
//}

if((initial_window == @current_window) && (paste_at_line_number < @current_line_number))
{
  while (counter < number_of_lines_in_bullet) 
  {
    down;
    counter++;
  }
}

@footer;
@say(fp + ' Counter: ' + str(counter));
@say(fp);
}



//;;

void
@copy_bullet_to_remote_mor_wme(str lc = parse_str('/1=', mparm_str))
{
str fp = 'Copy bullet to the middle of a remote rubric with me.';

if(!@is_bullet_file)
{
  return();
}

@header;

@hc_bullet;

if(!@find_lc_known(fp, lc))
{
  @footer;
  return();
}

@mor;

@paste;

@find_previous_bullet;

@footer;
@say(fp);
}



//;;

void
@@copy_bullet_to_remote_mor_wme(str lc = parse_str('/1=', mparm_str))
{
@header;
@copy_bullet_to_remote_mor_wme(lc);
@footer;
}



//;;

void
@copy_bullet_to_remote_eor_alone(str lc = parse_str('/1=', mparm_str))
{
str fp = 'Copy bullet to remote EOR alone.';

if(!@is_bullet_file)
{
  return();
}

int search_criterion_was_found;
int Initial_Window = @current_window;

mark_pos;

int There_Was_A_Problem = false;

@header;

if(@text_is_selected)
{
  @copy;
}
else
{
  @hc_bullet;
}

str so = @find_lc_core(lc, search_criterion_was_found, fp);

if(search_criterion_was_found)
{
  if(@file_is_read_only(fp))
  {
    There_Was_A_Problem = true;
    fp = 'Error: File is read-only, so cannot paste.';
  }
  else
  {
    @paste_to_eor;
  }
}
else
{
  There_Was_A_Problem = true;
  fp += ' ' + so;
}

switch_window(Initial_Window);

goto_mark;

@footer;
@say(fp);
}



//;;

void
@copy_bullet_to_remote_eor_wme(str lc = parse_str('/1=', mparm_str))
{
str fp = 'Copy bullet to remote EOR with me.';

if(!@is_bullet_file)
{
  return();
}

int search_criterion_was_found;
int Initial_Window = @current_window;

int Initial_Line_Number = @current_line_number;
int initial_column = @current_column;

@header;

@hc_bullet;

str so = @find_lc_core(lc, search_criterion_was_found, fp);

if(search_criterion_was_found)
{
  if(@file_is_read_only(fp))
  {
    switch_window(Initial_Window);
    goto_line(initial_line_number);
    goto_col(initial_column);
  }
  else
  {
    @paste_to_eor;
  }
}
else
{
  switch_window(Initial_Window);
  goto_line(initial_line_number);
  goto_col(initial_column);
  fp += ' ' + so;
}

@footer;
@say(fp);
}



//;+ Highlight



//;;

void
@highlight_rubric_then_find_next
{
str fp = 'Highlight this rubric, then find the next rubric.';
@header;

@bobs;

if(!@text_is_selected)
{
  str_block_begin;
}

@find_next_big_segment;
@bobs;

@footer;
@say(fp);
}



//;; (skw Highcopy consecutive bullets.)

void
@highlight_bullet_then_find_next
{
str fp = "Highlight this bullet, then find the next bullet.";

@header;

@bob;

if(!@text_is_selected)
{
  str_block_begin;
}

if(@find_next_bobs != 'bullet')
{
  up;
  up;
  left;
  left;
}
else
{
  @bob;
}

@footer;
@say(fp);

}



//;; (skw turn_on, turn on, highlight_until, highlight until, then find)

void
@highlight_then_find
{
str fp = "Highlight then find.";
@header;

block_begin;
@find_continuum(9, '');
up;
@bol;

@footer;
@say(fp);
}



//; (skw delete blank line)

void
@delete_blank_lines_near_eof()
{
str fp = "Delete blank lines near eof.";

eof;

while(true)
{
  @bol;
  if(at_eol)
  {
    @delete_line;
    up;
  }
  else
  {
    break;
  }
}
@say(fp);
}



//;

void
@add_rubric_near_eof(str lc = parse_str('/1=', mparm_str))
{

str fp = 'Add Rubric near EOF for launch code "' + lc + '".';

@header;

if(lc != '')
{
  if(!@find_lc_known(fp, lc))
  {
    @footer;
    return();
  }
}

eof;
@add_rubric_above('');

@footer;
@say(fp);
}



//;

void
@go_to_first_bullet_at_lc(str lc = parse_str('/1=', mparm_str))
{

/*

skw

go to jd, go_to_jd, junk_drawer

*/

str fp = 'Go to the first bullet at lc "' + lc + '".';

@header;

if(!@find_lc_known(fp, lc))
{
  @footer;
  return();
}

if(!@is_bullet_file)
{
  @footer;
  return();
}

@find_next_bullet;

@footer;
@say(fp);
}



//;+ Find Bookmarks



//;;

void
@if_past_eol_then_go_to_eol()
{
str fp = "If past eol, then go to eol.";

// fcd: Jan-30-2015

mark_pos;
int current_column = @current_column;
eol;
if(@current_column < current_column)
{
  pop_mark;
  eol;
}
else
{
  goto_mark;
}

@say(fp);
}



//;;

int
@make_double_q_adjustment()
{
str fp = "Make double q adjustment.";

int originalRowsToMoveDown = 0;
int rows_to_move_down = 0;

if(@current_character == '-')
{
  val(rows_to_move_down, @current_character + @next_character);
}
else
{
  val(rows_to_move_down, @current_character);
}
originalRowsToMoveDown = rows_to_move_down;
if(rows_to_move_down > 0)
{
  while(rows_to_move_down > 0)
  {
    down;
    rows_to_move_down--;
  }
}
else
{
  while(rows_to_move_down < 0)
  {
    up;
    rows_to_move_down++;
  }
}

@if_past_eol_then_go_to_eol;

@say(fp);
return(originalRowsToMoveDown);
}



//;; (skw @find_double_q)

void
@find_bookmark_primary()
{
str fp = "Find main bookmark.";

str sc = 'q' + 'q';
str so = '';

down;
down;

if(@seek_in_all_files_2_arguments('1' + sc, so))
{
  @say(fp + ' Primary case.');
  return();
}

if(@seek_in_all_files_2_arguments(sc, so))
{
  fp += ' Double q found.';
  @save_column;
  right;
  @make_double_q_adjustment;
  // This is the default behavior.
  if(@is_bullet_file)
  {
    if(@first_character_in_line == ':')
    {
      if(!@is_last_bullet)
      {
        @find_next_small_segment;
      }
      @restore_column;
    }
  }
  else
  {
    switch(@filename_extension)
    {
      case 's':
        if(length(get_line) == 0)
        {
          @bol;
        }
        break;
      default:
        break;
    }
  }
}
else
{
  fp += ' Double q was NOT found, so go to the now playing task list.';
  @go_to_first_bullet_at_lc('rfnptl');
}

@say(fp);
}



//;;

void
@process_move_marker()
{
str fp = "Process move marker.";

// fcd: Sep-15-2016

str sc = 'mov';

@bol;

if(find_text(sc, 1, _regexp))
{
  right;
  right;
  right;
  @make_double_q_adjustment;
}
else
{
  if(@is_bullet_file)
  {
    if((@current_line_type == 'rubric') || (@current_line_type == 'subrubric'))
    {
      if(@peek_ahead_3 != 'rubric')
      {
        @find_next_bullet;
      }
    }
  }
}

//@say(fp);
}



//;;

void
@cursor_to_starting_point()
{
str fp = 'Cursor to starting point.';

if(@filename_extension == 'txt')
{
  return();
}

switch(@filename)
{
  case "jonathan's_macros.s":
    @eof;
    @find_previous_big_segment;
    break;
  default:
    @bof;
    str sc = '!s' + 'p';
    // I modified this from "seek_in_all_files" on Apr-18-2016.
    @seek(sc);
    if(@is_bullet_file)
    {
      @find_next_bullet;
    }
    else
    {
      @process_move_marker;
    }
}

@say(fp);
}



//;;

void
@@find_bookmark_primary
{
@header_bloff;
@find_bookmark_primary;
@footer;
}



//;;

void
@find_bookmark_alternate
{
str fp = 'Go to alternate task location.';
@say(fp + ' Please wait . . .');
@header;

block_off;
@save_location;

str fs = '';
str so = '';

str SC1 = '(qj' + 'q)';
str SC2 = '(\@rt' + 'm)';

str orred_search_criteria = sc1 + '||' + sc2;

int search_criterion_was_found = @seek_in_all_files_core(Orred_Search_Criteria, so, FS);

if(search_criterion_was_found)
{
  @process_move_marker;
}
else
{
  so = 'Search criterion NOT found, so go to now playing task list.';
  @go_to_first_bullet_at_lc('rfnptl');
}

/* Use Case(s)

#2. q bq

#1. q bq

*/

@footer;
@say(fp + ' ' + so);
}



//;;

void
@cursor_to_initial_file_open_pos()
{
str fp = "Move cursor to initial file open position.";

@cursor_to_my_bof;
@cursor_to_starting_point;

}



//;;

void
@@find_initial_position
{
@header;
@cursor_to_initial_file_open_pos;
@footer;
}



//;;

void
@switch_to_named_window_jd
{

str fp = "Switch to the JD window.";

@header;

rm('@switch_to_named_window /1=JD.asc');
@cursor_to_initial_file_open_pos;

@footer;
@say(fp);
}



//;+ Add Bullet Rubric



//;;

void
@add_small_segment_above(int is_bullet)
{
str fp = 'Add small segment above.';

// This code is a work of art. It adheres to my 'building blocks' design pattern.

@boca;
insert_mode=1;

if(@is_big_segment)
{
  up;
  up;
}

cr;
cr;
up;
up;

text(':');
if(!is_bullet)
{
  text(':');
}

@say(fp);
}



//;;

void
@add_small_segment_below(int is_bullet)
{
str fp = 'Add small segment below.';

if(!@is_bullet_file)
{
  return();
}

// You can't insert a subbullet after a big segment.
if(!is_bullet)
{
  if(!@is_bullet_or_subbullet)
  {
    return();
  }
}

@boca;
insert_mode=1;

if(is_bullet)
{
  @find_next_bobs;
}
else
{
  @find_next_content_area;
}

@add_small_segment_above(is_bullet);

@say(fp);
}



//;;

void
@add_bullet_below()
{
str fp = 'Add below below.';
if(@is_bullet_file)
{
  @add_small_segment_below(true);
}
else
{
  @eol;
  cr;
}
@say(fp);
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
@add_bullet_at_lc(str lc = parse_str('/1=', mparm_str))
{
str fp = 'Add bullet at launch code.';

@header;

if(@find_lc(lc))
{
  @add_bullet_below;
}
else
{
  fp += ' LC NOT found.';
}

@footer;
@say(fp + ' (' + lc + ')');
}



//;;

void
@add_subbullet_above()
{
str fp = 'Add subbullet above.';

if(!@is_bullet_file)
{
  return();
}

if(@current_line == 1)
{
  fp += ' Error: You are at bof.';
  @say(fp);
  return();
}

@add_small_segment_above(false);

@say(fp);
}



//;;

void
@add_bullet_above()
{
str fp = 'Add bullet above.';
if(@is_subbullet)
{
  @bob;
}
if(@is_bullet_file)
{
  @add_small_segment_above(true);
}
else
{
  @bol;
  cr;
  up;
}
@say(fp);
}



//;;

void
@@add_bullet_above
{
@header;
@add_bullet_above;
@footer;
}



//;;

void
@add_bullet_at_end_of_previous_r
{
str fp = "Add bullet at end of previous rubric.";

str em;

@header;

@save_location;

em = @find_previous_big_segment;

if(length(em) == 0)
{
  @find_next_big_segment;
  @add_bullet_above;
}
else
{
  fp += ' ' + em;
  @restore_location;
}

@footer;
@say(fp);
}



//;;

void
@add_subbullet_below()
{
str fp = 'Add subbullet below.';
@header;
@add_small_segment_below(false);
@footer;
}



//;;

void
@add_subbullet_above
{
str fp = 'Add subbullet above.';
@header;
@add_small_segment_above(false);
@footer;
}



//;;

void
@add_bullet_at_beg_of_previous_r
{
str fp = "Add bullet at beginning of previous rubric.";
@header;

str em;

@header;

@save_location;

em = @find_previous_big_segment;

if(length(em) == 0)
{
  @add_bullet_below;
}
else
{
  fp += ' ' + em;
  @restore_location;
}

@footer;
@say(fp);
}



//;;

void
@add_bullet_at_eor()
{
str fp = 'Add bullet at end of rubric.';

@find_next_big_segment;
@bob;
@add_bullet_below;

@say(fp);
}



//;;

void
@add_bullet_at_remote_eor(str lc = parse_str('/1=', mparm_str))
{
str fp = 'Add bullet at remote EOR.';

// All the "add_bullet" macros assume "with me".

@header;

if(!@find_lc_known(fp, lc))
{
  @footer;
  return();
}

@add_bullet_at_eor;

@footer;
@say(fp);
}



//;;

void
@add_bullet_at_next_eor()
{
str fp = 'Add bullet at end of next rubric.';

@find_next_big_segment;
@find_next_big_segment;
@bob;
@add_bullet_below;

@say(fp);
}



//;;

void
@add_bullet_at_bor
{
str fp = 'Add bullet at beginning of rubric.';

if(!@is_bullet_File)
{
  return();
}

@header;

@bobs;

@add_bullet_below;

@footer;
@say(fp);
}



//;;

void
@add_bullet_at_remote_mor(str lc = parse_str('/1=', mparm_str))
{
str fp = 'Add bullet at middle of remote rubric.';
@header;

if(!@find_lc_known(fp, lc))
{
  @footer;
  return();
}

int Number_of_Bullets_in_Rubric = @count_bullets;
int Counter = 0;
while(Counter < (Number_of_Bullets_in_Rubric / 2))
{
  @find_next_bullet;
  Counter++;
}

@add_bullet_below;

@footer;
@say(fp);
}



//;;

void
@add_bullet_at_mor
{
str fp = 'Add bullet at middle of current rubric.';

if(!@is_bullet_file)
{
  return();
}

@header;

@bobs;

int Number_of_Bullets_in_Rubric = @count_bullets;
int Counter = 0;
while(Counter < (Number_of_Bullets_in_Rubric / 2))
{
  @find_next_bullet;
  Counter++;
}

@add_bullet_below;

@footer;
@say(fp);
}



//;;

void
@add_bullet_at_next_bor
{
str fp = "Add bullet at next BOR.";
@header;

@find_next_big_segment;
@add_bullet_below;

@footer;
@say(fp);
}



//;;

void
@add_double_q()
{
str fp = 'Add double q context sensitively.';
@header;

int is_bullet = false;
int is_subbullet = false;
str last_updated = ' Last updated: ' + @get_date();

if(@is_bullet_file)
{
  if(@is_bullet)
  {
    @add_bullet_above;
    Is_Bullet = true;
  }
  else if(@is_subbullet)
  {
    @add_subbullet_above;
    is_subbullet = true;
  }
  else
  {
    @add_bullet_below;
  }
  text('(!q' + 'q)');
  @find_next_small_segment;
}
else
{
  int column_number = @current_column;
  @eol;
  cr;
  text(@comment_characters);
  text('q' + 'q-1');
  if(@is_xxl_file(@filename_extension))
  {
    eol;
    text(' -->');
  }
  up;
  goto_col(column_number);
}

@footer;
@say(fp);
}



//;;

void
@@add_subbullet_above
{
@header;
@add_subbullet_above;
@footer;
}



//;;

void
@add_double_q_above
{
str fp = 'Add double q above.';
@header;

@save_location;

if(@is_bullet_file)
{
  if(@current_area_type == 'subbullet')
  {
    @add_subbullet_above;
  }
  else
  {
    @add_bullet_above;
  }
}
else
{
  @bol;
  cr;
  up;
  switch(lower(Get_Extension(File_name)))
  {
    case 'bat':
      text(':');
      break;
    case 's':
      text('//');
      break;
  }
}

text('q' + 'q');

@restore_location;
down;

if(@is_bullet_file)
{
  down;
}

@footer;
@say(fp);
}



//;

void
@format_buffer_data_nicely
{
str fp = "Format buffer data nicely and add as a bullet.";
@header;

if(!@is_bullet_file)
{
  return();
}

@save_location;

@create_reusable_temporary_file;

@paste;

@format_file;

rm('Block^SelectAll');
@copy;
@close_and_save_file_wo_prompt;

@restore_location;
@add_bullet_above;
cr;
@paste;
@fix_fat_colon;

@say(fp);
@footer;
}



//;+ Add Text (!fyat)



//;;

void
@add_text_at_eol(str text_to_add = parse_str('/1=', mparm_str))
{
str fp = "Add text at eol.";

// fcd: Mar-30-2015

@bol;

fp += ' (' + text_to_add + ')';

text_to_add = ' ' + text_to_add;

if(!find_text(@lookup_counter, 1, _regexp))
{
  text_to_add = ':' + text_to_add;
}

@eol;
text(text_to_add);

@say(fp);
}



//;;

void
@add_text_misspelling
{
str fp = 'Add text misspelling.';
@add_text_at_eol('msp');
}



//;;

void
@add_text_alternate_spelling
{
str fp = 'Add text alternate spelling.';
@add_text_at_eol('asp');
}



//;;

void
@add_text_parameter
{
str fp = 'Add text parameter.';

@eol;
left;
if(@current_character == ')')
{
  @delete_character;
}
else
{
  right;
}
left;
if(@current_character == '(')
{
  @delete_character;
}
else
{
  right;
}

text("(str sc = parse_str('/1=', mparm_str))");

@say(fp);
}



//;; (skw begin_each_line, begin each line, begin_and_end, begin and end)

void
@add_text_begin_all_lines_with_x
{

//skw begin each line with


str fp = "Begin all lines in the file with a variable defined here.";
str rs;
str sc;
int EFBO = true; // Execute First Block Only

if(!@is_text_file)
{
  return();
}

tof;

// begin line regex
sc = '^';

// begin line variable
rs = 'copy "';
rs = 'move "';
rs = 'del /f c:\\pcarss\\';

@replace_all_occurrs_inf_no_tof(sc, rs);

//tof;

// end line regex
//sc = '$^';

// end line variable
//rs = '" "c:\\!\\ by Pete Shop boys.mp3"$';

//@replace_all_occurrs_inf_no_tof(sc, rs);

@say(found_str);
@say(fp);
}



//;;

void
@add_text_end_all_lines_with_x
{
str fp = "End all lines in the file with a variable defined here.";
str rs;
str sc;
int EFBO = true; // Execute First Block Only

if(!@is_text_file)
{
  return();
}

@header;

tof;

// End line regex.
sc = '$^';

// End line variable.
rs = '" ".\\Error Screen Shots"$';

@replace_all_occurrs_inf_no_tof(sc, rs);

@footer;
@say(found_str);
@say(fp);
}



//;;

void
@add_text_workday_itinerary
{
str fp = 'Paste your workady itinerary to bol.';

// The 3 itineraries really should be one function with passed in a passed in parameter.
// May-9-2014

@header;

@save_location;

if(xpos('itinerary', get_line, 1))
{
  @delete_bullet;
}

if(!@find_lc('rfowt'))
{
  @say(fp + ' Error. Cannot find "rfowt".');
  @footer;
  return();
}

@hc_big_segment_content;

@restore_location;

@bol;
@paste;

@restore_location;

@footer;
@say(fp);
}



//;;

void
@add_text_monthly_itinerary
{
str fp = 'Paste your monthly itinerary to its proper place.';

@header;

@save_location;

if(xpos('itinerary', get_line, 1))
{
  @delete_bullet;
}

if(!@find_lc('rfomt'))
{
  @say(fp + ' Error. Cannot find "rfomt".');
  @footer;
  return();
}

@hc_big_segment_content;

@create_reusable_temporary_file;

@paste;

@format_data_for_monthly_itin;

@close_and_save_file_wo_prompt;
@restore_location;

@bol;
@paste;

@restore_location;

@footer;
@say(fp);
}



//;;

void
@add_text_quarterly_itinerary
{
str fp = 'Paste your quarterly itinerary to its proper place.';

@header;

@restore_location;

if(xpos('itinerary', get_line, 1))
{
  @delete_bullet;
}

if(!@find_lc('rfoqt'))
{
  @say(fp + ' Error. Cannot find "rfoqt".');
  @footer;
  return();
}

@hc_big_segment_content;

@restore_location;

@bol;
@paste;

@restore_location;

@footer;
@say(fp);
}



//;;

void
@add_text_separator
{
str fp = 'Add text separator here.';

@add_bullet_below;
text('  _/)       _/)      _/)');
cr;
text('  ~~~~~~~~~~~~~~~~~~~~~~~~');
up;
@eol;
right;

@say(fp);
}



//;;

void
@add_text_event_highlighting
{
str fp = 'Add text event highlighting.';

@eol;
cr;
cr;

text("I have highlighted this event.  _,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,__,.-'~'-.,_");

@say(fp);
}



//;;

void
@add_text_date_and_time_fixed_w()
{
str fp = 'Add fixed width date and time.';

if(@text_is_selected)
{
  delete_block;
}

text(@get_fixed_width_date + " " + @get_fixed_width_time);

@say(fp);
}



//;;

void
@add_text_date_and_time()
{
str fp = 'Add text date and time.';

if(@text_is_selected)
{
  delete_block;
}

if(@is_alphanumeric_character(@previous_character))
{
  text(' ');
}

text(@get_formatted_date + " " + @get_time);

@say(fp);
}



//;;

void
@add_text_date_plus_full_time()
{
str fp = 'Add text date plus full time.';

if(@text_is_selected)
{
  delete_block;
}

text(@get_formatted_date + " " + @get_formatted_full_time);

@say(fp);
}



//;;

void
@add_text_time()
{
str fp = 'Add text time.';

if(@text_is_selected)
{
  delete_block;
}

text(@get_formatted_time);

@say(fp);
}



//;;

void
@add_text_blank
{
str fp = "Add ' [blank]' text.";

if(@text_is_selected)
{
  delete_block;
}

if((@previous_character != ' ') and (@previous_character != ':'))
{
  text(' ');
}

text('[blank]');

if(!at_eol)
{
  text(' ');
}

/* Use Case(s)

test [blank] a

*/

@say(fp);
}



//;;

void
@add_text_blank_url_here()
{
str fp = 'Add blank browser text here.';

if(@text_is_selected)
{
  delete_block;
}

text('http://www.');
@eol;
text('.com');
left;
left;
left;
left;

@say(fp);
}



//;;

void
@add_text_last_updated()
{
str fp = 'Add text last updated.';

// Last Updated: Sep-19-2016

@eol;
cr;
cr;
text(@comment_characters);
text('Last Updated: ');
@add_text_date;
cr;
text(@comment_characters);
text('This is ' + 'the latest.');
up;
up;
up;

@say(fp);
}



//;;

void
@add_text_my_initials_and_date
{
str fp = 'Add text my initials and date.';

text(' - JRJ ' + @get_formatted_date);

@say(fp);
}



//;;

void
@add_text_global_search_string
{
str fp = 'Add text global search string, the cmac value, not THE value.';
text("global_str('search_str')");
@say(fp);
}



//;;

void
@add_text_global_search_string_v
{
str fp = 'Add text global search string value.';
text(global_str('search_str'));
@say(fp);
}



//;;

void
@add_text_global_ss_pretty_sc
{
str fp = 'Add text global search string value.';
text(global_str('pretty_sc'));
@say(fp);
}



//;;

void
@add_text_is_bullet
{
str fp = 'Add text is bullet.';
@header;

@bol;
text('if(@is_bullet)');
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
@add_text_is_bullet_file
{
str fp = 'Add text is bullet file.';
@header;

@bol;
text('if(@is_bullet_file)');
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
@add_text_is_text_file
{
str fp = 'Add text is text file.';
@header;

@bol;
text('if(!@is_text_file)');
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
@add_text_s_file
{
str fp = 'Add text s file.';
@header;

@bol;
text('if(!@is_s_file)');
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
@add_text_switch_statement_ftype
{
str fp = 'Add text switch statement for file type.';
@header;

@bol;
cr;
text("switch(lower(get_extension(File_name)))");
cr;
text("{");
cr;
text("  case 'asc':");
cr;
text("  case 'jpg':");
cr;
text("    break;");
cr;
text("  case 's':");
cr;
text("    break;");
cr;
text("  default:");
cr;
text("    break;");
cr;
text("}");
cr;

@footer;
@say(fp);
}



//;;

void
@add_text_is_subbullet
{
str fp = 'Add text "is_not_subbullet".';
@header;
@bol;
text('if(!@is_subbullet)');
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
@add_text_switch_statement
{
str fp = 'Add text for switch statement.';
@header;

text("switch(@current_area_type)");
cr;
text("{");
cr;
text("  case 'rubric':");
cr;
text("    break;");
cr;
text("  case 'bullet':");
cr;
text("    break;");
cr;
text("  case 'subbullet':");
cr;
text("    break;");
cr;
text("  default:");
cr;
text("}");

@footer;
@say(fp);
}



//;;

void
@add_text_text_is_selected
{
str fp = 'Add text block is selected.';

@bol;
text('if(@text_is_select' + 'ed)');
cr;
text('{');
cr;
text("  return();");
cr;
text('}');
cr;

@say(fp);
}



//;;

void
@add_text_is_bullet_or_subbullet
{
str fp = 'Add text is bullet or subbullet.';

@bol;
text('if(!@is_bullet_or_subbullet)');
cr;
text('{');
cr;
text("  return();");
cr;
text('}');
cr;

@say(fp);
}



//;; (skw known duplicate, official duplicate)

void
@add_text_for_sanctioned_dup
{

str fp = "Add text for sanctioned duplicate entry.";

@eol;

if(@previous_character != ' ')
{
  text(' ');
}

text("(sanctioned duplicate entry)");

@say(fp)
}



//;+ Convert Line Macros



//;;

void
@convert_line_to_sentence_case()
{
str fp = 'Convert current line to sentence case.';

@eoc;

str First_Character_in_Sentence;
First_Character_in_Sentence = @current_character;
First_Character_in_Sentence = @upper(First_Character_in_Sentence);
del_char;
text(First_Character_in_Sentence);

if(find_text(@lookup_counter, 1, _regexp))
{
  left;
  left;
}
else
{
  eol;
}

switch(@previous_character)
{
  case '.':
  case '?':
  case '!':
    break;
  default:
    text('.');
    if(@current_character == ':')
    {
      @delete_character;
    }
}

/* Use Cases

Use Case - Jan-18-2010

- That's not saying much. lk#2

- Hhat's not saying much. lk#2

- That's not saying much.
- That's not saying much?
- That's not saying much. lk#2
- That's not saying much. lk#2

- That's not saying much.
- That's not saying much?
- That's not saying much.

*/

@say(fp);
}



//;;

str
@convert_line_to_proper_case()
{
str fp = "Convert line to proper case. This is my new version that does not capitalize 'of'.";

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
    if((line_Product != ':') && (line_Product != ''))
    {
      switch(@trim(lower(word_Chunk)))
      {
        case 'and':
        case 'of':
        case 's':
        case 't':
          word_Chunk = lower(str_char(word_Chunk, 1)) + lower(str_del(word_Chunk, 1, 1));
          break;
        default:
          break;
      }
    }
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
@convert_line_to_lower_case()
{
str fp = 'Convert line to lower case.';

if(@text_is_selected)
{
  str selected_Text = @get_selected_text;
  delete_block;
  text(lower(selected_Text));
  @say(fp);
  return();
}

/* Use Case(s)

- 1. Use Case on Dec-21-2011: hey now

*/

put_line(lower(get_line));
@say(fp);
}



//;;

void
@convert_line_to_sent_and_proper()
{
str fp = "Convert line to sentence and proper case.";

@convert_line_to_proper_case;
@convert_line_to_sentence_case;

@say(fp);
}



//;;

void
@convert_line_to_sent_and_lower
{
str fp = 'Convert line to sentecne and lower case.';

@convert_line_to_lower_case;
@convert_line_to_sentence_case;

@say(fp);
}



//;;

void
@convert_line_to_wikipedia_case
{
str fp = 'Convert current line to wikipedia case, which is the same as sentence case without
  the period.';
@header;

put_line(lower(get_line));
str Action_Line = get_line;

Action_Line = @trim_leading_colons_et_al(Action_Line);

str first_character = str_char(Action_line, 1);
first_character = caps(first_character);

@say(First_Character);

// Delete the first character so we can replace it with it's uppercase equivalent.
Action_Line = str_del(Action_Line, 1, 1);
Action_Line = First_Character + Action_Line;

@say(Action_Line);

str Current_Character;
int Cursor_Position = 1;
str Colon_String = '';
int Length_of_Subject_Line = length(get_line);
str Subject_Line = get_line;
while(Cursor_Position <= Length_of_Subject_Line)
{
  Current_Character = Str_Char(Subject_Line, Cursor_Position);
  if(Current_Character == ':')
  {
    Colon_String += ':';
  }
  Cursor_Position += 1;
}

del_line;
cr;
up;
put_line(Colon_String + Action_Line);

/* Use Cases

- That's not saying much

*/

@footer;
@say(fp);
}



//;;

void
@convert_line_to_upper_case()
{
str fp = 'Convert line to upper case.';

str subject = get_line;

if(@text_is_selected)
{
  subject = @get_selected_text;
}

put_line(caps(subject));
@say(fp);
}



//;;

void
@convert_line_to_question_case()
{
str fp = 'Convert current line to question case.';

@eoc;

str First_Character_in_Sentence;
First_Character_in_Sentence = @current_character;
First_Character_in_Sentence = @upper(First_Character_in_Sentence);
del_char;
text(First_Character_in_Sentence);

if(find_text(@lookup_counter, 1, _regexp))
{
  left;
  left;
}
else
{
  eol;
}

switch(@previous_character)
{
  case '.':
    @backspace;
    break;
  case '?':
    break;
  default:
    text('?');
}

@say(fp);
}



//;;

str
@convert_line_to_function_name
{
str fp = 'Convert sentence to function name.';
@header;

@copy_and_paste_line;
@convert_line_to_lower_case;
str Current_Line = get_line;

Current_Line = @trim_before_character(Current_Line, char(34));
Current_Line = @trim_before_character(Current_Line, char(39));
Current_Line = '@' + Current_Line;
Current_Line = @commute_character(Current_Line, ' ', '_');
Current_Line = @commute_character(Current_Line, ',', '');
Current_Line = @trim_after_character(Current_Line, '.');

if(length(Current_Line) > 32)
{
  Current_Line = @left(Current_Line, 32);
}
else
{
  Current_Line = @trim_after_character(Current_Line, '.');
}

//Current_Line += '()';
put_line(Current_Line);
@cut;
str so;

@bobs;

down;
down;
down;
@bol;
@delete_line;
@paste;
up;
eol;
@hc_word_uc;

@footer;
@say(fp);
}



//;;

void
@convert_line_to_dashes
{
str fp = 'Replace text spaces and underscores with dashes.';

str Current_Line;
Current_Line = get_line;
Current_Line = @commute_character(Current_Line, ' ', '-');
Current_Line = @commute_character(Current_Line, '_', '-');
put_line(Current_Line);

@say(fp);
}



//;;

void
@convert_line_to_spaces()
{
str fp = 'Replace text dashes or underscores with spaces.';

str Current_Line;
Current_Line = get_line;
Current_Line = @commute_character(Current_Line, '-', ' ');
Current_Line = @commute_character(Current_Line, '_', ' ');
put_line(Current_Line);

@say(fp);
}



//;;

void
@convert_line_to_underscores()
{
str fp = 'Replace text spaces and dashes with with underscores.';

str Current_Line;
Current_Line = get_line;
Current_Line = @commute_character(Current_Line, ' ', '_');
Current_Line = @commute_character(Current_Line, '-', '_');
put_line(Current_Line);

@say(fp);
}



//;;

str
@convert_line_to_sql_server_dbnm
{
str fp = 'Convert line to sql server database name.';
@header;

@convert_line_to_lower_case;
str Current_Line = get_line;
Current_Line = @commute_character(Current_Line, '.', ' ');
Current_Line = @commute_character(Current_Line, '-', ' ');
Current_Line = @commute_character(Current_Line, '\', ' ');
Current_Line = @commute_character(Current_Line, ' ', '_');

@delete_line;
cr;
up;
text(Current_Line);

/* Use Case(s)

- px_6_0_2_package_deployment_30_january_2009

- PX 6.0.2 Package - Deployment - 30 January 2009

*/

@footer;
@say(fp);
}



//; Dangerous Macro (skw lower case, lower_case, convert_file_to_lowercase)

void
@convert_file_to_lower_case()
{
str fp = 'Convert file to lower case.';

if(!@is_text_file)
{
  return();
}

tof;
while(!at_eof)
{
  @convert_line_to_lower_case;
  down;
}

@say(fp);
}



//;+ Move to First Position (!firstp)



//;; first position

void
@move_line_to_firstp_wme()
{
str fp = "Move line to p1 with me.";

// fcd: Nov-18-2014

block_off;
@cut;
tof;
@paste;
up;

@say(fp);
}



//;;

void
@move_line_to_firstp_alone()
{
str fp = "Move line to p1 alone.";

// fcd: Nov-18-2014

@save_location;

@move_line_to_firstp_wme;

@restore_location;

@say(fp);
}



//;;

void
@move_subbullet_to_firstp_wme()
{
str fp = 'Move subbullet to the first position with me.';

if(@query_previous_bsr == 'bullet')
{
  @say('You are ALREADY the first child subbullet.');
  return();
}

@cut_subbullet;
up;
@bob;
@find_next_content_area;
@bol;
@paste;
@find_previous_subbullet;

/* Use Case(s)

Use Case Jan-22-2009: You are on the last bullet in a rubric on the first subbullet and there
are no other subbullets.

*/

@say(fp);
}



//;;

void
@move_subbullet_to_firstp_alone()
{
str fp = "Move line to p1 alone.";

// fcd: Nov-18-2014

@save_location;

@move_subbullet_to_firstp_wme;

@restore_location;

@say(fp);
}



//;;

void
@move_subrubric_to_firstp_wme()
{
str fp = "Move subrubric to the first position with me.";

// fcd: May-19-2014

@cut_big_segment;
up;
@bor;
@find_next_big_segment;
@bol;
@paste;
@find_previous_big_segment;

@say(fp);
}



//;;

void
@move_subrubric_to_firstp_alone()
{
str fp = "Move subrubric to the first position alone.";

// fcd: May-19-2014

@header;

@save_location;

@move_subrubric_to_firstp_wme;

@restore_location;

@find_next_big_segment;

@footer;

@say(fp);
}



//;;

void
@move_rubric_to_firstp_wme()
{
str fp = "Move rubric to the first position with me.";

// fcd: Oct-21-2014

@cut_rubric;
@bof;
find_text('glass ceiling rubric', 0, _regexp);
@find_next_rubric;
@bol;
@paste;
@find_bor_or_previous_rubric;

@say(fp);
}



//;;

void
@move_rubric_to_firstp_alone()
{
str fp = "Move rubric to the first position alone.";

// fcd: May-19-2014

@header;

@save_location;

@move_rubric_to_firstp_wme;

@restore_location;

if(@current_line_type != 'rubric')
{
  @find_next_rubric;
}

@footer;

@say(fp);
}



//;;

void
@move_to_firstp(int return_home = parse_int('/1=', mparm_str))
{
str fp = "Move context object to first position.";

// fcd: Nov-18-2014

@header;

if(!@is_rubric_file)
{
  if(return_home)
  {
    @move_line_to_firstp_alone;
  }
  else
  {
    @move_line_to_firstp_wme;
  }
}
else
{
  switch(@current_area_type)
  {
    case 'subbullet':
      if(return_home)
      {
        @move_subbullet_to_firstp_alone;
      }
      else
      {
        @move_subbullet_to_firstp_wme;
      }
      break;
    case 'bullet':
      if(return_home)
      {
        @@run_bullet_action_model('-3');
      }
      else
      {
        @@run_bullet_action_model('-3w');
      }
      break;
    case 'subrubric':
      if(return_home)
      {
        @move_subrubric_to_firstp_alone;
      }
      else
      {
        @move_subrubric_to_firstp_wme;
      }
      break;
    case 'rubric':
      if(return_home)
      {
        @move_rubric_to_firstp_alone;
      }
      else
      {
        @move_rubric_to_firstp_wme;
      }
      break;
  }
}
@footer;
}



//;+

void
@move_current_rubric_w_dog_park()
{
str fp = "Move current rubric and dog park to eof.";

// fcd: Sep-22-2016

if(!@is_batch_file)
{
  return();
}

@bor;
@cut_rubric;
@eof;
@bol;
@paste;

@seek_from_bof('rfdp');

@bor;
@cut_rubric;

@eof;
@bol;
up;
@bor;
@paste;
@eof;
up;
up;
up;
up;
up;
up;
@eol;

@say(fp);
}



//;;

void
@@move_current_rubric_w_dog_park
{
@header;
@move_current_rubric_w_dog_park;
@footer;
}



//;+ Move to Last Position



//;;

void
@move_line_to_lastp_wme()
{
str fp = "Move line to last position with me.";

// fcd: Nov-18-2014

block_off;
@cut;
eof;
@bol;
@paste;

@say(fp);
}



//;;

void
@move_line_to_lastp_alone()
{
str fp = "Move line to last position alone.";

// fcd: Nov-18-2014

@save_location;

@move_line_to_lastp_wme;

@restore_location;

@say(fp);
}



//;;

void
@move_subbullet_to_lastp_wme()
{
str fp = 'Move subbullet to the last position with me.';

if(@query_next_bsr != 'subbullet')
{
  @say('You are ALREADY the last child subbullet.');
  return();
}

@cut_subbullet;

if(@find_next_bobs != 'bullet')
{
  up;
  up; 
}

@bol;
@paste;
@find_previous_subbullet;

@say(fp);
}



//;;

void
@move_subbullet_to_lastp_alone()
{
str fp = "Move line to last position alone.";

// fcd: Nov-18-2014

@save_location;

@move_subbullet_to_lastp_wme;

@restore_location;

@say(fp);
}



//;;

void
@move_subrubric_to_lastp_wme()
{
str fp = "Move subrubric to the last position with me.";

// fcd: May-19-2014

@cut_big_segment;
@find_next_rubric;
@bol;
@paste;
@find_previous_big_segment;

@say(fp);
}



//;;

void
@move_subrubric_to_lastp_alone()
{
str fp = "Move subrubric to the last position alone.";

// fcd: May-19-2014

@header;

@save_location;

@move_subrubric_to_lastp_wme;

@restore_location;

if(!@is_structured_line)
{
  @find_next_content_area;
}

@footer;

@say(fp);
}



//;;

void
@move_rubric_to_lastp_wme()
{
str fp = "Move rubric to the last position with me.";

// fcd: Oct-21-2014

@bor;
@cut_rubric;
@eof;
@bol;
@paste;
left;
@bor;

@say(fp);
}



//;;

void
@move_rubric_to_lastp_alone()
{
str fp = "Move rubric to the last position alone.";

// fcd: May-19-2014

@header;

@save_location;

@move_rubric_to_lastp_wme;

@restore_location;

if(@current_line_type != 'rubric')
{
  @find_next_rubric;
}

@footer;

@say(fp);
}



//;;

void
@move_to_lastp(int return_home = parse_int('/1=', mparm_str))
{
str fp = "Move context object to last position.";

// fcd: Nov-18-2014

@header;

switch(lower(get_extension(File_name)))
{
  case 'bat':
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



//;+ Reversing



//;;

void
@reverse_roles
{
str fp = 'Turn any subbullet into the parent bullet or turn the parent bullet into the first 
  child subbullet.';

if(!@is_bullet_File)
{
  return();
}

if((@current_area_type == 'bullet') and (@query_next_bsr != 'subbullet'))
{
  @say('Error: This macro only works with bullets with nested subbullets.');
  return();
}

@header;

// This is interesting code because now you know you are at the first child subbullet.
switch(@current_area_type)
{
  case 'bullet':
    @find_next_content_area;
    break;
  case 'subbullet':
    @move_subbullet_to_firstp_wme;
    break;
  default:
    @say('Error 2. This macro only works with bullets with nested subbullets.');
    return();
}

// This block of code is intended to satisfy the use cases below. Jun-21-2012
@cut_subbullet;
left;
@bob;

text(@bullet_text);
@bol;
@paste;
@find_previous_subbullet;
@bol;
del_char;

/* Use Case(s)

2. Use Case on Jun-21-2012:
Parent with one child followed by a bullet.

1. Use Case on Jun-20-2012:
The case where you have a parent with a single child at the end of a rubric.

*/

@footer;
@say(fp);
}



//;;

void
@reverse_roles_for_rubrics
{
str fp = 'Turn any subrubric into the parent rubric or turn the parent rubric into the first 
  child subrubric.';
fp = 'Reverse roles for big segments.';

if(!@is_rubric_File)
{
  return();
}

if(@count_big_segments < 2)
{
  fp += ' Error: There must be at least 2 big segments upon which to work.';
  @say(fp);
  return();
}

int is_Last_Big_Segment = false;
int is_Rubric = false;

if(@is_last_big_segment)
{
  is_Last_Big_Segment = true;
}

@header;

switch(@current_area_type)
{
  case 'rubric':
    fp += ' (rubric)';
    is_Rubric = true;
    break;
  case 'subrubric':
    fp += ' (subrubric)';
    //@cut_big_segment;
    break;
  default:
    @say('Error: This macro only works with rubrics with nested subrubrics.');
    return();
    break;
}

@footer;
@say(fp);
}



//;+ Move to Last Position (!lastp)



//;;

void
@move_rubric_to_eof
{
str fp = "Move rubric to eof.";

mark_pos;
@bor;
@cut_rubric;
@eof;
@bol;
@paste;
goto_mark;
@say(fp);
}



//;;

void
@move_subbullet_to_last_ps_wme()
{
str fp = 'Move subbullet to the last child position with me.';

if(@query_next_bsr != 'subbullet')
{
  @say('You are ALREADY the last child subbullet.');
  return();
}

@cut_subbullet;

if(@find_next_bobs != 'bullet')
{
  up;
  up; 
}

@bol;
@paste;
@find_previous_subbullet;

@say(fp);
}



//;; (skw last_child, last_sibling, last_amoung_siblings)

void
@move_subbullet_to_last_pos()
{
str fp = 'Move subbullet to the last child position.';

if(@query_next_bsr != 'subbullet')
{
  @say('You are ALREADY the last child subbullet.');
  return();
}

mark_pos;
@cut_subbullet;
if(@find_next_bobs != 'bullet')
{
  up; 
  up; 
}

@bol;
@paste;
goto_mark;

@say(fp);
}



//;;

void
@move_subbullet_to_firstp()
{
str fp = 'Move subbullet to the first position.';

if(@query_previous_bsr == 'bullet')
{
  @say('You are ALREADY the first child subbullet.');
  return();
}

int Current_Column = @current_column;
@cut_subbullet;
left;
@bob;
@find_next_content_area;
@bol;
@paste;
goto_col(Current_Column);

/* Use Case(s)

Use Case Jan-22-2009: You are on the last bullet in a rubric on the first subbullet and there
are no other subbullets.

*/

@say(fp);
}



//;;

void
@move_to_lastp_wme
{
str fp = "Move to last position with me.";

// fcd: Nov-11-2014

@header;
@move_to_lastp(false);
@footer;

@say(fp);
}



//;;

void
@move_to_lastp_alone
{
str fp = "Move to last position alone.";

// fcd: Nov-11-2014

@header;
//@move_to_lastp(true);
@footer;

@say(fp);
}



//;+ Model X



//;; (!2mmx)

void
@model_x
(
  str action = parse_str('/1=', mparm_str), 
  str lc = parse_str('/2=', mparm_str))
{

str fp = "Model X.";

str default_action = 'move';
str default_rubric_position = 'beginning';
str default_campanionship = 'with_me';

@header;

// fcd: Apr-15-2016

lc = @trim_before_character(action, '.');

//Is leading period
if(@left(lc, 1) == '.')
{
  lc = @trim_left(lc, 1);
}

lc = @trim_before_character(lc, '.');

str debug_string = 'action: (' + action + ')';
debug_string += ', lc: (' + lc + ')';

// Is leading period.
if(@left(action, 1) == '.')
{
  action = @trim_left(action, 1);
}

action = @trim_after_character(action, '.');

if(action == '')
{
  action = default_action;
}
else if(action == 'c')
{
  action = 'copy';
}

str debug_string = 'action: (' + action + ')';
debug_string += ', lc: (' + lc + ')';
//@say(debug_string); return();

if(action == 'copy')
{
  @copy_bullet_to_remote_bor_wme(lc);
}
else if(action == 'move')
{
  @move_bullet_to_lc_wme(lc);
}


@footer;
@say(fp);
}



//;;

void
@model_x_test_harness
{
str fp = "";

// fcd: Apr-15-2016
@model_x('sub.marine', '');
@model_x('..bowe', '');
@model_x('.c.bowe', '');

}



//;

void
@find_lc_using_user_input()
{
str fp = "Find LC using user input.";

// fud: Sep-13-2016

int found = @find_lc('');

if(@is_bullet_file)
{
  if(@is_big_segment)
  {
    @find_next_bullet;
  }
}

if(!found)
{
  fp += ' LC NOT found.';
}

@say(fp);
}



//;

void
@find_specialty_string(str arguments = parse_str('/1=', mparm_str))
{
str fp = "Find specialty string.";

// fcd: Nov-28-2016

str arg1, arg2, arg3, arg4;
str search_target;

if(arguments == "")
{
  arguments = @get_user_input_nonspace(fp);
  if(arguments == @constant_function_aborted)
  {
    @say(@constant_function_aborted);
    return();
  }
}

@parse_aguments_4_parameters(arguments, ".", arg1, arg2, arg3, arg4);

//@say(fp + ' arg1: ' + arg1 + ', arg2: ' + arg2 + ' (Nov-28-2016 3:04 PM)');return();

if(arg2 == "")
{
  if(@find_lc(arg1))
  {
    @process_move_marker;
    @say(fp + ' (' + arg1 + ')');
  }
  else
  {
    @say(fp + ' NOT found. (' + arg1 + ')');
  }
  @footer;
  return();
}

switch(arg2)
{
  case 'b':
  case 'l':
  case 'bfl':
    search_target = 'bfl';
    break;
  case 'c':
  case 'cm':
    search_target = 'cm';
    break;
  case 'h':
  case 'r':
  case 'rh':
    search_target = 'rh';
    break;
}

switch(search_target)
{
  case 'bfl':
    str sc = arg1;
    sc = make_literal_x(sc);
    sc = '^:' + sc + '$';
    @bof;
    @seek_in_all_files_2_arguments(sc, fp);
    break;
  case 'cm':
    str sc = arg1;
    sc = @equate_spaces_and_underscores(sc);
    sc = ".*" + sc;
    @find_cmac_definition(sc, 0);
    break;
  case 'rh':
    @find_in_big_segment_header_uc(arg1);
    break;
}

/*
:specialty string search

::ui

::uc

::sj

::partial search

::exact match

::lc

::rubric header

::batch file label

::cmac method name

*/


@footer;
@say(fp);
}



//;

void
@find_specialty_string_l1(str arguments = parse_str('/1=', mparm_str))
{
str fp = "Find specialty string.";
@header;
@find_specialty_string(arguments);
@footer;
}



//;

int
@count_lines_in_bullet()
{
str fp = 'Count the number of lines in this bullet.';

int first_line_in_bullet;
int last_line_in_bullet;
int Number_of_Lines_in_bullet = 0;

mark_pos;

@bob;

First_Line_in_bullet = @current_line_number;
@find_next_bobs;
last_line_in_bullet = @current_line_number;
number_of_lines_in_bullet = last_line_in_bullet - first_line_in_bullet;

goto_mark;

if(number_of_lines_in_bullet == 0)
{
  number_of_lines_in_bullet = 1;
}

return(number_of_lines_in_bullet);
}



//;

void
@restore_location_2()
{
str fp = "Load previously saved location and check for edge case.";

int i = 0;
int lines_in_bullet = @count_lines_in_bullet;

if(@is_last_bullet)
{
  lines_in_bullet -= 2;
}

@restore_location;

while(i < lines_in_bullet)
{
  down;
  i++;
}

fp = 'i: ' + str(i);
fp = 'lines_in_bullet: ' + str(lines_in_bullet);
@say(fp);
}



//;

void
@make_a_copy_work_with_the_copy
{
str fp = "Make a copy, work with the copy.";

if(!@is_batch_file)
{
  return();
}

@header;

// fcd: Sep-22-2016

@bor;
@copy_and_paste_rubric;
@move_current_rubric_w_dog_park;

@footer;
@say(fp);
}



//;EOF << (!eflm)