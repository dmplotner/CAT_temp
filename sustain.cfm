<cfquery datasource="#application.DataSource#" 	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="SustainStatus">
	select tcpsust, tcpsust_text
			from #tablename#
			where month2 = '#thisRptMon#'
			AND  userid = '#Guserid#'
			and activity = '#Gactivity#'
			and year2 = #session.fy#			
</cfquery>

<table border=".5" width="100%" cellspacing="0">
<tr>
	<th align="left" width="30%">Sustainability Efforts(<cfoutput>#thisRptMon#</cfoutput>)</th>
</tr>
<tr>
	<td>Did this strategy support TCP sustainability efforts?
	Yes <input type="checkbox" <cfif SustainStatus.tcpsust EQ "1">checked</cfif> disabled> No <input type="checkbox" <cfif SustainStatus.tcpsust EQ "0">checked</cfif> disabled>
	</td>
</tr>
<cfif SustainStatus.tcpsust EQ "1">
<tr>
	<td>If yes, please describe:<br>
	<cfoutput>#sustainStatus.tcpsust_text#</cfoutput>
	</td>
</tr>
</cfif>
</table>