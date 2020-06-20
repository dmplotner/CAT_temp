
<cfquery datasource="#application.DataSource#"  		
			 
			password="#application.db_password#"   		
			username="#application.db_username#" name="oldprog">
	select progress
	from #tablename# as a
	where userid = '#Guserid#'
	and activity = '#Gactivity#'
	and month2='#thisRptMon#'
	<!---(select c.mon from monthS as c where c.rank =
			(select max(d.rank) from monthS as d , #tablename# as e
			where d.mon = e.month2 
			and e.progress is not null and rtrim(a.progress) <> ''
			AND  e.userid = '#session.userid#'
			and e.activity = '#QGenDescrip.activity#'
			and e.year2 = #session.fy#
			 and d.rank >=#form.stmonth#
			and d.rank <=#form.endmonth#) )--->
	and year2 = #session.fy#		
</cfquery>


<cfquery datasource="#application.DataSource#"  		
			 
			password="#application.db_password#"   		
			username="#application.db_username#" name="oldsucc">
	select  success
	from #tablename# as a
	where userid = '#Guserid#'
	and activity = '#Gactivity#'
	and month2='#thisRptMon#'
	<!---(select c.mon from monthS as c where c.rank =
			(select max(d.rank) from monthS as d , #tablename# as e
			where d.mon = e.month2 
			and e.success is not null and rtrim(a.success) <> ''			
			AND  e.userid = '#session.userid#'
			and e.activity = '#QGenDescrip.activity#'
			and e.year2 = #session.fy#
			 and d.rank >=#form.stmonth#
			and d.rank <=#form.endmonth#)) --->
	and year2 = #session.fy#	



</cfquery>

<cfquery datasource="#application.DataSource#"  		
			 
			password="#application.db_password#"   		
			username="#application.db_username#" name="oldbarr">
	select  barriers
	from #tablename# as a
	where userid = '#Guserid#'
	and activity = '#Gactivity#'
	and month2='#thisRptMon#'
	<!---(select c.mon from monthS as c where c.rank =
			(select max(d.rank) from monthS as d , #tablename# as e
			where d.mon = e.month2 
			and e.barriers is not null and rtrim(a.barriers) <> ''
			AND  e.userid = '#session.userid#'
			and e.activity = '#QGenDescrip.activity#'
			and e.year2 = #session.fy#
			 and d.rank >=#form.stmonth#
			and d.rank <=#form.endmonth#) )--->
	and year2 = #session.fy#		
</cfquery>

<cfif trim(oldprog.progress) NEQ ""  or trim(oldsucc.success) NEQ "" or trim(oldbarr.barriers) NEQ "">
<cfinclude template="sustain.cfm">
<table border=".5" width="100%" cellspacing="0">
<tr>
<td width="27%"><strong>Strategy Progress</strong> (<cfoutput>#thisRptMon#</cfoutput>)</td>
<td><cfif oldprog.recordcount GT 0><cfoutput>#oldprog.progress#</cfoutput></cfif>&nbsp;</td>
</tr>
<tr>
<td><strong>Reasons for Success</strong> (<cfoutput>#thisRptMon#</cfoutput>)</td>
<td><cfif oldsucc.recordcount GT 0><cfoutput>#oldsucc.success#</cfoutput></cfif>&nbsp;</td>
</tr>
<tr>
<td><strong>Barriers</strong> (<cfoutput>#thisRptMon#</cfoutput>)</td>
<td><cfif oldbarr.recordcount GT 0><cfoutput>#oldbarr.barriers#</cfoutput></cfif>&nbsp;</td>
</tr>

<cfquery datasource="#application.DataSource#"  		
			 
			password="#application.db_password#"   		
			username="#application.db_username#" name="earned">
			
		select count(earnedMedia) as count
	from #tablename#
	where userid= '#Guserid#' 
	and activity = '#Gactivity#'
	and year2 = #session.fy#
	and month2 ='#thisRptMon#'
	and earnedMedia=1
	
	</cfquery>
<tr>
<td>Earned Media (<cfoutput>#thisRptMon#</cfoutput>)</td>
<td>Yes <input type="checkbox" <cfif earned.count GT 0>checked</cfif> disabled>&nbsp;&nbsp;&nbsp;&nbsp; No <input type="checkbox" <cfif earned.count NEQ "1" or NOT isDefined("earned.count")>checked</cfif> disabled></td>
</tr>

<!--- </cfif> --->
</table>
</cfif>
<br><br>