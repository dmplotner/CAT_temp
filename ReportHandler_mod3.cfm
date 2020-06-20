<cfif session.userid EQ 'mgallagher'>
	<cfset form.rptType = 427>
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
document.fReportHandler.action="reportHandler_mod3.cfm<cfoutput>?#session.urltoken#</cfoutput>";
document.fReportHandler.submit();
}

function resetStrategy(){
if(document.fReportHandler.strategy != undefined){
document.fReportHandler.strategy.value="ALL";
}
document.fReportHandler.target="_self";
document.fReportHandler.action="reportHandler_mod3.cfm<cfoutput>?#session.urltoken#</cfoutput>";
document.fReportHandler.submit();
}

function resetGoal(){
if(document.fReportHandler.objective != undefined){
if(document.fReportHandler.goal == "ALL"){
document.fReportHandler.objective.value="NA";
}
}
document.fReportHandler.target="_self";
document.fReportHandler.action="reportHandler_mod3.cfm<cfoutput>?#session.urltoken#</cfoutput>";

document.fReportHandler.submit();
}

function chkSubmit(){

document.fReportHandler.target="_blank";
document.fReportHandler.action="rpt_switch2.cfm<cfoutput>?#session.urltoken#</cfoutput>";
document.fReportHandler.submit();
}

function setType(){
document.fReportHandler.target="_self";
document.fReportHandler.action="reportHandler_mod3.cfm<cfoutput>?#session.urltoken#</cfoutput>";
document.fReportHandler.submit();
}


</script>
<cfparam name="reportuser" default="#session.userid#">
<cfparam name="form.Region" default="ALL">
<cfparam name="form.rptType" default="555">


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
	and r.num !=5
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
</cfquery>


<cfquery datasource="#application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="QCM">
	select distinct c.contact as CMName , c.userid as CMid
	from contact as c, contact as c2, security s
	where c.userid=c2.cmanager
	and c2.partnertype=1
	and c2.userid=s.userid
	and (s.endyear is null or s.endyear > getdate())
	and c.userid != 'dplotner'

	order by 1
</cfquery>


<cfquery datasource="#application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="Qpartner_cc">
	select
c.orgName  as partner, c.userid
from contact c, security s, contact cc, modality m
where c.partnertype = m.modality
and c.userid = s.userid
and c.cmanager=cc.userid
and (s.del is null or s.del !=1)
and (s.endyear is null or s.endyear > '7/1/#session.fy#')
and (c.email is null or (c.email not like '%rti.org' and NOT(c.coordemail like '%health.state.ny.us%' OR c.email  like '%health.state.ny.us%')  and NOT(c.coordemail like '%health.ny.gov%' OR c.email  like '%health.ny.gov%')))
and c.userid <> 'RoswellParkCP' and c.userid <> 'LOlson'
and c.partnertype =1
	<cfif session.areaManage EQ "0" AND session.regionManage EQ "0" AND session.statemanage EQ "0" AND QuserArea.area NEQ "0">
	and c.userid = '#session.userid#'
	</cfif>
	<!--- <cfif isDefined("form.rptType") and (form.rptType EQ 8 or form.rptType EQ 18 or form.rptType EQ 19 or form.rptType EQ 25 or form.rptType EQ 21 or form.rptType EQ 24 or form.rptType EQ 33)>
	and c.partnertype=1
	</cfif>
	<cfif isDefined("form.modality") and form.modality NEQ "ALL">
	and c.partnertype=#form.modality#
	</cfif> --->
	and c.orgname is not null
	and c.orgname != ''
	and s.del is null
	<cfif isDefined("form.CM") and form.CM NEQ "ALL">
	and c.cmanager = '#form.cm#'
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
	username="#Application.db_username#" name="QObj1">
	Select initiative as objective, id
	from objectives
	where year2=#session.fy#
	and (del is null or del  != '1') and 1 like modality and id <> '8C'
	order by 2
</cfquery>
<cfquery datasource="#application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="QObj2">
	Select initiative as objective, id
	from objectives
	where year2=#session.fy#
	and (del is null or del  != '1') and modality like '%2%'
	order by 2
</cfquery>
<cfquery datasource="#application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="QObj3">
	Select initiative as objective, id
	from objectives
	where year2=#session.fy#
	and (del is null or del  != '1') and modality like '%3%'
	order by 2
</cfquery>
<cfquery datasource="#application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="QObj5">
	Select initiative as objective, id
	from objectives
	where year2=#session.fy#
	and (del is null or del  != '1') and modality like '%5%'
	order by 2
</cfquery>
<cfquery datasource="#application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="QObjall">
	Select initiative as objective, id
	from objectives
	where year2=#session.fy#
	and (del is null or del  != '1')
	and (modality like '%2%' or modality like '%3%' or modality like '%5%')
	order by 2
</cfquery>
<cfquery datasource="#application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="QFarea">
	select strategy as descr, strategy_Num as num
	from strategy
	where year2=#session.fy#
	<cfif isDefined("form.rptType") and form.rptType EQ "6" and form.rptType EQ "66">and strategy_Num !=10</cfif>
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
	select mon, mon_num, rank, max(rank) as maxrank
	from
	months
	group by mon,mon_num,rank,year2
	having
	year2 = #session.fy#
	<cfif session.fy EQ 2010>
	and mon_num != 7
	</cfif>
	<cfif session.fy EQ session.def_fy and session.def_fy NEQ 2018>
		and rank <= (select rank from months where mon = '#MonthAsString(Month(now()))#' and year2 = #session.fy#)
	</cfif>
		order by 3
</cfquery>
<cfform scriptSrc="/scripts" name="fReportHandler">
<input type="hidden" name="mod" value=1>
<!--- <table> --->
<tr><td colspan=2 style="border-bottom : thin solid Navy;"><h5>
	<cfif session.fy LT 2015>Cessation Center<cfelse>Health Systems Change</CFIF> Reports</h5></td></tr>
<tr>
	<td>Report Type</td>
	<td>

		<select name="rptType" onChange="setType();">
			<option value=""> - Select a report -</option>
<cfif session.userid NEQ 'mgallagher'>
			<cfif session.fy LT 2016>
				<option value="555" <cfif isDefined("form.rptType") and form.rptType EQ "555"> selected</cfif>>Cessation Center Maintenance: Primary Measures Report
			</cfif>
			<option value="22" <cfif isDefined("form.rptType") and form.rptType EQ "22"> selected</cfif>>Contractor Monthly Activity Report - HS

			<cfif session.fy LT 2016>
				<option value="6" <cfif isDefined("form.rptType") and form.rptType EQ "6"> selected</cfif>>Cessation Center Progress Milestones
			</cfif>
			<option value="3" <cfif isDefined("form.rptType") and form.rptType EQ "3"> selected</cfif>>Contract Manager Feedback Report

			<cfif session.fy LT 2013>
			<option value="2" <cfif isDefined("form.rptType") and form.rptType EQ "2"> selected</cfif>>Contractor Monthly Activity Report - CC
			</cfif>

			<!---<option value="5" <cfif isDefined("form.rptType") and form.rptType EQ "5"> selected</cfif>>Cessation Center Progress Summary Report--->
</cfif>
<cfif session.fy GTE 2017>
			<option value="900" <cfif isDefined("form.rptType") and form.rptType EQ "900"> selected</cfif>>Disparities
</CFIF>

<option value="427" <cfif isDefined("form.rptType") and form.rptType EQ "427"> selected</cfif>>Garnered Earned Media

	<option value="428" <cfif isDefined("form.rptType") and form.rptType EQ "428"> selected</cfif>>Health Systems Outcomes

<cfif session.userid EQ 'twills'>
<option value="429" <cfif isDefined("form.rptType") and form.rptType EQ "429"> selected</cfif>>Health Systems Outcomes TEST




</cfif>
									<option value="901"
									<cfif isDefined("form.rptType") and form.rptType EQ "901">
										selected
									</cfif>
									>HUD
																
<!--- <cfif session.userid EQ 'dplotner' OR session.userid EQ 'nsarris'><option value="555" <cfif isDefined("form.rptType") and form.rptType EQ "555"> selected</cfif>>Cessation Center Maintenance: Primary Measures Report</cfif> --->

		</select>
	</td>
</tr>

<input type="hidden" name="format" value="PDF">
<input type="hidden" name="modality" value="1">
<tr><td><br><br></td></tr>



<!--- <cfif (((isDefined("form.rptType") and form.rptType NEQ "340") OR NOT isDefined("form.rptType")) and (session.admin EQ "1" OR session.statemanage EQ "1" OR session.regionmanage EQ "1" OR session.areamanage EQ "1"  OR session.cntMan EQ "1")) <!--- and NOT (isDefined("rptType") and (form.rptType EQ 8)) --->>

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
			</cfloop>
		</cfoutput>
	</select>
</td>
</tr>
</cfif> --->
<input type="hidden" name="Region" value="ALL">
<cfif (isDefined("rptType") and ( form.rptType NEQ 555)) or not isDefined("rptType") >

<cfif ((session.admin EQ "1" OR session.statemanage EQ "1" OR session.cntMan EQ "1" OR session.regionmanage EQ "1" OR session.areamanage EQ "1") and NOT (isDefined("rptType") and ( form.rptType EQ 33)))>

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




<cfif isDefined("form.rptType") and form.rptType EQ "34" and (session.statemanage NEQ "1" and  Session.admin NEQ "1") AND session.areamanage EQ "1">
	<input type="hidden" name="area" value="<cfoutput>#QArea.num#</cfoutput>">
</cfif>
<cfif
((isDefined("form.region") <!--- AND form.region NEQ "ALL" --->) OR (session.admin NEQ "1" and session.statemanage NEQ "1" ))
and
((isDefined("form.rptType") and  form.rptType NEQ "23") or not isDefined("form.rptType"))>
<tr>
	<td>Contractor Name:</td>
	<td>
		<select name="partner" <cfif NOT isDefined("form.rptType")
				OR (isDefined("form.rptType") and form.rptType NEQ "50" and form.rptType NEQ "51" and form.rptType NEQ "52" and form.rptType NEQ "53" and form.rptType NEQ "54"
					and form.rptType NEQ "55")>onchange="resetStrategy();"</cfif>>
		<cfoutput>
			<cfif session.statemanage EQ "1" OR session.areamanage EQ "1" or session.admin EQ "1" or session.cessman NEQ 0>
					<option value="ALL" <cfif isDefined("form.partner") and form.partner EQ "ALL"> selected</cfif>>All Contractors
			</cfif>
		
			<cfloop query="Qpartner_cc">
					<option value="#Qpartner_cc.userid#"<cfif isDefined("form.partner") and form.partner EQ "#Qpartner_cc.userid#"> selected</cfif>>#partner#
			</cfloop>
		</cfoutput>
		</select>
	</td>
</tr>
</cfif>

<cfif (not isDefined("form.rptType")) OR (isDefined("form.rptType") and (form.rpttype eq "901" or form.rpttype eq "900" or form.rpttype eq "429" or form.rptType EQ "1" OR form.rptType EQ "2" OR form.rptType EQ "3" OR form.rptType EQ "22"))>

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
													<option value="#rank#"
													<cfif (#maxrank# eq #rank# or (isDefined("form.endmonth") and form.endmonth EQ "#rank#")OR (NOT isDefined("form.endmonth") AND rank EQ "12"))>
														selected
													</cfif>
													>#mon#
												</CFLOOP>
											</select>		</CFOUTPUT>
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


<cfif (form.rpttype EQ 900)>
<tr>
<td>Topic:</td>
<td>
	<CFOUTPUT>
		<select name="topic" multiple   class="mlti">
				<option value="ALL"> All Topics
				<!--- <option value="2D"> Point of Sale
				<option value="3M"> Smoke-free Media
				<option value="4F"> Smoke-free Multi-unit Housing
				<option value="2E"> Tobacco-free Outdoors
				<option value="8C"> Cessation Services and Media
				--->
				<option value="8A"> Medical Health Systems Change
				<option value="8B"> Mental Health Systems Change
				<option value="9x"> Other
		</select>
	</CFOUTPUT>
</td>
</tr>
</cfif>


<cfif not isdefined("form.rptType") or (form.rpttype NEQ 901 and form.rpttype NEQ 3 and form.rpttype neq 6 and form.rpttype neq 66  and form.rpttype neq 900)>
<tr>
<td>Initiative:</td>
<td>
	<CFOUTPUT>
		<select name="objective" multiple   class="mlti">
				<option value="ALL"> All Initiatives
			  <cfif form.rpttype eq 427>
                <cfif session.fy LT 2013>
					<option value="init7">Comprehensive School Policy</option>
				</cfif>
                <option value="init6">Health Systems Change</option>
                <option value="init1">Sustainability</option>
                <option value="init10">Tobacco Cessation / Quitline </option>
                <option value="init11">Tobacco Use disparities</option>

<cfelse>
			<CFLOOP query="Qobj1">
				<option value="#id#" <cfif isDefined("form.objective") AND form.objective EQ "#id#"> selected</cfif>>#objective#
			</CFLOOP>
		<!---		<option value="em" <cfif isDefined("form.objective") AND form.objective EQ "imnf"> selected</cfif>>Earned Media
				<option value="inf" <cfif isDefined("form.objective") AND form.objective EQ "inf"> selected</cfif>>Infrastructure

</option>---></cfif>
		</select>
	</CFOUTPUT>
</td>
</tr>
</cfif>

</td>
</tr>


</cfif>

<tr><td></td><td><input type="Button" value="Generate Report" onClick="chkSubmit();"></td></tr>
</table>


</cfform>

</body>
</html>
