<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>CAT</title>


<cfinclude template="CATstruct.cfm">
<cfif not isDefined("session.origUserID")>
	<cfset session.origUserID=session.userid>
</cfif>

 <cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="Qmonths">
select mon, mon_num
from months
where year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
order by rank
</cfquery>
 <cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="Qmonths2">
select mon,  mon_num
from months
where year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
order by sp_rank
</cfquery>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QPartnerList">
select
c.userid, orgname, --a.area, partnertype
R.REGION AS AREA
from contact as c, security as s, area as a, REGION AS R
where c.userid=s.userid
and s.area = a.num
AND R.NUM=A.REGION
and a.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
AND A.YEAR2=R.YEAR2
<cfif   NOT(session.userid EQ 'dplotner' or session.userid eq 'nsarris') >
	and c.partnertype !=4
</cfif>
and orgname is not null and orgname !=''
--and partnertype !=4
and (s.del is null or s.del !=1)
and (s.endyear is null or s.endyear > <cfqueryparam value="7/1/#session.fy#" cfsqltype="CF_SQL_DATE">)
and (1=2
	<cfif session.cntMan EQ 1>
	<cfif session.origUserID EQ "vxc04">
	or c.userid in('tompkins-co', 'carthageareahospital',
	'CCTFP','CUE_ACAA','mvnhealthAA','ongovAA','oswegocp','TPACC2','chenangohealth',
	'uhs2', 'carthageareahospital', 'sjhsyr', 'mvnhealthCC')
	</cfif>
	or c.cmanager=<cfqueryparam value="#session.origUserID#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">
	</cfif>
	<cfif  (session.userid EQ 'dplotner')OR ((session.admin EQ 1  OR session.tcp EQ 1 OR session.statemanage EQ 1)  AND (not isDefined("session.cessman") or
			(session.cessman NEQ 1 and session.cessman NEQ 2 and session.cessman NEQ 3 and session.cessman NEQ 4 and session.cessman does not contain "5" and session.cessman does not contain "6")) and session.cntMan EQ 0 ) >
	or 1=1
	</cfif>
	<cfif isDefined("session.cessman")>
	<cfif session.cessman contains 1>
		or c.partnertype = 1
	</cfif><cfif session.cessman contains 2>
		or c.partnertype = 2
	</cfif><cfif session.cessman contains 3>
		or c.partnertype = 3
	</cfif><cfif session.cessman contains 4>
		or c.partnertype = 4
	</cfif><cfif session.cessman contains 5>
		or c.partnertype = 5
	</cfif><cfif session.cessman contains 6>
		or c.partnertype = 6
	</cfif>
	</cfif>
)

<!--- added 8/6/2017 --->
and isNull(c.coordemail,'rti.org') not like '%rti.org' and NOT(c.coordemail like '%health.state.ny.us%' OR c.email  like '%health.state.ny.us%')  and NOT(c.coordemail like '%health.ny.gov%' OR c.email  like '%health.ny.gov%')
and c.orgname not in('Ann L.-- CP','Ann Whitfield-Green','Christina.peluso','Jill Dunkel','Julie steele','Van')

<!--- added 8/6/2017 --->
<cfif (session.origUserID EQ "julie.wright") OR  (session.UserID EQ "julie.wright")>
and c.partnertype in (1,6)
and c.userid not like 'tst_%'
<cfelseif (session.origUserID EQ "eas10") OR  (session.UserID EQ "eas10")>
and c.partnertype = 2
and c.userid not like 'tst_%'
</cfif>
order by  3,2
</cfquery>




<cfset form.year=session.fy>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="dispUsers">
select orgname,
--a.area,
R.REGION AS AREA,
c.userid,
sum(case when q.mon=8 then
case cntrReview when 1 then 2 else case when submitdt is not null then 1 else 3 end end else 0 end) as August,
sum(case when q.mon=9 then
case cntrReview when 1 then 2 else case when submitdt is not null then 1 else 3 end end else 0 end) as September,
sum(case when q.mon=10 then
case cntrReview when 1 then 2 else case when submitdt is not null then 1 else 3 end end else 0 end) as October,
sum(case when q.mon=11 then
case cntrReview when 1 then 2 else case when submitdt is not null then 1 else 3 end end else 0 end) as November,
sum(case when q.mon=12 then
case cntrReview when 1 then 2 else case when submitdt is not null then 1 else 3 end end else 0 end) as December,
sum(case when q.mon=1 then
case cntrReview when 1 then 2 else case when submitdt is not null then 1 else 3 end end else 0 end) as January,
sum(case when q.mon=2 then
case cntrReview when 1 then 2 else case when submitdt is not null then 1 else 3 end end else 0 end) as February,
sum(case when q.mon=3 then
case cntrReview when 1 then 2 else case when submitdt is not null then 1 else 3 end end else 0 end) as March,
sum(case when q.mon=4 then
case cntrReview when 1 then 2 else case when submitdt is not null then 1 else 3 end end else 0 end) as April,
sum(case when q.mon=5 then
case cntrReview when 1 then 2 else case when submitdt is not null then 1 else 3 end end else 0 end) as May,
sum(case when q.mon=6 then
case cntrReview when 1 then 2 else case when submitdt is not null then 1 else 3 end end else 0 end) as June,
sum(case when q.mon=7 then
case cntrReview when 1 then 2 else case when submitdt is not null then 1 else 3 end end else 0 end) as July , partnertype
from
security as s,
area as a, REGION AS R,
contact as c
left outer join CMfeedback as q  on q.userid=c.userid
and q.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
where
--c.userid in (#quotedValueList(QPartnerList.userid)#)
--and
a.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
and s.userid=c.userid
and s.area=a.num
AND A.YEAR2=R.YEAR2
AND A.REGION=R.NUM
and orgname is not null and orgname !=''
--and partnertype !=4
<cfif   NOT(session.userid EQ 'dplotner' or session.userid eq 'nsarris') >
	and c.partnertype !=4
	</cfif>
and (s.del is null or s.del !=1)
and (s.endyear is null or s.endyear > <cfqueryparam value="7/1/#session.fy#" cfsqltype="CF_SQL_DATE">)
and (1=2
	<cfif session.cntMan EQ 1>
	<cfif session.origUserID EQ "vxc04">
	or c.userid in('tompkins-co', 'carthageareahospital',
	'CCTFP','CUE_ACAA','mvnhealthAA','ongovAA','oswegocp','TPACC2','chenangohealth')
	</cfif>
	or c.cmanager=<cfqueryparam value="#session.origUserID#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">
	</cfif>
	<cfif  (session.userid EQ 'dplotner')OR
			((session.admin EQ 1  OR session.tcp EQ 1 OR session.statemanage EQ 1)
				AND (not isDefined("session.cessman") or
					(session.cessman does not contain "1"
						and session.cessman does not contain "2"
							and session.cessman does not contain "3"
								and session.cessman does not contain "4"
									and session.cessman does not contain "5"
										and session.cessman does not contain "6")) and session.cntMan EQ 0 ) >
	or 1=1
	</cfif>
	<cfif isDefined("session.cessman")>
	<cfif session.cessman contains 1>
		or c.partnertype = 1
	</cfif><cfif session.cessman contains 2>
		or c.partnertype = 2
	</cfif><cfif session.cessman contains 3>
		or c.partnertype = 3
	</cfif><cfif session.cessman contains 4>
		or c.partnertype = 4
	</cfif><cfif session.cessman contains 5>
		or c.partnertype = 5
	<cfif session.cessman contains 6>
		or c.partnertype = 6
	</cfif>
	</cfif>
	</cfif>
)

<!--- added 8/6/2017 --->
and isNull(c.coordemail,'rti.org') not like '%rti.org' and NOT(c.coordemail like '%health.state.ny.us%' OR c.email  like '%health.state.ny.us%')  and NOT(c.coordemail like '%health.ny.gov%' OR c.email  like '%health.ny.gov%')
and c.orgname not in('Ann L.-- CP','Ann Whitfield-Green','Christina.peluso','Jill Dunkel','Julie steele','Van')

<!--- added 8/6/2017 --->
<cfif (session.origUserID EQ "julie.wright") OR  (session.UserID EQ "julie.wright")>
and c.partnertype in (1,6)
and c.userid not like 'tst_%'
<cfelseif (session.origUserID EQ "eas10") OR  (session.UserID EQ "eas10")>
and c.partnertype = 2
and c.userid not like 'tst_%'
</cfif>

group by orgname,
--a.area,
R.REGION,
c.userid, partnertype
ORDER BY 2,1
</cfquery>



<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QPartnerList2">
select
c.userid, orgname, -- a.area
R.REGION AS AREA
from contact as c, security as s, area as a, REGION AS R
where c.userid=s.userid
and s.area = a.num
AND A.YEAR2=R.YEAR2
AND A.REGION=R.NUM
and a.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
 <cfif session.areamanage EQ 1 and (session.admin NEQ 1 AND session.tcp NEQ 1 AND session.statemanage NEQ 1)>
and  a.manager_id=<cfqueryparam value="#session.origUserID#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">
</cfif>
and orgname is not null and orgname !=''
and partnertype =4
and (s.del is null or s.del !=1)
and (s.endyear is null or s.endyear > <cfqueryparam value="7/1/#session.fy#" cfsqltype="CF_SQL_DATE"> )
order by  3,2
</cfquery>

<cfset form.year=session.fy>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="dispUsers2">
select orgname,
--a.area,
R.REGION AS AREA,
c.userid,
sum(case when q.month2='August' then  case q.partner_status when 1 then 3 else case q.submitted when 1 then 2 else 1 end end else 0 end) as August,
sum(case when q.month2='September' then  case q.partner_status when 1 then 3 else case q.submitted when 1 then 2 else 1 end end else 0 end) as September,
sum(case when q.month2='October' then  case q.partner_status when 1 then 2 else case q.submitted when 1 then 1 else 3 end end else 0 end) as October,
sum(case when q.month2='November' then  case q.partner_status when 1 then 2 else case q.submitted when 1 then 1 else 3 end end else 0 end) as November,
sum(case when q.month2='December' then  case q.partner_status when 1 then 2 else case q.submitted when 1 then 1 else 3 end end else 0 end) as December,
sum(case when q.month2='January' then  case q.partner_status when 1 then 2 else case q.submitted when 1 then 1 else 3 end end else 0 end) as January,
sum(case when q.month2='February' then  case q.partner_status when 1 then 2 else case q.submitted when 1 then 1 else 3 end end else 0 end) as February,
sum(case when q.month2='March' then  case q.partner_status when 1 then 2 else case q.submitted when 1 then 1 else 3 end end else 0 end) as March,
sum(case when q.month2='April' then  case q.partner_status when 1 then 2 else case q.submitted when 1 then 1 else 3 end end else 0 end) as April,
sum(case when q.month2='May' then  case q.partner_status when 1 then 2 else case q.submitted when 1 then 1 else 3 end end else 0 end) as May,
sum(case when q.month2='June' then  case q.partner_status when 1 then 2 else case q.submitted when 1 then 1 else 3 end end else 0 end) as June,
sum(case when q.month2='July' then  case q.partner_status when 1 then 2 else case q.submitted when 1 then 1 else 3 end end else 0 end) as July
from
security as s,
area as a, REGION AS R,
contact as c
left outer join AM_feedback as q  on q.partner_id=c.userid
and q.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
where
--  c.userid in (#quotedValueList(QPartnerList2.userid)#) AND
a.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
<cfif   NOT(session.userid EQ 'dplotner' or session.userid eq 'nsarris') >
	and c.partnertype !=4
</cfif>
AND A.YEAR2=R.YEAR2
AND A.REGION=R.NUM
and s.userid=c.userid
and s.area=a.num




group by orgname,
--a.area,
R.REGION,
c.userid
ORDER BY 2,1
</cfquery>



<table align="left" cellpadding="10" cellspacing="0" border="0"  class="box" width="100%">
<cfform action="contra2.cfm?#session.urltoken#&obj=1E" name="f1">
<tr>
	<td>&nbsp;<br><br></td>
</tr>
<tr>
	<th colspan="3">
		<h3>Contract Manager Feedback Grid</h3>
		<h3>Colleges for Change, Cessation Centers, Youth Partners and Community Partnerships</h3>
	</th>
</tr>
<tr><td>Select a contractor and month for a new report:</td>
<td>
<cfselect name="partnerName" query="QPartnerList" display ="orgname" value="userid">
</cfselect>
<cfselect name="rptMon" query="QMonths" display ="mon" value="mon_num">
</cfselect>
</td>
<td><input type="Submit" value="Enter Feedback" <!--- onclick="setmonth2('<cfoutput>#MonthAsString(Month(now()))#</cfoutput>');" --->></td>
</tr>
<tr><td colspan="4">
<table align="center" cellpadding="10" cellspacing="0" border="0" class="box2">
<cfoutput query="dispUsers" group="Area">
<tr><th colspan="13" align="left">#Area#</th></tr>
<tr>
	<th>Contractor</th>
	<cfif session.fy GT 2010><th>JUL</th></cfif>
	<th>AUG</th>
	<th>SEP</th>
	<th>OCT</th>
	<th>NOV</th>
	<th>DEC</th>
	<th>JAN</th>
	<th>FEB</th>
	<th>MAR</th>
	<th>APR</th>
	<th>MAY</th>
	<th>JUN</th>
	<cfif session.fy LTE 2010><th>JUL</th></cfif>
</tr>
<cfoutput>
<tr>
	<td><font color="Green">#orgname#</font></td>
	<cfif session.fy GT 2010><td align="center"><cfif #JULY# NEQ 0> <a href="contra2.cfm?#session.urltoken#&activ=#URLEncodedFormat(userid)#&amp;mon=7&obj=1E"><cfif #JULY# EQ 1>***<cfelseif #JULY# EQ 3>*<cfelse>&##8730;</cfif></a><CFELSE> -</cfif> </td></cfif>
	<td align="center"><cfif #AUGUST# NEQ 0> <a href="contra2.cfm?#session.urltoken#&activ=#URLEncodedFormat(userid)#&mon=8&obj=1E" ><cfif #AUGUST# EQ 1>***<cfelseif #AUGUST# EQ 3>*<cfelse>&##8730;</cfif></a><cfelseif partnertype EQ 4 and session.FY EQ 2010>N/A<CFELSE> -</cfif> </td>
	<td align="center"><cfif #SEPTEMBER# NEQ 0> <a href="contra2.cfm?#session.urltoken#&activ=#URLEncodedFormat(userid)#&mon=9&obj=1E"><cfif #SEPTEMBER# EQ 1>***<cfelseif #SEPTEMBER# EQ 3>*<cfelse>&##8730;</cfif></a><cfelseif partnertype EQ 4 and session.FY EQ 2010>N/A<CFELSE> -</cfif> </td>
	<td align="center"><cfif #OCTOBER# NEQ 0> <a href="contra2.cfm?#session.urltoken#&activ=#URLEncodedFormat(userid)#&mon=10&&obj=1E"><cfif #OCTOBER# EQ 1>***<cfelseif #OCTOBER# EQ 3>*<cfelse>&##8730;</cfif></a><cfelseif partnertype EQ 4 and session.FY EQ 2010>N/A<CFELSE> -</cfif> </td>
	<td align="center"><cfif #NOVEMBER# NEQ 0> <a href="contra2.cfm?#session.urltoken#&activ=#URLEncodedFormat(userid)#&mon=11&obj=1E"><cfif #NOVEMBER# EQ 1>***<cfelseif #NOVEMBER# EQ 3>*<cfelse>&##8730;</cfif></a><cfelseif partnertype EQ 4 and session.FY EQ 2010>N/A<CFELSE> -</cfif> </td>
	<td align="center"><cfif #DECEMBER# NEQ 0> <a href="contra2.cfm?#session.urltoken#&activ=#URLEncodedFormat(userid)#&mon=12&obj=1E"><cfif #DECEMBER# EQ 1>***<cfelseif #DECEMBER# EQ 3>*<cfelse>&##8730;</cfif></a><CFELSE> -</cfif> </td>
	<td align="center"><cfif #JANUARY# NEQ 0> <a href="contra2.cfm?#session.urltoken#&activ=#URLEncodedFormat(userid)#&mon=1&obj=1E"><cfif #JANUARY# EQ 1>***<cfelseif #JANUARY# EQ 3>*<cfelse>&##8730;</cfif></a><CFELSE> -</cfif> </td>
	<td align="center"><cfif #FEBRUARY# NEQ 0> <a href="contra2.cfm?#session.urltoken#&activ=#URLEncodedFormat(userid)#&mon=2&obj=1E"><cfif #FEBRUARY# EQ 1>***<cfelseif #FEBRUARY# EQ 3>*<cfelse>&##8730;</cfif></a><CFELSE> -</cfif> </td>
	<td align="center"><cfif #MARCH# NEQ 0> <a href="contra2.cfm?#session.urltoken#&activ=#URLEncodedFormat(userid)#&mon=3&obj=1E"><cfif #MARCH# EQ 1>***<cfelseif #MARCH# EQ 3>*<cfelse>&##8730;</cfif></a><CFELSE> -</cfif> </td>
	<td align="center"><cfif #APRIL# NEQ 0> <a href="contra2.cfm?#session.urltoken#&activ=#URLEncodedFormat(userid)#&mon=4&obj=1E"><cfif #APRIL# EQ 1>***<cfelseif #APRIL# EQ 3>*<cfelse>&##8730;</cfif></a><CFELSE> -</cfif> </td>
	<td align="center"><cfif #MAY# NEQ 0> <a href="contra2.cfm?#session.urltoken#&activ=#URLEncodedFormat(userid)#&amp;mon=5&obj=1E"><cfif #MAY# EQ 1>***<cfelseif #MAY# EQ 3>*<cfelse>&##8730;</cfif></a><CFELSE> -</cfif> </td>
	<td align="center"><cfif #JUNE# NEQ 0> <a href="contra2.cfm?#session.urltoken#&activ=#URLEncodedFormat(userid)#&amp;mon=6&obj=1E"><cfif #JUNE# EQ 1>***<cfelseif #JUNE# EQ 3>*<cfelse>&##8730;</cfif></a><CFELSE> -</cfif> </td>
	<cfif session.fy LTE 2010><td align="center"><cfif #JULY# NEQ 0> <a href="contra2.cfm?#session.urltoken#&activ=#URLEncodedFormat(userid)#&amp;mon=7&obj=1E"><cfif #JULY# EQ 1>***<cfelseif #JULY# EQ 3>*<cfelse>&##8730;</cfif></a><CFELSE> -</cfif> </td></cfif>
</tr>
</cfoutput></cfoutput>
</table>
</td></tr>
</cfform>
<tr>
<td colspan=13>
<table class="box2" cellpadding="5" border=".2"  align="center" width="75%">
<tr>
	<th colspan="3">Key for Contract Manager Feedback grid</th>
</tr>
<tr>
	<th width="50">Display</th>
	<th>What it means</th>
</tr>
<tr>
	<td align="center">-</td>
	<td>There is no Contract Manager feedback submitted for this month</td>
</tr>
<tr>
	<td align="center">*</td>
	<td>Contract Manager has saved feedback for this month.  Click the asterisks to read it</td>
</tr>
<tr>
	<td align="center">***</td>
	<td>Contract Manager has submitted feedback for this month.  Click the asterisks to read it</td>
</tr>
<tr>
	<td align="center">&#8730;</td>
	<td>
		Partner has checked the box to indicate that they have responded to Contract Manager feedback
</tr>
</table>
</td>
</tr>
</table></td></tr>
</table>
<br>
</body>
</html>
