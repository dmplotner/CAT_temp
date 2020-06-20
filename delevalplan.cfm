<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
<title>CAT</title>

<cfinclude template="catstruct.cfm">
<script LANGUAGE="JavaScript">
<!--
// Nannette Thacker http://www.shiningstar.net
function confirmSubmit()
{
var agree=confirm("Are you sure you wish to delete these Evaluation Methods?");
if (agree)
	return true ;
else
	return false ;
}
// -->
</script>



<cfset form.year=session.fy>

<cfif cgi.http_referer CONTAINS "delevalplan.cfm" and isDefined("form.delseq")>

<cfquery datasource="#application.DataSource#" 
	password="#application.db_password#" 	
	username="#application.db_username#" name="DelIndQ">
	Delete
	from eval_ind
	where userid='#session.userid#'
	and method in (select methodname from evalM where seq in (#form.delseq#))
	and year2=#session.fy#
</cfquery>
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="remStrategies">
	
Delete from evalM
where seq in (#form.delseq#)
</cfquery>

</cfif>


<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"  		
	username="#application.db_username#" name="MethDet">

select methodname,seq
from evalm
where userid='#session.userid#'
and year2=#session.fy#
and methodname is not null
and methodname != ''

</cfquery>


<cfif MethDet.recordcount GT 0>



<div align="center"><h3>Select an evaluation method to delete:</h3></div>
<table border="1" align="center" class="box">
<cfform action="delevalplan.cfm?#session.urltoken#" method="POST" >

<cfoutput>
<tr>
	<th>Evaluation Method</th>
	<th>Delete</th>	
</tr>
<cfloop query="MethDet">
<tr>
	<td>
		#methodname#
	</td>
	<td><input type="Checkbox" name="delseq" value="#seq#">Delete</td>
</tr>
</cfloop>
<tr><td colspan="2" align="center"><input type="Submit" value="DELETE STRATEGIES" onclick="return confirmSubmit();" class="DelButton"></td></tr>

</CFOUTPUT></cfform></table>
</cfif>

</body>
</html>
