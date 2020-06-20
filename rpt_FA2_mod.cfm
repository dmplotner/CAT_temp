<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Report</title>
	<link rel="stylesheet" href="print.css" type="text/css" media="print"> 
	<LINK rel="stylesheet" type"text/css" href="screen.css" media="screen">

</head>

<body>
<!--- <cfif not isdefined("target2") or trim(target2) EQ "">
	<cfset target3=0>
<cfelse>
	<cfset target3=target2>
</cfif>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="GetTarget">
	SELECT keyNum as targetNum, target
  FROM monitorTarget 
  where year2=#session.fy#
  and keyNum in (1)
 order by 1
 
</cfquery>

<tr>
      <td>Target Organizations:</td>
      <td colspan="3">  
	  	<cfif GetTarget.recordcount GT 0>
            <cfoutput query="getTarget" >
               #target#<br>
            </cfoutput>
		</cfif> 
      &nbsp;</td>
</tr>

 --->
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="strat_campaign_targets">
	select target, seq
	from strat_campaignTarget
	where 
	userid='#guserid#' 
	and activity = '#Gactivity#'	
	and year2=#session.fy#
	order by seq	
</cfquery>
<cfif strat_campaign_targets.recordcount GT 0>
<tr>
      <td>Target Audience:</td>
      <td colspan="3">
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
<!--- <tr>
	<td colspan="2" bgcolor="Silver">Target Audience #CurrentRow#: #valuelist(detail_targets.descrip,', ')#</td>
	<td bgcolor="Silver"><input type="Checkbox" name="del_target_seq" value="#seq#">Del</td>
</tr> --->
  
	  	<cfif detail_targets.recordcount GT 0>
            <cfoutput>
               #valuelist(detail_targets.descrip,', ')#<br>
            </cfoutput>
		</cfif>       
</cfloop>
&nbsp;</td>
</tr>
</cfif>
<!--- collaboration level include --->
<cfinclude template="rpt_sub_collablevel.cfm">
<!--- end collaboration level include --->
<cfinclude template="rpt_sub_planning.cfm">
<cfif QmonList.recordcount GT 0>
</cfif>
<cfloop query="Qmonlist">
<cfset thisRptMon=mon>
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
<!--- end strategy specific --->
<!--- Begin closing stock section --->
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="dispCampaign1">
	select  campChannel, c.descrip as campCat, s.descrip as campSource, 
	campCount, campCounty, campCost, a.seq, intenseCount,
	campTitle, grp, flightStart, flightEnd, month2, m.rank, grp, flightstart, flightend, s.descrip as source
	,circno, circtype, a.campcat as typeSpot
	from campaign as a, PMcampchan as c, pmcamps as s, months as m
	where userid= '#Guserid#' and activity = '#Gactivity#'
	<!--- and month2 in (#QuotedValuelist(Qmonlist.mon)#) --->
	and month2='#mon#'
	and a.year2 = #session.fy#
	and c.year2=#session.fy# 
	and s.year2=#session.fy#
	and a.campcat=c.num
	and a.campsource=s.num
	and month2=m.mon
	order by 14,1, 2, 3, 4, 5	
</cfquery>
<cfif dispCampaign1.recordcount gt 0>
<table border=".5" width="100%" cellspacing="0">
<tr><th colspan="11" align="left">Strategy Implementation Status</th></tr>
<tr><td colspan="11" class="head1">Media Details (<cfoutput>#mon#</cfoutput>)</td></tr>
<tr>
<!--- <td>Month</td> --->
<td width="21%">Campaign Channel</td>	
<td width="37%">Title of spot</td>
<td width="13%">Name of media channel</td>
<td>Source of content</td>
<td>Circulation</td>
<td colspan="2">Intensity Measures</td>
<td>Counties</td>
<td>Cost this month</td>
<td>GRP</td>
<td>Flight dates (start/end)</td>
</tr>
<cfoutput>
<cfloop query="dispCampaign1">
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="counties">
	select CountyName from counties
	where FIPS in<cfif campCounty NEQ "">(#campCounty#)<cfelse>(0)</cfif> 
	order by 1
	
</cfquery>
<tr>
<!--- <td>#month2#</td> --->
<td>#campcat#&nbsp;</td>
<td>#campTitle#&nbsp;</td>
<td>#campChannel#&nbsp;</td>
<td>#source#&nbsp;</td>
<td>#circno#&nbsp;<cfif circtype EQ 1>-Daily<cfelseif circtype EQ 1>-Weekly<cfelseif circtype EQ 3>-Other</cfif></td>
<td>#campCount#&nbsp;
<cfif typeSpot EQ "1"  OR typeSpot EQ "2" or typeSpot EQ "10">
spots
<cfelseif typeSpot EQ "3"  OR typeSpot EQ "4">
ads placed
<cfelseif typeSpot EQ "5"  OR typeSpot EQ "8">
locations
<cfelseif typeSpot EQ "6"  OR typeSpot EQ "11">
distributed
<cfelseif typeSpot EQ "7">
days run
<cfelseif typeSpot EQ "9">
length of time ad on website
<cfelseif typeSpot EQ "12">
pieces mailed
<cfelse>
spots
</cfif>
</td>
<td>#intenseCount#&nbsp;
<cfif typeSpot EQ "1"  OR typeSpot EQ "2" or typeSpot EQ "10">
(seconds)
<cfelseif typeSpot EQ "3"  OR typeSpot EQ "4">
(sq inches)
<cfelseif typeSpot EQ "5"  OR typeSpot EQ "8">
(days)
<cfelseif typeSpot EQ "6"  OR typeSpot EQ "11">

<cfelseif typeSpot EQ "7">
theaters
<cfelseif typeSpot EQ "9">
(days)
<cfelseif typeSpot EQ "12">

<cfelse>
length of spot
</cfif>

</td>
<td>#valuelist(counties.CountyName)#&nbsp;</td>
<td>#campCost#&nbsp;</td>
<td>#grp#&nbsp;</td>
<td>#dateformat(flightstart, "m/d/yyyy")#-#dateformat(flightend, "m/d/yyyy")#&nbsp;</td>
</tr>
</cfloop>
</cfoutput>
</table>
</cfif>
<cfinclude template="rpt_sub_earnedmedia.cfm">
</cfloop>
<br style="page-break-before:always;">
</form>
</body>
</html>
