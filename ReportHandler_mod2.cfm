<cfif session.userid EQ 'mgallagher'>
	<cfset form.rptType = 427>
</cfif>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>
			CAT
		</title>
		<cfinclude template="CATstruct.cfm">
		<cfif isDefined("url.NYP")>
			<cfset session.rptyr=session.fy+1>
		<cfelse>
			<cfset session.rptyr=session.fy>
		</cfif>
		<cfparam name="form.rptType" default="3">
		<table align="left" cellpadding="10" cellspacing="0" border="0" class="box" width="50%">
			<script language="JavaScript">
function resetPartner(){
if(document.fReportHandler.partner != undefined){
document.fReportHandler.partner.value="ALL";
}
document.fReportHandler.target="_self";
document.fReportHandler.action="reportHandler_mod2.cfm<cfoutput>?#session.urltoken#</cfoutput>";
document.fReportHandler.submit();
}
function resetStrategy(){
if(document.fReportHandler.strategy != undefined){
document.fReportHandler.strategy.value="ALL";
}
document.fReportHandler.target="_self";
document.fReportHandler.action="reportHandler_mod2.cfm<cfoutput>?#session.urltoken#</cfoutput>";
document.fReportHandler.submit();
}
function resetGoal(){
if(document.fReportHandler.objective != undefined){
if(document.fReportHandler.goal == "ALL"){
document.fReportHandler.objective.value="NA";
}
}
document.fReportHandler.target="_self";
document.fReportHandler.action="reportHandler_mod2.cfm<cfoutput>?#session.urltoken#</cfoutput>";
document.fReportHandler.submit();
}
function chkSubmit(){
document.fReportHandler.target="_blank";
document.fReportHandler.action="rpt_switch2.cfm<cfoutput>?#session.urltoken#</cfoutput>";
document.fReportHandler.submit();
}
function setType(){
document.fReportHandler.target="_self";
document.fReportHandler.action="reportHandler_mod2.cfm<cfoutput>?#session.urltoken#</cfoutput>";
document.fReportHandler.submit();
}
</script>
			<cfparam name="reportuser" default="#session.userid#">
			<cfparam name="form.Region" default="ALL">
			<cfquery datasource="#application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="QuserArea">
select area
from security
where userid=<cfif isDefined("session.origUserID")><cfqueryparam value="#session.origUserID#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"><cfelse><cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"></cfif>
</cfquery>
			<cfquery datasource="#application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="Qarea">
	select distinct
	r.region, r.num
	from area a, region r
	where a.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and r.num !=5
	<cfif session.regionManage EQ "0" OR session.statemanage EQ "0" AND QuserArea.area NEQ "0">
	and a.num = <cfqueryparam value="#QuserArea.area#" cfsqltype="CF_SQL_INTEGER">
	</cfif>
	<cfif session.cntMan EQ 1 AND SESSION.CessMan EQ "0">
	and a.num in
	(select distinct a.num from area as a, contact c
where a.num=c.area and c.cmanager = <cfif isDefined("session.origUserID")><cfqueryparam value="#session.origUserID#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"><cfelse><cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"></cfif>)
	</cfif>
	and a.year2=r.year2
	and a.region = r.num
	order by 1
</cfquery>

			<cfquery datasource="#application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="QCM">
	select distinct c.contact as CMName , c.userid as CMid
	from contact as c, contact as c2, security s
	where c.userid=c2.cmanager
	and c2.partnertype !=1
	and c2.partnertype !=4
	and c2.userid = s.userid
	and (c2.coordemail not like '%rti.org' or c2.userid like 'test%')
	and isnull(s.endyear, '1/1/2055') > getdate()
	and s.del is null
	and s.userid <> 'lxk03' and c.userid <> 'julie.wright'
	and (s.endyear is null or s.endyear > getdate())
	and c.userid != 'dplotner'
	<cfif (isDefined("form.modality") and form.modality EQ 2) or session.cessman EQ 2>
	and c2.partnertype=2
<cfelseif (isDefined("form.modality") and form.modality EQ 3) or session.cessman EQ 3>
	and c2.partnertype=3
	</cfif>
	<CFIF session.cntMan EQ 1>
	and c2.partnertype in (select distinct partnertype from  contact cc, security ss
	where cc.userid=ss.userid and cc.cmanager='#session.userid#' and
	cc.coordemail not like '%rti.org' and cc.userid not like 'test%'
	and isnull(ss.endyear, '1/1/2055') > getdate()
	and ss.del is null)
	</CFIF>
	and c.userid not in ('lkb01', 'caf07','eht01','lxs08',<!---'hrc01',--->'aar04', 'dpatterson')
	order by 1
</cfquery>
			<cfquery datasource="#application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="Qpartner">
	select distinct c.orgName as partner, c.userid
	from contact as c, security as s, region as r, area as a
	where c.userid=s.userid
	and r.num=a.region
	and r.year2=a.year2
	and s.area=a.num
	and (s.endyear is null or s.endyear > '7/1/2015')
	and (isnull(coordemail, '-') not like '%rti.org' and c.userid not like 'test%' and isnull(coordemail, '-') not like '%health.state.ny%'  and isnull(coordemail, '-') not like '%health.ny%')
	and c.userid not in ('caw16','jkd02','jah19','mchambard','christina.peluso', 'dpatterson')
	and c.userid not in ('test_cp','test_yp','tst_genuser')
	and (partnertype = 2)
	and c.orgname is not null
	and c.orgname != ''
	and s.del is null
	<cfif session.areaManage EQ "0" AND session.regionManage EQ "0" AND session.statemanage EQ "0" AND QuserArea.area NEQ "0">
	and c.userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	</cfif>
	<cfif isDefined("form.CM") and form.CM EQ "vxc04">
	and (c.cmanager = '#form.cm#' or c.userid in('tompkins-co', 'carthageareahospital',
	'CCTFP','CUE_ACAA','mvnhealthAA','ongovAA','oswegocp','TPACC2'))
<cfelseif isDefined("form.CM") and form.CM NEQ "ALL">
	and c.cmanager = <cfqueryparam value="#form.cm#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	</cfif>
	<cfif isDefined("form.modality") and form.modality NEQ "ALL">
	and c.partnertype =<cfqueryparam value="#form.modality#" cfsqltype="CF_SQL_INTEGER">
	</cfif>
	order by 1
</cfquery>
		<cfquery datasource="#application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="Qpartner_cp">
	select c.orgName as partner, c.userid
	from contact as c, security as s, region as r, area as a
	where c.userid=s.userid
	and r.num=a.region
	and r.year2=a.year2
	and s.area=a.num
	and (s.endyear is null or s.endyear > '7/1/2015')
	and (isnull(coordemail, '-') not like '%rti.org' and c.userid not like 'test%' and isnull(coordemail, '-') not like '%health.state.ny%' and isnull(coordemail, '-') not like '%health.ny%')
	and c.userid not in ('caw16','jkd02','jah19','mchambard','christina.peluso', 'dpatterson')
	and partnertype = 2
	<cfif session.areaManage EQ "0" AND session.regionManage EQ "0" AND session.statemanage EQ "0" AND QuserArea.area NEQ "0">
	and c.userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	</cfif>
	and c.orgname is not null
	and c.orgname != ''
	and s.del is null
	<cfif isDefined("form.CM") and form.CM EQ "vxc04">
	and (c.cmanager = <cfqueryparam value="#form.cm#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> or c.userid in('tompkins-co', 'carthageareahospital',
	'CCTFP','CUE_ACAA','mvnhealthAA','ongovAA','oswegocp','TPACC2'))
<cfelseif isDefined("form.CM") and form.CM NEQ "ALL">
	and c.cmanager = <cfqueryparam value="#form.cm#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	</cfif>
	order by 1
</cfquery>

			<cfquery datasource="#application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="QcntMod">
	select distinct partnertype from contact
	where cmanager = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
</cfquery>
			<cfquery datasource="#application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="Qpartner_cpyp">
	select c.orgName as partner, c.userid
	from contact as c, security as s, region as r, area as a
	where c.userid=s.userid
	and r.num=a.region
	and r.year2=a.year2
	and s.area=a.num
	and a.year2=2010
	and (isnull(coordemail, '-') not like '%rti.org' and c.userid not like 'test%' and isnull(coordemail, '-') not like '%health.state.ny%' and isnull(coordemail, '-') not like '%health.ny%')
	and c.userid not in ('caw16','jkd02','jah19','mchambard', 'dpatterson')
	and c.userid not in ('test_cp','test_yp')
	and (partnertype = 2 or partnertype = 3)
	<cfif session.areaManage EQ "0" AND session.regionManage EQ "0" AND session.statemanage EQ "0" AND QuserArea.area NEQ "0">
	and c.userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	</cfif>
	and c.orgname is not null
	and c.orgname != ''
	and s.del is null
	<cfif isDefined("form.CM") and form.CM EQ "vxc04">
	and (c.cmanager = <cfqueryparam value="#form.cm#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> or c.userid in('tompkins-co', 'carthageareahospital',
	'CCTFP','CUE_ACAA','mvnhealthAA','ongovAA','oswegocp','TPACC2'))
<cfelseif session.CessMan NEQ 0>
	and 1=1
<cfelseif isDefined("form.CM") and form.CM NEQ "ALL">
	and c.cmanager = <cfqueryparam value="#form.cm#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	</cfif>
	<cfif isDefined("form.modality") and form.modality NEQ "ALL">
	and c.partnertype = <cfqueryparam value="#form.modality#" cfsqltype="CF_SQL_INTEGER">
	</cfif>
	<cfif isDefined("form.rpttype") and form.rpttype EQ 7>
	<cfif session.CessMan NEQ 0>
	and c.partnertype in (<cfqueryparam value="#session.cessman#" cfsqltype="CF_SQL_VARCHAR">)
	</cfif>
	<cfif session.cntMan NEQ 0 and session.userid NEQ 'dplotner' and  session.CessMan EQ 0>
	and c.cmanager = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	</cfif>
	<cfif not(session.areaManage EQ "0" AND session.regionManage EQ "0" AND session.statemanage EQ "0" AND session.admin EQ "0") and not isDefined("form.modality") and session.cessMan NEQ 3>
	and c.partnertype=2
	</cfif>
	</cfif>
	order by 1
</cfquery>
			<cfquery datasource="#application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="Qpartner_yp">
	select c.orgName as partner, c.userid
	from contact as c, security as s, region as r, area as a
	where c.userid=s.userid
	and r.num=a.region
	and r.year2=a.year2
	and s.area=a.num
	and a.year2=2010
	and (isnull(coordemail, '-') not like '%rti.org' and c.userid not like 'test%' and isnull(coordemail, '-') not like '%health.state.ny%' and isnull(coordemail, '-') not like '%health.ny%')
	and c.userid not in ('caw16','jkd02','jah19','mchambard', 'dpatterson')
	and partnertype = 3
	<cfif session.areaManage EQ "0" AND session.regionManage EQ "0" AND session.statemanage EQ "0" AND QuserArea.area NEQ "0">
	and c.userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	</cfif>
	and c.orgname is not null
	and c.orgname != ''
	and s.del is null
	<cfif isDefined("form.CM") and form.CM EQ "vxc04">
	and (c.cmanager = <cfqueryparam value="#form.cm#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> or c.userid in('tompkins-co', 'carthageareahospital',
	'CCTFP','CUE_ACAA','mvnhealthAA','ongovAA','oswegocp','TPACC2'))
<cfelseif isDefined("form.CM") and form.CM NEQ "ALL">
	and c.cmanager = <cfqueryparam value="#form.cm#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	</cfif>
	order by 1
</cfquery>
			<cfquery datasource="#application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="Qpartner_c4c">
	select c.orgName as partner, c.userid
	from contact as c, security as s, region as r, area as a
	where c.userid=s.userid
	and r.num=a.region
	and r.year2=a.year2
	and s.area=a.num
	and a.year2=2010
	and (isnull(coordemail, '-') not like '%rti.org' and c.userid not like 'test%' and isnull(coordemail, '-') not like '%health.state.ny%' and isnull(coordemail, '-') not like '%health.ny%')
	and partnertype = 5
	and del is null
	<cfif session.areaManage EQ "0" AND session.regionManage EQ "0" AND session.statemanage EQ "0" AND QuserArea.area NEQ "0">
	and c.userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	</cfif>
	<cfif isDefined("form.rptType") and (form.rptType EQ 8 or form.rptType EQ 18 or form.rptType EQ 19 or form.rptType EQ 25 or form.rptType EQ 21 or form.rptType EQ 24 or form.rptType EQ 33)>
	and c.partnertype=1
	</cfif>
	<cfif isDefined("form.modality") and form.modality NEQ "ALL">
	and c.partnertype=<cfqueryparam value="#form.modality#" cfsqltype="CF_SQL_INTEGER">
	</cfif>
	and c.orgname is not null
	and c.orgname != ''
	and s.del is null
	<cfif isDefined("form.CM") and form.CM EQ "vxc04">
	and (c.cmanager = <cfqueryparam value="#form.cm#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> or c.userid in('tompkins-co', 'carthageareahospital',
	'CCTFP','CUE_ACAA','mvnhealthAA','ongovAA','oswegocp','TPACC2'))
<cfelseif isDefined("form.CM") and form.CM NEQ "ALL">
	and c.cmanager = <cfqueryparam value="#form.cm#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	</cfif>
	order by 1
</cfquery>
			<cfif (isDefined("form.partner") and form.partner NEQ "ALL") OR Not isDefined("form.partner")>
				<cfquery datasource="#application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="Qstrategy">
	select  u.activity as strategy
	from
	security as s, contact as c, area as a, useractivities as u
	where s.userid=c.userid
	and s.area=a.num
	and u.userid=c.userid
	and a.year2=u.year2
	and
	<cfif isDefined("form.partner") and form.partner NEQ "ALL">
		(
		(u.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">)
		or
		(u.activity in (select distinct ss.activity
		from shareduseractivities ss, useractivities uu
		where ss.activity=uu.activity
		and ss.year2=uu.year2
		and uu.userid='shared' and ss.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> and ss.year2=#session.fy#
		union select '0000')
		)
		)
<cfelse>
		(
		(u.userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">)
		or
		(u.activity in (select distinct ss.activity
		from shareduseractivities ss, useractivities uu
		where ss.activity=uu.activity
		and ss.year2=uu.year2
		and uu.userid='shared' and ss.userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> and ss.year2=#session.fy#
		union select '0000')
		)
		)
	</cfif>
	and u.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	order by 1
</cfquery>
			</cfif>
			<cfquery datasource="#application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="QGoal">
	Select progNum, program
	from program
	where year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	order by 1
</cfquery>
			<cfif isDefined("form.goal") and form.goal NEQ "ALL" >
				<cfquery datasource="#application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="QObj">
	Select objective, id
	from objectives
	where year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and progNum=<cfqueryparam value="#form.goal#" cfsqltype="CF_SQL_INTEGER">
	and (del is null or del  != '1')
	order by 2
</cfquery>
			</cfif>
			<cfquery datasource="#application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="QObj1">
	Select initiative as objective, id
	from objectives
	where year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and (del is null or del  != '1') and 1 like modality
	order by 2
</cfquery>
			<cfquery datasource="#application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="QObj2">
	Select initiative as objective, id
	from objectives
	where year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and (del is null or del  != '1') and modality like '%2%'
	<cfif session.fy GT 2011>
	and id not in ('2M','3M')
	</cfif>
	order by 2
</cfquery>
			<cfquery datasource="#application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="QObj3">
	Select initiative as objective, id
	from objectives
	where year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and (del is null or del  != '1') and modality like '%3%'
	order by 2
</cfquery>
			<cfquery datasource="#application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="QObj5">
	Select initiative as objective, id
	from objectives
	where year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and (del is null or del  != '1') and modality like '%5%'
	order by 2
</cfquery>
			<cfquery datasource="#application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="QObjall">
	Select initiative as objective, id
	from objectives
	where year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and (del is null or del  != '1') AND ID <> '2M'
	and (modality like '%2%' or modality like '%3%' or modality like '%5%')

	order by 1
</cfquery>
			<cfquery datasource="#application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="QObjblah">
	Select initiative as objective, id
	from objectives
	where seq in (337,338) <cfif session.fy GTE 2014> or seq in (465, 466)</cfif>
	order by 1
</cfquery>
			<cfquery datasource="#application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="QObjblah2">
	Select initiative as objective, id
	from objectives
	where seq in (337,375)
	order by initiative
</cfquery>
			<cfquery datasource="#application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="QObjblah22">
	Select initiative as objective, id
	from objectives
	where seq in (337,375,380)
	order by initiative
</cfquery>
			<cfquery datasource="#application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="QObjblah3">
	Select initiative as objective, id
	from objectives
	where seq in (337,338,341)
	order by initiative
</cfquery>
			<cfquery datasource="#application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="QObjblah33">
	Select initiative as objective, id
	from objectives
	where seq in (337,338,341,375,380)
	order by initiative
</cfquery>
			<cfquery datasource="#application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="QObjblah4">
	Select initiative as objective, id
	from objectives
	where seq in (337,338,341,375)
	<cfif session.fy GTE 2013 and session.modality EQ 2>
		and seq not in (375)
    <cfelseif session.fy GTE 2013 and session.modality EQ 3>
		and seq not in (341,338)
	</cfif>
	order by initiative
</cfquery>
			<cfquery datasource="#application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="QObjeminit">
	Select *
	from eminit
	where year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> and modality = #session.modality#
	order by eminittxt
</cfquery>
			<cfquery datasource="#application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="QFarea">
	select strategy as descr, strategy_Num as num
	from strategy
	where year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	<cfif isDefined("form.rptType") and form.rptType EQ "6">and strategy_Num !=10</cfif>
	order by 2
</cfquery>
			<cfquery datasource="#application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="QGroup">
	select distinct groupname,groupnum
	from objectives
	where year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	order by groupname
</cfquery>
			<cfquery datasource="#application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="QTarget">
	select distinct target --, targetnum
	from targets
	where year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	order by target
</cfquery>

			<cfquery datasource="#application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="Qmonths">
	select mon, mon_num, rank, max(rank) as maxrank
	from
	months
	group by mon,mon_num,rank,year2
	having year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	<cfif session.fy EQ session.def_fy and session.def_fy GT 2018>
		and rank <= (select rank from months where mon = '#MonthAsString(Month(now()))#' and year2 = #session.fy#)
	</cfif>
	<cfif session.fy EQ 2010>
	and mon_num != 7
	</cfif>
		order by 3
</cfquery>
			<cfform scriptSrc="/scripts" name="fReportHandler">
			<input type="hidden" name="mod" value=2>
				<!--- <table> --->
				<tr>
					<td colspan=2 style="border-bottom : thin solid Navy;">
						<h5>
							<cfif session.fy LT 2015>
								Reality Check and Community Partnership
								<cfif session.fy LT 2012>
									and Colleges 4 Change
								</cfif>
							<cfelse>
								ATFC
							</CFIF>
							Reports
						</h5>
					</td>
				</tr>
				<tr>
					<td>
						Report Type
					</td>
					<td>
						<select name="rptType" onChange="setType();">
							<cfif session.userid NEQ 'mgallagher'>
								<cfif session.fy NEQ 2011>
									<option value="1103"
									<cfif isDefined("form.rptType") and form.rptType EQ "1103">
										selected
									</cfif>
									>Community Mobilization Report
								</cfif>
								<option value="3"
								<cfif isDefined("form.rptType") and form.rptType EQ "3">
									selected
								</cfif>
								>Contract Manager Feedback Report
								<cfif ((isDefined ("session.modality") and session.modality NEQ "1" or (session.admin EQ "1" OR session.statemanage EQ "1" OR session.cntMan EQ "1" OR session.regionmanage EQ "1" OR session.areamanage EQ "1")) or (not isDefined ("session.modality")))>
									<option value="1"
									<cfif isDefined("form.rptType") and form.rptType EQ "1">
										selected
									</cfif>
									>Contractor Monthly Activity Report
								</cfif>
								<cfif session.userid is 'dplotner' or session.userid is 'nsarris' or session.userid is 'mchambard'>
								</cfif>
							</cfif>
							<cfif session.fy GTE 2017>
									<option value="900" <cfif isDefined("form.rptType") and form.rptType EQ "900"> selected</cfif>>Disparities
							</CFIF>
							<option value="427"
							<cfif isDefined("form.rptType") and form.rptType EQ "427">
								selected
							</cfif>
							>Garnered Earned Media
							<cfif session.userid NEQ 'mgallagher'>
								<cfif session.fy NEQ 2011>
									<option value="825"
									<cfif isDefined("form.rptType") and form.rptType EQ "825">
										selected
									</cfif>
									>Government Policy Maker Ed. and Advocating Summary Report
								</cfif>
								<cfif session.fy NEQ 2011>
									<option value="409"
									<cfif isDefined("form.rptType") and form.rptType EQ "409">
										selected
									</cfif>
									>Initiative-specific Strategies and Earned Media Activities Report
								</cfif>
									<option value="901"
									<cfif isDefined("form.rptType") and form.rptType EQ "901">
										selected
									</cfif>
									>HUD
									<cfif (#session.userid# is 'dplotner' or #session.userid# is 'nsarris' or #session.userid# is 'bmarkatos'
									or #session.userid# is 'sep06' or #session.userid# is 'dxv06' or #session.userid# is 'eas10' or
									#session.userid# is 'aar04' or #session.userid# is 'jmv04' or #session.userid# is 'vxc04' or
									#session.userid# is 'hxr03' or #session.userid# is 'yct01' or #session.userid# is 'kmc06' or
									#session.userid# is 'jah19')
									or (isDefined ("session.modality") and (session.modality EQ "2" or session.modality EQ "3"))>
									<option value="7"
									<cfif isDefined("form.rptType") and form.rptType EQ "7">
										selected
									</cfif>
									>Point of Sale Outcomes Report
								</cfif>
								<!---
									<cfif session.fy GTE 2011 ><option value="4444" <cfif isDefined("form.rptType") and form.rptType EQ "4444"> selected</cfif>>	Progress Toward Outcomes Report
									</cfif>
									--->
								<cfif session.fy NEQ 2011 AND session.cessMan NEQ "2" AND (session.modality EQ "3"   or (session.admin EQ "1" OR session.statemanage EQ "1" OR session.cntMan EQ "1" OR session.regionmanage EQ "1" OR session.areamanage EQ "1")) >
									<option value="778"
									<cfif isDefined("form.rptType") and form.rptType EQ "778">
										selected
									</cfif>
									>Smoke-free Media Outcomes Report
								</cfif>
								<cfif session.modality EQ "2" or (session.admin EQ "1" OR session.statemanage EQ "1" OR session.cntMan EQ "1" OR session.regionmanage EQ "1" OR session.areamanage EQ "1") >
									<cfif session.cessMan NEQ "3">
										<cfif session.fy GTE 2011 >
											<option value="824"
											<cfif isDefined("form.rptType") and form.rptType EQ "824">
												selected
											</cfif>
											>Smoke-free Multi-unit
											<cfif session.fy gte 2015>
												Housing
											<cfelse>
												Dwellings
											</cfif>
											– Outcomes Report <option value="779"
											<cfif isDefined("form.rptType") and form.rptType EQ "779">
												selected
											</cfif>
											>Summary of Advocacy and Government Policy-Maker Ed. Targets <option value="666"
											<cfif isDefined("form.rptType") and form.rptType EQ "666">
												selected
											</cfif>
											>Tobacco-free Outdoors [Lawmaking Bodies] – Outcomes Report
										</cfif>
										<option value="777"
										<cfif isDefined("form.rptType") and form.rptType EQ "777">
											selected
										</cfif>
										>Tobacco-free Outdoors [Voluntary Policies] – Outcomes Report
									</cfif>
								</cfif>

								<cfif session.userid is 'dplotner' or session.userid is 'nsarris' or session.userid is 'mchambard'  or session.userid is 'sep06'>



								</cfif>
							</cfif>
						</select>
					</td>
				</tr>
				<input type="hidden" name="format" value="PDF">
				<tr>
					<td>
						<br>
						<br>
					</td>
				</tr>
				<cfif (isDefined("form.rptType") AND (form.rpttype eq 824 and session.fy lte 2014) and (session.admin EQ "1" OR session.statemanage EQ "1" OR session.cntMan EQ "1" OR session.regionmanage EQ "1"
					OR session.areamanage EQ "1"))>
					<tr>
						<td>
							Modality:
						</td>
						<td>
							<select name="modality" onChange="resetPartner();">
								<cfif (session.areamanage EQ "1" OR session.statemanage EQ "1" or Session.admin EQ "1" ) and  (session.cessMan EQ "0" or session.origUserID EQ "dplotner") and (isdefined("form.rpttype") and #form.rpttype# is not 2 and #form.rpttype# is not 4) >
									<cfif form.rpttype NEQ 7 and form.rpttype neq 666 and form.rpttype neq 33 and form.rpttype neq 777 and form.rpttype neq 824 and form.rpttype is not 778 and form.rpttype is not 1103>
										<option value="ALL"
										<cfif isDefined("form.modality") and form.modality EQ "ALL">
											selected
										</cfif>
										>All Modalities
									</cfif>
								</cfif>
								<!--- added  3.27.2009 dmp--->
								<cfif 1 EQ 2>
									<!--- temporarily disabled for modality access to all CMs --->
									<cfif session.cessman EQ 5 or session.cessman EQ 0 and (isdefined("form.rpttype") and #form.rpttype# is not 2 and #form.rpttype# is not 7)>
										<option value="5"
										<cfif isDefined("form.modality") and form.modality EQ "5">
											selected
										</cfif>
										>Colleges for Change</option>
									</cfif>
									<cfif session.cessman EQ 2 or session.cessman EQ 0 and (isdefined("form.rpttype") and #form.rpttype# is not 2 and #form.rpttype# is not 778 )>
										<option value="2"
										<cfif isDefined("form.modality") and form.modality EQ "2">
											selected
										</cfif>
										>Community Partnership </option>
									</cfif>
									<cfif session.cessman EQ 3 or session.cessman EQ 0 and (isdefined("form.rpttype") and #form.rpttype# is not 2 and #form.rpttype# is not 666 and #form.rpttype# is not 777 and #form.rpttype# is not 824)>
										<option value="3"
										<cfif isDefined("form.modality") and form.modality EQ "3">
											selected
										</cfif>
										>Reality Check</option>
									</cfif>
								<cfelseif  isdefined("form.rpttype") and #form.rpttype# EQ 7 and (session.statemanage EQ "1" or Session.admin EQ "1" or session.cessMan NEQ "0" or QcntMod.recordcount NEQ 0)>
									<cfif (session.cessman EQ 2 or (session.cessman EQ 0 and (QcntMod.recordcount EQ 0 or valuelist(QcntMod.partnertype) contains 2))) and #form.rpttype# is not 778 >
										<option value="2"
										<cfif isDefined("form.modality") and form.modality EQ "2">
											selected
										</cfif>
										>Community Partnership</option>
									</cfif>
									<cfif session.cessman EQ 3 or (session.cessman EQ 0 and (QcntMod.recordcount EQ 0 or valuelist(QcntMod.partnertype) contains 3)) and (isdefined("form.rpttype") and #form.rpttype# is not 666  and #form.rpttype# is not 777 and #form.rpttype# is not 824)>
										<option value="3"
										<cfif isDefined("form.modality") and form.modality EQ "3">
											selected
										</cfif>
										>Reality Check</option>
									</cfif>
								<cfelse>
									<!--- this block is temp. --->
									<!---<option value="ALL"<cfif isDefined("form.modality") and form.modality EQ "ALL"> selected</cfif>>All Modalities--->
									<cfif isdefined("form.rpttype") and #form.rpttype# is not 7>
										<cfif session.fy LT 2012>
											<option value="5"
											<cfif isDefined("form.modality") and form.modality EQ "5">
												selected
											</cfif>
											>Colleges for Change</option>
										</cfif>
									</cfif>
									<cfif session.cessman NEQ 3>
										<cfif isdefined("form.rpttype") and #form.rpttype# is not 778>
											<option value="2"
											<cfif isDefined("form.modality") and form.modality EQ "2">
												selected
											</cfif>
											>Community Partnership </option>
										</cfif>
									</cfif>
									<cfif session.cessman NEQ 2>
										<cfif isdefined("form.rpttype") and #form.rpttype# is not 666  and #form.rpttype# is not 777 and #form.rpttype# is not 824>
											<option value="3"
											<cfif isDefined("form.modality") and form.modality EQ "3">
												selected
											</cfif>
											>Reality Check</option>
										</cfif>
									</cfif>
								</cfif>
							</select>
						</td>
					</tr>
				</cfif>
			<input type="hidden" name="Region" value="ALL">
				<cfif ((session.admin EQ "1" OR session.statemanage EQ "1" OR session.cntMan EQ "1" OR session.regionmanage EQ "1" OR session.areamanage EQ "1") and NOT (isDefined("rptType") and (form.rptType EQ 33 or form.rpttype eq 7 or form.rpttype eq 666 or form.rpttype eq 777 or form.rpttype eq 778 or form.rpttype eq 824 or form.rpttype eq 824)))>
					<cfif NOT( isdefined("form.rpttype") and  (session.cessMan NEQ "0" or session.cntMan EQ "1"))>
						<tr>
							<td>
								Contract Manager:
							</td>
							<td>
								<select name="CM" onChange="resetPartner();">
									<cfoutput>
										<option value="ALL"
										<cfif isDefined("form.CM") and form.CM EQ "ALL">
											selected
										</cfif>
										>ALL Contract Managers
										<cfif NOT( isdefined("form.rpttype") and (#form.rpttype# eq 666 OR #form.rpttype# EQ 824 or #form.rpttype# eq 777 or #form.rpttype# eq 7 or #form.rpttype# eq 778))>
											<cfloop query="QCM">
												<option value="#QCM.CMid#"
												<cfif isDefined("form.CM") and form.CM EQ QCM.CMid>
													selected
												</cfif>
												>#CMName#
											</cfloop>
										</cfif>
									</cfoutput>
								</select>
							</td>
						</tr>
					</cfif>
				</cfif>
				<cfif isDefined("form.rptType") and form.rptType EQ "34" and (session.statemanage NEQ "1" and  Session.admin NEQ "1") AND session.areamanage EQ "1">
					<input type="hidden" name="area" value="<cfoutput>#QArea.num#</cfoutput>">
				</cfif>
				<cfif
					((isDefined("form.region")) OR (session.admin NEQ "1" and session.statemanage NEQ "1" ))
					and
					((isDefined("form.rptType") and form.rpttype neq "1103" and form.rptType NEQ "22" and form.rpttype neq "666" and form.rpttype neq "777"  and form.rpttype neq "824" and form.rptType NEQ "23"  and form.rptType NEQ "7" and form.rptType NEQ "778") or not isDefined("form.rptType"))>
					<tr>
						<td>
							Contractor Name:
						</td>
						<td>
							<select name="partner"
							<cfif NOT isDefined("form.rptType")
								OR (isDefined("form.rptType") and form.rptType NEQ "50" and form.rptType NEQ "51" and form.rptType NEQ "52" and form.rptType NEQ "53" and form.rptType NEQ "54"  and form.rptType NEQ "666"   and form.rptType NEQ "777"
								and form.rptType NEQ "55")>
								onchange="resetStrategy();"
							</cfif>
							>
							<cfoutput>
								<cfif session.statemanage EQ "1" OR session.areamanage EQ "1" or session.admin EQ "1" or session.cessman NEQ 0>
									<option value="ALL"
									<cfif isDefined("form.partner") and form.partner EQ "ALL">
										selected
									</cfif>
									>All Contractors
								</cfif>
								<cfif (isdefined("form.rpttype") and (#form.rpttype# is 1 or #form.rpttype# is 3 or #form.rpttype# is 4)) and (isdefined("form.modality") and #form.modality# is 5)>
									<cfloop query="Qpartner_c4c">
										<option value="#Qpartner_c4c.userid#"
										<cfif isDefined("form.partner") and form.partner EQ "#Qpartner_c4c.userid#">
											selected
										</cfif>
										>#partner#
									</cfloop>
								<cfelseif (isdefined("form.rpttype") and (#form.rpttype# is 1 or #form.rpttype# is 3)) and (isdefined("form.modality") and #form.modality# is 2)>
									<cfloop query="Qpartner_cp">
										<option value="#Qpartner_cp.userid#"
										<cfif isDefined("form.partner") and form.partner EQ "#Qpartner_cp.userid#">
											selected
										</cfif>
										>#partner#
									</cfloop>
								<cfelseif (isdefined("form.rpttype") and (#form.rpttype# is 1 or #form.rpttype# is 3)) and (isdefined("form.modality") and #form.modality# is 3)>
									<cfloop query="Qpartner_yp">
										<option value="#Qpartner_yp.userid#"
										<cfif isDefined("form.partner") and form.partner EQ "#Qpartner_yp.userid#">
											selected
										</cfif>
										>#partner#
									</cfloop>
								<cfelseif (isdefined("form.rpttype") and (#form.rpttype# is 7))>
									<cfloop query="Qpartner_cpyp">
										<option value="#Qpartner_cpyp.userid#"
										<cfif isDefined("form.partner") and form.partner EQ "#Qpartner_cpyp.userid#">
											selected
										</cfif>
										>#partner#
									</cfloop>
								<cfelseif session.cessman EQ 3>
									<cfloop query="Qpartner_yp">
										<option value="#Qpartner_yp.userid#"
										<cfif isDefined("form.partner") and form.partner EQ "#Qpartner_yp.userid#">
											selected
										</cfif>
										>#partner#
									</cfloop>
								<cfelseif session.cessman EQ 2>
									<cfloop query="Qpartner_cp">
										<option value="#Qpartner_cp.userid#"
										<cfif isDefined("form.partner") and form.partner EQ "#Qpartner_cp.userid#">
											selected
										</cfif>
										>#partner#
									</cfloop>
								<cfelse>
									<cfloop query="Qpartner">
										<option value="#Qpartner.userid#"
										<cfif isDefined("form.partner") and form.partner EQ "#Qpartner.userid#">
											selected
										</cfif>
										>#partner#
									</cfloop>
								</cfif>
							</cfoutput>
							</select>
						</td>
					</tr>
				</cfif>
				<cfif (not isDefined("form.rptType")) OR (isDefined("form.rptType") and (((form.rpttype eq 901 or form.rpttype eq 900 or form.rpttype eq 7 or form.rpttype eq 778 or form.rpttype eq 824 or form.rpttype eq 777 or form.rpttype eq 666) and session.fy gte 2015) or form.rptType EQ "1" OR form.rptType EQ "2" OR form.rptType EQ "3" OR form.rptType EQ "999" or form.rpttype eq "1103"))>
					<tr>
						<td>
							Date Range:
						</td>
						<td>
							<table class="box">
								<tr>
									<td>
										Start Month:
									</td>
									<td>
										<CFOUTPUT>
											<select name="stmonth" query="Qmonths">
												<CFLOOP query="Qmonths">
													<option value="#rank#"
													<cfif ((isDefined("form.stmonth") and form.stmonth EQ "#rank#")OR (NOT isDefined("form.stmonth") AND rank EQ "1"))>
														selected
													</cfif>
													>#mon#
												</CFLOOP>
											</select>
										</CFOUTPUT>
									</td>
								</tr>
								<tr>
									<td>
										End Month:
									</td>
									<td>
										<CFOUTPUT>
											<select name="endmonth" query="Qmonths">
												<CFLOOP query="Qmonths">
													<option value="#rank#"
													<cfif (#maxrank# eq #rank# or (isDefined("form.endmonth") and form.endmonth EQ "#rank#")OR (NOT isDefined("form.endmonth") AND rank EQ "12"))>
														selected
													</cfif>
													>#mon#
												</CFLOOP>
											</select>
										</CFOUTPUT>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
					<cfelseif isDefined("form.rptType") and form.rptType EQ "17" >
					<tr>
						<td>
							Date Range:
						</td>
						<td>
							<table class="box">
								<tr>
									<td>
										Start Date (m/d/yyyy):
									</td>
									<td>
										<cfif isDefined("form.stmonth") and form.stmonth GT 20>
											<cfinput type="text" name="stmonth" validate="date" value="#dateformat(form.stmonth, 'm/d/yyyy')#">
										<cfelse>
											<cfinput type="text" name="stmonth" validate="date">
										</cfif>
									</td>
								</tr>
								<tr>
									<td>
										End Date (m/d/yyyy):
									</td>
									<td>
										<cfif isDefined("form.endmonth") and form.endmonth GT 20>
											<cfinput type="text" name="endmonth" validate="date" value="#dateformat(form.endmonth, 'm/d/yyyy')#">
										<cfelse>
											<cfinput type="text" name="endmonth" validate="date">
										</cfif>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
					<cfelseif isDefined("form.rptType") and (form.rptType EQ "8" or form.rptType EQ "19" or form.rptType EQ "24")>
					<tr>
						<td>
							Date Range:
						</td>
						<td>
							<table class="box">
								<cfif  isDefined("form.rptType") and form.rptType EQ "8">
									<cfset tempendyr = 2008>
								<cfelse>
									<cfset tempendyr = session.fy>
								</cfif>
								<tr>
									<td>
										Starting Year:
									</td>
									<td>
										<CFOUTPUT>
											<select name="stYear">
												<CFLOOP from="2005" to="#tempendyr#" index="yrloop">
													<option value="#yrloop#">
														#evaluate(yrloop-1)#-#yrloop#
												</CFLOOP>
											</select>
										</CFOUTPUT>
									</td>
									<td>
										Starting Quarter:
									</td>
									<td>
										<select name="stquarter">
											<option value=1>
												Q1
											</option>
											<option value=2>
												Q2
											</option>
											<option value=3>
												Q3
											</option>
											<option value=4>
												Q4
											</option>
										</select>
									</td>
								</tr>
								<tr>
									<td>
										Ending Year:
									</td>
									<td>
										<CFOUTPUT>
											<cfif isDefined("form.rptType") and (form.rptType EQ "8")>
												<cfset endyr = #session.fy#<!--- -1 --->>
											<cfelse>
												<cfset endyr = #session.fy#>
											</cfif>
											<select name="endYear">
												<CFLOOP from="2005" to="#tempendyr#" index="yrloop">
													<option value="#yrloop#">
														#evaluate(yrloop-1)#-#yrloop#
												</CFLOOP>
											</select>
										</CFOUTPUT>
									</td>
									<td>
										Ending Quarter:
									</td>
									<td>
										<select name="endquarter">
											<option value=1>
												Q1
											</option>
											<option value=2>
												Q2
											</option>
											<option value=3>
												Q3
											</option>
											<option value=4>
												Q4
											</option>
										</select>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
					<cfelseif isDefined("form.rptType") and (form.rptType EQ "21")>
					<tr>
						<td>
							Date Range:
						</td>
						<td>
							<table class="box">
								<tr>
									<td>
										Max Quarter:
									</td>
									<td>
										<select name="stquarter">
											<option value=1>
												Q1
											</option>
											<option value=2>
												Q2
											</option>
											<option value=3>
												Q3
											</option>
											<option value=4>
												Q4
											</option>
										</select>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
				</cfif>
				<cfif isDefined("form.rpttype") and (form.rpttype EQ 1 or form.rpttype EQ 2
				or form.rpttype EQ 4 or form.rpttype EQ 4444 or form.rpttype EQ 1103 or form.rpttype EQ 427
				or form.rpttype EQ 779  or form.rpttype EQ 825 or form.rpttype eq 409)>
				<tr> <td>Initiative:</td> <td> <CFOUTPUT> <select name="objective" multiple   class="mlti">
					<option value="ALL"> All Initiatives
					<cfif form.rpttype eq 427><CFLOOP query="Qobjeminit">
						<option value="#eminitnum#">#eminittxt# </CFLOOP>
						<cfif session.fy LT 2013>
							<option value="init7">Comprehensive School Policy</option> </cfif>

							<cfelse>
							<cfif form.rpttype eq 1 and ((isdefined("form.modality") and form.modality EQ 3) or session.modality EQ 3)> <CFLOOP query="Qobjblah22"> <option value="#id#" <cfif isDefined("form.objective") AND form.objective EQ "#id#"> selected</cfif>>#objective# </CFLOOP> <cfelseif form.rpttype EQ 1103> <cfif isdefined("form.modality") and #form.modality# is 3> <CFLOOP query="Qobjblah2"> <option value="#id#" <cfif isDefined("form.objective") AND form.objective EQ "#id#"> selected</cfif>>#objective# </CFLOOP> <cfelse> <CFLOOP query="Qobjblah"> <option value="#id#" <cfif isDefined("form.objective") AND form.objective EQ "#id#"> selected</cfif>>#objective# </CFLOOP></cfif> <cfelseif form.rpttype EQ 2> <CFLOOP query="Qobj1"> <option value="#id#" <cfif isDefined("form.objective") AND form.objective EQ "#id#"> selected</cfif>>#objective# </CFLOOP> <cfelseif (form.rpttype EQ 1 or form.rpttype eq 3)> <cfif (isdefined("session.modality") and #session.modality# is 1)> <CFLOOP query="Qobjall"> <option value="#id#" <cfif isDefined("form.objective") AND form.objective EQ "#id#"> selected</cfif>>#objective# </CFLOOP> <cfelseif isdefined("session.modality") and #session.modality# is 2> <CFLOOP query="Qobjblah33"> <option value="#id#" <cfif isDefined("form.objective") AND form.objective EQ "#id#"> selected</cfif>>#objective# </CFLOOP> </cfif> <cfelseif (form.rpttype EQ 825 or form.rpttype EQ 779) and (isdefined("form.modality") and #form.modality# is 2)> <option value="2d" <cfif isDefined("form.objective") AND form.objective EQ "2d"> selected</cfif>>Point of Sale (POS) <option value="4f" <cfif isDefined("form.objective") AND form.objective EQ "4f"> selected</cfif>>Smoke-free Multi-unit Dwellings <option value="2e" <cfif isDefined("form.objective") AND form.objective EQ "2e"> selected</cfif>>Tobacco-free Outdoors <cfelseif (form.rpttype EQ 825 or form.rpttype EQ 779) and (isdefined("form.modality") and #form.modality# is 3)> <option value="2d" <cfif isDefined("form.objective") AND form.objective EQ "2d"> selected</cfif>>Point of Sale (POS) <option value="3m" <cfif isDefined("form.objective") AND form.objective EQ "3m"> selected</cfif>>Smoke-free Media <cfelseif (form.rpttype EQ 825 or form.rpttype EQ 779)> <option value="2d" <cfif isDefined("form.objective") AND form.objective EQ "2d"> selected</cfif>>Point of Sale (POS) <cfif (session.modality EQ 2 and session.fy GTE 2015) > <option value="3m" <cfif isDefined("form.objective") AND form.objective EQ "3m"> selected</cfif>>Smoke-free Media </cfif> <cfif NOT(session.modality EQ 3 and session.fy GTE 2013) > <option value="4f" <cfif isDefined("form.objective") AND form.objective EQ "4f"> selected</cfif>>Smoke-free Multi-unit Housing <option value="2e" <cfif isDefined("form.objective") AND form.objective EQ "2e"> selected</cfif>>Tobacco-free Outdoors </cfif> <cfelseif (isdefined("form.modality") and #form.modality# is 1)> <CFLOOP query="Qobj1"> <option value="#id#" <cfif isDefined("form.objective") AND form.objective EQ "#id#"> selected</cfif>>#objective# </CFLOOP> <cfelseif (isdefined("form.modality") and #form.modality# is 2)> <cfif form.rpttype eq 409> <CFLOOP query="Qobjblah3"> <option value="#id#" <cfif isDefined("form.objective") AND form.objective EQ "#id#"> selected</cfif>>#objective# </CFLOOP> <cfelse> <cfif session.modality EQ 2 and session.cntMan EQ 0 AND SESSION.CessMan EQ "0"> <CFLOOP query="Qobj2"> <option value="#id#" <cfif isDefined("form.objective") AND form.objective EQ "#id#"> selected</cfif>>#objective# </CFLOOP> </cfif> </cfif> <cfelseif (isdefined("form.modality") and #form.modality# is 3)> <cfif form.rpttype eq 409> <CFLOOP query="Qobjblah2"> <option value="#id#" <cfif isDefined("form.objective") AND form.objective EQ "#id#"> selected</cfif>>#objective# </CFLOOP> <cfelse> <cfif session.modality EQ 2 and session.cntMan EQ 0 AND SESSION.CessMan EQ "0"> <CFLOOP query="Qobj3"> <option value="#id#" <cfif isDefined("form.objective") AND form.objective EQ "#id#"> selected</cfif>>#objective# </CFLOOP> </cfif> </cfif> <cfelseif isdefined("form.modality") and #form.modality# is 5> <CFLOOP query="Qobj5"> <option value="#id#" <cfif isDefined("form.objective") AND form.objective EQ "#id#"> selected</cfif>>#objective# </CFLOOP> <cfelse> <cfif form.rpttype eq 409> <CFLOOP query="Qobjblah4"> <option value="#id#" <cfif isDefined("form.objective") AND form.objective EQ "#id#"> selected</cfif>>#objective# </CFLOOP> <cfelse> <CFLOOP query="Qobjall"> <option value="#id#" <cfif isDefined("form.objective") AND form.objective EQ "#id#"> selected</cfif>> #objective# </CFLOOP> </cfif> </cfif> <cfif (form.rpttype is not 1103) and (form.rpttype is not 825) and (form.rpttype is not 779) and (form.rpttype is not 409)> <option value="em" <cfif isDefined("form.objective") AND form.objective EQ "em"> selected</cfif>>Earned Media <option value="inf" <cfif isDefined("form.objective") AND form.objective EQ "inf"> selected</cfif>>Infrastructure </cfif> </cfif> </select> </CFOUTPUT> </td> </tr> <cfelseif not isDefined("form.rpttype")> <tr> <td>Initiative:</td> <td> <CFOUTPUT> <select name="objective" multiple   class="mlti"> <option value="ALL"> All Initiatives <CFLOOP query="Qobjall"> <option value="#id#" <cfif isDefined("form.objective") AND form.objective EQ "#id#"> selected</cfif>>#objective# </CFLOOP> <option value="em" <cfif isDefined("form.objective") AND form.objective EQ "em"> selected</cfif>>Earned Media <option value="inf" <cfif isDefined("form.objective") AND form.objective EQ "inf"> selected</cfif>>Infrastructure </select> </CFOUTPUT> </td> </tr> </cfif> </td> </tr>




<cfif (form.rpttype EQ 900)>
<tr>
<td>Topic:</td>
<td>
	<CFOUTPUT>
		<select name="topic" multiple   class="mlti">
				<option value="ALL"> All Topics
				<option value="2D"> Point of Sale
				<option value="3M"> Smoke-free Media
				<option value="4F"> Smoke-free Multi-unit Housing
				<option value="2E"> Tobacco-free Outdoors
				<!---
				<option value="8C"> Cessation Services and Media
				<option value="8A"> Medical Health Systems Change
				<option value="8B"> Mental Health Systems Change
				--->
				<option value="9x"> Other
		</select>
	</CFOUTPUT>
</td>
</tr>
</cfif>





				<tr>
					<td>
					</td>
					<td>
						<input type="Button" value="Generate Report" onClick="chkSubmit();">
					</td>
				</tr>
		</table>
		</cfform> </body>
</html>

