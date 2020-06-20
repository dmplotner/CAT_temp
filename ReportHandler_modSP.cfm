<!---<cfif session.modality EQ 4>
	<cflocation addtoken="yes" url="UNAVAILABLE.cfm">
<!---<cfelseif (session.def_fy EQ session.fy) >
	<cflocation addtoken="yes" url="noFuture.cfm">--->
</cfif>
--->
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

<cfif #session.fy# GTE 2011>
	<cfparam name="form.rptType" default="1002">
</cfif>

<table align="left" cellpadding="10" cellspacing="0" border="0" class="box" width="50%">	

<script language="JavaScript">
function resetPartner(){
if(document.fReportHandler.partner != undefined){
document.fReportHandler.partner.value="ALL";
}
document.fReportHandler.target="_self";
document.fReportHandler.action="reportHandler_modSP.cfm<cfoutput>?#session.urltoken#</cfoutput>";
document.fReportHandler.submit();
}

function resetStrategy(){
if(document.fReportHandler.strategy != undefined){
document.fReportHandler.strategy.value="ALL";
}
document.fReportHandler.target="_self";
document.fReportHandler.action="reportHandler_modSP.cfm<cfoutput>?#session.urltoken#</cfoutput>";
document.fReportHandler.submit();
}

function resetGoal(){
if(document.fReportHandler.objective != undefined){
if(document.fReportHandler.goal == "ALL"){
document.fReportHandler.objective.value="NA";
}
}
document.fReportHandler.target="_self";
document.fReportHandler.action="reportHandler_modSP.cfm<cfoutput>?#session.urltoken#</cfoutput>";

document.fReportHandler.submit();
}

function chkSubmit(){

document.fReportHandler.target="_blank";
document.fReportHandler.action="rpt_switchSP.cfm<cfoutput>?#session.urltoken#</cfoutput>";
document.fReportHandler.submit();
}

function setType(){
<!--- document.fReportHandler.target="_top"--->
 document.fReportHandler.target="_self";
document.fReportHandler.action="reportHandler_modSP.cfm<cfoutput>?#session.urltoken#</cfoutput>";
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
<!--- 	<cfif session.regionManage EQ "0" OR session.statemanage EQ "0" AND QuserArea.area NEQ "0">
	and a.num = '#QuserArea.area#'
	</cfif> --->
	<cfif session.cntMan EQ 1 AND SESSION.CessMan EQ "0">
	and a.num in 
	(select distinct a.num from area as a, contact c
where a.num=c.area and c.cmanager = <cfif isDefined("session.origUserID")>'#session.origUserID#'<cfelse>'#session.userid#'</cfif>)
	
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
	and c2.partnertype=4
	and c2.userid= s.userid
	and s.del is null
	and c.coordemail not like '%rti.org'
	and (s.endyear is null or s.endyear > getdate())
	and c.userid != 'dplotner'	
	order by 1
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
	and (coordemail not like '%rti.org' and  c.orgname not like 'test%')
	

and (s.del is null or s.del !=1)
and (s.endyear is null or s.endyear > '7/1/#session.fy#')
	<cfif session.userid NEQ "test_sp">and (coordemail is null or coordemail not like '%rti.org') </cfif>
	
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
	and c.partnertype=4
	and c.orgname is not null
	and c.orgname != ''
	order by 1
</cfquery>



<cfquery datasource="#application.DataSource#" 	 
	password="#Application.db_password#"  		
	username="#Application.db_username#" name="Qpartner_sp">
	select c.orgName as partner, c.userid
	from contact as c, security as s --, region as r, area as a
	where c.userid=s.userid
	--and r.num=a.region
	--and r.year2=a.year2
	--and s.area=a.num
	--and a.year2=2010
	and (coordemail is not null and coordemail not like '%rti.org' and c.userid not like 'test%')
	and partnertype = 4
	

and (s.del is null or s.del !=1)
and (s.endyear is null or s.endyear > '7/1/#session.fy#')
	<cfif session.areaManage EQ "0" AND session.regionManage EQ "0" AND session.statemanage EQ "0" AND QuserArea.area NEQ "0">
	and c.userid = '#session.userid#'	
	</cfif>
	and c.orgname is not null
	and c.orgname != ''
	and s.del is null
	<cfif isDefined("form.CM") and form.CM NEQ "ALL">
	and c.cmanager = '#form.cm#'
	</cfif>
	order by 1			
		
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
	username="#Application.db_username#" name="QFarea">
	select strategy as descr, strategy_Num as num
	from strategy 
	where year2=#session.fy#
	<cfif isDefined("form.rptType") and form.rptType EQ "6">and strategy_Num !=10</cfif>
	order by 2
</cfquery>

<cfquery datasource="#application.DataSource#"   		 
	password="#Application.db_password#"  		
	username="#Application.db_username#" name="Qmonths">
	<cfif session.fy GTE 2013>
	select mon, sp_rank as rank
	<cfelse>
	
	select mon, rank as rank
	</cfif>
	from 
	months	where year2 = #session.fy#
	<cfif session.fy EQ 2010>
	and mon_num != 7
	</cfif>
	<cfif session.fy EQ session.def_fy>and sp_rank <= (select sp_rank from months where mon = '#MonthAsString(Month(now()))#' and year2 = '#session.fy#')</cfif>
	order by 2
</cfquery>


<cfform scriptSrc="/scripts" name="fReportHandler">

<tr><td colspan=2 style="border-bottom : thin solid Navy;"><h5>Healthy Schools New York Reports</h5></td></tr>
<tr>
	<td>Report Type</td>
	<td>
		<select name="rptType" onChange="setType();">
		<cfif #session.fy# is not '2000'>
			<option value="1001" <cfif isDefined("form.rptType") and form.rptType EQ "1001"> selected</cfif>>Contract Manager Feedback Report
			
			<cfif #session.fy# GTE 2011>
				<option value="666" <cfif isDefined("form.rptType") and form.rptType EQ "666"> selected</cfif>>HSNY Monthly Activity Report
				<option value="1002" <cfif isDefined("form.rptType") and form.rptType EQ "1002"> selected</cfif>>HSNY Policy Report
			</cfif>			
			
			
			<cfif #session.fy# LTE 2010>
				<option value="1" <cfif isDefined("form.rptType") and form.rptType EQ "1"> selected</cfif>>Detailed Monthly Strategy Report Entries 
				<option value="4" <cfif isDefined("form.rptType") and form.rptType EQ "4"> selected</cfif>>Earned Media Summary Report
	
	
					<cfif session.fy EQ 2007>
						<option value="42" <cfif isDefined("form.rptType") and form.rptType EQ "42"> selected</cfif>>End-of-year Area Manager Feedback Report
							<cfif SESSION.TCP EQ "1" or  SESSION.admin EQ "1" or  SESSION.areamanage EQ "1">
								<option value="41" <cfif isDefined("form.rptType") and form.rptType EQ "41"> selected</cfif>>End-of-year Report Status
						</cfif>
						<option value="40" <cfif isDefined("form.rptType") and form.rptType EQ "40"> selected</cfif>>End-of-year Report Summary
					</cfif>	 
			
					<cfif session.fy EQ 2008>
					<cfif SESSION.modality EQ 4 or SESSION.TCP EQ "1" or SESSION.CessMan EQ "1" or  SESSION.admin EQ "1" or  SESSION.areamanage EQ "1" or Session.CManager EQ "1">
						<option value="53" <cfif isDefined("form.rptType") and form.rptType EQ "53"> selected</cfif>>End-of-year Report Summary (SP)
						<option value="50" <cfif isDefined("form.rptType") and form.rptType EQ "50"> selected</cfif>>End-of-year Report Summary with TCP Feedback (SP)
					</cfif>		
					</cfif>	
	
	
							
			<option value="31" <cfif isDefined("form.rptType") and form.rptType EQ "31"> selected</cfif>>SP Checklist of Activity Types by School or District Report
			<option value="30" <cfif isDefined("form.rptType") and form.rptType EQ "30"> selected</cfif>>School Policy Advocacy Progress Summary Report
			<option value="44" <cfif isDefined("form.rptType") and form.rptType EQ "44"> selected</cfif>>SP Progress Milestones – by Contract Year
			
	
			<cfif session.fy LTE 2007>
				<option value="33" <cfif isDefined("form.rptType") and form.rptType EQ "33"> selected</cfif>>School Policy Observational Data Summary Report
			</cfif>
			<option value="37" <cfif isDefined("form.rptType") and form.rptType EQ "37"> selected</cfif>>School Policy Resources/Mini-grants/Stipends awarded
			
			<option value="1234" <cfif isDefined("form.rptType") and form.rptType EQ "1234"> selected</cfif>>SP Infrastructure Report: Recent Activity
			<option value="1000" <cfif isDefined("form.rptType") and form.rptType EQ "1000"> selected</cfif>>SP Milestones - Progress Towards Outcomes		
		
			
			<option value="39" <cfif isDefined("form.rptType") and form.rptType EQ "39"> selected</cfif>>SP Policy Passed Report - by Contract Year
			<option value="51" <cfif isDefined("form.rptType") and form.rptType EQ "51"> selected</cfif>>SP Policy Passed Report - cumulative
		
			
			<option value="6" <cfif isDefined("form.rptType") and form.rptType EQ "6"> selected</cfif>>Strategy Progress Summary Report
			<option value="18" <cfif isDefined("form.rptType") and form.rptType EQ "18"> selected</cfif>>Summary of Advocating-SP MSR
			
		 <cfelse>
		 	<option value="">
			
		</cfif>
		</cfif>
		
		<cfif session.userid EQ 'dplotner'>
		</cfif>
		</select>
	</td>
</tr>
<!--- <cfif NOT isDefined("form.rptType") OR (isDefined("form.rptType") and (form.rptType EQ "1" OR form.rptType EQ "2" OR form.rptType EQ "4" OR form.rptType EQ "6"  OR form.rptType EQ "8"  OR form.rptType EQ "9" OR form.rptType EQ "10" OR form.rptType EQ "11" OR form.rptType EQ "12" OR form.rptType EQ "13" OR form.rptType EQ "14" OR form.rptType EQ "15" OR form.rptType EQ "16" OR form.rptType EQ "17" OR form.rptType EQ "22" or form.rptType EQ "18" or form.rptType EQ "30"  or form.rptType EQ "31" or form.rptType EQ "32" OR form.rptType EQ "33" OR form.rptType EQ "34" OR form.rptType EQ "35" OR form.rptType EQ "36" OR form.rptType EQ "37" OR form.rptType EQ "38"))>

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
</cfif> 

<tr><td><br><br></td></tr>--->
<input type="hidden" name="format" value="PDF">

<cfif (session.admin EQ "1" OR session.statemanage EQ "1" OR session.regionmanage EQ "1" OR session.areamanage EQ "1") and NOT (isDefined("form.rptType") and (form.rptType EQ "1000" OR form.rptType EQ "1234" OR form.rptType EQ "1001" OR form.rptType EQ "1002" OR form.rptType EQ "666"))>
<tr>
<td>Region:</td>
<td>
	<select name="Region" onChange="resetPartner();">
		<cfoutput>
			<cfif session.statemanage EQ "1" or Session.admin EQ "1">
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

</cfif>




<cfif ((session.admin EQ "1" OR session.statemanage EQ "1" OR session.cntMan EQ "1" OR session.regionmanage EQ "1" OR session.areamanage EQ "1") and (isDefined("rptType") and (form.rptType EQ 666 or form.rptType EQ 1000 or form.rptType EQ 1234 or form.rptType EQ 1001 or form.rptType EQ 1002 or form.rptType EQ 666)))>

<tr>
<td>Contract Manager:</td>
<td>
	<select name="CM" onChange="resetPartner();">
		<cfoutput>
			<!--- <cfif session.statemanage EQ "1" or Session.admin EQ "1" or session.cessman NEQ 0>
				<option value="ALL"<cfif isDefined("form.area") and form.area EQ "ALL"> selected</cfif>>ALL Contract Managers
			</cfif> --->
			<option value="ALL"<cfif isDefined("form.CM") and form.CM EQ "ALL"> selected</cfif>>ALL Contract Managers
			<cfloop query="QCM">
				<option value="#QCM.CMid#"<cfif isDefined("form.CM") and form.CM EQ QCM.CMid> selected</cfif>>#CMName#
			</cfloop>
		</cfoutput>
	</select>
</td>
</tr>
</cfif>


<cfif 
<!--- ((isDefined("form.area") AND form.area NEQ "ALL") OR (session.admin NEQ "1" and session.statemanage NEQ "1" ))  --->
((isDefined("form.region") AND form.region NEQ "ALL") OR (session.admin NEQ "1" and session.statemanage NEQ "1" )) 
and 
((isDefined("form.rptType") and form.rptType NEQ "22" and form.rptType NEQ "1000" and form.rptType NEQ "1234" and form.rptType NEQ "1001"  and form.rptType NEQ "1002"  and form.rptType NEQ "666"<!--- and form.rptType NEQ "34" --->) or not isDefined("form.rptType"))>
<tr>	
	<td>Partner Name:</td>
	<td>
		<select name="partner" onchange="resetStrategy();">
		<cfoutput>
				<cfif session.statemanage EQ "1" OR session.areamanage EQ "1" or session.admin EQ "1">
					<option value="ALL" <cfif isDefined("form.partner") and form.partner EQ "ALL"> selected</cfif>>All Partners
				</cfif>
			<cfloop query="Qpartner">
				<option value="#Qpartner.userid#"<cfif isDefined("form.partner") and form.partner EQ "#Qpartner.userid#"> selected</cfif>>#partner#
			</cfloop>
			
		</cfoutput>
		</select>
	</td>
</tr>

<cfelseif isDefined("form.rptType") and (form.rptType EQ "1000" or form.rptType EQ "1234" or form.rptType EQ "1001" or form.rptType EQ "1002" or form.rptType EQ "666")>
<tr>	
	<td>Contractor Name:</td>
	<td>
		<select name="partner">
		<cfoutput>
			<cfif session.statemanage EQ "1" OR session.areamanage EQ "1" or session.admin EQ "1" or session.cessman NEQ 0>
					<option value="ALL" <cfif isDefined("form.partner") and form.partner EQ "ALL"> selected</cfif>>All Contractors
			</cfif>
			<cfloop query="Qpartner_sp">
					<option value="#Qpartner_sp.userid#"<cfif isDefined("form.partner") and form.partner EQ "#Qpartner_sp.userid#"> selected</cfif>>#partner#
			</cfloop>				
		</cfoutput>
		</select>
	</td>
</tr>
</cfif>

<!--- <cfif NOT isDefined("form.area") OR form.area NEQ "ALL">
<input type="hidden" name="partner" value="ALL">
</cfif> --->
<cfif (isDefined("form.rptType") and form.rptType NEQ "44" and form.rptType NEQ "43" and form.rptType NEQ "7"  and form.rptType NEQ "8" and form.rptType NEQ "9" and form.rptType NEQ "10" and form.rptType NEQ "11" and form.rptType NEQ "12" and form.rptType NEQ "22"  and form.rptType NEQ "18" and  form.rptType NEQ "30" and  form.rptType NEQ "31"  and  form.rptType NEQ "32" and  form.rptType NEQ "34"  
		and  form.rptType NEQ "35"  and  form.rptType NEQ "36"  and  form.rptType NEQ "37" and form.rptType NEQ "38" and form.rptType NEQ "39" and form.rptType NEQ "51" and form.rptType NEQ "45" and  form.rptType NEQ "40" and  form.rptType NEQ "41" and  form.rptType NEQ "42" and  form.rptType NEQ "50" and  form.rptType NEQ "53" and form.rptType NEQ "1002") or not isDefined("form.rptType")>
<cfif (NOT(isDefined("form.rptType") and (form.rptType EQ "1000" or form.rptType EQ "1234" or form.rptType EQ "1001" or form.rpttype eq "666")) and ((isDefined("form.partner") AND form.partner NEQ "ALL") OR (session.admin NEQ "1" and session.statemanage NEQ "1"  and session.regionmanage NEQ "1" and session.areamanage NEQ "1" and session.tcp NEQ "1" )))  >
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

<cfif (not isDefined("form.rptType")) OR (isDefined("form.rptType") and (form.rptType EQ "666" OR form.rptType EQ "1" OR form.rptType EQ "4" OR form.rptType EQ "6" OR form.rptType EQ "7" OR form.rptType EQ "9" OR form.rptType EQ "10"  OR form.rptType EQ "13"  OR form.rptType EQ "14" OR form.rptType EQ "15"  OR form.rptType EQ "16" or form.rptType EQ "18" or form.rptType EQ "30"  or  form.rptType EQ "31" or  form.rptType EQ "1234" or form.rptType EQ "1001"))>

<tr><td>Date Range:</td><td><table class="box">

<tr>
	<td>Start Month:</td>
	<td>
		<CFOUTPUT>
		<select name="stmonth" >
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
		<select name="endmonth" >
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
 
<cfelseif isDefined("form.rptType") and (form.rptType EQ "8" or form.rptType EQ "32" or form.rptType EQ "33" or form.rptType EQ "34" or form.rptType EQ "35" or form.rptType EQ "36" or form.rptType EQ "38")>
<tr><td>Date Range:</td><td><table class="box">

<tr>
	<td>Starting Year:</td>
	<td>
		<CFOUTPUT>
		<select name="stYear">
				<option value="1904">2005-2006
			<CFLOOP from="2007" to="#session.fy#" index="yrloop">
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
		<CFOUTPUT>
		<select name="endYear">
				<option value="1904">2005-2006
			<CFLOOP from="2007" to="#session.fy#" index="yrloop">
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
</cfif>
<cfif (isDefined("form.rptType") and form.rptType NEQ "44" and form.rptType NEQ "43" and form.rptType NEQ "7" and form.rptType NEQ "8" and form.rptType NEQ "9" 
		and form.rptType NEQ "10" and form.rptType NEQ "11" and form.rptType NEQ "12"  and form.rptType NEQ "22"  
			and form.rptType NEQ "18" and form.rptType NEQ "30" and  form.rptType NEQ "31" and  form.rptType NEQ "32" 
				and  form.rptType NEQ "33" and  form.rptType NEQ "34" and  form.rptType NEQ "35" and  form.rptType NEQ "36" 
					and  form.rptType NEQ "37" and  form.rptType NEQ "38" and  form.rptType NEQ "39"  and form.rptType NEQ "51" 
						and form.rptType NEQ "45" and  form.rptType NEQ "40" and  form.rptType NEQ "41" and  form.rptType NEQ "42" 
							and  form.rptType NEQ "50" and  form.rptType NEQ "53" and form.rptType NEQ "1000" 
								and  form.rptType NEQ "1234" and form.rptType NEQ "1001" and form.rptType NEQ "1002" and form.rptType NEQ "666") or not isDefined("form.rptType")>
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
</cfif></cfif>


</td>
</tr>


<cfif (isDefined("form.rptType") and form.rptType NEQ "14" and form.rptType NEQ "15" and form.rptType NEQ "16" and form.rptType NEQ "22" and  form.rptType NEQ "40" and  form.rptType NEQ "41" and  form.rptType NEQ "42" and  form.rptType NEQ "50" and  form.rptType NEQ "53" and form.rptType NEQ "1000" and  form.rptType NEQ "1234" and form.rptType NEQ "1001")>
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
</cfif>
<tr><td></td><td><input type="Button" value="Generate Report" onClick="chkSubmit();"></td></tr>
</table>


</cfform>

</body>
</html>
