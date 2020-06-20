<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
<title>CAT</title>
<script language="JavaScript" src="../spellchecker/spell.js"></script>
<script language="javascript">
function disableme(){
for(var intloop=0; intloop <document.AMFeedback.length; intloop++){
document.AMFeedback[intloop].disabled=true;
}
}
function setSave(){
document.AMFeedback.sendM.value=1;
return true;
}
function setSave2(){
document.AMFeedback.sendM.value=2;
document.AMFeedback.submit();
}
</script>

<cfif not isdefined("url.activ")>
<cfif isDefined("form.partnerName")>
 <cfset url.activ=form.partnerName>
<cfelse>
<cflocation url="AM_feedback_list.cfm" addtoken="yes">
</cfif>
</cfif>

<cfif not isdefined("url.mon")>
	<cfset url.mon=form.rptMon>
</cfif>


<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QUserinfo">
	select orgname
	from contact
	where userid='#url.activ#'	
</cfquery>

<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QRptinfo">
	select 
	review_status,
	review_progress,
	feedback, date_upd, date_init,
	partner_status, partner_date, partner_update,
	report_status, issues
	from AM_Feedback
	where partner_id='#url.activ#'	
	and month2='#url.mon#'
	and year2=#session.fy#
</cfquery>
 
<cfinclude template="CATstruct.cfm">
<cfoutput>
<cfform action="AM_feedback_process.cfm" name="AMFeedback">
<input type="hidden" name="partnerid" value="#url.activ#">
<input type="hidden" name="rptMon" value="#url.mon#">
<input type="hidden" name="sendM" value="0">

<table class="Table2" width="90%">
<tr>
	<td>&nbsp;</td>
</tr>

<tr>
	<td colspan="2">
		#Quserinfo.orgname#
	</td>
</tr>
<tr>
	<td colspan="2">
			<cfif session.fy EQ 1904>
			Fiscal Year 2006-2007
			<cfelse>
			Fiscal Year #evaluate(session.fy-1)#-#evaluate(session.fy)#
			</cfif>
	</td>
</tr>

<tr>
	<td colspan="2">
			#URL.MON#
	</td>
</tr>

<tr>
	<td>&nbsp;</td>
</tr>

<tr>
	<td colspan="2">
		Feedback Date: #dateformat(QRptinfo.date_upd, "mmm dd,yyyy")#
	</td>
</tr>

<tr>
	<td>&nbsp;</td>
</tr>

<tr>
	<td width=65%>
	
		<cfif http_referer does not contain "AM_Feedback_list.cfm" AND not isDefined ("url.mm")>
		Your <cfif session.fy LTE 2008>Area<Cfelse>Contract</cfif> Manager has reviewed your Monthly Strategy Reports this month.
		<cfelse>
		I have reviewed the Monthly Strategy Reports for this partner for this month.<!--- the Monthly Strategy Reports for this partner for this month. --->
		</cfif>
		</td>
		<td valign="middle">
		<cfif http_referer does not contain "AM_Feedback_list.cfm" AND not isDefined ("url.mm")>		
		
		<cfif isDefined("QRptinfo.review_status") and QRptinfo.review_status EQ 1>
			<img src="images/selected_button.jpg" align="middle">
		<cfelse>
			<img src="images/open_button.jpg" align="middle">
		</cfif>
		Yes
		&nbsp;
		<cfif isDefined("QRptinfo.review_status") and QRptinfo.review_status EQ 0>
			<img src="images/selected_button.jpg" align="middle">
		<cfelse>
			<img src="images/open_button.jpg" align="middle">
		</cfif>
		No
		
				
		
		<cfelse>
		
		
		<cfif isDefined("QRptinfo.review_status") and QRptinfo.review_status EQ 1>
			<cfinput type="radio" name="review_status" value="1"  checked required="yes" message="Please answer all questions before submitting feedback">
		<cfelse>
			<cfinput type="radio" name="review_status" value="1"  required="yes" message="Please answer all questions before submitting feedback">
		</cfif>
		Yes
		&nbsp;
		<cfif isDefined("QRptinfo.review_status") and QRptinfo.review_status EQ 0>
			<cfinput type="radio" name="review_status" value="0"  checked required="yes" message="Please answer all questions before submitting feedback">
		<cfelse>
			<cfinput type="radio" name="review_status" value="0" required="yes" message="Please answer all questions before submitting feedback">
		</cfif>
		No
		</cfif>
	</td>
</tr>

<cfif session.fy LT 1920 or session.fy GT 2006>
<tr>
	<td width=65%>
	
		<cfif http_referer does not contain "AM_Feedback_list.cfm" AND not isDefined ("url.mm")>
		Your CAT reports for the month are:
		<cfelse>
		This partner's CAT reports for the month are:
		</cfif>
		</td>
		<td valign="middle">
		<cfif http_referer does not contain "AM_Feedback_list.cfm" AND not isDefined ("url.mm")>		
		
		<cfif isDefined("QRptinfo.report_status") and QRptinfo.report_status EQ 1>
			<img src="images/selected_button.jpg" align="middle">
		<cfelse>
			<img src="images/open_button.jpg" align="middle">
		</cfif>
		Complete
		&nbsp;
		<cfif isDefined("QRptinfo.report_status") and QRptinfo.report_status EQ 0>
			<img src="images/selected_button.jpg" align="middle">
		<cfelse>
			<img src="images/open_button.jpg" align="middle">
		</cfif>
		Incomplete
			
		
		<cfelse>
		<cfif isDefined("QRptinfo.report_status") and QRptinfo.report_status EQ 1>
			<cfinput type="radio" name="report_status" value="1"  checked required="yes" message="Please answer all questions before submitting feedback">
		<cfelse>
			<cfinput type="radio" name="report_status" value="1"  required="yes" message="Please answer all questions before submitting feedback">
		</cfif>
		Complete
		&nbsp;
		<cfif isDefined("QRptinfo.report_status") and QRptinfo.report_status EQ 0>
			<cfinput type="radio" name="report_status" value="0"  checked required="yes" message="Please answer all questions before submitting feedback">
		<cfelse>
			<cfinput type="radio" name="report_status" value="0" required="yes" message="Please answer all questions before submitting feedback">
		</cfif>
		Incomplete
		</cfif>
	</td>
</tr>
</cfif>






<tr>
	<td>&nbsp;</td>
</tr>

<cfif session.fy LT 1920 or session.fy GT 2006>
<tr>
	<td valign="top" rowspan="3">
		<cfif http_referer does not contain "AM_Feedback_list.cfm" AND not isDefined ("url.mm")>
		Assessment of your progress toward completing work plan activities is:
		<cfelse>
		My assessment of this partner's progress toward completing work plan activities <cfif session.fy  EQ 1904 or session.fy GT 2006>and meeting contract deliverables </cfif>is:
		</cfif> 
	</td>
	<td align="left">
	<cfif http_referer does not contain "AM_Feedback_list.cfm" AND not isDefined ("url.mm")>
	<cfif isDefined("QRptinfo.review_progress") and QRptinfo.review_progress EQ 1>
	<img src="images/selected_button.jpg" align="left">
	<cfelse>
	<img src="images/open_button.jpg" align="left">
	</cfif>
	<cfif session.fy EQ 1904 OR session.fy GT 2006>
	Progressing
	<cfelse>
	Adequate
	</cfif>
	
	</td></tr><tr><td>
	<cfif isDefined("QRptinfo.review_progress") and QRptinfo.review_progress EQ 2>
	<img src="images/selected_button.jpg" align="left">
	<cfelse>
	<img src="images/open_button.jpg" align="left">
	</cfif>
	<cfif session.fy EQ 1904 OR session.fy GT 2006>
	Unmet
	<cfelse>
	Inadequate
	</cfif>
	</td></tr><tr><td>
	<cfif isDefined("QRptinfo.review_progress") and QRptinfo.review_progress EQ 3>
	<img src="images/selected_button.jpg" align="left">
	<cfelse>
	<img src="images/open_button.jpg" align="left">
	</cfif>Unable to determine/CAT reporting incomplete
	<cfelse>
	<cfif isDefined("QRptinfo.review_progress") and QRptinfo.review_progress EQ 1>
		<cfinput type="radio"  name="review_progress" value="1"  checked required="yes" message="Please answer all questions before submitting feedback">
	<cfelse>
		<cfinput type="radio" name="review_progress" value="1" required="yes" message="Please answer all questions before submitting feedback">
	</cfif>
	<cfif session.fy EQ 1904 OR session.fy GT 2006>
	Progressing
	<cfelse>
	Adequate
	</cfif>
	</td></tr>
	<tr><td>
	
	<cfif isDefined("QRptinfo.review_progress") and QRptinfo.review_progress EQ 2>
		<cfinput type="radio" name="review_progress" value="2"  checked required="yes" message="Please answer all questions before submitting feedback">
	<cfelse>
		<cfinput type="radio" name="review_progress" value="2" required="yes" message="Please answer all questions before submitting feedback">
	</cfif>
	<cfif session.fy EQ 1904 OR session.fy GT 2006>
	Unmet
	<cfelse>
	Inadequate
	</cfif>
	</td></tr>
	<tr><td>
	<cfif isDefined("QRptinfo.review_progress") and QRptinfo.review_progress EQ 3>
		<cfinput type="radio" name="review_progress" value="3"  checked required="yes" message="Please answer all questions before submitting feedback">
	<cfelse>
		<cfinput type="radio" name="review_progress" value="3" required="yes" message="Please answer all questions before submitting feedback">
	</cfif>
	Unable to determine/CAT reporting incomplete
	</td></tr></cfif>
<cfelse>
<tr>
	<td valign="top" rowspan="3">
		<cfif http_referer does not contain "AM_Feedback_list.cfm" AND not isDefined ("url.mm")>
		Assessment of your progress toward completing work plan activities is:
		<cfelse>
		My assessment of this partner's progress toward completing work plan activities <cfif session.fy  EQ 1904 or session.fy GT 2006>and meeting contract deliverables </cfif>is:
		</cfif> 
	</td>
	<td align="left">
	<cfif http_referer does not contain "AM_Feedback_list.cfm" AND not isDefined ("url.mm")>
	<cfif isDefined("QRptinfo.review_progress") and QRptinfo.review_progress EQ 1>
	<img src="images/selected_button.jpg" align="left">
	<cfelse>
	<img src="images/open_button.jpg" align="left">
	</cfif>
	<cfif session.fy EQ 1904 OR session.fy GT 2006>
	Progressing
	<cfelse>
	Adequate
	</cfif>
	
	</td></tr><tr><td>
	<cfif isDefined("QRptinfo.review_progress") and QRptinfo.review_progress EQ 2>
	<img src="images/selected_button.jpg" align="left">
	<cfelse>
	<img src="images/open_button.jpg" align="left">
	</cfif>
	<cfif session.fy EQ 1904 OR session.fy GT 2006>
	Unmet
	<cfelse>
	Inadequate
	</cfif>
	</td></tr><tr><td>
	<cfif isDefined("QRptinfo.review_progress") and QRptinfo.review_progress EQ 3>
	<img src="images/selected_button.jpg" align="left">
	<cfelse>
	<img src="images/open_button.jpg" align="left">
	</cfif>Unable to determine/CAT reporting incomplete
	<cfelse>
	<cfif isDefined("QRptinfo.review_progress") and QRptinfo.review_progress EQ 1>
		<cfinput type="radio"  name="review_progress" value="1"  checked required="yes" message="Please answer all questions before submitting feedback">
	<cfelse>
		<cfinput type="radio" name="review_progress" value="1" required="yes" message="Please answer all questions before submitting feedback">
	</cfif>
	<cfif session.fy EQ 1904 OR session.fy GT 2006>
	Progressing
	<cfelse>
	Adequate
	</cfif>
	</td></tr>
	<tr><td>
	
	<cfif isDefined("QRptinfo.review_progress") and QRptinfo.review_progress EQ 2>
		<cfinput type="radio" name="review_progress" value="2"  checked required="yes" message="Please answer all questions before submitting feedback">
	<cfelse>
		<cfinput type="radio" name="review_progress" value="2" required="yes" message="Please answer all questions before submitting feedback">
	</cfif>
	<cfif session.fy EQ 1904 OR session.fy GT 2006>
	Unmet
	<cfelse>
	Inadequate
	</cfif>
	</td></tr>
	<tr><td>
	<cfif isDefined("QRptinfo.review_progress") and QRptinfo.review_progress EQ 3>
		<cfinput type="radio" name="review_progress" value="3"  checked required="yes" message="Please answer all questions before submitting feedback">
	<cfelse>
		<cfinput type="radio" name="review_progress" value="3" required="yes" message="Please answer all questions before submitting feedback">
	</cfif>
	Unable to determine/CAT reporting incomplete
	</td></tr></cfif>	
</cfif>

<tr>
	<td colspan="2" wrap>
		<cfif http_referer does not contain "AM_Feedback_list.cfm" AND not isDefined ("url.mm")>
		Feedback from your <cfif session.fy LTE 2008>Area<Cfelse>Contract</cfif> Manager is:
		<cfelse>
		My feedback to this partner is:
		</cfif> <br>
	<cfif http_referer does not contain "AM_Feedback_list.cfm" AND not isDefined ("url.mm")>
 		#ParagraphFormat(QRptinfo.feedback)# 		
	<cfelse>
		<textarea name="AM_Comment" rows="20" cols="150"><cfif isDefined("QRptinfo.feedback")>#QRptinfo.feedback#</cfif></textarea>
	</cfif>	
	</td>

</tr>
<cfif session.fy LT 1920 or session.fy GT 2006>
<tr>
	<td colspan="2" wrap>
		<br>Issues to be addressed:<br>
	<cfif http_referer does not contain "AM_Feedback_list.cfm" AND not isDefined ("url.mm")>
 		#ParagraphFormat(QRptinfo.issues)# 		
	<cfelse>
		<textarea name="Issues" rows="20" cols="150"><cfif isDefined("QRptinfo.issues")>#QRptinfo.issues#</cfif></textarea>
	</td></tr>
	
	<tr>
 	<td colspan="2">
	 <input type="button" value="Check Spelling" onClick="spell('document.AMFeedback.AM_Comment.value', 'document.AMFeedback.Issues.value')">
	</td>
 	</tr>
	<tr><td>&nbsp;</td></tr>
	
	</cfif>	
	


</cfif>

<cfif http_referer contains "AM_Feedback_list.cfm" OR isDefined ("url.mm")>
<tr>
	<td  width=65%>
		<cfif http_referer does not contain "AM_Feedback_list.cfm" AND not isDefined ("url.mm")>
		
		I have reviewed my <cfif session.fy LTE 2008>Area<Cfelse>Contract</cfif> Manager's feedback about my Monthly Strategy Reports this month.
		<cfelse>
		The partner has reviewed your feedback about their Monthly Strategy Reports this month.
		</cfif>
		</td><td valign="bottom">
		<cfif isDefined("QRptinfo.partner_status") and QRptinfo.partner_status EQ 1>
			<cfinput type="radio" name="partner_status" value="1"  checked required="yes" message="Please answer all questions before submitting feedback">
		<cfelse>
			<cfinput type="radio" name="partner_status" value="1" required="yes" message="Please answer all questions before submitting feedback">
		</cfif>
		Yes
		&nbsp;
		<cfif (isDefined("QRptinfo.partner_status") and QRptinfo.partner_status NEQ 1) OR NOT isDefined("QRptinfo.partner_status")>
			<cfinput type="radio" name="partner_status" value="0"  checked required="yes" message="Please answer all questions before submitting feedback">
		<cfelse>
			<cfinput type="radio" name="partner_status" value="0" required="yes" message="Please answer all questions before submitting feedback">
		</cfif>
		No
	</td>
</tr>
</cfif>


<tr>
	<td colspan="2">
	<cfif http_referer does not contain "AM_Feedback_list.cfm" AND not isDefined ("url.mm")>
 		<!--- <script language="javascript">
 			disableme();
 		</script> --->
	<cfelse>
		<input type="button" value="Save" onClick="return setSave2();"><br>
		
		<input type="submit" value="Submit" onClick="return setSave();">
	</cfif>
	</td>
</tr>
</table>
</cfform>
<br>
<cfif http_referer does not contain "AM_Feedback_list.cfm" AND not isDefined ("url.mm")>
<cfform action="AM_feedbackread_process.cfm" name="AMFeedback2">
<input type="hidden" name="partnerid" value="#url.activ#">
<input type="hidden" name="rptMon" value="#url.mon#">
<table class="Table2" width="90%">

<tr>
	<td colspan="2">
	<strong>Please confirm that you have 
		<cfif http_referer does not contain "AM_Feedback_list.cfm" and session.fy GT 2008 AND not isDefined ("url.mm")>responded to 
		<cfelse>reviewed 
		</cfif>
		this feedback by checking "yes" and then clicking "Submit"</strong>	
	</td>
</tr>

<tr>
	<td  width=65%>
		<cfif http_referer does not contain "AM_Feedback_list.cfm" AND not isDefined ("url.mm")>
		<cfif session.fy LT 2009>
		I have reviewed my <cfif session.fy LTE 2008>Area<Cfelse>Contract</cfif> Manager's feedback about my Monthly Strategy Reports this month
		<cfelse>
		I have responded to and made necessary changes recommended by the contract manager.
		</cfif>
		<cfelse>
		The partner has reviewed your feedback about their Monthly Strategy Reports this month.
		</cfif>
		</td><td valign="bottom">
		<cfif isDefined("QRptinfo.partner_status") and QRptinfo.partner_status EQ 1>
			<cfinput type="radio" name="partner_status" value="1"  checked required="yes" message="Please answer all questions before submitting feedback">
		<cfelse>
			<cfinput type="radio" name="partner_status" value="1" required="yes" message="Please answer all questions before submitting feedback">
		</cfif>
		Yes
		&nbsp;
		<cfif (isDefined("QRptinfo.partner_status") and QRptinfo.partner_status NEQ 1) OR NOT isDefined("QRptinfo.partner_status")>
			<cfinput type="radio" name="partner_status" value="0"  checked required="yes" message="Please answer all questions before submitting feedback">
		<cfelse>
			<cfinput type="radio" name="partner_status" value="0" required="yes" message="Please answer all questions before submitting feedback">
		</cfif>
		No
	</td>
</tr>
<tr>
	<td colspan="2">
	<cfif http_referer does not contain "AM_Feedback_list.cfm" AND not isDefined ("url.mm")>
 		<input type="submit" value="Submit">
	</cfif>
	</td>
</tr>
</table>
</cfform>
</cfif>



</cfoutput>




</html>