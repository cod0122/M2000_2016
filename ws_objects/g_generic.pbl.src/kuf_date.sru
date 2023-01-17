$PBExportHeader$kuf_date.sru
forward
global type kuf_date from nonvisualobject
end type
end forward

global type kuf_date from nonvisualobject
end type
global kuf_date kuf_date

forward prototypes
public function date u_data_get_lastmonthday (date a_date)
private function datetime u_datetime_after (datetime a_datetime, long a_time, string a_datepart)
public function date u_datetime_after_ddnowe (date a_date, integer a_dd)
public function datetime u_datetime_after_hour (datetime a_datetime, long a_nr_hour)
public function datetime u_datetime_after_minute (datetime a_datetime, long a_nr_minute)
end prototypes

public function date u_data_get_lastmonthday (date a_date);//
//---- torna data con l'ultimo giorno del mese es. 20/10/2018 --> 31/10/2018 
//
date k_return
int li_month, li_year

li_month = Month(a_date)
li_year = year(a_date)

IF li_month < 12 THEN
   li_month ++
ELSE
   li_month = 1
   li_year ++
END IF

// build a new date
k_return = date(li_year,li_month,1)
// extract the last day of the previous month
k_return = RelativeDate(k_return, -1)


return k_return
end function

private function datetime u_datetime_after (datetime a_datetime, long a_time, string a_datepart);//
//--- Calcola un datetime add o sub minuti
//
//f_datetime_after (datetime a_datetime, long, a_time, string a_datepart)  
  
//returns the datetime after a set interval from a starting datetime  
//cannot use powerbuilder since it cannot span days  
// valid dateparts are:  
/*Year  
quarter  
month  
dayofyear  
day  
week  
weekday  
hour  
minute  
second  
millisecond  
microsecond  
nanosecond*/  
string ls_sql  
datetime ldt_end  


if isnull(a_datetime) or isnull(a_time) or isnull(a_datepart)  then
	return datetime(date(0), time(0))
else
	
	DECLARE get_diff DYNAMIC CURSOR FOR SQLSA ;  
	// Calculate the end date  
	ls_sql = 'SELECT DATEADD(' + a_datepart + ', ' + string(a_time) +  ", '" + string(a_datetime) + "')"  
	PREPARE SQLSA FROM :ls_sql ;  
	OPEN DYNAMIC get_diff ;  
	FETCH get_diff INTO :ldt_end ;  
	CLOSE get_diff ;  
	RETURN ldt_end  
end if
end function

public function date u_datetime_after_ddnowe (date a_date, integer a_dd);//
//--- Calcola un datetime add o sub in giorni lavorativi
//
int k_dd, k_ctr, k_day_segno = 1
string ls_sql  
date k_return, k_date 


	if isnull(a_date) or isnull(a_dd)   then
		return date(0)
	end if
	if a_dd = 0   then
		return a_date
	end if

	if a_dd < 0 then 
		a_dd = a_dd * -1   //cmq lavoro sul dato positivo
		k_day_segno = -1
	end if
		
	k_date = a_date
	
	k_ctr = 0
	do 
		
		k_date = relativedate(k_date, k_day_segno) 
		k_dd = dayNumber (k_date) 
		if k_dd = 1 or k_dd  = 7 then  // week-end
		else  // gg feriale 
			k_ctr ++
		end if
		
	loop while k_ctr < a_dd
		
	k_return = k_date
	

return k_return
end function

public function datetime u_datetime_after_hour (datetime a_datetime, long a_nr_hour);//
//--- Calcola un datetime add o sub minuti
//
datetime k_return


k_return = u_datetime_after(a_datetime, a_nr_hour, "hour")


return k_return 
  
end function

public function datetime u_datetime_after_minute (datetime a_datetime, long a_nr_minute);//
//--- Calcola un datetime add o sub minuti
//
datetime k_return


k_return = u_datetime_after(a_datetime, a_nr_minute, "minute")


return k_return 
  
end function

on kuf_date.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_date.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

