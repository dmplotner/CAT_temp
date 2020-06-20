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
		if(document.tbltwo[intloop].type=='textarea'){
	document.tbltwo[intloop].readOnly = true;
	}
	else
document.tbltwo[intloop].disabled=true;
}
}

function returnMenu(){
document.tbltwo.action = "QSP_menu.cfm";
document.tbltwo.submit();
}

function validateDate(fld) {
    var RegExPattern = /^(?=\d)(?:(?:(?:(?:(?:0?[13578]|1[02])(\/|-|\.)31)\1|(?:(?:0?[1,3-9]|1[0-2])(\/|-|\.)(?:29|30)\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})|(?:0?2(\/|-|\.)29\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))|(?:(?:0?[1-9])|(?:1[0-2]))(\/|-|\.)(?:0?[1-9]|1\d|2[0-8])\4(?:(?:1[6-9]|[2-9]\d)?\d{2}))($|\ (?=\d)))?(((0?[1-9]|1[012])(:[0-5]\d){0,2}(\ [AP]M))|([01]\d|2[0-3])(:[0-5]\d){1,2})?$/;
    var errorMessage = 'Please enter valid date as month, day, and four digit year.\nYou may use a slash, hyphen or period to separate the values.\nThe date must be a real date. 2-30-2000 would not be accepted.\nFormay mm/dd/yyyy.';
    if ((fld.value.match(RegExPattern)) && (fld.value!='')) {
        return true; 
    } else {
        alert(errorMessage);
        return false;
    } 
}

function prcForm(what){

if (what == "AddTwo"){
if(document.tbltwo.dimp.disabled == false){
if (validateDate(document.tbltwo.dpass) == false){
return false;
}
if (validateDate(document.tbltwo.dimp) == false){
return false;
}
myOption = -1;
for (i=document.tbltwo.polimp.length-1; i > -1; i--) {
if (document.tbltwo.polimp[i].checked) {
myOption = i; i = -1;
}
}
if (myOption == -1) {
alert("You must select a radio button for  'To what extent has the policy been implemented?'");
return false;
}

myOption = -1;
for (i=document.tbltwo.polenf.length-1; i > -1; i--) {
if (document.tbltwo.polenf[i].checked) {
myOption = i; i = -1;
}
}
if (myOption == -1) {
alert("You must select a radio button for 'To what extent has the policy been enforced?'");
return false;
}
}
document.tbltwo.action = "prc_QPP3.cfm";
document.tbltwo.submit();
}

if (what == "DelTwo"){
document.tbltwo.action = "prc_QPP3.cfm?Del=Y";
document.tbltwo.submit();
}

if (what == "Restwo"){
document.tbltwo.action = "QPP3.cfm?<cfoutput>#session.urltoken#&Q=#url.q#</cfoutput>#prt2";
document.tbltwo.submit();
}


if (what == "checkTwo"){
document.tbltwo.action = "QPP3.cfm?<cfoutput>#session.urltoken#&Q=#url.q#</cfoutput>&recent=2&sec=2#prt2";
document.tbltwo.submit();
}
}


function checkbaseline(){
if(document.tbltwo.tframe.options[document.tbltwo.tframe.selectedIndex].value !=1){
document.tbltwo.dpass.disabled = true;
document.tbltwo.dimp.disabled = true;
}
else
{
document.tbltwo.dpass.disabled = false;
document.tbltwo.dimp.disabled = false;
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
 select distinct  2, s.district + s.institutionType + '0000' as bedscode,d.district_name as institutionName, s.district, d.district_name as dn
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
	username="#application.db_username#" name="Q_luComm">
	select id, descr
	from sp_qpp3_lu_comm
	where year2=2008
	order by rank
	
</cfquery>

<cfquery datasource="#application.DataSource#" 	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QcheckPP1">	
select s.seq, s.sname, ns.InstitutionName, nd.district_name
from 
sp_qpp3  s 
left outer join nysed_school  ns on ns.bedscode=s.sname 
left outer join nysed_district  nd on nd.district_id=left(s.sname,6)
where s.userid='#session.userid#'
and s.year2=#session.fy#
and s.q=#url.q#	
</cfquery>


<!--- <cfif isDefined("url.recent") and url.recent eq 2>

</cfif> --->

<cfif isDefined("form.sname")>
<cfset url.school = form.sname>
</cfif>
<cfif  isDefined("url.school")>

<cfquery datasource="#application.DataSource#" 	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Q_selrecordPP1">
	select 
	sname, tframe,dpass,  
dimp, components, polimp, polenf, addcomments, other_desc 
	from SP_QPP3
	where 
	userid='#session.userid#'
	and year2=#session.fy#
	and sname = '#url.school#'
	and q= (select max(q) from SP_QPP3 
		where userid='#session.userid#'
		and year2=#session.fy#
		and sname = '#url.school#' )
	
	<!--- group by sname, tframe,dpass,  
dimp, components, polimp, polenf, addcomments, other_desc 

	 having max(Q) <= #url.q#  --->
</cfquery>


<cfquery datasource="#application.DataSource#" 	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Q_baseline">
select  components, addcomments, tframe
from SP_QPP3
	where 
	userid='#session.userid#'
	and year2=#session.fy#
	and Q = #url.q#
	and sname = '#url.school#'
</cfquery>

<cfif Q_baseline.tframe NEQ 1>

<cfset suppressBase2=1>
	
</cfif>


<cfif Q_selrecordPP1.recordcount GT 0>
<cfset form.sname=Q_selrecordPP1.sname>
<cfset form.tframe=Q_selrecordPP1.tframe>
<cfset form.dpass=Q_selrecordPP1.dpass>
<cfset form.dimp=Q_selrecordPP1.dimp>
<cfset form.polimp=Q_selrecordPP1.polimp>
<cfset form.polenf=Q_selrecordPP1.polenf>
<cfset form.other_desc=Q_selrecordPP1.other_desc>

<cfset form.components=Q_baseline.components>
<cfset form.addcomments=Q_baseline.addcomments>
<cfelse>
<cfset form.sname="">
<cfset form.tframe="">
<cfset form.dpass="">
<cfset form.dimp="">
<cfset form.polimp="">
<cfset form.polenf="">
<cfset form.other_desc="">
<cfset form.components="">
<cfset form.addcomments="">

</cfif>
</cfif>



<DIV align="center" ><h3>School-level implementation and enforcement report: Quarter <cfoutput>#url.Q#</cfoutput></h3></DIV>



<cfform name="tbltwo">
<input type="hidden" name="Q" <cfoutput>value="#url.Q#"</cfoutput>>
<table width="80%" border=".2" align="center" class="box">
<tr><th colspan="2"><a name="prt2"></a>School-level Implementation and Enforcement</th></tr>

<tr>
<td width="40%">School Name</td><!-- query below used to be "Qdistrict2" THEN CHANGED TO qDISTRICT -->
<td><cfif  isDefined("url.school")>
		<cfselect name="sname" group="dn" query="Qdistrict2" value="bedscode" display="institutionname" queryPosition="below" selected="#url.school#" onChange="prcForm('checkTwo');" >
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
	<td>Timeframe</td>
	<td>
	<select name="tframe" onChange="checkbaseline();">
		<OPTION value="1" <cfif isDefined("form.tframe") and form.tframe EQ 1> selected</cfif>>Quarter during which policy is being implemented </OPTION>
		<OPTION value="2" <cfif isDefined("form.tframe") and form.tframe EQ 2> selected</cfif>>Quarter following policy implementation</OPTION>
		<OPTION value="3" <cfif isDefined("form.tframe") and form.tframe EQ 3> selected</cfif>>12 months after policy implementation</OPTION>
		<OPTION value="4" <cfif isDefined("form.tframe") and form.tframe EQ 4> selected</cfif>>18 months after policy implementation</OPTION>
		<OPTION value="5" <cfif isDefined("form.tframe") and form.tframe EQ 5> selected</cfif>>24 months after policy implementation</OPTION>
		
	</select>
	</td>
</tr>

<tr>
	<td valign="top">Date policy change was passed</td>
	<td valign="top">
		<input type="text" name="dpass" <cfif suppressBase2 EQ 1>disabled</cfif><cfif isDefined("form.dpass")> value = "<cfoutput>#dateformat(form.dpass, 'm/d/yyyy')#</cfoutput>"</cfif>> 
	</td>
</tr>

<tr>
	<td valign="top">Date policy change was implemented</td>
	<td valign="top">
		<input type="text" name="dimp" <cfif suppressBase2 EQ 1>disabled</cfif><cfif isDefined("form.dimp")> value = "<cfoutput>#dateformat(form.dimp, 'm/d/yyyy')#</cfoutput>"</cfif>> 
	</td>
</tr>
<tr><th colspan="2"><a name="prt2"></a>Policy Communication</th></tr>
<tr>
	<td colspan="2">How has the current policy been communicated <strong>during this quarter</strong>? Check all that apply.</td>
</tr>
<cfoutput>
<tr>
		<td>&nbsp;</td>
		<td valign="top" >
		<cfloop query="Q_luComm">	
	<input type="checkbox" name="components" value="#id#" <cfif isdefined("form.components") and listfind(form.components,id)> checked</cfif>>#descr#<cfif id EQ "99">:&nbsp;<input type="text" name="other_desc" size="50" <cfif isDefined("form.other_desc")> value="#form.other_desc#" </cfif>><cfelse><br></cfif>
</cfloop>
</td>
	</tr>
	</cfoutput>
<tr><th colspan="2"><a name="prt2"></a>Policy Implementation and Enforcement</th></tr>



<tr>
	<td valign="top">To what extent has the policy been implemented?</td>
	<td valign="top">
		<input type="radio" name="polimp" value="1" <cfif isDefined("form.polimp") and form.polimp EQ 1> Checked</cfif> > Not at all implemented<br>
		<input type="radio" name="polimp" value="0" <cfif isDefined("form.polimp") and form.polimp EQ 0> Checked</cfif> > Partially implemented <br>
		<input type="radio" name="polimp" value="2" <cfif isDefined("form.polimp") and form.polimp EQ 2> Checked</cfif> > Fully implemented
	</td>
</tr>
<tr>
	<td valign="top">To what extent has the policy been enforced?</td>
	<td valign="top">
		<input type="radio" name="polenf" value="1" <cfif isDefined("form.polenf") and form.polenf EQ 1> Checked</cfif> > Not at all enforced <br>
		<input type="radio" name="polenf" value="0" <cfif isDefined("form.polenf") and form.polenf EQ 0> Checked</cfif> > Partially enforced <br>
		<input type="radio" name="polenf" value="2" <cfif isDefined("form.polenf") and form.polenf EQ 2> Checked</cfif> > Fully enforced
	</td>
</tr>
<cfif isDefined("Q_selrecordPP1")>
<cfoutput>
<input type="hidden" name="dpass2" value="#Q_selrecordPP1.dpass#">
<input type="hidden" name="dimp2" value="#Q_selrecordPP1.dimp#">
</cfoutput>
</cfif>

<tr>
	<td colspan="2">
	Additional Comments:<br>
	<textarea name="addcomments" cols="80" rows="5"><cfif isdefined("form.addcomments")><cfoutput>#form.addcomments#</cfoutput></cfif></textarea>
	</td>
</tr>



<tr>
	<td colspan="2" align="left"><input type="button" class="AddButton" <cfif isDefined("Q_selrecordPP1") and Q_selrecordPP1.recordcount GT 0> value="Update"<cfelse> value="Add"</cfif> onClick="prcForm('AddTwo');"</td>
</tr>
</table>

<cfif QcheckPP1.recordcount GT 0>


 <table width="80%" border=".2" align="center" class="box" >
<cfoutput>
<cfloop query="QcheckPP1">

<tr bgcolor="Silver">
	<td>
	<a href="qpp3.cfm?#session.urltoken#&q=#url.q#&school=#sname#">#district_name# #InstitutionName#</a>
	</td>
	<td align="right">
		Delete?
		<input type="checkbox" name="delQPP3" value="#seq#">
	</td>
	
</tr>
</cfloop>
<tr>
	<td colspan="2"><input type="button" class="DelButton" value="Delete" onClick="prcForm('DelTwo');"></td>
</tr>

</cfoutput>
</table> 
</cfif>





<DIV align="center" ><h3>The table below shows the schedule for follow-up data reporting</div>


<table  width="80%" border=".2" align="center" class="box">
<tr>
	<th>School</th>
	<th>Quarter during which policy is implemented</th>
	<th>Quarter following policy implementation</th>
	<th>12 months after policy implementation</th>
	<th>18 months after policy implementation</th>
	<th>24 months after policy implementation</th>
</tr>

<cfquery datasource="#application.DataSource#" 	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QcheckPP3">	
select sname, year2, q, tframe
from 
sp_qpp3  s 
where s.userid='#session.userid#'
order by 1,2,3
</cfquery>

<cfquery datasource="#application.DataSource#" 	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QcheckPP2">	
select distinct s.sname, ns.InstitutionName, nd.district_name
from 
collaborators as c, sp_qpp3  s 
left outer join nysed_school  ns on ns.bedscode=s.sname 
left outer join nysed_district  nd on nd.district_id=left(s.sname,6)
where s.userid='#session.userid#'
and c.userid='#session.userid#'
and
(s.sname=c.school or
(c.school='999' and left(s.sname, 6)= c.district and sname like '%0000'))
and c.del is null
order by 2

</cfquery>

	<cfset newQ= 0>
	<cfset newYr= 1899>
	<cfset newYr2= 1899>
 
<cfif QcheckPP2.recordcount GT 0>
 
<cfoutput>
<cfloop query="QcheckPP2">

<cfquery datasource="#application.DataSource#" 	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Q_selMinDate">
	select min(year2) as minyr
	from SP_QPP3
	where 
	userid='#session.userid#'
	and sname = '#QcheckPP2.sname#'
</cfquery> 

<cfquery datasource="#application.DataSource#" 	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Q_selMinDate2">
	select year2 as minyr, min(q) as minQ, 1 as tframe
	from SP_QPP3
	where 
	userid='#session.userid#'
	and sname = '#QcheckPP2.sname#' 
	and year2=#Q_selMinDate.minyr#
	and tframe=1
	group by year2
</cfquery>

<cfif Q_selMinDate2.minyr EQ "">
<cfquery datasource="#application.DataSource#" 	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Q_selMinDate2">
	select  year2 as minyr, min(q) as minQ, 2 as tframe
	from SP_QPP3
	where 
	userid='#session.userid#'
	and sname = '#QcheckPP2.sname#' 
	and year2=#Q_selMinDate.minyr#
	and tframe=2
	group by year2
</cfquery>
<cfif Q_selMinDate2.minyr EQ "">
<cfquery datasource="#application.DataSource#" 	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Q_selMinDate2">
	select year2 as minyr, min(q) as minQ, 3 as tframe
	from SP_QPP3
	where 
	userid='#session.userid#'
	and sname = '#QcheckPP2.sname#' 
	and year2=#Q_selMinDate.minyr#
	and tframe=3
	group by year2
</cfquery>
<cfif Q_selMinDate2.minyr EQ "">
<cfquery datasource="#application.DataSource#" 	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Q_selMinDate2">
	select year2 as minyr, min(q) as minQ, 4 as tframe
	from SP_QPP3
	where 
	userid='#session.userid#'
	and sname = '#QcheckPP2.sname#' 
	and year2=#Q_selMinDate.minyr#
	and tframe=4
	group by year2
</cfquery>
<cfif Q_selMinDate2.minyr EQ "">
<cfquery datasource="#application.DataSource#" 	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Q_selMinDate2">
	select year2 as minyr, min(q) as minQ, 5 as tframe
	from SP_QPP3
	where 
	userid='#session.userid#'
	and sname = '#QcheckPP2.sname#' 
	and year2=#Q_selMinDate.minyr#
	and tframe=5
	group by year2
</cfquery>
</cfif>
</cfif>
</cfif>
</cfif>
<cfset minyr2=Q_selMinDate2.minyr>
<cfif minyr2 EQ 1904>
	<cfset minyr2=2006>
</cfif>

<tr align="center">
	<td nowrap>#InstitutionName#</td>
	
	<cfquery dbtype="query" name="sortedcheck">
SELECT * FROM QcheckPP3 
where cast(sname as varchar)='#QcheckPP2.sname#'
and cast(year2 as varchar)= '#Q_selMinDate2.minyr#'
and cast(q as varchar)='#Q_selMinDate2.minQ#'
and tframe=1
</cfquery>

	<td <cfif sortedcheck.recordcount NEQ 0> bgcolor="##CCCCCC"</cfif>>
	<cfif Q_selMinDate2.tframe EQ 1>
	FY #evaluate(minyr2-1)#-#minyr2# <br>Quarter #Q_selMinDate2.minQ#<cfif sortedcheck.recordcount NEQ 0>  &nbsp;&nbsp;&radic;</cfif>
	<cfelse>-
	</cfif>
	</td>
	
<!--- quarter following --->

<cfset dispdate = 0>
<cfif Q_selMinDate2.tframe EQ 1>
	<cfset newQ= ((Q_selMinDate2.minQ Mod 4 )+ 1)>
	<cfset newYr= minyr2 + int((Q_selMinDate2.minQ + 1)/ 4)>
	<cfset newYr2= Q_selMinDate2.minyr + int((Q_selMinDate2.minQ + 1)/ 4)>
	<cfset dispdate = 1>
<cfelseif Q_selMinDate2.tframe EQ 2>
	<cfset newQ= Q_selMinDate2.minQ>
	<cfset newYr= minyr2>
	<cfset newYr2= Q_selMinDate2.minyr>
	<cfset dispdate = 1>
</cfif>

<cfquery dbtype="query" name="sortedcheck">
SELECT * FROM QcheckPP3 
where cast(sname as varchar)='#QcheckPP2.sname#'
and cast(year2 as varchar)= '#newYr2#'
and cast(q as varchar)='#newQ#'
and tframe=2
</cfquery>

	<td	<cfif sortedcheck.recordcount NEQ 0> bgcolor="##CCCCCC"</cfif>>
	<cfif dispdate EQ 1>
	FY #evaluate(newYr-1)#-#newYr# <br>Quarter #newQ#<cfif sortedcheck.recordcount NEQ 0>  &nbsp;&nbsp;&radic;</cfif>
	<cfelse>-
	</cfif>
	</td>
	
	<!--- 12 mos --->
<cfset dispdate = 0>
<cfif Q_selMinDate2.tframe EQ 1>
	<cfset newQ= Q_selMinDate2.minQ>
	<cfset newYr= minyr2 + 1>
	<cfset newYr2= Q_selMinDate2.minyr + 1>
	<cfset dispdate = 1>
<cfelseif Q_selMinDate2.tframe EQ 2>
	<cfset newQ=(((Q_selMinDate2.minQ+2) Mod 4 )+ 1)>
	<cfset newYr= minyr2- 1 + ceiling((Q_selMinDate2.minQ + 3)/ 4)>
	<cfset newYr2=Q_selMinDate2.minyr +int((Q_selMinDate2.minQ + 3)/ 4)>
	<cfset dispdate = 1>
<cfelseif Q_selMinDate2.tframe EQ 3>
	<cfset newQ= Q_selMinDate2.minQ>
	<cfset newYr= minyr2>
	<cfset newYr2= Q_selMinDate2.minyr>
	<cfset dispdate = 1>
</cfif>

<cfquery dbtype="query" name="sortedcheck">
SELECT * FROM QcheckPP3 
where cast(sname as varchar)='#QcheckPP2.sname#'
and cast(year2 as varchar)= '#newYr2#'
and cast(q as varchar)='#newQ#'
and tframe=3
</cfquery>

<td	<cfif sortedcheck.recordcount NEQ 0> bgcolor="##CCCCCC"</cfif>>
	<cfif dispdate EQ 1>
	FY #evaluate(newYr-1)#-#newYr# <br>Quarter #newQ#<cfif sortedcheck.recordcount NEQ 0>  &nbsp;&nbsp;&radic;</cfif>
	<cfelse>-
	</cfif>
</td>
	
<!--- 18 mos --->
<cfset dispdate = 0>
<cfif Q_selMinDate2.tframe EQ 1>
	<cfset newQ= (((Q_selMinDate2.minQ+1)Mod 4)+1)>
	<cfset newYr= minyr2 - 1 + ceiling((Q_selMinDate2.minQ + 6)/ 4)>
	<cfset newYr2= Q_selMinDate2.minyr + int((Q_selMinDate2.minQ + 6)/ 4)>
	<cfset dispdate = 1>
<cfelseif Q_selMinDate2.tframe EQ 2>
	<cfset newQ=(((Q_selMinDate2.minQ) Mod 4 )+ 1)>
	<cfset newYr= minyr2- 1 + ceiling((Q_selMinDate2.minQ + 5)/ 4)>
	<cfset newYr2=Q_selMinDate2.minyr +int((Q_selMinDate2.minQ + 5)/ 4)>
	<cfset dispdate = 1>
<cfelseif Q_selMinDate2.tframe EQ 3>
	<cfset newQ=(((Q_selMinDate2.minQ+1) Mod 4 )+ 1)>
	<cfset newYr= minyr2- 1 + ceiling((Q_selMinDate2.minQ + 2)/ 4)>
	<cfset newYr2=Q_selMinDate2.minyr +int((Q_selMinDate2.minQ + 2)/ 4)>
	<cfset dispdate = 1>
<cfelseif Q_selMinDate2.tframe EQ 4>
	<cfset newQ= Q_selMinDate2.minQ>
	<cfset newYr= minyr2>
	<cfset newYr2= Q_selMinDate2.minyr>
	<cfset dispdate = 1>
</cfif>

<cfquery dbtype="query" name="sortedcheck">
SELECT * FROM QcheckPP3 
where cast(sname as varchar)='#QcheckPP2.sname#'
and cast(year2 as varchar)= '#newYr2#'
and cast(q as varchar)='#newQ#'
and tframe=4
</cfquery>

<td	<cfif sortedcheck.recordcount NEQ 0> bgcolor="##CCCCCC"</cfif>>
	<cfif dispdate EQ 1>
	FY #evaluate(newYr-1)#-#newYr# <br>Quarter #newQ#<cfif sortedcheck.recordcount NEQ 0>  &nbsp;&nbsp;&radic;</cfif>
	<cfelse>-
	</cfif>
</td>

<!--- 24 mos --->
<cfset dispdate = 0>
<cfif Q_selMinDate2.tframe EQ 1>
	<cfset newQ= Q_selMinDate2.minQ>
	<cfset newYr= minyr2 + 2>
	<cfset newYr2= Q_selMinDate2.minyr + 2>
	<cfset dispdate = 1>
<cfelseif Q_selMinDate2.tframe EQ 2>
	<cfset newQ= (((Q_selMinDate2.minQ+2) Mod 4 )+ 1)>
	<cfset newYr= minyr2 - 1 + ceiling((Q_selMinDate2.minQ + 7)/ 4)>
	<cfset newYr2=Q_selMinDate2.minyr +int((Q_selMinDate2.minQ + 7)/ 4)>
	<cfset dispdate = 1>
<cfelseif Q_selMinDate2.tframe EQ 3>
	<cfset newQ=Q_selMinDate2.minQ>
	<cfset newYr= minyr2+ 1>
	<cfset newYr2=Q_selMinDate2.minyr +1>
	<cfset dispdate = 1>
<cfelseif Q_selMinDate2.tframe EQ 4>
	<cfset newQ= (((Q_selMinDate2.minQ + 1) MOD 4) + 1)>
	<cfset newYr= minyr2- 1 + ceiling((Q_selMinDate2.minQ + 2)/ 4)>
	<cfset newYr2= Q_selMinDate2.minyr+int((Q_selMinDate2.minQ + 2)/ 4)>
	<cfset dispdate = 1>
<cfelseif Q_selMinDate2.tframe EQ 5>
	<cfset newQ= Q_selMinDate2.minQ>
	<cfset newYr= minyr2>
	<cfset newYr2= Q_selMinDate2.minyr>
	<cfset dispdate = 1>
</cfif>

<cfquery dbtype="query" name="sortedcheck">
SELECT * FROM QcheckPP3 
where cast(sname as varchar)='#QcheckPP2.sname#'
and cast(year2 as varchar)= '#newYr2#'
and cast(q as varchar)='#newQ#'
and tframe=5
</cfquery>

<td	<cfif sortedcheck.recordcount NEQ 0> bgcolor="##CCCCCC"</cfif>>
	<cfif dispdate EQ 1>
	FY #evaluate(newYr-1)#-#newYr# <br>Quarter #newQ#<cfif sortedcheck.recordcount NEQ 0>  &nbsp;&nbsp;&radic;</cfif>
	<cfelse>-
	</cfif>
</td>
	
</tr>
 
</cfloop> 
</cfoutput>
</cfif> 
 
</table>

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
<script language="JavaScript">
checkbaseline();
</script>	
</cfform>
<div align="center"><input type="button" value="Save and Return to Main Screen" onClick="returnMenu();"></div>
</body>
<cfinclude template="quarterly_extm.cfm">
</html>
