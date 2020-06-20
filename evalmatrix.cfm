<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
<title>CAT Evaluation Planning Matrix</title>



<cfinclude template="catstruct.cfm">

<script language="JavaScript">
</script>
<br><br>

<div align="center" ><strong>Evaluation Plan</strong></div><br>

<table width="75%" align="center" class="Table">
<tr>
<td>
<cfif session.fy GT 2008>
Enter your evaluation plan, one project at a time.
Once you enter an evaluation project, it will appear in a grid below.  You may then enter additional evaluation projects.  You may use several different data collection methods to evaluate a single strategy (for example, you may evaluate a campaign with a written survey and in-person interviews). You may, alternatively, use one data collection method (such as a survey) to evaluate several different strategies in your annual plan.  
<cfelseif session.fy GT 2006>
Enter your evaluation plan, one method at a time. Survey instruments, telephone interview scripts, and observation checklists would be entered as unique evaluation data collection methods.  Together, all of these data collection methods make up your evaluation plan, just as your unique strategies together make up your annual work plan.
<cfelse>
Enter your evaluation plan, broken down by each specific data collection method you are using to evaluate your strategies.  Survey instruments, telephone interview scripts, and observation checklists would be entered as unique evaluation data collection methods.  Together, all of these data collection methods make up your evaluation plan, just as your unique strategies together make up your annual work plan.
</cfif>
<br><br></td>
</tr>

<cfif session.fy LTE 2008>
<tr>
	<td>
		Once you enter an evaluation method, it will appear in a grid below.  You may then enter additional evaluation methods.  You may use one data collection method (such as a survey) to evaluate several different strategies in your annual plan.  You may, alternatively, use several different data collection methods to evaluate a single strategy (for example, you may evaluate a campaign with a written survey and in-person interviews).  
	</td>
</tr>
</cfif>
</table>

<br><br>

<div align="center">
<button onClick="location.href='evalplan.cfm';">Enter new evaluation <cfif session.fy GT 2007>project<cfelse>method</cfif></button>
</div>

<br><br>

<div align="center">
<button onClick="location.href='delevalplan.cfm';">Delete an existing evaluation <cfif session.fy GT 2007>project<cfelse>method</cfif></button>
</div>


<br>


<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"  		
	username="#application.db_username#" name="MethDet">

select methodname, selectedstrategies as strat 
from evalm
where userid='#session.userid#'
and year2=#session.fy#
and methodname is not null
and methodname != ''

</cfquery>


<cfif MethDet.recordcount GT 0>
<table align="center" >
<tr>
<td>


<div align="left"><strong>Select an evaluation <cfif session.fy GT 2007>project<cfelse>method</cfif> to edit or view:</strong></div><br>
<table class="dictionary" cellpadding="5" border=".2" align="center">
<tr>
<th>&nbsp;</th>
<th>Goal 1</th>
<th>Goal 2</th>
<th>Goal 3</th>
<th>Goal 4</th>
<!--- <th>Goal 5</th>
<th>Goal 6</th> --->
</tr>


<cfoutput>
<cfloop query="MethDet">
<tr>
	<th align="left"><a href="evalplan.cfm?method2=#MethDet.methodname#">#MethDet.methodname#</a></th>
	<td colspan="6">&nbsp;</td>
</tr>

<cfif strat NEQ "">
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"  		
	username="#application.db_username#" name="StratDet">
	select activity, goal from useractivities 
	where 
	pk in (#MethDet.strat#)	
	and del is null
</cfquery>



<cfloop query="StratDet">
<tr>
	<td>&nbsp;&nbsp;&nbsp;#activity#</td>
	<td align="center"><cfif goal EQ 1>X<cfelse>&nbsp;</cfif></td>
	<td align="center"><cfif goal EQ 2>X<cfelse>&nbsp;</cfif></td>
	<td align="center"><cfif goal EQ 3>X<cfelse>&nbsp;</cfif></td>
	<td align="center"><cfif goal EQ 4>X<cfelse>&nbsp;</cfif></td>
	<!--- <td align="center"><cfif goal EQ 5>X<cfelse>&nbsp;</cfif></td>
	<td align="center"><cfif goal EQ 6>X<cfelse>&nbsp;</cfif></td> --->
</tr>

</cfloop>
</cfif>
</cfloop>
</table>
</cfoutput>

</td>
</tr>
</table>
<br>
</cfif>
 <table width="75%" align="center" class="Table">
 <tr>
 	<th>
		Sample Evaluation <cfif session.fy GT 2008>Project<cfelse>Methods</cfif>
	</th>
 </tr>
 <tr>
 	<td align="center">Below are some SAMPLE Evaluation <cfif session.fy GT 2008>Project<cfelse>Method</cfif> entries for you to review as you prepare your Evaluation Plan.

</td>
 </tr>
 <tr><td align="center"><br>For clearest image of samples, please print the pdf documents.<br></td></tr>
 
 
 <tr>
 	<td align="center"><a href="/evalSamples/EvalPlanSampleCP.pdf" target="_blank">Sample Evaluation <cfif session.fy GT 2007>Projects<cfelse>Methods</cfif>: CPs</a></td>
 </tr>
 <tr>
 	<td align="center"><a href="/evalSamples/EvalPlanSampleYP.pdf" target="_blank">Sample Evaluation <cfif session.fy GT 2007>Projects<cfelse>Methods</cfif>: YPs</a></td>
 </tr>

 
</table>
</body>
</html>
