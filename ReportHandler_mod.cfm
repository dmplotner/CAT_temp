<!--- <cfif session.modality EQ 4>
<cfset session.cntMan = 1>
	<cflocation addtoken="yes" url="UNAVAILABLE.cfm">
<!---<cfelseif (session.def_fy EQ session.fy) >
	<cflocation addtoken="yes" url="noFuture.cfm">--->
</cfif> --->
<cfif session.userid NEQ "dplotner" and session.userid NEQ "nsarris" and session.userid NEQ "aal07" and session.userid NEQ "bmarkatos">
<cflocation addtoken="true" url="UNAVAILABLE.CFM">
<cfelse>
<cflocation addtoken="true" url="reporthandler_mod2.CFM">
</cfif>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
<title>CAT</title>

<cfinclude template="CATstruct.cfm">

<cfif isDefined("url.NYP")>
	<cfset session.rptyr=session.fy+1>
<cfelse>
	<cfset session.rptyr=session.fy>
</cfif>

<table align="left" cellpadding="10" cellspacing="0" border="0" class="box" width="50%">	

<script language="JavaScript">
function resetPartner(){
if(document.fReportHandler.partner != undefined){
document.fReportHandler.partner.value="ALL";
}
document.fReportHandler.target="_self";
document.fReportHandler.action="reportHandler_mod.cfm<cfoutput>?#session.urltoken#</cfoutput>";
document.fReportHandler.submit();
}

function resetStrategy(){
if(document.fReportHandler.strategy != undefined){
document.fReportHandler.strategy.value="ALL";
}
document.fReportHandler.target="_self";
document.fReportHandler.action="reportHandler_mod.cfm<cfoutput>?#session.urltoken#</cfoutput>";
document.fReportHandler.submit();
}

function resetGoal(){
if(document.fReportHandler.objective != undefined){
if(document.fReportHandler.goal == "ALL"){
document.fReportHandler.objective.value="NA";
}
}
document.fReportHandler.target="_self";
document.fReportHandler.action="reportHandler_mod.cfm<cfoutput>?#session.urltoken#</cfoutput>";

document.fReportHandler.submit();
}

function chkSubmit(){

document.fReportHandler.target="_blank";
document.fReportHandler.action="rpt_switch.cfm<cfoutput>?#session.urltoken#</cfoutput>";
document.fReportHandler.submit();
}

function setType(){
<!--- document.fReportHandler.target="_top"--->
 document.fReportHandler.target="_self";
document.fReportHandler.action="reportHandler_mod.cfm<cfoutput>?#session.urltoken#</cfoutput>";
document.fReportHandler.submit();
}


</script>
<cfparam name="reportuser" default="#session.userid#">


<cfquery datasource="#application.DataSource#"  		 
	password="#Application.db_password#"  		
	username="#Application.db_username#" name="QuserArea">
select area 
from security 
where userid=<cfif isDefined("session.origUserID")>'#session.origUserID#'<cfelse>'#session.userid#'</cfif>
</cfquery>



<cfquery datasource="#application.DataSource#"   		 
	password="#Application.db_password#"  		
	username="#Application.db_username#" name="Qarea">
	select distinct
	r.region, r.num
	from area a, region r
	where a.year2=#session.fy#
	<cfif session.regionManage EQ "0" OR session.statemanage EQ "0" AND QuserArea.area NEQ "0">
	and a.num = '#QuserArea.area#'
	</cfif>
	<cfif session.cntMan EQ 1 AND SESSION.CessMan EQ "0">
	and a.num in 
	(select distinct a.num from area as a, contact c
where a.num=c.area and c.cmanager = <cfif isDefined("session.origUserID")>'#session.origUserID#'<cfelse>'#session.userid#'</cfif>)
	
	</cfif>
	and a.year2=r.year2
	and a.region = r.num	
	order by 1	
		
	<!--- select distinct
	r.region, r.num
	from area a, region r
	where a.year2=#session.fy#
	<cfif session.cntMan EQ  "0" OR session.regionManage EQ "0" OR session.statemanage EQ "0" AND QuserArea.area NEQ "0">
	and a.num = '#QuserArea.area#'
	</cfif>
	<cfif session.cntMan EQ 1 <!--- AND SESSION.CESSmAN eq 0 --->>
	and a.num in 
	(select distinct a.num from area as a, contact c
where a.num=c.area and (c.cmanager = <!--- '#session.userid#' --->'#session.origUserID#' ))
	
	</cfif>
	and a.year2=r.year2
	and a.region = r.num	
	order by 1 --->
		
		
	<!--- select area, num
	from area 
	where year2=#session.fy#
	<cfif session.regionManage EQ "0" OR session.statemanage EQ "0" AND QuserArea.area NEQ "0">
	and num = '#QuserArea.area#'
	</cfif>
	order by 1 --->
</cfquery>



<cfquery datasource="#application.DataSource#" 	 
	password="#Application.db_password#"  		
	username="#Application.db_username#" name="Qpartner">
	select c.orgName as partner, c.userid
	from contact as c, security as s, region as r, area as a
	where c.userid=s.userid
	and r.num=a.region
	and r.year2=a.year2
	and s.area=a.num
	and a.year2=2009
	and coordemail not like '%rti.org'
	
	and c.coordemail not like '%rti.org'
and c.email not like '%rti.org'
and c.coordemail not like '%health.state.ny.us'
and c.email not like '%health.state.ny.us'
	
	<cfif session.areaManage EQ "1" AND session.statemanage EQ "0" >
	-- and s.area='#QuserArea.area#'
	<cfelseif isDefined("form.Area") and form.Area NEQ "ALL">
	and s.area = '#form.area#'
	<!--- </cfif> --->
	</cfif>
	<cfif  (isDefined("form.Region") and form.Region NEQ "ALL") >
	and r.num = '#form.Region#'
	<cfelseif  session.cntMan EQ 1 and QArea.recordcount NEQ 0>
	and r.num = #Qarea.num#
	</cfif>
	<cfif session.areaManage EQ "0" AND session.regionManage EQ "0" AND session.statemanage EQ "0" AND QuserArea.area NEQ "0">
	and c.userid = '#session.userid#'	
	</cfif>
	
	<!--- <cfif session.areaManage EQ "1" AND session.statemanage EQ "0" >
	-- and s.area='#QuserArea.area#'
	<cfelseif isDefined("form.Area") and form.Area NEQ "ALL">
	and s.area = '#form.area#'
	<!--- </cfif> --->
	</cfif>
	<cfif  (isDefined("form.Region") and form.Region NEQ "ALL") >
	and r.num = '#form.Region#'
	<cfelseif  session.cntMan EQ 1>
	and r.num = #Qarea.num#
	</cfif>
	
	<cfif session.cntMan EQ "0" and session.areaManage EQ "0" AND session.regionManage EQ "0" AND session.statemanage EQ "0" AND QuserArea.area NEQ "0">
	and c.userid = '#session.userid#'	
	</cfif>
	<cfif isDefined("form.rptType") and (form.rptType EQ 8 or form.rptType EQ 18 or form.rptType EQ 19 or form.rptType EQ 25 or form.rptType EQ 21 or form.rptType EQ 24 or form.rptType EQ 33)>
	and c.partnertype=1
	</cfif>
	<cfif isDefined("form.modality") and form.modality NEQ "ALL">
	and c.partnertype=#form.modality#
	</cfif>
	
	<cfif session.cessman NEQ 0>
	and c.partnertype=#session.cessman#
	</cfif> --->
	and c.orgname is not null
	and c.orgname != ''
	order by 1
		
		
	<!--- select c.orgName as partner, c.userid
	from contact as c, security as s
	where c.userid=s.userid
	and email not like '%rti.org'
	<cfif session.areaManage EQ "1" AND session.statemanage EQ "0" >
	-- and s.area='#QuserArea.area#'
	<cfelseif isDefined("form.Area") and form.Area NEQ "ALL">
	and s.area = '#form.area#'
	</cfif>
	<cfif session.areaManage EQ "0" AND session.regionManage EQ "0" AND session.statemanage EQ "0" AND QuserArea.area NEQ "0">
	and c.userid = '#session.userid#'	
	</cfif>
	<cfif isDefined("form.rptType") and (form.rptType EQ 8 or form.rptType EQ 18 or form.rptType EQ 19 or form.rptType EQ 25 or form.rptType EQ 21 or form.rptType EQ 24 or form.rptType EQ 33)>
	and c.partnertype=1
	</cfif>
	<cfif isDefined("form.modality") and form.modality NEQ "ALL">
	and c.partnertype=#form.modality#
	</cfif>
	and c.orgname is not null
	and c.orgname != ''
	order by 1 --->
</cfquery>

<cfquery datasource="#application.DataSource#" 	 
	password="#Application.db_password#"  		
	username="#Application.db_username#" name="Qpartner_cc">
	select c.orgName as partner, c.userid
	from contact as c, security as s, region as r, area as a
	where c.userid=s.userid
	and r.num=a.region
	and r.year2=a.year2
	and s.area=a.num
	and a.year2=2009
	and coordemail not like '%rti.org'
	and partnertype = 1
	
	and c.coordemail not like '%rti.org'
and c.email not like '%rti.org'
and c.coordemail not like '%health.state.ny.us'
and c.email not like '%health.state.ny.us'

	<!--- <cfif session.areaManage EQ "1" AND session.statemanage EQ "0" >
	and s.area='#QuserArea.area#'
	</cfif> --->
	<cfif  isDefined("form.Area") and form.Area NEQ "ALL">
	and s.area = '#form.area#'
	<!--- </cfif> --->
	<cfelseif isDefined("form.Region") and form.Region NEQ "ALL">
	and r.num = '#form.Region#'
	<cfelseif  session.cntMan EQ 1>
	and r.num = #Qarea.num#
	</cfif>
	<cfif session.areaManage EQ "0" AND session.regionManage EQ "0" AND session.statemanage EQ "0" AND QuserArea.area NEQ "0">
	and c.userid = '#session.userid#'	
	</cfif>
	<cfif isDefined("form.rptType") and (form.rptType EQ 8 or form.rptType EQ 18 or form.rptType EQ 19 or form.rptType EQ 25 or form.rptType EQ 21 or form.rptType EQ 24 or form.rptType EQ 33)>
	and c.partnertype=1
	</cfif>
	<cfif isDefined("form.modality") and form.modality NEQ "ALL">
	and c.partnertype=#form.modality#
	</cfif>
	and c.orgname is not null
	and c.orgname != ''
	order by 1	
		
		
		
	<!--- select c.orgName as partner, c.userid
	from contact as c, security as s
	where c.userid=s.userid
	and email not like '%rti.org'
	and partnertype = 1
	<cfif session.areaManage EQ "1" AND session.statemanage EQ "0" >
	and s.area='#QuserArea.area#'
	<cfelseif isDefined("form.Area") and form.Area NEQ "ALL">
	and s.area = '#form.area#'
	</cfif>
	<cfif session.areaManage EQ "0" AND session.regionManage EQ "0" AND session.statemanage EQ "0" AND QuserArea.area NEQ "0">
	and c.userid = '#session.userid#'	
	</cfif>
	<cfif isDefined("form.rptType") and (form.rptType EQ 8 or form.rptType EQ 18 or form.rptType EQ 19 or form.rptType EQ 25 or form.rptType EQ 21 or form.rptType EQ 24 or form.rptType EQ 33)>
	and c.partnertype=1
	</cfif>
	<cfif isDefined("form.modality") and form.modality NEQ "ALL">
	and c.partnertype=#form.modality#
	</cfif>
	and c.orgname is not null
	and c.orgname != ''
	order by 1 --->
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
	and a.year2=2009
	and coordemail not like '%rti.org'
	and partnertype = 2
	
	and c.coordemail not like '%rti.org'
and c.email not like '%rti.org'
and c.coordemail not like '%health.state.ny.us'
and c.email not like '%health.state.ny.us'
	<!--- <cfif session.areaManage EQ "1" AND session.statemanage EQ "0" >
	and s.area='#QuserArea.area#'
	</cfif> --->
	<cfif  isDefined("form.Area") and form.Area NEQ "ALL" >
	and s.area = '#form.area#'
	<!--- </cfif> --->
	<cfelseif isDefined("form.Region") and form.Region NEQ "ALL">
	and r.num = '#form.Region#'
	<cfelseif  session.cntMan EQ 1>
	and r.num = #Qarea.num#
	</cfif>
	<cfif session.areaManage EQ "0" AND session.regionManage EQ "0" AND session.statemanage EQ "0" AND QuserArea.area NEQ "0">
	and c.userid = '#session.userid#'	
	</cfif>
	<cfif isDefined("form.rptType") and (form.rptType EQ 8 or form.rptType EQ 18 or form.rptType EQ 19 or form.rptType EQ 25 or form.rptType EQ 21 or form.rptType EQ 24 or form.rptType EQ 33)>
	and c.partnertype=1
	</cfif>
	<cfif isDefined("form.modality") and form.modality NEQ "ALL">
	and c.partnertype=#form.modality#
	</cfif>
	and c.orgname is not null
	and c.orgname != ''
	order by 1	
		
		
		
	<!--- select c.orgName as partner, c.userid
	from contact as c, security as s
	where c.userid=s.userid
	and email not like '%rti.org'
	and partnertype = 2
	<cfif session.areaManage EQ "1" AND session.statemanage EQ "0" >
	and s.area='#QuserArea.area#'
	<cfelseif isDefined("form.Area") and form.Area NEQ "ALL">
	and s.area = '#form.area#'
	</cfif>
	<cfif session.areaManage EQ "0" AND session.regionManage EQ "0" AND session.statemanage EQ "0" AND QuserArea.area NEQ "0">
	and c.userid = '#session.userid#'	
	</cfif>
	<cfif isDefined("form.rptType") and (form.rptType EQ 8 or form.rptType EQ 18 or form.rptType EQ 19 or form.rptType EQ 25 or form.rptType EQ 21 or form.rptType EQ 24 or form.rptType EQ 33)>
	and c.partnertype=1
	</cfif>
	<cfif isDefined("form.modality") and form.modality NEQ "ALL">
	and c.partnertype=#form.modality#
	</cfif>
	and c.orgname is not null
	and c.orgname != ''
	order by 1 --->
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
	and a.year2=2009
	and coordemail not like '%rti.org'
	and partnertype = 3
	
	and c.coordemail not like '%rti.org'
and c.email not like '%rti.org'
and c.coordemail not like '%health.state.ny.us'
and c.email not like '%health.state.ny.us'
	
	<!--- <cfif session.areaManage EQ "1" AND session.statemanage EQ "0" >
	and s.area='#QuserArea.area#'
	</cfif> --->
	<cfif isDefined("form.Area") and form.Area NEQ "ALL">
	and s.area = '#form.area#'
	<cfelseif isDefined("form.Region") and form.Region NEQ "ALL">
	and r.num = '#form.Region#'
	<cfelseif  session.cntMan EQ 1>
	and r.num = #Qarea.num#
	</cfif>
	<cfif session.areaManage EQ "0" AND session.regionManage EQ "0" AND session.statemanage EQ "0" AND QuserArea.area NEQ "0">
	and c.userid = '#session.userid#'	
	</cfif>
	<cfif isDefined("form.rptType") and (form.rptType EQ 8 or form.rptType EQ 18 or form.rptType EQ 19 or form.rptType EQ 25 or form.rptType EQ 21 or form.rptType EQ 24 or form.rptType EQ 33)>
	and c.partnertype=1
	</cfif>
	<cfif isDefined("form.modality") and form.modality NEQ "ALL">
	and c.partnertype=#form.modality#
	</cfif>
	and c.orgname is not null
	and c.orgname != ''
	order by 1	
		
		
		
	<!--- select c.orgName as partner, c.userid
	from contact as c, security as s
	where c.userid=s.userid
	and email not like '%rti.org'
	and partnertype = 3
	<cfif session.areaManage EQ "1" AND session.statemanage EQ "0" >
	and s.area='#QuserArea.area#'
	<cfelseif isDefined("form.Area") and form.Area NEQ "ALL">
	and s.area = '#form.area#'
	</cfif>
	<cfif session.areaManage EQ "0" AND session.regionManage EQ "0" AND session.statemanage EQ "0" AND QuserArea.area NEQ "0">
	and c.userid = '#session.userid#'	
	</cfif>
	<cfif isDefined("form.rptType") and (form.rptType EQ 8 or form.rptType EQ 18 or form.rptType EQ 19 or form.rptType EQ 25 or form.rptType EQ 21 or form.rptType EQ 24 or form.rptType EQ 33)>
	and c.partnertype=1
	</cfif>
	<cfif isDefined("form.modality") and form.modality NEQ "ALL">
	and c.partnertype=#form.modality#
	</cfif>
	and c.orgname is not null
	and c.orgname != ''
	order by 1 --->
</cfquery>

<!--- </cfif> --->

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
		(u.userid='#form.partner#')
		or
		(u.activity in (select distinct ss.activity 
		from shareduseractivities ss, useractivities uu
		where ss.activity=uu.activity 
		and ss.year2=uu.year2
		and uu.userid='shared' and ss.userid='#form.partner#' and ss.year2=#session.fy#
		union select '0000')
		)
		)	
	<cfelse>
		(
		(u.userid='#session.userid#')
		or
		(u.activity in (select distinct ss.activity 
		from shareduseractivities ss, useractivities uu
		where ss.activity=uu.activity 
		and ss.year2=uu.year2
		and uu.userid='shared' and ss.userid='#session.userid#' and ss.year2=#session.fy#
		union select '0000')
		)
		)	
	</cfif>
	and u.year2=#session.fy#
	order by 1
</cfquery>
</cfif>



<cfquery datasource="#application.DataSource#"   		 
	password="#Application.db_password#"  		
	username="#Application.db_username#" name="QGoal">
	Select progNum, program 
	from program
	where year2=#session.fy#	
	order by 1
</cfquery>

<cfif isDefined("form.goal") and form.goal NEQ "ALL" >
<cfquery datasource="#application.DataSource#"  		 
	password="#Application.db_password#"  		
	username="#Application.db_username#" name="QObj">
	Select objective, id 
	from objectives
	where year2=#session.fy#	
	and progNum=#form.goal#
	and (del is null or del  != '1')
	order by 2
</cfquery>
</cfif>

<cfquery datasource="#application.DataSource#"  		 
	password="#Application.db_password#"  		
	username="#Application.db_username#" name="QObj2">
	Select initiative as objective, id 
	from objectives
	where year2=#session.fy#	
	and (del is null or del  != '1')
	order by 2
</cfquery>



<cfquery datasource="#application.DataSource#"   		 
	password="#Application.db_password#"  		
	username="#Application.db_username#" name="QFarea">
	select strategy as descr, strategy_Num as num
	from strategy 
	where year2=#session.fy#
	<cfif isDefined("form.rptType") and form.rptType EQ "6">and strategy_Num !=10</cfif>
	order by 2
</cfquery>

<cfquery datasource="#application.DataSource#"   		 
	password="#Application.db_password#"  		
	username="#Application.db_username#" name="QGroup">
	select distinct groupname,groupnum
	from objectives
	where year2=#session.fy#
	order by groupname
</cfquery>

<cfquery datasource="#application.DataSource#"   		 
	password="#Application.db_password#"  		
	username="#Application.db_username#" name="QTarget">
	select distinct target --, targetnum
	from targets
	where year2=#session.fy#
	order by target
</cfquery>



<cfquery datasource="#application.DataSource#"   		 
	password="#Application.db_password#"  		
	username="#Application.db_username#" name="Qmonths">
	select mon, mon_num, rank
	from 
	months	where year2 = #session.fy#
	 <cfif session.fy EQ session.def_fy>and rank <= (select rank from months where mon = '#MonthAsString(Month(now()))#' and year2 = #session.fy#)</cfif>
		order by 2
</cfquery>

<!--- <cfquery datasource="#Application.DataSource#"  		 
	password="#Application.db_password#"  		
	username="#Application.db_username#" name="Qstrat">
	select mon, rank
	from 
	useractivities
	where year2=2004
	and userid=#reportuser#
	order by 2
</cfquery> --->
<!--- <cfform scriptSrc="/scripts" name="fReportHandler" action="reporthandler_mod.cfm?#session.urltoken#" target="_new">
 --->

<cfform scriptSrc="/scripts" name="fReportHandler">
<!--- <table> --->
<tr><td colspan=2 style="border-bottom : thin solid Navy;"><h5>Youth Partners, Cessation Centers and Community Partnership Reports</h5></td></tr>
<tr>
	<td>Report Type</td>
	<td>
		<select name="rptType" onChange="setType();">
		<!--- <cfif #session.fy# is not '2007'> --->
				<cfif #session.userid# EQ 'dplotner'>
							<option value="62" <cfif isDefined("form.rptType") and form.rptType EQ "62"> selected</cfif>>Contractor Monthly Activity Report
				
				</cfif>
			 <option value="9" <cfif isDefined("form.rptType") and form.rptType EQ "9"> selected</cfif>>Contract Manager Feedback Report
			<cfif SESSION.modality EQ 1 or SESSION.TCP EQ "1" or SESSION.CessMan EQ "1" or  SESSION.admin EQ "1" or  SESSION.areamanage EQ "1">
				<option value="24" <cfif isDefined("form.rptType") and form.rptType EQ "24"> selected</cfif>>CC Quarterly: Brief Cessation Interventions Summary Report
				<option value="19" <cfif isDefined("form.rptType") and form.rptType EQ "19"> selected</cfif>>CC Quarterly: Brief Cessation Interventions List Report
				<option value="8" <cfif isDefined("form.rptType") and form.rptType EQ "8"> selected</cfif>>Cessation Center Policy & Practice List Report
				<option value="21" <cfif isDefined("form.rptType") and form.rptType EQ "21"> selected</cfif>>Cessation Center Policy & Practice Summary Report
				<cfif session.fy GTE 2009>
			<!--- 		<option value="60" <cfif isDefined("form.rptType") and form.rptType EQ "60"> selected</cfif>>Cessation Center Progress Milestone Report - Cumulative --->
					<option value="61" <cfif isDefined("form.rptType") and form.rptType EQ "61"> selected</cfif>>Cessation Center Progress Milestone Report - by Fiscal Year
			
				
				</cfif>
			</cfif>
 			<option value="1" <cfif isDefined("form.rptType") and form.rptType EQ "1"> selected</cfif>>Detailed Monthly Strategy Report Entries
 <!--- 		<option value="3" <cfif isDefined("form.rptType") and form.rptType EQ "3"> selected</cfif>>(Work Plan Counts by Goal-Objective-Focus Area) --->
			<option value="4" <cfif isDefined("form.rptType") and form.rptType EQ "4"> selected</cfif>>Earned Media Summary Report
		
		<cfif session.fy EQ 2007>
			<option value="32" <cfif isDefined("form.rptType") and form.rptType EQ "32"> selected</cfif>>End-of-year Area Manager Feedback Report
			<cfif SESSION.TCP EQ "1" or  SESSION.admin EQ "1" or  SESSION.areamanage EQ "1">
			<option value="31" <cfif isDefined("form.rptType") and form.rptType EQ "31"> selected</cfif>>End-of-year Report Status
			</cfif>
			<option value="30" <cfif isDefined("form.rptType") and form.rptType EQ "30"> selected</cfif>>End-of-year Report Summary
		</cfif>	
		
		<cfif session.fy GTE 2008 or session.userid EQ 'bmarkatos' or session.userid EQ 'dplotner'  or session.userid EQ 'nsarris'>
			<cfif SESSION.modality EQ 1 or SESSION.TCP EQ "1" or SESSION.CessMan EQ "1" or  SESSION.admin EQ "1" or  SESSION.areamanage EQ "1">
			<option value="53" <cfif isDefined("form.rptType") and form.rptType EQ "53"> selected</cfif>>End-of-year Report Summary (CC)
			<option value="50" <cfif isDefined("form.rptType") and form.rptType EQ "50"> selected</cfif>>End-of-year Report Summary with TCP Feedback (CC)
			</cfif>
			<cfif SESSION.modality EQ 2 or SESSION.TCP EQ "1" or SESSION.CessMan EQ "1" or  SESSION.admin EQ "1" or  SESSION.areamanage EQ "1">
			<option value="54" <cfif isDefined("form.rptType") and form.rptType EQ "54"> selected</cfif>>End-of-year Report Summary (CP)
			<option value="51" <cfif isDefined("form.rptType") and form.rptType EQ "51"> selected</cfif>>End-of-year Report Summary with TCP Feedback (CP)
			</cfif>
			<cfif SESSION.modality EQ 3 or SESSION.TCP EQ "1" or SESSION.CessMan EQ "1" or  SESSION.admin EQ "1" or  SESSION.areamanage EQ "1">
			<option value="55" <cfif isDefined("form.rptType") and form.rptType EQ "55"> selected</cfif>>End-of-year Report Summary (YP)
			<option value="52" <cfif isDefined("form.rptType") and form.rptType EQ "52"> selected</cfif>>End-of-year Report Summary with TCP Feedback (YP)
			</cfif> 
		</cfif>	
			
			<cfif SESSION.TCP EQ "1" or  SESSION.admin EQ "1" or  SESSION.areamanage EQ "1">
	 			<option value="12" <cfif isDefined("form.rptType") and form.rptType EQ "12"> selected</cfif>> Evaluation Methods Summary Report
				<option value="11" <cfif isDefined("form.rptType") and form.rptType EQ "11"> selected</cfif>>Evaluation Project Status Report
			</cfif>
<!--- 		<option value="5" <cfif isDefined("form.rptType") and form.rptType EQ "5"> selected</cfif>>(Success-Barriers Report) --->
			<cfif SESSION.TCP EQ "1" or  SESSION.admin EQ "1" or  SESSION.areamanage EQ "1">
			<option value="23" <cfif isDefined("form.rptType") and form.rptType EQ "23"> selected</cfif>>Joint Partner Strategy Progress Summary Report
			<option value="22" <cfif isDefined("form.rptType") and form.rptType EQ "22"> selected</cfif>>Joint Partner Strategy List Report
			</cfif>
			<option value="7" <cfif isDefined("form.rptType") and form.rptType EQ "7"> selected</cfif>>Monthly Infrastructure Report Entries
			<option value="14" <cfif isDefined("form.rptType") and form.rptType EQ "14"> selected</cfif>>Paid Media Details Report
			<option value="17" <cfif isDefined("form.rptType") and form.rptType EQ "17"> selected</cfif>>Planned Media Campaign with Quitline reference report
			<option value="15" <cfif isDefined("form.rptType") and form.rptType EQ "15"> selected</cfif>>Policies and Resolutions Aggregate Report
			<option value="16" <cfif isDefined("form.rptType") and form.rptType EQ "16"> selected</cfif>>Policy and Resolution Changes Partner-level Report
			<option value="13" <cfif isDefined("form.rptType") and form.rptType EQ "13"> selected</cfif>>Quitline Paid Media Details Report
			<option value="6" <cfif isDefined("form.rptType") and form.rptType EQ "6"> selected</cfif>>Strategy Progress Summary Report
<cfif SESSION.modality EQ 1 or SESSION.TCP EQ "1" or SESSION.CessMan EQ "1" or  SESSION.admin EQ "1" or  SESSION.areamanage EQ "1">
			<option value="25" <cfif isDefined("form.rptType") and form.rptType EQ "25"> selected</cfif>>Summary of Advocating -CC MSR
</cfif>
			<option value="33" <cfif isDefined("form.rptType") and form.rptType EQ "33"> selected</cfif>>Summary of Trainings by Cessation Center	
			<option value="10" <cfif isDefined("form.rptType") and form.rptType EQ "10"> selected</cfif>>Sustainability Summary Report
			<option value="34" <cfif isDefined("form.rptType") and form.rptType EQ "34"> selected</cfif>>Tobacco-Free Policies and Resolutions List Report
			<option value="2" <cfif isDefined("form.rptType") and form.rptType EQ "2"> selected</cfif>>Work Plan Summary
		<!---  <cfelse>
		 	<option value="">
<!--- 			<option value="12" <cfif isDefined("form.rptType") and form.rptType EQ "12"> selected</cfif>> Evaluation Methods Summary Report
 --->
 		 	<option value="2" <cfif isDefined("form.rptType") and form.rptType EQ "2"> selected</cfif>>Work Plan Summary
		</cfif> --->
			
		</select>
		<cfif  isDefined("form.rptType") and form.rptType EQ "8"><br>THIS REPORT IS AVAILABLE FOR FYS 2004-2005 THROUGH 2007-2008 ONLY.</cfif>
	</td>
</tr>

<input type="hidden" name="format" value="PDF">

<!--- <cfif NOT isDefined("form.rptType") OR (isDefined("form.rptType") and (form.rptType EQ "1" or form.rptType EQ "2" OR form.rptType EQ "4" OR form.rptType EQ "6"  OR form.rptType EQ "8"  OR form.rptType EQ "9" OR form.rptType EQ "10" OR form.rptType EQ "11" OR form.rptType EQ "12" OR form.rptType EQ "13" OR form.rptType EQ "14" OR form.rptType EQ "15" OR form.rptType EQ "16" OR form.rptType EQ "17" OR form.rptType EQ "21" OR form.rptType EQ "22"  OR form.rptType EQ "19"  OR form.rptType EQ "23" OR form.rptType EQ "24" OR form.rptType EQ "25"))>

<tr>
	<td>Output Type</td>
	<td>
		<select name="format">
   			<option value="PDF" <cfif isDefined("form.format") and form.format EQ "PDF"> selected</cfif>>PDF (Acrobat)
			<!--- <option value="FlashPaper" <cfif isDefined("form.format") and form.format EQ "FlashPaper"> selected</cfif>>FlashPaper
 --->			<option value="Excel" <cfif isDefined("form.format") and form.format EQ "Excel"> selected</cfif>>Excel
		</select>
	</td>
</tr>
</cfif> --->
<tr><td><br><br></td></tr>


<cfif (((isDefined("form.rptType") and form.rptType NEQ 50 and form.rptType NEQ 51 and form.rptType NEQ 52 and form.rptType NEQ 53 and form.rptType NEQ 54 and form.rptType NEQ 55 and form.rptType NEQ 60 and form.rptType NEQ 61) OR NOT isDefined("form.rptType")) AND (session.admin EQ "1" OR session.statemanage EQ "1" OR session.cntMan EQ "1" OR session.regionmanage EQ "1" OR session.areamanage EQ "1") and NOT (isDefined("rptType") and (form.rptType EQ 8 or form.rptType EQ 19 or form.rptType EQ 24 or form.rptType EQ 21 OR form.rptType EQ 25 OR form.rptType EQ 33)))>
<tr>
	<td>Modality:</td>
	<td>
	<select name="modality" onChange="resetPartner();">
		<cfif (session.areamanage EQ "1" OR session.statemanage EQ "1" or Session.admin EQ "1") and  (session.cessMan EQ "0" or session.origUserID EQ "dplotner") >
			<option value="ALL"<cfif isDefined("form.modality") and form.modality EQ "ALL"> selected</cfif>>All Modalities
		</cfif>
		<!--- <cfif session.cessman NEQ 2 and session.cessman NEQ 3 and not(session.statemanage EQ "1" or Session.admin EQ "1")> --->
			
			
			<!--- <cfif session.cessman EQ 1>
			<option value="1">Cessation Center</option>
	<!--- 	<cfelseif  session.cessman NEQ 1 and session.cessman NEQ 3  and not(session.statemanage EQ "1" or Session.admin EQ "1")>--->
 			<cfelseif session.cessman EQ 2>
			<option value="2">Community Partnership</option>
		<!--- <cfelseif  session.cessman NEQ 1 and session.cessman NEQ 2  and not(session.statemanage EQ "1" or Session.admin EQ "1")> --->
			<cfelseif session.cessman EQ 3>
			<option value="3">Youth Partner</option>
		<cfelse> --->
		
		
	<!--- commented out 3.27.2009 dmp --->	
	<!--- 		<option value="1" <cfif isDefined("form.modality") and form.modality EQ "1"> selected</cfif>>Cessation Center</option>
			<option value="2" <cfif isDefined("form.modality") and form.modality EQ "2"> selected</cfif>>Community Partnership</option>		
			<option value="3" <cfif isDefined("form.modality") and form.modality EQ "3"> selected</cfif>>Youth Partner</option> --->
		
			<!--- added  3.27.2009 dmp--->
			<cfif session.cessman EQ 1 or session.cessman EQ 0 >
			<option value="1" <cfif isDefined("form.modality") and form.modality EQ "1"> selected</cfif>>Cessation Center</option>
			</cfif>
			<cfif session.cessman EQ 2 or session.cessman EQ 0>
			<option value="2" <cfif isDefined("form.modality") and form.modality EQ "2"> selected</cfif>>Community Partnership</option>	
			</cfif>
			<cfif session.cessman EQ 3 or session.cessman EQ 0>
			<option value="3" <cfif isDefined("form.modality") and form.modality EQ "3"> selected</cfif>>Youth Partner</option>
			</cfif>
			
			
			<!--- </cfif> --->
		
	</select>
	</td>
</tr>

</cfif>
<cfif (((isDefined("form.rptType") and form.rptType NEQ "340") OR NOT isDefined("form.rptType")) and (session.admin EQ "1" OR session.statemanage EQ "1" OR session.regionmanage EQ "1" OR session.areamanage EQ "1"  OR session.cntMan EQ "1")) <!--- and NOT (isDefined("rptType") and (form.rptType EQ 8)) --->>

<tr>
<td>Region:</td>
<td>
	<select name="Region" onChange="resetPartner();">
		<cfoutput>
			<cfif session.statemanage EQ "1" or Session.admin EQ "1" or session.cessman NEQ 0>
				<option value="ALL"<cfif isDefined("form.area") and form.area EQ "ALL"> selected</cfif>>StateWide
			</cfif>
			<cfloop query="QArea">
				<option value="#QArea.num#"<cfif isDefined("form.region") and form.region EQ QArea.num> selected</cfif>>#region#
				<!--- <option value="#QArea.num#"<cfif isDefined("form.area") and form.area EQ QArea.num> selected</cfif>>#area# --->
			</cfloop>
		</cfoutput>
	</select>
</td>
</tr>

<!--- <tr>
<td>Area:</td>
<td>
	<select name="area" onChange="resetPartner();">
		<cfoutput>
			<cfif session.statemanage EQ "1" or Session.admin EQ "1">
				<option value="ALL"<cfif isDefined("form.area") and form.area EQ "ALL"> selected</cfif>>StateWide
			</cfif>
			<cfloop query="QArea">
				<option value="#QArea.num#"<cfif isDefined("form.area") and form.area EQ QArea.num> selected</cfif>>#area#
			</cfloop>
		</cfoutput>
	</select>
</td>
</tr> --->


</cfif>
<cfif isDefined("form.rptType") and form.rptType EQ "34" and (session.statemanage NEQ "1" and  Session.admin NEQ "1") AND session.areamanage EQ "1">
	<input type="hidden" name="area" value="<cfoutput>#QArea.num#</cfoutput>">
<!--- <cfoutput>area: #QArea.num#</cfoutput>" --->
</cfif>
<cfif 
<!--- ((isDefined("form.area") AND form.area NEQ "ALL") OR (session.admin NEQ "1" and session.statemanage NEQ "1" )) --->
((isDefined("form.region") AND form.region NEQ "ALL") OR (session.admin NEQ "1" and session.statemanage NEQ "1" )) 
and 
((isDefined("form.rptType") and form.rptType NEQ "22" and form.rptType NEQ "23") or not isDefined("form.rptType"))>
<tr>	
	<td>Partner Name:</td>
	<td>
		<select name="partner" <cfif NOT isDefined("form.rptType") OR (isDefined("form.rptType") and form.rptType NEQ "50" and form.rptType NEQ "51" and form.rptType NEQ "52" and form.rptType NEQ "53" and form.rptType NEQ "54" and form.rptType NEQ "55")>onchange="resetStrategy();"</cfif>>
		<cfoutput>
				<cfif session.statemanage EQ "1" OR session.areamanage EQ "1" or session.admin EQ "1" or session.cessman NEQ 0>
					<option value="ALL" <cfif isDefined("form.partner") and form.partner EQ "ALL"> selected</cfif>>All Partners
				</cfif>
				<cfif isdefined("form.rpttype") and (#form.rpttype# is 50 or #form.rpttype# is 53 or #form.rpttype# is 60 or (#form.rpttype# is 61 or isdefined("form.modality") and #form.modality# is 1))>
			<cfloop query="Qpartner_cc">
				<option value="#Qpartner_cc.userid#"<cfif isDefined("form.partner") and form.partner EQ "#Qpartner_cc.userid#"> selected</cfif>>#partner#
			</cfloop>
			<cfelseif isdefined("form.rpttype") and (#form.rpttype# is 51 or #form.rpttype# is 54 or (#form.rpttype# is 61 or isdefined("form.modality") and #form.modality# is 2))>
			<cfloop query="Qpartner_cp">
				<option value="#Qpartner_cp.userid#"<cfif isDefined("form.partner") and form.partner EQ "#Qpartner_cp.userid#"> selected</cfif>>#partner#
			</cfloop>
			<cfelseif isdefined("form.rpttype") and (#form.rpttype# is 52 or #form.rpttype# is 55 or (#form.rpttype# is 61 or isdefined("form.modality") and #form.modality# is 3))>
			<cfloop query="Qpartner_yp">
				<option value="#Qpartner_yp.userid#"<cfif isDefined("form.partner") and form.partner EQ "#Qpartner_yp.userid#"> selected</cfif>>#partner#
			</cfloop>
			<cfelse>	
			<cfloop query="Qpartner">
				<option value="#Qpartner.userid#"<cfif isDefined("form.partner") and form.partner EQ "#Qpartner.userid#"> selected</cfif>>#partner#
			</cfloop>			</cfif>
		</cfoutput>
		</select>
	</td>
</tr>
</cfif>

<!--- <cfif NOT isDefined("form.area") OR form.area NEQ "ALL">
<input type="hidden" name="partner" value="ALL">
</cfif> --->
<cfif (isDefined("form.rptType") and form.rptType NEQ "7" and form.rptType NEQ "777" and form.rptType NEQ "8" and form.rptType NEQ "9" and form.rptType NEQ "10" and form.rptType NEQ "11" and form.rptType NEQ "12" and form.rptType NEQ "21" and form.rptType NEQ "22" and form.rptType NEQ "19" and form.rptType NEQ "24"  and form.rptType NEQ "30"  and form.rptType NEQ "31"  and form.rptType NEQ "32" and form.rptType NEQ "33" and form.rptType NEQ "50" and form.rptType NEQ "51" and form.rptType NEQ "52" and form.rptType NEQ "53" and form.rptType NEQ "54" and form.rptType NEQ "55" and form.rptType NEQ "60" and form.rptType NEQ "61" and form.rptType NEQ "62") or not isDefined("form.rptType")>
<cfif (isDefined("form.partner") AND form.partner NEQ "ALL") OR (session.admin NEQ "1" and session.statemanage NEQ "1"  and session.regionmanage NEQ "1" and session.areamanage NEQ "1" and session.tcp NEQ "1" )  >
<tr>
	<td>Strategy:</td>
	<td>
		<select name="strategy">
		<cfoutput>
				<option value="ALL">All Strategies
			<cfloop query="Qstrategy">
				<option value="#strategy#">#strategy#
			</cfloop>
		</cfoutput>
		</select>
	</td>
</tr>
</cfif>
</cfif>

<cfif (not isDefined("form.rptType")) OR (isDefined("form.rptType") and (form.rptType EQ "1" OR form.rptType EQ "4" OR form.rptType EQ "6" OR form.rptType EQ "777" OR form.rptType EQ "7" OR form.rptType EQ "9" OR form.rptType EQ "10"  OR form.rptType EQ "13"  OR form.rptType EQ "14" OR form.rptType EQ "15"  OR form.rptType EQ "16"   OR form.rptType EQ "23" OR form.rptType EQ "25" OR form.rptType EQ "62"))>

<tr><td>Date Range:</td><td><table class="box">

<tr>
	<td>Start Month:</td>
	<td>
		<CFOUTPUT>
		<select name="stmonth" query="Qmonths">
			<CFLOOP query="Qmonths">
				<option value="#rank#" <cfif ((isDefined("form.stmonth") and form.stmonth EQ "#rank#")OR (NOT isDefined("form.stmonth") AND rank EQ "1"))>selected</cfif>>#mon#
			</CFLOOP>
		</select>
		</CFOUTPUT>
	</td>
</tr>

<tr>
	<td>End Month:</td>
	<td>
		<CFOUTPUT>
		<select name="endmonth" query="Qmonths">
			<CFLOOP query="Qmonths">
				<option value="#rank#"<cfif ((isDefined("form.endmonth") and form.endmonth EQ "#rank#")OR (NOT isDefined("form.endmonth") AND rank EQ "12"))>selected</cfif>>#mon#
			</CFLOOP>
		</select>
		</CFOUTPUT>
	</td>
</tr>


</table></td></tr>
<tr>
<cfelseif isDefined("form.rptType") and form.rptType EQ "17" >
<tr><td>Date Range:</td><td><table class="box">
 
<tr>
 <td>Start Date (m/d/yyyy):</td>
 <td>
  <cfif isDefined("form.stmonth") and form.stmonth GT 20> 
   <cfinput type="text" name="stmonth" validate="date" value="#dateformat(form.stmonth, 'm/d/yyyy')#">
  <cfelse>
   <cfinput type="text" name="stmonth" validate="date">
  </cfif>
   </td>
</tr>
 
<tr>
 <td>End Date (m/d/yyyy):</td>
 <td>
  
  <cfif isDefined("form.endmonth") and form.endmonth GT 20> 
   <cfinput type="text" name="endmonth" validate="date" value="#dateformat(form.endmonth, 'm/d/yyyy')#">
  <cfelse>
   <cfinput type="text" name="endmonth" validate="date">
  </cfif>
   </td>
</tr>
 

</table></td></tr>
<tr>
 
<cfelseif isDefined("form.rptType") and (form.rptType EQ "8" or form.rptType EQ "19" or form.rptType EQ "24")>

<tr><td>Date Range:</td><td><table class="box">

<cfif  isDefined("form.rptType") and form.rptType EQ "8">
	<cfset tempendyr = 2008>
<cfelse>
	<cfset tempendyr = session.fy>
</cfif>
<tr>
	<td>Starting Year:</td>
	<td>
		<CFOUTPUT>
		<select name="stYear">
			<CFLOOP from="2005" to="#tempendyr#" index="yrloop">
				<option value="#yrloop#">#evaluate(yrloop-1)#-#yrloop#
			</CFLOOP>
		</select>
		</CFOUTPUT>
	</td>
	<td>Starting Quarter:</td>
	<td>
		<select name="stquarter">
			<option value=1>Q1</option>
			<option value=2>Q2</option>
			<option value=3>Q3</option>
			<option value=4>Q4</option>
		</select>		
	</td>	
</tr>

<tr>
	<td>Ending Year:</td>
	<td>
		<CFOUTPUT><cfif isDefined("form.rptType") and (form.rptType EQ "8")>
		<cfset endyr = #session.fy#<!--- -1 --->>
		<cfelse>
		<cfset endyr = #session.fy#>
		</cfif>
		<select name="endYear">
		
			<CFLOOP from="2005" to="#tempendyr#" index="yrloop">
				<option value="#yrloop#">#evaluate(yrloop-1)#-#yrloop#
			</CFLOOP>
	
		</select>
		</CFOUTPUT>
	</td>
	<td>Ending Quarter:</td>
	<td>
		<select name="endquarter">
			<option value=1>Q1</option>
			<option value=2>Q2</option>
			<option value=3>Q3</option>
			<option value=4>Q4</option>
		</select>		
	</td>	
</tr>


</table></td></tr>
<tr>

<cfelseif isDefined("form.rptType") and (form.rptType EQ "21")>

<tr><td>Date Range:</td><td><table class="box">

<tr>
	
	<td>Max Quarter:</td>
	<td>
		<select name="stquarter">
			<option value=1>Q1</option>
			<option value=2>Q2</option>
			<option value=3>Q3</option>
			<option value=4>Q4</option>
		</select>		
	</td>	
</tr>




</table></td></tr>
<tr>

</cfif>
<cfif isDefined("form.rpttype") and form.rpttype EQ 62>
<tr>
<td>Initiative:</td>
<td>
	<CFOUTPUT>
		<select name="objective" multiple>
				<option value="ALL"> All Initiatives
			<CFLOOP query="Qobj2">
				<option value="#id#" <cfif isDefined("form.objective") AND form.objective EQ "#id#"> selected</cfif>>#objective#
			</CFLOOP>
				<option value="inf" <cfif isDefined("form.objective") AND form.objective EQ "inf"> selected</cfif>>Infrastructure

		</select>
	</CFOUTPUT>
</td>
</tr>
</cfif>
<cfif (isDefined("form.rptType") and form.rptType NEQ "25" and form.rptType NEQ "777" and form.rptType NEQ "7" and form.rptType NEQ "8" and form.rptType NEQ "9" and form.rptType NEQ "10" and form.rptType NEQ "11" and form.rptType NEQ "12" and form.rptType NEQ "21"  and form.rptType NEQ "22" and form.rptType NEQ "19" and form.rptType NEQ "24"  and form.rptType NEQ "30"  and form.rptType NEQ "31"  and form.rptType NEQ "32" and form.rptType NEQ "33" and form.rptType NEQ "50" and form.rptType NEQ "51" and form.rptType NEQ "52" and form.rptType NEQ "53" and form.rptType NEQ "54" and form.rptType NEQ "55" and form.rptType NEQ "60" and form.rptType NEQ "61" and form.rptType NEQ "62") or not isDefined("form.rptType")>
<cfif isDefined("form.rptType") and form.rptType NEQ "4">
 <td>Goal:</td>
<td>
	<CFOUTPUT>
		<select name="goal" onchange="resetGoal();">
				<option value="ALL"> All Goals
			<CFLOOP query="Qgoal">
				<option value="#progNum#" <cfif isDefined("form.goal") AND form.goal EQ "#progNum#"> selected</cfif>>#program#
			</CFLOOP>
		</select>
	</CFOUTPUT>
</td>
</tr>

<cfif isDefined("form.goal") and form.goal NEQ "ALL">
<tr>
<td>Objective:</td>
<td>
	<CFOUTPUT>
		<select name="objective">
				<option value="ALL"> All Objectives
			<CFLOOP query="Qobj">
				<option value="#id#" <cfif isDefined("form.objective") AND form.objective EQ "#id#"> selected</cfif>>#objective#
			</CFLOOP>
		</select>
	</CFOUTPUT>
</td>
</tr>
</cfif>
</cfif>

</td>
</tr>


<cfif (isDefined("form.rptType") and form.rptType NEQ "14" and form.rptType NEQ "15" and form.rptType NEQ "16" and form.rptType NEQ "22"  and form.rptType NEQ "25" and form.rptType NEQ "50" and form.rptType NEQ "51" and form.rptType NEQ "52" and form.rptType NEQ "53" and form.rptType NEQ "54" and form.rptType NEQ "55")>
<tr>
	<td>Focus Area:</td>
	<td>
	<select name="farea" multiple size="4" class="mlti">
	<cfoutput>
		<option value="ALL" selected>All Focus Areas
		<cfloop query="QFarea">
			<option value="#num#" <cfif isDefined("form.farea") and form.farea EQ "#num#"> selected</cfif>>#descr#
		</cfloop>
	</cfoutput>
	</select>
	</td>
</tr>
</cfif>

<cfif (isDefined("form.rptType") and form.rptType EQ "34")>


<tr>
	<td>Category:</td>
	<td>
	<select name="category"  size="4" >
			<option value="ALL" selected>All Categories
			<option value="sponspromo" <cfif isDefined("form.category") and form.category CONTAINS "sponspromo"> selected</cfif>>Tobacco sponsorship and promotion policies/resolutions
			<option value="movies" <cfif isDefined("form.category") and form.category CONTAINS "movies"> selected</cfif>>Smoke free movies policies/resolutions
			<option value="magazine" <cfif isDefined("form.category") and form.category CONTAINS "magazine"> selected</cfif>>Tobacco ad-free magazine policies/ resolutions
			<option value="mud" <cfif isDefined("form.category") and form.category CONTAINS "mud"> selected</cfif>>Smoke-free multiunit dwelling policies
			<option value="outdoor" <cfif isDefined("form.category") and form.category CONTAINS "outdoor"> selected</cfif>>Outdoor tobacco use restriction/ban policies/resolutions
			<option value="retail" <cfif isDefined("form.category") and form.category CONTAINS "retail"> selected</cfif>>Retail tobacco policies/resolutions

	</select>
	</td>
</tr>

<tr>
	<td>Target Organization Types:</td>
	<td>
	<select name="targets" multiple size="4" class="mlti">
	<cfoutput>
		<option value="ALL" selected>All Target Organization Types
		<cfloop query="QTarget">
			<option value="#target#" <cfif isDefined("form.targets") and form.targets EQ "#target#"> selected</cfif>>#target#
		</cfloop>
	</cfoutput>
	</select>
	</td>
</tr>
</cfif>

</cfif>
<tr><td></td><td><input type="Button" value="Generate Report" onClick="chkSubmit();"></td></tr>
</table>


</cfform>

</body>
</html>
