<!---<cfif session.fy gte 2011 and session.userid neq 'dplotner'>
	<cflocation url="unavailable2.cfm" addtoken="true">
	</cfif>
	--->
<cfparam name="targDisp2" default="">
<cfparam name="form.targmhs" default="">
<cfparam name="form.satoff" default="">
<cfparam name="form.typehc" default="">
<cfparam name="form.askwritten" default="">
<cfparam name="form.askEHR" default="">
<cfparam name="form.askStandard" default="">
<cfparam name="form.askwritten" default="">
<cfparam name="form.askEHR" default="">
<cfparam name="form.askStandard" default="">
<cfparam name="targdisp2" default="">
<cfparam name="form.so1" default="">
<cfparam name="form.so2" default="">
<cfparam name="form.city" default="">
<cfparam name="form.dcs" default="">
<cfparam name="form.dcsdesc" default="">
<cfparam name="form.county" default="">
<cfparam name="form.targdisp1" default="">
<cfparam name="form.advjustone" default="">
<cfparam name="form.advjusttwo" default="">
<cfparam name="form.advjustthree" default="">
<cfparam name="form.advjustfour" default="">
<cfparam name="form.targoth" default="">
<cfparam name="form.cmdescr" default="">
<cfparam name="form.cmjustother" default="">
<cfparam name="form.chc" default="">
<cfparam name="form.pros" default="">
<cfparam name="form.hcpo" default="">
<cfparam name="form.cmjustone" default="">
<cfparam name="form.cmjusttwo" default="">
<cfparam name="form.cmjustthree" default="">
<cfparam name="form.cmjustfour" default="">
<cfparam name="advoc" default="">
<cfparam name="advocdesc" default="">
<cfparam name="govt" default="">
<cfparam name="govtdesc" default="">
<cfparam name="comm" default="">
<cfparam name="commdesc" default="">
<cfparam name="media" default="">
<cfparam name="form.mediadesc" default="">
<cfparam name="mediadesc" default="">
<cfparam name="cm" default="">
<cfparam name="form.cmdesc" default="">
<cfparam name="cmdesc" default="">
<cfparam name="commmob" default="">
<cfparam name="commmobdesc" default="">
<cfparam name="addlso" default="">
<cfparam name="addlsotxt" default="">
<cfparam name="form.reqinit" default="">
<cfparam name="form.dispar" default="">
<cfparam name="form.dispartxt" default="">
<cfparam name="form.regdesc" default="">
<cfparam name="form.statedesc" default="">
<cfparam name = "form.DispInit" default = "">
<cfparam name = "form.othdisptxt" default = "">
<cfif (isDefined("form.addCM") or isDefined("form.addgovOrg") or isDefined("form.addadvOrg")) and session.objnum is not '1a' and session.objnum is not '1g' and session.objnum is not '1e' and session.objnum is not '1h'>
	<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="GetEmailStats">
select
c.orgname,c.partnertype, c.coordemail as partneremail,
case c.partnertype
when 1 then '#session.MM1#'
when 2 then '#session.MM2#'
when 6 then '#session.MM6#'
else NULL end as mmanager,
m.email as cmanager
from contact c, contact m
where m.userid=c.cmanager
and c.partnertype in (1,2,3)
and c.userid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#session.userid#">
</cfquery>
	<Cfset mailType= 'A'>
	<cfif isDefined("form.addCM")>
		<cfif form.addCM EQ 'Update'>
			<Cfset mailType= 'U'>
		<cfelse>
			<Cfset mailType= 'A'>
		</cfif>
		<cfif isdefined("form.targ0") and form.targ0 EQ 1>
			<cfset emailTarg="Youth Focused Organization">
		<cfelseif isdefined("form.targ0") and  form.targ0 EQ 2>
			<cfset emailTarg="Other">
		<cfelse>
			<cfset emailTarg="">
		</cfif>
		<cfset emailOrg = #form.oName0#>
	<cfelseif isDefined("form.addgovOrg") or isDefined("form.addadvOrg")>
		<cfif (isDefined("form.addgovOrg") and form.addgovOrg EQ 'Update') OR (isDefined("form.addadvOrg") and form.addadvOrg EQ 'Update')>
			<Cfset mailType= 'U'>
		<cfelse>
			<Cfset mailType= 'A'>
		</cfif>
		<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="targgpme">
	select target
	from wrkplan_targets
where year2=<cfqueryPARAM value = "#session.fy#" CFSQLType = "CF_SQL_INTEGER">
and targetid = <cfif isDefined("form.addgovOrg")><cfqueryPARAM value = "#form.targz#" CFSQLType = "CF_SQL_INTEGER">
<cfelse><cfqueryPARAM value = "#form.targ#" CFSQLType = "CF_SQL_INTEGER"></cfif>
order by target
</cfquery>
		<cfset emailTarg=#targgpme.target#>
		<cfif isDefined("form.addgovOrg")>
			<cfset emailOrg="#form.gName#">
		<cfelse>
			<cfset emailOrg="#form.oName#">
		</cfif>
	</cfif>
	<cfif GetEmailStats.recordcount NEQ 0>
		<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="getmailInit">
	select
initiative
from objectives as o
where
o.year2=<cfqueryPARAM value = "#session.fy#" CFSQLType = "CF_SQL_INTEGER">
and o.id=<cfqueryparam value="#form.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="3">
and (o.del is null or o.del !=1) and  (modality like '%99%' or modality like '%#session.modality#%')
</cfquery>
		<cfif mailtype EQ "A">
			<cfmail from="NY Tobacco Control Program <NY-Tobacco-Control-Program@rti.org>"
to="#GetEmailStats.cmanager#; #GetEmailStats.mmanager#"
subject="#session.orgname# – new target entry" type="HTML">
#session.orgname# has added <strong>#emailOrg#</strong> as a <em>#emailTarg#</em> target to the #getmailInit.initiative# initiative.
<br><br>
</cfmail>
		<cfelse>
			<cfset fieldUPDS = "">
			<cfif isDefined("form.addCM")>
				<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="qcheckOld">
	select targnum, name, descrip
	from target_org
	where targid=<cfqueryPARAM value = "#form.targid0#" CFSQLType = "CF_SQL_INTEGER">
	and userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	order by name
</cfquery>
				<cfif qcheckOld.recordcount NEQ 0>
					<cfset fieldUPDS = "">
					<cfif form.targ0 NEQ qcheckOld.targnum>
						<cfset fieldUPDS = fieldUPDS & " 'Target Type'">
					</cfif>
					<cfif form.oname0 NEQ qcheckOld.name>
						<cfset fieldUPDS = fieldUPDS & " 'Target Name'">
					</cfif>
					<cfif form.CMdescr NEQ qcheckOld.descrip>
						<cfset fieldUPDS = fieldUPDS & " 'Target Description'">
					</cfif>
				</cfif>
			<cfelseif isDefined("form.addgovOrg")>
				<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="qcheckOld">
	select targnum, name
	from target_org
	where targid=<cfqueryPARAM value = "#form.targid0#" CFSQLType = "CF_SQL_INTEGER">
	and userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	order by name
</cfquery>
				<cfif qcheckOld.recordcount NEQ 0>
					<cfset fieldUPDS = "">
					<cfif form.targz NEQ qcheckOld.targnum>
						<cfset fieldUPDS = fieldUPDS & " 'Target Type'">
					</cfif>
					<cfif form.gname NEQ qcheckOld.name>
						<cfset fieldUPDS = fieldUPDS & " 'Target Name'">
					</cfif>
				</cfif>
			<cfelseif isDefined("form.addadvOrg")>
				<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="qcheckOld">
	select targnum, name, county
	from target_org
	where targid=<cfqueryPARAM value = "#form.targid0#"
    CFSQLType = "CF_SQL_INTEGER">
	and userid = <cfqueryparam  value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	order by name
</cfquery>
				<cfif qcheckOld.recordcount NEQ 0>
					<cfset fieldUPDS = "">
					<cfif form.targ NEQ qcheckOld.targnum>
						<cfset fieldUPDS = fieldUPDS & " 'Target Type'">
					</cfif>
					<cfif form.oname NEQ qcheckOld.name>
						<cfset fieldUPDS = fieldUPDS & " 'Target Name'">
					</cfif>
					<cfif isDefined("form.county") and form.county NEQ qcheckOld.county>
						<cfset fieldUPDS = fieldUPDS & " 'County'">
					</cfif>
				</cfif>
				<!--- <cfelseif isDefined("form.addadvOrg")>
					<cfquery datasource="#Application.DataSource#"
					password="#Application.db_password#"
					username="#Application.db_username#" name="qcheckOld">
					select targnum, name, county
					from target_org
					where targid=#form.targid0#
					and userid = '#session.userid#'
					</cfquery> --->
			</cfif>
			<cfmail from="NY Tobacco Control Program <NY-Tobacco-Control-Program@rti.org>"
to="#GetEmailStats.cmanager#; #GetEmailStats.mmanager#"
bcc="dplotner@rti.org; twills@rti.org"
subject="#session.orgname# – change to target entry" type="HTML">
#session.orgname# has edited <strong>#emailOrg#</strong> in the #getmailInit.initiative# initiative. This field was edited: #fieldUPDS#.
<br><br>
</cfmail>
		</cfif>
	</cfif>
</cfif>
<style>
	.box { font-family: verdana, helvetica, sans-serif; font-size: 11px; border: solid 1px #CCCC99; list-style:inherit } .boxy { font-family: verdana, helvetica, sans-serif; font-size: 11px; list-style:inheritborder-color : #498F49; } .box2 { font-family: verdana, helvetica, sans-serif; font-size: 11px; border: none; list-style:inherit }
</style>
<cfif isdefined("form.objval") or isdefined("url.objval")>
	<cfif isdefined("form.objval")>
		<cfset session.objval = '#form.objval#'>
	<cfelseif isdefined("url.objval")>
		<cfset session.objval = '#url.objval#'>
	</cfif>
</cfif>
<SCRIPT LANGUAGE="JavaScript" SRC="scripts/cfform.js"></SCRIPT>
<cfif session.fy LT 2007 and session.fy GT 1920>
	<cfinclude template="cat_annual_goal.cfm">
<cfelse>
	<!---
		<cfif  session.fy GT session.def_fy and  session.nextyr NEQ 1>
		<cflocation addtoken="yes" url="noFuture.cfm">
		</cfif>--->
</cfif>
<!--- <cfput>#session.objval#</cfput><cfabort> --->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>
			CAT
		</title>
	<body>
		<cfinclude template="CATstruct.cfm">
		<script language="JavaScript" src="../spellchecker/spell.js"></script>
		<script language="JavaScript">
	 function toggle_visibility1(id) {
 	     var e = document.getElementById(id);
	     var advo = document.wrk.advoc.checked;
		 if(advo == true){
       if(e.style.display == 'block')
          e.style.display = 'none';
       else
          e.style.display = 'block';
		  }
		  else
		  {
		  e.style.display = 'none';
		  }}
	  function toggle_visibility(id) {
 	     var e = document.getElementById(id);
	     var reqinit = document.wrk.reqinit[1].checked;
		 if(reqinit == true){
       if(e.style.display == 'block')
          e.style.display = 'none';
       else
          e.style.display = 'block';
		  }
		  else
		  {
		  e.style.display = 'none';
		  }
		  }
	function confirmDel(){
	var answer = confirm("WARNING: Deleting this target will also delete all of this target's entries in monthly reports.")
	if (answer){
		return checkMGG();
	}
	else{
		return false;
	}
	}
	function confirmDel2(){
	var answer = confirm("WARNING: Deleting this target will also delete all of this target's entries in monthly reports.")
	if (answer){
		return checkGGG();
	}
	else{
		return false;
	}
	}
	function confirmDelx(){
	var answer = confirm("WARNING: Deleting this target will also delete all of this target's entries in monthly reports.")
	if (answer){
		return true;
	}
	else{
		return false;
	}
	}
function checkBaseline(){
	var a= 0;
for(var i = 0; i < document.wrk.askWritten.length; i++) {
    if ( document.wrk.askWritten[i].checked) {
        // get value, set checked flag or do whatever you need to
       a=a+1;
    }
 }
 for(var i = 0; i < document.wrk.askEHR.length; i++) {
    if ( document.wrk.askEHR[i].checked) {
        // get value, set checked flag or do whatever you need to
       a=a+1;
    }
 }

 for(var i = 0; i < document.wrk.askStandard.length; i++) {
    if ( document.wrk.askStandard[i].checked) {
        // get value, set checked flag or do whatever you need to
       a=a+1;
    }
 }
if (a > 0){
document.getElementById("noPol").disabled = true;
}
else {
document.getElementById("noPol").disabled = false;
}
}
function disableme(){
for(var intloop=0; intloop <document.wrk.length; intloop++){
	if(document.wrk[intloop].type=='textarea'){
	document.monthlyActivity[intloop].readOnly = true;
	}
	else
document.wrk[intloop].disabled=true;
}
document.wrk.ObjVal.disabled=false;
}
function countit(what){
//Character count script- by javascriptkit.com
//Visit JavaScript Kit (http://javascriptkit.com) for script
//Credit must stay intact for use

formcontent=what.form.advocdesc.value
what.form.advdisplaycount.value=formcontent.length
}



function countit1(what){
formcontent=what.form.dispartxt.value
what.form.dispardisplaycount.value=formcontent.length
}

<cfif isdefined("session.objnum") <!--- and #session.objnum# is not '1E' ---> and  (#session.objnum# is  '2d' or #session.objnum# is  '2e' or #session.objnum# is  '4F' or #session.objnum# is  '8A' or #session.objnum# is  '8B') and session.modality NEQ 6>
function countit0(what){
formcontent=what.form.commmobdesc.value
what.form.commmobdisplaycount.value=formcontent.length
}
</cfif>

<cfif isdefined("session.objnum") <!--- and #session.objnum# is not '1E' ---> and  #session.objnum# is not '1A' and session.modality NEQ 6>
function countit2(what){
formcontent=what.form.govtdesc.value
what.form.govtdisplaycount.value=formcontent.length
}
</cfif>

<cfif  session.modality NEQ 6>
function countit3(what){
formcontent=what.form.commdesc.value
what.form.commdisplaycount.value=formcontent.length
}
function countit4(what){
formcontent=what.form.mediadesc.value
what.form.meddisplaycount.value=formcontent.length
}
function countit5(what){
formcontent=what.form.out.value
what.form.outdisplaycount.value=formcontent.length
}
function countit6(what){
formcontent=what.form.evalproj.value
what.form.epdisplaycount.value=formcontent.length
}
function countit7(what){
formcontent=what.form.dcsdesc.value
what.form.dcsdisplaycount.value=formcontent.length
}
</cfif>
function countit99(what){
formcontent=what.form.regdesc.value
what.form.regDspCnt.value=formcontent.length
}

function countit88(what){
formcontent=what.form.statedesc.value
what.form.stateDspCnt.value=formcontent.length
}


function counterUpdate(opt_countedTextBox, opt_countBody, opt_maxSize) {
        var countedTextBox = opt_countedTextBox ? opt_countedTextBox : "counttxt";
        var countBody = opt_countBody ? opt_countBody : "countBody";
        var maxSize = opt_maxSize ? opt_maxSize : 1950;

        var field = document.getElementById(countedTextBox);
        if (field.value.length >= maxSize) {
				document.wrk.advlong.value = 1;
           		alert("The maximum length for this field is 1950 characters.");
				return false;
				field.focus();
        }
}
function checkMOB(){

var oname = document.wrk.oname0.value;
var obj = document.wrk.targ.selectedIndex;
var chk1 = document.wrk.CHC.checked;
var chk2 = document.wrk.PROS.checked;
var chk3 = document.wrk.HCPO.checked;

if (oname == '')
{
alert('Please enter a target organization name before adding this entry.');
return false;
}
  if (obj == 0)
{
alert('Please select an target type before adding this entry.');
return false;
}
if ((chk1 == false)&&(chk2 == false)&&(chk3 == false))
{
	alert('Please select a related health systems change target before adding this entry.');
return false;
}
add('addCM');
}
function checkCM(){

 var oname = document.wrk.oname0.value;
 var obj = document.wrk.targ0.selectedIndex;

<!---  var just = 0;
 	if(document.wrk.cmjustone.checked==true){
 	just=just+1;
 	}
 	if(document.wrk.cmjusttwo.checked==true){
 	just=just+1;
 	}
 	if(document.wrk.cmjustthree.checked==true){
 	just=just+1;
 	}
 	if(document.wrk.cmjustfour.checked==true){
 	just=just+1;
 	} --->
var just = 1;
if (oname == '')
{
alert('Please enter a target organization name before adding this entry.');
return false;
}
if (obj == 0)
{
alert('Please select an organization type before adding this entry.');
return false;
}
if (document.wrk.CMDescr.value.length==0){
alert('Please enter a description of the target before adding this entry.');
return false;
}
if(just==0){
alert('Please enter your justification for selecting this target before adding this entry.');
return false;
}

<!--- if(document.wrk.cmjustfour.checked==true && document.wrk.cmjustother.value.length==0){
alert('Please enter justification text if you check the other justification box!');
return false;
} --->
add('addCM');
document.wrk.action="cat_work.cfm#cmmob";
}

function checkCMM(){
add('delCM');
document.wrk.action="cat_work.cfm#advoc";
}

function checkMG(){
 var oname = document.wrk.oname.value;
 var obj = document.wrk.objs.value;
 var targs = document.wrk.targ.value;

if (oname == '')
{
alert('Please enter a target organization name.');
return false}
if (targs == '')
{
alert('Please select an organization type.');
return false}

if (obj != '1E')
{

if((obj !='2E')&&(obj != '4F')&&obj != '3M')	{

 var city = document.wrk.city.value;
 }
 var county = document.wrk.county.value;

if((obj !='2E')&&(obj != '4F')&&(obj != '3M'))	{
if (city == '')
{
alert('Please enter a city.');
return false}
}

if (county == '')
{
alert('Please select a county.');
return false}
}

<!--- <cfif session.fy GTE 2012 and (not isDefined("form.objval") or (isDefined("form.objval") and form.objval NEQ "1E" and form.objval NEQ "3M" and form.objval NEQ "4F"))>
	if(document.wrk.advjustone.checked==0 && document.wrk.advjusttwo.checked==0 && document.wrk.advjustthree.checked==0){
	alert ('Please enter your justification for selecting this target.');
	return false;
	}
</cfif> --->

add('addMG');
document.wrk.action="cat_work.cfm#advoc";
}

function checkHCPO(){
 var oname = document.wrk.oname.value;
var targ = document.wrk.targ.value;
if (oname == '')
{
alert('Please enter a Target Organization Name.');
return false}
if (targ == '')
{
alert('Please select a Target Type.');
return false}
add('addMG');
document.wrk.action="cat_work.cfm#advoc";
}

function checkPOS(){
 var oname = document.wrk.oname.value;

if (oname == '')
{
alert('Please select a Target PROS program.');
return false}

add('addMG');
document.wrk.action="cat_work.cfm#advoc";
}

function checkHSC(){
if (document.wrk.targMHS.value == ""){
 alert('Please enter a target');
return false;
 }

var soff = document.wrk.satOff.value;
 if(isNaN(soff) || document.wrk.satOff.value.length ==0){
 alert('Enter the # of satellite offices');
return false;
 }

if(document.wrk.typeHC.selectedIndex==0){
alert("Select the type of healthcare organization.");
return false;
}


if (document.wrk.noPol.checked == false && document.wrk.confirmBase.checked==false){
 alert('Please confirm whether all baseline data have been entered, or no baseline policy is in place.  If you are not sure about the organization’s baseline data, you will need to gather that information before entering them as a target in your work plan.');
 return false;
 }
  return true;

 }

function checkCHC(){
 var oname = document.wrk.oname.value;

if (oname == '')
{
alert('Please select a Target CHC.');
return false}

add('addMG');
document.wrk.action="cat_work.cfm#advoc";
}

function checkCHC(){
 var oname = document.wrk.oname.value;

if (oname == '')
{
alert('Please select a Target CHC.');
return false}

add('addMG');
document.wrk.action="cat_work.cfm#advoc";
}
function checkCHC2(){
 var targ = document.wrk.targ.value;
var targsite = document.wrk.targsite.value;
if (targ == '')
{
alert('Please select a Target CHC.');
return false}
if (targsite == '')
{
alert('Please enter Target CHC Clinical Sites.');
return false}

add('addMG');
document.wrk.action="cat_work.cfm#advoc";
}
function checkMGG(){
add('delMG');
document.wrk.action="cat_work.cfm#advoc";
}

 function checkOG(){
  var outt = document.wrk.outdisplaycount.value;

if (outt > 1950)
{
alert('Outcome description cannot exceed 1950 characters.');
return false;
}
add('addOG');

}
 function checkGG(){
  var gname = document.wrk.gname.value;
   var targs = document.wrk.targZ.value;

if (gname == '')
{
alert('Please enter target organization name.');
return false;
}
if (targs == '')
{
alert('Please select an organization type.');
return false;
}
add('addGG');
document.wrk.action="cat_work.cfm#govt";

}
 function checkGGG(){
add('delGG');
document.wrk.action="cat_work.cfm#govt";

}
 function checkCG(){
add('addCG');
}

 function checkLG(){
 var evals = document.wrk.selfeval.value;
if (evals == '')
{
alert('Please select an evaluation project.');
return false}
else
{
  var ep = document.wrk.epdisplaycount.value;

if (ep > 2000)
{
alert('Evaluation project description cannot exceed 2000 characters.');
return false;
}
add('addLG');
}
}
function checkWiG()
{
return counterUpdate('advocdesc', 'countBody','1950');
return false;

return counterUpdate('govtdesc', 'countBody','1950');
return false;

return counterUpdate('commdesc', 'countBody','1950');
return false;

return counterUpdate('mediadesc', 'countBody','1950');
return false;

}
  function checkWG(){

<cfif session.fy GTE 2015 and (isdefined("session.objval") and (#session.objval# is not '6b'))>
if (document.getElementById('dispar_0').checked== false &&  document.getElementById('dispar_1').checked==false) {
alert('Please indicate whether you have a Disparities Project associated with this initiative.');
return false;
}
if (document.getElementById('dispar_1').checked==true && document.wrk.dispartxt.value.length == 0) {
alert('Please provide a brief description of your Disparities Project.');
return false;
}
</cfif>

<cfif isdefined("session.objval") and (#session.objval# is '1a' or #session.objval# is '1e') and session.modality NEQ 6>
   var advo = document.wrk.advoc.checked;
var advodesc = document.wrk.advocdesc.value;
		 if(advo == true){
			 if (advodesc == '')

		{
		alert('You checked Advocating but did not enter a description.  Please add text before you enter your Monthly Report');
		return false;
		}

		 }
		 </cfif>
		 <cfif isdefined("session.objval") and (#session.objval# is '1a' or #session.objval# is '1g' or #session.objval# is '1e') and session.modality NEQ 6>
		  var comm = document.wrk.comm.checked;
var commdesc = document.wrk.commdesc.value;
		 if(comm == true){
			 if (commdesc == '')

		{
		alert('You checked Community Education but did not enter a description.  Please add text before you enter your Monthly Report');
		return false;
		}

		 } </cfif>
		  <cfif isdefined("session.objval") and #session.objval# is '1h'>
 var comm = document.wrk.commmob.checked;
var commdesc = document.wrk.commmobdesc.value;

		 if(comm == true){
			 if (commdesc == '')

		{
		alert('You checked Community Moblization but did not enter a description.  Please add text before you enter your Monthly Report');
		return false;
		}

		 }
		 var med = document.wrk.media.checked;
var meddesc = document.wrk.mediadesc.value;

		 if(med == true){
			 if (meddesc == '')

		{
		alert('You checked Paid Media but did not enter a description.  Please add text before you enter your Monthly Report');
		return false;
		}

		 }
		  var dcs = document.wrk.dcs.checked;
var dcsdesc = document.wrk.dcsdesc.value;

		 if(dcs == true){
			 if (dcsdesc == '')

		{
		alert('You checked Direct Cessation Services but did not enter a description.  Please add text before you enter your Monthly Report');
		return false;
		}

		 }
		 </cfif>
<cfif isdefined("session.objval") and (#session.objval# is not '2d' and  #session.modality# is not 3  and session.modality NEQ 6)>
var adv = document.wrk.advdisplaycount.value;

if (adv > 1950)
{
alert('Advocacy description cannot exceed 1950 characters.');
return false;
}
</cfif>
<cfif isdefined("session.objval") and #session.objval# is not '1E' and  #session.objval# is not '1A' and session.modality NEQ 6>

var gov = document.wrk.govtdisplaycount.value;

if (gov > 1950)
{
alert('Government description cannot exceed 1950 characters.');
return false;
}

var comm = document.wrk.commdisplaycount.value;

if (comm > 1950)
{
alert('Community description cannot exceed 1950 characters.');
return false;
}</cfif>
<cfif isdefined("session.objval") and #session.objval# is not '1E' and session.modality NEQ 6>

var med = document.wrk.meddisplaycount.value;

if (med > 1950)
{
alert('Media description cannot exceed 1950 characters.');
return false;
}
</cfif>
add('addWG');
}
function add(actvalue){
document.wrk.dofunction.value=actvalue;
return true;
}

    function toggle_visibility0(id) {
 	     var e = document.getElementById(id);
	     var cm0 = document.wrk.commmob.checked;

		 if(cm0 == true){
       if(e.style.display == 'block')
          e.style.display = 'none';
       else
          e.style.display = 'block';
		  }
		  else
		  {
		  e.style.display = 'none';
		  }}

    function toggle_visibility2(id) {
 	     var e = document.getElementById(id);
	     var gov = document.wrk.govt.checked;

		 if(gov == true){
       if(e.style.display == 'block')
          e.style.display = 'none';
       else
          e.style.display = 'block';
		  }
		  else
		  {
		  e.style.display = 'none';
		  }}
	 function toggle_visibility7(id) {
 	     var e = document.getElementById(id);
	     var targ = document.wrk.targ.value;

		 if(targ == 999){
       if(e.style.display == 'block')
          e.style.display = 'none';
       else
          e.style.display = 'block';
		  }
		  else
		  {
		  e.style.display = 'none';
		  }}

		  function toggle_visibility8(id) {
 	     var e = document.getElementById(id);
	     var targ = document.wrk.targ.value;

		 if(targ == 999){
       if(e.style.display == 'block')
          e.style.display = 'none';
       else
          e.style.display = 'block';
		  }
		  else
		  {
		  e.style.display = 'none';
		  }}

		  function toggle_visibility9(id) {
 	     var e = document.getElementById(id);
	     var targ = document.wrk.targ.value;

		 if(targ == 999){
       if(e.style.display == 'block')
          e.style.display = 'none';
       else
          e.style.display = 'block';
		  }
		  else
		  {
		  e.style.display = 'none';
		  }}

	function toggle_visibility3(id) {
 	     var e = document.getElementById(id);
	     var comm = document.wrk.comm.checked;

		 if(comm == true){
       if(e.style.display == 'block')
          e.style.display = 'none';
       else
          e.style.display = 'block';
		  }
		  else
		  {
		  e.style.display = 'none';
		  }}

     function toggle_visibility4(id) {
 	     var e = document.getElementById(id);
	     var med = document.wrk.media.checked;

		 if(med == true){
       if(e.style.display == 'block')
          e.style.display = 'none';
       else
          e.style.display = 'block';
		  }
		  else
		  {
		  e.style.display = 'none';
		  }}
	function toggle_visibility5(id) {
 	     var e = document.getElementById(id);
	     var tag = document.wrk.targ.value;

		 if(tag == 17){
       if(e.style.display == 'block')
          e.style.display = 'none';
       else
          e.style.display = 'block';
		  }
		  else
		  {
		  e.style.display = 'none';
		  }}

	function toggle_visibility6(id) {
 	     var e = document.getElementById(id);
	     var dcs = document.wrk.dcs.checked;

		 if(dcs == true){
       if(e.style.display == 'block')
          e.style.display = 'none';
       else
          e.style.display = 'block';
		  }
		  else
		  {
		  e.style.display = 'none';
		  }}

	function toggle_visibility7(id) {
 	     var e = document.getElementById(id);
	     var addlSO = document.wrk.addlSO.checked;

		 if(addlSO == true){
       if(e.style.display == 'block')
          e.style.display = 'none';
       else
          e.style.display = 'block';
		  }
		  else
		  {
		  e.style.display = 'none';
		  }}

	function toggle_visibility10(id) {
 	     var e = document.getElementById(id);
	     if(document.wrk.dispar_1.checked)	   {
          e.style.display = 'block';
          if (document.wrk.targDisp != undefined){document.wrk.targDisp.disabled=false;}
          if (document.wrk.targDisp1 != undefined){document.wrk.targDisp1.disabled=false;}
          if (document.wrk.targDisp2 != undefined){document.wrk.targDisp2.disabled=false;}
          if (document.wrk.typeHC != undefined){document.getElementById("typeHC").options[4].disabled=false;}
          }
       else {
		  e.style.display = 'none';
		  if (document.wrk.targDisp != undefined){document.wrk.targDisp.disabled=true;}
		  if (document.wrk.targDisp1 != undefined){document.wrk.targDisp1.disabled=true;}
		  if (document.wrk.targDisp2 != undefined){document.wrk.targDisp2.disabled=true;}
		  if (document.wrk.typeHC != undefined){document.getElementById("typeHC").options[4].disabled=true;}
		  }
	 }
</script>
		<cfparam name="oldadvoc" default="">
		<cfparam name="oldgovt" default="">
		<cfparam name="oldcomm" default="">
		<cfparam name="oldmedia" default="">
		<cfparam name="oldcommMed" default="">
		<cfparam name="session.objval" default="">
		<cfparam name="session.outchg" default="">
		<cfparam name="session.stratchg" default="">
		<cfparam name="session.stratdel" default="">
		<cfparam name="session.smartchg" default="">
		<cfquery datasource="#application.DataSource#" password="#application.db_password#"
	username="#application.db_username#" name="countyheadache">
select catchment
from contact
where userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR"  maxlength="50">
</cfquery>
		<cfif countyheadache.catchment is ''>
			<cflocation url="nocounty.cfm">
		<cfelse>
			<cfquery datasource="#application.DataSource#"	password="#application.db_password#"
	username="#application.db_username#" name="counties">
	select CountyName, FIPS from counties
	where FIPS in<cfif isDefined("countyheadache.catchment")>(#valuelist(countyheadache.catchment)#)<cfelse>(0)</cfif>
	order by 1
</cfquery>
		</cfif>
		<cfif not isdefined("form.initiative")>
			<cfset session.initiative = ''>
		</cfif>
		<cfif not isdefined("dofunction")>
			<cfset form.dofunction = "">
		</cfif>
		<cfif isdefined("form.objval") or isdefined("url.objval")>
			<cfif isdefined("form.objval")>
				<cfset session.objval = '#form.objval#'>
			<cfelseif isdefined("url.objval")>
				<cfset session.objval = '#url.objval#'>
			</cfif>
			<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="getobj">
	select
o.objective,
o.id as objnum,prognum,id,
initiative,cc,aa,cp,yp
from objectives as o
where
o.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> and o.id = <cfqueryparam value="#session.objval#"
                cfsqltype="CF_SQL_VARCHAR"
                maxlength="3">
order by initiative
</cfquery>
			<cfoutput>
				<cfset session.initiative = '#getobj.initiative#'>
				<cfset session.prognum = '#getobj.prognum#'>
				<cfset session.id = '#getobj.id#'>
				<cfset session.objnum = '#getobj.objnum#'>
				<cfif isdefined("form.return") and #form.return# is 'Save and return to menu'>
					<cfset session.initiative = ''>
				</cfif>
			</cfoutput>
		</cfif>
		<cfif isdefined("form.addadvorg") and #form.addadvorg# is 'Add'>
			<cfset strat = 1>
		<cfelseif isdefined("form.addgovorg") and #form.addgovorg# is 'Add'>
			<cfset strat = 2>
		<cfelseif isdefined("form.addcommorg") and #form.addcommorg# is 'Add'>
			<cfset strat = 3>
		<cfelseif isdefined("form.addmedorg") and #form.addmedorg# is 'Add'>
			<cfset strat = 4>
		</cfif>
		<cfif isdefined("del_box")>
			<cfloop index="x" list="#del_box#">
				<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="del">
	delete from wrkplan_outcome where outcomeid = <cfqueryparam value="#x#" cfsqltype="CF_SQL_INTEGER">
	</cfquery>
			</cfloop>
		</cfif>
		<cfif form.dofunction is 'delMG' or form.dofunction is 'delGG' or form.dofunction is 'delCMM'>
			<cfif isdefined("del_targ0")>
				<cfloop index="x" list="#del_box2#">
					<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="del">
	delete from monthly_commmob where target = <cfqueryparam value="#x#" cfsqltype="CF_SQL_INTEGER">
	and year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and initnum = <cfqueryparam value="#session.objnum#" cfsqltype="CF_SQL_VARCHAR" maxlength="3">
	</cfquery>
				</cfloop>
			</cfif>
			<cfif isdefined("del_box2")>
				<cfloop index="x" list="#del_box2#">
					<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="del">
	delete from target_org where targid = <cfqueryparam  value="#x#" cfsqltype="CF_SQL_INTEGER">
	</cfquery>
				</cfloop>
			</cfif>
		</cfif>
		<cfif isdefined("del_box3")>
			<cfloop index="x" list="#del_box3#">
				<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="del">
	delete from wrkplan_selfeval
	where
	wrkselfid = <cfqueryparam value="#x#" cfsqltype="CF_SQL_INTEGER">
	</cfquery>
			</cfloop>
		</cfif>
		<cfif isdefined("del_box4")>
			<cfloop index="x" list="#del_box4#">
				<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="del">
	delete from target_chc where targchcid = <cfqueryparam value="#x#" cfsqltype="CF_SQL_INTEGER">
	</cfquery>
			</cfloop>
		</cfif>
		<cfif isdefined("del_box5") and (isDefined("form.del_targM") or isdefined("form.del_targ"))>
			<cfloop index="x" list="#del_box5#">
				<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="del">
	delete from target_org where targid = <cfqueryparam value="#x#" cfsqltype="CF_SQL_INTEGER">
	</cfquery>
				<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="del">
	delete from target_chc where targid = <cfqueryparam value="#x#" cfsqltype="CF_SQL_INTEGER">
	</cfquery>
			</cfloop>
		</cfif>
		<cfif isdefined("del_box5x")>
			<cfloop index="x" list="#del_box5x#">
				<cfquery datasource="#application.DataSource#"
password="#application.db_password#"
	username="#application.db_username#" name="del">
	delete from target_chc where targchcid = <cfqueryparam value="#x#" cfsqltype="CF_SQL_INTEGER">
	</cfquery>
			</cfloop>
		</cfif>
		<cfif isdefined("del_hsc")>
			<cfloop index="x" list="#delhsc#">
				<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="del">
	delete from HSC where id = <cfqueryparam value="#x#" cfsqltype="CF_SQL_INTEGER">
	and userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	</cfquery>
			</cfloop>
		</cfif>
		<cfparam name="form.dofunction" default="">
		<cfif form.dofunction is 'addMG'<!---  or (isdefined("form.targ") and #form.targ# is not '') --->>
			<cfif not isdefined("strat")>
				<cfset strat = 1>
			</cfif>
			<cfif isdefined("form.targsite") and form.targsite is not ''>
				<cfif isdefined("form.targy")>
					<cfset form.targ = #form.targy#>
				</cfif>
				<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QInsMG">
select * from target_chc
where targid = <cfqueryparam value="#form.targ#" cfsqltype="CF_SQL_INTEGER">
order by targsite
</cfquery>
				<cfif qinsmg.recordcount eq 0 or form.addchcorg is 'Add'>
					<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QInsMG">
insert into target_chc
(targid,targsite)
values
(<cfqueryparam value="#form.targ#" cfsqltype="CF_SQL_INTEGER">, <cfqueryparam value="#form.targsite#" cfsqltype="CF_SQL_VARCHAR"
                maxlength="100">)
</cfquery>
				<cfelse>
					<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QInsMG">
update target_chc
set targsite = <cfqueryparam value="#form.targsite#" cfsqltype="CF_SQL_VARCHAR" maxlength="100">
where targchcid = <cfqueryparam value="#form.targchc#" cfsqltype="CF_SQL_INTEGER">
</cfquery>
				</cfif>
			</cfif>
			<cfif (isdefined("form.addadvorg") and form.addadvorg EQ 'Update' and not isdefined("form.addchcorg")) or (isdefined("form.addhcpoorg") and #form.addhcpoorg# is 'Update')>
				<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QInsCG">
update target_org
set
targnum=<cfqueryparam value="#form.targ#" cfsqltype="CF_SQL_INTEGER">,
name=<cfqueryparam value="#form.oname#" cfsqltype="CF_SQL_VARCHAR" maxlength="500">,
city=<cfqueryparam value="#form.city#" cfsqltype="CF_SQL_VARCHAR" maxlength="100">,
targDisp=<cfqueryparam value="#form.targDisp1#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.targDisp1))#">,
county=<cfqueryparam value="#form.county#" cfsqltype="CF_SQL_VARCHAR" maxlength="100">,
justone=<cfqueryparam value="#form.advjustone#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.advjustone))#">,
justtwo=<cfqueryparam value="#form.advjusttwo#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.advjusttwo))#">,
justthree=<cfqueryparam value="#form.advjustthree#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.advjustthree))#">
where targid=<cfqueryparam value="#form.targid0#" cfsqltype="CF_SQL_INTEGER">
and userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
</cfquery>
			<cfelse>
				<cfif session.objnum is '1a' or session.objnum is '1g'>
					<cfset form.targ = 1>
				</cfif>
				<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QSelMG">
	select *
	from target_org
	where userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and stratnum = <cfqueryparam value="#strat#" cfsqltype="CF_SQL_INTEGER">
	and targnum = <cfqueryparam value="#form.targ#" cfsqltype="CF_SQL_INTEGER">
	and initnum = <cfqueryparam value="#session.objnum#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">
	and name = <cfqueryparam value="#form.oname#" cfsqltype="CF_SQL_VARCHAR" maxlength="500">
	order by name
	</cfquery>
				<cfif QSelMG.recordcount is 0>
					<cfif not isdefined("addchcorg") and not isdefined("form.addhcpoorg") or (isdefined("form.addhcpoorg") and #form.addhcpoorg# is 'Add')>
						<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QInsMG">
insert into target_org
(userid, year2,  stratnum,targnum, initnum,name,city,county
<cfif session.fy GT 2011>,justone, justtwo, justthree</cfif>,targoth, targDisp)
values
(<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">,
<cfqueryparam value="#strat#" cfsqltype="CF_SQL_INTEGER">,
<cfqueryparam value="#form.targ#" cfsqltype="CF_SQL_INTEGER">,
<cfqueryparam value="#session.objnum#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
<cfqueryparam value="#form.oname#" cfsqltype="CF_SQL_VARCHAR" maxlength="500">,
<cfqueryparam value="#form.city#" cfsqltype="CF_SQL_VARCHAR" maxlength="100">,
<cfqueryparam value="#form.county#" cfsqltype="CF_SQL_VARCHAR" maxlength="100">,
<cfif session.fy GT 2011>
<cfqueryparam value="#form.advjustone#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.advjustone))#">,
<cfqueryparam value="#form.advjusttwo#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.advjusttwo))#">,
<cfqueryparam value="#form.advjustthree#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.advjustthree))#">,
<cfqueryparam value="#form.targoth#" cfsqltype="CF_SQL_VARCHAR" maxlength="1000">,
</cfif>
<cfqueryparam value="#form.targdisp1#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.targdisp1))#">)
</cfquery>
					</cfif>
				</cfif>
			</cfif>
		</cfif>
		<cfif form.dofunction is 'addCM' and not isdefined("form.addchcorg")>
			<cfif (isdefined("form.addcm") and form.addCM EQ 'Update') or (isdefined("form.addmob") and form.addmob eq 'Update') or (isdefined("form.addhcpoorg") and form.addhcpoorg EQ 'Update')>
				<cfif isdefined("form.targ") and session.modality is not 2>
					<cfset form.targ0 = #form.targ#>
				</cfif>
				<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QInsCG">
update target_org
set
<cfif session.modality is not 2 and (session.objnum is '1h' or session.objnum is '1e')>
targnum=<cfqueryparam value="#form.targ#" cfsqltype="CF_SQL_INTEGER">,
<cfelse>
targnum=<cfqueryparam value="#form.targ0#" cfsqltype="CF_SQL_INTEGER">,
</cfif>
<cfif session.objnum is '1e'>
name=<cfqueryparam value="#form.oname#" cfsqltype="CF_SQL_VARCHAR" maxlength="500">,
<cfelse>
name=<cfqueryparam value="#form.oname0#" cfsqltype="CF_SQL_VARCHAR" maxlength="500">,
</cfif>
<cfif isdefined("form.targDisp")>targDisp=<cfqueryparam value="#form.targdisp#" cfsqltype="CF_SQL_INTEGER"><cfelse>targDisp=0</cfif>,
<cfif session.objnum is not '1h'>
descrip=<cfqueryparam value="#form.cmdescr#" cfsqltype="CF_SQL_VARCHAR" maxlength="1000">
</cfif>
<cfif session.fy LT 2012>,
justone=<cfqueryparam value="#form.advjustone#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.advjustone))#">,
justtwo=<cfqueryparam value="#form.advjusttwo#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.advjusttwo))#">,
justthree=<cfqueryparam value="#form.advjustthree#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.advjustthree))#">,
justfour=<cfqueryparam value="#form.advjustfour#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.advjustfour))#">,
justother=<cfqueryparam value="#form.cmjustother#" cfsqltype="CF_SQL_VARCHAR" maxlength="500">
</cfif>
<cfif session.objnum is '1h'>
chc=<cfqueryparam value="#form.chc#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.chc))#">,
pros=<cfqueryparam value="#form.pros#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.pros))#">,
hcpo=<cfqueryparam value="#form.hcpo#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.hcpo))#">
</cfif>
<cfif session.objnum is '1h' or session.objnum is '1e'>
,targoth = <cfqueryparam value="#form.targoth#" cfsqltype="CF_SQL_VARCHAR" maxlength="500">
</cfif>
<cfif isdefined("form.targid0") and #form.targid0# is not ''>
where targid=<cfqueryparam value="#form.targid0#" cfsqltype="CF_SQL_INTEGER">
<cfelse>
where targid=<cfqueryparam value="#form.targid#" cfsqltype="CF_SQL_INTEGER">
</cfif>
</cfquery>
			<cfelse>
				<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QInsCG">
insert into target_org
(userid, year2, stratnum,targnum, initnum, name, descrip, justone, justtwo, justthree, justfour, justother,chc,pros,hcpo
,targoth, targDisp)
values
(<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">,
'0'
<cfif isdefined("form.targ") and #form.targ# is not '' and (not isdefined("form.addcm"))>,
<cfqueryparam value="#form.targ#" cfsqltype="CF_SQL_INTEGER"><cfelse>,
<cfqueryparam value="#form.targ0#" cfsqltype="CF_SQL_INTEGER"></cfif>,
<cfqueryparam value="#session.objnum#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">,
<cfif isdefined("form.oname") and #form.oname# is not ''>
	<cfqueryparam value="#form.oname#" cfsqltype="CF_SQL_VARCHAR" maxlength="500">
<cfelse>
	<cfqueryparam value="#form.oname0#" cfsqltype="CF_SQL_VARCHAR" maxlength="500"></cfif>,
	<cfqueryparam value="#form.cmdescr#" cfsqltype="CF_SQL_VARCHAR" maxlength="1000">,
	<cfqueryparam value="#form.cmjustone#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.cmjustone))#">,
	<cfqueryparam value="#form.cmjusttwo#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.cmjusttwo))#">,
	<cfqueryparam value="#form.cmjustthree#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.cmjustthree))#">,
	<cfqueryparam value="#form.cmjustfour#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.cmjustfour))#">,
	<cfqueryparam value="#form.cmjustother#" cfsqltype="CF_SQL_VARCHAR" maxlength="500">,
	<cfqueryparam value="#form.chc#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.chc))#">,
	<cfqueryparam value="#form.pros#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.pros))#">,
	<cfqueryparam value="#form.hcpo#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.hcpo))#">,
	<cfqueryparam value="#form.targoth#" cfsqltype="CF_SQL_VARCHAR" maxlength="500">,
<cfif isdefined("form.targDisp")><cfqueryparam value="#form.targdisp#" cfsqltype="CF_SQL_INTEGER"><cfelse>0</cfif>
)
</cfquery>
			</cfif>
		</cfif>
		<cfif form.dofunction is 'addCG'>
			<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QInsCG">
insert into target_org
(userid, year2, stratnum, targnum, initnum, name,address)
values
(<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">,
<cfqueryparam value="#strat#" cfsqltype="CF_SQL_INTEGER">,
<cfqueryparam value="#form.targ#" cfsqltype="CF_SQL_INTEGER">,
<cfqueryparam value="#session.objnum#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">,
<cfqueryparam value="#form.cname#" cfsqltype="CF_SQL_VARCHAR" maxlength="500">,
<cfqueryparam value="#form.address#" cfsqltype="CF_SQL_VARCHAR" maxlength="500">)
</cfquery>
		</cfif>
		<cfif form.dofunction is 'addLG'>
			<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="se">
select * from wrkplan_selfeval
where
	userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and selfevalid = <cfqueryparam value="#selfeval#" cfsqltype="CF_SQL_INTEGER">
	and initnum='#session.objnum#'
	--and modality = '#session.modality#'
	</cfquery>
			<cfif isdefined("self") and #self# is 'Add' and se.recordcount EQ 0>
				<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QInsSE">
insert into wrkplan_selfeval
(userid, year2, selfevalid, evalproj, initnum, modality)
values
(<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">,
<cfqueryparam value="#selfeval#" cfsqltype="CF_SQL_INTEGER">,
<cfqueryparam value="#evalproj#" cfsqltype="CF_SQL_VARCHAR" maxlength="5000">,
<cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
<cfqueryparam value="#session.modality#" cfsqltype="CF_SQL_INTEGER">)
</cfquery>
			<cfelse>
				<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QupdSE">
	update wrkplan_selfeval set
	userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	,year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	,selfevalid = <cfqueryparam value="#selfeval#" cfsqltype="CF_SQL_INTEGER">
	,evalproj = <cfqueryparam value="#evalproj#" cfsqltype="CF_SQL_VARCHAR" maxlength="5000">
	,initnum = <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	,modality = <cfqueryparam value="#session.modality#" cfsqltype="CF_SQL_INTEGER">
	where
	wrkselfid = <cfqueryparam value="#se.wrkselfid#" cfsqltype="CF_SQL_INTEGER">
	</cfquery>
			</cfif>
		</cfif>
		<cfif form.dofunction is 'addWG' or form.dofunction is 'addMG' or form.dofunction is 'addGG' or form.dofunction is 'addOG' or form.dofunction is 'addCM'
			or isDefined("form.del_targ") or isDefined("form.del_targ0") or isDefined("form.return") or (isdefined("form.reqinit") and #form.reqinit# is not '')>
			<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="wrk">
select
	*
	from wrkplan
	where
	userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and initnum=<cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
</cfquery>
			<cfset oldadvoc = wrk.advoc>
			<cfset oldgovt = wrk.govt>
			<cfset oldcomm = wrk.comm>
			<cfset oldmedia = wrk.media>
			<cfset oldcm = wrk.cm>
			<cfset oldcommMob = wrk.commMob>
			<cfset olddispar = wrk.dispar>
			<cfset olddispartxt = wrk.dispartxt>
			<cfif wrk.recordcount EQ 0>
				<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QInsWG">
insert into wrkplan
(userid, year2, initnum, advoc ,advocdesc, govt, govtdesc, comm, commdesc, media, mediadesc, cm, cmdesc, commmob, commmobdesc, addlSO, addlSOtxt,reqinit,dispar, dispartxt,
regdesc, statedesc, DispInit, othdisptxt
)
values
(<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">,
<cfqueryparam value="#session.objnum#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
<cfqueryparam value="#advoc#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(advoc))#">,
<cfqueryparam value="#advocdesc#" cfsqltype="CF_SQL_VARCHAR" maxlength="2000">,
<cfqueryparam value="#govt#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(govt))#">,
<cfqueryparam value="#govtdesc#" cfsqltype="CF_SQL_VARCHAR" maxlength="2000">,
<cfqueryparam value="#comm#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(comm))#">,
<cfqueryparam value="#commdesc#" cfsqltype="CF_SQL_VARCHAR" maxlength="2000">,
<cfqueryparam value="#media#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(media))#">,
<cfqueryparam value="#form.mediadesc#" cfsqltype="CF_SQL_VARCHAR" maxlength="2000">,
<cfqueryparam value="#cm#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(cm))#">,
<cfqueryparam value="#form.cmdesc#" cfsqltype="CF_SQL_VARCHAR" maxlength="1950">,
<cfqueryparam value="#commmob#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(commmob))#">,
<cfqueryparam value="#commmobdesc#" cfsqltype="CF_SQL_VARCHAR" maxlength="1950">,
<cfqueryparam value="#addlSO#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(addlso))#">,
<cfqueryparam value="#addlSOtxt#" cfsqltype="CF_SQL_VARCHAR" maxlength="500">,
<cfqueryparam value="#form.reqinit#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.reqinit))#">,
<cfqueryparam value="#form.dispar#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.dispar))#">,
<cfqueryparam value="#form.dispartxt#" cfsqltype="CF_SQL_VARCHAR" maxlength="2000">,
<cfqueryparam value="#form.regdesc#" cfsqltype="CF_SQL_VARCHAR" maxlength="1950">,
<cfqueryparam value="#form.statedesc#" cfsqltype="CF_SQL_VARCHAR" maxlength="1000">,
<cfif isDefined("form.DispInit")>
	<cfqueryparam value="#form.DispInit#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	<cfelse>NULL
</cfif>,
<cfif isDefined("form.othdisptxt")>
	<cfqueryparam value="#form.othdisptxt#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	<cfelse>NULL
</cfif>)
</cfquery>
			<cfelse>
				<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QInsWG">
	update wrkplan set
	userid = '#session.userid#',
	advoc = <cfqueryparam value="#advoc#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(advoc))#">,
	advocdesc = <cfqueryparam value="#advocdesc#" cfsqltype="CF_SQL_VARCHAR" maxlength="2000">,
	govt = <cfqueryparam value="#govt#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(govt))#">,
	govtdesc = <cfqueryparam value="#govtdesc#" cfsqltype="CF_SQL_VARCHAR" maxlength="2000">,
	comm = <cfqueryparam value="#comm#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(comm))#">,
	commdesc = <cfqueryparam value="#commdesc#" cfsqltype="CF_SQL_VARCHAR" maxlength="2000">,
	media = <cfqueryparam value="#media#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(media))#">,
	mediadesc = <cfqueryparam value="#mediadesc#" cfsqltype="CF_SQL_VARCHAR" maxlength="2000">,
	cm = <cfqueryparam value="#cm#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(cm))#">,
	cmdesc = <cfqueryparam value="#cmdesc#" cfsqltype="CF_SQL_VARCHAR" maxlength="1950">,
	commmob = <cfqueryparam value="#commmob#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(commmob))#">,
	commmobdesc = <cfqueryparam value="#commmobdesc#" cfsqltype="CF_SQL_VARCHAR" maxlength="1950">,
	dcs = <cfqueryparam value="#dcs#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(dcs))#">,
	dcsdesc = <cfqueryparam value="#dcsdesc#" cfsqltype="CF_SQL_VARCHAR" maxlength="1950">,
	addlSO = <cfqueryparam value="#addlSO#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(addlso))#">,
	addlSOtxt = <cfqueryparam value="#addlSOtxt#" cfsqltype="CF_SQL_VARCHAR" maxlength="500">,
	reqinit = <cfqueryparam value="#form.reqinit#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.reqinit))#">,
	dispar = <cfqueryparam value="#form.dispar#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.dispar))#">,
	dispartxt = <cfqueryparam value="#form.dispartxt#" cfsqltype="CF_SQL_VARCHAR" maxlength="2000">,
	statedesc = <cfqueryparam value="#form.statedesc#" cfsqltype="CF_SQL_VARCHAR" maxlength="1000">,
	regdesc = <cfqueryparam value="#form.regdesc#" cfsqltype="CF_SQL_VARCHAR" maxlength="1950">,
	DispInit= <cfif isDefined("form.DispInit")>
	<cfqueryparam value="#form.DispInit#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	<cfelse>NULL</cfif>,
	othdisptxt= <cfif isDefined("form.othdisptxt")>
	<cfqueryparam value="#form.othdisptxt#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	<cfelse>NULL
</cfif>
	where userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and initnum=<cfqueryparam value="#session.objnum#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
</cfquery>
				<cfif isdefined("advoc") and advoc is 1 and #oldadvoc# is ''>
					<cfset session.stratchg = 1>
				<cfelseif isdefined("govt") and govt is 1 and #oldgovt# is ''>
					<cfset session.stratchg = 1>
				<cfelseif isdefined("comm") and comm is 1 and #oldcomm# is ''>
					<cfset session.stratchg = 1>
				<cfelseif isdefined("media") and media is 1 and #oldmedia# is ''>
					<cfset session.stratchg = 1>
				<cfelseif isdefined("cmmob") and cmmob is 1 and #oldcommMob# is ''>
					<cfset session.stratchg = 1>
				</cfif>
				<cfif NOT isdefined("advoc")  and #oldadvoc# is '1'>
					<cfset session.stratdel = 1>
				<cfelseif NOT isdefined("govt")  and #oldgovt# is '1'>
					<cfset session.stratdel = 1>
				<cfelseif NOT isdefined("comm")  and #oldcomm# is '1'>
					<cfset session.stratdel = 1>
				<cfelseif NOT isdefined("media") and #oldmedia# is '1'>
					<cfset session.stratdel = 1>
				<cfelseif NOT isdefined("cmmob") and #oldcommMob# is '1'>
					<cfset session.stratdel = 1>
				</cfif>
			</cfif>
			<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="so">
	select *
	from smartoutcome
	where
	initnum = <cfqueryparam value="#session.objnum#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and modality = <cfqueryparam value="#session.modality#" cfsqltype="CF_SQL_INTEGER">
	and year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and vars = 1
	order by rank
</cfquery>
			<cfif so.recordcount is not 0>
				<cfloop query="so">
					<cfset x = "#so.sonum#">
					<cfset argh = "form.so1_#x#">
					<cfset argh2 = "form.so2_#x#">
					<!--- <cfif isdefined("#evaluate(argh)#")>
						<cfset form.so1 = "#evaluate(argh)#"></cfif>
						<cfif isdefined("#evaluate(argh2)#")>
						<cfset form.so2 = "#evaluate(argh2)#">
						</cfif> --->
					<cfif isdefined("#argh#")>
						<cfset form.so1 = "#evaluate(argh)#">
					</cfif>
					<cfif isdefined("#argh2#")>
						<cfset form.so2 = "#evaluate(argh2)#">
					</cfif>
					<cfset sonum = '#x#'>
					<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="selwrk">
	select *
	from smartoutcomes
	where userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and initnum = <cfqueryparam value="#session.objnum#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and sonum = <cfqueryparam value="#x#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">	</cfquery>
					<cfif selwrk.recordcount is 0>
						<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QInsSO">
insert into smartoutcomes
(userid, year2, initnum, sonum<cfif isdefined("form.so1")>, so1</cfif><cfif isdefined("so2")>, so2</cfif>)
values
(<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">,
<cfqueryparam value="#session.objnum#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
<cfqueryparam value="#x#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#rereplace(form.so1, "[^0-9]", "","All")#" Null="#YesNoFormat(not Len(form.so1))#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#rereplace(form.so2, "[^0-9]", "","All")#" Null="#YesNoFormat(not Len(form.so2))#">)
</cfquery>
					<cfelse>
						<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="selwrk2">
	update smartoutcomes
	set
	year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">,
	so1 = <cfqueryparam cfsqltype="cf_sql_integer" value="#rereplace(form.so1, "[^0-9]", "","All")#" Null="#YesNoFormat(not Len(form.so1))#">,
	so2 = <cfqueryparam cfsqltype="cf_sql_integer" value="#rereplace(form.so2, "[^0-9]", "","All")#" Null="#YesNoFormat(not Len(form.so2))#">
	where userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and initnum = <cfqueryparam value="#session.objnum#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and sonum = <cfqueryparam value="#x#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	</cfquery>
						<cfif (isdefined("form.so1") and trim(form.so1) NEQ "" and #selwrk.so1# NEQ #form.so1#)
							or (isdefined("form.so2") and trim(form.so2) NEQ "" and #selwrk.so2# NEQ #form.so2#)>
							<cfset session.smartchg = 1>
						</cfif>
					</cfif>
				</cfloop>
				<!--- <cfset smartchg = 1>	 --->
			</cfif>
			<cfif form.dofunction is 'addWG'>
				<cfif session.outchg EQ 1 OR  session.stratchg EQ 1 OR  session.smartchg EQ 1>
					<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="CMEmail">
	select isNull(cc.email, 'dplotner@rti.org') as email ,
	  isNull(c.coordemail, 'dplotner@rti.org') as partneremail,
	isNull(c.superemail2, 'dplotner@rti.org') as superemail
from contact c inner join contact cc
on c.cmanager = cc.userid
where c.userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
</cfquery>
					<cfmail to="#CMemail.email#" bcc="dplotner@rti.org,twills@rti.org" from="NY Tobacco Control Program <NY-Tobacco-Control-Program@rti.org>" subject="#session.orgname# updated work plan in CAT" type="html">
#session.orgname# has updated the following fields in their work plan for the #session.fy# reporting period in CAT:<br>
#session.initiative# initiative:
<ul><cfif #session.outchg# is 1><li>New outcome added</li></cfif>
<cfif #session.stratchg# is 1><li>New strategy added</li></cfif>
<cfif #session.stratdel# is 1><li>Existing strategy deleted</li></cfif>
<cfif #session.smartchg# is 1><li>Change to SMART outcome numeric field</li></cfif>
</ul>
</cfmail>
					<cfset session.outchg = ''>
					<cfset session.stratchg = ''>
					<cfset session.stratdel = ''>
					<cfset session.smartchg = ''>
				</cfif>
				<cfset session.initiative = ''>
			</cfif>
			<cfif form.dofunction is 'addGG'>
				<cfset oname = '#form.gname#'>
				<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QSelMG">
	select *
	from target_org
	where userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and stratnum = 2
	and targnum = <cfqueryparam value="#form.targz#" cfsqltype="CF_SQL_INTEGER">
	and initnum = <cfqueryparam value="#session.objnum#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and name = <cfqueryparam value="#gname#" cfsqltype="CF_SQL_VARCHAR" maxlength="500">
	order by name
	</cfquery>
				<cfif form.addgovorg EQ 'Update'>
					<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QInsCG">
update target_org
set
targnum=<cfqueryparam value="#form.targz#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.targz))#">,
name=<cfqueryparam value="#form.gname#" cfsqltype="CF_SQL_VARCHAR" maxlength="500">,
targDisp = <cfqueryparam value="#targDisp2#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(targDisp2))#">
where targid=<cfqueryparam value="#form.targid0#" cfsqltype="CF_SQL_INTEGER">
and userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
</cfquery>
				<cfelse>
					<cfif QSelMG.recordcount is 0>
						<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QInsMG">
insert into target_org
(userid, year2, stratnum, targnum, initnum, name, targDisp)
values
(<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">,
<cfqueryparam value="#strat#" cfsqltype="CF_SQL_INTEGER">,
<cfqueryparam value="#form.targz#" cfsqltype="CF_SQL_INTEGER">,
<cfqueryparam value="#session.objnum#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
<cfqueryparam value="#oname#" cfsqltype="CF_SQL_VARCHAR" maxlength="500">,
<cfqueryparam value="#targDisp2#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(targDisp2))#">)
</cfquery>
					</cfif>
				</cfif>
			</cfif>
			<cfif form.dofunction is 'addOG'>
				<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QSelOG">
select * from wrkplan_outcome
where userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
and year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
and initnum = <cfqueryparam value="#session.objnum#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
and outcometxt = <cfqueryparam value="#form.out#" cfsqltype="CF_SQL_VARCHAR" maxlength="500">
</cfquery>
				<cfif qselog.recordcount is 0>
					<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QInsOG">
insert into wrkplan_outcome
(userid, year2, initnum, outcometxt)
values
(<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">,
<cfqueryparam value="#session.objnum#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
<cfqueryparam value="#form.out#" cfsqltype="CF_SQL_VARCHAR" maxlength="500">)
</cfquery>
				</cfif>
			</cfif>
		</cfif>
		<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="sampleGoalobj">
	select
o.objective,
o.id as objnum,prognum,
initiative
from objectives as o
where
o.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
and (o.del is null or o.del !=1) and  (modality like '%99%' or modality like '%#session.modality#%')
order by initiative
</cfquery>
		<cfif isDefined("form.addHSC") and form.addHSC EQ "Add">
			<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="insHSC">
insert into HSC
(userid, year2, obj, targmhs, satoff, typehc,
<cfif session.fy LT 2016>askwritten, askEHR, askStandard, nopol, confirmbase
<cfelseif session.fy eq 2016>askwritten2016, askEHR2016, askStandard2016, nopol2016, confirmbase2016
<cfelseif session.fy eq 2017>askwritten2017, askEHR2017, askStandard2017, nopol2017, confirmbase2017
<cfelseif session.fy eq 2018>askwritten2018, askEHR2018, askStandard2018, nopol2018, confirmbase2018
<cfelseif session.fy eq 2019>askwritten2019, askEHR2019, askStandard2019, nopol2019, confirmbase2019</cfif>)
values
(
<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">,
<cfqueryparam value="#session.objnum#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
<cfqueryparam cfsqltype="CF_SQL_LONGVARCHAR" value="#form.targmhs#">,
<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#form.satoff#" Null="#YesNoFormat(not Len(form.satoff))#">,
<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#form.typehc#" Null="#YesNoFormat(not Len(form.typehc))#">,
<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.askwritten#">,
<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.askEHR#">,
<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.askStandard#">,
<cfif isdefined("form.nopol")>1 <cfelse>0</cfif>,
<cfif isdefined("form.confirmbase")>1 <cfelse>0</cfif>
)
</cfquery>
			<cflocation url="cat_work.cfm?objval=#session.objval#">
		<cfelseif isDefined("form.addHSC") and form.addHSC EQ "Update">
		<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="insHSC">
update  HSC
set
targmhs=<cfqueryparam cfsqltype="CF_SQL_LONGVARCHAR" value="#form.targmhs#">,
satoff=<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#form.satoff#" Null="#YesNoFormat(not Len(form.satoff))#">,
typehc=<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#form.typehc#" Null="#YesNoFormat(not Len(form.typehc))#">,
<cfif session.fy LT 2016>
askwritten= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.askwritten#" >,
askEHR= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.askEHR#" >,
askStandard= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.askStandard#" >,
nopol=<cfif isdefined("form.nopol")>1 <cfelse>0</cfif>,
confirmbase=<cfif isdefined("form.confirmbase")>1 <cfelse>0</cfif>
<cfelseif session.fy EQ 2016>
askwritten2016= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.askwritten#" >,
askEHR2016= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.askEHR#" >,
askStandard2016= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.askStandard#" >,
nopol2016=<cfif isdefined("form.nopol")>1 <cfelse>0</cfif>,
confirmbase2016=<cfif isdefined("form.confirmbase")>1 <cfelse>0</cfif>
<cfelseif session.fy EQ 2017>
askwritten2017= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.askwritten#" >,
askEHR2017= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.askEHR#" >,
askStandard2017= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.askStandard#" >,
nopol2017=<cfif isdefined("form.nopol")>1 <cfelse>0</cfif>,
confirmbase2017=<cfif isdefined("form.confirmbase")>1 <cfelse>0</cfif>
<cfelseif session.fy EQ 2018>
askwritten2018= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.askwritten#" >,
askEHR2018= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.askEHR#" >,
askStandard2018= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.askStandard#" >,
nopol2018=<cfif isdefined("form.nopol")>1 <cfelse>0</cfif>,
confirmbase2018=<cfif isdefined("form.confirmbase")>1 <cfelse>0</cfif>
<cfelseif session.fy EQ 2019>
askwritten2019= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.askwritten#" >,
askEHR2019= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.askEHR#" >,
askStandard2019= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.askStandard#" >,
nopol2019=<cfif isdefined("form.nopol")>1 <cfelse>0</cfif>,
confirmbase2019=<cfif isdefined("form.confirmbase")>1 <cfelse>0</cfif>
<cfelseif session.fy EQ 2020>
askwritten2020= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.askwritten#" >,
askEHR2020= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.askEHR#" >,
askStandard2020= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.askStandard#" >,
nopol2020=<cfif isdefined("form.nopol")>1 <cfelse>0</cfif>,
confirmbase2020=<cfif isdefined("form.confirmbase")>1 <cfelse>0</cfif>
</cfif>
where
userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
and obj=<cfqueryparam value="#session.objnum#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
and id= <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#form.selhscid#">
</cfquery>
			<cflocation url="cat_work.cfm?objval=#session.objval#">
		</cfif>
		<cfif isdefined("form.objval") or isdefined("session.objval")>
			<cfif #session.objval# is '3m'>
				<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="targadv">
	select distinct w.targetid,target
from wrkplan_targetlink w
inner join wrkplan_targets wt
on w.targetid = wt.targetid
where year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> and initiative = <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5"> and modality = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#session.modality#"> and gpme is null
order by target
</cfquery>
			<cfelse>
				<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="targcommmob">
	select targetid,target
from wrkplan_targets
<cfif session.fy EQ 2015>
where targetid in (308,245,287,322)
<cfelseif session.fy EQ 2016>
where targetid in (388,325,367,390)
<cfelseif session.fy EQ 2017>
where targetid in (458,395,437,460)
<cfelseif session.fy EQ 2018>
where targetid in (464,506,527,529)
<cfelseif session.fy EQ 2019>
where targetid in (599,557,536,534)
<cfelse>
where targetid in (243,180,222,245)
</cfif>
and year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
order by target
</cfquery>
				<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="targadv">
	select distinct w.targetid,target
from wrkplan_targetlink w
inner join wrkplan_targets wt
on w.targetid = wt.targetid
where year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> and initiative = <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5"> and modality = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#session.modality#"> and gpme is null
order by target
</cfquery>
				<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="targchc">
	select w.target_id,target
from wrkplan_targetchc w
where year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
and w.target not in
(
select
	name
	from target_org tor where
	userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and tor.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and initnum='1a'
	and stratnum=1
	)

order by target
</cfquery>
				<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="targpro">
	select w.target_id,target
from wrkplan_targetpros w
where year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
order by target
</cfquery>
			</cfif>
			<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="targgpme">
	select distinct w.targetid,target
from wrkplan_targetlink w
inner join wrkplan_targets wt
on w.targetid = wt.targetid
where year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
and initiative = <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
and modality = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#session.modality#"> and gpme = 1
order by target
</cfquery>
			<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="camptarg">
	select num,descrip
from campaigntarget
where
year2= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
order by descrip
</cfquery>
			<cfif isdefined("session.prognum") and #session.prognum# is not ''>
				<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="getgoal">
	select
program
from program
where
year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
and prognum = <cfqueryparam value="#session.prognum#" cfsqltype="CF_SQL_VARCHAR" maxlength="80">
</cfquery>
			</cfif>
			<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="Qtargorgchc">
select
	*
	from target_org tor where
	userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and tor.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and initnum=<cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	and stratnum=1
	order by name
</cfquery>
			<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="Qtargchc">
select
	*
	from target_org tor inner join target_chc c on tor.targid = c.targid where
	userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and tor.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and initnum=<cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	and stratnum=1
    and c.targid is not null
	order by name, targsite
</cfquery>
			<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="Qtargmob">
select
	*
	from target_org tor inner join target_mob c on tor.targid = c.targid where
	userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and tor.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and initnum=<cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	and stratnum=1
    and c.targid is not null
	order by name
</cfquery>
			<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="Qtargorg0">
select
	*
	from target_org tor where
	userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and tor.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and initnum=<cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	and stratnum=0
	order by name
</cfquery>
			<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="Qtargorg">
select
	*
	from target_org tor left join wrkplan_targets t on tor.targnum = t.targetid and tor.year2 = t.year2
	left join counties c on tor.county = c.fips
	where
	userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and tor.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and initnum=<cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	and stratnum=1
	order by ltrim(name)
</cfquery>
			<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="Qtargorg2">
select
	*
	from target_org tor left join wrkplan_targets t on tor.targnum = t.targetid and tor.year2 = t.year2
	where
	userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and tor.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and initnum=<cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	and stratnum=2
	order by name
</cfquery>
			<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="Qtargorg3">
select
	*
	from target_org tor left join wrkplan_targets t on tor.targnum = t.targetid and tor.year2 = t.year2
	where
	userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and tor.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and initnum=<cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	and stratnum=3
	order by name
</cfquery>
			<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="Qtargorg4">
select
	*
	from target_org
	where
	userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and initnum=<cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	and stratnum=4
	order by name
</cfquery>
			<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="Q">
select
	*
	from wrkplan_outcome
	where
	userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and initnum=<cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
</cfquery>
			<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="wrk">
select
	*
	from wrkplan w left join smartoutcomes so
	on w.userid = so.userid and w.year2 = so.year2 and w.initnum = so.initnum
	left join wrkplan_selfeval ws on w.userid = ws.userid and w.year2 = ws.year2
	and ws.initnum = w.initnum and ws.modality =<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#session.modality#">
	where
	w.userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and w.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and w.initnum=<cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
</cfquery>
		</cfif>


<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="wrk2">
select
	dispinit
	from wrkplan w
	where
	w.userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and w.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and w.initnum='6A'
</cfquery>
		<!---
			<cfput>
			select
			*
			from wrkplan w inner join smartcomes so
			on w.userid = so.userid and w.year2 = so.year2 and w.initnum = so.initnum
			where
			w.userid='#session.userid#'
			and w.year2=#session.fy#
			and w.initnum='#session.objnum#'
			#wrk.advoc#</cfput> --->
		<table class="box" align="left" cellpadding="10" cellspacing="0" border="0"  class="box" width="100%">
			<cfform name="wrk" action="cat_work.cfm?#session.urltoken#">
				<input type="hidden" name="dofunction" value="">
				<input type="hidden" name="programVal" value="">
				<input type="hidden" name="advlong" value="">
				<cfoutput>
					<input type="hidden" name="objs" value="#session.objval#">
				</cfoutput>
				<tr>
					<td colspan="2" align="left">
						<table class="box2" align="left">
							<cfoutput>
								<tr>
									<td colspan="2">
										<h3>
											Work Plan Entry
											<cfif isdefined("session.initiative")>
												<cfoutput>
													: #session.initiative#
												</cfoutput>
											</cfif>
										</h3>
									</td>
								</tr>
							</cfoutput>
							<cfif not isdefined("session.initiative") or #session.initiative# is ''>
								<tr>
									<th align="left">
										Initiative:
									</th>
								</tr>
								<tr>
									<td>
										<select name="ObjVal" onchange="form.submit();">
											<option value="">
												Select initiative
											</option>
											<cfoutput query="sampleGoalobj">
												<option value="#objnum#">
													#initiative#
												</option>
											</cfoutput>
										</select>
										<cfset session.outchg = ''>
										<cfset session.stratchg = ''>
										<cfset session.smartchg = ''>
									</td>
								</tr>
							</cfif>
							<cfif isdefined("session.initiative") and #session.initiative# is not ''>
								<cfif session.fy GT 2017 and session.objnum EQ '6A'>
									<tr><td>
									<strong>Initiatives addressed:</strong>
									</td></tr>

<cfif session.modality EQ 2>
<tr>
<th align="left">
	<input type="checkbox" value="2D" name="DispInit" <cfif ((isDefined("form.DispInit") and form.DispInit CONTAINS "2D") OR ((isDefined("wrk.DispInit") and wrk.DispInit CONTAINS "2D")))> checked</cfif>>Point of Sale (POS)
</th>
</tr>

<tr>
<th align="left">
	<input type="checkbox" value="3M" name="DispInit" <cfif ((isDefined("form.DispInit") and form.DispInit CONTAINS "3M") OR ((isDefined("wrk.DispInit") and wrk.DispInit CONTAINS "3M")))> checked</cfif> >Smoke-free Media
</th>
</tr>
<tr>
<th align="left">
	<input type="checkbox" value="4F" name="DispInit" <cfif ((isDefined("form.DispInit") and form.DispInit CONTAINS "4F") OR ((isDefined("wrk.DispInit") and wrk.DispInit CONTAINS "4F")))> checked</cfif> >Smoke-free Multi-unit Housing
</th>
</tr>
<th align="left">
	<input type="checkbox" value="2E" name="DispInit" <cfif ((isDefined("form.DispInit") and form.DispInit CONTAINS "2E") OR ((isDefined("wrk.DispInit") and wrk.DispInit CONTAINS "2E")))> checked</cfif> >Tobacco-free Outdoors
</th>
</tr>
<cfelse>
<!---<tr>
<th align="left">
	<input type="checkbox" value="8C" name="DispInit" <cfif ((isDefined("form.DispInit") and form.DispInit CONTAINS "8C") OR ((isDefined("wrk.DispInit") and wrk.DispInit CONTAINS "8C")))> checked</cfif> >Cessation Services and Media
</th>
</tr>
--->
<tr>
<th align="left">
	<input type="checkbox" value='8A' name="DispInit" <cfif ((isDefined("form.DispInit") and form.DispInit CONTAINS "8A") OR ((isDefined("wrk.DispInit") and wrk.DispInit CONTAINS "8A")))> checked</cfif> >Medical Health Systems Change
</th>
</tr>
<tr>
<th align="left">
	<input type="checkbox" value='8B' name="DispInit" <cfif ((isDefined("form.DispInit") and form.DispInit CONTAINS "8B") OR ((isDefined("wrk.DispInit") and wrk.DispInit CONTAINS "8B")))> checked</cfif> >Mental Health Systems Change
</th>
</tr>
</cfif>
<tr>
<th align="left">
	<input type="checkbox" value='9X' name="DispInit" <cfif ((isDefined("form.DispInit") and form.DispInit CONTAINS "9X") OR ((isDefined("wrk.DispInit") and wrk.DispInit CONTAINS "9X")))> checked</cfif> >Other (e.g., T21):
	<cfoutput><input type = "text" name = "othdisptxt" value = "<cfif isDefined("form.othdisptxt") and #form.othdisptxt# is not ''>#form.othdisptxt#<cfelseif isDefined("wrk.othdisptxt")>#wrk.othdisptxt#</cfif>"></cfoutput>
</th>
</tr>




<tr><td><br></td></tr>
									<tr>
										<td >
											<table id="dispartxt"class="boxy" width="80%"  style='display:block;' >
												<tr>
													<td>
														Please provide a brief description of your Disparities Project.
													</td>
												</tr>
												<tr>
													<td width=750>
														<div align="left" valign="bottom">
														<cfoutput>
															<textarea name="dispartxt" cols=135 rows=6 onkeyup="countit1(this)"><cfif isDefined("form.dispartxt") and #form.dispartxt# is not ''>#form.dispartxt#<cfelseif isDefined("wrk.dispartxt")>#wrk.dispartxt#</cfif></textarea>
														</cfoutput>
													</td>
												</tr>
												<tr>
													<td width="100%" valign="bottom">
														<div align="right" valign="bottom">
														This text field has a max of 1950 characters. Characters entered:
														<cfoutput>
															<input type="text"
															<cfif isDefined("form.dispartxt") and #form.dispartxt# is not ''>
																value="#len(wrk.dispartxt)#"
															<cfelseif isDefined("wrk.dispartxt")>
																value="#len(wrk.dispartxt)#"
															</CFIF>
															name="dispardisplaycount" size="4" style="border:0;" disabled>
														</cfoutput>
													</td>
												</tr>
												<tr>
												<tr>
													<td>
														<input type="button" value="Check Spelling" onClick="spell('document.wrk.dispartxt.value', 'document.wrk.dispartxt.value')">
													</td>
												</tr>
											</table>
										</td>
									</tr>
								</cfif>
								<cfif NOT(session.modality EQ 1 and session.objnum EQ '1H' and session.fy GTE 2014)>
									<tr>
										<td>
											<table class="box2" width=775>
												<cfif  session.fy LT 2015 AND isdefined("session.objval") and #session.objval# is not '6B' and session.objval is not '1h' and session.objval is not '1g' and session.objval is not '1a' and session.objval is not '1e' and (#session.objval# is not '2d' and #session.modality# is not 3)>
													<tr>
														<td height=10>
														</td>
													</tr>
													<tr>
														<td align="left">
															<strong>
																<cfif #session.modality# is 2 and session.objval is not '2e' and session.objval is not '4f'>
																	Objective:
																</cfif>
															</strong>
															<cfoutput>
																<cfif #session.modality# is 1>
																	#getobj.cc#
																<cfelseif #session.modality# is 2 and session.objval is not '2e' and session.objval is not '4f'>
																	#getobj.cp#
																<cfelseif #session.modality# is 3>
																	#getobj.yp#
																<cfelseif #session.modality# is 5>
																	#getobj.aa#
																<cfelse>
																</cfif>
															</cfoutput>
														</td>
													<tr>
														<td align="left">
															<strong>
																<cfif #session.modality# is 2 and session.objval is not '2e' and session.objval is not '4f'>
																	Objective:
																</cfif>
															</strong>
															<cfoutput>
																<cfif #session.modality# is 1>
																	#getobj.cc#
																<cfelseif #session.modality# is 2 and session.objval is not '2e' and session.objval is not '4f'>
																	#getobj.cp#
																<cfelseif #session.modality# is 3>
																	#getobj.yp#
																<cfelseif #session.modality# is 5>
																	#getobj.aa#
																<cfelse>
																</cfif>
															</cfoutput>
														</td>
													</tr>
												</cfif>
											</table>
										</td>
									</tr>
								</cfif>
								<cfif #session.modality# is 2 and session.objval is '4f' and session.fy LT 2015>
									<tr>
										<td align="left">
											Is this a required initiative? <input type="radio" name="reqinit" value="1" onClick="form.submit();"
											<cfif isdefined("wrk.reqinit") and #wrk.reqinit# is 1>
												checked
											</cfif>
											>Yes <input type="radio" name="reqinit" value="0" onClick="form.submit();"
											<cfif  isdefined("wrk.reqinit") and (wrk.reqinit is '' or #wrk.reqinit# is 0)>
												checked
											</cfif>
											>No
											<br>
										</td>
									</tr>
								</cfif>
								<cfif session.objval is not '1h' and session.modality is not 6 and session.objval is not '8C' and session.objval is not '6A'>
									<tr>
										<td>
											<table class="box2" align="left">
												<tr>
													<td height=10>
													</td>
												</tr>
												<th align="left">
													SMART outcome<cfif #session.objval# is not '8a' and #session.objval# is not '8b'>s</cfif>:
											</th>
												</tr>



												<tr>
													<td width=775>
														<input type="hidden" name="SO" value=1>
														<cflock
															timeout = "25"
															scope = "Application"
															type = "exclusive ">
															<!--- CFML to be synchronized --->
															<cfquery datasource="#application.DataSource#"

	password="#application.db_password#"
	username="#application.db_username#" name="so">
	select s.sonum, s.sotext, isnull(so1,' ') as so1,isnull(so2,' ') as so2
	from smartoutcome s left outer join smartoutcomes so on s.initnum = so.initnum and s.sonum = so.sonum
	and userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and so.year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	where
	s.initnum = <cfqueryparam value="#session.objnum#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and modality = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#session.modality#">
	and s.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	order by rank,
<!--- 	 <cfif #session.modality# is 2 and session.objval is '3m' and session.fy GTE 2015>
		s.sotext , s.sonum
		 <cfelse> --->
	s.sonum
	<!--- </cfif> --->
</cfquery>
															<cfloop query="so">
																<cfset txt = #Replace("#so.sotext#","''","#so.so1#","ONE")#>
																<cfset txt2 = #Replace("#txt#","''","#so.so2#","ONE")#>
																<!--- <cffile action="write"
																	file="\\pubfile01\nytobaccomx\htdocs\stage\helpme2.txt"
																	output="#txt2# " addnewline="yes"> --->
																<!--- <cfinclude template="helpme2.txt" >  --->
																<cfoutput>
																	#txt2#
																</cfoutput>
															</cfloop>
														</cflock>
													</td>
												</tr>
								</cfif>


<!--- <cfoutput>#session.initiative#</cfoutput> --->


<cfif #session.initiative# is not 'Local level evaluation' >
<cfoutput>
	<input type="hidden" name="objval" value="#session.objval#">
</cfoutput>

<cfif (isdefined("wrk.reqinit") and #wrk.reqinit# eq 1) or (isdefined("form.reqinit") and #form.reqinit# eq 1)>

	<tr><td><br></td></tr>
	<tr>
		<th align="left">Optional Outcome:</th>
	</tr>
	<tr>
		<td width=700>MUH Outcome 1b (OPTIONAL): Between July 1, 2013, and June 30, 2014, the contractor will create a local environment in at least one county that successfully demands passage of one or more local laws or regulations requiring all landlords and building owners to fully disclose their smoking policies to all current and prospective tenants.</textarea> </td> </tr> </cfif>
		<cfif session.fy LT 2012>
		<tr>
			<th align="left">Additional outcome:</th>
		</tr>
		<tr>
			<td width=700>
				<textarea id="out" name="out" cols=145 onkeyup="countit5(this)" maxlength= "1950"></textarea>
			</td>
		</tr>
		<tr>
			<td width=750><div align="right" valign="bottom">This text field has a max of 1950 characters. Characters entered:
			<cfoutput><input type="text" name="outdisplaycount" size="4" style="border:0;" disabled></cfoutput>
			</td>
		</tr> <tr><td><input type="submit" name="add" value="Add" onclick="return checkOG();" class="AddButton"></td></tr>
		<cfif Q.recordcount GT 0> <tr> <td colspan="4"> <table border=".1" align="center" class="boxy" width="90%"> <tr> <td><strong>Additional Outcomes</strong></td> <td><strong>Delete</strong></td> </tr> <cfoutput><cfloop query="Q"> <cfif outcometxt NEQ ""> <tr> <td valign="top" bgcolor="##EEEEEE">#outcometxt#</td><td bgcolor="##EEEEEE"><input type="Checkbox" name="Del_box" value="#outcomeid#"></td> </tr>
		</cfif>
		</cfloop> <tr><td colspan=2><input type="Button" name="del_staff" value="Delete" onclick="submit();" class="DelButton"> </td></tr> </cfoutput> </table> </td> </tr> </cfif> </cfif> <cfif (session.objval is '2D' OR session.objval is '2E' or session.objval is '4F' or session.objval is '3M' or session.objval is '8A' or session.objval is '8B') and session.fy GTE 2015  and session.fy LT 2018> <tr><td><br><br></td></tr> <tr> <td>Do you have a Disparities Project for this initiative?<br> <input type="radio" name="dispar" id="dispar_0" value="0" onclick="toggle_visibility10('dispartxt');" <cfif isDefined("form.dispar") and form.dispar EQ 0> checked<cfelseif (isDefined("wrk.dispar") and #wrk.dispar# is 0)> checked</cfif>> No <br> <input type="radio" name="dispar" id="dispar_1" value="1" onclick="toggle_visibility10('dispartxt');" <cfif isDefined("form.dispar") and form.dispar EQ 1> checked<cfelseif (isDefined("wrk.dispar") and #wrk.dispar# is 1)> checked</cfif>> Yes <br><br> </td> </tr> <tr> <td colspan="4"> <table id="dispartxt"class="boxy" width="80%" <cfif isDefined("wrk.dispar") and #wrk.dispar# is 1> style='display:block;' <cfelse> style='display:none;'</cfif>> <tr><td>Please provide a brief description of your Disparities Project.</td></tr> <tr> <td width=750><div align="left" valign="bottom"> <cfoutput><textarea name="dispartxt" cols=135 rows=6 onkeyup="countit1(this)"><cfif isDefined("form.dispartxt") and #form.dispartxt# is not ''>#form.dispartxt#<cfelseif isDefined("wrk.dispartxt")>#wrk.dispartxt#</cfif></textarea> </cfoutput> </td> </tr> <tr> <td width="100%" valign="bottom"><div align="right" valign="bottom">This text field has a max of 1950 characters. Characters entered: <cfoutput><input type="text" <cfif isDefined("form.dispartxt") and #form.dispartxt# is not ''>value="#len(wrk.dispartxt)#"<cfelseif isDefined("wrk.dispartxt")>value="#len(wrk.dispartxt)#"</CFIF> name="dispardisplaycount" size="4" style="border:0;" disabled></cfoutput></td> </tr> <tr> <tr><td><input type="button" value="Check Spelling" onClick="spell('document.wrk.dispartxt.value', 'document.wrk.dispartxt.value')"> </table> </cfif> <cfif session.modality EQ 1 and (session.objnum EQ '8A' or session.objnum EQ '8B')> <cfquery datasource="#application.DataSource#" password="#application.db_password#"	username="#application.db_username#" name="AskAdvise">
	select id, label
	from askadvise
	where year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	order by rank

</cfquery>

<cfif isdefined("url.target") and url.target EQ "TMHS" >
<cfset askwrittenbase=""> <cfset askwritten=""> <cfset askehrbase=""> <cfset askehr=""> <cfset askstandardbase=""> <cfset askstandard="">
<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="indSELHSC">
SELECT ID, targmhs, satoff, typehc,askwritten, askEHR, askStandard, nopol,nopol2017, confirmbase,year2
FROM HSC
WHERE OBJ = <cfqueryparam value="#session.objnum#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
AND USERID = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
and id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.seq#">
ORDER BY 1
</cfquery>

<cfif indselhsc.recordcount gt 0> <cfset targmhs = #indselhsc.targmhs#> <cfset satoff = #indselhsc.satoff#> <cfset typehc = #indselhsc.typehc#> </cfif> <cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="indSELHSCbase2015">
SELECT ID, targmhs, satoff, typehc,askwritten, askEHR, askStandard, nopol, confirmbase,year2
FROM HSC
WHERE year2 = 2015
and OBJ = <cfqueryparam value="#session.objnum#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
AND USERID = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
and id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.seq#">
ORDER BY 1
</cfquery> <cfif indselhscbase2015.recordcount gt 0> <cfset askwrittenbase = #indselhscbase2015.askwritten#> <cfset askehrbase = #indselhscbase2015.askehr#> <cfset askstandardbase = #indselhscbase2015.askstandard#> </cfif> <cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="indSELHSCbase2016">
SELECT ID, targmhs, satoff, typehc,askwritten2016 as askwritten, askehr2016 as askEHR, askstandard2016 as askStandard, nopol, confirmbase,year2
FROM HSC
WHERE year2 = 2016
and OBJ = <cfqueryparam value="#session.objnum#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
AND USERID = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
and id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.seq#">
ORDER BY 1
</cfquery> <cfif indselhscbase2016.recordcount gt 0> <cfset askwrittenbase2016 = #indselhscbase2016.askwritten#> <cfset askehrbase2016 = #indselhscbase2016.askehr#> <cfset askstandardbase2016 = #indselhscbase2016.askstandard#> </cfif> <cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="indSELHSCbase2017">
SELECT ID, targmhs, satoff, typehc,askwritten2017 as askwritten, askehr2017 as askEHR, askstandard2017 as askStandard, nopol, confirmbase,year2
FROM HSC
WHERE year2 = 2017
and OBJ = <cfqueryparam value="#session.objnum#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
AND USERID = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
and id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.seq#">
ORDER BY 1
</cfquery>
<cfif indselhscbase2017.recordcount gt 0> <cfset askwrittenbase2017 = #indselhscbase2017.askwritten#> <cfset askehrbase2017 = #indselhscbase2017.askehr#> <cfset askstandardbase2017 = #indselhscbase2017.askstandard#> </cfif>
<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="indSELHSCbase2018">
SELECT ID, targmhs, satoff, typehc,askwritten2018 as askwritten, askehr2018 as askEHR, askstandard2018 as askStandard, nopol, confirmbase,year2
FROM HSC
WHERE year2 = 2018
and OBJ = <cfqueryparam value="#session.objnum#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
AND USERID = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
and id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.seq#">
ORDER BY 1
</cfquery>
<cfif indselhscbase2018.recordcount gt 0> <cfset askwrittenbase2018 = #indselhscbase2018.askwritten#> <cfset askehrbase2018 = #indselhscbase2018.askehr#> <cfset askstandardbase2018 = #indselhscbase2018.askstandard#> </cfif>
<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="indSELHSCbase2019">
SELECT ID, targmhs, satoff, typehc,askwritten2019 as askwritten, askehr2019 as askEHR, askstandard2019 as askStandard, nopol, confirmbase,year2
FROM HSC
WHERE year2 = 2019
and OBJ = <cfqueryparam value="#session.objnum#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
AND USERID = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
and id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.seq#">
ORDER BY 1
</cfquery>
<cfif indselhscbase2019.recordcount gt 0> <cfset askwrittenbase2019 = #indselhscbase2019.askwritten#> <cfset askehrbase2019 = #indselhscbase2019.askehr#> <cfset askstandardbase2019 = #indselhscbase2019.askstandard#> </cfif>

<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="indSELHSCbase2016">
SELECT ID, targmhs, satoff, typehc, askwritten2016 as askwritten, askEHR2016 as askEHR, askStandard2016 as askstandard, nopol, confirmbase2016
FROM HSC
WHERE (YEAR2 <= 2016)
AND OBJ = <cfqueryparam value="#session.objnum#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
AND USERID = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
and id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.seq#">
ORDER BY 1
</cfquery>
<cfif session.fy GTE 2016>
<cfif indselhscbase2016.recordcount gt 0>
<cfset askwritten2016 = #indselhscbase2016.askwritten#>
<cfset askehr2016 = #indselhscbase2016.askehr#>
<cfset askstandard2016 = #indselhscbase2016.askstandard#>
</cfif>
</cfif>
<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="indSELHSCbase2017">
SELECT ID, targmhs, satoff, typehc, askwritten2017 as askwritten, askEHR2017 as askEHR, askStandard2017 as askstandard, nopol, confirmbase2017
FROM HSC
WHERE (YEAR2 <= 2017)
AND OBJ = <cfqueryparam value="#session.objnum#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
AND USERID = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
<cfif isdefined("url.seq")>
and id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.seq#"></cfif>
ORDER BY 1
</cfquery>
<cfif indselhscbase2017.recordcount gt 0>
<cfif session.fy GTE 2017>
<cfset askwritten2017 = #indselhscbase2017.askwritten#>
<cfset askehr2017 = #indselhscbase2017.askehr#>
<cfset askstandard2017 = #indselhscbase2017.askstandard#>
</cfif>
</cfif>
<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="indSELHSCbase2018">
SELECT ID, targmhs, satoff, typehc, askwritten2018 as askwritten, askEHR2018 as askEHR, askStandard2018 as askstandard, nopol, confirmbase2018
FROM HSC
WHERE (YEAR2 <= 2018)
AND OBJ = <cfqueryparam value="#session.objnum#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
AND USERID = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
<cfif isdefined("url.seq")>
and id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.seq#"></cfif>
ORDER BY 1
</cfquery>
<cfif indselhscbase2018.recordcount gt 0>
<cfif session.fy GTE 2018>
<cfset askwritten2018 = #indselhscbase2018.askwritten#>
<cfset askehr2018 = #indselhscbase2018.askehr#>
<cfset askstandard2018 = #indselhscbase2018.askstandard#>
</cfif>
</cfif>

<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="indSELHSCbase2019">
SELECT ID, targmhs, satoff, typehc, askwritten2019 as askwritten, askEHR2019 as askEHR, askStandard2019 as askstandard, nopol, confirmbase2019
FROM HSC
WHERE (YEAR2 <= 2019)
AND OBJ = <cfqueryparam value="#session.objnum#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
AND USERID = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
<cfif isdefined("url.seq")>
and id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.seq#"></cfif>
ORDER BY 1
</cfquery>
<cfif indselhscbase2019.recordcount gt 0>
<cfif session.fy GTE 2019>
<cfset askwritten2019 = #indselhscbase2019.askwritten#>
<cfset askehr2019 = #indselhscbase2019.askehr#>
<cfset askstandard2019 = #indselhscbase2019.askstandard#>
</cfif>
</cfif>

<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="getHSCmon">
<!---    select c.id,targmhs,typehc,h.year2,
	c.plcwritpol,c.ehr,c.writstd,
	c.askwritten,	c.askEHR,	c.askStandard

	from HSC_mon  c, hsc h
	where c.id = h.id and (c.year2 = #session.fy#-1 or c.year2 = #session.fy#)
and c.id = <cfif isdefined("url.seq")>#url.seq#<cfelse>#form.id#</cfif> --->

   select hh.id, targmhs,typehc,hh.year2,
	stuff((select ','+	isnull(c.askwritten, 0) from HSC_mon  c, hsc h 	where  c.id = h.id and h.id= hh.id and (c.year2 < <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">)<cfif isdefined("url.seq") or isdefined("form.id")> and c.id = <cfif isdefined("url.seq")><cfqueryparam value="#url.seq#" cfsqltype="CF_SQL_INTEGER"><cfelse><cfqueryparam value="#form.id#" cfsqltype="CF_SQL_INTEGER"></cfif></cfif> for xml path('')), 1,1,'') as askwritten,
	stuff((select ','+	isnull(c.askEHR, 0) from HSC_mon  c, hsc h 	where c.id = h.id and  h.id= hh.id and (c.year2 < <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">)<cfif isdefined("url.seq") or isdefined("form.id")> and c.id = <cfif isdefined("url.seq")><cfqueryparam value="#url.seq#" cfsqltype="CF_SQL_INTEGER"><cfelse><cfqueryparam value="#form.id#" cfsqltype="CF_SQL_INTEGER"></cfif></cfif> for xml path('')), 1,1,'') as askEHR,
	stuff((select ','+	isnull(c.askStandard, 0) from HSC_mon  c, hsc h 	where  c.id = h.id and h.id= hh.id and (c.year2 < <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">)<cfif isdefined("url.seq") or isdefined("form.id")> and c.id = <cfif isdefined("url.seq")><cfqueryparam value="#url.seq#" cfsqltype="CF_SQL_INTEGER"><cfelse><cfqueryparam value="#form.id#" cfsqltype="CF_SQL_INTEGER"></cfif></cfif> for xml path('')), 1,1,'') as askStandard
	FROM HSC hh left outer join hsc_mon c on hh.id = c.id
	where  (hh.year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	<cfif session.fy gte '2016'>or hh.year2 <= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">-1</cfif> )
	<cfif isdefined("url.seq") or isdefined("form.id")>
and hh.id = <cfif isdefined("url.seq")><cfqueryparam value="#url.seq#" cfsqltype="CF_SQL_INTEGER"><cfelse>
<cfqueryparam value="#form.id#" cfsqltype="CF_SQL_INTEGER"></cfif></cfif>
group by
hh.id,targmhs,typehc,hh.year2
</cfquery> </cfif><cfif isDefined("indSELHSC.id") and indSELHSC.id is not ''> <input type="hidden" name="selhscid" <cfoutput>value="#indSELHSC.id#"</cfoutput>> <input type="hidden" name="year2" <cfoutput>value="#indSELHSC.year2#"</cfoutput>> </cfif> <a name="TMHS"></a> <tr><td><table class="box2" width="800"> <tr><td height=10></td></tr> <tr><td><strong>Target <cfif session.objnum EQ "8B">Mental<cfelse>Medical</cfif> Health Systems</strong></td></tr> <tr><td><table class="boxy"> <tr> <th>Target <cfif session.objnum EQ "8B">Mental<cfelse>Medical</cfif> Health Systems:</th> <th>#satellite offices:</th> <th>Type of healthcare organization:</th> </tr> <cfoutput> <tr> <td><textarea name="targMHS" cols="30" rows="4"><cfif isDefined("targmhs") and #targmhs# is not ''>#targMHS#<cfelseif isdefined("getHSCmon.targmhs") and #gethscmon.targmhs# is not ''>#getHSCmon.targMHS#</cfif> </textarea></td> <td align="center" width="270"><input type="text" size="3" name="satOff" maxlength=3 <cfif isDefined("satoff") and #satoff# is not ''>value = "#satOff#"<cfelseif isdefined("getHSCmon.satoff") and #gethscmon.satoff# is not ''>value=#getHSCmon.satoff#</cfif>></td> <td  width="270"><select name="typeHC" id="typeHC" <cfif isdefined("indselhsc.year2") and #indselhsc.year2# LT 2016 and #indSELHSC.typeHC# is not ''>disabled</cfif>> <option value="-" >-Please select a Type of Healthcare organization-</option> <cfif session.objval EQ '8A'> <option value="1" <cfif (isDefined("typeHC") and listfind(typeHC,1)) or (isDefined("getHSCmon") and listfind(getHSCmon.typeHC,1))> selected</cfif>>CHC</option> <option value="2" <cfif (isDefined("typeHC") and listfind(typeHC,2)) or (isDefined("getHSCmon") and listfind(getHSCmon.typeHC,2))> selected</cfif>>Primary Care Clinic</option> <option value="3" <cfif (isDefined("typeHC") and listfind(typeHC,3)) or (isDefined("getHSCmon") and listfind(getHSCmon.typeHC,3))> selected</cfif>>Hospital Outpatient Clinic</option> <option value="4" <cfif (isDefined("typeHC") and listfind(typeHC,4)) or (isDefined("getHSCmon") and listfind(getHSCmon.typeHC,4))> selected</cfif> <cfif isDefined("wrk.dispar") and #wrk.dispar# is 0> disabled</cfif>>Other health center - part of Disparities Project</option> <cfelse> <option value="1" <cfif (isDefined("typeHC") and listfind(typeHC,1)) or (isDefined("getHSCmon") and listfind(getHSCmon.typeHC,1))> selected</cfif>>Hospital Outpatient Mental Health Clinic</option> <option value="2" <cfif (isDefined("typeHC") and listfind(typeHC,2)) or (isDefined("getHSCmon") and listfind(getHSCmon.typeHC,2))> selected</cfif>>Mental Health Service Organization</option> <option value="3" <cfif (isDefined("typeHC") and listfind(typeHC,3)) or (isDefined("getHSCmon") and listfind(getHSCmon.typeHC,3)) or (isDefined("indSELHSCbase2016") and listfind(indSELHSCbase2016.typeHC,3)) or (isDefined("indSELHSCbase2017") and listfind(indSELHSCbase2017.typeHC,3)) or (isDefined("indSELHSCbase2018") and listfind(indSELHSCbase2018.typeHC,3)) or (isDefined("indSELHSCbase2019") and listfind(indSELHSCbase2019.typeHC,3))> selected</cfif>>Behavioral Health Service Organization</option> </cfif> </select> </td> </tr> <tr> <td colspan="3"> <strong>Baseline info:</strong> Please indicate which of the following policies/systems and their components are present at the time you are adding this target organization to CAT. </td> </tr> <tr><th>In place as written policy</th> <th>In place as EHR</th> <th>In place as written standard of care or protocol</th> </tr> </cfoutput> <tr><td><cfoutput query="AskAdvise"> <cfif (isDefined("askwrittenbase") and listfind(askWrittenbase,#id#)) or (isDefined("askwrittenbase2016") and listfind(askWrittenbase2016,#id#)) or (isDefined("askwrittenbase2017") and listfind(askWrittenbase2017,#id#)) or (isDefined("askwrittenbase2018") and listfind(askWrittenbase2018,#id#))><strong>B</strong> &nbsp;&nbsp;<strong>#label#</strong><br><cfelse> <input type="checkbox" name="askWritten" value="#id#" onClick="checkBaseline();" <cfif (isDefined("askwritten") and listfind(askwritten,#id#)) or (isDefined("askwritten2016") and listfind(askwritten2016,#id#)) or (isDefined("askwritten2017") and listfind(askwritten2017,#id#)) or (isDefined("askwritten2018") and listfind(askwritten2018,#id#)) or (isDefined("askwritten2019") and listfind(askwritten2019,#id#)) or (isDefined("askwrittenbase") and listfind(askwrittenbase,#id#)) or (isDefined("gethscmon") and listfind(gethscmon.askwritten,#id#))> checked</cfif> <cfif (isDefined("gethscmon") and listfind(gethscmon.askwritten,#id#)<!--- or (isDefined("indSELHSCbase") and indSELHSCbase.recordcount GT 0)--->)>disabled readonly</cfif>><strong>#label#</strong><br> </cfif></cfoutput> </td> <td><cfoutput query="AskAdvise"><cfif (isDefined("askehrbase") and listfind(askEHRbase,#id#)) or (isDefined("askehrbase2016") and listfind(askEHRbase2016,#id#)) or (isDefined("askehrbase2017") and listfind(askEHRbase2017,#id#)) or (isDefined("askehrbase2018") and listfind(askEHRbase2018,#id#))><strong>B</strong> &nbsp;&nbsp;<strong>#label#</strong><br><cfelse> <input type="checkbox" name="askEHR" value="#id#" onClick="checkBaseline();" <!---<cfif #findoneof("789",id)#> disabled</cfif>---> <cfif (isDefined("askehr") and listfind(askehr,#id#)) or (isDefined("askehr2016") and listfind(askehr2016,#id#)) or (isDefined("askehr2017") and listfind(askehr2017,#id#))  or (isDefined("askehr2018") and listfind(askehr2018,#id#)) or (isDefined("askehr2019") and listfind(askehr2019,#id#)) or (isDefined("askehrbase") and listfind(askehrbase,#id#)) or (isDefined("gethscmon") and listfind(gethscmon.askehr,#id#))> checked</cfif> <cfif (isDefined("gethscmon") and listfind(gethscmon.askehr,#id#)<!--- or (isDefined("indSELHSCbase") and indSELHSCbase.recordcount GT 0)--->)>disabled readonly</cfif>><strong>#label#</strong><br> </cfif> </cfoutput> </td> <td><cfoutput query="AskAdvise"> <cfif (isDefined("askstandardbase") and listfind(askstandardbase,#id#)) or (isDefined("askstandardbase2016") and listfind(askstandardbase2016,#id#)) or (isDefined("askstandardbase2017") and listfind(askstandardbase2017,#id#)) or (isDefined("askstandardbase2018") and listfind(askstandardbase2018,#id#))><strong>B</strong> &nbsp;&nbsp;<strong>#label#</strong><br><cfelse> <input type="checkbox" name="askStandard" value="#id#" onClick="checkBaseline();" <!---<cfif #findoneof("7",id)#> disabled<cfelseif  listfind(10,#id#)> disabled</cfif>---> <cfif (isDefined("askstandardbase") and listfind(askstandardbase,#id#)) or (isDefined("askstandard") and listfind(askstandard,#id#)) or (isDefined("askstandard2016") and listfind(askstandard2016,#id#)) or (isDefined("askstandard2017") and listfind(askstandard2017,#id#)) or (isDefined("askstandard2018") and listfind(askstandard2018,#id#)) or (isDefined("askstandard2019") and listfind(askstandard2019,#id#)) or (isDefined("gethscmon") and listfind(gethscmon.askstandard,#id#))> checked</cfif> <cfif (isDefined("gethscmon") and listfind(gethscmon.askstandard,#id#)<!--- or (isDefined("indSELHSCbase") and indSELHSCbase.recordcount GT 0)--->)>disabled readonly</cfif>><strong>#label#</strong><br> </cfif> </cfoutput></td></tr> <tr><td colspan="3"><cfif isDefined("indSELHSC") and indSELHSC.noPol EQ 1><strong>B</strong> <cfelse> <input type="checkbox" id="noPol" name="noPol" value=1 <cfif (isDefined("indSELHSC") and indSELHSC.noPol EQ 1) OR (isDefined("indSELHSC") and indSELHSC.noPol2017 EQ 1) > checked</cfif> <cfif isDefined("indSELHSC") and (indSELHSC.askWritten NEQ "" OR indSELHSC.askEHR NEQ "" OR indSELHSC.askStandard NEQ ""<!--- or (isDefined("indSELHSC") and indSELHSC.recordcount GT 0)--->)> disabled readonly</cfif> ></cfif> This target organization does not have a baseline policy, standard of care, or protocol in place.</td></tr> <tr><td colspan="3"> <cfif isDefined("indSELHSC") and indSELHSC.confirmBase EQ 1><strong>B</strong> <cfelse> <input type="checkbox" id="confirmBase" name="confirmBase" value=1 <cfif ((isDefined("indSELHSC") and indSELHSC.confirmBase EQ 1) or (isDefined("indSELHSCbase2016") and indSELHSCbase2016.confirmBase2016 EQ 1) or (isDefined("indSELHSCbase2017") and indSELHSCbase2017.confirmBase2017 EQ 1) or (isDefined("indSELHSCbase2018") and indSELHSCbase2018.confirmBase2018 EQ 1) or (isDefined("indSELHSCbase2019") and indSELHSCbase2019.confirmBase2019 EQ 1))> checked</cfif> <!---<cfif isDefined("indSELHSCbase") and indSELHSCbase.recordcount GT 0> disabled readonly</cfif>---> > </cfif> I confirm that all baseline data is represented in the table above.</td></tr> <tr><Td colspan="3"> <cfif isDefined("indSELHSC.id") and indSELHSC.id is not ''> <input type="submit" name="addHSC" value="Update" class="AddButton" onclick="return checkHSC();"> <cfelse> <input type="submit" name="addHSC" value="Add" class="AddButton"  onclick="return checkHSC();"> </cfif> </td></tr> </table></td></tr> <cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="SELHSC">

<!--- SELECT h.id, h.year2,targmhs, nopol2016,confirmbase2016,satoff, typehc,h.askwritten, hm.askwritten as askwritten_mon,askwritten2016,askehr2016,askstandard2016,h.askEHR, hm.askehr as askehr_mon,h.askStandard, hm.askstandard as askstandard_mon,h.nopol, h.confirmbase, h.year2
FROM HSC h left outer join hsc_mon hm on h.id = hm.id
where (h.YEAR2 = #session.fy# <cfif session.fy gte 2016>or h.year2 = #session.fy#-1</cfif>)
AND OBJ = '#session.objnum#'
AND USERID = '#session.userid#'
ORDER BY cast(targmhs as varchar) --->


SELECT distinct hh.id, hh.year2,ltrim(targmhs) as targmhs, nopol2016, confirmbase2016,satoff, typehc,hh.nopol, hh.confirmbase, hh.year2,cast(targmhs as varchar),
stuff ((select ','+	h.askwritten FROM HSC h left  join hsc_mon hm on h.id = hm.id  where  hh.id = h.id   and (h.YEAR2 <= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> ) AND OBJ = <cfqueryparam value="#session.objnum#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> AND USERID = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">  for xml path('')), 1,1,'') as askwritten,
stuff ((select ','+	askwritten2019 FROM HSC h left  join hsc_mon hm on h.id = hm.id where  hh.id = h.id and (h.YEAR2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> <cfif session.fy gte 2016>or h.year2 <= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"></cfif>) AND OBJ = <cfqueryparam value="#session.objnum#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> AND USERID = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">  for xml path('')), 1,1,'') as askwritten2019,
stuff ((select ','+	askwritten2018 FROM HSC h left  join hsc_mon hm on h.id = hm.id where  hh.id = h.id and (h.YEAR2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> <cfif session.fy gte 2016>or h.year2 <= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"></cfif>) AND OBJ = <cfqueryparam value="#session.objnum#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> AND USERID = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">  for xml path('')), 1,1,'') as askwritten2018,
stuff ((select ','+	askwritten2017 FROM HSC h left  join hsc_mon hm on h.id = hm.id where  hh.id = h.id and (h.YEAR2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> <cfif session.fy gte 2016>or h.year2 <= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"></cfif>) AND OBJ = <cfqueryparam value="#session.objnum#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> AND USERID = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">  for xml path('')), 1,1,'') as askwritten2017,
stuff ((select ','+	askwritten2016 FROM HSC h left  join hsc_mon hm on h.id = hm.id where  hh.id = h.id and (h.YEAR2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> <cfif session.fy gte 2016>or h.year2 <= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"></cfif>) AND OBJ = <cfqueryparam value="#session.objnum#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> AND USERID = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">  for xml path('')), 1,1,'') as askwritten2016,
stuff ((select ','+	h.askEHR FROM HSC h left  join hsc_mon hm on h.id = hm.id   where  hh.id = h.id AND (h.YEAR2 <= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> ) AND OBJ = <cfqueryparam value="#session.objnum#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> AND USERID = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">  for xml path('')), 1,1,'') as askEHR,
stuff ((select ','+	hm.askehr FROM HSC h left  join hsc_mon hm on h.id = hm.id  and hh.id = h.id where (hm.YEAR2 < <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">) AND OBJ = <cfqueryparam value="#session.objnum#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> AND USERID = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">  for xml path('')), 1,1,'') as askehr_mon,
stuff ((select ','+	askehr2019 FROM HSC h left  join hsc_mon hm on h.id = hm.id where  hh.id = h.id  and (h.YEAR2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> <cfif session.fy gte 2016>or h.year2 <= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"></cfif>) AND OBJ = <cfqueryparam value="#session.objnum#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> AND USERID = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">  for xml path('')), 1,1,'') as askehr2019,
stuff ((select ','+	askehr2018 FROM HSC h left  join hsc_mon hm on h.id = hm.id where  hh.id = h.id  and (h.YEAR2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> <cfif session.fy gte 2016>or h.year2 <= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"></cfif>) AND OBJ = <cfqueryparam value="#session.objnum#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> AND USERID = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">  for xml path('')), 1,1,'') as askehr2018,
stuff ((select ','+	askehr2017 FROM HSC h left  join hsc_mon hm on h.id = hm.id where  hh.id = h.id  and (h.YEAR2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> <cfif session.fy gte 2016>or h.year2 <= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"></cfif>) AND OBJ = <cfqueryparam value="#session.objnum#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> AND USERID = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">  for xml path('')), 1,1,'') as askehr2017,
stuff ((select ','+	askehr2016 FROM HSC h left  join hsc_mon hm on h.id = hm.id where  hh.id = h.id  and (h.YEAR2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> <cfif session.fy gte 2016>or h.year2 <= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"></cfif>) AND OBJ = <cfqueryparam value="#session.objnum#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> AND USERID = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">  for xml path('')), 1,1,'') as askehr2016,
stuff ((select ','+	h.askStandard FROM HSC h left  join hsc_mon hm on h.id = hm.id  where  hh.id = h.id  AND (h.YEAR2 <= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">) AND OBJ = <cfqueryparam value="#session.objnum#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> AND USERID = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">  for xml path('')), 1,1,'') as askStandard,
stuff ((select ','+	askstandard2019 FROM HSC h left  join hsc_mon hm on h.id = hm.id where  hh.id = h.id and (h.YEAR2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> <cfif session.fy gte 2016>or h.year2 <= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"></cfif>) AND OBJ = <cfqueryparam value="#session.objnum#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> AND USERID = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">  for xml path('')), 1,1,'') as askstandard2019,
stuff ((select ','+	askstandard2018 FROM HSC h left  join hsc_mon hm on h.id = hm.id where  hh.id = h.id and (h.YEAR2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> <cfif session.fy gte 2016>or h.year2 <= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"></cfif>) AND OBJ = <cfqueryparam value="#session.objnum#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> AND USERID = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">  for xml path('')), 1,1,'') as askstandard2018,
stuff ((select ','+	askstandard2017 FROM HSC h left  join hsc_mon hm on h.id = hm.id where  hh.id = h.id and (h.YEAR2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> <cfif session.fy gte 2016>or h.year2 <= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"></cfif>) AND OBJ = <cfqueryparam value="#session.objnum#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> AND USERID = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">  for xml path('')), 1,1,'') as askstandard2017,
stuff ((select ','+	askstandard2016 FROM HSC h left  join hsc_mon hm on h.id = hm.id where  hh.id = h.id and (h.YEAR2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> <cfif session.fy gte 2016>or h.year2 <= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"></cfif>) AND OBJ = <cfqueryparam value="#session.objnum#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> AND USERID = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">  for xml path('')), 1,1,'') as askstandard2016,
stuff ((select ','+	hm.askwritten FROM HSC h left  join hsc_mon hm on h.id = hm.id  and hh.id = h.id where (hm.YEAR2 < <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">) AND OBJ = <cfqueryparam value="#session.objnum#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> AND USERID = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">  for xml path('')), 1,1,'') as askwritten_mon,
stuff ((select ','+	hm.askstandard FROM HSC h left  join hsc_mon hm on h.id = hm.id  and hh.id = h.id where (hm.YEAR2 <  <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">) AND OBJ = <cfqueryparam value="#session.objnum#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> AND USERID = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> for xml path('')), 1,1,'') as askstandard_mon
FROM HSC hh left outer join hsc_mon hm on hh.id = hm.id
where (hh.YEAR2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
<cfif session.fy gte 2016>or hh.year2 <= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"></cfif>)
AND OBJ = <cfqueryparam value="#session.objnum#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
AND USERID = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
group by hh.id, hh.year2,targmhs, nopol2016,confirmbase2016,satoff, typehc,hh.nopol, hh.confirmbase, hh.year2,cast(targmhs as varchar)
ORDER BY targmhs


</cfquery> <CFIF SELHSC.RECORDCOUNT NEQ 0> <tr><td><table class="boxy">
<tr><td colspan=4><br><br></td></tr>
<CFOUTPUT query="SELHSC" group="id">
<tr> <td bgcolor="##EEEEEE"><a href="javascript: document.wrk.action='cat_work.cfm?#session.urltoken#&target=TMHS&seq=#ID###TMHS'; document.wrk.submit()">#targmhs#</a></td>
<td bgcolor="##EEEEEE">##satellite offices: #satoff#</td>
<td bgcolor="##EEEEEE"> <cfif session.objval EQ '8A'> <cfif typehc eq 1>CHC</cfif> <cfif typehc eq 2>Primary Care Clinic</cfif> <cfif typehc eq 3>Hospital Outpatient Clinic</cfif> <cfif typehc eq 4>Other health center - part of Disparities Project</cfif> <cfelse> <cfif typehc eq 1>Hospital Outpatient Mental Health Clinic</cfif> <cfif typehc eq 2>Mental Health Service Organization</cfif> <cfif typehc eq 3>Behavioral Health Service Organization</cfif> </cfif> </td>
<TD rowspan="2" bgcolor="##EEEEEE"><INPUT TYPE="CHECKBOX" NAME="dELhsc" VALUE="#ID#">Delete</TD> </tr>
<tr> <td> In place written policy:<br> <cfloop query="AskAdvise">
<cfif session.fy gte 2016>
<cfif listfind(SELHSC.askwritten, "#askadvise.id#") or  listfind(SELHSC.askwritten_mon, "#askadvise.id#") or listfind(SELHSC.askwritten2016, "#askadvise.id#")
or listfind(SELHSC.askwritten2017, "#askadvise.id#") or listfind(SELHSC.askwritten2018, "#askadvise.id#") or listfind(SELHSC.askwritten2019, "#askadvise.id#")>#askadvise.label#<br></cfif>
<cfelse> <cfif listfind(SELHSC.askwritten, "#askadvise.id#")>#askadvise.label#<br></cfif> </cfif> </cfloop> </td>
<td> In place EHR:<br> <cfloop query="AskAdvise">
<cfif session.fy gte 2016><cfif listfind(SELHSC.askehr, "#askadvise.id#") or  listfind(SELHSC.askehr_mon, "#askadvise.id#") or listfind(SELHSC.askehr2016, "#askadvise.id#")
or listfind(SELHSC.askehr2017, "#askadvise.id#") or listfind(SELHSC.askehr2018, "#askadvise.id#") or listfind(SELHSC.askehr2019, "#askadvise.id#")>#askadvise.label#<br></cfif>
<cfelse> <cfif listfind(SELHSC.askehr, "#askadvise.id#")>#askadvise.label#<br></cfif> </cfif> </cfloop> </td>
<td> In place as written standard of care<cfif session.objnum EQ "8A"> or protocol</cfif>:<br> <cfloop query="AskAdvise">
<cfif session.fy gte 2016><cfif listfind(SELHSC.askstandard, "#askadvise.id#") or  listfind(SELHSC.askstandard_mon, "#askadvise.id#") or listfind(SELHSC.askstandard2016, "#askadvise.id#")
or listfind(SELHSC.askstandard2017, "#askadvise.id#") or listfind(SELHSC.askstandard2018, "#askadvise.id#") or listfind(SELHSC.askstandard2019, "#askadvise.id#")>#askadvise.label#<br></cfif>
<cfelse> <cfif listfind(SELHSC.askstandard, "#askadvise.id#")>#askadvise.label#<br></cfif> </cfif> </cfloop> </td> </tr>
<tr> <td colspan="3">
<cfif selhsc.year2 LT 2016> <cfif nopol2016 eq 1 or (nopol EQ 1 and nopol2016 neq 0)>Target organization does not have a baseline policy, standard of care, or protocol in place<br></cfif> <cfelse> <cfif nopol EQ 1>Target organization does not have a baseline policy, standard of care, or protocol in place<br></cfif> </cfif>
<cfif selhsc.year2 LT 2016><cfif confirmbase2016 EQ 1 or (confirmbase eq 1 and confirmbase2016 neq 0)>Baseline data confirmed<br></cfif> <cfelse><cfif confirmbase2016 EQ 1>Baseline data confirmed<br></cfif></cfif> </td> </tr> </CFOUTPUT> <tr><td colspan=4> <input type="submit" name="del_hsc" value="Delete" onclick="return confirmDelx();" class="DelButton"></td></tr> </table></td></tr> </CFIF> </table></td></tr> </cfif> <cfif session.objval is '3m' and session.fy LT 2015> <tr><td>&nbsp;</td></tr> <tr> <td><input type="Checkbox" name="addlSO" value="1" onclick="toggle_visibility7('addlSOtxt');" <cfif isDefined("wrk.addlSO") and  #wrk.addlSO# is 1>checked</cfif>> Optional SFM Outcome</td> </tr> <tr> <td colspan="4"> <table border=".1" id="addlSOtxt"class="boxy" width="80%" <cfif isDefined("wrk.addlSO") and #wrk.addlSO# is not 1>style='display:none;'</cfif>> <tr> <td width=750><div align="left" valign="bottom"><cfoutput><textarea name="addlSOtxt" cols=135 rows=6 ><cfif isDefined("wrk.addlSOtxt")>#wrk.addlSOtxt#</cfif></textarea> </cfoutput></td> </tr>
						</table>
						</cfif>
		</table>
		<cfif isdefined("session.objval") and session.objval is '1g' and session.fy gte 2013> <p> <tr><td>&nbsp;</td></tr> <tr><td> <table border=".1" align="left" class="boxy" width="100%"> <tr><td align="left"><strong>Target PROS programs:</strong> </td></tr> <tr> <td align="left"> <select name="oname"><option value="">Please select</option> <cfoutput query="targpro"> <option value="#target#">#target#</option></cfoutput> </select> </td> </tr> <tr><Td colspan=4> <cfif isDefined("Qgettarg1")> <input type="submit" name="addadvorg" value="Update" class="AddButton" onclick="return checkPOS();"> <cfelse> <input type="submit" name="addadvorg" value="Add" class="AddButton" onclick="return checkPOS();"> </cfif> </td></tr> </table></td></tr><p></cfif> <cfif qtargorg.recordcount GT 0 and session.objnum is '1g'> <tr><td> <table border=".1" align="LEFT" class="boxy"> <tr> <th <!--- width="45%" --->>Target PROS programs</th> <th width="10%">Delete</th> </tr> <cfoutput><cfloop query="qtargorg"> <tr> <td valign="top" bgcolor="##EEEEEE">#name#</td> <td valign="top" bgcolor="##EEEEEE" align="center"><input type="Checkbox" name="del_box5" value="#targid#"></td> </tr> </cfloop> <tr><td colspan=2><input type="submit" name="del_targM" value="Delete" class="DelButton"></td></tr> </cfoutput> </table> </TD></TR> </cfif> <!---
			<cfif NOT(session.modality EQ 1  and session.objnum EQ '1H' and session.fy GTE 2014)>
			<tr><td>&nbsp;</td></tr> <!--- delete this for 1h ---> </cfif> ---> <cfif isdefined("session.objval") and session.objval is '1a' and session.fy gte 2013 and session.modality is not 6> <tr><td><strong>Target CHCs:</strong> </td></tr> <tr><td> <table border=".1" align="center" class="boxy" width="100%"> <tr> <th align="left"> <!--- width="35%" --->Target CHC</th> </tr> <tr> <td align="left"> <select name="oname"><option value="">Please select</option> <cfoutput query="targchc"> <option value="#target#">#target#</option></cfoutput> </select> </td> </tr> <tr><Td colspan=4> <cfif isDefined("Qgettarg1")> <input type="submit" name="addadvorg" value="Update" class="AddButton" onclick="return checkCHC();"> <cfelse> <input type="submit" name="addadvorg" value="Add" class="AddButton" onclick="return checkCHC();"> </cfif> </td></tr> </table></td></tr> <cfif qtargorgCHC.recordcount GT 0> <tr><td> <table border=".1" align="LEFT" class="boxy"> <tr> <th <!--- width="45%" --->>Target CHC</th> <th width="10%">Delete</th> </tr> <cfoutput><cfloop query="qtargorgCHC"> <tr> <td valign="top" bgcolor="##EEEEEE">#name#</td> <td valign="top" bgcolor="##EEEEEE" align="center"><input type="Checkbox" name="del_box5" value="#targid#"></td> </tr> </cfloop> <tr><td colspan=2><input type="submit" name="del_targ" value="Delete" class="DelButton"></td></tr> </cfoutput> </table> </TD></TR> </cfif> <cfif isDefined("url.target") and url.target EQ "CHC"> <cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="Qgettarg1">
		select
	*
	from target_chc
	where
	targchcid = <cfqueryparam value="#url.seq#" cfsqltype="CF_SQL_INTEGER">
</cfquery> <input type="hidden" name="targid0" value="<cfoutput>#url.seq#"</cfoutput>> </cfif> <P> <tr><td>&nbsp;</td></tr> <tr><td><strong>Target CHC Clinical Sites:</strong><br></td></tr> <TR><TD> <table border=".1" align="center" class="boxy" width="100%"> <tr> <th align="left"> <!--- width="35%" --->Target CHC</th> <th align="left"> <!--- width="35%" --->Target CHC Clinical Sites</th> </tr> <tr> <td align="left"> <select name="targ" <cfif isdefined("qgettarg1.targid") and qgettarg1.targid eq qtargorgchc.targid>disabled</cfif>><option value="">Please select</option> <cfoutput query="qtargorgCHC"> <option value="#targid#" <cfif isdefined("qgettarg1.targid") and qgettarg1.targid eq qtargorgchc.targid>selected</cfif>>#name#</option></cfoutput> </select> </td> <td align="left"> <cfoutput><cfif isdefined("qgettarg1.targid")><input type="hidden" name="targy" value="#qgettarg1.targid#"></cfif><cfif isdefined("qgettarg1.targchcid")><input type="hidden" name="targchc" value="#qgettarg1.targchcid#"></cfif><input type="text" name="targsite" size=70 maxlength=70 <cfif isdefined("qgettarg1.targsite")>value="#qgettarg1.targsite#"</cfif>></cfoutput> </td> </tr> <tr><Td colspan=4> <cfif isDefined("Qgettarg1")> <input type="submit" name="addchcorg" value="Update" class="AddButton" onclick="return checkCHC2();"> <cfelse> <input type="submit" name="addchcorg" value="Add" class="AddButton" onclick="return checkCHC2();"> </cfif> </td></tr> </table></cfif> <cfif isdefined("session.objval") and session.objval is '1e' and session.fy gte 2013> <cfif isDefined("url.target") and url.target EQ "HCPO"> <cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="Qgettarg1">
		select *
	from target_org t left join wrkplan_targets w on t.targnum = w.targetid
	where
	targid = <cfqueryparam value="#url.seq#" cfsqltype="CF_SQL_INTEGER">

</cfquery> <input type="hidden" name="targid0" value="<cfoutput>#url.seq#"</cfoutput>> <p> </cfif> <tr><td><strong>HCPO targets:</strong></td></tr> <tr><td> <table border=".1" align="center" class="boxy" width="100%"> <tr> <th align="left"> <!--- width="35%" ---> <cfif session.objval EQ "8A" OR session.objval EQ "8B">Community Mobilization Partner<cfelse>Target</cfif> Organization Name</th> <th align="left"> <!--- width="35%" ---><cfif session.objval EQ "8A" OR session.objval EQ "8B">Partner<cfelse>Target</cfif> Type</th> </tr> <tr> <td align="left"> <cfoutput> <cfif isdefined("Qgettarg1")><input type="hidden" name="targid" value="#Qgettarg1.targid#"></cfif><input type="text" name="oname" size=70 <cfif isdefined("qgettarg1.oname")>value="#qgettarg1.oname#"</cfif>></cfoutput> </td> <td align="left"> <select name="targ" onchange="toggle_visibility8('myObject8');"><option value="">Please select</option> <cfoutput query="targadv"> <option value="#targetid#" <cfif isdefined("qgettarg1.targnum") and #qgettarg1.targnum# eq targadv.targetid>selected</cfif>>#target#</option></cfoutput> <option value=999 <cfif isdefined("qgettarg1.targnum") and #qgettarg1.targnum# is '999'>selected</cfif>>Other specialty– please specify </option> </select> </td> </tr> <tr><td></td><td><table id="myObject8" class="boxy" <cfif isdefined("form.addhcpoorg") or (not isdefined("form.targ") or (isdefined("form.targ") and form.targ is '') or (isdefined("qgettarg1.targnum") and #qgettarg1.targnum# is not '999'))>style='display:none;'</cfif>> <cfoutput> <tr><td>Specify:<br><input type="text" name="targoth" size=60 <cfif isdefined("qgettarg1.targoth")>value="#qgettarg1.targoth#"</cfif>></td></tr></cfoutput> </table> </td></tr> <tr><Td colspan=4> <cfif isDefined("Qgettarg1")> <input type="submit" name="addhcpoorg" value="Update" class="AddButton" onclick="return checkHCPO();"> <cfelse> <input type="submit" name="addhcpoorg" value="Add" class="AddButton" onclick="return checkHCPO();"> </cfif> </td></tr> </table></td></tr> <cfif qtargorg.recordcount GT 0> <tr><td> <table border=".1" align="LEFT" class="boxy"> <tr> <th <!--- width="45%" --->>Target Organization Name</th> <th <!--- width="45%" --->>Target Type</th> <th width="10%">Delete</th> </tr> <cfoutput><cfloop query="qtargorg"> <tr> <td valign="top" bgcolor="##EEEEEE"> <a href="javascript: document.wrk.action='cat_work.cfm?#session.urltoken#&target=HCPO&seq=#targid###advoc'; document.wrk.submit()">#name#</a></td> <td valign="top" bgcolor="##EEEEEE"><cfif #targoth# is not '' and #targnum# is '999'>Other, specify: #targoth#<cfelse>#target#</cfif></td> <td valign="top" bgcolor="##EEEEEE" align="center"><input type="Checkbox" name="del_box5" value="#targid#"></td> </tr> </cfloop> <tr><td colspan=3><input type="submit" name="del_targ" value="Delete" class="DelButton"></td></tr> </cfoutput> </table> </TD></TR> </cfif> </cfif>
<cfif session.objval NEQ '6A'> <!--- where is this. <cfoutput>#session.objval#</cfoutput>
			<cfif session.objval NEQ '6A'> ~~this isn't showing.' ---> <cfif qtargCHC.recordcount GT 0> <p> <table border=".1" align="LEFT" class="boxy"> <tr> <th <!--- width="45%" --->>Target CHC</th> <th <!--- width="45%" --->>Target CHC Clinical Sites</th> <th width="10%">Delete</th> </tr> <cfoutput><cfloop query="qtargCHC"> <tr> <td valign="top" bgcolor="##EEEEEE"><a href="javascript: document.wrk.action='cat_work.cfm?#session.urltoken#&target=CHC&seq=#targchcid###advoc'; document.wrk.submit()">#name#</a></td> <td valign="top" bgcolor="##EEEEEE">#targsite#</td> <td valign="top" bgcolor="##EEEEEE" align="center"> <!--- <input type="Checkbox" name="del_box5" value="#targid#">~~</td> ---> <input type="Checkbox" name="del_box5x" value="#targchcid#"></td> </tr> </cfloop> <tr><td colspan=3><input type="submit" name="del_targx" value="Delete" class="DelButton"></td></tr> </cfoutput> </table> </TD></TR> </cfif> <cfif not(session.modality EQ 3 and session.objval eq '2d') and (session.objval is not '1h' and session.objval is not '1g') AND not(session.modality EQ 2 and session.objval eq '2d' and session.fy GTE 2012)  and session.modality is not 6 and session.objval neq '8C'> <tr><td height=20></td></tr> <th align="left"><input type="checkbox" name="advoc" value=1 onclick="toggle_visibility1('myObject');" <cfif #wrk.advoc# is 1>checked</cfif>><cfif #session.modality# is 2 or #session.modality# is 3>Advocating with Organizational Decision-makers<cfelse>Advocating with Organizational Decision-makers</cfif></th> </tr> <tr><td align="left"> <table id="myObject" class="box" <cfif #wrk.advoc# is not 1>style='display:none;'</cfif>> <tr> <th align="left">Description:</th> <tr><cfoutput> <td valign="top"><textarea id="advocdesc" name="advocdesc" cols=135 rows=6 onkeyup="countit(this)" maxlength="1950"><cfif isDefined("form.advocdesc")>#form.advocdesc#<cfelse>#wrk.advocdesc#</cfif></textarea> </td></cfoutput> </tr> <tr> <td width="100%" valign="bottom"><div align="right" valign="bottom">This text field has a max of 1950 characters. Characters entered: <cfoutput><input type="text" value="#len(wrk.advocdesc)#" name="advdisplaycount" size="4" style="border:0;" disabled></cfoutput></td> </tr> <tr><td><input type="button" value="Check Spelling" onClick="spell('document.wrk.advocdesc.value', 'document.wrk.advocdesc.value')"> <cfif (#session.objval# is not '1A' and session.objval is not '1e' and session.fy LT 2015) or (session.fy GT 2014 and session.modality EQ 2)> <cfif isDefined("url.target") and url.target EQ "ADV"> <cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="Qgettarg1">
		select
	*
	from target_org tor left join wrkplan_targets t on tor.targnum = t.targetid and tor.year2 = t.year2
	left join counties c on tor.county = c.fips
	where
	userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and tor.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and initnum=<cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	and stratnum=1
	and targid = <cfqueryparam value="#url.seq#" cfsqltype="CF_SQL_INTEGER">
</cfquery> <input type="hidden" name="targid0" value="<cfoutput>#url.seq#"</cfoutput>> </cfif> <a name="advoc"></a> <tr><tr  ><td><table class="boxy" width="100%"> <cfif session.modality EQ 3 and session.objval EQ "3M" and session.fy GT 2011> <tr><td colspan="3" align="center"><strong>Required targets include: MPAA, YouTube, and a major television network.</strong> <br>Enter any local media targets in the table below.</td></tr> </cfif> <tr> <th> <!--- width="35%" --->Target Organization Name</th> <th <!--- width="30%" --->>Organization Type</th> <cfif session.objval is not '1E' and session.objval is not '3m' and session.fy LT 2012> <th <!--- width="25%" --->>City</th> </cfif> <cfif (session.objval is '2D' OR session.objval is '2E' or session.objval is '4F' or session.objval is '3M') and session.fy GTE 2015> <th > Disparities Target?</th> </cfif> <cfif session.objval is not '1E'><th<!--- width="25%" --->>County</th></cfif> <!--- <cfif session.objval EQ '2E' and session.fy GT 2011><th>Justification for selecting this target*</th></cfif> ---> </tr> <tr><td align="center"><cfoutput><input name="oname" type="text" <cfif isdefined("Qgettarg1")>value="#Qgettarg1.name#"</cfif> size=40></cfoutput></td> <td align="center"> <select name="targ" <cfif #session.modality# is 2 and #session.objval# is '2D'>onchange="form.submit();"</cfif>> <cfif targadv.recordcount is not 1><option value="">Please select</option></cfif> <cfoutput query="targadv"> <option value="#targetid#" <cfif isdefined("Qgettarg1") and #targetid# eq #Qgettarg1.targnum#>selected</cfif>>#target#</option></cfoutput> </select> </td> <cfif session.objval is not '1E' and session.objval is not '3m' and session.fy LT 2012> <td align="center"> <cfoutput> <input type="text" name="city" <cfif isdefined("Qgettarg1")>value="#Qgettarg1.city#"</cfif>> </cfoutput> </td> </cfif> <cfif (session.objval is '2D' OR session.objval is '2E' or session.objval is '4F' or session.objval is '3M') and session.fy GTE 2015> <td align="center"> <input type="checkbox" name="targDisp1" value="1" <cfif isdefined("Qgettarg1") and Qgettarg1.targDisp eq 1> checked</cfif>  <cfif NOT(isDefined("wrk2.dispinit") and #wrk2.dispinit# CONTAINS '#session.objval#')> Disabled</cfif>> </td> </cfif> <cfif session.objval is not '1E'><td align="center"> <select name="county"> <cfif counties.recordcount gt 1><option value="">Please select</option></cfif> <cfoutput query="counties"> <option value="#fips#" <cfif isDefined("Qgettarg1") and Qgettarg1.county EQ fips> selected</cfif>>#countyname#</option></cfoutput> <cfif (session.modality EQ 2 OR session.modality EQ 3 or Session.modality EQ 5) or (#session.objval# is '2D' and #session.modality# is 2 and isdefined("form.targ") and #form.targ# is 17) or (#session.objval# is '2l' and #session.modality# is 3)> <option value=999 <cfif isDefined("Qgettarg1") and Qgettarg1.county EQ 999> selected</cfif>>Multiple counties</option> </cfif> </select></td> <!--- insert new column here ---> <!--- <cfif session.objval EQ '2E' and session.fy GT 2011><td>
			<input type="checkbox" name="advjustone" value="1" <cfif isDefined("Qgettarg1") and Qgettarg1.justone EQ 1> checked</cfif>>Employs large # of people<br>
			<input type="checkbox" name="advjusttwo" value="1" <cfif isDefined("Qgettarg1") and Qgettarg1.justtwo EQ 1> checked</cfif>>Is an influential employer<br>
			<input type="checkbox" name="advjustthree" value="1" <cfif isDefined("Qgettarg1") and Qgettarg1.justthree EQ 1> checked</cfif>>Is located in a high-profile area<br>
			</td></cfif> ---> </cfif> </tr> <input type="hidden" name="objnum" <cfoutput>value="#session.objnum#"</cfoutput>> <tr><Td colspan=4> <cfif isDefined("Qgettarg1")> <input type="submit" name="addadvorg" value="Update" class="AddButton" onclick="return checkMG();"> <cfelse> <input type="submit" name="addadvorg" value="Add" class="AddButton" onclick="return checkMG();"> </cfif> </td></tr> <cfif qtargorg.recordcount GT 0> <tr> <td colspan="5"> <table border=".1" align="center" class="boxy" > <!--- <tr>
			<th align="left" colspan="6">Targets for Advocating with organizational decision makers<!---  target organizations --->:</th> </tr> ---><tr> <th <!--- width="45%" --->>Target Organization Name</th> <th <!--- width="45%" --->>Organization Type</th> <cfif (session.objval is '2D' OR session.objval is '2E' or session.objval is '4F' or session.objval is '3M') and session.fy GTE 2015> <th> Disparities Target?</th> </cfif> <cfif session.objval is not '1E'><cfif session.objval is not '3m' and session.fy LT 2012><th width="25%">City</th></cfif> <th width="20%">County</th></cfif> <!--- <cfif session.objval EQ '2E' and session.fy GT 2011><th>Justification</th></cfif> ---> <th width="10%">Delete</th> </tr> <cfoutput><cfloop query="qtargorg"> <tr> <td valign="top" bgcolor="##EEEEEE"><a href="javascript: document.wrk.action='cat_work.cfm?#session.urltoken#&target=ADV&seq=#targid###advoc'; document.wrk.submit()"><cfif #targdisp# eq 1>*</cfif>#name#</a></td> <td valign="top" bgcolor="##EEEEEE">#target#</td><cfif session.objval is not '1E'> <cfif session.objval is not '3m' and session.fy LT 2012><td valign="top" bgcolor="##EEEEEE">#city#</td></cfif> <cfif (session.objval is '2D' OR session.objval is '2E' or session.objval is '4F' or session.objval is '3M') and session.fy GTE 2015> <td  bgcolor="##EEEEEE"> <cfif targDisp EQ 1>Yes</cfif></td> </cfif> <td valign="top" bgcolor="##EEEEEE"><cfif #county# is '999'>Multiple counties<cfelse>#countyname#</cfif></td></cfif> <!--- <cfif session.objval EQ '2E' and session.fy GT 2011>
			<td bgcolor="##EEEEEE">
			<cfif justone EQ 1>Employs large ## of people<br></cfif>
			<cfif justtwo EQ 1>Is an influential employer<br></cfif>
			<cfif justthree EQ 1>Is located in a high-profile area<br></cfif>
			</td>
			</cfif> ---> <td valign="top" bgcolor="##EEEEEE" align="center"><input type="Checkbox" name="Del_box2" value="#targid#"></td> </tr> </td></tr> </cfloop> <tr><td colspan=6><input type="submit" name="del_targ" value="Delete" onclick="return confirmDel();" class="DelButton"> </cfoutput> </table> </td> </tr> </cfif> </table></td></tr></cfif> </table></td></tr> </cfif> <cfif (#session.objnum# is '2D' or #session.objnum# is '2E' or #session.objnum# is '4f' or #session.objnum# is '3m' or #session.objnum# is '1h'  or #session.objnum# is '8A'  or #session.objnum# is '8B') and ((session.modality EQ 2 or session.modality eq 3 or (session.modality eq 1)) and session.fy GTE 2012)> <cfif NOT(session.modality EQ 1 and (session.objnum EQ '1H'  or #session.objnum# is '8A'  or #session.objnum# is '8B') and session.fy GTE 2014)> <tr><td height=20></td></tr> </cfif> <!--- <tr><td height=20></td></tr> ---> </tr> <th align="left"><input type="checkbox" value=1 name="commmob" onclick="toggle_visibility0('myObject0');" <cfif #wrk.commmob# is 1>checked</cfif>><cfif #session.modality# is 2 or #session.modality# is 3 or #session.modality# is 1>Community Mobilization</cfif><cfif session.objnum is '1h' and session.modality NEQ 1> <strong>(Optional)</strong></cfif></th> </tr> <tr><td align="center"> <table id="myObject0" align="left" class="box" <cfif wrk.commmob NEQ 1>style='display:none;'</cfif>> <th align="left">Description:</th> <tr> <td valign="top"><cfoutput><textarea name="commmobdesc" cols=135 rows=6 onkeyup="countit0(this)" maxlength="1950">#wrk.commmobDesc#</textarea></cfoutput> </td> </tr> <tr> <td width="100%" valign="bottom"><div align="right" valign="bottom">This text field has a max of 1950 characters. Characters entered: <cfoutput><input type="text" value="#len(wrk.commmobdesc)#" name="commmobdisplaycount" size="4" style="border:0;" disabled></cfoutput></td> </tr> <tr><td><input type="button" value="Check Spelling" onClick="spell('document.wrk.commmobdesc.value', 'document.wrk.commmobdesc.value')"> <cfif #session.objval# is not ''> <cfif isDefined("url.target") and url.target EQ "CMO"> <cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="Qgettarg">
select
	*
	from target_org tor
	where
	userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and tor.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and initnum=<cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	and stratnum=0
	and targid = <cfqueryparam value="#url.seq#" cfsqltype="CF_SQL_INTEGER">
	order by name
</cfquery> <input type="hidden" name="targid0" value="<cfoutput>#url.seq#"</cfoutput>> </cfif> <a name="cmmob"></a> <tr><td><br></td></tr> <tr><td align="left"><table class="boxy" align="left" width="100%"> <tr><th> <cfif session.objnum is '1h'>Community Mobilization<br>Target Organization Name<cfelseif session.objnum EQ '8A' or session.objnum EQ '8B'>Community Mobilization<br>Partner Organization Name<cfelse>Target Organization Name</cfif></th> <th ><cfif session.objnum is '1h'>Target Type<cfelseif session.objnum EQ '8A' or session.objnum EQ '8B'>Partner Type<cfelse>Organization Type</cfif></th> <cfif (session.objval is '2D' OR session.objval is '2E' or session.objval is '4F' or session.objval is '3M') and session.fy GTE 2015> <th > Disparities Target?</th> </cfif> <th><cfif session.objnum is '1h'>Related health systems change target<br> Select all that apply:<cfelse> Description of partner</cfif></th> <cfif session.fy LT 2012><th>Justification for selecting this target</th></cfif> </tr> <tr><td align="center"><cfoutput><input name="oname0" type="text" <cfif isdefined("Qgettarg")>value="#Qgettarg.name#"</cfif> size=40></cfoutput></td> <td align="left"> <select <cfif session.objnum is '1h'>name="targ"<cfelse>name="targ0"</cfif> onchange="toggle_visibility9('myObject7');"> <option value="">Please select</option> <cfif session.fy GTE 2014 AND session.modality is 2 and session.objval is '4f'> <cfoutput query="targcommmob"> <option value="#targetid#" <cfif isDefined("Qgettarg") and Qgettarg.targnum EQ targetid> selected</cfif> >#target# </option> </cfoutput> <cfelseif (session.modality is 2 and session.objval is not '2d') or (session.modality is 3 and session.objval is '3m' and session.objval is not '2d') or session.modality is 1> <cfoutput query="targadv"> <option value="#targetid#" <cfif isDefined("Qgettarg") and Qgettarg.targnum EQ targetid> selected</cfif> >#target#</option></cfoutput> </cfif> <cfif session.objnum is '1h' > <option value="999" <cfif isdefined("qgettarg") and qgettarg.targnum eq 999> selected</cfif>>Other, please specify</option> <cfelseif (session.modality is 2 and session.objval is  '4f') or session.objval is '8a' or session.objval is '8b'> <option value="999" <cfif isdefined("qgettarg") and qgettarg.targnum eq 999> selected</cfif>>Other</option> <cfelseif session.objnum is not '3m' and (session.modality is 2 and session.objval is not '4f') or (session.modality is 3 and session.objval is '2d')> > <option value="1" <cfif isdefined("qgettarg") and qgettarg.targnum eq 1> selected</cfif>>Youth-focused orgs</option> <option value="2" <cfif isdefined("qgettarg") and qgettarg.targnum eq 2> selected</cfif>>Other</option> </cfif> </select> </td> <cfif (session.objval is '2D' OR session.objval is '2E' or session.objval is '4F' or session.objval is '3M') and session.fy GTE 2015> <td align="center"> <input type="checkbox" name="targDisp" value="1" <cfif isdefined("qgettarg") and qgettarg.targDisp eq 1> checked</cfif> <cfif NOT(isDefined("wrk2.dispinit") and #wrk2.dispinit# CONTAINS '#session.objval#')> Disabled</cfif>> </td> </cfif> <td align="left"> <cfif session.objnum is '1h'><input type="checkbox" name="CHC" value=1 <cfif isdefined("qgettarg") and qgettarg.chc eq 1>checked</cfif>> CHC<br><input type="checkbox" name="PROS" value=1 <cfif isdefined("qgettarg") and qgettarg.pros eq 1>checked</cfif>> PROS<br><input type="checkbox" name="HCPO" value=1 <cfif isdefined("qgettarg") and qgettarg.hcpo eq 1>checked</cfif>> HCPO<br><cfelse> <cfoutput> <!--- <input type="text" name="CMDescr" <cfif isdefined("Qgettarg")>value="#Qgettarg.descrip#"</cfif>> ---> <textarea rows="3" cols="50" name="CMDescr"><cfif isdefined("Qgettarg")>#Qgettarg.descrip#</cfif></textarea> </cfoutput></cfif></td> <cfif session.fy LT 2012> <td align="left"> <input type="checkbox" name="cmjustone" value="1" <cfif isDefined("Qgettarg") and Qgettarg.justone EQ 1> checked</cfif>>Previous relationship with target<br> <input type="checkbox" name="cmjusttwo" value="1" <cfif isDefined("Qgettarg") and Qgettarg.justtwo EQ 1> checked</cfif>>Target expressed interest<br> <input type="checkbox" name="cmjustthree" value="1" <cfif isDefined("Qgettarg") and Qgettarg.justthree EQ 1> checked</cfif>>Target is influential in community<br> <input type="checkbox" name="cmjustfour" value="1" <cfif isDefined("Qgettarg") and Qgettarg.justfour EQ 1> checked</cfif>>Other:<br> <textarea name="cmjustother" cols="30" rows="3"><cfif isDefined("Qgettarg")><cfoutput>#Qgettarg.justother#</cfoutput></cfif></textarea> </td> </cfif> </cfif> </tr> <cfif session.modality eq 1><tr><td></td><td><table id="myObject7" class="boxy" <cfif session.objnum is '1h' or isdefined("form.addCM") or ((isdefined("form.targ") and form.targ is '') or (isdefined("qgettarg.targnum") and #qgettarg.targnum# is not '999'))>style='display:none;'</cfif>> <cfif session.fy LT 2015><cfoutput><tr><td colspan=2>Specify:<br><input type="text" name="targoth" size=60 <cfif isdefined("qgettarg")>value="#qgettarg.targoth#"</cfif>></td></tr></cfoutput></cfif></table> </td></tr></cfif> <!---<input type="hidden" name="objnum" value="#session.objnum#">---> <tr><cfif session.fy LT 2012><td colspan="4"><cfelse><td colspan="3"></cfif> <cfif isDefined("Qgettarg")><cfif session.objnum is '1h'><input type="submit" name="addCM" value="Update" class="AddButton"  onclick="return checkMOB();"><cfelse><input type="submit" name="addCM" value="Update" class="AddButton"  onclick="return checkCM();"></cfif> <cfelse><cfif session.objnum is '1h'><input type="submit" name="addMOB" value="Add" class="AddButton" onclick="return checkMOB();"><cfelse><input type="submit" name="addCM" value="Add" class="AddButton" onclick="return checkCM();"></cfif></cfif> </td></tr> </table> <cfif qtargorg0.recordcount GT 0> <tr> <cfif session.fy LT 2012><td colspan="5"><cfelse><td colspan="4"></cfif> <table border=".1" align="center" class="boxy"> <tr> <th ><cfif session.objnum is '1h'>Community Mobilization<br>Target Organization Name <cfelseif session.objnum EQ '8A' or session.objnum EQ '8B'> Community Mobilization<br>Partner Organization Name<cfelse>Community Mobilization<br>Organization Name</cfif>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </th> <th ><cfif session.objnum is '1h'>Target<cfelseif session.objnum EQ '8A' or session.objnum EQ '8B'>Partner<cfelse>Organization</cfif> Type</th> <cfif (session.objval is '2D' OR session.objval is '2E' or session.objval is '4F' or session.objval is '3M') and session.fy GTE 2015> <th > Disparities Target?</th> </cfif> <th width="30%"><cfif session.objnum is '1h'>Related health systems change target<cfelse>Description</cfif></th> <cfif session.fy LT 2012><th width="20%">Justification</th></cfif> <th width="10%">Delete</th> </tr> <cfoutput> <cfloop query="qtargorg0"> <cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="Qgettarg">
select
	*
	from target_org tor left join wrkplan_targets w
    on tor.targnum = w.targetid
	where
	targid = #qtargorg0.targid# and w.year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and initnum=<cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
</cfquery> <tr> <td valign="top" bgcolor="##EEEEEE"><a href="javascript: document.wrk.action='cat_work.cfm?#session.urltoken#&target=CMO&seq=#targid###cmmob'; document.wrk.submit()"><cfif #targdisp# eq 1>*</cfif>#name#</a></td> <!--- <td valign="top" bgcolor="##EEEEEE"><a href="cat_work.cfm?#session.urltoken#&target=CMO&seq=#targid#">#name#</a></td> ---> <td valign="top" bgcolor="##EEEEEE"> <cfif session.objnum is '1h'> <cfif #qgettarg.targoth# is not ''>Other, specify: #qgettarg.targoth#<cfelse> <cfif session.modality is not 2>#qgettarg.target#</cfif> </cfif><cfelse> <cfif targnum EQ 1>Youth-focused orgs <cfelseif targnum EQ 2 or targnum EQ 999>Other <cfelse> #qgettarg.target# </cfif> </cfif> </td> <cfif (session.objval is '2D' OR session.objval is '2E' or session.objval is '4F' or session.objval is '3M') and session.fy GTE 2015> <td  bgcolor="##EEEEEE"> <cfif targDisp EQ 1>Yes</cfif></td> </cfif> <td valign="top" bgcolor="##EEEEEE"><cfif session.objnum is '1h'><cfif qgettarg.chc eq 1>CHC<br></cfif><cfif qgettarg.pros eq 1>PROS<br></cfif><cfif qgettarg.hcpo eq 1>HCPO</cfif><cfelse>#descrip#</cfif></td> <cfif session.fy LT 2012> <td valign="top" bgcolor="##EEEEEE"> <cfif justone EQ 1>Previous relationship with target<br></cfif> <cfif justtwo EQ 1>Target expressed interest<br></cfif> <cfif justthree EQ 1>Target is influential in community<br></cfif> <cfif justfour EQ 1>Other:<br> #justother#</cfif> </td> </cfif> <td valign="top" bgcolor="##EEEEEE" align="center"><input type="Checkbox" name="Del_box2" value="#targid#"></td> </tr> </td></tr> </cfloop> <tr><td colspan=6><input type="submit" name="del_targ0" value="Delete" onclick="return confirmDel();" class="DelButton"> </cfoutput> </table> </td> </tr> </cfif> </table></td></tr> </cfif> <cfif (<!--- #session.objnum# is not '1E' and ---> #session.objnum# is not '1A' and session.objnum is not '1h' and #session.objnum# is not '1g' <!---  and #session.objnum# is not '4F' ---> or NOT(((#session.modality# is 2 and session.objval is '4f' and #wrk.reqinit# EQ 0 or wrk.reqinit is ''))
			and session.fy GTE 2012) and not (session.fy GT 2011 and session.modality EQ 1 and session.objnum EQ '1E'))
			and  not(session.fy GTE 2014 and session.modality EQ 1 and session.objval EQ '1E') and session.modality NEQ 6 and not(session.modality EQ 1 and session.fy GT 2014)> <tr><td height=20></td></tr> </tr> <th align="left"><input type="checkbox" value=1 name="govt" onclick="toggle_visibility2('myObject2');" <cfif #wrk.govt# is 1>checked</cfif>><cfif #session.modality# is 2 and session.objval is not '4f' or #session.modality# is 3>Government Policy Maker Education<cfelseif session.modality is 2 and session.objval is '4f'>Government Policy-Maker Education <cfif session.fy LT 2015>(for Optional Outcome 1b)</cfif><cfelse>Government policy maker education</cfif></th> </tr> <tr><td align="left"> <table id="myObject2" class="box" <cfif #wrk.govt# is not 1>style='display:none;'</cfif>> <th align="left">Description:</th> <tr> <td valign="top"><cfoutput><textarea name="govtdesc" cols=135 rows=6 onkeyup="countit2(this)" maxlength="1950">#wrk.govtdesc#</textarea></cfoutput> </td> </tr> <tr> <td width="100%" valign="bottom"><div align="right" valign="bottom">This text field has a max of 1950 characters. Characters entered: <cfoutput><input type="text" value="#len(wrk.govtdesc)#" name="govtdisplaycount" size="4" style="border:0;" disabled></cfoutput></td> </tr> <tr><td><input type="button" value="Check Spelling" onClick="spell('document.wrk.govtdesc.value', 'document.wrk.govtdesc.value')"> <cfif #session.objnum# is not '1A' <!--- and #session.objnum# is not '1E' --->> <cfif isDefined("url.target") and url.target EQ "GOV"> <cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="Qgettarg2">
		select
	*
	from target_org tor left join wrkplan_targets t on tor.targnum = t.targetid and tor.year2 = t.year2
	left join counties c on tor.county = c.fips
	where
	userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and tor.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and initnum=<cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	and stratnum=2
	and targid = <cfqueryparam value="#url.seq#"
                cfsqltype="CF_SQL_INTEGER">

</cfquery>
<input type="hidden" name="targid0" value="<cfoutput>#url.seq#"</cfoutput>>
</cfif>
<a name="govt"></a>
<tr><td>
<table class="boxy" width="53%">
	<tr>
		<th colspan=20%>Target Organization Name</th>
		<th colspan=80%>Organization Type</th>
		<cfif (session.objval is '2D' OR session.objval is '2E' or session.objval is '4F' or session.objval is '3M') and session.fy GTE 2015> <th > Disparities Target?</th> </cfif>
	</tr>
	<tr>
		<td colspan=20%>
			<input type="text" name="gname" size=40 <cfif isDefined("Qgettarg2")> value=<cfoutput>"#Qgettarg2.name#"</cfoutput></cfif>
		</td>
		<td colspan=80%>
		<select name="targZ"> <cfif targgpme.recordcount is not 1><option value="">Please select</option></cfif>
		<cfoutput query="targgpme"> <option value="#targetid#" <cfif isDefined("Qgettarg2") and Qgettarg2.targnum EQ targetid> selected</cfif> >#target#</option></cfoutput>
		</select>
		</td>
		<cfif (session.objval is '2D' OR session.objval is '2E' or session.objval is '4F' or session.objval is '3M') and session.fy GTE 2015>
		<td align="center">
			<input type="checkbox" name="targDisp2" value="1" <cfif isdefined("Qgettarg2") and Qgettarg2.targDisp eq 1> checked</cfif> <cfif NOT(isDefined("wrk2.dispinit") and #wrk2.dispinit# CONTAINS '#session.objval#')> Disabled </cfif>>
		</td>
		</cfif>
	</tr>
	<tr>
		<td colspan=2>
			<cfif isDefined("Qgettarg2")>
			<input type="submit" name="addgovorg" value="Update" class="AddButton" onclick="return checkGG();">
			<cfelse>
			<input type="submit" name="addgovorg" value="Add" onclick="return checkGG();" class="AddButton"></cfif>
		</td>
	</tr>
</table>
<cfif Qtargorg2.recordcount GT 0>
<tr>
<td colspan="4">
<table border=".1" class="boxy" width="60%">
	<tr>
		<th colspan=30%>Target Organization Name</th>
		<th colspan=40%>Organization Type</th>
		<cfif (session.objval is '2D' OR session.objval is '2E' or session.objval is '4F' or session.objval is '3M') and session.fy GTE 2015> <th > Disparities Target?</th> </cfif>
		<th colspan=10%>Delete</th>
	</tr>
	<cfoutput>
		<cfloop query="Qtargorg2">
			<tr>
				<td valign="top" bgcolor="##EEEEEE" colspan=30%><a href="javascript: document.wrk.action='cat_work.cfm?#session.urltoken#&target=GOV&seq=#targid###govt'; document.wrk.submit()">
					<cfif #targdisp# eq 1>*</cfif>#name#</a></td>
				<td valign="top" bgcolor="##EEEEEE" colspan=40%>#target#</td>
				<cfif (session.objval is '2D' OR session.objval is '2E' or session.objval is '4F' or session.objval is '3M') and session.fy GTE 2015>
				<td  bgcolor="##EEEEEE"> <cfif targDisp EQ 1>Yes</cfif></td>
				</cfif>
				<td valign="top" bgcolor="##EEEEEE" align="center" colspan=10%>
					<input type="Checkbox" name="Del_box2" value="#targid#">
				</td>
			</tr>
		</cfloop>
		<tr>
			<td colspan=6>
				<input type="submit" name="del_targ" value="Delete" onclick="return confirmDel2();" class="DelButton">
	</cfoutput>
</table>
			</td>
		</tr>
</cfif> <!---<cfelse>
			<input type="hidden" name="meddisplaycount">
			<input type="hidden" name="commdisplaycount">
			<input type="hidden" name="govtdisplaycount"> --->
</table>
</td>
</tr>
</cfif>
</cfif>


<cfif (not(session.fy GT 2011 and session.modality EQ 1 and (session.objnum NEQ '1h' and (session.objnum EQ '1A' or session.objnum EQ '1E')))
and (session.objnum NEQ '1h') or session.objnum EQ '1A' or session.objnum eq '1e')  and session.modality is not 6 and not(session.modality EQ 1 and session.fy GT 2014)>
<tr>
	<td height=20></td>
</tr>
<th align="left">
	<input type="checkbox" value=1 name="comm" onclick="toggle_visibility3('myObject3');" <cfif isdefined("wrk.comm") and #wrk.comm# is 1>checked</cfif>>Community Education
</th>
</tr>
<tr>
<td align="left">
<table id="myObject3" class="box" <cfif #wrk.comm# is not 1>style='display:none;'</cfif>>
<tr>
	<th align="left">&nbsp;<cfif #session.modality# is 5>Brief description:<cfelse>Description of targets and planned activities:</cfif></th>
</tr>
<tr>
	<cfoutput>
		<td valign="top">
			<textarea name="commdesc" rows=6 cols=135 onkeyup="countit3(this)" maxlength="1950">#wrk.commdesc#</textarea>
		</td>
	</cfoutput>
</tr>
<tr>
	<td width="100%" valign="bottom"><div align="right" valign="bottom">This text field has a max of 1950 characters. Characters entered:
	<cfoutput>
		<input type="text" value="#len(wrk.commdesc)#" name="commdisplaycount" size="4" style="border:0;" disabled>
	</cfoutput>
	</td>
</tr>
<tr>
	<td>
		<input type="button" value="Check Spelling" onClick="spell('document.wrk.commdesc.value', 'document.wrk.commdesc.value')">
	</td>
</tr>
<tr>
	<td align="center"> <cfparam name="session.objval" default="">
</td>
</tr>
</table>
	</td>
</tr>
</cfif>


<cfif <!--- #session.objnum# is not '1E' and --->(session.objnum eq '2d' or session.objnum eq '1h'  or NOT((#session.modality# is 2 and session.objval is '4f' and session.fy LT 2015)
			and ( isdefined("wrk.reqinit") and(#wrk.reqinit# EQ 0 or wrk.reqinit is '')))<!---  and #session.objnum# is not '4F' --->
			and  not(session.fy GT 2011 and session.modality EQ 1 and (session.objnum EQ '1E')))
			and  not(session.fy GT 2015 and session.modality EQ 2 and (session.objnum EQ '3M'))
			and  not(session.fy GTE 2014 and session.modality EQ 1 and (session.objval EQ '1A' OR session.objval EQ '1G'))  and session.modality is not 6
			and not(session.modality EQ 1 and session.fy GT 2014 and session.objval NEQ '8C')>

			<tr>
				<td height=20></td>
			</tr>
<tr>
<th align="left">
	<input type="checkbox" value=1 name="media" onclick="toggle_visibility4('myObject4');" <cfif #wrk.media# is 1>checked</cfif>>Paid Media
		<cfif session.objval is '1A' or (session.modality is 1 and session.objval is '1H')>(not including statewide campaign)
		<cfelseif session.objnum is '1h' or (session.objval is '2d' and session.modality is not 2) or (session.fy GTE 2015 and (session.objval EQ '4f' or session.objval EQ '2D' or session.objval EQ '2E'))> <strong>(Optional)</strong>
		</cfif>
</th>
</tr>
<tr>
<td align="left">
<table id="myObject4" class="box" <cfif #wrk.media# is not 1>style='display:none;'</cfif>>
<tr><th align="left">Description of targets and planned activities:</th>
</tr>
<tr>
	<cfoutput>
		<td valign="top">
			<textarea name="mediadesc" cols=135 rows=6 onkeyup="countit4(this)" maxlength="1950">#wrk.mediadesc#</textarea>
		</td>
	</cfoutput>
</tr>
<tr>
	<td width="100%" valign="bottom"><div align="right" valign="bottom">This text field has a max of 1950 characters. Characters entered:
	<cfoutput>
		<input type="text" value="#len(wrk.mediadesc)#" name="meddisplaycount" size="4" style="border:0;" disabled>
	</cfoutput>
	</td>
</tr>
<tr>
	<td>
		<input type="button" value="Check Spelling" onClick="spell('document.wrk.mediadesc.value', 'document.wrk.mediadesc.value')">
	</td>
</tr>
</table>
<cfelseif #session.modality# is 1 and #session.objval# is '1h' and session.fy is not 2013 >
<tr>
	<td height=20></td>
</tr>
<tr>
<th align="left">
	<input type="checkbox" value=1 name="media" onclick="toggle_visibility4('myObject4');"
			<cfif #wrk.media# is 1>checked</cfif>>Paid Media
</th>
</tr>
<tr>
<td align="center">
<table id="myObject4" class="box" <cfif #wrk.media# is not 1>style='display:none;'</cfif>>
<th align="left">Description of targets and planned activities:</th>
</tr>
<tr><cfoutput>
	<td valign="top">
		<textarea name="mediadesc" cols=135 rows=6 onkeyup="countit4(this)" maxlength="1950">#wrk.mediadesc#</textarea>
	</td></cfoutput>
</tr>
<tr>
	<td width="100%" valign="bottom"><div align="right" valign="bottom">This text field has a max of 1950 characters. Characters entered:
	<cfoutput>
		<input type="text" value="#len(wrk.mediadesc)#" name="meddisplaycount" size="4" style="border:0;" disabled>
	</cfoutput>
	</td>
</tr>
<tr>
	<td>
		<input type="button" value="Check Spelling" onClick="spell('document.wrk.mediadesc.value', 'document.wrk.mediadesc.value')">
	</td>
</tr>
</table>
</cfif>
</td></tr>

<cfif session.objnum is '1h' OR session.objnum is '8C'>
<tr>
	<td height=20></td>
</tr>
</tr>
<th align="left">
	<input type="checkbox" value=1 name="dcs" onclick="toggle_visibility6('myObject6');" <cfif isdefined("wrk.dcs") and #wrk.dcs# is 1>checked</cfif>>
Direct Cessation Services <cfif session.objval is '1A'>(not including statewide campaign)</cfif>

<cfif session.objnum is '1h' OR session.objnum is '8C'> <strong>(Optional)</strong></cfif>
</th>
			</tr>
			<tr>
			<td align="left">
			<table id="myObject6" class="box" <cfif isdefined("wrk.dcs") and #wrk.dcs# is not 1>style='display:none;'</cfif>>
				<tr><th align="left">Description of targets and planned activities:
				</th>
				</tr>
				<tr>
					<cfoutput>
						<td valign="top">
							<textarea name="dcsdesc" cols=135 rows=6 onkeyup="countit7(this)" maxlength="1950">#wrk.dcsdesc#</textarea>
						</td>
					</cfoutput>
				</tr>
				<tr>
					<td width="100%" valign="bottom"><div align="right" valign="bottom">This text field has a max of 1950 characters. Characters entered:
					<cfoutput>
						<input type="text" value="#len(wrk.dcsdesc)#" name="dcsdisplaycount" size="4" style="border:0;" disabled>
					</cfoutput>
					</td>
				</tr>
				<tr>
					<td>
						<input type="button" value="Check Spelling" onClick="spell('document.wrk.dcsdesc.value', 'document.wrk.dcsdesc.value')">
			</td>
				</tr>

</table>
</td>
				</tr>
</cfif>

<cfif   session.modality is  6>
	<cfif session.objnum is '1A'>
		<tr>
			<td align="left">
			<table id="myObject6" class="box" style="border: none;"  >
				<tr>
					<th align="left">Please describe the activities related to providing regional support of health systems change:
					</th>
				</tr>
				<tr>
					<cfoutput>
					<td valign="top">
						<textarea name="regdesc" cols=135 rows=6 onkeyup="countit99(this)" maxlength="1950">#wrk.regdesc#</textarea>
					</td>
					</cfoutput>
				</tr>
				<tr>
					<td width="100%" valign="bottom"><div align="right" valign="bottom">This text field has a max of 1950 characters. Characters entered:
					<cfoutput>
						<input type="text" value="#len(wrk.regdesc)#" name="regDspCnt" size="4" style="border:0;" disabled>
					</cfoutput>
					</td>
				</tr>
				<tr>
					<td>
						<input type="button" value="Check Spelling" onClick="spell('document.wrk.regdesc.value', 'document.wrk.regdesc.value')">
					</td>
				</tr>
			</table>
					</td>
				</tr>
	<cfelseif session.objnum is '2A'> <tr><td align="left">
			<tr>
			<td align="left">
			<table id="myObject6" class="box" style="border:0;" >
				<tr>
					<th align="left">Please describe the activities related to providing statewide support of health systems change:</th>
				</tr>
				<tr>
					<cfoutput>
						<td valign="top">
							<textarea name="statedesc" cols=135 rows=6 onkeyup="countit88(this)" maxlength="1950">#wrk.statedesc#</textarea>
						</td>
					</cfoutput>
				</tr>
				<tr>
					<td width="100%" valign="bottom"><div align="right" valign="bottom">This text field has a max of 1950 characters. Characters entered:
					<cfoutput>
						<input type="text" value="#len(wrk.statedesc)#" name="stateDspCnt" size="4" style="border:0;" disabled>
					</cfoutput>
					</td>
				</tr>
				<tr>
					<td>
						<input type="button" value="Check Spelling" onClick="spell('document.wrk.statedesc.value', 'document.wrk.statedesc.value')">
						</td>
				</tr>
			</table>
					</td>
				</tr>
	</cfif>
<!--- </cfif> --->
<!--- <tr>
	<td align="center">
	<input type="submit" name="return" value="Save and return to menu" onclick="return checkWG();">
	</td>
</tr> --->

<cfelse>
	<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="geteval">
	select *
from selfeval
where
modality = <cfqueryparam value="#session.modality#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">
and <cfif session.fy GTE 2012> year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"><cfelse>year2 is null</cfif>
order by selfevaltxt
</cfquery> <cfif isdefined("url.selfevalid")> <cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="geteval2">
	select *
from selfeval s inner join wrkplan_selfeval ws
on s.selfevalid = ws.selfevalid
where
ws.wrkselfid = <cfqueryparam value="#url.selfevalid#" cfsqltype="CF_SQL_INTEGER">
and s.modality = <cfqueryparam value="#session.modality#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">
and
<cfif session.fy GTE 2012> s.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
<cfelse>s.year2 is null
</cfif>
</cfquery>
</cfif>
</cfif>
</cfif>

</cfif>
<!--- <cfif session.objval NEQ '6A'> --->



<cfif session.objval EQ '6B'>

<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="geteval">
	select *
from selfeval
where
modality = <cfqueryparam value="#session.modality#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">
and <cfif session.fy GTE 2012> year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"><cfelse>year2 is null</cfif>
order by selfevaltxt
</cfquery>

<cfif isdefined("url.selfevalid")>
<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="geteval2">
	select *
from selfeval s inner join wrkplan_selfeval ws
on s.selfevalid = ws.selfevalid
where
ws.wrkselfid = <cfqueryparam value="#url.selfevalid#" cfsqltype="CF_SQL_INTEGER">
and s.modality = <cfqueryparam value="#session.modality#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">
and
<cfif session.fy GTE 2012> s.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
<cfelse>s.year2 is null
</cfif>
</cfquery>
</cfif>


<tr> <td height=10> </td> </tr>
<tr> <th align="left"> Select evaluation project: </th> </tr>
<tr> <td> <select name="selfeval">
		<cfif isdefined("url.selfevalid") and #url.selfevalid# is not ''> <cfoutput> <option value="#geteval2.selfevalid#"> #geteval2.selfevaltxt# </option> </cfoutput>
		<cfelse> <option value=""> Select evaluation project </option> </cfif>
			<cfoutput query="geteval"> <option value="#selfevalid#"> #selfevaltxt# </option> </cfoutput>
	</select> <cfoutput>
		<input type="hidden" name="initiative" value="#session.initiative#">
		<input type="hidden" name="objval" value="#session.objval#"> </cfoutput>
</td> </tr>
<tr> <td height=20> </td> </tr>
<tr><td><table class="box" style="border:0;" >
<tr> <th align="left"> Description of Evaluation Project (including WHERE observations will be conducted or WHO will be surveyed, <br> WHEN data will be collected, and HOW data will be utilized): </th> </tr>
<cfoutput> <tr> <td valign="top">
	<textarea name="evalproj" cols=150 rows=8 onkeyup="countit6(this)" maxlength="1950">
		<cfif isdefined("url.selfevalid") and #url.selfevalid# is not ''> #geteval2.evalproj# </cfif>
	</textarea> </td> </tr> </cfoutput>
	<tr> <td> <input type="button" value="Check Spelling" onClick="spell('document.wrk.evalproj.value', 'document.wrk.evalproj.value')">
	<tr> <td width=750> <div align="right" valign="bottom"> This text field has a max of 2000 characters. Characters entered:
	<cfoutput> <input type="text" name="epdisplaycount" size="4" style="border:0;" disabled> </cfoutput>
	</td> </tr>
</table>
	</td> </tr>
	<tr> <td>
		<cfif isdefined("url.selfevalid") and #url.selfevalid# is not ''> <input type="submit" name="self" value="Update" onClick="return checkLG();" class="AddButton">
		<cfelse> <input type="submit" name="self" value="Add" onClick="return checkLG();" class="AddButton">
		</cfif>
	</td> </tr>

	<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="getwrk">
	select *
from selfeval se inner join wrkplan_selfeval ws on se.selfevalid = ws.selfevalid and ws.modality = se.modality
where
userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
and ws.year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> and ws.modality = <cfqueryparam value="#session.modality#" cfsqltype="CF_SQL_INTEGER">
and <cfif session.fy GTE 2012> se.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"><cfelse>se.year2 is null</cfif>
and ws.modality=se.modality
and ws.initnum=<cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
</cfquery>



<cfoutput>
<tr> <td colspan="4">
<table border=".1" class="box" width="100%"> <tr> <th align="left">Evaluation project</th> <th>Delete</th> </tr>
<cfloop query="getwrk">
	<cfif getwrk.selfevalid is not ''>
	<tr>
		<td valign="top" bgcolor="##EEEEEE"><a href="cat_work.cfm?selfevalid=#getwrk.wrkselfid#&objval=#session.objval#">#getwrk.selfevaltxt#</a></td>
		<td bgcolor="##EEEEEE" align="center"><input type="Checkbox" name="Del_box3" value="#getwrk.wrkselfid#"></td>
	</tr>
	</cfif>
</cfloop>
<tr><td colspan=2><input type="Button" name="del_staff" value="Delete" onclick="submit();" class="DelButton"> </td></tr>
</table>
</td></tr>
</cfoutput>

</cfif>
<tr><td colspan=2 align="center"><input type="submit" name="return" value="Save and return to menu" onClick="window.location.href('cat_work.cfm');">
</td> </tr>
<!--- </table>
</td> </tr> --->
</cfif>


<!--- </cfif> --->



			</cfform>
</table>
		<cfif session.fy LT session.def_fy AND session.prevyr NEQ 1 AND NOT (SESSION.areamanage EQ "1" OR SESSION.admin EQ "1" OR SESSION.TCP EQ "1")>
			<script language="JavaScript">
	disableme();
</script>
		</cfif>

		<!---<cfif session.modality EQ 1 and session.admin NEQ 1 and #session.objval# NEQ '1E'>
			<script language="JavaScript">
			function disableSO(){
			var str = '';
			var elem = document.wrk.elements;
			for(var i = 0; i < elem.length; i++)
			{
			if(elem[i].name.substring(0,4) == 'SO1_' || elem[i].name.substring(0,4) == 'SO2_'){
			document.wrk.elements[i].disabled=true;
			document.wrk.elements[i].style.backgroundColor="#CCCCCC";
			document.wrk.elements[i].style.Color="#000000#";
			}
			}
			}
			disableSO();
			</script>
			</cfif>--->
	</body>
</html>
