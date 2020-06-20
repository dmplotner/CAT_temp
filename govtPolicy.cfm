<script language="JavaScript">
function validate(){
if (ValidateDate(document.monthlyActivity.startDate.value)==false){return false;};
if (ValidateDate(document.monthlyActivity.endDate.value)==false){return false;};
if (ValidateCompareDate(document.monthlyActivity.startDate.value, document.monthlyActivity.endDate.value)==false){return false;};

return true;
}
</script>

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

<cfif isDefined("form.addActiveTarget")>
<cfif form.addActiveTarget EQ "add">
	<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="addActivityTarget">
	insert into DirEdActTarget
	(userid, rptDate,activity, target, channel, commCount, impactCount, year2, month2)
	values
	('#activityInfo.userid#', '1/1/2008', '#activity#', '#form.indTarget#', '#form.commChannel#',
	'#form.numCommChannel#', '#numTarget#', #form.year#, '#form.month#')
	
	</cfquery>

	<cfset form.addActiveTarget EQ "">
	
<cfelseif  form.addActiveTarget EQ "delete">
<cfif isDefined("form.del") >
	<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="delActivityTarget">
	delete from DirEdActTarget
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
	insert into motivAct
	(userid, rptDate,activity, stakeholders, channel, commCount, impactCount, year2, month2)
	values
	('#activityInfo.userid#', '1/1/2008', '#activity#', '#form.stakeholders#', '#form.OrgcommChannel#',
	'#form.OrgnumCommChannel#', '#numTarget2#', #form.year#, '#form.month#')
	
	</cfquery>

	<cfset form.addActiveMotivation EQ "">
	
<cfelseif form.addActiveMotivation EQ "delete">
<cfif isDefined("form.delMotiv") >
	<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="delActivity">
	delete from motivAct
	where seq in (#form.delMotiv#)
	
	</cfquery>

</cfif>




</cfif>
</cfif>



<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="dispActivity">
	select activity, d.descrip as target,  c.descrip as channel, commCount, impactCount, a.seq
	from DirEdActTarget as a, govtdmakers as d, govtcommchannel as c
	where userid= '#activityInfo.userid#' 
	and activity = '#activity#'
	and month2='#form.month#'
	and a.year2 = #form.year#
	and d.year2=a.year2
	and c.year2=a.year2
	and a.target=d.num
	and a.channel=c.num
	order by 1, 2, 3
	
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="dispActivity2">
	select activity, s.descrip as stakeholders, c.descrip as channel, commCount, impactCount, m.seq
	from motivAct as m, govtAStake as s, govtcommChannel as C
	where userid= '#activityInfo.userid#' and activity = '#activity#'
	and month2='#form.month#'
	and m.year2 = #form.year#
	and m.year2=s.year2
	and m.year2=c.year2
	and m.stakeholders=s.num
	and m.channel=c.num
	order by 1, 2, 3
	
</cfquery>



<cfif pendStatus EQ "0">

<tr><td><a name="deat"></a><h3>Direct Education Activities and Targets</h3></td></tr>	
<tr><td><table  align="left" cellpadding="10" cellspacing="0" border="0" class="box">
<tr>
	<th>Individuals Targeted</th>
	<th>Communications Channel</th>
	<th>Number of Times that Communications Channel was Used</th>	
	<th>Number of Targeted Individuals Impacted or Attended</th>
</tr>
<tr>
	<th>
	
		<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="govtmakers">
	select
	descrip, num
	from govtdmakers
	where year2=#session.fy#
	order by
	rank
	</cfquery>
		<cfselect name="indTarget" query="govtmakers" display="descrip" value="num">
		</cfselect>
		
	</th>
	<th>
	<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="govtcommChannels">
	select
	descrip, head, num
	from govtcommchannel
	where year2=#session.fy#
	order by
	rank
	</cfquery>
		<select name="commChannel">
		<cfoutput query="govtcommChannels" group="head">
		<optgroup id="#head#" label="#head#">
		<cfoutput>
			<option value="#num#">#descrip#
		</cfoutput>
		</cfoutput>
		
		</select>
	</th>
	
	<th>
	<cfinput type="Text" name="numCommChannel" validate="integer" message="Please enter an integer value for Numbers">
	</th>
	
	<th>
	<cfinput type="Text" name="numTarget" validate="integer" message="Please enter an integer value for Numbers">
	</th>
</tr><tr>	<td align="left"><input type="Button" value="Add" onclick="addtarget('add');" class="AddButton"></td>
</tr>
<cfoutput>
<cfloop query="dispActivity">
<tr bgcolor="Silver">
	<td>#target#</td>
	<td>#channel#</td>
	<td align="center">#commCount#</td>
	<td align="center">#impactCount#</td>
	<td><input type="Checkbox" name="del" value="#seq#">Delete</td>
</tr>
</cfloop>
<tr><td colspan="5" align="left"><input type="Button" value="Delete" onclick="addtarget('delete');" class="DelButton"></td></tr>
</cfoutput>
</table></td></tr>





<tr><td><a name="amo"></a><h3>Activities to Motivate other Organizations</h3></td></tr>	
<tr><td><table  align="left" cellpadding="10" cellspacing="0" border="0" class="box">
<tr>
	<th>Stakeholders who can influence decision makers</th>
	<th>Communication channel</th>
	<th>Number of Times that Communications Channel was Used</th>	
	<th>Number of Organizations Impacted or Attended</th>
</tr>
<tr>
	<th>
		<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="govtAstake">
	select
	descrip, num
	from govtAstake
	where year2=#session.fy#
	order by
	rank
	</cfquery>
		<cfselect name="stakeholders" query="govtAstake" display="descrip" value="num">
		</cfselect>

	</th>
	<th>
		<!--- <cfquery datasource="#application.DataSource#"  		
		 
		password="#application.db_password#"   		
		username="#application.db_username#" name="govtAchannel">
		select
		descrip, num
		from govtAorgchannel
		where year2=#session.fy#
		order by
		rank
	</cfquery> --->
		<select name="OrgcommChannel">
		<cfoutput query="govtcommChannels" group="head">
		<optgroup id="#head#" label="#head#">
		<cfoutput>
			<option value="#num#">#descrip#
		</cfoutput>
		</cfoutput>
		
		</select>
		
		<!--- <cfselect name="OrgcommChannel" query="govtAchannel" value="num" display="descrip">
		</cfselect> --->
		
	</th>
	
	<th>
	<input type="Text" name="OrgnumCommChannel">
	</th>
	
	<th>
	<input type="Text" name="numTarget2">
	</th>
	</tr><tr>	<td align="left"><input type="Button" value="Add" onclick="addMotivation('add');" class="AddButton"></td>
</tr>
<cfoutput>
<cfloop query="dispActivity2">
<tr bgcolor="SILVER">
	<td>#stakeholders#</td>
	<td>#channel#</td>
	<td>#commCount#</td>
	<td>#impactCount#</td>
	<td><input type="Checkbox" name="delMotiv" value="#seq#">Delete</td>
</tr>
</cfloop>
<tr><td colspan="5" align="left"><input type="Button" value="Delete" onclick="addMotivation('delete');" class="DelButton"></td></tr>
</cfoutput>
</table></td></tr>


<!--- Promotion Popup --->
<!--- end promotion popup --->


<cfoutput>
<tr><td><table class="box">
<tr><th colspan="2">Impacts on Decision-makers this month</th></tr>
<tr><td><input type="Checkbox" name="cb1" value="1" <cfif isDefined("form.cb1") and form.cb1 EQ 1> checked</cfif>></td><td>Decision-maker commits to study the issue</td><td>Number:<input type="Text" name="cb1_text" <cfif isDefined("form.cb1_text")>value = "#form.cb1_text#"</cfif>></td></tr>
<tr><td><input type="Checkbox" name="cb2" value="1" <cfif isDefined("form.cb2") and form.cb2 EQ 1> checked</cfif>></td><td>Decision-maker commits to incorporate considerations<br> of public health impact into decision making</td><td>Number:<input type="Text" name="cb2_text" <cfif isDefined("form.cb2_text")>value = "#form.cb2_text#"</cfif>></td></tr>
<tr><td><input type="Checkbox" name="cb3" value="1" <cfif isDefined("form.cb3") and form.cb3 EQ 1> checked</cfif>></td><td>Decision-maker commits to protect the public health</td><td>Number:<input type="Text" name="cb3_text" <cfif isDefined("form.cb3_text")>value = "#form.cb3_text#"</cfif>></td></tr>
<tr><td><input type="Checkbox" name="cb4" value="1" <cfif isDefined("form.cb4") and form.cb4 EQ 1> checked</cfif>></td><td>Decision-maker refuses to change policy/practice </td><td>Number:<input type="Text" name="cb4_text" <cfif isDefined("form.cb4_text")>value = "#form.cb4_text#"</cfif>></td></tr>
<!--- <tr><td><input type="Checkbox" name="cb5" value="1" <cfif isDefined("form.cb5") and form.cb5 EQ 1> checked</cfif>>Decision-maker(s) commit to OPPOSE anti-tobacco position</td><td>Number:<input type="Text" name="cb5_text" <cfif isDefined("form.cb5_text")>value = "#form.cb5_text#"</cfif>></td></tr>--->
 </table></td></tr>
</cfoutput>
</cfif>
<cfinclude template="imp_pp_impl.cfm">
<!--- activity progress, successes, barriers, internal-training --->
<cfif pendStatus EQ "0">
<tr><td>&nbsp;</td></tr>
<cfinclude template="earnedM.cfm">
<tr><td>&nbsp;</td></tr>
<cfinclude template="tcpsust.cfm">
</cfif>
<cfinclude template="barriers.cfm">

