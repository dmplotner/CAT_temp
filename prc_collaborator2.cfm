<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>
<cfparam name="form.sodistrict" default="0">
<cfparam name="cksodistrict" default="0">
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
(userid, year2, thcposeq<cfif isdefined("checkCollab.tlevel")>
, oldtlevel</cfif><cfif isdefined("form.tlevel")>, newtlevel</cfif>, del, new)
values
(<cfqueryparam cfsqltype="cf_sql_varchar" value="#session.userid#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#session.fy#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#checkCollab.seq#">,
<cfif isdefined("checkCollab.tlevel")>
<cfqueryparam cfsqltype="cf_sql_varchar" value="#checkCollab.tLevel#">,</cfif>
<cfif isdefined("form.tlevel")>
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.tLevel#">,</cfif>
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
	<cfif isdefined("form.jurisdiction")>county='#form.jurisdiction#',</cfif>
	<!--- year2=#session.fy#, --->
	unit= <cfif isDefined("form.newUnit") and form.newUnit NEQ "">'#form.newUnit#'<cfelseif isDefined("form.Unit") and form.Unit NEQ "">'#form.Unit#'<cfelse> NULL</cfif>,
	tHCPO=<cfif isDefined("form.tHCPO") and form.tHCPO NEQ "">#form.tHCPO#<cfelse>NULL</cfif>,
	tLevel=<cfif isDefined("form.tLevel") and form.tLevel NEQ "">#form.tLevel#<cfelse>NULL</cfif>,
		fqhc=<cfif isDefined("form.fqhc") and form.fqhc NEQ "">#form.fqhc#<cfelse>NULL</cfif>,
				ref=<cfif isDefined("form.ref") and form.ref NEQ "">#form.ref#<cfelse>NULL</cfif>,
				<cfif isDefined("form.cess") and form.cess NEQ "">cess=#form.cess#,</cfif>
				<!--- cess=<cfif isDefined("form.cess") and form.cess NEQ "">#form.cess#<cfelse>NULL</cfif>, --->
		writpol=<cfif isDefined("form.writpol") and form.writpol NEQ "">#form.writpol#<cfelse>NULL</cfif>,
		ask=<cfif isDefined("form.ask") and form.ask NEQ "">#form.ask#<cfelse>NULL</cfif>,
		advise_ident=<cfif isDefined("form.advise_ident") and form.advise_ident NEQ "">#form.advise_ident#<cfelse>NULL</cfif>,
		assess_ident=<cfif isDefined("form.assess_ident") and form.assess_ident NEQ "">#form.assess_ident#<cfelse>NULL</cfif>,
		assarr_ident=<cfif isDefined("form.assarr_ident") and form.assarr_ident NEQ "">#form.assarr_ident#<cfelse>NULL</cfif>,
		advise_writpol=<cfif isDefined("form.advise_writpol") and form.advise_writpol NEQ "">#form.advise_writpol#<cfelse>NULL</cfif>,
		assess_writpol=<cfif isDefined("form.assess_writpol") and form.assess_writpol NEQ "">#form.assess_writpol#<cfelse>NULL</cfif>,
		assarr_writpol=<cfif isDefined("form.assarr_writpol") and form.assarr_writpol NEQ "">#form.assarr_writpol#<cfelse>NULL</cfif>,
		train=<cfif isDefined("form.train") and form.train NEQ "">#form.train#<cfelse>NULL</cfif>,
		idsys=<cfif isDefined("form.idsys") and form.idsys NEQ "">#form.idsys#<cfelse>NULL</cfif>,
		docsys=<cfif isDefined("form.docsys") and form.docsys NEQ "">#form.docsys#<cfelse>NULL</cfif>,
		
		idsys2=<cfif isDefined("form.idsys2") and form.idsys2 NEQ "">#form.idsys2#<cfelse>NULL</cfif>,
		docsys2=<cfif isDefined("form.docsys2") and form.docsys2 NEQ "">#form.docsys2#<cfelse>NULL</cfif>,
		
		staff=<cfif isDefined("form.staff") and form.staff NEQ "">#form.staff#<cfelse>NULL</cfif>,
		fback=<cfif isDefined("form.fback") and form.fback NEQ "">#form.fback#<cfelse>NULL</cfif>,
		campus=<cfif isDefined("form.campus") and form.campus NEQ "">#form.campus#<cfelse>NULL</cfif>,
		pip=<cfif isDefined("form.pip") and form.pip NEQ "">'#form.pip#'<cfelse>NULL</cfif>,
		entdt=<cfif isDefined("form.entdt") and form.entdt NEQ "">#form.entdt#<cfelse>NULL</cfif>

	<cfelse>school='#form.school#', district='#form.district#', sodistrict = #form.sodistrict#, sfy='#form.sfy#'</cfif>
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
	type,<cfif isdefined("form.jurisdiction")> county,</cfif>
	<cfelse>school, district, sodistrict,sfy,
	</cfif> 
	userid, year2 
	<cfif (isDefined("form.unit") and form.unit NEQ "") OR (isDefined("form.newunit") and form.newunit NEQ "")>,unit</cfif>
	<cfif isDefined("form.tHCPO") and form.tHCPO NEQ "">,tHCPO</cfif>
	<cfif isDefined("form.fqhc") and form.fqhc NEQ "">,fqhc</cfif>
		<cfif isDefined("form.ref") and form.ref NEQ "">,ref</cfif>
		<cfif isDefined("form.cess") and form.cess NEQ "">,cess</cfif>
	<cfif isDefined("form.tLevel") and form.tLevel NEQ "">,tLevel</cfif>
	<cfif isDefined("form.advise_writpol") and form.advise_writpol NEQ "">,advise_writpol</cfif>
	<cfif isDefined("form.assess_writpol") and form.assess_writpol NEQ "">,assess_writpol</cfif>
	<cfif isDefined("form.assarr_writpol") and form.assarr_writpol NEQ "">,assarr_writpol</cfif>
		<cfif isDefined("form.writpol") and form.writpol NEQ "">,form.writpol</cfif>
	<cfif isDefined("form.ask") and form.ask NEQ "">,ask</cfif>
	<cfif isDefined("form.advise_ident") and form.advise_ident NEQ "">,advise_ident</cfif>
	<cfif isDefined("form.assess_ident") and form.assess_ident NEQ "">,assess_ident</cfif>
	<cfif isDefined("form.assarr_ident") and form.assarr_ident NEQ "">,assarr_ident</cfif>
	<cfif isDefined("form.train") and form.train NEQ "">,train</cfif>
	
,idsys
,docsys
,idsys2
,docsys2
	
	
	<cfif isDefined("form.staff") and form.staff NEQ "">,staff</cfif>
	<cfif isDefined("form.fback") and form.fback NEQ "">,fback</cfif>
	<cfif isDefined("form.campus") and form.campus NEQ "">,campus</cfif>
	<cfif isDefined("form.timprovement")>, timprovement</cfif>
		<cfif isDefined("form.pip")>, pip</cfif>

	<cfif isDefined("form.entdt")>, entdt</cfif>)

	values
	(<cfif session.modality NEQ 4>'#htmleditformat(form.collabName)#', 
	<cfif isDefined("form.indOrg")>'#form.indOrg#',<cfelse>2,</cfif>
	<cfif session.fy LT 2007 and session.fy GT 1920>'#form.traditional#',</cfif>
	'#form.collabtype#'<cfif isdefined("form.jurisdiction")>, '#form.jurisdiction#'</cfif>, <cfelse>'#form.school#', '#form.district#', #form.sodistrict#,#form.sfy#,</cfif> 
	'#session.userid#', #session.fy# <cfif isDefined("form.newUnit") and form.newUnit NEQ "">,'#form.newUnit#'<cfelseif isDefined("form.Unit") and form.Unit NEQ "">,'#form.Unit#'</cfif>
	<cfif isDefined("form.tHCPO") and form.tHCPO NEQ "">,#form.tHCPO#</cfif>
	<cfif isDefined("form.fqhc") and form.fqhc NEQ "">,#form.fqhc#</cfif>
		<cfif isDefined("form.ref") and form.ref NEQ "">,#form.ref#</cfif>
		<cfif isDefined("form.cess") and form.cess NEQ "">,#form.cess#</cfif>
	<cfif isDefined("form.tLevel") and form.tLevel NEQ "">,#form.tLevel#</cfif>
		<cfif isDefined("form.writpol") and form.writpol NEQ "">,#form.writpol#</cfif>
	<cfif isDefined("form.ask") and form.ask NEQ "">,#ask#</cfif>
	<cfif isDefined("form.advise_writpol") and form.advise_writpol NEQ "">,#advise_writpol#</cfif>
	<cfif isDefined("form.assess_writpol") and form.assess_writpol NEQ "">,#assess_writpol#</cfif>
	<cfif isDefined("form.assarr_writpol") and form.assarr_writpol NEQ "">,#assarr_writpol#</cfif>
	<cfif isDefined("form.advise_ident") and form.advise_ident NEQ "">,#advise_ident#</cfif>
	<cfif isDefined("form.assess_ident") and form.assess_ident NEQ "">,#assess_ident#</cfif>
	<cfif isDefined("form.assarr_ident") and form.assarr_ident NEQ "">,#assarr_ident#</cfif>
	<cfif isDefined("form.train") and form.train NEQ "">,#train#</cfif>
	
	<cfif isDefined("form.idsys") and form.idsys NEQ "">,#idsys# <CFELSE>, 0</cfif>
	<cfif isDefined("form.docsys") and form.docsys NEQ "">,#docsys# <CFELSE>, 0</cfif>
	<cfif isDefined("form.idsys2") and form.idsys2 NEQ "">,#idsys2# <CFELSE>, 0</cfif>
	<cfif isDefined("form.docsys2") and form.docsys2 NEQ "">,#docsys2# <CFELSE>, 0</cfif>
	
	<cfif isDefined("form.other2") and form.other2 NEQ "">,#other2#</cfif>
	<cfif isDefined("form.staff") and form.staff NEQ "">,#staff#</cfif>
	<cfif isDefined("form.fback") and form.fback NEQ "">,#fback#</cfif>
	<cfif isDefined("form.campus") and form.campus NEQ "">,#campus#</cfif>
	<cfif isDefined("form.timprovement")>, #form.timprovement#</cfif>
	<cfif isDefined("form.pip")>, '#form.pip#'</cfif>
		<cfif isDefined("form.entdt")>, #form.entdt#</cfif>)
</cfquery>
<!--- check type of insert. Send email to betty if criteria are met. --->
<cfif form.collabtype EQ 3>
<!--- <cfquery datasource="#application.DataSource#" 	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="checkCont">
	select 

</cfquery> 
<cfmail to="bettybrown@rti.org" from="dplotner@rti.org" subject="New CAT entry- #htmleditformat(form.collabName)# (#session.orgName#)">
CC Name: #session.orgName#
Practice Name: #htmleditformat(form.collabName)#<br>
Level: <cfif form.tlevel EQ 1>Potential<cfelseif form.tlevel EQ 2>Ltd<cfelseif form.tlevel EQ 3>Full</cfif>
Date entered: #dateformat(now(), 'm/d/yyyy')#

</cfmail>

--->

</cfif>
<cfif session.modality EQ 1>
 <cfquery datasource="#application.DataSource#" 	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="checkCollab">
select isNull(sodistrict, 0) as sodistrict<cfif isdefined("form.tlevel")> , tLevel</cfif>, del, seq
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
<cfif isdefined("form.tlevel")>
<cfqueryparam cfsqltype="cf_sql_integer" value="#form.tLevel#">,</cfif>
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
select c.coordemail as email
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

<cfset location="#cgi.http_referer#">
<cfquery datasource="#application.DataSource#"  	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="mxid">
select max(seq) as mxid
from collaborators
</cfquery>
<!--- <cfset location  ="cat.cfm"> --->
<!--- <cflocation addtoken="No" url="#location#?#session.urltoken#&hide=true"> --->
<cfif isdefined("form.add_collaborator")>
<cflocation addtoken="No" url="collaborators.cfm?#session.urltoken#&hide=true">
<cfelse>
<cflocation addtoken="No" url="collaborators.cfm?seq=#mxid.mxid#">
</cfif>
</body>
</html>
