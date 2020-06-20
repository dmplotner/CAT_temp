<cfif ((SESSION.modality NEQ 1 AND SESSION.modality NEQ 4) or SESSION.TCP EQ "1"  or  SESSION.admin EQ "1" or  SESSION.areamanage EQ "1") and session.cessman NEQ 4 and session.cessman NEQ 1>
     


<!--- <cfif (session.def_fy EQ session.fy) >
	<cflocation addtoken="yes" url="noFuture.cfm">
</cfif> --->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
<title>CAT Evaluations</title>



<cfinclude template="catstruct.cfm">

<script language="JavaScript">
</script>
<br><br>


<table width="75%" align="center" class="Table">
<tr>
<th><a href="evalmatrix.cfm">Evaluation Plan</a> </th>
</tr>
<tr><td align="center">Enter your local level impact evaluation plan here
</td></tr>
<tr><td>&nbsp;</td></tr>

<tr>
<th><a href="evaltools.cfm">Evaluation Tools &amp; Resources</a>
 </th></tr>
 <tr><td align="center">
 <cfif session.fy GT 2006>
 Access the Program Evaluation Toolkit and Protocol Review Form here
 <cfelse>
 Access the Program Evaluation Toolkit and Evaluation Project Approval Form here
 </cfif>
 </td></tr>
<tr><td>&nbsp;</td></tr>

<tr>
<th><a href="<!--- /manual/local eval report form 07-08.doc" target="_blank --->">Evaluation Final Report</a></th>
</tr>
<tr>
 <td align="center">
  Contact your evaluation specialist to submit your 08-09 local level evaluation report
<!--- Enter the findings of your local level impact evaluation here --->
 </td>
</tr>

<!--- <tr><td>&nbsp;</td></tr>
<tr>
<th><a href="<!--- /manual/Case study report form 07-08.doc" target="_blank --->">Case Study Report</a></th>
</tr>
<tr>
 <td align="center">
  <!--- Enter the findings of your case study here --->
 </td>
</tr> 
<tr><td>&nbsp;</td></tr> --->

</table>

<cfelse>
	<cflocation addtoken="yes" url="welcome.cfm">
</cfif>