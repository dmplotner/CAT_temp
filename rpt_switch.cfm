<!--- <cfif NOT(session.areamanage EQ 1 or session.cessman EQ 1 or session.admin EQ 1) AND
	(form.rptType EQ "50"  )>
	<cflocation url="unavailable.cfm" addtoken="yes">
</cfif> --->




<!--- <cfif session.modality EQ 4>
	<cfset session.rptmode = "spMode">
<cfelse> --->
	<cfset session.rptmode = "main">
<!--- </cfif> --->
<cfif isDefined("form.farea") and form.farea CONTAINS "ALL">
	<cfset form.farea = "ALL">
</cfif>

<cfif isDefined("form.modality")>
	<cfif form.modality EQ "1">
		<cfset rptmodality = "Cessation Centers">
	<cfelseif form.modality EQ "2">
		<cfset rptmodality = "Community Partnerships">
	<cfelseif form.modality EQ "3">
		<cfset rptmodality = "Youth Partners">
	<cfelse>
		<cfset rptmodality = "ALL">
	</cfif>
<cfelse>
		<cfset rptmodality = "ALL">
</cfif>
<cfset modality_rank = "rank">

<cfif isDefined("form.stmonth") and #form.rpttype# is not 17>
<cfquery datasource="#Application.DataSource#"  		 
	password="#Application.db_password#"  		
	username="#Application.db_username#" name="Qstmn">
	select rank, mon_num
	from months 
	where rank=#form.stmonth# and year2 = #session.fy#
	order by 1
</cfquery>

<cfquery datasource="#Application.DataSource#"  		 
	password="#Application.db_password#"  		
	username="#Application.db_username#" name="Qendmn">
	select rank, mon_num
	from months 
	where rank=#form.endmonth# and year2 = #session.fy#
	order by 1
</cfquery>

	
<cfquery datasource="#Application.DataSource#"  		 
	password="#Application.db_password#"  		
	username="#Application.db_username#" name="Qmonlist">
	select mon
	from months 
	where rank between #Qstmn.rank# and  #Qendmn.rank#  and year2 = #session.fy#
	order by rank
</cfquery>

<cfset monthrange="(#quotedValueList(QMonlist.Mon, "~,~")#)">
<!--- <cfset obj="(#quotedValueList(form.objective, "~,~")#)">
 ---><cfset monthrange2="#quotedValueList(QMonlist.Mon)#">
<cfset monthrange=replace(monthrange,"('", "(~~")>
<cfset monthrange=replace(monthrange,"')", "~~)")>
<cfset monthrange=rereplace(monthrange,"'", "~", "all")>
<cfset monthrange3=rereplace(monthrange2,"'", "", "all")>
<cfset monthrange6="#ValueList(QMonlist.Mon)#">
</cfif>

<cfset rptfy="#session.fy#">

<cfif NOT isDefined("form.rptType")>
	<cflocation url="reporthandler_mod.cfm" addtoken="yes">
</cfif>


<!--- <cfoutput>#monthrange#</cfoutput><cfabort> --->
<cfswitch expression = "#form.rptType#">
	<!--- <cfcase value = 1><!--- Focus Area One --->
		<cfinclude template="rpt_fa_wrapper.cfm">
	</cfcase> --->
	
	<cfcase value = 2><!--- workplan summary --->
		<!--- <cfinclude template="rpt1.cfm"> --->
		<cfparam name="session.fy" default="2005">
		<cfparam name="form.Area" default="ALL">
		<cfparam name="form.Objective" default="ALL">
		<cfparam name="form.fArea" default="ALL">
		<cfparam name="form.region" default="ALL">
		<cfparam name="form.goal" default="ALL">
		<cfparam name="form.partner" default="ALL">
		<cfparam name="form.strategy" default="ALL">
		
		<cfinclude template="qry_report_filter.cfm">
		
	<cfquery datasource="#Application.DataSource#"  		 
	password="#Application.db_password#"  		
	username="#Application.db_username#" name="Qwp">
SELECT DISTINCT 
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1)
 	WHEN '*' THEN 'Joint Partner Strategies' ELSE ORGNAME END ORGNAME ,
U.GOAL AS GOALID, 
U.OBJECTIVE AS OBJECTIVEID,
S.STRATEGY_NUM AS STRATEGY_NUM,
S.STRATEGY AS STRATEGY,
P.PROGRAM AS GOAL,
O.OBJECTIVE AS OBJECTIVE,
U.ACTIVITY,
LTRIM(RTRIM(CAST(U.OUTCOME AS VARCHAR(4000))))  as outcome,
STARTDATE,
ENDDATE,
LTRIM(RTRIM(CAST(U.ACTIVITYNAME AS VARCHAR(4000)))) as activityname
FROM 
STRATEGY AS S,
PROGRAM AS P,
OBJECTIVES AS O,
USERACTIVITIES AS U
left outer join CONTACT C on u.USERID=c.USERID
WHERE U.STRATEGY=S.STRATEGY_NUM
AND P.PROGNUM=U.GOAL
AND O.ID=U.OBJECTIVE 
AND U.YEAR2=S.YEAR2
AND U.YEAR2=P.YEAR2
AND U.YEAR2=O.YEAR2
AND (U.DEL IS NULL OR U.DEL !='Y')AND  u.year2 =#session.fy#
<cfinclude template="report_filter.cfm">
</cfquery>		
		<cfoutput>
		<cfreport template="./reports/workplan.cfr" format = "#form.format#" query="Qwp">
		
		<CFREPORTPARAM name=Area VALUE=#form.region#>
		<CFREPORTPARAM name=Objective VALUE=#form.objective#>
		<CFREPORTPARAM name=FocusArea VALUE="#form.farea#">
		<CFREPORTPARAM name=Strategy VALUE="#form.strategy#">
		<CFREPORTPARAM name=Prognum VALUE="#form.goal#">
		<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">		
		<CFREPORTPARAM name=Year2 VALUE="#rptfy#">
		<CFREPORTPARAM name=ReportName VALUE="workplan">
		<CFREPORTPARAM name=modality VALUE="#rptmodality#">
		 </cfreport>
		 </cfoutput>
	</cfcase>
	
	<cfcase value = 4><!--- Focus Area One --->

                        <cfparam name="session.fy" default="2005">
                        <cfparam name="form.Area" default="ALL">
						<cfparam name="form.Region" default="ALL">
                        <cfparam name="form.Objective" default="ALL">
                        <cfparam name="form.fArea" default="ALL">
                        <cfparam name="form.goal" default="ALL">
                        <cfparam name="form.partner" default="ALL">
                        <cfparam name="form.strategy" default="ALL"> 
						<cfinclude template="qry_earnedmedia.cfm">

                        <cfreport template="./reports/earnedmedia.cfr" format = "#form.format#" query="QEarnedMedia">

                        <CFREPORTPARAM name=Area VALUE=#form.region#>
                        <CFREPORTPARAM name=Objective VALUE=#form.objective#>
                        <CFREPORTPARAM name=FocusArea VALUE="#form.farea#">
                        <CFREPORTPARAM name=Strategy VALUE="#form.strategy#">
                        <CFREPORTPARAM name=Prognum VALUE="#form.goal#">
                        <CFREPORTPARAM name=PartnerName VALUE="#form.partner#">
                        <CFREPORTPARAM name=Year2 VALUE="#rptfy#">
						<CFREPORTPARAM name=ReportName VALUE="progress">
						<CFREPORTPARAM name=Monthrange VALUE="#Monthrange3#">
						<CFREPORTPARAM name=modality VALUE="#rptmodality#">
                        </cfreport>

            </cfcase>


	
	<cfcase value = 99>
		<!--- <cfcase value = 6> --->
	
		

<cfparam name="session.fy" default="2005">
<cfparam name="form.stMonth" default="all">
<cfparam name="form.endmonth" default="all">
<cfparam name="form.Area" default="ALL">
<cfparam name="form.Region" default="ALL">
<cfparam name="form.Objective" default="ALL">
<cfparam name="form.fArea" default="ALL">
<cfparam name="form.goal" default="ALL">
<cfparam name="form.partner" default="ALL">
<cfparam name="form.strategy" default="ALL">


<cfinclude template="qry_report_filter.cfm">

<cfquery datasource="#Application.DataSource#"  		 
	password="#Application.db_password#"  		
	username="#Application.db_username#" name="Qsummary">
SELECT  distinct
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1) 	
WHEN  '*' THEN  'JOINT' 
<!--- ELSE (SELECT AR.AREA FROM AREA AR WHERE AR.NUM = C.AREA AND AR.YEAR2='2007' )  END AREA , --->
ELSE (SELECT r.region FROM AREA AR, region R WHERE R.NUM=AR.REGION and AR.NUM = C.AREA AND R.year2=ar.year2 and AR.YEAR2='2007' )  END AREA ,
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1)
WHEN '*' THEN 'SHARED'
ELSE ORGNAME END ORGNAME ,
U.ACTIVITY STRATEGY, LTRIM(RTRIM(CAST(U.ACTIVITYNAME AS VARCHAR(4000)))) STRATEGY_DESCRIPTION, A.MONTH2,
P.PROGRAM  GOAL, O.OBJECTIVE, U.STARTDATE, U.ENDDATE,
A.BARRIERS, A.SUCCESS, A.PROGRESS, m.rank, 
	'' as progress_2, '' as progress_3, '' as progress_4, '' as progress_5,
	'' as success_2, '' as success_3, '' as success_4, '' as success_5,
	'' as barriers_2, '' as barriers_3, '' as barriers_4, '' as barriers_5
FROM  PROGRAM  P, OBJECTIVES O,  ADVOC A, MONTHS M, USERACTIVITIES U
left outer join contact as c on 
u.userid=c.userid
	WHERE   U.GOAL=P.PROGNUM AND U.YEAR2=P.YEAR2
 	AND U.OBJECTIVE=O.[ID]AND U.YEAR2=O.YEAR2
 	AND A.YEAR2 = U.YEAR2 AND U.USERID=A.USERID
	AND U.ACTIVITY=A.ACTIVITY
	AND A.MONTH2=M.MON  and a.year2=m.year2
and u.year2=#session.fy#
AND (U.DEL IS NULL OR U.DEL != 'Y') AND U.STRATEGY=9 AND A.BARRIERS IS NOT NULL 
<cfinclude template="report_filter.cfm">
UNION
SELECT  distinct
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1) 	
WHEN  '*' THEN  'JOINT' 
<!--- ELSE (SELECT AR.AREA FROM AREA AR WHERE AR.NUM = C.AREA AND AR.YEAR2='2007' )  END AREA , --->
ELSE (SELECT r.region FROM AREA AR, region R WHERE R.NUM=AR.REGION and AR.NUM = C.AREA AND R.year2=ar.year2 and AR.YEAR2='2007' )  END AREA ,
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1)
WHEN '*' THEN 'SHARED'
ELSE ORGNAME END ORGNAME ,
U.ACTIVITY STRATEGY, LTRIM(RTRIM(CAST(U.ACTIVITYNAME AS VARCHAR(4000)))) STRATEGY_DESCRIPTION, A.MONTH2,
P.PROGRAM  GOAL, O.OBJECTIVE, U.STARTDATE, U.ENDDATE,
A.BARRIERS, A.SUCCESS, A.PROGRESS, m.rank, 
	'' as progress_2, '' as progress_3, '' as progress_4, '' as progress_5,
	'' as success_2, '' as success_3, '' as success_4, '' as success_5,
	'' as barriers_2, '' as barriers_3, '' as barriers_4, '' as barriers_5
FROM  PROGRAM  P, OBJECTIVES O,  GOVT A, MONTHS M, USERACTIVITIES U
left outer join contact as c on 
u.userid=c.userid
	WHERE   U.GOAL=P.PROGNUM AND U.YEAR2=P.YEAR2
 	AND U.OBJECTIVE=O.[ID]AND U.YEAR2=O.YEAR2
 	AND A.YEAR2 = U.YEAR2 AND U.USERID=A.USERID
	AND U.ACTIVITY=A.ACTIVITY
	AND A.MONTH2=M.MON and a.year2 = m.year2
and u.year2=#session.fy#
AND (U.DEL IS NULL OR U.DEL != 'Y') AND U.STRATEGY=1 AND A.BARRIERS IS NOT NULL 
<cfinclude template="report_filter.cfm">
UNION
SELECT  distinct
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1) 	
WHEN  '*' THEN  'JOINT' 
<!--- ELSE (SELECT AR.AREA FROM AREA AR WHERE AR.NUM = C.AREA AND AR.YEAR2='2007' )  END AREA , --->
ELSE (SELECT r.region FROM AREA AR, region R WHERE R.NUM=AR.REGION and AR.NUM = C.AREA AND R.year2=ar.year2 and AR.YEAR2='2007' )  END AREA ,
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1)
WHEN '*' THEN 'SHARED'
ELSE ORGNAME END ORGNAME ,
U.ACTIVITY STRATEGY, LTRIM(RTRIM(CAST(U.ACTIVITYNAME AS VARCHAR(4000)))) STRATEGY_DESCRIPTION, A.MONTH2,
P.PROGRAM  GOAL, O.OBJECTIVE, U.STARTDATE, U.ENDDATE,
A.BARRIERS, A.SUCCESS, A.PROGRESS, m.rank, 
	'' as progress_2, '' as progress_3, '' as progress_4, '' as progress_5,
	'' as success_2, '' as success_3, '' as success_4, '' as success_5,
	'' as barriers_2, '' as barriers_3, '' as barriers_4, '' as barriers_5
FROM  PROGRAM  P, OBJECTIVES O,  PAIDMEDIA A, MONTHS M, USERACTIVITIES U
left outer join contact as c on 
u.userid=c.userid
	WHERE   U.GOAL=P.PROGNUM AND U.YEAR2=P.YEAR2
 	AND U.OBJECTIVE=O.[ID]AND U.YEAR2=O.YEAR2
 	AND A.YEAR2 = U.YEAR2 AND U.USERID=A.USERID
	AND U.ACTIVITY=A.ACTIVITY
	AND A.MONTH2=M.MON and a.year2=m.year2
and u.year2=#session.fy#
AND (U.DEL IS NULL OR U.DEL != 'Y') AND U.STRATEGY=2 AND A.BARRIERS IS NOT NULL 
<cfinclude template="report_filter.cfm">
UNION
SELECT  distinct
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1) 	
WHEN  '*' THEN  'JOINT' 
<!--- ELSE (SELECT AR.AREA FROM AREA AR WHERE AR.NUM = C.AREA AND AR.YEAR2='2007' )  END AREA , --->
ELSE (SELECT r.region FROM AREA AR, region R WHERE R.NUM=AR.REGION and AR.NUM = C.AREA AND R.year2=ar.year2 and AR.YEAR2='2007' )  END AREA ,
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1)
WHEN '*' THEN 'SHARED'
ELSE ORGNAME END ORGNAME ,
U.ACTIVITY STRATEGY, LTRIM(RTRIM(CAST(U.ACTIVITYNAME AS VARCHAR(4000)))) STRATEGY_DESCRIPTION, A.MONTH2,
P.PROGRAM  GOAL, O.OBJECTIVE, U.STARTDATE, U.ENDDATE,
A.BARRIERS, A.SUCCESS, A.PROGRESS, m.rank, 
	'' as progress_2, '' as progress_3, '' as progress_4, '' as progress_5,
	'' as success_2, '' as success_3, '' as success_4, '' as success_5,
	'' as barriers_2, '' as barriers_3, '' as barriers_4, '' as barriers_5
FROM  PROGRAM  P, OBJECTIVES O,  FORUM A, MONTHS M, USERACTIVITIES U
left outer join contact as c on 
u.userid=c.userid
	WHERE   U.GOAL=P.PROGNUM AND U.YEAR2=P.YEAR2
 	AND U.OBJECTIVE=O.[ID]AND U.YEAR2=O.YEAR2
 	AND A.YEAR2 = U.YEAR2 AND U.USERID=A.USERID
	AND U.ACTIVITY=A.ACTIVITY
	AND A.MONTH2=M.MON and a.year2=m.year2
and u.year2=#session.fy#
AND (U.DEL IS NULL OR U.DEL != 'Y') AND U.STRATEGY=4 AND A.BARRIERS IS NOT NULL 
<cfinclude template="report_filter.cfm">
UNION
SELECT  distinct
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1) 	
WHEN  '*' THEN  'JOINT' 
<!--- ELSE (SELECT AR.AREA FROM AREA AR WHERE AR.NUM = C.AREA AND AR.YEAR2='2007' )  END AREA , --->
ELSE (SELECT r.region FROM AREA AR, region R WHERE R.NUM=AR.REGION and AR.NUM = C.AREA AND R.year2=ar.year2 and AR.YEAR2='2007' )  END AREA ,
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1)
WHEN '*' THEN 'SHARED'
ELSE ORGNAME END ORGNAME ,
U.ACTIVITY STRATEGY, LTRIM(RTRIM(CAST(U.ACTIVITYNAME AS VARCHAR(4000)))) STRATEGY_DESCRIPTION, A.MONTH2,
P.PROGRAM  GOAL, O.OBJECTIVE, U.STARTDATE, U.ENDDATE,
A.BARRIERS, A.SUCCESS, A.PROGRESS, m.rank, 
	'' as progress_2, '' as progress_3, '' as progress_4, '' as progress_5,
	'' as success_2, '' as success_3, '' as success_4, '' as success_5,
	'' as barriers_2, '' as barriers_3, '' as barriers_4, '' as barriers_5
FROM  PROGRAM  P, OBJECTIVES O,  MONITOR A, MONTHS M, USERACTIVITIES U
left outer join contact as c on 
u.userid=c.userid
	WHERE   U.GOAL=P.PROGNUM AND U.YEAR2=P.YEAR2
 	AND U.OBJECTIVE=O.[ID]AND U.YEAR2=O.YEAR2
 	AND A.YEAR2 = U.YEAR2 AND U.USERID=A.USERID
	AND U.ACTIVITY=A.ACTIVITY
	AND A.MONTH2=M.MON and a.year2=m.year2
and u.year2=#session.fy#
AND (U.DEL IS NULL OR U.DEL != 'Y') AND U.STRATEGY=5 AND A.BARRIERS IS NOT NULL 
<cfinclude template="report_filter.cfm">
UNION
SELECT  distinct
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1) 	
WHEN  '*' THEN  'JOINT' 
<!--- ELSE (SELECT AR.AREA FROM AREA AR WHERE AR.NUM = C.AREA AND AR.YEAR2='2007' )  END AREA , --->
ELSE (SELECT r.region FROM AREA AR, region R WHERE R.NUM=AR.REGION and AR.NUM = C.AREA AND R.year2=ar.year2 and AR.YEAR2='2007' )  END AREA ,
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1)
WHEN '*' THEN 'SHARED'
ELSE ORGNAME END ORGNAME ,
U.ACTIVITY STRATEGY, LTRIM(RTRIM(CAST(U.ACTIVITYNAME AS VARCHAR(4000)))) STRATEGY_DESCRIPTION, A.MONTH2,
P.PROGRAM  GOAL, O.OBJECTIVE, U.STARTDATE, U.ENDDATE,
A.BARRIERS, A.SUCCESS, A.PROGRESS, m.rank, 
	'' as progress_2, '' as progress_3, '' as progress_4, '' as progress_5,
	'' as success_2, '' as success_3, '' as success_4, '' as success_5,
	'' as barriers_2, '' as barriers_3, '' as barriers_4, '' as barriers_5
FROM  PROGRAM  P, OBJECTIVES O,  SURVEYPUB A, MONTHS M, USERACTIVITIES U
left outer join contact as c on 
u.userid=c.userid
	WHERE   U.GOAL=P.PROGNUM AND U.YEAR2=P.YEAR2
 	AND U.OBJECTIVE=O.[ID]AND U.YEAR2=O.YEAR2
 	AND A.YEAR2 = U.YEAR2 AND U.USERID=A.USERID
	AND U.ACTIVITY=A.ACTIVITY
	AND A.MONTH2=M.MON and a.year2 = m.year2
and u.year2=#session.fy#
AND (U.DEL IS NULL OR U.DEL != 'Y') AND U.STRATEGY=6 AND A.BARRIERS IS NOT NULL 
<cfinclude template="report_filter.cfm">
UNION
SELECT  distinct
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1) 	
WHEN  '*' THEN  'JOINT' 
<!--- ELSE (SELECT AR.AREA FROM AREA AR WHERE AR.NUM = C.AREA AND AR.YEAR2='2007' )  END AREA , --->
ELSE (SELECT r.region FROM AREA AR, region R WHERE R.NUM=AR.REGION and AR.NUM = C.AREA AND R.year2=ar.year2 and AR.YEAR2='2007' )  END AREA ,
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1)
WHEN '*' THEN 'SHARED'
ELSE ORGNAME END ORGNAME ,
U.ACTIVITY STRATEGY, LTRIM(RTRIM(CAST(U.ACTIVITYNAME AS VARCHAR(4000)))) STRATEGY_DESCRIPTION, A.MONTH2,
P.PROGRAM  GOAL, O.OBJECTIVE, U.STARTDATE, U.ENDDATE,
A.BARRIERS, A.SUCCESS, A.PROGRESS, m.rank, 
	'' as progress_2, '' as progress_3, '' as progress_4, '' as progress_5,
	'' as success_2, '' as success_3, '' as success_4, '' as success_5,
	'' as barriers_2, '' as barriers_3, '' as barriers_4, '' as barriers_5
FROM  PROGRAM  P, OBJECTIVES O,  CESSATION A, MONTHS M, USERACTIVITIES U
left outer join contact as c on 
u.userid=c.userid
	WHERE   U.GOAL=P.PROGNUM AND U.YEAR2=P.YEAR2
 	AND U.OBJECTIVE=O.[ID]AND U.YEAR2=O.YEAR2
 	AND A.YEAR2 = U.YEAR2 AND U.USERID=A.USERID
	AND U.ACTIVITY=A.ACTIVITY
	AND A.MONTH2=M.MON and a.year2 = m.year2
and u.year2=#session.fy#
AND (U.DEL IS NULL OR U.DEL != 'Y') AND U.STRATEGY=7 AND A.BARRIERS IS NOT NULL 
<cfinclude template="report_filter.cfm">
UNION
SELECT  distinct
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1) 	
WHEN  '*' THEN  'JOINT' 
<!--- ELSE (SELECT AR.AREA FROM AREA AR WHERE AR.NUM = C.AREA AND AR.YEAR2='2007' )  END AREA , --->
ELSE (SELECT r.region FROM AREA AR, region R WHERE R.NUM=AR.REGION and AR.NUM = C.AREA AND R.year2=ar.year2 and AR.YEAR2='2007' )  END AREA ,
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1)
WHEN '*' THEN 'SHARED'
ELSE ORGNAME END ORGNAME ,
U.ACTIVITY STRATEGY, LTRIM(RTRIM(CAST(U.ACTIVITYNAME AS VARCHAR(4000)))) STRATEGY_DESCRIPTION, A.MONTH2,
P.PROGRAM  GOAL, O.OBJECTIVE, U.STARTDATE, U.ENDDATE,
A.BARRIERS, A.SUCCESS, A.PROGRESS, m.rank, 
	'' as progress_2, '' as progress_3, '' as progress_4, '' as progress_5,
	'' as success_2, '' as success_3, '' as success_4, '' as success_5,
	'' as barriers_2, '' as barriers_3, '' as barriers_4, '' as barriers_5
FROM  PROGRAM  P, OBJECTIVES O,  ADVOC A, MONTHS M, USERACTIVITIES U
left outer join contact as c on 
u.userid=c.userid
	WHERE   U.GOAL=P.PROGNUM AND U.YEAR2=P.YEAR2
 	AND U.OBJECTIVE=O.[ID]AND U.YEAR2=O.YEAR2
 	AND A.YEAR2 = U.YEAR2 AND U.USERID=A.USERID
	AND U.ACTIVITY=A.ACTIVITY
	AND A.MONTH2=M.MON and a.year2 = m.year2
and u.year2=#session.fy#
AND (U.DEL IS NULL OR U.DEL != 'Y') AND U.STRATEGY=9 AND A.BARRIERS IS NOT NULL 
<cfinclude template="report_filter.cfm">
UNION
SELECT  distinct
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1) 	
WHEN  '*' THEN  'JOINT' 
<!--- ELSE (SELECT AR.AREA FROM AREA AR WHERE AR.NUM = C.AREA AND AR.YEAR2='2007' )  END AREA , --->
ELSE (SELECT r.region FROM AREA AR, region R WHERE R.NUM=AR.REGION and AR.NUM = C.AREA AND R.year2=ar.year2 and AR.YEAR2='2007' )  END AREA ,
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1)
WHEN '*' THEN 'SHARED'
ELSE ORGNAME END ORGNAME ,
U.ACTIVITY STRATEGY, LTRIM(RTRIM(CAST(U.ACTIVITYNAME AS VARCHAR(4000)))) STRATEGY_DESCRIPTION, A.MONTH2,
P.PROGRAM  GOAL, O.OBJECTIVE, U.STARTDATE, U.ENDDATE,
A.BARRIERS, A.SUCCESS, A.PROGRESS, m.rank, 
	isnull(progress_2, '') as progress_2, 
	isnull(progress_3, '') as progress_3, 
	isnull(progress_4, '') as progress_4, 
	isnull(progress_5, '') as progress_5,
	isnull(success_2, '') as success_2, 
	isnull(success_3, '') as success_3, 
	isnull(success_4, '') as success_4, 
	isnull(success_5, '') as success_5,
	isnull(barriers_2, '') as barriers_2, 
	isnull(barriers_3, '') as barriers_3, 
	isnull(barriers_4, '') as barriers_4, 
	isnull(barriers_5, '') as barriers_5
FROM  PROGRAM  P, OBJECTIVES O,  ADVOC A, MONTHS M, USERACTIVITIES U
left outer join contact as c on 
u.userid=c.userid
	WHERE   U.GOAL=P.PROGNUM AND U.YEAR2=P.YEAR2
 	AND U.OBJECTIVE=O.[ID]AND U.YEAR2=O.YEAR2
 	AND A.YEAR2 = U.YEAR2 AND U.USERID=A.USERID
	AND U.ACTIVITY=A.ACTIVITY
	AND A.MONTH2=M.MON  and a.year2 = m.year2
and u.year2=#session.fy#
and (U.DEL IS NULL OR U.DEL != 'Y') AND U.STRATEGY=8 AND (A.BARRIERS IS NOT NULL 
	OR A.PROGRESS_2 IS NOT NULL OR A.PROGRESS_3 IS NOT NULL OR A.PROGRESS_4 IS NOT NULL OR A.PROGRESS_5 IS NOT NULL
	OR A.SUCCESS_2 IS NOT NULL OR A.SUCCESS_3 IS NOT NULL OR A.SUCCESS_4 IS NOT NULL OR A.SUCCESS_5 IS NOT NULL
	OR A.BARRIERS_2 IS NOT NULL OR A.BARRIERS_3 IS NOT NULL OR A.BARRIERS_4 IS NOT NULL OR A.BARRIERS_5 IS NOT NULL
	)
<cfinclude template="report_filter.cfm">
order by 1, 2, 3, 13
</cfquery>








<!--- 		<cflocation addtoken="yes" url="http://nytobaccodev.rti.org/reports/stratprogsummary.cfr?StartMonth=#form.stmonth#&EndMonth=#form.endmonth#&Year2=2005&Area=1&Objective=all&FocusArea=all&Strategy=all&Prognum=all&PartnerName=all">
 --->	<cfoutput>

		<cfreport template="./reports/StratProgSummaryParam.cfr" format = "#form.format#" query="Qsummary">
		
		<!--- <CFREPORTPARAM name=StartMonth VALUE="#form.StMonth#">
		<CFREPORTPARAM name=EndMonth VALUE="#form.endmonth#"> --->
		<CFREPORTPARAM name=Year2 VALUE="#rptfy#">
		<!--- <cfif form.area NEQ "ALL">
			<cfquery datasource="#Application.DataSource#"  		 
			password="#Application.db_password#"  		
			username="#Application.db_username#" name="QArea">
			select area from area
			where num='#form.AREA#' and year2=#session.fy#
		</cfquery>
			<CFREPORTPARAM name=Area VALUE="#QArea.area#">
		<cfelse> --->
		<cfif form.region NEQ "ALL">
			<cfquery datasource="#Application.DataSource#"  		 
			password="#Application.db_password#"  		
			username="#Application.db_username#" name="QArea">
			select region from region
			where num='#form.region#' and year2=#session.fy#
		</cfquery>
			<CFREPORTPARAM name=Area VALUE="#QArea.region#">
		<cfelse>
			<CFREPORTPARAM name=Area VALUE="">
		</cfif>
		<cfif form.objective NEQ "ALL">
			<cfquery datasource="#Application.DataSource#"  		 
			password="#Application.db_password#"  		
			username="#Application.db_username#" name="Qobj">
			select objective from objectives where id='#form.objective#'
			and year2=#session.fy#
		</cfquery>
			<CFREPORTPARAM name=Objective VALUE="#Qobj.objective#">
		<cfelse>
			<CFREPORTPARAM name=Objective VALUE="">
		</cfif>
		<cfif form.farea NEQ "ALL">
		
			<cfquery datasource="#Application.DataSource#"  		 
			password="#Application.db_password#"  		
			username="#Application.db_username#" name="QFA">
			select descr from focusAreas where NUM='#form.farea#'
			and year2=#session.fy#
			</cfquery>
			<CFREPORTPARAM name=FocusArea VALUE="#QFA.descr#">
		<cfelse>
			<CFREPORTPARAM name=FocusArea VALUE="">
		</cfif>
		<cfif form.strategy NEQ "ALL">
			<CFREPORTPARAM name=Strategy VALUE="#form.strategy#">
		<Cfelse>
			<CFREPORTPARAM name=Strategy VALUE="">
		</cfif>
		
		<cfif form.goal NEQ "ALL">
		<cfquery datasource="#Application.DataSource#"  		 
		password="#Application.db_password#"  		
		username="#Application.db_username#" name="QProgram">
		select program from program where prognum = '#form.goal#'
		and year2=#session.fy#
		</cfquery>
			<CFREPORTPARAM name=Prognum VALUE="#QProgram.program#">
		<cfelse>
			<CFREPORTPARAM name=Prognum VALUE="">		
		</cfif>
		<cfif form.partner NEQ "ALL">
		<cfquery datasource="#Application.DataSource#"  		 
		password="#Application.db_password#"  		
		username="#Application.db_username#" name="QPartner">
		select orgname from contact where userid = '#form.partner#'
		</cfquery>
			<CFREPORTPARAM name=PartnerName VALUE="#QPartner.ORGNAME#">	
		<cfelse>
			<CFREPORTPARAM name=PartnerName VALUE="">	
		</cfif>
		
		<!--- <CFREPORTPARAM name=ReportName VALUE="progress">--->
		 <CFREPORTPARAM name=Monthrange VALUE="#Monthrange3#">
		<!--- <CFREPORTPARAM name=Monthrange VALUE="#monthrange#">	 --->	
		 </cfreport>
		 </cfoutput>
	</cfcase> 
	
	
	<cfcase value = 7>
<cfif session.fy LT 2009>
	<cfinclude template="rpt_infra.cfm">
<cfelse>
	
	<!--- <cfinclude template="rpt_infra.cfm">--->
<cfparam name="session.fy" default="2005">
<cfparam name="form.stMonth" default="all">
<cfparam name="form.endmonth" default="all">
<cfparam name="form.Area" default="ALL">
<cfparam name="form.Region" default="ALL">
<cfparam name="form.Objective" default="ALL">
<cfparam name="form.fArea" default="ALL">
<cfparam name="form.goal" default="ALL">
<cfparam name="form.partner" default="ALL">
<cfparam name="form.strategy" default="ALL">

<cfquery datasource="#Application.DataSource#"  		 
	password="#Application.db_password#"  		
	username="#Application.db_username#" name="infra">
select infra_monthly.userid,isnull(it_con,0) as it_con,isnull(staff_time,0) as staff_time,isnull(staff_job_desc,0) as staff_job_desc,isnull(staff_recruit,0) as staff_recruit,
	isnull(staff_interview,0) as staff_interview,isnull(staff_hired,0) as staff_hired,isnull(partner_recruit,0) as partner_recruit,
	isnull(partner_maint,0) as partner_maint,fiscal_voucher,fiscal_track, barriers, progress, success, 
	isnull(tcp_con,0) as tcp_con, isnull(tcp_am,0) as tcp_am, isnull(tcp_rm,0) as tcp_rm, isnull(tcp_sccm,0) as tcp_sccm, isnull(tcp_rscm,0) as tcp_rscm, isnull(tcp_ann,0) as tcp_ann, isnull(tcp_msm,0) as tcp_msm, isnull(tcp_ybm,0) as tcp_ybm,
	isnull(evalstatus,0) as evalstatus, isnull(web_maint,0) as web_maint, isnull(web_hit,0) as web_hit, isnull(web_comment,0) as web_comment,
	isnull(sust_1,0) as sust_1, isnull(sust_2,0) as sust_2, isnull(sust_3,0) as sust_3, isnull(sust_4,0) as sust_4,
	sust_1_txt, sust_2_txt, sust_3_txt, sust_4_txt, month2, orgname, 
	region.region,	llepd, num_visits,letter_num,tcp_mswm
	from infra_monthly, months, contact, 
	security
	left outer join area on area.num=security.area and area.year2=#session.def_fy#
	left outer join region on region.num = area.region and region.year2=#session.def_fy#
	where 	
	month2=mon
	and infra_monthly.userid=contact.userid
	and contact.userid=security.userid
	and
	<cfif isDefined("form.partner") and form.partner NEQ "ALL">
	
		(infra_monthly.userid='#form.partner#')
		and
	<cfelseif form.area NEQ "ALL">
		<cfif QAreas.recordcount NEQ 0 >
			(infra_monthly.userid in (#QuotedValueList(QAreas.userid)#)) and				
		<cfelse>
			infra_monthly.userid=' ' and
		</cfif>
	</cfif>
	<cfif isDefined("form.modality") and form.modality NEQ "ALL">
		 (contact.partnertype = #form.modality#) and
	</cfif> 
	contact.partnertype !=4
	and infra_monthly.year2=#session.fy#	
	and infra_monthly.month2 in (#quotedValueList(QMonlist.Mon)#)
	order by area.area, orgname, rank
</cfquery>
	
	<cfoutput>
	<cfreport template="./reports/heyelp.cfr" format = "#form.format#" query="infra">
		
		<CFREPORTPARAM name=Area VALUE="#form.region#">
		<CFREPORTPARAM name=Year2 VALUE="#rptfy#">
		<CFREPORTPARAM name=Objective VALUE="All">
		<CFREPORTPARAM name=FocusArea VALUE="All">
		<CFREPORTPARAM name=Strategy VALUE="All">
		<CFREPORTPARAM name=Prognum VALUE="All">
		<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">	
		<CFREPORTPARAM name=ReportName VALUE="PP">
		 <CFREPORTPARAM name=StartMonth VALUE="1">
		 <CFREPORTPARAM name=EndMonth VALUE="1">		
		 <CFREPORTPARAM name=Monthrange VALUE="#monthrange#">		 
		  <CFREPORTPARAM name=modality VALUE="#rptmodality#">
		
		</cfreport>
		 </cfoutput> 
	

</cfif>
<!--- <cfparam name="session.fy" default="2005">
<cfparam name="form.stMonth" default="all">
<cfparam name="form.endmonth" default="all">
<cfparam name="form.Area" default="ALL">
<cfparam name="form.Region" default="ALL">
<cfparam name="form.Objective" default="ALL">
<cfparam name="form.fArea" default="ALL">
<cfparam name="form.goal" default="ALL">
<cfparam name="form.partner" default="ALL">
<cfparam name="form.strategy" default="ALL">

<cfquery datasource="#Application.DataSource#"  		 
	password="#Application.db_password#"  		
	username="#Application.db_username#" name="infra">
select infra_monthly.userid,it_con,staff_time,staff_job_desc,staff_recruit,
	staff_interview,staff_hired,partner_recruit,
	partner_maint,fiscal_voucher,fiscal_track, barriers, progress, success, 
	tcp_con, tcp_am, tcp_rm, tcp_sccm, tcp_rscm, tcp_ann, tcp_msm, tcp_ybm,
	evalstatus, web_maint, web_hit, web_comment,
	sust_1, sust_2, sust_3, sust_4,
	sust_1_txt, sust_2_txt, sust_3_txt, sust_4_txt, month2, orgname, area.area as area,llepd
	from infra_monthly, months, contact,
	security
	left outer join area on area.num=security.area and area.year2=#session.def_fy#
	where 	
	month2=mon
	and infra_monthly.userid=contact.userid
	and contact.userid=security.userid
	and
	
	<cfif isDefined("form.partner") and form.partner NEQ "ALL">
	
		(infra_monthly.userid='#form.partner#')
		and
	<cfelseif form.area NEQ "ALL">
		<cfif QAreas.recordcount NEQ 0 >
			(infra_monthly.userid in (#QuotedValueList(QAreas.userid)#)) and				
		<cfelse>
			infra_monthly.userid=' ' and
		</cfif>
	</cfif>
	<cfif isDefined("form.modality") and form.modality NEQ "ALL">
		 (contact.partnertype = #form.modality#) and
	</cfif> 
	contact.partnertype !=4
	and infra_monthly.year2=#session.fy#	
	and infra_monthly.month2 in (#quotedValueList(QMonlist.Mon)#)
	order by area, orgname, rank
</cfquery>
	
	<cfoutput>
	<cfreport template="./reports/heyelp.cfr" format = "#form.format#" query="infra">
		
		<CFREPORTPARAM name=Area VALUE="#form.region#">
		<CFREPORTPARAM name=Year2 VALUE="#rptfy#">
		<CFREPORTPARAM name=Objective VALUE="All">
		<CFREPORTPARAM name=FocusArea VALUE="All">
		<CFREPORTPARAM name=Strategy VALUE="All">
		<CFREPORTPARAM name=Prognum VALUE="All">
		<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">	
		<CFREPORTPARAM name=ReportName VALUE="PP">
		 <CFREPORTPARAM name=StartMonth VALUE="1">
		 <CFREPORTPARAM name=EndMonth VALUE="1">		
		 <CFREPORTPARAM name=Monthrange VALUE="#monthrange#">		 
		  <CFREPORTPARAM name=modality VALUE="#rptmodality#">
		
		</cfreport>
		 </cfoutput> --->	</cfcase>
	
	<cfcase value = 8>
	
		

<cfparam name="session.fy" default="2005">
<cfparam name="form.stMonth" default="all">
<cfparam name="form.endmonth" default="all">
<cfparam name="form.Area" default="ALL">
<cfparam name="form.Region" default="ALL">
<cfparam name="form.Objective" default="ALL">
<cfparam name="form.fArea" default="ALL">
<cfparam name="form.goal" default="ALL">
<cfparam name="form.partner" default="ALL">
<cfparam name="form.strategy" default="ALL">

<cfquery datasource="#Application.DataSource#"  		 
	password="#Application.db_password#"  		
	username="#Application.db_username#" name="QPP">
select
	a.year2, q, collab_id,
        case rb1
        when 1 then 'Yes'
        when 0 then  'No'
        else 'Don''t know' end as rb1,

        case rb12
        when 0 then 'Not at all'
        when 3 then  'Partially'
        when 1 then  'Completely'
        else 'Don''t know' end as rb2,

        case rb13
        when 0 then 'Not at all'
        when 3 then  'Partially'
        when 1 then  'Completely'
        else 'Don''t know' end as rb3,

        case rb14
        when 0 then 'Not at all'
        when 3 then  'Partially'
        when 1 then  'Completely'
        else 'Don''t know' end as rb7,

        case rb15
        when 0 then 'Not at all'
        when 3 then  'Partially'
        when 1 then  'Completely'
        else 'Don''t know' end as rb6,

        case org_id_a
        when 1 then 'Yes'
        when 0 then 'No'
        end as org_id_a,

        case rb8
        when 1 then 'Yes'
        when 0 then 'No'
        end as rb8,

        case rb9
        when 2 then 'Yes, coordinated on their own'
        when 1 then 'Yes, coordinated through the Cessation Center'
        else 'No'
        end as rb9,

        case rb10
        when 2 then 'Yes, on their own'
        when 1 then 'Yes, through the Cessation Center'
        else 'No'
        end as rb10,

        case compliance_a
        when 1 then 'Yes'
        when 0 then 'No'
        end as compliance_a,

        case rb11
        when 1 then 'Yes'
        when 0 then 'No'
        end as rb11,

        isNull(compliance, 0) as compliance, isNull(org_id, 0) as org_id, a.seq,
        name,
        unit,
        case COALESCE(unit, 'NULL')
        when 'NULL' then name
        else  unit + ' ' + name
        end as nunit,
        comments, orgname
		
	from chcopp as a, collaborators as b, contact as c, region as r, area as ar
	where
	a.collab_id=b.seq
	and b.userid=c.userid
	and	c.partnertype != 4
	and r.year2=2009
	and ar.year2=r.year2
	and c.area=ar.num
	and ar.region=r.num
	  and (b.del is null or b.del !=1)
	<cfif form.area NEQ 'All' and form.partner EQ 'All'>
	and c.area=#form.area#
	</cfif>
	
	<cfif form.region NEQ 'All' and form.partner EQ 'All'>
	and r.num=#form.region#
	</cfif>
	
	<cfif form.partner NEQ 'All'>
	and c.userid = '#form.partner#'
	</cfif>
	<cfif isDefined("form.modality") and form.modality NEQ "ALL">
	and (c.partnertype = #form.modality#)
	</cfif>
	and (
	(a.year2 > #form.styear# OR (a.year2=#form.styear# and q >= #form.stquarter#))
	and (a.year2 < #form.endyear# OR (a.year2=#form.endyear# and q <= #form.endquarter#))
	) 
	order by orgname, nunit, 1,2

</cfquery>



<cfoutput>
	<cfreport template="./reports/PP_Progress.cfr" format = "#form.format#" query="QPP">
		
		<CFREPORTPARAM name=Year2 VALUE="#rptfy#">
		<CFREPORTPARAM name=Area VALUE="#form.region#">
		<CFREPORTPARAM name=Objective VALUE="All">
		<CFREPORTPARAM name=FocusArea VALUE="All">
		<CFREPORTPARAM name=Strategy VALUE="All">
		<CFREPORTPARAM name=Prognum VALUE="All">
		<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">	
		<CFREPORTPARAM name=ReportName VALUE="PP">
		 <CFREPORTPARAM name=StartMonth VALUE="1">
		 <CFREPORTPARAM name=EndMonth VALUE="1">		
		 <CFREPORTPARAM name=Monthrange VALUE="1">		 
		 <CFREPORTPARAM name=stYear VALUE="#form.stYear#">
		 <CFREPORTPARAM name=StQuarter VALUE="#form.stQuarter#">
		 <CFREPORTPARAM name=endYear VALUE="#form.endYear#">		 
		 <CFREPORTPARAM name=endQuarter VALUE="#form.endQuarter#">
		  <CFREPORTPARAM name=modality VALUE="#rptmodality#">
		
		</cfreport>
		 </cfoutput>
	</cfcase> 
	
	<cfcase value = 9>
	<cfoutput>
	
	
	
	


<cfparam name="session.fy" default="2005">
<cfparam name="form.Area" default="ALL">
<cfparam name="form.Region" default="ALL">
<cfparam name="form.Objective" default="ALL">
<cfparam name="form.fArea" default="ALL">
<cfparam name="form.goal" default="ALL">
<cfparam name="form.partner" default="ALL">
<cfparam name="form.strategy" default="ALL">

<cfinclude template="qry_report_filter.cfm">


<cfif session.fy LT 1920 or session.fy GT 2006>

<cfquery datasource="#Application.DataSource#"                          

            password="#Application.db_password#"                          

            username="#Application.db_username#" name="QAM">

select   <!--- ar.area, --->r.region as area,
            c.orgname,
            a.year2,
            a.month2,
case review_status
when 1 then 'Progressing'
when 2 then 'Unmet'
when 3 then 'Unable to determine/CAT reporting incomplete'
else 'NA'
end as review_status,
            case report_status
when 1 then 'Complete'
when 0 then 'Incomplete'
else 'NA'
end as report_status,
            review_progress,
            feedback, isNull(issues, '') as issues, CONVERT(CHAR(10),date_upd,110) as date_upd, date_init
			<cfif session.fy GTE 2007>, isNull(partner_status, 0) as partner_status</cfif>
from AM_Feedback as a, contact as c,
months as m, area as ar, region r,
security as s
where partner_id=c.userid
and a.year2=#session.fy#
and a.year2=ar.year2
and       c.partnertype != 4
and a.month2=m.mon
and a.year2=m.year2
and c.userid=s.userid
and s.area = ar.num

and ar.year2=r.year2
and ar.region=r.num
and
 <cfif isDefined("form.farea") and form.farea NEQ "ALL">u.strategy in (#form.farea#) and </cfif>  
            <cfif isDefined("form.partner") and form.partner NEQ "ALL">
                        (a.partner_id='#form.partner#' )
                        and
            <!--- <cfelseif form.area NEQ "ALL">
                        <cfif QAreas.recordcount NEQ 0 >
                                    (a.partner_id in (#QuotedValueList(QAreas.userid)#)
                                    ) and  
                        <cfelse>
						a.partner_id=' ' and
                        </cfif>
            </cfif>  --->
			<cfelseif form.region NEQ "ALL">
                        <cfif QAreas.recordcount NEQ 0 >
                                    (a.partner_id in (#QuotedValueList(QAreas.userid)#)
                                    ) and  
                        <cfelse>
						a.partner_id=' ' and
                        </cfif>
            </cfif> 
			<cfif isDefined("form.modality") and form.modality NEQ "ALL">
			(c.partnertype = #form.modality#) and 
			</cfif>
            a.month2 in #reReplace(monthrange, "~~", chr(39), "ALL")# 
order by 1,2,3,m.rank
</cfquery>

<cfelse>

<cfquery datasource="#Application.DataSource#" 
            password="#Application.db_password#" 
            username="#Application.db_username#" name="QAM">

select   <!--- ar.area, ---> r.region as area,
            c.orgname,
            a.year2,
            a.month2,
case review_status
when 1 then 'Adequate'
when 2 then 'Inadequate'
when 3 then 'Unable to determine'
else 'NA'
end as review_status,
            review_progress,
                        case report_status
when 1 then 'Complete'
when 0 then 'Incomplete'
else 'NA'
end as report_status,
            feedback, isNull(issues, '') as issues, CONVERT(CHAR(10),date_upd,110) as date_upd, date_init
			<cfif session.fy GTE 2007>, isNull(partner_status, 0) as partner_status</cfif>
from AM_Feedback as a, contact as c,
months as m, area as ar, region as r,
security as s
where partner_id=c.userid
and a.year2=#session.fy#
and a.year2=ar.year2
and       c.partnertype != 4
and a.month2=m.mon
and a.year2=m.year2
and c.userid=s.userid
and s.area = ar.num

and ar.region=r.num
and ar.year2=r.year2

and

 <cfif isDefined("form.farea") and form.farea NEQ "ALL">u.strategy in (#form.farea#) and </cfif>  
            <cfif isDefined("form.partner") and form.partner NEQ "ALL">
                        (a.partner_id='#form.partner#' )
                        and
            <!--- <cfelseif form.area NEQ "ALL">
                        <cfif QAreas.recordcount NEQ 0 >
                                    (a.partner_id in (#QuotedValueList(QAreas.userid)#) 
                                    ) and   
                        <cfelse>
						a.partner_id=' ' and
                        </cfif>
            </cfif>  --->
			<cfelseif form.region NEQ "ALL">
                        <cfif QAreas.recordcount NEQ 0 >
                                    (a.partner_id in (#QuotedValueList(QAreas.userid)#) 
                                    ) and   
                        <cfelse>
						a.partner_id=' ' and
                        </cfif>
            </cfif>   
			<cfif isDefined("form.modality") and form.modality NEQ "ALL">
		 (c.partnertype = #form.modality#) and
			</cfif>  
            a.month2 in #reReplace(monthrange, "~~", chr(39), "ALL")#
order by 1,2,3,m.rank
</cfquery>

</cfif>
	
<cfif session.fy LT 2007>
	<cfset rpttemp="./reports/areamgr_old.cfr">
<cfelse>
	<cfset rpttemp="./reports/areamgr.cfr">
</cfif>

 <cfreport template="#rpttemp#" format = "#form.format#" query="QAM"> 
	
		
		
		<CFREPORTPARAM name=ReportName VALUE="PP">
		<CFREPORTPARAM name=Year2 VALUE="#rptfy#">
		<CFREPORTPARAM name=Area VALUE="#form.region#">
		<CFREPORTPARAM name=Objective VALUE="ALL">
		<CFREPORTPARAM name=FocusArea VALUE="ALL">
		<CFREPORTPARAM name=Strategy VALUE="ALL">
		<CFREPORTPARAM name=Prognum VALUE="ALL">
		<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">	
		 <CFREPORTPARAM name=Monthrange VALUE="#Monthrange#">
		 <CFREPORTPARAM name=modality VALUE="#rptmodality#">
		 <!--- <CFREPORTPARAM name=StartMonth VALUE="1">
		 <CFREPORTPARAM name=EndMonth VALUE="1">		
		 <CFREPORTPARAM name=Monthrange VALUE="1">		 
		 <CFREPORTPARAM name=stYear VALUE="2005">
		 <CFREPORTPARAM name=StQuarter VALUE="1">
		 <CFREPORTPARAM name=endYear VALUE="2006">		 
		 <CFREPORTPARAM name=endQuarter VALUE="1"> --->
		
		</cfreport>
		 </cfoutput>
</cfcase>

<cfcase value = 10>

<cfparam name="session.fy" default="2005">
<cfparam name="form.stMonth" default="all">
<cfparam name="form.endmonth" default="all">
<cfparam name="form.Area" default="ALL">
<cfparam name="form.Region" default="ALL">
<cfparam name="form.Objective" default="ALL">
<cfparam name="form.fArea" default="ALL">
<cfparam name="form.goal" default="ALL">
<cfparam name="form.partner" default="ALL">
<cfparam name="form.strategy" default="ALL">
<cfparam name="form.modality" default="ALL">
<cfparam name="form.monthrange" default="January">


<cfquery datasource="#Application.DataSource#"  		 
	password="#Application.db_password#"  		
	username="#Application.db_username#" name="Qsust">
	select distinct
i.year2,
<!--- ar.area, --->r.region as area,
c.orgname,
Sum(case month2 when 'August' then (case sust_1 when 1 then 1 else 0 end) else 0 END) as augcorr,
Sum(case month2 when 'September' then (case sust_1 when 1 then 1 else 0 end) else 0 END) as septcorr,
Sum(case month2 when 'October' then (case sust_1 when 1 then 1 else 0 end) else 0 END) as octcorr,
Sum(case month2 when 'November' then (case sust_1 when 1 then 1 else 0 end) else 0 END) as novcorr,
Sum(case month2 when 'December' then (case sust_1 when 1 then 1 else 0 end) else 0 END) as deccorr,
Sum(case month2 when 'January' then (case sust_1 when 1 then 1 else 0 end) else 0 END) as jancorr,
Sum(case month2 when 'February' then (case sust_1 when 1 then 1 else 0 end) else 0 END) as febcorr,
Sum(case month2 when 'March' then (case sust_1 when 1 then 1 else 0 end) else 0 END) as marcorr,
Sum(case month2 when 'April' then (case sust_1 when 1 then 1 else 0 end) else 0 END) as aprcorr,
Sum(case month2 when 'May' then (case sust_1 when 1 then 1 else 0 end) else 0 END) as maycorr,
Sum(case month2 when 'June' then (case sust_1 when 1 then 1 else 0 end) else 0 END) as juncorr,
Sum(case month2 when 'July' then (case sust_1 when 1 then 1 else 0 end) else 0 END) as julcorr,

Sum(case month2 when 'August' then (case sust_2 when 1 then 1 else 0 end) else 0 END) as auglett,
Sum(case month2 when 'September' then (case sust_2 when 1 then 1 else 0 end) else 0 END) as septlett,
Sum(case month2 when 'October' then (case sust_2 when 1 then 1 else 0 end) else 0 END) as octlett,
Sum(case month2 when 'November' then (case sust_2 when 1 then 1 else 0 end) else 0 END) as novlett,
Sum(case month2 when 'December' then (case sust_2 when 1 then 1 else 0 end) else 0 END) as declett,
Sum(case month2 when 'January' then (case sust_2 when 1 then 1 else 0 end) else 0 END) as janlett,
Sum(case month2 when 'February' then (case sust_2 when 1 then 1 else 0 end) else 0 END) as feblett,
Sum(case month2 when 'March' then (case sust_2 when 1 then 1 else 0 end) else 0 END) as marlett,
Sum(case month2 when 'April' then (case sust_2 when 1 then 1 else 0 end) else 0 END) as aprlett,
Sum(case month2 when 'May' then (case sust_2 when 1 then 1 else 0 end) else 0 END) as maylett,
Sum(case month2 when 'June' then (case sust_2 when 1 then 1 else 0 end) else 0 END) as junlett,
Sum(case month2 when 'July' then (case sust_2 when 1 then 1 else 0 end) else 0 END) as jullett,

Sum(case month2 when 'August' then (case sust_3 when 1 then 1 else 0 end) else 0 END) as augmeet,
Sum(case month2 when 'September' then (case sust_3 when 1 then 1 else 0 end) else 0 END) as septmeet,
Sum(case month2 when 'October' then (case sust_3 when 1 then 1 else 0 end) else 0 END) as octmeet,
Sum(case month2 when 'November' then (case sust_3 when 1 then 1 else 0 end) else 0 END) as novmeet,
Sum(case month2 when 'December' then (case sust_3 when 1 then 1 else 0 end) else 0 END) as decmeet,
Sum(case month2 when 'January' then (case sust_3 when 1 then 1 else 0 end) else 0 END) as janmeet,
Sum(case month2 when 'February' then (case sust_3 when 1 then 1 else 0 end) else 0 END) as febmeet,
Sum(case month2 when 'March' then (case sust_3 when 1 then 1 else 0 end) else 0 END) as marmeet,
Sum(case month2 when 'April' then (case sust_3 when 1 then 1 else 0 end) else 0 END) as aprmeet,
Sum(case month2 when 'May' then (case sust_3 when 1 then 1 else 0 end) else 0 END) as maymeet,
Sum(case month2 when 'June' then (case sust_3 when 1 then 1 else 0 end) else 0 END) as junmeet,
Sum(case month2 when 'July' then (case sust_3 when 1 then 1 else 0 end) else 0 END) as julmeet,

Sum(case month2 when 'August' then (case sust_4 when 1 then 1 else 0 end) else 0 END) as augvisit,
Sum(case month2 when 'September' then (case sust_4 when 1 then 1 else 0 end) else 0 END) as septvisit,
Sum(case month2 when 'October' then (case sust_4 when 1 then 1 else 0 end) else 0 END) as octvisit,
Sum(case month2 when 'November' then (case sust_4 when 1 then 1 else 0 end) else 0 END) as novvisit,
Sum(case month2 when 'December' then (case sust_4 when 1 then 1 else 0 end) else 0 END) as decvisit,
Sum(case month2 when 'January' then (case sust_4 when 1 then 1 else 0 end) else 0 END) as janvisit,
Sum(case month2 when 'February' then (case sust_4 when 1 then 1 else 0 end) else 0 END) as febvisit,
Sum(case month2 when 'March' then (case sust_4 when 1 then 1 else 0 end) else 0 END) as marvisit,
Sum(case month2 when 'April' then (case sust_4 when 1 then 1 else 0 end) else 0 END) as aprvisit,
Sum(case month2 when 'May' then (case sust_4 when 1 then 1 else 0 end) else 0 END) as mayvisit,
Sum(case month2 when 'June' then (case sust_4 when 1 then 1 else 0 end) else 0 END) as junvisit,
Sum(case month2 when 'July' then (case sust_4 when 1 then 1 else 0 end) else 0 END) as julvisit

from infra_monthly as i, contact as c,
months as m, area as ar,region as r,
security as s
where i.userid=c.userid
and i.year2=#session.fy#
and i.year2=ar.year2
and i.month2=m.mon
and i.year2=m.year2
and c.userid=s.userid
and s.area = ar.num

and ar.region=r.num
and ar.year2=r.year2

<cfif form.area NEQ 'All' and form.partner EQ 'All'>
	and c.area=#form.area#
</cfif>

<cfif form.region NEQ 'All' and form.partner EQ 'All'>
	and r.num=#form.region#
</cfif>
<cfif form.partner NEQ 'All'>
	and c.userid = '#form.partner#'
</cfif>
<cfif isDefined("form.modality") and form.modality NEQ "ALL">
			and (c.partnertype = #form.modality#)
</cfif> 
and
		c.partnertype != 4
group by <!--- ar.area, --->r.region,
c.orgname,i.year2
order by <!--- ar.area --->r.region,orgname
</cfquery>


<!--- 		<cflocation addtoken="yes" url="http://nytobaccodev.rti.org/reports/stratprogsummary.cfr?StartMonth=#form.stmonth#&EndMonth=#form.endmonth#&Year2=2005&Area=1&Objective=all&FocusArea=all&Strategy=all&Prognum=all&PartnerName=all">
 --->	<cfoutput>

		<cfreport template="./reports/sustain.cfr" format = "#form.format#" query="QSust">
		
		<!--- <CFREPORTPARAM name=StartMonth VALUE="#form.StMonth#">
		<CFREPORTPARAM name=EndMonth VALUE="#form.endmonth#"> --->
		<CFREPORTPARAM name=Year2 VALUE="#rptfy#">
		<CFREPORTPARAM name=Area VALUE="#form.region#">
		<CFREPORTPARAM name=Objective VALUE="#form.objective#">
		<CFREPORTPARAM name=FocusArea VALUE="#form.farea#">
		<CFREPORTPARAM name=Strategy VALUE="#form.strategy#">
		<CFREPORTPARAM name=Prognum VALUE="#form.goal#">
		<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">	
		<CFREPORTPARAM name=ReportName VALUE="PP">
		 <CFREPORTPARAM name=Monthrange VALUE="#Monthrange#">
		 <CFREPORTPARAM name=dash VALUE="-">
		  <CFREPORTPARAM name=Y VALUE="Y">
		  <CFREPORTPARAM name=N VALUE="N">
		  <CFREPORTPARAM name=modality VALUE="#rptmodality#">
		<!--- <CFREPORTPARAM name=Monthrange VALUE="#monthrange#">	 --->	
		 </cfreport>
		 </cfoutput>
	</cfcase> 

	



<cfcase value = 11>

<cfparam name="session.fy" default="2005">
<cfparam name="form.stMonth" default="all">
<cfparam name="form.endmonth" default="all">
<cfparam name="form.Area" default="ALL">
<cfparam name="form.Region" default="ALL">
<cfparam name="form.Objective" default="ALL">
<cfparam name="form.fArea" default="ALL">
<cfparam name="form.goal" default="ALL">
<cfparam name="form.partner" default="ALL">
<cfparam name="form.strategy" default="ALL">
<cfparam name="form.monthrange" default="January">
<cfquery datasource="#Application.DataSource#"  		 
	password="#Application.db_password#"  		
	username="#Application.db_username#" name="Qstatus">
	
select <!--- ar.area, --->r.region as area,
i.userid, c.orgname, e.descrip as status, i.evalstatus, m.mon
	from infra_monthly as i,
	lu_eval_status as e,
contact as c,
months as m, 
area as ar, region as r,
security as s
	where 
i.evalstatus=e.id
and i.year2=e.year2
and i.userid=c.userid
and i.month2=m.mon
and i.year2 = m.year2
and i.userid=s.userid
and s.area = ar.num
and ar.year2=i.year2
and i.year2=#session.fy#

and ar.year2=r.year2
and ar.region=r.num
and m.rank=
(
select max(rank) from infra_monthly as ii, months as mm
where ii.month2=mm.mon
and ii.year2=mm.year2
and ii.year2=i.year2
and ii.userid=i.userid
)

 <cfif form.area NEQ 'All' and form.partner EQ 'All'>
	and c.area=#form.area#
	</cfif>
	
	<cfif form.region NEQ 'All' and form.partner EQ 'All'>
	and r.num=#form.region#
	</cfif>
	
	<cfif form.partner NEQ 'All'>
	and c.userid = '#form.partner#'
	</cfif>
	<cfif isDefined("form.modality") and form.modality NEQ "ALL">
			and (c.partnertype = #form.modality#)
	</cfif> 
	and
		c.partnertype != 4
order by 1,2, m.rank


</cfquery>


<!--- 		<cflocation addtoken="yes" url="http://nytobaccodev.rti.org/reports/stratprogsummary.cfr?StartMonth=#form.stmonth#&EndMonth=#form.endmonth#&Year2=2005&Area=1&Objective=all&FocusArea=all&Strategy=all&Prognum=all&PartnerName=all">
 --->	<cfoutput>

		<cfreport template="./reports/status.cfr" format = "#form.format#" query="QStatus">
		
		<!--- <CFREPORTPARAM name=StartMonth VALUE="#form.StMonth#">
		<CFREPORTPARAM name=EndMonth VALUE="#form.endmonth#"> --->
		<CFREPORTPARAM name=Year2 VALUE="#rptfy#">
		<CFREPORTPARAM name=Area VALUE="#form.region#">
		<CFREPORTPARAM name=Objective VALUE="#form.objective#">
		<CFREPORTPARAM name=FocusArea VALUE="#form.farea#">
		<CFREPORTPARAM name=Strategy VALUE="#form.strategy#">
		<CFREPORTPARAM name=Prognum VALUE="#form.goal#">
		<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">	
		<CFREPORTPARAM name=ReportName VALUE="method">
		 <CFREPORTPARAM name=Monthrange VALUE="#Monthrange#">
		 <CFREPORTPARAM name=modality VALUE="#rptmodality#">
		
		<!--- <CFREPORTPARAM name=Monthrange VALUE="#monthrange#">	 --->	
		 </cfreport>
		 </cfoutput>
	</cfcase> 





<cfcase value = 12>

<cfparam name="session.fy" default="2005">
<cfparam name="form.stMonth" default="all">
<cfparam name="form.endmonth" default="all">
<cfparam name="form.Area" default="ALL">
<cfparam name="form.Region" default="ALL">
<cfparam name="form.Objective" default="ALL">
<cfparam name="form.fArea" default="ALL">
<cfparam name="form.goal" default="ALL">
<cfparam name="form.partner" default="ALL">
<cfparam name="form.strategy" default="ALL">
<cfparam name="form.monthrange" default="January">
<cfquery datasource="#Application.DataSource#"  		 
	password="#Application.db_password#"  		
	username="#Application.db_username#" name="Qmethod">
	
select distinct <!--- ar.area, --->r.region as area,
c.userid, c.orgname,
'X' as methodEntered,
' ' as nomethodEntered
from 
contact as c,
area as ar, region as r,
security as s,
evalM as e
where 
c.userid=s.userid
and s.area = ar.num
and ar.year2=e.year2
and e.year2=#session.fy#
and e.userid=c.userid
and c.orgname is not null

and ar.year2=r.year2
and ar.region=r.num

and c.partnertype != '1' and c.partnertype != '4'
 <cfif form.area NEQ 'All' and form.partner EQ 'All'>
	and c.area=#form.area#
	</cfif>
	<cfif form.area NEQ 'All' and form.partner EQ 'All'>
	and r.num=#form.region#
	</cfif>
	
	<cfif form.partner NEQ 'All'>
	and c.userid = '#form.partner#'
	</cfif>
	<cfif isDefined("form.modality") and form.modality NEQ "ALL">
			and (c.partnertype = #form.modality#)
			</cfif> 
	

UNION

select distinct <!--- ar.area, ---> r.region as area,
c.userid, c.orgname,
' ' as methodEntered,
'X' as nomethodEntered
from 
contact as c,
area as ar, region as r,
security as s
where 
c.userid=s.userid
and s.area = ar.num
and ar.year2=#session.fy#
and ar.year2=r.year2
and ar.region=r.num
and c.userid not in
(select distinct userid from evalM where year2=#session.fy#)
and c.orgname is not null
and c.partnertype != '1' and c.partnertype != '4'
 <cfif form.area NEQ 'All' and form.partner EQ 'All'>
	and c.area=#form.area#
	</cfif>
	<cfif form.region NEQ 'All' and form.partner EQ 'All'>
	and r.num=#form.region#
	</cfif>
	
	<cfif form.partner NEQ 'All'>
	and c.userid = '#form.partner#'
</cfif>
	<cfif isDefined("form.modality") and form.modality NEQ "ALL">
			and (c.partnertype = #form.modality#)
			</cfif> 
order by 1,2
</cfquery>

<!--- 		<cflocation addtoken="yes" url="http://nytobaccodev.rti.org/reports/stratprogsummary.cfr?StartMonth=#form.stmonth#&EndMonth=#form.endmonth#&Year2=2005&Area=1&Objective=all&FocusArea=all&Strategy=all&Prognum=all&PartnerName=all">
 --->	<cfoutput>


		<cfreport template="./reports/methods.cfr" format = "#form.format#" query="Qmethod">
		
		<!--- <CFREPORTPARAM name=StartMonth VALUE="#form.StMonth#">
		<CFREPORTPARAM name=EndMonth VALUE="#form.endmonth#"> --->
		<CFREPORTPARAM name=Year2 VALUE="#rptfy#">
		<CFREPORTPARAM name=Area VALUE="#form.region#">
		<CFREPORTPARAM name=Objective VALUE="#form.objective#">
		<CFREPORTPARAM name=FocusArea VALUE="#form.farea#">
		<CFREPORTPARAM name=Strategy VALUE="#form.strategy#">
		<CFREPORTPARAM name=Prognum VALUE="#form.goal#">
		<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">	
		<CFREPORTPARAM name=ReportName VALUE="method">
		 <CFREPORTPARAM name=Monthrange VALUE="#Monthrange#">
		 <CFREPORTPARAM name=modality VALUE="#rptmodality#">
		<!--- <CFREPORTPARAM name=Monthrange VALUE="#monthrange#">	 --->	
		 </cfreport>
		 </cfoutput>
	</cfcase> 

<cfcase value = 13>

<cfparam name="session.fy" default="2005">
<cfparam name="form.stMonth" default="all">
<cfparam name="form.endmonth" default="all">
<cfparam name="form.Area" default="ALL">
<cfparam name="form.Region" default="ALL">
<cfparam name="form.Objective" default="ALL">
<cfparam name="form.fArea" default="2">
<cfparam name="form.goal" default="ALL">
<cfparam name="form.partner" default="ALL">
<cfparam name="form.strategy" default="ALL">
<cfparam name="form.monthrange" default="January">
<cfinclude template="qry_report_filter.cfm">

<cfquery datasource="#Application.DataSource#"  		 
	password="#Application.db_password#"  		
	username="#Application.db_username#" name="Qqline">
SELECT     u.goal, p.program, u.objective, o.abbr, c.orgname, <!--- ar.area, --->r.region as area, u.activity, a.month2, CASE u.tcp_fun WHEN 1 THEN 'Yes' ELSE 'No' END AS tcpfun, 
ca.descrip AS campCat2, camptitle, s.descrip AS campSource, campcat, campchannel,
      unit = CASE campcat
         WHEN 3 THEN 'ads placed' 
         WHEN 4 THEN 'ads placed' 
         WHEN 5 then 'locations'
         WHEN 8 THEN 'locations'
         WHEN 6 THEN 'distributed'
         WHEN 7 THEN 'days run'
         WHEN 9 THEN 'time on website'
         WHEN 11 THEN 'distributed'
         ELSE 'spots'
         END, grp, intensecount, campcount, campCost, flightstart, flightend, isNull(a.campcounty, 0) as campcounty
FROM         campaign AS a, PMcampchan AS ca, pmcamps AS s, useractivities AS u, 
program AS p, objectives AS o, contact AS c, months AS m, area AS ar, region as r
WHERE     u.userid = c.userid AND ar.num = c.area AND a.month2 = m.mon and a.year2 = m.year2 AND a.year2 = #session.fy# AND ca.year2 = a.year2 AND s.year2 = a.year2 AND 
                      a.campcat = ca.num AND a.campsource = s.num AND ar.year2 = a.year2 AND a.year2 = u.year2 AND a.year2 = p.year2 AND a.year2 = o.year2 AND 
                      a.userid = u.userid AND a.activity = u.activity AND p.progNum = u.goal AND o.id = u.objective AND (u.del IS NULL OR
                      u.del != 'y') AND u.strategy = 2  and c.partnertype!=4
					and ar.year2=r.year2 and ar.region=r.num
	<!--- <cfif form.area NEQ 'All' and form.partner EQ 'All'>
	and c.area='#form.area#'
	</cfif>
	
	
<cfif form.partner NEQ 'All'>
	and c.userid = '#form.partner#'
</cfif>

<cfif form.goal NEQ 'All' and form.objective EQ 'All'>
	and u.goal=#form.goal#
<cfelseif form.objective NEQ 'All'>
	and u.objective = '#form.objective#'
</cfif>

and a.month2 in #reReplace(monthrange, "~~", chr(39), "ALL")# --->
<cfinclude template="report_filter.cfm">
order by 
<!--- ar.area, --->r.region,
c.orgname,
u.activity,
ca.descrip,
a.month2

</cfquery>


<!--- 		<cflocation addtoken="yes" url="http://nytobaccodev.rti.org/reports/stratprogsummary.cfr?StartMonth=#form.stmonth#&EndMonth=#form.endmonth#&Year2=2005&Area=1&Objective=all&FocusArea=all&Strategy=all&Prognum=all&PartnerName=all">
 --->	<cfoutput>

		<cfreport template="./reports/quitline.cfr" format = "#form.format#" query="Qqline">
		
		<!--- <CFREPORTPARAM name=StartMonth VALUE="#form.StMonth#">
		<CFREPORTPARAM name=EndMonth VALUE="#form.endmonth#"> --->
		<CFREPORTPARAM name=Year2 VALUE="#rptfy#">
		<CFREPORTPARAM name=Area VALUE="#form.region#">
		<CFREPORTPARAM name=Objective VALUE="#form.objective#">
		<CFREPORTPARAM name=FocusArea VALUE="#form.farea#">
		<CFREPORTPARAM name=Strategy VALUE="#form.strategy#">
		<CFREPORTPARAM name=Prognum VALUE="#form.goal#">
		<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">	
		<CFREPORTPARAM name=ReportName VALUE="method">
		 <CFREPORTPARAM name=Monthrange VALUE="#Monthrange6#">
		 <CFREPORTPARAM name=modality VALUE="#rptmodality#">
		<!--- <CFREPORTPARAM name=Monthrange VALUE="#monthrange#">	 --->	
		 </cfreport>
		 </cfoutput>
	</cfcase> 
<cfcase value = 14>

<cfparam name="session.fy" default="2005">
<cfparam name="form.stMonth" default="all">
<cfparam name="form.endmonth" default="all">
<cfparam name="form.Area" default="ALL">
<cfparam name="form.Region" default="ALL">
<cfparam name="form.Objective" default="ALL">
<cfparam name="form.fArea" default="All">
<cfparam name="form.goal" default="ALL">
<cfparam name="form.partner" default="ALL">
<cfparam name="form.strategy" default="ALL">
<cfparam name="form.monthrange" default="January">

<cfinclude template="qry_report_filter.cfm">


<cfquery datasource="#Application.DataSource#"  		 
	password="#Application.db_password#"  		
	username="#Application.db_username#" name="Qdetails">
SELECT     u.goal, p.program, u.objective, o.abbr, c.orgname, <!--- ar.area, ---> r.region as area,  u.activity, a.month2, CASE u.state WHEN 1 THEN 'Yes' ELSE 'No' END AS statewideinit, 
                      si.abbr AS siabbr, ca.descrip AS campCat2, a.campchannel, camptitle, s.descrip AS campSource, campcat, unit = CASE campcat
         WHEN 3 THEN 'ads placed' 
         WHEN 4 THEN 'ads placed' 
         WHEN 5 then 'locations'
         WHEN 8 THEN 'locations'
         WHEN 6 THEN 'distributed'
         WHEN 7 THEN 'days run'
         WHEN 9 THEN 'time on website'
         WHEN 11 THEN 'distributed'
         ELSE 'spots'
         END, grp, intensecount, campcount, campCost, 
                      flightstart, flightend, isNull(a.campcounty, 0) as campcounty
FROM         campaign AS a, PMcampchan AS ca, pmcamps AS s, useractivities AS u LEFT JOIN
                      state_initiatives si ON u.campname = si.num AND u.year2 = si.year2, 
					  program AS p, objectives AS o, contact AS c, months AS m, area AS ar, region as r
WHERE     u.userid = c.userid AND ar.num = c.area AND a.month2 = m.mon and a.year2 = m.year2 AND a.year2 = #session.fy# 
AND ca.year2 = a.year2 AND s.year2 = a.year2 AND 
                      a.campcat = ca.num AND a.campsource = s.num AND ar.year2 = a.year2 
					  AND a.year2 = u.year2 AND a.year2 = p.year2 AND a.year2 = o.year2 AND 
                      a.userid = u.userid AND a.activity = u.activity AND p.progNum = u.goal 
					  AND o.id = u.objective AND (u.del IS NULL OR
                      u.del != 'y') AND u.strategy = 2 and (c.partnertype!=4 or u.userid='shared')
 
and ar.year2=r.year2 and ar.region=r.num
<!--- <cfif form.area NEQ 'All' and form.partner EQ 'All'>
	and co.area='#form.area#'
</cfif>	
<cfif form.partner NEQ 'All'>
	and co.userid = '#form.partner#'
</cfif>
<cfif form.goal NEQ 'All' and form.objective EQ 'All'>
	and u.goal=#form.goal#
<cfelseif form.objective NEQ 'All'>
	and u.objective = '#form.objective#'
</cfif> 
 and a.month2 in #reReplace(monthrange, "~~", chr(39), "ALL")# --->
 <cfinclude template="report_filter.cfm">
 
order by 
<!--- ar.area, --->r.region,
c.orgname,
u.activity,
ca.descrip,
a.month2

</cfquery>


 
 
 <cfoutput>

		<cfreport template="./reports/details.cfr" format = "#form.format#" query="Qdetails">
		
		<!--- <CFREPORTPARAM name=StartMonth VALUE="#form.StMonth#">
		<CFREPORTPARAM name=EndMonth VALUE="#form.endmonth#"> --->
		<CFREPORTPARAM name=Year2 VALUE="#rptfy#">
		<CFREPORTPARAM name=Area VALUE="#form.region#">
		<CFREPORTPARAM name=Objective VALUE="#form.objective#">
		<CFREPORTPARAM name=FocusArea VALUE=2>
		<CFREPORTPARAM name=Strategy VALUE="#form.strategy#">
		<CFREPORTPARAM name=Prognum VALUE="#form.goal#">
		<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">	
		<CFREPORTPARAM name=ReportName VALUE="method">
		 <CFREPORTPARAM name=Monthrange VALUE="#Monthrange6#">
		 <CFREPORTPARAM name=modality VALUE="#rptmodality#">
		<!--- <CFREPORTPARAM name=Monthrange VALUE="#monthrange#">	 --->	
		 </cfreport>
		 </cfoutput>
	</cfcase> 
	
	
	
	
<cfcase value = 15>

<cfparam name="session.fy" default="2005">
<cfparam name="form.stMonth" default="all">
<cfparam name="form.endmonth" default="all">
<cfparam name="form.Area" default="ALL">
<cfparam name="form.Region" default="ALL">
<cfparam name="form.Objective" default="ALL">
<cfparam name="form.fArea" default="ALL">
<cfparam name="form.goal" default="ALL">
<cfparam name="form.partner" default="ALL">
<cfparam name="form.strategy" default="ALL">
<cfparam name="form.monthrange" default="ALL">

<cfinclude template="qry_report_filter.cfm">
<cfif session.fy LT 2007>

<cfquery datasource="#Application.DataSource#"  		 
	password="#Application.db_password#"  		
	username="#Application.db_username#" name="Qdetails">
SELECT     <!--- ar.area, ---> r.region as area, orgname, sum(CASE WHEN abbr = 'Mag ads' THEN 1 ELSE 0 END) AS mag,
sum(CASE WHEN abbr = 'POP' THEN 1 ELSE 0 END) AS pop, sum(CASE WHEN abbr = 'TI sponsor' THEN 1 ELSE 0 END)
AS sponsor, sum(CASE WHEN abbr = 'TI promotion' THEN 1 ELSE 0 END) AS promo,
sum(CASE WHEN abbr = 'Movies' THEN 1 ELSE 0 END) AS movies, 
sum(CASE WHEN abbr != 'Movies' AND abbr != 'TI promotion' AND abbr != 'TI sponsor' AND abbr != 'Mag ads' 
AND abbr != 'POP' THEN 1 ELSE 0 END) AS other
FROM         dbo.userActivities u LEFT OUTER JOIN
                      dbo.State_initiatives si ON u.campName = si.num AND u.year2 = si.year2 INNER JOIN
                      govt a ON u.userid = a.userid AND u.year2 = a.year2 and a.activity=u.activity INNER JOIN
                      contact c ON u.userid = c.userid
inner join area ar on c.area = ar.num and ar.year2=u.year2
inner join region r on ar.region = r.num and ar.year2=r.year2
WHERE     (si.asp = 1) AND impact_imp = 1 and u.strategy = 1 and orgname is not null
AND (u.del IS NULL OR u.del != 'y') and c.partnertype != 4
<!--- <cfif form.area NEQ 'All' and form.partner EQ 'All'>
	and c.area='#form.area#'
</cfif>	
<cfif form.partner NEQ 'All'>
	and c.userid = '#form.partner#'
</cfif>
<cfif form.goal NEQ 'All' and form.objective EQ 'All'>
	and u.goal=#form.goal#
<cfelseif form.objective NEQ 'All'>
	and u.objective = '#form.objective#'
</cfif> 
 and g.month2 in #reReplace(monthrange, "~~", chr(39), "ALL")# --->
 <cfinclude template="report_filter.cfm">
  AND u.year2=#session.fy#
group by orgname,<!--- ar.area ---> r.region


union all

SELECT     <!--- ar.area, ---> r.region as area, orgname, sum(CASE WHEN abbr = 'Mag ads' THEN 1 ELSE 0 END) AS mag, sum(CASE WHEN abbr = 'POP' THEN 1
ELSE 0 END) AS pop, sum(CASE WHEN abbr = 'TI sponsor' THEN 1 ELSE 0 END) AS sponsor, sum(CASE WHEN 
abbr = 'TI promotion' THEN 1 ELSE 0 END) AS promo, sum(CASE WHEN abbr = 'Movies' THEN 1 ELSE 0 END) AS movies, 
sum(CASE WHEN abbr != 'Movies' AND abbr != 'TI promotion' AND abbr != 'TI sponsor' AND 
abbr != 'Mag ads' AND abbr != 'POP' THEN 1 ELSE 0 END) AS other
FROM         dbo.userActivities u LEFT OUTER JOIN
                      dbo.State_initiatives si ON u.campName = si.num AND u.year2 = si.year2 INNER JOIN
                      advoc a ON u.userid = a.userid AND u.year2 = a.year2 and a.activity=u.activity INNER JOIN
                      contact c ON u.userid = c.userid 
					inner join area ar on c.area = ar.num and ar.year2=u.year2
					inner join region r on ar.region = r.num and ar.year2=r.year2
					 
WHERE     (u.strategy IN (8,9)) AND (si.asp = 1) AND impact_imp = 1 and orgname is not null
AND (u.del IS NULL OR u.del != 'y') and c.partnertype != 4
<!--- <cfif form.area NEQ 'All' and form.partner EQ 'All'>
	and c.area='#form.area#'
</cfif>	
<cfif form.partner NEQ 'All'>
	and c.userid = '#form.partner#'
</cfif>
<cfif form.goal NEQ 'All' and form.objective EQ 'All'>
	and u.goal=#form.goal#
<cfelseif form.objective NEQ 'All'>
	and u.objective = '#form.objective#'
</cfif> 
and a.month2 in #reReplace(monthrange, "~~", chr(39), "ALL")# --->
<cfinclude template="report_filter.cfm">
AND u.year2=#session.fy#
group by orgname,<!--- ar.area ---> r.region

order by <!--- ar.area ---> r.region, orgname


</cfquery>
<cfoutput>


		<cfreport template="./reports/aspcomponent.cfr" format = "#form.format#"  query="QDetails">
		
		<!--- <CFREPORTPARAM name=StartMonth VALUE="#form.StMonth#">
		<CFREPORTPARAM name=EndMonth VALUE="#form.endmonth#"> --->
		<CFREPORTPARAM name=Year2 VALUE="#rptfy#">
		<CFREPORTPARAM name=Area VALUE="#form.region#">
		<CFREPORTPARAM name=Objective VALUE="#form.objective#">
		<CFREPORTPARAM name=FocusArea VALUE="#form.farea#">
		<CFREPORTPARAM name=Strategy VALUE="#form.strategy#">
		<CFREPORTPARAM name=Prognum VALUE="#form.goal#">
		<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">	
		<CFREPORTPARAM name=ReportName VALUE="method">
		 <CFREPORTPARAM name=Monthrange VALUE="#Monthrange#">
		 <CFREPORTPARAM name=modality VALUE="#rptmodality#">
		<!--- <CFREPORTPARAM name=Monthrange VALUE="#monthrange#">	 --->	
		 </cfreport>
		 </cfoutput>
		 
<cfelse>
<cfquery datasource="#Application.DataSource#"  		 
	password="#Application.db_password#"  		
	username="#Application.db_username#" name="Qdetails">
	
SELECT     c.orgname, <!--- ar.area,  ---> r.region as area,
sum(case when groupName='Retail' then
	(case channel when '1' then 1 when '4' then 1 when '5' then 1 else 0 end)
    else 0 end) as RetailPol,
sum(case when groupName='Retail' then
	(case channel when '2' then 1 else 0 end)
    else 0 end) as RetailRes,

sum(case when groupName='Magazine' then
	(case channel when '1' then 1 when '4' then 1 when '5' then 1 else 0 end)
    else 0 end) as MagPol,
sum(case when groupName='Magazine' then
	(case channel when '2' then 1 else 0 end)
    else 0 end) as MagRes,

sum(case when groupName='Movies' then
	(case channel when '1' then 1 when '4' then 1 when '5' then 1 else 0 end)
    else 0 end) as MoviePol,
sum(case when groupName='Movies' then
	(case channel when '2' then 1 else 0 end)
    else 0 end) as MovieRes,

sum(case when groupName='SponsPromo' then
	(case channel when '1' then 1 when '4' then 1 when '5' then 1 else 0 end)
    else 0 end) as SponsPol,
sum(case when groupName='SponsPromo' then
	(case channel when '2' then 1 else 0 end)
    else 0 end) as SponsRes,

sum(case when groupName='Outdoor' then
	(case channel when '1' then 1 when '4' then 1 when '5' then 1 else 0 end)
    else 0 end) as OutdoorPol,
sum(case when groupName='Outdoor' then
	(case channel when '2' then 1 else 0 end)
    else 0 end) as OutdoorRes,

sum(case when groupName='MUD' then
	(case channel when '1' then 1 when '4' then 1 when '5' then 1 else 0 end)
    else 0 end) as MudPol,
sum(case when groupName='MUD' then
	(case channel when '2' then 1 else 0 end)
    else 0 end) as MudRes

from PRPChange as P, 
userActivities u, 
contact as c,
govt as a,
area as ar, objectives as o, user_target_org as uto, region as r
WHERE     
p.userid=u.userid
and u.objective=o.id
and u.year2=o.year2
and u.userid=c.userid
and p.activity=u.activity
and p.year2=u.year2
and u.strategy = 1 
and a.userid=p.userid
and a.year2=p.year2
and a.activity=p.activity
and a.month2=p.month2
and ar.year2=u.year2
and ar.num=c.area
and uto.seq=p.stakeholders

and ar.year2=r.year2
and ar.region=r.num
and u.objective in 
<cfif rptfy GTE 2008>
('2B','2C','2Cb','2D','2E','2F','2G','2H','2J','2k','3G', '3C', '4c', '2i', '2L', '2M')
<cfelse>
('2B','2C','2Cb','2D','2E','2F','2G','2H','2J','2k','4G', '4C', '1c', '2i')
</cfif>

AND (u.del IS NULL OR u.del != 'y') and c.partnertype != 4
and orgname is not null
AND u.year2=#session.fy#
and c.partnertype !=4
<cfinclude template="report_filter.cfm">
group by c.orgname, <!--- ar.area ---> r.region
UNION

SELECT     c.orgname, <!--- ar.area,  ---> r.region as area,
sum(case when groupName='Retail' then
	(case channel when '1' then 1 when '4' then 1 when '5' then 1 else 0 end)
    else 0 end) as RetailPol,
sum(case when groupName='Retail' then
	(case channel when '2' then 1 else 0 end)
    else 0 end) as RetailRes,

sum(case when groupName='Magazine' then
	(case channel when '1' then 1 when '4' then 1 when '5' then 1 else 0 end)
    else 0 end) as MagPol,
sum(case when groupName='Magazine' then
	(case channel when '2' then 1 else 0 end)
    else 0 end) as MagRes,

sum(case when groupName='Movies' then
	(case channel when '1' then 1 when '4' then 1 when '5' then 1 else 0 end)
    else 0 end) as MoviePol,
sum(case when groupName='Movies' then
	(case channel when '2' then 1 else 0 end)
    else 0 end) as MovieRes,

sum(case when groupName='SponsPromo' then
	(case channel when '1' then 1 when '4' then 1 when '5' then 1 else 0 end)
    else 0 end) as SponsPol,
sum(case when groupName='SponsPromo' then
	(case channel when '2' then 1 else 0 end)
    else 0 end) as SponsRes,

sum(case when groupName='Outdoor' then
	(case channel when '1' then 1 when '4' then 1 when '5' then 1 else 0 end)
    else 0 end) as OutdoorPol,
sum(case when groupName='Outdoor' then
	(case channel when '2' then 1 else 0 end)
    else 0 end) as OutdoorRes,

sum(case when groupName='MUD' then
	(case channel when '1' then 1 when '4' then 1 when '5' then 1 else 0 end)
    else 0 end) as MudPol,
sum(case when groupName='MUD' then
	(case channel when '2' then 1 else 0 end)
    else 0 end) as MudRes
from PRPChange as P, 
userActivities u, 
contact as c,
advoc as a,
area as ar,  objectives as o, user_target_org as uto, region as r
WHERE     
p.userid=u.userid
and u.objective=o.id
and u.year2=o.year2
and u.userid=c.userid
and p.activity=u.activity
and p.year2=u.year2
and u.strategy in (8,9)
and a.userid=p.userid
and a.activity=p.activity
and a.month2=p.month2
and a.year2=p.year2
and ar.year2=u.year2
and ar.num=c.area
and uto.seq=p.stakeholders

and ar.year2=r.year2
and ar.region=r.num
and u.objective in 
<cfif rptfy GTE 2008>
('2B','2C','2Cb','2D','2E','2F','2G','2H','2J','2k','3G', '3C', '4c', '2i', '2L', '2M')
<cfelse>
('2B','2C','2Cb','2D','2E','2F','2G','2H','2J','2k','4G', '4C', '1c', '2i')
</cfif>
and orgname is not null
AND (u.del IS NULL OR u.del != 'y') and c.partnertype != 4
AND u.year2=#session.fy#
<cfinclude template="report_filter.cfm">
group by c.orgname, <!--- ar.area ---> r.region
order by 2,1
</cfquery>
<cfoutput>



		<cfreport template="./reports/aspcomponent_new2.cfr" format = "#form.format#"  query="QDetails">
		
		<!--- <CFREPORTPARAM name=StartMonth VALUE="#form.StMonth#">
		<CFREPORTPARAM name=EndMonth VALUE="#form.endmonth#"> --->
		<CFREPORTPARAM name=Year2 VALUE="#rptfy#">
		<CFREPORTPARAM name=Area VALUE="#form.region#">
		<CFREPORTPARAM name=Objective VALUE="#form.objective#">
		<CFREPORTPARAM name=FocusArea VALUE="#form.farea#">
		<CFREPORTPARAM name=Strategy VALUE="#form.strategy#">
		<CFREPORTPARAM name=Prognum VALUE="#form.goal#">
		<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">	
		<CFREPORTPARAM name=ReportName VALUE="method">
		 <CFREPORTPARAM name=Monthrange VALUE="#Monthrange#">
		 <CFREPORTPARAM name=modality VALUE="#rptmodality#">
		<!--- <CFREPORTPARAM name=Monthrange VALUE="#monthrange#">	 --->	
		 </cfreport>
		 </cfoutput>
		  
<!--- <cfelse>
		 <cfquery datasource="#Application.DataSource#"  		 
	password="#Application.db_password#"  		
	username="#Application.db_username#" name="Qdetails">


SELECT     c.orgname, ar.area, 
sum(case when objective='2b' then
	(case channel when '1' then 1 else 0 end)
    else 0 end) as SPONPol,
sum(case when objective='2b' then
	(case channel when '2' then 1 else 0 end)
    else 0 end) as SPONRes,
sum(case whyyen objective='2c' then
	(case channel when '1' then 1 else 0 end)
	when objective='2cb' then
	(case channel when '1' then 1 else 0 end)
    else 0 end) as PROMPol,
sum(case when objective='2c' then
	(case channel when '2' then 1 else 0 end)
	when objective='2cb' then
	(case channel when '2' then 1 else 0 end)
    else 0 end) as PROMRes,
sum(case when objective='2d' then
	(case channel when '1' then 1 else 0 end)
    else 0 end) as POPPol,
sum(case when objective='2d' then
	(case channel when '2' then 1 else 0 end)
    else 0 end) as POPRes,
sum(case when objective='2f' then
	(case channel when '1' then 1 else 0 end)
    else 0 end) as MAGPol,
sum(case when objective='2f' then
	(case channel when '2' then 1 else 0 end)
    else 0 end) as MAGRes,
sum(case when objective='4c' then
	(case channel when '1' then 1 else 0 end)
	when objective='4g' then
	(case channel when '1' then 1 else 0 end)
    else 0 end) as MOVIESPol,
sum(case when objective='4c' then
	(case channel when '2' then 1 else 0 end)
	when objective='4g' then
	(case channel when '2' then 1 else 0 end)
    else 0 end) as MOVIESRes
from PRPChange as P, 
userActivities u, 
contact as c,
govt as a,
area as ar
WHERE     
p.userid=u.userid
and u.userid=c.userid
and p.activity=u.activity
and p.year2=u.year2
and u.strategy = 1 
and a.userid=p.userid
and a.activity=p.activity
and a.month2=p.month2
and ar.year2=u.year2
and ar.num=c.area
and u.objective in ('2b','2c','2cb', '2d', '2f', '4c','4g')
AND (u.del IS NULL OR u.del != 'y') and c.partnertype != 4
and orgname is not null
AND u.year2=#session.fy#
and c.partnertype !=4
<cfinclude template="report_filter.cfm">
group by c.orgname, ar.area
UNION

SELECT     c.orgname, ar.area, 
sum(case when objective='2b' then
	(case channel when '1' then 1 else 0 end)
    else 0 end) as POPPol,
sum(case when objective='2b' then
	(case channel when '2' then 1 else 0 end)
    else 0 end) as POPRes,
sum(case when objective='2c' then
	(case channel when '1' then 1 else 0 end)
	when objective='2cb' then
	(case channel when '1' then 1 else 0 end)
    else 0 end) as MAGPol,
sum(case when objective='2c' then
	(case channel when '2' then 1 else 0 end)
	when objective='2cb' then
	(case channel when '2' then 1 else 0 end)
    else 0 end) as MAGRes,
sum(case when objective='2d' then
	(case channel when '1' then 1 else 0 end)
    else 0 end) as SPONPol,
sum(case when objective='2d' then
	(case channel when '2' then 1 else 0 end)
    else 0 end) as SPONRes,
sum(case when objective='2f' then
	(case channel when '1' then 1 else 0 end)
    else 0 end) as PROMPol,
sum(case when objective='2f' then
	(case channel when '2' then 1 else 0 end)
    else 0 end) as PROMRes,
sum(case when objective='4c' then
	(case channel when '1' then 1 else 0 end)
	when objective='4g' then
	(case channel when '1' then 1 else 0 end)
    else 0 end) as MOVIESPol,
sum(case when objective='4c' then
	(case channel when '2' then 1 else 0 end)
	when objective='4g' then
	(case channel when '2' then 1 else 0 end)
    else 0 end) as MOVIESRes
from PRPChange as P, 
userActivities u, 
contact as c,
advoc as a,
area as ar
WHERE     
p.userid=u.userid
and u.userid=c.userid
and p.activity=u.activity
and p.year2=u.year2
and u.strategy in (8,9)
and a.userid=p.userid
and a.activity=p.activity
and a.month2=p.month2
and ar.year2=u.year2
and ar.num=c.area
and u.objective in ('2B','2C','2Cb','2D','2E','2F','2G','2H','2J','2k','4G', '4C', '1c', '2i')
and orgname is not null
AND (u.del IS NULL OR u.del != 'y') and c.partnertype != 4
 AND u.year2=#session.fy#
<cfinclude template="report_filter.cfm">
group by c.orgname, ar.area

order by 2,1





</cfquery>
<cfoutput>



		<cfreport template="./reports/aspcomponent_new.cfr" format = "#form.format#"  query="QDetails">
		
		<!--- <CFREPORTPARAM name=StartMonth VALUE="#form.StMonth#">
		<CFREPORTPARAM name=EndMonth VALUE="#form.endmonth#"> --->
		<CFREPORTPARAM name=Year2 VALUE="#rptfy#">
		<CFREPORTPARAM name=Area VALUE="#form.area#">
		<CFREPORTPARAM name=Objective VALUE="#form.objective#">
		<CFREPORTPARAM name=FocusArea VALUE="#form.farea#">
		<CFREPORTPARAM name=Strategy VALUE="#form.strategy#">
		<CFREPORTPARAM name=Prognum VALUE="#form.goal#">
		<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">	
		<CFREPORTPARAM name=ReportName VALUE="method">
		 <CFREPORTPARAM name=Monthrange VALUE="#Monthrange#">
		 <CFREPORTPARAM name=modality VALUE="#rptmodality#">
		<!--- <CFREPORTPARAM name=Monthrange VALUE="#monthrange#">	 --->	
		 </cfreport>
		 </cfoutput> --->
		 </cfif>
	</cfcase> 
	
<cfcase value = 16>

<cfparam name="session.fy" default="2005">
<cfparam name="form.stMonth" default="all">
<cfparam name="form.endmonth" default="all">
<cfparam name="form.Area" default="ALL">
<cfparam name="form.Region" default="ALL">
<cfparam name="form.Objective" default="ALL">
<cfparam name="form.fArea" default="ALL">
<cfparam name="form.goal" default="ALL">
<cfparam name="form.partner" default="ALL">
<cfparam name="form.strategy" default="ALL">
<cfparam name="form.monthrange" default="January">

<cfinclude template="qry_report_filter.cfm">

<cfif session.fy LT 2007>
<cfquery datasource="#Application.DataSource#"  		 
	password="#Application.db_password#"  		
	username="#Application.db_username#" name="Qdetails">
SELECT    distinct <!--- ar.area, ---> r. region as area, orgname, u.objective,u.activity,CAST(u.activityname AS varchar(1000))as activityname,month2,revstart,revend, f.descr as focus,
case levelChangeSought when 1 then 'local - town' when 2 then 'local - county'
when 3 then 'entire Partner catchment area' when 4 then 'state' when 5 then 'national'
when 6 then 'international' end as level,CAST(impact_imp_txt AS varchar(1000))as impact_imp_txt, m.rank, o.abbr
FROM    focusareas as f,     dbo.userActivities u LEFT OUTER JOIN
                      dbo.State_initiatives si ON u.campName = si.num AND u.year2 = si.year2 INNER JOIN
                      govt a ON u.userid = a.userid AND u.year2 = a.year2 AND u.activity=a.activity INNER JOIN
                      contact c ON u.userid = c.userid
left join area ar on c.area = ar.num
inner join region r on ar.region=r.num and ar.year2=r.year2
inner join months m on a.month2=m.mon and a.year2 = m.year2
inner join objectives o on u.objective=o.id and o.year2=u.year2
WHERE     (si.asp = 1) AND impact_imp = 1 and u.strategy = 1 and orgname is not null
and ar.year2=u.year2 and c.partnertype != 4
and u.year2=f.year2 
and u.strategy=f.num
<!--- <cfif form.area NEQ 'All' and form.partner EQ 'All'>
	and c.area='#form.area#'
</cfif>	
<cfif form.partner NEQ 'All'>
	and c.userid = '#form.partner#'
</cfif>
<cfif form.goal NEQ 'All' and form.objective EQ 'All'>
	and u.goal=#form.goal#
<cfelseif form.objective NEQ 'All'>
	and u.objective = '#form.objective#'
</cfif> 
 and g.month2 in #reReplace(monthrange, "~~", chr(39), "ALL")# --->
 <cfinclude template="report_filter.cfm">
 AND (u.del IS NULL OR u.del != 'y')
 AND u.year2=#session.fy#
union all

SELECT    distinct <!--- ar.area, ---> r. region as area, orgname, u.objective,u.activity,CAST(u.activityname AS varchar(1000))as 
activityname,month2,revstart,revend, f.descr as focus,
case pollevel when 1 then 'local - town' when 2 then 'local - county'
when 3 then 'entire Partner catchment area' when 4 then 'state' when 5 then 'national'
when 6 then 'international' end as level,CAST(impact_imp_txt AS varchar(1000))as impact_imp_txt, m.rank, o.abbr
FROM  focusareas as f,       dbo.userActivities u LEFT OUTER JOIN
                      dbo.State_initiatives si ON u.campName = si.num AND u.year2 = si.year2 INNER JOIN
                      advoc a ON u.userid = a.userid AND u.year2 = a.year2 AND u.activity=a.activity
			 INNER JOIN
                      contact c ON u.userid = c.userid 
					inner join area ar on c.area = ar.num
					inner join region r on ar.region=r.num and ar.year2=r.year2
					  inner join months m on a.month2=m.mon and a.year2 = m.year2
					  inner join objectives o on u.objective=o.id and o.year2=u.year2
WHERE     (u.strategy IN (8,9)) AND (si.asp = 1) AND impact_imp = 1 and orgname is not null
and ar.year2=u.year2 and c.partnertype != 4
and u.year2=f.year2 
and u.strategy=f.num


<cfinclude template="report_filter.cfm">
AND (u.del IS NULL OR u.del != 'y')
AND u.year2=#session.fy#
order by 1,2,5,12
</cfquery>


<cfoutput>
 

		<cfreport template="./reports/asp_org.cfr" format = "#form.format#"  query="Qdetails">
		
		<!--- <CFREPORTPARAM name=StartMonth VALUE="#form.StMonth#">
		<CFREPORTPARAM name=EndMonth VALUE="#form.endmonth#"> --->
		<CFREPORTPARAM name=Year2 VALUE="#rptfy#">
		<CFREPORTPARAM name=Area VALUE="#form.region#">
		<CFREPORTPARAM name=Objective VALUE="#form.objective#">
		<CFREPORTPARAM name=FocusArea VALUE="#form.farea#">
		<CFREPORTPARAM name=Strategy VALUE="#form.strategy#">
		<CFREPORTPARAM name=Prognum VALUE="#form.goal#">
		<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">	
		<CFREPORTPARAM name=ReportName VALUE="method">
		<CFREPORTPARAM name=Monthrange VALUE="#Monthrange#">
		<CFREPORTPARAM name=modality VALUE="#rptmodality#">
		<!--- <CFREPORTPARAM name=Monthrange VALUE="#monthrange#">	 --->	
		 </cfreport>
		 </cfoutput>
	<cfelse>
<cfquery datasource="#Application.DataSource#"  		 
	password="#Application.db_password#"  		
	username="#Application.db_username#" name="Qdetails">	
select 
<!--- ar.area, ---> r.region as area, u.userid, c.orgname, g.program as goal, 
o.objective, u.activity, u.activityname,
a.month2, f.strategy as fa,
t.target,
	
	case channel
	when '1' then 'Policy'
	when '2' then 'Resolution'	
	when '3' then 'Practice' end as channel,
	rptdate, descr, a.seq, o.abbr
	from 

PRPChange as a, 
user_target_org as t,
useractivities as u,
contact as c,
objectives as o,
program as g,
area as ar, region r,
strategy as f,
months as m

where 
a.userid=t.userid
and a.userid=u.userid
and a.activity=u.activity
and a.year2=u.year2
and a.userid=c.userid
and u.objective = o.id
and u.year2=o.year2
and u.goal=g.prognum
and u.year2=g.year2
and c.area=ar.num
and u.year2=ar.year2
and u.year2=f.year2

and ar.region=r.num
and ar.year2=r.year2

and u.strategy=f.strategy_num
and m.mon=a.month2
and m.year2 = a.year2
<!--- and u.objective in ('2b','2c','2cb', '2d', '2f', '4c','4g')
 --->
 and u.objective in 
<cfif rptfy GTE 2008>
('2B','2C','2Cb','2D','2E','2F','2G','2H','2J','2k','3G', '3C', '4c', '2i', '2L', '2M')
 and u.strategy in (1,8,9) and NOT (u.strategy=8 and u.objective='1a')	
<cfelse>
('2B','2C','2Cb','2D','2E','2F','2G','2H','2J','2k','4G', '4C', '1c', '2i')
 and u.strategy in (1,8,9) and NOT (u.strategy=8 and u.objective='3a')
</cfif>

and c.partnertype !=4
	and a.year2=t.year2
	and t.seq=a.stakeholders 
	<cfinclude template="report_filter.cfm">
AND (u.del IS NULL OR u.del != 'y')
AND u.year2=#session.fy#
	
order by 1,3,f.strategy_num,o.id,u.activity, m.rank,a.seq		
	</cfquery>


<cfoutput>
 

		<cfreport template="./reports/asp_org_new.cfr" format = "#form.format#"  query="Qdetails">
		
		<!--- <CFREPORTPARAM name=StartMonth VALUE="#form.StMonth#">
		<CFREPORTPARAM name=EndMonth VALUE="#form.endmonth#"> --->
		<CFREPORTPARAM name=Year2 VALUE="#rptfy#">
		<CFREPORTPARAM name=Area VALUE="#form.region#">
		<CFREPORTPARAM name=Objective VALUE="#form.objective#">
		<CFREPORTPARAM name=FocusArea VALUE="#form.farea#">
		<CFREPORTPARAM name=Strategy VALUE="#form.strategy#">
		<CFREPORTPARAM name=Prognum VALUE="#form.goal#">
		<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">	
		<CFREPORTPARAM name=ReportName VALUE="method">
		<CFREPORTPARAM name=Monthrange VALUE="#Monthrange#">
		<CFREPORTPARAM name=modality VALUE="#rptmodality#">
		<!--- <CFREPORTPARAM name=Monthrange VALUE="#monthrange#">	 --->	
		 </cfreport>
		 </cfoutput>	
		</cfif>
	</cfcase> 		
	
<!---	<cfcase value = 17><!--- Focus Area One --->

                        <cfparam name="session.fy" default="2005">
                        <cfparam name="form.Area" default="ALL">
                        <cfparam name="form.Objective" default="ALL">
                        <cfparam name="form.fArea" default="ALL">
                        <cfparam name="form.goal" default="ALL">
                        <cfparam name="form.partner" default="ALL">
                        <cfparam name="form.strategy" default="ALL"> 
						<cfparam name="form.Monthrange" default="ALL">
						<!--- <cfinclude template="qry_earnedmedia.cfm"> --->

                        <cfreport template="./reports/cessqtrly.cfr" format = "#form.format#" <!--- query="QEarnedMedia" --->>

                        <CFREPORTPARAM name=Area VALUE=#form.area#>
                        <CFREPORTPARAM name=Objective VALUE=#form.objective#>
                        <CFREPORTPARAM name=FocusArea VALUE="#form.farea#">
                        <CFREPORTPARAM name=Strategy VALUE="#form.strategy#">
                        <CFREPORTPARAM name=Prognum VALUE="#form.goal#">
                        <CFREPORTPARAM name=PartnerName VALUE="#form.partner#">
                        <CFREPORTPARAM name=Year2 VALUE="#rptfy#">
						<CFREPORTPARAM name=ReportName VALUE="progress">
						<CFREPORTPARAM name=Monthrange VALUE="#Monthrange#">

                        </cfreport>

            </cfcase>
	
	<cfdefaultcase>
		<cfinclude template="rpt_fa_wrapper.cfm"> 		
	</cfdefaultcase>--->
<cfcase value = 17><!--- Plannned Media --->
   
   
                        <cfparam name="session.fy" default="2005">
                        <cfparam name="form.Area" default="ALL">
						<cfparam name="form.Region" default="ALL">
                        <cfparam name="form.Objective" default="ALL">
                        <cfparam name="form.fArea" default="ALL">
                        <cfparam name="form.goal" default="ALL">
                        <cfparam name="form.partner" default="ALL">
                        <cfparam name="form.strategy" default="ALL"> 
      <cfparam name="form.Monthrange" default="ALL">
        
      <cfinclude template="qry_report_filter.cfm">
   
 <cfquery datasource="#Application.DataSource#"     
 password="#Application.db_password#"    
 username="#Application.db_username#" name="Qdetails">
   SELECT DISTINCT 
            u.userid, c.orgname, u.goal, <!--- ar.area, --->r.region as area, u.activity, 
   CASE u.tcp_fun 
   WHEN 1 THEN 'Yes' ELSE 'No' 
   END AS tcpfun, 
   u.last_sd as startdate, u.last_ed as enddate, 
   isnull(pm_media, '0') as pm_media
FROM         contact c, useractivities u, area ar, strat_campaigntarget sc, region r
WHERE     u.userid = c.userid AND ar.num = c.area AND (u.del != 'y' OR
                      u.del IS NULL) AND u.strategy = 2 and c.partnertype!=4
       and u.last_sd >= '#form.StMonth#'
       and u.last_ed <= '#form.EndMonth#'
	   and ql_ref = 1
	   and ar.year2=r.year2
	   and ar.region=r.num
<cfinclude template="report_filter.cfm">
order by u.startdate, <!--- ar.area, --->r.region, c.orgname, u.activity
</cfquery>  
 

<cfset MonthRange = form.StMonth & ' - ' & form.endmonth>

                        <cfreport template="./reports/plannedquitline.cfr" query="Qdetails" format = "#form.format#">
 
                        <CFREPORTPARAM name=Year2 VALUE="#session.fy#">
     					<CFREPORTPARAM name=Area VALUE="#form.region#">
                        <CFREPORTPARAM name=Objective VALUE="#form.objective#">
                        <CFREPORTPARAM name=FocusArea VALUE="2">
                        <CFREPORTPARAM name=Strategy VALUE="#form.strategy#">
                        <CFREPORTPARAM name=Prognum VALUE="#form.goal#">
                        <CFREPORTPARAM name=PartnerName VALUE="#form.partner#">                        
     					 <CFREPORTPARAM name=ReportName VALUE="progress">
      					<CFREPORTPARAM name=Monthrange VALUE="#monthrange#">
						<CFREPORTPARAM name=modality VALUE="#rptmodality#">
 
                        </cfreport>
 
</cfcase>

<cfcase value=19><!--- CC Brief inteventions quarterly --->
<cfparam name="form.partner" default="ALL">
<cfparam name="session.fy" default="2005">
<cfparam name="form.Area" default="ALL">
<cfparam name="form.Region" default="ALL">
<cfparam name="form.Objective" default="ALL">
<cfparam name="form.fArea" default="ALL">
<cfparam name="form.goal" default="ALL">
<cfparam name="form.strategy" default="ALL">

<cfquery datasource="#Application.DataSource#"     
 password="#Application.db_password#"    
 username="#Application.db_username#" name="Qdetails">
select
case
when c.unit IS NULL then c.NAME
else c.unit + ' ' + c.NAME
end as unitname, b.collab_id, num_screened, screen_sample, num_id, id_sample, num_interv,
method as method2, b.seq, m.descr, sum(a.patient_pop) as pop, co.orgname, 
<!--- co.area --->r.num as areaNum, <!--- ar.area, --->r.region as area, b.year2, b.q
from  region as r, area as ar ,contact as co, collaborators as c, lu_q_cess_method as m, BCIQR as b
left outer join arod as a on b.collab_id=a.collab_id and b.year2=a.year2
where
<!---  q='4'
and b.year2=2006
and  --->
b.year2=m.year2

and b.collab_id=c.seq
and b.method=m.id
and co.userid=c.userid
and co.area=ar.num
and b.year2=ar.year2

and ar.year2=r.year2
and ar.region=r.num
  and (c.del is null or c.del !=1)

	<cfif form.area NEQ 'All' and form.partner EQ 'All'>
	and co.area=#form.area#
	</cfif>
	
	<cfif form.region NEQ 'All' and form.partner EQ 'All'>
	and r.num=#form.region#
	</cfif>
	
	<cfif form.partner NEQ 'All'>
	and co.userid = '#form.partner#'
	</cfif>
	and (
	(b.year2 > #form.styear# OR (b.year2=#form.styear# and q >= #form.stquarter#))
	and (b.year2 < #form.endyear# OR (b.year2=#form.endyear# and q <= #form.endquarter#))
	) 
group by c.unit, c.name,  b.collab_id, num_screened, screen_sample, num_id,
id_sample, num_interv, method, b.seq, co.orgname, <!--- co.area, --->  m.descr, <!--- ar.area, --->r.num, r.region, b.year2, b.q

	
order by 14,12,1,15,16
</cfquery>

<cfoutput>
	<cfreport template="./reports/briefinterv2.cfr" format = "#form.format#" query="Qdetails">
		
		<CFREPORTPARAM name=Year2 VALUE="#rptfy#">
		<CFREPORTPARAM name=Area VALUE="#form.region#">
		<CFREPORTPARAM name=Objective VALUE="All">
		<CFREPORTPARAM name=FocusArea VALUE="All">
		<CFREPORTPARAM name=Strategy VALUE="All">
		<CFREPORTPARAM name=Prognum VALUE="All">
		<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">	
		<CFREPORTPARAM name=ReportName VALUE="PP">
		 <CFREPORTPARAM name=StartMonth VALUE="1">
		 <CFREPORTPARAM name=EndMonth VALUE="1">		
		 <CFREPORTPARAM name=Monthrange VALUE="1">		 
		 <CFREPORTPARAM name=stYear VALUE="#form.stYear#">
		 <CFREPORTPARAM name=StQuarter VALUE="#form.stQuarter#">
		 <CFREPORTPARAM name=endYear VALUE="#form.endYear#">		 
		 <CFREPORTPARAM name=endQuarter VALUE="#form.endQuarter#">
		
	</cfreport>
</cfoutput>
</cfcase>		


<cfcase value="21">
<cfparam name="session.fy" default="2005">
<cfparam name="form.Area" default="ALL">
<cfparam name="form.Region" default="ALL">
<cfparam name="form.Objective" default="ALL">
<cfparam name="form.fArea" default="ALL">
<cfparam name="form.goal" default="ALL">
<cfparam name="form.partner" default="ALL">
<cfparam name="form.strategy" default="ALL">

<!--- Added line to filter by max quarter to date --->
<cfset filter21=" and q = (select max(q) from chcopp as c2 where a.collab_id = c2.collab_id and c2.year2=a.year2)
and  q <= #form.stquarter# and a.year2=#session.fy#">

<!--- and (
	(a.year2 > #form.styear# OR (a.year2=#form.styear# and q >= #form.stquarter#))
	and (a.year2 < #form.endyear# OR (a.year2=#form.endyear# and q <= #form.endquarter#))
	) " --->
	
<cfif form.area NEQ 'All' and form.partner EQ 'All'>
	<cfset filter21= filter21 & "and c.area=#form.area# and a.year2=#session.fy#">
</cfif>	
<cfif isDefined("form.modality") and form.modality NEQ "ALL">
			<cfset filter21= filter21 & "and (c.partnertype = #form.modality#) and a.year2=#session.fy#">
</cfif> 
<cfif form.partner NEQ 'All'>
	<cfset filter21= filter21 & "and c.userid = '#form.partner#' and a.year2=#session.fy#">
</cfif>


<cfquery datasource="#Application.DataSource#"     
 password="#Application.db_password#"    
 username="#Application.db_username#" name="Q21">
 select
count(*) as numrecords,
sum(case rb1 when 1 then 1 else 0 end) as rb1,
sum (case rb1 when 1 then case rb2 when 1 then 1 else 0 end else 0 end) as rb2,
sum (case rb1 when 1 then case rb3 when 1 then 1 else 0 end else 0 end) as rb3,
sum (case rb1 when 1 then case rb4 when 1 then 1 else 0 end else 0 end) as rb4,
sum (case rb1 when 1 then case rb5 when 1 then 1 else 0 end else 0 end) as rb5,
sum (case rb1 when 1 then case rb6 when 1 then 1 else 0 end else 0 end) as rb6,
sum (case rb1 when 1 then case rb7 when 1 then 1 else 0 end else 0 end) as rb7,


sum (case rb1 when 1 then case rb12 when 1 then 1 when 3 then 1 else 0 end else 0 end) as rb12,
sum (case rb1 when 1 then case rb13 when 1 then 1 when 3 then 1 else 0 end else 0 end) as rb13,
sum (case rb1 when 1 then case rb15 when 1 then 1 when 3 then 1 else 0 end else 0 end) as rb15,
sum (case rb1 when 1 then case rb14 when 1 then 1 when 3 then 1 else 0 end else 0 end) as rb14,


sum(case rb8 when 1 then 1 else 0 end) as rb8,
sum(case rb9 when 0 then 0 else 1 end) as rb9,
sum(case rb10 when 0 then 0 else 1 end) as rb10,
sum(case rb11 when 1 then 1 else 0 end) as rb11,

sum(case org_id_a when 1 then 1 else 0 end) as org_id_a,
sum(case compliance_a when 1 then 1 else 0 end) as compliance_a
from chcopp as a, collaborators as b, contact as c
where
a.collab_id=b.seq
and c.userid=a.userid


#preservesinglequotes(filter21)#
</cfquery>



<cfreport template="./reports/rpt_21.cfr" format = "#form.format#" query="Q21">
		
		
		<CFREPORTPARAM name=filter21 VALUE="#preservesinglequotes(filter21)#">
		<CFREPORTPARAM name=Year2 VALUE="#rptfy#">
		<CFREPORTPARAM name=Area VALUE="#form.region#">
		<CFREPORTPARAM name=Objective VALUE="All">
		<CFREPORTPARAM name=FocusArea VALUE="All">
		<CFREPORTPARAM name=Strategy VALUE="All">
		<CFREPORTPARAM name=Prognum VALUE="All">
		<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">	
		<CFREPORTPARAM name=ReportName VALUE="PP">		
		 <CFREPORTPARAM name=Monthrange VALUE="1">		 
		 <!--- <CFREPORTPARAM name=stYear VALUE="#form.rptfy#"> --->
		 <CFREPORTPARAM name=StQuarter VALUE="#form.stQuarter#">
		<!---  <CFREPORTPARAM name=endYear VALUE="#form.endYear#">		 
		 <CFREPORTPARAM name=endQuarter VALUE="#form.endQuarter#"> --->
		 <CFREPORTPARAM name=modality VALUE="#rptmodality#">
		 
</cfreport>
</cfcase>



	
<cfcase value = 22><!--- Joint Partne sTRATEGY --->
						 <cfquery datasource="#Application.DataSource#"     
 password="#Application.db_password#"    
 username="#Application.db_username#" name="Qdetails">
 						select u.activity, cast(u.activityname as varchar(8000)) as activityname,
						c.orgname, f.strategy as focusarea, 'Active' as status
						from useractivities as u,
						contact as c,
						shareduseractivities as s,
						strategy as f, area as ar, region as r
						where
						u.activity=s.activity
						and u.year2=s.year2
						and s.userid=c.userid
						and f.year2=u.year2
						and u.strategy=f.strategy_num
						and c.area=ar.num
						and u.year2=ar.year2
						and ar.year2=r.year2
						and ar.region=r.num
						and u.year2 =#session.fy#
						<cfif isDefined("form.area") and form.area NEQ "ALL">
						and c.area ='#form.area#'
						</cfif>
						<cfif isDefined("form.region") and  form.region NEQ "ALL">
						and r.num ='#form.region#'
						</cfif>
						<cfif isDefined("form.modality") and form.modality NEQ "ALL">
						and (c.partnertype = #form.modality#)
						</cfif> 
						UNION
						select s.activity, NULL, c.orgname, NULL, 'Inactive'
						from shareduseractivities as s, contact as c, region as r, area as ar
						where s.userid=c.userid
						and  s.year2=#session.fy#
						and s.activity NOT IN (
						select distinct u.activity
						from useractivities as u,
						contact as c,
						shareduseractivities as s,
						strategy as f, area as ar, region as r
						where
						u.activity=s.activity
						and u.year2=s.year2
						and s.userid=c.userid
						and f.year2=u.year2
						and u.strategy=f.strategy_num
						and c.area=ar.num
						and u.year2=ar.year2
						and ar.year2=r.year2
						and ar.region=r.num
						and u.year2 =#session.fy#
						 <cfif isDefined("form.area") and form.area NEQ "ALL">
						and c.area ='#form.area#'
						</cfif>
						<cfif isDefined("form.region") and  form.region NEQ "ALL">
						and r.num ='#form.region#'
						</cfif>
						)
						and c.area=ar.num
						and s.year2=ar.year2
						and ar.year2=r.year2
						<cfif isDefined("form.area") and form.area NEQ "ALL">
						and c.area ='#form.area#'
						</cfif>
						<cfif isDefined("form.region") and  form.region NEQ "ALL">
						and r.num ='#form.region#'
						</cfif>
						<cfif isDefined("form.modality") and form.modality NEQ "ALL">
						and (c.partnertype = #form.modality#)
						</cfif> 
						order by 5,1,3
</cfquery>
 <cfif form.region NEQ "ALL">
 <cfquery datasource="#Application.DataSource#"     
 password="#Application.db_password#"    
 username="#Application.db_username#" name="QArea">
 <!--- select area from area
 where num=#form.area#
 and year2=#session.fy# --->
select region as area from region
 where num=#form.region#
 and year2=#session.fy#

 </cfquery>
 </cfif>
                        <cfreport template="./reports/JPS.cfr"  format = "#form.format#" query="Qdetails"> 
                        <CFREPORTPARAM name=Year2 VALUE="#session.fy#"> 
						<CFREPORTPARAM name=Area VALUE="#form.region#">
						<cfif isDefined("Qarea")>
							<CFREPORTPARAM name=Area2 VALUE="#QArea.area#">
						<cfelse>
							<CFREPORTPARAM name=Area2 VALUE="Statewide">
						</cfif>
						
 
                        </cfreport>
 
            </cfcase>
			
<cfcase value = 23>
   
<cfparam name="session.fy" default="2005">
<cfparam name="form.Area" default="ALL">
<cfparam name="form.Region" default="ALL">
<cfparam name="form.Objective" default="ALL">
<cfparam name="form.fArea" default="ALL">
<cfparam name="form.goal" default="ALL">
<cfparam name="form.partner" default="ALL">
<cfparam name="form.strategy" default="ALL"> 
<cfparam name="form.Monthrange" default="ALL">

<cfinclude template="qry_report_filter.cfm">

<cfquery datasource="#Application.DataSource#"  		 
	password="#Application.db_password#"  		
	username="#Application.db_username#" name="Qsummary">
SELECT  distinct u.userid,
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1) 	
WHEN  '*' THEN  'JOINT' 
<!--- ELSE (SELECT AR.AREA FROM AREA AR WHERE AR.NUM = C.AREA AND AR.YEAR2='2007' )  END AREA , --->
ELSE (SELECT r.region FROM AREA ARa, region R WHERE R.NUM=ARa.REGION and ARa.NUM = C.AREA AND R.year2=ara.year2 and ARa.YEAR2='2007' )  END AREA ,
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1)
WHEN '*' THEN 'SHARED'
ELSE ORGNAME END ORGNAME ,
U.ACTIVITY STRATEGY, LTRIM(RTRIM(CAST(U.ACTIVITYNAME AS VARCHAR(4000)))) STRATEGY_DESCRIPTION, A.MONTH2,
P.PROGRAM  GOAL, O.OBJECTIVE, U.STARTDATE, U.ENDDATE,
cast(A.BARRIERS as varchar (2200)) as barriers, 
cast(A.SUCCESS as varchar (2200)) as success, 
cast(A.PROGRESS as varchar (2200)) as progress, 
m.rank, 
	'' as progress_2, '' as progress_3, '' as progress_4, '' as progress_5,
	'' as success_2, '' as success_3, '' as success_4, '' as success_5,
	'' as barriers_2, '' as barriers_3, '' as barriers_4, '' as barriers_5, ar.strategy as farea, ar.strategy_num as fnum
FROM  Strategy as AR, PROGRAM  P, OBJECTIVES O,  ADVOC A, MONTHS M, USERACTIVITIES U
left outer join contact as c on 
u.userid=c.userid
	WHERE   U.GOAL=P.PROGNUM AND U.YEAR2=P.YEAR2
 	AND U.OBJECTIVE=O.[ID]AND U.YEAR2=O.YEAR2
 	AND A.YEAR2 = U.YEAR2 AND U.USERID=A.USERID
	AND U.ACTIVITY=A.ACTIVITY
	AND A.MONTH2=M.MON and a.year2 = m.year2
	AND A.YEAR2=AR.YEAR2
        AND u.strategy=ar.strategy_num
and u.year2=#session.fy#
AND (U.DEL IS NULL OR U.DEL != 'Y') AND U.STRATEGY=9 AND A.BARRIERS IS NOT NULL 
<cfinclude template="report_filter_joint.cfm">
UNION
SELECT  distinct u.userid,
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1) 	
WHEN  '*' THEN  'JOINT' 
<!--- ELSE (SELECT AR.AREA FROM AREA AR WHERE AR.NUM = C.AREA AND AR.YEAR2='2007' )  END AREA , --->
ELSE (SELECT r.region FROM AREA ARa, region R WHERE R.NUM=ARa.REGION and ARa.NUM = C.AREA AND R.year2=ara.year2 and ARa.YEAR2='2007' )  END AREA ,
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1)
WHEN '*' THEN 'SHARED'
ELSE ORGNAME END ORGNAME ,
U.ACTIVITY STRATEGY, LTRIM(RTRIM(CAST(U.ACTIVITYNAME AS VARCHAR(4000)))) STRATEGY_DESCRIPTION, A.MONTH2,
P.PROGRAM  GOAL, O.OBJECTIVE, U.STARTDATE, U.ENDDATE,
cast(A.BARRIERS as varchar (2200)) as barriers, 
cast(A.SUCCESS as varchar (2200)) as success, 
cast(A.PROGRESS as varchar (2200)) as progress,  m.rank, 
	'' as progress_2, '' as progress_3, '' as progress_4, '' as progress_5,
	'' as success_2, '' as success_3, '' as success_4, '' as success_5,
	'' as barriers_2, '' as barriers_3, '' as barriers_4, '' as barriers_5, ar.strategy as farea, ar.strategy_num as fnum
FROM  Strategy as AR, PROGRAM  P, OBJECTIVES O,  GOVT A, MONTHS M, USERACTIVITIES U
left outer join contact as c on 
u.userid=c.userid
	WHERE   U.GOAL=P.PROGNUM AND U.YEAR2=P.YEAR2
 	AND U.OBJECTIVE=O.[ID]AND U.YEAR2=O.YEAR2
 	AND A.YEAR2 = U.YEAR2 AND U.USERID=A.USERID
	AND U.ACTIVITY=A.ACTIVITY
	AND A.MONTH2=M.MON and a.year2=m.year2
	AND A.YEAR2=AR.YEAR2
        AND u.strategy=ar.strategy_num
and u.year2=#session.fy# and u.userid = 'shared'
AND (U.DEL IS NULL OR U.DEL != 'Y') AND U.STRATEGY=1 AND A.BARRIERS IS NOT NULL 
<cfinclude template="report_filter_joint.cfm">
UNION
SELECT  distinct u.userid,
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1) 	
WHEN  '*' THEN  'JOINT' 
<!--- ELSE (SELECT AR.AREA FROM AREA AR WHERE AR.NUM = C.AREA AND AR.YEAR2='2007' )  END AREA , --->
ELSE (SELECT r.region FROM AREA ARa, region R WHERE R.NUM=ARa.REGION and ARa.NUM = C.AREA AND R.year2=ara.year2 and ARa.YEAR2='2007' )  END AREA ,
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1)
WHEN '*' THEN 'SHARED'
ELSE ORGNAME END ORGNAME ,
U.ACTIVITY STRATEGY, LTRIM(RTRIM(CAST(U.ACTIVITYNAME AS VARCHAR(4000)))) STRATEGY_DESCRIPTION, A.MONTH2,
P.PROGRAM  GOAL, O.OBJECTIVE, U.STARTDATE, U.ENDDATE,
cast(A.BARRIERS as varchar (2200)) as barriers, 
cast(A.SUCCESS as varchar (2200)) as success, 
cast(A.PROGRESS as varchar (2200)) as progress,  m.rank, 
	'' as progress_2, '' as progress_3, '' as progress_4, '' as progress_5,
	'' as success_2, '' as success_3, '' as success_4, '' as success_5,
	'' as barriers_2, '' as barriers_3, '' as barriers_4, '' as barriers_5, ar.strategy as farea, ar.strategy_num as fnum
FROM  Strategy as AR, PROGRAM  P, OBJECTIVES O,  PAIDMEDIA A, MONTHS M, USERACTIVITIES U
left outer join contact as c on 
u.userid=c.userid
	WHERE   U.GOAL=P.PROGNUM AND U.YEAR2=P.YEAR2
 	AND U.OBJECTIVE=O.[ID]AND U.YEAR2=O.YEAR2
 	AND A.YEAR2 = U.YEAR2 AND U.USERID=A.USERID
	AND U.ACTIVITY=A.ACTIVITY
	AND A.MONTH2=M.MON and a.year2 = m.year2
	AND A.YEAR2=AR.YEAR2
        AND u.strategy=ar.strategy_num
and u.year2=#session.fy# and u.userid = 'shared'
AND (U.DEL IS NULL OR U.DEL != 'Y') AND U.STRATEGY=2 AND A.BARRIERS IS NOT NULL 
<cfinclude template="report_filter_joint.cfm">
UNION
SELECT  distinct u.userid,
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1) 	
WHEN  '*' THEN  'JOINT' 
<!--- ELSE (SELECT AR.AREA FROM AREA AR WHERE AR.NUM = C.AREA AND AR.YEAR2='2007' )  END AREA , --->
ELSE (SELECT r.region FROM AREA ARa, region R WHERE R.NUM=ARa.REGION and ARa.NUM = C.AREA AND R.year2=ara.year2 and ARa.YEAR2='2007' )  END AREA ,
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1)
WHEN '*' THEN 'SHARED'
ELSE ORGNAME END ORGNAME ,
U.ACTIVITY STRATEGY, LTRIM(RTRIM(CAST(U.ACTIVITYNAME AS VARCHAR(4000)))) STRATEGY_DESCRIPTION, A.MONTH2,
P.PROGRAM  GOAL, O.OBJECTIVE, U.STARTDATE, U.ENDDATE,
cast(A.BARRIERS as varchar (2200)) as barriers, 
cast(A.SUCCESS as varchar (2200)) as success, 
cast(A.PROGRESS as varchar (2200)) as progress,  m.rank, 
	'' as progress_2, '' as progress_3, '' as progress_4, '' as progress_5,
	'' as success_2, '' as success_3, '' as success_4, '' as success_5,
	'' as barriers_2, '' as barriers_3, '' as barriers_4, '' as barriers_5, ar.strategy as farea, ar.strategy_num as fnum
FROM  Strategy as AR, PROGRAM  P, OBJECTIVES O,  FORUM A, MONTHS M, USERACTIVITIES U
left outer join contact as c on 
u.userid=c.userid
	WHERE   U.GOAL=P.PROGNUM AND U.YEAR2=P.YEAR2
 	AND U.OBJECTIVE=O.[ID]AND U.YEAR2=O.YEAR2
 	AND A.YEAR2 = U.YEAR2 AND U.USERID=A.USERID
	AND U.ACTIVITY=A.ACTIVITY
	AND A.MONTH2=M.MON and a.year2 = m.year2
	AND A.YEAR2=AR.YEAR2
        AND u.strategy=ar.strategy_num
and u.year2=#session.fy# and u.userid = 'shared'
AND (U.DEL IS NULL OR U.DEL != 'Y') AND U.STRATEGY=4 AND A.BARRIERS IS NOT NULL 
<cfinclude template="report_filter_joint.cfm">
UNION
SELECT  distinct u.userid,
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1) 	
WHEN  '*' THEN  'JOINT' 
<!--- ELSE (SELECT AR.AREA FROM AREA AR WHERE AR.NUM = C.AREA AND AR.YEAR2='2007' )  END AREA , --->
ELSE (SELECT r.region FROM AREA ARa, region R WHERE R.NUM=ARa.REGION and ARa.NUM = C.AREA AND R.year2=ara.year2 and ARa.YEAR2='2007' )  END AREA ,
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1)
WHEN '*' THEN 'SHARED'
ELSE ORGNAME END ORGNAME ,
U.ACTIVITY STRATEGY, LTRIM(RTRIM(CAST(U.ACTIVITYNAME AS VARCHAR(4000)))) STRATEGY_DESCRIPTION, A.MONTH2,
P.PROGRAM  GOAL, O.OBJECTIVE, U.STARTDATE, U.ENDDATE,
cast(A.BARRIERS as varchar (2200)) as barriers, 
cast(A.SUCCESS as varchar (2200)) as success, 
cast(A.PROGRESS as varchar (2200)) as progress,  m.rank, 
	'' as progress_2, '' as progress_3, '' as progress_4, '' as progress_5,
	'' as success_2, '' as success_3, '' as success_4, '' as success_5,
	'' as barriers_2, '' as barriers_3, '' as barriers_4, '' as barriers_5, ar.strategy as farea, ar.strategy_num as fnum
FROM  Strategy as AR, PROGRAM  P, OBJECTIVES O,  MONITOR A, MONTHS M, USERACTIVITIES U
left outer join contact as c on 
u.userid=c.userid
	WHERE   U.GOAL=P.PROGNUM AND U.YEAR2=P.YEAR2
 	AND U.OBJECTIVE=O.[ID]AND U.YEAR2=O.YEAR2
 	AND A.YEAR2 = U.YEAR2 AND U.USERID=A.USERID
	AND U.ACTIVITY=A.ACTIVITY
	AND A.MONTH2=M.MON and a.year2 = m.year2
	AND A.YEAR2=AR.YEAR2
        AND u.strategy=ar.strategy_num
and u.year2=#session.fy# and u.userid = 'shared'
AND (U.DEL IS NULL OR U.DEL != 'Y') AND U.STRATEGY=5 AND A.BARRIERS IS NOT NULL 
<cfinclude template="report_filter_joint.cfm">
UNION
SELECT  distinct u.userid,
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1) 	
WHEN  '*' THEN  'JOINT' 
<!--- ELSE (SELECT AR.AREA FROM AREA AR WHERE AR.NUM = C.AREA AND AR.YEAR2='2007' )  END AREA , --->
ELSE (SELECT r.region FROM AREA ARa, region R WHERE R.NUM=ARa.REGION and ARa.NUM = C.AREA AND R.year2=ara.year2 and ARa.YEAR2='2007' )  END AREA ,
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1)
WHEN '*' THEN 'SHARED'
ELSE ORGNAME END ORGNAME ,
U.ACTIVITY STRATEGY, LTRIM(RTRIM(CAST(U.ACTIVITYNAME AS VARCHAR(4000)))) STRATEGY_DESCRIPTION, A.MONTH2,
P.PROGRAM  GOAL, O.OBJECTIVE, U.STARTDATE, U.ENDDATE,
cast(A.BARRIERS as varchar (2200)) as barriers, 
cast(A.SUCCESS as varchar (2200)) as success, 
cast(A.PROGRESS as varchar (2200)) as progress,  m.rank, 
	'' as progress_2, '' as progress_3, '' as progress_4, '' as progress_5,
	'' as success_2, '' as success_3, '' as success_4, '' as success_5,
	'' as barriers_2, '' as barriers_3, '' as barriers_4, '' as barriers_5, ar.strategy as farea, ar.strategy_num as fnum
FROM  Strategy as AR, PROGRAM  P, OBJECTIVES O,  SURVEYPUB A, MONTHS M, USERACTIVITIES U
left outer join contact as c on 
u.userid=c.userid
	WHERE   U.GOAL=P.PROGNUM AND U.YEAR2=P.YEAR2
 	AND U.OBJECTIVE=O.[ID]AND U.YEAR2=O.YEAR2
 	AND A.YEAR2 = U.YEAR2 AND U.USERID=A.USERID
	AND U.ACTIVITY=A.ACTIVITY
	AND A.MONTH2=M.MON and a.year2 = m.year2
	AND A.YEAR2=AR.YEAR2
        AND u.strategy=ar.strategy_num
and u.year2=#session.fy# and u.userid = 'shared'
AND (U.DEL IS NULL OR U.DEL != 'Y') AND U.STRATEGY=6 AND A.BARRIERS IS NOT NULL 
<cfinclude template="report_filter_joint.cfm">
UNION
SELECT  distinct u.userid,
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1) 	
WHEN  '*' THEN  'JOINT' 
<!--- ELSE (SELECT AR.AREA FROM AREA AR WHERE AR.NUM = C.AREA AND AR.YEAR2='2007' )  END AREA , --->
ELSE (SELECT r.region FROM AREA ARa, region R WHERE R.NUM=ARa.REGION and ARa.NUM = C.AREA AND R.year2=ara.year2 and ARa.YEAR2='2007' )  END AREA ,
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1)
WHEN '*' THEN 'SHARED'
ELSE ORGNAME END ORGNAME ,
U.ACTIVITY STRATEGY, LTRIM(RTRIM(CAST(U.ACTIVITYNAME AS VARCHAR(4000)))) STRATEGY_DESCRIPTION, A.MONTH2,
P.PROGRAM  GOAL, O.OBJECTIVE, U.STARTDATE, U.ENDDATE,
cast(A.BARRIERS as varchar (2200)) as barriers, 
cast(A.SUCCESS as varchar (2200)) as success, 
cast(A.PROGRESS as varchar (2200)) as progress,  m.rank, 
	'' as progress_2, '' as progress_3, '' as progress_4, '' as progress_5,
	'' as success_2, '' as success_3, '' as success_4, '' as success_5,
	'' as barriers_2, '' as barriers_3, '' as barriers_4, '' as barriers_5, ar.strategy as farea, ar.strategy_num as fnum
FROM  Strategy as AR, PROGRAM  P, OBJECTIVES O,  CESSATION A, MONTHS M, USERACTIVITIES U
left outer join contact as c on 
u.userid=c.userid
	WHERE   U.GOAL=P.PROGNUM AND U.YEAR2=P.YEAR2
 	AND U.OBJECTIVE=O.[ID]AND U.YEAR2=O.YEAR2
 	AND A.YEAR2 = U.YEAR2 AND U.USERID=A.USERID
	AND U.ACTIVITY=A.ACTIVITY
	AND A.MONTH2=M.MON and a.year2 = m.year2
	AND A.YEAR2=AR.YEAR2
        AND u.strategy=ar.strategy_num
and u.year2=#session.fy# and u.userid = 'shared'
AND (U.DEL IS NULL OR U.DEL != 'Y') AND U.STRATEGY=7 AND A.BARRIERS IS NOT NULL 
<cfinclude template="report_filter_joint.cfm">
UNION
SELECT  distinct u.userid,
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1) 	
WHEN  '*' THEN  'JOINT' 
<!--- ELSE (SELECT AR.AREA FROM AREA AR WHERE AR.NUM = C.AREA AND AR.YEAR2='2007' )  END AREA , --->
ELSE (SELECT r.region FROM AREA ARa, region R WHERE R.NUM=ARa.REGION and ARa.NUM = C.AREA AND R.year2=ara.year2 and ARa.YEAR2='2007' )  END AREA ,
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1)
WHEN '*' THEN 'SHARED'
ELSE ORGNAME END ORGNAME ,
U.ACTIVITY STRATEGY, LTRIM(RTRIM(CAST(U.ACTIVITYNAME AS VARCHAR(4000)))) STRATEGY_DESCRIPTION, A.MONTH2,
P.PROGRAM  GOAL, O.OBJECTIVE, U.STARTDATE, U.ENDDATE,
cast(A.BARRIERS as varchar (2200)) as barriers, 
cast(A.SUCCESS as varchar (2200)) as success, 
cast(A.PROGRESS as varchar (2200)) as progress,  m.rank, 
	'' as progress_2, '' as progress_3, '' as progress_4, '' as progress_5,
	'' as success_2, '' as success_3, '' as success_4, '' as success_5,
	'' as barriers_2, '' as barriers_3, '' as barriers_4, '' as barriers_5, ar.strategy as farea, ar.strategy_num as fnum
FROM  Strategy as AR, PROGRAM  P, OBJECTIVES O,  ADVOC A, MONTHS M, USERACTIVITIES U
left outer join contact as c on 
u.userid=c.userid
	WHERE   U.GOAL=P.PROGNUM AND U.YEAR2=P.YEAR2
 	AND U.OBJECTIVE=O.[ID]AND U.YEAR2=O.YEAR2
 	AND A.YEAR2 = U.YEAR2 AND U.USERID=A.USERID
	AND U.ACTIVITY=A.ACTIVITY
	AND A.MONTH2=M.MON and a.year2 = m.year2
	AND A.YEAR2=AR.YEAR2
        AND u.strategy=ar.strategy_num
and u.year2=#session.fy# and u.userid = 'shared'
AND (U.DEL IS NULL OR U.DEL != 'Y') AND U.STRATEGY=9 AND A.BARRIERS IS NOT NULL 
<cfinclude template="report_filter_joint.cfm">
UNION
SELECT  distinct u.userid,
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1) 	
WHEN  '*' THEN  'JOINT' 
<!--- ELSE (SELECT AR.AREA FROM AREA AR WHERE AR.NUM = C.AREA AND AR.YEAR2='2007' )  END AREA , --->
ELSE (SELECT r.region FROM AREA ARa, region R WHERE R.NUM=ARa.REGION and ARa.NUM = C.AREA AND R.year2=ara.year2 and ARa.YEAR2='2007' )  END AREA ,
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1)
WHEN '*' THEN 'SHARED'
ELSE ORGNAME END ORGNAME ,
U.ACTIVITY STRATEGY, LTRIM(RTRIM(CAST(U.ACTIVITYNAME AS VARCHAR(4000)))) STRATEGY_DESCRIPTION, A.MONTH2,
P.PROGRAM  GOAL, O.OBJECTIVE, U.STARTDATE, U.ENDDATE,
cast(A.BARRIERS as varchar (2200)) as barriers, 
cast(A.SUCCESS as varchar (2200)) as success, 
cast(A.PROGRESS as varchar (2200)) as progress,  m.rank, 
	'' as progress_2, '' as progress_3, '' as progress_4, '' as progress_5,
	'' as success_2, '' as success_3, '' as success_4, '' as success_5,
	'' as barriers_2, '' as barriers_3, '' as barriers_4, '' as barriers_5, ar.strategy as farea, ar.strategy_num as fnum
FROM  Strategy as AR, PROGRAM  P, OBJECTIVES O,  ADVOC A, MONTHS M, USERACTIVITIES U
left outer join contact as c on 
u.userid=c.userid
	WHERE   U.GOAL=P.PROGNUM AND U.YEAR2=P.YEAR2
 	AND U.OBJECTIVE=O.[ID]AND U.YEAR2=O.YEAR2
 	AND A.YEAR2 = U.YEAR2 AND U.USERID=A.USERID
	AND U.ACTIVITY=A.ACTIVITY
	AND A.MONTH2=M.MON and a.year2=m.year2
	AND A.YEAR2=AR.YEAR2
        AND u.strategy=ar.strategy_num
and u.year2=#session.fy# and u.userid = 'shared'
and (U.DEL IS NULL OR U.DEL != 'Y') AND U.STRATEGY=8 AND (A.BARRIERS IS NOT NULL 
	OR A.PROGRESS_2 IS NOT NULL OR A.PROGRESS_3 IS NOT NULL OR A.PROGRESS_4 IS NOT NULL OR A.PROGRESS_5 IS NOT NULL
	OR A.SUCCESS_2 IS NOT NULL OR A.SUCCESS_3 IS NOT NULL OR A.SUCCESS_4 IS NOT NULL OR A.SUCCESS_5 IS NOT NULL
	OR A.BARRIERS_2 IS NOT NULL OR A.BARRIERS_3 IS NOT NULL OR A.BARRIERS_4 IS NOT NULL OR A.BARRIERS_5 IS NOT NULL
	)
<cfinclude template="report_filter_joint.cfm">
order by 1, 2, 3, 13
</cfquery>
        
<cfreport template="./reports/JntStratProgSummaryParam.cfr" format = "#form.format#" query="Qsummary">
 
<CFREPORTPARAM name=Year2 VALUE="#session.fy#">
<CFREPORTPARAM name=Area VALUE="#form.region#">
<CFREPORTPARAM name=Objective VALUE="#form.objective#">
<CFREPORTPARAM name=FocusArea VALUE="#form.farea#">
<CFREPORTPARAM name=Strategy VALUE="#form.strategy#">
<CFREPORTPARAM name=Prognum VALUE="#form.goal#">
<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">                        
<CFREPORTPARAM name=ReportName VALUE="progress">
<CFREPORTPARAM name=Monthrange VALUE="#monthrange6#">
<CFREPORTPARAM name=modality VALUE="#rptmodality#">
 
</cfreport>
 
</cfcase>
<cfcase value = 24>
	
		

<cfparam name="session.fy" default="2005">
<cfparam name="form.stMonth" default="all">
<cfparam name="form.endmonth" default="all">
<cfparam name="form.Area" default="ALL">
<cfparam name="form.Region" default="ALL">
<cfparam name="form.Objective" default="ALL">
<cfparam name="form.fArea" default="ALL">
<cfparam name="form.goal" default="ALL">
<cfparam name="form.partner" default="ALL">
<cfparam name="form.strategy" default="ALL">

<cfquery datasource="#Application.DataSource#"  		 
	password="#Application.db_password#"  		
	username="#Application.db_username#" name="QPP">
SELECT    
count (distinct a.collab_id) as num_collab, 
isnull(sum(isnull(a.num_screened,0)),0) as num_screened, 
isnull(sum(isnull(a.screen_sample,0)),0) as screen_sample, 
isnull(sum(isnull(a.num_id,0)),0) as num_id, 
isnull(sum(isnull(a.id_sample,0)),0) as id_sample, 
isnull(sum(isnull(a.num_interv,0)),0) as num_interv 
FROM      area as ar, region as r, dbo.BCIQR as a, contact as c, collaborators as b
where 
a.collab_id=b.seq
and c.area=ar.num
and ar.region=r.num
and ar.year2=a.year2
and ar.year2=r.year2
  and (b.del is null or b.del !=1)
	and b.userid=c.userid
	<cfif form.area NEQ 'All' and form.partner EQ 'All'>
	and c.area=#form.area#
	</cfif>
	<cfif form.region NEQ 'All' and form.partner EQ 'All'>
	and r.num=#form.region#
	</cfif>
	
	<cfif form.partner NEQ 'All'>
	and c.userid = '#form.partner#'
	</cfif>
	<cfif isDefined("form.modality") and form.modality NEQ "ALL">
			and (c.partnertype = #form.modality#)
	</cfif> 
	and (
	(a.year2 > #form.styear# OR (a.year2=#form.styear# and q >= #form.stquarter#))
	and (a.year2 < #form.endyear# OR (a.year2=#form.endyear# and q <= #form.endquarter#))
	) 

</cfquery>



<cfset subfilter2 = "select l.descr, count(a.method) AS COUNT
from
area as ar, region as r,	
lu_q_CESS_METHOD AS L
left OUTER JOIN BCIQR AS a
ON a.METHOD=L.ID
AND L.YEAR2=a.YEAR2
left outer join collaborators as b
on b.seq =a.collab_id
and l.year2=b.year2
left outer join contact as c
on c.userid=a.userid
where (b.del is null or b.del !=1)
and c.area=ar.num and ar.region=r.num and a.year2=ar.year2 and ar.year2=r.year2">
<cfif form.area NEQ 'All' and form.partner EQ 'All'>
	<cfset subfilter2 = subfilter2 & " and c.area=#form.area# ">
</cfif>
<cfif form.area NEQ 'All' and form.partner EQ 'All'>
	<cfset subfilter2 = subfilter2 & " and r.num=#form.region# ">
</cfif>
	
	<cfif form.partner NEQ 'All'>
	<cfset subfilter2 = subfilter2 & " and c.userid = '#form.partner#'">
	</cfif>
	<cfif isDefined("form.modality") and form.modality NEQ "ALL">
			<cfset subfilter2 = subfilter2 & " and (c.partnertype = #form.modality#)">
	</cfif> 
	<cfset subfilter2 = subfilter2 & " and (
	(a.year2 > #form.styear# OR (a.year2=#form.styear# and q >= #form.stquarter#))
	and (a.year2 < #form.endyear# OR (a.year2=#form.endyear# and q <= #form.endquarter#))
	) ">

<cfset subfilter2=subfilter2 &  " GROUP BY L.DESCR
ORDER BY 1">
<cfoutput>


	<cfreport template="./reports/cessintsum.cfr" format = "#form.format#" query="QPP">
		
		<CFREPORTPARAM name=Year2 VALUE="#rptfy#">
		<CFREPORTPARAM name=Area VALUE="#form.region#">
		<CFREPORTPARAM name=Objective VALUE="All">
		<CFREPORTPARAM name=FocusArea VALUE="All">
		<CFREPORTPARAM name=Strategy VALUE="All">
		<CFREPORTPARAM name=Prognum VALUE="All">
		<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">	
		<CFREPORTPARAM name=ReportName VALUE="PP">
		<!---  <CFREPORTPARAM name=StartMonth VALUE="1">
		 <CFREPORTPARAM name=EndMonth VALUE="1">		 --->
		 <CFREPORTPARAM name=Monthrange VALUE="1">		 
		 <CFREPORTPARAM name=stYear VALUE="#form.stYear#">
		 <CFREPORTPARAM name=StQuarter VALUE="#form.stQuarter#">
		 <CFREPORTPARAM name=endYear VALUE="#form.endYear#">		 
		 <CFREPORTPARAM name=endQuarter VALUE="#form.endQuarter#">
		 <CFREPORTPARAM name=subfilter VALUE="#preservesinglequotes(subfilter2)#">
		
		</cfreport>
		 </cfoutput>
	</cfcase> 
	
	
	<cfcase value = 25>
	<cfoutput>
		<cfparam name="form.Area" default="ALL">
		<cfparam name="form.Region" default="ALL">
		<cfparam name="form.Objective" default="ALL">
		<cfparam name="form.fArea" default="ALL">
		<cfparam name="form.goal" default="ALL">
		<cfparam name="form.partner" default="ALL">
		<cfparam name="form.strategy" default="ALL"> 
<cfinclude template="qry_report_filter.cfm">

<cfquery datasource="#Application.DataSource#"  		 
	password="#Application.db_password#"  		
	username="#Application.db_username#" name="QadvCC">
select u.startDate, u.endDate, u.collaborators, u.goal,
	u.objective, u.strategy, u.typepromo,
	rtrim(cast(p.progNum as char)) + ': ' + p.program as program,
	o.objective as objective2, u.userid, u.targetgroup, u.activity
,cast (progress_2 as varchar(2300)) as progress_2,
cast(barriers_2 as varchar(2300)) as barriers_2,
cast(success_2 as varchar(2300)) as success_2,  
2 as subsec
, <!--- c.area --->r.num as area, c.orgname, a.month2,
case when progress_2 is not null then 1 else
case when barriers_2 is not null then 1 else
case  when success_2 is not null then 1 else 0 end
end
end as indicator,

case when len(cast(progress_2 as varchar)) >0 then 1 else
case when len(cast(barriers_2 as varchar)) >0 then 1 else
case  when len(cast(success_2 as varchar)) >0 then 1 else 0
end
end
end as indicator2, m.rank
	from useractivities as u, program as p, objectives as o
,advoc as a, contact as c, months as m, area as ar, region as r
	where
	p.progNum=u.goal
	and o.ID=u.objective
	and u.year2=#rptfy#
	and u.year2=p.year2
	and u.year2=o.year2
and u.year2=a.year2
and u.userid=a.userid
and u.activity=a.activity
and u.strategy=8
and
((u.targetgroup = 1 and  <cfif session.fy GTE 2008>u.goal =1<cfelse>u.goal =3</cfif> and u.year2 > 2005)
 OR (u.targetgroup =1 and u.year2 <= 2005))
  and (u.del is null or u.del !=1)
and a.status='On-going'
and c.userid=u.userid
and a.month2=m.mon
and c.area=ar.num
and u.year2=ar.year2
and ar.year2=r.year2
and ar.region=r.num
and a.month2 in (#preserveSingleQuotes(monthrange2)#)
<cfinclude template="report_filter.cfm">

UNION

select u.startDate, u.endDate, u.collaborators, u.goal,
	u.objective, u.strategy, u.typepromo,
	rtrim(cast(p.progNum as char)) + ': ' + p.program as program,
	o.objective as objective2, u.userid, u.targetgroup, u.activity
,cast (progress_3 as varchar(2300)) as progress_3,
cast(barriers_3 as varchar(2300)),
cast(success_3 as varchar(2300)),  3 as subsec
, <!--- c.area --->r.num as area, c.orgname, a.month2,
case when progress_3 is not null then 1 else
case when barriers_3 is not null then 1 else
case  when success_3 is not null then 1 else 0 end
end
end as indicator,

case when len(cast(progress_3 as varchar)) >0 then 1 else
case when len(cast(barriers_3 as varchar)) >0 then 1 else
case  when len(cast(success_3 as varchar)) >0 then 1 else 0
end
end
end as indicator2, m.rank
	from useractivities as u, program as p, objectives as o
,advoc as a, contact as c, months as m, area as ar, region as r
	where
	p.progNum=u.goal
	and o.ID=u.objective
	and u.year2=#rptfy#
	and u.year2=p.year2
	and u.year2=o.year2
and u.year2=a.year2
and u.userid=a.userid
and u.activity=a.activity
and u.strategy=8
and
((u.targetgroup = 1 and  <cfif session.fy GTE 2008>u.goal =1<cfelse>u.goal =3</cfif> and u.year2 > 2005)
 OR (u.targetgroup =1 and u.year2 <= 2005))
  and (u.del is null or u.del !=1)
and a.status='On-going'
and c.userid=u.userid
and a.month2=m.mon
and a.year2=m.year2
and c.area=ar.num
and u.year2=ar.year2
and ar.year2=r.year2
and ar.region=r.num
and a.month2 in (#preserveSingleQuotes(monthrange2)#)
<cfinclude template="report_filter.cfm">
union
select u.startDate, u.endDate, u.collaborators, u.goal,
	u.objective, u.strategy, u.typepromo,
	rtrim(cast(p.progNum as char)) + ': ' + p.program as program,
	o.objective as objective2, u.userid, u.targetgroup, u.activity
,cast (progress_4 as varchar(2300)) as progress_4,
cast(barriers_4 as varchar(2300)),
cast(success_4 as varchar(2300)),  4 as subsec
, <!--- c.area --->r.num as area, c.orgname, a.month2,
case when progress_4 is not null then 1 else
case when barriers_4 is not null then 1 else
case  when success_4 is not null then 1 else 0 end
end
end as indicator,

case when len(cast(progress_4 as varchar)) >0 then 1 else
case when len(cast(barriers_4 as varchar)) >0 then 1 else
case  when len(cast(success_4 as varchar)) >0 then 1 else 0
end
end
end as indicator2, m.rank
	from useractivities as u, program as p, objectives as o
,advoc as a, contact as c, months as m, area as ar, region as r
	where
	p.progNum=u.goal
	and o.ID=u.objective
	and u.year2=#rptfy#
	and u.year2=p.year2
	and u.year2=o.year2
and u.year2=a.year2
and u.userid=a.userid
and u.activity=a.activity
and u.strategy=8
and
((u.targetgroup = 1 and  <cfif session.fy GTE 2008>u.goal =1<cfelse>u.goal =3</cfif> and u.year2 > 2005)
 OR (u.targetgroup =1 and u.year2 <= 2005))
  and (u.del is null or u.del !=1)
and a.status='On-going'
and c.userid=u.userid
and a.month2=m.mon
and c.area=ar.num
and u.year2=ar.year2
and ar.year2=r.year2
and ar.region=r.num
and a.month2 in (#preserveSingleQuotes(monthrange2)#)
<cfinclude template="report_filter.cfm">
UNION
select u.startDate, u.endDate, u.collaborators, u.goal,
	u.objective, u.strategy, u.typepromo,
	rtrim(cast(p.progNum as char)) + ': ' + p.program as program,
	o.objective as objective2, u.userid, u.targetgroup, u.activity
,cast (progress_2 as varchar(2300))  as progress_5,
cast(barriers_5 as varchar(2300)),
cast(success_5 as varchar(2300)),  5 as subsec
, <!--- c.area --->r.num as area, c.orgname, a.month2,
case when progress_5 is not null then 1 else
case when barriers_5 is not null then 1 else
case  when success_5 is not null then 1 else 0 end
end
end as indicator,

case when len(cast(progress_5 as varchar)) >0 then 1 else
case when len(cast(barriers_5 as varchar)) >0 then 1 else
case  when len(cast(success_5 as varchar)) >0 then 1 else 0
end
end
end as indicator2, m.rank
	from useractivities as u, program as p, objectives as o
,advoc as a, contact as c, months as m, area as ar, region as r
	where
	p.progNum=u.goal
	and o.ID=u.objective
	and u.year2=#rptfy#
	and u.year2=p.year2
	and u.year2=o.year2
and u.year2=a.year2
and u.userid=a.userid
and u.activity=a.activity
and u.strategy=8
and
((u.targetgroup = 1 and  <cfif session.fy GTE 2008>u.goal =1<cfelse>u.goal =3</cfif> and u.year2 > 2005)
 OR (u.targetgroup =1 and u.year2 <= 2005))
  and (u.del is null or u.del !=1)
and a.status='On-going'
and c.userid=u.userid
and a.month2=m.mon and a.year2 = m.year2
and c.area=ar.num
and u.year2=ar.year2
and ar.year2=r.year2
and ar.region=r.num
and a.month2 in (#preserveSingleQuotes(monthrange2)#)
<cfinclude template="report_filter.cfm">
order by
17,18,4,5,12,16, 21,22
</cfquery>


	<cfreport template="./reports/adv_cc_10.cfr" format = "#form.format#" query="QadvCC">		
		<CFREPORTPARAM name=Year2 VALUE="#session.fy#">
		 <CFREPORTPARAM name=Month2 VALUE="#preservesinglequotes(monthrange2)#">	
		<CFREPORTPARAM name=ReportName VALUE="PP">	
		<CFREPORTPARAM name=Area VALUE="#form.region#">		
		<CFREPORTPARAM name=Objective VALUE="#form.objective#">
		<CFREPORTPARAM name=FocusArea VALUE="8">
		<CFREPORTPARAM name=Strategy VALUE="#form.strategy#">
		<CFREPORTPARAM name=Prognum VALUE="#form.goal#">
		<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">				
		 <CFREPORTPARAM name=Monthrange VALUE="#monthrange6#">		 
		 <CFREPORTPARAM name=modality VALUE="Cessation Centers">
		
		</cfreport>
	</cfoutput>
	
	</cfcase>
	
	
	
	<!--- to replace existing report look for #99 --->
	<cfcase value = 6>
   
<cfparam name="session.fy" default="2005">
<cfparam name="form.Area" default="ALL">
<cfparam name="form.Region" default="ALL">
<cfparam name="form.Objective" default="ALL">
<cfparam name="form.fArea" default="ALL">
<cfparam name="form.goal" default="ALL">
<cfparam name="form.partner" default="ALL">
<cfparam name="form.strategy" default="ALL"> 
<cfparam name="form.Monthrange" default="ALL">

<cfinclude template="qry_report_filter.cfm">

<cfif session.userid NEQ "dplotner">
<cfquery datasource="#Application.DataSource#"  		 
	password="#Application.db_password#"  		
	username="#Application.db_username#" name="Qsummary">
SELECT  distinct
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1) 	
WHEN  '*' THEN  'JOINT' 
<!--- ELSE (SELECT AR.AREA FROM AREA AR WHERE AR.NUM = C.AREA AND AR.YEAR2='2007' )  END AREA , --->
ELSE (SELECT r.region FROM AREA AR, region R WHERE R.NUM=AR.REGION and AR.NUM = C.AREA AND R.year2=ar.year2 and AR.YEAR2='2007' )  END AREA ,
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1)
WHEN '*' THEN 'SHARED'
ELSE ORGNAME END ORGNAME ,
U.ACTIVITY STRATEGY, LTRIM(RTRIM(CAST(U.ACTIVITYNAME AS VARCHAR(1500)))) STRATEGY_DESCRIPTION, A.MONTH2,
P.PROGRAM  GOAL, O.OBJECTIVE, U.STARTDATE, U.ENDDATE,
cast(A.BARRIERS as varchar(2200)) as barriers, 
cast(A.SUCCESS as varchar(2200)) as success, 
cast(A.PROGRESS as varchar(2200)) as progress, m.rank, 
	'' as progress_2, '' as progress_3, '' as progress_4, '' as progress_5,
	'' as success_2, '' as success_3, '' as success_4, '' as success_5,
	'' as barriers_2, '' as barriers_3, '' as barriers_4, '' as barriers_5
FROM  PROGRAM  P, OBJECTIVES O,  ADVOC A, MONTHS M, USERACTIVITIES U
left outer join contact as c on 
u.userid=c.userid
	WHERE   U.GOAL=P.PROGNUM AND U.YEAR2=P.YEAR2
 	AND U.OBJECTIVE=O.[ID]AND U.YEAR2=O.YEAR2
 	AND A.YEAR2 = U.YEAR2 AND U.USERID=A.USERID
	AND U.ACTIVITY=A.ACTIVITY
	AND A.MONTH2=M.MON 
and u.year2=#session.fy#
AND (U.DEL IS NULL OR U.DEL != 'Y') AND U.STRATEGY=9 AND A.BARRIERS IS NOT NULL 
<cfinclude template="report_filter.cfm">
UNION
SELECT  distinct
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1) 	
WHEN  '*' THEN  'JOINT' 
<!--- ELSE (SELECT AR.AREA FROM AREA AR WHERE AR.NUM = C.AREA AND AR.YEAR2='2007' )  END AREA , --->
ELSE (SELECT r.region FROM AREA AR, region R WHERE R.NUM=AR.REGION and AR.NUM = C.AREA AND R.year2=ar.year2 and AR.YEAR2='2007' )  END AREA ,
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1)
WHEN '*' THEN 'SHARED'
ELSE ORGNAME END ORGNAME ,
U.ACTIVITY STRATEGY, LTRIM(RTRIM(CAST(U.ACTIVITYNAME AS VARCHAR(1500)))) STRATEGY_DESCRIPTION, A.MONTH2,
P.PROGRAM  GOAL, O.OBJECTIVE, U.STARTDATE, U.ENDDATE,
CAST(A.BARRIERS AS VARCHAR (2200)), 
CAST(A.SUCCESS AS VARCHAR (2200)), 
CAST(A.PROGRESS AS VARCHAR (2200)), m.rank, 
	'' as progress_2, '' as progress_3, '' as progress_4, '' as progress_5,
	'' as success_2, '' as success_3, '' as success_4, '' as success_5,
	'' as barriers_2, '' as barriers_3, '' as barriers_4, '' as barriers_5
FROM  PROGRAM  P, OBJECTIVES O,  GOVT A, MONTHS M, USERACTIVITIES U
left outer join contact as c on 
u.userid=c.userid
	WHERE   U.GOAL=P.PROGNUM AND U.YEAR2=P.YEAR2
 	AND U.OBJECTIVE=O.[ID]AND U.YEAR2=O.YEAR2
 	AND A.YEAR2 = U.YEAR2 AND U.USERID=A.USERID
	AND U.ACTIVITY=A.ACTIVITY
	AND A.MONTH2=M.MON and a.year2 = m.year2
and u.year2=#session.fy#
AND (U.DEL IS NULL OR U.DEL != 'Y') AND U.STRATEGY=1 AND A.BARRIERS IS NOT NULL 
<cfinclude template="report_filter.cfm">
UNION
SELECT  distinct
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1) 	
WHEN  '*' THEN  'JOINT' 
<!--- ELSE (SELECT AR.AREA FROM AREA AR WHERE AR.NUM = C.AREA AND AR.YEAR2='2007' )  END AREA , --->
ELSE (SELECT r.region FROM AREA AR, region R WHERE R.NUM=AR.REGION and AR.NUM = C.AREA AND R.year2=ar.year2 and AR.YEAR2='2007' )  END AREA ,
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1)
WHEN '*' THEN 'SHARED'
ELSE ORGNAME END ORGNAME ,
U.ACTIVITY STRATEGY, LTRIM(RTRIM(CAST(U.ACTIVITYNAME AS VARCHAR(1500)))) STRATEGY_DESCRIPTION, A.MONTH2,
P.PROGRAM  GOAL, O.OBJECTIVE, U.STARTDATE, U.ENDDATE,
CAST(A.BARRIERS AS VARCHAR (2200)), 
CAST(A.SUCCESS AS VARCHAR (2200)), 
CAST(A.PROGRESS AS VARCHAR (2200)), m.rank, 
	'' as progress_2, '' as progress_3, '' as progress_4, '' as progress_5,
	'' as success_2, '' as success_3, '' as success_4, '' as success_5,
	'' as barriers_2, '' as barriers_3, '' as barriers_4, '' as barriers_5
FROM  PROGRAM  P, OBJECTIVES O,  PAIDMEDIA A, MONTHS M, USERACTIVITIES U
left outer join contact as c on 
u.userid=c.userid
	WHERE   U.GOAL=P.PROGNUM AND U.YEAR2=P.YEAR2
 	AND U.OBJECTIVE=O.[ID]AND U.YEAR2=O.YEAR2
 	AND A.YEAR2 = U.YEAR2 AND U.USERID=A.USERID
	AND U.ACTIVITY=A.ACTIVITY
	AND A.MONTH2=M.MON 
and u.year2=#session.fy#
AND (U.DEL IS NULL OR U.DEL != 'Y') AND U.STRATEGY=2 AND A.BARRIERS IS NOT NULL 
<cfinclude template="report_filter.cfm">
UNION
SELECT  distinct
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1) 	
WHEN  '*' THEN  'JOINT' 
<!--- ELSE (SELECT AR.AREA FROM AREA AR WHERE AR.NUM = C.AREA AND AR.YEAR2='2007' )  END AREA , --->
ELSE (SELECT r.region FROM AREA AR, region R WHERE R.NUM=AR.REGION and AR.NUM = C.AREA AND R.year2=ar.year2 and AR.YEAR2='2007' )  END AREA ,
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1)
WHEN '*' THEN 'SHARED'
ELSE ORGNAME END ORGNAME ,
U.ACTIVITY STRATEGY, LTRIM(RTRIM(CAST(U.ACTIVITYNAME AS VARCHAR(1500)))) STRATEGY_DESCRIPTION, A.MONTH2,
P.PROGRAM  GOAL, O.OBJECTIVE, U.STARTDATE, U.ENDDATE,
CAST(A.BARRIERS AS VARCHAR (2200)), 
CAST(A.SUCCESS AS VARCHAR (2200)), 
CAST(A.PROGRESS AS VARCHAR (2200)), m.rank, 
	'' as progress_2, '' as progress_3, '' as progress_4, '' as progress_5,
	'' as success_2, '' as success_3, '' as success_4, '' as success_5,
	'' as barriers_2, '' as barriers_3, '' as barriers_4, '' as barriers_5
FROM  PROGRAM  P, OBJECTIVES O,  FORUM A, MONTHS M, USERACTIVITIES U
left outer join contact as c on 
u.userid=c.userid
	WHERE   U.GOAL=P.PROGNUM AND U.YEAR2=P.YEAR2
 	AND U.OBJECTIVE=O.[ID]AND U.YEAR2=O.YEAR2
 	AND A.YEAR2 = U.YEAR2 AND U.USERID=A.USERID
	AND U.ACTIVITY=A.ACTIVITY
	AND A.MONTH2=M.MON and a.year2 = m.year2
and u.year2=#session.fy#
AND (U.DEL IS NULL OR U.DEL != 'Y') AND U.STRATEGY=4 AND A.BARRIERS IS NOT NULL 
<cfinclude template="report_filter.cfm">
UNION
SELECT  distinct
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1) 	
WHEN  '*' THEN  'JOINT' 
<!--- ELSE (SELECT AR.AREA FROM AREA AR WHERE AR.NUM = C.AREA AND AR.YEAR2='2007' )  END AREA , --->
ELSE (SELECT r.region FROM AREA AR, region R WHERE R.NUM=AR.REGION and AR.NUM = C.AREA AND R.year2=ar.year2 and AR.YEAR2='2007' )  END AREA ,
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1)
WHEN '*' THEN 'SHARED'
ELSE ORGNAME END ORGNAME ,
U.ACTIVITY STRATEGY, LTRIM(RTRIM(CAST(U.ACTIVITYNAME AS VARCHAR(1500)))) STRATEGY_DESCRIPTION, A.MONTH2,
P.PROGRAM  GOAL, O.OBJECTIVE, U.STARTDATE, U.ENDDATE,
CAST(A.BARRIERS AS VARCHAR (2200)), 
CAST(A.SUCCESS AS VARCHAR (2200)), 
CAST(A.PROGRESS AS VARCHAR (2200)), m.rank, 
	'' as progress_2, '' as progress_3, '' as progress_4, '' as progress_5,
	'' as success_2, '' as success_3, '' as success_4, '' as success_5,
	'' as barriers_2, '' as barriers_3, '' as barriers_4, '' as barriers_5
FROM  PROGRAM  P, OBJECTIVES O,  MONITOR A, MONTHS M, USERACTIVITIES U
left outer join contact as c on 
u.userid=c.userid
	WHERE   U.GOAL=P.PROGNUM AND U.YEAR2=P.YEAR2
 	AND U.OBJECTIVE=O.[ID]AND U.YEAR2=O.YEAR2
 	AND A.YEAR2 = U.YEAR2 AND U.USERID=A.USERID
	AND U.ACTIVITY=A.ACTIVITY
	AND A.MONTH2=M.MON 
and u.year2=#session.fy#
AND (U.DEL IS NULL OR U.DEL != 'Y') AND U.STRATEGY=5 AND A.BARRIERS IS NOT NULL 
<cfinclude template="report_filter.cfm">
UNION
SELECT  distinct
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1) 	
WHEN  '*' THEN  'JOINT' 
<!--- ELSE (SELECT AR.AREA FROM AREA AR WHERE AR.NUM = C.AREA AND AR.YEAR2='2007' )  END AREA , --->
ELSE (SELECT r.region FROM AREA AR, region R WHERE R.NUM=AR.REGION and AR.NUM = C.AREA AND R.year2=ar.year2 and AR.YEAR2='2007' )  END AREA ,
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1)
WHEN '*' THEN 'SHARED'
ELSE ORGNAME END ORGNAME ,
U.ACTIVITY STRATEGY, LTRIM(RTRIM(CAST(U.ACTIVITYNAME AS VARCHAR(1500)))) STRATEGY_DESCRIPTION, A.MONTH2,
P.PROGRAM  GOAL, O.OBJECTIVE, U.STARTDATE, U.ENDDATE,
CAST(A.BARRIERS AS VARCHAR (2200)), 
CAST(A.SUCCESS AS VARCHAR (2200)), 
CAST(A.PROGRESS AS VARCHAR (2200)), m.rank, 
	'' as progress_2, '' as progress_3, '' as progress_4, '' as progress_5,
	'' as success_2, '' as success_3, '' as success_4, '' as success_5,
	'' as barriers_2, '' as barriers_3, '' as barriers_4, '' as barriers_5
FROM  PROGRAM  P, OBJECTIVES O,  SURVEYPUB A, MONTHS M, USERACTIVITIES U
left outer join contact as c on 
u.userid=c.userid
	WHERE   U.GOAL=P.PROGNUM AND U.YEAR2=P.YEAR2
 	AND U.OBJECTIVE=O.[ID]AND U.YEAR2=O.YEAR2
 	AND A.YEAR2 = U.YEAR2 AND U.USERID=A.USERID
	AND U.ACTIVITY=A.ACTIVITY
	AND A.MONTH2=M.MON and a.year2=m.year2
and u.year2=#session.fy#
AND (U.DEL IS NULL OR U.DEL != 'Y') AND U.STRATEGY=6 AND A.BARRIERS IS NOT NULL 
<cfinclude template="report_filter.cfm">
UNION
SELECT  distinct
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1) 	
WHEN  '*' THEN  'JOINT' 
<!--- ELSE (SELECT AR.AREA FROM AREA AR WHERE AR.NUM = C.AREA AND AR.YEAR2='2007' )  END AREA , --->
ELSE (SELECT r.region FROM AREA AR, region R WHERE R.NUM=AR.REGION and AR.NUM = C.AREA AND R.year2=ar.year2 and AR.YEAR2='2007' )  END AREA ,
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1)
WHEN '*' THEN 'SHARED'
ELSE ORGNAME END ORGNAME ,
U.ACTIVITY STRATEGY, LTRIM(RTRIM(CAST(U.ACTIVITYNAME AS VARCHAR(1500)))) STRATEGY_DESCRIPTION, A.MONTH2,
P.PROGRAM  GOAL, O.OBJECTIVE, U.STARTDATE, U.ENDDATE,
CAST(A.BARRIERS AS VARCHAR (2200)), 
CAST(A.SUCCESS AS VARCHAR (2200)), 
CAST(A.PROGRESS AS VARCHAR (2200)), m.rank, 
	'' as progress_2, '' as progress_3, '' as progress_4, '' as progress_5,
	'' as success_2, '' as success_3, '' as success_4, '' as success_5,
	'' as barriers_2, '' as barriers_3, '' as barriers_4, '' as barriers_5
FROM  PROGRAM  P, OBJECTIVES O,  CESSATION A, MONTHS M, USERACTIVITIES U
left outer join contact as c on 
u.userid=c.userid
	WHERE   U.GOAL=P.PROGNUM AND U.YEAR2=P.YEAR2
 	AND U.OBJECTIVE=O.[ID]AND U.YEAR2=O.YEAR2
 	AND A.YEAR2 = U.YEAR2 AND U.USERID=A.USERID
	AND U.ACTIVITY=A.ACTIVITY
	AND A.MONTH2=M.MON 
and u.year2=#session.fy#
AND (U.DEL IS NULL OR U.DEL != 'Y') AND U.STRATEGY=7 AND A.BARRIERS IS NOT NULL 
<cfinclude template="report_filter.cfm">
UNION
SELECT  distinct
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1) 	
WHEN  '*' THEN  'JOINT' 
<!--- ELSE (SELECT AR.AREA FROM AREA AR WHERE AR.NUM = C.AREA AND AR.YEAR2='2007' )  END AREA , --->
ELSE (SELECT r.region FROM AREA AR, region R WHERE R.NUM=AR.REGION and AR.NUM = C.AREA AND R.year2=ar.year2 and AR.YEAR2='2007' )  END AREA ,
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1)
WHEN '*' THEN 'SHARED'
ELSE ORGNAME END ORGNAME ,
U.ACTIVITY STRATEGY, LTRIM(RTRIM(CAST(U.ACTIVITYNAME AS VARCHAR(1500)))) STRATEGY_DESCRIPTION, A.MONTH2,
P.PROGRAM  GOAL, O.OBJECTIVE, U.STARTDATE, U.ENDDATE,
cast(A.BARRIERS as varchar(2200)) as barriers, 
cast(A.SUCCESS as varchar(2200)) as success, 
cast(A.PROGRESS as varchar(2200)) as progress, m.rank, 
	'' as progress_2, '' as progress_3, '' as progress_4, '' as progress_5,
	'' as success_2, '' as success_3, '' as success_4, '' as success_5,
	'' as barriers_2, '' as barriers_3, '' as barriers_4, '' as barriers_5
FROM  PROGRAM  P, OBJECTIVES O,  ADVOC A, MONTHS M, USERACTIVITIES U
left outer join contact as c on 
u.userid=c.userid
	WHERE   U.GOAL=P.PROGNUM AND U.YEAR2=P.YEAR2
 	AND U.OBJECTIVE=O.[ID]AND U.YEAR2=O.YEAR2
 	AND A.YEAR2 = U.YEAR2 AND U.USERID=A.USERID
	AND U.ACTIVITY=A.ACTIVITY
	AND A.MONTH2=M.MON and a.year2=m.year2
and u.year2=#session.fy#
AND (U.DEL IS NULL OR U.DEL != 'Y') AND U.STRATEGY=9 AND A.BARRIERS IS NOT NULL 
<cfinclude template="report_filter.cfm">
UNION
SELECT  distinct
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1) 	
WHEN  '*' THEN  'JOINT' 
<!--- ELSE (SELECT AR.AREA FROM AREA AR WHERE AR.NUM = C.AREA AND AR.YEAR2='2007' )  END AREA , --->
ELSE (SELECT r.region FROM AREA AR, region R WHERE R.NUM=AR.REGION and AR.NUM = C.AREA AND R.year2=ar.year2 and AR.YEAR2='2007' )  END AREA ,
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1)
WHEN '*' THEN 'SHARED'
ELSE ORGNAME END ORGNAME ,
U.ACTIVITY STRATEGY, LTRIM(RTRIM(CAST(U.ACTIVITYNAME AS VARCHAR(1500)))) STRATEGY_DESCRIPTION, A.MONTH2,
P.PROGRAM  GOAL, O.OBJECTIVE, U.STARTDATE, U.ENDDATE,
cast(A.BARRIERS as varchar(2200)) as barriers, 
cast(A.SUCCESS as varchar(2200)) as success, 
cast(A.PROGRESS as varchar(2200)) as progress, m.rank, 
	isnull(cast(progress_2 as varchar(2200)), '') as progress_2, 
	isnull(cast(progress_3 as varchar(2200)), '') as progress_3, 
	isnull(cast(progress_4 as varchar(2200)), '') as progress_4, 
	isnull(cast(progress_5 as varchar(2200)), '') as progress_5,
	isnull(cast(success_2 as varchar(2200)), '') as success_2, 
	isnull(cast(success_3 as varchar(2200)), '') as success_3, 
	isnull(cast(success_4 as varchar(2200)), '') as success_4, 
	isnull(cast(success_5 as varchar(2200)), '') as success_5,
	isnull(cast(barriers_2 as varchar(2200)), '') as barriers_2, 
	isnull(cast(barriers_3 as varchar(2200)), '') as barriers_3, 
	isnull(cast(barriers_4 as varchar(2200)), '') as barriers_4, 
	isnull(cast(barriers_5 as varchar(2200)), '') as barriers_5
FROM  PROGRAM  P, OBJECTIVES O,  ADVOC A, MONTHS M, USERACTIVITIES U
left outer join contact as c on 
u.userid=c.userid
	WHERE   U.GOAL=P.PROGNUM AND U.YEAR2=P.YEAR2
 	AND U.OBJECTIVE=O.[ID]AND U.YEAR2=O.YEAR2
 	AND A.YEAR2 = U.YEAR2 AND U.USERID=A.USERID
	AND U.ACTIVITY=A.ACTIVITY
	AND A.MONTH2=M.MON 
and u.year2=#session.fy#
and (U.DEL IS NULL OR U.DEL != 'Y') AND U.STRATEGY=8 AND (A.BARRIERS IS NOT NULL 
	OR A.PROGRESS_2 IS NOT NULL OR A.PROGRESS_3 IS NOT NULL OR A.PROGRESS_4 IS NOT NULL OR A.PROGRESS_5 IS NOT NULL
	OR A.SUCCESS_2 IS NOT NULL OR A.SUCCESS_3 IS NOT NULL OR A.SUCCESS_4 IS NOT NULL OR A.SUCCESS_5 IS NOT NULL
	OR A.BARRIERS_2 IS NOT NULL OR A.BARRIERS_3 IS NOT NULL OR A.BARRIERS_4 IS NOT NULL OR A.BARRIERS_5 IS NOT NULL
	)
<cfinclude template="report_filter.cfm">


<cfif (NOT isDefined("form.goal")  OR (isDefined("form.goal") and form.goal EQ "ALL")) 
and ((NOT isDefined("form.farea") OR (isDefined("form.farea") and form.farea EQ "ALL"))
and (NOT isDefined("form.strategy") or (isDefined("form.strategy") and form.strategy EQ "ALL"))
) >
UNION
SELECT
<!--- ar.area, --->r.region as area,
ORGNAME, 
'Infrastructure', '',
 m.mon as month2,
 '', '', null, null, 
CAST(A.BARRIERS AS VARCHAR (2200)), 
CAST(A.SUCCESS AS VARCHAR (2200)), 
CAST(A.PROGRESS AS VARCHAR (2200)), 	m.rank,
'','','','',
'','','','',
'','','',''
FROM  infra_monthly A,
AREA AR, region r,
MONTHS M,
contact as c
WHERE
a.userid=c.userid
	AND A.MONTH2=M.MON and a.year2=m.year2
	AND A.YEAR2=AR.YEAR2
and AR.NUM = C.AREA
AND AR.YEAR2=#session.fy#
and ar.year2=r.year2
and ar.region=r.num


<cfif isDefined("form.farea") and form.farea NEQ "ALL"> and u.strategy in (#form.farea#)</cfif> 
	<cfif isDefined("form.partner") and form.partner NEQ "ALL">
	
		and (c.userid='#form.partner#')
		
	<cfelseif isDefined("form.area") and form.area NEQ "ALL">
		<cfif QAreas.recordcount NEQ 0 >
			and (c.userid in (#QuotedValueList(QAreas.userid)#)) 	
			
		<cfelse>
			and c.userid=' ' 
		</cfif>
	<!--- </cfif> --->
	
	<cfelseif isDefined("form.region") and form.region NEQ "ALL">
		<cfif QAreas.recordcount NEQ 0 >
			and (c.userid in (#QuotedValueList(QAreas.userid)#)) 	
			
		<cfelse>
			and c.userid=' ' 
		</cfif>
	</cfif>
	<cfif isDefined("form.modality") and form.modality NEQ "ALL">
			and (c.partnertype = #form.modality#)
	</cfif> 
	<cfif isDefined("Monthrange2") and monthrange2 NEQ "all">
	and	a.month2 in (#quotedValueList(QMonlist.Mon)#)
	</cfif>
</cfif>
order by 1, 2, 3, 13
</cfquery>
<cfelse>


<cfquery datasource="#Application.DataSource#"  		 
	password="#Application.db_password#"  		
	username="#Application.db_username#" name="Qsummary">
SELECT  distinct
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1) 	
WHEN  '*' THEN  'JOINT' 
<!--- ELSE (SELECT AR.AREA FROM AREA AR WHERE AR.NUM = C.AREA AND AR.YEAR2='2007' )  END AREA , --->
ELSE (SELECT r.region FROM AREA AR, region R WHERE R.NUM=AR.REGION and AR.NUM = C.AREA AND R.year2=ar.year2 and AR.YEAR2='2007' )  END AREA ,
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1)
WHEN '*' THEN 'SHARED'
ELSE ORGNAME END ORGNAME ,
U.ACTIVITY STRATEGY, LTRIM(RTRIM(CAST(U.ACTIVITYNAME AS VARCHAR(1500)))) STRATEGY_DESCRIPTION, A.MONTH2,
P.PROGRAM  GOAL, O.OBJECTIVE, U.STARTDATE, U.ENDDATE,
'' as barriers, 
'' as success, 
'' as progress, m.rank, 
	isnull(cast(progress_2 as varchar(1000)), '') as progress_2, 
	isnull(cast(progress_3 as varchar(1000)), '') as progress_3, 
	isnull(cast(progress_4 as varchar(1000)), '') as progress_4, 
	isnull(cast(progress_5 as varchar(1000)), '') as progress_5,
	isnull(cast(success_2 as varchar(1000)), '') as success_2, 
	isnull(cast(success_3 as varchar(1000)), '') as success_3, 
	isnull(cast(success_4 as varchar(1000)), '') as success_4, 
	isnull(cast(success_5 as varchar(1000)), '') as success_5,
	isnull(cast(barriers_2 as varchar(1000)), '') as barriers_2, 
	isnull(cast(barriers_3 as varchar(1000)), '') as barriers_3, 
	isnull(cast(barriers_4 as varchar(1000)), '') as barriers_4, 
	isnull(cast(barriers_5 as varchar(1000)), '') as barriers_5
FROM  PROGRAM  P, OBJECTIVES O,  ADVOC A, MONTHS M, USERACTIVITIES U
left outer join contact as c on 
u.userid=c.userid
	WHERE   U.GOAL=P.PROGNUM AND U.YEAR2=P.YEAR2
 	AND U.OBJECTIVE=O.[ID]AND U.YEAR2=O.YEAR2
 	AND A.YEAR2 = U.YEAR2 AND U.USERID=A.USERID
	AND U.ACTIVITY=A.ACTIVITY
	AND A.MONTH2=M.MON 
and u.year2=#session.fy#
and (U.DEL IS NULL OR U.DEL != 'Y') AND U.STRATEGY=8 AND (A.BARRIERS IS NOT NULL 
	OR A.PROGRESS_2 IS NOT NULL OR A.PROGRESS_3 IS NOT NULL OR A.PROGRESS_4 IS NOT NULL OR A.PROGRESS_5 IS NOT NULL
	OR A.SUCCESS_2 IS NOT NULL OR A.SUCCESS_3 IS NOT NULL OR A.SUCCESS_4 IS NOT NULL OR A.SUCCESS_5 IS NOT NULL
	OR A.BARRIERS_2 IS NOT NULL OR A.BARRIERS_3 IS NOT NULL OR A.BARRIERS_4 IS NOT NULL OR A.BARRIERS_5 IS NOT NULL
	)
<cfinclude template="report_filter.cfm">



order by 1, 2, 3, 13
</cfquery>


</cfif>
<cfoutput>

		<cfreport template="./reports/StratProgSummaryParam.cfr" format = "#form.format#" query="Qsummary">
		
		<!--- <CFREPORTPARAM name=StartMonth VALUE="#form.StMonth#">
		<CFREPORTPARAM name=EndMonth VALUE="#form.endmonth#"> --->
		<CFREPORTPARAM name=Year2 VALUE="#rptfy#">
		<cfif form.region NEQ "ALL">
			<cfquery datasource="#Application.DataSource#"  		 
			password="#Application.db_password#"  		
			username="#Application.db_username#" name="QArea">
			<!--- select area from area
			where num='#form.AREA#' and year2=#session.fy# --->
			select region as area from region
			where num='#form.region#' and year2=#session.fy#
		</cfquery>
			<CFREPORTPARAM name=Area VALUE="#QArea.area#">
		<cfelse>
			<CFREPORTPARAM name=Area VALUE="">
		</cfif>
		<cfif form.objective NEQ "ALL">
			<cfquery datasource="#Application.DataSource#"  		 
			password="#Application.db_password#"  		
			username="#Application.db_username#" name="Qobj">
			select objective from objectives where id='#form.objective#'
			and year2=#session.fy#
		</cfquery>
			<CFREPORTPARAM name=Objective VALUE="#Qobj.objective#">
		<cfelse>
			<CFREPORTPARAM name=Objective VALUE="">
		</cfif>
		<cfif form.farea NEQ "ALL">
		
			<cfquery datasource="#Application.DataSource#"  		 
			password="#Application.db_password#"  		
			username="#Application.db_username#" name="QFA">
			select descr from focusAreas where NUM in (#form.farea#)
			and year2=#session.fy#
			</cfquery>
			<CFREPORTPARAM name=FocusArea VALUE="#QFA.descr#">
		<cfelse>
			<CFREPORTPARAM name=FocusArea VALUE="">
		</cfif>
		<cfif form.strategy NEQ "ALL">
			<CFREPORTPARAM name=Strategy VALUE="#form.strategy#">
		<Cfelse>
			<CFREPORTPARAM name=Strategy VALUE="">
		</cfif>
		
		<cfif form.goal NEQ "ALL">
		<cfquery datasource="#Application.DataSource#"  		 
		password="#Application.db_password#"  		
		username="#Application.db_username#" name="QProgram">
		select program from program where prognum = '#form.goal#'
		and year2=#session.fy#
		</cfquery>
			<CFREPORTPARAM name=Prognum VALUE="#QProgram.program#">
		<cfelse>
			<CFREPORTPARAM name=Prognum VALUE="">		
		</cfif>
		<cfif form.partner NEQ "ALL">
		<cfquery datasource="#Application.DataSource#"  		 
		password="#Application.db_password#"  		
		username="#Application.db_username#" name="QPartner">
		select orgname from contact where userid = '#form.partner#'
		</cfquery>
			<CFREPORTPARAM name=PartnerName VALUE="#QPartner.ORGNAME#">	
		<cfelse>
			<CFREPORTPARAM name=PartnerName VALUE="">	
		</cfif>
		
		<!--- <CFREPORTPARAM name=ReportName VALUE="progress">--->
		 <CFREPORTPARAM name=Monthrange VALUE="#Monthrange3#">
		 <CFREPORTPARAM name=modality VALUE="#rptmodality#">
		<!--- <CFREPORTPARAM name=Monthrange VALUE="#monthrange#">	 --->	
		 </cfreport>
		 </cfoutput>
        
<!--- <cfreport template="./reports/JntStratProgSummaryParam.cfr" format = "#form.format#">
 
<CFREPORTPARAM name=Year2 VALUE="#session.fy#">
<CFREPORTPARAM name=Area VALUE="#form.area#">
<CFREPORTPARAM name=Objective VALUE="#form.objective#">
<CFREPORTPARAM name=FocusArea VALUE="#form.farea#">
<CFREPORTPARAM name=Strategy VALUE="#form.strategy#">
<CFREPORTPARAM name=Prognum VALUE="#form.goal#">
<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">                        
<CFREPORTPARAM name=ReportName VALUE="progress">
<CFREPORTPARAM name=Monthrange VALUE="#monthrange#">
 
</cfreport> --->
 
</cfcase>

<cfcase value = 1><!--- MSR Detail --->
		<!--- <cfinclude template="rpt1.cfm"> --->
		<cfparam name="session.fy" default="2005">
		<cfparam name="form.Area" default="ALL">
		<cfparam name="form.Region" default="ALL">
		<cfparam name="form.Objective" default="ALL">
		<cfparam name="form.fArea" default="ALL">
		<cfparam name="form.goal" default="ALL">
		<cfparam name="form.partner" default="ALL">
		<cfparam name="form.strategy" default="ALL">		
		<cfinclude template="qry_report_filter.cfm">		
	<cfquery datasource="#Application.DataSource#"  		 
	password="#Application.db_password#"  		
	username="#Application.db_username#" name="Qwp">
SELECT DISTINCT u.userid, orgname as org,
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1)
 	WHEN '*' THEN 'Joint Partner Strategy' ELSE ORGNAME END ORGNAME ,
U.GOAL AS GOALID, 
U.OBJECTIVE AS OBJECTIVEID,
S.STRATEGY_NUM AS STRATEGY_NUM,
S.STRATEGY AS STRATEGY,
P.PROGRAM AS GOAL,
O.OBJECTIVE AS OBJECTIVE,
U.ACTIVITY,
LTRIM(RTRIM(CAST(U.OUTCOME AS VARCHAR(4000))))  as outcome,
last_sd as STARTDATE,
last_ed as ENDDATE,
LTRIM(RTRIM(CAST(U.ACTIVITYNAME AS VARCHAR(4000)))) as activityname
FROM 
STRATEGY AS S,
PROGRAM AS P,
OBJECTIVES AS O,
GOVT AS A,
USERACTIVITIES AS U
left outer join CONTACT C on u.USERID=c.USERID
WHERE U.STRATEGY=S.STRATEGY_NUM
AND P.PROGNUM=U.GOAL
AND O.ID=U.OBJECTIVE 
AND U.YEAR2=S.YEAR2
AND U.YEAR2=P.YEAR2
AND U.YEAR2=O.YEAR2
And u.year2=a.year2
and u.userid=a.userid
and u.activity=a.activity
and u.strategy =1
and a.status is not null and a.status != 'NA'
AND (U.DEL IS NULL OR U.DEL !='Y')AND  u.year2 =#session.fy#
and c.partnertype !=4
<cfinclude template="report_filter.cfm">
UNION
SELECT DISTINCT  u.userid,orgname as org,
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1)
 	WHEN '*' THEN 'Joint Partner Strategy' ELSE ORGNAME END ORGNAME ,
U.GOAL AS GOALID, 
U.OBJECTIVE AS OBJECTIVEID,
S.STRATEGY_NUM AS STRATEGY_NUM,
S.STRATEGY AS STRATEGY,
P.PROGRAM AS GOAL,
O.OBJECTIVE AS OBJECTIVE,
U.ACTIVITY,
LTRIM(RTRIM(CAST(U.OUTCOME AS VARCHAR(4000))))  as outcome,
last_sd as STARTDATE,
last_ed as ENDDATE,
LTRIM(RTRIM(CAST(U.ACTIVITYNAME AS VARCHAR(4000)))) as activityname
FROM 
STRATEGY AS S,
PROGRAM AS P,
OBJECTIVES AS O,
PAIDMEDIA AS A,
USERACTIVITIES AS U
left outer join CONTACT C on u.USERID=c.USERID
WHERE U.STRATEGY=S.STRATEGY_NUM
AND P.PROGNUM=U.GOAL
AND O.ID=U.OBJECTIVE 
AND U.YEAR2=S.YEAR2
AND U.YEAR2=P.YEAR2
AND U.YEAR2=O.YEAR2
And u.year2=a.year2
and u.userid=a.userid
and u.activity=a.activity
and u.strategy =2
and a.status is not null and a.status != 'NA'
AND (U.DEL IS NULL OR U.DEL !='Y')AND  u.year2 =#session.fy#
and c.partnertype !=4
<cfinclude template="report_filter.cfm">
union
SELECT DISTINCT  u.userid,orgname as org,
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1)
 	WHEN '*' THEN 'Joint Partner Strategy' ELSE ORGNAME END ORGNAME ,
U.GOAL AS GOALID, 
U.OBJECTIVE AS OBJECTIVEID,
S.STRATEGY_NUM AS STRATEGY_NUM,
S.STRATEGY AS STRATEGY,
P.PROGRAM AS GOAL,
O.OBJECTIVE AS OBJECTIVE,
U.ACTIVITY,
LTRIM(RTRIM(CAST(U.OUTCOME AS VARCHAR(4000))))  as outcome,
last_sd as STARTDATE,
last_ed as ENDDATE,
LTRIM(RTRIM(CAST(U.ACTIVITYNAME AS VARCHAR(4000)))) as activityname
FROM 
STRATEGY AS S,
PROGRAM AS P,
OBJECTIVES AS O,
FORUM AS A,
USERACTIVITIES AS U
left outer join CONTACT C on u.USERID=c.USERID
WHERE U.STRATEGY=S.STRATEGY_NUM
AND P.PROGNUM=U.GOAL
AND O.ID=U.OBJECTIVE 
AND U.YEAR2=S.YEAR2
AND U.YEAR2=P.YEAR2
AND U.YEAR2=O.YEAR2
And u.year2=a.year2
and u.userid=a.userid
and u.activity=a.activity
and u.strategy =4
and a.status is not null and a.status != 'NA'
AND (U.DEL IS NULL OR U.DEL !='Y')AND  u.year2 =#session.fy#
and c.partnertype !=4
<cfinclude template="report_filter.cfm">
union
SELECT DISTINCT  u.userid,orgname as org,
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1)
 	WHEN '*' THEN 'Joint Partner Strategy' ELSE ORGNAME END ORGNAME ,
U.GOAL AS GOALID, 
U.OBJECTIVE AS OBJECTIVEID,
S.STRATEGY_NUM AS STRATEGY_NUM,
S.STRATEGY AS STRATEGY,
P.PROGRAM AS GOAL,
O.OBJECTIVE AS OBJECTIVE,
U.ACTIVITY,
LTRIM(RTRIM(CAST(U.OUTCOME AS VARCHAR(4000))))  as outcome,
last_sd as STARTDATE,
last_ed as ENDDATE,
LTRIM(RTRIM(CAST(U.ACTIVITYNAME AS VARCHAR(4000)))) as activityname
FROM 
STRATEGY AS S,
PROGRAM AS P,
OBJECTIVES AS O,
MONITOR AS A,
USERACTIVITIES AS U
left outer join CONTACT C on u.USERID=c.USERID
WHERE U.STRATEGY=S.STRATEGY_NUM
AND P.PROGNUM=U.GOAL
AND O.ID=U.OBJECTIVE 
AND U.YEAR2=S.YEAR2
AND U.YEAR2=P.YEAR2
AND U.YEAR2=O.YEAR2
And u.year2=a.year2
and u.userid=a.userid
and u.activity=a.activity
and u.strategy =5
and a.status is not null and a.status != 'NA'
AND (U.DEL IS NULL OR U.DEL !='Y')AND  u.year2 =#session.fy#
and c.partnertype !=4
<cfinclude template="report_filter.cfm">
union
SELECT DISTINCT  u.userid,orgname as org,
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1)
 	WHEN '*' THEN 'Joint Partner Strategy' ELSE ORGNAME END ORGNAME ,
U.GOAL AS GOALID, 
U.OBJECTIVE AS OBJECTIVEID,
S.STRATEGY_NUM AS STRATEGY_NUM,
S.STRATEGY AS STRATEGY,
P.PROGRAM AS GOAL,
O.OBJECTIVE AS OBJECTIVE,
U.ACTIVITY,
LTRIM(RTRIM(CAST(U.OUTCOME AS VARCHAR(4000))))  as outcome,
last_sd as STARTDATE,
last_ed as ENDDATE,
LTRIM(RTRIM(CAST(U.ACTIVITYNAME AS VARCHAR(4000)))) as activityname
FROM 
STRATEGY AS S,
PROGRAM AS P,
OBJECTIVES AS O,
SURVEYPUB AS A,
USERACTIVITIES AS U
left outer join CONTACT C on u.USERID=c.USERID
WHERE U.STRATEGY=S.STRATEGY_NUM
AND P.PROGNUM=U.GOAL
AND O.ID=U.OBJECTIVE 
AND U.YEAR2=S.YEAR2
AND U.YEAR2=P.YEAR2
AND U.YEAR2=O.YEAR2
And u.year2=a.year2
and u.userid=a.userid
and u.activity=a.activity
and u.strategy =6
and a.status is not null and a.status != 'NA'
AND (U.DEL IS NULL OR U.DEL !='Y')AND  u.year2 =#session.fy#
and c.partnertype !=4
<cfinclude template="report_filter.cfm">
union
SELECT DISTINCT u.userid,orgname as org,
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1)
 	WHEN '*' THEN 'Joint Partner Strategy' ELSE ORGNAME END ORGNAME ,
U.GOAL AS GOALID, 
U.OBJECTIVE AS OBJECTIVEID,
S.STRATEGY_NUM AS STRATEGY_NUM,
S.STRATEGY AS STRATEGY,
P.PROGRAM AS GOAL,
O.OBJECTIVE AS OBJECTIVE,
U.ACTIVITY,
LTRIM(RTRIM(CAST(U.OUTCOME AS VARCHAR(4000))))  as outcome,
last_sd as STARTDATE,
last_ed as ENDDATE,
LTRIM(RTRIM(CAST(U.ACTIVITYNAME AS VARCHAR(4000)))) as activityname
FROM 
STRATEGY AS S,
PROGRAM AS P,
OBJECTIVES AS O,
CESSATION AS A,
USERACTIVITIES AS U
left outer join CONTACT C on u.USERID=c.USERID
WHERE U.STRATEGY=S.STRATEGY_NUM
AND P.PROGNUM=U.GOAL
AND O.ID=U.OBJECTIVE 
AND U.YEAR2=S.YEAR2
AND U.YEAR2=P.YEAR2
AND U.YEAR2=O.YEAR2
And u.year2=a.year2
and u.userid=a.userid
and u.activity=a.activity
and u.strategy =7
and a.status is not null and a.status != 'NA'
AND (U.DEL IS NULL OR U.DEL !='Y')AND  u.year2 =#session.fy#
and c.partnertype !=4
<cfinclude template="report_filter.cfm">
union
SELECT DISTINCT  u.userid,orgname as org,
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1)
 	WHEN '*' THEN 'Joint Partner Strategy' ELSE ORGNAME END ORGNAME ,
U.GOAL AS GOALID, 
U.OBJECTIVE AS OBJECTIVEID,
S.STRATEGY_NUM AS STRATEGY_NUM,
S.STRATEGY AS STRATEGY,
P.PROGRAM AS GOAL,
O.OBJECTIVE AS OBJECTIVE,
U.ACTIVITY,
LTRIM(RTRIM(CAST(U.OUTCOME AS VARCHAR(4000))))  as outcome,
last_sd as STARTDATE,
last_ed as ENDDATE,
LTRIM(RTRIM(CAST(U.ACTIVITYNAME AS VARCHAR(4000)))) as activityname
FROM 
STRATEGY AS S,
PROGRAM AS P,
OBJECTIVES AS O,
ADVOC AS A,
USERACTIVITIES AS U
left outer join CONTACT C on u.USERID=c.USERID
WHERE U.STRATEGY=S.STRATEGY_NUM
AND P.PROGNUM=U.GOAL
AND O.ID=U.OBJECTIVE 
AND U.YEAR2=S.YEAR2
AND U.YEAR2=P.YEAR2
AND U.YEAR2=O.YEAR2
And u.year2=a.year2
and u.userid=a.userid
and u.activity=a.activity
and u.strategy in (8,9,10,11)
and a.status is not null and a.status != 'NA'
AND (U.DEL IS NULL OR U.DEL !='Y')AND  u.year2 =#session.fy#
and c.partnertype !=4
<cfinclude template="report_filter.cfm">
order by  2,5,6,9
</cfquery>		
		<cfoutput>
		
		<cfreport template="./reports/msrb.cfr" format = "#form.format#" query="Qwp">
		
		<CFREPORTPARAM name=Area VALUE=#form.region#>
		<!--- <CFREPORTPARAM name=Objective VALUE="#form.objective#"> --->
		<CFREPORTPARAM name=Objective VALUE="#form.objective#">
		<CFREPORTPARAM name=FocusArea VALUE="#form.farea#">
		<CFREPORTPARAM name=Strategy VALUE="#form.strategy#">
		<CFREPORTPARAM name=Prognum VALUE="#form.goal#">
		<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">		
		<CFREPORTPARAM name=Year2 VALUE="#rptfy#">
		<CFREPORTPARAM name=ReportName VALUE="PP">
		<CFREPORTPARAM name=modality VALUE="#rptmodality#">
		<CFREPORTPARAM name=Monthrange VALUE="#monthrange3#">
		<CFREPORTPARAM name=Monthrange2 VALUE="#monthrange2#">
		<CFREPORTPARAM name=ModalityRank VALUE="#modality_rank#">
		 </cfreport>
		 </cfoutput>
	</cfcase>
	
	<cfcase value="30">
	<cfoutput>
	<cfparam name="form.Area" default="ALL">
	<cfparam name="form.Region" default="ALL">
	<cfparam name="form.fArea" default="ALL">
	<cfparam name="form.partner" default="ALL">
	
		
	
	<cfinclude template="qry_report_filter.cfm">
	<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="QEOY">
select <!--- a.area --->r.region as area, u.userid,c.orgname,u.activity, 
u.activityname, u.outcome, g.program as goal,

case isNull(e.status,0) when 0 then 'Not Entered' when 1 then 'Met' when 2 then 'Unmet' when 3 then 'Progressing' End as status,

e.barriers, e.actions, e.meas_b, e.meas_c, e.meas_t, e.comment, e.year2, o.objective
from contact as c, 
area as a, region as r,
program as g, objectives as o,  useractivities u
inner join  eoy_status as e
on u.userid=e.userid and u.activity=e.activity and u.year2=e.year2
where u.goal=g.prognum and u.year2=g.year2
and u.year2=2007
and u.userid=c.userid
and c.area=a.num
and u.year2=a.year2
and o.year2=u.year2
and o.id= u.objective
and a.year2=r.year2
and a.region=r.num

and (u.del is null or u.del !='Y')
and	c.partnertype != 4
and u.strategy !=10

	
	<cfinclude template="report_filter.cfm"> 
order by 1,3,4
</cfquery>

	<cfreport template="./reports/eoyreportlist.cfr" format = "pdf" query="QEOY"> 

		<CFREPORTPARAM name=Year2 VALUE="2007">
		<CFREPORTPARAM name=Area VALUE="All">
		<CFREPORTPARAM name=modality VALUE="ALL">
		<CFREPORTPARAM name=FA VALUE="All">
		<CFREPORTPARAM name=Prognum VALUE="All">
		<CFREPORTPARAM name=Objective VALUE="All">
		<CFREPORTPARAM name=Strategy VALUE="All">
		<CFREPORTPARAM name=ReportName VALUE="PP">
		<CFREPORTPARAM name=StMonth VALUE="1">
		  <CFREPORTPARAM name=endMnth VALUE="1">
		  <CFREPORTPARAM name=stYear VALUE="2007">
		  <CFREPORTPARAM name=endYr VALUE="2007">		 
		<CFREPORTPARAM name=PartnerName VALUE="ALL">
		</cfreport>
		 </cfoutput>
	</cfcase>
	
	<cfcase value="31">
	
	<cfparam name="form.Area" default="ALL">
	<cfparam name="form.Region" default="ALL">
<cfparam name="form.fArea" default="ALL">
<cfparam name="form.partner" default="ALL">

		<cfparam name="form.Objective" default="ALL">
		<cfparam name="form.goal" default="ALL">
		<cfparam name="form.strategy" default="ALL">	
		
<cfinclude template="qry_report_filter.cfm">

<cfoutput>
	<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="QEOY">
select distinct
	<!--- a.area --->r.region as area, c.orgname, c.userid,
case c.partnertype
when 1 then 'Cessation Center'
when 2 then 'Community Partnership'
when 3 then 'Youth Partner'
when 4 then 'School Policy Partner' 
end as modality,
case b.complete 
		when 0 then 'Some Entries' 
		when 1 then 'Some Entries' 
		else 'No Entry Yet' end as SomeEntries,
	case b.complete 
		when 1 then 'Complete' 
		else 'Not Complete' end as complete,
		
	case f.am_review 
		when 1 then 'Reviewed' 
		when 0 then 'Reviewing'
		else 'Not Reviewed' end as amstatus
		
from security as s, area as a, region as r, useractivities as u, contact as c
left outer join eoy_basics as b on b.userid=c.userid  and b.year2=2007
left outer join am_eoy_feedback as f on f.userid=c.userid and f.year2=2007
where 
u.userid=c.userid 
and  a.num = s.area
and s.userid=c.userid
and a.year2=u.year2 
and c.orgname is not null
and c.partnertype !=4
and u.strategy !=10

and a.year2=r.year2
and a.region=r.num


	<!--- <cfif form.area NEQ 'All' and form.partner EQ 'All'>
	and c.area=#form.area#
	</cfif>

	<cfif form.partner NEQ 'All'>
	and c.userid = '#form.partner#'
	</cfif>
	<cfif isDefined("form.modality") and form.modality NEQ "ALL">
	and (c.partnertype = #form.modality#)
	</cfif> --->
<cfinclude template="report_filter.cfm">
order by <!--- a.area --->r.region, c.orgname
</cfquery>
	<cfreport template="./reports/eoyreportStatus.cfr" format = "pdf"  query="QEOY"> 

		<CFREPORTPARAM name=Year2 VALUE="2007">
		<CFREPORTPARAM name=Area VALUE="All">
		<CFREPORTPARAM name=modality VALUE="ALL">
		<CFREPORTPARAM name=FA VALUE="All">
		<CFREPORTPARAM name=Prognum VALUE="All">
		<CFREPORTPARAM name=Objective VALUE="All">
		<CFREPORTPARAM name=Strategy VALUE="All">
		<CFREPORTPARAM name=ReportName VALUE="PP">
		<CFREPORTPARAM name=StMonth VALUE="1">
		  <CFREPORTPARAM name=endMnth VALUE="1">
		  <CFREPORTPARAM name=stYear VALUE="2007">
		  <CFREPORTPARAM name=endYr VALUE="2007">		 
		<CFREPORTPARAM name=PartnerName VALUE="ALL">
		</cfreport>
		 </cfoutput>
	</cfcase>
	
	<cfcase value="32">
	<cfoutput>
<cfparam name="form.Area" default="ALL">
<cfparam name="form.fArea" default="ALL">
<cfparam name="form.partner" default="ALL">
<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="QEOY">
select 
c.orgname,
case partnertype when 1 then 'Cessation Center'
when 2 then 'Community Partnership'
when 3 then 'Youth Partner'
when 4 then 'School Policy Partner'
else ''
end as modality,
case b.complete when 1 then 'Yes' when 0 then 'No' else 'No response' end as complete, 
<!--- ar.area, ---> r.region as area,
case rpt_status when 1 then 'Yes' when 0 then 'No' else 'No response' end as rpt_status,
case content when 1 then 'Yes' when 0 then 'No' else 'No response' end as content,
case reflect when 1 then 'Yes' when 0 then 'No' else 'No response' end as reflect,
case barriers_comp when 1 then 'Yes' when 0 then 'No' else 'No response' end as barriers_comp,
case barriers_build when 1 then 'Yes' when 0 then 'No' else 'No response' end as barriers_build,
gen_fdback,
tba,
discrep_txt,
isNull(cb_compdate, 0) as cb_compdate,
isNull(compdate, '1/1/1904') as compdate
from am_eoy_feedback as a, contact as c, area as ar, eoy_basics as b, region as r
where a.year2=2007
and a.year2=ar.year2
and c.area=ar.num
and a.userid=c.userid
and b.userid=c.userid
and b.year2=a.year2
and am_review=1
and	c.partnertype != 4

and ar.year2=r.year2
and ar.region=r.num

	<cfif form.area NEQ 'All' and form.partner EQ 'All'>
	and c.area=#form.area#
	</cfif>
	
	<cfif form.region NEQ 'All' and form.partner EQ 'All'>
	and r.num=#form.region#
	</cfif>

	<cfif form.partner NEQ 'All'>
	and c.userid = '#form.partner#'
	</cfif>
	<cfif isDefined("form.modality") and form.modality NEQ "ALL">
	and (c.partnertype = #form.modality#)
	</cfif>
order by <!--- ar.area --->r.region, orgname
</cfquery>

	<cfreport template="./reports/eoyfeedback.cfr" format = "pdf"  query="QEOY">

		<CFREPORTPARAM name=Year2 VALUE="2007">
		<CFREPORTPARAM name=Area VALUE="All">
		<CFREPORTPARAM name=modality VALUE="ALL">
		<CFREPORTPARAM name=FA VALUE="All">
		<CFREPORTPARAM name=Prognum VALUE="All">
		<CFREPORTPARAM name=Objective VALUE="All">
		<CFREPORTPARAM name=Strategy VALUE="All">
		<CFREPORTPARAM name=ReportName VALUE="PP">
		<CFREPORTPARAM name=StMonth VALUE="1">
		  <CFREPORTPARAM name=endMnth VALUE="1">
		  <CFREPORTPARAM name=stYear VALUE="2007">
		  <CFREPORTPARAM name=endYr VALUE="2007">		 
		<CFREPORTPARAM name=PartnerName VALUE="ALL">
		</cfreport>
		 </cfoutput>
	</cfcase>
<cfcase value="33">
	<cfoutput>
	<cfparam name="session.fy" default="2005">
		<cfparam name="form.Area" default="ALL">
		<cfparam name="form.Region" default="ALL">
		<cfparam name="form.Objective" default="ALL">
		<cfparam name="form.fArea" default="ALL">
		<cfparam name="form.goal" default="ALL">
		<cfparam name="form.partner" default="ALL">
		<cfparam name="form.strategy" default="ALL">
<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="CCT">
SELECT     c.orgname,  <!--- ar.area --->r.region as area,

SUM(CASE month2 WHEN 'August' THEN 1 ELSE 0 END) AS aug,

SUM(CASE month2 WHEN 'September' THEN 1 ELSE 0 END) AS sept,

SUM(CASE month2 WHEN 'October' THEN 1 ELSE 0 END) AS oct,

SUM(CASE month2 WHEN 'November' THEN 1 ELSE 0 END) AS nov,

SUM(CASE month2 WHEN 'December' THEN 1 ELSE 0 END) AS dec,

SUM(CASE month2 WHEN 'January' THEN 1 ELSE 0 END) AS jan,

SUM(CASE month2 WHEN 'February' THEN 1 ELSE 0 END) AS feb,

SUM(CASE month2 WHEN 'March' THEN 1 ELSE 0 END) AS mar,

SUM(CASE month2 WHEN 'April' THEN 1 ELSE 0 END) AS apr,

SUM(CASE month2 WHEN 'May' THEN 1 ELSE 0 END) AS may,

SUM(CASE month2 WHEN 'June' THEN 1 ELSE 0 END) AS jun,

SUM(CASE month2 WHEN 'July' THEN 1 ELSE 0 END) AS jul,

sum(CASE month2 WHEN 'August' THEN 1 ELSE 0 END+CASE month2 WHEN 'September' THEN 1 ELSE 0 END+CASE month2 WHEN 'October' THEN 1 ELSE 0 END+CASE month2 WHEN 'November' THEN 1 ELSE 0 END+CASE month2 WHEN 'December' THEN 1 ELSE 0 END+CASE month2 WHEN 'January' THEN 1 ELSE 0 END+CASE month2 WHEN 'February' THEN 1 ELSE 0 END+CASE month2 WHEN 'March' THEN 1 ELSE 0 END+CASE month2 WHEN 'April' THEN 1 ELSE 0 END+CASE month2 WHEN 'May' THEN 1 ELSE 0 END+CASE month2 WHEN 'June' THEN 1 ELSE 0 END+CASE month2 WHEN 'July' THEN 1 ELSE 0 END) as sum,

1 as train

FROM 

dbo.area ar, region r, dbo.contact c

left outer join        dbo.cchco_train cc on cc.userid=c.userid and cc.year2 = #session.fy#

where   

ar.year2=#session.fy#

and c.area=ar.num
and ar.year2=r.year2
and ar.region=r.num

and orgname is not null

and c.partnertype=1 

<cfif form.area NEQ 'All' and form.partner EQ 'All'>
and c.area=#form.area#
</cfif>
<cfif form.region NEQ 'All' and form.partner EQ 'All'>
and r.num=#form.region#
</cfif>

<cfif form.partner NEQ 'All'>
and c.userid = '#form.partner#'
</cfif>

group by c.orgname, <!--- ar.area --->r.region

union

SELECT     c.orgname,  <!--- ar.area --->r.region as area,

SUM(CASE month2 WHEN 'August' THEN 1 ELSE 0 END) AS aug,

SUM(CASE month2 WHEN 'September' THEN 1 ELSE 0 END) AS sept,

SUM(CASE month2 WHEN 'October' THEN 1 ELSE 0 END) AS oct,

SUM(CASE month2 WHEN 'November' THEN 1 ELSE 0 END) AS nov,

SUM(CASE month2 WHEN 'December' THEN 1 ELSE 0 END) AS dec,

SUM(CASE month2 WHEN 'January' THEN 1 ELSE 0 END) AS jan,

SUM(CASE month2 WHEN 'February' THEN 1 ELSE 0 END) AS feb,

SUM(CASE month2 WHEN 'March' THEN 1 ELSE 0 END) AS mar,

SUM(CASE month2 WHEN 'April' THEN 1 ELSE 0 END) AS apr,

SUM(CASE month2 WHEN 'May' THEN 1 ELSE 0 END) AS may,

SUM(CASE month2 WHEN 'June' THEN 1 ELSE 0 END) AS jun,

SUM(CASE month2 WHEN 'July' THEN 1 ELSE 0 END) AS jul,

sum(CASE month2 WHEN 'August' THEN 1 ELSE 0 END+CASE month2 WHEN 'September' THEN 1 ELSE 0 END+CASE month2 WHEN 'October' THEN 1 ELSE 0 END+CASE month2 WHEN 'November' THEN 1 ELSE 0 END+CASE month2 WHEN 'December' THEN 1 ELSE 0 END+CASE month2 WHEN 'January' THEN 1 ELSE 0 END+CASE month2 WHEN 'February' THEN 1 ELSE 0 END+CASE month2 WHEN 'March' THEN 1 ELSE 0 END+CASE month2 WHEN 'April' THEN 1 ELSE 0 END+CASE month2 WHEN 'May' THEN 1 ELSE 0 END+CASE month2 WHEN 'June' THEN 1 ELSE 0 END+CASE month2 WHEN 'July' THEN 1 ELSE 0 END) as sum,

2 as train

FROM      dbo.area ar, region r, dbo.contact c 

left outer join dbo.cchco_ta cc on cc.year2 = #session.fy# AND cc.method = 1 and  cc.userid=c.userid

left outer join dbo.lu_cchco_ta_method ta on ta.year2=#session.fy# and cc.method = ta.id

where  

ar.year2= #session.fy#

and c.area=ar.num
and ar.year2=r.year2
and ar.region=r.num

and orgname is not null

and c.partnertype=1 

<cfif form.area NEQ 'All' and form.partner EQ 'All'>
and c.area=#form.area#
</cfif>
<cfif form.region NEQ 'All' and form.partner EQ 'All'>
and r.num=#form.region#
</cfif>
<cfif form.partner NEQ 'All'>
and c.userid = '#form.partner#'
</cfif>

group by c.orgname, <!--- ar.area ---> r.region

order by <!--- ar.area --->r.region, c.orgname, train

</cfquery>

	<cfreport template="./reports/cctraining.cfr" format = "pdf" query="CCT">

		<CFREPORTPARAM name=Year2 VALUE="#session.fy#">
		<CFREPORTPARAM name=Area VALUE="#form.region#">
		<CFREPORTPARAM name=modality VALUE="ALL">
		<CFREPORTPARAM name=focusarea VALUE="All">
		<CFREPORTPARAM name=monthrange VALUE="All">
		<CFREPORTPARAM name=Prognum VALUE="All">
		<CFREPORTPARAM name=Objective VALUE="All">
		<CFREPORTPARAM name=Strategy VALUE="All">
		<CFREPORTPARAM name=ReportName VALUE="PP">
		<CFREPORTPARAM name=StMonth VALUE="1">
				<CFREPORTPARAM name=StMonth VALUE="1">
		  <CFREPORTPARAM name=endMnth VALUE="1">
		   <CFREPORTPARAM name=stQuarter VALUE="1">
		   		   <CFREPORTPARAM name=endQuarter VALUE="1">
		  <CFREPORTPARAM name=stYear VALUE="2007">
		  <CFREPORTPARAM name=endYear VALUE="2007">
		<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">
		</cfreport>
		 </cfoutput>
</cfcase>
	
	<cfcase value="34">
	<cfoutput>
	<cfparam name="session.fy" default="2005">
		<cfparam name="form.Area" default="ALL">
		<cfparam name="form.Region" default="ALL">
		<cfparam name="form.Objective" default="ALL">
		<cfparam name="form.fArea" default="ALL">
		<cfparam name="form.goal" default="ALL">
		<cfparam name="form.partner" default="ALL">
		<cfparam name="form.strategy" default="ALL">
		<cfset y = 0>
		<cfset k = 0>
		
<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="TFPP">
SELECT     <!--- a.area --->r.region as area, LTRIM(t.target) AS target, u.strategy, u.targetGroup, ta.Target AS targetOrgType, u.activity, 

                      CASE channel WHEN '1' THEN 'Policy' WHEN '4' THEN 'Policy' WHEN '5' THEN 'Policy' WHEN '2' THEN 'Resolution' WHEN '3' THEN 'Practice' END AS channel, m.rptDate, m.descr, m.seq, 

                      c.orgName, u.JPS_orgs, u.year2, m.month2, 

                      CASE o.groupname WHEN 'sponspromo' THEN 'Tobacco sponsorship and promotion policies/resolutions' WHEN 'movies' THEN 'Smoke free movies policies/resolutions' WHEN

                       'magazine' THEN 'Tobacco ad-free magazine policies/ resolutions' WHEN 'mud' THEN 'Smoke-free multiunit dwelling policies' WHEN 'outdoor' THEN 'Outdoor tobacco use restriction/ban policies/resolutions'

                       WHEN 'retail' THEN 'Retail tobacco policies/resolutions' END AS groupname

FROM         dbo.contact AS c INNER JOIN

                      dbo.Area AS a ON c.area = a.num INNER JOIN
					
						dbo.region as r on a.region=r.num and a.year2=r.year2 Inner Join

                      dbo.userActivities AS u ON c.userid = u.userid INNER JOIN

                      dbo.user_target_org AS t INNER JOIN

                      dbo.PRPChange AS m ON t.userid = m.userid AND t.year2 = m.year2 AND t.seq = m.stakeholders ON u.userid = m.userid AND u.activity = m.activity AND

                       u.year2 = m.year2   and a.year2=u.year2 INNER JOIN

                      dbo.targets AS ta ON CAST(u.targetGroup AS int) = ta.targetNum AND u.strategy = ta.strategyNum AND u.year2 = ta.year2 INNER JOIN

                      dbo.objectives AS o ON u.year2 = o.year2 AND u.objective = o.ID

WHERE     (u.del <> 'y' OR

                      u.del IS NULL) AND (u.targetGroup NOT LIKE '%,%')  and u.year2=#session.fy#
<cfif session.fy GTE 2008>

 AND u.objective IN ('2B','2C','2Cb','2D','2E','2F','2G','2H','2J','2k','3G', '3C', '4c', '2i', '2L', '2M')

<cfelse>

 AND u.objective IN ('2B','2C','2Cb','2D','2E','2F','2G','2H','2J','2k','4G', '4C', '1c', '2i')

</cfif>

<!--- <cfif form.area NEQ 'All' and form.partner EQ 'All'>
and (c.area=#form.area# OR (u.userid='SHARED' and  u.activity in (select activity from shareduseractivities where userid in (select userid from contact where area=#form.area# and year2=#session.fy#))))
</cfif> --->

<cfif form.region NEQ 'All' and form.partner EQ 'All'>
and (r.num=#form.region# OR (u.userid='SHARED' and  u.activity in (select activity from shareduseractivities where userid in (select userid from contact, area, region where contact.area=area.num and area.region=region.num and region.num=#form.region# and area.year2=#session.fy# and region.year2=area.year2))))
</cfif>
<cfif isDefined("form.targets") and form.targets NEQ "ALL">
and (
<cfloop index="x" list="#form.targets#">
<cfset k = k + 1>
<cfif k is not 1>or</cfif> ('#x#' = ta.target and ta.targetnum in (u.targetgroup))</cfloop>)</cfif>
<cfif form.partner NEQ 'All'>
and c.userid = '#form.partner#'
</cfif>
<cfif isDefined("form.farea") and form.farea NEQ "ALL"> and u.strategy in (#form.farea#)</cfif>
<cfif isDefined("form.groups") and form.groups NEQ "ALL"> and groupnum in (#form.groups#)</cfif>
	
	<cfif isDefined("form.objective") and form.objective NEQ "ALL">
		and u.objective='#form.objective#' 
	<cfelseif isDefined("form.goal") and form.goal NEQ "ALL">
		and u.goal='#form.goal#'  
	</cfif>
	
	<cfif isDefined("form.modality") and form.modality NEQ "ALL">
	and (u.userid='SHARED' or u.userid in (select userid from contact where partnertype = #form.modality#))
	</cfif>
	
	<cfif isDefined("form.category") and form.category DOES NOT CONTAIN "ALL">
	and o.groupname ='#form.category#'
	
	</cfif>

UNION ALL

SELECT     <!--- a.area --->r.region as area, LTRIM(t.target) AS target, u.strategy, u.targetGroup, 

                      CASE u.targetgroup WHEN '4,5' THEN 'Local elected officials; Local government staff' ELSE 'Reporting Error!' END AS targetOrgType, u.activity, 

                      CASE channel WHEN '1' THEN 'Policy' WHEN '4' THEN 'Policy' WHEN '5' THEN 'Policy' WHEN '2' THEN 'Resolution' WHEN '3' THEN 'Practice' END AS channel, m.rptDate, m.descr, m.seq, 

                      c.orgName, u.JPS_orgs, u.year2, m.month2, 

                      CASE o.groupname WHEN 'sponspromo' THEN 'Tobacco sponsorship and promotion policies/resolutions' WHEN 'movies' THEN 'Smoke free movies policies/resolutions' WHEN

                       'magazine' THEN 'Tobacco ad-free magazine policies/ resolutions' WHEN 'mud' THEN 'Smoke-free multiunit dwelling policies' WHEN 'outdoor' THEN 'Outdoor tobacco use restriction/ban policies/resolutions'

                       WHEN 'retail' THEN 'Retail tobacco policies/resolutions' END AS groupname

FROM         dbo.contact AS c INNER JOIN

                      dbo.Area AS a ON c.area = a.num INNER JOIN
					dbo.region as r on a.region=r.num and a.year2=r.year2 Inner Join

                      dbo.userActivities AS u ON c.userid = u.userid INNER JOIN

                      dbo.user_target_org AS t INNER JOIN

                      dbo.PRPChange AS m ON t.userid = m.userid AND t.year2 = m.year2 AND t.seq = m.stakeholders ON u.userid = m.userid AND u.activity = m.activity AND

                       u.year2 = m.year2 and a.year2=u.year2 INNER JOIN

                      dbo.objectives AS o ON u.year2 = o.year2 AND u.objective = o.ID

WHERE     (u.del <> 'y' OR

                      u.del IS NULL) AND (u.targetGroup LIKE '%,%') and u.year2=#session.fy#
		
<!--- <cfif form.area NEQ 'All' and form.partner EQ 'All'>
and (c.area=#form.area# OR (u.userid='SHARED' and  u.activity in (select activity from shareduseractivities where userid in (select userid from contact where area=#form.area# and year2=#session.fy#))))
</cfif> --->

<cfif form.region NEQ 'All' and form.partner EQ 'All'>
and (r.num=#form.region# OR (u.userid='SHARED' and  u.activity in (select activity from shareduseractivities where userid in (select userid from contact, area, region where contact.area=area.num and area.region=region.num and region.num=#form.region# and area.year2=#session.fy# and region.year2=area.year2))))
</cfif>
<cfif form.partner NEQ 'All'>
and c.userid = '#form.partner#'
</cfif>
<cfif isDefined("form.targets") and form.targets NEQ "ALL">
and (
<cfloop index="x" list="#form.targets#">
<cfset y = y + 1>
<cfif y is not 1>or</cfif> 
('Local elected officials, Local government staff'  like '%#x#%' and '4,5' in (u.targetgroup))
<!--- --'#x#' in (u.targetgroup) --->
</cfloop>)</cfif>

<!--- --(ta.target like '%#x#%' and ta.targetnum in (u.targetgroup))

--('Local elected officials, Local government staff'  like '%#x#%' and '4,5' in (u.targetgroup))


--('Local elected officials','Local government staff ') --->
<cfif isDefined("form.farea") and form.farea NEQ "ALL"> and u.strategy in (#form.farea#)</cfif>
<cfif isDefined("form.groups") and form.groups NEQ "ALL"> and groupnum in (#form.groups#)</cfif>

	<cfif isDefined("form.objective") and form.objective NEQ "ALL">
		and u.objective='#form.objective#' 
	<cfelseif isDefined("form.goal") and form.goal NEQ "ALL">
		and u.goal='#form.goal#'  
	</cfif>
	
	<cfif isDefined("form.modality") and form.modality NEQ "ALL">
	and (u.userid='SHARED' or u.userid in (select userid from contact where partnertype = #form.modality#))
	</cfif>
	<cfif isDefined("form.category") and form.category DOES NOT CONTAIN "ALL">
	and o.groupname = '#form.category#'
	
	</cfif>

order by groupname,targetorgtype, channel, target, rptdate


</cfquery>




<cfreport template="./reports/TFPP.cfr" format = "pdf" query="TFPP">

		<CFREPORTPARAM name=Year2 VALUE="#session.fy#">
<CFREPORTPARAM name=Area VALUE="#form.region#">
		<CFREPORTPARAM name=modality VALUE="ALL">
		<CFREPORTPARAM name=focusarea VALUE="All">
				<CFREPORTPARAM name=monthrange VALUE="All">
		<CFREPORTPARAM name=Prognum VALUE="All">
		<CFREPORTPARAM name=Objective VALUE="All">
		<CFREPORTPARAM name=Strategy VALUE="All">
		<CFREPORTPARAM name=ReportName VALUE="PP">
		<CFREPORTPARAM name=StMonth VALUE="1">
				<CFREPORTPARAM name=StMonth VALUE="1">
		  <CFREPORTPARAM name=endMnth VALUE="1">
		   <CFREPORTPARAM name=stQuarter VALUE="1">
		   		   <CFREPORTPARAM name=endQuarter VALUE="1">
		  <CFREPORTPARAM name=stYear VALUE="2007">
		  <CFREPORTPARAM name=endYear VALUE="2007">
		<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">
		</cfreport> 
		 </cfoutput>
</cfcase>
	
	
<cfcase value="50, 53">
	<cfoutput>
	<cfparam name="session.fy" default="2008">
		<cfparam name="form.Area" default="ALL">
		<cfparam name="form.Region" default="ALL">
		<cfparam name="form.fArea" default="ALL">
		<cfparam name="form.partner" default="ALL">
		
		
<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="TFPP">	
	select c.orgname, 
case c.partnertype
when 1 then 'CC'
when 2 then 'CP'
when 3 then 'YP'
when 4 then 'SP'
when 9 then 'shared'
else 'unknown'
end as modality,
namesig, agencydir, accomp, goals, complete, REPLACE(REPLACE(replace(replace(isNull(contamt, 0), ',',''),',',''),'$',''),'','') as contamt,
cbseq, c.userid, b.year2
	from eoy_basics b, contact c , area as ar, region as r
	where 
b.userid=c.userid
and c.partnertype=1
and b.year2= #session.fy#
and b.year2=ar.year2
and ar.year2=r.year2
and c.area=ar.num
and ar.region=r.num
<cfif form.area NEQ 'All' and form.partner EQ 'All'>
and c.area=#form.area# 
</cfif>
<cfif form.region NEQ 'All' and form.partner EQ 'All'>
and r.num=#form.region# 
</cfif>
<cfif form.partner NEQ 'All'>
and c.userid = '#form.partner#'
</cfif>
	<cfif isDefined("form.modality") and form.modality NEQ "ALL">
	and (c.partnertype = #form.modality#)
	</cfif>
order by 1
</cfquery>



<cfif form.rptType EQ 50>
	<cfif session.fy LT 2009>
		<cfreport template="./reports/eoy_rpt4CC.cfr" format = "pdf" query="TFPP">
		<CFREPORTPARAM name=Year2 VALUE="#session.fy#">
		<CFREPORTPARAM name=Area VALUE="#form.region#">
		<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">
		<CFREPORTPARAM name=modality VALUE="Cessation Center">		
		</cfreport> 
	<cfelse>
		<cfreport template="./reports/eoy_rpt4CC_2009.cfr" format = "pdf" query="TFPP">
		<CFREPORTPARAM name=Year2 VALUE="#session.fy#">
		<CFREPORTPARAM name=Area VALUE="#form.region#">
		<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">
		<CFREPORTPARAM name=modality VALUE="Cessation Center">		
		</cfreport> 
	</cfif>


<cfelse>
	<cfif session.fy LT 2009>
		<cfreport template="./reports/eoy_rpt4CC_sum.cfr" format = "pdf" query="TFPP">
		<CFREPORTPARAM name=Year2 VALUE="#session.fy#">
		<CFREPORTPARAM name=Area VALUE="#form.region#">
		<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">
		<CFREPORTPARAM name=modality VALUE="Cessation Center">		
		</cfreport> 	
	<cfelse>
		<cfreport template="./reports/eoy_rpt4CC_sum_2009.cfr" format = "pdf" query="TFPP">
		<CFREPORTPARAM name=Year2 VALUE="#session.fy#">
		<CFREPORTPARAM name=Area VALUE="#form.region#">
		<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">
		<CFREPORTPARAM name=modality VALUE="Cessation Center">		
		</cfreport> 
	
	</cfif>
</cfif>
</cfoutput>
</cfcase>


<cfcase value="51, 54">
	<cfoutput>
	<cfparam name="session.fy" default="2008">
		<cfparam name="form.Area" default="ALL">
		<cfparam name="form.Region" default="ALL">
		<cfparam name="form.fArea" default="ALL">
		<<cfparam name="form.partner" default="ALL">
	
	
	
		
<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="TFPP">	
	select c.orgname, 
case c.partnertype
when 1 then 'CC'
when 2 then 'CP'
when 3 then 'YP'
when 4 then 'SP'
when 9 then 'shared'
else 'unknown'
end as modality,
namesig, agencydir, accomp, goals, complete, cast(REPLACE(REPLACE(replace(replace(isNull(contamt, 0), ',',''),',',''),'$',''),'','') as decimal) as contamt,
cbseq, c.userid, b.year2
	from eoy_basics b, contact c, area a, region r
	where 
b.userid=c.userid
and c.partnertype=2
and b.year2=#session.fy#
and b.year2=a.year2
and a.year2=r.year2
and c.area=a.num
and a.region=r.num
<cfif form.area NEQ 'All' and form.partner EQ 'All'>
and c.area=#form.area# 
</cfif>
<cfif form.region NEQ 'All' and form.partner EQ 'All'>
and r.num=#form.region# 
</cfif>
<cfif form.partner NEQ 'All'>
and c.userid = '#form.partner#'
</cfif>
	<cfif isDefined("form.modality") and form.modality NEQ "ALL">
	and (c.partnertype = #form.modality#)
	</cfif>
order by 1
</cfquery>



<cfparam name="form.region" default="ALL">
<cfparam name="form.partner" default="ALL">


<cfif form.rptType EQ 51>
	<cfif session.fy LT 2009>
		<cfreport template="./reports/eoy_rpt4CP.cfr" format = "pdf" query="TFPP">
		<CFREPORTPARAM name=Year2 VALUE="#session.fy#">
		<CFREPORTPARAM name=Area VALUE="#form.region#">
		<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">
		<CFREPORTPARAM name=modality VALUE="Community Partnership">		
		</cfreport> 
	<cfelse>
	
		<cfreport template="./reports/eoy_rpt4CP_2009.cfr" format = "pdf" query="TFPP">
		<CFREPORTPARAM name=Year2 VALUE="#session.fy#">
		<CFREPORTPARAM name=Area VALUE="#form.region#">
		<CFREPORTPARAM name=PartnerName VALUE="#form.partner#"> 
		<CFREPORTPARAM name=modality VALUE="Community Partnership">
		
		<!--- <CFREPORTPARAM name=Year2 VALUE="2009">
		<CFREPORTPARAM name=Area VALUE="2">
		<CFREPORTPARAM name=PartnerName VALUE="satfc">
		<CFREPORTPARAM name=modality VALUE="Community Partnership">		 --->
		</cfreport> 
	</cfif>

<cfelse>
	<cfif session.fy LT 2009>
		<cfreport template="./reports/eoy_rpt4CP_sum.cfr" format = "pdf" query="TFPP">
		<CFREPORTPARAM name=Year2 VALUE="#session.fy#">
		<CFREPORTPARAM name=Area VALUE="#form.region#">
		<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">
		<CFREPORTPARAM name=modality VALUE="Community Partnership">		
		</cfreport> 
	<cfelse>
		<cfreport template="./reports/eoy_rpt4CP_sum_2009.cfr" format = "pdf" query="TFPP">
		<CFREPORTPARAM name=Year2 VALUE="#session.fy#">
		<CFREPORTPARAM name=Area VALUE="#form.region#">
		<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">
		<CFREPORTPARAM name=modality VALUE="Community Partnership">		
		</cfreport> 
		
	</cfif>
</cfif>


</cfoutput>
</cfcase>

<cfcase value="52, 55">
	<cfoutput>
	<cfparam name="session.fy" default="2008">
		<cfparam name="form.Area" default="ALL">
		<cfparam name="form.Region" default="ALL">
		<cfparam name="form.fArea" default="ALL">
		<<cfparam name="form.partner" default="ALL">
		
		
<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="TFPP">	
	select c.orgname, 
case c.partnertype
when 1 then 'CC'
when 2 then 'CP'
when 3 then 'YP'
when 4 then 'SP'
when 9 then 'shared'
else 'unknown'
end as modality,
namesig, agencydir, accomp, goals, complete, REPLACE(REPLACE(replace(replace(isNull(contamt, 0), ',',''),',',''),'$',''),'','') as contamt,
cbseq, c.userid, b.year2
	from eoy_basics b, contact c , area a, region r
	where 
b.userid=c.userid
and c.partnertype=3
and b.year2= #session.fy#
and b.year2=a.year2
and a.year2=r.year2
and c.area=a.num
and a.region=r.num
<cfif form.area NEQ 'All' and form.partner EQ 'All'>
and c.area=#form.area# 
</cfif>
<cfif form.region NEQ 'All' and form.partner EQ 'All'>
and r.num=#form.region# 
</cfif>
<cfif form.partner NEQ 'All'>
and c.userid = '#form.partner#'
</cfif>
	<cfif isDefined("form.modality") and form.modality NEQ "ALL">
	and (c.partnertype = #form.modality#)
	</cfif> 
	order by 1
</cfquery>

<cfif form.rptType EQ 52>
	<!--- <cfreport template="./reports/eoy_rpt4YPa.cfr" format = "pdf" query="TFPP">
	<CFREPORTPARAM name=Year2 VALUE="#session.fy#">
	<CFREPORTPARAM name=Area VALUE="#form.region#">
	<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">
	<CFREPORTPARAM name=modality VALUE="Youth Partner">	 --->
	
	<cfif session.fy LT 2009>
		<cfreport template="./reports/eoy_rpt4YPa.cfr" format = "pdf" query="TFPP">
		<CFREPORTPARAM name=Year2 VALUE="#session.fy#">
		<CFREPORTPARAM name=Area VALUE="#form.region#">
		<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">
		<CFREPORTPARAM name=modality VALUE="Youth Partner">		
		</cfreport> 
	<cfelse>
		<cfreport template="./reports/eoy_rpt4YP1_2009.cfr" format = "pdf" query="TFPP" >
		<!--- <CFREPORTPARAM name=Year2 VALUE="#session.fy#">
		<CFREPORTPARAM name=Area VALUE="#form.region#">
		<CFREPORTPARAM name=PartnerName VALUE="#form.partner#"> --->
		
		<CFREPORTPARAM name=Year2 VALUE="#session.fy#">
		<CFREPORTPARAM name=Area VALUE="#form.region#">
		<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">
		<CFREPORTPARAM name=modality VALUE="Youth Partner">		
		</cfreport> 
	</cfif>
		
<!--- </cfreport>  --->
<cfelse>
	<cfif session.fy LT 2009>
		<cfreport template="./reports/eoy_rpt4YPa_sum.cfr" format = "pdf" query="TFPP">
		<CFREPORTPARAM name=Year2 VALUE="#session.fy#">
		<CFREPORTPARAM name=Area VALUE="#form.region#">
		<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">
		<CFREPORTPARAM name=modality VALUE="Youth Partner">	
		</cfreport> 
	<cfelse>
		<cfreport template="./reports/eoy_rpt4YP1_sum_2009.cfr" format = "pdf" query="TFPP">
		<CFREPORTPARAM name=Year2 VALUE="#session.fy#">
		<CFREPORTPARAM name=Area VALUE="#form.region#">
		<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">
		<CFREPORTPARAM name=modality VALUE="Youth Partner">	
		</cfreport> 
		
	</cfif>	

</cfif>
</cfoutput>
</cfcase>

<cfcase value="60,61">
	<cfoutput>

<cfparam name="form.Area" default="ALL">
<cfparam name="form.Region" default="ALL">
<cfparam name="form.fArea" default="ALL">
<cfparam name="form.partner" default="ALL">
<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="QEOY">
	<!--- 	select 
<!--- a.area --->r.region as area, c.orgname, v.userid, CAST(v.bedscode AS NUMERIC) BEDSCODE, v.institutionname, lastupd,
case  when v.bedscode like '%0000' then 1 else 0 end as distlvl,
nd.district_name,
case sum(acp1) when 0 then 0 else 1 end as acp1,
case sum(acp2) when 0 then 0 else 1 end as acp2,
case sum(acp3) when 0 then 0 else 1 end as acp3,
case sum(spp1) when 0 then 0 else 1 end as spp1,
case sum(spp2) when 0 then 0 else 1 end as spp2,
case sum(spp3) when 0 then 0 else 1 end as spp3,
case sum(spp4) when 0 then 0 else 1 end as spp4,
case sum(tarp1) when 0 then 0 else 1 end as tarp1,
case sum(tarp2) when 0 then 0 else 1 end as tarp2,
case sum(tarp3) when 0 then 0 else 1 end as tarp3,
case sum(tarp4) when 0 then 0 else 1 end as tarp4,
case sum(tarp5) when 0 then 0 else 1 end as tarp5,
case sum(taip1) when 0 then 0 else 1 end as taip1,
case sum(taip2) when 0 then 0 else 1 end as taip2,
case sum(taip3) when 0 then 0 else 1 end as taip3,
case sum(taip4) when 0 then 0 else 1 end as taip4,
case sum(taip_5) when 0 then 0 else 1 end as taip5,
case sum(qob)   when 0 then 0 else 1 end as qob,
case sum(qsurv) when 0 then 0 else 1 end as qsurv,
1 as detprt, 0 as headprt, filler


FROM         nysed_district as nd, nysed_school as ns, dbo.eoygrid_temp AS v INNER JOIN
                      dbo.contact AS c ON v.userid = c.userid INNER JOIN
                      dbo.Area AS a ON a.num = c.area and a.year2=v.year2
					inner join dbo.region as r on a.year2=r.year2 and a.region=r.num

where 

v.year2 <=#session.fy#
	<cfif form.area NEQ 'All' and form.partner EQ 'All'>
	and c.area=#form.area#
	</cfif>
	<cfif form.region NEQ 'All' and form.partner EQ 'All'>
	and r.num=#form.region#
	</cfif>
	<cfif form.partner NEQ 'All'>
	and c.userid = '#form.partner#'
	</cfif>
and not(
acp1=0 and acp2=0 and acp3=0
and spp1=0 and spp2=0 and spp2=0 and spp4=0
and tarp1=0 and tarp2=0 and tarp3=0 and tarp4=0 and tarp5=0
and taip1=0 and taip2=0 and taip3=0 and taip4=0 and taip_5 =0
and qob=0 and qsurv=0
)
and ns.district=nd.district_id
and v.bedscode=ns.bedscode
group by 
<!--- a.area ---> r.region, c.orgname, v.userid, v.bedscode, v.institutionname, v.filler, lastupd, nd.district_name

union
select  <!--- a.area --->r.region as area, co.orgname, co.userid, n.bedscode, n.institutionname, ' ',
case  when n.bedscode like '%0000' then 1 else 0 end as distlvl,
nd.district_name,
' ', ' ', ' ', ' ', ' ', ' ', ' ',
' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ',
' ', ' ', ' ', ' ', 0 as detprt, 1 as headprt, 0

from nysed_district as nd,nysed_school as n
, contact co, nysed_county nc, area a, region r
where 
a.num = co.area and 
co.catchment like '%' + cast(nc.fips as varchar) + '%'
and nc.county_id = left(bedscode,2)
and bedscode like '%0000'	
and a.year2=2007
and a.year2=r.year2
and co.area=a.num
and a.region=r.num

and bedscode not in (select v.bedscode
from
dbo.eoygrid_temp  as v 
where 
v.year2 <=#session.fy#
and not(
acp1=0 and acp2=0 and acp3=0
and spp1=0 and spp2=0 and spp2=0 and spp4=0
and tarp1=0 and tarp2=0 and tarp3=0 and tarp4=0 and tarp5=0
and taip1=0 and taip2=0 and taip3=0 and taip4=0 and taip_5=0
and qob=0 and qsurv=0))

and  left(bedscode, 8) in 
(select left(v.bedscode, 8)
from
dbo.eoygrid_temp  as v 
where 
v.year2 <=#session.fy#
and not(
acp1=0 and acp2=0 and acp3=0
and spp1=0 and spp2=0 and spp2=0 and spp4=0
and tarp1=0 and tarp2=0 and tarp3=0 and tarp4=0 and tarp5=0
and taip1=0 and taip2=0 and taip3=0 and taip4=0 and taip_5=0
and qob=0 and qsurv=0))
and partnertype = 4
and n.district=nd.district_id
<cfif form.area NEQ 'All' and form.partner EQ 'All'>
	and co.area=#form.area#
	</cfif>
	<cfif form.region NEQ 'All' and form.partner EQ 'All'>
	and r.num=#form.region#
	</cfif>
		<cfif form.partner NEQ 'All'>
	and co.userid = '#form.partner#'
	</cfif>
order by a.area, orgname, 8, 7 desc, 5 --->

select 
r.region, co.orgname,
case 
	 when unit IS NULL then ltrim(NAME)
	 else ltrim(unit) + ' ' + NAME
	end as unitname ,
case sum(isNull(ac.collab_id,0)) when 0 then 0 else 1 end as col1,
case sum(isNull(bl.thcpo,0)) when 0 then 0 else 1 end as col2,
case sum(isNull(t.collab_id,0)) when 0 then 0 else 1 end as col3,
case sum(isNull(ta.collab_id,0)) when 0 then 0 else 1 end as col4,
case sum(case when (ta.material like '%21%') then 1 else 0 end) when 0 then 0 else 1 end as col5,

case sum(isNull(PP_tfp_b,0)) when 0 then 0 else 1 end as col6,
case sum(isNull(pp_pol_bit,0)) when 0 then 0 else 1 end as col7,
case sum(isNull(pp_sys_bit,0)) when 0 then 0 else 1 end as col8,

case sum(case when (pp_prac_bit=1 AND pp_prac_cb like '%1%') then 1 else 0 end) when 0 then 0 else 1 end as col9,
case sum(case when (pp_prac_bit=1 AND pp_prac_cb like '%2%') then 1 else 0 end) when 0 then 0 else 1 end as col10,
case sum(case when (pp_prac_bit=1 AND pp_prac_cb like '%5%') then 1 else 0 end) when 0 then 0 else 1 end as col11,
case sum(case when (pp_prac_bit=1 AND pp_prac_cb like '%4%') then 1 else 0 end) when 0 then 0 else 1 end as col12,
case sum(case when (pp_prac_bit=1 AND pp_prac_cb like '%3%') then 1 else 0 end) when 0 then 0 else 1 end as col13,

case sum(isNull(pp_ftq_a,0)) when 0 then 0 else 1 end as col14,
case sum(isNull(pp_cessAss_a,0)) when 0 then 0 else 1 end as col15,
case sum(isNull(pp_ed_a,0)) when 0 then 0 else 1 end as col16,

case sum(isNull(pp_feedback_b,0)) when 0 then 0 else 1 end as col17,
case sum(isNull(pp_cess_b,0)) when 0 then 0 else 1 end as col18,
case sum(isNull(pp_cessAss_b,0)) when 0 then 0 else 1 end as col19,
case sum(isNull(pp_depend_b,0)) when 0 then 0 else 1 end as col20,
case sum(isNull(pp_trans_a,0)) when 0 then 0 else 1 end as col21,

<cfif form.rpttype EQ 60 OR session.fy EQ 2009>
case sum(isNull(cast(s.ccpm_1 as integer), 0)) when 0 then 0 else 1 end as ccpm_1,
case sum(isNull(cast(s.ccpm_2 as integer), 0)) when 0 then 0 else 1 end as ccpm_2,
case sum(isNull(cast(s.ccpm_3 as integer), 0)) when 0 then 0 else 1 end as ccpm_3,
case sum(isNull(cast(s.ccpm_4 as integer), 0)) when 0 then 0 else 1 end as ccpm_4,
case sum(isNull(cast(s.ccpm_5 as integer), 0)) when 0 then 0 else 1 end as ccpm_5,
case sum(isNull(cast(s.ccpm_6 as integer), 0)) when 0 then 0 else 1 end as ccpm_6,
case sum(isNull(cast(s.ccpm_7 as integer), 0)) when 0 then 0 else 1 end as ccpm_7,
case sum(isNull(cast(s.ccpm_8 as integer), 0)) when 0 then 0 else 1 end as ccpm_8,
case sum(isNull(cast(s.ccpm_9 as integer), 0)) when 0 then 0 else 1 end as ccpm_9,
case sum(isNull(cast(s.ccpm_10 as integer), 0)) when 0 then 0 else 1 end as ccpm_10,

case sum(isNull(cast(s.ccpm_11 as integer), 0)) when 0 then 0 else 1 end as ccpm_11,
case sum(isNull(cast(s.ccpm_12 as integer), 0)) when 0 then 0 else 1 end as ccpm_12,
case sum(isNull(cast(s.ccpm_13 as integer), 0)) when 0 then 0 else 1 end as ccpm_13,
case sum(isNull(cast(s.ccpm_14 as integer), 0)) when 0 then 0 else 1 end as ccpm_14,
case sum(isNull(cast(s.ccpm_15 as integer), 0)) when 0 then 0 else 1 end as ccpm_15,
case sum(isNull(cast(s.ccpm_16 as integer), 0)) when 0 then 0 else 1 end as ccpm_16,
case sum(isNull(cast(s.ccpm_17 as integer), 0)) when 0 then 0 else 1 end as ccpm_17,
case sum(isNull(cast(s.ccpm_18 as integer), 0)) when 0 then 0 else 1 end as ccpm_18,
case sum(isNull(cast(s.ccpm_19 as integer), 0)) when 0 then 0 else 1 end as ccpm_19,
case sum(isNull(cast(s.ccpm_20 as integer), 0)) when 0 then 0 else 1 end as ccpm_20,
case sum(isNull(cast(s.ccpm_21 as integer), 0)) when 0 then 0 else 1 end as ccpm_21
<cfelse>
0 as ccpm_1,
0 as ccpm_2,
0 as ccpm_3,
0 as ccpm_4,
0 as ccpm_5,
0 as ccpm_6,
0 as ccpm_7,
0 as ccpm_8,
0 as ccpm_9,
0 as ccpm_10,

0 as ccpm_11,
0 as ccpm_12,
0 as ccpm_13,
0 as ccpm_14,
0 as ccpm_15,
0 as ccpm_16,
0 as ccpm_17,
0 as ccpm_18,
0 as ccpm_19,
0 as ccpm_20,
0 as ccpm_21

</cfif>

from  region r, area a, contact co, collaborators c 
left outer join advocCC_pp b on b.thcpo=c.seq <cfif form.rptType EQ "60"> and b.year2 <= #session.fy#<cfelse> and b.year2=#session.fy#</cfif> and b.year2 >=2009
left outer join cchco_ac ac on ac.collab_id=c.seq <cfif form.rptType EQ "60"> and ac.year2 <= #session.fy#<cfelse> and ac.year2=#session.fy#</cfif> and ac.year2 >=2009
left outer join advocCC_baselines bl on bl.tHCPO=c.seq <cfif form.rptType EQ "60"> and bl.year2 <= #session.fy#<cfelse> and bl.year2=#session.fy#</cfif> and bl.year2 >=2009
left outer join cchco_train_det t on t.collab_id=c.seq  
inner join cchco_train ct on t.train_seq=ct.seq  <cfif form.rptType EQ "60"> and ct.year2 <= #session.fy#<cfelse> and ct.year2=#session.fy#</cfif> and ct.year2 >=2009
left outer join cchco_ta ta on ta.collab_id=c.seq <cfif form.rptType EQ "60"> and ta.year2 <= #session.fy#<cfelse> and ta.year2=#session.fy#</cfif> and ta.year2 >=2009
left outer join ccpm_supp s on s.thcpo=c.seq

where co.userid = c.userid
and co.partnertype = 1
  and (c.del is null or c.del !=1)
and a.num = co.area
and a.region=r.num
and a.year2=r.year2
and a.year2=2008
and c.del is null

<cfif form.region NEQ 'All' and form.partner EQ 'All'>
	and r.num=#form.region#
	</cfif>
		<cfif form.partner NEQ 'All'>
	and co.userid = '#form.partner#'
	</cfif>
group by c.unit, c.name, r.region, co.orgname

order by 1, 2, 3
</cfquery>

	<cfreport template="./reports/CCPM.cfr" format = "pdf" query="qeoy">

		<CFREPORTPARAM name=Year2 VALUE=#session.fy#>
		<CFREPORTPARAM name=Area VALUE="#form.region#">
		<CFREPORTPARAM name=modality VALUE="ALL">
		<CFREPORTPARAM name=FA VALUE="All">
		<CFREPORTPARAM name=Prognum VALUE="All">
		<CFREPORTPARAM name=Objective VALUE="All">
		<CFREPORTPARAM name=Strategy VALUE="All">
		<CFREPORTPARAM name=ReportName VALUE="PP">
		<CFREPORTPARAM name=StMonth VALUE="1">
		  <CFREPORTPARAM name=endMnth VALUE="2">
		  <CFREPORTPARAM name=stYear VALUE="2007">
		  <CFREPORTPARAM name=endYr VALUE="2007">		 
  		  <cfif form.rptType EQ "60">
		<cfreportparam name=title value="Cumulative">
			<cfelse>
		<cfreportparam name=title value="by Fiscal Year">	
			</cfif>		 
		<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">
		</cfreport>  
		 

</cfoutput>
</cfcase>
<cfcase value="62">
	<cfoutput>
	#form.objective#
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
			and year2=#session.fy#
			order by initiative
		</cfquery>
		<cfset obj = ListAppend(obj, qobj.initiative, ",")>
		<cfset objlst = #quotedvaluelist(qobj.id)#>
		</cfloop>
		</cfif>

		</cfoutput>


<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="conmon">
select case m.mon when 1 then 'January' when 2 then 'February' when 3 then 'March' when 4 then 'April' when 5 then 'May' when 6 then 'June' when 7 then 'July' when 8 then 'August' when 9 then 'September' when 10 then 'October' when 11 then 'November' when 12 then 'December' end as monty,
	initnum,initiative,advmassmail,m.userid,editor,prsspk,prssrlse,calls,'' as legvisit,'' as legcorr,'' as mediarep,'' as numsub,'' as numpub,summary,barriers,steps
	from monthly m
	inner join objectives o
	on m.initnum = o.id and m.year2 = o.year2
	inner join months mo on m.mon = mo.mon_num and m.year2 = mo.year2
	where 
	1=1
	<cfif isdefined("form.partner")>
	and m.userid='#form.partner#'</cfif>
	and m.year2=#session.fy#
    and mo.rank >= '#form.stmonth#'
	and mo.rank <= '#form.endmonth#'	<cfif isdefined("form.objective")>
	and initnum in (#ListQualify(Form.objective,"'")#) </cfif>
		
	union
select case mon when 1 then 'January' when 2 then 'February' when 3 then 'March' when 4 then 'April' when 5 then 'May' when 6 then 'June' when 7 then 'July' when 8 then 'August' when 9 then 'September' when 10 then 'October' when 11 then 'November' when 12 then 'December' end as monty,
	'999' as initnum,'' as initiative,'' as advmassmail,userid,'' as editor,'' as prsspk,'' as prssrlse,'' as calls,legvisit,legcorr,mediarep,numsub,numpub,'' as summary,'' as barriers,'' as steps
	from infra
	where
	1=1		<cfif isdefined("form.partner")>
	and userid='#form.partner#'</cfif>
	and year2=#session.fy# <!--- --->

order by initnum<!---	

<cfif form.region NEQ 'All' and form.partner EQ 'All'>
	and r.num=#form.region#
	</cfif>
		<cfif form.partner NEQ 'All'>
	and co.userid = '#form.partner#'
	</cfif>
group by c.unit, c.name, r.region, co.orgname

order by 1, 2, 3 --->
</cfquery>

<cfreport template="./reports/conmon.cfr" format = "pdf" query="conmon">

		<CFREPORTPARAM name=Year2 VALUE=#session.fy#>
		<CFREPORTPARAM name=Area VALUE="#form.region#">
		<CFREPORTPARAM name=modality VALUE="ALL">
		<CFREPORTPARAM name=FOCUSAREA VALUE="All">
		<CFREPORTPARAM name=Prognum VALUE="All">

				<CFREPORTPARAM name=Obj VALUE="#obj#">

	<cfif isdefined("form.objective")>
				<CFREPORTPARAM name=Objective VALUE="#form.objective#">
<cfelse>
			<CFREPORTPARAM name=Objective VALUE="All">

	</cfif>		<CFREPORTPARAM name=Strategy VALUE="All">
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
		<CFREPORTPARAM name=ModWrd VALUE="Community Partnership">
		<cfelseif isdefined("form.modality") and #form.modality# is 3>
		<CFREPORTPARAM name=ModWrd VALUE="Youth Action">
		</cfif>
		<CFREPORTPARAM name=Monthrange VALUE="#Monthrange#">
		</cfreport>  

 ---></cfoutput>
</cfcase>


</cfswitch>