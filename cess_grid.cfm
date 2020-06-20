<!--- <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
<title>CAT</title>

<cfinclude template="catstruct.cfm"> --->
<br><br><br>
<script language="JavaScript">


function setgo(tabletype){
document.monthlyActivity.handler.value=tabletype;
document.monthlyActivity.action="Cess1.cfm<cfoutput>?#session.urltoken#</cfoutput>";
document.monthlyActivity.submit();
}
</script>

<cfif isDefined("url.handler")><cfset form.handler='#url.handler#'></cfif>
<!--- <cfform name="f1" action="cess1.cfm"> --->
<input type="hidden" name="handler" value="">
<table align="left" width="50%" class="box">
<tr>
	<th>
		Click on each button below to access screens for this monthly strategy report
	</th>
</tr>
<!--- <tr>
	<!--- <td>Policy and Practice</td> --->
	<td align="center"><input type="Button" value="Policy and Practice" style="width:300;" onclick="setgo('one');"></td>
</tr> --->
<tr>
	<!--- <td>Mini-grants</td> --->
	<td align="center"><input name="Butt_one"  type="Button" value="<cfif session.fy LT 2007>Mini-grants<cfelse>Stipends and Mini-grants</cfif>" style="width:300;" onclick="setgo('two');"></td>
</tr>
<tr>
	<!--- <td>Administrative Commitment</td> --->
	<td align="center"><input name="Butt_two" type="Button" value="Administrative Commitment" style="width:300;" onclick="setgo('three');"></td>
</tr>
<tr>
	<!--- <td>Training</td> --->
	<td align="center"><input name="Butt_three" type="Button" value="Training" style="width:300;" onclick="setgo('four');"></td>
</tr>
<tr>
	<!--- <td>Technical Assistance</td> --->
	<td align="center"><input name="Butt_four" type="Button" value="Technical Assistance" style="width:300;" onclick="setgo('five');"></td>
</tr>
<cfif session.fy GT 2008>
<tr>
	<!--- <td>baseline assessment</td> --->
	<td align="center"><input name="Butt_five" type="Button" value="Baseline Assessment" style="width:300;" onclick="setgo('six');"></td>
</tr>
<tr>
	<!--- <td>policy and practice changes</td> --->
	<td align="center"><input name="Butt_six" type="Button" value="Policy and Practice Changes" style="width:300;" onclick="setgo('seven');"></td>
</tr>
</cfif>
</table>
<!--- </cfform> 
</body>
</html>
--->