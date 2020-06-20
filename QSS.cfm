<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
<title>CAT</title>

<cfif isDefined("url.q")>
	<cfset form.Q=url.q>
</cfif>

<cfinclude template="catstruct.cfm">
<script language="javascript">
function disableme(){
for(var intloop=0; intloop <document.fqss.length; intloop++){
document.fqss[intloop].disabled=true;
}
}

function returnMenu(){
document.fqss.action = "QSP_menu.cfm?<cfoutput>#session.urltoken#</cfoutput>";
document.fqss.submit();
}
function prcForm(what){
if (what == "Add"){
document.fqss.action = "prc_qss.cfm?<cfoutput>#session.urltoken#</cfoutput>";

}
if (what == "Del"){
document.fqss.action = "prc_qss.cfm?Del=Y&<cfoutput>#session.urltoken#</cfoutput>";
document.fqss.submit();
}
}
</script>


<cfquery datasource="#application.DataSource#" 	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qselmembers">
	select descrip, num 
	from lu_comm_mbrs
	where year2=#session.fy#
	order by rank
</cfquery>

<cfquery datasource="#application.DataSource#" 	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qtfsp">
	select descrip, num
	from lu_tfsp
	where year2=#session.fy#
	and header =1
	order by rank
</cfquery>

<cfquery datasource="#application.DataSource#" 	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qtfsp2">
	select descrip, num
	from lu_tfsp
	where year2=#session.fy#
	and header =2
	order by rank
</cfquery>

<cfquery datasource="#application.DataSource#" 	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qpol">
	select descrip, num
	from lu_comm_pol
	where year2=#session.fy#
	order by rank
</cfquery>

<cfquery datasource="#application.DataSource#" 	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QpolV">
	select descrip, num
	from lu_comM_polV
	where year2=#session.fy#
	order by rank
</cfquery>

<!--- <cfquery datasource="#application.DataSource#" 	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qdistrict">
	select distinct agency_name
	from schools
	order by agency_name
</cfquery>
<cfquery datasource="#application.DataSource#" 	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qschool">
	select nces_id_code, agency_name, school_name
	from schools
	order by school_name
</cfquery> --->

<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qcollab_district">
	select distinct district
	from collaborators
	where userid='#session.userid#'
	and (del is null or del !=1)
	and school='999'
	<!--- and year2=#session.fy# --->
	order by 1
</cfquery>
<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qcollab_school">
	select distinct school
	from collaborators
	where userid='#session.userid#'
	and (del is null or del !=1)
	<!--- and year2=#session.fy# --->
	order by 1
</cfquery>
 
 <cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qschool">
	select bedscode,institutionName, district
	from nysed_school
	where <!--- district_code in (#valuelist(Qcollab_district.district)#)	
	and ---> bedscode in ( <cfif Qcollab_school.recordcount EQ 0>'0'<cfelse>#quotedvaluelist(Qcollab_school.school)#</cfif>)
	order by 2
</cfquery>


<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qdistrict">
	select 2, s.bedscode,s.institutionName, s.district, d.district_name as dn
	from nysed_school as s, nysed_district as d
	where <!--- district_code in (#valuelist(Qcollab_district.district)#)	
	and ---> bedscode in (<cfif Qcollab_school.recordcount GT 0> #quotedvaluelist(Qcollab_school.school)#<cfelse>'0'</cfif>)
	and d.district_id=s.district
	union
	select 1, s.bedscode,'**' + s.institutionName + '**', s.district, d.district_name
	from nysed_school as s, nysed_district as d
	where <!--- district_code in (#valuelist(Qcollab_district.district)#)	
	and ---> (
	<!--- (district in (<cfif Qschool.recordcount GT 0>#quotedvaluelist(Qschool.district)#<cfelse>'0'</cfif>) and bedscode like '%0000')
	or --->
	(district in (<cfif Qcollab_district.recordcount GT 0> #quotedvaluelist(Qcollab_district.district)#<cfelse>'0'</cfif>)and bedscode like '%0000')
	)
	and d.district_id=s.district
	order by 5,1,3
</cfquery>

<cfquery datasource="#application.DataSource#" 	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QselQSS">
select s.seq, s.sname, ns.InstitutionName, nd.district_name, s.datesurvey as dateob,
case tframe 
when 0 then '- other'
when 1 then '- baseline'
when 2 then '-3 month'
when 3 then '- 12 month'
else ''
end as survey
from 
sp_qss  s 
left outer join nysed_school  ns on ns.bedscode=s.sname 
left outer join nysed_district  nd on nd.district_id=left(s.sname,6)
where s.userid='#session.userid#'
and s.year2=#session.fy#
and s.q=#url.q#
order by s.seq
</cfquery>


<cfif isDefined("url.sec") and url.sec EQ 1>
<cfquery datasource="#application.DataSource#" 	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Q_selrecordPP1">
	select 
	sname,
	num_surveys,
	datesurvey,
	num_staff,
	tframe,
	per_content,
	per_imp,
	comp_1,
	comp_2,
	comp_3,
	comp_4,
	comp_5,
	comp_6,
	comp_7,
	comp_8,
	comp_9,
	seq
	from SP_QSS
	where 
	userid='#session.userid#'
	and year2=#session.fy#
	and Q=#url.q#
	and sname = '#url.school#'
	and seq=#url.seq2#
</cfquery>

<cfset form.sname=Q_selrecordPP1.sname>
<cfset form.datesurvey=dateformat(Q_selrecordPP1.datesurvey, 'm/d/yyyy')>
<cfset form.num_surveys=Q_selrecordPP1.num_surveys>
<cfset form.num_staff=Q_selrecordPP1.num_staff>
<cfset form.tframe=Q_selrecordPP1.tframe>
<cfset form.per_content=Q_selrecordPP1.per_content>
<cfset form.per_imp=Q_selrecordPP1.per_imp>
<cfset form.comp_1=Q_selrecordPP1.comp_1>
<cfset form.comp_2=Q_selrecordPP1.comp_2>
<cfset form.comp_3=Q_selrecordPP1.comp_3>
<cfset form.comp_4=Q_selrecordPP1.comp_4>
<cfset form.comp_5=Q_selrecordPP1.comp_5>
<cfset form.comp_6=Q_selrecordPP1.comp_6>
<cfset form.comp_7=Q_selrecordPP1.comp_7>
<cfset form.comp_8=Q_selrecordPP1.comp_8>
<cfset form.comp_9=Q_selrecordPP1.comp_9>
<!--- <cfset form.seq=Q_selrecordPP1.seq> --->
</cfif>

<DIV align="center" ><h3>Staff Survey Data: Quarter <cfoutput>#url.Q#</cfoutput></h3></DIV>
<cfform name="fqss">
<input type="hidden" name="Q" <cfoutput>value="#url.Q#"</cfoutput>>

<table width="80%" border=".2" align="center" class="box">
<tr><th colspan="3">Staff Survey Data Summary</th></tr>
<tr>
	<td colspan="2">School or District Name</td>
<td><cfif isDefined("url.stip_seq")>
		<cfselect name="sname" group="dn" query="Qdistrict" value="bedscode" display="institutionname" queryPosition="below" selected="#Qselectedstip.school_stip#" >
		<option value="999"><strong>Please select a School or District</strong></option>
	</cfselect>
	<cfelseif isDefined("form.sname")>
		<cfselect name="sname" group="dn" query="Qdistrict" value="bedscode" display="institutionname" queryPosition="below" selected="#form.sname#" >
		<option value="999"><strong>Please select a School or District</strong></option>
	</cfselect>
	<cfelse>
		<cfselect name="sname" group="dn" query="Qdistrict" value="bedscode" display="institutionname" queryPosition="below">
		<option value="999"><strong>Please select a School or District</strong></option>
	</cfselect>
	</cfif>
</td></tr>

<tr>
	<td colspan="2">Date Staff Surveys Completed</td>
	<td>
	<cfif isDefined("form.dateSurvey")>
	<cfinput type="text" name="dateSurvey" validate="date" message="Please enter a valid date format" value="#form.dateSurvey#" required="yes">
	<cfelse>
	<cfinput type="text" name="dateSurvey" validate="date" message="Please enter a valid date format" required="yes">
	</cfif>
	</td>
</tr>

<tr>
	<td colspan="2">Number of Survey Responses</td>
	<td>
		<cfif isDefined("form.num_surveys")>
			<cfinput type="text" name="num_surveys" size="5" value="#form.num_surveys#" validate="integer" message="Please enter an integer for number of surveys"  required="yes">
		<cfelse>
			<cfinput type="text" name="num_surveys" size="5" validate="integer" message="Please enter an integer for number of surveys"  required="yes">
		</cfif>
	</td>
</tr>
<tr>
	<td colspan="2">Total number of Staff at School</td>
	<td>
		<cfif isDefined("form.num_staff")>
			<cfinput type="text" name="num_staff" size="5" value="#form.num_staff#" validate="integer" message="Please enter an integer for number of staff"  required="yes">
		<cfelse>
			<cfinput type="text" name="num_staff" size="5" validate="integer" message="Please enter an integer for number of surveys"  required="yes">
		</cfif>
	</td>
</tr>

<tr>
	<td colspan="2" valign="top" valign="top">Timeframe of Staff Survey</td>
	<td valign="top">
		<!--- <input type="radio" name="tframe" value="1"> Baseline<br> --->
		
		<cfif isDefined("form.tframe") and form.tframe EQ 1>
			<cfinput type="radio" name="tframe" value="1" checked required="yes" message="Please select a value for timeframe of survey">
		<cfelse>
				<cfinput type="radio" name="tframe" value="1"  required="yes" message="Please select a value for timeframe of survey">
		</cfif> Baseline	<br>
		
		<cfif isDefined("form.tframe") and form.tframe EQ 2>
			<cfinput type="radio" name="tframe" value="2" checked required="yes" message="Please select a value for timeframe of survey">
		<cfelse>
				<cfinput type="radio" name="tframe" value="2"  required="yes" message="Please select a value for timeframe of survey">
		</cfif> 3 month follow up	<br>
		
		<cfif isDefined("form.tframe") and form.tframe EQ 3>
			<cfinput type="radio" name="tframe" value="3" checked required="yes" message="Please select a value for timeframe of survey">
		<cfelse>
				<cfinput type="radio" name="tframe" value="3"  required="yes" message="Please select a value for timeframe of survey">
		</cfif> 12 month follow up	<br>
		
		
		<cfif isDefined("form.tframe") and form.tframe EQ 0>
			<cfinput type="radio" name="tframe" value="0" checked required="yes" message="Please select a value for timeframe of survey">
		<cfelse>
				<cfinput type="radio" name="tframe" value="0"  required="yes" message="Please select a value for timeframe of survey">
		</cfif> Other
		
		<!--- <cfinput type="radio" name="tframe" value="2" <cfif isDefined("form.tframe") and form.tframe EQ 2> checked</cfif>> 3 month follow up	<br>
		<cfinput type="radio" name="tframe" value="3" <cfif isDefined("form.tframe") and form.tframe EQ 3> checked</cfif>> 12 month follow up<br>		
		<cfinput type="radio" name="tframe" value="0" <cfif isDefined("form.tframe") and form.tframe EQ 0> checked</cfif>> Other	 --->
	</td>
</tr>

<tr>
	<td valign="top"> Content of Policy</td>
	<td valign="top">% Respondents who indicate familiarity with rules and procedures of the tobaccor policy regarding no tobacco use</td>
	<td valign="top">
		<cfif isdefined("form.per_content")>
			<cfinput type="text" name="per_content" size="5" value="#form.per_content#" validate="range" range="0,100" message="Please enter valid percentages from 0-100" required="yes">
		<cfelse>
			<cfinput type="text" name="per_content" size="5" validate="range" range="0,100" message="Please enter valid percentages from 0-100" required="yes">
		</cfif>
		
	</td>
</tr>
<tr>
	<td valign="top">Impact of Policy</td>
	<td valign="top">% Respondents who feel the policy is very or moderately effective towards no tobacco use on schooll property</td>
	<td valign="top">
	<cfif isdefined("form.per_imp")>
		<cfinput type="text" name="per_imp" size="5" value="#form.per_imp#" validate="range" range="0,100" message="Please enter valid percentages from 0-100" required="yes">
	<cfelse>
		<cfinput type="text" name="per_imp" size="5" validate="range" range="0,100" message="Please enter valid percentages from 0-100" required="yes">
	</cfif>
	</td>
	
</tr>

<tr>
	<td rowspan="9" valign="top">Compliance with Policy</td>
	<td valign="top">% Staff who strongly agree or agree that the rules and procedures regarding no tobacco use on school property are consistently enforced for all students</td>
	<td valign="top">
	<cfif isdefined("form.comp_1")>
		<cfinput type="text" name="comp_1" size="5" value="#form.comp_1#" validate="range" range="0,100" message="Please enter valid percentages from 0-100" required="yes">
	<cfelse>
		<cfinput type="text" name="comp_1" size="5" validate="range" range="0,100" message="Please enter valid percentages from 0-100" required="yes">
	</cfif>
	</td>
</tr>
<tr>
	<td valign="top">% Staff who strongly agree or agree that the rules and procedures regarding no tobacco use on school property are consistently enforced for all staff</td>
	<td valign="top">
	<cfif isdefined("form.comp_2")>
		<cfinput type="text" name="comp_2" size="5" value="#form.comp_2#" validate="range" range="0,100" message="Please enter valid percentages from 0-100" required="yes">
	<cfelse>
		<cfinput type="text" name="comp_2" size="5" validate="range" range="0,100" message="Please enter valid percentages from 0-100" required="yes">
	</cfif>
	</td>
</tr>
<tr>
	<td valign="top">% Staff who strongly agree or agree that the rules and procedures regarding no tobacco use on school property are consistently enforced for all visitors</td>
	<td valign="top">
	<cfif isdefined("form.comp_3")>
		<cfinput type="text" name="comp_3" size="5" value="#form.comp_3#" validate="range" range="0,100" message="Please enter valid percentages from 0-100" required="yes">
	<cfelse>
		<cfinput type="text" name="comp_3" size="5" validate="range" range="0,100" message="Please enter valid percentages from 0-100" required="yes">
	</cfif>
	</td>
</tr>
<tr>
	<td valign="top">% Staff who say signs are posted at school grounds entrances regarding no tobacco use on school property</td>
	<td valign="top">
	<cfif isdefined("form.comp_4")>
		<cfinput type="text" name="comp_4" size="5" value="#form.comp_4#" validate="range" range="0,100" message="Please enter valid percentages from 0-100" required="yes">
	<cfelse>
		<cfinput type="text" name="comp_4" size="5" validate="range" range="0,100" message="Please enter valid percentages from 0-100" required="yes">
	</cfif>
	</td>
</tr>
<tr>
	<td valign="top">% Staff who say signs are posted at school building entrances regarding no tobacco use on school property</td>
	<td valign="top">
	<cfif isdefined("form.comp_7")>
		<cfinput type="text" name="comp_7" size="5" value="#form.comp_7#" validate="range" range="0,100" message="Please enter valid percentages from 0-100" required="yes">
	<cfelse>
		<cfinput type="text" name="comp_7" size="5" validate="range" range="0,100" message="Please enter valid percentages from 0-100" required="yes">
	</cfif>
	</td>
</tr>

<tr>
	<td valign="top">% Staff who have seen anyone (student, staff, visitor) <strong>smoking inside</strong> the school building(s) in the past 7 days</td>
	<td valign="top">
	<cfif isdefined("form.comp_5")>
		<cfinput type="text" name="comp_5" size="5" value="#form.comp_5#" validate="range" range="0,100" message="Please enter valid percentages from 0-100" required="yes">
	<cfelse>
		<cfinput type="text" name="comp_5" size="5" validate="range" range="0,100" message="Please enter valid percentages from 0-100" required="yes">
	</cfif>
	</td>
</tr>
<tr>
	<td valign="top">% Staff who have seen anyone (student, staff, visitor) <strong>smoking outside</strong> the school building(s) in the past 7 days</td>
	<td valign="top">
	
	<cfif isdefined("form.comp_6")>
		<cfinput type="text" name="comp_6" size="5" value="#form.comp_6#" validate="range" range="0,100" message="Please enter valid percentages from 0-100" required="yes">
	<cfelse>
		<cfinput type="text" name="comp_6" size="5" validate="range" range="0,100" message="Please enter valid percentages from 0-100" required="yes">
	</cfif>
	</td>		
</tr>
<tr>
	<td valign="top">% Staff who have seen anyone (student, staff, visitor) using <strong>smokeless tobacco inside</strong> the school building(s) in the past 7 days 
</td>
	<td valign="top">
	
	<cfif isdefined("form.comp_8")>
		<cfinput type="text" name="comp_8" size="5" value="#form.comp_8#" validate="range" range="0,100" message="Please enter valid percentages from 0-100" required="no">
	<cfelse>
		<cfinput type="text" name="comp_8" size="5" validate="range" range="0,100" message="Please enter valid percentages from 0-100" required="no">
	</cfif>
	</td>		
</tr>
<tr>
	<td valign="top">% Staff who have seen anyone (student, staff, visitor) using <strong>smokeless tobacco outside</strong> the school building(s) in the past 7 days
</td>
	<td valign="top">
	
	<cfif isdefined("form.comp_9")>
		<cfinput type="text" name="comp_9" size="5" value="#form.comp_9#" validate="range" range="0,100" message="Please enter valid percentages from 0-100" required="no">
	<cfelse>
		<cfinput type="text" name="comp_9" size="5" validate="range" range="0,100" message="Please enter valid percentages from 0-100" required="no">
	</cfif>
	</td>		
</tr>




<tr>
	<td colspan="3" align="left">
<!--- 		<input type="button" class="AddButton" value="Add" onClick="prcForm('Add');">
 --->		<input type="submit" class="AddButton" <cfif isDefined("url.sec")> value="Update"<cfelse> value="Add"</cfif> onClick="return prcForm('Add');">
	</td>
</tr>

<cfif QselQSS.recordcount GT 0>
<cfoutput>
<cfloop query="QselQSS">
<tr bgcolor="Silver">
	<td colspan="2">
	<a href="qss.cfm?#session.urltoken#&q=#url.q#&school=#sname#&seq2=#seq#&sec=1">#district_name# #InstitutionName# #dateformat(dateob,'mmm dd yyyy')# #survey#</a>
	</td>
	<td align="right">
		Delete?
		<input type="checkbox" name="delQSS2" value="#seq#">
	</td>
	
</tr>
</cfloop>
<tr>
	<td colspan="3">
		<input type="button" class="DelButton" value="Delete" onClick="return prcForm('Del');">
	</td>
</tr>

</cfoutput>
</cfif>
</table>

<!--- <cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qext">
	select userid from quarterly_extensions
	where userid = '#session.userid#'	
</cfquery>

<cfif Qext.recordcount EQ 0>
<cfset tempyr=session.fy>
<cfif tempyr EQ 1904>
	<cfset tempyr=2006>
</cfif>
<cfif (session.fy NEQ session.def_fy OR <!--- session.fy EQ session.def_fy OR  --->

(form.Q EQ 1 and DateCompare(createDate(session.fy, 4, 15),Dateformat(now())) LT 0)
OR 
(form.Q EQ 2 and DateCompare(createDate(session.fy, 7, 15),Dateformat(now())) LT 0)
OR 
(form.Q EQ 3 and DateCompare(createDate(session.fy, 10, 15),Dateformat(now())) LT 0)
OR 
(form.Q EQ 4 and DateCompare(createDate(session.fy+1, 1, 15),Dateformat(now())) LT 0)
<!--- AND session.userid NEQ 'QHC' --->
)
and session.fy EQ "1234">
	<script language="JavaScript">
	disableme();
	</script>	
</cfif>
</cfif> --->

</cfform>
<div align="center"><input type="button" value="Save and Return to Main Screen" onClick="returnMenu();"></div>

</body>


<!--- <cfif  ((session.userid  EQ "ccfulton" and now() LT "2/26/2009")OR(session.userid  EQ "gvbocesawgo" and now() LT "2/20/2009") ) >
<!--- Maureen gets an extension --->
<cfelse>
<script language="JavaScript">
	disableme();
</script>
</cfif> --->
		
<cfinclude template="quarterly_extm.cfm">
</html>
