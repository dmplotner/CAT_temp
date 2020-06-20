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
var agree=confirm("Are you sure you wish to delete these STRATEGIES?");
if (agree)
	return true ;
else
	return false ;
}
// -->
</script>



<cfset form.year=session.fy>

<cfif cgi.http_referer CONTAINS "rem_strategy.cfm" and isDefined("form.delseq")>
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="remStrategies">
	
Update useractivities
set Del = 'Y'
where pk in (#form.delseq#)
and userid = '#session.userid#'	
and year2=#session.fy#
</cfquery>

</cfif>


<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="dispStrategies">
	
select activity, pk as seq
from useractivities 
where userid = '#session.userid#'

and (del is Null or del <> 'Y')
and year2=#session.fy#
order by activity

</cfquery>




<CFOUTPUT>
<table border="1" align="center" class="box">
<cfform action="rem_strategy.cfm?#session.urltoken#" method="POST" >

<tr>
	<th>Strategy</th>
	<th>Delete</th>
	
</tr>
<cfloop query="dispStrategies">
<tr>
	<td><font color="Green">#activity#</font></td>
	<td><input type="Checkbox" name="delseq" value="#seq#">Delete</td>
		
</tr>
</cfloop>
<tr><td colspan="2" align="center"><input type="Submit" value="DELETE STRATEGIES" onclick="return confirmSubmit();" class="DelButton"></td></tr>

</cfform></table></CFOUTPUT>


</body>
</html>
