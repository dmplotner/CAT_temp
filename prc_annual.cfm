<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>CAT</title>
	<cfinclude template="CATstruct.cfm">
</head>
<SCRIPT language="JavaScript">
function CANCEL(){
document.confirmChanges.action="cat_annual_strategy.cfm<cfoutput>?#session.urltoken#</cfoutput>";
document.confirmChanges.submit();
}
</SCRIPT>

<body>
<!--- <cfif session.fy EQ 2007 and session.modality NEQ 4>
	<cfset session.AMalert=1>
	<cfset session.AMalert2=1>
<cfelseif session.fy EQ 2008 and session.modality NEQ 4>
	<cfset session.AMalert=0>
	<cfset session.AMalert2=0>
</cfif> --->

<!--- <cfif session.fy EQ 2007 and session.modality EQ 4>
	<cfset session.AMalert=0>
</cfif> --->


<cfif isdefined("form.startdate") and #form.startdate# is not ''>
<cfset pos = #find("/",form.startdate)#>
<cfif #pos# is 2>
<cfset m = #left(form.startdate,1)#>
<cfelse>
<cfset m = #left(form.startdate,2)#>
</cfif>
<cfset y = #right(form.startdate,4)#>
<cfset form.startdate = #m# &'/'&'1'&'/'&#y#>
</cfif>
<cfif isdefined("form.enddate") and #form.enddate# is not ''>
<cfset pos2 = #find("/",form.enddate)#>
<cfif #pos2# is 2>
<cfset mm = #left(form.enddate,1)#>
<cfelse>
<cfset mm = #left(form.enddate,2)#>
</cfif>
<cfset yy = #right(form.enddate,4)#>
<cfset form.enddate = #mm# &'/'&'1'&'/'&#yy#>
</cfif>



<cfoutput>





<div class="box"> 



<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="checkActivity">
	select userid, 
	activityName,
outcome,
strategy,
case  
when  targetgroup is null then '0'
when targetgroup = '' then '0' 
else targetgroup 
end as targetgroup, 
startdate,
enddate,
state,
campName,
otherName,
TCPRegional,
levelchangeSought,
issues,
impactedCounties,
campaignTarget,
target2,
foci,
primSec,
issuesAdd,
typePromo,
purpose,
pollevel,
stratfocus,	
TCPArea,
mgrant,
pm_theme,
pm_media,
QL_ref,
TCP_fun
	from useractivities
	where 
	
	<cfif isDefined("form.colStrat")>(userid = 'SHARED' and activity = '#htmleditformat(form.colStrat)#') 
	<cfelseif isDefined("form.activityName")>(userid = '#session.userid#' and activity ='#htmleditformat(form.activityName)#')
	</cfif>
	and year2=#session.fy#
</cfquery>



<cfif checkactivity.recordcount eq 0 and  (session.nextyr  EQ 1 and session.fy GT session.def_fy) >

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="insertActivity">
	insert 
	into userActivities 
	(userid, activity,
	goal, objective, outcome, 
<!---  	actionarea,   --->
	strategy,  activityName,  startdate, enddate, last_sd, last_ed, year2)
	values
	(<cfif isDefined("form.colStrat") and form.colStrat NEQ "">
	'SHARED','#htmleditformat(form.colStrat)#',
	<cfelse>
	'#session.userid#','#htmleditformat(form.activityName)#',
	</cfif>
	'#htmleditformat(form.programVal)#','#htmleditformat(form.objective)#','#htmleditformat(form.outcome)#',
<!---  	'#form.actionarea#',  --->
	'#form.strategy#',
<!--- 	'#form.activity#', --->
	<cfif isDefined("form.colStrat")>'#htmleditformat(form.colStrat)#',
	<cfelseif isDefined("form.activityName")>'#htmleditformat(form.activityName)#',
	</cfif>
	
	'#form.startdate#','#form.enddate#', '#form.startdate#','#form.enddate#', #session.fy#)
</cfquery>
	<!--- #insert 
	into userActivities 
	(userid, activity,
	goal, objective, outcome, 
<!---  	actionarea,   --->
	strategy,  activityName,  startdate, enddate, year2)
	values
	(<cfif isDefined("form.colStrat") and form.colStrat NEQ "">
	'SHARED','#htmleditformat(form.colStrat)#',
	<cfelse>
	'#session.userid#','#htmleditformat(form.activityName)#',
	</cfif>
	'#htmleditformat(form.programVal)#','#htmleditformat(form.objective)#','#htmleditformat(form.outcome)#',
<!---  	'#form.actionarea#',  --->
	'#form.strategy#',
<!--- 	'#form.activity#', --->
	<cfif isDefined("form.colStrat")>'#htmleditformat(form.colStrat)#',
	<cfelseif isDefined("form.activityName")>'#htmleditformat(form.activityName)#',
	</cfif>
	
	'#form.startdate#','#form.enddate#', #session.rptyr#)# --->
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="updActivity">
	update  userActivities 
	set
	activityName = '#form.activity#',
	<!--- goal= '#form.programVal#',
	objective= '#form.objective#', --->
	outcome= <cfqueryparam value="#htmleditformat(form.outcome)#" cfsqltype="cf_sql_varchar">,
<!--- 	actionarea= '#form.actionarea#', --->
	strategy= '#form.strategy#',
	<cfif isDefined("form.target1")>targetgroup= '#form.target1#',</cfif>
	last_sd= '#form.startdate#',
	
	<cfif isDefined("form.state")>state = '#form.state#',</cfif>
	<cfif isDefined("form.campaign")>campName = '#form.campaign#',</cfif>
	<cfif isDefined("form.otherCampaign")>otherName = '#form.otherCampaign#',</cfif>
	<cfif isDefined("form.regionalcollab")>TCPRegional = '#form.regionalcollab#',</cfif>
	<cfif isDefined("form.levelchangeSought")>levelchangeSought='#form.levelchangeSought#',</cfif>
	<cfif isDefined("form.issues")>issues='#form.issues#',</cfif>
	<cfif isDefined("form.impactedCounties")>impactedCounties='#form.impactedCounties#',</cfif>
	<cfif isDefined("form.campaignTarget")>campaignTarget='#form.campaignTarget#',</cfif>
	<cfif isDefined("form.target2")>target2=#form.target2#,</cfif>
	<cfif isDefined("form.foci")><cf_removeDuplicates list="#form.foci#">foci='#deDupedList#',</cfif>
	<cfif isDefined("form.primSec")>primSec='#form.primSec#',</cfif>
	<cfif isDefined("form.issuesAdd")>issuesAdd='#form.issuesAdd#',</cfif>
	<cfif isDefined("form.typePromo")>typePromo='#form.typePromo#',</cfif>
	<cfif isDefined("form.purpose")>purpose='#form.purpose#',</cfif>
	<cfif isDefined("form.pollevel")>pollevel='#form.pollevel#',</cfif>
	<cfif isDefined("form.stratfocus")>stratfocus='#form.stratfocus#',</cfif>
	
	<cfif isDefined("form.pm_theme")>pm_theme='#form.pm_theme#',</cfif>
	<cfif isDefined("form.pm_media")>pm_media='#form.pm_media#',</cfif>
	<cfif isDefined("form.QL_ref")>QL_ref='#form.QL_ref#',</cfif>
	<cfif isDefined("form.TCP_fun")>TCP_fun='#form.TCP_fun#',</cfif>
	
	
	<cfif isDefined("form.mgrant")>mgrant='#form.mgrant#',</cfif>
	<cfif isDefined("form.areaCollab")>TCPArea = '#form.areaCollab#',</cfif>
	last_ed='#form.enddate#'
	
	where
	<cfif isDefined("form.colStrat")>activity = '#htmleditformat(form.colStrat)#'
	<cfelseif isDefined("form.activityName")>userid = '#session.userid#' and activity='#htmleditformat(form.activityName)#'
	</cfif>	
	and year2=#session.fy#
</cfquery>

<!--- <cfinclude template="prc_annual2.cfm"> --->
<cfif form.addstrategy EQ "add">
	<!--- <cflocation addtoken="Yes" url="cat_annual_strategy.cfm?#session.urltoken#&programVal=#form.programVal#&objVal=#form.objective#"> --->
	<cflocation addtoken="Yes" url="cat_annual_success.cfm?#session.urltoken#&success=true">
<cfelse>
	<!--- <cflocation addtoken="Yes" url="cat_annual.cfm?#session.urltoken#&success=true"> --->
	<cflocation addtoken="Yes" url="cat_annual_success.cfm?#session.urltoken#&success=true">
</cfif>

<cfelseif checkactivity.recordcount neq 0 and (session.nextyr  EQ 1 and session.fy GT session.def_fy)>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="updActivity">
	update  userActivities 
	set
	activityName = '#form.activity#',
	<!--- goal= '#form.programVal#',
	objective= '#form.objective#', --->
	outcome= <cfqueryparam value="#htmleditformat(form.outcome)#" cfsqltype="cf_sql_varchar">,
<!--- 	actionarea= '#form.actionarea#', --->
	strategy= '#form.strategy#',
	<cfif isDefined("form.target1")>targetgroup= '#form.target1#',</cfif>
	last_sd= '#form.startdate#',
	<cfif isDefined("form.state")>state = '#form.state#',</cfif>
	<cfif isDefined("form.campaign")>campName = '#form.campaign#',</cfif>
	<cfif isDefined("form.otherCampaign")>otherName = '#form.otherCampaign#',</cfif>
	<cfif isDefined("form.regionalcollab")>TCPRegional = '#form.regionalcollab#',</cfif>
	<cfif isDefined("form.levelchangeSought")>levelchangeSought='#form.levelchangeSought#',</cfif>
	<cfif isDefined("form.issues")>issues='#form.issues#',</cfif>
	<cfif isDefined("form.impactedCounties")>impactedCounties='#form.impactedCounties#',</cfif>
	<cfif isDefined("form.campaignTarget")>campaignTarget='#form.campaignTarget#',</cfif>
	<cfif isDefined("form.target2")>target2=#form.target2#,</cfif>
	<cfif isDefined("form.foci")><cf_removeDuplicates list="#form.foci#">foci='#deDupedList#',</cfif>
	<cfif isDefined("form.primSec")>primSec='#form.primSec#',</cfif>
	<cfif isDefined("form.issuesAdd")>issuesAdd='#form.issuesAdd#',</cfif>
	<cfif isDefined("form.typePromo")>typePromo='#form.typePromo#',</cfif>
	<cfif isDefined("form.purpose")>purpose='#form.purpose#',</cfif>
	<cfif isDefined("form.pollevel")>pollevel='#form.pollevel#',</cfif>
	<cfif isDefined("form.stratfocus")>stratfocus='#form.stratfocus#',</cfif>
	
	<cfif isDefined("form.pm_theme")>pm_theme='#form.pm_theme#',</cfif>
	<cfif isDefined("form.pm_media")>pm_media='#form.pm_media#',</cfif>
	<cfif isDefined("form.QL_ref")>QL_ref='#form.QL_ref#',</cfif>
	<cfif isDefined("form.TCP_fun")>TCP_fun='#form.TCP_fun#',</cfif>
	
	
	<cfif isDefined("form.mgrant")>mgrant='#form.mgrant#',</cfif>
	<cfif isDefined("form.areaCollab")>TCPArea = '#form.areaCollab#', </cfif>	
	
	last_ed= '#form.enddate#'
	where
	<cfif isDefined("form.colStrat")>activity = '#htmleditformat(form.colStrat)#'
	<cfelseif isDefined("form.activityName")>userid = '#session.userid#' and activity='#htmleditformat(form.activityName)#'
	</cfif>	
	and year2=#session.fy#
</cfquery>
<!--- <cflocation addtoken="Yes" url="cat_annual.cfm?#session.urltoken#&success=true">
 --->
 <cflocation addtoken="Yes" url="cat_annual_success.cfm?#session.urltoken#&success=true">

<cfelseif checkactivity.recordcount eq 0 <!--- and SESSION.AMalert EQ 1 --->>
<cfform action="prc_annual3.cfm">

You have made an addition to your annual workplan. <br>
You can choose to submit this new strategy or cancel it. <br>
Submitting them will send a message to your contract manager, <br>
indicating that you have added a strategy to your workplan.<br>
<br>


<CFLOOP INDEX="form_element" LIST="#FORM.fieldnames#">                       
<INPUT TYPE="hidden" NAME="#form_element#" VALUE="#htmleditformat(Evaluate(form_element))#">                       
</CFLOOP>

<br>
<textarea name="explanationOfChanges" cols="80" rows="5">Please explain why you are adding a strategy.</textarea><br><br>

<input type="button" value="Cancel" onclick="CANCEL();"  style="width:400"><br>
<input type="submit" value="Submit Strategy" style="width:400">
</cfform>
<cfelse><!--- This case is an update to existing strategy --->


<!--- insert comparison code here for tracking changes (big Brother) --->
<cfset areasChanged = "">

<cfset session.afield=ArrayNew(1)>
<cfset session.aorigVal=ArrayNew(1)>
<cfset session.anewVal=ArrayNew(1)>
<cfset z=1>


<cfif isDefined("form.activity") AND form.activity NEQ checkActivity.activityName>
	<cfset areasChanged = areasChanged & '<li type="disc">Strategy</li>'>

	<cfset session.afield[z]="Strategy">
	<cfset session.aorigVal[z]=checkActivity.activityName>
	<cfset session.anewVal[z]=form.activity>
	<cfset z=z+1>	
</cfif>

<cfif isDefined("form.outcome") AND form.outcome NEQ checkActivity.outcome>
	<cfset areasChanged = areasChanged & '<li type="disc">Outcome</li>'>
	<cfset session.afield[z]="outcome">
	<cfset session.aorigVal[z]=checkActivity.outcome>
	<cfset session.anewVal[z]=form.outcome>
	<cfset z=z+1>	
</cfif>
<cfif isDefined("form.strategy") AND form.strategy NEQ checkActivity.strategy>
	<cfset areasChanged = areasChanged & '<li type="disc">Focus Area</li>'>
	
	<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="chkFarea1">
	select strategy
	from strategy
	where strategy_Num = '#form.strategy#'	
	</cfquery>
	
	<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="chkFarea2">
	select strategy
	from strategy
	where strategy_Num = '#checkActivity.strategy#'	
	</cfquery>
	
	<cfset session.afield[z]="Focus Area">
	<cfset session.aorigVal[z]=chkFarea1.strategy>
	<cfset session.anewVal[z]=chkFarea2.strategy>
	<cfset z=z+1>	
</cfif>
<cfif isDefined("form.target1") AND isDefined("checkActivity.targetgroup") AND form.target1 NEQ checkActivity.targetgroup and checkActivity.targetgroup NEQ "" and checkActivity.targetgroup NEQ 0>
	<cfset areasChanged = areasChanged & '<li type="disc">Target</li>'>
	
	<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="chkTarget1">
	select target
	from targets 
	where strategyNum = '#form.strategy#'
	and year2=#session.fy#
	and targetNum in (#checkActivity.targetgroup#)
	</cfquery>
	
	<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="chkTarget2">
	select target
	from targets 
	where strategyNum = '#form.strategy#'
	and year2=#session.fy#
	and targetNum in (#form.target1#)
	</cfquery>
	
	<cfset session.afield[z]="Target">
	<cfset session.aorigVal[z]=valuelist(chkTarget1.target)>
	<cfset session.anewVal[z]=valuelist(chkTarget2.target)>
	<cfset z=z+1>


</cfif>
<cfif isDefined("form.startdate") AND form.startdate NEQ checkActivity.startdate>
	<cfset areasChanged = areasChanged & '<li type="disc">Start Date</li>'>
	<cfset session.afield[z]="startdate">
	<cfset session.aorigVal[z]=checkActivity.startdate>
	<cfset session.anewVal[z]=form.startdate>
	<cfset z=z+1>	
</cfif>
<cfif isDefined("form.enddate") AND form.enddate NEQ checkActivity.enddate>
	<cfset areasChanged = areasChanged & '<li type="disc">End Date</li>'>
	<cfset session.afield[z]="enddate">
	<cfset session.aorigVal[z]=checkActivity.enddate>
	<cfset session.anewVal[z]=form.enddate>
	<cfset z=z+1>	
</cfif>
<!--- <cfif isDefined("form.state") AND form.state NEQ checkActivity.state></cfif> --->
<cfif isDefined("form.campaign") AND form.campaign NEQ checkActivity.campName>
	<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="chkCampaign1">
	select descrip
	from state_initiatives 
	where num = '#checkActivity.campName#'
	and year2=#session.fy#
	</cfquery>
	<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="chkCampaign2">
	select descrip
	from state_initiatives 
	where num = '#form.campaign#'
	and year2=#session.fy#
	</cfquery>	
	<cfset areasChanged = areasChanged & '<li type="disc">Name of Campaign</li>'>
	<cfset session.afield[z]="Name of Campaign">
	<cfset session.aorigVal[z]=chkCampaign1.descrip>
	<cfset session.anewVal[z]=chkCampaign2.descrip>
	<cfset z=z+1>	
</cfif>
<!--- <cfif isDefined("form.othercampaign") AND form.othercampaign NEQ checkActivity.otherName></cfif> --->
<cfif isDefined("form.regionalCollab") AND form.regionalCollab NEQ checkActivity.TCPRegional>
	<cfset areasChanged = areasChanged & '<li>Part of TCP regional collaboration with other partners</li>'>
	<cfset session.afield[z]="TCP Regional Collaboration">
	<cfset session.aorigVal[z]=checkActivity.TCPRegional>
	<cfset session.anewVal[z]=form.regionalCollab>
	<cfset z=z+1>	
</cfif>

<!--- Need to modify to database lookup --->
<cfif isDefined("form.levelchangeSought") AND form.levelchangeSought NEQ checkActivity.levelchangeSought AND isDefined("form.issues")>
	<cfset areasChanged = areasChanged & '<li type="disc">Level at which policy change sought</li>'>
	<cfset session.afield[z]="Level at which policy change sought">
	<cfset session.aorigVal[z]=checkActivity.issues>
	<cfset session.anewVal[z]=form.issues>
	<cfset z=z+1>	
</cfif>
<cfif isDefined("form.issues") AND form.issues NEQ checkActivity.issues>
	<cfset areasChanged = areasChanged & '<li type="disc">Issue Addressed by Education Activity</li>'>
	<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qgovtissues1"> 
	select  descrip
	 from GOVTissues
	  where year2=#session.fy#
	  and num='#checkActivity.issues#'
	   order by rank
 	</cfquery>
	
	<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qgovtissues2"> 
	select  descrip
	 from GOVTissues
	  where year2=#session.fy#
	  and num='#form.issues#'
	   order by rank
 	</cfquery>	
	<cfset session.afield[z]="issues">
	<cfset session.aorigVal[z]=Qgovtissues1.descrip>
	<cfset session.anewVal[z]=Qgovtissues2.descrip>
	<cfset z=z+1>	
</cfif>
<cfif isDefined("form.impactedCounties") AND form.impactedCounties NEQ checkActivity.impactedCounties>
	<cfset areasChanged = areasChanged & '<li type="disc">County(ies) within which Policy change sought</li>'>
	<cfset session.afield[z]="counties change sought">
	<cfset session.aorigVal[z]=checkActivity.impactedCounties>
	<cfset session.anewVal[z]=form.impactedCounties>
	<cfset z=z+1>	
</cfif>
<!--- <cfif isDefined("form.campaignTarget") AND form.campaignTarget NEQ checkActivity.campaignTarget></cfif> --->
<cfif isDefined("form.target2") AND form.target2 NEQ checkActivity.target2>
	<cfset areasChanged = areasChanged & '<li type="disc">Target Organization</li>'>
	<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="GetTarget1">
	SELECT target
  	FROM monitorTarget 
  	where year2=#session.fy#
	and keyNum='#checkActivity.target2#'
 	order by 1
	</cfquery>
	
	<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="GetTarget2">
	SELECT target
  	FROM monitorTarget 
  	where year2=#session.fy#
	and keyNum='#form.target2#'
 	order by 1
	</cfquery>
	
	<cfset session.afield[z]="target organizations">
	<cfset session.aorigVal[z]=GetTarget1.target>
	<cfset session.anewVal[z]=GetTarget2.target>
	<cfset z=z+1>	
	
</cfif>
<cfif isDefined("form.foci") AND form.foci NEQ checkActivity.foci and checkActivity.foci NEQ "">
	<cfset areasChanged = areasChanged & '<li type="disc">Focus of monitoring / assessment</li>'>
	<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="GetFoci1">
	SELECT Foci
  	FROM monitorFocus
  	where keyNum = '#checkActivity.target2#'
	and seq in (#checkActivity.foci#)
  	and year2=#session.fy#
 	</cfquery>
	<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="GetFoci2">
	SELECT Foci
  	FROM monitorFocus
  	where keyNum = '#form.target2#'
	and seq in (#form.foci#)
  	and year2=#session.fy#
 	</cfquery>
	<cfset session.afield[z]="focus of monitoring">
	<cfset session.aorigVal[z]=valueList(GetFoci1.foci)>
	<cfset session.anewVal[z]=valueList(GetFoci2.foci)>
	<cfset z=z+1>
	
</cfif>
<cfif isDefined("form.primSec") AND form.primSec NEQ checkActivity.primSec>
	<cfset areasChanged = areasChanged & '<li type="disc">Primary or secondary data collection</li>'>
	<cfset session.afield[z]="primary/secondary">
	<cfset session.aorigVal[z]=checkActivity.primSec>
	<cfset session.anewVal[z]=form.primSec>
	<cfset z=z+1>
</cfif>
<cfif isDefined("form.issuesAdd") AND form.issuesAdd NEQ checkActivity.issuesAdd>
	<cfset areasChanged = areasChanged & '<li type="disc">Issues addressed in survey</li>'>
	<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="issues1">
	select
	descrip
	from survey_issues
	where year2=#session.fy#
	<cfif checkActivity.issuesAdd NEQ "">and num in (#CheckActivity.issuesAdd#)<cfelse> and  num =0 </cfif>
	order by rank
	</cfquery>
	<cfset areasChanged = areasChanged & '<li type="disc">Issues addressed in survey</li>'>
	<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="issues2">
	select
	descrip
	from survey_issues
	where year2=#session.fy#
	<cfif form.issuesAdd NEQ ""> and num in (#form.issuesAdd#)<cfelse> and  num =0 </cfif>
	order by rank
	</cfquery>
	
	<!--#valuelist(issues2.descrip)#--->
	
	<cfset session.afield[z]="issues addressed">
	<cfset session.aorigVal[z]=Quotedvaluelist(issues1.descrip)>
	<cfset session.anewVal[z]=Quotedvaluelist(issues2.descrip)>
	<cfset z=z+1>
</cfif>
<!--- change to table driven --->
<cfif isDefined("form.typePromo") AND form.typePromo NEQ checkActivity.typePromo>
	<cfset areasChanged = areasChanged & '<li type="disc">Type of promotion of cessation services</li>'>
	<cfset session.afield[z]="Type of service">
	<cfset session.aorigVal[z]=checkActivity.typePromo>
	<cfset session.anewVal[z]=form.typePromo>
	<cfset z=z+1>
</cfif>
<cfif isDefined("form.purpose") AND checkActivity.purpose NEQ "" AND form.purpose NEQ checkActivity.purpose>
	<cfset areasChanged = areasChanged & '<li type="disc">Purpose of strategy</li>'>
	<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="stratpurp1">
	select descrip	
	from cess_purp 
	where stratnum = #form.strategy#
	and targnum = #form.target1#
	and year2=#session.fy#
	and purpnum in (#checkActivity.purpose#)
	</cfquery>
	<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="stratpurp2">
	select descrip	
	from cess_purp 
	where stratnum = #form.strategy#
	and targnum = #form.target1#
	and year2=#session.fy#
	and purpnum in (#checkActivity.purpose#)
	</cfquery>
	<cfset session.afield[z]="Purpose of Strategy">
	<cfset session.aorigVal[z]=QuotedValueList(stratpurp1.descrip)>
	<cfset session.anewVal[z]=QuotedValueList(stratpurp2.descrip)>
	<cfset z=z+1>
	
	
</cfif>
<cfif isDefined("form.pollevel") AND checkActivity.pollevel NEQ "" AND form.pollevel NEQ checkActivity.pollevel>
	<cfset areasChanged = areasChanged & '<li type="disc">Level at which policy, program or practice change sought</li>'>
	<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="pol_level1">
	select descrip	
	from cess_level 
	where year2=#session.fy#
	and num=#checkactivity.pollevel#
	</cfquery>
	<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="pol_level2">
	select descrip	
	from cess_level 
	where year2=#session.fy#
	and num=#form.pollevel#
	</cfquery>
	<cfset session.afield[z]="Level change sought">
	<cfset session.aorigVal[z]=QuotedValueList(pol_level1.descrip)>
	<cfset session.anewVal[z]=QuotedValueList(pol_level2.descrip)>
	<cfset z=z+1>
	
</cfif>
<cfif isDefined("form.stratfocus") AND form.stratfocus NEQ checkActivity.stratfocus>
	<cfset areasChanged = areasChanged & '<li type="disc">Strategy focus</li>'>
	<cfset session.afield[z]="strategy focus">
	<cfset session.aorigVal[z]=checkActivity.stratfocus>
	<cfset session.anewVal[z]=form.stratfocus>
	<cfset z=z+1>
</cfif>
<cfif isDefined("form.areaCollab") AND form.areaCollab NEQ checkActivity.TCPArea>
	<cfset areasChanged = areasChanged & '<li type="disc">part of TCP Area collaboration with other partners</li>'>
	<cfset session.afield[z]="TCP Area collaboration">
	<cfset session.aorigVal[z]=checkActivity.TCPArea>
	<cfset session.anewVal[z]=form.areaCollab>
	<cfset z=z+1>
</cfif>
<cfif isDefined("form.mgrant") AND form.mgrant NEQ checkActivity.mgrant>
	<cfset areasChanged = areasChanged & '<li type="disc">Strategy being conducted by mini-grant recipient</li>'>
	<cfset session.afield[z]="minigrant recipient">
	<cfset session.aorigVal[z]=checkActivity.mgrant>
	<cfset session.anewVal[z]=form.mgrant>
	<cfset z=z+1>
</cfif>

<cfif isDefined("form.PM_theme") AND form.PM_theme NEQ checkActivity.PM_theme>
	<cfset areasChanged = areasChanged & '<li type="disc">Theme of media campaign</li>'>
	<cfset session.afield[z]="Paid Media Theme">
	<cfset session.aorigVal[z]=checkActivity.PM_theme>
	<cfset session.anewVal[z]=form.PM_theme>
	<cfset z=z+1>
</cfif>
<cfif isDefined("form.PM_media") AND form.PM_media NEQ checkActivity.PM_media>
	<cfset areasChanged = areasChanged & '<li type="disc">Medium planned to be used</li>'>
	<cfset session.afield[z]="Paid Media Medium">
	<cfset session.aorigVal[z]=checkActivity.PM_media>
	<cfset session.anewVal[z]=form.PM_media>
	<cfset z=z+1>
</cfif>
<cfif isDefined("form.QL_ref") AND form.QL_ref NEQ checkActivity.QL_ref>
	<cfset areasChanged = areasChanged & '<li type="disc">Reference to NYS Quitline</li>'>
	<cfset session.afield[z]="NYS Quitline Reference">
	<cfset session.aorigVal[z]=checkActivity.QL_ref>
	<cfset session.anewVal[z]=form.QL_ref>
	<cfset z=z+1>
</cfif>

<cfif isDefined("form.TCP_fun") AND form.TCP_fun NEQ checkActivity.TCP_fun>
	<cfset areasChanged = areasChanged & '<li type="disc">TCP Funding</li>'>
	<cfset session.afield[z]="TCP Funding">
	<cfset session.aorigVal[z]=checkActivity.TCP_fun>
	<cfset session.anewVal[z]=form.TCP_fun>
	<cfset z=z+1>
</cfif>

<cfif areasChanged NEQ "">
<cfset areaschanged = "<ul>" & areaschanged & "</ul>">
<cfform name="confirmChanges" action="prc_annual2.cfm">
<CFLOOP INDEX="form_element" LIST="#FORM.fieldnames#">                       
<INPUT TYPE="hidden" NAME="#form_element#" VALUE="#htmleditformat(Evaluate(form_element))#">
                       
</CFLOOP>

You have made changes to your annual workplan. <br>
You must get pre-approval for these changes. <br>
You can choose to cancel these changes, or to submit them. <br>
Submitting them will send a message to your contract manager, <br>
indicating which areas of the workplan you have changed.<br>
<br>
Areas of workplan changed (for strategy 
<cfif isDefined("form.colStrat")>
#form.colStrat#
<cfelse>
#form.activityName#
</cfif>):<ul>#areaschanged#</ul>


<input type="hidden" name="areachanged" value='#areaschanged#'>
<br>
<textarea name="explanationOfChanges" cols="80" rows="5">Please enter your explanation here.</textarea><br><br>

<input type="button" value="Cancel" onclick="CANCEL();"  style="width:400"><br>
<input type="submit" value="Submit changes" style="width:400">


 </cfform>
<cfelse>
<!--- <cfinclude template="prc_annual2.cfm"> --->
<!--- <cfif form.addstrategy EQ "add">
	<cflocation addtoken="Yes" url="cat_annual_strategy.cfm?#session.urltoken#&programVal=#form.programVal#&objVal=#form.objective#">
<cfelse>
	<cflocation addtoken="Yes" url="cat_annual.cfm?success=true">
</cfif> --->

<cflocation addtoken="Yes" url="cat_annual.cfm?success=true">


</cfif>


</cfif>
</div>
</cfoutput>
</body>
</html>
