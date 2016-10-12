/*==============================================================================
                             Multi-Edit Macro File
                               22-Aug-06  17:55

  Function: ShellAPI interface header
  Authors : Dan Hughes

              Copyright (C) 2002-2006 by Multi Edit Software, Inc
 ====================================================================( ldh )==*/

#define   error_Success 					0
#define   error_BadDB 						1
#define   error_BadKey 						2
#define   error_CantOpen 					3
#define   error_CantRead 					4
#define   error_CantWrite 				5
#define   error_OutOfMemory 			6
#define		error_Invalid_Parameter	7
#define   error_Access_Denied 		8

import int	DragQueryFile(
		THandle Drop,
		int 		FileIndex,
		*asciiz FileName,
		int			cb
		)  shell32 'DragQueryFileA';

import int	DragQueryFileInt(
		THandle Drop,
		int			FileIndex,
		int 		FileName,
		int			cb
		)  shell32 'DragQueryFileA';

/*
import Bool DragQueryPoint( THandle Drop, PPoint Pt )
		shell32 'DragQueryPoint';

import void DragFinish( THandle Drop )
		shell32 'DragFinish';

import void DragAcceptFiles( HWnd Wnd, Bool Accept )
		shell32 'DragAcceptFiles';

import HIcon ExtractIcon(
		THandle Inst,
		*asciiz ExeFileName,
		int			IconIndex
		)  shell32 'ExtractIconA';
*/

// error values for ShellExecute( ) beyond the regular WinExec( ) codes

#define   se_err_Share 						26
#define   se_err_AssocIncomplete	27
#define   se_err_DDETimeout				28
#define   se_err_DDEFail 					29
#define   se_err_DDEBusy 					30
#define   se_err_NoAssoc 					31

import THandle ShellExecute(
		HWnd 		HWnd,
		asciiz 	Operation,
		asciiz 	FileName,
		asciiz 	Parameters,
		asciiz 	Directory,
		int			ShowCmd
		)  shell32 'ShellExecuteA';

import THandle FindExecutable(
		*asciiz FileName,
		*asciiz Directory,
		*asciiz Result
		)  shell32 'FindExecutableA';