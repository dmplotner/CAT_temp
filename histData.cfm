<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
<title>CAT</title>

<cfinclude template="catstruct.cfm">

<br><br><br>

<br>
<cfoutput>
	
<cfset dpath3 = "#expandpath('manual/reports/PRP reports')#">
<cfdirectory 
   action = "list"
   directory = "#dpath3#"
   name = "QrptList3"
  >

<cfquery name="qFile3" dbtype="query">
 SELECT
 name
 FROM
 QrptList3
 order by 1
 </cfquery> 	



<cfset dpath4 = "#expandpath('manual/reports/cc reports')#">
<cfdirectory 
   action = "list"
   directory = "#dpath4#"
   name = "QrptList4"
  >

<cfquery name="qFile4" dbtype="query">
 SELECT
 name
 FROM
 QrptList4
 order by 1
 </cfquery> 	


<!--- <cfif session.modality EQ 2 OR session.modality EQ 3 OR SESSION.areamanage EQ "1" OR SESSION.admin EQ "1" OR SESSION.TCP EQ "1">
<a href="">CP & YP Tobacco Free policies, resolutions, and practice changes list report</a>
<br><br>
</cfif>
 --->

<cfif session.modality EQ 1  OR SESSION.areamanage EQ "1" OR SESSION.admin EQ "1" OR SESSION.TCP EQ "1">

<!--- <a href="">CC Health Systems Change Milestones 2008-2009</a>
<br>
<a href="">CC Health Systems Change Milestones 2004-2005 through 2007-2008</a> --->

<cfloop query="qFile4">
			<a href="dispRpt2.cfm?#session.urltoken#&report=#URLEncodedFormat('cc reports/'& Name)#">#qFile4.name#</a>
			<br>
			</cfloop>
<br><br>
</cfif>




<cfif SESSION.areamanage EQ "1" OR SESSION.admin EQ "1" OR SESSION.TCP EQ "1">
	
<cfset dpath = "#expandpath('manual/reports/eoy reports')#">
<cfset dpath2 = "#expandpath('manual/reports/cm feedback reports')#">
<cfset dpath3 = "#expandpath('manual/reports/PRP reports')#">

<cfdirectory 
   action = "list"
   directory = "#dpath#"
   name = "QrptList1"
   filter="*.pdf"
 >

<cfdirectory 
   action = "list"
   directory = "#dpath2#"
   name = "QrptList2"
   filter="*.pdf"
 >

<cfquery name="qFile1" dbtype="query">
 SELECT
 name
 FROM
 QrptList1
 order by  1
 </cfquery> 

<cfquery name="qFile2" dbtype="query">
 SELECT
 name
 FROM
 QrptList2
 order by 1
 </cfquery> 
<br>
<strong>End-of-Year Reports with Contract Manager feedback (visible to TCP staff only):</strong>	<br>
	<cfif qFile1.recordcount GT 0>
		<cfset subnm="">
		
			<ul>
			<cfloop query="qFile1">
			<cfif subnm NEQ #mid(qFile1.name, 12,5)#>
			</ul>	
			<br><strong>EOY reports for 20#mid(qFile1.name, 12,2)# - 20#mid(qFile1.name, 15,2)#</strong>
			<ul>
			</cfif>	
			<li><a href="dispRpt2.cfm?#session.urltoken#&report=#URLEncodedFormat('eoy reports/'& Name)#">#qFile1.name#</a></li>
			<cfset subnm= #mid(qFile1.name, 12,5)#>
			
			</cfloop>	
</ul>	
	</cfif> 


<br><br><br>
<strong>Visible to TCP staff only</strong>
<br><br>
<strong>Contract Manager Feedback on monthly reports:</strong>	<br>
	<cfif qFile2.recordcount GT 0>
		<ul>
			
			<cfloop query="qFile2">
			<li><a href="dispRpt2.cfm?#session.urltoken#&report=#URLEncodedFormat('cm feedback reports/'& Name)#">#qFile2.name#</a></li>
			</cfloop>	
</ul>	
	</cfif> 	
</cfif>


<br><br><br>
<strong>Policies, Resolutions and Practices reports:</strong>	<br>
	<cfif qFile3.recordcount GT 0>
		<ul>
			
			<cfloop query="qFile3">
			<li><a href="dispRpt2.cfm?#session.urltoken#&report=#URLEncodedFormat('PRP reports/'& Name)#">#qFile3.name#</a></li>
			</cfloop>	
	</ul>	
	</cfif>

</cfoutput>
</body>
</html>
