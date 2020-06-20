<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
<title>CAT</title>

<cfinclude template="catstruct.cfm">
<cfif SESSION.userid EQ "kcdavis" OR SESSION.userid EQ "dplotner" or SESSION.userid EQ "lxk03" or SESSION.userid EQ "dvx06" or SESSION.userid EQ "bmarkatos" or SESSION.userid EQ "rav02">
<br><br><br>
<a href="kevin.cfm">PM Report</a>
</cfif>
<br>
<cfoutput>
<cfif (session.modality NEQ 4 or session.admin EQ 1 or session.tcp EQ 1 or session.cessman contains 1 or session.areamanage EQ 1 or session.statemanage EQ 1 or session.regionmanage EQ 1) and session.cessman NEQ 4>
<cfif session.fy GTE 2012>
<a href="reporthandler_mod2.cfm?#session.urltoken#">ATFC Reports</a>
<br><br>
<a href="reporthandler_mod3.cfm?#session.urltoken#">Health Systems Change Reports</a>



<cfelseif session.fy GTE 2010>
<a href="reporthandler_mod2.cfm?#session.urltoken#">Youth Partners, Cessation Centers and Community Partnerships</a>
<cfelse>
<a href="reporthandler_mod.cfm?#session.urltoken#">Youth Partners, Cessation Centers and Community Partnerships</a>
</cfif>
<br>
</cfif>
<cfif session.userid NEQ 'mgallagher'>
<cfif session.userid is 'dplotner' or session.userid is 'nsarris' or session.userid is 'mchambard' or session.userid is 'lolson'>
<a href="reporthandler_modSP.cfm?#session.urltoken#">School Policy Partners</a>
<br>
</cfif>
</cfif>
<cfif session.userid eq 'twills' or session.userid eq 'nsarris' or session.userid eq 'dplotner' or session.userid eq 'cschnefke'><br>
<a href="sustain.xlsx">sustainability pull</a>
</cfif>
</cfoutput>
</body>
</html>
