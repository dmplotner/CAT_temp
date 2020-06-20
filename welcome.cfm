<cfif session.userid EQ 'lcurrin' or session.userid EQ 'mmiura' or session.userid EQ 'nhuehnergath' or session.userid EQ 'kpm03' or session.userid EQ 'ksnyder' or session.userid EQ 'iKnopf'>
	<cflocation addtoken="Yes"  url=".././cfforum/login.cfm?userid=#session.userid#">
</cfif>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>
			CAT
		</title>
		<cfinclude template="CATstruct.cfm">
		<div align="left">
			<h2>
				Welcome to CAT
			</h2>
		</div>
		<table class="Table2">
			<tr>
				<td width="70%" valign="top">
					<!--- <div align="right"><INPUT type="button" value="Tobacco Control" onClick="window.open('http://nytobacco.rti.org/bmj/bmjournal2.cfm','mywindow','width=750,height=600,resizable=yes,scrollbars=yes')">
						Click here to open a new window to link<br>to the Tobacco Control journal website</div><BR>
						--->
					<h3>
						Events and Announcements
					</h3>
					<cfquery datasource="#application.DataSource#"

	password="#application.db_password#"
	username="#application.db_username#" name="announcements">
	select st_date, end_date, st_time, end_time, title, descrip, location, url_head, url, seq
	from announcement
	order by seq desc, 1, 2
</cfquery>
					<cfoutput>
						<cfloop query="announcements">
							<strong>
								#title#
							</strong>
							</b></b>
							<br>
							<cfif descrip NEQ "">
								#descrip#
								<br>
							</cfif>
							<cfif location NEQ "">
								#location#
								<br>
							</cfif>
							<cfif st_date NEQ "" and st_date NEQ "1/1/1900">
								#dateformat(st_date, "dddd, mmmm d, yyyy")#
								<cfif st_time NEQ "">
									&nbsp;&nbsp;#timeformat(st_time)#
								</cfif>
							</cfif>
							<cfif end_date NEQ "" and end_date NEQ "1/1/1900">
								- #dateformat(end_date, "dddd, mmmm d, yyyy")#
							</cfif>
							<cfif end_time NEQ "">
								<cfif end_date EQ "">
									-
								</cfif>
								#timeformat(end_time)#
							</cfif>
							<br>
							<cfif url_head NEQ "">
								#url_head#
							</cfif>
							&nbsp;
							<cfif url NEQ "">
								<a href="#trim(url)#" target="_blank">
									#url#
								</a>
							</cfif>
							<br>
							<br>
						</cfloop>
					</cfoutput>
				</td>
				<td>
					<table class="Table2">
						<tr>
							<td   colspan="2" align="left" valign="top" >
								<INPUT type="button" value="Bulletin Board" style = "width:285" ONCLICK="window.location.href='./cfforum/login.cfm?<cfoutput>#session.urltoken#</cfoutput>&userid=<cfoutput>#session.userid#</cfoutput>'">
								<br>
								<br>
							</td>
						</tr>
						<tr>
							<td  colspan="2" align="left" valign="top" >
								<INPUT type="button" value="NYS Quitline Partners Site" style = "width:285" onClick="window.open('https://www.nysmokefree.com/partners/login.aspx?ReturnUrl=%2fpartners%2fDefault.aspx','mywindow','width=750,height=600,resizable=yes,scrollbars=yes')">
								<br>
								<br>
							</td>
						</tr>
						<tr>
							<td  colspan="2" align="left" valign="top" >
								<INPUT type="button" value="BTC Contractor List" style = "width:285" onClick="window.location.href='https://nytobacco.rti.org/conlst.cfm?type=all&<cfoutput>#session.urltoken#</cfoutput>&userid=<cfoutput>#session.userid#</cfoutput>'">
								<br>
								<br>
							</td>
						</tr>
						<tr>
							<td align="left" valign="top" >
								<INPUT type="button" value="Professional Development and Training Program" style = "width:285" onClick="window.open('http://www.albany.edu/sph/cphce/tcpdtp.shtml','mywindow','width=750,height=600,resizable=yes,scrollbars=yes')">
						<tr>
							<td align="left" valign="top" >
								<br>
								<br>
								<INPUT type="button" value="Center for Public Health and Tobacco Policy" style = "width:285" onClick="window.open('http://www.tobaccopolicycenter.org/','mywindow','width=750,height=600,resizable=yes,scrollbars=yes')">
								<br>
								<br>
							</td>
							<cfif SESSION.areamanage EQ "1" OR SESSION.admin EQ "1" OR SESSION.TCP EQ "1" OR SESSION.cessMan NEQ "0">
						<tr> <td  colspan="2" align="left" valign="top" > <br><br> <INPUT type="button" value="BTC Contractor List (BTC staff only)" style = "width:285" onClick="window.location.href='http://nytobacco.rti.org/xlsrpt.cfm?<cfoutput>#session.urltoken#</cfoutput>'"> </td> </tr> </cfif>
					</table>
				</td>
			</tr>
		</table>
		</body>
</html>
