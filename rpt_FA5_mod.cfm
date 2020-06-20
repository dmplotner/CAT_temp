<!--- <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Focus Area Report</title>
	<link rel="stylesheet" href="print.css" type="text/css" media="print"> 
	<LINK rel="stylesheet" type"text/css" href="screen.css" media="screen">
	<cfinclude template="CATstruct.cfm">


<cfinclude template="rpt_sub_head_query.cfm">

<cfif QGenDescrip.recordcount GT 0>
<cfloop query="QGenDescrip">

<cfinclude template="rpt_sub_genhead.cfm"> --->

  <cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="GetTarget">
SELECT keyNum as targetNum, target
  FROM monitorTarget 
  where year2=#session.fy#
  and keyNum in(#QGenDescrip.target2#)
 order by 1
 
</cfquery>
 
<!--- <cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="GetFoci">
SELECT keyNum as focusNum, Foci
  FROM monitorFocus
  WHERE year2=#session.rptyr#
 </cfquery> --->


 <cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="GetFoci2">
SELECT keyNum as focusNum, Foci
  FROM monitorFocus
  where year2=#session.fy#
  and seq in (#QGenDescrip.foci#)
 </cfquery>
 
 



<tr>
      <td>Target Organizations:</td>
      <td colspan="3">   
            <cfoutput query="getTarget" >
               #target#<br>
            </cfoutput>
      &nbsp;</td>
</tr>

<tr>
   <td>Focus of Monitoring:</td>
   <td colspan="3">
	  <cfoutput>
	  <cfloop query="GetFoci2">
            #foci#<br>
      </cfloop>
	  </cfoutput>
   &nbsp;</td>
</tr>



<tr>
<td>Primary or Secondary data collection:</td>
<td colspan="3">
	<cfif (isDefined("QGenDescrip.primSec") and QGenDescrip.primSec EQ "1") OR (NOT isDefined("QGenDescrip.primSec"))> Primary
	<cfelseif isDefined("QGenDescrip.primSec") and QGenDescrip.primSec EQ "2">Secondary</cfif>&nbsp;
</td>
</tr> 




<!--- #valuelist(detail_targets.descrip)#<br> --->






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
	from Monitor	
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
	username="#application.db_username#" name="retMOnDet">
	select r.rank, <!--- z.foci as mType2 ---> mType2, impCounties, 
	a.descrip as assessmentM, i.descrip as sindividuals, numBus, m.seq, m.month2
	from MonitorDet as m, mon_assess as a, mon_indiv as i, <!--- monitorfocus as z , ---> months as r
	where
	month2 = '#thisRptMon#'
	and m.year2='#session.fy#' 
	and	m.year2=a.year2
	and m.year2=i.year2
	<!--- and m.year2=z.year2 --->
	and activity='#QGenDescrip.activity#'
	and userid='#QGenDescrip.userid#'
	and m.assessmentM= a.rank 
	and m.sindividuals = i.rank
	<!--- and mtype2=z.seq --->
	and month2=r.mon
	order by 1
	
</cfquery>


<cfif retMonDet.recordcount GT 0>

<cfquery datasource="#application.DataSource#"  	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="retMOnDet2">
	select monstatus, monstart
	from Monitor
	where
	month2 = '#thisRptMon#'
	and year2='#session.fy#' 	
	and activity='#QGenDescrip.activity#'
	and userid='#QGenDescrip.userid#'
</cfquery>
<tr>
<td>
<table border=".5" width="100%" cellspacing="0">
	<tr>
		<td>Has the assessment/monitoring actually started?
		&nbsp;&nbsp;&nbsp;<input type="checkbox" name="monstatus" value="1"<cfif (isDefined("retMonDet2.monstatus") and retMonDet2.monstatus EQ "1")> checked</cfif> disabled>Yes
		&nbsp;<input type="checkbox" name="monstatus" value="0"<cfif (isDefined("retMonDet2.monstatus") and retMonDet2.monstatus EQ "0")> checked</cfif> disabled>No
		</td>
	</tr>
	<cfif (isDefined("retMonDet2.monstatus") and retMonDet2.monstatus EQ "1")>
	<tr>
		<td>
			If yes, what was the start date? <cfoutput>#dateformat(retMonDet2.monstart,"m/d/yyyy")#</cfoutput>
		</td>
	</tr>
	
	</cfif>
</table>
</td>
</tr>

<tr>
<td>
<table border=".5" cellspacing="0" width="100%">
<tr>
	<th colspan="5" align="left">Strategy Implementation Status (<cfoutput>#thisRptMon#</cfoutput>)</th>
</tr>
<tr>
	
	<td width="25%">Assessment/Monitoring Focus</td>
	<td width="18%">Counties Targets Reside in</td>
	<td width="17%">Assessment Method</td>
	<td width="17%">Survey which Organizations</td>
	<td width="13%"># Organizations Reached</td>
</tr>
<cfoutput>
<cfloop query="retMonDet">
<cfquery datasource="#application.DataSource#"  		
		 
		password="#application.db_password#"   		
		username="#application.db_username#" name="QMtype2">
		select foci 
		from monitorfocus
		where seq in (#mType2#)
		order by 1	
		</cfquery>

<tr>
	
	<td>#valuelist(QMtype2.foci)#</td>
	<td>
		<cfquery datasource="#application.DataSource#"  		
		 
		password="#application.db_password#"   		
		username="#application.db_username#" name="countyDetails">
		select CountyName from counties
		where FIPS in (#impCounties#)
		order by 1	
		</cfquery>
		
		#valuelist(countyDetails.countyname)#
	</td>
	<td>#assessmentM#</td>
	<td>#sindividuals#</td>
	<td>#numBus#</td>
</tr>
</cfloop></cfoutput>
</table>
</cfif>
</cfif>
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="maxmonth5">
	
	select monstatus, monstart, incomp, disto, dischannel, status
	from Monitor
	where
	month2 = '#thisRptMon#'
	and year2='#session.fy#' 	
	and activity='#Gactivity#'
	and userid='#Guserid#'
	
	
	<!--- select max(d.rank) as mmonth, d.mon 
			from monthS as d, planning as A
			where d.mon = a.month2 
			AND  A.userid = '#Guserid#'
			and A.activity = '#Gactivity#'
			and A.year2 = #session.fy#
			and d.rank <= #form.endmonth#
			and d.rank >= #form.stmonth#
			group by d.mon --->
</cfquery>
<cfif maxmonth5.recordcount GT 0 and maxmonth5.status NEQ "">
<br>
<table border=".5" cellspacing="0" width="100%">
<tr>
	<td>Has dissemination of assessment/monitoring results been completed?</td>
	<td><cfif maxmonth5.incomp EQ 1>Yes<cfelse>No</cfif></td>
</tr>
<cfif maxmonth5.incomp EQ 1>
<tr>
	<td>Dissemination Channels:</td>
	<td> 
		<cfif maxmonth5.dischannel CONTAINS 1>Mailing<br></cfif>
		<cfif maxmonth5.dischannel CONTAINS 2>Websites<br></cfif>
		<cfif maxmonth5.dischannel CONTAINS 3>Emails<br></cfif>
		<cfif maxmonth5.dischannel CONTAINS 4>Handout at meeting<br></cfif>
		<cfif maxmonth5.dischannel CONTAINS 5>Drop off at supportive organization for distribution of posting<br></cfif>
	</td>	
</tr>
<tr>
	<td>Dissemination of survey/assessment to:</td>
	<td> 
		<cfif maxmonth5.disto CONTAINS 1>None<br></cfif>
		<cfif maxmonth5.disto CONTAINS 2>Business/organizations surveyed<br></cfif>
		<cfif maxmonth5.disto CONTAINS 3>Public/media<br></cfif>
		<cfif maxmonth5.disto CONTAINS 4>Regulatory agency<br></cfif>
	</td>
</tr>

</cfif>

</table>
</cfif>
<cfinclude template="rpt_sub_earnedmedia.cfm">
</cfloop>



















<!--- insert earnedmedia --->
<cfinclude template="rpt_sub_earnedmedia.cfm">

<br style="page-break-before:always;">


</form>
