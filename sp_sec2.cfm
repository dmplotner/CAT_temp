
<cfoutput query="Qcheckboxes2" group="sectid">

<tr>
	<th>Present at Baseline</th>
	<th>#Qcheckboxes2.heading#</th>
</tr>
<cfoutput>
<!--- <cfif isdefined("form.sname1") and not isdefined("clear")>

         <CFQUERY NAME="getbline" 
		 DATASOURCE="#application.DataSource#"
         USERNAME="#application.db_username#"
         PASSWORD="#application.db_password#">
	   select *
	   from sp_baseline
	   where district = '#form.sname1#' and variable = '#q#'
</CFQUERY>
</cfif> 
	   select *
	   from sp_baseline
	   where DISTRICT = <cfif isdefined("form.sname1")>'#form.sname1#' <cfelseif isdefined("url.seq")>'#url.seq#' <cfelseif qselectedItem.school NEQ "999">'#qselecteditem.school#'<cfelse>'#qselecteditem.district#'</cfif>
	   and variable = '#q#'s
--->
<cfif isdefined("form.sname1") or isdefined("url.seq") or isDefined("qselecteditem.district") and (not isdefined("clear"))>
         <CFQUERY NAME="getbline" 
		 DATASOURCE="#application.DataSource#"
         USERNAME="#application.db_username#"
         PASSWORD="#application.db_password#">
	   select *
	   from sp_baseline
	   where DISTRICT = <cfif isdefined("form.sname1")>'#form.sname1#' <cfelseif qselectedItem.school NEQ "999">'#qselecteditem.school#'<cfelse>'#qselecteditem.district#'</cfif>
	   and variable = '#q#'
</CFQUERY>
</cfif>



<input type="hidden" name="q" value="#q#">

<tr>
<td align="center"><input type="checkbox" name="#Q#" value="1" <cfif isdefined("getbline.value") and #getbline.value# EQ 1 and form.recordSeq NEQ -1>checked</cfif> 
></td>
<td valign="top">#descr#</td>
</tr>



</cfoutput>


</cfoutput>

</table>