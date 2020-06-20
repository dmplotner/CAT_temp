<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Untitled Document</title>
</head>

<body>
<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qcheck">
	select userid from am_eoy_feedback
	where year2=#session.fy#
	and userid='#form.usid#'
	
</cfquery>
<cfif Qcheck.recordcount NEQ 1>
<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qinsert">
	insert into am_eoy_feedback
	(userid, year2)
	values
	('#form.usid#',#session.fy#)
		
</cfquery>

</cfif>
<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qupdate">
update 	am_eoy_feedback
set 
<cfif isDefined("am_review")>am_review=<cfqueryparam cfsqltype="cf_sql_tinyint"  value="#form.am_review#">,</cfif>
<cfif isDefined("rpt_status")>rpt_status=<cfqueryparam cfsqltype="cf_sql_tinyint" value="#form.rpt_status#">,</cfif>
<cfif isDefined("content")>content=<cfqueryparam cfsqltype="cf_sql_tinyint" value="#form.content#">,</cfif>
<cfif isDefined("reflect")>reflect=<cfqueryparam cfsqltype="cf_sql_tinyint" value="#form.reflect#">,</cfif>
discrep_txt=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.discrep_txt#">,
<cfif isDefined("barriers_comp")>barriers_comp=<cfqueryparam cfsqltype="cf_sql_tinyint" value="#form.barriers_comp#">,</cfif>
<cfif isDefined("barriers_build")>barriers_build=<cfqueryparam cfsqltype="cf_sql_tinyint" value="#form.barriers_build#">,</cfif>

cb_compdate=<cfif isDefined("cb_compdate")><cfqueryparam cfsqltype="cf_sql_tinyint" value="#form.cb_compdate#"><Cfelse>NULL</cfif>,
compdate=
<cfif isDefined("cb_compdate") and cb_compdate EQ 1>
	<cfif isDefined("compdate") and compdate NEQ "">#dateformat(compdate, "m/d/yyyy")#<cfelse>getdate()</cfif>
<cfelse>NULL</cfif>,

gen_fdback=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.gen_fdback#">,
tba=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.tba#">
where year2=#session.fy#
	and userid='#form.usid#'
	
	
</cfquery>

<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QcheckAMUserinfo">
	
	<cfif now() GT '11/30/2008'>
	select c.orgname, c.contact, c.coordemail as email, c2.coordemail as email as amemail
	from contact as c, contact as c2
	where c.userid='#form.usid#'
	and c.cmanager=c2.userid
	
	<cfelse>
	select c.orgname, c.contact, c.coordemail as email, c2.coordemail as email as amemail
	from contact as c, contact as c2, area as a
	where c.userid='#form.usid#'
	and c.area=a.num
	and a.year2=#session.fy#
	and a.manager_id=c2.userid
	</cfif>
	
	
	
	
</cfquery>

<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QcheckModManinfo">
	select c2.coordemail as mmemail
	from contact as c, contact as c2, modality_manager as m
	where c.userid='#form.usid#'
	and c.partnertype=m.modality
	and m.userid=c2.userid
	
</cfquery>
<cfif not isDefined("form.AMSave") or (isDefined("form.AMSave") and form.AMSave NEQ "1")>
<!--- <cfmail from="bettybrown@rti.org" to="dplotner@rti.org" bcc="dplotner@rti.org" subject="Area Manager feedback available for your End-of-Year Progress Report" type="html">
 --->

<cfmail from="bettybrown@rti.org" to="#QcheckAMUserinfo.email#; amw06@health.state.ny.us" bcc="dplotner@rti.org" subject="Area Manager feedback available for your End-of-Year Progress Report" type="html">
<!--- Your Area Manager has provided feedback on your End-of-Year Progress Report.  Please review the feedback and provide any necessary response to
your Area Manager's comments.
 --->
Your Area Manager has provided feedback on your End-of-Year Progress Report. Please review the feedback and provide any necessary response to your Area Manager's comments.
<br><br>
 

To access the Area Manager feedback on the EOY Report, please do the following:
<br><br>
 
<ul>
<li>Change the FY to 2006-2007</li>
<li>Click on the “Reports” tab</li>
<li>Select the Report Type of “End-of-Year Area Manager Feedback Report” </li>
<li>Click “Generate Report”</li>
</ul>
 
<br><br>
Thank you,<br>
Betty 
 <br><br>
Betty Brown<br>
bettybrown@rti.org
</cfmail>
</cfif>
<cflocation addtoken="yes" url="am_eoy_feedback_list.cfm">
</body>
</html>