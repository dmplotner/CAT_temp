<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>

<cfif isDefined("form.submit") and form.submit EQ "add">
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="add_announcment">
	insert into announcement
	(st_date, end_date, st_time, end_time, title, descrip, location, url_head, url)
	values
	(#form.start_date#, #form.end_date#, #form.start_time#, #form.end_time#, '#form.event_title#', '#form.descrip#', '#form.location#', '#form.url_head#', '#form.url_text#')
	
</cfquery>	

<cfelseif isDefined("form.submit") and form.submit EQ "del">
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="del_announcement">
	delete from announcement where  seq in (#form.seq#)
	order by 1, 2
</cfquery>	

</cfif>
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="announcements">
	select st_date, end_date, st_time, end_time, title, descrip, location, url_head, url, seq
	from announcement
	order by 1, 2
</cfquery>	
<cfoutput>

<cfform action="announcements.cfm?#session.urltoken#">
<table>
<tr><th colspan="2">Add Event to Announcments:</th></tr>
<tr><td>Event (Start) Date:</td><td><input type="Text" name="start_date"></td></tr>
<tr><td>(End Date):</td><td><input type="Text" name="end_date"></td></tr>

<tr><td>(Start Time):</td><td><input type="Text" name="start_time"></td></tr>
<tr><td>(End TIme):</td><td><input type="Text" name="end_time"></td></tr>

<tr><td>Title:</td><td><input type="Text" name="event_title"></td></tr>
<tr><td>Description:</td><td><input type="Text" name="descrip"></td></tr>
<tr><td>Location:</td><td><input type="Text" name="location"></td></tr>

<tr><td>URL heading:</td><td><input type="Text" name="url_head"></td></tr>
<tr><td>URL:</td><td><input type="Text" name="url_text"></td></tr>
</table>

<input type="Submit" title="Submit" value="add">


<br>
<table>
<tr><th>Title</th><th>Delete</th></tr>
<cfloop query="announcements">
<tr><td>#title#</td><td><input type="Checkbox" name="seq" value="#seq#"></td></tr>
</cfloop>
<input type="Submit" title="Submit" value="del">
</table>
</cfform>

</cfoutput>

</body>
</html>
