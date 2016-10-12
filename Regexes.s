macro_file Regexes; // Regular Expressions (!re)

#include Aliases.sh
#include Shared.sh



//; Macro File Glass Ceiling



//;

/*

Metadata: Track Size (!tsre)

     Date      Lines    Bytes     Macros  Notes
 -----------  ------  ---------  -------  ---------------------------------------------------

: Oct-7-2016   1,463     20,939       81

: Apr-8-2016   1,475     21,145       82

:Dec-31-2015   1,489     21,299       83

: Oct-5-2015   1,478     21,110       83

: Jul-1-2015   1,462     20,852       82

: Apr-1-2015   1,456     20,781       81

:Jan-16-2015   1,310     18,800       73

: Oct-1-2014   1,327     19,096       73

: Jul-1-2014   1,264     18,134       70

:Apr-10-2014   1,236     17,750       68

: Oct-1-2013   1,230     17,624       68

: Jul-1-2013   1,228     17,580       68

: Apr-1-2013   1,226     17,536       68

: Jan-2-2013   1,224     17,492       68

: Oct-1-2012   1,208     17,290       67

: Jul-2-2012   1,177     16,727       65

:Jun-14-2012   1,142     16,308       64

- Apr-2-2012   1,095    15,556      61

- Jan-2-2012   1,047    14,659      59

- Dec-20-2011  1,045    14,618      59

- Nov-29-2011  1,038    14,418      59 At 65 lines per page, that's 16 pages of code.

- Oct-3-2011     970    13,274      58

- Aug-1-2011     968    13,297      58

- Jul-15-2011    966    13,256      58

- Jun-1-2011     937    12,899      56

- Apr-7-2011     901    12,470      57

- Mar-9-2011     873    11,980      55

- Jan-3-2011     835    11,446      53

- Jul-1-2010     704     9,370      45

- Jun-1-2010     674     8,917      43

- Mar-1-2010     622     8,363      39

- Feb-1-2010     619     8,307      39

- Jan-8-2010     618     8,394      39

- Dec-9-2009     434     5,971      29

- Dec-7-2009     445     6,010      30 At 65 lines per page = 7 pages.

- Dec-4-2009     411     5,595      28

*/



//;+ Rubric Macros



//;;

str
@big_segment()
{
str fp = 'Return the proper rubric search criterion for a particular file type.';

switch(@filename_extension)
{
  case 'asc':
  case 'txt':
    return("^;");
    break;
  case 'bat':
    return("^:_");
    break;
  case 'config':
    return("^ @<entity type");
    break;
  case 'htm':
    return("^<header");
    break;
  case 'ps1':
    return("^;");
    break;
  case 's':
  case 'sh':
    return("^//;");
    break;
  case 'sql':
    return("^--;");
    break;
  case 'xsl':
    return("^ @<xsl:t");
    break;
  case 'xml':
  case 'xslt':
    return('^ @<!--;');
    break;
}

}



//;;

str
@rubric()
{
str fp = 'Return the proper rubric search criterion for a particular file type.';

str sc;

switch(lower(get_extension(File_name)))
{
  case 'asc':
    sc = "^;"; // Problem: Finds subrubrics too.
    sc = "^;[^;]"; // Problem: Doesn't find empty rubrics and subrubrics.
    sc = "^;([^;]|$)"; // Ahh! Goldilocks.
    return(sc);
    break;
  case 'bat':
    return("^:_");
    break;
  case 'config':
    return("^ @<entity type");
    break;
  case 'ps1':
    return(@big_segment);
    break;
  case 's':
  case 'sh':
    return('^/' + '/;([^;]||$)');
    break;
  case 'sql':
    return("^--;");
    break;
  case 'htm':
  case 'xml':
    return("^<header");
    break;
  case 'xsl':
  case 'xslt':
    return('^ @<!--;');
    break;
  default:
    return("");
}

}



//;;

str
@childless_rubric()
{
str fp = 'Childless rubric';

str sc;

switch(lower(get_extension(File_name)))
{
  case 'asc':
    sc = "^;"; // Problem: Finds subrubrics too.
    sc = "^;[^;]"; // Problem: Doesn't find empty rubrics and subrubrics.
    sc = "^;([^;+]|$)"; // Ahh! Goldilocks.
    return(sc);
    break;
  case 'bat':
    return("^:_");
    break;
  case 'config':
    return("^ @<entity type");
    break;
  case 's':
  case 'sh':
    return('^/' + '/;([^+;]||$)');
    break;
  case 'sql':
    return("^--;");
    break;
  case 'htm':
  case 'xml':
    return("^<header");
    break;
  case 'xsl':
  case 'xslt':
    return('^ @<!--;');
    break;
  default:
    return("");
}

}



//;;

str
@family_rubric()
{
str fp = 'Family rubric';

str sc;

switch(lower(get_extension(File_name)))
{
  case 'asc':
    sc = '$$$^;\+';
    return(sc);
  case 'bat':
    return("^:_");
    break;
  case 'config':
    return("^ @<entity type");
    break;
  case 's':
  case 'sh':
    return('$$$^//;\+');
  case 'sql':
    return("^--;");
    break;
  case 'htm':
  case 'xml':
    return("^<header");
    break;
  case 'xsl':
  case 'xslt':
    return('^ @<!--;');
    break;
  default:
    return("");
}

}



//;;

str
@rubric_text()
{
str fp = 'Return the proper rubric text for a particular file type.';

switch(lower(get_extension(File_name)))
{
  case 'asc':
  case 'jpg':
  case 'txt':
    return(";");
    break;
  case 'bat':
    return(":_");
    break;
  case 'ps1':
    return(";");
    break;
  case 's':
  case 'sh':
    return('/' + '/;');
    break;
  case 'sql':
    return("--;");
    break;
  case 'xml':
  case 'xsl':
  case 'xslt':
    return("<!--; -->");
    break;
}

}



//;;

str
@family_rubric_text()
{
str fp = 'Return the proper rubric text for a particular file type.';

switch(lower(get_extension(File_name)))
{
  case 'bat':
    return(":_");
    break;
  case 'asc':
  case 'jpg':
  case 'txt':
    return(";+");
    break;
  case 's':
  case 'sh':
    return('/' + '/;+');
    break;
  case 'sql':
    return("--;");
    break;
  case 'xml':
  case 'xsl':
  case 'xslt':
    return("<!--; -->");
    break;
}

}



//;;

str
@subrubric_text()
{
str fp = 'Return the proper rubric text for a particular file type.';

switch(lower(get_extension(File_name)))
{
  case 'bat':
    return(":_");
    break;
  case 'asc':
  case 'jpg':
  case 'txt':
    return(";;");
    break;
  case 's':
  case 'sh':
    return('/' + '/;;');
    break;
  case 'sql':
    return("--;;");
    break;
  case 'xml':
    return("<!--;; -->");
    break;
}
}



//;;

str
@bullet()
{
str fp = "Bullet.";
str sc = 'No content area specified.';

switch(@filename_extension)
{
  case 'bat':
    sc = '(^:$)||(^:[^_])';
    break;
  case 'asc':
    sc = '(^:$)||(^:[^:])';
    break;
  case 'htm':
    sc = '^<!--:';
    break;
}

return(sc);
}



//;;

str
@bullet_text()
{
str fp = 'Return the proper rubric text for a particular file type.';

switch(@filename_extension)
{
  case 'bat':
    return(":");
    break;
  case 'asc':
    return(":");
    break;
  case 's':
  case 'sh':
    return(':');
    break;
  case 'sql':
    return(":");
    break;
  case 'xml':
    return(":");
    break;
}

}



//;;

str
@subrubric()
{
str fp = 'Return the proper rubric search criterion for a particular file type.';

switch(lower(get_extension(File_name)))
{
  case 'bat':
    return("^:__");
    break;
  case 'asc':
    return("^;;");
    break;
  case 's':
  case 'sh':
    return("^//;;");
    break;
  case 'sql':
    return("^--;;");
    break;
  case 'htm':
  case 'xml':
  case 'xsl':
    return("^<!--;;");
    break;
  default:
    return("");
}

}



//;

str
@bol_comma(str &regex_Description, str &rS)
{
str fp = 'BOL comma.';
str sc = '^,';
rS = ' ';
regex_Description = fp;
return(sc);
}



//;

str
@bol_colon(str &regex_Description, str &rS)
{
str fp = 'BOL colon.';
str sc = '^:';
rS = '-';
regex_Description = fp;
return(sc);
}



//;

str
@close_parenthesis_number(str &regex_Description, str &rS)
{
str fp = 'Close parenthesis number.';
str sc = '(\))([0-9])';
rS = '\0 \1';
regex_Description = fp;
return(sc);
}



//;+ Parenthesis



//;;

str
@open_parenthesis_space_letter(str &regex_Description, str &rS)
{
str fp = 'Open parenthesis space letter.';
str sc = '(\()' + ' ' + '([a-zA-Z0-9])';
rS = '\0\1';
regex_Description = fp;
return(sc);
}



//;;

str
@letter_space_close_parenthesis(str &regex_Description, str &rS)
{
str fp = 'Letter space close parenthesis.';
str sc = '([a-zA-Z0-9]) (\))';
rS = '\0\1';
regex_Description = fp;
return(sc);
}



//;

str
@space_comma(str &regex_Description, str &rS)
{
str fp = 'Space comma.';
str sc = char(32) + ',';
//rS = '\0 \1';
regex_Description = fp;
return(sc);
}



//;

str
@bol_space(str &regex_Description, str &rS)
{
str fp = 'BOL space.';
str sc = '^' + char(32);
rS = '';
regex_Description = fp;
return(sc);
}



//;

str
@open_bracket_space(str &regex_Description, str &rS)
{
str fp = 'Open bracket space.';
str sc = '(\' + char(91) + ')' + char(32);
rS = '\0';
regex_Description = fp;
return(sc);
}



//;

str
@crowded_noun(str &regex_Description, str &rS)
{
str fp = 'Noun followed by an alphabetic character.';
str sc = ' (noun)([a-rt-z])';
rs = ' noun \1';
regex_Description = fp;
return(sc);
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



//;

str
@space_colon(str &regex_Description, str &rS)
{
str fp = "Space colon.";
str sc = ' ' + char(58);
rs = ':';
regex_Description = fp;
return(sc);
}



//;

str
@space_eol_blank_line(str &regex_Description, str &rS)
{
str fp = 'Space EOL blank line.';
str sc = '(.#) $$';
rs = '\0$';
regex_Description = fp;
eol;
return(sc);
}



//;+ Alpha Character



//;;

str
@alphabetic_character()
{
str fp = "Alphabetic character.";
str sc = '[A-Za-z]';
return(sc);
}



//;;

str
@alphanumeric_character()
{
str fp = "Alphanumeric character.";
str sc = '[a-z0-9]';
return(sc);
}



//;

str
@alphanumeric_space_period(str &regex_Description, str &rS)
{
str fp = "Alphanumeric space period.";
str sc = '(' + @alphanumeric_character + ')( )(\. [^.])';
rS = '\0\2';
regex_Description = fp;
return(sc);
}



//;

str
@period_space_eol(str &regex_Description, str &rS)
{
str fp = "Period space EOL.";
str sc = '(\.)( )($)';
rS = '\0\2';
regex_Description = fp;
return(sc);
}



//;

str
@comma_nonspace(str &regex_Description, str &rS)
{
str fp = "Comma nonspace.";
str sc = '(,)(' + @alphabetic_character + ')';
rS = '\0 \1';
regex_Description = fp;
return(sc);
}



//;

str
@space_space_eol(str &regex_Description, str &rS)
{
str fp = "Space space EOL.";
str sc = '  $';
rS = ' ';
regex_Description = fp;
return(sc);
}



//;

str
@bol_space_eol(str &regex_Description, str &rS)
{
// Space on a line by itself.
str fp = "BOL space EOL.";
str sc = '^ $';
rS = '';
regex_Description = fp;
return (sc);
}



//;

str
@bol_colon_eol_eol(str &regex_Description, str &rS)
{
// Bullet on a line by itself. (skw blank colon, blank_colon)
str fp = "BOL colon EOL EOL.";
str sc = '^:$$';
//rs = ''
regex_Description = fp;
return(sc);
}



//;

str
@bol_colon_colon_eol_eol(str &regex_Description, str &rS)
{
// Subbullet on a line by itself. (skw blank colon, blank_colon)
str fp = "BOL colon colon EOL EOL.";
str sc = '^::$$';
//rs = ''
regex_Description = fp;
return(sc);
}



//;

str
@space_space_dash_space_space(str &regex_Description, str &rS)
{
str fp = 'Double space dash double space.';
str sc = '  -' + '  ';
rS = ' - ';
regex_Description = fp;
return(sc);
}



//;+ Wiki Annotation



//;;(skw wikipedia_brackets, wikipedia brackets)

str
@wikipedia_annotation(str &regex_Description, str &rS)
{
str fp = 'Wikipedia annotation.';
str sc = '\[[1-9]\]';
rS = '';
regex_Description = fp;
return(sc);
}



//;;

str
@wikipedia_annotation_2_digits(str &regex_Description, str &rS)
{
str fp = 'Wikipedia annotation two digit.';
str sc = '\[[1-9][0-9]\]';
rS = '';
regex_Description = fp;
return(sc);
}



//;

str
@wikipedia_citation(str &regex_Description, str &rS)
{
str fp = 'Wikipedia citation.';
str sc = '\[citation ' + 'needed\]';
rS = '';
regex_Description = fp;
return(sc);
}



//;

str
@thin_bullet(str &regex_Description, str &rS)
{
// This works for subbullets as well.
// (skw thin_colon, thin colon.)
str fp = "Thin bullet.";
str sc = '.$^:';
//rs = ''
regex_Description = fp;
return(sc);
}



//;

str
@thinnest_rubric(str &regex_Description, str &rS)
{
str fp = "Thinnest rubric.";
str sc = '.$' + @big_segment;
//rs = ''
regex_Description = fp;
return(sc);
}



//;

str
@thinner_rubric(str &regex_Description, str &rS)
{
str fp = "Thinner rubric.";
str sc = '.$$' + @big_segment;
//rs = ''
regex_Description = fp;
return(sc);
}



//;

str
@thin_rubric(str &regex_Description, str &rS)
{
str fp = "Thin rubric.";
str sc = '.$$$' + @big_segment;
//rs = ''
regex_Description = fp;
return(sc);
}



//;

str
@fat_colon(str &regex_Description, str &rS)
{
// (skw fat_colon)
str fp = "Fat colon.";
str sc = '$$$^:';
//rs = ''
regex_Description = fp;
return(sc);
}



//;

str
@fat_rubric(str &regex_Description, str &rS)
{
str fp = "Fat rubric.";
str sc = '$$$$$' + @big_segment;
rS = '$$$$' + @big_segment;
regex_Description = fp;
return(sc);
}



//;

str
@look_up_replacement_character(str sc)
{
str fp = "Look up replacement string.";

str rs;

switch(ascii(sc))
{
  case 129:
    rs = 'ü';
    break;
  case 131:
    rs = 'f';
    break;
  case 132:
    rs = 'à';
    break;
  case 134:
    rs = 'à';
    break;
  case 136:
    rs = '\^';
    break;
  case 136:
    rs = '?';
    break;
  case 146:
    rs = "'";
    break;
  case 147:
    rs = '"';
    break;
  case 148:
    rs = '"';
    break;
  case 151:
    rs = '"--';
    break;
  case 153:
    rs = '"';
    break;
  case 156:
    rs = 'oe';
    break;
  case 158:
    rs = '?';
    break;
  default:
    rs = '-';
}

return(rs);
}



//;

str
@special_character(str &regex_Description, str &rS, str sc)
{
str fp = "Special character.";
fp = @trim_last_character(fp) + ': ' + str(ascii(sc)) + '.';
//fp = str_del(fp, length(fp), 1) + ': ' + str(ascii(sc)) + '.';
rs = @look_up_replacement_character(sc);
regex_Description = fp;
return(sc);
}



//;

str
@space_space(str &regex_Description, str &rS)
{
str fp = "Space space.";
str sc = '  ';
rs = ' ';
regex_Description = fp;
return(sc);
}



//;

str
@lookup_counter()
{
str fp = "Lookup counter.";
str sc = 'lk\#[0-9][0-9]*';
return(sc);
}



//;

str
@cmac_function_header()
{
str fp = "CMAC function header.";
str sc = '(^)((str)||(int)||(void))$';
return(sc);
}



//;

str
@bsr
{
str fp = "Bullet, subbullet or rubric.";
str sc = '(^:)||(' + @big_segment + ')';
//rs = '';
//regex_Description = fp;
return(sc);
}



//;

str
@bullet_or_big_segment
{
str fp = "Bullet or big segment.";
str sc = '(' + @bullet + ')||(' + @big_segment + ')';
//regex_Description = fp;
return(sc);
}



//;

str
@lc
{
str fp = "Launch Code.";
str sc = '\(!.#\)';
return(sc);
}



//;

str
@lc_ending_in_2_letters(str last_2_Letters_of_lc)
{
str fp = "Launch Code ending in 2 letters.";
str sc = '';
sc = '(\(!)||(,' + ' !)' + '..' + last_2_letters_of_lc + '\)||,' ;
return(sc);
}



//;

str
@broken_lc(str &regex_Description, str &rS)
{
str fP = "Broken launch code xx.";

str sc;

//1. Space before exclamation point.
sc += '(\(' + char(32) + '\!)';

//2. Space after exclamation point.
sc += '||';
sc += '(\(\!' + char(32) + ')';

//3. Space after exclamation point when lc is not in the first position.
sc += '||';
sc += '(, !' + ' )';

//4. Five character launch code. Commented on Jan-30-2012.
//sc += '||';
//sc += '(!' + '[a-zA-Z0-9]...[a-zA-Z0-9],)';

//5. Also, five character launch code. Commented on Jan-30-2012.
//sc += '||';
//sc += '(!' + '[a-zA-Z0-9]...[a-zA-Z0-9]\))';

regex_Description = fp;
return(sc);

/* Use Case - May-5-2011

- 1. Space before the exclamation point and after the open parenthesis.

([]!blah

- 2. Space after the exclamation point.
(![]blah blah

- 3. 5 character launch code in the non-last position.


- 4. 5 character launch code in the last position.

!abcd,

!abcd)

![]abcde,

![]abcde)

*/
}



//;

str
@period_space_space_alpha_char(str &regex_Description, str &rS)
{
str fp = "Period space space alphabetic character.";
str sc = '(\.)(  )(' + @alphabetic_character + ')';
rs = '\0 \2';
regex_Description = fp;
return(sc);
}



//;

str
@alphabetic_character_space_lk(str &regex_Description, str &rS)
{
str fp = "Alphabetic character space" + " lk.";
str sc = @alphabetic_character + ' lk';
//rs = '\0 \2';
regex_Description = fp;
return(sc);
}



//;

str
@colon_period_space_period
{
str fp = "Colon period space period.";
str sc = ':\. \.';
return(sc);
}



//;

str
@blank_line(str &regex_Description, str &rS)
{
str fp = "Blank line.";
regex_Description = fp;
rs = '';
str sc = '$^$';
return(sc);
}



//;

str
@broken_cmac_macro(str &regex_Description, str &rS)
{
str fp = "Broken CMAC macro.";
regex_Description = fp;
str sc = '/R $';
return(sc);
}



//;

void
@regexes_say_version
{
str fp = "Regexes.s v. Mar-9-2010.";
}



//;

str
@subbullet()
{
str fp = "Subbullet.";
str sc = '(^::$)||(^::)';
return(sc);
}



//;

str
@synonyms_space_space(str &regex_Description, str &rS)
{
str fp = "Synonyms space space.";
str sc = "synonyms" + "  ";
regex_Description = fp;
rs = "synonyms ";
return(sc);
}



//;

str
@word_history_space_space(str &regex_Description, str &rS)
{
str fp = "Word History space space.";
str sc = "word " + "history  ";
regex_Description = fp;
rs = "word history ";
return(sc);
}



//;

str
@period_colon(str &regex_Description, str &rS)
{
str fp = "Period colon.";
str sc = '\.' + ': lk';
regex_Description = fp;
//rs = "word history ";
return(sc);
}



//;

str
@question_mark_colon_space_lk(str &regex_Description, str &rS)
{
str fp = "Question mark colon space l" + "k.";
str sc = '\?' + ': lk';
regex_Description = fp;
//rs = " ";
return(sc);
}



//;+ Marketing Detritus



//;;

str
@share_american_heritage_dot_com(str &regex_Description, str &rS)
{
str fp = "Share American Heritage come garabage addendum.";
str sc = 'Share:';
regex_Description = fp;
rs = "";
return(sc);
}



//;

str
@show_ipa(str &regex_Description, str &rS)
{
str fp = "Show ' + 'IPA.";
str sc = 'Show ' + 'IPA ';
regex_Description = fp;
rs = "";
return(sc);
}



//;

str
@anything(str &regex_Description, str &rS)
{
str fp = "Anything. Something or nothing.";

str sc = '.@';
//rs = '';
regex_Description = fp;
return(sc);
}



//;

str
@selected_text(str &regex_Description, str &rS)
{
str fp = "Selected text.";

str sc = copy(get_line, block_col1, block_col2 + 1 - block_col1);
//rs = '';
regex_Description = fp;
return(sc);
}



//;

str
@content_area()
{
str fp = "Content area.";
str sc = '(' + @bullet + ')||(' + @subbullet + ')';
sc += '||(' + @rubric + ')||(' + @subrubric + ')';
return(sc);
}



//;

str
@small_segment()
{
str fp = "Small segment.";
str sc = '(' + @bullet + ')||(' + @subbullet + ')';
return(sc);
}



//;

str
@comma_lc()
{
str fp = "Comma launch code.";
str sc = ' [a-z]@,[a-z]';
return(sc);
}



//;

str
@mobile_colon(str &regex_Description, str &rS)
{
str fp = "Alphabetic character plus zero plus space.";
str sc = '(' + @alphabetic_character + ')(0' + ' )';
rs = '\0: ';
regex_Description = fp;
return(sc);
}



//;

str
@language_learner(str &regex_Description, str &rS)
{
str fp = "Language learner.";
str sc = 'See ($^)@.@ ($^)@defined ($^)@for ($^)@English-language ($^)@learners'; //works
rs = '';
regex_Description = fp;
return(sc);
}



//;

str
@defined_for_kids(str &regex_Description, str &rS)
{
str fp = "Defined for" + " kids.";
str sc = 'See ($^)@.@ ($^)@defined ($^)@for ($^)@kids'; //works
rs = '';
regex_Description = fp;
return(sc);
}



//;

str
@first_known_use(str &regex_Description, str &rS)
{
str fp = "First known " + "use.";
str sc = ' (First ($^)@Known ($^)@Use)';
rs = '$$\0';
regex_Description = fp;
return(sc);
}



//;

str
@rhymes_with(str &regex_Description, str &rS)
{
str fp = "Rhymes with.";
str sc = ' (Rhymes ($^)@With)';
rs = '$$\0';
regex_Description = fp;
return(sc);
}



//;EOF << (!efre)