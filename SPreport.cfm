<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
<title>CAT</title>
 <!--- <cfif session.fy GT session.def_fy>
	<Cflocation url="unavailable.cfm" addtoken="yes">
</cfif> --->

<cfinclude template="CATstruct.cfm">

<!--- <script language="JavaScript">
function setmonth2(content){
document.f1.monthdisplay.value = content;
}
</script> --->
<cfif not isDefined("session.origUserID")>
	<cfset session.origUserID=session.userid>
</cfif>

 

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QPartnerList">
	
	
select 
c.userid, orgname, a.area, c.seq as seq2, s.area as areanum
from contact as c, security as s, area as a
where c.userid=s.userid
and s.area = a.num
and a.year2=#session.fy#
and a.num !=9
and c.coordemail not like '%rti.org' and c.coordemail not like 'health.state.ny.us'
<cfif session.areamanage EQ 1 and (session.admin NEQ 1 AND session.tcp NEQ 1 AND session.statemanage NEQ 1)>

and  a.manager_id='#session.origUserID#'

<cfelseif session.cessman EQ 4>
<cfelseif session.admin EQ 1>
<cfelseif session.statemanage EQ 1>
<cfelseif session.userid EQ 'uxb03' or session.userid EQ 'girlando'>

<cfelse>
and c.userid='#session.userid#'
</cfif>
and orgname is not null and orgname !=''
and partnertype=4
order by  3,2
</cfquery>



<cfset dpath = "#expandpath('../../DATA/REPORTS')#">

<cfdirectory 
   action = "list"
   directory = "#dpath#"
   name = "QrptList"
   filter="*.pdf"
 >


<table align="left" cellpadding="10" cellspacing="0" border="0"  class="box" width="100%">		
<cfform action="SPreport_det.cfm?#session.urltoken#" name="f1">

<tr>
	<td>&nbsp;<br><br></td>
</tr>
<tr>
	<th colspan="3">
		<h3>School Staff Tobacco Survey Summary Report Grid</h3>
		<h3>School Policy Partners</h3>
	</th>
</tr>

<!--- <tr><td>Select a partner and month for a new report:</td>
<td>
<cfselect name="partnerName" query="QPartnerList" display ="orgname" value="userid">
</cfselect>


<cfselect name="rptMon" query="QMonths" display ="mon" value="mon">
</cfselect>
</td>
<td><input type="Submit" value="Enter Feedback" <!--- onclick="setmonth2('<cfoutput>#MonthAsString(Month(now()))#</cfoutput>');" --->></td>

</tr> --->


<tr><td colspan="4">

<table align="center" cellpadding="10" cellspacing="0" border="0" class="box2">	
	




<cfif session.admin EQ 1 OR session.tcp EQ 1 OR session.statemanage EQ 1 OR session.cessman EQ 4>
<cfoutput>
<tr>
	<th align="left">NY State</th>
	<th><a href="SPreport_detState.cfm?#session.URLToken#">NY State Reports Available</a></th>
</tr>
</cfoutput>
</cfif>


<cfoutput query="QPartnerList" group="Area">
<tr>
	<th align="left">#Area#</th>
	<th><cfif session.areamanage EQ 1 OR session.admin EQ 1 OR session.tcp EQ 1 OR session.statemanage EQ 1 OR session.cessman EQ 4>

<a href="SPreport_detAM.cfm?#session.URLToken#&arn=#areanum#">#Area# Reports Available</a>
<cfelse>
	Reports Available
</cfif></th>
</tr>
<tr>
	<th>Partner</th>
	<th> 
	<!--- <cfif session.areamanage EQ 1 OR session.admin EQ 1 OR session.tcp EQ 1 OR session.statemanage EQ 1 OR session.cessman EQ 4>

<a href="SPreport_detAM.cfm?#session.URLToken#">Reports Available</a>
<cfelse>
	Reports Available
</cfif> --->
</th>
</tr>
<cfoutput>

<tr>
	<td><font color="Green">#orgname#</font></td>
	<td align="center">
	
	
	<cfquery name="qFile" dbtype="query">
 SELECT
 name
 FROM
 QrptList
 where name like '%' + '#seq2#' + '.pdf'  
 </cfquery> 
	
	<cfif qFile.recordcount GT 0>
	<a href="SPreport_det.cfm?#session.urltoken#&partnerid=#seq2#">Reports</a>
	
	<cfelse>No Reports for Partner</cfif> </td>
</tr>
</cfoutput>			
		


</cfoutput>
</table>



</td></tr>

</cfform>





</table></td></tr>	

</table>


<br>




</body>

</html>
