<cfif url.rtype EQ "YTD">
	<cfset rpttype="YTD">
<cfelse>
	<cfset rpttype="monthly">
</cfif>

<cfquery datasource="#Application.DataSource#"  		 
	password="#Application.db_password#"   		
	username="#Application.db_username#" name="QFocusAreaN">	
	select descr
	from focusAreas 
	where year2=#session.fy#
	and num=#focusareaNum#
</cfquery>


 <cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QGenDescrip">
	
	select activity, goal, u.objective, o.objective as objdesc, targetgroup,
	startdate, enddate,state, tcpregional, tcparea,
	issues, levelchangesought,
	target2, foci, primsec
	from userActivities as u, objectives as o
	where u.strategy=#focusareaNum#
	and userid = '#session.userid#'  
	and u.objective=o.id
	and u.year2=#session.fy#
	and u.year2=o.year2	
</cfquery>
