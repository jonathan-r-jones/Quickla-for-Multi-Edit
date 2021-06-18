macro_file Jonathan's_Macros; // (!jo, !jm)

// Miscellaneous macros.

#include Aliases.sh  // One of my guys.
#include Clif.sh     // One of my guys.
#include Finder.sh   // One of my guys.
#include Format.sh   // One of my guys.
#include ListMgr.sh  // One of my guys.
#include Regexes.sh  // One of my guys.
#include Searcher.sh // One of my guys.
#include Shared.sh   // One of my guys.

#include WinExec.sh  // Used by 'Execprog'.



//;

/*

Metadata: Track Size (!tsjm)

    Date       Lines    Bytes    Macros   Notes
 -----------  ------  ---------  -------  ----------------------------------------------------

: Jan-4-2021   7,841    106,508      279

:Oct-12-2020   7,838    106,455      279

: Jul-2-2020   7,805    105,997      278

: Apr-8-2020   7,645    104,255      274

:Nov-11-2019   7,645    104,047      274

:Jun-23-2019   7,546    102,690      271

:Apr-26-2019   7,554    103,198      269

: Jan-1-2019   7,312    100,686      259

: Aug-2-2018   7,215     99,571      257

: Jul-1-2018   6,959     95,708      249

:May-17-2018   6,845     94,525      245

: May-7-2018   6,844     94,447      246

: Apr-3-2018   6,961     95,847      249

: Jan-3-2018   6,821     94,186      244

: Dec-5-2017   6,729     93,302      241

:Jun-25-2017   6,456     89,494      231

:Jun-21-2017   6,454     89,450      231

:May-17-2017   6,459     89,713      229

:Mar-31-2017   6,277     86,561      224

: Dec-2-2016   5,992     83,208      214

:Nov-17-2016   5,796     80,742      208

: Oct-7-2016   5,724     78,939      210

:Sep-21-2016   5,619     77,633      206

: Apr-8-2016   5,293     73,482      195

:Dec-31-2015   5,159     72,566      194

: Oct-5-2015   4,950     69,294      189

: Jul-1-2015   4,485     62,787      167

: Apr-1-2015   4,109     58,951      146

:Jan-16-2015   3,754     54,671      129

: Oct-1-2014   3,516     51,508      123

: Jul-1-2014   3,437     50,526      120

:Apr-10-2014   3,683     54,080      125

: Apr-1-2014   3,500     51,790      121

: Oct-1-2013   2,985     44,218      107

: Jul-1-2013   2,961     43,868      106

: Apr-1-2013   2,834     42,058      101

: Jan-2-2013   2,830     41,964      101

: Oct-1-2012   2,775     41,152       99

:Aug-30-2012   2,749     40,752       98

: Jul-3-2012   2,645     38,949       87  Cleaned out some unused methods.

:Jun-22-2012   2,830     41,035       94

: Apr-2-2012   2,781     40,223       92

- Jan-2-2012   2,496     36,625       80

-Dec-30-2011   2,477     36,436       79

-Dec-20-2011   2,688     39,342       83

- Dec-9-2011   2,590    37,477      82

- Dec-8-2011   2,799    42,052      94

- Oct-3-2011   3,574    50,716     126

- Aug-1-2011   3,469    49,438     122

- Jul-15-2011  3,467    49,393     122

- Jun-1-2011   3,473    49,378     122

- Apr-1-2011   3,406    49,018     118

- Mar-1-2011   3,502    50,381     120

- Feb-1-2011   3,514    50,529     121

- Jan-18-2011  3,514    50,183     119 This is the day I created format.s and moved a lot of 
                                      stuff form this file to there and to ListMgr.s.

- Jan-5-2011  10,003   144,609     312

- Jan-4-2011  10,002   144,545     312

- Jan-4-2011  13,548   192,317     424 Major reorganization regarding "find" functions and 
                                      moving appropriate stuff from here to ListManager.s.

- Jan-2-2011  16,221   228,137     501

- Dec-1-2010  16,210   227,993     503

- Nov-1-2010  16,046   224,964     499

- Oct-1-2010  15,847   221,979     493

- Sep-1-2010  15,395   216,670     483

- Aug-2-2010  15,274   215,488     478

- Jul-1-2010  15,082   213,172     471

- Jun-1-2010  14,846   209,895     462

- May-3-2010  14,760   208,411     460

- Apr-1-2010  14,706   207,524     456

- Mar-1-2010  14,666   207,033     456

- Feb-1-2010  14,645   205,828     456

- Jan-8-2010  14,534   204,510     452 The creation of Code Graveyard has caused a lot of old
                                      functions to be placed there.

- Jan-2-2010  14,866   210,777     465

- Dec-9-2009  20,976   307,676     717 Calvin is at line 3584. (about 68 pages)
                                      This is the BEFORE picture of me moving the top part of 
                                      the file my stuff to Aliases.s. Remember Aliases = what 
                                      I used to think of as "Calvin".

- Dec-9-2009  20,978   307,573     718

- Dec-7-2009  20,853   305,838     712 Moved regular expressions into its own file.

- Dec-1-2009  21,140   308,701     721 The height of macros in this file.

- Dec-1-2009  21,080   307,616     719

- Nov-24-2009 20,715   303,086     704

- Nov-9-2009  20,311   299,036     690

- Nov-2-2009  20,075   295,477     685

- Oct-1-2009  19,794   290,770     681

- Sep-1-2009  18,760   277,119     660

- Aug-25-2009 18,381   273,146     647

- Jul-6-2009  17,012   257,327

- Jun-1-2009  16,831   256,725

- May-1-2009  16,532   251,955

- Apr-1-2009  16,010   244,717

- Mar-31-2009 15,910   243,596

- Mar-19-2009 15,782   242,050 I heard that Iron Python was about 40,000 lines of code.

- Mar-17-2009 15,645   240,230

- Feb-6-2009  14,233   222,282 At 65 lines per page, this equals 219 pages.

- Jan-5-2009  13,778   216,696

- Dec-3-2008  13,216   211,286

- Nov-3-2008  12,162   193,040

- Oct-1-2008  11,766   186,561

- Sep-17-2008 11,290   180,534 Deleted a lot of deadwood from this file.

- Jul-1-2008  12,411   191,398

- Jun-2-2008  11,552   179,980

- May-29-2008 11,020   172,289

- May-29-2008    438    14,827 UNASSKEY: Listed here for comparison purposes.

- May-1-2008   9,851   157,603

- Apr-8-2008   9,606   152,539 Deleted some deprecated stuff.

- Apr-8-2008   9,820   158,997 Made a lot of changes today regarding "@header;" and 
"@footer;".

- Apr-1-2008  10,110   163,936

- Mar-28-2008  9,908   160,995 Made major changes in the past 2 days.

- Mar-27-2008 10,204   164,276 Moved CMAC Code Keeperes rubric to its own file.

- Mar-10-2008  9,933   163,333 Performed a lot of cleanup while writing _List_Jonathans_Macros.

- Feb-4-2008   8,814   148,536 At 65 lines per page, this equals 136 pages.

- Jan-16-2008  8,584   145,283 Deleted a bunch of old macros.

- Dec-17-2007  8,521   147,061

- Nov-11-2007  8,334   143,890

- Oct-25-2007  8,340   143,865

- Aug-13-2007  7,269   123,968

- Jun-18-2007  6,677   113,665

- Jun-13-2007  6,339   109,099

- Jun-2-2007   6,170   108,409 Cleaned out the file.

- May-29-2007  6,418   113,435

- Apr-17-2007  5,933   106,128

- Mar-2-2007   5,266    94,768 At 65 lines per page, this equals 81 pages.

- Feb-11-2007  5,208    93,874

- Jan-3-2007   5,033    90,553

- Dec-5-2006   4,996    89,529

- Nov-15-2006  4,973    89,002

- Oct-4-2006   4,904    87,916

- Sep-9-2006   4,825    86,301

- Aug-19-2006  4,835    86,477

- Jul-30-2006  4,833    86,444

- Jun-7-2006   4,790    84,737

- May-3-2006   4,731    81,790

- Apr-8-2006   4,706    81,204

- Mar-4-2006   4,883    83,088 At 65 lines per page, this equals 75 pages.

- Feb-2-2006   4,842    81,782

- Jan-2-2006   4,816    81,559

- Dec-1-2005   4,798    81,230

- Nov-5-2005   4,782    80,884

- Oct-5-2005   4,776    81,172

- Sep-12-2005  4,839    82,351

- Aug-28-2005  4,837    82,318

- Jul-11-2005  4,760    80,680

- Jun-12-2005  4,762    80,648

- May-19-2005  4,742    81,547

- Apr-11-2005  4,480    77,171 At 65 lines per page, this equals 69 pages.

- Jan-15-2005  4,387    76,181 At 65 lines per page, this equals 67 pages.

- Dec-6-04     4,134    72,737

- 11-06-04     4,021    70,740

- 10-26-04     4,019    70,654 At 65 lines per page, this equals 62 pages.

- 10-02-04     3,879    67,494

- 05-03-04     3,786    66,106

- 04-05-04     3,751    65,470

- 03-03-04     3,630    63,018

- 07-10-03     3,310    59,310

- 08-01-02     2,857    51,076

- 07-19-02     2,780    49,693

- 07-09-02     2,417    42,793

- 06-14-02     2,330    37,960

- 05-22-02     2,409    44,109

*/



//;+ Add CMAC stubs. Simple CMAC Code Generators.



//;;

void
@add_cmac_stub_1(str sc = parse_str('/1=', mparm_str))
{
str fp = 'Add CMAC stub for a bare bones macro.';

// skw cmac1, sm1, sn1

str so;

if(sc == '')
{
  rm("@open_file_with_writability /FN=" + Get_Environment('savannah') +
    "\\cmac\\Quickla-for-Multi-Edit\\\Jonathan's_Macros.s");
  eof;
}
else
{
  @find_next_big_segment;
}

@bol;
text('//;');
cr;
cr;
text('void');
cr;
text('@rt' + 'm');
cr;
text('{');
cr;
text('str fp = "x');
text('";');
cr;
cr;
text('// lu: ');
@add_text_date;
cr;
cr;
cr;
text('//q' + 'q-1');
cr;
cr;
text('@say(fp);');
cr;
text('}');
cr;
cr;
cr;
cr;
up;
@bor;
@seek('q');
up;
@bol;
@say(fp);
}



//;;

void
@add_cmac_stub_tn
{
str fp = 'Add CMAC stub for test harness below.';

@bobs;
down;
down;
down;
@hc_word_uc;
@find_next_big_segment;
@bol;
text('//;;');
cr;
cr;
text('void');
cr;
@paste;
text('_tn');
cr;
text('{');
cr;
text('str fp = "";');
cr;
cr;
text('// fud: ');
@add_text_date;
cr;
cr;
cr;
text('//q' + 'q-1');
cr;
cr;
text('@say(fp);');
cr;
text('}');
cr;
cr;
cr;
cr;
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
@eol;
left;
left;
@say(fp);
}



//;;

void
@add_cmac_stub_1_below
{
@header;
@add_cmac_stub_1('below');
@footer;
}



//;;

void
@add_cmac_stub_1_l1
{
@header;
@add_cmac_stub_1('');
@footer;
}



//;;

void
@add_cmac_stub_2
{
str fp = 'Add CMAC stub for standard macros.';
str so;
@header;

rm("@open_file_with_writability /FN=" + Get_Environment('savannah') +
  "\\cmac\\Quickla-for-Multi-Edit\\\Jonathan's_Macros.s");

eof;
push_undo;
@bol;
text('//;');
cr;
cr;
text('void');
cr;
text('@rt' + 'm');
cr;
text('{');
cr;
text('str fp = "x');
text('";');
cr;
cr;
text('// lu: ');
@add_text_date;
cr;
cr;
text("@header;");
cr;
cr;
cr;
text('//q' + 'q-1');
cr;
cr;
text("@footer;");
cr;
text('@say(fp);');
cr;
text('}');
cr;
cr;
cr;
cr;
@seek_previous('q' + 'q', so);
up;
@bol;

@footer;
@say(fp);
}



//;;

void
@add_cmac_stub_3
{
str fp = 'Add CMAC stub for searching.';
str so;
@header;

rm("@open_file_with_writability /FN=" + Get_Environment('savannah') +
  "\\cmac\\Quickla-for-Multi-Edit\\\Jonathan's_Macros.s");

@eof;
@bol;
text('//;');
cr;
cr;
text('void');
cr;
text('@rt' + 'm');
cr;
text('{');
cr;
text('str fp = "x');
text('";');
cr;
cr;
text("// lu: ");
text(@get_date);
cr;
cr;
text("str rs;");
cr;
text("str sc;");
cr;
cr;
text("@header;");
cr;
text("sc = '';");
cr;
text("  //q" + "q-1");
cr;
text("@eol;");
cr;
cr;

text("@seek(sc);");
cr;
text("return();");
cr;
text("rs = '\\0';");
cr;
text("@replace_next_occurrence_only(sc, rs);");
cr;
text("@replace_all_occurrs_inf_one_tof(sc, rs);");
cr;
text("int is_found = @seek_in_all_files_2_arguments(sc, fp);");
cr;
cr;
text("@footer;");
cr;
text('@say(found_str);');
cr;
text('@say(fp);');
cr;
text('}');
cr;
cr;
cr;
cr;
@seek_previous('sc =', so);
eol;
left;
left;

@footer;
@say(fp);
}



//;;

void
@add_cmac_stub_4
{
str fp = 'Add CMAC stub for an alias wrapped in header and footer.';

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
text('@');
@paste;
eol;
cr;
text('{');
cr;
text('@header;');
cr;
@paste;
eol;
text(';');
cr;
text("@footer;");
cr;
text('}');
cr;
cr;
cr;

@bobs;
eol;

@say(fp);
}



//;;

void
@add_cmac_stub_5
{
str fp = 'Add CMAC stub above.';

block_off;
@bobs;

@bol;
cr;
up;
text('//;;');
cr;
cr;
text('void');
cr;
@paste;
eol;
text('()');
cr;
text('{');
cr;
text('str fp = "";');
cr;
cr;
text('// lu: ');
@add_text_date;
cr;
cr;
cr;
text('//q' + 'q-1');
cr;
cr;
text('@say(fp);');
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
up;
up;

@say(fp);
}



//;

void
@add_tsql_stub_1
{
str fp = 'Add T-SQL stub for a bare bones test method.';
str sc = '\(!p' + 'r,';
str so;

@header;

@seek_in_all_files_2_arguments(sc, fp);

@bol;
cr;
cr;
cr;
cr;
up;
up;
up;
up;
text('--; Next Test Object ' +
  '*************************************************************************');
cr;
text("if object_id(N'sp_test@', N'P') is not null");
cr;
text("  drop procedure sp_test@");
cr;
text("go");
cr;
cr;
cr;
cr;
text("create procedure sp_test@");
cr;
cr;
text("as");
cr;
text("begin");
cr;
cr;
cr;
text("--(!q" + "q)");
cr;
text("print char(13) + char(13)");
cr;
cr;
text("end");
cr;
text("go");
@seek_previous('q' + 'q', so);
up;
@bol;

@footer;
@say(fp);
}



//;

void
@compile_phone_list_7
{
str fp = 'Compile phone list.';
@header;

// The splitting of the first open bracket from the following text
// is done so as to avoid this line showing up in the resultant phone file.
str sc = ':<' + 'plb>';

int Amount;
int Found_Counter = 0;
int Handle;
int Result;
int Starting_Window = cur_window;
int Window_Counter = 0;

str Filename = Get_Environment('reach out') + '\Savannah Summary.txt';

Result = S_Create_File(Filename, Handle);

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
      Line = @trim_leading_colons_et_al(get_Line);
      Result = S_Write_Bytes(Line, Handle, Amount);
      Result = S_Write_Bytes(LINE_TERMINATOR, Handle, Amount);
      down;
      @bol;
      while(!find_text(':</plb>', 1, _regexp))
      {
        line = get_line;
        Result = S_Write_Bytes(Line, Handle, Amount);
        Result = S_Write_Bytes(LINE_TERMINATOR, Handle, Amount);
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
load_file(Filename);

@footer;
@say(fp);
}



//; (readkey, read_key)

void
@show_key()
{
@say('Type a key or key combination to see its mapping:');
working;
read_key;

/* Use Case - May-12-2011

           key1 key2
           ---- ----
Alt+Ctrl+a  65   13
Alt+Ctrl+b  66   13
    Ctrl+a  65    5
Alt+Ctrl+- 109   13

*/

@say("Key 1 = " + str(key1) + " and Key 2 = " + str(key2));
}



//;

void
@toggle_read_only_attribute
{
str fp = "Toggles the current file's read-only attribute.";
@header;

if(read_only)
{
  read_only = false;
}
else
{
  read_only = true;
}

@footer;
@say(fp);
}



//;+ The Jumps



//;;

void
@jump
{
str fp = 'How high? May-11-2021_1_58_PM';
@say(fp);
}



//;;

str
@jump2()
{
str fp = 'How high really? Jump 2.';
return(fp);
}



//;;

str
@jump3()
{
str fp = 'Jump 3!';
set_global_str('cmac_return_string', fp);
@say(fp);
return(fp);
}



//;

void
@search_wikipedia_current_topic
{
str fp = 'Open current Wikipedia topic.';
@header;

if(!@find_lc_known(fp, 'wc'))
{
  return();
}

@search_wikipedia('', 0);

@footer;
@say(fp);
}



//;

void
@open_wiki_topic_for_printing
{
str fp = "Open wikipedia topic in print mode.";

@search_wikipedia('', 3);

@say(fp);
}



//;

void
@count_word
{
str fp = "Count all occurrences of a particular word or phrase, from user input, in a file.";

// At this time, this macro is NOT a word search, but a string search only. Feb-1-2010

str sc;
str so;

@header;

sc = @get_user_input_raw(fp);

int Number_of_Occurrences = 0;

tof;

while(!at_eof)
{
  if(!@seek_next(sc, so))
  {
    break;
  }
  Number_of_Occurrences++;
}

@footer;
@say('Found ' + str(Number_of_Occurrences) + ' occurrence(s) of ' + char(34) + sc + char(34) +
 ' in this file.');

}



//;

void
@archive_big_segment
{
str fp = "Archive big segment Oct-6-2020_1_39_PM.";

// lu: Oct-6-2020

if(!((@is_s_file) or (@is_bullet_file) or (@is_batch_file) or (@is_jenkinsfile)))
{
  @say(fp + " Error: This macro doesn't work with the current file type.");
  @say(fp);
  return();
}

@header;

@save_location;

@bobs;

@cut_big_segment;

if(@is_s_file)
{
  @open_file(get_environment('savannah') + 
    "\\cmac\\Quickla-for-Multi-Edit\\\cmac code graveyard.s");
}
else if(@is_bullet_file)
{
  @open_file(get_environment('savannah') + 
    "\\miscellany\\historical rubrics.asc");
}
else if(@is_batch_file)
{
  @open_file(get_environment('composable_batch_files') + 
    "\\batch file code archive.bat");
}
else if(@is_jenkinsfile)
{
  @open_file(get_environment('share-zone') + '\\Jenkinsfiles\\Jenkinsfile_Code_Keepers')
}

@bof;

@paste;

@close_and_save_file_wo_prompt;

@restore_location;

@bobs;

@footer;

@say(fp);
}



//;

void
@mark_block_to_eof
{
str fp = 'Mark block to EOF.';
@header;

block_begin;
eof;
block_end;

@say(fp);
}



//;

void
@compile_joma
{
str fp = "Compile Joma.";

// Needs that highlight_bullet integration trick.

int Initial_Window = @current_window;
rm("@open_file_parameter_way /FN=" + Get_Environment('savannah') 
  + "\\cmac\\Quickla-for-Multi-Edit\\\Jonathan's_Macros.s");
rm("Compile /F=" + Get_Environment('savannah') +
   "\\cmac\\Quickla-for-Multi-Edit\\\Jonathan's_Macros.s /C=C:\\Program Files\\Multi-Edit 2008\\CmacWin.exe");

@load_my_macros_into_memory_1;

switch_window(Initial_Window);

@say(fp);
}



//; (skw query_ascii_character, query ascii character, identify ascii character)

void
@query_current_character
{
str fp = "Query current character.";
rm('Ascii^QueryCurChar /M=1');
}



//;+ Add Metadata



//;;

void
@add_text_metadata()
{
str fp = 'Add metadata';

mark_pos;

eof;

str number_of_lines_in_file = str(c_line);
@add_commas_to_a_number(Number_of_Lines_in_File);
while(length(number_of_lines_in_file) < 6)
{
  number_of_lines_in_file = ' ' + number_of_lines_in_file;
}

str File_Size = str(cur_file_size);
@add_commas_to_a_number(File_Size);
while(length(File_Size) < 9)
{
  File_Size = ' ' + File_Size;
}

str Date_Stamp = @get_formatted_date;
while(length(Date_Stamp) < 11)
{
  Date_Stamp = ' ' + Date_Stamp;
}

str Number_of_Rubrics = str(@count_rubrics);
@add_commas_to_a_number(Number_of_Rubrics);
while(length(Number_of_Rubrics) < 7)
{
  Number_of_Rubrics = ' ' + Number_of_Rubrics;
}

goto_mark;

if(@is_bullet_file)
{
  @add_bullet_below;
}
else
{
  @find_next_bullet;
  @bol;
  cr;
  cr;
  up;
  up;
  text(':');
}

text(Date_Stamp);
text('  ' + Number_of_Lines_in_File + '  ' + File_Size + '  ' + Number_of_Rubrics);

@say(fp);
}



//;;

void
@track_size(str lc = parse_str('/1=', mparm_str))
{
str fp = 'Tracker size.';

@header;

lc = 'ts' + lc;

if(!@find_lc_known(fp, lc))
{
  return();
}

@add_text_metadata;

@footer;
}



//;

void
@convert_vb_code_to_csharp_code
{
str fp = "Convert VB code to C# code.";
@header;

if(!@is_text_file)
{
  return();
}

int Number_of_Replacements = 0;
str sc;
str rs;

tof;

@delete_space_at_bol;

Number_of_Replacements = @replace_string_in_file_int('Private Sub', 'private void');

sc = ' _$^';
Number_of_Replacements = @replace_string_in_file_int(sc, ' ');

sc = "ByVal sender As System.Object, ByVal e As System.EventArgs\\)";
rs = "object sender, EventArgs e)${";
Number_of_Replacements += @replace_string_in_file_int(sc, rs);

Number_of_Replacements += @replace_string_in_file_int('End IF', '}');

Number_of_Replacements += @replace_string_in_file_int('End Sub', '}');

Number_of_Replacements += @replace_string_in_file_int('Handles Button1.Click', '');

// This is a tricky way to solve the case-sensitivity issue.
Number_of_Replacements += @replace_string_in_file_int('^If ', 'if12345 ');
Number_of_Replacements += @replace_string_in_file_int('if12345 ', 'if ');

sc = '(if)(.+)(then)';
rs = 'if(\1)${';
Number_of_Replacements += @replace_string_in_file_int(sc, rs);

sc = '(if\(.+ =) ';
rs = '\0= ';
Number_of_Replacements += @replace_string_in_file_int(sc, rs);

sc = ' New ';
rs = ' New12345 ';
Number_of_Replacements += @replace_string_in_file_int(sc, rs);

sc = ' New12345 ';
rs = ' new ';
Number_of_Replacements += @replace_string_in_file_int(sc, rs);

sc = '^dim (.+) as ';
rs = 'var \0 = ';
Number_of_Replacements += @replace_string_in_file_int(sc, rs);

sc = '^dim (.+) as ';
rs = 'var \0 = ';
Number_of_Replacements += @replace_string_in_file_int(sc, rs);

sc = 'system.io.';
rs = '';
Number_of_Replacements += @replace_string_in_file_int(sc, rs);

sc = '^(var .+[^;])$';
rs = '^\0;';
Number_of_Replacements += @replace_string_in_file_int(sc, rs);

sc = '^(MessageBox.+[^;])$';
rs = '^\0;';
Number_of_Replacements += @replace_string_in_file_int(sc, rs);

sc = '^(.+Close.+[^;])$';
rs = '^\0;';
Number_of_Replacements += @replace_string_in_file_int(sc, rs);

tof;

fp += ' Replacements made: ' + str(Number_of_Replacements) + '.';
@footer;
@say(fp);
}



//;

void
@compile_this_macro
{
str fp = "Compile this macro.";
rm('compile');
@say(fp);
}



//;

void
@edit_templates
{
str fp = "Edit templates.";
rm('Template^Tmp_Edit');
@say(fp);
}



//;

void
@@add_text_metadata
{
@header;
@add_text_metadata;
@footer;
}



//; (skw add to buffer, add_to_buffer, to_buffer, to buffer, copy to buffer, copy_to_buffer)

void
@add_to_buffer_plsql_sp_scriptsh
{
str fp = "Add to buffer PL/SQL stored procedure script shell.";
@header;

@save_location;

str lc = "plss";
if(!@find_lc_known(fp, lc))
{
  return();
}

@hc_bullet_content_dinc;

@restore_location;

@footer;
@say(fp);
}



//;

void
@make_batch_file_column
{
str fp = "Make batch file column.";
str rs;
str so;
int EFBO = true; // Execute First Block Only

if(@current_line > 14000)
{
  tof;
}

@header;
str sc = '';
sc = ' "';
rs = '$"';
right;

if(EFBO){ so = @replace_all_occurrences_in_file(sc, rs); EFBO = 0; }
if(EFBO){ so = @replace_next_occurrence_only(sc, rs); EFBO = 0; }
if(EFBO){ @seek_next(sc, so); EFBO = false; }
if(EFBO){ int Is_Found = @seek_in_all_files_2_arguments(sc, fp); EFBO = 0; }

@footer;
@say(found_str);
@say(so);
@say(fp);
}



//;+ Delete Macros



//;;

void
@delete_carriage_return_char_su()
{
str fp = "Delete text eof characters, special use case.";

int counter = 1;

tof;

while(counter < 40)
{
  @eol;
  @delete_character; 
  counter++;
}

@say(fp);
}



//;

str
@commute_common_characters(str sc)
{
str fp = "Commute common characters.";

sc = @commute_character(sc, ' ', '+');
sc = @commute_character(sc, '#', '%23');

@say(fp);
return(sc);
}



//;

void
@add_text_new_rubric_for_complet
{
str fp = "Add text new rubric for completed items.";

str sc = 'rfco';

@header;

if(!@find_lc_known(fp, sc))
{
  @footer;
  return();
}

@eol;
text(' ');
@add_text_date;
@delete_text_lc_on_cl;
@add_subrubric_above;
text('Completed Items (!' + 'co, !' + 'rfco) for the Week Ending');

@footer;

@say(fp);
}



//;

void
@add_a_carriage_return_before_cl
{
str fp = "Add a carriage return before current line.";
@header;

goto_col(1);
cr;

@footer;
@say(fp);
}



//;

void
@its_a_new_day
{
str fp = "It's a new day.";

@header;

@find_lc_known(fp, "rfnow");

@hc_big_segment_content;
@delete_block;
@find_next_big_segment;
@eoc;
@hc_word_uc;
str weekday = @get_wost;
@delete_line;
up;
up;
up;
@delete_line;
@delete_line;
@delete_line;
down;

str sc = weekday + ' Official Template';

str so;

@seek_in_all_files_2_arguments(sc, so);

if(!@seek_in_all_files_2_arguments(sc, so))
{
  fp += ' NOT found. ' + so;
  return(); 
}

@hc_big_segment;

@find_lc('rfmyca');

@bol;

@paste;

@find_previous_big_segment;

@eoc;

while(!at_eol)
{
  @delete_character; 
}

text(weekday);
text(' (!');
text(lower(@left(weekday, 2)));
text(')');

@find_lc('rfnow');
@find_next_bullet;

@footer;
@say(fp + ' (Hi ' + weekday + '.)');
}



//;+ ASCII Family



//;;

void
@open_the_multi_edit_ascii_table
{
str fp = "Open the Multi-Edit ASCII table.";
@header;

rm('ascii');

@footer;
@say(fp);
}



//;;

void
@identify_ascii_value_uc()
{
str fp = 'Identify the ASCII value of the character under the cursor.';

int rv = ascii(@current_character);
fp += ' Value: ' + str(rv) + '.';

@say(fp);
}



//;+ How to Pass Parameters



//;;

void
@hello_someone(str first_Name = parse_str('/1=', mparm_str))
{
str fp = "Hello someone.";

fp += ' (' + first_Name + ')';

@say(fp);
}



//;;

void
@hello_someone_test
{
str fp = "x";
@hello_someone('Bill');
}



//;;

void
@parameter_passing_test_harness
{
str fp = "";

//@parameter_passing_test_1('a');
//@parameter_passing_test_2('a', 'b');

}



//;;

void
@parameter_passing_test_3(int starting_Position_of_Search = parse_int('/1=', mparm_str),
  str starting_Position_of_Search_2 = parse_str('/2=', mparm_str))
{

// Note: Stupidly, the word "/P" must be capitalized.

@say('1 = ' + str(starting_Position_of_Search) + '. 2 = ' + starting_Position_of_Search_2);

/* Use Case(s)

Given the following "CLIF":

//@parameter_passing_test_2 /P1=jo/P2=1234

That Clif represents the maximum line length, that is 40 characters, that I hypothesize that 
ExecProg will accept.
*/

}



//;;

void
@parameter_passing_test_2(str starting_Position_of_Search = parse_str('/1=', mparm_str),
  str starting_Position_of_Search_2 = parse_str('/2=', mparm_str))
{

// Note: Stupidly, the word "/P" must be capitalized.

// Gotcha: There can be no space between multiple parameters.

@say('1 = ' + starting_Position_of_Search + '. 2 = ' + starting_Position_of_Search_2);

/* Use Case(s)

Given the following "CLIF":

@parameter_passing_test_2 /P1=jo/P2=1234

That Clif represents the maximum line length, that is 40 characters, that I hypothesize that 
ExecProg will accept.
*/

}



//;; (skw @parameter_passing_test_1)

void
@pass_1_parameter(str sc = parse_str('/1=', mparm_str))
{
str fp = 'Pass 1 parameter.';

// Gotcha: Stupidly, the word "/PARM", if you use a named parameter like this, must be 
// capitalized.

@say(fp + ' (' + sc + ')');
}



//;;

void
@pass_1_parameter()
{
str fp = 'Pass 1 parameter overload test.';

// Outcome: This function cannot be called because, as far as I can tell, the other function
// with the same name is defined before this one and thus takes precedence.

// Gotcha: Stupidly, the word "/PARM", if you use a named parameter like this, must be 
// capitalized.

@say(fp);
}



//;;

void
@pass_1_parameter_test
{
str fp = "";
fp = "Aug-20-2012 12:28 PM";

@pass_1_parameter(fp);
}



//;; (skw instructional macro)

void
@different_ways_to_call_the_same
{
str fp = "Different ways to call the same method.";

// Sample code below. Please do not delete.
rm('@switch_to_named_window /1=cc.asc');

@say(fp);
}



//;; (skw How to pass optional parameters in CMAC.)

void
@optional_parameter()
{
str test[128] = parse_str("/1=", mparm_str);

if(test == '')
{
  test = 'No parameter passed.'; 
}

@say(test);
}



//;;

void
@optional_parameter_with_2_args(str test_Parm)
{
str test[128] = parse_str("/FN=", mparm_str);

if(test == '')
{
  test = 'No parameter passed.'; 
}

test += test_Parm;

@say(test);
}



//;; (skw optional parameter callers

void
@optional_parameter_caller
{
//rm("@run_clif_from_multiedit_diag /1=jump /2=aa");
//@optional_parameter;
//@optional_parameter_with_2_args('hey now');

rm("@optional_parameter /1=" + Get_Environment('userprofile'));

//rm("@Optional_Parameter /test_Parm='coy' /1=" + Get_Environment('userprofile'));
//@Optional_Parameter_with_2_args('hey now', "/1=climb");
//rm("@Optional_Parameter_with_2_args('coy') /1=" + Get_Environment('userprofile'));
}



//;

void
@set_cmac_name(str parameter = parse_str('/1=', mparm_str))
{
str fp = "Set CMAC name.";

Set_Global_Str('cmac_return_value', parameter);
}



//; (skw 2_colons, two_colons)

str
@hc_subject_and_metadata
{
str fp = "Highcopy subject and metadata.";

int number_of_Colons_Reached = 0;

@eoc;
str_block_begin;

while(number_of_Colons_Reached < 2 and (!at_eol))
{
  if(@current_character == ':')
  {
    number_of_Colons_Reached++;
  }
  right; 
}
left;
block_end;

set_global_str('cmac_return_value', @get_selected_text);
@say(fp);
return (@get_selected_text);

/* Use Case(s)

- 1. Use Case on Jan-8-2012:

Sherlock Holmes: A Game of Shadows: 7.7 40k

*/

}



//;

void
@format_comments
{
str fp = "Format comments temporary macro.";

@header;

tof;

str sc = 'PhysicalDescription SourceString';

if(!@seek_next(sc, fp));
{
  fp += ' SC NOT found.';
}

@bol;
cr;
down;
cr;
up;
up;
@word_wrap;

down;
@bol;
cr;
up;
up;
@word_wrap;

down;
@bol;
cr;
up;
up;
@word_wrap;

@add_double_q;

up;
up;
up;

@footer;
@say(fp);
}



//;+ Clipboard Loading (!cllo)



//;;

void
@open_outlook_an_easier_way_2
{
str fp = "Open Outlook.";

@run_clif_internally('outl');

@say(fp);
}



//;;

void
@open_owa_an_easier_way
{
str fp = "Open OWA with r8 also.";

str url = 'https://outlook.office365.com/owa/?realm=nesassociates.com&exsvurl=1&ll-cc=1033&modurl=0&path=/mail/inbox';

url = 'https://outlook.office.com/owa/';
@surf(URL, 3);

@say(fp);
}



//;

void
@mol
{
str fp = 'Go to the middle of the line.';
@header;
eol;
int My_Eol = @current_column;
My_Eol = My_Eol / 2;
while (My_Eol > 0)
{
  left;
  My_Eol--;
}
@footer;
@say(fp);
}



//;

void
@mark_columns_of_text
{
str fp = "Mark columns of text.";
rm('MColBlck');
@say(fp);
}



//;

void
@save_file
{
str fp = "Save file.";
save_File;
@say(fp);
}



//;+ Switch Windows



//;;

int
@switch_to_first_window()
{
str fp = 'Switch to first window.';

int Previous_Window_Number;

while(cur_window <= window_count)
{
  Previous_Window_Number = cur_window;
  @next_window;
  if(Previous_Window_Number > cur_window)
  {
    break;
  }
}

if(get_line == '')
{
  @find_next_bullet;
}

@say(fp);
return(Previous_Window_Number);
}



//;;

void
@@switch_to_first_window
{
@header;
@switch_to_first_window;
@footer;
}



//;;

int
@switch_to_intermediate_window
{
str fp = 'Switch to intermediate or the median window.';

@header;

@switch_to_first_window;

@footer;

while(cur_window <= (window_count / 2))
{
  @next_window;
}
@say(fp);
}



//;

int
@constant_open_windows()
{

str fp = 'The number of windows to keep open, by default.';

// lu: Jan-3-2019

switch(@first_3_characters(@lower(get_environment("computername"))))
{
  case "lip":
    return(8);
    break;
  default:
    return(12);
}
}



//;+ Window Operations



//;;

int
@count_open_windows()
{
str fp = "Count open windows.";

str Name_of_Current_Window = @filename;
str Name_of_First_Window = @filename;

int Open_Window_Counter = 0;

do
{
  @next_window;
  Open_Window_Counter++;
  Name_of_Current_Window = @filename;
} while(Name_of_Current_Window != Name_of_First_Window);

@say("Number of Open Windows: " + str(Open_Window_Counter));
return(Open_Window_Counter);
}



//;;

void
@switch_to_last_window()
{
str fp = 'Switch to last window.';

@switch_to_first_window;
@previous_window;

@say(fp);
}



//;;

void
@@switch_to_last_window
{
@header;
@switch_to_last_window;
@footer;
}



//;;

void
@close_last_window()
{
str fp = 'Close last window.';

@switch_to_last_window;
@close_and_save_file_wo_prompt;

@say(fp);
}



//;;

void
@@close_last_window
{
@header;
@close_last_window;
@footer;
}



//;;

void
@close_excess_windows()
{
str fp = "Close excess windows.";

@header_bloff;
@switch_to_first_window;
int open_window_counter = @count_open_windows;
while(open_window_counter > @constant_open_windows)
{
  @close_last_window;
  @switch_to_first_window;
  open_window_counter--;
}

@find_bookmark_primary;
@footer;

@say(fp);
}



//;;

void
@toggle_window_opening_n_closing
{
str fp = "Toggle window opening and closing.";

@header;

// lu: Apr-9-2018

if(@window_count > @constant_open_windows)
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



//;+ Compositional Clifs (!cocl)



//;+ Microsoft Products With Jira



//;;

void
@open_microsoft_product_for_jira(str ticket_number, str application, str file_extension)
{

str fp = "Open Microsoft Product for Jira items.";

str filepath = '%savannah%\work documents';

filepath = @resolve_environment_variable(filepath);

str fullfilepath = filepath + '\' + ticket_number + '.' + file_extension;

if(!file_exists(fullfilepath))
{
  @set_clipboard(ticket_number);
}

@run_application_2p(application, fullfilepath);
}



//;;

void
@open_microsoft_product_prequel(str executable_number = parse_str('/1=', mparm_str))
{
str fp = "Open Microsoft product for Jira.";

// fcd: Apr-23-2015

str lc = 'cj';

@save_location;

if(!@find_lc_known(fp, lc))
{
  @restore_location;
  @say(" Error: LC NOT found. (" + lc + ")");
  @footer;
  return();
}

str filename = @get_subject_or_selected_text;

str executable_name;
str filename_extension;

switch(@trim(executable_number))
{
  case '1':
    executable_name = 'c:\\program files\\microsoft office\\office14\\OneNote.exe';
    filename_extension = 'one';
    break;
  case '2':
    executable_name = "c:\\program files\\microsoft office\\office14\\Winword.exe";
    filename_extension = 'docx';
    break;
  case '3':
    executable_name = 'c:\\program files\\microsoft office\\office14\\Excel.exe';
    filename_extension = 'xlsx';
    break;
  case '4':
    executable_name = 'c:\\program files\\microsoft office\\office14\\Powerpnt.exe';
    filename_extension = 'pptx';
    break;
  case '5':
    executable_name = 'c:\\program files\\microsoft office\\office14\\Visio.exe';
    filename_extension = 'vsd';
    break;
  case '6':
    executable_name = 'c:\program files\paint.net\paintdotnet.exe';
    filename_extension = 'png';
    break;
}

@open_microsoft_product_for_jira(filename, executable_name, filename_extension);

@restore_location;
}



//;;

void
@@open_microsoft_product_prequel(str execuatable_name = parse_str('/1=', mparm_str))
{
@header;
@open_microsoft_product_prequel(execuatable_name);
@footer;
}



//;

void
@highlight_to_almost_eol
{
str fp = "Highlight to almost EOL.";

int keep_moving_left = true;

str_block_begin;

eol;

while(keep_moving_left)
{
  switch (@previous_character)
  {
    case ')':
    case ';':
    case '>':
    case '.':
    case "'":
    case '"':
      left;
      continue;
  }
  keep_moving_left = false;
}

@say(fp);
}



//;+ Run Multi-Edit Macros (skw Multi-Edit Dialogue)



//;;

void
@run_multiedit_macro(str sc = parse_str('/1=', mparm_str))
{
str fp = "Run Multi-Edit macro. (" + sc + ')';
sc = @lower(sc);
switch(sc)
{
  case 'color':
    sc = 'Colors^SetupDefColors';
    break;
  default:
}
rm(sc);
@say(fp);
}



//;;

void
@open_me_dialogue_box_for_cme
{
str fp = "Open Multi-Edit's dialogue box for command map editing.";
rm('CommandMapEdit');
@say(fp);
}



//;;

void
@open_me_dialogue_box_for_cust
{
str fp = "Open Multi-Edit's dialgue box for customizing your environment.";
rm('Setup^Customize');
@say(fp);
}



//;;

void
@open_me_dialogue_box_colors
{
str fp = "Open up Multi-Edit's Colors dialgue box!";
rm('Colors^SetupDefColors');
@say(fp);
}



//;

void
@add_text_tiny_url()
{
str fp = 'Add text Tiny URL.';
if(@text_is_selected)
{
  delete_block;
}
text('http://www.tinyurl.com/');
@say(fp);
}



//;

void
@transpose_precolon_phrase_and_o
{
str fp = "Transpose precolon phrase and object portions of a line.";

str precolon_Phrase = @hc_subject;
str oj = @hc_object;
@hc_subject;
delete_block;
text(oj);
@hc_object
delete_block;
text(precolon_Phrase);

@say(fp);
}



//;+ Highcopy



//;;

void
@hc_test_harness_2
{
str fp = "";
fp = "Jun-20-2013 12:47 PM";

set_global_int("highcopy row 1", @current_row);
set_global_int("highcopy row 2", @current_row);
set_global_int("highcopy column 1", 1);
set_global_int("highcopy column 2", 11);

//@highcopy("tessla");

@say(fp);
}



//;;

void
@hc_test_harness()
{
str fp = "xx";
fp = "May-7-2013 1:39 PM";

@header;

//@highcopy(1, 2, @current_row, @current_row);
//@highcopy(3, 2, @current_row, @current_row + 1);

@footer;

@say(fp);
}



//;

void
@play_first_bullet_in_the_yt_rub
{
str fp = "Play first bullet in the YouTube wishlist queue rubric.";
@header;

if(!@find_lc_known(fp, 'wlyt'))
{
  return();
}

@find_next_bullet;

@search_youtube(0);

@footer;
@say(fp);
}



//;

int
@increment_ticket_number_counter()
{
str fp = "Increment ticket number counter.";

@save_location;

int result;

str filename = '%composable_batch_files%\ticket_number_counter.txt';

filename = @resolve_environment_variable(filename);
@open_file(filename);

str counter_string = @hc_subject;
val(result, counter_string);

delete_block;

result++;
text(str(result));

@close_and_save_file_wo_prompt;
@restore_location;
return(result);
@say(fp);
}



//;

void
@start_new_travel_rubric
{
str fp = "";
fp = "Start new travel rubric.";

@header;
@find_lc('tr');
@delete_text_lc_on_cl;
@find_lc('rftr');
@add_subrubric_below('');
@add_text_lc_on_current_line('tr');
@eoc;
left;

@footer;

@say(fp);
}



//;+ Look Up Information



//;;

void
@look_up_parents_information
{
str fp = "Look up parent's information in a context sensitive way.";
@header;

if(@is_subbullet)
{
  @look_up_bs_information;
  return();
}

if(@is_bullet)
{
  @look_up_bs_information;
  return();
}

if(@is_big_segment)
{
  @look_up_rubric_information;
  return();
}

@footer;
@say(fp);
}



//;;

void
@@delete_line
{
@header;
@delete_line;
@footer;
}



//;

void
@delete_current_ln_fr_colon_2eol()
{
str fp = 'Delete current line from colon to eol.';

@eoc;

while (!at_eol)
{
  @delete_current_character;
}

/* Use Case(s)

:CNN: http://www.cnn.com

:lunar landing: (!+wc) bm

*/

@say(fp);
}



//;+ Isolate Word



//;;

void
@isolate_word_on_line
{
str fp = "Isolate word on line.";

// fcd: Apr-3-2014

@header;

@hc_word_uc;

str current_line_type = @current_line_type;

@delete_line;
@bol;
cr;
up;

switch(current_line_type)
{
  case 'rubric':
    text(';');
    break;
  case 'bullet':
    text(':');
    break;
  case 'subbullet':
    text('::');
    break;
  default:
}

@paste;

@footer;

@say(fp);
}



//;;

void
@copy_and_isolate_word_on_line
{
str fp = "Copy and isolate word on line.";

// fcd: Apr-3-2014

@header;

@hc_word_uc;

str current_line_type = @current_line_type;

@bol;

cr;
cr;

if(current_line_type == 'bullet')
{
  text(':');
}

@bol;

up;
up;

switch(current_line_type)
{
  case 'rubric':
    text(';');
    break;
  case 'bullet':
    text(':');
    break;
  case 'subbullet':
    text('::');
    break;
  default:
}

@paste;

@footer;

@say(fp);
}



//;

void
@add_text_current_month
{
str fp = "Add text current month.";
str rs;
str sc;
str so;
int EFBO = true; // Execute First Block Only

@header;

@bol;
sc = '\[Month Name\]';
rs = @first_3_characters(@get_formatted_date);
right;

if(EFBO){ so = @replace_next_occurrence_only(sc, rs); EFBO = 0; }

@footer;
@say(found_str);
@say(so);
@say(fp);
}



//;

void
@review_poker_rubric
{
str fp = "Review poker rubrics.";
@header;

// fcd: Aug-13-2014

@find_lc('sgpo');
@add_bullet_below;
text(':q' + 'q');
@find_next_bullet;

@footer;
@say(fp);
}



//;

void
@move_bullet_to_double_q
{
str fp = "Move bullet to double q.";
@header;

// fcd: Aug-15-2014

@save_location;
@cut_bullet;
if(!@find_lc('q' + 'q'))
{
  @paste;
  return();
}
@bol;
@paste;
@restore_location;

@footer;
@say(fp);
}



//;

void
@move_bullet_to_jd
{
str fp = "Move bullet to jd.";
@header;

//lu: May-31-2019

@save_location;
@cut_bullet;
if(!@find_lc('jd'))
{
  @paste;
  return();
}
@bol;
@paste_after;
@restore_location;

@footer;
@say(fp);
}



//;

void
@find_next_lc()
{
str fp = "Find next launch code.";

// fcd: Oct-7-2014

// find_next_launch_codec: skw

@header;

right;
if(find_text(@lc, 0, _regexp))
{
  fp += ' Found!';
}
else
{
  fp += ' NOT found.';
}

@footer;

@say(fp);
}



//;

void
@select_text_downward
{
str fp = "";

// fcd: Oct-31-2014

goto_col(1);
if(!@text_is_selected)
{
  str_block_begin;
}
down;

@say(fp);
}



//;

void
@@delete_previous_line
{
@header;
@delete_previous_line;
@footer;
}



//;+ Lookup Number Macros



//;;

int
@get_lk_number_uc()
{
str fp = "Get l-k number under cursor.";

int current_line_lk_number;

right;
right;

int conversion_candidate;
int first_digit = -1;
int rv = -1;
int second_digit = -1;

if (val(conversion_candidate, @current_character) == 0)
{
  first_digit = conversion_candidate;
  rv = first_digit;
}

right;
if (val(conversion_candidate, @current_character) == 0)
{
  second_digit = conversion_candidate;
  rv = (first_digit * 10) + second_digit;
}

return(rv);
}



//;;

void
@find_next_lkc
{
str fp = "Find next l-k number straight up simple.";
@header;

int current_line_lk_number;

if(@seek_next(@lookup_counter, fp))
{
  current_line_lk_number = @get_lk_number_uc;
}

fp += ' Current L' + 'K# = ' + str(current_line_lk_number) + '.';

@footer;
@say(fp);
}



//;;

void
@compare_lkc_for_bs
{
str fp = "Determine if first bullet is possessed of the greatest lookup counter in this bs.";

@header;

int current_line_lk_number = 0;
int number_of_lines_to_search;
int starting_line_lk_number;

@bobs;

int first_line_in_rubric = @current_line;

int number_of_lines_in_big_segment = @count_lines_in_bs;

if(find_text(@lookup_counter, number_of_lines_in_big_segment, _regexp))
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
  number_of_lines_to_search = number_of_lines_in_big_segment - (@current_line - 
    first_line_in_rubric);
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
    @bobs;
    break;
  }
}

@footer;
@say(fp);
}



//;;

void
@find_next_higher_lkc
{
str fp = "Find next higher lookup counter.";

@header;

int starting_line_lk_number;
int current_line_lk_number = 0;
int escalator_lk_number;

@bol;

mark_pos;

if(@seek_next(@lookup_counter, fp))
{
  starting_line_lk_number = @get_lk_number_uc;
}
down;

while(starting_line_lk_number > current_line_lk_number)
{
  if(@seek_next(@lookup_counter, fp))
  {
    current_line_lk_number = @get_lk_number_uc;
    if(current_line_lk_number > starting_line_lk_number)
    {
      pop_mark;
      mark_pos;
      break;
    }
  }
  else
  {
    break;
  }
}

goto_mark;

fp += ' Current L[]K# = ' + str(current_line_lk_number) + '.';

@footer;
@say(fp);
}



//;;

void
@find_next_lkc_equal_or_higher
{
str fp = "Find next lookup counter equal or higher.";

// next_highest, next_biggest, next_largest, highest, greatest, lookup, next_high, next high
// skw

@header;

str so;
int starting_line_lk_number;
int current_line_lk_number = 0;
int escalator_lk_number;

@bol;

@save_location;
mark_pos;

if(@seek_next(@lookup_counter, so))
{
  starting_line_lk_number = @get_lk_number_uc;
}
down;

while(starting_line_lk_number > current_line_lk_number)
{
  if(@seek_next(@lookup_counter, so))
  {
    current_line_lk_number = @get_lk_number_uc;
    if(current_line_lk_number >= starting_line_lk_number)
    {
      pop_mark;
      mark_pos;
    }
  }
  else
  {
    fp += ' SLK (' + str(starting_line_lk_number) + ') is largest to EOF.';
    break;
  }
}

goto_mark;

@footer;
@say(fp);
}



//;

void
@move_subbullet_to_jd_and_append
{
str fp = "Move subbullet to JD and append it.";
@header;

// fcd: Jan-11-2015

if(!@is_subbullet)
{
  return();
}

@save_location;
@cut_subbullet;
@find_lc('jd');
@paste_after;

@restore_location;

@footer;
@say(fp);
}



//;

void
@set_configuration
{
str fp = "Set configuration.";
@header;

// fcd: Jan-15-2015

str selected_configuration = get_line;

@find_lc('rfmc');

down;
down;
down;
@delete_line;

up;
@bol;
cr;
text(selected_configuration);

@footer;
@say(fp);
}



//;

void
@apply_regal_format
{
str fp = "Apply regal format.";

// fcd: Jan-16-2015

@header;

@save_location;

@eoc;
str so;
str sc = ': ';
@seek_next(sc, so);
if(@next_3_characters == 'lk#')
{
  right;
  sc = ' ';
  @seek_next(sc, so);
  @backspace;
}

cr;

if(@current_character == ' ')
{
  @delete_character;
}

@word_wrap;

@restore_location;

@footer;

@say(fp);
}



//;

void
@calculate_net_worth
{
str fp = "Calculate net worth.";
@header;

// fcd: Feb-5-2015

int cash_amount_int = 0;
int conversion_candidate = 0;
int number_of_rows = 1;
int total_cash_amount_int = 0;
str so;

@seek_next('Car Equity', so);
up;
up;

while(number_of_rows <= 9)
{
  cash_amount_int = 0;
  conversion_candidate = 0;
  down;
  down;
  @eol;
  left;
  if(@current_character == '-')
  {
    down;
    down;
    break;
  }
  str cash_amount_string = @hc_object;
  cash_amount_string = @replace(cash_amount_string, ',', '');
  if (val(conversion_candidate, cash_amount_string) == 0)
  {
    cash_amount_int = conversion_candidate;
  }
  total_cash_amount_int += cash_amount_int;
  number_of_rows++;
}

@eol;
text(str(total_cash_amount_int));
@footer;
@say(fp);
}



//;

void
@add_new_piton
{
str fp = "Add new piton.";
@header;

// fcd: Feb-18-2015

@find_lc('rfpi');
@add_bullet_below;
@add_text_date_and_time;
@paste_without_wrapping;

@footer;
@say(fp);
}



//;

void
@hc_line_portion(int left_column, int right_column)
{
str fp = "Highcopy line portion";

// fcd: Mar-12-2015

fp = get_line;

goto_col(left_column);
str_block_begin;
goto_col(right_column);

//int test = left_column + right_column;
//@say(fp);
//@say(str(test));
}



//;

void
@tn_hc_line_portion
{
str fp = "";
// fcd: Mar-12-2015

block_off;

@eoc;
int left_column = @current_column;
@eol;
int right_column = @current_column;
@hc_line_portion(left_column, right_column);

//@say(fp);
}



//;

void
@go_to_destination_rubric
{
str fp = "Go to destination rubric.";
@header;

// fcd: Mar-19-2015

int source_lc_is_found;

str lc;
str looked_up_rubrics_lc = @look_up_rubrics_source_lc(source_lc_is_found);

if(source_lc_is_found)
{
  lc = 'dest' + looked_up_rubrics_lc;
  @find_lc(lc);
}
else
{
  fp += ' This rubric has associated destination.';
}

@footer;
@say(fp);
}



//;+ Run First Bullet



//;;

void
@run_asap_against_first_bullet(str sc = parse_str('/1=', mparm_str))
{
str fp = "Run associated application against the first bullet.";

// fcd: Jun-2-2015

@find_lc(sc);

int source_lc_is_found = false;

str looked_up_rubrics_lc = @look_up_rubrics_asap_lc(source_lc_is_found);

if(@query_next_bsr == 'bullet')
{
  @find_next_bullet;
  @run_clif_internally(looked_up_rubrics_lc);
}

@say(fp);
}



//;;

void
@@run_asap_against_first_bullet(str sc = parse_str('/1=', mparm_str))
{
@header;
@run_asap_against_first_bullet(sc);
@footer;
}



//;;

void
@play_youtube_video
{
str fp = "Play YouTube video.";

// fcd: Mar-19-2015

@header;

@save_location;

@find_lc('rfyt');
str operation_outcome;

if(@query_next_bsr == 'bullet')
{
  @find_next_bullet;
  @run_clif_under_cursor(operation_outcome);
}
else
{
  fp += ' The YouTube wish list is empty.';
  @find_next_bullet;
  @run_clif_under_cursor(operation_outcome);
}

@restore_location;

@footer;
@say(fp);
}



//;;

void
@play_pluralsight_video
{
str fp = "Play Pluralsight video.";

// fcd: Jun-2-2015

@header;

@save_location;

@find_lc('wlpt');

@find_next_bullet;
str operation_outcome;
@run_clif_under_cursor(operation_outcome);

@restore_location;

@footer;
@say(fp);
}



//;+ Find Family Deficiency Macros



//;;

void
@find_bad_parents
{
str fp = "Find bad parents.";
str debug_message;
str so;

// fcd: Mar-25-2015: This worked on this date.

@header;

@save_location;

int found_bad_parent = 0;

int initial_window = @current_window;

do
{
  tof;
  while(found_bad_parent == 0)
  {
    debug_message += ' Step 1.';
    if(@seek_next(@childless_rubric, so))
    {
      if(@seek_next(@big_segment, so))
      {
        debug_message += ' Step 2.';
        if(@current_area_type == 'subrubric')
        {
          debug_message += ' Step 3.';
          found_bad_parent = 1;
          fp = ' Stop! Bad parent found.';
          break;
        }
        else
        {
          debug_message += ' Step 4.';
          debug_message += ' Not a bad parent.';
        }
      }
      else
      {
        debug_message += ' Step 5.';
        debug_message += ' No big segments found - branch 2.';
        //break;
      }
    }
    else
    {
      debug_message += ' Step 6.';
      debug_message += ' No big segments found - branch 1.';
      break; 
    }
  }

  if(found_bad_parent)
  {
    break;
  }

  rm('NextWin');

} while(@current_window != initial_window);

if(!found_bad_parent)
{
  fp += ' No bad parents found.';
  @restore_location;
}

@say(fp);

@footer;
}



//;;

void
@find_crowded_families
{
str fp = "Find crowded families.";
str debug_message;
str so;

// fcd: Mar-25-2015: This worked on this date.

@header;

@save_location;

int found_crowded_family = 0;

int initial_window = @current_window;

do
{
  tof;
  while(found_crowded_family == 0)
  {
    debug_message += ' Step 1.';
    if(@seek_next(@family_rubric, so))
    {
      down;
      down;
      down;
      down;
      down;
      if(@length(get_line) > 0)
      {
        debug_message += ' Step 3.';
        found_crowded_family = 1;
        fp += ' Stop! Crowded family found.';
        break;
      }
      else
      {
        debug_message += ' Not crowded family.';
      }
    }
    else
    {
      debug_message += ' Step 6.';
      debug_message += ' No big segments found - branch 1.';
      break; 
    }
  }

  if(found_crowded_family)
  {
    break;
  }

  rm('NextWin');

} while(@current_window != initial_window);

if(!found_crowded_family)
{
  fp += ' No bad parents found.';
  @restore_location;
}

@say(fp);

@footer;
}



//;;

void
@find_quiet_families
{
str fp = "Find quiet families.";
str rs;
str sc;
str so;
int efbo = true; // execute first block only

@header;
sc = @family_rubric + '$';
rs = '\0';
@eol;

if(efbo){ int is_found = @seek_in_all_files_2_arguments(sc, fp); efbo = 0; }

down;
down;
down;
if(efbo){ @seek_next(sc, so); efbo = false; }
if(efbo){ so = @replace_next_occurrence_only(sc, rs); efbo = 0; }
if(efbo){ so = @replace_all_occurrs_inf_one_tof(sc, rs); efbo = 0; }

@footer;
@say(found_str);
@say(so);
@say(fp);
}



//;+ Load Clipboard



//;;

void
@lp_small_segment_content(str lc = parse_str('/1=', mparm_str))
{
str fp = "Load clipboard with small segment content.";

@header;

// fcd: Mar-31-2015

@save_location;

if(!@find_lc_known(fp, lc))
{
  @restore_location;
  @footer;
  @say(" Error: LC NOT found. (" + lc + ")");
  return();
}

@hc_small_segment_content_dinc;

@create_reusable_temporary_file;

@paste;

@format_data_2;

@close_and_save_file_wo_prompt;

@restore_location;
@footer;
@say(fp);
}



//;;

void
@lp_sj(str lc = parse_str('/1=', mparm_str))
{
str fp = "Load clipboard with remote subject.";

@header;

// fcd: Mar-31-2015

@save_location;

if(!@find_lc_known(fp, lc))
{
  @restore_location;
  @footer;
  @say(" Error: LC NOT found. (" + lc + ")");
  return();
}

str sj = @hc_subject;

@restore_location;

@footer;

if(@first_character(lc) == 'z')
{
  sj = @left(sj, 4) + '**';
}

@say(fp + ' (' + sj + ')');
}



//;;

void
@add_text(str lc = parse_str('/1=', mparm_str))
{
str fp = "Add text with remote subject.";

// fcd: Apr-14-2015

@save_location;

if(!@find_lc_known(fp, lc))
{
  @restore_location;
  @footer;
  @say(" Error: LC NOT found. (" + lc + ")");
  return();
}

str sj = @hc_subject;

@restore_location;

text(sj);

@say(fp + ' (' + sj + ')');
}



//;;

void
@@add_text(str sc = parse_str('/1=', mparm_str))
{
@header;
@add_text(sc);
@footer;
}



//;;

void
@add_text_oj(str lc = parse_str('/1=', mparm_str))
{
str fp = "Add text with remote object.";

// fcd: Apr-14-2015

@header;

@save_location;

if(!@find_lc_known(fp, lc))
{
  @restore_location;
  @footer;
  @say(" Error: LC NOT found. (" + lc + ")");
  return();
}

str oj = @hc_object;

@restore_location;
text(oj);

// The following addendum doesn't work well for a clif like "ato.wd", 
// so that's why I commented it out. Feb-7-2018
//text(' "');

@footer;
@say(fp + ' (' + oj + ')');
}



//;;

void
@lp_oj(str lc = parse_str('/1=', mparm_str))
{
str fp = "Load clipboard with remote object.";

@header;

// fcd: Mar-31-2015

@save_location;

if(!@find_lc_known(fp, lc))
{
  @restore_location;
  @footer;
  @say(" Error: LC NOT found. (" + lc + ")");
  return();
}

str oj = @hc_object;
@set_clipboard(oj);

@restore_location;
@footer;
@say(fp + ' (' + oj + ')');
}



//;

void
@open_root_folder
{
str fp = "Open root folder.";
// fcd: Apr-28-2015
@open_folder('c:\');
@say(fp);
}



//;

void
@lp_debug_writeline_statement
{
str fp = "Create a debug writeline statement from a clipboard variable.";

// fcd: May-7-2015

@create_timestamped_file;

text('Debug.WriteLine("');
@paste;
text(': {0}.", ');
@paste;
text(');');

@select_all;
@copy;

@close_and_save_file_wo_prompt;

@say(fp);
}



//;

void
@lp_debug_writeline_separator
{
str fp = "Create a debug writeline separator.";

// fcd: May-7-2015

@create_timestamped_file;

text('Debug.WriteLine("***************************************************************************************************************");');

@select_all;
@copy;

@close_and_save_file_wo_prompt;

@say(fp);
}



//;+ Load Clipboard



//;;

void
@lp_date()
{
str fp = 'Load clipboard date.';
@set_clipboard(@get_formatted_date);
fp += ' (' + @get_formatted_date + ')';
@say(fp);
}



//;;

void
@lp_date_and_time()
{
str fp = 'Load clipboard date and time.';
@set_clipboard(@get_formatted_date + " " + @get_formatted_time);
fp += ' (' + @get_formatted_date + " " + @get_formatted_time + ')';
@say(fp);
}



//;

void
@copy_subject(str lc = parse_str('/1=', mparm_str))
{
str fp = "Copy subject.";
@header;
// fcd: May-15-2015

@save_location;
@find_lc(lc);
str sj = @hc_subject;
@restore_location;

@footer;
@say(fp + ' (' + sj + ')');
}



//;

void
@lp_cj_subject
{
str fp = "Load clipboard with cj subject.";
@header;
// fcd: May-15-2015

@save_location;
@find_lc('cj');
str sj = @hc_subject;
@restore_location;

@footer;
@say(fp + ' (' + sj + ')');
}



//;

void
@delete_excess_blank_lines
{
str fp = "Delete excess blank lines.";

@header;

str rs;
str sc;
str so;

tof;

sc = '$$^[a-z]';
rs = '\0';
@eol;

while(@seek_with_case_sensitivity(sc, so))
{
  @delete_character;
  @word_wrap;
  tof;
}

@footer;

@say(fp);
}



//;

void
@add_break_for_tag_tr()
{
str fp = 'Add 3 blank rows before every row tag.';
str rs;
str sc;
str so;
int efbo = true; // execute first block only

sc = '(<tr)';
rs = '$$$$\0';
@eol;

if(efbo){ so = @replace_all_occurrs_inf_one_tof(sc, rs); efbo = 0; }

@say(found_str);
@say(so);
@say(fp);
}



//;

void
@add_break_for_tag_b()
{
str fp = 'Add break before every b tag.';
str rs;
str sc;
str so;
int efbo = true; // execute first block only

sc = '(<b)';
rs = '$\0';
@eol;

if(efbo){ so = @replace_all_occurrs_inf_one_tof(sc, rs); efbo = 0; }

@say(found_str);
@say(so);
@say(fp);
}



//;

void
@add_break_for_tag_end_tr()
{
str fp = 'Add 3 blank rows before every row tag.';
str rs;
str sc;
str so;
int efbo = true; // execute first block only

sc = '(</tr)';
rs = '$\0';
@eol;

if(efbo){ so = @replace_all_occurrs_inf_one_tof(sc, rs); efbo = 0; }

@say(found_str);
@say(so);
@say(fp);
}



//;

void
@add_break_for_tag_td()
{
str fp = 'Add 3 blank rows before every row tag.';
str rs;
str sc;
str so;
int efbo = true; // execute first block only

sc = '(<td)';
rs = '$\0';
@eol;

if(efbo){ so = @replace_all_occurrs_inf_one_tof(sc, rs); efbo = 0; }

@say(found_str);
@say(so);
@say(fp);
}



//;

void
@add_break_for_tag_end_td()
{
str fp = 'Add 3 blank rows before every row tag.';
str rs;
str sc;
str so;
int efbo = true; // execute first block only

sc = '(</td)';
rs = '$\0';
@eol;

if(efbo){ so = @replace_all_occurrs_inf_one_tof(sc, rs); efbo = 0; }

@say(found_str);
@say(so);
@say(fp);
}



//;

void
@add_break_for_tag_table()
{
str fp = 'Add break every table tag.';
str rs;
str sc;
str so;
int efbo = true; // execute first block only

sc = '(<table)';
rs = '$\0';
@eol;

if(efbo){ so = @replace_all_occurrs_inf_one_tof(sc, rs); efbo = 0; }

@say(found_str);
@say(so);
@say(fp);
}



//;

void
@add_break_for_tag_end_table()
{
str fp = 'Add break for every row tag.';
str rs;
str sc;
str so;
int efbo = true; // execute first block only

sc = '(</table)';
rs = '$\0';
@eol;

if(efbo){ so = @replace_all_occurrs_inf_one_tof(sc, rs); efbo = 0; }

@say(found_str);
@say(so);
@say(fp);
}



//;

void
@format_dossier
{
str fp = "Format dossier.";
@header;

// fcd: Jun-22-2015
tof;
@add_break_for_tag_tr
@add_break_for_tag_b
@add_break_for_tag_end_tr();
@add_break_for_tag_td();
@add_break_for_tag_end_td();
@add_break_for_tag_table();
@add_break_for_tag_end_table();

@footer;
@say(fp);
}



//;

void
@mark_block_to_bof()
{
str fp = 'Mark block to TOF.';

block_begin;
tof;
block_end;

@say(fp);
}



//;+ Make Java Files



//;;

void
@create_java_file(str filename = parse_str('/1=', mparm_str))
{
str fp = 'Create new file in the work documents folder.';

str full_filename[128] = get_environment('savannah') + '\java\' + filename;

if(file_exists(full_filename))
{
  filename = filename + '_' + @get_formatted_date_as_fct_name;
  full_filename = get_environment('savannah') + '\java\' + filename;
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



//;;

void
@make_java_file
{
str fp = "Take the current file and save it into the work documents folder.";

// fcd: Jul-28-2015

@open_file('C:\Users\jonathan.r.jones\Documents\savannah\Java\HelloWorld.java');

@select_all;

@copy;

@close_and_save_file_wo_prompt;

str filename = @get_formatted_date_as_fct_name + '.java';

@create_java_file(filename);

@paste;

@say(fp);
}



//;

void
@make_work_documents_file
{
str fp = "Take the current file and save it into the work documents folder.";

// fcd: Jul-28-2015

str filename = @get_formatted_date_as_fct_name + '.txt';

@create_work_documents_file(filename);
@paste;

@say(fp);
}



//;

void
@process_this_file(str lc = parse_str('/1=', mparm_str))
{
str fp = "Process this file.";

// fcd: Jul-28-2015

str application = '';
lc = @lower(lc);

switch(lc)
{
  case 'ie':
    application = 'c:\program files\internet explorer\iexplore.exe';
    @run_application_2p(application, file_name);
    fp += ' (' + lc + ')';
    break;
  default:
}

@say(fp);
}



//;+ Execute This Series (!exth)



//;;

void
@execute_current_line(str lc = parse_str('/1=', mparm_str))
{
str fp = "Execute current line.";

// fcd: Jul-29-2015

int lc_Is_Found;
str executable = @get_remote_oj_using_klc(lc, lc_is_found);
str parameter = @trim_colons(get_line);
@run_application_2p(executable, parameter);

@say(fp + ' (' + lc + ')');
}



//;;

void
@execute_this_file(str lc = parse_str('/1=', mparm_str))
{
str fp = "Execute this file.";

// fcd: Jul-31-2015

int lc_Is_Found;
str executable = @get_remote_oj_using_klc(lc, lc_is_found);
str parameter = file_name;
@run_application_2p(executable, parameter);

@say(fp + ' (' + lc + ')');
}



//;;

void
@@execute_current_line(str lc = parse_str('/1=', mparm_str))
{
@header;
@execute_current_line(lc);
@footer;
}



//;

void
@add_text_cmac_macro_list_entry
{
str fp = 'Add text new CMAC Macro List entry.';

// (skw add clif, add_clif, add cmac, add_cmac)

@header;

str lc = "rfc0";
if(!@find_lc_known(fp, lc))
{
  return();
}

@add_bullet_below;

@paste;
@eoc;
@delete_character;
@convert_line_to_spaces;
@convert_line_to_proper_case;
@eol;
text(' (!): ');
@paste;

@bol;
@seek('!');
@apply_2_line_format;

@footer;
@say(fp);
}



//;+ LC Current Line



//;

void
@what_regex_is
{
str fp = "";
str rs;
str sc;
str so;
int efbo = true; // execute first block only

if(@current_line > 14000)
{
  tof;
}

@header;
sc = '[a-z][1-9]';
// a1
// b2
// c3
rs = '\0';
@eol;

if(efbo){ @seek_next(sc, so); efbo = false; }
if(efbo){ so = @replace_next_occurrence_only(sc, rs); efbo = 0; }
if(efbo){ so = @replace_all_occurrs_inf_one_tof(sc, rs); efbo = 0; }
if(efbo){ int is_found = @seek_in_all_files_2_arguments(sc, fp); efbo = 0; }

@footer;
@say(found_str);
@say(so);
@say(fp);
}



//;+ LC Partner



//;;

int
@perform_next_test(str sc, str &remote_lc_partner)
{

str fp = 'Perform next test.';

str distilled_lc;
str original_sc = sc;
str partner_character;

sc = '!' + sc + '.+';

if(@first_character(original_sc) == '1')
{
  partner_character = '2';
}
else if(@first_character(original_sc) == '2')
{
  partner_character = '1';
}

@bol;

if(find_text(sc, 2, _regexp))
{
  distilled_lc = @distill_lc(found_str);;
  distilled_lc = @trim_after_character(distilled_lc, ')');
  distilled_lc = str_del(distilled_lc, 1, 2);
  remote_lc_partner = partner_character + @trim_left(original_sc, 1) + distilled_lc;
  goto_mark;
  return(1);
}

return(0);
}



//;; (!2mlcp)

int
@current_line_has_an_lc_partner(str &remote_lc_partner)
{

str fp = "Determine whether the current line has an lc partner.";

//@save_location; Commented on Apr-30-2018.

int rv = 0;

mark_pos;

str sc = '';
str distilled_lc = '';


// Next test. ****

sc = '!sour.+';

@bol;

if(find_text(sc, 2, _regexp))
{
  distilled_lc = @distill_lc(found_str);;
  distilled_lc = @trim_after_character(distilled_lc, ')');
  distilled_lc = str_del(distilled_lc, 1, 4);
  remote_lc_partner = 'dest' + distilled_lc;
  if(remote_lc_partner == 'destjd')
  {
    remote_lc_partner = 'jd';
  }
  goto_mark;
  return(1);
}

goto_mark;


// Next test. ****

sc = '!dest.+';

@bol;

if(find_text(sc, 2, _regexp))
{
  distilled_lc = @distill_lc(found_str);;
  distilled_lc = @trim_after_character(distilled_lc, ')');
  distilled_lc = str_del(distilled_lc, 1, 4);
  remote_lc_partner = 'sour' + distilled_lc;
  goto_mark;
  return(1);
}

goto_mark;


// Next test. ****

sc = '\^.+';

@bol;

if(find_text(sc, 2, _regexp))
{
  distilled_lc = @distill_lc(found_str);;
  distilled_lc = @trim_before_character(distilled_lc, '^');
  remote_lc_partner = distilled_lc;
  goto_mark;
  return(1);
}

goto_mark;


// Next test. ****

sc = '1way.+,';

@bol;

if(find_text(sc, 2, _regexp))
{
  distilled_lc = @distill_lc(found_str);
  remote_lc_partner = @replace(distilled_lc, '1way', '');
  goto_mark;
  return(1);
}

goto_mark;



// Beginning of 1-2 tests.

if(@perform_next_test('1f', remote_lc_partner))
{
  return(1);
}

if(@perform_next_test('2f', remote_lc_partner))
{
  return(1);
}

if(@perform_next_test('1g', remote_lc_partner))
{
  return(1);
}

if(@perform_next_test('2g', remote_lc_partner))
{
  return(1);
}

if(@perform_next_test('1m', remote_lc_partner))
{
  return(1);
}

if(@perform_next_test('2m', remote_lc_partner))
{
  return(1);
}

if(@perform_next_test('1s', remote_lc_partner))
{
  return(1);
}

if(@perform_next_test('2s', remote_lc_partner))
{
  return(1);
}

if(@perform_next_test('1z', remote_lc_partner))
{
  return(1);
}

if(@perform_next_test('2z', remote_lc_partner))
{
  return(1);
}

// I moved this to the last position because I wanted them to be a lower precedence
// than 1z and 2z. Feb-14-2018

if(@perform_next_test('1r', remote_lc_partner))
{
  return(1);
}

if(@perform_next_test('2r', remote_lc_partner))
{
  return(1);
}

// End of 1-2 tests. ****


goto_mark;

return(0);
}



//;

void
@find_lc_partner()
{
str fp = "Find lc partner.";

// fcd: Dec-7-2015

str lc;

if(@current_line_contains('^'))
{
  str lc = @get_indicated_lc_2;
  @find_lc(lc);
  @footer;
  return();
}

if(@current_line_contains('&'))
{
  str lc = @get_indicated_lc_2;
  @find_lc(lc);
  @footer;
  return();
}

if(!@current_line_has_an_lc_partner(lc))
{
  @say(fp + ' Error: There is no lc partner on the current line. (' + lc + ')');
  @footer;
  return();
}

@find_lc(lc);

@say(fp + ' (' + lc + ')');
}



//;

void
@@find_lc_partner
{
@header;
@save_location;
@find_lc_partner;
@footer;
}



//;

void
@pair_with_k
{
str fp = "Pair with k.";

@header;

// fcd: Feb-15-2016
@save_location;
@cut_bullet;
@find_lc('k');
@find_next_bullet;
@paste_after_with_subbullet;
@restore_location;

@footer;

@say(fp);
}



//;

void
@add_bullet_at_c_and_paste_ww
{
str fp = "Add bullet at c and paste without wrapping.";

@header;

@add_bullet_at_lc('rfwtl');
@paste;

@footer;

@say(fp);
}



//;

void
@bam_2
{
str fp = "BAM 2.";
@header;

// fcd: Mar-30-2016

@cut_bullet;

mark_pos;

@bobs;
@find_previous_content_area;
@paste_after;

goto_mark;

@footer;
@say(fp);
}



//;

void
@add_bullet_above_then_paste_ww
{
str fp = "Add bullet above then paste without wrapping.";

@header;

// fcd: Apr-23-2016

@add_bullet_above;
@paste_without_wrapping;
@bob;
@eoc;
@delete_character;
@delete_character;

@footer;
@say(fp);
}



//;

void
@find_lc_subsegment_with_uc
{
str fp = "Find in LC with UC. This finds subsegment LCs.";

// fcd: Apr-25-2016

str rs;
str so;
int efbo = true; // execute first block only

@header;

str sc = @get_wost;

sc = '\(!.#' + sc + '.#\)';

rs = '\0';
@eol;

if(efbo){ int is_found = @seek_in_all_files_2_arguments(sc, fp); efbo = 0; }

@footer;
@say(fp);
}



//;

void
@move_bullet_to_eopr_alone
{
str fp = "Move bullet to end of previous rubric alone.";
@header;

// fcd: Jun-12-2016

@save_location;
@cut_bullet;
@bobs;
up;
up;
@paste;
@bob;

@restore_location;
@find_next_bullet;
@footer;
@say(fp);
}



//;

void
@read_some_headlines
{
str fp = "Pass a url to a browser.";

// fcd: Jan-29-2020

@header;

int is_found = 0;
str url;

url = @get_remote_oj_using_klc('rfscne', is_found);
@surf(url, 1);

url = @get_remote_oj_using_klc('cnet', is_found);
@surf(url, 1);

url = @get_remote_oj_using_klc('rfbbc', is_found);
@surf(url, 1);

url = @get_remote_oj_using_klc('rfcnn', is_found);
@surf(url, 1);

url = @get_remote_oj_using_klc('dawi', is_found);
@surf(url, 1);

url = @get_remote_oj_using_klc('fcnp', is_found);
@surf(url, 1);

url = @get_remote_oj_using_klc('rffox', is_found);
@surf(url, 1);

url = @get_remote_oj_using_klc('rffran', is_found);
@surf(url, 1);

url = @get_remote_oj_using_klc('rfght', is_found);
@surf(url, 1);

url = @get_remote_oj_using_klc('rfguar', is_found);
@surf(url, 1);

url = @get_remote_oj_using_klc('rfnyt', is_found);
@surf(url, 1);

url = @get_remote_oj_using_klc('rfquil', is_found);
@surf(url, 1);

url = @get_remote_oj_using_klc('rfwash', is_found);
@surf(url, 1);

url = @get_remote_oj_using_klc('rfreas', is_found);
@surf(url, 1);

url = @get_remote_oj_using_klc('rfwsj', is_found);
@surf(url, 1);

url = @get_remote_oj_using_klc('tuca', is_found);
@surf(url, 1);

@footer;
@say(fp);
}



//;

void
@open_multiple_local_hosts
{
str fp = "Open multiple local hosts.";

// fcd: Mar-31-2017

@header;

int is_found = 0;
str url;

url = '127.0.0.1'; @surf(url, 1);
url = '70.182.186.117'; @surf(url, 1);
url = 'http://localhost'; @surf(url, 1);
url = 'http://localhost/'; @surf(url, 1);
url = 'https://localhost/app';
url = 'http://localhost:8080'; @surf(url, 1);
url = 'http://localhost:8081'; @surf(url, 1);
url = 'localhost';
url = 'localhost.com'; @surf(url, 1);

@footer;
@say(fp);
}



//;

void
@do_synonym_task()
{
str fp = "Do synonym task.";

// fcd: Sep-19-2016

@header;

@save_location;

int lc_is_found = 0;

@lp_small_segment_content('ax1');

@create_timestamped_file;

@paste;

str rs = @get_remote_oj_using_klc('ax2', lc_is_found);

str sc = '\#';

@bof;

@replace_all_occurrs_inf_one_tof(sc, rs);

@eof;

cr;
cr;

@select_all;

@copy;

@close_and_save_file_wo_prompt;

@find_lc('rfwtl');

@find_next_bullet;

@footer;

@say(fp);
}



//;

void
@find_latest
{
str fp = "Find latest.";

@header;

// fcd: Sep-20-2016

str sc = 'This is the ' + 'latest.';

@seek_in_all_files_2_arguments(sc, fp);

@footer;

@say(fp);
}



//;

void
@start_c_colon_on_a_new_line
{
str fp = "Start c colon on a new line.";
str rs;
str sc;
str so;
int efbo = true; // execute first block only

if(@current_line > 14000)
{
}
tof;

@header;
sc = '(c:)';
rs = '$$\0';
@eol;

if(efbo){ so = @replace_all_occurrs_inf_one_tof(sc, rs); efbo = 0; }
if(efbo){ so = @replace_next_occurrence_only(sc, rs); efbo = 0; }
if(efbo){ @seek_next(sc, so); efbo = false; }
if(efbo){ int is_found = @seek_in_all_files_2_arguments(sc, fp); efbo = 0; }

@footer;
@say(found_str);
@say(so);
@say(fp);
}



//;

void
@move_dog_park_to_eof()
{
str fp = "Move dog park to eof.";

// fcd: Nov-22-2016

if(!@is_batch_file)
{
  return();
}

if(@seek_from_bof('!rf' + 'cea') != 1)
{
  return();
}

@bor;
@cut_rubric;
@eof;
@bol;
@paste;
@eof;
@bol;

@say(fp);
}



//;+ Batch File Stubs



//;;

void
@add_batch_file_stub_bare_bones()
{
str fp = "Add batch file stub bare bones.";

// fcd: Jun-30-2020

if(!@is_batch_file)
{
  return();
}

@save_location;

@move_dog_park_to_eof;

str sc = 'rfbare';
//int is_found = @seek_in_all_files_2_arguments(sc, fp);
@find_lc(sc);

@hc_small_segment_content_dinc();

@restore_location;

@find_next_rubric;

@bol;
cr;
cr;
cr;
up;
up;
up;
@paste;


@bobs;
up;
@bobs;

@seek('x_marker');

@hc_subject;

@delete_block;

@seek('x_marker');

@hc_subject;

@delete_block;

@seek('lu');
@eol;
text(' ');
@add_text_date;

down;
down;
down;
down;
down;
down;
down;
@bol;
text('rem q' + 'q-1');
cr;
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
@eol;
text(' ');

@say(fp);
}



//;;

void
@add_batch_file_stub_generic()
{
str fp = "Add batch file new stub.";

// fcd: Sep-21-2016

if(!@is_batch_file)
{
  return();
}

@save_location;

@move_dog_park_to_eof;

str sc = 'rftnew';
//int is_found = @seek_in_all_files_2_arguments(sc, fp);
@find_lc(sc);

@hc_small_segment_content_dinc();

@restore_location;

@find_next_rubric;

@bol;
cr;
cr;
cr;
up;
up;
@paste;

return();

@bobs;
up;
@bobs;

@seek('x_marker');

@hc_subject;

@delete_block;

@seek('x_marker');

@hc_subject;

@delete_block;

@seek('lu');
@eol;
text(' ');
@add_text_date;

down;
down;
down;
down;
down;
down;
down;
@bol;
text('rem q' + 'q-1');
cr;
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
@eol;
text(' ');

@say(fp);
}



//;;

void
@add_cbf_template()
{
str fp = "Add batch file new stub for n.bat.";

// fcd: Jun-12-2018

@save_location;

int original_line_number = @current_line_number;

@move_dog_park_to_eof;

str sc = '!' + 'rfaf';
int is_found = @seek_in_all_files_2_arguments(sc, fp);

@hc_small_segment_content_dinc();

@restore_location;

goto_line(original_line_number);

@find_next_rubric;

@bol;
cr;
cr;
up;
up;
up;
@paste;

@find_bobs_or_previous_bs;

@seek('x_marker');

@hc_subject;

@delete_block;

@seek('x_marker');

@hc_subject;

@delete_block;

@seek('lu');

@eol;
text(' ');
@add_text_date;

down;
down;
down;

down;
down;
down;
down;

@bol;

text('rem Dec-10-2020_12_16_PM q' + 'q1');

up;
up;
up;
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
@add_cbf_template_short_version()
{
str fp = "Add cbf template short version.";

// fcd: Jun-18-2021

@save_location;

int original_line_number = @current_line_number;

@move_dog_park_to_eof;

str sc = '!' + 'rfafs';
int is_found = @seek_in_all_files_2_arguments(sc, fp);

@hc_small_segment_content_dinc();

@restore_location;

goto_line(original_line_number);

@find_next_rubric;

@bol;
cr;
cr;
up;
up;
up;
@paste;

@find_bobs_or_previous_bs;

@seek('x_marker');

@hc_subject;

@delete_block;

@seek('x_marker');

@hc_subject;

@delete_block;

@seek('lu');

@eol;
text(' ');
@add_text_date;

down;
down;
down;

down;
down;
down;
down;

@bol;

text('rem Dec-10-2020_12_16_PM q' + 'q1');

up;
up;
up;
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
@@add_cbf_template
{
@header;
@add_cbf_template;
@footer;
}



//;;

void
@@add_batch_file_stub_generic
{
@header;
@add_batch_file_stub_generic;
@footer;
}



//;;

void
@add_batch_file_stub_router(str starting_position = parse_str('/1=', mparm_str))
{
str fp = "Add batch file stub router.";

// lu: Nov-2-2018

@header;

switch(starting_position)
{
  case 'e':
    @eof;
    break;
  case '':
    break;
  default:
    if(!@find_lc(starting_position))
    {
      @say(fp + ' Starting position lc not found.');
      return();
    }
    @eof;
}

@add_cbf_template;

@footer;
}



//;;

void
@add_batch_file_stub_router_sv(str starting_position = parse_str('/1=', mparm_str))
{
str fp = "Add batch file stub router - short version.";

// lu: Nov-2-2018

@header;

switch(starting_position)
{
  case 'e':
    @eof;
    break;
  case '':
    break;
  default:
    if(!@find_lc(starting_position))
    {
      @say(fp + ' Starting position lc not found.');
      return();
    }
    @eof;
}

@add_cbf_template_short_version;
//qq1

@footer;
}



//;+ BAM 2



//;; (!2mum3)

str
@run_bullet_action_model_2(str arguments = parse_str('/1=', mparm_str))
{
str fp = "Bullet Action Model 2.";

// fcd: Oct-3-2016

@save_column;

if(@is_subbullet)
{
  @bob;
}

if(!@is_bullet)
{
  @restore_column;
  return(@constant_not_a_bullet);
}

str arg_1, arg_2, arg_3, arg_4;

arguments = @lower(arguments);

@parse_arguments_4_parameters(arguments, ".", arg_1, arg_2, arg_3, arg_4);

//@say(fp + ' arg_1: ' + arg_1 + ' (Jan-8-2017 11:06 PM)');return();
//@say(fp + ' arg_2: ' + arg_2 + ' (Jan-8-2017 11:06 PM)');return();

str lc = arg_1;

str incorrect_parameter_value = '';

str location_modifier = '';
str move_style = '';
str selected_rubric = '';
str togetherness = '';

switch(arg_2)
{
  case 'a':
    togetherness = arg_2;
    break;
  case 'b':
    location_modifier = arg_2;
    break;
  case 'c':
    move_style = arg_2;
    break;
  case 'd':
    move_style = arg_2;
    break;
  case 'e':
    location_modifier = arg_2;
    break;
  case 'm':
    location_modifier = arg_2;
    break;
  case 'n':
    selected_rubric  = arg_2;
    break;
  case 'p':
    selected_rubric  = arg_2;
    break;
  case 'v':
    move_style = arg_2;
    break;
  case 'w':
    togetherness = arg_2;
    break;
}
switch(arg_3)
{
  case 'a':
    togetherness = arg_3;
    break;
  case 'b':
    location_modifier = arg_3;
    break;
  case 'c':
    move_style = arg_3;
    break;
  case 'd':
    move_style = arg_3;
    break;
  case 'e':
    location_modifier = arg_3;
    break;
  case 'm':
    location_modifier = arg_3;
    break;
  case 'n':
    selected_rubric  = arg_3;
    break;
  case 'p':
    selected_rubric  = arg_3;
    break;
  case 'v':
    move_style = arg_3;
    break;
  case 'w':
    togetherness = arg_3;
    break;
}
switch(arg_4)
{
  case 'a':
    togetherness = arg_4;
    break;
  case 'b':
    location_modifier = arg_4;
    break;
  case 'c':
    move_style = arg_4;
    break;
  case 'd':
    move_style = arg_4;
    break;
  case 'e':
    location_modifier = arg_4;
    break;
  case 'm':
    location_modifier = arg_4;
    break;
  case 'n':
    selected_rubric  = arg_4;
    break;
  case 'p':
    selected_rubric  = arg_4;
    break;
  case 'v':
    move_style = arg_4;
    break;
  case 'w':
    togetherness = arg_4;
    break;
}


// Set the defaults.
if(location_modifier == '')
{
  location_modifier = 'b';
}

if(move_style == '')
{
  move_style = 'v';
}

if(togetherness == '')
{
  togetherness = 'a';
}

@save_location;

if(move_style == 'c')
{
  @hc_bullet;
}

int bullet_was_cut = false;
if(move_style == 'v')
{
  @cut_bullet;
  bullet_was_cut = true;
}

if(selected_rubric != '')
{
  if(selected_rubric == 'p')
  {
    @bor;
    up;
    @bor;
  }
  else
  {
    // Else it must be 'n'.
    @find_next_big_segment;
  }
}
else if(lc != '')
{
  if(!@find_lc(lc))
  {
    if(bullet_was_cut)
    {
      @paste;
      @find_previous_bullet;
    }
    @restore_column;
    return(@constant_lc_not_found);
  }
}

if(location_modifier == 'b')
{
  @bobs;
}
else if(location_modifier == 'm')
{
  @mor;
}
else if(location_modifier == 'e')
{
  @eor;
}
else
{
  incorrect_parameter_value = 'Location modifier parameter has an incorrect value.';
}

if(move_style == 'd')
{
  togetherness = 'w';
  @add_bullet_below;
}
else
{
  @paste_after;
}

if(togetherness != 'w')
{
  if(@is_paste_before_in_same_window)
  {
    @restore_location_2;
    fp += ' Rc2.';
  }
  else
  {
    @restore_location;
    fp += ' Rc.';
  }
}

if(@is_blank_line)
{
  @put_cursor_somewhere_useful;
}

@restore_column;

fp += " (Args: '" + arguments + "')";
@say(fp);
return('');
}



//;;

str
@@run_bullet_action_model_2(str sc = parse_str('/1=', mparm_str))
{
@header;
return(@run_bullet_action_model_2(sc));
@footer;
}



//;

void
@instrument_global_variables
{
str fp = "Instrument global variables.";

// fcd: Oct-19-2016

fp += ' ir: ' + str(global_int('initial row number'));
fp += ', ic: ' + str(global_int('initial column number'));
fp += ', iw: ' + str(global_int('initial window number'));

@say(fp);
}



//;

void
@bam_2_with_caller
{
str fp = "Move bullet to lc (together).";

@header;

// fcd: Oct-27-2016

str user_input = @get_user_input_nonspace(fp);

if((user_input == @constant_function_aborted))
{
  @say(user_input);
  @footer;
  return();
}

user_input += '.w';

if(@run_bullet_action_model_2(user_input) == @constant_lc_not_found)
{
  @say(fp + ' ' + @constant_lc_not_found);
  @footer;
  return();
}

@footer;

@say(fp);
}



//;

void
@add_text_return_statement
{
str fp = "Add text return statement.";

// fcd: Nov-23-2016

@bol;
cr;
up;
text('@say(fp + ');
text("' (" + @get_date_with_time + ")');");
text('return();');
text(' //q' + 'jq');

@say(fp);
}



//;

void
@move_rubric_to_position_1
{
str fp = "Move rubric to position 1.";

if(!@is_batch_file)
{
  return();
}

@header;

// fcd: Nov-28-2016

@cut_rubric;

@find_lc('rfrouter');

@find_next_rubric;

@bor;

@paste;

up;
@bor;

@footer;
@say(fp);
}



//;

void
@add_text_barckets
{
str fp = "Add text barckets.";

// fcd: Nov-30-2016

text(char(91) + char(93));

left;

@say(fp);
}



//;

void
@create_last_updated_entry
{
str fp = "Create last updated entry.";
@header;

// fcd: Dec-2-2016

@open_file(get_environment('reach out') + '\last updated.asc');

@find_lc('rflu');
@add_bullet_below;
@add_text_date_and_time_fixed_w;
text('  ');

text(get_environment("computername"));
goto_col(39);
mark_pos;
eof;
str number_of_lines_in_file = str(c_line);
@add_commas_to_a_number(Number_of_Lines_in_File);
goto_mark;
text(number_of_lines_in_file);

//@bob;

//@hc_bullet;

//@find_lc('rfwtl');

//@paste_after;

@footer;
@say(fp);
}



//;

void
@create_last_updated_entry_fres
{
str fp = "Create last updated entry for Fresnel.";
@header;

// fcd: Dec-2-2016

@open_file(get_environment('dropbox') + '\it\fresnel\fresnel\views\AboutPage.xaml');
@find_lc('rf' + 'spfr');
@delete_line;
@bol;
cr;
up;
text('                    Text="');
@add_text_date_and_time;
text('"');
@footer;
@say(fp);
}



//;

void
@create_last_updated_entry_bust
{
str fp = "Create last updated entry for Buster.";
@header;

// fcd: Jul-31-2018

@open_file(get_environment('dropbox') + '\it\buster\buster\buster\views\Page1.xaml');
@find_lc('rf' + 'spbr');
@delete_line;
@bol;
cr;
up;
text('                    Text="');
@add_text_date_and_time;
text('"');
@footer;
@say(fp);
}



//;

void
@find_new_dates(str lc = parse_str('/1=', mparm_str))
{
str fp = "Find new dates";

// fcd: Dec-4-2016
str rs;
str sc;

@header;

str month = 'Dec';

if(lc != '')
{
  @find_lc(lc);
}

sc = month + '-([0-9][0-9])||([0-9])-2016';

@eol;

int is_found = @seek_in_all_files_2_arguments(sc, fp);

@footer;
@say(fp);
}



//;

void
@start_new_jira_ticket
{
str fp = "";
fp = "Start new Jira ticket.";

@header;
@find_lc('rftk');
@add_subrubric_below('');
//int ticket_number_counter = @increment_ticket_number_counter;
//text(str(ticket_number_counter));
//text(' - Created on ');
text(' - ');
eol;
@add_text_date;
//@add_text_lc_on_current_line('tk' + str(ticket_number_counter));
@add_text_lc_and_individuate_it('cj');
@bol;
right;
right;
@footer;
}



//;

void
@replace_semicolons_with_crs()
{
str fp = "Replace all semicolons in file with carriage returns.";
// fcd: Dec-13-2016
str rs;
str sc;

if(@is_bullet_file)
{
  return();
}

@tof;

sc = ';';
rs = '$';
@eol;

@replace_all_occurrs_inf_one_tof(sc, rs);

@say(fp);
}



//;

void
@@replace_semicolons_with_crs
{
@header;
@replace_semicolons_with_crs;
@footer;
}



//;

void
@open_rdp_an_easier_way
{
str fp = "Run RDP.";

@run_clif_internally('rfrdp');
//@set_clipboard('mercury-jp.dreamhammer.com:21624');

@say(fp);
}



//;

void
@open_local_host_an_easier_way
{
str fp = "Open Local Host with interplay prepasted into buffer.";

fp = "Open localhost an easier way.";

str url;

url = '127.0.0.1'; // This is a working redirect. Apr-10-2017
url = '70.182.186.117';
url = 'http://10.0.2.2';
url = 'http://10.0.2.2/JWS/MercuryWebService';
url = 'http://10.0.2.2/JWS/MercuryWupService';
url = 'http://10.0.2.2/pub/jwsController';
url = 'http://localhost'; // This is a working redirect. Apr-10-2017
url = 'http://localhost/'; // This is a working redirect. Apr-10-2017
url = 'http://localhost:8080';
url = 'http://localhost:8081';
url = 'https://localhost/app';
     //http://localhost/index.html This works on the new server.
url = 'localhost'; // This is a working redirect. Apr-10-2017
url = 'localhost.com';
url = 'localhost/app';
url = 'localhost/app/';
url = 'localhost/app/mercury.html';
url = 'localhost/index.html'; // Only half works.
url = 'localhost/index.html/app'; // Only half works.
url = 'localhost/mercury.html'; // This works. Apr-11-2017
url = 'localhost/mercury.html/app';
url = 'localhost/mercury.html/app/';

// Last in wins.
url = 'localhost/mercury.html'; // This works. Apr-11-2017

// skw: machine, machinename, machine_name

switch(@lower(Get_Environment("ComputerName")))
{
  case "buzz":
    // For some reason this no longer works, but luckily the one for my NES laptop does.
    //    url = 'http://localhost:8080';
    break;
}

@set_clipboard('t');

@surf(url, 1);

@say(fp);
}



//;

void
@word_search_game_engine_f1
{
str fp = "4 letter word starts with z ends with r";

// fcd: Jan-18-2017

// Word Search Game Engine: skw

str rs;
str sc;
str sc_core;
str special_characters;

@header;
sc = "[^a-zé!·]z[a-z][a-z]r[^a-z]";
sc = "[^\\-]1";

special_characters = "[^a-zé!·\\-']";
sc_core = "z[a-z][a-z]r";
sc = special_characters + sc_core + special_characters;

@eol;

int is_found = @seek_in_all_files_2_arguments(sc, fp);
@footer;
@say(fp);
}



//;

void
@add_text_semicolon
{
str fp = 'Add semicolon.';
/*
This function used to live in Jonathan's_Macros.s. But then when I was doing testing and 
it wouldn't compile, I could use the semicolon key, so that wasn't working for me.
*/
text(';');
}



//;

void
@add_text_batch_file_error_check
{
str fp = 'Add batch file error check.';

text('if %errorlevel% gtr 0 exit/b');
}



//;

void
@add_text_brackets
{
str fp = 'Add text brackets.';
text('[]');
left;
}



//;

void
@echo_string
{
str fp = "Echo string.";

// fcd: "Feb-23-2017

fp += ' Current line type: "' + @current_line_type + '"';

@say(fp);
}



//;

void
@copy_this_file_into_j1
{
str fp = "Copy this file into j1.txt.";

// fcd: Jun-28-2017
@header;

@select_all;
@copy;

@open_file('c:\a\j1.txt');
@select_all;
delete_block;
@paste;
@close_and_save_file_wo_prompt;

@footer;
@say(fp);
}



//;

void
@copy_this_file_into_j2
{
str fp = "Copy this file into j2.txt.";

// fcd: Jun-28-2017
@header;

@select_all;
@copy;

@open_file('c:\a\j2.txt');
@select_all;
delete_block;
@paste;
@close_and_save_file_wo_prompt;

@footer;
@say(fp);
}



//;

void
@copy_to_study_hall(str scope = parse_str('/1=', mparm_str))
{
str fp = "Copy to study hall.";

// fcd: "Mar-31-2017
@header;

if(scope == '')
{
  scope = 'b';
}

switch(scope)
{
  case 'b':
    if(!@is_bullet_file)
    {
      return();
    }
    @hc_bullet;
    break;
  case 'l':
    @hc_line;
    break;
  case 'w':
    @hc_word_uc;
    break;
  default:
}

@save_location;

@find_lc('rfhall');

switch(scope)
{
  case 'b':
    @paste_after;
    break;
  case 'l':
    @eol;
    cr;
    cr;
    text(':');
    @paste;
    if(@second_character(get_line) == ':')
    {
      @bol;
      right;
      @delete_character;
    }
    break;
  case 'w':
    @add_bullet_below;
    @paste;
    break;
}

@recall_location;

@footer;
@say(fp);
}



//;

void
@format_active_users_email
{
str fp = "Format active users email.";

// fcd: May-5-2017

str rs;
str sc;

tof;
@bol;

@header;
sc = '$^';
rs = ';';

@replace_all_occurrs_inf_one_tof(sc, rs);
@footer;
}



//;

void
@copy_and_compile_documentation
{
str fp = "Copy and compile documentation.";
   fp = "May-30-2017 4:47 PM";
// fcd: "May-30-2017
@header;

@run_clif_internally('acpdoc');
@run_clif_internally('sfdoc');

@footer;
@say(fp);
}



//;

void
@load_clipboard_then_run_rdp(str lc = parse_str('/1=', mparm_str))
{
str fp = "Load clipboard then run RDP.";

int lc_is_found;

str ip_address = '$Becharming2';

if(lc != '')
{
  ip_address = @get_remote_oj_using_klc(lc, lc_Is_Found);
}

@set_clipboard(ip_address);

@run_clif_internally('rfrdp');

@say(fp);
}



//;

void
@replace_carriage_returns_w_semi()
{
str fp = "Replace all carriage returns with semicolons.";

// lu: Aug-7-2017

str rs;
str sc;

@tof;

sc = '$^';
rs = ';';
@eol;

@replace_all_occurrs_inf_one_tof(sc, rs);

@say(fp);
}



//;

void
@test_harness_for_informal_foll
{
str fp = "Test harness for @informal_followed_by_a_crowding.";
str fud = "Aug-13-2017";
// fcd: Aug-13-2017
str rs;
str sc;
str regex_description;

sc = @informal_followed_by_a_crowding(regex_description, rs);

@seek(sc);

@say(fp);
return();

// The following versions should not trigger a match.

// informal_followed

// informally

@replace_next_occurrence_only(sc, rs);
@say(rs);
@replace_all_occurrs_inf_one_tof(sc, rs);
int is_found = @seek_in_all_files_2_arguments(sc, fp);

@footer;
rs = '\0';
@say(found_str);
}



//;

void
@replace_everything_after_the_co
{
str fp = "Replace everything after the colon with nothing.";

// lu: Aug-31-2017

str rs;
str sc;

@header;

sc = ':.+,$';
rs = '';

@eol;

@replace_next_occurrence_only(sc, rs);

@footer;

@say(fp);
}



//;

void
@begin_each_line_with_this_path
{
str fp = "Begin each line with this path.";

// lu: Aug-31-2017

str rs;
str sc;

@header;
sc = '^';
rs = 'C:\\projects\\netbeans\\sencha\\HTML5Application\\public_html\\classic\\src\\view\\';

right;

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
@run_batch_file_with_parameter_2(str arguments = parse_str('/1=', mparm_str))
{
str fp = "Run batch file with parameter.";

// fcd: Nov-15-2017

str argument_1, argument_2;

@parse_arguments(arguments, ".", argument_1, argument_2);

@process_batx_clif_block(argument_1 + '.batx ' + argument_2);

@say(fp);
}



//;

void
@reformat_url_string
{
str fp = "Reformat URL string.";

// lu: Dec-7-2017

str rs;
str sc;

@header;

sc = '&';
rs = '$';

@eol;

@replace_all_occurrs_inf_one_tof(sc, rs);

@footer;
@say(fp);
}



//;

void
@reformat_url_string_2
{
str fp = "Reformat URL string 2.";

// lu: Dec-7-2017

str rs;
str sc;

@header;

sc = ',';
rs = '$';

@eol;

@replace_all_occurrs_inf_one_tof(sc, rs);

@footer;
@say(fp);
}



//;

void
@add_text_if_statement()
{
str fp = "Add text if statement.";

// lu: Jan-8-2018

@bol;
text('if()');
cr;
text('{');
cr;
cr;
text('}');
up;
up;
up;
@eol;
left;

@say(fp);
}



//;

void
@add_text_else_statement()
{
str fp = "Add text else statement.";

// lu: Aug-7-2018

@bol;
text('else');
cr;
text('{');
cr;
cr;
text('}');
up;
up;
up;
@eol;
left;

@say(fp);
}



//;

void
@add_text_if_else_statement
{
str fp = "Add text if and else statement.";

// lu: Nov-20-2018

@add_text_else_statement;
@bol;
cr;
up;
@add_text_if_statement;
@say(fp);
}



//;

void
@reverse_bullet_order
{
str fp = "Reverse bullet order.";
@header;

@save_location;
@cut_bullet;
@find_lc('sourgi');
@paste_after;
@recall_location;

@footer;
@say(fp);
}



//;

void
@add_blank_lines_after_ago()
{
str fp = "Add a blank line after for job postings.";

// lu: Feb-13-2018

str rs;
str sc;

sc = 'Ago$';
rs = 'Ago$';

@tof;

@replace_all_occurrs_inf_one_tof(sc, rs);

}



//;

void
@add_colons_after_blank_lines()
{
str fp = "Add colons after blank lines.";

// lu: Feb-13-2018

str rs;
str sc;

sc = '$$^';
rs = '$$:';

@tof;

@replace_all_occurrs_inf_one_tof(sc, rs);

@say(found_str);
@say(fp);
}



//;

void
@prepare_message_to_phone_file
{
str fp = "Prepare message to phone file.";

// lu: Mar-8-2018

@header;

@save_location;

@open_file(get_environment('dropbox') + '\savannah\reach out\message to phone.mtp');

@delete_all;

@paste;

@bof;

@delete_carriage_returns;

@footer;
@say(fp);
}



//;

void
@find_lc_partner_listed_in_bsh
{
str fp = "Find lc partner listed in big segment header.";

@save_location;

@header;

@bobs;
@find_lc_partner;

@footer;
@say(fp);
}



//;

void
@copy_bullet_to_lc_together
{
str fp = "Copy bullet to lc together.";

// lu: Jul-3-2018

@header;

@hc_bullet;

if(@find_lc(@get_user_input_nonspace(fp)))
{
  @paste_after;
}

@footer;
@say(fp);
}



//;

void
@copy_aff_file_contents_to_nptl
{
str fp = "Open ph and copy it's contents to Now Playing Task List (nptl).";

// lu: Dec-1-2019

@header;

str filename[128] = Get_Environment('dropbox') + '\savannah\reach out\myfile.txt';

@open_file(filename);

rm('block^selectall');

@copy;

@close_file;

@import_and_format_clipboard_l1;

@footer;
@say(fp);
}



//;

void
@find_next_long_line_then_hwwi
{
str fp = "Find next long line then hard word wrap it.";

// lu: Jul-11-2018

@header;

up;

if(@find_next_long_line)
{
  goto_col(95);
  cr;
  up;
}
else
{
  fp += ' No long lines found.';
  down;
}

@footer;
@say(fp);
}



//;

void
@open_cbf_dictionary_and_add_new
{
str fp = "Open the CBF dictionary and add a new definition.";

// lu: Jul-20-2018

@header;

str filename[128] = get_environment('dropbox') + '\it\composable-batch-files\n.bat';

@open_file(filename);

@add_cbf_template;

@footer;
@say(fp);
}



//;

void
@add_text_bookmark
{
str fp = "Add text bookmark.";

// lu: Jul-27-2018

@header;

mark_pos;

@bobs;

@find_next_lc;

right;
right;

@hc_word_uc;

goto_mark;

@eol;
cr;
cr;
text(":   _/)    _/)    (!");
@paste;
text('bm)');
cr;
text("  ~~~~~~~~~~~~~~");
up;

@footer;
@say(fp);
}



//;

str
@decorate_sc_with_precision(str sc = parse_str('/1=', mparm_str),
                            str find_precision = parse_str('/2=', mparm_str))
{
str fp = "Decorate sc.";

// lu: Aug-1-2018

// This enforces the idea that 3 will ALWAYS return at least as many as 2 which will ALWAYS
// return at least as many results as 1.

switch(find_precision)
{
  case '1': // most precise
    sc = @equate_spaces_and_dashes(sc);
    //Last Updated: Sep-26-2016
    sc = '^((:#)||(;#)||(:\+ @)||(;\+ @))' + sc;
    sc += '((:)||($)||(!)||(\.)||(\?)||( \())';
      // sc += '((:)||($)||(!)||(\.)||(\?)||( \()||(,))'; Prior to May-18-2018. I removed
      // the comma option.
    break;
  case '2': // intermediate
    sc = @equate_spaces_and_dashes(sc);
    sc = '^((:#)||(;#))' + sc;
    break;
  case '3': // least precise
  case '':
    sc = @equate_spaces_and_dashes_wcl(sc);
    break;
}

@say(fp);
return(sc);
}



//;

int
@find_continuum_2(str sc = parse_str('/1=', mparm_str),
                  str find_precision = parse_str('/1=', mparm_str))
{
str fp = 'Find continuum 2.';

// lu: Aug-1-2018

str Pretty_sc = sc;

set_global_str('pretty_sc', sc);

sc = make_literal_x(sc);

sc = @decorate_sc_with_precision(sc, find_precision);

str so;

int rv;

rv = @seek_in_all_files_2_arguments(sc, so);

if(rv == 2)
{
  //@restore_location;
}

@say(fp += ' ' + so + ' (' + Pretty_sc + ')');

return(rv);
}



//;

void
@ff_lc_with_precision(str lc = parse_str('/1=', mparm_str))
{
str fp = 'Find from lc with precision.';

// lu: Aug-1-2018

str first_parameter, second_parameter;
@parse_arguments(lc, ".", first_parameter, second_parameter);
str lc = first_parameter;
str find_precision = second_parameter;

str sc = @get_sj;

@find_lc(lc);

@find_continuum_2(sc, find_precision);

//@say(fp + ' LC: ' + lc + ', Find Precision: ' + find_precision);
}



//;

void
@add_bullet_with_datestamp(str lc = parse_str('/1=', mparm_str))
{
str fp = "Add bullet with datestamp.";

// lu: Aug-7-2018

@header;

@find_lc(lc);

@add_bullet_below;

@add_text_date;

@footer;
@say(fp);
}



//;

void
@use_firefox_and_gen
{
str fp = "Use Firefox and gen.";

// lu: Aug-7-2018

str current_line = @get_line;
str url;

current_line = @trim_leading_colons_et_al(current_line);

if(@first_4_characters(current_line) == 'http')
{
  url = current_line;
}
else
{
  url = @get_oj;
}

url = @replace_once(url, 'youtube', 'genyoutube');

@surf(url, 2);

@say(fp);
}



//;

void
@paste_and_format_link
{
str fp = "Paste and format link.";

// lu: Aug-24-2018

@paste_with_wikipedia_format;

//@apply_2_line_format;

@say(fp);
}



//;

void
@replace_colons_with_asterisks
{
str fp = "Replace colons with asterisks.";

// lu: Aug-28-2018

@header;

str rs;
str sc;

@header;
sc = '^:';

@eol;

@seek(sc);
rs = '* ';
@replace_all_occurrs_inf_one_tof(sc, rs);

@footer;
@say(fp);
}



//;

void
@say_current_line_type
{
str fp = "Say current line type.";

// lu: Sep-4-2018

@say(fp + ' (' + @current_line_type + ')');
}



//;+ Programming Exercises



//;;

void
@fuzz_biz_interview_test
{
str fp = "Fuzz biz interview test.";

@header;
int Counter = 1;

str Text_to_Write = '';

while(Counter <= 100)
{
  Text_to_Write = '';
  if(!(Counter % 5))
  {
    Text_to_Write = 'Fiz';
  }
  if(!(Counter % 3))
  {
    Text_to_Write += 'Buzz';
  }
  if(length(Text_to_Write))
  {
    text(str(Counter) + ': ');
    text(Text_to_Write);
    cr;
  }
  Counter++;
}

@footer;
@say(fp);
}



//;;

void
@reverse_string(str subject_String)
{
str fp = "Reverse string.";

str reversed_string = '';

while(length(subject_string) > 0)
{
  reversed_string += @last_character(subject_string);
  subject_string = @trim_last_character(subject_string);
}

@say(reversed_string);

/*
public static bool IsPrimeNumber(int numberToTest)
{
    for (int i = 2; i < numberToTest; i++)
    {
        if (numberToTest % i == 0)
        {
            return (false);
        }
    }
    return true;
}
*/

}



//;;

void
@reverse_string_tn
{
@reverse_string('Sep-24-2019');
}



//;

void
@move_bullet_to_same_lc_as_prev
{
str fp = "Move bullet to same lc as last time.";

// lu: Nov-9-2018

@header;

@move_bullet_to_lc_alone(global_str('lc'));

@footer;
@say(fp + ' (' + @distill_lc(global_str('lc')) + ')');
}



//;

void
@add_echo_line
{
str fp = "Add echo blank line in batch files.";

// lu: Jan-9-2019

str rs;
str sc;

@header;
sc = 'echo \%fp';

@eol;

@seek(sc);
rs = 'echo\.$echo \%fp';
@replace_all_occurrs_inf_one_tof(sc, rs);
return();
@replace_next_occurrence_only(sc, rs);
int is_found = @seek_in_all_files_2_arguments(sc, fp);

@footer;
@say(found_str);
@say(fp);
}



//;

void
@convert_slashes_to_backslashes
{
str fp = "Convert slashes to backslashes.";

// lu: Jan-17-2019 12:21 PM

put_line(@replace(get_line, '/', '\'));

@say(fp);
}



//;

void
@convert_line_to_double_percents
{
str fp = "Convert line to double percents.";

// lu: Jan-28-2019

put_line(@commute_character(get_line, '%', '%%'));

@say(fp);
}



//;

void
@add_a_new_label_at_passthrough
{
str fp = 'Add a new label at pass-through.';

// lu: Feb-1-2019

str rs;
str sc;

@header;

@hc_subject;

sc = ':pass-through$';

If(!@seek_in_all_files_2_arguments(sc, fp))
{
  fp += ' Error. N.bat is probably not open.';
  return();
}
@bol;
cr;
cr;
up;
up;
text(':');
@paste;

@footer;
@say(fp);
}



//;

void
@debug_say_current_area_type
{
str fp = "Debug say current_area_type.";

// lu: Mar-11-2019

@say(@current_area_type);
}



//;

void
@debug_say_is_jenkinsfile
{
str fp = "Test whether file is a Jenkinsfile.";

// lu: Mar-12-2019

if(@is_jenkinsfile)
{
  fp += ' This is a Jenkinsfile.';
}
else
{
  fp += ' This is a not Jenkinsfile.';
}

@say(fp);
}



//;

void
@tab
{
str fp = "2 Space tab.";

// lu: Mar-28-2019

text('  ');

@say(fp);
}



//;

void
@delete_all_commas_at_eol
{
str fp = "Delete all commas at eol in file.";

// lu: Apr-9-2019

str rs;
str sc;

@header;
sc = ',$';

@replace_all_occurrs_inf_one_tof(sc, rs);

@footer;
@say(found_str);
@say(fp);
}



//;

void
@open_pretty_sett_file()
{
str fp = "Open pretty sett file.";

str fp = "Synchronize my Savannah files in the background.";

str command_string = 'c:\windows\system32\cmd.exe /k ';

str parameter = get_environment("composable_batch_files") + '\show_set_3.bat';

command_string += parameter;

execprog(
  command_string, 
  '', 
  '', 
  '', 
  _EP_FLAGS_EXEWIN | 
  _EP_Flags_NoBypass);

@say(fp);
}



//;

void
@show_set_file_4
{
@header;
@open_pretty_sett_file;
@open_file(get_environment('tmp') + '\set.txt');
@replace_semicolons_with_crs;
@sort_file;
@tof;
@footer;
}



//;

void
@replace_help_1()
{
str fp = "Replace unwanted help line 1.";

// lu: Apr-17-2019

str rs;
str sc;

sc = '$$^.*"-h" goto help$';

@eol;

rs = '';

@replace_all_occurrs_inf_one_tof(sc, rs);

@say(fp);
}



//;

void
@replace_help_2()
{
str fp = "Replace unwanted help line 2.";

// lu: Apr-17-2019

str rs;
str sc;

sc = '$$^.*"help" goto help$';

@eol;

rs = '';

@replace_all_occurrs_inf_one_tof(sc, rs);

@say(fp);
}



//;

void
@dehe
{
str fp = "x";

// lu: Apr-17-2019

@header;

@replace_help_1;
@replace_help_2;

@footer;
@say(fp);
}



//;

void
@find_batch_label
{
str fp = "Find batch label.";

// lu: Apr-30-2019

@header;

str found_string;
str sc = @get_user_input_raw(fp);;
sc = make_literal_x(sc);
sc = '^:' + sc + '$';
@bof;
@seek_in_all_files_batch_files_o(sc, fp, found_string);

@footer;
@say(fp);
}



//;

void
@copy_bullet_to_bullet_buffer_he
{
str fp = "Copy bullet to bullet buffer helper.";

// lu: Jun-10-2019

@header;

@save_location;
@hc_bullet;
@find_lc('bbh');
@paste_after;
@restore_location;

@footer;
@say(fp);
}



//;

void
@copy_line_to_line_buffer_helper
{
str fp = "Copy line to line buffer helper.";

// lu: Jun-10-2019

@header;

@save_location;
@hc_line;
@find_lc('lbh');
@add_bullet_below;
@paste;
@drag_left;
@drag_left;
@restore_location;

@footer;
@say(fp);
}



//;

void
@load_clipboard_with_tail_string
{
str fp = "Load clipboard with the tail string.";

// lu: Jul-5-2019

@header;

str sc = '!' + 'rftail';
str so;
int is_found = @seek_in_all_files_2_arguments(sc, so);

@hc_subject;

@add_bullet_below;

@paste;

text(@get_date_tail_format + '.log');

str subject = @hc_subject;

@set_clipboard(subject);

@footer;

@say(fp + ' (' + subject + ')');
}



//;+



//;;

void
@say_this_filename
{
str fp = "Say this filename.";
// lu: Jun-10-2018
@say(fp + ' (' + @full_filename + ')');
}



//;;

void
@lp_this_filename
{
str fp = "Load clipboard with this filename.";
@header;
// lu: Aug-30-2019
@set_clipboard(@full_filename);
@footer;
@say(fp);
}



//;

void
@find_lc_or_batch_label
{
str fp = "Find lc or batch label.";

// lu: Oct-1-2019

@header;

@save_location;

str found_string;
str sc = @get_user_input_raw(fp);;
sc = make_literal_x(sc);
sc = '(^:' + sc + '$)||(!' + sc + ',||\))';

set_global_str('lc', sc); // Added Apr-23-2020.

@bof;
//@seek_in_all_files_batch_files_o(sc, fp, found_string);
if (@seek_in_all_files_2_arguments(sc, found_string))
{
  fp += ' Found.';
}
else
{
  fp += ' NOT found or aborted.';
  @restore_location;
}

@footer;
@say(fp);
}



//;

void
@replace_double_colon_with_sing
{
str fp = "Replace double colon with single colon.";

// lu: Oct-28-2019

str rs;
str sc;

@header;
sc = '^::';
rs = ':';
@eol;

@replace_next_occurrence_only(sc, rs);

@footer;
@say(fp);
}



//;

void
@lp_with_smart_commit_info
{
str fp = "Load clipboard with smart commit information.";

// lu: May-29-2020

@save_location;

@header;

@find_lc('cj');

@hc_subject;

@create_timestamped_file;

cr;
@paste;

@eof;
text('-jjones');

@hc_subject;

@close_and_save_file_wo_prompt;

@recall_location;

@footer;

@say(fp);
}



//;

void
@rtm
{
str fp = "x";

// lu: Sep-20-2020

str rs;
str sc;

@header;
sc = '\[clarification needed\]';
@eol;

int is_found = @seek_in_all_files_2_arguments(sc, fp);
return();
@seek(sc);
rs = '\0';
@replace_next_occurrence_only(sc, rs);
@replace_all_occurrs_inf_one_tof(sc, rs);

@footer;
@say(found_str);
@say(fp);
}



//; (!efjo, !efjm)
