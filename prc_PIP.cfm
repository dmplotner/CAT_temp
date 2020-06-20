<CFLOOP INDEX="TheField" list="#Form.FieldNames#">
<cfif TheField contains "PIPNUM_">
<cflock scope = "Session"  timeout = "30" type = "Exclusive">
<cfquery datasource="#application.DataSource#"  	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QcheckPIP">
	select * 
	from CC_advoc_PIP_Num
	where year2=#session.fy#
	and month2='#form.month#'
	and strategy='#form.oldrpt#'
	and hcpoid=substring('#TheField#', 8, 50)
</cfquery>

 <cfif QcheckPIP.recordcount EQ 0>
<cfquery datasource="#application.DataSource#"  	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QinsPIP">
	insert into CC_advoc_PIP_Num
	(userid,year2, month2, strategy,hcpoid)
	values
	('#session.userid#', #session.fy#,'#form.month#',<cfqueryparam  cfsqltype="cf_sql_varchar" value="#form.oldrpt#">,substring('#TheField#', 8, 50))
</cfquery>
</cfif>
</cflock>
<cfquery datasource="#application.DataSource#"  	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QupdPIP">
	update CC_advoc_PIP_Num
	set providerNum= #Evaluate(TheField)#
	where year2=#session.fy#
	and month2='#form.month#'
	and strategy=<cfqueryparam  cfsqltype="cf_sql_varchar" value="#form.oldrpt#">
	and hcpoid=substring('#TheField#', 8, 50)
</cfquery>
</cfif>  
</cfloop>


<cfquery datasource="#application.DataSource#"  	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QcheckPIPC">
	select * 
	from CC_advoc_PIP_Comments
	where year2=#session.fy#
	and month2='#form.month#'
	and strategy=<cfqueryparam  cfsqltype="cf_sql_varchar" value="#form.oldrpt#">
	and userid=<cfqueryparam  cfsqltype="cf_sql_varchar" value="#session.userid#"> 
</cfquery>	

<cfif QcheckPIPC.recordcount EQ 0>
<cfquery datasource="#application.DataSource#"  	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QinsPIPC">
	insert into CC_advoc_PIP_comments
	(userid,year2, month2, strategy)
	values
	('#session.userid#', #session.fy#,'#form.month#',<cfqueryparam  cfsqltype="cf_sql_varchar" value="#form.oldrpt#"> )
</cfquery>

</cfif>

<cfif isDefined("form.pipcomments")>
<cfquery datasource="#application.DataSource#"  	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QupdPIPC">
	update CC_advoc_PIP_comments
	set comment= <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.pipcomments#">
	where year2=#session.fy#
	and month2='#form.month#'
	and strategy=<cfqueryparam  cfsqltype="cf_sql_varchar" value="#form.oldrpt#">
	and userid=<cfqueryparam  cfsqltype="cf_sql_varchar" value="#session.userid#"> 	
</cfquery>
</cfif>
