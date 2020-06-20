

<cfif isDefined("form.oldMethodName") and form.oldMethodName NEQ "" and form.MethodName NEQ form.oldMethodName>
<!--- update evalm --->
<cfquery datasource="#application.DataSource#" 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QchangEvalm">
	update evalM
	set methodname='#htmleditformat(form.methodname)#'
	where methodname='#htmleditformat(form.oldmethodname)#'
	and userid='#session.userid#'
	and year2=#session.fy#
	
</cfquery>
<!--- update Eval_Ind --->
<cfquery datasource="#application.DataSource#" 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QchangInd">
	update Eval_Ind
	set method='#htmleditformat(form.methodname)#'
	where method='#htmleditformat(form.oldmethodname)#'
	and userid='#session.userid#'
	and year2=#session.fy#
</cfquery>
</cfif>


<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="checkRecord">
	select distinct userid
	from EvalM
	where 
	userid='#session.userid#'
	and methodname = '#htmleditformat(form.methodname)#'
	and year2=#session.fy#
	
</cfquery>

<cfif checkrecord.recordcount LT 1>
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="insertRecord">
	insert into EvalM
	(userid, methodname, year2)
	values	
	('#session.userid#', '#htmleditformat(form.methodname)#', #session.fy#)	
</cfquery>
</cfif>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="updateRecord">
	update EvalM
	set
	
		<cfif isDefined("form.ostartdate")>ostartdate='#form.ostartdate#',</cfif>
		<cfif isDefined("form.oenddate")>oenddate='#form.oenddate#',</cfif>
	<cfif isDefined("form.date_planning")>date_planning='#form.date_planning#',</cfif>
	<cfif isDefined("form.date_collecting")>date_collecting='#form.date_collecting#',</cfif>
	
	<cfif isDefined("form.selectedStrategies")>selectedStrategies='#form.selectedStrategies#',<cfelse>selectedStrategies='',</cfif>
	<cfif isDefined("form.selectedMethods")>selectedMethods='#form.selectedMethods#',<cfelse>selectedMethods='',</cfif>
	<cfif isDefined("form.evalcomments")>evalcomments='#form.evalcomments#',</cfif>
	<cfif isDefined("form.targetpop2")>targetpop2='#form.targetpop2#',</cfif>
	<cfif isDefined("form.detail_one")>detail_one='#form.detail_one#',</cfif>
	
	<cfif isDefined("form.other_eval")>other_eval='#form.other_eval#',</cfif>
	<cfif isDefined("form.other_eval_txt")>other_eval_txt='#form.other_eval_txt#',</cfif>
	<cfif isDefined("form.other_eval_txt2")>other_eval_txt2=<cfqueryparam cfsqltype="cf_sql_varchar" value="#preservesinglequotes(form.other_eval_txt2)#">,</cfif>
	<cfif isDefined("form.primary_dc")>primary_dc='#form.primary_dc#',</cfif>
	<cfif isDefined("form.primary_type")>primary_type='#form.primary_type#',</cfif>
	<cfif isDefined("form.secondary_type")>secondary_type='#form.secondary_type#',</cfif>
	<cfif isDefined("form.secondary_txt")>secondary_txt='#form.secondary_txt#',</cfif>
	<cfif isDefined("form.multi_eval")>multi_eval='#form.multi_eval#',</cfif>
	<cfif isDefined("form.multi_eval_num")>multi_eval_num='#form.multi_eval_num#',</cfif>
	<cfif isDefined("form.infosource")>infosource='#form.infosource#',</cfif>
	<cfif isDefined("form.sampletype")>sampletype='#form.sampletype#',</cfif>
	<cfif isDefined("form.othersampletype")>othersampletype='#form.othersampletype#',</cfif>
		<cfif isDefined("form.casemeth")>casemeth='#form.casemeth#',</cfif>	
	<cfif isDefined("form.analyzer")>analyzer='#form.analyzer#',</cfif>
	<cfif isDefined("form.reporter")>reporter='#form.reporter#',</cfif>
	<cfif isDefined("form.tsert_approv")>tsert_approv='#form.tsert_approv#',</cfif>	
	
	<cfif isDefined("form.tsert_instapprov")>tsert_instapprov='#form.tsert_instapprov#',</cfif>
	<cfif isDefined("form.tsert_date2")>tsert_date='#form.tsert_date2#',</cfif>
	<cfif isDefined("form.tsert_instdate")>tsert_instdate='#form.tsert_instdate#',</cfif>
	<cfif isDefined("form.date_complete")>date_complete='#form.date_complete#',</cfif>	
	<!--- <cfif isDefined("form.casemeth")>casemeth='#form.casemeth#',</cfif> --->	

	<!--- descrip='#htmleditformat(form.name)#', 
	stdate='#form.ostartdate#',
	enddate='#form.oenddate#',--->
	<!--- evalQ='#htmleditformat(form.question)#', --->
	<!--- evid='#htmleditformat(form.evidence)#', --->
	<!--- primSec='#form.primSec#',
	who_analyze='#htmleditformat(form.analyzer)#',
	who_prepare='#htmleditformat(form.reporter)#',
	<cfif isDefined("form.disseminate")>how_dissem='#form.disseminate#',</cfif>
	<cfif isDefined("form.disseminated")>who_dissem='#form.disseminated#',</cfif> --->
	<!--- 
	<CFIF FORM.PRIMSEC eq "1">
	<cfif isDefined("form.method")>coll_meth='#form.method#',</cfif>
	tool_name='#form.tool#',
	target_pop='#form.targetpop#',
	target_org='#form.targetorg#',
	coll_stDate ='#form.startdate#',
	coll_endDate='#form.enddate#',
	select_meth='#form.selectmethod#',
	add_num='#form.num#',
	<CFELSEIF FORM.PRIMSEC eq "2">
	data_source='#form.sources#',		
	</CFIF>	
	 --->
<!--- 	<cfif isDefined("revApproval")>revApproval='#form.revApproval#',</cfif> --->
	<!--- approvdate='#form.Adate#' --->
	userid='#session.userid#'
	where 
	userid='#session.userid#'
	and methodname = '#htmleditformat(form.methodname)#'	
	and year2=#session.fy#
</cfquery>

<cfquery datasource="#application.DataSource#" 	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="updateMethodSampleTF">
	delete from Eval_SampTF
	where userid='#session.userid#'
	and methodname = '#htmleditformat(form.methodname)#'	
	and year2=#session.fy#	
</cfquery>

<CFLOOP COLLECTION="#Form#" ITEM="VarName">
<cfif (left(varname, 3) EQ "ds_")  OR (left(varname, 3) EQ "tf_")>
<cfquery datasource="#application.DataSource#" 	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="insertMethodSampleTF">
		insert into eval_sampTF
	(userid, methodname, year2, mvarname, mvalue)
	values
	('#session.userid#','#htmleditformat(form.methodname)#', #session.fy#, '#VarName#', '#Form[VarName]#' )
</cfquery>
</cfif>
</CFLOOP>
<!--- <cflocation addtoken="Yes" url="eval_list.cfm?#session.urltoken#"> --->
 <cflocation addtoken="Yes" url="evalmatrix.cfm?#session.urltoken#">
