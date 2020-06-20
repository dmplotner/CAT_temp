<tr><td colspan="2">
<div id="restInPeace">
<table width=800 border=".1" cellpadding=10 cellspacing="2" class="boxy">
<cfoutput query="Qcheckboxes2" group="sectid">

<tr>
	<th><!---Present at Baseline---></th>
	<th>#Qcheckboxes2.heading#</th>
</tr>
<cfoutput>
<cfif isdefined("form.sname1") and not isdefined("save") and (not isdefined("chach")) and (#form.sname1# is not '')>

         <CFQUERY NAME="getbline" 
		 DATASOURCE="#application.DataSource#"
         USERNAME="#application.db_username#"
         PASSWORD="#application.db_password#">
	   select value
	   from sp_baseline
	   where district = '#form.sname1#' and variable = '#q#' and  userid = '#session.userid#'
	   	   union
	   select value
	   from sp_monthly
	   where district = '#form.sname1#' and variable = '#q#' and mo <> #session.monum# and  userid = '#session.userid#'
</CFQUERY>	 
          <CFQUERY NAME="getblinenow" 
		 DATASOURCE="#application.DataSource#"
         USERNAME="#application.db_username#"
         PASSWORD="#application.db_password#">
	   select value
	   from sp_monthly
	   where district = '#form.sname1#' and variable = '#q#' and mo = #session.monum# and  userid = '#session.userid#'
</CFQUERY>
    </cfif>
<input type="hidden" name="q" value="#q#">

<tr>
<td align="center"><input type="checkbox" name="#Q#" value="1" <cfif isdefined("getblinenow.value") and #getblinenow.value# EQ 1>checked</cfif> <cfif isdefined("getbline.value") and #getbline.value# EQ 1 and not isdefined("clear")>disabled checked</cfif> 
></td>
<td valign="top">#descr#</td>
</tr>



</cfoutput>


</cfoutput>
</table></div></td></tr>
<tr><td colspan="2">
<div id="restInPeace2">
<table width=800 border=".1" cellpadding=10 cellspacing="2" class="boxy">
<cfoutput query="Qcheckboxes3" group="sectid">

<tr>
	<th><!---Present at Baseline---></th>
	<th>#Qcheckboxes3.heading#</th>
</tr>
<cfoutput>
<cfif isdefined("form.sname1") and not isdefined("save") and (not isdefined("chach")) and (#form.sname1# is not '')>

         <CFQUERY NAME="getbline" 
		 DATASOURCE="#application.DataSource#"
         USERNAME="#application.db_username#"
         PASSWORD="#application.db_password#">
	   select value
	   from sp_baseline
	   where district = '#form.sname1#' and variable = '#q#' and  userid = '#session.userid#'
	   	   union
	   select value
	   from sp_monthly
	   where district = '#form.sname1#' and variable = '#q#' and mo <> #session.monum# and  userid = '#session.userid#'
</CFQUERY>	 
          <CFQUERY NAME="getblinenow" 
		 DATASOURCE="#application.DataSource#"
         USERNAME="#application.db_username#"
         PASSWORD="#application.db_password#">
	   select value
	   from sp_monthly
	   where district = '#form.sname1#' and variable = '#q#' and mo = #session.monum# and  userid = '#session.userid#'
</CFQUERY>
     
        <!--- <CFQUERY NAME="mon" 
		 DATASOURCE="#application.DataSource#"
         USERNAME="#application.db_username#"
         PASSWORD="#application.db_password#">
	   select *
	   from sp_mon
	   where bedscode = '#form.sname1#' and mon = #session.monum# and  userid = '#session.userid#'
</CFQUERY>---></cfif>
<input type="hidden" name="q" value="#q#">

<tr>
<td align="center"><input type="checkbox" name="#Q#" value="1" <cfif isdefined("getblinenow.value") and #getblinenow.value# EQ 1>checked</cfif> <cfif isdefined("getbline.value") and #getbline.value# EQ 1 and not isdefined("clear")>disabled checked</cfif> 
></td>
<td valign="top">#descr#</td>
</tr>



</cfoutput>


</cfoutput>
</table></div></td></tr>
<tr><td colspan="2">
<div id="restInPeace3">
<table width=800 border=".1" cellpadding=10 cellspacing="2" class="boxy">
<cfoutput query="Qcheckboxes4" group="sectid">

<tr>
	<th><!---Present at Baseline---></th>
	<th>#Qcheckboxes4.heading#</th>
</tr>
<cfoutput>
<cfif isdefined("form.sname1") and not isdefined("save") and (not isdefined("chach")) and (#form.sname1# is not '')>

         <CFQUERY NAME="getbline" 
		 DATASOURCE="#application.DataSource#"
         USERNAME="#application.db_username#"
         PASSWORD="#application.db_password#">
	   select value
	   from sp_baseline
	   where district = '#form.sname1#' and variable = '#q#' and  userid = '#session.userid#'
	   	   union
	   select value
	   from sp_monthly
	   where district = '#form.sname1#' and variable = '#q#' and mo <> #session.monum# and  userid = '#session.userid#'
</CFQUERY>	 
          <CFQUERY NAME="getblinenow" 
		 DATASOURCE="#application.DataSource#"
         USERNAME="#application.db_username#"
         PASSWORD="#application.db_password#">
	   select value
	   from sp_monthly
	   where district = '#form.sname1#' and variable = '#q#' and mo = #session.monum# and  userid = '#session.userid#'
</CFQUERY>
</cfif>
<input type="hidden" name="q" value="#q#">

<tr>
<td align="center"><input type="checkbox" name="#Q#" value="1" <cfif isdefined("getblinenow.value") and #getblinenow.value# EQ 1>checked</cfif> <cfif isdefined("getbline.value") and #getbline.value# EQ 1 and not isdefined("clear")>disabled checked</cfif> 
></td>
<td valign="top">#descr#</td>
</tr>



</cfoutput>


</cfoutput>
</table></div></td></tr>

</table>
