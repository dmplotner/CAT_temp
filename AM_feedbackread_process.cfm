<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QCheckinfo">
	select 
	partner_date
	from AM_Feedback
	where partner_id='#form.partnerid#'	
	and month2='#form.rptMon#'
	and year2=#session.fy#
</cfquery>


<cfif isDate(QCheckinfo.partner_Date)>


<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QUpdateInfo">
update AM_Feedback
set partner_status= #form.partner_status#,
partner_update=Getdate()
where partner_id='#form.partnerid#'	
	and month2='#form.rptMon#'
	and year2=#session.fy#
</cfquery>

<cfelse>
<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QinsertInfo">
update AM_Feedback
set partner_status= #form.partner_status#,
partner_date=Getdate(),
partner_update=Getdate()
where partner_id='#form.partnerid#'	
	and month2='#form.rptMon#'
	and year2=#session.fy#</cfquery>

</cfif>

<cflocation url="activ_list.cfm" addtoken="yes">