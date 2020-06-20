<script language="javascript">
function getCheckedValue(radioObj) {
	if(!radioObj)
		return "";
	var radioLength = radioObj.length;
	if(radioLength == undefined)
		if(radioObj.checked)
			return radioObj.value;
		else
			return "";
	for(var i = 0; i < radioLength; i++) {
		if(radioObj[i].checked) {
			return radioObj[i].value;
		}
	}
	return "";
}

function setAM(){
document.AMFback.AMsave.value=1;
document.AMFback.submit();
}
function checkAM(){
if (getCheckedValue(document.AMFback.AM_review)!=1){
alert('Please make sure to indicate that the End-of-Year Progress Report has been reviewed by Area Manager before submitting!');
return false
}
return true;
}
</script>

<cfoutput>
<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QAMFeedbackinfo">
select 
am_review,rpt_status,content,reflect,discrep_txt,barriers_comp,
barriers_build,gen_fdback,tba, cb_compdate, compdate
from am_eoy_feedback
where year2=#session.fy#
and userid=<cfif isDefined("url.usid")>'#url.usid#'<cfelse>'#session.userid#'</cfif>
</cfquery>
<hr>
<cfform name="AMFback" action="prc_eoy_am_detail.cfm">
<CFIF isDefined("URL.activ")>
<input type="hidden" name="activ" value="#URL.activ#">
</CFIF>
<input type="hidden" name="AMsave" value="">
<input type="hidden" name="compdate" value="#QAMFeedbackinfo.compdate#">
<input type="hidden" name="usid" value="<cfif isDefined("url.usid")>#url.usid#<cfelse>#session.userid#</cfif>">
<div style="width:80%">
<h3>Area Manager Feedback</h3>
</div>
<table class="Table2" width="90%" cellpadding="3">
<tr valign="top">
	<td width="30%">End-of-Year Progress Report reviewed by Area Manager</td>
	<td>
	<input type="radio" name="AM_review" value="1" <cfif QAMFeedbackinfo.recordcount EQ 1 and QAMFeedbackinfo.am_review EQ 1> checked</cfif>>Yes 
	<input type="radio" name="AM_review" value="0" <cfif QAMFeedbackinfo.recordcount EQ 0 or (QAMFeedbackinfo.recordcount EQ 1 and QAMFeedbackinfo.am_review NEQ 1)> checked</cfif>>No </td>
	
	<td>
	<input type="radio" name="rpt_status" value="1"<cfif QAMFeedbackinfo.recordcount EQ 1 and QAMFeedbackinfo.rpt_status EQ 1> checked</cfif>> EOY report is complete
	<input type="radio" name="rpt_status" value="0"<cfif QAMFeedbackinfo.recordcount EQ 1 and QAMFeedbackinfo.rpt_status EQ 0> checked</cfif>> EOY report is incomplete
	</td>

</tr>
<!--- <!--- <tr><td>&nbsp;</td></tr>
<tr valign="top">
	<td>&nbsp;</td> --->
	<tr valign="top"><td>&nbsp;</td><td><input type="radio" name="rpt_status" value="1"<cfif QAMFeedbackinfo.recordcount EQ 1 and QAMFeedbackinfo.rpt_status EQ 1> checked</cfif>> Report is complete<!--- </td> --->
<!--- </tr>
<tr valign="top">
	<td>&nbsp;</td> 
	<td>---><br><input type="radio" name="rpt_status" value="0"<cfif QAMFeedbackinfo.recordcount EQ 1 and QAMFeedbackinfo.rpt_status EQ 0> checked</cfif>> Report is incomplete</td>
</tr> --->
<tr><td>&nbsp;</td></tr>
<tr valign="top">
	<td>Content of report is consistent with CAT reporting</td>
	<td>
	<input type="radio" name="content" value="1"<cfif QAMFeedbackinfo.recordcount EQ 1 and QAMFeedbackinfo.content EQ 1> checked</cfif>>Yes 
	<input type="radio" name="content" value="0"<cfif QAMFeedbackinfo.recordcount EQ 1 and QAMFeedbackinfo.content EQ 0> checked</cfif>>No </td>
</tr>

<tr><td>&nbsp;</td></tr>
<tr valign="top">
	<td>From an Area Manager point of view, does the information within the report accurately reflect the partner's progress this past contract year?</td>
	<td colspan="2">
	<input type="radio" name="reflect" value="1"<cfif QAMFeedbackinfo.recordcount EQ 1 and QAMFeedbackinfo.reflect EQ 1> checked</cfif>>Yes 
	<input type="radio" name="reflect" value="0"<cfif QAMFeedbackinfo.recordcount EQ 1 and QAMFeedbackinfo.reflect EQ 0> checked</cfif>>No 
	
	<br><br>If No, please state discrepencies:<br>
	<cfif cgi.PATH_INFO contains 'EOY_progress.cfm'>
	#QAMFeedbackinfo.discrep_txt#
	<cfelse>
	<textarea name="discrep_txt" cols="120" rows="5"><cfif QAMFeedbackinfo.recordcount EQ 1>#QAMFeedbackinfo.discrep_txt#</cfif></textarea>
	</cfif>
	</td>
</tr>

<tr><td>&nbsp;</td></tr>
<tr valign="top">
	<td>
<cfif session.modality NEQ 4>On '06-'07 status report page "actions to address barriers" section is completed and consistent with CAT entries and '07-'08 (year 4) workplan strategies.
<cfelse>"Actions to address barriers" sections are completed and consistent with CAT entries and '07-'08 workplan strategies.
</cfif>
	</td>
	<td>
	<input type="radio" name="barriers_comp" value="1"<cfif QAMFeedbackinfo.recordcount EQ 1 and QAMFeedbackinfo.barriers_comp EQ 1> checked</cfif>>Yes 
	<input type="radio" name="barriers_comp" value="0"<cfif QAMFeedbackinfo.recordcount EQ 1 and QAMFeedbackinfo.barriers_comp EQ 0> checked</cfif>>No </td>
</tr>

<tr><td>&nbsp;</td></tr>
<tr valign="top">
	<td>
<cfif session.modality NEQ 4>Partner describes how year 4 activities will build on year 3 successes and this section is consistent with year 4 workplan
<cfelse>Partner describes how year 3 activities will build on year 2 successes and this section is consistent with year 3 workplan
</cfif>
	</td>
	<td>
	<input type="radio" name="barriers_build" value="1"<cfif QAMFeedbackinfo.recordcount EQ 1 and QAMFeedbackinfo.barriers_build EQ 1> checked</cfif>>Yes 
	<input type="radio" name="barriers_build" value="0"<cfif QAMFeedbackinfo.recordcount EQ 1 and QAMFeedbackinfo.barriers_build EQ 0> checked</cfif>>No </td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr valign="top">
	<td>General Feedback:</td>
	<td colspan="2">
	<cfif cgi.PATH_INFO contains 'EOY_progress.cfm'>
	#QAMFeedbackinfo.gen_fdback#
	<cfelse>
	<textarea name="gen_fdback" cols="120" rows="7"><cfif QAMFeedbackinfo.recordcount EQ 1>#QAMFeedbackinfo.gen_fdback#</cfif></textarea>
	</cfif>
	</td>
</tr>
<tr valign="top">
	<td>Items that need to be addressed:</td>
	<td colspan="2">
		<cfif cgi.PATH_INFO contains 'EOY_progress.cfm'>
	#QAMFeedbackinfo.tba#
	<cfelse>
		<textarea name="tba" cols="120" rows="7"><cfif QAMFeedbackinfo.recordcount EQ 1>#QAMFeedbackinfo.tba#</cfif></textarea>
		<input type="button" value="Check Spelling" onClick="spell('document.AMFback.discrep_txt.value', 'document.AMFback.gen_fdback.value','document.AMFback.tba.value')">
	</cfif>
	</td>
</tr>

<tr>
	<td colspan="3"><input type="checkbox" name="cb_compdate" value="1" <cfif isDefined("QAMFeedbackinfo.cb_compdate") and QAMFeedbackinfo.cb_compdate EQ 1> checked</cfif>>EOY report contains all recommended edits and is complete to Area Manager satisfaction (when checked).
	<cfif QAMFeedbackinfo.compdate NEQ ""> (#dateformat(QAMFeedbackinfo.compdate,"mm/dd/yyyy")#)</cfif> </td>
</tr>
<cfif isDefined("url.usid")>
<tr>
<td><input type="button" value="Save" onClick="setAM();"></td>
</tr>
<tr>
<td><input type="submit" value="Submit Feedback" onClick="return checkAM();"></td>
</tr>
</cfif>
</table>



</cfform>
</cfoutput>