<!--- <cfif session.fy EQ 2008 and session.modality EQ 4>
	<cflocation addtoken="yes" url="unavailable.cfm">
</cfif> --->

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

for(var intloop=0; intloop <document.tbltwo.length; intloop++){
document.tbltwo[intloop].disabled=true;
}
}

function returnMenu(){
document.tbltwo.action = "QSP_menu.cfm";
document.tbltwo.submit();
}

function prcForm(what){

if (what == "AddTwo"){
document.tbltwo.action = "prc_QPP2.cfm";
document.tbltwo.submit();
}

if (what == "DelTwo"){
document.tbltwo.action = "prc_QPP2.cfm?Del=Y";
document.tbltwo.submit();
}

if (what == "Restwo"){
document.tbltwo.action = "QPP2.cfm?<cfoutput>#session.urltoken#&Q=#url.q#</cfoutput>#prt2";
document.tbltwo.submit();
}


if (what == "checkTwo"){
document.tbltwo.action = "QPP2.cfm?<cfoutput>#session.urltoken#&Q=#url.q#</cfoutput>&recent=2&sec=2#prt2";
document.tbltwo.submit();
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
	select descrip, num
	from lu_tfsp
	where year2=#session.fy#
	and header =1
	order by rank
</cfquery>

<cfquery datasource="#application.DataSource#" 	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qtfsp2">
	select descrip, num
	from lu_tfsp
	where year2=#session.fy#
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
 select distinct  2, s.district + s.county + '0000' as bedscode,d.district_name as institutionName, s.district, d.district_name as dn
	from nysed_school as s, nysed_district as d
	where bedscode in (<cfif Qcollab_school.recordcount GT 0> #quotedvaluelist(Qcollab_school.school)#<cfelse>'0'</cfif>)
	and d.district_id=s.district
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



<cfform name="tbltwo">
<input type="hidden" name="Q" <cfoutput>value="#url.Q#"</cfoutput>>
<table width="80%" border=".2" align="center" class="box">
<tr><th colspan="2"><a name="prt2"></a>School-level Implementation and Enforcement</th></tr>

<tr>
<td width="40%">School Name</td><!-- query below used to be "Qdistrict2" THEN CHANGED TO qDISTRICT -->
<td><cfif  isDefined("form.sname")>
		<cfselect name="sname" group="dn" query="Qdistrict2" value="bedscode" display="institutionname" queryPosition="below" selected="#form.sname#" onChange="prcForm('checkTwo');" >
		<option value="999"><strong>Please select a School</strong></option>
	</cfselect>
	<cfelse>
		<cfselect name="sname" group="dn" query="Qdistrict2" value="bedscode" display="institutionname" queryPosition="below" onChange="prcForm('checkTwo');">
		<option value="999"><strong>Please select a School</strong></option>
	</cfselect>
	</cfif>
</td>
</tr>

<tr>
	<td valign="top">Timeframe</td>
	<td valign="top">
		<input type="radio" name="tframe" value="1" <cfif suppressBase2 EQ 1>disabled</cfif><cfif isDefined("form.tframe") and form.tframe EQ 1> Checked</cfif>> Baseline<br>
		<input type="radio" name="tframe" value="2" <cfif isDefined("form.tframe") and form.tframe EQ 2> Checked</cfif>> Update	
	</td>
</tr>
<tr>
	<td valign="top">Has the policy been communicated to the school community?</td>
	<td valign="top">
		<input type="radio" name="sccomm" value="1" <cfif isDefined("form.sccomm") and form.sccomm EQ 1> Checked</cfif> onClick="prcForm('Restwo');"> Yes <br>
		<input type="radio" name="sccomm" value="0"<cfif isDefined("form.sccomm") and form.sccomm EQ 0> Checked</cfif> onClick="prcForm('Restwo');"> No <br>
		<input type="radio" name="sccomm" value="2"<cfif isDefined("form.sccomm") and form.sccomm EQ 2> Checked</cfif> onClick="prcForm('Restwo');"> Don't Know
	</td>
</tr>
<cfif isDefined("form.sccomm") and form.sccomm EQ 1>
<tr>
	<td valign="top">If yes, how has the policy been communicated to the school community (students, faculty, vendors, etc)?</td>
	<td valign="top">
	<cfoutput>
	<cfloop query="Qpol">
	<input type="checkbox" name="commPol" value="#num#" <cfif isdefined("form.commPol") and listfind(form.commPol,num)> checked</cfif>>#descrip#<br>
	</cfloop>
	<input type="checkbox" name="commPol" value="99" <cfif isdefined("form.commPol") and listfind(form.commPol,99)> checked</cfif>>Other&nbsp;<input type="text" size="60" name="otherCommPol" <cfif isdefined("form.otherCommPol")> value="#form.otherCommPol#"</cfif>>
	</cfoutput>
	</td>
</tr>
</cfif>
<tr>
	<td valign="top">Has the policy been commmunicated to visitors?</td>
	<td valign="top">
		<input type="radio" name="viscomm" value="1" <cfif isDefined("form.viscomm") and form.viscomm EQ 1> Checked</cfif> onClick="prcForm('Restwo');"> Yes <br>
		<input type="radio" name="viscomm" value="0" <cfif isDefined("form.viscomm") and form.viscomm EQ 0> Checked</cfif> onClick="prcForm('Restwo');"> No <br>
		<input type="radio" name="viscomm" value="2" <cfif isDefined("form.viscomm") and form.viscomm EQ 2> Checked</cfif> onClick="prcForm('Restwo');"> Don't Know
	</td>
</tr>
<cfif isDefined("form.viscomm") and form.viscomm EQ 1>
<tr>
	<td valign="top">If yes, how has the policy been communicated to visitors?</td>
	<td valign="top">
	<cfoutput>
	<cfloop query="QpolV">
	<input type="checkbox" name="commPolV" value="#num#" <cfif isdefined("form.commPolV") and listfind(form.commPolV,num)> checked</cfif>>#descrip#<br>
	</cfloop>
	<input type="checkbox" name="commPolV" value="99" <cfif isdefined("form.commPolV") and listfind(form.commPolV,99)> checked</cfif>>Other
	<input type="text"  size="60" name="OthercommPolV"  <cfif isdefined("form.OthercommPolV")> value="#form.OthercommPolV#"</cfif>>
	</cfoutput>
	</td>
</tr>
</cfif>
<tr>
	<td valign="top">Has the policy been communicated to the community through the media?</td>
	<td valign="top">
		<input type="radio" name="mediacomm" value="1" <cfif isDefined("form.mediacomm") and form.mediacomm EQ 1> Checked</cfif> onClick="prcForm('Restwo');"> Yes <br>
		<input type="radio" name="mediacomm" value="0" <cfif isDefined("form.mediacomm") and form.mediacomm EQ 0> Checked</cfif> onClick="prcForm('Restwo');"> No <br>
		<input type="radio" name="mediacomm" value="2" <cfif isDefined("form.mediacomm") and form.mediacomm EQ 2> Checked</cfif> onClick="prcForm('Restwo');"> Don't Know
	</td>
</tr>
<cfif isDefined("form.mediacomm") and form.mediacomm EQ 1>
<tr>
	<td valign="top">If yes, how has the policy been communicated to the community through the media?</td>
	<td valign="top">
		<input type="checkbox" name="mediaComm_method" value="1" <cfif isDefined("form.mediaComm_method") and listfind(form.mediaComm_method,1)> Checked</cfif>> Newspaper<br>
		<input type="checkbox" name="mediaComm_method" value="2" <cfif isDefined("form.mediaComm_method") and listfind(form.mediaComm_method,2)> Checked</cfif>> Radio<br>
		<input type="checkbox" name="mediaComm_method" value="3" <cfif isDefined("form.mediaComm_method") and listfind(form.mediaComm_method,3)> Checked</cfif>> Other 
		<input type="text" name="otherMediaComm" size="60" <cfif isdefined("form.otherMediaComm")> <cfoutput>value="#form.otherMediaComm#"</cfoutput></cfif>>
	</td>
</tr>
</cfif>
<tr>
	<td valign="top">To what extent has the policy been implemented (policy documented and communicated to school community)?</td>
	<td valign="top">
		<input type="radio" name="extent_imp" value="0" <cfif isDefined("form.extent_imp") and form.extent_imp EQ 0> Checked</cfif>> Not at all<br>
		<input type="radio" name="extent_imp" value="1" <cfif isDefined("form.extent_imp") and form.extent_imp EQ 1> Checked</cfif>> Partially implemented<br>
		<input type="radio" name="extent_imp" value="2" <cfif isDefined("form.extent_imp") and form.extent_imp EQ 2> Checked</cfif>> Fully implemented<br>
		<input type="radio" name="extent_imp" value="3" <cfif isDefined("form.extent_imp") and form.extent_imp EQ 3> Checked</cfif>> Don't know<br>
	</td>
</tr>
<tr>
	<td valign="top">To what extent has the policy been enforced?</td>
	<td valign="top">
		<input type="radio" name="extent_enf" value="0" <cfif isDefined("form.extent_enf") and form.extent_enf EQ 0> Checked</cfif>> Not at all<br>
		<input type="radio" name="extent_enf" value="1" <cfif isDefined("form.extent_enf") and form.extent_enf EQ 1> Checked</cfif>> Partially enforced<br>
		<input type="radio" name="extent_enf" value="2" <cfif isDefined("form.extent_enf") and form.extent_enf EQ 2> Checked</cfif>> Fully enforced<br>
		<input type="radio" name="extent_enf" value="3" <cfif isDefined("form.extent_enf") and form.extent_enf EQ 3> Checked</cfif>> Don't know<br>
	</td>
</tr>

<tr>
	<td colspan="2" align="left"><input type="button" class="AddButton" <cfif isDefined("url.sec") and url.sec EQ 2> value="Update"<cfelse> value="Add"</cfif> onClick="prcForm('AddTwo');"</td>
</tr>
</table>

<cfif QcheckPP2.recordcount GT 0>


 <table width="80%" border=".2" align="center" class="box" >
<cfoutput>
<cfloop query="QcheckPP2">

<tr bgcolor="Silver">
	<td>
	<a href="qpp2.cfm?#session.urltoken#&q=#url.q#&school=#sname#&sec=2&##prt2">#district_name# #InstitutionName#</a>
	</td>
	<td align="right">
		Delete?
		<input type="checkbox" name="delQPP2" value="#seq#">
	</td>
	
</tr>
</cfloop>
<tr>
	<td colspan="2"><input type="button" class="DelButton" value="Delete" onClick="prcForm('DelTwo');"></td>
</tr>

</cfoutput>
</table> 
</cfif>

<!--- <cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qext">
	select userid from quarterly_extensions
	where userid = '#session.userid#'	
</cfquery>

<cfif Qext.recordcount EQ 0>
<cfset tempyr=session.fy>
<cfif tempyr EQ 1904>
	<cfset tempyr=2006>
</cfif>
<cfif (session.fy NEQ session.def_fy OR <!--- session.fy EQ session.def_fy OR  --->

(form.Q EQ 1 and DateCompare(createDate(session.fy, 4, 15),Dateformat(now())) LT 0)
OR 
(form.Q EQ 2 and DateCompare(createDate(session.fy, 7, 15),Dateformat(now())) LT 0)
OR 
(form.Q EQ 3 and DateCompare(createDate(session.fy, 10, 15),Dateformat(now())) LT 0)
OR 
(form.Q EQ 4 and DateCompare(createDate(session.fy+1, 1, 15),Dateformat(now())) LT 0)
<!--- AND session.userid NEQ 'QHC' --->
)
and session.fy EQ "1234">
	<script language="JavaScript">
	disableme();
	</script>	
</cfif>
</cfif> --->

</cfform>
<div align="center"><input type="button" value="Save and Return to Main Screen" onClick="returnMenu();"></div>
</body>
<cfinclude template="quarterly_extm.cfm">
</html>
