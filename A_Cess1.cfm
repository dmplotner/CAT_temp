
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
<title>CAT</title>

<cfinclude template="catstruct.cfm">
<table class="box" width="100%"><tr><td><br><br>
<SCRIPT LANGUAGE="JavaScript" SRC="RegExpValidate.js"></SCRIPT>
<script language="JavaScript">
function add(actvalue){
document.QCess.dofunction.value=actvalue;
document.QCess.patient_pop.value=removeCommas( document.QCess.patient_pop.value );
return true;
}

</script>
<cfif isDefined("url.q")>
	<cfset form.Q=url.q>
<cfelse>
	<cfset form.Q="1">
</cfif>








<cfquery datasource="#application.DataSource#"  	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qcalc_1">
	select sum(enrolled) as calc_one
	from ICIQ
	where userid='#session.userid#'
	and
	<cfif form.q EQ "1">
	year2=(#session.fy#-1)
	and q between 3 and 4
	<cfelseif form.q EQ "2">
	(
	(year2=(#session.fy#-1)
	and q=4)
	or 
	(year2=#session.fy#
	and q =1)
	)
	<cfelseif form.q EQ "3">
	year2=#session.fy#
	and q between 1 and 2
	<cfelseif form.q EQ "4">
	year2=#session.fy#
	and q between 2 and 3
	</cfif>	
</cfquery>



<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qcalc_2">
	select sum(enrolled) as calc_three
	from ICIQ
	where userid='#session.userid#'
	and
	<cfif form.q EQ "1">
	year2=(#session.fy#-1)
	and q between 1 and 4
	<cfelseif form.q EQ "2">
	(
	(year2=(#session.fy#-1)
	and q between 2 and 4)
	or 
	(year2=#session.fy#
	and q =1)
	)
	<cfelseif form.q EQ "3">
	((year2=(#session.fy#-1)
	and q between 3 and 4)
	or
	(year2=#session.fy#
	and q between 1 and 2))
	<cfelseif form.q EQ "4">
	((year2=#session.fy#
	and q=4)
	or
	(year2=#session.fy#
	and q between 1 and 3))
	</cfif>	
</cfquery>









<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QCatchmentCount">
	
	select catchment 
	from contact
	where userid='#session.userid#'
</cfquery>

<cfset NumCounties = ListLen(QCatchmentCount.catchment)>
<cfset NumCols=NumCounties + 3>


<cfif CGI.http_referer DOES NOT CONTAIN "QCess1.cfm">
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QselICIQ">
	select *
	from ICIQ
	where userid='#session.userid#'
	and year2='#session.fy#'
	and q='#form.q#'
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QselICIQ2">
	select *
	from ICIQ2
	where userid='#session.userid#'
	and year2='#session.fy#'
	and q='#form.q#'
</cfquery>

<cfif QselICIQ2.recordcount GT 0>
<cfoutput>
<cfset form.six_mos_contact="#QselICIQ2.six_mos_contact#">
<cfset form.seven_d_abst_six="#QselICIQ2.seven_d_abst_six#">
<cfset form.twelve_mos_contact="#QselICIQ2.twelve_mos_contact#">
<cfset form.seven_d_abst_twelve="#QselICIQ2.seven_d_abst_twelve#">
</cfoutput>


</cfif>



<cfif QselICIQ.recordcount GT 0>
<cfoutput>
<cfset form.enrolled="#QselICIQ.enrolled#">
<cfset form.dist_p="#QselICIQ.dist_p#">
<cfset form.dist_g="#QselICIQ.dist_g#">
<cfset form.dist_lo="#QselICIQ.dist_lo#">
<cfset form.dist_in="#QselICIQ.dist_in#">
<cfset form.dist_n="#QselICIQ.dist_n#">
<cfset form.dist_z="#QselICIQ.dist_z#">
</cfoutput>

</cfif>

</cfif>
 
<cfif isDefined("form.dofunction")>



<cfif form.dofunction EQ "addAnnual">
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QaddAnnual">
	insert into AROD
	(userid, year2, collab_id, patient_pop, type)
	values
	('#session.userid#', #session.fy#, '#form.annual_collab#', '#form.patient_pop#', '#form.annual_type#')
	
</cfquery>
<cfelseif form.dofunction EQ "delAnnual">
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QdelAnnual">
	delete from AROD
	where userid='#session.userid#'
	and seq in (#form.delAnnual#)	
</cfquery>
</cfif>

</cfif>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qcollaborators">
	select name, seq,
	case 
	 when unit IS NULL then NAME
	 else unit + ' ' + NAME
	end as unitname 
	from collaborators 
	where  userid = '#session.userid#'	
	and (del is null or del !=1)
	order by 3
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QBCIQR_method">
	select id, descr
	from lu_q_cess_method
	order by rank
</cfquery>

<!--- <cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QBCIQR">
select collab_id, num_screened, percent_screened, num_id, percent_id, num_interv, percent_interv, method, seq
from BCIQR
where q='#form.q#'
and userid='#session.userid#'	
order by seq
</cfquery> 
--->
<cfform name="QCess"> 

<input type="Hidden" name="dofunction" value="">

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QannualType">
	select id, descr 
	from lu_annual_type
	where year2='#session.fy#'
	order by rank
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QannualDet">
	select c.name, a.patient_pop,b.descr , a.seq,
	case 
	 when c.unit IS NULL then c.NAME
	 else c.unit + ' ' + c.NAME
	end as unitname 
	from lu_annual_type as b, arod as a, collaborators as c
	where 
	a.collab_id=c.seq
	  and (c.del is null or c.del !=1)
	and a.type=b.id
	and a.year2=b.year2
	and a.year2='#session.fy#'
	and a.userid='#session.userid#'	
	order by 5
</cfquery>
<table width="80%" border=".2" align="center" class="box">
<tr>
	<th colspan="4">Annual Report Outcome data to be supplied by each Cessation Center</th>
</tr>
<tr>
	<th>Target HCPO</th>
	<th>Total patient population</th>
	<th>Type of data used</th>
	<th>&nbsp;</th>
</tr>
<tr>
	<td>
	<select name="annual_collab">
	<option value="" selected>
	<cfoutput>
	<cfloop query="Qcollaborators">
	<option value="#seq#">#unitname#
	</cfloop>
	</cfoutput>
	</select> 
	</td>
	<td><cfinput name="patient_pop" type="Text" validate="integer" message="Please enter an integer value for patient population"></td>
	<td>
	<select name="annual_type">
	<option value="" selected>
	<cfoutput>
	<cfloop query="QannualType">
	<option value="#id#">#descr#
	</cfloop>
	</cfoutput>
	</select> 
	</td>
	<td><input type="Submit" value="Add" onclick="return add('addAnnual');" class="AddButton"></td>
</tr>

<cfif QannualDet.recordcount GT 0>
<cfoutput>
<cfloop query="QannualDet">
<tr bgcolor="Silver">
	<td>#unitname#</td>
	<td>#patient_pop#</td>
	<td>#descr#</td>
	<td>Delete<input name="delAnnual" type="Checkbox" value="#seq#"></td>
</tr>
</cfloop>
<tr>
	<td colspan="4" align="right"><input type="Submit" value="Delete" onclick="return add('delAnnual');" class="DelButton"></td>
</tr>
</cfoutput>
</cfif>
</table>

</cfform>
<br><br><br><br><br></td></tr></table>
</html>