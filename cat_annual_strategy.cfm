<!--- <cfif session.userid NEQ 'dplotner'>
<cflocation addtoken="true" url="offline.htm"> 
</cfif> --->

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>CAT</title>
<script language="JavaScript">

function alterTarget(location) {
var targetString= "cat_annual_strategy.cfm" 
 document.Form1.changeTarget.value = "change";
document.Form1.action=targetString+"<cfoutput>?#session.urltoken#</cfoutput>#" + location;
<!--_CF_checkForm1(document.Form1);//-->
document.Form1.submit();
}

function presubmit(location) {
var targetString= "cat_annual_strategy.cfm<cfoutput>?#session.urltoken#</cfoutput>#" + location
document.Form1.action=targetString;
document.Form1.submit();
}

function addCollabs(){
document.Form1.addCollab.value = "add";
document.Form1.submit();
}

function checkASP(){
if(document.Form1.objVal.value == '2B' || document.Form1.objVal.value == '2C' || document.Form1.objVal.value == '2Cb' ||document.Form1.objVal.value == '2D' || document.Form1.objVal.value == '2F' || document.Form1.objVal.value == '2G' || document.Form1.objVal.value == '2H' ||document.Form1.objVal.value == '2I' || document.Form1.objVal.value == '2J' || document.Form1.objVal.value == '2K' || document.Form1.objVal.value == '4C' || document.Form1.objVal.value == '4G'){
return true;
}
alert("The objective you selected is not one of the ASP objectives. You must either go back and select a new objective or answer ''NO'' to this question. When you hit the back button, your entries on this screen will not be saved.");
document.Form1.state.value=0;
return false;
}

function process(){
_CF_checkForm1(document.Form1);

if(document.Form1.outcome.value.length==0){
alert("Please enter an outcome!");
return false;
}

if(document.Form1.strategy.selectedIndex==0){
alert("Please select a focus area!");
return false;
}

if ((typeof(document.Form1.activityName)!="undefined") && document.Form1.activityName.value.length < 1){
alert("Please enter a strategy name!");
return false;
}

if ((typeof(document.Form1.colStrat)!="undefined") && document.Form1.colStrat.value==""){
alert("Please enter a joint strategy name!");
return false;
}

if ((typeof(document.Form1.levelChangeSought)!="undefined") && document.Form1.levelChangeSought.value==""){
alert("Please enter a level at which policy change sought!");
return false;
}


if (typeof(document.Form1.hasNoTarget)!="undefined") {
alert("Please enter a target for this strategy!");
return false;
}

if ((typeof(document.Form1.target2)!="undefined") && document.Form1.target2.value=="0"){
alert("Please select a target organization!");
return false;
}
if ((typeof(document.Form1.typePromo)!="undefined") && document.Form1.typePromo.value=="0"){
alert("Please select a type of promotion or provision!");
return false;
}

if ((typeof(document.Form1.target1)!="undefined") && document.Form1.target1.value==""){
alert("Please select a target organization!");
return false;
}
<cfif session.fy LT 2009>
if (((typeof(document.Form1.Foci)=="undefined") && (typeof(document.Form1.target2)!="undefined"))||((typeof(document.Form1.target2)!="undefined")&& document.Form1.Foci.value=="")){
alert("Please select a Focus of monitoring!");
return false;
}
</cfif>
if (document.Form1.startDate.value.length < 1){
alert("Please enter a start date!");
return false;
}
if (document.Form1.endDate.value.length < 1){
alert("Please enter an end date!");
return false;
}

//if (ValidateDate(document.Form1.startDate.value)==false){return false;};
//if (ValidateDate(document.Form1.endDate.value)==false){return false;};
//if (ValidateCompareDate(document.Form1.startDate.value, document.Form1.endDate.value)==false){return false;};


if (typeof(document.Form1.target1)!="undefined" && document.Form1.strategy.value !="5"){
Counter=0;
for (i=0; i<document.Form1.target1.length; i++){
	 // If an element is selected, increment the counter
     if (document.Form1.target1[i].selected == true){
         Counter++;
      } 
   }
   // If the counter is greater than 0, display an alert message.
   if (Counter <1){
      alert("You must select a target!");	  
      return false;
	}
	
}


//if (document.Form1.target.selectedIndex == 0){
//alert("Please select a target!");
//return false;
//}

document.Form1.action="prc_annual.cfm<cfoutput>?#session.urltoken#</cfoutput>";
return true;
}

function addStrat(){
document.Form1.addstrategy.value="add";
process();
}


 function pop_window(url) {
 //remove a attribute if you don't want it to show up
  var popit = window.open(url,'Add_Collaborator','scrollbars,width=740,height=480');
 }
 
 function check_strat_name()
 {
 if (document.Form1.activityName.value.match("&")){
 alert("You may not enter a strategy name with a '&'. Please use 'and'");
 document.Form1.activityName.focus();
 }
 }

</script>

<cfparam name="session.rptyr" default="#session.fy#">

<cfif isDefined("form.activityName") and CGI.http_referer DOES NOT Contain "annual_list.cfm" and NOT isDefined("form.flag_proceed")>
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="CheckIfExists">
	select activity
	from userActivities 
	where
	(userid = '#session.userid#'  OR userid='SHARED') and activity='#htmlEditFormat(form.activityName)#'
	and year2=#session.rptyr#
</cfquery>
<cfif CheckIfExists.recordcount NEQ 0>
<script language="JavaScript">
alert("Please use a strategy name not already in use, or previously used");
history.back();
</script>
</cfif>
</cfif>

<cfif isDefined("url.NYP") OR isDefined("form.NYP")>
	<cfset session.rptyr=session.fy+1>
<cfelse>
	<cfset session.rptyr=session.fy>
</cfif>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="countyheadache">
select catchment 
from contact
where userid = '#session.userid#'	
</cfquery>



<cfquery datasource="#application.DataSource#" 		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="selCounties">
select countyName, FIPS from counties 
where fips in <cfif isDefined("countyheadache.catchment") and countyheadache.catchment NEQ "">(#valuelist(countyheadache.catchment)#)<cfelse>(0)</cfif>

</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QcollabStrat">
select stratName, partners
from sharedActivities
where stratName not in (select activity from useractivities where year2=#session.fy#)
and year2=#session.fy#
order by 1
</cfquery>


<cfif isDefined("url.programVal") and isDefined("url.objVal")>


	<cfset form.programVal=url.programVal>
	<!--- <cfset form.objVal=#selobj.objective#> --->
	<cfset form.objVal=#url.objVal#>

</cfif>

<cfinclude template="CATstruct.cfm">


<cfif cgi.http_referer contains "annual_list.cfm" and isDefined("form.activityName")>
	<cfset url.act = htmlEditFormat(form.activityName)>
	
</cfif>
<cfif isDefined("url.act")>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="selActivity">
	select activityName, goal, objective, outcome, actionarea,
	strategy, targetgroup, last_sd as startdate, last_ed as enddate,
	state,campName,otherName,TCPRegional,TCPArea,
	levelchangeSought, issues, impactedCounties, campaignTarget, target2, foci, primSec, issuesAdd, typePromo,
	purpose,pollevel, stratfocus, mgrant, activity, userid, pm_theme, pm_media, QL_ref, TCP_fun
	from userActivities 
	where
	(userid = '#session.userid#'  OR userid='SHARED') and activity='#url.act#'
	and year2=#session.rptyr#
</cfquery>



<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="selbase">
select p.progNum, o.objective, o.id
from  program as p, objectives as o, userActivities as u
where
 p.progNum = o.progNum
 and u.goal=p.progNum
 and  o.id = u.objective
 and (userid = '#session.userid#'  OR userid='SHARED') and activity='#url.act#'
 and u.year2=#session.rptyr#
 and u.year2=o.year2
 and u.year2=p.year2
</cfquery>

<cfset form.programVal=selbase.progNum> 
<cfset form.objVal=selbase.id>

<cfset form.outcome=selactivity.outcome>
<cfset form.actionarea=selactivity.actionarea>
<cfset form.strategy=selactivity.strategy>
<cfif selactivity.userid EQ "SHARED">
	<cfset form.colStrat=selactivity.activity>
<cfelse>
	<cfset form.activityName=selactivity.activity>
</cfif>

<cfset form.activity=selactivity.activityName>
<!--- <cfset form.activityName=selactivity.activity> --->
<!--- <cfset form.activityname=url.act> --->
<cfset form.target1=selactivity.targetgroup>
<cfset form.startdate=selactivity.startdate>
<cfset form.enddate=selactivity.enddate>
<cfset form.purpose=selactivity.purpose>
<cfset form.pollevel=selactivity.pollevel>

<cfset form.state=selactivity.state>
<cfset form.campaign=selactivity.campName>
<cfset form.otherCampaign=selactivity.otherName>
<cfset form.regionalcollab=selactivity.TCPRegional>
<cfset form.areaCollab=selactivity.TCPArea>
<cfset form.levelchangeSought = selactivity.levelchangeSought>
<cfset form.issues = selactivity.issues>
<cfset form.impactedCounties = selactivity.impactedCounties>
<cfset form.campaignTarget = selactivity.campaignTarget>
<cfset form.target2 = selactivity.target2>
<cfset form.foci = selactivity.foci>
<cfset form.primSec = selactivity.primSec>
<cfset form.issuesAdd = selactivity.issuesAdd>
<cfset form.typePromo = selactivity.typePromo>
<cfset form.stratfocus = selactivity.stratfocus>
<cfset form.mgrant = selactivity.mgrant>
<cfset form.pm_media=selactivity.pm_media>
<cfset form.pm_theme=selactivity.pm_theme>
<cfset form.QL_ref=selactivity.QL_ref>
<cfset form.TCP_fun=selactivity.TCP_fun>
</cfif>
	 
<!--- <cfif NOT isDefined("form.activity")>
	<cfset form.activity = form.colstrat>
</cfif> --->

<table class="box" align="left" cellpadding="10" cellspacing="0" border="0"  class="box" width="85%">		





<cfform name="Form1" action="cat_annual_strategy.cfm?#session.urltoken#">


<cfoutput>

<cfquery datasource="#Application.DataSource#"  		 
	password="#Application.db_password#"   		
	username="#Application.db_username#" name="objective">
   select rtrim(cast(p.progNum as char)) + ': ' + p.program as program, p.progNum, o.objective, o.id, rank, isNull(groupname,'') as groupname
   from program as p, objectives as o
   where p.progNum = o.progNum
   and p.progNum= '#form.programVal#'
   and o.ID = '#form.objVal#'
   and p.year2=#session.fy#
   and p.year2=o.year2
   order by 3
</cfquery>

<input type="hidden" name="changeTarget" value="">
<input type="hidden" name="programVal" value="#form.programVal#">
<input type="hidden" name="objVal" value="#form.objVal#">
<input type="hidden" name="goal" value="#objective.program#">
<input type="hidden" name="objective" value="#objective.id#">
<input type="hidden" name="addCollab" value="">
<input type="hidden" name="addstrategy" value="">
<input type="hidden" name="statewide" value="">
<cfif session.rptyr NEQ session.fy>
   		<input type="hidden" name="NYP" value="">
</cfif>
<cfif isDefined("form.activityName") and form.activityName NEQ "">
	<input type="hidden" name="flag_proceed" value="">
</cfif>

<cfquery datasource="#Application.DataSource#"  		 
	password="#Application.db_password#"   		
	username="#Application.db_username#" name="collaboratorQ">
	
	select Unit + ' ' + name 
	from collaborators 
	where userid='#session.userid#'
	and (del is null or del != 1)
	order by 1
	
</cfquery>

<cfquery datasource="#Application.DataSource#"  		 
	password="#Application.db_password#"   		
	username="#Application.db_username#" name="StrategyQ">
	
	select strategy, strategy_Num 
	from strategy 
	where year2=#session.rptyr#
	<cfif session.fy GT 2005 or session.fy LT 1920>
	and strategy_Num != 10
	</cfif>
	<cfif session.modality EQ 1>
	and strategy_num not in (11, 9)
	<cfelseif session.modality EQ 2>
	and strategy_num not in (11, 8)
	<cfelseif session.modality EQ 3>
	and strategy_num not in (11, 8)
	<cfelseif session.modality EQ 4>
	and strategy_num not in (8, 9)
	</cfif>
	order by 2
	
</cfquery>

<cfquery datasource="#Application.DataSource#"  		 
	password="#Application.db_password#"   		
	username="#Application.db_username#" name="ActionAreaQ">
	
	select actionarea, heading, rank 
	from actionArea 
	where year2=#session.rptyr#
	order by rank
	
</cfquery>

<cfif isDefined("form.strategy") and form.strategy NEQ "0">
<cfquery datasource="#Application.DataSource#"  		 
	password="#Application.db_password#"   		
	username="#Application.db_username#" name="targetQ">
	
	select head, target, targetNum 
	from targets 
	where strategyNum = '#form.strategy#'
	and year2=#session.rptyr#
	order by 1,2, rank
</cfquery>

</cfif>  
<tr><td colspan="1">
<table width="95%"  class="boxN" cellpadding="8">

	  <tr>
       <td>Goal</td>
	
   
       <td>#objective.program#</td>
   
   
   <tr>
       <td>Objective</td>
       <td>#objective.objective#</td>
   </tr>
<!--- <cfif session.fy GT 2008 and listcontains('Magazine,Movies,Retail,SponsPromo',objective.groupname)>
<tr><td>&nbsp;</td><td>This strategy is part of the ASP initiative.</td></tr>
</cfif> --->
   
   
    <cfif (isDefined("selActivity") and selActivity.recordcount GT 0) OR (isDefined("form.colStrat") and form.colStrat NEQ "") or (isDefined("form.activityName") and form.activityName NEQ "")>
   
   <tr>
       <td>Strategy Name</td>
       <td> <cfif isDefined("form.activityName")>#form.activityName#<cfelseif isDefined("form.colStrat")>#form.colStrat#</cfif></td>
	   <cfif isDefined("form.colStrat")>
			<input type="Hidden" name="colStrat" value="#form.colStrat#">
		<cfelse>
			<input type="Hidden" name="activityName" value="#form.activityName#">
		</cfif>
	   <!--- <input type="Hidden" name="activityName" value="#form.activityName#"> --->
   </tr>
   <cfelse>
   <a name="strat"></a>
   <tr>
   	<td>Is this a TCP Joint Partner Strategy?<A HREF="javascript:void(0)"onclick="window.open('#application.basename#/dictionary.cfm##tcpjps','_blank','height=500, width=700,scrollbars=yes')"><img SRC="images/book07.gif"  width="20" height="20" BORDER="0" ALT="Help"></a></td>
	<td><input type="Radio"  name="TCPJS" value="1" <cfif isDefined("form.TCPJS") and form.TCPJS EQ "1"> checked</cfif>  onClick="presubmit('strat');">Yes&nbsp;&nbsp;&nbsp;<input type="Radio" name="TCPJS" value="0" <cfif (isDefined("form.TCPJS") and form.TCPJS EQ "0") OR NOT isDefined("form.TCPJS") > checked</cfif>  onClick="presubmit('strat');">No</td>
   </tr>
   <cfif (isDefined("form.TCPJS") and form.TCPJS EQ "0") OR NOT isDefined("form.TCPJS") >
   <tr>
       <td>Strategy Name</td>
       <td>
	   <cfif isDefined("form.activityName")>
	   	<cfinput type="Text" name="activityName" size="70" value="#form.activityName#" onBlur="check_strat_name();">
	   <cfelse>
	   	<cfinput type="Text" name="activityName" size="70" onBlur="check_strat_name();">
	   </cfif>
      </td>
   </tr>
   <cfelseif isDefined("form.TCPJS") and form.TCPJS EQ "1">
   <tr>
   	<td>
		Joint Strategy
	</td>
	<td>
		<select name="colStrat">
			<option value = ""> - Select strategy name-
			<cfloop query="QcollabStrat">
			<cfif ListFind(partners, session.user_pk)>
				<option value="#stratname#" <cfif isDefined("form.colStrat") and form.colStrat EQ "#stratname#"> selected</cfif>>#stratname#
			</cfif>
			</cfloop>
		</select>
	</td>
   </tr>
   </cfif>
   </cfif>
   
    <tr>
       <td>Strategy Description</td>
       <td>
       <textarea rows="5" cols="75" name="activity" ><cfif isDefined("form.activity")>#form.activity#</cfif></textarea>
	   <!--- <input type="button" value="Spellcheck" onclick="doSpell2('Form1.activity.value');"> --->              

     </td>
	 
	 
   </tr>
   
   <tr>
       <td>SMART<A HREF="javascript:void(0)"onclick="window.open('#application.basename#/dictionary.cfm##smart','_blank','height=500, width=700,scrollbars=yes')"><img SRC="images/book07.gif"  width="20" height="20" BORDER="0" ALT="Help"></a>&nbsp;Outcome</td>
	   
       <td><textarea name="outcome" cols="80" rows="5" ><cfif isDefined("form.outcome")>#form.outcome#</cfif></textarea>
	   <!--- <input type="button" value="Spellcheck" onclick="doSpell2('Form1.outcome.value');" > --->
	   </td>
   </tr>

   
   
   
   
   <tr>
       <td><a name="farea"></a>Focus Area
	   

	   	   <A HREF="javascript:void(0)"onclick="window.open('#application.basename#/dictionary.cfm##fa','_blank','height=500, width=700,scrollbars=yes')"><img SRC="images/book07.gif"  width="20" height="20" BORDER="0" ALT="Help"></a></td>
       <td>

       <select name="strategy" onchange="alterTarget('farea');">
	    <option value="0">Please select a Focus Area
		<cfif (session.fy GT 2005 OR session.fy LT 1920) and objective.progNum EQ "5">
	   <option value="10" selected>Infrastructure Development
	   <cfelse>
	 
	  
	   <cfloop query="StrategyQ">
	   	<option value="#strategy_num#" <cfif isDefined("form.strategy") AND ListFind(form.strategy,strategy_num)>selected</cfif>>#strategy#
	   </cfloop>
	    </cfif>
	   </select>
              

     </td>
   </tr>
 <cfif session.fy LT 2009>
   <tr>
   	<td> Is this strategy work being<br>conducted by a mini-grant recipient?</td>
	<td><input type="radio" name="mgrant" value="1"<cfif isDefined("form.mgrant") and form.mgrant EQ "1"> checked</cfif>>Yes&nbsp;&nbsp;&nbsp;<input type="radio" name="mgrant" value="0"<cfif (isDefined("form.mgrant") and form.mgrant NEQ "1") OR NOT isDefined("form.mgrant")> checked</cfif>>No</td>
   </tr>
</cfif>
  

   
   <tr>
       <td>Timeline</td>
       <td>
	   Start Date&nbsp;
	   <cfif isDefined("form.startDate") and cgi.http_referer DOES NOT CONTAIN "cat_annual_strategy.cfm">
	   	   <cfinput type="Text" name="startDate" value="#dateformat(form.startDate, 'm/yyyy')#">(m/yyyy)
	   <cfelseif isDefined("form.startDate")>
	   	   <cfinput type="Text" name="startDate" value="#dateformat(form.startDate,'m/yyyy')#">(m/yyyy)
	   <cfelse>
	   	   <cfinput type="Text" name="startDate">(m/yyyy)
	   </cfif>
	   

	 &nbsp;&nbsp;&nbsp;End Date&nbsp;
	 <cfif isDefined("form.endDate") and cgi.http_referer DOES NOT CONTAIN "cat_annual_strategy.cfm">
	 	<cfinput type="Text" name="endDate" value="#dateformat(form.enddate, 'm/yyyy')#">(m/yyyy)
	 <cfelseif isDefined("form.endDate")>
	 	<cfinput type="Text" name="endDate" value="#dateformat(form.enddate,'m/yyyy')#">(m/yyyy)
	 <cfelse>
	 	<cfinput type="Text" name="endDate">(m/yyyy)
	 </cfif>
	 </td>
   </tr>
   
   </table></td></tr>
   
   <cfif isDefined("form.strategy") and form.strategy EQ "7">
   <tr><td colspan="2"><table class="box">
   <tr>
	<td>
		Type of promotion or provision of cessation services
	<!--- change to table driven --->
		<select name="typePromo">
			<option value="0">
			<option value="1" <cfif isDefined("form.typePromo") and form.typePromo EQ "1"> selected</cfif>>Running a Quit & Win contest
			<option value="2" <cfif isDefined("form.typePromo") and form.typePromo EQ "2"> selected</cfif>>Provision of cessation services
			<option value="3" <cfif isDefined("form.typePromo") and form.typePromo EQ "3"> selected</cfif>>Promotion of cessation services
			<!--- <option value="3" <cfif isDefined("form.typePromo") and form.typePromo EQ "3"> selected</cfif>>Promotion of Quit Line Number
			<option value="4" <cfif isDefined("form.typePromo") and form.typePromo EQ "4"> selected</cfif>>Promotion of use of Medicaid benefit for cessation services
			<option value="5" <cfif isDefined("form.typePromo") and form.typePromo EQ "5"> selected</cfif>>Producing and distributing a guide to cessation services
			<option value="6" <cfif isDefined("form.typePromo") and form.typePromo EQ "6"> selected</cfif>>Promoting the use of Cessation Services--->		
		</select>
	</td>
</tr>

</table></td></tr>   
 </cfif>  
   
   
   <tr><td colspan="3"><table class="box">
<cfif session.fy LT 2009>
  <tr>
   	<td>
		<cfif session.fy LT 2007 and session.fy GT 1920>
			Part of a state-wide Initiative?	   <A HREF="javascript:void(0)"onclick="window.open('#application.basename#/dictionary.cfm##si','_blank','height=500, width=700,scrollbars=yes')"><img SRC="images/book07.gif"  width="20" height="20" BORDER="0" ALT="Help"></a>
		<cfelse>
			Is this strategy part of the ASP initiative?
		</cfif>
	</td>
	<td>
	<input type="Radio" name="state" <cfif session.fy LT 2007 and session.fy GT 1920>onClick="document.Form1.submit();"<cfelse>onClick="return checkASP();"</cfif> value="1"<cfif isDefined("form.state") and form.state EQ "1"> checked</cfif>>Yes&nbsp;&nbsp;&nbsp;
	<input type="Radio" name="state" <cfif session.fy LT 2007 and session.fy GT 1920>onClick="document.Form1.submit();"</cfif> value="0"<cfif Not isDefined("form.state") or (isDefined("form.state") and (form.state EQ "0" or form.state EQ ""))> checked</cfif>>No
	</td>
   </tr>
   
   
   
   
 <cfif isDefined("form.state") and form.state EQ "1" and session.fy LT 2007 and session.fy GT 1920>
   <cfquery datasource="#Application.DataSource#"  		 
	password="#Application.db_password#"   		
	username="#Application.db_username#" name="campaignValues">
	
	select descrip, num
	from state_initiatives
	where year2=#session.rptyr#
	order by rank
	</cfquery>
   
   <tr>
	<td>Name of campaign</td><td>
		<select name="campaign">
		<option value="">-Select a campaign-
		<cfloop query="campaignValues">
			<option value="#num#" <cfif isDefined("form.campaign") and form.campaign EQ "#num#"> selected</cfif>>#descrip#
		</cfloop>
		
		</select>
	</td>
</tr>
</cfif>



<tr>
	<td>Part of a TCP Regional Action Plan?</td><td><input type="radio" name="regionalCollab" value="1" <cfif isDefined("form.regionalCollab") and form.regionalCollab EQ "1">checked</cfif>>Yes&nbsp;&nbsp;&nbsp;<input type="radio" name="regionalCollab" value="0" <cfif NOT isDefined("form.regionalCollab") or (isDefined("form.regionalCollab") and (form.regionalCollab eq "0" or form.regionalCollab eq ""))> checked</cfif>>No</td>
</tr>
<tr>
	<td>Part of a TCP Area Action Plan?</td><td><input type="radio" name="areaCollab" value="1" <cfif isDefined("form.areaCollab") and form.areaCollab EQ "1">checked</cfif>>Yes&nbsp;&nbsp;&nbsp;<input type="radio" name="areaCollab" value="0" <cfif NOT isDefined("form.areaCollab") or (isDefined("form.areaCollab") and (form.areaCollab eq "0" OR form.areaCollab eq ""))> checked</cfif>>No</td>
</tr>
</cfif> 
 </table></td></tr>  
 </cfoutput>
 <tr><td colspan="4"><table class="box">
 
 <cfif isDefined("form.strategy") and form.strategy EQ "1">
 <!--- GOVT POLICY --->
 
<!---  <cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="govtissues">
 
 select num, descrip
 from GOVTissues
 where year2=#session.rptyr#
 order by rank
 </cfquery>
 <tr><td colspan="2">Issue addressed by education activity<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 <select name="Issues">
 <cfoutput>
 <cfloop query="govtissues">
 	<option  value="#num#" <cfif isDefined("form.issues") and form.issues EQ "#num#"> selected</cfif>>#descrip#
 </cfloop>
 </cfoutput>
</select></td></tr> --->


<!--- need to modify to database lookup! --->
<cfif session.fy LT 2009>
<tr><td colspan="2"><a name="lwpcs"></a>Level at which policy change sought<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<select name="levelChangeSought" onchange="presubmit('lwpcs');">
	<option value="">
	<option value="1" <cfif isDefined("form.levelChangeSought") and form.levelChangeSought EQ "1"> selected</cfif>>local - town
	<option value="2" <cfif isDefined("form.levelChangeSought") and form.levelChangeSought EQ "2"> selected</cfif>>local - county
	<option value="3" <cfif isDefined("form.levelChangeSought") and form.levelChangeSought EQ "3"> selected</cfif>>entire Partner catchment area
	<option value="4" <cfif isDefined("form.levelChangeSought") and form.levelChangeSought EQ "4"> selected</cfif>>state
	<option value="5" <cfif isDefined("form.levelChangeSought") and form.levelChangeSought EQ "5"> selected</cfif>>national
	<option value="6" <cfif isDefined("form.levelChangeSought") and form.levelChangeSought EQ "6"> selected</cfif>>international
</select></td></tr>
</cfif>

<!--- county Popup --->

<script type="text/javascript">
function setCounty(content){
document.Form1.handleCounty.value = content;
document.Form1.submit();
}
</script>
<input type="hidden" name="handleCounty" value="">
<cfif isDefined("form.levelChangeSought") and (listFind(form.levelChangeSought,"1") OR listFind(form.levelChangeSought,"2"))>
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="catchmentCounties">
	select catchment 
	from contact 
	where userid = '#session.userid#'	
</cfquery>

<!--- Code added to include JSP counties in catchment. Othewise use similar code already executed above --->
<cfif isDefined("form.activityName")>
	<cfset localsname = form.activityName>
<cfelseif isDefined("form.colStrat")>
	<cfset localsname = form.colStrat>
</cfif>

<cfif isDefined("localsname") and left(localsname,1) EQ "*">
<cfquery datasource="#application.DataSource#" 	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="seljointpartners">
	select userid 
from shareduseractivities
where year2= #session.rptyr#
and activity = '#localsname#'
	
</cfquery>

<cfquery datasource="#application.DataSource#" 	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="countyheadache">
select catchment 
from contact
where userid in (#quotedvaluelist(seljointpartners.userid)#)
</cfquery>

<cfquery datasource="#application.DataSource#"	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="selCounties">
select countyName, FIPS from counties 
where fips in <cfif isDefined("countyheadache.catchment") and countyheadache.catchment NEQ "">(#valuelist(countyheadache.catchment)#)<cfelse>(0)</cfif>

</cfquery>
</cfif>
<!--- end addition for JSP --->

<tr>
	<td width="120" valign="top" nowrap>Select County(ies):</td><td align="left" valign="top">
	<cfselect name="impactedCounties" multiple class="mlti">
		<cfoutput>
			<cfloop query="selCounties">
				<option value="#FIPS#" <cfif isDefined("form.impactedCounties") and listFind(form.impactedcounties,FIPS)> selected</cfif>>#countyName#
			</cfloop> 			
		</cfoutput>
		</cfselect>
	</td>
</tr>
</cfif>



  <!---  <cfif isDefined("form.strategy") and (form.strategy EQ "1" ) > --->
  <tr>
  	<td colspan="2">
		<table class="box" cellspacing="0">
		<tr>
       <td valign="top"><a name="PTG"></a>
	   <cfif session.fy GT 2006 or session.fy LT 1920>Type of </cfif>Target&nbsp;&nbsp;</td>
       <td valign="top"><select name="target1" <cfif isDefined("form.strategy") and (form.strategy EQ "8" or form.strategy EQ "9")> onchange="alterTarget('PTG');"</cfif> <cfif session.fy LT "2008" and form.strategy NEQ "1">multiple class="mlti" size="3"</cfif>>
	   <cfif isDefined("targetQ")>
	   <!--- <option value="">- Please select a Target --->
	   	<cfoutput query="targetQ" group="head">
		    <optgroup id="#head#" label="#head#">
        		<cfoutput>
	   				<option value="#targetNum#" <cfif isDefined("form.target1") AND listFind(form.target1, targetNum)> selected </cfif>>#target#
	   			</cfoutput> 
			</optgroup>
  		 </cfoutput> 
		<cfelse>
			<option value="0"> Please select a Focus Area
		</cfif>
</select></td>
   </tr>
   </table>
	</td>
  </tr> 
  
  <cfinclude template="userTarget.cfm">
   <!--- </cfif> --->
   
   
<!--- </cfif> --->
<!--- end county popup --->

 
 
 
 
 
 
 
<cfelseif isDefined("form.strategy") and form.strategy EQ "2">
  <!--- PAID MEDIA --->
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Q_themes">
	select id, descr
	from lu_PM_theme
	where year2=#session.fy#
	
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Q_medium">
	select id, descr
	from lu_PM_media
	where year2=#session.fy#
</cfquery>

 <tr>
 	<td>
		<table class="box">
			<!--- <tr>
				<td>Theme of media campaign</td>
				<td>
				<cfoutput>
				<select name="PM_theme">
				<cfloop query="Q_themes">
					<option value="#id#"<cfif isDefined("form.PM_theme") and form.PM_theme EQ "#id#"> selected</cfif>>#descr#
				</cfloop>
				</select>
				</cfoutput>
				</td>
			</tr> --->
			<input type="Hidden" name="PM_theme" value="0"
			<tr>
				<td>What medium are you planning to use?</td>
				<td>
				<cfoutput>
				<select name="PM_media" multiple size="4" class="mlti">
				<cfloop query="Q_medium">
					<option value="#id#"<cfif isDefined("form.PM_media") and ListContains(form.PM_media,id)> selected</cfif>>#descr#
				</cfloop>
				</select>
				</cfoutput>
				</td>
			</tr>
			<tr>
				<td>Will this campaign have a direct reference to NYS Quitline?</td>
				<td>
				<input type="radio" name="QL_ref" value="1" <cfif isDefined("form.QL_ref") and form.QL_ref EQ 1> checked</cfif>>Yes&nbsp;&nbsp;&nbsp;
				<input type="radio" name="QL_ref" value="0"<cfif (isDefined("form.QL_ref") and form.QL_ref EQ 0) OR NOT isDefined("form.QL_ref")> checked</cfif>>No
				</td>
			</tr>
			
			<cfif session.fy LT 2009>
			<tr>
				<td>Is this media being run with TCP program support funding?</td>
				<td>
				<input type="radio" name="TCP_fun" value="1" <cfif isDefined("form.TCP_fun") and form.TCP_fun EQ 1> checked</cfif>>Yes&nbsp;&nbsp;&nbsp;
				<input type="radio" name="TCP_fun" value="0"<cfif (isDefined("form.TCP_fun") and form.TCP_fun NEQ 1) OR NOT isDefined("form.TCP_fun")> checked</cfif>>No
				</td>
			</tr>
			</cfif>
		</table>
	</td>
 </tr>
<tr><td colspan="2">
 <cfinclude template="camptarget.cfm">
 </td></tr>
 
<cfelseif isDefined("form.strategy") and form.strategy EQ "4">
 	<!--- <cfinclude template="targetorg.cfm"> --->
	<tr><td colspan="2">
 <cfinclude template="camptarget.cfm">
 </td></tr>
 
 <!--- COMMUNITY FORUM/EVENT none applicable --->
 
<cfelseif isDefined("form.strategy") and form.strategy EQ "5">
 <!--- MONITORING OR ASSESSMENT --->

 <!--- Select the states and area codes. --->


<!--- Select all the area codes. --->
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="GetFoci">
SELECT seq as focusNum, Foci
  FROM monitorFocus
  WHERE year2=#session.rptyr#
 </cfquery>
 <cfif isDefined("form.target2" )and form.target2 NEQ "">
 <cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="GetFoci2">
SELECT seq as focusNum, Foci
  FROM monitorFocus
  where keyNum = #form.target2#
  and year2=#session.rptyr#
 </cfquery>
</cfif>




 <cfinclude template="targetorg.cfm">
 
<cfif session.fy LT 2009>
<tr>
   <td>Focus of Monitoring / Assessment</td></tr><tr><td>
      <cfselect name="Foci"  size="5" multiple  class="mlti">
         <!--- <option value="0">Select Focus --->
		 <cfif isDefined("form.target2") and form.target2 NEQ "">
		 <cfoutput query="GetFoci2">
            <option value="#focusNum#" <cfif isDefined("form.Foci") and ListFind(form.Foci, focusNum)> Selected</cfif>>#foci#
         </cfoutput> 
		 <cfelse>
		 <!--- <cfoutput query="GetFoci"> --->
            <option value="0">Select Target Organization
         <!--- </cfoutput> --->
		 </cfif>         
      </cfselect>
   </td>
</tr>



<tr>
<cfoutput>
<td>Primary or secondary data collection<A HREF="javascript:void(0)"onclick="window.open('#application.basename#/dictionary.cfm##pdc','_blank','height=500, width=700,scrollbars=yes')"><img SRC="images/book07.gif"  width="20" height="20" BORDER="0" ALT="Help"></a>&nbsp;&nbsp;&nbsp;<input type="Radio" name="primSec" value="1"<cfif (isDefined("form.primSec") and form.primSec EQ "1") OR (NOT isDefined("form.primSec")) > checked</cfif>>Primary &nbsp;&nbsp;&nbsp;<input type="Radio" name="primSec" value="2"<cfif isDefined("form.primSec") and form.primSec EQ "2"> checked</cfif>  <!--- onclick="setPrimSec('2');" --->>Secondary</td>
</cfoutput>
</tr>  
</cfif>  
 
 
<cfelseif isDefined("form.strategy") and form.strategy EQ "6">
 <!--- SURVEY OF PUBLIC's KAB --->
<tr><td colspan="2">
 <cfinclude template="camptarget.cfm">
 </td></tr> 
 
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="issues">
	
select
descrip, num
from survey_issues
where year2=#session.rptyr#
order by rank

</cfquery>
 <tr valign="top">
	<td valign="top">Issue(s) addressed in Survey:&nbsp;&nbsp;
	</td>
	<td valign="top">
	<cfselect name="issuesAdd" multiple size="13" required="Yes" message="Please select an issue addressed in this survey" class="mlti">
	<cfoutput>
	<cfloop query="issues">
		<option value="#num#" <cfif isDefined("form.issuesAdd") and ListFind(form.issuesAdd, "#num#")> selected</cfif>>#descrip#
	</cfloop>
	</cfoutput>
	</cfselect>
	</td>
</tr> 

<cfelseif isDefined("form.strategy") and form.strategy EQ "7">
 <!--- PROVISION or PROMOTION OF CESSAATION SERVICES --->
<tr><td colspan="2">
 <cfinclude template="camptarget.cfm">
 </td></tr>
 
 
 
<cfelseif isDefined("form.strategy") and (form.strategy EQ "8" OR form.strategy EQ "9")>







<tr>
       <td><a name="PTG"></a>Target Organization Type</td>
</tr>
<tr>
       <td><select name="target1" <cfif isDefined("form.strategy") and (form.strategy EQ "8" or form.strategy EQ "9")> onchange="alterTarget('PTG');"</cfif>>
	   <cfif isDefined("targetQ")>
	   <option value="">- Please select a target
	   	<cfoutput query="targetQ" group="head">
		    <optgroup id="#head#" label="#head#">
        		<cfoutput>
	   				<option value="#targetNum#" <cfif isDefined("form.target1") AND form.target1 EQ "#targetNum#"> selected </cfif>>#target#
	   			</cfoutput> 
			</optgroup>
  		 </cfoutput> 
		<cfelse>
			<option value="0"> Please select a Focus Area
		</cfif>
</select></td>
   </tr>
<cfif isDefined ("form.target1") and form.target1 NEQ "">
 <cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="stratpurp">
select purpnum, descrip	
from cess_purp 
where stratnum = #form.strategy#
and targnum = #form.target1#
and year2=#session.rptyr#
</cfquery>

<!---  <cfinclude template="targetorg.cfm"> --->
<cfif session.fy LT 2009>
<tr><td>Purpose of Strategy:<br>
<cfselect name="purpose" multiple required="Yes" message="Please select a Purpose of Strategy" class="mlti">
<cfoutput><cfloop query="stratpurp">

<option value="#purpnum#" <cfif isDefined("form.purpose") and ListFind(form.purpose,#purpnum#)> selected </cfif>>#descrip#

</cfloop></cfoutput>
</cfselect>
</td>
</tr> 
</cfif> 
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="pol_level">
select num, descrip	
from cess_level 
where year2=#session.rptyr#
order by rank
</cfquery>
<cfif session.fy LT 2009>
<tr><td>Level at which policy, program or practice change sought:</td></tr> 
<tr>
	<td>
		<select name="pollevel">
		<cfoutput>
		<cfloop query="pol_level">
			<option value="#num#" <cfif isDefined("form.pollevel") and form.pollevel EQ #num#> selected </cfif>>#descrip#
		</cfloop>
		</cfoutput>
		</select>
	
</td></tr></cfif></cfif>
<cfinclude template="userTarget.cfm">

<cfelseif  isDefined("form.strategy") and (form.strategy EQ "11")>


<tr>
       <td><a name="PTG"></a>Target Organization Type</td>
</tr>
<tr>
       <td><select name="target1" <cfif isDefined("form.strategy") and (form.strategy EQ "8" or form.strategy EQ "9")> onchange="alterTarget('PTG');"</cfif>>
	   <cfif isDefined("targetQ")>
	  <!---  <option value="">- Please select a target --->
	   	<cfoutput query="targetQ" group="head">
		    <optgroup id="#head#" label="#head#">
        		<cfoutput>
	   				<option value="#targetNum#" <cfif isDefined("form.target1") AND form.target1 EQ "#targetNum#"> selected </cfif>>#target#
	   			</cfoutput> 
			</optgroup>
  		 </cfoutput> 
		<cfelse>
			<option value="0"> Please select a Focus Area
		</cfif>
</select></td>
   </tr>

</cfif> 




</table></td></tr>  
<tr><td colspan="2">
<cfif isDefined("form.levelChangeSought") and (listFind(form.levelChangeSought,"1") OR listFind(form.levelChangeSought,"2"))>

<!--- <tr><td colspan="2"><input type="submit" value="Submit and add new strategy for this goal/objective" onclick="return addStrat();checkcounties();"  style="width:400"></td></tr>
 --->
 <tr><td colspan="2"><input type="submit" value="Submit" onclick="return checkcounties();" ></td></tr>
<cfelse>
<!--- <tr><td colspan="2"><input type="submit" value="Submit and add new strategy for this goal/objective" onclick="addStrat();"  style="width:400"></td></tr>
 --->
 <tr><td colspan="2"><input type="submit" value="Submit" onclick="return process();" ></td></tr>

</cfif>
</cfform>


</table></td></tr>	
</table>
<cfif isDefined("form.levelChangeSought") and (listFind(form.levelChangeSought,"1") OR listFind(form.levelChangeSought,"2"))>
<script language="JavaScript">
function checkcounties(){
var Counter=0;
if(document.Form1.impactedCounties){
for (i=0; i<document.Form1.impactedCounties.length; i++){
      // If an element is selected, increment the counter
      if (document.Form1.impactedCounties[i].selected == true){
         Counter++;
      }
   }
   // If the counter is greater than 3, display an alert message.
   if (Counter <1){
      alert("You must select at least one county!");
      return false;
}
}
process();
}
</script>
</cfif>

<cfif isDefined("form.addCollab") and form.addCollab EQ "add">
<script language="JavaScript">
	pop_window('add_collab.cfm');	
</script>
</cfif>

</body>
</html>
