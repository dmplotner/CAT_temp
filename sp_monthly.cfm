		
	<style>
.box {
	font-family: verdana, helvetica, sans-serif;
	font-size: 11px;
	border: solid 1px #CCCC99;
	list-style:inherit;
	border-collapse: collapse; 
}
.boxy {
	font-family: verdana, helvetica, sans-serif;
	font-size: 11px;
	list-style:inheritborder-color : #498F49;
}
.box2 {
	font-family: verdana, helvetica, sans-serif;
	font-size: 11px;
	border: none;
	list-style:inherit;
	padding: 0px;
	spacing: 0px;
}
.box3 td {
	border-collapse: collapse; 
}
</style>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>CAT</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body>

		<cfif isdefined("mo")>
        <cfif session.fy lte 2012>
<cfswitch expression="#mo#">
<cfcase value=1>
<cfset session.mon = "January">
<cfset session.monum = 1>
<cfset session.rank = 7>
</cfcase>
<cfcase value=2>
<cfset session.mon = "February">
<cfset session.monum = 2>
<cfset session.rank = 8>
</cfcase>
<cfcase value=3>
<cfset session.mon = "March">
<cfset session.monum = 3>
<cfset session.rank = 9>
</cfcase>
<cfcase value=4>
<cfset session.mon = "April">
<cfset session.monum = 4>
<cfset session.rank = 10>
</cfcase>
<cfcase value=5>
<cfset session.mon = "May">
<cfset session.monum = 5>
<cfset session.rank = 11>
</cfcase>
<cfcase value=6>
<cfset session.mon = "June">
<cfset session.monum = 6>
<cfset session.rank = 12>
</cfcase>
<cfcase value=7>
<cfset session.mon = "July">
<cfset session.monum = 7>
<cfset session.rank = 1>
</cfcase>
<cfcase value=8>
<cfset session.mon = "August">
<cfset session.monum = 8>
<cfset session.rank = 2>
</cfcase>
<cfcase value=9>
<cfset session.mon = "September">
<cfset session.monum = 9>
<cfset session.rank = 3>
</cfcase>
<cfcase value=10>
<cfset session.mon = "October">
<cfset session.monum = 10>
<cfset session.rank = 4>
</cfcase>
<cfcase value=11>
<cfset session.mon = "November">
<cfset session.monum = 11>
<cfset session.rank = 5>
</cfcase>
<cfcase value=12>
<cfset session.mon = "December">
<cfset session.monum = 12>
<cfset session.rank = 6>
</cfcase>
</cfswitch>
<cfelse>

<cfswitch expression="#mo#">
<!--- <cfcase value=10>
<cfset session.mon = "January">
<cfset session.monum = 1>
<cfset session.rank = 7>
</cfcase>
<cfcase value=11>
<cfset session.mon = "February">
<cfset session.monum = 2>
<cfset session.rank = 8>
</cfcase>
<cfcase value=12>
<cfset session.mon = "March">
<cfset session.monum = 3>
<cfset session.rank = 9>
</cfcase>
<cfcase value=1>
<cfset session.mon = "April">
<cfset session.monum = 4>
<cfset session.rank = 10>
</cfcase>
<cfcase value=2>
<cfset session.mon = "May">
<cfset session.monum = 5>
<cfset session.rank = 11>
</cfcase>
<cfcase value=3>
<cfset session.mon = "June">
<cfset session.monum = 6>
<cfset session.rank = 12>
</cfcase>
<cfcase value=4>
<cfset session.mon = "July">
<cfset session.monum = 7>
<cfset session.rank = 1>
</cfcase>
<cfcase value=5>
<cfset session.mon = "August">
<cfset session.monum = 8>
<cfset session.rank = 2>
</cfcase>
<cfcase value=6>
<cfset session.mon = "September">
<cfset session.monum = 9>
<cfset session.rank = 3>
</cfcase>
<cfcase value=7>
<cfset session.mon = "October">
<cfset session.monum = 10>
<cfset session.rank = 4>
</cfcase>
<cfcase value=8>
<cfset session.mon = "November">
<cfset session.monum = 11>
<cfset session.rank = 5>
</cfcase>
<cfcase value=9>
<cfset session.mon = "December">
<cfset session.monum = 12>
<cfset session.rank = 6> --->

<cfcase value=10>
<cfset session.mon = "October">
<cfset session.monum = 10>
<cfset session.rank = 7>
</cfcase>
<cfcase value=11>
<cfset session.mon = "November">
<cfset session.monum = 11>
<cfset session.rank = 8>
</cfcase>
<cfcase value=12>
<cfset session.mon = "December">
<cfset session.monum = 12>
<cfset session.rank = 9>
</cfcase>
<cfcase value=1>
<cfset session.mon = "January">
<cfset session.monum = 1>
<cfset session.rank = 10>
</cfcase>
<cfcase value=2>
<cfset session.mon = "February">
<cfset session.monum = 2>
<cfset session.rank = 11>
</cfcase>
<cfcase value=3>
<cfset session.mon = "March">
<cfset session.monum = 3>
<cfset session.rank = 12>
</cfcase>
<cfcase value=4>
<cfset session.mon = "April">
<cfset session.monum = 4>
<cfset session.rank = 1>
</cfcase>
<cfcase value=5>
<cfset session.mon = "May">
<cfset session.monum = 5>
<cfset session.rank = 2>
</cfcase>
<cfcase value=6>
<cfset session.mon = "June">
<cfset session.monum = 6>
<cfset session.rank = 3>
</cfcase>
<cfcase value=7>
<cfset session.mon = "July">
<cfset session.monum = 7>
<cfset session.rank = 4>
</cfcase>
<cfcase value=8>
<cfset session.mon = "August">
<cfset session.monum = 8>
<cfset session.rank = 5>
</cfcase>
<cfcase value=9>
<cfset session.mon = "September">
<cfset session.monum = 9>
<cfset session.rank = 6>

</cfcase>
</cfswitch></cfif></cfif>
		<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qcollab_district">
	select distinct district
	from collaborators as c
	where userid='#session.userid#'
	  and (c.del is null or c.del !=1)
	<!--- and year2=#session.fy# --->
	and  school='999'
	union
	select distinct school
	from collaborators as c
	where userid='#session.userid#'
	  and (c.del is null or c.del !=1)
	<!--- and year2=#session.fy# --->
	and  isNull(soDistrict,0)=1
	order by 1
</cfquery>
<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="dist">
	  select c.name, c.indOrg, c.traditional, o.type, c.county, 
  c.seq , c.unit, 
case when c.unit IS NULL then c.NAME else c.unit + ' ' + NAME end as unitname , 
  del, case tHCPO when 0 then 'No' when 1 then 'Yes' else '-' end as tHCPO, 
case tLevel 
	when 1 then 'Full' 
	when 2 then 'Limited' 
	when 3 then 'Maintenance'
	when 0 then 'Inactive'
	else '-' end as tLevel, 
	
	case timprovement when 1 then 'Yes' else 'No' end  as timprovement,
  c.school, c.district , isnull(c.sodistrict,0) as sodistrict, isNull(c.sfy, 0) as sfy,
d.district_name
  from collaborators as c 
left outer join  orgtype as o on o.indorg=c.indorg and o.num = c.type and o.year2=c.year2 
left outer join nysed_district as d on d.district_id = c.district
  where userid = '#session.userid#' and (c.year2 >=1904)
  and (c.del is null or c.del !=1)
  and c.district is not null
order by 17
</cfquery>
 


<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qcheckboxes1">
	
	select id, descr,q from lu_schoolCheckBox
where sect=1 and type=0
and seq <> 48 and seq <> 49 and seq <> 50 and seq <> 7 and seq <> 51
order by rank
	
</cfquery>

<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qcheckboxes2">
	select c.id, c.descr, q,c.sect, c.type, h.sect as sectid, h.descr as heading
from lu_schoolCheckBox c inner join lu_schoolheadings h
on c.sect = h.sect
where 
c.sect=2 or c.sect=3
order by c.sect,rank
	
</cfquery>
<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qcheckboxes3">
	select c.id, c.descr, q,c.sect, c.type, h.sect as sectid, h.descr as heading
from lu_schoolCheckBox c inner join lu_schoolheadings h
on c.sect = h.sect
where 
c.sect=4 or c.sect=5
order by c.sect,rank
	
</cfquery>
<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qcheckboxes4">
	select c.id, c.descr, q,c.sect, c.type, h.sect as sectid, h.descr as heading
from lu_schoolCheckBox c inner join lu_schoolheadings h
on c.sect = h.sect
where 
c.sect=6 or c.sect=7
order by c.sect,rank
	
</cfquery>
<cfinclude template="CATstruct.cfm">
<table><tr><td>
		<table class="box2" width=800 align="left">
      <tr><td colspan="2" align="left"><br><h3>District Level Policy Development Monthly Report for <cfoutput>#session.mon#</cfoutput>
		</td></tr>
		<tr><td>
        <cfif session.fy gte 2013>
        <p><br><strong>SMART Objective 1 (Physical Activity):</strong><br>  By March 31, 2013, increase by at least 2 the number of school districts that have initiated the process of assessing and developing or revising the district PE Plan for approval and submission to the State Education Department. 
        <p><strong>Alternate objective for catchment areas whose local educational network consists of 1 school district that does not maintain its policy-making authority with a Board of Education or Superintendents, but rather with a city Department of Education Chancellor (Physical Activity):</strong><br> By March 31, 2013, 50% of school buildings in which the agency is currently working will have initiated the process of implementing PE policies or strategies consistent with the school district’s  current Local School Wellness Policies that align with State Education Department Regulations and/or the city Department of Education Chancellor’s Regulations for PE. 
<p><strong>SMART Objective 2 (Physical Activity):</strong><br> By March 31, 2013, increase by at least 2 the number of school districts that have initiated the process of assessing and developing or revising a minimum of 1 PA policy as either a separate school board approved policy or integrated into the school district’s Local School Wellness Policies. <br>
<p><strong>Alternate Objective for catchment areas whose local educational network consists of 1 school district that does not maintain its policy-making authority with a Board of Education or Superintendents, but rather with a city Department of Education Chancellor (Physical Activity):</strong><br> By March 31, 2013, 50% of school buildings in which the agency is currently working will have initiated the process of implementing a minimum of 1 PA element (from the list above) of the school district’s current Local School Wellness Policies.<br>
<p><strong>SMART Objective 1 (Nutrition):</strong><br> By March 31, 2013, increase by at least 2 the number of school districts that have initiated the process of assessing and developing or revising a minimum of 2 of the 4 Required Nutrition Policy Elements, as either a separate school board approved policy or integrated into the school district’s Local School Wellness Policies. <br>
<p><strong>Alternate Objective for catchment areas whose local educational network consists of 1 school district that does not maintain its policy-making authority with a Board of Education or Superintendents, but rather with a city Department of Education Chancellor (Nutrition):</strong><br> By March 31, 2013, 50% of school buildings in which the agency is currently working will have initiated the process of implementing a minimum of 2 of the 4 Required Nutrition Policy Elements (see list above) of the school district’s current Local School Wellness Policies. In addition, you may choose to work on implementation of one or more of the Optional Nutrition Policy Elements.

        <cfelse><p><br><strong>SMART Outcome 1:</strong><br>By March 31, 2012, <strong>5-6</strong> schools selected for year 1 (year 1 = first 21 months) of the contract will have 1) a commitment from school administration to establish a healthy environment through policy change; 2) a team or committee to address the issue; 3) conducted a needs assessment (such as the School Health Index); 4) an implementation plan, including a timeline, 5) completed an on-site observation, 6) assessed existing tobacco-free policies, nutrition policies and Physical Education (P.E.) plans; and 7) reviewed and approved a comprehensive school health policy</p></cfif><br><br>
</td></tr>
</table>
</td></tr>
<cfinclude template="sp_sec1_mo.cfm">
<p></p>
<p></p>
<!---<cfinclude template="sp_sec2.cfm">--->



</body>
</html>