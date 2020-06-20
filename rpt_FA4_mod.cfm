<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="strat_campaign_targets">
	select target, seq
	from strat_campaignTarget
	where userid='#QGenDescrip.userid#'
	and activity = '#QGenDescrip.activity#'
	and year2=#session.fy#
	order by seq	
</cfquery>

<tr><td>Target Audience(s)</td><td colspan="3">
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
#valuelist(detail_targets.descrip)#<br>
</cfloop>
</cfoutput>
</cfif>
&nbsp;</td></tr>





<!--- collaboration level include --->
<cfinclude template="rpt_sub_collablevel.cfm">
<!--- end collaboration level include --->


<cfinclude template="rpt_sub_planning.cfm">
<cfif QmonList.recordcount GT 0>
<br>
</cfif>
<cfloop query="Qmonlist">

<cfset thisRptMon=mon>

<!--- end strategy specific --->
<!--- Begin closing stock section --->

<br>
<cfquery datasource="#application.DataSource#"	 
	password="#application.db_password#"   		
	username="#application.db_username#" 
	name="checkMon">
	select count(*) as count
	from Forum	
	<!--- where userid= '#QGenDescrip.userid#' 
	and activity = '#QGenDescrip.activity#' --->
	where userid= '#Guserid#' 
	and activity = '#Gactivity#'
	and month2 ='#thisRptMon#'
	and year2 = #session.fy#
	
</cfquery>
<cfif checkMon.count GT 0>
<cfquery datasource="#application.DataSource#" 	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="CurStatus">
	select status
			from #tablename#
			where month2 = '#thisRptMon#'
			AND  userid = '#Guserid#'
			and activity = '#Gactivity#'
			and year2 = #session.fy#			
</cfquery>
<cfif isDefined("CurStatus.status") and CurStatus.status NEQ "">
<table border=".5" width="100%" cellspacing="0">
<tr><th align="left" width="30%">Strategy Status (<cfoutput>#thisRptMon#</cfoutput>)</th>
<td width="70%"><cfoutput>#CurStatus.status#</cfoutput></td>
</tr>
</table>
</cfif>

<cfinclude template="rpt_collabs.cfm">







<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="dispForumA">
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
num, promotion

	from forum
	
	where month2 = '#thisRptMon#'
			AND  userid = '#Guserid#'
			and activity = '#Gactivity#'
			and year2 = #session.fy#	
	
</cfquery>



<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="dispForum">
	select 
seq as seq2,
fkforum, 
isNull(format,0) as format,
isNull(setting,0) as setting,
isNull(series,0) as series,
numEvents ,
countyEvent ,
isNull(eventT,0) as eventT,
isNull(commFocus,0) as commFocus,
isNull(target, 0) as target,
isNull(num, 0) as num,
isNull(promotion, 3) as promotion 
from forum_det
where fkforum=#dispForumA.seq#



	

	
</cfquery>




<cfoutput>
<cfif dispForum.recordcount GT 0>
<cfif CurStatus.status NEQ "Planning">
<table border=".5" cellspacing="0" width="100%">
<tr>
	<th colspan="9"> Strategy Implementation Status</th>
</tr>
<tr>
	
	<th >Format</th>
	<th >Setting</th>
	<th >Counties</th>
	<th >Tobacco Related</th>
	<th >Focus of Tobacco communication</th>
	<th >Target Audience</th>
	<th>## reached</th>
	<th>Event Promotion?</th>
</tr>

<cfloop query="dispForum">

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qformats">
	select descr, num
	from LU_forum_format
	where year2=#session.fy#
	and num in (#dispForum.format#)
	order by rank
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qsettings">
	select descr, num
	from LU_forum_setting
	where year2=#session.fy#
	and num in(#dispForum.setting#)
	order by rank
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qfocus">
	select descr, num
	from LU_forum_focus
	where year2=#session.fy#
	and num in(#dispForum.commFocus#)
	order by rank
</cfquery>


<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="counties5">
	select CountyName, FIPS from counties
	where FIPS in (#dispForum.countyevent#) 
	order by 1
	
</cfquery>

<cfquery datasource="#application.DataSource#"  		
				 
				password="#application.db_password#"   		
				username="#application.db_username#" name="detail_targets2">
				select descrip
				from campaignTarget
				where 
				num in (#dispForum.target#)	
				and year2=#session.fy#
</cfquery>

<tr>
	
	<td>#valuelist(Qformats.descr)#</td>
	<td>#valuelist(Qsettings.descr)#</td>
	<td>
	#valuelist(counties5.CountyName)#
	<cfif listfind(dispForum.countyevent,"88888")>, Counties beyond catchment area </cfif>
	<cfif listfind(dispForum.countyevent,"99999")>, Distant from catchment area </cfif>
	</td>
	<td><cfif eventT EQ "1">Yes<cfelse>No</cfif></td>
	<td>#valuelist(Qfocus.descr)#</td>
	<td>#valuelist(detail_targets2.descrip)#*</td>
	<td>#num#</td>
	<td>
		<cfif dispforum.promotion EQ 0>No
		<cfelseif dispforum.promotion EQ 1>Yes
		<cfelse>
			N/A
		</cfif>
	</td>
</tr>


<cfif dispforum.promotion EQ 1>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="checkOutreach">
	
	select 
	descr as type, county, target, o.seq, month2, r.rank
	from OUTREACH as o, lu_outreach_media as m, months as r
	where activity = '#QGenDescrip.activity#'
	and userid = '#QGenDescrip.userid#'
	and month2  = '#thisRptMon#'
	and o.year2= '#session.fy#'	
	and o.fk_forum_det=#seq2#
	and o.year2=m.year2
	and o.type=m.num
	and month2=r.mon
	order by r.rank
</cfquery>



<cfif checkOutreach.recordcount GT 0>
	<tr>
		<td>&nbsp;</td>
		<th colspan="3">Event Promotion</th>
		<td colspan="5">&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<th width="36%">Type of Promotion Material / Medium</th>
		<th width="34%">Counties targeted by that Medium</th>
		<th>Target Audience</th>
		<td colspan="5">&nbsp;</td>
	</tr>
	
	
	<cfloop query="checkOutreach" >
	<tr>
		<td>&nbsp;</td>
		<td> #type#</td>
		<td>
		<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="countyDetails">
	select CountyName from counties
	where FIPS in (#county#)
	order by 1	
	</cfquery>
		
		#valuelist(countyDetails.countyname)#
		
		</td>
		
		<cfquery datasource="#application.DataSource#"  		
				 
				password="#application.db_password#"   		
				username="#application.db_username#" name="detail_targets_outr">
				select descrip
				from campaignTarget
				where 
				num in (#target#)	
				and year2=#session.fy#
			</cfquery>

	<td>#valuelist(detail_targets_outr.descrip,'<br>')#</td>
	<td colspan="5">&nbsp;</td>
</tr>
		
	</cfloop> 
	



</cfif>

</cfif>
</cfloop>
</table>
</cfif>
</cfif>
</cfoutput>







<!--- insert earnedmedia --->
<cfinclude template="rpt_sub_earnedmedia.cfm">
</cfif>
</cfloop>
<br style="page-break-before:always;">



</form>


