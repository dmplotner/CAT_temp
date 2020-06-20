<cfset prog_num = 'progress'&suffix>
<cfset suc_num = 'success'&suffix>
<cfset bar_num = 'barriers'&suffix>

<cfquery datasource="#application.DataSource#"  		
			 
			password="#application.db_password#"   		
			username="#application.db_username#" name="CurSucProgbar">
select   #prog_num# as progress, #suc_num# as success, #bar_num# as barriers
			from  advoc
			where userid = '#Guserid#'
			and activity = '#Gactivity#'
			and month2='#thisRptMon#'
			and year2=#session.fy#
</cfquery>




<cfif trim(CurSucProgbar.progress) NEQ ""  or trim(CurSucProgbar.success) NEQ "" or trim(CurSucProgbar.barriers) NEQ "">
<table border=".5" width="100%" cellspacing="0">
<tr>
	<th colspan="2">
	<CFIF SUFFIX EQ "_2">Mini-grants
	<CFELSEIF SUFFIX EQ "_3">Administrative Commitment
	<CFELSEIF SUFFIX EQ "_4">Training
	<CFELSEIF SUFFIX EQ "_5">Technical Assistance
	</CFIF> (<cfoutput>#thisRptMon#</cfoutput>)
	</th>
</tr>
<tr>
<td width="27%">Strategy Progress:</td>
<td><cfoutput>#CurSucProgbar.progress#</cfoutput>&nbsp;</td>
</tr>
<tr>
<td>Reasons for Success:</td>
<td><cfoutput>#CurSucProgbar.success#</cfoutput>&nbsp;</td>
</tr>
<tr>
<td>Barriers:</td>
<td><cfoutput>#CurSucProgbar.barriers#</cfoutput>&nbsp;</td>
</tr>
</table>
</cfif>

