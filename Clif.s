macro_file Clif; // (!cf)

#include Aliases.sh  // One of my guys.
#include Finder.sh   // One of my guys.
#include ListMgr.sh  // One of my guys. (skw qcq) Remove from production Clif.
#include melib.sh    // Used by "include ShellApi.sh.
#include Regexes.sh  // One of my guys.
#include Searcher.sh
#include Shared.sh   // One of my guys.

// Used by 'ShellExecute'. Initially I need to comment some of this code.
#include ShellApi.sh // qcq

#include WinExec.sh  // Used by 'Execprog'.



//; Macro File Glass Ceiling



//;

/*

Metadata: Track Size (!tscl, !tscf)

    Date       Lines     Bytes    Macros  Notes
 -----------  ------  ---------  -------  ----------------------------------------------------

:Nov-17-2016   4,120     75,752      105

: Oct-7-2016   4,064     74,683      104

: Apr-8-2016   3,942     72,408      103

:Dec-31-2015   4,088     74,934      105

: Oct-5-2015   4,053     74,108      104

: Jul-1-2015   3,590     65,015       93

: Apr-1-2015   2,729     50,819       68

:Jan-16-2015   2,568     48,663       59

: Oct-1-2014   2,590     48,911       58

: Jul-1-2014   2,496     47,976       53

:Apr-10-2014   2,732     52,366       64

: Oct-1-2013   2,424     47,400       54

: Jul-1-2013   2,422     47,356       54

:Apr-30-2013   2,459     48,513       53

: Apr-1-2013   2,608     49,762       55

:Jan-10-2013   2,549     48,775       54

: Jan-2-2013   2,547     48,745       54

: Oct-1-2012   2,452     47,037       51

: Jul-2-2012   2,558     49,448       51

: Apr-2-2012   2,435     47,860       44

- Jan-2-2012   2,162    42,960      43

- Dec-30-2011  2,129    41,962      43

- Dec-20-2011  1,632    33,115      33

- Oct-3-2011   1,648    33,389      38

- Aug-1-2011   1,658    33,529      38

- Jul-15-2011  1,657    33,640      38

- Jun-1-2011   1,598    32,763      35

- May-18-2011  1,596    32,703      35 = 24 pages of code

- Apr-7-2011   1,590    32,580      35

- Jan-5-2011   1,326    27,182      31

- Jan-5-2011     996    22,015      21

- Jan-3-2011   1,063    23,020      24

- Jul-1-2010   1,045    22,540      24

- Jun-1-2010   1,043    22,499      24

- May-3-2010   1,041    22,456      24

- Apr-1-2010   1,006    21,906      23

- Mar-1-2010     966    21,372      22

- Feb-1-2010     932    20,544      21

- Jan-8-2010     905    20,090      21


*/



//;

void
@load_my_macros_into_memory_1()
{
str fp = "Load my macros into memory.";

// Note: Strangely, the order that these files are loaded into memory matters,

load_macro_file("Build_CMAC_Macros"); 
load_macro_file("Jonathan's_Macros"); 
load_macro_file('Searcher');
load_macro_file('Clif');
load_macro_file('ListMgr');
load_macro_file('Aliases');
load_macro_file('Regexes');
load_macro_file('Finder');

@say(fp)
}



//; (Run_This_File, Run This File)

void
@run_this_executable_file(str filename)
{
str fp = 'Run this executable file.';

str Argument;
str Command_Line;
str Name_of_File;

if(filename == '') // The passed in parameter is empty, so use the actual filename.
{
  name_of_file = file_name;
}
else // Use the passed in parameter.
{
  name_of_file = filename;
}

switch(lower(get_extension(name_of_file)))
{
  case 'bat':
    Command_Line = 'c:\windows\system32\cmd.exe /k ';
    Argument = char(34) + Name_of_File + char(34);
    break;
  case 'htm':
    @surf(@full_filename, 0);
    return();
    break;
  case 'java':
    Command_Line = char(34) + 'C:\Program Files\Java\jdk1.8.0_102\bin\javac.exe' + char(34);
    Argument = char(34) + Name_of_File + char(34);
  ExecProg(Command_Line + ' ' + argument,
  Get_Path(Name_of_File),
  Get_Environment("TEMP") + '\\multi-edit output.txt',
  Get_Environment("TEMP") + '\\multi-edit error.txt',
  _EP_FLAGS_DONTWAIT | _EP_Flags_ExeWin);
    return();
    break;
  case 'ps1':
    Command_Line = 'c:\windows\system32\WindowsPowerShell\v1.0\powershell.exe -NoExit 
      -OutputFormat Text ';
    Argument = '.\' +  truncate_path(file_name);
    break;
  case 's':
    rm('Compile');
    @say(fp + ' Compile.');
    @load_my_macros_into_memory_1;
    return();
    break;
  case 'sqlx':
    Command_Line = 'c:\windows\system32\cmd.exe /k ' + Get_Environment('savannah') +
                   '\belfry\run_tsql_2.bat ';
    Argument = char(34) + Name_of_File + char(34);
    break;
  default:
    int Initial_Window = @current_window;
    rm("@open_file_parameter_way /FN=" + Get_Environment('savannah') 
      + "\\cmac\\source code\\Jonathan's_Macros.s");
    rm("Compile /F=" + Get_Environment('savannah') +
      "\\cmac\\source code\\Jonathan's_Macros.s /C=C:\\Program " + 
      "Files\\Multi-Edit 2008\\CmacWin.exe");
    rm("@open_file_parameter_way /FN=" + Get_Environment('savannah') 
      + "\\cmac\\source code\\ListMgr.s");
    rm("Compile /F=" + Get_Environment('savannah') +
       "\\cmac\\source code\\ListMgr.s /C=C:\\Program Files\\Multi-Edit 2008\\CmacWin.exe");
    switch_window(Initial_Window);
    @say(fp + ' Compile.');
    return();
    break;
}

ExecProg(Command_Line + Argument,
  Get_Path(Name_of_File),
  Get_Environment("TEMP") + '\\multi-edit output.txt',
  Get_Environment("TEMP") + '\\multi-edit error.txt',
  _EP_FLAGS_DONTWAIT | _EP_Flags_ExeWin);

@say(fp);
}



//;

void
@clif_say_version
{
str fp = "Clif.s v. Mar-9-2010.";

@say(fp)
}



//;

str
@hello_world_from_a_test_macro
{
str fp = "Hello world from a test macro message.";
str rv = fp + ' Hey now';

@say(fp);
set_global_str('cmac_return_value', rv);
return(fp);
}



//;+ Delete File



//;;

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
    @recall_location;
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



//;;

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

@recall_location;

@footer;
@say(fp);
}



//;+ Open Folder Family



//;;

str
@get_network_folder_path(str sc = parse_str('/1=', mparm_str))
{
str fp = "Get network folder path.";

// fcd: May-12-2015

int position_of_double_backslash = xpos('\\', sc, 1) - 1;
str path = str_del(sc, 1, position_of_double_backslash);

return(path);
}



//;;

void
@get_network_folder_path_tn
{
str fp = "Test";

// fcd: May-12-2015

fp = @get_network_folder_path('hello: \\test\123');

@say(fp);
}



//;;

str
@get_path_using_lw()
{
str fp = "Get path using location awareness.";

// fcd: Apr-23-2015

str path;

if(@text_is_selected)
{
  return(@get_selected_text);
}

path = @concatenate_multiple_lines;
path = @trim_leading_colons_et_al(path);

int percent_sign_position = xpos('%', path, 1);

if(percent_sign_position > 0)
{
  while(xpos('%', path, 1))
  {
    path = @resolve_environment_variable(path); 
  }
}

int path_length = length(path);
int position_of_double_backslash = xpos('\\', path, 1) - 1;
// Double backslash.
if(xpos(char(92) + char(92), path, 1)) // Network Locations *************************
{
  fp += 'Network folder.';
  path = @get_network_folder_path(path);
}
else 
{
  // Truncate the Clif block in order to isolate the text to the right of last colon.
  while(path_length)
  {
    if(str_char(path, path_length) == ':')
    {
      path = str_del(path, 1, path_length - 2);
      break;
    }
    path_length--;
  }
}

// Now we need to strip out the filename.
path_length = length(path);

// This block allows Alt+Space to work the same as Ctrl+Space.
if(@fourth_to_last_character(path) == '.')
{
  while(path_length)
  {
    if(str_char(path, path_length) == '\')
    {
      path = str_del(path, path_length, length(path));
      break;
    }
    path_length--;
  }
}

/* Use Case(s)

:Test: \\fuji\shared

:Test: \\fuji\shared\usr\jrj

:Test: %temp%\

:Only supported as a clif block.
:Test: %temp%\

:
c:\a\j.txt

:
c:\j.txt

:
c:\!!

:
c:\!

:
c:\

:
c:

*/

@say(fp);
return(path);
}



//;;

void
@@get_path_using_lw_tn
{
// fcd: May-12-2015
str fp = @get_path_using_lw;
@say(fp);
}



//;;

str
@get_filename_using_lw()
{
str fp = "Get path using location awareness.";

// fcd: Apr-23-2015

str path;

if(@text_is_selected)
{
  return(@get_selected_text);
}

path = @concatenate_multiple_lines;
path = @trim_leading_colons_et_al(path);

int percent_sign_position = xpos('%', path, 1);

if(percent_sign_position > 0)
{
  while(xpos('%', path, 1))
  {
    path = @resolve_environment_variable(path); 
  }
}

int path_length = length(path);

// Truncate the Clif block in order to isolate the text to the right of last colon.
while(path_length)
{
  if(str_char(path, path_length) == ':')
  {
    path = str_del(path, 1, path_length - 2);
    break;
  }
  path_length--;
}

// Now we need to strip out the filename.
path_length = length(path);

/* Use Case(s)

*/

@say(fp);
return(path);
}



//;;

int
@folder_exists(str path = parse_str('/1=', mparm_str))
{
str fp = "Folder exists.";
// fcd: Apr-24-2015
if(file_exists(path) != 2)
{
  // Folder doesn't exist.
  return(0);
}
return(1);
}



//;;

void
@folder_exists_tn
{
str fp = "";

// fcd: May-12-2015

//int folder_exists = @folder_exists('c:\!');
//int folder_exists = @folder_exists('\\fuji\shared\usr\jrj');
int folder_exists = @folder_exists('\\fuji\shared');
//:Test: \\fuji\shared\usr\jrj

@say(str(folder_exists));
}



//;;

int
@file_exists(str path = parse_str('/1=', mparm_str))
{
str fp = "File exists.";
// fcd: Apr-24-2015
if(file_exists(path) != 1)
{
  // File doesn't exist.
  return(0);
}
return(1);
}



//;;

int
@open_folder(str path = parse_str('/1=', mparm_str))
{
str fp = 'Open folder.';

str application = get_environment("windir") +  "\\explorer.exe /n, /e, ";

if(@folder_exists(path))
{
  @run_application_3p(application, path, true);
  fp += " (" + path + ")";
  @say(fp);
  return(1);
}

path = @trim_leading_colons_et_al(path);

if(@folder_exists(path))
{
  @run_application_3p(application, path, true);
  fp += " (" + path + ")";
  @say(fp);
  return(1);
}

if(@last_character(path) == '\')
{
  path = @trim_last_character(path);
}

if(@folder_exists(path))
{
  @run_application_3p(application, path, true);
  fp += " (" + path + ")";
  @say(fp);
  return(1);
}

//path = get_path(path); // This breaks network locations. May-12-2015

if(@folder_exists(path))
{
  @run_application_3p(application, path, true);
  fp += " (" + path + ")";
  @say(fp);
  return(1);
}

if(@last_character(path) == '\')
{
  path = @trim_last_character(path);
}

if(@folder_exists(path))
{
  @run_application_3p(application, path, true);
  fp += " (" + path + ")";
  @say(fp);
  return(1);
}

path = @resolve_environment_variable(path);
if(@folder_exists(path))
{
  @run_application_3p(application, path, true);
  fp += " (" + path + ")";
  @say(fp);
  return(1);
}

if(@fourth_to_last_character(path) == '.')
{
  path = get_path(path);
  if(@folder_exists(path))
  {
    @run_application_3p(application, path, true);
    fp += " (" + path + ")";
    @say(fp);
    return(1);
  }
}

if(!@folder_exists(path))
{
  // Try it anyway because the above function is not always right.
  @run_application_3p(application, path, true);
  fp += " (" + path + ")";
  return(1);

  fp += " Folder doesn't exist. (" + path + ")";
  @say(fp);
  return(0);
}

return(0);
}



//;;

void
@open_folder_tn
{
str fp = "Open folder test harness.";

// fcd: May-17-2015

// These macros work.
//@open_folder('c:\!');
//@open_folder('c:\!!');
@open_folder('%programfiles%');

//%savannah%\belfry\open_files_vaio.bat
//@open_folder('%savannah%\belfry\open_files_vaio.bat');
//@open_folder('%savannah%');

/* Use Case(s)

9.
:Temp Folder: %temp%

8.
%temp%

7.
%savannah%\belfry\open_files_vaio.bat

6.
%savannah%\belfry\

5.
%savannah%\belfry

4. Use Case on May-17-2015:
%savannah%

3.
c:\!!

2.
c:\!

1.
c:\

*/


@say(fp);
}



//;

void
@open_header_file_of_this_file
{
str fp = 'Open header file of this file.';

str path = @strip_off_filename(file_name);
str header_file_name = @filename + "h";
str full_path = path + "\\" + header_file_name;
str application = 'c:\Program Files (x86)\Multi-Edit 2008\Mew32.exe';
@run_application_2p(application, full_path);
@cursor_to_starting_point();

@say(fp);
}



//;+ Get Remotes Etc.



//;;

str
@get_remote_oj_using_klc(str lc, int &lc_Is_Found)
{
str fp = "Get remote object portion using known launch code.";
str rv = "OJ.";

@save_location;

str object_Portion;

if(!@find_lc_known(fp, lc))
{
  @recall_location;
  @footer;
  lc_Is_Found = false;
  return(" Error: LC NOT found.");
}

object_Portion = @get_multiline_object;

lc_is_found = true;

@recall_location;

return(object_Portion);
}



//;;

str
@get_remote_sj_using_klc(str lc, int &lc_Is_Found)
{
str fp = "Get remote subject portion using known launch code.";
str rv = "SJ.";

str subject_Portion;

if(!@find_lc_known(fp, lc))
{
  @recall_location;
  @footer;
  lc_Is_Found = false;
  return(" Error: LC NOT found.");
}

subject_Portion = @get_subject;

@recall_location;
lc_Is_Found = true;
return(subject_Portion);
}



//;+ HC and Gets



//;;

str
@hc_first_sentence()
{
str fp = "Highcopy first sentence.";
str rv = "Returns the first sentence.";

@eoc;
str_block_begin;

while((@current_Character != '.') and (@current_Character != '?') and (!at_eol))
{
  right; 
}

block_end;

rv = @get_selected_text;

@say(fp);
return(rv);

/* Use Case(s)

- 4. Use Case on Jan-5-2012:
- +I like big dogs? Hey now.

- 3. Use Case on Jan-5-2012:
- +I like dogs.

- 2. Use Case on Jan-5-2012:
I like dogs.

- 1. Use Case on Jan-5-2012:
Hey now Francine. I like dogs.

*/
}



//;;

str
@get_subject_or_selected_text()
{
str fp = "Get subject or selected text or whole line.";

int original_column = @current_column;
int sj_Column = 0;
str rv;

if(@text_is_selected)
{
  rv = @get_selected_text;
}
else
{
  rv = @get_sj;
}
set_global_str('cmac_return_value', rv);
// I commented out the following line on Nov-4-2013 because it was causing a flicker for 
// alt+s searches.
//@set_clipboard(rv);
goto_col(original_column);
return(rv);
}



//;;

str
@get_proper_case_text_for_cl()
{
str fp = "Get proper case text for the current line.";

str rv = @convert_line_to_proper_case;

@set_clipboard(rv);
return(rv);
}



//;;

str
@get_info_for_tortoise
{
str fp = "Get information for Tortoise.";

@header;

@save_location;

@find_lc('cj');

str rv = get_line;
rv = @trim_leading_colons_et_al(rv);
rv = @replace(rv, " (!", "");
rv = @replace(rv, "cj)", "");

@recall_location;

@footer;

@set_clipboard(rv);
return(rv);
}



//;;

str
@lp_text_intitials_date_and_tn()
{
str fp = "Load clipboard intitials, date and ticket number.";

// fcd: Apr-14-2015

@save_location;

str lc = 'cj';

if(!@find_lc_known(fp, lc))
{
  @recall_location;
  @footer;
  @say(" Error: LC NOT found. (" + lc + ")");
  return('');
}

str sj = @hc_subject;

str rv = '  // JRJ, ';
rv += @get_date_with_time;
rv += ', ';
rv += sj;
rv += '. ';

@set_clipboard(rv);

@recall_location;

@say(fp + ' (' + rv + ')');
return(rv);
}



//;;

str
@@lp_text_intitials_date_and_tn
{
@header;
return(@lp_text_intitials_date_and_tn);
@footer;
}



//;;

str
@get_official_info_x_format()
{
str fp = "Get official information in Xsl, Xml format.";
str rv = 'Return official x string.';

str rv = '<!-- ' + @lp_text_intitials_date_and_tn + ' -->';

@set_clipboard(rv);
return(rv);
}



//;+ RCC Stuff



//;;

void
@interpret_status_bar_command_ln(str &em_rp, str &lc_object, str &lc_verb, str &third_parameter, 
str user_input)
{

str fp = "Interpret status bar command line.";
str sm;

lc_verb = @get_precomma_string(user_Input, em_rp);

if(length(em_rp) > 0)
{
  sm = em_rp;
  return();
}

lc_object = @get_postcomma_string(user_Input, em_rp);

if(length(em_rp) > 0)
{
  sm = em_rp;
  return();
}

If(xpos(',', lc_object, 1))
{
  user_input = lc_object;
  lc_object = @get_precomma_string(user_input, em_rp);
  if(length(em_rp) > 0)
  {
    sm = em_rp;
    return();
  }
  third_parameter = @get_postcomma_string(user_input, em_rp);

  if(length(em_rp) > 0)
  {
    sm = em_rp;
    return();
  }

}

}



//;;

void
@interpret_status_test_caller
{
str fp = "@interpret_status_bar_command_ln test caller.";

str em_rp = '';
str lc_object;
str lc_verb;
str third_parameter;
str user_input = "one, two, three";

@interpret_status_bar_command_ln(em_rp, lc_object, lc_verb, third_parameter, user_input);

@say("third_parameter = " + third_parameter + ", user_input = " + user_input);
@say("em_rp = " + em_rp + ", lc_object = " + lc_object + ", lc_verb = " + lc_verb);
}



//;;

void
@run_clif_compositionally(str user_Input, str &sm, 
  int &show_outer_status_message, int is_repeat_call)
{
str fp = "Run Clif compositionally.";
fp = "RCC.";

int lc_Is_Found = false;
int is_Literal_CMAC_Function_Name = false;

str em_rp = '';
str expanded_verb = '';
str expanded_object = '';

str lc_verb;
str lc_object;
str third_parameter;

@interpret_status_bar_command_ln(em_rp, lc_object, lc_verb, third_parameter, user_input);

if(@first_character(lc_object) == "'")
{
  // Pass the object to the verb literally. For example, 'rm + ascii'.
  expanded_object = @trim_first_character(lc_object);
  lc_object = 'ix'; // Is eXactly?
}

if(@first_character(lc_object) == "@")
{
  // Means I want you to expand the lc_object but NOT run the CMAC macro, just show its name.
  lc_object = @trim_first_character(lc_object);
  is_Literal_CMAC_Function_Name = true;
}



// Object switch statement.     _/)       _/)      _/)
//                            ~~~~~~~~~~~~~~~~~~~~~~~~

// I put the object resolution first because nouns never execute immediately. Jan-2-2012
switch(lc_object)
{
  case 'cl':
    expanded_object = @get_current_line;
    break;
  case 'ix': // Is eXactly?
    break;
  case 'oj':
    expanded_object = @get_object;
    break;
  case 'sj':
    expanded_object = @get_subject;
    break;
  default:
    switch(lc_verb)
    {
      // This list of case statements represent those lc_verbs that want to use the object
      // portion over the subject portion of the line in question. Feb-4-2014
      case 'ato':
      case 'fx':
      case 'ie':
      case 'kr':
      case 'me':
      case 'si':
      case 'lo':
      case 'smo':
        expanded_object = @get_remote_oj_using_klc(lc_object, lc_Is_Found);
        break;
      default:
        expanded_object = @get_remote_sj_using_klc(lc_object, lc_Is_Found);
    }
    if(third_parameter != '')
    {
      expanded_object = @get_remote_sj_using_klc(lc_object, lc_Is_Found);
    }
    if(!lc_Is_Found)
    {
      sm = fp + ' ' + expanded_object + ' (Object)';
      return();
    }
    // Double quote character.
    expanded_object = @resolve_environment_variable(expanded_object);
    break;
}

if((!is_Literal_CMAC_Function_Name) and (@first_character(expanded_object) == '@'))
{
  fp += ' Run the CMAC.';
  // Use the output from the CMAC object.
  rm(expanded_object);
  expanded_object = global_str('cmac_return_value');
}

sm = fp + ' (' + lc_verb + ', ' + lc_object + ')';



// Verb switch statement.    _/)       _/)      _/)
//                          ~~~~~~~~~~~~~~~~~~~~~~~~

switch(lc_verb)
{
  case '1':
  case '15':
  case '1w':
  case '2':
  case '3':
  case '3w':
  case '4':
  case '4w':
  case '5':
  case '55':
  case '5w':
  case '6':
  case '7':
  case '75':
  case '75w':
  case '7w':
  case '8':
  case '8w':
  case 'a1':
  case 'a2':
  case 'a3':
  case 'a35':
  case 'a4':
  case 'a5':
  case 'a6':
  case 'a7':
  case 'a75':
  case 'a8':
  case 'ar':
  case 'ara':
  case 'arb':
  case 'asb':
  case 'asr':
  case 'c1':
  case 'c2':
  case 'c3':
  case 'c4':
  case 'c5':
  case 'c55':
  case 'c6':
  case 'c7':
  case 'c75':
  case 'c75w':
  case 'c7w':
  case 'c8':
  case 'c8w':
  case 'f':
  case 'g3':
  case 'g35':
  case 'g4':
  case 'g7':
  case 'g75':
  case 'g8':
  case 'l':
                        // LC is a location pass-through. (!palc, !lopa)
  case 'lo':
  case 'ls':
  case 'm1':
  case 'm15':
  case 'm1w':
  case 'm2':
  case 'm3':
  case 'm3w':
  case 'm4':
  case 'm4w':
  case 'm5':
  case 'm55':
  case 'm5w':
  case 'm6':
  case 'm7':
  case 'm75':
  case 'm75w':
  case 'm7w':
  case 'm8':
  case 'm8w':
  case 'ts':
  case 'loj':
    // In this sense lc is used as a location, rather than as an action tool.
    expanded_verb = @get_remote_oj_using_klc(lc_verb, lc_Is_Found);
    if(third_parameter == '')
    {
      rm(expanded_verb + ' /1=' + lc_object);
    }
    else
    {
      rm(expanded_verb + ' /1=' + lc_object + '/2=' + third_parameter); 
    }
    show_outer_status_message = false;
    return();
    break;
  default:
    expanded_verb = @get_remote_oj_using_klc(lc_verb, lc_Is_Found);
    if(!lc_Is_Found)
    {
      sm = fp + expanded_verb + ' (Verb)';
      return();
    }
    expanded_verb = @resolve_environment_variable(expanded_verb);
    expanded_verb = @trim_before_character(expanded_verb, '"');
    if(@left(expanded_verb, 2) == '/R')
    {
      expanded_verb = @trim_left(expanded_verb, 2);
    }
    break;
}
if(expanded_verb == '')
{
  fp += ' Error: Expanded verb is blank. Exit.';
  sm = fp;
  return();
}
if(@left(expanded_verb, 1) == '@')
{
  fp += ' CMAC function Verb pass-through.';
  rm(expanded_verb + ' /1=' + expanded_object);
  sm = expanded_verb + ' (' + expanded_object + ')';
  show_outer_status_message = false;
  return();
}
@run_application_2p(expanded_verb, expanded_object);
}



//;;

void
@run_location_passthrough(str user_Input, str &sm, int &show_outer_status_message, int 
is_repeat_call, int &return_home) 
{ 
str fp = "Run Clif compositionally.";

fp = "RCC.";

int lc_Is_Found = false;
int is_Literal_CMAC_Function_Name = false;

str em_rp = '';
str expanded_verb = '';
str expanded_object = '';

str lc_verb;
str lc_object;
str third_parameter;

@interpret_status_bar_command_ln(em_rp, lc_object, lc_verb, third_parameter, user_input);

if(@first_character(lc_object) == "'")
{
  // Pass the object to the verb literally. For example, 'rm + ascii'.
  expanded_object = @trim_first_character(lc_object);
  lc_object = 'ix'; // Is eXactly?
}

if(@first_character(lc_object) == "@")
{
  // Means I want you to expand the lc_object but NOT run the CMAC macro, just show its name.
  lc_object = @trim_first_character(lc_object);
  is_Literal_CMAC_Function_Name = true;
}



// Object switch statement.     _/)       _/)      _/)
//                            ~~~~~~~~~~~~~~~~~~~~~~~~

// I put the object resolution first because nouns never execute immediately. Jan-2-2012
switch(lc_object)
{
  case 'cl':
    expanded_object = @get_current_line;
    break;
  case 'ix': // Is eXactly?
    break;
  case 'oj':
    expanded_object = @get_object;
    break;
  case 'sj':
    expanded_object = @get_subject;
    break;
  default:
    switch(lc_verb)
    {
      // This list of case statements represent those lc_verbs that want to use the object
      // portion over the subject portion of the line in question. Feb-4-2014
      case 'ato':
      case 'fx':
      case 'ie':
      case 'kr':
      case 'me':
      case 'si':
      case 'lo':
      case 'smo':
        expanded_object = @get_remote_oj_using_klc(lc_object, lc_Is_Found);
        break;
      default:
        expanded_object = @get_remote_sj_using_klc(lc_object, lc_Is_Found);
    }
    if(third_parameter != '')
    {
      expanded_object = @get_remote_sj_using_klc(lc_object, lc_Is_Found);
    }
    if(!lc_Is_Found)
    {
      sm = fp + ' ' + expanded_object + ' (Object)';
      return();
    }
    // Double quote character.
    expanded_object = @resolve_environment_variable(expanded_object);
    break;
}

if((!is_Literal_CMAC_Function_Name) and (@first_character(expanded_object) == '@'))
{
  fp += ' Run the CMAC.';
  // Use the output from the CMAC object.
  rm(expanded_object);
  expanded_object = global_str('cmac_return_value');
}

sm = fp + ' (' + lc_verb + ', ' + lc_object + ')';

// LC is a location pass-through. (!palc, !lopa)

return_home = false;
if(lc_verb == 'ts')
{
// a8
}

expanded_verb = @get_remote_oj_using_klc(lc_verb, lc_Is_Found);
if(third_parameter == '')
{
  rm(expanded_verb + ' /1=' + lc_object);
}
else
{
  rm(expanded_verb + ' /1=' + lc_object + '/2=' + third_parameter); 
}
show_outer_status_message = false;
}



//;

int
@is_paste_before_in_same_window()
{
str fp = "Is paste before in same window edge case.";

// fcd: Oct-19-2016

int source_line = global_int('initial row number');
int source_window = global_int('initial window number');

int destination_line = @current_line;
int destination_window = @current_window;

if((destination_line < source_line) and (source_window == destination_window))
{
  return(1);
}

@say(fp + ' (false)');
return(0);
}



//; (skw the gun, bullet gun)

void
@gun(int return_home = parse_int('/1=', mparm_str))
{
str fp = "If something shoots bullets, then it's a gun. Get it?";

fp = 'Move bullet to lc.';

if(!@is_bullet_File)
{
  return();
}

if(!@is_bullet_or_subbullet)
{
  return();
}

int initial_column = @current_column;

@bob;
@save_location;

// I moved this check above the others because of monthly itinerary items that also
// have launch codes on their line. Jun-2-2014
if(@first_5_characters_is_month)
{
  @move_bullet_to_calendar(return_home);
  return();
}

if(@current_line_contains_regex(@comma_lc))
{
  @move_bullet_to_appropriate_lc(return_home);
  return();
}

int initial_window = cur_window;
int search_criterion_was_found;
str lc = 'jd';

int source_lc_is_found = false;

str looked_up_rubrics_lc = @look_up_rubrics_source_lc(source_lc_is_found);

int current_line_number = 0;

if(return_home == 1)
{
  mark_pos;
}

@cut_bullet;

if(source_lc_is_found)
{
  lc = 'dest' + looked_up_rubrics_lc;
}

if(@filename == 'ne.asc')
{
  if(lc == 'destjd')
  {
    lc = 'jd';
  }
  else if(lc == 'destcj')
  {
    // Is this supposed to be blank? Feb-27-2014
  }
  else
  {
    lc = 'co';
  }
}

if(lc == 'destcj')
{
  lc = 'cj';
  if(!@find_lc(lc))
  {
    lc = 'rfco';
  }
}

@find_lc(lc);

if(!@find_lc_known(fp, lc))
{
  switch_window(Initial_Window);
  rm('paste');
  fp += ' Error: Lc NOT found. (' + lc + ')';
  @say(fp);
  return();
}

@paste_after;

if(return_home == 1)
{
  if(@is_paste_before_in_same_window)
  {
    @recall_location_2;
  }
  else
  {
    @recall_location;
  }
  goto_col(initial_column);
}

if(@is_blank_line)
{
  @put_cursor_somewhere_useful;
}

fp += ' (' + lc + ')';
@say(fp);
}



//;;

void
@@gun(int return_home = parse_int('/1=', mparm_str))
{
@header;
@gun(return_home);
@footer;
}



//;

void
@run_batch_file_with_parameter(str application, str argument);
{
str fp = "Run batch file with parameter.";
fp = "Dec-21-2016 3:43 PM";

// fcd: Dec-21-2016

//@say(lowercased_clif_block);
}



//;+ Anatomizing



//;;

str
@get_presecondperiod_string(str parameter)
{
str fp = 'Get presecondperiod string.';

str preperiod_string = '';
int loop_Counter = 1;
int length_of_string = length(parameter);

while(loop_counter <= length_of_string)
{
  if(str_char(parameter, loop_Counter) != ".")
  {
    preperiod_string += str_char(parameter, loop_Counter);
  }
  else
  {
    break;
  }
  loop_Counter ++;
}

return(preperiod_string);
}



//;;

void
@open_folder_lw(str lc = parse_str('/1=', mparm_str))
{
str fp = "Open folder using location awareness.";

// fcd: Apr-24-2015

int lc_is_found = false;

if(lc != '')
{
  lc = @get_presecondperiod_string(lc);
  @save_location;
  if(@find_lc_known(fp, lc))
  {
    lc_is_found = true;
  }
}

str path = @get_path_using_lw;

if(lc_is_found)
{
  @recall_location;
}

if(@open_folder(path) == 0)
{
  fp += " Folder doesn't exist. (" + path + ")";
} 
//@say(fp);
}



//;;

int
@multiedit(str path = parse_str('/1=', mparm_str))
{
str fp = 'Multiedit.';

str application = "c:\\program files (x86)\\multi-edit 2008\\mew32.exe ";

if(@file_exists(path))
{
  @run_application_3p(application, path, false);
  fp += " (" + path + ")";
  @say(fp);
  return(1);
}

path = @trim_leading_colons_et_al(path);

if(@folder_exists(path))
{
  @run_application_3p(application, path, true);
  fp += " (" + path + ")";
  @say(fp);
  return(1);
}

if(@last_character(path) == '\')
{
  path = @trim_last_character(path);
}

if(@folder_exists(path))
{
  @run_application_3p(application, path, true);
  fp += " (" + path + ")";
  @say(fp);
  return(1);
}

path = get_path(path);

if(@folder_exists(path))
{
  @run_application_3p(application, path, true);
  fp += " (" + path + ")";
  @say(fp);
  return(1);
}

if(@last_character(path) == '\')
{
  path = @trim_last_character(path);
}

if(@folder_exists(path))
{
  @run_application_3p(application, path, true);
  fp += " (" + path + ")";
  @say(fp);
  return(1);
}

if(!@folder_exists(path))
{
  fp += " Folder doesn't exist. (" + path + ")";
  @say(fp);
  return(0);
}

if(xpos('"', path, 1))
{
  //path = @trim_before_character(path, '"');
}

return(1);
}



//;;

void
@multiedit_lw(str lc = parse_str('/1=', mparm_str))
{
str fp = "Multiedit using location awareness.";

// fcd: Apr-30-2015

int lc_is_found = false;

if(lc != '')
{
  lc = @get_presecondperiod_string(lc);
  @save_location;
  if(@find_lc_known(fp, lc))
  {
    lc_is_found = true;
  }
}

str path = @get_filename_using_lw;

if(@multiedit(path) == 0)
{
  fp += " File doesn't exist. (" + path + ")";
}

if(lc_is_found)
{
  @recall_location;
}

@say(fp);
}



//;;

str
@get_line()
{
str fp = "Get line.";

// fcd: Aug-7-2015

str current_line;
current_line = @trim_colons(get_line);
current_line = @resolve_environment_variable(current_line);

@say(fp);
return(current_line);
}



//;;

str
@get_reserved_word(str sc = parse_str('/1=', mparm_str))
{
str fp = 'Get reserved word.';

str reserved_word_definition;

@save_location;

switch(sc)
{
  case "cj":
    if(!@find_lc_known(fp, sc))
    {
      @recall_location;
      @say(" Error: LC NOT found. (" + sc + ")");
      return(" Error: LC NOT found. (" + sc + ")");
    }
    reserved_word_definition = @hc_subject;
    break;
  case "cl":
    reserved_word_definition = @get_line;
    break;
  case "clq": // Current line - no quotes.
    reserved_word_definition = @get_line;
    reserved_word_definition = @trim_first_character(reserved_word_definition);
    reserved_word_definition = @trim_last_character(reserved_word_definition);
    break;
  case "clp": // Current line - path only.
    // (!rw, !rv) Reserved Words
    reserved_word_definition = @get_line;
    reserved_word_definition = get_path(reserved_word_definition);
    break;
  case "mj":
    reserved_word_definition = @get_multiline_object;
    break;
  case "nl": // Next line (!rewo, !nl)
    down;
    reserved_word_definition = @get_line;
    reserved_word_definition = @trim_leading_colons_et_al(reserved_word_definition);
    break;
  case "nlp": // Next line - path only.
    down;
    reserved_word_definition = @get_line;
    reserved_word_definition = get_path(reserved_word_definition);
    break;
  case "o":
    // This is the funky part. Aug-20-2015
    // See glossary at &lpg.
  case "oj":
    reserved_word_definition = @resolve_environment_variable(@get_object);
    break;
  case "s":
  case "sj":
    reserved_word_definition = @get_subject;
    break;
  case "st": // This has an age-old problem.
    reserved_word_definition = '"' + @get_selected_text + '"';
    reserved_word_definition = @get_selected_text;
    break;
  case "tf":
    reserved_word_definition = file_name;
    break;
  case "uc":
    reserved_word_definition = @hc_word_uc;
    break;
  default:
    return('');
}

@recall_location;
return(reserved_word_definition);
}



//;;

void
@open_folder_router(str action = parse_str('/1=', mparm_str))
{
str fp = "Open folder router.";

// fcd: Apr-28-2015

str reserved_word_string = @get_reserved_word(action);

if(reserved_word_string == '')
{
  @open_folder_lw(action);
}
else
{
  @open_folder(reserved_word_string);
}
}



//;;

void
@multiedit_router(str action = parse_str('/1=', mparm_str))
{
str fp = "Multi-Edit router.";

// fcd: Apr-28-2015

str reserved_word_string = @get_reserved_word(action);

if(reserved_word_string == '')
{
  @multiedit_lw(action);
}
else
{
  @multiedit(reserved_word_string);
}
}



//;; (!anat)

int
@anatomize_clif(int desired_action, str &status_message_rp)
{
str fp = 'Parse clif block.';

/* Return Values

6 = non-executable clif.

*/

int column_Number;
int error_Code;

str application;
str application_Plus_Argument;
str argument;
str clif_Block;
str uRL;

if(@text_is_selected)
{
  clif_Block = @get_selected_text;
}
else
{
  clif_Block = @concatenate_multiple_lines;
  clif_Block = @trim_leading_colons_et_al(clif_Block);
}

// I probably need to refactor this to say if "%" occurs BEFORE http, than only modify that
// portion of the clif_Block.

int http_Position = xpos('http', clif_Block, 1);

int percent_sign_position = xpos('%', clif_block, 1);

if(percent_sign_position > 0)
{
  if(http_Position > 0)
  {
    if(http_Position > percent_Sign_Position)
    {
      while(xpos('%', clif_Block, 1))
      {
        clif_Block = @resolve_environment_variable(clif_Block); 
      }
    }
  }
  else
  {
    while(xpos('%', clif_Block, 1))
    {
      clif_Block = @resolve_environment_variable(clif_Block); 
    }
  }
}

/* Encoding/Decoding Use Cases - Oct-13-2011

- #2: This Clif has both a uRL AND an environment variable: (See !+Out).

- #1: This uRL should be passed to Amazon directly. if decode the uRL, the browser simply needs 
then encode it.

- http://www.amazon.com/s/qid=1318517089/ref=sr_pg_8?ie=UTF8&sort=titlerank&keywords=Pet%20Shop

*/

column_Number = length(clif_Block);

// This switch statement is used to transform the action line based on the incoming argument.
switch(desired_action)
{
  case 3: // Edit File in ME, for both cases of "here" and "remotely". ******************
    // This block searches for the rightmost colon in the Clif Block, then chops off
    // everything 2 spaces before it until the beginning of the line.
    while(column_Number)
    {
      if(str_char(clif_Block, column_Number) == ':')
      {
        argument = str_del(clif_Block, 1, column_Number - 2);
        break;
      }
      Column_Number--;
    }

    if(xpos(' ', argument, 1))
    {
      argument = char(34) + argument + char(34);
    }

    // ME_Path = Multi-Edit's Default Installation Folder
    application = ME_Path + 'Mew32.exe';

    if(xpos(' ', application, 1))
    {
      application = char(34) + application + char(34);
    }

    ExecProg(application + ' ' + argument,
      Get_Environment("TEMP"),
      Get_Environment("TEMP") + '\\multi-edit output.txt',
      Get_Environment("TEMP") + '\\multi-edit error.txt',
      _EP_FLAGS_DONTWAIT | _EP_Flags_ExeAuto);

    return(0);
}

str Lowercased_clif_Block = lower(clif_Block);

/*
This is the interpreter that figures out what we are going to do on the action line, i.e. the 
heart of the Clif engine. lk#2
*/

int is_exe_or_bat_file = false; // Feb-4-2015
if(xpos('.exe', lowercased_clif_block, 1)) // Application ********************************
{
  is_exe_or_bat_file = true;
}
if(xpos('.cmd', lowercased_clif_block, 1)) // Visual Studio Code *************************
{
  is_exe_or_bat_file = true;
}

// This allows a batch file to work with a parameter. Feb-5-2015
if(xpos('.bat', lowercased_clif_Block, 1)) // Batch File with a parameter ****************
{
  is_exe_or_bat_file = true;
}

if(is_exe_or_bat_file)
{
  int Position_of_Double_Quote = xpos(char(34), clif_Block, 1);

  application = str_del(clif_Block, Position_of_Double_Quote, 400);

  int Pos_of_First_Colon_Backslash = xpos(':\', clif_Block, 1);
  if(Pos_of_First_Colon_Backslash == 0)
  {
    // This for the case of executables that live on the network.
    pos_of_first_colon_backslash = xpos('\\', clif_block, 1);

    /* Use Case(s)
      Use Case Jun-1-2009: Executable on the network: \\pxad\COTS\Utilities\daemon400.exe
    */
    application = str_del(application, 1, Pos_of_First_Colon_Backslash - 1);
  }
  else
  {
    application = str_del(application, 1, Pos_of_First_Colon_Backslash - 2);
  }

  str quoteless_application = application;

  if(xpos(' ', application, 1))
  {
    application = char(34) + application + char(34);
  }

  if(position_of_double_quote == 0) // application without argument *********************
  {
    if(xpos('.bat', quoteless_application, 1))
    {
      @run_this_executable_file(quoteless_application);
      return(1);
    }
    status_message_rp = 'Run application: ' + application;

    ExecProg(application,
      Get_Environment("TEMP"),
      Get_Environment("TEMP") + '\\multi-edit output.txt',
      Get_Environment("TEMP") + '\\multi-edit error.txt',
      _EP_Flags_DontWait | _EP_Flags_ExeWin);

    /*
    On Mar-25-2008 I deleted the "run-in-background" flag so that the calculator program
    would not run in the foreground.
                    _EP_FLAGS_DONTWAIT | _EP_Flags_ExeWin | _EP_Flags_RunBkg);
    */
  }
  else // application WITH argument ******************************************************
  {
    argument = str_del(clif_block, 1, position_of_double_quote);

    status_message_rp = 'Run app with arg: ' + argument;

    int Flag = _EP_Flags_RunBkg;

    If(xpos('http', Lowercased_clif_Block, 1)) // Fully Qualified Link *********************
    {
      int Position_of_HTTP = xpos('http', clif_Block, 1) - 1;
      argument = str_del(clif_Block, 1, Position_of_HTTP);
      status_message_rp = 'Using a specific brower, surf to: ' + argument;
    }
    else if(xpos('.htm', Lowercased_clif_Block, 1)) // Penchant.htm, for example. ***********
    { 
      // I commented this block out on Aug-13-2012 because it was messing up
      // the edit in Multi-Edit functionality.
      //      argument = @commute_character(argument, '\', '/');
      //      argument = @commute_character(argument, '"', '');
      //      argument = 'file:///' + argument;
      //      status_message_rp = 'Using a specific browser, surf to LOCAL file: ' + argument;
    }

    // We need the double quotes wrapped around filenames that contain spaces.
    if(xpos(' ', argument, 1))
    {
      argument = char(34) + argument + char(34);
    }

    application_plus_argument = application + ' ' + argument;

    // This allows a batch file to work with a parameter. Feb-5-2015
    if(xpos('.bat', lowercased_clif_block, 1))
    {
      if(xpos('"', lowercased_clif_block, 1)) // Has a parameter.
      {
        is_exe_or_bat_file = true;
        int position_of_double_quote = xpos('"', lowercased_clif_block, 1);
        int position_of_dot_bat = xpos('.bat', lowercased_clif_block, 1);
        if(position_of_dot_bat < position_of_double_quote)
        {
          // Then we know we are dealing with a batch with a parameter.
          // I tried to make this work but it conficts with "Edit" batch file say. 
          // It's too much spaghetti code. Dec-21-2016
          @run_batch_file_with_parameter(application, argument);
        }
      }
    }

    ExecProg(application_Plus_Argument,
      Get_Environment("TEMP"),
      Get_Environment("TEMP") + '\\multi-edit output.txt',
      Get_Environment("TEMP") + '\\multi-edit error.txt',
      Flag);
  }
}
else If(xpos('http', Lowercased_clif_Block, 1)) // Open Link Using Default application ******
{
  int Position_of_HTTP = xpos('http', clif_Block, 1) - 1;
  uRL = str_del(clif_Block, 1, Position_of_HTTP);
  status_message_rp = 'Surf to: ' + uRL;
  @surf(uRL, 0);
}
// Character 92 is the backslash.
else if(xpos(char(92), clif_Block, 1)) // Open a Folder or File *****************************
{
  int position_of_backslash = xpos('\', clif_block, 1) - 1;
  // Double backslash.
  if(xpos(char(92) + char(92), clif_Block, 1)) // Network Locations *************************
  {
    clif_block = str_del(clif_block, 1, position_of_backslash);
    status_message_rp = 'Open a network folder. (' + clif_block + ')';
  }
  else // Local File Locations, e.g. C and E drives. ****************************************
  {
    clif_block = str_del(clif_block, 1, position_of_backslash - 2);
    status_message_rp += ' Open local fd.';
    str display_Path = clif_Block;
    int length_of_string = @length(display_Path);
    if(length_of_string > 34)
    {
      length_of_string = 34;
      display_Path = "..." + @right(display_Path, length_of_string);
    }
    else
    {
      display_Path = @right(display_Path, length_of_string);
    }
    status_message_rp += ' (' + display_Path + ')';
  }

  if(File_Exists(clif_Block) == 1)
  {
    status_message_rp = 'Run file assoc: ' + clif_Block;
    switch(lower(Get_Extension(clif_Block))) // Executable Files *****************
    {
      case 'bat':
      case 'ps1':
      case 'sql':
        @run_this_executable_File(clif_Block);
        break;
      default:
        // This is useful for opening files with defined file open associations.
        error_Code = ShellExecute(0, "Open", clif_Block, "", "", 0); //qcq
    }
  }
  else
  {
    // Validate the folder path where there is NO file extension present.
    if(length(get_extension(clif_Block)) == 0)
    {
      Change_Dir(clif_Block);
      // For some reason "\\pxad" returns Error_Level 123, which doesn't cause
      // an error for Windows Explorer, so this bit of logic allows it to pass through.
      if ((Error_Level != 0) and (Error_Level != 123))
      {
        @say(status_message_rp += ". NOT found.");
        Error_Level = 0;
        return(1);
      }
    }
    // Validate the folder path where there is a file extension present.
    else
    {
      Change_Dir(Get_Path(clif_Block));
      if (Error_Level != 0)
      {
        status_message_rp += ' NOT found (Site 6).';
        Error_Level = 0;
        return(1);
      }
    }
    // Mar-4-2013. I added the double backslash.
    @open_folder(clif_Block + "\\");
  }
}
else if(xpos('@', lowercased_Clif_Block, 1)) // Naked CMAC Macro *************************
{
  // ME_Path = Multi-Edit's Default Installation Folder
  application = ME_Path + 'Mew32.exe';
  argument = lowercased_Clif_Block;
  argument = @trim_before_character(argument, '@');
  argument = '/R@' + argument;
  @run_application_2p(application, argument);
  status_message_rp += ' Run naked CMAC macro.';
  //  status_message_rp = ' ' + lowercased_Clif_Block;
}
else // Non-executable Location in Open Files ********************************************
{
  status_message_rp += ' The current line is not an executable Clif.';
  return(6);
}
return(0);
}



//;;

void
@edit_file_remotely
{
str fp = "Edit file remotely.";

@header;

@save_location;

str lc = @get_user_input_nonspace(fp);
str distilled_lc = @distill_lc(lc);
if(!@find_lc_known(fp, lc))
{
  if(lc == 'Function aborted.')
  {
    @say(lc);
  }
  return();
}

if(@is_bullet_file)
{
  // This block means that I don't have to be on the top line of a clif in order to
  // execute it properly.
  if((@first_character(get_line) != ';') && (@first_character(get_line) != ':'))
  {
    @bobsr; //qcq
  }
}

@anatomize_clif(3, fp);

@recall_location;

fp = @trim_period(fp) + ' "' + Distilled_lc + '".';

@footer;

@say(fp);
}



//;;

void
@edit_file_uc()
{
str fp = "Edit file under cursor (using Multi-Edit).";
@anatomize_clif(3, fp);
@say(fp);
}



//;;

void
@anatomize_current_line()
{
str fp = "Anatomize current line.";
@anatomize_clif(0, fp);
@say(fp);
}



//;;

void
@open_folder_uc_or_cl
{
str fp = 'Open folder under cursor or current line.';

str current_line = get_line;
current_line = @trim_leading_colons_et_al(current_line);
@open_folder(current_line);

/*

Use Case 2: Mar-13-2015

:c:\a\j.txt

Use Case 4: Mar-13-2015

:c:\!

*/

}



//;;

void
@open_folder_this_file
{
str fp = 'Open containing folder (where this file lives) of the current window.';
/* skw
open folder of the currently loaded file
open folder current file
*/
@open_folder(get_path(file_name));
@say(fp);
}



//;;

void
@open_folder_in_dos()
{
str fp = 'Open folder under cursor in a command prompt.';
str Command_String = 'c:\windows\system32\cmd.exe /k ';
str Set_My_Path = "%savannah%\\belfry\\set_my_path.bat";

set_my_path = char(34) + @resolve_environment_variable(set_my_path) + char(34);

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
    @recall_location;
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
  fp += ' NOT found (site 7).';
  Error_Level = 0;
  @say(fp + ' - ' + Clif_Block);
  @footer;
  return();
}

fp += ' ' + Clif_Block;

str test = '';

@say(fp);

ExecProg(Command_String,
  Clif_Block,
  Get_Environment("TEMP") + '\\multi-edit output.txt',
  Get_Environment("TEMP") + '\\multi-edit error.txt',
  _EP_FLAGS_DONTWAIT | _EP_FLAGS_EXEWIN);

}



//;;

void
@open_folder_in_dos_remotely
{
str fp = 'Open folder in DOS remotely.';
@header;

@save_location;

if(!@find_lc_ui(fp))
{
  @footer;
  return();
}

@open_folder_in_dos;

@recall_location;

@footer;
@say(fp);
}



//;;

void
@open_folder_in_dos_remotely_2(str lc = parse_str('/1=', mparm_str))
{
str fp = 'Open folder in DOS remotely 2.';
@header;

@save_location;

@find_lc(lc);

@open_folder_in_dos;

@recall_location;

@footer;
@say(fp);
}



//;;

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



//;;

void
@open_folder_remotely(str sc = parse_str('/1=', mparm_str))
{
str fp = "Open folder remotely.";

@header;

@save_location;

if(sc != '')
{
  @find_lc(sc);
}
else if(!@find_lc_ui(fp))
{
  @footer;
  return();
}

@open_folder_lw('');

@recall_location;

@footer;

@say(fp);
}



//;+ Do Indicated Stuff



//;;

str
@get_indicated_lc_3()
{
str fp = "Get indicated lc 3.";

// fcd: May-13-2014

str indicated_lc;

int position_of_triple_comma = xpos(',,,', get_line, 1);

goto_col(position_of_triple_comma + 2);

while(!at_eol)
{
  indicated_lc += @current_character; 
  right;
}

/* Use Case(s)

Use Case on May-13-2014:

:Noble Hustle !+a

:Noble Hustle !+au

:Noble Hustle ,,a

:Miguel De Icaza ,,gi

*/

return(indicated_lc);
}



//;;

str
@get_indicated_lc()
{
str fp = "Get indicated lc.";

// fcd: May-13-2014

str indicated_lc;

int position_of_double_comma = xpos(',,', get_line, 1);

goto_col(position_of_double_comma + 2);

while(!at_eol)
{
  indicated_lc += @current_character; 
  right;
}

/* Use Case(s)

Use Case on May-13-2014:

:Noble Hustle !+a

:Noble Hustle !+au

:Noble Hustle ,,a

:Miguel De Icaza ,,gi

*/

return(indicated_lc);
}



//;;

void
@perform_indicated_action()
{
str fp = "Perform indicated action.";

// fcd: May-13-2014

str user_input = @get_indicated_lc + ',' + 'sj';

int return_home = 1;
int show_outer_status_message = 1;
int is_repeat_call = 0;

int return_home = true;

//@run_location_passthrough(user_Input, fp, show_outer_status_message, 0, return_home);
@run_clif_compositionally(user_Input, fp, show_outer_status_message, 0);

@say(fp);
}



//;+ Run Clifs



//;;

int
@run_clif_under_cursor(str &operation_Outcome)
{
str fp = "Run cl uc.";

int rv;

if(@text_is_selected)
{
  @save_highlighted_text;
  rv = @anatomize_clif(0, fp);
  @load_highlighted_text;
  @say(fp);
  return(rv);
}

if(@is_bullet_file)
{
  // This block means that I don't have to be on the top line of a clif in order to
  // execute it properly.
  if((@first_character(get_line) != ';') && (@first_character(get_line) != ':'))
  {
    mark_pos;
    @boca; //qcq
    rv = @anatomize_clif(0, fp);
    goto_mark;
    @say(fp);
    if(@trim(fp) == '')
    {
      @say('branch here.');
    }
    return(rv);
  }
}
rv = @anatomize_clif(0, fp);

operation_Outcome = fp;

//@say(fp);
//qjq-1

return(rv);
}



//;;

void
@run_clif_internally(str lc)
{

str fp = 'Run Clif for internal uses. Notice the absence of the "header" and "footer" in this 
method.';

@save_location;

if(!@find_lc_known(fp, lc))
{
  return();
}

str Operation_Outcome;
@run_clif_under_cursor(Operation_Outcome);

@recall_location;
}



//;;

void
@copy_subject_to_clip_and_run_lc()
{
str fp = "Copy the subject to the clipboard and run the given lc.";

// fcd: May-13-2014

@save_location;

str sj = @get_subject;
@set_clipboard(sj);

@recall_location;

str lc = @get_indicated_lc_3;

lc = @trim_first_character(lc);

@run_clif_internally(lc);

@say(fp + ' (' + lc + ')');
}



//;;

int
@is_reserved_word(str sc = parse_str('/1=', mparm_str))
{
str fp = 'Is reserved word.';

switch(sc)
{
  case "cj":
  case "oj":
  case "sj":
  case "uc":
    break;
  default:
    @say('Not a reserved word.');
    return(0);
}
return(1);
}



//;;

void
@search_jira(str sc = parse_str('/1=', mparm_str), int is_print_mode = parse_int('/2=', mparm_str)) 
{

str fp = 'Search Jira.';

str URL = "http://kili:8080/browse/";

str reserved_word_definition = '';

if(@is_reserved_word(sc))
{
  reserved_word_definition = @get_reserved_word(sc);
  sc = reserved_word_definition;
}

if(sc == '')
{
  sc = @get_subject_or_selected_text;
}

str Pretty_sc = sc;

if(@contains(sc, 'MT-'))
{
  URL += sc;
}
else if(@contains(sc, 'DATA-'))
{
  URL += sc;
}
else if(@contains(sc, 'TNG-'))
{
  URL += sc;
}
else
{
  Pretty_sc = "All Tickets Sorted By Newest First";
  @set_clipboard('MT-2581');
  URL = "http://kili:8080/secure/IssueNavigator.jspa?mode=hide&requestId=10151";
}

sc = @commute_character(sc, ' ', '+');

if(is_print_mode)
{
  url = 'http://kili:8080/si/jira.issueviews:issue-html/' + sc + '/' + sc + '.html';
  @surf(url, 3);
}
else
{
  @surf(url, 1);
}

/* Use Case(s)

MT-4436

*/

str status_Message = @trim_period(fp) + ' for "' + Pretty_sc + '".';
Set_Global_Str('inner_status_message', status_Message);
@say(status_Message);
}



//;;

void
@open_jira_topic_for_printing
{
str fp = "Open Jira topic in print mode.";

@search_jira('', 1);

@say(fp);
}



//;;

void
@search_jira_with_cj
{
str fp = "Search Jira with CJ.";

// fcd: May-8-2015

@header;
@save_location;
@find_lc('cj');
@search_jira('', 0);
@recall_location;
@footer;

@say(fp);
}



//;;

void
@search_jira_for_printing(str sc = parse_str('/1=', mparm_str))
{

str fp = 'Search Jira for printing.';

str URL = "http://kili:8080/browse/";

if(sc == '')
{
  sc = @get_subject_or_selected_text;
}

str Pretty_sc = sc;

if(@contains(sc, 'MT-'))
{
  URL += sc;
}
else if(@contains(sc, 'DATA-'))
{
  URL += sc;
}
else
{
  Pretty_sc = "All Tickets Sorted By Newest First";
  @set_clipboard('MT-2247');
  URL = "http://kili:8087/secure/IssueNavigator.jspa?mode=hide&requestId=10151";
}

sc = @commute_character(sc, ' ', '+');

@surf(url, 4);

/* Use Case(s)

MT-4436

*/

str status_Message = @trim_period(fp) + ' for "' + Pretty_sc + '".';
Set_Global_Str('inner_status_message', status_Message);
@say(status_Message);
}



//;; Acting as opposed to thinking.

void
@execute_code_word_line()
{
str fp = 'Execute cwl.';

// (skw triple comma, triple_comma)
if(@current_line_contains(',,,'))
{
  @copy_subject_to_clip_and_run_lc;
  return();
}

// (skw double comma, double_comma)
if(@current_line_contains(',,'))
{
  @perform_indicated_action;
  return();
}

if(@current_line_contains('^'))
{
  str lc = @get_indicated_lc_2;
  @run_clif_internally(lc);
  return();
}

if(@current_line_contains(' &'))
{
  str lc = @get_indicated_lc_2;
  @save_location;
  @find_lc(lc);
  return();
}

if(@current_line_contains_regex(@comma_lc))
{
  @move_bullet_to_appropriate_lc(true);
  return();
}

str sc = @get_subject_or_selected_text;
if(@contains(sc, 'MT-'))
{
  @search_jira('', 0);
  return();
}
else if(@contains(sc, 'DATA-'))
{
  @search_jira('', 0);
  return();
}
else if(@contains(sc, 'TNG-'))
{
  @search_jira('', 0);
  return();
}

str Operation_Outcome;
@run_clif_under_cursor(Operation_Outcome);

if(@contains(operation_outcome, 'not an executable'))
{
  if(@first_5_characters_is_month)
  {
    @move_bullet_to_calendar(1);
  }
  else
  {
    // (!setr2)
    @search_google_liberally(''); 
  }
  return();
}

//@say(fp + ' ' + Operation_Outcome);
//qjq-1
}



//;;

void
@@execute_code_word_line
{
@header;
@execute_code_word_line;
@footer;
}



//;; (skw Redial, Repeat_Clif, Repeat Clif)

void
@repeat_command
{
str fp = 'Repeat Clif command.';

@header;

str Distilled_lc = @distill_lc(Global_Str('lc'));

@run_clif_internally(Global_Str('lc'));

@footer;

@say(fp + ': ' + Distilled_lc);
}



//;;

void
@@run_clif_under_cursor
{
@header;
str Operation_Outcome = '';
@run_clif_under_cursor(Operation_Outcome);
@footer;
}



//;; (skw special processing, special_processing)

void
@perform_custom_lc_process3(str lc = parse_str('/1=', mparm_str))
{
str fp = "Perform custom processing per launch code.";

@header;

if(!@find_lc_known(fp, lc))
{
  return();
}

// What do I call this feature? Auto-Rubric-Population? (skw January) (!arpo)
switch(lc) //qcq
{
  // Add bullet then date. ****
  case 'diar':
  case 'droo':
  case 'pa':
    @add_bullet_below;
    @add_text_date;
    text(': ');
    break;
  // Add http string. ****
  case 'aspl':
  case 'lk':
    @add_bullet_below;
    @add_text_blank_url_here;
    break;
  // Unique. ****
  case 'ers':
    @add_bullet_below;
    @add_text_date;
    @paste_without_wrapping;
    break;
  case 'edit':
    @add_bullet_below;
    cr;
    @add_text_multiedit;
    break;
  case 'fast':
    @add_bullet_below;
    @add_text_date;
    text('  ');
    break;
  case 'mcc':
  case 'prou':
  case 'shon': // (!2msho)
    @add_bullet_below;
    @add_text_date;
    @paste_with_wikipedia_format;
    break;
  default:
    @add_bullet_below;
    break;
}

@footer;

@say(fp);
}



//;;

int
@run_clif_remotely(str lc, int &return_Home, str &sm)
{
str fp = "Run remote Clif using user inputted launch code.";

if(!@find_lc_known(sm, lc))
{
  return(0);
}

int rv = @run_clif_under_cursor(sm);

if(rv ==6)
{
  return_Home = false;
  @perform_custom_lc_process3(lc); //QCQ
}

return(0);
}



//;;

void
@use_wuc_as_shortcut_link_to_lc
{
str fp = "Use word under cursor as a shortcut link to the launch code.";
@header;

@save_location;

str lc = @hc_word_uc;
int return_home = true;
@run_clif_remotely(lc, return_home, fp);

@recall_location;

@footer;
@say(fp);
}



//;;

void
@go_to_and_run_clif
{
str fp = "Go to and run Clif.";

@header;

str lc = @get_user_input_nonspace(fp);
str Distilled_lc = @distill_lc(lc);
if(!@find_lc_known(fp, lc))
{
  if(lc == 'Function aborted.')
  {
    @say(lc);
  }
  return();
}

str Operation_Outcome;
@run_clif_under_cursor(Operation_Outcome);

fp = @trim_period(fp) + ' "' + Distilled_lc + '".';

@footer;
@say(fp);
}



//;+ Quick Launcher Router



//;;

str
@get_postsecondperiod_string(str parameter)
{
str fp = 'Get postperiod string.';

int position_of_period = xpos(char(46), parameter, 1);

str postperiod_string = '';
int loop_Counter = position_of_period + 1;
int length_of_string = length(parameter);

while(loop_counter <= length_of_string)
{
  postperiod_string += str_char(parameter, loop_Counter);
  loop_Counter ++;
}

return(postperiod_string);
}



//;;

void
@find_from_lc_arguments(str lc = parse_str('/1=', mparm_str))
{
str fp = 'Search from lc with reserved word sc.';

// Sample Usage: f.al.sj
// If the second parameter is left blank, the subject is used by default.

str sc = @get_sj;

@find_lc(lc);

sc = @equate_spaces_and_dashes_wcl(sc);
@seek_in_all_files_2_arguments(sc, fp);

@say(fp + ' (' + sc + ')');
}



//;;

void
@test_function(str sc = parse_str('/1=', mparm_str))
{
str fp = "Test function.";

// fcd: Apr-20-2015

@say(fp + ' (' + sc + ')');
}



//;;

void
@line_is_a_codeword_candidate(str application)
{
str fp = "Line is a codeword candidate because user entered only the application parameter.";

// fcd: Apr-21-2015

str sc = @get_subject_or_selected_text;
if(@contains(sc, 'MT-') || @contains(sc, 'DATA-'))
{
  str url = "http://kili:8087/browse/";
  url += sc;
  int is_windows_explorer = false;
  @run_application_2p(application, url);
}

@say(fp);
}



//;;

void
@application_is_a_cmac_macro(str application, str postperiod_status_bar_arguments)
{
str fp = "Application is a CMAC macro.";
// fcd: Apr-21-2015
// Passes the arguments through to the macro in question.
rm(application + ' /1=' + postperiod_status_bar_arguments);
}



//;;

void
@arguments_parser(str status_bar_arguments)
{
str fp = 'Arguments parser.';

str application_lc = @get_presecondperiod_string(status_bar_arguments);
str postperiod_status_bar_arguments = @get_postsecondperiod_string(status_bar_arguments);

int lc_is_found = 0;

str application = @get_remote_oj_using_klc(application_lc, lc_is_found);

if(@first_character(application) == '@')
{
@application_is_a_cmac_macro(application, postperiod_status_bar_arguments);
return();
}

if(postperiod_status_bar_arguments == '')
{
@line_is_a_codeword_candidate(application);
return();
}

}



//;;

void
@cstyle_cmac_with_parameter(str status_bar_arguments)
{
str fp = 'Run CMAC with variable.';

str application_lc = @get_presecondperiod_string(status_bar_arguments);
str postperiod_status_bar_arguments = @get_postsecondperiod_string(status_bar_arguments);

int lc_is_found = 0;

str application = @get_remote_oj_using_klc(application_lc, lc_is_found);

//fp += ' Oct-27-2016: ' + application;
//fp += ' Oct-27-2016: ' + application_lc;
//fp += ' Oct-27-2016: ' + status_bar_arguments;
//@say(fp);
//return();

if(@first_character(application) == '@')
{
  @application_is_a_cmac_macro(application, postperiod_status_bar_arguments);
  return();
}

if(postperiod_status_bar_arguments == '')
{
  @line_is_a_codeword_candidate(application);
  return();
}

@say(fp + " (" + application + ")");
return();

}



//;;

str
@get_first_parameter(str string, str &em_rp)
{
str fp = 'Get first parameter.';

str rv = @trim_leading_colons_et_al(string);

int position_of_apostrophe = xpos(char(39), rv, 1);

if(position_of_apostrophe == 0)
{
  em_rp = 'Error: No apostrophe found in string.';
  rv = '';
  return(rv);
}

str new_string;
int loop_Counter = 1;
int length_of_String = length(rv);

while(loop_Counter < length_of_String)
{
  if(str_char(string, loop_Counter) != "'")
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
  em_rp = 'Error: First argument is missing.';
  rv = '';
  return(rv);
}

rv = new_String;

return(rv);
}



//;;

str
@get_second_parameter(str string, str &em_rp)
{
str fp = 'Get second parameter (post apostrophe string).';

str rv = @trim_leading_colons_et_al(string);

int position_of_apostrophe = xpos(char(39), string, 1);

if(position_of_apostrophe == 0)
{
  em_rp = 'Error: No comma found in string.';
  rv = '';
  return(rv);
}

str new_String;

int loop_counter = position_of_apostrophe + 1;
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



//;;

void
@cstyle_rexe_w_r_full_filename(str arguments = parse_str('/1=', mparm_str))
{
str fp = "Run command line style executable with remote full filename.";

// Parameter 1 is a command line executable and parameter 2 is a remote oj lc path.

// skw first_argument, first_parameter

// fcd: Aug-3-2015

str em_rp;
str sm;
str first_parameter, second_parameter;
@parse_aguments(arguments, "'", first_parameter, second_parameter);

if(length(em_rp) > 0)
{
  sm = em_rp;
  return();
}

if(length(em_rp) > 0)
{
  sm = em_rp;
  return();
}

str third_parameter;

If(xpos("'", second_parameter, 1))
{
  arguments = second_parameter;
//  second_parameter = @get_second_parameter(arguments, em_rp);
  if(length(em_rp) > 0)
  {
    sm = em_rp;
    return();
  }
  third_parameter = @get_second_parameter(arguments, em_rp);
  if(length(em_rp) > 0)
  {
    sm = em_rp;
    return();
  }
}

int lc_is_found;

str application = @get_remote_oj_using_klc(first_parameter, lc_is_found);
str remote_oj_path = @get_remote_oj_using_klc(second_parameter, lc_is_found);
@run_application_2p(application, remote_oj_path);

@say(fp + ' (' + first_parameter + "'" + second_parameter + ')');
}



//;;

void
@cstyle_rexe_w_context(str arguments = parse_str('/1=', mparm_str))
{
str fp = "Run context-style command line.";

// fcd: Aug-3-2015

str em_rp;
str sm;
str first_parameter, second_parameter;
@parse_aguments(arguments, "-", first_parameter, second_parameter);

if(length(em_rp) > 0)
{
  sm = em_rp;
  return();
}

if(length(em_rp) > 0)
{
  sm = em_rp;
  return();
}

str third_parameter;

If(xpos("'", second_parameter, 1))
{
  arguments = second_parameter;
  //  second_parameter = @get_second_parameter(arguments, em_rp);
  if(length(em_rp) > 0)
  {
    sm = em_rp;
    return();
  }
  third_parameter = @get_second_parameter(arguments, em_rp);
  if(length(em_rp) > 0)
  {
    sm = em_rp;
    return();
  }
}

int lc_is_found;

str application = @get_remote_oj_using_klc(first_parameter, lc_is_found);

str expanded_reserved_word = @get_reserved_word(second_parameter);
//@say('expanded_reserved_word:' + ' ' + expanded_reserved_word); return();

@run_application_2p(application, expanded_reserved_word);

@say(fp + ' (' + first_parameter + "--" + second_parameter + ')');
}



//;;

void
@cstyle_cmac_w_lc(str arguments = parse_str('/1=', mparm_str))
{
str fp = "Run lc pass style command line.";

// fcd: Aug-3-2015

// This small function rewrites pretty much all of the passthrough god class.
// CMAC function Verb pass-through.
str argument_1, argument_2;
@parse_aguments(arguments, ".", argument_1, argument_2);
int lc_is_found;
str expanded_verb = @get_remote_oj_using_klc(argument_1, lc_Is_Found);
if(!lc_Is_Found)
{
  @say("LC NOT found. (" + expanded_verb + ")");
  return();
}
expanded_verb = @resolve_environment_variable(expanded_verb);
expanded_verb = @trim_before_character(expanded_verb, '"');
if(@left(expanded_verb, 2) == '/R')
{
  expanded_verb = @trim_left(expanded_verb, 2);
}
rm(expanded_verb + ' /1=' + argument_2);

}



//;;

void
@cstyle_cmac_string_consumer(str arguments = parse_str('/1=', mparm_str))
{
str fp = "Run CMAC that consumes a string.";

// fcd: Aug-27-2015

// Not yet implemented.

/*
str argument_1, argument_2;
@parse_aguments(arguments, ".", argument_1, argument_2);
int lc_is_found;
str expanded_verb = @get_remote_oj_using_klc(argument_1, lc_Is_Found);
if(!lc_Is_Found)
{
  @say("LC NOT found. (" + expanded_verb + ")");
  return();
}
expanded_verb = @resolve_environment_variable(expanded_verb);
expanded_verb = @trim_before_character(expanded_verb, '"');
if(@left(expanded_verb, 2) == '/R')
{
  expanded_verb = @trim_left(expanded_verb, 2);
}
rm(expanded_verb + ' /1=' + argument_2);
*/

}



//;;

void
@run_skeleton_router(str user_input = parse_str('/1=', mparm_str))
{
str fp = "Run skeleton router.";

/*

By skeleton I mean a elegant and scalable structure ulike that which was found in the 
deprecated RCC method.

fcd: Aug-6-2015
flu: Aug-25-2016

For more information, see &srum.

*/

str first_character = @first_character(user_input);

str user_input_wo_first_2_chars = @trim_before_character(user_input, '.');
str massaged_string_1 = @replace(user_input_wo_first_2_chars, ".", "'");
str massaged_string_2 = @replace(user_input_wo_first_2_chars, ".", "-");

int lc_Is_Found;

switch(first_character)
{
  // Status Bar Character Glossary
  case '1': // dash
    // remote application with contextual awareness
    @cstyle_rexe_w_context(massaged_string_2);
    break;
  case '2': // apostrophe
    // remote application with remote parameter
    @cstyle_rexe_w_r_full_filename(massaged_string_1);
    break;
  case '3': // comma
    @cstyle_cmac_w_lc(user_input_wo_first_2_chars);
    break;
  case '4': // (!rcc, !skeleton, !skel)
    @find_lc(user_input_wo_first_2_chars);
    break;
  case '5': // tick
    @cstyle_cmac_string_consumer(user_input_wo_first_2_chars);
    break;
  default:  // period
    @cstyle_cmac_with_parameter(user_input);
}

}



//;;

void
@quick_launcher_router(str status_bar_text, int is_repeater)
{
str fp = "Quick launcher router.";
fp = "LC.";

str sm;

/* Rules of the status bar command line.

No spaces.

Maximum 2 commas, for now at least.

Use colon in the first position of the object to signify an inline noun.

*/

int text_Is_Selected = 0;
int show_outer_status_message = true;

@header;

if(@text_is_selected)
{
  text_is_selected = 1;
  @save_highlighted_text;
}
else
{
  @clear_highlighted_text;
}

@save_location;
str user_Input;

if(is_repeater)
{
  user_input = Global_Str('status_bar_text');
}
else
{
  if(status_bar_text == '')
  {
    user_Input = @get_user_input_nonspace(fp);
  }
  else
  {
    user_input = status_bar_text;
  }
}

set_global_str('status_bar_text', user_input);

if(user_Input == 'Function aborted.')
{
  @say(fp + ' ' + user_Input);
  @footer;
  return();
}

if(user_Input == '')
{
  return();
}

int return_home = true;

if(xpos(',', user_input, 1))
{
  @run_location_passthrough(user_input, sm, show_outer_status_message, 0, return_home);
}
else if(xpos('.', user_input, 1))
{
  if(@first_character(user_input) == '.') //period
  {
    // Oct-27-2016: This is a trick/hack which allows me not have to type the "e" for 
    // the very common macro.
    user_input = 'bam2' + user_input;
  }
  //  @say(' Oct-27-2016: ' + user_input);
  @run_skeleton_router(user_input);
  @footer;
  return();
}
else if(xpos("'", user_input, 1)){
  @cstyle_rexe_w_r_full_filename(user_input);
  @footer;
  return();
}
else if(xpos("-", user_input, 1))
{
  @cstyle_rexe_w_context(user_input);
  @footer;
  return();
}
else
{
  @run_clif_remotely(user_input, return_home, sm);
}

if(return_home)
{
  @recall_location;
}

if(text_Is_Selected)
{
  @load_highlighted_text;
}
else
{
  // I am uncommenting this because it doesn't center the line when I do !+l. Feb-6-2012
  // I am commenting this footer because it deletes the higlight from an action like 
  // !+au. Feb-3-2012
  // I put the footers back into this function because otherwise macros like
  // !+dml doesn't work because it doesn't recognize the selection. Jan-23-2014
  @footer;
}

if(show_outer_status_message == true)
{
  @say(sm);
}
else
{
  // Apr-1-2015: I commented this out so the pass-through lcs would show their own
  // status messages.
  // @say(global_str('inner_status_message'));
}

}



//;;

void
@quick_launcher_router_caller
{
@quick_launcher_router('', 0);
}



//;;

void
@@quick_launcher_router(str status_bar_text = parse_str('/1=', mparm_str))
{
@quick_launcher_router(status_bar_text, 0);
}



//;;

void
@repeat_quick_launch
{
@quick_launcher_router(global_str('status_bar_text'), 1);
}



//;+ Tablet Macros



//;;

int
@i_am_on_my_tablet()
{
str fp = "I am on my home tablet.";

switch(@lower(Get_Environment("ComputerName")))
{
  case "wave-function":
    return(1);
    @say(fp);
    break;
}
return(0);
}



//;;

void
@question_mark_operation
{
str fp = "Question mark operation.";

if(!@i_am_on_my_tablet)
{
  text('?');
  return();
}

@quick_launcher_router('', 0);

}



//; (!2mum1)

void
@paste_with_arguments(str arguments = parse_str('/1=', mparm_str))
{
str fp = "Paste with arguments.";

@header;

// Last Updated: Sep-21-2016

str first_parameter, second_parameter;

@parse_aguments(arguments, ".", first_parameter, second_parameter);

str lc = first_parameter; // location here below (default) versus remote

str wrapping_is_on = second_parameter; // wwrapping (default "") versus no wrapping "n"

if(lc != '')
{
  @find_lc(lc);
}
@add_bullet_below;

// Enforce the default.
if((wrapping_is_on == '') or (wrapping_is_on == 'y'))
{
  @paste_with_wikipedia_format;
}
else
{
  @paste;
  down;
  @backspace;
}
@bob;

@footer;
@say(fp);
}



//; (!2mum2)

void
@find_backwards(str arguments = parse_str('/1=', mparm_str))
{
str fp = "Find backwards wost at lc.";

@header;

// fcd: Sep-21-2016

str first_parameter, second_parameter;

@parse_aguments(arguments, ".", first_parameter, second_parameter);

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

@footer;

@say(fp);
}



//;

void
@find_backwards_from_eof_w_ui
{
str fp = "Find backwards from EOF using user input.";
@header;

// fcd: Sep-22-2016

@find_backwards('rfeof.u');

@footer;
}



//;EOF << (!efcf)