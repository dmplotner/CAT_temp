<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>CAT</title>
<cfinclude template="catstruct.cfm">
<script language="JavaScript">
function doChange(val){
document.changeUser.doType.value=val;
}
</script><cfif isDefined("form.doType")>
<cfif form.doType EQ "change">
	<CFQUERY NAME="QcheckUsrPK"
		 DATASOURCE="#application.DataSource#"
         USERNAME="#application.db_username#"
         PASSWORD="#application.db_password#">
		 select seq from security where userid=<cfqueryparam cfsqltype="varchar" value="#form.new_user#">
	</CFQUERY>
	<CFQUERY NAME="QcheckUsrModality1"
		 DATASOURCE="#application.DataSource#"
         USERNAME="#application.db_username#"
         PASSWORD="#application.db_password#">
		 select partnerType
		 from contact
		 where userid=<cfqueryparam cfsqltype="varchar" value="#form.new_user#">
	</CFQUERY>
	<cfset session.user_pk=QcheckUsrPK.seq>
	<cfset session.userid=form.new_user>
	<cfif QcheckUsrModality1.partnerType EQ 4>
		<cfset session.AlterYr = "newSPyr">
	<cfelse>
		<cfset session.AlterYr = "newNotSPyr">
	</cfif>
<cfelseif form.doType EQ "restore">
	<cfset session.userid=session.origUserID>
	<cfset session.user_pk=session.user_pk_master>
</cfif>
<cfif form.doType EQ "restore" or form.doType EQ "change">
<CFQUERY NAME="QNewExt_1"
		 DATASOURCE="#application.DataSource#"
         USERNAME="#application.db_username#"
         PASSWORD="#application.db_password#">
	   select  extfy
	   from Extensions
	   where userid=<cfqueryparam cfsqltype="varchar" value="#session.userid#">
	   and enddate > getdate() -1
	   and exttype=1
</CFQUERY>
<CFQUERY NAME="QNewExt_2"
		 DATASOURCE="#application.DataSource#"
         USERNAME="#application.db_username#"
         PASSWORD="#application.db_password#">
	   select  extfy
	   from Extensions
	   where userid=<cfqueryparam cfsqltype="varchar" value="#session.userid#">
	   and enddate > getdate() -1
	   and exttype=2
</CFQUERY>
<CFQUERY NAME="QNewExt_3"
		 DATASOURCE="#application.DataSource#"
         USERNAME="#application.db_username#"
         PASSWORD="#application.db_password#">
	   select  extfy
	   from Extensions
	   where userid=<cfqueryparam cfsqltype="varchar" value="#session.userid#">
	   and enddate > getdate() -1
	   and exttype=3
</CFQUERY>
<CFQUERY NAME="QNewExt_4"
		 DATASOURCE="#application.DataSource#"
         USERNAME="#application.db_username#"
         PASSWORD="#application.db_password#">
	   select  extfy
	   from Extensions
	   where userid=<cfqueryparam cfsqltype="varchar" value="#session.userid#">
	   and enddate > getdate() -1
	   and exttype=4
</CFQUERY>
<CFQUERY NAME="QNewExt_5"
		 DATASOURCE="#application.DataSource#"
         USERNAME="#application.db_username#"
         PASSWORD="#application.db_password#">
	   select  extfy
	   from Extensions
	   where userid=<cfqueryparam cfsqltype="varchar" value="#session.userid#">
	   and enddate > getdate() -1
	   and exttype=5
</CFQUERY>
<cfif QNewExt_1.recordcount GT 0>
	<cfset session.newExt_1 = "#valuelist(QNewExt_1.extfy)#">
</cfif>
<cfif QNewExt_2.recordcount GT 0>
	<cfset session.newExt_2 = "#valuelist(QNewExt_2.extfy)#">
</cfif>
<cfif QNewExt_3.recordcount GT 0>
	<cfset session.newExt_3 = "#valuelist(QNewExt_3.extfy)#">
</cfif>
<cfif QNewExt_4.recordcount GT 0>
	<cfset session.newExt_4 = "#valuelist(QNewExt_4.extfy)#">
</cfif>
<cfif QNewExt_5.recordcount GT 0>
	<cfset session.newExt_5 = "#valuelist(QNewExt_5.extfy)#">
</cfif>
</cfif>
<CFQUERY NAME="QcheckUsrName"
		 DATASOURCE="#application.DataSource#"
         USERNAME="#application.db_username#"
         PASSWORD="#application.db_password#">
		 select orgName, partnertype from Contact
		 where userid=<cfqueryparam cfsqltype="varchar" value="#session.userid#">
</CFQUERY>
	<cfset session.orgName=QcheckUsrName.orgname>
	<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QcheckAdmin">
	select
	<cfif QcheckUsrName.partnertype EQ 4>
	sp_fy as fy, sp_nextyr as nextyr, sp_prevyr as prevyr, sp_stratAlert as stratAlert
	<cfelse>
	fy, nextyr, prevyr,stratAlert
	</cfif>
	from admin
	</cfquery>
	<cfset session.def_fy=QcheckAdmin.fy>
	<cfset session.fy=QcheckAdmin.fy>
	<cfset session.modality=QcheckUsrName.partnertype>
	<cfset session.nextyr=QcheckAdmin.nextyr>
	<cfset session.prevyr=QcheckAdmin.prevyr>
	<cfparam name="session.fy" default="#session.def_fy#">
	  <cfif session.userid is 'test_cc' or session.userid is 'dplotner' or session.userid is 'twills' or session.userid is 'mchambard' or session.userid is 'nsarris' or session.userid is 'lolson'>
<cfparam name="session.fy" default="2016">
	<cfset session.def_fy=2016>
	<cfset session.fy=2016>
</cfif>
	<cflocation url="alteruser.cfm">
</cfif>
<cfparam name="session.origUserID" default="#session.userid#">
<cfif (session.admin EQ 1) OR (Session.TCP EQ "1")
		or
			 (session.userid EQ 'vxc04' OR session.userid EQ 'hxr03' or session.userid EQ 'hrc01' or session.userid EQ 'yct01'  or session.userid EQ 'eas10'  or session.userid EQ 'julie.wright'  or session.userid EQ 'sep06'  or session.userid EQ 'hbb01')
				or (session.origUserID EQ 'vxc04' OR session.origUserID EQ 'hxr03' or session.origUserID EQ 'hrc01' or session.origUserID EQ 'yct01'  or session.origUserID EQ 'eas10'  or session.origUserID EQ 'julie.wright'  or session.origUserID EQ 'sep06'  or session.origUserID EQ 'hbb01') or
							(session.userid EQ 'dplotner' or session.userid is 'twills' OR session.userid EQ 'nsarris' or session.userid EQ 'cschnefke' or session.userid EQ 'bmarkatos' or session.userid EQ 'lolson')
					or (isDefined("session.origUserID") AND (session.origUserID  EQ 'dplotner' OR session.origuserid eq 'twills' or session.origUserID EQ 'nsarris' or session.origUserID EQ 'cschnefke'  or session.origUserID EQ 'bmarkatos'  or session.origUserID EQ 'lolson'))>
	<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QPartnerlist">
	select distinct c.orgname, c.partnertype,c.userid, c.contact
from contact c, security s, contact cc, modality m
where c.partnertype = m.modality
and c.userid = s.userid
and c.cmanager=cc.userid
and (s.del is null or s.del !=1)
and (s.endyear is null or s.endyear > <cfqueryparam cfsqltype="date" value="7/1/#session.fy#">)
and c.partnertype <> 4
<cfif not(session.origUserID  EQ 'dplotnerX' or session.origuserid eq 'twills' OR session.origUserID EQ 'nsarris' or session.origUserID EQ 'cschnefke'  or session.origUserID EQ 'bmarkatos'  or session.origUserID EQ 'lolson')>
and isNull(c.coordemail,'rti.org') not like '%rti.org' and NOT(c.coordemail like '%health.state.ny.us%' OR c.email  like '%health.state.ny.us%')  and NOT(c.coordemail like '%health.ny.gov%' OR c.email  like '%health.ny.gov%')
 and c.orgname not in('Ann L.-- CP','Ann Whitfield-Green','Christina.peluso','Jill Dunkel','Julie steele','Van')

</cfif>
<cfif (session.origUserID EQ "julie.wright") OR  (session.UserID EQ "julie.wright")>
and c.partnertype in (1,6)
and c.userid not like 'tst_%'
<cfelseif (session.origUserID EQ "eas10") OR  (session.UserID EQ "eas10")>
and c.partnertype = 2
and c.userid not like 'tst_%'
</cfif>

<cfif (session.origUserID EQ "julie.wright") OR  (session.UserID EQ "julie.wright")>
	or c.userid = 'CAIGlobal'
	</cfif>

	order by 1
</cfquery>
<cfelseif session.areamanage EQ 1 and Session.cessMan EQ 0>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QArea">
	select num
	from area
	where manager_id=<cfqueryparam cfsqltype="varchar" value="#session.origUserID#">
</cfquery>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QPartnerlist">
	select orgname, c.userid, contact
	from contact as c, security as s
	where c.userid=s.userid
	and orgname is not null
	--and s.area in (#valuelist(QArea.num)#)
	<cfif SESSION.statemanage EQ 1>
	and c.partnertype != 9 AND ORGNAME NOT LIKE '%TEST%' AND ORGNAME NOT LIKE '%TST%'

	<cfelse>
			session.origUserID <!--- NEQ "hxr03" ---> NEQ "xxx">
	and c.cmanager = <cfqueryparam cfsqltype="varchar" value="#session.origUserID#">
	</cfif>
	<cfif   (session.userid EQ 'dplotner' or session.userid eq 'twills' or session.userid eq 'nsarris') >
	and c.partnertype !=4
	</cfif>
and partnertype <> 4
and (s.del is null or s.del !=1)
and (s.endyear is null or s.endyear > <cfqueryparam cfsqltype="date" value="7/1/#session.fy#">)
	order by 1
</cfquery>
</cfif>

<cfif (Session.CessMan CONTAINS 1 or Session.CessMan CONTAINS 2 or Session.CessMan CONTAINS 3 or Session.CessMan CONTAINS 4 or Session.CessMan CONTAINS 5 or Session.CessMan CONTAINS 6) and not
		( (session.userid EQ 'vxc04' OR session.userid EQ 'hxr03' or session.userid EQ 'hrc01' or session.userid EQ 'yct01'  or session.userid EQ 'eas10'  or session.userid EQ 'julie.wright'  or session.userid EQ 'sep06'  or session.userid EQ 'hbb01' or session.userid EQ 'aar04')
				or (session.origUserID EQ 'vxc04' OR session.origUserID EQ 'hxr03' or session.origUserID EQ 'hrc01' or session.origUserID EQ 'yct01'  or session.origUserID EQ 'eas10'  or session.origUserID EQ 'julie.wright'  or session.origUserID EQ 'sep06'  or session.origUserID EQ 'hbb01' or session.origUserID EQ 'aar04') or
							(session.userid EQ 'dplotner' OR session.userid eq 'twills' or session.userid EQ 'nsarris' or session.userid EQ 'cschnefke' or session.userid EQ 'bmarkatos' or session.userid EQ 'lolson')
					or (isDefined("session.origUserID") AND (session.origUserID  EQ 'dplotner' or session.origuserid eq 'twills' OR session.origUserID EQ 'nsarris' or session.origUserID EQ 'mchambard'  or session.origUserID EQ 'bmarkatos'  or session.origUserID EQ 'lolson')))>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QPartnerlist">
	select  orgname, c.userid, contact
	from contact as c, security as s
	where c.userid=s.userid
	and orgname is not null
and (s.del is null or s.del !=1)
and partnertype <> 4
and (s.endyear is null or s.endyear > <cfqueryparam cfsqltype="date" value="7/1/#session.fy#">)
and isNull(c.coordemail,'rti.org') not like '%rti.org'
	<cfif  NOT (session.userid EQ 'dplotner' or session.userid eq 'twills' or session.userid eq 'nsarris') >
	and c.partnertype !=4
	</cfif>
<cfif session.cessman contains (1)>
and c.partnertype = 1

</cfif>
	and (1=2
	<cfif session.cntMan EQ 1>
	or c.cmanager=<cfqueryparam cfsqltype="varchar" value="#session.origUserID#">
	<cfif session.origUserID EQ 'vxc04' or session.origUserID EQ 'lxk03'>
	or c.cmanager='kmc06'
	</cfif>
	</cfif>
	<cfif session.origUserID EQ "vxc04">
	or c.userid in('tompkins-co', 'carthageareahospital',
	'CCTFP','CUE_ACAA','mvnhealthAA','ongovAA','oswegocp','TPACC2',
	'uhs2', 'carthageareahospital', 'sjhsyr', 'mvnhealthCC'
	)
	</cfif>
	<cfif  (session.userid EQ 'dplotner' or session.userid eq 'twills' or session.userid eq 'nsarris') OR ((session.admin EQ 1  OR session.tcp EQ 1 OR session.statemanage EQ 1)  AND (not isDefined("session.cessman") or (session.cessman DOES NOT CONTAIN 1 and session.cessman DOES NOT CONTAIN 2 and session.cessman DOES NOT CONTAIN 3 and session.cessman DOES NOT CONTAIN 4 and session.cessman DOES NOT CONTAIN 5 and session.cessman DOES NOT CONTAIN 6)) and session.cntMan EQ 0 ) >
	or 1=1
	</cfif>
and isNull(c.coordemail,'rti.org') not like '%rti.org'
<cfif isDefined("session.cessman")>
	<cfif session.cessman contains 1 or  session.origUserID EQ "amw06">
		or c.partnertype = 1
	</cfif><cfif session.cessman contains 2 or session.userid is 'jah19'>
		or c.partnertype = 2
	</cfif><cfif session.cessman contains 3>
		or c.partnertype = 3
	</cfif>
	<cfif session.cessman contains 4>
		or c.partnertype = 4
	</cfif>
	<cfif session.cessman contains 5>
		or c.partnertype = 5
	</cfif>
	<cfif session.cessman contains 6>
		or c.partnertype = 6
	</cfif>
	<cfif (session.origUserID EQ "julie.wright") OR  (session.UserID EQ "julie.wright")>
	or c.userid = 'CAIGlobal'
	</cfif>
<cfelseif SESSION.statemanage EQ 1>
	or c.partnertype != 9
</cfif>
	) 
	order by 1
</cfquery>
</cfif>

<cfform name="changeUser" action="alteruser.cfm?#session.urltoken#">
<input type="hidden" name="doType" value="">
<table width="60%"  align="center" class="box">
<tr>
<td colspan="3"><br><br><br></td>
</tr>
<tr>
	<td>Login as:</td>
	<td>
	<select name="new_user">
	<option value="" selected>
	<cfoutput>
	<cfloop query="QPartnerlist">
	<option value="#userid#">#orgname#
	</cfloop>
	</cfoutput>
	<option value="yct01">yct01</option>
	</select>
	</td>
	<td><input type="submit" value="Change User" onclick="doChange('change');"></td>
</tr>
<tr>
	<td colspan="2">&nbsp;</td>
	<td><input type="submit" value="Restore User"  onclick="doChange('restore');"></td>
</tr>
<tr>
<td colspan="3"><br><br><br></td>
</tr>
</table>
</cfform>
</body>
</html>
