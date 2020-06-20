<cfif isdefined("form.startdate") and #form.startdate# is not ''>
<cfset pos = #find("/",form.startdate)#>
<cfif #pos# is 2>
<cfset m = #left(form.startdate,1)#>
<cfelse>
<cfset m = #left(form.startdate,2)#>
</cfif>
<cfset y = #right(form.startdate,4)#>
<cfset startdate = #m# &'/'&'1'&'/'&#y#>
</cfif>
<cfif isdefined("form.enddate") and #form.enddate# is not ''>
<cfset pos2 = #find("/",form.enddate)#>
<cfif #pos2# is 2>
<cfset mm = #left(form.enddate,1)#>
<cfelse>
<cfset mm = #left(form.enddate,2)#>
</cfif>
<cfset yy = #right(form.enddate,4)#>
<cfset enddate = #mm# &'/'&'1'&'/'&#yy#>
</cfif>
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="checkActivity">
	
	select activity 
	from paidMedia
	where activity = '#form.oldrpt#'
	and userid = '#form.rptuserid#'
	and month2= '#form.month#'		
	and year2= '#form.year#'		
</cfquery>

<cfif checkActivity.recordCount EQ 0>
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="insertNewRecord">
	
	insert into paidMedia
	(userid, activity, month2, year2)
	values('#form.rptuserid#', '#form.oldRpt#', '#form.month#', '#form.year#'	)
</cfquery>


</cfif>
<cfif isDefined("form.focus1") or isDefined("form.focus2") or isDefined("form.focus3") or isDefined("form.focus4") or isDefined("form.focus5") or isDefined("form.focus6") or isDefined("form.focus7") or isDefined("form.focus8") or isDefined("form.focus9") or isDefined("form.focus10")>
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="resetrecord">
	update paidMedia
set focus1=0, 
focus2=0,
focus3=0,
focus4=0,
focus5=0,
focus6=0,
focus7=0,
focus8=0,
focus9=0,
focus10=0

where activity = '#form.oldRpt#'
	and userid = '#form.rptuserid#'
	and month2= '#form.month#'		
	and year2= '#form.year#'		
	

</cfquery>
</cfif>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="updateRecord">
update paidMedia
	set revStart = '#startDate#',
RevEnd = '#endDate#',
status = '#form.actstatus#',
note = '#form.changedDates#',
statewide='#form.statewide#',
<cfif isDefined("form.focus1") and form.focus1 EQ "1">focus1 = 1,</cfif>
<cfif isDefined("form.focus2") and form.focus2 EQ "1">focus2 = 1,</cfif>
<cfif isDefined("form.focus3") and form.focus3 EQ "1">focus3 = 1,</cfif>
<cfif isDefined("form.focus4") and form.focus4 EQ "1">focus4 = 1,</cfif>
<cfif isDefined("form.focus5") and form.focus5 EQ "1">focus5 = 1,</cfif>
<cfif isDefined("form.focus6") and form.focus6 EQ "1">focus6 = 1,</cfif>
<cfif isDefined("form.focus7") and form.focus7 EQ "1">focus7 = 1,</cfif>
<cfif isDefined("form.focus8") and form.focus8 EQ "1">focus8 = 1,</cfif>
<cfif isDefined("form.focus9") and form.focus9 EQ "1">focus9 = 1,</cfif>
<cfif isDefined("form.focus10") and form.focus10 EQ "1">focus10 = 1,</cfif>
<cfif isDefined("form.numtrained") > numbertrained = '#form.numtrained#', </cfif> 
<cfif isDefined("form.lentrained") > hourstrained = '#form.lentrained#', </cfif> 
<cfif isDefined("form.internalTraining") > intTrain = '#form.internalTraining#', </cfif> 
<cfif isDefined("form.tcpsust")>tcpsust = #form.tcpsust#, </cfif>
<cfif isDefined("form.tcpsust_text")>tcpsust_text = '#htmleditformat(form.tcpsust_text)#', </cfif>

progress = '#form.activityProgress#',
success = '#form.successes#',
barriers = '#form.barriers#',
<cfif isDefined("form.earned") and form.earned EQ "1">
earnedMedia = 1
<cfelse>
earnedMedia = 0
</cfif>

where activity = '#form.oldRpt#'
	and userid = '#form.rptuserid#'
	and month2= '#form.month#'		
	and year2= '#form.year#'		
</cfquery>
