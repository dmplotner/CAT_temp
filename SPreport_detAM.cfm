<cfif session.areamanage NEQ 1  and session.cessman NEQ 4 and session.admin NEQ 1 AND session.tcp NEQ 1 AND session.statemanage NEQ 1>
	<cflocation addtoken="yes" url="welcome.cfm">
</cfif>

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
and a.num !=9
and c.coordemail not like '%rti.org' and c.coordemail not like 'health.state.ny.us'
<cfif session.areamanage EQ 1 and (session.admin NEQ 1 AND session.tcp NEQ 1 AND session.statemanage NEQ 1)>
and  a.manager_id='#session.origUserID#'
</cfif>
and c.partnertype =4
and s.area=#URL.arn#
</cfquery>


<cfset dpath = "#expandpath('../../DATA/REPORTS')#">

<cfdirectory 
   action = "list"
   directory = "#dpath#"
   name = "QrptList"
   filter="*.pdf"
 >



<CFOUTPUT>
<table align="left" cellpadding="10" cellspacing="0" border="0"  class="box" width="100%">		
<tr>
	<th align="left">#Qpartnerlist.area#</th>
	<td>&nbsp;<br><br></td>
</tr>
<!--- <TR>
	<TH>School Staff Tobacco Survey Summary Reports for #QPartnerList.ORGNAME#</TH>
</TR> --->
<CFLOOP query="Qpartnerlist">
<cfquery name="qFile" dbtype="query">
 SELECT
 name, datelastmodified<!--- ,  substring(name, 1, 2) as dispname --->
 FROM
 QrptList
 where name like '%' + '#qpartnerlist.seq2#' + '.pdf'  
 order by name desc
 </cfquery> 
 <cfif qfile.recordcount GT 0>
 <tr>
 	<td colspan="2">#Qpartnerlist.orgName#</td>
 </tr>
 <cfloop query="qFile">
 <TR>
	<td width="5">&nbsp;</td><TD>
		<a href="dispRpt.cfm?#session.urltoken#&report=#URLEncodedFormat(Name)#">#NAME#</a> (#dateformat(datelastmodified, "mmm dd yyyy")#) 
	</TD>
</TR>
</cfloop>
</cfif>
</CFLOOP>
</table>
</CFOUTPUT>
</body>
</html>
