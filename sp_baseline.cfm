		
	<style>
.box {
	font-family: verdana, helvetica, sans-serif;
	font-size: 11px;
	border: solid 1px #CCCC99;
	list-style:inherit;
	border-collapse: collapse; 
}
.boxy {
	font-family: verdana, helvetica, sans-serif;
	font-size: 11px;
	list-style:inheritborder-color : #498F49;
}
.box2 {
	font-family: verdana, helvetica, sans-serif;
	font-size: 11px;
	border: none;
	list-style:inherit;
	padding: 0px;
	spacing: 0px;
}
</style>

<!--- <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head> --->
<script language="javascript">
            
    function hideSect() {
    		var ele = document.getElementById("restInPeace");
    		ele.style.display = "none";                
            }
            
    function showSect() {
    	var ele = document.getElementById("restInPeace");
    	ele.style.display = "block";            
            }
	
	function checkDsp(){
	if (document.submitCollab.school.selectedIndex!=0  && document.submitCollab.sodistrict.checked!=true){
	hideSect();
	}
	else showSect();
	}
	
</script>
<!--- <title>CAT</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body> --->

		
		<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qcollab_district">
	select distinct district
	from collaborators as c
	where userid='#session.userid#'
	<!--- and year2=#session.fy# --->
	  and (c.del is null or c.del !=1)
	and  school='999'
	order by 1
</cfquery>
<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qcollab_school">
	select distinct school
	from collaborators as c
	where userid='#session.userid#'
	  and (c.del is null or c.del !=1)
	and (sodistrict is null or sodistrict != 1)
	<!--- and year2=#session.fy# --->
	order by 1
</cfquery>
 
 <cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qschool">
	select bedscode,institutionName, district
	from nysed_school
	where <!--- district_code in (#valuelist(Qcollab_district.district)#)	
	and ---> bedscode in (<cfif Qcollab_school.recordcount GT 0> #quotedvaluelist(Qcollab_school.school)#<cfelse>'0'</cfif>)
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
	username="#application.db_username#" name="Qcheckboxes1">
	
	select id, descr,q from lu_schoolCheckBox
where sect=1 and type=0
and seq <> 48 and seq <> 49 and seq <> 50 and seq <> 7 and seq <> 52 and seq <> 53 and seq <> 54
order by rank
	
</cfquery>

<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qcheckboxes2">
	
	select c.id, c.descr, q,c.sect, c.type, h.sect as sectid, h.descr as heading
from lu_schoolCheckBox c, lu_schoolheadings h
where c.sect!=1
and h.sect = c.sect
order by c.sect,rank
	
</cfquery>

<p>
<table>
   <tr>
      <td>

<div id="restInPeace">
		<table class="box2">
      <tr><td colspan="2"><br><br><h3>Baseline District Data</h3>Document status. Any changes should be entered in monthly reports
		</td></tr>
</table>
<p></p>

<cfinclude template="sp_sec1.cfm">
</div>
<!---     moved from sp_sec1.cfm, and suppressed      --->
<!--- <input type="submit" name="add_collaborator" value="Add/Update" class="AddButton" > --->
</td></tr></table>
<p></p>
<p></p>
<!---<cfinclude template="sp_sec2.cfm">--->
<!--- <script language="javascript">
showSect();

</script> --->

</body>
</html>