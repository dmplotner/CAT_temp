<cfif pendStatus EQ "0">
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="dispForum">
	select 
	userid,
activity,
month2,
year2,
status,
revstart,
revend,
note,
progress,
success,
barriers,
earnedMedia,
collaborators,
intTrain,
numberTrained,
hoursTrained,
statewide,
format,
setting,
series,
numEvents,
countyEvent,
eventT,
commFocus,
target,
countyTarget,
num, promotion, seq

	from forum
	where userid = '#activityInfo.userid#'
	and activity = '#activity#'
	and month2='#form.month#'
	and year2 = #form.year#
	
</cfquery>

<cfif dispForum.recordcount GT 0 and cgi.http_referer DOES NOT CONTAIN "monthlyActive.cfm">
	<cfset form.format = dispForum.format>
	<cfset form.setting = dispForum.setting>
	<cfset form.series = dispForum.series>
	<cfset form.numEvents = dispForum.numEvents>
	<cfset form.countyEvent = dispForum.countyEvent>
	<cfset form.eventT = dispForum.eventT>
	<cfset form.commfocus = dispForum.commfocus>
	<cfset form.target = dispForum.target>
	<cfset form.countyTarget = dispForum.countyTarget>
	<cfset form.num = dispForum.num>
	<cfset form.promotion = dispForum.promotion>
	<cfset form.seq2 = dispForum.seq>
	
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
	username="#application.db_username#" name="counties">
	select CountyName, FIPS from counties
	where FIPS in<cfif isDefined("countyheadache.catchment")>(#valuelist(countyheadache.catchment)#)<cfelse>(0)</cfif> 
	order by 1
	
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qformats">
	select descr, num
	from LU_forum_format
	where year2=#form.year#
	order by rank
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qsettings">
	select descr, num
	from LU_forum_setting
	where year2=#form.year#
	order by rank
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qfocus">
	select descr, num
	from LU_forum_focus
	where year2=#form.year#
	order by rank
</cfquery>
<script language="JavaScript">
function reloadpage(targ){
document.monthlyActivity.action="monthlyActive.cfm<cfoutput>?#session.urltoken#</cfoutput>#"+targ;
document.monthlyActivity.submit();
}

function validate(){
if (ValidateDate(document.monthlyActivity.startDate.value)==false){return false;};
if (ValidateDate(document.monthlyActivity.endDate.value)==false){return false;};
if (ValidateCompareDate(document.monthlyActivity.startDate.value, document.monthlyActivity.endDate.value)==false){return false;};

{
var Counter=0;
for (i=0; i<document.monthlyActivity.setting.length; i++){
      // If an element is selected, increment the counter
      if (document.monthlyActivity.setting[i].selected == true){
         Counter++;
      }
   }
   // If the counter is greater than 3, display an alert message.
   if (Counter <1){
      alert("You must select at least one event setting!");
      return false;
}}
{
Counter=0;
for (j=0; j<document.monthlyActivity.countyEvent.length; j++){
      // If an element is selected, increment the counter
      if (document.monthlyActivity.countyEvent[j].selected == true){
         Counter++;
      }
   }
   // If the counter is greater than 3, display an alert message.
   if (Counter <1){
      alert("You must select at least one County of target audience!");
      return false;
}}
{
Counter=0;
for (k=0; k<document.monthlyActivity.commFocus.length; k++){
      // If an element is selected, increment the counter
      if (document.monthlyActivity.commFocus[k].selected == true){
         Counter++;
      }
   }
   // If the counter is greater than 3, display an alert message.
   if (Counter <1){
      alert("You must select at least one Focus of tobacco Communication!");
      return false;
}}
{
Counter=0;
for (m=0; m<document.monthlyActivity.target.length; m++){
      // If an element is selected, increment the counter
      if (document.monthlyActivity.target[m].selected == true){
         Counter++;
      }
   }
   // If the counter is greater than 3, display an alert message.
   if (Counter <1){
      alert("You must select at least one Target Audience!");
      return false;
}}
return true;
}
</script>


<tr><td>Event Description</td></tr>
<tr><td colspan="2"><table class="box" border="0">
<tr><td>Event Format:</td>
<td>
<select name="format" multiple size="4" class="mlti">
<cfoutput>
	<cfloop query="Qformats">
		<option value="#num#" <cfif isDefined("form.format") and listfind(form.format,num)>selected</cfif>>#descr#
	</cfloop>
</cfoutput>

<!--- <option value="2" <cfif isDefined("form.format") and form.format CONTAINS "2">selected</cfif>>panel discussion
<option value="3" <cfif isDefined("form.format") and form.format CONTAINS "3">selected</cfif>>specific workshops
<option value="4" <cfif isDefined("form.format") and form.format CONTAINS "4">selected</cfif>>presentations
<!--- <option value="5" <cfif isDefined("form.format") and form.format CONTAINS "5">selected</cfif>>announcements to observers --->
<option value="6" <cfif isDefined("form.format") and form.format CONTAINS "6">selected</cfif>>information dissemination-focused
<option value="7" <cfif isDefined("form.format") and form.format CONTAINS "7">selected</cfif>>Stomp --->
</select>
</td></tr>

<tr><td>Event Setting:</td>
<td>
<select name="setting" multiple size="4" class="mlti">
<cfoutput>
	<cfloop query="Qsettings">
		<option value="#num#" <cfif isDefined("form.setting") and listfind(form.setting,num)>selected</cfif>>#descr#
	</cfloop>
</cfoutput>

<!--- <option value="2" <cfif isDefined("form.setting") and form.setting CONTAINS "2">selected</cfif>>school (K-12)
<option value="3" <cfif isDefined("form.setting") and form.setting CONTAINS "3">selected</cfif>>school (higher Ed)
<option value="4" <cfif isDefined("form.setting") and form.setting CONTAINS "4">selected</cfif>>movie theater
<option value="5" <cfif isDefined("form.setting") and form.setting CONTAINS "5">selected</cfif>>business org meeting
<option value="6" <cfif isDefined("form.setting") and form.setting CONTAINS "6">selected</cfif>>workplace
<option value="7" <cfif isDefined("form.setting") and form.setting CONTAINS "7">selected</cfif>>health fair--->
</select>
</td></tr>

<tr><td>Series? </td><td>
<input type="Radio" name="series" value="1"  onclick="reloadpage();" <cfif isDefined("form.series") and form.series EQ "1"> checked</cfif>>Yes&nbsp;&nbsp;&nbsp;
<input type="Radio" name="series" value="0" onclick="reloadpage();" <cfif (isDefined("form.series") and form.series EQ "0") OR Not isDefined("form.series")> checked</cfif>>No

</td>

</tr>
<cfif isDefined("form.series") and form.series EQ "1">
<tr>
<td>Number of events in series held this month:</td>
<td>
<!--- 	<input type="Text" name="numEvents" size="6"<cfif isDefined("form.numEvents")> value="<cfoutput>#form.numEvents#</cfoutput>"</cfif>> --->
	<cfif isDefined("form.numEvents")>
		<cfinput type="Text" name="numEvents" size="6"  value="#form.numEvents#"  validate="integer" message="Please enter a valid integer for your number of events">
	<cfelse>
		<cfinput type="Text" name="numEvents" size="6" validate="integer" message="Please enter a valid integer for your number of events">
	</cfif>
</td>
</tr>
</cfif>
<tr>
<td>County(ies) of target audience:</td>
<td><select name="countyEvent" multiple size="4" class="mlti">
<cfoutput>
<cfloop query="counties">
<option  value= "#FIPS#"<cfif isDefined("form.countyEvent") and listfind(form.countyEvent,FIPS)> selected</cfif>>#countyName#
</cfloop>

	<option value="88888"<cfif isDefined("form.countyEvent") and listfind(form.countyEvent,"88888")> selected</cfif>>Counties beyond catchment area
	<option value="99999"<cfif isDefined("form.countyEvent") and listfind(form.countyEvent,"88888")> selected</cfif>>Distant from catchment area
</cfoutput>
</select> </td>
</tr>

<tr>
<td>Tobacco Related Event?</td><td><input type="Radio" name="eventT" value="1"<cfif (isDefined("form.eventT") and form.eventT EQ "1") OR Not isDefined("form.eventT")> checked</cfif>>Tobacco Related Event?</td>
<td><input type="Radio" name="eventT" value="2"<cfif (isDefined("form.eventT") and form.eventT EQ "2")> checked</cfif>>Non-Tobacco Related Event?	   <A HREF="javascript:void(0)"onclick="window.open('<cfoutput>#application.basename#</cfoutput>/dictionary.cfm#ntre','_blank','height=500, width=700,scrollbars=yes')"><img SRC="images/book07.gif"  width="20" height="20" BORDER="0" ALT="Help"></a></td>
</tr>

<tr>
<td>Focus of tobacco Communication:</td>
<td><select name="commFocus" multiple class="mlti">
<cfoutput>
	<cfloop query="Qfocus">
		<option value="#num#"<cfif isDefined("form.commFocus") and listfind(form.commFocus,num)> selected</cfif>>#descr#
	</cfloop>
</cfoutput>

<!--- <option value="2"<cfif isDefined("form.commFocus") and form.commFocus CONTAINS "2"> selected</cfif>>Pro-CIA expansion
<option value="3"<cfif isDefined("form.commFocus") and form.commFocus CONTAINS "3"> selected</cfif>>Tobacco industry tactics
<option value="4"<cfif isDefined("form.commFocus") and form.commFocus CONTAINS "4"> selected</cfif>>Pro increase excise tax
<option value="5"<cfif isDefined("form.commFocus") and form.commFocus CONTAINS "5"> selected</cfif>>Smoke-free homes and vehicles
<option value="6"<cfif isDefined("form.commFocus") and form.commFocus CONTAINS "6"> selected</cfif>>Tobacco-free school campuses
<option value="7"<cfif isDefined("form.commFocus") and form.commFocus CONTAINS "7"> selected</cfif>>Tobacco use in movies/arts/entertainment
<option value="8"<cfif isDefined("form.commFocus") and form.commFocus CONTAINS "8"> selected</cfif>>Global Tobacco control issues--->
</select></td>
</tr>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="strat_campaign_targets">
	select target, seq
	from strat_campaignTarget
	where userid='#activityInfo.userid#'
	and activity = '#activity#'
	and year2=#session.fy#
	order by seq	
</cfquery>

<tr>
<td>Target Audience:</td>
<td>
<select name="target" multiple class="mlti">
<cfif strat_campaign_targets.recordcount GT 0>
			<cfoutput>
			<cfloop query="strat_campaign_targets">
				<cfquery datasource="#application.DataSource#"  		
				 
				password="#application.db_password#"   		
				username="#application.db_username#" name="detail_targets">
				select descrip
				from campaignTarget
				where 
				num in (#strat_campaign_targets.target#)	
				and year2=#session.fy#
			</cfquery>
			<option value="#target#" <cfif isDefined("form.target") and listfind(form.target,target)> selected</cfif>>#valuelist(detail_targets.descrip)#
			</cfloop>
			</cfoutput>
			<cfelse>
			<option value="">No targets selected in workplan
			</cfif>



</select></td></tr>


<tr>
<td># reached (if series, total #/month)</td>
<td>
	<cfif isDefined("form.num")>
		<cfinput type="Text" name="num" size="7"  value="#form.num#"  validate="integer" message="Please enter a valid integer for your number reached">
	<cfelse>
		<cfinput type="Text" name="num" size="7" validate="integer" message="Please enter a valid integer for your number reached">
	</cfif>
</td>
</tr>

<tr>
<td>Event Promotion?</td>
<td align="left">
<input type="Radio" name="promotion" value="1" onclick="reloadpage();" <cfif (isDefined("form.promotion") and form.promotion EQ "1")> checked</cfif>>Yes<br>
<input type="Radio" name="promotion" value="0" onclick="reloadpage();" <cfif (isDefined("form.promotion") and form.promotion EQ "0") OR Not isDefined("form.promotion")> checked</cfif>>No
<input type="Radio" name="promotion" value="2" onclick="reloadpage();" <cfif (isDefined("form.promotion") and form.promotion EQ "2")> checked</cfif>>NA</td>
</tr>

</table></td></tr>

<cfif isDefined("form.promotion") and form.promotion EQ "1">
<tr><td><table>
<cfif isDefined("dispForum")>
</cfif>
<cfinclude template="outreach_bak.cfm">

</table></td></tr>
</cfif>
<tr><td>&nbsp;</td></tr>
</cfif>
<cfinclude template="barriers.cfm">
<cfif pendStatus EQ "0">
<tr><td>&nbsp;</td></tr>
<cfinclude template="earnedM.cfm">
</cfif>