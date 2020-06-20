<cfif isdefined("form.startdate") and #form.startdate# is not ''>
<cfset pos = #find("/",form.startdate)#>
<cfif #pos# is 2>
<cfset m = #left(form.startdate,1)#>
<cfelse>
<cfset m = #left(form.startdate,2)#>
</cfif>
<cfset y = #right(form.startdate,4)#>
<cfset startdate = #m# &'/'&'1'&'/'&#y#>
</cfif>
<cfif isdefined("form.enddate") and #form.enddate# is not ''>
<cfset pos2 = #find("/",form.enddate)#>
<cfif #pos2# is 2>
<cfset mm = #left(form.enddate,1)#>
<cfelse>
<cfset mm = #left(form.enddate,2)#>
</cfif>
<cfset yy = #right(form.enddate,4)#>
<cfset enddate = #mm# &'/'&'1'&'/'&#yy#>
</cfif>

<cfoutput>
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="checkForum">
	
	select activity 
	from ADVOC
	where activity = '#form.oldrpt#'
	<!--- and strategy='#form.strategy#' --->
	and userid = '#form.rptuserid#'
	and month2= '#form.month#'		
	and year2= '#form.year#'		
</cfquery>
<cfif checkForum.recordCount EQ 0>
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="insertForum">	
	insert into ADVOC
	(userid, activity, month2, year2, strategy)
	values('#form.rptuserid#', '#form.oldRpt#', '#form.month#', '#form.year#', '#form.strategy#'	)
</cfquery>
</cfif>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="updateForum">
	Update ADVOC
	set revStart = '#startDate#',
RevEnd = '#endDate#',
	status = '#form.actstatus#',
	note = '#form.changedDates#',
	<cfif isDefined("form.numtrained") > numbertrained = '#form.numtrained#', </cfif> 
	<cfif isDefined("form.lentrained") > hourstrained = '#form.lentrained#', </cfif> 
	<cfif isDefined("form.internalTraining") > intTrain = '#form.internalTraining#', </cfif> 
	
	<cfif isDefined("form.monStatus") > monStatus = #form.monStatus#, </cfif>
	<cfif isDefined("form.distIncent") > distIncent = #form.distIncent#, </cfif>
	<cfif isDefined("form.direction") > direction = #form.direction#, </cfif>
	
	<cfif isDefined("form.impact_none")>impact_none=#form.impact_none#, </cfif>
	<cfif isDefined("form.impact_study")>impact_study=#form.impact_study#, </cfif>
	<cfif isDefined("form.impact_change")>impact_change=#form.impact_change#, </cfif>
	<cfif isDefined("form.impact_commit")>impact_commit=#form.impact_commit#, </cfif>
	
	<cfif isDefined("form.impact_action")>impact_action=#form.impact_action#, </cfif>
	<cfif isDefined("form.impact_action_txt")>impact_action_txt='#htmleditformat(form.impact_action_txt)#', </cfif>
	<cfif isDefined("form.impact_imp")>impact_imp=#form.impact_imp#, </cfif>
	<cfif isDefined("form.impact_imp_txt")>impact_imp_txt='#htmleditformat(form.impact_imp_txt)#', </cfif>
	
	<cfif isDefined("form.impact_neg")>impact_neg=#form.impact_neg#, </cfif>
	
	<cfif isDefined("form.num_study")>num_study='#form.num_study#', </cfif>
	<cfif isDefined("form.num_change")>num_change='#form.num_change#', </cfif>
	<cfif isDefined("form.num_commit")>num_commit='#form.num_commit#', </cfif>	
	<cfif isDefined("form.num_neg")>num_neg='#form.num_neg#', </cfif>	
	
	<cfif isDefined("form.reported")>reported = #form.reported#,</cfif>
	<cfif isDefined("form.surveyval")>assess_survey = #form.surveyval#, </cfif>
	<cfif isDefined("form.train_bool")>training = #form.train_bool#, </cfif>
	<cfif isDefined("form.survey_bool")> surveys = #form.survey_bool#, </cfif>
	
	<cfif isDefined("form.preTarget")>preTarget = #form.preTarget#, </cfif>
	<cfif isDefined("form.preTargetDescrip")> preTargetDescrip = '#htmleditformat(form.preTargetDescrip)#', </cfif>
	
	<cfif isDefined("form.tcpsust")>tcpsust = #form.tcpsust#, </cfif>
	<cfif isDefined("form.tcpsust_text")>tcpsust_text = '#htmleditformat(form.tcpsust_text)#', </cfif>

	<cfif isDefined("form.activityProgress")>progress = '#htmleditformat(form.activityProgress)#',</cfif>
	<cfif isDefined("form.successes")>success = '#htmleditformat(form.successes)#',</cfif>
	<cfif isDefined("form.barriers")>barriers = '#htmleditformat(form.barriers)#',</cfif>
	<cfif isDefined("form.earned") and form.earned EQ "1">
	earnedMedia = 1
	<cfelse>
	earnedMedia = 0
	</cfif>	
	where activity = '#form.oldRpt#'
	and userid = '#form.rptuserid#'
	and month2= '#form.month#'		
	and year2= '#session.fy#'	
</cfquery>


</cfoutput>