<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>
<!--- <cfset cntyQuotes="">
<cfloop list="#form.catchment#" index="cnty">
	<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="LookupCatchment">

select FIPS from counties where countyName = '#cnty#'	
	
</cfquery>
	<cfset cntyQuotes= cntyQuotes & chr(39) & #cnty# &  ", ">
</cfloop> --->

<cfif isDefined("form.catchment")>
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="convertCatchment">
	
	select FIPS from counties where countyName in (#listQualify(form.catchment,"'",",","all")#)
</cfquery>

<cfif convertCatchment.recordCount GT 0>
<cfoutput><cf_removeDuplicates list="#valueList(convertCatchment.FIPS)#"></cfoutput>
<cfset localcntylist=deDupedList>
</cfif>

<!--- <cfoutput>
<cfloop query="convertCatchment">#FIPS#,</cfloop>
</cfoutput> --->
</cfif>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="updContact">
	Update contact
	set orgName = '#htmleditformat(form.orgName)#', 
	partnerType='#htmleditformat(form.partnerType)#', 
	agent='#htmleditformat(form.agent)#',
	agentName='#htmleditformat(form.agentName)#', 
	grantNum = '#htmleditformat(form.grant)#', 
	street1='#htmleditformat(form.street1)#', 
	street2='#htmleditformat(form.street2)#', 
	city= '#htmleditformat(form.city)#', 
	state='#htmleditformat(form.us_states)#', 
	zip='#htmleditformat(form.zip)#', 
	contact='#htmleditformat(form.contact)#', 
	title='#htmleditformat(form.title)#', 
	phone = '#htmleditformat(form.phone)#', 
	fax = '#htmleditformat(form.fax)#', 
	email = '#htmleditformat(form.email)#', 
	website = '#htmleditformat(form.website)#', 
	agentphone='#htmleditformat(form.agentPhone)#',
	agentEmail='#htmleditformat(form.agentemail)#',
	<cfif isDefined("form.vouchers")>vouchers=#form.vouchers#,</cfif>
	catchment = <cfif isdefined("localcntylist")>'#localcntylist#'<cfelse>''</cfif>
	where 
	userid = '#session.userid#'
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="updContact2">
	Update members
	set
	email = '#htmleditformat(form.email)#' 	
	where 
	username = '#session.userid#'	
	
</cfquery>
<cfset location="#cgi.http_referer#">
<!--- <cfset location  ="cat.cfm"> --->
<cflocation addtoken="Yes" url="#location#">

</body>
</html>
