<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>CAT</title>
<cfinclude template="CATstruct.cfm">

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QPartnerList">
	
	
select 
c.userid, orgname, a.area, c.seq as seq2
from contact as c, security as s, area as a
where c.userid=s.userid
and s.area = a.num
and a.year2=#session.fy#
and c.seq = '#url.partnerid#'
</cfquery>


<cfset dpath = "#expandpath('../../DATA/REPORTS')#">

<cfdirectory 
   action = "list"
   directory = "#dpath#"
   name = "QrptList"
   filter="*.pdf"
 >


<cfquery name="qFile" dbtype="query">
 SELECT
 name
 FROM
 QrptList
 where name like '%' + '#url.partnerid#' + '.pdf'  
 </cfquery> 
<CFOUTPUT>
<table align="left" cellpadding="10" cellspacing="0" border="0"  class="box" width="100%">		
<tr>
	<td>&nbsp;<br><br></td>
</tr><TR>
	<TH>School Staff Tobacco Survey Summary Reports for #QPartnerList.ORGNAME#</TH>
</TR>
<CFLOOP query="QfILE">
<TR>
	<TD>
		<a href="dispRpt.cfm?#session.urltoken#&report=#URLEncodedFormat(Name)#">#NAME#</a>
	</TD>
</TR>
</CFLOOP>
</table>
</CFOUTPUT>
</body>
</html>
