<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<cfif Qmonlist.recordcount GT 1>
	<cfset rtype="YTD">
<cfelse>
	<cfset rtype="monthly">
</cfif>
<html>
<head>
	<title>Focus Area Report</title>
	<link rel="stylesheet" href="print.css" type="text/css" media="print"> 
	<LINK rel="stylesheet" type"text/css" href="screen.css" media="screen">
	<!--- <cfinclude template="CATstruct.cfm"> --->
	
</head>
<body>
<!--- <cfset tablename="govt">
<cfset focusareaNum="1">
 --->
 
 
<cfinclude template="rpt_header_fa.cfm">

<cfinclude template="rpt_sub_head_query_mod.cfm">

<cfif QGenDescrip.recordcount GT 0>
<cfloop query="QGenDescrip">
<cfset Guserid=QGenDescrip.userid>
<cfset Gactivity=QGenDescrip.activity>
<cfswitch expression="#QGenDescrip.strategy#">
	<cfcase value=1>
		<cfset tablename="govt">
		<cfset focusareaNum="1">
		<cfinclude template="rpt_sub_genhead_mod.cfm">
		<cfinclude template="rpt_fa1_mod.cfm">	
	</cfcase>
	
	<cfcase value=2>
		<cfset tablename="paidmedia">
		<cfset focusareaNum="2">
		<cfinclude template="rpt_sub_genhead_mod.cfm">
		<cfinclude template="rpt_fa2_mod.cfm">	
	</cfcase>
	
	<cfcase value=4>
		<cfset tablename="forum">
		<cfset focusareaNum="4">
		<cfinclude template="rpt_sub_genhead_mod.cfm">
		<cfinclude template="rpt_fa4_mod.cfm">
	</cfcase>
	
	<cfcase value=5>
		<cfset tablename="monitor">
		<cfset focusareaNum="5">
		<cfinclude template="rpt_sub_genhead_mod.cfm">
		<cfinclude template="rpt_fa5_mod.cfm">	
	</cfcase>
	
	<cfcase value=6>
		<cfset tablename="SURVEYPUB">
		<cfset focusareaNum="6">
		<cfinclude template="rpt_sub_genhead_mod.cfm">
		<cfinclude template="rpt_fa6_mod.cfm">	
	</cfcase>
	
	<cfcase value=7>
		<cfset tablename="CESSATION">
		<cfset focusareaNum="7">
		<cfinclude template="rpt_sub_genhead_mod.cfm">
		<cfinclude template="rpt_fa7_mod.cfm">	
	</cfcase>
	
	<cfcase value=8>
		<cfset tablename="advoc">
		<cfset focusareaNum="8">
		<cfinclude template="rpt_sub_genhead_mod.cfm">
		<cfinclude template="rpt_fa8_mod.cfm">	
	</cfcase>
	
	<cfcase value=9>
		<cfset tablename="advoc">
		<cfset focusareaNum="9">
		<cfinclude template="rpt_sub_genhead_mod.cfm">
		<cfinclude template="rpt_fa8_mod.cfm">	
	</cfcase>
	
	<cfdefaultcase>
<!--- 		<cfset tablename="govt">
		<cfset focusareaNum="1">
		<cfinclude template="rpt_sub_genhead_mod.cfm">
		<cfinclude template="rpt_fa1_mod.cfm">	 --->
		There is no CODE for this report *<cfoutput>#QGenDescrip.strategy#</cfoutput>*
		
	</cfdefaultcase>

</cfswitch>

</cfloop>
<cfelse>
<br>
<div align="center"><h2>There are no data for this report</h2></div>

</cfif>
</body>
</html>