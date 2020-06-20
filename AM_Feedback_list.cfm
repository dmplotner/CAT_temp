<CFIF SESSION.FY gte 2010>
	<CFLOCATION addtoken="YES" url="cm_FEEDBACKLIST.CFM">
</CFIF>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
<title>CAT</title>
 <!--- <cfif session.fy GT session.def_fy>
	<Cflocation url="unavailable.cfm" addtoken="yes">
</cfif> --->

<cfinclude template="CATstruct.cfm">
<cfparam name="#session.origUserID#" default="#session.userid#">
<!--- <script language="JavaScript">
function setmonth2(content){
document.f1.monthdisplay.value = content;
}
</script> --->
<cfif not isDefined("session.origUserID")>
	<cfset session.origUserID=session.userid>
</cfif>

 <cfquery datasource="#application.DataSource#"  	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qmonths">
select mon
from months
where year2 = #session.fy#
order by rank
</cfquery> 

 <cfquery datasource="#application.DataSource#"  	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Q2">
select mon
from months
where year2 = #session.fy#
order by sp_rank
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QPartnerList">
	
	
select 
c.userid, orgname, r.region as area
from contact as c, security as s, area as a, region as r
where c.userid=s.userid
and s.area = a.num
and a.year2=#session.fy#

and r.year2=a.year2
and r.num=a.region

and (1=2 
	<!--- <cfif session.cntMan EQ 1> --->
	or c.cmanager='#session.origUserID#'
	<!--- </cfif> --->
<!--- <cfif  (session.admin EQ 1 <!--- OR session.tcp EQ 1 OR session.statemanage EQ 1 --->) <!--- AND (not isDefined("session.cessman") or (session.cessman NEQ 1 and session.cessman NEQ 2 and session.cessman NEQ 3 and session.cessman NEQ 4)) ---> >--->
<cfif  (session.userid EQ 'dplotner')OR ((session.admin EQ 1  OR session.tcp EQ 1 OR session.statemanage EQ 1)  AND (not isDefined("session.cessman") or (session.cessman DOES NOT CONTAIN 1 and session.cessman DOES NOT CONTAIN 2 and session.cessman DOES NOT CONTAIN 3 and session.cessman DOES NOT CONTAIN 4 and session.cessman DOES NOT CONTAIN 5)) and session.cntMan EQ 0 ) >


or 1=1
</cfif>
<!--- <cfif session.areamanage EQ 1 and (session.admin NEQ 1 AND session.tcp NEQ 1 AND session.statemanage NEQ 1)>
or  a.manager_id='#session.origUserID#'
</cfif> --->
<cfif isDefined("session.cessman")>
	<cfif session.cessman CONTAINS 1>
		or c.partnertype = 1
	<cfelseif session.cessman CONTAINS 2>
		or c.partnertype = 2
	<cfelseif session.cessman CONTAINS 3>
		or c.partnertype = 3
	<cfelseif session.cessman CONTAINS 4>
		or c.partnertype = 4
	<cfelseif session.cessman CONTAINS 5>
		or c.partnertype = 5
	</cfif>

	
</cfif>
)
and orgname is not null and orgname !=''
and partnertype !=4
order by 2
</cfquery>



<cfset form.year=session.fy>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="dispUsers">
select orgname, 
r.region as area, c.userid,
sum(case when q.month2='August' then case q.partner_status when 1 then 2 else 1 end else 0 end) as August, 
sum(case when q.month2='September' then case q.partner_status when 1 then 2 else 1 end else 0 end) as September, 
sum(case when q.month2='October' then case q.partner_status when 1 then 2 else 1 end else 0 end) as October, 
sum(case when q.month2='November' then case q.partner_status when 1 then 2 else 1 end else 0 end) as November, 
sum(case when q.month2='December' then case q.partner_status when 1 then 2 else 1 end else 0 end) as December, 
sum(case when q.month2='January' then case q.partner_status when 1 then 2 else 1 end else 0 end) as January, 
sum(case when q.month2='February' then case q.partner_status when 1 then 2 else 1 end else 0 end) as February, 
sum(case when q.month2='March' then case q.partner_status when 1 then 2 else 1 end else 0 end) as March, 
sum(case when q.month2='April' then case q.partner_status when 1 then 2 else 1 end else 0 end) as April, 
sum(case when q.month2='May' then case q.partner_status when 1 then 2 else 1 end else 0 end) as May, 
sum(case when q.month2='June' then case q.partner_status when 1 then 2 else 1 end else 0 end) as June, 
sum(case when q.month2='July' then case q.partner_status when 1 then 2 else 1 end else 0 end) as July 
from  
security as s, 
area as a, region as r,
contact as c
left outer join AM_feedback as q  on q.partner_id=c.userid 
and q.year2=#session.fy# 
where c.userid in 
<cfif QPartnerList.recordcount GT 0>(#quotedValueList(QPartnerList.userid)#)<cfelse>('x')</cfif> 
and a.year2=#session.fy# 

and s.userid=c.userid 
and s.area=a.num 

and a.year2=r.year2
and a.region=r.num

group by orgname, 
r.region,
c.userid, c.partnertype

ORDER BY 2,c.partnertype, 1
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QPartnerList2">
	
	
select 
c.userid, orgname, r.region as area
from contact as c, security as s, area as a, region as r
where c.userid=s.userid
and s.area = a.num
and a.year2=#session.fy#

and r.year2=a.year2
and r.num=a.region

and (1=2 
	<!--- <cfif session.cntMan EQ 1> --->
	or c.cmanager='#session.origUserID#'
	<!--- </cfif> --->
<cfif  (session.admin EQ 1 <!--- OR session.tcp EQ 1 OR session.statemanage EQ 1 --->) <!--- AND (not isDefined("session.cessman") or (session.cessman NEQ 1 and session.cessman NEQ 2 and session.cessman NEQ 3 and session.cessman NEQ 4)) ---> >
or 1=1
</cfif>
<!--- <cfif session.areamanage EQ 1 and (session.admin NEQ 1 AND session.tcp NEQ 1 AND session.statemanage NEQ 1)>
or  a.manager_id='#session.origUserID#'
</cfif> --->
<cfif isDefined("session.cessman")>
	<cfif session.cessman CONTAINS 1>
		or c.partnertype = 1
	<cfelseif session.cessman CONTAINS 2>
		or c.partnertype = 2
	<cfelseif session.cessman CONTAINS 3>
		or c.partnertype = 3
	<cfelseif session.cessman CONTAINS 4>
		or c.partnertype = 4
	<cfelseif session.cessman CONTAINS 5>
		or c.partnertype = 5
	</cfif>
	
</cfif>
)
and orgname is not null and orgname !=''
and partnertype =4
union
select '', '', ''
order by  2
</cfquery>





<cfset form.year=session.fy>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="dispUsers2">
select orgname, 
r.region as area, c.userid,
sum(case when q.month2='August' then case q.partner_status when 1 then 2 else 1 end else 0 end) as August, 
sum(case when q.month2='September' then case q.partner_status when 1 then 2 else 1 end else 0 end) as September, 
sum(case when q.month2='October' then case q.partner_status when 1 then 2 else 1 end else 0 end) as October, 
sum(case when q.month2='November' then case q.partner_status when 1 then 2 else 1 end else 0 end) as November, 
sum(case when q.month2='December' then case q.partner_status when 1 then 2 else 1 end else 0 end) as December, 
sum(case when q.month2='January' then case q.partner_status when 1 then 2 else 1 end else 0 end) as January, 
sum(case when q.month2='February' then case q.partner_status when 1 then 2 else 1 end else 0 end) as February, 
sum(case when q.month2='March' then case q.partner_status when 1 then 2 else 1 end else 0 end) as March, 
sum(case when q.month2='April' then case q.partner_status when 1 then 2 else 1 end else 0 end) as April, 
sum(case when q.month2='May' then case q.partner_status when 1 then 2 else 1 end else 0 end) as May, 
sum(case when q.month2='June' then case q.partner_status when 1 then 2 else 1 end else 0 end) as June, 
sum(case when q.month2='July' then case q.partner_status when 1 then 2 else 1 end else 0 end) as July 
from  
security as s, 
area as a, region as r,
contact as c
left outer join AM_feedback as q  on q.partner_id=c.userid 
and q.year2=#session.fy# 
where c.userid in 
<cfif QPartnerList2.recordcount GT 0>(#quotedValueList(QPartnerList2.userid)#)<cfelse>('x')</cfif> 
and a.year2=#session.fy# 

and a.year2=r.year2
and a.region=r.num

and s.userid=c.userid 
and s.area=a.num 
group by orgname, 
r.region,
c.userid, c.partnertype

ORDER BY 2,c.partnertype, 1
</cfquery>

	 

<table align="left" cellpadding="10" cellspacing="0" border="0"  class="box" width="100%">		
<cfform action="AM_Feedback_det.cfm?#session.urltoken#" name="f1">

<tr>
	<td>&nbsp;<br><br></td>
</tr>
<tr>
	<th colspan="3">
		<h3><cfif session.fy LTE 2008>Area<Cfelse>Contract</cfif> Manager Feedback Grid</h3>
		<h3>Cessation Centers, Youth Partners and Community Partnerships</h3>
	</th>
</tr>

<tr><td>Select a partner and month for a new report:</td>
<td>
<cfselect name="partnerName" query="QPartnerList" display ="orgname" value="userid">
</cfselect>


<cfselect name="rptMon" query="QMonths" display ="mon" value="mon">
</cfselect>
</td>
<td><input type="Submit" value="Enter Feedback" <!--- onclick="setmonth2('<cfoutput>#MonthAsString(Month(now()))#</cfoutput>');" --->></td>

</tr>


<tr><td colspan="4">

<table align="center" cellpadding="10" cellspacing="0" border="0" class="box2">	
	







<cfoutput query="dispUsers" group="Area">
<tr><th colspan="13" align="left">#Area#</th></tr>
<tr>
	<th>Partner</th>
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
	<th>JUL</th>	
</tr>
<cfoutput>

<tr>
	<td><font color="Green">#orgname#</font></td>
	<td align="center"><cfif #AUGUST# NEQ 0> <a href="AM_Feedback_det.cfm?#session.urltoken#&activ=#URLEncodedFormat(userid)#&mon=August&year=#form.year#" ><cfif #AUGUST# EQ 1>***<cfelse>&##8730;</cfif></a><CFELSE> -</cfif> </td>
	<td align="center"><cfif #SEPTEMBER# NEQ 0> <a href="AM_Feedback_det.cfm?#session.urltoken#&activ=#URLEncodedFormat(userid)#&mon=September&year=#form.year#"><cfif #SEPTEMBER# EQ 1>***<cfelse>&##8730;</cfif></a><CFELSE> -</cfif> </td>
	<td align="center"><cfif #OCTOBER# NEQ 0> <a href="AM_Feedback_det.cfm?#session.urltoken#&activ=#URLEncodedFormat(userid)#&mon=October&year=#form.year#"><cfif #OCTOBER# EQ 1>***<cfelse>&##8730;</cfif></a><CFELSE> -</cfif> </td>
	<td align="center"><cfif #NOVEMBER# NEQ 0> <a href="AM_Feedback_det.cfm?#session.urltoken#&activ=#URLEncodedFormat(userid)#&mon=November&year=#form.year#"><cfif #NOVEMBER# EQ 1>***<cfelse>&##8730;</cfif></a><CFELSE> -</cfif> </td>
	<td align="center"><cfif #DECEMBER# NEQ 0> <a href="AM_Feedback_det.cfm?#session.urltoken#&activ=#URLEncodedFormat(userid)#&mon=December&year=#form.year#"><cfif #DECEMBER# EQ 1>***<cfelse>&##8730;</cfif></a><CFELSE> -</cfif> </td>
	<td align="center"><cfif #JANUARY# NEQ 0> <a href="AM_Feedback_det.cfm?#session.urltoken#&activ=#URLEncodedFormat(userid)#&mon=January&year=#form.year#"><cfif #JANUARY# EQ 1>***<cfelse>&##8730;</cfif></a><CFELSE> -</cfif> </td>
	<td align="center"><cfif #FEBRUARY# NEQ 0> <a href="AM_Feedback_det.cfm?#session.urltoken#&activ=#URLEncodedFormat(userid)#&mon=February&year=#form.year#"><cfif #FEBRUARY# EQ 1>***<cfelse>&##8730;</cfif></a><CFELSE> -</cfif> </td>
	<td align="center"><cfif #MARCH# NEQ 0> <a href="AM_Feedback_det.cfm?#session.urltoken#&activ=#URLEncodedFormat(userid)#&mon=March&year=#form.year#"><cfif #MARCH# EQ 1>***<cfelse>&##8730;</cfif></a><CFELSE> -</cfif> </td>
	<td align="center"><cfif #APRIL# NEQ 0> <a href="AM_Feedback_det.cfm?#session.urltoken#&activ=#URLEncodedFormat(userid)#&mon=April&year=#form.year#"><cfif #APRIL# EQ 1>***<cfelse>&##8730;</cfif></a><CFELSE> -</cfif> </td>
	<td align="center"><cfif #MAY# NEQ 0> <a href="AM_Feedback_det.cfm?#session.urltoken#&activ=#URLEncodedFormat(userid)#&amp;mon=May&amp;year=#form.year#"><cfif #MAY# EQ 1>***<cfelse>&##8730;</cfif></a><CFELSE> -</cfif> </td>
	<td align="center"><cfif #JUNE# NEQ 0> <a href="AM_Feedback_det.cfm?#session.urltoken#&activ=#URLEncodedFormat(userid)#&amp;mon=June&amp;year=#form.year#"><cfif #JUNE# EQ 1>***<cfelse>&##8730;</cfif></a><CFELSE> -</cfif> </td>
	<td align="center"><cfif #JULY# NEQ 0> <a href="AM_Feedback_det.cfm?#session.urltoken#&activ=#URLEncodedFormat(userid)#&amp;mon=July&amp;year=#form.year#"><cfif #JULY# EQ 1>***<cfelse>&##8730;</cfif></a><CFELSE> -</cfif> </td>
</tr>
</cfoutput>			
		


</cfoutput>
</table>



</td></tr>

</cfform>

<cfform action="AM_Feedback_det.cfm?#session.urltoken#" name="f2">

<tr>
	<td>&nbsp;<br><br></td>
</tr>
<tr>
	<th colspan="3">
		<h3><cfif session.fy LTE 2008>Area<Cfelse>Contract</cfif> Manager Feedback Grid</h3>
		<h3>School Policy Partners</h3>
	</th>
</tr>


<!--- <cfif  NOT((session.tcp EQ 1 OR session.statemanage EQ 1)   
		AND (not (isDefined("session.cessman")) OR (session.cessman EQ 1 OR session.cessman EQ 2 OR session.cessman EQ 3 OR session.cessman EQ 4))
		 and session.cntMan EQ 0  )  >
 --->
<tr><td>Select a partner and month for a new report:</td>
<td>
<cfselect name="partnerName" query="QPartnerList2" display ="orgname" value="userid">
</cfselect>


<cfselect name="rptMon" query="QMonths2" display ="mon" value="mon">
</cfselect>
</td>
<td><input type="Submit" value="Enter Feedback" <!--- onclick="setmonth2('<cfoutput>#MonthAsString(Month(now()))#</cfoutput>');" --->></td>

</tr> 
<!--- </cfif> --->

<tr><td colspan="4">

<table align="center" cellpadding="10" cellspacing="0" border="0" class="box2">	
	







<cfoutput query="dispUsers2" group="Area">
<tr><th colspan="13" align="left">#Area#</th></tr>
<tr>
	<th>Partner</th>
	
	<th>DEC</th>
	<th>JAN</th>
	<th>FEB</th>
	<th>MAR</th>
	<th>APR</th>
	<th>MAY</th>
	<th>JUN</th>
	<th>JUL</th>	
	<th>AUG</th>
	<th>SEP</th>
	<th>OCT</th>
	<th>NOV</th>
</tr>
<cfoutput>

<tr>
	<td><font color="Green">#orgname#</font></td>
	<td align="center"><cfif #DECEMBER# NEQ 0> <a href="AM_Feedback_det.cfm?#session.urltoken#&activ=#URLEncodedFormat(userid)#&mon=December&year=#form.year#"><cfif #DECEMBER# EQ 1>***<cfelse>&##8730;</cfif></a><CFELSE> -</cfif> </td>
	<td align="center"><cfif #JANUARY# NEQ 0> <a href="AM_Feedback_det.cfm?#session.urltoken#&activ=#URLEncodedFormat(userid)#&mon=January&year=#form.year#"><cfif #JANUARY# EQ 1>***<cfelse>&##8730;</cfif></a><CFELSE> -</cfif> </td>
	<td align="center"><cfif #FEBRUARY# NEQ 0> <a href="AM_Feedback_det.cfm?#session.urltoken#&activ=#URLEncodedFormat(userid)#&mon=February&year=#form.year#"><cfif #FEBRUARY# EQ 1>***<cfelse>&##8730;</cfif></a><CFELSE> -</cfif> </td>
	<td align="center"><cfif #MARCH# NEQ 0> <a href="AM_Feedback_det.cfm?#session.urltoken#&activ=#URLEncodedFormat(userid)#&mon=March&year=#form.year#"><cfif #MARCH# EQ 1>***<cfelse>&##8730;</cfif></a><CFELSE> -</cfif> </td>
	<td align="center"><cfif #APRIL# NEQ 0> <a href="AM_Feedback_det.cfm?#session.urltoken#&activ=#URLEncodedFormat(userid)#&mon=April&year=#form.year#"><cfif #APRIL# EQ 1>***<cfelse>&##8730;</cfif></a><CFELSE> -</cfif> </td>
	<td align="center"><cfif #MAY# NEQ 0> <a href="AM_Feedback_det.cfm?#session.urltoken#&activ=#URLEncodedFormat(userid)#&amp;mon=May&amp;year=#form.year#"><cfif #MAY# EQ 1>***<cfelse>&##8730;</cfif></a><CFELSE> -</cfif> </td>
	<td align="center"><cfif #JUNE# NEQ 0> <a href="AM_Feedback_det.cfm?#session.urltoken#&activ=#URLEncodedFormat(userid)#&amp;mon=June&amp;year=#form.year#"><cfif #JUNE# EQ 1>***<cfelse>&##8730;</cfif></a><CFELSE> -</cfif> </td>
	<td align="center"><cfif #JULY# NEQ 0> <a href="AM_Feedback_det.cfm?#session.urltoken#&activ=#URLEncodedFormat(userid)#&amp;mon=July&amp;year=#form.year#"><cfif #JULY# EQ 1>***<cfelse>&##8730;</cfif></a><CFELSE> -</cfif> </td>
	<td align="center"><cfif #AUGUST# NEQ 0> <a href="AM_Feedback_det.cfm?#session.urltoken#&activ=#URLEncodedFormat(userid)#&mon=August&year=#form.year#" ><cfif #AUGUST# EQ 1>***<cfelse>&##8730;</cfif></a><CFELSE> -</cfif> </td>
	<td align="center"><cfif #SEPTEMBER# NEQ 0> <a href="AM_Feedback_det.cfm?#session.urltoken#&activ=#URLEncodedFormat(userid)#&mon=September&year=#form.year#"><cfif #SEPTEMBER# EQ 1>***<cfelse>&##8730;</cfif></a><CFELSE> -</cfif> </td>
	<td align="center"><cfif #OCTOBER# NEQ 0> <a href="AM_Feedback_det.cfm?#session.urltoken#&activ=#URLEncodedFormat(userid)#&mon=October&year=#form.year#"><cfif #OCTOBER# EQ 1>***<cfelse>&##8730;</cfif></a><CFELSE> -</cfif> </td>
	<td align="center"><cfif #NOVEMBER# NEQ 0> <a href="AM_Feedback_det.cfm?#session.urltoken#&activ=#URLEncodedFormat(userid)#&mon=November&year=#form.year#"><cfif #NOVEMBER# EQ 1>***<cfelse>&##8730;</cfif></a><CFELSE> -</cfif> </td>
	
</tr>
</cfoutput>			
		


</cfoutput>
</table>



</td></tr>

</cfform>

<tr>
<td colspan=13>
<table class="box2" cellpadding="5" border=".2"  align="center" width="75%">
<tr>
	<th colspan="3">Key for Monthly Strategy Report grid</th>
</tr>
<tr>
	<th>Key</th>
	<th width="50">Display</th>
	<th>What it means</th>
</tr>
<!--- <tr>
	<td rowspan="6" valign="top">Reports for each Strategy</td>
	<td align="center">-</td>
	<td>The report has not been opened</td>
</tr>
<tr>
	<td align="center">***</td>
	<td>The Monthly Strategy Report for this month has been opened/viewed, but nothing was entered</td>
</tr>
<tr>
	<td align="center">P</td>
	<td>Information has been submitted for this strategy this month, and the strategy is in <strong>Planning</strong> status
	</td>
</tr>
<tr>
	<td align="center">O</td>
	<td>Information has been submitted for this strategy this month, and the strategy is in <strong>Ongoing</strong> status
	</td>
</tr>
<tr>
	<td align="center">C</td>
	<td>Information has been submitted for this strategy this month, and the strategy is in <strong>Completed</strong> status
	</td>
</tr>
<tr>
	<td align="center">S</td>
	<td>Information has been submitted for this strategy this month, and the strategy is in <strong>Suspended</strong> status
</td>
</tr> --->
<tr>
	<td rowspan="3" valign="top"><cfif session.fy LTE 2008>Area<Cfelse>Contract</cfif> Manager feedback</td>
	<td align="center">-</td>
	<td>There is no <cfif session.fy LTE 2008>Area<Cfelse>Contract</cfif> Manager feedback submitted for this month</td>
</tr>
<tr>
	<td align="center">***</td>
	<td>There is <cfif session.fy LTE 2008>Area<Cfelse>Contract</cfif> Manager feedback for this month.  Click the asterisks to read it</td>
</tr>
<tr>
	<td align="center">&#8730;</td>
	<td>Partner has checked the box to indicate that they have read this <cfif session.fy LTE 2008>Area<Cfelse>Contract</cfif> Manager feedback</td>
	
</tr>

<!--- <tr>
	<td rowspan="3" valign="top">Infrastructure report</td>
	<td align="center">-</td>
	<td>The report has not been opened</td>
</tr>
<tr>
	<td align="center">***</td>
	<td>The Infrastructure report has been opened, but not submitted</td>
</tr>
<tr>
	<td align="center">R</td>
	<td>The Infrastructure report has been submitted</td>
</tr> --->
</table>
</td>
</tr>



</table></td></tr>	



</table>


<br>




</body>

</html>
