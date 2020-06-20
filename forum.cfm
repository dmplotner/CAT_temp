<script language="javascript">
function petcycle(){
document.monthlyActivity.action="monthlyActive.cfm<cfoutput>?#session.urltoken#</cfoutput>#pet";
document.monthlyActivity.submit();
}
</script> 
<cfif pendStatus EQ "0">


<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="dispForum">
	select 
	seq,
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
num, promotion, rbpet, numSig

	from forum
	where userid = '#activityInfo.userid#'
	and activity = '#activity#'
	and month2='#form.month#'
	and year2 = #form.year#
	
</cfquery>

<cfif isDefined("form.procDescrip") and form.procDescrip EQ "add">

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="insForumDet">
insert into forum_det
(fkforum, 
format,
setting,countyEvent,
<cfif isDefined('form.eventT')>eventT,</cfif>commfocus,<!--- target ---> target_seq
<cfif isDefined("form.num")>,num</cfif>
<cfif isDefined("form.promotion")>,promotion</cfif> 
<cfif isDefined("form.format_other")>, format_other</cfif>
<cfif isDefined("form.setting_other")>, setting_other</cfif>
<cfif isDefined("form.type_promo")>, type_promo</cfif>
<cfif isDefined("form.isEvent")>, isEvent</cfif>
<cfif isDefined("form.didInitiate")>, didInitiate</cfif>
)
values
(#dispForum.seq#, 
<cfif isDefined('form.format')>'#form.format#',<cfelse>0,</cfif>
'#form.setting#','#form.countyEvent#',
<cfif isDefined('form.eventT')>'#form.eventT#',</cfif>'#form.commfocus#','#form.target#'
<cfif isDefined("form.num")>,'#form.num#'</cfif>
<cfif isDefined("form.promotion")>,'#form.promotion#'</cfif>
<cfif isDefined("form.format_other")>, '#form.format_other#'</cfif>
<cfif isDefined("form.setting_other")>, '#form.setting_other#'</cfif>
<cfif isDefined("form.type_promo")>,  '#form.type_promo#'</cfif>
<cfif isDefined("form.isEvent")>, #form.isEvent#</cfif>
<cfif isDefined("form.didInitiate")>, #form.didInitiate#</cfif>
) 
</cfquery>


<cfset form.format=''>
<cfset form.isEvent=''>
<cfset form.didInitiate=''>
<cfset form.setting=''>
<cfset form.countyEvent=''>
<cfset form.eventT=''>
<cfset form.commfocus=''>
<cfset form.target=''>
<cfset form.num=''>
<cfset form.promotion=''>
<cfset form.format_other=''>
<cfset form.setting_other=''>
<cfset form.type_promo='0'>

<cfelseif isDefined("form.procDescrip") and form.procDescrip EQ "del" and isDefined("form.del_forum")>
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="delForumDet">
	delete from forum_det
	where seq in (#del_forum#)
</cfquery>
</cfif>

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
	<cfset form.rbpet = dispForum.rbpet>
	<cfset form.numSig = dispForum.numSig>	
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
	username="#application.db_username#" name="Qtypepromo">
	select descr, num
	from LU_type_promo
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

<cfinclude template="outreach2.cfm">
<script language="JavaScript">
function reloadpage(targ){
document.monthlyActivity.action="monthlyActive.cfm<cfoutput>?#session.urltoken#</cfoutput>#"+targ;
document.monthlyActivity.submit();
}

function isInteger(s){
	var i;
    for (i = 0; i < s.length; i++){   
        // Check that current character is number.
        var c = s.charAt(i);
        if (((c < "0") || (c > "9"))) return false;
    }
    // All characters are numbers.
    return true;
}
function addDescrip(){
if (document.monthlyActivity.countyEvent.selectedIndex < 0){
alert("Please make sure to select a county of target audience before clicking the ADD button");
return false;
}
if (document.monthlyActivity.commFocus.selectedIndex < 0){
alert("Please make sure to select a focus of tobacco communication before clicking the ADD button");
return false;
}
if (document.monthlyActivity.target.selectedIndex < 0){
alert("Please make sure to select a target audience before clicking the ADD button");
return false;
}
if (document.monthlyActivity.num){
if (isInteger(document.monthlyActivity.num.value)== false ){
alert("Please enter an integer value for Number of people");
return false;
}
}
<cfif session.fy LT 2007 and session.fy GT 1920>
var radioSelected = false;
for (i = 0;  i < document.monthlyActivity.promotion.length;  i++)
{
if (document.monthlyActivity.promotion[i].checked)
radioSelected = true;
}
if (!radioSelected)
{
alert("Please make sure to select a response to the event promotion radio button before clicking the ADD button");
return (false);
}
</cfif>

document.monthlyActivity.action="monthlyActive.cfm<cfoutput>?#session.urltoken#</cfoutput>#";
document.monthlyActivity.procDescrip.value="add";
document.monthlyActivity.submit();
}

function del(){
document.monthlyActivity.action="monthlyActive.cfm<cfoutput>?#session.urltoken#</cfoutput>#";
document.monthlyActivity.procDescrip.value="del";
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
<input type="hidden" name="procDescrip" value="">

<tr><td><a name="commdesc"></a>Community Education Description</td></tr>
<tr><td colspan="2"><table class="box" border="0">
<tr><td>Community Education Format:</td>
<td>
<select name="format" <cfif (session.fy GT 2006 OR session.fy LT 1920)>onChange="reloadpage('commdesc');" </cfif>>
	<option value="">Please select</option>
<cfoutput>
	<cfloop query="Qformats">
		<option value="#num#"  <cfif (session.fy GT 2006 OR session.fy LT 1920)and ((isDefined("form.procDescrip") and form.procDescrip NEQ "add") or Not isDefined("form.procDescrip")) and isDefined("form.format") and listfind(form.format,num)>selected</cfif> >#descr#
	</cfloop>
</cfoutput>
</select>

</td>
</tr>

<cfif session.fy GT 2006 OR session.fy LT 1920>
 
<tr>
	<td>If you selected 'other,' please specify:</td>
	<td>
		<input type="text" name="format_other" <cfif (session.fy GT 2006 OR session.fy LT 1920) and ((isDefined("form.procDescrip") and form.procDescrip NEQ "add") or Not isDefined("form.procDescrip")) and isDefined("form.format_other")> value="<cfoutput>#form.format_other#</cfoutput>"</cfif>>
	</td>
</tr>
</cfif>
<tr><td>Community Education Setting:</td>
<td>
<select name="setting" >
		<option value="">Please select</option>
<cfoutput>		
	<cfloop query="Qsettings">
		<option value="#num#"   <cfif (session.fy GT 2006 OR session.fy LT 1920)and ((isDefined("form.procDescrip") and form.procDescrip NEQ "add") or Not isDefined("form.procDescrip")) and isDefined("form.setting") and listfind(form.setting,num)>selected</cfif> >#descr#
		
	</cfloop>
</cfoutput>

</select>
</td>
</tr>
<cfif session.fy GT 2006 OR session.fy LT 1920>
 
<tr>
	<td>If you selected 'other,' please specify:</td>
	<td>
		<input type="text" name="setting_other" <cfif (session.fy GT 2006 OR session.fy LT 1920) and ((isDefined("form.procDescrip") and form.procDescrip NEQ "add") or Not isDefined("form.procDescrip")) and isDefined("form.setting_other")> value="<cfoutput>#form.setting_other#</cfoutput>"</cfif>>
	</td>
</tr>
</cfif>

<!--- <tr><td>Series? </td><td>
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
</cfif> --->
<tr>
<td><cfif session.fy LT 2009>County(ies) of target audience:<cfelse>County where the event occurred:</cfif></td>
<td><select name="countyEvent" multiple size="4" <cfif session.fy LT 2009>class="mlti"</cfif>>
<cfoutput>
<cfloop query="counties">
<option  value= "#FIPS#" <cfif  (session.fy GT 2006 OR session.fy LT 1920) and ((isDefined("form.procDescrip") and form.procDescrip NEQ "add") or Not isDefined("form.procDescrip")) and isDefined("form.countyEvent") and listfind(form.countyEvent,FIPS)> selected</cfif> >#countyName#
</cfloop>

	<option value="88888"<cfif  (session.fy GT 2006 OR session.fy LT 1920) and ((isDefined("form.procDescrip") and form.procDescrip NEQ "add") or Not isDefined("form.procDescrip")) and isDefined("form.countyEvent") and listfind(form.countyEvent,"88888")> selected</cfif> >Counties beyond catchment area
	<option value="99999" <cfif  (session.fy GT 2006 OR session.fy LT 1920) and ((isDefined("form.procDescrip") and form.procDescrip NEQ "add") or Not isDefined("form.procDescrip")) and isDefined("form.countyEvent") and listfind(form.countyEvent,"99999")> selected</cfif> >Distant from catchment area
</cfoutput>
</select> </td>
</tr>



<tr>
<td>Focus of tobacco communication:</td>
<td><select name="commFocus" multiple class="mlti">
<cfoutput>
	<cfloop query="Qfocus">
		<option value="#num#" <cfif  (session.fy GT 2006 OR session.fy LT 1920) and ((isDefined("form.procDescrip") and form.procDescrip NEQ "add") or Not isDefined("form.procDescrip")) and isDefined("form.commFocus") and listfind(form.commFocus,num)> selected</cfif> >#descr#
	</cfloop>
</cfoutput>
</select></td>
</tr>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="strat_campaign_targets">
	select target, seq as target_seq
	from strat_campaignTarget
	where userid='#activityInfo.userid#'
	and activity = '#activity#'
	and (del is null or del !=1)
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
			<!--- <option value="#target#"  <cfif (session.fy GT 2006 OR session.fy LT 1920) and ((isDefined("form.procDescrip") and form.procDescrip NEQ "add") or Not isDefined("form.procDescrip")) and isDefined("form.target") and listfind(form.target,target)> selected <cfelseif strat_campaign_targets.recordcount EQ 1> selected </cfif> >#valuelist(detail_targets.descrip)#
 --->			<option value="#target_seq#"  <cfif (session.fy GT 2006 OR session.fy LT 1920) and ((isDefined("form.procDescrip") and form.procDescrip NEQ "add") or Not isDefined("form.procDescrip")) and isDefined("form.target") and listfind(form.target,target)> selected <cfelseif strat_campaign_targets.recordcount EQ 1> selected </cfif> >#valuelist(detail_targets.descrip)#
			</cfloop>
			</cfoutput>
			<cfelse>
			<option value="">No targets selected in workplan
			</cfif>



</select>
</td>
</tr>

<cfif session.fy LT 2007 and session.fy GT 1920><br>
<tr>
<td>If this was an event, was the overall theme related to tobacco issues?</td>
<td>
<input type="Radio" name="eventT" value="1"<cfif (isDefined("form.eventT") and form.eventT EQ "1") OR Not isDefined("form.eventT")> checked</cfif>>Tobacco Related Event &nbsp;&nbsp;&nbsp;
<input type="Radio" name="eventT" value="2"<!--- <cfif (isDefined("form.eventT") and form.eventT EQ "2")> checked</cfif> --->>Non-Tobacco Related Event&nbsp;<A HREF="javascript:void(0)"onclick="window.open('<cfoutput>#application.basename#</cfoutput>/dictionary.cfm#ntre','_blank','height=500, width=700,scrollbars=yes')"><img SRC="images/book07.gif"  width="20" height="20" BORDER="0" ALT="Help"></a></td>
</tr>
<cfelse>

<cfif (isDefined("form.format") and form.format  NEQ 10 and form.format NEQ 11) OR NOT isDefined("form.format")>
<tr>
	<td>Was this an event?</td>
	<td>
		<input type="radio" name="isEvent" value="1" onClick="reloadpage('commdesc');"<cfif ((isDefined("form.procDescrip") and form.procDescrip NEQ "add") or Not isDefined("form.procDescrip")) AND isDefined("form.isEvent") and form.isEvent EQ 1> checked</cfif>>Yes &nbsp;&nbsp;
		<input type="radio" name="isEvent" value="0" onClick="reloadpage('commdesc');"<cfif ((isDefined("form.procDescrip") and form.procDescrip NEQ "add") or Not isDefined("form.procDescrip"))AND isDefined("form.isEvent") and form.isEvent EQ 0> checked</cfif>>No
	</td>
</tr>
</cfif>
<cfif isDefined("form.isEvent") and form.isEvent EQ 1>
<tr>
<td>Was the overall theme of the event related to tobacco issues?</td>
<td>
<input type="Radio" name="eventT" value="1"<cfif (isDefined("form.eventT") and form.eventT EQ "1") > checked</cfif>>Yes &nbsp;&nbsp;&nbsp;
<input type="Radio" name="eventT" value="2" <cfif (isDefined("form.eventT") and form.eventT EQ "2")> checked</cfif> >No 
</td>
</tr>

<tr>
	<td>Did you initiate or organize this event?</td>
	<td>
		<input type="radio" name="didInitiate" value="1"<cfif (isDefined("form.didInitiate") and form.didInitiate EQ "1")> checked</cfif>>Yes &nbsp;&nbsp;
		<input type="radio" name="didInitiate" value="0"<cfif (isDefined("form.didInitiate") and form.didInitiate EQ "0")> checked</cfif>>No

	</td>
</tr>

</cfif>
</cfif>
<cfif (isDefined("form.isEvent") and form.isEvent EQ 1 and (session.fy GT 2006 or session.fy LT 1920)) OR (session.fy LT 2007 and session.fy GT 1920) and isDefined("form.format") and form.format NEQ 10 and form.format NEQ 11>

<tr>
<td>
<cfif form.format EQ 3 or form.format EQ 4>
# of people attending presentation or workshop
<cfelseif form.format EQ 6>
# of people receiving information or materials
<cfelseif form.format EQ 7>
# of stomp participants
<cfelseif form.format EQ 8>
# of people in attendance
<cfelseif form.format EQ 9>
# of people in attendance
<cfelseif form.format EQ 12>
# of people reached
<cfelse>
# reached
</cfif>


</td>
<td>
	 <cfif isDefined("form.num")>
		<cfinput type="Text" name="num" size="7"  value="#form.num#"  validate="integer" message="Please enter a valid integer for your number reached">
	<cfelse> 
		<cfinput type="Text" name="num" size="7" validate="integer" message="Please enter a valid integer for your number reached">
	</cfif>
</td>
</tr>
</cfif>
<cfif session.fy LT 2007 and session.fy GT 1920>

<tr>
<td>Event Promotion?</td>
<td align="left">
<input type="Radio" name="promotion" value="1"  <!--- <cfif (isDefined("form.promotion") and form.promotion EQ "1")> checked</cfif> --->>Yes
<input type="Radio" name="promotion" value="0"  <!--- <cfif (isDefined("form.promotion") and form.promotion EQ "0") OR Not isDefined("form.promotion")> checked</cfif> --->>No
<input type="Radio" name="promotion" value="2"  <!--- <cfif (isDefined("form.promotion") and form.promotion EQ "2")> checked</cfif> --->>NA</td>
</tr>
<cfelse>
<cfif (isDefined("form.isEvent") and form.isEvent EQ 1 and (session.fy GT 2006 or session.fy LT 1920)) >

<tr>
	<td>What type of event promotion did you do?</td>
	<td>
	<select name="type_Promo" multiple class="mlti">
	<cfoutput>
	<cfloop query="Qtypepromo">
		<option value="#num#"<!--- <cfif isDefined("form.type_Promo") and listfind(form.commFocus,num)> selected</cfif> --->>#descr#
	</cfloop>
	</cfoutput>
	</select>
	</td>
</tr>
</cfif>
</cfif>

<tr>
	<td><input type="Button" value="Add" onClick="addDescrip();" class="AddButton"></td>
</tr>



<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="retForumDet">
select 
seq,fkforum, format ,setting ,
series ,numEvents ,countyEvent ,
eventT ,commfocus ,target, target_seq ,num ,promotion ,format_other, setting_other, type_promo, isEvent, didInitiate
from forum_det
where fkforum=#dispForum.seq#
</cfquery>
<tr><td>&nbsp;</td></tr>


<cfif retForumDet.recordcount GT 0>
<tr><td colspan="3"><table class="boxg">

<cfoutput>
<cfloop query="retForumDet">
<cfset seq2=seq>
<cfset fkforum2=fkforum>
<cfset format2=format>
<cfset setting2=setting>
<cfset series2=series>
<cfset numevents2=numEvents>
<cfset countyEvent2=countyEvent>
<cfset eventT2=eventT>
<cfset commfocus2=commfocus>
<!--- <cfset target2=target> --->
<cfset target3=target_seq>
	<cfif target3 EQ ''>
		<cfset target3='999999'>
	</cfif>
<cfset num2=num>
<cfset promotion2=promotion> 

</tr>
<tr><td>Community Education Format:</td>
<td>
	<cfloop query="Qformats" >
		<cfif listfind(format2,num)>#descr#<br></cfif>
	</cfloop>
</td>
<td nowrap><input type="Checkbox" name="del_forum" value="#seq2#">Delete Entry</td>
</tr>

<tr><td valign="top">Community Education Setting:</td>
<td valign="top">

	<cfloop query="Qsettings">
		<cfif listfind(setting2,num)>#descr#<br></cfif>
	</cfloop>
</td>
</tr>

<!--- <tr><td valign="top">Series? </td>
<td valign="top">
<cfif series2 EQ "1"> YES<cfelse>NO</cfif>
</td>
</tr>
<cfif series2 EQ "1">
<tr>
<td>Number of events in series held this month:</td>
<td>#numEvents2#
</td>
</tr>
</cfif> --->


<tr>
<td valign="top"><cfif session.fy LT 2009>County(ies) of target audience:<cfelse>County where the event occurred:</cfif></td>
<td valign="top">

<cfloop query="counties">
<cfif listfind(countyEvent2,FIPS)>#countyName#<br></cfif>
</cfloop>

	<cfif listfind(countyEvent2,"88888")>Counties beyond catchment area<br></cfif>
	<cfif listfind(countyEvent2,"99999")>Distant from catchment area<br></cfif>

</td>
</tr>



<tr>
<td valign="top">Focus of tobacco Communication:</td>
<td valign="top">
	<cfloop query="Qfocus">
		<cfif listfind(commFocus2,num)>#descr#</cfif>
	</cfloop>
</td>
</tr>


<tr>
<td valign="top">Target Audience:</td>
<td valign="top">
<cfquery datasource="#application.DataSource#" 				 
password="#application.db_password#"   		
username="#application.db_username#" name="targetseqToNum">
select isnull(target, '99999') as target from strat_campaignTarget where seq in (#target3#)
</cfquery>
				
<cfif targetseqToNum.recordcount GT 0>
 		
		<cfloop query="targetseqToNum">				
				
				<cfquery datasource="#application.DataSource#" 				 
				password="#application.db_password#"   		
				username="#application.db_username#" name="detail_targets">
				select descrip
				from campaignTarget
				where 
				num in (#targetseqToNum.target#)
				and year2=#session.fy#
				</cfquery>
				
				<cfif detail_targets.recordcount GT 0>
				#valuelist(detail_targets.descrip)#<br>
				</cfif>
			</cfloop>			
<cfelse>
No targets selected
</cfif>

<!--- <cfif strat_campaign_targets.recordcount GT 0>
			
			<cfloop query="strat_campaign_targets">
				
				<cfquery datasource="#application.DataSource#" 				 
				password="#application.db_password#"   		
				username="#application.db_username#" name="detail_targets">
				select descrip
				from campaignTarget
				where 
				<!--- num in (#strat_campaign_targets.target#) --->	
				num in (#strat_campaign_targets.target_seq#)
				and year2=#session.fy#
				</cfquery>
				
				<cfif target2 EQ target>#valuelist(detail_targets.descrip)#</cfif>
			</cfloop>
			
<cfelse>
No targets selected in workplan
</cfif> --->
</td>
</tr>


<cfif session.fy LT 2006 and session.fy GT 1920>
<tr>
<td>If this was an event, was the overall theme related to tobacco issues?</td>
<td>
<cfif eventT2 EQ "1">Tobacco Related Event
<cfelseif eventT2 EQ "2">Non-Tobacco Related Event
</cfif>
</td>
</tr>

<tr>
<td>If this was an event, number reached (if series, total number per month)</td>
<td>
	#num2#		
</td>
</tr>

<tr>
<td>Event Promotion?</td>
<td align="left">
<cfif promotion2 EQ "1">Yes
<cfelseif promotion2 EQ "0">No
<cfelseif promotion2 EQ "2">NA
</cfif>
</td>
</tr>

<cfif promotion2 EQ "1">
<tr><td colspan="3"><table>
<cfinclude template="outreach.cfm">
</table></td></tr>
</cfif>

<tr><td colspan="3"><hr></td></tr>

<cfelseif session.fy LT 2007 and session.fy GT 1920>
<cfif isDefined("form.eventT")>
	<tr>
		<td>
			<cfif form.eventT EQ "1">
			Tobacco Related Event
			<cfelseif form.eventT EQ "2">
			Non-Tobacco Related Event
			</cfif>
		</td>
	</tr>

</cfif>
<tr>
	<td>Number of people attending:</td>
	<td>#num#</td>
</tr>
<cfif isDefined("promotion")>
<tr>	
	<td>Event Promotion?</td>
	<td align="left">
	<cfif promotion EQ "1">Yes
	<cfelseif promotion EQ "0">No
	<cfelse> NA	
	</cfif>
	</td>
</tr>
</cfif>

<cfelseif format2 NEQ 10 and format2 NEQ 11>
<tr>
	<td>Was this an event?</td>
	<td align="left">
		<cfif iSEvent EQ "1">Yes
		<cfelseif isEvent EQ "0">No	
		</cfif>
	</td>
</tr>
<cfif isEvent EQ "1">
<tr>
	<td>Theme related to tobacco issues?</td>
	<td align="left">
		<!--- used to be promotion --->
		<cfif eventT EQ "1">Yes
		<cfelseif eventT NEQ "1">No	
		</cfif>
	</td>
</tr>
<tr>
	<td>Did you initiate or organize?</td>
	<td align="left">
		<cfif didInitiate EQ "1">Yes
		<cfelseif didInitiate NEQ "1">No	
		</cfif>
	</td>
</tr>
<tr>
<td>Number reached</td>
<td>
	#num2#		
</td>
</tr>
<tr>
	<td valign="top">Type of event promotion</td>
	<td valign="top">
		<cfif isDefined("type_promo") and type_promo NEQ "">
			<cfquery datasource="#application.DataSource#"  
				password="#application.db_password#"   		
				username="#application.db_username#" name="detail_typepromo">
				select descr
				from lu_type_promo
				where 
				num in (#type_promo#)	
				and year2=#session.fy#
			</cfquery>
			#valuelist(detail_typepromo.descr, '<br>')#
		</cfif>
	</td>
	</tr>
</cfif>


</cfif>
<tr><td>&nbsp;</td></tr>
</cfloop>
<cfif retForumDet.recordcount GTE 1>
	<tr><td colspan="4" align="left"><input type="Button" value="Delete Checked Entries" onclick="del();" class="DelButton"></td></tr>
</cfif>
</cfoutput>


</table></td></tr>
</cfif>
</table></td></tr>
<tr><td>&nbsp;</td></tr>
</cfif>
<cfif pendStatus EQ "0">
<tr>
<td><a name="pet"></a>
<table class="box">
<tr>
	<td>Did this community education strategy include getting petition signatures this month?</td>
	
	<td>
		<input type="radio" name="rbpet" value="1"<cfif isDefined("form.rbpet") and form.rbpet EQ 1> checked</cfif> onClick="petcycle()">Yes
		<input type="radio" name="rbpet" value="0"<cfif isDefined("form.rbpet") and form.rbpet EQ 0> checked</cfif> onClick="petcycle()">No
	</td>
</tr>
<cfif (isDefined("form.rbpet") and form.rbpet EQ 1)><tr>
	<td>Number of new signatures collected this month:</td>
	<td>
		<cfif isDefined("form.numsig")>
			<cfinput type="text" name="numsig" size="5" value="#form.numsig#" validate="integer" message="Please enter an integer value for number of signatures">	
		<cfelse>
			<cfinput type="text" name="numsig" size="5" validate="integer" message="Please enter an integer value for number of signatures">	
		</cfif>
	</td>
</tr>
</cfif>
</table>
</td>
</tr>
<tr><td>&nbsp;</td></tr>
<cfinclude template="earnedM.cfm">
<tr><td>&nbsp;</td></tr>
<cfinclude template="tcpsust.cfm">
</cfif>
<cfinclude template="barriers.cfm">
