<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="checkRecord">
	select distinct userid
	from EvalR
	where 
	userid='#session.userid#'
	and method = '#form.methodname#'
	and id_date='#form.mdate#'
	and year2=#session.fy#
	
</cfquery>

<cfif checkrecord.recordcount LT 1>
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="insertRecord">
	insert into EvalR
	(userid, method, id_date, year2)
	values	
	('#session.userid#', '#form.methodname#', '#form.mdate#', #session.fy#)	
</cfquery>
</cfif>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="updateRecord">
	update Evalr
	set
	<cfif isDefined("form.rptCOunties")>counties='#form.rptCounties#',</cfif>
	
	<cfif isDefined("form.numsurvdist")>num_surv_dist='#form.numsurvdist#',</cfif>
	<cfif isDefined("form.numsurvcomp")>num_surv_comp='#form.numsurvcomp#',</cfif>
	
	<cfif isDefined("form.numint")>num_int_comp='#form.numint#',</cfif>
	
	<cfif isDefined("form.numsites")>num_sites_obs='#form.numsites#',</cfif>
	
	results='#form.results#',
	conclusions='#form.conclusions#',
	lessons='#form.lessons#'
	where 
	userid='#session.userid#'
	and method = '#form.methodname#'
	and id_date='#form.mdate#'
	and year2=#session.fy#
</cfquery>
<cflocation  addtoken="Yes" url="eval_rpt_list.cfm?#session.urltoken#">