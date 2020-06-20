<!--- <cfif session.modality EQ 4> --->
	<cfset session.rptmode = "spMode">
	<cfset rptmodality = "School Policy Partners">
<!--- <cfelse>
	<cfset session.rptmode = "main">
</cfif>
 --->
<cfif isDefined("form.stmonth") and #form.rpttype# is not 17>
<cfquery datasource="#Application.DataSource#"  		 
	password="#Application.db_password#"  		
	username="#Application.db_username#" name="Qstmn">
	select sp_rank as rank, mon_num
	from months 
	where sp_rank=#form.stmonth# and year2 = #session.fy#
	order by 1
</cfquery>

<cfquery datasource="#Application.DataSource#"  		 
	password="#Application.db_password#"  		
	username="#Application.db_username#" name="Qendmn">
	select sp_rank as rank, mon_num
	from months 
	where sp_rank=#form.endmonth# and year2 = #session.fy#
	order by 1
</cfquery>


<cfquery datasource="#Application.DataSource#"  		 
	password="#Application.db_password#"  		
	username="#Application.db_username#" name="QstmnW">
	select mon
	from months 
	where <cfif session.fy GTE 2011 and session.fy LT 2013>rank<cfelse>sp_rank</cfif>=#form.stmonth# and year2 = #session.fy#
	order by 1
</cfquery>

<cfquery datasource="#Application.DataSource#"  		 
	password="#Application.db_password#"  		
	username="#Application.db_username#" name="QendmnW">
	select mon
	from months 
	where <cfif session.fy GTE 2011 and session.fy LT 2013>rank<cfelse>sp_rank</cfif>=#form.endmonth# and year2 = #session.fy#
	order by 1
</cfquery>




<cfquery datasource="#Application.DataSource#"  		 
	password="#Application.db_password#"  		
	username="#Application.db_username#" name="Qmonlist">
	select mon, mon_num
	from months 
	where <cfif session.fy GTE 2011 and session.fy LT 2013>rank<cfelse>sp_rank</cfif> between #Qstmn.rank# and  #Qendmn.rank#
	and year2=#session.fy#
	order by sp_rank
</cfquery>
<cfset modality_rank = "sp_rank">

<cfset monthrange="(#quotedValueList(QMonlist.Mon, "~,~")#)">
<cfset monthrange2="#quotedValueList(QMonlist.Mon)#">
<cfset monthrange=replace(monthrange,"('", "(~~")>
<cfset monthrange=replace(monthrange,"')", "~~)")>
<cfset monthrange=rereplace(monthrange,"'", "~", "all")>
<cfset monthrange3=rereplace(monthrange2,"'", "", "all")>
<cfset monthrange6="#ValueList(QMonlist.Mon)#">

</cfif>

<!--- <cfif #session.fy# is "1904">
<cfset rptfy="2006">
<cfelse> --->
<cfset rptfy="#session.fy#">
<!--- </cfif> --->


<cfif NOT isDefined("form.rptType")>
	<cflocation url="reporthandler_modSP.cfm" addtoken="yes">
</cfif>


<!--- <cfoutput>#monthrange#</cfoutput><cfabort> --->
<cfswitch expression = "#form.rptType#">
	<!--- <cfcase value = 1>
	<!--- Focus Area One --->
		<cfinclude template="rpt_fa_wrapperSP.cfm">
	</cfcase> 
	--->
	
	<cfcase value = 2><!--- workplan summary --->
		<!--- <cfinclude template="rpt1.cfm"> --->
		<cfparam name="rptfy" default="2005">
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
SELECT DISTINCT 
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1)
 	WHEN '*' THEN 'SHARED' ELSE ORGNAME END ORGNAME ,
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

                        <cfparam name="rptfy" default="2005">
                        <cfparam name="form.Area" default="ALL">
		<cfparam name="form.Region" default="ALL">
                        <cfparam name="form.Objective" default="ALL">
                        <cfparam name="form.fArea" default="ALL">
                        <cfparam name="form.goal" default="ALL">
                        <cfparam name="form.partner" default="ALL">
                        <cfparam name="form.strategy" default="ALL"> 
						<cfinclude template="qry_earnedmedia.cfm">

                        <cfreport template="./reports/earnedmediaSP.cfr" format = "#form.format#" query="QEarnedMedia">

                        <CFREPORTPARAM name=Area VALUE=#form.region#>
                        <CFREPORTPARAM name=Objective VALUE=#form.objective#>
                        <CFREPORTPARAM name=FocusArea VALUE="#form.farea#">
                        <CFREPORTPARAM name=Strategy VALUE="#form.strategy#">
                        <CFREPORTPARAM name=Prognum VALUE="#form.goal#">
                        <CFREPORTPARAM name=PartnerName VALUE="#form.partner#">
                        <CFREPORTPARAM name=Year2 VALUE="#rptfy#">
						<CFREPORTPARAM name=ReportName VALUE="progress">
						<CFREPORTPARAM name=Monthrange VALUE="#Monthrange#">
						<CFREPORTPARAM name=modality VALUE="#rptmodality#">

                        </cfreport>

            </cfcase>


	
	<cfcase value = 6>
	<cfparam name="session.fy" default="2005">
<cfparam name="form.Area" default="ALL">
<cfparam name="form.Objective" default="ALL">
<cfparam name="form.fArea" default="ALL">
<cfparam name="form.goal" default="ALL">
<cfparam name="form.partner" default="ALL">
<cfparam name="form.strategy" default="ALL"> 
<cfparam name="form.Monthrange" default="ALL">
<cfparam name="rptmodality" default="ALL">

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
cast(A.BARRIERS as varchar(4000)) as barriers, 
cast(A.SUCCESS as varchar(4000)) as success, 
cast(A.PROGRESS as varchar(4000)) as progress, m.rank, 
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
ELSE (SELECT r.region FROM AREA AR, region R WHERE R.NUM=AR.REGION and AR.NUM = C.AREA AND R.year2=ar.year2 and AR.YEAR2='2007' )  END AREA ,CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1)
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
	AND A.MONTH2=M.MON and a.year2 = m.year2
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
	AND A.MONTH2=M.MON and a.year2 = m.year2
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
cast(A.BARRIERS as varchar(4000)) as barriers, 
cast(A.SUCCESS as varchar(4000)) as success, 
cast(A.PROGRESS as varchar(4000)) as progress, m.rank, 
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
cast(A.BARRIERS as varchar(4000)) as barriers, 
cast(A.SUCCESS as varchar(4000)) as success, 
cast(A.PROGRESS as varchar(4000)) as progress, m.rank, 
	isnull(cast(progress_2 as varchar(4000)), '') as progress_2, 
	isnull(cast(progress_3 as varchar(4000)), '') as progress_3, 
	isnull(cast(progress_4 as varchar(4000)), '') as progress_4, 
	isnull(cast(progress_5 as varchar(4000)), '') as progress_5,
	isnull(cast(success_2 as varchar(4000)), '') as success_2, 
	isnull(cast(success_3 as varchar(4000)), '') as success_3, 
	isnull(cast(success_4 as varchar(4000)), '') as success_4, 
	isnull(cast(success_5 as varchar(4000)), '') as success_5,
	isnull(cast(barriers_2 as varchar(4000)), '') as barriers_2, 
	isnull(cast(barriers_3 as varchar(4000)), '') as barriers_3, 
	isnull(cast(barriers_4 as varchar(4000)), '') as barriers_4, 
	isnull(cast(barriers_5 as varchar(4000)), '') as barriers_5
FROM  PROGRAM  P, OBJECTIVES O,  ADVOC A, MONTHS M, USERACTIVITIES U
left outer join contact as c on 
u.userid=c.userid
	WHERE   U.GOAL=P.PROGNUM AND U.YEAR2=P.YEAR2
 	AND U.OBJECTIVE=O.[ID]AND U.YEAR2=O.YEAR2
 	AND A.YEAR2 = U.YEAR2 AND U.USERID=A.USERID
	AND U.ACTIVITY=A.ACTIVITY
	AND A.MONTH2=M.MON and a.year2 = m.year2
and u.year2=#session.fy#
and (U.DEL IS NULL OR U.DEL != 'Y') AND U.STRATEGY=8 AND (A.BARRIERS IS NOT NULL 
	OR A.PROGRESS_2 IS NOT NULL OR A.PROGRESS_3 IS NOT NULL OR A.PROGRESS_4 IS NOT NULL OR A.PROGRESS_5 IS NOT NULL
	OR A.SUCCESS_2 IS NOT NULL OR A.SUCCESS_3 IS NOT NULL OR A.SUCCESS_4 IS NOT NULL OR A.SUCCESS_5 IS NOT NULL
	OR A.BARRIERS_2 IS NOT NULL OR A.BARRIERS_3 IS NOT NULL OR A.BARRIERS_4 IS NOT NULL OR A.BARRIERS_5 IS NOT NULL
	)
<cfinclude template="report_filter.cfm">
<cfif (NOT isDefined("form.goal")  OR (isDefined("form.goal") and form.goal EQ "ALL")) and (NOT isDefined("form.farea") OR (isDefined("form.farea") and form.farea EQ "ALL")) >
UNION
SELECT
r.region as area,
ORGNAME, 
'Infrastructure', '',
 m.mon as month2,
 '', '', null, null, 
A.BARRIERS, A.SUCCESS,A.PROGRESS,  	m.rank,
'','','','',
'','','','',
'','','',''
FROM  infra_monthly A,
AREA AR, region r,
MONTHS M,
contact as c
WHERE
a.userid=c.userid
	AND A.MONTH2=M.MON
	and a.year2 = m.year2
	AND A.YEAR2=AR.YEAR2
	and ar.year2=r.year2
	and ar.region=r.num
and AR.NUM = C.AREA
AND AR.YEAR2=#session.fy#


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
	
	<cfif isDefined("Monthrange2") and monthrange NEQ "all">
	and	a.month2 in (#quotedValueList(QMonlist.Mon)#)
	</cfif>
</cfif>
order by 1, 2, 3, 13
</cfquery>

<cfoutput>

		<cfreport template="./reports/StratProgSummaryParam.cfr" format = "#form.format#" query="Qsummary">
		
		<!--- <CFREPORTPARAM name=StartMonth VALUE="#form.StMonth#">
		<CFREPORTPARAM name=EndMonth VALUE="#form.endmonth#"> --->
		<CFREPORTPARAM name=Year2 VALUE="#rptfy#">
		<cfif form.area NEQ "ALL">
			<cfquery datasource="#Application.DataSource#"  		 
			password="#Application.db_password#"  		
			username="#Application.db_username#" name="QArea">
			select area from area
			where num='#form.AREA#' and year2=#session.fy#
		</cfquery>
			<CFREPORTPARAM name=Area VALUE="#QArea.area#">
		
		
		<cfelseif form.region NEQ "ALL">
			<cfquery datasource="#Application.DataSource#"  		 
			password="#Application.db_password#"  		
			username="#Application.db_username#" name="QArea">
			select region as area from region
			where num='#form.region#' and year2=#session.fy#
		</cfquery>
			<CFREPORTPARAM name=area VALUE="#QArea.area#">
		<cfelse>
			<CFREPORTPARAM name=area VALUE="">
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
		<CFREPORTPARAM name=modality VALUE="#rptmodality#">
		

<!--- <cfparam name="rptfy" default="2005">
<cfparam name="form.stMonth" default="all">
<cfparam name="form.endmonth" default="all">
<cfparam name="form.Area" default="ALL">
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
ELSE (SELECT AR.AREA FROM AREA AR WHERE AR.NUM = C.AREA AND AR.YEAR2='2007' )  END AREA ,
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1)
WHEN '*' THEN 'SHARED'
ELSE ORGNAME END ORGNAME ,
U.ACTIVITY STRATEGY, LTRIM(RTRIM(CAST(U.ACTIVITYNAME AS VARCHAR(4000)))) STRATEGY_DESCRIPTION, A.MONTH2,
P.PROGRAM  GOAL, O.OBJECTIVE, U.STARTDATE, U.ENDDATE,
A.BARRIERS, A.SUCCESS, A.PROGRESS, m.sp_rank as rank, 
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
ELSE (SELECT AR.AREA FROM AREA AR WHERE AR.NUM = C.AREA AND AR.YEAR2='2007' )  END AREA ,
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1)
WHEN '*' THEN 'SHARED'
ELSE ORGNAME END ORGNAME ,
U.ACTIVITY STRATEGY, LTRIM(RTRIM(CAST(U.ACTIVITYNAME AS VARCHAR(4000)))) STRATEGY_DESCRIPTION, A.MONTH2,
P.PROGRAM  GOAL, O.OBJECTIVE, U.STARTDATE, U.ENDDATE,
A.BARRIERS, A.SUCCESS, A.PROGRESS, m.sp_rank as rank, 
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
	AND A.MONTH2=M.MON 
and u.year2=#session.fy#
AND (U.DEL IS NULL OR U.DEL != 'Y') AND U.STRATEGY=1 AND A.BARRIERS IS NOT NULL 
<cfinclude template="report_filter.cfm">
UNION
SELECT  distinct
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1) 	
WHEN  '*' THEN  'JOINT' 
ELSE (SELECT AR.AREA FROM AREA AR WHERE AR.NUM = C.AREA AND AR.YEAR2='2007' )  END AREA ,
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1)
WHEN '*' THEN 'SHARED'
ELSE ORGNAME END ORGNAME ,
U.ACTIVITY STRATEGY, LTRIM(RTRIM(CAST(U.ACTIVITYNAME AS VARCHAR(4000)))) STRATEGY_DESCRIPTION, A.MONTH2,
P.PROGRAM  GOAL, O.OBJECTIVE, U.STARTDATE, U.ENDDATE,
A.BARRIERS, A.SUCCESS, A.PROGRESS, m.sp_rank as rank, 
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
ELSE (SELECT AR.AREA FROM AREA AR WHERE AR.NUM = C.AREA AND AR.YEAR2='2007' )  END AREA ,
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1)
WHEN '*' THEN 'SHARED'
ELSE ORGNAME END ORGNAME ,
U.ACTIVITY STRATEGY, LTRIM(RTRIM(CAST(U.ACTIVITYNAME AS VARCHAR(4000)))) STRATEGY_DESCRIPTION, A.MONTH2,
P.PROGRAM  GOAL, O.OBJECTIVE, U.STARTDATE, U.ENDDATE,
A.BARRIERS, A.SUCCESS, A.PROGRESS, m.sp_rank as rank, 
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
	AND A.MONTH2=M.MON 
and u.year2=#session.fy#
AND (U.DEL IS NULL OR U.DEL != 'Y') AND U.STRATEGY=4 AND A.BARRIERS IS NOT NULL 
<cfinclude template="report_filter.cfm">
UNION
SELECT  distinct
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1) 	
WHEN  '*' THEN  'JOINT' 
ELSE (SELECT AR.AREA FROM AREA AR WHERE AR.NUM = C.AREA AND AR.YEAR2='2007' )  END AREA ,
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1)
WHEN '*' THEN 'SHARED'
ELSE ORGNAME END ORGNAME ,
U.ACTIVITY STRATEGY, LTRIM(RTRIM(CAST(U.ACTIVITYNAME AS VARCHAR(4000)))) STRATEGY_DESCRIPTION, A.MONTH2,
P.PROGRAM  GOAL, O.OBJECTIVE, U.STARTDATE, U.ENDDATE,
A.BARRIERS, A.SUCCESS, A.PROGRESS, m.sp_rank as rank, 
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
ELSE (SELECT AR.AREA FROM AREA AR WHERE AR.NUM = C.AREA AND AR.YEAR2='2007' )  END AREA ,
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1)
WHEN '*' THEN 'SHARED'
ELSE ORGNAME END ORGNAME ,
U.ACTIVITY STRATEGY, LTRIM(RTRIM(CAST(U.ACTIVITYNAME AS VARCHAR(4000)))) STRATEGY_DESCRIPTION, A.MONTH2,
P.PROGRAM  GOAL, O.OBJECTIVE, U.STARTDATE, U.ENDDATE,
A.BARRIERS, A.SUCCESS, A.PROGRESS, m.sp_rank as rank, 
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
	AND A.MONTH2=M.MON 
and u.year2=#session.fy#
AND (U.DEL IS NULL OR U.DEL != 'Y') AND U.STRATEGY=6 AND A.BARRIERS IS NOT NULL 
<cfinclude template="report_filter.cfm">
UNION
SELECT  distinct
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1) 	
WHEN  '*' THEN  'JOINT' 
ELSE (SELECT AR.AREA FROM AREA AR WHERE AR.NUM = C.AREA AND AR.YEAR2='2007' )  END AREA ,
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1)
WHEN '*' THEN 'SHARED'
ELSE ORGNAME END ORGNAME ,
U.ACTIVITY STRATEGY, LTRIM(RTRIM(CAST(U.ACTIVITYNAME AS VARCHAR(4000)))) STRATEGY_DESCRIPTION, A.MONTH2,
P.PROGRAM  GOAL, O.OBJECTIVE, U.STARTDATE, U.ENDDATE,
A.BARRIERS, A.SUCCESS, A.PROGRESS, m.sp_rank as rank, 
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
ELSE (SELECT AR.AREA FROM AREA AR WHERE AR.NUM = C.AREA AND AR.YEAR2='2007' )  END AREA ,
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1)
WHEN '*' THEN 'SHARED'
ELSE ORGNAME END ORGNAME ,
U.ACTIVITY STRATEGY, LTRIM(RTRIM(CAST(U.ACTIVITYNAME AS VARCHAR(4000)))) STRATEGY_DESCRIPTION, A.MONTH2,
P.PROGRAM  GOAL, O.OBJECTIVE, U.STARTDATE, U.ENDDATE,
A.BARRIERS, A.SUCCESS, A.PROGRESS, m.sp_rank as rank, 
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
ELSE (SELECT AR.AREA FROM AREA AR WHERE AR.NUM = C.AREA AND AR.YEAR2='2007' )  END AREA ,
CASE SUBSTRING(LTRIM(RTRIM(U.ACTIVITY)),1,1)
WHEN '*' THEN 'SHARED'
ELSE ORGNAME END ORGNAME ,
U.ACTIVITY STRATEGY, LTRIM(RTRIM(CAST(U.ACTIVITYNAME AS VARCHAR(4000)))) STRATEGY_DESCRIPTION, A.MONTH2,
P.PROGRAM  GOAL, O.OBJECTIVE, U.STARTDATE, U.ENDDATE,
A.BARRIERS, A.SUCCESS, A.PROGRESS, m.sp_rank as rank, 
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
		<cfif form.area NEQ "ALL">
			<cfquery datasource="#Application.DataSource#"  		 
			password="#Application.db_password#"  		
			username="#Application.db_username#" name="QArea">
			select area from area
			where num='#form.AREA#' and year2=#session.fy#
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
		select program from programs where prognum = '#form.goal#'
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
		<!--- <CFREPORTPARAM name=Monthrange VALUE="#monthrange#">	 --->	 --->
		 </cfreport>
		 </cfoutput>
	</cfcase> 
	
	
	<cfcase value = 7>
	<cfif session.fy LT 2009>
	<cfinclude template="rpt_infraSP.cfm">
<cfelse>
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
<cfquery datasource="#application.DataSource#"  		 
	password="#application.db_password#"   		
	username="#application.db_username#" name="infra">
	select infra_monthly.userid,it_con,staff_time,staff_job_desc,staff_recruit,
	staff_interview,staff_hired,partner_recruit,
	partner_maint,fiscal_voucher,fiscal_track, barriers, progress, success, 
	tcp_con, tcp_am, tcp_rm, tcp_sccm, tcp_rscm, tcp_ann, tcp_msm, tcp_ybm,llepd,num_visits,
	letter_num,tcp_mswm,evalstatus, web_maint, web_hit, web_comment,
	sust_1, sust_2, sust_3, sust_4,
	sust_1_txt, sust_2_txt, sust_3_txt, sust_4_txt, month2, orgname, region.region as region
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
	<!--- <cfelseif form.area NEQ "ALL"> --->
	<cfelseif form.region NEQ "ALL">
		<cfif QAreas.recordcount NEQ 0 >
			(infra_monthly.userid in (#QuotedValueList(QAreas.userid)#)) and				
		<cfelse>
			infra_monthly.userid=' ' and
		</cfif>
	</cfif>
	infra_monthly.year2=#session.fy#
	and contact.partnertype=4
	and infra_monthly.month2 in (#quotedValueList(QMonlist.Mon)#)
	order by region.region, orgname, sp_rank
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
		 </cfoutput> </cfif>
	</cfcase>
	
	<cfcase value = 8>
	
		

<cfparam name="rptfy" default="2005">
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

        case 14
        when 0 then 'Not at all'
        when 3 then  'Partially'
        when 1 then  'Completely'
        else 'Don''t know' end as rb7,

        case 15
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
	from chcopp as a, collaborators as b, contact as c, area as ar, region as r
	where
	a.collab_id=b.seq
	and b.userid=c.userid
	and c.area=ar.area
	and ar.year2=2009
	and ar.year2=r.year2
	and ar.region-r.num
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
	and (
	(a.year2 > #form.styear# OR (a.year2=#form.styear# and q >= #form.stquarter#))
	and (a.year2 < #form.endyear# OR (a.year2=#form.endyear# and q <= #form.endquarter#))
	) and c.partnertype = 4
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
		
		</cfreport>
		 </cfoutput>
	</cfcase> 
	
	<cfcase value = 9>
	<cfoutput>
	
	
	
	


	<cfparam name="rptfy" default="2005">
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
months as m, area as ar, region as r,
security as s
where partner_id=c.userid
and a.year2=#session.fy#
and a.year2=ar.year2
and ar.year2=r.year2
and ar.region=r.num
and       c.partnertype = 4
and a.month2=m.mon
and a.year2=m.year2
and c.userid=s.userid
and s.area = ar.num
and
 <cfif isDefined("form.farea") and form.farea NEQ "ALL">u.strategy in (#form.farea#) and </cfif>  
            <cfif isDefined("form.partner") and form.partner NEQ "ALL">
                        (a.partner_id='#form.partner#' )
                        and
            <cfelseif form.area NEQ "ALL">
                        <cfif QAreas.recordcount NEQ 0 >
                                    (a.partner_id in (#QuotedValueList(QAreas.userid)#)
                                    ) and  
                        <cfelse>
						a.partner_id=' ' and
                        </cfif>
			<cfelseif form.region NEQ "ALL">
                        <cfif QAreas.recordcount NEQ 0 >
                                    (a.partner_id in (#QuotedValueList(QAreas.userid)#)
                                    ) and  
                        <cfelse>
						a.partner_id=' ' and
                        </cfif>
            </cfif> 
            a.month2 in #reReplace(monthrange, "~~", chr(39), "ALL")# 
order by 1,2,3,m.rank
</cfquery>

<cfelse>

<cfquery datasource="#Application.DataSource#" 
            password="#Application.db_password#" 
            username="#Application.db_username#" name="QAM">

select   <!--- ar.area, --->r.region as area,
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
and ar.year2=r.year2
and ar.region=r.num
and       c.partnertype = 4
and a.month2=m.mon
and a.year2=m.year2
and c.userid=s.userid
and s.area = ar.num
and

 <cfif isDefined("form.farea") and form.farea NEQ "ALL">u.strategy in (#form.farea#) and </cfif>  
            <cfif isDefined("form.partner") and form.partner NEQ "ALL">
                        (a.partner_id='#form.partner#' )
                        and
            <cfelseif form.area NEQ "ALL">
                        <cfif QAreas.recordcount NEQ 0 >
                                    (a.partner_id in (#QuotedValueList(QAreas.userid)#) 
                                    ) and   
                        <cfelse>
						a.partner_id=' ' and
                        </cfif>
			<cfelseif form.region NEQ "ALL">
                        <cfif QAreas.recordcount NEQ 0 >
                                    (a.partner_id in (#QuotedValueList(QAreas.userid)#) 
                                    ) and   
                        <cfelse>
						a.partner_id=' ' and
                        </cfif>
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

 <cfreport template="#rpttemp#" format = "#form.format#"  query="QAM"> 
	
<!--- 
<cfif session.fy LT 2007>
 	<cfreport template="./reports/areamgr_old.cfr" format = "#form.format#" query="QAM"> 
 <cfelse>
 	<cfreport template="./reports/areamgr.cfr" format = "#form.format#" query="QAM"> 
</cfif> --->		<!--- <cfreport template="./reports/AMHeader.cfr" format = "#form.format#"> --->
		
		
		<CFREPORTPARAM name=ReportName VALUE="PP">
		<CFREPORTPARAM name=Year2 VALUE="#rptfy#">
		<CFREPORTPARAM name=Area VALUE="#form.region#">
		<CFREPORTPARAM name=Objective VALUE="ALL">
		<CFREPORTPARAM name=FocusArea VALUE="ALL">
		<CFREPORTPARAM name=Strategy VALUE="ALL">
		<CFREPORTPARAM name=Prognum VALUE="ALL">
		<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">	
		 <CFREPORTPARAM name=Monthrange VALUE="#Monthrange#">
		 <!--- <CFREPORTPARAM name=StartMonth VALUE="1">
		 <CFREPORTPARAM name=EndMonth VALUE="1">		
		 <CFREPORTPARAM name=Monthrange VALUE="1">		 
		 <CFREPORTPARAM name=stYear VALUE="2005">
		 <CFREPORTPARAM name=StQuarter VALUE="1">
		 <CFREPORTPARAM name=endYear VALUE="2006">		 
		 <CFREPORTPARAM name=endQuarter VALUE="1"> --->
		 <CFREPORTPARAM name=modality VALUE="#rptmodality#">
		
		</cfreport>
		 </cfoutput>
	</cfcase>

<cfcase value = 10>

<cfparam name="rptfy" default="2005">
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
months as m, area as ar, region as r,
security as s
where i.userid=c.userid
and i.year2=#rptfy#
and i.year2=ar.year2
and i.month2=m.mon
and i.year2=m.year2
and c.userid=s.userid
and s.area = ar.num
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
and c.partnertype = 4
group by r.region,
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

<cfparam name="rptfy" default="2005">
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
	
select <!--- ar.area, ---> r.region as area,
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
and i.month2=m.mon and i.year2=m.year2
and i.userid=s.userid
and s.area = ar.num

and ar.year2=i.year2
and ar.year2=r.year2
and ar.region=r.num
and i.year2=#rptfy#
and m.rank=
(
select max(rank) from infra_monthly as ii, months as mm
where ii.month2=mm.mon and ii.year2 = mm.year2
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
	and
	<cfif session.rptmode EQ "main">
		c.partnertype != 4
	<cfelse>
		c.partnertype not in (1,2,3)
	</cfif>
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
		
		<!--- <CFREPORTPARAM name=Monthrange VALUE="#monthrange#">	 --->	
		 </cfreport>
		 </cfoutput>
	</cfcase> 





<cfcase value = 12>

<cfparam name="rptfy" default="2005">
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
and ar.year2=r.year2
and ar.region=r.num
and e.year2=#rptfy#
and e.userid=c.userid
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
	

UNION

select distinct <!--- ar.area, --->r.region as area,
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
and ar.year2=#rptfy#
and ar.year2=r.year2
and ar.region=r.num
and c.userid not in
(select distinct userid from evalM where year2=#rptfy#)
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
		<!--- <CFREPORTPARAM name=Monthrange VALUE="#monthrange#">	 --->	
		 </cfreport>
		 </cfoutput>
	</cfcase> 

<cfcase value = 13>

<cfparam name="rptfy" default="2005">
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
SELECT     u.goal, p.program, u.objective, o.abbr, c.orgname, <!--- ar.area, ---> r.region as area, 
u.activity, a.month2, CASE u.tcp_fun WHEN 1 THEN 'Yes' ELSE 'No' END AS tcpfun, 
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
         END, grp, intensecount, campcount, campCost, flightstart, flightend, a.campcounty
FROM         campaign AS a, PMcampchan AS ca, pmcamps AS s, useractivities AS u, program AS p, objectives AS o, contact AS c, months AS m, area AS ar, region as r
WHERE     u.userid = c.userid AND ar.num = c.area AND a.month2 = m.mon and a.year2 = m.year2 AND a.year2 = #rptfy# AND ca.year2 = a.year2 AND s.year2 = a.year2 AND 
                      a.campcat = ca.num AND a.campsource = s.num AND ar.year2 = a.year2 
					and ar.year2=r.year2 and ar.region=r.num
					AND a.year2 = u.year2 AND a.year2 = p.year2 AND a.year2 = o.year2 AND 
                      a.userid = u.userid AND a.activity = u.activity AND p.progNum = u.goal AND o.id = u.objective AND (u.del IS NULL OR
                      u.del != 'y') AND u.strategy = 2 and c.partnertype=4
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
		<cfparam name="form.Region" default="ALL">
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
<cfcase value = 14>

<cfparam name="rptfy" default="2005">
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
SELECT     u.goal, p.program, u.objective, o.abbr, c.orgname, <!--- ar.area --->r.region as area, 
u.activity, a.month2, CASE u.state WHEN 1 THEN 'Yes' ELSE 'No' END AS statewideinit, 
                      isNull(si.abbr,'') AS siabbr, ca.descrip AS campCat2, camptitle, s.descrip AS campSource, 
					campcat, campchannel,
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
         END, isNull(grp, 0) as grp, intensecount, campcount, isNull(campCost, 0) as campCost, 
                      flightstart, flightend, isNull(a.campcounty,0) as campcounty
FROM         campaign AS a, PMcampchan AS ca, pmcamps AS s, useractivities AS u 
LEFT JOIN state_initiatives si ON u.campname = si.num AND u.year2 = si.year2, 
					  program AS p, objectives AS o, contact AS c, months AS m, area AS ar, region as r
WHERE     u.userid = c.userid AND ar.num = c.area AND a.month2 = m.mon and a.year2 = m.year2 AND a.year2 = #rptfy# 
AND ca.year2 = a.year2 AND s.year2 = a.year2 AND 
 ar.year2=r.year2 and ar.region=r.num
                    AND  a.campcat = ca.num AND a.campsource = s.num AND ar.year2 = a.year2 
					  AND a.year2 = u.year2 AND a.year2 = p.year2 AND a.year2 = o.year2 AND 
                      a.userid = u.userid AND a.activity = u.activity AND p.progNum = u.goal 
					  AND o.id = u.objective AND (u.del IS NULL OR u.del != 'y') 
					AND u.strategy = 2 and c.partnertype=4
 
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
<!--- ar.area --->r.region,
c.orgname,
u.activity,
ca.descrip,
a.month2

</cfquery>

 
 <cfoutput>
	

		<cfreport template="./reports/details.cfr" format = "pdf" query="Qdetails">
		
		<!--- <CFREPORTPARAM name=StartMonth VALUE="#form.StMonth#">
		<CFREPORTPARAM name=EndMonth VALUE="#form.endmonth#"> --->
		<CFREPORTPARAM name=Year2 VALUE="#rptfy#">
		<CFREPORTPARAM name=Area VALUE="#form.region#">
		<CFREPORTPARAM name=Objective VALUE="#form.objective#">
		<CFREPORTPARAM name=FocusArea VALUE="2">
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

<cfparam name="rptfy" default="2005">
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
SELECT     <!--- ar.area --->r.region as area,orgname, sum(CASE WHEN abbr = 'Mag ads' THEN 1 ELSE 0 END) AS mag,
sum(CASE WHEN abbr = 'POP' THEN 1 ELSE 0 END) AS pop, sum(CASE WHEN abbr = 'TI sponsor' THEN 1 ELSE 0 END)
AS sponsor, sum(CASE WHEN abbr = 'TI promotion' THEN 1 ELSE 0 END) AS promo,
sum(CASE WHEN abbr = 'Movies' THEN 1 ELSE 0 END) AS movies, 
sum(CASE WHEN abbr != 'Movies' AND abbr != 'TI promotion' AND abbr != 'TI sponsor' AND abbr != 'Mag ads' 
AND abbr != 'POP' THEN 1 ELSE 0 END) AS other
FROM         dbo.userActivities u LEFT OUTER JOIN
                      dbo.State_initiatives si ON u.campName = si.num AND u.year2 = si.year2 INNER JOIN
                      govt a ON u.userid = a.userid AND u.year2 = a.year2 and a.activity=u.activity INNER JOIN
                      contact c ON u.userid = c.userid
inner join area ar on c.area = ar.num and u.year2=ar.year2
inner join region r on ar.year2=r.year2 and ar.region=r.num
WHERE     (si.asp = 1) AND impact_imp = 1 and u.strategy = 1 and orgname is not null
AND (u.del IS NULL OR u.del != 'y') and c.partnertype = 4
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
  AND u.year2=#rptfy#
group by orgname,<!--- ar.area --->r.region


union all

SELECT     <!--- ar.area --->r.region as area, orgname, sum(CASE WHEN abbr = 'Mag ads' THEN 1 ELSE 0 END) AS mag, sum(CASE WHEN abbr = 'POP' THEN 1
ELSE 0 END) AS pop, sum(CASE WHEN abbr = 'TI sponsor' THEN 1 ELSE 0 END) AS sponsor, sum(CASE WHEN 
abbr = 'TI promotion' THEN 1 ELSE 0 END) AS promo, sum(CASE WHEN abbr = 'Movies' THEN 1 ELSE 0 END) AS movies, 
sum(CASE WHEN abbr != 'Movies' AND abbr != 'TI promotion' AND abbr != 'TI sponsor' AND 
abbr != 'Mag ads' AND abbr != 'POP' THEN 1 ELSE 0 END) AS other
FROM         dbo.userActivities u LEFT OUTER JOIN
                      dbo.State_initiatives si ON u.campName = si.num AND u.year2 = si.year2 INNER JOIN
                      advoc a ON u.userid = a.userid AND u.year2 = a.year2 and a.activity=u.activity INNER JOIN
                      contact c ON u.userid = c.userid inner join area ar on c.area = ar.num and ar.year2=u.year2
					inner join region r on ar.year2=r.year2 and ar.region=r.num
					 
WHERE     (u.strategy IN (8,9)) AND (si.asp = 1) AND impact_imp = 1 and orgname is not null
AND (u.del IS NULL OR u.del != 'y') and c.partnertype = 4
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
AND u.year2=#rptfy#
group by orgname,<!--- ar.area --->r.region

order by orgname


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
		<!--- <CFREPORTPARAM name=Monthrange VALUE="#monthrange#">	 --->	
		 </cfreport>
		 </cfoutput>


<cfelse>
		 <cfquery datasource="#Application.DataSource#"  		 
	password="#Application.db_password#"  		
	username="#Application.db_username#" name="Qdetails">


SELECT     c.orgname, <!--- ar.area --->r.region as area, 
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
govt as a,
area as ar, region as r
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
and ar.year2=r.year2
and ar.region=r.num
and u.objective in ('2b','2c','scb', '2d', '2f', '4c','4g')
and orgname is not null
AND u.year2=#session.fy#
and c.partnertype = 4
<cfinclude template="report_filter.cfm">
group by c.orgname, <!--- ar.area --->r.region
UNION

SELECT     c.orgname, <!--- ar.area --->r.region as area, 
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
area as ar, region as r
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
and ar.year2=r.year2
and ar.region=r.num
and u.objective in ('2b','2c','scb', '2d', '2f', '4c','4g')
and orgname is not null
AND (u.del IS NULL OR u.del != 'y') and c.partnertype = 4
 AND u.year2=#session.fy#
<cfinclude template="report_filter.cfm">
group by c.orgname, <!--- ar.area ---> r.region

order by 2,1





</cfquery>
<cfoutput>



		<cfreport template="./reports/aspcomponent_new.cfr" format = "#form.format#"  query="QDetails">
		
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
	
<cfcase value = 16>

<cfparam name="rptfy" default="2005">
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

<cfquery datasource="#Application.DataSource#"  		 
	password="#Application.db_password#"  		
	username="#Application.db_username#" name="Qdetails">
SELECT    distinct <!--- ar.area --->r.region as area,orgname, u.objective,u.activity,CAST(u.activityname AS varchar(1000))as activityname,month2,revstart,revend,'Govt policy-maker ed.' as focus,
case levelChangeSought when 1 then 'local - town' when 2 then 'local - county'
when 3 then 'entire Partner catchment area' when 4 then 'state' when 5 then 'national'
when 6 then 'international' end as level,CAST(impact_imp_txt AS varchar(1000))as impact_imp_txt, m.rank, o.abbr
FROM         dbo.userActivities u LEFT OUTER JOIN
                      dbo.State_initiatives si ON u.campName = si.num AND u.year2 = si.year2 INNER JOIN
                      govt a ON u.userid = a.userid AND u.year2 = a.year2 AND u.activity=a.activity INNER JOIN
                      contact c ON u.userid = c.userid
left join area ar on c.area = ar.num and u.year2=ar.year2
inner join region r on  ar.year2=r.year2 and ar.region=r.num
inner join months m on a.month2=m.mon and a.year2 = m.year2
inner join objectives o on u.objective=o.id and o.year2=u.year2
WHERE     (si.asp = 1) AND impact_imp = 1 and u.strategy = 1 and orgname is not null
and ar.year2=u.year2 and c.partnertype=4
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
 AND u.year2=#rptfy#
union all

SELECT    distinct r.region as area,orgname, u.objective,u.activity,CAST(u.activityname AS varchar(1000))as 
activityname,month2,revstart,revend,'Govt policy-maker ed.' as focus,
case pollevel when 1 then 'local - town' when 2 then 'local - county'
when 3 then 'entire Partner catchment area' when 4 then 'state' when 5 then 'national'
when 6 then 'international' end as level,CAST(impact_imp_txt AS varchar(1000))as impact_imp_txt, m.rank, o.abbr
FROM         dbo.userActivities u LEFT OUTER JOIN
                      dbo.State_initiatives si ON u.campName = si.num AND u.year2 = si.year2 INNER JOIN
                      advoc a ON u.userid = a.userid AND u.year2 = a.year2 AND u.activity=a.activity
			 INNER JOIN
                      contact c ON u.userid = c.userid inner join area ar on c.area = ar.num and ar.year2=u.year2
					inner join region r on ar.year2=r.year2 and ar.region=r.num
					  inner join months m on a.month2=m.mon and a.year2 = m.year2
					  inner join objectives o on u.objective=o.id and o.year2=u.year2
WHERE     (u.strategy IN (8,9)) AND (si.asp = 1) AND impact_imp = 1 and orgname is not null
and ar.year2=u.year2 and c.partnertype=4

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
AND (u.del IS NULL OR u.del != 'y')
AND u.year2=#rptfy#
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
		<!--- <CFREPORTPARAM name=Monthrange VALUE="#monthrange#">	 --->	
		 </cfreport>
		 </cfoutput>
	</cfcase> 		
	
<!---	<cfcase value = 17><!--- Focus Area One --->

                        <cfparam name="rptfy" default="2005">
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
            u.userid, c.orgname, u.goal, <!--- ar.area --->r.region as area, u.activity, 
   CASE u.tcp_fun 
   WHEN 1 THEN 'Yes' ELSE 'No' 
   END AS tcpfun, 
   u.startdate, u.enddate, 
   isnull(pm_media, '0') as pm_media
FROM         contact c, useractivities u, area ar, region as r, strat_campaigntarget sc
WHERE     u.userid = c.userid AND ar.num = c.area AND (u.del != 'y' OR
                      u.del IS NULL) AND u.strategy = 2 and c.partnertype=4
					and ar.year2=u.year2
					and ar.year2=r.year2
					and ar.region=r.num
       and u.startdate >= '#form.StMonth#'
       and u.enddate <= '#form.EndMonth#'
	   and ql_ref = 1
<cfinclude template="report_filter.cfm">
order by u.startdate, <!--- ar.area --->r.region, c.orgname, u.activity
</cfquery>  
 

<cfset MonthRange = form.StMonth & ' - ' & form.endmonth>
                        <cfreport template="./reports/plannedquitline.cfr" query="Qdetails" format = "#form.format#">
 
                        <CFREPORTPARAM name=Year2 VALUE="2006">
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
			
			<cfcase value = 18><!--- Plannned Media --->
   
 						<cfparam name="session.fy" default="2005">
                        <cfparam name="form.Area" default="ALL">
		<cfparam name="form.Region" default="ALL">
                        <cfparam name="form.Objective" default="ALL">
                        <cfparam name="form.fArea" default="ALL">
                        <cfparam name="form.goal" default="ALL">
                        <cfparam name="form.partner" default="ALL">
                        <cfparam name="form.strategy" default="ALL"> 
						<cfset monthrange6=''>
						<cfloop query="Qmonlist">
							<Cfset monthrange6= monthrange6 &'''' & #mon# &''','> 
						</cfloop>	
						<Cfset monthrange6=monthrange6 & "'test'">
						<cfset monthrange7 =#valuelist(Qmonlist.mon_num)#>
						<Cfset monthrange8= ''>
						<cfloop query="Qmonlist" >
							<Cfset monthrange8= monthrange8 &',' & #mon# > 
						</cfloop>
	
	
	
	
						
<cfquery datasource="#Application.DataSource#"     
 password="#Application.db_password#"    
 username="#Application.db_username#" name="QSPP">
select n.bedscode as school, n.institutionname , co.orgname,
case  when n.bedscode like '%0000' then 1 else 0 end as distlvl, n.district
from collaborators as c, nysed_school as n, contact as co
where c.userid=co.userid and (c.school=n.bedscode or (c.school='999' and c.district=n.district))
 <cfif isDefined("partner") and partner NEQ "ALL">
 
 <cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qcollab_district">
	select distinct district
	from collaborators 
	where userid='#partner#'
	<!--- and year2=#session.fy# --->
	union
	select
	'0'   from collaborators as c
	where   (c.del is null or c.del !=1)
	order by 1
</cfquery>

 <cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qcollab_school">
	select distinct school
	from collaborators as c
	where userid='#partner#'
	  and (c.del is null or c.del !=1)
	<!--- and year2=#session.fy# --->
	order by 1
</cfquery>


<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qschool">
	select bedscode,institutionName, district
	from nysed_school
	where bedscode in (#quotedvaluelist(Qcollab_school.school)#)
	union
	select '0', '', ''
	from nysed_school
	order by 2
</cfquery>


 <cfquery datasource="#Application.DataSource#"     
 password="#Application.db_password#"    
 username="#Application.db_username#" name="QpartnerSchool">
	select s.bedscode
	from nysed_school as s, nysed_district as d
	where bedscode in (#quotedvaluelist(Qcollab_school.school)#)
	and d.district_id=s.district
	union
	select s.bedscode
	from nysed_school as s, nysed_district as d
	where 
	(
	(district in (#quotedvaluelist(Qschool.district)#) and bedscode like '%0000')
	or
	(district in (#quotedvaluelist(Qcollab_district.district)#)and bedscode like '%0000')
	)
	and d.district_id=s.district
	
	
 </cfquery>
 
 and n.bedscode in (#quotedvaluelist(QpartnerSchool.bedscode)#)
 
 
<cfelseif (isDefined("area") and area NEQ "ALL") or (isDefined("region") and region NEQ "ALL")>
  
<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qpartnerarea">
	
	<cfif (isDefined("area") and area NEQ "ALL")>
	select userid 
	from contact 
	where area=#area#
		
	<cfelse>
	select userid 
	from contact c, area a, region r 
	where c.area=a.num
	and a.year2=2009
	and a.year2=r.year2
	and a.region=r.num	
	and r.num=#region#	
	</cfif>
	and partnertype=4
</cfquery>

 <cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qcollab_district">
	select distinct district
	from collaborators
	where userid in (#quotedvaluelist(Qpartnerarea.userid)#)
	<!--- and year2=#session.fy# --->
	order by 1
</cfquery>

 <cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qcollab_school">
	select distinct school
	from collaborators
	where userid in (#quotedvaluelist(Qpartnerarea.userid)#)
	<!--- and year2=#session.fy# --->
	order by 1
</cfquery>
<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qschool">
	select bedscode,institutionName, district
	from nysed_school
	where bedscode in (#quotedvaluelist(Qcollab_school.school)#)
	order by 2
</cfquery> 
	
	
	
 <cfquery datasource="#Application.DataSource#"     
 password="#Application.db_password#"    
 username="#Application.db_username#" name="QpartnerSchool">
	select s.bedscode
	from nysed_school as s, nysed_district as d
	where bedscode in (#quotedvaluelist(Qcollab_school.school)#)
	and d.district_id=s.district
	union
	select s.bedscode
	from nysed_school as s, nysed_district as d
	where 
	(
	(district in (#quotedvaluelist(Qschool.district)#) and bedscode like '%0000')
	or
	(district in (#quotedvaluelist(Qcollab_district.district)#)and bedscode like '%0000')
	)
	and d.district_id=s.district
	
 </cfquery>
 
 and n.bedscode in (#quotedvaluelist(QpartnerSchool.bedscode)#)
 
 
 </cfif>
 and n.bedscode in
(select distinct school_acc from sp_acc, months where sp_acc.year2=#session.fy# and month2=mon and mon_num in (#monthrange7#) and months.year2=2010
union
select distinct school_acp from sp_acp, months where sp_acp.year2=#session.fy# and month2=mon and mon_num in (#monthrange7#) and months.year2=2010
union
select distinct school_spd from sp_spd, months where sp_spd.year2=#session.fy# and month2=mon and mon_num in (#monthrange7#) and months.year2=2010
union
select distinct school_spp from sp_spp, months where sp_spp.year2=#session.fy# and month2=mon and mon_num in (#monthrange7#) and months.year2=2010
union
select distinct school_tard from sp_tard, months where sp_tard.year2=#session.fy# and month2=mon and mon_num in (#monthrange7#) and months.year2=2010
union
select distinct school_tarp from sp_tarp, months where sp_tarp.year2=#session.fy# and month2=mon and mon_num in (#monthrange7#) and months.year2=2010
union
select distinct school_taid from sp_taid, months where sp_taid.year2=#session.fy# and month2=mon and mon_num in (#monthrange7#) and months.year2=2010
union
select distinct school_taip from sp_taip, months where sp_taip.year2=#session.fy# and month2=mon and mon_num in (#monthrange7#) and months.year2=2010
union
select distinct school_stip from sp_stip, months where sp_stip.year2=#session.fy# and month2=mon and mon_num in (#monthrange7#) and months.year2=2010
)
order by 3, 5, 4 desc, 2
</cfquery>
 
 
 
 

 
<!--- <cfquery datasource="#Application.DataSource#"     
 password="#Application.db_password#"    
 username="#Application.db_username#" name="QSPMon">
select mon_num as monthnum from months
where mon in (#monthrange8#)
</cfquery>  --->
<cfoutput>
<!--- #session.fy#<br>
#monthrange7#<br>
#form.area#<br>
#form.objective#<br>
#form.farea#"<br>
"#form.strategy#"<br>
"#form.goal#"<br>
#form.partner#"<br>
"progress"<br>
"#Monthrange3#"<br>
"#rptmodality#"<br>
<cfabort>--->

 
                        <cfreport template="./reports/SPMSR.cfr" query="QSPP" format = "#form.format#">
 
                    <cfreportparam name="year2" value=#session.fy#>
					<!--- <cfreportparam name="month2" value=#valueList(QSPMon.monthnum)#> --->
					<cfreportparam name="month2" value=#monthrange7#>

                        <CFREPORTPARAM name=Area VALUE=#form.region#>
                        <CFREPORTPARAM name=Objective VALUE=#form.objective#>
                        <CFREPORTPARAM name=FocusArea VALUE="#form.farea#">
                        <CFREPORTPARAM name=Strategy VALUE="#form.strategy#">
                        <CFREPORTPARAM name=Prognum VALUE="#form.goal#">
                        <CFREPORTPARAM name=PartnerName VALUE="#form.partner#">
						<CFREPORTPARAM name=ReportName VALUE="progress">
						<CFREPORTPARAM name=Monthrange VALUE="#Monthrange3#">
						<CFREPORTPARAM name=modality VALUE="#rptmodality#">

                        </cfreport>
 </cfoutput>
            </cfcase>
			
			<cfcase value = 22>
			
                        <cfparam name="form.Area" default="ALL">
						<cfparam name="form.Region" default="ALL">	
				
				<!--- Joint Partne sTRATEGY --->
						 <cfquery datasource="#Application.DataSource#"     
 password="#Application.db_password#"    
 username="#Application.db_username#" name="Qdetails">
 						select u.activity, cast(u.activityname as varchar(8000)) as activityname,
						c.orgname, f.strategy as focusarea, 'Active' as status
						from useractivities as u,
						contact as c, area as ar, region as r,
						shareduseractivities as s,
						strategy as f
						where
						u.activity=s.activity
						and u.year2=s.year2
						and s.userid=c.userid
						and f.year2=u.year2
						
						and ar.year2=u.year2
						and ar.year2=r.year2
						and ar.region=r.num
						and c.area=ar.num
						and u.strategy=f.strategy_num
						and u.year2 =#session.fy#
						 <cfif form.area NEQ "ALL">
						and c.area ='#form.area#'
						</cfif>	
						<cfif form.region NEQ "ALL">
						and r.num ='#form.region#'
						</cfif>						
						and c.partnertype = 4
						
</cfquery>
 <cfif form.area NEQ "ALL">
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
			
			
			
			
			
			
<cfcase value = 30><!--- SP advocacy Progress Report --->
   
 						<cfparam name="session.fy" default="2005">
                        <cfparam name="form.Area" default="ALL">
						<cfparam name="form.Region" default="ALL">
                        <cfparam name="form.Objective" default="ALL">
                        <cfparam name="form.fArea" default="ALL">
                        <cfparam name="form.goal" default="ALL">
                        <cfparam name="form.partner" default="ALL">
                        <cfparam name="form.strategy" default="ALL"> 
						<!--- <cfset monthrange6=''>
						<cfloop query="Qmonlist">
							<Cfset monthrange6= monthrange6 &'''' & #mon# &''','> 
						</cfloop>	
						<Cfset monthrange6=monthrange6 & "'test'"> --->
						<cfset monthrange7 =#valuelist(Qmonlist.mon_num)#>
						
						
<cfquery datasource="#Application.DataSource#"     
 password="#Application.db_password#"    
 username="#Application.db_username#" name="QSPP">
select n.bedscode as school, n.institutionname , co.orgname, <!--- ar.area --->r.region as area,
case  when n.bedscode like '%0000' then 1 else 0 end as distlvl
from collaborators as c, nysed_school as n, contact as co, area as ar, region as r
where c.userid=co.userid and (c.school=n.bedscode or (c.school='999' and c.district=n.district)) 
and co.area = ar.num
and ar.year2=r.year2
and ar.region=r.num
  and (c.del is null or c.del !=1)
 <cfif isDefined("partner") and partner NEQ "ALL">
 
 <cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qcollab_district">
	select distinct district
	from collaborators
	where userid='#partner#'
	<!--- and year2=#session.fy# --->
	union
	select '0000'
	from collaborators as c
	  where (c.del is null or c.del !=1)
	order by 1
</cfquery>

 <cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qcollab_school">
	select distinct school
	from collaborators
	where userid='#partner#'
	<!--- and year2=#session.fy# --->
	union 
	select '0'
	from collaborators as c
	where   (c.del is null or c.del !=1)
	order by 1
</cfquery>

<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qschool">
	select bedscode,institutionName, district
	from nysed_school
	where bedscode in (#quotedvaluelist(Qcollab_school.school)#)
	union
	select '0000','','0000'
	from nysed_school
	order by 2
</cfquery>



 <cfquery datasource="#Application.DataSource#"     
 password="#Application.db_password#"    
 username="#Application.db_username#" name="QpartnerSchool">
	select s.bedscode
	from nysed_school as s, nysed_district as d
	where bedscode in (#quotedvaluelist(Qcollab_school.school)#)
	and d.district_id=s.district
	union
	select s.bedscode
	from nysed_school as s, nysed_district as d
	where 
	(
	(district in (#quotedvaluelist(Qschool.district)#) and bedscode like '%0000')
	or
	(district in (#quotedvaluelist(Qcollab_district.district)#)and bedscode like '%0000')
	)
	and d.district_id=s.district
	union
	select '0000' from nysed_school
	
	
 </cfquery>
 
 and n.bedscode in (#quotedvaluelist(QpartnerSchool.bedscode)#)
 
 
 

<cfelseif (isDefined("form.area") and form.area NEQ "ALL") or (isDefined("form.region") and form.region NEQ "ALL")>
  <cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qpartnerarea">
	<cfif (isDefined("area") and area NEQ "ALL")>
	select userid from contact 
	where area=#form.area#
	and partnertype=4	
	<cfelse>
	select userid from contact c, area a, region r 
	where c.area=a.num
	and a.year2=2009
	and a.year2=r.year2
	and a.region=r.num
	and r.num=#form.region#
	and partnertype=4	
	</cfif>
</cfquery>

 <cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qcollab_district">
	select distinct district
	from collaborators
	where userid in (#quotedvaluelist(Qpartnerarea.userid)#)
	<!--- and year2=#session.fy# --->
	union
	select '0000' from collaborators as c
	where   (c.del is null or c.del !=1)
	order by 1
</cfquery>

 <cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qcollab_school">
	select distinct school
	from collaborators
	where userid in (#quotedvaluelist(Qpartnerarea.userid)#)
	<!--- and year2=#session.fy# --->
	union
	select '0000' from collaborators as c
	where   (c.del is null or c.del !=1)
	order by 1
</cfquery>
<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qschool">
	select bedscode,institutionName, district
	from nysed_school
	where bedscode in (#quotedvaluelist(Qcollab_school.school)#)
	union
	select '0000', '', '0000' from nysed_school
	order by 2
</cfquery> 
 <cfquery datasource="#Application.DataSource#"     
 password="#Application.db_password#"    
 username="#Application.db_username#" name="QpartnerSchool">
	select s.bedscode
	from nysed_school as s, nysed_district as d
	where bedscode in (#quotedvaluelist(Qcollab_school.school)#)
	and d.district_id=s.district
	union
	select s.bedscode
	from nysed_school as s, nysed_district as d
	where 
	(
	(district in (#quotedvaluelist(Qschool.district)#) and bedscode like '%0000')
	or
	(district in (#quotedvaluelist(Qcollab_district.district)#)and bedscode like '%0000')
	)
	and d.district_id=s.district
	
	
 </cfquery>
 
 and n.bedscode in (#quotedvaluelist(QpartnerSchool.bedscode)#)
 
 
 </cfif>
 and n.bedscode in
(
select distinct school_acp from sp_acp, months where sp_acp.year2=#session.fy# and month2=mon and mon_num in (#monthrange7#) and sp_acp.year2 = months.year2
union
select distinct school_spp from sp_spp, months where sp_spp.year2=#session.fy# and month2=mon and mon_num in (#monthrange7#) and sp_spp.year2 = months.year2
union
select distinct school_tarp from sp_tarp, months where sp_tarp.year2=#session.fy# and month2=mon and mon_num in (#monthrange7#) and sp_tarp.year2 = months.year2
union
select distinct school_taip from sp_taip, months where sp_taip.year2=#session.fy# and month2=mon and mon_num in (#monthrange7#) and sp_taip.year2 = months.year2
union
select '0000' from sp_taip)
<!--- order by 4,3,2 --->
order by 4,3,n.district,5, 2
 </cfquery>
 
 
<!--- <cfquery datasource="#Application.DataSource#"     
 password="#Application.db_password#"    
 username="#Application.db_username#" name="QSPMon">
select monthnum from months
where mon in (#monthrange4#)
</cfquery> --->
                        <cfreport template="./reports/SP_APS.cfr" query="QSPP" format = "#form.format#">
 
                    <cfreportparam name="year2" value=#session.fy#>
					<!--- <cfreportparam name="month2" value=#valueList(QSPMon.monthnum)#> --->
					<cfreportparam name="month2" value=#monthrange7#>
                        <CFREPORTPARAM name=Area VALUE=#form.region#>
                        <CFREPORTPARAM name=Objective VALUE=#form.objective#>
                        <CFREPORTPARAM name=FocusArea VALUE="11">
                        <CFREPORTPARAM name=Strategy VALUE="#form.strategy#">
                        <CFREPORTPARAM name=Prognum VALUE="#form.goal#">
                        <CFREPORTPARAM name=PartnerName VALUE="#form.partner#">
						<CFREPORTPARAM name=ReportName VALUE="progress">
						<CFREPORTPARAM name=Monthrange VALUE="#Monthrange6#">
						<CFREPORTPARAM name=modality VALUE="#rptmodality#">

                        </cfreport>
 
</cfcase>

<cfcase value="31">
						<cfparam name="session.fy" default="2005">
                        <cfparam name="form.Area" default="ALL">
		<cfparam name="form.Region" default="ALL">
                        <cfparam name="form.Objective" default="ALL">
                        <cfparam name="form.fArea" default="ALL">
                        <cfparam name="form.goal" default="ALL">
                        <cfparam name="form.partner" default="ALL">
                        <cfparam name="form.strategy" default="ALL"> 
						<cfset monthrange6=''>
						<cfloop query="Qmonlist">
							<Cfset monthrange6= monthrange6 &'''' & #mon# &''','> 
						</cfloop>	
						<Cfset monthrange6=monthrange6 & "'test'">
						<cfset monthrange7 =#valuelist(Qmonlist.mon_num)#>

<CFSET SUBFILTER = "">

<CFIF  isDefined("form.partner") and form.partner NEQ "ALL">
	
		<CFSET SUBFILTER = "and s.userid='#form.partner#'">
		
<cfelseif isDefined("form.area") and form.area NEQ "ALL">
	<cfquery datasource="#Application.DataSource#"     
 password="#Application.db_password#"    
 username="#Application.db_username#" name="QpartnerbyArea">
 select userid from contact where area = #form.area#
 </cfquery>
	<CFSET SUBFILTER = "and s.userid in (#qUOTEDValueList(QpartnerbyArea.userid)#)">


<cfelseif isDefined("form.region") and form.region NEQ "ALL">
	<cfquery datasource="#Application.DataSource#"     
 password="#Application.db_password#"    
 username="#Application.db_username#" name="QpartnerbyRegion">
 select userid from contact as c, area as ar, region as r 
where c.area=ar.num
and ar.region=r.num
and ar.year2=2009
and ar.year2=r.year2
and r.num = #form.region#
 </cfquery>
	<CFSET SUBFILTER = "and s.userid in (#qUOTEDValueList(QpartnerbyRegion.userid)#)">

</cfif>

<cfquery datasource="#Application.DataSource#"     
 password="#Application.db_password#"    
 username="#Application.db_username#" name="QbySD">
select distinct
ns.InstitutionName, nd.district_name, 
1 as AC, 0 as SP, 0 as TADevelopment, 0 as TAimpl,s.month2, sp_rank, co.orgname,
case  when ns.bedscode like '%0000' then 1 else 0 end as distlvl
from
months as m,sp_acc  s
left outer join nysed_school  ns on ns.bedscode=s.school_acc
left outer join nysed_district  nd on nd.district_id=left(s.school_acc,6)
inner join contact co on s.userid = co.userid
where s.month2=m.mon and s.year2 = m.year2
#preserveSingleQuotes(SUBFILTER)#
and s.year2=<cfqueryPARAM cfsqltype="cf_sql_integer" value="#session.fy#">
and s.month2 in ('#valuelist(Qmonlist.mon,"','")#')
and (ns.institutionName is not null or nd.district_name is not null)
UNION
select distinct
ns.InstitutionName, nd.district_name,
1, 0, 0, 0,s.month2, sp_rank, co.orgname,
case  when ns.bedscode like '%0000' then 1 else 0 end as distlvl
from
months as m, sp_acp  s
left outer join nysed_school  ns on ns.bedscode=s.school_acp
left outer join nysed_district  nd on nd.district_id=left(s.school_acp,6)
inner join contact co on s.userid = co.userid
where s.month2=m.mon and s.year2=m.year2
#preserveSingleQuotes(SUBFILTER)#
and s.year2=<cfqueryPARAM cfsqltype="cf_sql_integer" value="#session.fy#">
and s.month2 in ('#valuelist(Qmonlist.mon,"','")#')
and (ns.institutionName is not null or nd.district_name is not null)


UNION
select distinct
ns.InstitutionName, nd.district_name,
0, 1, 0, 0,s.month2, sp_rank, co.orgname,
case  when ns.bedscode like '%0000' then 1 else 0 end as distlvl
from
months as m, sp_taid  s
left outer join nysed_school  ns on ns.bedscode=s.school_taid
left outer join nysed_district  nd on nd.district_id=left(s.school_taid,6)
inner join contact co on s.userid=co.userid
where s.month2=m.mon 
#preserveSingleQuotes(SUBFILTER)#
and s.year2=<cfqueryPARAM cfsqltype="cf_sql_integer" value="#session.fy#">
and s.month2 in ('#valuelist(Qmonlist.mon,"','")#')
and (ns.institutionName is not null or nd.district_name is not null)
UNION
select distinct
ns.InstitutionName, nd.district_name,
0, 1, 0, 0,s.month2, sp_rank, co.orgname,
case  when ns.bedscode like '%0000' then 1 else 0 end as distlvl
from
months as m, sp_taip  s
left outer join nysed_school  ns on ns.bedscode=s.school_taip
left outer join nysed_district  nd on nd.district_id=left(s.school_taip,6)
inner join contact co on s.userid=co.userid
where  s.month2=m.mon and s.year2=m.year2
#preserveSingleQuotes(SUBFILTER)#
and s.year2=<cfqueryPARAM cfsqltype="cf_sql_integer" value="#session.fy#">
and s.month2 in ('#valuelist(Qmonlist.mon,"','")#')
and (ns.institutionName is not null or nd.district_name is not null)

UNION



select distinct
ns.InstitutionName, nd.district_name,
0, 0, 1, 0,s.month2, sp_rank,co.orgname,
case  when ns.bedscode like '%0000' then 1 else 0 end as distlvl
from
months as m, sp_tard  s
left outer join nysed_school  ns on ns.bedscode=s.school_tard
left outer join nysed_district  nd on nd.district_id=left(s.school_tard,6)
inner join contact co on s.userid=co.userid
where  s.month2=m.mon 
#preserveSingleQuotes(SUBFILTER)#
and s.year2=<cfqueryPARAM cfsqltype="cf_sql_integer" value="#session.fy#">
and s.month2 in ('#valuelist(Qmonlist.mon,"','")#')
and (ns.institutionName is not null or nd.district_name is not null)
UNION
select distinct
ns.InstitutionName, nd.district_name,
0, 0, 1, 0,s.month2, sp_rank,co.orgname,
case  when ns.bedscode like '%0000' then 1 else 0 end as distlvl
from
months as m, sp_tarp  s
left outer join nysed_school  ns on ns.bedscode=s.school_tarp
left outer join nysed_district  nd on nd.district_id=left(s.school_tarp,6)
inner join contact co on s.userid = co.userid
where  s.month2=m.mon 
#preserveSingleQuotes(SUBFILTER)#
and s.year2=<cfqueryPARAM cfsqltype="cf_sql_integer" value="#session.fy#">
and s.month2 in ('#valuelist(Qmonlist.mon,"','")#')
and (ns.institutionName is not null or nd.district_name is not null)

UNION


select distinct
ns.InstitutionName, nd.district_name,
0, 0, 0, 1,s.month2, sp_rank,co.orgname,
case  when ns.bedscode like '%0000' then 1 else 0 end as distlvl
from
months as m, sp_spd  s
left outer join nysed_school  ns on ns.bedscode=s.school_spd
left outer join nysed_district  nd on nd.district_id=left(s.school_spd,6)
inner join contact co on s.userid=co.userid
where  s.month2=m.mon 
#preserveSingleQuotes(SUBFILTER)#
and s.year2=<cfqueryPARAM cfsqltype="cf_sql_integer" value="#session.fy#">
and s.month2 in ('#valuelist(Qmonlist.mon,"','")#')
and (ns.institutionName is not null or nd.district_name is not null)
UNION
select distinct
ns.InstitutionName, nd.district_name,
0, 0, 0, 1,s.month2 , sp_rank,co.orgname,
case  when ns.bedscode like '%0000' then 1 else 0 end as distlvl
from
months as m, sp_spp  s
left outer join nysed_school  ns on ns.bedscode=s.school_spp
left outer join nysed_district  nd on nd.district_id=left(s.school_spp,6)
inner join contact co on s.userid=co.userid
where  s.month2=m.mon and s.year2 = s.year2
#preserveSingleQuotes(SUBFILTER)#
and s.year2=<cfqueryPARAM cfsqltype="cf_sql_integer" value="#session.fy#">
and s.month2 in ('#valuelist(Qmonlist.mon,"','")#')
and (ns.institutionName is not null or nd.district_name is not null)
<!--- order by co.orgname,1,2,8 --->
order by co.orgname,2,10 desc, 1,8

</cfquery>

						<cfreport template="./reports/monthlyactbysd.cfr" QUERY="QbySD" format = "#form.format#">
 
                  		  <cfreportparam name="year2" value=#session.fy#>
						<!--- <cfreportparam name="month2" value=#valueList(QSPMon.monthnum)#> --->
						<cfreportparam name="month2" value=#monthrange7#>
                        <CFREPORTPARAM name=Area VALUE=#form.region#>
                        <CFREPORTPARAM name=Objective VALUE=#form.objective#>
                        <CFREPORTPARAM name=FocusArea VALUE="#form.farea#">
                        <CFREPORTPARAM name=Strategy VALUE="#form.strategy#">
                        <CFREPORTPARAM name=Prognum VALUE="#form.goal#">
                        <CFREPORTPARAM name=PartnerName VALUE="#form.partner#">
						<CFREPORTPARAM name=ReportName VALUE="progress">
						<CFREPORTPARAM name=Monthrange VALUE="#valuelist(Qmonlist.mon)#">
							 
		 				<CFREPORTPARAM name=stYear VALUE="1">
						<CFREPORTPARAM name=StQuarter VALUE="1">
						<CFREPORTPARAM name=endYear VALUE="1">		 
						<CFREPORTPARAM name=endQuarter VALUE="1">

                        </cfreport>
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
and c.partnertype =4
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
and c.partnertype =4
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
and c.partnertype =4
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
and c.partnertype =4
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
and c.partnertype = 4
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
and c.partnertype=4
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
and c.partnertype =4
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
<cfcase value = 32>

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
	username="#Application.db_username#" name="SPQP">
	select 
s.seq, cast(s.q as varchar) as queue, case s.year2 when 1904 then 2006 else s.year2 end as year, s.sname, isNull(ns.InstitutionName,nd.district_name) as InstitutionName, nd.district_name,
	case s.tframe when 1 then 'Baseline' when 2 then  'Update' else '' end as tframe,
	case s.liaison when 1 then 'Yes' when 0 then 'No' else '' end as liason,	
	case s.committee 
	when 1 then 'Yes, a district-level committee is fully developed'
	when 2 then 'Yes, a school-level committee is fully developed'
	when 3 then 'Yes, district-level committee development is in progress'
	when 4 then 'Yes, school-level committee development is in progress'
	when 0 then 'No' else '' end as committee ,
	isnull(s.commmbr,'999') as commmbr,
	isnull(s.othercommmbr,'999') as othercommmbr,
	isnull(s.wpolicy, '999') as wpolicy,	
	rtrim(isnull(s.components,'999')) as components,	
	rtrim(isnull(s.other_components,'999')) as other_components,
	case s.sbapproved when 1 then 'Yes' when 0 then 'No' when 2 then 'Don''t Know' else '' end as approved,
	ltrim(s.addcomments) as addcomments,s.year2
        from 
	sp_qpp  s 
left outer join nysed_school  ns on ns.bedscode=s.sname 
left outer join nysed_district  nd on nd.district_id=left(s.sname,6)
left outer join contact c on s.userid = c.userid
left outer join area ar on s.year2=ar.year2 and c.area=ar.num
left outer join region r on ar.year2=r.year2 and ar.region=r.num
where 1=1
<cfif form.area NEQ 'All' and form.partner EQ 'All'>
	and c.area=#form.area#
	</cfif>
	<cfif form.region NEQ 'All' and form.partner EQ 'All'>
	and r.num=#form.region#
	</cfif>
	<cfif form.partner NEQ 'All'>
	and c.userid = '#form.partner#'
	</cfif>
	and (
	(s.year2 > #form.styear# OR (s.year2=#form.styear# and q >= #form.stquarter#))
	and (s.year2 < #form.endyear# OR (s.year2=#form.endyear# and q <= #form.endquarter#))
	)

 and c.partnertype = 4
	
</cfquery>

<cfoutput>
	<cfreport template="./reports/SPQtrlyPolicy.cfr" format = "#form.format#" query="SPQP">
		
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
<cfcase value = 33>

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
	username="#Application.db_username#" name="SPOD">
select 

            q, SP_QOD.year2, sname, ns.InstitutionName,

            dateob,

            case tframe

when  1 then  'Baseline'

when 2 then '3 month follow up'

when 3 then '12 month follow up'

when 4 then '24 month follow up'

when 5 then 'Other' end as tframe,

case post_main 
when 1 then 'Yes'
when 0 then 'No'
end as post_main, 
case post_main_bld 
when 1 then 'Yes'
when 0 then 'No'
end as post_main_bld,case post_other
when 1 then 'Yes'
when 0 then 'No'
end as post_other,

            case post_athletic when 1 then 'Yes' when 0 then 'No' when 2 then 'NA' end as post_athletic,

            tu_evid,

            isnull(evidobr,'999') as evidobr,

            isnull(evidother, '999') as evidother,

            sp_qod.seq, 
case  when ns.bedscode like '%0000' then 1 else 0 end as distlvl, ns.district

            from SP_QOD 
            left outer join nysed_school  ns on ns.bedscode=sp_qod.sname
      left outer join contact c on sp_qod.userid = c.userid  
	left outer join area ar on sp_qod.year2=ar.year2 and c.area=ar.num  and SP_QOD.year2=ar.year2
	left outer join region r on ar.year2=r.year2 and ar.region=r.num   
where 1=1
<cfif form.area NEQ 'All' and form.partner EQ 'All'>
	and c.area=#form.area#
	</cfif>
	<cfif form.region NEQ 'All' and form.partner EQ 'All'>
	and r.num=#form.region#
	</cfif>
	<cfif form.partner NEQ 'All'>
	and c.userid = '#form.partner#'
	</cfif>
	
	and (
	(sp_qod.year2 > #form.styear# OR (sp_qod.year2=#form.styear# and q >= #form.stquarter#))
	and (sp_qod.year2 < #form.endyear# OR (sp_qod.year2=#form.endyear# and q <= #form.endquarter#))
	)

 and c.partnertype = 4
 order by district, distlvl desc, institutionname
</cfquery>
<cfoutput>
	<cfif session.fy GTE 2008>
		<cfset rpttmpl="./reports/SPObservB.cfr">
	<Cfelse>
		<cfset rpttmpl="./reports/SPObserv.cfr">
	</cfif>
		
	<cfreport template="#rpttmpl#" format = "#form.format#" query="SPOD">
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
<cfcase value = 34>

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
	username="#Application.db_username#" name="SPOA">
SELECT     dbo.SP_qod.q, c.orgName, <!--- a.area --->r.region as area, dbo.SP_qod.year2, dbo.SP_qod.userid, 
COUNT(*) AS qcount
FROM         dbo.SP_qod LEFT OUTER JOIN
                      dbo.contact c ON dbo.SP_qod.userid = c.userid LEFT OUTER JOIN
                      dbo.Area a ON c.area = a.num 
					left outer join region r on a.year2=r.year2 and a.region=r.num

GROUP BY dbo.SP_qod.q, dbo.SP_qod.year2, dbo.SP_qod.userid, 
a.year2, c.orgName, 
r.region, c.partnertype , c.userid, r.num
HAVING      (1 = 1) 

and (
	(dbo.SP_qod.year2 > #form.styear# OR (dbo.SP_qod.year2=#form.styear# and dbo.SP_qod.q >= #form.stquarter#))
	and (dbo.SP_qod.year2 < #form.endyear# OR (dbo.SP_qod.year2=#form.endyear# and dbo.SP_qod.q <= #form.endquarter#))
	)


AND (a.year2 = dbo.SP_qod.year2)
	<cfif form.partner NEQ 'All'>
	and c.userid = '#form.partner#'
	<!--- <cfelseif form.area NEQ 'All' and form.partner EQ 'All'>
	and  a.area=#form.area#	 --->	
	<cfelseif form.region NEQ 'All' and form.partner EQ 'All'>
	and  r.num=#form.region#	
	</cfif>
	and c.partnertype = 4 AND (r.num IS not NULL)
ORDER BY r.region,c.orgname, q
</cfquery>




<cfoutput>


	<cfreport template="./reports/SPOA_b.cfr" format = "#form.format#" query="SPOA">
		
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
<cfcase value = 35>

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
	username="#Application.db_username#" name="SPIE">
select 
distinct
      q.q, c.orgname, n.institutionname, sname,

      case tframe when 1 then 'Baseline' when 2 then 'Update' end as tframe,

      sccomm,
      isnull(commpol,'999') as commpol,
      isnull(othercommpol,'999') as othercommpol,

      viscomm,
      isnull(commpolv,'999') as commpolv,
      isnull(othercommpolv,'999') as othercommpolv,
   
      mediacomm,
      isnull(mediacomm_method,'999') as mediacomm_method,
      isnull(othermediacomm,'999') as othermediacomm,
   
           case extent_imp when 0 then 'Not at all' when 1 then 'Partially' when 2 then 'Fully' when 3 then 'Dont Know' end as extentImp ,

      case extent_enf when 0 then 'Not at all' when 1 then 'Partially' when 2 then 'Fully' when 3 then 'Dont Know' end as extentEnf, 
case  when n.bedscode like '%0000' then 1 else 0 end as distlvl, n.district

      from SP_QPP2 as q, nysed_school as n, contact as c, area as a , region as r

      where 
q.sname=n.bedscode

and c.userid=q.userid
and c.area = a.num
and q.year2=a.year2
and a.year2=r.year2
and a.region=r.num

and 1=1

	<cfif form.partner NEQ 'All'>
	and c.userid = '#form.partner#'
	<cfelseif form.area NEQ 'All' and form.partner EQ 'All'>
	and c.area=#form.area#
	<cfelseif form.region NEQ 'All' and form.partner EQ 'All'>
	and r.num=#form.region#
	</cfif>
	and (
	(q.year2 > #form.styear# OR (q.year2=#form.styear# and q.q >= #form.stquarter#))
	and (q.year2 < #form.endyear# OR (q.year2=#form.endyear# and q.q <= #form.endquarter#))
	)

	
 and c.partnertype = 4 AND (a.area IS not NULL)
order by district, distlvl, institutionname
</cfquery>



<cfoutput>
	<cfreport template="./reports/SPIE_b.cfr" format = "#form.format#" query="SPIE">
		
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
 <cfcase value = 36>

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
	username="#Application.db_username#" name="SSS">
SELECT    <!--- a.area --->r.region as area, c.orgname, dbo.SP_qss.userid, dbo.SP_qss.q, dbo.SP_qss.year2, sum(dbo.SP_qss.num_surveys) as num_surveys
FROM         dbo.SP_qss INNER JOIN
                      dbo.contact c ON dbo.SP_qss.userid = c.userid
                      LEFT OUTER JOIN
   dbo.area a on c.area = a.num and dbo.sp_qss.year2 = a.year2
left outer join region as r on a.year2=r.year2 and a.region=r.num
WHERE     (c.partnerType = 4) 

and 1=1

	<cfif form.partner NEQ 'All'>
	and c.userid = '#form.partner#'
	<cfelseif form.area NEQ 'All' and form.partner EQ 'All'>
	and c.area=#form.area#
	<cfelseif form.region NEQ 'All' and form.partner EQ 'All'>
	and r.num=#form.region#
	</cfif>
	and (
	(dbo.sp_qss.year2 > #form.styear# OR (dbo.sp_qss.year2=#form.styear# and dbo.sp_qss.q >= #form.stquarter#))
	and (dbo.sp_qss.year2 < #form.endyear# OR (dbo.sp_qss.year2=#form.endyear# and dbo.sp_qss.q <= #form.endquarter#))
	)

	
 and c.partnertype = 4 AND (a.area IS not NULL)
GROUP BY <!--- a.area --->r.region, dbo.SP_qss.userid, c.orgname, dbo.SP_qss.q, dbo.SP_qss.year2
ORDER BY <!--- a.area --->r.region, dbo.SP_qss.userid, dbo.SP_qss.q, dbo.SP_qss.year2
</cfquery>




<cfoutput>
	<cfreport template="./reports/SSS.cfr" format = "#form.format#" query="SSS">
		
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

 <cfcase value = 37>

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
	username="#Application.db_username#" name="SPM">
SELECT     nys.institutionname, c.orgname, <!--- a.area --->r.region as area, dbo.SP_STIP.userid, dbo.SP_STIP.descrip_stip, dbo.SP_STIP.year2, dbo.sp_stip.month2,dbo.SP_STIP.amount_STIP, isNull(lst.descrip, 'Unspecified') as descrip,
case  when nys.bedscode like '%0000' then 1 else 0 end as distlvl, nys.district
FROM         dbo.SP_STIP INNER JOIN
                      dbo.contact c ON dbo.SP_STIP.userid = c.userid LEFT OUTER JOIN
                      dbo.Area a ON c.area = a.num AND a.year2 = #session.fy# 
					left outer join region as r on r.year2=a.year2 and r.num=a.region
					  inner join nysed_school nys on nys.bedscode = dbo.sp_stip.school_stip
                      inner join months on dbo.sp_stip.month2 = months.mon and dbo.sp_stip.year2 = months.year2
                      left outer join dbo.lu_sp_typefunding lst on dbo.sp_stip.typefund = lst.num and dbo.sp_stip.year2 = lst.year2
WHERE     (c.partnerType = 4) AND (dbo.SP_STIP.year2 = #session.fy#)
	<cfif form.partner NEQ 'All'>
	and c.userid = '#form.partner#'
	<cfelseif form.area NEQ 'All' and form.partner EQ 'All'>
	and c.area=#form.area#
	</cfif>
group by <!--- a.area --->r.region,c.orgname, nys.institutionname, c.orgname, dbo.SP_STIP.userid, dbo.SP_STIP.descrip_stip, dbo.SP_STIP.year2, dbo.sp_stip.month2,dbo.SP_STIP.amount_STIP, sp_rank, lst.descrip,
case  when nys.bedscode like '%0000' then 1 else 0 end, nys.district
order by <!--- a.area --->r.region, orgname, district, distlvl desc, institutionname, sp_rank
</cfquery>




<cfoutput>
	<cfreport template="./reports/SPM.cfr" format = "#form.format#" query="SPM">
		
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
		  <CFREPORTPARAM name=endYear VALUE="1">
		 <CFREPORTPARAM name=endQuarter VALUE="1">
		  <CFREPORTPARAM name=modality VALUE="#rptmodality#">
		 <CFREPORTPARAM name=stYear VALUE="1">
		 <CFREPORTPARAM name=StQuarter VALUE="1">
		  <CFREPORTPARAM name=Monthrange VALUE="1">		 
		
		</cfreport>
		 </cfoutput>
	</cfcase>
<cfcase value = 38>

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
	username="#Application.db_username#" name="SPSS">

SELECT DISTINCT 
                      <!--- a.area --->r.region as area, c.orgName, nys.InstitutionName, dbo.SP_QSS.datesurvey, dbo.SP_QSS.num_surveys, dbo.SP_QSS.num_staff, 
 timeframe = CASE tframe
         WHEN 1 THEN 'Baseline' 
         WHEN 2 THEN '3 month follow up' 
         WHEN 3 then '12 month follow up'
         WHEN 0 THEN 'Other'
         END,
                      
                      dbo.SP_QSS.tframe, 
                      dbo.SP_QSS.per_content, dbo.SP_QSS.per_imp, dbo.SP_QSS.comp_1, dbo.SP_QSS.comp_2, dbo.SP_QSS.comp_3, dbo.SP_QSS.comp_4, 
                      dbo.SP_QSS.comp_7, dbo.SP_QSS.comp_5, dbo.SP_QSS.comp_6, dbo.SP_QSS.comp_8, dbo.SP_QSS.comp_9,
					case  when nys.bedscode like '%0000' then 1 else 0 end as distlvl, nys.district
FROM         dbo.SP_QSS INNER JOIN
                      dbo.contact c ON dbo.SP_QSS.userid = c.userid LEFT OUTER JOIN
                      dbo.Area a ON c.area = a.num AND a.year2 = #session.fy# 
					left outer join dbo.region r on a.year2=r.year2 and a.region=r.num
					INNER JOIN
                      dbo.nysed_school nys ON nys.BEDSCode = dbo.SP_QSS.sname
WHERE     (c.partnerType = 4) <!--- AND (dbo.SP_QSS.year2 = 2007) --->
and (
	(dbo.SP_QSS.year2 > #form.styear# OR (dbo.SP_QSS.year2=#form.styear# and dbo.SP_QSS.q >= #form.stquarter#))
	and (dbo.SP_QSS.year2 < #form.endyear# OR (dbo.SP_QSS.year2=#form.endyear# and dbo.SP_QSS.q <= #form.endquarter#))
	)

<cfif form.partner NEQ 'All'>
	and c.userid = '#form.partner#'
<cfelseif form.area NEQ 'All' and form.partner EQ 'All'>
	and c.area=#form.area#
<cfelseif form.region NEQ 'All' and form.partner EQ 'All'>
	and r.num=#form.region#
</cfif>
ORDER BY <!--- a.area --->r.region, c.orgName, district, distlvl desc, institutionname

	
<!--- SELECT     nys.institutionname, c.orgname, a.area, dbo.SP_STIP.userid, dbo.SP_STIP.descrip_stip, dbo.SP_STIP.year2, dbo.sp_stip.month2,dbo.SP_STIP.amount_STIP, lst.descrip
FROM         dbo.SP_STIP INNER JOIN
                      dbo.contact c ON dbo.SP_STIP.userid = c.userid LEFT OUTER JOIN
                      dbo.Area a ON c.area = a.num AND a.year2 = 2007 inner join nysed_school nys on nys.bedscode = dbo.sp_stip.school_stip
                      inner join months on dbo.sp_stip.month2 = months.mon
                      inner join dbo.lu_sp_typefunding lst on dbo.sp_stip.typefund = lst.num and dbo.sp_stip.year2 = lst.year2
WHERE     (c.partnerType = 4) AND (dbo.SP_STIP.year2 = #session.fy#)
	<cfif form.partner NEQ 'All'>
	and c.userid = '#form.partner#'
	<cfelseif form.area NEQ 'All' and form.partner EQ 'All'>
	and c.area=#form.area#
	</cfif>
group by a.area,c.orgname, nys.institutionname, c.orgname, dbo.SP_STIP.userid, dbo.SP_STIP.descrip_stip, dbo.SP_STIP.year2, dbo.sp_stip.month2,dbo.SP_STIP.amount_STIP, sp_rank, lst.descrip
order by a.area, orgname, institutionname, sp_rank --->
</cfquery>




<cfoutput>

	<cfreport template="./reports/SPSS.cfr" format = "#form.format#" query="SPSS">
		
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
		  <CFREPORTPARAM name=endYear VALUE="#form.endyear#">
		 <CFREPORTPARAM name=endQuarter VALUE="#form.endquarter#">
		  <CFREPORTPARAM name=modality VALUE="#rptmodality#">
		 <CFREPORTPARAM name=stYear VALUE="#form.styear#">
		 <CFREPORTPARAM name=StQuarter VALUE="#form.stquarter#">
		  <CFREPORTPARAM name=Monthrange VALUE="1">		 
		
		</cfreport>
		 </cfoutput>
	</cfcase>
 <cfcase value= "39;51;" delimiters=";">
	
	<cfset session.fy=2010>
	<cfset form.stmonth=1>
	<cfset form.endmonth=4>

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
	username="#Application.db_username#" name="QAllminCrit">
select num
	from lu_tfsp
	where year2=#rptfy#
	and header =1
	order by rank
</cfquery>

<cfquery datasource="#Application.DataSource#"  		 
	password="#Application.db_password#"  		
	username="#Application.db_username#" name="SPPP">
SELECT    distinct <!--- a.area --->r.region as area, c.orgname, n.institutionname, mon.rank,
dbo.sp_tarp.month2, sp_qpp.q as quarter, 
case dbo.SP_tarp.year2 when 1904 then 2006 else dbo.SP_tarp.year2 end as year2, progress_tarp, sname,
case  when components like ('%#valuelist(QAllminCrit.num)#%') then 1 else 0 end as allmincrit,
mon.sp_rank,
case  when n.bedscode like '%0000' then 1 else 0 end as distlvl, n.district
FROM         dbo.SP_tarp INNER JOIN
                      dbo.contact c ON dbo.SP_tarp.userid = c.userid
                      LEFT OUTER JOIN
   dbo.area a on c.area = a.num and a.year2 <cfif form.rptType EQ 39>=<cfelse><=</cfif> #session.fy# 
left outer join region r on a.year2=r.year2 and a.region=r.num
   inner join months mon on dbo.sp_tarp.month2=mon.mon and dbo.sp_tarp.year2 = mon.year2
inner join nysed_school n on dbo.sp_tarp.school_tarp = n.bedscode
left join sp_qpp on dbo.sp_tarp.school_tarp = sp_qpp.sname  
and dbo.sp_tarp.year2 = sp_qpp.year2 
and mon.sp_quarter = dbo.sp_qpp.q
and dbo.sp_tarp.month2=mon.mon
WHERE     (c.partnerType = 4) AND (dbo.SP_tarp.year2 <cfif form.rptType EQ 39>=<cfelse><=</cfif> #session.fy#) and progress_tarp like '%5%' and 1=1

	<cfif form.partner NEQ 'All'>
	and c.userid = '#form.partner#'
	<cfelseif form.area NEQ 'All' and form.partner EQ 'All'>
	and c.area=#form.area#
	<cfelseif form.region NEQ 'All' and form.partner EQ 'All'>
	and r.num=#form.region#
	</cfif>
GROUP BY <!--- a.area --->r.region , dbo.SP_tarp.userid, c.orgname, n.institutionname, dbo.SP_tarp.year2, progress_tarp, mon.rank, dbo.sp_tarp.month2, sp_qpp.q, sname, mon.sp_rank, components,
case  when n.bedscode like '%0000' then 1 else 0 end, n.district
ORDER BY <!--- a.area --->r.region, n.district, distlvl desc, n.institutionname, 10 asc, mon.sp_rank,dbo.SP_tarp.year2,progress_tarp, dbo.sp_tarp.month2
	</cfquery>

<cfoutput>
	<cfif form.rptType EQ 39>
<cfreport template="./reports/SPPP.cfr" format = "#form.format#" query="sppp">
		
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
		 <CFREPORTPARAM name=modality VALUE="#rptmodality#">

		  <CFREPORTPARAM name=Monthrange VALUE="1"> 
		</cfreport>
	<cfelse>
	
	<cfquery  dbtype="query" name="subOne">
select count(distinct institutionname) as totCnt 
from sppp
</cfquery>

<cfquery  dbtype="query" name="subTwo">
select count(distinct institutionname) as totCnt 
from sppp
where allmincrit = 1
</cfquery>

<cfreport template="./reports/SPPP_tot.cfr" format = "#form.format#" query="SPPP">
		
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
		 <CFREPORTPARAM name=modality VALUE="#rptmodality#">
		  <CFREPORTPARAM name=Monthrange VALUE="1"> 
		  <cfif subOne.totCnt EQ "">
		<CFREPORTPARAM name=totOne VALUE="0"> 
		<cfelse><CFREPORTPARAM name=totOne VALUE="#subOne.totCnt#"> </cfif>
		  <cfif subTwo.totCnt EQ "">
		<CFREPORTPARAM name=totTwo VALUE="0"> 
		<cfelse><CFREPORTPARAM name=totTwo VALUE="#subTwo.totCnt#">  </cfif>
		</cfreport>
	</cfif>
	
		 </cfoutput>
	</cfcase>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	<!--- DELETE THIS TEST CASE --->
	<cfcase value= "52" >

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
	username="#Application.db_username#" name="QAllminCrit">
select num
	from lu_tfsp
	where year2=#rptfy#
	and header =1
	order by rank
</cfquery>

<cfquery datasource="#Application.DataSource#"  		 
	password="#Application.db_password#"  		
	username="#Application.db_username#" name="SPPP">
SELECT    distinct <!--- a.area --->r.region as area, c.orgname, n.institutionname, mon.rank,
dbo.sp_tarp.month2, sp_qpp.q as quarter, 
case dbo.SP_tarp.year2 when 1904 then 2006 else dbo.SP_tarp.year2 end as year2, progress_tarp, sname,
case  when components like ('%#valuelist(QAllminCrit.num)#%') then 1 else 0 end as allmincrit,
mon.sp_rank,
case  when n.bedscode like '%0000' then 1 else 0 end as distlvl, n.district
FROM         dbo.SP_tarp INNER JOIN
                      dbo.contact c ON dbo.SP_tarp.userid = c.userid
                      LEFT OUTER JOIN
   dbo.area a on c.area = a.num and a.year2 <cfif form.rptType EQ 39>=<cfelse><=</cfif> #session.fy# 
left outer join region r on a.year2=r.year2 and a.region=r.num
   inner join months mon on dbo.sp_tarp.month2=mon.mon and dbo.sp_tarp.year2=mon.year2
inner join nysed_school n on dbo.sp_tarp.school_tarp = n.bedscode
left join sp_qpp on dbo.sp_tarp.school_tarp = sp_qpp.sname  
and dbo.sp_tarp.year2 = sp_qpp.year2 
and mon.sp_quarter = dbo.sp_qpp.q
and dbo.sp_tarp.month2=mon.mon
WHERE     (c.partnerType = 4) AND (dbo.SP_tarp.year2 <cfif form.rptType EQ 39>=<cfelse><=</cfif> #session.fy#) and progress_tarp like '%5%' and 1=1

	<cfif form.partner NEQ 'All'>
	and c.userid = '#form.partner#'
	<cfelseif form.area NEQ 'All' and form.partner EQ 'All'>
	and c.area=#form.area#
	<cfelseif form.region NEQ 'All' and form.partner EQ 'All'>
	and r.num=#form.region#
	</cfif>
GROUP BY <!--- a.area --->r.region , dbo.SP_tarp.userid, c.orgname, n.institutionname, dbo.SP_tarp.year2, progress_tarp, mon.rank, dbo.sp_tarp.month2, sp_qpp.q, sname, mon.sp_rank, components,
case  when n.bedscode like '%0000' then 1 else 0 end, n.district
ORDER BY <!--- a.area --->r.region, n.district, distlvl desc, n.institutionname, 10, mon.sp_rank,dbo.SP_tarp.year2,progress_tarp, dbo.sp_tarp.month2</cfquery>

<cfquery  dbtype="query" name="subOne">
select count(distinct institutionname) as totCnt 
from sppp
</cfquery>

<cfquery  dbtype="query" name="subTwo">
select count(distinct institutionname) as totCnt 
from sppp
where allmincrit = 1
</cfquery>



<cfoutput>
<cfreport template="./reports/SPPP_tot.cfr" format = "#form.format#" query="SPPP">
		
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
		 <CFREPORTPARAM name=modality VALUE="#rptmodality#">
		  <CFREPORTPARAM name=Monthrange VALUE="1"> 
		  
		  <CFREPORTPARAM name=totOne VALUE="#subOne.totCnt#"> 
		  <CFREPORTPARAM name=totTwo VALUE="#subTwo.totCnt#"> 
		</cfreport>

		 </cfoutput>
	</cfcase>
	
	
	
	
	
	

<cfcase value="40">
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
o.objective
from contact as c, 
area as a, region r,
program as g, objectives as o,  useractivities u
where u.goal=g.prognum and u.year2=g.year2
and u.year2=#session.fy#
and u.userid=c.userid
and c.area=a.num
and a.year2=r.year2
and a.region=r.num
and u.year2=a.year2
and o.year2=u.year2
and o.id= u.objective
and (u.del is null or u.del !='Y')
and	c.partnertype = 4
		
	<cfinclude template="report_filter.cfm"> 
order by 1,3
</cfquery>

	<cfreport template="./reports/sp_eoyreportlist.cfr" format = "pdf" query="QEOY"> 

		<CFREPORTPARAM name=Year2 VALUE="2007">
		<CFREPORTPARAM name=Area VALUE="#form.region#">
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
		<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">
		</cfreport>
		 </cfoutput>
	</cfcase>
	
	<cfcase value="41">
	
	<cfparam name="form.Area" default="ALL">
<cfparam name="form.fArea" default="ALL">
		<cfparam name="form.Region" default="ALL">
<cfparam name="form.partner" default="ALL">

<cfparam name="form.Area" default="ALL">
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
and a.year2=r.year2
and a.region=r.num
and c.orgname is not null
and c.partnertype =4
and u.strategy !=10


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
order by a.area, c.orgname
</cfquery>
	<cfreport template="./reports/eoyreportStatus.cfr" format = "pdf"  query="QEOY"> 

		<CFREPORTPARAM name=Year2 VALUE="2007">
		<CFREPORTPARAM name=Area VALUE="#form.region#">
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
		<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">
		</cfreport>
		 </cfoutput>
	</cfcase>
	
	<cfcase value="42">
	<cfoutput>
<cfparam name="form.Area" default="ALL">
		<cfparam name="form.Region" default="ALL">
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
ar.area,
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
and ar.year2=r.year2
and ar.region=r.num
and a.userid=c.userid
and b.userid=c.userid
and b.year2=a.year2
and am_review=1
and	c.partnertype = 4

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
order by ar.area, orgname
</cfquery>

	<cfreport template="./reports/eoyfeedback.cfr" format = "pdf"  query="QEOY">

		<CFREPORTPARAM name=Year2 VALUE="2007">
		<CFREPORTPARAM name=Area VALUE="#form.region#">
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
		<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">
		</cfreport>
		 </cfoutput>
	</cfcase>
	<cfcase value="43">
	<cfoutput>

<cfparam name="form.Area" default="ALL">
		<cfparam name="form.Region" default="ALL">
<cfparam name="form.fArea" default="ALL">
<cfparam name="form.partner" default="ALL">
<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="QEOY">
		select 
r.region as area, c.orgname, v.userid, CAST(v.bedscode AS NUMERIC) BEDSCODE, v.institutionname, lastupd,
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
                      dbo.Area AS a ON a.num = c.area and v.year2=a.year2
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
<!--- a.area --->r.region, c.orgname, v.userid, v.bedscode, v.institutionname, v.filler, lastupd, nd.district_name

union
select  <!--- a.area --->r.region, co.orgname, co.userid, n.bedscode, n.institutionname, ' ',
case  when n.bedscode like '%0000' then 1 else 0 end as distlvl,
nd.district_name,
' ', ' ', ' ', ' ', ' ', ' ', ' ',
' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ',
' ', ' ', ' ', ' ', 0 as detprt, 1 as headprt, 0

from nysed_district as nd,nysed_school as n
, contact co, nysed_county nc, area a, region r
where 
a.num = co.area  
and a.year2=r.year2
and a.region=r.num
and
co.catchment like '%' + cast(nc.fips as varchar) + '%'
and nc.county_id = left(bedscode,2)
and bedscode like '%0000'	

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
	
order by <!--- a.area --->r.region, orgname, 8, 7 desc, 5

</cfquery>


	<cfreport template="./reports/sppeoy_main.cfr" format = "pdf" query="qeoy">

		<CFREPORTPARAM name=Year2 VALUE=#session.fy#>
		<CFREPORTPARAM name=Area VALUE="#form.region#">
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
  		  <cfreportparam name=title value="Cumulative">		 
		<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">
		</cfreport>  
		 </cfoutput>
	</cfcase>
	<cfcase value="44">
	<cfoutput>

<cfparam name="form.Area" default="ALL">
		<cfparam name="form.Region" default="ALL">
<cfparam name="form.fArea" default="ALL">
<cfparam name="form.partner" default="ALL">
<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="QEOY">
		select 
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


FROM        nysed_district as nd, nysed_school as ns, dbo.eoygrid_temp AS v INNER JOIN
                      dbo.contact AS c ON v.userid = c.userid INNER JOIN
                      dbo.Area AS a ON a.num = c.area
					inner join dbo.region as r on a.year2=r.year2 and a.region=r.num

where 

v.year2 =#session.fy#
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
<!--- a.area --->r.region, c.orgname, v.userid, v.bedscode, v.institutionname, v.filler, lastupd, nd.district_name

union
select  <!--- a.area --->r.region as area, co.orgname, co.userid, n.bedscode, n.institutionname, ' ',
case  when n.bedscode like '%0000' then 1 else 0 end as distlvl,
nd.district_name,
' ', ' ', ' ', ' ', ' ', ' ', ' ',
' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ',
' ', ' ', ' ', ' ', 0 as detprt, 1 as headprt, 0

from nysed_district as nd, nysed_school as n
, contact co, nysed_county nc, area a, region r
where 
a.num = co.area  
and a.year2=r.year2
and a.region=r.num
and
co.catchment like '%' + cast(nc.fips as varchar) + '%'
and nc.county_id = left(bedscode,2)
and bedscode like '%0000'	

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
v.year2 =#session.fy#
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
order by <!--- a.area --->r.region, orgname, 8, 7 desc,5

</cfquery>

	<cfreport template="./reports/sppeoy_main.cfr" format = "pdf" query="qeoy">

		<CFREPORTPARAM name=Year2 VALUE=#session.fy#>
		<CFREPORTPARAM name=Area VALUE="#form.region#">
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
		  <cfreportparam name=title value="by Contract Year">		 
		<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">
		</cfreport>  
		 </cfoutput>
	</cfcase>
 <cfcase value = 45>

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
	username="#Application.db_username#" name="QAllminCrit">
select num
	from lu_tfsp
	where year2=#rptfy#
	and header =1
	order by rank
</cfquery>

<cfquery datasource="#Application.DataSource#"  		 
	password="#Application.db_password#"  		
	username="#Application.db_username#" name="SPPP">
SELECT    distinct <!--- a.area --->r.region as area, c.orgname, n.institutionname, mon.rank,
dbo.sp_tarp.month2, sp_qpp.q as quarter, 
case dbo.SP_tarp.year2 when 1904 then 2006 else dbo.SP_tarp.year2 end as year2, progress_tarp, sname,
case  when components like ('%#valuelist(QAllminCrit.num)#%') then 1 else 0 end as allmincrit,
mon.sp_rank,
1 as distlvl, n.district
FROM         dbo.SP_tarp INNER JOIN
                      dbo.contact c ON dbo.SP_tarp.userid = c.userid
                      LEFT OUTER JOIN
   dbo.area a on c.area = a.num and a.year2 =#session.fy# 
left outer join region r on a.year2=r.year2 and a.region=r.num
   inner join months mon on dbo.sp_tarp.month2=mon.mon
inner join nysed_school n on dbo.sp_tarp.school_tarp = n.bedscode
left join sp_qpp on dbo.sp_tarp.school_tarp = sp_qpp.sname  
and dbo.sp_tarp.year2 = sp_qpp.year2 
and mon.sp_quarter = dbo.sp_qpp.q
and dbo.sp_tarp.month2=mon.mon
WHERE     (c.partnerType = 4) AND (dbo.SP_tarp.year2 = #session.fy#) and progress_tarp like '%5%' and 1=1

	<cfif form.partner NEQ 'All'>
	and c.userid = '#form.partner#'
	<cfelseif form.area NEQ 'All' and form.partner EQ 'All'>
	and c.area=#form.area#
	<cfelseif form.region NEQ 'All' and form.partner EQ 'All'>
	and r.num=#form.region#
	</cfif>
GROUP BY <!--- a.area --->r.region , dbo.SP_tarp.userid, c.orgname, n.institutionname, dbo.SP_tarp.year2, progress_tarp, mon.rank, dbo.sp_tarp.month2, sp_qpp.q, sname, mon.sp_rank, components,
case  when n.bedscode like '%0000' then 1 else 0 end, n.district
ORDER BY <!--- a.area --->r.region, n.district, distlvl desc, n.institutionname,mon.sp_rank,dbo.SP_tarp.year2,progress_tarp, dbo.sp_tarp.month2</cfquery>

<cfoutput>
	<cfreport template="./reports/SPPP2.cfr" format = "#form.format#" query="sppp">
		
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
		 <CFREPORTPARAM name=modality VALUE="#rptmodality#">

		  <CFREPORTPARAM name=Monthrange VALUE="1"> 
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
namesig, agencydir, accomp, goals, complete, contamt,
cbseq, c.userid, b.year2
	from eoy_basics b, contact c , area ar, region r
	where 
b.userid=c.userid
and c.partnertype=4
and b.year2=#session.fy#
and b.year2=ar.year2
and ar.year2=r.year2
and ar.region=r.num
and ar.num=c.area
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
	<cfreport template="./reports/eoy_rpt4SP.cfr" format = "pdf" query="TFPP">
<CFREPORTPARAM name=Year2 VALUE="#session.fy#">
<CFREPORTPARAM name=Area VALUE="#form.region#">
<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">
<CFREPORTPARAM name=modality VALUE="School Policy Partner">		
</cfreport> 


<cfelse>
	<cfreport template="./reports/eoy_rpt4SPd_sum.cfr" format = "pdf" query="TFPP" > 
<CFREPORTPARAM name=Year2 VALUE="#session.fy#">
<CFREPORTPARAM name=Area VALUE="#form.region#">
<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">
<CFREPORTPARAM name=modality VALUE="School Policy Partner">		
</cfreport> 

</cfif>


</cfoutput>
</cfcase>

<cfcase value="1234">
<cfset form.modality =4>

<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="conmon">
select orgname,case infra.mon when 1 then 'January' when 2 then 'February' when 3 then 'March' when 4 then 'April' when 5 then 'May' 
when 6 then 'June' when 7 then 'July' when 8 then 'August' when 9 then 'September' when 10 then 'October' when 11 then 'November' 
when 12 then 'December' end as monty,
	'999' as initnum,'Infrastructure' as initiative,'' as advmassmail,infra.userid,'' as editor,'' as prsspk,'' as prssrlse,'' as calls,
	legvisit,legcorr,mediarep,numsub,numpub,'' as summary,'' as barriers,'' as steps, c.partnertype
	from infra
	inner join contact c on infra.userid = c.userid
	inner join months mo on infra.mon = mo.mon_num
	where
	1=1		
	<cfif isdefined("form.cm") and form.cm is not 'all'>
	and infra.userid in (select userid from contact where cmanager = '#form.cm#')	
	</cfif>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and infra.userid='#form.partner#'
	</cfif>
	
	and c.partnertype = 4

	and infra.year2=#session.fy# 
	and mo.sp_rank >= '#form.stmonth#'
	and mo.sp_rank <= '#form.endmonth#'	 

order by c.orgname, initnum
</cfquery>

<cfset rptCM = "NONE">
<cfif (session.admin EQ "1" OR session.statemanage EQ "1" OR session.cntMan EQ "1" OR session.regionmanage EQ "1" OR session.areamanage EQ "1")>
<cfif form.CM EQ "ALL">
	<cfset rptCM = "All CMs">
	
	<cfelse>
<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="CMName">
	select contact from contact
	where userid = '#form.CM#'

</cfquery>
<cfset rptCM = "#CMName.contact#">	
</cfif>
</cfif>

<cfif form.partner NEQ "all">
<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="pName">
	select orgname from contact
	where userid = '#form.partner#'
</cfquery>
<cfset form.partner = '#pName.orgname#'>
<cfelseif  form.CM NEQ "ALL">
<cfset form.partner = 'ALL contractors assigned to this CM'>
<cfelse>
<cfset form.partner = 'ALL contractors statewide'>
</cfif>
	
	<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="mon">
	select mon_num as stmon
	from months
	where rank = #form.stmonth# and year2 = #session.fy#
</cfquery>

	<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="mon2">
	select mon_num as endmon
	from months
	where rank = #form.endmonth# and year2 = #session.fy#
</cfquery>
<cfreport template="./reports/infra2010.cfr"  format = "pdf" query="conmon">
		<CFREPORTPARAM name=Year2 VALUE=#session.fy#>
	<CFREPORTPARAM name=Objective VALUE="All">
		<CFREPORTPARAM name=ReportName VALUE="PP">
		<CFREPORTPARAM name=StMonth VALUE="#form.stmonth#">
		  <CFREPORTPARAM name=endMonth VALUE="#form.endmonth#">
		  <CFREPORTPARAM name=StMonthW VALUE="#mon.stmon#">
		  <CFREPORTPARAM name=endMonthW VALUE="#mon2.endmon#">
		<CFREPORTPARAM name=reportCM VALUE="#rptCM#">
		<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">
		
</cfreport>  
</cfcase>


<cfcase value="1000">
<cfset form.modality =4>

<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="conmon">
select 
1 as SONum, r.region as area, c.orgname, v.userid, CAST(v.bedscode AS NUMERIC) BEDSCODE, v.institutionname, lastupd,
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
case
sum(case isnull(qp.tframe,0) when 2 then 1 when 3 then 1 when 4 then 1 else 0 end )
when 0 then 0 else 1 end
as testQOD,
case
sum(case isnull(qp.tframe,0) when 1 then 1 when 20 then 1 else 0 end )
when 0 then 0 else 1 end
as testBOC,
case
sum(case isnull(qs.tframe,0) when 2 then 1 when 3 then 1 else 0 end )
when 0 then 0 else 1 end
as testQSS,
case (sum( case isnull(qs.tframe,'0') when '1' then 1 else 0 end)) when 0 then 0 else 1 end as  testBSS,
case (sum( case isnull(qpp.components,'0') when '0' then 0 else 1 end)) when 0 then 0 else 1 end as testQPP3,
1 as detprt, 0 as headprt, filler

FROM nysed_district as nd, nysed_school as ns, dbo.eoygrid_temp AS v 
left outer join sp_qod as qp on qp.sname=v.bedscode  
left outer join sp_qss as qs on qs.sname=v.bedscode 
left outer join sp_qpp3 as qpp on qpp.sname=v.bedscode  
INNER JOIN
dbo.contact AS c ON v.userid = c.userid 
INNER JOIN dbo.Area AS a ON a.num = c.area and v.year2=a.year2
inner join dbo.region as r on a.year2=r.year2 and a.region=r.num

where 

v.year2 >= 2009
	
and not(
acp1=0 and acp2=0 and acp3=0
and spp1=0 and spp2=0 and spp2=0 and spp4=0
and tarp1=0 and tarp2=0 and tarp3=0 and tarp4=0 and tarp5=0
and taip1=0 and taip2=0 and taip3=0 and taip4=0 and taip_5 =0
and qob=0 and qsurv=0
)
and ns.district=nd.district_id
and v.bedscode=ns.bedscode
and 
(
v.bedscode in (select cc.school from collaborators cc where cc.sfy in (2009, 2010) and cc.userid = v.userid)
or
(left(v.bedscode,6) in (select cc.district from  collaborators cc where cc.sfy in (2009, 2010) and cc.userid = v.userid and cc.school= '999')
and right(v.bedscode,4)='0000')
)
<cfif isdefined("form.cm") and form.cm is not 'all'>
	and v.userid in (select userid from contact where cmanager = '#form.cm#')	
	</cfif>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and v.userid='#form.partner#'
	</cfif>
group by 
r.region, c.orgname, v.userid, v.bedscode, v.institutionname, v.filler, lastupd, nd.district_name

union
select 
1 as SONum, r.region as area, co.orgname, co.userid, CAST(n.bedscode AS NUMERIC) BEDSCODE, n.institutionname, '1/2/1904',
case  when n.bedscode like '%0000' then 1 else 0 end as distlvl,
nd.district_name,
' ', ' ', ' ', ' ', ' ', ' ', ' ',
' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ',
' ', ' ', ' ', ' ', 
'', '', '',
0 as detprt, 1 as headprt, 0

from nysed_district as nd, nysed_school as n
, contact co, nysed_county nc, area a, region r
where 
a.num = co.area  
and a.year2=r.year2
and a.region=r.num
and
co.catchment like '%' + cast(nc.fips as varchar) + '%'
and nc.county_id = left(bedscode,2)
and bedscode like '%0000'	

and bedscode not in (select v.bedscode
from
dbo.eoygrid_temp  as v 
where 
v.year2 >= 2009
<cfif isdefined("form.cm") and form.cm is not 'all'>
	and v.userid in (select userid from contact where cmanager = '#form.cm#')	
	</cfif>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and v.userid='#form.partner#'
	</cfif>
and 
(
v.bedscode in (select cc.school from collaborators cc where cc.sfy in (2009, 2010) and cc.userid = v.userid)
or
(left(v.bedscode,6) in (select cc.district from  collaborators cc where cc.sfy in (2009, 2010) and cc.userid = v.userid and cc.school= '999')
and right(v.bedscode,4)='0000')
)
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
v.year2  >=2009
<cfif isdefined("form.cm") and form.cm is not 'all'>
	and v.userid in (select userid from contact where cmanager = '#form.cm#')	
	</cfif>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and v.userid='#form.partner#'
	</cfif>
and 
(
v.bedscode in (select cc.school from collaborators cc where cc.sfy in (2009, 2010) and cc.userid = v.userid)
or
(left(v.bedscode,6) in (select cc.district from  collaborators cc where cc.sfy in (2009, 2010) and cc.userid = v.userid and cc.school= '999')
and right(v.bedscode,4)='0000')
)
and not(
acp1=0 and acp2=0 and acp3=0
and spp1=0 and spp2=0 and spp2=0 and spp4=0
and tarp1=0 and tarp2=0 and tarp3=0 and tarp4=0 and tarp5=0
and taip1=0 and taip2=0 and taip3=0 and taip4=0 and taip_5=0
and qob=0 and qsurv=0))
and partnertype = 4
and n.district=nd.district_id
<cfif isdefined("form.cm") and form.cm is not 'all'>
	and co.userid in (select userid from contact where cmanager = '#form.cm#')	
	</cfif>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and co.userid='#form.partner#'
	</cfif>


UNION


select 
2 as SONum, r.region as area, c.orgname, v.userid, CAST(v.bedscode AS NUMERIC) BEDSCODE, v.institutionname, lastupd,
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
case
sum(case isnull(qp.tframe,0) when 2 then 1 when 3 then 1 when 4 then 1 else 0 end )
when 0 then 0 else 1 end
as testQOD,
case
sum(case isnull(qp.tframe,0) when 1 then 1 when 20 then 1 else 0 end )
when 0 then 0 else 1 end
as testBOC,
case
sum(case isnull(qs.tframe,0) when 2 then 1 when 3 then 1 else 0 end )
when 0 then 0 else 1 end
as testQSS,
case (sum( case isnull(qs.tframe,'0') when '1' then 1 else 0 end)) when 0 then 0 else 1 end as  testBSS,
case (sum( case isnull(qpp.components,'0') when '0' then 0 else 1 end)) when 0 then 0 else 1 end as testQPP3,
1 as detprt, 0 as headprt, filler

FROM nysed_district as nd, nysed_school as ns, dbo.eoygrid_temp AS v 
left outer join sp_qod as qp on qp.sname=v.bedscode  
left outer join sp_qss as qs on qs.sname=v.bedscode 
left outer join sp_qpp3 as qpp on qpp.sname=v.bedscode  
INNER JOIN
dbo.contact AS c ON v.userid = c.userid 
INNER JOIN dbo.Area AS a ON a.num = c.area and v.year2=a.year2
inner join dbo.region as r on a.year2=r.year2 and a.region=r.num

where 

v.year2  >= 2008
	
and not(
acp1=0 and acp2=0 and acp3=0
and spp1=0 and spp2=0 and spp2=0 and spp4=0
and tarp1=0 and tarp2=0 and tarp3=0 and tarp4=0 and tarp5=0
and taip1=0 and taip2=0 and taip3=0 and taip4=0 and taip_5 =0
and qob=0 and qsurv=0
)
and ns.district=nd.district_id
and v.bedscode=ns.bedscode
and 
(
v.bedscode in (select cc.school from collaborators cc where cc.sfy in (2008) and cc.userid = v.userid)
or
(left(v.bedscode,6) in (select cc.district from  collaborators cc where cc.sfy in (2008) and cc.userid = v.userid and cc.school= '999')
and right(v.bedscode,4)='0000')
)
<cfif isdefined("form.cm") and form.cm is not 'all'>
	and v.userid in (select userid from contact where cmanager = '#form.cm#')	
	</cfif>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and v.userid='#form.partner#'
	</cfif>
group by 
r.region, c.orgname, v.userid, v.bedscode, v.institutionname, v.filler, lastupd, nd.district_name

union
select 
2 as SONum, r.region as area, co.orgname, co.userid, CAST(n.bedscode AS NUMERIC) BEDSCODE, n.institutionname, '1/2/1904',
case  when n.bedscode like '%0000' then 1 else 0 end as distlvl,
nd.district_name,
' ', ' ', ' ', ' ', ' ', ' ', ' ',
' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ',
' ', ' ', ' ', ' ', 
'', '', '',
0 as detprt, 1 as headprt, 0

from nysed_district as nd, nysed_school as n
, contact co, nysed_county nc, area a, region r
where 
a.num = co.area  
and a.year2=r.year2
and a.region=r.num
and
co.catchment like '%' + cast(nc.fips as varchar) + '%'
and nc.county_id = left(bedscode,2)
and bedscode like '%0000'	

and bedscode not in (select v.bedscode
from
dbo.eoygrid_temp  as v 
where 
v.year2 >= 2008
<cfif isdefined("form.cm") and form.cm is not 'all'>
	and v.userid in (select userid from contact where cmanager = '#form.cm#')	
	</cfif>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and v.userid='#form.partner#'
	</cfif>
and 
(
v.bedscode in (select cc.school from collaborators cc where cc.sfy in (2008) and cc.userid = v.userid)
or
(left(v.bedscode,6) in (select cc.district from  collaborators cc where cc.sfy in (2008) and cc.userid = v.userid and cc.school= '999')
and right(v.bedscode,4)='0000')
)
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
v.year2 >= 2008
<cfif isdefined("form.cm") and form.cm is not 'all'>
	and v.userid in (select userid from contact where cmanager = '#form.cm#')	
	</cfif>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and v.userid='#form.partner#'
	</cfif>
and 
(
v.bedscode in (select cc.school from collaborators cc where cc.sfy in (2008) and cc.userid = v.userid)
or
(left(v.bedscode,6) in (select cc.district from  collaborators cc where cc.sfy in (2008) and cc.userid = v.userid and cc.school= '999')
and right(v.bedscode,4)='0000')
)
and not(
acp1=0 and acp2=0 and acp3=0
and spp1=0 and spp2=0 and spp2=0 and spp4=0
and tarp1=0 and tarp2=0 and tarp3=0 and tarp4=0 and tarp5=0
and taip1=0 and taip2=0 and taip3=0 and taip4=0 and taip_5=0
and qob=0 and qsurv=0))
and partnertype = 4
and n.district=nd.district_id
<cfif isdefined("form.cm") and form.cm is not 'all'>
	and co.userid in (select userid from contact where cmanager = '#form.cm#')	
	</cfif>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and co.userid='#form.partner#'
	</cfif>

UNION

select 
3 as SONum, r.region as area, c.orgname, v.userid, CAST(v.bedscode AS NUMERIC) BEDSCODE, v.institutionname, lastupd,
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
case
sum(case isnull(qp.tframe,0) when 2 then 1 when 3 then 1 when 4 then 1 else 0 end )
when 0 then 0 else 1 end
as testQOD,
case
sum(case isnull(qp.tframe,0) when 1 then 1 when 20 then 1 else 0 end )
when 0 then 0 else 1 end
as testBOC,
case
sum(case isnull(qs.tframe,0) when 2 then 1 when 3 then 1 else 0 end )
when 0 then 0 else 1 end
as testQSS,
case (sum( case isnull(qs.tframe,'0') when '1' then 1 else 0 end)) when 0 then 0 else 1 end as  testBSS,
case (sum( case isnull(qpp.components,'0') when '0' then 0 else 1 end)) when 0 then 0 else 1 end as testQPP3,
1 as detprt, 0 as headprt, filler

FROM nysed_district as nd, nysed_school as ns, dbo.eoygrid_temp AS v 
left outer join sp_qod as qp on qp.sname=v.bedscode  
left outer join sp_qss as qs on qs.sname=v.bedscode 
left outer join sp_qpp3 as qpp on qpp.sname=v.bedscode  
INNER JOIN
dbo.contact AS c ON v.userid = c.userid 
INNER JOIN dbo.Area AS a ON a.num = c.area and v.year2=a.year2
inner join dbo.region as r on a.year2=r.year2 and a.region=r.num

where 

v.year2 >= 1904
	
and not(
acp1=0 and acp2=0 and acp3=0
and spp1=0 and spp2=0 and spp2=0 and spp4=0
and tarp1=0 and tarp2=0 and tarp3=0 and tarp4=0 and tarp5=0
and taip1=0 and taip2=0 and taip3=0 and taip4=0 and taip_5 =0
and qob=0 and qsurv=0
)
and ns.district=nd.district_id
and v.bedscode=ns.bedscode
and 
(
v.bedscode in (select cc.school from collaborators cc where cc.sfy in (1904, 2007) and cc.userid = v.userid)
or
(left(v.bedscode,6) in (select cc.district from  collaborators cc where cc.sfy in (1904, 2007) and cc.userid = v.userid and cc.school= '999')
and right(v.bedscode,4)='0000')
)
<cfif isdefined("form.cm") and form.cm is not 'all'>
	and v.userid in (select userid from contact where cmanager = '#form.cm#')	
	</cfif>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and v.userid='#form.partner#'
	</cfif>
group by 
r.region, c.orgname, v.userid, v.bedscode, v.institutionname, v.filler, lastupd, nd.district_name

union
select 
3 as SONum, r.region as area, co.orgname, co.userid, CAST(n.bedscode AS NUMERIC) BEDSCODE, n.institutionname, '1/2/1904',
case  when n.bedscode like '%0000' then 1 else 0 end as distlvl,
nd.district_name,
' ', ' ', ' ', ' ', ' ', ' ', ' ',
' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ',
' ', ' ', ' ', ' ', 
'', '', '',
0 as detprt, 1 as headprt, 0

from nysed_district as nd, nysed_school as n
, contact co, nysed_county nc, area a, region r
where 
a.num = co.area  
and a.year2=r.year2
and a.region=r.num
and
co.catchment like '%' + cast(nc.fips as varchar) + '%'
and nc.county_id = left(bedscode,2)
and bedscode like '%0000'	

and bedscode not in (select v.bedscode
from
dbo.eoygrid_temp  as v 
where 
v.year2 >= 1904
<cfif isdefined("form.cm") and form.cm is not 'all'>
	and v.userid in (select userid from contact where cmanager = '#form.cm#')	
	</cfif>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and v.userid='#form.partner#'
	</cfif>
and 
(
v.bedscode in (select cc.school from collaborators cc where cc.sfy in (1904, 2007) and cc.userid = v.userid)
or
(left(v.bedscode,6) in (select cc.district from  collaborators cc where cc.sfy in (1904, 2007) and cc.userid = v.userid and cc.school= '999')
and right(v.bedscode,4)='0000')
)
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
v.year2 >= 1904
<cfif isdefined("form.cm") and form.cm is not 'all'>
	and v.userid in (select userid from contact where cmanager = '#form.cm#')	
	</cfif>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and v.userid='#form.partner#'
	</cfif>
and 
(
v.bedscode in (select cc.school from collaborators cc where cc.sfy in (1904, 2007) and cc.userid = v.userid)
or
(left(v.bedscode,6) in (select cc.district from  collaborators cc where cc.sfy in (1904, 2007) and cc.userid = v.userid and cc.school= '999')
and right(v.bedscode,4)='0000')
)
and not(
acp1=0 and acp2=0 and acp3=0
and spp1=0 and spp2=0 and spp2=0 and spp4=0
and tarp1=0 and tarp2=0 and tarp3=0 and tarp4=0 and tarp5=0
and taip1=0 and taip2=0 and taip3=0 and taip4=0 and taip_5=0
and qob=0 and qsurv=0))
and partnertype = 4
and n.district=nd.district_id
<cfif isdefined("form.cm") and form.cm is not 'all'>
	and co.userid in (select userid from contact where cmanager = '#form.cm#')	
	</cfif>
	<cfif isdefined("form.partner") and form.partner is not 'all'>
	and co.userid='#form.partner#'
	</cfif>

order by 
orgname, 1, 9, 8 desc,6
	
</cfquery>


<cfset rptCM = "NONE">
<cfif (session.admin EQ "1" OR session.statemanage EQ "1" OR session.cntMan EQ "1" OR session.regionmanage EQ "1" OR session.areamanage EQ "1")>
<cfif form.CM EQ "ALL">
	<cfset rptCM = "All CMs">
	
	<cfelse>
<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="CMName">
	select contact from contact
	where userid = '#form.CM#'

</cfquery>
<cfset rptCM = "#CMName.contact#">	
</cfif>
</cfif>

<cfif form.partner NEQ "all">
<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="pName">
	select orgname from contact
	where userid = '#form.partner#'
</cfquery>
<cfset form.partner = '#pName.orgname#'>
<cfelseif  form.CM NEQ "ALL">
<cfset form.partner = 'ALL contractors assigned to this CM'>
<cfelse>
<cfset form.partner = 'ALL contractors statewide'>
</cfif>
	
	
<cfreport template="./reports/sppeoy_smart123.cfr"  format = "pdf" query="conmon">
		<CFREPORTPARAM name=Year2 VALUE=#session.fy#>
		<CFREPORTPARAM name=Objective VALUE="All">
		<CFREPORTPARAM name=ReportName VALUE="PP">
		<CFREPORTPARAM name=StMonth VALUE="1">
		<CFREPORTPARAM name=reportCM VALUE="#rptCM#"> 
		<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">		
</cfreport>  
</cfcase>









<cfcase value="1001">
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
			and year2=#session.fy#
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
and m.mon_num=f.mon and m.year2 = f.year2
<cfif isdefined("form.cm") and form.cm is not 'all'>
	and f.userid in (select userid from contact where cmanager = '#form.cm#')	
</cfif>
<cfif isdefined("form.partner") and form.partner is not 'all'>
	and f.userid='#form.partner#'
	<cfelseif isDefined("form.Region") and form.region is not 'all'>
		and f.userid in 
		(select userid from security s, area a, region r 
where 
isNull(c.coordemail, '') not like '%rti.org' and
s.del is null
and s.area = a.num
and a.region=r.num
and a.year2=#session.fy#
and r.num=#form.region#
and r.year2=a.year2 )	
	</cfif>
	and c.partnertype = 4
	
	and f.year2=#session.fy# 
	and m.year2=#session.fy#
	<cfif session.fy GTE 2013>
	
	and m.sp_rank >= '#form.stmonth#'
	and m.sp_rank <= '#form.endmonth#'
	
	<cfelseif session.fy GTE 2011>
	
	and m.rank >= '#form.stmonth#'
	and m.rank <= '#form.endmonth#'
	<cfelse>
	
	and m.sp_rank >= '#form.stmonth#'
	and m.sp_rank <= '#form.endmonth#'
	</cfif>		

order by orgname,m.rank
</cfquery>

<cfset rptCM = "NONE">
<cfif (session.admin EQ "1" OR session.statemanage EQ "1" OR session.cntMan EQ "1" OR session.regionmanage EQ "1" OR session.areamanage EQ "1")>
<cfif isdefined("form.cm") and form.CM EQ "ALL">
	<cfset rptCM = "All CMs">
	
	<cfelseif isdefined("form.cm")>
<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="CMName">
	select contact from contact
	where userid = '#form.CM#'

</cfquery>
<cfset rptCM = "#CMName.contact#">	
</cfif>
</cfif>

<cfif form.partner NEQ "all">
<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="pName">
	select orgname from contact
	where userid = '#form.partner#'
</cfquery>
<cfset form.partner = '#pName.orgname#'>
<cfelseif  isdefined("form.cm") and form.CM NEQ "ALL">
<cfset form.partner = 'ALL contractors assigned to this CM'>
<cfelse>
<cfset form.partner = 'ALL contractors statewide'>
</cfif>

<cfreport template="./reports/cmfbackSP.cfr" format = "pdf" query="cmfb">

		<CFREPORTPARAM name=Year2 VALUE=#session.fy#>
	<CFREPORTPARAM name=Objective VALUE="All">
		<CFREPORTPARAM name=ReportName VALUE="PP">
	<!--- 	<CFREPORTPARAM name=StMonth VALUE="#form.stmonth#">
		  <CFREPORTPARAM name=endMonth VALUE="#form.endmonth#"> --->
		  <CFREPORTPARAM name=StMonthW VALUE="#QstmnW.mon#">
		  <CFREPORTPARAM name=endMonthW VALUE="#QendmnW.mon#">
		<CFREPORTPARAM name=reportCM VALUE="#rptCM#">
		<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">
		</cfreport>  

</cfoutput>

</cfcase>




<cfcase value="1002">

	<CFparam name="form.CM" default="All"> 
	<CFparam name="form.Partner" default="All">
	
<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="conmon">


select 
1 as sect, c.orgname,co.userid, n.institutionName,
q.district,  isnull(m.year2,0) as year2,
max(isNull(mo,0)) as mmon, 
DateName( month , DateAdd( month , max(isNull(mo,0)) , 0 ) - 1 ) as mmon2,
case sum(case m.variable when 'Q2_9' then 1 else 0 end) when 0 then 0 else 1 end as Q2_9,
case sum(case m.variable when 'Q2_10' then 1 else 0 end) when 0 then 0 else 1 end as Q2_10,
case sum(case m.variable when 'Q2_11' then 1 else 0 end) when 0 then 0 else 1 end as Q2_11,
case sum(case m.variable when 'Q2_12' then 1 else 0 end) when 0 then 0 else 1 end as Q2_12,
case sum(case m.variable when 'Q2_13' then 1 else 0 end) when 0 then 0 else 1 end as Q2_13,
case sum(case m.variable when 'Q2_14' then 1 else 0 end) when 0 then 0 else 1 end as Q2_14,
case sum(case m.variable when 'Q2_15' then 1 else 0 end) when 0 then 0 else 1 end as Q2_15,
case sum(case m.variable when 'Q2_16' then 1 else 0 end) when 0 then 0 else 1 end as Q2_16,
case sum(case m.variable when 'Q2_17' then 1 else 0 end) when 0 then 0 else 1 end as Q2_17,
case sum(case m.variable when 'Q2_18' then 1 else 0 end) when 0 then 0 else 1 end as Q2_18,
case sum(case m.variable when 'Q2_19' then 1 else 0 end) when 0 then 0 else 1 end as Q2_19,
case sum(case m.variable when 'Q3_20' then 1 else 0 end) when 0 then 0 else 1 end as Q3_20,
case sum(case m.variable when 'Q3_21' then 1 else 0 end) when 0 then 0 else 1 end as Q3_21,
case sum(case m.variable when 'Q3_22' then 1 else 0 end) when 0 then 0 else 1 end as Q3_22,
case sum(case m.variable when 'Q3_23' then 1 else 0 end) when 0 then 0 else 1 end as Q3_23,
case sum(case m.variable when 'Q3_24' then 1 else 0 end) when 0 then 0 else 1 end as Q3_24,
case sum(case m.variable when 'Q4_25' then 1 else 0 end) when 0 then 0 else 1 end as Q4_25,
case sum(case m.variable when 'Q4_26' then 1 else 0 end) when 0 then 0 else 1 end as Q4_26,
case sum(case m.variable when 'Q4_27' then 1 else 0 end) when 0 then 0 else 1 end as Q4_27,
case sum(case m.variable when 'Q4_28' then 1 else 0 end) when 0 then 0 else 1 end as Q4_28,
case sum(case m.variable when 'Q4_29' then 1 else 0 end) when 0 then 0 else 1 end as Q4_29,
case sum(case m.variable when 'Q4_30' then 1 else 0 end) when 0 then 0 else 1 end as Q4_30,
case sum(case m.variable when 'Q4_31' then 1 else 0 end) when 0 then 0 else 1 end as Q4_31,
case sum(case m.variable when 'Q4_32' then 1 else 0 end) when 0 then 0 else 1 end as Q4_32,
case sum(case m.variable when 'Q4_33' then 1 else 0 end) when 0 then 0 else 1 end as Q4_33,
case sum(case m.variable when 'Q4_34' then 1 else 0 end) when 0 then 0 else 1 end as Q4_34,
case sum(case m.variable when 'Q4_35' then 1 else 0 end) when 0 then 0 else 1 end as Q4_35,
case sum(case m.variable when 'Q5_36' then 1 else 0 end) when 0 then 0 else 1 end as Q5_36,
case sum(case m.variable when 'Q5_37' then 1 else 0 end) when 0 then 0 else 1 end as Q5_37,
case sum(case m.variable when 'Q5_38' then 1 else 0 end) when 0 then 0 else 1 end as Q5_38,
case sum(case m.variable when 'Q6_39' then 1 else 0 end) when 0 then 0 else 1 end as Q6_39,
case sum(case m.variable when 'Q6_40' then 1 else 0 end) when 0 then 0 else 1 end as Q6_40,
case sum(case m.variable when 'Q6_41' then 1 else 0 end) when 0 then 0 else 1 end as Q6_41,
case sum(case m.variable when 'Q7_42' then 1 else 0 end) when 0 then 0 else 1 end as Q7_42,
case sum(case m.variable when 'Q7_43' then 1 else 0 end) when 0 then 0 else 1 end as Q7_43,
case sum(case m.variable when 'Q7_44' then 1 else 0 end) when 0 then 0 else 1 end as Q7_44,
case sum(case m.variable when 'Q7_45' then 1 else 0 end) when 0 then 0 else 1 end as Q7_45,
case sum(case m.variable when 'Q7_46' then 1 else 0 end) when 0 then 0 else 1 end as Q7_46,
case sum(case m.variable when 'Q7_47' then 1 else 0 end) when 0 then 0 else 1 end as Q7_47,

case sum(case b.variable when 'Q2_9' then 1 else 0 end) when 0 then 0 else 1 end as bQ2_9,
case sum(case b.variable when 'Q2_10' then 1 else 0 end) when 0 then 0 else 1 end as bQ2_10,
case sum(case b.variable when 'Q2_11' then 1 else 0 end) when 0 then 0 else 1 end as bQ2_11,
case sum(case b.variable when 'Q2_12' then 1 else 0 end) when 0 then 0 else 1 end as bQ2_12,
case sum(case b.variable when 'Q2_13' then 1 else 0 end) when 0 then 0 else 1 end as bQ2_13,
case sum(case b.variable when 'Q2_14' then 1 else 0 end) when 0 then 0 else 1 end as bQ2_14,
case sum(case b.variable when 'Q2_15' then 1 else 0 end) when 0 then 0 else 1 end as bQ2_15,
case sum(case b.variable when 'Q2_16' then 1 else 0 end) when 0 then 0 else 1 end as bQ2_16,
case sum(case b.variable when 'Q2_17' then 1 else 0 end) when 0 then 0 else 1 end as bQ2_17,
case sum(case b.variable when 'Q2_18' then 1 else 0 end) when 0 then 0 else 1 end as bQ2_18,
case sum(case b.variable when 'Q2_19' then 1 else 0 end) when 0 then 0 else 1 end as bQ2_19,
case sum(case b.variable when 'Q3_20' then 1 else 0 end) when 0 then 0 else 1 end as bQ3_20,
case sum(case b.variable when 'Q3_21' then 1 else 0 end) when 0 then 0 else 1 end as bQ3_21,
case sum(case b.variable when 'Q3_22' then 1 else 0 end) when 0 then 0 else 1 end as bQ3_22,
case sum(case b.variable when 'Q3_23' then 1 else 0 end) when 0 then 0 else 1 end as bQ3_23,
case sum(case b.variable when 'Q3_24' then 1 else 0 end) when 0 then 0 else 1 end as bQ3_24,
case sum(case b.variable when 'Q4_25' then 1 else 0 end) when 0 then 0 else 1 end as bQ4_25,
case sum(case b.variable when 'Q4_26' then 1 else 0 end) when 0 then 0 else 1 end as bQ4_26,
case sum(case b.variable when 'Q4_27' then 1 else 0 end) when 0 then 0 else 1 end as bQ4_27,
case sum(case b.variable when 'Q4_28' then 1 else 0 end) when 0 then 0 else 1 end as bQ4_28,
case sum(case b.variable when 'Q4_29' then 1 else 0 end) when 0 then 0 else 1 end as bQ4_29,
case sum(case b.variable when 'Q4_30' then 1 else 0 end) when 0 then 0 else 1 end as bQ4_30,
case sum(case b.variable when 'Q4_31' then 1 else 0 end) when 0 then 0 else 1 end as bQ4_31,
case sum(case b.variable when 'Q4_32' then 1 else 0 end) when 0 then 0 else 1 end as bQ4_32,
case sum(case b.variable when 'Q4_33' then 1 else 0 end) when 0 then 0 else 1 end as bQ4_33,
case sum(case b.variable when 'Q4_34' then 1 else 0 end) when 0 then 0 else 1 end as bQ4_34,
case sum(case b.variable when 'Q4_35' then 1 else 0 end) when 0 then 0 else 1 end as bQ4_35,
case sum(case b.variable when 'Q5_36' then 1 else 0 end) when 0 then 0 else 1 end as bQ5_36,
case sum(case b.variable when 'Q5_37' then 1 else 0 end) when 0 then 0 else 1 end as bQ5_37,
case sum(case b.variable when 'Q5_38' then 1 else 0 end) when 0 then 0 else 1 end as bQ5_38,
case sum(case b.variable when 'Q6_39' then 1 else 0 end) when 0 then 0 else 1 end as bQ6_39,
case sum(case b.variable when 'Q6_40' then 1 else 0 end) when 0 then 0 else 1 end as bQ6_40,
case sum(case b.variable when 'Q6_41' then 1 else 0 end) when 0 then 0 else 1 end as bQ6_41,
case sum(case b.variable when 'Q7_42' then 1 else 0 end) when 0 then 0 else 1 end as bQ7_42,
case sum(case b.variable when 'Q7_43' then 1 else 0 end) when 0 then 0 else 1 end as bQ7_43,
case sum(case b.variable when 'Q7_44' then 1 else 0 end) when 0 then 0 else 1 end as bQ7_44,
case sum(case b.variable when 'Q7_45' then 1 else 0 end) when 0 then 0 else 1 end as bQ7_45,
case sum(case b.variable when 'Q7_46' then 1 else 0 end) when 0 then 0 else 1 end as bQ7_46,
case sum(case b.variable when 'Q7_47' then 1 else 0 end) when 0 then 0 else 1 end as bQ7_47,

cast(n.bedscode as float) as bedscode


from 
collaborators co,
nysed_school n,
contact c,
dbo.v_spDistricts q 
left outer join 
sp_monthly m on  q.district=m.district and q.userid =m.userid and m.year2 <=#session.fy#
and
(

case m.variable when 'Q2_9' then 1 else 0 end !=0 OR
case m.variable when 'Q2_10' then 1 else 0 end !=0 OR
case m.variable when 'Q2_11' then 1 else 0 end  !=0 OR
case m.variable when 'Q2_12' then 1 else 0 end !=0 OR
case m.variable when 'Q2_13' then 1 else 0 end !=0 OR
case m.variable when 'Q2_14' then 1 else 0 end  !=0 OR
case m.variable when 'Q2_15' then 1 else 0 end  !=0 OR
case m.variable when 'Q2_16' then 1 else 0 end  !=0 OR
case m.variable when 'Q2_17' then 1 else 0 end  !=0 OR
case m.variable when 'Q2_18' then 1 else 0 end !=0 OR
case m.variable when 'Q2_19' then 1 else 0 end  !=0 OR
case m.variable when 'Q3_20' then 1 else 0 end !=0 OR
case m.variable when 'Q3_21' then 1 else 0 end !=0 OR
case m.variable when 'Q3_22' then 1 else 0 end !=0 OR
case m.variable when 'Q3_23' then 1 else 0 end  !=0 OR
case m.variable when 'Q3_24' then 1 else 0 end !=0)
left outer join 
sp_baseline b on  q.district=b.district and q.userid =b.userid and b.year2 <=#session.fy#
and
(

case b.variable when 'Q2_9' then 1 else 0 end !=0 OR
case b.variable when 'Q2_10' then 1 else 0 end !=0 OR
case b.variable when 'Q2_11' then 1 else 0 end !=0 OR
case b.variable when 'Q2_12' then 1 else 0 end !=0 OR
case b.variable when 'Q2_13' then 1 else 0 end !=0 OR
case b.variable when 'Q2_14' then 1 else 0 end  !=0 OR
case b.variable when 'Q2_15' then 1 else 0 end  !=0 OR
case b.variable when 'Q2_16' then 1 else 0 end  !=0 OR
case b.variable when 'Q2_17' then 1 else 0 end  !=0 OR
case b.variable when 'Q2_18' then 1 else 0 end  !=0 OR
case b.variable when 'Q2_19' then 1 else 0 end  !=0 OR
case b.variable when 'Q3_20' then 1 else 0 end  !=0 OR
case b.variable when 'Q3_21' then 1 else 0 end  !=0 OR
case b.variable when 'Q3_22' then 1 else 0 end  !=0 OR
case b.variable when 'Q3_23' then 1 else 0 end  !=0 OR
case b.variable when 'Q3_24' then 1 else 0 end  !=0 
)
where 
isnull(c.coordemail, '') not like '%rti.org' and 
c.userid=co.userid and
 ((rtrim(q.district) = n.district and n.bedscode like '%0000')  OR rtrim(q.district) = n.bedscode) 
and (q.district = co.district or q.district = co.school)
and co.userid = c.userid
and c.userid = q.userid
<!--- and c.coordemail not like '%rti.org' --->
<cfif isdefined("form.cm") and form.cm is not 'all'>
	and c.userid in (select userid from contact where cmanager = '#form.cm#')	
</cfif>
<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid='#form.partner#'
</cfif>
and (co.SCHOOL='999' OR ISNULL(co.SODISTRICT,0)=1) AND ISNULL(co.DEL,0) = 0
and
(

case m.variable when 'Q2_9' then 1 else 0 end !=0 OR
case m.variable when 'Q2_10' then 1 else 0 end !=0 OR
case m.variable when 'Q2_11' then 1 else 0 end  !=0 OR
case m.variable when 'Q2_12' then 1 else 0 end !=0 OR
case m.variable when 'Q2_13' then 1 else 0 end !=0 OR
case m.variable when 'Q2_14' then 1 else 0 end  !=0 OR
case m.variable when 'Q2_15' then 1 else 0 end  !=0 OR
case m.variable when 'Q2_16' then 1 else 0 end  !=0 OR
case m.variable when 'Q2_17' then 1 else 0 end  !=0 OR
case m.variable when 'Q2_18' then 1 else 0 end !=0 OR
case m.variable when 'Q2_19' then 1 else 0 end  !=0 OR
case m.variable when 'Q3_20' then 1 else 0 end !=0 OR
case m.variable when 'Q3_21' then 1 else 0 end !=0 OR
case m.variable when 'Q3_22' then 1 else 0 end !=0 OR
case m.variable when 'Q3_23' then 1 else 0 end  !=0 OR
case m.variable when 'Q3_24' then 1 else 0 end !=0 or

case b.variable when 'Q2_9' then 1 else 0 end !=0 OR
case b.variable when 'Q2_10' then 1 else 0 end !=0 OR
case b.variable when 'Q2_11' then 1 else 0 end !=0 OR
case b.variable when 'Q2_12' then 1 else 0 end !=0 OR
case b.variable when 'Q2_13' then 1 else 0 end !=0 OR
case b.variable when 'Q2_15' then 1 else 0 end  !=0 OR
case b.variable when 'Q2_14' then 1 else 0 end  !=0 OR
case b.variable when 'Q2_16' then 1 else 0 end  !=0 OR
case b.variable when 'Q2_17' then 1 else 0 end  !=0 OR
case b.variable when 'Q2_18' then 1 else 0 end  !=0 OR
case b.variable when 'Q2_19' then 1 else 0 end  !=0 OR
case b.variable when 'Q3_20' then 1 else 0 end  !=0 OR
case b.variable when 'Q3_21' then 1 else 0 end  !=0 OR
case b.variable when 'Q3_22' then 1 else 0 end  !=0 OR
case b.variable when 'Q3_23' then 1 else 0 end  !=0 OR
case b.variable when 'Q3_24' then 1 else 0 end  !=0 
)


group by 
co.userid, isnull(m.year2,0), 
q.district,
n.institutionName, c.orgname, cast(n.bedscode as float)





UNION


select 
2, c.orgname,co.userid, n.institutionName,
q.district,  isnull(m.year2,0),
max(isNull(mo,0)) as mmon, 
DateName( month , DateAdd( month , max(isNull(mo,0)) , 0 ) - 1 ) as mmon2,
case sum(case m.variable when 'Q2_9' then 1 else 0 end) when 0 then 0 else 1 end as Q2_9,
case sum(case m.variable when 'Q2_10' then 1 else 0 end) when 0 then 0 else 1 end as Q2_10,
case sum(case m.variable when 'Q2_11' then 1 else 0 end) when 0 then 0 else 1 end as Q2_11,
case sum(case m.variable when 'Q2_12' then 1 else 0 end) when 0 then 0 else 1 end as Q2_12,
case sum(case m.variable when 'Q2_13' then 1 else 0 end) when 0 then 0 else 1 end as Q2_13,
case sum(case m.variable when 'Q2_14' then 1 else 0 end) when 0 then 0 else 1 end as Q2_14,
case sum(case m.variable when 'Q2_15' then 1 else 0 end) when 0 then 0 else 1 end as Q2_15,
case sum(case m.variable when 'Q2_16' then 1 else 0 end) when 0 then 0 else 1 end as Q2_16,
case sum(case m.variable when 'Q2_17' then 1 else 0 end) when 0 then 0 else 1 end as Q2_17,
case sum(case m.variable when 'Q2_18' then 1 else 0 end) when 0 then 0 else 1 end as Q2_18,
case sum(case m.variable when 'Q2_19' then 1 else 0 end) when 0 then 0 else 1 end as Q2_19,
case sum(case m.variable when 'Q3_20' then 1 else 0 end) when 0 then 0 else 1 end as Q3_20,
case sum(case m.variable when 'Q3_21' then 1 else 0 end) when 0 then 0 else 1 end as Q3_21,
case sum(case m.variable when 'Q3_22' then 1 else 0 end) when 0 then 0 else 1 end as Q3_22,
case sum(case m.variable when 'Q3_23' then 1 else 0 end) when 0 then 0 else 1 end as Q3_23,
case sum(case m.variable when 'Q3_24' then 1 else 0 end) when 0 then 0 else 1 end as Q3_24,
case sum(case m.variable when 'Q4_25' then 1 else 0 end) when 0 then 0 else 1 end as Q4_25,
case sum(case m.variable when 'Q4_26' then 1 else 0 end) when 0 then 0 else 1 end as Q4_26,
case sum(case m.variable when 'Q4_27' then 1 else 0 end) when 0 then 0 else 1 end as Q4_27,
case sum(case m.variable when 'Q4_28' then 1 else 0 end) when 0 then 0 else 1 end as Q4_28,
case sum(case m.variable when 'Q4_29' then 1 else 0 end) when 0 then 0 else 1 end as Q4_29,
case sum(case m.variable when 'Q4_30' then 1 else 0 end) when 0 then 0 else 1 end as Q4_30,
case sum(case m.variable when 'Q4_31' then 1 else 0 end) when 0 then 0 else 1 end as Q4_31,
case sum(case m.variable when 'Q4_32' then 1 else 0 end) when 0 then 0 else 1 end as Q4_32,
case sum(case m.variable when 'Q4_33' then 1 else 0 end) when 0 then 0 else 1 end as Q4_33,
case sum(case m.variable when 'Q4_34' then 1 else 0 end) when 0 then 0 else 1 end as Q4_34,
case sum(case m.variable when 'Q4_35' then 1 else 0 end) when 0 then 0 else 1 end as Q4_35,
case sum(case m.variable when 'Q5_36' then 1 else 0 end) when 0 then 0 else 1 end as Q5_36,
case sum(case m.variable when 'Q5_37' then 1 else 0 end) when 0 then 0 else 1 end as Q5_37,
case sum(case m.variable when 'Q5_38' then 1 else 0 end) when 0 then 0 else 1 end as Q5_38,
case sum(case m.variable when 'Q6_39' then 1 else 0 end) when 0 then 0 else 1 end as Q6_39,
case sum(case m.variable when 'Q6_40' then 1 else 0 end) when 0 then 0 else 1 end as Q6_40,
case sum(case m.variable when 'Q6_41' then 1 else 0 end) when 0 then 0 else 1 end as Q6_41,
case sum(case m.variable when 'Q7_42' then 1 else 0 end) when 0 then 0 else 1 end as Q7_42,
case sum(case m.variable when 'Q7_43' then 1 else 0 end) when 0 then 0 else 1 end as Q7_43,
case sum(case m.variable when 'Q7_44' then 1 else 0 end) when 0 then 0 else 1 end as Q7_44,
case sum(case m.variable when 'Q7_45' then 1 else 0 end) when 0 then 0 else 1 end as Q7_45,
case sum(case m.variable when 'Q7_46' then 1 else 0 end) when 0 then 0 else 1 end as Q7_46,
case sum(case m.variable when 'Q7_47' then 1 else 0 end) when 0 then 0 else 1 end as Q7_47,

case sum(case b.variable when 'Q2_9' then 1 else 0 end) when 0 then 0 else 1 end as bQ2_9,
case sum(case b.variable when 'Q2_10' then 1 else 0 end) when 0 then 0 else 1 end as bQ2_10,
case sum(case b.variable when 'Q2_11' then 1 else 0 end) when 0 then 0 else 1 end as bQ2_11,
case sum(case b.variable when 'Q2_12' then 1 else 0 end) when 0 then 0 else 1 end as bQ2_12,
case sum(case b.variable when 'Q2_13' then 1 else 0 end) when 0 then 0 else 1 end as bQ2_13,
case sum(case b.variable when 'Q2_14' then 1 else 0 end) when 0 then 0 else 1 end as bQ2_14,
case sum(case b.variable when 'Q2_15' then 1 else 0 end) when 0 then 0 else 1 end as bQ2_15,
case sum(case b.variable when 'Q2_16' then 1 else 0 end) when 0 then 0 else 1 end as bQ2_16,
case sum(case b.variable when 'Q2_17' then 1 else 0 end) when 0 then 0 else 1 end as bQ2_17,
case sum(case b.variable when 'Q2_18' then 1 else 0 end) when 0 then 0 else 1 end as bQ2_18,
case sum(case b.variable when 'Q2_19' then 1 else 0 end) when 0 then 0 else 1 end as bQ2_19,
case sum(case b.variable when 'Q3_20' then 1 else 0 end) when 0 then 0 else 1 end as bQ3_20,
case sum(case b.variable when 'Q3_21' then 1 else 0 end) when 0 then 0 else 1 end as bQ3_21,
case sum(case b.variable when 'Q3_22' then 1 else 0 end) when 0 then 0 else 1 end as bQ3_22,
case sum(case b.variable when 'Q3_23' then 1 else 0 end) when 0 then 0 else 1 end as bQ3_23,
case sum(case b.variable when 'Q3_24' then 1 else 0 end) when 0 then 0 else 1 end as bQ3_24,
case sum(case b.variable when 'Q4_25' then 1 else 0 end) when 0 then 0 else 1 end as bQ4_25,
case sum(case b.variable when 'Q4_26' then 1 else 0 end) when 0 then 0 else 1 end as bQ4_26,
case sum(case b.variable when 'Q4_27' then 1 else 0 end) when 0 then 0 else 1 end as bQ4_27,
case sum(case b.variable when 'Q4_28' then 1 else 0 end) when 0 then 0 else 1 end as bQ4_28,
case sum(case b.variable when 'Q4_29' then 1 else 0 end) when 0 then 0 else 1 end as bQ4_29,
case sum(case b.variable when 'Q4_30' then 1 else 0 end) when 0 then 0 else 1 end as bQ4_30,
case sum(case b.variable when 'Q4_31' then 1 else 0 end) when 0 then 0 else 1 end as bQ4_31,
case sum(case b.variable when 'Q4_32' then 1 else 0 end) when 0 then 0 else 1 end as bQ4_32,
case sum(case b.variable when 'Q4_33' then 1 else 0 end) when 0 then 0 else 1 end as bQ4_33,
case sum(case b.variable when 'Q4_34' then 1 else 0 end) when 0 then 0 else 1 end as bQ4_34,
case sum(case b.variable when 'Q4_35' then 1 else 0 end) when 0 then 0 else 1 end as bQ4_35,
case sum(case b.variable when 'Q5_36' then 1 else 0 end) when 0 then 0 else 1 end as bQ5_36,
case sum(case b.variable when 'Q5_37' then 1 else 0 end) when 0 then 0 else 1 end as bQ5_37,
case sum(case b.variable when 'Q5_38' then 1 else 0 end) when 0 then 0 else 1 end as bQ5_38,
case sum(case b.variable when 'Q6_39' then 1 else 0 end) when 0 then 0 else 1 end as bQ6_39,
case sum(case b.variable when 'Q6_40' then 1 else 0 end) when 0 then 0 else 1 end as bQ6_40,
case sum(case b.variable when 'Q6_41' then 1 else 0 end) when 0 then 0 else 1 end as bQ6_41,
case sum(case b.variable when 'Q7_42' then 1 else 0 end) when 0 then 0 else 1 end as bQ7_42,
case sum(case b.variable when 'Q7_43' then 1 else 0 end) when 0 then 0 else 1 end as bQ7_43,
case sum(case b.variable when 'Q7_44' then 1 else 0 end) when 0 then 0 else 1 end as bQ7_44,
case sum(case b.variable when 'Q7_45' then 1 else 0 end) when 0 then 0 else 1 end as bQ7_45,
case sum(case b.variable when 'Q7_46' then 1 else 0 end) when 0 then 0 else 1 end as bQ7_46,
case sum(case b.variable when 'Q7_47' then 1 else 0 end) when 0 then 0 else 1 end as bQ7_47,

cast(n.bedscode as float) as bedscode


from 
collaborators co,
nysed_school n,
contact c,
dbo.v_spDistricts q 
left outer join 
sp_monthly m on  q.district=m.district and q.userid =m.userid and m.year2 <=#session.fy#
and
(
case m.variable when 'Q4_25' then 1 else 0 end  !=0 OR
case m.variable when 'Q4_26' then 1 else 0 end !=0 OR
case m.variable when 'Q4_27' then 1 else 0 end  !=0 OR
case m.variable when 'Q4_28' then 1 else 0 end  !=0 OR
case m.variable when 'Q4_29' then 1 else 0 end !=0 OR
case m.variable when 'Q4_30' then 1 else 0 end  !=0 OR
case m.variable when 'Q4_31' then 1 else 0 end  !=0 OR
case m.variable when 'Q4_32' then 1 else 0 end  !=0 OR
case m.variable when 'Q4_33' then 1 else 0 end !=0 OR
case m.variable when 'Q4_34' then 1 else 0 end !=0 OR
case m.variable when 'Q4_35' then 1 else 0 end !=0 OR
case m.variable when 'Q5_36' then 1 else 0 end !=0 OR
case m.variable when 'Q5_37' then 1 else 0 end !=0 OR
case m.variable when 'Q5_38' then 1 else 0 end !=0 )
left outer join 
sp_baseline b on  q.district=b.district and q.userid =b.userid and b.year2 <=#session.fy#
and
(
case b.variable when 'Q4_25' then 1 else 0 end !=0 OR
case b.variable when 'Q4_26' then 1 else 0 end !=0 OR
case b.variable when 'Q4_27' then 1 else 0 end !=0 OR
case b.variable when 'Q4_28' then 1 else 0 end !=0 OR
case b.variable when 'Q4_29' then 1 else 0 end  !=0 OR
case b.variable when 'Q4_30' then 1 else 0 end  !=0 OR
case b.variable when 'Q4_31' then 1 else 0 end  !=0 OR
case b.variable when 'Q4_32' then 1 else 0 end  !=0 OR
case b.variable when 'Q4_33' then 1 else 0 end  !=0 OR
case b.variable when 'Q4_34' then 1 else 0 end !=0 OR
case b.variable when 'Q4_35' then 1 else 0 end  !=0 OR
case b.variable when 'Q5_36' then 1 else 0 end  !=0 OR
case b.variable when 'Q5_37' then 1 else 0 end  !=0 OR
case b.variable when 'Q5_38' then 1 else 0 end  !=0
)
where 
isnull(c.coordemail, '') not like '%rti.org' and
c.userid=co.userid and
 ((rtrim(q.district) = n.district and n.bedscode like '%0000')  OR rtrim(q.district) = n.bedscode) 
and (q.district = co.district or q.district = co.school)
and co.userid = c.userid
and c.userid = q.userid
<!--- and c.coordemail not like '%rti.org' --->
<cfif isdefined("form.cm") and form.cm is not 'all'>
	and c.userid in (select userid from contact where cmanager = '#form.cm#')	
</cfif>
<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid='#form.partner#'
</cfif>
and (co.SCHOOL='999' OR ISNULL(co.SODISTRICT,0)=1) AND ISNULL(co.DEL,0) = 0
and
(
case m.variable when 'Q4_25' then 1 else 0 end  !=0 OR
case m.variable when 'Q4_26' then 1 else 0 end !=0 OR
case m.variable when 'Q4_27' then 1 else 0 end  !=0 OR
case m.variable when 'Q4_28' then 1 else 0 end  !=0 OR
case m.variable when 'Q4_29' then 1 else 0 end !=0 OR
case m.variable when 'Q4_30' then 1 else 0 end  !=0 OR
case m.variable when 'Q4_31' then 1 else 0 end  !=0 OR
case m.variable when 'Q4_32' then 1 else 0 end  !=0 OR
case m.variable when 'Q4_33' then 1 else 0 end !=0 OR
case m.variable when 'Q4_34' then 1 else 0 end !=0 OR
case m.variable when 'Q4_35' then 1 else 0 end !=0 OR
case m.variable when 'Q5_36' then 1 else 0 end !=0 OR
case m.variable when 'Q5_37' then 1 else 0 end !=0 OR
case m.variable when 'Q5_38' then 1 else 0 end !=0  or
case b.variable when 'Q4_25' then 1 else 0 end !=0 OR
case b.variable when 'Q4_26' then 1 else 0 end !=0 OR
case b.variable when 'Q4_27' then 1 else 0 end !=0 OR
case b.variable when 'Q4_28' then 1 else 0 end !=0 OR
case b.variable when 'Q4_29' then 1 else 0 end  !=0 OR
case b.variable when 'Q4_30' then 1 else 0 end  !=0 OR
case b.variable when 'Q4_31' then 1 else 0 end  !=0 OR
case b.variable when 'Q4_32' then 1 else 0 end  !=0 OR
case b.variable when 'Q4_33' then 1 else 0 end  !=0 OR
case b.variable when 'Q4_34' then 1 else 0 end !=0 OR
case b.variable when 'Q4_35' then 1 else 0 end  !=0 OR
case b.variable when 'Q5_36' then 1 else 0 end  !=0 OR
case b.variable when 'Q5_37' then 1 else 0 end  !=0 OR
case b.variable when 'Q5_38' then 1 else 0 end  !=0
)

group by 
co.userid,  isnull(m.year2,0),
q.district,
n.institutionName, c.orgname, cast(n.bedscode as float)



UNION


select 
3, c.orgname,co.userid, n.institutionName,
q.district,  isnull(m.year2,0),
max(isNull(mo,0)) as mmon, 
DateName( month , DateAdd( month , max(isNull(mo,0)) , 0 ) - 1 ) as mmon2,
case sum(case m.variable when 'Q2_9' then 1 else 0 end) when 0 then 0 else 1 end as Q2_9,
case sum(case m.variable when 'Q2_10' then 1 else 0 end) when 0 then 0 else 1 end as Q2_10,
case sum(case m.variable when 'Q2_11' then 1 else 0 end) when 0 then 0 else 1 end as Q2_11,
case sum(case m.variable when 'Q2_12' then 1 else 0 end) when 0 then 0 else 1 end as Q2_12,
case sum(case m.variable when 'Q2_13' then 1 else 0 end) when 0 then 0 else 1 end as Q2_13,
case sum(case m.variable when 'Q2_14' then 1 else 0 end) when 0 then 0 else 1 end as Q2_14,
case sum(case m.variable when 'Q2_15' then 1 else 0 end) when 0 then 0 else 1 end as Q2_15,
case sum(case m.variable when 'Q2_16' then 1 else 0 end) when 0 then 0 else 1 end as Q2_16,
case sum(case m.variable when 'Q2_17' then 1 else 0 end) when 0 then 0 else 1 end as Q2_17,
case sum(case m.variable when 'Q2_18' then 1 else 0 end) when 0 then 0 else 1 end as Q2_18,
case sum(case m.variable when 'Q2_19' then 1 else 0 end) when 0 then 0 else 1 end as Q2_19,

case sum(case m.variable when 'Q3_20' then 1 else 0 end) when 0 then 0 else 1 end as Q3_20,
case sum(case m.variable when 'Q3_21' then 1 else 0 end) when 0 then 0 else 1 end as Q3_21,
case sum(case m.variable when 'Q3_22' then 1 else 0 end) when 0 then 0 else 1 end as Q3_22,
case sum(case m.variable when 'Q3_23' then 1 else 0 end) when 0 then 0 else 1 end as Q3_23,
case sum(case m.variable when 'Q3_24' then 1 else 0 end) when 0 then 0 else 1 end as Q3_24,

case sum(case m.variable when 'Q4_25' then 1 else 0 end) when 0 then 0 else 1 end as Q4_25,
case sum(case m.variable when 'Q4_26' then 1 else 0 end) when 0 then 0 else 1 end as Q4_26,
case sum(case m.variable when 'Q4_27' then 1 else 0 end) when 0 then 0 else 1 end as Q4_27,
case sum(case m.variable when 'Q4_28' then 1 else 0 end) when 0 then 0 else 1 end as Q4_28,
case sum(case m.variable when 'Q4_29' then 1 else 0 end) when 0 then 0 else 1 end as Q4_29,
case sum(case m.variable when 'Q4_30' then 1 else 0 end) when 0 then 0 else 1 end as Q4_30,
case sum(case m.variable when 'Q4_31' then 1 else 0 end) when 0 then 0 else 1 end as Q4_31,
case sum(case m.variable when 'Q4_32' then 1 else 0 end) when 0 then 0 else 1 end as Q4_32,
case sum(case m.variable when 'Q4_33' then 1 else 0 end) when 0 then 0 else 1 end as Q4_33,
case sum(case m.variable when 'Q4_34' then 1 else 0 end) when 0 then 0 else 1 end as Q4_34,
case sum(case m.variable when 'Q4_35' then 1 else 0 end) when 0 then 0 else 1 end as Q4_35,

case sum(case m.variable when 'Q5_36' then 1 else 0 end) when 0 then 0 else 1 end as Q5_36,
case sum(case m.variable when 'Q5_37' then 1 else 0 end) when 0 then 0 else 1 end as Q5_37,
case sum(case m.variable when 'Q5_38' then 1 else 0 end) when 0 then 0 else 1 end as Q5_38,
case sum(case m.variable when 'Q6_39' then 1 else 0 end) when 0 then 0 else 1 end as Q6_39,
case sum(case m.variable when 'Q6_40' then 1 else 0 end) when 0 then 0 else 1 end as Q6_40,
case sum(case m.variable when 'Q6_41' then 1 else 0 end) when 0 then 0 else 1 end as Q6_41,

case sum(case m.variable when 'Q7_42' then 1 else 0 end) when 0 then 0 else 1 end as Q7_42,
case sum(case m.variable when 'Q7_43' then 1 else 0 end) when 0 then 0 else 1 end as Q7_43,
case sum(case m.variable when 'Q7_44' then 1 else 0 end) when 0 then 0 else 1 end as Q7_44,
case sum(case m.variable when 'Q7_45' then 1 else 0 end) when 0 then 0 else 1 end as Q7_45,
case sum(case m.variable when 'Q7_46' then 1 else 0 end) when 0 then 0 else 1 end as Q7_46,
case sum(case m.variable when 'Q7_47' then 1 else 0 end) when 0 then 0 else 1 end as Q7_47,

case sum(case b.variable when 'Q2_9' then 1 else 0 end) when 0 then 0 else 1 end as bQ2_9,
case sum(case b.variable when 'Q2_10' then 1 else 0 end) when 0 then 0 else 1 end as bQ2_10,
case sum(case b.variable when 'Q2_11' then 1 else 0 end) when 0 then 0 else 1 end as bQ2_11,
case sum(case b.variable when 'Q2_12' then 1 else 0 end) when 0 then 0 else 1 end as bQ2_12,
case sum(case b.variable when 'Q2_13' then 1 else 0 end) when 0 then 0 else 1 end as bQ2_13,
case sum(case b.variable when 'Q2_14' then 1 else 0 end) when 0 then 0 else 1 end as bQ2_14,
case sum(case b.variable when 'Q2_15' then 1 else 0 end) when 0 then 0 else 1 end as bQ2_15,
case sum(case b.variable when 'Q2_16' then 1 else 0 end) when 0 then 0 else 1 end as bQ2_16,
case sum(case b.variable when 'Q2_17' then 1 else 0 end) when 0 then 0 else 1 end as bQ2_17,
case sum(case b.variable when 'Q2_18' then 1 else 0 end) when 0 then 0 else 1 end as bQ2_18,
case sum(case b.variable when 'Q2_19' then 1 else 0 end) when 0 then 0 else 1 end as bQ2_19,
case sum(case b.variable when 'Q3_20' then 1 else 0 end) when 0 then 0 else 1 end as bQ3_20,

case sum(case b.variable when 'Q3_21' then 1 else 0 end) when 0 then 0 else 1 end as bQ3_21,
case sum(case b.variable when 'Q3_22' then 1 else 0 end) when 0 then 0 else 1 end as bQ3_22,
case sum(case b.variable when 'Q3_23' then 1 else 0 end) when 0 then 0 else 1 end as bQ3_23,
case sum(case b.variable when 'Q3_24' then 1 else 0 end) when 0 then 0 else 1 end as bQ3_24,
case sum(case b.variable when 'Q4_25' then 1 else 0 end) when 0 then 0 else 1 end as bQ4_25,

case sum(case b.variable when 'Q4_26' then 1 else 0 end) when 0 then 0 else 1 end as bQ4_26,
case sum(case b.variable when 'Q4_27' then 1 else 0 end) when 0 then 0 else 1 end as bQ4_27,
case sum(case b.variable when 'Q4_28' then 1 else 0 end) when 0 then 0 else 1 end as bQ4_28,
case sum(case b.variable when 'Q4_29' then 1 else 0 end) when 0 then 0 else 1 end as bQ4_29,
case sum(case b.variable when 'Q4_30' then 1 else 0 end) when 0 then 0 else 1 end as bQ4_30,
case sum(case b.variable when 'Q4_31' then 1 else 0 end) when 0 then 0 else 1 end as bQ4_31,
case sum(case b.variable when 'Q4_32' then 1 else 0 end) when 0 then 0 else 1 end as bQ4_32,
case sum(case b.variable when 'Q4_33' then 1 else 0 end) when 0 then 0 else 1 end as bQ4_33,
case sum(case b.variable when 'Q4_34' then 1 else 0 end) when 0 then 0 else 1 end as bQ4_34,
case sum(case b.variable when 'Q4_35' then 1 else 0 end) when 0 then 0 else 1 end as bQ4_35,

case sum(case b.variable when 'Q5_36' then 1 else 0 end) when 0 then 0 else 1 end as bQ5_36,
case sum(case b.variable when 'Q5_37' then 1 else 0 end) when 0 then 0 else 1 end as bQ5_37,
case sum(case b.variable when 'Q5_38' then 1 else 0 end) when 0 then 0 else 1 end as bQ5_38,

case sum(case b.variable when 'Q6_39' then 1 else 0 end) when 0 then 0 else 1 end as bQ6_39,
case sum(case b.variable when 'Q6_40' then 1 else 0 end) when 0 then 0 else 1 end as bQ6_40,
case sum(case b.variable when 'Q6_41' then 1 else 0 end) when 0 then 0 else 1 end as bQ6_41,

case sum(case b.variable when 'Q7_42' then 1 else 0 end) when 0 then 0 else 1 end as bQ7_42,
case sum(case b.variable when 'Q7_43' then 1 else 0 end) when 0 then 0 else 1 end as bQ7_43,
case sum(case b.variable when 'Q7_44' then 1 else 0 end) when 0 then 0 else 1 end as bQ7_44,
case sum(case b.variable when 'Q7_45' then 1 else 0 end) when 0 then 0 else 1 end as bQ7_45,
case sum(case b.variable when 'Q7_46' then 1 else 0 end) when 0 then 0 else 1 end as bQ7_46,
case sum(case b.variable when 'Q7_47' then 1 else 0 end) when 0 then 0 else 1 end as bQ7_47,

cast(n.bedscode as float) as bedscode


from 
collaborators co,
nysed_school n,
contact c,
dbo.v_spDistricts q 
left outer join 
sp_monthly m on  q.district=m.district and q.userid =m.userid and m.year2 <=#session.fy#
and (
case m.variable when 'Q6_39' then 1 else 0 end !=0 OR
case m.variable when 'Q6_40' then 1 else 0 end !=0 OR
case m.variable when 'Q6_41' then 1 else 0 end  !=0 OR

case m.variable when 'Q7_42' then 1 else 0 end !=0 OR
case m.variable when 'Q7_43' then 1 else 0 end !=0 OR
case m.variable when 'Q7_44' then 1 else 0 end  !=0 OR
case m.variable when 'Q7_45' then 1 else 0 end  !=0 OR
case m.variable when 'Q7_46' then 1 else 0 end !=0 OR
case m.variable when 'Q7_47' then 1 else 0 end !=0)
left outer join 
sp_baseline b on  q.district=b.district and q.userid =b.userid and b.year2 <=#session.fy#
 and 
(case b.variable when 'Q6_39' then 1 else 0 end !=0 OR
case b.variable when 'Q6_40' then 1 else 0 end !=0 OR
case b.variable when 'Q6_41' then 1 else 0 end !=0 OR

case b.variable when 'Q7_42' then 1 else 0 end  !=0 OR
case b.variable when 'Q7_43' then 1 else 0 end  !=0 OR
case b.variable when 'Q7_44' then 1 else 0 end  !=0 OR
case b.variable when 'Q7_45' then 1 else 0 end  !=0 OR
case b.variable when 'Q7_46' then 1 else 0 end  !=0 OR
case b.variable when 'Q7_47' then 1 else 0 end !=0 
)
where 
isnull(c.coordemail, '') not like '%rti.org' and 
c.userid=co.userid and
 ((rtrim(q.district) = n.district and n.bedscode like '%0000')  OR rtrim(q.district) = n.bedscode) 
and (q.district = co.district or q.district = co.school)
and co.userid = c.userid
and c.userid = q.userid
<!--- and c.coordemail not like '%rti.org' --->
<cfif isdefined("form.cm") and form.cm is not 'all'>
	and c.userid in (select userid from contact where cmanager = '#form.cm#')	
</cfif>
<cfif isdefined("form.partner") and form.partner is not 'all'>
	and c.userid='#form.partner#'
</cfif>
and (co.SCHOOL='999' OR ISNULL(co.SODISTRICT,0)=1) AND ISNULL(co.DEL,0) = 0
and
 (
case m.variable when 'Q6_39' then 1 else 0 end !=0 OR
case m.variable when 'Q6_40' then 1 else 0 end !=0 OR
case m.variable when 'Q6_41' then 1 else 0 end  !=0 OR

case m.variable when 'Q7_42' then 1 else 0 end !=0 OR
case m.variable when 'Q7_43' then 1 else 0 end !=0 OR
case m.variable when 'Q7_44' then 1 else 0 end  !=0 OR
case m.variable when 'Q7_45' then 1 else 0 end  !=0 OR
case m.variable when 'Q7_46' then 1 else 0 end !=0 OR
case m.variable when 'Q7_47' then 1 else 0 end !=0 OR
case b.variable when 'Q6_39' then 1 else 0 end !=0 OR
case b.variable when 'Q6_40' then 1 else 0 end !=0 OR
case b.variable when 'Q6_41' then 1 else 0 end !=0 OR

case b.variable when 'Q7_42' then 1 else 0 end  !=0 OR
case b.variable when 'Q7_43' then 1 else 0 end  !=0 OR
case b.variable when 'Q7_44' then 1 else 0 end  !=0 OR
case b.variable when 'Q7_45' then 1 else 0 end  !=0 OR
case b.variable when 'Q7_46' then 1 else 0 end  !=0 OR
case b.variable when 'Q7_47' then 1 else 0 end !=0 
)


group by 
co.userid, isnull(m.year2,0),
q.district,
n.institutionName, c.orgname, cast(n.bedscode as float)


order by 2,1,4







		
		
		
		
	<!--- 	
	select 1 as sect,* from dbo.v_SPPolRpt
--	where (q2_9 != 0 OR q2_10 !=0 or q2_11 !=0 or q2_12 !=0 or q2_13 !=0 or q2_14 !=0 or q2_15 !=0 or q2_16!=0 or q2_17 !=0 or q2_18 !=0 or q2_19 !=0 or q3_20 !=0  or q3_21 !=0  or q3_22 !=0  or q3_23 !=0  or q3_24 !=0 
--or bq2_9 != 0 OR bq2_10 !=0 or bq2_11 !=0 or bq2_12 !=0 or bq2_13 !=0 or bq2_14 !=0 or bq2_15 !=0 or bq2_16!=0 or bq2_17 !=0 or bq2_18 !=0 or bq2_19 !=0 or bq3_20 !=0  or bq3_21 !=0  or bq3_22 !=0  or bq3_23 !=0  or bq3_24 !=0)
union
select 2,* from dbo.v_SPPolRpt
--where (q4_25  != 0 OR q4_26  != 0 OR q4_27  != 0 OR q4_28  != 0 OR q4_29  != 0 OR q4_30  != 0 OR q4_31  != 0 OR q4_32  != 0 OR q4_33  != 0 OR q4_34  != 0 OR q4_35  != 0 OR q5_36  != 0 OR q5_37  != 0 OR q5_38 != 0
--or bq4_25  != 0 OR bq4_26  != 0 OR bq4_27  != 0 OR bq4_28  != 0 OR bq4_29  != 0 OR bq4_30  != 0 OR bq4_31  != 0 OR bq4_32  != 0 OR bq4_33  != 0 OR bq4_34  != 0 OR bq4_35  != 0 OR bq5_36  != 0 OR bq5_37  != 0 OR bq5_38 != 0)
union
select 3,* from dbo.v_SPPolRpt
--where (q6_39 != 0 OR q6_40 != 0 OR q6_41 != 0 OR q7_42 != 0 OR q7_43 != 0 OR q7_44 != 0 OR q7_45 != 0 OR q7_46 != 0 OR q7_47 != 0 OR
--bq6_39 != 0 OR bq6_40 != 0 OR bq6_41 != 0 OR bq7_42 != 0 OR bq7_43 != 0 OR bq7_44 != 0 OR bq7_45 != 0 OR bq7_46 != 0 OR bq7_47 != 0)
order by 2,1,3
 --->



</cfquery>

<cfreport template="./reports/SP_Pol2011.cfr"  format = "pdf" query="conmon">
		<CFREPORTPARAM name=Year2 VALUE=#session.fy#>		
		<CFREPORTPARAM name=Objective VALUE="All">
		<CFREPORTPARAM name=ReportName VALUE="PP">
		<CFREPORTPARAM name=StMonth VALUE="1">
		<CFREPORTPARAM name=reportCM VALUE="#form.CM#"> 
		<CFREPORTPARAM name=PartnerName VALUE="#form.partner#">  
		<!--- <CFREPORTPARAM name=reportCM VALUE="All"> 
		<CFREPORTPARAM name=PartnerName VALUE="All">--->
		<!--- <CFREPORTPARAM name=Area VALUE="1"> --->
</cfreport>  
</cfcase>

<cfcase value="666">
	
<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="monthact">
select * from contact 
where partnertype = 4  and userid <> 'dplotner' and (userid in (select userid from monthly where year2 = '#session.fy#')
or userid in (select userid from sp_mon3 m inner join months mm on m.mon = mm.mon_num and m.year2 = mm.year2 where m.year2 = '#session.fy#' ))  <!--- and userid <> 'test_sp' --->
<cfif isdefined("form.partner") and form.partner is not 'all'>
	and userid='#form.partner#'
</cfif>
<cfif isdefined("form.cm") and form.cm is not 'all'>
	and userid in (select userid from contact where cmanager = '#form.cm#')	
</cfif>
and isnull(coordemail, '') not like '%rti.org'

order by orgname
</cfquery>


<cfreport template="./reports/spmonthact2.cfr"  format = "pdf" query="monthact">
		<CFREPORTPARAM name=Year2 VALUE=#session.fy#>
								<CFREPORTPARAM name=Monthrange VALUE="#Monthrange6#">

<CFREPORTPARAM name=Objective VALUE="All">
		<CFREPORTPARAM name=ReportName VALUE="PP">
		<CFREPORTPARAM name=EndMonth VALUE="#form.endmonth#">
		<CFREPORTPARAM name=StMonth VALUE="#form.stmonth#">
		<cfif isdefined("form.cm")>
				<CFREPORTPARAM name=reportCM VALUE="#form.CM#">
				<cfelse>
				<CFREPORTPARAM name=reportCM VALUE="#monthact.cmanager#">
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
</cfreport>  
</cfcase>

</cfswitch>