<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>
<cfparam name="form.sodistrict" default="0">
<cfparam name="cksodistrict" default="0">
<cfif isDefined("form.sname1") and form.sname1 EQ "" and isDefined("form.school") and form.school EQ "999">
	<cfset form.sname1=form.district>
</cfif>
<cfif form.addUser EQ "add">
<!--- <cfoutput> --->

<cfif isDefined("form.recordSeq") and form.recordSeq GTE 0>
<cfquery datasource="#application.DataSource#" 	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="checkCollab">
select isNull(sodistrict, 0) as sodistrict , tLevel, del, seq
from collaborators
where userid='#session.userid#'
and seq = #form.recordSeq#
</cfquery>
<cfif session.modality EQ 1>
<cfquery datasource="#application.DataSource#" 	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="inscheckCollab">
insert into tHCPOlog
(userid, year2, thcposeq, oldtlevel, newtlevel, del, new)
values
(<cfqueryparam cfsqltype="cf_sql_varchar" value="#session.userid#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#session.fy#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#checkCollab.seq#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#checkCollab.tLevel#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.tLevel#">,
<cfqueryparam cfsqltype="cf_sql_bit" value="0">,
<cfqueryparam cfsqltype="cf_sql_bit" value="0">)
</cfquery>

</cfif>

<cfset cksodistrict = checkCollab.sodistrict>

<cfparam name="form.sodistrict" default="0">
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="updateCollab">
	update collaborators 
	set 
	<cfif session.modality NEQ 4>
	name='#htmleditformat(form.collabName)#',
	indOrg=<cfif isDefined("form.indOrg") and session.fy LT 2007>'#form.indOrg#', <cfelse>2,</cfif>
	<cfif session.fy LT 2007 and session.fy GT 1920>traditional='#form.traditional#', </cfif>
	type='#form.collabtype#', 
	county='#form.jurisdiction#',
	<!--- year2=#session.fy#, --->
	unit= <cfif isDefined("form.newUnit") and form.newUnit NEQ "">'#form.newUnit#'<cfelseif isDefined("form.Unit") and form.Unit NEQ "">'#form.Unit#'<cfelse> NULL</cfif>,
	tHCPO=<cfif isDefined("form.tHCPO") and form.tHCPO NEQ "">#form.tHCPO#<cfelse>NULL</cfif>,
	tLevel=<cfif isDefined("form.tLevel") and form.tLevel NEQ "">#form.tLevel#<cfelse>NULL</cfif>
	<cfelse>school='#form.school#', district='#form.district#', sodistrict = #form.sodistrict#, sfy='#form.sfy#'<cfif session.fy GTE 2011>,solunch='#form.solunch#'</cfif></cfif>
	<cfif isDefined("form.timprovement")>,timprovement=#form.timprovement#</cfif>
	where userid='#session.userid#'
	and seq = #form.recordSeq#
</cfquery>
<cfset cksodistrict = form.sodistrict - cksodistrict>
<cfelse>

<cflock scope="Application" timeout="30" throwontimeout="true" type="exclusive">

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="insertCollab">
	insert into collaborators (
	<cfif session.modality NEQ 4>name, 
	indOrg, 
	<cfif session.fy LT 2007 and session.fy GT 1920>traditional,</cfif>
	type, county,
	<cfelse>school, district, sodistrict,sfy,<cfif session.fy GTE 2011>solunch,</cfif>
	</cfif> 
	userid, year2 
	<cfif (isDefined("form.unit") and form.unit NEQ "") OR (isDefined("form.newunit") and form.newunit NEQ "")>,unit</cfif>
	<cfif isDefined("form.tHCPO") and form.tHCPO NEQ "">,tHCPO</cfif>
	<cfif isDefined("form.tLevel") and form.tLevel NEQ "">,tLevel</cfif>
	<cfif isDefined("form.timprovement")>, timprovement</cfif>)
	values
	(<cfif session.modality NEQ 4>'#htmleditformat(form.collabName)#', 
	<cfif isDefined("form.indOrg")>'#form.indOrg#',<cfelse>2,</cfif>
	<cfif session.fy LT 2007 and session.fy GT 1920>'#form.traditional#',</cfif>
	'#form.collabtype#', '#form.jurisdiction#', <cfelse>'#form.school#', '#form.district#', #form.sodistrict#,#form.sfy#,<cfif session.fy GTE 2011>#form.solunch#,</cfif></cfif> 
	'#session.userid#', #session.fy# <cfif isDefined("form.newUnit") and form.newUnit NEQ "">,'#form.newUnit#'<cfelseif isDefined("form.Unit") and form.Unit NEQ "">,'#form.Unit#'</cfif>
	<cfif isDefined("form.tHCPO") and form.tHCPO NEQ "">,#form.tHCPO#</cfif>
	<cfif isDefined("form.tLevel") and form.tLevel NEQ "">,#form.tLevel#</cfif>
	<cfif isDefined("form.timprovement")>, #form.timprovement#</cfif>)
</cfquery>
<cfif session.modality EQ 1>
<cfquery datasource="#application.DataSource#" 	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="checkCollab">
select isNull(sodistrict, 0) as sodistrict , tLevel, del, seq
from collaborators
where userid='#session.userid#'
and seq = (select max (seq) from collaborators)
</cfquery>
<cfquery datasource="#application.DataSource#" 	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="checkCollab">
insert into tHCPOlog
(userid, year2, thcposeq, oldtlevel, newtlevel, del, new)
values
(<cfqueryparam cfsqltype="cf_sql_varchar" value="#session.userid#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#session.fy#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#checkCollab.seq#">,
NULL,
<cfqueryparam cfsqltype="cf_sql_integer" value="#form.tLevel#">,
<cfqueryparam cfsqltype="cf_sql_bit" value="0">,
<cfqueryparam cfsqltype="cf_sql_bit" value="1">)
</cfquery>
</cfif>
</cflock>
<cfif form.sodistrict EQ 1>
<cfset cksodistrict =1>
</cfif>
</cfif>

</cfif>

<cfif isDefined("form.del_box")>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="deleteCollab">
	Update collaborators
	set del=1
	where seq in (#form.del_box#) and userid = '#session.userid#'
</cfquery>
<cfif session.modality EQ 1>
<cfquery datasource="#application.DataSource#" 	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="checkCollab2">
select isNull(sodistrict, 0) as sodistrict , tLevel, del, seq as uniqID
from collaborators
where userid='#session.userid#'
and seq in (#form.del_box#)
</cfquery>

<cfif checkCollab2.recordcount  GT 0>

<cfloop query="checkCollab2">
<cfquery datasource="#application.DataSource#" 	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="checkCollab">
insert into tHCPOlog
(userid, year2, thcposeq, oldtlevel, newtlevel, del, new)
values
(<cfqueryparam cfsqltype="cf_sql_varchar" value="#session.userid#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#session.fy#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#checkCollab2.uniqID#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#checkCollab2.tLevel#">,
NULL,
<cfqueryparam cfsqltype="cf_sql_bit" value="1">,
<cfqueryparam cfsqltype="cf_sql_bit" value="0">)
</cfquery>
</cfloop>

</cfif>
</cfif>
</cfif>

<cfif cksodistrict EQ 1>
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qschoolname">
	select institutionName 
	from nysed_school 
	where bedscode = '#form.school#'
</cfquery>
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QOrgname">
	select orgname , coordemail as email
	from contact 
	where userid = '#session.userid#'
</cfquery>
<cfquery datasource="#application.DataSource#"  	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QSMname">
select c.email
from modality_manager m, contact c 
where modality = 4
and m.userid=c.userid
</cfquery>
<cfoutput>
<cfmail from="dplotner@rti.org" cc="dplotner@rti.org" to="#QSMname.email#" subject="School checked to be stand-alone district" type="HTML">
#QOrgname.orgname# has entered the following school, as reporting as a district for CAT quarterly purposes:
<br>
#Qschoolname.institutionName#
</cfmail>
</cfoutput>
</cfif>



<!--- all this moved from other forms - dp- --->

<cfif session.fy GT 2010 and session.modality EQ 4>

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

<CFQUERY NAME="spbas" 
		 DATASOURCE="#application.DataSource#"
         USERNAME="#application.db_username#"
         PASSWORD="#application.db_password#">
	 delete 
	 from sp_baseline 
	 where userid ='#session.userid#'
	 and district ='#form.sname1#'
	 and year2='#session.fy#'
	 
</CFQUERY>


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
</cfif>

</cfif>


<cfset location="#cgi.http_referer#">

<!--- <cfset location  ="cat.cfm"> --->
<!--- <cflocation addtoken="No" url="#location#?#session.urltoken#&hide=true"> --->
<cflocation addtoken="No" url="collaborators.cfm?#session.urltoken#&hide=true">
</body>
</html>
