<!--- <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
	<link rel="stylesheet" href="print.css" type="text/css" media="print"> 
	<LINK rel="stylesheet" type"text/css" href="screen.css" media="screen">

</head>

<body> --->

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="strat_campaign_targets">
	select target, seq
	from strat_campaignTarget
	where 
	userid= '#QGenDescrip.userid#' 
	and activity = '#activity#'
	and year2=#session.fy#
	order by seq	
</cfquery>



<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="stratpurp">
select descrip 
from cess_purp 
where stratnum = #focusareaNum#
and targnum = #QGenDescrip.targetgroup#
and purpNum in (#QGenDescrip.purpose#)
and year2=#session.rptyr#
</cfquery>



<cfquery datasource="#Application.DataSource#"  		 
	password="#Application.db_password#"   		
	username="#Application.db_username#" name="targetQ">
	
	select target
	from targets 
	where strategyNum=#focusareaNum#
	and  targetNum = #QGenDescrip.targetgroup#
	and year2=#session.fy#
	order by 1, rank
</cfquery>
<cfif isDefined("QGenDescrip.pollevel") and QGenDescrip.pollevel NEQ "">
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="pol_level">
select descrip	
from cess_level 
where year2=#session.fy#
and num=#QGenDescrip.pollevel#
</cfquery>
</cfif>
<tr>
	<td>Target</td>
	<td colspan="3"><cfoutput>
			<cfloop query="targetQ">
				#target#<br>
			</cfloop>
		</cfoutput>&nbsp;</td>
</tr>
<tr>
	<td>Purpose of Strategy
		</td>
	<td colspan="3"><cfoutput>#stratpurp.descrip#</cfoutput>&nbsp;
		
	</td>
</tr>

<tr>
	<td>Level change sought</td>
	<td colspan="3"><cfif isDefined("pol_level")><cfoutput>#pol_level.descrip#&nbsp;</cfoutput></cfif>&nbsp;</td>
</tr>






<!--- collaboration level include --->
<cfinclude template="rpt_sub_collablevel.cfm">
<!--- end collaboration level include --->
<cfinclude template="rpt_sub_planning.cfm">
<!--- Check to see if this is HCPO or NOT --->
 <cfif QGenDescrip.targetgroup EQ 1 and QGenDescrip.goal EQ 3>
 	<cfloop query="Qmonlist">

<cfset thisRptMon=mon>
<cfquery datasource="#application.DataSource#"	 
	password="#application.db_password#"   		
	username="#application.db_username#" 
	name="checkMon">
	select count(*) as count
	from advoc	
	<!--- where userid= '#QGenDescrip.userid#' 
	and activity = '#QGenDescrip.activity#' --->
	where userid= '#Guserid#' 
	and activity = '#Gactivity#'
	and month2 ='#thisRptMon#'
	and year2 = #session.fy#
	
</cfquery>

<cfif checkMon.count GT 0>
 	<cfinclude template="temp_hcpo_queries_etc.cfm">
	</cfif>
	</cfloop>
 
 
<cfelse>









<!--- 
<cfif QmonList.recordcount GT 0>
<br>
</cfif> --->
<cfloop query="Qmonlist">

<cfset thisRptMon=mon>
<cfquery datasource="#application.DataSource#"	 
	password="#application.db_password#"   		
	username="#application.db_username#" 
	name="checkMon">
	select count(*) as count
	from advoc	
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





<!--- end strategy specific --->
<!--- Begin closing stock section --->
<br>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="advoc_details">
select advoc_target as target, advoc_method as advocacy, advoc_catchment as counties, 
advoc_num_method as num_advoc, advoc_num_impacted as num_targets, seq, month2, m.rank
from detail_dir_advoc, months as m
where userid= '#Guserid#' 
	and activity = '#Gactivity#'
	and month2= '#thisRptMon#'
	and year2=#session.fy# 
	and month2=m.mon
order by m.rank,seq	
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="indirect_details">
	select target, method as method2, county, num_method, num_target, seq, month2, m.rank
	from persuasion, months as m
	where userid= '#Guserid#' 
	and activity = '#Gactivity#'
	and month2= '#thisRptMon#'
	and year2=#session.fy# 
	and month2=m.mon
	order by m.rank, seq	
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="advocValues">
	select TOP 1 reported, assess_survey, training, surveys,
	impact_study, impact_none, impact_change, impact_commit, impact_neg,
	num_study, num_change, num_commit, num_neg, month2, m.rank, 
	impact_action, impact_action_txt, impact_imp, impact_imp_txt, assess_survey
	from advoc, months as m
	where userid= '#Guserid#' 
	and activity = '#Gactivity#'
	and month2= '#thisRptMon#'
	and year2=#session.fy# 
	and month2=m.mon
	order by m.rank, seq

	
</cfquery>


<table border=".5" width="100%" cellspacing="0">
<cfoutput query="advocValues">
<tr>
	<td>
	Was a survey conducted initially to determine baseline status, and to identify those firms "needing" change?
	</td>
	<td>Yes <input type="checkbox" <cfif advocValues.assess_survey EQ "1">checked</cfif> disabled> No <input type="checkbox" <cfif advocValues.assess_survey EQ "0">checked</cfif> disabled></td>
	</td>
</tr>
</cfoutput>
</table>

<cfif advoc_details.recordcount GT 0 or indirect_details.recordcount GT 0>
<table border=".5" width="100%" cellspacing="0">
<tr><th colspan="5" align="left">Strategy Implementation Status (<cfoutput>#thisRptMon#</cfoutput>)</th></tr>

<cfif advoc_details.recordcount GT 0>
<tr><td colspan="5" class="head1">Direct Advocacy of target Organizations</td></tr>
<tr>
	<td>Purpose of strategy</td>
	<td>Advocacy Method</td>
	<td>Counties of Residence of Targets</td>
	<td># of Advocacy method used</td>
	<td># of Target organizations impacted</td>
</tr>
<cfoutput>
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
	u.userid = '#Guserid#' 
	and u.activity = '#Gactivity#'	
	and u.targetgroup = p.targnum
	and p.purpnum in(#target#)
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

<tr>
	<td>#advoc_targetdescrip.descrip#&nbsp;</td>
	<td>#advoc_method_Descrip.descrip#&nbsp;</td>
	<td>#valuelist(counties2.CountyName)#&nbsp;</td>
	<td>#num_advoc#&nbsp;</td>
	<td>#num_targets#&nbsp;</td>
</tr>
</cfloop>
</cfoutput>
</cfif>



<cfif indirect_details.recordcount GT 0>
<tr><td colspan="5" class="head1">InDirect Advocacy of target Organizations</td></tr>
<tr>
	<td>Targets</td>
	<td>Method of Communications</td>
	<td>Counties of Residence of Targets</td>
	<td># of times Communication channel was used</td>
	<td># of organizations/individuals impacted</td>
</tr>


<cfoutput>
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

<tr>
	<td>#indirect_targetdescrip.descrip#</td>
	<td>#indirect_method_Descrip.descrip#</td>
	<td>#valuelist(counties3.CountyName)#</td>
	<td>#num_method#</td>
	<td>#num_target#</td>
</tr>
</cfloop>
</cfoutput>
</cfif>
</table>
</cfif>


<br>
<cfif advocValues.recordcount GT 0>
<table border=".5" width="100%" cellspacing="0">
<tr>
	<td colspan="4" class="head1">Impacts on Decision-Makers (<cfoutput>#thisRptMon#</cfoutput>)</td></tr>
	
	<cfoutput>
	
	<cfloop query="advocValues">
	<tr>
		<td>## commit to study issues</td>
		<td>#num_study#&nbsp;</td>
		<td>## commit to change policy/practice</td>
		<td>#num_change#&nbsp;</td>
	</tr>
	<tr>
		<td>## commit expand/strengthen policy/practice</td>
		<td>#num_commit#&nbsp;</td>
		<td>## refuse to change policy/practice</td>
		<td>#num_neg#&nbsp;</td>
	</tr>
	</cfloop>
	</cfoutput>
</table>
<br>
</cfif>
<table border=".5" width="100%" cellspacing="0">
<cfloop query="advocValues">
<tr>
	<th colspan="2"><cfoutput>#thisRptMon#</cfoutput></th>
</tr>
<tr>
	
	<td width="75%">
	T-A provided to organizations committed to change policy/practice.
	</td>
	<td width="25%">Yes <input type="checkbox" <cfif advocValues.training EQ "1">checked</cfif> disabled> No <input type="checkbox" <cfif advocValues.training EQ "0">checked</cfif> disabled></td>
	</td>
</tr>
<tr>
	<td>
	Partner monitors or conducts surveys to determine the extent to which organizations were implementing improved policies or practices.
	</td>
	<td>Yes <input type="checkbox" <cfif advocValues.surveys EQ "1">checked</cfif> disabled> No <input type="checkbox" <cfif advocValues.surveys EQ "0">checked</cfif> disabled></td>
	</td>
</tr>



<tr>
	<td>
	Did decision maker(s) take action this month?
	</td>
	<td>Yes <input type="checkbox" <cfif advocValues.impact_action EQ "1">checked</cfif> disabled> No <input type="checkbox" <cfif advocValues.impact_action EQ "0">checked</cfif> disabled></td>
	<br>
	<cfoutput>#advocValues.impact_action_txt#</cfoutput>
	</td>
</tr>

<tr>
	<td>
	Was a new policy/practice/resolution implemented or strenghtened this month?
	</td>
	<td>Yes <input type="checkbox" <cfif advocValues.impact_imp EQ "1">checked</cfif> disabled> No <input type="checkbox" <cfif advocValues.impact_imp EQ "0">checked</cfif> disabled></td>
	<br>
	<cfoutput>#advocValues.impact_imp_txt#</cfoutput>
	</td>
</tr>
</cfloop>
</table>

<br>
<cfinclude template="rpt_sub_earnedmedia.cfm">
</CFIF>
</cfloop>
</cfif>

<br style="page-break-before:always;">



</form>



</body>
</html>
