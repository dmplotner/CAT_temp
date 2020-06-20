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
	username="#application.db_username#" name="checkMonitor">
	
	select activity 
	from Monitor
	where activity = '#form.oldrpt#'
	and userid = '#form.rptuserid#'
	and month2= '#form.month#'		
	and year2= '#form.year#'		
</cfquery>



<cfif checkMonitor.recordCount EQ 0>
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="insertMonitor">
	
	insert into Monitor
	(userid, activity, month2, year2)
	values('#form.rptuserid#', '#form.oldRpt#', '#form.month#', '#form.year#'	)
</cfquery>
</cfif>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="updateMonitor">
	Update monitor
	set revStart = '#startDate#',
RevEnd = '#endDate#',
status = '#form.actstatus#',
note = '#form.changedDates#',
<!--- target='#form.target#',
	foci='#form.foci#',
	primSec='#form.primSec#', --->
	<cfif isDefined("form.monStatus")>monStatus='#form.monStatus#',</cfif>
	<cfif isDefined("form.monStart")>monStart='#form.monStart#',</cfif>
	<cfif isDefined("form.secData")>secData='#form.secData#',</cfif>
	<cfif isDefined("form.inComp")>inComp='#form.inComp#',</cfif>
	<cfif isDefined("form.disChannel")>disChannel='#form.disChannel#',</cfif>
	<cfif isDefined("form.disto")>disto='#form.disto#',</cfif>
	<cfif isDefined("form.tcpsust")>tcpsust = #form.tcpsust#, </cfif>
<cfif isDefined("form.tcpsust_text")>tcpsust_text = '#htmleditformat(form.tcpsust_text)#', </cfif>

	progress = '#form.activityProgress#',
success = '#form.successes#',
barriers = '#form.barriers#'
	where activity = '#form.oldrpt#'
	and userid = '#form.rptuserid#'
	and month2= '#form.month#'		
	and year2= '#form.year#'
	
</cfquery>



