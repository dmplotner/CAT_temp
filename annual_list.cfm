<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
<title>CAT</title>

<cfinclude template="CATstruct.cfm">

<cfif isDefined("url.NYP")>
	<cfset session.rptyr=session.fy+1>
<cfelse>
	<cfset session.rptyr=session.fy>
</cfif>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QcollabStrat">
select stratName, partners
from sharedActivities as s, useractivities as u
where u.activity=s.stratName
and u.year2=s.year2
and u.year2=#session.rptyr#
</cfquery>
<cfquery datasource="#Application.DataSource#"  		 
	password="#Application.db_password#"   		
	username="#Application.db_username#" name="Activities">
	
	select distinct activity
	from useractivities
	where 
	(userid = '#session.userid#' 
	or 
	activity in (<cfloop query="QcollabStrat">
			<cfif ListFind(partners, session.user_pk)>
				'#stratname#', 
			</cfif>
			</cfloop> 'NONE')
	)
	and (del <> 'Y' OR del IS NULL)
	and year2=#session.rptyr#
	
	order by 1
	
</cfquery>

<!---

<cfquery datasource="#Application.DataSource#"  		 
	password="#Application.db_password#"   		
	username="#Application.db_username#" name="test">
	
	select distinct userid
	from useractivities 
	where 
	(
	activity not in (<cfloop query="QcollabStrat">
			<cfif ListFind(partners, session.user_pk)>
				'#stratname#', 
			</cfif>
			</cfloop> 'NONE')
	)
	and (del <> 'Y' OR del IS NULL) 
	and year2=2007
	
	order by userid
	
</cfquery>

<cfoutput query="test">
#userid#<br>
</cfoutput>
--->
<table align="left" cellpadding="10" cellspacing="0" border="0"  class="box" width="100%">			 
<tr><td><br><br></td></tr>

<cfif isDefined("url.NYP")>
	<cfform action="cat_annual_strategy.cfm?NYP=1&#session.urltoken#" name="f1">
	<tr><td>Select a Strategy as entered in your annual workplan to edit:</td></tr>
<tr><td><cfselect name ="activityname" query="activities" value="activity"></cfselect></td></tr>
<tr><td><input type="Submit"></td></tr>


</cfform>
<cfelse>
<cfif activities.recordcount EQ 0>
<tr>
<td>
You must enter a new strategy in order to edit a strategy
</td>
</tr>

<cfelse>
	<cfform action="cat_annual_strategy.cfm?#session.urltoken#" name="f1">
	<tr><td>Select a Strategy as entered in your annual workplan to edit:</td></tr>
<tr><td><cfselect name ="activityname" query="activities" value="activity"></cfselect></td></tr>
<tr><td><input type="Submit" title="Submit" value="Submit"></td></tr>


</cfform>
</cfif>
</cfif>


</table> </td></tr>	

</table>

</body>

</html>
