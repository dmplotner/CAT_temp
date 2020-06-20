<cflocation  addtoken="No" url="unavailable.cfm?#session.urltoken#">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>

	<title>Edit Evaluation Reports</title>
	<cfinclude template="catstruct.cfm">
</head>

<body>
<div class="Table">
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="pullRecords">
	select method as method2, id_date
	from EvalR
	where 
	userid='#session.userid#'
	and year2=#session.fy#
	order by 1, 2	
</cfquery>

<cfoutput>
<h2> Evaluation Reports (click to edit)</h2>
<cfloop query="pullRecords">
<a href="evalrpt.cfm?method2=#method2#&date=#dateformat(id_date,'yyyy-mm-dd')#">#method2# #dateformat(id_date, 'm/dd/yyyy')#</a><br>
</cfloop>
</cfoutput>

</body></div>
</html>
