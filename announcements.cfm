<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>
			CAT
		</title>
		<cfinclude template="CATstruct.cfm">
		<script language="JavaScript">
function setval(val){
document.f1.process.value=val;
document.f1.submit();
}
function checkSubject(val){
if(document.f1.seq2.value != "True"){
alert('Please enter or choose an event; or click add anouncement');
return false;
}
setval(val);
}
</script>
		<cfif isDefined("form.process") and form.process EQ "add">
			<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="add_announcment">
	insert into announcement
	(st_date, end_date, st_time, end_time, title, descrip, location, url_head, url)
	values
	(<cfqueryparam value="#htmleditformat(form.start_date)#" cfsqltype="CF_SQL_DATE">, <cfif form.end_date NEQ ""><cfqueryparam value="#htmleditformat(form.end_date)#" cfsqltype="CF_SQL_DATE"><cfelse> NULL</cfif>, <cfif form.start_time NEQ ""><cfqueryparam value="#htmleditformat(form.start_time)#" cfsqltype="CF_SQL_TIME"><cfelse>NULL</cfif>, <cfif form.end_time NEQ ""><cfqueryparam value="#htmleditformat(form.end_time)#" cfsqltype="CF_SQL_TIME"><cfelse>NULL</cfif>, <cfqueryparam value="#htmleditformat(form.event_title)#" cfsqltype="CF_SQL_VARCHAR" maxlength="500">, <cfqueryparam value="#htmleditformat(form.descrip)#" cfsqltype="CF_SQL_VARCHAR" maxlength="4000">, <cfqueryparam value="#htmleditformat(form.location)#" cfsqltype="CF_SQL_VARCHAR" maxlength="180">, <cfqueryparam value="#htmleditformat(form.url_head)#" cfsqltype="CF_SQL_VARCHAR" maxlength="300">, <cfqueryparam value="#form.url_text#" cfsqltype="CF_SQL_VARCHAR" maxlength="500">)
</cfquery>
		<cfelseif isDefined("form.process") and form.process EQ "del">
			<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="del_announcement">
	delete from announcement where  seq in (<cfqueryparam value="#form.seq#" cfsqltype="CF_SQL_INTEGER" list="yes" maxlength="50">)
</cfquery>
		<cfelseif isDefined("form.process") and form.process EQ "upd">
			<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="upd_announcment">
	update announcement
	set
	st_date=<cfqueryparam value="#htmleditformat(form.start_date)#" cfsqltype="CF_SQL_DATE">,
	end_date=<cfif form.end_date NEQ ""><cfqueryparam value="#htmleditformat(form.end_date)#" cfsqltype="CF_SQL_DATE"><cfelse>NULL</cfif>,
	st_time=<cfif form.start_time NEQ ""><cfqueryparam value="#htmleditformat(form.start_time)#" cfsqltype="CF_SQL_TIME"><cfelse>NULL</cfif>,
	end_time=<cfif form.end_time NEQ ""><cfqueryparam value="#htmleditformat(form.end_time)#" cfsqltype="CF_SQL_TIME"><cfelse>NULL</cfif>,
	title=<cfqueryparam value="#htmleditformat(form.event_title)#" cfsqltype="CF_SQL_VARCHAR" maxlength="500">,
	descrip=<cfqueryparam value="#htmleditformat(form.descrip)#" cfsqltype="CF_SQL_VARCHAR" maxlength="4000">,
	location=<cfqueryparam value="#htmleditformat(form.location)#" cfsqltype="CF_SQL_VARCHAR" maxlength="180">,
	url_head=<cfqueryparam value="#htmleditformat(form.url_head)#" cfsqltype="CF_SQL_VARCHAR" maxlength="300">,
	url=<cfqueryparam value="#form.url_text#" cfsqltype="CF_SQL_VARCHAR" maxlength="500">
	where seq = <cfqueryparam value="#form.seq#" cfsqltype="CF_SQL_INTEGER">
</cfquery>
		<cfelseif isDefined("url.val")>
			<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="announce">
	select st_date, end_date, st_time, end_time, title, descrip, location, url_head, url, seq
	from announcement
	where seq = <cfqueryparam value="#url.val#" cfsqltype="CF_SQL_INTEGER">
</cfquery>
		</cfif>
		<cfquery datasource="#application.DataSource#"
	password="#application.db_password#"
	username="#application.db_username#" name="announcements">
	select st_date, end_date, st_time, end_time, title, descrip, location, url_head, url, seq
	from announcement
	order by 1, 2
</cfquery>
		<cfoutput>
			<cfform action="announcements.cfm?#session.urltoken#" name="f1">
				<cfif isDefined("url.val")>
					<input type="hidden" name="seq2" value="True">
				<cfelse>
					<input type="hidden" name="seq2" value="">
				</cfif>
				<input type="hidden" name="process" value="">
				<cfif isDefined("url.val")>
					<input type="hidden" name="seq" value="#url.val#" >
				</cfif>
				<table align="center" class="box">
					<tr>
						<td>
							<table  class="box" align="center" cellpadding="10" cellspacing="0" border="0" >
								<tr>
									<th colspan="2">
										Add Event to Announcements:
									</th>
								</tr>
								<tr>
									<td>
										Event (Start) Date:
									</td>
									<td>
										<input type="Text" name="start_date"
										<cfif isDefined("announce.st_date") and announce.st_date NEQ "1/1/1900">
											value="#dateformat(announce.st_date,'m/d/yyyy')#"
										</cfif>
										> (mm/dd/yyyy)
									</td>
								</tr>
								<tr>
									<td>
										(End Date):
									</td>
									<td>
										<input type="Text" name="end_date"
										<cfif isDefined("announce.end_date") and announce.end_date NEQ "1/1/1900">
											value="#dateformat(announce.end_date,'m/d/yyyy')#"
										</cfif>
										> (mm/dd/yyyy)
									</td>
								</tr>
								<tr>
									<td>
										(Start Time):
									</td>
									<td>
										<input type="Text" name="start_time"
										<cfif isDefined("announce.st_time")>
											value="#timeformat(announce.st_time)#"
										</cfif>
										>
									</td>
								</tr>
								<tr>
									<td>
										(End Time):
									</td>
									<td>
										<input type="Text" name="end_time"
										<cfif isDefined("announce.end_time")>
											value="#timeformat(announce.end_time)#"
										</cfif>
										>
									</td>
								</tr>
								<tr>
									<td>
										Title:
									</td>
									<td>
										<textarea name="event_title" cols="80" rows="3" ><cfif isdefined("announce.title")>#announce.title#</cfif></textarea>
									</td>
								</tr>
								<tr>
									<td>
										Description:
									</td>
									<td>
										<textarea name="descrip" cols="80" rows="5"><cfif isdefined("announce.descrip")>#announce.descrip#</cfif></textarea>
									</td>
								</tr>
								<tr>
									<td>
										Location:
									</td>
									<td>
										<textarea name="location" cols="80" rows="5"><cfif isdefined("announce.location")>#announce.location#</cfif></textarea>
									</td>
								</tr>
								<tr>
									<td>
										URL heading:
									</td>
									<td>
										<input type="Text" name="url_head"
										<cfif isdefined("announce.url_head")>
											value="#announce.url_head#"
										</cfif>
										>
									</td>
								</tr>
								<tr>
									<td>
										URL:
									</td>
									<td>
										<input type="Text" name="url_text" size="80"
										<cfif isdefined("announce.url")>
											value="#announce.url#"
										</cfif>
										>
									</td>
								</tr>
								<tr>
									<td colspan="2" align="center">
										<input type="button" value="Add Announcement" onclick="setval('add');" class="AddButton">
										<input type="button" value="Update Announcement" onclick="checkSubject('upd');">
									</td>
								</tr>
							</table>
							<br>
							<table class="Table" align="center" cellpadding="10" cellspacing="0" border="0">
								<tr>
									<th>
										Title
									</th>
									<th>
										Delete
									</th>
								</tr>
								<cfloop query="announcements">
									<tr>
										<td>
											<a href="announcements.cfm?val=#seq#">
												#title#
											</a>
										</td>
										<td>
											<input type="Checkbox" name="seq" value="#seq#">
										</td>
									</tr>
								</cfloop>
								<tr>
									<td colspan="2" align="center">
										<input type="button" value="Delete Announcement(s)"  onclick="setval('del');" class="DelButton">
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</cfform>
		</cfoutput>
		</body>
</html>

