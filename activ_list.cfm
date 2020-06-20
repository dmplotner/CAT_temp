
<!---<cfif session.fy GTE 2015 and (#session.userid# is not 'test_cc1' and #session.userid# is not 'test_cc2' and #session.userid# is not 'test_cc_b2' and #session.userid# is not 'test_cp2' and #session.userid# is not 'test_cp1' and #session.userid# is not 'test_cc_b1' and #session.userid# is not 'test_cc' and #session.userid# is not 'test_cp' and #session.userid# is not 'test_cc_b')><cflocation url="unavailable.cfm" addtoken="true"></cfif>
--->s
<cfif session.fy GT 2010><cflocation url="monthrep.cfm" addtoken="true"></cfif>
<!--- <cfif session.fy EQ 2008><cflocation addtoken="yes" url="noFuture.cfm"></cfif>
 ---><!--- <cfif (session.fy EQ 2007)and session.modality EQ 4 and session.userid NEQ 'twills' and session.userid NEQ 'bmarkatos' and session.userid NEQ 'rav02' and session.userid NEQ 'dxv06'  >
	<cflocation addtoken="yes" url="noFuture.cfm">
</cfif> --->

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
<title>CAT</title>
 <!--- <cfif session.fy GT session.def_fy>
	<Cflocation url="unavailable.cfm" addtoken="yes">
</cfif> --->

<cfif session.fy GT session.def_fy>
	<cflocation addtoken="yes" url="noFuture.cfm">
</cfif>

<cfinclude template="CATstruct.cfm">

<script language="JavaScript">
function setmonth2(content){
document.f1.monthdisplay.value = content;
}
</script>

<cfif 1 EQ 1 OR (session.def_fy EQ session.fy) OR DatePart("m", now()) GT 5>
<!---
 <cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qmonths">
select mon
from months
where <cfif session.modality EQ 4>
sp_rank
<cfelse>
rank
</cfif> <= 
(select <cfif session.modality EQ 4>
sp_rank
<cfelse>
rank
</cfif> from months 
where mon_num=DATEPART(MONTH, getdate())) 
order by 
<cfif session.modality EQ 4>
sp_rank
<cfelse>
rank
</cfif>
</cfquery> 
--->
 <cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qmonths">
select mon
from months
where year2 = #session.fy#
<!--- MonthAsString(Month(yourDate)) --->


<cfif (session.modality EQ 4  AND (session.fy GT Year(Now())) OR ((session.fy EQ Year(Now())) AND (Month(Now()) GTE 12)))>


and sp_rank <= (select sp_rank from months where mon = '#MonthAsString(Month(Now()))#' and year2 = #session.fy#)


 <cfelseif (session.modality NEQ 4  AND (session.fy GT Year(Now())) OR ((session.fy EQ Year(Now())) AND (Month(Now()) LTE 7)))>
and rank <= (select rank from months where mon = '#MonthAsString(Month(Now()))#' and year2 = #session.fy#)
</cfif>
order by 
<cfif session.modality EQ 4>
sp_rank
<cfelse>
rank
</cfif>
</cfquery> 

<cfelse>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qmonths">
<!--- select mon
from months
where 
<cfif session.userid EQ "XXX">
rank <= 12 and rank >=8
<cfelse>
rank <= 12 and rank >=11
</cfif>
order by 
<cfif session.modality EQ 4>
sp_rank
<cfelse>
rank
</cfif> --->
select mon
from months
where year2 = #session.fy#
order by 
<cfif session.modality EQ 4>
sp_rank
<cfelse>
rank
</cfif>

</cfquery>
</cfif>


<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QcollabStrat">
select stratName, partners
from sharedActivities as s, useractivities as u
where u.activity=s.stratName
and u.strategy != 10
and u.year2=s.year2

order by 1
</cfquery>

<cfquery datasource="#Application.DataSource#"  		 
	password="#Application.db_password#"   		
	username="#Application.db_username#" name="newActivities">
	
	select activity
	from useractivities
	where userid = '#session.userid#'
	and (del is Null or del <> 'Y')
	and year2=#session.fy#
	and strategy != 10
	union
	select activity
	from useractivities
	where activity in (<cfloop query="QcollabStrat">
			<cfif ListFind(partners, session.user_pk)>
				'#stratname#', 
			</cfif>
			</cfloop> 'NONE')
	and (del is Null or del <> 'Y')
	and year2=#session.fy#
	and strategy != 10
	order by 1
	
</cfquery>

<cfquery datasource="#Application.DataSource#"  		 
	password="#Application.db_password#"   		
	username="#Application.db_username#" name="oldActivities">
	
	select activity
	from useractivities
	where userid = '#session.userid#'
	and year2=#session.fy#
	and strategy != 10
	union
	select activity
	from useractivities
	where activity in (<cfloop query="QcollabStrat">
			<cfif ListFind(partners, session.user_pk)>
				'#htmlEditFormat(stratname)#', 
			</cfif>
			</cfloop> 'NONE')
	and year2=#session.fy#
	and strategy != 10
	order by 1
	
</cfquery>

<cfset form.year=session.fy>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="dispStrategies">

select a.activity, a.objective, rtrim(cast(p.progNum as char)) + ': ' + p.program as goal,
sum(case when month2='August' 
then 
case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as August,
sum(case when month2='September' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as September,
sum(case when month2='October' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as October,
sum(case when month2='November' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as November,
sum(case when month2='December' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as December,
sum(case when month2='January' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as January,
sum(case when month2='February' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as February,
sum(case when month2='March' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as March,
sum(case when month2='April' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as April,
sum(case when month2='May' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as May,
sum(case when month2='June' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as June,
sum(case when month2='July' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as July, del
from govt as b, useractivities as a, program as p
where 
(a.del is NULL and a.activity *= b.activity)
and 
(a.userid = '#session.userid#' 
OR
a.activity in (<cfloop query="QcollabStrat">
			<cfif ListFind(partners, session.user_pk)>
				'#stratname#', 
			</cfif>
			</cfloop> 'NONE')
)
and a.userid*=b.userid
and a.strategy = '1'
and a.goal = p.progNum
and b.year2=#session.fy#
and a.year2=#session.fy#
and p.year2=#session.fy#


group by a.activity, a.objective, p.program, p.prognum, del

UNION 

select a.activity, a.objective, rtrim(cast(p.progNum as char)) + ': ' + p.program as goal,
sum(case when month2='August' 
then 
case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as August,
sum(case when month2='September' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as September,
sum(case when month2='October' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as October,
sum(case when month2='November' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as November,
sum(case when month2='December' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as December,
sum(case when month2='January' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as January,
sum(case when month2='February' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as February,
sum(case when month2='March' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as March,
sum(case when month2='April' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as April,
sum(case when month2='May' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as May,
sum(case when month2='June' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as June,
sum(case when month2='July' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as July, del
from PAIDMEDIA as b, useractivities as a, program as p
where 
(a.del is NULL and a.activity *= b.activity)
and 
((a.userid = '#session.userid#')
OR
a.activity in (<cfloop query="QcollabStrat">
			<cfif ListFind(partners, session.user_pk)>
				'#stratname#', 
			</cfif>
			</cfloop> 'NONE')
)
and a.userid*=b.userid
and a.strategy = '2'
and a.goal = p.progNum
and b.year2=#session.fy#
and a.year2=#session.fy#
and p.year2=#session.fy#
group by a.activity, a.objective, p.program, p.prognum, del


 UNION 
 
select a.activity, a.objective, rtrim(cast(p.progNum as char)) + ': ' + p.program as goal,
sum(case when month2='August' 
then 
case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as August,
sum(case when month2='September' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as September,
sum(case when month2='October' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as October,
sum(case when month2='November' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as November,
sum(case when month2='December' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as December,
sum(case when month2='January' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as January,
sum(case when month2='February' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as February,
sum(case when month2='March' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as March,
sum(case when month2='April' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as April,
sum(case when month2='May' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as May,
sum(case when month2='June' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as June,
sum(case when month2='July' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as July, del
from FORUM as b, useractivities as a, program as p
where 
(a.del is NULL and a.activity *= b.activity)
and
(a.userid = '#session.userid#' 
OR
a.activity in (<cfloop query="QcollabStrat">
			<cfif ListFind(partners, session.user_pk)>
				'#stratname#', 
			</cfif>
			</cfloop> 'NONE')
)
and a.userid*=b.userid
and a.strategy = '4'
and a.goal = p.progNum
and b.year2=#session.fy#
and a.year2=#session.fy#
and p.year2=#session.fy#
group by a.activity, a.objective, p.program, p.prognum, del

UNION

select a.activity, a.objective,  rtrim(cast(p.progNum as char)) + ': ' + p.program as goal,
sum(case when month2='August' 
then 
case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as August,
sum(case when month2='September' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as September,
sum(case when month2='October' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as October,
sum(case when month2='November' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as November,
sum(case when month2='December' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as December,
sum(case when month2='January' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as January,
sum(case when month2='February' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as February,
sum(case when month2='March' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as March,
sum(case when month2='April' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as April,
sum(case when month2='May' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as May,
sum(case when month2='June' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as June,
sum(case when month2='July' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as July, del
from MONITOR as b, useractivities as a, program as p
where 
(a.del is NULL and a.activity *= b.activity)
and 
(a.userid = '#session.userid#' 
OR
a.activity in (<cfloop query="QcollabStrat">
			<cfif ListFind(partners, session.user_pk)>
				'#stratname#', 
			</cfif>
			</cfloop> 'NONE')
)
and a.userid*=b.userid
and a.strategy = '5'
and a.goal = p.progNum
and b.year2=#session.fy#
and a.year2=#session.fy#
and p.year2=#session.fy#
group by a.activity, a.objective, p.program, p.prognum, del

UNION

select a.activity, a.objective, rtrim(cast(p.progNum as char)) + ': ' + p.program as goal,
sum(case when month2='August' 
then 
case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as August,
sum(case when month2='September' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as September,
sum(case when month2='October' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as October,
sum(case when month2='November' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as November,
sum(case when month2='December' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as December,
sum(case when month2='January' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as January,
sum(case when month2='February' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as February,
sum(case when month2='March' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as March,
sum(case when month2='April' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as April,
sum(case when month2='May' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as May,
sum(case when month2='June' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as June,
sum(case when month2='July' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as July, del
from SURVEYPUB as b, useractivities as a, program as p
where 
(a.del is NULL and a.activity *= b.activity)
and 
(a.userid = '#session.userid#' 
OR
a.activity in (<cfloop query="QcollabStrat">
			<cfif ListFind(partners, session.user_pk)>
				'#stratname#', 
			</cfif>
			</cfloop> 'NONE')
)
and a.userid*=b.userid
and a.strategy = '6'
and a.goal = p.progNum
and b.year2=#session.fy#
and a.year2=#session.fy#
and p.year2=#session.fy#
group by a.activity, a.objective, p.program, p.prognum, del

UNION

select a.activity as activity, a.objective,  rtrim(cast(p.progNum as char)) + ': ' + p.program as goal,
sum(case when month2='August' 
then 
case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as August,
sum(case when month2='September' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as September,
sum(case when month2='October' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as October,
sum(case when month2='November' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as November,
sum(case when month2='December' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as December,
sum(case when month2='January' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as January,
sum(case when month2='February' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as February,
sum(case when month2='March' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as March,
sum(case when month2='April' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as April,
sum(case when month2='May' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as May,
sum(case when month2='June' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as June,
sum(case when month2='July' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as July, del
from CESSATION as b, useractivities as a, program as p
where 
(a.del is NULL and a.activity *= b.activity)
and 
(a.userid = '#session.userid#' 
OR
a.activity in (<cfloop query="QcollabStrat">
			<cfif ListFind(partners, session.user_pk)>
				'#stratname#', 
			</cfif>
			</cfloop> 'NONE')
)
and a.userid*=b.userid
and a.strategy = '7'
and a.goal = p.progNum
and b.year2=#session.fy#
and a.year2=#session.fy#
and p.year2=#session.fy#
group by a.activity, a.objective, p.program, p.prognum, del

UNION

select a.activity as activity, a.objective,  rtrim(cast(p.progNum as char)) + ': ' + p.program as goal,
sum(case when month2='August' 
then 
case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as August,
sum(case when month2='September' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as September,
sum(case when month2='October' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as October,
sum(case when month2='November' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as November,
sum(case when month2='December' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as December,
sum(case when month2='January' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as January,
sum(case when month2='February' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as February,
sum(case when month2='March' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as March,
sum(case when month2='April' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as April,
sum(case when month2='May' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as May,
sum(case when month2='June' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as June,
sum(case when month2='July' 
then case b.status
when 'Planning' then 10
when 'On-going' then 20
when 'Suspended' then 30
when 'Completed' then 40
else 1
end else 0 end) 
as July, del
from ADVOC b
inner join useractivities a
on a.userid=b.userid and a.activity = b.activity
inner join program p on a.goal = p.progNum
where 
a.del is NULL and 
a.userid = '#session.userid#' 
OR
a.activity in (<cfloop query="QcollabStrat">
			<cfif ListFind(partners, session.user_pk)>
				'#stratname#', 
			</cfif>
			</cfloop> 'NONE')
)

and (a.strategy ='8' OR a.strategy ='9')

and b.year2=#session.fy#
and a.year2=#session.fy#
and p.year2=#session.fy#
group by a.activity, a.objective, p.program, p.prognum, del

UNION

select a.activity as activity, a.objective,  rtrim(cast(p.progNum as char)) + ': ' + p.program as goal,
sum(case when month2='August' 
then 
20 else 0 end) 
as August,
sum(case when month2='September' 
then 
20 else 0 end)  
as September,
sum(case when month2='October' 
then 
20 else 0 end) 
as October,
sum(case when month2='November' 
then 
20 else 0 end) 
as November,
sum(case when month2='December' 
then 
20 else 0 end) 
as December,
sum(case when month2='January' 
then 
20 else 0 end) 
as January,
sum(case when month2='February' 
then  
20 else 0 end) 
as February,
sum(case when month2='March' 
then 
20 else 0 end) 
as March,
sum(case when month2='April' 
then 
20 else 0 end) 
as April,
sum(case when month2='May' 
then 
20 else 0 end) 
as May,
sum(case when month2='June' 
then 
20 else 0 end) 
as June,
sum(case when month2='July' 
then 
20 else 0 end) 
as July, del
from ADVOC b
inner join useractivities a
on a.userid = b.userid and a.activity = b.activity
and (a.strategy ='11')
inner join program p on a.goal = p.progNum
where 
a.del is NULL
and 
(a.userid = '#session.userid#' 
OR
a.activity in (<cfloop query="QcollabStrat">
			<cfif ListFind(partners, session.user_pk)>
				'#stratname#', 
			</cfif>
			</cfloop> 'NONE')
)
and b.year2=#session.fy#
and a.year2=#session.fy#
and p.year2=#session.fy#
group by a.activity, a.objective, p.program, p.prognum, del


ORDER BY 3,1
	
</cfquery>





<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="dispInfra">
select 
isNull(sum(case when month2='August' then (case when flag='1' then 9 else 1 end)	 else 0 end), 0) as August,
isNull(sum(case when month2='September' then (case when flag='1' then 9 else 1 end)	 else 0 end), 0) as September,
isNull(sum(case when month2='October' then (case when flag='1' then 9 else 1 end)	 else 0 end), 0) as October,
isNull(sum(case when month2='November' then (case when flag='1' then 9 else 1 end)	 else 0 end), 0) as November,
isNull(sum(case when month2='December' then (case when flag='1' then 9 else 1 end)	 else 0 end), 0) as December,
isNull(sum(case when month2='January' then (case when flag='1' then 9 else 1 end)	 else 0 end), 0) as January,
isNull(sum(case when month2='February' then (case when flag='1' then 9 else 1 end)	 else 0 end), 0) as February,
isNull(sum(case when month2='March' then (case when flag='1' then 9 else 1 end)	 else 0 end), 0) as March,
isNull(sum(case when month2='April' then (case when flag='1' then 9 else 1 end)	 else 0 end), 0) as April,
isNull(sum(case when month2='May' then (case when flag='1' then 9 else 1 end)	 else 0 end), 0) as May,
isNull(sum(case when month2='June' then (case when flag='1' then 9 else 1 end)	 else 0 end), 0) as June,
isNull(sum(case when month2='July' then (case when flag='1' then 9 else 1 end)	 else 0 end), 0) as July
from infra_monthly
where userid = '#session.userid#' 
and year2=#session.fy#
ORDER by 1
</cfquery>
	 
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="dispUsers">
select orgname, 
a.area, c.userid,
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
area as a,
contact as c
left outer join AM_feedback as q  on q.partner_id=c.userid 
and q.year2=#session.fy# 
where c.userid= '#session.userid#' 
and a.year2=#session.fy# 
and s.userid=c.userid 
and s.area=a.num 
group by orgname, 
a.area,
c.userid
ORDER BY 2,1
</cfquery>


<table align="left" cellpadding="10" cellspacing="0" border="0"  class="box" width="100%">		
<cfform action="monthlyActive.cfm?#session.urltoken#" name="f1">
<input type="hidden" name ="rptdate" value ="1/1/2008">
<input type="hidden" name ="monthdisplay" value="">

<CFSET this_month = DatePart('m', now())>
<cfif this_month EQ 1>
	<CFSET prev_month = 12>
<cfelse>
	<CFSET prev_month = this_month -1>
</cfif>
<cfset lastmonth = monthasstring(prev_month)>
<CFSET thismonth = monthasstring(this_month)> 
<!--- <cfif #session.modality# is 1 and #session.fy# is 2007>
<tr><td align="center"><br>
<strong>Cessation Centers will not be reporting for August 2006 until after a training is conducted at the end of August.  Contact Betty with any questions.
</td></tr>
<cfelse> --->

<tr><th colspan="2">Enter a new strategy report
</th></tr>

<cfoutput>
<cfif newActivities.recordcount EQ 0>
<tr>
	<th colspan="3">
	You need to enter a strategy in your workplan before you can proceed with monthly reporting!
	</th>
</tr>
<cfelse>













<cfif  SESSION.RETROcutM NEQ 0>
<cfquery datasource="#application.DataSource#" 	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qextension">
	select userid
	from msr_extensions 
	order by 1
</cfquery>

<cfif listcontains(valuelist(Qextension.userid), session.userid)>
	<cfset session.usermsrext=1>
</cfif>
<cfif session.modality NEQ 4>
	<cfset session.RETROcut=0>
</cfif>  
</cfif>
<cfif <!---   --->
<!--- (session.userid EQ "tfac" OR session.userid EQ "nyccoalition" OR session.userid EQ "nycrc" OR session.userid EQ "alleganyrc" or session.userid EQ "franklinrc" or session.userid EQ "SETONH" or session.userid EQ "washingtonrc" OR session.userid EQ "tiogarc" OR session.userid EQ "steubenrc")
 --->
SESSION.RETROcut EQ "1" or session.modality EQ 4 OR(listcontains(valuelist(Qextension.userid), session.userid))>


<!--- <cfif 1 EQ 2>  --->
<tr>
<td>Select a strategy and month for a new report:</td>
<td>
<cfselect name="oldActivities" query="newActivities" display ="activity" value="activity">
</cfselect>
</td>
<td><cfselect name="month1" query="Qmonths" display="mon" value="mon"></cfselect></td>
<td><input type="Submit" value="Monthly Strategy Report" onClick="setmonth2(document.f1.month1.options[document.f1.month1.selectedIndex].value);"></td>
</tr>




<tr><td colspan="2">Select a month to enter infrastructure activity:</td>
<td><cfselect name="month2" query="Qmonths" display="mon" value="mon"></cfselect></td>
<td><input type="Submit" value="Infrastructure Report" onClick="setmonth2(document.f1.month2.options[document.f1.month2.selectedIndex].value);this.form.action='monthlyInfra.cfm?#session.urltoken#';"></td>
</tr>

<cfelse>
<!--- begin alternate --->

<tr><td>Select a strategy and month for a new report:</td>
<td>
<cfselect name="oldActivities" query="newActivities" display ="activity" value="activity">
</cfselect>
</td>
<td>


<cfif session.modality EQ 4>
<cfif (lastmonth NEQ "november" OR (lastmonth EQ "november" and session.fy LT session.def_fy)) AND Day(Now()) LTE 15 >
	<input type="Submit" value="#lastmonth# Report" onClick="setmonth2('#lastmonth#');"><!--- <cfif lastmonth EQ "July"> disabled </cfif> --->
</cfif>
<cfif thismonth NEQ "december" OR (thismonth EQ "december" and  session.fy GTE session.def_fy)>
	<br><input type="Submit" value="#thismonth# Report" onClick="setmonth2('#thismonth#');">
</cfif>
<cfelse>
<cfif (lastmonth NEQ "july" OR (lastmonth EQ "july" and session.fy LT session.def_fy) OR session.modality EQ 4 ) AND Day(Now()) LTE 16>
	<input type="Submit" value="#lastmonth# Report" onClick="setmonth2('#lastmonth#');"><!--- <cfif lastmonth EQ "July"> disabled </cfif> --->
</cfif>
<cfif thismonth NEQ "august" OR (thismonth EQ "august" and  session.fy GTE session.def_fy)>
	<br><input type="Submit" value="#thismonth# Report" onClick="setmonth2('#thismonth#');">
</cfif>
</cfif>
<!--- <br><input type="Submit" value="October Report" onClick="setmonth2('October');">
 ---></td>
</tr>








<tr><td colspan="2">Select a month to enter infrastructure activity:</td>
<td>
<cfif session.modality EQ 4>
<cfif lastmonth NEQ "november" OR (lastmonth EQ "november" and session.fy LT session.def_fy)> 
	<input type="Submit" value="#lastmonth# Infrastructure Report" onclick="this.form.action='monthlyInfra.cfm?#session.urltoken#';setmonth2('#lastmonth#');"<!--- <cfif lastmonth EQ "July"> disabled </cfif> --->>
</cfif>
<cfif thismonth NEQ "december" OR (thismonth EQ "december" and  session.fy GTE session.def_fy) >
	<br><input type="Submit" value="#thismonth# Infrastructure Report" onClick="this.form.action='monthlyInfra.cfm?#session.urltoken#';setmonth2('#thismonth#');">
</cfif>
<cfelse>
<cfif lastmonth NEQ "july" OR (lastmonth EQ "july" and session.fy LT session.def_fy) > 
	<input type="Submit" value="#lastmonth# Infrastructure Report" onclick="this.form.action='monthlyInfra.cfm?#session.urltoken#';setmonth2('#lastmonth#');"<!--- <cfif lastmonth EQ "July"> disabled </cfif> --->>
</cfif>
<cfif thismonth NEQ "august" OR (thismonth EQ "august" and  session.fy GTE session.def_fy)>
	<br><input type="Submit" value="#thismonth# Infrastructure Report" onClick="this.form.action='monthlyInfra.cfm?#session.urltoken#';setmonth2('#thismonth#');">
</cfif>
</cfif>
<!--- 	<br><input type="Submit" value="October Infrastructure Report" onClick="this.form.action='monthlyInfra.cfm?#session.urltoken#';setmonth2('October');">
 --->
</td>
</tr>

</cfif>
<!--- end alternate --->
</cfif> 



<tr><th colspan="2">view/edit an existing strategy report?
</th></tr>


<input type="Hidden" name="year" value="#session.fy#">
<tr><td colspan="4">

<table align="center" cellpadding="10" cellspacing="0" border="0" class="box2">	
<tr>
	<th>Strategy</th>
	<cfif session.modality NEQ 4>
	<th>AUG</th>
	<th>SEP</th>
	<th>OCT</th>
	<th>NOV</th>	
	</cfif>
	<th>DEC</th>
	<th>JAN</th>
	<th>FEB</th>
	<th>MAR</th>
	<th>APR</th>
	<th>MAY</th>
	<th>JUN</th>
	<th>JUL</th>	
	<cfif session.modality EQ 4>
	<th>AUG</th>
	<th>SEP</th>
	<th>OCT</th>
	<th>NOV</th>
</cfif>
</tr>
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="curMoncheck">
	select rank 
	from months 
	where mon='#thisMonth#'
	and year2 = #session.fy#
	
</cfquery>
</cfoutput>
<!--- <cfif (rptMonCheck.rank GT curMonCheck.rank) OR ((rptMonCheck.rank + 1) LT curMonCheck.rank)> --->
<cfoutput query="dispInfra">
<tr>
	<td><font color="##7d053f">Infrastructure</font></td>
	<cfif session.modality NEQ 4>
	<td align="center"><cfif dispInfra.recordcount GT 0 and #AUGUST# NEQ 0> <a href="monthlyInfra.cfm?#session.urltoken#&mon=August&year=#form.year#" ><cfif #AUGUST# GTE 9>R<cfelse>***</cfif></a><CFELSE> -</cfif> </td>
	<td align="center"><cfif dispInfra.recordcount GT 0 and  #SEPTEMBER# NEQ 0> <a href="monthlyInfra.cfm?#session.urltoken#&mon=September&year=#form.year#"><cfif #SEPTEMBER# GTE 9>R<cfelse>***</cfif></a><CFELSE> -</cfif> </td>
	<td align="center"><cfif dispInfra.recordcount GT 0 and  #OCTOBER# NEQ 0> <a href="monthlyInfra.cfm?#session.urltoken#&mon=October&year=#form.year#"><cfif #OCTOBER# GTE 9>R<cfelse>***</cfif></a><CFELSE> -</cfif> </td>
	<td align="center"><cfif dispInfra.recordcount GT 0 and  #NOVEMBER# NEQ 0> <a href="monthlyInfra.cfm?#session.urltoken#&mon=November&year=#form.year#"><cfif #NOVEMBER# GTE 9>R<cfelse>***</cfif></a><CFELSE> -</cfif> </td>
	</cfif>
	<td align="center"><cfif dispInfra.recordcount GT 0 and  #DECEMBER# NEQ 0> <a href="monthlyInfra.cfm?#session.urltoken#&mon=December&year=#form.year#"><cfif #DECEMBER# GTE 9>R<cfelse>***</cfif></a><CFELSE> -</cfif> </td>
	<td align="center"><cfif dispInfra.recordcount GT 0 and  #JANUARY# NEQ 0> <a href="monthlyInfra.cfm?#session.urltoken#&mon=January&year=#form.year#"><cfif #JANUARY# GTE 9>R<cfelse>***</cfif></a><CFELSE> -</cfif> </td>
	<td align="center"><cfif dispInfra.recordcount GT 0 and  #FEBRUARY# NEQ 0> <a href="monthlyInfra.cfm?#session.urltoken#&mon=February&year=#form.year#"><cfif #FEBRUARY# GTE 9>R<cfelse>***</cfif></a><CFELSE> -</cfif> </td>
	<td align="center"><cfif dispInfra.recordcount GT 0 and  #MARCH# NEQ 0> <a href="monthlyInfra.cfm?#session.urltoken#&mon=March&year=#form.year#"><cfif #MARCH# GTE 9>R<cfelse>***</cfif></a><CFELSE> -</cfif> </td>
	<td align="center"><cfif dispInfra.recordcount GT 0 and  #APRIL# NEQ 0> <a href="monthlyInfra.cfm?#session.urltoken#&mon=April&year=#form.year#"><cfif #APRIL# GTE 9>R<cfelse>***</cfif></a><CFELSE> -</cfif> </td>
	<td align="center"><cfif dispInfra.recordcount GT 0 and  #MAY# NEQ 0> <a href="monthlyInfra.cfm?#session.urltoken#&amp;mon=May&amp;year=#form.year#"><cfif #MAY# GTE 9>R<cfelse>***</cfif></a><CFELSE> -</cfif> </td>
	<td align="center"><cfif dispInfra.recordcount GT 0 and  #JUNE# NEQ 0> <a href="monthlyInfra.cfm?#session.urltoken#&amp;mon=June&amp;year=#form.year#"><cfif #JUNE# GTE 9>R<cfelse>***</cfif></a><CFELSE> -</cfif> </td>
	<td align="center"><cfif dispInfra.recordcount GT 0 and  #JULY# NEQ 0> <a href="monthlyInfra.cfm?#session.urltoken#&amp;mon=July&amp;year=#form.year#"><cfif #JULY# GTE 9>R<cfelse>***</cfif></a><CFELSE> -</cfif> </td>
	<cfif session.modality EQ 4>
	<td align="center"><cfif dispInfra.recordcount GT 0 and #AUGUST# NEQ 0> <a href="monthlyInfra.cfm?#session.urltoken#&mon=August&year=#form.year#" ><cfif #AUGUST# GTE 9>R<cfelse>***</cfif></a><CFELSE> -</cfif> </td>
	<td align="center"><cfif dispInfra.recordcount GT 0 and  #SEPTEMBER# NEQ 0> <a href="monthlyInfra.cfm?#session.urltoken#&mon=September&year=#form.year#"><cfif #SEPTEMBER# GTE 9>R<cfelse>***</cfif></a><CFELSE> -</cfif> </td>
	<td align="center"><cfif dispInfra.recordcount GT 0 and  #OCTOBER# NEQ 0> <a href="monthlyInfra.cfm?#session.urltoken#&mon=October&year=#form.year#"><cfif #OCTOBER# GTE 9>R<cfelse>***</cfif></a><CFELSE> -</cfif> </td>
	<td align="center"><cfif dispInfra.recordcount GT 0 and  #NOVEMBER# NEQ 0> <a href="monthlyInfra.cfm?#session.urltoken#&mon=November&year=#form.year#"><cfif #NOVEMBER# GTE 9>R<cfelse>***</cfif></a><CFELSE> -</cfif> </td>
	</cfif>
</tr></cfoutput>			
		








	







<cfoutput query="dispUsers">
<tr>
	<th>Area Manager Feedback</th>
	<cfif session.modality NEQ 4>
	<th>AUG</th>
	<th>SEP</th>
	<th>OCT</th>
	<th>NOV</th>
	</cfif>
	<th>DEC</th>
	<th>JAN</th>
	<th>FEB</th>
	<th>MAR</th>
	<th>APR</th>
	<th>MAY</th>
	<th>JUN</th>
	<th>JUL</th>
	<cfif session.modality EQ 4>
	<th>AUG</th>
	<th>SEP</th>
	<th>OCT</th>
	<th>NOV</th>
	</cfif>	
</tr>
<tr>
	<td><font color="Green">#orgname#</font></td>
	<cfif session.modality NEQ 4>
	<td align="center"><cfif #AUGUST# NEQ 0> <a href="AM_Feedback_det.cfm?#session.urltoken#&activ=#URLEncodedFormat(userid)#&mon=August&year=#form.year#" ><cfif #AUGUST# EQ 1><font color="##FF0000">***</font><cfelse>&##8730;</cfif></a><CFELSE> -</cfif> </td>
	<td align="center"><cfif #SEPTEMBER# NEQ 0> <a href="AM_Feedback_det.cfm?#session.urltoken#&activ=#URLEncodedFormat(userid)#&mon=September&year=#form.year#"><cfif #SEPTEMBER# EQ 1><font color="##FF0000">***</font><cfelse>&##8730;</cfif></a><CFELSE> -</cfif> </td>
	<td align="center"><cfif #OCTOBER# NEQ 0> <a href="AM_Feedback_det.cfm?#session.urltoken#&activ=#URLEncodedFormat(userid)#&mon=October&year=#form.year#"><cfif #OCTOBER# EQ 1><font color="##FF0000">***</font><cfelse>&##8730;</cfif></a><CFELSE> -</cfif> </td>
	<td align="center"><cfif #NOVEMBER# NEQ 0> <a href="AM_Feedback_det.cfm?#session.urltoken#&activ=#URLEncodedFormat(userid)#&mon=November&year=#form.year#"><cfif #NOVEMBER# EQ 1><font color="##FF0000">***</font><cfelse>&##8730;</cfif></a><CFELSE> -</cfif> </td>
	</cfif>
	<td align="center"><cfif #DECEMBER# NEQ 0> <a href="AM_Feedback_det.cfm?#session.urltoken#&activ=#URLEncodedFormat(userid)#&mon=December&year=#form.year#"><cfif #DECEMBER# EQ 1><font color="##FF0000">***</font><cfelse>&##8730;</cfif></a><CFELSE> -</cfif> </td>
	<td align="center"><cfif #JANUARY# NEQ 0> <a href="AM_Feedback_det.cfm?#session.urltoken#&activ=#URLEncodedFormat(userid)#&mon=January&year=#form.year#"><cfif #JANUARY# EQ 1><font color="##FF0000">***</font><cfelse>&##8730;</cfif></a><CFELSE> -</cfif> </td>
	<td align="center"><cfif #FEBRUARY# NEQ 0> <a href="AM_Feedback_det.cfm?#session.urltoken#&activ=#URLEncodedFormat(userid)#&mon=February&year=#form.year#"><cfif #FEBRUARY# EQ 1><font color="##FF0000">***</font><cfelse>&##8730;</cfif></a><CFELSE> -</cfif> </td>
	<td align="center"><cfif #MARCH# NEQ 0> <a href="AM_Feedback_det.cfm?#session.urltoken#&activ=#URLEncodedFormat(userid)#&mon=March&year=#form.year#"><cfif #MARCH# EQ 1><font color="##FF0000">***</font><cfelse>&##8730;</cfif></a><CFELSE> -</cfif> </td>
	<td align="center"><cfif #APRIL# NEQ 0> <a href="AM_Feedback_det.cfm?#session.urltoken#&activ=#URLEncodedFormat(userid)#&mon=April&year=#form.year#"><cfif #APRIL# EQ 1><font color="##FF0000">***</font><cfelse>&##8730;</cfif></a><CFELSE> -</cfif> </td>
	<td align="center"><cfif #MAY# NEQ 0> <a href="AM_Feedback_det.cfm?#session.urltoken#&activ=#URLEncodedFormat(userid)#&amp;mon=May&amp;year=#form.year#"><cfif #MAY# EQ 1><font color="##FF0000">***</font><cfelse>&##8730;</cfif></a><CFELSE> -</cfif> </td>
	<td align="center"><cfif #JUNE# NEQ 0> <a href="AM_Feedback_det.cfm?#session.urltoken#&activ=#URLEncodedFormat(userid)#&amp;mon=June&amp;year=#form.year#"><cfif #JUNE# EQ 1><font color="##FF0000">***</font><cfelse>&##8730;</cfif></a><CFELSE> -</cfif> </td>
	<td align="center"><cfif #JULY# NEQ 0> <a href="AM_Feedback_det.cfm?#session.urltoken#&activ=#URLEncodedFormat(userid)#&amp;mon=July&amp;year=#form.year#"><cfif #JULY# EQ 1><font color="##FF0000">***</font><cfelse>&##8730;</cfif></a><CFELSE> -</cfif> </td>
	<cfif session.modality EQ 4>
	<td align="center"><cfif #AUGUST# NEQ 0> <a href="AM_Feedback_det.cfm?#session.urltoken#&activ=#URLEncodedFormat(userid)#&mon=August&year=#form.year#" ><cfif #AUGUST# EQ 1><font color="##FF0000">***</font><cfelse>&##8730;</cfif></a><CFELSE> -</cfif> </td>
	<td align="center"><cfif #SEPTEMBER# NEQ 0> <a href="AM_Feedback_det.cfm?#session.urltoken#&activ=#URLEncodedFormat(userid)#&mon=September&year=#form.year#"><cfif #SEPTEMBER# EQ 1><font color="##FF0000">***</font><cfelse>&##8730;</cfif></a><CFELSE> -</cfif> </td>
	<td align="center"><cfif #OCTOBER# NEQ 0> <a href="AM_Feedback_det.cfm?#session.urltoken#&activ=#URLEncodedFormat(userid)#&mon=October&year=#form.year#"><cfif #OCTOBER# EQ 1><font color="##FF0000">***</font><cfelse>&##8730;</cfif></a><CFELSE> -</cfif> </td>
	<td align="center"><cfif #NOVEMBER# NEQ 0> <a href="AM_Feedback_det.cfm?#session.urltoken#&activ=#URLEncodedFormat(userid)#&mon=November&year=#form.year#"><cfif #NOVEMBER# EQ 1><font color="##FF0000">***</font><cfelse>&##8730;</cfif></a><CFELSE> -</cfif> </td>
	</cfif>
</tr>
</cfoutput>



<cfoutput query="dispStrategies" group="goal">
<tr><th colspan="13" align="left">#goal#</th></tr>
<tr>
	<th>Strategy</th>
	<cfif session.modality NEQ 4>
	<th>AUG</th>
	<th>SEP</th>
	<th>OCT</th>
	<th>NOV</th>
	</cfif>
	<th>DEC</th>
	<th>JAN</th>
	<th>FEB</th>
	<th>MAR</th>
	<th>APR</th>
	<th>MAY</th>
	<th>JUN</th>
	<th>JUL</th>
	<cfif session.modality EQ 4>
	<th>AUG</th>
	<th>SEP</th>
	<th>OCT</th>
	<th>NOV</th>
	</cfif>	
</tr>
<cfoutput>
<tr>
	<td><font color=<cfif del EQ 'Y'>"Black"<cfelse>"Green"</cfif>>#activity#</font></td>
	<cfif session.modality NEQ 4>
	<td align="center"><cfif #AUGUST# NEQ 0> <a href="monthlyActive.cfm?#session.urltoken#&activ=#URLEncodedFormat(activity)#&mon=August&year=#form.year#" ><cfif august EQ 10>P<cfelseif august EQ 20>O<cfelseif august EQ 30>S<cfelseif august EQ 40>C<cfelse>***</cfif></a><CFELSE> -</cfif> </td>
	<td align="center"><cfif #SEPTEMBER# NEQ 0> <a href="monthlyActive.cfm?#session.urltoken#&activ=#URLEncodedFormat(activity)#&mon=September&year=#form.year#"><cfif September EQ 10>P<cfelseif September EQ 20>O<cfelseif September EQ 30>S<cfelseif September EQ 40>C<cfelse>***</cfif></a><CFELSE> -</cfif> </td>
	<td align="center"><cfif #OCTOBER# NEQ 0> <a href="monthlyActive.cfm?#session.urltoken#&activ=#URLEncodedFormat(activity)#&mon=October&year=#form.year#"><cfif October EQ 10>P<cfelseif October EQ 20>O<cfelseif October EQ 30>S<cfelseif October EQ 40>C<cfelse>***</cfif></a><CFELSE> -</cfif> </td>
	<td align="center"><cfif #NOVEMBER# NEQ 0> <a href="monthlyActive.cfm?#session.urltoken#&activ=#URLEncodedFormat(activity)#&mon=November&year=#form.year#"><cfif November EQ 10>P<cfelseif November EQ 20>O<cfelseif November EQ 30>S<cfelseif November EQ 40>C<cfelse>***</cfif></a><CFELSE> -</cfif> </td>
	</cfif>
	<td align="center"><cfif #DECEMBER# NEQ 0> <a href="monthlyActive.cfm?#session.urltoken#&activ=#URLEncodedFormat(activity)#&mon=December&year=#form.year#"><cfif December EQ 10>P<cfelseif December EQ 20>O<cfelseif December EQ 30>S<cfelseif December EQ 40>C<cfelse>***</cfif></a><CFELSE> -</cfif> </td>
	<td align="center"><cfif #JANUARY# NEQ 0> <a href="monthlyActive.cfm?#session.urltoken#&activ=#URLEncodedFormat(activity)#&mon=January&year=#form.year#"><cfif January EQ 10>P<cfelseif January EQ 20>O<cfelseif January EQ 30>S<cfelseif January EQ 40>C<cfelse>***</cfif></a><CFELSE> -</cfif> </td>
	<td align="center"><cfif #FEBRUARY# NEQ 0> <a href="monthlyActive.cfm?#session.urltoken#&activ=#URLEncodedFormat(activity)#&mon=February&year=#form.year#"><cfif February EQ 10>P<cfelseif February EQ 20>O<cfelseif February EQ 30>S<cfelseif February EQ 40>C<cfelse>***</cfif></a><CFELSE> -</cfif> </td>
	<td align="center"><cfif #MARCH# NEQ 0> <a href="monthlyActive.cfm?#session.urltoken#&activ=#URLEncodedFormat(activity)#&mon=March&year=#form.year#"><cfif March EQ 10>P<cfelseif March EQ 20>O<cfelseif March EQ 30>S<cfelseif March EQ 40>C<cfelse>***</cfif></a><CFELSE> -</cfif> </td>
	<td align="center"><cfif #APRIL# NEQ 0> <a href="monthlyActive.cfm?#session.urltoken#&activ=#URLEncodedFormat(activity)#&mon=April&year=#form.year#"><cfif April EQ 10>P<cfelseif April EQ 20>O<cfelseif April EQ 30>S<cfelseif April EQ 40>C<cfelse>***</cfif></a><CFELSE> -</cfif> </td>
	<td align="center"><cfif #MAY# NEQ 0> <a href="monthlyActive.cfm?#session.urltoken#&activ=#URLEncodedFormat(activity)#&amp;mon=May&amp;year=#form.year#"><cfif May EQ 10>P<cfelseif May EQ 20>O<cfelseif May EQ 30>S<cfelseif May EQ 40>C<cfelse>***</cfif></a><CFELSE> -</cfif> </td>
	<td align="center"><cfif #JUNE# NEQ 0> <a href="monthlyActive.cfm?#session.urltoken#&activ=#URLEncodedFormat(activity)#&amp;mon=June&amp;year=#form.year#"><cfif June EQ 10>P<cfelseif June EQ 20>O<cfelseif June EQ 30>S<cfelseif June EQ 40>C<cfelse>***</cfif></a><CFELSE> -</cfif> </td>
	<td align="center"><cfif #JULY# NEQ 0> <a href="monthlyActive.cfm?#session.urltoken#&activ=#URLEncodedFormat(activity)#&amp;mon=July&amp;year=#form.year#"><cfif July EQ 10>P<cfelseif July EQ 20>O<cfelseif July EQ 30>S<cfelseif July EQ 40>C<cfelse>***</cfif></a><CFELSE> -</cfif> </td>
	<cfif session.modality EQ 4>
	<td align="center"><cfif #AUGUST# NEQ 0> <a href="monthlyActive.cfm?#session.urltoken#&activ=#URLEncodedFormat(activity)#&mon=August&year=#form.year#" ><cfif august EQ 10>P<cfelseif august EQ 20>O<cfelseif august EQ 30>S<cfelseif august EQ 40>C<cfelse>***</cfif></a><CFELSE> -</cfif> </td>
	<td align="center"><cfif #SEPTEMBER# NEQ 0> <a href="monthlyActive.cfm?#session.urltoken#&activ=#URLEncodedFormat(activity)#&mon=September&year=#form.year#"><cfif September EQ 10>P<cfelseif September EQ 20>O<cfelseif September EQ 30>S<cfelseif September EQ 40>C<cfelse>***</cfif></a><CFELSE> -</cfif> </td>
	<td align="center"><cfif #OCTOBER# NEQ 0> <a href="monthlyActive.cfm?#session.urltoken#&activ=#URLEncodedFormat(activity)#&mon=October&year=#form.year#"><cfif October EQ 10>P<cfelseif October EQ 20>O<cfelseif October EQ 30>S<cfelseif October EQ 40>C<cfelse>***</cfif></a><CFELSE> -</cfif> </td>
	<td align="center"><cfif #NOVEMBER# NEQ 0> <a href="monthlyActive.cfm?#session.urltoken#&activ=#URLEncodedFormat(activity)#&mon=November&year=#form.year#"><cfif November EQ 10>P<cfelseif November EQ 20>O<cfelseif November EQ 30>S<cfelseif November EQ 40>C<cfelse>***</cfif></a><CFELSE> -</cfif> </td>
	</cfif>
</tr></cfoutput>			
		


</cfoutput>
</table>



</td></tr>

<!--- </cfif> --->
</cfform>
<!--- <cfif #session.modality# is not 1 and #session.fy# is not 2007>
 --->
 <tr><td colspan="4">

<table class="box2" cellpadding="5" border=".2"  align="center" width="75%">
<tr>
	<th colspan="3">Key for Monthly Strategy Report grid</th>
</tr>
<tr>
	<th>Key</th>
	<th width="50">Display</th>
	<th>What it means</th>
</tr>
<tr>
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
</tr>
<tr>
	<td rowspan="3" valign="top">Area Manager feedback</td>
	<td align="center">-</td>
	<td>There is no Area Manager feedback submitted for this month</td>
</tr>
<tr>
	<td align="center"><font color="#FF0000">***</font></td>
	<td>There is Area Manager feedback for this month.  Click the asterisks to read it</td>
</tr>
<tr>
	<td align="center">&#8730;</td>
	<td>Partner has checked the box to indicate that they have read this Area Manager feedback</td>
	
</tr>

<tr>
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
</tr>
</table>
</td></tr>
</table></td></tr>	
<tr>
<td>


	


</td>
</tr>
<!--- </cfif> --->
</table>

<br>




</body>

</html>
