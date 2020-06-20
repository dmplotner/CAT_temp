<cfif  isDefined("form.partner") and form.partner NEQ "ALL" and (NOT isDefined("form.area") or form.Area EQ "All")
	and (NOT isDefined("form.region") or form.region EQ "All")>
<cfquery datasource="#application.DataSource#"  	
		password="#application.db_password#"   		
		username="#application.db_username#" name="QAreaspec">
		<!--- select area from security
		where userid='#form.partner#' --->
		select r.num as area 
		from security as s, area as a, region as r
		where userid='#form.partner#'
		and s.area=a.num
		and a.region=r.num
		and a.year2=r.year2
		and a.year2=2009
		</cfquery>
		
		<!--- <Cfset form.area=QAreaspec.area> --->
		<Cfset form.region=QAreaspec.area>


</cfif>




<cfif (isDefined("form.region") and form.region NEQ "ALL") OR (isDefined("form.area") and form.area NEQ "ALL")>

<cfif (isDefined("form.region") and form.region NEQ "ALL")>
<cfquery datasource="#application.DataSource#"  	
		password="#application.db_password#"   		
		username="#application.db_username#" name="QAreas">
		select s.userid, s.seq
		from security as s, contact as c, area as a, region as r
		where r.num='#form.region#'			
		and s.userid=c.userid
		and s.area=a.num
		and a.region=r.num
		and a.year2=2009
		and r.year2=a.year2
		and 
		<cfif session.rptmode EQ "main">
		c.partnertype != 4
		<cfelse>
		c.partnertype = 4
		</cfif>
		<cfif isDefined("form.modality") and form.modality NEQ "ALL">
		and c.partnertype = #form.modality#
		</cfif>		
</cfquery>
<cfelse>
<cfquery datasource="#application.DataSource#"  	
		password="#application.db_password#"   		
		username="#application.db_username#" name="QAreas">
		select s.userid, s.seq
		from security as s, contact as c
		where s.area='#form.area#'	
		and s.userid=c.userid
		and 
		<cfif session.rptmode EQ "main">
		c.partnertype != 4
		<cfelse>
		c.partnertype = 4
		</cfif>
		<cfif isDefined("form.modality") and form.modality NEQ "ALL">
		and c.partnertype = #form.modality#
		</cfif>
		
</cfquery>
</cfif>



		
<cfquery datasource="#application.DataSource#"  		
	password="#application.db_password#"   		
	username="#application.db_username#" name="QcollabStrat">
select  s.activity as stratName, s.userid as partners
from shareduserActivities as s, useractivities as u, contact as c
where u.activity=s.activity
and c.userid=s.userid
and u.strategy != 10
and u.year2=s.year2
and u.year2=#session.fy#
and u.userid='shared'
<cfif isDefined("form.modality") and form.modality NEQ "ALL">
and c.partnertype = #form.modality#
</cfif>
order by 1

</cfquery>

	
<cfquery datasource="#application.DataSource#"  
		password="#application.db_password#"   		
		username="#application.db_username#" name="QAreasSharedAct">
		select distinct stratname
		from sharedActivities
		where stratname in (
		<cfloop query="Qareas"><cfset tempuserid=userid>
		<cfloop query="QcollabStrat">
			<cfif QcollabStrat.partners EQ tempuserid>
				'#QcollabStrat.stratname#', 
			</cfif>
		</cfloop>
		</cfloop>'NONE')		
		and year2=#session.fy#
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
		where stratname in (
		<cfloop query="QcollabStrat">
		<cfif ListFind(partners, form.partner)> 
				'#stratname#', 
		</cfif>
		</cfloop>
		 'NONE')
		 and year2=#session.fy#
		 union
		 select 'sp'
		 from sharedActivities
</cfquery>

		
</cfif>

<cfelse>

<cfquery datasource="#application.DataSource#"  	
		password="#application.db_password#"   		
		username="#application.db_username#" name="QIncludeJoint">
		select distinct s.activity
		from shareduseractivities s, contact as c
		where s.userid=c.userid
		and 
		<cfif session.rptmode EQ "main">
		c.partnertype != 4
		<cfelse>
		c.partnertype = 4
		</cfif>
		and year2=#session.fy#
		<cfif isDefined("form.modality") and form.modality NEQ "ALL">
		and  c.partnertype = #form.modality#
		</cfif>
		union
		 select 'sp'
		 from sharedActivities
</cfquery>

</cfif>	