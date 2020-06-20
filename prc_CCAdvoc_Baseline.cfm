<cfif isDefined("URL.delline") and URL.delline EQ 1 and isDefined("form.del")>
<cfquery datasource="#application.DataSource#" 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qdel">
	delete from advocCC_baselines
where seq in (#form.del#)
</cfquery>

<cfelse>
<!--- <cfdump var="#form#"><cfabort> --->
<cfquery datasource="#application.DataSource#" 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qcheck">
select count(*) as count
from advocCC_baselines
where userid=<cfqueryparam cfsqltype="cf_sql_varchar" value="#session.userid#">
<!--- and year2=<cfqueryparam cfsqltype="cf_sql_integer" value="#session.fy#">
and month2=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.month2#"> --->
and tHCPO=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.BLcollabs#">
and strategy=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.activity2#">
</cfquery>

<cfif Qcheck.count EQ 0>
<cfquery datasource="#application.DataSource#" 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qinsert">
insert into advocCC_baselines
(userid, year2, month2, tHCPO, strategy)
values
(<cfqueryparam cfsqltype="cf_sql_varchar" value="#session.userid#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#session.fy#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.month2#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.BLcollabs#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.activity2#">
)
</cfquery>
</cfif>

<cfquery datasource="#application.DataSource#" 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qupdate">
update
advocCC_baselines
set
writtenP=<cfif isDefined("form.writtenP")><cfqueryparam cfsqltype="cf_sql_integer" value="#form.writtenP#"><cfelse>0</cfif>, 
writtenP_det=<cfif isDefined("form.writtenP_det")><cfqueryparam cfsqltype="cf_sql_varchar" value="#form.writtenP_det#"><cfelse>0</cfif>,
ep_1=<cfif isDefined("form.ep_1")><cfqueryparam cfsqltype="cf_sql_integer" value="#form.ep_1#"><cfelse>0</cfif>, 
ep_2=<cfif isDefined("form.ep_2")><cfqueryparam cfsqltype="cf_sql_integer" value="#form.ep_2#"><cfelse>0</cfif>, 
ep_3=<cfif isDefined("form.ep_3")><cfqueryparam cfsqltype="cf_sql_integer" value="#form.ep_3#"><cfelse>0</cfif>, 
ep_4=<cfif isDefined("form.ep_4")><cfqueryparam cfsqltype="cf_sql_integer" value="#form.ep_4#"><cfelse>0</cfif>, 
ep_5=<cfif isDefined("form.ep_5")><cfqueryparam cfsqltype="cf_sql_integer" value="#form.ep_5#"><cfelse>0</cfif>,
<!--- ep_6=<cfif isDefined("form.ep_6")><cfqueryparam cfsqltype="cf_sql_integer" value="#form.ep_6#"><cfelse>0</cfif>, --->

idSys=<cfif isDefined("form.idSys")><cfqueryparam cfsqltype="cf_sql_integer" value="#form.idSys#"><cfelse>0</cfif>, 
idSys_det=<cfif isDefined("form.idSys_det")><cfqueryparam cfsqltype="cf_sql_varchar" value="#form.idSys_det#"><cfelse>0</cfif>,
tdtc=<cfif isDefined("form.tdtc")><cfqueryparam cfsqltype="cf_sql_integer" value="#form.tdtc#"><cfelse>0</cfif>, 
promote_couns=<cfif isDefined("form.promote_couns")><cfqueryparam cfsqltype="cf_sql_integer" value="#form.promote_couns#"><cfelse>0</cfif>, 
provide_res=<cfif isDefined("form.provide_res")><cfqueryparam cfsqltype="cf_sql_integer" value="#form.provide_res#"><cfelse>0</cfif>,
compliance=<cfif isDefined("form.compliance")><cfqueryparam cfsqltype="cf_sql_integer" value="#form.compliance#"><cfelse>0</cfif>, 
compliance_det=<cfif isDefined("form.compliance_det")><cfqueryparam cfsqltype="cf_sql_varchar" value="#form.compliance_det#"><cfelse>0</cfif>,
feedback=<cfif isDefined("form.feedback")><cfqueryparam cfsqltype="cf_sql_integer" value="#form.feedback#"><cfelse>0</cfif>,
policies=<cfif isDefined("form.polBL")><cfqueryparam cfsqltype="cf_sql_varchar" value="#form.polBL#"><cfelse>0</cfif>, 
policies_date=<cfif isDefined("form.polBLdate")><cfqueryparam cfsqltype="CF_SQL_date" value="#polBLdate#"><cfelse>NULL</cfif>,
cess_assist=<cfif isDefined("form.cess_assist")><cfqueryparam cfsqltype="cf_sql_integer" value="#form.cess_assist#"><cfelse>0</cfif>, 
comments=<cfif isDefined("form.comments")><cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.comments#"><cfelse>NULL</cfif>


where userid=<cfqueryparam cfsqltype="cf_sql_varchar" value="#session.userid#">
<!--- and year2=<cfqueryparam cfsqltype="cf_sql_integer" value="#session.fy#">
and month2=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.month2#"> --->
and tHCPO=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.BLcollabs#">
<!--- and strategy=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.activity2#"> --->
</cfquery>
<!--- 
<cflocation addtoken="true" url="cess1.cfm?handler=seven"> --->

<cfset form.newT = "new">
</cfif>
