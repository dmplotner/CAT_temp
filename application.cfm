<!---  <cflocation url="offline.htm">  --->
<!--- <cflocation url="./login/login.cfm"> --->

<cfapplication 	name="NYTobacco" sessionmanagement="Yes" setclientcookies="No"
		sessiontimeout="#CreateTimeSpan(0,0,60,0)#"
		applicationtimeout="#CreateTimeSpan(0,0,60,0)#">

<cfset this.scriptprotect="all">

<cfset Application.DataSource ="nytobacco">
<Cfset Application.exit_location="http://www.rti.org">
<Cfset Application.db_password="pulp$oj4">
<cfset Application.db_username="nytobaccoadmin">
<cfset Application.provider="ODBC">
<cfparam name="session.AlterYr" default="">
<cfparam name="SESSION.modality" default="">
<cfparam name="SESSION.tcp" default="">
<cfparam name="SESSION.admin" default="">




<cfsetting requesttimeout="240">



<!--- <cfif isDefined("session.userid") and session.userid EQ "sep06">
			<cfset session.def_fy = 2009>
			<cfparam name="session.fy" default="#session.def_fy#">
</cfif> --->

<cfif (NOT isDefined("session.def_fy")) or session.AlterYr EQ "newSPyr" or session.AlterYr EQ "newNotSPyr" or session.AlterYr EQ "restoreYr">
<cfif isdefined("session.modality") and (#session.modality# eq 2)>
	<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QcheckAdmin">
	select
	<cfif session.AlterYr EQ "newSPyr">
	sp_fy as fy, sp_nextyr as nextyr, sp_prevyr as prevyr, sp_stratAlert as stratAlert
	<cfelseif session.AlterYr EQ "newNotSPyr">
	fy, nextyr, prevyr,stratAlert
	<cfelseif SESSION.modality EQ 4 or SESSION.modality EQ 2 or SESSION.modality EQ 3>
	sp_fy as fy, sp_nextyr as nextyr, sp_prevyr as prevyr, sp_stratAlert as stratAlert
	<cfelse>
	fy, nextyr, prevyr,stratAlert
	</cfif>
	from admin
	where fy = 2019
	</cfquery>
<cfelse>
	<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QcheckAdmin">
	select
	<cfif session.AlterYr EQ "newSPyr">
	sp_fy as fy, sp_nextyr as nextyr, sp_prevyr as prevyr, sp_stratAlert as stratAlert
	<cfelseif session.AlterYr EQ "newNotSPyr">
	fy, nextyr, prevyr,stratAlert
	<cfelseif SESSION.modality EQ 4 or SESSION.modality EQ 2 or SESSION.modality EQ 3>
	sp_fy as fy, sp_nextyr as nextyr, sp_prevyr as prevyr, sp_stratAlert as stratAlert
	<cfelse>
	fy, nextyr, prevyr,stratAlert
	</cfif>
	from admin
	</cfquery>

</cfif>

<cfset session.def_fy=QcheckAdmin.fy>


		<cfset session.def_fy=2019>

<!---change this to 5 when you change to fy2020--->
<cfset session.yrsub = 4>

	<!--- <cfset session.def_fy=QcheckAdmin.fy>

	<cfif  (isDefined("SESSION.areamanage") and SESSION.areamanage EQ "1")OR (isDefined("SESSION.admin") and SESSION.admin EQ "1" )
			OR (isDefined("SESSION.TCP") and SESSION.TCP EQ "1") >
		<!--- <cfif Not isDefined("session.cessman") or (isDefined("session.cessman") and session.cessman NEQ 4)> --->
		<cfif not((isDefined("session.origUserID") and session.origUserID EQ "amb06") or session.userid EQ "amb06")>
			<cfset session.def_fy=2010>
		</cfif>
		<cfset session.def_fy=2010>
	</cfif> --->

	<cfset session.nextyr=QcheckAdmin.nextyr>
	<cfset session.prevyr=QcheckAdmin.prevyr>
	<cfset application.stratAlert=QcheckAdmin.stratAlert>
	<cfset session.fy=session.def_fy>

	<!--- TRACY.. remove this when they want the default year to change to 2010 for SPs --->
	<!--- <cfif (isDefined("session.cessMan") and session.cessMan EQ 4)>
			<cfset session.fy= 2009>
	</cfif> --->




	<!--- <cfif session.modality NEQ 4>
		<cfset session.fy=session.def_fy-1>
	</cfif> --->

	<cfset session.AlterYr ="">




</cfif>
<!--- <cfif NOT isDefined("session.def_fy")>
	<cfquery datasource="#application.DataSource#"

	password="#application.db_password#"
	username="#application.db_username#" name="QcheckAdmin">
	select
	fy, nextyr, prevyr,stratAlert
	from admin
	</cfquery>

	<cfset session.def_fy=QcheckAdmin.fy>
	<cfset session.nextyr=QcheckAdmin.nextyr>
	<cfset session.prevyr=QcheckAdmin.prevyr>
	<cfset application.stratAlert=QcheckAdmin.stratAlert>
	<cfparam name="session.fy" default="#session.def_fy#">

</cfif> --->
<cfset Application.servername=CGI.SERVER_NAME>
<cfset HOME=application.servername & "nytobacco/">
<cfset Application.LoginPath="./login/login.cfm">
<cfset application.basename="https://nytobacco.rti.org">

<cfif  isDefined("session.nextyr") or NOT isDefined("session.def_fy") or NOT isDefined("session.prevyr")>

<cfif isdefined("session.userid") and (#session.userid# is 'nsarris' or #session.userid# is 'twills' or #session.userid# is 'dplotner')>
 <cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QAdminValues">
	<!--- select fy, nextyr,prevyr
	from admin --->
	select
	<!---
	<cfif session.AlterYr EQ "newSPyr">
	sp_fy as fy, sp_nextyr as nextyr, sp_prevyr as prevyr, sp_stratAlert as stratAlert
	<cfelseif session.AlterYr EQ "newNotSPyr">
	fy, nextyr, prevyr,stratAlert	 --->
	<cfif SESSION.modality EQ 4  or SESSION.modality EQ 2 or SESSION.modality EQ 3>
	sp_fy as fy, sp_nextyr as nextyr, sp_prevyr as prevyr, sp_stratAlert as stratAlert
	<cfelse>
	fy, nextyr, prevyr,stratAlert
	</cfif>
	from admin
	</cfquery>
<cfelse>
 <cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QAdminValues">
	<!--- select fy, nextyr,prevyr
	from admin --->
	select
	<!---
	<cfif session.AlterYr EQ "newSPyr">
	sp_fy as fy, sp_nextyr as nextyr, sp_prevyr as prevyr, sp_stratAlert as stratAlert
	<cfelseif session.AlterYr EQ "newNotSPyr">
	fy, nextyr, prevyr,stratAlert	 --->
	<cfif SESSION.modality EQ 4  or SESSION.modality EQ 2 or SESSION.modality EQ 3>
	sp_fy as fy, sp_nextyr as nextyr, sp_prevyr as prevyr, sp_stratAlert as stratAlert
	<cfelse>
	fy, nextyr, prevyr,stratAlert
	</cfif>
	from admin
	</cfquery>
	</cfif>


	<cfset session.def_fy=QAdminValues.fy>
	<cfset session.nextyr=QAdminValues.nextyr>
	<cfset session.prevyr=QAdminValues.prevyr>

	<cfif session.modality EQ 1 and now() LT '9/18/2010'>
		<cfset session.prevyr = 1>
	</cfif>




	<!---
	<cfif  (isDefined("SESSION.areamanage") and SESSION.areamanage EQ "1")OR (isDefined("SESSION.admin") and SESSION.admin EQ "1" )OR (isDefined("SESSION.TCP") and SESSION.TCP EQ "1") >
		<cfif Not isDefined("session.cessman") or (isDefined("session.cessman") and session.cessman NEQ 4) and session.userid NEQ 'jah19'>
			<cfset session.def_fy=2013>
	</cfif></cfif>
--->
</cfif>


<cfif NOT isDefined("session.userid") OR session.userid NEQ "dplotner">
	<!--- <cfif cgi.remote_addr NEQ "10.128.240.158"> --->
	<cferror type="request" template="customerror.cfm" mailto="dplotner@rti.org">
	<cferror type="exception"  exception="Any" template="customerror.cfm" mailto="dplotner@rti.org">
</cfif>
<!--- </cfif> --->
<CFIF IsDefined("SESSION.LoggedIn") IS FALSE>
		<cfoutput>
		<!--- <script> --->
		<!--- //alert ("SESSION.LoggedIn is Undefined due to inactivity")  --->
			<!--- each folder's application should have code to call function GoLogin when Session.LoggedIn variable is expired due tio inactivity --->
<!---tw commented out on 10/14 --->
			<cflocation addtoken="no" url="#Application.LoginPath#">
		<!--- </script> --->
	</cfoutput>
	<cfabort>
<cfelse>
		<CFIF #SESSION.LoggedIn# IS "">
		<cfoutput>
		<script>
		//alert ("here SESSION.LoggedIn is NO")

		</script>
		<cflocation addtoken="no" url="#Application.LoginPath#">
		</cfoutput>

	</CFIF>
</CFIF>
<CFIF IsDefined("SESSION.USERID") IS FALSE OR session.userid EQ "">
	<cflocation addtoken="no" url="#Application.LoginPath#">
</CFIF>




<!---  <cfif session.userid NEQ "dplotner" and session.userid NEQ "bmarkatos">
	<CFLOCATION addtoken="NO" url="OFFLINE.HTM">
</cfif>  --->


<cfif isDefined("session.userid") AND session.userid EQ 'cvfamilycenterAA' and now() LT '10/1/2010'>
		<cfset session.prevyr = 1>
	</cfif>


<cfparam name="session.cntMan" default="0">
<cfset SESSIONMINUTES=50>

<!--- List of pages that should NOT be checked for timeout --->
<cfset TMEXCL ="login.cfm,validate.cfm,timedout.cfm,timeoutwarning.cfm,logout.cfm,custom_error.cfm,index.cfm,arch_tbl_cntnts.cfm">

<CFIF Not ListFindNoCase(TMEXCL,GetFileFromPath(GetBaseTemplatePath()))>
 <!--- <cfif Not IsDefined ("Session.USR") or Not IsDefined("session.admin")>
  <cflocation url="timedout.cfm" addtoken="No">
 </cfif> --->
 <cfmodule template="i_session_timer.cfm"
  minutes="#SESSIONMINUTES#"
  warn="Yes"
  warnThreshold="5"
  warnURL="timeoutwarning.cfm"
  onTimeout="./login/login.cfm">
  <!--- onTimeout="#LOGIN#?expired=yes"> --->
</CFIF>
<cfset Session.keepAlive = "Yes">

<!--- <cfif session.userid EQ 'dplotner'>
		<cfset session.nextyr=1>
	</cfif>
 --->

<cfif SESSION.areamanage EQ "1" OR SESSION.admin EQ "1" OR SESSION.TCP EQ "1" OR SESSION.CessMan CONTAINS "1">
	<cfparam name="session.origUserID" default="#session.userid#">
</cfif>
<!--- <cfif NOT((session.userid EQ 'dplotner' OR session.userid EQ  'bmarkatos') OR (isDefined("session.origuserid") and  (session.origUserID EQ 'dplotner' OR session.origUserID EQ  'bmarkatos')))>
	<cflocation url="offline.htm">

</cfif> --->

<!--- <cfif session.modality EQ 4>
	<cfset session.fy =session.def_fy>
</cfif>

<cfif  (isDefined("SESSION.areamanage") and SESSION.areamanage EQ "1")OR (isDefined("SESSION.admin") and SESSION.admin EQ "1" )OR (isDefined("SESSION.TCP") and SESSION.TCP EQ "1") >
		<cfif Not isDefined("session.cessman") or (isDefined("session.cessman") and session.cessman NEQ 4)>
			<cfset session.def_fy=2013>
	</cfif>
</cfif> --->

<cfif session.userid EQ "CSNRockland">
	<cfset session.def_fy=2012>
	<cfif isDefined("session.fy") and session.fy GT 2012>
		<cfset session.fy = 2012>
	</cfif>

</cfif>


<cfparam name="session.fy" default="session.def_fy">
<cfparam name="session.EOYcut" default="0">

<cfif now() LTE '12/1/2007' and session.modality NEQ 4 and session.fy EQ 2008>
			<cfset SESSION.RETROcut="0">
<cfelse>
			<cfset SESSION.RETROcut="1">
</cfif>




<cfparam name="session.MM1" default="julie.wright@health.ny.gov"><!--- Health Systems Change A --->
<cfparam name="session.MM2" default="elizabeth.anker@health.ny.gov"><!--- ATFC  --->
<cfparam name="session.MM6" default="julie.wright@health.ny.gov"><!--- Health Systems Change B --->
<cfparam name="session.extraEmail" default="sep06@health.state.ny.us"><!--- Sara Phelps to CC on all emails as extra --->

<!--- <cfif (<!--- session.modality  EQ 1 OR  ---> session.modality  EQ 2 OR session.modality  EQ 3 OR session.modality  EQ 5) AND  session.cntMan EQ 0 AND SESSION.CessMan EQ 0  and SESSION.admin EQ 0  and SESSION.areamanage  EQ 0  and SESSION.regionmanage EQ 0  and SESSION.statemanage EQ 0 >
	<cfset session.fy = 2010>
</cfif> --->

<!--- <cfif session.cessMan EQ 4 or session.modality EQ 4 and session.fy EQ 2010>
			<cfset session.fy= 2009>
</cfif> --->

<!--- <cfif isDefined("session.userid")>
<cfif session.userid EQ 'dplotner' or session.userid EQ 'nsarris' or session.userid EQ 'mchambard' or session.userid EQ 'twills'>

<cfelseif isDefined("session.origUserID") and (session.origUserID EQ 'dplotner' or session.origUserID EQ 'nsarris' or session.origUserID EQ 'cschnefke' or session.origUserID EQ 'twills') >


<cfelseif session.modality EQ 4>
	<cflocation  url="../unavailable_sp.htm">
<cfelse>
	<cflocation  url="../unavailable_cont.htm">
</cfif>
</cfif> --->