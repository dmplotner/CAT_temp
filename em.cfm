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
.box td {border: solid 1px #ccccff;
}

.boxy {
	font-family: verdana, helvetica, sans-serif;
	font-size: 11px;
	list-style:inheritborder-color : #498F49;
	border-collapse: collapse;
	float: none;
}
.box2 {
	font-family: verdana, helvetica, sans-serif;
	font-size: 11px;
	border: none;
	list-style:inherit;
	border-collapse: collapse;
}

.num1 { text-indent: 14pt }
</style>
<!---  <cfoutput>#session.modality# #session.objnum#</cfoutput>
 ---><SCRIPT LANGUAGE="JavaScript" SRC="scripts/cfform.js"> </SCRIPT>
 <SCRIPT LANGUAGE="JavaScript">

function disableme(){
for(var intloop=0; intloop <document.wrk.length; intloop++){
	if(document.wrk[intloop].type=='textarea'){
	document.wrk[intloop].readOnly = true;
	}
	else
document.wrk[intloop].disabled=true;
}
}

  function countit(what){

//Character count script- by javascriptkit.com
//Visit JavaScript Kit (http://javascriptkit.com) for script
//Credit must stay intact for use

formcontent=what.form.activity.value;
what.form.activitydisplaycount.value=formcontent.length;


}
  function countit2(what){

//Character count script- by javascriptkit.com
//Visit JavaScript Kit (http://javascriptkit.com) for script
//Credit must stay intact for use

formcontent=what.form.barriers.value;
what.form.barriersdisplaycount.value=formcontent.length;


}
  function countit3(what){

//Character count script- by javascriptkit.com
//Visit JavaScript Kit (http://javascriptkit.com) for script
//Credit must stay intact for use

formcontent=what.form.steps.value;
what.form.stepsdisplaycount.value=formcontent.length;


}

    function toggle_visibility1(id) {
 	     var e = document.getElementById(id);
	     var train = document.wrk.train.value;

		 if(train == 7){
       if(e.style.display == 'block')
          e.style.display = 'none';
       else
          e.style.display = 'block';
		  }
		  else
		  {
		  e.style.display = 'none';
		  }}
 function checkEM2(){
 var act = document.wrk.outlet.value
 var place = document.wrk.placeDT.value
 var emtype = document.wrk.emtype.value
 var eminit = document.wrk.eminitnum.value

 if (act == '')
 {
 alert('Please enter name of outlet before adding this entry to your Monthly Report');
return false;
 }
  if (place == '')
 {
 alert('Please enter date of placement before adding this entry to your Monthly Report');
return false;
 }
   if (emtype == '')
 {
 alert('Please select type before adding this entry to your Monthly Report');
return false;
 }
var radioSelected = false;
for (i = 0;  i < document.wrk.eminitnum.length;  i++)
{
if (document.wrk.eminitnum[i].checked)
radioSelected = true;
}
if (!radioSelected)
{
alert('Please select initiatives or sustainability messages before adding this entry to your Monthly Report');
return (false);
}

 add('addEM2');

 }
 function checkLG(){
 var act = document.wrk.activitydisplaycount.value * 1
 var barr = document.wrk.barriersdisplaycount.value * 1
 var step = document.wrk.stepsdisplaycount.value * 1

 if (act > 2000)
{
alert('Recruitment activities description cannot exceed 2000 characters.');
return false;
}
 if (barr > 2000)
{
alert('Barriers description cannot exceed 2000 characters.');
return false;
}
if (step > 2000)
{
alert('Next steps description cannot exceed 2000 characters.');
return false;
}
add('addLG');
}

function checkOG(){

 var twain = document.wrk.train.value
 if (twain == '')
 {
 alert('Please select training name');
 return false;
 }
add('addOG');
}function add(actvalue){
document.wrk.dofunction.value=actvalue;
return true;}

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
<cfparam name="form.dofunction" default="">
<!--- <cfparam name="form.emq1_1" default=0>
<cfparam name="form.emq1_2" default=0>
<cfparam name="form.emq1_3" default=0>
<cfparam name="form.activity" default="">
<cfparam name="form.barriers" default="">
<cfparam name="form.steps" default=""> --->
<cfparam name="form.eminitnum" default="">
<cfparam name="form.mediarep" default="">
<cfparam name="form.numsub" default="">
<cfparam name="form.numpub" default="">
<cfparam name="form.susdesc" default="">
<cfparam name="form.infradesc" default="">
<cfparam name="session.monum" default="0">
<!--- <cfparam name="form.maxxx" default="2000"> --->
<cfparam name="form.maxxx" default="2000">


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

<cfif session.monum is 5 and session.modality is 4>
<cfset maxxx = 2000>
<cfelse>
<!--- <cfset maxxx = 2000> --->
<cfset maxxx = 2000>
</cfif>



<cfif isdefined("url.seq")>
<cfquery datasource="#application.DataSource#"

	password="#application.db_password#"
	username="#application.db_username#" name="QEM">
	select *
	from ems
	where emid = '#url.seq#'
	</cfquery>

<cfquery datasource="#application.DataSource#"

	password="#application.db_password#"
	username="#application.db_username#" name="QEM2">
	select *
	from ems2
	where emid = '#url.seq#'
	</cfquery>

<cfset form.outlet = "#QEM.outlet#">
<cfset form.placedt = "#QEM.placedt#">
<cfset form.emtype = "#QEM.emtype#">
<cfset form.eminitnum = "#valuelist(QEM2.eminitnum)#">
</cfif>


<cfif isdefined("del_box")>
<cfloop index="x" list="#del_box#">
<cfquery datasource="#application.DataSource#"

	password="#application.db_password#"
	username="#application.db_username#" name="del">
	delete from ems where emid = '#x#'
	</cfquery>
	<cfquery datasource="#application.DataSource#"

	password="#application.db_password#"
	username="#application.db_username#" name="del">
	delete from ems2 where emid = '#x#'
	</cfquery>
</cfloop>
</cfif>
<cfif form.dofunction is 'addEM2'>
<cfif isDefined("addadvocating") and addadvocating EQ "Update">
<cfquery datasource="#application.DataSource#"

	password="#application.db_password#"
	username="#application.db_username#" name="QInsBG">
Update ems
set outlet='#form.outlet#',
placedt=<cfif isDefined("form.placedt")>'#form.placedt#'<cfelse>null</cfif>,
link=<cfif isDefined("form.link")>'#form.link#'<cfelse>null</cfif>,
emtype=<cfif isDefined("form.emtype")>#form.emtype#<cfelse>null</cfif>
where
emid='#form.row_emid#'

</cfquery>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="ems">
delete from ems2
where
emid='#form.row_emid#'
</cfquery>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="ems">
select emid from ems
where
emid='#form.row_emid#'
</cfquery>
<cfelse>
<cfquery datasource="#application.DataSource#"

	password="#application.db_password#"
	username="#application.db_username#" name="QInsCG">
insert into ems
(userid, year2,  mon, outlet,placedt,link,emtype)
values
('#session.userid#', '#session.fy#', '#session.monum#','#form.outlet#','#form.placedt#',<cfif isDefined("form.link")>'#form.link#'<cfelse>null</cfif>,'#form.emtype#')
</cfquery>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="ems">
select max(emid) as emid from ems
where
	userid='#session.userid#'
	and year2=#session.fy#
	and mon= '#session.monum#'
	</cfquery>

</cfif>

<cfloop index="x" list="#form.eminitnum#">
<cfquery datasource="#application.DataSource#"

	password="#application.db_password#"
	username="#application.db_username#" name="QInsCG">
insert into ems2
(emid, eminitnum)
values
('#ems.emid#', '#x#')
</cfquery>
</cfloop>
<cfset form.train = ''>
<cfset getinfra.train = ''>
<cfmail from ="NY-Tobacco-Control-Program@rti.org" to="LXK03@health.state.ny.us" subject="#session.orgName# Earned Media Event Added to CAT" type="html">
<strong>#session.orgName#</strong> has added an Earned Media event in the #monthasstring(session.monum)# Earned Media Report. <strong>#form.outlet#</strong> featured the earned media message.
</cfmail>
</cfif>
<cfif form.dofunction is 'addLG' or form.dofunction is 'addOG' or isdefined("form.addadvocating") or isdefined("form.del_staff")>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="em">
select * from em
where
	userid='#session.userid#'
	and year2=#session.fy#
	and mon= '#session.monum#'
	</cfquery>
	<cfif em.recordcount is 0>
 <cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QInsSE">
insert into em
(userid, year2, mon, entdt,emq1_1,emq1_2,emq1_3,activity,barriers,steps)
values
('#session.userid#', '#session.fy#','#session.monum#',#now()#,
<cfif isDefined("form.emq1_1")>'#form.emq1_1#'<cfelse>null</cfif>,
<cfif isDefined("form.emq1_2")>'#form.emq1_2#'<cfelse>null</cfif>,
<cfif isDefined("form.emq1_3")>'#form.emq1_3#'<cfelse>null</cfif>,
<cfqueryparam cfsqltype="cf_sql_varchar" maxLength = "2200" value="#form.activity#">,
<cfqueryparam cfsqltype="cf_sql_varchar" maxLength = "2200" value="#form.barriers#">,
<cfqueryparam cfsqltype="cf_sql_varchar" maxLength = "2200" value="#form.steps#">)
</cfquery>
<cfelse>

<cfquery datasource="#application.DataSource#"

	password="#application.db_password#"
	username="#application.db_username#" name="QupdSE">
	update em set
	userid = userid

	<cfif isDefined("form.emq1_1") and #form.emq1_1# eq 1>
	,emq1_1 = 1
	<cfelse>
	,emq1_1 = 0
	</cfif>

	<cfif isDefined("form.emq1_2") and  #form.emq1_2# eq 1>
	,emq1_2 = 1
	<cfelse>
	,emq1_2 = 0
	</cfif>

	<cfif isDefined("form.emq1_3") and #form.emq1_3# eq 1>
	,emq1_3 = 1
	<cfelse>
	,emq1_3 = 0
	</cfif>

	,activity = <cfqueryparam cfsqltype="cf_sql_varchar" maxLength = "2200" value="#form.activity#">
	,barriers = <cfqueryparam cfsqltype="cf_sql_varchar" maxLength = "2200" value="#form.barriers#">
	,steps = <cfqueryparam cfsqltype="cf_sql_varchar" maxLength = "2200" value="#form.steps#">

	where
	emid='#em.emid#'
	</cfquery>


<!--- <cfparam name="form.activity" default="#em.activity#">
<cfparam name="form.barriers" default="#em.barriers#">
<cfparam name="form.steps" default="#em.steps#">

<cfparam name="form.emq1_1" default="#em.emq1_1#">
<cfparam name="form.emq1_2" default="#em.emq1_2#">
<cfparam name="form.emq1_3" default="#em.emq1_3#"> --->



</cfif>
<cfif form.dofunction is 'addLG'>
<cfif isDefined("form.return") and form.return EQ "Save and return to Monthly Reporting">
<cfif session.modality EQ 4>
	<!---<cflocation url="activ_list_new2.cfm" addtoken="true">--->
	<cflocation url="monthrepSP.cfm" addtoken="true">

<cfelse>
	<cflocation url="monthrep.cfm" addtoken="true">
</cfif></cfif>
</cfif>
<!--- <cflocation url="monthrep.cfm">
 --->
</cfif>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="em">
select * from em
where
	userid='#session.userid#'
	and year2=#session.fy#
	and mon='#session.monum#'

</cfquery>
<cfif em.recordcount NEQ 0>
<cfparam name="form.activity" default="#em.activity#">
<cfparam name="form.barriers" default="#em.barriers#">
<cfparam name="form.steps" default="#em.steps#">

<cfparam name="form.emq1_1" default="#em.emq1_1#">
<cfparam name="form.emq1_2" default="#em.emq1_2#">
<cfparam name="form.emq1_3" default="#em.emq1_3#">

</cfif>

<cfparam name="form.activity" default="">
<cfparam name="form.barriers" default="">
<cfparam name="form.steps" default="">

<cfparam name="form.emq1_1" default="">
<cfparam name="form.emq1_2" default="">
<cfparam name="form.emq1_3" default="">

<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="Q">
select
	*
	from ems
	where
	userid='#session.userid#'
	and year2=#session.fy#
	and mon='#session.monum#'
	order by outlet
</cfquery>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="eminit">
select
	*
	from eminit
	where year2=#session.fy#
	<cfif session.fy GT 2014 and session.modality EQ 2>and modality = 2<cfelse>and modality = 1</cfif>
	order by rank
</cfquery>
<cfif isdefined("obj") and #obj# is not ''>
<cfset session.objval = '#obj#'></cfif>

<cfparam name="form.activity" default="">
<cfparam name="form.barriers" default="">
<cfparam name="form.steps" default="">
<cfparam name="form.outlet" default="">
<cfparam name="form.link" default="">
<cfparam name="form.emtype" default="">
<cfparam name="form.eminitnum" default="">

<cfparam name="form.PLACEDT" default="">




<cfform action="em.cfm?#session.urltoken#&mo=#url.mo#&obj=#url.obj#" method="post" name="wrk">

<!---<table class="box2" width="775" align="left">--->
<table>
	<tr><td>
<table class="box2" width="775" align="left">
			  <tr><cfoutput>
		<td align="left"><h3>Earned Media Monthly Report for #session.mon#</h3>
	</td></cfoutput>

	  </tr>
	  	  <tr>

		<td align="left"><strong>Earned Media definition:</strong>   Coverage of tobacco-related issues by a news organization and/or partner organization.  Earned media reported on this screen should not include self-generated placements that did not involve third party editorial/content decision-making.
	</td>
  </tr>
  	  	  <tr>
		<td align="left"><br><strong>Q1. Earned media recruitment activities</strong><br>
		<br>What activities did you conduct during this month to try to recruit earned media? (Select all that apply)</td></tr>
		<tr><td class="num1">
		<input type="checkbox" name="emq1_1" value=1 <cfif isdefined("form.emq1_1") and #form.emq1_1# is 1>checked</cfif>>Distributed materials (press release, letter to the editor, press kit, etc.)</td></tr>
		<tr><td class="num1">
		<input type="checkbox" name="emq1_2" value=1 <cfif isdefined("form.emq1_2") and #form.emq1_2# is 1>checked</cfif>>Spoke directly to a reporter, news editor, publisher, station manager, etc. (pitched a story, was interviewed for story, etc.)</td></tr>
		<tr><td class="num1">
		<input type="checkbox" name="emq1_3" value=1 <cfif isdefined("form.emq1_3") and #form.emq1_3# is 1>checked</cfif>>Activated partners to garner earned media on my behalf (community members, allied health partners, etc.)</p>
		</td></tr>
				<tr><td align="left"><br><strong>Q2. Earned media placement</strong><p>What earned media was placed (published or broadcast) during this month?</td></tr>


		</table>
	</td></tr>
	<tr><td>

 <table class="boxy" border=".1" width=700 align="left">
<tr><th width=33%><strong>Brief Description</strong></th><th width=33%><strong>Type</strong></th><th width=33%><strong>Initiatives or sustainability messages addressed</strong> </th></tr>
<tr><td valign="top">Name of outlet:<br>
<input type="text" size=60 maxlength="60" name="outlet" <cfif isDefined("url.seq")>value="<cfoutput>#form.outlet#</cfoutput>"</cfif>><p>
Date of placement:<br>
<cfif isDefined("url.seq")>
<cfinput name="placeDT" type="text" size=10 maxlength="10" required="no" message="Please enter a valid date" validate="date" value="#dateformat(form.placeDT,'m/d/yyyy')#">
<cfelse>
<cfinput name="placeDT" type="text" size=10 maxlength="10" required="no" message="Please enter a valid date" validate="date" >

</cfif><br>
<i>mm/dd/yyyy</i><p>
Moodle (if available):<br>
<input type="text" size=60 name="link"><p>
</p></td>
<td valign="top">
<select name="emtype">
<option value="">Please select</option>
<option value="1" <cfif isDefined("url.seq") and form.emType EQ 1>selected</cfif>>Letter to the editor (print or web)</option>
<option value="2" <cfif isDefined("url.seq") and form.emType EQ 2>selected</cfif>>Newspaper story (print or web)</option>
<option value="3" <cfif isDefined("url.seq") and form.emType EQ 3>selected</cfif>>Editorial / op-ed (print or web)</option>
<option value="4" <cfif isDefined("url.seq") and form.emType EQ 4>selected</cfif>>TV story (broadcast or web)</option>
<option value="5" <cfif isDefined("url.seq") and form.emType EQ 5>selected</cfif>>Newsletter/website story</option>
<option value="6" <cfif isDefined("url.seq") and form.emType EQ 6>selected</cfif>>Radio interview or story</option>
<option value="7" <cfif isDefined("url.seq") and form.emType EQ 7>selected</cfif>>Blog story/discussion </option>





</select></td>
<td valign="top" nowrap>(Select all that apply)<p>
<cfoutput query="eminit">
<input type="checkbox" name="eminitnum" value="#eminitnum#" <cfif isDefined("url.seq") and listfindnocase(form.eminitnum,#eminitnum#)> checked</cfif>>#eminittxt#<br>
</cfoutput>
</p></td></tr>

<tr><td colspan="4">
<input type="submit" name="addadvocating" <cfif isdefined("url.seq")>value="Update"<cfelse>value="Add"</cfif> class="AddButton" onclick="return checkEM2();">
<cfif isdefined("url.seq")><input type="hidden" name="row_emid" value="<cfoutput>#url.seq#</cfoutput>"></cfif>

</td></tr>
</table>

</td></tr>
<tr><td>






	  		<cfif Q.recordcount GT 0>

<table border=".1" class="box" width=700>
<tr>
	<th width="33%"><strong>Brief Description</strong></th>
	<th width="33%"><strong>Type</strong></th>
	<th width="33%"><strong>Initiatives or sustainability messages addressed </strong></th>
	<th width="33%"><strong>Delete</strong></th>
</tr>
<cfoutput><cfloop query="Q">
<cfif isdefined("q.emtype")>
<cfswitch expression="#q.emtype#">
<cfcase value=1>
<cfset mtype = "Letter to the editor (print or web)">
</cfcase>
<cfcase value=2>
<cfset mtype = "Newspaper story (print or web)">
</cfcase>
<cfcase value=3>
<cfset mtype = "Editorial / op-ed (print or web)">
</cfcase>
<cfcase value=4>
<cfset mtype = "TV story (broadcast or web)">
</cfcase>
<cfcase value=5>
<cfset mtype = "Newsletter/website story">
</cfcase>
<cfcase value=6>
<cfset mtype = "Radio interview or story">
</cfcase>
<cfcase value=7>
<cfset mtype = "Blog story/discussion">
</cfcase>

<cfdefaultcase>
<cfset mtype = "">
</cfdefaultcase>
</cfswitch>


</cfif>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="ems2">
select
	distinct eminittxt
	from ems2 e inner
join eminit ei on ei.eminitnum = e.eminitnum where emid = #q.emid# and ei.year2 = #session.fy#
order by eminittxt
</cfquery>

<cfif (#FindNoCase("http://", link)# eq 0) AND (#FindNoCase("https://", link)# eq 0)>
<cfset linky = 'http://' & #link#>
<cfelse>
<cfset linky = #link#>
</cfif>
	<tr>
		<td valign="top" bgcolor="##EEEEEE" border=".1">
			<cfif session.fy LT 2012>
				#outlet#<p>#dateformat(placedt,"mm/dd/yyyy")#<p><a href="#link#">#link#</a>
			<cfelse>
				<a href="javascript: document.wrk.action='em.cfm?#session.urltoken#&mo=#url.mo#&obj=#url.obj#&seq=#emid#'; document.wrk.submit()">#outlet#</a><p>#dateformat(placedt,"mm/dd/yyyy")#<p><a href="#linky#" >#link#</a>
			</cfif>
		</td>
		<td valign="top" bgcolor="##EEEEEE">#mtype#</td>
		<td bgcolor="##EEEEEE" valign="top"><cfloop query="ems2">#eminittxt#<br></cfloop></td>
		<td bgcolor="##EEEEEE"><input type="Checkbox" name="Del_box" value="#emid#"></td>
	</tr>
</cfloop>

</cfoutput>
</table>

<input type="Button" name="del_staff" value="Delete" onclick="submit();" class="DelButton">

</cfif>

</td></tr>
<tr><td>

<table class="box2" width=775>

<tr><th align="left" height=30 valign="bottom"><br>Describe your earned media recruitment activities during this month.  Provide detailed feedback regarding general activities reported in Q1.  </th>
	</tr>
	<cfoutput>
		  <tr>
	  	<td><textarea name="activity" cols=145 rows=14 onkeyup="countit(this)" maxlength="2000">#form.activity#
</textarea>
 <br><input type="button" value="Check Spelling" onClick="spell('document.wrk.activity.value')"></td></tr>
</td></tr>
      <tr>
      <td width="100%" valign="bottom" colspan=2><div align="right" valign="bottom">This text field has a max of 2000 characters. Characters entered: <cfoutput><input type="text" value="#len(em.activity)#" name="activitydisplaycount" size="4" style="border:0;" disabled></cfoutput></td>
    </tr>

<tr><th align="left" height=30 valign="bottom"><br>Describe barriers encountered this month regarding earned media recruitment activities and placement.  </th>
	</tr>

		  <tr>
	  	<td><textarea name="barriers" cols=145 rows=14 onkeyup="countit2(this)" maxlength="2000">#form.barriers#
</textarea>
 <br><input type="button" value="Check Spelling" onClick="spell('document.wrk.barriers.value')"></td></tr>

</td></tr>
      <tr>
      <td width="100%" valign="bottom" colspan=2><div align="right" valign="bottom">This text field has a max of 2000 characters. Characters entered: <cfoutput><input type="text" value="#len(em.barriers)#" name="barriersdisplaycount" size="4" style="border:0;" disabled></cfoutput></td>
    </tr>

<tr><th align="left" height=30 valign="bottom"><br>Next steps regarding earned media recruitment activities.    </th>
	</tr>

		  <tr>
	  	<td><textarea name="steps" cols=145 rows=14 onkeyup="countit3(this)">#form.steps#
</textarea>
 <br><input type="button" value="Check Spelling" onClick="spell('document.wrk.steps.value')" maxlength="2000"></td></tr>

</td></tr>
      <tr>
      <td width="100%" valign="bottom" colspan=2><div align="right" valign="bottom">This text field has a max of 2000 characters. Characters entered: <cfoutput><input type="text" value="#len(em.steps)#" name="stepsdisplaycount" size="4" style="border:0;" disabled></cfoutput></td>
    </tr>
</table></cfoutput>
<input type="hidden" name="dofunction" value="">
			<tr><td align="center" height=20><p><input type="submit" name="return" value="Save" onClick="return checkLG();"></td></tr>
			<tr><td>&nbsp;</td></tr>
			<tr><td align="center" height=20><p><input type="submit" name="return" value="Save and return to Monthly Reporting" onClick="return checkLG();"></td></tr>
</td></tr>



</table>

</cfform>


</td></tr>
</table>

</body>

<cfif session.readOnly EQ 1>
<script language="JavaScript">
	disableme();
</script>
</cfif>


</html>
