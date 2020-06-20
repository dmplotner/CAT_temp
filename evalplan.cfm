<cfif session.fy GT 2008>
	<cfinclude template="evalplan_new3.cfm">
<cfelseif session.fy GT 2006>
	<cfinclude template="evalplan_new.cfm">
<cfelse>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
<title>CAT Evaluation Plan</title>

<cfif isDefined("form.oldMethodName") and form.oldMethodName NEQ "" and form.MethodName NEQ form.oldMethodName>
<!--- update evalm --->
<cfquery datasource="#application.DataSource#" 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QchangEvalm">
	update evalM
	set methodname='#htmleditformat(form.methodname)#'
	where methodname='#htmleditformat(form.oldmethodname)#'
	and userid='#session.userid#'
	and year2=#session.fy#
	
</cfquery>
<!--- update Eval_Ind --->
<cfquery datasource="#application.DataSource#" 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QchangInd">
	update Eval_Ind
	set method='#htmleditformat(form.methodname)#'
	where method='#htmleditformat(form.oldmethodname)#'
	and userid='#session.userid#'
	and year2=#session.fy#
</cfquery>
</cfif>



<cfif isDefined("url.method2")>
<cfquery datasource="#application.DataSource#" 
	password="#application.db_password#"   		
	username="#application.db_username#" name="RecordDet">
	select
	methodname,
	ostartdate, oenddate,
	date_planning, date_collecting,
	selectedStrategies,
	evalcomments,
	targetpop2,
	detail_one,
	other_eval,other_eval_txt,other_eval_txt2,
	primary_dc,
	primary_type,
	secondary_type,
	secondary_txt,
	multi_eval,
	multi_eval_num,
	infosource,
	sampletype,
	othersampletype,
	analyzer,
	reporter,
	tsert_approv
	from EvalM
	where 
	userid='#session.userid#'
	and methodname = '#url.method2#'	
	and year2=#session.fy#
</cfquery>




	<cfset form.methodname = '#RecordDet.methodname#'>
	<cfset form.ostartdate =  dateformat(#RecordDet.ostartdate#,'m/d/yyyy')> 
	<cfset form.oenddate =  dateformat(#RecordDet.oenddate#,'m/d/yyyy')>
	<cfset form.date_planning =  '#RecordDet.date_planning#'> 
	<cfset form.date_collecting =  '#RecordDet.date_collecting#'>
	<cfset form.selectedStrategies = '#RecordDet.selectedStrategies#'>
	<cfset form.evalcomments = '#RecordDet.evalcomments#'>
	<cfset form.targetpop2 = '#RecordDet.targetpop2#'>
	<cfset form.detail_one = '#RecordDet.detail_one#'>
	<cfset form.other_eval = '#RecordDet.other_eval#'>
	<cfset form.other_eval_txt = '#RecordDet.other_eval_txt#'>
	<cfset form.other_eval_txt2 = '#RecordDet.other_eval_txt2#'>
	<cfset form.primary_dc = '#RecordDet.primary_dc#'>
	<cfset form.primary_type = '#RecordDet.primary_type#'>
	<cfset form.secondary_type = '#RecordDet.secondary_type#'>
	<cfset form.secondary_txt = '#RecordDet.secondary_txt#'>
	<cfset form.multi_eval = '#RecordDet.multi_eval#'>
	<cfset form.multi_eval_num = '#RecordDet.multi_eval_num#'>
	<cfset form.infosource = '#RecordDet.infosource#'>
	<cfset form.sampletype = '#RecordDet.sampletype#'>
	<cfset form.othersampletype = '#RecordDet.othersampletype#'>
	<cfset form.analyzer = '#RecordDet.analyzer#'>
	<cfset form.reporter = '#RecordDet.reporter#'>
	<cfset form.tsert_approv = '#RecordDet.tsert_approv#'>
	

<!--- 
<cfset form.selectedStrategies = '#RecordDet.strat#'>
<cfset form.name = '#RecordDet.descrip#'>
<cfset form.ostartdate = dateformat(#RecordDet.stdate#,'m/d/yyyy')>
<cfset form.oenddate = dateformat(#RecordDet.enddate#, 'm/d/yyyy')>
<cfset form.question = '#RecordDet.evalQ#'>
<cfset form.evidence = '#RecordDet.evid#'>
<cfset form.methodname = '#url.method#'>
<cfset form.primsec = '#RecordDet.primsec#'>
<cfif form.primsec EQ ''>
	<cfset form.primsec=1>
</cfif>
<cfset form.analyzer = '#RecordDet.who_analyze#'>
<cfset form.reporter = '#RecordDet.who_prepare#'>
<cfset form.disseminate = '#RecordDet.how_dissem#'>
<cfset form.disseminated = '#RecordDet.who_dissem#'>
<cfif form.primsec EQ "1">
<cfset form.method = '#RecordDet.coll_meth#'>
<cfset form.tool = '#RecordDet.tool_name#'>
<cfset form.targetpop = '#RecordDet.target_pop#'>
<cfset form.targetorg = '#RecordDet.target_org#'>
<cfset form.selectmethod = '#RecordDet.select_meth#'>
<cfset form.startdate = dateformat(#RecordDet.coll_stDate#, 'm/d/yyyy')>
<cfset form.enddate = dateformat(#RecordDet.coll_endDate#, 'm/d/yyyy')>
<cfset form.num = '#RecordDet.add_num#'>
</cfif>
<cfset form.sources = '#RecordDet.data_source#'>

<cfset form.Adate = dateformat(#RecordDet.approvdate#, 'm/d/yyyy')>
<cfset form.revApproval = '#RecordDet.revApproval#'>

--->
</cfif> 
<cfquery datasource="#application.DataSource#" 
	password="#application.db_password#"  		
	username="#application.db_username#" name="qMeth">
select num, descr, rank 
from eval_meth
where year2=#session.fy#
order by rank	
</cfquery>

 <cfquery datasource="#application.DataSource#" 
	password="#application.db_password#" 	
	username="#application.db_username#" name="GetTarget">
SELECT keyNum as targetNum, target
  FROM monitorTarget 
  where year2=#session.fy#
 order by 1
 
</cfquery>

<cfif isDefined("form.indicator")>
<cfif form.indicator EQ "Add">
<cfquery datasource="#application.DataSource#" 
	password="#application.db_password#" 	
	username="#application.db_username#" name="Add_Indic">
	
insert into Eval_Ind
(method, userid, year2, question, ind)
values
('#htmleditformat(form.methodname)#', '#session.userid#', #session.fy#, '#form.indQ#', '#form.indind#')	
</cfquery>

<cfelseif form.indicator EQ "Del" and isDefined("form.delInd")>
<cfquery datasource="#application.DataSource#" 
	password="#application.db_password#" 	
	username="#application.db_username#" name="Del_Indic">
	Delete from Eval_ind
	where seq in (#form.delInd#)	
</cfquery>
	
</cfif>



</cfif>


<cfif isDefined("form.selectedStrategies")>

<CFSET strats = "'" & replace(replace(form.selectedStrategies,"'","''","ALL"),",","','","ALL") & "'">

 <cfquery datasource="#application.DataSource#" 
	password="#application.db_password#" 	
	username="#application.db_username#" name="GetStratDet">
	select u.goal, u.objective, u.outcome, u.targetgroup, u.strategy, u.target2, u.activity, 
	g.program, o.objective as obj
	from useractivities as u, program as g, objectives as o
	where u.pk in (#PreserveSingleQuotes(strats)#)
	and g.year2=#session.fy#
	and o.year2=#session.fy#
	and g.prognum=u.goal
	and o.id=u.objective
	and (u.del is Null  or u.del !='Y')
	
	order by 1,2	
</cfquery>






<cfquery datasource="#application.DataSource#" 
	password="#application.db_password#"  		
	username="#application.db_username#" name="GetStratDetSimple2">

	SELECT u.goal, u.objective, G.program , o.objective as obj
	FROM USERACTIVITIES AS U, program as g, objectives as o 
	WHERE u.pk in (#PreserveSingleQuotes(strats)#)
	and u.goal=g.prognum
	and g.year2=#session.fy#
	and o.year2=#session.fy#
	and u.objective=o.id
	and (u.del is Null  or u.del !='Y')
	order by 1,2	
</cfquery>

<cfquery datasource="#application.DataSource#" 
	password="#application.db_password#"  		
	username="#application.db_username#" name="GetStratDesc">

	SELECT u.activity, u.activityname
	FROM USERACTIVITIES AS U
	WHERE u.pk in (#PreserveSingleQuotes(strats)#)
	and (u.del is Null  or u.del !='Y')
	order by 1
</cfquery>

</cfif>
<cfif isDefined("form.methodName")>
<cfquery datasource="#application.DataSource#" 
	password="#application.db_password#" 	
	username="#application.db_username#" name="GetIndQ">
	select 
	method as methodname, question, ind, seq
	from eval_ind
	where userid='#session.userid#'
	and method = '#form.methodname#'	
	and year2=#session.fy#
</cfquery>
</cfif>

<cfinclude template="catstruct.cfm">

<script language="JavaScript">

function flipeval(){
for(var k = 0; k < document.f1.selectedStrategies.length; k++){ 
document.f1.selectedStrategies[k].selected = true;
}
return true;
alert('check this out');
}

function checkPageDates(){
if (ValidateDate(document.f1.Ostartdate.value)==false){return false;};
if (ValidateDate(document.f1.Ostartdate.value)==false){return false;};
if (ValidateCompareDate(document.f1.Ostartdate.value, document.f1.Oenddate.value)==false){return false;};
if (typeof(document.f1.startdate) != "undefined"){
if (ValidateDate(document.f1.startdate.value)==false){return false;};
if (ValidateDate(document.f1.enddate.value)==false){return false;};
if (ValidateCompareDate(document.f1.startdate.value, document.f1.enddate.value)==false){return false;};
}
if (typeof(document.f1.adate) != "undefined" && document.f1.adate!="" ){
if (ValidateDate(document.f1.adate.value)==false){return false;};
}
<!--- if (document.f1.targetorg.selectedIndex==-1){
alert('Please select a target organization');
return false;
}
 --->

 flipeval();
}



function process(){
document.f1.action="prc_evalplan.cfm?<cfoutput>#session.urltoken#</cfoutput>";
flipeval();
document.f1.submit();
}

function questionIndic(adddel){
if (document.f1.methodName.value.length <1){
alert('Please enter a method name prior to adding questions or indicators.');
return false;
}
document.f1.indicator.value=adddel;
document.f1.action="evalplan.cfm?<cfoutput>#session.urltoken#</cfoutput>";
flipeval();
document.f1.submit();
}

function AddStrat(){
document.f1.action="evalplan.cfm?<cfoutput>#session.urltoken#</cfoutput>";
flipeval();
document.f1.submit();
}

function  primSec(type){

document.f1.action="evalplan.cfm?<cfoutput>#session.urltoken#</cfoutput>";
flipeval();
document.f1.submit();
}

function toggle(){
document.f1.action="evalplan.cfm?<cfoutput>#session.urltoken#</cfoutput>";
flipeval();
document.f1.submit();
}

</script>


<div class="box">
<cfform name="f1" action="prc_evalplan.cfm?#session.urltoken#"> 
<!--- <cfform name="f1" action="prcevalplanDet.cfm?#session.urltoken#">--->
<input name="indicator" type="hidden" value="">
<cfif isDefined("form.methodName") and form.methodName NEQ "">
	<input name="oldMethodName" type="hidden" value="<cfoutput>#form.methodName#</cfoutput>">
<cfelse>
	<input name="oldMethodName" type="hidden" value="">
</cfif>
<input name="oldMethodName" type="hidden" value="">
<cfif isDefined("url.method2")><cfoutput><input type="hidden" name="method2" value="#url.method2#"></cfoutput></cfif>
<div align="center"><h3>Description of Evaluation Method</h3></div>
<div align="center"><strong>(One or more methods can make up your Evaluation plan)</strong></div>
<div align="center"><strong>(Adapted from Evaluation Planning Matrix)</strong></div>
<br>
<script language="JavaScript">
function sortSelect(selObj) {

var opts = selObj.getElementsByTagName('option');
var listVals = new Array();

for(var i = 0; i < opts.length; i++) 
listVals.push(opts.item(i).text+"~"+opts.item(i).value+"~"+opts.item(i).selected);

listVals.sort();

for(var i = 0; i < listVals.length; i++) {
selObj.options[i].text = String(listVals[i]).split("~")[0];
selObj.options[i].value = String(listVals[i]).split("~")[1];
selObj.options[i].selected = (String(listVals[i]).split("~")[2]=="true"?1:0);
}

} 
<!-- This script and many more are available free online at -->

<!-- The JavaScript Source!! http://javascript.internet.com -->

<!-- Original:  Fred P -->

<!-- Begin

// Compare two options within a list by VALUES

function compareOptionValues(a, b) 

{ 

  // Radix 10: for numeric values

  // Radix 36: for alphanumeric values

  var sA = parseInt( a.value, 36 );  

  var sB = parseInt( b.value, 36 );  

  return sA - sB;

}



// Compare two options within a list by TEXT

function compareOptionText(a, b) 

{ 

  // Radix 10: for numeric values

  // Radix 36: for alphanumeric values

  var sA = parseInt( a.text, 36 );  

  var sB = parseInt( b.text, 36 );  

  return sA - sB;

}



// Dual list move function

function moveDualList( srcList, destList, moveAll ) 

{

  // Do nothing if nothing is selected

  if (  ( srcList.selectedIndex == -1 ) && ( moveAll == false )   )

  {

    return;

  }



  newDestList = new Array( destList.options.length );



  var len = 0;



  for( len = 0; len < destList.options.length; len++ ) 

  {

    if ( destList.options[ len ] != null )

    {

      newDestList[ len ] = new Option( destList.options[ len ].text, destList.options[ len ].value, destList.options[ len ].defaultSelected, destList.options[ len ].selected );

    }

  }



  for( var i = 0; i < srcList.options.length; i++ ) 

  { 

    if ( srcList.options[i] != null && ( srcList.options[i].selected == true || moveAll ) )

    {

       // Statements to perform if option is selected



       // Incorporate into new list

       newDestList[ len ] = new Option( srcList.options[i].text, srcList.options[i].value, srcList.options[i].defaultSelected, srcList.options[i].selected );

       len++;

    }

  }



  // Sort out the new destination list

  newDestList.sort( compareOptionValues );   // BY VALUES

  //newDestList.sort( compareOptionText );   // BY TEXT


newDestList.sort();
  // Populate the destination with the items from the new array

  for ( var j = 0; j < newDestList.length; j++ ) 

  {

    if ( newDestList[ j ] != null )

    {

      destList.options[ j ] = newDestList[ j ];

    }

  }



  // Erase source list selected elements

  for( var i = srcList.options.length - 1; i >= 0; i-- ) 

  { 

    if ( srcList.options[i] != null && ( srcList.options[i].selected == true || moveAll ) )

    {

       // Erase Source

       //srcList.options[i].value = "";

       //srcList.options[i].text  = "";

       srcList.options[i]       = null;

    }

  }


sortSelect(srcList);
sortSelect(destList);

} // End of moveDualList()

//  End -->

</script> 
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QcollabStrat">
select stratName, partners
from sharedActivities as s, useractivities as u
where u.activity=s.stratName
and u.strategy != 10
and u.year2=s.year2

order by 1
</cfquery>

<cfquery datasource="#Application.DataSource#" 
	password="#Application.db_password#" 		
	username="#Application.db_username#" name="strategies">
	
	select Rtrim(activity) as activity, pk as stratNum
	from useractivities
	where 
	(userid = '#session.userid#'
	OR
	activity in (<cfloop query="QcollabStrat">
			<cfif ListFind(partners, session.user_pk)>
				'#htmlEditFormat(stratname)#', 
			</cfif>
			</cfloop> 'NONE')
	)
			
	and year2=#session.fy#
	and (del is null or del!='Y')
	and goal between 1 and 4
	and strategy not in (5,6)
	<cfoutput><cfif isDefined("form.selectedstrategies") and (form.selectedstrategies NEQ "")>and  pk NOT IN (#form.selectedstrategies#)</cfif></cfoutput>
	order by 1
	
</cfquery>


<table align="center" class="box" >
<tr>
<td colspan="2" align="center">
Please provide a unique name for the evaluation method that will be used to collect the information to determine community impact (e.g. POP ad observation, policy maker survey, faculty interviews, policy analysis/document review):
</td>
</tr>
<tr>
	<!--- <td>What is the name you've assigned for this evaluation method?</td> --->
	<td colspan="2" align="center">
	<cfif isDefined("form.methodName")><cfinput type="Text" name="methodName" size="60" required="Yes"  message="Please enter a unique evaluation method name." value="#form.methodName#">
	<cfelse>
	<cfinput type="Text" name="methodName" size="60" required="yes" message="Please enter a unique evaluation method name.">
	</cfif>
	</td>
</tr>
<tr>
	<td colspan="2" align="center">Please record the expected timeframe for the entire evaluation (preliminary planning, data collection, and reporting)</td>
</tr>
<tr>
	<!--- <td>What is the overall timeframe for the entire evaluation project<br>
	(planning, data collection, and reporting):</td> --->
	<td colspan="2" align="center">
		Start Date: 
		<cfif isdefined("form.Ostartdate") and form.Ostartdate NEQ "1/1/1900">
			<cfinput type="text" name="Ostartdate"  value="#form.Ostartdate#" validate="date" message="Please enter all dates in m/d/yyyy format">
		<cfelse>
			<cfinput type="text" name="Ostartdate">
		</cfif>
		&nbsp;&nbsp;&nbsp;&nbsp;End Date: 
		<cfif isdefined("form.Oenddate") and form.Oenddate NEQ "1/1/1900">
				<cfinput type="text" name="Oenddate" value="#form.Oenddate#" validate="date" message="Please enter all dates in m/d/yyyy format">
		<cfelse>
				<cfinput type="text" name="Oenddate" validate="date" message="Please enter all dates in m/d/yyyy format">
		</cfif>
	</td>

</tr>
<tr>
	<td colspan="2" align="center">
	When do you expect to begin formal planning and preparation for the evaluation?
	</td>
</tr>
<tr>
	<td colspan="2" align="center">
	M/YYYY 
	<cfif isdefined("form.date_planning") and form.date_planning NEQ "1/1/1900">
			<cfinput type="text" name="date_planning"  value="#form.date_planning#" >
		<cfelse>
			<cfinput type="text" name="date_planning" >
		</cfif>
	</td>
</tr>

<tr>
	<td colspan="2" align="center">
	When do you expect to begin collecting the information for the evaluation?
	</td>
</tr>
<tr>
	<td colspan="2" align="center">
	M/YYYY 
	<cfif isdefined("form.date_collecting") and form.date_collecting NEQ "1/1/1900">
			<cfinput type="text" name="date_collecting"  value="#form.date_collecting#" >
		<cfelse>
			<cfinput type="text" name="date_collecting" >
		</cfif>
	</td>
</tr>
</table>



<table class="box">
<tr>
	<td align="center"><h3>Intervention Details</h3> </td>
</tr>
<tr>
	<td colspan="2" align="center"><strong>In this section you will provide details about the work plan strategy or strategies that you have chosen to evaluate for impact</strong></td>
</tr>

<tr><td colspan="2">
<table align="left" class="box">
<tr><th colspan="3" align="left">What strategy or strategies will be evaluated by this method?<br>(select all that apply)</th></tr>
<tr>
<td colspan="3">
Note:  Impact evaluation is used to assess community effects of a program intervention
<A HREF="javascript:void(0)" <cfoutput>onclick="window.open('#application.basename#/dictionary.cfm##interv','_blank','height=500, width=700,scrollbars=yes')"></cfoutput><img SRC="images/book07.gif"  width="20" height="20" BORDER="0" ALT="Help"></a>
. Therefore, annual plan strategies entered for Goals 5 and 6, as well as any strategy classified as either Monitoring or Assessment or Survey, will not appear in the List of Strategies for potential evaluation selection.  Monitoring/ Assessment and Survey strategies might be used as evaluation methods, but would not need to be evaluated themselves, since they are not interventions.
<br>&nbsp;<br>&nbsp;
</td>
</tr>

<tr>
<td align="right">
Annual Plan Strategies: <br><select name="allstrategies" multiple size="5" class="mlti">
<cfoutput>
<cfloop query="strategies">
<option value="#stratNum#">#activity#

</cfloop> 
</cfoutput>
</select>
</td>
<td align="center"><NOBR> 
    <input type="button" style="width:90" onclick="moveDualList( this.form.allstrategies,  this.form.selectedStrategies, false );flipeval();AddStrat();"    name="Add     >>"  value="Add       >>" class="AddButton">     <BR>



    <NOBR>   
	<input type="button" style="width:90" onclick="moveDualList( this.form.selectedStrategies, this.form.allstrategies,  false );flipeval();AddStrat();"    name="<<  Remove"  value="<<   Remove" class="DelButton" >     <BR>



    <!--- <NOBR> 
	    <input type="button" style="width:90" onclick="moveDualList( this.form.allcounties,  this.form.catchment, true  )"    name="Add All >>"  value="Add All >>">     <BR>



    <NOBR>
    <input type="button" style="width:90" onclick="moveDualList( this.form.catchment, this.form.allcounties,  true  )"     name="<<Remove All "  value="<<Remove All ">     <BR>

    </NOBR> --->

  </td>

<td align="left">



Strategies Evaluated using this method: 
<br><select name="selectedStrategies" multiple size="5" class="mlti">
<cfoutput>
<cfif isDefined("form.selectedStrategies")>
<cfloop list="#form.selectedStrategies#" index="strat">

<cfquery datasource="#Application.DataSource#" 
password="#Application.db_password#"   		
	username="#Application.db_username#" name="strategiesback">
	
	select Rtrim(activity) as activity, pk as stratNum
	from useractivities
	where pk=#strat#
	and year2=#session.fy#
	order by 1
	
</cfquery>


<option value="#strat#">#strategiesback.activity#
</cfloop> 
</cfif>
</cfoutput>
</select>
</td></tr> 
</table>
</td></tr>




<tr>
<td>
<table align="left" class="box" width="100%">



<cfif isDefined("GetStratDetSimple2")>

<tr>
	<th align="left" colspan="2">Selected Strategy Descriptions</th>
</tr>
<cfoutput query="GetStratDesc" >
<tr>
	<td width="300" valign="top">#activity#</td>
	<td valign="top">#activityname#</td>
</tr>
<tr><td colspan="2">&nbsp;</td></tr>
</cfoutput>
<tr><td colspan="2"></td></tr>
<!--- <tr><td>
<table align="left" class="box" width="100%"> --->
<tr>
	<th align="left" colspan="2">Workplan Goals and Objectives</th>
</tr>
<cfoutput query="GetStratDetSimple2" group="program">
<tr>
	<td colspan="2">#program#</td>
</tr>
<cfoutput>
<tr>
	<td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#obj#</td>
</tr>
</cfoutput>
</cfoutput>
<!--- </table>
</td></tr>

<tr><td>
<table align="left" class="box" width="100%"> --->
<tr>
	<th align="left" colspan="2">Expected SMART Outcomes<A HREF="javascript:void(0)" <cfoutput>onclick="window.open('#application.basename#/dictionary.cfm##smart','_blank','height=500, width=700,scrollbars=yes')"></cfoutput><img SRC="images/book07.gif"  width="20" height="20" BORDER="0" ALT="Help"></a>
	</th>
</tr>
<cfoutput>
<cfloop query="GetStratDet">
<tr>
	<td colspan="2">#outcome#</td>
</tr>
</cfloop>
</cfoutput>
<!--- </table>
<br>
</td></tr> --->
</cfif>
<tr><td>&nbsp;</td></tr>
<tr>
	<td colspan="2">
	<strong>REMINDER: In order to edit SMART Outcomes, go to the Annual Plans section and EDIT the Strategy for that Outcome. 
	Make desired changes to the Outcome, save changes by clicking SUBMIT, and then close and re-open this evaluation method.</strong>
	</td>
</tr>
<tr><td colspan="2">&nbsp;</td></tr>
</table>
</td>
</tr>
<tr>
	<td>
	<table align="left" class="box">
<tr>
	<td width="40%">If needed, further describe the expected SMART Outcomes and community impact(s) 
	that the intervention is expected to produce and that the evaluation will assess. Remember, a
	community impact can constitute a clear and discrete action outcome (i.e. policy adoption)</td>

	<td width="60%"><textarea name="EvalComments" cols="60" rows="5"><cfif isDefined("form.EvalComments")><cfoutput>#form.EvalComments#</cfoutput></cfif></textarea></td>
</tr>	
	</table>
	</td>
</tr>


<cfif isDefined("GetStratDet")>
	<cfset targetArray=ArrayNew(1)>
	<cfset temp=ArrayClear(targetArray)>
</cfif>
<cfoutput>
<cfif isDefined("GetStratDet")>
<cfloop query="GetStratDet">


<cfif strategy EQ 2 or strategy EQ 4 or strategy EQ 6 or strategy EQ 7>
<cfquery datasource="#Application.DataSource#" password="#Application.db_password#" 
username="#Application.db_username#" name="strategTargA">
	select target  as target
	from strat_campaignTarget
	where (userid='#session.userid#' 
	or userid='shared') 
	and  activity='#activity#'
	and (del is null or del !=1)
	and year2=#session.fy#
</cfquery>


<cfloop query="strategTargA">
<cfquery datasource="#application.DataSource#" 
	password="#application.db_password#"  		
	username="#application.db_username#" name="strategTarg">
	select descrip as target
	from campaignTarget
	where 
	num in(#target#)
	and year2=#session.fy#
</cfquery>


<cfif isDefined("strategTarg")>
<cfloop query="strategTarg">
<!--- <cfoutput><h3>#target#<br></h3></cfoutput> --->
<cfscript>

  ArrayAppend(targetArray, "#valuelist(strategTarg.target,', ')#");
</cfscript>
</cfloop>
</cfif>
</cfloop>

<cfelseif strategy EQ 5 and isDefined("target2") and target2 NEQ "">
<cfquery datasource="#Application.DataSource#" 
	password="#Application.db_password#" 	
	username="#Application.db_username#" name="strategTarg">
	select target  as target
	from monitorTarget
	where keyNum=#target2#
	and year2=#session.fy#
</cfquery>
<cfif isDefined("strategTarg")>
<cfloop query="strategTarg">
<!--- <cfoutput><h3>#target#**<br></h3></cfoutput> --->
<cfscript>
  ArrayAppend(targetArray, "#valuelist(strategTarg.target,', ')#");
</cfscript>
</cfloop>
</cfif>

<cfelseif strategy NEQ 10 and isDefined("targetgroup") and targetgroup NEQ "">


<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#" 
	username="#Application.db_username#" name="strategTarg">
	select target as target
	from targets
	where targetNum in (#targetgroup#)
	and strategyNum=#strategy#
	and year2=#session.fy#
</cfquery>

<cfif isDefined("strategTarg")>
<cfloop query="strategTarg">
<!--- <cfoutput><h3>#target#<br>********</h3></cfoutput>---> 
 <!--- ArrayAppend(targetArray, "#valuelist(strategTarg.target,', ')#"); --->
 <cfscript>
 
  ArrayAppend(targetArray, #target#);
</cfscript>
</cfloop>
</cfif>

</cfif>
</cfloop>
</cfif>
</cfoutput>
<cfif isDefined("targetArray")>

<cfoutput> 
<tr><td>
<table align="left" class="box">
<tr>
<TD valign="top">
	<strong>What is the target population
	<A HREF="javascript:void(0)" onclick="window.open('#application.basename#/dictionary.cfm##target','_blank','height=500, width=700,scrollbars=yes')"><img SRC="images/book07.gif"  width="20" height="20" BORDER="0" ALT="Help"></a>&nbsp;that the evaluation will assess?<br>(select all that apply)</strong>
</TD>
<td>
<select name="targetpop2" size="5" multiple class="mlti">
<cfset isSuccessful = ArraySort(targetArray, "textnocase", "desc")>
<cfset arraylength=ArrayLen(targetArray)>
<cfif arraylength GTE 2>
<cfloop from="#arraylength#" to="2" step="-1"index="arraypos">
<cfif targetarray[#arraypos#] EQ targetarray[#arraypos#-1]>
<cfset success=ArrayDeleteAt(targetarray,arraypos)>
</cfif>
</cfloop>
</cfif>
<cfset newlength=ArrayLen(targetArray)>
<cfloop from="1" to="#newlength#" index="arrayps">
 <option value="#replace((targetArray[arrayps]), ",", "~", "all")#" <cfif isDefined("form.targetpop2") and listContains(form.targetpop2,"#replace((targetArray[arrayps]), ",", "~", "all")#")> selected</cfif>>#targetArray[arrayps]#</option> 

<!---  <option value="#targetArray[arrayps]#" <cfif isDefined("form.targetpop2") and listContains(form.targetpop2,"#replace((targetArray[arrayps]), ",", "~", "all")#")> selected</cfif>>#targetArray[arrayps]#</option> 
 --->
 </cfloop>
</select> 
</td>
</tr>
</table>
</td></tr>
</cfoutput>
</cfif>








<tr>
<td>
<table class="box">
<tr><td align="center"><h3>Evaluation Details</h3></td></tr>
<tr>
	<td align="center"><font size="+1">In this section you will provide details about the evaluation questions, approaches, and methods</font></td>
</tr>

<tr>
<td colspan="2">
<table class="box" align="left" width="400">
<tr><th colspan="3"  align="left">Evaluation Question(s) and related Indicator(s)<A HREF="javascript:void(0)" <cfoutput>onclick="window.open('#application.basename#/dictionary.cfm##ind','_blank','height=500, width=700,scrollbars=yes')"</cfoutput>><img SRC="images/book07.gif"  width="20" height="20" BORDER="0" ALT="Help"></a>
<br>
Please enter one evaluation question and corresponding indicator at a time.<br>
If there is more than one indicator for a particular evaluation question, enter that same evaluation question again with the additional indicator.
</th></tr>
<tr>
<td width="60">
Evaluation question<br><input type="text" name="indQ" size="60" >
</td>
<td width="60">
Indicator<br><input type="text" name="indInd" size="60">
</td>

</tr>
<tr>
<td><button onClick="questionIndic('add');" class="AddButton">Add</button></td>
</tr>
<cfif isDefined("GetIndQ") and GetIndQ.recordcount GT 0>
<cfoutput><cfloop query="GetIndQ">
<tr bgcolor="silver">
<td>#question#</td>
<td>#Ind#</td>
<td><input type="checkbox" name="delInd" value="#seq#">Delete?</td>
</tr>
</cfloop>
<tr>
<td><button onClick="questionIndic('del');" class="DelButton">Delete</button></td>
</tr>
</cfoutput>
</cfif>
</table>
</td></tr>

<tr>
<td>
<table class="box" align="left">
<tr>
	<th colspan="3" align="left">Evaluation Approach<A HREF="javascript:void(0)" <cfoutput>onclick="window.open('#application.basename#/dictionary.cfm##evap','_blank','height=500, width=700,scrollbars=yes')"</cfoutput>><img SRC="images/book07.gif"  width="20" height="20" BORDER="0" ALT="Help"></a></th>
</tr>
<tr>
	<td align="left" colspan="3">(Please choose only one)</td>
</tr>

<tr>
	<td colspan="3">
	There are several different approaches or designs that can be used to evaluate whether or not an intervention (one or more work plan strategies) has produced an impact. Please select the option that most closely describes your evaluation approach. Please note that there is room to describe an alternative approach not listed.
	</td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr><td>&nbsp;</td></tr>
<tr>
	<td><input type="radio" name="detail_one" value="1"  <cfif isDefined ("form.detail_one") and form.detail_one EQ "1"> checked</cfif>> 
	</td>
	<td colspan="2">Will you be collecting information from one group of people, places, or events before and after an intervention to determine its impact?
	</td>
</tr>

<tr>
	<td >&nbsp;</td>
	<td>
	Example: Observe tobacco retailers for external advertising before and after providing educational information to the store managers. The same stores are observed two or more times <i><font color="#000000">(Pre/Post - Single Group)</font></i>
	</td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr>
	<td valign="top"><input type="radio" name="detail_one" value="2"  <cfif isDefined ("form.detail_one") and form.detail_one EQ "2"> checked</cfif>>
	</td>
	<td colspan="2">Will you be collecting information from two different groups of people, 
	places, or events before and after an intervention to determine its impact?
	</td>
</tr>

<tr>
	<td >&nbsp;</td>
	<td>
	Example: Conduct a survey with 12th grade students this year and a new set of 12th grade students 
	next year to determine of they are aware of a change in school policies regarding tobacco 
	free buildings, grounds, and events <i><font color="#000000">(Pre/Post - Cross Sectional)</font></i></td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr>
	<td valign="top"><input type="radio" name="detail_one" value="3" <cfif isDefined("form.detail_one") and form.detail_one EQ "3"> checked</cfif>>
	</td>
	<td colspan="2">Will you be identifying and demonstrating the results of a specific action/key outcome that the evaluation will assess?
	</td>
</tr>

<tr>
	<td >&nbsp;</td>
	<td>
	Example: An organizer (e.g. PTA, school board, local business) takes an action that is supportive of your efforts such as adopting a voluntary CIAA expansion policy or sends smoke free movie support letters to the MPAA <i><font color="#000000">(Discrete Outcome)</font></i></td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr>
	<td valign="top"><input type="radio" name="detail_one" value="4"  <cfif isDefined ("form.detail_one") and form.detail_one EQ "4"> checked</cfif>> 
	</td>
	<td colspan="2">Will you be collecting information from two different groups of people, places, or events before and after an intervention where one group specifically received an intervention and the other group did not (i.e., Do you have a control or comparison group?)
	</td>
</tr>

<tr>
	<td>&nbsp;</td>
	<td>
	Example: A media campaign promoting cessation is conducted in one community, but not in a similar neighboring community. 
	A survey is conducted with residents in each community both before and after the intervention to determine if there were 
	changes in cessation behavior as a result of the media campaign
 <i><font color="#000000">(Control Group)</font></i></td>
</tr>




<tr><td>&nbsp;</td></tr>
<tr>
	<td valign="top"><input type="radio" name="detail_one" value="5"  <cfif isDefined ("form.detail_one") and form.detail_one EQ "5"> checked</cfif>> 
	</td>
	<td colspan="2">
		Will you be conducting some other kind of evaluation? 
	</td>
</tr>
<tr>
	<td></td>
	<td>
	Please describe your alternative approach below:<br>
	<textarea name="other_eval_txt" cols="80" rows="6"><cfif isDefined("form.other_eval_txt")><cfoutput>#form.other_eval_txt#</cfoutput></cfif></textarea>
	</td>
</tr>

<tr><td>&nbsp;</td></tr>
<tr>
	<td colspan="2">
	In your own words, describe how you will conduct this evaluation (similar
to but more detailed than the on-screen Example listed for the Evaluation
Approach). Include details about the timing of the intervention and
evaluation, including whether or not the evaluation will span different
contract years, what the evaluation will consist of, and other specifics
that will allow Evaluation Specialists to understand what you are doing.
</td>
</tr>
<tr>
	<td>&nbsp;</td>
	<td>
	<textarea name="other_eval_txt2" cols="80" rows="6"><cfif isDefined("form.other_eval_txt2")><cfoutput>#form.other_eval_txt2#</cfoutput></cfif></textarea>
	</td>
</tr>

</table></td></tr>
<tr>
<td>
<table class="box">
	<tr>
		<th colspan="4" align="left">Evaluation Method</th>
	</tr>
	<tr>
		<td colspan="4" align="left">Remember that if you are doing multiple types of data collection, you will need to enter a separate evaluation method for each one.</td>
	</tr>
	<tr>
		<td colspan="4">Please indicate how the information for the evaluation will be collected and from what source:</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td width="70" valign="top">
		Will you be:
		</td><td width="5" valign="top">
		<input type="radio" name="primary_dc" value="1" onClick="primSec('prim');" <cfif isDefined ("form.primary_dc") and form.primary_dc EQ "1"> checked</cfif>>&nbsp;
		</td><td colspan="2" valign="top">Collecting new information from surveys, interviews, or observations performed by yourself, 
		your staff, or a subcontractor (referred to as Primary Data Collection<A HREF="javascript:void(0)" <cfoutput>onclick="window.open('#application.basename#/dictionary.cfm##pdc','_blank','height=500, width=700,scrollbars=yes')"</cfoutput>><img SRC="images/book07.gif"  width="20" height="20" BORDER="0" ALT="Help"></a>&nbsp;)?
		</td>
	</tr>
	<cfif isDefined("form.primary_dc") and form.primary_dc EQ "1">
	<tr><td>&nbsp;</td></tr>
	<tr>
		
		<td colspan="4">What is the data collection method that you will use?</td>
	</tr>
	<tr>
		<td colspan="2">&nbsp;</td>
		<td ><input type="radio" name="primary_type" value="1"<cfif isDefined ("form.primary_type") and form.primary_type EQ "1"> checked</cfif>>Survey, face-to-face/hand-out</td>
		<td><input type="radio" name="primary_type" value="2"<cfif isDefined ("form.primary_type") and form.primary_type EQ "2"> checked</cfif>>Observation</td>
	</tr>
	<tr>
		<td colspan="2">&nbsp;</td>
		<td ><input type="radio" name="primary_type" value="3"<cfif isDefined ("form.primary_type") and form.primary_type EQ "3"> checked</cfif>>Survey, mail</td>
		<td><input type="radio" name="primary_type" value="4"<cfif isDefined ("form.primary_type") and form.primary_type EQ "4"> checked</cfif>>Case study</td>
	</tr>
	<tr>
		<td colspan="2">&nbsp;</td>
		<td><input type="radio" name="primary_type" value="5"<cfif isDefined ("form.primary_type") and form.primary_type EQ "5"> checked</cfif>>Survey, telephone</td>
		<td><input type="radio" name="primary_type" value="6"<cfif isDefined ("form.primary_type") and form.primary_type EQ "6"> checked</cfif>>Record/Document review</td>
	</tr>
	<tr>
		<td colspan="2">&nbsp;</td>
		<td><input type="radio" name="primary_type" value="9"<cfif NOT isDefined("form.primary_type") OR (isDefined ("form.primary_type") and form.primary_type EQ "9")> checked</cfif>>Survey, e-mail/web based</td>
		<td><input type="radio" name="primary_type" value="7"<cfif isDefined ("form.primary_type") and form.primary_type EQ "7"> checked</cfif>>Interview</td>
		
	</tr>
	<tr>
		<td colspan="2">&nbsp;</td>
		<td><input type="radio" name="primary_type" value="8"<cfif NOT isDefined("form.primary_type") OR (isDefined ("form.primary_type") and form.primary_type EQ "8")> checked</cfif>>Other</td>
		<td>&nbsp;</td>
	</tr>&
	</cfif>
	<tr><td>&nbsp;</td></tr>
	
	
	
	
	<tr>
		<td>&nbsp;</td>
		<td width="5" valign="top">
		<input type="radio" name="primary_dc" value="0" onClick="primSec('sec');" <cfif isDefined ("form.primary_dc") and form.primary_dc EQ "0"> checked</cfif>>&nbsp;
		</td><td colspan="2" valign="top">Using information that has already been collected by others, such as information 
		from the Quitline, Medicaid claims information, Medicaid recipient NRT usage, etc.
		(referred to as Secondary Data Collection<A HREF="javascript:void(0)" <cfoutput>onclick="window.open('#application.basename#/dictionary.cfm##sdc','_blank','height=500, width=700,scrollbars=yes')"</cfoutput>><img SRC="images/book07.gif"  width="20" height="20" BORDER="0" ALT="Help"></a>&nbsp;)? 
		</td>
	</tr>
	
	
	<tr><td>&nbsp;</td></tr>
	
	
	<tr><td>&nbsp;</td></tr>
	<cfif isDefined("form.primary_dc") and form.primary_dc EQ "0">
	<tr>
		<td>&nbsp;</td>
		<td colspan="3">
		What available information will you use?
		</td>
	</tr>
	<tr>
		<td colspan="2">&nbsp;</td>
		<td><input type="radio" name="secondary_type" value="1"<cfif isDefined ("form.secondary_type") and form.secondary_type EQ "1"> checked</cfif>>NYS Quitline</td>
		<td><input type="radio" name="secondary_type" value="2"<cfif isDefined ("form.secondary_type") and form.secondary_type EQ "2"> checked</cfif>>YTS</td>
	</tr>
	<tr>
		<td colspan="2">&nbsp;</td>
		<td><input type="radio" name="secondary_type" value="3"<cfif isDefined ("form.secondary_type") and form.secondary_type EQ "3"> checked</cfif>>Medicaid</td>
		<td><input type="radio" name="secondary_type" value="4"<cfif isDefined ("form.secondary_type") and form.secondary_type EQ "4"> checked</cfif>>X-BRFSS</td>
	</tr>
	<tr>
		<td colspan="2">&nbsp;</td>
		<td valign="top"><input type="radio" name="secondary_type" value="5"<cfif isDefined ("form.secondary_type") and form.secondary_type EQ "5"> checked</cfif>>ATS</td>
		<td valign="top"><input type="radio" name="secondary_type" value="6"<cfif NOT isDefined("form.secondary_type") or (isDefined ("form.secondary_type") and form.secondary_type EQ "6")> checked</cfif>>Other
		<br>
		If "Other", please describe<br>
		<textarea name="secondary_txt" cols="50" rows="4"><cfif isDefined("form.secondary_txt")><cfoutput>#form.secondary_txt#</cfoutput></cfif></textarea>
		</td>
	</tr>
	
	
	<tr><td>&nbsp;</td></tr>
	</cfif>
	<tr>
	<td colspan="4">
	Will you use this evaluation method more 
	than one time to collect the information needed for the evaluation? 
	(For example, collect information using the same survey before 
	and after an intervention to measure the impact of the intervention)?
	<input type="radio" name="multi_eval" value="1"<cfif isDefined ("form.multi_eval") and form.multi_eval EQ "1"> checked</cfif>> Yes &nbsp;&nbsp;&nbsp;&nbsp;
	<input type="radio" name="multi_eval" value="0"<cfif NOT isDefined("form.multi_eval") OR (isDefined ("form.multi_eval") and form.multi_eval NEQ "1")> checked</cfif>> No	
		
	</td>
	</tr>
	
	
	
	<tr><td>&nbsp;</td></tr>
	
	<tr>
	<td colspan="4">
	If yes, how many more times will you be collecting the information using this method?
	<cfif isDefined("form.multi_eval_num")>
		<cfinput name="multi_eval_num" type="text"  value="#form.multi_eval_num#" validate="integer" message="Please enter an integer value for Number of times you will be using this method" size="5">
	<cfelse>
		<cfinput name="multi_eval_num" type="text" validate="integer" message="Please enter an integer value for Number of times you will be using this method" size="5">
	</cfif>
	</td>
	</tr>
	</table></td></tr>
<tr>
<td>
<table class="box">
	<tr>
		<th align="left">Evaluation Sample<A HREF="javascript:void(0)" <cfoutput>onclick="window.open('#application.basename#/dictionary.cfm##sam','_blank','height=500, width=700,scrollbars=yes')"</cfoutput>><img SRC="images/book07.gif"  width="20" height="20" BORDER="0" ALT="Help"></a>&nbsp;</th>
	</tr>
	<tr>
		<td><strong>In this section, you will describe the source of the information that will be used for the evaluation:</strong></td>
	</tr>
	
	<tr>
		<td>Sources of information can consist of:</td>
	</tr>
	<tr>
		<td>
			<ul>
				<li style="color:#333333;font-family: verdana, helvetica, sans-serif;font-size: 11px;">Primary Sources: People, groups organizations, places, and/or events</li>
				<li style="color:#333333;font-family: verdana, helvetica, sans-serif;font-size: 11px;">Secondary Sources: Quitline, Medicaid, BRFSS Survey Data</li>
				<li style="color:#333333;font-family: verdana, helvetica, sans-serif;font-size: 11px;">Important characteristics such as the significance of locations of people chosen, 
				local political or historical context, past interventions, etc., to help us 
				understand why you have chosen this source of information.</li>
			</ul>
		</td>
	</tr>
	<tr>
		<td>Examples include:</td>
	</tr>
	<tr>
		<td>
			<ul>		
			<li style="color:#333333;font-family: verdana, helvetica, sans-serif;font-size: 11px;">200 parents of high school students from Valley High School, from a list of students obtained from the high school attendance office</li>
			<li style="color:#333333;font-family: verdana, helvetica, sans-serif;font-size: 11px;">20 retailers within 1000 feet of a school in Fairview County, determined with maps and driving directions</li>
			<li style="color:#333333;font-family: verdana, helvetica, sans-serif;font-size: 11px;">Quitline data for June and July for my catchment area.</li>
			</ul>
		</td>
	</tr>
	<tr>
		<td>Please describe your source/who or where you will get the information from:</td>
	</tr>
	<tr>
		<td align="center">
		<textarea name="infosource" cols="80" rows="4"><cfif isDefined("form.infosource")><cfoutput>#form.infosource#</cfoutput></cfif></textarea>
		</td>
	</tr>
	
	<tr><td>&nbsp;</td></tr>
	<tr>
		<td>
		How will you choose the individuals, organizations, places, or events from which you will collect information?
		</td>
	</tr>
	<tr>
		<td>
		<input type="radio" name="sampletype" value="3" <cfif isDefined("form.sampletype") and form.sampletype EQ "3"> checked</cfif>>Convenience<A HREF="javascript:void(0)" <cfoutput>onclick="window.open('#application.basename#/dictionary.cfm##con','_blank','height=500, width=700,scrollbars=yes')"</cfoutput>><img SRC="images/book07.gif"  width="20" height="20" BORDER="0" ALT="Help"></a>&nbsp; sample (e.g., conducting man-on-the-street interviews or conducting surveys among the first 75 people to walk into a meeting or mailing questionnaires to the first 25 people to respond to an ad about participating in study)		</td>
	</tr>
	<tr>
		<td>
		<input type="radio" name="sampletype" value="4" <cfif isDefined("form.sampletype") and form.sampletype EQ "4"> checked</cfif>>Census<A HREF="javascript:void(0)" <cfoutput>onclick="window.open('#application.basename#/dictionary.cfm##cen','_blank','height=500, width=700,scrollbars=yes')"</cfoutput>><img SRC="images/book07.gif"  width="20" height="20" BORDER="0" ALT="Help"></a>&nbsp; (e.g., pick every possible choice to collect information from, such as all students within a school or <strong>all</strong> restaurants in a county)
		</td>
	</tr>
	<tr>
		<td>
		<input type="radio" name="sampletype" value="1" <cfif isDefined("form.sampletype") and form.sampletype EQ "1"> checked</cfif>>Randomly<A HREF="javascript:void(0)" <cfoutput>onclick="window.open('#application.basename#/dictionary.cfm##ran','_blank','height=500, width=700,scrollbars=yes')"</cfoutput>><img SRC="images/book07.gif"  width="20" height="20" BORDER="0" ALT="Help"></a>&nbsp; (e.g., using a random number table to choose from a complete listing of all possible choices)
		</td>
	</tr>
	<tr>
		<td>
		<input type="radio" name="sampletype" value="2" <cfif isDefined("form.sampletype") and form.sampletype EQ "2"> checked</cfif>>Systematically<A HREF="javascript:void(0)" <cfoutput>onclick="window.open('#application.basename#/dictionary.cfm##syssamp','_blank','height=500, width=700,scrollbars=yes')"</cfoutput>><img SRC="images/book07.gif"  width="20" height="20" BORDER="0" ALT="Help"></a>&nbsp; (e.g., choosing every 10th person, every 25th person, etc from a listing of choices)
		</td>
	</tr>
	
	
	<tr>
		<td>
		<input type="radio" name="sampletype" value="5" <cfif isDefined("form.sampletype") and form.sampletype EQ "5"> checked</cfif>>Not applicable – This evaluation project did not require choosing a sample of people or organizations
		</td>
	</tr>
	<tr>
		<td>
		<input type="radio" name="sampletype" value="6" <cfif NOT isDefined("form.sampletype") OR (isDefined("form.sampletype") and form.sampletype EQ "6")> checked</cfif>>Other (please describe below)
		</td>
	</tr>
	<tr>
		<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;If "Other," describe the selection process for collecting information:<br>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<textarea name="othersampletype" cols="80" rows="4"><cfif isDefined("form.othersampletype")><cfoutput>#form.othersampletype#</cfoutput></cfif></textarea>
		</td>
	</tr>
	
</table>
</td></tr>

<tr>
<td>
<table class="box">	
	<tr>
		<th colspan="2" align="left">Evaluation Results</th>
	</tr>
	<tr>
	<td>
	Who will collect and tabulate/analyze the information?
	</td>
	<td><input type="text" name="analyzer" size="80" <cfif isDefined("form.analyzer")><cfoutput>value='#form.analyzer#'</cfoutput></cfif>></td>
</tr>

<tr>
	
	<td>Who will prepare the report of findings?</td>
	<td><input type="text" name="reporter" size="80" <cfif isDefined("form.reporter")><cfoutput>value='#form.reporter#'</cfoutput></cfif>></td>
</tr>

	
</table></td></tr>
<tr>
<td>
<table class="box">	
	<tr>
		<th align="left">Evaluation Plan Approval</th>
	</tr>
	<tr>
		<td>
		Has this evaluation plan been formally approved by your TSERT Evaluation Specialist?
		<input type="radio" name="tsert_approv" value="1" <cfif isDefined("form.tsert_approv") and form.tsert_approv EQ "1"> checked</cfif>> Yes &nbsp;&nbsp;&nbsp;&nbsp;
		<input type="radio" name="tsert_approv" value="0" <cfif NOT isDefined("form.tsert_approv") or (isDefined("form.tsert_approv") and form.tsert_approv NEQ "1")> checked</cfif>> No	
		
		</td>
	</tr>
	
</table>
</td>
</tr>

<!--- <tr>
<td>
<table class="box" align="left">
<tr>
	<td>
	What is the Purpose of Evaluation Project?<br><br>
	Briefly describe the <strong>key</strong> community<br>
	change(s) that the intervention<br>
	is expected to produce and that<br>
	the evaluation will assess
	</td>
	<td><textarea name="EvalPurp" cols="60" rows="5"><cfif isDefined("form.targetPop")><cfoutput>#form.targetpop#</cfoutput></cfif></textarea></td>
</tr>
</table>
</td>
</tr>
<tr>
<td>
<table class="box">

<tr>
	<cfoutput><td colspan="2">Design of Evaluation<A HREF="javascript:void(0)" onclick="window.open('#application.basename#/dictionary.cfm##desEval','_blank','height=500, width=700,scrollbars=yes')"><img SRC="images/book07.gif"  width="20" height="20" BORDER="0" ALT="Help"></a> (please select the evaluation design below that most closely describes the design of your evaluation project):</td></cfoutput>
</tr>

<cfquery datasource="#Application.DataSource#"  
	password="#Application.db_password#" 		
	username="#Application.db_username#" name="QevalDesign">
	select descrip, id
	from lu_evalDesign
	where year2=#session.fy#
</cfquery>

<tr>
	<td colspan="2">
		<cfselect name="evalDesign" query="QevalDesign" display="descrip" value="id"></cfselect>
	</td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr>
	<td valign="top">If "other", please describe:</td><td><textarea name="targetPop" cols="60" rows="5"><cfif isDefined("form.targetPop")><cfoutput>#form.targetpop#</cfoutput></cfif></textarea></td>
</tr>
</table>
</td>
</tr>


<tr>
	<td colspan="3" align="left"><button onClick="questionIndic('del');" class="DelButton">Delete</button></td>
</tr>
</cfif>


</table>
</td>
</tr>


</table></td></tr>
 --->



<!--- <tr><td><table align="left" class="box">
<tr>
<th colspan="2">Data Collection</th>
</tr>

<tr>
	<td>How will you collect the data?</td>
	<td><a name="prims"></a><input type="Radio" name="primSec" value="1" onclick="process();"<cfif (isDefined("form.primSec") and form.primSec NEQ "2") or (NOT isDefined("form.primSec")) > checked</cfif>>Primary?<A HREF="javascript:void(0)"onclick="window.open('<cfoutput>#application.basename#</cfoutput>/dictionary.cfm#pdc','_blank','height=500, width=700,scrollbars=yes')"><img SRC="images/book07.gif"  width="20" height="20" BORDER="0" ALT="Help"></a>&nbsp;&nbsp;&nbsp;<input type="Radio" name="primSec" value="2" onclick="process();"<cfif isDefined ("form.primSec") and form.primSec EQ "2"> checked</cfif>>Secondary?<A HREF="javascript:void(0)"onclick="window.open('<cfoutput>#application.basename#</cfoutput>/dictionary.cfm#sdc','_blank','height=500, width=700,scrollbars=yes')"><img SRC="images/book07.gif"  width="20" height="20" BORDER="0" ALT="Help"></a></td>
</tr>

<cfif isDefined("form.primSec")>
<cfif form.primSec EQ 1>
<tr>
<td>What is the data collection method that you will use?</td>
<td>
		<select name="method" query="qMeth" >
			<option value="">-select a method-
		<cfoutput query="qMeth">
			<option value="#num#" <cfif isDefined("form.method") and form.method EQ "#num#"> selected</cfif>>#descr#
		</cfoutput>
		</select>
	</td>
</tr>

<cfelseif form.primSec EQ 2>
<td>What data source will you use?</td>
<td>Data Sources:</td>
	<td>
		<select name="sources">
			<option value="">-select a source-<br>
			<option value="1" <cfif isDefined("form.sources") and form.sources EQ "1"> selected</cfif>>NYS Quit Line
			<option value="2" <cfif isDefined("form.sources") and form.sources EQ "2"> selected</cfif>>Medicaid
			<option value="3" <cfif isDefined("form.sources") and form.sources EQ "3"> selected</cfif>>Regional ATS
			<option value="4" <cfif isDefined("form.sources") and form.sources EQ "4"> selected</cfif>>YTS
			<option value="5" <cfif isDefined("form.sources") and form.sources EQ "5"> selected</cfif>>X-BRFSS
			<option value="6" <cfif isDefined("form.sources") and form.sources EQ "6"> selected</cfif>>Other
		</select>
	</td>
</cfif>

</cfif>

<tr>
	<td>Timeframe for data collection:</td>
	<td>
		Start Date:
		<cfif isDefined("form.startdate") and form.startdate NEQ "1/1/1900">
			<cfinput type="text" name="startdate" value="#form.startdate#" ><br>
		<cfelse>
			<cfinput type="text" name="startdate"><br>	
		</cfif>
		
		 

		End Date:
		<cfif isDefined("form.enddate") and form.enddate NEQ "1/1/1900">
			<cfinput type="text" name="enddate" value="#form.enddate#">	
		<cfelse>
			<cfinput type="text" name="enddate">	
		</cfif>
		 

	</td>
</tr>

<tr>
	<td>Additional number of times to be collected?</td>
	<td><input type="Text" name="num" <cfif isDefined("form.num")><cfoutput> value="#form.num#"</cfoutput></cfif>></td>
</tr>
<!--- <cfif (isDefined ("form.primSec") and form.primSec EQ "1") or NOT isDefined("form.primSec")>
 --->

<!--- <tr>
	<td>Questionnaire or assessment tool name:</td>
	<td><input type="Text" name="tool" <cfif isDefined("form.tool")> value=<cfoutput>"#form.tool#"</cfoutput></cfif>></td>
</tr> --->





  
 <!--- <tr>
      <td>Select Target Organizations</td>
	  <td>
         <select name="targetorg" multiple size="3">
            <cfoutput query="getTarget" >
               <option value="#targetNum#" <cfif isDefined("form.targetorg") and listfind(form.targetorg,targetNum)> Selected</cfif>>#target#
            </cfoutput>
				<option value="99" <cfif isDefined("form.targetorg") and listfind(form.targetorg,'99')> Selected</cfif>>other
         </select>
      </td>
</tr> --->


</table>
<br><br>

<table class="box" align="left">
<tr>
	<th colspan="2">Sample</th>
</tr>
<tr>
	<td>Sample Selection:<A HREF="javascript:void(0)"onclick="window.open('<cfoutput>#application.basename#</cfoutput>/dictionary.cfm##si','_blank','height=500, width=700,scrollbars=yes')"><img SRC="images/book07.gif"  width="20" height="20" BORDER="0" ALT="Help"></a></td>
	<td nowrap>
		<input type="Radio" name="selectmethod" value="1" <cfif isDefined ("form.selectmethod") and form.selectmethod EQ "1"> checked</cfif>>Random
		&nbsp;&nbsp;&nbsp;
		<input type="Radio" name="selectmethod" value="2" <cfif (isDefined ("form.selectmethod") and (form.selectmethod EQ "2" or form.selectmethod NEQ "1")) or NOT isDefined ("form.selectmethod") > checked</cfif>>Convenience
		&nbsp;&nbsp;&nbsp;
		<input type="Radio" name="selectmethod" value="3" <cfif isDefined ("form.selectmethod") and form.selectmethod EQ "3"> checked</cfif>>Census
	</td>
</tr>

<tr>
	<td colspan="2">Please provide additional information about your sample. Who/where will you get the information from?<br>How will you select the samplke and determine the sample size?</td>
</tr>

<tr>
	<td><textarea name="SampleDetail" cols="60" rows="5"><cfif isDefined("form.SampleDetail")><cfoutput>#form.SampleDetail#</cfoutput></cfif></textarea></td>
	</td>
</tr>
</table>
<br><br>
<table class="box" align="left">
<tr>
	<th colspan="2">Reporting</th>
</tr>
<!--- <tr>
	<td>Method - Brief Description:</td>
	<td><textarea name="name" cols="60" rows="5"><cfif isDefined("form.name")><cfoutput>#form.name#</cfoutput></cfif></textarea></td>
</tr>

<tr>
	<td>Evaluation Question(s):<br>
	What do you want to know?<br>
	What questions will be answered by the data you collect?</td>
	<td><textarea name="question" cols="60" rows="8"><cfif isDefined("form.question")><cfoutput>#form.question#</cfoutput></cfif></textarea></td>
</tr>

<tr>
	<td>Evidence:<br>
	What can be measured to determine if change has occurred?<br>
	How will you know it has happened?<br>
	What are the indicators?</td>
	<td><textarea name="Evidence" cols="60" rows="8"><cfif isDefined("form.Evidence")><cfoutput>#form.Evidence#</cfoutput></cfif></textarea></td>
</tr> --->

<tr>
	<td>Who will tabulate/analyze the data?</td>
	<td><input type="text" name="analyzer" size="60" <cfif isDefined("form.analyzer")><cfoutput>value="#form.analyzer#"</cfoutput></cfif>></td>
</tr>

<tr>
	<td>Who will prepare the report of findings?</td>
	<td><input type="text" name="reporter" size="60" <cfif isDefined("form.reporter")><cfoutput>value="#form.reporter#"</cfoutput></cfif>></td>
</tr>

<tr>
	<td>How will the report be disseminated?</td>
	<td>
	<select name="disseminate" multiple size="5" class="mlti">
		<!--- <option value="">-select a method- --->
		<option value="1" <cfif isDefined("form.disseminate") and listfind(form.disseminate,"1")> selected</cfif>>mailing
		<option value="2"<cfif isDefined("form.disseminate") and listfind(form.disseminate,"2")> selected</cfif>>website
		<option value="3"<cfif isDefined("form.disseminate") and listfind(form.disseminate,"3")> selected</cfif>>e-mails
		<option value="4"<cfif isDefined("form.disseminate") and listfind(form.disseminate,"4")> selected</cfif>>distribute at meetings
		<option value="5"<cfif isDefined("form.disseminate") and listfind(form.disseminate,"5")> selected</cfif>>give to support orgs for distribution
		<option value="6"<cfif isDefined("form.disseminate") and listfind(form.disseminate,"6")> selected</cfif>>Other		

	</select>
	</td>
</tr>

<tr>
	<td>Who will receive the report?</td>
	<td>
	<select name="disseminated" multiple size="4" class="mlti">
		<option value=1<cfif isDefined("form.disseminated") and listfind(form.disseminated,"1")> selected</cfif>>orgs surveyed
		<option value=2<cfif isDefined("form.disseminated") and listfind(form.disseminated,"2")> selected</cfif>>public / media
		<option value=3<cfif isDefined("form.disseminated") and listfind(form.disseminated,"3")> selected</cfif>>regulatory agency
		<option value=4<cfif isDefined("form.disseminated") and listfind(form.disseminated,"4")> selected</cfif>>TCP evaluation specialist
		<option value=5<cfif isDefined("form.disseminated") and listfind(form.disseminated,"5")> selected</cfif>>TCP Area Manager
		<option value=6<cfif isDefined("form.disseminated") and listfind(form.disseminated,"6")> selected</cfif>>Other
	</select>
	</td>
</tr>


<!--- <tr>
	<td colspan="2">If Evaluation Plan was revised, was the revision approved by the Partner's designated evaluation specialist</td>
</tr>	
<tr><td><input type="Radio" name="revApproval" value="1" <cfif isDefined ("form.revApproval") and form.revApproval EQ "1"> checked</cfif>>Yes&nbsp;&nbsp;&nbsp;<input type="Radio" name="revApproval" value="0" <cfif isDefined ("form.revApproval") and form.revApproval EQ "0"> checked</cfif>>No</td>
</tr>
<tr></tr> --->
</table>
 --->
</td>
</tr>
<tr><td align="left">
<br><input type="Submit" value="Submit" onclick="return checkPageDates();">
</td></tr>
<tr>
	<td>
	The information on this page should relate to one specific evaluation method.  
	If you are using several evaluation methods, 
	include information about only one of them on this screen, and then click “Submit” 
	to enter information about your next evaluation method on a new page. 
	Repeat for each additional method.
	</td>
</tr>
</table>
</cfform>



</body>
</html>
</cfif>