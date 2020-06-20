<cfif session.modality EQ 1 and session.fy GTE 2013>
	<cfinclude template="Month_2013.cfm">
<cfelse>
<cfif isdefined ("url.obj")>
	<cfset attributes.obj2=url.obj>
<cfelseif isDefined("form.obj2")>
	<cfset attributes.obj2=form.obj2>
<cfelseif isDefined("session.objval")>
	<cfset attributes.obj2=session.objval>
</cfif>
<style>
.box {
	font-family: verdana, helvetica, sans-serif;
	font-size: 11px;
	color: #333366;
	background-color: #EEEEEE;
	border: solid 1px #CCCC99;
	list-style:inherit;
	border-collapse: collapse;
}
.box2 {
	font-family: verdana, helvetica, sans-serif;
	font-size: 11px;
	color: #003366;
	background-color: #FFF8DC;
	border: none;
	list-style:inherit;
	border-collapse: collapse;
}
</style>
<!---  <cfoutput>#session.modality# #session.objnum#</cfoutput>
 ---><SCRIPT LANGUAGE="JavaScript" SRC="../scripts/cfform.js"> </SCRIPT>
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
     <script>
  $(function() {
$('.datepicker').datepicker({ dateFormat: 'mm-dd-yy' }).val();
});
  </script>
 <SCRIPT LANGUAGE="JavaScript">
	  function toggle_visibility0(id) {
 	     var e = document.getElementById(id);
	     var boolLaw = document.wrk.boolLaw[0].checked;
		 if(boolLaw == true){
       if(e.style.display == 'block')
          e.style.display = 'none';
       else
          e.style.display = 'block';
		  }
		  else
		  {
		  e.style.display = 'none';
		  }
		  show_other('posThree', 'hide');show_other('posFour', 'show');
		  }
function pos3()
{
var lbody = document.wrk.lbody.value
var county = document.wrk.county.value
var jurs = document.wrk.jurName.value
var boo1 = document.wrk.boolPassed[0].checked
var boo2 = document.wrk.boolPassed[1].checked
var vadd1 = document.wrk.vaddressed1.checked
var vadd2 = document.wrk.vaddressed2.checked
var vadd3 = document.wrk.coupon.checked
if (lbody == '')
{
alert('Please select the lawmaking body that voted on the law/regulation.');
return false;
}
if (jurs == '')
{
alert('Please enter jurisdiction name.');
return false;
}
<cfif isdefined("session.objnum") and (#session.objnum# is '2d' or #session.objnum# is '2e')>
if (county == '')
{
alert('Please select a county.');
return false;
}
</cfif>
if ((vadd1 == '')&&(vadd2 == '')&&(vadd3 == ''))
{
alert('Please indicate what the vote addressed.');
return false;
}
if ((boo1 == false)&&(boo2 == false))
{
alert('Please indicate whether the law/regulation passed.');
return false;
}
if (boo1 == true)
{
var jurnum = document.wrk.jurNum.value
var policydesc = document.wrk.policydesc.value
if (jurnum == '')
{
alert('Please specify how many people reside in this jurisdiction.');
return false;
}

if ((jurnum != '')&&(isNaN(document.wrk.jurNum.value) == true))
{
  alert('Number of people who reside in this jurisdiction must be numeric');
  return false;
}
if (policydesc == '')
{
alert('Please provide a brief description of the law/regulation');
return false;
}

if (document.wrk.cntrcAgree2.checked == false){
alert ('Please check to agree to submit a written copy.');
return false;
}
}


if ((boo2 == true) && (document.wrk.txtConcerns.value == '')){
alert ('Please Indicate the lawmaker concerns.');
return false;

}

if (boo2 == true){
if (document.wrk.cntrcAgree.checked == false){
alert ('Please check to agree to submit a written copy.');
return false;
}
}


}
function pos33()
{
var jurs = document.wrk.jurName2.value
var txtConcerns = document.wrk.txtConcerns.value
var boo1 = document.wrk.boolPassed2[0].checked
var county = document.wrk.County.value
<cfif session.fy GTE 2012>
if(document.wrk.lbody2.selectedIndex==0){
alert('Please select a lawmaking body.');
return false
}
if(document.wrk.SFord2.checked == false && document.wrk.SFord4.checked == false && document.wrk.SFord5.checked == false){
alert('Please indicate where the policy/ordinance prohibits smoking');
return false;
}
if (county == '')
{
alert('Please select a county.');
return false;
}
if (jurs == '')
{
alert('Please enter jurisdiction name.');
return false;
}
if(document.wrk.boolPassed2[0].checked == false && document.wrk.boolPassed2[1].checked == false){
alert('Please indicate if the policy/ordinance was passed.');
return false;
}
if (boo1 == true)
{
</CFIF>
if (jurs == '')
{
alert('Please enter jurisdiction name.');
return false;
}
if (county == '')
{
alert('Please select a county.');
return false;
}
if (boo1 == true)
{
var jurnum = document.wrk.jurNum.value
if (jurnum == '')
{
alert('Please specify how many people reside in this jurisdiction.');
return false;
}
}
<cfif session.fy GTE 2012>
<cfif session.fy LT 2013>
var jurnum = document.wrk.jurNum.value
if (jurnum == '')
{
alert('Please specify how many people reside in this jurisdiction.');
return false;
}
</cfif>
}
if(document.wrk.boolPassed2[0].checked == true && document.wrk.cntrcAgree2.checked == false){
alert('Please check the box agreeing to send documentation to Alison Rhodes-Devey.');
return false;
}
if(document.wrk.boolPassed2[1].checked == true)
if (txtConcerns == ''){
alert ('Please enter any concerns expressed by the lawmaking body.');
return false;
}
if (document.wrk.boolPassed2[1].checked == true && document.wrk.cntrcAgree.checked == false)
{
alert('Please check the box agreeing to send documentation to Alison Rhodes-Devey.');
return false;
}
</cfif>
}
function POS44(){
	document.wrk.action="month.cfm#pos44";
	if (document.wrk.SForg.selectedIndex==0){
	alert('Please select the name of the organization.');
	return false;}
var county = document.wrk.county.value
var desc = document.wrk.SFPnMuniDesc.value
if (county == '')
		{
		alert ('Please select the county/ies affected by the policy.');
	return false;
		}
if(document.wrk.SFPol2.checked == false && document.wrk.SFPol4.checked == false && document.wrk.SFPol5.checked == false){
alert('Please indicate where the policy prohibits smoking.');
return false;}
if (desc == '')
{
alert('Please enter a brief description of the policy.');
return false;}
return true;
}
function pos2(shain)
{
var shain = document.wrk.sChainName.value
if (shain == '')
{
alert('Please select a supermarket chain.');
return false;
}
document.wrk.addPOS2.value = 'Add';
}
      function show_other (divname, shide) {
             var textField_div = document.getElementById(divname);
            if ( shide == 'show' ) {
                  // show other text box
                  textField_div.style.display = "block";

            } else {
                  // hide other text box
                  textField_div.style.display = "none";
            }
      }
     function show_other2 (fieldstat, divname) {
     	     var textField_div = document.getElementById(divname);
     	     var textField = eval(fieldstat);

     	    if (textField[0].checked==true) {
                  textField_div.style.display = "block";

            } else {
                 textField_div.style.display = "none";
            }
      }
function presetPos(){
var stone= -1;
var sttwo= -1;
var stthree= -1;
var cnt = -1;
 for (var i=document.wrk.boolLaw.length-1; i > -1; i--) {
        if (document.wrk.boolLaw[i].checked) {
        	if(document.wrk.boolLaw[i].value ==1){
        	show_other('posOne', 'hide');
        	show_other('posTwo', 'show');
        	show_other('posThree','hide');
        	stone = 1;
        	}
        	if(document.wrk.boolLaw[i].value ==0){
        	show_other('posOne', 'show');
        	show_other('posTwo', 'hide');
        	show_other('posThree','hide');
        	show_other('posFour', 'hide');
        	stone = 1;
        	}
}
}
var cnt = -1;
 for (var i=document.wrk.boolPassed.length-1; i > -1; i--) {
        if (document.wrk.boolPassed[i].checked) {
        	if(document.wrk.boolPassed[i].value ==1){
        	show_other('posThree', 'hide');
        	show_other('posFour', 'show');
        	sttwo = 1;
        	}
        	if(document.wrk.boolPassed[i].value ==0){
        	show_other('posThree', 'show');
        	show_other('posFour', 'hide');
        	sttwo = 1;
        	}
}
}
<cfif session.modality EQ 2 and isdefined("attributes.obj2") and #attributes.obj2# EQ '2d' and session.fy LT 2012>
if(document.wrk.boolSuperPol){
var cnt = -1;
 for (var i=document.wrk.boolSuperPol.length-1; i > -1; i--) {
        if (document.wrk.boolSuperPol[i].checked) {
        	if(document.wrk.boolSuperPol[i].value ==1){
        	show_other('posFive', 'hide');
        	show_other('posSix', 'show');
        	stthree = 1;
        	}
        	if(document.wrk.boolSuperPol[i].value ==0){
        	show_other('posFive', 'show');
        	show_other('posSix', 'hide');
        	stthree = 1;
        	}
}
}
	}
</cfif>
if (stone == -1){show_other('posOne', 'hide'); show_other('posTwo', 'hide'); show_other('posThree','hide');}
if (sttwo == -1){show_other('posThree', 'hide'); show_other('posFour', 'hide');}
<cfif session.modality EQ 2 AND isdefined("attributes.obj2") and attributes.obj2 EQ  '2d'>
 if(document.wrk.boolSuperPol){
 if (stthree == -1){show_other('posFive', 'hide'); show_other('posSix', 'hide');}
if (document.wrk.boolPassed[1].checked) {show_other('posThree', 'hide');}
 }
</cfif>
}
function presetSFM(){
var stoney= -1;
var cnt = -1;
 for (var i=document.wrk.sfm.length-1; i > -1; i--) {
        if (document.wrk.sfm[i].checked) {
        	if(document.wrk.sfm[i].value ==1){
        	/* show_other('sfm2', 'hide');
        	show_other('sfm1', 'show'); */
        	show_other('sfm1', 'hide');
        	show_other('sfm2', 'show');
        	stoney = 1;
        	}
        	if(document.wrk.sfm[i].value ==0){
        	<!--- show_other('sfm1', 'show');
        	show_other('sfm2', 'hide'); --->
        	show_other('sfm1', 'show');
        	show_other('sfm2', 'hide');
        	stoney = 1;
        	}
}
}
if (stoney == -1){show_other('sfm1', 'hide'); show_other('sfm2', 'hide');}
}
function presetSFO(){
var stone= -1;
var sttwo= -1;
var stthree= -1;
var cnt = -1;
<cfif NOT(session.modality EQ 5 AND attributes.obj2 EQ '2e')>
 for (var i=document.wrk.boolSFOP.length-1; i > -1; i--) {
        if (document.wrk.boolSFOP[i].checked) {
        	if(document.wrk.boolSFOP[i].value ==1){
        	show_other('SFODOne', 'hide');
        	show_other('SFODTwo', 'show');
        	stone = 1;
        	}
        	if(document.wrk.boolSFOP[i].value ==0){
        	show_other('SFODOne', 'show');
        	show_other('SFODTwo', 'hide');
        	stone = 1;
        	}
}
}
var cnt = -1;
 for (var i=document.wrk.boolPassed2.length-1; i > -1; i--) {
        if (document.wrk.boolPassed2[i].checked) {
        	if(document.wrk.boolPassed2[i].value ==1){
        	show_other('SFODThree', 'hide');
        	show_other('SFODFour', 'show');
        	sttwo = 1;
        	}
        	if(document.wrk.boolPassed2[i].value ==0){
        	show_other('SFODThree', 'show');
        	show_other('SFODFour', 'hide');
        	sttwo = 1;
        	}
}
}
</cfif>
var cnt = -1;
 for (var i=document.wrk.boolSFOP2.length-1; i > -1; i--) {
        if (document.wrk.boolSFOP2[i].checked) {
        	if(document.wrk.boolSFOP2[i].value ==1){
        	show_other('SFODFive', 'hide');
        	show_other('SFODSix', 'show');
        	stthree = 1;
        	}
        	if(document.wrk.boolSFOP2[i].value ==0){
        	show_other('SFODFive', 'show');
        	show_other('SFODSix', 'hide');
        	stthree = 1;
        	}
}
}
<cfif NOT(session.modality EQ 5 AND attributes.obj2 EQ '2e')>
if (stone == -1){show_other('SFODOne', 'hide'); show_other('SFODTwo', 'hide'); show_other('SFODThree','hide');show_other('SFODFour','hide');}
if (sttwo == -1){show_other('SFODThree', 'hide'); show_other('SFODFour', 'hide');}
</cfif>
if (stthree == -1){show_other('SFODFive', 'hide'); show_other('SFODSix', 'hide');}
}
function disableme(){
for(var intloop=0; intloop <document.wrk.length; intloop++){
	if(document.wrk[intloop].type=='textarea'){
	document.wrk[intloop].readOnly = true;
	}
	else
document.wrk[intloop].disabled=true;
}
}
function countitAny(what,when){
//Character count script- by javascriptkit.com
//Visit JavaScript Kit (http://javascriptkit.com) for script
//Credit must stay intact for use
formcontent=document.getElementById(what).value
document.getElementById(when).value=formcontent.length
}
 function countit(what){
formcontent=what.form.summary.value
what.form.summdisplaycount.value=formcontent.length
}
 function countit2(what){
formcontent=what.form.barriers.value
what.form.barrdisplaycount.value=formcontent.length
}
 function countit3(what){
formcontent=what.form.steps.value
what.form.stepdisplaycount.value=formcontent.length
}
 function countit10(what){
formcontent=eval('document.wrk.summary' + what + '.value');
var tempname='evalsummdisplaycount' + what;
var obj = document.getElementById(tempname);
obj.value = formcontent.length;
}
 function countit20(what){
formcontent=eval('document.wrk.barriers' + what + '.value');
var tempname='evalbarrdisplaycount' + what;
var obj = document.getElementById(tempname);
obj.value = formcontent.length;
}
 function countit30(what){
formcontent=eval('document.wrk.steps' + what + '.value');
var tempname='evalstepdisplaycount' + what;
var obj = document.getElementById(tempname);
obj.value = formcontent.length;
}
 function countit40(what){
formcontent=what.form.specSuperActTxt.value
what.form.specSuperActTxtdisplaycount.value=formcontent.length
}
 function countit50(what){
formcontent=what.form.specLawTxt.value
what.form.specLawTxtdisplaycount.value=formcontent.length
}
 function countit60(what){
formcontent=what.form.specSFODTxt.value
what.form.specSFODTxtdisplaycount.value=formcontent.length
}
 function countit70(what){
formcontent=what.form.specSFODTxt2.value
what.form.specSFODTxt2displaycount.value=formcontent.length
}
 function countit80(what){
formcontent=what.form.specSFODTxt2.value
what.form.specSFODTxt2displaycount.value=formcontent.length
}
function countit85(what){
formcontent=what.form.HSC_DESC.value
what.form.HSC_DESCdisplaycount.value=formcontent.length
}
 function counterUpdate(opt_countedTextBox, opt_countBody, opt_maxSize) {
        var countedTextBox = opt_countedTextBox ? opt_countedTextBox : "counttxt";
        var countBody = opt_countBody ? opt_countBody : "countBody";
        var maxSize = opt_maxSize ? opt_maxSize : 1024;
        var field = document.getElementById(countedTextBox);
        if (field.value.length >= maxSize) {
           		alert("The maximum length for this field is 1000 characters.");
				return false;
        }
}
function checkPOS(){
var pos = document.wrk.boolLaw[0].checked
var pos1 = document.wrk.boolLaw[1].checked
if ((pos == false)&&(pos1 == false))
{
alert('Was a law/regulation voted on by a lawmaking body during this month?”');
return false;
}
if (pos == true)
{
var jurs = document.wrk.jurname.value
if (jurs == '')
{
alert('Please enter jurisdiction name.');
return false;
}
}
}
function checkTG(){
var train = document.wrk.train.value
var attend2 = document.wrk.attend2.value
var award = document.wrk.award.value
var nrt = document.wrk.nrt.value
var pipa = document.wrk.pipa.value
<cfif session.fy GT 2011>
var pipb = document.wrk.pipb.value
var pipc = document.wrk.pipc.value
var targ = document.wrk.targ.selectedIndex
</cfif>
if ((train != '')&&(isNaN(document.wrk.train.value) == true))
{
  alert('Number of trainings for the HCPO this month must be numeric');
  return false;
}
if ((attend2 != '')&&(isNaN(document.wrk.attend2.value) == true))
{
  alert('Number of attendees this month must be numeric');
  return false;
}
if ((award != '')&&(isNaN(document.wrk.award.value) == true))
{
  alert('Amount awarded this month must be numeric');
  return false;
}
if ((nrt != '')&&(isNaN(document.wrk.nrt.value) == true))
{
  alert('Number of 2-week NRT units provided this month must be numeric');
  return false;
}
if ((pipa != '')&&(isNaN(document.wrk.pipa.value) == true))
{
  alert('Completed Stage A must be numeric');
  return false;
}
<cfif session.fy GT 2011>
if ((pipa != '')&&(isNaN(document.wrk.pipa.value) == true))
{
  alert('Completed Stage A must be numeric');
  return false;
}
if ((pipb != '')&&(isNaN(document.wrk.pipb.value) == true))
{
  alert('Completed Stage B must be numeric');
  return false;
}
if ((pipc != '')&&(isNaN(document.wrk.pipc.value) == true))
{
  alert('Completed Stage C must be numeric');
  return false;
}
if(targ == 0){
	alert('Please select a target HCPO');
	return false;
}
</cfif>
add('addTG');
document.wrk.action="month.cfm#thcpo";
}
function loopForm(form) {
    var cbResults = 'Checkboxes: ';
    var radioResults = 'Radio buttons: ';
    for (var i = 0; i < form.elements.length; i++ ) {
        if (form.elements[i].type == 'checkbox') {
            if (form.elements[i].checked == true) {
                cbResults += form.elements[i].value + ' ';
            }
        }
        if (form.elements[i].type == 'radio') {
            if (form.elements[i].checked == true) {
                radioResults += form.elements[i].value + ' ';
            }
        }
    }
    document.getElementById("cbResults").innerHTML = cbResults;
    document.getElementById("radioResults").innerHTML = radioResults;
}
function checkHUD(){
hudtarg = document.wrk.HUD_target.value
units = document.wrk.units.value
dt = document.wrk.dt.value
notes = document.wrk.HUD_notes.value
	if (hudtarg != ''){
if (units == '')
{
  alert('Please enter number of HUD units');
  return false;
}
if (isNaN(document.wrk.units.value) == true)
{
alert('Number of HUD units must be numeric');
  return false;
}
if (dt == '')
{
  alert('Please enter implementation date');
  return false;
}
if (notes == '')
{
  alert('Please enter description of activity');
  return false;
}
	}
	}
function checkIG(){
mod = document.wrk.modality.value
var objy = document.wrk.objy.value
	if(document.wrk.targ999[document.wrk.targ999.selectedIndex].value == ''){
	alert ('Please select an Org Name before adding this entry.');
	return false;
	}
	if ((mod == 5)&&(objy == "2M")){
var tiki = 0
   for (var i = 0; i < document.wrk.elements.length; i++ ) {
        if (document.wrk.elements[i].type == 'checkbox') {
            if (document.wrk.elements[i].checked == true) {
               tiki = tiki + 1
            }
        }}
		if (tiki == 0)
		{
	alert ('Please enter the Description before adding this entry.');
		return false;
		}}
		if (objy == "4F")
		{
		var opt1 = document.wrk.option1.value
		var opt2 = document.wrk.option2.value
		var opt3 = document.wrk.option3.value
		var opt4 = document.wrk.option4.value
		var numun = document.wrk.numUnits.value
		var county = document.wrk.county.value
		var policydesc = document.wrk.policydesc.value
		if (((document.wrk.option1.checked != 1)&&(document.wrk.option2.checked != 1)&&(document.wrk.option3.checked != 1)&&(document.wrk.option4.checked != 1))){
	alert ('Please select at least 1 checkbox under Description');
		return false;
		}if (numun == ''){
	alert ('Please enter the exact number of units covered');
		return false;
		}
if (county == '')
		{
		alert ('Please select the county/ies affected by the policy.');
	return false;
		}
if (policydesc == '')
		{
		alert ('Please enter a brief description of the policy.');
	return false;
		}
if(document.wrk.cntrcAgree2.checked != true){
alert('Please select the check box indicating that you have sent a written copy of the policy to Alison Rhodes-Devey.');
return false;
}
		}
	if ((mod == 3)&&((objy == "2L")||(objy == '3G'))){
	var opentxt = document.wrk.opntxt.value
	if (opentxt == '')
	{
	alert ('Please enter your Description before adding this entry.');
	return false;
	}}
	if ((mod == 2)&&(objy == "4F")){
var tiki = 0
   for (var i = 0; i < document.wrk.elements.length; i++ ) {
        if (document.wrk.elements[i].type == 'checkbox') {
            if (document.wrk.elements[i].checked == true) {
               tiki = tiki + 1
            }
        }}
		if (tiki == 0)
		{
	alert ('Please indicate where smoking is prohibited.');
		return false;
		}
		else
		{
		var opt1 = document.wrk.option1.value
		var opt2 = document.wrk.option2.value
		var opt3 = document.wrk.option3.value
		var opt4 = document.wrk.option4.value
		var opt5 = document.wrk.option5.value
		var opt6 = document.wrk.option6.value
		var opt7 = document.wrk.option7.value
		if (((document.wrk.option1.checked != 1)&&(document.wrk.option2.checked != 1)&&(document.wrk.option3.checked != 1))){
	alert ('Please indicate where smoking is prohibited.');
		return false;
		}
if (((document.wrk.option4.checked != 1)&&(document.wrk.option5.checked != 1)&&(document.wrk.option6.checked != 1)&&(document.wrk.option7.checked != 1))){
	alert ('Please indicate the number of units.');
		return false;
		}
		}}
add('addIG');
document.wrk.action="month.cfm#pro";
}
function checkMOG(){
var medout = document.wrk.medout.value
var opt1 = document.wrk.polprohib1.value
		var opt2 = document.wrk.polprohib2.value
		var opt3 = document.wrk.polprohib3.value
				var jurname = document.wrk.jurname3.value
					var county = document.wrk.county.value
if (medout == '')
{
alert('Please select a local media outlet.');
return false;
}
		if (((document.wrk.polprohib1.checked != 1)&&(document.wrk.polprohib2.checked != 1)&&(document.wrk.polprohib3.checked != 1))){

	alert ('Please indicate what the policy prohibits.');
		return false;
		}

		if((document.wrk.polprohib3.checked == 1) && (document.wrk.polprohibtxt.value == '')){
		alert ('Please indicate "Other".');
		return false;

		}
		if (jurname == '')
{
alert('Please enter jurisdiction name.');
return false;
}
if (county == '')
		{
		alert ('Please select the county/ies affected by the policy.');
	return false;
		}
if(document.wrk.sfmAgree.checked != true){
alert('Please select the check box indicating that you have sent a written copy of the policy to Alison Rhodes-Devey.');
return false;
}
add('addMOG');
document.wrk.action="month.cfm#medout";
}
function checkPPG(){
	if(document.wrk.targ2.selectedIndex == 0){
	alert('Please select a target HCPO');
	return false;
}
add('addPPG');
document.wrk.action="month.cfm#ppc";
}
function checkCMMOB(){
	 var obj = document.wrk.objy.value;
if(document.wrk.targ2a.selectedIndex==0){
	alert('Please select a Target name');
	return false;
}
if ((obj != '3M')&&(obj != '4F')&&(obj != '2E'))
{
if ((document.wrk.commed.checked == 0)&&(document.wrk.govt.checked == 0))
{
alert('Please indicate which strategies your interaction with this target contributed towards.');
return false;
}
}
if ((obj == '3M')||(obj == '4F')||(obj == '2E'))
{
if ((document.wrk.commed.checked == 0)&&(document.wrk.Advoc.checked == 0)&&(document.wrk.govt.checked == 0))
{
alert('Please indicate which strategies your interaction with this target contributed towards.');
return false;
}
}
if(document.wrk.youth[0].checked == false && document.wrk.youth[1].checked==false){
	alert('Please select a response to were youth directly involved in this stratgegy.');
	return false;
}
if(document.wrk.advance.value.length == 0){
	alert('Please briefly describe how this target helped advance/achieve your outcome this month.');
	return false;
}
add('addcmmmob');
document.wrk.action="month.cfm#cmmmob";
}
function checkSG(){
var summ = document.wrk.summary.value
 var summm = document.wrk.summdisplaycount.value
 var barr = document.wrk.barrdisplaycount.value
 var step = document.wrk.stepdisplaycount.value
var modality = document.wrk.modality.value
var objy = document.wrk.objy.value
if (objy == '3M')
{
var sfm = document.wrk.sfm[0].checked
var sfm2 = document.wrk.sfm[1].checked
var youtube = document.wrk.youTube.value
if ((sfm == '')&&(sfm2 == ''))
{
alert("Please indicate whether a local media outlet implemented a policy.");
return false;
}
if ((youtube != '')&&(isNaN(document.wrk.youTube.value) == true))
{
  alert('Number of YouTube videos flagged this month must be numeric');
  return false;
}
}
if (summ == '')
{
  alert('Summary of activities cannot be left blank');
  return false;
}
if (summm > 2000)
{
alert('Summary cannot exceed 2000 characters.');
return false;
}
if (barr > 2000)
{
alert('Barriers cannot exceed 2000 characters.');
return false;
}
if (step > 2000)
{
alert('Steps cannot exceed 2000 characters.');
return false;
}
if ((modality != 5)&&(objy == '2E'))
{
 var spec3 = document.wrk.specSFODTxtdisplaycount.value
 var spec4 = document.wrk.specSFODTxt2displaycount.value
if ((spec3 > 1000)||(spec4 > 1000))
{
alert('Specific Activities cannot exceed 1000 characters.');
return false;
}
}
if ((modality == 5)&&(objy == '2E'))
{
 var spec5 = document.wrk.specSFODTxt2displaycount.value
if (spec5 > 1000)
{
alert('Specific Activities cannot exceed 1000 characters.');
return false;
}
var xc = 0;
for(var i = 0; i < document.wrk.boolSFOP2.length; i++) {
		if(document.wrk.boolSFOP2[i].checked) {
			xc = 1;
		}
	}
if (xc == 0){
alert('Please enter a response to the question "Was a tobacco-free outdoors policy adopted by an organization other than a jurisdiction during this month?"');
return false;
}
}
if (((modality == 3) || (modality == 2)) && (objy == '2D')){
var booly = document.wrk.boolLaw[1].checked
if (booly == true)
{
	var boolytxt = document.wrk.specLawTxt.value
	if (boolytxt == '')
	{
	alert('Please specify what specific activities related to the Point of Sale visibility/retailers law/regulation outcome/s will be undertaken prior to your next monthly report.');
	return false;
}
}
var xc = 0;
for(var i = 0; i < document.wrk.boolLaw.length; i++) {
		if(document.wrk.boolLaw[i].checked) {
			var xc = 1;
		}
	}
if (xc == 0){
alert('Please enter a response to the question "Was a Point of Sale law/regulation voted on by a lawmaking body during this month?"');
return false;
}
}
if ((modality == 2) && (objy == '2D')){
var xc = 0;
if(document.wrk.boolSuperPol){
for(var i = 0; i < document.wrk.boolSuperPol.length; i++) {
		if(document.wrk.boolSuperPol[i].checked) {
			var xc = 1;
		}
	}
if (xc == 0){
alert('Please enter a response to the question "Was a policy adopted by a supermarket chain during this reporting period?"');
return false;
}}
}
if (((modality == 3) || (modality == 2)) && (objy == '2E')){
	var booly = document.wrk.boolSFOP[1].checked
if (booly == true)
{
	var boolytxt = document.wrk.specSFODTxt.value
	if (boolytxt == '')
	{
	alert('Please specify what specific activities related to the Smoke-free Outdoors outcome will be undertaken prior to your next monthly report.');
	return false;
}
}
var xc = 0;
for(var i = 0; i < document.wrk.boolSFOP.length; i++) {
		if(document.wrk.boolSFOP[i].checked) {
			var xc = 1;
		}
	}
if (xc == 0){
alert('Please enter a response to the question "Was a tobacco-free outdoors policy or ordinance voted on by a lawmaking body during this month?"');
return false;
}
var booly = document.wrk.boolSFOP2[1].checked
if (booly == true)
{
	var boolytxt = document.wrk.specSFODTxt2.value
	if (boolytxt == '')
	{
	alert('Please specify what specific activities related to this policy outcome will be undertaken prior to your next monthly report.');
	return false;
}
}
var xc = 0;
for(var i = 0; i < document.wrk.boolSFOP2.length; i++) {
		if(document.wrk.boolSFOP2[i].checked) {
			var xc = 1;
		}
	}
if (xc == 0){
alert('Please enter a response to the question "Was a tobacco-free outdoors policy adopted by an organization other than a jurisdiction during this month?"');
return false;
}
}
if (objy == '2D')
{
 var spec6 = document.wrk.specLawTxtdisplaycount.value
if (spec6 > 1000)
{
alert('Specific Activities cannot exceed 1000 characters.');
return false;
}
if (modality == 2 && (document.wrk.specSuperActTxtdisplaycount))
{
 var spec7 = document.wrk.specSuperActTxtdisplaycount.value
if (spec7 > 1000)
{
alert('Specific Activities cannot exceed 1000 characters.');
return false;
}
}
}
document.wrk.action="month.cfm";
add('addSG');
}
function checkOK(){
var targ3 = document.wrk.targ3.value
var sampnum = document.wrk.sampnum.value*1
var patscreen = document.wrk.patscreen.value*1
var patident = document.wrk.patident.value*1
var userquit = document.wrk.userquit.value*1
var userinterv = document.wrk.userinterv.value*1
if (targ3 == '')
{
alert('You must select a Target HCPO');
return false;
}
if ((sampnum != '')&&(isNaN(document.wrk.sampnum.value) == true))
{
  alert('Number of patients in sample must be numeric');
  return false;
}
if ((patscreen != '')&&(isNaN(document.wrk.patscreen.value) == true))
{
  alert('Number of patients screened must be numeric');
  return false;
}
if ((patident != '')&&(isNaN(document.wrk.patident.value) == true))
{
  alert('Number of patients identified as tobacco users must be numeric');
  return false;
}
if ((userquit != '')&&(isNaN(document.wrk.userquit.value) == true))
{
  alert('Number of tobacco users ready to quit must be numeric');
  return false;
}
if ((userinterv != '')&&(isNaN(document.wrk.userinterv.value) == true))
{
  alert('Number of tobacco users who receive interventions must be numeric');
  return false;
}
if (patscreen > sampnum)
{
alert('Number of patients screened must be less than or equal to number of patients in sample.');
return false;
}
if (patident > patscreen)
{
alert('Number of patients identified as tobacco users must be less than or equal to number of patients screened.');
return false;
}
if (userquit > patident)
{
alert('Number of tobacco users ready to quit must be less than or equal to number of patients identified as tobacco users.');
return false;
}
if (userinterv > patident)
{
alert('Number of tobacco users who receive interventions must be equal to number of patients identified as tobacco users.');
return false;
}
add('addOK');
document.wrk.action="month.cfm#outc";
}
  function checkAG(){
  document.wrk.strat.value = 1;
  var targ = document.wrk.targ.value;
  if (targ =='')
  {
  alert('You must select an org name');
  return false;
  }
var meet = document.wrk.meet.value
var phone = document.wrk.fon.value
var lett = document.wrk.lett.value
var email = document.wrk.email.value
if ((meet == 0)&&(phone == 0)&&(lett == 0)&&(email == 0))
{
  alert('Please enter something for meetings, phone calls, letters, emails');
  return false;
}
if ((phone != '')&&(isNaN(document.wrk.fon.value) == true))
{
  alert('Number of phone calls must be numeric');
  return false;
}
if ((meet != '')&&(isNaN(document.wrk.meet.value) == true))
{
  alert('Number of meetings must be numeric');
  return false;
}if ((lett != '')&&(isNaN(document.wrk.lett.value) == true))
{
  alert('Number of letters must be numeric');
  return false;
}if ((email != '')&&(isNaN(document.wrk.email.value) == true))
{
  alert('Number of emails must be numeric');
  return false;
}
add('addAG');
document.wrk.action="month.cfm#advadv";
}
  function checkAAG(){
  var summ = document.wrk.summary.value
 var summm = document.wrk.summdisplaycount.value
 var barr = document.wrk.barrdisplaycount.value
 var step = document.wrk.stepdisplaycount.value
if (summ == '')
{
  alert('Summary of activities cannot be left blank');
  return false;
}
if (summm > 2000)
{
alert('Summary cannot exceed 2000 characters.');
return false;
}
if (barr > 2000)
{
alert('Barriers cannot exceed 2000 characters.');
return false;
}
if (step > 2000)
{
alert('Steps cannot exceed 2000 characters.');
return false;
}
document.wrk.strat.value = 1;
add('addSG');
}
  function checkCC(){
  var targ7 = document.wrk.targ7.value;
  var adv1 = document.wrk.adcomm.checked;
  var adv2 = document.wrk.prvtrain.checked;
  var adv3 = document.wrk.techass1.checked;
  if (targ7 =='')
  {
  alert('You must select a target organization before adding this entry.');
  return false;
  }
  if ((adv1 == false)&&(adv2 == false)&&(adv3 == false))
  {
  alert('You must check at least one box before adding this entry.');
  return false;
  }
  if(document.wrk.adcomm_descr.value.length == 0){
  alert('Please describe your interactions with the target this month.');
  return false;
  }
add('addCC');
document.wrk.action="month.cfm#advadv";
}
  function checkBG(){
document.wrk.action="month.cfm#advadv";
  document.wrk.strat.value = 2;
 <cfif session.fy GT 2011>
	if(document.wrk.targ2.selectedIndex==0){
 alert('Please select a Target name.');
 return false;
 }
   var nat1 = document.wrk.nature1.checked;
  var nat2 = document.wrk.nature2.checked;
  var nat3 = document.wrk.nature3.checked;
  if ((nat1 == false)&&(nat2 == false)&&(nat3 == false))
  {
  alert('Please select the categories which best describe the nature of the conversation with this Government Policy-maker.');
  return false;
  }
 </cfif>
 if(document.wrk.interact.value.length == 0){
 alert('Please describe your interaction with the target this month.');
return false
 }
var govtmail = document.wrk.govtmassmail.value
var targ2 = document.wrk.targ2.value
if ((govtmail != '')&&(isNaN(document.wrk.govtmassmail.value) == true))
{
  alert('Number of government policy makers must be numeric.');
  return false;
}
if (targ2 == '')
{
  alert('Please select an org name.');
  return false;
}
var meet = document.wrk.meet2.value
var phone = document.wrk.phone2.value
var letter = document.wrk.letter2.value
var email = document.wrk.email2.value
if ((meet == '')&&(phone == '')&&(letter == '')&&(email == ''))
{
  alert('Please enter something for meetings, phone calls, letters, emails');
  return false;
}
if ((phone != '')&&(isNaN(document.wrk.phone2.value) == true))
{
  alert('Number of phone calls must be numeric');
  return false;
}
if ((meet != '')&&(isNaN(document.wrk.meet2.value) == true))
{
  alert('Number of meetings must be numeric');
  return false;
}if ((letter != '')&&(isNaN(document.wrk.letter2.value) == true))
{
  alert('Number of letters must be numeric');
  return false;
}if ((email != '')&&(isNaN(document.wrk.email2.value) == true))
{
  alert('Number of emails must be numeric');
  return false;
}
add('addBG');
document.wrk.action="month.cfm#advadv";
}
  function checkCG(){
  document.wrk.strat.value = 3;
  var even = document.wrk.event.value;
  var target = document.wrk.target.value;
  <cfif session.fy LT 2012>
  var attend = document.wrk.attend.value;
  var orgpart = document.wrk.orgpart[0].checked;
  var orgpart1 = document.wrk.orgpart[1].checked;
  var county = document.wrk.county.value;
	</cfif>
  if (even == '')
  {
  alert('You must enter an event name');
  return false;
  }
   if (target == '')
{
  alert('You must enter  a target');
  return false;
}
<cfif session.fy GTE 2012>
if (even.length > 1000) {
alert('Please keep your event description to less than 1000 characters.');
  return false;
}
if (target.length > 50) {
alert('Please keep your target description to less than 50 characters.');
  return false;
}
</cfif>
<cfif session.fy LT 2012>
  if (county == '')
  {
  alert('You must select a county');
  return false;
  }
  if (attend == '')
{
  alert('You must enter number of attendees');
  return false;
}
if ((attend != '')&&(isNaN(document.wrk.attend.value) == true))
{
  alert('Number of attendees this month must be numeric');
  return false;
}
if ((orgpart == false)&&(orgpart1 == false))
{
  alert('You must select organized or participated');
  return false;
}
</cfif>
add('addCG');
document.wrk.action="month.cfm#comm";
}
  function checkDG(){
  document.wrk.strat.value = 4;
var medtype = document.wrk.mediatype.value
var medchnnl = document.wrk.mediachannel.value
var spotit = document.wrk.spottitle.value
var num = document.wrk.number.value
var cost = document.wrk.cost.value
if (medtype == '')
{
  alert('Please select a media type.');
  return false;
}
if (medchnnl == '')
{
  alert('Please enter a media channel.');
  return false;
}
if (spotit == '')
{
  alert('Please enter a spot title.');
  return false;
}
if (num == '')
{
  alert('Please enter a number for number run/aired/printed.');
  return false;
}
  if (isNaN(document.wrk.number.value) == true)
{
  alert('Number must be numeric.');
  return false;
}
if (cost == '')

{
  alert('Please enter cost.');
  return false;
}
  if (isNaN(document.wrk.cost.value) == true)
{
  alert('Cost must be numeric.');
  return false;
}
add('addDG');
document.wrk.action="month.cfm#pm";
}
  function checkLG(){
var elem = document.getElementById('wrk').elements;
     if (document.wrk.stop.value == 0)
     {
     for(var i = 0; i < elem.length; i++)
        {
           var tempName=elem[i].name;
           if(tempName.substring(0,7)=='summary'){
           	var blah=tempName.substring(7);
           	var oy = 'summary' + blah;
if (document.getElementById(oy).value == '')
{
	 document.wrk.stop.value = 1
  alert('Summary of activities cannot be left blank');
  break;
   return false;
}
           	}
        	}
add('addLG');
     	}
document.wrk.action="month.cfm#media2";
}
function checkMG(){
add('addMG');
document.wrk.action="month.cfm#targ";
}
function checkMGG(){
add('addMGG');
document.wrk.action="month.cfm#targ";
}
function add(actvalue){
document.wrk.dofunction.value=actvalue;
return true;
}
function ugh(){
document.wrk.docsys[1].checked = false;
document.wrk.advise_ident.disabled = false;
document.wrk.assess_ident.disabled = false;
document.wrk.assarr_ident.disabled = false;
return true;
}
function ugh3(){
document.wrk.docsys[0].checked = false;
document.wrk.advise_ident.disabled = false;
document.wrk.assess_ident.disabled = false;
document.wrk.assarr_ident.disabled = false;
return true;
}
function ugh2(){
document.wrk.ask.disabled = false;
document.wrk.advise_writpol.disabled = false;
document.wrk.assess_writpol.disabled = false;
document.wrk.assarr_writpol.disabled = false;
document.wrk.train2.disabled = false;
return true;
}
function ugh4(){
document.wrk.idsys[1].checked = false;
}
function ugh5(){
document.wrk.idsys[0].checked = false;
}
function ugh6(){
document.wrk.userquit_na.checked = false;
}
function ugh7(){
document.wrk.userquit.value = '';
}
</SCRIPT>
<!--- <cfif session.fy LT 2007 and session.fy GT 1920>
	<cfinclude template="cat_annual_goal.cfm">
<cfelse>
<cfif  session.fy GT session.def_fy and  session.nextyr NEQ 1>
	<cflocation addtoken="yes" url="noFuture.cfm">
</cfif>  --->
<!--- <cfput>#session.objnum#</cfput><cfabort> --->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>CAT</title>
<body>
<cfinclude template="CATstruct.cfm">
<script language="JavaScript" src="../spellchecker/spell.js"></script>
<cfif isDefined("url.obj")>
	<cfset attributes.obj2 = url.obj >
<cfelseif isDefined("form.obj2")>
	<cfset  attributes.obj2 = form.obj2 >
</cfif>
<cfif isDefined ("form.boolLaw")>
			<cfset attributes.specLawTxt=form.specLawTxt>
</cfif>
<cfif isDefined ("form.specLawTxt") and #form.speclawtxt# is not ''>
			<cfset attributes.specLawTxt=form.specLawTxt>
</cfif>
<cfif isDefined ("form.boolSuperPol")>
			<cfset attributes.boolSuperPol=form.boolSuperPol>
</cfif>
<cfif isDefined ("form.specSuperActTxt") and #form.specsuperacttxt# is not ''>
			<cfset attributes.specSuperActTxt=form.specSuperActTxt>
</cfif>
<cfif isdefined("obj")>
<cfset session.objval = '#obj#'>
</cfif>
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
<cfif isdefined("obj") and #obj# is not ''>
<cfset session.objval = '#obj#'></cfif>
<cfparam name="attributes.boolSuperPol" default="">
<cfparam name="attributes.boollaw" default="">
<cfparam name="attributes.speclawtxt" default="">
<cfparam name="attributes.boolsfop" default="">
<cfparam name="attributes.boolsfop2" default="">
<cfparam name="attributes.specSFODTxt" default="">
<cfparam name="attributes.specSFODTxt2" default="">
<cfparam name="attributes.specSuperActTxt" default="">
<cfparam name="form.county" default="">
<cfparam name="form.speclawtxt" default="">
<cfparam name="form.sfmagree" default="">
<cfparam name="form.boolsfop" default="">
<cfparam name="form.boolsfop2" default="">
<cfparam name="form.boolpassed2" default="">
<cfparam name="form.sforg" default="">
<cfparam name="form.number" default="">
<cfparam name="form.cost" default="">
<cfparam name="form.orgpart" default="">
<cfparam name="form.commed" default="">
<cfparam name="form.advoc" default="">
<cfparam name="form.govt" default="">
<cfparam name="form.youth" default="">
<cfparam name="form.targy" default="">
<cfparam name="form.attend" default="">
<cfparam name="form.units" default="">
<cfparam name="form.numunits" default="">
<cfparam name="form.hud_notes" default="">
<cfparam name="form.lha" default="">
<cfparam name="form.prvtrain" default="">
<cfparam name="form.nature1" default="">
<cfparam name="form.nature2" default="">
<cfparam name="form.nature3" default="">
<cfparam name="form.email2" default="">
<cfparam name="form.letter2" default="">
<cfparam name="form.phone2" default="">
<cfparam name="form.meet2" default="">
<cfparam name="form.youtube" default="">
<cfparam name="form.sfm" default="">
<cfparam name="form.boollaw" default="">
<cfparam name="form.outcome" default="">
<cfparam name="form.userinterv" default="">
<cfparam name="form.patident" default="">
<cfparam name="form.patscreen" default="">
<cfparam name="form.sampnum" default="">
<cfparam name="form.targ" default="">
<cfparam name="form.editorial" default="">
<cfparam name="form.other" default="">
<cfparam name="form.ltred" default="">
<cfparam name="form.nwsstry" default="">
<cfparam name="form.nwsltr" default="">
<cfparam name="form.strat" default="">
<cfparam name="form.advmassmail" default="">
<cfparam name="form.govtmassmail" default="">
<cfparam name="form.boolSuperPol" default="">
<cfparam name="form.permiss" default="">
<cfparam name="permisss" default="">
<cfparam name="attributes.obj2" default="">
<cfparam name="form.ccmassmail" default="">
<cfparam name="form.prssrlse" default="">
<cfparam name="form.prsspk" default="">
<cfparam name="form.userquit" default="">
<cfparam name="form.userquit_na" default="">
<cfparam name="form.calls" default="">
<cfparam name="form.editor" default="">
<cfparam name="form.meet" default="">
<cfparam name="form.fon" default="">
<cfparam name="form.lett" default="">
<cfparam name="form.email" default="">
<cfparam name="form.adcomm" default="">
<cfparam name="form.adcomm1" default="">
<cfparam name="form.adcomm2" default="">
<cfparam name="form.adcomm3" default="">
<cfparam name="form.maintind" default="">
<cfparam name="form.train" default="">
<cfparam name="form.attend" default="">
<cfparam name="form.attend2" default="">
<cfparam name="form.techass1" default="">
<cfparam name="form.techass2" default="">
<cfparam name="form.techass3" default="">
<cfparam name="form.outc" default="">
<cfparam name="form.award" default="">
<cfparam name="form.nrt" default="">
<cfparam name="form.pipa" default="">
<cfparam name="form.pipb" default="">
<cfparam name="form.pipc" default="">
<cfparam name="form.notes" default="">
<cfparam name="form.massmail" default="">
<cfparam name="form.docsys" default="">
<cfparam name="form.idsys" default="">
<cfparam name="form.showz" default="">
<cfparam name="form.writpol" default="">
<cfparam name="form.assess_ident" default="">
<cfparam name="form.assarr_ident" default="">
<cfparam name="form.advise_writpol" default="">
<cfparam name="form.assess_writpol" default="">
<cfparam name="form.assarr_writpol" default="">
<cfparam name="form.train2" default="">
<cfparam name="form.assarr_fback" default="">
<cfparam name="form.fback" default="">
<cfparam name="form.ask" default="">
<cfparam name="form.advise_ident" default="">
<cfparam name="form.staff" default="">
<cfparam name="form.campus" default="">
<cfparam name="selcollab3.intab" default="">
<cfparam name="form.option1" default="">
<cfparam name="form.option2" default="">
<cfparam name="form.option3" default="">
<cfparam name="form.option4" default="">
<cfparam name="form.option5" default="">
<cfparam name="form.option6" default="">
<cfparam name="form.option7" default="">
<cfparam name="form.option8" default="">
<cfparam name="form.opntxt" default=""><cfparam name="form.opntxt" default="">
<cfparam name="form.dispstrat1" default="">
<cfparam name="form.dispstrat2" default="">
<cfparam name="form.dispstrat3" default="">
<cfparam name="form.dispstrat4" default="">
<cfparam name="form.dispstrat5" default="">
<cfparam name="form.dispstrattxt" default="">
<cfparam name="form.dt" default="">
<cfparam name="form.hud_notes" default="">
<cfparam name="form.summary" default="">
<cfparam name="form.barriers" default="">
<cfparam name="form.steps" default="">
<cfparam name="option3_txt" default="">
<cfparam name="form.specSuperActTxt" default="">
<cfparam name="form.schainname" default="">
<cfparam name="form.poa" default="">
<cfparam name="form.poldesc" default="">
<cfparam name="form.numstores" default="">
<cfparam name="form.boolotherstates" default="">
<cfparam name="form.cntcagree3" default="">
<!--- <cfparam name="form.SPECSFODTXT" default=""> --->
<cfparam name="form.lbody2" default="">
<cfparam name="form.lbody3" default="">
<cfparam name="form.jurnum" default="">
<cfparam name="form.policylink" default="">
<cfparam name="form.policydesc" default="">
<cfparam name="form.jurname2" default="">
<cfparam name="form.jurname3" default="">
<cfparam name="form.boolpassed2" default="">
<!--- <cfparam name="form.SPECSFODTXT2" default=""> --->
<cfparam name="form.sfpol1" default="">
<cfparam name="form.sfpol2" default="">
<cfparam name="form.sfpol3" default="">
<cfparam name="form.sfpol4" default="">
<cfparam name="form.sfpol5" default="">
<cfparam name="form.SFPNMUNIDESC" default="">
<cfparam name="form.CNTRCAGREESFPNMUNI" default="">
<cfparam name="form.CNTRCAGREE" default="">
<cfparam name="form.CNTRCAGREE2" default="">
<cfparam name="form.sford1" default="">
<cfparam name="form.sford2" default="">
<cfparam name="form.sford3" default="">
<cfparam name="form.sford4" default="">
<cfparam name="form.sford5" default="">
<cfparam name="form.CNTRCAGREE3" default="">
<cfparam name="form.specSuperActTxtdisplaycount" default="">
<cfparam name="form.specLawTxtdisplaycount" default="">
<cfparam name="form.specSFODTxtdisplaycount" default="">
<cfparam name="form.medout" default="">
<cfparam name="form.polprohib1" default="">
<cfparam name="form.polprohib2" default="">
<cfparam name="form.polprohib3" default="">
<cfparam name="form.addpos6" default="">
<cfparam name="form.polprohibtxt" default="">
   <cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="wrk">
select * from wrkplan
where
	userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> and year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> and initnum = <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5"></cfquery>
<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="getobj">
	select
o.objective,
o.id as objnum,prognum,id,
initiative,cc,aa,cp,yp
from objectives as o
where
o.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> and o.id = <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
</cfquery>

<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="getverk">
	select *
from wrkplan w
where
w.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> and initnum = <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5"> and userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
</cfquery>
<cfif isdefined("del_box8")>
<cfloop index="x" list="#del_box8#">
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="del">
	delete from monthly_initsum
	where
	seq = <cfqueryparam value="#x#" cfsqltype="CF_SQL_INTEGER"> and mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER"> and year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	</cfquery>
</cfloop>
<cfoutput>
<cflocation url="month.cfm##pro" addtoken="no"></cfoutput>
</cfif>
	<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="countyheadache">
select catchment
from contact
where userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
</cfquery>
<cfif #session.modality# is 5>
<cfif #session.objval# is '2E'>
<cfset targs = '23,53,33,63,31,61,26,56,39,69'>
<cfset chg = 'Policy'>
<cfset rez = 0>
<cfset pol = 2>
<cfset option1_value =  1>
<cfset option1_txt = "Prohibit smoking near entryways of facilities/buildings">
<cfset option2_value =  2>
<cfset option2_txt = "Prohibit smoking at events">
<cfset option3_value =  3>
<cfset option3_txt = "Prohibit smoking at parks and/or venues">
</cfif>
<cfif #session.objval# is '4F'>
<cfset targs = '27,57'>
<cfset chg = 'Policy'>
<cfoutput>
	select so1
from smartoutcomes
where
year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> and initnum = <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5"> and userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> and Sonum = <cfif session.modality EQ 2 and session.fy GT 2010>'2'<cfelse>'1b'</cfif>
</cfoutput>
<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="so1">
	select so1
from smartoutcomes
where
year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> and initnum = <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5"> and userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> and Sonum = <cfif session.modality EQ 2 and session.fy GT 2010>'2'<cfelse>'1b'</cfif>
</cfquery>
<cfset rez = 0>
<cfset pol = #so1.so1#>
<cfset option1_value =  1>
<cfset option1_txt = "Prohibit smoking in all units">
<cfif #session.modality# is 5 and #session.fy# is 2011>
<cfset option2_txt = "Prohibit smoking in indoor common areas">
<cfset option2_value =  2>
<cfset option3_txt = "Prohibit smoking in outdoor common areas">
<cfset option3_value =  3>
<cfset option4_txt = "Fewer than 10 units">
<cfset option4_value =  4>
<cfset option5_txt = "11-25 units">
<cfset option5_value =  5>
<cfset option6_txt = "26-50 units">
<cfset option6_value =  6>
<cfset option7_txt = "More than 50 units">
<cfset option7_value =  7>
<cfelseif session.modality EQ 2 and session.fy GT 2011>
<cfset option2_txt = "Prohibit smoking in indoor common areas">
<cfset option2_value =  2>
<cfset option3_txt = "Prohibit smoking in outdoor common areas">
<cfset option3_value =  3>
<cfif session.fy GT 2014>
<cfset option4_txt = "Require landlords/building owners to fully disclose smoking policies">
<cfset option4_value =  4>
</cfif>
</cfif>
</cfif>
<cfif #session.objval# is '2D'>
<cfset targs = '23,53'>
<cfset chg = 'Policy'>
<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="so1">
	select <cfif session.fy GT 2010 and session.modality EQ 5>so2<cfelse>so1</cfif> as so1
from smartoutcomes
where
year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> and initnum = <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5"> and userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> and Sonum = '1'
</cfquery>
<cfset rez = 0>
<cfset pol = #so1.so1#>
<cfset option1_value =  1>
<cfset option1_txt = "Ban sale of tobacco products">
</cfif>
<cfif #session.objval# is '2M'>
<cfset targs = '23,53,28,58,29,59,10,40,30,60'>
<cfset chg = 'Policy'>
<cfset permisss = 0>
<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="so4">
	select isnull(so1,0) as so1
from smartoutcomes
where
year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> and initnum = <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5"> and userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> and Sonum = '4a'
</cfquery>
<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="so5">
	select isnull(so1,0) as so1
from smartoutcomes
where
year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> and initnum = <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5"> and userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> and Sonum = '5a'
</cfquery>
<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="so6">
	select isnull(so1,0) as so1
from smartoutcomes
where
year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> and initnum = <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5"> and userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> and Sonum = '6a'
</cfquery>
<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="so7">
	select isnull(so1,0) as so1
from smartoutcomes
where
year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> and initnum = <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5"> and userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> and Sonum = '7a'
</cfquery>
<cfset rez = 0>
<cfif #so4.so1# is '' and #so5.so1# is '' and #so6.so1# is '' and #so7.so1# is ''>
<cfset pol = 0>
<cfelse>
<cfset pol = 3 + #so4.so1# + #so5.so1# + #so6.so1# + #so7.so1#></cfif>
<cfset option1_value =  1>
<cfset option1_txt = "Prohibit distribution of free tobacco products">
<cfset option2_value =  2>
<cfset option2_txt = "Prohibit tobacco industry sponsorship">
<cfset option3_value =  3>
<cfset option3_txt = "Prohibit tobacco industry sponsorship of research">
</cfif>
</cfif>
<cfif #session.modality# is 2>
<cfif #session.objval# is '2D'>
<cfset targs = '16,17,46,47'>
<cfset chg = 'Policy'>
<cfset rez = 0>
<cfset pol = 2>
<cfset option1_value =  1>
<cfset option1_txt = "Ban sale of tobacco products">
<cfset option2_value =  2>
<cfset option2_txt = "Eliminate tobacco ads">
<cfset option3_value =  3>
<cfset option3_txt = "Reduce visibility of tobacco ads">
<cfset option4_value =  4>
<cfset option4_txt = "Reduce visibility of tobacco products">
</cfif>
<cfif #session.objval# is '4F'>
<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="so1">
	select so1
from smartoutcomes
where
year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> and initnum = <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5"> and userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> and Sonum =<cfif session.modality EQ 2 and session.fy GT 2010>'2'<cfelse>'1'</cfif>
</cfquery>
<cfset targs = '27,57'>
<cfset chg = 'Policy'>
<cfset rez = 0>
<cfset pol = #so1.so1#>
<cfset option1_value =  1>
<cfset option1_txt = "Prohibit smoking in all units">
<cfif #session.modality# is 2 and #session.fy# is 2011>
<cfset option2_txt = "Prohibit smoking in indoor common areas">
<cfset option2_value =  2>
<cfset option3_txt = "Prohibit smoking in outdoor common areas">
<cfset option3_value =  3>
<cfset option4_txt = "Fewer than 10 units">
<cfset option4_value =  4>
<cfset option5_txt = "11-25 units">
<cfset option5_value =  5>
<cfset option6_txt = "26-50 units">
<cfset option6_value =  6>
<cfset option7_txt = "More than 50 units">
<cfset option7_value =  7>
<cfelseif session.fy GT 2011 and session.modality EQ 2>
<cfset option2_txt = "Prohibit smoking in indoor common areas">
<cfset option2_value =  2>
<cfset option3_txt = "Prohibit smoking in outdoor common areas">
<cfset option3_value =  3>
<cfif session.fy GT 2014>
<cfset option4_txt = "Require landlords/building owners to fully disclose smoking policies">
<cfset option4_value =  4>
</cfif>
</cfif>
<!--- <cfset option2_value =  2>
<cfset option2_txt = "Prohibit smoking is some units">
<cfset option3_value =  3>
<cfset option3_txt = "Prohibit smoking in other places"> --->
</cfif>
<cfif #session.objval# is '2E'>
<cfset targs = '33,63,25,61,26,56,11,41,39,69'>
<cfif isdefined("targ") and #targ# is 11>
<cfset chg = 'Ordinance'>
<cfelse>
<cfset chg = 'Policy'>
</cfif>
<cfset rez = 0>
<cfset cntycnt = "#listlen(countyheadache.catchment)#">
<cfset pol = 2*#cntycnt#>
<cfset option1_value =  1>
<cfset option1_txt = "Prohibit tobacco use at outdoor areas">
</cfif>
</cfif>
<cfif #session.modality# is 3>
<cfset pol = 2>
<cfset rez = 2>
<cfif #session.objval# is '2L'>
<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="so1">
	select so1
from smartoutcomes
where
year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> and initnum = <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5"> and userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> and Sonum = '1a'
</cfquery>
<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="so2">
	select so1
from smartoutcomes
where
year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> and initnum = <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5"> and userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> and Sonum = '2a'
</cfquery>
<cfset rez = #so1.so1#>
<cfset pol = 0>
<cfset chg = ''>
<cfset targs = 'all'>
<cfset permisss =  1>
<cfset opntxt = 1>
</cfif>
<cfif #session.objval# is '2D'>
<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="so1">
	select so1
from smartoutcomes
where
year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> and initnum = <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5"> and userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> and Sonum = '1a'
</cfquery>
<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="so2">
	select so1
from smartoutcomes
where
year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> and initnum = <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5"> and userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> and Sonum = '2a'
</cfquery>
<cfset rez = #so1.so1#>
<cfset pol = 0>
<cfset targs = '10,11,40,41'>
<cfset chg = 'Ordinance'>
<cfset opntxt = 1>
</cfif>
<cfif #session.objval# is '3G'>
<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="so1">
	select so1
from smartoutcomes
where
year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> and initnum = <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5"> and userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> and Sonum = '1a'
</cfquery>
<cfset pol = 0>
<cfset rez = #so1.so1#>
<cfset targs = '10,40,18,42,11,41,12,42'>
<cfset chg = 'Resolution'>
<cfset opntxt = 1>
</cfif>
<cfif #session.objval# is '2E'>
<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="so1">
	select isnull(so1,0) as so1
from smartoutcomes
where
year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> and initnum = <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5"> and userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> and Sonum = '1a'
</cfquery>
<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="so2">
	select isnull(so1,0) as so1
from smartoutcomes
where
year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> and initnum = <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5"> and userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> and Sonum = '2a'
</cfquery>
<cfset rez = 0>
<cfif isdefined("so1.sol") and isdefined("so2.so1")>
<cfset pol = #so1.so1# + #so2.so1#></cfif>
<cfset targs = '33,63,25,55,26,56,11,41,39,69'>
<cfif isdefined("targ") and #targ# is 11>
<cfset chg = 'Ordinance'>
<cfelse>
<cfset chg = 'Policy'>
</cfif>
<cfset option1_value =  1>
<cfset option1_txt = "Prohibit tobacco use at outdoor areas">
</cfif>
</cfif>
<cfif isdefined("targs")>
<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="gettarg">
	select *
from target_org
where
year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> and initnum = <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
<cfif #targs# is not 'all'>and targnum in (#targs#)</cfif> and userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
order by name
</cfquery>
</cfif>
<cfset session.initiative = '#getobj.initiative#'>
<cfset session.prognum = '#getobj.prognum#'>
<cfset session.id = '#getobj.id#'>
<cfset session.objnum = '#getobj.objnum#'>
<cfparam name="form.dofunction" default="">
<cfparam name="form.massmail" default="">
<cfif isdefined("del_box1")>
<cfloop index="x" list="#del_box1#">
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="del">
	delete from monthly_org
	where
	org = <cfqueryparam value="#x#" cfsqltype="CF_SQL_INTEGER"> and year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> and initnum = <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5"> and userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> and mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER"> and stratnum = 2
	</cfquery>
</cfloop>
</cfif>
<cfif isdefined("del_box9")>
<cfloop index="x" list="#del_box9#">
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="del">
	delete from monthly_org
	where
	monthlyorgid = <cfqueryparam value="#x#" cfsqltype="CF_SQL_INTEGER"> and mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER"> and year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	</cfquery>
</cfloop>
</cfif>
<cfif isdefined("del2a")>
<cfloop index="x" list="#del2a#">
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="del">
	delete from monthly_commmob
	where
	monthlycommmobid = <cfqueryparam value="#x#" cfsqltype="CF_SQL_INTEGER"> and mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
	</cfquery>
</cfloop>
<cfoutput>
<cflocation url="month.cfm##commmob" addtoken="no"></cfoutput>
</cfif>
<cfif isdefined("del_box3")>
<cfloop index="x" list="#del_box3#">
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="del">
	delete from monthly_comm
	where
	monthlycommid = <cfqueryparam value="#x#" cfsqltype="CF_SQL_INTEGER"> and mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
	</cfquery>
</cfloop>
<cfoutput>
<cflocation url="month.cfm##comm" addtoken="no"></cfoutput>
</cfif>
<cfif isdefined("del_box4")>
<cfloop index="x" list="#del_box4#">
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="del">
	delete from monthly_media
	where
	monthlymediaid = <cfqueryparam value="#x#" cfsqltype="CF_SQL_INTEGER"> and mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
	</cfquery>
</cfloop>
<cfoutput>
<cflocation url="month.cfm##pm" addtoken="no"></cfoutput>
</cfif>
<cfif isdefined("del_box5")>
<cfloop index="x" list="#del_box5#">
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="del">
	delete from monthly_targethcpo
	where
	seq = <cfqueryparam value="#x#" cfsqltype="CF_SQL_INTEGER"> and mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
	</cfquery>
</cfloop>
</cfif>
<cfif isdefined("del_box6")>
<cfloop index="x" list="#del_box6#">
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="del">
	delete from monthly_targethcpo
	where
	seq = <cfqueryparam value="#x#" cfsqltype="CF_SQL_INTEGER"> and mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER"> and year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	</cfquery>
</cfloop>
<cfoutput>
<cflocation url="month.cfm##thcpo" addtoken="no"></cfoutput></cfif>
<cfif isdefined("del_box10")>
<cfloop index="x" list="#del_box10#">
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="del">
	delete from monthly_cc
	where
	seq = <cfqueryparam value="#x#" cfsqltype="CF_SQL_INTEGER"> and mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER"> and year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	</cfquery>
</cfloop>
<cfoutput>
<cflocation url="month.cfm##ppc" addtoken="no"></cfoutput>
</cfif>
<cfif isdefined("del_box7")>
<cfloop index="x" list="#del_box7#">
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="del">
	delete from monthly_cc
	where
	seq = <cfqueryparam value="#x#" cfsqltype="CF_SQL_INTEGER"> and fullz = 1 and mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER"> and year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	</cfquery>
</cfloop>
<cfoutput>
<cflocation url="month.cfm##outc" addtoken="no"></cfoutput>
</cfif>
<cfif isdefined("del_box16")>
<cfloop index="x" list="#del_box16#">
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="del">
	delete from monthly_pos6
	where
	monthlyid = <cfqueryparam value="#x#" cfsqltype="CF_SQL_INTEGER">
	</cfquery>
</cfloop>
<cfoutput>
<cflocation url="month.cfm?sfm=1##pos" addtoken="no"></cfoutput>
</cfif>
<cfif isdefined("del_box11")>
<cfloop index="x" list="#del_box11#">
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="del">
	delete from monthly_pos
	where
	monthlyid = <cfqueryparam value="#x#" cfsqltype="CF_SQL_INTEGER">
	</cfquery>
</cfloop>
<cfoutput>
<cflocation url="month.cfm##pos" addtoken="no"></cfoutput>
</cfif>
<cfif isdefined("del_box12")>
<cfloop index="x" list="#del_box12#">
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="del">
	delete from monthly_pos2
	where
	monthlyid = <cfqueryparam value="#x#" cfsqltype="CF_SQL_INTEGER">
	</cfquery>
</cfloop>
<cfoutput>
<cflocation url="month.cfm##pos" addtoken="no"></cfoutput>
</cfif>
<cfif isdefined("del_box13")>
<cfloop index="x" list="#del_box13#">
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="del">
	delete from monthly_pos3
	where
	monthlyid = <cfqueryparam value="#x#" cfsqltype="CF_SQL_INTEGER">
	</cfquery>
</cfloop>
<cfoutput>
<cflocation url="month.cfm##pos" addtoken="no"></cfoutput>
</cfif>
<cfif isdefined("del_box14")>
<cfloop index="x" list="#del_box14#">
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="del">
	delete from monthly_pos4
	where
	monthlyid = <cfqueryparam value="#x#" cfsqltype="CF_SQL_INTEGER">
	</cfquery>
</cfloop>
<cfoutput>
<cflocation url="month.cfm##pos" addtoken="no"></cfoutput>
</cfif>
<cfif isdefined("del_box15")>
<cfloop index="x" list="#del_box15#">
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="del">
	delete from hud
	where
	seq = <cfqueryparam value="#x#" cfsqltype="CF_SQL_INTEGER">
	</cfquery>
</cfloop>
<cfoutput>
<cflocation url="month.cfm##hud" addtoken="no"></cfoutput>
</cfif>
<cfif isDefined("form.add_HUD") and isdefined("form.HUD_target") and #form.hud_target# is not ''>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="checkHUD">
select *
from HUD
where
userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
and year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
and mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
and HUD_target=<cfqueryparam value="#form.HUD_target#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">
</cfquery>
<cfif checkHUD.recordcount EQ 1>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="updHUD">
update HUD
set HUD_target = <cfqueryparam  value="#form.HUD_target#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">,
HUD_notes = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" maxlength="1000" value="#form.HUD_notes#">,
units = <cfqueryparam  value="#form.units#" cfsqltype="CF_SQL_integer">,
dt = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" maxlength="20" value="#form.dt#">
where
userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
and year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
and mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
and HUD_target=<cfqueryparam value="#form.HUD_target#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">
</cfquery>
<cflocation url="month.cfm##hud" addtoken="no">
<cfelse>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="insHSC">
insert into HUD
(userid, year2, mon, HUD_target, HUD_notes,units,dt)
values
(
<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">,
<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
<cfqueryparam  cfsqltype="CF_SQL_VARCHAR" maxlength="10" value="#form.HUD_target#">,
<cfqueryparam value="#form.HUD_notes#" cfsqltype="CF_SQL_VARCHAR" maxlength="1000">,
<cfqueryparam  cfsqltype="CF_SQL_INTEGER" maxlength="5" value="#form.units#">,
<cfqueryparam value="#form.dt#" cfsqltype="CF_SQL_VARCHAR" maxlength="20">
)
</cfquery></cfif>
</cfif>
<cfif isDefined("form.HSC_DESC")>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="checkHSC">
select descr
from HSC_Monthly
where
userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
and year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
and mon = <cfqueryparam value="#session.mon#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
and obj=<cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
</cfquery>
<cfif checkHSC.recordcount EQ 1>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="updHSC">
update HSC_Monthly
set descr = <cfqueryparam cfsqltype="CF_SQL_LONGVARCHAR" value="#form.HSC_DESC#">
where
userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
and year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
and mon = <cfqueryparam value="#session.mon#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
and obj=<cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
</cfquery>
<cfelse>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="insHSC">
insert into HSC_Monthly
(userid, year2, mon, obj, descr)
values
(
<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">,
<cfqueryparam value="#session.mon#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
<cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">,
<cfqueryparam cfsqltype="CF_SQL_LONGVARCHAR" value="#form.HSC_DESC#">
)
</cfquery></cfif>
</cfif>
<cfif (isdefined("addtargethcpo") and isdefined("form.targ") and #form.targ# is not '')>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QSelTG">
	select *
	from monthly_targethcpo
	where userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
	and seq = <cfqueryparam value="#form.targ#" cfsqltype="CF_SQL_INTEGER">
	</cfquery>
	<cfif QSelTG.recordcount is 0>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QInsTG">
insert into monthly_targethcpo
(userid, year2,  mon, seq, massmail, adcomm1, adcomm2, adcomm3, maintind, train, attend,techass1, techass2, techass3, award, nrt, pipA, pipB, pipC, notes)
values
(<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
,<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
,<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
,<cfqueryparam value="#form.targ#" cfsqltype="CF_SQL_INTEGER">
,<cfqueryparam value="#form.massmail#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.massmail))#">
,<cfqueryparam  cfsqltype="cf_sql_bit" value="#form.adcomm1#" null="#YesNoFormat(not Len(form.adcomm1))#">
,<cfqueryparam  cfsqltype="cf_sql_bit" value="#form.adcomm2#" null="#YesNoFormat(not Len(form.adcomm2))#">
,<cfqueryparam  cfsqltype="cf_sql_bit" value="#form.adcomm3#" null="#YesNoFormat(not Len(form.adcomm3))#">
,<cfqueryparam value="#form.maintind#" cfsqltype="CF_SQL_VARCHAR" maxlength="3000" null="#YesNoFormat(not Len(form.maintind))#">
,<cfqueryparam value="#form.train#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.train))#">
,<cfqueryparam value="#form.attend2#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.attend2))#">
,<cfqueryparam  cfsqltype="cf_sql_bit" value="#form.techass1#" null="#YesNoFormat(not Len(form.techass1))#">
,<cfqueryparam  cfsqltype="cf_sql_bit" value="#form.techass2#" null="#YesNoFormat(not Len(form.techass2))#">
,<cfqueryparam  cfsqltype="cf_sql_bit" value="#form.techass3#" null="#YesNoFormat(not Len(form.techass3))#">
,<cfqueryparam value="#form.award#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.award))#">
,<cfqueryparam value="#form.nrt#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.nrt))#">
,<cfqueryparam value="#form.pipa#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.pipa))#">
,<cfqueryparam value="#form.pipb#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.pipb))#">
,<cfqueryparam value="#form.pipc#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.pipc))#">
,<cfqueryparam value="#notes#" cfsqltype="CF_SQL_VARCHAR" maxlength="3000" null="#YesNoFormat(not Len(notes))#">
)</cfquery>
<cfelse>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QUpdTG">
update monthly_targethcpo
set
massmail = <cfqueryparam value="#form.massmail#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.massmail))#">
,adcomm1 = <cfqueryparam  cfsqltype="cf_sql_bit" value="#form.adcomm1#" null="#YesNoFormat(not Len(form.adcomm1))#">
,adcomm2 = <cfqueryparam  cfsqltype="cf_sql_bit" value="#form.adcomm2#" null="#YesNoFormat(not Len(form.adcomm2))#">
,adcomm3 = <cfqueryparam  cfsqltype="cf_sql_bit" value="#form.adcomm3#" null="#YesNoFormat(not Len(form.adcomm3))#">
,maintind = <cfqueryparam value="#form.maintind#" cfsqltype="CF_SQL_VARCHAR" maxlength="3000" null="#YesNoFormat(not Len(form.maintind))#">
,train = <cfqueryparam value="#form.train#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.train))#">
,attend = <cfqueryparam value="#form.attend2#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.attend2))#">
,techass1 = <cfqueryparam  cfsqltype="cf_sql_bit" value="#form.techass1#" null="#YesNoFormat(not Len(form.techass1))#">
,techass2 = <cfqueryparam  cfsqltype="cf_sql_bit" value="#form.techass2#" null="#YesNoFormat(not Len(form.techass2))#">
,techass3 = <cfqueryparam  cfsqltype="cf_sql_bit" value="#form.techass3#" null="#YesNoFormat(not Len(form.techass3))#">
,award = <cfqueryparam value="#form.award#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.award))#">
,nrt = <cfqueryparam value="#form.nrt#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.nrt))#">
,pipa = <cfqueryparam value="#form.pipa#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.pipa))#">
,pipb = <cfqueryparam value="#form.pipb#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.pipb))#">
,pipc = <cfqueryparam value="#form.pipc#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.pipc))#">
,notes = <cfqueryparam value="#notes#" cfsqltype="CF_SQL_VARCHAR" maxlength="3000"null="#YesNoFormat(not Len(notes))#">
where seq = <cfqueryparam value="#form.targ#" cfsqltype="CF_SQL_INTEGER">
and mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
and year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
</cfquery>
</cfif>
<cfset form.adcomm3 = ''>
<cfset form.adcomm2 = ''>
<cfset form.maintind = ''>
<cfset form.adcomm1 = ''>
<cfset form.train = ''>
<cfset form.attend = ''>
<cfset form.attend2 = ''>
<cfset form.techass1 = ''>
<cfset form.techass2 = ''>
<cfset form.techass3 = ''>
<cfset form.award = ''>
<cfset form.nrt = ''>
<cfset form.pipa = ''>
<cfset form.pipb = ''>
<cfset form.pipc = ''>
<cfset form.notes = ''>
<cfset form.massmail = ''>
<cfif isdefined("form.targ") and #form.targ# is not '' and (not isdefined("form.targ2") or #form.targ2# is '')>
<cfif isdefined("form.addtargethcpo")>
<cfset session.targ = ''>
<cfelse>
<cfset session.targ = #form.targ#>
</cfif>
<cflocation url="month.cfm##thcpo" addtoken="no">
</cfif>
</cfif>
<cfif (form.dofunction is 'addOK' or isdefined("addoutrep")) and  isDefined("addoutrep")>
<cfif isdefined("form.targ3") and #form.targ3# is not ''>
<cfset form.targ2 = #form.targ3#>
</cfif>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QSelFG">
	select *
	from monthly_cc
	where userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
	and seq = <cfqueryparam value="#form.targ2#" cfsqltype="CF_SQL_INTEGER">
	and fullz = 1
	</cfquery>
	<cfif QSelFG.recordcount is 0>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QInsTG">
insert into monthly_cc
(userid, year2,  mon, seq, fullz, sampnum, outcome, patscreen, patident, userquit, userquit_na,userinterv)
values
(<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
,<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
,<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
,<cfqueryparam value="#form.targ2#" cfsqltype="CF_SQL_INTEGER">
,'1'
,<cfqueryparam value="#form.sampnum#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.sampnum))#">
,<cfqueryparam value="#form.outc#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.outc))#">
,<cfqueryparam value="#form.patscreen#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.patscreen))#">
,<cfqueryparam value="#form.patident#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.patident))#">
,<cfqueryparam value="#form.userquit#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.userquit))#">
,<cfqueryparam value="#form.userquit_na#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.userquit_na))#">
,<cfqueryparam value="#form.userinterv#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.userinterv))#">)
</cfquery>
<cfelse>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QUpdTG">
update monthly_cc
set
fullz = '1',
sampnum = <cfqueryparam value="#form.sampnum#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.sampnum))#">,
outcome = <cfqueryparam value="#form.outc#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.outc))#">,
patscreen = <cfqueryparam value="#form.patscreen#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.patscreen))#">,
patident = <cfqueryparam value="#form.patident#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.patident))#">,
userquit = <cfqueryparam value="#form.userquit#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.userquit))#">,
userquit_na = <cfqueryparam value="#form.userquit_na#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.userquit_na))#">,
userinterv = <cfqueryparam value="#form.userinterv#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.userinterv))#">
where seq = <cfqueryparam value="#form.targ3#" cfsqltype="CF_SQL_INTEGER">
and mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
 and year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	</cfquery>
</cfif>
<cfset form.targ3 = ''>
<cfset form.sampnum = ''>
<cfset form.patscreen = ''>
<cfset form.patident = ''>
<cfset form.userquit = ''>
<cfset form.userquit_na = ''>
<cfset form.user_interv = ''>
<cflocation url="month.cfm##outc" addtoken="no">
<cfelseif isDefined("form.targ3")>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QSelFGa">
	select *
	from monthly_cc
	where userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
	and seq = <cfqueryparam value="#form.targ3#" cfsqltype="CF_SQL_INTEGER">
	</cfquery>
<cfif QSelFGa.recordcount NEQ 0>
<cfset form.targ3 = QSelFGa.seq>
<cfset form.sampnum = QSelFGa.sampnum>
<cfset form.patscreen = QSelFGa.patscreen>
<cfset form.patident = QSelFGa.patident>
<cfset form.userquit = QSelFGa.userquit>
<cfset form.userquit_na = QSelFGa.userquit_na>
<cfset form.userinterv = QSelFGa.userinterv>
	</cfif>
</cfif>
<cfif isdefined("form.dofunction") and form.dofunction is not '' <!--- or isdefined("form.advmassmail") ---> or isdefined("form.del_box2") or (isDefined("form.objval") and (form.objval EQ '2d' or form.objval EQ '2e'))>
<cfif session.objval EQ '' and isDefined ("url.objval")><cfset session.objval = url.objval></cfif>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="mon">
select
	*
	from monthly
	where
	userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and mon=<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
	and initnum=<cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
</cfquery>

<cfif isDefined("mon.boolsfop")><cfset attributes.boolsfop = #mon.boolsfop#></cfif>
<cfif isDefined("form.boolsfop") and #form.boolsfop# is not ''><cfset attributes.boolsfop = #form.boolsfop#></cfif>
<cfif isDefined("mon.boolsfop2")><cfset attributes.boolsfop2 = #mon.boolsfop2#></cfif>
<cfif isDefined("form.boolsfop2") and #form.boolsfop2# is not ''><cfset attributes.boolsfop2 = #form.boolsfop2#></cfif>
<cfif isDefined("mon.specSFODTxt") and #mon.specSFODTxt# is not ''><cfset attributes.specSFODTxt = #mon.specSFODTxt#></cfif>
<cfif isDefined("form.specSFODTxt") and #form.specSFODTxt# is not ''><cfset attributes.specSFODTxt = #form.specSFODTxt#></cfif>
<cfif isDefined("mon.specSFODTxt2") and #mon.specSFODTxt2# is not ''><cfset attributes.specSFODTxt2 = #mon.specSFODTxt2#></cfif>
<cfif isDefined("form.specSFODTxt2") and #form.specSFODTxt2# is not ''><cfset attributes.specSFODTxt2 = #form.specSFODTxt2#></cfif>
<cfif mon.recordcount EQ 0>
<cfset entdt = #createodbcdate(now())#>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QInsMO">
insert into monthly
(userid,
entdt,year2, mon, initnum, stratnum,advmassmail,govtmassmail,ccmassmail, editor,prssrlse,calls,prsspk,ltred,nwsstry,nwsltr,editorial,other,summary,barriers,steps,boollaw,speclawtxt,boolSuperPol,specsuperacttxt,boolSFOP,boolSFOP2,specSFODTxt,specSFODTxt2, sfm,dispstrat1,dispstrat2,dispstrat3,dispstrat4,dispstrat5,dispstrattxt,youTube)
values
(<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
,<cfqueryparam value="#entdt#" cfsqltype="CF_SQL_DATE">
,<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
,<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
,<cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
,<cfqueryparam value="#form.strat#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.strat))#">
,<cfqueryparam value="#form.advmassmail#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.advmassmail))#">
,<cfqueryparam value="#form.govtmassmail#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.govtmassmail))#">
,<cfqueryparam value="#form.ccmassmail#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.ccmassmail))#">
,<cfqueryparam value="#form.editor#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.editor))#">
,<cfqueryparam value="#form.prssrlse#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.prssrlse))#">
,<cfqueryparam value="#form.calls#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.calls))#">
,<cfqueryparam value="#form.prsspk#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.prsspk))#">
,<cfqueryparam value="#form.ltred#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.ltred))#">
,<cfqueryparam value="#form.nwsstry#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.nwsstry))#">
,<cfqueryparam value="#form.nwsltr#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.nwsltr))#">
,<cfqueryparam value="#form.editorial#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.editorial))#">
,<cfqueryparam value="#form.other#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.other))#">
,<cfqueryparam value="#form.summary#" cfsqltype="CF_SQL_VARCHAR" maxlength="2050" null="#YesNoFormat(not Len(form.summary))#">
,<cfqueryparam value="#form.barriers#" cfsqltype="CF_SQL_VARCHAR" maxlength="2050" null="#YesNoFormat(not Len(form.barriers))#">
,<cfqueryparam value="#form.steps#" cfsqltype="CF_SQL_VARCHAR" maxlength="2050" null="#YesNoFormat(not Len(form.steps))#">
,<cfqueryparam value="#form.boollaw#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.boollaw))#">
,<cfqueryparam value="#form.speclawtxt#" cfsqltype="CF_SQL_VARCHAR" maxlength="1000" null="#YesNoFormat(not Len(form.speclawtxt))#">
,<cfqueryparam value="#form.boolsuperpol#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.boolsuperpol))#">
,<cfqueryparam value="#form.specsuperacttxt#" cfsqltype="CF_SQL_VARCHAR" maxlength="1000" null="#YesNoFormat(not Len(form.specsuperacttxt))#">
,<cfqueryparam value="#attributes.boolSFOP#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(attributes.boolsfop))#">
,<cfqueryparam value="#attributes.boolSFOP2#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(attributes.boolsfop2))#">
,<cfqueryparam value="#attributes.specSFODTxt#" cfsqltype="CF_SQL_VARCHAR" maxlength="1000" null="#YesNoFormat(not Len(attributes.specSFODTxt))#">
,<cfqueryparam value="#attributes.specSFODTxt2#" cfsqltype="CF_SQL_VARCHAR" maxlength="1000" null="#YesNoFormat(not Len(attributes.specSFODTxt2))#">
,<cfqueryparam value="#form.sfm#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.sfm))#">
,<cfqueryparam value="#form.dispstrat1#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.dispstrat1))#">
,<cfqueryparam value="#form.dispstrat2#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.dispstrat2))#">
,<cfqueryparam value="#form.dispstrat3#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.dispstrat3))#">
,<cfqueryparam value="#form.dispstrat4#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.dispstrat4))#">
,<cfqueryparam value="#form.dispstrat5#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.dispstrat5))#">
,<cfqueryparam value="#form.dispstrattxt#" cfsqltype="CF_SQL_VARCHAR" maxlength="5000" null="#YesNoFormat(not Len(form.dispstrattxt))#">
,<cfqueryparam value="#form.youtube#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.youtube))#">)
	</cfquery>
<cfelse>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QInsWG">
		update monthly set
	userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	,advmassmail = <cfqueryparam value="#form.advmassmail#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.advmassmail))#">
	,govtmassmail = <cfqueryparam value="#form.govtmassmail#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.govtmassmail))#">
	,ccmassmail = <cfqueryparam value="#form.ccmassmail#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.ccmassmail))#">
	,editor = <cfqueryparam value="#form.editor#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.editor))#">
	,prssrlse = <cfqueryparam value="#form.prssrlse#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.prssrlse))#">
	,calls = <cfqueryparam value="#form.calls#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.calls))#">
	,prsspk = <cfqueryparam value="#form.prsspk#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.prsspk))#">
	,ltred = <cfqueryparam value="#form.ltred#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.ltred))#">
	,nwsstry = <cfqueryparam value="#form.nwsstry#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.nwsstry))#">
	,nwsltr = <cfqueryparam value="#form.nwsltr#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.nwsltr))#">
	,editorial = <cfqueryparam value="#form.editorial#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.editorial))#">
	,other = <cfqueryparam value="#form.other#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.other))#">
	,barriers = <cfqueryparam value="#form.barriers#" cfsqltype="CF_SQL_VARCHAR" maxlength="2050" null="#YesNoFormat(not Len(form.barriers))#">
	,summary = <cfqueryparam value="#form.summary#" cfsqltype="CF_SQL_VARCHAR" maxlength="2050" null="#YesNoFormat(not Len(form.summary))#">
	,steps = <cfqueryparam value="#form.steps#" cfsqltype="CF_SQL_VARCHAR" maxlength="2050" null="#YesNoFormat(not Len(form.steps))#">
	,boollaw = <cfqueryparam value="#form.boollaw#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.boollaw))#">
	,speclawtxt = <cfqueryparam value="#form.speclawtxt#" cfsqltype="CF_SQL_VARCHAR" maxlength="1000" null="#YesNoFormat(not Len(form.speclawtxt))#">
	,boolSuperPol = <cfqueryparam value="#form.boolSuperPol#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.boolsuperpol))#">
	,boolSFOP = <cfqueryparam value="#attributes.boolSFOP#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(attributes.boolsfop))#">
	,boolSFOP2 = <cfqueryparam value="#attributes.boolSFOP2#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(attributes.boolsfop2))#">
	,specSFODTxt = <cfqueryparam value="#attributes.specSFODTxt#" cfsqltype="CF_SQL_VARCHAR" maxlength="1000" null="#YesNoFormat(not Len(attributes.specsfodtxt))#">
	,specSFODTxt2 = <cfqueryparam value="#attributes.specSFODTxt2#" cfsqltype="CF_SQL_VARCHAR" maxlength="1000" null="#YesNoFormat(not Len(attributes.specsfodtxt2))#">
	,specsuperacttxt = <cfqueryparam value="#form.specsuperacttxt#" cfsqltype="CF_SQL_VARCHAR" maxlength="1000" null="#YesNoFormat(not Len(form.specsuperacttxt))#">
	,sfm = <cfqueryparam value="#form.sfm#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.sfm))#">
	,dispstrat1 = <cfqueryparam value="#form.dispstrat1#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.dispstrat1))#">
	,dispstrat2 = <cfqueryparam value="#form.dispstrat2#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.dispstrat2))#">
	,dispstrat3 = <cfqueryparam value="#form.dispstrat3#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.dispstrat3))#">
	,dispstrat4 = <cfqueryparam value="#form.dispstrat4#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.dispstrat4))#">
	,dispstrat5 = <cfqueryparam value="#form.dispstrat5#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.dispstrat5))#">
	,dispstrattxt = <cfqueryparam value="#form.dispstrattxt#" cfsqltype="CF_SQL_VARCHAR" maxlength="5000" null="#YesNoFormat(not Len(form.dispstrattxt))#">
	,youTube = <cfqueryparam value="#form.youtube#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.youtube))#">
	where userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
	and initnum = <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	</cfquery>
</cfif>
</cfif>
<cfif isdefined("addemr")>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QSelPPG">
	select *
	from monthly_cc
	where userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
	and seq = <cfqueryparam value="#form.targ2#" cfsqltype="CF_SQL_INTEGER">
	and pp = 1
	</cfquery>
	<cfif QSelPPG.recordcount is 0>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QInsTG">
insert into monthly_cc
(userid, year2,  mon, seq, pp, idsys, docsys, writpol, ask, advise_ident, assess_ident, assarr_ident, advise_writpol, assess_writpol, assarr_writpol, train2, staff, fback, campus)
values
(<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">, <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">, <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">,<cfqueryparam value="#form.targ2#" cfsqltype="CF_SQL_INTEGER">, '1', <cfqueryparam value="#form.idsys#" cfsqltype="CF_SQL_INTEGER">, <cfqueryparam value="#form.docsys#" cfsqltype="CF_SQL_INTEGER">, <cfqueryparam value="#form.writpol#" cfsqltype="CF_SQL_INTEGER">, <cfqueryparam value="#form.ask#" cfsqltype="CF_SQL_INTEGER">, <cfqueryparam value="#form.advise_ident#" cfsqltype="CF_SQL_INTEGER">, <cfqueryparam value="#form.assess_ident#" cfsqltype="CF_SQL_INTEGER">, <cfqueryparam value="#form.assarr_ident#" cfsqltype="CF_SQL_INTEGER">, <cfqueryparam value="#form.advise_writpol#" cfsqltype="CF_SQL_INTEGER">, <cfqueryparam value="#form.assess_writpol#" cfsqltype="CF_SQL_INTEGER">, <cfqueryparam value="#form.assarr_writpol#" cfsqltype="CF_SQL_INTEGER">, <cfqueryparam value="#form.train2#" cfsqltype="CF_SQL_INTEGER">, <cfqueryparam value="#form.staff#" cfsqltype="CF_SQL_INTEGER">,<cfqueryparam value="#form.fback#" cfsqltype="CF_SQL_INTEGER">, <cfqueryparam value="#form.campus#" cfsqltype="CF_SQL_INTEGER">)
</cfquery>
<cfelse>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QUpdTG">
update monthly_cc
set
pp = 1,
idsys = <cfqueryparam value="#form.idsys#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.idsys))#">,
docsys = <cfqueryparam value="#form.docsys#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.docsys))#">,
writpol = <cfqueryparam value="#form.writpol#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.writpol))#">,
ask = <cfqueryparam value="#form.ask#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.ask))#">,
advise_ident = <cfqueryparam value="#form.advise_ident#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.advise_ident))#">,
assess_ident = <cfqueryparam value="#form.assess_ident#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.assess_ident))#">,
assarr_ident = <cfqueryparam value="#form.assarr_ident#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.assarr_ident))#">,
advise_writpol = <cfqueryparam value="#form.advise_writpol#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.advise_writpol))#">,
assess_writpol = <cfqueryparam value="#form.assess_writpol#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.assess_writpol))#">,
assarr_writpol = <cfqueryparam value="#form.assarr_writpol#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.assarr_writpol))#">,
train2 = <cfqueryparam value="#form.train2#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.train2))#">,
staff = <cfqueryparam value="#form.staff#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.staff))#">,
fback = <cfqueryparam value="#form.fback#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.fback))#">,
campus = <cfqueryparam value="#form.campus#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.campus))#">
where seq = <cfqueryparam value="#form.targ2#" cfsqltype="CF_SQL_INTEGER">
and mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
 and year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	</cfquery>
</cfif>
<cfset form.targ2 = ''>
<cfset selcollab3.name = ''>
<cfset form.idsys = ''>
<cfset form.docsys = ''>
<cfset form.writpol = ''>
<cfset form.ask = ''>
<cfset form.advise_ident = ''>
<cfset form.assess_ident = ''>
<cfset form.assarr_ident = ''>
<cfset form.advise_writpol = ''>
<cfset form.assess_writpol = ''>
<cfset form.assarr_writpol = ''>
<cfset form.train2 = ''>
<cfset form.staff = ''>
<cfset form.fback = ''>
<cfset form.campus = ''>
</cfif>
<cfif form.dofunction is 'addBG' or isdefined("addgovernment")>
<cfif session.fy LT 2012>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QSelBG">
	select *
	from monthly_org
	where userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
	and initnum = <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	and org = <cfqueryparam value="#form.targ2#" cfsqltype="CF_SQL_INTEGER">
	</cfquery>
	<cfif QSelBG.recordcount is 0>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QInsBG">
insert into monthly_org
(userid, year2,  mon, initnum, stratnum, org, meet, phone ,letter ,email)
values
(<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
,<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
,<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
,<cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
,<cfqueryparam value="#form.strat#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.strat))#">
,<cfqueryparam value="#form.targ2#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.targ2))#">
,<cfqueryparam value="#form.meet2#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.meet2))#">
,<cfqueryparam value="#form.phone2#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.phone2))#">
,<cfqueryparam value="#form.letter2#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.letter2))#">
,<cfqueryparam value="#form.email2#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.email2))#">)
</cfquery>
<cfelse>
</cfif>
<cfelse>
<cfif isdefined("form.nature3") and #form.nature3# is 1 and (#session.modality# is 2 or #session.modality# is 3)>
	<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="GetEmailStats">
select
c.orgname,c.partnertype, c.coordemail as partneremail,
case c.partnertype
<!--- when 2 then 'eas10@health.ny.gov'
when 3 then 'eas10@health.ny.gov' --->
when 1 then '#session.MM1#'
when 2 then '#session.MM2#'
when 6 then '#session.MM6#'
else NULL end as mmanager,
m.email as cmanager
from contact c, contact m
where m.userid=c.cmanager
and c.partnertype in (1,2,6)
and c.userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
and isNull(c.coordemail,'rti.org') not like '%rti.org'
</cfquery>
<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="targname">
	select distinct tor.targid,name,isnull(tm.org,0) as tm
from target_org tor left join monthly_org tm
on tor.targid = tm.org and tor.year2 = tm.year2
and tor.initnum = tm.initnum and tor.userid = tm.userid and tm.mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
where tor.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> and tor.initnum = <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
and targid = <cfqueryparam value="#form.targ2#" cfsqltype="CF_SQL_INTEGER">
order by name
</cfquery>
<cfmail from="NY Tobacco Control Program <NY-Tobacco-Control-Program@rti.org>"
to="#GetEmailStats.cmanager#; #GetEmailStats.mmanager#;tobacco@tobaccopolicycenter.org" bcc="dplotner@rti.org; twills@rti.org"
subject="#session.orgname# – identified support/commitment for policy" type="HTML">
#session.orgname# has identified that #targname.name# is supportive of/committed to policy change for #session.initiative# in the #session.mon# Monthly Report.
</cfmail>
</cfif>
<cfif isDefined("addgovernment") and addgovernment EQ "Update">
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QInsBG">
Update monthly_org
set org=<cfqueryparam value="#form.targ2#" cfsqltype="CF_SQL_INTEGER">,
nature1=<cfif isDefined("form.nature1")><cfqueryparam value="#form.nature1#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.nature1))#"><cfelse>null</cfif>,
nature2=<cfif isDefined("form.nature2")><cfqueryparam value="#form.nature2#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.nature2))#"><cfelse>null</cfif>,
nature3=<cfif isDefined("form.nature3")><cfqueryparam value="#form.nature3#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.nature3))#"><cfelse>null</cfif>,
interact=<cfqueryparam value="#form.interact#" cfsqltype="CF_SQL_VARCHAR" maxlength="1500">
where
monthlyorgid=<cfqueryparam value="#form.targid01#" cfsqltype="CF_SQL_INTEGER">
</cfquery>
<cfelse>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QInsBG">
insert into monthly_org
(userid, year2,  mon, initnum, stratnum, org, nature1, nature2, nature3, interact)
values
(<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">, <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">, <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">, <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">, <cfqueryparam value="#form.strat#" cfsqltype="CF_SQL_INTEGER">, <cfqueryparam value="#form.targ2#" cfsqltype="CF_SQL_INTEGER">,
<cfif isDefined("form.nature1")><cfqueryparam value="#form.nature1#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.nature1))#"><cfelse>null</cfif>,
<cfif isDefined("form.nature2")><cfqueryparam value="#form.nature2#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.nature2))#"><cfelse>null</cfif>,
<cfif isDefined("form.nature3")><cfqueryparam value="#form.nature3#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.nature3))#"><cfelse>null</cfif>,
<cfqueryparam value="#form.interact#" cfsqltype="CF_SQL_VARCHAR" maxlength="1500">)
</cfquery>
</cfif>
</cfif>
<cfoutput>
<cflocation url="month.cfm##gov" addtoken="no"></cfoutput>
</cfif>
<cfif form.dofunction is 'addIG' or isdefined("addpolicy") >
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QSelIG">
	select *
	from monthly_initsum
	where userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
	and seq = <cfqueryparam value="#form.targ999#" cfsqltype="CF_SQL_INTEGER">
	and initnum = <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	</cfquery>
<cfif QSelIG.recordcount is 0>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QInsIG">
insert into monthly_initsum
(userid, year2,  mon, initnum, seq, option1_value, option2_value, option3_value, option4_value, option5_value, option6_value, option7_value, option8_value,opentxt,permiss, number,lha,county,cntrcAgree2,policydesc)
values
(<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">,
<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">,
<cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">,
<cfqueryparam value="#form.targ999#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.targ999))#">,
<cfqueryparam value="#form.option1#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.option1))#">,
<cfqueryparam value="#form.option2#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.option2))#">,
<cfqueryparam value="#form.option3#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.option3))#">,
<cfqueryparam value="#form.option4#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.option4))#">,
<cfqueryparam value="#form.option5#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.option5))#">,
<cfqueryparam value="#form.option6#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.option6))#">,
<cfqueryparam value="#form.option7#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.option7))#">,
<cfqueryparam value="#form.option8#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.option8))#">,
<cfqueryparam value="#form.opntxt#" cfsqltype="CF_SQL_VARCHAR" maxlength="500">,
<cfqueryparam value="#form.permiss#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.permiss))#">,
<cfqueryparam value="#form.numunits#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.numunits))#">,
<cfqueryparam value="#form.lha#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.lha))#">,
<cfqueryparam value="#form.county#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
<cfqueryparam value="#form.CNTRCAGREE2#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.cntrcagree2))#">,
<cfqueryparam value="#form.policydesc#" cfsqltype="CF_SQL_VARCHAR" maxlength="1000">)

</cfquery>
<cfelse>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QInsIG">
update  monthly_initsum
set option1_value=<cfqueryparam value="#form.option1#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.option1))#">,
option2_value=<cfqueryparam value="#form.option2#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.option2))#">,
option3_value=<cfqueryparam value="#form.option3#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.option3))#">,
option4_value=<cfqueryparam value="#form.option4#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.option4))#">,
option5_value=<cfqueryparam value="#form.option5#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.option5))#">,
option6_value=<cfqueryparam value="#form.option6#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.option6))#">,
option7_value=<cfqueryparam value="#form.option7#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.option7))#">,
option8_value=<cfqueryparam value="#form.option8#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.option8))#">,
opentxt=<cfqueryparam value="#form.opntxt#" cfsqltype="CF_SQL_VARCHAR" maxlength="500">,
permiss=<cfqueryparam value="#form.permiss#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.permiss))#">,
number=<cfqueryparam value="#form.numunits#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.numunits))#">,
lha=<cfqueryparam value="#form.lha#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.lha))#">,
county=<cfqueryparam value="#form.county#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">,
cntrcAgree2=<cfqueryparam value="#form.CNTRCAGREE2#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.cntrcagree2))#">,
policydesc=<cfqueryparam value="#form.policydesc#" cfsqltype="CF_SQL_VARCHAR" maxlength="1000">
where
userid= <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
and year2=  <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
and mon= <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
and initnum=<cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
and seq=<cfqueryparam value="#form.targ999#" cfsqltype="CF_SQL_INTEGER">
</cfquery>
</cfif></cfif>
<cfif form.dofunction is 'addAG' or isdefined("addadvocating")>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QSelAG">
	select *
	from monthly_org
	where userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
	and initnum = <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	and org = <cfqueryparam value="#form.targ#" cfsqltype="CF_SQL_INTEGER">
	</cfquery>
	<cfif QSelAG.recordcount is 0>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QInsAG">
insert into monthly_org
(userid, year2,  mon, initnum, stratnum, org, meet, phone, letter, email)
values
(<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
,<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
,<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
,<cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
,<cfqueryparam value="#form.strat#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.strat))#">
,<cfqueryparam value="#form.targ#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.targ))#">
,<cfqueryparam value="#form.meet#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.meet))#">
,<cfqueryparam value="#form.fon#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.fon))#">
,<cfqueryparam value="#form.lett#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.lett))#">
,<cfqueryparam value="#form.email#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.email))#">)
</cfquery>
</cfif>
</cfif>
<cfif form.dofunction is 'addCC' or isdefined("addcc")>
<cfif isDefined("form.addcc") and form.addcc EQ "update">
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QInsCG">
update monthly_org
set
adcomm=<cfif isdefined("form.adcomm") and #form.adcomm# is not ''><cfqueryparam value="#form.adcomm#" cfsqltype="CF_SQL_INTEGER"><cfelse>0</cfif> ,
prvtrain=<cfif isdefined("form.prvtrain") and #form.prvtrain# is not ''><cfqueryparam value="#form.prvtrain#" cfsqltype="CF_SQL_INTEGER"><cfelse>0</cfif>,
techass=<cfif isdefined("form.techass1") and #form.techass1# is not ''><cfqueryparam value="#form.techass1#" cfsqltype="CF_SQL_INTEGER"><cfelse>0</cfif>,
descr=<cfif isDefined("form.adcomm_descr")><cfqueryparam value="#form.adcomm_descr#" cfsqltype="CF_SQL_VARCHAR" maxlength="4000"><cfelse>NULL</cfif>
	where userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
	and initnum = <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	and org = <cfqueryparam value="#form.targ7#" cfsqltype="CF_SQL_INTEGER">
</cfquery>
<cfset form.targ7 = ''>
<cfelse>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QSelCC">
	select *
	from monthly_org
	where userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
	and initnum = <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	and org = <cfqueryparam value="#form.targ7#" cfsqltype="CF_SQL_INTEGER">
	</cfquery>
<cfif isdefined("form.techass1") and #form.techass1# is 1 and (#session.modality# is 2 or #session.modality# is 3)>
	<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="GetEmailStats">
select
c.orgname,c.partnertype, c.coordemail as partneremail,
case c.partnertype
<!--- when 1 then 'amw06@health.state.ny.us'
when 2 then 'elizabeth.anker@health.ny.gov'
when 3 then 'elizabeth.anker@health.ny.gov' --->
when 1 then '#session.MM1#'
when 2 then '#session.MM2#'
when 6 then '#session.MM6#'
else NULL end as mmanager,
m.email as cmanager
from contact c, contact m
where m.userid=c.cmanager
and c.partnertype in (1,2,6)
and c.userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
and isNull(c.coordemail,'rti.org') not like '%rti.org'
</cfquery>
<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="targname">
	select distinct tor.targid,name,isnull(tm.org,0) as tm
from target_org tor left join monthly_org tm
on tor.targid = tm.org and tor.year2 = tm.year2
and tor.initnum = tm.initnum and tor.userid = tm.userid and tm.mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
where tor.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> and tor.initnum = <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
and targid = <cfqueryparam value="#form.targ7#" cfsqltype="CF_SQL_INTEGER">
order by name
</cfquery>
<cfmail from="NY Tobacco Control Program <NY-Tobacco-Control-Program@rti.org>"
to="#GetEmailStats.cmanager#; #GetEmailStats.mmanager#;tobacco@tobaccopolicycenter.org" bcc="dplotner@rti.org; twills@rti.org"
subject="#session.orgname# – identified support/commitment for policy" type="HTML">
#session.orgname# has identified that #targname.name# is supportive of/committed to policy change for #session.initiative# in the #session.mon# Monthly Report.
</cfmail>
</cfif>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QInsBG">
insert into monthly_org
(userid, year2,  mon, initnum, org
,adcomm
,prvtrain
,techass,
descr)
values
(<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">, <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">, <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">, <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">, <cfqueryparam value="#form.targ7#" cfsqltype="CF_SQL_INTEGER">
<cfif isdefined("form.adcomm") and #form.adcomm# is not ''>,<cfqueryparam value="#form.adcomm#" cfsqltype="CF_SQL_INTEGER"><cfelse>,0</cfif>
<cfif isdefined("form.prvtrain") and #form.prvtrain# is not ''>,<cfqueryparam value="#form.prvtrain#" cfsqltype="CF_SQL_INTEGER"><cfelse>,0</cfif>
<cfif isdefined("form.techass1") and #form.techass1# is not ''>,<cfqueryparam value="#form.techass1#" cfsqltype="CF_SQL_INTEGER"><cfelse>,0</cfif>
<cfif isDefined("form.adcomm_descr")>,<cfqueryparam value="#form.adcomm_descr#" cfsqltype="CF_SQL_VARCHAR" maxlength="4000"><cfelse>,NULL</cfif>)
</cfquery>
</cfif>
</cfif>
<cfif form.dofunction is 'addCommob' or isdefined("addcommmob")>
<cfif form.addcommmob EQ 'Update'>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QInsCG">
update monthly_commmob
set
commed=<cfqueryparam value="#form.commed#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.commed))#">,
advoc=<cfqueryparam value="#form.advoc#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.advoc))#">,
gpme=<cfqueryparam value="#form.govt#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.govt))#">,
youth=<cfqueryparam value="#form.youth#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.youth))#">,
descr=<cfqueryparam value="#form.advance#" cfsqltype="CF_SQL_VARCHAR" maxlength="5000">
where
monthlycommmobID=<cfqueryparam value="#form.targy#" cfsqltype="CF_SQL_INTEGER">
and userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
and mon=<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
and year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
</cfquery>
<cfelse>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QInsCommmob">
insert into monthly_commmob
(userid, year2,  mon, target, commed, advoc, gpme, youth, descr, initnum)
values
(<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
,<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
,<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
,<cfqueryparam value="#form.targ2a#" cfsqltype="CF_SQL_INTEGER">
,<cfqueryparam value="#form.commed#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.commed))#">
,<cfqueryparam value="#form.advoc#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.advoc))#">
,<cfqueryparam value="#form.govt#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.govt))#">
,<cfqueryparam value="#form.youth#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.youth))#">
,<cfqueryparam value="#form.advance#" cfsqltype="CF_SQL_VARCHAR" maxlength="5000">
,<cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">)
</cfquery>
</cfif>
<cflocation url="month.cfm##commmob" addtoken="no">
</cfif>
<cfif form.dofunction is 'addCG' or isdefined("addcommunity")>
<cfif isDefined("addcommunity") and addcommunity EQ "Update">
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QInsBG">
update monthly_comm
set target=<cfqueryparam value="#form.target#" cfsqltype="CF_SQL_VARCHAR" maxlength="55">,
event = <cfqueryparam value="#form.event#" cfsqltype="CF_SQL_VARCHAR" maxlength="1020">
where
monthlycommid=<cfqueryparam value="#form.targid02#" cfsqltype="CF_SQL_INTEGER">
</cfquery>
<cfelse>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QSelBG">
	select *
	from monthly_comm
	where userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
	and initnum = <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	and event = <cfqueryparam value="#form.event#" cfsqltype="CF_SQL_VARCHAR" maxlength="1020">
	</cfquery>
	<cfif QSelBG.recordcount is 0>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QInsBG">
insert into monthly_comm
(userid, year2,  mon, initnum, event, county, target, attend, orgpart)
values
(<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
,<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
,<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
,<cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
,<cfqueryparam value="#form.event#" cfsqltype="CF_SQL_VARCHAR" maxlength="1020">
,<cfqueryparam value="#form.county#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
,<cfqueryparam value="#form.target#" cfsqltype="CF_SQL_VARCHAR" maxlength="55">
,<cfqueryparam value="#form.attend#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.attend))#">
,<cfqueryparam value="#form.orgpart#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.orgpart))#">)
</cfquery>
</cfif>
</cfif>
<cflocation url="month.cfm##comm" addtoken="no">
</cfif>
<cfif isdefined("addpaidmedia")>
<cfif addpaidmedia EQ "update">
<cfquery datasource="#application.DataSource#"	password="#application.db_password#"
	username="#application.db_username#" name="QInsDG">
update monthly_media
set mediatype=<cfqueryparam value="#form.mediatype#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
mediachannel=<cfqueryparam value="#form.mediachannel#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
spottitle=<cfqueryparam value="#form.spottitle#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
number=<cfqueryparam value="#form.number#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.number))#">,
cost=<cfqueryparam value="#form.cost#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.cost))#">
where
monthlymediaID=<cfqueryparam value="#form.targid03#" cfsqltype="CF_SQL_INTEGER">
</cfquery>
<cfelse>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QSelPG">
	select *
	from monthly_media
	where userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
	and initnum = <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	and spottitle = <cfqueryparam value="#form.spottitle#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and mediatype = <cfqueryparam value="#form.mediatype#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and mediachannel = <cfqueryparam value="#form.mediachannel#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and number = <cfqueryparam value="#form.number#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.number))#">
	</cfquery>
	<cfif QSelPG.recordcount is 0>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QInsDG">
insert into monthly_media
(userid, year2,  mon, initnum, mediatype,mediachannel,spottitle,number,cost)
values
(<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
,<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
,<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
,<cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
,<cfqueryparam value="#form.mediatype#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
,<cfqueryparam value="#form.mediachannel#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
,<cfqueryparam value="#form.spottitle#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
,<cfqueryparam value="#form.number#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.number))#">
,<cfqueryparam value="#form.cost#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.cost))#">)
</cfquery></cfif>
<cfoutput>
<cflocation url="month.cfm##pm" addtoken="no"></cfoutput>
</cfif>
</cfif>
<cfif form.dofunction is 'addSG' or (isdefined("form.return") and (#form.return# is 'Save and return to Monthly Reporting' or #form.return# is 'Save')) or (isdefined("form.addPOS") and form.addpos is 'Add') or (isdefined("form.addPOS2") and form.addpos2 is 'Add') or (isdefined("form.addPOS3") and form.addpos3 is 'Add') or (isdefined("form.addPOS4") and form.addpos4 is 'Add') or (isdefined("form.addPOS5") and form.addpos5 is 'Add') or (isdefined("form.addPOS6") and (form.addpos6 is 'Add' or form.addpos6 is 'Update'))>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="mon">
select
	*
	from monthly
	where
	userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and mon=<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
	and initnum=<cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
</cfquery>
<cfif mon.recordcount EQ 0 and form.modality is not 6>

<cfparam name="form.speclawtxt" default="">
<cfif isDefined("mon.boolsfop")><cfset attributes.boolsfop = #mon.boolsfop#></cfif>
<cfif isDefined("form.boolsfop") and #form.boolsfop# is not ''><cfset attributes.boolsfop = #form.boolsfop#></cfif>
<cfif isDefined("mon.boolsfop2")><cfset attributes.boolsfop2 = #mon.boolsfop2#></cfif>
<cfif isDefined("form.boolsfop2") and #form.boolsfop2# is not ''><cfset attributes.boolsfop2 = #form.boolsfop2#></cfif>
<cfif isDefined("mon.specSFODTxt")><cfset attributes.specSFODTxt = #mon.specSFODTxt#></cfif>
<cfif isDefined("form.specSFODTxt")><cfset attributes.specSFODTxt = #form.specSFODTxt#></cfif>
<cfif isDefined("mon.specSFODTxt2")><cfset attributes.specSFODTxt2 = #mon.specSFODTxt2#></cfif>
<cfif isDefined("form.specSFODTxt2")><cfset attributes.specSFODTxt2 = #form.specSFODTxt2#></cfif>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QInsMO">
insert into monthly
(userid, year2, mon, initnum, stratnum, advmassmail,govtmassmail,ccmassmail, editor,prssrlse,calls,prsspk,ltred,nwsstry,nwsltr,editorial,other,summary,barriers,steps,boollaw,speclawtxt,boolSuperPol,specsuperacttxt,boolSFOP,boolSFOP2,specSFODTxt,specSFODTxt2,dispstrat1,dispstrat2,dispstrat3,dispstrat4,dispstrat5,dispstrattxt)
values
(<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">,
<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">,
<cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
, <cfqueryparam  cfsqltype="CF_SQL_INTEGER" value="#form.strat#" null="#YesNoFormat(not Len(form.strat))#">
, <cfqueryparam  cfsqltype="CF_SQL_INTEGER" value="#form.advmassmail#" null="#YesNoFormat(not Len(form.advmassmail))#">
, <cfqueryparam  cfsqltype="CF_SQL_INTEGER" value="#form.govtmassmail#" null="#YesNoFormat(not Len(form.govtmassmail))#">
, <cfqueryparam  cfsqltype="CF_SQL_INTEGER" value="#form.ccmassmail#" null="#YesNoFormat(not Len(form.ccmassmail))#">
, <cfqueryparam  cfsqltype="CF_SQL_INTEGER" value="#form.editor#" null="#YesNoFormat(not Len(form.editor))#">
, <cfqueryparam  cfsqltype="CF_SQL_INTEGER" value="#form.prssrlse#" null="#YesNoFormat(not Len(form.prssrlse))#">
, <cfqueryparam  cfsqltype="CF_SQL_INTEGER" value="#form.calls#" null="#YesNoFormat(not Len(form.calls))#">
, <cfqueryparam  cfsqltype="CF_SQL_INTEGER" value="#form.prsspk#" null="#YesNoFormat(not Len(form.prsspk))#">
, <cfqueryparam  cfsqltype="CF_SQL_INTEGER" value="#form.ltred#" null="#YesNoFormat(not Len(form.ltred))#">
, <cfqueryparam  cfsqltype="CF_SQL_INTEGER" value="#form.nwsstry#" null="#YesNoFormat(not Len(form.nwsstry))#">
, <cfqueryparam  cfsqltype="CF_SQL_INTEGER" value="#form.nwsltr#" null="#YesNoFormat(not Len(form.nwsltr))#">
, <cfqueryparam  cfsqltype="CF_SQL_INTEGER" value="#form.editorial#" null="#YesNoFormat(not Len(form.editorial))#">
, <cfqueryparam  cfsqltype="CF_SQL_INTEGER" value="#form.other#" null="#YesNoFormat(not Len(form.other))#">
, <cfqueryparam value="#form.summary#" cfsqltype="CF_SQL_VARCHAR" maxlength="2050" >
, <cfqueryparam value="#form.barriers#" cfsqltype="CF_SQL_VARCHAR" maxlength="2050">
, <cfqueryparam value="#form.steps#" cfsqltype="CF_SQL_VARCHAR" maxlength="2050">
, <cfqueryparam  cfsqltype="CF_SQL_INTEGER" value="#form.boollaw#" null="#YesNoFormat(not Len(form.boollaw))#">
, <cfqueryparam value="#form.speclawtxt#" cfsqltype="CF_SQL_VARCHAR" maxlength="1000" >
, <cfqueryparam  cfsqltype="CF_SQL_INTEGER" value="#form.boolsuperpol#" null="#YesNoFormat(not Len(form.boolsuperpol))#">
, <cfqueryparam value="#form.specsuperacttxt#" cfsqltype="CF_SQL_VARCHAR" maxlength="1000">
, <cfqueryparam  cfsqltype="CF_SQL_INTEGER" value="#form.boolSFOP#" null="#YesNoFormat(not Len(form.boolSFOP))#">
, <cfqueryparam  cfsqltype="CF_SQL_INTEGER" value="#form.boolSFOP2#" null="#YesNoFormat(not Len(form.boolSFOP2))#">
, <cfqueryparam value="#attributes.specSFODTxt#" cfsqltype="CF_SQL_VARCHAR" maxlength="1000">
, <cfqueryparam value="#attributes.specSFODTxt2#" cfsqltype="CF_SQL_VARCHAR" maxlength="1000">
, <cfqueryparam  cfsqltype="CF_SQL_INTEGER" value="#form.dispstrat1#" null="#YesNoFormat(not Len(form.dispstrat1))#">
, <cfqueryparam  cfsqltype="CF_SQL_INTEGER" value="#form.dispstrat2#" null="#YesNoFormat(not Len(form.dispstrat2))#">
, <cfqueryparam  cfsqltype="CF_SQL_INTEGER" value="#form.dispstrat3#" null="#YesNoFormat(not Len(form.dispstrat3))#">
, <cfqueryparam  cfsqltype="CF_SQL_INTEGER" value="#form.dispstrat4#" null="#YesNoFormat(not Len(form.dispstrat4))#">
, <cfqueryparam  cfsqltype="CF_SQL_INTEGER" value="#form.dispstrat5#" null="#YesNoFormat(not Len(form.dispstrat5))#">
,<cfqueryparam value="#form.dispstrattxt#" cfsqltype="CF_SQL_VARCHAR" maxlength="5000">)
</cfquery>
<cfelse>

<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QInsWG">
	update monthly set
	userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	,advmassmail = <cfqueryparam value="#form.advmassmail#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.advmassmail))#">
	,govtmassmail = <cfqueryparam value="#form.govtmassmail#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.govtmassmail))#">
	,ccmassmail = <cfqueryparam value="#form.ccmassmail#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.ccmassmail))#">
	,editor = <cfqueryparam value="#form.editor#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.editor))#">
	,prssrlse = <cfqueryparam value="#form.prssrlse#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.prssrlse))#">
	,calls = <cfqueryparam value="#form.calls#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.calls))#">
	,prsspk = <cfqueryparam value="#form.prsspk#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.prsspk))#">
	,ltred = <cfqueryparam value="#form.ltred#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.ltred))#">
	,nwsstry = <cfqueryparam value="#form.nwsstry#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.nwsstry))#">
	,nwsltr = <cfqueryparam value="#form.nwsltr#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.nwsltr))#">
	,editorial = <cfqueryparam value="#form.editorial#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.editorial))#">
	,other = <cfqueryparam value="#form.other#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.other))#">
	,barriers = <cfqueryparam value="#form.barriers#" cfsqltype="CF_SQL_VARCHAR" maxlength="2050">
	,summary = <cfqueryparam value="#form.summary#" cfsqltype="CF_SQL_VARCHAR" maxlength="2050">
	,steps = <cfqueryparam value="#form.steps#" cfsqltype="CF_SQL_VARCHAR" maxlength="2050">
	,boollaw = <cfqueryparam value="#form.boollaw#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.boollaw))#">
	,speclawtxt = <cfqueryparam value="#form.speclawtxt#" cfsqltype="CF_SQL_VARCHAR" maxlength="1000">
	,boolsuperpol = <cfqueryparam value="#form.boolsuperpol#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.boolsuperpol))#">
	,boolsfop = <cfqueryparam value="#form.boolsfop#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.boolsfop))#">
	,boolsfop2 = <cfqueryparam value="#form.boolsfop2#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.boolsfop2))#">
	,specsuperacttxt = <cfqueryparam value="#form.specsuperacttxt#" cfsqltype="CF_SQL_VARCHAR" maxlength="1000">
	,specSFODTxt = <cfqueryparam value="#attributes.specSFODTxt#" cfsqltype="CF_SQL_VARCHAR" maxlength="1000">
	,specSFODTxt2 = <cfqueryparam value="#attributes.specSFODTxt2#" cfsqltype="CF_SQL_VARCHAR" maxlength="1000">
	,dispstrat1 = <cfqueryparam value="#form.dispstrat1#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.dispstrat1))#">
	,dispstrat2 = <cfqueryparam value="#form.dispstrat2#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.dispstrat2))#">
	,dispstrat3 = <cfqueryparam value="#form.dispstrat3#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.dispstrat3))#">
	,dispstrat4 = <cfqueryparam value="#form.dispstrat4#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.dispstrat4))#">
	,dispstrat5 = <cfqueryparam value="#form.dispstrat5#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.dispstrat5))#">
	,dispstrattxt = <cfqueryparam value="#form.dispstrattxt#" cfsqltype="CF_SQL_VARCHAR" maxlength="5000">
	where userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
	and initnum = <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	</cfquery>
</cfif>
</cfif>
<cfif  (isDefined("url.target") and url.target EQ 'updIG') and not isDefined("form.addpolicy")>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QSelIG2">
	select *
	from monthly_initsum
	where userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
	and seq = <cfqueryparam value="#url.seq#" cfsqltype="CF_SQL_INTEGER">
	and initnum = <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	</cfquery>
<cfelseif (isDefined("form.targ999") and form.targ999 neq "") and not isDefined("form.addpolicy")>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QSelIG2">
	select *
	from monthly_initsum
	where userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
	and seq = '#form.targ999#'
	and initnum = <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	</cfquery>
<cfelseif  (isDefined("url.target") and url.target EQ "advadv")>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name = "QgettargXXa"> <!--- name="QccorgDet" --->
select
	*
	from monthly_org tor
	where
	tor.userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and tor.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and tor.initnum=<cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	and tor.mon=<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
	and tor.org = <cfqueryparam value="#url.seq#" cfsqltype="CF_SQL_INTEGER">
	order by 1 --name
</cfquery>
<cfset form.targ7 = #url.seq#>
</cfif>
<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="targadv">
	select distinct tor.targid,name,isnull(tm.org,0) as tm
from target_org tor left join monthly_org tm
on tor.targid = tm.org and tor.year2 = tm.year2 and tor.initnum = tm.initnum and tor.userid = tm.userid and tm.mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
where tor.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> and tor.initnum = <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5"> and tor.userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> and tor.stratnum = 1
order by name
</cfquery>
<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="targgovt">
	select distinct tor.targid,name,isnull(tm.org,0) as tm,targdisp
from target_org tor left join monthly_org tm
on tor.targid = tm.org and tor.year2 = tm.year2 and tor.initnum = tm.initnum and tor.userid = tm.userid and tm.mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
where tor.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> and tor.initnum = <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5"> and tor.userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> and tor.stratnum = 2
order by name
</cfquery>
<cfif session.objval is '3m'>
<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="targcc">
select distinct tor.targid,name,targdisp
from target_org tor
where tor.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> and tor.initnum = <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
and tor.userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
and tor.stratnum = 1 and targid not in (select org from monthly_org where year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> and initnum = <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5"> and mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">)
UNION
select 999, 'MPAA','' as targdisp
UNION
Select 888, 'YouTube','' as targdisp
UNION
Select 777, 'Major television network','' as targdisp
order by 2
</cfquery>
<cfelse>
<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="targcc">
	select distinct tor.targid,name,targdisp
from target_org tor
where tor.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> and tor.initnum = <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
and tor.userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
and tor.stratnum = 1 and targid not in (select org from monthly_org where year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> and initnum = <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5"> and mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">)
order by name
</cfquery>
</cfif>
<cfif isdefined("url.seq") and isdefined("url.target") and #url.target# is 'advadv'>
<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="targcc">
	select distinct tor.targid,name,isnull(tm.org,0) as tm,targdisp
from target_org tor left join monthly_org tm
on tor.targid = tm.org and tor.year2 = tm.year2
and tor.initnum = tm.initnum and tor.userid = tm.userid and tm.mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
where tor.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> and tor.initnum = <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
and tor.userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
and tor.stratnum = 1 and targid = <cfqueryparam value="#url.seq#" cfsqltype="CF_SQL_INTEGER">
order by name
</cfquery>
</cfif>
<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="targmi">
	select distinct tor.targid,name,targdisp
from target_org tor
where tor.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> and tor.initnum = <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
and tor.userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
and tor.stratnum = 1 and targid not in (select seq from monthly_initsum where year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> and initnum = <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5"> and mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">)
order by name
</cfquery>
<cfif isdefined("url.seq") and isdefined("url.target") and url.target is 'updIG' and not isdefined("form.addpolicy")>
<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="targmi">
	select distinct tor.targid,name,isnull(tm.org,0) as tm,targdisp
from target_org tor left join monthly_org tm
on tor.targid = tm.org and tor.year2 = tm.year2
and tor.initnum = tm.initnum and tor.userid = tm.userid and tm.mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
where tor.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> and tor.initnum = <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
and tor.userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
and tor.stratnum = 1 and targid = <cfqueryparam value="#url.seq#" cfsqltype="CF_SQL_INTEGER">
order by name
</cfquery>
</cfif>
<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="targCommmob">
	select
	targid, name, targdisp
	from target_org tor where
	userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and tor.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and initnum=<cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	and stratnum=0
	order by name
</cfquery>
<cfif form.dofunction is 'addLG'>
<cfloop index="x" list="#form.wrkselfid#">
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="se">
select * from selfeval_mon
where
wrkselfid = <cfqueryparam value="#x#" cfsqltype="CF_SQL_INTEGER">
and mon=<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER"> and year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	</cfquery>
	<cfoutput>
<cfset sum = 'form.summary'&#x#>
<cfset sumsum = '#evaluate(sum)#'>
<cfset bar = 'form.barriers'&#x#>
<cfset barbar = '#evaluate(bar)#'>
<cfset step = 'form.steps'&#x#>
<cfset stepstep = '#evaluate(step)#'>
</cfoutput>
<cfif se.recordcount is 0>
 <cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QInsSE">
insert into selfeval_mon
(wrkselfid,userid, year2, mon, summary,barriers,steps)
values
(<cfqueryparam value="#x#" cfsqltype="CF_SQL_INTEGER">,<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">, <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">, <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">, <cfqueryparam value="#sumsum#" cfsqltype="CF_SQL_VARCHAR" maxlength="2000">,<cfqueryparam value="#barbar#" cfsqltype="CF_SQL_VARCHAR" maxlength="2000">,<cfqueryparam value="#stepstep#" cfsqltype="CF_SQL_VARCHAR" maxlength="2000">)
</cfquery>
<cfelse><cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QupdSE">
	update selfeval_mon set
	summary = <cfqueryparam value="#sumsum#" cfsqltype="CF_SQL_VARCHAR" maxlength="2050">
	,barriers = <cfqueryparam value="#barbar#" cfsqltype="CF_SQL_VARCHAR" maxlength="2050">
	,steps = <cfqueryparam value="#stepstep#" cfsqltype="CF_SQL_VARCHAR" maxlength="2050">
	where
	wrkselfid = <cfqueryparam value="#x#" cfsqltype="CF_SQL_INTEGER">
and mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
 and year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	</cfquery>
</cfif>
</cfloop>
</cfif>
<cfif isdefined("form.return") and #form.return# is 'Save and return to Monthly Reporting' and #form.stop# is not 1>
	 <cflocation url="monthrep.cfm">
</cfif>
<cfif isdefined("form.addPOS5") and #form.addPOS5# is 'Add'>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QInsTG5">
insert into monthly_pos5
(userid, entdt,year2,  mon, initnum,sforg,SFPol1,SFPol2,SFPol3,SFPol4,SFPol5,SFPnMuniDesc,cntrcAgreeSFPnMuni)
values
(<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">, '#dateformat(now(),"mm/dd/yyyy")#'
,<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
,<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
,<cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
,<cfqueryparam value="#form.sforg#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.sforg))#">
,<cfqueryparam value="#form.SFPol1#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.sfpol1))#">
,<cfqueryparam value="#form.SFPol2#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.sfpol2))#">
,<cfqueryparam value="#form.SFPol3#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.sfpol3))#">
,<cfqueryparam value="#form.SFPol4#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.sfpol4))#">
,<cfqueryparam value="#form.SFPol5#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.sfpol5))#">
,<cfqueryparam value="#form.SFPnMuniDesc#" cfsqltype="CF_SQL_VARCHAR" maxlength="1500">
,<cfqueryparam value="#form.cntrcAgreeSFPnMuni#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.cntrcAgreeSFPnMuni))#">)
</cfquery>
<cfset form.lbody2 = "">
<cfset form.sforg = "">
<cfset form.sfpol1 = "">
<cfset form.sfpol2 = "">
<cfset form.sfpol3 = "">
<cfset form.sfpol4 = "">
<cfset form.sfpol5 = "">
<cfset form.SFPnMuniDesc = "">
<cfset form.cntrcAgreeSFPnMuni = "">\
<cfset form.county = "">
<cflocation url="month.cfm##pos" addtoken="no">
</cfif>
<cfif isdefined("form.addPOS4")>
<cfif  #form.addPOS4# is 'Add'>
	<cfset CleanList = ListChangeDelims(form.county, ",", ",")>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QInsTG">
insert into monthly_pos4
(userid, entdt,year2,  mon, initnum,sforg,SFPol1,SFPol2,SFPol3,SFPol4,SFPol5,SFPnMuniDesc,cntrcAgreeSFPnMuni,county)
values
(<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
,'#dateformat(now(),"mm/dd/yyyy")#'
,<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
,<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
,<cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
,<cfqueryparam value="#form.sforg#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.sforg))#">
,<cfqueryparam value="#form.SFPol1#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.sfpol1))#">
,<cfqueryparam value="#form.SFPol2#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.sfpol2))#">
,<cfqueryparam value="#form.SFPol3#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.sfpol3))#">
,<cfqueryparam value="#form.SFPol4#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.sfpol4))#">
,<cfqueryparam value="#form.SFPol5#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.sfpol5))#">
,<cfqueryparam value="#form.SFPnMuniDesc#" cfsqltype="CF_SQL_VARCHAR" maxlength="1500">
,<cfqueryparam value="#form.cntrcAgreeSFPnMuni#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.cntrcAgreeSFPnMuni))#">,<cfqueryparam value="#CleanList#" cfsqltype="CF_SQL_VARCHAR" maxlength="100">)
</cfquery>
<cfelseif  #form.addPOS4# is 'Update'>
<cfset CleanList = ListChangeDelims(form.county, ",", ",")>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QInsTG">
update monthly_pos4
set sforg=<cfqueryparam value="#form.sforg#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.sforg))#">,
SFPol1=<cfqueryparam value="#form.SFPol1#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.sfpol1))#">,
SFPol2=<cfqueryparam value="#form.SFPol2#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.sfpol2))#">,
SFPol3=<cfqueryparam value="#form.SFPol3#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.sfpol3))#">,
SFPol4=<cfqueryparam value="#form.SFPol4#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.sfpol4))#">,
SFPol5=<cfqueryparam value="#form.SFPol5#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.sfpol5))#">,
SFPnMuniDesc=<cfqueryparam value="#form.SFPnMuniDesc#" cfsqltype="CF_SQL_VARCHAR" maxlength="1500">,
cntrcAgreeSFPnMuni=<cfqueryparam value="#form.cntrcAgreeSFPnMuni#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.cntrcAgreesfpnmuni))#">,
county='#CleanList#'
where userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
and initnum = <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
and monthlyid= <cfqueryparam value="#form.pos4seq#" cfsqltype="CF_SQL_INTEGER">
</cfquery>
</cfif>
<cfset form.lbody2 = "">
<cfset form.sforg = "">
<cfset form.sfpol1 = "">
<cfset form.sfpol2 = "">
<cfset form.sfpol3 = "">
<cfset form.sfpol4 = "">
<cfset form.sfpol5 = "">
<cfset form.SFPnMuniDesc = "">
<cfset form.cntrcAgreeSFPnMuni = "">
<cfset form.county = "">
<cflocation url="month.cfm##POS44" addtoken="no">

</cfif>
<cfif isdefined("form.addPOS3")>
<cfif isdefined("form.jurnum") and #form.jurnum# is not ''>
<cfset jur = #rereplace(form.jurnum, "[^0-9|.]", "","All")#>
<cfelse>
<cfset jur = ''>
</cfif>
<cfif  #form.addPOS3# is 'Add'>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QInsTG">
insert into monthly_pos3
(userid, entdt,year2,  mon, initnum,lbody2,sford1,sford2,sford3,sford4,sford5,jurname2,boolpassed2,txtconcerns,cntrcAgree,jurnum,cntrcAgree2,county)
values
(<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
'#dateformat(now(),"mm/dd/yyyy")#',
<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">,
<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">,
<cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">,
<cfqueryparam  cfsqltype="CF_SQL_INTEGER" value="#form.lbody2#" null="#YesNoFormat(not Len(form.lbody2))#">,
<cfqueryparam  cfsqltype="CF_SQL_INTEGER" value="#form.sford1#" null="#YesNoFormat(not Len(form.sford1))#">,
<cfqueryparam  cfsqltype="CF_SQL_INTEGER" value="#form.sford2#" null="#YesNoFormat(not Len(form.sford2))#">,
<cfqueryparam  cfsqltype="CF_SQL_INTEGER" value="#form.sford3#" null="#YesNoFormat(not Len(form.sford3))#">,
<cfqueryparam  cfsqltype="CF_SQL_INTEGER" value="#form.sford4#" null="#YesNoFormat(not Len(form.sford4))#">,
<cfqueryparam  cfsqltype="CF_SQL_INTEGER" value="#form.sford5#" null="#YesNoFormat(not Len(form.sford5))#">,
<cfqueryparam value="#form.jurname2#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
<cfqueryparam  cfsqltype="CF_SQL_INTEGER" value="#form.boolpassed2#" null="#YesNoFormat(not Len(form.boolpassed2))#">,
<cfqueryparam value="#form.txtconcerns#" cfsqltype="CF_SQL_VARCHAR" maxlength="1500">,
<cfqueryparam  cfsqltype="CF_SQL_INTEGER" value="#form.cntrcAgree#" null="#YesNoFormat(not Len(form.cntrcAgree))#">,
<cfqueryparam  cfsqltype="CF_SQL_INTEGER" value="#jur#" null="#YesNoFormat(not Len(jur))#">,
<cfqueryparam  cfsqltype="CF_SQL_INTEGER" value="#form.cntrcAgree2#" null="#YesNoFormat(not Len(form.cntrcAgree2))#">,
<cfqueryparam value="#form.county#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">)
</cfquery>
<cfelseif  #form.addPOS3# is 'Update' and isDefined("form.pos3seq")>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QInsTG">
update monthly_pos3
set
lbody2=<cfqueryparam value="#form.lbody2#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.lbody2))#">,
sford1=<cfqueryparam value="#form.sford1#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.sford1))#">,
sford2=<cfqueryparam value="#form.sford2#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.sford2))#">,
sford3=<cfqueryparam value="#form.sford3#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.sford3))#">,
sford4=<cfqueryparam value="#form.sford4#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.sford4))#">,
sford5=<cfqueryparam value="#form.sford5#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.sford5))#">,
jurname2=<cfqueryparam value="#form.jurname2#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
boolpassed2=<cfqueryparam value="#form.boolpassed2#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.boolpassed2))#">,
txtconcerns=<cfqueryparam value="#form.txtconcerns#" cfsqltype="CF_SQL_VARCHAR" maxlength="1500">,
cntrcAgree=<cfqueryparam value="#form.cntrcAgree#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.cntrcAgree))#">,
jurnum=<cfqueryparam value="#jur#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(jur))#">,
cntrcAgree2=<cfqueryparam value="#form.cntrcAgree2#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.cntrcAgree2))#">,
county=<cfqueryparam value="#form.county#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">
where userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
and initnum = <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
and monthlyid= <cfqueryparam value="#form.pos3seq#" cfsqltype="CF_SQL_INTEGER">
</cfquery>
</cfif>
<cfset form.lbody2 = "">
<cfset form.sford1 = "">
<cfset form.sford2 = "">
<cfset form.sford3 = "">
<cfset form.sford4 = "">
<cfset form.sford5 = "">
<cfset form.jurname2 = "">
<cfset form.boolpassed2 = "">
<cfset form.txtconcerns = "">
<cfset form.cntrcAgree = "">
<cfset form.jurnum = "">
<cfset form.policylink = "">
<cfset form.policydesc = "">
<cfset form.cntrcAgree2 = "">
<cfset form.county = "">
<cfset form.jurnum = ""><cflocation url="month.cfm##pos" addtoken="no">
</cfif>
<cfif isdefined("form.addPOS2") and #form.addPOS2# is 'Add'>
<cfparam name="form.SCHAINNAME" default="">
<cfparam name="form.poa" default="">
<cfparam name="form.poldesc" default="">
<cfparam name="form.NUMSTORES" default="">
<cfparam name="form.boolotherstates" default="">
<cfparam name="form.CNTCAGREE3" default="">
specsuperacttxt
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QInsTG">
insert into monthly_pos2
(userid, entdt,year2,  mon, initnum, schainname,poa,poldesc,numstores,boolotherstates,cntcagree3)
values
(<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
,'#dateformat(now(),"mm/dd/yyyy")#'
,<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
,<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
,<cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
,<cfqueryparam value="#form.schainname#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.schainname))#">
,<cfqueryparam value="#form.poa#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
,<cfqueryparam value="#form.poldesc#" cfsqltype="CF_SQL_VARCHAR" maxlength="2000">
,<cfqueryparam value="#form.numstores#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.numstores))#">
,<cfqueryparam value="#form.boolotherstates#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.boolotherstates))#">
,<cfqueryparam value="#form.cntcagree3#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.cntcagree3))#">)
</cfquery>
<cfset form.schainname = "">
<cfset form.poa = "">
<cfset form.poldesc = "">
<cfset form.numstores = "">
<cfset form.boolOtherStates = "">
<cfset form.cntcAgree3 = "">
<cflocation url="month.cfm##pos" addtoken="no">
</cfif>
<cfif isdefined("form.addPOS") >
<cfparam name="form.vaddressed1" default="">
<cfparam name="form.vaddressed2" default="">
<cfparam name="form.coupon" default="">
<cfparam name="form.boolPassed" default="">
<cfparam name="form.coupon" default="">
<cfparam name="form.cntrcAgree" default="">
<cfparam name="form.cntrcAgree2" default="">
<cfparam name="form.specLawTxt" default="">
<cfparam name="form.lBody" default="">
<cfparam name="form.jurName" default="">
<cfif #form.addPOS# is 'Add'>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QInsTG">
insert into monthly_pos
(userid, entdt,year2,  mon, initnum, lbody,jurName,county,
vaddressed1,vaddressed2,boolPassed,coupon,txtConcerns,cntrcAgree,jurNum,policylink,policydesc,cntrcAgree2)
values
(<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
,'#dateformat(now(),"mm/dd/yyyy")#'
,<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
,<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
,<cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
,<cfqueryparam value="#form.lbody#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.lbody))#">
,<cfqueryparam value="#form.jurname#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
,<cfqueryparam value="#form.county#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">,
<cfqueryparam value="#form.vaddressed1#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.vaddressed1))#">
,<cfqueryparam value="#form.vaddressed2#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.vaddressed2))#">
,<cfqueryparam value="#form.boolpassed#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.boolpassed))#">
,<cfqueryparam value="#form.coupon#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.coupon))#">
,<cfqueryparam value="#form.txtConcerns#" cfsqltype="CF_SQL_VARCHAR" maxlength="2000">
,<cfqueryparam value="#form.cntrcAgree#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.cntrcagree))#">
,<cfqueryparam value="#form.jurnum#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.jurnum))#">
,<cfqueryparam value="#form.policylink#" cfsqltype="CF_SQL_VARCHAR" maxlength="300">
,<cfqueryparam value="#form.policydesc#" cfsqltype="CF_SQL_VARCHAR" maxlength="1000">
,<cfqueryparam value="#form.cntrcAgree2#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.cntrcagree2))#">)
</cfquery>
<cfelseif  #form.addPOS# is 'Update'>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QInsTG">
update monthly_pos
set lbody=<cfqueryparam value="#form.lbody#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.lbody))#">,
jurName=<cfqueryparam value="#form.jurname#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
county=<cfqueryparam value="#form.county#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">,
vaddressed1=<cfqueryparam value="#form.vaddressed1#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.vaddressed1))#">,
vaddressed2=<cfqueryparam value="#form.vaddressed2#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.vaddressed2))#">,
boolPassed=<cfqueryparam value="#form.boolpassed#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.boolpassed))#">,
coupon=<cfqueryparam value="#form.coupon#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.coupon))#">,
txtConcerns= <cfqueryparam value="#form.txtConcerns#" cfsqltype="CF_SQL_VARCHAR" maxlength="2000" >,
cntrcAgree=<cfqueryparam value="#form.cntrcAgree#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.cntrcagree))#">,
jurNum=<cfqueryparam value="#form.jurnum#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.jurnum))#">,
policylink=<cfqueryparam value="#form.policylink#" cfsqltype="CF_SQL_VARCHAR" maxlength="300" >,
policydesc=<cfqueryparam value="#form.policydesc#" cfsqltype="CF_SQL_VARCHAR" maxlength="1000" >,
cntrcAgree2= <cfqueryparam value="#form.cntrcAgree2#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.cntrcagree2))#">
where monthlyid = <cfqueryparam value="#form.targid0a#" cfsqltype="CF_SQL_INTEGER">
</cfquery>
</cfif>
<cfset form.targ3 = ''>
<cfset form.sampnum = ''>
<cfset form.patscreen = ''>
<cfset form.patident = ''>
<cfset form.userquit = ''>
<cfset form.userquit_na = ''>
<cfset form.user_interv = ''>
<cflocation url="month.cfm##pos" addtoken="no">
</cfif>
<cfif #form.addPOS6# is 'Add'>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QInsTG6">
insert into monthly_pos6
(userid, entdt,year2,  mon, initnum,medout,polprohib1,polprohib2,polprohib3,polprohibtxt,jurname, sfmagree,county)
values
(<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
,'#dateformat(now(),"mm/dd/yyyy")#'
,<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
,<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
,<cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
,<cfqueryparam value="#form.medout#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.medout))#">
,<cfqueryparam value="#form.polprohib1#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.polprohib1))#">
,<cfqueryparam value="#form.polprohib2#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.polprohib2))#">
,<cfqueryparam value="#form.polprohib3#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.polprohib3))#">
,<cfqueryparam value="#form.polprohibtxt#" cfsqltype="CF_SQL_VARCHAR" maxlength="500">
,<cfqueryparam value="#form.jurname3#" cfsqltype="CF_SQL_VARCHAR" maxlength="1000">
,<cfqueryparam value="#form.sfmagree#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.sfmagree))#">
,<cfqueryparam value="#form.county#" cfsqltype="CF_SQL_VARCHAR" maxlength="100">)
</cfquery>
<cfset form.medout = "">
<cfset form.polprohib1 = "">
<cfset form.polprohib2 = "">
<cfset form.polprohib3 = "">
<cfset form.polprohibtxt = "">
<cfset form.jurname = "">
<cfset form.sfmagree = "0">
<cfset form.county = "">
<cflocation url="month.cfm?sfm=1##pos" addtoken="no">
<cfelseif #form.addPOS6# is 'Update'>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QInsTG">
update monthly_pos6
set polprohib1=<cfqueryparam value="#form.polprohib1#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.polprohib1))#">,
polprohib2=<cfqueryparam value="#form.polprohib2#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.polprohib2))#">,
polprohib3=<cfqueryparam value="#form.polprohib3#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.polprohib3))#">,
polprohibtxt=<cfqueryparam value="#form.polprohibtxt#" cfsqltype="CF_SQL_VARCHAR" maxlength="500">,
jurname=<cfqueryparam value="#form.jurname3#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
sfmagree=<cfif isDefined("form.sfmagree")><cfqueryparam value="#form.sfmagree#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.sfmagree))#"><cfelse>null</cfif>,
county=<cfif isDefined("form.county")><cfqueryparam value="#form.county#" cfsqltype="CF_SQL_VARCHAR" maxlength="100"><cfelse>null</cfif>
where monthlyid = <cfqueryparam value="#form.monthlyid#" cfsqltype="CF_SQL_INTEGER"> and mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
</cfquery>
<cfset form.medout = "">
<cfset form.polprohib1 = "">
<cfset form.polprohib2 = "">
<cfset form.polprohib3 = "">
<cfset form.polprohibtxt = "">
<cfset form.jurname = "">
<cfset form.county = "">
<cflocation url="month.cfm?sfm=1##pos" addtoken="no">
</cfif>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QPOS">
	select *
	from monthly_pos
	where userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
	and initnum = <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	</cfquery>
<cfset form.boolLaw = "">
<cfset form.lbody = "">
<cfset form.jurName = "">
<cfset form.county = "">
<cfset form.vaddressed1 = "">
<cfset form.vaddressed2 = "">
<cfset form.boolPassed = "">
<cfset form.coupon = "">
<cfset form.txtConcerns = "">
<cfset form.cntrcAgree = "">
<cfset form.jurNum = "">
<cfset form.policylink = "">
<cfset form.policydesc = "">
<cfset form.cntrcAgree2 = "">
<cfif isdefined("url.monthid")>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QPOS2">
	select *
	from monthly_pos
	where monthlyid = <cfqueryparam value="#monthid#" cfsqltype="CF_SQL_INTEGER">
	</cfquery>
<cfset form.boolLaw = "#qpos2.boolLaw#">
<cfset form.lbody = "#qpos2.lbody#">
<cfset form.jurName = "#qpos2.jurname#">
<cfset form.vaddressed1 = "#qpos2.vaddressed1#">
<cfset form.vaddressed2 = "#qpos2.vaddressed2#">
<cfset form.boolPassed = "#qpos2.boolpassed#">
<cfset form.coupon = "#qpos2.coupon#">
<cfset form.county = "#qpos2.county#">
</cfif>
<cfif isdefined("del_box2")>
<cfloop index="x" list="#del_box2#">
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="del">
	delete from monthly_org
	where
	org = <cfqueryparam value="#x#" cfsqltype="CF_SQL_INTEGER"> and mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER"> and year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	</cfquery>
</cfloop>
<cfoutput>
<cflocation url="month.cfm##advadv" addtoken="no"></cfoutput>
</cfif>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="Qtargorg">
select
	*
	from target_mon tor inner join target_org t on tor.targid = t.targid and tor.year2 = t.year2
	where
	tor.userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and tor.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and tor.initnum=<cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	and tor.mon=<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
</cfquery>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="mon">
select
	*
	from monthly
	where
	userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and mon=<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
	and initnum=<cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
</cfquery>

<cfif isDefined("mon.specSuperActTxt")><cfset attributes.specSuperActTxt = #mon.specSuperActTxt#></cfif>
<cfif isDefined("form.specSuperActTxt") and #form.specSuperActTxt# is not ''><cfset attributes.specSuperActTxt = #form.specSuperActTxt#></cfif>
<cfif isDefined("mon.boolSuperPol")><cfset attributes.boolSuperPol = #mon.boolSuperPol#></cfif>
<cfif isDefined("form.boolSuperPol") and #form.boolSuperPol# is not ''><cfset attributes.boolSuperPol = #form.boolSuperPol#></cfif>
<cfif isDefined("mon.specLawTxt")><cfset attributes.specLawTxt = #mon.specLawTxt#></cfif>
<cfif isDefined("form.specLawTxt") and #form.specLawTxt# is not ''><cfset attributes.specLawTxt = #form.specLawTxt#></cfif>
<cfif isDefined("mon.boolLaw")><cfset attributes.boolLaw = #mon.boolLaw#></cfif>
<cfif isDefined("form.boolLaw") and #form.boolLaw# is not ''><cfset attributes.boolLaw = #form.boolLaw#></cfif>
<cfif isDefined("mon.boolsfop")> <cfset attributes.boolsfop = #mon.boolsfop#></cfif>
<cfif isDefined("form.boolsfop") and #form.boolsfop# is not ''> <cfset attributes.boolsfop = #form.boolsfop#></cfif>
<cfif isDefined("mon.boolsfop2")><cfset attributes.boolsfop2 = #mon.boolsfop2#></cfif>
<cfif isDefined("form.boolsfop2") and #form.boolsfop2# is not ''><cfset attributes.boolsfop2 = #form.boolsfop2#></cfif>
<cfif isDefined("mon.specSFODTxt")><cfset attributes.specSFODTxt = #mon.specSFODTxt#></cfif>
<cfif isDefined("form.specSFODTxt")><cfset attributes.specSFODTxt = #form.specSFODTxt#></cfif>
<cfif isDefined("mon.specSFODTxt2")><cfset attributes.specSFODTxt2 = #mon.specSFODTxt2#></cfif>
<cfif isDefined("form.specSFODTxt2")><cfset attributes.specSFODTxt2 = #form.specSFODTxt2#></cfif>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="counties">
	select CountyName, FIPS from counties
	where FIPS in<cfif isDefined("countyheadache.catchment")>(#valuelist(countyheadache.catchment)#)<cfelse>(0)</cfif>
	order by 1
</cfquery>
<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="getinit">
	select *
from monthly_initsum m inner join target_org t on m.seq = t.targid
where
m.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> and m.initnum = <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5"> and m.userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> and m.mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
order by name
</cfquery>
<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="getinitcnt">
	select count(*) as cnt
from monthly_initsum m inner join target_org t on m.seq = t.targid
where
m.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> and m.initnum = <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5"> and m.userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> and m.mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
</cfquery>
<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="getinitcntcum">
select
count(seq) as cnt
from months mo2, months mo, monthly_initsum m inner join target_org t on m.seq = t.targid
where
mo.mon_num=m.mon
and mo.year2 = m.year2
and m.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
and m.initnum = <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
and m.userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
and mo2.mon_num = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
and mo.rank <= mo2.rank
and mo.year2 = mo2.year2
and seq <> 0
</cfquery>
<cfif isdefined("form.return") and #form.return# is 'Save and return to Monthly Reporting' and (isdefined("form.stop") and #form.stop# is not 1)>
 <cflocation url="monthrep.cfm">
</cfif>
<cfform name="wrk" action="">
<input type="hidden" name="stop" value = 0>
<cfif isDefined("form.boolLaw") and form.boollaw NEQ ""><cfset attributes.boolLaw = #form.boolLaw#></cfif>
<cfif isDefined("form.specLawTxt") and #form.speclawtxt# is not ''><cfset attributes.specLawTxt = #form.specLawTxt#></cfif>
<cfif isDefined("form.boolSuperPol")><cfset attributes.boolSuperPol = #form.boolSuperPol#></cfif>
<cfif isDefined("form.specSuperActTxt") and #form.specSuperActTxt# is not ''><cfset attributes.specSuperActTxt = #form.specSuperActTxt#></cfif>
<cfif isDefined("url.target")>
<cfif url.target EQ "commmob">
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QgettargCommmob">
	select 	*
	from monthly_commmob
	where
	userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and monthlycommmobid = <cfqueryparam value="#url.seq#" cfsqltype="CF_SQL_INTEGER">
</cfquery>
<input type="hidden" name="targid0" value="<cfoutput>#url.seq#"</cfoutput>>
<cfelseif url.target EQ "pos">
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QgettargPOSx">
	select *
	from monthly_pos
	where userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
	and initnum = <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	and  monthlyid = <cfqueryparam value="#url.seq#" cfsqltype="CF_SQL_INTEGER">
</cfquery>
<input type="hidden" name="targid0a" value="<cfoutput>#url.seq#"</cfoutput>>
<cfset form.lbody = QgettargPOSx.lbody>
<cfset form.jurName = QgettargPOSx.jurName>
<cfset form.vaddressed1 = QgettargPOSx.vaddressed1>
<cfset form.vaddressed2 = QgettargPOSx.vaddressed2>
<cfset form.boolpassed = QgettargPOSx.boolpassed>
<cfset form.coupon = QgettargPOSx.coupon>
<cfset form.jurNum = QgettargPOSx.jurNum>
<cfset form.policylink = QgettargPOSx.policylink>
<cfset form.policydesc = QgettargPOSx.policydesc>
<cfset form.cntrcAgree = QgettargPOSx.cntrcAgree>
<cfset form.cntrcAgree2 = QgettargPOSx.cntrcAgree2>
<cfset form.txtconcerns = QgettargPOSx.txtconcerns>
<cfset form.county = QgettargPOSx.county>
<cfelseif url.target EQ "gov">
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QgettargX">
	select 	*
	from monthly_org
	where
	userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and initnum=<cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	and monthlyorgid = <cfqueryparam value="#url.seq#" cfsqltype="CF_SQL_INTEGER">
	and stratnum = 2
</cfquery>
<input type="hidden" name="targid01" value="<cfoutput>#url.seq#</cfoutput>">
<cfelseif url.target EQ "advadv">
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QgettargXXa">
	select 	*
	from monthly_org
	where userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
	and initnum = <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	and monthlyorgid= <cfqueryparam value="#url.seq#" cfsqltype="CF_SQL_INTEGER">
</cfquery>
<input type="hidden" name="targid02a" value="<cfoutput>#url.seq#"</cfoutput>>
<cfelseif url.target EQ "comm">
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QgettargXX">
	select 	*
	from monthly_comm
	where
	userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and initnum=<cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	and monthlycommid = <cfqueryparam value="#url.seq#" cfsqltype="CF_SQL_INTEGER">
</cfquery>
<input type="hidden" name="targid02" value="<cfoutput>#url.seq#"</cfoutput>>
<cfelseif url.target EQ "media">
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QgettargXXXS">
	select 	*
	from monthly_media
	where
	userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and initnum=<cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	and monthlymediaid = <cfqueryparam value="#url.seq#" cfsqltype="CF_SQL_INTEGER">
</cfquery>
<input type="hidden" name="targid03" value="<cfoutput>#url.seq#"</cfoutput>>
</cfif>
<cfelseif isDefined("form.targ2") and form.targ2 NEQ "" and not IsDefined("form.addgovernment")>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QgettargX">
	select 	*
	from monthly_org
	where
	userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and initnum=<cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	and org = <cfqueryparam value="#form.targ2#" cfsqltype="CF_SQL_INTEGER">
	and mon=<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
	and stratnum = 2
</cfquery>
<input type="hidden" name="targid01" value="<cfoutput>#form.targ2#</cfoutput>">
</cfif>
<cfif isDefined("form.targ2a") and form.targ2a neq "" and Not isDefined("form.addcommmob") and not isdefined("url.seq")>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QgettargCommmob">
	select 	*
	from monthly_commmob
	where
	userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and mon=<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
	and target = <cfqueryparam value="#form.targ2a#" cfsqltype="CF_SQL_INTEGER">
</cfquery>
</cfif>
<cfif isDefined("form.targ7") and form.targ7 neq "" and Not isDefined("form.addcc") and not(isDefined("form.target") and form.target EQ "advadv")>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QgettargXXa">
	select 	*
	from monthly_org
	where userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
	and initnum = <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	and org = <cfqueryparam value="#form.targ7#" cfsqltype="CF_SQL_INTEGER">
</cfquery>
<cfif QgettargXXa.recordcount NEQ 0 and not isDefined("url.target")>
<input type="hidden" name="targid02a" value="<cfoutput>#form.targ7#"</cfoutput>>
		<cfset form.targ7 = "#QgettargXXa.org#">
		<cfset form.adcomm = "#QgettargXXa.adcomm#">
		<cfset form.prvtrain = "#QgettargXXa.prvtrain#">
		<cfset form.techass1 = "#QgettargXXa.techass#">
</cfif>
</cfif>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="Qgovtorg">
select
	*
	from monthly_org tor inner join target_org t on tor.org = t.targid and tor.year2 = t.year2
	where
	tor.userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and tor.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and tor.initnum=<cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	and tor.mon=<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
	and tor.stratnum = 2
</cfquery>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="Qcommorg">
select
	*
	from monthly_comm tor
	where
	tor.userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and tor.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and tor.initnum=<cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	and tor.mon=<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
</cfquery>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="Qmediaorg">
select
	*
	from monthly_media tor
	where
	tor.userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and tor.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and tor.initnum=<cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	and tor.mon=<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
</cfquery>
<input type="hidden" name="dofunction" value="">
<cfoutput>
<input type="hidden" name="objy" value="#session.objval#">
<input type="hidden" name="modality" value="#session.modality#">
</cfoutput>
	  <tr><td><table class="boxs" width=775>
			  <tr>
	  <cfoutput>
		<td align="left"><h3>#getobj.initiative# Monthly Report for #session.mon#</h4>
	</td>
	  </tr>
</cfoutput>
		  <cfif isdefined("session.objval") and #session.objval# is not '6B' and #session.objval# is not '2d' and session.objval is not '2e' and session.objval is not '4f' and session.objval is not '3m' and session.modality NEQ 6>
		  		<tr><td height=10></td></tr>
	  <tr>
		<td align="left"><strong>Objective:</strong>   <cfoutput><cfif #session.modality# is 1>#getobj.cc#<cfelseif #session.modality# is 2>#getobj.cp#<cfelseif #session.modality# is 3>#getobj.yp#<cfelseif #session.modality# is 5>#getobj.aa#<cfelse></cfif></cfoutput>
	</td>
	  </tr>
		</cfif></table></td></tr>
	  <tr><td><table class="boxs">
	  		<tr><td height=10></td></tr>
	<cfif session.modality NEQ 6>
		<th align="left">SMART outcomes:</th>
	</cfif>
	  </tr>
	  <tr>
	  	<td width=775><input type="hidden" name="SO" value=1>
<cflock
   timeout = "25"
   scope = "Application"
   type = "exclusive ">
			<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="so">
	select s.sonum, s.sotext_mon, isnull(so1,' ') as so1,isnull(so2,' ') as so2
	from smartoutcome s left outer join smartoutcomes so
	on s.initnum = so.initnum and s.sonum = so.sonum
	and s.year2 = so.year2
	and userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> and so.year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	where
	s.initnum = <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	and modality  = <cfqueryparam value="#session.modality#" cfsqltype="CF_SQL_INTEGER">
	and s.year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	order by s.sonum
</cfquery>
			<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="sout">
	select *
	from wrkplan_outcome
	where
	userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and initnum = <cfqueryparam value="#session.objnum#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	and year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
</cfquery>
<cfparam name="numPOSSCO" default="0">
<cfloop query="so">
	<cfif session.modality EQ 2 AND session.objval EQ  '2d' AND so.soNum EQ '1b'>
		<cfset numPOSSCO = #so.so1#>
	</cfif>
<cfset txt = #Replace("#so.sotext_mon#","''","#so.so1#","ONE")#>
<cfset txt2 = #Replace("#txt#","''","#so.so2#","ONE")#>
<!--- <cffile action="write"
	file="\\pubfile01\nytobaccomx\htdocs\prod\helpme2.txt"
	output="#txt2# " addnewline="yes">
<cfinclude template="helpme2.txt"> --->
<cfoutput>#txt2#</cfoutput>
</cfloop>
</cflock>
<cfoutput><p>
<cfif sout.recordcount is not 0>
<strong>Additional outcomes:</strong><br>
<cfloop query="sout">
#sout.outcometxt#<br></cfloop></cfif>
<cfif #getverk.advoc# is 1 or #getverk.govt# is 1 or #getverk.comm# is 1 or #getverk.media# is 1 or #getverk.commmob# is 1>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="Qadvorg">
select
	*
	from monthly_org tor inner join target_org t on tor.org = t.targid and tor.year2 = t.year2
	where
	tor.userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and tor.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and tor.initnum=<cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	and tor.mon=<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
	and tor.stratnum=1
</cfquery>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="Qgovtorg">
select
	*
	from monthly_org tor inner join target_org t on tor.org = t.targid and tor.year2 = t.year2
	where
	tor.userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and tor.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and tor.initnum=<cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	and tor.mon=<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
	and tor.stratnum = 2
	order by name
</cfquery>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="Qcommorg">
select
	*
	from monthly_comm tor
	where
	tor.userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and tor.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and tor.initnum=<cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	and tor.mon=<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
	order by target
</cfquery>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="Qmediaorg">
select
	*
	from monthly_media tor
	where
	tor.userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and tor.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and tor.initnum=<cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	and tor.mon=<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
	order by mediatype
</cfquery>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="Qcommob">
	select c.monthlycommmobid, case c.target when 0 then 'Unaffiliated youth' else  t.name end as target, case isNull(commed,0) when 1 then 'Yes' else 'No' end as commed,targdisp,
	case isNull(advoc,0) when 1 then 'Yes' else 'No' end as advoc,
case isNull(gpme,0) when 1 then 'Yes' else 'No' end as gpme,
case isNull(youth, 0) when 1 then 'Yes' else 'No' end as youth, descr
	from monthly_commmob c
	left outer join target_org t on c.target=t.targid
	where c.userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and (c.target=0 or isNull(t.name, '') != '')
	and c.year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and c.mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
	and c.initnum = <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	order by  case c.target when 0 then 'Unaffiliated youth' else  ltrim(rtrim(t.name)) end
	</cfquery>
<cfif #getverk.dispar# is 1>
<tr><td>
<p><strong>This initiative is part of a Disparities Project.</strong></p>
</td></tr>
</cfif>
<cfif session.modality EQ 3 and attributes.obj2 eq '2l'>
<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="getPer">
	select count(*) as cnt
from monthly_initsum m inner join target_org t on m.seq = t.targid
where
m.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> and m.initnum = '2l' and m.userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> and m.mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
</cfquery>
<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="getPercum">
select
count(seq) as cnt
from months mo2, months mo, monthly_initsum m inner join target_org t on m.seq = t.targid
where
mo.mon_num=m.mon
and mo.year2 = m.year2
and m.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
and m.initnum = '2l'
and m.userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
and mo2.mon_num = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
and mo.rank <= mo2.rank
and mo.year2 = mo2.year2
and seq <> 0
</cfquery>
<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="so1z">
	select so1
from smartoutcomes
where
year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> and initnum = '2l' and userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> and Sonum = '2a'
</cfquery>
</cfif>
<cfif #session.objval# is '3m'>
<table class="boxs" width=775>
		 <tr><td height=10></td></tr>
		 <tr><th align="left"><a name="pos"></a><h6>Progress Toward Outcomes</th></tr>
</table>
</td></tr>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QtargorgSFOD">
select
	name, targid,targdisp
	from target_org tor left join wrkplan_targets t on tor.targnum = t.targetid and tor.year2 = t.year2
	left join counties c on tor.county = c.fips
	where
	userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and tor.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and initnum=<cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	and stratnum=1 and targid not in (select medout from monthly_pos6 where year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> and mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER"> and initnum = <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">)
</cfquery>
<tr><td>
<table class="boxy" border=".1" width=775>
<tr><td>Did a local media outlet implement a policy that protects youth from pro-tobacco marketing and imagery? </td></tr>
<tr><td>
<input type="radio" name="sfm" value="1" onClick="show_other('sfm1', 'hide');show_other('sfm2', 'show');"  <cfif mon.sfm is 1 or (isDefined("form.sfm") and form.sfm EQ 1) or (isDefined("url.sfm") and url.sfm EQ 1)>checked</cfif>>Yes<br>
<input type="radio" name="sfm" value="0" onClick="show_other('sfm1', 'show');show_other('sfm2', 'hide');" <cfif mon.sfm is 0 or (isDefined("form.sfm") and form.sfm EQ 0) or (isDefined("url.sfm") and url.sfm EQ 0)>checked</cfif>>No
</td></tr>
</table>
		<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="Qpos66">
	select
	*
	from monthly_pos6 m left join target_org tor on m.medout = targid
	where m.userid = '#session.userid#' and m.year2 = '#session.fy#' <cfif isdefined("url.targ")>
	and monthlyid = <cfqueryparam value="#url.targ#" cfsqltype="CF_SQL_INTEGER"></cfif>
	order by 2, name
</cfquery>
<div id="sfm1"  <cfif (not isdefined("form.sfm") or #form.sfm# is not 1)>style='display:none;'</cfif>>
<table class="boxy" border=".1" width=775>
<tr><td>
What specific activities related to the Smoke Free Media local policy outcome will be undertaken prior to your next monthly report?</td></tr>
<tr><td>
<textarea cols="148" rows="5" maxlength="1000" name="specSFODTxt2" onkeyup="countit80(this)">#mon.specsfodtxt2#</textarea>
</td></tr>
<tr><td>
<input type="button" value="Check Spelling" onClick="spell('document.wrk.specsfodtxt2.value')"></td></tr>
	      <tr>
      <td width="90%" valign="bottom"><div align="right" valign="bottom">This text field has a max of 1000 characters. Characters entered: <cfoutput><input type="text" value="#len(mon.specSFODTxt2)#" name="specSFODTxt2displaycount" size="4" style="border:0;" disabled></cfoutput></td>
    </tr>
</table>
</div>
<div id="sfm2"  <cfif (not isdefined("form.sfm") or #form.sfm# is not 0) and (not isdefined("mon.sfm") or #mon.sfm# is not 1)>style='display:none;'</cfif>>
<table class="boxy" border=".1" width=775>
	<tr>
		<td><strong>What local media outlet implemented the policy?</strong></td>
		<td><strong>Policy prohibits:</strong></td>
		<td><strong>Jurisdiction name</strong></td>
		<cfif session.fy GT 2014><td><strong>County</strong></td></cfif>
	</tr>
<tr>
		<td>
		<cfif isdefined("qpos66.recordcount") and qpos66.recordcount GT 0>
		<select name="medout"><option value="#qpos66.targid#">#qpos66.name#</option></select>
		<cfelse>
		<cfselect name="medout" query="QtargorgSFOD" queryposition="below" display="name" value="targid">
		  <option value="">Please select</option>
		</cfselect>
		</cfif>
		</td>
		<cfif isdefined("qpos66.monthlyid")>
<input type="hidden" name="monthlyid" value="#qpos66.monthlyid#"></cfif>
		<td nowrap="yes">
		<input name="polprohib1" type = "checkbox" value="1" <cfif form.polprohib1 is 1 or (isdefined("qpos66.polprohib1") and qpos66.polprohib1 is 1)>checked</cfif>>Pro-tobacco marketing<br>
		<input name="polprohib2" type = "checkbox" value="1" <cfif form.polprohib2 is 1 or (isdefined("qpos66.polprohib2") and qpos66.polprohib2 is 1)>checked</cfif>>Pro-tobacco imagery<br>
		<input name="polprohib3" type = "checkbox" value="1" <cfif form.polprohib3 is 1 or (isdefined("qpos66.polprohib3") and qpos66.polprohib3 is 1)>checked</cfif>>Other: <br>
		<input type="text" name="polprohibtxt" <cfif isdefined("qpos66.polprohibtxt") and #qpos66.polprohibtxt# is not ''>value="#qpos66.polprohibtxt#"<cfelse>value="#form.polprohibtxt#" </cfif>>
		</td>
		<td>
		<input type="text" name="jurname3" <cfif isdefined("qpos66.jurname") and #qpos66.jurname# is not ''>value="#qpos66.jurname#"<cfelse>value="#form.jurname3#" </cfif>>
		</td>
		<cfif session.fy GT 2014>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="countyheadache">
select catchment
from contact
where userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
</cfquery>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="counties">
	select CountyName, FIPS from counties
	where FIPS in<cfif isDefined("countyheadache.catchment")>(#valuelist(countyheadache.catchment)#)<cfelse>(0)</cfif>
	order by 1
</cfquery>
<td>
<select name="county" multiple>
	  <cfloop query="counties">
		<option value="#fips#" <cfif isDefined("qpos66") and listfind(qpos66.county, fips)> selected</cfif>>#countyname#</option>
		</cfloop>
		</select>
</td>
	</cfif>
	</tr>
<cfif session.modality neq 2 or (session.fy lt 2016 and session.modality eq 2)>
<tr>
	<td colspan="3">
	<input name="sfmAgree" type = "checkbox" value="1" <cfif isdefined("qpos66.sfmAgree") and  qpos66.sfmAgree is 1>checked</cfif>> Check here to indicate that <cfoutput>#session.orgName#</cfoutput> agrees to submit a written copy of the policy to Alison Rhodes-Devey (Alison.Rhodes-Devey@health.ny.gov) and copy your Contract Manager
	</td>
</tr>
</cfif>
</table>
<table class="boxy" border=".1" width=775>
<tr><td>
<cfif isDefined("url.targ")>
		<input type="submit" name="addPOS6" value="Update" class="AddButton" onClick="return checkMOG();">
	<cfelse>
		<input type="submit" name="addPOS6" value="Add" class="AddButton" onClick="return checkMOG();">
	</cfif>
</td></tr>
</table>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="Qpos6">
select
	*
	from monthly_pos6 m left join target_org tor on m.medout = targid
	where
	m.userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and m.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and m.initnum=<cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	and m.mon=<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
	order by 2, name
</cfquery>
<cfif qpos6.recordcount is not 0>
<table border=".1" class="box" width="775">
<tr>
	<th align="left">What local media outlet implemented the policy?</th><th align="left">Policy prohibits:</th><th align="left">Jurisdiction name</th>	<cfif session.fy GT 2014><th>County</th></cfif><th>Delete</th>
</tr>
<cfloop query="qpos6">
	<cfif isdefined("qpos6.county") and qpos6.county is not ''>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="counties">
	select CountyName, FIPS from counties
	where FIPS in (#county#)
	order by 1
</cfquery></cfif>
	<tr>
	<td valign="top" bgcolor="##E9FBEC"><a href="../month.cfm?targ=#monthlyid#&sfm=1##medout">#name#</a></td><td valign="top" bgcolor="##E9FBEC"><cfif #polprohib1# is 1>Pro-tobacco marketing<br></cfif><cfif #polprohib2# is 1>Pro-tobacco imagery<br></cfif><cfif #polprohib3# is 1>Other: #polprohibtxt#<br></cfif></td><td valign="top" bgcolor="##E9FBEC">#jurname#</td><cfif session.fy GT 2014><td bgcolor="##E9FBEC"><cfif isdefined("counties.countyname")>#valuelist(counties.countyName)#</cfif></td></cfif>
	<td bgcolor="##E9FBEC" align="center"><input type="Checkbox" name="Del_box16" value="#monthlyid#"></td>
	</tr>
</cfloop>
<tr><Td colspan=5>			<tr><td colspan=6 align="right"><input type="submit" name="del_targ" value="Delete" class="DelButton">
</td></tr>
</table>
</cfif></div>
</cfif>
<input type="hidden" name="strat">
<cfif isdefined("targs")>
<cfif session.fy LTE 2010 or
		(((session.fy GTE 2011 and attributes.obj2 EQ '4f')
			or attributes.obj2 eq '2l' or attributes.obj2 eq '3g'
			or (attributes.obj2 eq '2d' and session.modality NEQ 2 and session.modality NEQ 3)
			or attributes.obj2 eq '2m')
			or (session.modality eq 3 and (attributes.obj2 eq '2l' OR attributes.obj2 eq '3g')))>
<tr><td height=10></td></tr>
	  <th align="left">Initiative summary this month at-a-glance</th>
	  <tr><td><table class="boxy" border=".1" width=600>
<a name="targ"></a>	  <tr><td width="30%"></th><td>Goal</th><td>Reported this month</th><td>Cumulative</th></tr>
<cfif session.modality EQ 3 and attributes.obj2 eq '2l'>
	  <tr>	<td>
			## orgs providing permission to display info
		</td><td align="center">
		<input name="pol" type="text" size="4" maxlength="4" <cfif isDefined("so1z.so1")>value="#so1z.so1#"<cfelse>value=0</cfif>  readonly class="readonly">
</td>
<td align="center"><input name="polcnt" type="text" size="4" <cfif isdefined("getPer.cnt")>value="#getPer.cnt#"<cfelse>value=0</cfif> readonly class="readonly"></td>
<td align="center"><input name="letter" type="text" size="4" <cfif isdefined("getPercum.cnt")>value="#getPercum.cnt#"<cfelse>value=0</cfif> readonly class="readonly"></td>
</tr>
<cfelse>
<cfif attributes.obj2 EQ '4f'>
<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="so1z">
	select so1
from smartoutcomes
where
year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> and initnum = <cfqueryparam value="#session.objnum#" cfsqltype="CF_SQL_VARCHAR" maxlength="5"> and userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> and sonum = '1a'
</cfquery>
<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="numCnties">
select catchment from contact
where userid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#session.userid#">
</cfquery>
<cfset numCnt=listlen(numCnties.catchment)>
<cfif session.modality EQ 2 and session.fy LT 2012>
<cfif isdefined("pol") and #pol# is not ''>
<cfset pol=pol*numCnt>
<cfelse>
<cfset pol = 0>
</cfif>
<cfset rez=rez*numCnt>
</cfif>
</cfif>
<cfif session.fy GT 2011>
<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="getinitcnt">
	select sum(isNull(m.number,0)) as cnt
from monthly_initsum m inner join target_org t on m.seq = t.targid
where
m.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> and m.initnum = <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5"> and m.userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> and m.mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
</cfquery>
<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="getinitcntcum">
select
sum(isNull(m.number,0)) as cnt
from months mo2, months mo, monthly_initsum m inner join target_org t on m.seq = t.targid
where
mo.mon_num=m.mon
and mo.year2 = m.year2
and m.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
and m.initnum = <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
and m.userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
and mo2.mon_num = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
and mo.rank <= mo2.rank
and mo.year2 = mo2.year2
and seq <> 0
</cfquery>
<tr>	<td>
			Number of units
		</td><td align="center">
		<input name="pol"  <cfif isDefined("so1z.so1")>value="#so1z.so1#"<cfelse>value=0</cfif> type="text" size="4" maxlength="4" readonly class="readonly">
</td>
<td align="center"><input name="polcnt" type="text" size="4" <cfif #chg# is 'Policy' and isdefined("getinitcnt.cnt")>value="#getinitcnt.cnt#"<cfelse>value=0</cfif> readonly class="readonly"></td>
<td align="center"><input name="letter" type="text" size="4" <cfif #chg# is 'Policy' and isdefined("getinitcntcum.cnt")>value="#getinitcntcum.cnt#"<cfelse>value=0</cfif> readonly class="readonly"></td>
</tr>
<cfelse>
	  <tr>	<td>
			Policies/ordinances
		</td><td align="center">
		<input name="pol" type="text" size="4" maxlength="4" value="#pol#" readonly class="readonly">
</td>
<td align="center"><input name="polcnt" type="text" size="4" <cfif #chg# is 'Policy' and isdefined("getinitcnt.cnt")>value="#getinitcnt.cnt#"<cfelse>value=0</cfif> readonly class="readonly"></td>
<td align="center"><input name="letter" type="text" size="4" <cfif #chg# is 'Policy' and isdefined("getinitcntcum.cnt")>value="#getinitcntcum.cnt#"<cfelse>value=0</cfif> readonly class="readonly"></td>
</tr>
	  <tr>	<td>
			Resolutions
		</td><td align="center">
		<input name="rez" type="text" size="4" maxlength="4" value="#rez#" <cfif #rez# is 0>readonly</cfif> class="readonly">
</td>
<td align="center"><input name="a" type="text" size="4" maxlength="4"  <cfif #chg# is 'Resolution' and isdefined("getinitcnt.cnt")>value="#getinitcnt.cnt#"<cfelse>value=0</cfif> readonly class="readonly" value=0></td>
<td align="center"><input name="b" type="text" size="4" maxlength="4" <cfif #chg# is 'Resolution' and isdefined("getinitcntcum.cnt")>value="#getinitcntcum.cnt#"<cfelse>value=0</cfif> readonly class="readonly" value=0></td>
</tr>
</cfif>
</cfif>
</table>
</cfif>
<tr><td height=10></td></tr>
<cfif session.fy LTE 2010
		or ((session.modality eq 2 and attributes.obj2 eq '4f')
			or NOT(((session.modality EQ 2 or session.modality EQ 3) and attributes.obj2 EQ '2d')
				or  (session.modality EQ 5 and attributes.obj2 eq '2e'))
					and NOT(session.modality EQ 3 and attributes.obj2 eq '2e') and NOT(session.modality EQ 2 and attributes.obj2 eq '2e'))>
	  <th align="left"><a name="pro"></a><cfif session.fy LT 2012 or (session.fy GTE 2012 and attributes.obj2 NEQ '4F')>Policies, resolutions, and ordinances this month<cfelse>Policies this month</cfif></th>
	  <tr><td><table class="boxy" border=".1">
	  <tr><td><strong>Org name</strong></td>
	  <cfif session.fy GT 2014><td align="center"><strong>Local Housing Authority?</strong></td></cfif>
	  <cfif (session.modality eq 3 and session.objval is '3g') or (session.modality eq 5 and (session.objval is '2d' or session.objval is '2m'))>
		  <td><strong>Change</strong></td>
		</cfif>
		  <td><strong>Description</strong></td>
		<cfif session.fy GT 2011 and session.modality EQ 2 and attributes.obj2 EQ '4f'><td><strong>Exact number of units covered</strong></td><cfif session.fy gt '2014'><td><strong>County/ies</strong></td></cfif></cfif>
		</tr>
	  <tr>	<td>
			<select name="targ999" onChange="javascript: document.wrk.action='month.cfm?#session.urltoken###targ'; form.submit();" >
	  		<option value="">Please select</option>
<cfif session.fy GTE 2012 and session.modality EQ 2 and attributes.obj2 EQ '4f'>
<cfloop query="targmi">
		<option value="#targid#" <cfif (isDefined("QSelIG2") and  QSelIG2.seq EQ targmi.targid) or (isDefined("form.targ999") and form.targ999 EQ targmi.targid and not isDefined("form.addpolicy"))> selected</cfif> ><cfif #targdisp# is 1>*</cfif>#name#</option>
</cfloop>
<cfelse>
<cfloop query="gettarg">
		<option value="#targid#"  <cfif (isDefined("QSelIG2") and  QSelIG2.seq EQ gettarg.targid) or (isDefined("form.targ999") and form.targ999 EQ gettarg.targid and not isDefined("form.addpolicy"))> selected</cfif>><cfif #targdisp# is 1>*</cfif>#name#</option>
</cfloop>
</cfif>		</select>
		</td>
		 <cfif session.fy GT 2014><td align="center"><input type="checkbox"<cfif (isDefined("QSelIG2") and  QSelIG2.lha EQ 1)> checked</cfif> name="lha" value="1"></td></cfif>
		<cfif session.modality eq 3 and session.objval is '3g'><td><select name="chg"><option value="">Resolution</option></select></th><cfelseif session.modality eq 5 and (session.objval is '2d' or session.objval is '2m')><td valign="top">Policy</th></cfif>
<td align="left" valign="top">
<cfif NOT(session.modality eq 5 and attributes.obj2 eq '2e')><!--- TEMP DELETE --->
<cfif isdefined("option1_txt") and option1_txt NEQ "">
<cfif session.objval is '2d'>
		<input name="option1" type="hidden" value=1>#option1_txt#
		<cfelse>
		<input name="option1" type="checkbox" value=1 <cfif isDefined("QSelIG2") and  QSelIG2.option1_value EQ 1> checked</cfif>> #option1_txt#
		</cfif>
</cfif>
<cfif isdefined("option2_txt") and option2_txt NEQ "">
		<br><input name="option2" type="checkbox" value=1 <cfif isDefined("QSelIG2") and  QSelIG2.option2_value EQ 1> checked</cfif>> #option2_txt#
</cfif>
<cfif isdefined("option3_txt") and option3_txt NEQ "">
		<br><input name="option3" type="checkbox" value=1 <cfif isDefined("QSelIG2") and  QSelIG2.option3_value EQ 1> checked</cfif>> #option3_txt#
</cfif>
<cfif isdefined("option4_txt") and option4_txt NEQ "">
		<br><input name="option4" type="checkbox" value=1 <cfif isDefined("QSelIG2") and  QSelIG2.option4_value EQ 1> checked</cfif>> #option4_txt#
</cfif>
<cfif isdefined("option5_txt") and option5_txt NEQ "">
		<br><input name="option5" type="checkbox" value=1 <cfif isDefined("QSelIG2") and  QSelIG2.option5_value EQ 1> checked</cfif>> #option5_txt#
		</cfif>
<cfif isdefined("option6_txt") and option6_txt NEQ "">
		<br><input name="option6" type="checkbox" value=1 <cfif isDefined("QSelIG2") and  QSelIG2.option6_value EQ 1> checked</cfif>> #option6_txt#
</cfif>
<cfif isdefined("option7_txt") and option7_txt NEQ "">
		<br><input name="option7" type="checkbox" value=1 <cfif isDefined("QSelIG2") and  QSelIG2.option7_value EQ 1> checked</cfif>> #option7_txt#
</cfif>
<cfif isdefined("option8_txt") and option8_txt NEQ "">
		<br><input name="option8" type="checkbox" value=1 <cfif isDefined("QSelIG2") and  QSelIG2.option8_value EQ 1> checked</cfif>> #option8_txt#
</cfif>
<cfelse>
<cfif isdefined("option1_txt") and option1_txt NEQ "">
		<input name="option1" type="checkbox" value=1 <cfif isDefined("QSelIG2") and  QSelIG2.option1_value EQ 1> checked</cfif>> #option1_txt#
		</cfif>
<cfif isdefined("option2_txt") and option2_txt NEQ "">
		<br><input name="option2" type="checkbox" value=1 <cfif isDefined("QSelIG2") and  QSelIG2.option2_value EQ 1> checked</cfif>> #option2_txt#
</cfif>
<cfif isdefined("option3_txt") and option3_txt NEQ "">
		<br><input name="option3" type="checkbox" value=1 <cfif isDefined("QSelIG2") and  QSelIG2.option3_value EQ 1> checked</cfif>> #option3_txt#
</cfif>
<cfif isdefined("option4_txt") and option4_txt NEQ "">
		<br><input name="option4" type="checkbox" value=1 <cfif isDefined("QSelIG2") and  QSelIG2.option4_value EQ 1> checked</cfif>> #option4_txt#
</cfif>
</cfif>
<!--- <cfif session.modality eq 5 and url.obj eq '4f'>
<!--- TEMP DELETE THIS --->
<br><input name="option50" type="checkbox" value=1> Prohibit smoking in indoor common areas
<br><input name="option51" type="checkbox" value=1> Prohibit smoking in outdoor common areas
<br><input name="option52" type="checkbox" value=1> Fewer than 10 units
<br><input name="option53" type="checkbox" value=1> 11-25 units
<br><input name="option54" type="checkbox" value=1> 26-50 units
<br><input name="option55" type="checkbox" value=1> More than 50 units
</cfif> --->
<cfif isdefined("opntxt") and #opntxt# is 1><input type="text" size=50 name="opntxt" maxlength=50></cfif>
<!---(#session.modality# is 3 and (#session.objval# is '2l' or #attributes.obj2# is '2l')) or (#session.modality# is 5 and #session.objval# is not '2d' and #attributes.obj2# is not '2d')--->
<cfif #permisss# eq 1><input type="hidden" value=1 name="permiss"> Permission to display info</cfif>
</td>
<cfif session.fy GT 2011 and session.modality EQ 2 and attributes.obj2 EQ '4f'><td align="center"><input type="text" name="numUnits" size="3"  <cfif isDefined("QSelIG2")> value = "#QselIG2.number#"</cfif>></td></cfif>
				<cfif session.fy GT 2014>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="countyheadache">
select catchment
from contact
where userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
</cfquery>
<cfif session.fy GT 2014>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="countyheadache">
select catchment
from contact
where userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
</cfquery>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="counties">
	select CountyName, FIPS from counties
	where FIPS in<cfif isDefined("countyheadache.catchment")>(#valuelist(countyheadache.catchment)#)<cfelse>(0)</cfif>
	order by 1
</cfquery>
<td>
<select name="county" multiple>
	  <cfloop query="counties">
		<option value="#fips#" <cfif isDefined("QSelIG2") and listfind(QSelIG2.county, fips)> selected</cfif>>#countyname#</option>
		</cfloop>
		</select>
</td>
	</cfif>
	</cfif>
<cfif session.modality neq 2 or (session.fy lt 2016 and session.modality eq 2)>
<tr>
	<td colspan=5>
	<input name="cntrcAgree2" type = "checkbox" value="1" <cfif form.cntrcAgree2 is 1 or (isDefined("QSelIG2") and #qselig2.cntrcagree2# is 1)>checked</cfif>> Check here to indicate that <cfoutput>#session.orgName#</cfoutput> agrees to submit a written copy of the <strong>policy</strong> to Alison Rhodes-Devey (Alison.Rhodes-Devey@health.ny.gov) and copy your Contract Manager
	</td>
</tr></cfif>
		</tr>
		<tr>
	<td colspan=5>
		Brief description:
		&nbsp;<textarea name="policydesc" cols="100" rows="5" align="left"><cfif isdefined("QSelIG2")>#ltrim(qselig2.policydesc)#</cfif></textarea>
	</td>
</tr>
<tr><Td colspan=5>
	 <cfif (isDefined("QSelIG2") and QSelIG2.recordcount NEQ 0) and  not isDefined("form.addpolicy")>
		<input type="submit" name="addpolicy" value="Update" class="AddButton" onClick="return checkIG();">
	 <cfelse>
		<input type="submit" name="addpolicy" value="Add" class="AddButton" onClick="return checkIG();">
	</cfif>
</td></tr>
<cfif isdefined("getinit.recordcount") and getinit.recordcount is not 0>
<tr>
<td colspan="4">
<table border=".1" class="box" width="100%">
<tr>
	<th align="left">Org Name</th>
	<cfif session.fy GT 2014><th align="left">Local Housing Authority?</th></cfif>
	<cfif session.modality eq 3 and session.objval is '2l'><cfelseif session.fy GTE 2012 and session.objval EQ '4f'><cfelse><th>Change</th></cfif>
	<th align="left">Description</th>
	<cfif isdefined("permisss") and #permisss# eq 1><th align="left"></th></cfif>
	<cfif session.fy GT 2011 and session.modality EQ 2 and attributes.obj2 EQ '4f'><th>Exact number of units covered</th><cfif session.fy gt '2014'><th>County/ies</th></cfif></cfif>
	<th>Delete</th>
</tr>
<cfloop query="getinit">
	<cfif getinit.county is not ''>
	<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="counties">
	select CountyName, FIPS from counties
	where FIPS in<cfif isDefined("getinit.county")>(#getinit.county#)<cfelse>(0)</cfif>
	order by 1
</cfquery></cfif>
	<tr>
	<td valign="top" bgcolor="##E9FBEC"><a href="javascript: document.wrk.action='month.cfm?#session.urltoken#&target=updIG&seq=#getinit.seq###targ'; document.wrk.submit()"><cfif #targdisp# is 1>*</cfif>#getinit.name#</a></td>
	<cfif session.fy GT 2014><td valign="top" bgcolor="##E9FBEC"><cfif isdefined("lha") and #lha# is not ''>Yes</cfif></td></cfif>
	<cfif session.modality eq 3 and session.objval is '2l'>
	<cfelseif session.fy GTE 2012 and session.objval EQ '4f'>
	<cfelse>
	<td valign="top" bgcolor="##E9FBEC"><cfif getinit.targnum EQ '11'>Ordinance<cfelse>#chg#</cfif></td>
	</cfif>
	<td valign="top" bgcolor="##E9FBEC"><cfif isdefined("getinit.option1_value") and isdefined("option1_txt") and #getinit.option1_value# is 1>#option1_txt#<br></cfif><cfif #getinit.option2_value# is 1 and isdefined("option2_txt")>#option2_txt#<br></cfif><cfif #getinit.option3_value# is 1>#option3_txt#<br></cfif>
	<cfif isdefined("getinit.option4_value") and isdefined("option4_txt") and #getinit.option4_value# is 1>#option4_txt#<br></cfif>
	<cfif isdefined("getinit.option5_value") and isdefined("option5_txt") and #getinit.option5_value# is 1>#option5_txt#<br></cfif>
	<cfif isdefined("getinit.option6_value") and isdefined("option6_txt") and #getinit.option6_value# is 1>#option6_txt#<br></cfif>
	<cfif isdefined("getinit.option7_value") and isdefined("option7_txt") and #getinit.option7_value# is 1>#option7_txt#<br></cfif>
	<cfif isdefined("getinit.option8_value") and isdefined("option8_txt") and #getinit.option8_value# is 1>#option8_txt#</cfif>
	<cfif isdefined("getinit.opentxt")>#getinit.opentxt#</cfif></td>
	<cfif isdefined("permisss") and #permisss# eq 1><td valign="top" bgcolor="##E9FBEC"><cfif #getinit.permiss# EQ 1 and isdefined("permisss") and #permisss# EQ 1>Permission to display info</cfif></td></cfif>
	<cfif session.fy GT 2011 and session.modality EQ 2 and attributes.obj2 EQ '4f'><td align="center">#getinit.number#</td></cfif>
	<cfif session.fy GT 2014><td valign="top" bgcolor="##E9FBEC"><cfif isdefined("counties.countyname")>#valuelist(counties.countyName)#</cfif>
	</td></cfif>
	<td bgcolor="##E9FBEC" align="right"><input type="Checkbox" name="Del_box8" value="#getinit.seq#"></td>
	</tr>
</cfloop>
<tr><Td colspan=5>			<tr><td colspan=6 align="right"><input type="submit" name="del_targ" value="Delete" class="DelButton">
</td></tr>
</table>
</th>
</tr></cfif>
</table>
		</cfif>
<cfif session.fy GT 2017 and session.objval EQ '4F'>
<cfif isDefined("url.target") and URL.TARGET EQ "hud">
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="Qgethud">
select
*
from HUD h left join pha p on h.hud_target = p.phaid
where hud_target = '#url.seq#' and year2 = '#session.fy#' and mon = '#session.monum#'
and userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
</cfquery>
<cfif Qgethud.recordcount NEQ 0>
	<cfset hud_target=#qgethud.hud_target#>
	<cfset hud_notes=#qgethud.hud_notes#>
	<cfset units=#qgethud.units#>
	<cfset dt=#qgethud.dt#>
</cfif>
</cfif>
		<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QPHAlist">
				select
  distinct phaid, name
  --c.userid, c.countylist, p.*
  from pha p, contact c where
  c.countylist like '%' + p.county + '%'
	and userid= <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and phaid not in (select hud_target from hud where userid = '#session.userid#' and year2 = '#session.fy#' and mon = '#session.monum#')
  order by 2
</cfquery>
		<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="Qhud">
				select hud_target,seq,name,phaid
				from
				 HUD h inner join pha p on h.hud_target = p.phaid
where
userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
and year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
and mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
</cfquery>
					<tr>
					<td align="left" width="800">
						<a name="hud">
						</a><br><h6>Fully HUD-funded Properties</td></tr>
						<table class="boxy" width=800>
							<tr>
								<th width="250">
									Target Name
								</th>
								<th width="250">
									## of Units
								</th>
								<th width="250">
									Implementation Date
								</th>
								<th colspan="2">
									Description of Activity
								</th>
							</tr>
							<tr>
								<td>
									<select name="HUD_target">
									<option value="">
										Please select
									</option>
										<cfoutput>
										<cfloop query="QPHAlist"> <!--- #id#  --->

										<option value="#phaid#"
										<cfif isdefined("url.seq") and isdefined("url.target") and url.target is 'hud'>
										<cfif url.seq eq #phaid#>
										selected
										</cfif></cfif>
											>
											#name#
										</option>
									</cfloop>
									</cfoutput>


									</select>
								</td>
								<td align="center">
								<input type="text" name="units" size="3"  <cfif isDefined("units") and isdefined("url.target") and url.target is 'hud'> value = "#units#"</cfif>>
								</td>	
								<td align="center">
								<input type="text" name="dt" id="dt" <cfif isdefined("dt") and isdefined("url.target") and url.target is 'hud'>value="#dateformat(dt,'mm/dd/yyyy')#"</cfif> size=10><br>mm/dd/yyyy
								</td>							
								<td colspan=2><cfoutput>
									<textarea name="HUD_notes" id="HUD_notes" cols=55 rows=4  onkeyup="countitAny(this.id, 'CHUD_notes')"><cfif isdefined("url.target") and #url.target# EQ "hud">#hud_notes#</cfif></textarea></cfoutput>
									<br>
									<div align="right" valign="bottom">
									This text field has a max of 2500 characters. Characters entered:
									<cfoutput>
										<input type="text" value="" name="CHUD_notes" id="CHUD_notes" size="4" style="border:0;" disabled>
									</cfoutput>
								</td>
								</tr>


				<tr>
								<Td colspan="4">
									<input type="button" value="Check Spelling" onClick="spell('document.wrk.HUD_notes.value')">
									<br>
									<input type="submit" name="add_HUD"
									<cfif isdefined("url.target") and url.target EQ "HUD">
										value="Update"
									<cfelse>
										value="Add"
									</cfif>
									class="AddButton" onClick="return checkHUD();">
									<br>
									<br>
								</td>
					</tr>
<cfif qhud.recordcount is not 0>
<tr><td colspan=4>
<table border=".1" class="box" width="775">
<tr>
	<td align="left">Target Name</td><td>Delete</td>
</tr>
					<cfoutput><cfloop query="Qhud">
	<tr>
		<td valign="top" bgcolor="##E9FBEC"><a href="javascript: document.wrk.action='month.cfm?#session.urltoken#&target=hud&seq=#phaid###hud'; document.wrk.submit()">#name#</a></td>
				<td valign="top" bgcolor="##E9FBEC" align="center"><input type="Checkbox" name="Del_box15" value="#seq#"></td>
	</tr>
</cfloop>
		<tr><td colspan=7 align="right"><input type="submit" name="del_targ" value="Delete" class="DelButton">
</cfoutput>

</td></tr></table>
</td></tr>
</cfif>
</cfif>

<cfif session.fy GT 2010 and
		(((session.modality is 2 or session.modality is 3) and (session.objval is '2e' or session.objval is '2d'))
			or (session.modality is 5 and session.objval is  '2e'))>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="Qpos">
select
	*, case lbody when 1 then 'Board of Health' when 2 then 'Municipality' when 3 then 'County' end as lb,
	case boolpassed when 1 then 'Yes' when 0 then 'No' end as bp,coupon,county,countyname
	from monthly_pos tor left join counties c on tor.county = c.fips
	where
	tor.userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and tor.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and tor.initnum=<cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	and tor.mon=<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
</cfquery>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="Qpos2">
select
	*,
	case when  poa like '%1%' then 'Policy to end sale of tobacco products <br>' else '' end +
	case when poa like '%2%' then 'Policy to reduce visibility of tobacco advertising and products<br>' else  '' end as poaz,
	case boolOtherStates when 1 then 'Yes' when 0 then 'No' end as bos
	from monthly_pos2 m left join target_org t on m.schainname = t.targid
	where
	m.userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and m.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and m.initnum=<cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	and m.mon=<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
</cfquery>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="Qpos3">
select
	*, case lbody2 when 1 then 'Board of Health' when 2 then 'Municipality' when 3 then 'County' end as lb,
	case boolpassed2 when 1 then 'Yes' when 0 then 'No' end as bp
	from monthly_pos3 m		left join counties c on m.county = c.fips
	where
	m.userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and m.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and m.initnum=<cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	and m.mon=<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
order by jurname2
</cfquery>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="Qpos4">
select
	*
	from monthly_pos4 m left join target_org tor on m.sforg = targid
	where
	m.userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and m.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and m.initnum=<cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	and m.mon=<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
	order by name
</cfquery>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="Qpos5">
select
	*
	from monthly_pos5 m left join target_org tor on m.sforg = targid
	where
	m.userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and m.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and m.initnum=<cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	and m.mon=<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
</cfquery>
<tr><td>
<table class="boxs" width=775>
		 <tr><td height=10></td></tr>
		 <tr><th align="left"><a name="pos"></a><h6>Progress Toward Outcomes</th></tr>
		 <tr><td height=10></td></tr>
</table>
</td></tr>
<cfif session.modality EQ 5 and session.objval EQ '2e'>
<tr><td height=10><br><br></td></tr>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QtargorgSFOD">
select
	name, targid,targdisp
	from target_org tor left join wrkplan_targets t on tor.targnum = t.targetid and tor.year2 = t.year2
	left join counties c on tor.county = c.fips
	where
	userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and tor.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and initnum=<cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	and stratnum=1
</cfquery>
<tr><td>
<table class="boxy" border=".1" width=775>
<tr><td>Was a tobacco-free outdoors policy adopted by an organization other than a jurisdiction during this month?</td></tr>
<tr><td>
<input type="radio" name="boolSFOP2" value="1" onClick="show_other('SFODFive', 'hide');show_other('SFODSix', 'show');"  <cfif mon.boolsfop2 is 1>checked</cfif>>Yes<br>
<input type="radio" name="boolSFOP2" value="0" onClick="show_other('SFODFive', 'show');show_other('SFODSix', 'hide');" <cfif mon.boolsfop2 is 0>checked</cfif>>No
</td></tr>
</table>
<div id="SFODFive">
<table class="boxy" border=".1" width=775>
<tr><td>What specific activities related to this policy outcome will be undertaken prior to your next monthly report?</td></tr>
<tr><td>
<textarea cols="148" rows="5" maxlength="1000" name="specSFODTxt2" onkeyup="countit80(this)">#mon.specsfodtxt2#</textarea>
</td></tr>
	      <tr>
      <td width="90%" valign="bottom"><div align="right" valign="bottom">This text field has a max of 1000 characters. Characters entered: <cfoutput><input type="text" value="#len(mon.specSFODTxt2)#" name="specSFODTxt2displaycount" size="4" style="border:0;" disabled></cfoutput></td>
    </tr>
</table>
</div>
<div id="SFODSix">
<table class="boxy" border=".1" width=775>
	<tr>
		<td><strong>Name of organization</strong></td>
		<td><strong>Policy prohibits smoking:</strong></td>
		<td><strong>Brief description</strong></td>
	</tr>
<tr>
		<td>
		<cfselect name="SForg" query="QtargorgSFOD" queryposition="below" display="name" value="targid">
	  <option value="">Please select</option>
		</cfselect>
		</td>
		<td nowrap="yes">
		<input name="SFPol1" type = "checkbox" value="1" <cfif form.sfpol1 is 1>checked</cfif>>At outdoor areas<br>
		<input name="SFPol2" type = "checkbox" value="1" <cfif form.sfpol2 is 1>checked</cfif>>Near entryways of buildings<br>
		<input name="SFPol3" type = "checkbox" value="1" <cfif form.sfpol3 is 1>checked</cfif>>At events<br>
		<input name="SFPol4" type = "checkbox" value="1" <cfif form.sfpol4 is 1>checked</cfif>>At parks and/or other venues
		</td>
		<td>
		<textarea name="SFPnMuniDesc" cols="73" rows="5">#form.sfpnmunidesc#</textarea>
		</td>
	</tr>
<cfif session.modality neq 2 or (session.fy lt 2016 and session.modality eq 2)>
<tr>
	<td colspan="3">
	<input name="cntrcAgreeSFPnMuni" type = "checkbox" value="1" <cfif form.cntrcAgreeSFPnMuni is 1>checked</cfif>> Check here to indicate that <cfoutput>#session.orgName#</cfoutput> agrees to submit a written copy of the <strong>policy</strong> to Cheryl Bellus (cab25@health.ny.gov) and copy your Contract Manager
	</td>
</tr>
</cfif>
</table>
<table class="boxy" border=".1" width=775>
<tr><td>
<input type="submit" name="addPOS5" value="Add" class="AddButton">
</td></tr>
</table>
</div>
</table>
</td></tr>
<cfif qpos5.recordcount is not 0>
<table border=".1" class="box" width="775">
<tr>
	<th align="left">Organization Name</th><th align="left">Policy prohibits smoking</th><th align="left">Brief description</th><th>Delete</th>
</tr>
<cfloop query="qpos5">
	<tr>
	<td valign="top" bgcolor="##E9FBEC">#name#</td><td valign="top" bgcolor="##E9FBEC"><cfif #sfpol1# is 1>At outdoor areas<br></cfif><cfif #sfpol2# is 1>Near entryways of buildings<br></cfif><cfif #sfpol3# is 1>At events<br></cfif><cfif #sfpol4# is 1>At parks and/or other venues<br></cfif></td><td valign="top" bgcolor="##E9FBEC">#sfpnmunidesc#</td>
	<td bgcolor="##E9FBEC" align="center"><input type="Checkbox" name="Del_box14" value="#monthlyid#"></td>
	</tr>
</cfloop>
<tr><Td colspan=5>			<tr><td colspan=6 align="right"><input type="submit" name="del_targ" value="Delete" class="DelButton">
</td></tr>
</table>
</cfif>
</cfif>
<!--- end of new insert --->
<cfif isdefined("session.objval") and #session.objval# EQ '2d'>
<input type="hidden" name="objval"  value="#attributes.obj2#">
<input type="hidden" name="obj2"  value="#attributes.obj2#">
<tr><td>
<table class="boxy" border=".1" width=775>
<tr><td>Was a Point of Sale law/regulation voted on by a lawmaking body during this month?</td></tr>
<tr><td>
<input type="radio" name="boolLaw" value="1" onClick="<!--- toggle_visibility0('coupon');--->show_other('posOne', 'hide');show_other('posTwo', 'show');" <cfif isDefined("form.boolLaw") and form.boolLaw EQ 1>checked<cfelseif attributes.boolLaw is 1>checked</cfif>>Yes<br>
<input type="radio" name="boolLaw" value="0" onClick="show_other('posOne', 'show');show_other('posTwo', 'hide');show_other('posThree', 'hide'); show_other('posFour', 'hide');" <cfif  isDefined("form.boolLaw") and form.boolLaw EQ 0>checked<cfelseif  attributes.boolLaw is 0>checked</cfif>>No
</td></tr>
</table>
<div id="posOne">
<table class="boxy" border=".1" width=775>
<tr><td>What specific activities related to the Point of Sale visibility/retailers <strong>law/regulation</strong> outcome/s will be undertaken prior to your next monthly report?</td></tr>
<tr><td>
<textarea cols="148" rows="5" maxlength="1000" name="specLawTxt" onkeyup="countit50(this)">#attributes.specLawTxt#</textarea>
</td></tr>
	      <tr>
      <td width="90%" valign="bottom"><div align="right" valign="bottom">This text field has a max of 1000 characters. Characters entered: <cfoutput><input type="text" value="#len(mon.specLawTxt)#" name="specLawTxtdisplaycount" size="4" style="border:0;" disabled></cfoutput></td>
    </tr>
</table>
</div>
<div id="posTwo" style='display:none;'>
<table class="boxy" border=".1" width=775>
	<tr>
		<td><strong>What lawmaking body voted on the law/regulation?</strong></td>
		<td><strong>Jurisdiction Name</strong></td>
		<cfif session.fy GT 2014><td><strong>County</strong></td></cfif>
		<td><strong>Vote addressed</strong></td>
		<td><strong>Was the law/regulation passed?</strong></td>
	</tr>
<tr>
		<td>
		<select name="lbody">
	  <option value="">Please select</option>
	  <option value=1 <cfif #form.lbody# is 1>selected</cfif>>Board of Health</option>
	  <option value=2 <cfif #form.lbody# is 2>selected</cfif>>Municipality</option>
	  <option value=3 <cfif #form.lbody# is 3>selected</cfif>>County</option>County
</select>
		</td>
		<td>
		<input type="text" name="jurName"  size="50" value="#form.jurname#">
		</td>
		<cfif session.fy GT 2014>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="countyheadache">
select catchment
from contact
where userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
</cfquery>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="counties">
	select CountyName, FIPS from counties
	where FIPS in<cfif isDefined("countyheadache.catchment")>(#valuelist(countyheadache.catchment)#)<cfelse>(0)</cfif>
	order by 1

</cfquery>
<td>
<select name="county">
		<cfif counties.recordcount gt 1><option value="">Please select</option></cfif>
	  <cfloop query="counties">
		<option value="#fips#" <cfif isDefined("form.county") and form.county EQ fips> selected</cfif>>#countyname#</option>
		</cfloop>
		</select>
</td>
	</cfif>
	<td nowrap="yes">
		<input name="vaddressed1" type = "checkbox" value="1" <cfif form.vaddressed1 is 1>checked</cfif>>POS&nbsp;visibility<br>
		<input name="vaddressed2" type = "checkbox" value="1" <cfif form.vaddressed2 is 1>checked</cfif>>POS&nbsp;retailers
<br>
	<input name="coupon" type = "checkbox" value="1" <cfif form.coupon is 1>checked</cfif>>Coupons/multi-packs
		</td>
		<td>
		<input type="radio"  name="boolPassed" value="1" onClick="show_other('posFour', 'show');show_other('posThree', 'hide');" <cfif form.boolPassed is 1>checked</cfif>>Yes<br>
		<input type="radio" name="boolPassed" value="0" onClick="show_other('posThree', 'show');show_other('posFour', 'hide');" <cfif form.boolPassed is 0>checked</cfif>>No
	</td>
	</tr>
</table>
<div id="posThree">
<table class="boxy" border=".1" width=775>
	<tr>
	<td>
		What concerns did the lawmaking body express regarding the proposed <strong>law/regulation</strong>?
	</td>
</tr>
<tr>
	<td>
	<textarea cols="120" rows="5" name="txtConcerns">#form.txtconcerns#</textarea>
	</td>
</tr>
<cfif session.modality neq 2 or (session.fy lt 2016 and session.modality eq 2)>
<tr>
	<td>
	<input name="cntrcAgree" type = "checkbox" value="1" <cfif form.cntrcAgree is 1>checked</cfif>> Check here to indicate that <cfoutput>#session.orgName#</cfoutput> agrees to submit a written copy of the proposed <strong>law/regulation</strong> to Alison Rhodes-Devey (Alison.Rhodes-Devey@health.ny.gov) and copy your Contract Manager
	</td>
</tr>
</cfif>
</table>
</div>
<div id="posFour">
<table class="boxy" border=".1" width=775>
<tr>
	<td>
		Approximately how many people reside in this jurisdiction?
		<input type="text" name="jurNum" size="7" value="#form.jurnum#">
	</td>
</tr>
<tr>
	<td>
		Link to policy:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="text" name="policylink" size="75" value="#form.policylink#">
	</td>
</tr>
<tr>
	<td>
		Brief description:
		&nbsp;<textarea name="policydesc" cols="100" rows="5">#form.policydesc#</textarea>
	</td>
</tr>
<cfif session.modality neq 2 or (session.fy lt 2016 and session.modality eq 2)>
<tr>
	<td>
	<input name="cntrcAgree2" type = "checkbox" value="1" <cfif form.cntrcAgree2 is 1>checked</cfif>> Check here to indicate that <cfoutput>#session.orgName#</cfoutput> agrees to submit a written copy of the <strong>law/regulation</strong> to Alison Rhodes-Devey (Alison.Rhodes-Devey@health.ny.gov) and copy your Contract Manager
	</td>
</tr>
</cfif>
</table>
</div>
<table class="boxy" border=".1" width=775>
<tr><td>
<input type="button" value="Check Spelling" onClick="spell('document.wrk.txtConcerns.value')"><br>
		<cfif ((not isDefined("form.addPOS") ) and ((isDefined("URL.target") and url.target EQ "POS") ))   >
			<input type="submit" name="addPOS" value="Update" class="AddButton" onClick="return pos3();">
		<cfelse>
			<input type="submit" name="addPOS" value="Add" class="AddButton" onClick="return pos3();">
		</cfif>
</td></tr>
</table>
</div>
</div>
</td></tr>
<cfif qpos.recordcount is not 0>
<table border=".1" class="box" width="775">
<tr>
	<th align="left">Jurisdiction Name</th>
	<cfif session.fy GT 2014><th align="left" width=100>County</th></cfif>
	<th align="left">Lawmaking Body</th>
	<th align="left">Vote Addressed</th>
	<th align="left">Law/Regulation Passed?</th>
	<th align="left">## in Jurisdiction</th>
	<th>Delete</th>
</tr>
<cfloop query="qpos">
	<tr>
	<td valign="top" bgcolor="##E9FBEC"><a href="javascript: document.wrk.action='month.cfm?#session.urltoken#&target=pos&seq=#monthlyid###pos'; document.wrk.submit()">#jurname#</a></td>
		<cfif session.fy GT 2014><td valign="top" bgcolor="##E9FBEC">#countyname#</td></cfif>
	<td valign="top" bgcolor="##E9FBEC">#lb#</td>
	<td valign="top" bgcolor="##E9FBEC">
		<cfif isdefined("vaddressed1") and #vaddressed1# is 1>POS visibility<br></cfif>
		<cfif isdefined("vaddressed2") and #vaddressed2# is 1>POS retailers<br>
		</cfif>
		<cfif isdefined("coupon") and #coupon# is 1>Coupons</cfif>
	</td>
	<td valign="top" bgcolor="##E9FBEC">#bp#</td>
	<td valign="top" bgcolor="##E9FBEC"><cfif bp EQ "No">NA<cfelse>#jurnum#</cfif></td>
	<td bgcolor="##E9FBEC" align="center"><input type="Checkbox" name="Del_box11" value="#monthlyid#"></td>
	</tr>
	<cfif bp eq 'no'>
	<tr>
		<td valign="top" bgcolor="##E9FBEC">Concerns:</td>
	<td valign="top" colspan="8" bgcolor="##E9FBEC">#txtconcerns#</td>
	</tr>
	</cfif>
</cfloop>
<tr><Td colspan=8>			<tr><td colspan=8 align="right"><input type="submit" name="del_targ" value="Delete" class="DelButton">
</td></tr>
</table>
</cfif>
<!--- supermarket outcomes --->
<cfif numPOSSCO GT 0>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="Qtargorg">
select
	name, targid
	from target_org tor left join wrkplan_targets t on tor.targnum = t.targetid and tor.year2 = t.year2
	left join counties c on tor.county = c.fips
	where
	userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and tor.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and initnum=<cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	and stratnum=1
	and target like '%market%'
</cfquery>
<cfif session.fy LT 2012>
<tr><td height=10><br><br></td></tr>
<tr><td>
<table class="boxy" border=".1" width=775>
<tr><td>Was a policy  adopted by a supermarket chain during this reporting period?</td></tr>
<tr><td>
<input type="radio" name="boolSuperPol" value="1" onClick="show_other('posFive', 'hide');show_other('posSix', 'show');" <cfif attributes.boolSuperPol is 1>checked</cfif>>Yes<br>
<input type="radio" name="boolSuperPol" value="0" onClick="show_other('posFive', 'show');show_other('posSix', 'hide');" <cfif attributes.boolSuperPol is 0>checked</cfif>>No
</td></tr>
</table>
<div id="posFive">
<table class="boxy" border=".1" width=775>
<tr><td>What specific activities related to this policy outcome will be undertaken prior to your next monthly report?</td></tr>
<tr><td>
<textarea cols="148" rows="5" maxlength="1000" name="specSuperActTxt" onkeyup="countit40(this)">#attributes.specsuperacttxt#</textarea>
</td></tr>
	      <tr>
      <td width="90%" valign="bottom"><div align="right" valign="bottom">This text field has a max of 1000 characters. Characters entered: <cfoutput><input type="text" value="#len(mon.specsuperacttxt)#" name="specSuperActTxtdisplaycount" size="4" style="border:0;" disabled></cfoutput></td>
    </tr>
</table>
</div>
<div id="posSix">
<table class="boxy" border=".1" width=775>
	<tr>
		<td><strong>Name of supermarket chain</strong></td>
		<td><strong>What policy outcome was adopted</strong></td>
		<td><strong>Describe the policy that was adopted</strong></td>
		<td><strong>## NY stores covered by this policy</strong></td>
		<td><strong>Does policy apply to chain's stores in other states?</strong></td>
	</tr>
<tr>
		<td>
	  <select name="sChainName">
	  	  <option value="">Please select</option>
	  <cfloop query="qtargorg">
	  <option value="#targid#" <cfif #form.schainname# eq #targid#>selected</cfif>>#name#</option>  </cfloop>
	  </select>
	</td>
		<td nowrap="yes" width="150">
		<input name="poa" type = "checkbox" value="1" <cfif form.poa contains 1>checked</cfif>>Policy to end sale of tobacco products<br>
		<input name="poa" type = "checkbox" value="2" <cfif form.poa contains 2>checked</cfif>>Policy to reduce visibility of tobacco advertising and products
		</td>
		<td><textarea cols="40" rows="5" name="polDesc">#form.poldesc#</textarea></td>
		<td>
		<input type="text" name="numStores"  size="4" value="#form.numstores#">
		</td>
		<td>
		<input type="radio" name="boolOtherStates" value="1" <!--- onClick="show_other('posThree', 'hide');show_other('posFour', 'show');" ---> <cfif form.boolOtherStates is 1>checked</cfif>>Yes<br>
		<input type="radio" name="boolOtherStates" value="0" <!--- onClick="show_other('posThree', 'show');show_other('posFour', 'hide');" ---> <cfif form.boolOtherStates is 0>checked</cfif>>No
		</td>
	</tr>
</table>
<table class="boxy" border=".1" width=775>
	<cfif session.modality neq 2 or (session.fy lt 2016 and session.modality eq 2)>
<tr>
	<td>
	<input name="cntcAgree3" type = "checkbox" value="1" <cfif form.cntcAgree3 is 1>checked</cfif>> Check here to indicate that <cfoutput>#session.orgName#</cfoutput> agrees to submit a written copy of the policy to Cheryl Bellus (cab25@health.ny.gov) and copy your Contract Manager
	</td>
</tr>
</cfif>
</table>
<table class="boxy" border=".1" width=775>
<tr><td>
<input type="submit" name="addPOS2" value="Add" class="AddButton" onClick="return pos2();">
</td></tr>
</table>
</div>
</div>
</td></tr>
<cfif qpos2.recordcount is not 0>
<table border=".1" class="box" width="775">
<tr>
	<th align="left">Name of Supermarket Chain</th>
	<th align="left">Policy Outcome Adopted</th>
	<th align="left">Policy Description</th>
	<th align="left">## of NY Stores Covered</th>
	<th align="left">Does Policy Apply to Chains in Other States?</th>
	<th align="left">Agree to Send</th>
	<th>Delete</th>
</tr>
<cfloop query="qpos2">
	<tr>
	<td valign="top" bgcolor="##E9FBEC">#name#</td>
	<td valign="top" bgcolor="##E9FBEC">#poaz#</td>
	<td valign="top" bgcolor="##E9FBEC">#poldesc#</td>
	<td valign="top" bgcolor="##E9FBEC">#numstores#</td>
	<td valign="top" bgcolor="##E9FBEC">#bos#</td>
	<td valign="top" bgcolor="##E9FBEC"><cfif #cntcagree3# is 1>Yes</cfif></td>
	<td bgcolor="##E9FBEC" align="center"><input type="Checkbox" name="Del_box12" value="#monthlyid#"></td>
	</tr>
</cfloop>
<tr><Td colspan=5>			<tr><td colspan=6 align="right"><input type="submit" name="del_targ" value="Delete" class="DelButton">
</td></tr>
</table>
</cfif>
</cfif>
</cfif>
<cfelseif isdefined("session.objval") and #session.objval# EQ '2e' and session.modality NEQ 5>
<cfif isDefined("url.target") and URL.TARGET EQ "pos3">
<cfquery datasource="#application.DataSource#"
password="#application.db_password#"
	username="#application.db_username#" name="QgetPos3det">
select
*
from monthly_pos3
where userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
and initnum = <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
and monthlyid= <cfqueryparam value="#url.seq#" cfsqltype="CF_SQL_INTEGER">
</cfquery>
<cfif QgetPos3det.recordcount NEQ 0>
	<cfset form.lbody2=#QgetPos3det.lbody2#>
	<cfset form.sford1=#QgetPos3det.sford1#>
	<cfset form.sford2=#QgetPos3det.sford2#>
	<cfset form.sford3=#QgetPos3det.sford3#>
	<cfset form.sford4=#QgetPos3det.sford4#>
	<cfset form.sford5=#QgetPos3det.sford5#>
	<cfset form.jurname2=#QgetPos3det.jurname2#>
	<cfset form.boolpassed2=#QgetPos3det.boolpassed2#>
	<cfset form.txtconcerns=#QgetPos3det.txtconcerns#>
	<cfset form.cntrcAgree=#QgetPos3det.cntrcAgree#>
	<cfset form.county=#QgetPos3det.county#>
	<cfset form.jurnum=#QgetPos3det.jurnum#>
	<!---<cfset form.policylink=#QgetPos3det.policylink#>
	<cfset form.policydesc=#QgetPos3det.policydesc#>--->
	<cfset form.cntrcAgree2=#QgetPos3det.cntrcAgree2#>
</cfif>
<input type="hidden" name="pos3seq" value="#url.seq#">
</cfif>
<tr><td>
<table class="boxy" border=".1" width=775>
<tr><td>Was a tobacco-free outdoors policy or ordinance voted on by a lawmaking body during this month?</td></tr>
<tr><td>
<input type="radio" name="boolSFOP" value="1" onClick="show_other('SFODOne', 'hide');show_other('SFODTwo', 'show');" <cfif attributes.boolsfop is 1>checked</cfif>>Yes<br>
<input type="radio" name="boolSFOP" value="0" onClick="show_other('SFODOne', 'show');show_other('SFODTwo', 'hide');" <cfif attributes.boolsfop is 0>checked</cfif>>No
</td></tr>
</table>
<div id="SFODOne">
<table class="boxy" border=".1" width=775>
<tr><td>What specific activities related to the Smoke-free Outdoors outcome will be undertaken prior to your next monthly report?</td></tr>
<tr><td>
<textarea cols="148" rows="5" maxlength="1000" name="specSFODTxt" onkeyup="countit60(this)">#attributes.specsfodtxt#</textarea>
</td></tr>
	      <tr>
      <td width="90%" valign="bottom"><div align="right" valign="bottom">This text field has a max of 1000 characters. Characters entered: <cfoutput><input type="text" value="#len(attributes.specSFODTxt)#" name="specSFODTxtdisplaycount" size="4" style="border:0;" disabled></cfoutput></td>
    </tr>
</table>
</div>
<div id="SFODTwo">
<table class="boxy" border=".1" width=775>
	<tr>
		<td><strong>What lawmaking body voted on the policy/ordinance?</strong></td>
		<td><strong>Policy/ordinance prohibits smoking:</strong></td>
		<cfif session.fy GT 2014><td><strong>County</strong></td></cfif>
		<td><strong>Jurisdiction name</strong></td>
		<td><strong>Was the policy/ordinance passed?</strong></td>
	</tr>
<tr>
		<td>
		<select name="lbody2">
	  <option value="">Please select</option>
	  <option value="1" <cfif form.lbody2 is 1>selected</cfif>>Board of Health</option>
	  <option value="2" <cfif form.lbody2 is 2>selected</cfif>>Municipality</option>
	  <option value="3" <cfif form.lbody2 is 3>selected</cfif>>County</option>
</select>
		</td>
		<td nowrap="yes">
		<cfif session.fy LT 2012><input name="SFord1" type = "checkbox" value="1" <cfif form.sford1 is 1>checked</cfif>>At outdoor areas<br></cfif>
		<input name="SFord2" type = "checkbox" value="1" <cfif form.sford2 is 1>checked</cfif>>Near entryways of buildings<br>
		<cfif session.fy LT 2012><input name="SFord3" type = "checkbox" value="1" <cfif form.sford3 is 1>checked</cfif>>At events<br></cfif>
		<input name="SFord4" type = "checkbox" value="1" <cfif form.sford4 is 1>checked</cfif>>
		<cfif session.fy GT 2011>At parks, playgrounds, or beaches<cfelse>At parks and/or other venues</cfif>
		<cfif session.fy GTE 2012><br><input name="SFord5" type = "checkbox" value="1" <cfif form.sford5 is 1>checked</cfif>>On campus grounds</cfif>
		</td>
				<cfif session.fy GT 2014>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="countyheadache">
select catchment
from contact
where userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
</cfquery>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="counties">
	select CountyName, FIPS from counties
	where FIPS in<cfif isDefined("countyheadache.catchment")>(#valuelist(countyheadache.catchment)#)<cfelse>(0)</cfif>
	order by 1
</cfquery>
<td>
<select name="County">
		<cfif counties.recordcount gt 1><option value="">Please select</option></cfif>
	  <cfloop query="counties">
		<option value="#fips#" <cfif isDefined("form.county") and form.county EQ fips> selected</cfif>>#countyname#</option>
		</cfloop>
		</select>
</td>
	</cfif>
		<td>
		<input type="text" name="jurName2"  size="50" value="#form.jurname2#">
		</td><td>
		<input type="radio" name="boolPassed2" value="1" onClick="show_other('SFODThree', 'hide');show_other('SFODFour', 'show');" <cfif form.boolpassed2 is 1>checked</cfif>>Yes<br>
		<input type="radio" name="boolPassed2" value="0" onClick="show_other('SFODThree', 'show');show_other('SFODFour', 'hide');" <cfif form.boolpassed2 is 0>checked</cfif>>No
		</td>
	</tr>
</table>
<div id="SFODThree">
<table class="boxy" border=".1" width=775>
	<tr>
	<td>
		What concerns did the lawmaking body express regarding the proposed <strong>law/regulation</strong>?
	</td>
</tr>
<tr>
	<td>
	<textarea cols="120" rows="5" name="txtConcerns">#form.txtconcerns#</textarea>
	</td>
</tr>
<cfif session.modality neq 2 or (session.fy lt 2016 and session.modality eq 2)>
<tr>
	<td>
	<input name="cntrcAgree" type = "checkbox" value="1" <cfif form.cntrcagree is 1>checked</cfif>> Check here to indicate that <cfoutput>#session.orgName#</cfoutput> agrees to submit a written copy of the proposed <strong>law/regulation</strong> to Alison Rhodes-Devey (Alison.Rhodes-Devey@health.ny.gov) and copy your Contract Manager
	</td>
</tr>
</cfif>
</table>
</div>
<div id="SFODFour">
<table class="boxy" border=".1" width=775>
<tr>
	<td>
		Approximately how many people reside in this jurisdiction?
		<input type="text" name="jurNum" size="7" value="#form.jurnum#">
	</td>
</tr>
<cfif session.modality neq 2 or (session.fy lt 2016 and session.modality eq 2)>
<tr>
	<td>
	<input name="cntrcAgree2" type = "checkbox" value="1" <cfif form.cntrcagree2 is 1>checked</cfif>> Check here to indicate that <cfoutput>#session.orgName#</cfoutput> agrees to submit a written copy of the <strong>law/regulation</strong> to Alison Rhodes-Devey (Alison.Rhodes-Devey@health.ny.gov) and copy your Contract Manager
	</td>
</tr>
</cfif>
</table>
</div>
<table class="boxy" border=".1" width=775>
<tr><td>
	<cfif isDefined("url.target") and URL.TARGET EQ "pos3">
	<input type="submit" name="addPOS3" value="Update" class="AddButton" onClick="return pos33();">
	<cfelse>
	<input type="submit" name="addPOS3" value="Add" class="AddButton" onClick="return pos33();">
	</cfif>
</td></tr>
</table>
</div>
</td></tr>
<cfif qpos3.recordcount is not 0>
<table border=".1" class="box" width="775">
<tr>
	<th align="left">Jurisdiction Name</th><cfif session.fy GT 2014><th align="left">County</cfif><th align="left">Lawmaking Body</th><th align="left">Policy/ordinance prohibits smoking</th><th align="left">Policy/Ordinance Passed?</th>		<th align="left">## in Jurisdiction</th>
	<th>Delete</th>
</tr>
<cfloop query="qpos3">
	<tr>
	<td valign="top" bgcolor="##E9FBEC"><a href="javascript: document.wrk.action='month.cfm?#session.urltoken#&target=pos3&seq=#monthlyid###pos'; document.wrk.submit()">#jurname2#</a></td>
	<cfif session.fy GT 2014><td valign="top" bgcolor="##E9FBEC">#countyname#</td>	<td valign="top" bgcolor="##E9FBEC">#lb#</td></cfif>
	<td valign="top" bgcolor="##E9FBEC"><cfif #sford1# is 1>At outdoor areas<br></cfif>
	<cfif #sford2# is 1>Near entryways of buildings<br></cfif>
	<cfif #sford3# is 1>At events<br></cfif>
	<cfif #sford4# is 1><cfif session.fy GT 2011>At parks, playgrounds, or beaches<cfelse>At parks and/or other venues</cfif><br></cfif>
	<cfif #sford5# is 1>On campus grounds<br></cfif>
	</td>
	<td valign="top" bgcolor="##E9FBEC">#bp#</td>
	<td valign="top" bgcolor="##E9FBEC"><cfif #bp# NEQ "No">#jurnum#<cfelse>N/A</cfif></td>
	<td bgcolor="##E9FBEC" align="center"><input type="Checkbox" name="Del_box13" value="#monthlyid#"></td>
	</tr>
	<cfif (len(txtConcerns) GT 1)>
	<tr><td colspan="8"  bgcolor="##E9FBEC">Concerns: #txtConcerns#</td></tr>
	</cfif>
</cfloop>
<tr><Td colspan=8>			<tr><td colspan=8 align="right"><input type="submit" name="del_targ" value="Delete" class="DelButton">
</td></tr>
</table>
</cfif>
<tr><td height=10><br><br></td></tr>
<cfif isdefined("url.target") and #url.target# is 'pos4'>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QtargorgSFOD">
select
	name, targid,targdisp
	from target_org tor left join wrkplan_targets t on tor.targnum = t.targetid and tor.year2 = t.year2
	left join counties c on tor.county = c.fips inner join monthly_pos4 m on tor.targid = m.sforg and tor.initnum = m.initnum and tor.year2 = m.year2 and m.mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
	where
	tor.userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and tor.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and tor.initnum=<cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	and tor.stratnum=1 and monthlyid = <cfqueryparam value="#url.seq#" cfsqltype="CF_SQL_INTEGER">
</cfquery>
<cfelse>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QtargorgSFOD">
select
	name, targid,targdisp
	from target_org tor left join wrkplan_targets t on tor.targnum = t.targetid and tor.year2 = t.year2
	left join counties c on tor.county = c.fips
	where
	userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and tor.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and initnum=<cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	and stratnum=1 and targid not in (select sforg from monthly_pos4 where year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> and mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER"> and initnum = <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">)
</cfquery>
</cfif>
<cfif isDefined("url.target") and URL.TARGET EQ "pos4">
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QgetPos4det">
select
*
from monthly_pos4
where userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
and initnum = <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
and monthlyid= <cfqueryparam value="#url.seq#" cfsqltype="CF_SQL_INTEGER">
</cfquery>
<cfif QgetPos4det.recordcount NEQ 0>
	<cfset form.sforg=#QgetPos4det.sforg#>
	<cfset form.SFPol1=#QgetPos4det.SFPol1#>
	<cfset form.SFPol2=#QgetPos4det.SFPol2#>
	<cfset form.SFPol3=#QgetPos4det.SFPol3#>
	<cfset form.SFPol4=#QgetPos4det.SFPol4#>
	<cfset form.SFPol5=#QgetPos4det.SFPol5#>
	<cfset form.SFPnMuniDesc=#QgetPos4det.SFPnMuniDesc#>
	<cfset form.cntrcAgreeSFPnMuni=#QgetPos4det.cntrcAgreeSFPnMuni#>
	<cfset form.county=#QgetPos4det.county#>
</cfif>
<input type="hidden" name="pos4seq" value="#url.seq#">
</cfif>
<cfparam name="form.SForg" default="">
<tr><td>
<a name="POS44">
<table class="boxy" border=".1" width=775>
<tr><td>Was a tobacco-free outdoors policy adopted by an organization other than a jurisdiction during this month?</td></tr>
<tr><td>
<input type="radio" name="boolSFOP2" value="1" onClick="show_other('SFODFive', 'hide');show_other('SFODSix', 'show');"  <cfif attributes.boolsfop2 is 1>checked</cfif>>Yes<br>
<input type="radio" name="boolSFOP2" value="0" onClick="show_other('SFODFive', 'show');show_other('SFODSix', 'hide');" <cfif attributes.boolsfop2 is 0>checked</cfif>>No
</td></tr>
</table>
<div id="SFODFive">
<table class="boxy" border=".1" width=775>
<tr><td>What specific activities related to this policy outcome will be undertaken prior to your next monthly report?</td></tr>
<tr><td>
<textarea cols="148" rows="5" maxlength="1000" name="specSFODTxt2" onkeyup="countit70(this)">#attributes.specsfodtxt2#</textarea>
</td></tr>
	      <tr>
      <td width="90%" valign="bottom"><div align="right" valign="bottom">This text field has a max of 1000 characters. Characters entered: <cfoutput><input type="text" value="#len(attributes.specSFODTxt2)#" name="specSFODTxt2displaycount" size="4" style="border:0;" disabled></cfoutput></td>
    </tr>
</table>
</div>
<div id="SFODSix">
<table class="boxy" border=".1" width=775>
	<tr>
		<td><strong>Name of organization</strong></td>
		<cfif session.fy GT 2014><td><strong>County/ies:</strong></td></cfif>
		<td><strong>Policy prohibits smoking:</strong></td>
		<td><strong>Brief description</strong></td>
	</tr>
<tr>
		<td>
			<select name="SForg">
				 <option value="">Please select</option><cfloop query="QtargorgSFOD">
	<option value="#targid#" <cfif (isDefined("form.SForg") and form.SForg eq targid) or (isdefined("url.seq") and #url.seq# eq targid)> selected</cfif>><cfif #targdisp# is 1>*</cfif>#name#</option><!--- </cfif> ---></cfloop>
				</option></select>
		</td>
				<cfif session.fy GT 2014>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="countyheadache">
select catchment
from contact
where userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
</cfquery>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="counties">
	select CountyName, FIPS from counties
	where FIPS in<cfif isDefined("countyheadache.catchment")>(#valuelist(countyheadache.catchment)#)<cfelse>(0)</cfif>
	order by 1
</cfquery>
<cfif isdefined("QgetPos4det") and #Qgetpos4det.county# is not ''>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="counties2">
	select CountyName, FIPS from counties
	where FIPS in<cfif isDefined("QgetPos4det.county")>(#valuelist(QgetPos4det.county)#)<cfelse>(0)</cfif>
	order by 1
</cfquery>	</cfif>
<td>
<select name="county" multiple>
		<cfif counties.recordcount gt 1><option value="">Please select</option></cfif>
		<cfloop query="counties">
<option value="#fips#" <cfif isDefined("QgetPos4det.county") and listfind(QgetPos4det.county, fips)> selected</cfif>>#countyname#
</cfloop>
		</select>
</td>
	</cfif>
		<td nowrap="yes">
		<cfif session.fy LT 2012><input name="SFPol1" type = "checkbox" value="1" <cfif form.sfpol1 is 1>checked</cfif>>At outdoor areas<br></cfif>
		<input name="SFPol2" type = "checkbox" value="1" <cfif form.sfpol2 is 1>checked</cfif>>Near entryways of buildings<br>
		<cfif session.fy LT 2012><input name="SFPol3" type = "checkbox" value="1" <cfif form.sfpol3 is 1>checked</cfif>>At events<br></cfif>
		<input name="SFPol4" type = "checkbox" value="1" <cfif form.sfpol4 is 1>checked</cfif>><cfif session.fy GT 2011>At private parks, playgrounds, or beaches<cfelse>At parks and/or other venues</cfif>
		<cfif session.fy GTE 2012><br><input name="SFPol5" type = "checkbox" value="1" <cfif form.SFPol5 is 1>checked</cfif>>On grounds</cfif>
		</td>
		<td>
		<textarea name="SFPnMuniDesc" cols="73" rows="5">#form.sfpnmunidesc#</textarea>
		</td>
	</tr>
<cfif session.modality neq 2 or (session.fy lt 2016 and session.modality eq 2)>
<tr>
	<td colspan=<cfif session.fy GT 2014>"4"<cfelse>"3"</cfif>>
	<input name="cntrcAgreeSFPnMuni" type = "checkbox" value="1" <cfif form.cntrcAgreeSFPnMuni is 1>checked</cfif>> Check here to indicate that <cfoutput>#session.orgName#</cfoutput> agrees to submit a written copy of the <strong>policy</strong> to Alison Rhodes-Devey (Alison.Rhodes-Devey@health.ny.gov) and copy your Contract Manager
	</td>
</tr>
</cfif>
</table>
<table class="boxy" border=".1" width=775>
<tr><td>
<cfif isDefined("url.target") and URL.TARGET EQ "pos4">
	<input type="submit" name="addPOS4" value="Update" class="AddButton" onClick="return POS44();">
	<cfelse>
	<input type="submit" name="addPOS4" value="Add" class="AddButton" onClick="return POS44();">
	</cfif>
</td></tr>
</table>
</div>
</cfif>
</table>
</td></tr>
<cfif qpos4.recordcount is not 0 and session.modality NEQ 5>
<table border=".1" class="box" width="775">
<tr>
	<th align="left">Organization Name</th>		<cfif session.fy GT 2014><th align="left">County/ies:</td></cfif>
<th align="left">Policy prohibits smoking</th><th align="left">Brief description</th>
<cfif session.fy LT 2016><th align="left">Agree to Send</th></cfif><th>Delete</th>
</tr>
<cfloop query="qpos4">
	<cfif qpos4.county is not ''>
	<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="counties">
	select CountyName, FIPS from counties
	where FIPS in<cfif isDefined("qpos4.county")>(#qpos4.county#)<cfelse>(0)</cfif>
	order by 1
</cfquery></cfif>
	<tr>
	<td valign="top" bgcolor="##E9FBEC">
		<a href="javascript: document.wrk.action='month.cfm?#session.urltoken#&target=pos4&seq=#monthlyid###POS44'; document.wrk.submit()"><cfif #targdisp# eq 1>*</cfif>#name#</a>
	</td>
		<cfif session.fy GT 2014><td valign="top" bgcolor="##E9FBEC"><cfif isdefined("counties.countyname")>#valuelist(counties.countyName)#</cfif>
	</td></cfif>
	<td valign="top" bgcolor="##E9FBEC"><cfif #sfpol1# is 1>At outdoor areas<br></cfif><cfif #sfpol2# is 1>Near entryways of buildings<br></cfif><cfif #sfpol3# is 1>At events<br></cfif><cfif #sfpol4# is 1>At parks and/or other venues<br></cfif><cfif #sfpol5# is 1>On campus grounds<br></cfif></td><td valign="top" bgcolor="##E9FBEC">#sfpnmunidesc#</td>
	<cfif session.fy LT 2016><td bgcolor="##E9FBEC" align="center"><cfif #cntrcAgreeSFPnMuni# is 1  >Yes</cfif></td></cfif>
	<td bgcolor="##E9FBEC" align="center"><input type="Checkbox" name="Del_box14" value="#monthlyid#"></td>
	</tr>
</cfloop>
<tr><cfif session.fy LT 2016><td colspan=6 align="right"><cfelse><td colspan=5 align="right"></cfif><input type="submit" name="del_targ" value="Delete" class="DelButton">
</td></tr>
</table>
</cfif>
</cfif>
</cfif>
<cfif session.fy GT 2014 and (#session.objnum# is not '2d' and #session.objnum# is not '4f' and #session.objnum# is not '2e')>
	<tr><td height=20></td></tr>
<div id="vflagg">
	<tr>
	<th align="left" width="800"><a name="thcpo"></a><h6>Video Flagging<br><br></th>
	</tr>
<table class="boxy" border=".1" width=775>
	<tr>
		<td>Please enter the number of YouTube videos flagged this month:
		<input type="text" name = "youTube" size="5" value="#mon.youTube#">
		</td>
	</tr>
	</cfif>
	</table></div>
	<cfif #getverk.advoc# is 1>
<cfif #session.objval# is '1A'>
   <cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="wrk">
select * from wrkplan
where
	userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> and year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> and initnum = '1A'
</cfquery>
 <cfif isdefined("form.targ") or isdefined("url.targ")>
   <cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="selcollab">
  select c.name, c.indOrg, c.traditional, w.targethcpo as type, c.county,
  c.seq , c.unit,
case when c.unit IS NULL then c.NAME else c.unit + ' ' + NAME end as unitname ,
  del, case tHCPO when 0 then 'No' when 1 then 'Yes' else '-' end as tHCPO,
case tLevel
	when 1 then 'Potential'
	when 2 then 'Limited'
	when 3 then 'Full'
	else '-' end as tLevel,
	entdt,
	case FQHC when 1 then 'Yes' else 'No' end  as FQHC,
	case ref when 1 then 'Yes' else 'No' end  as ref,cess,pip,
  c.school, c.district , isnull(c.sodistrict,0) as sodistrict, isNull(c.sfy, 0) as sfy,
d.district_name,
s.institutionname
  from collaborators as c
left outer join  wrkplan_targethcpo as w on w.targethcpo_id = c.type and w.year2=c.year2
left outer join nysed_district as d on d.district_id = c.district
left outer join nysed_school as s on s.bedscode=c.school
  where c.seq = <cfif isdefined("form.targ")><cfqueryparam value="#form.targ#" cfsqltype="CF_SQL_INTEGER"><cfelseif isdefined("url.targ")><cfqueryparam value="#url.targ#" cfsqltype="CF_SQL_INTEGER"></cfif>
  </cfquery>
  </cfif>
  <cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="collaborators">
  select c.name, c.indOrg, c.traditional, w.targethcpo as type, c.county,
  c.seq , c.unit,
case when c.unit IS NULL then c.NAME else c.unit + ' ' + NAME end as unitname ,
  del, case tHCPO when 0 then 'No' when 1 then 'Yes' else '-' end as tHCPO,
case tLevel
	when 1 then 'Potential'
	when 2 then 'Limited'
	when 3 then 'Full'
	else '-' end as tLevel,
	entdt,
	case FQHC when 1 then 'Yes' else 'No' end  as FQHC,
	case ref when 1 then 'Yes' else 'No' end  as ref,cess,pip,
  c.school, c.district , isnull(c.sodistrict,0) as sodistrict, isNull(c.sfy, 0) as sfy,
d.district_name,
s.institutionname
  from collaborators as c
left outer join  wrkplan_targethcpo as w on w.targethcpo_id = c.type and w.year2=c.year2
left outer join nysed_district as d on d.district_id = c.district
left outer join nysed_school as s on s.bedscode=c.school
  where userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> and (c.year2 >=1904)
  and (c.del is null or c.del !=1) and c.year2  <cfif session.fy GT 2010 and session.modality EQ 1> >= 2010<cfelse> =<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"></cfif>
  <cfif session.modality EQ 4>
  and c.district is not null
  <cfelse>
  and c.county is not null
  </cfif>
 <cfif session.modality EQ 4>order by 17, 18 --13, 12<Cfelse> order by 8,7,1</cfif>
  </cfquery>
      <cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="gettarg">
  select *
  from monthly_targethcpo m inner join collaborators c on m.seq = c.seq
  where m.userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> and m.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> and mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
 and (c.del is null or c.del !=1)
order by name
  </cfquery>
 <cfif (isdefined("form.targ") and form.targ NEQ "") or isdefined("url.targ")>
<cfif isDefined("url.targ")>
  <cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="gettargs">
select
c.userid, m.year2, mon, m.seq, massmail,
adcomm1,
adcomm2, adcomm3,
maintind, m.train, isNull(attend, 0) attend,
techass1, techass2, techass3, award, nrt, pipA, pipB, pipC, notes,
--seqPK,
name, indorg, traditional, type, county,  unit, del,
tHCPO, tLevel, school, district,soDistrict, sfy, timprovement, FQHC, ref, cess,
entDT, writpol, ask, advise_ident, assarr_ident,advise_writpol,
assess_writpol, assarr_writpol, idsys, staff, fback, campus, pip, docsys, other2, idsys2, docsys2
  from monthly_targethcpo m inner join collaborators c on m.seq = c.seq
  where m.seq = <cfqueryparam value="#url.targ#" cfsqltype="CF_SQL_INTEGER"> and m.mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
  and m.year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
 and (c.del is null or c.del !=1)
  </cfquery>
</cfif>
<cfif not isDefined("url.targ") or (isDefined("url.targ") and gettargs.recordcount EQ 0)>
  <cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="gettargs">
select
c.userid, m.year2, mon, m.seq, massmail,
adcomm1,
adcomm2, adcomm3,
maintind, m.train, isNull(attend, 0) attend,
techass1, techass2, techass3, award, nrt, pipA, pipB, pipC, notes,
--seqPK,
name, indorg, traditional, type, county,  unit, del,
tHCPO, tLevel, school, district,soDistrict, sfy, timprovement, FQHC, ref, cess,
entDT, writpol, ask, advise_ident, assarr_ident,advise_writpol,
assess_writpol, assarr_writpol, idsys, staff, fback, campus, pip, docsys, other2, idsys2, docsys2
  from monthly_targethcpo m inner join collaborators c on m.seq = c.seq
  where m.seq = <cfqueryparam value="#form.targ#" cfsqltype="CF_SQL_INTEGER"> and m.mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
  and m.year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
 and (c.del is null or c.del !=1)
  </cfquery>
</cfif><cfabort>
     <cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="gettargsHist">
select
sum(isnull(adcomm3,0)) as adcomm3
from monthly_targethcpo m inner join collaborators c on m.seq = c.seq
  where m.seq = <cfif isdefined("form.targ") and form.targ NEQ "">'#form.targ#'<cfelseif isdefined("url.targ")>'#url.targ#'</cfif>
and ((m.mon in (select mm.mon_num from months mm
where mm.rank < (select mmm.rank from months mmm where mmm.mon_num=<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER"> and mmm.year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> and mm.year2=mmm.year2))
  and (m.year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> or m.year2 < <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">)
 and (c.del is null or c.del !=1)
  </cfquery>
  <cfset form.massmail = "#gettargs.massmail#">
  <cfset form.adcomm1 = "#gettargs.adcomm1#">
  <cfset form.adcomm2 = "#gettargs.adcomm2#">
  <cfset form.adcomm3 = "#gettargs.adcomm3#">
  <cfset form.maintind = "#gettargs.maintind#">
  <cfset form.train = "#gettargs.train#">
  <cfset form.attend = "#gettargs.attend#">
  <cfset form.attend2 = "#gettargs.attend#">
  <cfset form.techass1 = "#gettargs.techass1#">
  <cfset form.techass2 = "#gettargs.techass2#">
  <cfset form.techass3 = "#gettargs.techass3#">
  <cfset form.award = "#gettargs.award#">
  <cfset form.nrt = "#gettargs.nrt#">
  <cfset form.pipa = "#gettargs.pipa#">
  <cfset form.pipb = "#gettargs.pipb#">
  <cfset form.pipc = "#gettargs.pipc#">
  <cfset form.notes = "#gettargs.notes#">
  <cfelse>
  <cfset gettargs.massmail = ''>
</cfif>
	  <th align="left" width="800"><a name="thcpo"></a><h6>Advocating with Organizational Decision Makers<br><br></th></tr>
<tr><td colspan=4>Mass mailing sent to
	<cfif isDefined("form.advmassmail") and form.advmassmail NEQ "">
	<cfinput name="advmassmail" type="text" value="#form.advmassmail#" size=3 required="no" message="You must enter a number for mass mailings sent to HCPOs" validate="integer">
	<cfelse>
	<cfinput name="advmassmail" type="text" value="#mon.advmassmail#" size=3 required="no" message="You must enter a number for mass mailings sent to HCPOs" validate="integer">
	</cfif>
	 HCPOs this month</td></tr>
<table class="boxy" width=800><tr><td><strong>Target HCPO</strong></td><td>
<select name="targ" onChange="javascript: document.wrk.action='month.cfm?#session.urltoken###thcpo'; form.submit();">
<option value="">Please select</option>
<cfloop query="collaborators">
		<option value="#seq#"
				<cfif isdefined("url.targ") and #url.targ# EQ #seq#>selected<cfelseif NOT isDefined("url.targ") AND isdefined("FORM.targ") and #FORM.targ# EQ #seq#>selected</cfif>>#name#</option></cfloop></select>
		</td></tr>
		<tr><td valign="top"><strong>Training</strong></td><td><input type="text" name="train" size=2 value="#form.train#"> number of trainings for the HCPO this month<br>
		<input type="text" name="attend2" size=2 value="#form.attend2#"> Total ## attendees this month</td></tr>
				<tr><td valign="top"><strong>Technical Assistance</strong></td><td><input type="checkbox" name="techass1" value=1 <cfif #form.techass1# is 1>checked</cfif>> Conducted on-site academic detailing this month<br>
		<input type="checkbox" name="techass2" value=1 <cfif #form.techass2# is 1>checked</cfif>> Conducted other TA this month<br>
		<input type="checkbox" name="techass3" value=1 <cfif #form.techass3# is 1>checked</cfif>> Reviewed progress and provided feedback this month
			<tr><td valign="top"><strong>Maintenance</strong></td><td><!---<input type="checkbox" name="adcomm1" value=1 <cfif #form.adcomm1# is 1>checked</cfif>> Administrative commitment contact this month<br>
		<input type="checkbox" name="adcomm2" value=1 <cfif #form.adcomm2# is 1>checked</cfif>> Administrative commitment obtained this month<br>--->
		<input type="checkbox" name="adcomm3" value=1 <cfif isDefined("gettargsHist") and gettargsHist.adcomm3 GT 0> disabled </cfif> <cfif #form.adcomm3# is 1>checked</cfif>> Moved to maintenance phase this month
<br>		Maintenance indicators:<br>
		<textarea name="maintind" cols=115 rows=3>#form.maintind#</textarea></td></tr>
				<tr><td valign="top"><strong>Stipends and mini-grants</strong></td><td>$ <input type="text" name="award" size=6 value="#form.award#"> Amount awarded this month<br>
		<input type="text" name="nrt" size=2 value="#form.nrt#"> ## of 2-week NRT units provided this month</td></tr>
				<tr><td valign="top"><strong>PIP</strong></td><td>## providers completed each stage this month<br>
				<input type="text" name="pipa" size=2 value="#form.pipa#"> Completed Stage A<br>
		<input type="text" name="pipb" size=2 value="#form.pipb#"> Completed Stage B<br>
			<input type="text" name="pipc" size=2 value="#form.pipc#"> Completed Stage C</td></tr>
					<tr><td valign="top"><strong>Additional notes</strong></td><td><textarea name="notes" cols=115 rows=4>#form.notes#</textarea></td></tr>
			<tr><Td colspan=2>	  <input type="submit" name="addtargethcpo" <cfif isdefined("url.targ") or (isDefined("gettargs.recordcount") and gettargs.recordcount NEQ 0)>value="Update"<cfelse>value="Add"</cfif> class="AddButton" onClick="return checkTG();"><br><br>
</td></tr><a name="delhcpo" id="delhcpo"></a>
<cfif gettarg.recordcount is not 0>
<tr>
<td colspan="4">
<table border=".1" class="box" width="100%">
<tr>
	<th align="left">Target HCPO</th>	<th>Delete</th>
</tr>
<cfloop query="gettarg">
	<tr>
	<td valign="top" bgcolor="##E9FBEC">
				<a href="javascript: document.wrk.action='month.cfm?targ=#seq###thcpo'; document.wrk.submit();">
#gettarg.name#</a></td>
	<td bgcolor="##E9FBEC" align="center"><input type="Checkbox" name="Del_box6" value="#gettarg.seq#"></td>
	</tr>
</cfloop>
<tr><Td colspan=5>			<tr><td colspan=6 align="right"><input type="submit" name="del_targ" value="Delete" class="DelButton">
</td></tr>
</table>
</th>
</tr></cfif>
</table>
<p></p>
<cfif isdefined("form.targ2") or isdefined("url.targ2")  or (isdefined("session.targ2") and session.targ2 NEQ "")>
   <cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="selcollab2">
		select c.name, c.indOrg, c.traditional, c.county, c.seq , c.unit, case when c.unit IS NULL then c.NAME else c.unit + ' ' + NAME end as unitname ,
del, case tHCPO when 0 then 'No' when 1 then 'Yes' else '-' end as tHCPO, case tLevel when 1 then 'Potential' when 2 then 'Limited' when 3 then 'Full' else '-' end as tLevel,
w.seq as intab, sum(case isnull(w.idsys, 0) when 1 then 1 else 0 end) + isnull(c.idsys,0) as idsys, sum(case isnull(w.idsys, 0) when 2 then 1 else 0 end) + isnull(c.idsys2,0) as idsys2,
sum(case isnull(w.docsys, 0) when 1 then 1 else 0 end) + isnull(c.docsys,0) as docsys, sum(case isnull(w.docsys, 0) when 2 then 1 else 0 end) + isnull(c.docsys2,0) as docsys2,
sum(isnull(w.writpol, 0)) + isnull(c.writpol,0)as writpol, sum(isnull(w.ask, 0))+ isnull(c.ask,0) as ask, sum(isnull(w.advise_ident, 0))+ isnull(c.advise_ident,0) as advise_ident,
sum(isnull(w.assess_ident, 0))+ isnull(c.assess_ident,0) as assess_ident, sum(isnull(w.assarr_ident, 0))+ isnull(c.assarr_ident,0) as assarr_ident,
sum(isnull(w.advise_writpol, 0))+ isnull(c.advise_writpol,0) as advise_writpol, sum(isnull(w.assess_writpol, 0))+ isnull(c.assess_writpol,0) as assess_writpol,
sum(isnull(w.assarr_writpol, 0))+ isnull(c.assarr_writpol,0) as assarr_writpol, sum(isnull(w.train2, 0))+ isnull(c.train,0) as train2, sum(isnull(w.staff, 0))+ isnull(c.staff,0) as staff,
sum(isnull(w.fback, 0))+ isnull(c.fback,0) as fback, sum(isnull(w.campus, 0))+ isnull(c.campus,0) as campus
from collaborators as c
left join monthly_cc w
on c.seq = w.seq and c.year2 = w.year2 and w.mon  in
(select m.mon_num from months m
where m.rank < (select rank from months mm where mon_num=<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER"> and year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">))
 where c.seq = <cfif isdefined("form.targ2")><cfqueryparam value="#form.targ2#" cfsqltype="CF_SQL_INTEGER"><cfelseif isdefined("url.targ2")><cfqueryparam value="#url.targ2#" cfsqltype="CF_SQL_INTEGER"><cfelseif isdefined("session.targ2")><cfqueryparam value="#session.targ2#" cfsqltype="CF_SQL_INTEGER"></cfif>
group by
c.name, c.indOrg, c.traditional, c.county,
  c.seq , c.unit,
case when c.unit IS NULL then c.NAME else c.unit + ' ' + NAME end  ,
  del, case tHCPO when 0 then 'No' when 1 then 'Yes' else '-' end ,
case tLevel
	when 1 then 'Potential'
	when 2 then 'Limited'
	when 3 then 'Full'
	else '-' end ,
w.seq, c.idsys, c.idsys2, c.docsys, c.docsys2,
c.writpol,c.staff,c.fback,c.campus,
c.advise_ident,c.assarr_ident,c.assess_ident,
c.ask,c.advise_writpol,c.assarr_writpol,c.assess_writpol,c.train
  </cfquery>
   <cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="selcollab3">
  select c.name, c.indOrg, c.traditional, c.county,
  c.seq , c.unit,
case when c.unit IS NULL then c.NAME else c.unit + ' ' + NAME end as unitname ,
  del, case tHCPO when 0 then 'No' when 1 then 'Yes' else '-' end as tHCPO,
case tLevel
	when 1 then 'Potential'
	when 2 then 'Limited'
	when 3 then 'Full'
	else '-' end as tLevel, w.seq as intab, w.idsys, w.docsys, w.writpol, w.ask, w.advise_ident, w.assess_ident, w.assarr_ident,
	w.advise_writpol, w.assess_writpol, w.assarr_writpol, w.train2, w.staff, w.fback, w.campus
  from collaborators as c
left outer join monthly_cc as w on w.seq = c.seq
--left outer join nysed_district as d on d.district_id = c.district
--left outer join nysed_school as s on s.bedscode=c.school
  where c.seq = <cfif isdefined("form.targ2")><cfqueryparam value="#form.targ2#" cfsqltype="CF_SQL_INTEGER"><cfelseif isdefined("url.targ2")><cfqueryparam value="#url.targ2#" cfsqltype="CF_SQL_INTEGER"><cfelseif isdefined("session.targ2")><cfqueryparam value="#session.targ2#" cfsqltype="CF_SQL_INTEGER"></cfif> and w.mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER"> and w.year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
  </cfquery>
 <cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="selcollab4">
  select c.name, c.indOrg, c.traditional, c.county,
  c.seq , c.unit,
case when c.unit IS NULL then c.NAME else c.unit + ' ' + NAME end as unitname ,
  del, case tHCPO when 0 then 'No' when 1 then 'Yes' else '-' end as tHCPO,
case tLevel
	when 1 then 'Potential'
	when 2 then 'Limited'
	when 3 then 'Full'
	else '-' end as tLevel, w.seq as intab, w.idsys, w.docsys, w.writpol, w.ask, w.advise_ident, w.assess_ident, w.assarr_ident,
	w.advise_writpol, w.assess_writpol, w.assarr_writpol, w.train2, w.staff, w.fback, w.campus
  from collaborators as c
left outer join monthly_cc as w on w.seq = c.seq
--left outer join nysed_district as d on d.district_id = c.district
--left outer join nysed_school as s on s.bedscode=c.school
  where c.seq = <cfif isdefined("form.targ2")><cfqueryparam value="#form.targ2#" cfsqltype="CF_SQL_INTEGER"><cfelseif isdefined("url.targ2")><cfqueryparam value="#url.targ2#" cfsqltype="CF_SQL_INTEGER"><cfelseif isdefined("session.targ2")><cfqueryparam value="#session.targ2#" cfsqltype="CF_SQL_INTEGER"></cfif>
and w.mon in
(select a.mon_num from months a, months b
where a.rank < b.rank and a.year2=b.year2
and b.mon_num=<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">)
and w.year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
  </cfquery>
 <cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="selcollab5">
 select c.name, c.indOrg, c.traditional, c.type, c.county, c.seq , c.unit, pip,
	  case when c.unit IS NULL then c.NAME else c.unit + ' ' + NAME end as unitname , FQHC,ref,cess,writpol,ask,advise_writpol,assess_writpol,train,assarr_writpol,advise_ident,assess_ident,assarr_ident,
	  isnull(idsys,0)as idsys,
	  isnull(docsys,0)as docsys,
	  isnull(idsys2,0)as idsys2,
	  isnull(docsys2,0)as docsys2,
	  other2,staff,fback,campus,
	  tHCPO, tLevel from collaborators as c where userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	  and c.seq = <cfif isdefined("form.targ2")><cfqueryparam value="#form.targ2#" cfsqltype="CF_SQL_INTEGER"><cfelseif isdefined("url.targ2")><cfqueryparam value="#url.targ2#" cfsqltype="CF_SQL_INTEGER"><cfelseif isdefined("session.targ2")><cfqueryparam value="#session.targ2#" cfsqltype="CF_SQL_INTEGER"></cfif>
</cfquery>
 <cfset form.idsys = #selcollab3.idsys#>
 <cfset form.docsys = #selcollab3.docsys#>
 <cfset form.writpol = #selcollab3.writpol#>
<cfset form.ask = #selcollab3.ask#>
<cfset form.advise_ident = #selcollab3.advise_ident#>
<cfset form.assess_ident = #selcollab3.assess_ident#>
<cfset form.assarr_ident = #selcollab3.assarr_ident#>
<cfset form.advise_writpol = #selcollab3.advise_writpol#>
<cfset form.assess_writpol = #selcollab3.assess_writpol#>
<cfset form.assarr_writpol = #selcollab3.assarr_writpol#>
<cfset form.train2 = #selcollab3.train2#>
<cfset form.staff = #selcollab3.staff#>
<cfset form.fback = #selcollab3.fback#>
<cfset form.campus = #selcollab3.campus#>
<cfif isdefined("form.targ2") and #form.targ2# is not '' and (not isdefined("form.targ") or #form.targ# is '')>
<cfset session.targ2 = #form.targ2#>
<cflocation url="month.cfm##ppc" addtoken="no">
</cfif>
  </cfif>
          <cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="gettarg2">
  select *
  from monthly_cc m inner join collaborators c on m.seq = c.seq
  and pp = 1 and mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER"> and m.userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> and m.year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
order by name
  </cfquery>
<br>
  <tr><th><a name="ppc"></a><h6>Policy and Practice Changes</th></tr>
<table class="boxy" border=".1" width=800 cellpadding=10>
<tr><td><strong>Target HCPO<br>
</strong></td><td>
<input type="hidden" name="showz">
<select name="targ2"  onchange="javascript: document.wrk.action='month.cfm?#session.urltoken###ppc'; form.submit();" >
<option value="" selected>Please select</option>
<cfloop query="collaborators">
		<option value="#seq#" <cfif isdefined("FORM.targ2") and #FORM.targ2# EQ #seq#>selected<cfelseif  (isDefined("session.targ2") and session.targ2 EQ #seq#)or (isdefined("url.targ2") and #url.targ2# EQ #seq#)>selected<!--- <cfelseif isdefined("session.targ2") and #session.targ2# EQ #seq#>selected< ---></cfif>>#name#</option></cfloop></select>
<br>
		</td></tr>
<tr><td><input name="idsys"value="1" type="checkbox"  onclick="ugh4();"<cfif (isdefined("selcollab5.idsys") and selcollab5.idsys GTE 1)or (isdefined("selcollab4.idsys") and selcollab4.idsys GTE 1)>checked disabled<cfelseif isdefined("selcollab3.idsys") and selcollab3.idsys GTE 1> checked</cfif>> EMR
<br><input name="idsys" value="2" type="checkbox"   onclick="ugh5();"<cfif (isdefined("selcollab5.idsys2") and selcollab5.idsys2 GTE 1)or (isdefined("selcollab4.idsys2") and selcollab4.idsys2 GTE 1)>checked disabled<cfelseif isdefined("selcollab3.idsys2") and selcollab3.idsys2 GTE 1>  checked</cfif>> Other</td>
<td valign="top">Implemented/ updated identification <strong>system</strong> to document smoking status of every patient this month (ASK)</td></tr>
<tr><td colspan="2">
<table style="font-family: verdana, helvetica, sans-serif; font-size: 11px; border: none; border-style: hide; " border="0">
<tr>
<td  colspan="2" width="180"><input name="docsys" value="1" type="checkbox" onClick="ugh();" <cfif (isdefined("selcollab5.docsys") and selcollab5.docsys GTE 1)or (isdefined("selcollab4.docsys") and selcollab4.docsys GTE 1)>checked disabled<cfelseif isdefined("selcollab3.docsys") and selcollab3.docsys eq 1>  checked</cfif>> EMR</td>
<td valign="top" rowspan="2" valign="top">Implemented/ updated <strong>system</strong> to document tobacco dependence treatment for every tobacco user (Indicate what specifically is included)</td>
</tr>
<tr>
<td colspan="2"><input name="docsys" value="2" type="checkbox"  onclick="ugh3();"<cfif (isdefined("selcollab5.docsys2") and selcollab5.docsys2 GTE 1)or (isdefined("selcollab4.docsys2") and selcollab4.docsys2 GTE 1)>checked disabled<cfelseif isdefined("selcollab3.docsys") and selcollab3.docsys eq 2>  checked</cfif>> Other</td>
</tr>
<tr>
<td width="40">&nbsp;</td>
<td><input type="checkbox" name="advise_ident" value=1 <cfif (isdefined("selcollab5.advise_ident") and #selcollab5.advise_ident# GTE 1)or (isdefined("selcollab4.advise_ident") and #selcollab4.advise_ident# GTE 1)>checked disabled <cfelseif isdefined("selcollab3.advise_ident") and #selcollab3.advise_ident# GTE 1>  checked</cfif>>ADVISE</td>
<td>Tobacco user was advised to quit and provided brief counseling (ADVISE)</td>
</tr>
<tr>
<td></td>
<td ><input type="checkbox" name="assess_ident" value=1 <cfif (isdefined("selcollab5.assess_ident") and #selcollab5.assess_ident# GTE 1)or (isdefined("selcollab4.assess_ident") and #selcollab4.assess_ident# GTE 1)>checked disabled <cfelseif isdefined("selcollab3.assess_ident") and #selcollab3.assess_ident# GTE 1>  checked</cfif>>ASSESS</td>
<td>Tobacco user was assessed for willingness to quit (ASSESS)</td>
</tr>
<tr>
<td></td>
<td ><input type="checkbox" name="assarr_ident" value=1 <cfif (isdefined("selcollab5.assarr_ident") and #selcollab5.assarr_ident# GTE 1)or (isdefined("selcollab4.assarr_ident") and #selcollab4.assarr_ident# GTE 1)>checked disabled<cfelseif isdefined("selcollab3.assarr_ident") and #selcollab3.assarr_ident# GTE 1>  checked</cfif>>ASSIST/ARRANGE</td>
<td>Tobacco user ready to quit was assisted and provided follow-up (ASSIST/ARRANGE)</td>
</tr>
</table>
</td></tr>
<tr><td colspan="2">
<table style="font-family: verdana, helvetica, sans-serif; font-size: 11px; border: none; border-style: hide; " border="0">
<tr>
<td  colspan="2" width="180"><input name="writpol" value="1" type="checkbox" <cfif (isdefined("selcollab5.writpol") and selcollab5.writpol GTE 1)or ( isdefined("selcollab4.writpol") and selcollab4.writpol GTE 1)>checked disabled<cfelseif isdefined("selcollab3.writpol") and selcollab3.writpol GTE 1>  checked</cfif>> Policy/SOC</td>
<td><strong>Written policy or written standard of care</strong> on tobacco dependence treatment updated this month.
If yes, what was included/ added?</td>
</tr>
<tr>
<td width="40">&nbsp;</td>
<td><input type="checkbox" name="ask" value=1 <cfif (isdefined("selcollab5.ask") and #selcollab5.ask# eq 1)or (isdefined("selcollab4.ask") and #selcollab4.ask# eq 1)>checked disabled<cfelseif isdefined("selcollab3.ask") and #selcollab3.ask# eq 1>  checked</cfif>>ASK</td>
<td>Every patient will be screened for tobacco use (ASK)</td>
</tr>
<tr>
<td width="40">&nbsp;</td>
<td><input type="checkbox" name="advise_writpol" value=1 <cfif (isdefined("selcollab5.advise_writpol") and #selcollab5.advise_writpol# GTE 1)or (isdefined("selcollab4.advise_writpol") and #selcollab4.advise_writpol# GTE 1)>checked disabled<cfelseif isdefined("selcollab3.advise_writpol") and #selcollab3.advise_writpol# GTE 1>  checked</cfif>>ADVISE</td>
<td>Every tobacco user will be advised to quit and provided brief counseling (ADVISE)</td>
</tr>
<tr>
<td width="40">&nbsp;</td>
<td><input type="checkbox" name="assess_writpol" value=1 <cfif (isdefined("selcollab5.assess_writpol") and #selcollab5.assess_writpol# GTE 1)or (isdefined("selcollab4.assess_writpol") and #selcollab4.assess_writpol# GTE 1)>checked disabled<cfelseif isdefined("selcollab3.assess_writpol") and #selcollab3.assess_writpol# GTE 1>  checked</cfif>>ASSESS</td>
<td>Every tobacco user will be assessed for willingness to quit (ASSESS)</td>
</tr>
<tr>
<td width="40">&nbsp;</td>
<td><input type="checkbox" name="assarr_writpol" value=1 <cfif (isdefined("selcollab5.assarr_writpol") and #selcollab5.assarr_writpol# GTE 1)or (isdefined("selcollab4.assarr_writpol") and #selcollab4.assarr_writpol# GTE 1)>checked disabled<cfelseif isdefined("selcollab3.assarr_writpol") and #selcollab3.assarr_writpol# GTE 1>  checked</cfif>>ASSIST/ARRANGE</td>
<td>Every tobacco user ready to quit will be assisted and provided follow-up (ASSIST/ ARRANGE)</td>
</tr>
<tr>
<td width="40">&nbsp;</td>
<td><input type="checkbox" name="train2" value=1 <cfif (isdefined("selcollab5.train") and #selcollab5.train# GTE 1)or (isdefined("selcollab4.train2") and #selcollab4.train2# GTE 1)>checked disabled<cfelseif isdefined("selcollab3.train2") and #selcollab3.train2# GTE 1>  checked</cfif>>TRAIN</td>
<td>Providers will receive ongoing cessation training</td>
</tr>
</table>
</td></tr>
<tr>
	<td><input name="staff" type="checkbox" value="1" <cfif (isdefined("selcollab5.staff") and selcollab5.staff GTE 1)or (isdefined("selcollab4.staff") and selcollab4.staff GTE 1)>checked disabled<cfelseif isdefined("selcollab3.staff") and selcollab3.staff GTE 1>  checked</cfif>></td>
<td>Staff person assigned as Tobacco Dependence Treatment Staff this month</td></tr>
<br></td></tr>
<tr>
	<td><input name="fback" type="checkbox" value="1" <cfif (isdefined("selcollab5.fback") and selcollab5.fback GTE 1)or (isdefined("selcollab4.fback") and selcollab4.fback GTE 1)>checked disabled<cfelseif isdefined("selcollab3.fback") and selcollab3.fback GTE 1>  checked</cfif>></td>
<td>HCPO provides feedback to providers regarding documentation of tobacco dependence treatment</td></tr>
<tr><td><input type="checkbox" name="campus" value="1" <cfif (isdefined("selcollab5.campus") and selcollab5.campus GTE 1)or (isdefined("selcollab4.campus") and selcollab4.campus GTE 1)>checked disabled<cfelseif isdefined("selcollab3.campus") and selcollab3.campus GTE 1>  checked</cfif>></td>
<td>Tobacco-free campus policy implemented this month (including grounds)</td></tr>
			<tr><Td colspan=3>	  <input type="submit" name="addemr"
				<cfif  (((isdefined("form.targ2") and form.targ2 NEQ "") or isdefined("url.targ2") or (isDefined("session.targ2") and session.targ2 NEQ "")) and (isDefined("selcollab3.recordcount") and selcollab3.recordcount NEQ 0))>value="Update" <cfelse> value="Add"</cfif> class="AddButton" onclick="return checkPPG();"><br><br>
				<cfif gettarg2.recordcount is not 0>
<tr>
<td colspan="4">
<table border=".1" class="box" width="100%">
<tr>
	<th align="left">Target HCPO</th>	<th>Delete</th>
</tr>
<cfloop query="gettarg2">
	<tr>
	<td valign="top" bgcolor="##E9FBEC"><a href="../month.cfm?targ2=#seq###ppc">#gettarg2.name#</a></td>
	<td bgcolor="##E9FBEC" align="center"><input type="Checkbox" name="Del_box10" value="#gettarg2.seq#"></td>
	</tr>
</cfloop>
<tr><Td colspan=5>			<tr><td colspan=6 align="right"><input type="submit" name="del_targ" value="Delete" class="DelButton">
</td></tr>
</table>
</th>
</tr></cfif>
</table>
<br><br>
  <cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="fullcoll">
  select c.name, c.indOrg, c.traditional, w.targethcpo as type, c.county,
  c.seq , c.unit,
case when c.unit IS NULL then c.NAME else c.unit + ' ' + NAME end as unitname ,
  del, case tHCPO when 0 then 'No' when 1 then 'Yes' else '-' end as tHCPO,
case tLevel
	when 1 then 'Potential'
	when 2 then 'Limited'
	when 3 then 'Full'
	else '-' end as tLevel,
	entdt,
	case FQHC when 1 then 'Yes' else 'No' end  as FQHC,
	case ref when 1 then 'Yes' else 'No' end  as ref,cess,pip,
  c.school, c.district , isnull(c.sodistrict,0) as sodistrict, isNull(c.sfy, 0) as sfy,
d.district_name,
s.institutionname
  from collaborators as c
left outer join  wrkplan_targethcpo as w on w.targethcpo_id = c.type and w.year2=c.year2
left outer join nysed_district as d on d.district_id = c.district
left outer join nysed_school as s on s.bedscode=c.school
  where userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> and (c.year2 >=1904) and tlevel = 3 and c.year2<cfif session.fy GT 2010 and session.modality EQ 1> >= 2010<cfelse> =<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"></cfif>
  and (c.del is null or c.del !=1)
  <cfif session.modality EQ 4>
  and c.district is not null
  <cfelse>
  and c.county is not null
  </cfif>
 <cfif session.modality EQ 4>order by 17, 18 --13, 12<Cfelse> order by 8,7,1</cfif>
  </cfquery>
          <cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="gettarg3">
  select *
  from monthly_cc m inner join collaborators c on m.seq = c.seq
  and fullz = 1 and mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER"> and m.userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> and m.year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
 order by name
  </cfquery>
     <cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="gettarg33">
  select *
  from monthly_cc
  where mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER"> and userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> and year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
  </cfquery>
  <cfif isdefined("url.targ3")>
          <cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="gettarg4">
  select *
  from monthly_cc m inner join collaborators c on m.seq = c.seq
  and fullz = 1 and m.seq = <cfqueryparam value="#url.targ3#" cfsqltype="CF_SQL_INTEGER"> and mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">  and m.year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
  </cfquery>
	<cfelseif isDefined("form.targ3")>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="gettarg4">
  select *
  from monthly_cc m inner join collaborators c on m.seq = c.seq
  and fullz = 1 and m.seq = <cfqueryparam value="#form.targ3#" cfsqltype="CF_SQL_INTEGER"> and mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">  and m.year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
  </cfquery>
	</cfif>
    <tr><th><a name="outc"></a><h6>Outcome reporting for full partners</h3></th></tr>
<tr><td height=20></td></tr>
<table class="boxy" width=800 cellpadding=10>
<tr><td colspan=6><input name="outc" type="checkbox" value=1 <cfif isdefined("gettarg33.outcome") and #gettarg33.outcome# is 1>checked</cfif>> No outcome data ready for entry this month<br></td></tr>
<tr><th>Target HCPO</td><th>## of patients in sample</th><th>## patients screened for tobacco use </th><th>## patients identified as tobacco users</th>
<th>## of tobacco users ready to quit</th><th>## of tobacco users who receive interventions </th></tr>
<tr><th><select name="targ3"   onchange="javascript: document.wrk.action='month.cfm?#session.urltoken###outc'; form.submit();" >
<cfif collaborators.recordcount is not -1 or (isdefined("form.targ3") and form.targ3 is not '')><option value="">Please select</option></cfif>
<cfloop query="fullcoll">
		<option value="#seq#" <cfif ((isdefined("url.targ3") and #url.targ3# EQ #seq#) or (isdefined("form.targ3") and #form.targ3# EQ #seq#))>selected</cfif>>#name#</option></cfloop>
		</select></td>
		<th><input type="text" name="sampnum" size=4 <cfif isdefined("gettarg4.sampnum")>value="#gettarg4.sampnum#"<cfelse>value=0</cfif>></th>
		<th><input type="text" name="patscreen" size=4 <cfif isdefined("gettarg4.patscreen")>value="#gettarg4.patscreen#"<cfelse>value=0</cfif>></th>
		<th><input type="text" name="patident" size=4 <cfif isdefined("gettarg4.patident")>value="#gettarg4.patident#"<cfelse>value=0</cfif>></th>
<th><input type="text" name="userquit" size=4 <cfif isdefined("gettarg4.userquit")>value="#gettarg4.userquit#"<cfelse>value=0</cfif> onChange="ugh6();">&nbsp;&nbsp;&nbsp;&nbsp; <br><input type="checkbox" name="userquit_na" value=1 onClick="ugh7();">not available</th><th><input type="text" name="userinterv" size=4 <cfif isdefined("gettarg4.sampnum")>value="#gettarg4.userinterv#"<cfelse>value=0</cfif>></th></tr>
			<tr><Td colspan=6>
			<input type="submit" name="addoutrep" <cfif IsDefined("url.targ3") or (isdefined("gettarg4") and gettarg4.recordcount NEQ 0)>value="Update"<cfelse>value="Add"</cfif> class="AddButton" onClick="return checkOK();"><br><br>


<cfif gettarg3.recordcount is not 0>
<tr>
<td colspan="6">
<table border=".1" class="box" width="100%">
<tr>
	<th align="left">Target HCPO</th><th>## of patients in sample</th><th>## patients screened for tobacco use </th><th>## patients identified as tobacco users</th>
<th>## of tobacco users ready to quit</th><th>## of tobacco users who receive interventions </th>	<th>Delete</th>

</tr>
<cfloop query="gettarg3">
	<tr>
	<td valign="top" bgcolor="##E9FBEC"><a href="../month.cfm?targ3=#seq###outc">#gettarg3.name#</a></td>
	<th bgcolor="##E9FBEC">#gettarg3.sampnum#</th><th bgcolor="##E9FBEC">#gettarg3.patscreen#</th><th bgcolor="##E9FBEC">#gettarg3.patident#</th>
<th bgcolor="##E9FBEC">#gettarg3.userquit#&nbsp;&nbsp;&nbsp;&nbsp;<br> <cfif #gettarg3.userquit_na# is 1>Not available</cfif></th>
<th bgcolor="##E9FBEC">#gettarg3.userinterv#</th>
	<td bgcolor="##E9FBEC" align="center"><input type="Checkbox" name="Del_box7" value="#gettarg3.seq#"></td>
	</tr>
</cfloop>
			<tr><td colspan=7 align="right"><input type="submit" name="del_targ" value="Delete" class="DelButton">
</td></tr>
</table>
</th>
</tr></cfif>
</table>
<p></p>
</cfif>
<cfif getverk.advoc is 1 and session.objval is not '1A'>
	  <th align="left" width="800"><a name="advadv"></a><h6>Advocating with Organizational Decision Makers<br><br></th></tr>
<cfif session.fy LT 2012 >
<tr><td colspan=4></h6>Mass mailing sent to
<cfif isDefined("form.advmassmail") and form.advmassmail NEQ "">
	<cfinput name="advmassmail" type="text" value="#form.advmassmail#" size=3 required="no" message="You must enter a number for mass mailings sent to organizations" validate="integer">
<cfelse>
	<cfinput name="advmassmail" type="text" value="#mon.advmassmail#" size=3 required="no" message="You must enter a number for mass mailings sent to organizations" validate="integer">
</cfif> organizations this month</td></tr>
</cfif>
<cfif #session.modality# is 1 and #session.objval# is '1E'>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="Qccorg">
select
	*
	from monthly_org tor left join target_org t on tor.org = t.targid and tor.year2 = t.year2
	where
	tor.userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and tor.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and tor.initnum=<cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	and tor.mon=<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER"> <cfif session.fy LT 2012> and t.stratnum=1</cfif>
	order by name
</cfquery>
<cfif isDefined("form.addcc")>
		<cfset form.targ7 = "">
		<cfset form.adcomm = "">
		<cfset form.prvtrain = "">
		<cfset form.techass1 = "">
</cfif>
<cfif (isDefined("url.target") and url.target EQ "aodm")>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QccorgDet">
	select
	*
	from monthly_org tor
	where
	tor.userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and tor.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and tor.initnum=<cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	and tor.mon=<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
	and tor.monthlyorgid = <cfqueryparam value="#url.seq#" cfsqltype="CF_SQL_INTEGER">
</cfquery>
<cfif  QccorgDet.recordcount NEQ 0>
	<cfset form.targ7 = QccorgDet.org>
</cfif>
<cfelseif (isDefined("form.targ7") and form.targ7 NEQ "") and NOT (isDefined("url.target") and url.target EQ "advadv")>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QccorgDet">
select
	*
	from monthly_org tor
	where
	tor.userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and tor.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and tor.initnum=<cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	and tor.mon=<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
	and tor.org = <cfqueryparam value="#form.targ7#" cfsqltype="CF_SQL_INTEGER">
</cfquery>
<cfset form.targ7 = form.targ7>
<cfif QccorgDet.recordcount EQ 0>
		<cfset form.adcomm = "">
		<cfset form.prvtrain = "">
		<cfset form.techass1 = "">
</cfif>
</cfif>
<cfif (isDefined("QccorgDet") and QccorgDet.recordcount NEQ 0)>
	<cfset form.adcomm = QccorgDet.adcomm>
		<cfset form.prvtrain = QccorgDet.prvtrain>
		<cfset form.techass1 = QccorgDet.techass>
<input type="hidden" name="targid02a" value="<cfoutput>#QccorgDet.monthlyorgid#"</cfoutput>>
</cfif>
<cfif form.dofunction is 'addCC' or isdefined("addcc")>
		<cfset form.targ7 = "">
		<cfset form.adcomm = "">
		<cfset form.prvtrain = "">
		<cfset form.techass1 = "">
</cfif>
<cfparam name="form.targ7" default = "">
<cfparam name="form.adcomm" default = "">
<cfparam name="form.prvtrain" default = "">
<cfparam name="form.techass1" default = "">

	  <tr><td><table class="boxs" width=775>		  		<tr><td height=10></td></tr>
  <tr><td><table class="boxy" border=".1" width=800>
<a name="targ"></a>
<tr>
	<th width="30%" valign="bottom">Target organization</th>
	<th>Obtained administrative<br> commitment</th>
	<th valign="bottom">Provided training</th>
	<th>Provided technical<br>assistance</th>
</tr>
	  <tr>	<td>
				<select name="targ7"  <!--- onChange="javascript: document.wrk.action='month.cfm?#session.urltoken###targ'; form.submit();" --->>
	  		<option value="">Please select</option>
<cfloop query="targcc">
	<option value="#targid#" <cfif form.targ7 EQ targid>selected</cfif>>#name#</option></cfloop>
		</select>
		</td><td align="center">
		<input type="checkbox" name="adcomm" value=1 <cfif form.adcomm EQ 1>checked</cfif>>
</td>
<td align="center"><input type="checkbox" name="prvtrain" value=1 <cfif form.prvtrain EQ 1>checked</cfif>></td>
<td align="center"><input type="checkbox" name="techass1" value=1 <cfif form.techass1 EQ 1>checked</cfif>></td>
<tr><Td colspan=5>
	<input type="submit" name="addcc"
			<cfif (isDefined("QccorgDet") and QccorgDet.recordcount NEQ 0 and not (form.dofunction is 'addCC' or isdefined("addcc")))>value="Update"
			<cfelse>value="Add"</cfif> class="AddButton" onClick="return checkCC();">
</td></tr>
		  		<tr><td height=10 colspan=5></td></tr>
<cfif Qccorg.recordcount GT 0>
<tr>
<td colspan="5">
<table border=".1" class="box" bgcolor="##B3C2F4" width=800>
<tr><th>Target organization</th>
	<th>Obtained administrative<br> commitment</th>
		<th>Provided training</th>
			<th>Provided technical<br>assistance</th>
	<th>Delete</th>
</tr>
<cfoutput>
	<cfloop query="Qccorg">
	<tr>
		<td valign="top" bgcolor="##E9FBEC"><a href="javascript: document.wrk.action='month.cfm?#session.urltoken#&target=aodm&seq=#monthlyorgid###targ'; document.wrk.submit()">#name#</a></td>
		<td valign="top" bgcolor="##E9FBEC" align="center"><input name="" type="checkbox" disabled="true" <cfif #adcomm# is 1>checked</cfif>></td>
				<td valign="top" bgcolor="##E9FBEC" align="center"><input name="" type="checkbox" disabled="true" <cfif #prvtrain# is 1>checked</cfif>></td>
						<td valign="top" bgcolor="##E9FBEC" align="center"><input name="" type="checkbox" disabled="true" <cfif #techass# is 1>checked</cfif>></td>
		<td valign="top" bgcolor="##E9FBEC" align="center"><input type="Checkbox" name="Del_box9" value="#monthlyorgid#"></td>
	</tr>
</cfloop>
		<tr><td colspan=6 align="right"><input type="submit" name="del_targ" value="Delete" onClick="return checkMGG();" class="DelButton">
</cfoutput>
</cfif>
</table></td></tr>
</table></td></tr>
		  		<tr><td height=10></td></tr>
<p></p>
</cfif>
<cfif session.modality is not 1>
		 <tr><td>
		 <table <cfif session.fy GTE 2011>class="boxyw"<cfelse>class="boxy"</cfif> border=".1" width=800>
<a name="targ"></a>
<cfif session.fy LT 2012>
<tr><th width="30%">Org name</th><th>## meetings</th><th>## phone calls</th><th>## letters</th><th>## emails</th></tr>
	  <tr>	<td>
				<select name="targ">
	  		<cfif targadv.recordcount is not -1><option value="">Please select</option></cfif>
<cfloop query="targadv">
		<option value="#targid#">#name#</option></cfloop>
		</select>
		</td><td align="center">
		<input name="meet" type="text" size="4" maxlength="4" value=0>
</td>
<td align="center"><input name="fon" type="text" size="4" maxlength="4" value=0></td>
<td align="center"><input name="lett" type="text" size="4" maxlength="4" value=0></td>
<td align="center"><input name="email" type="text" size="4" maxlength="4" value=0></td></tr>
<tr><Td colspan=5>	  <input type="submit" name="addadvocating" value="Add" class="AddButton" onClick="return checkAG();">
</td></tr>
		  		<tr><td height=10 colspan=5></td></tr>
<cfif Qadvorg.recordcount GT 0>
<tr>
<td colspan="5">
<table border=".1" class="box" bgcolor="##B3C2F4" width=800>
<tr>
	<th>Org name</th>
	<th>## meetings</th>
		<th>## phone calls</th>
			<th>## letters</th>
				<th>## emails</th>
	<th>Delete</th>
</tr>
<cfoutput><cfloop query="Qadvorg">
	<tr>
		<td valign="top" bgcolor="##E9FBEC">#name#</td>
		<td valign="top" bgcolor="##E9FBEC" align="center">#meet#</td>
				<td valign="top" bgcolor="##E9FBEC" align="center">#phone#</td>
						<td valign="top" bgcolor="##E9FBEC" align="center">#letter#</td>
								<td valign="top" bgcolor="##E9FBEC" align="center">#email#</td>
		<td valign="top" bgcolor="##E9FBEC" align="center"><input type="Checkbox" name="Del_box2" value="#org#"></td>
	</tr>
</cfloop>
		<tr><td colspan=7 align="right"><input type="submit" name="del_targ" value="Delete" onClick="return checkMGG();" class="DelButton">
</cfoutput>
</cfif>
<cfelse>
<tr>
	<th width="30%" valign="bottom">Target Name</th>
	<th>Select the categories which best describe the nature of your conversation with this Organizational Decision-maker</th>
	<th >Describe your interaction with this target this month</th>
</tr>
</tr>
	  <tr>	<td>
		  <cfif isdefined("url.seq") and isdefined("url.target") and url.target is 'advadv'>
		 <cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QccorgDet">
	select distinct tor.targid,name,targdisp
from target_org tor
where tor.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> and tor.initnum = <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
and tor.userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
and tor.stratnum = 1 and targid = <cfqueryparam value="#url.seq#" cfsqltype="CF_SQL_INTEGER">
order by name	</cfquery>
	</cfif>
				<select name="targ7">
	  		<option value="">Please select</option>
	  		<cfif isdefined("url.seq") and isdefined("url.target") and url.target is 'advadv'>
<cfloop query="QccorgDet">
	<option value="#targid#" <cfif ((isDefined("form.targ7") and form.targ7 EQ targid )or (isDefined("url.target") and url.target EQ "advadv" and url.seq EQ targID)) and not isDefined(("form.addcc"))> selected</cfif>><cfif #targdisp# is 1>*</cfif>#name#</option>
</cfloop>
<cfelse>
<cfloop query="targcc">
<option value="#targid#" <cfif ((isDefined("form.targ7") and form.targ7 EQ targid )) and not isDefined(("form.addcc"))> selected</cfif>><cfif #targdisp# is 1>*</cfif>#name#</option>
</cfloop>
</cfif>
 		</select>
		</td>
	<td align="ceneftter">
		<input type="checkbox" name="adcomm" value=1 <cfif (isDefined("QgettargXXa") and QgettargXXa.adcomm EQ 1)  <!--- or (isDefined("form.adcomm") and form.adcomm EQ 1) --->> checked</cfif>>Education about the issue<br>
		<input type="checkbox" name="prvtrain" value=1 <cfif isDefined("QgettargXXa") and QgettargXXa.prvtrain EQ 1  <!--- or (isDefined("form.prvtrain") and form.prvtrain EQ 1) --->> checked</cfif>>Education about policy solutions<br>
		<input type="checkbox" name="techass1" value=1 <cfif isDefined("QgettargXXa") and QgettargXXa.techass EQ 1  <!--- or (isDefined("form.techass1") and form.techass1 EQ 1) --->> checked</cfif>>Obtained commitment for policy
	</td>
	<td>
		<textarea name="adcomm_descr" id="adcomm_descr" cols="50" maxlength="1500" rows="5" onkeyup="countitAny('adcomm_descr','adcommdisplaycount');"><cfif isDefined("QgettargXXa")>#QgettargXXa.descr#</cfif></textarea>
<div align="left">This text field has a max of 1500 characters. Characters entered: <cfoutput><input type="text" value="<cfif isDefined("QgettargXXa")>#len(QgettargXXa.descr)#<cfelse>0</cfif>" name="adcommdisplaycount" id="adcommdisplaycount" size="4" style="border:0;" disabled></cfoutput></div>

	</td>
	</tr>
	<tr><td><input type="button" value="Check Spelling" onClick="spell('document.wrk.adcomm_descr.value')"><br>
<cfif isDefined("QgettargXXa") and  (QgettargXXa.recordcount NEQ 0)>
			<input type="submit" name="addcc" value="Update" class="AddButton" onClick="return checkCC();">
<cfelse>
<input type="submit" name="addcc" value="Add" class="AddButton" onClick="return checkCC();">
</cfif>
</td></tr>
<tr><td height=10 colspan=5></td></tr>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="Qcc">
	select
	*,
	case org when 999 then 'MPAA' when 888 then 'YouTube' when 777 then 'Major television network' else ltrim(rtrim(name)) end as nameX
	from monthly_org tor left join target_org t on tor.org = t.targid and tor.year2 = t.year2
	where
	tor.userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and tor.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and tor.initnum=<cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	and tor.mon=<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
	<cfif session.fy LT 2012> and t.stratnum=1
	<cfelseif session.fy GTE 2012><cfif session.objval EQ "3m">and isNull(t.stratnum,0)!=2<!--- and t.stratnum = 1 ---> <cfelse>and isNull(t.stratnum,0)!=2</cfif></cfif>
<!---  note that for 3m, this was just changed to stratnum=1 for modaliity 3 dp 9/23/11  --->
	order by  case org when 999 then 'MPAA' when 888 then 'YouTube' when 777 then 'Major television network' else ltrim(rtrim(name)) end
	</cfquery>
<cfif isDefined("Qcc") and Qcc.recordcount GT 0>
<tr>
<td colspan="5">
<table border=".1" class="box" bgcolor="##B3C2F4" width=800>
<tr><th  width="30%" >Target name</th>
	<th>Select the categories which best describe the nature of your conversation with this Organizational Decision-maker</th>
		<th>Describe your interaction with this target this month</th>
	<th>Delete</th>
</tr>
<cfoutput>	<cfloop query="Qcc">
	<tr>
		<td valign="top" bgcolor="##E9FBEC"><a href="javascript: document.wrk.action='month.cfm?#session.urltoken#&target=advadv&seq=#org###advadv'; document.wrk.submit()">
			<!--- <cfif org EQ 999>MPAA
			<cfelseif org EQ 888>YouTube
			<cfelseif org EQ 777>Major television network
			<cfelse> --->
			<cfif #targdisp# is 1>*</cfif>#namex#<!--- </cfif> ---></a></td>
		<td valign="top" bgcolor="##E9FBEC">
			<cfif #adcomm# is 1>Education about the issue<br></cfif>
			<cfif #prvtrain# is 1>Education about policy solutions<br></cfif>
		<cfif #techass# is 1>Obtained commitment for policy<br></cfif>
</td>
						<td valign="top" bgcolor="##E9FBEC" align="center">#descr#</td>
		<td valign="top" bgcolor="##E9FBEC" align="center"><input type="Checkbox" name="Del_box9" value="#monthlyorgid#"></td>
	</tr>
</cfloop>
		<tr><td colspan=6 align="right"><input type="submit" name="del_targ" value="Delete" onClick="return checkMGG();" class="DelButton">
</cfoutput>
</cfif>
</cfif>
</cfif>
		  		<tr><td height=10 colspan=6></td></tr>
</table></td></tr>
</cfif>
		<tr><td height=10 colspan=6></td></tr>
</table></td></tr>
 </cfif>
		  		<tr><td height=10></td></tr>
<cfif #getverk.commmob# is 1>
<tr><td height=10></td></tr>
 <th align="left" height=1 valign="bottom"><a name="commmob"></a><h6>Community Mobilization strategy<br><br></th></tr>
		  <tr><td><table class="boxs" width=775>
		   <tr><td valign="top"><table <cfif session.fy GTE 2011>class="boxyw"<cfelse>class="boxy"</cfif> border=".1" width=800>
<a name="targ"></a>	  <tr><th width="30%">Target name</th><th colspan=<cfif session.objval EQ '2e'  or session.objval eq '3m' or session.objval eq '4f'>3<cfelse>2</cfif>>
Which strategies did your interaction with this target contribute to?</th><th>Were youth directly involved in this strategy?</th>
<th>How did this target help advance/achieve your <cfif session.objval EQ '2e'>tobacco-free outdoors<cfelseif session.objval EQ '4f'>SF Multi-unit Housing<cfelseif session.objval EQ '3M'>SFM<cfelse>POS</cfif> outcome this month?</th></tr>
	  <tr>	<td>
      <cfif isdefined("QgettargCommmob.monthlycommmobid")>
      <input type="hidden" name="targy" value="#QgettargCommmob.monthlycommmobid#"></cfif>
				<select name="targ2a" <!--- onChange="javascript: document.wrk.action='month.cfm?#session.urltoken###commmob'; document.wrk.submit()" ---><!---  --->>
	  		<cfif targCommmob.recordcount is not -1><option value="">-Please select-</option></cfif>
<cfloop query="targCommmob">
<!--- <cfif targgovt.tm is 0>
 --->		<option value="#targid#" <cfif (isDefined("QgettargCommmob") and QgettargCommmob.target EQ targid) or (isDefined("form.targ2a") and form.targ2a eq targid)> selected</cfif>><cfif #targdisp# is 1>*</cfif>#name#</option><!--- </cfif> ---></cfloop>
				<option value="0" <cfif (isDefined("QgettargCommmob") and QgettargCommmob.target EQ 0) or (isDefined("form.targ2a") and form.targ2a eq 0)> selected</cfif>>Unaffiliated youth</option></select>
		</td><td align="center">Community Education<br>
		<input name="commed" type="checkbox" value=1 <cfif isDefined("QgettargCommmob") and QgettargCommmob.commed EQ 1> checked</cfif>>
</td>
<cfif session.objval EQ '2e' or session.objval eq '3m' or session.objval is '4f'>
<td align="center">Advocating with decision-makers<br>
		<input name="Advoc" type="checkbox" value=1<cfif isDefined("QgettargCommmob") and QgettargCommmob.advoc EQ 1> checked</cfif>>
</td>
</cfif>
<td align="center">Gov't Policy-maker Education<br>
		<input name="govt" type="checkbox" value=1<cfif isDefined("QgettargCommmob") and QgettargCommmob.gpme EQ 1> checked</cfif>>
</td>
<td align="center">&nbsp;<input type="radio" name="youth" value=1<cfif isDefined("QgettargCommmob") and QgettargCommmob.youth EQ 1> checked</cfif>> Yes<br>
<input type="radio" name="youth" value=0 <cfif isDefined("QgettargCommmob") and QgettargCommmob.youth EQ 0> checked</cfif>> No</td>
<td align="center"><textarea maxlength="1500" name="advance" id="advance" cols=50 rows=5 onkeyup="countitAny('advance','advancedisplaycount');"><cfif isDefined("QgettargCommmob")>#QgettargCommmob.descr#</cfif></textarea>
<div align="left">This text field has a max of 1500 characters. Characters entered: <cfoutput><input type="text" value="<cfif isDefined("QgettargCommmob")>#len(QgettargCommmob.descr)#<cfelse>0</cfif>" name="advancedisplaycount" id="advancedisplaycount" size="4" style="border:0;" disabled></cfoutput></div>
</td>
</tr>
<tr>
	<Td colspan=<cfif session.objval EQ '2e' or session.objval eq '3m' or session.objval eq '4f'>6<cfelse>5</cfif>>
		<input type="button" value="Check Spelling" onClick="spell('document.wrk.advance.value')"><br>
		<cfif isDefined("QgettargCommmob") and  (QgettargCommmob.recordcount NEQ 0)>
			<input type="submit" name="addcommmob" value="Update" class="AddButton" onClick="return checkCMMOB();">
		<cfelse>
			<input type="submit" name="addcommmob" value="Add" class="AddButton" onClick="return checkCMMOB();">
		</cfif>
</td>
</tr>
<tr><Td colspan=<cfif session.objval EQ '2e' or session.objval eq '3m' or session.objval eq '4f'>6<cfelse>5</cfif>>
		  		<tr><td height=10 colspan=<cfif session.objval EQ '2e' or session.objval eq '3m' or session.objval eq '4f'>6<cfelse>5</cfif>></td></tr>
<cfif Qcommob.recordcount GT 0>
<tr>
<td colspan="6">
<table border=".1" class="box" bgcolor="##B3C2F4" width=800>
<tr>
	<th rowspan="2">Target name</th>
	<th <cfif session.objval EQ '2e' or session.objval EQ '3m' OR (session.fy GTE 2015 and session.objval EQ '4F')>colspan="3"<cfelse>colspan="2"</cfif>>Which strategies did your interation with this target contribute to?</th>
		<th rowspan="2">Were youth directly involved in this strategy?</th>
			<th rowspan="2">How did this target help advance/achieve your
				<cfif session.objval EQ '2e'>tobacco-free outdoors<cfelseif session.objval EQ '4f'>SF Multi-unit Housing<cfelseif session.objval EQ '3M'>SFM<cfelse>POS</cfif>
				<!--- <cfif session.objval EQ '2e' or session.objval EQ '3m'>tobacco-free outdoors<cfelse>POS</cfif> --->
				outcome this month?</th>
				<th rowspan="2">Delete</th>
</tr>
<tr>
	<th>Community Education</th>
	<cfif session.objval EQ '2e' or session.objval EQ '3m' OR (session.fy GTE 2015 and session.objval EQ '4F')><th>Advocating with decision-makers</th></cfif>
	<th>Gov't Policy-maker Education</th>
</tr>
<cfoutput><cfloop query="Qcommob">
	<tr>
		<td valign="top" bgcolor="##E9FBEC"><a href="javascript: document.wrk.action='month.cfm?#session.urltoken#&target=commmob&seq=#monthlycommmobid###commmob'; document.wrk.submit()"><cfif #targdisp# is 1>*</cfif>#target#</a></td>
		<td valign="top" align="center" bgcolor="##E9FBEC">#commed#</td>
		<cfif session.objval EQ '2e' or session.objval EQ '3m' OR (session.fy GTE 2015 and session.objval EQ '4F')><td valign="top" bgcolor="##E9FBEC" align="center">#advoc#</td></cfif>
		<td valign="top" align="center" bgcolor="##E9FBEC">#gpme#</td>
		<td valign="top"  align="center" bgcolor="##E9FBEC">#youth#</td>
		<td valign="top" bgcolor="##E9FBEC">#descr#</td>
		<td valign="top" bgcolor="##E9FBEC"><input type="checkbox" name="del2a" value="#monthlycommmobid#"></td>
		<!--- <td valign="top" bgcolor="##E9FBEC" align="center"><input name="" type="text" disabled="true" value="#meet#" size="4" maxlength="4" readonly="true"></td>
				<td valign="top" bgcolor="##E9FBEC" align="center"><input name="" type="text" disabled="true" value="#phone#" size="4" maxlength="4" readonly="true"></td>
						<td valign="top" bgcolor="##E9FBEC" align="center"><input name="" type="text" disabled="true" value="#letter#" size="4" maxlength="4" readonly="true"></td>
								<td valign="top" bgcolor="##E9FBEC" align="center"><input name="" type="text" disabled="true" value="#email#" size="4" maxlength="4" readonly="true"></td>
		<td valign="top" bgcolor="##E9FBEC" align="center"><input type="Checkbox" name="Del_box2" value="#org#"></td> --->
	</tr>
</cfloop>
		<tr><td colspan=7 align="right"><input type="submit" name="del_targ" value="Delete" onClick="return checkcmmmob();" class="DelButton">
</cfoutput>
</cfif>
</table></td></tr>
</cfif>
</table></td></tr>
		  		<tr><td height=10></td></tr>
<cfif #getverk.govt# is 1>
<tr><td height=10></td></tr></table>
	  <th align="left"><a name="gov"></a><h6>Government Policy Maker Education<br><br></th>
  <tr><td><table class="boxs" width=775>
<cfif session.fy GTE 2012>
<cfif session.fy LT 2012>
<tr><td colspan=4>Mass mailing sent to
	<cfif isDefined("form.govtmassmail") and form.govtmassmail NEQ "">
	<cfinput name="govtmassmail" type="text" value="#form.govtmassmail#" size=3 required="no" message="You must enter a number" validate="integer">
<cfelse>
	<cfinput name="govtmassmail" type="text" value="#mon.govtmassmail#" size=3 required="no" message="You must enter a number" validate="integer">
	</cfif>
	 government policy makers</td></tr>
</cfif>
	  <tr><td><table <cfif session.fy GTE 2011>class="boxyw"<cfelse>class="boxy"</cfif> border=".1" >
<a name="targ"></a>	  <tr><th width="30%">Target name</th><th width="200px">Select the categories which best describe the nature of the conversation with this Government Policy-maker</th><th>Describe your interaction with this target this month</th></tr>
	  <tr>	<td>
				<select name="targ2"  <!--- onChange="javascript: document.wrk.action='month.cfm?#session.urltoken###gov'; document.wrk.submit()" --->>
	  		<cfif targgovt.recordcount is not -1><option value="">Please select</option></cfif>
<cfloop query="targgovt">
<!--- <cfif targgovt.tm is 0>
 --->		<option value="#targid#" <cfif (isDefined("QgettargX") and QgettargX.org EQ targid) or (isDefined("form.targ2") and form.targ2 eq targid)> selected</cfif>><cfif #targdisp# is 1>*</cfif>#name#</option><!--- </cfif> --->
 </cfloop>
 <input type="hidden" name="targname" value="gettargx.targname">
		</select>
		</td><td nowrap="true">Select all that apply:<br>
		<input type="checkbox" name="nature1" value=1 <cfif isDefined("QgettargX") and QgettargX.nature1 EQ 1> checked</cfif>> Education about the issue<br>
		<input type="checkbox" name="nature2" value=1 <cfif isDefined("QgettargX") and QgettargX.nature2 EQ 1> checked</cfif>> Education about policy solutions<br>
		<input type="checkbox" name="nature3" value=1 <cfif isDefined("QgettargX") and QgettargX.nature3 EQ 1> checked</cfif>> Voiced support for policy
</td>
<td align="center"><textarea maxlength="1500" name="interact" id="interact" cols=50 rows=5 onkeyup="countitAny('interact','interactdisplaycount');"><cfif isDefined("QgettargX")>#QgettargX.interact#</cfif></textarea>
<div align="left">This text field has a max of 1500 characters. Characters entered: <cfoutput><input type="text" value="<cfif isDefined("QgettargX")>#len(QgettargX.interact)#<cfelse>0</cfif>" name="interactdisplaycount" id="interactdisplaycount" size="4" style="border:0;" disabled></cfoutput></div></td>
</tr>
<cfelse>
<tr><td colspan=4>Mass mailing sent to
	<cfif isDefined("form.govtmassmail") and form.govtmassmail NEQ "">
	<cfinput name="govtmassmail" type="text" value="#form.govtmassmail#" size=3 required="no" message="You must enter a number" validate="integer">
<cfelse>
	<cfinput name="govtmassmail" type="text" value="#mon.govtmassmail#" size=3 required="no" message="You must enter a number" validate="integer">
</cfif>	 government policy makers</td></tr>
	  <tr><td><table <cfif session.fy GTE 2011>class="boxyw"<cfelse>class="boxy"</cfif> border=".1" width=800>
<a name="targ"></a>	  <tr><th width="30%">Org name</th><th>## meetings</th><th>## phone calls</th><th>## letters</th><th>## emails</th></tr>
	  <tr>	<td>
				<select name="targ2">
	  		<cfif targgovt.recordcount is not 1><option value="">Please select</option></cfif>
<cfloop query="targgovt">
<option value="#targid#"><cfif #targdisp# is 1>*</cfif>#name#</option><!--- </cfif> ---></cfloop>
		</select>
		</td><td align="center">
		<input name="meet2" type="text" size="4" maxlength="4" value=0>
</td>
<td align="center"><input name="phone2" type="text" size="4" maxlength="4" value=0></td>
<td align="center"><input name="letter2" type="text" size="4" maxlength="4" value=0></td>
<td align="center"><input name="email2" type="text" size="4" maxlength="4" value=0></td></tr>
</cfif>
<tr>
	<Td colspan=5><input type="button" value="Check Spelling" onClick="spell('document.wrk.interact.value')"><br>
		<cfif (isDefined("QgettargX") and QgettargX.recordcount GT 0) or (isDefined ("url.seq") and url.target EQ 'gov')>
			<input type="submit" name="addgovernment" value="Update" class="AddButton" onClick="return checkBG();">
			<cfelse>
		<input type="submit" name="addgovernment" value="Add" class="AddButton" onClick="return checkBG();">
		</cfif>
	</td>
</tr>
<tr><Td colspan=5>
		  		<tr><td height=10 colspan=5></td></tr>
<cfif Qgovtorg.recordcount GT 0>
<cfif session.fy GT 2011>
<tr>
<td colspan="5">
<table border=".1" class="box" bgcolor="##B3C2F4" width=800>
<tr>
	<th>Target name</th>
	<th>Categories</th>
		<th>Describe your interactions</th>
	<th>Delete</th>
</tr>
<cfoutput><cfloop query="Qgovtorg">
	<tr>
		<td valign="top" bgcolor="##E9FBEC"><a href="javascript: document.wrk.action='month.cfm?#session.urltoken#&target=gov&seq=#monthlyorgID###gov'; document.wrk.submit()"><cfif #targdisp# is 1>*</cfif>#name#</a></td>
		<td valign="top" bgcolor="##E9FBEC" nowrap="true">
		<cfif nature1 EQ 1> Education about the issue<br></cfif>
		<cfif nature2 EQ 1> Education about policy solutions<br></cfif>
		<cfif nature3 EQ 1> Voiced support for policy</cfif>
		</td>
				<td valign="top" bgcolor="##E9FBEC" align="center">#interact#</td>
		<td valign="top" bgcolor="##E9FBEC" align="center"><input type="Checkbox" name="Del_box2" value="#org#"></td>
	</tr>


</cfloop>
		<tr><td colspan=6 align="right"><input type="submit" name="del_targ" value="Delete" onClick="return checkMGG();" class="DelButton">

</cfoutput>



<cfelse>

<tr>
<td colspan="5">
<table border=".1" class="box" bgcolor="##B3C2F4" width=800>
<tr>
	<th>Org name</th>
	<th>## meetings</th>
		<th>## phone calls</th>
			<th>## letters</th>
				<th>## emails</th>
	<th>Delete</th>
</tr>
<cfoutput><cfloop query="Qgovtorg">
	<tr>
		<td valign="top" bgcolor="##E9FBEC">#name#</td>
		<td valign="top" bgcolor="##E9FBEC" align="center">#meet#</td>
		<td valign="top" bgcolor="##E9FBEC" align="center">#phone#</td>
		<td valign="top" bgcolor="##E9FBEC" align="center">#letter#</td>
		<td valign="top" bgcolor="##E9FBEC" align="center">#email#</td>
		<td valign="top" bgcolor="##E9FBEC" align="center"><input type="Checkbox" name="Del_box2" value="#org#"></td>
	</tr>
</cfloop>
		<tr><td colspan=6 align="right"><input type="submit" name="del_targ" value="Delete" onClick="return checkMGG();" class="DelButton">
</cfoutput>
</cfif>
</table></td></tr>
</cfif>
</cfif>
</table></td></tr>
		  		<tr><td height=10></td></tr>
<cfif #getverk.comm# is 1><tr><td height=10></td></tr></table>
 <th align="left" height=1 valign="bottom"><a name="commmob"></a><h6>Community Education<br><br></th></tr>
		  <tr><td><table class="boxs" width=775>
	  <tr><td><table <cfif session.fy GTE 2011>class="boxyw"<cfelse>class="boxy"</cfif> border=".1" width=775>
<a name="targ"></a>
<tr>
	<th <cfif session.fy GTE 2012> colspan="2"</cfif>>Target</th>
	<th width="60%"><cfif session.objval is '3m' or session.objval is '2d' and session.modality is '3'>Brief description of what you did to educate the community<cfelse>Brief description of event</cfif></th>
	<cfif session.fy LT 2012><th>County</th></cfif>

	<cfif session.fy LT 2012>
		<th>## of people attending</th>
		<th>Organized or participated?</th>
	</cfif>
</tr>
	  <tr>
	  <td align="center" valign="top"<cfif session.fy GTE 2012> colspan="2"</cfif>>
				<input type="text" size=70 maxlength=70 name="target" <cfif isDefined("QgetTargXX")> value="#Qgettargxx.target#"</cfif>>
</td>
	  <td>
				<!--- <input type="text" size=40 maxlength=40 name="event" <cfif isDefined("QgetTargXX")> value="#Qgettargxx.event#"</cfif>> --->
		<textarea name="event" cols="80" rows="4"><cfif isDefined("QgetTargXX")>#Qgettargxx.event#</cfif></textarea>
		</td>
		<cfif session.fy LT 2012>
		<td align="center">
		<select name="county">
		<option value="">Please select</option>
	  		<cfloop query="counties">
				<option value="#countyname#">#countyname#</option>
			</cfloop>
		</select>
		</td>
		</cfif>

<cfif session.fy LT 2012>
<td align="center">
<input name="attend" type="text" size="5" maxlength="5">
 </td>
<td align="left"><input type="radio" name="orgpart" value=1>Organized<br><input type="radio" name="orgpart" value=2>Participated	    </td>
</cfif>
<tr><Td colspan=<cfif session.fy LT 2012>5<cfelse>3</cfif>>	  <input type="button" value="Check Spelling" onClick="spell('document.wrk.event.value')">
<br><cfif isDefined("QgetTargXX") and isDefined("url.seq")>
	<input type="submit" name="addcommunity" value="Update" class="AddButton" onClick="return checkCG();">
<cfelse>
<input type="submit" name="addcommunity" value="Add" class="AddButton" onClick="return checkCG();">
</cfif>
</td>
</tr>
<cfif Qcommorg.recordcount GT 0>
		  <tr><td colspan=5><table class="box" border=".1" width=775>
<a name="targ"></a>
<tr>
	<th>Target</th><th width="60%"><cfif session.objval is '3m' or session.objval is '2d' and session.modality is '3'>Brief description of what you did to educate the community<cfelse>Brief description of event</cfif></th>
	<cfif session.fy LT 2012><th>County</th></cfif>

	<cfif session.fy LT 2012><th>## of people attending</th>
	<th>Organized or participated?</th>	</cfif>
	<th>Delete</th>
</tr>
<cfloop query="qcommorg">
	<tr>
	<td align="center" bgcolor="##E9FBEC">
		<cfif session.fy GTE 2012><a href="javascript: document.wrk.action='month.cfm?#session.urltoken#&target=comm&seq=#qcommorg.monthlycommid###comm'; document.wrk.submit()">#qcommorg.target#</a>
		<cfelse>
		#qcommorg.target#
		</cfif>
	</td>
	<td bgcolor="##E9FBEC" height="20"  width="80%">

	#qcommorg.event#
	</td>
	<cfif session.fy LT 2012><td align="center" bgcolor="##E9FBEC">#qcommorg.county#</td></cfif>

	<cfif session.fy LT 2012><td align="center" bgcolor="##E9FBEC">#qcommorg.attend#</td>
	<td align="left" bgcolor="##E9FBEC">
		<cfif #qcommorg.orgpart# is 1>Organized
		<cfelseif #qcommorg.orgpart# is 2>Participated
		</cfif>
	</td></cfif>
	<td valign="top" bgcolor="##E9FBEC" align="center"><input type="Checkbox" name="Del_box3" value="#qcommorg.monthlycommid#"></td>
	</tr>
</cfloop>
<!--- <tr><Td colspan=5> --->
<tr><td <cfif session.fy LT 2012>colspan=6<cfelse>colspan=3</cfif> align="right"><input type="submit" name="del_targ" value="Delete" onClick="return checkMGG();" class="DelButton">
</td></tr></table>
</td></tr></cfif>
</table></td></tr></cfif>
		  		<tr><td height=10></td></tr>
<cfif #getverk.media# is 1>
		  		<tr><td height=10></td></tr></table>
	  <th align="left"><a name="pm"></a><h6>Paid Media<br><br></th>
	  <tr><td><table <cfif session.fy GTE 2011>class="boxyw"<cfelse>class="boxy"</cfif> border=".1" width=775>
	  <tr><th width="20%">Media type</td><th>Name of media channel(s)</td><th>Title of spot</td><th>Number run/ aired/ printed</td><th>Cost</td></tr>
	  <tr>	<td>
	  <select name="mediatype">
	  <option value="">Please select</option>
	  <option value="Billboard" <cfif isDefined("QgettargXXXs") and QgettargXXXs.mediatype EQ "Billboard"> selected</cfif>>Billboard</option>
	  <option value="Digital/website" <cfif isDefined("QgettargXXXs") and QgettargXXXs.mediatype EQ "Digital/website"> selected</cfif>>Digital/website</option>
	   <option value="Magazine" <cfif isDefined("QgettargXXXs") and QgettargXXXs.mediatype EQ "Magazine"> selected</cfif>>Magazine</option>
	   <option value="Newspaper" <cfif isDefined("QgettargXXXs") and QgettargXXXs.mediatype EQ "Newspaper"> selected</cfif>>Newspaper</option>
	    <option value="Radio" <cfif isDefined("QgettargXXXs") and QgettargXXXs.mediatype EQ "Radio"> selected</cfif>>Radio</option>
	    	  <option value="Theater slide" <cfif isDefined("QgettargXXXs") and QgettargXXXs.mediatype EQ "Theater slide"> selected</cfif>>Theater slide</option>
  <option value="Transit" <cfif isDefined("QgettargXXXs") and QgettargXXXs.mediatype EQ "Transit"> selected</cfif>>Transit</option>
	    <option value="TV" <cfif isDefined("QgettargXXXs") and QgettargXXXs.mediatype EQ "TV"> selected</cfif>>TV</option>
	 	   </select>
		</td><td align="center">  <input type="text" size=40 maxlength=40 name="mediachannel" <cfif isDefined("QgettargXXXs") > value="#QgettargXXXs.mediachannel#"</cfif>>
		</td><td align="center">
<input type="text" size=40 maxlength=40 name="spottitle" <cfif isDefined("QgettargXXXs") > value="#QgettargXXXs.spottitle#"</cfif>>
</td>
<td align="center">
			<input type="text" size=8 maxlength=7 name="number" <cfif isDefined("QgettargXXXs") > value="#QgettargXXXs.number#"</cfif>>
 </td>
<td align="left">
			<input type="text" size=9 maxlength=8 name="cost" <cfif isDefined("QgettargXXXs") > value="#QgettargXXXs.cost#"</cfif>>
</td>
<tr><Td colspan=5>
<cfif isDefined("QgettargXXXs") and isDefined("url.seq")>
<input type="button" value="Check Spelling" onClick="spell('document.wrk.mediachannel.value'),spell('document.wrk.spottitle.value')">
<br><input type="submit" name="addpaidmedia" value="Update" class="AddButton" onClick="return checkDG();">
<cfelse>
<input type="button" value="Check Spelling" onClick="spell('document.wrk.mediachannel.value'),spell('document.wrk.spottitle.value')">
<br><input type="submit" name="addpaidmedia" value="Add" class="AddButton" onClick="return checkDG();">
</cfif>
<cfif Qmediaorg.recordcount GT 0>
		  <tr><td colspan=5><table class="box" border=".1" width=775>
<a name="media2"></a>	  <tr><th>Media type</th><th>Name of media channel(s)</th><th>Title of spot</th><th>Number run/aired/printed</th><th>Cost</th>	<th>Delete</th></tr>
<cfloop query="qmediaorg">
	<tr>	<td bgcolor="##E9FBEC"><a href="javascript: document.wrk.action='month.cfm?#session.urltoken#&target=media&seq=#qmediaorg.monthlymediaid###pm'; document.wrk.submit()">#qmediaorg.mediatype#</a></td><td align="center" bgcolor="##E9FBEC">#qmediaorg.mediachannel#
</td><td align="center" bgcolor="##E9FBEC">#qmediaorg.spottitle#</td>
<td align="center" bgcolor="##E9FBEC">#qmediaorg.number#</td>
<td align="left" bgcolor="##E9FBEC">#qmediaorg.cost#</td>
	<td valign="top" bgcolor="##E9FBEC" align="center"><input type="Checkbox" name="Del_box4" value="#qmediaorg.monthlymediaid#"></td></cfloop>

<tr><Td colspan=5 align="right">			<tr><td colspan=6 align="right"><input type="submit" name="del_targ" value="Delete" onClick="javascript: document.wrk.action='month.cfm?#session.urltoken###pm'; return checkMGG();" class="DelButton">
</td></tr></table>
</td></tr></cfif>
</table></td></tr>
		  		<tr><td height=10></td></tr>
</cfif>
<cfif #session.fy# LTE '2010'>
	  			  <tr><td><table class="boxs" width=775>
				  		<tr><td height=10><br></td></tr>
				  		<tr><td height=10><br></td></tr>
	  <th align="left"><h6>Earned Media<br><br></th>

<tr><td>	  Check all recruitment activities you conducted for this initiative this month:</td></tr>
	  <tr><td><table class="boxy" border=".1" width=805>
<a name="targ"></a>	  <tr><th align="center">Sent letters to the editor</td><th align="center">Sent press releases</td><th align="center">Made calls to the media</td><th align="center">Delivered press packets</td></tr>
	  <tr>	<td align="center">
			<input type="checkbox" name="editor" value=1 <cfif #mon.editor# is 1>checked</cfif>>
		</td><td align="center">

	   <input type="checkbox" name="prssrlse" value=1 <cfif #mon.prssrlse# is 1>checked</cfif>></td>
<td align="center"><input type="checkbox" name="calls" value=1 <cfif #mon.calls# is 1>checked</cfif>>	    </td>
<td align="center"><input type="checkbox" name="prsspk" value=1 <cfif #mon.prsspk# is 1>checked</cfif>>	    </td></tr>

</table></td></tr>
		  		<tr><td height=10></td></tr>

<tr><td>	 Number of instances of earned media achieved for this initiative this month:</td></tr>
	  <tr><td><table class="boxy" border=".1" width=805>
<a name="targ"></a>	  <tr><th align="center">Letters to the editor</td><th align="center">News stories</td><th align="center">Newsletter stories</td><th align="center">Editorials</td><th align="center">Other</td></tr>
	  <tr>	<td align="center">
			<input name="ltred" type="text" size=4 maxlength=4 <cfif #mon.ltred# is not ''>value="#mon.ltred#"<cfelse>value=0</cfif>>
		</td><td align="center">

			<input type="text" name="nwsstry" size=4 maxlength=4 <cfif #mon.nwsstry# is not ''>value="#mon.nwsstry#"<cfelse>value=0</cfif>>
</td>
<td align="center">			<input type="text" name="nwsltr" size=4 maxlength=4 <cfif #mon.nwsltr# is not ''>value="#mon.nwsltr#"<cfelse>value=0</cfif>>
    </td>
<td align="center">			<input type="text" name="editorial" size=4 maxlength=4 <cfif #mon.editorial# is not ''>value="#mon.editorial#"<cfelse>value=0</cfif>>
    </td>
	<td align="center">			<input type="text" name="other" size=4 maxlength=4 <cfif #mon.other# is not ''>value="#mon.other#"<cfelse>value=0</cfif>>
    </td></tr>
</table></td></tr>
		  		<tr><td height=10></td></tr>
		  		<tr><td height=10></td></tr>
</cfif>
<cfif session.fy GT 2014 and (session.objval EQ "2D" or session.objval EQ "2E" or session.objval EQ "4F" or session.objval EQ "3M")>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QInsMob">
select isNull(dispar,0) as dispar from wrkplan
where userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
and year2= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
and initnum = <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
</cfquery>
<cfif QInsMob.dispar EQ 1>
<tr><td height=20></td></tr>
<tr><td colspan=4>
<table class="boxy">
<tr>
		<th align="left" height=30 valign="bottom"><h6>Disparities Project</th>
	  </tr>
	  <tr>
		<td>Please select which strategies were used for your <cfif session.objval EQ "2D">POS<cfelseif session.objval EQ "2E">Tobacco-free Outdoors<cfelseif session.objval EQ "3M">Smoke-free Media<cfelseif session.objval EQ "4F">Smoke-free Multi-unit Housing Disparities</cfif> Disparities Project this month [Select all that apply]<br>
<cfif session.objval NEQ "2D">
<cfif #wrk.advoc# is 1><input type = "checkbox" name="dispstrat1" value="1" <cfif isDefined("mon.dispstrat1") and #mon.dispstrat1# is 1> checked</cfif>>Advocating with Organizational Decision Makers<br></cfif></cfif>
<cfif #wrk.commmob# is 1><input type = "checkbox" name="dispstrat2" value="1" <cfif isDefined("mon.dispstrat2") and #mon.dispstrat2# is 1> checked</cfif>>Community Mobilization<br></cfif>
<cfif #wrk.govt# is 1><input type = "checkbox" name="dispstrat3" value="1" <cfif isDefined("mon.dispstrat3") and #mon.dispstrat3# is 1> checked</cfif>>Government Policy-maker Education<br></cfif>
<cfif #wrk.comm# is 1><input type = "checkbox" name="dispstrat4" value="1" <cfif isDefined("mon.dispstrat4") and #mon.dispstrat4# is 1> checked</cfif>>Community Education<br></cfif>
<cfif #wrk.media# is 1><input type = "checkbox" name="dispstrat5" value="1" <cfif isDefined("mon.dispstrat5") and #mon.dispstrat5# is 1> checked</cfif>>Paid Media<br></cfif>
		</td>
</tr>
		<tr>
<td colspan="4">
<table border=".1" id="dispartxt"class="boxy" width="80%" <!--- <cfif isDefined("wrk.dispar") and #wrk.dispar# is 1> style='display:block;' <cfelse> style='display:none;'</cfif> --->>
<tr><td>Description of <cfif session.objnum is '2d'>POS<cfelseif session.objnum is '2e'>Tobacco-free Outdoors<cfelseif session.objnum is '4f'>Smoke-free Multi-unit Housing<cfelseif session.objnum is '3m'>Smoke-free Media</cfif> Disparities Project activities for this month:</td></tr>
<tr>
    <td width=750><div align="left" valign="bottom">
		<cfoutput><textarea name="dispstrattxt" cols=135 rows=6 ><cfif isDefined("mon.dispstrattxt")>#mon.dispstrattxt#</cfif></textarea>
		</cfoutput>
	</td>
</tr>
  <tr><td><input type="button" value="Check Spelling" onClick="spell('document.mon.dispstrattxt.value', 'document.mon.dispstrattxt.value')">
</table>
</td></tr>	</table></td></tr>
</cfif>

</cfif>








		  		<tr><td height=10></td></tr>
<tr><td colspan=4>
<table class="boxy">
		<th align="left" height=30 valign="bottom"><h6>Summary of activities this month:</th>
	  </tr>

	  <tr>
	  	<td width=805><textarea name="summary" cols=145 rows=14 maxlength="2000" onkeyup="countit(this)"><cfif isDefined("form.summary") and form.summary NEQ "">#form.summary#<cfelse>#mon.summary#</cfif></textarea>
</td></tr>
	  <tr><td height=30><input type="button" value="Check Spelling" onClick="spell('document.wrk.summary.value', 'document.wrk.summary.value')"></td></tr>
	      <tr>
      <td width="100%" valign="bottom"><div align="right" valign="bottom">This text field has a max of 2000 characters. Characters entered: <cfoutput><input type="text" value="#len(mon.summary)#" name="summdisplaycount" size="4" style="border:0;" disabled></cfoutput></td>
    </tr>

		<th align="left" height=30 valign="bottom"><h6>Barriers encountered this month:</th>

	  <tr>
	  	<td width=700><textarea name="barriers" cols=145 rows=14 maxlength="2000" onkeyup="countit2(this)"><cfif isDefined("form.barriers") and form.barriers NEQ "">#form.barriers#<cfelse>#mon.barriers#</cfif></textarea>
</td></tr>
	  <tr><td height=30><input type="button" value="Check Spelling" onClick="spell('document.wrk.barriers.value', 'document.wrk.barriers.value')"></td></tr>
	      <tr>
      <td width="100%" valign="bottom"><div align="right" valign="bottom">This text field has a max of 2000 characters. Characters entered: <cfoutput><input type="text" value="#len(mon.barriers)#" name="barrdisplaycount" size="4" style="border:0;" disabled></cfoutput></td>
    </tr>
		<th align="left" height=30 valign="bottom"><h6>Next steps:</th>
			  <tr>
	  	<td width=700><textarea name="steps" cols=145 rows=14 maxlength="2000" onkeyup="countit3(this)"><cfif isDefined("form.steps") and form.steps NEQ "">#form.steps#<cfelse>#mon.steps#</cfif></textarea>
</td></tr>
	  <tr><td><input type="button" value="Check Spelling" onClick="spell('document.wrk.steps.value', 'document.wrk.steps.value')">

	      <tr>
      <td width="100%" valign="bottom"><div align="right" valign="bottom">This text field has a max of 2000 characters. Characters entered: <cfoutput><input type="text" value="#len(mon.steps)#" name="stepdisplaycount" size="4" style="border:0;" disabled></cfoutput></td>
    </tr>
			<tr><td align="center" height=20><p><input type="submit" name="return" value="Save" <cfif #session.objval# is '6B'>onClick="checkLG();"<cfelseif #session.objval# is '1E'>onClick="return checkAAG();"<cfelse>onClick="return checkSG();"</cfif>></td></tr>
			<tr><td>&nbsp;</td></tr>
			<tr><td align="center" height=20><p><input type="submit" name="return" value="Save and return to Monthly Reporting" <cfif #session.objval# is '6B'>onClick="checkLG();"<cfelseif #session.objval# is '1E'>onClick="return checkAAG();"<cfelse>onClick="return checkSG();"</cfif>></td></tr>
</td></tr>
</cfif>
</cfoutput>
 <cfif #session.modality# is not 1 and #session.objval# is '6B'>
		  <cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="geteval">
SELECT     ws.wrkselfid, ws.userid, ws.initnum, ws.year2, ws.selfevalid, s.selfevaltxt, ws.evalproj, sm.summary, sm.barriers, sm.steps
FROM         wrkplan_selfeval AS ws INNER JOIN
                      SelfEval AS s ON ws.selfevalid = s.selfevalid and (ws.year2=isNull(s.year2, 1904) or (ws.year2 <2012 and s.year2 is null)) and s.modality =#session.modality#
	LEFT OUTER JOIN
                      selfeval_mon AS sm ON ws.wrkselfid = sm.wrkselfid  and mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
WHERE     (ws.userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">) AND (ws.year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">) AND (ws.initnum = <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">)
</cfquery>
	</td></tr>
 <cfoutput query="geteval">
<input type="hidden" name="selfevalid" value="#selfevalid#">
<input type="hidden" name="wrkselfid" value="#wrkselfid#">
		  		<tr><td height=10></td></tr>
		<th align="left"><h6>Evaluation project: #selfevaltxt#</h6></th>
		  		<tr><td>#evalproj#</td></tr>
		<tr><td colspan=5><table class="boxy">
		<th align="left">Summary of activities this month:</th>
	  </tr>
	  <tr>
	  	<td width=700><textarea maxlength="2000" <cfif #session.modality# is not 1 and #session.objval# is '6B'>onkeyup="countit10('#wrkselfid#');" name="summary#wrkselfid#" id="summary#wrkselfid#"<cfelse>onkeyup="countit(this);" name="summary" id="summary"</cfif> rows=14 cols=145><cfif #session.modality# is not 1 and #session.objval# is '6B'>#geteval.summary#<cfelse>#mon.summary#</cfif></textarea>
<br><input type="button" value="Check Spelling" onClick="spell('document.wrk.summary#wrkselfid#.value')">
</td></tr>
	      <tr>
      <td width="100%" valign="bottom"><div align="right" valign="bottom">This text field has a max of 2000 characters. Characters entered:
	<!--- <cfoutput> --->
		<input type="text" <cfif #session.modality# is not 1 and #session.objval# is '6B'>value="#len(geteval.summary)#" <cfelse>value="#len(mon.summary)#" </cfif>
				<cfif #session.modality# is not 1 and #session.objval# is '6B'>name="evalsummdisplaycount#wrkselfid#" id="evalsummdisplaycount#wrkselfid#"
				<cfelse>name="evalsummdisplaycount" id="evalsummdisplaycount"</cfif>
				 size="4" style="border:0;" disabled>
	<!--- </cfoutput> --->
		</td>
    </tr>
		<th align="left">Barriers encountered this month:</th>
	  <tr>
	  	<td width=700><textarea maxlength="2000" <cfif #session.modality# is not 1 and #session.objval# is '6B'>onkeyup="countit20('#wrkselfid#');" name="barriers#wrkselfid#"<cfelse>onkeyup="countit2(this);" name="barriers"</cfif> rows=14 cols=145><cfif #session.modality# is not 1 and #session.objval# is '6B'>#geteval.barriers#<cfelse>#mon.barriers#</cfif></textarea>
<br><input type="button" value="Check Spelling" onClick="spell('document.wrk.barriers#wrkselfid#.value')">
</td></tr>
 <tr>
      <td width="100%" valign="bottom"><div align="right" valign="bottom">This text field has a max of 2000 characters. Characters entered:
	<!--- <cfoutput> --->
		<input type="text" <cfif #session.modality# is not 1 and #session.objval# is '6B'>value="#len(geteval.barriers)#" <cfelse>value="#len(mon.barriers)#" </cfif>
				<cfif #session.modality# is not 1 and #session.objval# is '6B'>name="evalbarrdisplaycount#wrkselfid#" id="evalbarrdisplaycount#wrkselfid#"
				<cfelse>name="evalbarrdisplaycount" id="evalbarrdisplaycount"</cfif>
				 size="4" style="border:0;" disabled>
	<!--- </cfoutput> --->
		</td>
    </tr>
		<th align="left">Next steps:</th>
			  <tr>
	  	<td width=700><textarea maxlength="2000" <cfif #session.modality# is not 1 and #session.objval# is '6B'>onkeyup="countit30('#wrkselfid#');" name="steps#wrkselfid#"<cfelse>onkeyup="countit3(this);" name="steps#wrkselfid#"</cfif> rows=14 cols=145><cfif #session.modality# is not 1 and #session.objval# is '6B'>#geteval.steps#<cfelse>#mon.steps#</cfif></textarea>
<br><input type="button" value="Check Spelling" onClick="spell('document.wrk.steps#wrkselfid#.value')">
</td></tr>
		 <tr>
      <td width="100%" valign="bottom"><div align="right" valign="bottom">This text field has a max of 2000 characters. Characters entered:
	<!--- <cfoutput> --->
		<input type="text" <cfif #session.modality# is not 1 and #session.objval# is '6B'>value="#len(geteval.steps)#" <cfelse>value="#len(mon.steps)#" </cfif>
				<cfif #session.modality# is not 1 and #session.objval# is '6B'>name="evalstepdisplaycount#wrkselfid#" id="evalstepdisplaycount#wrkselfid#"
				<cfelse>name="evalstepdisplaycount" id="evalstepdisplaycount"</cfif>
				 size="4" style="border:0;" disabled>
	<!--- </cfoutput> --->
		</td>
    </tr>
		</table></td></tr></cfoutput>
</cfif>
<cfif #session.objval# is '6B'>
	  		<tr><td height=10></td></tr>
		  		<tr><td height=10></td></tr>
	<tr><td align="center" width=700><input type="submit" name="return" value="Save" onClick="checkLG();"></td></tr>
	<tr><td>&nbsp;</td></tr>
	<tr><td align="center" width=700><input type="submit" name="return" value="Save and return to Monthly Reporting" onClick="checkLG();"></td></tr>
<cfelseif session.modality eq 6 and (session.objval is '1A' or session.objval is '2A')>
<cfquery datasource="#application.DataSource#"	password="#application.db_password#"username="#application.db_username#" name="QgetHSC">
select descr
from HSC_Monthly
where
userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
and year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
and mon = <cfqueryparam value="#session.mon#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
and obj=<cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="5">
</cfquery>
<tr>
		<th align="left">
<cfif session.objval EQ "1A">
Please describe this month's activities related to providing regional support of health systems change.
<cfelseif session.objval EQ "2A">
Please describe this month's activities related to providing statewide support of health systems change.
</cfif>
		</th>
</tr>
 <tr>
	  <cfoutput>	<td width=700><textarea maxlength="4000" onkeyup="countit85(this);" name="HSC_DESC" id= "HSC_DESC"
rows=14 cols=145>#QgetHSC.descr#</textarea>
<br><input type="button" value="Check Spelling" onClick="spell('document.wrk.HSC_DESC.value')">
</td></cfoutput></tr>
 <tr>
      <td width="100%" valign="bottom"><div align="right" valign="bottom">This text field has a max of 4000 characters. Characters entered:
		<cfoutput><input type="text" value="#len(QgetHSC.descr)#" </cfoutput>
				name="HSC_DESCdisplaycount" id="HSC_DESCdisplaycount"

				 size="4" style="border:0;" disabled>
		</td>
    </tr>
	  		<tr><td height=10></td></tr>
		  		<tr><td height=10></td></tr>
	<tr><td align="center" width=700><input type="submit" name="return" value="Save"></td></tr>
	<tr><td>&nbsp;</td></tr>
	<tr><td align="center" width=700><input type="submit" name="return" value="Save and return to Monthly Reporting" ></td></tr>
</cfif>
</table></td></tr></table>
</cfform>
</table>
</td>
</tr>
<script language="JavaScript">
<cfif session.fy GT 2010 and isdefined("session.objval") and #session.objval# EQ '2d' and (session.modality EQ 2 or session.modality EQ 3)>
presetPos();
<cfelseif session.fy GT 2010 and isdefined("session.objval") and #session.objval# EQ '2e' and session.modality NEQ 5>
presetSFO();
</cfif>
<cfif session.fy GT 2010 and isdefined("attributes.obj2") and attributes.obj2 EQ '2e' and session.modality EQ 5>
presetSFO();
</cfif>
<cfif session.fy GTE 2011 and isdefined("attributes.obj2") and attributes.obj2 EQ '3m' and session.modality EQ 3>
presetSFM();
</cfif>
</script>
<cfif session.fy LT session.def_fy AND session.prevyr NEQ 1 AND session.userid is 'test_yp' and NOT (SESSION.areamanage EQ "1" OR SESSION.admin EQ "1" OR SESSION.TCP EQ "1")>
<script language="JavaScript">
	disableme();
</script>
</cfif>
<!--- <cfif session.userid is not 'test_cp' and session.userid is not 'test_yp' and session.userid is not 'dplotner' and session.userid is not 'nsarris'>
<script language="JavaScript">
	disableme();
</script>
</cfif> --->
<cfif session.readOnly EQ 1>
<script language="JavaScript">
	disableme();
</script>
</cfif>
<cfif mon.sfm is 1 or (isDefined("form.sfm") and form.sfm EQ 1) or (isDefined("url.sfm") and url.sfm EQ 1)>
<script language="JavaScript">
show_other('sfm1', 'hide');show_other('sfm2', 'show');
</script>
<cfelseif mon.sfm is 0 or (isDefined("form.sfm") and form.sfm EQ 0) or (isDefined("url.sfm") and url.sfm EQ 0)>
<script language="JavaScript">
show_other('sfm1', 'show');show_other('sfm2', 'hide');
</script>
</cfif>
<cfset session.targ2 = "">
</body>
</html>
</cfif>