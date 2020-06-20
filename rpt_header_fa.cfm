
<cfif session.areamanage NEQ 1 and session.regionmanage NEQ "1" and session.statemanage NEQ "1">
	<cfquery datasource="#application.DataSource#"  		
		 
		password="#application.db_password#"   		
		username="#application.db_username#" name="QAlterquery1">
		<!--- select area
		from security 
		where userid ='#session.userid#' --->
		select r.region as area
		from security s, area as a, region as r
		where userid ='#session.userid#'
		and s.area=a.num
		and a.region=r.num
		and a.year2=r.year2
		and a.year2=#session.fy#
	</cfquery>
	
	<cfset form.area="#QAlterquery1.area#">	
	<cfset form.partner="#session.userid#">
<cfelseif  (session.areamanage EQ 1 OR session.regionmanage EQ "1")and session.statemanage NEQ "1">
	<cfquery datasource="#application.DataSource#"  		
		 
		password="#application.db_password#"   		
		username="#application.db_username#" name="QAlterquery2">
		<!--- select area
		from security 
		where userid ='#session.userid#' --->
		select r.region as area
		from security s, area as a, region as r
		where userid ='#session.userid#'
		and s.area=a.num
		and a.region=r.num
		and a.year2=r.year2
		and a.year2=#session.fy#
	</cfquery>
	
	<cfset form.area="#QAlterquery2.area#">	
</cfif> 



<table border=".5" width="100%" cellspacing="0" bgcolor="Silver">
<tr>
	<td colspan="3" align="center"><h3>
	 <!--- <cfif focusareaNum NEQ 0>  --->
	  <cfif form.rptType EQ 1>
	Detailed Monthly Strategy Report Entries
	<cfelse>
	Monthly Infrastructure Report Entries
	</cfif>
	</h3></td>
</tr>
<tr>
<td rowspan="2">
Report Organizational level:
</td><td>
<cfif isDefined("form.partner") and form.partner NEQ "ALL">
<cfquery datasource="#Application.DataSource#"  		 
	password="#Application.db_password#"   		
	username="#Application.db_username#" name="Qpartner">
select orgName
from contact
where userid='#form.partner#'	
</cfquery>
Partner: <cfoutput>#Qpartner.orgName#</cfoutput>



<cfelseif isDefined("form.region") and form.region NEQ "ALL">
<cfquery datasource="#Application.DataSource#"  		 
	password="#Application.db_password#"   		
	username="#Application.db_username#" name="Qarea">
	<!--- select area, num
	from area 
	where year2=#session.fy#
	and num = '#form.area#' --->
	
	select region as area, num
	from region 
	where year2=#session.fy#
	and num = '#form.region#'
	
	
	
</cfquery>
<!--- Area: --->Region:
<cfoutput>#QArea.area#
</td><td>

</cfoutput>
<cfelse>
State Wide
</cfif>
&nbsp;</td>

<cfif (isDefined("form.area") and form.Area EQ "ALL") or not isDefined("form.area")><td>&nbsp;</td></cfif>
</tr>
<tr>
<td colspan="2">
Modality: 
<cfif isDefined("form.modality") OR cgi.HTTP_REFERER contains "reporthandler_modSP">
	<cfif cgi.HTTP_REFERER contains "reporthandler_modSP">
		School Policy Partners
	<cfelseif form.modality EQ "1">
		Cessation Centers
	<cfelseif form.modality EQ "2">
		Community Partnerships
	<cfelseif form.modality EQ "3">
		Youth Partners
	<cfelseif form.modality EQ "4">
		School Policy Partners	
	<cfelse>
		All
	</cfif>
<cfelse>
		All
</cfif>
</td></tr>




 <!--- <cfif focusareaNum NEQ 0>  --->
	  <cfif form.rptType EQ 1>
<tr>

	<td rowspan="3">Strategy Category</td>

<td>

<cfif isDefined("form.goal") and form.Goal NEQ "ALL">
<cfquery datasource="#Application.DataSource#"  		 
	password="#Application.db_password#"   		
	username="#Application.db_username#" name="QGoal">
	Select program as goal
	from program
	where year2=#session.fy#	
	and progNum='#form.goal#'
	order by 1
</cfquery>
<cfoutput>#QGoal.goal#</cfoutput>
<cfelse>
All Goals
</cfif>
</td>
<td>
<cfif isDefined("form.objective") and form.objective NEQ "ALL" >

<cfquery datasource="#Application.DataSource#"  		 
	password="#Application.db_password#"   		
	username="#Application.db_username#" name="QObj">
	Select objective
	from objectives
	where year2=#session.fy#	
	and progNum=#form.goal#
	and id='#form.objective#'
	order by 1
</cfquery>
<cfoutput>#QObj.objective#</cfoutput>
<cfelse>
All Objectives
</cfif>
&nbsp;

</td>	
</tr>


<tr>
<td>Focus Area:</td>
<td>
<cfif isDefined("form.farea") and NOT listFind(form.farea,"ALL")>
<cfquery datasource="#Application.DataSource#"  		 
	password="#Application.db_password#"   		
	username="#Application.db_username#" name="QFarea">
	select num, descr
	from 
	FocusAreas	
	where num in (#form.farea#)
	and year2=#session.fy#
</cfquery>
<cfoutput>#valuelist(QFarea.descr,"<br>")#</cfoutput>
<cfelse>
All Focus Areas
</cfif>

</td>
</tr>
<tr>
	<td>Modality</td>
	<td>
<cfif isDefined("form.modality") OR cgi.HTTP_REFERER contains "reporthandler_modSP">
	<cfif cgi.HTTP_REFERER contains "reporthandler_modSP">
		School Policy Partners
	<cfelseif form.modality EQ "1">
		Cessation Centers
	<cfelseif form.modality EQ "2">
		Community Partnerships
	<cfelseif form.modality EQ "3">
		Youth Partners
	<cfelseif form.modality EQ "4">
		School Policy Partners	
	<cfelse>
		All
	</cfif>
<cfelse>
		All
</cfif>
	</td>
</tr>
</cfif>
<cfquery datasource="#Application.DataSource#"  		 
	password="#Application.db_password#"   		
	username="#Application.db_username#" name="Qsmonth">
	select mon
	from 
	months	
	where rank=#form.stmonth#
</cfquery>
<cfquery datasource="#Application.DataSource#"  		 
	password="#Application.db_password#"   		
	username="#Application.db_username#" name="Qemonth">
	select mon
	from 
	months	
	where rank=#form.endmonth#
</cfquery>
<tr>
	<td>Date Range: FY <cfif session.fy EQ 1904>2005 - 2006<cfelse><cfoutput>#evaluate(session.fy-1)# - #session.fy#</cfoutput></cfif></td>
	<td colspan="2"><cfoutput>#Qsmonth.mon# through #Qemonth.mon#</cfoutput></td>
</tr>
</table>
