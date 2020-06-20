		
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
</style>
 <SCRIPT LANGUAGE="JavaScript">
 function countit(what){

//Character count script- by javascriptkit.com
//Visit JavaScript Kit (http://javascriptkit.com) for script
//Credit must stay intact for use

formcontent=what.form.outsumm.value
what.form.outsummcount.value=formcontent.length

}
</script>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>CAT</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body>

		<cfif isdefined("mo")>
<cfswitch expression="#mo#">
<cfcase value=1>
<cfset session.mon = "January">
<cfset session.monum = 1>
</cfcase>
<cfcase value=2>
<cfset session.mon = "February">
<cfset session.monum = 2>
</cfcase>
<cfcase value=3>
<cfset session.mon = "March">
<cfset session.monum = 3>
</cfcase>
<cfcase value=4>
<cfset session.mon = "April">
<cfset session.monum = 4>
</cfcase>
<cfcase value=5>
<cfset session.mon = "May">
<cfset session.monum = 5>
</cfcase>
<cfcase value=6>
<cfset session.mon = "June">
<cfset session.monum = 6>
</cfcase>
<cfcase value=7>
<cfset session.mon = "July">
<cfset session.monum = 7>
</cfcase>
<cfcase value=8>
<cfset session.mon = "August">
<cfset session.monum = 8>
</cfcase>
<cfcase value=9>
<cfset session.mon = "September">
<cfset session.monum = 9>
</cfcase>
<cfcase value=10>
<cfset session.mon = "October">
<cfset session.monum = 10>
</cfcase>
<cfcase value=11>
<cfset session.mon = "November">
<cfset session.monum = 11>
</cfcase>
<cfcase value=12>
<cfset session.mon = "December">
<cfset session.monum = 12>
</cfcase>
</cfswitch></cfif>
<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qcollab_school">
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
d.district_name,
s.institutionname
  from collaborators as c 
left outer join  orgtype as o on o.indorg=c.indorg and o.num = c.type and o.year2=c.year2 
left outer join nysed_district as d on d.district_id = c.district
left outer join nysed_school as s on s.bedscode=c.school
  where userid = '#session.userid#' and (c.year2 >=1904)
  and (c.del is null or c.del !=1)
  and c.district is not null
and isNull(c.sodistrict,0)=0
order by 17, 18 

</cfquery>
 <cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qmos">
	select rank from months where mon_num = #session.monum# and year2 = #session.fy#
	</cfquery>

 <cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qschool">
	select bedscode,institutionName, district_name + ': ' + institutionname as name
	from nysed_school ns inner join nysed_district nd on ns.district = nd.district_id
	where <!--- district_code in (#valuelist(Qcollab_district.district)#)	
	and ---> bedscode in (<cfif Qcollab_school.recordcount GT 0> #quotedvaluelist(Qcollab_school.school)#<cfelse>'0'</cfif>)
		and ns.district not in (select district from sp_monthly sp inner join months m on sp.mo = m.mon_num and sp.year2 = m.year2 where variable = 'q1_1' and value = 1 and rank <= #qmos.rank# )
		and ns.district not in (select district from sp_monthly sp inner join months m on sp.mo = m.mon_num and sp.year2 = m.year2 where variable = 'q1_1' and value = 1 and sp.year2 < #session.fy# )
		and ns.district not in (select district from sp_baseline where variable = 'q1_1' and value = 1)
	order by 2
</cfquery>
<cfoutput query="Qschool">
<cfset frmval='form.' & #bedscode#> 
<cfparam name = "#frmval#" default="0">
</cfoutput>
<cfif isdefined("return") and #return# is not ''>
  <CFQUERY NAME="getmon" 
		 DATASOURCE="#application.DataSource#"
         USERNAME="#application.db_username#"
         PASSWORD="#application.db_password#">
	   select *
	   from sp_mon3
	   where userid = '#session.userid#' and mon = #session.monum# and year2 = #session.fy#
</CFQUERY>	
<cfif getmon.recordcount is 0>

 <CFQUERY NAME="insmon" 
		 DATASOURCE="#application.DataSource#"
         USERNAME="#application.db_username#"
         PASSWORD="#application.db_password#">
	 insert into sp_mon3 (userid,entdt,mon,year2,outsumm)
	 values ('#session.userid#',#now()#,'#session.monum#','#session.fy#','#outsumm#')
</CFQUERY>
<cfelse> 

<CFQUERY NAME="spdir" 
		 DATASOURCE="#application.DataSource#"
         USERNAME="#application.db_username#"
         PASSWORD="#application.db_password#">
	update sp_mon3 set 
	entdt = #now()#,
	outsumm =  '#outsumm#'
	where userid = '#session.userid#' and mon = #session.monum# and year2 = #session.fy#
</CFQUERY>

</cfif>

<cfif isdefined("form.bedscode")>
<cfloop index="x" list="#form.bedscode#">
<cfset frmval='form.' & #x#> 
         <CFQUERY NAME="getbline" 
		 DATASOURCE="#application.DataSource#"
         USERNAME="#application.db_username#"
         PASSWORD="#application.db_password#">
	   select *
	   from sp_mon2
	   where bedscode = '#x#' and mon = #session.monum# and year2 = #session.fy#
</CFQUERY>	

<cfif getbline.recordcount is 0>

 <CFQUERY NAME="spdir" 
		 DATASOURCE="#application.DataSource#"
         USERNAME="#application.db_username#"
         PASSWORD="#application.db_password#">
	 insert into sp_mon2 (userid,bedscode,mon,year2,entdt,dircon)
	 values ('#session.userid#','#x#','#session.monum#','#session.fy#',#now()#,#evaluate(frmval)#)
</CFQUERY>
<cfelse> 

<CFQUERY NAME="spdir" 
		 DATASOURCE="#application.DataSource#"
         USERNAME="#application.db_username#"
         PASSWORD="#application.db_password#">
	update sp_mon2 set 
	entdt = #now()#,
	dircon =  #evaluate(frmval)#
	where bedscode = '#x#' and year2 = '#session.fy#' and mon = #session.monum#
</CFQUERY>

</cfif>
</cfloop>

</cfif>
<cfif #return# is 'Save and Return to Monthly Reporting'>
<cflocation url="monthrep.cfm">
</cfif>
</cfif>
   <CFQUERY NAME="mon" 
		 DATASOURCE="#application.DataSource#"
         USERNAME="#application.db_username#"
         PASSWORD="#application.db_password#">
	   select *
	   from sp_mon3
	   where userid = '#session.userid#' and mon = #session.monum# and year2 = '#session.fy#'
</CFQUERY>	

<cfinclude template="CATstruct.cfm">

		<table class="box2" width=675>
      <tr><td colspan="2"><br><h3>Outreach to New Schools Monthly Report for <cfoutput>#session.mon#</cfoutput>
		</td></tr>
<!---		<tr><td><strong>SMART Outcome 2:</strong><br>By March 31, 2012, <strong>25%</strong> of schools in the catchment area will have been directly contacted to initiate process of adopting a comprehensive school health policy for year 2 of the contract.</td></tr>
	--->	<tr><td><br>Schools appear in this table if they have been entered in your ‘Target Schools and Districts’ list but you have not yet indicated that you have administrative commitment for the district in which they are located.</td></tr>
</table>
<p></p>
<cfform name="dircon" method="post" action="">
<table width=675 border=".1" cellpadding=10 cellspacing="2" class="boxy">
<cfif qschool.recordcount is not 0>
<tr><th>School Name</th><th>Direct Contact This Month</th></tr></cfif>
<cfloop query="Qschool">
         <CFQUERY NAME="getdir" 
		 DATASOURCE="#application.DataSource#"
         USERNAME="#application.db_username#"
         PASSWORD="#application.db_password#">
	   select dircon
	   from sp_mon2
	   where bedscode = '#bedscode#' and mon = #session.monum#
</CFQUERY>
<cfoutput>
<input type="hidden" name="bedscode" value="#bedscode#">
<tr><td>#qschool.name# #qschool.bedscode#</td><td align="center" width="25%"><input type="checkbox" name="#bedscode#" value="1" <cfif isdefined("getdir.dircon") and #getdir.dircon# EQ 1>checked</cfif>></td>
</tr></cfoutput>
</cfloop>
	<th align="left" height=30 valign="bottom" colspan=2><h6>Summary of outreach activities this month:</th>
			  <tr>
			  <cfoutput>
	  	<td width=675 colspan= 2><textarea name="outsumm" cols=145 rows=14 onBlur="countit(this)"><cfif isdefined("mon.outsumm")>#mon.outsumm#</cfif></textarea>
</td></tr>
	  <tr><td colspan=2><input type="button" value="Check Spelling" onClick="spell('document.dircon.outsummcount.value', 'document.dircon.outsummcount.value')">
</td></tr>
	      <tr>
      <td width="100%" valign="bottom" colspan=2><div align="right" valign="bottom">This text field has a max of 1950 characters. Characters entered: <cfoutput><input type="text" <cfif isdefined("mon.outsumm")>value="#len(mon.outsumm)#"</cfif> name="outsummcount" size="4" style="border:0;" disabled></cfoutput></td>
    </tr>

</cfoutput>

</table>
<p></p>
<p></p>
<input type="submit" name="return" value="Save" class="AddButton">
<p></p>
<input type="submit" name="return" value="Save and Return to Monthly Reporting" class="AddButton">
</cfform>
<!---<cfinclude template="sp_sec2.cfm">--->



</body>
</html>