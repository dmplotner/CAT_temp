<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
<title>CAT</title>

<cfif isDefined("url.q")> 
	<cfset form.Q=url.q>
</cfif>

<cfinclude template="catstruct.cfm">
<script language="javascript">
function disableme(){
for(var intloop=0; intloop <document.tblone.length; intloop++){
document.tblone[intloop].disabled=true;
}

}

function returnMenu(){
document.tblone.action = "QSP_menu.cfm";
document.tblone.submit();
}
function prcForm(what){
if (what == "AddOne"){
document.tblone.action = "prc_QPP.cfm";
document.tblone.submit();
}

if (what == "DelOne"){
document.tblone.action = "prc_QPP.cfm?Del=Y";
document.tblone.submit();
}

if (what == "Resone"){
document.tblone.action = "QPP.cfm?<cfoutput>#session.urltoken#&Q=#url.q#</cfoutput>";
document.tblone.submit();
}

if (what == "checkOne"){
document.tblone.action = "QPP.cfm?<cfoutput>#session.urltoken#&Q=#url.q#</cfoutput>&recent=1&sec=1#prt1";
document.tblone.submit();
}

}

</script>

<cfset suppressBase=0>
<cfset suppressBase2=0>

<cfquery datasource="#application.DataSource#" 	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qselmembers">
	select descrip, num 
	from lu_comm_mbrs
	where year2=#session.fy#
	order by rank
</cfquery>

<cfquery datasource="#application.DataSource#" 	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qtfsp">
	select descrip, num, isNull(t.stem, 0) as stem, lead, isNull(stemtxt,'') as stemtxt
	from lu_tfsp as t left outer join lu_ftsp_stem s on t.year2=s.year2 and t.stem=s.stemnum
	where t.year2=#session.fy#
	and header =1
	order by rank
</cfquery>

<cfquery datasource="#application.DataSource#" 	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qtfsp2">
	select descrip, num, isNull(t.stem, 0) as stem, lead, isNull(stemtxt,'') as stemtxt
	from lu_tfsp as t left outer join lu_ftsp_stem s on t.year2=s.year2 and t.stem=s.stemnum
	where t.year2=#session.fy#
	and header =2
	order by rank
</cfquery>

<cfquery datasource="#application.DataSource#" 	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qpol">
	select descrip, num
	from lu_comm_pol
	where year2=#session.fy#
	order by rank
</cfquery>

<cfquery datasource="#application.DataSource#" 	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QpolV">
	select descrip, num
	from lu_comM_polV
	where year2=#session.fy#
	order by rank
</cfquery>

<!--- <cfquery datasource="#application.DataSource#" 	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qdistrict">
	select distinct agency_name
	from schools
	order by agency_name
</cfquery> --->

 <cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qcollab_district">
	select distinct district
	from collaborators
	where userid='#session.userid#'
	<!--- and year2=#session.fy# --->
	and  school='999'
	order by 1
</cfquery>
<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qcollab_school">
	select distinct school
	from collaborators
	where userid='#session.userid#'
	and (sodistrict is null or sodistrict != 1)
	<!--- and year2=#session.fy# --->
	order by 1
</cfquery>
 
 <cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qschool">
	select bedscode,institutionName, district
	from nysed_school
	where <!--- district_code in (#valuelist(Qcollab_district.district)#)	
	and ---> bedscode in (<cfif Qcollab_school.recordcount GT 0> #quotedvaluelist(Qcollab_school.school)#<cfelse>'0'</cfif>)
	order by 2
</cfquery>

<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qdistrict">
	select 2, s.bedscode,s.institutionName, s.district, d.district_name as dn
	from nysed_school as s, nysed_district as d
	where <!--- district_code in (#valuelist(Qcollab_district.district)#)	
	and ---> bedscode in (<cfif Qcollab_school.recordcount GT 0> #quotedvaluelist(Qcollab_school.school)#<cfelse>'0'</cfif>)
	and d.district_id=s.district
	union
	select 1, s.bedscode,'**' + s.institutionName + '**', s.district, d.district_name
	from nysed_school as s, nysed_district as d
	where <!--- district_code in (#valuelist(Qcollab_district.district)#)	
	and ---> (
	<!--- (district in (<cfif Qschool.recordcount GT 0>#quotedvaluelist(Qschool.district)#<cfelse>'0'</cfif>) and bedscode like '%0000')
	or --->
	(district in (<cfif Qcollab_district.recordcount GT 0> #quotedvaluelist(Qcollab_district.district)#<cfelse>'0'</cfif>)and bedscode like '%0000')
	)
	and d.district_id=s.district
	order by 5,1,3
</cfquery>


<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qdistrict_ONLY">
 <!--- select distinct  2, s.district + s.county + '0000' as bedscode,d.district_name as institutionName, s.district, d.district_name as dn
	from nysed_school as s, nysed_district as d
	where bedscode in (<cfif Qcollab_school.recordcount GT 0> #quotedvaluelist(Qcollab_school.school)#<cfelse>'0'</cfif>)
	and d.district_id=s.district
	order by 5,1,3 --->
	
	<!--- select distinct  2, s.district + s.county + '0000' as bedscode,d.district_name as institutionName, s.district, d.district_name as dn
	from nysed_school as s, nysed_district as d
	where bedscode in (<cfif Qcollab_school.recordcount GT 0> #quotedvaluelist(Qcollab_school.school)#<cfelse>'0'</cfif>)
	and d.district_id=s.district
	union
select distinct  2, s.district + s.county + '0000' as bedscode,d.district_name as institutionName, s.district, d.district_name as dn
	from nysed_school as s, nysed_district as d
	where s.district in (<cfif Qcollab_district.recordcount GT 0> #quotedvaluelist(Qcollab_district.district)#<cfelse>'0'</cfif>)
	and d.district_id=s.district
	order by 5,1,3 --->
	select distinct  2, d.bedscode, d.institutionName, d.district, d.institutionName as dn
	from nysed_school as s, nysed_school as d
	where s.bedscode in (<cfif Qcollab_school.recordcount GT 0> #quotedvaluelist(Qcollab_school.school)#<cfelse>'0'</cfif>)
	and d.district=s.district
	and d.bedscode like '%0000'
	<!--- select distinct  2, s.district + s.institutionType + '0000' as bedscode,d.district_name as institutionName, s.district, d.district_name as dn
	from nysed_school as s, nysed_district as d
	where bedscode in (<cfif Qcollab_school.recordcount GT 0> #quotedvaluelist(Qcollab_school.school)#<cfelse>'0'</cfif>)
	and d.district_id=s.district
	--and bedscode like '%0000' --->
	union
select distinct  2, s.bedscode,d.district_name as institutionName, s.district, d.district_name as dn
	from nysed_school as s, nysed_district as d
	where s.district in (<cfif Qcollab_district.recordcount GT 0> #quotedvaluelist(Qcollab_district.district)#<cfelse>'0'</cfif>)
	and d.district_id=s.district
	and bedscode like '%0000'
	
		UNION
	
	select 2, bedscode, institutionname, district, institutionname as dn from nysed_school
	where bedscode in (
	select distinct  school from collaborators where (sodistrict is not null and sodistrict = 1)
	and userid='#session.userid#')
	
	
	order by 5,1,3
	
</cfquery>


<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qdistrict2">
	select 2, s.bedscode,s.institutionName, s.district, d.district_name as dn
	from nysed_school as s, nysed_district as d
	where <!--- district_code in (#valuelist(Qcollab_district.district)#)	
	and ---> bedscode in (<cfif Qcollab_school.recordcount GT 0> #quotedvaluelist(Qcollab_school.school)#<cfelse>'0'</cfif>)
	and d.district_id=s.district
	order by 5,1,3
</cfquery>

<cfquery datasource="#application.DataSource#" 	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qschool">
	select nces_id_code, agency_name, school_name
	from schools
	order by school_name
</cfquery>

<cfquery datasource="#application.DataSource#" 	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QcheckPP1">
	<!--- select *
	from sp_qpp
	where year2=#session.fy#
	and userid = '#session.userid#'
	and q=#url.q#
	order by dname, sname
	 --->
	
select s.seq, s.sname, ns.InstitutionName, nd.district_name
from 
sp_qpp  s 
left outer join nysed_school  ns on ns.bedscode=s.sname 
left outer join nysed_district  nd on nd.district_id=left(s.sname,6)
where s.userid='#session.userid#'
and s.year2=#session.fy#
and s.q=#url.q#

	
</cfquery>

<cfquery datasource="#application.DataSource#" 	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QcheckPP2">
	<!--- select *
	from sp_qpp2
	where year2=#session.fy#
	and userid = '#session.userid#'
	and q=#url.q#
	order by dname, sname	
	 --->
	select s.seq, s.sname, ns.InstitutionName, nd.district_name
from 
sp_qpp2  s 
left outer join nysed_school  ns on ns.bedscode=s.sname 
left outer join nysed_district  nd on nd.district_id=left(s.sname,6)
where s.userid='#session.userid#'
and s.year2=#session.fy#
and s.q=#url.q#

</cfquery>

<cfif isDefined("url.sec") and url.sec EQ 1>
<cfif isDefined("url.recent") and url.recent EQ 1>
<cfquery datasource="#application.DataSource#" 	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Q_selrecordPP1">
	select 
	sname,
	2 as tframe,
	liaison,	
	committee,
	commmbr,
	othercommmbr,
	wpolicy,	
	components,	
	other_components,
	sbapproved,
	addcomments,
	other_components	
	from SP_QPP
	where 
	userid='#session.userid#'
	and year2=#session.fy#
	and sname = '#form.sname1#'
	group by sname, tframe, liaison, committee, commmbr, othercommmbr, wpolicy, components, other_components, sbapproved, addcomments, other_components
	having max(Q) <= #url.q#
</cfquery>

<cfquery datasource="#application.DataSource#" 	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Q_baseline">
select  tframe 
from SP_QPP
	where 
	userid='#session.userid#'
	and year2=#session.fy#
	and Q < #url.q#
	and sname = '#form.sname1#'
</cfquery>

<cfif Q_baseline.recordcount GT 0>
	<cfset suppressBase=1>
<cfelse>
	<cfset suppressBase=0>
</cfif>
<cfelse>
<cfquery datasource="#application.DataSource#" 	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Q_selrecordPP1">
	select 
	sname,
	tframe,
	liaison,	
	committee,
	commmbr,
	othercommmbr,
	wpolicy,	
	components,	
	other_components,
	sbapproved,
	addcomments,
	other_components
	
	from SP_QPP
	where 
	userid='#session.userid#'
	and year2=#session.fy#
	and Q=#url.q#
	and sname = '#url.school#'
</cfquery>
<cfquery datasource="#application.DataSource#" 	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Q_baseline">
select  tframe 
from SP_QPP
	where 
	userid='#session.userid#'
	and year2=#session.fy#
	and Q < #url.q#
	and sname = '#url.school#'
</cfquery>

<cfif Q_baseline.recordcount GT 0>
	<cfset suppressBase=1>
<cfelse>
	<cfset suppressBase=0>
</cfif>
</cfif>






<cfif Q_selrecordPP1.recordcount GT 0>
<cfset form.sname1=Q_selrecordPP1.sname>
<cfset form.tframe1=Q_selrecordPP1.tframe>
<cfset form.liaison=Q_selrecordPP1.liaison>
<cfset form.committee=Q_selrecordPP1.committee>
<cfset form.commmbr=Q_selrecordPP1.commmbr>
<cfset form.othercommmbr=Q_selrecordPP1.othercommmbr>
<cfset form.wpolicy=Q_selrecordPP1.wpolicy>
<cfset form.othercommmbr=Q_selrecordPP1.othercommmbr>
<cfset form.wpolicy=Q_selrecordPP1.wpolicy>
<cfset form.components=Q_selrecordPP1.components>
<cfset form.other_components=Q_selrecordPP1.other_components>

<cfset form.sbapproved=Q_selrecordPP1.sbapproved>
<cfset form.addcomments=Q_selrecordPP1.addcomments>
</cfif>
<!--- <cfset form.sbapproved=Q_selrecordPP1.sbapproved> --->

<cfelseif isDefined("url.sec") and url.sec EQ 2>
<cfif isDefined("url.recent") and url.recent EQ 2>
<cfquery datasource="#application.DataSource#" 	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Q_selrecordPP2">
	select 
	sname,
	2 as tframe,
	sccomm,
	commpol,
	othercommpol,
	viscomm,
	commpolv,
	othercommpolv,
	mediacomm,
	mediacomm_method,
	othermediacomm,
	extent_imp,
	extent_enf	
	from SP_QPP2
	where 
	userid='#session.userid#'
	and year2=#session.fy#
	and sname = '#form.sname#'
	
		group by 
	 
	sname,
	tframe,
	sccomm,
	commpol,
	othercommpol,
	viscomm,
	commpolv,
	othercommpolv,
	mediacomm,
	mediacomm_method,
	othermediacomm,
	extent_imp,
	extent_enf
	having max(Q) <= #url.q#
</cfquery>
<cfquery datasource="#application.DataSource#" 	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Q_baseline2">
select  tframe 
from SP_QPP2
	where 
	userid='#session.userid#'
	and year2=#session.fy#
	and Q < #url.q#
	and sname = '#form.sname#'
</cfquery>

<cfif Q_baseline2.recordcount GT 0>
	<cfset suppressBase2=1>
<cfelse>
	<cfset suppressBase2=0>
</cfif>
<cfelse>
<cfquery datasource="#application.DataSource#" 	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Q_selrecordPP2">
	select 
	sname,
	tframe,
	sccomm,
	commpol,
	othercommpol,
	viscomm,
	commpolv,
	othercommpolv,
	mediacomm,
	mediacomm_method,
	othermediacomm,
	extent_imp,
	extent_enf
	
	from SP_QPP2
	where 
	userid='#session.userid#'
	and year2=#session.fy#
	and Q=#url.q#
	and sname = '#url.school#'

</cfquery>

<cfquery datasource="#application.DataSource#" 	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Q_baseline2">
select  tframe 
from SP_QPP2
	where 
	userid='#session.userid#'
	and year2=#session.fy#
	and Q < #url.q#
	and sname = '#url.school#'
</cfquery>

<cfif Q_baseline2.recordcount GT 0>
	<cfset suppressBase2=1>
<cfelse>
	<cfset suppressBase2=0>
</cfif>
</cfif>

<cfif Q_selrecordPP2.recordcount GT 0>
<cfset form.sname = Q_selrecordPP2.sname>
<cfset form.tframe = Q_selrecordPP2.tframe>
<cfset form.commpol = Q_selrecordPP2.commpol>
<cfset form.othercommpol = Q_selrecordPP2.othercommpol>
<cfset form.viscomm = Q_selrecordPP2.viscomm>
<cfset form.commpolv = Q_selrecordPP2.commpolv>
<cfset form.othercommpolv = Q_selrecordPP2.othercommpolv>
<cfset form.mediacomm = Q_selrecordPP2.mediacomm>
<cfset form.sccomm = Q_selrecordPP2.sccomm>
<cfset form.mediacomm_method = Q_selrecordPP2.mediacomm_method> 
<cfset form.othermediacomm= Q_selrecordPP2.othermediacomm> 
<cfset form.extent_imp= Q_selrecordPP2.extent_imp>
<cfset form.extent_enf = Q_selrecordPP2.extent_enf>
</cfif>
</cfif>



<DIV align="center" ><h3>Policy & Procedures Report: Quarter <cfoutput>#url.Q#</cfoutput></h3></DIV>

<cfform name="tblone">
<input type="hidden" name="Q" <cfoutput>value="#url.Q#"</cfoutput>>
<table width="80%" border=".2" align="center" class="box">
<tr><th colspan="2">District Level Policy Report</th></tr>

<tr>
<td>District Name</td>
<td><cfif  isDefined("form.sname1")>
		<cfselect name="sname1" query="Qdistrict_ONLY" value="bedscode" display="institutionname" queryPosition="below" selected="#form.sname1#" onChange="prcForm('checkOne');" >
		<option value="999"><strong>Please select a District</strong></option>
	</cfselect>
	<cfelse>
		<cfselect name="sname1" query="Qdistrict_ONLY" value="bedscode" display="institutionname" queryPosition="below"  onChange="prcForm('checkOne');">
		<option value="999"><strong>Please select a District</strong></option>
	</cfselect>
	</cfif>
</td>
</tr>
<tr>
	<td valign="top">Timeframe</td>
	<td valign="top">
		<input type="radio" name="tframe1" value="1" <cfif suppressBase EQ 1>disabled</cfif><cfif isdefined("form.tframe1") and form.tframe1 EQ 1> checked</cfif>> Baseline<br>
		<input type="radio" name="tframe1" value="2"<cfif isdefined("form.tframe1") and form.tframe1 EQ 2> checked</cfif>> Update	
	</td>
</tr>
<cfif session.fy LT 2008>
<tr>
	<td valign="top"> Does the district have a tobacco policy liaison?</td>
	<td valign="top">
		<input type="radio" name="liaison" value="1" <cfif isdefined("form.liaison") and form.liaison EQ 1> checked</cfif>> Yes <br>
		<input type="radio" name="liaison" value="0" <cfif isdefined("form.liaison") and form.liaison EQ 0> checked</cfif>> No
	</td>
</tr>

<tr>
	<td valign="top">Does the district have a committee to address tobacco policy issues?</td>
	<td valign="top">
	<input type="radio" name="committee" value="1" <cfif isdefined("form.committee") and form.committee EQ 1> checked</cfif> onClick="prcForm('Resone');"> Yes, a district-level committee is fully developed <br>
	<input type="radio" name="committee" value="2" <cfif isdefined("form.committee") and form.committee EQ 2> checked</cfif> onClick="prcForm('Resone');"> Yes, a school-level committee is fully developed <br>
	<input type="radio" name="committee" value="3" <cfif isdefined("form.committee") and form.committee EQ 3> checked</cfif> onClick="prcForm('Resone');"> Yes, district-level committee development is in progress <br>
	<input type="radio" name="committee" value="4" <cfif isdefined("form.committee") and form.committee EQ 4> checked</cfif> onClick="prcForm('Resone');"> Yes, school-level committee development is in progress <br>
	<input type="radio" name="committee" value="0" <cfif isdefined("form.committee") and form.committee EQ 0> checked</cfif> onClick="prcForm('Resone');"> No 
	
	</td>
</tr>
<cfif isDefined("form.committee") and form.committee NEQ 0>
<tr>
	<td valign="top">If yes, select members represented on the committee:</td>
	<td valign="top">	
	<cfoutput>
	<table class="detlist">
	<cfloop query="Qselmembers">
	
	<tr>
		<td valign="top" width="3"><input type="checkbox" name="commmbr" value="#num#" <cfif isdefined("form.commmbr") and listfind(form.commmbr,num)> checked</cfif> ></td>
		<td valign="top">#descrip#</td>
	</tr>
	</cfloop>
	<tr>
		<td>&nbsp;</td><td><input type="text"  size="70" name="othercommmbr"<cfif isdefined("form.othercommmbr")> value="#form.othercommmbr#"</cfif>></td>
	</tr>
	
	</table>	
	</cfoutput>
	</td>
</tr>
</cfif>
</cfif>
<!--- <tr>
	<td valign="top">
		Does the school or district have a written tobacco-free school policy?
	</td>
	<td valign="top">
		<input type="radio" name="wpolicy" value="1"<cfif isdefined("form.wpolicy") and form.wpolicy EQ 1> checked</cfif>  onClick="prcForm('Resone');"> Yes <br>
		<input type="radio" name="wpolicy" value="0"<cfif isdefined("form.wpolicy") and form.wpolicy EQ 0> checked</cfif>  onClick="prcForm('Resone');"> No
	</td>
</tr> --->
<input type="hidden" name="wpolicy" value="1">
<!--- <cfif isDefined("form.wpolicy") and form.wpolicy EQ 1> --->
<tr>
	<td valign="top">What components are included in the tobacco free school policy?</td>
	<td valign="top">
	<cfoutput>
	<table class="detlist">
	<tr>
	<td colspan="2" valign="top"><strong>Minimum Criteria</strong></td>
	</tr>
	<cfset tempstem="">
	<cfloop query="Qtfsp">	
	<cfif session.fy GTE 2008 AND Qtfsp.stem NEQ 0>
	<cfif Qtfsp.stem NEQ tempstem>
	<tr>
		<td colspan="2">#stemtxt#</td>
	</tr>
	</cfif>
	<tr>
		<td></td>
		<td valign="top"><input type="checkbox" name="components" value="#num#" <cfif isdefined("form.components") and listfind(form.components,num)> checked</cfif>>
		#lead#
		</td>
		
	</tr>
	<cfset tempstem=Qtfsp.stem>
	<cfelse>
	<tr>
		<td valign="top"><input type="checkbox" name="components" value="#num#" <cfif isdefined("form.components") and listfind(form.components,num)> checked</cfif>></td>
		<td valign="top">#descrip#</td>
	</tr>
	</cfif>
	</cfloop>
	
	<tr>
	<td colspan="2" valign="top"><strong>Additional Policy Elements</strong></td>
	</tr>
	<cfset tempstem="">
	<cfloop query="Qtfsp2">	
	<cfif session.fy GTE 2008 AND Qtfsp2.stem NEQ 0>
	<cfif Qtfsp2.stem NEQ tempstem>
	<tr>
		<td colspan="2">#stemtxt#</td>
	</tr>
	</cfif>
	<tr>
		<td></td>
		<td valign="top"><input type="checkbox" name="components" value="#num#" <cfif isdefined("form.components") and listfind(form.components,num)> checked</cfif>>
		#lead#
		</td>
		
	</tr>
	<cfset tempstem=Qtfsp2.stem>
	<cfelse>
	<tr>
		<td valign="top"><input type="checkbox" name="components" value="#num#" <cfif isdefined("form.components") and listfind(form.components,num)> checked</cfif>></td>
		<td valign="top">#descrip#</td>
	</tr>
	</cfif>
	</cfloop>
	<tr>
		<td valign="top"><input type="checkbox" name="components" value="99" <cfif isdefined("form.components") and listfind(form.components,99)> checked</cfif>></td>
		<td valign="top">Other:<input type="text" size="40" name="other_components" <cfif isdefined("form.other_components")>value="<cfoutput>#form.other_components#</cfoutput>"</cfif>></td>
	</tr>
	</table>	
	</cfoutput>
	</td>
</tr>
<tr>
	<td valign="top">Has the school board approved the tobacco free school policy?</td>
	<td valign="top">
		<input type="radio" name="sbapproved" value="1" <cfif isdefined("form.sbapproved") and form.sbapproved EQ 1 > checked</cfif>> Yes <br>
		<input type="radio" name="sbapproved" value="0" <cfif isdefined("form.sbapproved") and form.sbapproved EQ 0 > checked</cfif>> No <br>
		<input type="radio" name="sbapproved" value="2" <cfif isdefined("form.sbapproved") and form.sbapproved EQ 2 > checked</cfif>> Don't Know
	</td>
	
</tr>
<!--- </cfif> --->
<tr>
	<td colspan="2">
	Additional Comments:<br>
	<textarea name="addcomments" cols="80" rows="5"><cfif isdefined("form.addcomments") ><cfoutput>#form.addcomments#</cfoutput></cfif></textarea>
	</td>
</tr>
<tr>
	<td colspan="2" align="left"><input type="button" <cfif isDefined("url.sec") and url.sec EQ 1> value="Update"<cfelse> value="Add"</cfif>class="AddButton" onClick="prcForm('AddOne');"></td>
</tr>
</table>

<cfif QcheckPP1.recordcount GT 0>




<table width="80%" border=".2" align="center" class="box" >
<cfoutput>
<cfloop query="QcheckPP1">

<tr bgcolor="Silver">
	<td colspan="3">
	<a href="qpp.cfm?#session.urltoken#&q=#url.q#&school=#sname#&sec=1">#district_name# #InstitutionName#</a>
	</td>
	<td align="right">
		Delete?
		<input type="checkbox" name="delQPP" value="#seq#">
	</td>
	
</tr>
</cfloop>
<tr>
	<td colspan="2"><input type="button" class="DelButton" value="Delete"  onClick="prcForm('DelOne');"></td>
</tr>

</cfoutput>
</table>

</cfif>

</cfform>



<div align="center"><input type="button" value="Save and Return to Main Screen" onClick="returnMenu();"></div>
</body>
<cfinclude template="quarterly_extm.cfm">
</html>
