<cfoutput>
<cfif isDefined("form.farea") and form.farea NEQ "ALL"> and u.strategy in (#form.farea#)</cfif>
	<cfif isDefined("form.objective") and form.objective NEQ "ALL">
		and u.objective='#form.objective#' 
	<cfelseif isDefined("form.goal") and form.goal NEQ "ALL">
		and u.goal='#form.goal#'  
	</cfif>	
	<cfif isDefined("form.strategy") and form.strategy NEQ "ALL">
		and u.activity='#htmlEditformat(form.strategy)#' and
		(u.userid='#form.partner#' or u.userid='shared')
	<cfelseif isDefined("form.partner") and form.partner NEQ "ALL">
	
		and (u.userid='#form.partner#'  
		<cfif QPartnerSharedAct.recordcount NEQ 0> 
		or u.activity in (#QuotedValueList(QPartnerSharedAct.stratName)#) 
		</cfif>
		)
		
	<!--- <cfelseif isDefined("form.area") and form.area NEQ "ALL">
		<cfif QAreas.recordcount NEQ 0 >
			and (u.userid in (#QuotedValueList(QAreas.userid)#) 
			<cfif isDefined("QAreasSharedAct") AND QAreasSharedAct.recordcount NEQ 0> 
			or u.activity in (#QuotedValueList(QAreasSharedAct.stratName)#) </cfif>
			) 	
			
		<cfelse>
			and u.userid=' ' 
		</cfif> --->
	<cfelseif isDefined("form.region") and form.region NEQ "ALL">
		<cfif QAreas.recordcount NEQ 0 >
			and (u.userid in (#QuotedValueList(QAreas.userid)#) 
			<cfif isDefined("QAreasSharedAct") AND QAreasSharedAct.recordcount NEQ 0> 
			or u.activity in (#QuotedValueList(QAreasSharedAct.stratName)#) </cfif>
			) 	
			
		<cfelse>
			and u.userid=' ' 
		</cfif>
	<cfelse>
		and ((u.userid = 'SHARED' and u.activity in (#QuotedValueList(QIncludeJoint.activity)#)) OR u.userid !='SHARED') 
	</cfif>
	
	<cfif  isDefined("form.goal") and form.goal NEQ "ALL">
	and u.goal in (#form.goal#)  
	</cfif>
	<cfif  isDefined("form.objective") and form.objective NEQ "ALL">
	and u.objective in ('#form.objective#') 
	</cfif>
	<cfif  isDefined("form.farea") and form.farea NEQ "ALL">
	and u.strategy in (#form.farea#) 
	</cfif>
	<cfif isDefined("form.modality") and form.modality NEQ "ALL">
	and (u.userid='SHARED' or u.userid in (select userid from contact where partnertype = #form.modality#))
	</cfif>
	and (u.userid='SHARED' or u.userid in (select userid from contact where partnertype 
	
	
	 <cfif session.rptmode EQ "main">
		!= 4
	<cfelse>
		not in (1,2,3)
	</cfif>))
	<cfif isDefined("Monthrange2") and monthrange NEQ "all">
	and	a.month2 in (#Monthrange2#)
	</cfif>
</cfoutput>