<cfif IsDefined("URL.go")>
	<cfset Session.keepAlive = "yes"><cfoutput>
<script language="JavaScript" type="text/javascript">
opener.startTimer();
self.close();
</script></cfoutput>
	<cfabort>

<cfelse>
	<cfset msecs = (URL.rm + 1) * 60000><cfoutput>
<title>CAT - Warning</title>
<script language="JavaScript" type="text/javascript">
// Script runs when user clicks Continue button (tf = true) or Logout button (tf = 
// false).  If continue, we have to submit the form to the server so we can 
// reference the session object to keep that alive.  We also have to keep the 
// unload event (logout function) in this window from sending the main window to the 
// timeout page (accomplished by setting keepAlive to true when document first 
// loads--see below).  If Logout, we change keepAlive to false and close the window, 
// which causes the unload event to trigger the logout() function.
function doSubmit(tf) {
	if (tf) {
		document.tform.go.value="yes";
		document.tform.submit();
	}
	else {
		keepAlive = false;
		self.close(); // resulting unload event causes logout() to run next
	}
}
// Save the URL of the document that opened this window, so when this window is 
// closed, we know whether or not the document in the main window should be 
// affected.
function init() { 
	openerURL = opener.document.URL;
	self.focus();
}
// Runs whenever document is unloaded by form submit or window close.  But we only 
// want to send main window to timeout page if (1) user has NOT clicked Continue 
// to keep session alive, and (2) if document currently in main window is the one 
// that opened this window (user could have ignored the warning in this pop-up 
// window and kept the session alive by going on to another page in the main window).
function logout() {
	stopTimer(); // Stop timer in this window
	if (! keepAlive) { 
		if (opener.document.URL == openerURL) { 
			opener.stopTimer();  // Stop timer in parent window
//			opener.location.href=protocol+"//"+domain+root+"/timedout.cfm";
			opener.location.href="#URL.tm#";
			opener.focus();
		}
	}
}
function stopTimer() {
	if (timerRunning) clearTimeout(timerID);
	timerRunning = false;
}
function startTimer() {
	stopTimer();
	winExpires = #msecs#;
	calcInterval();
}
function calcInterval() {
	winExpires = winExpires - 60000;
	if (winExpires <= 0) {
		self.close();
		return;
	}
	timerID = setTimeout("calcInterval()",60000);
	timerRunning = true;
}
// Runs on document focus.  If user ignores the timeout warning in this window, and 
// keeps the session alive by going to another page in the main window, then tries
// to go back to this warning window, we don't to cause confusion by displaying a 
// warning that is no longer applicable--we just need to get rid of the warning 
// window.
function checkIt() {
	if (opener.document.URL != openerURL) {
		keepAlive = true;
		self.close();
	}
}
// NOTE: We have to set this to true to begin with, to keep the logout routine 
// from forcing the opener window to the timeout page under the following 2 
// conditions: (1) when this document is unloaded in order to load an updated 
// timeout warning; (2) when this window is closed.
keepAlive = true;
protocol = self.location.protocol;
domain = self.document.domain;
timerID = null;
timerRunning = false;
startTimer(); // Set timeout for this window, so it will just go away if not closed first.
</script></cfoutput>
</cfif>

<cfoutput>
</head>

<body onLoad="init();" onUnload="logout();" onFocus="checkIt();">
<form name="tform" method="get" action="timeoutwarning.cfm?#session.urltoken#">
<input type="Hidden" name="go" value="">
<H3 align="center">CAT Warning</H3>
<table align="center">
<tr>
	<td colspan="2">
		<p>Your session will expire in #URL.rm# minute<cfif URL.rm GT 1>s</cfif>.</p>
		<p>At this time, you will be automatically logged out.</p>
		<p>To log out now, click the "Logout" button.</p>
		<p>To continue, click the "Continue" button.</p>
	</td>
</tr>
<tr>
	<td colspan="2">&nbsp;</td>
</tr>
<tr>
	<td align="right"><table cellpadding="0" cellspacing="0" border="1"><tr><td><input type="button" value="Continue" class="bttn" width="90" onClick="doSubmit(true);"></td></td></tr></table>
	<td><table cellpadding="0" cellspacing="0" border="1"><tr><td><input type="button" value="Logout" class="bttn" width="90" onClick="doSubmit(false);"></td></td></tr></table>
</tr>
</table>
</form>
</body>
</cfoutput>
