<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
<title>CAT</title>
<script language="javascript">
function disableme(){
for(var intloop=0; intloop <document.AMFeedback.length; intloop++){
document.AMFeedback[intloop].disabled=true;
}
}
</script>

<cfif not isdefined("url.activ")>
 <cfset url.activ=form.partnerName>
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
	partner_status, partner_date, partner_update
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
	<cfset dispyr=session.fy>
	<cfif dispyr EQ 1904>
		<cfset dispyr=2007>
	</cfif>
			Fiscal Year #evaluate(dispyr-1)#-#evaluate(dispyr)#
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
	
		<cfif http_referer does not contain "AM_Feedback_list.cfm">
		Your Area Manager has reviewed your Monthly Strategy Reports this month.
		<cfelse>
		I have reviewed the Monthly Strategy Reports for this partner for this month.
		</cfif>
		</td>
		<td valign="middle">
		<cfif http_referer does not contain "AM_Feedback_list.cfm">
		
		
		
		
		
		
		
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
<tr>
	<td>&nbsp;</td>
</tr>

<tr>
	<td valign="top">
		<cfif http_referer does not contain "AM_Feedback_list.cfm">
		Assessment of your progress toward completing work plan activities is:
		<cfelse>
		My assessment of this partner's progress toward completing work plan activities is:
		</cfif> 
	</td>
	<td>
	<cfif http_referer does not contain "AM_Feedback_list.cfm">
		
		
		
	<cfif isDefined("QRptinfo.review_progress") and QRptinfo.review_progress EQ 1>
		<img src="images/selected_button.jpg" align="middle">
	<cfelse>
		<img src="images/open_button.jpg" align="middle">
		
	</cfif>
	Adequate<br>
	
	<cfif isDefined("QRptinfo.review_progress") and QRptinfo.review_progress EQ 2>
		<img src="images/selected_button.jpg" align="middle">
	<cfelse>
		<img src="images/open_button.jpg" align="middle">
	</cfif>
	Inadequate<br>
	
	<cfif isDefined("QRptinfo.review_progress") and QRptinfo.review_progress EQ 3>
		<img src="images/selected_button.jpg" align="middle">
	<cfelse>
		<img src="images/open_button.jpg" align="middle">
	</cfif>
	Unable to determine/CAT reporting incomplete

		
		
		
		
		
		
		
		
		
		
	<cfelse>
	<cfif isDefined("QRptinfo.review_progress") and QRptinfo.review_progress EQ 1>
		<cfinput type="radio"  name="review_progress" value="1"  checked required="yes" message="Please answer all questions before submitting feedback">
	<cfelse>
		<cfinput type="radio" name="review_progress" value="1" required="yes" message="Please answer all questions before submitting feedback">
	</cfif>
	Adequate<br>
	
	<cfif isDefined("QRptinfo.review_progress") and QRptinfo.review_progress EQ 2>
		<cfinput type="radio" name="review_progress" value="2"  checked required="yes" message="Please answer all questions before submitting feedback">
	<cfelse>
		<cfinput type="radio" name="review_progress" value="2" required="yes" message="Please answer all questions before submitting feedback">
	</cfif>
	Inadequate<br>
	
	<cfif isDefined("QRptinfo.review_progress") and QRptinfo.review_progress EQ 3>
		<cfinput type="radio" name="review_progress" value="3"  checked required="yes" message="Please answer all questions before submitting feedback">
	<cfelse>
		<cfinput type="radio" name="review_progress" value="3" required="yes" message="Please answer all questions before submitting feedback">
	</cfif>
	Unable to determine/CAT reporting incomplete
	</cfif>
	</td>
</tr>

<tr>
	<td colspan="2" wrap>
		<cfif http_referer does not contain "AM_Feedback_list.cfm">
		Feedback from your Area Manager is:
		<cfelse>
		My feedback to this partner is:
		</cfif> <br>
	<cfif http_referer does not contain "AM_Feedback_list.cfm">
 		#ParagraphFormat(QRptinfo.feedback)# 		
	<cfelse>
		<textarea name="AM_Comment" rows="20" cols="150"><cfif isDefined("QRptinfo.feedback")>#QRptinfo.feedback#</cfif></textarea>
	</cfif>	
	</td>

</tr>

<tr>
	<td colspan="2">
	<cfif http_referer does not contain "AM_Feedback_list.cfm">
 		<!--- <script language="javascript">
 			disableme();
 		</script> --->
	<cfelse>
		<input type="submit" value="Submit">
	</cfif>
	</td>
</tr>
</table>
</cfform>
<br>
<cfform action="AM_feedbackread_process.cfm" name="AMFeedback2">
<input type="hidden" name="partnerid" value="#url.activ#">
<input type="hidden" name="rptMon" value="#url.mon#">
<table class="Table2" width="90%">
<cfif http_referer does not contain "AM_Feedback_list.cfm">
<tr>
	<td colspan="2">
	<strong>Please confirm that you have reviewed this feedback by checking "yes" and then clicking "Submit"</strong>	
	</td>
</tr>
</cfif>
<tr>
	<td  width=65%>
		<cfif http_referer does not contain "AM_Feedback_list.cfm">
		
		I have reviewed and made necessary changes recommended by the contract manager.
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
	<cfif http_referer does not contain "AM_Feedback_list.cfm">
 		<input type="submit" value="Submit">
	</cfif>
	</td>
</tr>
</table>
</cfform>

</cfoutput>




</html>