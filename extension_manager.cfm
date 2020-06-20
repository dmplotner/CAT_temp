<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<cflocation addtoken="true" url="extension_manager2.cfm">
<html>
<head>
<title>CAT</title>


<cfinclude template="CATstruct.cfm">
<cfinclude template="ListCompare.cfm">
<SCRIPT LANGUAGE="JavaScript" SRC="selectbox.js"></SCRIPT>
<script language="JavaScript">
function flip(){
for(var i = 0; i < document.collaborations.selpartners.length; i++){ 
document.collaborations.selpartners[i].selected = true;
}
if (isdefined(document.collaborations.selpartners)=="undefined"){
alert('Please select at least one collaborator!');
return false;
}
return true;
}
</script>

	 
<tr><td><br><br><br><br></td></tr>
<table class="box" align="center" cellpadding="10" cellspacing="0" border="0" >		
<tr><td align="center"><h2>MSR Extension Management</h2></td></tr>





<cfif isDefined("form.collabs")>
<!--- <cfif isDefined("form.selpartners")> --->
 <cfparam name="form.selpartners" default="none">
<cfquery datasource="#application.DataSource#"  	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QlookupPartner">
	select userid from contact where <!--- orgName --->userid in (#listQualify(htmleditformat(form.selpartners),"'")#)	
</cfquery>

<cfif form.collabs EQ "update">

<cfquery datasource="#application.DataSource#"  	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qlookupext">
	select userid from msr_extensions
</cfquery>

<cfquery datasource="#application.DataSource#"  
	password="#application.db_password#"   		
	username="#application.db_username#" name="QtruncStrat">	
	delete from msr_extensions
	where 
	1=1
	and userid not in ('boceswsnassau', 'boceswssuffolk')
	<cfif Qlookupext.recordcount GT 0>and userid in (#quotedvaluelist(Qlookupext.userid)#)</cfif>
	<cfif QlookupPartner.recordcount GT 0>and userid not in (#quotedvaluelist(QlookupPartner.userid)#)</cfif>
</cfquery>

<cfset newlist=valuelist(QlookupPartner.userid)>
<cfset origlist=valuelist(Qlookupext.userid)>
<cfset revisedList=ListCompare(newlist,origlist)>

<cfloop list="#revisedList#" index="usID">

<cfquery datasource="#application.DataSource#"   
	password="#application.db_password#"   		
	username="#application.db_username#" name="QaddStrat">
	insert into msr_extensions
	(userid, initdate, enddate) 
	values
	('#usID#', getdate(), getdate()+7)	
</cfquery>

<cfquery datasource="#application.DataSource#"   
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qmailinfo">
	<cfif now() gt '11/30/2008'>
	
	select c1.orgname, c1.contact, c1.coordemail,
	c2.coordemail as manmail
	from contact as c1, contact as c2
	where
	c1.cmanager=c2.userid		
	and c1.userid='#usID#' 
	
	
	<cfelse>

	select c1.orgname, c1.contact, c1.coordemail,
	c2.coordemail as manmail
	from contact as c1, contact as c2 , area as a 
	where
	c1.area=a.num	
	and a.manager_id=c2.userid
	and c1.userid='#usID#' 
	and a.year2=#session.fy# 
	
	</cfif>
	
	
	
</cfquery>

<cfif Qmailinfo.recordcount GT 0>
<cfmail to="#Qmailinfo.coordemail#" from="bettybrown@rti.org" cc="#Qmailinfo.manmail#" subject="MSR extension" type="html">
You have been granted an extension to complete or correct data entry in the Community Activity Tracking (CAT) system.  
All extensions are for seven (7) days only and will automatically expire after that time period.  
Please complete all your changes and additions in the seven day time period allotted.
<br><br>
Please contact Nikie Sarris or Betty Brown with questions, at 1-800-848-4091 or <a href="mailto:nsarris@rti.org">nsarris@rti.org</a> or <a href="mailto:bettybrown@rti.org">bettybrown@rti.org</a>.



</cfmail>

</cfif>

</cfloop>
</cfif>
</cfif>
<!--- </cfif> --->


<cfquery datasource="#application.DataSource#" 	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="selectedPartners">
	select distinct m.userid, c.orgname
	from msr_extensions as m, contact as c	
	order by 2
</cfquery>


<cfquery datasource="#application.DataSource#"  	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QallPartners">
select distinct userid, orgname
from contact 
where
orgname is not null and orgname != ''
and 
<cfoutput><cfif (selectedPartners.recordcount GT 0) and (selectedPartners.userid NEQ "")>  userid NOT IN (<cfloop list="#selectedPartners.userid#" index="mypartner">'#mypartner#', </cfloop>'0') and </cfif></cfoutput>
	 1=1
	 order by 2
</cfquery>



<cfquery datasource="#application.DataSource#"  		 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QselPartners">
select distinct orgName, userid from contact
where 
orgname is not null and orgname != ''
and userid in <cfif (selectedPartners.recordcount GT 0) and (selectedPartners.userid NEQ "")>(#quotedValuelist(selectedPartners.userid)#)<cfelse>('')</cfif>
order by 1	
</cfquery>
<cfform name="collaborations" action="extension_manager.cfm?#session.urltoken#">
<input type="Hidden" name="collabs" value="">
<script language="JavaScript">
function setUpd5(value){
document.collaborations.collabs.value=value;
document.collaborations.submit();
}
</script>
<tr><td>

<TABLE  class="box">

<TR>
	<TD>
<INPUT TYPE="hidden" NAME="movepattern1" VALUE="">
	<SELECT NAME="allpartners"  class="mlti" MULTIPLE SIZE=10 onDblClick="moveSelectedOptions(this.form['allpartners'],this.form['selpartners'],true,this.form['movepattern1'].value)">
		<cfoutput>
<cfloop query="QallPartners">
<option value="#userid#">#orgName#
</cfloop> 
</cfoutput>

	</SELECT>
	</TD>
	<TD VALIGN=MIDDLE ALIGN=CENTER>
		<input type="button" style="width:90" ONCLICK="moveSelectedOptions(this.form['allpartners'],this.form['selpartners'],true,this.form['movepattern1'].value)"    name="    >>     "  value="    >>     " class="AddButton">     <BR>
  		<input type="button" style="width:90" ONCLICK="moveSelectedOptions(this.form['selpartners'],this.form['allpartners'],true,this.form['movepattern1'].value)"    name="    <<     "  value="    <<     " class="DelButton">     <BR>
 	</TD>
	<TD>

	<SELECT NAME="selpartners"  class="mlti" MULTIPLE SIZE=10 onDblClick="moveSelectedOptions(this.form['selpartners'],this.form['allpartners'],true,this.form['movepattern1'].value)">
		<cfoutput>
<cfloop query="QselPartners">
<option value="#userid#">#orgName#
</cfloop> 

</cfoutput>

	</SELECT>
	</TD>
</TR>

</TABLE>




<!--- 
<table class="box">
<cfform name="collaborations" action="extension_manager.cfm?#session.urltoken#">
<input type="Hidden" name="collabs" value="">
<script language="JavaScript">
function setUpd5(value){
document.collaborations.collabs.value=value;
document.collaborations.submit();
}
</script>
<tr>
<td colspan="2"><table class="box" ><tr><th colspan="3">Partners:</th></tr>
<tr>
<td align="right" valign="top">
TCP Partners: <br><select name="allpartners" multiple  size="15" class="mlti">
<cfoutput>
<cfloop query="QallPartners">
<option value="#orgName#">#orgName#
</cfloop> 
</cfoutput>
</select>
</td>
<td align="center"><NOBR> 
    <input type="button" style="width:90" onclick="moveDualList( this.form.allpartners,  this.form.selpartners, false )"    name="    >>     "  value="    >>     " class="AddButton">     <BR>
    <NOBR>   
	<input type="button" style="width:90" onclick="moveDualList( this.form.selpartners, this.form.allpartners,  false )"    name="    <<     "  value="    <<     " class="DelButton">     <BR>
    </td>

<td align="left"  valign="top">



TCP Partners with extensions:<br><cfselect name="selpartners" multiple size="15"  required="Yes" message="Please specify at least one county in your catchment area" class="mlti">
<cfoutput>
<cfloop list="#valuelist(QselPartners.orgName)#" index="orgName">
<option value="#orgName#">#orgName#
</cfloop> 
</cfoutput>
</cfselect></td>
</tr></table> --->





</td></tr>
<tr>
<td colspan="3"><input type="button" name="updUser5" value="Submit changes" onclick="flip();setUpd5('update');" class="AddButton"></td>
</tr>
</cfform>
</table></td></tr>	
</table></td></tr>


<tr><td>&nbsp;<br></td></tr>

<tr><td>
<table class="box" align="center" cellpadding="10" cellspacing="0" border="0" >		
<tr><td align="center"><h2>Quarterly Extension Management</h2></td></tr>





<cfif isDefined("form.collabs2")>
<!--- <cfif isDefined("form.selpartners2")> --->
<cfparam name="form.selpartners2" default="none">
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QlookupPartner2">
	select distinct userid from contact where userid in (#listQualify(htmleditformat(form.selpartners2),"'")#)	
</cfquery>



<cfif form.collabs2 EQ "update2">
<cfquery datasource="#application.DataSource#"  	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qlookupext2">
	select userid from quarterly_extensions
</cfquery>

<cfquery datasource="#application.DataSource#"  
	password="#application.db_password#"   		
	username="#application.db_username#" name="QtruncStrat2">	
	delete from quarterly_extensions
	where 
	1=1
	<cfif Qlookupext2.recordcount GT 0>and userid in (#quotedvaluelist(Qlookupext2.userid)#)</cfif>
	<cfif QlookupPartner2.recordcount GT 0>and userid not in (#quotedvaluelist(QlookupPartner2.userid)#)</cfif>
</cfquery>


<cfset newlist2=valuelist(QlookupPartner2.userid)>
<cfset origlist2=valuelist(Qlookupext2.userid)>
<cfset revisedList2=ListCompare(newlist2,origlist2)>

<cfloop list="#revisedList2#" index="usID">

<cfquery datasource="#application.DataSource#"   
	password="#application.db_password#"   		
	username="#application.db_username#" name="QaddStrat2">
	insert into quarterly_extensions
	(userid, initdate, enddate) 
	values
	('#usID#', getdate(), getdate()+7)	
</cfquery>

<cfquery datasource="#application.DataSource#"   
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qmailinfo2">
	
	<cfif now() gt '11/30/2008'>
	
	select c1.orgname, c1.contact, c1.coordemail,
	c2.coordemail as manmail
	from contact as c1, contact as c2
	where
	c1.cmanager=c2.userid		
	and c1.userid='#usID#' 
	
	
	<cfelse>

	select c1.orgname, c1.contact, c1.coordemail,
	c2.coordemail as manmail
	from contact as c1, contact as c2 , area as a 
	where
	c1.area=a.num	
	and a.manager_id=c2.userid
	and c1.userid='#usID#' 
	and a.year2=#session.fy# 
	
	</cfif>
	
	
</cfquery>

<cfif Qmailinfo2.recordcount GT 0>
<cfmail to="#Qmailinfo2.coordemail#" from="bettybrown@rti.org" cc="#Qmailinfo2.manmail#" subject="Quarterly extension" type="html">
You have been granted an extension to complete or correct quarterly data entry in the Community Activity Tracking (CAT) system.  
All extensions are for seven (7) days only and will automatically expire after that time period.  
Please complete all your changes and additions in the seven day time period allotted.
<br><br>
Please contact Betty Brown with any questions, at 1-800-848-4091 or <a href="mailto:bettybrown@rti.org">bettybrown@rti.org</a>.



</cfmail>

</cfif>

</cfloop>
</cfif>
</cfif>
<!--- </cfif> --->



<!--- 

<cfquery datasource="#application.DataSource#"  
	password="#application.db_password#"   		
	username="#application.db_username#" name="QtruncStrat2">	
	delete from quarterly_extensions
</cfquery>

<cfloop query="QlookupPartner2">
<cfquery datasource="#application.DataSource#"   
	password="#application.db_password#"   		
	username="#application.db_username#" name="QaddStrat2">
	insert into quarterly_extensions
	(userid) 
	values
	('#userid#')	
</cfquery>
</cfloop>
</cfif>
</cfif>
</cfif> --->


<cfquery datasource="#application.DataSource#" 	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="selectedPartners2">
	select distinct m.userid, c.orgname
	from quarterly_extensions as m, contact as c	
	order by 2
</cfquery>


<cfquery datasource="#application.DataSource#"  	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QallPartners2">
select distinct userid, orgname
from contact 
where
orgname is not null and orgname != ''
and partnertype in (1,4)
and 
<cfoutput><cfif (selectedPartners2.recordcount GT 0) and (selectedPartners2.userid NEQ "")>  userid NOT IN (<cfloop list="#selectedPartners2.userid#" index="mypartner">'#mypartner#', </cfloop>'0') and </cfif></cfoutput>
	 1=1
	 order by 2
</cfquery>



<cfquery datasource="#application.DataSource#"  		 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QselPartners2">
select distinct orgName, userid from contact
where 
orgname is not null and orgname != ''
and userid in <cfif (selectedPartners2.recordcount GT 0) and (selectedPartners2.userid NEQ "")>(#quotedValuelist(selectedPartners2.userid)#)<cfelse>('')</cfif>
order by 1	
</cfquery>


<tr><td><table class="box">
<cfform name="collaborations2" action="extension_manager.cfm?#session.urltoken#">
<input type="Hidden" name="collabs2" value="">
<script language="JavaScript">
function setUpd6(value){
document.collaborations2.collabs2.value=value;
document.collaborations2.submit();
}

function flip2(){
for(var i = 0; i < document.collaborations2.selpartners2.length; i++){ 
document.collaborations2.selpartners2[i].selected = true;
}
if (isdefined(document.collaborations2.selpartners2)=="undefined"){
alert('Please select at least one partner!');
return false;
}
return true;
}
</script>





<!--- 
<tr>
<td colspan="2"><table class="box" ><tr><th colspan="3">Partners:</th></tr>
<tr>
<td align="right" valign="top">
TCP Partners: <br>
<select name="allpartners2" multiple  size="15" class="mlti">
<cfoutput>
<cfloop query="QallPartners2">
<option value="#orgName#">#orgName#
</cfloop> 
</cfoutput>
</select>
</td>
<td align="center"><NOBR> 
    <input type="button" style="width:90" onclick="moveDualList( this.form.allpartners2,  this.form.selpartners2, false )"    name="    >>     "  value="    >>     " class="AddButton">     <BR>



    <NOBR>   
	<input type="button" style="width:90" onclick="moveDualList( this.form.selpartners2, this.form.allpartners2,  false )"    name="    <<     "  value="    <<     " class="DelButton">     <BR>



    </td>

<td align="left"  valign="top">



TCP Partners with quarterly extensions:<br><cfselect name="selpartners2" multiple size="15"  required="Yes" message="Please specify at least one partner" class="mlti">
<cfoutput>
<cfloop list="#valuelist(QselPartners2.orgName)#" index="orgName">
<option value="#orgName#">#orgName#
</cfloop> 
</cfoutput>
</cfselect></td>
</tr>

 --->


<TR>
	<TD>
<INPUT TYPE="hidden" NAME="movepattern1" VALUE="">
	TCP Partners: <br><SELECT NAME="allpartners2"  class="mlti" MULTIPLE SIZE=10 onDblClick="moveSelectedOptions(this.form['allpartners'],this.form['selpartners'],true,this.form['movepattern1'].value)">
		<cfoutput>
<cfloop query="QallPartners2">
<option value="#userid#">#orgName#
</cfloop> 
</cfoutput>

	</SELECT>
	</TD>
	<TD VALIGN=MIDDLE ALIGN=CENTER>
		<input type="button" style="width:90" ONCLICK="moveSelectedOptions(this.form['allpartners2'],this.form['selpartners2'],true,this.form['movepattern1'].value)"    name="    >>     "  value="    >>     " class="AddButton">     <BR>
  		<input type="button" style="width:90" ONCLICK="moveSelectedOptions(this.form['selpartners2'],this.form['allpartners2'],true,this.form['movepattern1'].value)"    name="    <<     "  value="    <<     " class="DelButton">     <BR>
 	</TD>
	<TD>

	TCP Partners with quarterly extensions:<br><SELECT NAME="selpartners2"  class="mlti" MULTIPLE SIZE=10 onDblClick="moveSelectedOptions(this.form['selpartners2'],this.form['allpartners2'],true,this.form['movepattern1'].value)">
		<cfoutput>
<cfloop query="QselPartners2">
<option value="#userid#">#orgName#
</cfloop> 

</cfoutput>

	</SELECT>
	</TD>
</TR>


</table></td></tr>
<tr>
<td colspan="3"><input type="button" name="updUser6" value="Submit Changes" onclick="flip2();setUpd6('update2');" class="AddButton"></td>
</tr>
</cfform>


<!--- new eoy extension --->
<tr><td>
<table class="box" align="center" cellpadding="10" cellspacing="0" border="0" >		
<tr><td align="center"><h2>EOY Extension Management</h2></td></tr>





<cfif isDefined("form.collabs3")>
<!--- <cfif isDefined("form.selpartners2")> --->
<cfparam name="form.selpartners3" default="none">
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QlookupPartner3">
	select distinct userid from contact where userid in (#listQualify(htmleditformat(form.selpartners3),"'")#)	
</cfquery>



<cfif form.collabs3 EQ "update3">
<cfquery datasource="#application.DataSource#"  	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qlookupext3">
	select userid from eoy_extensions
</cfquery>

<cfquery datasource="#application.DataSource#"  
	password="#application.db_password#"   		
	username="#application.db_username#" name="QtruncStrat3">	
	delete from eoy_extensions
	where 
	1=1
	<cfif Qlookupext3.recordcount GT 0>and userid in (#quotedvaluelist(Qlookupext3.userid)#)</cfif>
	<cfif QlookupPartner3.recordcount GT 0>and userid not in (#quotedvaluelist(QlookupPartner3.userid)#)</cfif>
</cfquery>


<cfset newlist3=valuelist(QlookupPartner3.userid)>
<cfset origlist3=valuelist(Qlookupext3.userid)>
<cfset revisedList3=ListCompare(newlist3,origlist3)>

<cfloop list="#revisedList3#" index="usID">

<cfquery datasource="#application.DataSource#"   
	password="#application.db_password#"   		
	username="#application.db_username#" name="QaddStrat3">
	insert into eoy_extensions
	(userid, initdate, enddate) 
	values
	('#usID#', getdate(), getdate()+7)	
</cfquery>

<cfquery datasource="#application.DataSource#"   
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qmailinfo3">	
	
	
	<cfif now() gt '11/30/2008'>
	
	select c1.orgname, c1.contact, c1.coordemail,
	c2.coordemail as manmail
	from contact as c1, contact as c2
	where
	c1.cmanager=c2.userid		
	and c1.userid='#usID#' 
	
	
	<cfelse>

	select c1.orgname, c1.contact, c1.coordemail,
	c2.coordemail as manmail
	from contact as c1, contact as c2 , area as a 
	where
	c1.area=a.num	
	and a.manager_id=c2.userid
	and c1.userid='#usID#' 
	and a.year2=#session.fy# 
	
	</cfif>
	
</cfquery>

<cfquery datasource="#application.DataSource#"   
	password="#application.db_password#"   		
	username="#application.db_username#" name="QModinfo3">
	
	select c1.orgname, c1.contact, c1.coordemail,
	c2.coordemail as manmail
	from contact as c1, contact as c2, modality_manager as a
	where
	c1.partnertype=a.modality	
	and a.userid=c2.userid
	and c1.userid='#usID#' 
	<!--- and a.year2=#session.fy# --->
</cfquery>

<cfif Qmailinfo3.recordcount GT 0>
<cfmail to="#Qmailinfo3.coordemail#" from="bettybrown@rti.org" cc="#Qmailinfo3.manmail#; #QModinfo3.manmail#" subject="#Qmailinfo3.orgname# EOY extension" type="html">
You have been granted an extension to complete or correct EOY reports in the Community Activity Tracking (CAT) system.  
All extensions are for seven (7) days only and will automatically expire after that time period.  
Please complete all your changes and additions in the seven day time period allotted.
<br><br>
Please contact Betty Brown with any questions, at 1-800-848-4091 or <a href="mailto:bettybrown@rti.org">bettybrown@rti.org</a>.



</cfmail>

</cfif>

</cfloop>
</cfif>
</cfif>



<cfquery datasource="#application.DataSource#" 	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="selectedPartners3">
	select distinct m.userid, c.orgname
	from eoy_extensions as m, contact as c	
	order by 2
</cfquery>


<cfquery datasource="#application.DataSource#"  	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QallPartners3">
select distinct userid, orgname
from contact 
where
orgname is not null and orgname != ''

and 
<cfoutput><cfif (selectedPartners3.recordcount GT 0) and (selectedPartners3.userid NEQ "")>  userid NOT IN (<cfloop list="#selectedPartners3.userid#" index="mypartner">'#mypartner#', </cfloop>'0') and </cfif></cfoutput>
	 1=1
	 order by 2
</cfquery>



<cfquery datasource="#application.DataSource#"  		 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QselPartners3">
select distinct orgName, userid from contact
where 
orgname is not null and orgname != ''
and userid in <cfif (selectedPartners3.recordcount GT 0) and (selectedPartners3.userid NEQ "")>(#quotedValuelist(selectedPartners3.userid)#)<cfelse>('')</cfif>
order by 1	
</cfquery>


<tr><td><table class="box">
<cfform name="collaborations3" action="extension_manager.cfm?#session.urltoken#">
<input type="Hidden" name="collabs3" value="">
<script language="JavaScript">
function setUpd7(value){
document.collaborations3.collabs3.value=value;
document.collaborations3.submit();
}

function flip3(){
for(var i = 0; i < document.collaborations3.selpartners3.length; i++){ 
document.collaborations3.selpartners3[i].selected = true;
}
if (isdefined(document.collaborations3.selpartners3)=="undefined"){
alert('Please select at least one partner!');
return false;
}
return true;
}
</script>
<TR>
	<TD>
<INPUT TYPE="hidden" NAME="movepattern1" VALUE="">
	TCP Partners: <br><SELECT NAME="allpartners3"  class="mlti" MULTIPLE SIZE=10 onDblClick="moveSelectedOptions(this.form['allpartners3'],this.form['selpartners3'],true,this.form['movepattern1'].value)">
		<cfoutput>
<cfloop query="QallPartners3">
<option value="#userid#">#orgName#
</cfloop> 
</cfoutput>

	</SELECT>
	</TD>
	<TD VALIGN=MIDDLE ALIGN=CENTER>
		<input type="button" style="width:90" ONCLICK="moveSelectedOptions(this.form['allpartners3'],this.form['selpartners3'],true,this.form['movepattern1'].value)"    name="    >>     "  value="    >>     " class="AddButton">     <BR>
  		<input type="button" style="width:90" ONCLICK="moveSelectedOptions(this.form['selpartners3'],this.form['allpartners3'],true,this.form['movepattern1'].value)"    name="    <<     "  value="    <<     " class="DelButton">     <BR>
 	</TD>
	<TD>

	TCP Partners with EOY extensions:<br><SELECT NAME="selpartners3"  class="mlti" MULTIPLE SIZE=10 onDblClick="moveSelectedOptions(this.form['selpartners3'],this.form['allpartners3'],true,this.form['movepattern1'].value)">
		<cfoutput>
<cfloop query="QselPartners3">
<option value="#userid#">#orgName#
</cfloop> 

</cfoutput>

	</SELECT>
	</TD>
</TR>
</table></td></tr>
<tr>
<td colspan="3"><input type="button" name="updUser7" value="Submit Changes" onclick="flip3();setUpd7('update3');" class="AddButton"></td>
</tr>
</cfform>



<cfif isDefined("form.collabs3a") and form.collabs3a EQ "update3a">
update eoy_basics
	set complete = 0
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QupdEOY">
	update eoy_basics
	set complete = 0
	where userid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.unsubPartner#">
	and year2=#session.fy#
</cfquery>
</cfif>

<cfquery datasource="#application.DataSource#"  		 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QallsubPartners">
select distinct c.orgName, c.userid 
from contact c, eoy_basics b
where 
c.userid=b.userid
and b.complete =1
and b.year2=#session.fy#
order by 1	
</cfquery>
<tr><td>
<table class="box" align="center" cellpadding="10" cellspacing="0" border="0" >		
<tr><td align="center"><h2>EOY UnSubmit Management</h2></td></tr>
<cfform name="collaborations3a" action="extension_manager.cfm?#session.urltoken#">
<INPUT TYPE="hidden" NAME="collabs3a" VALUE="">
<script language="JavaScript">
function setUpd8(value){
document.collaborations3a.collabs3a.value=value;
document.collaborations3a.submit();
}
</script>
<tr>
	<td>Submitted Partners: 
	<cfselect name="unsubPartner" query="QallsubPartners" value="userid" display="orgname">
	</cfselect>
	</td>	
	<td>
	<input type="button" name="updUser8" value="Unsubmit EOY report" onclick="setUpd8('update3a');" class="AddButton"></td>
	</td>
</tr>


</cfform>
</table></td></tr>
</body>

</html>
