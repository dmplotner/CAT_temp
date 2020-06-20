<!--- <cfif NOT(session.areamanage EQ 1 or session.cessman is 1 or session.admin is 1)>
	<cflocation url="unavailable.cfm" addtoken="yes">
</cfif> --->


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
<title>CAT</title>

<!--- <cfif isDefined("session.EOYcut") and session.EOYcut NEQ 0 and SESSION.admin NEQ "1">
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
where <cfif isdefined("usid")>c.userid='#usid#'<cfelse>c.userid='#session.userid#' </cfif>
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
sm1_status, sm2_status,
sm1_progress, sm2_progress,
sm1_barrier, sm2_barrier,
sm1_actions, sm2_actions,
cbseq
	from eoy_basics 
where <cfif isdefined("usid")>userid='#usid#'<cfelse>userid='#session.userid#' </cfif>
	and year2=#session.fy#
</cfquery> 
<cfinclude template="CATstruct.cfm">
<cfoutput>



<div align="center"><h3>End-of-Year Report for FY #evaluate(session.fy-1)#-#session.fy# - Youth Partner</h3></div>
<hr>
	<cfinclude template="yp_eoy_sub.cfm">


<!--- <cfif ((isdefined("url.usid") and session.userid EQ url.usid ) or (not isDefined("url.usid")) AND (QRptbasics.recordcount EQ 0 OR QRptbasics.complete NEQ 1))>

<div align="left">
	<input type="submit" value="Save" class="AddButton">
</div>	
</cfif> 

<cfinclude template="EOY_sub_AM_Detail.cfm">
--->

</cfoutput>

<!--- <script language="javascript">

function countcb(){
var localcnt = 0;
for(var intloop=0; intloop <document.EOYStatus.yr1_2.length; intloop++){
if (document.EOYStatus.yr1_2[intloop].checked){
localcnt = localcnt+1;
}
}
document.EOYStatus.cntcb.value = localcnt;

}

function disableme3(){
for(var intloop=0; intloop <document.AMFback.length; intloop++){
document.AMFback[intloop].disabled=true;
}
}
disableme3();
countcb()
</script> --->

<script language="javascript">
function disableme(){
for(var intloop=0; intloop <document.EOYStatus.length; intloop++){
	if(document.EOYStatus[intloop].type=='textarea'){
	document.EOYStatus[intloop].readOnly = true;
	}
	else
document.EOYStatus[intloop].disabled=true;
}
}
<!--- <cfif <!--- ('8/31/2009' LTE now()) AND  ---> --->
<CFIF (getdeets.Partner_status GT 0 and NOT(listcontains(session.newExt_5, (session.def_fy-1)) or listcontains(session.newExt_5, (session.def_fy)))) AND (NOT(SESSION.areamanage EQ "1" OR SESSION.admin EQ "1" OR SESSION.TCP EQ "1" OR SESSION.CessMan contains "1" or session.areamanage EQ 1 or session.admin eq 1))>
<!--- 		NOT(SESSION.areamanage EQ "1" OR SESSION.admin EQ "1" OR SESSION.TCP EQ "1" OR SESSION.CessMan EQ "1" or session.areamanage EQ 1 or session.admin eq 1) and NOT listcontains(session.newExt_5, (session.def_fy))> --->
disableme();
</cfif>
</script>
</html>