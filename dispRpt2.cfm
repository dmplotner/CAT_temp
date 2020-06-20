<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Untitled Document</title>
</head>

<body>
<cfset dpath = "#expandpath('manual/reports/')#">
<cfset dpath = dpath & url.report>


<cfoutput>#url.report# <br> #dpath#</cfoutput>
 <cfheader name="content-disposition" value="attachment; filename=#replace(url.report,' ','_','ALL')#" >
<cfif url.report contains ".pdf">
	<cfcontent type="application/pdf" file="#dpath#"> 	
	<cfelse>
<cfcontent type="application/vnd.ms-excel" file="#dpath#"> 
</cfif>
</body>
</html>
