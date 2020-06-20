<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>
			CAT
		</title>
		<cfinclude template="catstruct.cfm">
		<br>
		<br>
		<br>
		<!--- <cfif #session.fy# GTE '2010' and #session.modality# is not 4> --->
		<a href="cat_wrkplan.cfm?<cfoutput>#session.urltoken#</cfoutput>">
			Contact Info
		</a>
		<!--- <cfelse>
			<a href="cat.cfm?<cfoutput>#session.urltoken#</cfoutput>">Contact Info</a>
			</cfif> --->
		<br>
		<cfif session.modality NEQ 2 and session.modality NEQ 3 and session.modality NEQ 5>
			<cfif NOT(session.fy GTE 2013 and session.modality EQ 1)>
				<a href="collaborators.cfm?<cfoutput>#session.urltoken#</cfoutput>">
					<cfif session.fy GT 2006 and session.modality EQ 1>
						Target HCPOs
					<cfelse>
						Collaborators
					</cfif>
				</a>
			</cfif>
		</cfif>
		<cfif SESSION.admin EQ "1">
			<br>
			<a href="announcements.cfm?<cfoutput>#session.urltoken#</cfoutput>">
				Edit Announcements
			</a>
			<br>
			<a href="admin.cfm?<cfoutput>#session.urltoken#</cfoutput>">
				Update Users
			</a>
			<br>
			<a href="./cfforum/admin.cfm?<cfoutput>#session.urltoken#</cfoutput>">
				Bulletin Board Admin
			</a>
		</cfif>
		<cfif SESSION.areamanage EQ "1" OR SESSION.admin EQ "1" OR SESSION.TCP EQ "1" OR SESSION.cessMan NEQ "0">
			<br>
			<a href="alteruser.cfm?<cfoutput>#session.urltoken#</cfoutput>">
				View Contractor Data
			</a>
		</cfif>
		<cfif SESSION.areamanage EQ "1" OR SESSION.admin EQ "1" OR SESSION.TCP EQ "1" OR SESSION.cessMan NEQ "0">
			<br>
			<a href="AM_feedback_list.cfm?<cfoutput>#session.urltoken#</cfoutput>">
				<cfif session.fy LTE 2008>
					Area
				<Cfelse>
					Contract
				</cfif>
				Manager Feedback
			</a>
		</cfif>
		<cfif session.fy EQ 2008>
			<br>
			<a href="<cfif session.modality eq 2>cp_eoy_progress.cfm?modality=cp&<cfelseif session.modality eq 3>yp_eoy_progress.cfm?modality=yp&<cfelseif session.modality eq 1>cc_eoy_progress.cfm?modality=yp&</cfif><cfoutput>#session.urltoken#</cfoutput>">
				EOY Reports
			</a>
		</cfif>
		</body>
</html>
