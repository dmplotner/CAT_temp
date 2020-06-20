<cfset addloc = "">
<cfif SESSION.areamanage EQ "1" OR SESSION.admin EQ "1" OR SESSION.TCP EQ "1" OR SESSION.CessMan EQ "1" or session.areamanage EQ 1 or session.admin eq 1>
	 	<cfset btn="tcp">
	 	<cfset read=1>
	 <cfelse>
	 <cfset btn="partner">
	 <cfset read=0>
</cfif>

<cfif isdefined("usid")>
	<cfset tempModality= session.modality>
	<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QgetModality">
	select partnertype from contact where userid = '#usid#'
	</cfquery>
	
	<cfset session.modality= QgetModality.partnertype>
</cfif>

<cfparam name="form.namesig" default=''>
<cfparam name="form.contamt" default=''>
<cfparam name="form.agencydir" default=''>
<cfparam name="form.accomp" default=''>
<cfparam name="form.goals" default=''>


<cfparam name="form.muniprogress" default=''>
<cfparam name="form.munifeedback" default=''>

<cfparam name="form.muniprogress2" default=''>
<cfparam name="form.munibarriers2" default=''>
<cfparam name="form.munifeedback2" default=''>
<cfparam name="form.ordifeedback" default=''>
<cfparam name="form.ordiprogress" default="">
<cfparam name="form.ordibarriers" default="">
<cfparam name="form.ordiactions" default="">
<cfparam name="form.MULTIPROGRESS" default="">
<cfparam name="form.MULTIBARRIERS" default="">
<cfparam name="form.MULTIACTIONS" default="">
<cfparam name="form.MULTIFEEDBACK" default="">

<cfparam name="form.govt" default=''>
<cfparam name="form.excise" default=''>
<cfparam name="form.tcp1" default=''>
<cfparam name="form.tcp2" default=''>
<cfparam name="form.tcp3" default=''>
<cfparam name="form.tcp4" default=''>
<cfparam name="form.health" default=''>
<cfparam name="form.busi" default=''>
<cfparam name="form.outd" default=''>
<cfparam name="form.mag" default=''>



<cfparam name="form.govtnum2" default=''>
<cfparam name="form.excisestatus" default=''>
<cfparam name="form.EXCISEPROGRESS" default=''>
<cfparam name="form.EXCISEBarriers" default=''>
<cfparam name="form.EXCISEActions" default=''>
<cfparam name="form.EXCISEFeedback" default=''>
<cfparam name="form.FTQSTATUS" default=''>
 

<cfparam name="form.QLINE1" default="">
<cfparam name="form.QLINE2" default=""> 
<cfparam name="form.QLINENUM" default="">
<cfparam name="form.QLINEPROGRESS" default=""> 
<cfparam name="form.QLINEBARRIERS" default="">
<cfparam name="form.QLINEACTIONS" default="">
<cfparam name="form.QLINEFEEDBACK" default="">
<cfparam name="form.AGFEEDBACK" default="">
<cfparam name="form.SFMFEEDBACK" default="">
<cfparam name="form.SBFEEDBACK" default="">

<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qchkinfo">
	select userid
	from eoy_basics 
	where 
		<cfif isdefined("usid")>userid='#usid#'<cfelse>userid='#session.userid#' </cfif>
	and year2=#session.fy#	
</cfquery>

<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qchkdetail">
	select userid
	from eoy_details
	where 
		<cfif isdefined("usid")>userid='#usid#'<cfelse>userid='#session.userid#' </cfif>
	and year2=#session.fy#	
</cfquery>



<cfif Qchkinfo.recordcount EQ 0>
<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QnewRecord">
insert into eoy_basics (userid, year2)
values (	<cfif isdefined("usid")>'#usid#'<cfelse>'#session.userid#' </cfif>,#session.fy#)
</cfquery>
</cfif>

<cfif Qchkdetail.recordcount EQ 0>
<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QnewRecord">
insert into eoy_details (userid, year2)
values (	<cfif isdefined("usid")>'#usid#'<cfelse>'#session.userid#' </cfif>,#session.fy#)
</cfquery>
</cfif>
<cfif isdefined("smartcounty")>
<cfloop index="x" list="#smartcounty#">
	<cfset cntyNm = x>
<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qchkcounty">
	select userid
	from eoy_smartcounty
	where 
		<cfif isdefined("usid")>userid='#usid#'<cfelse>userid='#session.userid#' </cfif>
	and year2=#session.fy#	
	and countyname='#cntyNm#'
</cfquery>
<cfif Qchkcounty.recordcount EQ 0 and cntyNm NEQ ''>
<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QnewRecord">
insert into eoy_smartcounty (userid, year2,countyname)
values (	<cfif isdefined("usid")>'#usid#'<cfelse>'#session.userid#' </cfif>,#session.fy#,'#cntyNm#')
</cfquery>
</cfif>
</cfloop>
</cfif>





<!--- commented out by plotner 7/15 because it doesn;t work --->



 <cfif isdefined("newoutcome") and #newoutcome# is not ''>
<!--- <cfset addloc = "##addnew"> --->
<!--- <cfloop index="x" list="#form.newoutcome#" delimiters=","> --->

<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qchkdetail">
	select userid
	from eoy_custom
	where 
		<cfif isdefined("usid")>userid='#usid#'<cfelse>userid='#session.userid#' </cfif>
	and year2=#session.fy#
	and outcome='#form.newoutcome#'	
</cfquery>
<cfif Qchkdetail.recordcount is 0>
<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QnewRecord">
insert into eoy_custom (userid, year2, outcome)
values (	<cfif isdefined("usid")>'#usid#'<cfelse>'#session.userid#' </cfif>,#session.fy#, '#form.newoutcome#')
</cfquery>
</cfif>
</cfif>


<!--- 
<cfoutput>
<cfif form.addcnt GT 0>	
<cfloop from="1" to="#form.addcnt#" index="x">
	<cfset stat=Evaluate("form.customstatus_#x#")>
	<cfset prog=Evaluate("form.customprogress_#x#")>
	<cfset barr=Evaluate("form.custombarriers_#x#")>
	<cfset act=Evaluate("form.customactions_#x#")>
	<cfset feed=Evaluate("form.customfeedback_#x#")>
	<cfset outc=Evaluate("form.newoutcome_#x#")>

<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QUpdRecord">
	update eoy_custom
	set
	customstatus=#stat#,
	customprogress='#prog#',
	custombarriers='#barr#',
	customactions='#act#',
	customfeedback='#feed#'
	where userid='#session.userid#' 
	and year2=#session.fy#
	and outcome='#outc#'
		</cfquery> 


</cfloop>
</cfif> </cfoutput> --->

<cfif isDefined("form.deleteOpt") and form.deleteOpt NEQ "">
<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QdelOption">
	delete 
	from eoy_custom
	where 
		<cfif isdefined("usid")>userid='#usid#'<cfelse>userid='#session.userid#' </cfif>
	and year2=#session.fy#
	and seq = #form.deleteOpt#
	</cfquery>
</cfif>

<cfif isdefined("smartcounty")>
<cfloop index="x" list="#smartcounty#">
<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qchkcounty">
	select e.countyname --, FIPS
	from eoy_smartcounty e --, counties c
	where 
		<cfif isdefined("usid")>userid='#usid#'<cfelse>userid='#session.userid#' </cfif>
	--and c.fips=e.countyname
	and year2=#session.fy#	
	and e.countyname='#x#'
</cfquery>





<cfif Qchkcounty.recordcount NEQ 0> <cfoutput>
<cfif session.fy LT 2009>
	<cfset k = 'form.sixsevenactual' & '_' & #Qchkcounty.countyname#>
	<cfset kk = #evaluate(k)#>
</cfif>
<cfset l = 'form.seveneighttarget' & '_' & #Qchkcounty.countyname#>
<cfset ll = #evaluate(l)#>
<cfset m = 'form.seveneightactual' & '_' & #Qchkcounty.countyname#>
<cfset mm = #evaluate(m)#></cfoutput>
	<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QnewRecord">
	update eoy_smartcounty
	set
	<cfif session.fy LT 2009>sixsevenactual=<cfif isDefined("kk")> #kk#<cfelse>NULL</cfif>,</cfif>
	seveneighttarget=<cfif isDefined("ll")> #ll#<cfelse>NULL</cfif>,
	seveneightactual=<cfif isDefined("mm")> #mm#<cfelse>NULL</cfif>
	where 
		<cfif isdefined("usid")>userid='#usid#'<cfelse>userid='#session.userid#' </cfif>
	and year2=#session.fy#	
	and countyname='#Qchkcounty.countyname#'
</cfquery> 


</cfif> 
</cfloop>
</cfif>
<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qchkdetail">
	select userid
	from eoy_details
	where 
		<cfif isdefined("usid")>userid='#usid#'<cfelse>userid='#session.userid#' </cfif>
	and year2=#session.fy#	
</cfquery>
<cfif Qchkdetail.recordcount GT 0>
<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QUpdRecord">
	update eoy_details
	set
	<cfif #btn# is 'tcp'>
	tcp_dt=<cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#now()#">,
	<cfelseif #btn# is 'partner'>
	partner_dt=<cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#now()#">,	
	</cfif>
	<cfif read is 0>
	<cfif #session.modality# is 2 or #session.modality# is 3>
	munistatus=<cfif isDefined("form.munistatus")><cfqueryparam cfsqltype="cf_sql_varchar" value="#form.munistatus#"><cfelse>NULL</cfif>,
	muniprogress=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.muniprogress#">,
	munibarriers=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.munibarriers#">,
	
	munistatus2=<cfif isDefined("form.munistatus2")><cfqueryparam cfsqltype="cf_sql_varchar" value="#form.munistatus2#"><cfelse>NULL</cfif>,
	muniprogress2=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.muniprogress2#">,
	munibarriers2=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.munibarriers2#">,
	
	<cfif session.fy LT 2009>muniactions=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.muniactions#">,</cfif>
	retailnum=<cfqueryparam cfsqltype="CF_SQL_BIGINT" value="#form.retailnum#" null="#IIF(form.retailnum EQ "", true, false)#">,
	retailstatus=<cfif isDefined("form.retailstatus")><cfqueryparam cfsqltype="cf_sql_varchar" value="#form.retailstatus#"><cfelse>NULL</cfif>,
	retailprogress=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.retailprogress#">,
	retailbarriers=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.retailbarriers#">,
	<cfif session.fy LT 2009>retailactions=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.retailactions#">,</cfif>
	ordistatus=<cfif isDefined("form.ordistatus")><cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ordistatus#"><cfelse>NULL</cfif>,
	ordiprogress=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ordiprogress#">,
	ordibarriers=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ordibarriers#">,
	<cfif session.fy LT 2009>ordiactions=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ordiactions#">,</cfif>
	orgnum=<cfqueryparam cfsqltype="CF_SQL_BIGINT" value="#form.orgnum#" null="#IIF(form.orgnum EQ "", true, false)#">,
	orgstatus=<cfif isDefined("form.orgstatus")><cfqueryparam cfsqltype="cf_sql_varchar" value="#form.orgstatus#"><cfelse>NULL</cfif>,
	orgprogress=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.orgprogress#">,
	orgbarriers=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.orgbarriers#">,
	<cfif session.fy LT 2009>orgactions=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.orgactions#">,</cfif>
	coordstatus=<cfif isDefined("form.coordstatus")><cfqueryparam cfsqltype="cf_sql_varchar" value="#form.coordstatus#"><cfelse>NULL</cfif>,
	coordprogress=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.coordprogress#">,
	coordbarriers=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.coordbarriers#">,
	<cfif session.fy LT 2009>coordactions=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.coordactions#">,</cfif>
	govt=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.govt#">,
	govtnum=<cfqueryparam cfsqltype="cf_sql_bigint" value="#form.govtnum#" null="#IIF(form.govtnum EQ "", true, false)#">,
	<!--- govtnum2=<cfif govt EQ 1><cfqueryparam cfsqltype="cf_sql_bigint" value="#form.govtnum2#"><cfelse>NULL</cfif> , --->
	govtstatus=<cfif isDefined("form.govtstatus")><cfqueryparam cfsqltype="cf_sql_varchar" value="#form.govtstatus#"><cfelse>NULL</cfif>,
	govtprogress=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.govtprogress#">,
	govtbarriers=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.govtbarriers#">,
	<cfif session.fy LT 2009>govtactions=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.govtactions#">,</cfif>
	</cfif>
	<cfif #session.modality# is 1>
	hosp1=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.hosp1#">,
	<cfif session.fy LT 2009>hosp2=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.hosp2#">,
	hosp3=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.hosp3#">,</cfif>
	hospstatus=<cfif isDefined("form.hospstatus")><cfqueryparam cfsqltype="cf_sql_varchar" value="#form.hospstatus#"><cfelse>NULL</cfif>,
	hospprogress=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.hospprogress#">,
	hospbarriers=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.hospbarriers#">,
	<cfif session.fy LT 2009>hospactions=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.hospactions#">,</cfif>
	hcpo1=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.hcpo1#">,
	<cfif session.fy LT 2009>hcpo2=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.hcpo2#">,
	hcpo3=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.hcpo3#">,</cfif>
	hcpostatus=<cfif isDefined("form.hcpostatus")><cfqueryparam cfsqltype="cf_sql_varchar" value="#form.hcpostatus#"><cfelse>NULL</cfif>,
	hcpoprogress=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.hcpoprogress#">,
	hcpobarriers=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.hcpobarriers#">,
	<cfif session.fy LT 2009>hcpoactions=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.hcpoactions#">,</cfif>
	clinstatus=<cfif isDefined("form.clinstatus")><cfqueryparam cfsqltype="cf_sql_varchar" value="#form.clinstatus#"><cfelse>NULL</cfif>,
	<cfif session.fy LT 2009>clinprogress=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.clinprogress#">,
	clinbarriers=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.clinbarriers#">,
	clinactions=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.clinactions#">,</cfif>
	moustatus=<cfif isDefined("form.moustatus")><cfqueryparam cfsqltype="cf_sql_varchar" value="#form.moustatus#"><cfelse>NULL</cfif>,
	mouprogress=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.mouprogress#">,
	moubarriers=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.moubarriers#">,
	<cfif session.fy LT 2009>mouactions=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.mouactions#">,</cfif>
	medistatus=<cfif isDefined("form.medistatus")><cfqueryparam cfsqltype="cf_sql_varchar" value="#form.medistatus#"><cfelse>NULL</cfif>,
	mediprogress=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.mediprogress#">,
	medibarriers=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.medibarriers#">,
	<cfif session.fy LT 2009>mediactions=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.mediactions#">,</cfif>
	ccstatus=<cfif isDefined("form.ccstatus")><cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ccstatus#"><cfelse>NULL</cfif>,
	<cfif session.fy LT 2009>ccprogress=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ccprogress#">,
	ccbarriers=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ccbarriers#">,
	ccactions=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ccactions#">,</cfif>
	cc2status=<cfif isDefined("form.cc2status")><cfqueryparam cfsqltype="cf_sql_varchar" value="#form.cc2status#"><cfelse>NULL</cfif>,
	cc2progress=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.cc2progress#">,
	cc2barriers=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.cc2barriers#">,
	<cfif session.fy LT 2009>cc2actions=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.cc2actions#">,</cfif>
	health=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.health#">,
	<cfif session.fy LT 2009>healthnum=<cfqueryparam cfsqltype="cf_sql_bigint" value="#form.healthnum#" null="#IIF(form.healthnum EQ "", true, false)#">,</cfif>
	healthnum2=<cfqueryparam cfsqltype="cf_sql_bigint" value="#form.healthnum2#" null="#IIF(form.healthnum2 EQ "", true, false)#">,
	healthstatus=<cfif isDefined("form.healthstatus")><cfqueryparam cfsqltype="cf_sql_varchar" value="#form.healthstatus#"><cfelse>NULL</cfif>,
	healthprogress=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.healthprogress#">,
	healthbarriers=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.healthbarriers#">,
	<cfif session.fy LT 2009>healthactions=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.healthactions#">,</cfif>
	busi=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.busi#">,
	businum1=<cfqueryparam cfsqltype="cf_sql_bigint" value="#form.businum1#" null="#IIF(form.businum1 EQ "", true, false)#">,
	businum2=<cfqueryparam cfsqltype="cf_sql_bigint" value="#form.businum2#" null="#IIF(form.businum2 EQ "", true, false)#">,
	busistatus=<cfif isDefined("form.busistatus")><cfqueryparam cfsqltype="cf_sql_varchar" value="#form.busistatus#"><cfelse>NULL</cfif>,
	busiprogress=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.busiprogress#">,
	busibarriers=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.busibarriers#">,
	<cfif session.fy LT 2009>busiactions=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.busiactions#">,</cfif>
	<cfif session.fy GT 2008>
	hosp3a=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.hosp3a#">,
	hcpo3a=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.hcpo3a#">,
	
	numHCPOdev=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.numHCPOdev#">,
	tempdsp=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.tempdsp#">,	
	sm7a=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sm7a#">,
	sm7b=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sm7b#">,
	
	<!--- qlinenum2=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.qlinenum2#">, --->
	
	numHPlans=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.numHPlans#">,
	
	FTQ1=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.FTQ1#">,
	FTQ2=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.FTQ2#">,
	FTQ3=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.FTQ3#">,
	
	FTQstatus=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.FTQstatus#">,	
	FTQprogress=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.FTQprogress#">,	
	FTQbarriers=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.FTQbarriers#">,
	
	cc3progress=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.cc3progress#">,
	cc3barriers=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.cc3barriers#">,
	
	QFPprogress=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.QFPprogress#">,
	QFPbarriers=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.QFPbarriers#">,
	
	Maint=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Maint#" null="#IIF(form.Maint EQ "", true, false)#">,
	Maintprogress=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Maintprogress#">,
	Maintbarriers=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Maintbarriers#">,

	
	</cfif>
	</cfif>
	<cfif #session.modality# is 2>
	multistatus=<cfif isDefined("form.multistatus")><cfqueryparam cfsqltype="cf_sql_varchar" value="#form.multistatus#"><cfelse>NULL</cfif>,
	multiprogress=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.multiprogress#">,
	multibarriers=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.multibarriers#">,
	<cfif session.fy LT 2009>multiactions=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.multiactions#">,</cfif>
	excise=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.excise#">,
	excisestatus=<cfif isDefined("form.excisestatus")><cfqueryparam cfsqltype="cf_sql_varchar" value="#form.excisestatus#"><cfelse>NULL</cfif>,
	exciseprogress=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.exciseprogress#">,
	excisebarriers=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.excisebarriers#">,
	<cfif session.fy LT 2009>exciseactions=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.exciseactions#">,</cfif>
	</cfif>
	<cfif #session.modality# is 3>
	agnum1=<cfqueryparam cfsqltype="cf_sql_bigint" value="#form.agnum1#" null="#IIF(form.agnum1 EQ "", true, false)#">,
	agnum2=<cfqueryparam cfsqltype="cf_sql_bigint" value="#form.agnum2#" null="#IIF(form.agnum2 EQ "", true, false)#">,
	agstatus=<cfif isDefined("form.agstatus")><cfqueryparam cfsqltype="cf_sql_varchar" value="#form.agstatus#"><cfelse>NULL</cfif>,
	agprogress=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.agprogress#">,
	agbarriers=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.agbarriers#">,
	<cfif session.fy LT 2009>agactions=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.agactions#">,</cfif>
	sbstatus=<cfif isDefined("form.sbstatus")><cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sbstatus#"><cfelse>NULL</cfif>,
	sbprogress=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sbprogress#">,
	sbbarriers=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sbbarriers#">,
	<cfif session.fy LT 2009>sbactions=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sbactions#">,</cfif>
	sfmstatus=<cfif isDefined("form.sfmstatus")><cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sfmstatus#"><cfelse>NULL</cfif>,
	sfmprogress=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sfmprogress#">,
	sfmbarriers=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sfmbarriers#">,
	<cfif session.fy LT 2009>sfmactions=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sfmactions#">,
	mpaastatus=<cfif isDefined("form.mpaastatus")><cfqueryparam cfsqltype="cf_sql_varchar" value="#form.mpaastatus#"><cfelse>NULL</cfif>,
	mpaaprogress=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.mpaaprogress#">,
	mpaabarriers=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.mpaabarriers#">,
	mpaaactions=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.mpaaactions#">,</cfif>
	</cfif>
	<cfif #session.modality# is 1 or #session.modality# is 2>
	qline1=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.qline1#">,
	qline2=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.qline2#">,
	qlinenum=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.qlinenum#">,
	qlinestatus=<cfif isDefined("form.qlinestatus")><cfqueryparam cfsqltype="cf_sql_varchar" value="#form.qlinestatus#"><cfelse>NULL</cfif>,
	qlineprogress=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.qlineprogress#">,
	qlinebarriers=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.qlinebarriers#">,
	<cfif session.fy LT 2009>qlineactions=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.qlineactions#">,</cfif>
</cfif>
<cfif isDefined("form.customcomment")>
	customcomment=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.customcomment#">,
</cfif>
	<cfelse>
	<cfif #session.modality# EQ 1>
	hospfeedback=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.hospfeedback#">,

	hcpofeedback=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.hcpofeedback#">,
	<cfif session.fy LT 2009>clinfeedback=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.clinfeedback#">,</cfif>
	moufeedback=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.moufeedback#">,
	<cfif session.fy LT 2009>ccfeedback=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ccfeedback#">,	</cfif>
	medifeedback=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.medifeedback#">,
	cc2feedback=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.cc2feedback#">,
	healthfeedback=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.healthfeedback#">,
	busifeedback=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.busifeedback#">,
	
<cfif session.fy GT 2008>
	FTQfeedback=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.FTQfeedback#">,
	cc3feedback=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.cc3feedback#">,
	QFPfeedback=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.QFPfeedback#">,
	Maintfeedback=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Maintfeedback#">,
</cfif>

<cfelseif #session.modality# is 2 or #session.modality# is 3>

<cfif #session.modality# is 2>
		multifeedback=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.multifeedback#">,
			excisefeedback=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.excisefeedback#">,
		</cfif>
		<cfif #session.modality# is 3>
			agfeedback=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.agfeedback#">,
				sbfeedback=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sbfeedback#">,
	sfmfeedback=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sfmfeedback#">,
	<cfif session.fy lt 2009>
		mpaafeedback=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.mpaafeedback#">,
</cfif>

		</cfif>
			retailfeedback=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.retailfeedback#">,
	munifeedback=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.munifeedback#">,
	munifeedback2=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.munifeedback2#">,
	ordifeedback=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ordifeedback#">,
	orgfeedback=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.orgfeedback#">,
		coordfeedback=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.coordfeedback#">,
	govtfeedback=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.govtfeedback#">,
</cfif>
	<cfif session.modality EQ 4>
	sm1_feedback=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sm1_feedback#">,
	sm2_feedback=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sm2_feedback#">,
	sm3_feedback=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sm3_feedback#">,
	
		
	tcp1=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.tcp1#">,
	tcp2=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.tcp2#">,
	tcp3=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.tcp3#">,
	tcp4=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.tcp4#">,
	tcpfeedback=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.tcpfeedback#">,
	
	<cfelse>
	qlinefeedback=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.qlinefeedback#">,


	customfeedback=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.customfeedback#">,
	tcp1=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.tcp1#">,
	tcp2=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.tcp2#">,
	tcp3=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.tcp3#">,
	tcp4=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.tcp4#">,
	tcpfeedback=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.tcpfeedback#">,
	</cfif>
	<cfif isdefined("form.eoycomplete")>
	eoycomplete=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.eoycomplete#">,
	
	<cfif #eoycomplete# is 1 and (not isdefined("eoy_dt") or #eoy_dt# is '')>
	eoy_dt=<cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#now()#">,
	</cfif></cfif>
	</cfif>
<!--- 	<cfif session.modality EQ 4>
	sm1_status=<cfif isDefined("form.sm1_status")><cfqueryparam cfsqltype="cf_sql_bit" value="#form.sm1_status#"><cfelse>NULL</cfif>,
	sm1_barrier=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sm1_barrier#">,
	sm1_progress=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sm1_progress#">,
	sm1_actions=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sm1_actions#">,
	
	sm2_status=<cfif isDefined("form.sm2_status")><cfqueryparam cfsqltype="cf_sql_bit" value="#form.sm2_status#"><cfelse>NULL</cfif>,
	sm2_barrier=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sm2_barrier#">,
	sm2_progress=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sm2_progress#">,
	sm2_actions=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sm2_actions#">,
	
	cbseq=<cfif isDefined("form.yr1_2")><cfqueryparam cfsqltype="cf_sql_varchar" value="#form.yr1_2#"><cfelse>NULL</cfif>,
	</cfif> --->
	year2=year2
	where 
		<cfif isdefined("usid")>userid='#usid#'<cfelse>userid='#session.userid#' </cfif>
	and year2=#session.fy#	
</cfquery>
</cfif>

<cfif isDefined("URL.statusC") and URL.statusC EQ 'comp'>
<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QUpdRecorda">
	update eoy_basics
	set
	complete=<cfif isDefined("form.completed")>#form.completed#<cfelse>0</cfif>
	where 
		<cfif isdefined("usid")>userid='#usid#'<cfelse>userid='#session.userid#' </cfif>
	and year2=#session.fy#	
</cfquery>

<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QcheckAMUserinfo">
	select c.orgname, c.contact, c.coordemail as email, c2.coordemail as amemail
	from contact as c, contact as c2 --, area as a
	where 
	<cfif isdefined("usid")>c.userid='#usid#'<cfelse>c.userid='#session.userid#' </cfif>
	and c.cmanager=c2.userid
	-- and a.year2=#session.fy#
	-- and a.manager_id=c2.userid
	
</cfquery>

<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QcheckModManinfo">
	select c2.coordemail as mmemail
	from contact as c, contact as c2, modality_manager as m
	where 
		<cfif isdefined("usid")>c.userid='#usid#'<cfelse>c.userid='#session.userid#' </cfif>
	and c.partnertype=m.modality
	and m.userid=c2.userid
	
</cfquery>

<cfmail from="bettybrown@rti.org" to="#QcheckAMUserinfo.amemail#; #QcheckModManinfo.mmemail#; amw06@health.state.ny.us" bcc="dplotner@rti.org" subject="End-of-Year Progress Report Submitted by #QcheckAMUserinfo.orgname#" type="html">
#QcheckAMUserinfo.orgname# (#QcheckAMUserinfo.contact#) submitted their End-of-Year Progress Report.  Please
review and provide feedback.

</cfmail>

<cfelse><cfif read is 0>
<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QUpdRecord">
	update eoy_basics
	set

	namesig=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.namesig#">,
	contamt=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.contamt#" null="#IIF(form.contamt EQ "", true, false)#">,
	agencydir=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.agencydir#">,
	accomp=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.accomp#">,
	goals=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.goals#">,
	<cfif session.modality EQ 4>
	sm1_status=<cfif isDefined("form.sm1_status")><cfqueryparam cfsqltype="cf_sql_bit" value="#form.sm1_status#"><cfelse>NULL</cfif>,
	sm1_barrier=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sm1_barrier#">,
	sm1_progress=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sm1_progress#">,
	sm1_actions=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sm1_actions#">,
	
	sm2_status=<cfif isDefined("form.sm2_status")><cfqueryparam cfsqltype="cf_sql_bit" value="#form.sm2_status#"><cfelse>NULL</cfif>,
	sm2_barrier=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sm2_barrier#">,
	sm2_progress=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sm2_progress#">,
	sm2_actions=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sm2_actions#">,
	
	<cfif session.fy GTE 2008>
	sm3_status=<cfif isDefined("form.sm3_status")><cfqueryparam cfsqltype="cf_sql_bit" value="#form.sm3_status#"><cfelse>NULL</cfif>,
	sm3_barrier=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sm3_barrier#">,
	sm3_progress=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sm3_progress#">,
	sm3_actions=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sm3_actions#">,
	</cfif>
	
	cbseq=<cfif isDefined("form.yr1_2")><cfqueryparam cfsqltype="cf_sql_varchar" value="#form.yr1_2#"><cfelse>NULL</cfif>,
	</cfif>
	year2=year2
	where 
		<cfif isdefined("usid")>userid='#usid#'<cfelse>userid='#session.userid#' </cfif>
	and year2=#session.fy#	
</cfquery>	</cfif>

</cfif>


<cfif isDefined("form.compPartner") and form.compPartner EQ 1>
	
<cfif isdefined("usid")>
	<cfset tmpUsid='#usid#'>
<cfelse>
	<cfset tmpUsid='#session.userid#'>
</cfif>

<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QUPDAudit">
UPDATE EOY_DETAILS
SET partner_status=1
where 
		<cfif isdefined("usid")>userid='#usid#'<cfelse>userid='#session.userid#' </cfif>
and year2=#session.fy#	
</cfquery>

<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QindAudit">
insert into eoy_audit
(userid, year2, type, dtstmp)
values
(<cfqueryparam cfsqltype="cf_sql_varchar" value="#tmpUsid#">, <cfqueryparam cfsqltype="cf_sql_varchar" value="#session.fy#">,
'Partner', <cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#now()#">)
</cfquery>


<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QUpdRecord">
delete from extensions
where userid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#session.userid#">
and exttype=5	
</cfquery>

<cfset session.newExt_5 = '0'>

<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qcontactinfo">
select c.orgname, c.coordemail as email, c2.coordemail as manmail, c3.coordemail as modalityemail
from contact c, contact c2, contact c3, --area a, 
modality_manager m
where 
c.userid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#session.userid#">
and c.cmanager=c2.userid
and c.partnertype=m.modality
and m.userid=c3.userid
	
		
<!--- select c.orgname, c.email, c2.email as manmail, c3.email as modalityemail
from contact c, contact c2, contact c3, area a, modality_manager m
where 
c.userid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#session.userid#">
and c.area=a.num
and a.manager_id=c2.userid
and c.partnertype=m.modality
and m.userid=c3.userid
and a.year2=#session.fy# --->
</cfquery>

<cfmail from="nsarris@rti.org" to="#Qcontactinfo.manmail#; #Qcontactinfo.modalityemail#" subject="EOY report submitted: #Qcontactinfo.orgname#" type="html">
#Qcontactinfo.orgname# has submitted their EOY report for FY #evaluate(session.fy-1)#-#session.fy#.
</cfmail>


</cfif>
<cfif isDefined("form.compTCP") and form.compTCP EQ 1>
<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QindAudit">
insert into eoy_audit
(userid, tcp, year2, type, dtstmp)
values
(<cfqueryparam cfsqltype="cf_sql_varchar" value="#usid#">, 
<cfqueryparam cfsqltype="cf_sql_varchar" value="#session.userid#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#session.fy#">,
'TCP', <cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#now()#">)
</cfquery>


<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QUPDAudit">
UPDATE EOY_DETAILS
SET TCP_status=1
where 
		<cfif isdefined("usid")>userid='#usid#'<cfelse>userid='#session.userid#' </cfif>
and year2=#session.fy#	
</cfquery>

<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qcontactinfo">
select c.orgname, c.coordemail as email, c2.coordemail as manmail, c3.coordemail as modalityemail
from contact c, contact c2, contact c3, <!--- area a, ---> modality_manager m
where 
c.userid = <cfif isdefined("usid")>'#usid#'<cfelse>'#session.userid#' </cfif>
--and c.area=a.num
--and a.manager_id=c2.userid
and c.partnertype=m.modality
and m.userid=c3.userid
--and a.year2=#session.fy#
and c.cmanager=c2.userid
</cfquery>

<cfmail from="nsarris@rti.org" to="#Qcontactinfo.email#" subject="Feedback on your EOY report" type="html">
TCP Reviewers have reviewed your EOY report for FY 2008-2009. 
To view the feedback, log into CAT, then click on "EOY Reports" under the "Administration" header. 
Comments will be inserted in the report. You can also view a PDF report by the name of "End-of-Year Report Summary" in the "Reports" section of CAT. 
To make any changes to your EOY report, you will need to request an extension by contacting Nikie Sarris at <a href="mailto:nsarris@rti.org">nsarris@rti.org</a> or 800-848-4091. 
When you have finalized your changes, please click the "Submit EOY Report" button.

</cfmail>
</cfif>

<cfif isDefined("tempModality")>
	<cfset session.modality=tempModality>
</cfif>
<cfparam name="form.sect" default="">
<cfif CGI.HTTP_USER_AGENT CONTAINS "MSIE">
	<cfset addloc = "&###form.sect#">
<cfelse>
	<cfset addloc = "###form.sect#">
</cfif>
<cfif isDefined("usid") and isDefined("form.compTCP") and form.compTCP EQ 1>
	<cflocation addtoken="yes" url="am_eoy_feedback_list.cfm">
</cfif>
 <cfif #session.modality# is 1>
	<cfif isdefined("usid")>
	<cflocation addtoken="no" url="cc_eoy_progress.cfm?modal=cc&usid=#usid#&#session.urltoken##addloc#">
	<cfelse>
	<cflocation addtoken="no" url="cc_eoy_progress.cfm?#session.urltoken##addloc#"></cfif>
<cfelseif #session.modality# is 2>
	<cfif isdefined("usid")>
		<cflocation addtoken="no" url="cp_eoy_progress.cfm?modal=cp&usid=#usid#&#session.urltoken##addloc#">
	<cfelse>
		<cflocation addtoken="no" url="cp_eoy_progress.cfm?#session.urltoken##addloc#">
	</cfif>
<cfelseif #session.modality# is 3>
 	<cfif isdefined("usid")>
		<cflocation addtoken="no" url="yp_eoy_progress.cfm?modal=yp&usid=#usid#&#session.urltoken##addloc#">
	<cfelse>
		<cflocation addtoken="no" url="yp_eoy_progress.cfm?#session.urltoken##addloc#">
	</cfif>
<cfelseif #session.modality# is 4>
 	<cfif isdefined("usid")>
		<cflocation addtoken="no" url="eoy_progress.cfm?usid=#usid#&#session.urltoken##addloc#">
	<cfelse>
		<cflocation addtoken="no" url="eoy_progress.cfm?#session.urltoken##addloc#">
	</cfif>

</cfif> 
