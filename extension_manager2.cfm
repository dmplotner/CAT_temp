<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
<title>CAT</title>
<script>
function showhide(id, sh){
if (document.getElementById){
obj = document.getElementById(id);
if (sh == "show"){
obj.style.display = "";
} else {
obj.style.display = "none";
}
}
}

function evaluatemenu(){
if (document.collaborations.extensiontype.options[document.collaborations.extensiontype.selectedIndex].value ==1||document.collaborations.extensiontype.options[document.collaborations.extensiontype.selectedIndex].value ==3||document.collaborations.extensiontype.options[document.collaborations.extensiontype.selectedIndex].value ==5){
showhide('year1','hide');
}
else{
showhide('year1','show');
} 

if (document.collaborations2.extensiontype2.options[document.collaborations2.extensiontype2.selectedIndex].value ==1||document.collaborations2.extensiontype2.options[document.collaborations2.extensiontype2.selectedIndex].value ==3||document.collaborations2.extensiontype2.options[document.collaborations2.extensiontype2.selectedIndex].value ==5){
showhide('year2','hide');
}
else{
showhide('year2','show');
} 
}
</script> 

<cfinclude template="CATstruct.cfm">
<cfif isDefined("url.add") AND url.add EQ "user">
<cfif  isdefined("form.extensionfy") and form.extensionfy EQ 0>
<cfquery datasource="#application.DataSource#"   
	password="#application.db_password#"   		
	username="#application.db_username#" name="qcheckfy">
	select case partnertype 
	when 4 then sp_fy else fy end as pfy 	
	from contact c , admin a 
	where c.userid=<cfqueryparam CFSQLType ="CF_SQL_VARCHAR" value="#form.partnerid#">
	
</cfquery>
<cfset form.extensionfy = qcheckfy.pfy>

<cfif form.extensiontype EQ 5>
<!--- <cfset form.extensionfy = form.extensionfy -1> --->
</cfif>
</cfif>

<cfquery datasource="#application.DataSource#"   
	password="#application.db_password#"   		
	username="#application.db_username#" name="qcheckinsert">
select * from extensions
where userid= <cfqueryparam CFSQLType ="CF_SQL_VARCHAR" value="#form.partnerid#">
and exttype = <cfqueryparam CFSQLType ="CF_SQL_INTEGER" value="#form.extensiontype#">
and extfy = <cfqueryparam CFSQLType ="CF_SQL_INTEGER" value="#form.extensionfy#">

</cfquery>

<cfif qcheckinsert.recordcount EQ 0>

<cfquery datasource="#application.DataSource#"   
	password="#application.db_password#"   		
	username="#application.db_username#" name="qcheckinsert">
insert into extensions
(userid, exttype, extfy, creator, initdate, enddate)
values
(<cfqueryparam CFSQLType ="CF_SQL_VARCHAR" value="#form.partnerid#">,
<cfqueryparam CFSQLType ="CF_SQL_INTEGER" value="#form.extensiontype#">,
<cfqueryparam CFSQLType ="CF_SQL_INTEGER" value="#form.extensionfy#">,
<cfqueryparam CFSQLType ="CF_SQL_VARCHAR" value="#session.userid#">, getdate(), getdate()+7)
</cfquery>

<cfquery datasource="#application.DataSource#"   
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qmailinfo">
	<cfif now() gt '11/30/2008'>
	
	select c1.orgname, c1.contact, c1.coordemail,
	c2.coordemail as manmail
	from contact as c1, contact as c2
	where
	c1.cmanager=c2.userid		
	and c1.userid=<cfqueryparam CFSQLType ="CF_SQL_VARCHAR" value="#form.partnerid#">
	
	
	<cfelse>

	select c1.orgname, c1.contact, c1.coordemail,
	c2.coordemail as manmail
	from contact as c1, contact as c2 , area as a 
	where
	c1.area=a.num	
	and a.manager_id=c2.userid
	and c1.userid=<cfqueryparam CFSQLType ="CF_SQL_VARCHAR" value="#form.partnerid#">
	and a.year2=#session.fy# 
	
	</cfif>
</cfquery>



<cfif Qmailinfo.recordcount GT 0>

<cfif form.extensiontype EQ 1 or form.extensiontype EQ 2>
	<cfset exttxt="Monthly reporting">	
<cfelseif form.extensiontype EQ 3 or form.extensiontype EQ 4>
	<cfset exttxt="Quarterly reporting">
<cfelseif form.extensiontype EQ 5>	
	<cfset exttxt="EOY">
<cfelse>
	<cfset exttxt="">
</cfif>
	
<cfmail to="#Qmailinfo.coordemail#" from="nsarris@rti.org" cc="#Qmailinfo.manmail#" bcc="dplotner@rti.org" subject="CAT #exttxt# extension" type="html">
You have been granted an extension to complete or correct data entry in the Community Activity Tracking (CAT) system.  
All extensions are for seven (7) days only and will automatically expire after that time period.  
Please complete all your changes and additions in the seven day time period allotted.
<br><br>
Please contact Nikie Sarris or Betty Brown with questions, at 1-800-848-4091 or <a href="mailto:nsarris@rti.org">nsarris@rti.org</a> or <a href="mailto:bettybrown@rti.org">bettybrown@rti.org</a>.



</cfmail>

</cfif>
</cfif>

<cfif form.extensiontype EQ 5>
	<cfquery datasource="#application.DataSource#"   
	password="#application.db_password#"   		
	username="#application.db_username#" name="qunsubmit">
	update eoy_basics
	set complete =0
	where year2=<cfqueryparam CFSQLType ="CF_SQL_INTEGER" value="#form.extensionfy#">
	and userid = <cfqueryparam CFSQLType ="CF_SQL_VARCHAR" value="#form.partnerid#">
</cfquery>

</cfif>


<!--- Modality Wide Extension --->
<cfelseif  isDefined("url.add") AND url.add EQ "modality" and form.modality NEQ 0>
<cfif  isdefined("form.extensionfy2") and form.extensionfy2 EQ 0>
<cfquery datasource="#application.DataSource#"   
	password="#application.db_password#"   		
	username="#application.db_username#" name="qcheckfy">
	select 
<cfif form.modality EQ 4> sp_fy <cfelse> fy </cfif> as pfy 	
	from admin 
</cfquery>
<cfset form.extensionfy2 = qcheckfy.pfy>
</cfif>
<cfquery datasource="#application.DataSource#"   
	password="#application.db_password#"   		
	username="#application.db_username#" name="qdel">
delete from extensions
where userid in (select userid from contact where partnertype=<cfqueryparam CFSQLType ="CF_SQL_VARCHAR" value="#form.modality#">
and exttype = <cfqueryparam CFSQLType ="CF_SQL_INTEGER" value="#form.extensiontype2#">
and extfy = <cfqueryparam CFSQLType ="CF_SQL_INTEGER" value="#form.extensionfy2#">)
and userid not in ('boceswsnassau', 'boceswssuffolk')
</cfquery>

<cfquery datasource="#application.DataSource#"   
	password="#application.db_password#"   		
	username="#application.db_username#" name="qinsert">
insert into extensions
(userid, exttype, extfy, creator, initdate, enddate)
select userid,
<cfqueryparam CFSQLType ="CF_SQL_INTEGER" value="#form.extensiontype2#">,
<cfqueryparam CFSQLType ="CF_SQL_INTEGER" value="#form.extensionfy2#">,
<cfqueryparam CFSQLType ="CF_SQL_VARCHAR" value="#session.userid#">, getdate(), getdate()+7 
from contact
where 
partnertype=<cfqueryparam CFSQLType ="CF_SQL_VARCHAR" value="#form.modality#">
</cfquery>

<cfif  form.extensiontype2 EQ 5>
	<cfquery datasource="#application.DataSource#"   
	password="#application.db_password#"   		
	username="#application.db_username#" name="qunsubmit">
	update eoy_basics
	set complete =0
	where year2=<cfqueryparam CFSQLType ="CF_SQL_INTEGER" value="#form.extensionfy2#">
	and userid in (select userid from contact where partnertype=<cfqueryparam CFSQLType ="CF_SQL_VARCHAR" value="#form.modality#">)
</cfquery>

</cfif>


<!--- add for all modalities, all users --->
<cfelseif  isDefined("url.add") AND url.add EQ "modality" and form.modality EQ 0>
<cfparam name="form.extensionfy1" default="#session.def_fy#">
<cfquery datasource="#application.DataSource#"   
	password="#application.db_password#"   		
	username="#application.db_username#" name="qdel">
delete from extensions
where exttype = <cfqueryparam CFSQLType ="CF_SQL_INTEGER" value="#form.extensiontype2#">
and extfy = <cfqueryparam CFSQLType ="CF_SQL_INTEGER" value="#form.extensionfy2#">)
and userid not in ('boceswsnassau', 'boceswssuffolk')
</cfquery>
<cfquery datasource="#application.DataSource#"   
	password="#application.db_password#"   		
	username="#application.db_username#" name="qinsert">
insert into extensions
(userid, exttype, extfy, creator, initdate, enddate)
select userid,
<cfqueryparam CFSQLType ="CF_SQL_INTEGER" value="#form.extensiontype2#">,
<cfif isDefined("form.extensionfy2") and form.extensionfy2 NEQ 0>
	<cfqueryparam CFSQLType ="CF_SQL_INTEGER" value="#form.extensionfy2#">
<cfelse>
CASE  partnertype 
	when 4 then sp_fy else fy end
</cfif>,
<cfqueryparam CFSQLType ="CF_SQL_VARCHAR" value="#session.userid#">, getdate(), getdate()+7 from contact c, admin

</cfquery>

<cfif form.extensiontype2 EQ 5>
	<cfquery datasource="#application.DataSource#"   
	password="#application.db_password#"   		
	username="#application.db_username#" name="qunsubmit">
	update eoy_basics
	set complete =0
	where year2=<cfqueryparam CFSQLType ="CF_SQL_INTEGER" value="#form.extensionfy2#">
	
</cfquery>

</cfif>


<!--- Deletions --->
<cfelseif isDefined("url.add") and url.add EQ "del">
<cfquery datasource="#application.DataSource#"   
	password="#application.db_password#"   		
	username="#application.db_username#" name="qdel">
delete from extensions
where seq in (<cfqueryparam list separator="," value="#form.del_ext#">)
and userid not in ('boceswsnassau', 'boceswssuffolk')
</cfquery>
</cfif>

<cfquery datasource="#application.DataSource#"   
	password="#application.db_password#"   		
	username="#application.db_username#" name="qgetextensions">

select orgname, a.area, m.long_descrip as modality, e.enddate, 
t.descr, e.seq,
case e.extfy when 1904 then 'FY 2005-2006 SP' else 'FY ' + cast((e.extfy-1) as varchar) + '-' + cast(e.extfy as varchar) end as extfy
from contact c, area a, modality m, extensions e, extensiontypes t
where c.partnertype=m.modality
and c.area =a.num
and a.year2=2007
and c.userid= e.userid
and t.extid=e.exttype
order by 1,5

</cfquery>

	 
<tr><td><br><br><br><br></td></tr>
<table class="box" align="center" cellpadding="10" cellspacing="0" border="0" >
<tr><td align="center"><h2>Extension Management</h2></td></tr>


<cfquery datasource="#application.DataSource#"   
	password="#application.db_password#"   		
	username="#application.db_username#" name="qpartners">

select c.userid, orgname, a.area, m.long_descrip as modality
from contact c, area a, modality m, security s
where c.partnertype=m.modality
and c.coordemail is not null
and c.coordemail not like '%rti.org'
and c.coordemail not like '%health.state.ny.us'
and c.area =a.num
and a.year2=2007
and c.userid=s.userid
and s.del is null
order by orgname
</cfquery>

<cfquery datasource="#application.DataSource#"   
	password="#application.db_password#"   		
	username="#application.db_username#" name="qmodalities">

select modality as modnum, long_descrip as modality
from modality 
union 
select 0, 'All Modalities'
order by 1
</cfquery>

<cfquery datasource="#application.DataSource#"   
	password="#application.db_password#"   		
	username="#application.db_username#" name="qexttype">

select extid, descr
from extensiontypes
order by extid
</cfquery>


<cfquery datasource="#application.DataSource#"   
	password="#application.db_password#"   		
	username="#application.db_username#" name="qextfy">

select distinct case year2 when 1904 then 'FY 2005-2006 SP' else 'FY ' + cast((year2-1) as varchar) + '-' + cast(year2 as varchar) end as descr, year2 as extid
from useractivities
order by 2
</cfquery>





<!--- <cfquery datasource="#application.DataSource#"   
	password="#application.db_password#"   		
	username="#application.db_username#" name="QaddStrat">
	insert into msr_extensions
	(userid, initdate, enddate) 
	values
	('#usID#', getdate(), getdate()+7)	
</cfquery>

<cfquery datasource="#application.DataSource#"   
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qmailinfo">
	select c1.orgname, c1.contact, c1.email,
	c2.email as manmail
	from contact as c1, contact as c2, area as a
	where
	c1.area=a.num	
	and a.manager_id=c2.userid
	and c1.userid='#usID#' 
	and a.year2=#session.fy# 
</cfquery>

<cfif Qmailinfo.recordcount GT 0>
<cfmail to="#Qmailinfo.email#" from="bettybrown@rti.org" cc="#Qmailinfo.manmail#" subject="MSR extension" type="html">
You have been granted an extension to complete or correct data entry in the Community Activity Tracking (CAT) system.  
All extensions are for seven (7) days only and will automatically expire after that time period.  
Please complete all your changes and additions in the seven day time period allotted.
<br><br>
Please contact Betty Brown with any questions, at 1-800-848-4091 or <a href="mailto:bettybrown@rti.org">bettybrown@rti.org</a>.



</cfmail> --->

<cfform name="collaborations" action="extension_manager2.cfm?#session.urltoken#&add=user">
<tr>
	<td>
		<cfselect name="partnerid" query="qpartners" value="userid" display="orgname" <!--- group="modality" --->></cfselect>
	</td>
	<td>
		<cfselect name="extensiontype" query="qexttype" value="extid" display="descr" queryposition="below" onchange="evaluatemenu();">
		
		</cfselect>
	</td>
	<td>
		<div id="year1">
			<cfselect name="extensionfy" query="qextfy" value="extid" display="descr" queryposition="below">
				<option value="0">-Please Select a Fiscal Year-</option>
			</cfselect>
		</div>
	
	</td>

</tr>
<tr>
<td colspan="3"><input type="submit" name="AddUser" value="Add Extension" class="AddButton"></td>
</tr>
</cfform>
<cfform name="collaborations2" action="extension_manager2.cfm?#session.urltoken#&add=modality">
<tr>
	<td>
		<cfselect name = "modality" query="qmodalities" value="modnum" display="modality"></cfselect>
			
	</td>
	<td>
		<cfselect name="extensiontype2" query="qexttype" value="extid" display="descr" queryposition="below" onchange="evaluatemenu();">
		</cfselect>
	</td>
	<td>
		<div id="year2"> 
			<cfselect name="extensionfy2" query="qextfy" value="extid" display="descr" queryposition="below">
				<option value="0">-Please Select a Fiscal Year-</option>
			</cfselect>
		</div>
	</td>

</tr>
<tr>
<td colspan="3"><input type="submit" name="AddUser" value="Add Extension" class="AddButton"></td>
</tr>

<tr>
	<td colspan="3">
	<table>
	
	</table>	
	</td>
</tr>
</cfform>
<cfif qgetextensions.recordcount NEQ 0>
<cfform name="collaborations3" action="extension_manager2.cfm?#session.urltoken#&add=del">
<tr><strong>
	<td><strong>Partner</strong></td>
	<td><strong>Extension Type</strong></td>
	<td><strong>Extension FY</strong></td>
	<td><strong>Expiration Date</strong></td>	
	<td><strong>Delete?</strong></td>
	
</tr>
<cfoutput>
<cfloop query="qgetextensions">

<!--- <tr><td colspan="4"><strong >#modality#</strong></td></tr> --->
<!--- <cfoutput> --->
	<tr>
		<td>#orgname#</td>
		<td>#descr#</td>
		<td>#extfy#</td>
		<td>#dateformat(enddate, "m/d/yyyy")#</td>
		<td><input type="checkbox" name="del_ext" value="#seq#"></td>
	</tr>

</cfloop>
</cfoutput>
<tr>
<td colspan="5"><input type="submit" name="AddUser" value="Delete Extension" class="DelButton"></td></tr>
</cfform>

</cfif>

</table>

<script language="javascript">
 evaluatemenu();
</script>

</body>

</html>
