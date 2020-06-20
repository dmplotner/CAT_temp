<table class="boxy" border=".1" width=800 cellpadding=10>
<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qdistrict_ONLY">
	SELECT DISTINCT nd.district_id, nd.district_name
FROM         collaborators AS c INNER JOIN
                      nysed_district AS nd ON c.district = nd.district_id
WHERE     (c.year2 = '#session.fy#') AND (c.userid = '#session.userid#')
	  and (c.del is null or c.del !=1)
</cfquery>
<cfparam name="form.Q1_1" default="0">
<cfparam name="form.Q1_2" default="0">
<cfparam name="form.Q1_3" default="0">
<cfparam name="form.Q1_4" default="0">
<cfparam name="form.Q1_5" default="0">
<cfparam name="form.Q1_6" default="0">
<cfparam name="form.Q1_7" default="0">
<cfparam name="form.Q1_8" default="0">
<cfparam name="form.Q1_9" default="0">
<cfparam name="form.Q1_10" default="0">
<cfparam name="form.Q1_11" default="0">
<cfparam name="form.Q1_12" default="0">

<cfparam name="form.Q2_9" default="0">
<cfparam name="form.Q2_10" default="0">
<cfparam name="form.Q2_11" default="0">
<cfparam name="form.Q2_12" default="0">
<cfparam name="form.Q2_13" default="0">
<cfparam name="form.Q2_14" default="0">
<cfparam name="form.Q2_15" default="0">
<cfparam name="form.Q2_16" default="0">
<cfparam name="form.Q2_17" default="0">
<cfparam name="form.Q2_18" default="0">
<cfparam name="form.Q2_19" default="0">

<cfparam name="form.Q3_20" default="0">
<cfparam name="form.Q3_21" default="0">
<cfparam name="form.Q3_22" default="0">
<cfparam name="form.Q3_23" default="0">
<cfparam name="form.Q3_24" default="0">

<cfparam name="form.Q4_25" default="0">
<cfparam name="form.Q4_26" default="0">
<cfparam name="form.Q4_27" default="0">
<cfparam name="form.Q4_28" default="0">
<cfparam name="form.Q4_29" default="0">
<cfparam name="form.Q4_30" default="0">
<cfparam name="form.Q4_31" default="0">
<cfparam name="form.Q4_32" default="0">
<cfparam name="form.Q4_33" default="0">
<cfparam name="form.Q4_34" default="0">
<cfparam name="form.Q4_35" default="0">

<cfparam name="form.Q5_36" default="0">
<cfparam name="form.Q5_37" default="0">
<cfparam name="form.Q5_38" default="0">

<cfparam name="form.Q6_39" default="0">
<cfparam name="form.Q6_40" default="0">
<cfparam name="form.Q6_41" default="0">

<cfparam name="form.Q7_42" default="0">
<cfparam name="form.Q7_43" default="0">
<cfparam name="form.Q7_44" default="0">
<cfparam name="form.Q7_45" default="0">
<cfparam name="form.Q7_46" default="0">
<cfparam name="form.Q7_47" default="0">


<!--- 
<cfif isdefined("form.dd") and #form.dd# is not ''>
<cfloop index="s" list="#form.del#">
         <CFQUERY NAME="getbline" 
		 DATASOURCE="#application.DataSource#"
         USERNAME="#application.db_username#"
         PASSWORD="#application.db_password#">
	   delete
	   from sp_baseline
	   where DISTRICT = '#s#' 
</CFQUERY>
</cfloop>

</cfif>
<cfif isdefined("form.add_collaborator") and #form.add_collaborator# is not ''>

<cfif isdefined("form.q")>


<cfoutput><cfloop index="x" list="#form.q#">
<cfset frmval='form.' & #x#> 
         <CFQUERY NAME="getbline" 
		 DATASOURCE="#application.DataSource#"
         USERNAME="#application.db_username#"
         PASSWORD="#application.db_password#">
	   select *
	   from sp_baseline
	   where district = '#form.sname1#' and variable = '#x#'
</CFQUERY>
<cfif #evaluate(frmval)# is 1>
<cfif getbline.recordcount is 0>
 <CFQUERY NAME="spbas" 
		 DATASOURCE="#application.DataSource#"
         USERNAME="#application.db_username#"
         PASSWORD="#application.db_password#">
	 insert into sp_baseline (userid,district,year2,entdt,variable,value)
	 values ('#session.userid#','#form.sname1#','#session.fy#',#now()#,'#x#','#evaluate(frmval)#')
</CFQUERY>
<cfelse> 

<CFQUERY NAME="spbas" 
		 DATASOURCE="#application.DataSource#"
         USERNAME="#application.db_username#"
         PASSWORD="#application.db_password#">
	update sp_baseline set 
	entdt = #now()#,
	value =  '#evaluate(frmval)#'
	where district = '#form.sname1#' and year2 = '#session.fy#' and variable = '#x#'
</CFQUERY>
</cfif><cfset clear = 1>
</cfif>


</cfloop>
</cfoutput></cfif>
</cfif> --->

<cfif not isdefined("form.sname1")>
<cfif isdefined("url.id") and #url.id# is not ''>
         <CFQUERY NAME="getblink" 
		 DATASOURCE="#application.DataSource#"
         USERNAME="#application.db_username#"
         PASSWORD="#application.db_password#">
	   select *
	   from sp_baseline
	   where DISTRICT = '#url.id#' 
</CFQUERY>
<cfset form.sname1 = #getblink.DISTRICT#>
</cfif>
</cfif>

<!--- <cfform name="igiveup33" method="post" action="collaborators.cfm?#session.urltoken#"> --->
<tr><td><strong>District</td><td>

<!--- <cfif  isDefined("form.sname1")>
		<cfselect name="sname1" query="Qdistrict_ONLY" value="district_id" display="district_name" queryPosition="below" selected="#form.sname1#">

	</cfselect>
	<cfelseif isdefined("qselecteditem.district")>
			<cfselect name="sname1" query="Qdistrict_ONLY" value="district_id" display="district_name" queryPosition="below" selected="#qselecteditem.district#">
		
	</cfselect>		
	<cfelse>
		<cfselect name="sname1" query="Qdistrict_ONLY" value="district_id" display="district_name" queryPosition="below">
		<option value="999"><strong>Please select a District</strong></option>
	</cfselect>
</cfif> --->

<cfif isDefined("form.school") and form.school NEQ "999">
<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qschool_ONLY">
	SELECT DISTINCT institutionname, bedscode
FROM         
                      nysed_school 
WHERE    bedscode = '#form.school#'
	
</cfquery>
<cfelseif isDefined("qselectedItem") and qselectedItem.school NEQ "999">
<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qschool_ONLY">
	SELECT DISTINCT institutionname, bedscode
FROM         
                      nysed_school 
WHERE    bedscode = '#qselectedItem.school#'
	
</cfquery>

</cfif> 


<cfoutput>

<cfif isDefined("Qschool_ONLY.institutionname")>	
	<input type="hidden" name="sname1" value="#Qschool_ONLY.bedscode#">#Qschool_ONLY.institutionname#
<cfelseif  isDefined("form.sname1")>
	<cfquery dbtype="query" name="subQdistrict_ONLY">
	select * from Qdistrict_ONLY
	where district_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sname1#">
	</cfquery>
		<input type="hidden" name="sname1" value="#form.sname1#">#subQdistrict_ONLY.district_Name#

<cfelseif isdefined("qselecteditem.district")>
	<cfquery dbtype="query" name="subQdistrict_ONLY">
	select * from Qdistrict_ONLY
	where district_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#qselecteditem.district#">
	</cfquery>
			<input type="hidden" name="sname1" value="#qselecteditem.district#">#subQdistrict_ONLY.district_Name#
<cfelse>
	<input type="hidden" name="sname1" value="">
</cfif>		
</cfoutput>

</td>
</tr>
	<tr><th>Milestones Achieved at Baseline</th><th></th></tr>


<cfoutput>
<cfloop query="Qcheckboxes1">
<cfif isdefined("form.sname1") or isDefined("qselecteditem.district") and (not isdefined("add_collaborator"))>

         <CFQUERY NAME="getbline" 
		 DATASOURCE="#application.DataSource#"
         USERNAME="#application.db_username#"
         PASSWORD="#application.db_password#">
	   select *
	   from sp_baseline
	   where DISTRICT = <cfif isdefined("form.sname1")>'#form.sname1#' <cfelseif qselectedItem.school NEQ "999">'#qselecteditem.school#'<cfelse>'#qselecteditem.district#'</cfif>
	   and variable = '#q#'
</CFQUERY>
</cfif>

<input type="hidden" name="q" value="#q#">

<tr>
<td align="center"><input type="checkbox" name="#Q#" value="1" <cfif isdefined("getbline.value") and #getbline.value# EQ 1 and form.recordSeq NEQ -1>checked</cfif> 
></td>
<td valign="top">#descr#</td>
</tr>
</cfloop>

</tr>
<!--- <tr><Td colspan=5>	  <input type="submit" name="addpolicy" value="Add" class="AddButton" >
</td></tr> --->
</cfoutput>
<cfinclude template="sp_sec2.cfm">
<tr>
		<td colspan="2" align="center">

 <!---          <input type="submit" name="add_collaborator" value="Add/Update" class="AddButton" > --->
		
</td></tr>

<!--- </cfform> --->
</table>

<!--- 
<CFQUERY NAME="getdist" 
		 DATASOURCE="#application.DataSource#"
         USERNAME="#application.db_username#"
         PASSWORD="#application.db_password#">
select distinct institutionname,s.district from nysed_school n inner join sp_baseline s
on n.district = s.district
where userid = '#session.userid#' and year2 = '#session.fy#'
</cfquery>
<cfif getdist.recordcount is not 0>
<!--- <cfform name="skool2" action="" method="post"> --->
<table class="boxy" border=".1" width=800 cellpadding=10>
<th align="left">District</th><th align="left">Delete</th>
<cfoutput query="getdist">
<tr><td><a href="sp_baseline.cfm?id=#district#">#getdist.institutionname#</a></td>
<td><input name="del" type="Checkbox" value="#district#"></td></td></tr></cfoutput>
<tr>
	<td colspan="2" align="right"><input type="Submit" name="dd" value="Delete" class="DelButton"></td>
</tr>
</table>
<!--- </cfform> --->
</cfif>
 --->
