<cfparam name="form.dcs_numpart" default="">
<cfparam name="form.disparities" default="">
<cfparam name="form.plcwritpol" default="">
<cfparam name="form.ehr" default="">
<cfparam name="form.writstd" default="">
<cfparam name="form.askwritten" default="">
<cfparam name="form.askEHR" default="">
<cfparam name="form.askStandard" default="">
<cfparam name="form.id" default="">
<cfparam name="form.pp_target" default="">
<cfparam name="form.pp_wtdtpol" default="">
<cfparam name="form.pp_ask" default="">
<cfparam name="form.pp_advise" default="">
<cfparam name="form.hud_notes" default="">
<cfparam name="form.hud_units" default="">
<cfparam name="form.pp_assess" default="">
<cfparam name="form.pp_assist" default="">
<cfparam name="form.pp_arrange" default="">
<cfparam name="form.pp_referral" default="">
<cfparam name="form.pp_train" default="">
<cfparam name="form.hcpo_target" default="">
<cfparam name="form.hcpo_wtdtpol" default="">
<cfparam name="form.pp_hcp" default="">
<cfparam name="form.hcpo_orgpol" default="">
<cfparam name="form.hcpo_clinP" default="">
<cfparam name="form.hcpo_clinW" default="">
<cfparam name="form.hcpo_emr" default="">
<cfparam name="form.hcpo_other" default="">
<cfparam name="form.hcpo_ask" default="">
<cfparam name="form.hcpo_advise" default="">
<cfparam name="form.hcpo_assist" default="">
<cfparam name="form.hcpo_arrange" default="">
<cfparam name="form.hcpo_assess" default="">
<cfparam name="form.hcpo_refer" default="">
<cfparam name="form.hcpo_train" default="">
<cfparam name="form.hcpo_HCP" default="">
<cfparam name="form.HUD_seq" default="">


<cfif isdefined ("url.obj")>
	<cfset attributes.obj2=url.obj>
<cfelseif isDefined("form.obj2")>
	<cfset attributes.obj2=form.obj2>
<cfelseif isDefined("session.objval")>
	<cfset attributes.obj2=session.objval>
</cfif>
<cfif isDefined("url.mo")>
	<cfset session.monum = #url.mo#>
</cfif>
<!--- section add update and deletes --->
<!--- deletes first --->
<cfif isdefined("del_hsc")>
	<cfloop index="x" list="#delhsc#">
		<cfquery datasource="#application.DataSource#"

	password="#application.db_password#"
	username="#application.db_username#" name="del">
	delete from HSC_mon where id = <cfqueryparam value="#x#" cfsqltype="CF_SQL_INTEGER"> and mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
	</cfquery>
	</cfloop>
	<cfoutput>
		<cflocation url="month.cfm##tmhs" addtoken="no">
	</cfoutput>
</cfif>
<cfif isdefined("del_pm") and isDefined("form.Del_boxPM")>
	<cfloop index="x" list="#Del_boxPM#">
		<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="del">
	delete from monthly_media
	where
	monthlymediaid = <cfqueryparam value="#x#" cfsqltype="CF_SQL_INTEGER"> and mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
</cfquery>
	</cfloop>
	<cfoutput>
		<cflocation url="month.cfm##pro" addtoken="no">
	</cfoutput>
</cfif>
<cfif isdefined("del_dcs") and isDefined("form.Del_boxDCS")>
	<cfloop index="x" list="#Del_boxDCS#">
		<cfquery datasource="#application.DataSource#"

	password="#application.db_password#"
	username="#application.db_username#" name="del">
	delete from monthly_dcs
	where
	monthlydcsid = <cfqueryparam value="#x#" cfsqltype="CF_SQL_INTEGER"> and mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
	</cfquery>
	</cfloop>
	<cfoutput>
		<cflocation url="month.cfm##dcs" addtoken="no">
	</cfoutput>
</cfif>
<cfif isdefined("del_mob") and isDefined("form.Del_boxmob")>
	<cfloop index="x" list="#Del_boxmob#">
		<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="del">
	delete from monthly_commmob
	where
	monthlycommmobid = <cfqueryparam value="#x#" cfsqltype="CF_SQL_INTEGER"> and mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
	</cfquery>
	</cfloop>
	<cfoutput>
		<cflocation url="month.cfm##mob" addtoken="no">
	</cfoutput>
</cfif>
<cfif isdefined("del_comm") and isDefined("form.Del_boxcomm")>
	<cfloop index="x" list="#Del_boxcomm#">
		<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="del">
	delete from monthly_comm
	where
	monthlycommid = <cfqueryparam value="#x#" cfsqltype="CF_SQL_INTEGER"> and mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
	</cfquery>
	</cfloop>
	<cfoutput>
		<cflocation url="month.cfm##comm" addtoken="no">
	</cfoutput>
</cfif>
<cfif isdefined("del_adv") and isDefined("form.Del_boxadv")>
	<cfloop index="x" list="#Del_boxadv#">
		<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="del">
	delete from monthly_org
	where
	monthlyorgid = <cfqueryparam value="#x#" cfsqltype="CF_SQL_INTEGER"> and mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
	</cfquery>
	</cfloop>
	<cfoutput>
		<cflocation url="month.cfm##adv" addtoken="no">
	</cfoutput>
</cfif>
<cfif isdefined("del_PPC") and isDefined("form.Del_boxPPC")>
	<cfloop index="x" list="#Del_boxPPC#">
		<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="del">
	delete from monthly_cc
	where
	monthlyccid = <cfqueryparam value="#x#" cfsqltype="CF_SQL_INTEGER"> and mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
	</cfquery>
	</cfloop>
	<cfoutput>
		<cflocation url="month.cfm##ppc" addtoken="no">
	</cfoutput>
</cfif>
<cfif isdefined("del_CLIN") and isDefined("form.Del_boxCLIN")>
	<cfloop index="x" list="#Del_boxCLIN#">
		<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="del">
	delete from monthly_cc
	where
	monthlyccid = <cfqueryparam value="#x#" cfsqltype="CF_SQL_INTEGER"> and mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
	</cfquery>
	</cfloop>
	<cfoutput>
		<cflocation url="month.cfm##clin" addtoken="no">
	</cfoutput>
</cfif>
<cfif isdefined("del_HCPO") and isDefined("form.Del_boxHCPO")>
	<cfloop index="x" list="#Del_boxHCPO#">
		<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="del">
	delete from monthly_cc
	where
	monthlyccid = <cfqueryparam value="#x#" cfsqltype="CF_SQL_INTEGER"> and mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
	</cfquery>
	</cfloop>
	<cfoutput>
		<cflocation url="month.cfm##hcpo" addtoken="no">
	</cfoutput>
</cfif>

<cfif isdefined("del_box15")>
<cfloop index="x" list="#del_box15#">
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="del">
	delete from hud
	where
	seq = <cfqueryparam value="#x#" cfsqltype="CF_SQL_INTEGER">
	</cfquery>
</cfloop>
<cfoutput>
<cflocation url="month.cfm##hud" addtoken="no"></cfoutput>
</cfif>
<!--- other: insert or update --->



<cfif isDefined("form.add_HUD") and isdefined("form.HUD_target") and #form.hud_target# is not ''>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="checkHUD">
select *
from HUD
where
userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
and year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
and mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
and HUD_target=<cfqueryparam value="#form.HUD_target#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">
</cfquery>
<cfif checkHUD.recordcount EQ 1>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="updHUD">
update HUD
set HUD_target = <cfqueryparam  value="#form.HUD_target#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">,
HUD_notes = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" maxlength="1000" value="#form.HUD_notes#">,
units = <cfqueryparam  value="#form.units#" cfsqltype="CF_SQL_integer">
where
userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
and year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
and mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
and HUD_target=<cfqueryparam value="#form.HUD_target#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">
</cfquery>
<cflocation url="month.cfm##hud" addtoken="no">
<cfelse>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="insHSC">
insert into HUD
(userid, year2, mon, HUD_target, HUD_notes,units)
values
(
<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">,
<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
<cfqueryparam  cfsqltype="CF_SQL_VARCHAR" maxlength="10" value="#form.HUD_target#">,
<cfqueryparam value="#form.HUD_notes#" cfsqltype="CF_SQL_VARCHAR" maxlength="1000">,
<cfqueryparam  cfsqltype="CF_SQL_INTEGER" maxlength="5" value="#form.units#">
)
</cfquery></cfif>
</cfif>



<cfif isdefined("addpaidmedia")>
	<cfif addpaidmedia EQ "update">
		<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QInsDG">
update monthly_media
set mediatype= <cfqueryparam value="#form.mediatype#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
mediachannel= <cfqueryparam value="#form.mediachannel#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
spottitle= <cfqueryparam value="#form.spottitle#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
number= <cfqueryparam value="#form.number#" cfsqltype="CF_SQL_INTEGER">,
cost= <cfqueryparam value="#form.cost#" cfsqltype="CF_SQL_INTEGER">
where
monthlymediaID= <cfqueryparam value="#form.targid03#" cfsqltype="CF_SQL_INTEGER">
</cfquery>
	<cfelse>
		<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QSelPG">
	select *
	from monthly_media
	where userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
	and initnum = <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">
	and spottitle = <cfqueryparam value="#form.spottitle#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and mediatype = <cfqueryparam value="#form.mediatype#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and mediachannel = <cfqueryparam value="#form.mediachannel#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and number = <cfqueryparam value="#form.number#" cfsqltype="CF_SQL_INTEGER">
	</cfquery>
		<cfif QSelPG.recordcount is 0>
			<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QInsDG">
insert into monthly_media
(userid, year2,  mon, initnum, mediatype,mediachannel,spottitle,number,cost)
values
(<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">, <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">, <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">, <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">, <cfqueryparam value="#form.mediatype#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,<cfqueryparam value="#form.mediachannel#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,<cfqueryparam value="#form.spottitle#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,<cfqueryparam value="#form.number#" cfsqltype="CF_SQL_INTEGER">,<cfqueryparam value="#form.cost#" cfsqltype="CF_SQL_INTEGER">)
</cfquery>
		</cfif>
		<cfoutput>
			<cflocation url="month.cfm##pm" addtoken="no">
		</cfoutput>
	</cfif>
</cfif>
<cfif isdefined("add_dcs")>
	<cfif add_dcs EQ "update">
		<cfquery datasource="#application.DataSource#"

	password="#application.db_password#"
	username="#application.db_username#" name="QInsDG">
update monthly_dcs
set
[location]=<cfqueryparam value="#form.dcs_loc#" cfsqltype="CF_SQL_VARCHAR" maxlength="255">,
numSess=<cfqueryparam value="#form.dcs_numses#" cfsqltype="CF_SQL_INTEGER">,
numPart=<cfqueryparam value="#form.dcs_numpart#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.dcs_numpart))#">,
descr=<cfqueryparam value="#form.dcs_descr#" cfsqltype="CF_SQL_VARCHAR" maxlength="5000">
where
monthlydcsID=<cfqueryparam value="#form.targid04#" cfsqltype="CF_SQL_INTEGER">
</cfquery>
	<cfelse>
		<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QInsDG">
insert into monthly_dcs
(userid, year2,  mon, initnum,
location, numSess<cfif isdefined("form.dcs_numpart")>, numPart</cfif>, descr)
values
(<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">, <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">, <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">, <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">,
<cfqueryparam value="#form.dcs_loc#" cfsqltype="CF_SQL_VARCHAR" maxlength="255">,<cfqueryparam value="#form.dcs_numses#" cfsqltype="CF_SQL_INTEGER">,<cfqueryparam value="#form.dcs_numpart#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.dcs_numpart))#">,<cfqueryparam value="#form.dcs_descr#" cfsqltype="CF_SQL_VARCHAR" maxlength="5000">)
</cfquery>
	</cfif>
	<cfoutput>
		<cflocation url="month.cfm##dcs" addtoken="no">
	</cfoutput>
</cfif>
<cfif isdefined("add_mob")>
	<cfif add_mob EQ "update">
		<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QInsMob">
update monthly_commmob
set
target=<cfqueryparam value="#form.mob_target#" cfsqltype="CF_SQL_INTEGER">,
descr=<cfqueryparam value="#form.mob_descr#" cfsqltype="CF_SQL_VARCHAR" maxlength="5000">, [group] =<cfif session.fy GTE 2015><cfqueryparam value="#form.mob_group#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"><cfelse>Null</cfif>
where
monthlycommmobID=<cfqueryparam value="#form.targid05#" cfsqltype="CF_SQL_INTEGER">
</cfquery>
	<cfelse>
		<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QInsMob">
insert into monthly_commmob
(userid, year2,  mon, initnum,
target, descr, [group])
values
(<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">, <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">, <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">, <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">,
<cfqueryparam value="#form.mob_target#" cfsqltype="CF_SQL_INTEGER">,<cfqueryparam value="#form.mob_descr#" cfsqltype="CF_SQL_VARCHAR" maxlength="5000">, <cfif session.fy GTE 2015 and isdefined("form.mob_group")><cfqueryparam value="#form.mob_group#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"><cfelse>Null</cfif>)
</cfquery>
	</cfif>
	<cfoutput>
		<cflocation url="month.cfm##mob" addtoken="no">
	</cfoutput>
</cfif>
<cfif isdefined("add_commed")>
	<cfif add_commed EQ "update">
		<cfquery datasource="#application.DataSource#"

	password="#application.db_password#"
	username="#application.db_username#" name="QInsComm">
update monthly_comm
set
target=<cfqueryparam value="#form.commed_target#" cfsqltype="CF_SQL_VARCHAR" maxlength="55">,
staff=<cfif isDefined("form.comm_staff")><cfqueryparam value="#comm_staff#" cfsqltype="CF_SQL_INTEGER"><cfelse>0</cfif>,
train=<cfif isDefined("form.comm_train")><cfqueryparam value="#comm_train#" cfsqltype="CF_SQL_INTEGER"><cfelse>0</cfif>,
ta=<cfif isDefined("form.comm_ta")><cfqueryparam value="#comm_ta#" cfsqltype="CF_SQL_INTEGER"><cfelse>0</cfif>,
nrt=<cfif isDefined("form.comm_nrt")><cfqueryparam value="#comm_nrt#" cfsqltype="CF_SQL_INTEGER"><cfelse>0</cfif>,
tfo=<cfif isDefined("form.comm_tfo")><cfqueryparam value="#comm_tfo#" cfsqltype="CF_SQL_INTEGER"><cfelse>0</cfif>,
descr=<cfqueryparam value="#form.commed_descr#" cfsqltype="CF_SQL_VARCHAR" maxlength="5000">
where
monthlycommID=<cfqueryparam value="#form.targid06#" cfsqltype="CF_SQL_INTEGER">
</cfquery>
	<cfelse>
		<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QInsComm">
insert into monthly_comm
(userid, year2,  mon, initnum,
target,
staff, train, ta, nrt, tfo, descr)
values
(<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">, <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">, <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">, <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">,
<cfqueryparam value="#form.commed_target#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
<cfif isDefined("form.comm_staff")><cfqueryparam value="#comm_staff#" cfsqltype="CF_SQL_INTEGER"><cfelse>0</cfif>,
 <cfif isDefined("form.comm_train")><cfqueryparam value="#comm_train#" cfsqltype="CF_SQL_INTEGER"><cfelse>0</cfif>,
<cfif isDefined("form.comm_ta")><cfqueryparam value="#comm_ta#" cfsqltype="CF_SQL_INTEGER"><cfelse>0</cfif>,
<cfif isDefined("form.comm_nrt")><cfqueryparam value="#comm_nrt#" cfsqltype="CF_SQL_INTEGER"><cfelse>0</cfif>,
<cfif isDefined("form.comm_tfo")><cfqueryparam value="#comm_tfo#" cfsqltype="CF_SQL_INTEGER"><cfelse>0</cfif>,
<cfqueryparam value="#form.commed_descr#" cfsqltype="CF_SQL_VARCHAR" maxlength="5000">)
</cfquery>
	</cfif>
	<cfoutput>
		<cflocation url="month.cfm##comm" addtoken="no">
	</cfoutput>
</cfif>
<cfif isdefined("add_adv")>
	<cfif add_adv EQ "update">
		<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QInsAdv">
update monthly_org
set
adcomm=<cfif isDefined("form.adv_adcom") and #form.adv_adcom# is not ''><cfqueryparam value="#adv_adcom#" cfsqltype="CF_SQL_INTEGER"><cfelse>0</cfif>,
edIssues=<cfif isDefined("form.adv_edIssues") and #form.adv_edIssues# is not ''><cfqueryparam value="#adv_edIssues#" cfsqltype="CF_SQL_INTEGER"><cfelse>0</cfif>,
edPol=<cfif isDefined("form.adv_edPol") and #form.adv_edPol# is not ''><cfqueryparam value="#adv_edPol#" cfsqltype="CF_SQL_INTEGER"><cfelse>0</cfif>,
comPol=<cfif isDefined("form.adv_comPol") and #form.adv_comPol# is not ''><cfqueryparam value="#adv_comPol#" cfsqltype="CF_SQL_INTEGER"><cfelse>0</cfif>,
polTime=<cfif isDefined("form.adv_polTime") and #form.adv_polTime# is not ''><cfqueryparam value="#adv_polTime#" cfsqltype="CF_SQL_INTEGER"><cfelse>0</cfif>,
polAdopt=<cfif isDefined("form.adv_polAdopt") and #form.adv_polAdopt# is not ''><cfqueryparam value="#adv_polAdopt#" cfsqltype="CF_SQL_INTEGER"><cfelse>0</cfif>,
descr=<cfqueryparam value="#form.adv_notes#" cfsqltype="CF_SQL_VARCHAR" maxlength="4000">
where
monthlyorgID=<cfqueryparam value="#form.targid07#" cfsqltype="CF_SQL_INTEGER">
</cfquery>
	<cfelse>
		<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QInsAdv">
insert into monthly_org
(userid, year2,  mon, initnum,
org,
adcomm, edIssues, edPol, comPol, polTime, polAdopt, descr
)
values
(<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">, <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">, <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">, <cfqueryparam value="#attributes.obj2#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">,
<cfqueryparam value="#adv_target#" cfsqltype="CF_SQL_INTEGER">,
<cfif isDefined("form.adv_adcom") and #form.adv_adcom# is not ''><cfqueryparam value="#adv_adcom#" cfsqltype="CF_SQL_INTEGER"><cfelse>0</cfif>,
 <cfif isDefined("form.adv_edIssues") and #form.adv_edIssues# is not ''><cfqueryparam value="#adv_edIssues#" cfsqltype="CF_SQL_INTEGER"><cfelse>0</cfif>,
<cfif isDefined("form.adv_edPol") and #form.adv_edPol# is not ''><cfqueryparam value="#adv_edPol#" cfsqltype="CF_SQL_INTEGER"><cfelse>0</cfif>,
<cfif isDefined("form.adv_comPol") and #form.adv_comPol# is not ''><cfqueryparam value="#adv_comPol#" cfsqltype="CF_SQL_INTEGER"><cfelse>0</cfif>,
<cfif isDefined("form.adv_polTime") and #form.adv_polTime# is not ''><cfqueryparam value="#adv_polTime#" cfsqltype="CF_SQL_INTEGER"><cfelse>0</cfif>,
<cfif isDefined("form.adv_polAdopt") and #form.adv_polAdopt# is not ''><cfqueryparam value="#adv_polAdopt#" cfsqltype="CF_SQL_INTEGER"><cfelse>0</cfif>,
<cfqueryparam value="#form.adv_notes#" cfsqltype="CF_SQL_VARCHAR" maxlength="4000">)
</cfquery>
	</cfif>
	<cfoutput>
		<cflocation url="month.cfm##adv" addtoken="no">
	</cfoutput>
</cfif>
<cfif isDefined("form.addHSC") and form.addHSC EQ "Add">
	<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="insHSC">
insert into HSC_mon
(id, mon, year2,plcwritpol,ehr,writstd,askwritten, askEHR, askStandard, nopol, confirmbase)
values
(
<cfqueryparam cfsqltype="CF_SQL_NUMERIC" value="#form.id#" null="#YesNoFormat(not Len(form.id))#">,
<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">,
<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">,
<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.plcwritpol#" null="#YesNoFormat(not Len(form.plcwritpol))#">,
<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.ehr#" null="#YesNoFormat(not Len(form.ehr))#">,
<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.writstd#" null="#YesNoFormat(not Len(form.writstd))#">,
<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.askwritten#" null="#YesNoFormat(not Len(form.askwritten))#">,
<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.askEHR#" null="#YesNoFormat(not Len(form.askEHR))#">,
<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.askStandard#" null="#YesNoFormat(not Len(form.askStandard))#">,
<cfif isdefined("form.nopol")>1 <cfelse>0</cfif>,
<cfif isdefined("form.confirmbase")>1 <cfelse>0</cfif>
)
</cfquery>
	<cflocation url="month.cfm?target=''##tmhs" addtoken="no">
<cfelseif isDefined("form.addHSC") and form.addHSC EQ "Update">
	<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="insHSC">
update  HSC_mon
set
plcwritpol= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.plcwritpol#" null="#YesNoFormat(not Len(form.plcwritpol))#">,
ehr= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.ehr#" null="#YesNoFormat(not Len(form.ehr))#">,
writstd= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.writstd#" null="#YesNoFormat(not Len(form.writstd))#">,
askwritten= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.askwritten#" null="#YesNoFormat(not Len(form.askwritten))#">,
askEHR= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.askEHR#" null="#YesNoFormat(not Len(form.askEHR))#">,
askStandard= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.askStandard#" null="#YesNoFormat(not Len(form.askStandard))#">,
nopol=<cfif isdefined("form.nopol")>1 <cfelse>0</cfif>,
confirmbase=<cfif isdefined("form.confirmbase")>1 <cfelse>0</cfif>
where
mon=<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
and year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
and id= <cfqueryparam cfsqltype="CF_SQL_NUMERIC" value="#form.id#">
</cfquery>
	<cfoutput>
		<cflocation url="month.cfm?target=''##tmhs" addtoken="no">
	</cfoutput>
</cfif>
<cfif isdefined("add_pp")>
	<cfif add_pp EQ "update">
		<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QInsPPC">
update monthly_cc
set
target= <cfqueryparam value="#form.pp_target#" cfsqltype="CF_SQL_INTEGER">,
wtdtpol=<cfqueryparam value="#form.pp_wtdtpol#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.pp_wtdtpol))#">,
ask=<cfqueryparam value="#form.pp_ask#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.pp_ask))#">,
advise_ident=<cfqueryparam value="#form.pp_advise#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.pp_advise))#">,
assess_ident=<cfqueryparam value="#form.pp_assess#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.pp_assess))#">,
assist=<cfqueryparam value="#form.pp_assist#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.pp_assist))#">,
arrange=<cfqueryparam value="#form.pp_arrange#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.pp_arrange))#">,
referral=<cfqueryparam value="#form.pp_referral#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.pp_referral))#">,
train=<cfqueryparam value="#form.pp_train#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.pp_train))#">,
definedHCP=<cfqueryparam value="#form.pp_hcp#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.pp_hcp))#">
where
monthlyccID=<cfqueryparam value="#form.targid08#" cfsqltype="CF_SQL_INTEGER">
</cfquery>
	<cfelse>
		<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QInsPPC">
insert into monthly_cc
(userid, year2,  mon, initnum,
target,[section],
wtdtpol, ask, advise_ident, assess_ident, assist, arrange, referral, train, definedHCP)
values
(<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">, <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">, <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">, <cfqueryparam value="#attributes.obj2#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">,
<cfqueryparam value="#form.pp_target#" cfsqltype="CF_SQL_INTEGER">,1,
<cfif isDefined("form.pp_wtdtpol")><cfqueryparam value="#form.pp_wtdtpol#" cfsqltype="CF_SQL_INTEGER"><cfelse>0</cfif>,
<cfif isDefined("form.pp_ask")><cfqueryparam value="#form.pp_ask#" cfsqltype="CF_SQL_INTEGER"><cfelse>0</cfif>,
<cfif isDefined("form.pp_advise")><cfqueryparam value="#form.pp_advise#" cfsqltype="CF_SQL_INTEGER"><cfelse>0</cfif>,
<cfif isDefined("form.pp_assess")><cfqueryparam value="#form.pp_assess#" cfsqltype="CF_SQL_INTEGER"><cfelse>0</cfif>,
<cfif isDefined("form.pp_assist")><cfqueryparam value="#form.pp_assist#" cfsqltype="CF_SQL_INTEGER"><cfelse>0</cfif>,
<cfif isDefined("form.pp_arrange")><cfqueryparam value="#form.pp_arrange#" cfsqltype="CF_SQL_INTEGER"><cfelse>0</cfif>,
<cfif isDefined("form.pp_referral")><cfqueryparam value="#form.pp_referral#" cfsqltype="CF_SQL_INTEGER"><cfelse>0</cfif>,
<cfif isDefined("form.pp_train")><cfqueryparam value="#form.pp_train#" cfsqltype="CF_SQL_INTEGER"><cfelse>0</cfif>,
<cfif isDefined("form.pp_HCP")><cfqueryparam value="#form.pp_hcp#" cfsqltype="CF_SQL_INTEGER"><cfelse>0</cfif>)
</cfquery>
	</cfif>
	<cfoutput>
		<cflocation url="month.cfm##ppc" addtoken="no">
	</cfoutput>
</cfif>
<cfif isdefined("add_clin")>
	<cfif add_clin EQ "update">
		<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QInsCLIN">
update monthly_cc
set
target= <cfqueryparam value="#form.clin_target#" cfsqltype="CF_SQL_INTEGER">,
clinp=<cfif isDefined("form.clin_p")><cfqueryparam value="#form.clin_p#" cfsqltype="CF_SQL_INTEGER"><cfelse>0</cfif>,
clinw=<cfif isDefined("form.clin_w")><cfqueryparam value="#form.clin_w#" cfsqltype="CF_SQL_INTEGER"><cfelse>0</cfif>,
clinother=<cfif isDefined("form.clin_other")><cfqueryparam value="#form.clin_other#" cfsqltype="CF_SQL_INTEGER"><cfelse>0</cfif>,
descr=<cfif isDefined("form.clin_descr")><cfqueryparam value="#form.clin_descr#" cfsqltype="CF_SQL_VARCHAR" maxlength="4000"><cfelse>NULL</cfif>,
descr2=<cfif isDefined("form.clin_descr2")><cfqueryparam value="#form.clin_descr2#" cfsqltype="CF_SQL_VARCHAR" maxlength="4000"><cfelse>NULL</cfif>,
descr3=<cfif isDefined("form.clin_descr3")><cfqueryparam value="#form.clin_descr3#" cfsqltype="CF_SQL_VARCHAR" maxlength="4000"><cfelse>NULL</cfif>,
ask=<cfif isDefined("form.clin_ask")><cfqueryparam value="#form.clin_ask#" cfsqltype="CF_SQL_INTEGER"><cfelse>0</cfif>,
advise_ident=<cfif isDefined("form.clin_advise")><cfqueryparam value="#form.clin_advise#" cfsqltype="CF_SQL_INTEGER"><cfelse>0</cfif>,
assess_ident=<cfif isDefined("form.clin_assess")><cfqueryparam value="#form.clin_assess#" cfsqltype="CF_SQL_INTEGER"><cfelse>0</cfif>,
assist=<cfif isDefined("form.clin_assist")><cfqueryparam value="#form.clin_assist#" cfsqltype="CF_SQL_INTEGER"><cfelse>0</cfif>,
arrange=<cfif isDefined("form.clin_arrange")><cfqueryparam value="#form.clin_arrange#" cfsqltype="CF_SQL_INTEGER"><cfelse>0</cfif>,
referral=<cfif isDefined("form.clin_refer")><cfqueryparam value="#form.clin_refer#" cfsqltype="CF_SQL_INTEGER"><cfelse>0</cfif>,
sysImp=<cfif isDefined("form.clin_sysImp")><cfqueryparam value="#form.clin_sysImp#" cfsqltype="CF_SQL_INTEGER"><cfelse>0</cfif>,
emr=<cfif isDefined("form.clin_emr")><cfqueryparam value="#form.clin_emr#" cfsqltype="CF_SQL_INTEGER"><cfelse>0</cfif>,
other=<cfif isDefined("form.clin_other")><cfqueryparam value="#form.clin_other#" cfsqltype="CF_SQL_INTEGER"><cfelse>0</cfif>,
descr4=<cfif isDefined("form.clin_descr4")><cfqueryparam value="#form.clin_descr4#" cfsqltype="CF_SQL_VARCHAR" maxlength="4000"><cfelse>NULL</cfif>
where
monthlyccID=<cfqueryparam value="#form.targid09#" cfsqltype="CF_SQL_INTEGER">
</cfquery>
	<cfelse>
		<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QInsCLIN">
insert into monthly_cc
(userid, year2,  mon, initnum,
target,[section],
clinp, clinw, clinother, descr, descr2, descr3,
ask, advise_ident, assess_ident, assist, arrange, referral,
sysImp, emr, other, descr4
)
values
(<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">, <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">, <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">, <cfqueryparam value="#attributes.obj2#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">,
<cfqueryparam value="#form.clin_target#" cfsqltype="CF_SQL_INTEGER">,2,
<cfif isDefined("form.clin_p")><cfqueryparam value="#form.clin_p#" cfsqltype="CF_SQL_INTEGER"><cfelse>0</cfif>,
<cfif isDefined("form.clin_w")><cfqueryparam value="#form.clin_w#" cfsqltype="CF_SQL_INTEGER"><cfelse>0</cfif>,
<cfif isDefined("form.clin_other")><cfqueryparam value="#form.clin_other#" cfsqltype="CF_SQL_INTEGER"><cfelse>0</cfif>,
<cfif isDefined("form.clin_descr")><cfqueryparam value="#form.clin_descr#" cfsqltype="CF_SQL_VARCHAR" maxlength="4000"><cfelse>NULL</cfif>,
<cfif isDefined("form.clin_descr2")><cfqueryparam value="#form.clin_descr2#" cfsqltype="CF_SQL_VARCHAR" maxlength="4000"><cfelse>NULL</cfif>,
<cfif isDefined("form.clin_descr3")><cfqueryparam value="#form.clin_descr3#" cfsqltype="CF_SQL_VARCHAR" maxlength="4000"><cfelse>NULL</cfif>,
<cfif isDefined("form.clin_ask")><cfqueryparam value="#form.clin_ask#" cfsqltype="CF_SQL_INTEGER"><cfelse>0</cfif>,
<cfif isDefined("form.clin_advise")><cfqueryparam value="#form.clin_advise#" cfsqltype="CF_SQL_INTEGER"><cfelse>0</cfif>,
<cfif isDefined("form.clin_assess")><cfqueryparam value="#form.clin_assess#" cfsqltype="CF_SQL_INTEGER"><cfelse>0</cfif>,
<cfif isDefined("form.clin_assist")><cfqueryparam value="#form.clin_assist#" cfsqltype="CF_SQL_INTEGER"><cfelse>0</cfif>,
<cfif isDefined("form.clin_arrange")><cfqueryparam value="#form.clin_arrange#" cfsqltype="CF_SQL_INTEGER"><cfelse>0</cfif>,
<cfif isDefined("form.clin_refer")><cfqueryparam value="#form.clin_refer#" cfsqltype="CF_SQL_INTEGER"><cfelse>0</cfif>,
<cfif isDefined("form.clin_sysImp")><cfqueryparam value="#form.clin_sysImp#" cfsqltype="CF_SQL_INTEGER"><cfelse>0</cfif>,
<cfif isDefined("form.clin_emr")><cfqueryparam value="#form.clin_emr#" cfsqltype="CF_SQL_INTEGER"><cfelse>0</cfif>,
<cfif isDefined("form.clin_other")><cfqueryparam value="#form.clin_other#" cfsqltype="CF_SQL_INTEGER"><cfelse>0</cfif>,
<cfif isDefined("form.clin_descr4")><cfqueryparam value="#form.clin_descr4#" cfsqltype="CF_SQL_VARCHAR" maxlength="4000"><cfelse>NULL</cfif>)
</cfquery>
	</cfif>
	<cfoutput>
		<cflocation url="month.cfm##clin" addtoken="no">
	</cfoutput>
</cfif>
<cfif isdefined("add_hcpo")>
	<cfif add_hcpo EQ "update">
		<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QInsHCPO">
update monthly_cc
set
target= <cfqueryparam value="#form.hcpo_target#" cfsqltype="CF_SQL_INTEGER">,
wtdtpol=<cfqueryparam value="#form.hcpo_wtdtpol#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.hcpo_wtdtpol))#">,
orgpol=<cfqueryparam value="#form.hcpo_orgpol#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.hcpo_orgpol))#">,
clinP=<cfqueryparam value="#form.hcpo_clinP#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.hcpo_clinP))#">,
clinW=<cfqueryparam value="#form.hcpo_clinW#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.hcpo_clinW))#">,
emr=<cfqueryparam value="#form.hcpo_emr#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.hcpo_emr))#">,
other=<cfqueryparam value="#form.hcpo_other#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.hcpo_other))#">,
descr=<cfif isDefined("form.hcpo_othertxt")><cfqueryparam value="#form.hcpo_othertxt#" cfsqltype="CF_SQL_VARCHAR" maxlength="4000"><cfelse>NULL</cfif>,
ask=<cfqueryparam value="#form.hcpo_ask#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.hcpo_ask))#">,
advise_ident=<cfqueryparam value="#form.hcpo_advise#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.hcpo_advise))#">,
assess_ident=<cfqueryparam value="#form.hcpo_assess#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.hcpo_assess))#">,
assist=<cfqueryparam value="#form.hcpo_assist#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.hcpo_assist))#">,
arrange=<cfqueryparam value="#form.hcpo_arrange#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.hcpo_arrange))#">,
referral=<cfqueryparam value="#form.hcpo_refer#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.hcpo_refer))#">,
train=<cfqueryparam value="#form.hcpo_train#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.hcpo_train))#">,
definedHCP=<cfqueryparam value="#form.hcpo_HCP#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.hcpo_HCP))#">
where
monthlyccID=<cfqueryparam value="#form.targid10#" cfsqltype="CF_SQL_INTEGER">
</cfquery>
	<cfelse>
		<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QInsHCPO">
insert into monthly_cc
(userid, year2,  mon, initnum,
target,[section],
wtdtpol,
orgpol, clinP, clinW, emr, other, descr,
ask, advise_ident, assess_ident, assist, arrange, referral, train, definedHCP)
values
(<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">, <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">, <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">, <cfqueryparam value="#attributes.obj2#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">,
<cfqueryparam value="#form.hcpo_target#" cfsqltype="CF_SQL_INTEGER">,1,
<cfif isDefined("form.hcpo_wtdtpol")><cfqueryparam value="#form.hcpo_wtdtpol#" cfsqltype="CF_SQL_INTEGER"><cfelse>0</cfif>,
<cfqueryparam value="#form.hcpo_orgpol#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.hcpo_orgpol))#">,
<cfqueryparam value="#form.hcpo_clinP#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.hcpo_clinP))#">,
<cfqueryparam value="#form.hcpo_clinW#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.hcpo_clinW))#">,
<cfqueryparam value="#form.hcpo_emr#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.hcpo_emr))#">,
<cfqueryparam value="#form.hcpo_other#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.hcpo_other))#">,
<cfif isDefined("form.hcpo_othertxt")><cfqueryparam value="#form.hcpo_othertxt#" cfsqltype="CF_SQL_VARCHAR" maxlength="4000"><cfelse>NULL</cfif>,
<cfif isDefined("form.hcpo_ask")><cfqueryparam value="#hcpo_ask#" cfsqltype="CF_SQL_INTEGER"><cfelse>0</cfif>,
<cfif isDefined("form.hcpo_advise")><cfqueryparam value="#hcpo_advise#" cfsqltype="CF_SQL_INTEGER"><cfelse>0</cfif>,
<cfif isDefined("form.hcpo_assess")><cfqueryparam value="#hcpo_assess#" cfsqltype="CF_SQL_INTEGER"><cfelse>0</cfif>,
<cfif isDefined("form.hcpo_assist")><cfqueryparam value="#hcpo_assist#" cfsqltype="CF_SQL_INTEGER"><cfelse>0</cfif>,
<cfif isDefined("form.hcpo_arrange")><cfqueryparam value="#hcpo_arrange#" cfsqltype="CF_SQL_INTEGER"><cfelse>0</cfif>,
<cfif isDefined("form.hcpo_refer")><cfqueryparam value="#hcpo_refer#" cfsqltype="CF_SQL_INTEGER"><cfelse>0</cfif>,
<cfif isDefined("form.hcpo_train")><cfqueryparam value="#hcpo_train#" cfsqltype="CF_SQL_INTEGER"><cfelse>0</cfif>,
<cfif isDefined("form.hcpo_HCP")><cfqueryparam value="#hcpo_HCP#" cfsqltype="CF_SQL_INTEGER"><cfelse>0</cfif>)
</cfquery>
	</cfif>
	<cfoutput>
		<cflocation url="month.cfm##hcpo" addtoken="no">
	</cfoutput>
</cfif>
<!---  --->
<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="testJunk">
select 'apples' as item, 1 as code union
select 'oranges' as item, 2 as code union
select 'pears' as item, 3 as code
</cfquery>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="collaborators">
  select c.name, c.indOrg, c.traditional, w.targethcpo as type, c.county,
  c.seq , c.unit,
case when c.unit IS NULL then c.NAME else c.unit + ' ' + NAME end as unitname ,
  del, case tHCPO when 0 then 'No' when 1 then 'Yes' else '-' end as tHCPO,
case tLevel
	when 1 then 'Potential'
	when 2 then 'Limited'
	when 3 then 'Full'
	else '-' end as tLevel,
	entdt,
	case FQHC when 1 then 'Yes' else 'No' end  as FQHC,
	case ref when 1 then 'Yes' else 'No' end  as ref,cess,pip,
  c.school, c.district , isnull(c.sodistrict,0) as sodistrict, isNull(c.sfy, 0) as sfy,
d.district_name,
s.institutionname
  from collaborators as c
left outer join  wrkplan_targethcpo as w on w.targethcpo_id = c.type and w.year2=c.year2
left outer join nysed_district as d on d.district_id = c.district
left outer join nysed_school as s on s.bedscode=c.school
  where userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> and (c.year2 >=1904)

  <!--- and (c.del is null or c.del != 1)
  and o.num = c.type and o.indorg=c.indorg
  and  c.year2=o.year2  --->
  and (c.del is null or c.del !=1) and c.year2  <cfif session.fy GT 2010 and session.modality EQ 1> >= 2010<cfelse> = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"></cfif>
  <cfif session.modality EQ 4>
  and c.district is not null
  <cfelse>
  and c.county is not null
  </cfif>
 <cfif session.modality EQ 4>order by 17, 18 --13, 12<Cfelse> order by 8,7,1</cfif>
  </cfquery>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="Qtargorg0">
select
	*
	from target_org tor where
	userid= <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and tor.year2= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and initnum=<cfqueryparam value="#attributes.obj2#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">
	and stratnum=0
	 <cfif not isdefined("url.seq")> and targid not in (select target from monthly_commmob where year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> and initnum=<cfqueryparam value="#attributes.obj2#" cfsqltype="CF_SQL_VARCHAR" maxlength="10"> and stratnum=0 and mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">)</cfif>
	order by name
</cfquery>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="Qtargorg1">
select
	*
	from target_org tor where
	userid= <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and tor.year2= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and initnum=<cfqueryparam value="#attributes.obj2#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">
	and stratnum=1
		order by name
</cfquery>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QtargGroups">
	select
	*
	from target_org tor left join wrkplan_targets w
    on tor.targnum = w.targetid
	where
	w.year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> and tor.userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> and tor.initnum = <cfqueryparam value="#attributes.obj2#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">
</cfquery>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="Qtargorg">
select
	*
	from target_org tor left join wrkplan_targets t on tor.targnum = t.targetid and tor.year2 = t.year2
	left join counties c on tor.county = c.fips
	where
	userid= <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and tor.year2= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and initnum=<cfqueryparam value="#attributes.obj2#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">
	and stratnum=1
		order by name
</cfquery>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="Qtargorgchc">
select
	targid, name
	from target_org tor where
	userid= <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and tor.year2= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and initnum=<cfqueryparam value="#attributes.obj2#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">
	and stratnum=1
		order by name
</cfquery>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="Qtargchc">
select
	targchcid, tor.targid, name, targsite
	from target_org tor inner join target_chc c on tor.targid = c.targid where
	userid= <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and tor.year2= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and initnum=<cfqueryparam value="#attributes.obj2#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">
	and stratnum=1
    and c.targid is not null
	order by name
</cfquery>
<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="getverk">
	select *
from wrkplan w
where
w.year2= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> and initnum = <cfqueryparam value="#attributes.obj2#" cfsqltype="CF_SQL_VARCHAR" maxlength="10"> and userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
</cfquery>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QgettargXXXS">
	select 	*
	from monthly_media
	where
	userid= <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and year2= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and initnum=<cfqueryparam value="#attributes.obj2#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">
</cfquery>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QgettargDCS">
	select 	*
	from monthly_dcs
	where
	userid= <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and year2= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and initnum=<cfqueryparam value="#attributes.obj2#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">
	and mon=<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
order by location
</cfquery>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QgettargMOB">
	select 	c.*, descr, name
	from monthly_commmob c, target_org tor
	where
	c.userid= <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and c.year2= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and c.year2=tor.year2
	and c.initnum=<cfqueryparam value="#attributes.obj2#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">
	and c.target=tor.targid
	and mon=<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
	order by name
</cfquery>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QgettargComm">
	<cfif attributes.obj2 EQ "1A">
	select 	cc.*, descr, name + ': ' + targsite as name
	--targchcid, tor.targid, name, targsite
	from monthly_comm cc, target_org tor
	inner join target_chc c on tor.targid = c.targid
	where
	cc.userid= <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and cc.year2= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and cc.year2=tor.year2
	and cc.initnum=<cfqueryparam value="#attributes.obj2#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">
	--and cc.target=tor.targid
	and mon=<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
	and cc.target=c.targchcid
<cfelse>
	select 	c.*, descr, name
	from monthly_comm c, target_org tor
	where
	c.userid= <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and c.year2= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and c.year2=tor.year2
	and c.initnum=<cfqueryparam value="#attributes.obj2#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">
	and c.target=tor.targid
	and mon=<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
	</cfif>
</cfquery>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="COMMED_Qtargorg">
select
	*
	from target_org tor left join wrkplan_targets t on tor.targnum = t.targetid and tor.year2 = t.year2
	left join counties c on tor.county = c.fips
	where
	userid= <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and tor.year2= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and initnum=<cfqueryparam value="#attributes.obj2#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">
	and stratnum=1
	order by name
</cfquery>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="COMMED_Qtargchc">
select
	targchcid, tor.targid, name, targsite
	from target_org tor inner join target_chc c on tor.targid = c.targid where
	userid= <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and tor.year2= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and initnum=<cfqueryparam value="#attributes.obj2#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">
	and stratnum=1
    and c.targid is not null
	order by name
</cfquery>
<cfif #attributes.obj2# is '8a' or #attributes.obj2# is '8b'>
	<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QgettargAdv">
SELECT c.*, ltrim(tor.targmhs) AS name
FROM  dbo.monthly_org AS c INNER JOIN
dbo.HSC AS tor ON (c.year2 = tor.year2
<cfloop index = "loop" from = "1" to = #session.yrsub#>
or tor.year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">-#loop#
</cfloop>) AND c.org = tor.id
WHERE (c.userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">) AND (c.year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">) AND (c.initnum = <cfqueryparam value="#attributes.obj2#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">) AND (c.mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">)
ORDER BY name
</cfquery>
<cfelse>
	<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QgettargAdv">
select 	c.*, descr, ltrim(name) as name
	from monthly_org c, target_org tor
	where
	c.userid= <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and c.year2= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and c.year2=tor.year2
	and c.initnum=<cfqueryparam value="#attributes.obj2#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">
	and c.org=tor.targid
	and mon=<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
	order by ltrim(name)
</cfquery>
</cfif>
<cfif isDefined("url.target") and url.target EQ "adv" and isDefined("url.seq")>
	<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="ADV_Qtargorg">
		SELECT c.*, tor.targmhs
FROM  dbo.monthly_org AS c INNER JOIN
dbo.HSC AS tor ON (c.year2 = tor.year2
<cfloop index = "loop" from = "1" to = #session.yrsub#>
or tor.year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">-#loop#
</cfloop>) AND c.org = tor.id
WHERE (c.userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">)
AND (c.year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">)
AND (c.initnum = <cfqueryparam value="#attributes.obj2#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">) AND (c.mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">) and monthlyorgid = <cfqueryparam value="#url.seq#" cfsqltype="CF_SQL_INTEGER">
and monthlyorgid=<cfqueryparam value="#url.seq#" cfsqltype="CF_SQL_INTEGER">
order by tor.targmhs
</cfquery>



</cfif>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="ADV_Qtargorgmedhealth">
		SELECT distinct ID, ltrim(targmhs) as targmhs, satoff, typehc,askwritten, askEHR, askStandard, nopol, confirmbase
FROM HSC tor left join wrkplan_targets t on tor.id = t.targetid and tor.year2 = t.year2
WHERE (tor.YEAR2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
<cfloop index = "loop" from = "1" to = #session.yrsub#>
or tor.year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">-#loop#
</cfloop>)
AND OBJ = <cfqueryparam value="#attributes.obj2#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">
AND USERID = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
and
	(id not in (select x.org from monthly_org x where x.userid= <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and x.year2= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and x.initnum=<cfqueryparam value="#attributes.obj2#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">
	and x.mon=<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">	))
ORDER BY targmhs
</cfquery>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="ADV_Qtargorgmedhealth2">
		SELECT ID, targmhs, satoff, typehc,askwritten, askEHR, askStandard, nopol, confirmbase
FROM HSC tor left join wrkplan_targets t on tor.id = t.targetid and tor.year2 = t.year2
WHERE (tor.YEAR2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
<cfloop index = "loop" from = "1" to = #session.yrsub#>
or tor.year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">-#loop#
</cfloop>)
AND OBJ = <cfqueryparam value="#attributes.obj2#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">
AND USERID = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
ORDER BY ltrim(targmhs)
</cfquery>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="ADV_Qtargorgmedhealthchc">
		SELECT id,ltrim(targmhs) as targmhs
FROM HSC tor
WHERE (tor.YEAR2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
<cfloop index = "loop" from = "1" to = #session.yrsub#>
or tor.year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">-#loop#
</cfloop>)
AND OBJ = <cfqueryparam value="#attributes.obj2#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">
AND USERID = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> <cfif not isdefined("form.id") and not isdefined("url.seq")> and id not in (select id from hsc_mon where mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER"> and year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">)</cfif>
ORDER BY ltrim(targmhs)
</cfquery>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="ADV_Qtargorgchc">
select
	targid, name
	from target_org tor where
	userid= <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and tor.year2= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and initnum=<cfqueryparam value="#attributes.obj2#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">
	and stratnum=1
	and
	(targid not in
	(select x.org from monthly_org x where x.userid= <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and x.year2= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and x.initnum=<cfqueryparam value="#attributes.obj2#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">
	and x.mon=<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">)
	<cfif isDefined("url.target") and url.target EQ "adv" and isDefined("url.seq")> OR targid=(select distinct org from monthly_org where monthlyorgid = <cfqueryparam value="#url.seq#" cfsqltype="CF_SQL_INTEGER">)</cfif>
	)
	order by name
</cfquery>
<cfif #attributes.obj2# is not '8a' and #attributes.obj2# is not '8b'>
	<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QgettargPPC">
select 	c.*, descr, name
	from monthly_cc c, target_org tor
	where
	c.userid= <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and c.year2= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and c.year2=tor.year2
	and c.initnum=<cfqueryparam value="#attributes.obj2#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">
	and c.target=tor.targid
	and c.section=1
	and mon=<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
	order by name
</cfquery>
<cfelse>
	<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QgettargPPC">
select 	c.*, targmhs as name
	from monthly_cc c, hsc tor
	where
	c.userid= <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and c.year2= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and c.year2=tor.year2
	and c.initnum=<cfqueryparam value="#attributes.obj2#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">
	and c.target=tor.id
	and c.section=1
	and mon=<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
ORDER BY cast(targmhs as varchar)
</cfquery>
</cfif>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="PPC_Qtargchc">
	select
	targid, name
	from target_org tor where
	userid= <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and tor.year2= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and initnum=<cfqueryparam value="#attributes.obj2#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">
	and stratnum=1
	 and
	(tor.targid not in
	(select x.target from monthly_cc x where x.userid= <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and x.year2= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> and x.section=1
	and x.initnum=<cfqueryparam value="#attributes.obj2#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">
	and x.mon=<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">)
	<cfif isDefined("url.target") and url.target EQ "ppc" and isDefined("url.seq")> OR tor.targid=(select distinct target from monthly_cc where monthlyccid = <cfqueryparam value="#url.seq#" cfsqltype="CF_SQL_INTEGER"> )</cfif>
	)
	order by name
</cfquery>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QgettargCLIN">
select 	cc.*,
	targchcid, tor.targid, name, targsite
	from monthly_cc cc, target_org tor
	inner join target_chc c on tor.targid = c.targid
	where
	cc.userid= <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and cc.year2= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and cc.year2=tor.year2
	--and c.initnum='#attributes.obj2#'
	--and cc.target=tor.targid
	and cc.section=2
	and cc.target=c.targchcid
	and mon=<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
	order by name
</cfquery>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="CLIN_Qtargchc">
select
	targchcid, tor.targid, name, targsite
	from target_org tor inner join target_chc c on tor.targid = c.targid where
	userid= <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and tor.year2= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and initnum=<cfqueryparam value="#attributes.obj2#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">
	and stratnum=1
    and c.targid is not null
	 and
	(c.targchcid not in
	(select x.target from monthly_cc x, target_chc xx where x.userid= <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and x.year2= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> and x.section=2
	and x.initnum=<cfqueryparam value="#attributes.obj2#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">
	and x.mon=<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
 )
	<cfif isDefined("url.target") and url.target EQ "clin" and isDefined("url.seq")> OR c.targchcid=(select distinct target from monthly_cc where monthlyccid = <cfqueryparam value="#url.seq#" cfsqltype="CF_SQL_INTEGER"> )</cfif>
	)
	order by name
</cfquery>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QgettargHCPO">
select 	c.*, descr, name
	from monthly_cc c, target_org tor
	where
	c.userid= <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and c.year2= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and c.year2=tor.year2
	and c.initnum=<cfqueryparam value="#attributes.obj2#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">
	and c.target=tor.targid
	and c.section=1
	and mon=<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
	order by name
</cfquery>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="HCPO_Qtargorg">
select
	*
	from target_org tor left join wrkplan_targets t on tor.targnum = t.targetid and tor.year2 = t.year2
	left join counties c on tor.county = c.fips
	where
	userid= <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and tor.year2= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and initnum=<cfqueryparam value="#attributes.obj2#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">
	and stratnum=1
	and
	(tor.targid not in
	(select x.target from monthly_cc x where x.userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and x.year2= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> and x.section=1
	and x.initnum=<cfqueryparam value="#attributes.obj2#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">
	and x.mon=<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">)
	<cfif isDefined("url.target") and url.target EQ "hcpo" and isDefined("url.seq")> OR tor.targid=(select distinct target from monthly_cc where monthlyccid = <cfqueryparam value="#url.seq#" cfsqltype="CF_SQL_INTEGER"> )</cfif>
	)
	order by name
</cfquery>
<cfif isdefined("obj")>
	<cfset session.objval = '#obj#'>
</cfif>
<cfif isdefined("mo")>
	<cfswitch expression="#mo#">
		<cfcase value=1>
			<cfset session.mon = "January">
			<cfset session.monum = 1>
		</cfcase>
		<cfcase value=2>
			<cfset session.mon = "February">
			<cfset session.monum = 2>
		</cfcase>
		<cfcase value=3>
			<cfset session.mon = "March">
			<cfset session.monum = 3>
		</cfcase>
		<cfcase value=4>
			<cfset session.mon = "April">
			<cfset session.monum = 4>
		</cfcase>
		<cfcase value=5>
			<cfset session.mon = "May">
			<cfset session.monum = 5>
		</cfcase>
		<cfcase value=6>
			<cfset session.mon = "June">
			<cfset session.monum = 6>
		</cfcase>
		<cfcase value=7>
			<cfset session.mon = "July">
			<cfset session.monum = 7>
		</cfcase>
		<cfcase value=8>
			<cfset session.mon = "August">
			<cfset session.monum = 8>
		</cfcase>
		<cfcase value=9>
			<cfset session.mon = "September">
			<cfset session.monum = 9>
		</cfcase>
		<cfcase value=10>
			<cfset session.mon = "October">
			<cfset session.monum = 10>
		</cfcase>
		<cfcase value=11>
			<cfset session.mon = "November">
			<cfset session.monum = 11>
		</cfcase>
		<cfcase value=12>
			<cfset session.mon = "December">
			<cfset session.monum = 12>
		</cfcase>
	</cfswitch>
</cfif>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="Qmediaorg">
select
	*
	from monthly_media tor
	where
	tor.userid= <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and tor.year2= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and tor.initnum=<cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">
	and tor.mon=<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
</cfquery>
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="mon">
select
	*
	from monthly
	where
	userid= <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and year2= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and mon=<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
	and initnum=<cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">
</cfquery>
<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="getobj">
	select
o.objective,
o.id as objnum,prognum,id,
initiative,cc,aa,cp,yp
from objectives as o
where
o.year2= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"> and o.id = '#session.objval#'
</cfquery>
<cfif isdefined("form.dofunction") and form.dofunction is not ''
	or isdefined("form.del_box2") or (isDefined("form.objval") and (form.objval EQ '2d' or form.objval EQ '2e'))>
	<cfif session.objval EQ '' and isDefined ("url.objval")>
		<cfset session.objval = url.objval>
	</cfif>
	<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="mon">
select
	*
	from monthly
	where
	userid= <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and year2= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and mon=<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
	and initnum=<cfqueryparam value="#attributes.obj2#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">
</cfquery>
	<cfif mon.recordcount EQ 0>
		<cfset entdt = #createodbcdate(now())#>
		<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QInsMO">
insert into monthly
(userid, entdt,year2, mon, initnum,summary,barriers,steps, disparities)
values
(<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">, #entdt#,<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">, <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">, <cfqueryparam value="#attributes.obj2#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">,
<cfif isdefined("form.summary")><cfqueryparam value="#form.summary#" cfsqltype="CF_SQL_VARCHAR" maxlength="4000"><cfelse>NULL</cfif>,
<cfif isdefined("form.barriers")><cfqueryparam value="#form.barriers#" cfsqltype="CF_SQL_VARCHAR" maxlength="1000"><cfelse>NULL</cfif>,
<cfif isdefined("form.steps")><cfqueryparam value="#form.steps#" cfsqltype="CF_SQL_VARCHAR" maxlength="1000"><cfelse>NULL</cfif>,
<cfif isdefined("form.disparities")><cfqueryparam value="#form.disparities#" cfsqltype="CF_SQL_VARCHAR" maxlength="2000"><cfelse>NULL</cfif>)
</cfquery>
	<cfelse>


		<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QInsWG">
		update monthly set
	userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	 ,barriers = <cfqueryparam value="#form.barriers#" cfsqltype="CF_SQL_VARCHAR" maxlength="2050">
	,summary = <cfqueryparam value="#form.summary#" cfsqltype="CF_SQL_VARCHAR" maxlength="4000">
	,steps = <cfqueryparam value="#form.steps#" cfsqltype="CF_SQL_VARCHAR" maxlength="2000">
	,disparities = <cfqueryparam value="#form.disparities#" cfsqltype="CF_SQL_VARCHAR" maxlength="1400">
	where userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
	and initnum = <cfqueryparam value="#attributes.obj2#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">
	</cfquery>
	</cfif>
</cfif>
<style>
	.box { font-family: verdana, helvetica, sans-serif; font-size: 11px; color: #333366; background-color: #EEEEEE; border: solid 1px #CCCC99; list-style:inherit; border-collapse: collapse; } .box2 { font-family: verdana, helvetica, sans-serif; font-size: 11px; color: #003366; background-color: #FFF8DC; border: none; list-style:inherit; border-collapse: collapse; }
</style>
<SCRIPT LANGUAGE="JavaScript" SRC="../scripts/cfform.js"> </SCRIPT>
<script type="text/javascript" language="JavaScript">
function countitAny(what,when){
//Character count script- by javascriptkit.com
//Visit JavaScript Kit (http://javascriptkit.com) for script
//Credit must stay intact for use
formcontent=document.getElementById(what).value
document.getElementById(when).value=formcontent.length
}
 function countit(what){
//Character count script- by javascriptkit.com
//Visit JavaScript Kit (http://javascriptkit.com) for script
//Credit must stay intact for use
formcontent=what.form.summary.value
what.form.summdisplaycount.value=formcontent.length
}
 function countit2(what){
formcontent=what.form.barriers.value
what.form.barrdisplaycount.value=formcontent.length
}
 function countit3(what){
formcontent=what.form.steps.value
what.form.stepdisplaycount.value=formcontent.length
}
 function countit4(what){
formcontent=what.form.disparities.value
what.form.dispdisplaycount.value=formcontent.length
}
function checkADV(){
if(document.wrk.adv_target.selectedIndex == 0){
alert('');
return false;
}
if(document.wrk.adv_adcom.checked==false && document.wrk.adv_edIssues.checked==false && document.wrk.adv_edPol.checked == false && document.wrk.adv_comPol.checked==false && document.wrk.adv_polTime.checked==false && document.wrk.adv_polAdopt.checked==false){
alert('Please select a category which best describes the nature of your conversation');
return false;
}
if(document.wrk.adv_notes.value.replace(/^\s+|\s+$/g, '') == ""){
alert('Please describe your interaction with this target');
return false;
}
document.wrk.action="month.cfm#adv";
return true;
}

function checkPP(){
if(document.wrk.PP_target.selectedIndex == 0){
alert('Please make sure to select a Target Name');
return false;
}

if(document.wrk.pp_wtdtPol.checked == false){
alert('Please make sure to check "Written Tobacco Dependence Treatment policy within parent organization policy."');
return false;
}

if (!(

(document.wrk.pp_ask.checked == true && document.wrk.pp_ask.disabled==false)||
(document.wrk.pp_assess.checked == true && document.wrk.pp_assess.disabled==false)||
(document.wrk.pp_advise.checked == true && document.wrk.pp_advise.disabled==false)||
(document.wrk.pp_assist.checked == true && document.wrk.pp_assist.disabled==false)||
(document.wrk.pp_arrange.checked == true && document.wrk.pp_arrange.disabled==false)||
(document.wrk.pp_referral.checked == true && document.wrk.pp_referral.disabled==false)||
(document.wrk.pp_train.checked == true && document.wrk.pp_train.disabled==false)||
(document.wrk.pp_hcp.checked == true && document.wrk.pp_hcp.disabled==false)
)){
alert('Please select at least one "select all that apply" checkbox.');
return false;
}

document.wrk.action="month.cfm#ppc";
return true;
}

function checkCHC(){
if(document.wrk.clin_target.selectedIndex == 0){
alert('Please make sure to select a Target Name');
return false;
}

if (!(
(document.wrk.clin_p.checked == true )||
(document.wrk.clin_w.checked == true )||
(document.wrk.clin_other.checked == true ))){
alert('Please make sure to select at least one checkbox from Clinical policy/procedures, Clinic Workflow protocol, or other');
return false;
}
else if (!(
(document.wrk.clin_ask.checked == true)||
(document.wrk.clin_advise.checked == true)||
(document.wrk.clin_assess.checked == true)||
(document.wrk.clin_assist.checked == true)||
(document.wrk.clin_arrange.checked == true)||
(document.wrk.clin_refer.checked == true))){
alert('Please select at least one "select all that apply" checkbox.');
return false;
}
if(document.wrk.clin_sysImp.checked == true && (!((document.wrk.clin_emr.checked == true)||(document.wrk.clin_other2.checked == true)))){
alert('Please indicate which System to implement and document tobacco dependence treatment policy/Standards of Care.');
return false;
}

if (!(
(document.wrk.clin_p.checked == true && document.wrk.clin_p.disabled==false)||
(document.wrk.clin_w.checked == true && document.wrk.clin_w.disabled==false)||
(document.wrk.clin_other.checked == true && document.wrk.clin_other.disabled==false)||
(document.wrk.clin_ask.checked == true && document.wrk.clin_ask.disabled==false)||
(document.wrk.clin_advise.checked == true && document.wrk.clin_advise.disabled==false)||
(document.wrk.clin_assess.checked == true && document.wrk.clin_assess.disabled==false)||
(document.wrk.clin_assist.checked == true && document.wrk.clin_assist.disabled==false)||
(document.wrk.clin_arrange.checked == true && document.wrk.clin_arrange.disabled==false)||
(document.wrk.clin_refer.checked == true && document.wrk.clin_refer.disabled==false)||
(document.wrk.clin_sysImp.checked == true && document.wrk.clin_sysImp.disabled==false)||
(document.wrk.clin_emr.checked == true && document.wrk.clin_emr.disabled==false)||
(document.wrk.clin_other2.checked == true && document.wrk.clin_other2.disabled==false)
)){
alert('Please select at least one "select all that apply" checkbox.');
return false;
}
if(document.wrk.clin_p.checked == true && document.wrk.clin_p.disabled ==false && document.wrk.clin_descr.value.replace(/^\s+|\s+$/g, '') == ""){
alert('Please enter a Policy/procedure description.');
return false;
}
if(document.wrk.clin_w.checked == true && document.wrk.clin_w.disabled ==false && document.wrk.clin_descr2.value.replace(/^\s+|\s+$/g, '') == ""){
alert('Please enter a Protocol description.');
return false;
}
if(document.wrk.clin_other.checked == true && document.wrk.clin_other.disabled ==false && document.wrk.clin_descr3.value.replace(/^\s+|\s+$/g, '') == ""){
alert('Please enter a description for Other - please specify.');
return false;
}
if(document.wrk.clin_other2.checked == true && document.wrk.clin_other2.disabled ==false && document.wrk.clin_descr4.value.replace(/^\s+|\s+$/g, '') == ""){
alert('Please enter a description for Other - please specify.');
return false;
}

document.wrk.action="month.cfm#chc";
return true;
}

function checkED(){
if(document.wrk.commed_target.selectedIndex == 0){
alert('Please make sure to select a Target Name');
return false;
}
if(document.wrk.comm_staff.checked==false && document.wrk.comm_train.checked==false && document.wrk.comm_ta.checked == false && document.wrk.comm_nrt.checked==false && ((document.wrk.comm_tfo && document.wrk.comm_tfo.checked==false)|| !(document.wrk.comm_tfo) )){
alert('Please select a category which best describes the focus of your Community Ed.');
return false;
}
if(document.wrk.comm_descr.value.replace(/^\s+|\s+$/g, '') == ""){
alert('Please describe the community education.');
return false;
}
document.wrk.action="month.cfm#com";
return true;
}

function checkHCP(){
if(document.wrk.hcpo_target.selectedIndex == 0){
alert('Please make sure to select a Target Name');
return false;
}
if (!(
(document.wrk.hcpo_orgPol.checked == true )||
(document.wrk.hcpo_clinP.checked == true )||
(document.wrk.hcpo_clinW.checked == true )||
(document.wrk.hcpo_EMR.checked == true )||
(document.wrk.hcpo_other.checked == true ))){
alert('Please make sure to select at least one checkbox to indicate the Tobacco Dependence Treatment Systems Change.');
return false;
}
else if (!(
(document.wrk.hcpo_ask.checked == true)||
(document.wrk.hcpo_advise.checked == true)||
(document.wrk.hcpo_assess.checked == true)||
(document.wrk.hcpo_assist.checked == true)||

(document.wrk.hcpo_refer.checked == true)||
(document.wrk.hcpo_train.checked == true)||
(document.wrk.hcpo_hcp.checked == true))){
alert('Please select at least one "select all that apply" checkbox.');
return false;
}

if (!(
(document.wrk.hcpo_wtdtPol.checked == true && document.wrk.hcpo_wtdtPol.disabled==false)||
(document.wrk.hcpo_orgPol.checked == true && document.wrk.hcpo_orgPol.disabled==false)||
(document.wrk.hcpo_clinP.checked == true && document.wrk.hcpo_clinP.disabled==false)||
(document.wrk.hcpo_clinW.checked == true && document.wrk.hcpo_clinW.disabled==false)||
(document.wrk.hcpo_EMR.checked == true && document.wrk.hcpo_EMR.disabled==false)||
(document.wrk.hcpo_other.checked == true && document.wrk.hcpo_other.disabled==false)||
(document.wrk.hcpo_ask.checked == true && document.wrk.hcpo_ask.disabled==false)||
(document.wrk.hcpo_advise.checked == true && document.wrk.hcpo_advise.disabled==false)||
(document.wrk.hcpo_assess.checked == true && document.wrk.hcpo_assess.disabled==false)||
(document.wrk.hcpo_assist.checked == true && document.wrk.hcpo_assist.disabled==false)||
(document.wrk.hcpo_refer.checked == true && document.wrk.hcpo_refer.disabled==false)||
(document.wrk.hcpo_train.checked == true && document.wrk.hcpo_train.disabled==false)||
(document.wrk.hcpo_hcp.checked == true && document.wrk.hcpo_hcp.disabled==false)
)){
alert('Please select at least one "select all that apply" checkbox.');
return false;
}
if(document.wrk.hcpo_other.checked == true && document.wrk.hcpo_other.disabled ==false && document.wrk.hcpo_othertxt.value.replace(/^\s+|\s+$/g, '') == ""){
alert('Please enter a description of "Other."');
return false;

}
document.wrk.action="month.cfm#hcpo";
return true;
}

function checkCOMMMOB(){
if(document.wrk.mob_target.selectedIndex == 0){
alert('Please make sure to select a Target Name');
return false;
}
<cfif #session.objval# is '8a' or #session.objval# is '8b'>
if(document.wrk.mob_group.value == ''){
alert('Please make sure to select a Target Org');
return false;
}

</cfif>
if(document.wrk.mob_descr.value.replace(/^\s+|\s+$/g, '') == ''){
alert('Please describe how this target helped advance a Health Systems Change outcome this month.');
return false;
}

document.wrk.action="month.cfm#hcpo";
return true;
}

function checkCC(){
if(document.wrk.summary && document.wrk.summary.value.replace(/^\s+|\s+$/g, '') == ""){
alert('Please enter a summary of activities');
return false;
}
<!--- if(document.wrk.barriers && document.wrk.barriers.value == ""){
alert('Please enter barriers encountered this month');
return false;
}
if(document.wrk.steps && document.wrk.steps.value == ""){
alert('Please enter next steps');
return false;
} --->
return true;
}

function checkMGG(){
add('addMGG');
document.wrk.action="month.cfm#targ";
}

function checkDCS(){

if(document.wrk.dcs_loc.value.replace(/^\s+|\s+$/g, '') == ''){
alert('Please enter a location for Direct Cessation Services');
return false;
}

if(document.wrk.dcs_numses.value.replace(/^\s+|\s+$/g, '') == '' || isNaN(document.wrk.dcs_numses.value) == true){
alert('Please enter a numeric value for number of sessions (no commas)');
return false;
}
	if(document.wrk.dcs_descr && document.wrk.dcs_descr.value.replace(/^\s+|\s+$/g, '') == ""){
alert('Please enter a description for Direct Cessation Services');
return false;
}
add('addDCS');
document.wrk.action="month.cfm#dcs";
return true;
}

function checkMOB(){
add('addMOB');
document.wrk.action="month.cfm#mob";
}

function add(actvalue){
document.wrk.dofunction.value=actvalue;
return true;
}

function checkDG(){
<!---  document.wrk.strat.value = 4; --->
var medtype = document.wrk.mediatype.selectedIndex
var medchnnl = document.wrk.mediachannel.value.replace(/^\s+|\s+$/g, '')
var spotit = document.wrk.spottitle.value.replace(/^\s+|\s+$/g, '')
var num = document.wrk.number.value.replace(/^\s+|\s+$/g, '')
var cost = document.wrk.cost.value.replace(/^\s+|\s+$/g, '')

if (medtype == 0)

{
  alert('Please select a media type.');
  return false;
}
if (medchnnl == '')

{
  alert('Please enter a media channel.');
  return false;
}
if (spotit == '')

{
  alert('Please enter a spot title.');
  return false;
}
if (num == '')

{
  alert('Please enter a number for number run/aired/printed.');
  return false;
}
  if (isNaN(document.wrk.number.value) == true)
{
  alert('Number must be numeric.');
  return false;
}
if (cost == '')

{
  alert('Please enter cost.');
  return false;
}

  if (isNaN(document.wrk.cost.value) == true)
{
  alert('Cost must be numeric.');
  return false;
}
add('addDG');
document.wrk.action="month.cfm#pm";
}

function ValidateMHSID(){if(document.wrk.id.selectedIndex == 0){
alert('Please make sure to select a Target Medical Health Systems name');
return false; 	}

}
function checkHUD(){
hudtarg = document.wrk.HUD_target.value
units = document.wrk.units.value
dt = document.wrk.dt.value
notes = document.wrk.HUD_notes.value
if (hudtarg == '')
{alert('Please select a target');
return false;
}
	if (hudtarg != ''){
if (units == '')
{
  alert('Please enter number of HUD units');
  return false;
}
if (isNaN(document.wrk.units.value) == true)
{
alert('Number of HUD units must be numeric');
  return false;
}
if (dt == '')
{
  alert('Please enter implementation date');
  return false;
}
if (notes == '')
{
  alert('Please enter description of activity');
  return false;
}
	}
	}

</SCRIPT>
<!--- <cfif session.fy LT 2007 and session.fy GT 1920>
	<cfinclude template="cat_annual_goal.cfm">
<cfelse>
	<cfif  session.fy GT session.def_fy and  session.nextyr NEQ 1>
	<cflocation addtoken="yes" url="noFuture.cfm">
	</cfif>  --->
<!--- <cfput>#session.objnum#</cfput><cfabort> --->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>
			CAT
		</title>
	<body>
		<cfinclude template="CATstruct.cfm">
		<script language="JavaScript" src="../spellchecker/spell.js"></script>
		<cfif isdefined("form.return") and #form.return# is 'Save and return to Monthly Reporting'>
			<cflocation url="monthrep.cfm">
		</cfif>
		<cfform name="wrk" action="">
			<!--- set hidden form fields --->
			<cfif isDefined("url.target")>
				<cfif url.target EQ "media">
					<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QgettargXXXS">
	select 	*
	from monthly_media
	where
	userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and year2= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and initnum=<cfqueryparam value="#attributes.obj2#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">
	and monthlymediaid = <cfqueryparam value="#url.seq#" cfsqltype="CF_SQL_INTEGER">
</cfquery>
					<input type="hidden" name="targid03" value="<cfoutput>#url.seq#</cfoutput>">
				<cfelseif url.target EQ "dcs">
					<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QgettargDCS2">
	select 	*
	from monthly_dcs
	where
	userid= <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and year2= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and initnum=<cfqueryparam value="#attributes.obj2#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">
	and monthlydcsid = <cfqueryparam value="#url.seq#" cfsqltype="CF_SQL_INTEGER">
</cfquery>
					<input type="hidden" name="targid04" value="<cfoutput>#url.seq#</cfoutput>">
				<cfelseif url.target EQ "mob">
					<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QgettargMOB2">
	select 	*
	from monthly_commmob
	where
	userid= <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and year2= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and initnum=<cfqueryparam value="#attributes.obj2#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">
	and monthlycommmobid = <cfqueryparam value="#url.seq#" cfsqltype="CF_SQL_INTEGER">
</cfquery>
					<input type="hidden" name="targid05" value="<cfoutput>#url.seq#</cfoutput>">
				<cfelseif url.target EQ "comm">
					<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QgettargCOM2">
	<cfif attributes.obj2 EQ "1A">
	select 	cc.*, targchcid as target2
	from monthly_comm cc,  target_chc c
	where
	userid= <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and year2= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and initnum=<cfqueryparam value="#attributes.obj2#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">
	and monthlycommid = <cfqueryparam value="#url.seq#" cfsqltype="CF_SQL_INTEGER">
	and cc.target=c.targchcid
<cfelse>
	select 	*
	from monthly_comm
	where
	userid= <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and year2= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and initnum=<cfqueryparam value="#attributes.obj2#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">
	and monthlycommid = <cfqueryparam value="#url.seq#" cfsqltype="CF_SQL_INTEGER">
	</cfif>
</cfquery>
					<input type="hidden" name="targid06" value="<cfoutput>#url.seq#</cfoutput>">
				<cfelseif url.target EQ "adv">
					<cfif #attributes.obj2# is '8a' or #attributes.obj2# is '8b'>
						<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QgettargAdv2">
		SELECT c.*, tor.targmhs AS name
FROM  dbo.monthly_org AS c INNER JOIN
               dbo.HSC AS tor ON (c.year2 = tor.year2 or tor.year2 >= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">-#session.yrsub#) AND c.org = tor.id
WHERE (c.userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">) AND (c.year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">) AND (c.initnum = <cfqueryparam value="#attributes.obj2#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">) AND (c.mon = '#session.monum#') and monthlyorgid = <cfqueryparam value="#url.seq#" cfsqltype="CF_SQL_INTEGER">
ORDER BY name
</cfquery>
					<cfelse>
						<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QgettargADV2">
	select 	*
	from monthly_org
	where
	userid= <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and year2= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and initnum=<cfqueryparam value="#attributes.obj2#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">
	and monthlyorgid = <cfqueryparam value="#url.seq#" cfsqltype="CF_SQL_INTEGER">
</cfquery>
					</cfif>
					<input type="hidden" name="targid07" value="<cfoutput>#url.seq#</cfoutput>">
				<cfelseif url.target EQ "ppc">
					<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QgettargPPC2">
	select 	*
	from monthly_cc
	where
	userid= <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and year2= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and initnum=<cfqueryparam value="#attributes.obj2#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">
	and [section]=1
	and monthlyccid = <cfqueryparam value="#url.seq#" cfsqltype="CF_SQL_INTEGER">
</cfquery>
					<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="">
	select
	case isNull(sum(isnull(c.wtdtpol,0)),0) when 0 then 0 else 1 end as wtdtpol,
	case isNull(sum(isnull(c.ask,0)),0) when 0 then 0 else 1 end as ask,
	case isNull(sum(isnull(c.advise_ident,0)),0) when 0 then 0 else 1 end as advise_ident,
	case isNull(sum(isnull(c.assess_ident,0)),0) when 0 then 0 else 1 end as assess_ident,
	case isNull(sum(isnull(c.assist,0)),0) when 0 then 0 else 1 end as assist,
	case isNull(sum(isnull(c.arrange,0)),0) when 0 then 0 else 1 end as arrange,
	case isNull(sum(isnull(c.referral,0)),0) when 0 then 0 else 1 end as referral,
	case isNull(sum(isnull(c.train,0)),0) when 0 then 0 else 1 end as train,
	case isNull(sum(isnull(c.definedHCP,0)),0) when 0 then 0 else 1 end as definedHCP
	from monthly_cc c, monthly_cc c2
	where c2.target=c.target
	and c.mon in (
	select m.mon_num from months m, months mm
	where m.year2= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and m.year2=mm.year2
	and mm.mon_num = #session.monum#
	and m.rank < mm.rank
	)
	and
	c2.userid= <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and c2.userid=c.userid
	and c2.year2= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and c2.year2=c.year2
	and c2.initnum=<cfqueryparam value="#attributes.obj2#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">
	and c2.initnum=c.initnum
	and c2.[section]=1 and c2.[section] = c.[section]
	and c2.monthlyccid = <cfqueryparam value="#url.seq#" cfsqltype="CF_SQL_INTEGER">	and c2.target=c.target
</cfquery>
					<input type="hidden" name="targid08" value="<cfoutput>#url.seq#</cfoutput>">
				<cfelseif url.target EQ "ppc2">
					<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QgettargPPC2x">
	select
	*
	from hsc_mon c
	where c.mon in (
	select m.mon_num from months m, months mm
	where m.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and m.year2=mm.year2
	and mm.mon_num = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
	and m.rank < mm.rank
	)
	and
	c.userid= <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and c.year2= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and c.obj=<cfqueryparam value="#attributes.obj2#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">
	<!--- --and c2.monthlyccid = #url.seq#	and c2.target=c.target --->
	and c.targmhs= <cfqueryparam value="#form.pp_target#" cfsqltype="CF_SQL_INTEGER">
</cfquery>
				<cfelseif url.target EQ "clin">
					<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QgettargCLIN2">
	select 	cc.*, targchcid as target2
	from monthly_cc cc,  target_chc c
	where
	cc.userid= <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and cc.year2= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and initnum=<cfqueryparam value="#attributes.obj2#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">
	and [section]=2
	and cc.monthlyccid = <cfqueryparam value="#url.seq#" cfsqltype="CF_SQL_INTEGER">
	and cc.target=c.targchcid
</cfquery>
					<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QgettargCLIN2x">
	select
	case isNull(sum(isnull(c.clinp,0)),0) when 0 then 0 else 1 end as clinp,
	case isNull(sum(isnull(c.clinw,0)),0) when 0 then 0 else 1 end as clinw,
	case isNull(sum(isnull(c.clinother,0)),0) when 0 then 0 else 1 end as clinother,
	case isNull(sum(isnull(c.ask,0)),0) when 0 then 0 else 1 end as ask,
	case isNull(sum(isnull(c.advise_ident,0)),0) when 0 then 0 else 1 end as advise_ident,
	case isNull(sum(isnull(c.assess_ident,0)),0) when 0 then 0 else 1 end as assess_ident,
	case isNull(sum(isnull(c.assist,0)),0) when 0 then 0 else 1 end as assist,
	case isNull(sum(isnull(c.arrange,0)),0) when 0 then 0 else 1 end as arrange,
	case isNull(sum(isnull(c.referral,0)),0) when 0 then 0 else 1 end as referral,
	--case isNull(sum(isnull(c.train,0)),0) when 0 then 0 else 1 end as train,
	--case isNull(sum(isnull(c.definedHCP,0)),0) when 0 then 0 else 1 end as definedHCP
	case isNull(sum(isnull(c.sysimp,0)),0) when 0 then 0 else 1 end as sysimp,
	case isNull(sum(isnull(c.emr,0)),0) when 0 then 0 else 1 end as emr,
	case isNull(sum(isnull(c.other,0)),0) when 0 then 0 else 1 end as other
	from monthly_cc c, monthly_cc c2
	where c2.target=c.target
	and c.mon in (
	select m.mon_num from months m, months mm
	where m.year2= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and m.year2=mm.year2
	and mm.mon_num = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
	and m.rank < mm.rank
	)
	and
	c2.userid= <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and c2.userid=c.userid
	and c2.year2= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and c2.year2=c.year2
	and c2.initnum=<cfqueryparam value="#attributes.obj2#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">
	and c2.initnum=c.initnum
	and c2.[section]=2 and c2.[section] = c.[section]
	and c2.monthlyccid = <cfqueryparam value="#url.seq#" cfsqltype="CF_SQL_INTEGER">	and c2.target=c.target
</cfquery>
					<input type="hidden" name="targid09" value="<cfoutput>#url.seq#</cfoutput>">
				<cfelseif url.target EQ "clin2" and form.clin_target NEQ "">
					<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QgettargCLIN2x">
	select
	case isNull(sum(isnull(c.clinp,0)),0) when 0 then 0 else 1 end as clinp,
	case isNull(sum(isnull(c.clinw,0)),0) when 0 then 0 else 1 end as clinw,
	case isNull(sum(isnull(c.clinother,0)),0) when 0 then 0 else 1 end as clinother,
	case isNull(sum(isnull(c.ask,0)),0) when 0 then 0 else 1 end as ask,
	case isNull(sum(isnull(c.advise_ident,0)),0) when 0 then 0 else 1 end as advise_ident,
	case isNull(sum(isnull(c.assess_ident,0)),0) when 0 then 0 else 1 end as assess_ident,
	case isNull(sum(isnull(c.assist,0)),0) when 0 then 0 else 1 end as assist,
	case isNull(sum(isnull(c.arrange,0)),0) when 0 then 0 else 1 end as arrange,
	case isNull(sum(isnull(c.referral,0)),0) when 0 then 0 else 1 end as referral,
	--case isNull(sum(isnull(c.train,0)),0) when 0 then 0 else 1 end as train,
	--case isNull(sum(isnull(c.definedHCP,0)),0) when 0 then 0 else 1 end as definedHCP
	case isNull(sum(isnull(c.sysimp,0)),0) when 0 then 0 else 1 end as sysimp,
	case isNull(sum(isnull(c.emr,0)),0) when 0 then 0 else 1 end as emr,
	case isNull(sum(isnull(c.other,0)),0) when 0 then 0 else 1 end as other
	from monthly_cc c, monthly_cc c2
	where c2.target=c.target
	and c.mon in (
	select m.mon_num from months m, months mm
	where m.year2= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and m.year2=mm.year2
	and mm.mon_num = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
	and m.rank < mm.rank
	)
	and
	c2.userid= <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and c2.userid=c.userid
	and c2.year2= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and c2.year2=c.year2
	and c2.initnum=<cfqueryparam value="#attributes.obj2#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">
	and c2.initnum=c.initnum
	and c2.[section]=2 and c2.[section] = c.[section]
	and c.target= <cfqueryparam value="#form.clin_target#" cfsqltype="CF_SQL_INTEGER">
</cfquery>
				<cfelseif url.target EQ "hcpo">
					<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QgettargHCPO2">
	select 	*
	from monthly_cc
	where
	userid= <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and year2= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and initnum=<cfqueryparam value="#attributes.obj2#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">
	and [section]=1
	and monthlyccid = <cfqueryparam value="#url.seq#" cfsqltype="CF_SQL_INTEGER">
</cfquery>
					<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QgettargHCPO2x">
	select
	case isNull(sum(isnull(c.wtdtpol,0)),0) when 0 then 0 else 1 end as wtdtpol,
	case isNull(sum(isnull(c.orgpol,0)),0) when 0 then 0 else 1 end as orgpol,
	case isNull(sum(isnull(c.clinP,0)),0) when 0 then 0 else 1 end as clinP,
	case isNull(sum(isnull(c.clinW,0)),0) when 0 then 0 else 1 end as clinW,
	case isNull(sum(isnull(c.emr,0)),0) when 0 then 0 else 1 end as emr,
	case isNull(sum(isnull(c.other,0)),0) when 0 then 0 else 1 end as other,
	case isNull(sum(isnull(c.ask,0)),0) when 0 then 0 else 1 end as ask,
	case isNull(sum(isnull(c.advise_ident,0)),0) when 0 then 0 else 1 end as advise_ident,
	case isNull(sum(isnull(c.assess_ident,0)),0) when 0 then 0 else 1 end as assess_ident,
	case isNull(sum(isnull(c.assist,0)),0) when 0 then 0 else 1 end as assist,
	case isNull(sum(isnull(c.arrange,0)),0) when 0 then 0 else 1 end as arrange,
	case isNull(sum(isnull(c.referral,0)),0) when 0 then 0 else 1 end as referral,
	case isNull(sum(isnull(c.train,0)),0) when 0 then 0 else 1 end as train
	 ,
	case isNull(sum(isnull(c.definedHCP,0)),0) when 0 then 0 else 1 end as definedHCP
	from monthly_cc c, monthly_cc c2
	where c2.target=c.target
	and c.mon in (
	select m.mon_num from months m, months mm
	where m.year2= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and m.year2=mm.year2
	and mm.mon_num = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
	and m.rank < mm.rank
	)
	and
	c2.userid= <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and c2.userid=c.userid
	and c2.year2= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and c2.year2=c.year2
	and c2.initnum=<cfqueryparam value="#attributes.obj2#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">
	and c2.initnum=c.initnum
	and c2.[section]=1 and c2.[section] = c.[section]
	and c2.monthlyccid = <cfqueryparam value="#url.seq#" cfsqltype="CF_SQL_INTEGER">	and c2.target=c.target
</cfquery>
					<input type="hidden" name="targid10" value="<cfoutput>#url.seq#</cfoutput>">
				<cfelseif url.target EQ "hcpo2">
					<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QgettargHCPO2x">
	select
	case isNull(sum(isnull(c.wtdtpol,0)),0) when 0 then 0 else 1 end as wtdtpol,
	case isNull(sum(isnull(c.orgpol,0)),0) when 0 then 0 else 1 end as orgpol,
	case isNull(sum(isnull(c.clinP,0)),0) when 0 then 0 else 1 end as clinP,
	case isNull(sum(isnull(c.clinW,0)),0) when 0 then 0 else 1 end as clinW,
	case isNull(sum(isnull(c.emr,0)),0) when 0 then 0 else 1 end as emr,
	case isNull(sum(isnull(c.other,0)),0) when 0 then 0 else 1 end as other,
	case isNull(sum(isnull(c.ask,0)),0) when 0 then 0 else 1 end as ask,
	case isNull(sum(isnull(c.advise_ident,0)),0) when 0 then 0 else 1 end as advise_ident,
	case isNull(sum(isnull(c.assess_ident,0)),0) when 0 then 0 else 1 end as assess_ident,
	case isNull(sum(isnull(c.assist,0)),0) when 0 then 0 else 1 end as assist,
	case isNull(sum(isnull(c.arrange,0)),0) when 0 then 0 else 1 end as arrange,
	case isNull(sum(isnull(c.referral,0)),0) when 0 then 0 else 1 end as referral,
	case isNull(sum(isnull(c.train,0)),0) when 0 then 0 else 1 end as train,
	case isNull(sum(isnull(c.definedHCP,0)),0) when 0 then 0 else 1 end as definedHCP
	from monthly_cc c, monthly_cc c2
	where c2.target=c.target
	and c.mon in (
	select m.mon_num from months m, months mm
	where m.year2= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and m.year2=mm.year2
	and mm.mon_num = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
	and m.rank < mm.rank
	)
	and
	c2.userid= <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and c2.userid=c.userid
	and c2.year2= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and c2.year2=c.year2
	and c2.initnum=<cfqueryparam value="#attributes.obj2#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">
	and c2.initnum=c.initnum
	and c2.[section]=1 and c2.[section] = c.[section]
	<!--- --and c2.monthlyccid = #url.seq#	and c2.target=c.target --->
	and c.target= <cfqueryparam value="#form.hcpo_target#" cfsqltype="CF_SQL_INTEGER">
</cfquery>
				</cfif>
			</cfif>
			<tr>
				<td>
					<table class="boxs" width=775>
						<tr>
							<cfoutput>
								<td align="left">
									<h3>
									#getobj.initiative# Monthly Report for #session.mon#</h4>
								</td>
							</cfoutput>
						</tr>
						<cfif isdefined("session.objval") and #session.objval# is not '6B' and #session.objval# is not '2d'  and #session.objval# is not '1H'>
						</cfif>
					</table>
				</td>
			</tr>
			<cfif #session.objval# is not '1H' AND #session.objval# is not '8C'>
				<tr>
					<td>
						<table class="boxs">
							<tr>
								<td height=10>
								</td>
							</tr>
							<th align="left">
								SMART outcomes:
							</th>
							</tr>
							<tr>
								<td width=775>
									<input type="hidden" name="SO" value=1>
									<cflock
										timeout = "25"
										scope = "Application"
										type = "exclusive ">
										<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="so">
	select s.sonum, s.sotext_mon, isnull(so1,' ') as so1,isnull(so2,' ') as so2
	from smartoutcome s left outer join smartoutcomes so
	on s.initnum = so.initnum and s.sonum = so.sonum
	and s.year2 = so.year2
	and userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"> and so.year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	where
	s.initnum = <cfqueryparam value="#attributes.obj2#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">
	and modality  = <cfqueryparam value="#session.modality#" cfsqltype="CF_SQL_INTEGER">
	and s.year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	order by s.sonum
</cfquery>
										<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="sout">
	select *
	from wrkplan_outcome
	where
	userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and initnum = <cfqueryparam value="#attributes.obj2#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">
	and year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
</cfquery>
										<cfparam name="numPOSSCO" default="0">
										<cfloop query="so">
											<cfset txt = #Replace("#so.sotext_mon#","''","#so.so1#","ONE")#>
											<cfset txt2 = #Replace("#txt#","''","#so.so2#","ONE")#>
											<cffile action="write"
												file="\\pubfile01\nytobaccomx\htdocs\prod\helpme2.txt"
												output="#txt2# " addnewline="yes">
											<cfinclude template="helpme2.txt">
										</cfloop>
									</cflock>
									<cfoutput>
										<p>
											<cfif sout.recordcount is not 0>
												<strong>
													Additional outcomes:
												</strong>
												<br>
												<cfloop query="sout">
													#sout.outcometxt#
													<br>
												</cfloop>
											</cfif>
									</cfoutput>
						</TABLE>
					</TD>
				</TR>
			</cfif>


			<cfif session.fy GT 2017>
<cfif isDefined("url.target") and URL.TARGET EQ "hud">
<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="Qgethud">
select
*
from HUD h left join pha p on h.hud_target = p.phaid
where hud_target = <cfqueryparam value="#url.seq2#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
and
userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
and year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
and mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">

</cfquery>
<cfif Qgethud.recordcount NEQ 0>
	<cfset hud_target=#qgethud.hud_target#>
	<cfset hud_notes=#qgethud.hud_notes#>
	<cfset hud_units = #qgethud.units#>
	
</cfif>
</cfif>

		<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QPHAlist">

<!---				select
  distinct phaid, name
  --c.userid, c.countylist, p.*
  from pha p, contact c where
  c.countylist like '%' + p.county + '%'
	and userid= <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
  order by 2
 --->

  select distinct phaid, name from
(
select
  distinct phaid, name,
  ROW_NUMBER() OVER(PARTITION BY name, unit_count_hud ORDER BY [phaid] DESC) AS RowNumber
  from pha p, contact c where
  c.countylist like '%' + p.county + '%'
and userid= <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
) as a
where rownumber = 1
order by 2
</cfquery>

	<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="Qhud">
				select hud_target,seq,name,phaid,hud_notes
				from
				 HUD h inner join pha p on h.hud_target = p.phaid
where
userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
and year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
and mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
</cfquery>
<cfif #session.objval# is '8a'>
<cfoutput>
	<tr>
					<td align="left" width="800">
						<a name="hud">
						</a><br><h6>Fully HUD-funded Properties</td></tr>
						<table class="boxy" width=800>
							<tr>
								<th width="250">
									Target Name
								</th>
								<th width="150">
									## of Units
								</th>
								<th colspan="2">
									Description of Activity
								</th>
							</tr>
							<tr>
								<td>
									<select name="HUD_target">
									<option value="">
										Please select
									</option>
										<cfoutput>
										<cfloop query="QPHAlist"> <!--- #id#  --->

										<option value="#phaid#"
										<cfif isdefined("url.seq2") and isdefined("url.target") and url.target is 'hud'>
										<cfif url.seq2 eq #phaid#>
										selected
										</cfif></cfif>
											>
											#name#
										</option>
									</cfloop>
									</cfoutput>
									</select>
								</td>
								<td align="center">
								<input type="text" name="units" size="3"  <cfif isDefined("hud_units") and isdefined("url.target") and url.target is 'hud'> value = "#hud_units#"</cfif>>
								</td>	
								<td colspan=2><cfoutput>
									<textarea name="HUD_notes" id="HUD_notes" cols=55 rows=4  onkeyup="countitAny(this.id, 'CHUD_notes')"><cfif isdefined("url.target") and #url.target# EQ "hud">#hud_notes#</cfif></textarea></cfoutput>
									<br>
									<div align="right" valign="bottom">
									This text field has a max of 2500 characters. Characters entered:
									<cfoutput>
										<input type="text" value="" name="CHUD_notes" id="CHUD_notes" size="4" style="border:0;" disabled>
									</cfoutput>
								</td>
								</tr>


				<tr>
								<Td colspan="4">
									<input type="button" value="Check Spelling" onClick="spell('document.wrk.HUD_notes.value')">
									<br>
									<input type="submit" name="add_HUD"
									<cfif isdefined("url.target") and url.target EQ "HUD">
										value="Update"
									<cfelse>
										value="Add"
									</cfif>
									class="AddButton" onClick="return checkHUD();">
									<br>
									<br>
								</td>
					</tr>
<cfif qhud.recordcount is not 0>
<tr><td colspan=4>
<table border=".1" class="box" width="775">
<tr>
	<td align="left">Target Name</td><td>Delete</td>
</tr>
					<cfoutput><cfloop query="Qhud">
	<tr>
		<td valign="top" bgcolor="##E9FBEC"><a href="javascript: document.wrk.action='month.cfm?#session.urltoken#&target=hud&seq2=#phaid###hud'; document.wrk.submit()">#name#</a></td>
				<td valign="top" bgcolor="##E9FBEC" align="center"><input type="Checkbox" name="Del_box15" value="#seq#"></td>
	</tr>
</cfloop>
		<tr><td colspan=7 align="right"><input type="submit" name="del_targ" value="Delete" class="DelButton">
</cfoutput>

</td></tr></table>


</cfif>
</cfoutput>
</cfif>
</cfif>
</td></tr></table></td></tr>

			<cfif #getverk.advoc# is 1>
				<tr>
					<th align="left" width="800">
						<a name="adv">
						</a>
						<h6>
						Advocating with Organizational Decision Makers
						<br>
						<br>
					</th>
				</tr>
				<tr>
					<td>
						<table class="boxy" width=800>
							<tr>
								<th width="250">
									Target Name
								</th>
								<th width="350">
									Select the categories which best describe the nature of your conversation with this Organizational Decision-maker
								</th>
								<th colspan="2">
									Describe your interaction with this target this month, including barriers and next steps with target
								</th>
							</tr>
							<tr>
								<td>
									<select name="adv_target"
									<!--- onChange="javascript: document.wrk.action='month.cfm?#session.urltoken###thcpo'; form.submit();" --->
									>
									<option value="">
										Please select
									</option>
									<cfoutput>
										<cfif attributes.obj2 EQ '8A' or #attributes.obj2# eq '8b'>
											<cfif isdefined("url.target") and #url.target# EQ "adv">
												<cfloop query="ADV_Qtargorg">
													<option value="#id#" selected>
														#targmhs#
													</option>
												</cfloop>
											<cfelse>
												<cfloop query="ADV_Qtargorgmedhealth">
													<option value="#id#"
													<cfif isdefined("url.target") and #url.target# EQ "adv" and QgettargAdv2.org EQ #id#>
														selected
													</cfif>
													>#targmhs#</option>
												</cfloop>
											</cfif>
										<cfelseif attributes.obj2 NEQ '1A'>
											<cfloop query="ADV_Qtargorg">
												<option value="#targid#"
												<cfif isdefined("url.target") and #url.target# EQ "adv" and QgettargAdv2.org EQ #targid#>
													selected
												</cfif>
												>#name#</option>
											</cfloop>
										<cfelse>
											<cfloop query="ADV_Qtargorgchc">
												<option value="#targid#"
												<cfif isdefined("url.target") and #url.target# EQ "adv" and QgettargAdv2.org EQ #targid#>
													selected
												</cfif>
												>#name#</option>
											</cfloop>
										</cfif>
									</cfoutput>
									</select>
								</td>
								<td>
									Select all that apply:
									<br>
									&nbsp;&nbsp;&nbsp;<input type="checkbox" name="adv_adcom" value=1
									<cfif isdefined("url.target") and #url.target# EQ "adv" and QgettargAdv2.adcomm EQ 1>
										checked="checked"
									</cfif>
									>Obtained administrative commitment
									<br>
									&nbsp;&nbsp;&nbsp;<input type="checkbox" name="adv_edIssues" value=1
									<cfif isdefined("url.target") and #url.target# EQ "adv" and QgettargAdv2.edIssues EQ 1>
										checked="checked"
									</cfif>
									>Education about the issue
									<br>
									&nbsp;&nbsp;&nbsp;<input type="checkbox" name="adv_edPol" value=1
									<cfif isdefined("url.target") and #url.target# EQ "adv" and QgettargAdv2.edPol EQ 1>
										checked="checked"
									</cfif>
									>Education about policy solutions
									<br>
									&nbsp;&nbsp;&nbsp;<input type="checkbox" name="adv_comPol" value=1
									<cfif isdefined("url.target") and #url.target# EQ "adv" and QgettargAdv2.comPol EQ 1>
										checked="checked"
									</cfif>
									>Obtained commitment for policy
									<cfif attributes.obj2 EQ '1E'>
										/systems change
									</cfif>
									<br>
									&nbsp;&nbsp;&nbsp;<input type="checkbox" name="adv_polTime" value=1
									<cfif isdefined("url.target") and #url.target# EQ "adv" and QgettargAdv2.polTime EQ 1>
										checked="checked"
									</cfif>
									>
									<cfif attributes.obj2 EQ '8A' OR attributes.obj2 EQ '8B'>
										Education about
									</cfif>
									<cfif attributes.obj2 EQ '1E'>
										/systems change
									</cfif>
									policy implementation/timeline
									<br>
									&nbsp;&nbsp;&nbsp;<input type="checkbox" name="adv_polAdopt" value=1
									<cfif isdefined("url.target") and #url.target# EQ "adv" and QgettargAdv2.polAdopt EQ 1>
										checked="checked"
									</cfif>
									>Policy
									<cfif attributes.obj2 EQ '1E'>
										/systems change
									</cfif>
									adoption
								</td>
								<td colspan=4><cfoutput>
									<textarea name="adv_notes" id="adv_notes" cols=55 rows=4  onkeyup="countitAny(this.id, 'Cadv_notes')"><cfif isdefined("url.target") and #url.target# EQ "adv">#QgettargAdv2.descr#</cfif></textarea></cfoutput>
									<br>
									<div align="right" valign="bottom">
									This text field has a max of 2500 characters. Characters entered:
									<cfoutput>
										<input type="text" value="" name="Cadv_notes" id="Cadv_notes" size="4" style="border:0;" disabled>
									</cfoutput>
								</td>
							</tr>
							<tr>
								<Td colspan="4">
									<input type="button" value="Check Spelling" onClick="spell('document.wrk.adv_notes.value')">
									<br>
									<input type="submit" name="add_adv"
									<cfif isdefined("url.target") and url.target EQ "adv">
										value="Update"
									<cfelse>
										value="Add"
									</cfif>
									class="AddButton" onClick="return checkADV();">
									<br>
									<br>
								</td>
							</tr>
							<cfif QgettargAdv.recordcount GT 0>
								<cfoutput>
									<tr>
										<td  colspan="3" align="center">
											<strong>
												Target Name
											</strong>
										</td>
										<!--- <th>Categories</th>
											<th>Describe</th> --->
										<td>
											<strong>
												Delete?
											</strong>
										</td>
									</tr>
									<cfloop query="QgettargAdv">
										<tr>
											<td  bgcolor="##E9FBEC" colspan="3">
												<a href="javascript: document.wrk.action='month.cfm?#session.urltoken#&target=adv&seq=#QgettargAdv.monthlyorgid###adv'; document.wrk.submit()">
													#QgettargAdv.name#
												</a>
											</td>
											<td  align="right" bgcolor="##E9FBEC" width="20">
												<input type="Checkbox" name="Del_boxADV" value="#QgettargAdv.monthlyorgid#">
											</td>
										</tr>
									</cfloop>
									<tr>
										<td colspan="4" align="right">
											<input type="submit" name="del_ADV" value="Delete" onClick="javascript: document.wrk.action='month.cfm?#session.urltoken###adv'; " class="DelButton">
										</td>
									</tr>
								</cfoutput>
							</cfif>
						</table>
					</td>
				</tr></cfif>
				<cfif attributes.obj2 EQ '1A' or attributes.obj2 EQ '8A' or attributes.obj2 EQ '8B'>
					<cfquery datasource="#application.DataSource#" password="#application.db_password#"	username="#application.db_username#" name="AskAdvise">
	select id, label
	from askadvise
	where year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	order by rank

</cfquery>
					<cfif (isdefined("form.id") and #form.id# is not '') or (isdefined("url.seq") and #url.seq# is not '')>
						<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QgettargHCPO">

	select c.id,
	c.plcwritpol,c.ehr,c.writstd,
	c.askwritten,	c.askEHR,	c.askStandard

	from HSC_mon  c, hsc h
	where c.id = h.id
and c.id = <cfif isdefined("url.seq")><cfqueryparam value="#url.seq#" cfsqltype="CF_SQL_INTEGER">
<cfelse><cfqueryparam value="#form.id#" cfsqltype="CF_SQL_INTEGER"></cfif>
and c.mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
and c.year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">

</cfquery>
						<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="QgettargHCPO2">

SELECT *
FROM hsc h
WHERE (h.YEAR2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"><cfif #session.fy# gte 2016> or h.year2 < <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"></cfif>)
AND OBJ = <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="2">
AND USERID = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
and h.id = <cfif isdefined("url.seq")><cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.seq#"><cfelseif isdefined("form.id")><cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#form.id#"><cfelse><cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#form.selhscid#"></cfif>
ORDER BY 1
</cfquery>
<cfif session.fy GTE 2018>
<cfset askwritt2018 = #qgettarghcpo2.askwritten2018#>
<cfset askeh2018 = #qgettarghcpo2.askehr2018#>
<cfset askstan2018 = #qgettarghcpo2.askstandard2018#>
<cfelse>
<cfset askwritt2018 = ''>
<cfset askeh2018 = ''>
<cfset askstan2018 = ''>
</cfif>
<cfif session.fy GTE 2017>
<cfset askwritt2017 = #qgettarghcpo2.askwritten2017#>
<cfset askeh2017 = #qgettarghcpo2.askehr2017#>
<cfset askstan2017 = #qgettarghcpo2.askstandard2017#>
<cfelse>
<cfset askwritt2017 = ''>
<cfset askeh2017 = ''>
<cfset askstan2017 = ''>
</cfif>
<cfif session.fy GTE 2016>
<cfset askwritt2016 = #qgettarghcpo2.askwritten2016#>
<cfset askeh2016 = #qgettarghcpo2.askehr2016#>
<cfset askstan2016 = #qgettarghcpo2.askstandard2016#>
<cfelse>
<cfset askwritt2016 = ''>
<cfset askeh2016 = ''>
<cfset askstan2016 = ''>
</cfif>

						<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="indSELHSC">

	select distinct
	c.plcwritpol,c.ehr,c.writstd,
	c.askwritten,	c.askEHR,	c.askStandard

	from HSC_mon  c, HSC_mon c2, hsc h
	where c2.id=c.id and c.id = h.id
	and c.mon in (
	select m.mon_num from months m, months mm
	where m.year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and m.year2=mm.year2
	and mm.mon_num = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
	and m.rank < mm.rank
	)
	and
	h.userid= <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and c2.year2= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and c2.year2=c.year2
	and h.obj=<cfqueryparam value="#attributes.obj2#" cfsqltype="CF_SQL_VARCHAR" maxlength="10">
	and h.id = c2.id
	and h.id = <cfif isdefined("url.seq")><cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.seq#"><cfelseif isdefined("form.id")><cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#form.id#"><cfelse><cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#form.selhscid#"></cfif>
</cfquery>

						<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="indSELHSC2">
	select c.id,
	c.plcwritpol,c.ehr,c.writstd,
	c.askwritten,	c.askEHR,	c.askStandard
	from HSC_mon  c, hsc h
	where c.id = h.id
and c.id = <cfif isdefined("url.seq")><cfqueryparam value="#url.seq#" cfsqltype="CF_SQL_INTEGER"><cfelse><cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#form.id#"></cfif>
and <cfif #session.fy# gte 2016>c.year2 < <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"><cfelse>c.year2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER"></cfif>
</cfquery>
						<cfset x=''>
						<cfloop query="indselhsc">
							<cfset x=#ValueList(indselhsc.askehr)#>
							<cfset y=#ValueList(indselhsc.askwritten)#>
							<cfset z=#ValueList(indselhsc.askstandard)#>
							<cfset temp2 = ListAppend(x,#indselhsc.askehr# )>
							<cfset temp = ListAppend(y,#indselhsc.askwritten# )>
							<cfset temp3 = ListAppend(z,#indselhsc.askstandard# )>
						</cfloop>
						<cfset x=''>
						<cfloop query="indselhsc2">
							<cfset x22=#ValueList(indselhsc2.plcwritpol)#>
							<cfset x222=#ValueList(indselhsc2.ehr)#>
							<cfset x2222=#ValueList(indselhsc2.writstd)#>
							<cfset x2=#ValueList(indselhsc2.askehr)#>
							<cfset y2=#ValueList(indselhsc2.askwritten)#>
							<cfset z2=#ValueList(indselhsc2.askstandard)#>
							<cfset temp2222 = ListAppend(x22,#indselhsc2.plcwritpol# )>
							<cfset temp22222 = ListAppend(x222,#indselhsc2.ehr# )>
							<cfset temp222222 = ListAppend(x2222,#indselhsc2.writstd# )>
							<cfset temp222 = ListAppend(x2,#indselhsc2.askehr# )>
							<cfset temp22 = ListAppend(y2,#indselhsc2.askwritten# )>
							<cfset temp32 = ListAppend(z2,#indselhsc2.askstandard# )>
						</cfloop>
					</cfif>
					<a name="TMHS">
					</a>
					<tr>
						<th>
							<a name="ppc">
							</a>
							<h6>
							<cfif session.objval EQ "8A">
								Medical Health Systems Change
							<cfelseif session.objval EQ "8B">
								Mental Health Systems Change
							<cfelse>
								CHC
							</cfif>
							Policy and Practice Change
						</th>
					</tr>
					<table class="boxy" border=".1" width=800 cellpadding=10>
						<tr>
							<td colspan=3 >
								<strong>
									<cfif session.objval EQ "8A">
										Target Medical Health Systems:
									<cfelseif session.objval EQ "8B">
										Target Mental Health Systems:
									</cfif>
								</strong>
								<input type="hidden" name="showz">
								<cfoutput>
									<select name="id" onChange="javascript: document.wrk.action='month.cfm?#session.urltoken#&target=TMHS##TMHS'; form.submit();">
								</cfoutput>
								<option value="">Please select</option>
								<cfoutput>
									<cfif attributes.obj2 EQ '8A' or #attributes.obj2# eq '8b'>

									<!--- <cfdump var="#form#"> --->
									<cfloop query="ADV_Qtargorgmedhealthchc"> <!--- #id#  --->
										<option value="#id#"
											<cfif (isDefined("QgettargHCPO2") and QgettargHCPO2.recordcount NEQ 0 and QgettargHCPO2.id EQ #ADV_Qtargorgmedhealthchc.id#)
											or (isDefined("QgettargHCPO") and QgettargHCPO.recordcount NEQ 0 and QgettargHCPO.id EQ #ADV_Qtargorgmedhealthchc.id#)
											or (isDefined("form.id") and form.id EQ #id#)>selected</cfif>>
											#targmhs#
										</option>
									</cfloop>
									</cfif>
								</cfoutput>
									</select>
								<br>
							</td>
						</tr>
						<tr>
							<cfif isDefined("QgettargHCPO2")>
								<input type="hidden" name="selhscid"
								<cfoutput>
									value="#QgettargHCPO2.id#"
								</cfoutput>
								>
							</cfif>
							<th>
								<input type="checkbox" name="plcwritpol" value="1"
								<cfif (isDefined("QgettargHCPO.plcwritpol") and #QgettargHCPO.plcwritpol# eq 1) or (isdefined("QgettargHCPO2") and QgettargHCPO2.askWritten is not '') or (isdefined("indSELHSC") and indSELHSC.plcwritpol eq 1) or  (isdefined("temp2222") and listfind(temp2222,1))>
									checked
									<cfif (isdefined("QgettargHCPO2") and QgettargHCPO2.askWritten is not '') or (isdefined("QgettargHCPO.plcwritpol") and QgettargHCPO.plcwritpol eq 1) or  (isdefined("temp2222") and listfind(temp2222,1))>
										disabled
									</cfif>
								</cfif>
								>In place as written policy
							</th>
							<th>
								<input type="checkbox" name="ehr" value="1"
								<cfif (isDefined("QgettargHCPO.ehr") and #QgettargHCPO.ehr# eq 1) or (isdefined("QgettargHCPO2") and QgettargHCPO2.askehr is not '') or (isdefined("indSELHSC") and indSELHSC.ehr eq 1) or (isdefined("indSELHSC2") and indSELHSC2.ehr eq 1) or  (isdefined("temp22222") and listfind(temp22222,1)) or (isdefined("temp2") and listfind(temp2,1))>
									checked
									<cfif (isdefined("QgettargHCPO2") and QgettargHCPO2.askehr is not '') or (isdefined("QgettargHCPO") and QgettargHCPO.ehr eq 1) or  (isdefined("temp22222") and listfind(temp22222,1)) or (isdefined("temp2") and listfind(temp2,1))>
										disabled
									</cfif>
								</cfif>
								>In place as EHR
							</th>
							<th>
								<input type="checkbox" name="writstd" value="1"
								<cfif (isDefined("QgettargHCPO.writstd") and #QgettargHCPO.writstd# eq 1) or (isdefined("QgettargHCPO2") and QgettargHCPO2.askstandard is not '') or (isdefined("indSELHSC") and indSELHSC.writstd eq 1) or  (isdefined("temp222222") and listfind(temp222222,1)) or  (isdefined("temp3") and listfind(temp3,1))>
									checked
									<cfif (isdefined("QgettargHCPO2") and QgettargHCPO2.askstandard is not '') or (isdefined("QgettargHCPO") and QgettargHCPO.writstd eq 1) or  (isdefined("temp222222") and listfind(temp222222,1)) or  (isdefined("temp3") and listfind(temp3,1))>
										disabled
									</cfif>
								</cfif>
								>In place as written standard of care or protocol
							</th>
						</tr>
						<tr>
							<td>
								<cfoutput query="AskAdvise">
									<input type="checkbox" name="askWritten" value="#id#" onClick="checkBaseline();"
									<cfif (isDefined("QgettargHCPO.askwritten") and listfind(QgettargHCPO.askWritten,#id#))  or  (isdefined("QgettargHCPO2") and (listfind(askWritt2016,#id#) OR listfind(askWritt2017,#id#) OR listfind(askWritt2018,#id#))) or  (isdefined("QgettargHCPO2") and listfind(QgettargHCPO2.askWritten,#id#)) or (isdefined("temp") and listfind(temp,#id#)) or  (isdefined("temp22") and listfind(temp22,#id#))>
										checked
										<cfif (isdefined("QgettargHCPO2") and (listfind(askWritt2016,#id#) OR listfind(askWritt2017,#id#) OR listfind(askWritt2018,#id#))) or (isdefined("QgettargHCPO2") and listfind(QgettargHCPO2.askWritten,#id#)) or (isdefined("temp") and listfind(temp,#id#)) or (isdefined("temp22") and listfind(temp22,#id#))>
											disabled
										</cfif>
									</cfif>
									>
									<strong>
										#label#
									</strong>
									<br>
								</cfoutput>
							</td>
							<td>
								<cfoutput query="AskAdvise">
									<input type="checkbox" name="askEHR" value="#id#" onClick="checkBaseline();"
									<!---<cfif #findoneof("789",id)#> disabled</cfif>--->
									<cfif (isDefined("QgettargHCPO.askehr") and listfind(QgettargHCPO.askehr,#id#)) or  (isdefined("QgettargHCPO2") and (listfind(askeh2016,#id#) OR listfind(askeh2017,#id#) OR listfind(askeh2018,#id#))) or  (isdefined("QgettargHCPO2") and listfind(QgettargHCPO2.askehr,#id#)) or  (isdefined("temp2") and listfind(temp2,#id#)) or  (isdefined("temp222") and listfind(temp222,#id#))>
										checked
										<cfif (isdefined("QgettargHCPO2") and (listfind(askeh2016,#id#) OR listfind(askeh2017,#id#) OR listfind(askeh2018,#id#))) or (isdefined("QgettargHCPO2") and listfind(QgettargHCPO2.askehr,#id#))  or (isdefined("temp2") and listfind(temp2,#id#)) or (isdefined("temp222") and listfind(temp222,#id#))>
											disabled
										</cfif>
									</cfif>
									>
									<strong>
										#label#
									</strong>
									<br>
								</cfoutput>
							</td>
							<td>
								<cfoutput query="AskAdvise">
									<input type="checkbox" name="askStandard" value="#id#" onClick="checkBaseline();"
									<!---<cfif #findoneof("7",id)#> disabled<cfelseif  listfind(10,#id#)> disabled</cfif>--->
									<cfif (isDefined("QgettargHCPO.askstandard") and listfind(QgettargHCPO.askStandard,#id#))  or (isdefined("QgettargHCPO2") and (listfind(askStan2016,#id#) OR listfind(askStan2017,#id#) OR listfind(askStan2018,#id#))) or (isdefined("QgettargHCPO2") and listfind(QgettargHCPO2.askStandard,#id#)) or (isdefined("temp3") and listfind(temp3,#id#)) or (isdefined("temp32") and listfind(temp32,#id#))>
										checked
										<cfif (isdefined("QgettargHCPO2") and (listfind(askStan2016,#id#) OR listfind(askStan2017,#id#) OR listfind(askStan2018,#id#))) or (isdefined("QgettargHCPO2") and listfind(QgettargHCPO2.askStandard,#id#)) or (isdefined("temp3") and listfind(temp3,#id#)) or (isdefined("temp32") and listfind(temp32,#id#))>
											disabled
										</cfif>
									</cfif>
									>
									<strong>
										#label#
									</strong>
									<br>
								</cfoutput>
							</td>
						</tr>
						<tr>
							<Td colspan=3>
								<cfif isDefined("url.seq")>
									<input type="submit" name="addHSC" value="Update" class="AddButton">
								<cfelse>
									<input type="submit" name="addHSC" value="Add" class="AddButton" onClick="return ValidateMHSID();">
								</cfif>
							</td>
						</tr></table>
						<cfquery datasource="#Application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="SELHSC">
 SELECT distinct hm.ID, ltrim(cast(targmhs as varchar(100))) as targmhs
FROM HSC_mon hm LEFT join hsc h on hm.id = h.id
WHERE hm.YEAR2 = <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
AND OBJ = <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
AND USERID = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
and mon = <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
ORDER BY ltrim(cast(targmhs as varchar(100)))
</cfquery>

						<CFIF SELHSC.RECORDCOUNT NEQ 0>
							<tr>
								<td colspan=1>
									<table class="box" width="800">
										<tr>
											<td>
												<cfif session.objval EQ "8A">
													Target Medical Health Systems
												<cfelseif session.objval EQ "8B">
													Target Mental Health Systems
												</cfif>
											</td>
											<td>
												Delete
											</td>
										</tr>
										<CFOUTPUT query="SELHSC">
											<tr>
												<td bgcolor="##E9FBEC">
													<a href="javascript: document.wrk.action='month.cfm?#session.urltoken#&target=TMHS&seq=#ID###TMHS'; document.wrk.submit()">
														#targmhs#
													</a>
												</td>
												<td bgcolor="##E9FBEC">
													<INPUT TYPE="CHECKBOX" NAME="dELhsc" VALUE="#ID#">
												</TD>
											</tr>
										</CFOUTPUT>
										<tr>
											<td colspan=4>
												<input type="submit" name="del_hsc" value="Delete" class="DelButton">
											</td>
										</tr>
									</table>
								</td>
							</tr>

					</table>
					</td></tr>
				<cfelseif attributes.obj2 EQ '1E'>
					<script language="javascript">
function checkHCPO(){
if (document.wrk.hcpo_wtdtPol.checked==true || document.wrk.hcpo_wtdtPol.disabled==true){
	<cfif NOT(isDefined("QgettargHCPO2x") and QgettargHCPO2x.orgPol EQ 1)>document.wrk.hcpo_orgPol.disabled=false;</cfif>
	<cfif NOT(isDefined("QgettargHCPO2x") and QgettargHCPO2x.clinp EQ 1)>document.wrk.hcpo_clinP.disabled=false;</cfif>
	<cfif NOT(isDefined("QgettargHCPO2x") and QgettargHCPO2x.clinW EQ 1)>document.wrk.hcpo_clinW.disabled=false;</cfif>
	<cfif NOT(isDefined("QgettargHCPO2x") and QgettargHCPO2x.emr EQ 1)>document.wrk.hcpo_EMR.disabled=false;</cfif>
	<cfif NOT(isDefined("QgettargHCPO2x") and QgettargHCPO2x.other EQ 1)>document.wrk.hcpo_other.disabled=false;</cfif>

	if ((document.wrk.hcpo_orgPol.checked==true)||	(document.wrk.hcpo_clinP.checked==true )||	(document.wrk.hcpo_clinW.checked==true)||	(document.wrk.hcpo_EMR.checked==true) ||	(document.wrk.hcpo_other.checked==true))
	{
	<cfif NOT(isDefined("QgettargHCPO2x") and QgettargHCPO2x.ask EQ 1)>document.wrk.hcpo_ask.disabled=false;</cfif>
	<cfif NOT(isDefined("QgettargHCPO2x") and QgettargHCPO2x.advise_ident EQ 1)>document.wrk.hcpo_advise.disabled=false;</cfif>
	<cfif NOT(isDefined("QgettargHCPO2x") and QgettargHCPO2x.assess_ident EQ 1)>document.wrk.hcpo_assess.disabled=false;</cfif>
	<cfif NOT(isDefined("QgettargHCPO2x") and QgettargHCPO2x.assist EQ 1)>document.wrk.hcpo_assist.disabled=false;</cfif>
	<!--- <cfif NOT(isDefined("QgettargHCPO2x") and QgettargHCPO2x.arrange EQ 1)>document.wrk.hcpo_arrange.disabled=false;</cfif> --->
	<cfif NOT(isDefined("QgettargHCPO2x") and QgettargHCPO2x.referral EQ 1)>document.wrk.hcpo_refer.disabled=false;</cfif>
	<cfif NOT(isDefined("QgettargHCPO2x") and QgettargHCPO2x.train EQ 1)>document.wrk.hcpo_train.disabled=false;</cfif>
	<cfif NOT(isDefined("QgettargHCPO2x") and QgettargHCPO2x.definedHCP EQ 1)>document.wrk.hcpo_hcp.disabled=false;</cfif>

	}
	else{
		document.wrk.hcpo_ask.disabled=true;
		document.wrk.hcpo_advise.disabled=true;
		document.wrk.hcpo_assess.disabled=true;
		document.wrk.hcpo_assist.disabled=true;
		<!--- document.wrk.hcpo_arrange.disabled=true; --->
		document.wrk.hcpo_refer.disabled=true;
		document.wrk.hcpo_train.disabled=true;
		document.wrk.hcpo_hcp.disabled=true;

	}


}
else {
	document.wrk.hcpo_orgPol.disabled=true;
	document.wrk.hcpo_clinP.disabled=true;
	document.wrk.hcpo_clinW.disabled=true;
	document.wrk.hcpo_EMR.disabled=true;
	document.wrk.hcpo_other.disabled=true;

	document.wrk.hcpo_ask.disabled=true;
	document.wrk.hcpo_advise.disabled=true;
	document.wrk.hcpo_assess.disabled=true;
	document.wrk.hcpo_assist.disabled=true;

	document.wrk.hcpo_refer.disabled=true;
	document.wrk.hcpo_train.disabled=true;
	document.wrk.hcpo_hcp.disabled=true;
}

}

</script>
					<tr>
						<th>
							<a name="hcpo">
							</a>
							<h6>
							HCPO Policy and Practice Change
						</th>
					</tr>
					<table class="boxy" border=".1" width=800 cellpadding=10>
						<tr>
							<td colspan="5" >
								<strong>
									Target HCPO
									<br>
								</strong>
							</td>
							<td>
								<input type="hidden" name="showz">
								<cfoutput>
									<select name="hcpo_target"
									<cfif NOT(isDefined("url.target") and url.target EQ "HCPO")>
										onChange="javascript: document.wrk.action='month.cfm?#session.urltoken#&target=hcpo2##hcpo'; form.submit();"
									</cfif>
									>
								</cfoutput>
								<option value="" selected>
									Please select
								</option>
								<cfoutput>
									<cfloop query="HCPO_Qtargorg">
										<option value="#targid#"
										<cfif isdefined("url.target") and url.target EQ "HCPO" and isDefined("QgettargHCPO2") and QgettargHCPO2.recordcount NEQ 0 and QgettargHCPO2.target EQ #targid#>
											selected
										<cfelseif isdefined("url.target") and url.target EQ "HCPO2" and #form.HCPO_target# EQ #targid# >
											selected
										</cfif>
										>#name#</option>
									</cfloop>
								</cfoutput>
								</select>
								<br>
							</td>
						</tr>
						<tr>
							<td colspan="6">
								<input type="checkbox" name="hcpo_wtdtPol" value="1" onClick="checkHCPO();"
								<cfif isDefined("QgettargHCPO2x") and QgettargHCPO2x.wtdtPol EQ 1>
									checked="checked" disabled
								<cfelseif isDefined("QgettargHCPO2") and QgettargHCPO2.wtdtPol EQ 1>
									checked="checked"
								</cfif>
								>
								<strong>
									Tobacco Dependence Treatment Systems Change:
								</strong>
							</td>
						</tr>
						<tr>
							<td>
								&nbsp;&nbsp;&nbsp;&nbsp;
							</td>
							<td colspan="5">
								<input type="checkbox" name="hcpo_orgPol" value="1" onClick="checkHCPO();"
								<cfif isDefined("QgettargHCPO2x") and QgettargHCPO2x.orgPol EQ 1>
									checked="checked" disabled
								<cfelseif isDefined("QgettargHCPO2") and QgettargHCPO2.orgPol EQ 1>
									checked="checked"
								</cfif>
								> Organizational policy
							</td>
						</tr>
						<tr>
							<td>
								&nbsp;
							</td>
							<td colspan="5" nowrap="">
								<input type="checkbox" name="hcpo_clinP" value="1" onClick="checkHCPO();"
								<cfif isDefined("QgettargHCPO2x") and QgettargHCPO2x.clinP EQ 1>
									checked="checked" disabled
								<cfelseif isDefined("QgettargHCPO2") and QgettargHCPO2.clinP EQ 1>
									checked="checked"
								</cfif>
								> Clinical policy/procedures
							</td>
						</tr>
						<tr>
							<td>
								&nbsp;
							</td>
							<td colspan="5">
								<input type="checkbox" name="hcpo_clinW" value="1" onClick="checkHCPO();"
								<cfif isDefined("QgettargHCPO2x") and QgettargHCPO2x.clinW EQ 1>
									checked="checked" disabled
								<cfelseif isDefined("QgettargHCPO2") and QgettargHCPO2.clinW EQ 1>
									checked="checked"
								</cfif>
								> Clinic Workflow protocol
							</td>
						</tr>
						<tr>
							<td>
								&nbsp;
							</td>
							<td colspan="5">
								<input type="checkbox" name="hcpo_EMR" value="1" onClick="checkHCPO();"
								<cfif isDefined("QgettargHCPO2x") and QgettargHCPO2x.emr EQ 1>
									checked="checked" disabled
								<cfelseif isDefined("QgettargHCPO2") and QgettargHCPO2.emr EQ 1>
									checked="checked"
								</cfif>
								> EMR
							</td>
						</tr>
						<tr>
							<td>
								&nbsp;
							</td>
							<td colspan="5">
								<input type="checkbox" name="hcpo_other" value="1" onClick="checkHCPO();"
								<cfif isDefined("QgettargHCPO2x") and QgettargHCPO2x.other EQ 1>
									checked="checked" disabled
								<cfelseif isDefined("QgettargHCPO2") and QgettargHCPO2.other EQ 1>
									checked="checked"
								</cfif>
								>Other:
								<textarea name="hcpo_othertxt" id="hcpo_othertxt" rows="1" columns="20" onkeyup="countitAny(this.id, 'Chcpo_othertxt')"><cfif isDefined("QgettargHCPO2")><cfoutput>#QgettargHCPO2.descr#</cfoutput></cfif></textarea>
								<br>
								<div align="right" valign="bottom">
								This text field has a max of 2500 characters. Characters entered:
								<cfoutput>
									<input type="text" value="" name="Chcpo_othertxt" id="Chcpo_othertxt" size="4" style="border:0;" disabled>
								</cfoutput>
							</td>
						</tr>
						<tr>
							<td colspan="6">
								&nbsp;
							</td>
						</tr>
						<tr>
							<td>
							</td>
							<td colspan="5">
								Select all that apply:
							</td>
						</tr>
						<tr>
							<td>
							</td>
							<td colspan="2">
								&nbsp;&nbsp;&nbsp;&nbsp;
							</td>
							<td>
								<input type="checkbox" name="hcpo_ask" value="1"
								<cfif isDefined("QgettargHCPO2x") and QgettargHCPO2x.ask EQ 1>
									checked="checked" disabled
								<cfelseif isDefined("QgettargHCPO2") and QgettargHCPO2.ask EQ 1>
									checked="checked"
								</cfif>
								> Ask-
							</td>
							<td colspan="3">
								Every patient will be screened for tobacco use
							</td>
						</tr>
						<tr>
							<td colspan="3">
							</td>
							<td>
								<input type="checkbox" name="hcpo_advise" value="1"
								<cfif isDefined("QgettargHCPO2x") and QgettargHCPO2x.advise_ident EQ 1>
									checked="checked" disabled
								<cfelseif isDefined("QgettargHCPO2") and QgettargHCPO2.advise_ident EQ 1>
									checked="checked"
								</cfif>
								> Advise-
							</td>
							<td colspan="2">
								Every tobacco user will be advised to quit
							</td>
						</tr>
						<tr>
							<td colspan="3">
							</td>
							<td>
								<input type="checkbox" name="hcpo_assess" value="1"
								<cfif isDefined("QgettargHCPO2x") and QgettargHCPO2x.assess_ident EQ 1>
									checked="checked" disabled
								<cfelseif isDefined("QgettargHCPO2") and QgettargHCPO2.assess_ident EQ 1>
									checked="checked"
								</cfif>
								> Assess-
							</td>
							<td colspan="2">
								Every tobacco user will be assessed for a willingness to quit
							</td>
						</tr>
						<tr>
							<td colspan="3">
							</td>
							<td>
								<input type="checkbox" name="hcpo_assist" value="1"
								<cfif isDefined("QgettargHCPO2x") and QgettargHCPO2x.assist EQ 1>
									checked="checked" disabled
								<cfelseif isDefined("QgettargHCPO2") and QgettargHCPO2.assist EQ 1>
									checked="checked"
								</cfif>
								> Assist/Arrange-
							</td>
							<td colspan="2">
								Every tobacco user, ready to quit, will be provided brief counseling and provided follow-up
							</td>
						</tr>
						<!--- <tr>
							<td colspan="2"></td>
							<td><input type="checkbox" name="" value="1"> Assist/Arrange-</td>
							<td colspan="2">Every tobacco user, ready to quit, will be assisted and provided follow-up</td>
							</tr> --->
						<tr>
							<td colspan="3">
							</td>
							<td>
								<input type="checkbox" name="hcpo_refer" value="1"
								<cfif isDefined("QgettargHCPO2x") and QgettargHCPO2x.referral EQ 1>
									checked="checked" disabled
								<cfelseif isDefined("QgettargHCPO2") and QgettargHCPO2.referral EQ 1>
									checked="checked"
								</cfif>
								> Referral-
							</td>
							<td colspan="2">
								Every tobacco user is referred to the Quitline for additional services as the default option, unless the person opts out of the referral
							</td>
						</tr>
						<tr>
							<td colspan="3">
							</td>
							<td>
								<input type="checkbox" name="hcpo_train" value="1"
								<cfif isDefined("QgettargHCPO2x") and QgettargHCPO2x.train EQ 1>
									checked="checked" disabled
								<cfelseif isDefined("QgettargHCPO2") and QgettargHCPO2.train EQ 1>
									checked="checked"
								</cfif>
								> Training-
							</td>
							<td colspan="2">
								Providers will receive on-going tobacco treatment training
							</td>
						</tr>
						<tr>
							<td colspan="3">
							</td>
							<td>
								<input type="checkbox" name="hcpo_hcp" value="1"
								<cfif isDefined("QgettargHCPO2x") and QgettargHCPO2x.definedHCP EQ 1>
									checked="checked" disabled
								<cfelseif isDefined("QgettargHCPO2") and QgettargHCPO2.definedHCP EQ 1>
									checked="checked"
								</cfif>
								> Defined HCP duty-
							</td>
							<td colspan="2">
								Tobacco dependence treatment is a defined clinician duty
							</td>
						</tr>
						<tr>
							<td colspan="6">
								<input type="button" value="Check Spelling" onClick="spell('document.wrk.hcpo_othertxt.value')">
								<br>
								<input type="submit" name="add_hcpo"
								<cfif isDefined("url.target") and url.target EQ "hcpo">
									value="Update"
								<cfelse>
									value="Add"
								</cfif>
								class="AddButton" onClick="return checkHCP();">
								<br>
								<br>
							</td>
						</tr>
						<script language="javascript">
checkHCPO();

</script>
						<cfif QgettargHCPO.recordcount GT 0>
							<cfoutput>
								<tr>
									<th colspan="5">
										Target Name
									</th>
									<th align="right">
										Delete?
									</th>
								</tr>
								<cfloop query="QgettargHCPO">
									<tr>
										<td  colspan="5" bgcolor="##E9FBEC"  colspan="5">
											<a href="javascript: document.wrk.action='month.cfm?#session.urltoken#&target=hcpo&seq=#QgettargHCPO.monthlyccid###hcpo'; document.wrk.submit()">
												gvgg#QgettargHCPO.name#
											</a>
										</td>
										<td bgcolor="##E9FBEC" align="right">
											<input type="Checkbox" name="Del_boxHCPO" value="#QgettargHCPO.monthlyccid#">
										</td>
									</tr>
								</cfloop>
								<tr>
									<td colspan="6" align="right">
										<input type="submit" name="del_HCPO" value="Delete" onClick="javascript: document.wrk.action='month.cfm?#session.urltoken###hcpo'; " class="DelButton">
									</td>
								</tr>
							</cfoutput>
						</cfif>
					</table>
					</td></tr>
				</cfif>
				<br>
				<br>
				<cfif attributes.obj2 EQ '1A'>
					<script language="javascript">
function checkCLIN(){
if ((document.wrk.clin_p.checked==true || document.wrk.clin_p.disabled==true)||(document.wrk.clin_w.checked==true || document.wrk.clin_w.disabled==true)||(document.wrk.clin_other.checked==true || document.wrk.clin_other.disabled==true)){
	<cfif NOT(isDefined("QgettargCLIN2x") and QgettargCLIN2x.ask EQ 1)>document.wrk.clin_ask.disabled=false;</cfif>
	<cfif NOT(isDefined("QgettargCLIN2x") and QgettargCLIN2x.advise_ident EQ 1)>document.wrk.clin_advise.disabled=false;</cfif>
	<cfif NOT(isDefined("QgettargCLIN2x") and QgettargCLIN2x.assess_ident EQ 1)>document.wrk.clin_assess.disabled=false;</cfif>
	<cfif NOT(isDefined("QgettargCLIN2x") and QgettargCLIN2x.assist EQ 1)>document.wrk.clin_assist.disabled=false;</cfif>
	<cfif NOT(isDefined("QgettargCLIN2x") and QgettargCLIN2x.arrange EQ 1)>document.wrk.clin_arrange.disabled=false;</cfif>
	<cfif NOT(isDefined("QgettargCLIN2x") and QgettargCLIN2x.referral EQ 1)>document.wrk.clin_refer.disabled=false;</cfif>
}
else {
document.wrk.clin_ask.disabled=true;
	document.wrk.clin_advise.disabled=true;
	document.wrk.clin_assess.disabled=true;
	document.wrk.clin_assist.disabled=true;
	document.wrk.clin_arrange.disabled=true;
	document.wrk.clin_refer.disabled=true;
}
if (document.wrk.clin_sysImp.checked==true || document.wrk.clin_sysImp.disabled==true){
	<cfif NOT(isDefined("QgettargCLIN2x") and QgettargCLIN2x.emr EQ 1)>document.wrk.clin_emr.disabled=false;</cfif>
	<cfif NOT(isDefined("QgettargCLIN2x") and QgettargCLIN2x.other EQ 1)>document.wrk.clin_other2.disabled=false;</cfif>
}
else {
	document.wrk.clin_emr.disabled=true;
	document.wrk.clin_other2.disabled=true;
}
}
</script>
					<tr>
						<th>
							<a name="clin">
							</a>
							<h6>
							Changes at CHC clinical sites
						</th>
					</tr>
					<table class="boxy" border=".1" width=800 cellpadding=10>
						<tr>
							<td colspan=2 >
								<strong>
									Target CHC Clinical Site
									<br>
								</strong>
							</td>
							<td>
								<input type="hidden" name="showz">
								<cfoutput>
									<select name="clin_target"
									<cfif NOT(isDefined("url.target") and url.target EQ "clin")>
										onChange="javascript: document.wrk.action='month.cfm?#session.urltoken#&target=clin2##clin'; form.submit();"
									</cfif>
									>
								</cfoutput>
								<option value="" selected>
									Please select
								</option>
								<cfoutput>
									<cfloop query="CLIN_Qtargchc">
										<!--- Qtargchc --->
										<option value="#targchcid#"
										<CFIF isdefined("url.target") and url.target EQ "CLIN" and isDefined("QgettargCLIN2") and QgettargCLIN2.recordcount NEQ 0 and QgettargCLIN2.target2 EQ #targchcid#>
											selected
										<cfelseif isdefined("url.target") and url.target EQ "CLIN2" and #form.Clin_target# EQ #targchcid# >
											selected
										</cfif>
										>#name#: #targsite#</option>
									</cfloop>
								</cfoutput>
								</select>
								<br>
							</td>
						</tr>
						<tr>
							<td colspan="2" nowrap>
								<input name="clin_p"value="1" type="checkbox" onClick="checkCLIN();"
								<cfif isDefined("QgettargCLIN2x") and QgettargCLIN2x.clinp EQ 1>
									checked="checked" disabled
								<cfelseif isDefined("QgettargCLIN2") and QgettargCLIN2.clinp EQ 1>
									checked="checked"
								</cfif>
								>
								<strong>
									Clinical policy/procedures
								</strong>
							</td>
							<td>
								Policy/procedure description
								<br>
								<textarea name="clin_descr" id="clin_descr" cols="55" rows="4"  onkeyup="countitAny(this.id, 'Cclin_descr')"><cfif isDefined("QgettargCLIN2")><cfoutput>#QgettargCLIN2.descr#</cfoutput></cfif></textarea>
								<br>
								<div align="right" valign="bottom">
								This text field has a max of 2500 characters. Characters entered:
								<cfoutput>
									<input type="text" value="" name="Cclin_descr" id="Cclin_descr" size="4" style="border:0;" disabled>
								</cfoutput>
							</td>
						</tr>
						<tr>
							<td colspan=2>
								<input name="clin_w"value="1" type="checkbox" onClick="checkCLIN();"
								<cfif isDefined("QgettargCLIN2x") and QgettargCLIN2x.clinw EQ 1>
									checked="checked" disabled
								<cfelseif isDefined("QgettargCLIN2") and QgettargCLIN2.clinw EQ 1>
									checked="checked"
								</cfif>
								>
								<strong>
									Clinic Workflow protocol
								</strong>
							</td>
							<td>
								Protocol description
								<br>
								<textarea name="clin_descr2" id="clin_descr2" rows="3" cols="55" onkeyup="countitAny(this.id, 'Cclin_descr2')"><cfif isDefined("QgettargCLIN2")><cfoutput>#QgettargCLIN2.descr2#</cfoutput></cfif></textarea>
								<br>
								<div align="right" valign="bottom">
								This text field has a max of 2500 characters. Characters entered:
								<cfoutput>
									<input type="text" value="" name="Cclin_descr2" id="Cclin_descr2" size="4" style="border:0;" disabled>
								</cfoutput>
							</td>
						</tr>
						<tr>
							<td colspan=2>
								<input name="clin_other"value="1" type="checkbox" onClick="checkCLIN();"
								<cfif isDefined("QgettargCLIN2x") and QgettargCLIN2x.clinother EQ 1>
									checked="checked" disabled
								<cfelseif isDefined("QgettargCLIN2") and QgettargCLIN2.clinother EQ 1>
									checked="checked"
								</cfif>
								>
								<strong>
									Other - please specify
								</strong>
							</td>
							<td>
								Description
								<br>
								<textarea name="clin_descr3" id="clin_descr3" rows="3" cols="55" onkeyup="countitAny(this.id, 'Cclin_descr3')"><cfif isDefined("QgettargCLIN2")><cfoutput>#QgettargCLIN2.descr3#</cfoutput></cfif></textarea>
								<br>
								<div align="right" valign="bottom">
								This text field has a max of 2500 characters. Characters entered:
								<cfoutput>
									<input type="text" value="" name="Cclin_descr3" id="Cclin_descr3" size="4" style="border:0;" disabled>
								</cfoutput>
							</td>
						</tr>
						<tr>
							<td colspan=1>
								Select all that apply:
							</td>
						</tr>
						<tr>
							<td>
								&nbsp;&nbsp;&nbsp;&nbsp;
							</td>
							<td>
								<input name="clin_ask"value="1" type="checkbox"
								<cfif isDefined("QgettargCLIN2x") and QgettargCLIN2x.ask EQ 1>
									checked="checked" disabled
								<cfelseif isDefined("QgettargCLIN2") and QgettargCLIN2.ask EQ 1>
									checked="checked"
								</cfif>
								> Ask-
							</td>
							<td>
								Every patient will be screened for tobacco use
							</td>
						</tr>
						<tr>
							<td>
								&nbsp;
							</td>
							<td>
								<input name="clin_advise"value="1" type="checkbox"
								<cfif isDefined("QgettargCLIN2x") and QgettargCLIN2x.advise_ident EQ 1>
									checked="checked" disabled
								<cfelseif isDefined("QgettargCLIN2") and QgettargCLIN2.advise_ident EQ 1>
									checked="checked"
								</cfif>
								> Advise-
							</td>
							<td>
								Every tobacco user will be advised to quit
							</td>
						</tr>
						<tr>
							<td>
								&nbsp;
							</td>
							<td>
								<input name="clin_assess"value="1" type="checkbox"
								<cfif isDefined("QgettargCLIN2x") and QgettargCLIN2x.assess_ident EQ 1>
									checked="checked" disabled
								<cfelseif isDefined("QgettargCLIN2") and QgettargCLIN2.assess_ident EQ 1>
									checked="checked"
								</cfif>
								> Assess-
							</td>
							<td>
								Every tobacco user will be assessed for willingness to quit
							</td>
						</tr>
						<tr>
							<td>
								&nbsp;
							</td>
							<td>
								<input name="clin_assist"value="1" type="checkbox"
								<cfif isDefined("QgettargCLIN2x") and QgettargCLIN2x.assist EQ 1>
									checked="checked" disabled
								<cfelseif isDefined("QgettargCLIN2") and QgettargCLIN2.assist EQ 1>
									checked="checked"
								</cfif>
								> Assist-
							</td>
							<td>
								Every tobacco user, ready to quit, will be provided brief counseling
							</td>
						</tr>
						<tr>
							<td>
								&nbsp;
							</td>
							<td>
								<input name="clin_arrange"value="1" type="checkbox"
								<cfif isDefined("QgettargCLIN2x") and QgettargCLIN2x.arrange EQ 1>
									checked="checked" disabled
								<cfelseif isDefined("QgettargCLIN2") and QgettargCLIN2.arrange EQ 1>
									checked="checked"
								</cfif>
								> Arrange-
							</td>
							<td>
								Every tobacco user, ready to quit, will be provided follow-up
							</td>
						</tr>
						<tr>
							<td>
								&nbsp;
							</td>
							<td>
								<input name="clin_refer"value="1" type="checkbox"
								<cfif isDefined("QgettargCLIN2x") and QgettargCLIN2x.referral EQ 1>
									checked="checked" disabled
								<cfelseif isDefined("QgettargCLIN2") and QgettargCLIN2.referral EQ 1>
									checked="checked"
								</cfif>
								> Referral-
							</td>
							<td>
								Every tobacco user is referred to the Quitline for additional services as the default option, unless the person opts out of the referral
							</td>
						</tr>
						<tr>
							<td colspan="3">
								<br>
							</td>
						</tr>
						<tr>
							<td colspan=1>
								<input name="clin_sysImp"value="1" type="checkbox" onClick="checkCLIN();"
								<cfif isDefined("QgettargCLIN2x") and QgettargCLIN2x.SysImp EQ 1>
									checked="checked" disabled
								<cfelseif isDefined("QgettargCLIN2") and QgettargCLIN2.sysImp EQ 1>
									checked="checked"
								</cfif>
								>
								<strong>
									System to implement and document tobacco dependence treatment policy/Standards of Care
								</strong>
							</td>
						</tr>
						<tr>
							<td>
								&nbsp;
							</td>
							<td>
								<input name="clin_emr"value="1" type="checkbox"
								<cfif isDefined("QgettargCLIN2x") and QgettargCLIN2x.emr EQ 1>
									checked="checked" disabled
								<cfelseif isDefined("QgettargCLIN2") and QgettargCLIN2.emr EQ 1>
									checked="checked"
								</cfif>
								> EMR
							</td>
							<td>
							</td>
						</tr>
						<tr>
							<td>
								&nbsp;
							</td>
							<td>
								<input name="clin_other2"value="1" type="checkbox"
								<cfif isDefined("QgettargCLIN2x") and QgettargCLIN2x.other EQ 1>
									checked="checked" disabled
								<cfelseif isDefined("QgettargCLIN2") and QgettargCLIN2.other EQ 1>
									checked="checked"
								</cfif>
								>Other - please specify
							</td>
							<td>
								<textarea name="clin_descr4" id="clin_descr4" rows="3" cols="55" onkeyup="countitAny(this.id, 'Cclin_descr4')"><cfif isDefined("QgettargCLIN2")><cfoutput>#QgettargCLIN2.descr4#</cfoutput></cfif></textarea>
								<br>
								<div align="right" valign="bottom">
								This text field has a max of 2500 characters. Characters entered:
								<cfoutput>
									<input type="text" value="" name="Cclin_descr4" id="Cclin_descr4" size="4" style="border:0;" disabled>
								</cfoutput>
							</td>
						</tr>
						<tr>
							<td colspan="3">
								<input type="button" value="Check Spelling" onClick="spell('document.wrk.clin_descr.value'),spell('document.wrk.clin_descr2.value'),spell('document.wrk.clin_descr3.value'),spell('document.wrk.clin_descr4.value')">
								<br>
								<input type="submit" name="add_clin"
								<cfif isDefined("url.target") and url.target EQ "clin">
									value="Update"
								<cfelse>
									value="Add"
								</cfif>
								class="AddButton" onclick="return checkCHC();" >
								<br>
								<br>
							</td>
						</tr>
					</table>
					<script language="javascript">
checkCLIN();

</script>
					<cfif QgettargCLIN.recordcount GT 0>
						<cfoutput>
							<table class="boxy" border=".1" width=800 cellpadding=10>
								<tr>
									<th colspan="3">
										Target Name
									</th>
									<th>
										Delete?
									</th>
								</tr>
								<cfloop query="QgettargCLIN">
									<tr>
										<td colspan="3"  bgcolor="##E9FBEC">
											<a href="javascript: document.wrk.action='month.cfm?#session.urltoken#&target=clin&seq=#QgettargCLIN.monthlyccid###clin'; document.wrk.submit()">
												#QgettargCLIN.name#: #QgettargCLIN.targsite#
											</a>
										</td>
										<td bgcolor="##E9FBEC">
											<input type="Checkbox" name="Del_boxCLIN" value="#QgettargCLIN.monthlyccid#">
										</td>
									</tr>
								</cfloop>
								<tr>
									<td colspan=4 align="right">
										<input type="submit" name="del_CLIN" value="Delete" onClick="javascript: document.wrk.action='month.cfm?#session.urltoken###clin'; " class="DelButton">
									</td>
								</tr>
						</cfoutput>
					</cfif>
					</table> </td></tr>
				</cfif>
			</cfif>
			<!--- <cfif obj EQ '1H'> --->
			<cfif attributes.obj2 EQ '1H' or attributes.obj2 EQ '8A' or attributes.obj2 EQ '8B' or attributes.obj2 EQ '8C'>
				<!--- Mobilization --->
				<cfif #getverk.commmob# eq 1 AND  attributes.obj2 NEQ '8C'>
					<tr>
						<th align="left" width="800">
							<a name="mob">
							</a>
							<h6>
							Community Mobilization
							<br>
							<br>
						</th>
					</tr>
					<tr>
						<td>
							<table class="boxyw" width=800>
								<tr>
									<th width="40%">
										<strong>
										<cfif session.fy GTE 2015>
											Partner
										</cfif>
										Organization Name
									</th>
									<cfif session.fy GTE 2015>
										<th>
											<strong>
											Target Org
										</th>
									</cfif>
									<th>
										<strong>
										How did this partner help advance/achieve a Health Systems Change outcome this month?
									</th>
								</tr>
								<tr>
									<td>
										<select name="mob_target" onChange="javascript: document.wrk.action='month.cfm?#session.urltoken#&target=mob##mob'; form.submit();">
											<option value="">
												Please select
											</option>
											<cfoutput>
												<cfloop query="qtargorg0">
													<option value="#targid#"
													<cfif (isdefined("form.mob_target") and form.mob_target eq #targid#) or (isdefined("url.target") and url.target EQ "mob" and QgettargMOB2.target EQ #targid#)>
														selected
													</cfif>
													<!--- <cfelseif NOT isDefined("url.targ") AND isdefined("FORM.targ") and #FORM.targ# EQ #targid#>selected</cfif> --->
													>#name#</option>
												</cfloop>
											</cfoutput>
										</select>
									</td>
									<cfif session.fy GTE 2015>
										<td>
											<select multiple name="mob_group" >
												<cfoutput>
													<cfloop query="ADV_Qtargorgmedhealth2">
														<option value="#id#"
														<cfif isDefined("QgettargMOB2") and listfind(QgettargMOB2.group, id)>
															selected
														</cfif>
														>#targmhs#</option>
													</cfloop>
													<option value="0"
													<cfif isDefined("QgettargMOB2") and listfind(QgettargMOB2.group, 0)>
														selected
													</cfif>
													>Other</option>
												</cfoutput>
											</select>
										</td>
									</cfif>
									<td align="center">
										<cfparam name="form.mob_descr" default="">
										<textarea name="mob_descr" id="mob_descr" cols=55 rows=4 onkeyup="countitAny(this.id, 'Cmob_descr')"><cfif isdefined("url.target") and url.target EQ "mob"><cfoutput>#QgettargMOB2.descr#</cfoutput></cfif></textarea>
										<br>
										<div align="right" valign="bottom">
										This text field has a max of 2500 characters. Characters entered:
										<cfoutput>
											<input type="text" value="" name="Cmob_descr" id="Cmob_descr" size="4" style="border:0;" disabled>
										</cfoutput>
									</td>
								</tr>
								<tr>
									<Td colspan=
									<cfif session.fy GTE 2015>
										3
									<cfelse>
										2
									</cfif>
									>
									<input type="button" value="Check Spelling" onClick="spell('document.wrk.mob_descr.value')">
									<br>
									<input type="submit" name="add_mob"
									<cfif isdefined("url.target") and url.target EQ "mob">
										value="Update"
									<cfelse>
										value="Add"
									</cfif>
									class="AddButton" onClick="return checkCOMMMOB();">
									<br>
									<br>
									</td>
								</tr>
								<cfif QgettargMOB.recordcount GT 0>
									<cfoutput>
										<tr>
											<td colspan=
											<cfif session.fy GTE 2015>
												3
											<cfelse>
												2
											</cfif>
											>
											<table class="box" border=".1" width=800>
												<a name="media2">
												</a>
												<tr>
													<th>
														Target Organization Name
													</th>
													<cfif session.fy GTE 2015>
														<th>
															Target Org
														</th>
													</cfif>
													<th>
														How did this target help advance/achieve a Health Systems Change outcome this month?
													</th>
													<th>
														Delete
													</th>
												</tr>
												<cfloop query="QgettargMOB">
													<tr>
														<td bgcolor="##E9FBEC">
															<a href="javascript: document.wrk.action='month.cfm?#session.urltoken#&target=mob&seq=#QgettargMOB.monthlycommmobID###mob'; document.wrk.submit()">
																#QgettargMOB.name#
															</a>
														</td>
														<cfif session.fy GTE 2015>
															<td  bgcolor="##E9FBEC">
																<cfif isdefined("qgettargmob.group") and qgettargmob.group is not ''>
																	<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="getgrouptxt">
	select targmhs from hsc where id in (#QgettargMOB.group#)
</cfquery>
																	<cfloop query="getgrouptxt">
																		#getgrouptxt.targmhs#
																		<br>
																	</cfloop>
																	<cfset numList = ListValueCountNoCase(QgettargMOB.group,0)>
																	<cfif #numList# GT 0>
																		Other
																	</cfif>
															</td>
															</cfif>
														</cfif>
														<td align="left" bgcolor="##E9FBEC">
															#QgettargMOB.descr#
														</td>
														<td valign="top" bgcolor="##E9FBEC" align="center">
															<input type="Checkbox" name="Del_boxMOB" value="#QgettargMOB.monthlycommmobID#">
														</td>
												</cfloop>
												<tr>
													<td colspan=6 align="right">
														<input type="submit" name="del_MOB" value="Delete" onClick="javascript: document.wrk.action='month.cfm?#session.urltoken###mob'; return checkMGG();" class="DelButton">
													</td>
												</tr>
											</table>
											</td>
										</tr>
									</cfoutput>
								</cfif>
							</table>
							<br>
						</td>
					</tr>
				</cfif>
				<!--- <cfif #getverk.media# is 1> --->
				<cfif #getverk.media# neq 111  and session.objval NEQ "8A" and session.objval NEQ "8B" and #getverk.media# EQ 1>
					<tr>
						<th align="left" width="800">
							<br>
							<a name="pm">
							</a>
							<h6>
								Paid Media
							</h6>
						</th>
					</tr>
					<cfoutput>
						<tr>
							<td>
								<table class="boxyw" border=".1" width=800>
									<tr>
										<td width="20%">
											<strong>
												Media type
											</strong>
											</th>
										<th>
											<strong>
												Name of media channel(s)
											</strong>
										</th>
										<th>
											<strong>
												Title of spot
											</strong>
										</th>
										<th>
											<strong>
												Number run/ aired/ printed this month
											</strong>
										</th>
										<th>
											<strong>
												Cost
											</strong>
										</th>
									</tr>
									<cfoutput>
										<tr>
											<td>
												<select name="mediatype">
													<option value="">
														Please select
													</option>
													<option value="Billboard"
													<cfif (isDefined("url.target") and url.target EQ "media") and QgettargXXXs.mediatype EQ "Billboard">
														selected
													</cfif>
													>Billboard</option> <option value="Digital/website"
													<cfif (isDefined("url.target") and url.target EQ "media") and QgettargXXXs.mediatype EQ "Digital/website">
														selected
													</cfif>
													>Digital/website</option> <option value="Magazine"
													<cfif (isDefined("url.target") and url.target EQ "media") and QgettargXXXs.mediatype EQ "Magazine">
														selected
													</cfif>
													>Magazine</option> <option value="Newspaper"
													<cfif (isDefined("url.target") and url.target EQ "media") and QgettargXXXs.mediatype EQ "Newspaper">
														selected
													</cfif>
													>Newspaper</option> <option value="Radio"
													<cfif (isDefined("url.target") and url.target EQ "media") and QgettargXXXs.mediatype EQ "Radio">
														selected
													</cfif>
													>Radio</option> <option value="Theater slide"
													<cfif (isDefined("url.target") and url.target EQ "media") and QgettargXXXs.mediatype EQ "Theater slide">
														selected
													</cfif>
													>Theater slide</option> <option value="Transit"
													<cfif (isDefined("url.target") and url.target EQ "media") and QgettargXXXs.mediatype EQ "Transit">
														selected
													</cfif>
													>Transit</option> <option value="TV"
													<cfif (isDefined("url.target") and url.target EQ "media") and QgettargXXXs.mediatype EQ "TV">
														selected
													</cfif>
													>TV</option>
												</select>
											</td>
											<td align="center">
												<input type="text" size=40 maxlength=40 name="mediachannel"
												<cfif (isDefined("url.target") and url.target EQ "media")>
													value="#QgettargXXXs.mediachannel#"
												</cfif>
												>
											</td>
											<td align="center">
												<input type="text" size=40 maxlength=40 name="spottitle"
												<cfif (isDefined("url.target") and url.target EQ "media")>
													value="#QgettargXXXs.spottitle#"
												</cfif>
												>
											</td>
											<td align="center">
												<input type="text" size=8 maxlength=7 name="number"
												<cfif (isDefined("url.target") and url.target EQ "media")>
													value="#QgettargXXXs.number#"
												</cfif>
												>
											</td>
											<td align="left">
												<input type="text" size=9 maxlength=8 name="cost"
												<cfif (isDefined("url.target") and url.target EQ "media")>
													value="#QgettargXXXs.cost#"
												</cfif>
												>
											</td>
										</tr>
									</cfoutput>
									<tr>
										<Td colspan=5>
											<cfif isDefined("url.target") and url.target EQ "media">
												<input type="button" value="Check Spelling" onClick="spell('document.wrk.mediachannel.value'),spell('document.wrk.spottitle.value')">
												<br>
												<input type="submit" name="addpaidmedia" value="Update" class="AddButton" onClick="return checkDG();">
											<cfelse>
												<input type="button" value="Check Spelling" onClick="spell('document.wrk.mediachannel.value'),spell('document.wrk.spottitle.value')">
												<br>
												<input type="submit" name="addpaidmedia" value="Add" class="AddButton" onClick="return checkDG();">
											</cfif>
										</td>
									</tr>
									<cfif Qmediaorg.recordcount GT 0>
										<tr>
											<td colspan=5>
												<table class="box" border=".1" width=800>
													<a name="media2">
													</a>
													<tr>
														<th>
															Media type
														</th>
														<th>
															Name of media channel(s)
														</th>
														<th>
															Title of spot
														</th>
														<th>
															Number run/aired/printed this month
														</th>
														<th>
															Cost
														</th>
														<th>
															Delete
														</th>
													</tr>
													<cfloop query="qmediaorg">
														<tr>
															<td bgcolor="##E9FBEC">
																<a href="javascript: document.wrk.action='month.cfm?#session.urltoken#&target=media&seq=#qmediaorg.monthlymediaid###pm'; document.wrk.submit()">
																	#qmediaorg.mediatype#
																</a>
															</td>
															<td align="center" bgcolor="##E9FBEC">
																#qmediaorg.mediachannel#
															</td>
															<td align="center" bgcolor="##E9FBEC">
																#qmediaorg.spottitle#
															</td>
															<td align="center" bgcolor="##E9FBEC">
																#qmediaorg.number#
															</td>
															<td align="left" bgcolor="##E9FBEC">
																#qmediaorg.cost#
															</td>
															<td valign="top" bgcolor="##E9FBEC" align="center">
																<input type="Checkbox" name="Del_boxPM" value="#qmediaorg.monthlymediaid#">
															</td>
													</cfloop>
													<tr>
														<td colspan=6 align="right">
															<input type="submit" name="del_PM" value="Delete" onClick="javascript: document.wrk.action='month.cfm?#session.urltoken###pm'; return checkMGG();" class="DelButton">
														</td>
													</tr>
												</table>
											</td>
										</tr>
									</cfif>
								</table>
							</td>
						</tr>
					</cfoutput>
				</cfif>

				<cfif #getverk.advoc# NEQ 99  and session.objval NEQ "8A" and session.objval NEQ "8B"<!--- and #getverk.dcs# EQ 1--->>
					<tr>
						<th align="left" width="800">
							<br>
							<br>
							<a name="dcs">
							</a>
							<h6>
							Direct Cessation Services
							<br>
							<br>
						</th>
					</tr>
					<cfoutput>
						<tr>
							<td>
								<table class="boxyw" width=800>
									<tr>
										<th>
											<cfif session.modality eq 1>
												Organization
											<cfelse>
												Location
											</cfif>
										</th>
										<th>
											<cfif session.modality eq 1>
												Quantity of NRT
											<cfelse>
												Number of Sessions
											</cfif>
										</th>
										<cfif session.modality neq 1>
											<th>
												Number of participants
											</th>
										</cfif>
										<th>
											Description
										</th>
									</tr>
									<tr>
										<td align="center">
											<input type="text" name="dcs_loc" size="25"
											<cfif isDefined("QgettargDCS2")>
												value="#QgettargDCS2.location#"
											</cfif>
											>
										</td>
										<td align="center">
											<input type="text" name="dcs_numses" size="5"
											<cfif isDefined("QgettargDCS2")>
												value="#QgettargDCS2.numsess#"
											</cfif>
											>
										</td>
										<cfif session.modality neq 1>
											<td align="center">
												<input type="text" name="dcs_numpart" size="5"
												<cfif isDefined("QgettargDCS2")>
													value="#QgettargDCS2.numpart#"
												</cfif>
												>
											</td>
										</cfif>
										<td align="center">
											<textarea name="dcs_descr" id="dcs_descr" cols="55" rows="4" onkeyup="countitAny(this.id, 'Cdcs_descr')"><cfif isDefined("QgettargDCS2")>#QgettargDCS2.descr#</cfif></textarea>
											<br>
											<div align="right" valign="bottom">
											This text field has a max of 2500 characters. Characters entered:
											<cfoutput>
												<input type="text" value="" name="Cdcs_descr" id="Cdcs_descr" size="4" style="border:0;" disabled>
											</cfoutput>
										</td>
									</tr>
									<tr>
										<Td colspan="4">
											<input type="button" value="Check Spelling" onClick="spell('document.wrk.dcs_descr.value')">
											<br>
											<input type="submit" name="add_dcs"
											<cfif isDefined("url.target") and url.target EQ "DCS" >
												value="Update"
											<cfelse>
												value="Add"
											</cfif>
											class="AddButton" onClick="return checkDCS();">
											<br>
											<br>
											<!--- <cfif isDefined("QgettargDCS") and isDefined("url.seq")>
												<input type="button" value="Check Spelling" onClick="spell('document.wrk.dcs_descr.value')">
												<br><input type="submit" name="add_dcs" value="Update" class="AddButton" onClick="return checkDG();">
											<cfelse>
												<input type="button" value="Check Spelling" onClick="spell('document.wrk.dcs_descr.value')">
												<br><input type="submit" name="add_dcs" value="Add" class="AddButton" onClick="return checkDG();">
												</cfif> --->
										</td>
									</tr>
									<cfif QgettargDCS.recordcount GT 0>
										<tr>
											<td colspan=5>
												<table class="box" border=".1" width=800>
													<!--- <a name="dcs"></a> --->
													<tr>
														<th>
															<cfif session.modality eq 1>
																Organization
															<cfelse>
																Location
															</cfif>
														</th>
														<th>
															<cfif session.modality eq 1>
																Quantity of NRT
															<cfelse>
																Number of Sessions
															</cfif>
														</th>
														<cfif session.modality neq 1>
															<th>
																Number of Participants
															</th>
														</cfif>
														<th>
															Description
														</th>
														<th>
															Delete
														</th>
													</tr>
													<cfloop query="QgettargDCS">
														<tr>
															<td bgcolor="##E9FBEC">
																<a href="javascript: document.wrk.action='month.cfm?#session.urltoken#&target=dcs&seq=#QgettargDCS.monthlydcsid###dcs'; document.wrk.submit()">
																	#QgettargDCS.location#
																</a>
															</td>
															<td align="center" bgcolor="##E9FBEC">
																#QgettargDCS.numSess#
															</td>
															<cfif session.modality neq 1>
																<td align="center" bgcolor="##E9FBEC">
																	#QgettargDCS.numPart#
																</td>
															</cfif>
															<td align="center" bgcolor="##E9FBEC">
																#QgettargDCS.Descr#
															</td>
															<td valign="top" bgcolor="##E9FBEC" align="center">
																<input type="Checkbox" name="Del_boxDCS" value="#QgettargDCS.monthlydcsid#">
															</td>
													</cfloop>
													<tr>
														<td colspan=6 align="right">
															<input type="submit" name="del_DCS" value="Delete" onClick="javascript: document.wrk.action='month.cfm?#session.urltoken###dcs';" class="DelButton">
														</td>
													</tr>
												</table>
											</td>
										</tr>
									</cfif>
								</table>
							</td>
						</tr>
					</cfoutput>
				</cfif>
			</cfif>
			<!--- community ed --->
			<cfif #getverk.comm# is 1>
				<tr>
					<td>
						<table class="boxs" width=800>
							<tr>
								<td height=10>
								</td>
							</tr>
							<th align="left">
								<a name="comm">
								</a>
								<h6>
								Community Education
							</th>
							<tr>
								<td height=10>
								</td>
							</tr>
							<tr>
								<td>
									<table class="boxyw" border=".1" width="100%">
										<a name="targ">
										</a>
										<tr>
											<th width="250">
												<strong>
													Target Name
												</strong>
											</th>
											<th width="250">
												<strong>
													Select the categories which best describe the focus of your community education
												</strong>
											</th>
											<th colspan="3">
												<strong>
													Brief description of community education, including barriers and next steps
												</strong>
											</th>
										</tr>
										<tr>
											<td>
												<select name="commed_target"  onchange="" >
													<option value="" selected>
														Please select
													</option>
													<cfoutput>
														<cfif attributes.obj2 NEQ '1A'>
															<cfloop query="COMMED_Qtargorg">
																<option value="#targid#"
																<cfif isDefined("url.target") and url.target EQ "comm" and QgettargCOM2.target EQ #targid#>
																	selected
																</cfif>
																>#name#</option>
															</cfloop>
														<cfelse>
															<cfloop query="COMMED_Qtargchc">
																<option value="#targchcid#"
																<cfif isDefined("url.target") and url.target EQ "comm" and QgettargCOM2.target2 EQ #targchcid#>
																	selected
																</cfif>
																>#name#: #targsite#</option>
															</cfloop>
														</cfif>
													</cfoutput>
												</select>
											</td>
											<td>
												<table class="boxyw" width="100%">
													<tr>
														<td colspan="2">
															Select all that apply:
														</td>
													</tr>
													<tr>
														<td colspan="2">
															<input name="comm_staff" type="checkbox" value="1"
															<cfif isDefined("url.target") and url.target EQ "comm" and QgettargCOM2.staff EQ 1>
																checked="checked"
															</cfif>
															> Staff training needs assessment
														</td>
													</tr>
													<!--- <cfif obj NEQ '1E'>
														<tr>
														<td>&nbsp;</td>
														<td><input type="checkbox" value="1"> Site systems change point person identified</td>
														</tr>
														</cfif>
														<tr>
														<td>&nbsp;</td>
														<td><input type="checkbox" value="1"> Site systems change committee identified</td>
														</tr> --->
													<tr>
														<td colspan=2>
															<input name="comm_train" type="checkbox" value="1"
															<cfif isDefined("url.target") and url.target EQ "comm" and QgettargCOM2.train EQ 1>
																checked="checked"
															</cfif>
															> Training
														</td>
													</tr>
													<tr>
														<td colspan=2>
															<input name="comm_ta" type="checkbox" value="1"
															<cfif isDefined("url.target") and url.target EQ "comm" and QgettargCOM2.ta EQ 1>
																checked="checked"
															</cfif>
															> Technical assistance
														</td>
													</tr>
													<tr>
														<td colspan=2>
															<input name="comm_nrt" type="checkbox" value="1"
															<cfif isDefined("url.target") and url.target EQ "comm" and QgettargCOM2.nrt EQ 1>
																checked="checked"
															</cfif>
															> NRT, Stipend, mini-grant
														</td>
													</tr>
													<cfif session.objval EQ "1G">
														<tr>
															<td colspan=2>
																<input name="comm_tfo" type="checkbox" value="1"
																<cfif isDefined("url.target") and url.target EQ "comm" and QgettargCOM2.tfo EQ 1>
																	checked="checked"
																</cfif>
																> Tobacco Free Outdoors
															</td>
														</tr>
													</cfif>
												</table>
											</td>
											<td colspan="3">
												<textarea name="comm_descr" id="comm_descr" cols="45" rows="4" onkeyup="countitAny(this.id, 'Ccomm_descr')"><cfif isDefined("url.target") and url.target EQ "comm"><cfoutput>#QgettargCOM2.descr#</cfoutput></cfif>
												</textarea>
												<br>
												<div align="right" valign="bottom">
												This text field has a max of 2500 characters. Characters entered:
												<cfoutput>
													<input type="text" value="" name="Ccomm_descr" id="Ccomm_descr" size="4" style="border:0;" disabled>
												</cfoutput>
											</td>
										</tr>
										<tr>
											<td colspan="5">
												<input type="button" value="Check Spelling" onClick="spell('document.wrk.comm_descr.value')">
												<br>
												<input type="submit" name="add_commed"
												<!--- <cfif  (((isdefined("form.targ2") and form.targ2 NEQ "") or isdefined("url.targ2") or (isDefined("session.targ2") and session.targ2 NEQ "")) and (isDefined("selcollab3.recordcount") and selcollab3.recordcount NEQ 0))>value="Update" <cfelse> value="Add"</cfif> class="AddButton" onclick="return checkPPG();"> --->
												<cfif isDefined("url.target") and url.target EQ "comm">
													value="Update"
												<cfelse>
													value="Add"
												</cfif>
												class="AddButton" onclick="return checkED();">
												<br>
												<br>
											</td>
										</tr>
										<cfif QgettargComm.recordcount GT 0>
											<cfoutput>
												<!--- <tr><td colspan=4>
													<table class="box" border=".1" width=775> --->
												<!--- <a name="dcs"></a> --->
												<tr>
													<th colspan="2">
														<strong>
														Target Name
													</th>
													<th>
														<strong>
														Categories
													</th>
													<th>
														<strong>
														Brief Description
													</th>
													<th>
														<strong>
														Delete
													</th>
												</tr>
												<cfloop query="QgettargComm">
													<tr>
														<td colspan="2" bgcolor="##E9FBEC">
															<a href="javascript: document.wrk.action='month.cfm?#session.urltoken#&target=comm&seq=#QgettargComm.monthlycommid###comm'; document.wrk.submit()">
																#QgettargComm.name#
															</a>
														</td>
														<td  bgcolor="##E9FBEC">
															<!--- #QgettargComm.numSess# --->
															<cfif QgettargComm.staff EQ 1>
																Staff training needs assessment
																<br>
															</cfif>
															<cfif QgettargComm.train EQ 1>
																Training
																<br>
															</cfif>
															<cfif QgettargComm.ta EQ 1>
																Technical assistance
																<br>
															</cfif>
															<cfif QgettargComm.nrt EQ 1>
																NRT, Stipend, mini-grant
																<br>
															</cfif>
															<cfif QgettargComm.tfo EQ 1>
																Tobacco Free Outdoors
																<br>
															</cfif>
														</td>
														<td  bgcolor="##E9FBEC">
															#QgettargComm.Descr#
														</td>
														<td valign="top" bgcolor="##E9FBEC" align="center">
															<input type="Checkbox" name="Del_boxCOMM" value="#QgettargComm.monthlycommid#">
														</td>
												</cfloop>
												<tr>
													<td colspan=5 align="right">
														<input type="submit" name="del_comm" value="Delete" onClick="javascript: document.wrk.action='month.cfm?#session.urltoken###comm'; return checkDCS();" class="DelButton">
													</td>
												</tr>
												<!--- </table>
													</td></tr> --->
											</cfoutput>
										</cfif>
									</table>
								</td>
							</tr>
							<tr>
								<td>
									<br>
									<br>
								</td>
							</tr>
			</cfif>
			<br><br> <cfoutput> <tr><td colspan=4> <table class="boxy" width="800"> <cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QInsMob">
select isNull(dispar,0) as dispar from wrkplan
where userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
and year2= <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
and initnum = <cfqueryparam value="#session.objval#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
</cfquery>
<cfif session.fy GTE 2015 and (attributes.obj2 EQ '8A' OR attributes.obj2 EQ '8B') and QInsMob.dispar EQ 1> <tr><th align="left" height=30 valign="bottom"><h6>Summary of Disparities Project activities:</th></tr> <tr> <td width=700><textarea name="disparities" cols=145 rows=14 onKeyup="countit4(this)"><cfif isDefined("form.disparities") and form.disparities NEQ "">#form.disparities#<cfelse>#mon.disparities#</cfif></textarea> </td></tr> <tr><td height=30><input type="button" value="Check Spelling" onClick="spell('document.wrk.disparities.value', 'document.wrk.disparities.value')"></td></tr> <tr> <td width="100%" valign="bottom"><div align="right" valign="bottom">This text field has a max of 2000 characters. Characters entered: <cfoutput><input type="text" value="#len(mon.disparities)#" name="dispdisplaycount" size="4" style="border:0;" disabled></cfoutput></td> </tr> </cfif> <tr><th align="left" height=30 valign="bottom"><h6>Summary of activities this month:</th></tr> <tr> <td width=805><textarea name="summary" cols=145 rows=14 onKeyup="countit(this)"><cfif isDefined("form.summary") and form.summary NEQ "">#form.summary#<cfelse>#mon.summary#</cfif></textarea> </td></tr> <tr><td height=30><input type="button" value="Check Spelling" onClick="spell('document.wrk.summary.value', 'document.wrk.summary.value')"></td></tr> <tr> <td width="100%" valign="bottom"><div align="right" valign="bottom">This text field has a max of 4000 characters. Characters entered: <cfoutput><input type="text" value="#len(mon.summary)#" name="summdisplaycount" size="4" style="border:0;" disabled></cfoutput></td> </tr> <cfif attributes.obj2 NEQ '1H'> <tr><th align="left" height=30 valign="bottom"><h6>Barriers encountered this month:</th></tr> <tr> <td width=700><textarea name="barriers" cols=145 rows=14 onKeyup="countit2(this)"><cfif isDefined("form.barriers") and form.barriers NEQ "">#form.barriers#<cfelse>#mon.barriers#</cfif></textarea> </td></tr> <tr><td height=30><input type="button" value="Check Spelling" onClick="spell('document.wrk.barriers.value', 'document.wrk.barriers.value')"></td></tr> <tr> <td width="100%" valign="bottom"><div align="right" valign="bottom">This text field has a max of 1000 characters. Characters entered: <cfoutput><input type="text" value="#len(mon.barriers)#" name="barrdisplaycount" size="4" style="border:0;" disabled></cfoutput></td> </tr> <tr><th align="left" height=30 valign="bottom"><h6>Next steps:</th></tr> <tr> <td width=700><textarea name="steps" cols=145 rows=14 onKeyup="countit3(this)"><cfif isDefined("form.steps") and form.steps NEQ "">#form.steps#<cfelse>#mon.steps#</cfif></textarea> </td></tr> <tr><td><input type="button" value="Check Spelling" onClick="spell('document.wrk.steps.value', 'document.wrk.steps.value')"> <tr> <td width="100%" valign="bottom"><div align="right" valign="bottom">This text field has a max of 1000 characters. Characters entered: <cfoutput><input type="text" value="#len(mon.steps)#" name="stepdisplaycount" size="4" style="border:0;" disabled></cfoutput></td> </tr> </cfif> </cfoutput> <input type="hidden" name="dofunction" value="addUpd"> <tr><td align="center" height=20><p><input type="submit" name="return" value="Save" <!--- <cfif #session.objval# is '6B'>onClick="checkLG();"<cfelseif #session.objval# is '1E'>onClick="return checkAAG();"<cfelse>onClick="return checkSG();"</cfif> ---> onClick="return checkCC();"></td></tr> <tr><td>&nbsp;</td></tr> <tr><td align="center" height=20><p><input type="submit" name="return" value="Save and return to Monthly Reporting" <!--- <cfif #session.objval# is '6B'>onClick="checkLG();"<cfelseif #session.objval# is '1E'>onClick="return checkAAG();"<cfelse>onClick="return checkSG();"</cfif> ---> onClick="return checkCC();"></td></tr> </table> </td></tr></table>
		</cfform>
		<cfif session.readOnly EQ 1> <script language="JavaScript">
	function disableme(){
for(var intloop=0; intloop <document.wrk.length; intloop++){
	if(document.wrk[intloop].type=='textarea'){
	document.wrk[intloop].readOnly = true;
	}
	else
document.wrk[intloop].disabled=true;
}
}

	disableme();
</script> </cfif>
	</body>
</html>

