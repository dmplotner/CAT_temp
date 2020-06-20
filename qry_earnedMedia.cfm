<cfinclude template="qry_report_filter.cfm">


<cfquery datasource="#Application.DataSource#"  		 
	password="#Application.db_password#"  		
	username="#Application.db_username#" name="QEarnedMedia">
	select
0 as NS,
<!--- 0 as ed, --->
0 as OE,
0 as RC,
0 as car,
0 as pic,
0 as led,
0 as ran,
0 as r1,
0 as r2,
0 as r3,
0 as r4,
0 as r5,
p.prognum as goalid,
o.id as objectiveid,
p.program as goal,
o.objective as objective, o.year2
from
program as p,
objectives as o
where p.progNum NOT in (5,6) and
p.prognum=o.prognum
and p.year2=o.year2
and p.year2=#session.fy#
and (o.del is null or o.del !=1)

UNION

select
count(case
when type='1' then type
when type='10' then type
when type='11' then type
end) as NS,
<!--- count(case
when type='2' then type
end) as ed, --->
count(case
when type='2' then type
when type='3' then type
when type='12' then type
end) as OE,
count(case
when type='4' then type
end) as RC,
count(case
when type='5' then type
end) as car,
count(case
when type='6' then type
when type='13' then type
end) as pic,
count(case
when type='7' then type
end) as led,
0 as run,
0 as r1,
0 as r2,
0 as r3,
0 as r4,
0 as r5,
u.goal as goalid,
u.objective as objectiveid,
p.program as goal,
o.objective as objective, u.year2
from

newspaper as n,
useractivities as u,
program as p,
objectives as o,
govt as a,
contact as c
where p.progNum NOT in (5,6) and
p.prognum=u.goal
and u.year2=p.year2
and u.year2=o.year2
and u.year2=n.year2
and o.id=u.objective
and n.userid=u.userid
and n.activity=u.activity
and u.year2=a.year2
and u.userid=a.userid
and u.activity=a.activity
and a.month2=n.month2
and (u.del is null OR u.del != 'Y')
and u.strategy=1
and u.userid=c.userid
and (o.del is null or o.del !=1)
and u.year2=#session.fy# <cfinclude template="report_filter.cfm">
group by u.goal, u.objective, p.program, o.objective, u.year2
union
select
0 as NS,
<!--- 0 as ed, --->
0 as OE,
0 as RC,
0 as car,
0 as pic,
0 as led,
count(case
when run='1' then run
end) as ran,
0 as r1,
0 as r2,
0 as r3,
0 as r4,
0 as r5,
u.goal as goalid,
u.objective as objectiveid,
p.program as goal,
o.objective as objective, u.year2
from
radio as n,
useractivities as u,
program as p,
objectives as o,
govt as a,
contact as c
where p.progNum NOT in (5,6) and
p.prognum=u.goal
and u.year2=p.year2
and u.year2=o.year2
and u.year2=n.year2
and o.id=u.objective
and n.userid=u.userid
and u.userid=c.userid
and n.activity=u.activity
and u.year2=a.year2
and u.userid=a.userid
and u.activity=a.activity
and a.month2=n.month2
and (u.del is null OR u.del != 'Y')
and u.strategy=1
and (o.del is null or o.del !=1)
and u.year2=#session.fy# <cfinclude template="report_filter.cfm">
group by u.goal, u.objective, p.program, o.objective, u.year2
union

select
0 as NS,
<!--- 0 as ed, --->
0 as OE,
0 as RC,
0 as car,
0 as pic,
0 as led,
0 as ran,
count(case
when recruit1='1' then 1
end) as r1,
count(case
when recruit2='1' then 1
end) as r2,
count(case
when recruit3='1' then 1
end) as r3,
count(case
when recruit4='1' then 1
end) as r4,
count(case
when recruit5='1' then 1
end) as r5,
u.goal as goalid,
u.objective as objectiveid,
p.program as goal,
o.objective as objective, u.year2
from
earnedmedia as n,
useractivities as u,
program as p,
objectives as o,
govt as a,
contact as c
where p.progNum NOT in (5,6) and
p.prognum=u.goal
and u.userid=c.userid
and u.year2=p.year2
and u.year2=o.year2
and u.year2=n.year2
and o.id=u.objective
and n.userid=u.userid
and n.activity=u.activity
and u.year2=a.year2
and u.userid=a.userid
and u.activity=a.activity
and a.month2=n.month2
and (o.del is null or o.del !=1)
and (u.del is null OR u.del != 'Y')
and u.strategy=1
and u.year2=#session.fy# <cfinclude template="report_filter.cfm">
group by u.goal, u.objective, p.program, o.objective, u.year2

union

select
count(case
when type='1' then type
when type='10' then type
when type='11' then type
end) as NS,
<!--- count(case
when type='2' then type
end) as ed, --->
count(case
when type='2' then type
when type='3' then type
when type='12' then type
end) as OE,
count(case
when type='4' then type
end) as RC,
count(case
when type='5' then type
end) as car,
count(case
when type='6' then type
when type='13' then type
end) as pic,
count(case
when type='7' then type
end) as led,
0 as run,
0 as r1,
0 as r2,
0 as r3,
0 as r4,
0 as r5,
u.goal as goalid,
u.objective as objectiveid,
p.program as goal,
o.objective as objective, u.year2
from

newspaper as n,
useractivities as u,
program as p,
objectives as o,
PaidMedia as a,
contact as c
where p.progNum NOT in (5,6) and
p.prognum=u.goal
and u.year2=p.year2
and u.userid=c.userid
and u.year2=o.year2
and u.year2=n.year2
and o.id=u.objective
and n.userid=u.userid
and n.activity=u.activity
and u.year2=a.year2
and u.userid=a.userid
and u.activity=a.activity
and a.month2=n.month2
and (o.del is null or o.del !=1)
and (u.del is null OR u.del != 'Y')
and u.strategy=2
and u.year2=#session.fy# <cfinclude template="report_filter.cfm">
group by u.goal, u.objective, p.program, o.objective, u.year2
union

select
0 as NS,
<!--- 0 as ed, --->
0 as OE,
0 as RC,
0 as car,
0 as pic,
0 as led,
count(case
when run='1' then run
end) as ran,
0 as r1,
0 as r2,
0 as r3,
0 as r4,
0 as r5,
u.goal as goalid,
u.objective as objectiveid,
p.program as goal,
o.objective as objective, u.year2
from
radio as n,
useractivities as u,
program as p,
objectives as o,
PaidMedia as a,
contact as c
where p.progNum NOT in (5,6) and
p.prognum=u.goal
and u.userid=c.userid
and u.year2=p.year2
and u.year2=o.year2
and u.year2=n.year2
and o.id=u.objective
and n.userid=u.userid
and n.activity=u.activity
and u.year2=a.year2
and u.userid=a.userid
and u.activity=a.activity
and a.month2=n.month2
and (o.del is null or o.del !=1)
and (u.del is null OR u.del != 'Y')
and u.strategy=2
and u.year2=#session.fy# <cfinclude template="report_filter.cfm">
group by u.goal, u.objective, p.program, o.objective, u.year2
union

select
0 as NS,
<!--- 0 as ed, --->
0 as OE,
0 as RC,
0 as car,
0 as pic,
0 as led,
0 as ran,
count(case
when recruit1='1' then 1
end) as r1,
count(case
when recruit2='1' then 1
end) as r2,
count(case
when recruit3='1' then 1
end) as r3,
count(case
when recruit4='1' then 1
end) as r4,
count(case
when recruit5='1' then 1
end) as r5,
u.goal as goalid,
u.objective as objectiveid,
p.program as goal,
o.objective as objective, u.year2
from
earnedmedia as n,
useractivities as u,
program as p,
objectives as o,
PaidMedia as a,
contact as c
where p.progNum NOT in (5,6) and
p.prognum=u.goal
and u.userid=c.userid
and u.year2=p.year2
and u.year2=o.year2
and u.year2=n.year2
and o.id=u.objective
and n.userid=u.userid
and n.activity=u.activity
and u.year2=a.year2
and u.userid=a.userid
and u.activity=a.activity
and a.month2=n.month2
and (o.del is null or o.del !=1)
and (u.del is null OR u.del != 'Y')
and u.strategy=2
and u.year2=#session.fy# <cfinclude template="report_filter.cfm">
group by u.goal, u.objective, p.program, o.objective, u.year2

union

select
count(case
when type='1' then type
when type='10' then type
when type='11' then type
end) as NS,
<!--- count(case
when type='2' then type
end) as ed, --->
count(case
when type='2' then type
when type='3' then type
when type='12' then type
end) as OE,
count(case
when type='4' then type
end) as RC,
count(case
when type='5' then type
end) as car,
count(case
when type='6' then type
when type='13' then type
end) as pic,
count(case
when type='7' then type
end) as led,
0 as run,
0 as r1,
0 as r2,
0 as r3,
0 as r4,
0 as r5,
u.goal as goalid,
u.objective as objectiveid,
p.program as goal,
o.objective as objective, u.year2
from

newspaper as n,
useractivities as u,
program as p,
objectives as o,
FORUM as a,
contact as c
where p.progNum NOT in (5,6) and
p.prognum=u.goal
and u.userid=c.userid
and u.year2=p.year2
and u.year2=o.year2
and u.year2=n.year2
and o.id=u.objective
and n.userid=u.userid
and n.activity=u.activity
and u.year2=a.year2
and u.userid=a.userid
and u.activity=a.activity
and a.month2=n.month2
and (o.del is null or o.del !=1)
and (u.del is null OR u.del != 'Y')
and u.strategy=4
and u.year2=#session.fy# <cfinclude template="report_filter.cfm">
group by u.goal, u.objective, p.program, o.objective, u.year2
union
select
0 as NS,
<!--- 0 as ed, --->
0 as OE,
0 as RC,
0 as car,
0 as pic,
0 as led,
count(case
when run='1' then run
end) as ran,
0 as r1,
0 as r2,
0 as r3,
0 as r4,
0 as r5,
u.goal as goalid,
u.objective as objectiveid,
p.program as goal,
o.objective as objective, u.year2
from
radio as n,
useractivities as u,
program as p,
objectives as o,
FORUM as a,
contact as c
where p.progNum NOT in (5,6) and
p.prognum=u.goal
and u.userid=c.userid
and u.year2=p.year2
and u.year2=o.year2
and u.year2=n.year2
and o.id=u.objective
and n.userid=u.userid
and n.activity=u.activity
and u.year2=a.year2
and u.userid=a.userid
and u.activity=a.activity
and a.month2=n.month2
and (o.del is null or o.del !=1)
and (u.del is null OR u.del != 'Y')
and u.strategy=4
and u.year2=#session.fy# <cfinclude template="report_filter.cfm">
group by u.goal, u.objective, p.program, o.objective, u.year2
union

select
0 as NS,
<!--- 0 as ed, --->
0 as OE,
0 as RC,
0 as car,
0 as pic,
0 as led,
0 as ran,
count(case
when recruit1='1' then 1
end) as r1,
count(case
when recruit2='1' then 1
end) as r2,
count(case
when recruit3='1' then 1
end) as r3,
count(case
when recruit4='1' then 1
end) as r4,
count(case
when recruit5='1' then 1
end) as r5,
u.goal as goalid,
u.objective as objectiveid,
p.program as goal,
o.objective as objective, u.year2
from
earnedmedia as n,
useractivities as u,
program as p,
objectives as o,
FORUM as a,
contact as c
where p.progNum NOT in (5,6) and
p.prognum=u.goal
and u.userid=c.userid
and u.year2=p.year2
and u.year2=o.year2
and u.year2=n.year2
and o.id=u.objective
and n.userid=u.userid
and n.activity=u.activity
and u.year2=a.year2
and u.userid=a.userid
and u.activity=a.activity
and a.month2=n.month2
and (o.del is null or o.del !=1)
and (u.del is null OR u.del != 'Y')
and u.strategy=4
and u.year2=#session.fy# <cfinclude template="report_filter.cfm">
group by u.goal, u.objective, p.program, o.objective, u.year2

union

select
count(case
when type='1' then type
when type='10' then type
when type='11' then type
end) as NS,
<!--- count(case
when type='2' then type
end) as ed, --->
count(case
when type='2' then type
when type='3' then type
when type='12' then type
end) as OE,
count(case
when type='4' then type
end) as RC,
count(case
when type='5' then type
end) as car,
count(case
when type='6' then type
when type='13' then type
end) as pic,
count(case
when type='7' then type
end) as led,
0 as run,
0 as r1,
0 as r2,
0 as r3,
0 as r4,
0 as r5,
u.goal as goalid,
u.objective as objectiveid,
p.program as goal,
o.objective as objective, u.year2
from

newspaper as n,
useractivities as u,
program as p,
objectives as o,
monitor as a,
contact as c
where p.progNum NOT in (5,6) and
p.prognum=u.goal
and u.userid=c.userid
and u.year2=p.year2
and u.year2=o.year2
and u.year2=n.year2
and o.id=u.objective
and n.userid=u.userid
and n.activity=u.activity
and u.year2=a.year2
and u.userid=a.userid
and u.activity=a.activity
and a.month2=n.month2
and (o.del is null or o.del !=1)
and (u.del is null OR u.del != 'Y')
and u.strategy=5
and u.year2=#session.fy# <cfinclude template="report_filter.cfm">
group by u.goal, u.objective, p.program, o.objective, u.year2
union
select
0 as NS,
<!--- 0 as ed, --->
0 as OE,
0 as RC,
0 as car,
0 as pic,
0 as led,
count(case
when run='1' then run
end) as ran,
0 as r1,
0 as r2,
0 as r3,
0 as r4,
0 as r5,
u.goal as goalid,
u.objective as objectiveid,
p.program as goal,
o.objective as objective, u.year2
from
radio as n,
useractivities as u,
program as p,
objectives as o,
monitor as a,
contact as c
where p.progNum NOT in (5,6) and
p.prognum=u.goal
and u.userid=c.userid
and u.year2=p.year2
and u.year2=o.year2
and u.year2=n.year2
and o.id=u.objective
and n.userid=u.userid
and n.activity=u.activity
and u.year2=a.year2
and u.userid=a.userid
and u.activity=a.activity
and a.month2=n.month2
and (o.del is null or o.del !=1)
and (u.del is null OR u.del != 'Y')
and u.strategy=5
and u.year2=#session.fy# <cfinclude template="report_filter.cfm">
group by u.goal, u.objective, p.program, o.objective, u.year2
union

select
0 as NS,
<!--- 0 as ed, --->
0 as OE,
0 as RC,
0 as car,
0 as pic,
0 as led,
0 as ran,
count(case
when recruit1='1' then 1
end) as r1,
count(case
when recruit2='1' then 1
end) as r2,
count(case
when recruit3='1' then 1
end) as r3,
count(case
when recruit4='1' then 1
end) as r4,
count(case
when recruit5='1' then 1
end) as r5,
u.goal as goalid,
u.objective as objectiveid,
p.program as goal,
o.objective as objective, u.year2
from
earnedmedia as n,
useractivities as u,
program as p,
objectives as o,
monitor as a,
contact as c
where p.progNum NOT in (5,6) and
p.prognum=u.goal
and u.userid=c.userid
and u.year2=p.year2
and u.year2=o.year2
and u.year2=n.year2
and o.id=u.objective
and n.userid=u.userid
and n.activity=u.activity
and u.year2=a.year2
and u.userid=a.userid
and u.activity=a.activity
and a.month2=n.month2
and (o.del is null or o.del !=1)
and (u.del is null OR u.del != 'Y')
and u.strategy=5
and u.year2=#session.fy# <cfinclude template="report_filter.cfm">
group by u.goal, u.objective, p.program, o.objective, u.year2

union

select
count(case
when type='1' then type
when type='10' then type
when type='11' then type
end) as NS,
<!--- count(case
when type='2' then type
end) as ed, --->
count(case
when type='2' then type
when type='3' then type
when type='12' then type
end) as OE,
count(case
when type='4' then type
end) as RC,
count(case
when type='5' then type
end) as car,
count(case
when type='6' then type
when type='13' then type
end) as pic,
count(case
when type='7' then type
end) as led,
0 as run,
0 as r1,
0 as r2,
0 as r3,
0 as r4,
0 as r5,
u.goal as goalid,
u.objective as objectiveid,
p.program as goal,
o.objective as objective, u.year2
from

newspaper as n,
useractivities as u,
program as p,
objectives as o,
surveyPub as a,
contact as c
where p.progNum NOT in (5,6) and
p.prognum=u.goal
and u.userid=c.userid
and u.year2=p.year2
and u.year2=o.year2
and u.year2=n.year2
and o.id=u.objective
and n.userid=u.userid
and n.activity=u.activity
and u.year2=a.year2
and u.userid=a.userid
and u.activity=a.activity
and a.month2=n.month2
and (o.del is null or o.del !=1)
and (u.del is null OR u.del != 'Y')
and u.strategy=6
and u.year2=#session.fy# <cfinclude template="report_filter.cfm">
group by u.goal, u.objective, p.program, o.objective, u.year2
union
select
0 as NS,
<!--- 0 as ed, --->
0 as OE,
0 as RC,
0 as car,
0 as pic,
0 as led,
count(case
when run='1' then run
end) as ran,
0 as r1,
0 as r2,
0 as r3,
0 as r4,
0 as r5,
u.goal as goalid,
u.objective as objectiveid,
p.program as goal,
o.objective as objective, u.year2
from
radio as n,
useractivities as u,
program as p,
objectives as o,
surveyPub as a,
contact as c
where p.progNum NOT in (5,6) and
p.prognum=u.goal
and u.userid=c.userid
and u.year2=p.year2
and u.year2=o.year2
and u.year2=n.year2
and o.id=u.objective
and n.userid=u.userid
and n.activity=u.activity
and u.year2=a.year2
and u.userid=a.userid
and u.activity=a.activity
and a.month2=n.month2
and (o.del is null or o.del !=1)
and (u.del is null OR u.del != 'Y')
and u.strategy=6
and u.year2=#session.fy# <cfinclude template="report_filter.cfm">
group by u.goal, u.objective, p.program, o.objective, u.year2
union

select
0 as NS,
<!--- 0 as ed, --->
0 as OE,
0 as RC,
0 as car,
0 as pic,
0 as led,
0 as ran,
count(case
when recruit1='1' then 1
end) as r1,
count(case
when recruit2='1' then 1
end) as r2,
count(case
when recruit3='1' then 1
end) as r3,
count(case
when recruit4='1' then 1
end) as r4,
count(case
when recruit5='1' then 1
end) as r5,
u.goal as goalid,
u.objective as objectiveid,
p.program as goal,
o.objective as objective, u.year2
from
earnedmedia as n,
useractivities as u,
program as p,
objectives as o,
surveyPub as a,
contact as c
where p.progNum NOT in (5,6) and
p.prognum=u.goal
and u.userid=c.userid
and u.year2=p.year2
and u.year2=o.year2
and u.year2=n.year2
and o.id=u.objective
and n.userid=u.userid
and n.activity=u.activity
and u.year2=a.year2
and u.userid=a.userid
and u.activity=a.activity
and a.month2=n.month2
and (o.del is null or o.del !=1)
and (u.del is null OR u.del != 'Y')
and u.strategy=6
and u.year2=#session.fy# <cfinclude template="report_filter.cfm">
group by u.goal, u.objective, p.program, o.objective, u.year2

union

select
count(case
when type='1' then type
when type='10' then type
when type='11' then type
end) as NS,
<!--- count(case
when type='2' then type
end) as ed, --->
count(case
when type='2' then type
when type='3' then type
when type='12' then type
end) as OE,
count(case
when type='4' then type
end) as RC,
count(case
when type='5' then type
end) as car,
count(case
when type='6' then type
when type='13' then type
end) as pic,
count(case
when type='7' then type
end) as led,
0 as run,
0 as r1,
0 as r2,
0 as r3,
0 as r4,
0 as r5,
u.goal as goalid,
u.objective as objectiveid,
p.program as goal,
o.objective as objective, u.year2
from

newspaper as n,
useractivities as u,
program as p,
objectives as o,
Cessation as a,
contact as c
where p.progNum NOT in (5,6) and
p.prognum=u.goal
and u.userid=c.userid
and u.year2=p.year2
and u.year2=o.year2
and u.year2=n.year2
and o.id=u.objective
and n.userid=u.userid
and n.activity=u.activity
and u.year2=a.year2
and u.userid=a.userid
and u.activity=a.activity
and a.month2=n.month2
and (o.del is null or o.del !=1)
and (u.del is null OR u.del != 'Y')
and u.strategy=7
and u.year2=#session.fy# <cfinclude template="report_filter.cfm">
group by u.goal, u.objective, p.program, o.objective, u.year2
union
select
0 as NS,
<!--- 0 as ed, --->
0 as OE,
0 as RC,
0 as car,
0 as pic,
0 as led,
count(case
when run='1' then run
end) as ran,
0 as r1,
0 as r2,
0 as r3,
0 as r4,
0 as r5,
u.goal as goalid,
u.objective as objectiveid,
p.program as goal,
o.objective as objective, u.year2
from
radio as n,
useractivities as u,
program as p,
objectives as o,
Cessation as a,
contact as c
where p.progNum NOT in (5,6) and
p.prognum=u.goal
and u.userid=c.userid
and u.year2=p.year2
and u.year2=o.year2
and u.year2=n.year2
and o.id=u.objective
and n.userid=u.userid
and n.activity=u.activity
and u.year2=a.year2
and u.userid=a.userid
and u.activity=a.activity
and a.month2=n.month2
and (o.del is null or o.del !=1)
and (u.del is null OR u.del != 'Y')
and u.strategy=7
and u.year2=#session.fy# <cfinclude template="report_filter.cfm">
group by u.goal, u.objective, p.program, o.objective, u.year2
union

select
0 as NS,
<!--- 0 as ed, --->
0 as OE,
0 as RC,
0 as car,
0 as pic,
0 as led,
0 as ran,
count(case
when recruit1='1' then 1
end) as r1,
count(case
when recruit2='1' then 1
end) as r2,
count(case
when recruit3='1' then 1
end) as r3,
count(case
when recruit4='1' then 1
end) as r4,
count(case
when recruit5='1' then 1
end) as r5,
u.goal as goalid,
u.objective as objectiveid,
p.program as goal,
o.objective as objective, u.year2
from
earnedmedia as n,
useractivities as u,
program as p,
objectives as o,
Cessation as a,
contact as c
where p.progNum NOT in (5,6) and
p.prognum=u.goal
and u.userid=c.userid
and u.year2=p.year2
and u.year2=o.year2
and u.year2=n.year2
and o.id=u.objective
and n.userid=u.userid
and n.activity=u.activity
and u.year2=a.year2
and u.userid=a.userid
and u.activity=a.activity
and a.month2=n.month2
and (o.del is null or o.del !=1)
and (u.del is null OR u.del != 'Y')
and u.strategy=7
and u.year2=#session.fy# <cfinclude template="report_filter.cfm">
group by u.goal, u.objective, p.program, o.objective, u.year2

union

select
count(case
when type='1' then type
when type='10' then type
when type='11' then type
end) as NS,
<!--- count(case
when type='2' then type
end) as ed, --->
count(case
when type='2' then type
when type='3' then type
when type='12' then type
end) as OE,
count(case
when type='4' then type
end) as RC,
count(case
when type='5' then type
end) as car,
count(case
when type='6' then type
when type='13' then type
end) as pic,
count(case
when type='7' then type
end) as led,
0 as run,
0 as r1,
0 as r2,
0 as r3,
0 as r4,
0 as r5,
u.goal as goalid,
u.objective as objectiveid,
p.program as goal,
o.objective as objective, u.year2
from

newspaper as n,
useractivities as u,
program as p,
objectives as o,
Advoc as a,
contact as c
where p.progNum NOT in (5,6) and
p.prognum=u.goal
and u.userid=c.userid
and u.year2=p.year2
and u.year2=o.year2
and u.year2=n.year2
and o.id=u.objective
and n.userid=u.userid
and n.activity=u.activity
and u.year2=a.year2
and u.userid=a.userid
and u.activity=a.activity
and a.month2=n.month2
and (o.del is null or o.del !=1)
and (u.del is null OR u.del != 'Y')
and u.strategy in (8,9)
and u.year2=#session.fy# <cfinclude template="report_filter.cfm">
group by u.goal, u.objective, p.program, o.objective, u.year2
union
select
0 as NS,
<!--- 0 as ed, --->
0 as OE,
0 as RC,
0 as car,
0 as pic,
0 as led,
count(case
when run='1' then run
end) as ran,
0 as r1,
0 as r2,
0 as r3,
0 as r4,
0 as r5,
u.goal as goalid,
u.objective as objectiveid,
p.program as goal,
o.objective as objective, u.year2
from
radio as n,
useractivities as u,
program as p,
objectives as o,
Advoc as a,
contact as c
where p.progNum NOT in (5,6) and
p.prognum=u.goal
and u.userid=c.userid
and u.year2=p.year2
and u.year2=o.year2
and u.year2=n.year2
and o.id=u.objective
and n.userid=u.userid
and n.activity=u.activity
and u.year2=a.year2
and u.userid=a.userid
and u.activity=a.activity
and a.month2=n.month2
and (o.del is null or o.del !=1)
and (u.del is null OR u.del != 'Y')
and u.strategy in (8,9)
and u.year2=#session.fy# <cfinclude template="report_filter.cfm">
group by u.goal, u.objective, p.program, o.objective, u.year2
union

select
0 as NS,
<!--- 0 as ed, --->
0 as OE,
0 as RC,
0 as car,
0 as pic,
0 as led,
0 as ran,
count(case
when recruit1='1' then 1
end) as r1,
count(case
when recruit2='1' then 1
end) as r2,
count(case
when recruit3='1' then 1
end) as r3,
count(case
when recruit4='1' then 1
end) as r4,
count(case
when recruit5='1' then 1
end) as r5,
u.goal as goalid,
u.objective as objectiveid,
p.program as goal,
o.objective as objective, u.year2
from
earnedmedia as n,
useractivities as u,
program as p,
objectives as o,
Advoc as a,
contact as c
where p.progNum NOT in (5,6) and
p.prognum=u.goal
and u.userid=c.userid
and u.year2=p.year2
and u.year2=o.year2
and u.year2=n.year2
and o.id=u.objective
and n.userid=u.userid
and n.activity=u.activity
and u.year2=a.year2
and u.userid=a.userid
and u.activity=a.activity
and a.month2=n.month2
and (o.del is null or o.del !=1)
and (u.del is null OR u.del != 'Y')
and u.strategy in (8,9)
and u.year2=#session.fy# <cfinclude template="report_filter.cfm">
group by u.goal, u.objective, p.program, o.objective, u.year2

order by 15
	
</cfquery>



