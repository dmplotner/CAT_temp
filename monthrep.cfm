
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>
			CAT
		</title>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
		<style>
			.box { font-family: verdana, helvetica, sans-serif; font-size: 11px; border: solid 1px #CCCC99; list-style:inherit; border-collapse: collapse; } .boxy { font-family: verdana, helvetica, sans-serif; font-size: 11px; list-style:inheritborder-color : #498F49; } .box2 { font-family: verdana, helvetica, sans-serif; font-size: 11px; border: none; list-style:inherit; padding: 0px; spacing: 0px; }
		</style>
	</head>
	<body>
		<cfquery  NAME="QsetATFAC"
		 			DATASOURCE="#application.DataSource#"
         			USERNAME="#application.db_username#"
         			PASSWORD="#application.db_password#">

select userid from contact where partnertype in (1,2,3,6)
and userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">

</cfquery>
<cfif session.fy GT 2010 AND session.modality EQ 4>
	<cflocation addtoken="true" url="monthrepSP.cfm">
<cfelseif session.fy GTE 2016 AND NOT (
		QsetATFAC.recordcount GT 0 or session.userid is 'test_cc' or session.userid is 'dplotner' or session.userid is 'cschnefke' or session.userid is 'nsarris' or session.userid is 'lolson'
		or session.userid is 'eas10'  or session.userid is 'hbb01'  or session.userid is 'hrc01'  or session.userid is 'vxc04'  or session.userid is 'christina.peluso'  or session.userid is 'sep06'  or session.userid is 'hxr03'  or session.userid is 'yct01'  or session.userid is 'julie.wright'
		or (isDefined("session.origUserID") and (session.origUserID is 'test_cc' or session.origUserID is 'dplotner' or session.origUserID is 'cschnefke' or session.origUserID is 'nsarris' or session.origUserID is 'lolson'
		or  session.origUserid is 'eas10'  or session.origUserid is 'hbb01'  or session.origUserid is 'hrc01'  or session.origUserid is 'vxc04'  or session.origUserid is 'christina.peluso'  or session.origUserid is 'sep06'  or session.origUserid is 'hxr03'  or session.origUserid is 'yct01'  or session.origUserid is 'julie.wright' ) )
		<!--- session.userid is 'test_cc' or session.userid is 'dplotner' or session.userid is 'cschnefke' or session.userid is 'nsarris' or session.userid is 'lolson'
		or (isDefined("session.origUserID") and (session.origUserID is 'test_cc' or session.origUserID is 'dplotner' or session.origUserID is 'cschnefke' or session.origUserID is 'nsarris' or session.origUserID is 'lolson'
		) ) --->
		)>
	<cflocation addtoken="true" url="nofuture.cfm">
</cfif>

<cfif NOT(SESSION.areamanage EQ "1" OR SESSION.admin EQ "1" OR SESSION.TCP EQ "1" OR SESSION.CessMan CONTAINS "1" OR session.modality EQ 2 OR session.modality EQ 3 OR session.modality EQ 1 OR session.modality EQ 6) AND session.fy GTE 2018>
	<cflocation addtoken="true" url="nofuture.cfm">
</cfif>

<cfif session.fy GTE 2020 AND NOT
(session.userid is 'test_cc' or session.userid is 'dplotner' or session.userid is 'cschnefke'
or session.userid is 'nsarris' or session.userid is 'lolson'
		or (isDefined("session.origUserID")
		and (session.origUserID is 'test_cc' or session.origUserID is 'dplotner' or session.origUserID is 'cschnefke' or session.origUserID is 'nsarris' or session.origUserID is 'lolson'
		) ))>
	<cflocation addtoken="true" url="nofuture.cfm">
</cfif>

		<cfset session.mon = ''>
		<cfset session.objval = ''>
		<cfinclude template="CATstruct.cfm">
		<cfif isdefined("submit")>
			<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QcheckInsWG">
	select * from  monthly
	where userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and mon = <cfqueryparam value="#mo#" cfsqltype="CF_SQL_INTEGER">
	</cfquery>
			<cfif QcheckInsWG.recordcount EQ 0>
				<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QInsNewWG">
	insert into monthly (userid, year2, mon, summary)
	values
	(<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">, <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">, <cfqueryparam value="#mo#" cfsqltype="CF_SQL_INTEGER">, '')
	</cfquery>
			</cfif>
			<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QInsWG">
	update monthly set
	submitDT = <cfqueryparam value="#Now()#" cfsqltype="CF_SQL_DATE">
	where userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and mon = <cfqueryparam value="#mo#" cfsqltype="CF_SQL_INTEGER">

	update infra set
	submitDT = <cfqueryparam value="#Now()#" cfsqltype="CF_SQL_DATE">
	where userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and mon = <cfqueryparam value="#mo#" cfsqltype="CF_SQL_INTEGER">
	</cfquery>
			<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="CMEmail">
	select isNull(cc.email, 'dplotner@rti.org') as email ,
	  isNull(c.coordemail, 'dplotner@rti.org') as partneremail,
	isNull(c.superemail2, 'dplotner@rti.org') as superemail2
from contact c inner join contact cc
on c.cmanager = cc.userid
where c.userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
</cfquery>
<cfif #mo# eq 12>
<cfset duemth = 1>
<cfelse>
<cfset duemth = #mo# + 1>
</cfif>
			<CFIF (#mo# eq 7 or #mo# eq 8) and #session.fy# is '2018'>
				<cfset duedt = '9/30/2017'>
			<cfelseif  (#mo# eq 7) and #session.fy# is '2020'>
				<cfset duedt = '9/19/2018'>
			<cfelseif  (#mo# eq 8) and #session.fy# is '2020'>
				<cfset duedt = '10/3/2018'>

			<cfelse>
				<cfset duedt = #duemth# &'/'& '15' &'/'& #year(now())#>
			</cfif>

			<cfif duedt EQ '12/15/2009'>
				<cfset duedt = '12/31/2009'>
			</cfif>
<cfif #dateformat(now(),'m/d/yyy')# LTE #duedt#>
				<cfif session.modality eq 2>
					<cfmail from="NY Tobacco Control Program <NY-Tobacco-Control-Program@rti.org>"
to="#CMemail.email#" bcc="dplotner@rti.org,eas10@health.ny.gov" subject="#session.orgname# has submitted their CAT monthly report" type="HTML">
#session.orgname# has submitted their #MonthAsString(mo)# CAT monthly report on time. Please review the entries and provide appropriate feedback by the specified deadline.
</cfmail>
				<cfelseif session.modality eq 1 or session.modality eq 6>
					<cfmail from="NY Tobacco Control Program <NY-Tobacco-Control-Program@rti.org>"
to="#CMemail.email#" bcc="dplotner@rti.org,Julie.Wright@health.ny.gov" subject="#session.orgname# has submitted their CAT monthly report" type="HTML">
#session.orgname# has submitted their #MonthAsString(mo)# CAT monthly report on time. Please review the entries and provide appropriate feedback by the specified deadline.
</cfmail>
				<cfelse>
					<cfmail from="NY Tobacco Control Program <NY-Tobacco-Control-Program@rti.org>"
to="#CMemail.email#" bcc="dplotner@rti.org" subject="#session.orgname# has submitted their CAT monthly report" type="HTML">
#session.orgname# has submitted their #MonthAsString(mo)# CAT monthly report on time. Please review the entries and provide appropriate feedback by the specified deadline.
</cfmail>
				</cfif>
			<cfelseif #dateformat(now(),'m/d/yyy')# GT #duedt#>
				<cfif session.modality eq 2>
					<cfmail from="NY Tobacco Control Program <NY-Tobacco-Control-Program@rti.org>"
to="#CMemail.partneremail#" cc="#CMemail.email#; #CMemail.superemail2#" bcc="dplotner@rti.org,eas10@health.ny.gov" subject="#session.orgname# LATE SUBMISSION" type="HTML">
#session.orgname# - This email acknowledges receipt of your monthly CAT report for #MonthAsString(mo)#, which was submitted late to the State Health Department.
<br><br>
Submitting monthly reports on time is part of the agency contract requirements. Reports must be submitted on time every month to avoid delays in payment to the agency or other administration action.
</cfmail>
				<cfelseif session.modality eq 1 or session.modality eq 6>
					<cfmail from="NY Tobacco Control Program <NY-Tobacco-Control-Program@rti.org>"
to="#CMemail.partneremail#" cc="#CMemail.email#; #CMemail.superemail2#" bcc="dplotner@rti.org,Julie.Wright@health.ny.gov" subject="#session.orgname# LATE SUBMISSION" type="HTML">
#session.orgname# - This email acknowledges receipt of your monthly CAT report for #MonthAsString(mo)#, which was submitted late to the State Health Department.
<br><br>
Submitting monthly reports on time is part of the agency contract requirements. Reports must be submitted on time every month to avoid delays in payment to the agency or other administration action.
</cfmail>
				<cfelse>
					<cfmail from="NY Tobacco Control Program <NY-Tobacco-Control-Program@rti.org>"
to="#CMemail.partneremail#" cc="#CMemail.email#; #CMemail.superemail2#" bcc="dplotner@rti.org" subject="#session.orgname# LATE SUBMISSION" type="HTML">
#session.orgname# - This email acknowledges receipt of your monthly CAT report for #MonthAsString(mo)#, which was submitted late to the State Health Department.
<br><br>
Submitting monthly reports on time is part of the agency contract requirements. Reports must be submitted on time every month to avoid delays in payment to the agency or other administration action.
</cfmail>
				</cfif>
			</cfif>
		</cfif>
		<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="getsubs">
	select distinct mon, submitdt
	from monthly
	where year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> and userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and submitdt is not null
</cfquery>
		<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="getInfra">
	select distinct mon
	from infra
	where year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> and userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
</cfquery>
		<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="getem">
	select distinct mon
	from em
	where year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> and userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
</cfquery>
		<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="getFback">
	select distinct mon
	from cmfeedback
	where year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> and userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and submitdt is not null
</cfquery>
		<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="getCFback">
	select distinct mon
	from cmfeedback
	where year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> and userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and 	cntrReview=1
</cfquery>
		<cfif #session.fy# GTE 2011>
			<cfset lst = "7,8,9,10,11,12,1,2,3,4,5,6">
			<cfset xx = 7>
		<cfelseif #session.fy# is 2010>
			<cfset lst = "8,9,10,11,12,1,2,3,4,5,6">
			<cfset xx = 8>
		<cfelse>
			<cfset lst = "8,9,10,11,12,1,2,3,4,5,6,7">
			<cfset xx = 8>
		</cfif>
		<h3>
		Monthly Reporting
		<p>
		</p>
		<table class="box" width=800>
			<cfoutput>
				<tr>
					<td>
					</td>
					<cfloop index="x" list="#lst#">
						<td class="box" align="center" width="6%">
							<cfform name="#MonthAsString(x)#">
								<input type="hidden" name="mo" value="#x#">
								<cfset tempflag=0>
								<cfloop query="getsubs">
									<cfif #getsubs.submitdt# is not ''>
										<cfif #getsubs.mon# is #x#>
											<cfset tempflag=1>
											Date Submitted:
											<br>
											#dateformat(getsubs.submitdt,"mm/dd/yyyy")#
										</cfif>
									</cfif>
								</cfloop>
								<cfif x GTE #xx#>
									<cfset tempMFY = #evaluate(session.fy -1)# >
								<cfelse>
									<cfset tempMFY = #session.fy#>
								</cfif>
								<cfif tempflag EQ 0 AND (#CreateDate(tempMFY, x, 1)#   LTE #now()#) and (session.fy GTE session.def_fy or session.prevyr EQ 1)>
									<input type="submit" name="submit" value="Submit"
									<cfif (session.fy LT 2014) OR (session.fy EQ 2014 AND (#CreateDate(tempMFY, x, 1)#   LTE '2/28/2014'))>
										disabled="true"
									</cfif>
									>
								</cfif>
							</cfform>
						</td>
					</cfloop>
				</tr>
				<tr>
					<th class="box" align="left" width=200>
						Initiative
					</th>
					<cfif #session.fy# GTE 2011>
						<th class="box">
							Jul
						</th>
					</cfif>
					<th class="box">
						Aug
					</th>
					<th class="box">
						Sep
					</th>
					<th class="box">
						Oct
					</th>
					<th class="box">
						Nov
					</th>
					<th class="box">
						Dec
					</th>
					<th class="box">
						Jan
					</th>
					<th class="box">
						Feb
					</th>
					<th class="box">
						Mar
					</th>
					<th class="box">
						Apr
					</th>
					<th class="box">
						May
					</th>
					<th class="box">
						Jun
					</th>
					<cfif #session.fy# lt 2010>
						<th class="box">
							Jul
						</th>
					</cfif>
					<!--- <th class="box">Jul</th> --->
				</tr>
				</td></tr>
			</cfoutput>
			<cfloop index="x" list="1,2,3,4,5,6,7,8,9,10,11,12">
				<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="sampleGoalobj#x#">
	select
o.objective,
o.id as objnum,prognum,submitdt,
initiative,isNull(m.userid, 'NAU') as monuser, 1
from objectives as o left join monthly m on o.id = m.initnum and mon = #x#
and m.userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> and o.year2 = m.year2
where
o.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
and (o.del is null or o.del !=1) and  (modality like '%99%' or modality like '%#session.modality#%')
and o.id !='6B'

<cfif session.modality EQ 6>
UNION
select
o.objective,
o.id as objnum,prognum,NULL,
initiative,isNull(m.userid, 'NAU') as monuser, 1
from objectives as o left join HSC_Monthly m on o.id = m.obj and
MONTH(mon + ' 1 2014') = #x#
and m.userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> and o.year2 = m.year2
where
o.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
and (o.del is null or o.del !=1) and  (modality like '%99%' or modality like '%6%')
and o.id !='6B'

</cfif>

UNION
select distinct 'Develop and implement data collection systems and studies to monitor, measure, and help understand the impact of the TCP',
 '6B', '6', '1/1/1904', 'Local level evaluation', isNull(userid, 'NAU'), 2
from selfeval_mon
where
year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
and userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
and mon = <cfqueryparam value="#x#" cfsqltype="CF_SQL_INTEGER">
order by 6, 5
</cfquery>
				<cfoutput>
					<cfset qy = 'sampleGoalobj'&#x#>
					<cfset qyqy = '#evaluate(qy)#'>
				</cfoutput>
			</cfloop>
			<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="getobj">
select
o.objective,
o.id as objnum,prognum,id,
initiative, o.rank
from objectives as o , wrkplan w
where
o.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
and o.year2=w.year2
and w.userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
and o.id=w.initnum
and (o.del is null or o.del !=1) and  (modality like '%99%' or modality like '%#session.modality#%')
<!--- and (id !='6A' or (id = '6A' and isnull(dispinit,'')!='')) --->
and id !='6A'
and id !='6B'

 UNION
select distinct 'Develop and implement data collection systems and studies to monitor, measure, and help understand the impact of the TCP',
 '6B', '6', '6B', 'Local level evaluation', 99
from wrkplan_selfeval
where
year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
and userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">

order by <cfif session.fy GTE 2013 and session.modality EQ 1>6,</cfif> 5
</cfquery>
			<cfoutput query="getobj">
				<tr>
					<td>
						#getobj.initiative#
					</td>
					<cfset tempInitiative = getobj.id>
					<cfset aa=7>
					<cfloop index="x" list="#lst#">
						<cfset aa=x>
						<td class="box" align="center">
							<input name="#getobj.initiative#_#MonthAsString(x)#_#getobj.currentRow#" type="radio" onClick="window.location.href='month.cfm?mo=#x#&amp;obj=#getobj.objnum#'"
							<cfset bb = 'sampleGoalobj' & aa & '.monuser'>
							<cfset cc= 'sampleGoalobj' & aa>
							<cfif x GTE #xx#>
								<cfset tempMFY = #evaluate(session.fy -1)# >
							<cfelse>
								<cfset tempMFY = #session.fy#>
							</cfif>
							<cfloop query="#cc#">
								<cfif isdefined("#bb#") and #evaluate('sampleGoalobj' & aa & '.monuser')# is not 'NAU' and #tempInitiative# EQ #evaluate('sampleGoalobj' & aa & '.objnum')#>
									checked
								</cfif>
							</cfloop>
							<cfif #CreateDate(tempMFY, x, 1)#   GTE #now()# and session.FY LT 2020>
								disabled
							</cfif>
							>

						</td>
					</cfloop>
				</tr>
			</cfoutput>
			<tr>
				<td colspan=13>
					<table>
						<tr>
							<td>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td>
					Earned Media
				</td>
				<cfoutput>
					<cfloop index="x" list="#lst#">
						<cfset aa=x>
						<cfif aa GTE #xx#>
							<cfset tempMFY = #evaluate(session.fy -1)# >
						<cfelse>
							<cfset tempMFY = #session.fy#>
						</cfif>
						<td class="box" align="center">
							<input type="radio" name="em_#aa#" onClick="window.location.href='em.cfm?mo=#aa#&amp;obj=#getobj.objnum#'"
							<cfif isdefined("getem") and #Listfind(valueList(getem.mon),aa)#>
								checked
							</cfif>
							<cfif #CreateDate(tempMFY, aa, 1)#   GTE #now()#  and #session.FY# LT 2020>
								disabled
							</cfif>
							>
						</td>
					</cfloop>
				</cfoutput>
			</tr>
			<tr>
				<td colspan=13>
					<table>
						<tr>
							<td>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td>
					Infrastructure
				</td>
				<cfoutput>
					<cfloop index="x" list="#lst#">
						<cfset aa=x>
						<cfif aa GTE #xx#>
							<cfset tempMFY = #evaluate(session.fy -1)# >
						<cfelse>
							<cfset tempMFY = #session.fy#>
						</cfif>
						<td class="box" align="center">
							<input type="radio" name="infra_#aa#" onClick="window.location.href='infra.cfm?mo=#aa#&amp;obj=#getobj.objnum#'"
							<cfif isdefined("getInfra") and #Listfind(valueList(getInfra.mon),aa)#>
								checked
							</cfif>
							<cfif #CreateDate(tempMFY, aa, 1)#   GTE #now()#  and session.FY LT 2020>
								disabled
							</cfif>
							>
						</td>
					</cfloop>
				</cfoutput>
			</tr>
			<tr>
				<td colspan=13>
					<table>
						<tr>
							<td>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<!--- CM Feedback --->
			<tr>
				<td>
					Contract Manager Feedback
				</td>
				<cfoutput>
					<cfloop index="x" list="#lst#">
						<cfset aa=x>
						<cfif aa GTE #xx#>
							<cfset tempMFY = #evaluate(session.fy -1)# >
						<cfelse>
							<cfset tempMFY = #session.fy#>
						</cfif>
						<td class="box" align="center">
							<cfif SESSION.areamanage EQ "1" OR SESSION.admin EQ "1" OR SESSION.TCP EQ "1" OR SESSION.cessMan NEQ "0">
								<input type="radio" name="cmf_#aa#" onClick="window.location.href='contra.cfm?mo=#aa#&amp;obj=#getobj.objnum#'"
								<cfif isdefined("getFback") and #Listfind(valueList(getFback.mon),aa)#>
									checked
								</cfif>
								<cfif #CreateDate(tempMFY, aa, 1)#   GTE #now()#  and session.FY LT 2020>
									disabled
								</cfif>
								>
							<cfelse>
								<cfif isdefined("getFback") and #Listfind(valueList(getFback.mon),aa)#>
									<input type="radio" name="cmf_#aa#" onClick="window.location.href='contra.cfm?mo=#aa#&amp;obj=#getobj.objnum#'" checked
									<cfif #CreateDate(tempMFY, aa, 1)#   GTE #now()#  and session.FY LT 2017>
										disabled
									</cfif>
									>
								<cfelse>
									-
								</cfif>
							</cfif>
						</td>
					</cfloop>
				</cfoutput>
			<tr>
				<td>
					Feedback reviewed by contractor
				</td>
				<cfoutput>
					<cfloop index="x" list="#lst#">
						<cfset aa=x>
						<td class="box" align="center">
							<cfif isdefined("getCFback") and #Listfind(valueList(getCFback.mon),aa)#>
								<img src="./images/checkblack.gif">
							<cfelse>
								-
							</cfif>
						</td>
					</cfloop>
				</cfoutput>
			</tr>
		</table>
	</body>
</html>
