<cfif session.fy GT session.def_fy>
	<cflocation addtoken="yes" url="noFuture.cfm">
</cfif>
<!--- <cfif (session.def_fy EQ session.fy) and session.userid NEQ 'dplotner' and session.userid NEQ 'bmarkatos' and session.userid NEQ 'rav02'>
	<cflocation addtoken="yes" url="noFuture.cfm">
</cfif> --->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Quarterly Cessation Data</title>
<cfinclude template="catstruct.cfm">

<table class="box" width="100%">
<tr>
	<td><br><br><br></td>
</tr>
<tr>
	<th align="center" colspan="2">Please select a quarter to report either collaborator policy and practice data or outcome data </th>
</tr>

<tr>
	<td><br></td>
</tr>
<tr>
<td colspan="3" align="center">
<table class="box" border="1" cellpadding="2">

<tr>
	<th colspan="2">Policy Data</th>
	<th colspan="2">Outcome Data</th>
</tr>
<tr>
	<th>District-level Policy Report</th>
	<th>School-level Implementation and Enforcement</th>
	<th>Observational Data</th>
	<th>Staff Survey Data</th>
</tr>
<tr>
	<td align="center"><a href="QPP.cfm?<cfoutput>#session.urltoken#</cfoutput>&Q=1">Quarter One (Dec-Feb)</a></td>
	<td align="center"><a href="<cfif session.fy LT 2008>QPP2.cfm<cfelse>QPP3.cfm</cfif>?<cfoutput>#session.urltoken#</cfoutput>&Q=1">Quarter One (Dec-Feb)</a></td>
	<td align="center"><a href="QOD.cfm?<cfoutput>#session.urltoken#</cfoutput>&Q=1">Quarter One (Dec-Feb)</a></td>
	<td align="center"><a href="QSS.cfm?<cfoutput>#session.urltoken#</cfoutput>&Q=1">Quarter One (Dec-Feb)</a></td>
</tr>
<tr>
	<td align="center"><a href="QPP.cfm?<cfoutput>#session.urltoken#</cfoutput>&Q=2">Quarter Two (Mar-May)</a></td>
	<td align="center"><a href="<cfif session.fy LT 2008>QPP2.cfm<cfelse>QPP3.cfm</cfif>?<cfoutput>#session.urltoken#</cfoutput>&Q=2">Quarter Two (Mar-May)</a></td>
	<td align="center"><a href="QOD.cfm?<cfoutput>#session.urltoken#</cfoutput>&Q=2">Quarter Two (Mar-May)</a></td>
	<td align="center"><a href="QSS.cfm?<cfoutput>#session.urltoken#</cfoutput>&Q=2">Quarter Two (Mar-May)</a></td>
</tr>
<tr>
	<td align="center"><a href="QPP.cfm?<cfoutput>#session.urltoken#</cfoutput>&Q=3">Quarter Three (Jun-Aug)</a></td>
	<td align="center"><a href="<cfif session.fy LT 2008>QPP2.cfm<cfelse>QPP3.cfm</cfif>?<cfoutput>#session.urltoken#</cfoutput>&Q=3">Quarter Three (Jun-Aug)</a></td>
	<td align="center"><a href="QOD.cfm?<cfoutput>#session.urltoken#</cfoutput>&Q=3">Quarter Three (Jun-Aug)</a></td>
	<td align="center"><a href="QSS.cfm?<cfoutput>#session.urltoken#</cfoutput>&Q=3">Quarter Three (Jun-Aug)</a></td>
</tr>
<tr>
	<td align="center"><a href="QPP.cfm?<cfoutput>#session.urltoken#</cfoutput>&Q=4">Quarter Four (Sep-Nov)</a></td>
	<td align="center"><a href="<cfif session.fy LT 2008>QPP2.cfm<cfelse>QPP3.cfm</cfif>?<cfoutput>#session.urltoken#</cfoutput>&Q=4">Quarter Four (Sep-Nov)</a></td>
	<td align="center"><a href="QOD.cfm?<cfoutput>#session.urltoken#</cfoutput>&Q=4">Quarter Four (Sep-Nov)</a></td>
	<td align="center"><a href="QSS.cfm?<cfoutput>#session.urltoken#</cfoutput>&Q=4">Quarter Four (Sep-Nov)</a></td>
</tr>
</table>
</td>
</tr>
<tr>
	<td><br><br></td>
</tr>

</tr>

<tr>
	<td><br></td>
</tr>
<!--- <tr>
	<td align="center" colspan="2"><a href="A_Cess1.cfm?<cfoutput>#session.urltoken#</cfoutput>&Q=4">Patient population annual data</a></td>
</tr> --->
<tr>
	<td><br><br><br></td>
</tr>

</table>
</body>
</html>
