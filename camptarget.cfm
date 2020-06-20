
<script language="JavaScript">
var sPath = window.location.pathname;
//var sPage = sPath.substring(sPath.lastIndexOf('\\') + 1);
var sPage = sPath.substring(sPath.lastIndexOf('/') + 1);



function addcTarg(value){
if (value== 'Add' && document.Form1.p_target_aud.selectedIndex==0){
alert("Please select at least a primary target");
return false;
}
document.Form1.action=sPage+'<cfoutput>?#session.urltoken#</cfoutput>#taud';
document.Form1.prc_targ_aud.value=value;
document.Form1.submit();
}

function checkStrategy(){
if (typeof(document.Form1.activityName)!="undefined"){
if (document.Form1.activityName.value==""){
alert("Please name this strategy before assigning targets");
return false;
}
}
if (typeof(document.Form1.colStrat)!="undefined"){
if (document.Form1.colStrat.value==""){
alert("Please name this strategy before assigning targets");
return false;
}
}
addcTarg('Add');
}



</script>
<cfif isDefined("form.prc_targ_aud") and form.prc_targ_aud EQ "Add">
<cfif isDefined("form.p_target_aud") and form.p_target_aud NEQ "">
<cfset str_target = form.p_target_aud>
 <cfif form.s_target_aud NEQ "">
<cfset str_target = str_target & ',' & form.s_target_aud>
</cfif>
<cfif form.t_target_aud NEQ "">
<cfset str_target = str_target & ',' & form.t_target_aud>
</cfif> 
</cfif>


<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="insert_targets">
	insert into strat_campaignTarget
	(userid,activity,target, year2)
	values
	<cfif isDefined("form.activityName") and (left(form.activityName,1) NEQ "*")>('#session.userid#','#form.activityName#','#str_target#', #session.fy#)
	<cfelseif isDefined("form.activityName")>('SHARED','#form.activityName#','#str_target#', #session.fy#)
	<cfelseif isDefined("form.colStrat")>('SHARED','#form.colStrat#','#str_target#', #session.fy#)
	</cfif>
	
	
	
	
</cfquery>

<cfelseif isDefined("form.prc_targ_aud") and form.prc_targ_aud EQ "Del" and isDefined("form.del_target_seq")>
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="delete_targets">
	update strat_campaignTarget
	set del =1 where 
	<!--- userid='#session.userid#' and 
	activity='#form.activityName#'
	and ---> 
	seq in (#form.del_target_seq#)
	and year2=#session.fy#
</cfquery>

</cfif>

<input type="Hidden" name="prc_targ_aud" value="">
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="campaign_targets">
	select head, descrip, num
	from campaignTarget
	where year2=#session.fy#
	and (del is null or del = 0)
	order by groupNum, rank	
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="strat_campaign_targets">
	select target, seq
	from strat_campaignTarget
	where 
	<cfif isDefined("form.activityName") and (left(form.activityName,1) NEQ "*")>(userid='#session.userid#' and activity = '#form.activityName#')
	<cfelseif isDefined("form.activityName")>(userid='SHARED' and activity = '#form.activityName#')
	<cfelseif isDefined("form.colStrat")>(userid='SHARED' and activity = '#form.colStrat#')
	</cfif>
	and year2=#session.fy#
	and (del is null or del !=1)
	order by seq	
</cfquery>
<table class="box" cellspacing="0">
<tr><th colspan="2" align="left"><a name="taud"></a>Target Audience:</th></tr>
<tr>
	<th>Target Characteristic</th>
	 <cfif session.fy LT 2009>
	 	<th>Additional Target Characteristic</th>
		<th>Additional Target Characteristic</th>
	</cfif>
</tr>
<tr>
	<td>
	<select name="p_target_aud">
		<optgroup id="" label="">
			<option value ="">-select a target characteristic-
		</optgroup>
	<cfoutput query="campaign_targets" group="head">
		<optgroup id="#head#" label="#head#">
			<cfoutput>
				<option value="#num#">#descrip#
			</cfoutput>
		</optgroup>
	</cfoutput>	
	</select>
	</td>
	<cfif session.fy LT 2009>
	<td>
	<select name="s_target_aud">
		<optgroup id="" label="">
			<option value ="">-select a target characteristic (if applicable)-
		</optgroup>
	<cfoutput query="campaign_targets" group="head">
		<optgroup id="#head#" label="#head#">
			<cfoutput>
				<option value="#num#">#descrip#
			</cfoutput>
		</optgroup>
	</cfoutput>	
	</select>
	</td>
	<td>
	<select name="t_target_aud">
		<optgroup id="" label="">
			<option value ="">-select a target characteristic (if applicable)-
		</optgroup>
	<cfoutput query="campaign_targets" group="head">
		<optgroup id="#head#" label="#head#">
			<cfoutput>
				<option value="#num#">#descrip#
			</cfoutput>
		</optgroup>
	</cfoutput>	
	</select>
	</td>
	<cfelse>
		<input type="hidden" name="s_target_aud" value="">
		<input type="hidden" name="t_target_aud" value="">
	</cfif>
	</tr><tr><td align="left">
		<input type="Button" name="addcamptarget" value="Add" onClick="checkStrategy();" class="AddButton">
	</td>
</tr>
<cfif strat_campaign_targets.recordcount GT 0>

<cfoutput>
<cfloop query="strat_campaign_targets">
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="detail_targets">
	select descrip
	from campaignTarget
	where 
	num in (#target#)	
	and year2=#session.fy#
</cfquery>
<tr>
	<td colspan="2" bgcolor="Silver">Target Audience #CurrentRow#: #valuelist(detail_targets.descrip,', ')#</td>
	<td bgcolor="Silver"><input type="Checkbox" name="del_target_seq" value="#seq#">Del</td>
</tr>
</cfloop>
</cfoutput>
<tr><td align="left"><input type="Button"  value="Delete" onclick="addcTarg('Del');" class="DelButton"></td></tr>
<cfelse>
	<input type="Hidden" name="hasNoTarget" value="">
</cfif>


</table>

