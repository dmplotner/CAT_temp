<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>






<cfif cgi.HTTP_REFERER contains "monthlyActive_cess_test.cfm">
<cfif  session.fy GT 2008>
	<cfinclude template="prc_PIP.cfm">
</cfif> 
	<!--- <cfinclude template="prc_cesstest.cfm"> --->
	<cfquery datasource="#application.DataSource#"  		 
	password="#application.db_password#"   		
	username="#application.db_username#" name="updateForum">
	Update ADVOC
	set 
	<cfif isDefined("form.startDate")>revStart = '#form.startDate#',</cfif>
	<cfif isDefined("form.endDate")>RevEnd = '#form.endDate#',</cfif>	
	<cfif isDefined("form.tcpsust")>tcpsust = #form.tcpsust#, </cfif>
	<cfif isDefined("form.tcpsust_text")>tcpsust_text = '#htmleditformat(form.tcpsust_text)#', </cfif>
	<cfif isDefined("form.changedDates")>note = '#form.changedDates#',</cfif>
	<cfif isDefined("form.earned")>earnedMedia = '#form.earned#',</cfif>
	status = 'On-going'
	where activity = '#htmlEditFormat(form.oldRpt)#'
	and userid = '#form.rptuserid#'
	and month2= '#form.month#'		
	and year2= '#form.year#'	
	</cfquery>
	<cfset tablename="advoc"> 
<cfelse>

<cfif form.rpt EQ "1">
	<cfinclude template="prc_one.cfm">
	<cfset tablename="govt">
<cfelseif form.rpt EQ "2">
	<cfinclude template="prc_two.cfm">
	<cfset tablename="paidmedia">
<cfelseif form.rpt EQ "4">
	<cfinclude template="prc_four.cfm">
	<cfif session.fy EQ 2005>
		<cfinclude template="prc_four_bak.cfm">
	<cfelse>
		<cfinclude template="prc_four.cfm">
	</cfif>
	<cfset tablename="forum">
<cfelseif form.rpt EQ "5">
	<cfinclude template="prc_five.cfm">
	<cfset tablename="monitor">
<cfelseif form.rpt EQ "6">
	<cfinclude template="prc_six.cfm">
	<cfset tablename="surveypub">
<cfelseif form.rpt EQ "7">
	<cfinclude template="prc_seven.cfm">
	<cfset tablename="cess">
<cfelseif form.rpt EQ "8" or form.rpt EQ "9" or form.rpt EQ "11">
	<cfinclude template="prc_eight.cfm">
	<cfset tablename="advoc">
<cfelseif form.rpt EQ "10">
	<cfinclude template="prc_ten.cfm">
	<cfset tablename="infrastruct">
</cfif>
</cfif>
<!--- Process EarnedMedia --->
<cfif isDefined("form.earned") and form.earned EQ "1">
	<cfinclude template="prc_earned.cfm">
</cfif>


<!--- End Earned Media Processing --->

<!--- process planning data(monthly) --->
<cfif session.fy LT 1920 or session.fy GT 2006>
	<cfinclude template="prc_planning_new.cfm">
<cfelse>
	<cfinclude template="prc_planning.cfm">
</cfif>

<cfquery datasource="#application.DataSource#"  		
			 
			password="#application.db_password#"   		
			username="#application.db_username#" name="reviseddates">
<cfif session.modality NEQ 4>
select userid, activity, year2, revstart, revend from #tablename# as p, months as c
where
revstart is not null
and  c.mon=p.month2 and c.year2 = p.year2
and  p.activity = '#form.oldrpt#'
and p.userid = '#form.rptuserid#'		
and year2= '#form.year#'		
	
and c.rank=
		(select max(d.rank) from monthS as d, #tablename# as z
			where d.mon = z.month2  and d.year2 = z.year2
			and z.revstart is not null 			
			AND  z.userid = p.userid
			and z.year2 = p.year2
			and z.activity=p.activity)		
<cfelse>
select userid, activity, year2, revstart, revend from #tablename# as p, months as c
where
revstart is not null
and  c.mon=p.month2 and c.year2 = p.year2
and  p.activity = '#form.oldrpt#'
and p.userid = '#form.rptuserid#'		
and year2= '#form.year#'		
	
and c.sp_rank=
		(select max(d.sp_rank) from monthS as d, #tablename# as z
			where d.mon = z.month2 
			and d.year2 = z.year2
			and z.revstart is not null 			
			AND  z.userid = p.userid
			and z.year2 = p.year2
			and z.activity=p.activity)		

</cfif>	
</cfquery>

<cfloop query="reviseddates">
<cfquery datasource="#application.DataSource#"  		
			 
			password="#application.db_password#"   		
			username="#application.db_username#" name="updatedates">
			update useractivities
			set last_sd='#dateformat(revstart,'m/d/yyyy')#',
			last_ed='#dateformat(revend,'m/d/yyyy')#'
			where userid='#userid#'
			and activity='#activity#'
			and year2=#year2#
			and strategy=#form.rpt#
			and del is null
			
			
</cfquery>
</cfloop>

<cflocation addtoken="Yes" url="activ_list.cfm?#session.urltoken#"> 
</body>
</html>
