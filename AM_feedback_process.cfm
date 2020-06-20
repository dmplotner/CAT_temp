<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QCheckinfo">
	select 
	review_status,
	review_progress,
	feedback
	from AM_Feedback
	where partner_id='#form.partnerid#'	
	and month2='#form.rptMon#'
	and year2=#session.fy#
</cfquery>


<cfif QCheckinfo.recordcount NEQ 0>


<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QUpdateInfo">
update AM_Feedback
set 
review_status=<cfif isDefined("form.review_status")> #form.review_status#<cfelse>null</cfif>,
review_progress=<cfif isDefined("form.review_progress")>#form.review_progress#<cfelse>null</cfif>,
feedback='#htmlEditFormat(form.AM_Comment)#',
<cfif isdefined("form.report_status")>report_status=#form.report_status#,
issues='#htmlEditFormat(form.issues)#',</cfif>
submitted=<cfif form.sendM eq 1>1<cfelse>0</cfif>,
date_upd=Getdate()
where partner_id='#form.partnerid#'	
	and month2='#form.rptMon#'
	and year2=#session.fy#
</cfquery>

<cfelse>
<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QpartnerInfo">
	select 
	area 
	from security 
	where userid = '#form.partnerid#'	
</cfquery>

<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QinsertInfo">
insert into AM_Feedback
(area, partner_id,review_status, review_progress, feedback, year2, month2, date_init, date_upd<cfif isdefined("form.report_status")>, report_status, issues</cfif>, submitted)
values
(#QpartnerInfo.area#, '#form.partnerid#',
<cfif isDefined("form.review_status")>#form.review_status#<cfelse>null</cfif>, 
<cfif isDefined("form.review_progress")>#form.review_progress#<cfelse>null</cfif>, 
'#htmlEditFormat(form.AM_Comment)#', #session.fy#, '#form.rptMon#', Getdate(), 
Getdate()<cfif isdefined("form.report_status")>, #form.report_status#, '#htmlEditFormat(form.issues)#'</cfif>,<cfif form.sendM eq 1>1<cfelse>0</cfif> )
</cfquery>

</cfif>

<cfif form.sendM EQ 2>
 <cflocation url="AM_Feedback_det.cfm?activ=#form.partnerid#&mm=7&mon=#form.rptMon#&year=#session.fy#"  addtoken="yes">
 
</cfif>
<cflocation url="AM_Feedback_list.cfm" addtoken="yes">