<script language="JavaScript">
function validate(){
if (ValidateDate(document.monthlyActivity.startDate.value)==false){return false;};
if (ValidateDate(document.monthlyActivity.endDate.value)==false){return false;};
if (ValidateCompareDate(document.monthlyActivity.startDate.value, document.monthlyActivity.endDate.value)==false){return false;};

return true;
}
function chkone(){
if (document.monthlyActivity.indTarget.value == '')
{
alert('Please select a target government policy maker.');
return false;
}
if (isInteger(document.monthlyActivity.numMeet.value)==false){
alert("please enter an integer value for number of meetings");
return false;

}
if (isInteger(document.monthlyActivity.numPhone.value)==false){
alert("please enter an integer value for number of phone interactions");
return false;
}
if (isInteger(document.monthlyActivity.numEmail.value)==false){
alert("please enter an integer value for number of emailings");
return false;
}
if (isInteger(document.monthlyActivity.numLetters.value)==false){
alert("please enter an integer value for number of letters");
return false;
}
addtarget('add');
}

function chktwo(){
if (document.monthlyActivity.stakeholders.value == '')
{
alert('Please select a target government policy maker.');
return false;
}
if (document.monthlyActivity.channel.value == '')
{
alert('Please select policy, resolution or practice.');
return false;
}
<cfif session.fy GT 2008>
<!--- if (document.monthlyActivity.formal.value == '')
{
alert('Please select if formalizing current practice or a change in the way the organization operates.');
return false;
} --->
if (document.monthlyActivity.resist.value == '')
{
alert('Please select how much resistance you encountered.');
return false;
}
</cfif>
if (document.monthlyActivity.rptdate.value == '')
{
alert('You must enter date of change');
return false;
}
else
{
if (ValidateDate(document.monthlyActivity.rptdate.value)==false){
return false;
}
addMotivation('add');
}}
</script>
<!--- 
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="dispGovtActive">
	select 
	<!--- issue, polLevel,impCounties,  --->
	impact1, impact2, impact3, impact4, impact5, 
	number1, number2, number3, number4, number5, 
	impact_action, impact_action_txt,
	impact_imp, impact_imp_txt
	from GOVT
	where userid = '#activityInfo.userid#'
	and activity = '#activity#'
	and month2='#form.month#'
	and year2 = #form.year#
	
</cfquery>

<cfif dispGovtActive.recordcount GT 0 and cgi.http_referer DOES NOT CONTAIN "monthlyActive.cfm">
<!--- 	<cfset form.issues = dispGovtActive.issue> --->
<!--- 	<cfset form.levelchangesought = dispGovtActive.polLevel> --->
<!--- 	<cfset form.impactedCounties = dispGovtActive.impcounties> --->
	<cfset form.cb1  = dispGovtActive.impact1>
	<cfset form.cb2  = dispGovtActive.impact2>
	<cfset form.cb3  = dispGovtActive.impact3>
	<cfset form.cb4 = dispGovtActive.impact4>
	<cfset form.cb5  = dispGovtActive.impact5>	
	<cfset form.cb1_text = dispGovtActive.number1>
	<cfset form.cb2_text = dispGovtActive.number2>
	<cfset form.cb3_text = dispGovtActive.number3>
	<cfset form.cb4_text = dispGovtActive.number4>
	<cfset form.cb5_text = dispGovtActive.number5>
	
	<cfset form.impact_action = dispGovtActive.impact_action>
	<cfif isDefined("dispGovtActive.impact_action_TXT")> 
		<cfset form.impact_action_txt = dispGovtActive.impact_action_txt>
	</cfif>
	<cfset form.impact_imp = dispGovtActive.impact_imp>
	<cfif isDefined("dispGovtActive.impact_imp_TXT")> 
		<cfset form.impact_imp_txt = dispGovtActive.impact_imp_txt>
	</cfif>
</cfif>
 --->
<cfif isDefined("form.addActiveTarget")>
<cfif form.addActiveTarget EQ "add">
	<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="addActivityTarget">
	insert into DirEdAct
	(userid, activity, target, numMeet, numPhone, numEmail, numLetters, year2, month2, FArea, numPet)
	values
	('#activityInfo.userid#', '#activity#', '#form.indTarget#', '#form.numMeet#', '#form.numPhone#', '#form.numEmail#', '#form.numLetters#', #form.year#, '#form.month#',#activityInfo.strategy#, <cfif form.numPet EQ ''>0<cfelse>#form.numPet#</cfif>)
	
	</cfquery>

	<cfset form.addActiveTarget EQ "">
	
<cfelseif  form.addActiveTarget EQ "delete">
<cfif isDefined("form.del") >
	<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="delActivityTarget">
	delete from DirEdAct
	where seq in (#form.del#)
	
	</cfquery>

</cfif>

</cfif>

</cfif>






<cfif isDefined("form.addActiveMotivation")>
<cfif form.addActiveMotivation EQ "add">
	<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="addActivity">
	insert into PRPChange
	(userid, rptDate,activity, stakeholders, channel, descr, year2, month2, FArea
	<cfif session.fy GT 2008><!--- ,formal --->, resist</cfif>)
	values
	('#activityInfo.userid#', '#rptdate#', '#activity#', '#form.stakeholders#', '#form.Channel#',
	'#form.descr#',  #form.year#, '#form.month#',#activityInfo.strategy#
	<cfif session.fy GT 2008><!--- ,#form.formal# --->, #form.resist#</cfif>)
	
	</cfquery>
	
		<cfset form.addActiveMotivation EQ "">
	
<cfelseif form.addActiveMotivation EQ "delete">
<cfif isDefined("form.delMotiv") >
	<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="delActivity">
	delete from PRPChange
	where seq in (#form.delMotiv#)
	
	</cfquery>

</cfif>




</cfif>
</cfif>

<!--- <cfquery datasource="#application.DataSource#" 
	password="#application.db_password#"   		
	username="#application.db_username#" name="dispTargets">
	select targetgroup from useractivities as u
	where u.year2=#form.year# and u.activity='#activity#' and u.userid='#activityInfo.userid#'  
	
</cfquery>
 --->

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="dispTargets">
	<!--- select t.target, t.targetnum
	from targets as t
	where 
	t.targetNum in (#dispTargets.targetgroup#)
	and T.year2=#form.year#
	AND t.strategynum=1 --->
	
	
select target, seq as targetnum
from 
user_target_org as u
where u.year2=#form.year# and u.strategy='#activity#' and u.userid='#activityInfo.userid#' 
order by 1


</cfquery>



<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="dispActivity">
	select a.activity, a.seq,
	t.target, numMeet, numPhone, numEmail, numLetters,a.numpet
	
	from DirEdAct as a, useractivities as u, user_target_org as t
	where a.userid= '#activityInfo.userid#' 
	and a.activity = '#activity#'
	and month2='#form.month#'
	and a.year2 = #form.year#
	and u.year2=a.year2
	and t.year2=u.year2
	and t.seq=a.target
	and u.activity=a.activity
	and u.userid=a.userid
	and u.del is null
	order by a.seq
	
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="dispActivity2">
	select t.target,
	activity,
	case channel
	when '4' then 'Policy - Formalizing current practice'
	when '5' then 'Policy - Change in the way organization operates'
	-- when '1' then 'Policy'
	when '2' then 'Resolution'	
	when '3' then 'Practice' end as channel,
	rptdate, m.descr, m.seq <cfif session.fy GT 2008>, r.descr as resist<!--- , f.descr as formal ---></cfif>
	from PRPChange as m, user_target_org as t<cfif session.fy GT 2008><!--- , lu_prp_formal as f --->, lu_prp_resistance as r</cfif>
	where m.userid= '#activityInfo.userid#' 
	and m.userid=t.userid
	and activity = '#activity#'
	and month2='#form.month#'
	and m.year2 = #form.year#
	and m.year2=t.year2
	and t.seq=m.stakeholders 
	<cfif session.fy GT 2008>
	<!--- and m.year2=f.year2 --->
	and m.year2=r.year2
	<!--- and m.formal=f.num --->
	and m.resist=r.num</cfif>
	<!--- and t.strategynum=1 --->
	
	order by m.seq
	
</cfquery>




<cfif pendStatus EQ "0">

<tr><td><a name="deat"></a><!--- <h3>Please fill in the rows below for each direct education activity you have conducted</h3> ---></td></tr>	
<tr><td><table width="80%" border=".2" class="box">
<tr><th colspan="8">Complete rows below for activities conducted this month</th></tr>
<tr>
	<th>Target government policy maker</th>
	<th># Meetings<br>attended</th>
	<th># Phone<br>interactions</th>	
	<th># emails<br>sent</th>
	<th># of letters<br>sent</th>
	<th># of petition<br>signatures delivered</th>
	<th rowspan="2">&nbsp;</th>
</tr>
<tr>
	<th valign="top">
	<cfif disptargets.recordcount EQ 0>
		<select name="indTarget">
	<option value="">-Please Select-</option>
		<cfoutput 	query="disptargets">

	<option value="#targetnum#">#target#</option>	</cfoutput>
	</select><br>
	If no response options appear in this pull-down menu, go to "Annual Plans" and "edit strategy" to add target decision-makers for this strategy in your work plan
	<cfelse>
		<select name="indTarget">
	<option value="">-Please Select-</option>
		<cfoutput 	query="disptargets">

	<option value="#targetnum#">#target#</option>	</cfoutput>
	</select>
	</cfif>
	</th>
	<th valign="top">
		<cfinput type="Text" name="numMeet" size=5 validate="integer" message="Please enter an integer value for Numbers">

	</th>
	<th valign="top">
		<cfinput type="Text" name="numPhone"size=5  validate="integer" message="Please enter an integer value for Numbers">

	</th>
	
	<th valign="top">
	<cfinput type="Text" name="numEmail" size=5 validate="integer" message="Please enter an integer value for Numbers">
	</th>
	
	<th valign="top">
	<cfinput type="Text" name="numLetters" size=5 validate="integer" message="Please enter an integer value for Numbers">
	</th>
	<th valign="top">
	<cfinput type="Text" name="numpet" size=5 validate="integer" message="Please enter number of petitions as an integer">
	</th>
</tr>
<tr>
	<td colspan="7" align="left">
	<input type="Button" value="Add" onclick="chkone();" class="AddButton">
	</td>
</tr>
<tr>
	<td colspan="7" align="left">
	<font size="-2">To add target organizations to this list, go to "Annual Plans" and select "Edit strategy" and add each target organization.</font>
	</td>
</tr>
<cfoutput>
<cfif dispActivity.recordcount GT 0>
<cfloop query="dispActivity">
<tr bgcolor="Silver">
	<td>#target#</td>
	<td align="center">#numMeet#</td>
	<td align="center">#numPhone#</td>
	<td align="center">#numEmail#</td>
	<td align="center">#numLetters#</td>
	<td align="center">#numpet#</td>
	<td><input type="Checkbox" name="del" value="#seq#">Delete</td>
</tr>
</cfloop>

<tr><td colspan="7" align="left"><input type="Button" value="Delete" onclick="addtarget('delete');" class="DelButton"></td></tr>
</cfif>
</cfoutput>
</table></td></tr>


<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="dispformal">
	select num, descr from lu_prp_formal
	where year2=#session.fy#
	and del is null
	order by rank
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="dispresistance">
			select num, descr from lu_prp_resistance
	where year2=#session.fy#
	and del is null
	order by rank

</cfquery>


<tr><td align="center"><a name="amo"></a><h4>Policy, resolution and practice changes</h4></td></tr>	
<tr><td><table width="80%" border=".2" align="center" class="box">

<tr>
	<th>Target government policy maker</th>
	<th>Policy/<br>Resolution/<br>Practice</th>
	<th>Date of change</th>	
	<cfif session.fy GT 2008>
	<!--- <th>Is this formalizing current practice or a change in the way the organization operates?</th> --->
	<th>How much resistance did you encounter?</th>
	</cfif>
	<th>Brief description of policy, resolution, or practice change</th>
	<th rowspan="2">&nbsp;</th>
</tr>
<tr>
	<th valign="top">		
	<cfif disptargets.recordcount EQ 0>
		<select name="stakeholders">
	<option value="">-Please Select-</option>
		<cfoutput 	query="disptargets">

	<option value="#targetnum#">#target#</option>	</cfoutput>
	</select>
	<br>
	If no response options appear in this pull-down menu, go to "Annual Plans" and "edit strategy" to add target decision-makers for this strategy in your work plan
	<cfelse>
		<select name="stakeholders">
	<option value="">-Please Select-</option>
		<cfoutput 	query="disptargets">

	<option value="#targetnum#">#target#</option>	</cfoutput>
	</select>
	</cfif>
	</th>
	<th valign="top">
		<select name="channel">
			<option value="">-Please Select-</option>
			<option value="4">Policy - Formalizing current practice</option>
			<option value="5">Policy - Change in the way organization operates</option>
			<!--- <option value="1">Policy</option> --->
			<option value="2">Resolution</option>
			<option value="3">Practice</option>
		</select>
		
	</th>
	
	<th valign="top">
	<cfinput type="Text" name="rptdate" size=12>
	</th>
	<cfif session.fy GT 2008>
	<!--- <th valign="top">
			<select name="formal">
	<option value="">-Please Select-</option>
		<cfoutput 	query="dispformal">

	<option value="#num#">#descr#</option>	</cfoutput>
	</select>
	</th> --->
	
	<th valign="top">
				<select name="resist">
	<option value="">-Please Select-</option>
		<cfoutput 	query="dispresistance">

	<option value="#num#">#descr#</option>	</cfoutput>
	</select>

	</th>
	</cfif>
	<th valign="top">
	<textarea name="descr" cols="30" rows="4"></textarea>
	</th>
	</tr>
	<tr>	
		<td align="left" colspan="<cfif session.fy GT 2008>7<cfelse>5</cfif>">
		<input type="Button" value="Add" onclick="chktwo();" class="AddButton">
		</td>
	</tr>
	<tr>
	<td colspan="<cfif session.fy GT 2008>7<cfelse>5</cfif>" align="left">
	<font size="-2">To add target organizations to this list, go to "Annual Plans" and select "Edit strategy" and add each target organization.</font>
	</td>
</tr>
<cfoutput>
<cfif dispActivity2.recordcount GT 0>
<cfloop query="dispActivity2">
<tr bgcolor="SILVER">
	<td>#target#</td>
	<td>#channel#</td>
	<td>#dateformat(rptdate, 'm/d/yyyy')#</td>
	<cfif session.fy GT 2008>
		<!--- <td>#formal#</td> --->
	<td>#resist#</td>
	</cfif>
	<td>#descr#</td>
	<td><input type="Checkbox" name="delMotiv" value="#seq#">Delete</td>
</tr>
</cfloop>
<tr><td colspan="<cfif session.fy GT 2008>7<cfelse>5</cfif>" align="left"><input type="Button" value="Delete" onclick="addMotivation('delete');" class="DelButton"></td></tr>
</cfif>
</cfoutput>
</table></td></tr>


<!--- Promotion Popup --->
<!--- end promotion popup --->


<!--- <cfoutput>
<tr><td><table class="box">
<tr><th colspan="2">Impacts on Decision-makers this month</th></tr>
<tr><td><input type="Checkbox" name="cb1" value="1" <cfif isDefined("form.cb1") and form.cb1 EQ 1> checked</cfif>></td><td>Decision-maker commits to study the issue</td><td>Number:<input type="Text" name="cb1_text" <cfif isDefined("form.cb1_text")>value = "#form.cb1_text#"</cfif>></td></tr>
<tr><td><input type="Checkbox" name="cb2" value="1" <cfif isDefined("form.cb2") and form.cb2 EQ 1> checked</cfif>></td><td>Decision-maker commits to incorporate considerations<br> of public health impact into decision making</td><td>Number:<input type="Text" name="cb2_text" <cfif isDefined("form.cb2_text")>value = "#form.cb2_text#"</cfif>></td></tr>
<tr><td><input type="Checkbox" name="cb3" value="1" <cfif isDefined("form.cb3") and form.cb3 EQ 1> checked</cfif>></td><td>Decision-maker commits to protect the public health</td><td>Number:<input type="Text" name="cb3_text" <cfif isDefined("form.cb3_text")>value = "#form.cb3_text#"</cfif>></td></tr>
<tr><td><input type="Checkbox" name="cb4" value="1" <cfif isDefined("form.cb4") and form.cb4 EQ 1> checked</cfif>></td><td>Decision-maker refuses to change policy/practice </td><td>Number:<input type="Text" name="cb4_text" <cfif isDefined("form.cb4_text")>value = "#form.cb4_text#"</cfif>></td></tr>
<!--- <tr><td><input type="Checkbox" name="cb5" value="1" <cfif isDefined("form.cb5") and form.cb5 EQ 1> checked</cfif>>Decision-maker(s) commit to OPPOSE anti-tobacco position</td><td>Number:<input type="Text" name="cb5_text" <cfif isDefined("form.cb5_text")>value = "#form.cb5_text#"</cfif>></td></tr>--->
 </table></td></tr>
</cfoutput>--->
</cfif>
<!--- <cfinclude template="imp_pp_impl.cfm">  --->
<!--- activity progress, successes, barriers, internal-training --->
<cfif pendStatus EQ "0">
<tr><td>&nbsp;</td></tr>
<cfinclude template="earnedM.cfm">
<tr><td>&nbsp;</td></tr>
<cfinclude template="tcpsust.cfm">
</cfif>
<cfinclude template="barriers.cfm">

