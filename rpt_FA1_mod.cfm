

<!--- Strategy specific --->
 <cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qissues">
	select descrip 
	from GovtIssues
	<!--- where num='#QGenDescrip.issues#' --->
	where num='#issues#'
	
</cfquery>

<!--- <cfif QGenDescrip.levelchangesought NEQ ""> --->
<cfif levelchangesought NEQ "">
 <cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qlevel">
	select descr 
	from LWPCS
	<!--- where num=#QGenDescrip.levelchangesought# --->
	where num=#levelchangesought#
	 
</cfquery>

</cfif>

<tr>
<td>Issues addressed</td>
<td colspan="3"><cfoutput>#Qissues.descrip#</cfoutput></td>
</tr>

<tr>
<td>Level change sought</td>
<td colspan="3">
<cfif isDefined("Qlevel.descr")><cfoutput>#Qlevel.descr#</cfoutput><cfelse>&nbsp;</cfif></td>
</tr>
<!--- end strategy specific --->

<!--- collaboration level include --->
<cfinclude template="rpt_sub_collablevel.cfm">
<!--- end collaboration level include --->
<cfinclude template="rpt_sub_planning.cfm">

<cfif QmonList.recordcount GT 0>
<br>
</cfif>
<cfloop query="Qmonlist">

<cfset thisRptMon=mon>

<cfquery datasource="#application.DataSource#"	 
	password="#application.db_password#"   		
	username="#application.db_username#" 
	name="checkMon">
	select count(*) as count
	from GOVT	
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
<cfinclude template="rpt_collabs.cfm">
</cfif>
<cfif rtype EQ "monthly">
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="dispActivity">
	select activity, d.descrip as target,  c.descrip as channel, commCount, impactCount, a.seq
	from DirEdActTarget as a, govtdmakers as d, govtcommchannel as c
	<!--- where userid= '#QGenDescrip.userid#' 
	and activity = '#QGenDescrip.activity#' --->
	where userid= '#Guserid#' 
	and activity = '#Gactivity#'
	and month2 ='#thisRptMon#'
	and a.year2 = #session.fy#
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
	from motivAct as m, govtAStake as s, govtcommchannel as C
	<!--- where userid= '#QGenDescrip.userid#' 
	and activity = '#QGenDescrip.activity#' --->
	where userid= '#Guserid#' 
	and activity = '#Gactivity#'
	and month2 ='#thisRptMon#'
	and m.year2 = #session.fy#
	and m.year2=s.year2
	and m.year2=c.year2
	and m.stakeholders=s.num
	and m.channel=c.num
	order by 1, 2, 3
	
</cfquery>




<cfif dispActivity.recordcount GT 0 OR dispActivity2.recordcount GT 0>
<table border=".5" width="100%" cellspacing="0">
<tr><th colspan="4" align="left">Strategy Implementation Status (<cfoutput>#thisRptMon#</cfoutput>)</th></tr>
<cfif dispActivity.recordcount GT 0>
<tr><td colspan="4" class="head1">Direct Education Activities and Targets</td></tr>
<tr>
<td width="35%">Individuals Targeted</td>	
<td width="25%">Communications Channel</td>
<td width="20%"># of times channel was Used</td>
<td width="20%"># of Targeted individuals impacted</td>
</tr>
<cfoutput>
<cfloop query="dispActivity">
<tr>
	<td>#target#</td>
	<td>#channel#</td>
	<td align="center">#commCount#</td>
	<td align="center">#impactCount#</td>
</tr>
</cfloop>
</cfoutput>
</cfif>
<cfif dispActivity2.recordcount GT 0>
<tr><td colspan="4" class="head1">Motivating other organizations</td></tr>
<tr>
<td>Stakeholders who can influence</td>	
<td>Communications Channel</td>
<td># of times channel was Used</td>
<td># of organizations impacted</td>
</tr>
<cfoutput>
<cfloop query="dispActivity2">
<tr >
	<td>#stakeholders#</td>
	<td>#channel#</td>
	<td>#commCount#</td>
	<td>#impactCount#</td>
</tr>
</cfloop>
</cfoutput>
</cfif>
</table>
</cfif>
<cfelse> <!--- monthly reports--->
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="dispActivity">
	select m.rank, activity, d.descrip as target,  c.descrip as channel, commCount, impactCount, a.seq, month2
	from DirEdActTarget as a, govtdmakers as d, govtcommchannel as c, months as m
	<!--- where userid= '#QGenDescrip.userid#' 
	and activity = '#QGenDescrip.activity#' --->
	where userid= '#Guserid#' 
	and activity = '#Gactivity#'
	and a.year2 = #session.fy#
	and d.year2=a.year2
	and c.year2=a.year2
	and a.target=d.num
	and a.channel=c.num
	and month2=m.mon
	and month2 ='#thisRptMon#'
	order by 1, 2, 3, 4
	
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="dispActivity2">
	select z.rank,activity, s.descrip as stakeholders, c.descrip as channel, commCount, impactCount, m.seq, month2
	from motivAct as m, govtAStake as s, govtcommchannel as C, months as z
	<!--- where userid= '#QGenDescrip.userid#' 
	and activity = '#QGenDescrip.activity#' --->
	where userid= '#Guserid#' 
	and activity = '#Gactivity#'
	and m.year2 = #session.fy#
	and m.year2=s.year2
	and m.year2=c.year2
	and m.stakeholders=s.num
	and m.channel=c.num
	and month2=z.mon
	and month2 ='#thisRptMon#'
	order by 1, 2, 3, 4
	
</cfquery>
<cfif dispActivity.recordcount GT 0 OR dispActivity2.recordcount GT 0>
<table border=".5" width="100%" cellspacing="0">
<tr><th colspan="5" align="left">Strategy Implementation Status (<cfoutput>#thisRptMon#</cfoutput>)</th></tr>
<cfif dispActivity.recordcount GT 0>
<tr><td colspan="4" class="head1">Direct Education Activities and Targets</td></tr>
<tr>
<!--- <td width="10%">Month</td> --->
<td width="35%">Individuals Targeted</td>	
<td width="25%">Communications Channel</td>
<td width="20%"># of times channel was Used</td>
<td width="20%"># of Targeted individuals impacted</td>
</tr>
<cfoutput>
<cfloop query="dispActivity">
<tr>
	<!--- <td>#month2#</td> --->
	<td>#target#</td>
	<td>#channel#</td>
	<td align="center">#commCount#</td>
	<td align="center">#impactCount#</td>
</tr>
</cfloop>
</cfoutput>
</cfif>
<cfif dispActivity2.recordcount GT 0>
<tr><td colspan="4" class="head1">Motivating other organizations</td></tr>
<tr>
<!--- <td>Month</td> --->
<td>Stakeholders who can influence</td>	
<td>Communications Channel</td>
<td># of times channel was Used</td>
<td># of organizations impacted</td>
</tr>
<cfoutput>
<cfloop query="dispActivity2">
<tr >
	<!--- <td>#month2#</td> --->
	<td>#stakeholders#</td>
	<td>#channel#</td>
	<td>#commCount#</td>
	<td>#impactCount#</td>
</tr>
</cfloop>
</cfoutput>
</cfif>
</table>
</cfif>
</cfif>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qimpactprogress">
	
select number1,number2, number3, number4,
impact_action, impact_action_txt,
impact_imp, impact_imp_txt
from GOVT	
<!--- where userid= '#QGenDescrip.userid#' 
	and activity = '#QGenDescrip.activity#' --->
	where userid= '#Guserid#' 
	and activity = '#Gactivity#'
	and month2 ='#thisRptMon#'
	and year2 = #session.fy#
</cfquery>



<cfif Qimpactprogress.recordcount GT 0 and (Qimpactprogress.number2 NEQ "" and Qimpactprogress.number3 NEQ "" and Qimpactprogress.number1 NEQ "" )>
<table border=".5" width="100%" cellspacing="0">
<tr><th colspan="6" align="left" >Impacts on Decision-Makers (<cfoutput>#thisRptMon#</cfoutput>)</th></tr>
<tr>
<td width="27%"># commit to study</td>
<td width="6%"><cfoutput>#Qimpactprogress.number1#&nbsp;</cfoutput></td>
<td width="27%"># commit to consider public health impact</td>
<td width="6%"><cfoutput>#Qimpactprogress.number2#&nbsp;</cfoutput></td>
<td width="27%"># commit to protect public health</td>
<td><cfoutput>#Qimpactprogress.number3#</cfoutput>&nbsp;</td>
</tr>
</table>

<table border=".5" width="100%" cellspacing="0">
<tr><th colspan="2" align="left">Impacts on policy/practice implementation this month (<cfoutput>#thisRptMon#</cfoutput>)</th></tr>
<tr>
<td width="27%">Did Decision-maker(s) take action this month?
</td>
<td>
<cfif Qimpactprogress.impact_action EQ 0>No.<cfelse>Yes:&nbsp;</cfif><cfoutput>#Qimpactprogress.impact_action_txt#</cfoutput>
</td>
</tr>
<tr>
<td width="27%">Was a new policy/practice/resolution implemented or strengthened this month?
</td>
<td>
<cfif Qimpactprogress.impact_imp EQ 0>No.<cfelse>Yes:&nbsp;</cfif><cfoutput>#Qimpactprogress.impact_imp_txt#</cfoutput>
</td>
</tr>
</table>
</cfif>
<!--- end strategy specific --->
<!--- Begin closing stock section --->




<!--- insert earnedmedia --->
<cfinclude template="rpt_sub_earnedmedia.cfm">
</cfif>

</cfloop>
<br style="page-break-before:always;">



</form>

