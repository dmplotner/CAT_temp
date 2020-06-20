<!--- <cfdump var=#form#> --->


<SCRIPT language="JavaScript">
function CANCEL(){
location.history.go(-2)
}
</SCRIPT>

<cfif isDefined("form.colStrat")><cfparam name="form.activityName" default="#form.colStrat#"></cfif>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qgetuserinfo">
select c.coordemail as email, c.orgName, s.area
from contact as c, security as s
where c.userid='#session.userid#'	
and c.userid=s.userid
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QstrategyName">
select descr
from focusareas
where num=#form.strategy#
</cfquery>
<!--- <cfif Session.modality EQ 1 and (Qgetuserinfo.area EQ "1" or Qgetuserinfo.area EQ "2") >
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QAreaManager">
select m.userid, m.email
from modality_manager as m, contact as c
where 
c.userid=m.userid
</cfquery>

<cfelse> --->
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QAreaManager">
<!--- select manager_id, m.email, s.area
from area as a, contact as c, security as s, contact as m
where 
c.userid=s.userid
and a.num=s.area
and a.year2=#session.fy#
and c.userid='#session.userid#'
and a.manager_id=m.userid --->
<cfif now() GT '11/30/2008'>
select manager_id, m.coordemail as email,  m2.coordemail as modmail, s.area
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
select manager_id, m.coordemail as email,  m2.coordemail as modmail, s.area
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
</cfquery>

<!--- </cfif> --->
<cfmail from="dplotner@rti.org" to="#QAreaManager.email#" cc="#QAreaManager.modmail#" subject="Changes to CAT workplans" type="HTML">
You are being contacted because you serve as the contract/modality manager for #htmleditformat(Qgetuserinfo.orgName)#. 
There have been changes made to their FY<cfif session.fy EQ 1904>2005-2006<cfelse>#evaluate(session.fy-1)#-#session.fy#</cfif>
workplan, specifically to the "#htmleditformat(<!--- QstrategyName.descr --->form.activityName)#" strategy in the following areas:

<!--- insert comparison code here for tracking changes (big Brother) --->
#form.areachanged#
<br>
Reasons for changes:<br>

<pre>#htmleditformat(form.explanationOfChanges)#</pre>

Please review that these changes have been approved, and ask the partner to correct as necessary.
</cfmail>





<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="updActivity">
	update  userActivities 
	set
	activityName = '#htmleditformat(form.activity)#',
	<!--- goal= '#form.programVal#',
	objective= '#form.objective#', --->

	outcome= <cfqueryparam value="#form.outcome#" cfsqltype="cf_sql_varchar">,
<!--- 	actionarea= '#form.actionarea#', --->
	strategy= '#form.strategy#',
	<cfif isDefined("form.target1")>targetgroup= '#form.target1#',</cfif>
	last_sd= '#form.startdate#',
	<!--- last_sd= #dateformat(form.startdate,'m/yyyy')#, --->
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
	<!--- last_ed= #dateformat(form.enddate,'m/yyyy')# --->
	where
	(userid ='#session.userid# 'OR userid='SHARED') and activity=<cfif isDefined("form.activityName")>'#htmleditformat(form.activityName)#'<cfelseif isDefined("form.colStrat")>'#htmleditformat(form.colStrat)#'</cfif>
	and year2=#session.rptyr#
</cfquery>


<CFLOOP INDEX="ii" FROM="1" TO="#ArrayLen(session.afield)#">
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="updHist">

insert into historychange
(year2, date2, fieldname, initValue, finalValue, userid, strategy)
values
(#session.fy#, getDate(), '#session.afield[ii]#',
<cfqueryparam value="#htmleditformat(session.aorigVal[ii])#" cfsqltype="cf_sql_varchar">,
<cfqueryparam value="#htmleditformat(session.anewVal[ii])#" cfsqltype="cf_sql_varchar">, 

 '#session.userid#', '#htmleditformat(form.activityName)#' )
	
</cfquery>
</CFLOOP>




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
	<cflocation addtoken="Yes" url="cat_annual_success.cfm?#session.urltoken#&success=true">
	<!--- <cflocation addtoken="Yes" url="cat_annual.cfm?#session.urltoken#&success=true">  --->
</cfif> --->

<cflocation addtoken="Yes" url="cat_annual_strategy.cfm?#session.urltoken#&programVal=#form.programVal#&objVal=#form.objective#"> 


