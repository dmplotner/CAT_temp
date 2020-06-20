<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>PM Report</title>
	<cfinclude template="CATstruct.cfm">








<cfoutput>
<div align="center"><h2>Paid Media report as of #dateformat(now(),'mmm dd,yyyy')#</h2></div>
<table class="boxg" border=".1">
<tr bgcolor="silver">
<td>Partner Name</td>
<td>strategy name</td>
<td>month</td>
<td>Campaign Channel</td>
<td>Title of spot</td>
<td>Source of content</td>
<td>Intensity Measure</td>
<td>Length of Spot</td>
<td>Counties</td>
<td>Campaign Cost</td>
<td>GRP</td>
<td>Flight dates-START</td>
<td>END</td>
<td>Target</td>
</tr>



<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="dispCampaign">
	select  cast(g.campcat as integer) as ccat, g.month2,u.userid, u.activity, c.orgname, g.campcost
campchannel, pm.descrip as campCat, s.descrip as campSource,

campCount, campCounty, campCost, g.seq, intenseCount,
	campTitle, grp, flightStart, flightEnd, pm.num as channel_num
	

from useractivities as u, contact as c, campaign as g, pmcampchan as pm, pmcamps as s, months as m
	where u.strategy=2
	and u.userid=c.userid
	and u.year2=#session.fy#	
and g.userid=u.userid
and g.activity=u.activity
and g.year2=u.year2
and pm.year2=u.year2
and pm.num=g.campcat
and s.year2=u.year2
and s.num=g.campsource
and g.month2=m.mon
	order by 1,g.campcost,m.rank
	
	
</cfquery>

<cfloop query="dispCampaign">
<cfset usern=dispCampaign.userid>
<cfset activ=dispCampaign.activity>


<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="strat_campaign_targets">
	select target, seq
	from strat_campaignTarget
	where 
	activity = '#dispCampaign.activity#'
	and userid='#dispCampaign.userid#'
	and year2=#session.fy#
	order by seq	
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="counties">
	select CountyName from counties
	where FIPS in<cfif campCounty NEQ "">(#campCounty#)<cfelse>(0)</cfif> 
	order by 1	
</cfquery>

<tr >
		<td>#orgname#</td>
		
		<td>#activ#</td>
		<td>#month2#</td>
		<td>#campCat#&nbsp;</td>
		<td>#campTitle#&nbsp;</td>
		<!--- <td>#campChannel#&nbsp;</td> --->
		<td>#campSource#&nbsp;</td>
		<td>#campCount#&nbsp;</td>
		<td>#intenseCount#&nbsp;</td>
		<cfif channel_num EQ 13>
		<cfquery datasource="#application.DataSource#"  		
		 
		password="#application.db_password#"   		
		username="#application.db_username#" name="FMcounties">
		select distinct countyname
		from counties as c, fm_data as d
		where d.fips=c.fips
		and call='#campChannel#'
		order by 1	
		</cfquery>
		<td>#valuelist(FMcounties.countyname, '<br>')#&nbsp;</td>
		
		<cfelseif channel_num EQ 1>
		<cfquery datasource="#application.DataSource#"  		
		 
		password="#application.db_password#"   		
		username="#application.db_username#" name="TVcounties">
		select distinct countyname
		from counties as c, tv_data as d
		where d.fips=c.fips
		and call='#campChannel#'
		order by 1	
		</cfquery>
		
		
		<td>#valuelist(TVcounties.countyname, '<br>')#&nbsp;</td>
		
		
		
		<cfelse>
		<td>#valuelist(counties.CountyName, '<br>')#&nbsp;</td>
		</cfif>
		<td>$#campCost#&nbsp;</td>		
		<td>#grp#&nbsp;</td>
		<td>#dateformat(flightStart,'m/d/yyyy')#</td>
		<td>#dateformat(flightEnd,'m/d/yyyy')#</td>
		

		
<cfif strat_campaign_targets.recordcount GT 0>
<td>
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

	Target Audience #CurrentRow#: #valuelist(detail_targets.descrip,', ')#<br>

</cfloop>
</td>
<cfelse>
	<td></td>
</cfif>
</tr>
</cfloop>



</table>
</cfoutput>

</body>
</html>
