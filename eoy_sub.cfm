<SCRIPT LANGUAGE="JavaScript" SRC="RegExpValidate.js"></SCRIPT>
<script language="JavaScript" src="../spellchecker/spell.js"></script>
<script language="javascript">
function checkContAmt(){


document.EOYStatus.contamt.value=removeCommas(removeCurrency(document.EOYStatus.contamt.value));
if (!validateNumeric(document.EOYStatus.contamt.value)){
alert("Please enter a numeric value for dollar amount of contract.");
return false;
}
document.EOYStatus.submit();
}


function setSave2(){
	  document.EOYStatus.compTCP.disabled=false;
      document.EOYStatus.compTCP.value=1;
      
      }
</script>
<cfset tempsht = "">
<cfif  session.modality EQ 4 or (isDefined("modal") and modal EQ "sp")>
		<cfset tempsht="&modal=SP">
</cfif>
<cfoutput>
<cfform action="upd_eoybasic.cfm?#session.urltoken##tempsht#" name="EOYStatus">


<!--- <cfif session.modality EQ 4 or (isDefined("modal") and modal EQ "sp")>
	<cfform  action="upd_eoybasic.cfm?#session.urltoken#&modal=##QUserinfo.modality##" name="EOYStatus">
<cfelse>
	<cfform  action="upd_eoybasic.cfm?#session.urltoken#&modal=##QUserinfo.modality##" name="EOYStatus">
</cfif> --->

<input type="hidden" name="compTCP" value="">
<!--- <cfif isDefined("url.modal")>
		<cfform  action="upd_eoybasic.cfm?modal=#url.modal#&#session.urltoken#" name="EOYStatus">
<cfelse>
	<cfform  action="upd_eoybasic.cfm?#session.urltoken#" name="EOYStatus">
</cfif> --->




<table class="Table2" width="90%">
<tr>
	<td width="30%">Partner Name:</td>
	<td>#QUserinfo.orgname#</td>
</tr>
<tr>
	<td>Fiscal Agency Name:</td>
	<td>#QUserinfo.agent#</td>
</tr>
<tr>
	<td>Counties included in catchment area:</td>
	<td>#QUserinfo.countylist#</td>
</tr>
<tr>
	<td>Contract Number:</td>
	<td><cfif QUserinfo.grantNum EQ ""><font color="##FF0000">Contract ## missing. Please enter by going to the Administration header and the Contact Info screen.</font><Cfelse>#QUserinfo.grantNum#</cfif></td>
</tr>

<tr valign="top">
	<td>Annual contract amount<cfif session.modality NEQ 4> *</cfif>:</td>
	<td>
	<cfif (cgi.PATH_INFO contains 'EOY_AM_Detail.cfm') or (QRptbasics.complete EQ 1 or (isdefined("url.usid") and session.userid NEQ url.usid))>
	$#QRptbasics.contamt#
	<cfelse>
	$<input type="text" size="15" name="contamt" <cfif QRptbasics.recordcount NEQ 0> value="#QRptbasics.contamt#" </cfif> >

	</cfif><cfif session.modality NEQ 4>*Community Partnerships should exclude program support media dollars.</cfif>
	</td>
</tr>

<tr>
	<td>Modality:</td>
	<td>#QUserinfo.modality#</td>
</tr>


<tr valign="top">
	<td>Name of person completing report:</td>
	<td>
	<cfif (cgi.PATH_INFO contains 'EOY_AM_Detail.cfm') or (QRptbasics.complete EQ 1 or (isdefined("url.usid") and session.userid NEQ url.usid))>
	#QRptbasics.namesig#
	<cfelse>
		<input type="text" size="50" name="namesig" <cfif QRptbasics.recordcount NEQ 0> value="#QRptbasics.namesig#"</cfif>>

	</cfif>
	</td>
</tr>
<tr valign="top">
	<td valign="top">Agency Director approving report:</td>
	<td>
	<cfif (cgi.PATH_INFO contains 'EOY_AM_Detail.cfm') or (QRptbasics.complete EQ 1 or (isdefined("url.usid") and session.userid NEQ url.usid))>
	#QRptbasics.agencydir#
	<cfelse>
	<input type="text" size="50" name="agencydir"<cfif QRptbasics.recordcount NEQ 0> value="#QRptbasics.agencydir#"</cfif>>
	</td>
	</cfif>
</tr>

<tr valign="top">
	<td valign="top">Describe 5-10 of your program's most significant accomplishments during the past 12 months</td>
	<td>
		<cfif (cgi.PATH_INFO contains 'EOY_AM_Detail.cfm') or (QRptbasics.complete EQ 1 or (isdefined("url.usid") and session.userid NEQ url.usid))>
	#replace(QRptbasics.accomp,chr(13), '<br>', 'ALL')#
	<!--- <pre>#QRptbasics.accomp#</pre> --->
	<cfelse>	
	<textarea name="accomp" cols="120" rows="8"><cfif QRptbasics.recordcount NEQ 0>#QRptbasics.accomp#</cfif></textarea>
	</cfif></td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr valign="top">
	<td valign="top">
		
		Describe how you will build on these accomplishments in the #session.fy#-#evaluate(session.fy + 1)# contract year to achieve tobacco control program goals and objectives</td>
	<td>
	<cfif (cgi.PATH_INFO contains 'EOY_AM_Detail.cfm') or (QRptbasics.complete EQ 1 or (isdefined("url.usid") and session.userid NEQ url.usid))>
	#replace(QRptbasics.goals,chr(13), '<br>', 'ALL')#
	<!--- <pre>#QRptbasics.goals#</pre> --->
	<cfelse>
	<textarea name="goals" cols="120" rows="8"><cfif QRptbasics.recordcount NEQ 0>#QRptbasics.goals#</cfif></textarea>
	<input type="button" value="Check Spelling" onClick="spell('document.EOYStatus.accomp.value', 'document.EOYStatus.goals.value')">
	</cfif>
</td>
</tr>
<cfif ((isdefined("url.usid") and session.userid EQ url.usid ) or (not isDefined("url.usid")) AND (QRptbasics.recordcount EQ 0 OR QRptbasics.complete NEQ 1))>

<tr valign="top">
	<td colspan="2" align="left">
	<input type="button" value="Save" class="AddButton" onClick="checkContAmt();">
	</td>
</tr>
</cfif>
</table>
<cfoutput>
<script language="javascript">



function disableme(){
for(var intloop=0; intloop <document.EOYStatus.length; intloop++){
document.EOYStatus[intloop].disabled=true;
}
}
</script>
</cfoutput>


<cfif QRptbasics.complete EQ 1 or (isdefined("url.usid") and session.userid NEQ url.usid)>
<script language="JavaScript">
	disableme();
</script>
</cfif>

<cfif session.modality EQ 4 or (isDefined("modal") and modal EQ "sp")>
	<cfinclude template="eoy_sp_sub.cfm">
</cfif>


<cfif session.modality NEQ 4 and ((isDefined("modal") and modal NEQ "sp") OR NOT isDefined("modal"))>

<div style="width:80%">
<h3>Strategy Status Report</h3>
<!-- For each outcome included in your 2006-2007 work plan, please indicate the status of the outcome (met, unmet, progressing).  If the outcome was unmet, please briefly describe the barriers to meeting the outcome and the actions you will take to address the barriers in the coming year.  Provide measurements for your outcome (baseline, current and target).  "Baseline" refers to the outcome prior to your intervention; "Current" refers to the outcome at the end of the contract year; and "Target" refers to the outcome you hoped to achieve.
 --></div>
<div>Click on each link below to update this information for each strategy. Your reported status is summarized next to each link.</div>
<table class="Table2" width="90%">
<tr>
	<th align="left">Strategy Name</th>
	<th align="left">Status</th>
</tr>
<cfloop query="QRptinfo">
<tr>
	<td><a href="EOY_detail.cfm?#session.urltoken#&activ=#URLEncodedFormat(activity)#&usid=#URLEncodedFormat(session.userid)#">#activity#</a></td>
	<td><cfif status EQ 'Not Entered'><font color="##FF0000">Not Entered</font><cfelse>#status#</cfif></td>
</tr>
<tr><td colspan="2"><hr></td>
</tr>
</cfloop>
</table>
</cfif>

<!--- <cfform  action="upd_eoybasic.cfm?#session.urltoken#" name="EOYStatus2"> --->
<script language="javascript">
function changeform(){
<cfif session.modality EQ 4>
myOption = -1;
for (i=document.EOYStatus.sm1_status.length-1; i > -1; i--) {
if (document.EOYStatus.sm1_status[i].checked) {
myOption = i; i = -1;
}
}
if (myOption == -1) {
alert("You must select a radio button for Status of SMART Outcome 1");
return false;
}
myOption = -1;
for (i=document.EOYStatus.sm2_status.length-1; i > -1; i--) {
if (document.EOYStatus.sm2_status[i].checked) {
myOption = i; i = -1;
}
}
if (myOption == -1) {
alert("You must select a radio button for Status of SMART Outcome 2");
return false;
}

</cfif>
var agree=confirm("Once you mark your End of Year report as complete, you will not be able to edit it. Are you sure you want to mark your report as complete now?");
if (agree){
	document.EOYStatus.completed.value=1;
	document.EOYStatus.action='upd_eoybasic.cfm?#session.urltoken#&statusC=comp';
}
else
	return false ;
}
</script>
<cfif (isdefined("url.usid") and session.userid EQ url.usid) OR not isDefined("url.usid")>
<table class="Table2" width="90%">
<tr>
	<td colspan="2">
	<cfif QRptbasics.recordcount NEQ 0 and QRptbasics.complete EQ 1>
	<strong>You have marked your EOY report as complete</strong>.
	<cfelse>
	Click the button below to indicate that you have completed your EOY report. After you submit your report, you will not be able to make additional changes to your End of Year Report. 
	</cfif>
	</td>
</tr>
<tr>
	<td>
	
 	<input type="hidden" name="completed" value="0" > 
	</td>
	<cfif QRptbasics.recordcount EQ 0 OR QRptbasics.complete NEQ 1>
	<td>
	<br><input type="submit" <cfif QRptbasics.recordcount NEQ 0 and QRptbasics.complete EQ 1> value="Completed"disabled <cfelse>value ="Submit completed EOY report now"  onclick="return changeform();" </cfif> >
	</td>
	</cfif>
</tr>
</table>
<cfelse>
<table class="Table2" width="90%">
<tr>
	<td colspan="2">
<cfif QRptbasics.recordcount NEQ 0 and QRptbasics.complete EQ 1>
	EOY report has been marked as complete.
	<script language="javascript">
	<!--- disableme(); --->
	</script>
	<cfelse>
	EOY report has NOT been marked as complete.
	</cfif>
</cfif>
</td>
</tr>
</table>
<!--- </cfform> --->
<br><br>
<cfinclude template="eoy_tcp_feedback.cfm">


</cfform>
</cfoutput>
