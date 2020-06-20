<cfoutput>
	<cfset obj='All Initiatives'>
	<cfif isdefined("form.objective") and form.objective NEQ "ALL">
		<cfset obj = ''>
		<cfset objlst = ''>
		<cfloop index="x" list="#form.objective#">
			<cfquery datasource="#Application.DataSource#"
			password="#Application.db_password#"
			username="#Application.db_username#" name="Qobj">
			select id,initiative from objectives where id = '#x#'
			and year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
			order by initiative
		</cfquery>
			<cfif qobj.initiative is not ''>
				<cfset obj = ListAppend(obj, qobj.initiative, ",")>
				<cfset objlst = #quotedvaluelist(qobj.id)#>
			</cfif>
		</cfloop>
	</cfif>
	<cfif isdefined("form.objective") and #form.objective# contains "em">
		<cfset obj = ListAppend(obj, 'Earned Media', ",")>
	</cfif>
	<cfif isdefined("form.objective") and #form.objective# contains "inf">
		<cfset obj = ListAppend(obj, 'Infrastructure', ",")>
	</cfif>
</cfoutput>
<cfset session.rptmode = "main">
<cfif isDefined("form.farea") and form.farea CONTAINS "ALL">
	<cfset form.farea = "ALL">
</cfif>

<cfif isDefined("form.modality")>
	<cfif form.modality EQ "1">
		<cfset rptmodality = "Cessation Centers">
	<cfelseif form.modality EQ "2">
		<cfset rptmodality = "ATFCs">
	<cfelseif form.modality EQ "3">
		<cfset rptmodality = "Youth Partners">
	<cfelse>
		<cfset rptmodality = "ALL">
	</cfif>
<cfelse>
	<cfset form.modality = session.modality>
	<cfset rptmodality = "ALL">
</cfif>
<cfset modality_rank = "rank">
<cfparam name="form.objective" default="ALL">
<cfif form.objective contains "ALL">
	<cfset form.objective = "ALL">
</cfif>
<cfif isdefined("form.cm")>
<cfswitch expression="#form.cm#">
<cfcase value="hxr03">
<cfset cms = "Hiram Rivera">
</cfcase>
<cfcase value="vxc04">
<cfset cms = "Van Cleary-Hammarstedt">
</cfcase>
<cfcase value="yct01">
<cfset cms = "Yvonne C. Thorne">
</cfcase>
<cfdefaultcase>
<cfset cms = "All">
</cfdefaultcase>
</cfswitch>
</cfif>

<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="QendRnk">
	select rank
	from months
	where mon_num=#DatePart('m', Now())# and year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
</cfquery>
<cfparam name="form.stMonth" default="1">
<cfif #datepart('yyyy', Now())# GT #session.fy#>
	<cfparam name="form.endMonth" default="12">
<cfelse>
	<cfparam name="form.endMonth" default="#QendRnk.rank#">
</cfif>
<cfif isDefined("form.stmonth")>
	<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="Qstmn">
	select rank, mon_num
	from months
	where rank=<cfqueryparam value="#form.stmonth#" cfsqltype="CF_SQL_INTEGER"> and year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	order by 1
</cfquery>
	<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="Qendmn">
	select rank, mon_num
	from months
	where rank=<cfqueryparam value="#form.endmonth#" cfsqltype="CF_SQL_INTEGER"> and year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	order by 1
</cfquery>
	<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="Qmonlist">
	select mon
	from months
	where rank between <cfqueryparam value="#Qstmn.rank#" cfsqltype="CF_SQL_INTEGER"> and
	<cfif session.fy LT session.def_fy AND form.rptType EQ "4444" >
	12
<cfelse>
	<cfqueryparam value="#Qendmn.rank#" cfsqltype="CF_SQL_INTEGER">
	</cfif>
	and year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	order by rank
</cfquery>
	<cfset monthrange="(#quotedValueList(QMonlist.Mon, ",")#)">
	<cfset monthrange2="#quotedValueList(QMonlist.Mon)#">
	<cfset monthrange=replace(monthrange,"('", "")>
	<cfset monthrange=replace(monthrange,"')", "")>
	<cfset monthrange=rereplace(monthrange,"'", "", "all")>
	<cfset monthrange3=rereplace(monthrange2,"'", "", "all")>
	<cfset monthrange6="#ValueList(QMonlist.Mon)#">
</cfif>
<cfset rptfy="#session.fy#">
<cfif NOT isDefined("form.rptType")>
	<cflocation url="reporthandler_mod2.cfm" addtoken="yes">
</cfif>
<cfparam name="form.Area" default="ALL">
<cfparam name="form.Region" default="ALL">
<cfparam name="form.fArea" default="ALL">
<cfparam name="form.partner" default="ALL">
<cfparam name="form.CM" default="ALL">
<cfswitch expression = "#form.rptType#">
	<cfcase value="1">

<cfset foo = createObject("component", "cfcs.ReportLog").logreport(reportid=1) />
		<cfoutput>
				<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="conmon">
select orgname,case m.mon when 1 then 'January' when 2 then 'February' when 3 then 'March' when 4 then 'April' when 5 then 'May' when 6 then 'June' when 7 then 'July' when 8 then 'August' when 9 then 'September' when 10 then 'October' when 11 then 'November' when 12 then 'December' end as monty,
	initnum,initiative,advmassmail,m.userid,editor,prsspk,prssrlse,calls, NULL as legvisit,NULL as legcorr,NULL as mediarep,null as numsub, null as numpub,summary,barriers,steps, c.partnertype,dispstrat1,dispstrat2,dispstrat3,dispstrat4,dispstrat5,'' as dispstrattxt
	from monthly m
	inner join contact c on m.userid = c.userid
	and c.orgname not in ('dp-22poo','test_cp','test_cp1','TEST_YP','nikie')
	and isNull(c.suppress, 0) !=1
	and c.userid not like 'test%'
	inner join objectives o
	on m.initnum = o.id and m.year2 = o.year2
	inner join months mo on m.mon = mo.mon_num and m.year2 = mo.year2
	where
	1=1
	<cfif isDefined("form.modality") and form.modality NEQ "ALL" and form.modality NEQ "" and form.modality NEQ "0">
	and c.partnertype = <cfqueryparam value="#form.modality#" cfsqltype="CF_SQL_INTEGER">
	</cfif>
	<cfif isDefined("form.CM") and form.CM EQ "vxc04">
	and (m.userid in (select userid from contact where cmanager = <cfqueryparam value="#form.cm#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">) or m.userid in('tompkins-co', 'carthageareahospital',
	'CCTFP','CUE_ACAA','mvnhealthAA','ongovAA','oswegocp','TPACC2'))
<cfelseif isdefined("form.cm") and form.cm is not 'all'>
	and m.userid in (select userid from contact where cmanager = <cfqueryparam value="#form.cm#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">)
	</cfif>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
		and m.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
<cfelseif isDefined("form.Region") and form.region is not 'all'>
		and m.userid in
		(select userid from security s, area a, region r
where s.del is null
and s.area = a.num
and a.region=r.num
and a.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
and r.num=<cfqueryparam value="#form.region#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
and r.year2=a.year2 )
	</cfif>
and m.userid not in ('nsarris') and m.userid not like 'test%'
	and m.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
    and mo.rank >= <cfqueryparam value="#form.stmonth#" cfsqltype="CF_SQL_INTEGER">
	and mo.rank <= <cfqueryparam value="#form.endmonth#" cfsqltype="CF_SQL_INTEGER">
and c.partnertype <> 1
	<cfif isdefined("form.objective") and form.objective NEQ "ALL">
		and initnum in (#ListQualify(Form.objective,"'")#)
	</cfif>
	<cfif isdefined("form.objective") and (form.objective EQ "ALL" or form.objective CONTAINS 'em')>
	union
select orgname,case e.mon when 1 then 'January' when 2 then 'February' when 3 then 'March' when 4 then 'April' when 5 then 'May'
when 6 then 'June' when 7 then 'July' when 8 then 'August' when 9 then 'September' when 10 then 'October' when 11 then 'November'
when 12 then 'December' end as monty,
	'998' as initnum,'Earned Media' as initiative,'' as advmassmail,e.userid,'' as editor,'' as prsspk,'' as prssrlse,'' as calls,
	1 as legvisit,1 as legcorr,1 as mediarep,1 as numsub,1 as numpub,'' as summary,'' as barriers,'' as steps, c.partnertype,'' as dispstrat1,'' as dispstrat2,'' as dispstrat3,'' as dispstrat4,'' as dispstrat5,'' as dispstrattxt
	from em e
	inner join contact c on e.userid = c.userid
	and c.orgname not in ('dp-22poo','test_cp','test_cp1','TEST_YP','nikie')
	and isNull(c.suppress, 0) !=1
	and c.userid not like 'test%'
	inner join months mo on e.mon = mo.mon_num and e.year2 = mo.year2
	left outer join ems i  on i.userid = c.userid
	and  i.mon = mo.mon_num and i.year2 = mo.year2
where	1=1
<cfif isDefined("form.modality") and form.modality NEQ "ALL" and form.modality NEQ "" and form.modality NEQ "0">
	and c.partnertype = <cfqueryparam value="#form.modality#" cfsqltype="CF_SQL_INTEGER">
	</cfif>
	<cfif isDefined("form.CM") and form.CM EQ "vxc04">
	and (c.userid in (select userid from contact where cmanager = <cfqueryparam value="#form.cm#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">) or c.userid in('tompkins-co', 'carthageareahospital',
	'CCTFP','CUE_ACAA','mvnhealthAA','ongovAA','oswegocp','TPACC2'))
<cfelseif  isdefined("form.cm") and form.cm is not 'all'>
	and c.userid in (select userid from contact where cmanager = <cfqueryparam value="#form.cm#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">)
	</cfif>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
<cfelseif isDefined("form.Region") and form.region is not 'all'>
		and c.userid in
		(select userid from security s, area a, region r
and year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
 )
)
	</cfif>
 and c.userid not in ('nsarris') and c.userid not like 'test%'
	and mo.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and mo.rank >= <cfqueryparam value="#form.stmonth#" cfsqltype="CF_SQL_INTEGER">
	and mo.rank <= <cfqueryparam value="#form.endmonth#" cfsqltype="CF_SQL_INTEGER">
	</cfif>
	<cfif isdefined("form.objective") and (form.objective EQ "ALL" or form.objective CONTAINS 'inf')>
	union
select orgname,case infra.mon when 1 then 'January' when 2 then 'February' when 3 then 'March' when 4 then 'April' when 5 then 'May'
when 6 then 'June' when 7 then 'July' when 8 then 'August' when 9 then 'September' when 10 then 'October' when 11 then 'November'
when 12 then 'December' end as monty,
	'999' as initnum,'Infrastructure' as initiative,'' as advmassmail,infra.userid,'' as editor,'' as prsspk,'' as prssrlse,'' as calls,
	legvisit,legcorr,mediarep,numsub,numpub,'' as summary,'' as barriers,'' as steps, c.partnertype,'' as dispstrat1,'' as dispstrat2,'' as dispstrat3,'' as dispstrat4,'' as dispstrat5, '' as dispstrattxt
	from infra
	inner join contact c on infra.userid = c.userid
	and c.orgname not in ('dp-22poo','test_cp','test_cp1','TEST_YP','nikie')
	and isNull(c.suppress, 0) !=1
	and c.userid not like 'test%'
	inner join months mo on infra.mon = mo.mon_num and infra.year2 = mo.year2
	where
	1=1
	<cfif isDefined("form.modality") and form.modality NEQ "ALL" and form.modality NEQ "0">
	and c.partnertype = <cfqueryparam value="#form.modality#" cfsqltype="CF_SQL_INTEGER">
	</cfif>
	<cfif isDefined("form.CM") and form.CM EQ "vxc04">
	and (infra.userid in (select userid from contact where cmanager = <cfqueryparam value="#form.cm#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">) or infra.userid in('tompkins-co', 'carthageareahospital',
	'CCTFP','CUE_ACAA','mvnhealthAA','ongovAA','oswegocp','TPACC2'))
<cfelseif  isdefined("form.cm") and form.cm is not 'all'>
	and infra.userid in (select userid from contact where cmanager = <cfqueryparam value="#form.cm#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">)
	</cfif>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and infra.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
<cfelseif isDefined("form.Region") and form.region is not 'all'>
		and infra.userid in
		(select userid from security s, area a, region r
where s.del is null
and s.area = a.num
and a.region=r.num
and a.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
and r.num=<cfqueryparam value="#form.region#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
and r.year2=a.year2 )
	</cfif>
and c.partnertype <> 1
and c.userid not in ('nsarris') and c.userid not like 'test%'
	and mo.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and mo.rank >= <cfqueryparam value="#form.stmonth#" cfsqltype="CF_SQL_INTEGER">
	and mo.rank <= <cfqueryparam value="#form.endmonth#" cfsqltype="CF_SQL_INTEGER">
	</cfif>
order by c.orgname, initnum
</cfquery>
			<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="conmontw">
select distinct top 10 orgname,case m.mon when 1 then 'January' when 2 then 'February' when 3 then 'March' when 4 then 'April' when 5 then 'May' when 6 then 'June' when 7 then 'July' when 8 then 'August' when 9 then 'September' when 10 then 'October' when 11 then 'November' when 12 then 'December' end as monty,
	initnum,initiative,m.userid
	from monthly m
	inner join contact c on m.userid = c.userid
	and c.orgname not in ('dp-22poo','test_cp','test_cp1','TEST_YP','nikie')
	and isNull(c.suppress, 0) !=1
	and c.userid not like 'test%'
	inner join objectives o
	on m.initnum = o.id and m.year2 = o.year2
	inner join months mo on m.mon = mo.mon_num and m.year2 = mo.year2
	where
	1=1
	and m.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> and m.initnum = '2d' and m.userid = <cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
   </cfquery>
			<cfif session.userid is 'xxChemungYP'>
				<cfreport template="./reports/conmon4.cfr" format = "pdf" query="conmon">
					<CFREPORTPARAM name=Year2 VALUE=#session.fy#>
					<CFREPORTPARAM name=Area VALUE="#form.region#">
					<CFREPORTPARAM name=modality VALUE="ALL">
					<CFREPORTPARAM name=FOCUSAREA VALUE="All">
					<CFREPORTPARAM name=Prognum VALUE="All">
					<cfif isdefined("obj") and #obj# is not '' and #obj# NEQ "()">
						<CFREPORTPARAM name=Obj VALUE="#obj#">
					<cfelse>
						<CFREPORTPARAM name=Obj VALUE="All">
					</cfif>
					<cfif isdefined("form.objective")>
						<CFREPORTPARAM name=Objective VALUE="Retail">
					<cfelse>
						<CFREPORTPARAM name=Objective VALUE="All">
					</cfif>
					<CFREPORTPARAM name=Strategy VALUE="All">
					<CFREPORTPARAM name=ReportName VALUE="PP">
					<CFREPORTPARAM name=StMonth VALUE="#form.stmonth#">
					<CFREPORTPARAM name=endMonth VALUE="#form.endmonth#">
					<CFREPORTPARAM name=stYear VALUE="2007">
					<CFREPORTPARAM name=endYr VALUE="2007">
					<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">
					<CFREPORTPARAM name=Modality VALUE="#form.modality#">
					<CFREPORTPARAM name=ModWrd VALUE="CP & YA">
					<CFREPORTPARAM name=Monthrange VALUE="#Monthrange#">
				</cfreport>
			<cfelseif session.fy GTE 2015 and form.modality is 2>
				<cfreport template="./reports/conmonCP2015.cfr"  format = "pdf" query="conmon">
					<CFREPORTPARAM name=Year2 VALUE=#session.fy#>
					<CFREPORTPARAM name=Area VALUE="#form.region#">
					<CFREPORTPARAM name=modality VALUE="ALL">
					<CFREPORTPARAM name=FOCUSAREA VALUE="All">
					<CFREPORTPARAM name=Prognum VALUE="All">
					<cfif isdefined("obj") and #obj# is not '' and #obj# NEQ "()">
						<CFREPORTPARAM name=Obj VALUE="#obj#">
					<cfelse>
						<CFREPORTPARAM name=Obj VALUE="All">
					</cfif>
					<cfif isdefined("form.objective")>
						<CFREPORTPARAM name=Objective VALUE="#form.objective#">
					<cfelse>
						<CFREPORTPARAM name=Objective VALUE="All">
					</cfif>
					<CFREPORTPARAM name=Strategy VALUE="All">
					<CFREPORTPARAM name=ReportName VALUE="PP">
					<CFREPORTPARAM name=StMonth VALUE="#form.stmonth#">
					<CFREPORTPARAM name=endMonth VALUE="#form.endmonth#">
					<CFREPORTPARAM name=stYear VALUE="2007">
					<CFREPORTPARAM name=endYr VALUE="2007">
					<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">
					<CFREPORTPARAM name=Modality VALUE="#form.modality#">
					<cfif isdefined("form.modality") and #form.modality# is 1>
						<CFREPORTPARAM name=ModWrd VALUE="Cessation Center">
					<cfelseif isdefined("form.modality") and #form.modality# is 2>
						<CFREPORTPARAM name=ModWrd VALUE="ATFC">
					<cfelseif isdefined("form.modality") and #form.modality# is 3>
						<CFREPORTPARAM name=ModWrd VALUE="Reality Check">
					<cfelseif isdefined("form.modality") and #form.modality# is 5>
						<CFREPORTPARAM name=ModWrd VALUE="Colleges for Change">
					<cfelse>
						<CFREPORTPARAM name=ModWrd VALUE="All Modalities">
					</cfif>
					<CFREPORTPARAM name=Monthrange VALUE="#Monthrange#">
				</cfreport>
			<cfelseif session.fy GTE 2012 and session.fy LT 2015 and form.modality is 2>
				<cfreport template="./reports/conmonCP.cfr"  format = "pdf" query="conmon">
					<CFREPORTPARAM name=Year2 VALUE=#session.fy#>
					<CFREPORTPARAM name=Area VALUE="#form.region#">
					<CFREPORTPARAM name=modality VALUE="ALL">
					<CFREPORTPARAM name=FOCUSAREA VALUE="All">
					<CFREPORTPARAM name=Prognum VALUE="All">
					<cfif isdefined("obj") and #obj# is not '' and #obj# NEQ "()">
						<CFREPORTPARAM name=Obj VALUE="#obj#">
					<cfelse>
						<CFREPORTPARAM name=Obj VALUE="All">
					</cfif>
					<cfif isdefined("form.objective")>
						<CFREPORTPARAM name=Objective VALUE="#form.objective#">
					<cfelse>
						<CFREPORTPARAM name=Objective VALUE="All">
					</cfif>
					<CFREPORTPARAM name=Strategy VALUE="All">
					<CFREPORTPARAM name=ReportName VALUE="PP">
					<CFREPORTPARAM name=StMonth VALUE="#form.stmonth#">
					<CFREPORTPARAM name=endMonth VALUE="#form.endmonth#">
					<CFREPORTPARAM name=stYear VALUE="2007">
					<CFREPORTPARAM name=endYr VALUE="2007">
					<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">
					<CFREPORTPARAM name=Modality VALUE="#form.modality#">
					<cfif isdefined("form.modality") and #form.modality# is 1>
						<CFREPORTPARAM name=ModWrd VALUE="Cessation Center">
					<cfelseif isdefined("form.modality") and #form.modality# is 2>
						<CFREPORTPARAM name=ModWrd VALUE="ATFC">
					<cfelseif isdefined("form.modality") and #form.modality# is 3>
						<CFREPORTPARAM name=ModWrd VALUE="Reality Check">
					<cfelseif isdefined("form.modality") and #form.modality# is 5>
						<CFREPORTPARAM name=ModWrd VALUE="Colleges for Change">
					<cfelse>
						<CFREPORTPARAM name=ModWrd VALUE="All Modalities">
					</cfif>
					<CFREPORTPARAM name=Monthrange VALUE="#Monthrange#">
				</cfreport>
			<cfelseif session.fy GTE 2012>
				<cfreport template="./reports/conmon_dp_a.cfr"  format = "pdf" query="conmon">
					<CFREPORTPARAM name=Year2 VALUE=#session.fy#>
					<CFREPORTPARAM name=Area VALUE="#form.region#">
					<CFREPORTPARAM name=Modality VALUE="ALL">
					<CFREPORTPARAM name=FOCUSAREA VALUE="All">
					<CFREPORTPARAM name=Prognum VALUE="All">
					<cfif isdefined("obj") and #obj# is not '' and #obj# NEQ "()">
						<CFREPORTPARAM name=Obj VALUE="#obj#">
					<cfelse>
						<CFREPORTPARAM name=Obj VALUE="All">
					</cfif>
					<cfif isdefined("form.objective")>
						<CFREPORTPARAM name=Objective VALUE="#form.objective#">
					<cfelse>
						<CFREPORTPARAM name=Objective VALUE="All">
					</cfif>
					<CFREPORTPARAM name=Strategy VALUE="All">
					<CFREPORTPARAM name=ReportName VALUE="PP">
					<CFREPORTPARAM name=StMonth VALUE="#form.stmonth#">
					<CFREPORTPARAM name=endMonth VALUE="#form.endmonth#">
					<CFREPORTPARAM name=stYear VALUE="2007">
					<CFREPORTPARAM name=endYr VALUE="2007">
					<CFREPORTPARAM name=PartnerName VALUE="ALL">
					<CFREPORTPARAM name=Modality VALUE="#form.modality#">
					<cfif isdefined("form.modality") and #form.modality# is 1>
						<CFREPORTPARAM name=ModWrd VALUE="Cessation Center">
					<cfelseif isdefined("form.modality") and #form.modality# is 2>
						<CFREPORTPARAM name=ModWrd VALUE="ATFC">
					<cfelseif isdefined("form.modality") and #form.modality# is 3>
						<CFREPORTPARAM name=ModWrd VALUE="Reality Check">
					<cfelseif isdefined("form.modality") and #form.modality# is 5>
						<CFREPORTPARAM name=ModWrd VALUE="Colleges for Change">
					<cfelse>
						<CFREPORTPARAM name=ModWrd VALUE="All Modalities">
					</cfif>
					<CFREPORTPARAM name=Monthrange VALUE="#Monthrange#">
				</cfreport>
					<cfelseif session.fy GTE 2015>
				<cfreport template="./reports/conmoncp2015.cfr"  format = "pdf" query="conmon">
					<CFREPORTPARAM name=Year2 VALUE=#session.fy#>
					<CFREPORTPARAM name=Area VALUE="#form.region#">
					<CFREPORTPARAM name=Modality VALUE="ALL">
					<CFREPORTPARAM name=FOCUSAREA VALUE="All">
					<CFREPORTPARAM name=Prognum VALUE="All">
					<cfif isdefined("obj") and #obj# is not '' and #obj# NEQ "()">
						<CFREPORTPARAM name=Obj VALUE="#obj#">
					<cfelse>
						<CFREPORTPARAM name=Obj VALUE="All">
					</cfif>
					<cfif isdefined("form.objective")>
						<CFREPORTPARAM name=Objective VALUE="#form.objective#">
					<cfelse>
						<CFREPORTPARAM name=Objective VALUE="All">
					</cfif>
					<CFREPORTPARAM name=Strategy VALUE="All">
					<CFREPORTPARAM name=ReportName VALUE="PP">
					<CFREPORTPARAM name=StMonth VALUE="#form.stmonth#">
					<CFREPORTPARAM name=endMonth VALUE="#form.endmonth#">
					<CFREPORTPARAM name=stYear VALUE="2007">
					<CFREPORTPARAM name=endYr VALUE="2007">
					<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">
					<CFREPORTPARAM name=Modality VALUE="#form.modality#">
					<cfif isdefined("form.modality") and #form.modality# is 1>
						<CFREPORTPARAM name=ModWrd VALUE="Cessation Center">
					<cfelseif isdefined("form.modality") and #form.modality# is 2>
						<CFREPORTPARAM name=ModWrd VALUE="ATFC">
					<cfelseif isdefined("form.modality") and #form.modality# is 3>
						<CFREPORTPARAM name=ModWrd VALUE="Reality Check">
					<cfelseif isdefined("form.modality") and #form.modality# is 5>
						<CFREPORTPARAM name=ModWrd VALUE="Colleges for Change">
					<cfelse>
						<CFREPORTPARAM name=ModWrd VALUE="All Modalities">
					</cfif>
					<CFREPORTPARAM name=Monthrange VALUE="#Monthrange#">
				</cfreport>
			<cfelse>
				<cfreport template="./reports/conmontw.cfr"  format = "pdf" query="conmon">
					<CFREPORTPARAM name=Year2 VALUE=#session.fy#>
					<CFREPORTPARAM name=Area VALUE="#form.region#">
					<CFREPORTPARAM name=modality VALUE="ALL">
					<CFREPORTPARAM name=FOCUSAREA VALUE="All">
					<CFREPORTPARAM name=Prognum VALUE="All">
					<cfif isdefined("obj") and #obj# is not '' and #obj# NEQ "()">
						<CFREPORTPARAM name=Obj VALUE="#obj#">
					<cfelse>
						<CFREPORTPARAM name=Obj VALUE="All">
					</cfif>
					<cfif isdefined("form.objective")>
						<CFREPORTPARAM name=Objective VALUE="#form.objective#">
					<cfelse>
						<CFREPORTPARAM name=Objective VALUE="All">
					</cfif>
					<CFREPORTPARAM name=Strategy VALUE="All">
					<CFREPORTPARAM name=ReportName VALUE="PP">
					<CFREPORTPARAM name=StMonth VALUE="#form.stmonth#">
					<CFREPORTPARAM name=endMonth VALUE="#form.endmonth#">
					<CFREPORTPARAM name=stYear VALUE="2007">
					<CFREPORTPARAM name=endYr VALUE="2007">
					<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">
					<CFREPORTPARAM name=Modality VALUE="#form.modality#">
					<cfif isdefined("form.modality") and #form.modality# is 1>
						<CFREPORTPARAM name=ModWrd VALUE="Cessation Center">
					<cfelseif isdefined("form.modality") and #form.modality# is 2>
						<CFREPORTPARAM name=ModWrd VALUE="ATFC">
					<cfelseif isdefined("form.modality") and #form.modality# is 3>
						<CFREPORTPARAM name=ModWrd VALUE="Reality Check">
					<cfelseif isdefined("form.modality") and #form.modality# is 5>
						<CFREPORTPARAM name=ModWrd VALUE="Colleges for Change">
					<cfelse>
						<CFREPORTPARAM name=ModWrd VALUE="All Modalities">
					</cfif>
					<CFREPORTPARAM name=Monthrange VALUE="#Monthrange#">
				</cfreport>
			</cfif>
		</cfoutput>
	</cfcase>
	<cfcase value="999">
<cfset foo = createObject("component", "cfcs.ReportLog").logreport(reportid=999) />
		<cfoutput>
			<cfparam name="form.Area" default="ALL">
			<cfparam name="form.Region" default="ALL">
			<cfparam name="form.fArea" default="ALL">
			<cfparam name="form.partner" default="ALL">
				<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="conmon">
select orgname,case m.mon when 1 then 'January' when 2 then 'February' when 3 then 'March' when 4 then 'April' when 5 then 'May' when 6 then 'June' when 7 then 'July' when 8 then 'August' when 9 then 'September' when 10 then 'October' when 11 then 'November' when 12 then 'December' end as monty, initnum,initiative,advmassmail,m.userid,editor,prsspk,prssrlse,calls, NULL as legvisit,NULL as legcorr,NULL as mediarep,null as numsub, null as numpub,summary,barriers,steps, c.partnertype from monthly m inner join contact c on m.userid = c.userid inner join objectives o on m.initnum = o.id and m.year2 = o.year2 inner join months mo on m.mon = mo.mon_num and m.year2 = mo.year2 where 1=1 and m.year2=2010 and mo.rank >= '1' and mo.rank <= '10' and c.partnertype = 2 and initnum <> '6b' and stratnum = 4 and orgname <> 'test_yp' order by c.orgname, initnum
</cfquery>
			<cfif session.userid is 'ChemungYP'>
				<cfreport template="./reports/conmon4.cfr" format = "pdf" query="conmon">
					<CFREPORTPARAM name=Year2 VALUE=#session.fy#>
					<CFREPORTPARAM name=Area VALUE="#form.region#">
					<CFREPORTPARAM name=modality VALUE="ALL">
					<CFREPORTPARAM name=FOCUSAREA VALUE="All">
					<CFREPORTPARAM name=Prognum VALUE="All">
					<cfif isdefined("obj") and #obj# is not '' and #obj# NEQ "()">
						<CFREPORTPARAM name=Obj VALUE="#obj#">
					<cfelse>
						<CFREPORTPARAM name=Obj VALUE="All">
					</cfif>
					<cfif isdefined("form.objective")>
						<CFREPORTPARAM name=Objective VALUE="Retail">
					<cfelse>
						<CFREPORTPARAM name=Objective VALUE="All">
					</cfif>
					<CFREPORTPARAM name=Strategy VALUE="All">
					<CFREPORTPARAM name=ReportName VALUE="PP">
					<CFREPORTPARAM name=StMonth VALUE="#form.stmonth#">
					<CFREPORTPARAM name=endMonth VALUE="#form.endmonth#">
					<CFREPORTPARAM name=stYear VALUE="2007">
					<CFREPORTPARAM name=endYr VALUE="2007">
					<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">
					<CFREPORTPARAM name=Modality VALUE="#form.modality#">
					<CFREPORTPARAM name=ModWrd VALUE="CP & YA">
					<CFREPORTPARAM name=Monthrange VALUE="#Monthrange#">
				</cfreport>
			<cfelse>
				<cfreport template="./reports/conmon999.cfr"  format = "pdf" query="conmon">
					<CFREPORTPARAM name=Year2 VALUE=#session.fy#>
					<CFREPORTPARAM name=Area VALUE="#form.region#">
					<CFREPORTPARAM name=modality VALUE="ALL">
					<CFREPORTPARAM name=FOCUSAREA VALUE="All">
					<CFREPORTPARAM name=Prognum VALUE="All">
					<cfif isdefined("obj") and #obj# is not '' and #obj# NEQ "()">
						<CFREPORTPARAM name=Obj VALUE="#obj#">
					<cfelse>
						<CFREPORTPARAM name=Obj VALUE="All">
					</cfif>
					<cfif isdefined("form.objective")>
						<CFREPORTPARAM name=Objective VALUE="#form.objective#">
					<cfelse>
						<CFREPORTPARAM name=Objective VALUE="All">
					</cfif>
					<CFREPORTPARAM name=Strategy VALUE="All">
					<CFREPORTPARAM name=ReportName VALUE="PP">
					<CFREPORTPARAM name=StMonth VALUE="#form.stmonth#">
					<CFREPORTPARAM name=endMonth VALUE="#form.endmonth#">
					<CFREPORTPARAM name=stYear VALUE="2007">
					<CFREPORTPARAM name=endYr VALUE="2007">
					<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">
					<CFREPORTPARAM name=Modality VALUE="#form.modality#">
					<cfif isdefined("form.modality") and #form.modality# is 1>
						<CFREPORTPARAM name=ModWrd VALUE="Cessation Center">
					<cfelseif isdefined("form.modality") and #form.modality# is 2>
						<CFREPORTPARAM name=ModWrd VALUE="ATFC">
					<cfelseif isdefined("form.modality") and #form.modality# is 3>
						<CFREPORTPARAM name=ModWrd VALUE="Reality Check">
					<cfelseif isdefined("form.modality") and #form.modality# is 5>
						<CFREPORTPARAM name=ModWrd VALUE="Colleges for Change">
					<cfelse>
						<CFREPORTPARAM name=ModWrd VALUE="All Modalities">
					</cfif>
					<CFREPORTPARAM name=Monthrange VALUE="#Monthrange#">
				</cfreport>
			</cfif>
		</cfoutput>
	</cfcase>
	<cfcase value="1103">
<cfset foo = createObject("component", "cfcs.ReportLog").logreport(reportid=1103) />
		<cfoutput>
			<cfparam name="form.Area" default="ALL">
			<cfparam name="form.Region" default="ALL">
			<cfparam name="form.fArea" default="ALL">
			<cfparam name="form.partner" default="ALL">
			<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="conmon">
	select 	--distinct
	orgname,mo.mon as monty
	,case target when 0 then 'Unaffiliated youth' else name end as name,target,isnull(commed,0) as commed,isnull(mm.advoc,0) as advoc,isnull(mm.gpme,0) as gpme,isnull(mm.youth,0) as youth,
	initiative,m.initnum, mo.rank
from contact c left join monthly m on c.userid = m.userid
left join wrkplan w on m.userid = w.userid and m.initnum = w.initnum and m.year2 = w.year2
inner join monthly_commmob mm on m.userid = mm.userid AND mm.mon = m.mon AND mm.year2 = mm.year2 AND m.initnum = mm.initnum and mm.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
left join target_org t on mm.target = t.targid and mm.initnum = t.initnum and mm.year2 = t.year2
inner join objectives o on m.initnum = o.id and m.year2 = o.year2
inner join months mo on m.mon = mo.mon_num and m.year2 = mo.year2
	where
m.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> and orgname <> 'test_yp'
	<cfif isDefined("form.modality") and form.modality NEQ "ALL" and form.modality NEQ "0">
	and c.partnertype = <cfqueryparam value="#form.modality#" cfsqltype="CF_SQL_INTEGER">
	</cfif>
	<cfif isdefined("form.objective") and form.objective NEQ "ALL">
		and m.initnum in (#ListQualify(Form.objective,"'")#)
</cfif>
	<cfif isdefined("form.cm") and form.cm is not 'all'>
	and m.userid in (select userid from contact where cmanager = <cfqueryparam value="#form.cm#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">)
	</cfif>
		and mo.rank >= <cfqueryparam value="#form.stmonth#" cfsqltype="CF_SQL_INTEGER">
	and mo.rank <= <cfqueryparam value="#form.endmonth#" cfsqltype="CF_SQL_INTEGER">
and m.userid not in ('dplotner','test_cp','nsarris')
and m.userid not like 'test%'
and m.initnum in ('2d','2e','3m'<cfif session.fy GT 2014>, '4f'</cfif>)
and w.commmob = 1
order by initiative,orgname, mo.rank, name
</cfquery>





			<cfreport template="./reports/commmob.cfr"  format = "pdf" query="conmon">
				<CFREPORTPARAM name=Year2 VALUE=#session.fy#>
				<CFREPORTPARAM name=Area VALUE="#form.region#">
				<CFREPORTPARAM name=modality VALUE="ALL">
				<CFREPORTPARAM name=FOCUSAREA VALUE="All">
				<CFREPORTPARAM name=Prognum VALUE="All">
				<cfif isdefined("obj") and #obj# is not ''>
					<CFREPORTPARAM name=Obj VALUE="#obj#">
				<cfelse>
					<CFREPORTPARAM name=Obj VALUE="All">
				</cfif>
				<cfif isdefined("cm") and #cm# is not ''>
					<CFREPORTPARAM name=CM VALUE="#form.cm#">
				<cfelse>
					<CFREPORTPARAM name=CM VALUE="All">
				</cfif>
				<cfif isdefined("form.objective")>
					<CFREPORTPARAM name=Objective VALUE="#form.objective#">
				<cfelse>
					<CFREPORTPARAM name=Objective VALUE="All">
				</cfif>
				<CFREPORTPARAM name=Strategy VALUE="All">
				<CFREPORTPARAM name=ReportName VALUE="PP">
				<CFREPORTPARAM name=StMonth VALUE="#form.stmonth#">
				<CFREPORTPARAM name=endMonth VALUE="#form.endmonth#">
				<CFREPORTPARAM name=stYear VALUE="2007">
				<CFREPORTPARAM name=endYr VALUE="2007">
				<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">
				<CFREPORTPARAM name=Modality VALUE="#form.modality#">
				<cfif isdefined("form.modality") and #form.modality# is 1>
					<CFREPORTPARAM name=ModWrd VALUE="Cessation Center">
				<cfelseif isdefined("form.modality") and #form.modality# is 2>
					<CFREPORTPARAM name=ModWrd VALUE="ATFC">
				<cfelseif isdefined("form.modality") and #form.modality# is 3>
					<CFREPORTPARAM name=ModWrd VALUE="Reality Check">
				<cfelseif isdefined("form.modality") and #form.modality# is 5>
					<CFREPORTPARAM name=ModWrd VALUE="Colleges for Change">
				<cfelse>
					<CFREPORTPARAM name=ModWrd VALUE="All Modalities">
				</cfif>
				<CFREPORTPARAM name=Monthrange VALUE="#Monthrange#">
			</cfreport>
		</cfoutput>
	</cfcase>
	<cfcase value="427">
<cfset foo = createObject("component", "cfcs.ReportLog").logreport(reportid=427) />
		<cfif isdefined("form.objective") and form.objective NEQ "ALL">
			<cfset obj = ''>
			<cfset objlst = ''>
			<cfloop index="x" list="#form.objective#">
				<cfquery datasource="#Application.DataSource#"
			password="#Application.db_password#"
			username="#Application.db_username#" name="Qobj">
			select eminittxt from eminit where eminitnum = <cfqueryparam value="#x#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
			and year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
			order by eminittxt
		</cfquery>
				<cfset obj = ListAppend(obj, qobj.eminittxt, ",")>
			</cfloop>
		</cfif>
		<cfoutput>
			<cfparam name="form.Area" default="ALL">
			<cfparam name="form.Region" default="ALL">
			<cfparam name="form.fArea" default="ALL">
			<cfparam name="form.partner" default="ALL">
			<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="conmon">
select
v.modality,
v.orgname, v.grantnum, v.userid,
 --outlet, e.emid, ee.eminitnum,
v.eminittxt as initiative,
sum(case mon when 7 then 1 else 0 end) as 'July',
sum(case mon when 8 then 1 else 0 end) as 'August',
sum(case mon when 9 then 1 else 0 end) as 'September',
sum(case mon when 10 then 1 else 0 end) as 'October',
sum(case mon when 11 then 1 else 0 end) as 'November',
sum(case mon when 12 then 1 else 0 end) as 'December',
sum(case mon when 1 then 1 else 0 end) as 'January',
sum(case mon when 2 then 1 else 0 end) as 'February',
sum(case mon when 3 then 1 else 0 end) as 'March',
sum(case mon when 4 then 1 else 0 end) as 'April',
sum(case mon when 5 then 1 else 0 end) as 'May',
sum(case mon when 6 then 1 else 0 end) as 'June'
from v_granteeEMinit v
LEFT OUTER join v_emsems2 e on  V.eminitnum= E.eminitnum
and e.userid=V.userid and  e.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
where
v.partnertype !=4 and v.partnertype !=5
and v.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
<cfif isdefined("form.objective") and (form.objective EQ "ALL")>
		and 1=1
<cfelse>
		and v.eminitnum in (#ListQualify(Form.objective,"'")#)
</cfif>
    <cfif http_referer contains "reporthandler_mod2.cfm">
    and v.partnertype <> 1
	and v.eminitnum not in ('init10','init6')
	and v.partnertype in (2,3)
      <cfelseif http_referer contains "reporthandler_mod3.cfm">
	and v.eminitnum not in ('init4','init12','init13','init15','init14')
    and v.partnertype = 1
    </cfif>
	<cfif isdefined("form.cm") and form.cm is not 'all'>
	and v.userid in (select userid from contact where cmanager = <cfqueryparam value="#form.cm#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">)
	</cfif>
    	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and v.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif>
	and v.userid not like 'test%' and v.userid <> 'Jared.Meagher' and v.orgname <> 'christina.peluso' and v.orgname <> 'dpatterson' and v.orgname <> 'theresa.juster'
group by
V.orgname, V.grantnum, V.userid,
V.partnertype, V.MODALITY, V.eminittxt
order by 5, 1, 2 -- 5, 1, 4
</cfquery>
			<cfreport template="./reports/em.cfr"  format = "pdf" query="conmon">
				<CFREPORTPARAM name=Year2 VALUE=#session.fy#>
				<CFREPORTPARAM name=Area VALUE="#form.region#">
				<CFREPORTPARAM name=modality VALUE="ALL">
				<CFREPORTPARAM name=FOCUSAREA VALUE="All">
				<CFREPORTPARAM name=Prognum VALUE="All">
				<cfif isdefined("obj") and #obj# is not ''>
					<CFREPORTPARAM name=Obj VALUE="#obj#">
				<cfelse>
					<CFREPORTPARAM name=Obj VALUE="All">
				</cfif>
				<cfif isdefined("cm") and #cm# is not ''>
					<CFREPORTPARAM name=CM VALUE="#form.cm#">
				<cfelse>
					<CFREPORTPARAM name=CM VALUE="All">
				</cfif>
				<cfif isdefined("form.objective")>
					<CFREPORTPARAM name=Objective VALUE="#form.objective#">
				<cfelse>
					<CFREPORTPARAM name=Objective VALUE="All">
				</cfif>
				<CFREPORTPARAM name=Strategy VALUE="All">
				<CFREPORTPARAM name=ReportName VALUE="PP">
				<CFREPORTPARAM name=StMonth VALUE="#form.stmonth#">
				<CFREPORTPARAM name=endMonth VALUE="#form.endmonth#">
				<CFREPORTPARAM name=stYear VALUE="2007">
				<CFREPORTPARAM name=endYr VALUE="2007">
				<cfif form.partner is not 'all'>
					<CFREPORTPARAM name=PartnerName VALUE="#conmon.orgname#">
				<cfelse>
					<CFREPORTPARAM name=PartnerName VALUE="All">
				</cfif>
				<CFREPORTPARAM name=Modality VALUE="#form.modality#">
				<cfif isdefined("form.modality") and #form.modality# is 1>
					<CFREPORTPARAM name=ModWrd VALUE="Health Systems Change">
				<cfelseif isdefined("form.modality") and #form.modality# is 2>
					<CFREPORTPARAM name=ModWrd VALUE="ATFC">
				<cfelseif isdefined("form.modality") and #form.modality# is 3>
					<CFREPORTPARAM name=ModWrd VALUE="Reality Check">
				<cfelseif isdefined("form.modality") and #form.modality# is 5>
					<CFREPORTPARAM name=ModWrd VALUE="Colleges for Change">
				<cfelse>
					<CFREPORTPARAM name=ModWrd VALUE="All Modalities">
				</cfif>
				<CFREPORTPARAM name=Monthrange VALUE="#Monthrange#">
			</cfreport>
		</cfoutput>
	</cfcase>
	<cfcase value="428">
<cfset foo = createObject("component", "cfcs.ReportLog").logreport(reportid=428) />
		<!---

stuff ((select ','+	h.askwritten FROM HSC h left  join hsc_mon hm on h.id = hm.id  where  hh.id = h.id   and (h.YEAR2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> <cfif session.fy gte 2016>or h.year2 <= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"></cfif>) AND OBJ = <cfqueryparam value="#session.objnum#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> AND USERID = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">  for xml path('')), 1,1,'') as askwritten,

stuff ((select ','+	askwritten2016 FROM HSC h left  join hsc_mon hm on h.id = hm.id where  hh.id = h.id and (h.YEAR2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> <cfif session.fy gte 2016>or h.year2 <= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"></cfif>) AND OBJ = <cfqueryparam value="#session.objnum#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> AND USERID = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">  for xml path('')), 1,1,'') as askwritten2016,
stuff ((select ','+	h.askEHR FROM HSC h left  join hsc_mon hm on h.id = hm.id   where  hh.id = h.id AND (h.YEAR2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> <cfif session.fy gte 2016>or h.year2 <= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"></cfif>) AND OBJ = <cfqueryparam value="#session.objnum#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> AND USERID = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">  for xml path('')), 1,1,'') as askEHR,
stuff ((select ','+	hm.askehr FROM HSC h left  join hsc_mon hm on h.id = hm.id  and hh.id = h.id where (h.YEAR2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> <cfif session.fy gte 2016>or h.year2 <= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"></cfif>) AND OBJ = <cfqueryparam value="#session.objnum#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> AND USERID = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">  for xml path('')), 1,1,'') as askehr_mon,
stuff ((select ','+	askehr2016 FROM HSC h left  join hsc_mon hm on h.id = hm.id where  hh.id = h.id  and (h.YEAR2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> <cfif session.fy gte 2016>or h.year2 <= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"></cfif>) AND OBJ = <cfqueryparam value="#session.objnum#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> AND USERID = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">  for xml path('')), 1,1,'') as askehr2016,
stuff ((select ','+	h.askStandard FROM HSC h left  join hsc_mon hm on h.id = hm.id  where  hh.id = h.id  AND (h.YEAR2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> <cfif session.fy gte 2016>or h.year2 <= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"></cfif>) AND OBJ = <cfqueryparam value="#session.objnum#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> AND USERID = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">  for xml path('')), 1,1,'') as askStandard,
stuff ((select ','+	askstandard2016 FROM HSC h left  join hsc_mon hm on h.id = hm.id where  hh.id = h.id and (h.YEAR2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> <cfif session.fy gte 2016>or h.year2 <= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"></cfif>) AND OBJ = <cfqueryparam value="#session.objnum#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> AND USERID = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">  for xml path('')), 1,1,'') as askstandard2016,
stuff ((select ','+	hm.askwritten FROM HSC h left  join hsc_mon hm on h.id = hm.id  and hh.id = h.id where (h.YEAR2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> <cfif session.fy gte 2016>or h.year2 <= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"></cfif>) AND OBJ = <cfqueryparam value="#session.objnum#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> AND USERID = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">  for xml path('')), 1,1,'') as askwritten_mon,
stuff ((select ','+	hm.askstandard FROM HSC h left  join hsc_mon hm on h.id = hm.id  and hh.id = h.id where (h.YEAR2 =  <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> <cfif session.fy gte 2016>or h.year2 <=  <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"></cfif>) AND OBJ = <cfqueryparam value="#session.objnum#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> AND USERID = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> for xml path('')), 1,1,'') as askstandard_mon


--->
		<cfparam name="form.Area" default="ALL">
		<cfparam name="form.Region" default="ALL">
		<cfparam name="form.fArea" default="ALL">
		<cfparam name="form.partner" default="ALL">
		<cfif session.fy lt 2016>
		<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="conmon">
select distinct hh.targmhs,hh.userid,hh.obj,orgname,hh.id,targmhs,case hh.obj when '8a' then case typehc when 1 then 'CHC' when 2 then 'Primary Care Clinic' when 3 then 'Hospital Outpatient Clinic' when 4 then 'Other health center - part of Disparities Project' end when '8b' then case typehc when 1 then 'Hospital Outpatient Mental Health Clinic' when 2 then 'Mental Health Service Organization' when 3 then 'Behavioral Health Service Organization' end end as typehc,hh.askwritten,hh.askehr,hh.askstandard,
stuff ((select ','+	h.askwritten FROM HSC h left  join hsc_mon hm on h.id = hm.id  where  hh.id = h.id   and (h.YEAR2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> or h.year2 <=  <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">) <cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>AND OBJ  in (#ListQualify(Form.objective,"'")#)</cfif> <cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif> for xml path('')), 1,1,'') as askwritten,
stuff ((select ','+	askwritten2016 FROM HSC h left  join hsc_mon hm on h.id = hm.id where  hh.id = h.id and (h.YEAR2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> or h.year2 <=  <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">) <cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>AND OBJ  in (#ListQualify(Form.objective,"'")#)</cfif> <cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif> for xml path('')), 1,1,'') as askwritten2016,
stuff ((select ','+	h.askEHR FROM HSC h left  join hsc_mon hm on h.id = hm.id   where  hh.id = h.id AND (h.YEAR2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> or h.year2 <=  <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">) <cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>AND OBJ  in (#ListQualify(Form.objective,"'")#)</cfif> <cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif> for xml path('')), 1,1,'') as askEHR,
stuff ((select ','+	hm.askehr FROM HSC h left  join hsc_mon hm on h.id = hm.id  and hh.id = h.id where (h.YEAR2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> or h.year2 <=  <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">) <cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>AND OBJ  in (#ListQualify(Form.objective,"'")#)</cfif> <cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif> for xml path('')), 1,1,'') as askehr_mon,
stuff ((select ','+	askehr2016 FROM HSC h left  join hsc_mon hm on h.id = hm.id where  hh.id = h.id  and (h.YEAR2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> or h.year2 <=  <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">) <cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>AND OBJ  in (#ListQualify(Form.objective,"'")#)</cfif> <cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif> for xml path('')), 1,1,'') as askehr2016,
stuff ((select ','+	h.askStandard FROM HSC h left  join hsc_mon hm on h.id = hm.id  where  hh.id = h.id  AND (h.YEAR2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> or h.year2 <=  <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">) <cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>AND OBJ  in (#ListQualify(Form.objective,"'")#)</cfif> <cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif> for xml path('')), 1,1,'') as askStandard,
stuff ((select ','+	askstandard2016 FROM HSC h left  join hsc_mon hm on h.id = hm.id where  hh.id = h.id and (h.YEAR2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> or h.year2 <=  <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">) <cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>AND OBJ  in (#ListQualify(Form.objective,"'")#)</cfif> <cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif> for xml path('')), 1,1,'') as askstandard2016,
stuff ((select ','+	hm.askwritten FROM HSC h left  join hsc_mon hm on h.id = hm.id  and hh.id = h.id where (h.YEAR2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> or h.year2 <=  <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">) <cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>AND OBJ  in (#ListQualify(Form.objective,"'")#)</cfif> <cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif> for xml path('')), 1,1,'') as askwritten_mon,
stuff ((select ','+	hm.askstandard FROM HSC h left  join hsc_mon hm on h.id = hm.id  and h.id = hh.id where (h.YEAR2 =  <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> or h.year2 <=  <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">) <cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>AND OBJ  in (#ListQualify(Form.objective,"'")#)</cfif> <cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif> for xml path('')), 1,1,'') as askstandard_mon

from HSC hh inner join contact c on hh.userid = c.userid left outer join hsc_mon hm on hh.id = hm.id
left outer join months mo on hm.mon = mo.mon_num and mo.year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
where
c.userid not in ('julie.wright','TEST_CC','TEST_CC2')
and c.userid not like 'test%'
<cfif isdefined("form.cm") and form.cm is not 'all'>
	and c.userid in (select userid from contact where cmanager = <cfqueryparam value="#form.cm#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">)
</cfif>
<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif>
<cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>
and hh.obj in (#ListQualify(Form.objective,"'")#)
</cfif>
order by hh.obj,orgname,hh.targmhs
	</cfquery>
		<cfoutput>

			<cfreport template="./reports/healthsysout2.cfr"  format = "pdf" query="conmon">
				<CFREPORTPARAM name=Year2 VALUE=#session.fy#>
				<CFREPORTPARAM name=Area VALUE="#form.region#">
				<CFREPORTPARAM name=modality VALUE="ALL">
				<CFREPORTPARAM name=FOCUSAREA VALUE="All">
				<CFREPORTPARAM name=Prognum VALUE="All">
				<cfif isdefined("obj") and #obj# is not ''>
					<CFREPORTPARAM name=Obj VALUE="#obj#">
				<cfelse>
					<CFREPORTPARAM name=Obj VALUE="All">
				</cfif>
				<cfif isdefined("cm") and #cm# is not ''>
					<CFREPORTPARAM name=CM VALUE="#form.cm#">
				<cfelse>
					<CFREPORTPARAM name=CM VALUE="All">
				</cfif>
				<cfif isdefined("form.objective")>
					<CFREPORTPARAM name=Objective VALUE="#form.objective#">
				<cfelse>
					<CFREPORTPARAM name=Objective VALUE="All">
				</cfif>
				<CFREPORTPARAM name=Strategy VALUE="All">
				<CFREPORTPARAM name=ReportName VALUE="PP">
				<CFREPORTPARAM name=StMonth VALUE="1">
				<CFREPORTPARAM name=endMonth VALUE="12">
				<CFREPORTPARAM name=stYear VALUE="2007">
				<CFREPORTPARAM name=endYr VALUE="2007">
				<cfif form.partner is not 'all'>
					<CFREPORTPARAM name=PartnerName VALUE="#conmon.orgname#">
				<cfelse>
					<CFREPORTPARAM name=PartnerName VALUE="All">
				</cfif>
				<CFREPORTPARAM name=Modality VALUE="#form.modality#">
				<cfif isdefined("form.modality") and #form.modality# is 1>
					<CFREPORTPARAM name=ModWrd VALUE="Cessation Center">
				<cfelseif isdefined("form.modality") and #form.modality# is 2>
					<CFREPORTPARAM name=ModWrd VALUE="ATFC">
				<cfelseif isdefined("form.modality") and #form.modality# is 3>
					<CFREPORTPARAM name=ModWrd VALUE="Reality Check">
				<cfelseif isdefined("form.modality") and #form.modality# is 5>
					<CFREPORTPARAM name=ModWrd VALUE="Colleges for Change">
				<cfelse>
					<CFREPORTPARAM name=ModWrd VALUE="All Modalities">
				</cfif>
				<CFREPORTPARAM name=Monthrange VALUE="#Monthrange#">
			</cfreport>

		</cfoutput>
		<cfelse>
		<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="conmon">
select distinct satoff,ltrim(hh.targmhs),hh.userid,hh.obj,orgname,hh.id,targmhs,case hh.obj when '8a' then case typehc when 1 then 'CHC' when 2 then 'Primary Care Clinic' when 3 then 'Hospital Outpatient Clinic' when 4 then 'Other health center - part of Disparities Project' end when '8b' then case typehc when 1 then 'Hospital Outpatient Mental Health Clinic' when 2 then 'Mental Health Service Organization' when 3 then 'Behavioral Health Service Organization' end end as typehc,hh.year2,
stuff ((select ','+	h.askwritten FROM HSC h where  hh.id = h.id   and (h.YEAR2 <= 2015) <cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>AND OBJ  in (#ListQualify(Form.objective,"'")#)</cfif>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif> for xml path('')), 1,1,'') as askwrittenb1,
	stuff ((select ','+	h.askwritten2016 FROM HSC h where  hh.id = h.id   and (h.YEAR2 <= 2016) <cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>AND OBJ  in (#ListQualify(Form.objective,"'")#)</cfif>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif> for xml path('')), 1,1,'') as askwrittenb2,
	stuff ((select ','+	h.askwritten2017 FROM HSC h where  hh.id = h.id   and (h.YEAR2 <= 2017) <cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>AND OBJ  in (#ListQualify(Form.objective,"'")#)</cfif>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif> for xml path('')), 1,1,'') as askwrittenb3,
   	stuff ((select ','+	h.askwritten2018 FROM HSC h where  hh.id = h.id   and (h.YEAR2 <= 2018) <cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>AND OBJ  in (#ListQualify(Form.objective,"'")#)</cfif>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif> for xml path('')), 1,1,'') as askwrittenb4,
    stuff ((select ','+	h.askwritten2019 FROM HSC h where  hh.id = h.id   and (h.YEAR2 <= 2019) <cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>AND OBJ  in (#ListQualify(Form.objective,"'")#)</cfif>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif> for xml path('')), 1,1,'') as askwrittenb5,
	stuff ((select ','+	hm.askwritten FROM HSC h left  join hsc_mon hm on h.id = hm.id  and hh.id = h.id where (hm.YEAR2 = 2015) <cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>AND OBJ  in (#ListQualify(Form.objective,"'")#)</cfif>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif> for xml path('')), 1,1,'') as askwrittenm1,
	stuff ((select ','+	hm.askwritten FROM HSC h left  join hsc_mon hm on h.id = hm.id  and hh.id = h.id where (hm.YEAR2 = 2016) <cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>AND OBJ  in (#ListQualify(Form.objective,"'")#)</cfif>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif> for xml path('')), 1,1,'') as askwrittenm2,
	stuff ((select ','+	hm.askwritten FROM HSC h left  join hsc_mon hm on h.id = hm.id  and hh.id = h.id where (hm.YEAR2 = 2017) <cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>AND OBJ  in (#ListQualify(Form.objective,"'")#)</cfif>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif> for xml path('')), 1,1,'') as askwrittenm3,
    stuff ((select ','+	hm.askwritten FROM HSC h left  join hsc_mon hm on h.id = hm.id  and hh.id = h.id where (hm.YEAR2 = 2018) <cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>AND OBJ  in (#ListQualify(Form.objective,"'")#)</cfif>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif> for xml path('')), 1,1,'') as askwrittenm4,
    stuff ((select ','+	hm.askwritten FROM HSC h left  join hsc_mon hm on h.id = hm.id  and hh.id = h.id where (hm.YEAR2 = 2019) <cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>AND OBJ  in (#ListQualify(Form.objective,"'")#)</cfif>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif> for xml path('')), 1,1,'') as askwrittenm5,
	stuff ((select ','+	h.askehr FROM HSC h where  hh.id = h.id   and (h.YEAR2 <= 2015) <cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>AND OBJ  in (#ListQualify(Form.objective,"'")#)</cfif>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif> for xml path('')), 1,1,'') as askehrb1,
	stuff ((select ','+	h.askehr2016 FROM HSC h where  hh.id = h.id   and (h.YEAR2 <= 2016) <cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>AND OBJ  in (#ListQualify(Form.objective,"'")#)</cfif>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif> for xml path('')), 1,1,'') as askehrb2,
	stuff ((select ','+	h.askehr2017 FROM HSC h where  hh.id = h.id   and (h.YEAR2 <= 2017) <cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>AND OBJ  in (#ListQualify(Form.objective,"'")#)</cfif>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif> for xml path('')), 1,1,'') as askehrb3,
    stuff ((select ','+	h.askehr2018 FROM HSC h where  hh.id = h.id   and (h.YEAR2 <= 2018) <cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>AND OBJ  in (#ListQualify(Form.objective,"'")#)</cfif>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif> for xml path('')), 1,1,'') as askehrb4,
    stuff ((select ','+	h.askehr2019 FROM HSC h where  hh.id = h.id   and (h.YEAR2 <= 2019) <cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>AND OBJ  in (#ListQualify(Form.objective,"'")#)</cfif>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif> for xml path('')), 1,1,'') as askehrb5,
	stuff ((select ','+	hm.askehr FROM HSC h left  join hsc_mon hm on h.id = hm.id  and hh.id = h.id where (hm.YEAR2 = 2015) <cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>AND OBJ  in (#ListQualify(Form.objective,"'")#)</cfif>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif> for xml path('')), 1,1,'') as askehrm1,
	stuff ((select ','+	hm.askehr FROM HSC h left  join hsc_mon hm on h.id = hm.id  and hh.id = h.id where (hm.YEAR2 = 2016) <cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>AND OBJ  in (#ListQualify(Form.objective,"'")#)</cfif> <cfif isdefined("form.partner") and form.partner is not 'all'>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif>
    </cfif> for xml path('')), 1,1,'') as askehrm2,
	stuff ((select ','+	hm.askehr FROM HSC h left  join hsc_mon hm on h.id = hm.id  and hh.id = h.id where (hm.YEAR2 = 2017) <cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>AND OBJ  in (#ListQualify(Form.objective,"'")#)</cfif> <cfif isdefined("form.partner") and form.partner is not 'all'>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif>
    </cfif> for xml path('')), 1,1,'') as askehrm3,
    stuff ((select ','+	hm.askehr FROM HSC h left  join hsc_mon hm on h.id = hm.id  and hh.id = h.id where (hm.YEAR2 = 2018) <cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>AND OBJ  in (#ListQualify(Form.objective,"'")#)</cfif> <cfif isdefined("form.partner") and form.partner is not 'all'>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif>
    </cfif> for xml path('')), 1,1,'') as askehrm4,
    stuff ((select ','+	hm.askehr FROM HSC h left  join hsc_mon hm on h.id = hm.id  and hh.id = h.id where (hm.YEAR2 = 2019) <cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>AND OBJ  in (#ListQualify(Form.objective,"'")#)</cfif> <cfif isdefined("form.partner") and form.partner is not 'all'>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif>
    </cfif> for xml path('')), 1,1,'') as askehrm5,
	stuff ((select ','+	h.askStandard FROM HSC h where  hh.id = h.id   and (h.YEAR2 <= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">) <cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>AND OBJ  in (#ListQualify(Form.objective,"'")#)</cfif> <cfif isdefined("form.partner") and form.partner is not 'all'>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif>
    </cfif> for xml path('')), 1,1,'') as askStandardb1,
	stuff ((select ','+	h.askStandard2016 FROM HSC h where  hh.id = h.id   and (h.YEAR2 <= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">) <cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>AND OBJ  in (#ListQualify(Form.objective,"'")#)</cfif> <cfif isdefined("form.partner") and form.partner is not 'all'>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif>
    </cfif> for xml path('')), 1,1,'') as askStandardb2,
	stuff ((select ','+	h.askStandard2017 FROM HSC h where  hh.id = h.id   and (h.YEAR2 <= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">) <cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>AND OBJ  in (#ListQualify(Form.objective,"'")#)</cfif> <cfif isdefined("form.partner") and form.partner is not 'all'>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif>
    </cfif> for xml path('')), 1,1,'') as askStandardb3,
    stuff ((select ','+	h.askStandard2018 FROM HSC h where  hh.id = h.id   and (h.YEAR2 <= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">) <cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>AND OBJ  in (#ListQualify(Form.objective,"'")#)</cfif> <cfif isdefined("form.partner") and form.partner is not 'all'>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif>
    </cfif> for xml path('')), 1,1,'') as askStandardb4,
    stuff ((select ','+	h.askStandard2019 FROM HSC h where  hh.id = h.id   and (h.YEAR2 <= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">) <cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>AND OBJ  in (#ListQualify(Form.objective,"'")#)</cfif> <cfif isdefined("form.partner") and form.partner is not 'all'>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif>
    </cfif> for xml path('')), 1,1,'') as askStandardb5,
	stuff ((select ','+	hm.askStandard FROM HSC h left  join hsc_mon hm on h.id = hm.id  and hh.id = h.id where (hm.YEAR2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">-4) <cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>AND OBJ  in (#ListQualify(Form.objective,"'")#)</cfif> <cfif isdefined("form.partner") and form.partner is not 'all'>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif>
    </cfif> for xml path('')), 1,1,'') as askStandardm1,
	stuff ((select ','+	hm.askStandard FROM HSC h left  join hsc_mon hm on h.id = hm.id  and hh.id = h.id where (hm.YEAR2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">-3) <cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>AND OBJ  in (#ListQualify(Form.objective,"'")#)</cfif> <cfif isdefined("form.partner") and form.partner is not 'all'>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif>
    </cfif> for xml path('')), 1,1,'') as askStandardm2,
	stuff ((select ','+	hm.askStandard FROM HSC h left  join hsc_mon hm on h.id = hm.id  and hh.id = h.id where (hm.YEAR2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">-2) <cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>AND OBJ  in (#ListQualify(Form.objective,"'")#)</cfif> <cfif isdefined("form.partner") and form.partner is not 'all'>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif>
    </cfif> for xml path('')), 1,1,'') as askStandardm3,
    	stuff ((select ','+	hm.askStandard FROM HSC h left  join hsc_mon hm on h.id = hm.id  and hh.id = h.id where (hm.YEAR2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">-1) <cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>AND OBJ  in (#ListQualify(Form.objective,"'")#)</cfif> <cfif isdefined("form.partner") and form.partner is not 'all'>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif>
    </cfif> for xml path('')), 1,1,'') as askStandardm4,
    	stuff ((select ','+	hm.askStandard FROM HSC h left  join hsc_mon hm on h.id = hm.id  and hh.id = h.id where (hm.YEAR2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">) <cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>AND OBJ  in (#ListQualify(Form.objective,"'")#)</cfif> <cfif isdefined("form.partner") and form.partner is not 'all'>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif>
    </cfif> for xml path('')), 1,1,'') as askStandardm5
from HSC hh inner join contact c on hh.userid = c.userid left outer join hsc_mon hm on hh.id = hm.id
left outer join months mo on hm.mon = mo.mon_num and mo.year2 <= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
where 1 = 1
and c.userid not in ('julie.wright','TEST_CC','TEST_CC2')
and c.userid not like 'test%'
<cfif isdefined("form.cm") and form.cm is not 'all'>
	and c.userid in (select userid from contact where cmanager = <cfqueryparam value="#form.cm#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">)
</cfif>
<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif>
<cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>
and hh.obj in (#ListQualify(Form.objective,"'")#)
</cfif>
order by hh.obj,orgname,ltrim(hh.targmhs)

	</cfquery>
		<cfoutput>

			<cfreport template="./reports/healthsysout23tw.cfr"  format = "pdf" query="conmon">
				<CFREPORTPARAM name=Year2 VALUE=#session.fy#>
				<CFREPORTPARAM name=Area VALUE="#form.region#">
				<CFREPORTPARAM name=modality VALUE="ALL">
				<CFREPORTPARAM name=FOCUSAREA VALUE="All">
				<CFREPORTPARAM name=Prognum VALUE="All">
				<cfif isdefined("obj") and #obj# is not ''>
					<CFREPORTPARAM name=Obj VALUE="#obj#">
				<cfelse>
					<CFREPORTPARAM name=Obj VALUE="All">
				</cfif>
				<cfif isdefined("cm") and #cm# is not ''>
					<CFREPORTPARAM name=CM VALUE="#form.cm#">
				<cfelse>
					<CFREPORTPARAM name=CM VALUE="All">
				</cfif>
				<cfif isdefined("form.objective")>
					<CFREPORTPARAM name=Objective VALUE="#form.objective#">
				<cfelse>
					<CFREPORTPARAM name=Objective VALUE="All">
				</cfif>
				<CFREPORTPARAM name=Strategy VALUE="All">
				<CFREPORTPARAM name=ReportName VALUE="PP">
				<CFREPORTPARAM name=StMonth VALUE="1">
				<CFREPORTPARAM name=endMonth VALUE="12">
				<CFREPORTPARAM name=stYear VALUE="2007">
				<CFREPORTPARAM name=endYr VALUE="2007">
				<cfif form.partner is not 'all'>
					<CFREPORTPARAM name=PartnerName VALUE="#conmon.orgname#">
				<cfelse>
					<CFREPORTPARAM name=PartnerName VALUE="All">
				</cfif>
				<CFREPORTPARAM name=Modality VALUE="#form.modality#">
				<cfif isdefined("form.modality") and #form.modality# is 1>
					<CFREPORTPARAM name=ModWrd VALUE="Cessation Center">
				<cfelseif isdefined("form.modality") and #form.modality# is 2>
					<CFREPORTPARAM name=ModWrd VALUE="ATFC">
				<cfelseif isdefined("form.modality") and #form.modality# is 3>
					<CFREPORTPARAM name=ModWrd VALUE="Reality Check">
				<cfelseif isdefined("form.modality") and #form.modality# is 5>
					<CFREPORTPARAM name=ModWrd VALUE="Colleges for Change">
				<cfelse>
					<CFREPORTPARAM name=ModWrd VALUE="All Modalities">
				</cfif>
				<CFREPORTPARAM name=Monthrange VALUE="#Monthrange#">
			</cfreport>

		</cfoutput>
		</cfif>
	</cfcase>
	<cfcase value="429">
		<cfset foo = createObject("component", "cfcs.ReportLog").logreport(reportid=429) />
		<cfparam name="form.Area" default="ALL">
		<cfparam name="form.Region" default="ALL">
		<cfparam name="form.fArea" default="ALL">
		<cfparam name="form.partner" default="ALL">
		<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="conmon">
select distinct satoff,ltrim(hh.targmhs),hh.userid,hh.obj,orgname,hh.id,targmhs,case hh.obj when '8a' then case typehc when 1 then 'CHC' when 2 then 'Primary Care Clinic' when 3 then 'Hospital Outpatient Clinic' when 4 then 'Other health center - part of Disparities Project' end when '8b' then case typehc when 1 then 'Hospital Outpatient Mental Health Clinic' when 2 then 'Mental Health Service Organization' when 3 then 'Behavioral Health Service Organization' end end as typehc,hh.year2,
stuff ((select ','+	h.askwritten FROM HSC h where  hh.id = h.id   and (h.YEAR2 <= 2015) <cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>AND OBJ  in (#ListQualify(Form.objective,"'")#)</cfif>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif> for xml path('')), 1,1,'') as askwrittenb1,
	stuff ((select ','+	h.askwritten2016 FROM HSC h where  hh.id = h.id   and (h.YEAR2 <= 2016) <cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>AND OBJ  in (#ListQualify(Form.objective,"'")#)</cfif>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif> for xml path('')), 1,1,'') as askwrittenb2,
	stuff ((select ','+	h.askwritten2017 FROM HSC h where  hh.id = h.id   and (h.YEAR2 <= 2017) <cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>AND OBJ  in (#ListQualify(Form.objective,"'")#)</cfif>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif> for xml path('')), 1,1,'') as askwrittenb3,
   	stuff ((select ','+	h.askwritten2018 FROM HSC h where  hh.id = h.id   and (h.YEAR2 <= 2018) <cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>AND OBJ  in (#ListQualify(Form.objective,"'")#)</cfif>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif> for xml path('')), 1,1,'') as askwrittenb4,
    stuff ((select ','+	h.askwritten2019 FROM HSC h where  hh.id = h.id   and (h.YEAR2 <= 2019) <cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>AND OBJ  in (#ListQualify(Form.objective,"'")#)</cfif>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif> for xml path('')), 1,1,'') as askwrittenb5,
	stuff ((select ','+	hm.askwritten FROM HSC h left  join hsc_mon hm on h.id = hm.id  and hh.id = h.id where (hm.YEAR2 = 2015) <cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>AND OBJ  in (#ListQualify(Form.objective,"'")#)</cfif>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif> for xml path('')), 1,1,'') as askwrittenm1,
	stuff ((select ','+	hm.askwritten FROM HSC h left  join hsc_mon hm on h.id = hm.id  and hh.id = h.id where (hm.YEAR2 = 2016) <cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>AND OBJ  in (#ListQualify(Form.objective,"'")#)</cfif>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif> for xml path('')), 1,1,'') as askwrittenm2,
	stuff ((select ','+	hm.askwritten FROM HSC h left  join hsc_mon hm on h.id = hm.id  and hh.id = h.id where (hm.YEAR2 = 2017) <cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>AND OBJ  in (#ListQualify(Form.objective,"'")#)</cfif>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif> for xml path('')), 1,1,'') as askwrittenm3,
    stuff ((select ','+	hm.askwritten FROM HSC h left  join hsc_mon hm on h.id = hm.id  and hh.id = h.id where (hm.YEAR2 = 2018) <cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>AND OBJ  in (#ListQualify(Form.objective,"'")#)</cfif>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif> for xml path('')), 1,1,'') as askwrittenm4,
    stuff ((select ','+	hm.askwritten FROM HSC h left  join hsc_mon hm on h.id = hm.id  and hh.id = h.id where (hm.YEAR2 = 2019) <cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>AND OBJ  in (#ListQualify(Form.objective,"'")#)</cfif>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif> for xml path('')), 1,1,'') as askwrittenm5,
	stuff ((select ','+	h.askehr FROM HSC h where  hh.id = h.id   and (h.YEAR2 <= 2015) <cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>AND OBJ  in (#ListQualify(Form.objective,"'")#)</cfif>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif> for xml path('')), 1,1,'') as askehrb1,
	stuff ((select ','+	h.askehr2016 FROM HSC h where  hh.id = h.id   and (h.YEAR2 <= 2016) <cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>AND OBJ  in (#ListQualify(Form.objective,"'")#)</cfif>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif> for xml path('')), 1,1,'') as askehrb2,
	stuff ((select ','+	h.askehr2017 FROM HSC h where  hh.id = h.id   and (h.YEAR2 <= 2017) <cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>AND OBJ  in (#ListQualify(Form.objective,"'")#)</cfif>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif> for xml path('')), 1,1,'') as askehrb3,
    stuff ((select ','+	h.askehr2018 FROM HSC h where  hh.id = h.id   and (h.YEAR2 <= 2018) <cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>AND OBJ  in (#ListQualify(Form.objective,"'")#)</cfif>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif> for xml path('')), 1,1,'') as askehrb4,
    stuff ((select ','+	h.askehr2019 FROM HSC h where  hh.id = h.id   and (h.YEAR2 <= 2019) <cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>AND OBJ  in (#ListQualify(Form.objective,"'")#)</cfif>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif> for xml path('')), 1,1,'') as askehrb5,
	stuff ((select ','+	hm.askehr FROM HSC h left  join hsc_mon hm on h.id = hm.id  and hh.id = h.id where (hm.YEAR2 = 2015) <cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>AND OBJ  in (#ListQualify(Form.objective,"'")#)</cfif>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif> for xml path('')), 1,1,'') as askehrm1,
	stuff ((select ','+	hm.askehr FROM HSC h left  join hsc_mon hm on h.id = hm.id  and hh.id = h.id where (hm.YEAR2 = 2016) <cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>AND OBJ  in (#ListQualify(Form.objective,"'")#)</cfif> <cfif isdefined("form.partner") and form.partner is not 'all'>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif>
    </cfif> for xml path('')), 1,1,'') as askehrm2,
	stuff ((select ','+	hm.askehr FROM HSC h left  join hsc_mon hm on h.id = hm.id  and hh.id = h.id where (hm.YEAR2 = 2017) <cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>AND OBJ  in (#ListQualify(Form.objective,"'")#)</cfif> <cfif isdefined("form.partner") and form.partner is not 'all'>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif>
    </cfif> for xml path('')), 1,1,'') as askehrm3,
    stuff ((select ','+	hm.askehr FROM HSC h left  join hsc_mon hm on h.id = hm.id  and hh.id = h.id where (hm.YEAR2 = 2018) <cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>AND OBJ  in (#ListQualify(Form.objective,"'")#)</cfif> <cfif isdefined("form.partner") and form.partner is not 'all'>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif>
    </cfif> for xml path('')), 1,1,'') as askehrm4,
    stuff ((select ','+	hm.askehr FROM HSC h left  join hsc_mon hm on h.id = hm.id  and hh.id = h.id where (hm.YEAR2 = 2019) <cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>AND OBJ  in (#ListQualify(Form.objective,"'")#)</cfif> <cfif isdefined("form.partner") and form.partner is not 'all'>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif>
    </cfif> for xml path('')), 1,1,'') as askehrm5,
	stuff ((select ','+	h.askStandard FROM HSC h where  hh.id = h.id   and (h.YEAR2 <= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">) <cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>AND OBJ  in (#ListQualify(Form.objective,"'")#)</cfif> <cfif isdefined("form.partner") and form.partner is not 'all'>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif>
    </cfif> for xml path('')), 1,1,'') as askStandardb1,
	stuff ((select ','+	h.askStandard2016 FROM HSC h where  hh.id = h.id   and (h.YEAR2 <= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">) <cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>AND OBJ  in (#ListQualify(Form.objective,"'")#)</cfif> <cfif isdefined("form.partner") and form.partner is not 'all'>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif>
    </cfif> for xml path('')), 1,1,'') as askStandardb2,
	stuff ((select ','+	h.askStandard2017 FROM HSC h where  hh.id = h.id   and (h.YEAR2 <= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">) <cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>AND OBJ  in (#ListQualify(Form.objective,"'")#)</cfif> <cfif isdefined("form.partner") and form.partner is not 'all'>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif>
    </cfif> for xml path('')), 1,1,'') as askStandardb3,
    stuff ((select ','+	h.askStandard2018 FROM HSC h where  hh.id = h.id   and (h.YEAR2 <= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">) <cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>AND OBJ  in (#ListQualify(Form.objective,"'")#)</cfif> <cfif isdefined("form.partner") and form.partner is not 'all'>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif>
    </cfif> for xml path('')), 1,1,'') as askStandardb4,
    stuff ((select ','+	h.askStandard2019 FROM HSC h where  hh.id = h.id   and (h.YEAR2 <= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">) <cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>AND OBJ  in (#ListQualify(Form.objective,"'")#)</cfif> <cfif isdefined("form.partner") and form.partner is not 'all'>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif>
    </cfif> for xml path('')), 1,1,'') as askStandardb5,
	stuff ((select ','+	hm.askStandard FROM HSC h left  join hsc_mon hm on h.id = hm.id  and hh.id = h.id where (hm.YEAR2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">-4) <cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>AND OBJ  in (#ListQualify(Form.objective,"'")#)</cfif> <cfif isdefined("form.partner") and form.partner is not 'all'>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif>
    </cfif> for xml path('')), 1,1,'') as askStandardm1,
	stuff ((select ','+	hm.askStandard FROM HSC h left  join hsc_mon hm on h.id = hm.id  and hh.id = h.id where (hm.YEAR2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">-3) <cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>AND OBJ  in (#ListQualify(Form.objective,"'")#)</cfif> <cfif isdefined("form.partner") and form.partner is not 'all'>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif>
    </cfif> for xml path('')), 1,1,'') as askStandardm2,
	stuff ((select ','+	hm.askStandard FROM HSC h left  join hsc_mon hm on h.id = hm.id  and hh.id = h.id where (hm.YEAR2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">-2) <cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>AND OBJ  in (#ListQualify(Form.objective,"'")#)</cfif> <cfif isdefined("form.partner") and form.partner is not 'all'>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif>
    </cfif> for xml path('')), 1,1,'') as askStandardm3,
    	stuff ((select ','+	hm.askStandard FROM HSC h left  join hsc_mon hm on h.id = hm.id  and hh.id = h.id where (hm.YEAR2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">-1) <cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>AND OBJ  in (#ListQualify(Form.objective,"'")#)</cfif> <cfif isdefined("form.partner") and form.partner is not 'all'>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif>
    </cfif> for xml path('')), 1,1,'') as askStandardm4,
    	stuff ((select ','+	hm.askStandard FROM HSC h left  join hsc_mon hm on h.id = hm.id  and hh.id = h.id where (hm.YEAR2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">) <cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>AND OBJ  in (#ListQualify(Form.objective,"'")#)</cfif> <cfif isdefined("form.partner") and form.partner is not 'all'>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif>
    </cfif> for xml path('')), 1,1,'') as askStandardm5
from HSC hh inner join contact c on hh.userid = c.userid left outer join hsc_mon hm on hh.id = hm.id
left outer join months mo on hm.mon = mo.mon_num and mo.year2 <= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
where 1 = 1
and c.userid not in ('julie.wright','TEST_CC','TEST_CC2')
and c.userid not like 'test%'
<cfif isdefined("form.cm") and form.cm is not 'all'>
	and c.userid in (select userid from contact where cmanager = <cfqueryparam value="#form.cm#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">)
</cfif>
<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
    </cfif>
<cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>
and hh.obj in (#ListQualify(Form.objective,"'")#)
</cfif>
order by hh.obj,orgname,ltrim(hh.targmhs)
</cfquery>
		<cfoutput>
			<cfreport template="./reports/healthsysout23tw.cfr"  format = "pdf" query="conmon">
				<CFREPORTPARAM name=Year2 VALUE=#session.fy#>
				<CFREPORTPARAM name=Area VALUE="#form.region#">
				<CFREPORTPARAM name=modality VALUE="ALL">
				<CFREPORTPARAM name=FOCUSAREA VALUE="All">
				<CFREPORTPARAM name=Prognum VALUE="All">
				<cfif isdefined("obj") and #obj# is not ''>
					<CFREPORTPARAM name=Obj VALUE="#obj#">
				<cfelse>
					<CFREPORTPARAM name=Obj VALUE="All">
				</cfif>
				<cfif isdefined("cm") and #cm# is not ''>
					<CFREPORTPARAM name=CM VALUE="#form.cm#">
				<cfelse>
					<CFREPORTPARAM name=CM VALUE="All">
				</cfif>
				<cfif isdefined("form.objective")>
					<CFREPORTPARAM name=Objective VALUE="#form.objective#">
				<cfelse>
					<CFREPORTPARAM name=Objective VALUE="All">
				</cfif>
				<CFREPORTPARAM name=Strategy VALUE="All">
				<CFREPORTPARAM name=ReportName VALUE="PP">
				<CFREPORTPARAM name=StMonth VALUE="#form.stmonth#">
				<CFREPORTPARAM name=endMonth VALUE="#form.endmonth#">
				<CFREPORTPARAM name=stYear VALUE="2007">
				<CFREPORTPARAM name=endYr VALUE="2007">
				<cfif form.partner is not 'all'>
					<CFREPORTPARAM name=PartnerName VALUE="#conmon.orgname#">
				<cfelse>
					<CFREPORTPARAM name=PartnerName VALUE="All">
				</cfif>
				<CFREPORTPARAM name=Modality VALUE="#form.modality#">
				<cfif isdefined("form.modality") and #form.modality# is 1>
					<CFREPORTPARAM name=ModWrd VALUE="Cessation Center">
				<cfelseif isdefined("form.modality") and #form.modality# is 2>
					<CFREPORTPARAM name=ModWrd VALUE="ATFC">
				<cfelseif isdefined("form.modality") and #form.modality# is 3>
					<CFREPORTPARAM name=ModWrd VALUE="Reality Check">
				<cfelseif isdefined("form.modality") and #form.modality# is 5>
					<CFREPORTPARAM name=ModWrd VALUE="Colleges for Change">
				<cfelse>
					<CFREPORTPARAM name=ModWrd VALUE="All Modalities">
				</cfif>
				<CFREPORTPARAM name=Monthrange VALUE="#Monthrange#">
			</cfreport>
		</cfoutput>
	</cfcase>
	<cfcase value="409">
		<cfset foo = createObject("component", "cfcs.ReportLog").logreport(reportid=409) />
		<cfoutput>
			<cfparam name="form.Area" default="ALL">
			<cfparam name="form.Region" default="ALL">
			<cfparam name="form.fArea" default="ALL">
			<cfparam name="form.partner" default="ALL">
			<cfif session.userid is 'dplotnerX'>
				<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="conmon">
select distinct c.userid,orgname,grantnum,descrip as modality,mm.year2,mm.year2-1 as year,initiative,initnum
from contact c inner join modality m
on c.partnertype = m.modality
inner join monthly mm on c.userid = mm.userid
inner join objectives o on mm.initnum = o.id and mm.year2 = o.year2
where mm.year2 = #session.fy#	and c.userid not in ('dplotner','nsarris','test_cp','test_cp','test_cp2','test_yp')
and isNull(c.suppress, 0) !=1
and c.userid not like 'test%'
and o.id in ('2d','2e','4f','3m')
order by initiative,descrip,orgname
</cfquery>
			<cfreport template="./reports/initspectw.cfr"  format = "pdf" query="conmon">
				<CFREPORTPARAM name=Year2 VALUE=#session.fy#>
				<CFREPORTPARAM name=Area VALUE="#form.region#">
				<CFREPORTPARAM name=modality VALUE="ALL">
				<CFREPORTPARAM name=FOCUSAREA VALUE="All">
				<CFREPORTPARAM name=Prognum VALUE="All">
				<CFREPORTPARAM name=Objval VALUE="#obj#">
				<cfif isdefined("cm") and #cm# is not ''>
					<CFREPORTPARAM name=CM VALUE="#form.cm#">
				<cfelse>
					<CFREPORTPARAM name=CM VALUE="All">
				</cfif>
				<cfif isdefined("form.objective")>
					<CFREPORTPARAM name=Objective VALUE="#form.objective#">
				<cfelse>
					<CFREPORTPARAM name=Objective VALUE="All">
				</cfif>
				<CFREPORTPARAM name=Strategy VALUE="All">
				<CFREPORTPARAM name=ReportName VALUE="PP">
				<CFREPORTPARAM name=StMonth VALUE="#form.stmonth#">
				<CFREPORTPARAM name=endMonth VALUE="#form.endmonth#">
				<CFREPORTPARAM name=stYear VALUE="2007">
				<CFREPORTPARAM name=endYr VALUE="2007">
				<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">
				<CFREPORTPARAM name=Modality VALUE="#form.modality#">
				<cfif isdefined("form.modality") and #form.modality# is 1>
					<CFREPORTPARAM name=ModWrd VALUE="Cessation Center">
				<cfelseif isdefined("form.modality") and #form.modality# is 2>
					<CFREPORTPARAM name=ModWrd VALUE="ATFC">
				<cfelseif isdefined("form.modality") and #form.modality# is 3>
					<CFREPORTPARAM name=ModWrd VALUE="Reality Check">
				<cfelseif isdefined("form.modality") and #form.modality# is 5>
					<CFREPORTPARAM name=ModWrd VALUE="Colleges for Change">
				<cfelse>
					<CFREPORTPARAM name=ModWrd VALUE="All Modalities">
				</cfif>
				<CFREPORTPARAM name=Monthrange VALUE="#Monthrange#">
			</cfreport>
			<cfelse>
			<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="conmon">
select distinct c.userid,orgname,grantnum,descrip as modality,mm.year2,'#session.fy-1# - Session.fy' as year,initiative,initnum
from contact c inner join modality m
on c.partnertype = m.modality
inner join monthly mm on c.userid = mm.userid
inner join objectives o on mm.initnum = o.id and mm.year2 = o.year2
where mm.year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> and c.userid not in ('dplotner','nsarris','test_cp','test_yp') and o.id in ('2d','2e','4f','3m')
<cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>
and mm.initnum in (#ListQualify(Form.objective,"'")#)
</cfif>
<cfif isDefined("form.modality") and form.modality NEQ "ALL" and form.modality NEQ "0">
	and c.partnertype = <cfqueryparam value="#form.modality#" cfsqltype="CF_SQL_INTEGER">
	</cfif>
	and c.partnertype !=1 and c.partnertype !=4
	<cfif isdefined("form.cm") and form.cm is not 'all'>
	and c.userid in (select userid from contact where cmanager = <cfqueryparam value="#form.cm#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">)
</cfif>
<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
</cfif>
order by initiative,descrip,orgname
</cfquery>
			<cfreport template="./reports/initspec.cfr"  format = "pdf" query="conmon">
				<CFREPORTPARAM name=Year2 VALUE=#session.fy#>
				<CFREPORTPARAM name=Area VALUE="#form.region#">
				<CFREPORTPARAM name=modality VALUE="ALL">
				<CFREPORTPARAM name=FOCUSAREA VALUE="All">
				<CFREPORTPARAM name=Prognum VALUE="All">
				<CFREPORTPARAM name=Objval VALUE="#obj#">
				<cfif isdefined("cm") and #cm# is not ''>
					<CFREPORTPARAM name=CM VALUE="#form.cm#">
				<cfelse>
					<CFREPORTPARAM name=CM VALUE="All">
				</cfif>
				<cfif isdefined("form.objective")>
					<CFREPORTPARAM name=Objective VALUE="#form.objective#">
				<cfelse>
					<CFREPORTPARAM name=Objective VALUE="All">
				</cfif>
				<CFREPORTPARAM name=Strategy VALUE="All">
				<CFREPORTPARAM name=ReportName VALUE="PP">
				<CFREPORTPARAM name=StMonth VALUE="#form.stmonth#">
				<CFREPORTPARAM name=endMonth VALUE="#form.endmonth#">
				<CFREPORTPARAM name=stYear VALUE="2007">
				<CFREPORTPARAM name=endYr VALUE="2007">
				<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">
				<CFREPORTPARAM name=Modality VALUE="#form.modality#">
				<cfif isdefined("form.modality") and #form.modality# is 1>
					<CFREPORTPARAM name=ModWrd VALUE="Cessation Center">
				<cfelseif isdefined("form.modality") and #form.modality# is 2>
					<CFREPORTPARAM name=ModWrd VALUE="ATFC">
				<cfelseif isdefined("form.modality") and #form.modality# is 3>
					<CFREPORTPARAM name=ModWrd VALUE="Reality Check">
				<cfelseif isdefined("form.modality") and #form.modality# is 5>
					<CFREPORTPARAM name=ModWrd VALUE="Colleges for Change">
				<cfelse>
					<CFREPORTPARAM name=ModWrd VALUE="All Modalities">
				</cfif>
				<CFREPORTPARAM name=Monthrange VALUE="#Monthrange#">
			</cfreport>
			</cfif>
		</cfoutput>
	</cfcase>
	<cfcase value="2">
		<cfset foo = createObject("component", "cfcs.ReportLog").logreport(reportid=2) />
		<cfoutput>
			<cfparam name="form.Area" default="ALL">
			<cfparam name="form.Region" default="ALL">
			<cfparam name="form.fArea" default="ALL">
			<cfparam name="form.partner" default="ALL">
				<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="ccmon">
select case m.mon when 1 then 'January' when 2 then 'February' when 3 then 'March' when 4 then 'April' when 5 then 'May' when 6 then 'June' when 7 then 'July' when 8 then 'August' when 9 then 'September' when 10 then 'October' when 11 then 'November' when 12 then 'December' end as monty,
	initnum,initiative,advmassmail,m.userid,editor,prsspk,prssrlse,calls,
	NULL as legvisit,NULL as legcorr,NULL as mediarep,NULL as numsub,NULL as numpub,
	summary,barriers,steps, co.partnertype, co.orgname,mo.rank
	from monthly m
	inner join objectives o
	on m.initnum = o.id and m.year2 = o.year2 and o.modality LIKE '%1%'
	inner join months mo on m.mon = mo.mon_num and m.year2 = mo.year2
	inner join contact co on co.userid=m.userid and co.partnertype = 1
	where
	1=1
	<cfif isdefined("form.cm") and form.cm is not 'all'>
	and m.userid in (select userid from contact where cmanager = <cfqueryparam value="#form.cm#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">)
	</cfif>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
		and m.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
<cfelseif isDefined("form.Region") and form.region is not 'all'>
		and m.userid in
		(select userid from security s, area a, region r
where s.del is null
and s.area = a.num
and a.region=r.num
and a.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
and r.num=<cfqueryparam value="#form.region#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
and r.year2=a.year2 )
	</cfif>
	<cfif isdefined("form.objective") and form.objective NEQ "ALL">
		and initnum in (#ListQualify(Form.objective,"'")#)
	</cfif>
	and m.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
    and mo.rank >= <cfqueryparam value="#form.stmonth#" cfsqltype="CF_SQL_INTEGER">
	and mo.rank <= <cfqueryparam value="#form.endmonth#" cfsqltype="CF_SQL_INTEGER">
	union
select case infra.mon when 1 then 'January' when 2 then 'February' when 3 then 'March' when 4 then 'April' when 5 then 'May' when 6 then 'June' when 7 then 'July' when 8 then 'August' when 9 then 'September' when 10 then 'October' when 11 then 'November' when 12 then 'December' end as monty,
	'999' as initnum,'Infrastructure' as initiative,'' as advmassmail,infra.userid,'' as editor,'' as prsspk,'' as prssrlse,'' as calls,legvisit,legcorr,mediarep,numsub,numpub,'' as summary,'' as barriers,'' as steps,  co.partnertype, co.orgname,mo.rank
	from infra
	inner join contact co on co.userid=infra.userid and co.partnertype = 1
	inner join months mo on infra.mon = mo.mon_num and infra.year2 = mo.year2
	where
	1=1
	<cfif isdefined("form.cm") and form.cm is not 'all'>
	and infra.userid in (select userid from contact where cmanager = <cfqueryparam value="#form.cm#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">)
	</cfif>
	and infra.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
    and mo.rank >= <cfqueryparam value="#form.stmonth#" cfsqltype="CF_SQL_INTEGER">
	and mo.rank <= <cfqueryparam value="#form.endmonth#" cfsqltype="CF_SQL_INTEGER">
	<cfif isdefined("form.objective") and (form.objective EQ "ALL" or form.objective CONTAINS "inf")>
		and 1=1
<cfelse>
		and 1=2
	</cfif>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
		and infra.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
<cfelseif isDefined("form.Region") and form.region is not 'all'>
		and infra.userid in
		(select userid from security s, area a, region r
where s.del is null
and s.area = a.num
and a.region=r.num
and a.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
and r.num=<cfqueryparam value="#form.region#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
and r.year2=a.year2 )
	</cfif>
	union
select case em.mon when 1 then 'January' when 2 then 'February' when 3 then 'March' when 4 then 'April' when 5 then 'May' when 6 then 'June' when 7 then 'July' when 8 then 'August' when 9 then 'September' when 10 then 'October' when 11 then 'November' when 12 then 'December' end as monty,
	'995' as initnum,'Earned Media' as initiative,'' as advmassmail,em.userid,'' as editor,
	'' as prsspk,'' as prssrlse,'' as calls,
	'' as legvisit,'' as legcorr,'' as mediarep,'' as numsub,'' as numpub,
	'' as summary,'' as barriers,'' as steps,  co.partnertype, co.orgname,mo.rank
	from em
	inner join contact co on co.userid=em.userid and co.partnertype = 1
	inner join months mo on em.mon = mo.mon_num and em.year2 = mo.year2
	where
	1=1
	<cfif isdefined("form.cm") and form.cm is not 'all'>
	and em.userid in (select userid from contact where cmanager = <cfqueryparam value="#form.cm#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">)
	</cfif>
	and em.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
    and mo.rank >= <cfqueryparam value="#form.stmonth#" cfsqltype="CF_SQL_INTEGER">
	and mo.rank <= <cfqueryparam value="#form.endmonth#" cfsqltype="CF_SQL_INTEGER">
	<cfif isdefined("form.objective") and (form.objective EQ "ALL" or form.objective CONTAINS "em")>
		and 1=1
<cfelse>
		and 1=2
	</cfif>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
		and em.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
<cfelseif isDefined("form.Region") and form.region is not 'all'>
		and em.userid in
		(select userid from security s, area a, region r
where s.del is null
and s.area = a.num
and a.region=r.num
and a.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
and r.num=<cfqueryparam value="#form.region#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
and r.year2=a.year2 )
	</cfif>
order by co.orgname, initnum,mo.rank
</cfquery>
			<cfreport template="./reports/ccmon4.cfr" format = "pdf" query="ccmon">
				<CFREPORTPARAM name=Year2 VALUE=#session.fy#>
				<CFREPORTPARAM name=Area VALUE="#form.region#">
				<CFREPORTPARAM name=modality VALUE="ALL">
				<CFREPORTPARAM name=FOCUSAREA VALUE="All">
				<CFREPORTPARAM name=Prognum VALUE="All">
				<cfif isdefined("obj") and #obj# is not '' and #obj# NEQ "()">
					<CFREPORTPARAM name=Obj VALUE="#obj#">
				<cfelse>
					<CFREPORTPARAM name=Obj VALUE="All">
				</cfif>
				<cfif isdefined("form.objective")>
					<CFREPORTPARAM name=Objective VALUE="#form.objective#">
				<cfelse>
					<CFREPORTPARAM name=Objective VALUE="All">
				</cfif>
				<CFREPORTPARAM name=Strategy VALUE="All">
				<CFREPORTPARAM name=ReportName VALUE="PP">
				<CFREPORTPARAM name=StMonth VALUE="#form.stmonth#">
				<CFREPORTPARAM name=endMonth VALUE="#form.endmonth#">
				<CFREPORTPARAM name=stYear VALUE="2007">
				<CFREPORTPARAM name=endYr VALUE="2007">
				<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">
				<CFREPORTPARAM name=ModWrd VALUE="Health Systems Change">
				<CFREPORTPARAM name=Monthrange VALUE="#Monthrange#">
			</cfreport>
		</cfoutput>
	</cfcase>
	<cfcase value="22">
		<cfset foo = createObject("component", "cfcs.ReportLog").logreport(reportid=22) />
		<cfoutput>
			<cfparam name="form.Area" default="ALL">
			<cfparam name="form.Region" default="ALL">
			<cfparam name="form.fArea" default="ALL">
			<cfparam name="form.partner" default="ALL">
			<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="ccmon">
select case m.mon when 1 then 'January' when 2 then 'February' when 3 then 'March' when 4 then 'April' when 5 then 'May' when 6 then 'June' when 7 then 'July' when 8 then 'August' when 9 then 'September' when 10 then 'October' when 11 then 'November' when 12 then 'December' end as monty,
	initnum,initiative,advmassmail,m.userid,editor,prsspk,prssrlse,calls,
	NULL as legvisit,NULL as legcorr,NULL as mediarep,NULL as numsub,NULL as numpub,
	summary,barriers,steps, co.partnertype, co.orgname,mo.rank
	from monthly m
	inner join objectives o
	on m.initnum = o.id and m.year2 = o.year2 and o.modality LIKE '%1%'
	inner join months mo on m.mon = mo.mon_num and m.year2 = mo.year2
	inner join contact co on co.userid=m.userid and co.partnertype = 1
	where
	1=1
	<cfif isdefined("form.cm") and form.cm is not 'all'>
	and m.userid in (select userid from contact where cmanager = <cfqueryparam value="#form.cm#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">)
	</cfif>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
		and m.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
<cfelseif isDefined("form.Region") and form.region is not 'all'>
		and m.userid in
		(select userid from security s, area a, region r
where s.del is null
and s.area = a.num
and a.region=r.num
and a.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
and r.num=<cfqueryparam value="#form.region#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
and r.year2=a.year2 )
	</cfif>
	<cfif isdefined("form.objective") and form.objective NEQ "ALL">
		and initnum in (#ListQualify(Form.objective,"'")#)
	</cfif>
	and m.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
    and mo.rank >= <cfqueryparam value="#form.stmonth#" cfsqltype="CF_SQL_INTEGER">
	and mo.rank <= <cfqueryparam value="#form.endmonth#" cfsqltype="CF_SQL_INTEGER">
	union
select case infra.mon when 1 then 'January' when 2 then 'February' when 3 then 'March' when 4 then 'April' when 5 then 'May' when 6 then 'June' when 7 then 'July' when 8 then 'August' when 9 then 'September' when 10 then 'October' when 11 then 'November' when 12 then 'December' end as monty,
	'999' as initnum,'Infrastructure' as initiative,'' as advmassmail,infra.userid,'' as editor,'' as prsspk,'' as prssrlse,'' as calls,legvisit,legcorr,mediarep,numsub,numpub,'' as summary,'' as barriers,'' as steps,  co.partnertype, co.orgname,mo.rank
	from infra
	inner join contact co on co.userid=infra.userid and co.partnertype = 1
	inner join months mo on infra.mon = mo.mon_num and infra.year2 = mo.year2
	where
	1=1
	<cfif isdefined("form.cm") and form.cm is not 'all'>
	and infra.userid in (select userid from contact where cmanager = <cfqueryparam value="#form.cm#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">)
	</cfif>
	and infra.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
    and mo.rank >= <cfqueryparam value="#form.stmonth#" cfsqltype="CF_SQL_INTEGER">
	and mo.rank <= <cfqueryparam value="#form.endmonth#" cfsqltype="CF_SQL_INTEGER">
	<cfif isdefined("form.objective") and (form.objective EQ "ALL" or form.objective CONTAINS "inf")>
		and 1=1
<cfelse>
		and 1=2
	</cfif>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
		and infra.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
<cfelseif isDefined("form.Region") and form.region is not 'all'>
		and infra.userid in
		(select userid from security s, area a, region r
where s.del is null
and s.area = a.num
and a.region=r.num
and a.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
and r.num=<cfqueryparam value="#form.region#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
and r.year2=a.year2 )
	</cfif>
	union
select case em.mon when 1 then 'January' when 2 then 'February' when 3 then 'March' when 4 then 'April' when 5 then 'May' when 6 then 'June' when 7 then 'July' when 8 then 'August' when 9 then 'September' when 10 then 'October' when 11 then 'November' when 12 then 'December' end as monty,
	'995' as initnum,'Earned Media' as initiative,'' as advmassmail,em.userid,'' as editor,
	'' as prsspk,'' as prssrlse,'' as calls,
	'' as legvisit,'' as legcorr,'' as mediarep,'' as numsub,'' as numpub,
	'' as summary,'' as barriers,'' as steps,  co.partnertype, co.orgname,mo.rank
	from em
	inner join contact co on co.userid=em.userid and co.partnertype = 1
	inner join months mo on em.mon = mo.mon_num and em.year2 = mo.year2
	where
	1=1
	<cfif isdefined("form.cm") and form.cm is not 'all'>
	and em.userid in (select userid from contact where cmanager = <cfqueryparam value="#form.cm#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">)
	</cfif>
	and em.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
    and mo.rank >= <cfqueryparam value="#form.stmonth#" cfsqltype="CF_SQL_INTEGER">
	and mo.rank <= <cfqueryparam value="#form.endmonth#" cfsqltype="CF_SQL_INTEGER">
	<cfif isdefined("form.objective") and (form.objective EQ "ALL" or form.objective CONTAINS "em")>
		and 1=1
<cfelse>
		and 1=2
	</cfif>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
		and em.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
<cfelseif isDefined("form.Region") and form.region is not 'all'>
		and em.userid in
		(select userid from security s, area a, region r
where s.del is null
and s.area = a.num
and a.region=r.num
and a.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
and r.num=<cfqueryparam value="#form.region#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
and r.year2=a.year2 )
	</cfif>
order by co.orgname, initnum,mo.rank
</cfquery>
			<cfif session.userid is 'dplotnerX'>
				<cfreport template="./reports/ccmon6.cfr" format = "pdf" query="ccmon">
					<CFREPORTPARAM name=Year2 VALUE=#session.fy#>
					<CFREPORTPARAM name=Area VALUE="#form.region#">
					<CFREPORTPARAM name=modality VALUE="ALL">
					<CFREPORTPARAM name=FOCUSAREA VALUE="All">
					<CFREPORTPARAM name=Prognum VALUE="All">
					<cfif isdefined("obj") and #obj# is not '' and #obj# NEQ "()">
						<CFREPORTPARAM name=Obj VALUE="#obj#">
					<cfelse>
						<CFREPORTPARAM name=Obj VALUE="All">
					</cfif>
					<cfif isdefined("form.objective")>
						<CFREPORTPARAM name=Objective VALUE="#form.objective#">
					<cfelse>
						<CFREPORTPARAM name=Objective VALUE="All">
					</cfif>
					<CFREPORTPARAM name=Strategy VALUE="All">
					<CFREPORTPARAM name=ReportName VALUE="PP">
					<CFREPORTPARAM name=StMonth VALUE="#form.stmonth#">
					<CFREPORTPARAM name=endMonth VALUE="#form.endmonth#">
					<CFREPORTPARAM name=stYear VALUE="2007">
					<CFREPORTPARAM name=endYr VALUE="2007">
					<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">
					<CFREPORTPARAM name=ModWrd VALUE="Health Systems Change">
					<CFREPORTPARAM name=Monthrange VALUE="#Monthrange#">
				</cfreport>
			<cfelse>
				<cfreport template="./reports/ccmon5.cfr" format = "pdf" query="ccmon">
					<CFREPORTPARAM name=Year2 VALUE=#session.fy#>
					<CFREPORTPARAM name=Area VALUE="#form.region#">
					<CFREPORTPARAM name=modality VALUE="ALL">
					<CFREPORTPARAM name=FOCUSAREA VALUE="All">
					<CFREPORTPARAM name=Prognum VALUE="All">
					<cfif isdefined("obj") and #obj# is not '' and #obj# NEQ "()">
						<CFREPORTPARAM name=Obj VALUE="#obj#">
					<cfelse>
						<CFREPORTPARAM name=Obj VALUE="All">
					</cfif>
					<cfif isdefined("form.objective")>
						<CFREPORTPARAM name=Objective VALUE="#form.objective#">
					<cfelse>
						<CFREPORTPARAM name=Objective VALUE="All">
					</cfif>
					<CFREPORTPARAM name=Strategy VALUE="All">
					<CFREPORTPARAM name=ReportName VALUE="PP">
					<CFREPORTPARAM name=StMonth VALUE="#form.stmonth#">
					<CFREPORTPARAM name=endMonth VALUE="#form.endmonth#">
					<CFREPORTPARAM name=stYear VALUE="2007">
					<CFREPORTPARAM name=endYr VALUE="2007">
					<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">
					<CFREPORTPARAM name=ModWrd VALUE="Health Systems Change">
					<CFREPORTPARAM name=Monthrange VALUE="#Monthrange#">
				</cfreport>
			</cfif>
		</cfoutput>
	</cfcase>
	<cfcase value="3">
		<cfset foo = createObject("component", "cfcs.ReportLog").logreport(reportid=3) />
		<cfoutput>
			<cfparam name="form.Area" default="ALL">
			<cfparam name="form.Region" default="ALL">
			<cfparam name="form.fArea" default="ALL">
			<cfparam name="form.partner" default="ALL">
			<cfoutput>
				<cfif isdefined("form.objective") and form.objective NEQ "ALL">
					<cfset obj = ''>
					<cfset objlst = ''>
					<cfloop index="x" list="#form.objective#">
						<cfquery datasource="#Application.DataSource#"
			password="#Application.db_password#"
			username="#Application.db_username#" name="Qobj">
			select id,initiative from objectives where id = '#x#'
			and year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
			order by initiative
		</cfquery>
						<cfset obj = ListAppend(obj, qobj.initiative, ",")>
						<cfset objlst = #quotedvaluelist(qobj.id)#>
					</cfloop>
					<cfif #form.objective# contains "inf">
						<cfset obj = ListAppend(obj, 'Infrastructure', ",")>
					</cfif>
				</cfif>
			</cfoutput>
			<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="cmfb">
select
orgname,
m.mon,
case status
when 1 then
'Actively working on contract deliverables'
when 2 then
'Not actively working on contract deliverables/ Issues to be addressed (See Detailed Feedback)'
when 3 then
'Unable to determine'
end as status,
meet as feedback,
case isNull(cntrReview,0) when 1 then 'Yes' else 'No' end as fbreviewed
from CMfeedback f, contact c, months m
where c.userid=f.userid

	and c.orgname not in ('dp-22poo','test_cp','test_cp1','TEST_YP','nikie')
	and isNull(c.suppress, 0) !=1
	and c.userid not like 'test%'

and m.mon_num=f.mon and m.year2 = f.year2
<cfif isDefined("form.CM") and form.CM EQ "vxc04">
	and (f.userid in (select userid from contact where cmanager = <cfqueryparam value="#form.cm#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">) or f.userid in('tompkins-co', 'carthageareahospital',
	'CCTFP','CUE_ACAA','mvnhealthAA','ongovAA','oswegocp','TPACC2'))
<cfelseif   isdefined("form.cm") and form.cm is not 'all'>
	and f.userid in (select userid from contact where cmanager = <cfqueryparam value="#form.cm#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">)
</cfif>
<cfif isdefined("form.partner") and form.partner is not 'all' >
	and f.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
<cfelseif isDefined("form.Region") and form.region is not 'all'>
		and f.userid in
		(select userid from security s, area a, region r
where s.del is null
and s.area = a.num
and a.region=r.num
and a.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
and r.num=<cfqueryparam value="#form.region#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
and r.year2=a.year2 )
	</cfif>
	<cfif isDefined("form.modality") and form.modality NEQ "ALL" and form.modality NEQ "0">
	and c.partnertype = <cfqueryparam value="#form.modality#" cfsqltype="CF_SQL_INTEGER">
	</cfif>
	and f.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and m.rank >= <cfqueryparam value="#form.stmonth#" cfsqltype="CF_SQL_INTEGER">
	and m.rank <= <cfqueryparam value="#form.endmonth#" cfsqltype="CF_SQL_INTEGER">
order by orgname,m.rank
</cfquery>
			<cfreport template="./reports/cmfback.cfr" format = "pdf" query="cmfb">
				<CFREPORTPARAM name=Year2 VALUE=#session.fy#>
				<CFREPORTPARAM name=Area VALUE="#form.region#">
				<CFREPORTPARAM name=modality VALUE="ALL">
				<CFREPORTPARAM name=FOCUSAREA VALUE="All">
				<CFREPORTPARAM name=Prognum VALUE="All">
				<cfif isdefined("obj") and #obj# is not '' and #obj# NEQ "()">
					<CFREPORTPARAM name=Obj VALUE="#obj#">
				<cfelse>
					<CFREPORTPARAM name=Obj VALUE="All">
				</cfif>
				<cfif isdefined("form.objective")>
					<CFREPORTPARAM name=Objective VALUE="#form.objective#">
				<cfelse>
					<CFREPORTPARAM name=Objective VALUE="All">
				</cfif>
				<CFREPORTPARAM name=Strategy VALUE="All">
				<CFREPORTPARAM name=ReportName VALUE="PP">
				<CFREPORTPARAM name=StMonth VALUE="#form.stmonth#">
				<CFREPORTPARAM name=endMonth VALUE="#form.endmonth#">
				<CFREPORTPARAM name=stYear VALUE="2007">
				<CFREPORTPARAM name=endYr VALUE="2007">
				<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">
				<CFREPORTPARAM name=Modality VALUE="#form.modality#">
				<cfif isdefined("form.modality") and #form.modality# is 1>
					<CFREPORTPARAM name=ModWrd VALUE="Health Systems Change">
				<cfelseif isdefined("form.modality") and #form.modality# is 2>
					<CFREPORTPARAM name=ModWrd VALUE="ATFC">
				<cfelseif isdefined("form.modality") and #form.modality# is 3>
					<CFREPORTPARAM name=ModWrd VALUE="Reality Check">
				<cfelseif isdefined("form.modality") and #form.modality# is 5>
					<CFREPORTPARAM name=ModWrd VALUE="Colleges for Change">
				<cfelse>
					<CFREPORTPARAM name=ModWrd VALUE="All Modalities">
				</cfif>
				<CFREPORTPARAM name=Monthrange VALUE="#Monthrange#">
			</cfreport>
		</cfoutput>
	</cfcase>
	<cfcase value="4">
		<cfset foo = createObject("component", "cfcs.ReportLog").logreport(reportid=4) />
		<cfoutput>
			<cfparam name="form.Area" default="ALL">
			<cfparam name="form.Region" default="ALL">
			<cfparam name="form.fArea" default="ALL">
			<cfparam name="form.partner" default="ALL">
			<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="cmfb">
SELECT DISTINCT c.orgName, o.initiative, c.userid, m.initnum, c.partnerType AS modality, m.year2, GETDATE() AS dtt
FROM         monthly AS m LEFT OUTER JOIN
                      contact AS c ON c.userid = m.userid INNER JOIN
                      objectives AS o ON m.initnum = o.ID AND m.year2 = o.year2
	<cfif isDefined("form.modality") and form.modality NEQ "ALL">
	and c.partnertype = <cfqueryparam value="#form.modality#" cfsqltype="CF_SQL_INTEGER">
	</cfif>
	<cfif isdefined("form.cm") and form.cm is not 'all'>
	and c.userid in (select userid from contact where cmanager = <cfqueryparam value="#form.cm#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">)
</cfif>
<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
</cfif>
<cfif isdefined("form.objective") and form.objective NEQ "ALL">
		and initnum in (#ListQualify(Form.objective,"'")#)
</cfif>
	where test is null and submitdt is not null
	and m.year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
UNION
SELECT DISTINCT c.orgName, 'Infrastructure' AS initiative, c.userid, '99' AS initnum, c.partnerType AS modality, m.year2, GETDATE() AS dtt
FROM         monthly AS m LEFT OUTER JOIN
                      contact AS c ON c.userid = m.userid INNER JOIN
                      objectives AS o ON m.initnum = o.ID AND m.year2 = o.year2
<cfif isDefined("form.modality") and form.modality NEQ "ALL">
	and c.partnertype = <cfqueryparam value="#form.modality#" cfsqltype="CF_SQL_INTEGER">
</cfif>
<cfif isdefined("form.cm") and form.cm is not 'all'>
	and c.userid in (select userid from contact where cmanager = <cfqueryparam value="#form.cm#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">)
</cfif>
<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
</cfif>
<cfif isdefined("form.objective") and (form.objective EQ "ALL" or form.objective CONTAINS "inf")>
		and 1=1
<cfelse>
		and 1=2
	</cfif>
		where test is null and submitdt is not null
ORDER BY c.orgName, m.initnum
</cfquery>
			<cfset mon = #month(cmfb.dtt)#>
			<cfreport template="./reports/progout.cfr" format = "pdf" query="cmfb">
				<CFREPORTPARAM name=dtt VALUE="#cmfb.dtt#">
				<CFREPORTPARAM name=mon VALUE="#mon#">
				<CFREPORTPARAM name=Year2 VALUE=#session.fy#>
				<CFREPORTPARAM name=Area VALUE="#form.region#">
				<CFREPORTPARAM name=modality VALUE="ALL">
				<CFREPORTPARAM name=FOCUSAREA VALUE="All">
				<CFREPORTPARAM name=Prognum VALUE="All">
				<cfif isdefined("obj") and #obj# is not '' and #obj# NEQ "()">
					<CFREPORTPARAM name=Obj VALUE="#obj#">
				<cfelse>
					<CFREPORTPARAM name=Obj VALUE="All">
				</cfif>
				<cfif isdefined("form.objective")>
					<CFREPORTPARAM name=Objective VALUE="#form.objective#">
				<cfelse>
					<CFREPORTPARAM name=Objective VALUE="All">
				</cfif>
				<CFREPORTPARAM name=Strategy VALUE="All">
				<CFREPORTPARAM name=ReportName VALUE="PP">
				<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">
				<CFREPORTPARAM name=Modality VALUE="#form.modality#">
				<cfif isdefined("form.modality") and #form.modality# is 1>
					<CFREPORTPARAM name=ModWrd VALUE="Cessation Center">
				<cfelseif isdefined("form.modality") and #form.modality# is 2>
					<CFREPORTPARAM name=ModWrd VALUE="ATFC">
				<cfelseif isdefined("form.modality") and #form.modality# is 3>
					<CFREPORTPARAM name=ModWrd VALUE="Reality Check">
				<cfelseif isdefined("form.modality") and #form.modality# is 5>
					<CFREPORTPARAM name=ModWrd VALUE="Colleges for Change">
				<cfelse>
					<CFREPORTPARAM name=ModWrd VALUE="All Modalities">
				</cfif>
			</cfreport>
		</cfoutput>
	</cfcase>
	<cfcase value="5">
		<cfset foo = createObject("component", "cfcs.ReportLog").logreport(reportid=5) />
		<cfoutput>
			<cfparam name="form.Area" default="ALL">
			<cfparam name="form.Region" default="ALL">
			<cfparam name="form.fArea" default="ALL">
			<cfparam name="form.partner" default="ALL">
			<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="cmfb">
	SELECT DISTINCT c.orgName, o.initiative, c.userid, m.initnum, c.partnerType AS modality, m.year2, GETDATE() AS dtt, '' as adcomm,'' as prvtrain,'' as techass, max(m.mon) as maxmon
FROM         monthly AS m LEFT OUTER JOIN
                      contact AS c ON c.userid = m.userid INNER JOIN
                      objectives AS o ON m.initnum = o.ID AND m.year2 = o.year2
				  inner join monthly_org mo on m.userid = mo.userid and m.year2 = mo.year2
				group by c.orgName, c.userid, c.partnerType, m.year2,o.initiative,m.initnum,test,m.submitdt,mo.adcomm,mo.prvtrain,mo.techass
	having test is null and submitdt is not null and (adcomm = 1 or prvtrain = 1 or techass = 1 or prvtrain = 1) and m.initnum = '1e'
	and c.userid <> 'dplotner' and m.year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
 and orgname not in ('TEST_cc','nikie','dp-22poo')
<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
</cfif>
<cfif isdefined("form.cm") and form.cm is not 'all'>
	and c.userid in (select userid from contact where cmanager = <cfqueryparam value="#form.cm#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">)
</cfif>
	<cfif isdefined("form.objective") and form.objective NEQ "ALL">
		and m.initnum in (#ListQualify(Form.objective,"'")#)
	</cfif>
UNION
SELECT DISTINCT c.orgName, o.initiative, c.userid, m.initnum, c.partnerType AS modality, m.year2, GETDATE() AS dtt, '' as adcomm,'' as prvtrain,'' as techass, max(m.mon) as maxmon
FROM         monthly AS m LEFT OUTER JOIN
                      contact AS c ON c.userid = m.userid INNER JOIN
                      objectives AS o ON m.initnum = o.ID AND m.year2 = o.year2
				 	group by c.orgName, c.userid, c.partnerType, m.year2,o.initiative,m.initnum,test,submitdt
having test is null and submitdt is not null and m.initnum = '1a'
 and orgname not in ('TEST_cc','nikie','dp-22poo')
<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
</cfif>
<cfif isdefined("form.cm") and form.cm is not 'all'>
	and c.userid in (select userid from contact where cmanager = <cfqueryparam value="#form.cm#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">)
</cfif>
	<cfif isdefined("form.objective") and form.objective NEQ "ALL">
		and m.initnum in (#ListQualify(Form.objective,"'")#)
	</cfif>
	and m.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
<cfif form.objective eq 'ALL' OR form.objective eq 'inf'>
	union
SELECT DISTINCT c.orgName, 'Infrastructure' AS initiative, c.userid, '99' AS initnum, c.partnerType AS modality, i.year2, GETDATE() AS dtt,'' as adcomm, '' as prvtrain,'' as techass, max(i.mon) as maxmon
FROM         infra i inner join contact c on c.userid = i.userid and submitdt is not null
 and orgname not in ('TEST_cc','nikie','dp-22poo')
<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
</cfif>
<cfif isdefined("form.cm") and form.cm is not 'all'>
	and c.userid in (select userid from contact where cmanager = <cfqueryparam value="#form.cm#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">)
</cfif>
and c.userid <> 'dplotner'
and i.modality = 1
and i.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
group by c.orgName, c.userid, c.partnerType, i.year2</cfif>
<cfif form.objective eq 'ALL' OR form.objective eq 'inf'>
	union
SELECT DISTINCT c.orgName, 'Infrastructure' AS initiative, c.userid, '99' AS initnum, c.partnerType AS modality, i.year2, GETDATE() AS dtt,'' as adcomm, '' as prvtrain,'' as techass, max(i.mon) as maxmon
FROM         infra i inner join contact c on c.userid = i.userid and submitdt is not null
 and orgname not in ('TEST_cc','nikie','dp-22poo')
<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
</cfif>
<cfif isdefined("form.cm") and form.cm is not 'all'>
	and c.userid in (select userid from contact where cmanager = <cfqueryparam value="#form.cm#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">)
</cfif>
and c.userid <> 'dplotner'
and i.modality = 1
and i.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
group by c.orgName, c.userid, c.partnerType, i.year2</cfif>
<cfif form.objective eq 'ALL' OR form.objective eq 'em'>
	union
SELECT DISTINCT c.orgName, 'Earned Media' AS initiative, c.userid, '9' AS initnum, c.partnerType AS modality, i.year2, GETDATE() AS dtt,'' as adcomm, '' as prvtrain,'' as techass, max(i.mon) as maxmon
FROM         em i
inner join contact c on c.userid = i.userid
inner join ems on ems.userid = c.userid and ems.year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
 and orgname not in ('TEST_cc','nikie','dp-22poo')
<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
</cfif>
<cfif isdefined("form.cm") and form.cm is not 'all'>
	and c.userid in (select userid from contact where cmanager = <cfqueryparam value="#form.cm#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">)
</cfif>
and c.userid <> 'dplotner'
and c.partnertype = 1
and i.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
group by c.orgName, c.userid, c.partnerType, i.year2</cfif>
<cfif form.objective eq 'ALL' OR form.objective eq 'inf'>
	union
SELECT DISTINCT c.orgName, 'Infrastructure' AS initiative, c.userid, '99' AS initnum, c.partnerType AS modality, i.year2, GETDATE() AS dtt,'' as adcomm, '' as prvtrain,'' as techass, max(i.mon) as maxmon
FROM         infra i inner join contact c on c.userid = i.userid and submitdt is not null
 and orgname not in ('TEST_cc','nikie','dp-22poo')
<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
</cfif>
<cfif isdefined("form.cm") and form.cm is not 'all'>
	and c.userid in (select userid from contact where cmanager = <cfqueryparam value="#form.cm#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">)
</cfif>
and c.userid <> 'dplotner'
and i.modality = 1
and i.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
group by c.orgName, c.userid, c.partnerType, i.year2</cfif>
ORDER BY c.orgName,m.initnum
</cfquery>
			<cfif #session.fy# LTE 2010>
				<cfreport template="./reports/progout2.cfr" format = "pdf" query="cmfb">
					<cfif isdefined("cmfb.dtt")>
						<CFREPORTPARAM name=dtt VALUE="#cmfb.dtt#">
					<cfelse>
						<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="dt">
SELECT DISTINCT GETDATE() AS dtt
FROM         monthly 	</cfquery>
						<CFREPORTPARAM name=dtt VALUE="#dt.dtt#">
					</cfif>
					<CFREPORTPARAM name=Year2 VALUE=#session.fy#>
					<CFREPORTPARAM name=Area VALUE="#form.region#">
					<CFREPORTPARAM name=modality VALUE="ALL">
					<CFREPORTPARAM name=FOCUSAREA VALUE="All">
					<CFREPORTPARAM name=Prognum VALUE="All">
					<cfif isdefined("obj") and #obj# is not '' and #obj# NEQ "()">
						<CFREPORTPARAM name=Obj VALUE="#obj#">
					<cfelse>
						<CFREPORTPARAM name=Obj VALUE="All">
					</cfif>
					<cfif isdefined("form.objective")>
						<CFREPORTPARAM name=Objective VALUE="#form.objective#">
					<cfelse>
						<CFREPORTPARAM name=Objective VALUE="All">
					</cfif>
					<CFREPORTPARAM name=Strategy VALUE="All">
					<CFREPORTPARAM name=ReportName VALUE="PP">
					<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">
					<CFREPORTPARAM name=Modality VALUE="#form.modality#">
					<CFREPORTPARAM name=maxmon VALUE="#cmfb.maxmon#">
				</cfreport>
			<cfelse>
				<cfreport template="./reports/progout2taw.cfr" format = "pdf" query="cmfb">
					<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="dtDisp">
SELECT
mm.Mon + ' ' + cast(mm.dspyr as varchar) + ' - ' + m.Mon + ' ' + cast(m.dspyr as varchar) as dtstring
FROM  dbo.months m
INNER JOIN  dbo.months mm ON m.year2 = mm.year2
WHERE     (m.mon_num = DATEPART(m, GETDATE())) AND (mm.rank = 1) AND (m.year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">)
</cfquery>
					<cfif isdefined("cmfb.dtt")>
						<CFREPORTPARAM name=dtt VALUE="#cmfb.dtt#">
					<cfelse>
						<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="dt">
SELECT DISTINCT GETDATE() AS dtt
FROM         monthly 	</cfquery>
						<CFREPORTPARAM name=dtt VALUE="#dt.dtt#">
					</cfif>
					<CFREPORTPARAM name=Year2 VALUE=#session.fy#>
					<CFREPORTPARAM name=Area VALUE="#form.region#">
					<CFREPORTPARAM name=modality VALUE="ALL">
					<CFREPORTPARAM name=FOCUSAREA VALUE="All">
					<CFREPORTPARAM name=Prognum VALUE="All">
					<cfif #session.fy# EQ 2011>
						<CFREPORTPARAM name=DatesDisp VALUE="July 2010 – June 2011">
					<cfelse>
						<CFREPORTPARAM name=DatesDisp VALUE="#dtDisp.dtstring#">
					</cfif>
					<cfif isdefined("obj") and #obj# is not '' and #obj# NEQ "()">
						<CFREPORTPARAM name=Obj VALUE="#obj#">
					<cfelse>
						<CFREPORTPARAM name=Obj VALUE="All">
					</cfif>
					<cfif isdefined("form.objective")>
						<CFREPORTPARAM name=Objective VALUE="#form.objective#">
					<cfelse>
						<CFREPORTPARAM name=Objective VALUE="All">
					</cfif>
					<CFREPORTPARAM name=Strategy VALUE="All">
					<CFREPORTPARAM name=ReportName VALUE="PP">
					<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">
					<CFREPORTPARAM name=Modality VALUE="#form.modality#">
					<CFREPORTPARAM name=maxmon VALUE="#cmfb.maxmon#">
				</cfreport>
			</cfif>
		</cfoutput>
	</cfcase>
	<cfcase value="6">
		<cfset foo = createObject("component", "cfcs.ReportLog").logreport(reportid=6) />
		<cfoutput>
			<cfparam name="form.Area" default="ALL">
			<cfparam name="form.Region" default="ALL">
			<cfparam name="form.fArea" default="ALL">
			<cfparam name="form.partner" default="ALL">
			<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="ccpm">
select distinct
ltrim(c.name) as name,co.orgname,case
  when unit IS NULL then ltrim(NAME)
  else ltrim(unit) + ' ' + NAME
 end as unitname,
r.region,
sum(case isNull(m.adcomm2,0) when 1 then 1 else 0 end) as col1,sum(case isNull(cess,0) when 1 then 1 else 0 end) as col2a,
sum(case isNull(cess,0) when 2 then 1 else 0 end) as col2c,sum(case isNull(cess,0) when 1 then 1 else 0 end) as col2d,sum(case isNull(m.adcomm3,0) when 1 then 1 else 0 end) as col2b
,sum(case isNull(mm.train,0) when 1 then 1 else 0 end) as col3,
sum(case isNull(mm.techass1,0) when 1 then 1 else 0 end) as col4,
sum(case isNull(mm.techass2,0) when 1 then 1 else 0 end) as col5,
sum(case isNull(mm.techass3,0) when 1 then 1 else 0 end) as col6,
sum(case isNull(cc.idsys,0) when 1 then 1 else 0 end) as col7,
sum(case isNull(c.idsys,0) when 1 then 1 else 0 end) as col77,sum(case isNull(cc.idsys,0) when 2 then 1 else 0 end) as col8,
sum(case isNull(c.idsys2,0) when 1 then 1 else 0 end) as col88
,sum(case isNull(cc.docsys,0) when 1 then 1 else 0 end) as col9,sum(case isNull(c.docsys,0) when 1 then 1 else 0 end) as col99,sum(case isNull(cc.docsys,0) when 2 then 1 else 0 end) as col10,sum(case isNull(c.docsys2,0) when 1 then 1 else 0 end) as col100
,sum(case isNull(cc.advise_ident,0) when 1 then 1 else 0 end) as col11,sum(case isNull(c.advise_ident,0) when 1 then 1 else 0 end) as col111,sum(case isNull(cc.assess_ident,0) when 1 then 1 else 0 end) as col12,sum(case isNull(c.assess_ident,0) when 1 then 1 else 0 end) as col121
,sum(case isNull(cc.assarr_ident,0) when 1 then 1 else 0 end) as col13,sum(case isNull(c.assarr_ident,0) when 1 then 1 else 0 end) as col131,sum(case isNull(cc.writpol,0) when 1 then 1 else 0 end) as col14,sum(case isNull(c.writpol,0) when 1 then 1 else 0 end) as col141
,sum(case isNull(cc.ask,0) when 1 then 1 else 0 end) as col15,sum(case isNull(c.ask,0) when 1 then 1 else 0 end) as col151,sum(case isNull(cc.advise_writpol,0) when 1 then 1 else 0 end) as col16,sum(case isNull(c.advise_writpol,0) when 1 then 1 else 0 end) as col161
,sum(case isNull(cc.assess_writpol,0) when 1 then 1 else 0 end) as col17,sum(case isNull(c.assess_writpol,0) when 1 then 1 else 0 end) as col171,sum(case isNull(cc.assarr_writpol,0) when 1 then 1 else 0 end) as col18,sum(case isNull(c.assarr_writpol,0) when 1 then 1 else 0 end) as col181
,sum(case isNull(cc.train2,0) when 1 then 1 else 0 end) as col19,sum(case isNull(c.train,0) when 1 then 1 else 0 end) as col191,sum(case isNull(cc.staff,0) when 1 then 1 else 0 end) as col20,sum(case isNull(c.staff,0) when 1 then 1 else 0 end) as col201
,sum(case isNull(cc.fback,0) when 1 then 1 else 0 end) as col21,sum(case isNull(c.fback,0) when 1 then 1 else 0 end) as col211,sum(case isNull(cc.campus,0) when 1 then 1 else 0 end) as col22,sum(case isNull(c.campus,0) when 1 then 1 else 0 end) as col23
from
collaborators c
left outer join monthly_targethcpo m on c.seq = m.seq and m.year2 <cfif #session.fy# is '2010'>= 2010<cfelse> >= 2010 and m.year2<=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"></cfif>
left outer join monthly_targethcpo mm on mm.seq = c.seq and mm.year2  = #session.fy# and m.year2=mm.year2
left outer join monthly_cc cc on c.seq = cc.seq  and cc.year2 <cfif #session.fy# is '2010'>= 2010<cfelse> >= 2010 and cc.year2<=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"></cfif>
inner join contact co on c.userid = co.userid
inner join area a on a.num = co.area
inner join region r on a.region = r.num and a.year2 = r.year2
where  c.name is not null and len(c.name) > 0 and   (c.del is null or c.del !=1)
and c.year2 <cfif #session.fy# is '2010'>= 2010<cfelse> >= 2010 and c.year2<=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"></cfif>
<cfif form.region NEQ 'All' and form.partner EQ 'All'>
	and r.num=<cfqueryparam value="#form.region#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
</cfif>
<cfif form.CM NEQ 'All'>
	and co.cmanager = <cfqueryparam value="#form.cm#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
</cfif>
<cfif form.partner NEQ 'All'>
	and co.userid = <cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
</cfif>
group by c.name,co.orgname,r.region,c.seq,c.unit
order by
r.region,co.orgname,ltrim(name)
</cfquery>
			<cfreport template="./reports/ccpm2tw.cfr" format = "pdf" query="ccpm">
				<CFREPORTPARAM name=fa VALUE=1>
				<CFREPORTPARAM name=Year2 VALUE=#session.fy#>
				<CFREPORTPARAM name=Area VALUE="#form.region#">
				<CFREPORTPARAM name=modality VALUE="ALL">
				<CFREPORTPARAM name=FOCUSAREA VALUE="All">
				<CFREPORTPARAM name=Prognum VALUE="All">
				<cfif isdefined("obj") and #obj# is not '' and #obj# NEQ "()">
					<CFREPORTPARAM name=Obj VALUE="#obj#">
				<cfelse>
					<CFREPORTPARAM name=Obj VALUE="All">
				</cfif>
				<cfif isdefined("form.objective")>
					<CFREPORTPARAM name=Objective VALUE="#form.objective#">
				<cfelse>
					<CFREPORTPARAM name=Objective VALUE="All">
				</cfif>
				<CFREPORTPARAM name=Strategy VALUE="All">
				<CFREPORTPARAM name=ReportName VALUE="PP">
				<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">
				<CFREPORTPARAM name=Modality VALUE="#form.modality#">
			</cfreport>
		</cfoutput>
	</cfcase>
	<cfcase value="7">
		<cfoutput>
			<cfparam name="form.Area" default="ALL">
			<cfparam name="form.Region" default="ALL">
			<cfparam name="form.fArea" default="ALL">
			<cfparam name="form.partner" default="ALL">
			<cfif session.fy  GTE 2012>
				<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="pos">

select 1 as rank,
w.year2, s.initnum, c.partnertype AS modality,c.userid,
orgname, 1 AS cnt,getdate() as rundt,
cast(SUM(ISNULL(boolpassed,0))*100/1 as varchar) + '%' as  perDisp,
SUM(ISNULL(boolpassed,0)) AS bp,
SUM (ISNULL(jurNum,0)) AS jurnum
from
contact c
left outer join smartoutcomes s on c.userid = s.userid and s.year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> and s.initnum = '2d'
LEFT OUTER JOIN monthly_pos p ON c.userid = p.userid  and p.year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
left outer join months mm on p.mon = mm.mon_num and p.year2 = mm.year2 and mm.rank >= <cfqueryparam value="#form.stmonth#" cfsqltype="CF_SQL_INTEGER"> and mm.rank <= <cfqueryparam value="#form.endmonth#" cfsqltype="CF_SQL_INTEGER">
inner join wrkplan w on c.userid = w.userid and w.year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> and w.initnum = '2d'
where
 w.userid not in ('test_yp','nikie','test_cp','test_cp1')
 and orgname not like '%test%'
 and coordemail not like '%rti.org'
GROUP BY orgname,
w.year2, s.initnum, c.partnertype,c.userid
order by orgname
</cfquery>
				<cfreport template="./reports/pos_outcomes_dp.cfr" format = "pdf" query="pos">
					<CFREPORTPARAM name=fa VALUE=1>
					<CFREPORTPARAM name=StMonth VALUE="#form.stmonth#">
					<CFREPORTPARAM name=endMonth VALUE="#form.endmonth#">
					<CFREPORTPARAM name=Year2 VALUE=#session.fy#>
					<CFREPORTPARAM name=Area VALUE="#form.region#">
					<CFREPORTPARAM name=modality VALUE="ALL">
					<CFREPORTPARAM name=FOCUSAREA VALUE="All">
					<CFREPORTPARAM name=Prognum VALUE="All">
					<CFREPORTPARAM name=Strategy VALUE="All">
					<CFREPORTPARAM name=ReportName VALUE="PP">
					<CFREPORTPARAM name=Monthrange VALUE="#Monthrange#">
					<cfif isdefined("form.modality") and #form.modality# is 1>
						<CFREPORTPARAM name=ModWrd VALUE="Cessation Center">
					<cfelseif isdefined("form.modality") and #form.modality# is 2>
						<CFREPORTPARAM name=ModWrd VALUE="ATFC">
					<cfelseif isdefined("form.modality") and #form.modality# is 3>
						<CFREPORTPARAM name=ModWrd VALUE="Reality Check">
					<cfelseif isdefined("form.modality") and #form.modality# is 5>
						<CFREPORTPARAM name=ModWrd VALUE="Colleges for Change">
					<cfelse>
						<CFREPORTPARAM name=ModWrd VALUE="ALL">
					</cfif>
					<CFREPORTPARAM name=Obj VALUE="All">
					<CFREPORTPARAM name=Objective VALUE="All">
					<CFREPORTPARAM name=Initiative VALUE="All">
					<CFREPORTPARAM name=CM VALUE="ALL">
					<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">
					<CFREPORTPARAM name=Modality VALUE="#form.modality#">
				</cfreport>
			<cfelse>
				<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="pos">
select 1 as rank,orgname,isNull(sum(isnull(so1,0)),0) as tots,s.year2,c.userid,s.initnum, c.partnertype,getdate() as rundt
from contact c inner join smartoutcomes s on c.userid = s.userid
where s.initnum = '2d'
and s.year2 =  <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
and s.userid not in ('test_yp','nsarris','test_cp')
<cfif form.modality NEQ "ALL" and form.partner NEQ 'All'>
	and c.userid = <cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
<cfelseif form.modality EQ "ALL" and form.partner NEQ 'All'>
	and c.partnertype = (select partnertype from contact where userid = <cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">)
</cfif>
<cfif isDefined("form.modality") and form.modality NEQ "ALL">
	and c.partnertype = <cfqueryparam value="#form.modality#" cfsqltype="CF_SQL_INTEGER">
	<cfif #form.modality# is 3>
	  <cfelseif #form.modality# is 2>
	 and sonum in ('2b','3b')
	</cfif>
</cfif>
and ((c.partnertype=3 and sonum in ('1','2'))
	or
	(c.partnertype=2 and sonum in ('2b','3b')))
group by orgname,s.year2,c.userid,s.initnum, c.partnertype
order by orgname
</cfquery>
				<cfreport template="./reports/pos_outcomes.cfr" format = "pdf" query="pos">
					<CFREPORTPARAM name=fa VALUE=1>
					<CFREPORTPARAM name=Year2 VALUE=#session.fy#>
					<CFREPORTPARAM name=Area VALUE="#form.region#">
					<CFREPORTPARAM name=modality VALUE="ALL">
					<CFREPORTPARAM name=FOCUSAREA VALUE="All">
					<CFREPORTPARAM name=Prognum VALUE="All">
					<CFREPORTPARAM name=Strategy VALUE="All">
					<CFREPORTPARAM name=ReportName VALUE="PP">
					<CFREPORTPARAM name=Monthrange VALUE="#Monthrange#">
					<cfif isdefined("form.modality") and #form.modality# is 1>
						<CFREPORTPARAM name=ModWrd VALUE="Cessation Center">
					<cfelseif isdefined("form.modality") and #form.modality# is 2>
						<CFREPORTPARAM name=ModWrd VALUE="ATFC">
					<cfelseif isdefined("form.modality") and #form.modality# is 3>
						<CFREPORTPARAM name=ModWrd VALUE="Reality Check">
					<cfelseif isdefined("form.modality") and #form.modality# is 5>
						<CFREPORTPARAM name=ModWrd VALUE="Colleges for Change">
					<cfelse>
						<CFREPORTPARAM name=ModWrd VALUE="ALL">
					</cfif>
					<CFREPORTPARAM name=Obj VALUE="All">
					<CFREPORTPARAM name=Objective VALUE="All">
					<CFREPORTPARAM name=Initiative VALUE="All">
					<CFREPORTPARAM name=CM VALUE="ALL">
					<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">
					<CFREPORTPARAM name=Modality VALUE="#form.modality#">
				</cfreport>
			</cfif>
		</cfoutput>
	</cfcase>
	<cfcase value="666">
		<cfset foo = createObject("component", "cfcs.ReportLog").logreport(reportid=666) />
		<cfoutput>
			<cfparam name="form.Area" default="ALL">
			<cfparam name="form.Region" default="ALL">
			<cfparam name="form.fArea" default="ALL">
			<cfparam name="form.partner" default="ALL">
			<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="pos">
select 1 as rank,c.userid,w.initnum,orgname,isnull(sum(so1),2) as tots,
LEN(catchment) - LEN(REPLACE(catchment, ',', '')) + 1 AS tots2,getdate() as rundt
from contact c 
inner join wrkplan w on c.userid = w.userid and w.initnum = '2e' and w.year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> and w.initnum = '2e'
left outer join smartoutcomes s on c.userid = s.userid and s.initnum = '2e' and sonum in ('1b') 
where w.year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> and partnertype = 2  and orgname not in ('TEST_CP','nikie','dp-22poo')
and isNull(c.suppress, 0) !=1
and c.userid not like 'test%'
group by orgname,c.userid,w.initnum,catchment
order by orgname
</cfquery>
			<cfset Year2less = #session.fy#-1>
			<cfset conperiod = #year2less# & '-' & #session.fy#>
			<cfreport template="./reports/tobfreeout4.cfr" format = "pdf" query="pos">
				<CFREPORTPARAM name=fa VALUE=1>
				<CFREPORTPARAM name=StMonth VALUE="#form.stmonth#">
				<CFREPORTPARAM name=endMonth VALUE="#form.endmonth#">
				<CFREPORTPARAM name=Area VALUE="#form.region#">
				<CFREPORTPARAM name=modality VALUE="ALL">
				<CFREPORTPARAM name=FOCUSAREA VALUE="All">
				<CFREPORTPARAM name=Prognum VALUE="All">
				<CFREPORTPARAM name=Strategy VALUE="All">
				<CFREPORTPARAM name=ReportName VALUE="PP">
				<CFREPORTPARAM name=Monthrange VALUE="#Monthrange#">
				<CFREPORTPARAM name=YEAR2 VALUE=#session.fy#>
				<cfif isdefined("form.modality") and #form.modality# is 1>
					<CFREPORTPARAM name=ModWrd VALUE="Cessation Center">
				<cfelseif isdefined("form.modality") and #form.modality# is 2>
					<CFREPORTPARAM name=ModWrd VALUE="ATFC">
				<cfelseif isdefined("form.modality") and #form.modality# is 3>
					<CFREPORTPARAM name=ModWrd VALUE="Reality Check">
				<cfelseif isdefined("form.modality") and #form.modality# is 5>
					<CFREPORTPARAM name=ModWrd VALUE="Colleges for Change">
				<cfelse>
					<CFREPORTPARAM name=ModWrd VALUE="ALL">
				</cfif>
				<CFREPORTPARAM name=Obj VALUE="All">
				<CFREPORTPARAM name=Objective VALUE="All">
				<CFREPORTPARAM name=Initiative VALUE="All">
				<CFREPORTPARAM name=CM VALUE="ALL">
				<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">
				<CFREPORTPARAM name=Modality VALUE="#form.modality#">
				<CFREPORTPARAM name=lastyear VALUE=#Year2less#>
			</cfreport>
		</cfoutput>
	</cfcase>
	<cfcase value="824">
		<cfset foo = createObject("component", "cfcs.ReportLog").logreport(reportid=824) />
		<cfoutput>
			<cfparam name="form.Area" default="ALL">
			<cfparam name="form.Region" default="ALL">
			<cfparam name="form.fArea" default="ALL">
			<cfparam name="form.partner" default="ALL">
			<cfif session.fy GTE 2012>
				<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="pos">
select distinct 1 as rank,c.userid,w.initnum,orgname,isnull(sum(so1),0) as tots,getdate() as rundt,
(select isnull(sum(isnull(number,0)),0) as passed from monthly_initsum m inner join contact c on m.userid = c.userid inner join target_org t on m.seq = t.targid inner join months mo on m.mon = mo.mon_num and m.year2 = mo.year2 where partnertype = 2 and m.year2 = '#session.fy#' and m.initnum = '4f' and mo.rank >= '#form.stmonth#' and mo.rank <= '#form.endmonth#' and c.userid not in ('dplotner','test_cp','test_cp1','TEST_YP','nsarris')) as passed
from contact c inner join smartoutcomes s on c.userid = s.userid 
inner join wrkplan w on w.userid = s.userid and w.year2 = s.year2
left outer join monthly_pos6 m on c.userid=m.userid and m.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
left outer join months mm on m.mon = mm.mon_num and m.year2 = mm.year2 and mm.rank >= <cfqueryparam value="#form.stmonth#" cfsqltype="CF_SQL_INTEGER"> and mm.rank <= <cfqueryparam value="#form.endmonth#" cfsqltype="CF_SQL_INTEGER">
where
w.userid=c.userid
and w.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
and w.initnum='4f'
and isnull(c.coordemail, '-') not like '%rti.org'
<cfif isdefined("form.cm") and form.cm is not 'all'>
	and c.userid in (select userid from contact where cmanager = <cfqueryparam value="#form.cm#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">)
</cfif>
and c.orgname not in ('dp-22poo','test_cp','test_cp1','TEST_YP','nikie')
and isNull(c.suppress, 0) !=1
and c.userid not like 'test%'
group by orgname,c.userid,w.initnum
order by orgname
</cfquery>
			<cfelse>
				<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="pos">
select 1 as rank,c.userid,initnum,orgname,
isnull(sum(so1),0)*(Len(catchment)-LEN(REPLACE(catchment, ',', ''))+1
) as tots
from contact c inner join smartoutcomes s on c.userid = s.userid
where initnum = '4f' and sonum in ('2') and year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
and partnertype = 2  and orgname not in ('nikie','test_cp','test_cp1','dp-22poo')
and coordemail not like '%rti.org'
and c.userid in (select userid from monthly where year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> and initnum = '4f')
and isNull(c.suppress, 0) !=1
group by orgname,c.userid,initnum, catchment
order by ltrim(orgname)</cfquery>
			</cfif>
			<cfset Year2less = #session.fy#-1>
			<cfset conperiod = #year2less# & '-' & #session.fy#>
			<cfif session.fy GTE 2012>
				<cfreport template="./reports/mudouttw.cfr" format = "pdf" query="pos">
					<CFREPORTPARAM name=fa VALUE=1>
					<CFREPORTPARAM name=Area VALUE="#form.region#">
					<CFREPORTPARAM name=modality VALUE="ALL">
					<CFREPORTPARAM name=FOCUSAREA VALUE="All">
					<CFREPORTPARAM name=Prognum VALUE="All">
					<CFREPORTPARAM name=Strategy VALUE="All">
					<CFREPORTPARAM name=ReportName VALUE="PP">
					<CFREPORTPARAM name=Monthrange VALUE="#Monthrange#">
					<cfif isdefined("form.modality") and #form.modality# is 1>
						<CFREPORTPARAM name=ModWrd VALUE="Cessation Center">
					<cfelseif isdefined("form.modality") and #form.modality# is 2>
						<CFREPORTPARAM name=ModWrd VALUE="ATFC">
					<cfelseif isdefined("form.modality") and #form.modality# is 3>
						<CFREPORTPARAM name=ModWrd VALUE="Reality Check">
					<cfelseif isdefined("form.modality") and #form.modality# is 5>
						<CFREPORTPARAM name=ModWrd VALUE="Colleges for Change">
					<cfelse>
						<CFREPORTPARAM name=ModWrd VALUE="ALL">
					</cfif>
					<CFREPORTPARAM name=Obj VALUE="All">
					<CFREPORTPARAM name=Objective VALUE="All">
					<CFREPORTPARAM name=Initiative VALUE="All">
					<CFREPORTPARAM name=CM VALUE="ALL">
					<cfif session.fy GTE 2015>
						<CFREPORTPARAM name=StMonth VALUE="#form.stmonth#">
						<CFREPORTPARAM name=endMonth VALUE="#form.endmonth#">
					<cfelse>
						<CFREPORTPARAM name=StMonth VALUE="1">
						<CFREPORTPARAM name=endMonth VALUE="12">
					</cfif>
					<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">
					<CFREPORTPARAM name=Modality VALUE="#form.modality#">
					<CFREPORTPARAM name=lastyear VALUE=#Year2less#>
					<CFREPORTPARAM name=Year2 VALUE=#session.fy#>
				</cfreport>
			<cfelse>
				<cfreport template="./reports/mudout_pre2012.cfr" format = "pdf" query="pos">
					<CFREPORTPARAM name=fa VALUE=1>
					<CFREPORTPARAM name=Area VALUE="#form.region#">
					<CFREPORTPARAM name=modality VALUE="ALL">
					<CFREPORTPARAM name=FOCUSAREA VALUE="All">
					<CFREPORTPARAM name=Prognum VALUE="All">
					<CFREPORTPARAM name=Strategy VALUE="All">
					<CFREPORTPARAM name=ReportName VALUE="PP">
					<CFREPORTPARAM name=Monthrange VALUE="#Monthrange#">
					<cfif isdefined("form.modality") and #form.modality# is 1>
						<CFREPORTPARAM name=ModWrd VALUE="Cessation Center">
					<cfelseif isdefined("form.modality") and #form.modality# is 2>
						<CFREPORTPARAM name=ModWrd VALUE="ATFC">
					<cfelseif isdefined("form.modality") and #form.modality# is 3>
						<CFREPORTPARAM name=ModWrd VALUE="Reality Check">
					<cfelseif isdefined("form.modality") and #form.modality# is 5>
						<CFREPORTPARAM name=ModWrd VALUE="Colleges for Change">
					<cfelse>
						<CFREPORTPARAM name=ModWrd VALUE="ALL">
					</cfif>
					<CFREPORTPARAM name=Obj VALUE="All">
					<CFREPORTPARAM name=Objective VALUE="All">
					<CFREPORTPARAM name=Initiative VALUE="All">
					<CFREPORTPARAM name=CM VALUE="ALL">
					<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">
					<CFREPORTPARAM name=Modality VALUE="#form.modality#">
					<CFREPORTPARAM name=lastyear VALUE=#Year2less#>
					<CFREPORTPARAM name=Year2 VALUE=#session.fy#>
				</cfreport>
			</cfif>
		</cfoutput>
	</cfcase>
	<cfcase value="777">
		<cfset foo = createObject("component", "cfcs.ReportLog").logreport(reportid=777) />
		<cfoutput>
			<cfparam name="form.Area" default="ALL">
			<cfparam name="form.Region" default="ALL">
			<cfparam name="form.fArea" default="ALL">
			<cfparam name="form.partner" default="ALL">
			<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="pos">
select 2 as grp,1 as rank,c.userid,w.initnum,orgname,(LEN(catchment) - LEN(REPLACE(catchment, ',', '')) + 1) * 2 AS tt,
case when s.year2 > 2013 then 1 else isnull(sum(so1),0) end as tots,getdate() as rundt
from contact c 
inner join wrkplan w on c.userid = w.userid and w.year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> and w.initnum = '2e'
left outer join smartoutcomes s on c.userid = s.userid and s.initnum = '2e' and sonum in ('2b','1b') and s.year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
where
w.year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> and partnertype = 2  and orgname not in ('TEST_CP','nikie','dp-22poo')
<cfif form.CM NEQ 'All'>
	and c.cmanager = <cfqueryparam value="#form.cm#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
</cfif>
and isNull(c.suppress, 0) !=1
and c.userid not like 'test%'
group by orgname,c.userid,w.initnum, s.year2,catchment
order by orgname
</cfquery>
			<cfset Year2less = #session.fy#-1>
			<cfset conperiod = #year2less# & '-' & #session.fy#>
			<cfreport template="./reports/tobfreeout2.cfr" format = "pdf" query="pos">
				<CFREPORTPARAM name=fa VALUE=1>
				<CFREPORTPARAM name=StMonth VALUE="#form.stmonth#">
				<CFREPORTPARAM name=endMonth VALUE="#form.endmonth#">
				<CFREPORTPARAM name=Area VALUE="#form.region#">
				<CFREPORTPARAM name=modality VALUE="ALL">
				<CFREPORTPARAM name=FOCUSAREA VALUE="All">
				<CFREPORTPARAM name=Prognum VALUE="All">
				<CFREPORTPARAM name=Strategy VALUE="All">
				<CFREPORTPARAM name=ReportName VALUE="PP">
				<CFREPORTPARAM name=Monthrange VALUE="#Monthrange#">
				<cfif isdefined("form.modality") and #form.modality# is 1>
					<CFREPORTPARAM name=ModWrd VALUE="Cessation Center">
				<cfelseif isdefined("form.modality") and #form.modality# is 2>
					<CFREPORTPARAM name=ModWrd VALUE="ATFC">
				<cfelseif isdefined("form.modality") and #form.modality# is 3>
					<CFREPORTPARAM name=ModWrd VALUE="Reality Check">
				<cfelseif isdefined("form.modality") and #form.modality# is 5>
					<CFREPORTPARAM name=ModWrd VALUE="Colleges for Change">
				<cfelse>
					<CFREPORTPARAM name=ModWrd VALUE="ALL">
				</cfif>
				<CFREPORTPARAM name=Obj VALUE="All">
				<CFREPORTPARAM name=Objective VALUE="All">
				<CFREPORTPARAM name=Initiative VALUE="All">
				<CFREPORTPARAM name=CM VALUE="ALL">
				<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">
				<CFREPORTPARAM name=Modality VALUE="#form.modality#">
				<CFREPORTPARAM name=lastyear VALUE=#Year2less#>
				<CFREPORTPARAM name=Year2 VALUE=#session.fy#>
			</cfreport>
		</cfoutput>
	</cfcase>
	<cfcase value="778">

		<cfset foo = createObject("component", "cfcs.ReportLog").logreport(reportid=778) />
		<cfoutput>
			<cfparam name="form.Area" default="ALL">
			<cfparam name="form.Region" default="ALL">
			<cfparam name="form.fArea" default="ALL">
			<cfparam name="form.partner" default="ALL">
			<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="pos">
select
	orgname, count(m.monthlyid) as achieved, 1 as rank,getdate() as rundt,c.userid
	from wrkplan w,contact c
left outer join monthly_pos6 m on c.userid=m.userid and m.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
left outer join months mm on m.mon = mm.mon_num and m.year2 = mm.year2 and mm.rank >= <cfqueryparam value="#form.stmonth#" cfsqltype="CF_SQL_INTEGER"> and mm.rank <= <cfqueryparam value="#form.endmonth#" cfsqltype="CF_SQL_INTEGER">
	where
 w.userid=c.userid
and w.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
and w.initnum='3m'
and isnull(c.coordemail, '-') not like '%rti.org'
<cfif isdefined("form.cm") and form.cm is not 'all'>
	and c.userid in (select userid from contact where cmanager = <cfqueryparam value="#form.cm#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">)
</cfif>
and c.orgname not in ('dp-22poo','test_cp','test_cp1','TEST_YP','nikie')
and isNull(c.suppress, 0) !=1
and c.userid not like 'test%'
group by orgname,c.userid
order by 1,2
</cfquery>
			<cfset Year2less = #session.fy#-1>
			<cfset conperiod = #year2less# & '-' & #session.fy#>
			<cfreport template="./reports/sfreemedia.cfr" format = "pdf" query="pos">
				<CFREPORTPARAM name=fa VALUE=1>
				<CFREPORTPARAM name=StMonth VALUE="#form.stmonth#">
				<CFREPORTPARAM name=endMonth VALUE="#form.endmonth#">
				<CFREPORTPARAM name=Area VALUE="#form.region#">
				<CFREPORTPARAM name=modality VALUE="ALL">
				<CFREPORTPARAM name=FOCUSAREA VALUE="All">
				<CFREPORTPARAM name=Prognum VALUE="All">
				<CFREPORTPARAM name=Strategy VALUE="All">
				<CFREPORTPARAM name=ReportName VALUE="PP">
				<CFREPORTPARAM name=Monthrange VALUE="#Monthrange#">
				<CFREPORTPARAM name=ModWrd VALUE="Reality Check">
				<CFREPORTPARAM name=Obj VALUE="All">
				<CFREPORTPARAM name=Objective VALUE="All">
				<CFREPORTPARAM name=Initiative VALUE="All">
				<CFREPORTPARAM name=CM VALUE="#form.CM#">
				<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">
				<CFREPORTPARAM name=Modality VALUE="#form.modality#">
				<CFREPORTPARAM name=lastyear VALUE=#Year2less#>
				<CFREPORTPARAM name=Year2 VALUE=#session.fy#>
			</cfreport>
		</cfoutput>
	</cfcase>
	<cfcase value="779">
		<cfset foo = createObject("component", "cfcs.ReportLog").logreport(reportid=779) />
			<cfoutput>
			<cfparam name="form.Area" default="ALL">
			<cfparam name="form.Region" default="ALL">
			<cfparam name="form.fArea" default="ALL">
			<cfparam name="form.partner" default="ALL">
			<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="conmon">
		select
case partnertype
when 1 then 'CC'
when 2 then 'ATFC'
when 3 then 'YP'
when 4 then 'SP'
when 5 then 'C4C'
else 'NA' end as modality,
c.orgname, grantnum as contractNum,
'Point of Sale (POS)' as  initiative,
'Government Policy-maker Education' as strategy,
(select count(distinct tt.targid) from  target_org tt
               where  c.userid=tt.userid
                and tt.initnum='xxx'
                and isnull(tt.stratnum,2) = 2  and tt.name is not null
                and tt.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">)as ccount,
sum(  isNull(nature1,0)) as 'IssueEd',
sum( isNull(nature2,0)) as 'PolicySolutionEd',
sum( isNull(nature3,0)) as 'VoicedSupport'
,1 as grp
from
Security s,contact c
                left outer join monthly_org tor on
                c.userid=tor.userid
                and tor.year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
                and tor.initnum='2d'
                and isnull(tor.stratnum,2) = 2
                LEFT OUTER JOIN months m ON  tor.mon=m.mon_num
                and m.year2=tor.year2
                left join target_org t on tor.org = t.targid and tor.year2 = t.year2
                WHERE  c.partnertype =99
and s.userid=c.userid
and isNull(s.del, 0)=0
and isNull(s.endyear, '1/1/2040') > getdate()  and c.orgname <> 'christina.peluso' and c.orgname <> 'dpatterson'
group by
case partnertype
when 1 then 'CC'
when 2 then 'ATFC'
when 3 then 'YP'
when 4 then 'SP'
when 5 then 'C4C'
else 'NA' end,
c.orgname, grantnum , c.userid, tor.userid
<cfif isdefined("form.objective") and (( ListContainsNoCase(Form.objective,"all",",")) OR ListContainsNoCase(Form.objective,"2d",",")) >
UNION ALL
select
case partnertype
when 1 then 'CC'
when 2 then 'ATFC'
when 3 then 'YP'
when 4 then 'SP'
when 5 then 'C4C'
else 'NA' end as modality,
c.orgname, grantnum as contractNum,
'Point of Sale (POS)' as  initiative,
'Government Policy-maker Education' as strategy,
(select count(distinct tt.targid) from  target_org tt
               where  c.userid=tt.userid
                and tt.initnum='2d'
                and isnull(tt.stratnum,2) = 2  and tt.name is not null
                and tt.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">)as ccount,
sum(  isNull(nature1,0)) as 'IssueEd',
sum( isNull(nature2,0)) as 'PolicySolutionEd',
sum( isNull(nature3,0)) as 'VoicedSupport'
,1
from
Security s,contact c
                left outer join monthly_org tor on
                c.userid=tor.userid
                and tor.year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
                and tor.initnum='2d'
                and isnull(tor.stratnum,2) = 2
                LEFT OUTER JOIN months m ON  tor.mon=m.mon_num
                and m.year2=tor.year2
                left join target_org t on tor.org = t.targid and tor.year2 = t.year2
                WHERE  c.partnertype in (2,3)
and c.coordemail not like '%rti.org'
and c.email not like '%rti.org'
and c.coordemail not like '%health.state.ny.us'
and c.email not like '%health.state.ny.us'
and s.userid=c.userid
and isNull(s.del, 0)=0
and isNull(s.endyear, '1/1/2040') > getdate() and c.orgname <> 'christina.peluso' and c.orgname <> 'dpatterson'
<cfif isDefined("form.modality") and form.modality NEQ "ALL"  and form.modality NEQ "0">
	and c.partnertype = <cfqueryparam value="#form.modality#" cfsqltype="CF_SQL_INTEGER">
	</cfif>
	and c.partnertype !=1 and c.partnertype !=4
	<cfif isdefined("form.cm") and form.cm is not 'all'>
	and c.userid in (select userid from contact where cmanager = <cfqueryparam value="#form.cm#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">)
</cfif>
<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
</cfif>
group by
case partnertype
when 1 then 'CC'
when 2 then 'ATFC'
when 3 then 'YP'
when 4 then 'SP'
when 5 then 'C4C'
else 'NA' end,
c.orgname, grantnum , c.userid, tor.userid

</cfif>
<cfif isdefined("form.objective") and (( ListContainsNoCase(Form.objective,"all",",")) OR ListContainsNoCase(Form.objective,"2e",",")) >
UNION ALL
select
case partnertype
when 1 then 'CC'
when 2 then 'ATFC'
when 3 then 'YP'
when 4 then 'SP'
when 5 then 'C4C'
else 'NA' end as modality,
c.orgname, grantnum as contractNum,
                'Tobacco-free Outdoors' as  initiative, 'Government Policy-maker Education' as strategy,
                (select count(distinct tt.targid) from  target_org tt
               where  c.userid=tt.userid
                and tt.initnum='2e'
                and isnull(tt.stratnum,2) = 2  and tt.name is not null
                and tt.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">)as ccount,
               sum( isNull(nature1,0)) as 'Issue Ed.',
               sum(  isNull(nature2,0)) as 'Policy Solution Ed',
               sum(  isNull(nature3,0)) as 'Voiced Support'
               ,2
                from
                security s, contact c
                left outer join monthly_org tor on
                c.userid=tor.userid
                 and tor.year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
                and tor.initnum='2E'
                and isnull(tor.stratnum,2) = 2
                left outer join months m on tor.mon=m.mon_num
                and m.year2=tor.year2
                left join target_org t on tor.org = t.targid and tor.year2 = t.year2
                WHERE  c.partnertype in (2)
and c.coordemail not like '%rti.org'
and c.email not like '%rti.org'
and c.coordemail not like '%health.state.ny.us'
and c.email not like '%health.state.ny.us'
and s.userid=c.userid
and isNull(s.del, 0)=0
and isNull(s.endyear, '1/1/2040') > getdate() and c.orgname <> 'christina.peluso' and c.orgname <> 'dpatterson'
<cfif isDefined("form.modality") and form.modality NEQ "ALL">
	and c.partnertype = <cfqueryparam value="#form.modality#" cfsqltype="CF_SQL_INTEGER">
	</cfif>
	and c.partnertype !=1 and c.partnertype !=4
	<cfif isdefined("form.cm") and form.cm is not 'all'>
	and c.userid in (select userid from contact where cmanager = <cfqueryparam value="#form.cm#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">)
</cfif>
<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
</cfif>
 and c.orgname <> 'christina.peluso' and c.orgname <> 'dpatterson'
group by
case partnertype
when 1 then 'CC'
when 2 then 'ATFC'
when 3 then 'YP'
when 4 then 'SP'
when 5 then 'C4C'
else 'NA' end,
c.orgname, grantnum , c.userid, tor.userid
</cfif>
<cfif isdefined("form.objective") and (( ListContainsNoCase(Form.objective,"all",",")) OR ListContainsNoCase(Form.objective,"3M",",")) >
UNION ALL
select
case partnertype
when 1 then 'CC'
when 2 then 'ATFC'
when 3 then 'YP'
when 4 then 'SP'
when 5 then 'C4C'
else 'NA' end as modality,
c.orgname, grantnum as contractNum,
                'Smoke-free Media' as  initiative, 'Government Policy-maker Education' as strategy,
                (select count(distinct tt.targid) from  target_org tt
               where  c.userid=tt.userid
                and tt.initnum='3m'
                and isnull(tt.stratnum,2) = 2  and tt.name is not null
                and tt.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">)as ccount,
               sum( isNull(nature1,0)) as 'Issue Ed.',
               sum(  isNull(nature2,0)) as 'Policy Solution Ed',
               sum(  isNull(nature3,0)) as 'Voiced Support'
               ,2
                from
                security s, contact c
                left outer join monthly_org tor on
                c.userid=tor.userid
                 and tor.year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
                and tor.initnum='3M'
                and isnull(tor.stratnum,2) = 2
                left outer join months m on tor.mon=m.mon_num
                and m.year2=tor.year2
                left join target_org t on tor.org = t.targid and tor.year2 = t.year2
                WHERE  c.partnertype in (2)
and c.coordemail not like '%rti.org'
and c.email not like '%rti.org'
and c.coordemail not like '%health.state.ny.us'
and c.email not like '%health.state.ny.us'
and s.userid=c.userid
and isNull(s.del, 0)=0
and isNull(s.endyear, '1/1/2040') > getdate() and c.orgname <> 'christina.peluso' and c.orgname <> 'dpatterson'
<cfif isDefined("form.modality") and form.modality NEQ "ALL">
	and c.partnertype = <cfqueryparam value="#form.modality#" cfsqltype="CF_SQL_INTEGER">
	</cfif>
	and c.partnertype !=1 and c.partnertype !=4
	<cfif isdefined("form.cm") and form.cm is not 'all'>
	and c.userid in (select userid from contact where cmanager = <cfqueryparam value="#form.cm#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">)
</cfif>
<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
</cfif>
 and c.orgname <> 'christina.peluso' and c.orgname <> 'dpatterson'
group by
case partnertype
when 1 then 'CC'
when 2 then 'ATFC'
when 3 then 'YP'
when 4 then 'SP'
when 5 then 'C4C'
else 'NA' end,
c.orgname, grantnum , c.userid, tor.userid
</cfif>
<cfif isdefined("form.objective") and (( ListContainsNoCase(Form.objective,"all",",")) OR ListContainsNoCase(Form.objective,"2e",",")) >
UNION ALL
select
case partnertype
when 1 then 'CC'
when 2 then 'ATFC'
when 3 then 'YP'
when 4 then 'SP'
when 5 then 'C4C'
else 'NA' end as modality,
c.orgname, grantnum as contractNum,
                'Tobacco-free Outdoors' as  initiative, 'Advocating with Organizational Decision-Makers' as strategy,
                (select count(distinct tt.targid) from  target_org tt
               where  c.userid=tt.userid
                and tt.initnum='2E'
                and isnull(tt.stratnum,0) =1  and tt.name is not null
                and tt.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">),
             sum(    isNull(adcomm,0)) as 'Education about the issue',
              sum(   isNull(prvtrain,0)) as 'Education about policy solutions',
              sum(   isNull(techass,0)) as 'Voiced support for policy'
               ,4 from
                security s, contact c
                left outer join monthly_org tor
                on c.userid=tor.userid
                and tor.year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
                and tor.initnum='2E'
                and isnull(tor.stratnum,0) != 2
                left outer join months m
                on tor.mon=m.mon_num
                and m.year2=tor.year2
                left join target_org t on tor.org = t.targid and tor.year2 = t.year2
                where
                 c.partnertype in (2)
and c.coordemail not like '%rti.org'
and c.email not like '%rti.org'
and c.coordemail not like '%health.state.ny.us'
and c.email not like '%health.state.ny.us'
and s.userid=c.userid
and isNull(s.del, 0)=0
and isNull(s.endyear, '1/1/2040') > getdate() and c.orgname <> 'christina.peluso' and c.orgname <> 'dpatterson'
<cfif isDefined("form.modality") and form.modality NEQ "ALL">
	and c.partnertype = <cfqueryparam value="#form.modality#" cfsqltype="CF_SQL_INTEGER">
	</cfif>
	and c.partnertype !=1 and c.partnertype !=4
	<cfif isdefined("form.cm") and form.cm is not 'all'>
	and c.userid in (select userid from contact where cmanager = <cfqueryparam value="#form.cm#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">)
</cfif>
<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
</cfif>
group by
case partnertype
when 1 then 'CC'
when 2 then 'ATFC'
when 3 then 'YP'
when 4 then 'SP'
when 5 then 'C4C'
else 'NA' end,
c.orgname, grantnum , c.userid, tor.userid
</cfif>
<cfif isdefined("form.objective") and (( ListContainsNoCase(Form.objective,"all",",")) OR ListContainsNoCase(Form.objective,"4f",",")) >
UNION ALL
select
case partnertype
when 1 then 'CC'
when 2 then 'ATFC'
when 3 then 'YP'
when 4 then 'SP'
when 5 then 'C4C'
else 'NA' end as modality,
c.orgname, grantnum as contractNum,
                'Smoke-free Multi-Unit Housing' as  initiative, 'Government Policy-maker Education' as strategy,
                (select count(distinct tt.targid) from  target_org tt
               where  c.userid=tt.userid
                and tt.initnum='4f'
                and isnull(tt.stratnum,2) = 2  and tt.name is not null
                and tt.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">)as ccount,
               sum( isNull(nature1,0)) as 'Issue Ed.',
               sum(  isNull(nature2,0)) as 'Policy Solution Ed',
               sum(  isNull(nature3,0)) as 'Voiced Support'
               ,2
                from
                security s, contact c
                left outer join monthly_org tor on
                c.userid=tor.userid
                 and tor.year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
                and tor.initnum='4f'
                and isnull(tor.stratnum,2) = 2
                left outer join months m on tor.mon=m.mon_num
                and m.year2=tor.year2
                left join target_org t on tor.org = t.targid and tor.year2 = t.year2
                WHERE  c.partnertype in (2)
and c.coordemail not like '%rti.org'
and c.email not like '%rti.org'
and c.coordemail not like '%health.state.ny.us'
and c.email not like '%health.state.ny.us'
and s.userid=c.userid
and isNull(s.del, 0)=0
and isNull(s.endyear, '1/1/2040') > getdate() and c.orgname <> 'christina.peluso' and c.orgname <> 'dpatterson'
<cfif isDefined("form.modality") and form.modality NEQ "ALL">
	and c.partnertype = <cfqueryparam value="#form.modality#" cfsqltype="CF_SQL_INTEGER">
	</cfif>
	and c.partnertype !=1 and c.partnertype !=4
	<cfif isdefined("form.cm") and form.cm is not 'all'>
	and c.userid in (select userid from contact where cmanager = <cfqueryparam value="#form.cm#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">)
</cfif>
<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
</cfif>
 and c.orgname <> 'christina.peluso' and c.orgname <> 'dpatterson'
group by
case partnertype
when 1 then 'CC'
when 2 then 'ATFC'
when 3 then 'YP'
when 4 then 'SP'
when 5 then 'C4C'
else 'NA' end,
c.orgname, grantnum , c.userid, tor.userid
</cfif>
<cfif isdefined("form.objective") and (( ListContainsNoCase(Form.objective,"all",",")) OR ListContainsNoCase(Form.objective,"4f",",")) >
       UNION ALL
select
case partnertype
when 1 then 'CC'
when 2 then 'ATFC'
when 3 then 'YP'
when 4 then 'SP'
when 5 then 'C4C'
else 'NA' end as modality,
c.orgname, grantnum as contractNum,
                'Smoke-free Multi-Unit Housing' as  initiative, 'Advocating with Organizational Decision-Makers' as strategy,
                (select count(distinct tt.targid) from  target_org tt
               where  c.userid=tt.userid
                and tt.initnum='4f'
                and isnull(tt.stratnum,0) =1  and tt.name is not null
                and tt.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">),
             sum(    isNull(adcomm,0)) as 'Education about the issue',
              sum(   isNull(prvtrain,0)) as 'Education about policy solutions',
              sum(   isNull(techass,0)) as 'Voiced support for policy'
               ,4 from
                security s, contact c
                left outer join monthly_org tor
                on c.userid=tor.userid
                and tor.year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
                and tor.initnum='4f'
                and isnull(tor.stratnum,0) != 2
                left outer join months m
                on tor.mon=m.mon_num
                and m.year2=tor.year2
                left join target_org t on tor.org = t.targid and tor.year2 = t.year2
                where
                 c.partnertype in (2)
and c.coordemail not like '%rti.org'
and c.email not like '%rti.org'
and c.coordemail not like '%health.state.ny.us'
and c.email not like '%health.state.ny.us'
and s.userid=c.userid
and isNull(s.del, 0)=0
and isNull(s.endyear, '1/1/2040') > getdate() and c.orgname <> 'christina.peluso' and c.orgname <> 'dpatterson'
<cfif isDefined("form.modality") and form.modality NEQ "ALL">
	and c.partnertype = <cfqueryparam value="#form.modality#" cfsqltype="CF_SQL_INTEGER">
	</cfif>
	and c.partnertype !=1 and c.partnertype !=4
	<cfif isdefined("form.cm") and form.cm is not 'all'>
	and c.userid in (select userid from contact where cmanager = <cfqueryparam value="#form.cm#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">)
</cfif>
<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
</cfif>
group by
case partnertype
when 1 then 'CC'
when 2 then 'ATFC'
when 3 then 'YP'
when 4 then 'SP'
when 5 then 'C4C'
else 'NA' end,
c.orgname, grantnum , c.userid, tor.userid
</cfif>
<cfif isdefined("form.objective") and (( ListContainsNoCase(Form.objective,"all",",")) OR ListContainsNoCase(Form.objective,"3M",",")) >
UNION ALL
select
case partnertype
when 1 then 'CC'
when 2 then 'ATFC'
when 3 then 'YP'
when 4 then 'SP'
when 5 then 'C4C'
else 'NA' end as modality,
c.orgname, grantnum as contractNum,
                'Smoke-free Media' as  initiative, 'Advocating with Organizational Decision-Makers' as strategy,
                (select count(distinct tt.targid) from  target_org tt
               where  c.userid=tt.userid
                and tt.initnum='3M'
                and isnull(tt.stratnum,0) =1  and tt.name is not null
                and tt.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">),
             sum(    isNull(adcomm,0)) as 'Education about the issue',
              sum(   isNull(prvtrain,0)) as 'Education about policy solutions',
              sum(   isNull(techass,0)) as 'Voiced support for policy'
               ,4 from
                security s, contact c
                left outer join monthly_org tor
                on c.userid=tor.userid
                and tor.year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
                and tor.initnum='3m'
                and isnull(tor.stratnum,0) != 2
                left outer join months m
                on tor.mon=m.mon_num
                and m.year2=tor.year2
                left join target_org t on tor.org = t.targid and tor.year2 = t.year2
                where
                 c.partnertype in (2)
and c.coordemail not like '%rti.org'
and c.email not like '%rti.org'
and c.coordemail not like '%health.state.ny.us'
and c.email not like '%health.state.ny.us'
and s.userid=c.userid
and isNull(s.del, 0)=0
and isNull(s.endyear, '1/1/2040') > getdate() and c.orgname <> 'christina.peluso' and c.orgname <> 'dpatterson'
<cfif isDefined("form.modality") and form.modality NEQ "ALL">
	and c.partnertype = <cfqueryparam value="#form.modality#" cfsqltype="CF_SQL_INTEGER">
	</cfif>
	and c.partnertype !=1 and c.partnertype !=4
	<cfif isdefined("form.cm") and form.cm is not 'all'>
	and c.userid in (select userid from contact where cmanager = <cfqueryparam value="#form.cm#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">)
</cfif>
<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
</cfif>
group by
case partnertype
when 1 then 'CC'
when 2 then 'ATFC'
when 3 then 'YP'
when 4 then 'SP'
when 5 then 'C4C'
else 'NA' end,
c.orgname, grantnum , c.userid, tor.userid
</cfif>
order by
4, 5,
1,2,3
</cfquery><!--- <cfabort> --->
			<cfreport template="./reports/advoc_gpme_targ2.cfr"  format = "pdf"   query="conmon">
				<CFREPORTPARAM name=Year2 VALUE=#session.fy#>
				<CFREPORTPARAM name=Objval VALUE="#obj#">
				<cfif isdefined("cm") and #cm# is not ''>
					<CFREPORTPARAM name=CM VALUE="#form.cm#">
				<cfelse>
					<CFREPORTPARAM name=CM VALUE="All">
				</cfif>
				<cfif form.partner is not 'all'>
					<CFREPORTPARAM name=PartnerName VALUE="#conmon.orgname#">
				<cfelse>
					<CFREPORTPARAM name=PartnerName VALUE="All">
				</cfif>
				<cfif isdefined("form.modality") and #form.modality# is 1>
					<CFREPORTPARAM name=ModWrd VALUE="Cessation Center">
				<cfelseif isdefined("form.modality") and #form.modality# is 2>
					<CFREPORTPARAM name=ModWrd VALUE="ATFC">
				<cfelseif isdefined("form.modality") and #form.modality# is 3>
					<CFREPORTPARAM name=ModWrd VALUE="Reality Check">
				<cfelseif isdefined("form.modality") and #form.modality# is 5>
					<CFREPORTPARAM name=ModWrd VALUE="Colleges for Change">
				<cfelse>
					<CFREPORTPARAM name=ModWrd VALUE="All Modalities">
				</cfif>
			</cfreport>
		</cfoutput>
	</cfcase>
	<cfcase value="111">
		<cfset foo = createObject("component", "cfcs.ReportLog").logreport(reportid=111) />
		<cfoutput>
			<cfparam name="form.Area" default="ALL">
			<cfparam name="form.Region" default="ALL">
			<cfparam name="form.fArea" default="ALL">
			<cfparam name="form.partner" default="ALL">
			<cfoutput>
				<cfif isdefined("form.objective") and form.objective NEQ "ALL">
					<cfset obj = ''>
					<cfset objlst = ''>
					<cfloop index="x" list="#form.objective#">
						<cfquery datasource="#Application.DataSource#"
			password="#Application.db_password#"
			username="#Application.db_username#" name="Qobj">
			select id,initiative from objectives where id = '#x#'
			and year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
			order by initiative
		</cfquery>
						<cfset obj = ListAppend(obj, qobj.initiative, ",")>
						<cfset objlst = #quotedvaluelist(qobj.id)#>
					</cfloop>
				</cfif>
				<cfif #form.objective# contains "inf">
					<cfset obj = ListAppend(obj, 'Infrastructure', ",")>
				</cfif>
			</cfoutput>
			<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="conmon">
select orgname,case m.mon when 1 then 'January' when 2 then 'February' when 3 then 'March' when 4 then 'April' when 5 then 'May' when 6 then 'June' when 7 then 'July' when 8 then 'August' when 9 then 'September' when 10 then 'October' when 11 then 'November' when 12 then 'December' end as monty,
	initnum,initiative,advmassmail,m.userid,editor,prsspk,prssrlse,calls, NULL as legvisit,NULL as legcorr,NULL as mediarep,null as numsub, null as numpub,summary,barriers,steps, c.partnertype
	from monthly m
	inner join contact c on m.userid = c.userid
	inner join objectives o
	on m.initnum = o.id and m.year2 = o.year2
	inner join months mo on m.mon = mo.mon_num and m.year2 = mo.year2
	where
	1=1
	<cfif isdefined("form.cm") and form.cm is not 'all'>
	and m.userid in (select userid from contact where cmanager = <cfqueryparam value="#form.cm#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">)
	</cfif>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
		and m.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
<cfelseif isDefined("form.Region") and form.region is not 'all'>
		and m.userid in
		(select userid from security s, area a, region r
where s.del is null
and s.area = a.num
and a.region=r.num
and a.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
and r.num=<cfqueryparam value="#form.region#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
and r.year2=a.year2 )
	</cfif>
	<cfif isDefined("form.modality") and form.modality NEQ "ALL">
	and c.partnertype = <cfqueryparam value="#form.modality#" cfsqltype="CF_SQL_INTEGER">
	</cfif>
	and m.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
    and mo.rank >= <cfqueryparam value="#form.stmonth#" cfsqltype="CF_SQL_INTEGER">
	and mo.rank <= <cfqueryparam value="#form.endmonth#" cfsqltype="CF_SQL_INTEGER">
	<cfif isdefined("form.objective") and form.objective NEQ "ALL">
		and initnum in (#ListQualify(Form.objective,"'")#)
	</cfif>
	<cfif isdefined("form.objective") and (form.objective EQ "ALL" or form.objective CONTAINS 'inf')>
	union
select orgname,case infra.mon when 1 then 'January' when 2 then 'February' when 3 then 'March' when 4 then 'April' when 5 then 'May'
when 6 then 'June' when 7 then 'July' when 8 then 'August' when 9 then 'September' when 10 then 'October' when 11 then 'November'
when 12 then 'December' end as monty,
	'999' as initnum,'Infrastructure' as initiative,'' as advmassmail,infra.userid,'' as editor,'' as prsspk,'' as prssrlse,'' as calls,
	legvisit,legcorr,mediarep,numsub,numpub,'' as summary,'' as barriers,'' as steps, c.partnertype
	from infra
	inner join contact c on infra.userid = c.userid
	inner join months mo on infra.mon = mo.mon_num and infra.year2 = mo.year2
	where
	1=1
	<cfif isdefined("form.cm") and form.cm is not 'all'>
	and infra.userid in (select userid from contact where cmanager = <cfqueryparam value="#form.cm#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">)
	</cfif>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and infra.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
<cfelseif isDefined("form.Region") and form.region is not 'all'>
		and infra.userid in
		(select userid from security s, area a, region r
where s.del is null
and s.area = a.num
and a.region=r.num
and a.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
and r.num=<cfqueryparam value="#form.region#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
and r.year2=a.year2 )
	</cfif>
	<cfif isDefined("form.modality") and form.modality NEQ "ALL">
	and c.partnertype = <cfqueryparam value="#form.modality#" cfsqltype="CF_SQL_INTEGER">
	</cfif>
	and year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and mo.rank >= <cfqueryparam value="#form.stmonth#" cfsqltype="CF_SQL_INTEGER">
	and mo.rank <= <cfqueryparam value="#form.endmonth#" cfsqltype="CF_SQL_INTEGER">
	</cfif>
order by c.orgname, initnum
</cfquery>
			<cfreport template="./reports/conmon2.cfr" format = "pdf" query="conmon">
				<CFREPORTPARAM name=Year2 VALUE=#session.fy#>
				<CFREPORTPARAM name=Area VALUE="#form.region#">
				<CFREPORTPARAM name=modality VALUE="ALL">
				<CFREPORTPARAM name=FOCUSAREA VALUE="All">
				<CFREPORTPARAM name=Prognum VALUE="All">
				<cfif isdefined("obj") and #obj# is not '' and #obj# NEQ "()">
					<CFREPORTPARAM name=Obj VALUE="#obj#">
				<cfelse>
					<CFREPORTPARAM name=Obj VALUE="All">
				</cfif>
				<cfif isdefined("form.objective")>
					<CFREPORTPARAM name=Objective VALUE="#form.objective#">
				<cfelse>
					<CFREPORTPARAM name=Objective VALUE="All">
				</cfif>
				<CFREPORTPARAM name=Strategy VALUE="All">
				<CFREPORTPARAM name=ReportName VALUE="PP">
				<CFREPORTPARAM name=StMonth VALUE="#form.stmonth#">
				<CFREPORTPARAM name=endMonth VALUE="#form.endmonth#">
				<CFREPORTPARAM name=stYear VALUE="2007">
				<CFREPORTPARAM name=endYr VALUE="2007">
				<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">
				<CFREPORTPARAM name=Modality VALUE="#form.modality#">
				<cfif isdefined("form.modality") and #form.modality# is 1>
					<CFREPORTPARAM name=ModWrd VALUE="Cessation Center">
				<cfelseif isdefined("form.modality") and #form.modality# is 2>
					<CFREPORTPARAM name=ModWrd VALUE="ATFC">
				<cfelseif isdefined("form.modality") and #form.modality# is 3>
					<CFREPORTPARAM name=ModWrd VALUE="Reality Check">
				<cfelseif isdefined("form.modality") and #form.modality# is 5>
					<CFREPORTPARAM name=ModWrd VALUE="Colleges for Change">
				<cfelse>
					<CFREPORTPARAM name=ModWrd VALUE="All Modalities">
				</cfif>
				<CFREPORTPARAM name=Monthrange VALUE="#Monthrange#">
			</cfreport>
		</cfoutput>
	</cfcase>
	<cfcase value="4444">
		<cfset foo = createObject("component", "cfcs.ReportLog").logreport(reportid=4444) />
		<cfoutput>
			<cfparam name="form.stMonth" default="1">
			<cfparam name="form.endMonth" default="#DatePart('m', Now())#">
			<cfparam name="form.Area" default="ALL">
			<cfparam name="form.Region" default="ALL">
			<cfparam name="form.fArea" default="ALL">
			<cfparam name="form.partner" default="ALL">
			<cfif session.fy LT session.def_fy>
				<cfset form.endMonth = 12>
			<cfelse>
				<cfparam name="form.endMonth" default="#DatePart('m', Now())#">
			</cfif>
			<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="cmfb">
SELECT DISTINCT c.orgName, o.initiative, c.userid, m.initnum, c.partnerType AS modality, m.year2, GETDATE() AS dtt,
case m.initnum
when '2d' then 1
when '2e' then 2
when '4f' then 3
when '2m' then 4
when '2l' then 5
when '3g' then 6
when '6b' then 7
when '99' then 8
else 9 end as sortinit
FROM        months as mo, monthly AS m LEFT OUTER JOIN
                      contact AS c ON c.userid = m.userid INNER JOIN
                      objectives AS o ON m.initnum = o.ID AND m.year2 = o.year2
	<cfif isDefined("form.modality") and form.modality NEQ "ALL">
	and c.partnertype = <cfqueryparam value="#form.modality#" cfsqltype="CF_SQL_INTEGER">
	</cfif>
	and c.partnertype !=1 and c.partnertype !=4
	<cfif isdefined("form.cm") and form.cm is not 'all'>
	and c.userid in (select userid from contact where cmanager = <cfqueryparam value="#form.cm#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">)
</cfif>
<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
</cfif>
<cfif isdefined("form.objective") and form.objective NEQ "ALL">
		and initnum in (#ListQualify(Form.objective,"'")#)
</cfif>
	where
	test is null and --submitdt is not null and
	m.year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and orgname is not null
	and orgname not like '%test%'
	and m.year2=mo.year2
	and m.mon=mo.mon_num
	and mo.rank >= <cfqueryparam value="#form.stmonth#" cfsqltype="CF_SQL_INTEGER">
	and mo.rank <= <cfqueryparam value="#form.endmonth#" cfsqltype="CF_SQL_INTEGER">
<cfif isdefined("form.objective") and (ListContainsNoCase(Form.objective,"all",",") OR ListContainsNoCase(Form.objective,"inf",","))>
 UNION
SELECT DISTINCT c.orgName, 'Infrastructure' AS initiative, c.userid, '99' AS initnum, c.partnerType AS modality, m.year2, GETDATE() AS dtt, 99
FROM         months as mo, infra AS m LEFT OUTER JOIN
                      contact AS c ON c.userid = m.userid
	<cfif isDefined("form.modality") and form.modality NEQ "ALL">
	and c.partnertype = <cfqueryparam value="#form.modality#" cfsqltype="CF_SQL_INTEGER">
	</cfif>
	and c.partnertype !=1 and c.partnertype !=4
	<cfif isdefined("form.cm") and form.cm is not 'all'>
	and c.userid in (select userid from contact where cmanager = <cfqueryparam value="#form.cm#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">)
</cfif>
<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
</cfif>
where
	test is null and --submitdt is not null and
	m.year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and orgname is not null
	and orgname not like '%test%'
	and m.year2=mo.year2
	and m.mon=mo.mon_num
    and mo.rank >= <cfqueryparam value="#form.stmonth#" cfsqltype="CF_SQL_INTEGER">
	and mo.rank <= <cfqueryparam value="#form.endmonth#" cfsqltype="CF_SQL_INTEGER">
</cfif>
ORDER BY c.partnertype, c.orgName,

case m.initnum
when '2d' then 1
when '2e' then 2
when '4f' then 3
when '2m' then 4
when '2l' then 5
when '3g' then 6
when '6b' then 7
when '99' then 8
else 9 end,
m.initnum
</cfquery>
			<cfset mon = #month(cmfb.dtt)#>
			<cfreport template="./reports/progout_DP.cfr" format = "pdf" query="cmfb">
				<CFREPORTPARAM name=dtt VALUE="#cmfb.dtt#">
				<CFREPORTPARAM name=mon VALUE="#mon#">
				<CFREPORTPARAM name=Year2 VALUE=#session.fy#>
				<CFREPORTPARAM name=Area VALUE="#form.region#">
				<CFREPORTPARAM name=modality VALUE="ALL">
				<CFREPORTPARAM name=FOCUSAREA VALUE="All">
				<CFREPORTPARAM name=Prognum VALUE="All">
				<cfif isdefined("obj") and #obj# is not '' and #obj# NEQ "()">
					<CFREPORTPARAM name=Obj VALUE="#obj#">
				<cfelse>
					<CFREPORTPARAM name=Obj VALUE="All">
				</cfif>
				<CFREPORTPARAM name=Strategy VALUE="All">
				<CFREPORTPARAM name=ReportName VALUE="PP">
				<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">
				<CFREPORTPARAM name=Modality VALUE="#form.modality#">
				<cfif isdefined("form.modality") and #form.modality# is 1>
					<CFREPORTPARAM name=ModWrd VALUE="Cessation Center">
				<cfelseif isdefined("form.modality") and #form.modality# is 2>
					<CFREPORTPARAM name=ModWrd VALUE="ATFC">
				<cfelseif isdefined("form.modality") and #form.modality# is 3>
					<CFREPORTPARAM name=ModWrd VALUE="Reality Check">
				<cfelseif isdefined("form.modality") and #form.modality# is 5>
					<CFREPORTPARAM name=ModWrd VALUE="Colleges for Change">
				<cfelse>
					<CFREPORTPARAM name=ModWrd VALUE="All Modalities">
				</cfif>
				<CFREPORTPARAM name=Monthrange VALUE="#Monthrange6#">
				<CFREPORTPARAM name=StMonth VALUE="#form.stmonth#">
				<CFREPORTPARAM name=endMonth VALUE="#form.endmonth#">
				<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">
			</cfreport>
		</cfoutput>
	</cfcase>
	<cfcase value="555">
		<cfset foo = createObject("component", "cfcs.ReportLog").logreport(reportid=555) />
		<cfoutput>
			<cfparam name="form.Area" default="ALL">
			<cfparam name="form.Region" default="ALL">
			<cfparam name="form.fArea" default="ALL">
			<cfparam name="form.partner" default="ALL">
			<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="pos">
select distinct
m.year2,
co.orgname,
sum(case isnull(c.type,0) when 3  then 1 else 0 end) as mpc,
sum(case isnull(c.type,0) when 1  then 1 else 0 end) as hoa,
sum(case  isnull(c.type,0) when 2 then 1 else 0 end) as hdu,
sum(case isnull(c.type,0) when 4  then 1 else 0 end) as other,
sum(CASE FQHC WHEN 1 THEN 1 ELSE 0 END) AS FQHC,
0 as so
 from contact co, monthly_targethcpo m inner join collaborators c on m.seq = c.seq
left outer join  wrkplan_targethcpo as w on w.targethcpo_id = c.type and w.year2=m.year2
 where  m.year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
and m.year2=w.year2
AND adcomm3=1
and co.userid=m.userid
and co.coordemail not like '%rti.org'
group by m.year2,
co.orgname
UNION
select distinct
s.year2, c.orgname,
0,0,0,0,0,
<cfif session.fy LT 2012>isnull(so2,0)- isnull(so1,0)<cfelse>isnull(so1,0)</cfif>as so
from contact c, smartoutcome s left outer join smartoutcomes so on s.initnum = so.initnum and s.sonum = so.sonum
and so.year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	where
s.initnum = '1a'
and s.soNum='1b'
and modality = '1'
and c.userid=so.userid
and c.partnertype=1
and s.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
and c.coordemail not like '%rti.org'
order by 1,2
</cfquery>
			<cfreport template="./reports/hcpo2maint.cfr" format = "pdf" query="pos">
				<CFREPORTPARAM name=REPORTPER VALUE="#session.fy#">
			</cfreport>
		</cfoutput>
	</cfcase>
	<cfcase value="825">
		<cfset foo = createObject("component", "cfcs.ReportLog").logreport(reportid=825) />
		<cfoutput>
			<cfparam name="form.Area" default="ALL">
			<cfparam name="form.Region" default="ALL">
			<cfparam name="form.fArea" default="ALL">
			<cfparam name="form.partner" default="ALL">
			<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="pos">
	select
case partnertype
when 1 then 'CC'
when 2 then 'CP'
when 3 then 'YP'
when 4 then 'SP'
when 5 then 'C4C'
else 'NA' end as modality,
c.orgname, grantnum as contractNum,
	'Point of Sale (POS)' as  initiative,
	'Government Policy-maker Education' as strategy,
	case org
	when 999 then 'MPAA'
	when 888 then 'YouTube'
	when 777 then 'Major Television Network'
	else isNull(t.name, 'No data entered') end as name,
	tor.mon as monnum, m.mon,
	isNull(nature1,0) as 'IssueEd',
	isNull(nature2,0) as 'PolicySolutionEd',
	isNull(nature3,0) as 'VoicedSupport'	, m.rank, getdate() as rundt,targdisp as dispar
	from
	security s, contact c
	left outer join monthly_org tor on
	c.userid=tor.userid
	and tor.initnum='2d'
	and isnull(tor.stratnum,2) = 2
	and (isNull(nature1,0)=1 OR isNull(nature2,0)=1 or isNull(nature3,0)=1)
	LEFT OUTER JOIN months m ON  tor.mon=m.mon_num
	and m.year2=tor.year2
	left join target_org t on tor.org = t.targid and tor.year2 = t.year2
	left join wrkplan_targets wt on t.targnum = wt.targetid and t.year2 = wt.year2
	WHERE  c.partnertype in (2,3)
    and tor.year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	 and t.name is not null
and c.coordemail not like '%rti.org'
and c.email not like '%rti.org'
and c.coordemail not like '%health.state.ny.us'
and c.email not like '%health.state.ny.us'
and s.userid=c.userid
and isNull(s.del, 0)=0
and isNull(s.endyear, '1/1/2040') > getdate()
<cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>
and tor.initnum in  (#ListQualify(Form.objective,"'")#)
</cfif>
<cfif isDefined("form.modality") and form.modality NEQ "ALL" and form.modality NEQ "0">
	and c.partnertype = <cfqueryparam value="#form.modality#" cfsqltype="CF_SQL_INTEGER">
	</cfif>
	and c.partnertype !=1 and c.partnertype !=4
	<cfif isdefined("form.cm") and form.cm is not 'all'>
	and c.userid in (select userid from contact where cmanager = <cfqueryparam value="#form.cm#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">)
</cfif>
<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
</cfif>
UNION ALL
	select
	case partnertype
when 1 then 'CC'
when 2 then 'CP'
when 3 then 'YP'
when 4 then 'SP'
when 5 then 'C4C'
else 'NA' end as modality,
c.orgname, grantnum as contractNum,
	'Tobacco-free Outdoors' as  initiative, 'Government Policy-maker Education' as strategy,
	case org
	when 999 then 'MPAA'
	when 888 then 'YouTube'
	when 777 then 'Major Television Network'
	else isNull(t.name, 'No data entered') end as name,
	tor.mon, m.mon,
	isNull(nature1,0) as 'Issue Ed.',
	isNull(nature2,0) as 'Policy Solution Ed',
	isNull(nature3,0) as 'Voiced Support'	, m.rank, getdate(),targdisp as dispar
	from
	security s, contact c
	left outer join monthly_org tor on
	c.userid=tor.userid
	and tor.initnum='2E'
	and isnull(tor.stratnum,2) = 2
	and (isNull(nature1,0)=1 OR isNull(nature2,0)=1 or isNull(nature3,0)=1)
	left outer join months m on tor.mon=m.mon_num
	and m.year2=tor.year2
	left join target_org t on tor.org = t.targid and tor.year2 = t.year2
	left join wrkplan_targets wt on t.targnum = wt.targetid and t.year2 = wt.year2
	WHERE  c.partnertype in (2)
    and tor.year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
    	 and t.name is not null
and c.coordemail not like '%rti.org'
and c.email not like '%rti.org'
and c.coordemail not like '%health.state.ny.us'
and c.email not like '%health.state.ny.us'
and s.userid=c.userid
and isNull(s.del, 0)=0
and isNull(s.endyear, '1/1/2040') > getdate()
<cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>
and tor.initnum in  (#ListQualify(Form.objective,"'")#)
</cfif>
<cfif isDefined("form.modality") and form.modality NEQ "ALL">
	and c.partnertype = <cfqueryparam value="#form.modality#" cfsqltype="CF_SQL_INTEGER">
	</cfif>
	and c.partnertype !=1 and c.partnertype !=4
	<cfif isdefined("form.cm") and form.cm is not 'all'>
	and c.userid in (select userid from contact where cmanager = <cfqueryparam value="#form.cm#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">)
</cfif>
<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
</cfif>
UNION ALL
	select
	case partnertype
when 1 then 'CC'
when 2 then 'CP'
when 3 then 'YP'
when 4 then 'SP'
when 5 then 'C4C'
else 'NA' end as modality,
c.orgname, grantnum as contractNum,
	'Smoke-free Media' as  initiative, 'Government Policy-maker Education' as strategy,
	case org
	when 999 then 'MPAA'
	when 888 then 'YouTube'
	when 777 then 'Major Television Network'
	else isNull(t.name, 'No data entered') end as name,
	tor.mon, m.mon,
	isNull(nature1,0) as 'Issue Ed.',
	isNull(nature2,0) as 'Policy Solution Ed',
	isNull(nature3,0) as 'Voiced Support'	, m.rank, getdate(),targdisp as dispar
	from
	security s, contact c
	left outer join monthly_org tor on
	c.userid=tor.userid
	and tor.initnum='3M'
	and isnull(tor.stratnum,2) = 2
	and (isNull(nature1,0)=1 OR isNull(nature2,0)=1 or isNull(nature3,0)=1)
	left outer join months m on tor.mon=m.mon_num
	and m.year2=tor.year2
	left join target_org t on tor.org = t.targid and tor.year2 = t.year2
	left join wrkplan_targets wt on t.targnum = wt.targetid and t.year2 = wt.year2
	where
	 c.partnertype in (3)
	    and tor.year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
          and t.name is not null
and c.coordemail not like '%rti.org'
and c.email not like '%rti.org'
and c.coordemail not like '%health.state.ny.us'
and c.email not like '%health.state.ny.us'
and s.userid=c.userid
and isNull(s.del, 0)=0
and isNull(s.endyear, '1/1/2040') > getdate()
<cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>
and tor.initnum in  (#ListQualify(Form.objective,"'")#)
</cfif>
<cfif isDefined("form.modality") and form.modality NEQ "ALL">
	and c.partnertype = <cfqueryparam value="#form.modality#" cfsqltype="CF_SQL_INTEGER">
	</cfif>
	and c.partnertype !=1 and c.partnertype !=4
	<cfif isdefined("form.cm") and form.cm is not 'all'>
	and c.userid in (select userid from contact where cmanager = <cfqueryparam value="#form.cm#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">)
</cfif>
<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
</cfif>
	UNION ALL
	select
	case partnertype
when 1 then 'CC'
when 2 then 'CP'
when 3 then 'YP'
when 4 then 'SP'
when 5 then 'C4C'
else 'NA' end as modality,
c.orgname, grantnum as contractNum,
	'Tobacco-free Outdoors' as  initiative, 'Advocating with Organizational Decision-Makers' as strategy,
	case org
	when 999 then 'MPAA'
	when 888 then 'YouTube'
	when 777 then 'Major Television Network'
	else isNull(t.name, 'No data entered') end as name,
	tor.mon, m.mon,
	isNull(adcomm,0) as 'Education about the issue',
	isNull(prvtrain,0) as 'Education about policy solutions',
	isNull(techass,0) as 'Voiced support for policy'		, m.rank, getdate(),targdisp as dispar
	from
	security s, contact c
	left outer join monthly_org tor
	on c.userid=tor.userid
	and tor.initnum='2E'
	and isnull(tor.stratnum,0) != 2
	and (isNull(adcomm,0)=1 OR isNull(prvtrain,0)=1 or isNull(techass,0)=1)
	left outer join months m
	on tor.mon=m.mon_num
	and m.year2=tor.year2
	left join target_org t on tor.org = t.targid and tor.year2 = t.year2
	left join wrkplan_targets wt on t.targnum = wt.targetid and t.year2 = wt.year2
	where
	 c.partnertype in (2)
	     and tor.year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
         and t.name is not null
and c.coordemail not like '%rti.org'
and c.email not like '%rti.org'
and c.coordemail not like '%health.state.ny.us'
and c.email not like '%health.state.ny.us'
and s.userid=c.userid
and isNull(s.del, 0)=0
and isNull(s.endyear, '1/1/2040') > getdate()
<cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>
and tor.initnum in  (#ListQualify(Form.objective,"'")#)
</cfif>
<cfif isDefined("form.modality") and form.modality NEQ "ALL">
	and c.partnertype = <cfqueryparam value="#form.modality#" cfsqltype="CF_SQL_INTEGER">
	</cfif>
	and c.partnertype !=1 and c.partnertype !=4
	<cfif isdefined("form.cm") and form.cm is not 'all'>
	and c.userid in (select userid from contact where cmanager = <cfqueryparam value="#form.cm#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">)
</cfif>
<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
</cfif>
	UNION ALL
		select
	case partnertype
when 1 then 'CC'
when 2 then 'CP'
when 3 then 'YP'
when 4 then 'SP'
when 5 then 'C4C'
else 'NA' end as modality,
c.orgname, grantnum as contractNum,
	'Smoke-free Multi-unit Housing' as  initiative, 'Advocating with Organizational Decision-Makers' as strategy,
	case org
	when 999 then 'MPAA'
	when 888 then 'YouTube'
	when 777 then 'Major Television Network'
	else isNull(t.name, 'No data entered') end as name,
	tor.mon, m.mon,
	isNull(adcomm,0) as 'Education about the issue',
	isNull(prvtrain,0) as 'Education about policy solutions',
	isNull(techass,0) as 'Voiced support for policy'	, m.rank	, getdate(),targdisp as dispar
	from
	security s, contact c
	left outer join monthly_org tor
	on  c.userid=tor.userid
		and tor.initnum='4f'
	and isnull(tor.stratnum,0) != 2
	and (isNull(adcomm,0)=1 OR isNull(prvtrain,0)=1 or isNull(techass,0)=1)
	left outer join months m
	on tor.mon=m.mon_num
	and m.year2=tor.year2
	left join target_org t on tor.org = t.targid and tor.year2 = t.year2
	left join wrkplan_targets wt on t.targnum = wt.targetid and t.year2 = wt.year2
	where
	 c.partnertype in (2)
	      and tor.year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
          and t.name is not null
and c.coordemail not like '%rti.org'
and c.email not like '%rti.org'
and c.coordemail not like '%health.state.ny.us'
and c.email not like '%health.state.ny.us'
and s.userid=c.userid
and isNull(s.del, 0)=0
<cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>
and tor.initnum in  (#ListQualify(Form.objective,"'")#)
</cfif>
<cfif isDefined("form.modality") and form.modality NEQ "ALL">
	and c.partnertype = <cfqueryparam value="#form.modality#" cfsqltype="CF_SQL_INTEGER">
	</cfif>
	and c.partnertype !=1 and c.partnertype !=4
	<cfif isdefined("form.cm") and form.cm is not 'all'>
	and c.userid in (select userid from contact where cmanager = <cfqueryparam value="#form.cm#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">)
</cfif>
<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
</cfif>
	UNION ALL
select
	case partnertype
when 1 then 'CC'
when 2 then 'CP'
when 3 then 'YP'
when 4 then 'SP'
when 5 then 'C4C'
else 'NA' end as modality,
c.orgname, grantnum as contractNum,
	'Smoke-free Media' as  initiative, 'Advocating with Organizational Decision-Makers' as strategy,
	case org
	when 999 then 'MPAA'
	when 888 then 'YouTube'
	when 777 then 'Major Television Network'
	else isNull(t.name, 'No data entered') end as name,
	tor.mon, m.mon,
	isNull(adcomm,0) as 'Education about the issue',
	isNull(prvtrain,0) as 'Education about policy solutions',
	isNull(techass,0) as 'Voiced support for policy'		, m.rank, getdate(),targdisp as dispar
	from
	security s, contact c
	left outer join monthly_org tor
	on c.userid=tor.userid
	and tor.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and tor.initnum='3m'
	and isnull(tor.stratnum,0) != 2
	and (isNull(adcomm,0)=1 OR isNull(prvtrain,0)=1 or isNull(techass,0)=1)
	left outer join  months m on tor.mon=m.mon_num
	and m.year2=tor.year2
	left join target_org t on tor.org = t.targid and tor.year2 = t.year2
	left join wrkplan_targets wt on t.targnum = wt.targetid and t.year2 = wt.year2
	where
	  c.partnertype in (3)
      and t.name is not null
and c.coordemail not like '%rti.org'
and c.email not like '%rti.org'
and c.coordemail not like '%health.state.ny.us'
and c.email not like '%health.state.ny.us'
and s.userid=c.userid
and isNull(s.del, 0)=0
and isNull(s.endyear, '1/1/2040') > getdate()
<cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>
and tor.initnum in (#ListQualify(Form.objective,"'")#)
</cfif>
<cfif isDefined("form.modality") and form.modality NEQ "ALL">
	and c.partnertype = <cfqueryparam value="#form.modality#" cfsqltype="CF_SQL_INTEGER">
	</cfif>
	and c.partnertype !=1 and c.partnertype !=4
	<cfif isdefined("form.cm") and form.cm is not 'all'>
	and c.userid in (select userid from contact where cmanager = <cfqueryparam value="#form.cm#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">)
</cfif>
<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
</cfif>
UNION ALL
	select
	case partnertype
when 1 then 'CC'
when 2 then 'CP'
when 3 then 'YP'
when 4 then 'SP'
when 5 then 'C4C'
else 'NA' end as modality,
c.orgname, grantnum as contractNum,
	'Smoke-free Media' as  initiative, 'Government Policy-maker Education' as strategy,
	case org
	when 999 then 'MPAA'
	when 888 then 'YouTube'
	when 777 then 'Major Television Network'
	else isNull(t.name, 'No data entered') end as name,
	tor.mon, m.mon,
	isNull(nature1,0) as 'Issue Ed.',
	isNull(nature2,0) as 'Policy Solution Ed',
	isNull(nature3,0) as 'Voiced Support'	, m.rank, getdate(),targdisp as dispar
	from
	security s, contact c
	left outer join monthly_org tor on
	c.userid=tor.userid
	and tor.initnum='3M'
	and isnull(tor.stratnum,2) = 2
	and (isNull(nature1,0)=1 OR isNull(nature2,0)=1 or isNull(nature3,0)=1)
	left outer join months m on tor.mon=m.mon_num
	and m.year2=tor.year2
	left join target_org t on tor.org = t.targid and tor.year2 = t.year2
	left join wrkplan_targets wt on t.targnum = wt.targetid and t.year2 = wt.year2
	where
	 c.partnertype in (2)
	    and tor.year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	    and tor.year2 >= 2015
          and t.name is not null
and c.coordemail not like '%rti.org'
and c.email not like '%rti.org'
and c.coordemail not like '%health.state.ny.us'
and c.email not like '%health.state.ny.us'
and s.userid=c.userid
and isNull(s.del, 0)=0
and isNull(s.endyear, '1/1/2040') > getdate()
<cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>
and tor.initnum in  (#ListQualify(Form.objective,"'")#)
</cfif>
<cfif isDefined("form.modality") and form.modality NEQ "ALL">
	and c.partnertype = <cfqueryparam value="#form.modality#" cfsqltype="CF_SQL_INTEGER">
	</cfif>
	and c.partnertype !=1 and c.partnertype !=4
	<cfif isdefined("form.cm") and form.cm is not 'all'>
	and c.userid in (select userid from contact where cmanager = <cfqueryparam value="#form.cm#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">)
</cfif>
<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
</cfif>
	UNION ALL
select
	case partnertype
when 1 then 'CC'
when 2 then 'CP'
when 3 then 'YP'
when 4 then 'SP'
when 5 then 'C4C'
else 'NA' end as modality,
c.orgname, grantnum as contractNum,
	'Smoke-free Media' as  initiative, 'Advocating with Organizational Decision-Makers' as strategy,
	case org
	when 999 then 'MPAA'
	when 888 then 'YouTube'
	when 777 then 'Major Television Network'
	else isNull(t.name, 'No data entered') end as name,
	tor.mon, m.mon,
	isNull(adcomm,0) as 'Education about the issue',
	isNull(prvtrain,0) as 'Education about policy solutions',
	isNull(techass,0) as 'Voiced support for policy'		, m.rank, getdate(),targdisp as dispar
	from
	security s, contact c
	left outer join monthly_org tor
	on c.userid=tor.userid
	and tor.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and tor.initnum='3m'
	and isnull(tor.stratnum,0) != 2
	and (isNull(adcomm,0)=1 OR isNull(prvtrain,0)=1 or isNull(techass,0)=1)
	left outer join  months m on tor.mon=m.mon_num
	and m.year2=tor.year2
	left join target_org t on tor.org = t.targid and tor.year2 = t.year2
	left join wrkplan_targets wt on t.targnum = wt.targetid and t.year2 = wt.year2
	where
	  c.partnertype in (2)
	  and tor.year2 >= 2015
and c.coordemail not like '%rti.org'
and c.email not like '%rti.org'
and c.coordemail not like '%health.state.ny.us'
and c.email not like '%health.state.ny.us'
and s.userid=c.userid
and isNull(s.del, 0)=0
and isNull(s.endyear, '1/1/2040') > getdate()
<cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>
and tor.initnum in (#ListQualify(Form.objective,"'")#)
</cfif>
<cfif isDefined("form.modality") and form.modality NEQ "ALL">
	and c.partnertype = <cfqueryparam value="#form.modality#" cfsqltype="CF_SQL_INTEGER">
	</cfif>
	and c.partnertype !=1 and c.partnertype !=4
	<cfif isdefined("form.cm") and form.cm is not 'all'>
	and c.userid in (select userid from contact where cmanager = <cfqueryparam value="#form.cm#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">)
</cfif>
<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
</cfif>
UNION ALL
		select
	case partnertype
when 1 then 'CC'
when 2 then 'CP'
when 3 then 'YP'
when 4 then 'SP'
when 5 then 'C4C'
else 'NA' end as modality,
c.orgname, grantnum as contractNum,
	'Smoke-free Multi-unit Housing' as  initiative, 'Government Policy-maker Education' as strategy,
	case org
	when 999 then 'MPAA'
	when 888 then 'YouTube'
	when 777 then 'Major Television Network'
	else isNull(t.name, 'No data entered') end as name,
	tor.mon, m.mon,
	isNull(nature1,0) as 'Education about the issue',
	isNull(nature2,0) as 'Education about policy solutions',
	isNull(nature3,0) as 'Voiced support for policy'	, m.rank	, getdate(),targdisp as dispar
	from
	security s, contact c
	left outer join monthly_org tor
	on  c.userid=tor.userid
		and tor.initnum='4f'
	and isnull(tor.stratnum,2) = 2
	and (isNull(nature1,0)=1 OR isNull(nature2,0)=1 or isNull(nature3,0)=1)
	left outer join months m
	on tor.mon=m.mon_num
	and m.year2=tor.year2
	left join target_org t on tor.org = t.targid and tor.year2 = t.year2
	left join wrkplan_targets wt on t.targnum = wt.targetid and t.year2 = wt.year2
	where
	 c.partnertype in (2)
	      and tor.year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	      and tor.year2 >= 2015
          and t.name is not null
and c.coordemail not like '%rti.org'
and c.email not like '%rti.org'
and c.coordemail not like '%health.state.ny.us'
and c.email not like '%health.state.ny.us'
and s.userid=c.userid
and isNull(s.del, 0)=0
<cfif isdefined("form.objective") and (NOT ListContainsNoCase(Form.objective,"all",","))>
and tor.initnum in  (#ListQualify(Form.objective,"'")#)
</cfif>
<cfif isDefined("form.modality") and form.modality NEQ "ALL">
	and c.partnertype = <cfqueryparam value="#form.modality#" cfsqltype="CF_SQL_INTEGER">
	</cfif>
	and c.partnertype !=1 and c.partnertype !=4
	<cfif isdefined("form.cm") and form.cm is not 'all'>
	and c.userid in (select userid from contact where cmanager = <cfqueryparam value="#form.cm#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">)
</cfif>
<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
</cfif>
order by
4, 5,
1,2,3,m.rank, 6
</cfquery>
			<cfif #session.fy# GTE '2015'>
				<cfreport template="./reports/ADV_GPME2015.cfr" format = "pdf"  query="pos">
					<cfset Year2less = #session.fy#-1>
					<cfset conperiod = #year2less# & '-' & #session.fy#>
					<CFREPORTPARAM name=fa VALUE=1>
					<CFREPORTPARAM name=Area VALUE="ALL">
					<CFREPORTPARAM name=modality VALUE="ALL">
					<CFREPORTPARAM name=FOCUSAREA VALUE="All">
					<CFREPORTPARAM name=Prognum VALUE="All">
					<CFREPORTPARAM name=Strategy VALUE="All">
					<CFREPORTPARAM name=ReportName VALUE="PP">
					<CFREPORTPARAM name=Monthrange VALUE="1">
					<cfif isdefined("form.modality") and #form.modality# is 1>
						<CFREPORTPARAM name=ModWrd VALUE="Cessation Center">
					<cfelseif isdefined("form.modality") and #form.modality# is 2>
						<CFREPORTPARAM name=ModWrd VALUE="ATFC">
					<cfelseif isdefined("form.modality") and #form.modality# is 3>
						<CFREPORTPARAM name=ModWrd VALUE="Reality Check">
					<cfelse>
						<CFREPORTPARAM name=ModWrd VALUE="All Modalities">
					</cfif>
					<CFREPORTPARAM name=Objval VALUE="#obj#">
					<CFREPORTPARAM name=Objective VALUE="All">
					<CFREPORTPARAM name=Initiative VALUE="All">
					<cfif isdefined("cm") and #cm# is not ''>
						<CFREPORTPARAM name=CM VALUE="#form.cm#">
					<cfelse>
						<CFREPORTPARAM name=CM VALUE="All">
					</cfif>
					<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">
					<CFREPORTPARAM name=Modality VALUE="#form.modality#">
					<CFREPORTPARAM name=lastyear VALUE=#Year2less#>
					<CFREPORTPARAM name=Year2 VALUE=#session.fy#>
				</cfreport>
			<cfelse>
				<cfreport template="./reports/ADV_GPME.cfr" format = "pdf"  query="pos">
					<cfset Year2less = #session.fy#-1>
					<cfset conperiod = #year2less# & '-' & #session.fy#>
					<CFREPORTPARAM name=fa VALUE=1>
					<CFREPORTPARAM name=Area VALUE="ALL">
					<CFREPORTPARAM name=modality VALUE="ALL">
					<CFREPORTPARAM name=FOCUSAREA VALUE="All">
					<CFREPORTPARAM name=Prognum VALUE="All">
					<CFREPORTPARAM name=Strategy VALUE="All">
					<CFREPORTPARAM name=ReportName VALUE="PP">
					<CFREPORTPARAM name=Monthrange VALUE="1">
					<cfif isdefined("form.modality") and #form.modality# is 1>
						<CFREPORTPARAM name=ModWrd VALUE="Cessation Center">
					<cfelseif isdefined("form.modality") and #form.modality# is 2>
						<CFREPORTPARAM name=ModWrd VALUE="ATFC">
					<cfelseif isdefined("form.modality") and #form.modality# is 3>
						<CFREPORTPARAM name=ModWrd VALUE="Reality Check">
					<cfelse>
						<CFREPORTPARAM name=ModWrd VALUE="All Modalities">
					</cfif>
					<CFREPORTPARAM name=Objval VALUE="#obj#">
					<CFREPORTPARAM name=Objective VALUE="All">
					<CFREPORTPARAM name=Initiative VALUE="All">
					<cfif isdefined("cm") and #cm# is not ''>
						<CFREPORTPARAM name=CM VALUE="#form.cm#">
					<cfelse>
						<CFREPORTPARAM name=CM VALUE="All">
					</cfif>
					<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">
					<CFREPORTPARAM name=Modality VALUE="#form.modality#">
					<CFREPORTPARAM name=lastyear VALUE=#Year2less#>
					<CFREPORTPARAM name=Year2 VALUE=#session.fy#>
				</cfreport>
			</cfif>
		</cfoutput>
	</cfcase>



	<!--  test of disp --->
<cfcase value="900">
<cfparam name="form.topic" default="ALL">

<cfset foo = createObject("component", "cfcs.ReportLog").logreport(reportid=900) />
<cfoutput>
			<cfparam name="form.Area" default="ALL">
			<cfparam name="form.Region" default="ALL">
			<cfparam name="form.fArea" default="ALL">
			<cfparam name="form.partner" default="ALL">

<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="conmon">

SELECT userid, orgname, dispartxt,othdisptxt,
LTRIM(RTRIM(m.n.value('.[1]','varchar(8000)'))) AS DispInit,

case LTRIM(RTRIM(m.n.value('.[1]','varchar(8000)')))
when '2D' then 'Point of Sale'
when '3M' then 'Smoke-free Media'
when '4F' then 'Smoke-free Multi-unit Housing'
when '2E' then 'Tobacco-free Outdoors'
when '8C' then 'Cessation Services and Media'
when '8A' then 'Medical Health Systems Change'
when '8B' then 'Mental Health Systems Change'
when '9x' then 'Other'
else ''
end as Topic,

case LTRIM(RTRIM(m.n.value('.[1]','varchar(8000)')))
when '9x' then 2 else 1 end as srtorder

FROM
(
SELECT c.userid, c.orgname, dispartxt,othdisptxt,CAST('<XMLRoot><RowData>' + REPLACE(DispInit,',','</RowData><RowData>') + '</RowData></XMLRoot>' AS XML) AS x
FROM   contact c left join wrkplan w  on c.userid = w.userid
where year2= 2018 and dispinit is not null and DispInit != ''
and c.coordemail not like '%rti.org'
and c.email not like '%rti.org'
and c.coordemail not like '%health.state.ny.us'
and c.email not like '%health.state.ny.us'
and c.userid not like 'test%'
--and c.partnertype in (1,6)
<cfif isdefined("form.cm") and form.cm is not 'all'>
	and c.userid in (select userid from contact where cmanager = <cfqueryparam value="#form.cm#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">)
</cfif>
<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
</cfif>

<cfif isDefined("form.modality") and form.modality NEQ "ALL" and form.modality NEQ "0">
	and c.partnertype = <cfqueryparam value="#form.modality#" cfsqltype="CF_SQL_INTEGER">
</cfif>
<cfif isDefined("form.mod")>
	and c.partnertype = <cfqueryparam value="#form.mod#" cfsqltype="CF_SQL_INTEGER">
</cfif>
)t
CROSS APPLY x.nodes('/XMLRoot/RowData')m(n)
<cfif form.topic DOES NOT CONTAIN "All">
where LTRIM(RTRIM(m.n.value('.[1]','varchar(8000)'))) in ('#replace(form.topic, ',', "','", "all")#')
</cfif>
order by 7,6,2,4
</cfquery>



<cfif form.topic contains "All">
	<cfset obj = "All">
<cfelse>
	<Cfset obj = "">

				<cfif form.topic contains "2d"><cfif len(obj) GT 1>Cfset obj = obj & ", "></cfif><Cfset obj = obj & "Point of Sale"></cfif>
				<cfif form.topic contains "3M"><cfif len(obj) GT 1><Cfset obj = obj &  ",Smoke-free Media"><cfelse><Cfset obj = "Smoke-free Media"></cfif></cfif>
				<cfif form.topic contains "4F"><cfif len(obj) GT 1><Cfset obj = obj &  ",Smoke-free Multi-unit Housing"><cfelse><Cfset obj = "Smoke-free Multi-unit Housing"></cfif></cfif>
				<cfif form.topic contains "2E"><cfif len(obj) GT 1><Cfset obj = obj &  ",Tobacco-free Outdoors"><cfelse><Cfset obj = "Tobacco-free Outdoors"></cfif></cfif>
				<cfif form.topic contains "8C"><cfif len(obj) GT 1><Cfset obj = obj &  ",Cessation Services and Media"><cfelse><Cfset obj = "Cessation Services and Media"></cfif></cfif>
				<cfif form.topic contains "8A"><cfif len(obj) GT 1><Cfset obj = obj &  ",Medical Health Systems Change"><cfelse><Cfset obj = "Medical Health Systems Change"></cfif></cfif>
				<cfif form.topic contains "8B"><cfif len(obj) GT 1><Cfset obj = obj &  ",Mental Health Systems Change"><cfelse><Cfset obj = "Mental Health Systems Change"></cfif></cfif>
				<cfif form.topic contains "9x"><cfif len(obj) GT 1><Cfset obj = obj &  ",Other"><cfelse><Cfset obj = "Other"></cfif></cfif>



</cfif>

<!---<option value="ALL"> All Topics
				<option value="2D"> Point of Sale
				<option value="3M"> Smoke-free Media
				<option value="4F"> Smoke-free Multi-unit Housing
				<option value="2E"> Tobacco-free Outdoors
				<option value="8C"> Cessation Services and Media
				<option value="8A"> Medical Health Systems Change
				<option value="8B"> Mental Health Systems Change
				<option value="9x'"> Other
--->

	<cfreport template="./reports/disp.cfr"  format = "pdf" query="conmon">




				<cfif isdefined("obj") and #obj# is not ''>
					<CFREPORTPARAM name=Objval VALUE="#obj#">
				<cfelse>
					<CFREPORTPARAM name=Objval VALUE="All">
				</cfif>
				<CFREPORTPARAM name=Year2 VALUE=#session.fy#>
				<CFREPORTPARAM name=userid VALUE="ALL">






				<CFREPORTPARAM name=StMonth VALUE="#form.stmonth#">
				<CFREPORTPARAM name=endMonth VALUE="#form.endmonth#">


					<cfif (isdefined("form.modality") and #form.modality# is 1) or (isdefined("form.mod") and #form.mod# is 1)>
						<CFREPORTPARAM name=ModWrd VALUE="Health Systems Change">
					<cfelseif isdefined("form.modality") and #form.modality# is 2 or (isdefined("form.mod") and #form.mod# is 2)>
						<CFREPORTPARAM name=ModWrd VALUE="ATFC">
					<cfelseif isdefined("form.modality") and #form.modality# is 3>
						<CFREPORTPARAM name=ModWrd VALUE="Reality Check">
					<cfelseif isdefined("form.modality") and #form.modality# is 5>
						<CFREPORTPARAM name=ModWrd VALUE="Colleges for Change">
					<cfelse>
						<CFREPORTPARAM name=ModWrd VALUE="All Modalities">
					</cfif>

				<cfif isdefined("cm") and #cm# is not ''>
						<CFREPORTPARAM name=CM VALUE="#form.cm#">
					<cfelse>
						<CFREPORTPARAM name=CM VALUE="All">
					</cfif>
				<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">
				<CFREPORTPARAM name=modality VALUE="#form.modality#">
				<CFREPORTPARAM name=Obj VALUE="#obj#">

				<CFREPORTPARAM name=Monthrange VALUE="#Monthrange#">


				<!---

				<CFREPORTPARAM name=Area VALUE="ALL">
				<CFREPORTPARAM name=FOCUSAREA VALUE="All">
				<CFREPORTPARAM name=Prognum VALUE="All">
				<CFREPORTPARAM name=Obj VALUE="All">
				<CFREPORTPARAM name=Objective VALUE="All">
				<CFREPORTPARAM name=Strategy VALUE="All">
				<CFREPORTPARAM name=ReportName VALUE="PP">
				<CFREPORTPARAM name=stYear VALUE="2007">
				<CFREPORTPARAM name=endYr VALUE="2007">
				--->



		</cfreport>

		</cfoutput>
	</cfcase>
<cfcase value="901">
<cfparam name="form.topic" default="ALL">

<cfset foo = createObject("component", "cfcs.ReportLog").logreport(reportid=900) />
<cfoutput>
			<cfparam name="form.Area" default="ALL">
			<cfparam name="form.Region" default="ALL">
			<cfparam name="form.fArea" default="ALL">
			<cfparam name="form.partner" default="ALL">

<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="conmon">

select 1 as grp,ltrim(orgname) as orgname,name,units,m.mon,dt,hud_notes,county,rank,getdate() as rundt
from contact c inner join hud h on c.userid = h.userid right outer join pha p on hud_target = phaid 
left outer join months m
	on h.mon=m.mon_num
	and m.year2=h.year2
where h.year2 = #session.fy# and orgname not in ('nikie') and orgname not like 'test%'
<cfif isdefined("form.cm") and form.cm is not 'all'>
	and c.userid in (select userid from contact where cmanager = <cfqueryparam value="#form.cm#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">)
</cfif>
<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid=<cfqueryparam value="#form.partner#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
</cfif>

<cfif isDefined("form.mod")>
	and c.partnertype = <cfqueryparam value="#form.mod#" cfsqltype="CF_SQL_INTEGER">
</cfif>
	and m.rank >= <cfqueryparam value="#form.stmonth#" cfsqltype="CF_SQL_INTEGER">
	and m.rank <= <cfqueryparam value="#form.endmonth#" cfsqltype="CF_SQL_INTEGER">
order by 2,9,3
</cfquery>
<cfif #form.modality# neq 1>
	<cfreport template="./reports/hud.cfr"  format = "pdf" query="conmon">
				<CFREPORTPARAM name=Year2 VALUE=#session.fy#>
					<CFREPORTPARAM name=Area VALUE="#form.region#">
					<CFREPORTPARAM name=modality VALUE="ALL">
					<CFREPORTPARAM name=FOCUSAREA VALUE="All">
					<CFREPORTPARAM name=Prognum VALUE="All">
					<cfif isdefined("obj") and #obj# is not '' and #obj# NEQ "()">
						<CFREPORTPARAM name=Obj VALUE="#obj#">
					<cfelse>
						<CFREPORTPARAM name=Obj VALUE="All">
					</cfif>
					<cfif isdefined("form.objective")>
						<CFREPORTPARAM name=Objective VALUE="#form.objective#">
					<cfelse>
						<CFREPORTPARAM name=Objective VALUE="All">
					</cfif>
					<CFREPORTPARAM name=Strategy VALUE="All">
					<CFREPORTPARAM name=ReportName VALUE="PP">
					<CFREPORTPARAM name=StMonth VALUE="#form.stmonth#">
					<CFREPORTPARAM name=endMonth VALUE="#form.endmonth#">
					<CFREPORTPARAM name=stYear VALUE="2007">
					<CFREPORTPARAM name=endYr VALUE="2007">
					<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">
					<CFREPORTPARAM name=Modality VALUE="#form.modality#">
					<cfif isdefined("form.modality") and #form.modality# is 1>
						<CFREPORTPARAM name=ModWrd VALUE="Cessation Center">
					<cfelseif isdefined("form.modality") and #form.modality# is 2>
						<CFREPORTPARAM name=ModWrd VALUE="ATFC">
					<cfelseif isdefined("form.modality") and #form.modality# is 3>
						<CFREPORTPARAM name=ModWrd VALUE="Reality Check">
					<cfelseif isdefined("form.modality") and #form.modality# is 5>
						<CFREPORTPARAM name=ModWrd VALUE="Colleges for Change">
					<cfelse>
						<CFREPORTPARAM name=ModWrd VALUE="All Modalities">
					</cfif>
					<CFREPORTPARAM name=Monthrange VALUE="#Monthrange#">
									<cfif isdefined("cms") and #cms# is not ''>
					<CFREPORTPARAM name=CM VALUE="#cms#">
				<cfelse>
					<CFREPORTPARAM name=CM VALUE="All">
				</cfif>
		</cfreport>
		<cfelse>
		<cfreport template="./reports/hudcc.cfr"  format = "pdf" query="conmon">
				<CFREPORTPARAM name=Year2 VALUE=#session.fy#>
					<CFREPORTPARAM name=Area VALUE="#form.region#">
					<CFREPORTPARAM name=modality VALUE="ALL">
					<CFREPORTPARAM name=FOCUSAREA VALUE="All">
					<CFREPORTPARAM name=Prognum VALUE="All">
					<cfif isdefined("obj") and #obj# is not '' and #obj# NEQ "()">
						<CFREPORTPARAM name=Obj VALUE="#obj#">
					<cfelse>
						<CFREPORTPARAM name=Obj VALUE="All">
					</cfif>
					<cfif isdefined("form.objective")>
						<CFREPORTPARAM name=Objective VALUE="#form.objective#">
					<cfelse>
						<CFREPORTPARAM name=Objective VALUE="All">
					</cfif>
					<CFREPORTPARAM name=Strategy VALUE="All">
					<CFREPORTPARAM name=ReportName VALUE="PP">
					<CFREPORTPARAM name=StMonth VALUE="#form.stmonth#">
					<CFREPORTPARAM name=endMonth VALUE="#form.endmonth#">
					<CFREPORTPARAM name=stYear VALUE="2007">
					<CFREPORTPARAM name=endYr VALUE="2007">
					<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">
					<CFREPORTPARAM name=Modality VALUE="#form.modality#">
					<cfif isdefined("form.modality") and #form.modality# is 1>
						<CFREPORTPARAM name=ModWrd VALUE="Cessation Center">
					<cfelseif isdefined("form.modality") and #form.modality# is 2>
						<CFREPORTPARAM name=ModWrd VALUE="ATFC">
					<cfelseif isdefined("form.modality") and #form.modality# is 3>
						<CFREPORTPARAM name=ModWrd VALUE="Reality Check">
					<cfelseif isdefined("form.modality") and #form.modality# is 5>
						<CFREPORTPARAM name=ModWrd VALUE="Colleges for Change">
					<cfelse>
						<CFREPORTPARAM name=ModWrd VALUE="All Modalities">
					</cfif>
					<CFREPORTPARAM name=Monthrange VALUE="#Monthrange#">
									<cfif isdefined("cms") and #cms# is not ''>
					<CFREPORTPARAM name=CM VALUE="#cms#">
				<cfelse>
					<CFREPORTPARAM name=CM VALUE="All">
				</cfif>
		</cfreport>
		</cfif>
		</cfoutput>
	</cfcase>




</cfswitch>
