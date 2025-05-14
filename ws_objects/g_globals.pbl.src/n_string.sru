$PBExportHeader$n_string.sru
forward
global type n_string from nonvisualobject
end type
end forward

global type n_string from nonvisualobject
end type
global n_string n_string

type prototypes
//=== findwindow 95 e w3.x
function longPtr FindWindowA (longPtr szclass, string sztitle) library "USER32.DLL" alias for "FindWindowA;Ansi"

end prototypes

forward prototypes
public function long of_arraytostring (string as_source[], string as_delimiter, boolean ab_processempty, ref string as_ref_string)
public function long of_arraytostring (string as_source[], string as_delimiter, ref string as_ref_string)
public function string of_globalreplace (string as_source, string as_old, string as_new, boolean ab_ignorecase)
public function string of_globalreplace (string as_source, string as_old, string as_new)
public function boolean of_isalpha (string as_source)
public function boolean of_isalphanum (string as_source)
public function long of_parsetoarray (string as_source, string as_delimiter, ref long al_array[])
public function long of_parsetoarray (string as_source, string as_delimiter, ref string as_array[])
public function long of_lastpos (string as_source, string as_target, long al_start)
public function long of_lastpos (string as_source, string as_target)
public function string of_quote (string as_source)
public function string u_stringa_compatta (string k_stringa)
public function string u_stringa_pulisci_asc (string ka_stringa)
public function string u_stringa_cmpnovocali (string a_stringa)
public function string u_stringa_alfa (string k_stringa)
public function string u_stringa_tonome (string k_stringa)
public function string u_stringa_spezza (string k_stringa)
public function string u_replace (string k_str, string k_str_old, string k_str_new)
public function string u_stringa_pulisci (string k_stringa)
public function string u_stringa_pulisci_x_msg (string k_stringa)
public function string u_stringa_numeri (string k_stringa)
public function string u_stringa_pulisci_nomefunzione (string k_stringa)
public function string u_stringa_alfanum (string k_stringa)
public function string u_string_replace (string k_string, readonly string k_str_old, readonly string k_str_new)
public function integer u_findwindow (unsignedlong k_classe, string k_window)
public function integer u_stringa_split (ref string a_string[], string a_sep)
public function string u_num_itatousa2 (string a_stringa, boolean a_forceconversionifenglish)
public function string u_url_encode (string a_url, boolean a_replace_puls_sign)
public function string u_url_sep_path_by_name (ref string a_url)
public function string u_stringa_alfanum_spazio (string k_stringa)
public function string u_num_itatousa (string a_stringa)
end prototypes

public function long of_arraytostring (string as_source[], string as_delimiter, boolean ab_processempty, ref string as_ref_string);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_ArrayToString
//
//	Access:  		public
//
//	Arguments:
//	as_source[]		 The array of string to be moved into a single string.
//	as_Delimiter	 The delimeter string.
//	ab_processempty Whether to process empty string as_source members.
//	as_ref_string	 The string to be filled with the array of strings,
//						 passed by reference.
//
//	Returns:  		long
//						1 for a successful transfer.
//						-1 if a problem was found.
//
//	Description:  	Create a single string from an array of strings separated by
//						the passed delimeter.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	7.0   Initial version
//			Overloaded an existing of_arraytostring to optionally allow processing 
//			of empty string arguments.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

long		ll_Count, ll_ArrayUpBound

//Get the array size
ll_ArrayUpBound = UpperBound(as_source[])

//Check parameters
IF IsNull(as_delimiter) or (Not ll_ArrayUpBound>0) Then
	Return -1
End If

//Reset the Reference string
as_ref_string = ''

If Not ab_processempty Then
	For ll_Count = 1 to ll_ArrayUpBound
		// Do not include any entries that match an empty string 
		If as_source[ll_Count] <> '' Then
			If Len(as_ref_string) = 0 Then
				//Initialize string
				as_ref_string = as_source[ll_Count]
			else
				//Concatenate to string
				as_ref_string = as_ref_string + as_delimiter + as_source[ll_Count]
			End If
		End If
	Next 
Else
	For ll_Count = 1 to ll_ArrayUpBound
		// Include any entries that match an empty string 
		If ll_Count = 1 Then
			//Initialize string
			as_ref_string = as_source[ll_Count]
		else
			//Concatenate to string
			as_ref_string = as_ref_string + as_delimiter + as_source[ll_Count]
		End If
	Next 
End If
return 1

end function

public function long of_arraytostring (string as_source[], string as_delimiter, ref string as_ref_string);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_ArrayToString
//
//	Access:  		public
//
//	Arguments:
//	as_source[]		The array of string to be moved into a single string.
//	as_Delimiter	The delimeter string.
//	as_ref_string	The string to be filled with the array of strings,
//						passed by reference.
//
//	Returns:  		long
//						1 for a successful transfer.
//						-1 if a problem was found.
//
//	Description:  	Create a single string from an array of strings separated by
//						the passed delimeter.
//						Note: Function will not include on the single string any 
//								array entries which match an empty string.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//	7.0   Redirect to the overloaded function version, which allows optional 
//			processing of an empty string.  The default behavior is to dissallow 
//			empty string to remain backwards compatible.  Call the 4 argument 
//			version of the function if the empty string processing is desired.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

return of_arraytostring(as_source[], as_delimiter, FALSE, as_ref_string)

end function

public function string of_globalreplace (string as_source, string as_old, string as_new, boolean ab_ignorecase);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_GlobalReplace
//
//	Access:  		public
//
//	Arguments:
//	as_Source		The string being searched.
//	as_Old			The old string being replaced.
//	as_New			The new string.
// ab_IgnoreCase	A boolean stating to ignore case sensitivity.
//
//	Returns:  		string
//						as_Source with all occurrences of as_Old replaced with as_New.
//						If any argument's value is NULL, function returns NULL.
//
//	Description:  	Replace all occurrences of one string inside another with
//						a new string.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

Long	ll_Start
Long	ll_OldLen
Long	ll_NewLen
String ls_Source

//Check parameters
If IsNull(as_source) or IsNull(as_old) or IsNull(as_new) or IsNull(ab_ignorecase) Then
	string ls_null
	SetNull(ls_null)
	Return ls_null
End If

//Get the string lenghts
ll_OldLen = Len(as_Old)
ll_NewLen = Len(as_New)

//Should function respect case.
If ab_ignorecase Then
	as_old = Lower(as_old)
	ls_source = Lower(as_source)
Else
	ls_source = as_source
End If

//Search for the first occurrence of as_Old
ll_Start = Pos(ls_Source, as_Old)

Do While ll_Start > 0
	// replace as_Old with as_New
	as_Source = Replace(as_Source, ll_Start, ll_OldLen, as_New)
	
	//Should function respect case.
	If ab_ignorecase Then 
		ls_source = Lower(as_source)
	Else
		ls_source = as_source
	End If
	
	// find the next occurrence of as_Old
	ll_Start = Pos(ls_Source, as_Old, (ll_Start + ll_NewLen))
Loop

Return as_Source

end function

public function string of_globalreplace (string as_source, string as_old, string as_new);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_GlobalReplace
//
//	Access:  		public
//
//	Arguments:
//	as_Source		The string being searched.
//	as_Old			The old string being replaced.
//	as_New			The new string.
// 
//Returns:  		string
//						as_Source with all occurrences of as_Old replaced with as_New.
//						If any argument's value is NULL, function returns NULL.
//
//	Description:  	Replace all occurrences of one string inside another with
//						a new string.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

//Check parameters

If IsNull(as_source) or IsNull(as_old) or IsNull(as_new) Then
	string ls_null
	SetNull(ls_null)
	Return ls_null
End If

//The default is to ignore Case
as_Source = of_GlobalReplace (as_source, as_old, as_new, True)

Return as_Source


end function

public function boolean of_isalpha (string as_source);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_IsAlpha
//
//	Access: 			public
//
//	Arguments:
//	as_source		The source string.
//
//	Returns:  		Boolean
//						True if the string only contains alphabetic characters. 
//						If any argument's value is NULL, function returns NULL.
//
//	Description:  	Determines whether a string contains only alphabetic
//						characters.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

long		ll_count=0
long		ll_length
char		lc_char[]
integer	li_ascii

//Check parameters
If IsNull(as_source) Then
	boolean lb_null
	SetNull(lb_null)
	Return lb_null
End If

//Get the length
ll_length = Len (as_source)

//Check for at least one character
If ll_length=0 Then
	Return False
End If

//Move string into array of chars
lc_char = as_source

//Perform loop around all characters
//Quit loop if Non Alpha character is found
do while ll_count<ll_length
	ll_count ++
	
	//Get ASC code of character.
	li_ascii = Asc (lc_char[ll_count])
	
	// 'A'=65, 'Z'=90, 'a'=97, 'z'=122
	if li_ascii<65 or (li_ascii>90 and li_ascii<97) or li_ascii>122 then
		/* Character is Not an Alpha */
		Return False
	end if
loop
	
// Entire string is alpha.
return True
end function

public function boolean of_isalphanum (string as_source);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_IsAlphaNum
//
//	Access: 			public
//
//	Arguments:
//	as_source		The source string.
//
//	Returns:  		Boolean
//						True if the string only contains alphabetic and Numeric
//						characters. 
//						If any argument's value is NULL, function returns NULL.
//
//	Description:  	Determines whether a string contains only alphabetic and
//						numeric characters.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

long ll_count=0
long ll_length
char lc_char[]
integer	li_ascii

//Check parameters
If IsNull(as_source) Then
	boolean lb_null
	SetNull(lb_null)
	Return lb_null
End If

//Get the length
ll_length = Len (as_source)

//Check for at least one character
If ll_length=0 Then
	Return False
End If

//Move string into array of chars
lc_char = as_source

//Perform loop around all characters.
//Quit loop if Non Alphanemeric character is found.
do while ll_count<ll_length
	ll_count ++
	
	//Get ASC code of character.
	li_ascii = Asc (lc_char[ll_count])
	
	// '0'= 48, '9'=57, 'A'=65, 'Z'=90, 'a'=97, 'z'=122
	If li_ascii<48 or (li_ascii>57 and li_ascii<65) or &
		(li_ascii>90 and li_ascii<97) or li_ascii>122 then
		/* Character is Not an AlphaNumeric */
		Return False
	end if
loop
	
// Entire string is AlphaNumeric.
return True

end function

public function long of_parsetoarray (string as_source, string as_delimiter, ref long al_array[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_ParseToArray
//
//	Access:  public
//
//	Arguments:
//	as_Source   The string to parse.
//	as_Delimiter   The delimeter string.
//	al_array[]   The array to be filled with the parsed long, passed by reference.
//
//	Returns:  long
//	The number of elements in the array.
//	If as_Source or as_Delimeter is NULL, function returns NULL.
//
//	Description:  Parse a string into array elements using a delimeter string.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//	5.0.02   Fixed problem when delimiter is last character of string.

//	   Ref array and return code gave incorrect results.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

long		ll_DelLen, ll_Pos, ll_Count, ll_Start, ll_Length, ll_null
string 	ls_holder
	
SetNull(ll_null)	
//Check for NULL
IF IsNull(as_source) or IsNull(as_delimiter) Then
	Return ll_null
End If

//Check for at leat one entry
If Trim (as_source) = '' Then
	Return 0
End If

//Get the length of the delimeter
ll_DelLen = Len(as_Delimiter)

ll_Pos =  Pos(Upper(as_source), Upper(as_Delimiter))

//Only one entry was found
if ll_Pos = 0 then
	if isnumber(Trim(as_source)) then 
		al_array[1] = Long(Trim(as_source))
	else
		Return ll_null
	end if 
	
	return 1
end if

//More than one entry was found - loop to get all of them
ll_Count = 0
ll_Start = 1
Do While ll_Pos > 0
	
	//Set current entry
	ll_Length = ll_Pos - ll_Start
	ls_holder = Mid (as_source, ll_start, ll_length)

	// Update array and counter
	ll_Count ++
	if isnumber(Trim(ls_holder)) then 
		al_array[ll_Count] = Long(Trim(ls_holder))
	else
		Return ll_null
	end if
	//Set the new starting position
	ll_Start = ll_Pos + ll_DelLen

	ll_Pos =  Pos(Upper(as_source), Upper(as_Delimiter), ll_Start)
Loop

//Set last entry
ls_holder = Mid (as_source, ll_start, Len (as_source))

// Update array and counter if necessary
if Len (ls_holder) > 0 then
	ll_count++
	if isnumber(Trim(ls_holder)) then 
		al_array[ll_Count] = Long(Trim(ls_holder))
	else
		Return ll_null
	end if
end if

//Return the number of entries found
Return ll_Count

end function

public function long of_parsetoarray (string as_source, string as_delimiter, ref string as_array[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_ParseToArray
//
//	Access:  public
//
//	Arguments:
//	as_Source   The string to parse.
//	as_Delimiter   The delimeter string.
//	as_Array[]   The array to be filled with the parsed strings, passed by reference.
//
//	Returns:  long
//	The number of elements in the array.
//	If as_Source or as_Delimeter is NULL, function returns NULL.
//
//	Description:  Parse a string into array elements using a delimeter string.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//	5.0.02   Fixed problem when delimiter is last character of string.

//	   Ref array and return code gave incorrect results.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

long		ll_DelLen, ll_Pos, ll_Count, ll_Start, ll_Length
string 	ls_holder

//Check for NULL
IF IsNull(as_source) or IsNull(as_delimiter) Then
	long ll_null
	SetNull(ll_null)
	Return ll_null
End If

//Check for at leat one entry
If Trim (as_source) = '' Then
	Return 0
End If

//Get the length of the delimeter
ll_DelLen = Len(as_Delimiter)

ll_Pos =  Pos(Upper(as_source), Upper(as_Delimiter))

//Only one entry was found
if ll_Pos = 0 then
	as_Array[1] = Trim(as_source)
	return 1
end if

//More than one entry was found - loop to get all of them
ll_Count = 0
ll_Start = 1
Do While ll_Pos > 0
	
	//Set current entry
	ll_Length = ll_Pos - ll_Start
	ls_holder = Mid (as_source, ll_start, ll_length)

	// Update array and counter
	ll_Count ++
	as_Array[ll_Count] = Trim(ls_holder)
	
	//Set the new starting position
	ll_Start = ll_Pos + ll_DelLen

	ll_Pos =  Pos(Upper(as_source), Upper(as_Delimiter), ll_Start)
Loop

//Set last entry
ls_holder = Mid (as_source, ll_start, Len (as_source))

// Update array and counter if necessary
if Len (ls_holder) > 0 then
	ll_count++
	as_Array[ll_Count] = Trim(ls_holder)
end if

//Return the number of entries found
Return ll_Count

end function

public function long of_lastpos (string as_source, string as_target, long al_start);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_LastPos	
//
//	Access:  		public
//
//	Arguments:
//	as_Source		The string being searched.
//	as_Target		The being searched for.
//	al_start			The starting position, 0 means start at the end.
//
//	Returns:  		Long	
//						The position of as_Target.
//						If as_Target is not found, function returns a 0.
//						If any argument's value is NULL, function returns NULL.
//
//	Description: 	Search backwards through a string to find the last occurrence 
//						of another string.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

Long	ll_Cnt, ll_Pos

//Check for Null Parameters.
IF IsNull(as_source) or IsNull(as_target) or IsNull(al_start) Then
	SetNull(ll_Cnt)
	Return ll_Cnt
End If

//Check for an empty string
If Len(as_Source) = 0 Then
	Return 0
End If

// Check for the starting position, 0 means start at the end.
If al_start=0 Then  
	al_start=Len(as_Source)
End If

//Perform find
For ll_Cnt = al_start to 1 Step -1
	ll_Pos = Pos(as_Source, as_Target, ll_Cnt)
	If ll_Pos = ll_Cnt Then 
		//String was found
		Return ll_Cnt
	End If
Next

//String was not found
Return 0

end function

public function long of_lastpos (string as_source, string as_target);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_LastPos	
//
//	Access:  		public
//
//	Arguments:
//	as_Source		The string being searched.
//	as_Target		The string being searched for.
//
//	Returns:  		Long	
//						The position of as_Target.
//						If as_Target is not found, function returns a 0.
//						If any argument's value is NULL, function returns NULL.
//
//	Description:  Search backwards through a string to find the last occurrence of another string
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

//Check for Null Parameters.
IF IsNull(as_source) or IsNull(as_target) Then
	Long ll_null
	SetNull(ll_null)
	Return ll_null
End If

//Set the starting position and perform the search
Return of_LastPos (as_source, as_target, Len(as_Source))

end function

public function string of_quote (string as_source);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_Quote
//
//	Access: 			public
//
//	Arguments:
//	as_source		The source string.
//
//	Returns:  		String
//						The original string enclosed in quotations.
//						If any argument's value is NULL, function returns NULL.
//
//	Description:  	Enclose the original string in quotations.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

//Check parameters
If IsNull(as_source) Then
	Return as_source
End If

// Enclosed original string in quotations.
return '"' + as_source + '"'

end function

public function string u_stringa_compatta (string k_stringa);//
//--- restituisce campo stringa compattato senza caratteri speciali ovvero ad es. "mia sorella_matta" diventa "miasorellamatta" 
//--- tipo .'/|\*spazio~'a capo come ~n o ~r o ~t"
//
string k_return_stringa=""
int k_ind, k_len

		k_len = len(k_stringa)
		for k_ind = 1 to k_len
			 if mid(k_stringa, k_ind, 1) = " " or mid(k_stringa, k_ind, 1) = "\" or mid(k_stringa, k_ind, 1) =  "/" or mid(k_stringa, k_ind, 1) = "." or mid(k_stringa, k_ind, 1) = "," &
			     or mid(k_stringa, k_ind, 1) = "*" or mid(k_stringa, k_ind, 1) = "_" or mid(k_stringa, k_ind, 1) = "|" &
			     or mid(k_stringa, k_ind, 1) = "(" or mid(k_stringa, k_ind, 1) = ")" or mid(k_stringa, k_ind, 1) = "["  or mid(k_stringa, k_ind, 1) = "]" then
			else
				if k_ind < k_len then
					if mid(k_stringa, k_ind, 2) =  "~~" or mid(k_stringa, k_ind, 2) = "~t" or mid(k_stringa, k_ind, 2) = "~r" or mid(k_stringa, k_ind, 2) = "~n" or mid(k_stringa, k_ind, 2) = "~"" then
					else
						k_return_stringa += mid(k_stringa, k_ind, 1) 
					end if
				else
					k_return_stringa += mid(k_stringa, k_ind, 1) 
				end if
			end if
		next

return k_return_stringa

end function

public function string u_stringa_pulisci_asc (string ka_stringa);//
//--- restituisce campo stringa con solo caratteri alfabetici e numeri e qualche altro carattere stampabile
//--- toglie tutto il resto
//
string k_return_stringa = ""
boolean k_forza_spazio=false
string k_char_ok[] = {" ","{","a","b","c","d","e","f","g","h","k","i","j","l","m","n","o","p" &
							,"q","r","s","t","u","v","w","x","y","z","A","B","C","D","E","F","G","H" &
							,"K","I","J","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z" &
							,"1","2","3","4","5","6","7","8","9","0","è","ò","à","ì","ù",".",",",";",":","*" &
							,"-","+","'","!","%","&","/","?","@","#","(",")","[","]","€","$","£","=","^","<",">","}"}
int k_item, k_item_tot, k_len_stringa, k_item_len
boolean k_char_scrivi = false


	if trim(ka_stringa) = "" then return ""

	k_len_stringa = len(trim(ka_stringa))
	k_item_tot = upperbound(k_char_ok[])
	
	for k_item_len = 1 to k_len_stringa
		
//--- cerca se il carattere è ok		
		k_char_scrivi = false
//--- se è un semplice spazio salto il controllo ed è subito OK		
		if mid(ka_stringa,k_item_len,1) =  " " then 
			k_char_scrivi = true
		else
			k_item = 1
			do while not k_char_scrivi and k_item < k_item_tot  
				if mid(ka_stringa,k_item_len,1) =  k_char_ok[k_item] then
					k_char_scrivi = true
				else
					k_item ++
				end if
			loop
		end if
		
//--- se ok popolo char x char la stringa di ritorno		
		if k_char_scrivi then 
			k_return_stringa += mid(ka_stringa,k_item_len,1)
			if mid(ka_stringa,k_item_len,1) = " " then
				k_forza_spazio = true
			else
				k_forza_spazio = false
			end if
		else
//--- se char non consentito mette uno spazio ma solo se e' il primo (non a spazi consecutivi)
			if not k_forza_spazio then k_return_stringa += " "
			k_forza_spazio = true
		end if
	end for
	

return trim(k_return_stringa)

end function

public function string u_stringa_cmpnovocali (string a_stringa);//
//--- restituisce campo stringa compattato con solo CONSONANTI o NUMERI ad es. "mia Sorella_Matta_3" diventa "msrllmtt3" 
//--- toglie anche i char spaciali come ~n o ~r o ~t"
//
string k_stringa
string k_return_stringa=""
int k_ind, k_len


		k_stringa = lower(trim(a_stringa))
		k_len = len(a_stringa)
		for k_ind = 1 to k_len
			if match(upper(mid(k_stringa, k_ind, 1)), '[^BCDFGHJLMNPQRSTVWXYZ0-9]') then  // diverso da CONSONANTI e 0-9
			else
				if k_ind < k_len then
					if mid(k_stringa, k_ind, 2) =  "~~" or mid(k_stringa, k_ind, 2) = "~t" or mid(k_stringa, k_ind, 2) = "~r" or mid(k_stringa, k_ind, 2) = "~n" or mid(k_stringa, k_ind, 2) = "~"" then
					else
						k_return_stringa += mid(k_stringa, k_ind, 1) 
					end if
				else
					k_return_stringa += mid(k_stringa, k_ind, 1) 
				end if
			end if
		next

return k_return_stringa

end function

public function string u_stringa_alfa (string k_stringa);//
//--- restituisce campo con solo char alfabetici 
//--- esempio  'pippo 027 / 5 pluto '    torna   'pippo pluto'
//
string k_return_stringa = ""
int k_start_pos
boolean k_space = false, k_ok = true


	k_stringa = trim(k_stringa)
	for k_start_pos = 1 to len(k_stringa) 
		
		choose case mid(k_stringa, k_start_pos, 1)
			case "a" to "z" & 
				 ,"è" to "à", "ù", "ì", "ò" & 
				 ,"A" to "Z" &
				 ," "
				if mid(k_stringa, k_start_pos, 1) = " " then
					if k_space then
						k_ok = false
					else
						k_space = true
					end if
				else
					k_ok = true
					k_space = false
				end if
				if k_ok then
					k_return_stringa += mid(k_stringa, k_start_pos, 1) 
				end if
		end choose
		
	next
	
return trim(k_return_stringa)
			

end function

public function string u_stringa_tonome (string k_stringa);//
//--- restituisce campo stringa molto commpresso e dovrebbe assomigliare a un nome
//--- toglie i caratteri speciale spazi, '_' e numeri
//
string k_return_stringa
string k_old_str, k_new_str
int k_start_pos

	k_stringa = u_stringa_pulisci_nomefunzione(k_stringa) 	// se contiene il nome della funzione tra <...> la rimuovo
	k_stringa = u_stringa_compatta(k_stringa)
	k_return_stringa = u_stringa_pulisci(k_stringa) // u_stringa_alfa(k_stringa)

return k_return_stringa

end function

public function string u_stringa_spezza (string k_stringa);//
//--- restituisce campo stringa con uno spazio tra parole troppo lunghe (ogni 24 char) spezza dove trova un '-' o simile 
//---     es. "31482203-31482201-31482204-31482205-31482202-31482206-31482207-31482208-31483780-31483781-31483779-31483783-31483782" 
//---     diventa
//---         "31482203-31482201-31482204- 31482205-31482202-31482206- 31482207-31482208-31483780- 31483781-31483779-31483783- 31483782" 
//--- tipo .'/|\*spazio~'a capo come ~n o ~r o ~t"
//
string k_return_stringa, k_char
int k_ind, k_len, k_cntr


	k_len = len(k_stringa)
	for k_ind = 1 to k_len
		k_char = mid(k_stringa, k_ind, 1)
		if k_char = " " then
			k_cntr = 0 	
		else
			k_cntr ++
		end if
		if k_cntr >= 24 then
			if k_char = "-" &
					or k_char = "\" or k_char =  "/" or k_char = "." or k_char = "," &
					or k_char = "*" or k_char = "_" or k_char = "|" &
					or k_char = "(" or k_char = ")" or k_char = "["  or k_char = "]" then
					
				k_cntr = 0 	
				k_char += " " // SPEZZA: aggiungo il carattere SPAZIO
				
			end if
		end if
		
		k_return_stringa += k_char   // aggiungo un carattere alla volta
		
	next

return k_return_stringa

end function

public function string u_replace (string k_str, string k_str_old, string k_str_new);//
//--- ricopre nella stringa str i caratteri char_old con char 
//

return u_string_replace(k_str, k_str_old, k_str_new)

end function

public function string u_stringa_pulisci (string k_stringa);//
//--- restituisce campo stringa senza caratteri speciali
//--- i caratteri:  .'/|\:*spazio~~ e gli  'a capo' come: ~n o ~r o ~t"  diventano: "_", mentre: [(])+-~  li toglie
//
string k_return_stringa
string k_old_str, k_new_str
long k_start_pos

		k_return_stringa = k_stringa
		k_start_pos = 1
		k_old_str = " "
		k_new_str = "_"
		k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
		DO WHILE k_start_pos > 0
			 k_return_stringa = ReplaceA(k_return_stringa, k_start_pos, len(k_old_str), k_new_str)
			 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+len(k_new_str))
		LOOP
		k_start_pos = 1
		k_old_str = ":"
		k_new_str = "_"
		k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
		DO WHILE k_start_pos > 0
			 k_return_stringa = ReplaceA(k_return_stringa, k_start_pos, len(k_old_str), k_new_str)
			 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+len(k_new_str))
		LOOP
		k_start_pos = 1
		k_old_str = "\"
		k_new_str = "_"
		k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
		DO WHILE k_start_pos > 0
			 k_return_stringa = ReplaceA(k_return_stringa, k_start_pos, len(k_old_str), k_new_str)
			 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+len(k_new_str))
		LOOP
		k_start_pos = 1
		k_old_str = "/"
		k_new_str = "_"
		k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
		DO WHILE k_start_pos > 0
			 k_return_stringa = ReplaceA(k_return_stringa, k_start_pos, len(k_old_str), k_new_str)
			 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+len(k_new_str))
		LOOP
		k_start_pos = 1
		k_old_str = "."
		k_new_str = "_"
		k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
		DO WHILE k_start_pos > 0
			 k_return_stringa = ReplaceA(k_return_stringa, k_start_pos, len(k_old_str), k_new_str)
			 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+len(k_new_str))
		LOOP
		k_start_pos = 1
		k_old_str = ","
		k_new_str = "_"
		k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
		DO WHILE k_start_pos > 0
			 k_return_stringa = ReplaceA(k_return_stringa, k_start_pos, len(k_old_str), k_new_str)
			 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+len(k_new_str))
		LOOP
		k_start_pos = 1
		k_old_str = "*"
		k_new_str = "_"
		k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
		DO WHILE k_start_pos > 0
			 k_return_stringa = ReplaceA(k_return_stringa, k_start_pos, len(k_old_str), k_new_str)
			 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+len(k_new_str))
		LOOP
		k_start_pos = 1
		k_old_str = "'"
		k_new_str = "_"
		k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
		DO WHILE k_start_pos > 0
			 k_return_stringa = ReplaceA(k_return_stringa, k_start_pos, len(k_old_str), k_new_str)
			 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+len(k_new_str))
		LOOP
		k_start_pos = 1
		k_old_str = "|"
		k_new_str = "_"
		k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
		DO WHILE k_start_pos > 0
			 k_return_stringa = ReplaceA(k_return_stringa, k_start_pos, len(k_old_str), k_new_str)
			 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+len(k_new_str))
		LOOP
		k_start_pos = 1
		k_old_str = "~~"
		k_new_str = "_"
		k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
		DO WHILE k_start_pos > 0
			 k_return_stringa = ReplaceA(k_return_stringa, k_start_pos, len(k_old_str), k_new_str)
			 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+len(k_new_str))
		LOOP
		k_start_pos = 1
		k_old_str = "~t"
		k_new_str = "_"
		k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
		DO WHILE k_start_pos > 0
			 k_return_stringa = ReplaceA(k_return_stringa, k_start_pos, len(k_old_str), k_new_str)
			 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+len(k_new_str))
		LOOP
		k_start_pos = 1
		k_old_str = "~r"
		k_new_str = "_"
		k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
		DO WHILE k_start_pos > 0
			 k_return_stringa = ReplaceA(k_return_stringa, k_start_pos, len(k_old_str), k_new_str)
			 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+len(k_new_str))
		LOOP
		k_start_pos = 1
		k_old_str = "~n"
		k_new_str = "_"
		k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
		DO WHILE k_start_pos > 0
			 k_return_stringa = ReplaceA(k_return_stringa, k_start_pos, len(k_old_str), k_new_str)
			 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+len(k_new_str))
		LOOP
		k_start_pos = 1
		k_old_str = "~""
		k_new_str = ""
		k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
		DO WHILE k_start_pos > 0
			 k_return_stringa = ReplaceA(k_return_stringa, k_start_pos, len(k_old_str), k_new_str)
			 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+len(k_new_str))
		LOOP
		k_start_pos = 1
		k_old_str = "("
		k_new_str = ""
		k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
		DO WHILE k_start_pos > 0
			 k_return_stringa = ReplaceA(k_return_stringa, k_start_pos, len(k_old_str), k_new_str)
			 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+len(k_new_str))
		LOOP
		k_start_pos = 1
		k_old_str = ")"
		k_new_str = ""
		k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
		DO WHILE k_start_pos > 0
			 k_return_stringa = ReplaceA(k_return_stringa, k_start_pos, len(k_old_str), k_new_str)
			 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+len(k_new_str))
		LOOP
		k_start_pos = 1
		k_old_str = "["
		k_new_str = ""
		k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
		DO WHILE k_start_pos > 0
			 k_return_stringa = ReplaceA(k_return_stringa, k_start_pos, len(k_old_str), k_new_str)
			 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+len(k_new_str))
		LOOP
		k_start_pos = 1
		k_old_str = "]"
		k_new_str = ""
		k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
		DO WHILE k_start_pos > 0
			 k_return_stringa = ReplaceA(k_return_stringa, k_start_pos, len(k_old_str), k_new_str)
			 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+len(k_new_str))
		LOOP
		k_start_pos = 1
		k_old_str = "+"
		k_new_str = ""
		k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
		DO WHILE k_start_pos > 0
			 k_return_stringa = ReplaceA(k_return_stringa, k_start_pos, len(k_old_str), k_new_str)
			 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+len(k_new_str))
		LOOP
		k_start_pos = 1
		k_old_str = "-"
		k_new_str = ""
		k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
		DO WHILE k_start_pos > 0
			 k_return_stringa = ReplaceA(k_return_stringa, k_start_pos, len(k_old_str), k_new_str)
			 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+len(k_new_str))
		LOOP
		k_start_pos = 1
		k_old_str = "<"
		k_new_str = ""
		k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
		DO WHILE k_start_pos > 0
			 k_return_stringa = ReplaceA(k_return_stringa, k_start_pos, len(k_old_str), k_new_str)
			 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+len(k_new_str))
		LOOP
		k_start_pos = 1
		k_old_str = ">"
		k_new_str = ""
		k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
		DO WHILE k_start_pos > 0
			 k_return_stringa = ReplaceA(k_return_stringa, k_start_pos, len(k_old_str), k_new_str)
			 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+len(k_new_str))
		LOOP

return k_return_stringa

end function

public function string u_stringa_pulisci_x_msg (string k_stringa);//
//--- restituisce campo stringa senza caratteri speciale x fare Display
//--- toglie:  '|~ mentre gli 'a capo' come ~n o ~r o ~t diventano spazio
//
string k_return_stringa
string k_old_str, k_new_str
long k_start_pos

		k_return_stringa = k_stringa
//		k_start_pos = 1
//		k_old_str = " "
//		k_new_str = "_"
//		k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
//		DO WHILE k_start_pos > 0
//			 k_return_stringa = ReplaceA(k_return_stringa, k_start_pos, len(k_old_str), k_new_str)
//			 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+len(k_new_str))
//		LOOP
//		k_start_pos = 1
//		k_old_str = "\"
//		k_new_str = "_"
//		k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
//		DO WHILE k_start_pos > 0
//			 k_return_stringa = ReplaceA(k_return_stringa, k_start_pos, len(k_old_str), k_new_str)
//			 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+len(k_new_str))
//		LOOP
//		k_start_pos = 1
//		k_old_str = "/"
//		k_new_str = "_"
//		k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
//		DO WHILE k_start_pos > 0
//			 k_return_stringa = ReplaceA(k_return_stringa, k_start_pos, len(k_old_str), k_new_str)
//			 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+len(k_new_str))
//		LOOP
//		k_start_pos = 1
//		k_old_str = "."
//		k_new_str = "_"
//		k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
//		DO WHILE k_start_pos > 0
//			 k_return_stringa = ReplaceA(k_return_stringa, k_start_pos, len(k_old_str), k_new_str)
//			 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+len(k_new_str))
//		LOOP
//		k_start_pos = 1
//		k_old_str = ","
//		k_new_str = "_"
//		k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
//		DO WHILE k_start_pos > 0
//			 k_return_stringa = ReplaceA(k_return_stringa, k_start_pos, len(k_old_str), k_new_str)
//			 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+len(k_new_str))
//		LOOP
//		k_start_pos = 1
//		k_old_str = "*"
//		k_new_str = "_"
//		k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
//		DO WHILE k_start_pos > 0
//			 k_return_stringa = ReplaceA(k_return_stringa, k_start_pos, len(k_old_str), k_new_str)
//			 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+len(k_new_str))
//		LOOP
		k_start_pos = 1
		k_old_str = "~t"
		k_new_str = " "
		k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
		DO WHILE k_start_pos > 0
			 k_return_stringa = ReplaceA(k_return_stringa, k_start_pos, len(k_old_str), k_new_str)
			 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+len(k_new_str))
		LOOP
		k_start_pos = 1
		k_old_str = "~r"
		k_new_str = " "
		k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
		DO WHILE k_start_pos > 0
			 k_return_stringa = ReplaceA(k_return_stringa, k_start_pos, len(k_old_str), k_new_str)
			 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+len(k_new_str))
		LOOP
		k_start_pos = 1
		k_old_str = "~n"
		k_new_str = " "
		k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
		DO WHILE k_start_pos > 0
			 k_return_stringa = ReplaceA(k_return_stringa, k_start_pos, len(k_old_str), k_new_str)
			 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+len(k_new_str))
		LOOP

		k_start_pos = 1
		k_old_str = "'"
		k_new_str = ""
		k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
		DO WHILE k_start_pos > 0
			 k_return_stringa = ReplaceA(k_return_stringa, k_start_pos, len(k_old_str), k_new_str)
			 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+len(k_new_str))
		LOOP
		k_start_pos = 1
		k_old_str = "|"
		k_new_str = ""
		k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
		DO WHILE k_start_pos > 0
			 k_return_stringa = ReplaceA(k_return_stringa, k_start_pos, len(k_old_str), k_new_str)
			 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+len(k_new_str))
		LOOP
		k_start_pos = 1
		k_old_str = "~""
		k_new_str = ""
		k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
		DO WHILE k_start_pos > 0
			 k_return_stringa = ReplaceA(k_return_stringa, k_start_pos, len(k_old_str), k_new_str)
			 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+len(k_new_str))
		LOOP

return k_return_stringa

end function

public function string u_stringa_numeri (string k_stringa);//
//--- restituisce campo con solo i numeri 
//--- esempio  'fabio 027 / 5'    torna   '0275'
//
string k_return_stringa = ""
int k_start_pos

	for k_start_pos = 1 to len(k_stringa) 
		
		choose case mid(k_stringa, k_start_pos, 1)
			case "0" to "9"
				k_return_stringa += mid(k_stringa, k_start_pos, 1) 
		end choose
	next
	
return k_return_stringa		
			

end function

public function string u_stringa_pulisci_nomefunzione (string k_stringa);//
//--- restituisce campo stringa senza il nome della funzione 
//--- esempio "<pl_barcode_l> Elenco piani di lavoro"   diventa  "Elenco piani di lavoro"
//
string k_return
int k_pos_ini, k_pos_fin


	k_return = k_stringa
	k_pos_ini = pos(k_return, "<", 1)
	if k_pos_ini > 0 then
		k_pos_fin = pos(k_return, ">", k_pos_ini)
		if k_pos_fin > 0 then
			k_return = trim(ReplaceA(k_return, k_pos_ini, k_pos_fin - k_pos_ini + 1, ""))
		end if
	end if
		
return k_return

end function

public function string u_stringa_alfanum (string k_stringa);//
//--- restituisce campo con solo char alfabetici o numerici
//--- esempio  'fabio 027 / 5'    torna   'fabio027'
//
string k_return_stringa = ""
int k_start_pos

	for k_start_pos = 1 to len(k_stringa) 
		
		choose case mid(k_stringa, k_start_pos, 1)
			case "a" to "z" & 
				 ,"A" to "Z" & 
				 ,"0" to "9"
				k_return_stringa += mid(k_stringa, k_start_pos, 1) 
		end choose
	next
	
return k_return_stringa		
			

end function

public function string u_string_replace (string k_string, readonly string k_str_old, readonly string k_str_new);//
//--- restituisce campo stringa con uno o più caratteri ricoperti
//--- inp: stringa da ricoprire
//---      vecchio carattere
//---      nuovo carattere
//
long k_pos=1
long k_len, k_len_in


if k_str_old <> k_str_new then

	k_len = len(k_str_new)
	k_len_in = len(k_str_old)
	
	k_pos = pos(k_string, k_str_old, k_pos)
	do while k_pos > 0 
		
		k_string = replace(k_string, k_pos, k_len_in, k_str_new)
		k_pos += k_len
		k_pos = pos(k_string, k_str_old, k_pos)
		
	loop
	
end if

return k_string

end function

public function integer u_findwindow (unsignedlong k_classe, string k_window);//
ulong k_return=0
environment k_env


	if getenvironment(k_env) = 1 then

//=== Win a 32 bit
		k_return = FindWindowA (k_classe, k_window)
		
	else
		k_return = 0
	end if		
	
return k_return



end function

public function integer u_stringa_split (ref string a_string[], string a_sep);/*
 Splitta in diverse stringhe separate da un carattere
     inp: array a_string[1] il primo elemento è la stringa da separare 
	     : carattere separatore come ad esempio "," ";" ":"....
     out: array a_string[] con i tronconi
	  Ret: numero di spezzoni
*/
string k_string
int k_str_split_idx
long k_pos, k_i, k_len_sep


	if upperbound(a_string[]) = 0 then return 0
	if trim(a_string[1]) > " " then
	else 
		return 0 
	end if

	k_string = trim(a_string[1])

	a_string[1] = ""

	k_len_sep = len(a_sep)

//--- se manca aggiunge il char separatore alla fine 
	if right(k_string, k_len_sep) <> a_sep then k_string += a_sep 

	k_i = 1
	k_pos = pos(k_string, a_sep, k_i)
	do while k_pos > 0
		k_str_split_idx ++
		a_string[k_str_split_idx] = mid(k_string, k_i, k_pos - k_i) 
			
		k_i = k_pos + k_len_sep
		k_pos = pos(k_string, a_sep, k_i)
		
	loop
	
	if k_str_split_idx > 0 then
		if k_i < len(k_string) then 
			k_str_split_idx ++
			a_string[k_str_split_idx] = mid(k_string, k_i, len(k_string) - k_i + 1) 
		end if
	end if

return k_str_split_idx

end function

public function string u_num_itatousa2 (string a_stringa, boolean a_forceconversionifenglish);/*
   Campo numerico da formato ITA a USA
   input: il numero da convertire + TRUE se forzare conversione anche se già il pc è impostato in inglese
   Out: il numero convertito
   esempio  '-1.127.123,75'    torna   '-1,127,123.75'
*/
string k_return = ""
string k_return_stringa = "", k_stringa, k_segno = ""
int k_start_pos, k_len
boolean k_virgola_trovata=false, k_converti = false


//--- se è in amb ENG allora non converte 
	if a_forceconversionifenglish then
		k_converti = true
	else
		//k_stringa = string(1.2, "0.0")
		if string(1.2, "0.0") = "1,2" then
			k_converti = true  // ITA sono settato come separatore decimale con la virgola
		end if
	end if
		
	if k_converti then
		k_stringa = trim(a_stringa)
		k_len = len(k_stringa)
	
		for k_start_pos = k_len to 1 step -1  
			
			choose case mid(k_stringa, k_start_pos, 1)
				case "0" to "9"
					k_return_stringa = mid(k_stringa, k_start_pos, 1) + k_return_stringa
				case ","
					if not k_virgola_trovata then
						k_virgola_trovata=true
						k_return_stringa = "." + k_return_stringa
					end if
				case "-", "+"
					if k_segno > " " then
					else
						k_segno = mid(k_stringa, k_start_pos, 1)
					end if
				case "."
					k_virgola_trovata=true    // non posso trovare una virgola dopo un punto delle migliaia, ovviamente
					k_return_stringa = "," + k_return_stringa
			end choose
		next
		k_return_stringa = k_segno + k_return_stringa
	else
		k_return_stringa = trim(a_stringa)
	end if
	
return k_return_stringa		
			

end function

public function string u_url_encode (string a_url, boolean a_replace_puls_sign);/*
 Codifica URL 
 Inp: url da decodificare
      TRUE = per sostituire il '+' con '%20' che sembra più corretto nella maggior parte dei casi  
*/

Blob k_blob
String k_url_encode

k_blob = Blob(a_url, EncodingUTF8!) //, EncodingANSI!)

CoderObject lnv_CoderObject
lnv_CoderObject = Create CoderObject

k_url_encode = lnv_CoderObject.UrlEncode(k_blob)

if a_replace_puls_sign then
	
	k_url_encode = u_replace( k_url_encode, "+", "%20")
	
end if

return k_url_encode
end function

public function string u_url_sep_path_by_name (ref string a_url);/*
  Separa dal URL il path dal nome 
  Inp: url completo
  Out: url senza nome
  Ret: nome file
*/
string k_return_name
string k_trova_str
int k_start_pos, k_pos


		a_url = trim(a_url)
		k_start_pos = 1
		k_pos = 1
		k_trova_str = "/"
		k_start_pos = pos(a_url, k_trova_str, k_start_pos)
		DO WHILE k_start_pos > 0
			k_pos = k_start_pos + 1
			k_start_pos = pos(a_url, k_trova_str, k_pos )
		LOOP

		k_return_name = trim(mid(a_url, k_pos, len(a_url) - k_pos + 1))
		a_url = trim(left(a_url, k_pos - 1))

return k_return_name

end function

public function string u_stringa_alfanum_spazio (string k_stringa);/*
	Restituisce campo con solo char alfabetici, numerici + spazio (o'_' che diventa spazio)
										+ lettere accentate
		esempio  fabio 027 / 5_cinque    --->   'fabio 027 5 cinque'
*/
string k_return_stringa = ""
int k_start_pos

	for k_start_pos = 1 to len(k_stringa) 
		
		choose case mid(k_stringa, k_start_pos, 1)
			case "a" to "z" & 
				 ,"è" to "à", "ù", "ì", "ò" & 
				 ,"A" to "Z" & 
				 ,"0" to "9" &
				 ," " &
				 ,"_" 
				if mid(k_stringa, k_start_pos, 1) = "_" then 
					k_return_stringa += " "
				else
					k_return_stringa += mid(k_stringa, k_start_pos, 1) 
				end if
		end choose
	next
	
return k_return_stringa		
			

end function

public function string u_num_itatousa (string a_stringa);/*
 restituisce campo stringa con numero DECIMALE da formato ITALIA a USA 
 	inp: stringa numero italiano es. '12,50' 
	out: stringa numero formato USA es. '12.50' 
 
 ATTENZIONE:
 		esempio: '12,50' 		--> '12.50'		OK!
					'1.237' 		--> '1.237'   	ERRORE...		 
					'1.237,00' 	--> '1237.00'  OK!
					'A41C,A7'   --> '41.7'     ERRORE??
 
*/
string k_return_stringa
//string k_old_str, k_new_str
//int k_start_pos
string k_str, k_char
int k_len, k_i
boolean k_p

	k_str = trim(a_stringa)
	k_len = len(a_stringa)
	
	for k_i = k_len to 1 step -1
		k_char = mid(k_str, k_i, 1)
		choose case true
			case k_char = '.' &
				 ,k_char = ',' 
				if not k_p then
					k_p = true
					k_return_stringa = "." + k_return_stringa
				end if

			case isnumber(k_char)
				k_return_stringa = k_char + k_return_stringa
				
		end choose
	next
		
//		k_return_stringa = k_stringa
//		k_start_pos = 1
//		k_old_str = ","
//		k_new_str = "."
//		k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos)
//		DO WHILE k_start_pos > 0
//			 k_return_stringa = ReplaceA(k_return_stringa, k_start_pos, len(k_old_str), k_new_str)
//			 k_start_pos = pos(k_return_stringa, k_old_str, k_start_pos+len(k_new_str))
//		LOOP

return k_return_stringa

end function

on n_string.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_string.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

