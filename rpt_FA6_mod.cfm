<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
	<link rel="stylesheet" href="print.css" type="text/css" media="print"> 
	<LINK rel="stylesheet" type"text/css" href="screen.css" media="screen">

</head>

<body>

<!--- <cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="strat_campaign_targets">
	select target, seq
	from strat_campaignTarget
	where 
	userid= '#QGenDescrip.userid#' 
	and activity = '#activity#'
	and year2=#session.fy#
	order by seq	
</cfquery> --->

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="issues5">
	
select
descrip, num
from survey_issues
where year2=#session.rptyr#
and num in (#QGenDescrip.issuesAdd#)
order by rank

</cfquery>
<!---<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="GetTarget99">
	SELECT keyNum as targetNum, target
  FROM monitorTarget 
  where year2=#session.fy#
  and keyNum in(#QGenDescrip.target2#)
 order by 1
 
</cfquery>
 <cfoutput>
SELECT keyNum as targetNum, target
  FROM monitorTarget 
  where year2=#session.fy#
  and keyNum in(#QGenDescrip.target2#)
 order by 1
</cfoutput> --->

<tr>
      <td>Target:</td>
      <td colspan="3">
<!--- <cfoutput>
<br>
select descrip
	from campaignTarget
	where 
	num in (#QGenDescrip.target2#)	
	and year2=#session.fy#
<br><br>
select target, seq
	from strat_campaignTarget
	where 
	userid= '#QGenDescrip.userid#' 
	and activity = '#activity#'
	and year2=#session.fy#
	order by seq	<br>
<cfloop query="strat_campaign_targets">
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="detail_targets">
	select descrip
	from campaignTarget
	where 
	num in (#QGenDescrip.target2#)	
	and year2=#session.fy#
</cfquery>
#valuelist(detail_targets.descrip,', ')#<br>

</cfloop>
</cfoutput>   --->




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
#valuelist(detail_targets.descrip,', ')#<br>
</cfloop>
</cfoutput>

</cfif>











	  
<!--- 	   
            <cfoutput query="getTarget" >
               #target#<br>
            </cfoutput>
      &nbsp; --->
&nbsp; </td>
</tr>




<cfoutput>
<tr>
	<td>Issues Addressed</td>
	<td colspan="3">
		<cfloop query="issues5">
			#descrip#<br>
		</cfloop>
	</td>
</tr>
</cfoutput>








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
	from SurveyPub	
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
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="SurveyDetail">
	select 
	m.rank, characteristics, method as method2, counties, numreached, numCompleted, seq, month2
	from SurveyDetail, months as m
	where
	userid= '#Guserid#' 
	and activity = '#Gactivity#'
	and month2 ='#thisRptMon#'
	and year2=#session.fy# 
	and month2=m.mon
	order by 1
	
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="dissemstatus">
	select DisChannel
	from surveyPub
	where activity = '#Gactivity#'
	and userid = '#Guserid#' 
	and month2= '#thisRptMon#'		
	and year2= #session.fy# 
	</cfquery>
<br>
<table border=".5" width="100%" cellspacing="0">
<tr><th colspan="6" align="left">Strategy Implementation Status (<cfoutput>#thisRptMon#</cfoutput>)</th></tr>

<tr><td colspan="6" class="head1">Survey data </td></tr>
<tr>
	
	<td>Target Audience</td>
	<td>Survey Method</td>
	<td>County(ies) of residence of those surveyed</td>
	<td># reached by method</td>
	<td># completed surveys</td>
</tr>
	
<cfoutput>
<cfloop query="SurveyDetail">
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="counties3">
	select CountyName from counties
	where FIPS in <cfif counties NEQ "">(#counties#)<cfelse>(0)</cfif> 
	order by 1
	
</cfquery>

 
<cfquery datasource="#application.DataSource#"  		
				 
				password="#application.db_password#"   		
				username="#application.db_username#" name="detail_targets_out">
				select descrip
				from campaignTarget
				where 
				num in (#characteristics#)	
				and year2=#session.fy#
			</cfquery> 

	<tr>
	
	<td> #valuelist(detail_targets_out.descrip,'<br>')#<!---   #characteristics# ---></td>
	<td>#method2#</td>
	<td>#valuelist(counties3.CountyName)#</td>
	<td>#numreached#</td>
	<td>#numCompleted#</td>
	
</tr>
</cfloop>
</cfoutput>
</table>
<br>
<cfif CurStatus.status NEQ "Planning">
<table border=".5" width="100%" cellspacing="0">
<tr>
	<td>Results Disseminated to:&nbsp;&nbsp;&nbsp;
	<cfif isdefined("dissemstatus.DisChannel") and listfind(dissemstatus.DisChannel,"0")> <input type="checkbox" checked disabled><cfelse> <input type="checkbox" disabled></cfif>None
		<cfif isdefined("dissemstatus.DisChannel") and listfind(dissemstatus.DisChannel,"1")> <input type="checkbox" checked disabled> <cfelse> <input type="checkbox" disabled></cfif>Results disseminated to public and to the media
		<cfif isdefined("dissemstatus.DisChannel") and listfind(dissemstatus.DisChannel,"2")> <input type="checkbox" checked disabled> <cfelse> <input type="checkbox" disabled></cfif>Results submitted to government agency
	</select></td>
</tr>
</table>
<br>
</cfif>
<cfinclude template="rpt_sub_earnedmedia.cfm">
</cfif>
</cfloop>
<br style="page-break-before:always;">



</form>



</body>
</html>
