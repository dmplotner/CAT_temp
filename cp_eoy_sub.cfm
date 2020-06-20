<SCRIPT LANGUAGE="JavaScript" SRC="RegExpValidate.js"></SCRIPT>
<script language="JavaScript" src="spellchecker/spell.js"></script>
<script language="javascript">
function checkContAmt(){


<!--- document.EOYStatus.contamt.value=removeCommas(removeCurrency(document.EOYStatus.contamt.value));
if (!validateNumeric(document.EOYStatus.contamt.value)){
alert("Please enter a numeric value for dollar amount of contract.");
return false;
}
if (!(isInteger(document.EOYStatus.retailnum.value) && (document.EOYStatus.retailnum.value != '') && isInteger(document.EOYStatus.orgnum.value) && (document.EOYStatus.orgnum.value != '') && isInteger(document.EOYStatus.govtnum.value) && (document.EOYStatus.govtnum.value != '') && isInteger(document.EOYStatus.qline1.value) && (document.EOYStatus.qline1.value != '') && isInteger(document.EOYStatus.qline2.value) && (document.EOYStatus.qline2.value != '')&& isInteger(document.EOYStatus.qlinenum.value) && (document.EOYStatus.qlinenum.value != ''))){
      alert ('Please make sure all numeric fields have integer values, and not text or blanks.');
      return false;
      }--->
<cfif SESSION.areamanage EQ "1" OR SESSION.admin EQ "1" OR SESSION.TCP EQ "1" OR SESSION.CessMan contains "1" or session.areamanage EQ 1 or session.admin eq 1>
	 document.EOYStatus.btn.value='tcp';
	 <cfelse>
	 document.EOYStatus.btn.value='partner';
	 </cfif> 
document.EOYStatus.submit();
}
</script>
<cfoutput>

<cfif session.areamanage EQ 1 or session.cessman contains 1 or session.admin is 1>
<cfset read = 1>
<cfelse>
<cfset read = 0>
</cfif>

<cfform  action="upd_eoybasic.cfm?#session.urltoken#" name="EOYStatus">

<table class="Table2" width="90%">
<tr>
	<td width="30%">Partner Name:</td>
	<td>#QUserinfo.orgname#</td>
</tr>
<tr>
	<td>Name of person completing report:</td>
	<td>
		<input type="text" size="50" name="namesig" <cfif QRptbasics.recordcount NEQ 0> value="#QRptbasics.namesig#"</cfif> <cfif read is 1>readonly class="readonly"</cfif>>
	</td>
</tr>
<tr>
	<td>Agency Director approving report:</td>
	<td>
	<input type="text" size="50" name="agencydir"<cfif QRptbasics.recordcount NEQ 0> value="#QRptbasics.agencydir#"</cfif> <cfif read is 1>readonly class="readonly"</cfif>>
	</td>
<tr>
	<td>Contract amount:</td>
	<td>
	$<input type="text" size="15" name="contamt" <cfif QRptbasics.recordcount NEQ 0> value="#QRptbasics.contamt#" </cfif> <cfif read is 1>readonly class="readonly"</cfif>>
	</td>
</tr>

<tr valign="top">
	<td valign="top">Describe 5-10 of your program's most significant accomplishments during the past 12 months:</td>
	<td>
	<textarea name="accomp" cols="120" rows="8" <cfif read is 1>readonly class="readonly"</cfif>><cfif QRptbasics.recordcount NEQ 0>#QRptbasics.accomp#</cfif></textarea>
    <cfif session.fy GT 2008>
	<br>
	<input type="button" value="Check Spelling" onClick="spell('document.EOYStatus.accomp.value')">
	</cfif>
	</td>
</tr>
<tr><td>&nbsp;</td></tr>
<cfif session.fy EQ 2008>
<tr valign="top">
	<td valign="top">Describe how you will build on these accomplishments in the 2008-2009 contract year to achieve tobacco control program goals and objectives:</td>
	<td>
	<textarea name="goals" cols="120" rows="8" <cfif read is 1>readonly class="readonly"</cfif>><cfif QRptbasics.recordcount NEQ 0>#QRptbasics.goals#</cfif></textarea><br>
	<input type="button" value="Check Spelling" onClick="spell('document.EOYStatus.accomp.value', 'document.EOYStatus.goals.value')">
</td>
</tr>
</cfif>
<cfif ((isdefined("url.usid") and session.userid EQ url.usid ) or (not isDefined("url.usid")) AND (QRptbasics.recordcount EQ 0 OR QRptbasics.complete NEQ 1))>

<tr valign="top">
	<td colspan="2" align="left">
	<input type="button" value="Save" class="AddButton" onClick="checkContAmt();">
	</td>
</tr>
</cfif>
</table>
<!--- 
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
--->

<!--- <cfif session.modality is 'cc'></cfif>
 --->	



	<cfinclude template="eoy_cp_sub.cfm">


<!--- 

<cfif session.modality NEQ 4>

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
	<td><a href="file:///R|/htdocs/prod/EOY_detail.cfm?#session.urltoken#&activ=#URLEncodedFormat(activity)#&usid=#URLEncodedFormat(session.userid)#">#activity#</a></td>
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
<cfif ((isdefined("url.usid") and session.userid EQ url.usid) OR not isDefined("url.usid")) AND not isDefined("tempusermodality")>
<table class="Table2" width="90%">
<tr>
	<td colspan="2">
	<cfif QRptbasics.recordcount NEQ 0 and QRptbasics.complete EQ 1>
	<script language="javascript">
	disableme();
	</script>

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
	disableme();
	</script>
	<cfelse>
	EOY report has NOT been marked as complete.
	</cfif>
</cfif>
</td>
</tr>
</table>
<!--- </cfform> --->


 --->
</cfform>
</cfoutput>
