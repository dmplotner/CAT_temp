<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
<title>CAT</title>

<cfinclude template="CATstruct.cfm">
<cfparam name="session.rptyr" default="#session.fy#">

<cfif isDefined("url.NYP")>
	<cfset session.rptyr=session.fy+1>
<cfelse>
	<cfset session.rptyr=session.fy>
</cfif>

	 


<table align="left" cellpadding="10" cellspacing="0" border="0" class="box" width="100%">		
<cfform name="Form1" action="Cat_annual_obj.cfm?#session.urltoken#">
<cfif isDefined("url.success") and url.success EQ "true">
	<tr><th colspan="3" align="center">You have successfully entered an item into your workplan<br>
	Please enter another item, or use the menu above to navigate<br>
	to another portion of the site</th></tr>
</cfif>





<cfoutput>
<cfquery datasource="#Application.DataSource#"  		 
	password="#Application.db_password#"   		
	username="#Application.db_username#" name="Goals">
   select program, progNum, rtrim(cast(progNum as char)) + ': ' + program as disp
   from program
   where year2=#session.rptyr#
   order by 2
</cfquery>
    <TR><TD><BR><BR><BR></TD></TR>
<tr><td>Fiscal year #session.rptyr#</td></tr>

    <tr>
       <td>Goal&nbsp;&nbsp;&nbsp;

       <cfselect query="Goals" name="programVal"  display="disp" value="progNum"></cfselect>
              

     </td>
   </tr>
</cfoutput>
<tr><td><input type="Submit" value="Submit"></td></tr>



</cfform></table></td></tr>	

</table>

</body>

</html>
