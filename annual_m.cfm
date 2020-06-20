<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
<title>CAT</title>

<cfinclude template="catstruct.cfm">

<br><br><br>
<a href="cat_annual.cfm?<cfoutput>#session.urltoken#</cfoutput>">New Strategy</a>
<br>
<a href="annual_list.cfm?<cfoutput>#session.urltoken#</cfoutput>">Edit Strategy</a>
<br>
<a href="rem_strategy.cfm?<cfoutput>#session.urltoken#</cfoutput>">Delete Strategy</a>
<!--- <br>

<a href="monthlyEval.cfm">Evaluation Plan</a> --->
</body>
</html>
