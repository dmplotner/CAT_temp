<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>
			Untitled
		</title>
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
				<cfoutput>
					<cf_removeDuplicates list="#valueList(convertCatchment.FIPS)#">
				</cfoutput>
				<cfset localcntylist=deDupedList>
			</cfif>
			<!--- <cfoutput>
				<cfloop query="convertCatchment">#FIPS#,</cfloop>
				</cfoutput> --->
		</cfif>
		<cfoutput>
			Update contact set orgName = '#htmleditformat(form.orgName)#', orgName2 = '#htmleditformat(form.orgName2)#', partnerType='#htmleditformat(form.partnerType)#', grantNum = '#htmleditformat(form.grant)#', coordpref='#htmleditformat(form.coordpref)#', coordfname='#htmleditformat(form.coordfname)#', coordlname='#htmleditformat(form.coordlname)#', coordphone = '#htmleditformat(form.coordphone)#', coordemail = '#htmleditformat(form.coordemail)#', coordpref2='#htmleditformat(form.coordpref2)#', coordfname2='#htmleditformat(form.coordfname2)#', coordlname2='#htmleditformat(form.coordlname2)#', coordphone2 = '#htmleditformat(form.coordphone2)#', coordemail2 = '#htmleditformat(form.coordemail2)#', email = '#htmleditformat(form.addlemail)#',
			<cfif isDefined("form.PIfname")>
				PIfname = '#htmleditformat(form.PIfname)#', PIlname = '#htmleditformat(form.PIlname)#', PIphone='#htmleditformat(form.PIPhone)#', PIEmail='#htmleditformat(form.PIemail)#',
			</cfif>
			superfname2 = '#htmleditformat(form.superfname2)#', superlname2 = '#htmleditformat(form.superlname2)#', superphone2='#htmleditformat(form.superPhone2)#', superEmail2='#htmleditformat(form.superemail2)#', fiscalfname2 = '#htmleditformat(form.fiscalfname2)#', fiscallname2 = '#htmleditformat(form.fiscallname2)#', fiscalphone2='#htmleditformat(form.fiscalPhone2)#', fiscalEmail2='#htmleditformat(form.fiscalemail2)#', btccomm=
			<cfif isdefined("form.btccomm")>
				'#htmleditformat(form.btccomm)#'
			<cfelse>
				0
			</cfif>
			, addlEmail='#htmleditformat(form.addlemail)#', catchment =
			<cfif isdefined("localcntylist")>
				'#localcntylist#'
			<cfelse>
				''
			</cfif>
			where userid = '#session.userid#'
		</cfoutput>
		<cfquery datasource="#application.DataSource#"

	password="#application.db_password#"
	username="#application.db_username#" name="updContact">
	Update contact
	set orgName = <cfqueryparam value="#htmleditformat(form.orgName)#" cfsqltype="CF_SQL_VARCHAR" maxlength="180">,
	orgName2 = <cfqueryparam value="#htmleditformat(form.orgName2)#" cfsqltype="CF_SQL_VARCHAR" maxlength="180">,
	partnerType= <cfqueryparam value="#htmleditformat(form.partnerType)#" cfsqltype="CF_SQL_VARCHAR" maxlength="180">,
	grantNum = <cfqueryparam value="#htmleditformat(form.grant)#" cfsqltype="CF_SQL_VARCHAR" maxlength="180">,
	coordpref= <cfqueryparam value="#htmleditformat(form.coordpref)#" cfsqltype="CF_SQL_VARCHAR" maxlength="180">,
	coordfname= <cfqueryparam value="#htmleditformat(form.coordfname)#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
	coordlname= <cfqueryparam value="#htmleditformat(form.coordlname)#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
	coordphone = <cfqueryparam value="#htmleditformat(form.coordphone)#" cfsqltype="CF_SQL_VARCHAR" maxlength="25">,
	coordemail = <cfqueryparam value="#htmleditformat(form.coordemail)#" cfsqltype="CF_SQL_VARCHAR" maxlength="180">,
	coordpref2= <cfqueryparam value="#htmleditformat(form.coordpref2)#" cfsqltype="CF_SQL_VARCHAR" maxlength="180">,
	coordfname2= <cfqueryparam value="#htmleditformat(form.coordfname2)#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
	coordlname2= <cfqueryparam value="#htmleditformat(form.coordlname2)#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
	coordphone2 = <cfqueryparam value="#htmleditformat(form.coordphone2)#" cfsqltype="CF_SQL_VARCHAR" maxlength="25">,
	coordemail2 = <cfqueryparam value="#htmleditformat(form.coordemail2)#" cfsqltype="CF_SQL_VARCHAR" maxlength="180">,
	email = <cfqueryparam value="#htmleditformat(form.addlemail)#" cfsqltype="CF_SQL_VARCHAR" maxlength="500">,
	<cfif isDefined("form.PIfname")>
	PIfname = <cfqueryparam value="#htmleditformat(form.PIfname)#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
	PIlname = <cfqueryparam value="#htmleditformat(form.PIlname)#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
	PIphone= <cfqueryparam value="#htmleditformat(form.PIPhone)#" cfsqltype="CF_SQL_VARCHAR" maxlength="25">,
	PIEmail= <cfqueryparam value="#htmleditformat(form.PIemail)#" cfsqltype="CF_SQL_VARCHAR" maxlength="180">,
	</cfif>
	superfname2 = <cfqueryparam value="#htmleditformat(form.superfname2)#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
	superlname2 = <cfqueryparam value="#htmleditformat(form.superlname2)#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
	superphone2= <cfqueryparam value="#htmleditformat(form.superPhone2)#" cfsqltype="CF_SQL_VARCHAR" maxlength="25">,
	superEmail2= <cfqueryparam value="#htmleditformat(form.superemail2)#" cfsqltype="CF_SQL_VARCHAR" maxlength="180">,
	fiscalfname2 = <cfqueryparam value="#htmleditformat(form.fiscalfname2)#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
	fiscallname2 = <cfqueryparam value="#htmleditformat(form.fiscallname2)#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
	fiscalphone2= <cfqueryparam value="#htmleditformat(form.fiscalphone2)#" cfsqltype="CF_SQL_VARCHAR" maxlength="25">,
	fiscalEmail2= <cfqueryparam value="#htmleditformat(form.fiscalEmail2)#" cfsqltype="CF_SQL_VARCHAR" maxlength="180">,
	btccomm= <cfif isdefined("form.btccomm")><cfqueryPARAM value = "#form.btccomm#" CFSQLType = "CF_SQL_INTEGER"><cfelse>0</cfif>,
	addlEmail= <cfqueryparam value="#htmleditformat(form.addlemail)#" cfsqltype="CF_SQL_VARCHAR" maxlength="500">,
	catchment = <cfif isdefined("localcntylist")><cfqueryparam value="#localcntylist#" cfsqltype="CF_SQL_VARCHAR" maxlength="500"><cfelse>''</cfif>
	where
	userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
</cfquery>
		<cfstoredproc
			procedure = "sp_UpdateCountyList"
			datasource="#application.DataSource#"
			password="#application.db_password#"
			username="#application.db_username#">
		</cfstoredproc>
		<!--- <cfquery datasource="#application.DataSource#"
			password="#application.db_password#"
			username="#application.db_username#" name="updContact2">
			Update members
			set
			email = '#htmleditformat(form.coordemail)#'
			where
			username = '#session.userid#'
			</cfquery> --->
		<cfset location="#cgi.http_referer#">
		<!--- <cfset location  ="cat.cfm"> --->
		<cflocation addtoken="Yes" url="#location#">
	</body>
</html>
