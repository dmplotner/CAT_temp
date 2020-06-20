
<!---
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="selbase">
select p.progNum, o.objective, o.id
from  program as p, objectives as o, userActivities as u
where
 p.progNum = o.progNum
 and u.goal=p.progNum
 and  o.id = u.objective
 and userid = '#session.userid#' and activity='#url.act#'
 and u.year2=#session.rptyr#
 and u.year2=o.year2
 and u.year2=p.year2
</cfquery>

<cfquery datasource="#Application.DataSource#"  		 
	password="#Application.db_password#"   		
	username="#Application.db_username#" name="objective">
   select rtrim(cast(p.progNum as char)) + ': ' + p.program as program, p.progNum, o.objective, o.id, rank
   from program as p, objectives as o
   where p.progNum = o.progNum
   and p.progNum= '#form.programVal#'
   and o.ID like '#form.objVal#%'
   and p.year2=#session.rptyr#
   and p.year2=o.year2
   order by 3
</cfquery>

<cfquery datasource="#Application.DataSource#"  		 
	password="#Application.db_password#"   		
	username="#Application.db_username#" name="StrategyQ">
	
	select strategy, strategy_Num 
	from strategy 
	where year2=#session.rptyr#
	order by 2
	
</cfquery> --->
<form>
<table border=".5" width="100%" cellspacing="0">
<caption>Focus Area <cfoutput>#focusareaNum#: #QFocusAreaN.descr#</cfoutput></caption>

<tr>
<th colspan="4" align="left">Strategy Description</th>
</tr>
<tr>

<td>Strategy Name</td>
<td colspan="3"><cfoutput>#QGenDescrip.activity#</cfoutput></td>
</tr>

<tr>
<td width="20%">Goal</td>
<td width="17%"><cfoutput>#QGenDescrip.goal#</cfoutput></td>
<td width="13%">Objective</td>
<td><cfoutput>#QGenDescrip.objdesc#</cfoutput></td>
</tr>



<!--- Date module --->
<cfset startdate2 = QGenDescrip.startdate>
<cfset enddate2 = QGenDescrip.enddate>
	
	<cfquery datasource="#application.DataSource#"  		
			 
			password="#application.db_password#"   		
			username="#application.db_username#" name="latestDate">
			
		select  revstart, revend
			from #tablename# as a
			where userid = '#session.userid#'
			and activity = '#QGenDescrip.activity#'
			and year2 = #session.fy#
			and month2=(select c.mon from monthS as c where c.rank =
			(select max(d.rank) from monthS as d 
			where d.mon = a.month2 
			and A.revstart is not null 
			AND  A.userid = '#session.userid#'
			and A.activity = '#QGenDescrip.activity#'
			and A.year2 = #session.fy#))
	</cfquery>
	<cfif latestdate.recordcount GT 0>
	<cfset startdate2 = latestDate.revstart>
	<cfset enddate2 = latestDate.revEnd>
	
	</cfif>

<tr>
<td>Start Date (latest)</td>
<td><cfoutput>#dateformat(startdate2,'m/d/yyyy')#</cfoutput></td>
<td>End Date</td>
<td><cfoutput>#dateformat(enddate2,'m/d/yyyy')#</cfoutput></td>
</tr>
