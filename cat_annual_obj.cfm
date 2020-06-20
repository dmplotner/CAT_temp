<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
<title>CAT</title>

<cfinclude template="CATstruct.cfm">


<cfparam name="session.rptyr" default="session.fy">
	 

<table align="left" cellpadding="10" cellspacing="0" border="0" class="box" width="100%">		





<cfform name="Form1" action="Cat_annual_strategy.cfm?#session.urltoken#">
<cfoutput><input type="Hidden" name="programVal" value="#form.programVal#"></cfoutput>
<cfoutput>
<cfquery datasource="#Application.DataSource#"  		 
	password="#Application.db_password#"   		
	username="#Application.db_username#" name="objective">
   select rtrim(cast(p.progNum as char)) + ': ' + p.program as program, p.progNum, o.objective, rank, o.id as objectiveNum
   from program as p, objectives as o
   where p.progNum = o.progNum
   and p.progNum= '#form.programVal#'
   and p.year2=#session.rptyr#
   and p.year2=o.year2
   order by 4
</cfquery>
  <tr><td>Fiscal year #session.rptyr#</td></tr>

    <tr>
       <td>Goal</td>
       <td>

       #objective.program#
              

     </td>
   </tr>
   
   <tr>
       <td>Objective</td>
       <td>

       <cfselect query="Objective" name="ObjVal"  display="objective" value="objectiveNum"></cfselect>
              

     </td>
   </tr>
   <cfif session.rptyr NEQ session.fy>
   		<input type="hidden" name="NYP" value="">
   </cfif>
</cfoutput>
<tr><td><input type="Submit" value="Submit"></td></tr>
</cfform>


</table></td></tr>	

</table>

</body>

</html>
