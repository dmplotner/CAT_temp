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
	from govt
	where activity = '#form.oldrpt#'
	and userid = '#form.rptuserid#'
	and month2= '#form.month#'		
	and year2= '#form.year#'		
</cfquery>

<cfif checkActivity.recordCount EQ 0>
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="insertNewRecord">
	
	insert into govt
	(userid, activity, month2, year2)
	values('#form.rptuserid#', '#form.oldRpt#', '#form.month#', '#form.year#'	)
</cfquery>


</cfif>
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="resetrecord">
	update govt
set impact1=0, impact2=0, impact3=0, impact4=0, impact5=0
where activity = '#form.oldRpt#'
	and userid = '#form.rptuserid#'
	and month2= '#form.month#'		
	and year2= '#form.year#'		
	

</cfquery>
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="updateRecord">
update govt
	set revStart = '#startDate#',
RevEnd = '#endDate#',
status = '#form.actstatus#',
note = '#form.changedDates#',

<!--- issue = '#form.issues#', --->
<!--- polLevel = '#form.levelchangesought#',  --->
<!--- <cfif isDefined("form.impactedCounties")>impCounties = '#form.impactedCounties#',</cfif>  --->
<cfif isDefined("form.cb1") and form.cb1 EQ "1">impact1 = 1,</cfif>
<cfif isDefined("form.cb2") and  form.cb2 EQ "1"> impact2 = 1, </cfif> 
<cfif isDefined("form.cb3") and  form.cb3 EQ "1"> impact3 = 1, </cfif> 
<cfif isDefined("form.cb4") and  form.cb4 EQ "1"> impact4 = 1, </cfif> 
<cfif isDefined("form.cb5") and  form.cb5 EQ "1"> impact5 = 1, </cfif> 

<cfif isDefined("form.impact_action") > impact_action = #form.impact_action#, </cfif> 
<cfif isDefined("form.impact_action_txt") > impact_action_txt = '#htmleditformat(form.impact_action_txt)#', </cfif> 
<cfif isDefined("form.impact_imp") > impact_imp = #form.impact_imp#, </cfif> 
<cfif isDefined("form.impact_imp_txt") > impact_imp_txt = '#htmleditformat(form.impact_imp_txt)#', </cfif> 

<cfif isDefined("form.numtrained") > numbertrained = '#form.numtrained#', </cfif> 
<cfif isDefined("form.lentrained") > hourstrained = '#form.lentrained#', </cfif> 
<cfif isDefined("form.internalTraining") > intTrain = '#form.internalTraining#', </cfif> 
<cfif isDefined("form.statewide") > statewide = '#form.statewide#', </cfif> 
<cfif isDefined("form.cb1_text")>number1 = '#form.cb1_text#', </cfif> 
<cfif isDefined("form.cb2_text")>number2 = '#form.cb2_text#', </cfif> 
<cfif isDefined("form.cb3_text")>number3 = '#form.cb3_text#', </cfif> 
<cfif isDefined("form.cb4_text")>number4 = '#form.cb4_text#', </cfif> 
<cfif isDefined("form.cb5_text")>number5 = '#form.cb5_text#', </cfif> 

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

