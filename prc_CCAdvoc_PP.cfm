<cfif isDefined("URL.delline") and URL.delline EQ 1 and isDefined("form.del")>
<cfquery datasource="#application.DataSource#" 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qdel">
	delete from advocCC_pp
where seq in (#form.del#)
</cfquery>

<cfelse>

<cfquery datasource="#application.DataSource#" 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qcheck">
select count(*) as count
from advocCC_pp
where userid=<cfqueryparam cfsqltype="cf_sql_varchar" value="#session.userid#">
and year2=<cfqueryparam cfsqltype="cf_sql_integer" value="#session.fy#">
and month2=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.month2#">
and tHCPO=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.PPcollabs#">
and strategy=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.activity2#">
</cfquery>

<cfif Qcheck.count EQ 0>
<cfquery datasource="#application.DataSource#" 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qinsert">
insert into advocCC_pp
(userid, year2, month2, tHCPO, strategy)
values
(<cfqueryparam cfsqltype="cf_sql_varchar" value="#session.userid#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#session.fy#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.month2#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.PPcollabs#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.activity2#">
)
</cfquery>
</cfif>

<cfquery datasource="#application.DataSource#" 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qupdate">
update
advocCC_pp
set


pp_pol_bit=<cfif isDefined("form.pp_pol_bit")><cfqueryparam cfsqltype="cf_sql_integer" value="#form.pp_pol_bit#"><cfelse>0</cfif>,
pp_pol_det=<cfif isDefined("form.pp_pol_det")><cfqueryparam cfsqltype="cf_sql_char" value="#form.pp_pol_det#"><cfelse>NULL</cfif>,
pp_pol_cb=<cfif isDefined("form.pp_pol_cb")><cfqueryparam cfsqltype="cf_sql_varchar" value="#form.pp_pol_cb#"><cfelse>''</cfif>,

pp_prac_bit=<cfif isDefined("form.pp_prac_bit")><cfqueryparam cfsqltype="cf_sql_integer" value="#form.pp_prac_bit#"><cfelse>0</cfif>,
pp_prac_det=<cfif isDefined("form.pp_prac_det")><cfqueryparam cfsqltype="cf_sql_char" value="#form.pp_prac_det#"><cfelse>NULL</cfif>,
pp_prac_cb=<cfif isDefined("form.pp_prac_cb")><cfqueryparam cfsqltype="cf_sql_varchar" value="#form.pp_prac_cb#"><cfelse>''</cfif>,

pp_sys_bit=<cfif isDefined("form.pp_sys_bit")><cfqueryparam cfsqltype="cf_sql_integer" value="#form.pp_sys_bit#"><cfelse>0</cfif>,
pp_sys_det=<cfif isDefined("form.pp_sys_det")><cfqueryparam cfsqltype="cf_sql_char" value="#form.pp_sys_det#"><cfelse>NULL</cfif>,
pp_sys_cb=<cfif isDefined("form.pp_sys_cb")><cfqueryparam cfsqltype="cf_sql_varchar" value="#form.pp_sys_cb#"><cfelse>''</cfif>,

pp_ed_a=<cfif isDefined("form.pp_ed_a")><cfqueryparam cfsqltype="cf_sql_integer" value="#form.pp_ed_a#"><cfelse>0</cfif>,
pp_ed_b=<cfif isDefined("form.pp_ed_b")><cfqueryparam cfsqltype="cf_sql_integer" value="#form.pp_ed_b#"><cfelse>0</cfif>,
pp_ed_det=<cfif isDefined("form.pp_ed_det")><cfqueryparam cfsqltype="cf_sql_char" value="#form.pp_ed_det#"><cfelse>NULL</cfif>,

pp_cess_a=<cfif isDefined("form.pp_cess_a")><cfqueryparam cfsqltype="cf_sql_integer" value="#form.pp_cess_a#"><cfelse>0</cfif>,
pp_cess_b=<cfif isDefined("form.pp_cess_b")><cfqueryparam cfsqltype="cf_sql_integer" value="#form.pp_cess_b#"><cfelse>0</cfif>,
pp_cess_det=<cfif isDefined("form.pp_cess_det")><cfqueryparam cfsqltype="cf_sql_char" value="#form.pp_cess_det#"><cfelse>NULL</cfif>,

pp_depend_a=<cfif isDefined("form.pp_depend_a")><cfqueryparam cfsqltype="cf_sql_integer" value="#form.pp_depend_a#"><cfelse>0</cfif>,
pp_depend_b=<cfif isDefined("form.pp_depend_b")><cfqueryparam cfsqltype="cf_sql_integer" value="#form.pp_depend_b#"><cfelse>0</cfif>,
pp_depend_det=<cfif isDefined("form.pp_depend_det")><cfqueryparam cfsqltype="cf_sql_char" value="#form.pp_depend_det#"><cfelse>NULL</cfif>,

pp_ftq_a=<cfif isDefined("form.pp_ftq_a")><cfqueryparam cfsqltype="cf_sql_integer" value="#form.pp_ftq_a#"><cfelse>0</cfif>,
pp_ftq_det=<cfif isDefined("form.pp_ftq_det")><cfqueryparam cfsqltype="cf_sql_char" value="#form.pp_ftq_det#"><cfelse>NULL</cfif>,



pp_compliance_a=<cfif isDefined("form.pp_compliance_a")><cfqueryparam cfsqltype="cf_sql_integer" value="#form.pp_compliance_a#"><cfelse>0</cfif>,
pp_compliance_det=<cfif isDefined("form.pp_compliance_det")><cfqueryparam cfsqltype="cf_sql_char" value="#form.pp_compliance_det#"><cfelse>NULL</cfif>,
pp_compliance_cb=<cfif isDefined("form.pp_compliance_cb")><cfqueryparam cfsqltype="cf_sql_varchar" value="#form.pp_compliance_cb#"><cfelse>''</cfif>,
pp_compliance_cb2=<cfif isDefined("form.pp_compliance_cb2")><cfqueryparam cfsqltype="cf_sql_varchar" value="#form.pp_compliance_cb2#"><cfelse>''</cfif>,



pp_feedback_a=<cfif isDefined("form.pp_feedback_a")><cfqueryparam cfsqltype="cf_sql_integer" value="#form.pp_feedback_a#"><cfelse>0</cfif>,
pp_feedback_b=<cfif isDefined("form.pp_feedback_b")><cfqueryparam cfsqltype="cf_sql_integer" value="#form.pp_feedback_b#"><cfelse>0</cfif>,
pp_feedback_det=<cfif isDefined("form.pp_feedback_det")><cfqueryparam cfsqltype="cf_sql_char" value="#form.pp_feedback_det#"><cfelse>NULL</cfif>,

pp_tfp_a=<cfif isDefined("form.pp_tfp_a")><cfqueryparam cfsqltype="cf_sql_integer" value="#form.pp_tfp_a#"><cfelse>0</cfif>,
pp_tfp_det=<cfif isDefined("form.pp_tfp_det")><cfqueryparam cfsqltype="cf_sql_char" value="#form.pp_tfp_det#"><cfelse>NULL</cfif>,


pp_cessAss_a=<cfif isDefined("form.pp_cessAss_a")><cfqueryparam cfsqltype="cf_sql_integer" value="#form.pp_cessAss_a#"><cfelse>0</cfif>,
pp_cessAss_b=<cfif isDefined("form.pp_cessAss_b")><cfqueryparam cfsqltype="cf_sql_integer" value="#form.pp_cessAss_b#"><cfelse>0</cfif>,
pp_cessAss_det=<cfif isDefined("form.pp_cessAss_det")><cfqueryparam cfsqltype="cf_sql_char" value="#form.pp_cessAss_det#"><cfelse>NULL</cfif>,


pp_trans_a=<cfif isDefined("form.pp_trans_a")><cfqueryparam cfsqltype="cf_sql_integer" value="#form.pp_trans_a#"><cfelse>0</cfif>,
pp_trans_det=<cfif isDefined("form.pp_trans_det")><cfqueryparam cfsqltype="cf_sql_char" value="#form.pp_trans_det#"><cfelse>NULL</cfif>


where userid=<cfqueryparam cfsqltype="cf_sql_varchar" value="#session.userid#">
and year2=<cfqueryparam cfsqltype="cf_sql_integer" value="#session.fy#">
and month2=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.month2#">
and tHCPO=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.PPcollabs#">
and strategy=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.activity2#">
</cfquery>
<!--- 
<cflocation addtoken="true" url="cess1.cfm?handler=seven"> --->


<cfset form.newT = "new">
</cfif>
