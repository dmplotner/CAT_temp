<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
	<title>Infrastructure Report</title>
	<link rel="stylesheet" href="print.css" type="text/css" media="print"> 
	<LINK rel="stylesheet" type"text/css" href="screen.css" media="screen">
	<!--- <cfinclude template="CATstruct.cfm"> --->
	
</head>
<body>
<!--- <cfset tablename="govt">
<cfset focusareaNum="1">
 --->
<cfset focusareaNum="0">
 
<cfinclude template="rpt_header_fa.cfm">

<!--- <cfinclude template="rpt_sub_head_query_mod.cfm"> --->
<!--- <cfif isDefined("form.area") and form.area NEQ "ALL">
<cfquery datasource="#application.DataSource#" 		 
		password="#application.db_password#"   		
		username="#application.db_username#" name="QAreas">
		select s.userid, s.seq
		from security as s, contact as c
		where s.area='#form.area#'	
		and c.userid=s.userid
		<cfif isdefined("form.modality") and form.modality NEQ "ALL">
		and c.partnertype = #session.modality#
		<!--- <cfelseif isdefined("session.modality") and session.modality NEQ "ALL">
		and c.partnertype = #session.modality# --->
		<cfelseif cgi.HTTP_REFERER contains "reporthandler_modSP.cfm">
		and c.partnertype =4
		</cfif>	
</cfquery> --->
<cfif isDefined("form.region") and  form.region NEQ "ALL">
<cfquery datasource="#application.DataSource#" 		 
		password="#application.db_password#"   		
		username="#application.db_username#" name="QAreas">
		select s.userid, s.seq
		from security as s, contact as c, area as a, region as r
		where s.area=a.num
		and a.year2=2009
		and r.year2=a.year2
		and a.region=r.num
		and r.num=#form.region#
		and c.userid=s.userid
		<cfif isdefined("form.modality") and form.modality NEQ "ALL">
		and c.partnertype = #session.modality#
		<!--- <cfelseif isdefined("session.modality") and session.modality NEQ "ALL">
		and c.partnertype = #session.modality# --->
		<cfelseif cgi.HTTP_REFERER contains "reporthandler_modSP.cfm">
		and c.partnertype =4
		</cfif>	
</cfquery>
</cfif>

<cfquery datasource="#application.DataSource#"  		 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QinfraDet">
	select infra_monthly.userid,it_con,staff_time,staff_job_desc,staff_recruit,
	staff_interview,staff_hired,partner_recruit,
	partner_maint,fiscal_voucher,fiscal_track, barriers, progress, success, 
	tcp_con, tcp_am, tcp_rm, tcp_sccm, tcp_rscm, tcp_ann, tcp_msm, tcp_ybm,
	evalstatus, web_maint, web_hit, web_comment,
	sust_1, sust_2, sust_3, sust_4,
	sust_1_txt, sust_2_txt, sust_3_txt, sust_4_txt, month2, orgname, region.region as region
	from infra_monthly, months, contact,
	security
	left outer join area on area.num=security.area and area.year2=#session.def_fy#
	left outer join region on region.num = area.region and region.year2=#session.def_fy#
	where 	
	month2=mon
	and infra_monthly.userid=contact.userid
	and contact.userid=security.userid
	and
	
	<cfif isDefined("form.partner") and form.partner NEQ "ALL">
	
		(infra_monthly.userid='#form.partner#')
		and
	<!--- <cfelseif form.area NEQ "ALL"> --->
	<cfelseif form.region NEQ "ALL">
		<cfif QAreas.recordcount NEQ 0 >
			(infra_monthly.userid in (#QuotedValueList(QAreas.userid)#)) and				
		<cfelse>
			infra_monthly.userid=' ' and
		</cfif>
	</cfif>
	infra_monthly.year2=#session.fy#
	and contact.partnertype=4
	and infra_monthly.month2 in (#quotedValueList(QMonlist.Mon)#)
	order by region.region, orgname, sp_rank
</cfquery>


<cfif QinfraDet.recordcount GT 0>
<cfloop query="QinfraDet">
<cfset thisRptMon = month2 >
<cfset Guserid=QinfraDet.userid>
<br><br>


<!--- <cfquery datasource="#application.DataSource#"   
	password="#application.db_password#"  
	username="#application.db_username#" name="QinfraDet">
	select it_con,staff_time,staff_job_desc,staff_recruit,
	staff_interview,staff_hired,partner_recruit,
	partner_maint,fiscal_voucher,fiscal_track, barriers, progress, success, 
	tcp_con, tcp_am, tcp_rm, tcp_sccm, tcp_rscm, tcp_ann, tcp_msm, tcp_ybm,
	evalstatus, web_maint, web_hit, web_comment,
	sust_1, sust_2, sust_3, sust_4,
	sust_1_txt, sust_2_txt, sust_3_txt, sust_4_txt
	from infra_monthly
	where 
	userid='#Guserid#'
	and month2= '#thisRptMon#'
	and year2= #session.fy#
	order by seq
</cfquery> --->

	
	<cfquery datasource="#application.DataSource#"   
	password="#application.db_password#"  
	username="#application.db_username#" name="traindet">
	select topic, isNull(tfocus,0) as tfocus, tdate, isNull(trecip, 0) as trecip, isNull(ttrain, 0) as ttrain, tlen, tattend1, tattend2, partnerSpons, seq
	from infra_det_train
	where year2=#session.fy#
	and month2='#thisRptMon#'
	and userid='#Guserid#'
	order by seq
	</cfquery>



<cfif (isDefined("infrauser") and infrauser NEQ Guserid) or NOT isdefined("infrauser")>
<cfif isDefined("infrauser")>
<br style="page-break-before:always;">
</cfif>
<table border=".5" width="98.5%" cellspacing="0" title="Training">
<tr>
	<th align="left">Partner Name: <cfoutput>#orgname#</cfoutput></th>
</tr>
<tr>
	<td>Region: <cfoutput>#<!--- area --->region#</cfoutput></td>
</tr>

</table>

</cfif>



<table border=".5" width="98.5%" cellspacing="0" title="Training">

<tr>
	<td colspan="9"><div align="center"><strong>Training <cfoutput>(#thisRptMon#)</cfoutput></strong></div></td>
</tr>
<tr>
	<td colspan="9">Were any infrastructure trainings received or conducted this month?
		<input type="radio"  value="1"  <cfif isDefined("QinfraDet.it_con") and QinfraDet.it_con EQ "1"> checked</cfif> disabled>Yes
		<input type="radio"  value="0"  <cfif not isDefined("QinfraDet.it_con") or (isDefined("QinfraDet.it_con") and QinfraDet.it_con EQ "0") or QinfraDet.it_con EQ ""> checked</cfif> disabled>No
	</td>
</tr>
	<cfif isDefined("QinfraDet.it_con") and QinfraDet.it_con EQ "1" and traindet.recordcount GT 0>
<tr>
					<td>Training Name</td>
					<td>Training Focus</td>
					<td>Training Date</td>
					<td>Training Recipients</td>
					<td>Trainer</td>
					<td>Session Length<br>(hrs/session)</td>
					<td>Did you conduct this training?</td>
					<td>If yes, # of attendees</td>
					<td>If no, # of your staff who attended</td>
	</tr>
				
<cfoutput>
<cfloop query="traindet">
				
	
	<cfquery datasource="#application.DataSource#"  
	 password="#application.db_password#" 
	 username="#application.db_username#" name="focusdet">
		select  descr as focusdescrip
		from lu_infra_focus
		where num in (#tfocus#)
		and year2=#session.fy#
	</cfquery>
	<cfquery datasource="#application.DataSource#"  
	 password="#application.db_password#" 
	 username="#application.db_username#" name="trainingRecipDet">
		select  descr as trainingdescrip
		from lu_infra_train_recip
		where num in (#trecip#)		
		and year2=#session.fy#
	</cfquery>
	<cfquery datasource="#application.DataSource#"  
	 password="#application.db_password#" 
	 username="#application.db_username#" name="trainerDet">
		select  descr as trainer
		from lu_infra_trainer
		where num in (#Ttrain#)	
		and year2=#session.fy#	
	</cfquery>
				<tr>					
					<td>#topic#</td>
					<td>#valuelist(focusdet.focusdescrip, '<br>')#</td>
					<td>#dateformat(tdate,'m/d/yyyy')#</td>					 
					<td>#valuelist(trainingRecipDet.trainingdescrip)#</td>
					<td>#valuelist(trainerDet.trainer)#</td>
					<td>#tlen#</td>
					<td><cfif partnerSpons EQ "1">Yes<cfelse>No</cfif></td>
					<td>#tattend1#</td>					
					<td>#tattend2#</td>					
				</tr>
				</cfloop>
				</cfoutput>
				</cfif>
				</table>
				
			
			<!-- TCP meetings --->
			
			
			
			
			
			
			
			<table border=".5" width="98.5%" cellspacing="0"  title="TCP Meetings">
<tr>
		<td colspan="2"><div align="center"><strong>TCP Meetings <cfoutput>(#thisRptMon#)</cfoutput></strong></div></td>
	</tr>
	<tr>
	<td colspan="2">Was your organization represented at any Tobacco Control Program meetings this month?
		<input type="radio"  value="1"  <cfif isDefined("QinfraDet.tcp_con") and QinfraDet.tcp_con EQ "1"> checked</cfif> disabled>Yes
		<input type="radio"  value="0"  <cfif not isDefined("QinfraDet.tcp_con") or (isDefined("QinfraDet.tcp_con") and QinfraDet.tcp_con EQ "0") or QinfraDet.tcp_con EQ ""> checked</cfif> disabled>No
	</td>
</tr>
	
			<cfif isDefined("QinfraDet.tcp_con") and QinfraDet.tcp_con EQ "1">&nbsp;
			
				<tr>
					<td>Area Meeting</td>
					<td>
					    <input type="Radio"  value="1" <cfif isDefined("QinfraDet.tcp_am") and QinfraDet.tcp_am EQ "1">checked</cfif> disabled>Yes&nbsp;&nbsp;&nbsp;
						<input type="Radio" value="0" <cfif isDefined("QinfraDet.tcp_am") and QinfraDet.tcp_am EQ "0">checked</cfif>  disabled>No &nbsp;&nbsp;&nbsp;
						<input type="Radio"  value="2" <cfif (isDefined("QinfraDet.tcp_am") and QinfraDet.tcp_am EQ "2") or Not isDefined("QinfraDet.tcp_am")>checked</cfif> disabled>NA
					</td>
				</tr>
				<tr>
					<td>Regional Meeting</td>
					<td>
					    <input type="Radio"  value="1" <cfif isDefined("QinfraDet.tcp_rm") and QinfraDet.tcp_rm EQ "1">checked</cfif> disabled>Yes&nbsp;&nbsp;&nbsp;
						<input type="Radio"  value="0" <cfif isDefined("QinfraDet.tcp_rm") and QinfraDet.tcp_rm EQ "0">checked</cfif>  disabled>No &nbsp;&nbsp;&nbsp;
						<input type="Radio"  value="2" <cfif (isDefined("QinfraDet.tcp_rm") and QinfraDet.tcp_rm EQ "2") or Not isDefined("QinfraDet.tcp_rm")>checked</cfif> disabled>NA
					</td>
				</tr>
				<tr>
					<td>Statewide Coordinating Committee Meeting</td>
					<td>
					    <input type="Radio" value="1" <cfif isDefined("QinfraDet.tcp_sccm") and QinfraDet.tcp_sccm EQ "1">checked</cfif> disabled>Yes&nbsp;&nbsp;&nbsp;
						<input type="Radio"  value="0" <cfif isDefined("QinfraDet.tcp_sccm") and QinfraDet.tcp_sccm EQ "0">checked</cfif> disabled >No &nbsp;&nbsp;&nbsp;
						<input type="Radio"  value="2" <cfif (isDefined("QinfraDet.tcp_sccm") and QinfraDet.tcp_sccm EQ "2") or Not isDefined("QinfraDet.tcp_sccm")>checked</cfif> disabled>NA
					</td>
				</tr>
				<tr>
					<td>Regional Steering Comittee Meeting</td>
					<td>
					    <input type="Radio" value="1" <cfif isDefined("QinfraDet.tcp_rscm") and QinfraDet.tcp_rscm EQ "1">checked</cfif> disabled>Yes&nbsp;&nbsp;&nbsp;
						<input type="Radio"  value="0" <cfif isDefined("QinfraDet.tcp_rscm") and QinfraDet.tcp_rscm EQ "0">checked</cfif> disabled >No &nbsp;&nbsp;&nbsp;
						<input type="Radio"  value="2" <cfif (isDefined("QinfraDet.tcp_rscm") and QinfraDet.tcp_rscm EQ "2") or Not isDefined("QinfraDet.tcp_rscm")>checked</cfif> disabled>NA
					</td>
				</tr>
				<tr>
					<td><Cfif session.fy GTE 2007>TCP Statewide Meeting<Cfelse>TCP Annual Meeting</Cfif></td>
					<td>
					    <input type="Radio" value="1" <cfif isDefined("QinfraDet.tcp_ann") and QinfraDet.tcp_ann EQ "1">checked</cfif> disabled>Yes&nbsp;&nbsp;&nbsp;
						<input type="Radio"  value="0" <cfif isDefined("QinfraDet.tcp_ann") and QinfraDet.tcp_ann EQ "0">checked</cfif> disabled >No &nbsp;&nbsp;&nbsp;
						<input type="Radio"  value="2" <cfif (isDefined("QinfraDet.tcp_ann") and QinfraDet.tcp_ann EQ "2") or Not isDefined("QinfraDet.tcp_ann")>checked</cfif> disabled>NA
					</td>
				</tr>
				
				<tr>
					<td>Modality-specific meeting</td>
					<td>
					    <input type="Radio"  value="1" <cfif isDefined("QinfraDet.tcp_msm") and QinfraDet.tcp_msm EQ "1">checked</cfif> disabled>Yes&nbsp;&nbsp;&nbsp;
						<input type="Radio"  value="0" <cfif isDefined("QinfraDet.tcp_msm") and QinfraDet.tcp_msm EQ "0">checked</cfif>  disabled>No &nbsp;&nbsp;&nbsp;
						<input type="Radio"  value="2" <cfif (isDefined("QinfraDet.tcp_msm") and QinfraDet.tcp_msm EQ "2") or Not isDefined("QinfraDet.tcp_msm")>checked</cfif> disabled>NA
					</td>
				</tr>
				
				<tr>
					<td><Cfif session.fy GTE 2007>Regional / Statewide Youth Meeting<Cfelse>Youth board meeting</Cfif></td>
					<td>
					    <input type="Radio"  value="1" <cfif isDefined("QinfraDet.tcp_ybm") and QinfraDet.tcp_ybm EQ "1">checked</cfif> disabled>Yes&nbsp;&nbsp;&nbsp;
						<input type="Radio" value="0" <cfif isDefined("QinfraDet.tcp_ybm") and QinfraDet.tcp_ybm EQ "0">checked</cfif>  disabled>No &nbsp;&nbsp;&nbsp;
						<input type="Radio"  value="2" <cfif (isDefined("QinfraDet.tcp_ybm") and QinfraDet.tcp_ybm EQ "2") or Not isDefined("QinfraDet.tcp_ybm")>checked</cfif> disabled>NA
					</td>
				</tr>
				</cfif>
	</table>
			
			
			
			<!--  Staffing --->
			<table border=".5" width="98.5%" cellspacing="0"  title="Training">
				<tr>
					<td colspan="2"><div align="center"><strong>Staffing <cfoutput>(#thisRptMon#)</cfoutput></strong></div>
					</td>
				</tr>
				<tr>
					<td>Was any time spent on staffing activities this month?
					</td>
					<td>
						<input type="radio"  value="1"<cfif isDefined("QinfraDet.staff_time") and QinfraDet.staff_time EQ "1"> checked</cfif> DISABLED>Yes
						<input type="radio" value="0" <cfif not isDefined("QinfraDet.staff_time") or (isDefined("QinfraDet.staff_time") and QinfraDet.staff_time EQ "0") or QinfraDet.staff_time EQ ""> checked</cfif>  DISABLED>No
					</td>
				</tr>
				<cfif isDefined("QinfraDet.staff_time") and QinfraDet.staff_time EQ "1">
				<tr>
					<td>-Developed job descriptions?
					</td>
					<td>
						<input type="radio"  value="1"<cfif isDefined("QinfraDet.staff_job_desc") and QinfraDet.staff_job_desc EQ "1"> checked</cfif> DISABLED>Yes
						<input type="radio"  value="0" <cfif not isDefined("QinfraDet.staff_job_desc") or (isDefined("QinfraDet.staff_job_desc") and QinfraDet.staff_job_desc EQ "0") or QinfraDet.staff_job_desc EQ ""> checked</cfif> DISABLED>No
					</td>
				</tr>
				<tr>
					<td>-Recruited and/or advertised for an open position?
					</td>
					<td>
						<input type="radio"  value="1"<cfif isDefined("QinfraDet.staff_recruit") and QinfraDet.staff_recruit EQ "1"> checked</cfif> DISABLED>Yes
						<input type="radio"  value="0" <cfif not isDefined("QinfraDet.staff_recruit") or (isDefined("QinfraDet.staff_recruit") and QinfraDet.staff_recruit EQ "0") or QinfraDet.staff_recruit EQ ""> checked</cfif> DISABLED>No
					</td>
				</tr>
				<tr>
					<td>-Interviewed for an open position?
					</td>
					<td>
						<input type="radio"  value="1"<cfif isDefined("QinfraDet.staff_interview") and QinfraDet.staff_interview EQ "1"> checked</cfif> DISABLED>Yes
						<input type="radio"  value="0" <cfif not isDefined("QinfraDet.staff_interview") or (isDefined("QinfraDet.staff_interview") and QinfraDet.staff_interview EQ "0") or QinfraDet.staff_interview EQ ""> checked</cfif> DISABLED>No
					</td>
				</tr>
				<tr>
					<td>-Hired for an open position?
					</td>
					<td>
						<input type="radio"  value="1"<cfif isDefined("QinfraDet.staff_hired") and QinfraDet.staff_hired EQ "1"> checked</cfif> DISABLED>Yes
						<input type="radio"  value="0" <cfif not isDefined("QinfraDet.staff_hired") or (isDefined("QinfraDet.staff_hired") and QinfraDet.staff_hired EQ "0") or QinfraDet.staff_hired EQ ""> checked</cfif>  DISABLED>No
					</td>
				</tr>
				</cfif>
			
			</table>
			
			
			
			
			<!---  Partnership Maintenance  ---->



<cfquery datasource="#application.DataSource#"  
	 password="#application.db_password#" 
	 username="#application.db_username#" name="QDetEvent">
	select type, num_ind, num_org, seq
	from infra_det_partner_event
	where year2=#session.fy#
	and month2='#thisRptMon#'
	and userid='#Guserid#'
	order by seq
</cfquery>

<cfquery datasource="#application.DataSource#"  
	 password="#application.db_password#" 
	 username="#application.db_username#" name="QDetActivity">
	select type, seq, comment
	from  infra_det_partner_activity
	where year2=#session.fy#
	and month2='#thisRptMon#'
	and userid='#Guserid#'
	order by seq
</cfquery>
<tr><td>
<table border=".5" width="98.5%" cellspacing="0" title="Partnership Building">
<tr>
		<td colspan="3"><div align="center"><strong>Partnership Building and Maintenance <cfoutput>(#thisRptMon#)</cfoutput></strong></div>
		</td>
	</tr>
	<tr>
	<th colspan="3" align="left">Were any new members (organizations or individuals) recruited this month?
		<input type="radio"  value="1"<cfif isDefined("QinfraDet.partner_recruit") and QinfraDet.partner_recruit EQ "1"> checked</cfif> disabled>Yes
		<input type="radio"  value="0" <cfif not isDefined("QinfraDet.partner_recruit") or (isDefined("QinfraDet.partner_recruit") and QinfraDet.partner_recruit EQ "0") or QinfraDet.partner_recruit EQ ""> checked</cfif> disabled>No
	</th>
</tr>
	
			<cfif isDefined("QinfraDet.partner_recruit") and QinfraDet.partner_recruit EQ "1">
			
				<tr>
					<th rowspan="2">Outreach opportunities</th>
					<th colspan="2">Number recruited</th>
				</tr>
				<tr>
					<th>Individuals</th>
					<th>Organizations</th>
				</tr>
				
				<cfif QDetEvent.recordcount GT 0>
				<cfoutput>
				<cfloop query="QDetEvent">
				<cfquery datasource="#application.DataSource#"  
				 password="#application.db_password#" 
				 username="#application.db_username#" name="QtypeEventDet">
				select descr	
				from lu_infra_typeEvent
				where year2=#session.fy#
				and num=#type#
				order by rank
				</cfquery>
				<tr>
					<td>#QtypeEventDet.descr#</td>
					<td>#num_ind#</td>
					<td>#num_org#</td>
					
				</tr>
				</cfloop>					
				</cfoutput>	
				</cfif>
				
				</cfif>
			
		
		<tr>
	<th colspan="3" align="left">Were any partnership maintenance activities conducted this month?
		<input type="radio" value="1"<cfif isDefined("QinfraDet.partner_maint") and QinfraDet.partner_maint EQ "1"> checked</cfif> disabled>Yes
		<input type="radio" value="0" <cfif not isDefined("QinfraDet.partner_maint") or (isDefined("QinfraDet.partner_maint") and QinfraDet.partner_maint EQ "0") or QinfraDet.partner_maint EQ ""> checked</cfif> disabled>No
	</th>
</tr>
	
			<cfif isDefined("QinfraDet.partner_maint") and QinfraDet.partner_maint EQ "1">
			
				<tr>
					<th>Type of Activity</th>
					<th colspan="2">Comments</th>
				</tr>
				
				
				<cfif QDetActivity.recordcount GT 0>
				<cfoutput>
				<cfloop query="QDetActivity">
				<cfquery datasource="#application.DataSource#"  
				 password="#application.db_password#" 
				 username="#application.db_username#" name="QtypeActivityDet">
				select descr	
				from lu_infra_typeActivity
				where year2=#session.fy#
				and num=#type#
				order by rank
				</cfquery>
				<tr>
					<td>#QtypeActivityDet.descr#</td>
					<!--- <td>#num_attend#</td>
					<td>#dateformat(date2,'m/d/yyyy')#</td> --->
					<td colspan="2">#comment#</td>					
				</tr>
				</cfloop>	
						
				</cfoutput>	
				</cfif>
				
				
				</cfif>			
	</table>


<!--- fiscal management --->
<table border=".5" width="98.5%" cellspacing="0" title="fiscal management">
				<tr>
					<td colspan="2"><div align="center"><strong>Fiscal Management <cfoutput>(#thisRptMon#)</cfoutput></strong></div>
					</td>
				</tr>
				<tr>
					<td width="30%">Have you submitted vouchers this month?
					</td><td width="70%">
						<input type="radio"  value="1"<cfif isDefined("QinfraDet.fiscal_voucher") and QinfraDet.fiscal_voucher EQ "1"> checked</cfif> disabled>Yes
						<input type="radio"  value="0" <cfif not isDefined("QinfraDet.fiscal_voucher") or (isDefined("QinfraDet.fiscal_voucher") and QinfraDet.fiscal_voucher EQ "0") or QinfraDet.fiscal_voucher EQ ""> checked</cfif> disabled>No
					</td>
				</tr>
				<tr>
					<td>Are your budget expenditures on track?
					</td><td>
						<input type="radio" value="1"<cfif isDefined("QinfraDet.fiscal_track") and QinfraDet.fiscal_track EQ "1"> checked</cfif> disabled>Yes
						<input type="radio"  value="0" <cfif not isDefined("QinfraDet.fiscal_track") or (isDefined("QinfraDet.fiscal_track") and QinfraDet.fiscal_track EQ "0") or QinfraDet.fiscal_track EQ ""> checked</cfif> disabled>No
					</td>
				</tr>			
			</table>
			
			
<!--- website devel --->			
<cfif session.fy GT 2005>
<table border=".5" width="98.5%" cellspacing="0" title="Website development/maintenance">
				<tr>
					<td><div align="center"><strong>Website Development/Maintenance <cfoutput>(#thisRptMon#)</cfoutput></strong></div>
					</td>
				</tr>
				<tr>
					<td>Was any time spent working on your website this month?
						<input type="radio"  value="1"<cfif isDefined("QinfraDet.web_maint") and QinfraDet.web_maint EQ "1"> checked</cfif> disabled>Yes
						<input type="radio" value="0" <cfif not isDefined("QinfraDet.web_maint") or (isDefined("QinfraDet.web_maint") and QinfraDet.web_maint EQ "0") or QinfraDet.web_maint EQ ""> checked</cfif> disabled>No
					</td>
				</tr>		
				<cfif isDefined("QinfraDet.web_maint") and QinfraDet.web_maint EQ "1">
				<tr>
					<td>Number of website hits this month: <cfoutput>#QinfraDet.web_hit#</cfoutput></td>
				</tr>
				<tr>
					<td>Comments:<br>
					<cfoutput>#QinfraDet.web_comment#</cfoutput>
					</td>
				</tr>				
				</cfif>	
			</table>
		
			<table border=".5" width="98.5%" cellspacing="0" title="Sustainability">
				<tr>
				<td colspan="2">
					<div align="center"><strong>Sustainability Efforts <cfoutput>(#thisRptMon#)</cfoutput></strong></div>
				</td>
				</tr>
				<tr>
					<td>
					Did you correspond (via newsletters, mailings, press releases, etc.) with local legislators this month?
					<input type="radio"  value="1" <cfif isDefined("QinfraDet.sust_1") and QinfraDet.sust_1 EQ "1"> checked</cfif> disabled>Yes 
					<input type="radio" value="0"<cfif NOT isDefined("QinfraDet.sust_1") or (isDefined("QinfraDet.sust_1") and QinfraDet.sust_1 NEQ "1")> checked</cfif> disabled>No
					
					<br>Additional Details:<br>
					<cfoutput>#QinfraDet.sust_1_txt#</cfoutput>
					</td>
				</tr>
				
				
				<tr>
					<td>
					Did you submit a letter to the editor this month?
					<input type="radio"  value="1"<cfif isDefined("QinfraDet.sust_2") and QinfraDet.sust_2 EQ "1"> checked</cfif> disabled>Yes &nbsp;
					<input type="radio"  value="0"<cfif NOT isDefined("QinfraDet.sust_2") or (isDefined("QinfraDet.sust_2") and QinfraDet.sust_2 NEQ "1")> checked</cfif> disabled>No
					<br>Additional Details:<br>
					<cfoutput>#QinfraDet.sust_2_txt#</cfoutput>
					</td>
				</tr>
				<tr>
					<td>
					Did you meet with media representatives this month?
					<input type="radio"  value="1"<cfif isDefined("QinfraDet.sust_3") and QinfraDet.sust_3 EQ "1"> checked</cfif> disabled>Yes &nbsp;
					<input type="radio"  value="0"<cfif NOT isDefined("QinfraDet.sust_3") or (isDefined("QinfraDet.sust_3") and QinfraDet.sust_3 NEQ "1")> checked</cfif> disabled>No
					
					<br>Additional Details:<br>
					<cfoutput>#QinfraDet.sust_3_txt#</cfoutput>
					</td>
				</tr>
				<tr>
					<td>
					Did you make an in-person legislative visit this month?
					<input type="radio"  value="1"<cfif isDefined("QinfraDet.sust_4") and QinfraDet.sust_4 EQ "1"> checked</cfif> disabled>Yes &nbsp;
					<input type="radio" value="0"<cfif NOT isDefined("QinfraDet.sust_4") or (isDefined("QinfraDet.sust_4") and QinfraDet.sust_4 NEQ "1")> checked</cfif> disabled>No
					
					<br>Additional Details:<br>
				<cfoutput>#QinfraDet.sust_4_txt#</cfoutput>
				</td>
					
				</tr>
			</table>
		
	</cfif>
	
	<!---  progress/successes/barriers --->
	<cfif trim(QinfraDet.progress) NEQ ""  or trim(QinfraDet.success) NEQ "" or trim(QinfraDet.barriers) NEQ "">
<table border=".5" width="98.5%" cellspacing="0">
<tr>
<td width="27%">Strategy Progress (<cfoutput>#thisRptMon#</cfoutput>)</td>
<td><cfoutput>#QinfraDet.progress#</cfoutput></td>
</tr>
<tr>
<td>Reasons for Success (<cfoutput>#thisRptMon#</cfoutput>)</td>
<td><cfoutput>#QinfraDet.success#</cfoutput></td>
</tr>
<tr>
<td>Barriers (<cfoutput>#thisRptMon#</cfoutput>)</td>
<td><cfoutput>#QinfraDet.barriers#</cfoutput></td>
</tr>
</table>
</cfif>

<cfset infrauser=Guserid>


</cfloop>
<cfelse>
<br>
<div align="center"><h2>There are no data for this report</h2></div>

</cfif>
</body>
</html>