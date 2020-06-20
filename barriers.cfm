<!--- Select previous month barrier data --->
<script language="JavaScript" src="../spellchecker/spell.js"></script>

<cfif session.modality NEQ 4>
<cfquery datasource="#application.DataSource#"  		
			 
			password="#application.db_password#"   		
			username="#application.db_username#" name="oldprog">
			
			select c.mon, progress, success, barriers
			from months as c, #tablename# as z
			where ((z.userid= '#activityInfo.userid#'
			and z.activity='#activity#') or (z.activity='#activity#' and z.activity like '*%' and z.userid='shared'))
			and c.mon=z.month2
			and c.year2=z.year2
			and c.rank =
			(select max(d.rank) from monthS as d, #tablename# as a, monthS as b
			where d.mon = a.month2 
			and d.year2 = a.year2
			and A.progress is not null 
			and rtrim(cast(a.progress as varchar)) <> ''
			and d.mon != '#form.month#'
			AND  ((A.userid = '#session.userid#'
			and A.activity = '#activity#') or (A.Activity like '*%' and A.activity = '#activity#' and A.userid='SHARED'))
			and A.year2 = #form.year#
			and b.mon='#form.month#'
			and d.rank < b.rank
			)			
			and ((z.userid= '#activityInfo.userid#'
			and z.activity='#activity#') or (z.activity='#activity#' and z.activity like '*%' and z.userid='shared'))
			and z.year2 = #form.year#		
			
	<!--- select progress, success, barriers
	from #tablename# as a
	where userid = '#activityInfo.userid#'
	and activity = '#activity#'
	and month2=(select c.mon from monthS as c where c.rank =
			(select max(d.rank) from monthS as d 
			where d.mon = a.month2 
			and A.progress is not null and rtrim(a.progress) <> ''
			and d.mon != '#form.month#'
			AND  A.userid = '#session.userid#'
			and A.activity = '#activity#'
			and A.year2 = #form.year#))
	and year2 = #form.year#		 --->



</cfquery>




<cfquery datasource="#application.DataSource#"  		
			 
			password="#application.db_password#"   		
			username="#application.db_username#" name="oldsucc">
			select c.mon, progress, success, barriers
			from months as c, #tablename# as z
			where ((z.userid= '#activityInfo.userid#'
			and z.activity='#activity#') or (z.activity='#activity#' and z.activity like '*%' and z.userid='shared'))
			and c.mon=z.month2
			and c.year2 = z.year2
			and c.rank =
			(select max(d.rank) from monthS as d, #tablename# as a, monthS as b
			where d.mon = a.month2 
			and d.year2 = a.year2
			and A.success is not null 
			and rtrim(cast(a.success as varchar)) <> ''
			and d.mon != '#form.month#'
			AND  ((A.userid = '#session.userid#'
			and A.activity = '#activity#') or (A.Activity like '*%' and A.activity = '#activity#' and A.userid='SHARED'))
			and A.year2 = #form.year#
			and b.mon='#form.month#'
			and d.rank < b.rank
			)			
			and((z.userid= '#activityInfo.userid#'
			and z.activity='#activity#') or (z.activity='#activity#' and z.activity like '*%' and z.userid='shared'))
			and z.year2 = #form.year#	
			
	<!--- select  success
	from #tablename# as a
	where userid = '#activityInfo.userid#'
	and activity = '#activity#'
	and month2=(select c.mon from monthS as c where c.rank =
			(select max(d.rank) from monthS as d 
			where d.mon = a.month2 
			and A.success is not null  and rtrim(a.success) <> ''
			and d.mon != '#form.month#'
			AND  A.userid = '#activityInfo.userid#'
			and A.activity = '#activity#'
			and A.year2 = #form.year#))
	and year2 = #form.year#		 --->



</cfquery>

<cfquery datasource="#application.DataSource#"  		
			 
			password="#application.db_password#"   		
			username="#application.db_username#" name="oldbarr">
			
			select c.mon, progress, success, barriers
			from months as c, #tablename# as z
			where ((z.userid= '#activityInfo.userid#'
			and z.activity='#activity#') or (z.activity='#activity#' and z.activity like '*%' and z.userid='shared'))
			and c.mon=z.month2
			and c.year2=z.year2
			and c.rank =
			(select max(d.rank) from monthS as d, #tablename# as a, monthS as b
			where d.mon = a.month2 
			and d.year2 = a.year2
			and A.barriers is not null 
			and rtrim(cast(a.barriers as varchar)) <> ''
			and d.mon != '#form.month#'
			AND  ((A.userid = '#session.userid#'
			and A.activity = '#activity#') or (A.Activity like '*%' and A.activity = '#activity#' and A.userid='SHARED'))
			and A.year2 = #form.year#
			and b.mon='#form.month#'
			and d.rank < b.rank
			)			
			and ((z.userid= '#activityInfo.userid#'
			and z.activity='#activity#') or (z.activity='#activity#' and z.activity like '*%' and z.userid='shared'))
			and z.year2 = #form.year#	
			
	<!--- select barriers
	from #tablename# as a
	where userid = '#activityInfo.userid#'
	and activity = '#activity#'
	and month2=(select c.mon from monthS as c where c.rank =
			(select max(d.rank) from monthS as d 
			where d.mon = a.month2 
			and A.barriers is not null and rtrim(a.barriers) <> ''
			and d.mon != '#form.month#'
			AND  A.userid = '#activityInfo.userid#'
			and A.activity = '#activity#'
			and A.year2 = #form.year#))
	and year2 = #form.year#		
 --->


</cfquery>

<cfelse>

<cfquery datasource="#application.DataSource#"  		
			 
			password="#application.db_password#"   		
			username="#application.db_username#" name="oldprog">
			
			select c.mon, progress, success, barriers
			from months as c, #tablename# as z
			where ((z.userid= '#activityInfo.userid#'
			and z.activity='#activity#') or (z.activity='#activity#' and z.activity like '*%' and z.userid='shared'))
			and c.mon=z.month2
			and c.year2=z.year2
			and c.sp_rank =
			(select max(d.sp_rank) from monthS as d, #tablename# as a, monthS as b
			where d.mon = a.month2 
			and A.progress is not null 
			and rtrim(cast(a.progress as varchar)) <> ''
			and d.mon != '#form.month#'
			AND  ((A.userid = '#session.userid#'
			and A.activity = '#activity#') or (A.Activity like '*%' and A.activity = '#activity#' and A.userid='SHARED'))
			and A.year2 = #form.year#
			and b.mon='#form.month#'
			and d.sp_rank < b.sp_rank
			)			
			and ((z.userid= '#activityInfo.userid#'
			and z.activity='#activity#') or (z.activity='#activity#' and z.activity like '*%' and z.userid='shared'))
			and z.year2 = #form.year#		
			
	<!--- select progress, success, barriers
	from #tablename# as a
	where userid = '#activityInfo.userid#'
	and activity = '#activity#'
	and month2=(select c.mon from monthS as c where c.rank =
			(select max(d.rank) from monthS as d 
			where d.mon = a.month2 
			and A.progress is not null and rtrim(a.progress) <> ''
			and d.mon != '#form.month#'
			AND  A.userid = '#session.userid#'
			and A.activity = '#activity#'
			and A.year2 = #form.year#))
	and year2 = #form.year#		 --->



</cfquery>




<cfquery datasource="#application.DataSource#"  		
			 
			password="#application.db_password#"   		
			username="#application.db_username#" name="oldsucc">
			select c.mon, progress, success, barriers
			from months as c, #tablename# as z
			where ((z.userid= '#activityInfo.userid#'
			and z.activity='#activity#') or (z.activity='#activity#' and z.activity like '*%' and z.userid='shared'))
			and c.mon=z.month2
			and c.year2=z.year2
			and c.sp_rank =
			(select max(d.sp_rank) from monthS as d, #tablename# as a, monthS as b
			where d.mon = a.month2 
			and A.success is not null 
			and rtrim(cast(a.success as varchar)) <> ''
			and d.mon != '#form.month#'
			AND  ((A.userid = '#session.userid#'
			and A.activity = '#activity#') or (A.Activity like '*%' and A.activity = '#activity#' and A.userid='SHARED'))
			and A.year2 = #form.year#
			and b.mon='#form.month#'
			and d.sp_rank < b.sp_rank
			)			
			and((z.userid= '#activityInfo.userid#'
			and z.activity='#activity#') or (z.activity='#activity#' and z.activity like '*%' and z.userid='shared'))
			and z.year2 = #form.year#	
			
	<!--- select  success
	from #tablename# as a
	where userid = '#activityInfo.userid#'
	and activity = '#activity#'
	and month2=(select c.mon from monthS as c where c.rank =
			(select max(d.rank) from monthS as d 
			where d.mon = a.month2 
			and A.success is not null  and rtrim(a.success) <> ''
			and d.mon != '#form.month#'
			AND  A.userid = '#activityInfo.userid#'
			and A.activity = '#activity#'
			and A.year2 = #form.year#))
	and year2 = #form.year#		 --->



</cfquery>

<cfquery datasource="#application.DataSource#"  		
			 
			password="#application.db_password#"   		
			username="#application.db_username#" name="oldbarr">
			
			select c.mon, progress, success, barriers
			from months as c, #tablename# as z
			where ((z.userid= '#activityInfo.userid#'
			and z.activity='#activity#') or (z.activity='#activity#' and z.activity like '*%' and z.userid='shared'))
			and c.mon=z.month2
			and c.year2=z.year2
			and c.sp_rank =
			(select max(d.sp_rank) from monthS as d, #tablename# as a, monthS as b
			where d.mon = a.month2 
			and A.barriers is not null 
			and rtrim(cast(a.barriers as varchar)) <> ''
			and d.mon != '#form.month#'
			AND  ((A.userid = '#session.userid#'
			and A.activity = '#activity#') or (A.Activity like '*%' and A.activity = '#activity#' and A.userid='SHARED'))
			and A.year2 = #form.year#
			and b.mon='#form.month#'
			and d.sp_rank < b.sp_rank
			)			
			and ((z.userid= '#activityInfo.userid#'
			and z.activity='#activity#') or (z.activity='#activity#' and z.activity like '*%' and z.userid='shared'))
			and z.year2 = #form.year#	
			
	<!--- select barriers
	from #tablename# as a
	where userid = '#activityInfo.userid#'
	and activity = '#activity#'
	and month2=(select c.mon from monthS as c where c.rank =
			(select max(d.rank) from monthS as d 
			where d.mon = a.month2 
			and A.barriers is not null and rtrim(a.barriers) <> ''
			and d.mon != '#form.month#'
			AND  A.userid = '#activityInfo.userid#'
			and A.activity = '#activity#'
			and A.year2 = #form.year#))
	and year2 = #form.year#		
 --->


</cfquery>
</cfif>

<!--- End select previous month barrier data --->

<cfoutput>
<tr><td>Strategy Progress:</td></tr>
<cfif oldprog.recordcount GT 0 and oldprog.progress NEQ "">
<tr>
	<td colspan="2">
		<table width="75%" class="table2">
			<tr>
				<td width="600">#oldprog.progress#</td>
			</tr>
		</table>
	</td>
</tr>
</cfif>
<tr><td colspan="3"><textarea name="activityProgress" cols="120" rows="8"  onKeyDown="textCounter(this.form.activityProgress,2200);" onKeyUp="textCounter(this.form.activityProgress,2200);"><cfif isDefined("form.activityProgress")>#form.activityProgress#</cfif></textarea>
<!--- <input type="button" value="Spellcheck" onclick="doSpell2('monthlyActivity.activityProgress.value');">  --->
</td></tr>

<tr><td>Reasons for Success:</td></tr>
<cfif oldsucc.recordcount GT 0 and oldsucc.success NEQ "">
<tr>
	<td colspan="2">
		<table width="75%" class="table2">
			<tr>
				<td width="600">#oldsucc.success#</td>
			</tr>
		</table>
	</td>
</tr>
</cfif>
<tr><td colspan="3"><textarea name="Successes" cols="120" rows="8" onKeyDown="textCounter(this.form.Successes,2200);" onKeyUp="textCounter(this.form.Successes,2200);"><cfif isDefined("form.Successes")>#form.Successes#</cfif></textarea>
<!--- <input type="button" value="Spellcheck" onclick="doSpell2('monthlyActivity.Successes.value');">  --->
</td></tr>


<tr><td>Barriers:</td></tr>
<cfif oldbarr.recordcount GT 0 and oldbarr.barriers NEQ "">
<tr>
	<td colspan="2">
		<table width="75%" class="table2">
			<tr>
				<td width="600">#oldbarr.barriers#</td>
			</tr>
		</table>
	</td>
</tr>
</cfif>
<tr><td colspan="3"><textarea name="barriers" cols="120" rows="8"  onKeyDown="textCounter(this.form.barriers,2200);" onKeyUp="textCounter(this.form.barriers,2200);"><cfif isDefined("form.barriers")>#form.barriers#</cfif></textarea>
<!--- <input type="button" value="Spellcheck" onclick="doSpell2('monthlyActivity.barriers.value');">
 --->
 </td></tr>
 
 <tr>
 	<td colspan="3">
	 <input type="button" value="Check Spelling" onClick="spell('document.monthlyActivity.activityProgress.value', 'document.monthlyActivity.Successes.value','document.monthlyActivity.barriers.value')">
	</td>
 </tr>
</cfoutput>


