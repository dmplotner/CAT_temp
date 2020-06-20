
<!--- <CFSET this_month = DatePart('m', now())>
<CFSET thismonth = monthasstring( this_month)>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="curMoncheck">
	<cfif session.modality EQ 4>
	select sp_rank as rank from months where mon='#thisMonth#'
	<Cfelse>select rank from months where mon='#thisMonth#'</cfif>
</cfquery>
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="rptMoncheck">
	<cfif session.modality EQ 4>
	select sp_rank as rank from months where mon='#form.Month#'
	<Cfelse>select rank from months where mon='#form.Month#'</cfif>
</cfquery> --->
<cfquery datasource="#application.DataSource#" 
	password="#application.db_password#"   		
	username="#application.db_username#" name="ExtExcept">	
	select userid from extension_exceptions
	union
	select 'null'
</cfquery>

<cfif session.fy EQ session.def_fy AND NOT(listcontains(session.newExt_3, session.def_fy) or listContains(valuelist(ExtExcept.userid), session.userid))
AND 
((SESSION.MODALITY eq 4 AND 
		(form.Q EQ 1 and  (DateCompare(createDate(session.fy, 4, 16),Dateformat(now())) gT 0)
			and  (DateCompare(createDate(session.fy-1, 12, 1),Dateformat(now())) lT 0))
		OR 
		(form.Q EQ 2 and  (DateCompare(createDate(session.fy, 7, 16),Dateformat(now())) gT 0)
			and  (DateCompare(createDate(session.fy, 3, 1),Dateformat(now())) lT 0))
		OR 
		(form.Q EQ 3 and (DateCompare(createDate(session.fy, 10, 16),Dateformat(now())) gT 0)
			and  (DateCompare(createDate(session.fy, 6, 1),Dateformat(now())) lT 0))
		OR 
		(form.Q EQ 4 and (DateCompare(createDate(session.fy+1, 1, 16),Dateformat(now())) gT 0)
			and  (DateCompare(createDate(session.fy, 9, 1),Dateformat(now())) lT 0)))
			
	or
		(SESSION.MODALITY Neq 4 AND 
		(form.Q EQ 1 and  (DateCompare(createDate(session.fy-1, 12, 16),Dateformat(now())) gT 0)
			and  (DateCompare(createDate(session.fy-1, 8, 1),Dateformat(now())) lT 0))
		OR 
		(form.Q EQ 2 and  (DateCompare(createDate(session.fy, 3, 16),Dateformat(now())) gT 0)
			and  (DateCompare(createDate(session.fy-1, 11, 1),Dateformat(now())) lT 0))
		OR 
		(form.Q EQ 3 and (DateCompare(createDate(session.fy, 7, 16),Dateformat(now())) gT 0)
			and  (DateCompare(createDate(session.fy, 2, 1),Dateformat(now())) lT 0))
		OR 
		(form.Q EQ 4 and (DateCompare(createDate(session.fy, 9, 16),Dateformat(now())) gT 0))
			and  (DateCompare(createDate(session.fy, 5, 1),Dateformat(now())) lT 0))			
				
						)		
				> 
				
				<!--- valid quarterly entry --->

<cfelseif session.fy EQ session.def_fy AND (listcontains(session.newExt_3, session.def_fy) or listContains(valuelist(ExtExcept.userid), session.userid))>
	<!--- current year extension --->
	

	
	<cfif session.modality EQ 4><!--- SP --->
		<cfif
		(form.Q EQ 1 and  (DateCompare(createDate(session.fy-1, 12, 1),Dateformat(now())) GT 0))
		OR 
		(form.Q EQ 2 and  (DateCompare(createDate(session.fy, 3, 1),Dateformat(now())) GT 0))
		OR 
		(form.Q EQ 3 and (DateCompare(createDate(session.fy, 6, 1),Dateformat(now())) GT 0))
		OR 
		(form.Q EQ 4 and (DateCompare(createDate(session.fy, 9, 1),Dateformat(now())) GT 0))>
		<script language="JavaScript">
			disableme();
		</script>
		</cfif>
	<cfelse>
	<!--- non-SP --->
		<cfif
		(form.Q EQ 1 and  (DateCompare(createDate(session.fy-1, 8, 1),Dateformat(now())) GT 0))
		OR 
		(form.Q EQ 2 and   (DateCompare(createDate(session.fy-1, 11, 1),Dateformat(now())) GT 0))
		OR 
		(form.Q EQ 3 and (DateCompare(createDate(session.fy, 2, 1),Dateformat(now())) GT 0))
		OR 
		(form.Q EQ 4 and  (DateCompare(createDate(session.fy, 5, 1),Dateformat(now())) GT 0))>
		<script language="JavaScript">
			disableme();
		</script>
		</cfif>
	</cfif>

<cfelseif session.fy NEQ session.def_fy AND listcontains(session.newExt_4, session.fy)>
<!--- prevyr extension --->



<cfelseif session.fy NEQ session.def_fy AND session.modality EQ 4 and NOT(form.Q EQ 4 and DateCompare(createDate(session.fy, 1, 15),Dateformat(now())) LTE 0  and  (DateCompare(createDate(session.fy-1, 9, 1),Dateformat(now())) LTE 0) )><!--- less than 45 days into new year --->

<script language="JavaScript">
	disableme();
</script>

<cfelseif session.fy NEQ session.def_fy AND session.modality NEQ 4 and NOT(form.Q EQ 4 and DateCompare(createDate(session.fy, 9, 15),Dateformat(now())) GTE 0  and  (DateCompare(createDate(session.fy, 5, 1),Dateformat(now())) LTE 0) )><!--- less than 45 days into new year --->
<script language="JavaScript">
	disableme();
</script>


<cfelseif session.fy NEQ session.def_fy AND session.modality EQ 4 and (form.Q EQ 4 and DateCompare(createDate(session.fy, 1, 15),Dateformat(now())) LTE 0 and  (DateCompare(createDate(session.fy-1, 9, 1),Dateformat(now())) LTE 0))><!--- less than 45 days into new year --->

<cfelseif session.fy NEQ session.def_fy AND session.modality NEQ 4 and (form.Q EQ 4 and DateCompare(createDate(session.fy, 9, 15),Dateformat(now())) GTE 0 and  (DateCompare(createDate(session.fy, 5, 1),Dateformat(now())) LTE 0))><!--- less than 45 days into new year --->




<cfelseif (session.fy GT (session.def_fy))>	 
<!--- any other month for future year --->
<cflocation addtoken="yes" url="noFuture.cfm">
<cfelse>
<!--- no case --->

<script language="JavaScript">
	disableme();
</script>
</cfif> 

<cfif session.fy LT session.def_fy AND session.prevyr NEQ 1 AND NOT (SESSION.areamanage EQ "1" OR SESSION.admin EQ "1" OR SESSION.TCP EQ "1")>
<script language="JavaScript">
	disableme();
</script>
</cfif>

<!--- 
<cfif (session.fy NEQ session.def_fy OR <!--- session.fy EQ session.def_fy OR  --->
<!--- SP --->
(form.Q EQ 1 and DateCompare(createDate(session.fy, 4, 15),Dateformat(now())) LTE 0 and  (DateCompare(createDate(session.fy-1, 12, 1),Dateformat(now())) GTE 0))
OR 
(form.Q EQ 2 and DateCompare(createDate(session.fy, 7, 15),Dateformat(now())) LTE 0 and  (DateCompare(createDate(session.fy, 3, 1),Dateformat(now())) GTE 0))
OR 
(form.Q EQ 3 and DateCompare(createDate(session.fy, 10, 15),Dateformat(now())) LTE 0 and  (DateCompare(createDate(session.fy, 6, 1),Dateformat(now())) GTE 0))
OR 
(form.Q EQ 4 and DateCompare(createDate(session.fy+1, 1, 15),Dateformat(now())) LTE 0 and  (DateCompare(createDate(session.fy, 9, 1),Dateformat(now())) GTE 0))




<!--- non-SP --->
(form.Q EQ 1 and DateCompare(createDate(session.fy-1, 12, 15),Dateformat(now())) LTE 0 and  (DateCompare(createDate(session.fy-1, 8, 1),Dateformat(now())) GTE 0))
OR 
(form.Q EQ 2 and DateCompare(createDate(session.fy, 3, 15),Dateformat(now())) LTE 0 and  (DateCompare(createDate(session.fy-1, 11, 1),Dateformat(now())) GTE 0))
OR 
(form.Q EQ 3 and DateCompare(createDate(session.fy, 6, 15),Dateformat(now())) LTE 0 and  (DateCompare(createDate(session.fy, 2, 1),Dateformat(now())) GTE 0))
OR 
(form.Q EQ 4 and DateCompare(createDate(session.fy, 9, 15),Dateformat(now())) LTE 0 and  (DateCompare(createDate(session.fy, 5, 1),Dateformat(now())) GTE 0))

 --->
