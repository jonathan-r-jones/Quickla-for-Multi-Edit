macro_file Build_CMAC_Macros; // (!)



#include Aliases.sh  // One of my guys.
#include WinExec.sh  // Used by 'Execprog'.



//;

void
@load_my_macros_into_memory_2()
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
load_macro_file('Format');
load_macro_file('Finder');

@say(fp)
}



//;

void
@load_listmgr_into_memory()
{
str fp = "Load ListMgr into memory.";

load_macro_file('ListMgr');

@say(fp)
}



//;

void
@load_joma()
{
str fp = "Load joma.";

// You can't load macro from the same macro.

load_macro_file("Jonathan's_Macros");

@say(fp)
}



//;

void
@perform_macro_operations
{
str fp = "Perform macro operations.";

str Batch_File_Filename = 'compile_cmac_files_1.bat';

str Command_String = 'c:\windows\system32\cmd.exe /k ' + char(34) +
  Get_Environment("savannah") +
  '\belfry\' + Batch_File_Filename + char(34);

ExecProg(Command_String,
  Get_Environment("userprofile") + '\my documents\savannah\belfry',
  Get_Environment("TEMP") + '\\multi-edit output.txt',
  Get_Environment("TEMP") + '\\multi-edit error.txt',
  _EP_FLAGS_DONTWAIT | _EP_FLAGS_EXEWIN);

@load_my_macros_into_memory_2;

@say(fp);
}



//;EOF << (!efre)