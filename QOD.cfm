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
for(var intloop=0; intloop <document.fqod.length; intloop++){
document.fqod[intloop].disabled=true;
}
}

function returnMenu(){
document.fqod.action = "QSP_menu.cfm";
document.fqod.submit();
}

function prcForm(what){
if (what == "Add"){

if (document.fqod.sname.value=='999'){
alert('Please select a school or district');
	return false;
}
document.fqod.action = "prc_qod.cfm";
if (_CF_checkfqod(document.fqod)){



var checkStat=0;
for (var i=0; i < document.fqod.tframe.length; i++)
   {
   if (document.fqod.tframe[i].checked)
      {
      checkStat= checkStat+1;	 
      }
   }
   if (checkStat==0) {
   alert('Please indicate the timeframe of observation');
	return false;
   }
   
  checkStat=0;
for (var i=0; i < document.fqod.post_main.length; i++)
   {
   if (document.fqod.post_main[i].checked)
      {
      checkStat= checkStat+1;	 
      }
   }
   if (checkStat==0) {
   alert('Please select a reponse to each question about tobacco-free signs');
	return false;
   }
   
     checkStat=0;
for (var i=0; i < document.fqod.post_other.length; i++)
   {
   if (document.fqod.post_other[i].checked)
      {
      checkStat= checkStat+1;	 
      }
   }
   if (checkStat==0) {
   alert('Please select a reponse to each question about tobacco-free signs');
	return false;
   }
   
     checkStat=0;
for (var i=0; i < document.fqod.post_athletic.length; i++)
   {
   if (document.fqod.post_athletic[i].checked)
      {
      checkStat= checkStat+1;	 
      }
   }
   if (checkStat==0) {
   alert('Please select a reponse to each question about tobacco-free signs');
	return false;
   }
   
  checkStat=0;
for (var i=0; i < document.fqod.tu_evid.length; i++)
   {
   if (document.fqod.tu_evid[i].checked)
      {
      checkStat= checkStat+1;	 
      }
   }
   if (checkStat==0) {
   alert('Please respond to the question about evidence of tobacco use');
	return false;
   }
   
  checkStat=0;
for (var i=0; i < document.fqod.tframe.length; i++)
   {
   if (document.fqod.tframe[i].checked)
      {
      checkStat= checkStat+1;	 
      }
   }
   if (checkStat==0) {
   alert('Please indicate the timeframe of observation');
	return false;
   }
   
<cfif isDefined("form.tu_evid") and form.tu_evid EQ 1 and session.fy GT 2008>
	checkStat=0;
for (var i=0; i < document.fqod.tu_butt.length; i++)
   {
   if (document.fqod.tu_butt[i].checked)
      {
      checkStat= checkStat+1;	 
      }
   }
   <!--- if (checkStat==0) {
   alert('Please indicate the number of butts observed');
	return false;
   }  --->  
</cfif>
document.fqod.submit();
}
}
if (what == "Del"){
document.fqod.action = "prc_qod.cfm?Del=Y";
document.fqod.submit();
}
if (what == "refr"){
document.fqod.action = "QOD.cfm?<cfoutput>#session.urltoken#&Q=#url.q#</cfoutput>";
document.fqod.submit();
}
}

function validateSelection(ele){
	var tempa=ele + 'a';
	var tempb=ele + 'b';
	var tempc=ele + 'c';
	var tempd=ele + 'd';
	var tempe=ele + 'e';
if(document.getElementById(ele).checked==false){
	
	if ((document.getElementById(tempa).checked==true)||(document.getElementById(tempb).checked==true)||(document.getElementById(tempc).checked==true)||(document.getElementById(tempd).checked==true)||(document.getElementById(tempe).checked==true)){
	alert ('You must deselect the items to the right before you can indicate that there is not any evidence.');
	document.getElementById(ele).checked=true;
	return false;
	}
	document.getElementById(tempa).disabled=true;
	document.getElementById(tempb).disabled=true;
	document.getElementById(tempc).disabled=true;
	document.getElementById(tempd).disabled=true;
	document.getElementById(tempe).disabled=true; 
	
}
else{
	document.getElementById(tempa).disabled=false;
	document.getElementById(tempb).disabled=false;
	document.getElementById(tempc).disabled=false;
	document.getElementById(tempd).disabled=false;
	document.getElementById(tempe).disabled=false; 
}
}
</script>



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
</cfquery>
<cfquery datasource="#application.DataSource#" 	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qschool">
	select nces_id_code, agency_name, school_name
	from schools
	order by school_name
</cfquery> --->
<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qcollab_district">
	select distinct district
	from collaborators
	where userid='#session.userid#'
	and (del is null or del !=1)
	and school = '999'
	<!--- and year2=#session.fy# --->
	order by 1
</cfquery>
<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qcollab_school">
	select distinct school
	from collaborators
	where userid='#session.userid#'
	and (del is null or del !=1)
	<!--- and year2=#session.fy# --->
	order by 1
</cfquery>
 
 <cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qschool">
	select bedscode,institutionName, district
	from nysed_school
	where <!--- district_code in (#valuelist(Qcollab_district.district)#)	
	and ---> bedscode in  (<cfif Qcollab_school.recordcount EQ 0>'0'<cfelse>#quotedvaluelist(Qcollab_school.school)#</cfif> )
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
	<!---( district in (<cfif Qschool.recordcount GT 0>#quotedvaluelist(Qschool.district)#<cfelse>'0'</cfif>) and bedscode like '%0000')
	or --->
	(district in (<cfif Qcollab_district.recordcount GT 0> #quotedvaluelist(Qcollab_district.district)#<cfelse>'0'</cfif>)and bedscode like '%0000')
	)
	and d.district_id=s.district
	order by 5,1,3
</cfquery>



<cfquery datasource="#application.DataSource#" 	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qevidence">
	<cfif Session.fy GT 2008>
		
	select descrip, num, hdescrip
	from lu_evidence e, lu_evidence_head h
	where e.year2=#session.fy#
	and year2=hyear2
	and hnum=heading
	order by hrank, rank	
	<cfelse>
	
	select descrip, num
	from lu_evidence
	where year2=#session.fy#
	order by rank
	</cfif>
</cfquery>

<cfquery datasource="#application.DataSource#" 	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QselQOD">
select s.seq, s.sname, ns.InstitutionName, nd.district_name, s.dateob
from 
sp_qod  s 
left outer join nysed_school  ns on ns.bedscode=s.sname 
left outer join nysed_district  nd on nd.district_id=left(s.sname,6)
where s.userid='#session.userid#'
and s.year2=#session.fy#
and s.q=#url.q#
order by s.seq
</cfquery>

<cfif isDefined("url.sec") and url.sec EQ 1>
<cfquery datasource="#application.DataSource#" 	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Q_selrecordPP1">
	select 
	sname,
	dateob,
	tframe,
	post_main, post_main_bld,
	post_other,
	post_athletic,
	tu_evid,tu_butt,
	evidobr,
	evidother,
	other_evid_txt,
	seq
	from SP_QOD
	where 
	userid='#session.userid#'
	and year2=#session.fy#
	and Q=#url.q#
	and sname = '#url.school#'
	and seq=#url.seq2#
</cfquery>

<cfset form.sname=Q_selrecordPP1.sname>
<cfset form.dateob=dateformat(Q_selrecordPP1.dateob, "m/d/yyyy")>
<cfset form.tframe=Q_selrecordPP1.tframe>
<cfset form.post_main=Q_selrecordPP1.post_main>
<cfset form.post_main_bld=Q_selrecordPP1.post_main_bld>
<cfset form.post_other=Q_selrecordPP1.post_other>
<cfset form.post_athletic=Q_selrecordPP1.post_athletic>
<cfset form.tu_evid=Q_selrecordPP1.tu_evid>
<cfset form.tu_butt=Q_selrecordPP1.tu_butt>
<cfset form.evidobr=Q_selrecordPP1.evidobr>
<cfset form.evidother=Q_selrecordPP1.evidother>
<cfset form.other_evid_txt=Q_selrecordPP1.other_evid_txt>

<!--- <cfset form.seq=Q_selrecordPP1.seq> --->
</cfif>

<DIV align="center" ><h3>Outcome Data: Quarter <cfoutput>#url.Q#</cfoutput></h3></DIV>

<cfform name="fqod">
<input type="hidden" name="Q" <cfoutput>value="#url.Q#"</cfoutput>>
<table width="80%" border=".2" align="center" class="box">
<tr><th colspan="3">Observational Data Summary</th></tr>

<tr>
	<td colspan="2">School or District Name</td>
<td><cfif isDefined("url.stip_seq")>
		<cfselect name="sname" group="dn" query="Qdistrict" value="bedscode" display="institutionname" queryPosition="below" selected="#Qselectedstip.school_stip#" >
		<option value="999"><strong>Please select a School or District</strong></option>
	</cfselect>
	<cfelseif isDefined("form.sname")>
		<cfselect name="sname" group="dn" query="Qdistrict" value="bedscode" display="institutionname" queryPosition="below" selected="#form.sname#" >
		<option value="999"><strong>Please select a School or District</strong></option>
	</cfselect>
	<cfelse>
		<cfselect name="sname" group="dn" query="Qdistrict" value="bedscode" display="institutionname" queryPosition="below">
		<option value="999"><strong>Please select a School or District</strong></option>
	</cfselect>
	</cfif>
</td></tr>
<tr>
	<td colspan="2">Date of Observation</td>
	<td>
	<cfif isDefined("form.dateob")>
	<cfinput type="text" name="dateOb" validate="date" required="yes" message="Please enter a valid date format" value="#form.dateob#">
	<cfelse>
	<cfinput type="text" name="dateOb" validate="date" required="yes" message="Please enter a valid date format">
	</cfif>
	</td>
</tr>
<tr>
	<td colspan="2" valign="top">Timeframe of Observation</td>
	<td valign="top">
		<input type="radio" name="tframe" value="1"<cfif isDefined("form.tframe") and form.tframe EQ 1> checked</cfif>> Baseline 1<br>
		<input type="radio" name="tframe" value="20"<cfif isDefined("form.tframe") and form.tframe EQ 20> checked</cfif>> Baseline 2<br>
		<input type="radio" name="tframe" value="2"<cfif isDefined("form.tframe") and form.tframe EQ 2> checked</cfif>> 3 month follow up	<br>
		<input type="radio" name="tframe" value="3"<cfif isDefined("form.tframe") and form.tframe EQ 3> checked</cfif>> 12 month follow up		<br>
		<input type="radio" name="tframe" value="4"<cfif isDefined("form.tframe") and form.tframe EQ 4> checked</cfif>> 24 month follow up		<br>
		<input type="radio" name="tframe" value="0"<cfif isDefined("form.tframe") and form.tframe EQ 0> checked</cfif>> Other	
	</td>
</tr>
<tr>
	<td colspan="2" valign="top">Were tobacco-free signs posted at any of the following locations?</td>
	<td>&nbsp;</td>
</tr>
<tr>
	<td width="25">&nbsp; </td>
	<td valign="top">Main entrances to school buildings</td>
	<td valign="top">
		<input type="radio" name="post_main_bld" value="1"<cfif isDefined("form.post_main_bld") and form.post_main_bld EQ 1> checked</cfif>>Yes&nbsp;&nbsp;&nbsp;
		<input type="radio" name="post_main_bld" value="0"<cfif isDefined("form.post_main_bld") and form.post_main_bld EQ 0> checked</cfif>>No
	</td>
</tr>

<tr>
	<td width="25">&nbsp; </td>
	<td valign="top">Main entrances to school grounds</td>
	<td valign="top">
		<input type="radio" name="post_main" value="1"<cfif isDefined("form.post_main") and form.post_main EQ 1> checked</cfif>>Yes&nbsp;&nbsp;&nbsp;
		<input type="radio" name="post_main" value="0"<cfif isDefined("form.post_main") and form.post_main EQ 0> checked</cfif>>No
	</td>
</tr>

<tr>
	<td>&nbsp; </td>
	<td valign="top">All other entrances to the schools</td>
	<td valign="top">
		<input type="radio" name="post_other" value="1"<cfif isDefined("form.post_other") and form.post_other EQ 1> checked</cfif>>Yes&nbsp;&nbsp;&nbsp;
		<input type="radio" name="post_other" value="0"<cfif isDefined("form.post_other") and form.post_other EQ 0> checked</cfif>>No
	</td>
</tr>
<tr>
	<td>&nbsp; </td>
	<td valign="top">All outdoor athletic fields</td>
	<td valign="top">
		<input type="radio" name="post_athletic" value="1"<cfif isDefined("form.post_athletic") and form.post_athletic EQ 1> checked</cfif>>Yes&nbsp;&nbsp;&nbsp;
		<input type="radio" name="post_athletic" value="0"<cfif isDefined("form.post_athletic") and form.post_athletic EQ 0> checked</cfif>>No&nbsp;&nbsp;&nbsp;
		<input type="radio" name="post_athletic" value="2"<cfif isDefined("form.post_athletic") and form.post_athletic EQ 2> checked</cfif>>NA
	</td>
</tr>
<tr>
	<td colspan="2" valign="top">Was there any evidence of tobacco use on school property?
	<cfif session.fy GT 2008><br>If yes, where was evidence of tobacco use observed? (check all that apply)</cfif>
	</td>
	<td valign="top">
		<input type="radio" name="tu_evid" value="1"<cfif isDefined("form.tu_evid") and form.tu_evid EQ 1> checked</cfif> onClick="prcForm('refr');">Yes&nbsp;&nbsp;&nbsp;
		<input type="radio" name="tu_evid" value="0"<cfif isDefined("form.tu_evid") and form.tu_evid EQ 0> checked</cfif> onClick="prcForm('refr');">No
	</td>
</tr>
<cfif isDefined("form.tu_evid") and form.tu_evid EQ 1 and session.fy GT 2008>
<tr>
	<td>&nbsp;</td>
	<!--- <td valign="top">If yes, where was evidence of tobacco use observed? (check all that apply)</td> --->
	<td colspan="2" valign="top">
		<table  border=".2" class="box"<!--- class="detlist" --->>
			<tr>
				<th valign="bottom">Any Evidence</th>
				<th valign="bottom">Location</th>
				<th valign="bottom" width="60">See anyone smoking or using tobacco</th>
				<th valign="bottom"  width="60">Smell tobacco</th>
				<th valign="bottom" width="60">Butts, matches, ashes</th>
				<th valign="bottom" width="60">Spit cans, chew/spit stains, or mounds of tobacco</th>
				<th valign="bottom" width="60">Ceiling panels moved / out of place</th>				
			</tr>
		
	<cfoutput  query="Qevidence" group="hdescrip">
		<tr>
			<td></td>
			<th>#hdescrip#</th>
			<td colspan="5"></td>
		</tr>
	<cfoutput>
	<tr bgcolor="###iif(currentrow MOD 2,DE('ffffff'),DE('efefef'))#">
		<td align="center"><input type="checkbox" name="evidobr" id="#num#" value="#num#" <cfif isDefined("form.evidobr") and listfind(form.evidobr,num)> checked</cfif> onclick="validateSelection('#num#');"></td>
		<td>#descrip#</td>
		<td align="center"><input type="checkbox" name="evidobr"  id="#num#a" value="#num#a" <cfif isDefined("form.evidobr") and listfind(form.evidobr,num & 'a')> checked</cfif> <cfif (isDefined("form.evidobr") and NOT listfind(form.evidobr,num)) or NOT isDefined("form.evidobr")> disabled</cfif>></td>
		<td align="center"><input type="checkbox" name="evidobr"  id="#num#b" value="#num#b" <cfif isDefined("form.evidobr") and listfind(form.evidobr,num & 'b')> checked</cfif> <cfif (isDefined("form.evidobr") and NOT listfind(form.evidobr,num)) or NOT isDefined("form.evidobr")> disabled</cfif>></td>
		<td align="center"><input type="checkbox" name="evidobr"  id="#num#c" value="#num#c" <cfif isDefined("form.evidobr") and listfind(form.evidobr,num & 'c')> checked</cfif> <cfif (isDefined("form.evidobr") and NOT listfind(form.evidobr,num)) or NOT isDefined("form.evidobr")> disabled</cfif>></td>
		<td align="center"><input type="checkbox" name="evidobr"  id="#num#d" value="#num#d" <cfif isDefined("form.evidobr") and listfind(form.evidobr,num & 'd')> checked</cfif> <cfif (isDefined("form.evidobr") and NOT listfind(form.evidobr,num)) or NOT isDefined("form.evidobr")> disabled</cfif>></td>
		<td align="center"><input type="checkbox" name="evidobr"  id="#num#e" value="#num#e" <cfif isDefined("form.evidobr") and listfind(form.evidobr,num & 'e')> checked</cfif> <cfif (isDefined("form.evidobr") and NOT listfind(form.evidobr,num)) or NOT isDefined("form.evidobr")> disabled</cfif>></td>
		
	</tr>
	</cfoutput>
	</cfoutput>
	</table>
	</td>
</tr>
<cfif session.fy GT 2008>
<tr>
	<td colspan="2" valign="top">How many cigarette butts were observed at the locations overall?
	</td>
	<td valign="top">
		<input type="radio" name="tu_butt" value="0"<cfif isDefined("form.tu_butt") and form.tu_butt EQ 0> checked</cfif> >None<br>
		<input type="radio" name="tu_butt" value="1"<cfif isDefined("form.tu_butt") and form.tu_butt EQ 1> checked</cfif> >Less than 10<br>
		<input type="radio" name="tu_butt" value="2"<cfif isDefined("form.tu_butt") and form.tu_butt EQ 2> checked</cfif> >10-30<br>
		<input type="radio" name="tu_butt" value="3"<cfif isDefined("form.tu_butt") and form.tu_butt EQ 3> checked</cfif> >31-50<br>
		<input type="radio" name="tu_butt" value="4"<cfif isDefined("form.tu_butt") and form.tu_butt EQ 4> checked</cfif> >51-100<br>
		<input type="radio" name="tu_butt" value="5"<cfif isDefined("form.tu_butt") and form.tu_butt EQ 5> checked</cfif> >More than 100
	</td>
</tr>

</cfif>
<cfelseif  isDefined("form.tu_evid") and form.tu_evid EQ 1>
<tr>
	<td>&nbsp;</td>
	<td valign="top">If yes, where was evidence of tobacco use observed? (check all that apply)</td>
	<td valign="top"><cfoutput>
	<cfloop query="Qevidence">
	<input type="checkbox" name="evidobr" value="#num#" <cfif isDefined("form.evidobr") and listfind(form.evidobr,num)> checked</cfif>>#descrip#&nbsp;<cfif descrip EQ "other"><input name="other_evid_txt" type="text" value="<cfif isDefined("form.other_evid_txt")><cfoutput>#form.other_evid_txt#</cfoutput></cfif>" size="50"></cfif><br>
	</cfloop>
	</cfoutput>
	</td>
</tr>


</cfif>


<tr>
	<td colspan="3" align="left">
	<!--- <input type="button" class="AddButton" value="Add" onClick="prcForm('Add');"> --->
	<input type="button" class="AddButton" <cfif isDefined("url.sec")> value="Update"<cfelse> value="Add"</cfif> onClick="prcForm('Add');">
	</td>
</tr>
<cfif QselQOD.recordcount GT 0>
<cfoutput>
<cfloop query="QselQOD">
<tr bgcolor="Silver">
	<td colspan="2">
	<a href="qod.cfm?#session.urltoken#&q=#url.q#&school=#sname#&seq2=#seq#&sec=1">#district_name# #InstitutionName# #dateformat(dateob,'mmm dd yyyy')#</a>
	</td>
	<td align="right">
		Delete?
		<input type="checkbox" name="delQOD" value="#seq#">
	</td>
	
</tr>
</cfloop></cfoutput>
<tr>
	<td colspan="3" align="left">
	<!--- <input type="button" class="AddButton" value="Add" onClick="prcForm('Add');"> --->
	<input type="button" class="DelButton" value="Delete" onClick="prcForm('Del');">
	</td>
</tr>
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

</cfform>
<div align="center"><input type="button" value="Save and Return to Main Screen" onClick="returnMenu();"></div>

</body>
<cfinclude template="quarterly_extm.cfm">
</html>
