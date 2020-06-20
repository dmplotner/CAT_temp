<cfif session.fy GTE 2008>
<cfif isDefined("activityInfo.strategy") and activityInfo.strategy EQ "8" AND ((activityInfo.targetgroup EQ "1" AND 
	activityInfo.goal EQ "1" and session.fy GT 2005) OR (activityInfo.targetgroup EQ "1" and session.fy LTE 2005))>

<!--- <cfif isDefined("activityInfo.targetgroup") and activityInfo.targetgroup EQ "1"> --->
	<cfset parentform = "monthlyActive_cess_test.cfm">
<cfelse>
	<cfset parentform = "monthlyActive.cfm">
</cfif>	
<cfelse>
<cfif isDefined("activityInfo.strategy") and activityInfo.strategy EQ "8" AND ((activityInfo.targetgroup EQ "1" AND 
	activityInfo.goal EQ "3"  and session.fy GT 2005) OR (activityInfo.targetgroup EQ "1" and session.fy LTE 2005))>

<!--- <cfif isDefined("activityInfo.targetgroup") and activityInfo.targetgroup EQ "1"> --->
	<cfset parentform = "monthlyActive_cess_test.cfm">
<cfelse>
	<cfset parentform = "monthlyActive.cfm">
</cfif>
</cfif>
<!--- 

<cfif isDefined("activityInfo.strategy") and activityInfo.strategy EQ "8" AND ((activityInfo.targetgroup EQ "1" AND 
	activityInfo.goal EQ "3" and session.fy GT 2005) OR (activityInfo.targetgroup EQ "1" and session.fy LTE 2005))>


	<cfset parentform = "monthlyActive_cess_test.cfm">
<cfelse>
	<cfset parentform = "monthlyActive.cfm">
</cfif> 

--->

<cfif isDefined("form.mbarriers")>

<cfif form.earned EQ "1">
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="checkEMedia">
	
	select userid from earnedMedia 
	where activity = '#activity#'
	and userid = '#activityInfo.userid#'
	and month2= '#form.month#'		
	and year2= '#form.year#'	
	
</cfquery>

<cfif checkEMedia.recordcount EQ "0">
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="insEMedia">

		insert into earnedMedia (activity, userid, month2, year2)
		values('#activity#','#activityInfo.userid#', '#form.month#', '#form.year#')
</cfquery>
</cfif>

<!--- <cfoutput>   processing earned media   </cfoutput> --->
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="updEMedia">
	update earnedMedia
	set recruit1=<cfif isDefined("form.recruit1")>1<cfelse>0</cfif>, 
	recruit2=<cfif isDefined("form.recruit2")>1<cfelse>0</cfif>, 
	recruit3=<cfif isDefined("form.recruit3")>1<cfelse>0</cfif>, 
	recruit4=<cfif isDefined("form.recruit4")>1<cfelse>0</cfif>, 
	recruit5=<cfif isDefined("form.recruit5")>1<cfelse>0</cfif>, 
	mediaSuccesses = '#form.msuccesses#'
	where activity = '#form.oldrpt#'
	and userid ='#activityInfo.userid#'
	and month2= '#form.month#'		
	and year2= '#form.year#'
	
	
</cfquery>

</cfif>
</cfif>


<tr><td><table  align="left" cellpadding="10" cellspacing="0" border="0" class="box">
<tr><td><a name="em"></a><cfif session.fy GT 2006 or session.fy LT 1920>Did you recruit and/or receive earned media for this strategy this month?<cfelse>Did this strategy generate any earned media?</cfif>	   <A HREF="javascript:void(0)"onclick="window.open('<cfoutput>#application.basename#</cfoutput>/dictionary.cfm#em','_blank','height=500, width=700,scrollbars=yes')"><img SRC="images/book07.gif"  width="20" height="20" BORDER="0" ALT="Help"></a>
&nbsp;&nbsp;&nbsp;&nbsp;<input type="Radio" name="earned" value="1" onclick="submitMedia('yes');" <cfif isDefined("form.earned") and form.earned EQ "1"> checked</cfif>>Yes&nbsp;&nbsp;&nbsp;<input type="Radio" name="earned" value="0"  onclick="submitMedia('no');"<cfif (isDefined("form.earned") and form.earned NEQ "1") or not isDefined("form.earned")> checked</cfif>>No</td></tr>


<input type="hidden" name="insNewspaper" value = "">
<input type="hidden" name="insNewsletter" value = "">
<input type="hidden" name="insRadio" value = "">
<input type="hidden" name="showNewspaper" value = "">

<script language="JavaScript">
function addnewspaper(value){
document.monthlyActivity.insNewspaper.value=value;
document.monthlyActivity.action="<cfoutput>#parentform#?#session.urltoken#</cfoutput>#np";
document.monthlyActivity.submit();

}

function addnewsletter(value){
document.monthlyActivity.insNewsletter.value=value;
document.monthlyActivity.action="<cfoutput>#parentform#?#session.urltoken#</cfoutput>#nl";
document.monthlyActivity.submit();

}

function addradio(value){
document.monthlyActivity.insRadio.value=value;
document.monthlyActivity.action="<cfoutput>#parentform#?#session.urltoken#</cfoutput>#rad";
document.monthlyActivity.submit();

}

function submitMedia(display){
if(display == "yes"){
document.monthlyActivity.showNewspaper.value="show";
}
document.monthlyActivity.action="<cfoutput>#parentform#</cfoutput>#em";
document.monthlyActivity.submit();
}

</script>
<cfif isDefined("form.earned") and form.earned EQ "1">
<cfif (isDefined("form.shownewspaper") and form.shownewspaper NEQ "show-xxx") OR form.earned EQ "1">

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="mediaStats">
select recruit1, recruit2, recruit3, recruit4, recruit5,
mediabarriers, mediaSuccesses
from earnedMedia
where userid = '#activityInfo.userid#'
	and activity = '#activity#'
	and month2='#form.month#'
	and year2 = #form.year#
	
</cfquery>


<cfif isDefined("form.insNewspaper") and form.insNewspaper EQ "add">
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="addNewspaper">
	insert into newspaper
	(userid, activity, newspaper, type, month2, year2)
	values
	('#activityInfo.userid#','#activity#', '#form.newspaper#', '#form.typeStory#', '#form.month#', '#form.year#')
	 
</cfquery>
</cfif>

<cfif isDefined("form.insNewspaper") and form.insNewspaper EQ "del" and isDefined("form.del_news")>
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="delNewspaper">
	delete from newspaper
	where userid= '#activityInfo.userid#'
	and  activity= '#activity#'
	and seq in (#form.del_news#)
	and year2=#session.fy#
		 
</cfquery>
</cfif>

<cfif isDefined("form.insNewsletter") and form.insNewsletter EQ "add">
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="addNewspaper">
	insert into newsletter
	(userid, activity, newsletter, type, month2, year2)
	values
	('#activityInfo.userid#','#activity#', '#form.newsletter#', '#form.typenl#', '#form.month#', '#form.year#')
	 
</cfquery>
</cfif>

<cfif isDefined("form.insNewsletter") and form.insNewsletter EQ "del" and isDefined("form.del_newsl")>
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="delNewspaper">
	delete from newsletter
	where userid= '#activityInfo.userid#'
	and  activity= '#activity#'
	and seq in (#form.del_newsl#)
	and year2=#session.fy#
		 
</cfquery>
</cfif>

<cfif isDefined("form.insRadio") and form.insRadio EQ "add">
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="addRadio">
	insert into radio
	(userid, activity, radio, run, month2, year2)
	values
	('#activityInfo.userid#','#activity#', '#form.radio#', '#form.run#', '#form.month#', '#form.year#')
	 
</cfquery>
</cfif>

<cfif isDefined("form.insRadio") and form.insRadio EQ "del" and isDefined("form.del_radio")>
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="delRadio">
	delete from radio
	where userid= '#activityInfo.userid#'
	and  activity= '#activity#'
	and seq in (#form.del_radio#)
	and month2='#form.month#' and year2='#form.year#'
	
	 
</cfquery>
</cfif>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="selectNewspaper">
		
	select newspaper, t.descrip as type, n.seq
	from newspaper as n, typestory as t
	where userid='#activityInfo.userid#' and activity = '#activity#'
	and month2='#form.month#' and n.year2='#form.year#'
	and n.type=t.num
	and n.year2=t.year2
	order by 1,2
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="selectNewsletter">
		
	select newsletter, t.descrip as type, n.seq
	from newsletter as n, typestory as t
	where userid='#activityInfo.userid#' and activity = '#activity#'
	and month2='#form.month#' and n.year2='#form.year#'
	and n.type=t.num
	and n.year2=t.year2
	order by 1,2
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="selectRadio">
		
	select radio, run, seq
	from radio
	where userid='#activityInfo.userid#' and activity = '#activity#'
	and month2='#form.month#' and year2='#form.year#'
	order by 1,2
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="typestories">
		
	select descrip, num
	from typestory
	where year2=#session.fy#
	order by rank
</cfquery>


<tr><td><table class="box">

<cfif session.fy GT 2006 or session.fy LT 1920>
<tr><td>&nbsp;</td></tr>

<tr><td>What did you do to recruit earned media for this strategy this month? (check all that apply):</td></tr>
<tr><td>&nbsp;&nbsp;&nbsp;<input type="Checkbox" name="recruit1" value ="1"<cfif mediaStats.recordcount EQ "1" and mediaStats.recruit1 EQ "1"> checked</cfif>>N/A. Media covered this event/activity without any encouragement from partner</td></tr>
<tr><td>&nbsp;&nbsp;&nbsp;<input type="Checkbox" name="recruit2" value ="1"<cfif mediaStats.recordcount EQ "1" and mediaStats.recruit2 EQ "1"> checked</cfif>>Distributed Press Release on this event</td></tr>
<tr><td>&nbsp;&nbsp;&nbsp;<input type="Checkbox" name="recruit3" value ="1"<cfif mediaStats.recordcount EQ "1" and mediaStats.recruit3 EQ "1"> checked</cfif>>Made calls to press to announce this event</td></tr>
<tr><td>&nbsp;&nbsp;&nbsp;<input type="Checkbox" name="recruit4" value ="1"<cfif mediaStats.recordcount EQ "1" and mediaStats.recruit4 EQ "1"> checked</cfif>>Delivered press packets with background information</td></tr>
<tr><td>&nbsp;&nbsp;&nbsp;<input type="Checkbox" name="recruit5" value ="1"<cfif mediaStats.recordcount EQ "1" and mediaStats.recruit5 EQ "1"> checked</cfif>>Held press conference on this event</td></tr>
</cfif>
<tr><td>&nbsp;</td></tr>
<tr><td> <a name="np"></a><cfif session.fy GT 2006 or session.fy LT 1920>If you received newspaper coverage this month, enter each item below<cfelse>If Newspaper, coverage achieved:</cfif></td></tr>
<tr><td>
<table   align="left" cellpadding="10" cellspacing="0" border="0" class="box">
<tr>
	<th>Name of newspaper<br><CFinput type="text" name="newspaper" maxlength="180"></th>
	<th><cfif session.fy LT 2009>Type of Story<cfelse>Type of newspaper coverage</cfif><br>
		<cfselect name="typestory" query="typestories" display="descrip" value="num">
		</cfselect>
		<!--- <select name="typeStory">
			<option >News Story
			<option >Editorial
			<option >Op-Ed
			<option >Regular Column
			<option>Cartoon
			<option>Picture
		</select> --->
	</th>	
	</tr><tr>
			<td align="left"><input type="Button" value="Add Line" onclick="addnewspaper('add');" class="AddButton"></td>
</tr>
<cfoutput>
<cfloop query="selectNewspaper">
<tr bgcolor="Silver">
	<td>#newspaper#</td>
	<td>#type#</td>
	<td><input type="checkbox" name="del_news" value="#seq#">Delete</td>
</tr>
</cfloop>
</cfoutput>
<cfif selectNewspaper.recordcount GT 0>
<tr><td colspan="3" align="left"><input type="Button" value="Delete" onclick="addnewspaper('del');" class="DelButton"></td></tr>
</cfif>
</table></td></tr>
<cfif session.fy GT 2008>
<tr><td>&nbsp;</td></tr>
<tr><td> <a name="nl"></a>If you received newsletter coverage this month, enter each item below.</td></tr>
<tr><td>
<table   align="left" cellpadding="10" cellspacing="0" border="0" class="box">
<tr>
	<th>Name of newsletter<br><CFinput type="text" name="newsletter" maxlength="180"></th>
	<th>Type of newsletter coverage<br>
		<cfselect name="typenl" query="typestories" display="descrip" value="num">
		</cfselect>		
	</th>	
	</tr><tr>
			<td align="left"><input type="Button" value="Add Line" onclick="addnewsletter('add');" class="AddButton"></td>
</tr>
<cfoutput>
<cfloop query="selectNewsLetter">
<tr bgcolor="Silver">
	<td>#newsletter#</td>
	<td>#type#</td>
	<td><input type="checkbox" name="del_newsl" value="#seq#">Delete</td>
</tr>
</cfloop>
</cfoutput>
<cfif selectNewsLetter.recordcount GT 0>
<tr><td colspan="3" align="left"><input type="Button" value="Delete" onclick="addnewsletter('del');" class="DelButton"></td></tr>
</cfif>
</table></td></tr>
</cfif>


<tr><td><a name="rad"></a> <cfif session.fy GT 2006 or session.fy LT 1920>If you received TV or radio coverage this month, enter each station below<cfelse>If TV or Radio, coverage of the event:</cfif></td></tr>
<tr><td><table   align="left" cellpadding="10" cellspacing="0" border="0" class="box">
<tr>
	<th>Name of TV or Radio station that covered the event<br><cfinput type="text" name="radio" maxlength="180"></th>
	<th>Did station run the story?<br>
		<input type="radio" name="run" value="1">Yes&nbsp;&nbsp;&nbsp;
		<input type="radio" name="run" value="0">No&nbsp;&nbsp;&nbsp;
		<input type="radio" name="run" value="2" checked>Don't Know
	</th>	
			</tr><tr>
			<td align="left"><input type="Button" value="Add" onclick="addradio('add');" class="AddButton"></td>
</tr>
<cfoutput>
<cfloop query="selectRadio">
<tr bgcolor="Silver">
	<td>#radio#</td>
	<td>
	<cfif run EQ "1">Yes
	<cfelseif run EQ "0">No
	<cfelseif run EQ "2">Don't Know
	</cfif>
	</td>
	<td><input type="checkbox" name="del_radio" value="#seq#">Delete</td>
</tr>
</cfloop>
</cfoutput>
<cfif selectRadio.recordcount GT 0>
<tr><td colspan="3" align="left"><input type="Button" value="Delete" onclick="addradio('del');" class="DelButton"></td></tr>
</cfif>

</table></td></tr>
<cfif session.fy LT 2007 and session.fy GT 1920>
<tr><td>&nbsp;</td></tr>

<tr><td>How did the partnership recruit earned media coverage (check all that apply):</td></tr>
<tr><td>&nbsp;&nbsp;&nbsp;<input type="Checkbox" name="recruit1" value ="1"<cfif mediaStats.recordcount EQ "1" and mediaStats.recruit1 EQ "1"> checked</cfif>>N/A. Media covered this event/activity without any encouragement from partner</td></tr>
<tr><td>&nbsp;&nbsp;&nbsp;<input type="Checkbox" name="recruit2" value ="1"<cfif mediaStats.recordcount EQ "1" and mediaStats.recruit2 EQ "1"> checked</cfif>>Distributed Press Release on this event</td></tr>
<tr><td>&nbsp;&nbsp;&nbsp;<input type="Checkbox" name="recruit3" value ="1"<cfif mediaStats.recordcount EQ "1" and mediaStats.recruit3 EQ "1"> checked</cfif>>Made calls to press to announce this event</td></tr>
<tr><td>&nbsp;&nbsp;&nbsp;<input type="Checkbox" name="recruit4" value ="1"<cfif mediaStats.recordcount EQ "1" and mediaStats.recruit4 EQ "1"> checked</cfif>>Delivered press packets with background information</td></tr>
<tr><td>&nbsp;&nbsp;&nbsp;<input type="Checkbox" name="recruit5" value ="1"<cfif mediaStats.recordcount EQ "1" and mediaStats.recruit5 EQ "1"> checked</cfif>>Held press conference on this event</td></tr>
</cfif>
<tr><td>&nbsp;</td></tr>




<tr><td valign="top">Earned media barriers:<textarea name="mbarriers" cols="120" rows="4"><cfoutput>#mediastats.mediabarriers#</cfoutput></textarea></td></tr>
<tr><td valign="top">Reasons for earned media success:<textarea name="msuccesses" cols="120" rows="4"><cfoutput>#mediastats.mediasuccesses#</cfoutput></textarea></td></tr>
</cfif>
</table></td></tr>

</cfif>


</table></td></tr>
<!--- end earned media popup --->