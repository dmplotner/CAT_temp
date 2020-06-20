<script language="JavaScript">
function validate(){

if (ValidateDate(document.monthlyActivity.startDate.value)==false){return false;};
if (ValidateDate(document.monthlyActivity.endDate.value)==false){return false;};
if (ValidateCompareDate(document.monthlyActivity.startDate.value, document.monthlyActivity.endDate.value)==false){return false;};

return true;
}
function test22() {
  		document.monthlyActivity.aTarget1.disabled=true;
		document.monthlyActivity.aTarget2.disabled=true;
  
  }
  
function checkentries(nextfunction){
if (document.monthlyActivity.indTarget.value == '')
{
alert('Please select a target organization name.');
return false;
}
	if( _CF_checkmonthlyActivity(document.monthlyActivity)==false) {return false;};
	
	if (nextfunction == 'addtarget'){
		addtarget('add');
	}
	else if (nextfunction == 'addMotivation'){
		if (document.monthlyActivity.rptdate.value == '')
			{
			alert('You must enter date of change');
			return false;
			}
		addMotivation('add');		
	}
{


}	
}
function checkentries2(nextfunction){
if (document.monthlyActivity.stakeholders.value == '')
{
alert('Please select a target organization name.');
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




	if( _CF_checkmonthlyActivity(document.monthlyActivity)==false) {return false;};
	
	if (nextfunction == 'addtarget'){
		addtarget('add');
	}
	else if (nextfunction == 'addMotivation'){
		if (document.monthlyActivity.rptdate.value == '')
			{
			alert('You must enter date of change');
			return false;
			}
		addMotivation('add');		
	}
{


}	
}
</script>

<!--- <cfquery datasource="#application.DataSource#"  		
	 
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
</cfif> --->

<cfif isDefined("form.addActiveTarget")>
<cfif form.addActiveTarget EQ "add">
	<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="addActivityTarget">
	insert into DirEdAct
	(userid, activity, target, numMeet, numPhone, numEmail, numMG, numIncent, numLetters, year2, month2, FArea, numPet)
	values
	('#activityInfo.userid#', '#activity#', '#form.indTarget#', '#form.numMeet#', '#form.numPhone#', '#form.numEmail#', '#form.numMG#', '#form.numIncent#','#form.numLetters#', #form.year#, '#form.month#',#activityInfo.strategy#, <cfif form.numPet EQ ''>0<cfelse>#form.numPet#</cfif>)
	
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
	(userid, rptDate,activity, stakeholders, channel, descr, year2, month2, FArea<!--- , numpet --->
	<cfif session.fy GT 2008><!--- ,formal --->, resist</cfif>)
	values
	('#activityInfo.userid#', '#rptdate#', '#activity#', '#form.stakeholders#', '#form.Channel#',
	'#form.descr#',  #form.year#, '#form.month#',#activityInfo.strategy#<!--- , #form.numpet# --->
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


<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="dispTargets">
	
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
	t.target, numMeet, numPhone, numEmail, numLetters, numMG, numIncent, a.numpet
	
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
	<!--- AND t.strategynum=1 --->
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
	
	rptdate, m.descr, m.seq
	<cfif session.fy GT 2008><!--- , f.descr as formal --->, r.descr as resist</cfif>
	from PRPChange as m, user_target_org as t
	<cfif session.fy GT 2008><!--- , lu_prp_formal f --->, lu_prp_resistance r</cfif>
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
	and m.resist=r.num
	</cfif>
	<!--- and t.strategynum=1 --->
	
	order by m.seq
	
</cfquery>




<cfif pendStatus EQ "0">

<tr><td><table width="80%" border=".2" align="left	" class="box">
<tr><th colspan="9"><a name="deat"></a>Direct Advocacy of target organizations</th></tr>	

<tr><td colspan="9" align="center">Please fill in the rows below for each direct education activity you have conducted</td></tr>	


<tr>
	<th>Target organization name</th>
	<th># Meetings attended</th>
	<th># Phone interactions</th>	
	<th># letters sent</th>
	<th># emails sent</th>
	<th># of minigrants/stipends awarded</th>
	<th># of non-monetary incentives given (e.g., NRT)</th>
	<th># of petition<br>signatures delivered</th>
	<th>&nbsp;</th>
</tr>
<tr>
	<th valign="top">
	<cfif disptargets.recordcount EQ 0>
		<select name="indTarget">
	<option value="">-Please Select-</option>
		<cfoutput 	query="disptargets">

	<option value="#targetnum#">#target#</option>	</cfoutput>
	</select>
	
<!--- 	<cfselect name="indTarget" query="disptargets" display="target" value="targetnum">
	</cfselect> ---><br>
	If no response options appear in this pull-down menu, go to "Annual Plans" and "edit strategy" to add target decision-makers for this strategy in your work plan
	<cfelse>
			<select name="indTarget">
	<option value="">-Please Select-</option>
		<cfoutput 	query="disptargets">

	<option value="#targetnum#">#target#</option>	</cfoutput>
	</select>
<!--- 		<cfselect name="indTarget" query="disptargets" display="target" value="targetnum">
		</cfselect> --->
	</cfif>
	</th>
	<th valign="top">
		<cfinput type="Text" size="10" name="numMeet" validate="integer" message="Please enter an integer value for Numbers">

	</th>
	<th valign="top">
		<cfinput type="Text"  size="10" name="numPhone" validate="integer" message="Please enter an integer value for Numbers">

	</th>	
	<th valign="top">
	<cfinput type="Text"  size="10" name="numLetters" validate="integer" message="Please enter an integer value for Numbers">
	</th>
	<th valign="top">
	<cfinput type="Text"  size="10" name="numEmail" validate="integer" message="Please enter an integer value for Numbers">
	</th>
	<th valign="top">
	<cfinput type="Text"  size="10" name="numMG" validate="integer" message="Please enter an integer value for Numbers">
	</th>
	<th valign="top">
	<cfinput type="Text"  size="10" name="numIncent" validate="integer" message="Please enter an integer value for Numbers">
	</th>
	<th valign="top">
	<cfinput type="Text" name="numpet" size=5 validate="integer" message="Please enter number of petitions as an integer">
	</th>
	<th>&nbsp;</th>
</tr>
<tr>
	<td colspan="9" align="left"><input type="Button" value="Add" name="Target1" onclick="checkentries('addtarget');" class="AddButton"></td>
</tr>
<tr>
	<td colspan="9" align="left">
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
	<td align="center">#numLetters#</td>
	<td align="center">#numEmail#</td>	
	<td align="center">#numMG#</td>
	<td align="center">#numIncent#</td>
	<td>#numpet#</td>
	<td><input type="Checkbox" name="del" value="#seq#">Delete</td>
</tr>
</cfloop>

<tr><td colspan="9" align="left"><input type="Button" value="Delete" onclick="addtarget('delete');" class="DelButton"></td></tr>
</cfif>
</cfoutput>
</table></td></tr>


<cfif session.fy GT 2008>
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

</cfif>
	
<tr><td><table width="80%" border=".2" align="center" class="box">
<tr><th colspan="<cfif session.fy GT 2008>8<cfelse>6</cfif>"><a name="amo"></a>Policy, resolution and practice changes</th></tr>
<tr>
	<td colspan="<cfif session.fy GT 2008>8<cfelse>6</cfif>" align="center">Please fill in the rows below for each policy, practice, or resolution adopted this month</td>
</tr>
<tr>
	<th>Target organization name</th>
	<th>Policy/<br>Resolution/<br>Practice</th>
	<!--- <th># of petitions<br>delivered</th> --->
	<th>Date of change</th>	
	<cfif session.fy GT 2008>
	<!--- <th>Is this formalizing current practice or a change in the way the organization operates?</th> --->
	<th>How much resistance did you encounter?</th>
	</cfif>
	<th colspan="2">Brief description of policy, resolution, or practice change</th>
	
</tr>
<tr>
	<th valign="top">		
	<cfif disptargets.recordcount EQ 0>
			<select name="stakeholders">
	<option value="">-Please Select-</option>
		<cfoutput 	query="disptargets">

	<option value="#targetnum#">#target#</option>	</cfoutput>
	</select>
<!--- 	<cfselect name="stakeholders" query="disptargets" display="target" value="targetnum">
	</cfselect> ---><br>
	If no response options appear in this pull-down menu, go to "Annual Plans" and "edit strategy" to add target decision-makers for this strategy in your work plan
	<cfelse>
				<select name="stakeholders">
	<option value="">-Please Select-</option>
		<cfoutput 	query="disptargets">

	<option value="#targetnum#">#target#</option>	</cfoutput>
	</select><!--- 
		<cfselect name="stakeholders" query="disptargets" display="target" value="targetnum">
		</cfselect> --->
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
	<!--- <th valign="top">
	<cfinput type="Text" name="numpet" size=5 validate="integer" message="number of petitions as an integer">
	</th> --->
	
	<th valign="top">
	<cfinput type="Text" size=12 name="rptdate" validate="date" message="Please enter dates in 'm/d/yyyy/ format">
	</th>
	<cfif session.fy GT 2008>
	<!--- <th valign="top">
	<select name="formal">
	<option value="">-Please Select-</option>
		<cfoutput 	query="dispformal">

	<option value="#num#">#descr#</option>	</cfoutput>
	</select>
	

<!--- 	
		<cfselect name="formal" query="dispformal" value="num" display="descr">
		</cfselect> --->
	</th> --->
	
	<th valign="top">
		<select name="resist">
	<option value="">-Please Select-</option>
		<cfoutput 	query="dispresistance">

	<option value="#num#">#descr#</option>	</cfoutput>
	</select>
<!--- 		<cfselect name="resist" query="dispresistance" value="num" display="descr">
		</cfselect> --->
	</th>
	</cfif>
	<th valign="top" colspan="2">
	<textarea name="descr" cols="30" rows="4"></textarea>
	</th>
	</tr>
	<tr>
		<td align="left" colspan="<cfif session.fy GT 2008>8<cfelse>6</cfif>"><input type="Button" name="aTarget2" value="Add" onclick="checkentries2('addMotivation');" class="AddButton"></td>
	</tr>
	<tr>	
		<td align="left" colspan="<cfif session.fy GT 2008>8<cfelse>6</cfif>">
			<font size="-2">To add target organizations to this list, go to "Annual Plans" and select "Edit strategy" and add each target organization.</font>
			</td>
	</tr>

<cfoutput>
<cfif disptargets.recordcount EQ 0>
<script language="javascript">
	test22();
</script>
</cfif>
<cfif dispActivity2.recordcount GT 0>
<cfloop query="dispActivity2">
<tr bgcolor="SILVER">
	<td>#target#</td>
	<td>#channel#</td>
	<!--- <td>#numpet#</td> --->
	<td>#dateformat(rptdate, 'm/d/yyyy')#</td>
	<cfif session.fy GT 2008>
		<!--- <td>#formal#</td> --->
		<td>#resist#</td>
	</cfif>
	<td>#descr#</td>
	<td width="60"><input type="Checkbox" name="delMotiv" value="#seq#">Delete</td>
</tr>
</cfloop>
<tr><td colspan="<cfif session.fy GT 2008>8<cfelse>6</cfif>" align="left"><input type="Button" value="Delete" onclick="addMotivation('delete');" class="DelButton"></td></tr>
</cfif>
</cfoutput>
</table></td></tr>



</cfif>
<cfif pendStatus EQ "0">
<tr><td>&nbsp;</td></tr>
<cfinclude template="earnedM.cfm">
<tr><td>&nbsp;</td></tr>
<cfinclude template="tcpsust.cfm">
</cfif>
<cfinclude template="barriers.cfm">

