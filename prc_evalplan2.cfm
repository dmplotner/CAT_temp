


<cfquery datasource="#application.DataSource#"  	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QgetSpec">
	select area from security
	where userid='#session.userid#'
</cfquery>

<cfquery datasource="#application.DataSource#"  	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QUserInfo">
select c.orgname, c.contact, s.area, a.region, c.coordemail as email
from contact as c, security as s, area as a
where c.userid='#session.userid#'	
and c.userid=s.userid
and s.area=a.num
and a.year2=#session.fy#
</cfquery>

<cfquery datasource="#application.DataSource#"  	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QgetSpec2">
	select  region  from area
	where num='#QgetSpec.area#'
	and year2=#session.fy#
</cfquery>

<cfif QgetSpec2.region EQ 2 OR QgetSpec2.region EQ 3>
<!--- central and capital regions (2,3) --->
	<cfset TSERT_SPEC= "aal07@health.state.ny.us">
<cfelse>
<!--- western and metro regions (1,4)--->
	<!--- <cfset TSERT_SPEC= "dxv06@health.state.ny.us"> --->
	<cfset TSERT_SPEC= "aal07@health.state.ny.us">
</cfif>
	
	
<cfmail from="dplotner@rti.org" cc="dplotner@rti.org" to="#TSERT_SPEC#" subject="#htmleditformat(QUserInfo.orgname)# Evaluation Plan Modification" type="HTML">
You are being contacted because you serve as the evaluation specialist for #htmleditformat(QUserInfo.orgname)#
(#htmleditformat(QUserInfo.contact)#, #QUserInfo.email#).
They have made a change to an existing FY<cfif session.fy EQ 1904>2005-2006<cfelse>#evaluate(session.fy-1)#-#session.fy#</cfif> Evaluation Project. ( <cfif isDefined("form.methodname")>"#htmleditformat(form.methodname)#"</cfif>)
<br><br>
Reason(s) for the change:<br>

<pre>#htmleditformat(form.explanationOfChanges)#</pre>
<br>
Please review these changes, and provide feedback to the partner.

</cfmail>




<cfinclude template="prcEvalPlanDet.cfm">
