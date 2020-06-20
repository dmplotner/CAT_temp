<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
<title>CAT</title>
 <!--- <cfif session.fy GT session.def_fy>
	<Cflocation url="unavailable.cfm" addtoken="yes">
</cfif> --->

<cfinclude template="CATstruct.cfm">
<cfparam name="#session.origUserID#" default="#session.userid#">
<cfif #session.cessman# CONTAINS 1 OR #session.cessman# CONTAINS 2 OR #session.cessman# CONTAINS 3 OR #session.cessman# CONTAINS 4 OR #session.cessman# CONTAINS 5>
<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qmodman">
	select mm.modality, long_descrip from modality_manager mm inner join modality m
	on mm.modality = m.modality
	where userid = '#session.userid#'
</cfquery>
</cfif>

<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QRptinfo">
	select distinct
	
	a.area, c.orgname, c.userid, c.partnertype,


case  
when isNull(partner_status, 0) > 0
then 'Submitted'
	else 
		case isNull(partner_dt,0) when 0 then 'No Entry Yet' else 'Some Entries' end 
	end 
as partnerstatus,

case isNull(tcp_status,0)
when  0 then 'Not Reviewed' 
else 'Reviewed'
<!--- case  isNull(tcp_dt,0) 
	when 0 then 'Not Reviewed' 
	else 
		case eoycomplete 
			when 1 then 'Complete to TCP Satisfaction' 
			else 'Some Entries' 
			end  --->
end as feedbackstatus




	/* ,case b.complete 
		when 0 then 'Not Complete' 
		when 1 then 'Complete' 
		else 'No Entry Yet' end as complete,
		
	case isNull(f.am_review ,99)
		when 1 then 'Reviewed' 
		when 0 then 'Reviewing' 
		else 'Not Reviewed' end as amstatus */
		
from security as s, area as a, 
--useractivities as u, 
contact as c

left outer join eoy_basics as b on b.userid=c.userid  and b.year2=#session.fy#
left outer join eoy_details  as d on d.userid=c.userid  and d.year2=#session.fy#
--left outer join am_eoy_feedback as f on f.userid=c.userid and f.year2=#session.fy#

where 

--u.userid=c.userid  and  
a.num = s.area
and s.userid=c.userid
and a.year2=#session.fy#
--and a.year2=u.year2 
--and u.year2=#session.fy#

and c.orgname is not null
and
(1=2
<cfif isdefined("qmodman.modality") and Qmodman.modality is not ''>
or c.partnertype=#qmodman.modality#
</cfif>
or c.cmanager='#session.origUserID#'
<cfif  (session.userid EQ 'dplotner')OR ((session.admin EQ 1  OR session.tcp EQ 1 OR session.statemanage EQ 1)  AND (not isDefined("session.cessman") or (session.cessman DOES NOT CONTAIN 1 and session.cessman DOES NOT CONTAIN 2 and session.cessman DOES NOT CONTAIN 3 and session.cessman DOES NOT CONTAIN 4 and session.cessman DOES NOT CONTAIN 5)) and session.cntMan EQ 0 ) >

or 1=1
</cfif>
or 2=3)


--and c.partnertype != 4
and s.area != 9
order by a.area, c.orgname 
</cfquery>



<!--- <cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QRptinfo2">
	select distinct
	a.area, c.orgname, c.userid,
	case b.complete 
		when 0 then 'Not Complete' 
		when 1 then 'Complete' 
		else 'No Entry Yet' end as complete,
		
	case isNull(f.am_review ,99)
		when 1 then 'Reviewed' 
		when 0 then 'Reviewing' 
		else 'Not Reviewed' end as amstatus
		
from security as s, area as a,  contact as c
left outer join eoy_basics as b on b.userid=c.userid  and b.year2=#session.fy#
left outer join am_eoy_feedback as f on f.userid=c.userid and f.year2=#session.fy#
where 
a.num = s.area
and s.userid=c.userid
and c.orgname is not null
and c.partnertype = 4
and s.area != 9
order by a.area, c.orgname 
</cfquery> --->


<br>
<table class="Table2" width="90%">
<tr>
<cfif isdefined("qmodman.long_descrip")>
<cfoutput>	<th colspan="4">#qmodman.long_descrip#</th></cfoutput></cfif>
</tr>
<cfoutput query="QRptinfo" group="area">
<tr>
	<th colspan="4" align="left">#area#</th>
</tr>
<tr>
	<td>&nbsp;</td>
	<th align="left">Partner Name</th>
	<th align="left">Partner reporting status</th>
	<th align="left">TCP feedback status</th>
</tr>
<cfoutput>
<cfswitch expression="#qrptinfo.partnertype#">
<cfcase value=1>
	<cfset modal = "cc">
</cfcase>
<cfcase value=2>
	<cfset modal = "cp">
</cfcase>
<cfcase value=3>
	<cfset modal = "yp">
</cfcase>
<cfcase value=4>
	<cfset modal = "sp">
</cfcase>
</cfswitch>
<tr>
	<td>&nbsp;</td>
	<td>
<!--- 	<a href="EOY_AM_detail.cfm?#session.urltoken#&activ=#URLEncodedFormat(activity)#&usid=#URLEncodedFormat(userid)#">#activity#</a>--->	
<!---  		<a href="EOY_AM_partnerList.cfm?#session.urltoken#&usid=#URLEncodedFormat(userid)#">#orgname#</a>--->
		<cfif modal EQ "sp">
			<a href="eoy_progress.cfm?modal=#modal#&#session.urltoken#&usid=#URLEncodedFormat(userid)#">#orgname#</a>
		<cfelse>
			<a href="#modal#_eoy_progress.cfm?modal=#modal#&#session.urltoken#&usid=#URLEncodedFormat(userid)#">#orgname#</a>
		</cfif>
	
	</td>
	<td>#partnerstatus#</td>
	<td>#feedbackstatus#</td>
</tr>
<tr><td colspan="4"><hr></td>
</tr></cfoutput>
</cfoutput>

</table>



</body>

</html>
