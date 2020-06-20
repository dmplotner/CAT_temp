<!--- <cfif url.rtype EQ "YTD">
	<cfset rpttype="YTD">
<cfelse>
	<cfset rpttype="monthly">
</cfif> --->
<cfset rpttype="monthly">

		


<cfif form.area NEQ "ALL">
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
</cfquery>


		
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QcollabStrat">
select  s.activity as stratName, s.userid as partners
from shareduserActivities as s, useractivities as u
where u.activity=s.activity
and u.strategy != 10
and u.year2=s.year2
and u.year2=#session.fy#
and u.userid='shared'

order by 1
</cfquery>

<!--- <cfoutput>select stratname
		from sharedActivities
		where distinct stratname in (
		<cfloop query="Qareas">
		<cfloop query="QcollabStrat">
			<cfif ListFind(partners, Qareas.seq)>
				'#stratname#', 
			</cfif>
		</cfloop>
		</cfloop>'NONE')
		<br><br>
</cfoutput><cfabort> --->

<cfquery datasource="#application.DataSource#"  		
		 
		password="#application.db_password#"   		
		username="#application.db_username#" name="QAreasSharedAct">
		select distinct stratname
		from sharedActivities
		where stratname in (
		<cfloop query="Qareas">
		<cfloop query="QcollabStrat">
			<cfif partners EQ Qareas.userid>
				'#stratname#', 
			</cfif>
		</cfloop>
		</cfloop>'NONE')
		
</cfquery>


<cfif isDefined("form.partner") and form.partner NEQ "ALL">
<cfquery datasource="#application.DataSource#"  		
		 
		password="#application.db_password#"   		
		username="#application.db_username#" name="QPartnerSeq">
		select seq 
		from security 
		where userid='#form.partner#'	
		
</cfquery>
<cfquery datasource="#application.DataSource#"  			 
		password="#application.db_password#"   		
		username="#application.db_username#" 
		name="QPartnerSharedAct">
		select stratname
		from  sharedActivities
		where stratname in (<cfloop query="QcollabStrat">
			<cfif ListFind(partners, QPartnerSeq.seq)>
				'#stratname#', 
			</cfif>
			</cfloop> 'NONE')
</cfquery>
		
</cfif>
</cfif>		


 <cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QGenDescrip">
	
	select activity, goal, u.objective, o.objective as objdesc, targetgroup,
	startdate, enddate,state, tcpregional, tcparea,
	isNull(issues, 0) as issues, isNull(levelchangesought, 0) as levelchangesought,
	isNull(target2, 0) as target2, isNull(foci, 0) as foci, primsec, userid, strategy,targetgroup,purpose,pollevel, 
	isNull(issuesAdd, 0) as issuesAdd, typepromo, u.userid, campname, activityname
	from userActivities as u, objectives as o
	where 
	<cfif isDefined("form.farea") and form.farea NEQ "ALL">u.strategy in (#form.farea#) and </cfif>
	<cfif isDefined("form.objective") and form.objective NEQ "ALL">
		u.objective='#form.objective#' and
	<cfelseif form.goal NEQ "ALL">
		u.goal='#form.goal#' and 
	</cfif>	
	<cfif isDefined("form.strategy") and form.strategy NEQ "ALL">
		u.activity='#htmlEditformat(form.strategy)#' and
		u.userid='#form.partner#' and
	<cfelseif isDefined("form.partner") and form.partner NEQ "ALL">
	
		(u.userid='#form.partner#'  
		<cfif QPartnerSharedAct.recordcount NEQ 0> 
		or u.activity in (#QuotedValueList(QPartnerSharedAct.stratName)#) 
		</cfif>
		)
		and
	<cfelseif form.area NEQ "ALL">
		<cfif QAreas.recordcount NEQ 0 >
			(u.userid in (#QuotedValueList(QAreas.userid)#) 
			<cfif isDefined("QAreasSharedAct") AND QAreasSharedAct.recordcount NEQ 0> 
			or u.activity in (#QuotedValueList(QAreasSharedAct.stratName)#) </cfif>
			) and	
			
		<cfelse>
			u.userid=' ' and
		</cfif>
	</cfif>
	<cfif isDefined("form.modality") and form.modality NEQ "ALL">
	(u.userid= 'shared' or u.userid in (select userid from contact where partnertype = #form.modality#)) and
	</cfif>
	u.objective=o.id
	and u.year2=#session.fy#
	and u.year2=o.year2	
	and u.strategy != 10
	and (u.del is null OR u.del != 'Y')
	order by strategy, 3, userid, activity
</cfquery>

<!--- <cfoutput>
select activity, goal, u.objective, o.objective as objdesc, targetgroup,
	startdate, enddate,state, tcpregional, tcparea,
	isNull(issues, 0) as issues, isNull(levelchangesought, 0) as levelchangesought,
	isNull(target2, 0) as target2, isNull(foci, 0) as foci, primsec, userid, strategy,targetgroup,purpose,pollevel, 
	isNull(issuesAdd, 0) as issuesAdd, typepromo, u.userid, campname
	from userActivities as u, objectives as o
	where 
	<cfif isDefined("form.farea") and form.farea NEQ "ALL">u.strategy in (#form.farea#) and </cfif>
	<cfif isDefined("form.objective") and form.objective NEQ "ALL">
		u.objective='#form.objective#' and
	<cfelseif form.goal NEQ "ALL">
		u.goal='#form.goal#' and 
	</cfif>	
	<cfif isDefined("form.strategy") and form.strategy NEQ "ALL">
		u.activity='#htmlEditformat(form.strategy)#' and
		u.userid='#form.partner#' and
	<cfelseif isDefined("form.partner") and form.partner NEQ "ALL">
	
		(u.userid='#form.partner#'  
		<cfif QPartnerSharedAct.recordcount NEQ 0> 
		or u.activity in (#QuotedValueList(QPartnerSharedAct.stratName)#) 
		</cfif>
		)
		and
	<cfelseif form.area NEQ "ALL">
		<cfif QAreas.recordcount NEQ 0 >
			(u.userid in (#QuotedValueList(QAreas.userid)#) 
			<cfif isDefined("QPartnerSharedAct") AND QPartnerSharedAct.recordcount NEQ 0> 
			or u.activity in (#QuotedValueList(QAreasSharedAct.stratName)#) </cfif>
			) and	
			
		<cfelse>
			u.userid=' ' and
		</cfif>
	</cfif>
	u.objective=o.id
	and u.year2=#session.fy#
	and u.year2=o.year2	
	and u.strategy != 10
	and (u.del is null OR u.del != 'Y')
	order by strategy, 3, userid, activity
</cfoutput>
 --->