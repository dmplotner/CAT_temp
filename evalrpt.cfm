<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
<title>CAT Evaluation Report</title>

<cfif isDefined("form.rptmethod")>
	<cfset url.method2=form.rptmethod>
</cfif>
<cfif isDefined("url.method2")>
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="RecordDet">
	select
	strat,
	descrip,
	stdate,
	enddate,
	evalQ,
	evid,
	coll_meth,
	primSec,
	who_analyze,
	who_prepare,
	how_dissem,
	who_dissem,
	tool_name,
	target_pop,
	target_org,
	coll_stDate,
	coll_endDate,
	select_meth,
	add_num,
	data_source,
	approvdate,
	revApproval
	from EvalM
	where 
	userid='#session.userid#'
	and method = '#url.method2#'	
	and year2=#session.fy#
	
	
	
	
</cfquery>


<cfset form.selectedStrategies = '#RecordDet.strat#'>
<cfset form.name = '#RecordDet.descrip#'>
<cfset form.ostartdate = dateformat(#RecordDet.stdate#,'m/d/yyyy')>
<cfset form.oenddate = dateformat(#RecordDet.enddate#, 'm/d/yyyy')>
<cfset form.question = '#RecordDet.evalQ#'>
<cfset form.evidence = '#RecordDet.evid#'>
<cfset form.methodname = '#url.method2#'>
<cfset form.primsec = '#RecordDet.primsec#'>
<cfset form.analyzer = '#RecordDet.who_analyze#'>
<cfset form.reporter = '#RecordDet.who_prepare#'>
<cfset form.disseminate = '#RecordDet.how_dissem#'>
<cfset form.disseminated = '#RecordDet.who_dissem#'>
<cfif form.primsec EQ "1"></cfif>
<cfset form.method2 = #RecordDet.coll_meth#>
<cfset form.tool = '#RecordDet.tool_name#'>
<cfset form.targetpop = '#RecordDet.target_pop#'>
<cfset form.targetorg = '#RecordDet.target_org#'>
<cfset form.selectmethod = '#RecordDet.select_meth#'>
<cfset form.startdate = dateformat(#RecordDet.coll_stDate#, 'm/d/yyyy')>
<cfset form.enddate = dateformat(#RecordDet.coll_endDate#, 'm/d/yyyy')>
<cfset form.num = '#RecordDet.add_num#'>

<cfset form.sources = '#RecordDet.data_source#'>

<cfset form.Adate = dateformat(#RecordDet.approvdate#, 'm/d/yyyy')>
<cfset form.revApproval = '#RecordDet.revApproval#'>
</cfif>
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="qMeth2">
select num, descr, rank from eval_meth
where num = #form.method2#
</cfquery>
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="countyheadache">
select catchment 
from contact
where userid = '#session.userid#'
	
</cfquery>




<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="counties">
	select CountyName, FIPS from counties
	where FIPS in<cfif isDefined("countyheadache.catchment")>(#valuelist(countyheadache.catchment)#)<cfelse>(0)</cfif> 
	order by 1
	
</cfquery>



<cfinclude template="catstruct.cfm">

<script language="JavaScript">



function process(){
document.f1.action="evalrpt.cfm<cfoutput>?#session.urltoken#</cfoutput>";
document.f1.submit();
}

</script>


<div class="box">
<cfform name="f1" action="prc_evalrpt.cfm?#session.urltoken#" >
<div align="center"><h2>Evaluation Report</h2></div>

<!--- <cfquery datasource="#Application.DataSource#"  		 
	password="#Application.db_password#"   		
	username="#Application.db_username#" name="strategies">
	
	select Rtrim(activity) as activity
	from useractivities
	where userid = '#session.userid#'
	and activity in 
	order by 1
	
</cfquery> --->

<table align="center" class="box">
<tr>
	<td>Method - Brief Description:</td>
	<td><cfoutput>#form.name#</cfoutput></td>
</tr>

<tr>
	<td>Method Unique Name:</td>
	<td><cfoutput>#form.methodName#</cfoutput></td>
	<input type="hidden" name="methodname" value=<cfoutput>"#form.methodName#"</cfoutput>>
</tr>
<tr>
<td>Reporting Date:</td>
<td>
<cfif isDefined("url.date")>
	<cfinput name="mdate" type="Text" validate="date" message="Please enter a date in the 'mm/dd/yyyy' format" value="#dateformat(url.date, 'm/d/yyyy')#"></td>
<cfelse>
	<cfinput name="mdate" type="Text" validate="date" message="Please enter a date in the 'mm/dd/yyyy' format"></td>
</cfif>

</tr>

<tr>
	<td>Strategies Evaluated:</td>
	<td><cfoutput>#form.selectedStrategies#</cfoutput></td>
</tr>
<tr>
	<td>Overall time frame</td>
	<td>Start Date:<cfoutput>#dateformat(form.Ostartdate, 'm/d/yyyy')#<br>End Date: #dateformat(form.Oenddate, 'm/d/yyyy')#</cfoutput></td>
</tr>
<tr><td>Primary or Secondary data:</td><td><cfif form.primsec EQ "1">Primary<cfelse>Secondary</cfif></td></tr>
<cfif form.primsec EQ "1">
<tr>
	<td>Data Collection Method:</td>
	<td><cfoutput>#qMeth2.descr#</cfoutput>
	</td>
</tr>


<tr>
	<td>Data Collection Timeframe:</td>
	<td>Start Date: <cfoutput>#dateformat(form.startdate, 'm/d/yyyy')#</cfoutput><br>
	End Date: <cfoutput>#dateformat(form.enddate, 'm/d/yyyy')#</cfoutput></td>
</tr>

<cfif isDefined("form.targetorg")>
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="GetTarget">
SELECT target
  FROM monitorTarget 
  where year2=#session.fy#
  and keyNum in (#form.targetorg#)
 order by 1 
</cfquery>
</cfif>
<tr><td>Target Population:</td><td><cfif isDefined("GetTarget.target")><cfoutput>#valuelist(GetTarget.target, '<br>')#</cfoutput></cfif></td></tr>
<tr><td>Other Desc:</td><td><cfoutput>#form.targetPop#</cfoutput></td></tr>
<cfelse>
<tr>
	<td>Source:</td>
	<td>
		<cfswitch expression="form.sources">
		<cfcase value="1">NYS Quit Line</cfcase>
		<cfcase value="2">Medicaid</cfcase>
		<cfcase value="3">Regional ATS</cfcase>
		<cfcase value="4">YTS</cfcase>
		<cfcase value="5">X-BRFSS</cfcase>
		<cfcase value="6">Other</cfcase>
		</cfswitch>	
	</td>
</tr>
</cfif>

<tr>
<td>County(ies) target population or sites reside in:</td>
<td>
<select name="rptcounties" multiple size="5" class="mlti">
<cfoutput>

<cfloop query="counties" >
<option value="#FIPS#">#CountyName#
</cfloop>
</cfoutput>
<option value="88888">Counties beyond catchment area
<option value="99999">Distant from catchment area
</select></td>
</tr>

<cfif form.method2 EQ "1" or form.method2 EQ "2" or form.method2 EQ "3">
<tr>
	<td>Number of surveys distributed:</td>
	<td><input type="Text" name="numsurveydist"></td>
</tr>

<tr>
	<td>Number of surveys completed:</td>
	<td><input type="Text" name="numsurveycomp"></td>
</tr>

<cfelseif form.method2 EQ "4">
<tr>
	<td>Number of completed interviews:</td>
	<td><input type="Text" name="numint"></td>
</tr>

<cfelseif form.method2 EQ "5">
<tr>
	<td>Number of sites/businesses where observations took place:</td>
	<td><input type="Text" name="numsites"></td>
</tr>

</cfif>



<tr>
	<td valign="top">Dissemination Channels:</td>
	<td valign="top">
		<cfif listfind(form.disseminate,"1")>mailing<br></cfif>
		<cfif listfind(form.disseminate,"2")>website<br></cfif>
		<cfif listfind(form.disseminate,"3")>e-mails<br></cfif>
		<cfif listfind(form.disseminate,"4")>distribute at meetings<br></cfif>
		<cfif listfind(form.disseminate,"5")>give to support orgs for distribution</cfif>
		<cfif listfind(form.disseminate,"6")>Other</cfif>

	</td>
</tr>

<tr>
	<td valign="top">Dissemination Targets</td>
	<td valign="top">
		<cfif listfind(form.disseminated,"1")>orgs surveyed<br></cfif>
		<cfif listfind(form.disseminated,"2")>public / media<br></cfif>
		<cfif listfind(form.disseminated,"3")>regulatory agency<br></cfif>
		<cfif listfind(form.disseminated,"4")>TCP evaluation specialist<br></cfif>
		<cfif listfind(form.disseminated,"5")>TCP Area Manager<br></cfif>
		<cfif listfind(form.disseminated,"6")>Other<br></cfif>
	</td>
</tr>

<tr>
	<td>Results:</td>
	<td><textarea name="results" cols="80" rows="5"></textarea></td>
</tr>

<tr>
	<td>Conclusions:</td>
	<td><textarea name="conclusions" cols="80" rows="5"></textarea></td>
</tr>

<tr>
	<td>Lessons learned:</td>
	<td><textarea name="lessons" cols="80" rows="5"></textarea></td>
</tr>

</table>

<input type="Submit" value="Submit">


</cfform>
</div>


</body>
</html>
