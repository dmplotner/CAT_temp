<!-----------------------------------------------------------------------
Reached by redirection from APPLICATION.CFM, whenever a session timeout
is detected (by the absence of Session.USR).

Links to LOGIN.CFM, so user can log in again if desired.

Summary of processing:

If session timeout detected from a page within a frame, initial 
JavaScript code is used to break out of the frame.  Then the timeout 
message is displayed along with a link back to LOGIN.CFM.
------------------------------------------------------------------------->

<cfset structClear(Session)>

<cfoutput>
<TITLE>CAT - Session Timeout</TITLE>
</HEAD>

<BODY>

<script language="JavaScript">
if (window != top) top.location.href = location.href;
else if (window.name == "pwin") {
	opener.location.href = location.href;
	self.close();
}
</script>
<cflocation addtoken="no" url="#Application.LoginPath#">

</body>
</cfoutput>
