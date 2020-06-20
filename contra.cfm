<style>
.box {
	font-family: verdana, helvetica, sans-serif;
	font-size: 11px;
	color: #003366;
	border: solid 1px #CCCC99;
	list-style:inherit;
	border-collapse: collapse;
}
.box2 {
	font-family: verdana, helvetica, sans-serif;
	font-size: 11px;
	color: #003366;
	border: none;
	list-style:inherit;
	border-collapse: collapse;
}
</style>
<SCRIPT LANGUAGE="JavaScript" SRC="../scripts/cfform.js"> </SCRIPT>
<SCRIPT LANGUAGE="JavaScript">
    function toggle_visibility1(id) {
 	     var e = document.getElementById(id);
	     var train = document.wrk.train.value;
		 if(train == 7){
       if(e.style.display == 'block')
          e.style.display = 'none';
       else
          e.style.display = 'block';
		  }
		  else
		  {
		  e.style.display = 'none';
		  }}
function checkLG(){
add('addLG');
}
function checkLG2(){
add('addLG2');
}
function add(actvalue){
document.wrk.dofunction.value=actvalue;
return true;}
</SCRIPT>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>CAT</title>
<body>
<cfinclude template="CATstruct.cfm">
<script language="JavaScript" src="../spellchecker/spell.js"></script>
<cfparam name="form.dofunction" default="">
<cfparam name="form.status" default="">
<cfparam name="form.review" default="">
<cfif isdefined("mo")>
<cfswitch expression="#mo#">
<cfcase value=1>
<cfset session.mon = "January">
<cfset session.monum = 1>
<cfset session.lastmo = 12>
<cfset session.lastyr = #session.fy# + 1>
</cfcase>
<cfcase value=2>
<cfset session.mon = "February">
<cfset session.monum = 2>
<cfset session.lastmo = 1>
</cfcase>
<cfcase value=3>
<cfset session.mon = "March">
<cfset session.monum = 3>
<cfset session.lastmo = 2>
</cfcase>
<cfcase value=4>
<cfset session.mon = "April">
<cfset session.monum = 4>
<cfset session.lastmo = 3>
</cfcase>
<cfcase value=5>
<cfset session.mon = "May">
<cfset session.monum = 5>
<cfset session.lastmo = 4>
</cfcase>
<cfcase value=6>
<cfset session.mon = "June">
<cfset session.monum = 6>
<cfset session.lastmo = 5>
</cfcase>
<cfcase value=7>
<cfset session.mon = "July">
<cfset session.monum = 7>
<cfset session.lastmo = 6>
</cfcase>
<cfcase value=8>
<cfset session.mon = "August">
<cfset session.monum = 8>
<cfset session.lastmo = 7>
</cfcase>
<cfcase value=9>
<cfset session.mon = "September">
<cfset session.monum = 9>
<cfset session.lastmo = 8>
</cfcase>
<cfcase value=10>
<cfset session.mon = "October">
<cfset session.monum = 10>
<cfset session.lastmo = 9>
</cfcase>
<cfcase value=11>
<cfset session.mon = "November">
<cfset session.monum = 11>
<cfset session.lastmo = 10>
</cfcase>
<cfcase value=12>
<cfset session.mon = "December">
<cfset session.monum = 12>
<cfset session.lastmo = 11>
</cfcase>
</cfswitch>
</cfif>
<cfparam name="form.status" default="">
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="getlastCMF">
select * from CMfeedback
where
	userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	<cfif isdefined("session.lastyr")>and year2=<cfqueryparam value="#session.lastyr#" cfsqltype="CF_SQL_INTEGER">
	<cfelse>
	and year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	</cfif>
	and mon=<cfqueryparam value="#session.lastmo#" cfsqltype="CF_SQL_INTEGER">
</cfquery>
<cfset tempdate=#dateformat(Now(),'m/d/yyyy')#>
<cfif form.dofunction is 'addLG' OR  form.dofunction is 'addLG2'>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="cmf">
select * from CMfeedback
where
	userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and mon= <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
	</cfquery>
	<cfif cmf.recordcount is 0>
 <cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QInsSE">
insert into CMfeedback
(userid, year2, mon, status, meet
<cfif isDefined("form.review") >, cntrReview</cfif>
<CFIF form.dofunction is 'addLG2'>, submitdt</CFIF>
)
values
(<cfqueryparam cfsqltype="cf_sql_varchar" value="#session.userid#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#session.fy#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#session.monum#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#form.status#" null="#YesNoFormat(not Len(form.status))#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.meet#">
<cfif isDefined("form.review") >,<cfqueryparam cfsqltype="cf_sql_bit" value="#form.review#" null="#YesNoFormat(not Len(form.review))#"></cfif>
<CFIF form.dofunction is 'addLG2'>,<cfqueryparam value="#tempdate#" cfsqltype="CF_SQL_date"></CFIF>
)
</cfquery>

<cfelse>

<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QupdSE">
	update CMfeedback set
	userid=userid
	<cfif isDefined("form.status")>,status=<cfqueryparam cfsqltype="cf_sql_integer" value="#form.status#" null="#YesNoFormat(not Len(form.status))#"></cfif>
	<cfif isDefined("form.meet")>,meet=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.meet#"></cfif>
	<cfif isDefined("form.review")>,cntrReview=<cfqueryparam value="#form.Review#" cfsqltype="CF_SQL_BIT" null="#YesNoFormat(not Len(form.review))#"></cfif>
	<CFIF form.dofunction is 'addLG2'>,submitdt=<cfqueryparam value="#tempdate#" cfsqltype="CF_SQL_date"></CFIF>
	where
	userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and mon=<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
	and year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	</cfquery>
</cfif>
<cfif isdefined("form.return") and #form.return# is 'Submit'>
		<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="GetEmailStats">
select
c.orgname,c.partnertype, c.coordemail as partneremail,c.coordemail2 as partneremail2,
case c.partnertype
when 1 then '#session.MM1#'
when 2 then '#session.MM2#'
when 6 then '#session.MM6#'
else NULL end as mmanager,
m.email as cmanager
from contact c, contact m
where m.userid=c.cmanager
and c.partnertype in (1,2,6)
and c.userid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#session.userid#">
and isNull(c.coordemail,'rti.org') not like '%rti.org'
</cfquery>

<cfset extraemail = "#session.extraEmail#">
<cfif session.userid EQ 'HRIRPACC' OR session.userid EQ 'HRIRPEN' or session.userid EQ 'HRIRPWGLO'><cfset extraemail = "#session.extraEmail#; Anthony.billoni@roswellpark.org"></cfif>
<!--- <cfif GetEmailStats.cmanager EQ 'hrc01@health.state.ny.us'><cfset extraemail = "#session.extraEmail#; debbie.spinosa@health.ny.gov"></cfif> --->
<!--- <cfif GetEmailStats.recordcount NEQ 0 and GetEmailStats.mmanager NEQ ""> --->
<cfif GetEmailStats.recordcount NEQ 0>
<!--- 	<cfif GetEmailStats.partnertype EQ 2> --->


<cfmail from="NY Tobacco Control Program <NY-Tobacco-Control-Program@rti.org>"
to="#GetEmailStats.partneremail#;#GetEmailStats.partneremail2#"
bcc="dplotner@rti.org"
cc="#GetEmailStats.cmanager#; #GetEmailStats.mmanager#; #extraemail#"
subject="CM Feedback on #MonthAsString(session.monum)# CAT Monthly Report for #GetEmailStats.orgname# is Available for Review #tempdate#" type="HTML">
Your Contract Manager has posted feedback in response to your #MonthAsString(session.monum)# monthly report.
The feedback is detailed below and on the CAT DOH feedback screen. If you have any questions or concerns, please respond directly to your Contract Manager by forwarding this email.
<strong>Also, please be sure to check that you have reviewed this month's feedback on CAT.
<br><br>
DOH Feedback:
<br></strong>
#form.meet#
<br><br>
</cfmail>
<!--- <cfelseif GetEmailStats.partnertype EQ 1 or GetEmailStats.partnertype EQ 6>

<cfmail from="NY Tobacco Control Program <NY-Tobacco-Control-Program@rti.org>"
to="#GetEmailStats.partneremail#;#GetEmailStats.partneremail2#"
bcc="dplotner@rti.org"
cc="#GetEmailStats.cmanager#; #GetEmailStats.mmanager#;sep06@health.ny.gov"
subject="CM Feedback on #MonthAsString(session.monum)# CAT Monthly Report for #GetEmailStats.orgname# is Available for Review #tempdate#" type="HTML">
Your Contract Manager has posted feedback in response to your #MonthAsString(session.monum)# monthly report.
The feedback is detailed below and on the CAT DOH feedback screen. If you have any questions or concerns, please respond directly to your Contract Manager by forwarding this email.
<strong>Also, please be sure to check that you have reviewed this month's feedback on CAT.
<br><br>
DOH Feedback:
<br></strong>
#form.meet#
<br><br>
</cfmail>
<cfelse>

<cfmail from="NY Tobacco Control Program <NY-Tobacco-Control-Program@rti.org>"
to="#GetEmailStats.partneremail#;#GetEmailStats.partneremail2#"
bcc="dplotner@rti.org"
cc="#GetEmailStats.cmanager#; #GetEmailStats.mmanager# #extraemail#"
subject="CM Feedback on #MonthAsString(session.monum)# CAT Monthly Report for #GetEmailStats.orgname# is Available for Review #tempdate#" type="HTML">
Your Contract Manager has posted feedback in response to your #MonthAsString(session.monum)# monthly report.
The feedback is detailed below and on the CAT DOH feedback screen. If you have any questions or concerns, please respond directly to your Contract Manager by forwarding this email.
<strong>Also, please be sure to check that you have reviewed this month's feedback on CAT.
<br><br>
DOH Feedback:
<br></strong>
#form.meet#
<br><br>
</cfmail>
</cfif>
<cfelseif GetEmailStats.recordcount NEQ 0>

<cfmail from="NY Tobacco Control Program <NY-Tobacco-Control-Program@rti.org>"
to="#GetEmailStats.partneremail#;#GetEmailStats.partneremail2#"
bcc="dplotner@rti.org"
cc="#GetEmailStats.cmanager#; #GetEmailStats.mmanager#"
subject="CM Feedback on #MonthAsString(session.monum)# CAT Monthly Report for #GetEmailStats.orgname# is Available for Review #tempdate#" type="HTML">
Your Contract Manager has posted feedback in response to your #MonthAsString(session.monum)# monthly report.
The feedback is detailed below and on the CAT DOH feedback screen. If you have any questions or concerns, please respond directly to your Contract Manager by forwarding this email.
<strong>Also, please be sure to check that you have reviewed this month's feedback on CAT.
<br><br>
DOH Feedback:
<br></strong>
#form.meet#
<br><br>
</cfmail> --->
</cfif>
<cflocation url="monthrep.cfm"></cfif>
</cfif>


<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="getCMF">
select * from CMfeedback
where
	userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and mon=<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
</cfquery>
<cfparam name="getCMF.STATUS" default="">
<cfparam name="getCMF.meet" default="">
<cfparam name="getCMF.REVIEW" default="">
<cfform name="wrk" action="contra.cfm?#session.urltoken#">
<input type="hidden" name="dofunction" value="">
  <tr><td><table class="boxn" border=0 width=775>
			  <tr>
		<td align="left"><h3>DOH Feedback</h4>
	</td>
	  </tr></table>
	  <tr><td><table class="box2" width=775>
	  <cfoutput>
	  <tr><td><table width=775 class="box">		<th align="left">Contractor name</th><td>#session.orgName#</td>
		  		<tr><td colspan=2 height=10></td></tr>
	  <tr><th align="left">Reporting period</th><td>#evaluate(session.fy-1)# - #session.fy#</td>
</tr>
		  		<tr><td colspan=2 height=10></td></tr>
	  <tr><th align="left">Month</th><td>#session.mon#</td>
</tr>
		  		<tr><td colspan=2 height=10></td></tr>
	  <tr><th align="left">Feedback date</th><td>#dateformat(getCMF.submitdt, 'mmmm d, yyyy')#</td>
</tr>
		  		<tr><td colspan=2 height=10></td></tr>
	  <tr><th align="left" valign="top">Status of #session.orgname# activity for the month is:</th><td>
		   <cfif getCMF.status is not ''>
			<input type="radio" name="status" value=1 <CFIF getCMF.status eq 1> CHECKED</CFIF><cfif NOT(SESSION.areamanage EQ "1" OR SESSION.admin EQ "1" OR SESSION.TCP EQ "1" OR SESSION.cessMan NEQ "0")> Disabled</cfif>> Actively working on contract deliverables<br>
	  		<input type="radio" name="status" value=2 <CFIF getCMF.status eq 2> CHECKED</CFIF><cfif NOT(SESSION.areamanage EQ "1" OR SESSION.admin EQ "1" OR SESSION.TCP EQ "1" OR SESSION.cessMan NEQ "0")> Disabled</cfif>> Not actively working on contract deliverables/ Issues to be addressed (See Detailed Feedback)<br>
	   		<input type="radio" name="status" value=3 <CFIF getCMF.status eq 3> CHECKED</CFIF><cfif NOT(SESSION.areamanage EQ "1" OR SESSION.admin EQ "1" OR SESSION.TCP EQ "1" OR SESSION.cessMan NEQ "0")> Disabled</cfif>> Unable to determine
		<cfelse>
		<input type="radio" name="status" value=1<cfif NOT(SESSION.areamanage EQ "1" OR SESSION.admin EQ "1" OR SESSION.TCP EQ "1" OR SESSION.cessMan NEQ "0")> Disabled</cfif>> Actively working on contract deliverables<br>
	  		<input type="radio" name="status" value=2<cfif NOT(SESSION.areamanage EQ "1" OR SESSION.admin EQ "1" OR SESSION.TCP EQ "1" OR SESSION.cessMan NEQ "0")> Disabled</cfif>> Not actively working on contract deliverables/ Issues to be addressed (See Detailed Feedback)<br>
	   		<input type="radio" name="status" value=3<cfif NOT(SESSION.areamanage EQ "1" OR SESSION.admin EQ "1" OR SESSION.TCP EQ "1" OR SESSION.cessMan NEQ "0")> Disabled</cfif>> Unable to determine
			</cfif>
		</td>
</tr>
		  		<tr><td colspan=2 height=10></td></tr>
<tr><th align="left" valign="top">Detailed feedback</th><td>
	<cfif isdefined("getlastCMF.MEET") and getlastcmf.meet is not ''>Last month's feedback: #getlastcmf.meet#</cfif>
	<div>
	<cfif NOT(SESSION.areamanage EQ "1" OR SESSION.admin EQ "1" OR SESSION.TCP EQ "1" OR SESSION.cessMan NEQ "0")>
		<cftextarea name="meet" richtext="yes"  toolbar="Basic" width="550" height="200" disabled="true">#getCMF.MEET#</cftextarea>
	<cfelse>
		<cftextarea name="meet" richtext="yes"  toolbar="Basic" width="550" height="200"  >#getCMF.MEET#</cftextarea>
	</cfif>
</div>
		<cfif (SESSION.areamanage EQ "1" OR SESSION.admin EQ "1" OR SESSION.TCP EQ "1" OR SESSION.cessMan NEQ "0")>
		  <br><input type="button" value="Check Spelling" onClick="spell('document.wrk.meet.value')">
	</CFIF>
</td></tr>
			  		<tr><td colspan=2 height=10></td></tr>
	  <tr><th align="left" valign="top">#session.orgname# has reviewed this month's feedback</th><td>
		  	 <cfif getCMF.cntrReview is not ''>
		  	 <input type="checkbox" name="review" value=1 <CFIF getCMF.cntrReview eq 1> CHECKED </CFIF>
		  	 <cfif (SESSION.areamanage EQ "1" OR SESSION.admin EQ "1" OR SESSION.TCP EQ "1" OR SESSION.cessMan NEQ "0") OR getCMF.cntrReview eq 1> Disabled</cfif>> Yes<br>
		  	 <CFIF getCMF.cntrReview eq 1 and ((SESSION.areamanage EQ "1" OR SESSION.admin EQ "1" OR SESSION.TCP EQ "1" OR SESSION.cessMan NEQ "0") OR getCMF.cntrReview eq 1)>
			<input type="hidden" name="review" value=1>
			</CFIF>

		  	 <CFELSE>
		  	<input type="checkbox" name="review" value=1 <cfif (SESSION.areamanage EQ "1" OR SESSION.admin EQ "1" OR SESSION.TCP EQ "1" OR SESSION.cessMan NEQ "0")> Disabled </CFIF>>
		  	 </cfif>
</tr>
				  		<tr><td colspan=2 height=10></td></tr>
		  		<tr><td colspan=2 height=10></td></tr>
	<tr><td colspan=2><input type="submit" name="return" value="Save" onClick="return checkLG();">
			  		<tr><td colspan=2 height=10></td></tr>
	<cfif SESSION.areamanage EQ "1" OR SESSION.admin EQ "1" OR SESSION.TCP EQ "1" OR SESSION.cessMan NEQ "0">
	<tr><td colspan=2><input type="submit" name="return" value="Submit" onClick="return checkLG2();">
	</cfif>
</table></cfoutput>
</cfform>
</table>
</tr>
</body>
</html>
