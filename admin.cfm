<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>
			CAT
		</title>
		<cfif isDefined ("form.sysfy")>
			<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QupdateAdmin">
	update admin
	set fy=<cfqueryparam value="#form.sysfy#" cfsqltype="CF_SQL_INTEGER" null="#YesNoFormat(not Len(form.sysfy))#">,
	nextyr=<cfqueryparam  cfsqltype="cf_sql_bit" value="#form.nyr#" null="#YesNoFormat(not Len(form.nyr))#">,
	sp_fy=<cfqueryparam  cfsqltype="cf_sql_bit" value="#form.sysfy_sp#" null="#YesNoFormat(not Len(form.sysfy_sp))#">,
	sp_nextyr=<cfqueryparam  cfsqltype="cf_sql_bit" value="#form.nyr_sp#" null="#YesNoFormat(not Len(form.nyr_sp))#">
</cfquery>
			<cflock timeout=20 scope="Session" type="Exclusive">
				<cfset StructDelete(Session, "def_fy")>
			</cflock>
			<cfinclude template="application.cfm">
		</cfif>
		<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QgetAdmin">
	select fy,	nextyr,
	sp_fy, sp_nextyr
	from admin
</cfquery>
		<cfinclude template="CATstruct.cfm">
		<script language="JavaScript">
function setUpd(){
document.new2.process.value="update";
document.new2.submit();
}
function flip(){
for(var i = 0; i < document.collaborations.selpartners.length; i++){
document.collaborations.selpartners[i].selected = true;
}
if (isdefined(document.collaborations.selpartners)=="undefined"){
alert('Please select at least one collaborator!');
return false;
}
return true;
}
</script>
		<tr>
			<td>
			</td>
		</tr>
		<table class="box" align="center" cellpadding="10" cellspacing="0" border="0" >
			<tr>
				<td align="center">
					<h2>
						User Administration
					</h2>
				</td>
			</tr>
			<cfif isDefined("form.process")>
				<cfswitch expression="#form.process#">
					<cfcase value="new">
						<cfoutput>
							<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="CheckUser">
		select userid from  security where userid = <cfqueryparam value="#form.newUser#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	</cfquery>
						</cfoutput>
						<cfif CheckUser.recordcount GT 0 >
							<script language="JavaScript">
	alert("WARNING! You have chosen a Username already in use, please make another selection, or update an existing user");
	</script>
						<cfelse>
							<cfoutput>
								<CFSET RND8 ="">
								<CFLOOP INDEX="R8ix" FROM="1" TO="8">
									<CFSET RND8 =
										RND8&Mid('abcdefghijklmnopqrstuvwxyz123456789',RandRange('1','35'),'1')>
								</CFLOOP>
<cfset variables.salt = Hash(GenerateSecretKey("AES"), "SHA-512") />
<cfset variables.hashedPassword = Hash(RND8 & variables.salt, "SHA-512") />

								<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="insertUser">
insert into security (userid, <!--- password, ---> change, security, name,areamanage,regionmanage,statemanage, area, pw, salt, lastchanged, password)
values (<cfqueryparam value="#form.newUser#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
<!--- <cfqueryparam value="#RND8#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">, --->
1, <cfif isDefined("form.Sec")>1<cfelse>0</cfif>,
<cfqueryparam value="#form.coordlname#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
<cfif isDefined("form.area")>1<cfelse>0</cfif>,
<cfif isDefined("form.regional")>1<cfelse>0</cfif>,
<cfif isDefined("form.state")>1<cfelse>0</cfif>,
<cfqueryparam value="#form.contactarea#" cfsqltype="CF_SQL_INTEGER">,
<cfqueryparam value="#variables.hashedPassword#" cfsqltype="CF_SQL_VARCHAR">,
<cfqueryparam value="#variables.salt#" cfsqltype="CF_SQL_VARCHAR">,
getdate(), 'notused')
</cfquery>

 <cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="insertBBSUser">
insert into members
(username, email, activestatus, accesslevel, pw, salt, password)
values
(<cfqueryparam value="#form.newUser#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
<!--- <cfqueryparam value="#RND8#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">, --->
<cfqueryparam value="#form.coordemail#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">, 'A', 1,
<cfqueryparam value="#variables.hashedPassword#" cfsqltype="CF_SQL_VARCHAR">,
<cfqueryparam value="#variables.salt#" cfsqltype="CF_SQL_VARCHAR">, 'notused'
)
</cfquery>

<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="RetrUser">
select userid, seq
from security
where userid=<cfqueryparam value="#form.newUser#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
</cfquery>

<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="insertContactr">
insert into contact (
userid,
user_pk,
suppress,
orgname, orgname2,partnertype,grantnum, coordfname, coordlname, coordphone, coordemail, cmanager)
values (
<cfqueryparam value="#form.newUser#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
<cfqueryparam value="#RetrUser.seq#" cfsqltype="CF_SQL_INTEGER">,
<cfif isDefined("form.suppress")>1<cfelse>0</cfif>,
<cfqueryparam value="#form.orgname#" cfsqltype="CF_SQL_VARCHAR" maxlength="180">,
<cfqueryparam value="#form.orgname2#" cfsqltype="CF_SQL_VARCHAR" maxlength="180">,
<cfqueryparam value="#form.partnertype#" cfsqltype="CF_SQL_VARCHAR" maxlength="180">,
<cfqueryparam value="#form.grantnum#" cfsqltype="CF_SQL_VARCHAR" maxlength="180">,
<cfqueryparam value="#form.coordfname#" cfsqltype="CF_SQL_VARCHAR" maxlength="180">,
<cfqueryparam value="#form.coordlname#" cfsqltype="CF_SQL_VARCHAR" maxlength="180">,
<cfqueryparam value="#form.coordphone#" cfsqltype="CF_SQL_VARCHAR" maxlength="25">,
<cfqueryparam value="#form.coordemail#" cfsqltype="CF_SQL_VARCHAR" maxlength="180">,
<cfqueryparam value="#form.cm#" cfsqltype="CF_SQL_VARCHAR" maxlength="20">
)
</cfquery>
							</cfoutput>
							<cfmail from="dplotner@rti.org" to="#form.coordemail#" subject="Welcome to CAT" type="HTML">
Welcome to the CAT System.<BR><BR>
You may access the system using:<BR><BR>
	Username: #form.newUser#<BR>
	Password: #RND8#<BR><BR>
	You will be prompted to change your password when you login.<BR><BR>
	The system can be accessed at <a href="#application.basename#">#application.basename#</a>
</cfmail>
						</cfif>
					</cfcase>
					<cfcase value="update">
						<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="updateUser">
update security
set
security=<cfif isDefined("form.Sec")>1<cfelse>0</cfif>,
name=<cfqueryparam value="#form.coordlname#" cfsqltype="CF_SQL_VARCHAR" maxlength="180">,
<cfif isDefined("form.contactarea")>area=<cfqueryparam value="#form.contactarea#" cfsqltype="CF_SQL_INTEGER">,</cfif>
areamanage=<cfif isDefined("form.area")>1<cfelse>0</cfif>,
regionmanage=<cfif isDefined("form.regional")>1<cfelse>0</cfif>,
statemanage=<cfif isDefined("form.state")>1<cfelse>0</cfif>

<!--- pw= <cfqueryparam value="#variables.hashedPassword#" cfsqltype="CF_SQL_VARCHAR">,
salt= <cfqueryparam value="#variables.salt#" cfsqltype="CF_SQL_VARCHAR">,lastchanged=getdate(), --->
where userid=<cfqueryparam value="#form.newUser#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
</cfquery>
						<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="updateContactr">
update contact
set
email=<cfqueryparam value="#form.coordemail#" cfsqltype="CF_SQL_VARCHAR" maxlength="180">,
orgname=<cfqueryparam value="#form.orgname#" cfsqltype="CF_SQL_VARCHAR" maxlength="180">,
orgname2=<cfqueryparam value="#form.orgname2#" cfsqltype="CF_SQL_VARCHAR" maxlength="180">,
partnertype=<cfqueryparam value="#form.partnertype#" cfsqltype="CF_SQL_VARCHAR" maxlength="180">,
grantnum=<cfqueryparam value="#form.grantnum#" cfsqltype="CF_SQL_VARCHAR" maxlength="180">,
coordfname=<cfqueryparam value="#form.coordfname#" cfsqltype="CF_SQL_VARCHAR" maxlength="180">,
coordlname=<cfqueryparam value="#form.coordlname#" cfsqltype="CF_SQL_VARCHAR" maxlength="180">,
coordphone=<cfqueryparam value="#form.coordphone#" cfsqltype="CF_SQL_VARCHAR" maxlength="25">,
coordemail=<cfqueryparam value="#form.coordemail#" cfsqltype="CF_SQL_VARCHAR" maxlength="180">,
cmanager=<cfqueryparam value="#form.cm#" cfsqltype="CF_SQL_VARCHAR" maxlength="20">,
suppress=<cfif isDefined("form.suppress")>1<cfelse>0</cfif>
<cfif isDefined("form.contactarea")>,area=<cfqueryparam value="#form.contactarea#" cfsqltype="CF_SQL_INTEGER"></cfif>
where userid=<cfqueryparam value="#form.newUser#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
</cfquery>
					</cfcase>
				<cfcase value="reset">
						<CFSET RND8 ="">
						<CFLOOP INDEX="R8ix" FROM="1" TO="8">
							<CFSET RND8 =
								RND8&Mid('abcdefghijklmnopqrstuvwxyz123456789',RandRange('1','35'),'1')>
						</CFLOOP>

<cfset variables.salt = Hash(GenerateSecretKey("AES"), "SHA-512") />
<cfset variables.hashedPassword = Hash(RND8 & variables.salt, "SHA-512") />

						<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="updateUser">
update security
set <!--- password=<cfqueryparam value="#RND8#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">, --->
password = 'notused',
pw='#variables.hashedPassword#', salt='#variables.salt#',lastchanged=getdate(),
change=1
where userid= <cfqueryparam value="#form.resetname#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
</cfquery>


<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="updateMembers">
update members
set password = 'notused', <!--- password=<cfqueryparam value="#RND8#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">, --->
pw = '#variables.hashedPassword#', salt = '#variables.salt#'
where username= <cfqueryparam value="#form.resetname#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
</cfquery>

<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="getUserMail">
select isnull(coordemail,isNull(email,'dplotner@rti.org')) as email,isnull(coordemail2,isNull(email,'dplotner@rti.org')) as email2 from contact
where userid= <cfqueryparam value="#form.resetname#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
</cfquery>
						<cfmail from="dplotner@rti.org" to="#getUserMail.email#,#getUserMail.email2#" bcc="twills@rti.org" subject="CAT Password Reset" type="HTML">
Welcome to the CAT System.<BR><BR>
Your password to access the system has been changed:<BR><BR>
	Username: #form.resetName#<BR>
	Password: #RND8#<BR><BR>
	You will be prompted to change your password when you login.<BR><BR>
	The system can be accessed at <a href="#application.basename#>">#application.basename#</a>
</cfmail>
					</cfcase>
					<cfcase value="delete">
						<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="deleteUser">
delete from security
where userid= <cfqueryparam value="#form.delname#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
</cfquery>
						<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="deleteUser2">
delete from contact
where userid= <cfqueryparam value="#form.delname#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
</cfquery>
						<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="deleteUser3">
delete from members
where username= <cfqueryparam value="#form.delname#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
</cfquery>
					</cfcase>
				</cfswitch>
			</cfif>
			<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="selectRegion">
	select r.region, a.area, a.num from area a, region r
	where a.year2=2010
	and a.year2=r.year2
	and a.region=r.num
	and a.area !='joint strategy'
	order by 1,2
</cfquery>
			<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="currentUser">
		select c.userid, orgname + '- ' + c.coordlname as name
from  contact c , security s
where
c.userid = s.userid and
orgname is not null and contact is not null
and (ENDyear is null and  s.del is null)
union
select c.userid, orgname as name
from  contact c , security s
where c.userid = s.userid and
contact is  null
and (ENDyear is null and  s.del is null)
union
select c.userid, '- '+ <!--- contact --->coordlname + ' ('+ c.userid +')' as name
from  contact c, security s
where c.userid = s.userid and
orgname is null
and (ENDyear is null and  s.del is null)
order by 2
	</cfquery>
			<cfif isDefined ("form.process") and form.process EQ "updlist">
				<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="UserInfo">
		select s.userid, s.name, security, s.area, areamanage, regionmanage, statemanage , suppress,
		orgname, orgname2,partnertype,grantnum, coordfname, coordlname, coordphone, coordemail, cmanager as cm
		from  security as s, contact as c
		where s.userid=<cfqueryparam value="#form.resetname#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
		and c.userid = s.userid
	</cfquery>
				<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="UserInfo2">
		select coordemail
		from  contact
		where userid=<cfqueryparam value="#form.resetname#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
	</cfquery>
			</cfif>
			<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="partnerTypes">
	select distinct heading, num,rank
	from partnerTypes
	where year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	order by rank
</cfquery>
			<cfquery datasource="#application.DataSource#"
	password="#Application.db_password#"
	username="#Application.db_username#" name="QCM">
	select distinct c.contact as CMName , c.userid as CMid
	from contact as c, contact as c2, security s
	where c.userid=c2.cmanager
	and c2.userid = s.userid
	--and c.email not like '%rti.org'
	and s.del is null
	order by 1
</cfquery>
			<cfform name="new2" action="admin.cfm?#session.urltoken#">
				<input type="Hidden" name="process" value="new">
				<tr>
					<td>
						<table class="box" align="center">
							<tr>
								<td>
									Add New User:
								</td>
							</tr>
							<tr>
								<td>
								</td>
								<td>
									Username:
								</td>
								<td>
									<input type="Text" name="newUser"
									<cfif isDefined("UserInfo")>
										<cfoutput>
											value="#UserInfo.userid#"
										</cfoutput>
									</cfif>
									>
								</td>
							</tr>
							<cfoutput>
								<tr>
									<td>
									</td>
									<td width="25%">
										Program name (Display Name)
									</td>
									<td colspan="2">
										<input type="text" name="orgName"
										<cfif isDefined("UserInfo")>
											value ="#UserInfo.orgName#"
										</cfif>
										required="Yes" maxlength="180" size="75">
									</td>
								</tr>
								<tr>
									<td>
									</td>
									<td>
										Modality
									</td>
									<td colspan="2">
										<cfselect name="partnerType" required="Yes"
										<!--- onchange="replaceContent()" --->
										>
										<cfloop query="partnerTypes">
											<option value="#num#"
											<cfif isDefined("UserInfo") and UserInfo.partnerType EQ "#num#">
												selected
											</cfif>
											>#heading#
										</cfloop>
										</cfselect>
									</td>
								</tr>
							</cfoutput>
							<tr>
								<td>
								</td>
								<td>
									Area?
								</td>
								<td>
									<select name="contactArea">
										<cfoutput query="selectRegion" group="Region">
											<optgroup label="#Region#">
											<cfoutput>
												<option value="#num#"
												<cfif isDefined("UserInfo")AND UserInfo.area EQ num>
													selected
												</cfif>
												>#area#
											</cfoutput>
										</cfoutput>
									</select>
								</td>
							</tr>
							<cfoutput>
								<tr>
									<td>
									</td>
									<td>
										Contract Manager #QCM.recordcount#
									</td>
									<td>
										<select name="CM">
											<cfloop query="QCM">
												<option value="#QCM.CMid#"
												<cfif isDefined("UserInfo.CM") and UserInfo.CM EQ QCM.CMid>
													selected
												</cfif>
												>#CMName#
											</cfloop>
										</select>
									</td>
								</tr>
								<tr>
									<td>
									</td>
									<td>
										Organization name
									</td>
									<td colspan="2">
										<input type="text" name="orgName2"
										<cfif isDefined("UserInfo")>
											value ="#UserInfo.orgName2#"
										</cfif>
										required="Yes" maxlength="180" size="75">
									</td>
								</tr>
								<tr>
									<td>
									</td>
									<td>
										Contract Number
									</td>
									<td colspan="2">
										<input type="text" name="grantnum"
										<cfif isDefined("UserInfo")>
											value ="#UserInfo.grantnum#"
										</cfif>
										required="Yes" maxlength="180" size="50">
									</td>
								</tr>
								<tr>
									<td>
									</td>
									<td>
										Project Coordinator Name *
									</td>
									<td colspan=2 align="left">
										<table align="left">
											<tr>
												<td align="left">
													<div style="font-style:italic;font-size:11px;">
														First Name
													</div>
													<input type="text" name="coordfname"
													<cfif isDefined("UserInfo")>
														value ="#UserInfo.coordfname#"
													</cfif>
													maxlength="180" size="20">
												</td>
												<td align="left">
													<div style="font-style:italic;font-size:11px;">
														Last Name
													</div>
													<input type="text" name="coordlname"
													<cfif isDefined("UserInfo")>
														value ="#UserInfo.coordlname#"
													</cfif>
													maxlength="180" size="20">
												</td>
											</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td>
									</td>
									<td>
										Project Coordinator Phone *
									</td>
									<td colspan="2">
										<input type="text" name="coordphone"
										<cfif isDefined("UserInfo")>
											value ="#UserInfo.coordphone#"
										</cfif>
										required="Yes" maxlength="180" size="50">
									</td>
								</tr>
								<tr>
									<td>
									</td>
									<td>
										Project Coordinator E-mail address *
									</td>
									<td colspan="2">
										<input type="text" name="coordemail"
										<cfif isDefined("UserInfo")>
											value ="#UserInfo.coordemail#"
										</cfif>
										required="Yes" maxlength="180" size="50">
									</td>
								</tr>
							</cfoutput>
							<tr>
								<td>
								</td>
								<td>
									Admin?
								</td>
								<td>
									<input type="Checkbox" name="sec"
									<cfif isDefined("UserInfo")AND UserInfo.security EQ 1>
										checked
									</cfif>
									>
								</td>
							</tr>
							<tr>
								<td>
								</td>
								<td>
									Area Access?
								</td>
								<td>
									<input type="Checkbox" name="area"
									<cfif isDefined("UserInfo")AND UserInfo.areamanage EQ 1>
										checked
									</cfif>
									>
								</td>
							</tr>
							<tr>
								<td>
								</td>
								<td>
									Regional Access?
								</td>
								<td>
									<input type="Checkbox" name="regional"
									<cfif isDefined("UserInfo")AND UserInfo.regionmanage EQ 1>
										checked
									</cfif>
									>
								</td>
							</tr>
							<tr>
								<td>
								</td>
								<td>
									State Access?
								</td>
								<td>
									<input type="Checkbox" name="state"
									<cfif isDefined("UserInfo")AND UserInfo.statemanage EQ 1>
										checked
									</cfif>
									>
								</td>
							</tr>
							<tr>
								<td>
								</td>
								<td>
									Supress User?
								</td>
								<td>
									<input type="Checkbox" name="suppress"
									<cfif isDefined("UserInfo")AND UserInfo.suppress EQ 1>
										checked
									</cfif>
									>
								</td>
							</tr>
							<td>
								<input type="submit" name="addUser" value="Add User" class="AddButton">
							</td>
							<td>
							</td>
							<td>
								<input type="button" name="updUser" value="Update User" onclick="setUpd();" class="AddButton" class="AddButton">
							</td>
							</tr>
							<tr>
								<td colspan="4">
									<hr>
								</td>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</cfform>
			<cfform name="reset2" action="admin.cfm?#session.urltoken#">
				<input type="Hidden" name="process" value="updlist">
				<tr>
					<td>
						<table width="100%"  class="box">
							<tr>
								<td>
									Update User Info:
								</td>
								<td>
									Contact Name:
								</td>
								<td>
									<cfselect name="resetName" query="currentUser" display="name" value="userid" onchange="document.reset2.submit();">
										<option selected>
									</cfselect>
								</td>
							</tr>
							<tr><td colspan="4"><hr></td></td></tr>
						</table>
					</td>
				</tr>
			</cfform>
			<cfform name="reset" action="admin.cfm?#session.urltoken#"> <input type="Hidden" name="process" value="reset"> <tr><td> <table width="100%" class="box"> <tr><td>Reset Password:</td><td>Contact Name:</td><td><cfselect name="resetName" query="currentUser" display="name" value="userid"></cfselect></td> <td><input type="submit" value="Reset" class="DelButton"></td><td></td> </tr> <tr><td colspan="4"><hr></td></td></tr> </table> </td> </tr> </cfform> <cfform name="delete" action="admin.cfm?#session.urltoken#"> <script LANGUAGE="JavaScript">
</script> <input type="Hidden" name="process" value="delete"> <tr><td><table class="box"> <tr><td>Delete User:</td></tr> <tr><td></td><td>Contact Name:</td><td><cfselect query="currentUser" display="name" value="userid" name="delName"></cfselect></td> <td><input type="submit" value="Delete User" onclick="return confirmSubmit();" class="DelButton"></td> </tr> </table></td></tr> </cfform> <cfif isDefined("form.collabs")> <cfif NOT isDefined("form.collabname") or form.collabname EQ ""> <cfparam name="form.collabname" default="form.strategyName"> </cfif> <cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QcheckStrat">
	select partners from sharedActivities
	where (stratname=<cfqueryparam value="#form.collabName#" cfsqltype="CF_SQL_VARCHAR" maxlength="180"> or stratname=<cfqueryparam value="#form.strategyName#" cfsqltype="CF_SQL_VARCHAR" maxlength="180">)
	and year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
</cfquery> <cfif isDefined("form.selpartners")> <cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QlookupPartner">
	select user_pk from contact where orgName in (<cfqueryparam value="#listQualify(form.selpartners,"'")#" cfsqltype="CF_SQL_VARCHAR" maxlength="180">)
</cfquery> <cfif form.collabs EQ "update"> <cfif QcheckStrat.recordcount NEQ 0 and form.collabName EQ ""> <cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QupdStrat">
	update sharedActivities
	set
	partners=<cfqueryparam value="#valuelist(QlookupPartner.user_pk)#" cfsqltype="CF_SQL_VARCHAR" maxlength="180">,
	focusArea=<cfqueryparam value="#form.farea#" cfsqltype="CF_SQL_INTEGER">,
	year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	where (stratname=<cfqueryparam value="#form.collabName#" cfsqltype="CF_SQL_VARCHAR" maxlength="180"> or stratname=<cfqueryparam value="#form.strategyName#" cfsqltype="CF_SQL_VARCHAR" maxlength="180">)
</cfquery> <cfelse> <cfset form.collabs = "new"> </cfif> <cfif form.collabs EQ "new"> <cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QcheckStrat">
	select *
	from sharedActivities
	where stratName=<cfqueryparam value="#form.collabName#" cfsqltype="CF_SQL_VARCHAR" maxlength="180">
</cfquery> <cfset updatefail= "0"> <cfif QcheckStrat.recordcount GT 0> <cfset updatefail= "1"> <cfelse> <cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QaddStrat">
	insert into sharedActivities
	(partners,focusArea,stratName, year2, creationdate, creator)
	values
	(<cfqueryparam value="#valuelist(QlookupPartner.user_pk)#" cfsqltype="CF_SQL_VARCHAR" maxlength="180">,<cfqueryparam value="#form.farea#" cfsqltype="CF_SQL_INTEGER">,<cfqueryparam value="#form.collabName#" cfsqltype="CF_SQL_INTEGER">, <cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">, getDate(),
	'<cfif isDefined("session.userid")><cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"></cfif>:<cfif isDefined("session.origUserID")><cfqueryparam value="#session.origUserID#" cfsqltype="CF_SQL_VARCHAR" maxlength="50"></cfif>')
</cfquery> </cfif> </cfif> <cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QtruncStrat">
	delete from sharedUserActivities
	where year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
</cfquery> <cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QStrat_1">
	select partners, stratName
	from sharedActivities
	where year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
</cfquery> <cfif QStrat_1.recordcount GT 0> <cfloop query="QStrat_1"> <cfloop index = "ListElement" list = "#partners#"> <cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QStrat_2">
	insert into sharedUserActivities
	(year2, userid, activity)
	values
	(<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">, <cfqueryparam value="#ListElement#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,<cfqueryparam value="#stratName#" cfsqltype="CF_SQL_VARCHAR" maxlength="250">)
	</cfquery> </cfloop> </cfloop> <cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QStrat_final">
	update sharedUserActivities
	set userid=(select userid from contact as c where c.user_pk=sharedUserActivities.userid and c.user_pk !=8)
	where year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
	</cfquery> </cfif> </cfif> <cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="qJPSlist">
	select stratname, partners, year2
	from sharedactivities
	where partners is not null
</cfquery> <!--- <cfloop query="qJPSlist">
				<cfquery datasource="#application.DataSource#"
				password="#application.db_password#"
				username="#application.db_username#" name="quserlist">
				select orgname, userid
				from contact
				where user_pk in (#qJPSlist.partners#)
				</cfquery>
				<cfquery datasource="#application.DataSource#"
				password="#application.db_password#"
				username="#application.db_username#" name="qupduser">
				update useractivities
				set JPS_orgs='#valuelist(quserlist.orgname)#'
				where activity='#qJPSlist.stratname#'
				and year2=#qJPSlist.year2#
				and userid='shared'
				</cfquery>
				<cfquery datasource="#application.DataSource#"
				password="#application.db_password#"
				username="#application.db_username#" name="qupduser2">
				update sharedactivities
				set PARTNERLIST='#valuelist(quserlist.userid)#'
				where stratname='#qJPSlist.stratname#'
				and year2=#qJPSlist.year2#
				</cfquery>
				</cfloop> ---> <cfloop query="qJPSlist"> <cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="quserlist">
select orgname, catchment, userid
from contact
where user_pk in (<cfqueryparam value="#qJPSlist.partners#" cfsqltype="CF_SQL_VARCHAR" maxlength="100">)
</cfquery> <cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="qcatchmentlist">
select countyname
from counties
where FIPS in (<cfqueryparam value="#valuelist(quserlist.catchment)#" cfsqltype="CF_SQL_VARCHAR" maxlength="100">)
</cfquery> <cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="qupduser">
	update useractivities
	set JPS_orgs=<cfqueryparam value="#valuelist(quserlist.orgname)#" cfsqltype="CF_SQL_VARCHAR" maxlength="100">,
	JPS_counties=<cfqueryparam value="#valuelist(qcatchmentlist.countyname)#" cfsqltype="CF_SQL_VARCHAR" maxlength="100">
	where activity=<cfqueryparam value="#qJPSlist.stratname#" cfsqltype="CF_SQL_VARCHAR" maxlength="180">
	and year2=<cfqueryparam value="#qJPSlist.year2#" cfsqltype="CF_SQL_INTEGER">
	and userid='shared'
</cfquery> <cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="qupduser2">
	update sharedactivities
	set PARTNERLIST=<cfqueryparam value="#valuelist(quserlist.userid)#" cfsqltype="CF_SQL_VARCHAR" maxlength="5000">
	where stratname=<cfqueryparam value="#qJPSlist.stratname#" cfsqltype="CF_SQL_VARCHAR" maxlength="180">
	and year2=<cfqueryparam value="#qJPSlist.year2#" cfsqltype="CF_SQL_INTEGER">
</cfquery> </cfloop> </cfif> <cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QcheckFocus">
	select focusArea from sharedActivities
	where (stratname=<cfqueryparam value="#form.collabName#" cfsqltype="CF_SQL_VARCHAR" maxlength="180"> or stratname=<cfqueryparam value="#form.strategyName#" cfsqltype="CF_SQL_VARCHAR" maxlength="180">)
	and year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
</cfquery> </cfif> <cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QFocusAreas">
select num, descr from focusAreas
where year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
order by rank
</cfquery> <cfparam name="form.strategyName" default="NotDefined"> <cfparam name="form.COLLABNAME" default="NotDefined"> <cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="selectedPartners">
	select partners from sharedActivities
	where (stratname=<cfqueryparam value="#form.collabName#" cfsqltype="CF_SQL_VARCHAR" maxlength="180"> or stratname=<cfqueryparam value="#form.strategyName#" cfsqltype="CF_SQL_VARCHAR" maxlength="180">)
	and year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
</cfquery> <cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QallPartners">
select orgName, user_pk from contact
where
orgname is not null
and orgname != ''
<cfoutput><cfif (selectedPartners.recordcount GT 0) and (selectedPartners.partners NEQ "")>and user_pk NOT IN (<cfloop list="#selectedPartners.partners#" index="mypartner"><cfqueryparam value="#mypartner#" cfsqltype="CF_SQL_VARCHAR" maxlength="180">, </cfloop>'0') </cfif></cfoutput>
	 order by 1
</cfquery> <cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QselPartners">
select orgName, user_pk from contact
where user_pk in <cfif (selectedPartners.recordcount GT 0) and (selectedPartners.partners NEQ "")>(<cfqueryparam value="#selectedPartners.partners#" cfsqltype="CF_SQL_VARCHAR" maxlength="180">)<cfelse>(0)</cfif>
order by 1
</cfquery> <cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="QExistStrat">
select stratName from sharedActivities
where year2=<cfqueryparam value="#session.fy#" cfsqltype="CF_SQL_INTEGER">
order by 1
</cfquery> <!--- <tr><td><table class="box">
				<cfform name="collaborations" action="admin.cfm?#session.urltoken#">
				<input type="Hidden" name="collabs" value="">
				<script language="JavaScript">
				function setUpd5(value){
				document.collaborations.collabs.value=value;
				document.collaborations.submit();
				}
				</script>
				<tr><th colspan="2">TCP Partner Joint Strategies</th></tr>
				<tr>
				<td>Select Existing Joint Strategy Name:</td>
				<td>
				<select  name="strategyName" onchange="this.form.submit();">
				<option>-Select an existing strategy-
				<cfoutput>
				<cfloop query="QExistStrat">
				<option value="#stratName#" <cfif isDefined("form.strategyName") and form.strategyName EQ #stratName#> selected</cfif>>#stratName#
				</cfloop>
				</cfoutput>
				</select>
				</td>
				</tr>
				<tr><th> OR</th></tr>
				<tr>
				<td>Enter New Joint Strategy Name:</td>
				<td><input name="collabName"  size="80">
				<cfif isDefined("updatefail") and updatefail EQ 1><font color="#FF0000">STRATEGY ALREADY EXISTS: CREATION FAILED</font></cfif>
				</td>
				</tr>
				<tr>
				<td>Focus Area</td>
				<td>
				<select name="fArea">
				<cfoutput>
				<cfloop query="QFocusAreas">
				<option value="#num#" <cfif isDefined("QcheckFocus.focusArea") and QcheckFocus.focusArea EQ "#num#"> selected</cfif>>#descr#
				</cfloop>
				</cfoutput>
				</select>
				</td>
				</tr>
				<tr>
				<td colspan="2"><table class="box"><tr><th colspan="3">Partners:</th></tr>
				<tr>
				<td align="right" valign="top">
				TCP Partners: <br><select name="allpartners" multiple size="5" class="mlti">
				<cfoutput>
				<cfloop query="QallPartners">
				<option value="#orgName#">#orgName#
				</cfloop>
				</cfoutput>
				</select>
				</td>
				<td align="center"><NOBR>
				<input type="button" style="width:90" onclick="moveDualList( this.form.allpartners,  this.form.selpartners, false )"    name="Add     >>"  value="Add       >>" class="AddButton">     <BR>
				<NOBR>
				<input type="button" style="width:90" onclick="moveDualList( this.form.selpartners, this.form.allpartners,  false )"    name="<<  Remove"  value="<<   Remove" class="DelButton">     <BR>
				</td>
				<td align="left"  valign="top">
				TCP Partners participating in this joint strategy:<br><cfselect name="selpartners" multiple size="5"  required="Yes" message="Please specify at least one county in your catchment area" class="mlti">
				<cfoutput>
				<cfloop list="#valuelist(QselPartners.orgName)#" index="orgName">
				<option value="#orgName#">#orgName#
				</cfloop>
				</cfoutput>
				</cfselect></td>
				</tr></table></td></tr>
				<tr>
				<td colspan="2"></td><td><input type="button" name="updUser5" value="Add or Update User" onclick="flip();setUpd5('update');" class="AddButton"></td>
				</tr>
				</cfform>
				<tr><td>&nbsp;<br></td></tr> ---> <tr><td colspan="3"><br> <cfform name="fyadmin" action="admin.cfm?#session.urltoken#"> <input type="Hidden" name="fyadmin" value=""> <table class="box" width="75%" align="center"> <tr> <td>Function</td> <td>CP, YP<cfif session.fy GT 2011> and<cfelse>,</cfif> CC<cfif session.fy LT 2012> and C4C Modalities</cfif></td> <td>SP Modality</td> </tr> <tr> <td>System Fiscal Year</td> <td><cfinput name="sysfy" type="Text" validate="integer" maxlength="4" value="#QgetAdmin.fy#"></td> <td><cfinput name="sysfy_sp" type="Text" validate="integer" maxlength="4" value="#QgetAdmin.sp_fy#"></td> </tr> <tr> <td>Next Years Access?</td> <td><input name="nyr" type="Radio" value="1"<cfif QgetAdmin.nextyr EQ "1"> checked</cfif>>YES<input name="nyr" type="Radio" value="0"<cfif QgetAdmin.nextyr EQ "0"> checked</cfif>>NO</td> <td><input name="nyr_sp" type="Radio" value="1"<cfif QgetAdmin.sp_nextyr EQ "1"> checked</cfif>>YES<input name="nyr_sp" type="Radio" value="0"<cfif QgetAdmin.sp_nextyr EQ "0"> checked</cfif>>NO</td> </tr> <!--- <tr>
				<td>Last Years Access?</td>
				<td><input name="lyr" type="Radio" value="1"<cfif session.prevyr EQ "1"> checked</cfif>>YES<input name="lyr" type="Radio" value="0"<cfif session.prevyr EQ "0"> checked</cfif>>NO</td>
				</tr>
				<tr>
				<td>Enable Area Manager New Strategy Alert:</td>
				<td><input name="stratManagAlert" type="Radio" value="1"<cfif application.stratAlert EQ "1"> checked</cfif>>YES<input name="stratManagAlert" type="Radio" value="0"<cfif application.stratAlert EQ "0"> checked</cfif>>NO</td>
				<td><input name="stratManagAlert_sp" type="Radio" value="1"<cfif application.stratAlert EQ "1"> checked</cfif>>YES<input name="stratManagAlert" type="Radio" value="0"<cfif application.stratAlert EQ "0"> checked</cfif>>NO</td>
				</tr>---> <tr><td colspan="2"><input type="Submit" class="AddButton"></td></tr> </table> </cfform> </td></tr>
		</table>
		</td></tr> </table></td></tr> </body>
</html>

