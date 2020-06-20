<html><head>
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
	selectedmethods,
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
	tsert_approv,
	tsert_date,
	tsert_instapprov,
	tsert_instdate,
	date_complete,
	casemeth
	from EvalM
	where 
	userid='#session.userid#'
	and methodname = '#url.method2#'	
	and year2=#session.fy#
</cfquery>

<cfquery datasource="#application.DataSource#" 
	password="#application.db_password#"   		
	username="#application.db_username#" name="UsrEvalMeth">
	select method_id
	from user_eval_methods
	where userid='#session.userid#'
	and year2=#session.fy#
</cfquery>
	<cfset form.selectedmethods = '#UsrEvalMeth.method_id#'> 

	<cfset form.methodname = '#RecordDet.methodname#'>
	<cfset form.ostartdate =  dateformat(#RecordDet.ostartdate#,'m/d/yyyy')> 
	<cfset form.oenddate =  dateformat(#RecordDet.oenddate#,'m/d/yyyy')>
	<cfset form.date_planning =  dateformat(#RecordDet.date_planning#,'m/d/yyyy')> 
	<cfset form.date_collecting =  dateformat(#RecordDet.date_collecting#,'m/d/yyyy')>
	<cfset form.selectedStrategies = '#RecordDet.selectedStrategies#'>
	<cfset form.selectedMethods = '#RecordDet.selectedMethods#'>
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
	
	<cfset form.tsert_date2 = dateformat(#RecordDet.tsert_date#,'m/d/yyyy')>
	<cfset form.tsert_instapprov = dateformat(#RecordDet.tsert_instapprov#,'m/d/yyyy')>
	<cfset form.tsert_instdate = dateformat(#RecordDet.tsert_instdate#,'m/d/yyyy')>
	
	<cfset form.date_complete = dateformat(#RecordDet.date_complete#,'m/d/yyyy')>	
	<cfset form.casemeth = '#RecordDet.casemeth#'>
	
	

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
	username="#application.db_username#" name="GetStratFullDet">
	select u.activity, u.activityname,
	g.program as goal,
	o.objective as obj,
	u.outcome
	from useractivities as u, program as g, objectives as o
	where u.pk in (#PreserveSingleQuotes(strats)#)
	and g.year2=#session.fy#
	and o.year2=#session.fy#
	and g.prognum=u.goal
	and o.id=u.objective
	and (u.del is Null  or u.del !='Y')
	
	order by 1
</cfquery>

<!--- 
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
</cfquery> --->

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
}

function flipeval2(){
for(var k = 0; k < document.f1.selectedmethods.length; k++){ 
document.f1.selectedmethods[k].selected = true;
}
return true;
}

function checkPageDates(){
<!--- if (ValidateDate(document.f1.Ostartdate.value)==false){return false;};
if (ValidateDate(document.f1.Ostartdate.value)==false){return false;};
if (ValidateCompareDate(document.f1.Ostartdate.value, document.f1.Oenddate.value)==false){return false;};
if (typeof(document.f1.startdate) != "undefined"){
if (ValidateDate(document.f1.startdate.value)==false){return false;};
if (ValidateDate(document.f1.enddate.value)==false){return false;};
if (ValidateCompareDate(document.f1.startdate.value, document.f1.enddate.value)==false){return false;};
}
if (typeof(document.f1.adate) != "undefined" && document.f1.adate!="" ){
if (ValidateDate(document.f1.adate.value)==false){return false;};
} --->
<!--- if (document.f1.targetorg.selectedIndex==-1){
alert('Please select a target organization');
return false;
}
 --->

 flipeval();
  flipeval2();
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
document.f1.action="evalplan.cfm?<cfoutput>#session.urltoken#</cfoutput>#evald";
flipeval();
flipeval2();
document.f1.submit();
}

function AddStrat(){
document.f1.action="evalplan.cfm?<cfoutput>#session.urltoken#</cfoutput>#addstrat";
flipeval();
flipeval2();
document.f1.submit();
}

function AddStrat2(){
document.f1.action="evalplan.cfm?<cfoutput>#session.urltoken#</cfoutput>#addmeth";
flipeval();
flipeval2();
document.f1.submit();
}

function  primSec(type){

document.f1.action="evalplan.cfm?<cfoutput>#session.urltoken#</cfoutput>#primSec";
flipeval();
flipeval2();
document.f1.submit();
}

function toggle(){
document.f1.action="evalplan.cfm?<cfoutput>#session.urltoken#</cfoutput>";
flipeval();
flipeval2();
document.f1.submit();
}

function numtimes(){
document.f1.action="evalplan.cfm?<cfoutput>#session.urltoken#</cfoutput>#numtimes";
flipeval();
flipeval2();
document.f1.submit();
}

function showdmeth(){
document.f1.action="evalplan.cfm?<cfoutput>#session.urltoken#</cfoutput>#showdmeth";
flipeval();
flipeval2();
document.f1.submit();
}

</script>


<div class="box">
 <cfform name="f1" action="prc_evalplan.cfm?#session.urltoken#"> 
<!---<cfform name="f1" action="prcevalplanDet.cfm?#session.urltoken#">--->
<input name="indicator" type="hidden" value="">
<cfif isDefined("form.methodName") and form.methodName NEQ "">
	<input name="oldMethodName" type="hidden" value="<cfoutput>#form.methodName#</cfoutput>">
<cfelse>
	<input name="oldMethodName" type="hidden" value="">
</cfif>
<input name="oldMethodName" type="hidden" value="">
<cfif isDefined("url.method2")><cfoutput><input type="hidden" name="method2" value="#url.method2#"></cfoutput></cfif>
<div align="center"><h2>Description of Evaluation Project</h2></div>
<br>
<script language="JavaScript">
	
  function RemoveDuplicates(arr)
   {
    //get sorted array as input and returns the same array without duplicates.
    var result=new Array();
    var lastValue="";
    for (var i=0; i<arr.length; i++)
    {
  var curValue=arr[i];
  if (curValue != lastValue)
  {
result[result.length] = curValue;
  }
  lastValue=curValue;
    }
    return result;
   }
   
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
and (u.del is Null  or u.del !='Y')
	

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
<!--- Please provide a unique name for the evaluation project (e.g. POP ad observation, policy maker survey, faculty interviews, policy analysis/document review):
 --->Please provide a unique name for the evaluation project (e.g. Retail Strategy Evaluation Project, Multi-Unit Dwelling Evaluation Project):
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
	<td colspan="2" align="center">
	When do you expect to begin formal planning and preparation for the evaluation?
	</td>
</tr>
<tr>
	<td colspan="2" align="center">
	M/D/YYYY 
	<cfif isdefined("form.date_planning") and form.date_planning NEQ "1/1/1900">
			<cfinput type="text" name="date_planning"  value="#form.date_planning#"  validate="date" message="Please enter your dates in the 'm/d/yyyy' format.">
		<cfelse>
			<cfinput type="text" name="date_planning"  validate="date" message="Please enter your dates in the 'm/d/yyyy' format.">
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
	M/D/YYYY 
	<cfif isdefined("form.date_collecting") and form.date_collecting NEQ "1/1/1900">
			<cfinput type="text" name="date_collecting"  value="#form.date_collecting#"  validate="date" message="Please enter your dates in the 'm/d/yyyy' format.">
		<cfelse>
			<cfinput type="text" name="date_collecting"  validate="date" message="Please enter your dates in the 'm/d/yyyy' format.">
		</cfif>
	</td>
</tr>

<tr>
	<td colspan="2" align="center">
	When do you expect to complete the evaluation?
	</td>
</tr>
<tr>
	<td colspan="2" align="center">
	M/D/YYYY 
	<cfif isdefined("form.date_complete") and form.date_collecting NEQ "1/1/1900">
			<cfinput type="text" name="date_complete"  value="#form.date_complete#"  validate="date" message="Please enter your dates in the 'm/d/yyyy' format.">
		<cfelse>
			<cfinput type="text" name="date_complete" validate="date" message="Please enter your dates in the 'm/d/yyyy' format.">
		</cfif>
	</td>
</tr>
</table>

<br><br>

<table class="box">
<tr>
	<td align="center"><h3>Intervention Details</h3> </td>
</tr>
<tr>
	<td colspan="2" align="center"><font size="+1">In this section you will provide details about the work plan strategy or strategies that you have chosen to evaluate for impact</font></td>
</tr>

<tr><td colspan="2">
<table align="left" class="boxN">
<tr>
  <th colspan="3" align="left">What strategy or strategies will be evaluated by this project?<br>
    (select all that apply)</th></tr>
<tr>
<td colspan="3">
Note:  Impact evaluation is used to assess community effects of a program intervention
<A HREF="javascript:void(0)" <cfoutput>onclick="window.open('#application.basename#/dictionary.cfm##interv','_blank','height=500, width=700,scrollbars=yes')"></cfoutput><img SRC="images/book07.gif"  width="20" height="20" BORDER="0" ALT="Help"></a>
. Therefore, annual plan strategies entered for Goals 5 and 6, as well as any strategy classified as either Monitoring or Assessment or Survey, will not appear in the List of Strategies for potential evaluation selection.  Monitoring/ Assessment and Survey strategies might be used as evaluation methods, but would not need to be evaluated themselves, since they are not interventions.
<br>&nbsp;<br>&nbsp;
</td>
</tr>

<tr>
<td align="right"><a name="addstrat"></a>
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

  </td>

<td align="left">



Strategies Evaluated by this Project: 
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
	and (del is null or del !='Y')
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
<!--- <table align="left" class="box" width="100%">



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
</table>--->
<cfif isdefined("GetStratFullDet") and GetStratFullDet.recordcount GT 0>
<table align="left" class="boxB" width="100%">
<tr>
	<th width="13%">Strategy</th>
	<th width="23%">Strategy Description</th>
	<th width="9%">Goal</th>
	<th width="23%">Objective</th>
	<th width="23%">SMART Outcome</th>

</tr>
<cfoutput>
<cfloop query="GetStratFullDet">
<tr>
	<td valign="top">#activity#</td>
	<td valign="top">#activityname#</td>
	<td valign="top">#goal#</td>
	<td valign="top">#obj#</td>
	<td valign="top">#outcome#</td>
</tr>
</cfloop>
</cfoutput>
</table>
</cfif>



</td>
</tr>
<tr>
	<td>
	<table align="left" class="boxN">
<tr>
	<td width="40%">If needed, further describe the expected SMART Outcomes and community impact(s) 
	that the intervention is expected to produce and that the evaluation will assess.</td>

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
<table align="left" class="boxN">
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



</table>
<br><br>

</td></tr>

<tr>
<td>
<table class="box">
<tr><td align="center"><a name="evald"></a><h3>Evaluation Details</h3></td></tr>
<tr>
	<td align="center"><font size="+1">In this section you will provide details about the evaluation questions, approaches, and methods</font></td>
</tr>

<tr>
<td colspan="2">
<table class="boxN" align="left" width="400">
<tr><td colspan="3"  align="left"><strong>Evaluation Question(s) and related Indicator(s)<A HREF="javascript:void(0)" <cfoutput>onclick="window.open('#application.basename#/dictionary.cfm##ind','_blank','height=500, width=700,scrollbars=yes')"</cfoutput>><img SRC="images/book07.gif"  width="20" height="20" BORDER="0" ALT="Help"></a>
<br>
Please enter one evaluation question and corresponding indicator at a time.</strong><br>
If there is more than one indicator for a particular evaluation question, enter that same evaluation question again with the additional indicator.
</td></tr>
<tr>
<td width="80">
<strong>Evaluation&nbsp;question</strong><br><input type="text" name="indQ" size="60" >
</td>
<td width="80">
<strong>Indicator</strong><br><input type="text" name="indInd" size="60">
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
<table class="boxN" align="left">
<tr>
	<th colspan="3" align="left">Evaluation Approach<A HREF="javascript:void(0)" <cfoutput>onclick="window.open('#application.basename#/dictionary.cfm##evap','_blank','height=500, width=700,scrollbars=yes')"</cfoutput>><img SRC="images/book07.gif"  width="20" height="20" BORDER="0" ALT="Help"></a></th>
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
	<textarea name="other_eval_txt2" cols="140" rows="6"><cfif isDefined("form.other_eval_txt2")><cfoutput>#form.other_eval_txt2#</cfoutput></cfif></textarea>
	</td>
</tr>

</table></td></tr>


<!--- begin of new section for data collection --->
<tr>
<td>
<table class="boxN">
	<tr>
		<th colspan="3" align="left">Data Collection</th>
	</tr>
	<tr><td>&nbsp;</td></tr>
	<tr>
		<th colspan="3" align="left">In this section you will provide details about the data collection methods that you have chosen for your evaluation project.</th>
	</tr>
	
	<tr>
	<td colspan="3">
	Are you planning to use information that has already been collected by others such as information from the Quitline, Medicaid, etc. (referred to as Secondary Data Collection)?
	<input type="radio" name="multi_eval"  value="1"<cfif isDefined ("form.multi_eval") and form.multi_eval EQ "1"> checked</cfif> onclick="AddStrat2();"> Yes &nbsp;&nbsp;&nbsp;&nbsp;
	<input type="radio" name="multi_eval"  value="0"<cfif NOT isDefined("form.multi_eval") OR (isDefined ("form.multi_eval") and form.multi_eval NEQ "1")> checked</cfif> onclick="AddStrat2();"> No	
		
	</td>
	</tr>
	<tr><td>&nbsp;</td></tr>
	<tr>
		<td colspan="3">
		What data collection method or methods will you be using to answer your evaluation questions?
		</td>
	</tr>


	<!--- begin selection script --->
	
<cfquery datasource="#Application.DataSource#" 
password="#Application.db_password#"   		
	username="#Application.db_username#" name="Qdatacollmeth">
	
	select 
	case p_s when 1 then ' ' + method
	else method end as
	
	method, method_id
	from lu_eval_dc_methods
	where  year2=#session.fy#
	--and (del is null or del !='Y')
	<cfif isDefined("form.multi_eval") and form.multi_eval EQ 1>
	and 1=1
	<cfelse>
	and p_s = 1
	</cfif>
	<cfif isDefined("form.selectedMethods") and form.selectedMethods NEQ "">and method_id not in (#form.selectedMethods#)</cfif>
	order by 1, method_rank
</cfquery>



<tr><td>&nbsp;</td></tr>
<tr>
<td align="right"><a name="addmeth"></a>
Possible Data Collection Methods: <br><select name="allmethods" multiple size="5" class="mlti">
<cfoutput>
<cfloop query="Qdatacollmeth">
<option value="#method_id#">#method#
</cfloop> 
</cfoutput>
</select>
</td>

<td align="center"><NOBR> 
    <input type="button" style="width:90" onclick="moveDualList( this.form.allmethods,  this.form.selectedmethods, false );flipeval2();AddStrat2();"    name="Add     >>"  value="Add       >>" class="AddButton">     <BR>
    <NOBR>   
	<input type="button" style="width:90" onclick="moveDualList( this.form.selectedmethods, this.form.allmethods,  false );flipeval2();AddStrat2();"    name="<<  Remove"  value="<<   Remove" class="DelButton" >     <BR>
  </td>
<td align="left">


Your Data Collection Methods: 
<br><select name="selectedmethods" multiple size="5" class="mlti">
<cfoutput>
<cfif isDefined("form.selectedmethods")>
<cfloop list="#form.selectedmethods#" index="strat">

<cfquery datasource="#Application.DataSource#" 
password="#Application.db_password#"   		
	username="#Application.db_username#" name="methodsback">
	
	select method, method_id
	from lu_eval_dc_methods
	where method_id=#strat#
	and year2=#session.fy#
	--and (del is null or del !='Y')
	order by 1	
</cfquery>


<option value="#strat#">#methodsback.method#
</cfloop> 
</cfif>
</cfoutput>
</select>
</td></tr> 


	<!--- end selection script --->
</table>
</td></tr>


<tr>
<td>
<table class="boxN" cellpadding="5" cellspacing="10">
<tr>
	<td valign="top"><strong>Method</strong><br>What method will you use to collect the information?</td>
	<td valign="top"><strong>Sample</strong><br> Who / where will you get the information from? How will you select the sample?</td>
	<td valign="top"><strong>Timeframe</strong><br> When will you collect the data? By what date will data collection be complete?</td>
</tr>

<cfoutput>
<cfif isDefined("form.selectedmethods")>
<cfloop list="#form.selectedmethods#" index="strat">

<cfquery datasource="#Application.DataSource#" 
password="#Application.db_password#"   		
	username="#Application.db_username#" name="methodsback">
	
	select method, method_id
	from lu_eval_dc_methods L
	where method_id=#strat#
	and year2=#session.fy#
	--and (del is null or del !='Y')
	order by 1	
</cfquery>

<cfquery datasource="#Application.DataSource#" 
password="#Application.db_password#"   		
	username="#Application.db_username#" name="methodDS">
	select mvalue 
	from eval_sampTF
	where userid='#session.userid#'
	and methodname = '#htmleditformat(form.methodname)#'	
	and year2=#session.fy#
	and mvarname = 'ds_#methodsback.method_id#'
</cfquery>

<cfquery datasource="#Application.DataSource#" 
password="#Application.db_password#"   		
	username="#Application.db_username#" name="methodTF">
	select mvalue 
	from eval_sampTF
	where userid='#session.userid#'
	and methodname = '#htmleditformat(form.methodname)#'	
	and year2=#session.fy#
	and mvarname = 'tf_#methodsback.method_id#'
</cfquery>


<cfset temp1='form.ds_' & '#methodsback.method_id#'>
<cfset temp2='form.tf_' & '#methodsback.method_id#'>
<tr valign="top">
	<td>#methodsback.method#</td>
	<td><textarea name="ds_#methodsback.method_id#" rows="3" cols="70"><cfif isDefined("form.ds_#methodsback.method_id#")>#evaluate(temp1)#<cfelseif methodDS.recordcount GT 0>#methodDS.mvalue#</cfif></textarea></td>
	<td><textarea name="tf_#methodsback.method_id#" rows="3" cols="70"><cfif isDefined("form.tf_#methodsback.method_id#")>#evaluate(temp2)#<cfelseif methodTF.recordcount GT 0>#methodTF.mvalue#</cfif></textarea></td>
</tr> 
</cfloop>
</cfif>
</cfoutput>





</table>
</td>
</tr>

<!--- end of new section for data collection --->
<tr>
<td>
<table class="boxN">	
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
<table class="boxN" cellspacing="5" >	
	<tr>
		<th align="left" colspan="2">Evaluation Plan Approval</th>
	</tr>
	<tr valign="middle">
		<td>
		Has this evaluation plan been formally approved by your TSERT Evaluation Specialist?
		</td><td><input type="radio" name="tsert_approv" value="1" <cfif isDefined("form.tsert_approv") and form.tsert_approv EQ "1"> checked</cfif>> Yes &nbsp;&nbsp;&nbsp;&nbsp;
		<input type="radio" name="tsert_approv" value="0" <cfif NOT isDefined("form.tsert_approv") or (isDefined("form.tsert_approv") and form.tsert_approv NEQ "1")> checked</cfif>> No	
		&nbsp;&nbsp;&nbsp;Date of approval (M/D/YYYY):
		<cfif isdefined("form.tsert_date2") and form.tsert_date2 NEQ "1/1/1900">
			<cfinput type="text" name="tsert_date2"  value="#form.tsert_date2#"  validate="date" message="Please enter your dates in the 'm/d/yyyy' format.">
		<cfelse>
			<cfinput type="text" name="tsert_date2"  validate="date" message="Please enter your dates in the 'm/d/yyyy' format.">
		</cfif>		
		</td>
	</tr>
	<tr valign="middle">
		<td>
		Have the data collection instruments been formally approved by your TSERT Evaluation Specialist?
		</td>
		<td><input type="radio" name="tsert_instapprov" value="1" <cfif isDefined("form.tsert_instapprov") and form.tsert_approv EQ "1"> checked</cfif>> Yes &nbsp;&nbsp;&nbsp;&nbsp;
		<input type="radio" name="tsert_instapprov" value="0" <cfif NOT isDefined("form.tsert_instapprov") or (isDefined("form.tsert_instapprov") and form.tsert_instapprov NEQ "1")> checked</cfif>> No	
		&nbsp;&nbsp;&nbsp;Date of approval (M/D/YYYY):
		<cfif isdefined("form.tsert_instdate") and form.tsert_instdate NEQ "1/1/1900">
			<cfinput type="text" name="tsert_instdate"  value="#form.tsert_instdate#"  validate="date" message="Please enter your dates in the 'm/d/yyyy' format.">
		<cfelse>
			<cfinput type="text" name="tsert_instdate"  validate="date" message="Please enter your dates in the 'm/d/yyyy' format.">
		</cfif>
		</td>
	</tr>
	
	
	
	
	
</table>
</td>
</tr>

</td>
</tr>
<tr><td align="left">
<br><input type="Submit" value="Save" onclick="return checkPageDates();">
</td></tr>

</table>
</cfform>



</body>
</html>