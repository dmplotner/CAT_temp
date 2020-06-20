<!--- <cfif isdefined("form.startdate") and #form.startdate# is not ''>
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
</cfif> --->
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QUserInfo">
select c.orgname, c.contact, s.area
from contact as c, security as s
where c.userid='#session.userid#'	
and c.userid=s.userid
</cfquery>
<!--- <cfif Session.modality EQ 1 and (Quserinfo.area EQ "1" or Quserinfo.area EQ "2")>
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QAreaManager">
select m.userid, email
from modality_manager as m, contact as c
where 
c.userid=m.userid
</cfquery>
<cfelse> --->
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QAreaManager">
<cfif now() GT '11/30/2008'>
select manager_id, m.coordemail as email,  m2.coordemail as email as modmail, s.area
from area as a, contact as c, security as s, contact as m
,modality_manager as mo
, contact as m2
where 
c.userid=s.userid
and a.num=s.area
and a.year2=#session.fy#
and c.userid='#session.userid#'
and c.cmanager=m.userid
and c.partnertype=mo.modality
and m2.userid=mo.userid
<cfelse>
select manager_id, m.coordemail as email,  m2.coordemail as email as modmail, s.area
from area as a, contact as c, security as s, contact as m
,modality_manager as mo
, contact as m2
where 
c.userid=s.userid
and a.num=s.area
and a.year2=#session.fy#
and c.userid='#session.userid#'
and a.manager_id=m.userid
and c.partnertype=mo.modality
and m2.userid=mo.userid
</cfif>
		
		
<!--- select manager_id, m.email,  m2.email as modmail, s.area
from area as a, contact as c, security as s, contact as m
,modality_manager as mo
, contact as m2
where 
c.userid=s.userid
and a.num=s.area
and a.year2=#session.fy#
and c.userid='#session.userid#'
and a.manager_id=m.userid
and c.partnertype=mo.modality
and m2.userid=mo.userid --->



</cfquery>


<!--- </cfif> --->

<!--- <cfmail from="dplotner@rti.org" to="dplotner@rti.org" subject="Addition to CAT workplans" type="HTML"> --->
<cfmail from="dplotner@rti.org" to="#QAreaManager.email#" cc="#QAreaManager.modmail#" subject="Addition to CAT workplans" type="HTML">
You are being contacted because you serve as the contract/modality manager for #htmleditformat(QUserInfo.orgname)# (#htmleditformat(QUserInfo.contact)#). 
They have added a strategy to their FY<cfif session.fy EQ 1904>2005-2006<cfelse>#evaluate(session.fy-1)#-#session.fy#</cfif> workplan ( <cfif isDefined("form.activityName")>"#htmleditformat(form.activityName)#"<cfelse>"#htmleditformat(form.colStrat)#"</cfif>) 
<br>
Reasons for addition:<br>

<pre>#htmleditformat(form.explanationOfChanges)#</pre>

Please review that these changes have been approved, and ask the partner to correct as necessary.
</cfmail>





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
	'#htmleditformat(form.strategy)#',
<!--- 	'#form.activity#', --->
	<cfif isDefined("form.colStrat")>'#htmleditformat(form.colStrat)#',
	<cfelseif isDefined("form.activityName")>'#htmleditformat(form.activityName)#',
	</cfif>
	
	'#form.startdate#','#form.enddate#', '#form.startdate#','#form.enddate#',#session.fy#)
</cfquery>

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
	
	last_ed= '#form.enddate#'
	where
	<cfif isDefined("form.colStrat")>activity = '#htmleditformat(form.colStrat)#'
	<cfelseif isDefined("form.activityName")>userid = '#session.userid#' and activity='#htmleditformat(form.activityName)#'
	</cfif>	
	and year2=#session.fy#
</cfquery>



<!--- <cfif form.addstrategy EQ "add">
	<!--- <cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="redirActivity">
	select rank 
	from objectives 
	where objective='#form.objective#' 
	and progNum=#form.programVal#	
	and year2=#session.fy#
	</cfquery> --->
	<cflocation addtoken="Yes" url="cat_annual_strategy.cfm?#session.urltoken#&programVal=#form.programVal#&objVal=#form.objective#"> 
<cfelse>
	<cflocation addtoken="Yes" url="cat_annual.cfm?#session.urltoken#&success=true"> 
</cfif>
 --->
<cflocation addtoken="Yes" url="cat_annual.cfm?#session.urltoken#&success=true">

