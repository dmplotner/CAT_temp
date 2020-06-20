
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>error</title>
</head>

<body>


<h2>You have experienced an error</h2>
<p>
Details of this error are being sent to RTI so that we can resolve it.<br>

Please use your browser's "back" button to return to your last point in the system, 
and try again, or try another aspect of the system.<br>

This error report will facilitate a rapid correction of the problem.<br>

Thank you for your patience,<br><br>

-david plotner-<br>
RTI International<br>
(800) 334-8571 ext 25588<br>
dplotner@rti.org<br>

</P>



<cfmail to="dplotner@rti.org; twills@rti.org" 
from ="dplotner@rti.org" 
subject="Error on page #ERROR.Template#">
error date: #error.datetime#
users browser: #error.browser#
URL params: #error.querystring#
template: #error.template#
previous page: #error.httpreferer#
user id: <cfif isDefined("session.userid")>#session.userid#</cfif>
Session user: <cfif isDefined("session.origUserID")>#session.origUserID#</cfif>
-----------------------------
<!--- form fields populated: <cfloop list="#form.fieldnames#" index="thisField">
Field Name: #thisField#<br>
Field Value: #form[thisField]#<hr>
</cfloop> --->

#error.diagnostics#
</cfmail>

<cfmail to="dplotner@rti.org; twills@rti.org" 
from ="dplotner@rti.org" 
subject="Error on page #ERROR.Template#">
error date: #error.datetime#
users browser: #error.browser#
URL params: #error.querystring#
template: #error.template#
previous page: #error.httpreferer#
user id: <cfif isDefined("session.userid")>#session.userid#</cfif>
Session user: <cfif isDefined("session.origUserID")>#session.origUserID#</cfif>
-----------------------------
<cfif isDefined("form.fieldnames")>
form fields populated: <cfloop list="#form.fieldnames#" index="thisField">
Field Name: #thisField#<br>
Field Value: #form[thisField]#<hr>
</cfloop>
</cfif>
#error.diagnostics#
<!--- #error.generatedcontent# --->
</cfmail>

</body>
</html>
