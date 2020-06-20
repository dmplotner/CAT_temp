<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qcollaborators_PIP">
	select name, seq,
	case 
	 when unit IS NULL then NAME
	 else unit + ' ' + NAME
	end as unitname 
	from collaborators 
	where  userid = '#session.userid#'	
	and (del is null or del !=1)
	and  timprovement=1	
	order by 3
</cfquery>

<cfif Qcollaborators_PIP.recordcount GT 0>
<tr><td>
<table align="left" width="50%" class="box">
<tr><th colspan="3" align="left">Performance Improvement Project (PIP)<!--- <br>Enter information here ONLY if PIP occurred this month. ---></th></tr>

<tr><td colspan="2"></td></tr>
<tr>
	<td><strong>HCPOs with PIP</strong></td>
	<td><strong># of providers participating</strong></td>
	<!--- <td>Update to # of providers</td> --->
</tr>
<cfoutput>
<cfloop query="Qcollaborators_PIP">
	
	
	
	
	<cfquery datasource="#application.DataSource#"  	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qcollaborators_PIPnum">
		
		select providerNum from cc_advoc_pip_num n
where hcpoId= '#Qcollaborators_PIP.seq#'
and year2 =#session.fy#
and userid = '#session.userid#'
and month2='#form.monthdisplay#'

</cfquery>

<cfif Qcollaborators_PIPnum.recordcount EQ 0>
<cfquery datasource="#application.DataSource#"  	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qcollaborators_PIPnum">	
select providerNum from cc_advoc_pip_num n, months as m
where hcpoId= '#Qcollaborators_PIP.seq#'
and year2 <=#session.fy#
and userid = '#session.userid#'
and year2 in
(select 0 union 
select max(year2) 
from cc_advoc_pip_num 
where hcpoId= '#Qcollaborators_PIP.seq#'
and userid = '#session.userid#')
and m.mon=n.month2 and m.year2 = n.year2
order by rank desc
</cfquery>
</cfif>
	
<tr>
	<td>#unitname#
	<td><input type="text" name="PIPNUM_#Qcollaborators_PIP.seq#" size="5" value="<cfif Qcollaborators_PIPnum.recordcount GT 0>#Qcollaborators_PIPnum.providerNum#<cfelse>0</cfif>"> </td>
	<!--- <td><input name="test" size="5"><input type="button" value="Save"></td> --->
</tr>
</cfloop>

<cfif Qcollaborators_PIP.recordcount GT 0>
<!-- <tr><td><input type="button" value="Update Values"></td></tr>
 -->
</cfif>
<tr><td></td></tr>


<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Q_PIPComments">
	
select comment
from cc_advoc_pip_comments n
where year2 =#session.fy#
and userid = '#session.userid#'
and year2 =#session.fy#
and strategy = <cfqueryparam  cfsqltype="cf_sql_varchar" value="#activity#"> 
and month2= <cfqueryparam  cfsqltype="cf_sql_varchar" value="#monthdisplay#"> 
</cfquery>

<tr>
		<td colspan="3">PIP Comments (Training and technical assistance this month). <br>Enter information here ONLY if PIP activities occurred this month:</td>
</tr>
<tr>
		<td colspan="3"><textarea name="pipcomments" cols="80" rows="4"><cfif Q_PIPComments.recordcount GT 0><cfoutput>#Q_PIPComments.comment#</cfoutput></cfif></textarea></td>
</tr>
</cfoutput>
<tr>
<td  colspan="3"><input type="Submit" value="Save"  class="AddButton"></td>

</tr>
</table>

</td></tr>
</cfif>