<cfoutput>
<input type="hidden" name="strategy" value="#activityInfo.strategy#"></cfoutput>
<cfif pendStatus EQ "0">

<input type="Hidden" name="provisionprocess" value="">
<script language="JavaScript">
function resubmit(){
document.monthlyActivity.action="monthlyActive.cfm?<cfoutput>#session.urltoken#</cfoutput>";
document.monthlyActivity.submit();
}

function setUpd(process){
document.monthlyActivity.provisionprocess.value=process;
resubmit();
}

function addRecord(process){

if(process=='DirAdvoc'){
var Counter=0;
for (k=0; k<document.monthlyActivity.advoc_target.length; k++){
      // If an element is selected, increment the counter
      if (document.monthlyActivity.advoc_target[k].selected == true){
         Counter++;
      }
   }
   // If the counter is greater than 3, display an alert message.
   if (Counter <1){
      alert("You must select at least one target!");
      return false;
}
Counter=0;
for (m=0; m<document.monthlyActivity.advoc_catchment.length; m++){
      // If an element is selected, increment the counter
      if (document.monthlyActivity.advoc_catchment[m].selected == true){
         Counter++;
      }
   }
   // If the counter is greater than 3, display an alert message.
   if (Counter <1){
      alert("You must select at least one county!");
      return false;
}
document.monthlyActivity.action="monthlyActive.cfm<cfoutput>?#session.urltoken#</cfoutput>#da";
}

if(process=='indirect'){
var Counter=0;
for (p=0; p<document.monthlyActivity.indirect_catchment.length; p++){
      // If an element is selected, increment the counter
      if (document.monthlyActivity.indirect_catchment[p].selected == true){
         Counter++;
      }
   }
   // If the counter is greater than 3, display an alert message.
   if (Counter <1){
      alert("You must select at least one county!");
      return false;
}
document.monthlyActivity.action="monthlyActive.cfm<cfoutput>?#session.urltoken#</cfoutput>#ia";
}
if(process=='miniGrant'){
document.monthlyActivity.action="monthlyActive.cfm#mg";
}
document.monthlyActivity.addrecord.value=process;
document.monthlyActivity.submit();
}

function delRecord(process){
document.monthlyActivity.delrecord.value=process;
if(process=='DirAdvoc'){document.monthlyActivity.action="monthlyActive.cfm<cfoutput>?#session.urltoken#</cfoutput>#da";}
if(process=='miniGrant'){document.monthlyActivity.action="monthlyActive.cfm<cfoutput>?#session.urltoken#</cfoutput>#mg";}
if(process=='indirect'){document.monthlyActivity.action="monthlyActive.cfm<cfoutput>?#session.urltoken#</cfoutput>#ia";}
document.monthlyActivity.submit();
}

function validate(){
if (ValidateDate(document.monthlyActivity.startDate.value)==false){return false;};
if (ValidateDate(document.monthlyActivity.endDate.value)==false){return false;};
if (ValidateCompareDate(document.monthlyActivity.startDate.value, document.monthlyActivity.endDate.value)==false){return false;};

return true;
}
</script>
<cfif isDefined("form.addrecord") and form.addrecord NEQ "">
<cfif form.addrecord EQ "DirAdvoc">
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="detail_advoc">
Insert into detail_dir_advoc
(advoc_target, advoc_method, advoc_catchment, advoc_num_method, advoc_num_impacted, userid, strategy, activity, month2, year2)
values
('#form.advoc_target#', '#form.advoc_method#','#form.advoc_catchment#',
'#form.advoc_num_method#',
'#form.advoc_num_impacted#', '#activityInfo.userid#', '#form.strategy#',
'#activity#', '#form.month#',#form.year#)
</cfquery>
</cfif>

<cfif form.addrecord EQ "miniGrant">
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="detail_mgrant">
Insert into m_grant
(userid, strategy, activity, month2, year2, name, fcollab, amt, summary)
values
('#activityInfo.userid#','#form.strategy#','#activity#', '#form.month#',#form.year#,
'#form.mf_name#', '#form.mf_collab#','#form.mf_amt#','#form.mf_summary#')
</cfquery>
</cfif>

<cfif form.addrecord EQ "training">
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="detail_training">
Insert into tech_assist
(userid, strategy, activity, month2, year2, num_targets, length, summary)
values
('#activityInfo.userid#','#form.strategy#','#activity#', '#form.month#',#form.year#,
'#form.train_target#', '#form.train_length#','#htmleditformat(form.train_overview)#')
</cfquery>
</cfif>

<cfif form.addrecord EQ "monitor">
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="detail_mon">
Insert into partner_mon
(userid, strategy, activity, month2, year2,  method, number <cfif isDefined("form.training_overview")>, summary</cfif>)
values
('#activityInfo.userid#','#form.strategy#','#activity#', '#form.month#',#form.year#,
'#form.surv_mon_method#', '#form.num_agency_surveyed#'<cfif isDefined("form.training_overview")>, '#form.training_overview#'</cfif>)
</cfquery>
</cfif>

<cfif form.addrecord EQ "indirect">
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="detail_indirect">
Insert into persuasion
(userid, strategy, activity, month2, year2,  target, method, county, num_method, num_target)
values
('#activityInfo.userid#','#form.strategy#','#activity#', '#form.month#',#form.year#,
'#form.indirect_target#', '#form.indirect_commun#', '#form.indirect_catchment#', '#form.indirect_num_method#', '#form.indirect_num_impacted#')
</cfquery>
</cfif>
</cfif>

<cfif isDefined("form.delrecord") and form.delrecord NEQ "">
<cfif form.delrecord EQ "DirAdvoc" and isDefined("form.del_advoc")>
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="delete_advoc">
delete from detail_dir_advoc
where userid = '#activityInfo.userid#'
and year2= #form.year#
and month2='#form.month#'
and seq in (#form.del_advoc#)
</cfquery>
</cfif>

<cfif form.delrecord EQ "miniGrant" and isDefined("form.delete_mg")>
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="delete_mg">
delete from m_grant
where userid = '#activityInfo.userid#'
and year2= #form.year#
and month2='#form.month#'
and seq in (#form.delete_mg#)
</cfquery>
</cfif>

<cfif form.delrecord EQ "training" and isDefined("form.del_train")>
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="delete_advoc">
delete from tech_assist
where userid = '#activityInfo.userid#'
and year2= #form.year#
and month2='#form.month#'
and seq in (#form.del_train#)
</cfquery>
</cfif>

<cfif form.delrecord EQ "monitor" and isDefined("form.del_mon")>
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="delete_mon">
delete from partner_mon
where userid = '#activityInfo.userid#'
and year2= #form.year#
and month2='#form.month#'
and seq in (#form.del_mon#)
</cfquery>
</cfif>

<cfif form.delrecord EQ "indirect" and isDefined("form.del_indirect")>
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="delete_indirect">
delete from persuasion
where userid = '#activityInfo.userid#'
and year2= #form.year#
and month2='#form.month#'
and seq in (#form.del_indirect#)
</cfquery>
</cfif>

</cfif>
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="advocValues">
	select
	reported, assess_survey, training, surveys,
	impact_study, impact_none, impact_change, impact_commit, impact_neg,
	num_study, num_change, num_commit, num_neg, impact_action, impact_action_txt, impact_imp, impact_imp_txt
	from advoc
	where userid = '#activityInfo.userid#'
	and activity = '#activity#'
	and month2='#form.month#'
	and year2 = #form.year#
	
</cfquery>

<cfif advocValues.recordcount GT 0 and cgi.http_referer DOES NOT CONTAIN "monthlyActive.cfm">
<cfset form.reported = advocValues.reported>
<cfset form.surveyval = advocValues.assess_survey>
<cfset form.train_bool = advocValues.training>
<cfset form.survey_bool = advocValues.surveys>
<cfif advocvalues.impact_study EQ "1"><cfset form.impact_study = advocValues.impact_study></cfif>
<cfif advocvalues.impact_none EQ "1"><cfset form.impact_none=advocValues.impact_none></cfif>
<cfif advocvalues.impact_change EQ "1"><cfset form.impact_change= advocValues.impact_change></cfif>
<cfif advocvalues.impact_commit EQ "1"><cfset form.impact_commit= advocValues.impact_commit></cfif>
<cfif advocvalues.impact_neg EQ "1"><cfset form.impact_neg= advocValues.impact_neg></cfif>

<cfif advocvalues.impact_action EQ "1"><cfset form.impact_action= advocValues.impact_action></cfif>
<cfif isDefined("advocvalues.impact_action_txt")><cfset form.impact_action_txt= advocValues.impact_action_txt></cfif>
<cfif advocvalues.impact_imp EQ "1"><cfset form.impact_imp= advocValues.impact_imp></cfif>
<cfif isDefined("advocvalues.impact_imp_txt")><cfset form.impact_imp_txt= advocValues.impact_imp_txt></cfif>

<cfset form.num_study= advocValues.num_study>
<cfset form.num_commit=advocValues.num_commit>
<cfset form.num_neg= advocValues.num_neg>
<cfset form.num_change= advocValues.num_change>

</cfif>
	

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="targetOrg">
	
	 
	select t.target 
	from targets as t, useractivities as u	
	where t.strategyNum = u.strategy
	and t.targetnum=u.targetgroup
	and u.userid = '#activityInfo.userid#'
	and u.activity = '#activity#'
	and u.year2=#session.fy#
	and u.year2=t.year2
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="CessPurpa">
	select purpose from useractivities where activity='#activity#'
	and userid = '#activityInfo.userid#'
	and year2=#session.fy#
	
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="CessPurp">	
select purpnum, descrip
from cess_purp as p, useractivities as u
where 
u.purpose is not null and
u.userid = '#activityInfo.userid#'
and u.activity = '#activity#'	
and  p.purpnum in (#cesspurpa.purpose#)
and u.targetgroup = p.targnum
and u.year2=#session.fy#
and u.year2=p.year2
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="level">
	
	
select l.descrip
from cess_level as l, useractivities as u
where 
u.purpose is not null and
u.userid ='#activityInfo.userid#'
and u.activity = '#activity#'	
and u.pollevel = l.num
and u.year2=#session.fy#
and u.year2=l.year2
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="countyheadache">
select catchment 
from contact
where userid = '#session.userid#'	

</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="counties">
	select CountyName, FIPS from counties
	where FIPS in<cfif isDefined("countyheadache.catchment")>(#valuelist(countyheadache.catchment)#)<cfelse>(0)</cfif> 
	order by 1	
</cfquery>
<cfoutput>
<tr><td>Target:&nbsp;&nbsp;#targetorg.target#</td></tr>
<cfloop query="cesspurp">
<tr><td>Purpose of Strategy:&nbsp;&nbsp;#descrip#</td></tr>
</cfloop>
<tr><td>Level at which change sought:&nbsp;&nbsp;#level.descrip#</td></tr>
<input type="Hidden" name="addrecord" value="">
<input type="Hidden" name="delrecord" value="">
<cfif activityInfo.strategy EQ "8">




<tr><td>Was a survey conducted initially to determine baseline status, and to identify those organizations "needing" change?</td></tr>
<tr><td>

<!--- <input type="hidden" name = "strategy" value="#activityInfo.strategy#"> --->
<input type="radio" name="surveyval" value="1" <cfif isDefined("form.surveyval") and form.surveyval EQ "1"> checked</cfif>>Yes&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" name="surveyval" value="0" <cfif (isDefined("form.surveyval") and form.surveyval EQ "0") or (NOT isDefined("form.surveyval"))> checked</cfif>>No</td></tr>
<tr><td> (If "yes", record this survey in Strategy Type ##5: Assessing / Monitoring)
</td></tr>
<cfelse> 

<tr><td>Was a survey conducted initially to determine baseline status, and to identify those organizations "needing" change?</td></tr>
<tr><td>
<input type="radio" name="surveyval" value="1" <cfif isDefined("form.surveyval") and form.surveyval EQ "1"> checked</cfif>>Yes&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" name="surveyval" value="0" <cfif (isDefined("form.surveyval") and form.surveyval EQ "0") or (NOT isDefined("form.surveyval"))> checked</cfif>>No
</td></tr>
<tr>
<td>If "yes", have you reported the results of this assessment?</td>
</tr>
<tr>
<td><input type="radio" name="reported" value="1" <cfif isDefined("form.reported") and form.reported EQ "1"> checked</cfif>>Yes&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="reported" value="0" <cfif isDefined("form.reported") and form.reported EQ "0"> checked></cfif>>No</td>
</tr>
</cfif>


<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="ad_methods">
select num, descrip
from cess_adv_method
where year2=#session.fy#
order by rank	
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="advoc_details">
select advoc_target as target, advoc_method as advocacy, advoc_catchment as counties, 
advoc_num_method as num_advoc, advoc_num_impacted as num_targets, seq
from detail_dir_advoc
where userid='#activityInfo.userid#'
and activity = '#activity#'
and month2='#form.month#'
and year2=#form.year#
order by seq	
</cfquery>


<tr><th colspan="2" align="left"><a name="da"></a>Direct Advocacy of target organization</th></tr> 
<!--- <tr><td colspan="2">
<table  align="left" cellpadding="10" cellspacing="0" border="0" class="box">
<tr>
	<th>Targets</th>
	<th>Advocacy Method</th>
	<th>County(ies) of residence/jurisdiction of target(s)</th>	
	<th>Number of that advocacy method used</th>
	<th>Number of targets impacted by method</th>
</tr>
<tr>
	<th>
		<cfselect name="advoc_target" multiple size="4" class="mlti">
			<cfloop query="cesspurp">
				<option value="#purpnum#">#descrip#
			</cfloop>
		</cfselect>
	</th>
	<th>
		<select name="advoc_method">
			<cfloop query="ad_methods">
				<option value="#num#">#descrip#
			</cfloop>
		</select>
	</th>
	
	<th>
		<!--- <cfinclude template="countysel.cfm"> --->
		<select name="advoc_catchment" multiple size="5"  class="mlti">
		<cfloop query="counties" >
			<option value="#FIPS#">#countyName#
		</cfloop>
			<option value="88888">Counties beyond catchment area
			<option value="99999">Distant from catchment area
		</select>
	</th>
	
	
	<th>
		<cfinput type="Text" size="6" name="advoc_num_method" validate="float" message="Please enter a valid number">
	</th>
	<th>
		<cfinput type="Text" size="6" name="advoc_num_impacted" validate="float" message="Please enter a valid number">
	</th>
	<td><input type="Button" value="Add ?" onclick="addRecord('DirAdvoc');"></td>
</tr>

<cfloop query="advoc_details">
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="counties2">
	select CountyName from counties
	where FIPS in<cfif counties NEQ "">(#counties#)<cfelse>(0)</cfif> 
	order by 1
	
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="advoc_targetdescrip">
	select descrip
	from cess_purp as p, useractivities as u
	where 
	u.purpose is not null and
	u.userid = '#activityInfo.userid#'
	and u.activity = '#activity#'	
	and u.targetgroup = p.targnum
	and p.purpnum=#target#
	and u.year2=#session.fy#
	and p.year2=u.year2
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="advoc_method_Descrip">
	select descrip
	from cess_adv_method
	where num=#advocacy#
	and year2=#session.fy#
	
</cfquery>

<tr bgcolor="Silver">
	<td>#advoc_targetdescrip.descrip#</td>
	<td>#advoc_method_Descrip.descrip#</td>
	<td>#valuelist(counties2.CountyName)#</td>
	<td>#num_advoc#</td>
	<td>#num_targets#</td>
	<td><input type="Checkbox" name="del_advoc" value="#seq#">Delete</td>
</tr>
</cfloop>
<tr><td colspan="4"></td><td><input type="Button" value="Delete" onclick="delRecord('DirAdvoc');"></td></tr>
 
</table></td></tr>
<cfif valuelist(advoc_details.advocacy) CONTAINS "7">
<tr><td colspan="2"><a name="mg"></a><strong>If mini-grant funding:</strong></td></tr>
<tr><td colspan="2"><table class="box">
<tr>
<th>Mini-grant program name</th>
<th>Funded collaborator</th>
<th>Dollar ammount of award</th>
<th>Summary of funded Program</th>
</tr>
<tr>
<th><input type="text" name="mf_name"></th>
<th><input type="text" name="mf_collab"></th>
<th><input type="text" name="mf_amt"></th>
<th><textarea name="mf_summary" cols="30" rows="4"></textarea></th>
<td><input type="Button" value="Add ?" onclick="addRecord('miniGrant');"></td></tr>


<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="mg_details">
select name, fcollab, amt, summary, seq
from m_grant
where userid = '#activityInfo.userid#'
and year2= #form.year#
and month2='#form.month#'
</cfquery>
<cfloop query="mg_details">
<tr bgcolor="Silver">
	<td>#name#</td>
	<td>#fcollab#</td>
	<td>#amt#</td>
	<td>#summary#</td>
	<td><input type="Checkbox" name="delete_mg" value="#seq#">Delete</td>
</tr>
</cfloop>
<tr><td colspan="4"></td><td><input type="Button" value="Delete" onclick="delRecord('miniGrant');"></td></tr>
 




</table></td></tr> --->







<tr><td colspan="2">
<table  align="left" cellpadding="10" cellspacing="0" border="0" class="box">
<tr>
	<th align="left">Purpose of Strategy</th>
	<th align="left">
		<cfselect name="advoc_target" multiple size="4" class="mlti">
			<cfloop query="cesspurp">
				<option value="#purpnum#">#descrip#
			</cfloop>
		</cfselect>
	</th>
</tr>
<tr>
	<th align="left">Advocacy Method</th>
	<th align="left">
		<select name="advoc_method">
			<cfloop query="ad_methods">
				<option value="#num#">#descrip#
			</cfloop>
		</select>
	</th>
</tr>
<tr>
	<th align="left">County(ies) of residence/jurisdiction<br>of target(s)</th>
	<th align="left">
		<!--- <cfinclude template="countysel.cfm"> --->
		<select name="advoc_catchment" multiple size="5"  class="mlti">
		<cfloop query="counties" >
			<option value="#FIPS#">#countyName#
		</cfloop>
			<option value="88888">Counties beyond catchment area
			<option value="99999">Distant from catchment area
		</select>
	</th>
</tr>	
<tr>
	<th align="left">Number of that advocacy method used</th>
	<th align="left">
		<cfinput type="Text" size="6" name="advoc_num_method" validate="float" message="Please enter a valid number">
	</th>
</tr>
<tr>
	<th align="left">Number of targets impacted by method</th>
	<th align="left">
		<cfinput type="Text" size="6" name="advoc_num_impacted" validate="float" message="Please enter a valid number">
	</th>	
</tr>
<tr>
	<td colspan="2"><input type="Button" value="Add" onclick="addRecord('DirAdvoc');" class="AddButton"></td>
</tr>

<tr>
	<td colspan="2">
		<table class="boxg">
		
		
<cfloop query="advoc_details">
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="counties2">
	select CountyName from counties
	where FIPS in<cfif counties NEQ "">(#counties#)<cfelse>(0)</cfif> 
	order by 1
	
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="advoc_targetdescrip">
	select descrip
	from cess_purp as p, useractivities as u
	where 
	u.purpose is not null and
	u.userid = '#activityInfo.userid#'
	and u.activity = '#activity#'	
	and u.targetgroup = p.targnum
	and p.purpnum in (#target#)
	and u.year2=#session.fy#
	and p.year2=u.year2
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="advoc_method_Descrip">
	select descrip
	from cess_adv_method
	where num=#advocacy#
	and year2=#session.fy#
	
</cfquery>


	<tr><td>Targets</td><td>#valuelist(advoc_targetdescrip.descrip, '<br>')#</td><td><input type="Checkbox" name="del_advoc" value="#seq#">Delete</td></tr>
	<tr><td>Advocacy Method</td><td>#advoc_method_Descrip.descrip#</td></tr>
	<tr><td>Counties</td><td>#valuelist(counties2.CountyName)#</td></tr>
	<tr><td>Number of that advocacy method used</td><td>#num_advoc#</td></tr>
	<tr><td>Number of targets impacted by method</td><td>#num_targets#</td></tr>
	<tr><td>&nbsp;</td></tr>

</cfloop>
<cfif advoc_details.recordcount GTE 1>
	<tr><td colspan="4"></td><td><input type="Button" value="Delete" onclick="delRecord('DirAdvoc');" class="DelButton"></td></tr>
</cfif>
		</table>
	</td>
</tr>

 
</table></td></tr>
<cfif ListFind(valuelist(advoc_details.advocacy),"7")>
<tr><td colspan="2"><a name="mg"></a><strong>If mini-grant funding:</strong></td></tr>
<tr><td colspan="2"><table class="box" cellspacing="0">
<tr>
<th>Mini-grant program name</th>
<th>Funded collaborator</th>
<th>Dollar ammount of award</th>
<th>Summary of funded Program</th>
</tr>
<tr>
<th><input type="text" name="mf_name"></th>
<th><input type="text" name="mf_collab"></th>
<th><input type="text" name="mf_amt"></th>
<th><textarea name="mf_summary" cols="30" rows="4"></textarea></th>
<td><input type="Button" value="Add" onclick="addRecord('miniGrant');" class="AddButton"></td></tr>


<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="mg_details">
select name, fcollab, amt, summary, seq
from m_grant
where userid = '#activityInfo.userid#'
and year2= #form.year#
and month2='#form.month#'
</cfquery>
<cfloop query="mg_details">
<tr bgcolor="Silver">
	<td>#name#</td>
	<td>#fcollab#</td>
	<td>#amt#</td>
	<td>#summary#</td>
	<td><input type="Checkbox" name="delete_mg" value="#seq#">Delete</td>
</tr>
</cfloop>
<cfif mg_details.recordcount GTE 1>
<tr><td colspan="4"></td><td><input type="Button" value="Delete" onclick="delRecord('miniGrant');" class="DelButton"></td></tr>
</cfif>
</table></td></tr>
</cfif>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="cess_targets">
	select descrip, num
	from cess_targets
	where year2=#session.fy#
	order by rank
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="cess_commun">
	select descrip, num
	from cess_commun
	where year2=#session.fy#
	order by rank
</cfquery>
<tr><th colspan="2" align="left"><a name="ia"></a>Indirect advocacy of organizational decision makers by motivating other organizations to pursuade</th></tr>
<tr><td colspan="2">
<table align="left" cellpadding="10" cellspacing="0" border="0" class="box">
<tr>
	<th>Targets</th>
	<th>
		<select name="indirect_target">
		<cfloop query="cess_targets">
			<option value="#num#">#descrip#
		</cfloop>
		</select>
	</th>
</tr>
<tr>
	<th>Method of communication<br>with other organizations</th>
	<th>
		<select name="indirect_commun">
		<cfloop query="cess_commun">
			<option value="#num#">#descrip#
		</cfloop>
		</select>
	</th>
</tr>
<tr>
	<th>County(ies) of<br>residence/jurisdiction<br>of target(s)</th>
	<th>
		<!--- <cfinclude template="countysel.cfm"> --->
		<select name="indirect_catchment" multiple size="5"  class="mlti">
		<cfloop query="counties" >
			<option value="#FIPS#">#countyName#
		</cfloop>
			<option value="88888">Counties beyond catchment area
			<option value="99999">Distant from catchment area
		</select>
	</th>
</tr>
<tr>
	<th>Number of that <br>communication method<br>used</th>
	<th>
		<cfinput type="Text" size="6" name="indirect_num_method" validate="float" message="Please enter a valid number">
	</th>
</tr>
<tr>
	<th>Number of<br>organizational targets</th>
	<th>
		<cfinput type="Text" size="6" name="indirect_num_impacted" validate="float" message="Please enter a valid number">
	</th>
</tr>
<tr>
	<td colspan="2"><input type="Button" value="Add" onclick="addRecord('indirect');"  class="AddButton"></td>
</tr>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="indirect_details">
	select target, method as method2, county, num_method, num_target, seq
	from persuasion
	where userid='#activityInfo.userid#'
	and activity = '#activity#'
	and month2='#form.month#'
	and year2=#form.year#
	order by seq	
	 
	
</cfquery>



<tr>
	<td colspan="2">
		<table class="boxg">
<cfloop query="indirect_details">
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="counties3">
	select CountyName from counties
	where FIPS in <cfif county NEQ "">(#county#)<cfelse>(0)</cfif> 
	order by 1
	
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="indirect_targetdescrip">
	select descrip
	from cess_targets
	where 
	num=#target#
	and year2=#session.fy#
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="indirect_method_Descrip">
	select descrip
	from cess_commun
	where num=#method2#
	and year2=#session.fy#
	
</cfquery>


	<tr><td>Targets</td><td>#indirect_targetdescrip.descrip#</td><td><input type="Checkbox" name="del_indirect" value="#seq#">Delete</td></tr>
	<tr><td>Method of communication</td><td>#indirect_method_Descrip.descrip#</td></tr>
	<tr><td>County(ies)</td><td>#valuelist(counties3.CountyName)#</td></tr>
	<tr><td>Number of that communication method used</td><td>#num_method#</td></tr>
	<tr><td>Number of organizational targets</td><td>#num_target#</td></tr>
	<tr><td>&nbsp;</td></tr>
	

</cfloop>
<cfif indirect_details.recordcount GTE 1>
<tr><td colspan="4"></td><td><input type="Button" value="Delete" onclick="delRecord('indirect');" class="DelButton"></td></tr>
</cfif>
		</table>
	</td>
</tr>


</table></td></tr>

<tr><td colspan="2"><table class="box">
<tr><td>Impacts on Decision-makers this month:</td><td>Number</td></tr>

<tr><td><input type="Checkbox" value="1" name="impact_study" <cfif isDefined("form.impact_study") and form.impact_study EQ "1"> checked</cfif>>Decision-maker(s) commit to study issues</td><td><input type="Text" name="num_study" size="3" <cfif isDefined("num_study")>value="#num_study#"</cfif>></td></tr>
<tr><td><input type="Checkbox" value="1" name="impact_change" <cfif isDefined("form.impact_change") and form.impact_change EQ "1"> checked</cfif>>Decision-maker(s) commit to change or implement policy/practice</td><td><input type="Text" name="num_change" size="3" <cfif isDefined("num_change")>value="#num_change#"</cfif>></td></tr>

<tr><td><input type="Checkbox" value="1" name="impact_commit" <cfif isDefined("form.impact_commit") and form.impact_commit EQ "1"> checked</cfif>>Decision-maker(s) commit to expand or strengthen existing policy/practice</td><td><input type="Text" name="num_commit" size="3" <cfif isDefined("num_commit")>value="#num_commit#"</cfif>></td></tr>
<tr><td><input type="Checkbox" value="1" name="impact_neg" <cfif isDefined("form.impact_neg") and form.impact_neg EQ "1"> checked</cfif>><!--- <cfif activityInfo.strategy EQ "8"> --->Decision-maker(s) refuse to change policy/practice in desired direction
<!--- <cfelse>
decision-maker(s) states s/he will vote negative on the proposed change
</cfif> --->
</td><td><input type="Text" name="num_neg" size="3" <cfif isDefined("num_neg")>value="#num_neg#"</cfif>></td></tr>
<tr><td><input type="Checkbox"  value="1" name="impact_none" <cfif isDefined("form.impact_none") and form.impact_none EQ "1"> checked</cfif>>None at this time</td></tr>
</table></td></tr>

<tr><td colspan="2">
<!--- <cfif activityInfo.strategy EQ "8"> --->
Was technical-assistance provided to those organizations after they decided to implement an improved policy or practice this month?
<!--- <cfelse>
Was training or technical-assistance, or other collaboration, provided to those agencies.companies/industries/schools which has decided to implement an improves policy/program/practice (training or T-A either by the Partner, or facilitated by the Partner)?
</cfif> --->
</td></tr>
<tr>
	<td>
		<input type="radio" name="train_bool" value="1" <cfif isDefined("form.train_bool") and form.train_bool EQ "1"> checked</cfif> onclick="resubmit();">Yes&nbsp;&nbsp;&nbsp;
		<input type="radio" name="train_bool" value="0" <cfif (isDefined("form.train_bool") and form.train_bool EQ "0") OR NOT isDefined("form.train_bool")> checked</cfif> onclick="resubmit();">No
	</td>
</tr>
<cfif isDefined("form.train_bool") and form.train_bool EQ "1">
<tr><td colspan="2"><table class = "box">
<tr>
	<th>## of targets receiving<br>T-A or training?</th>
	<th>Average length of<br>TA/Training session<br>(hours)</th>
	<th>Overview of<br>TA or Training</th>
</tr>
<tr>
	<th valign="top"><cfinput type="Text" name="train_target" maxlength="180"  validate="float" message="Please enter a valid number of targets"></th>
	<th valign="top"><cfinput type="Text" name="train_length" maxlength="180"></th>
	<th valign="top"><textarea name="train_overview" cols="30" rows="4"></textarea></th>
	<td valign="top"><input type="Button" value="Add" onclick="addRecord('training');" class="AddButton"></td>
</tr>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="train_details">
select num_targets, length, summary, seq
from tech_assist
where userid = '#activityInfo.userid#'
and year2= #form.year#
and month2='#form.month#'
</cfquery>
<cfloop query="train_details">
<tr bgcolor="silver">
	<td>#num_targets#</td>
	<td>#length#</td>
	<td>#summary#</td>
	<td><input type="Checkbox" name="del_train" value="#seq#">Delete</td>
</tr>
</cfloop>
<tr><td colspan="4" align="right"><input type="Button" value="Delete" onclick="delRecord('training');" class="DelButton"></td></tr>
 
</table></td></tr>
</cfif>

<tr><td colspan="2">
<!--- <cfif activityInfo.strategy EQ "8"> --->
Did Partner monitor or conduct surveys to determine the extent to which organizations were implementing the improved policies or practices?
<!--- <cfelse>
Did Partner monitor or conduct surveys to determine the extent to which agencies/companies/industries/schools
that has said they were implementing improved policies/programs/practice ... were, in fact, doing so?
</cfif> --->
</td></tr>
<tr>
	<td>
		<input type="radio" name="survey_bool" value="1" <cfif isDefined("form.survey_bool") and form.survey_bool EQ "1"> checked</cfif> onClick="resubmit();">Yes&nbsp;&nbsp;&nbsp;
		<input type="radio" name="survey_bool" value="0" <cfif (isDefined("form.survey_bool") and form.survey_bool EQ "0") OR NOT isDefined("form.survey_bool")> checked</cfif> onClick="resubmit();">No
	</td>
</tr>
<cfif isDefined("form.survey_bool") and form.survey_bool EQ "1">
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="survey_mon">
	select num,descrip
	from cess_surv_mon
	where year2=#session.fy#
	order by rank
	
</cfquery>

<tr><td colspan="2">
<table  align="left" cellpadding="10" cellspacing="0" border="0" class="box">
<tr>
<th>Survey/monitoring method</th>
<th>## of organizations<br>monitored/surveyed</th>
<!--- <cfif activityInfo.strategy EQ "9"><th>Overview of TA or Training</th></cfif> --->
<!--- <th>Overview of TA or Training</th> --->
</tr>
<tr>
<th>
	<select name="surv_mon_method">
		<cfloop query="survey_mon">
			<option value="#num#">#descrip#
		</cfloop>
	</select>
</th>
<th><input type="text" name="num_agency_surveyed"></th>
<!--- <cfif activityInfo.strategy EQ "9"><th><textarea name="training_overview" cols="30" rows="4"></textarea></th></cfif> --->
<!--- <th><textarea name="training_overview" cols="30" rows="4"></textarea></th> --->
<td><input type="Button" value="Add" onclick="addRecord('monitor');" class="AddButton"></td></tr>
</tr>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="mon_details">
<!--- select method, number, summary, seq
from partner_mon
where userid = '#session.userid#'
and year2= #form.year#
and month2='#form.month#' --->

select c.descrip, u.number, u.summary, u.seq
from partner_mon as u, cess_surv_mon as c
where userid = '#activityInfo.userid#'
and u.year2= #form.year#
and u.year2=c.year2
and month2='#form.month#'
and c.num = u.method
and activity = '#activity#'
</cfquery>
<cfloop query="mon_details">
<tr>
	<td>#descrip#</td>
	<td>#number#</td>
<!--- 	<td>#summary#</td> --->
	<td><input type="Checkbox" name="del_mon" value="#seq#">Delete</td>
</tr>
</cfloop>
<tr><td colspan="4"></td><td><input type="Button" value="Delete" onclick="delRecord('monitor');" class="DelButton"></td></tr>
 
</table></td></tr>

</cfif>
<cfinclude template="imp_pp_impl.cfm">

</cfoutput>
</cfif>
<cfif pendStatus EQ "0">
<tr><td>&nbsp;</td></tr>
<cfinclude template="earnedM.cfm">
<tr><td>&nbsp;</td></tr>
<cfinclude template="tcpsust.cfm">
</cfif>
<cfinclude template="barriers.cfm">



<!--- <cfif activityInfo.targetgroup EQ "1">
	<input type="hidden" name="activityProgress" value="NA">
	<input type="hidden" name="successes" value="NA">
	<input type="hidden" name="barriers" value="NA">
	<cfinclude template="earnedM.cfm">
<cfelse>
	<cfinclude template="barriers.cfm">
		<cfif pendStatus EQ "0">
		<tr><td>&nbsp;</td></tr>
			
		</cfif>
</cfif> --->