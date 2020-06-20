<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
<title>CAT</title>
<!--- 
<cfif NOT(session.EOYcut EQ 1 OR SESSION.admin EQ "1" or listcontains(session.newExt_5, session.fy))>
<!--- <cfif isDefined("session.EOYcut") and session.EOYcut NEQ 0 and SESSION.admin NEQ "1"> --->
	<cflocation addtoken="yes" url="welcome.cfm">
</cfif>
 --->

<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QUserinfo">
	select orgname, agent, countylist, grantNum, m.long_descrip as modality, 
	s.namesig, s.agencydir, s.contamt, s.progspptAmt, s.accomp, s.goals
from modality as m, contact as c 
left outer join eoy_sum as s
on s.userid=c.userid and s.year2=#session.fy#
where <!--- c.userid='#session.userid#'  --->
<cfif isdefined("usid")>c.userid='#usid#'<cfelse>c.userid='#session.userid#' </cfif>
and c.partnertype=m.modality 
</cfquery>

<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QUsershared">
	select activity
	from shareduseractivities
	where
year2=#session.fy#
and <cfif isdefined("usid")>userid='#usid#'<cfelse>userid='#session.userid#' </cfif> 
union
select 'novalue'
</cfquery>



<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QRptinfo">
	select u.activity, 
	case isNull(e.status,0) when 0 then 'Not Entered' when 1 then 'Met' when 2 then 'Unmet' when 3 then 'Progressing' End as status,
	barriers, actions, meas_b, meas_c, meas_t, comment
from useractivities as u
left outer join eoy_status as e
on ltrim(rtrim(e.activity))=ltrim(rtrim(u.activity) )
and 
e.userid=u.userid and e.year2=u.year2
where 
u.year2=#session.fy#
and(<cfif isdefined("usid")>u.userid='#usid#'<cfelse>u.userid='#session.userid#' </cfif>
or
(u.userid='shared' and u.activity in (#quotedvaluelist(QUsershared.activity)#))
)


and (u.del is null or u.del != 'Y')
and u.strategy !=10
order by 1
	
</cfquery>
<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QRptbasics">
select namesig, agencydir, accomp, goals, complete, contamt,
sm1_status, sm2_status, sm3_status,
sm1_progress, sm2_progress, sm3_progress,
sm1_barrier, sm2_barrier,sm3_barrier,
sm1_actions, sm2_actions, sm3_actions,
cbseq
	from eoy_basics 
	where <cfif isdefined("usid")>userid='#usid#'<cfelse>userid='#session.userid#' </cfif>
	and year2=#session.fy#
</cfquery> 

<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QRptdetails2">
select *
	from eoy_details 
	where <cfif isdefined("usid")>userid='#usid#'<cfelse>userid='#session.userid#' </cfif>
	and year2=#session.fy#
</cfquery> 


<cfinclude template="CATstruct.cfm">
<cfoutput>



<div align="center"><h3>School Policy Partner End-of-Year Report for Fiscal Year #evaluate(session.fy-1)# - #session.fy#</h3></div>
<cfinclude template="eoy_sub.cfm">



<!--- <cfif ((isdefined("url.usid") and session.userid EQ url.usid ) or (not isDefined("url.usid")) AND (QRptbasics.recordcount EQ 0 OR QRptbasics.complete NEQ 1))>

<div align="left">
	<input type="submit" value="Save" class="AddButton">
</div>	
</cfif> --->

<!--- <cfinclude template="EOY_sub_AM_Detail.cfm"> --->
<!--- <br><br>
<cfinclude template="eoy_tcp_feedback.cfm"> --->


</cfoutput>

<script language="javascript">

function countcb(){
var localcnt = 0;
<cfif session.fy LT 2008>
for(var intloop=0; intloop <document.EOYStatus.yr1_2.length; intloop++){
if (document.EOYStatus.yr1_2[intloop].checked){
localcnt = localcnt+1;
}
}

document.EOYStatus.cntcb.value = localcnt;
</cfif>
}

function disableme3(){
for(var intloop=0; intloop <document.AMFback.length; intloop++){
document.AMFback[intloop].disabled=true;
}
}
<!--- disableme3(); --->
countcb();
function disableme(){
for(var intloop=0; intloop <document.EOYStatus.length; intloop++){
	if(document.EOYStatus[intloop].type=='textarea'){
	document.EOYStatus[intloop].readOnly = true;
	}
	else
document.EOYStatus[intloop].disabled=true;
}
}
<cfif ('1/10/2009' LTE now()) AND NOT(SESSION.areamanage EQ "1" OR SESSION.admin EQ "1" OR SESSION.TCP EQ "1" OR SESSION.CessMan contains "1" or session.areamanage EQ 1 or session.admin eq 1) and NOT listcontains(session.newExt_5, (session.def_fy-1))>
disableme();
</cfif>
</script>


</html>