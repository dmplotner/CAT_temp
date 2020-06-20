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
	username="#application.db_username#" name="checkForum">
	
	select activity 
	from Forum
	where activity = '#form.oldrpt#'
	and userid = '#form.rptuserid#'
	and month2= '#form.month#'		
	and year2= '#form.year#'		
</cfquery>
<cfif checkForum.recordCount EQ 0>
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="insertForum">
	
	insert into Forum
	(userid, activity, month2, year2)
	values('#form.rptuserid#', '#form.oldRpt#', '#form.month#', '#form.year#'	)
</cfquery>
</cfif>



<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="updateForum">
	Update Forum
	set
	<cfif isDefined("form.format")> format = '#form.format#',</cfif>
	<cfif isDefined("form.setting")>setting = '#form.setting#',</cfif>
	<cfif isDefined("form.series")>series = '#form.series#',</cfif>
	<cfif isDefined("form.numEvents")>numEvents = '#form.numEvents#',</cfif>
	<cfif isDefined("form.countyEvent")>countyEvent = '#form.countyEvent#',</cfif>
	<cfif isDefined("form.eventT")>eventT = '#form.eventT#',</cfif>
	<cfif isDefined("form.commfocus")>commfocus = '#form.commfocus#',</cfif>
	<cfif isDefined("form.target")>target = '#form.target#',</cfif>
	<!--- countyTarget = '#form.countyTarget#', --->
	<cfif isDefined('form.num')>num = '#form.num#',</cfif>
	<cfif isDefined("form.promotion")>promotion = '#form.promotion#',</cfif>
	<cfif isDefined("form.rbpet")>rbpet = #form.rbpet#,</cfif>
	<cfif isDefined("form.numsig") and form.numsig NEQ "">numsig = #form.numsig#,<cfelse>numsig=NULL,</cfif>
	
	 revStart = '#startDate#',
RevEnd = '#endDate#',
status = '#form.actstatus#',
note = '#form.changedDates#',

statewide='#form.statewide#',

<cfif isDefined("form.numtrained") > numbertrained = '#form.numtrained#', </cfif> 
<cfif isDefined("form.lentrained") > hourstrained = '#form.lentrained#', </cfif> 
<cfif isDefined("form.internalTraining") > intTrain = '#form.internalTraining#', </cfif> 
<cfif isDefined("form.tcpsust")>tcpsust = #form.tcpsust#, </cfif>
<cfif isDefined("form.tcpsust_text")>tcpsust_text = '#htmleditformat(form.tcpsust_text)#', </cfif>


<!--- campTarget = '#form.campaignTarget#', --->

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