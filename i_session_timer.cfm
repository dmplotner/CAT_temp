<cfparam name="Attributes.minutes" default="55">
<cfparam name="Attributes.warn" default="No">
<cfparam name="Attributes.warnThreshold" default="3">
<cfparam name="Attributes.warnURL" default="">
<cfparam name="Attributes.warnWidth" default="350">
<cfparam name="Attributes.warnHeight" default="300">
<cfparam name="Attributes.onTimeOut" default="">

<cfscript>
if (Not IsNumeric(Attributes.minutes)) Attributes.minutes = "55";
if (Attributes.warn) {
	if (Not IsNumeric(Attributes.warnThreshold)) Attributes.warnThreshold = "3";
	if (Attributes.warnThreshold GTE Attributes.minutes) warn = "No";
	if (Not Len(Attributes.warnURL)) Attributes.warn = "No";
	if (Not IsNumeric(Attributes.warnWidth)) warnWidth = "300";
	if (Not IsNumeric(Attributes.warnHeight)) warnHeight = "250";
}
msecs = (Attributes.minutes + 1) * 60000;
</cfscript>

<cfoutput>
<script type="text/javascript" language="JavaScript">
function stopTimer() {
	if (timerRunning) clearTimeout(timerID);
	timerRunning = false;
}
function startTimer() {
	stopTimer();
	sessionExpires = #msecs#;
	calcInterval();
}
function calcInterval() {
	sessionExpires = sessionExpires - 60000;
	if (sessionExpires <= 0) {
		if (showWarning) 
			if (typeof wWin != "undefined")
				if (! wWin.closed) 
					wWin.close();
		<cfif Len(Attributes.onTimeOut)>window.location.href="#Attributes.onTimeOut#";</cfif>
		return;
	}
	js_min_left = sessionExpires / 60000;
	timerID = setTimeout("calcInterval()",60000);
	if (showWarning && js_min_left <= #Attributes.warnThreshold#) warn();
	timerRunning = true;
}
function warn() {
	var w = #Attributes.warnWidth#;
	var h = #Attributes.warnHeight#;
	var l = (screen.availWidth/2) - (w/2);
	var t = (screen.availHeight/2) - (h/2);
	var parms = "width=" + w + ",height=" + h + ",left=" + l + ",top=" + t;

// 	wWin = window.open("#Attributes.warnURL#?rm="+js_min_left+"&tm=#URLEncodedFormat(Attributes.onTimeout)#","wWin",parms);
	
	
//Detect IE5.5+
version=0
if (navigator.appVersion.indexOf("MSIE")!=-1){
temp=navigator.appVersion.split("MSIE")
version=parseFloat(temp[1])
}

if (version>=6.0) //NON IE browser will return 0
alert("Your CAT session is about to END.  Please submit your current entries at this time.")
else 	
wWin = window.open("#Attributes.warnURL#?rm="+js_min_left+"&tm=#URLEncodedFormat(Attributes.onTimeout)#","wWin",parms);
		

}
showWarning = false;
timerID = null;
timerRunning = false;
if (this == this.top) {
	if ("#LCase(Attributes.warn)#" == "yes") showWarning = true;
	startTimer();
}
else top.startTimer();
</script>
</cfoutput>
