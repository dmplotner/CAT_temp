<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<SCRIPT LANGUAGE="JavaScript" SRC="RegExpValidate.js"></SCRIPT>
<script language="JavaScript" src="../spellchecker/spell.js"></script>
<html>
<head>
<!--- <cfdump var="#form#">  --->
<title>CAT</title>

<cfinclude template="catstruct.cfm">
<table class="box" width="100%"><tr><td>
<br><br><br>
<script language="JavaScript">
function add(actvalue){
document.cess.dofunction.value=actvalue;
return true;
}

function toggle(){

document.cess.org_id_show.value="1";
document.cess.submit();
}

function addTRAIN(identifier){
if(eval("document.cess.TRCollabName_" + identifier + ".selectedIndex")==0){
	alert("Please select a target HCPO");
	return false;
	}
	
if (!validateInteger(eval("document.cess.TRCollabAttend_" + identifier + ".value") )) {
    alert("Please enter an integer for number attended");
	return false;
	}

document.cess.dofunction.value="addTrainCollab";
document.cess.prcSeq.value=identifier;
return true;
}

function delTRAIN2(identifier){
document.cess.dofunction.value="delTrainCollab";
document.cess.prcSeq.value=identifier;
return true;
}

function return_home(){
<cfif isDefined("form.handler") and form.handler EQ "six">
if (document.cess.BLcollabs.selectedIndex != 0){
if(validateMe()){
document.cess.action="monthlyActive_cess_test.cfm<cfoutput>?#session.urltoken#&mon=#form.month#&year=#session.fy#&activ=#form.activity2#</cfoutput>";
document.cess.submit();	}
}
else {
document.cess.action="monthlyActive_cess_test.cfm<cfoutput>?#session.urltoken#</cfoutput>";
document.cess.submit();
}	
<cfelseif isDefined("form.handler") and form.handler EQ "seven">
if(validateMe()){
document.cess.action="monthlyActive_cess_test.cfm?<cfoutput>#session.urltoken#&mon=#form.month#&year=#session.fy#&activ=#form.activity2#</cfoutput>";
document.cess.submit()}
<cfelse>
document.cess.action="monthlyActive_cess_test.cfm<cfoutput>?#session.urltoken#</cfoutput>";
document.cess.submit();
</cfif>
}

function disableme(){
for(var intloop=0; intloop <document.cess.length; intloop++){
document.cess[intloop].disabled=true;
}
}

function checkMG(){
<cfif session.fy LT 2006>
if (ValidateDate(document.cess.MGdate.value)==false){
return false;
}
</cfif>
document.cess.MGamount.value=removeCommas(removeCurrency(document.cess.MGamount.value));
if (!validateNumeric(document.cess.MGamount.value)){
alert("Please enter a numeric value for dollar amount of award.");
return false;
}
add('addMG');

}


function checkAC(){
if (ValidateDate(document.cess.ACdate.value)==false){
return false;
}
<cfif session.fy LT 2007>
// initialize the counter
   var Counter = 0;
   // Loop through the select box to see how many are selected;
   for (i=0; i<document.cess.ACMaterial.length; i++){
      // If an element is selected, increment the counter
      if (document.cess.ACMaterial[i].selected == true){
         Counter++;
      }
   }
   // If the counter is greater than 3, display an alert message.
   if (Counter==0){
      alert("You must select at least one material provided.");
      return false;
   } 
</cfif>
add('addAC');

}

function checkTrain(){
if (ValidateDate(document.cess.TRDate.value)==false){
return false;
}
document.cess.TRNum.value=removeCommas(document.cess.TRNum.value);
if (validateInteger(document.cess.TRNum.value)==false){
alert("Please enter an integer value for number of attendees.");
return false;
}
<cfif session.fy LT 2007>

// initialize the counter
   var Counter = 0;
   // Loop through the select box to see how many are selected;
   for (i=0; i<document.cess.TRMaterial.length; i++){
      // If an element is selected, increment the counter
      if (document.cess.TRMaterial[i].selected == true){
         Counter++;
      }
   }
   // If the counter is greater than 3, display an alert message.
   if (Counter==0){
      alert("You must select at least one material provided.");
      return false;
   } 
 </cfif>
add('addTRAIN');
}

function checkTA(){
if (ValidateDate(document.cess.TAdate.value)==false){
return false;
}
document.cess.TANum.value=removeCommas(document.cess.TANum.value);
if (validateInteger(document.cess.TANum.value)==false){
alert("Please enter an integer value for number of attendees.");
return false;
}
 var Counter2 = 0;
    // Loop through the select box to see how many are selected;
   for (i=0; i<document.cess.TAMethod.length; i++){
       // If an element is selected, increment the counter
      if (document.cess.TAMethod[i].checked == true){
	  	  Counter2++;
      }
   }
   // If the counter is greater than 3, display an alert message.
   if (Counter2==0){
      alert("You must select a method used.");
      return false;
   } 

<cfif session.fy LT 2007>

// initialize the counter
   var Counter = 0;
   // Loop through the select box to see how many are selected;
   for (i=0; i<document.cess.TAMaterial.length; i++){
      // If an element is selected, increment the counter
      if (document.cess.TAMaterial[i].selected == true){
         Counter++;
      }
   }
   // If the counter is greater than 3, display an alert message.
   if (Counter==0){
      alert("You must select at least one material provided.");
      return false;
   } 
 <cfelse>
 var Counter = 0;
   // Loop through the select box to see how many are selected;
   for (i=0; i<document.cess.TAMaterial.length; i++){
      // If an element is selected, increment the counter
      if (document.cess.TAMaterial[i].checked == true){
         Counter++;
      }
   }
   // If the counter is greater than 3, display an alert message.
   if (Counter==0){
      alert("You must select at least one material provided.");
      return false;
   } 
  </cfif>
add('addTA')

}



</script>

<cfif isDefined("url.id2")>
<cfquery datasource="#application.DataSource#"  		 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QpullMe">
	
select a.seq, c.seq,
case 
	 when unit IS NULL then NAME
	 else unit + ' ' + NAME
	end as unitname ,
s.strategy, u.activity, a.month2
from advocCC_pp a, collaborators c, useractivities as u, strategy s
where a.userid=c.userid
and c.seq=a.thcpo
and u.year2=a.year2
and u.userid=a.userid
and u.activity=a.strategy
and u.del is null
and s.year2=u.year2
and s.strategy_num=u.strategy
and a.seq=<cfqueryparam cfsqltype="cf_sql_integer" value="#url.id2#">
</cfquery>

<cfset form.month=QpullMe.month2>
<cfset form.activity2=QpullMe.activity>
<cfset form.myFA=QpullMe.strategy>

<cfset form.actStatus="">
<cfset form.addActiveMotivation="">
<cfset form.addActiveTarget="">
<cfset form.handler=url.handler>
<cfset form.oldRpt="">
<cfset form.reportMonth="">
<cfset form.reportYear=session.fy>
<cfset form.rpt="">
<cfset form.rptuserid=session.userid>
<cfset form.statewide="">
<cfset form.year=session.fy>


</cfif>



<cfif isDefined("url.id3")>
<cfquery datasource="#application.DataSource#"  		 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QpullMe2">
	
select a.seq, c.seq,
case 
	 when unit IS NULL then NAME
	 else unit + ' ' + NAME
	end as unitname ,
s.strategy, u.activity, a.month2
from advocCC_baselines a, collaborators c, useractivities as u, strategy s
where a.userid=c.userid
and c.seq=a.thcpo
and u.year2=a.year2
and u.userid=a.userid
and u.activity=a.strategy
and u.del is null
and s.year2=u.year2
and s.strategy_num=u.strategy
and a.seq=<cfqueryparam cfsqltype="cf_sql_integer" value="#url.id3#">
</cfquery>

<cfset form.month=QpullMe2.month2>
<cfset form.activity2=QpullMe2.activity>
<cfset form.myFA=QpullMe2.strategy>

<cfset form.actStatus="">
<cfset form.addActiveMotivation="">
<cfset form.addActiveTarget="">
<cfset form.handler=url.handler>
<cfset form.oldRpt="">
<cfset form.reportMonth="">
<cfset form.reportYear=session.fy>
<cfset form.rpt="">
<cfset form.rptuserid=session.userid>
<cfset form.statewide="">
<cfset form.year=session.fy>


</cfif>




<cfif isDefined("url.mon")>
	<cfset form.year = url.year>
	<cfset form.month2 = url.mon>
</cfif>
<cfif isDefined("url.month2")>	
	<cfset form.month = url.month2>
</cfif>
<cfif isDefined("url.activity2")>
	<cfset form.activity2 = url.activity2>
</cfif>
<cfif isDefined("form.month")>
	<cfset form.month2=form.month>
</cfif>

<cfif (isDefined("form.monthdisplay") AND form.monthdisplay NEQ "") and NOT isDefined("form.month2")>
	<cfset form.month2=form.monthdisplay>
</cfif>
<cfparam name="form.month2" default=form.month>

<cfif isDefined("form.dofunction")>
<!--- <cfif form.dofunction EQ "addPractice">
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QInsPP">
insert into chcopp
(userid, month2, year2, strategy, collab_id, rb1, rb2, rb3, rb4, rb5, rb6, rb7, rb8, rb9, rb10, rb11, <cfif isDefined("form.org_id")>org_id,</cfif> <cfif isDefined("form.compliance")>compliance,</cfif> org_id_a, compliance_a)
values
('#session.userid#', '#form.month2#', #session.fy#, #form.rpt#,
#form.collabs#, #form.rb1#,#form.rb2#,#form.rb3#,#form.rb4#,#form.rb5#,#form.rb6#,#form.rb7#,#form.rb8#,#form.rb9#,#form.rb10#,#form.rb11#, 
<cfif isDefined("form.org_id")>'#form.org_id#',</cfif><cfif isDefined("form.compliance")>'#form.compliance#',</cfif> '#form.org_id_a#', '#form.compliance_a#'
)
</cfquery>

<cfelseif form.dofunction EQ "delPractice">
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QDelPP">
delete from chcopp
where seq in (#form.delPP#)
</cfquery> --->

<cfif form.dofunction EQ "addMG">

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QInsMG">
insert into CHCO_MGF
(userid, month2, year2,  strategy, collab_id, <cfif isDefined("form.mgservice")>funded_service,</cfif> <cfif isDefined("form.other_funded_service")>other_funded_service,</cfif> amount<cfif isDefined("form.mgdate")>, award_date</cfif>)
values
('#session.userid#', '#form.month2#', #session.fy#, '#form.activity2#', '#form.mgcollabs#', 
<cfif isDefined("form.mgservice")>'#htmleditformat(form.mgservice)#',</cfif><cfif isDefined("form.other_funded_service")>'#form.other_funded_service#',</cfif> '#form.mgamount#'<cfif isDefined("form.mgdate")>,'#form.mgdate#'</cfif>)

</cfquery>

<cfquery datasource="#application.DataSource#"  		 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QUpd1">
update advoc
set status='On-going'
where 
userid='#session.userid#'
and month2='#form.month2#'
and year2=#session.fy#
and activity='#form.activity2#'
</cfquery>

<cfelseif form.dofunction EQ "delMG" and isDefined("form.delMG")>
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QDelMG">
delete from CHCO_MGF
where seq in (#form.delMG#)
</cfquery>



<cfelseif form.dofunction EQ "addAC">
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QInsMG">
insert into CCHCO_AC
(userid, month2, year2,  strategy, collab_id, method, contact_date<cfif isDefined("form.acmaterial")>, material</CFIF> <cfif isDefined("form.other_acmaterial")>, other_acmaterial</cfif><cfif isDefined("form.aco")>, aco</cfif>)
values
('#session.userid#', '#form.month2#', #session.fy#,  '#form.activity2#', '#form.accollabs#','#form.acmethod#', '#form.acdate#'<cfif isDefined("form.acmaterial")>, '#form.acmaterial#'</CFIF> <cfif isDefined("form.other_acmaterial")>, '#other_acmaterial#'</cfif><cfif isDefined("form.aco")>, #form.aco#</cfif>)


</cfquery>
<cfquery datasource="#application.DataSource#"  		 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QUpd2">
update advoc
set status='On-going'
where 
userid='#session.userid#'
and month2='#form.month2#'
and year2=#session.fy#
and activity='#form.activity2#'
</cfquery>
<cfelseif form.dofunction EQ "delAC" and isDefined("form.delAC")>
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QDelMG">
delete from CCHCO_AC
where seq in (#form.delAC#)
</cfquery>


<cfelseif form.dofunction EQ "addTrain">
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QInsMG">
insert into CCHCO_TRAIN
(userid, month2, year2,  strategy, training, train_date, method, credit, <cfif isDefined("form.TRTypeCredit")>type_credit,</cfif> num_attendees, material <cfif isDefined("form.other_TRmaterial")>, other_TRmaterial</cfif>)
values
('#session.userid#', '#form.month2#', #session.fy#,  '#form.activity2#', '#form.TRtrain#','#form.TRdate#', '#form.TRmethod#', '#form.TRCredit#', <cfif isDefined("form.TRTypeCredit")>'#form.TRTypeCredit#', </cfif>'#form.TRNum#', '#form.TRMaterial#' <cfif isDefined("form.other_TRmaterial")>, '#form.other_TRmaterial#'</cfif>)

</cfquery>

<cfquery datasource="#application.DataSource#"  		 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QUpd3">
update advoc
set status='On-going'
where 
userid='#session.userid#'
and month2='#form.month2#'
and year2=#session.fy#
and activity='#form.activity2#'
</cfquery>
<cfelseif form.dofunction EQ "delTrain" and isDefined("form.delTRAIN")>
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QDelMG">
delete from CCHCO_TRAIN
where seq in (#form.delTRAIN#)
</cfquery>








<cfelseif form.dofunction EQ "addTA">
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QInsMG">
insert into CCHCO_TA
(userid, month2, year2,  strategy, collab_id, ta_date, method, num_ta, material <cfif isDefined("form.other_TAmaterial")>, other_TAmaterial</cfif><cfif isDefined("form.other_TAmethod")>, other_TAmethod</cfif>)
values
('#session.userid#', '#form.month2#', #session.fy#,  '#form.activity2#', #form.TAcollabs#,'#form.tadate#', '#form.tamethod#', '#form.tanum#', '#form.tamaterial#' <cfif isDefined("form.other_TAmaterial")>, '#other_TAmaterial#'</cfif><cfif isDefined("form.other_TAmethod")>, '#form.other_TAmethod#'</cfif>)

</cfquery>

<cfquery datasource="#application.DataSource#"  		 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QUpd4">
update advoc
set status='On-going'
where 
userid='#session.userid#'
and month2='#form.month2#'
and year2=#session.fy#
and activity='#form.activity2#'
</cfquery>

<cfelseif form.dofunction EQ "delTA" and isDefined("form.delTA")>
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QDelMG">
delete from CCHCO_TA
where seq in (#form.delTA#)
</cfquery>


<cfelseif form.dofunction EQ "addTrainCollab" and isDefined("form.prcSeq")>
<cfset cname="form.TRCollabName_"&form.prcSeq>
<cfset cnum="form.TRCollabAttend_"&form.prcSeq>
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QinsTrainColl">
insert into CCHCO_TRAIN_DET
(train_seq, collab_id, attend)
values
(#form.prcSeq#, #evaluate(cname)#, #evaluate(cnum)#)
</cfquery>

<cfelseif form.dofunction EQ "delTrainCollab" and isDefined("form.delTrainCollabDet")>
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QdelTrainColl">
Delete from CCHCO_TRAIN_DET
where
seq in (#form.delTrainCollabDet#)

</cfquery>

<!--- Processing before return --->
<cfelse>

<cfif isDefined("form.barriers") and isDefined("form.userid") and isDefined("form.dofunction") and form.dofunction contains "_">
<cfset prog_num = 'progress'&form.dofunction>
<cfset suc_num = 'success'&form.dofunction>
<cfset bar_num = 'barriers'&form.dofunction>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="CheckProg">
	select userid
	from advoc
	where userid = '#form.userid#'
			and activity = '#form.activity2#'
			and month2='#form.month#'
			and year2=#form.year#
			<!--- and strategy = '#form.rpt#' --->
</cfquery>

<cfif CheckProg.recordcount LT 1>
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="InsNewProg">
	Insert into advoc
	(userid, activity, month2, year2, strategy)
	values
	('#form.userid#','#form.activity2#','#form.month#',#form.year#, '#form.rpt#')
</cfquery>
</cfif>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="UpdProg">
	Update advoc
	set #prog_num# = '#form.Activityprogress#', 
	#suc_num#='#successes#', 
	#bar_num#='#barriers#',
	status='On-going'
			where userid = '#form.userid#'
			and activity = '#form.activity2#'
			and month2='#form.month#'
			and year2=#form.year#

</cfquery>
			
			
</cfif>


</cfif>


</cfif>

<!--- <cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QSelPP">
	select  
	collab_id, rb1, rb2, rb3, rb4, rb5, rb6, rb7, rb8, rb9, rb10, rb11, org_id, compliance, org_id_a, compliance_a, a.seq, name
	from chcopp as a, collaborators as b
	where 
	a.userid='#session.userid#'
	and a.year2=#session.fy#
	and a.month2='#form.month#'
	and a.collab_id=b.seq
	and a.strategy = #form.rpt#
	
</cfquery> --->

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QSelMG">
	select  
	collab_id, isNull(funded_service,'0') as funded_service, other_funded_service, amount, award_date, a.seq, name,
	case 
	 when b.unit IS NULL then b.NAME
	 else b.unit + ' ' + b.NAME
	end as unitname
	from chco_mgf as a, collaborators as b	
	where 
	a.userid='#session.userid#'
	and a.year2=#session.fy#
	and a.month2='#form.month2#'	
	and a.collab_id=b.seq
	and a.strategy = '#form.activity2#'
	order by 6
</cfquery>

<!--- <cfoutput>
select  
	collab_id, rb1, rb2, rb3, rb4, rb5, rb6, rb7, rb8, rb9, rb10, rb11, org_id, compliance, org_id_a, compliance_a, a.seq, name
	from chcopp as a, collaborators as b
	where 
	a.userid='#session.userid#'
	and a.year2=#session.fy#
	and a.month2='#form.month2#'
	and a.collab_id=b.seq
	and a.strategy = #form.rpt#
</cfoutput> --->

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QSelAC">
	select  
	collab_id, 
	case isNull(method, '0') when '' then '0' else isNull(method, '0') end as method2, 
	contact_date, isNull(material,0) as material, a.seq, name,other_acmaterial,
	case 
	 when b.unit IS NULL then b.NAME
	 else b.unit + ' ' + b.NAME
	end as unitname, aco
	from cchco_ac as a, collaborators as b
	
	where 
	a.userid='#session.userid#'
	and a.year2=#session.fy#
	and a.month2='#form.month2#'	
	and a.collab_id=b.seq
	and a.strategy = '#form.activity2#'
	order by 6
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QSelTRAIN">
	select  
	training, train_date, isNull(method, 0) as method2, credit, type_credit, num_attendees, material,seq, other_trmaterial
	from cchco_train
	where 
	userid='#session.userid#'
	and year2=#session.fy#
	and month2='#form.month2#'	
	and strategy = '#form.activity2#'
	
</cfquery>



<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QSelTA">
	select  
	collab_id, ta_date, method as method2, num_ta, material, a.seq, name, other_tamaterial,other_tamethod,
	case 
	 when unit IS NULL then NAME
	 else unit + ' ' + NAME
	end as unitname 
	from cchco_ta as a, collaborators as b
	where 
	a.userid='#session.userid#'
	and a.year2=#session.fy#
	and a.month2='#form.month2#'	
	and a.collab_id=b.seq
	and a.strategy = '#form.activity2#'
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qcollaborators">
	select name, type, county, seq,
	case 
	 when unit IS NULL then NAME
	 else unit + ' ' + NAME
	end as unitname 
	  from collaborators 
	where  userid = '#session.userid#'
	and (del is null or del != 1)
	and name is not null
	order by 5
	
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qcollaborators">
	select name, type, county, seq,
	case 
	 when unit IS NULL then NAME
	 else unit + ' ' + NAME
	end as unitname 
	  from collaborators 
	where  userid = '#session.userid#'
	and (del is null or del != 1)
	and name is not null
	order by 5
	
</cfquery>
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qident">
	select id, descr
	from lu_chcopp_id
	where year2=#session.fy#
	order by rank
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qfeedback">
	select id, descr
	from lu_chcopp_feedback 
	where year2=#session.fy#
	order by rank
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QACMethods">
	select id, descr
	from lu_cchco_commit_method 
	where year2=#session.fy#
	order by rank
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QACMaterials">
	select id, descr
	from lu_cchco_materials
	where year2=#session.fy#
	and flag is null
	order by rank
</cfquery>
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QACMaterialsA">
	select id, descr
	from lu_cchco_materials
	where year2=#session.fy#
	and flag=1
	order by rank
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QTAMethod">
	select id, descr
	from lu_cchco_ta_method
	where year2=#session.fy#
	and flag is null
	order by rank
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QTAMethodA">
	select id, descr
	from lu_cchco_ta_method
	where year2=#session.fy#
	order by rank
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QTrainMethod">
	select id, descr
	from lu_cchco_train_method
	where year2=#session.fy#
	order by rank
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QTrainCredit">
	select id, descr
	from lu_cchco_train_credit
	where year2=#session.fy#
	order by rank
</cfquery>



<table class="box" width="80%" align="center">
<cfoutput>
<tr>
	<th align="left">Monthly Report for #form.month#</th>
</tr>
<tr>
	<th align="left">Focus Area: #form.myFA#</th>
</tr>
<tr>
	<th align="left">Strategy: #form.activity2#</th>
</tr>
<cfif session.fy LT 2007>
<tr>
	<th>Cessation Center Focus Area Process Measures</th>
</tr>
</cfif>
</cfoutput>
</table>


<cfform name="cess" action="">
<!--- <input type="Hidden" name="rpt" value="<cfoutput>#form.rpt#</cfoutput>">
<input type="Hidden" name="month2" value="<cfoutput>#form.month2#</cfoutput>">
<input type="Hidden" name="month" value="<cfoutput>#form.month#</cfoutput>">
<input type="Hidden" name="myFA" value="<cfoutput>#form.myFA#</cfoutput>">
<input type="Hidden" name="activity2" value="<cfoutput>#form.activity2#</cfoutput>"> --->
<input type="hidden" name="dofunction" value="">
<input type="Hidden" name="org_id_show" value="">
<!--- <input type="Hidden" name="handler" value="<cfoutput>#form.handler#</cfoutput>">
<input type="Hidden" name="year" value="<cfoutput>#form.year#</cfoutput>"> --->



<cfoutput>
<input type="Hidden" name="activity2" value="#form.activity2#">
<!--- <input type="hidden" name="activityProgress" value="#form.activityProgress#"> --->
<input type="Hidden" name="actStatus" value="#form.actStatus#">
<input type="hidden" name="addActiveMotivation" value="#form.addActiveMotivation#">
<input type="hidden" name="addActiveTarget" value="#form.addActiveTarget#">
<!--- <input type="hidden" name="barriers" value="#form.barriers#"> --->
 <cfif isdefined("form.changedDates")><INPUT TYPE="hidden" name="changedDates" value ="#form.changedDates#"></cfif>
<cfif isdefined("form.earned")><input type="hidden" name="earned" value ="#form.earned#"></cfif>
<cfif isdefined("form.endDate")><INPUT TYPE="hidden" NAME="endDate" VALUE="#form.endDate#"> </cfif>
<input type="hidden" name="handler" value="#form.handler#">
<cfif isdefined("form.insNewspaper")><input type="hidden" name="insNewspaper" value ="#form.insNewspaper#"></cfif>
<cfif isdefined("form.insRadio")><input type="hidden" name="insRadio" value ="#form.insRadio#"></cfif>
<cfif isDefined("form.manipCollab")><input type="hidden" name="manipCollab" value="#form.manipCollab#"></cfif>
<!--- <input type="hidden" name="mbarriers" value ="#form.mbarriers#"> --->
<input type="hidden" name="month" value="#form.month#">
<!--- <input type="hidden" name="msuccesses" value ="#form.msuccesses#"> --->
<input type="Hidden" name="myFA" value ="#form.myFA#">
<input type="hidden" name="oldRpt" value="#form.oldRpt#">
<cfif isDefined("form.recruit1")><input type="hidden" name="recruit1" value ="#form.recruit1#"></cfif>
<cfif isDefined("form.recruit2")><input type="hidden" name="recruit2" value ="#form.recruit2#"></cfif>
<cfif isDefined("form.recruit3")><input type="hidden" name="recruit3" value ="#form.recruit3#"></cfif>
<cfif isDefined("form.recruit4")><input type="hidden" name="recruit4" value ="#form.recruit4#"></cfif>
<cfif isDefined("form.recruit5")><input type="hidden" name="recruit5" value ="#form.recruit5#"></cfif>
<input type="hidden" name="reportMonth"  value="#form.reportMonth#">
<input type="hidden" name="reportYear" value="#form.reportYear#">
<input type="Hidden" name="rpt" value="#form.rpt#">
<input type="Hidden" name="rptuserid" value="#form.rptuserid#">
<cfif isdefined("form.showNewspaper")><input type="hidden" name="showNewspaper" value ="#form.showNewspaper#"></cfif>
<cfif isdefined("form.startDate")><INPUT TYPE="hidden" NAME="startDate" VALUE="#form.startDate#"></cfif> 
<input type="Hidden" name="statewide" value="#form.statewide#">
<!--- <input type="hidden" name="successes" value="#form.successes#">
 ---><input type="hidden" name="year" value="#form.year#">

</cfoutput>


<!--- <cfoutput>
<cfset PreserveExclude1 = "dofunction,org_id_show,collabs,rb1,rb2,rb3,rb4,rb5,rb6,rb7,org_id_a,org_id,rb8,rb9,rb10,compliance_a,compliance,rb11,delPP,MCcollabs,MGservice,MCamount,MGdate,delMG">
<cfset PreserveExclude2 = "ACollabs,ACmethod,ACdate,ACMaterial,delAC,TRTrain,TRDate,TRMethod,TRCredit,TRTypeCredit,TRNum,TRMaterial,delTRAIN,delTrainCollabDet,TACollabs,TAdate,TAMethod,TANum,TAMaterial,delTA,activityprogress,successes,barriers,prcSeq,accollabs,collab_id,amount,progress,success,barriers">
<cfif IsDefined("form.fieldnames")>
     <cfloop list="#form.fieldnames#" index="f">
          <cfif NOT IsDefined("PreserveExclude")
               OR (ListFindNoCase(PreserveExclude1, f) IS 0 AND ListFindNoCase(PreserveExclude2, f) IS 0) >
               <cfif f does not contain "TRCollabName_" and f does not contain "TRCollabAttend_">
			   	<cfset FEval = "ListLast(form." & f & ")">
               	<!--- <input name="#f#" type="Hidden" value="#Evaluate(htmlEditformat(FEval))#">
				#f#:  #Evaluate(htmlEditformat(FEval))#<br>
				#f#: #Form[f]# <br><br> --->
				<input name="#f#" type="Hidden" value="#Form[f]#">
			   </cfif>
          </cfif>
     </cfloop>
	 
</cfif>

</cfoutput> --->




<!--- <div align="center">Cessation Center Focus Area Process Measures</div> --->
<!--- <cfif isDefined("form.handler") and form.handler EQ "one">
<!--- <div align="center">Policy and Practice</div> --->
<table border=".2" align="center" class="box" width="80%" title="Collaborating Health Care Organizations' Policy and Practice">
<tr>
	<th colspan="2">Collaborating Health Care Organizations' Policy and Practice</th>
</tr>
<tr>
	<td>Collaborator</td>
	<td>
	<select name="collabs">
	<option value="" selected>
	<cfoutput>
	<cfloop query="Qcollaborators">
	<option value="#seq#"<cfif isDefined("form.org_id_show") and form.org_id_show EQ "1" and form.collabs EQ seq>selected</cfif>>#name#
	</cfloop>
	</cfoutput>
	</select> 
	</td>
</tr>
<tr>
	<td>Does organization have a written policy, procedure or guideline on tobacco dependence treatment?</td>
	<td>
		<input type="Radio" name="rb1" value="1"<cfif isDefined("form.org_id_show") and form.org_id_show EQ "1" and form.rb1 EQ "1">checked</cfif>>Yes&nbsp;&nbsp;&nbsp;
		<input type="Radio" name="rb1" value="0" <cfif (isDefined("form.org_id_show") and ((form.org_id_show EQ "1" and form.rb1 EQ "0") or form.org_id_show NEQ "1")) or Not isDefined("form.org_id_show")>checked</cfif>>No
	</td>
</tr>
<tr>
	<td colspan="2">Does the organization's written policy, procedure, or guideline include...</td>
</tr>
<tr>
	<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Every patient is screened for tobacco use?</td>
	<td nowrap>
		<input type="Radio" name="rb2" value="1" <cfif isDefined("form.org_id_show") and form.org_id_show EQ "1" and form.rb2 EQ "1">checked</cfif>>Yes&nbsp;&nbsp;&nbsp;
		<input type="Radio" name="rb2" value="0" <cfif isDefined("form.org_id_show") and form.org_id_show EQ "1" and form.rb2 EQ "0">checked</cfif> >No &nbsp;&nbsp;&nbsp;
		<input type="Radio" name="rb2" value="2" <cfif (isDefined("form.org_id_show") and ((form.org_id_show EQ "1" and form.rb2 EQ "2") or form.org_id_show NEQ "1")) or Not isDefined("form.org_id_show")>checked</cfif>>NA
	</td>
</tr>
<tr>
	<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Every tobacco user is provided with brief counseling?</td>
	<td>
		<input type="Radio" name="rb3" value="1" <cfif isDefined("form.org_id_show") and form.org_id_show EQ "1" and form.rb3 EQ "1">checked</cfif> >Yes&nbsp;&nbsp;&nbsp;
		<input type="Radio" name="rb3" value="0" <cfif isDefined("form.org_id_show") and form.org_id_show EQ "1" and form.rb3 EQ "0">checked</cfif>  >No &nbsp;&nbsp;&nbsp;
		<input type="Radio" name="rb3" value="2" <cfif (isDefined("form.org_id_show") and ((form.org_id_show EQ "1" and form.rb3 EQ "2") or form.org_id_show NEQ "1")) or Not isDefined("form.org_id_show")>checked</cfif>>NA
	</td>
</tr>
<tr>
	<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Providers receive ongoing training?</td>
	<td>
		<input type="Radio" name="rb4" value="1" <cfif isDefined("form.org_id_show") and form.org_id_show EQ "1" and form.rb4 EQ "1">checked</cfif> >Yes&nbsp;&nbsp;&nbsp;
		<input type="Radio" name="rb4" value="0"  <cfif isDefined("form.org_id_show") and form.org_id_show EQ "1" and form.rb4 EQ "0">checked</cfif> >No &nbsp;&nbsp;&nbsp;
		<input type="Radio" name="rb4" value="2" <cfif (isDefined("form.org_id_show") and ((form.org_id_show EQ "1" and form.rb4 EQ "2") or form.org_id_show NEQ "1")) or Not isDefined("form.org_id_show")>checked</cfif>>NA
	</td>
</tr>
<tr>
	<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;A procedure for giving feedback to providers?</td>
	<td>
		<input type="Radio" name="rb5" value="1" <cfif isDefined("form.org_id_show") and form.org_id_show EQ "1" and form.rb5 EQ "1">checked</cfif> >Yes&nbsp;&nbsp;&nbsp;
		<input type="Radio" name="rb5" value="0"  <cfif isDefined("form.org_id_show") and form.org_id_show EQ "1" and form.rb5 EQ "0">checked</cfif> >No &nbsp;&nbsp;&nbsp;
		<input type="Radio" name="rb5" value="2" <cfif (isDefined("form.org_id_show") and ((form.org_id_show EQ "1" and form.rb5 EQ "2") or form.org_id_show NEQ "1")) or Not isDefined("form.org_id_show")>checked</cfif>>NA
	</td>
</tr>
<tr>
	<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;A procedure for providing follow up and referrals to tobacco users?</td>
	<td>
		<input type="Radio" name="rb6" value="1" <cfif isDefined("form.org_id_show") and form.org_id_show EQ "1" and form.rb6 EQ "1">checked</cfif> >Yes&nbsp;&nbsp;&nbsp;
		<input type="Radio" name="rb6" value="0"  <cfif isDefined("form.org_id_show") and form.org_id_show EQ "1" and form.rb6 EQ "0">checked</cfif> >No &nbsp;&nbsp;&nbsp;
		<input type="Radio" name="rb6" value="2" <cfif (isDefined("form.org_id_show") and ((form.org_id_show EQ "1" and form.rb6 EQ "2") or form.org_id_show NEQ "1")) or Not isDefined("form.org_id_show")>checked</cfif>>NA
	</td>
</tr>
<tr>
	<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Offer pharmacotherapy to tobacco users unless contraindicated?</td>
	<td>
		<input type="Radio" name="rb7" value="1" <cfif isDefined("form.org_id_show") and form.org_id_show EQ "1" and form.rb7 EQ "1">checked</cfif> >Yes&nbsp;&nbsp;&nbsp;
		<input type="Radio" name="rb7" value="0" <cfif isDefined("form.org_id_show") and form.org_id_show EQ "1" and form.rb7 EQ "0">checked</cfif>  >No &nbsp;&nbsp;&nbsp;
		<input type="Radio" name="rb7" value="2" <cfif (isDefined("form.org_id_show") and ((form.org_id_show EQ "1" and form.rb7 EQ "2") or form.org_id_show NEQ "1")) or Not isDefined("form.org_id_show")>checked</cfif>>NA
	</td>
</tr>


<tr>
	<td>Does organization have an identification system to assess the smoking status of every patient? If yes, select type:</td>
	<td>
		<input type="Radio" name="org_id_a" value="1" <cfif isDefined("form.org_id_show") and form.org_id_show EQ "1" and form.org_id_a EQ "1">checked</cfif>  onclick="toggle();">Yes&nbsp;&nbsp;&nbsp;
		<input type="Radio" name="org_id_a" value="0" <cfif (isDefined("form.org_id_show") and ((form.org_id_show EQ "1" and form.org_id_a EQ "0") or form.org_id_show NEQ "1")) or Not isDefined("form.org_id_show")>checked</cfif> onclick="toggle();">No
	</td>
</tr>
<cfif isDefined("form.org_id_show") and form.org_id_show EQ "1" and form.org_id_a EQ "1">
<tr>
	<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;If yes, select type(s):</td>
	<td>
		<select  name="org_id" multiple size="4" class="mlti">
		<cfoutput>
		<cfloop query="Qident">
		<option value="#id#"<cfif isDefined("form.org_id") and listContains(form.org_id, id)> selected</cfif>>#descr#
		</cfloop>
		</cfoutput>
		</select>
	</td>
		
</tr>
</cfif>

<tr>
	<td>Does the organization have a staff person assigned as the Tobacco Dependence Treatment Coordinator?</td>
	<td>
		<input type="Radio" name="rb8" value="1"<cfif isDefined("form.org_id_show") and form.org_id_show EQ "1" and form.rb8 EQ "1">checked</cfif>>Yes&nbsp;&nbsp;&nbsp;
		<input type="Radio" name="rb8" value="0" <cfif (isDefined("form.org_id_show") and ((form.org_id_show EQ "1" and form.rb8 EQ "0") or form.org_id_show NEQ "1")) or Not isDefined("form.org_id_show")>checked</cfif>>No
	</td>
</tr>
<tr>
	<td>Does the organization provide educational opportunities to clinicians and staff to promote counseling with tobacco-using patients?</td>
	<td>
		<input type="Radio" name="rb9" value="1"<cfif isDefined("form.org_id_show") and form.org_id_show EQ "1" and form.rb9 EQ "1">checked</cfif>>Yes&nbsp;&nbsp;&nbsp;
		<input type="Radio" name="rb9" value="0" <cfif (isDefined("form.org_id_show") and ((form.org_id_show EQ "1" and form.rb9 EQ "0") or form.org_id_show NEQ "1")) or Not isDefined("form.org_id_show")>checked</cfif>>No
	</td>
</tr>
<tr>
	<td>Does the organization provide resources and materials to clinicians/staff to promote screening and brief counseling with tobacco-using patients?</td>
	<td>
		<input type="Radio" name="rb10" value="1"<cfif isDefined("form.org_id_show") and form.org_id_show EQ "1" and form.rb10 EQ "1">checked</cfif>>Yes&nbsp;&nbsp;&nbsp;
		<input type="Radio" name="rb10" value="0" <cfif (isDefined("form.org_id_show") and ((form.org_id_show EQ "1" and form.rb10 EQ "0") or form.org_id_show NEQ "1")) or Not isDefined("form.org_id_show")>checked</cfif>>No
	</td>
</tr>


<tr>
	<td>Does the organization assess provider compliance with the tobacco dependence treatment policy, procedure, or guideline?<br>If yes, how is compliance assessed?</td>
	<td>
		<input type="Radio" name="compliance_a" value="1"<cfif isDefined("form.org_id_show") and form.org_id_show EQ "1" and form.compliance_a EQ "1">checked</cfif> onclick="toggle();">Yes&nbsp;&nbsp;&nbsp;
		<input type="Radio" name="compliance_a" value="0" <cfif (isDefined("form.org_id_show") and ((form.org_id_show EQ "1" and form.compliance_a EQ "0") or form.org_id_show NEQ "1")) or Not isDefined("form.org_id_show")>checked</cfif> onclick="toggle();">No
	</td>
</tr>
<cfif isDefined("form.org_id_show") and form.org_id_show EQ "1" and form.compliance_a EQ "1"><tr>
	<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;If yes, how is compliance assessed?</td>
	<td>
		<select  name="compliance" multiple size="4" class="mlti">
		<cfoutput>
		<cfloop query="Qfeedback">
		<option value="#id#"<cfif isDefined("form.compliance") and listContains(form.compliance, id)> selected</cfif>>#descr#
		</cfloop>
		</cfoutput>
		</select>
	</td>
</tr>
</cfif>

<tr>
	<td>Does the organization give feedback (e.g. report cards) to providers?</td>
	<td>
		<input type="Radio" name="rb11" value="1"<cfif isDefined("form.org_id_show") and form.org_id_show EQ "1" and form.rb11 EQ "1">checked</cfif>>Yes&nbsp;&nbsp;&nbsp;
		<input type="Radio" name="rb11" value="0" <cfif (isDefined("form.org_id_show") and ((form.org_id_show EQ "1" and form.rb11 EQ "0") or form.org_id_show NEQ "1")) or Not isDefined("form.org_id_show")>checked</cfif>>No
	</td>
</tr>
<tr><td colspan="2" align="right"><input type="Submit" value="Add" onclick="return add('addpractice');"></td></tr>

</table>
<br>
<cfif QSelPP.recordcount GT 0>
<table align="center" class="box" width="80%"  border=".1">

<tr>
	<td rowspan="2" valign="top">Collaborator</td>
	<td rowspan="2" valign="top">Written policy, procedure or guideline?</td>
	<td colspan="6" valign="top">Does the organization's written policy procedure or guideline include...</td>
	<td rowspan="2" valign="top">Identification system?</td>
</tr>	
<tr>
	<td valign="top">Every patient is screened for tobacco use?</td>
	<td valign="top">Every tobacco user is provided with brief counseling?</td>
	<td valign="top">Providers receive ongoing training?</td>
	<td valign="top">A procedure for giving feedback to providers?</td>
	<td valign="top">A procedure for providing follow up and referrals to tobacco users?</td>
	<td valign="top">Offer pharmacotherapy to tobacco users unless contraindicated?</td>	
</tr>	
<cfoutput>

<cfloop query="QSelPP">

<tr bgcolor="Silver">
	<td>#QSelPP.name#</td>
	<td><cfif QSelPP.rb1 EQ 1>YES<cfelse>NO</cfif></td>
	<td><cfif QSelPP.rb2 EQ 1>YES<cfelseif QSelPP.rb2 EQ 2>NA<cfelse>NO</cfif></td>
	<td><cfif QSelPP.rb3 EQ 1>YES<cfelseif QSelPP.rb3 EQ 2>NA<cfelse>NO</cfif></td>
	<td><cfif QSelPP.rb4 EQ 1>YES<cfelseif QSelPP.rb4 EQ 2>NA<cfelse>NO</cfif></td>
	<td><cfif QSelPP.rb5 EQ 1>YES<cfelseif QSelPP.rb5 EQ 2>NA<cfelse>NO</cfif></td>
	<td><cfif QSelPP.rb6 EQ 1>YES<cfelseif QSelPP.rb6 EQ 2>NA<cfelse>NO</cfif></td>
	<td><cfif QSelPP.rb7 EQ 1>YES<cfelseif QSelPP.rb7 EQ 2>NA<cfelse>NO</cfif></td>
<cfif QSelPP.org_id_a EQ "1">
	<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QPP_det_id">
	select id, descr
	from lu_chcopp_id
	where id in (#QSelPP.org_id#)
	order by rank
	</cfquery>
	<td>#valueList(QPP_det_id.descr, '<br>')#</td>
<cfelse>
	<td>NO</td>
</cfif>
	
</tr>

</cfloop>
</cfoutput>
</table>
<br>
<table align="center" class="box" width="80%"  border=".1">
<tr>	
	<td valign="top">Collaborator</td>
	<td valign="top">Tobacco Dependence Treatment Coordinator?</td>
	<td valign="top">Educational opportunities to staff to promote counseling?</td>
	<td valign="top">Resources and materials to staff to promote screening and counseling?</td>
	<td valign="top">Assess provider compliance?</td>
	<td valign="top">Feedback to providers?</td>
	<td valign="top">Delete?</td>
</tr>
<cfoutput>
<cfloop query="QSelPP">

<tr bgcolor="Silver">
	<td>#QSelPP.name#</td>
	<td><cfif QSelPP.rb8 EQ 1>YES<cfelse>NO</cfif></td>
	<td><cfif QSelPP.rb9 EQ 1>YES<cfelse>NO</cfif></td>
	<td><cfif QSelPP.rb10 EQ 1>YES<cfelse>NO</cfif></td>
	
<cfif QSelPP.compliance_a EQ "1">
	<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QPP_det_feedback">
	select id, descr
	from lu_chcopp_feedback
	where id in (#QSelPP.compliance#)
	order by rank
</cfquery>
	<td>#ValueList(QPP_det_feedback.descr, '<br>')#</td>
<cfelse>
	<td>NO</td>
</cfif>
	
	
	
	<td><cfif QSelPP.rb11 EQ 1>YES<cfelse>NO</cfif></td>
	<td>Delete<input type="Checkbox" name="delPP" value="#QSelPP.seq#"></td>
	
</tr>
</cfloop>
</cfoutput>
<tr>
	<td colspan="7" align="right"><input type="Submit" value="Delete" onclick="return add('delpractice');"></td>
</tr>
</table>
</cfif> 
--->
<cfquery datasource="#application.DataSource#"  		 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QselPriorTargetHCPO">
select  
	collab_id, name,
	case 
	 when b.unit IS NULL then b.NAME
	 else b.unit + ' ' + b.NAME
	end as unitname, a.month2, funded_service, amount, other_funded_service
	from chco_mgf as a, collaborators as b, months as m
	where 
	a.userid='#session.userid#'
	and a.year2=#session.fy#
	and a.collab_id=b.seq
	and a.strategy = '#form.activity2#'
	and a.month2=m.mon
	and a.year2=m.year2
	and m.rank < (select m2.rank from months as m2 where m2.mon='#form.month#' and m2.year2 = #session.fy#)
	order by m.rank, 2, 4, 5
	
</cfquery>
<cfif isDefined("form.handler") and form.handler EQ "two">
<cfquery datasource="#application.DataSource#"  		 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QselServ">
	select num, descrip from lu_ccfundedServ
	where year2=#session.fy#
	and (del is Null or del !=1)
	order by rank
	
</cfquery>
<!--- <br><hr><br>
<div align="center">Mini-grants</div> --->
<table border=".1" align="center" class="box" width="80%" >
<tr>
	<th colspan=<cfif session.fy LT 2007>"5"<cfelse>"4"</cfif>>
	<cfif session.fy LT 2007>
	Collaborating Health Care Organizations Receiving Mini-grant Funding
	<cfelse>
	Stipends and mini-grants to health care organizations
	</cfif>
	</th>
</tr>
<tr>
	<th>Target HCPO</th>
	<th>Funded Service</th>
	<th>Dollar Amount of Award</th>
	<cfif session.fy LT 2007><th>Date of Award</th></cfif>
	<th>Delete</th>
</tr>
<tr>
		<td valign="top">
		<select name="MGcollabs">
	<option value="" selected>
	<cfoutput>
	<cfloop query="Qcollaborators">
	<option value="#seq#">#unitname#
	</cfloop>
	</cfoutput>
	</select> 
	</td>
		<td valign="top">
		<cfif session.fy LT 2007>
		<input type="text" name="MGservice" size="40" >
		<cfelse>
<!--- 		<cfselect name="MGservice"  class="mlti" query="QselServ" value="num" display="descrip" multiple="yes"></cfselect>
 --->		<cfoutput>
		<cfloop query="QselServ">
			<input type="checkbox" name="MGservice" value="#num#"> #descrip#<br>
		</cfloop>
		&nbsp;If other, please describe:<br>
		&nbsp;<input type="text" name="other_funded_service" size="45">
		</cfoutput>
		</cfif>
		
		
		</td>
		<td valign="top">$<cfinput type="text" name="MGamount"></td>
		<cfif session.fy LT 2007><td><cfinput type="text" name="MGdate"></td></cfif>
		<td>&nbsp;</td>
</tr>
<tr>
<td  colspan=<cfif session.fy LT 2007>"5"<cfelse>"4"</cfif>><input type="Submit" value="Add" onclick="return checkMG();" class="AddButton"></td>
</tr>


<cfif QselPriorTargetHCPO.recordcount GT 0>

<tr>
<td colspan="4">
<table border=".1" align="center" class="box" width="100%">
<tr>
	<th align="left"  colspan="4">Mini-grant/Stipend funded Target  HCPOs:</th>
</tr>
<tr>
	<th>HCPO</th>
	<th>Month Entered</th>
	<th>Services</th>
	<th>Funding Amount</th>
</tr>
<cfoutput><cfloop query="QselPriorTargetHCPO">
<cfset lulist = '#QselPriorTargetHCPO.funded_service#'>
	<tr>
		<td valign="top">#unitname#</td>
		<td valign="top">#month2#</td>
		<td valign="top">
		<cfloop query="QselServ">
			<cfif listcontains(#lulist#, QselServ.num)>#QselServ.descrip#<br></cfif>					
		</cfloop>
		#other_funded_service#</td>
		<td valign="top">$#amount#</td>
	</tr>
</cfloop>
</cfoutput>
</table>
</td>
</tr>


</cfif>


<!--- <tr>
	<td colspan="4" align="right"><input type="Submit" value="Add" onclick="return add('addMG');"></td>
</tr> --->
<cfif QSelMG.recordcount GT 0>
<cfoutput>
<cfloop query="QSelMG">

<tr bgcolor="Silver">
	<td>#QSelMG.unitname#</td>
	<td>
	<cfif session.fy LT 2007>
	#QSelMG.funded_service#	
	<cfelse>
	<cfquery datasource="#application.DataSource#"  		 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QselServdet">
	select descrip from lu_ccfundedserv
	where year2=#session.fy#
	and num in (#QSelMG.funded_service#)	
	</cfquery>
	#valuelist(QselServdet.descrip, "<br>")#
	<cfif isDefined("QSelMG.other_funded_service") and QSelMG.other_funded_service	NEQ "">
	#QSelMG.other_funded_service#
	</cfif>
	</cfif>
	</td>
	<td>$#QSelMG.amount#</td>
	<cfif session.fy LT 2007><td>#dateformat(QSelMG.award_date, 'm/d/yyyy')#</td></cfif>
	<td>Delete<input type="Checkbox" name="delMG" value="#QSelMG.seq#"></td>
</tr>
</cfloop>
</cfoutput>
<tr>
	<td colspan=<cfif session.fy LT 2007>"5"<cfelse>"4"</cfif> align="left"><input type="Submit" value="Delete" onclick="return add('delMG');" class="DelButton"></td>
</tr>
</cfif>
</table>
<cfelseif isDefined("form.handler") and form.handler EQ "three">
<!--- <br><hr><br>
<div align="center">Administrative Commitment</div> --->

<table border=".1" align="center" class="box" width="80%" >
<tr>
	<th <cfif session.fy LTE 2008>colspan="5"<cfelse>colspan="6"</cfif>>Contacts with Collaborating Health Care Organizations to get Administrative Commitment</th>
</tr>
<tr>
	<th>Target HCPO</th>
	<th>Method of Contact</th>
	<th>Date of Contact</th>
	<th>Resources and Information Provided</th>	
	<th>Delete</th>
</tr>
<tr>
		<td valign="top">
		<select name="ACcollabs">
			<option value="" selected>
			<cfoutput>
			<cfloop query="Qcollaborators">
			<option value="#seq#">#unitname#
			</cfloop>
			</cfoutput>
		</select> 
		</td>
		<td valign="top"><cfselect NAME="ACmethod" query="QACMethods" display="descr" value="id" queryPosition="Below"><option value="">Please select</option></cfselect></td>		
		<td valign="top"><input type="text" name="ACdate"></td>
		<td valign="top">
		<cfif session.fy LT 2007>
		<cfselect NAME="ACMaterial" query="QACMaterials" display="descr" value="id" multiple="Yes" size="4" class="mlti"></cfselect>
		<cfelse>
		<cfoutput>
		<cfloop query="QACMAterials">
		<input type="checkbox" value="#id#" NAME="ACMaterial">#descr#<br>
			<cfif id EQ 14>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Please specify:<br>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="other_acmaterial" size="30"><br>
			</cfif>
		</cfloop>
		</cfoutput>
		</cfif>
		<cfif session.fy GT 2008><input type="checkbox" value="1" NAME="ACO">Administrative commitment obtained<br></cfif>
		</td>
		
		<td>&nbsp;</td>
</tr>
<tr>
<td colspan="5">
<input type="Submit" value="Add" onclick="return checkAC();" class="AddButton">
</td></tr>

<cfif QSelAC.recordcount GT 0>
<cfoutput>
<cfloop query="QSelAC">
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QAC_det_method">
	select id, descr
	from lu_cchco_commit_method
	where id in (#QSelAC.method2#)
	and year2=#session.fy#
	order by rank
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QAC_det_materials">
	select id, descr
	from lu_cchco_materials
	where id in (#QSelAC.material#)
	and year2=#session.fy#
	order by rank
</cfquery>
<tr bgcolor="Silver">
	<td>#QSelAC.unitname#</td>
	<td>#valueList(QAC_det_method.descr, '<br>')#</td>
	<td>#dateformat(QSelAC.contact_date, 'm/d/yyyy')#</td>
	<td>#valueList(QAC_det_materials.descr, '<br>')# <cfif isDefined("QSelAC.aco") and QSelAC.aco EQ 1><br>Administrative commitment obtained</cfif>
	<cfif isDefined("QSelAC.other_acmaterial") and QSelAC.other_acmaterial NEQ ""><br>#QSelAC.other_acmaterial#</cfif>
	</td>
	<td>Delete<input type="Checkbox" name="delAC" value="#QSelAC.seq#"</td>
</tr>
</cfloop>
</cfoutput>
<tr>
	<td colspan="5" align="left"><input type="Submit" value="Delete" onclick="return add('delAC');" class="DelButton"></td>
</tr>
</cfif>
</table>
<cfelseif isDefined("form.handler") and form.handler EQ "four">
<!--- <br><hr><br>
<div align="center">Training</div> --->
<table border=".1" align="center" class="box" width="80%" >
<tr>
	<th colspan="8">Contacts with Target Health Care Organizations to Provide Training</th>
</tr>
<tr>
	<th>Training Name</th>
	<th width="5">Training<br>Date</th>
	<th>Training Method Used</th>
	<th>Was Continuing education credit offered?</th>
	<th>If yes, type of credit offered?</th>
	<th width="12">Total # of<br>Attendees</th>
	<th>Resources and Information Provided</th>
	<th>Delete</th>
</tr>
<tr>
	<td valign="top"><input type="Text" name="TRTrain" size="70"></td>
	<td valign="top"><input type="Text" name="TRDate" size="10"></td>
	<td valign="top"><cfselect NAME="TRMethod" query="Qtrainmethod" display="descr" value="id" queryposition="below"><option value="">Please select</option></cfselect></td>
	<td valign="top"><input type="Radio" name="TRCredit" value="1">YES<br><input type="Radio" name="TRCredit" value="0" checked>NO</td>
	<td valign="top"><cfselect NAME="TRTypeCredit" query="QtrainCredit" display="descr" value="id"  multiple="Yes" size="3" class="mlti"></cfselect></td>
	<td valign="top"><input type="Text" name="TRNum" size="10"></td>
	<td valign="top">
	<CFIF SESSION.FY lt 2007>
	<cfselect NAME="TRMaterial" query="QACMaterials" display="descr" value="id" multiple="Yes" size="4" class="mlti"></cfselect>
	<cfelse>
		<cfoutput>
		<cfloop query="QACMAterials">
		<input type="checkbox" value="#id#" name="TRMaterial">#descr#<br>
			<cfif id EQ 14>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Please specify:<br>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="other_TRmaterial" size="30"><br>
			</cfif>
		</cfloop>
		</cfoutput>
		</cfif>
	</td>
	<td>&nbsp;</td>
</tr>
<tr>
<td colspan="8"><input type="Submit" value="Add" onclick="return checkTrain();" class="AddButton"></td>
</tr>

<cfif QSelTRAIN.recordcount GT 0>

<cfloop query="QSelTRAIN">
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QTRAIN_det_method">
	select id, descr
	from lu_cchco_train_method
	where id in (<cfif QSelTRAIN.method2 NEQ "">#QSelTRAIN.method2#<cfelse>0</cfif>)
	and year2=#session.fy#
	order by rank
</cfquery>
<cfif isDefined("QSelTRAIN.type_credit") and QSelTRAIN.type_credit NEQ "">
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QTRAIN_det_type">
	select id, descr
	from lu_cchco_train_credit
	where id in (#QSelTRAIN.type_credit#)
	and year2=#session.fy#
	order by rank
</cfquery>
</cfif>

<cfif isDefined("QSelTRAIN.material") and QSelTRAIN.material NEQ "">
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QTRAIN_det_material">
	select id, descr
	from lu_cchco_materials
	where id in (#QSelTRAIN.material#)
	and year2=#session.fy#
	order by rank
</cfquery>
</cfif>
<cfoutput>
<tr bgcolor="Silver">
	<td>#QSelTRAIN.training#</td>
	<td>#dateformat(QSelTRAIN.train_date, 'm/d/yyyy')#</td>
	<td>#QTRAIN_det_method.descr#</td>
	<td><cfif QSelTRAIN.credit EQ 1>YES<cfelse>NO</cfif></td>
	<td><cfif isDefined("QSelTRAIN.type_credit") and QSelTRAIN.type_credit NEQ "">#valueList(QTRAIN_det_type.descr, '<BR>')#<cfelse>&nbsp;</cfif></td>
	<td>#QSelTRAIN.num_attendees#</td>
	<td><cfif isDefined("QTRAIN_det_material")>#valueList(QTRAIN_det_material.descr, '<br>')#</cfif>
	<cfif isDefined("QSelTRAIN.other_TRmaterial") and QSelTRAIN.other_TRmaterial NEQ ""><br>#QSelTRAIN.other_TRmaterial#</cfif>
	</td>
	<td>Delete<input type="Checkbox" name="delTRAIN" value="#QSelTRAIN.seq#"></td>
</tr>
</cfoutput>
<tr>
	<cfoutput>
	
	<td colspan="2">Target HCPO Name:<br>
	<select name="TRCollabName_#QSelTRAIN.seq#">
	<option selected value="">	
	<cfloop query="Qcollaborators">
	<option value="#seq#">#unitname#
	</cfloop>	
	</select> 
	
	</td>
	<td>Target HCPO Attendence:<br><input type="Text" name="TRCollabAttend_#QSelTRAIN.seq#"></td>
	<td><input type="Submit" value="Add" onclick="return addTRAIN('#QSelTRAIN.seq#');" class="AddButton"></td>
	<td></td>
	<td></td>
	<td></td>
	</cfoutput>
</tr>
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QTRAIN_det_collabs">
	select d.train_seq, d.collab_id, d.attend, d.seq, c.name,
	case 
	 when c.unit IS NULL then c.NAME
	 else c.unit + ' ' + c.NAME
	end as unitname
	from CCHCO_TRAIN_DET as d, collaborators as c
	where d.train_seq=#QSelTRAIN.seq#
	and d.collab_id=c.seq
	order by 6	
</cfquery>

<cfif QTRAIN_det_collabs.recordcount GT 0>
<cfoutput>
<cfloop query="QTRAIN_det_collabs">
<tr>	
	<td colspan="2">#unitname#</td>
	<td>#attend#</td>
	<td>Delete?<input type="Checkbox" name="delTrainCollabDet" value="#seq#"></td>
</tr>
</cfloop>

<tr>
	<td colspan="4" align="left"><input type="Submit" value="Delete Target HCPO(s)" onclick="return delTRAIN2('#QSelTRAIN.seq#');" class="DelButton"></td>
</tr>
</cfoutput>
</cfif>



</cfloop>
<tr>
	<td colspan="8" align="left"><input type="Submit" value="Delete Training(s)" onclick="return add('delTRAIN');" class="DelButton"></td>
</tr>

</cfif>
</table>

<cfelseif isDefined("form.handler") and form.handler EQ "five">
<!--- <br><hr><br>
<div align="center">Technical Assistance</div> --->
<table border=".1" align="center" class="box" width="80%" >
<tr>
	<th colspan="6">Contacts with Target Health Care Organizations to provide Technical Assistance (TA)</th>
</tr>
<tr>
	<th>HCPO Receiving TA</th>
	<th width="5">Date</th>
	<th>Method Used<cfoutput><A HREF="javascript:void(0)"onclick="window.open('#application.basename#/dictionary.cfm##ad','_blank','height=500, width=700,scrollbars=yes')"><img SRC="images/book07.gif"  width="20" height="20" BORDER="0" ALT="Help"></a></cfoutput></th>
	<th width="10"># of HCPO staff receiving TA</th>
	<th>Resources and Information Provided</th>
	
	<th>Delete</th>
</tr>
<tr>
	<td valign="top">
	<select name="TAcollabs">
	<option value="" selected>
	<cfoutput>
	<cfloop query="Qcollaborators">
	<option value="#seq#">#unitname#
	</cfloop>
	</cfoutput>
	</select> 	
	</td>
	<td valign="top"><input type="text" name="TAdate" size="10"></td>
	<td valign="top">
	<cfif session.fy LT 2007>
	<cfselect NAME="TAMethod" query="QTAMethod" display="descr" value="id"></cfselect>
	<cfelse>
		<cfoutput>
		<cfloop query="QTAMethod">
		<input type="radio" value="#id#" name="TAMethod">#descr#<br>
			<cfif id EQ 7>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Please specify:<br>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="other_TAmethod" size="30"><br>
			</cfif>
		</cfloop>
		</cfoutput>
		
	
	</cfif>	
	
	</td>
	<td valign="top"><input type="text" name="TANum" size="10"></td>
	<td valign="top">
	<cfif session.fy LT 2007>
	<cfselect NAME="TAMaterial" query="QACMaterials" display="descr" value="id" multiple="Yes" size="4" class="mlti"></cfselect>
	<cfelse>
		<cfoutput>
		<cfloop query="QACMAterials">
		<input type="checkbox" value="#id#" name="TAMaterial">#descr#<br>
			<cfif id EQ 14>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Please specify:<br>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="other_TAmaterial" size="30"><br>
			</cfif>
		</cfloop>
		</cfoutput>
		
		<cfif session.fy GT 2008>
	<br>
	Quarterly Data:<br><cfoutput>
		<cfloop query="QACMAterialsA">
		<input type="checkbox" value="#id#" name="TAMaterial">#descr#<br>
		</cfloop>
		</cfoutput>
	
	</cfif>
		</cfif>
	</td>
	<td>&nbsp;</td>
</tr>
<tr>
<td><input type="Submit" value="Add" onclick="return checkTA();" class="AddButton"></td>
</tr>
<cfif QSelTA.recordcount GT 0>
<cfoutput>
<cfloop query="QSelTA">
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QTA_det_method">
	select id, descr
	from lu_cchco_ta_method
	where id in (#QSelTA.method2#)
	and year2=#session.fy#
	order by rank
</cfquery>
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QTA_det_material">
	select id, descr
	from lu_cchco_materials
	where id in (#QSelTA.material#)
	and year2=#session.fy#
	order by rank
</cfquery>
<tr bgcolor="Silver">
	<td>#QSelTA.unitname#</td>
	<td>#dateformat(QSelTA.ta_date, 'm/d/yyyy')#</td>
	<td>#QTA_det_method.descr# <cfif QTA_det_method.descr EQ "other">: #QSelTA.other_tamethod#</cfif> </td>
	<td>#QSelTA.num_ta#</td>
	<td>#valueList(QTA_det_material.descr, '<br>')#
	<cfif isDefined("QSelTA.other_tamaterial") and QSelTA.other_tamaterial NEQ ""><br>#QSelTA.other_tamaterial#</cfif>
	</td>
	<td>Delete<input type="Checkbox" name="delTA" value="#QSelTA.seq#"</td>
</tr>
</cfloop>






</cfoutput>
<tr>
	<td colspan="6" align="left"><input type="Submit" value="Delete" onclick="return add('delTA');" class="DelButton"></td>
</tr>
</cfif>




<cfelseif isDefined("form.handler") and form.handler EQ "six">
<table border=".1" align="center" class="box" width="80%" >
	<cfinclude template="cess1_baseline.cfm">
</table>
<cfelseif isDefined("form.handler") and form.handler EQ "seven">
<table border=".1" align="center" class="box" width="80%" >
	<cfinclude template="cess1_PP.cfm">
</table>
</cfif>
<cfif  isDefined("form.handler") and (form.handler EQ "two" OR form.handler EQ "five" OR form.handler EQ "four" OR form.handler EQ "three")>
<cfoutput>
<br>

<cfif form.handler EQ "two">
	<cfset suffix= "_2">
<cfelseif form.handler EQ "three">
	<cfset suffix= "_3">
<cfelseif form.handler EQ "four">
	<cfset suffix= "_4">
<cfelse>
	<cfset suffix= "_5">
</cfif>


<cfset tablename="advoc">
<cfset prog_num = 'progress'&suffix>
<cfset suc_num = 'success'&suffix>
<cfset bar_num = 'barriers'&suffix>

<!--- Select previous month barrier data --->
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QcollabStrat">
select stratName, partners
from sharedActivities as s, useractivities as u
where u.activity=s.stratName
and u.year2=s.year2
and  u.year2=#session.fy#
order by 1
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="activityInfo">
	
	select u.startDate, u.endDate, u.collaborators, u.goal, 
	u.objective, u.strategy, u.typepromo,
	rtrim(cast(p.progNum as char)) + ': ' + p.program as program, o.objective as objective2, u.userid, u.targetgroup
	from useractivities as u, program as p, objectives as o
	where 
	(u.userid = '#session.userid#' 
OR
u.activity in (<cfloop query="QcollabStrat">
			<cfif ListFind(partners, session.user_pk)>
				'#htmleditformat(stratName)#', 
			</cfif>
			</cfloop> 'NONE')
)
	
	and u.activity = '#htmleditformat(form.activity2)#'
	and p.progNum=u.goal
	and o.ID=u.objective
	and u.year2=#session.fy#
	and u.year2=p.year2
	and u.year2=o.year2
	</cfquery>
	
	

<cfquery datasource="#application.DataSource#"  		
			 
			password="#application.db_password#"   		
			username="#application.db_username#" name="oldprog">
			
			<!--- select c.mon, #prog_num# as progress, #suc_num# as success, #bar_num# as barriers
			from months as c, #tablename# as z
			where z.userid = '#activityInfo.userid#'
			and z.activity = '#form.activity2#'
			and c.mon=z.month2
			and c.rank =
			(select max(d.rank) from monthS as d, #tablename# as a
			where d.mon = a.month2 
			and A.#prog_num# is not null 
			and rtrim(a.#prog_num#) <> ''
			and d.mon != '#form.month#'
			AND  A.userid = '#session.userid#'
			and A.activity = '#form.activity2#'
			and A.year2 = #form.year#
			)			
			and z.userid= '#activityInfo.userid#'
			and z.activity='#form.activity2#'
			and z.year2 = #form.year#	 --->	
			
			select c.mon, progress, success, barriers
			from months as c, #tablename# as z
			where z.userid = '#activityInfo.userid#'
			and z.activity = '#form.activity2#'
			and c.mon=z.month2
			and c.year2=z.year2
			and c.rank =
			(select max(d.rank) from monthS as d, #tablename# as a, monthS as b
			where d.mon = a.month2 and d.year2 = a.year2 
			and A.progress is not null 
			and rtrim(cast(a.progress as varchar(8000))) <> ''
			and d.mon != '#form.month#'
			AND  A.userid = '#session.userid#'
			and A.activity = '#form.activity2#'
			and A.year2 = #form.year#
			and b.mon='#form.month#'
			and b.year2=#session.fy#
			and d.rank < b.rank
			)			
			and z.userid= '#activityInfo.userid#'
			and z.activity='#form.activity2#'
			and z.year2 = #form.year#		
			
	

</cfquery>




<cfquery datasource="#application.DataSource#"  		
			 
			password="#application.db_password#"   		
			username="#application.db_username#" name="oldsucc">
			<!--- select c.mon, #prog_num# as progress, #suc_num# as success, #bar_num# as barriers
			from months as c, #tablename# as z
			where z.userid = '#activityInfo.userid#'
			and z.activity = '#form.activity2#'
			and c.mon=z.month2
			and c.rank =
			(select max(d.rank) from monthS as d, #tablename# as a
			where d.mon = a.month2 
			and A.#suc_num# is not null 
			and rtrim(a.#suc_num#) <> ''
			and d.mon != '#form.month#'
			AND  A.userid = '#session.userid#'
			and A.activity = '#form.activity2#'
			and A.year2 = #form.year#
			)			
			and z.userid= '#activityInfo.userid#'
			and z.activity='#form.activity2#'
			and z.year2 = #form.year#		 --->
			
			select c.mon, progress, success, barriers
			from months as c, #tablename# as z
			where z.userid = '#activityInfo.userid#'
			and z.activity = '#form.activity2#'
			and c.mon=z.month2
			and c.year2=z.year2
			and c.rank =
			(select max(d.rank) from monthS as d, #tablename# as a, monthS as b
			where d.mon = a.month2 
			and A.success is not null 
			and rtrim(cast(a.success as varchar(8000))) <> ''
			and d.mon != '#form.month#'
			AND  A.userid = '#session.userid#'
			and A.activity = '#form.activity2#'
			and A.year2 = #form.year#
			and b.mon='#form.month#'
			and d.rank < b.rank
			)			
			and z.userid= '#activityInfo.userid#'
			and z.activity='#form.activity2#'
			and z.year2 = #form.year#	
			
	
</cfquery>

<cfquery datasource="#application.DataSource#"  		
			 
			password="#application.db_password#"   		
			username="#application.db_username#" name="oldbarr">
			
			<!--- select c.mon, #prog_num# as progress, #suc_num# as success, #bar_num# as barriers
			from months as c, #tablename# as z
			where z.userid = '#activityInfo.userid#'
			and z.activity = '#form.activity2#'
			and c.mon=z.month2
			and c.rank =
			(select max(d.rank) from monthS as d, #tablename# as a
			where d.mon = a.month2 
			and A.#bar_num# is not null 
			and rtrim(a.#bar_num#) <> ''
			and d.mon != '#form.month#'
			AND  A.userid = '#session.userid#'
			and A.activity = '#form.activity2#'
			and A.year2 = #form.year#
			)			
			and z.userid= '#activityInfo.userid#'
			and z.activity='#form.activity2#'
			and z.year2 = #form.year# --->		
			
			select c.mon, progress, success, barriers
			from months as c, #tablename# as z
			where z.userid = '#activityInfo.userid#'
			and z.activity = '#form.activity2#'
			and c.mon=z.month2
			and c.year2=z.year2
			and c.rank =
			(select max(d.rank) from monthS as d, #tablename# as a, monthS as b
			where d.mon = a.month2 and d.year2 = a.year2 
			and A.barriers is not null 
			and rtrim(cast(a.barriers as varchar(8000))) <> ''
			and d.mon != '#form.month#'
			AND  A.userid = '#session.userid#'
			and A.activity = '#form.activity2#'
			and A.year2 = #form.year#
			and b.mon='#form.month#'
			and d.rank < b.rank
			)			
			and z.userid= '#activityInfo.userid#'
			and z.activity='#form.activity2#'
			and z.year2 = #form.year#
			
	
</cfquery>


<cfquery datasource="#application.DataSource#"  		
			 
			password="#application.db_password#"   		
			username="#application.db_username#" name="CurSucProgbar">
select   #prog_num# as progress, #suc_num# as success, #bar_num# as barriers
			from  #tablename# 
			where userid = '#activityInfo.userid#'
			and activity = '#form.activity2#'
			and month2='#form.month#'
			and year2=#form.year#
</cfquery>

<cfif CGI.http_referer DOES NOT CONTAIN "cess1.cfm">
	<cfset form.activityProgress=CurSucProgbar.progress>
	<cfset form.Successes=CurSucProgbar.success>
	<cfset form.barriers=CurSucProgbar.barriers>
</cfif>



<cfparam name="form.userid" default=activityInfo.userid>
<input type="Hidden" name="userid" value="#activityInfo.userid#">

<table class="box" align="center">
<tr><td>Strategy Progress:</td></tr>
<cfif oldprog.recordcount GT 0 and oldprog.progress NEQ ""><tr><td colspan="2"><table class="table2"><tr><td width="600">#oldprog.progress#</td></tr></table></td></tr></cfif>
<tr><td colspan="3"><textarea name="activityProgress" cols="120" rows="8" onKeyDown="textCounter(this.form.activityProgress,2200);" onKeyUp="textCounter(this.form.activityProgress,2200);"><cfif isDefined("form.activityProgress")>#form.activityProgress#</cfif></textarea>
<!--- <input type="button" value="Spellcheck" onclick="doSpell2('cess.activityProgress.value');">  --->
</td></tr>

<tr><td>Reasons for Success:</td></tr>
<cfif oldsucc.recordcount GT 0 and oldsucc.success NEQ ""><tr><td colspan="2"><table class="table2"><tr><td width="600">#oldsucc.success#</td></tr></table></td></tr></cfif>
<tr><td colspan="3"><textarea name="Successes" cols="120" rows="8" onKeyDown="textCounter(this.form.Successes,2200);" onKeyUp="textCounter(this.form.Successes,2200);"><cfif isDefined("form.Successes")>#form.Successes#</cfif></textarea>
<!--- <input type="button" value="Spellcheck" onclick="doSpell2('cess.Successes.value');">  --->
</td></tr>


<tr><td>Barriers:</td></tr>
<cfif oldbarr.recordcount GT 0 and oldbarr.barriers NEQ ""><tr><td colspan="2"><table class="table2"><tr><td width="600">#oldbarr.barriers#</td></tr></table></td></tr></cfif> 
<tr><td colspan="3"><textarea name="barriers" cols="120" rows="8"  onKeyDown="textCounter(this.form.barriers,2200);" onKeyUp="textCounter(this.form.barriers,2200);"><cfif isDefined("form.barriers")>#form.barriers#</cfif></textarea>
<!--- <input type="button" value="Spellcheck" onclick="doSpell2('cess.barriers.value');"> --->
</td></tr>
 <tr>
 	<td colspan="3">
	 <input type="button" value="Check Spelling" onClick="spell('document.cess.activityProgress.value', 'document.cess.Successes.value','document.cess.barriers.value')">
	</td>
 </tr>

</table>
</cfoutput>
<br><br>
<div align="center">
<!--- <button>Save and Return to Main Screen</button>--->
 <input type="Submit" value="Save and Return to Main Screen" onclick="return add('<cfoutput>#suffix#</cfoutput>');">

</div>
<cfelse>


<br><br>
<div align="center">
<!--- <button>Save and Return to any Main Screen</button> --->

<input type="button" value="Save and Return to Main Screen" onclick="return return_home();">
</cfif>
</div>

<cfif isDefined("form.dofunction") and (form.dofunction CONTAINS "_" )>
<script language="JavaScript">

return_home();
</script>

</cfif>
<input type="Hidden" name="prcSeq" value="">
</cfform>

</td></tr></table>
<!--- <cfif SESSION.RETROcut NEQ "1">
<CFSET this_month = DatePart('m', now())>
<CFSET thismonth = monthasstring( this_month)>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="curMoncheck">
	select rank from months where mon='#thisMonth#'
</cfquery>
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="rptMoncheck">
	select rank from months where mon='#form.Month#'
</cfquery>
<!--- <cfif 
session.retrocutM NEQ 0 AND  (((session.fy NEQ session.def_fy) AND NOT(rptMonCheck.rank EQ 12  and curMonCheck.rank EQ 1) and session.usermsrext and session.usermsrext NEQ 1)
or
((session.fy EQ session.def_fy)AND (1 EQ 2) AND ((rptMonCheck.rank GT curMonCheck.rank) OR ((rptMonCheck.rank + 1) LT curMonCheck.rank)) and session.usermsrext NEQ 1))>
<script language="JavaScript">
	disableme();
</script>
</cfif>
</cfif> --->
<cfparam name="session.usermsrext" default="0">
  <cfif session.modality NEQ 4>
	<cfset session.RETROcut=0>
</cfif>

<cfif 
isdefined("session.retrocutM") and session.retrocutM NEQ 0 AND  (((session.fy NEQ session.def_fy) AND NOT(rptMonCheck.rank EQ 12  and curMonCheck.rank EQ 1) and session.usermsrext NEQ 1  <!--- and session.modality NEQ 4 --->)
or
((session.fy EQ session.def_fy) AND ((rptMonCheck.rank GT curMonCheck.rank) OR ((rptMonCheck.rank + 1) LT curMonCheck.rank)) and session.usermsrext NEQ 1) <!--- and session.modality NEQ 4 --->
or
((session.fy NEQ session.def_fy) AND ((rptMonCheck.rank GT curMonCheck.rank) OR ((rptMonCheck.rank + 1) LT curMonCheck.rank)) and session.usermsrext NEQ 1 and session.modality EQ 44)
)>
<script language="JavaScript">
	disableme();
</script>
</cfif>
</cfif>
 --->
</body>
<cfinclude template="msr_extm.cfm">
</html>
