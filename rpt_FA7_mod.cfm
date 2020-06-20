<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
	<link rel="stylesheet" href="print.css" type="text/css" media="print"> 
	<LINK rel="stylesheet" type"text/css" href="screen.css" media="screen">

</head>

<body>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="strat_campaign_targets">
	select target, seq
	from strat_campaignTarget
	where 
	userid= '#Guserid#' 
	and activity = '#Gactivity#'
	and year2=#session.fy#
	order by seq	
</cfquery>


<!--- <cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="GetTarget">
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
	<td>Type of promotion or provision of cesServ</td>
	<td colspan="3">
		<cfif QGenDescrip.typepromo EQ "1">Running a Quit & Win contest
		<cfelseif QGenDescrip.typepromo EQ "2">Provision of Cessation Services
		<cfelse>Promotion of Cessation Services
		</cfif>
	</td>
</tr>

<tr>
      <td>Target:</td>
      <td colspan="3">
<cfoutput>
<cfset typep=QGenDescrip.typepromo>
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
	  
<!--- 	   
            <cfoutput query="getTarget" >
               #target#<br>
            </cfoutput>
      &nbsp; --->
&nbsp; </td>
</tr>






<!--- collaboration level include --->
<cfinclude template="rpt_sub_collablevel.cfm">
<!--- end collaboration level include --->


<cfinclude template="rpt_sub_planning.cfm">


<!--- end strategy specific --->
<!--- Begin closing stock section --->
<br>



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
	from cessation	
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








<cfif typep EQ "1">
<tr><td>QW</td></tr>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="selQW">
	
	select  
	QWstart, QWend, lengthd, numPm, seq, fup, month2, m.rank
	from QWIN, months as m
	where userid= '#Guserid#' 
	and activity = '#Gactivity#'
	and month2 ='#thisRptMon#'
	and year2 = #session.fy#
	and month2=m.mon
	order by 8, 5
</cfquery>
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="checkOutreach">
	
	select 
	descr as type, county, target, o.seq, month2, r.rank
	from OUTREACH as o, lu_outreach_media as m, months as r
	where userid= '#Guserid#' 
	and activity = '#Gactivity#'
	and month2 ='#thisRptMon#'
	and o.year2= #session.fy#	
	and o.year2=m.year2
	and o.type=m.num
	and month2=r.mon
	order by 6

	
</cfquery>

<table border=".5" width="100%" cellspacing="0">
<tr><th colspan="4" align="left">Strategy Implementation Status</th></tr>

<tr><td colspan="4" class="head1">Quit and Win Contest Description <cfoutput>(#thisRptMon#)</cfoutput></td></tr>
<tr>
	
	<td colspan="2" align="center" >Q&W Contest Dates</td>
	<td rowspan="2">Q&W Contestant Followup</td>	
	<td rowspan="2"># contest participants</td>
</tr><br>
<tr>
	<td>Start Date</td>
	<td>End Date</td>
</tr>
<cfoutput>
<cfloop query="selQW">
<tr>
	<td>#dateformat(QWstart,'mm/dd/yyyy')#</td>
	<td>#dateformat(QWend,'mm/dd/yyyy')#</td>
	<td>
		<CFIF fup eq "1">
		By Quitline
		<CFELSEIF fup eq "2">
		Other: #lengthd#
		</CFIF>
	</td>
	<!--- <td>#lengthd#</td> --->
	<td>#numPm#</td>
	
</tr>
</cfloop>
</cfoutput>
</table>
<br>
<table border=".5" width="100%" cellspacing="0">


<tr><td colspan="3" class="head1">Event Promotion, Publicity or Outreach <cfoutput>(#thisRptMon#)</cfoutput></td></tr>
<tr>
	<td>Type of Promotion Material or Medium</td>
	<td>Counties Targeted</td>
	<td>Target Audience</td>
</tr>
<cfoutput>
	<cfloop query="checkOutreach" >
	<tr>
		<td>#type#</td>
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
		
		
		
	</tr>
		
	</cfloop> 
	</cfoutput>
</table>

<cfelseif typep EQ "2">



<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="selServ">
	select month2, 
	type,	
	target, numRecip, <!--- numQuit, --->  monStatus, a.seq, m.rank
	from provCess as a, months as m
	where userid= '#Guserid#' 
and activity = '#Gactivity#'
and month2 ='#thisRptMon#'
and year2 = #session.fy#
and month2=m.mon

	order by m.rank
</cfquery>

<table border=".5" width="100%" cellspacing="0">
<tr><th colspan="3" align="left">Strategy Implementation Status <cfoutput>(#thisRptMon#)</cfoutput></th></tr>
<tr>
	
	<td>Type of cessation service provided</td>
	<td>Target population</td>
	<td>Number of recipients</td>
</tr>
<cfoutput>
<cfloop query="selServ">
<cfquery datasource="#application.DataSource#"  		
				 
				password="#application.db_password#"   		
				username="#application.db_username#" name="detail_targetpop">
				select descrip
				from campaignTarget
				where 
				num in (#selServ.target#)	
				and year2=#session.fy#
			</cfquery>
<tr>

<td>
				<cfif listcontains(selServ.type,"1")>Brief advice from HCP<br></cfif>
				  <cfif listcontains(selServ.type,"2")>Face-to-face behavioral counseling (group or individual)<br></cfif>
				  <cfif listcontains(selServ.type,"3")>NRT (OTC) provided directly<br></cfif>
				  <cfif listcontains(selServ.type,"4")>NRT (OTC) voucher provided<br></cfif>
				  <cfif listcontains(selServ.type,"5")>Self-help materials provided<br></cfif>
				  <cfif listcontains(selServ.type,"6")>Telephone counseling<br></cfif>

</td>
<td>#valuelist(detail_targetpop.descrip)#</td>
<td>#numrecip#</td>

</tr>
</cfloop></cfoutput>
</table>
<br>






<cfelseif typep EQ "3">
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="selpromo1">
	
	select
	  
	f.descrip as focus, t.descrip as type, other, d.descrip as channel, numdist, 
	recipChar as targetChar, county , a.seq, month2, m.rank
	from promoCess as a, cess_focus as f, cess_type as t, cess_dissem as d, months as m
	where 
	userid= '#Guserid#' 
	and activity = '#Gactivity#'
	and month2 ='#thisRptMon#'
	and a.year2 = #session.fy#
	and a.year2=f.year2
	and a.year2=t.year2
	and a.year2=d.year2
	and div_org=0
	and a.focus = f.rank
	and a.type = t.rank
	and a.channel = d.rank
	and month2=m.mon
	order by m.rank
	
	 	
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="selpromo2">
    select f.descrip as focus, 
	o.descrip as targetOrg, numMaterial, 
	recipchar as targetChar, county , 
	a.seq from promoCess as a, cess_focus as f, 
	cess_torg as o where userid = '#Guserid#' 
	and activity = '#Gactivity#' and month2='#thisRptMon#' 
	and a.year2 = #session.fy# and a.year2=f.year2 
	and a.year2=o.year2 and div_org=1 and 
	a.focus = f.rank and a.targetOrg = o.rank order by 1
    </cfquery>


<table border=".5" width="100%" cellspacing="0">
<tr><th colspan="5" align="left">Promotion Direct to Public <cfoutput>(#thisRptMon#)</cfoutput></th></tr>
<tr>
	
	<td>Primary Promotional Focus</td>
	<td>Type of material Disseminated</td>
	<td>Dissemination Channel</td>
	<td>Target Recipients</td>
	<td>Counties where target recipients live</td>
</tr>
<cfoutput>
<cfloop query="selpromo1">
<tr>
<td>#focus#</td>
<td>#type#&nbsp;&nbsp;#other#</td>
<td>#channel#</td>
<!--- <td>#numdist#</td> --->
<cfquery datasource="#application.DataSource#"  		
				 
				password="#application.db_password#"   		
				username="#application.db_username#" name="detail_targets_out">
				select descrip
				from campaignTarget
				where 
				num in (#targetChar#)	
				and year2=#session.fy#
			</cfquery>

	<td>#valuelist(detail_targets_out.descrip,'<br>')#</td>

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

</tr>
</cfloop>
</cfoutput>
</table>







<cfif isDefined("selpromo2") and selpromo2.recordcount GT 0>
<table border=".5" width="100%" cellspacing="0">
<tr><th colspan="4" align="left">Promotion Through other Organizations <cfoutput>(#thisRptMon#)</cfoutput></th></tr>
<tr>	
	<td>Primary Promotional Focus</td>
	<td>Target Organizations</td>
	<td>Counties</td>
	<td>Ultimate Recipients</td>	
</tr>
        <cfoutput>
          <cfloop query="selpromo2">
            <tr>
                <td>#focus#</td>
			
			  <td>#targetorg#</td>
			
			  <td><cfquery datasource="#application.DataSource#" 
	password="#application.db_password#"   		
	username="#application.db_username#" name="countyDetails">
                select CountyName from counties where FIPS in (#county#) order by 1
                </cfquery>
                #valuelist(countyDetails.countyname)#</td>
			
              <!--- 		<td>#numMaterial#</td> --->
              <cfquery datasource="#application.DataSource#"  		
				 
				password="#application.db_password#"   		
				username="#application.db_username#" name="detail_targets_out">
              select descrip from campaignTarget where num in (#targetChar#)
			  and year2=#session.fy#
              </cfquery>
           
			  <td>#valuelist(detail_targets_out.descrip,'<br>')#</td>
			</tr>
            
          </cfloop>
        </cfoutput>
		</table>
		</cfif>










<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="seltarget">
select descrip
				from campaignTarget
				where 
				num in (<cfif isDefined("selServ.target") and selServ.target NEQ "">#selServ.target#<cfelse>999</cfif>)	
				and year2=#session.fy#
</cfquery>

<br>

</cfif>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="CessDetails">
select 
ISNULL(monStatus,'0') as monStatus, 
ISNULL(distIncent,'0') as distIncent,
ISNULL(direction,'0') as direction
from cessation
where userid= '#Guserid#' 
and activity = '#Gactivity#'
and month2 ='#thisRptMon#'
and year2 = #session.fy#

</cfquery>
<table border=".5" width="100%" cellspacing="0">
<tr><th colspan="2" align="left">Additional Aspects of Strategy</th></tr>
<tr>
	<td>
	Does this activity involve monitoring the status of smokers who are using cessation services?
	</td>
	<td>Yes <input type="checkbox" <cfif CessDetails.monstatus EQ "1">checked</cfif> disabled> No <input type="checkbox" <cfif CessDetails.monstatus EQ "0">checked</cfif> disabled></td>
</tr>
<tr>
	<td>
	Does this activity involve distributing incentives to smokers who are using cessation services
	<br>to remain smoke free?
	</td>
	<td>Yes <input type="checkbox" <cfif CessDetails.distIncent EQ "1">checked</cfif> disabled> No <input type="checkbox" <cfif CessDetails.distIncent EQ "0">checked</cfif> disabled></td>
</tr>
</table>

<br>
<cfinclude template="rpt_sub_earnedmedia.cfm">
</cfif>
</cfloop>
<br style="page-break-before:always;">

</form>



