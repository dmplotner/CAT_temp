<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Untitled Document</title>
</head>

<body>
<cfset dpath = "#expandpath('../../DATA/REPORTS/')#">
<cfset dpath = dpath & url.report>


<cfoutput>#url.report# <br> #dpath#</cfoutput>
 <cfheader name="content-disposition" value="attachment; filename=#replace(url.report,' ','_','ALL')#" >
<cfcontent type="application/pdf" file="#dpath#"> 	
<!---
<cfheader name="content-disposition" value="inline; filename=#findfile.filename#" >
<cfcontent type="#apptype#" variable="#findfile.attachment#"> 	
 --->
<!--- <cfheader name="content-disposition" value="inline; filename=\\pubfile01\nytobaccomx\\htdocs\dev\manualCAT update 02-24-05.doc" >
<cfcontent type="application/pdf" file="test.pdf"> 	
 --->
<!--- \\pubfile01\nytobaccomx\\htdocs\dev\manualCAT update 02-24-05.doc
 --->
</body>
</html>
