

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QSelMG">
	select  
	collab_id, funded_service, amount, award_date, a.seq, name,
	case 
	 when b.unit IS NULL then b.NAME
	 else b.unit + ' ' + b.NAME
	end as unitname
	from chco_mgf as a, collaborators as b	
	where 
	a.userid='#Guserid#'
	and a.year2=#session.fy#
	and a.month2='#thisRptMon#'	
	and a.collab_id=b.seq
	and a.strategy = '#Gactivity#'
	order by 6
</cfquery>

<cfif QSelMG.recordcount GT 0>
<cfoutput>
<table border=".5" width="100%" cellspacing="0">
<tr>
	<th colspan="4">
		Collaborating Health Care Organizations Receiving Mini-grant Funding (<cfoutput>#thisRptMon#</cfoutput>)
	</th>
</tr>
<tr>
	<td>Collaborator Name</td>
	<td>Funded Service</td>
	<td>Amount</td>
	<td>Award Date</td>	
</tr>
<cfloop query="QSelMG">

<tr>
	<td>#QSelMG.unitname#</td>
	<td>#QSelMG.funded_service#</td>
	<td>$#QSelMG.amount#</td>
	<td>#dateformat(QSelMG.award_date, 'm/d/yyyy')#</td>
	
</tr>
</cfloop>
</table>
</cfoutput>

</cfif>
<br>
<cfset suffix= "_2">
<cfinclude template="hcpo_success.cfm">

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QSelAC">
	select  
	collab_id, method, contact_date, material, a.seq, name,
	case 
	 when b.unit IS NULL then b.NAME
	 else b.unit + ' ' + b.NAME
	end as unitname
	from cchco_ac as a, collaborators as b
	
	where 
	a.userid='#Guserid#'
	and a.year2=#session.fy#
	and a.month2='#thisRptMon#'	
	and a.collab_id=b.seq
	and a.strategy = '#Gactivity#'
	order by 6
</cfquery>


<cfif QSelAC.recordcount GT 0>
<table border=".5" width="100%" cellspacing="0">
<tr>
	<th colspan="4">Contacts with Collaborating Health Care Organizations to get Administrative Commitment (<cfoutput>#thisRptMon#</cfoutput>)</th>
</tr>
<tr>
	<td>Collaborator</td>
	<td>Method of Contact</td>
	<td>Date of Contact</td>
	<td>Resources and Information Provided</td>	  	  	  	
</tr>

<cfoutput>
<cfloop query="QSelAC">
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QAC_det_method">
	select id, descr
	from lu_cchco_commit_method
	where id in (#QSelAC.method#)
	and year2=#session.fy#
	order by rank
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QAC_det_materials">
	select id, descr
	from lu_cchco_materials
	where id in (#QSelAC.material#)
	and year2=#session.fy#
	order by rank
</cfquery>
<tr>
	<td>#QSelAC.unitname#</td>
	<td>#valueList(QAC_det_method.descr, '<br>')#</td>
	<td>#dateformat(QSelAC.contact_date, 'm/d/yyyy')#</td>
	<td>#valueList(QAC_det_materials.descr, '<br>')#</td>
</tr>
</cfloop>
</cfoutput>


</table>
</cfif>

<br>
<cfset suffix= "_3">
<cfinclude template="hcpo_success.cfm">

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QSelTRAIN">
	select  
	training, train_date, method, credit, type_credit, num_attendees, material,seq
	from cchco_train
	where 
	userid='#Guserid#'
	and year2=#session.fy#
	and month2='#thisRptMon#'	
	and strategy = '#Gactivity#'
	
</cfquery>


<cfif QSelTRAIN.recordcount GT 0>
<table border=".5" width="100%" cellspacing="0">
<tr>
	<th colspan="7">Contacts with Collaborating Health Care Organizations to Provide Training (<cfoutput>#thisRptMon#</cfoutput>)</th>
</tr>
<tr>
	<td>Training Name</td>
	<td>Training Date</td>
	<td>Training Method Used </td>
	<td>Was Continuing education credit offered?</td>	 
	<td>If yes, what type of credit was offered?</td>
	<td>Total # of Attendees</td>
	<td>Resources and Information Provided</td> 	  	  	
</tr>
 	 		 	 	 	
<cfloop query="QSelTRAIN">
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QTRAIN_det_method">
	select id, descr
	from lu_cchco_train_method
	where id in (#QSelTRAIN.method#)
	and year2=#session.fy#
	order by rank
</cfquery>
<cfif isDefined("QSelTRAIN.type_credit") and QSelTRAIN.type_credit NEQ "">
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QTRAIN_det_type">
	select id, descr
	from lu_cchco_train_credit
	where id in (#QSelTRAIN.type_credit#)
	and year2=#session.fy#
	order by rank
</cfquery>
</cfif>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QTRAIN_det_material">
	select id, descr
	from lu_cchco_materials
	where id in (#QSelTRAIN.material#)
	and year2=#session.fy#
	order by rank
</cfquery>
<cfoutput>
<tr>
	<td>#QSelTRAIN.training#</td>
	<td>#dateformat(QSelTRAIN.train_date, 'm/d/yyyy')#</td>
	<td>#QTRAIN_det_method.descr#</td>
	<td><cfif QSelTRAIN.credit EQ 1>YES<cfelse>NO</cfif></td>
	<td><cfif isDefined("QSelTRAIN.type_credit") and QSelTRAIN.type_credit NEQ "">#valueList(QTRAIN_det_type.descr, '<BR>')#<cfelse>&nbsp;</cfif></td>
	<td>#QSelTRAIN.num_attendees#</td>
	<td>#valueList(QTRAIN_det_material.descr, '<br>')#</td>
</tr>
</cfoutput>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QTRAIN_det_collabs">
	select d.train_seq, d.collab_id, d.attend, d.seq, c.name,
	case 
	 when c.unit IS NULL then c.NAME
	 else c.unit + ' ' + c.NAME
	end as unitname
	from CCHCO_TRAIN_DET as d, collaborators as c
	where d.train_seq=#QSelTRAIN.seq#
	and d.collab_id=c.seq
	order by 6	
</cfquery>

<cfif QTRAIN_det_collabs.recordcount GT 0>
<cfoutput>
<cfloop query="QTRAIN_det_collabs">
<tr>	
	<td colspan="3">&nbsp;</td>
	<td colspan="2">Collaborator: #unitname#</td>
	<td colspan="2">Number Attended: #attend#</td>
	
</tr>
</cfloop>


</cfoutput>
</cfif>


</cfloop>
</table>
</cfif>

<br>
<cfset suffix= "_4">
<cfinclude template="hcpo_success.cfm">


<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QSelTA">
	select  
	collab_id, ta_date, method, num_ta, material, a.seq, name,
	case 
	 when unit IS NULL then NAME
	 else unit + ' ' + NAME
	end as unitname 
	from cchco_ta as a, collaborators as b
	where 
	a.userid='#Guserid#'
	and a.year2=#session.fy#
	and a.month2='#thisRptMon#'	
	and a.collab_id=b.seq
	and a.strategy = '#Gactivity#'
</cfquery>


<cfif QSelTA.recordcount GT 0>
<table border=".5" width="100%" cellspacing="0">
<tr>
	<th colspan="7">Contacts with Collaborating Health Care Organizations to provide Technical Assistance (<cfoutput>#thisRptMon#</cfoutput>)</th>
</tr>
<tr>
	<td>Collaborator Receiving TA</td>
	<td>Date</td>
	<td>Method Used</td>
	<td># of Collaborator staff receiving TA</td>	 
	<td>Resources and Information Provided</td>  	  	
</tr>
 	
  	  	  	  	
<cfoutput>
<cfloop query="QSelTA">
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QTA_det_method">
	select id, descr
	from lu_cchco_ta_method
	where id in (#QSelTA.method#)
	and year2=#session.fy#
	order by rank
</cfquery>
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QTA_det_material">
	select id, descr
	from lu_cchco_materials
	where id in (#QSelTA.material#)
	and year2=#session.fy#
	order by rank
</cfquery>
<tr>
	<td>#QSelTA.unitname#</td>
	<td>#dateformat(QSelTA.ta_date, 'm/d/yyyy')#</td>
	<td>#QTA_det_method.descr#</td>
	<td>#QSelTA.num_ta#</td>
	<td>#valueList(QTA_det_material.descr, '<br>')#</td>	
</tr>
</cfloop>
</cfoutput>
</table>
</cfif>

<br>
<cfset suffix= "_5">
<cfinclude template="hcpo_success.cfm">
<!---
ALL PROGRESS, etc:
<cfquery datasource="#application.DataSource#"  		
			 
			password="#application.db_password#"   		
			username="#application.db_username#" name="CurSucProgbar">
select   #prog_num# as progress, #suc_num# as success, #bar_num# as barriers
			from  #tablename# 
			where userid = '#activityInfo.userid#'
			and activity = '#form.activity2#'
			and month2='#form.month#'
			and year2=#form.year#
</cfquery>

<table class="box" align="center">
<tr><td>Strategy Progress:</td></tr>
<cfif oldprog.recordcount GT 0 and oldprog.progress NEQ ""><tr><td colspan="2"><table><tr><td width="600">#oldprog.progress#</td></tr></table></td></tr></cfif>
<tr><td colspan="3"><textarea name="activityProgress" cols="120" rows="8" ><cfif isDefined("form.activityProgress")>#form.activityProgress#</cfif></textarea>
<!--- <input type="button" value="Spellcheck" onclick="doSpell2('cess.activityProgress.value');">  --->
</td></tr>

<tr><td>Reasons for Success:</td></tr>
<cfif oldsucc.recordcount GT 0 and oldsucc.success NEQ ""><tr><td colspan="2"><table><tr><td width="600">#oldsucc.success#</td></tr></table></td></tr></cfif>
<tr><td colspan="3"><textarea name="Successes" cols="120" rows="8"><cfif isDefined("form.Successes")>#form.Successes#</cfif></textarea>
<!--- <input type="button" value="Spellcheck" onclick="doSpell2('cess.Successes.value');">  --->
</td></tr>


<tr><td>Barriers:</td></tr>
<cfif oldbarr.recordcount GT 0 and oldbarr.barriers NEQ ""><tr><td colspan="2"><table><tr><td width="600">#oldbarr.barriers#</td></tr></table></td></tr></cfif> 
<tr><td colspan="3"><textarea name="barriers" cols="120" rows="8" ><cfif isDefined("form.barriers")>#form.barriers#</cfif></textarea>
<!--- <input type="button" value="Spellcheck" onclick="doSpell2('cess.barriers.value');"> --->
</td></tr>

</table> --->