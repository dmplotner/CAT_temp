<cfif session.fy GT session.def_fy>
	<cflocation addtoken="yes" url="noFuture.cfm">
</cfif>
<!--- <cfif session.fy EQ 2008><cflocation addtoken="yes" url="noFuture.cfm"></cfif>
 ---><!--- <cfif (session.def_fy EQ session.fy) >
	<cflocation addtoken="yes" url="noFuture.cfm">
</cfif> --->

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Quarterly Cessation Data</title>
<cfinclude template="catstruct.cfm">
<!--- <table class="box" width="100%">
<tr>
	<td><br><br><br></td>
</tr>
<tr>
	<th align="center">Please select a quarter to report cessation outcome data: </th>
</tr>

<tr>
	<td><br></td>
</tr>
<tr>
	<td align="center"><a href="QCess1.cfm?<cfoutput>#session.urltoken#</cfoutput>&Q=1">Quarter One (August-October)</a></td>
</tr>
<tr>
	<td align="center"><a href="QCess1.cfm?<cfoutput>#session.urltoken#</cfoutput>&Q=2">Quarter Two (November-January)</a></td>
</tr>
<tr>
	<td align="center"><a href="QCess1.cfm?<cfoutput>#session.urltoken#</cfoutput>&Q=3">Quarter Three (February-April)</a></td>
</tr>
<tr>
	<td align="center"><a href="QCess1.cfm?<cfoutput>#session.urltoken#</cfoutput>&Q=4">Quarter Four (May-July)</a></td>
</tr>
<tr>
	<td><br><br></td>
</tr>
<tr>
	<th align="center">Please enter patient population data for each collaborator that you will be working with this contract year:

</th>
</tr>

<tr>
	<td><br></td>
</tr>
<tr>
	<td align="center"><a href="A_Cess1.cfm?<cfoutput>#session.urltoken#</cfoutput>&Q=4">Patient population annual data</a></td>
</tr>
<tr>
</tr>
	<td><br><br></td>
</tr>
<tr>
	<th align="center">Please select a quarter to report collaborator policy and practice data: </th>
</tr>

<tr>
	<td><br></td>
</tr>
<tr>
	<td align="center"><a href="PolPractice1.cfm?<cfoutput>#session.urltoken#</cfoutput>&Q=1">Quarter One (August-October)</a></td>
</tr>
<tr>
	<td align="center"><a href="PolPractice1.cfm?<cfoutput>#session.urltoken#</cfoutput>&Q=2">Quarter Two (November-January)</a></td>
</tr>
<tr>
	<td align="center"><a href="PolPractice1.cfm?<cfoutput>#session.urltoken#</cfoutput>&Q=3">Quarter Three (February-April)</a></td>
</tr>
<tr>
	<td align="center"><a href="PolPractice1.cfm?<cfoutput>#session.urltoken#</cfoutput>&Q=4">Quarter Four (May-July)</a></td>
</tr>
	<td><br><br><br></td>
</tr>
</table>


<br><br>
 --->
<table class="box" width="100%">
<tr>
	<td><br><br><br></td>
</tr>
<tr>
	<th align="center" colspan="2">Please select a quarter to report <cfif session.fy LT 2009>either </cfif>Target HCPO <cfif session.fy LT 2009>policy and practice data or </cfif>outcome data </th>
</tr>

<tr>
	<td><br></td>
</tr>
<tr>
<td <cfif session.fy LT 2009>colspan="2"</cfif> align="center">
<table class="box" border="1" cellpadding="2">

<tr>
	<cfif session.fy LT 2009><th>Policy and practice data</th></cfif>
	<th>Outcome data</th>
</tr>
<tr>
	<cfif session.fy LT 2009><td align="center"><a href="PolPractice1.cfm?<cfoutput>#session.urltoken#</cfoutput>&Q=1">Quarter One (August-October)</a></td></cfif>
	<td align="center"><a href="QCess1.cfm?<cfoutput>#session.urltoken#</cfoutput>&Q=1">Quarter One (August-October)</a></td>
</tr>
<tr>
	<cfif session.fy LT 2009><td align="center"><a href="PolPractice1.cfm?<cfoutput>#session.urltoken#</cfoutput>&Q=2">Quarter Two (November-January)</a></td></cfif>
	<td align="center"><a href="QCess1.cfm?<cfoutput>#session.urltoken#</cfoutput>&Q=2">Quarter Two (November-January)</a></td>
</tr>
<tr>
	<cfif session.fy LT 2009><td align="center"><a href="PolPractice1.cfm?<cfoutput>#session.urltoken#</cfoutput>&Q=3">Quarter Three (February-April)</a></td></cfif>
	<td align="center"><a href="QCess1.cfm?<cfoutput>#session.urltoken#</cfoutput>&Q=3">Quarter Three (February-April)</a></td>
</tr>
<tr>
	<cfif session.fy LT 2009><td align="center"><a href="PolPractice1.cfm?<cfoutput>#session.urltoken#</cfoutput>&Q=4">Quarter Four (May-July)</a></td></cfif>
	<td align="center"><a href="QCess1.cfm?<cfoutput>#session.urltoken#</cfoutput>&Q=4">Quarter Four (May-July)</a></td>
</tr>
</table>
</td>
</tr>
<tr>
	<td><br><br></td>
</tr>
<tr>
	<th align="center" colspan="2">Please enter patient population data for each Target HCPO that you will be working with this contract year:

</th>
</tr>

<tr>
	<td><br></td>
</tr>
<tr>
	<td align="center" colspan="2"><a href="A_Cess1.cfm?<cfoutput>#session.urltoken#</cfoutput>&Q=4">Patient population annual data</a></td>
</tr>
<tr>
	<td><br><br><br></td>
</tr>

</table>
</body>
</html>
