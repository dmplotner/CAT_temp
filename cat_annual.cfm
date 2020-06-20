<cfif session.fy LT 2007 and session.fy GT 1920>
	<cfinclude template="cat_annual_goal.cfm">
<cfelse>
<cfif session.fy GT session.def_fy and session.nextyr NEQ 1>
	<cflocation addtoken="yes" url="noFuture.cfm">
</cfif>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>CAT</title>
<cfinclude template="CATstruct.cfm">
<script language="JavaScript">

function setvalues() {
for (var i=0; i < document.Form1.ObjVal.length; i++)
   {
   if (document.Form1.ObjVal[i].checked)
      {
      document.Form1.programVal.value = document.Form1.ObjVal[i].value.substring(0,1);
	  document.Form1.submit();
	  return true;
      }
   }
alert('Please select a Goal/Objective!');
return false;
}

 

</script>



<cfquery datasource="#Application.DataSource#"  		 
	password="#Application.db_password#"   		
	username="#Application.db_username#" name="sampleGoalobj">
	select
p.program as goal,
p.prognum as goalnum,
o.objective,
o.id as objnum
from program as p, objectives as o
where
p.year2=o.year2
and p.year2=#session.fy#
and p.prognum=o.prognum
and (o.del is null or o.del !=1)
order by p.prognum, o.rank
</cfquery>


<table class="box" align="left" cellpadding="10" cellspacing="0" border="0"  class="box" width="100%">
<cfform name="Form1" action="cat_annual_strategy.cfm?#session.urltoken#">
<input type="hidden" name="programVal" value="">
<tr>
	<td colspan="2">
		<table class="box">
	<cfoutput>
      <tr><td colspan="2"><h3>Goals and Objectives</h3><br><br></td></tr>
	  </cfoutput>
	  
	  <cfoutput query="sampleGoalobj" group="goalnum">
	  <tr>
	  	<th colspan="2" align="left">Goal #goalnum#: #goal#</th>
	  </tr>
	  <tr>
	  	<td>&nbsp;</td>
		<th align="left">Objective:</th>
	  </tr>
	  <cfoutput>
	  <tr>
	  	<td width="30" align="center"><input type="radio" name="ObjVal" value="#objnum#"></td>
		<td>#objective#</td>
	  </tr>
	  </cfoutput>
	  </cfoutput>
	  
	  </table>
	</td>
</tr>
<tr><td><input type="button" value="Submit" onClick="setvalues();"></td></tr>
</cfform>
</table>


</body>

</html>
</cfif>