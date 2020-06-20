<style>
	.box { font-family: verdana, helvetica, sans-serif; font-size: 11px; border: solid 1px #CCCC99; list-style:inherit; border-collapse: collapse; } .boxy { font-family: verdana, helvetica, sans-serif; font-size: 11px; list-style:inheritborder-color : #498F49; border-collapse: collapse; } .box2 { font-family: verdana, helvetica, sans-serif; font-size: 11px; border: none; list-style:inherit; border-collapse: collapse; }
</style>
<SCRIPT LANGUAGE="JavaScript" SRC="scripts/cfform.js"> </SCRIPT>
<SCRIPT LANGUAGE="JavaScript">

function disableme(){
for(var intloop=0; intloop <document.wrk.length; intloop++){
	if(document.wrk[intloop].type=='textarea'){
	document.wrk[intloop].readOnly = true;
	}
	else
document.wrk[intloop].disabled=true;
}
}
  function countit(what){
	if(typeof what.form.infradesc != "undefined"){
formcontent=what.form.infradesc.value;
what.form.infradisplaycount.value=formcontent.length;
 }
	if(typeof what.form.susdesc != "undefined"){
formcontent2=what.form.susdesc.value;
what.form.infrasuscount.value=formcontent2.length;
	}
	if(typeof what.form.meet != "undefined"){
formcontent3=what.form.meet.value;
what.form.infraMeetcount.value=formcontent3.length;
	}

if(typeof what.form.fdadesc != "undefined"){
formcontent4=what.form.fdadesc.value;
what.form.fdacount.value=formcontent4.length;
	}

if(typeof what.form.dsripdesc != "undefined"){
formcontent5=what.form.dsripdesc.value;
what.form.dsripcount.value=formcontent5.length;
	}
if(typeof what.form.dispartxt != "undefined"){
formcontent6=what.form.dispartxt.value;
what.form.dispardisplaycount.value=formcontent6.length;
	}

}
    function toggle_visibility1(id) {
 	     var e = document.getElementById(id);
	     var train = document.wrk.train.value;

		 if(train == 7){
       if(e.style.display == 'block')
          e.style.display = 'none';
       else
          e.style.display = 'block';
		  }
		  else
		  {
		  e.style.display = 'none';
		  }
}

 function checkLG(){
 var summm = document.wrk.infradisplaycount.value * 1
 var idesc = document.wrk.infradesc.value
 <cfif session.fy GT 2017 and session.modality NEQ 2 >
 if (typeof document.wrk.dsripdesc != 'undefined' ){
 	var DSRIPD = document.wrk.dsripdesc.value
 }
 </cfif>

 var maxxx = document.wrk.maxxx.value * 1
 var legvisit = document.wrk.legvisit.value
 <cfif session.fy GTE 2012>
if(document.wrk.meet.value.length > 1000){
	<cfif session.modality EQ 2>
			alert('ATFC meetings details cannot exceed 1000 characters.');
<cfelseif session.modality EQ 3>
		alert('Youth meetings and trainings details cannot exceed 1000 characters.');
	<cfelse>
	alert('Health Systems Change meetings and workgroup activity text cannot exceed 1000 characters.');
	</cfif>
return false;
}

if(document.wrk.dispartxt.value.length > 1950){
		alert('Disparities Project Summary of Activities cannot exceed 1950 characters.');
return false;
}
</cfif>

<cfif session.fy GT 2017 and session.modality NEQ 2 >
if (typeof document.wrk.dsripdesc != 'undefined' ){
 if (DSRIPD == '')
 {
 alert('Please enter DSRIP details');
 return false;
 }
}
</cfif>
 if (idesc == '')
 {
 alert('Please enter infrastructure details');
 return false;
 }

 if (summm > maxxx)
{
alert('Infrastructure details cannot exceed 2000 characters.');
return false;
}
add('addLG');
}
function checkOG(){
 var twain = document.wrk.train.value
 if (twain == '')
 {
 alert('Please select training name');
 return false;
 }
add('addOG');
}
function add(actvalue){
document.wrk.dofunction.value=actvalue;
return true;}
</SCRIPT>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>
			CAT
		</title>
	<body>
		<cfinclude template="CATstruct.cfm">
		<script language="JavaScript" src="../spellchecker/spell.js"></script>
		<cfparam name="form.dofunction" default="">
		<cfparam name="form.train" default="">
		<cfparam name="form.trainoth" default="">
		<cfparam name="form.tcp1" default="">
		<cfparam name="form.tcp2" default="">
		<cfparam name="form.meet" default="">
		<cfparam name="form.ypmemb" default="">
		<cfparam name="form.legvisit" default="">
		<cfparam name="form.legcorr" default="">
		<cfparam name="form.mediarep" default="">
		<cfparam name="form.numsub" default="">
		<cfparam name="form.numpub" default="">
		<cfparam name="form.fdacomm" default="">
		<cfparam name="form.postdock" default="">
		<cfparam name="form.susdesc" default="">
		<cfparam name="form.infradesc" default="">
		<cfparam name="form.fdadesc" default="">
		<cfparam name="session.monum" default="0">
		<cfparam name="form.maxxx" default="2000">
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
		<cfif session.monum is 5 and session.modality is 4>
			<cfset maxxx = 2000>
		<cfelse>
			<cfset maxxx = 2000>
		</cfif>
		<cfif isdefined("del_box")>
			<cfloop index="x" list="#del_box#">
				<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="del">
	delete from infras where infraid = <cfqueryparam value="#x#" cfsqltype="CF_SQL_INTEGER">
	</cfquery>
			</cfloop>
		</cfif>
		<cfif form.dofunction is 'addOG'>
			<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QInsCG">
insert into infras
(userid, year2,  mon, train
<cfif isdefined("form.trainoth")>,specify</cfif>)
values
(<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">, <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">, <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">,<cfqueryparam value="#form.train#" cfsqltype="CF_SQL_INTEGER">
<cfif isdefined("form.trainoth")>,<cfqueryparam value="#form.trainoth#" cfsqltype="CF_SQL_VARCHAR" maxlength="500"></cfif>)
</cfquery>
			<cfset form.train = ''>
			<cfset getinfra.train = ''>
		</cfif>
		<cfif form.dofunction is 'addLG' or form.dofunction is 'addOG'>
			<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="inf">
select * from infra
where
	userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and mon= <cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
	and modality = <cfqueryparam value="#session.modality#" cfsqltype="CF_SQL_INTEGER">
	</cfquery>
			<cfif inf.recordcount is 0>
				<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QInsSE">
insert into infra
(userid, year2,  modality,train,trainoth,tcp1,tcp2,meet,ypmemb,legvisit,legcorr,mediarep,numsub,numpub,fdacomm,fdadesc,postdock,susdesc,infradesc, mon
<cfif isdefined("form.DSRIPDESC")>, DSRIPDESC</cfif>
<cfif isdefined("form.dispartxt")>, dispartxt</cfif>)
values
(<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">,
<cfqueryparam value="#session.modality#" cfsqltype="CF_SQL_INTEGER">,
<cfqueryparam value="#form.train#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.train))#">,
<cfqueryparam value="#form.trainoth#" cfsqltype="CF_SQL_VARCHAR" maxlength="500">,
<cfqueryparam value="#form.tcp1#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.tcp1))#">,
<cfqueryparam value="#form.tcp2#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.tcp2))#">,
<cfqueryparam value="#form.meet#" cfsqltype="CF_SQL_VARCHAR" maxlength="2000">,
<cfqueryparam value="#form.ypmemb#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.ypmemb))#">,
<cfqueryparam value="#form.legvisit#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.legvisit))#">,
<cfqueryparam value="#form.legcorr#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.legcorr))#">,
<cfqueryparam value="#form.mediarep#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.mediarep))#">,
<cfqueryparam value="#form.numsub#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.numsub))#">,
<cfqueryparam value="#form.numpub#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.numpub))#">,
<cfqueryparam value="#form.fdacomm#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.fdacomm))#">,
<cfqueryparam value="#form.fdadesc#" cfsqltype="CF_SQL_VARCHAR" maxlength="2000">,
<cfqueryparam value="#form.postdock#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.postdock))#">,
<cfqueryparam value="#form.susdesc#" cfsqltype="CF_SQL_VARCHAR" maxlength="2000">,
<cfqueryparam value="#form.infradesc#" cfsqltype="CF_SQL_VARCHAR" maxlength="2900">,
<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
<cfif isdefined("form.DSRIPDESC")>,
<cfqueryparam value="#form.DSRIPDESC#" cfsqltype="CF_SQL_VARCHAR" maxlength="2000">
</cfif>
<cfif isdefined("form.dispartxt")>,
<cfqueryparam value="#form.dispartxt#" cfsqltype="CF_SQL_VARCHAR" maxlength="2000">
</cfif>
)
</cfquery>
			<cfelse>
				<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QupdSE">
	update infra set
	userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	,train = <cfqueryparam value="#form.train#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.train))#">
	,trainoth = <cfqueryparam value="#form.trainoth#" cfsqltype="CF_SQL_VARCHAR" maxlength="500">
	,tcp1 = <cfqueryparam value="#form.tcp1#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.tcp1))#">
	,tcp2 = <cfqueryparam value="#form.tcp2#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.tcp2))#">
	,meet = <cfqueryparam value="#form.meet#" cfsqltype="CF_SQL_VARCHAR" maxlength="2000">
	,ypmemb = <cfqueryparam value="#form.ypmemb#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.ypmemb))#">
	,legvisit = <cfqueryparam value="#form.legvisit#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.legvisit))#">
	,legcorr = <cfqueryparam value="#form.legcorr#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.legcorr))#">
	,mediarep = <cfqueryparam value="#form.mediarep#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.mediarep))#">
	,numsub = <cfqueryparam value="#form.numsub#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.numsub))#">
	,numpub = <cfqueryparam value="#form.numpub#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.numpub))#">
	,fdacomm = <cfqueryparam value="#form.fdacomm#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.fdacomm))#">
	,fdadesc = <cfqueryparam value="#form.fdadesc#" cfsqltype="CF_SQL_VARCHAR" maxlength="2000">
	,postdock = <cfqueryparam value="#form.postdock#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.postdock))#">
	,susdesc = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.susdesc#">
	,infradesc =<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.infradesc#">
	<cfif isDefined("form.DSRIPDESC")>
	,DSRIPDESC =<cfqueryparam cfsqltype="CF_SQL_VARCHAR" maxlength="2000" value="#form.DSRIPDESC#">
	</cfif>
	<cfif isDefined("form.dispartxt")>
	,dispartxt =<cfqueryparam cfsqltype="CF_SQL_VARCHAR" maxlength="2000" value="#form.dispartxt#">
	</cfif>

	where
	infraid=<cfqueryparam value="#inf.infraid#" cfsqltype="CF_SQL_INTEGER">
	and mon=<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
	</cfquery>
			</cfif>
			<cfif form.dofunction is 'addLG'>
				<cfif isDefined("form.return") and form.return EQ "Save and return to Monthly Reporting">
					<cfif session.modality EQ 4>
						<cflocation url="monthrepsp.cfm" addtoken="true">
					<cfelse>
						<cflocation url="monthrep.cfm" addtoken="true">
					</cfif>
				</cfif>
			</cfif>
		</cfif>
		<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="getinfra">
select * from infra
where
	userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and modality = <cfqueryparam value="#session.modality#" cfsqltype="CF_SQL_INTEGER">
	and mon=<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
</cfquery>
<cfif isdefined("session.origuserid") and #session.fy# eq '2019' and (#session.origuserid# is 'nsarris' or #session.origuserid# is 'twills' or #session.origuserid# is 'dplotner' or #session.origuserid# is 'cschnefke')>
		<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="Q">
select
	traintxt as tname, ii.train,isNull(specify, '') as otherspec,infraid
	from infras i inner join infratrain ii on i.train = ii.train and i.year2 = ii.year2
	where
	userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and ii.year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and i.mon=<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
	and initnum = <cfqueryparam value="#session.modality#" cfsqltype="CF_SQL_varchar" maxlength="5">
	order by traintxt
</cfquery>
<cfelse>
		<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="Q">
select
	*, isNull(specify, '') as otherspec
	from infras
	where
	userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	and mon=<cfqueryparam value="#session.monum#" cfsqltype="CF_SQL_INTEGER">
</cfquery>
</cfif>
		<cfif isdefined("obj") and #obj# is not ''>
			<cfset session.objval = '#obj#'>
		</cfif>
		<p>
		</p>
		<table class="box2" width=775>
			<tr>
				<cfoutput>
					<td align="left">
						<h3>
						Infrastructure Monthly Report for #session.mon#</h4>
					</td>
				</cfoutput>
			</tr>
		</table>
		<cfform name="wrk" action="infra.cfm?#session.urltoken#">
			<input type="hidden" name="conf" value="">
			<input type="hidden" name="dofunction" value="">
			<cfoutput>
				<input type="hidden" name="maxxx" value="#maxxx#">
				<table class="box" width=775>
					<tr>
						<td>
							<table class="box2" border=".1" width=775>
								<tr>
									<td align="left" colspan=2>
										<strong>
											Training Received
										</strong>
									</td>
								</tr>
								<a name="targ">
								</a>
								<tr>
									<td colspan=2>
										<!--- Training name
										<br> --->
										<select name="train" onchange="toggle_visibility1('myObject');">
											<option value=""
											<cfif #form.train# is ''>
												selected
											</cfif>
											>Please select</option>
											<cfif session.fy GT 2017 and session.modality EQ 2>
												<option value="60"
												<cfif form.train is 60>
													selected
												</cfif>
												> ATFC Institute - Online
												<option value="61"
												<cfif form.train is 61>
													selected
												</cfif>
												> ATFC Institute - Webinar
												<option value="62"
												<cfif form.train is 62>
													selected
												</cfif>
												> ATFC Institute - In-person
												<option value="63"
												<cfif form.train is 63>
													selected
												</cfif>
												> HS Institute - Online
												<option value="64"
												<cfif form.train is 64>
													selected
												</cfif>
												> HS Institute - Webinar
												<option value="65"
												<cfif form.train is 65>
													selected
												</cfif>
												> HS Institute - In-Person
												<option value="66"
												<cfif form.train is 66>
													selected
												</cfif>
												> Director Track - Online
												<option value="67"
												<cfif form.train is 67>
													selected
												</cfif>
												> Director Track - Webinar
												<option value="68"
												<cfif form.train is 68>
													selected
												</cfif>
												> Director Track - In-person
												<option value="69"
												<cfif form.train is 69>
													selected
												</cfif>
												> Self-paced - Online only


											<cfelseif session.modality EQ 4>
												<option value="33"
												<cfif form.train is 33>
													selected
												</cfif>
												>HSNY Trainings</option> <option value="7"
												<cfif form.train is 7>
													selected
												</cfif>
												>Other</option>
											<cfelse>
												<option value="8"
												<cfif form.train is 8>
													selected
												</cfif>
												>Advanced Media Skills</option> <option value="1"
												<cfif form.train is 1>
													selected
												</cfif>
												>Applying Social Marketing to Tobacco Control</option> <option value="22"
												<cfif form.train is 22>
													selected
												</cfif>
												>Building Alliances to Reduce Tobacco Use in Low Income Populations</option> <option value="23"
												<cfif form.train is 23>
													selected
												</cfif>
												>Building Momentum for POS Initiative (Community Partners)</option> <option value="24"
												<cfif form.train is 24>
													selected
												</cfif>
												>Building Momentum for POS Initiative (Reality Check)</option> <option value="25"
												<cfif form.train is 25>
													selected
												</cfif>
												>Engaging Community Health Center Administration in Health Systems Change</option> <option value="26"
												<cfif form.train is 26>
													selected
												</cfif>
												>Engaging Youth in Tobacco Policy Work</option> <option value="27"
												<cfif form.train is 27>
													selected
												</cfif>
												>Enhanced Outreach with Elected Officials</option> <option value="2"
												<cfif form.train is 2>
													selected
												</cfif>
												>Facilitating Tobacco Policy Change in Your Community</option> <option value="3"
												<cfif form.train is 3>
													selected
												</cfif>
												>Interviewing Skills</option> <option value="4"
												<cfif form.train is 4>
													selected
												</cfif>
												>Making the Most of Media</option> <option value="31"
												<cfif form.train is 31>
													selected
												</cfif>
												>Making an Impact Through Data & Stories</option> <option value="32"
												<cfif form.train is 32>
													selected
												</cfif>
												>Public Speaking</option> <option value="9"
												<cfif form.train is 9>
													selected
												</cfif>
												>Social Media Intro</option>
											</cfif>
												<option value="7"
												<cfif form.train is 7>
													selected
												</cfif>



												>Other</option>
										</select>
									</td>
								</tr>
								<tr>
									<td>
										<table id="myObject" class="box2"
										<cfif not isdefined("form.train") or #form.train# NEQ 7>
											style='display:none;'
										</cfif>
										>
								<tr>
									<td>
										Specify:
										<br>
										<input type="text" name="trainoth" size=60
										<cfif getinfra.trainoth is not ''>
											value="#getinfra.trainoth#"
										</cfif>
										>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td colspan=2>
							<input type="submit" name="add" value="Add" onclick="return checkOG();" class="AddButton">
						</td>
					</tr>
					<cfif Q.recordcount GT 0>
						<tr>
							<td colspan="4">
								<table border=".1" align="center" class="box2" width="100%">
									<tr>
										<td>
											<strong>
												Training name
											</strong>
										</td>
										<td>
											<strong>
												Delete
											</strong>
										</td>
									</tr>
									<cfoutput>
										<cfloop query="Q">
										<cfif not(isdefined("session.origuserid") and #session.fy# eq '2019' and (#session.origuserid# is 'nsarris' or #session.origuserid# is 'twills' or #session.origuserid# is 'dplotner' or #session.origuserid# is 'cschnefke'))>
											<cfif isdefined("q.train")>
												<cfswitch expression="#q.train#">
													<cfcase value=8>
														<cfset tname="Advanced Media Skills">
													</cfcase>
													<cfcase value=1>
														<cfset tname="Applying Social Marketing to Tobacco Control">
													</cfcase>
													<cfcase value=22>
														<cfset tname="Building Alliances to Reduce Tobacco Use in Low Income Populations">
													</cfcase>
													<cfcase value=23>
														<cfset tname="Building Momentum for POS Initiative (Community Partners)">
													</cfcase>
													<cfcase value=24>
														<cfset tname="Building Momentum for POS Initiative (Reality Check)">
													</cfcase>
													<cfcase value=25>
														<cfset tname="Engaging Community Health Center Administration in Health Systems Change">
													</cfcase>
													<cfcase value=26>
														<cfset tname="Engaging Youth in Tobacco Policy Work">
													</cfcase>
													<cfcase value=27>
														<cfset tname="Enhanced Outreach with Elected Officials">
													</cfcase>
													<cfcase value=2>
														<cfset tname="Facilitating Tobacco Policy Change in Your Community">
													</cfcase>
													<cfcase value=3>
														<cfset tname ="Interviewing Skills">
													</cfcase>
													<cfcase value=4>
														<cfset tname="Making the Most of Media">
													</cfcase>
													<cfcase value=31>
														<cfset tname ="Making an Impact Through Data & Stories">
													</cfcase>
													<cfcase value=32>
														<cfset tname ="Public Speaking">
													</cfcase>
													<cfcase value=9>
														<cfset tname="Social Media Intro">
													</cfcase>
													<cfcase value=7>
														<cfset tname="Other">
													</cfcase>
													<cfcase value=33>
														<cfset tname="HSNY Trainings">
													</cfcase>




												<cfcase value=60>
													<cfset tname="ATFC Institute - Online">
													</cfcase>
												<cfcase value=61>
													<cfset tname="ATFC Institute - Webinar">
													</cfcase>
												<cfcase value=62>
													<cfset tname="ATFC Institute - In-person">
													</cfcase>
												<cfcase value=63>
													<cfset tname="HS Institute - Online">
													</cfcase>
												<cfcase value=64>
													<cfset tname="HS Institute - Webinar">
													</cfcase>
												<cfcase value=65>
													<cfset tname="HS Institute - In-Person">
													</cfcase>
												<cfcase value=66>
													<cfset tname="Director Track - Online">
													</cfcase>
												<cfcase value=67>
													<cfset tname="Director Track - Webinar">
													</cfcase>
												<cfcase value=68>
													<cfset tname="Director Track - In-person">
													</cfcase>
												<cfcase value=69>
													<cfset tname="Self-paced - Online only">
													</cfcase>


												</cfswitch>
											</cfif></cfif>
											<tr>
												<td valign="top" bgcolor="##EEEEEE">
													#tname#
													<cfif q.train EQ 7>
														: #otherspec#
													</cfif>
												</td>
												<td bgcolor="##EEEEEE">
													<input type="Checkbox" name="Del_box" value="#infraid#">
												</td>
											</tr>
										</cfloop>
										<tr>
											<td colspan=2>
												<input type="Button" name="del_staff" value="Delete" onclick="submit();" class="DelButton">
											</td>
										</tr>
									</cfoutput>
								</table>
							</td>
						</tr>
					</cfif>
					<tr>
						<td height=10>
						</td>
					</tr>
					<td align="left" colspan=2>
						<strong>
							DOH Meetings and Conference Calls
						</strong>
						</th>
					</tr>
					<tr>
						<td valign="top" width=30%>
							Check the
							<cfif session.modality EQ 4 or session.modality eq 3>
								DOH
							<cfelse>
								DOH
							</cfif>
							meetings
							<cfif session.fy GT 2011>
								and Conference Calls
							</cfif>
							you attended this month:
						</td>
						<td>
							<input type="checkbox" name="tcp1" value=1
							<cfif #getinfra.tcp1# is 1>
								checked
							</cfif>
							> Regional Meeting
							<br>
							<input type="checkbox" name="tcp2" value=1
							<cfif getinfra.tcp2 is 1>
								checked
							</cfif>
							> Program Area Meeting
						</td>
					</tr>
					<tr>
						<td height=10>
						</td>
					</tr>
					<cfif #session.modality# is 2>
						<tr>
							<td align="left" valign="top" colspan=4><strong>ATFC meetings</strong><br><textarea name="meet" cols=150 rows=4  onKeyUp="countit(this)" onBlur="countit(this)">#getinfra.meet#</textarea>
								<br>
								<input type="button" value="Check Spelling" onClick="spell('document.wrk.meet.value')">
							</td>
						</tr>
						</td></tr>
					<cfelseif #session.modality# is 3>
						<tr>
							<td align="left" valign="top">
								<strong>
									Number of youth members active this month
								</strong>
								</th>
							<td>
								<cfif getinfra.ypmemb is not ''>
									<cfinput name="ypmemb" type="text" size=4 required="no" message="Please enter numeric data for number of youth members!" validate="integer" value="#getinfra.ypmemb#">
								<cfelse>
									<cfinput name="ypmemb" type="text" size=4 required="no" message="Please enter numeric data for number of youth members!" validate="integer">
								</cfif>
							</td>
						</tr>
						<tr>
							<td>
								<br>
							</td>
						</tr>
						<tr>
							<td align="left" valign="top" colspan=2>
								<strong>
									Youth meetings and trainings
								</strong>
								<br>
								<textarea name="meet" cols=150 rows=4  onKeyUp="countit(this)" onBlur="countit(this)">#getinfra.meet#</textarea>
								<br>
								<input type="button" value="Check Spelling" onClick="spell('document.wrk.meet.value')">
							</td>
						</tr>
						</td></tr>
					<cfelseif #session.modality# is 1 or #session.modality# EQ 6>
						<tr>
							<td align="left" valign="top" colspan=2>
								<strong>
									Health Systems Change meetings and workgroup activity
								</strong>
								<br>
								<textarea name="meet" cols=150 rows=4  onKeyUp="countit(this)" onBlur="countit(this)">#getinfra.meet#</textarea>
								<br>
								<input type="button" value="Check Spelling" onClick="spell('document.wrk.meet.value')">
							</td>
						</tr>
						</td></tr>
					<cfelseif #session.modality# is 5>
						<tr>
							<td align="left" valign="top" colspan=2>
								<strong>
									Colleges for Change meetings
								</strong>
								<br>
								<textarea name="meet" cols=150 rows=4  onKeyUp="countit(this)" onBlur="countit(this)">#getinfra.meet#</textarea>
								<br>
								<input type="button" value="Check Spelling" onClick="spell('document.wrk.meet.value')">
							</td>
						</tr>
					<cfelseif #session.modality# is 4>
						<tr>
							<td align="left" valign="top" colspan=2>
								<strong>
									School Policy meetings and workgroup activity
								</strong>
								<br>
								<textarea name="meet" cols=150 rows=4>#getinfra.meet#</textarea>
								<br>
								<input type="button" value="Check Spelling" onClick="spell('document.wrk.meet.value')">
							</td>
						</tr>
					</cfif>






					<tr>
						<td width="100%" valign="bottom" colspan=2>
							<div align="right" valign="bottom">
							This text field has a max of 1000 characters. Characters entered:
							<cfoutput>
								<input type="text" value="#len(getinfra.meet)#" name="infraMeetcount" size="4" style="border:0;" disabled>
							</cfoutput>
						</td>
					</tr>


					<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="CheckDisp">
	select isnull(len(dispinit),0) as displen from wrkplan
	where year2 = 2018
	and initnum = '6A'
	and userid=<cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	and year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
</cfquery>


					<cfif session.fy GT 2017>
	<cfif session.fy GT 2017 and session.modality NEQ 2>
					<tr>
						<th align="left" colspan=2>
							<strong>
								DSRIP
							</strong>
						</th>
					</tr>
					<tr>
						<td colspan=2>
							<textarea name="dsripdesc" cols=150 rows=14 onKeyUp="countit(this)" onBlur="countit(this)">#getinfra.dsripdesc#</textarea>
							<input type="button" value="Check Spelling" onClick="spell('document.wrk.dsripdesc.value')">
						</td>
					</tr>
					</td></tr>
					<tr>
						<td width="100%" valign="bottom" colspan=2>
							<div align="right" valign="bottom">
							This text field has a max of 2000 characters. Characters entered:
							<cfoutput>
								<input type="text" value="#len(getinfra.dsripdesc)#" name="dsripcount" size="4" style="border:0;" disabled>
							</cfoutput>
						</td>
					</tr>

					</cfif>

					<tr>
						<td height=10>
						</td>
					</tr>


					<tr><td colspan=2><strong>Disparities Project Summary of Activities</strong></td></tr>
					<tr> <td colspan = "2"><div align="left" valign="bottom">
<cfoutput><textarea name="dispartxt" cols=150 rows=6 onkeyup="countit(this)"><cfif isDefined("form.dispartxt") and #form.dispartxt# is not ''>#form.dispartxt#<cfelseif isDefined("getinfra.dispartxt")>#getinfra.dispartxt#</cfif></textarea> </cfoutput> </td> </tr>




<tr> <td colspan="2" width="100%" valign="bottom"><div align="right" valign="bottom">This text field has a max of 1950 characters. Characters entered: <cfoutput><input type="text" <cfif isDefined("form.dispartxt") and #form.dispartxt# is not ''>value="#len(form.dispartxt)#"<cfelseif isDefined("getinfra.dispartxt")>value="#len(getinfra.dispartxt)#"</CFIF> name="dispardisplaycount" size="4" style="border:0;" disabled></cfoutput></td> </tr> <tr>
<tr><td><input type="button" value="Check Spelling" onClick="spell('document.wrk.dispartxt.value', 'document.wrk.dispartxt.value')"> </td></tr></table>


					</cfif>

					<!--- for new CP --->
					<cfif session.modality EQ 2 and session.fy GT 2014>
						<tr>
							<td height=10>
							</td>
						</tr>

						<CFIF session.fy LT 2017>
						<td align="left" colspan=2>
							<strong>
								FDA
							</strong>
							</th>
						</tr>
						<tr>
							<td colspan=2>
								<table class="boxy" border=".1" width=775>
									<a name="fda">
									</a>
									<tr>
										<td>
											Number of communications with the federal government decision makers<!--- FDA ---> (e.g., about local POS policy)
										</td>
										<td align="center">
											<cfif #getinfra.fdacomm# is not ''>
												<cfinput type="text" name="fdacomm" value="#getinfra.fdacomm#" size=4 message="Please enter numeric data for Number of communications with FDA!" validate="integer">
											<cfelse>
												<cfinput type="text" name="fdacomm" size=4 message="Please enter Number of communications with FDA!" validate="integer" value="0">
											</cfif>
										</td>
									</tr>
									<tr>
										<td>
											Number of posted docket responses
										</td>
										<td align="center">
											<cfif #getinfra.postdock# is not ''>
												<cfinput type="text" name="postdock" value="#getinfra.postdock#" size=4 message="Please enter numeric data for number of posted docket responses!" validate="integer">
											<cfelse>
												<cfinput type="text" name="postdock" size=4 message="Please enter numeric data for number of posted docket responses!" validate="integer" value="0">
											</cfif>
										</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td height=10>
							</td>
						</tr>
						<tr>
							<td height=10>
							</td>
						</tr>
						<tr>
							<th align="left" colspan=2>
								<strong>
									Please describe any federal government<!--- FDA ---> communications (e.g., name of agency with which you communicated, topic of communication) or docket responses. Include docket ## if applicable.
								</strong>
							</th>
						</tr>
						<tr>
							<td colspan=2><textarea name="fdadesc" cols=150 rows=14 onKeyUp="countit(this)" onBlur="countit(this)">#getinfra.fdadesc#</textarea>
								<input type="button" value="Check Spelling" onClick="spell('document.wrk.fdadesc.value')">
							</td>
						</tr>
						</td></tr>


						<tr>
							<td width="100%" valign="bottom" colspan=2>
								<div align="right" valign="bottom">
								This text field has a max of 2000 characters. Characters entered:
								<cfoutput>
									<input type="text" value="#len(getinfra.fdadesc)#" name="fdacount" size="4" style="border:0;" disabled>
								</cfoutput>
							</td>
						</tr>
						</cfif>
					</cfif>
					<!--- end new --->
					<tr>
						<td height=10>
						</td>
					</tr>


<!--- inserted disparities --->





					<td align="left" colspan=2>
						<strong>
							Sustainability
						</strong>
						</th>
					</tr>
					<tr>
						<td colspan=2>
							<table class="boxy" border=".1" width=775>
								<a name="targ">
								</a>
								<cfif session.fy GTE 2011>
									<tr>
										<td>
											Number of in-person meetings with a state legislator
											<!--- (<em>This can include legislative office visits or other meetings during which you were able to present information about HSNY activities.</em>) --->
										</td>
										<td align="center">
											<cfif #getinfra.legvisit# is not ''>
												<cfinput type="text" name="legvisit" value="#getinfra.legvisit#" size=4 message="Please enter numeric data for number of legislative visits!" validate="integer">
											<cfelse>
												<cfinput type="text" name="legvisit" size=4 message="Please enter numeric data for number of legislative visits!" validate="integer" value="0">
											</cfif>
										</td>
									</tr>
									<tr>
										<td>
											Number of state legislators corresponded with
											<!--- (<em>This includes mailing or otherwise providing tobacco control-related information to state legislators and their staff.</em>) --->
										</td>
										<td align="center">
											<cfif #getinfra.legcorr# is not ''>
												<cfinput type="text" name="legcorr" value="#getinfra.legcorr#" size=4 message="Please enter numeric data for number of local legislators corresponded with!" validate="integer">
											<cfelse>
												<cfinput type="text" name="legcorr" size=4 message="Please enter numeric data for number of local legislators corresponded with!" validate="integer" value="0">
											</cfif>
										</td>
									</tr>
								<cfelse>
									<tr>
										<td align="center"
										<cfif session.fy LT 2011>
											rowspan=2
										</cfif>
										valign="bottom">
										<cfif session.fy LT 2011>
											## in-person
											<br>
											legislative visits
										<cfelse>
											Number of in-person meetings with a state legislator (This can include legislative office visits or other meetings during which you were able to present information about tobacco control activities.)
										</cfif>
										</td> <td align="center"
										<cfif session.fy LT 2011>
											rowspan=2
										</cfif>
										valign="bottom">
										<cfif session.fy LT 2011>
											## local legislators
											<br>
											corresponded with
										<cfelse>
											Number of state legislators corresponded with (This includes mailing or otherwise providing tobacco control-related information to state legislators and their staff.)
										</cfif>
										</td>
										<cfif session.fy LT 2011>
											<td align="center" rowspan=2 valign="bottom">
												## media representatives
												<br>
												you met with
											</td>
											<td colspan=2 align="center">
												Sustainability letters to the editor
												<br>
												(excluding initiative-specific letters)
											</td>
										</cfif>
									</tr>
									<cfif session.fy LT 2011>
										<tr>
											<td align="center">
												## submitted
											</td>
											<td align="center">
												## published
											</td>
										</tr>
									</cfif>
									<tr>
										<td align="center">
											<cfif #getinfra.legvisit# is not ''>
												<cfinput type="text" name="legvisit" value="#getinfra.legvisit#" size=4 message="Please enter numeric data for number of legislative visits!" validate="integer">
											<cfelse>
												<cfinput type="text" name="legvisit" size=4 message="Please enter numeric data for number of legislative visits!" validate="integer" value="0">
											</cfif>
										</td>
										<td align="center">
											<cfif #getinfra.legcorr# is not ''>
												<cfinput type="text" name="legcorr" value="#getinfra.legcorr#" size=4 message="Please enter numeric data for number of local legislators corresponded with!" validate="integer">
											<cfelse>
												<cfinput type="text" name="legcorr" size=4 message="Please enter numeric data for number of local legislators corresponded with!" validate="integer" value="0">
											</cfif>
											<cfif session.fy LT 2011>
										<td align="center"><cfif #getinfra.mediarep# is not ''><cfinput type="text" name="mediarep" value="#getinfra.mediarep#" size=4 message="Please enter numeric data for number of media representatives you met with!" validate="integer"><cfelse><cfinput type="text" name="mediarep" size=4 message="Please enter numeric data for number of media representatives you met with!" validate="integer" value="0"></cfif> </td> <td align="center"><cfif #getinfra.numsub# is not ''><cfinput type="text" name="numsub" value="#getinfra.numsub#" size=4 message="Please enter numeric data for number of letters submitted!" validate="integer"><cfelse><cfinput type="text" name="numsub" size=4 message="Please enter numeric data for number of letters submitted!" validate="integer" value="0"></cfif> </td> <td align="center"><cfif #getinfra.numpub# is not ''><cfinput type="text" name="numpub" value="#getinfra.numpub#" size=4 message="Please enter numeric data for number of letters published!" validate="integer"><cfelse><cfinput type="text" name="numpub" size=4 message="Please enter numeric data for number of letters published!" validate="integer" value="0"></cfif> </td> </cfif>
									</tr>
								</cfif>
							</table>
						</td>
					</tr>
					<tr>
						<td height=10>
						</td>
					</tr>
					<tr>
						<td height=10>
						</td>
					</tr>
					<tr>
						<th align="left" colspan=2>
							<strong>
								Sustainability activities description
							</strong>
						</th>
					</tr>
					<tr>
						<td colspan=2>
							<textarea name="susdesc" cols=150 rows=14 onKeyUp="countit(this)" onBlur="countit(this)">#getinfra.susdesc#</textarea>
							<input type="button" value="Check Spelling" onClick="spell('document.wrk.susdesc.value')">
						</td>
					</tr>
					</td></tr>
					<tr>
						<td width="100%" valign="bottom" colspan=2>
							<div align="right" valign="bottom">
							This text field has a max of 2000 characters. Characters entered:
							<cfoutput>
								<input type="text" value="#len(getinfra.susdesc)#" name="infrasuscount" size="4" style="border:0;" disabled>
							</cfoutput>
						</td>
					</tr>
					<tr>
						<td height=10>
						</td>
					</tr>
					<tr>
						<td height=10>
						</td>
					</tr>
					<th align="left" colspan=2>
						<strong>
							Infrastructure details
							<cfif session.modality EQ 2 and session.fy GT 2017>
								 (include RC developments, community planning meetings, agency partnerships, champions recruited, etc.)
							<cfelseif session.fy GT 2017>
								 (health planning groups, health care partnerships, champions recruited, etc.)
							</cfif>
						</strong>
					</th>
					</tr>
					<tr>
						<td colspan=2>
							<textarea name="infradesc" cols=150 rows=14 onKeyUp="countit(this)" onBlur="countit(this)">#getinfra.infradesc#</textarea>
							<input type="button" value="Check Spelling" onClick="spell('document.wrk.infradesc.value')">
							</th>
					</tr>
					</td></tr>
					<tr>
						<td width="100%" valign="bottom" colspan=2>
							<div align="right" valign="bottom">
							This text field has a max of 2000 characters. Characters entered:
							<cfoutput>
								<input type="text" value="#len(getinfra.infradesc)#" name="infradisplaycount" size="4" style="border:0;" disabled>
							</cfoutput>
						</td>
					</tr>
					<tr>
						<td height=10>
						</td>
					</tr>
			</cfoutput>
			<tr><td colspan=2 align="center"> <input type="submit" name="return" value="Save" onClick="return checkLG();"> </td></tr> <tr><td>&nbsp;</td></tr> <tr><td colspan=2 align="center"> <input type="submit" name="return" value="Save and return to Monthly Reporting" onClick="return checkLG();"> </td></tr> </table>
		</cfform>
		</table> </td> </tr>
		<cfif session.fy LT session.def_fy AND session.prevyr NEQ 1 AND NOT (SESSION.areamanage EQ "1" OR SESSION.admin EQ "1" OR SESSION.TCP EQ "1")>
			<script language="JavaScript">
	disableme();
</script>
		</cfif>
		<cfif session.readOnly EQ 1>
			<script language="JavaScript">
	disableme();
</script>
		</cfif>
	</body>
</html>

