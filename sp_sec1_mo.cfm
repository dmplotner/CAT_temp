<tr><td><table width=800 border=".1" cellpadding=10 cellspacing="2" class="boxy">
<script type="text/javascript">
<!--
    function toggle_visibility(id) {
       var e = document.getElementById(id);
       if(e.style.display == 'block')
          e.style.display = 'none';
       else
          e.style.display = 'block';
    }
//-->
</script>

 <SCRIPT LANGUAGE="JavaScript">
 function hypo()
 {
 var sname = document.taco.sname1.value
 
 if (sname == '')
 {
 alert('Please select a district');
 return false;}
 }
 function countit(what){
formcontent=what.form.tobpoldev.value
what.form.tobpoldevcount.value=formcontent.length

}
 function countit2(what){
formcontent=what.form.nutpoldev.value
what.form.nutpoldevcount.value=formcontent.length

}

 function countit3(what){
formcontent=what.form.pepoldev.value
what.form.pepoldevcount.value=formcontent.length

}
            
    function hideSect() {
    		var ele = document.getElementById("restInPeace");
    		ele.style.display = "none";                
            }
            
    function showSect() {
    	var ele = document.getElementById("restInPeace");
    	ele.style.display = "block";            
            }
			    function hideSect2() {
    		var ele = document.getElementById("restInPeace2");
    		ele.style.display = "none";                
            }
            
    function showSect2() {
    	var ele = document.getElementById("restInPeace2");
    	ele.style.display = "block";            
            }
			    function hideSect3() {
    		var ele = document.getElementById("restInPeace3");
    		ele.style.display = "none";                
            }
            
    function showSect3() {
    	var ele = document.getElementById("restInPeace3");
    	ele.style.display = "block";            
            }
            
    function shDetails(){
    if (document.taco.Q1_13.checked == true){
    	showSect();
    }
    else hideSect();
    }
	    function shDetails2(){
    if (document.taco.Q1_14.checked == true){
    	showSect2();
    }
    else hideSect2();
    }
	    function shDetails3(){
    if (document.taco.Q1_15.checked == true){
    	showSect3();
    }
    else hideSect3();
    }
	</script>		
	
<cfif session.fy LT 2012><cfparam name="form.CNTRCAGREESFPNMUNI" default=""></cfif>

<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qdistrict_ONLY">
  select distinct 
<!--- c.name, c.indOrg, c.traditional, w.targethcpo as type, c.county, 
  c.seq , c.unit, 
case when c.unit IS NULL then c.NAME else c.unit + ' ' + NAME end as unitname , 
  del, case tHCPO when 0 then 'No' when 1 then 'Yes' else '-' end as tHCPO, 
case tLevel 
	when 1 then 'Potential' 
	when 2 then 'Limited' 
	when 3 then 'Full'
	else '-' end as tLevel, 
	entdt,
	case FQHC when 1 then 'Yes' else 'No' end  as FQHC,
	case ref when 1 then 'Yes' else 'No' end  as ref,cess,pip,
  c.school, c.district , isnull(c.sodistrict,0) as sodistrict, isNull(c.sfy, 0) as sfy, --->
d.district_name, c.district
<!--- s.institutionname --->
  from collaborators as c 
left outer join  wrkplan_targethcpo as w on w.targethcpo_id = c.type and w.year2=c.year2 
left outer join nysed_district as d on d.district_id = c.district
left outer join nysed_school as s on s.bedscode=c.school
  where userid = '#session.userid#' and (c.year2 >=1904)
  <!--- and (c.del is null or c.del != 1)
  and o.num = c.type and o.indorg=c.indorg 
  and  c.year2=o.year2  --->
  and (c.del is null or c.del !=1)
  <cfif session.modality EQ 4>
  and c.district is not null
  <cfelse>
  and c.county is not null 
  </cfif>

union
 select distinct 
<!--- c.name, c.indOrg, c.traditional, w.targethcpo as type, c.county, 
  c.seq , c.unit, 
case when c.unit IS NULL then c.NAME else c.unit + ' ' + NAME end as unitname , 
  del, case tHCPO when 0 then 'No' when 1 then 'Yes' else '-' end as tHCPO, 
case tLevel 
	when 1 then 'Potential' 
	when 2 then 'Limited' 
	when 3 then 'Full'
	else '-' end as tLevel, 
	entdt,
	case FQHC when 1 then 'Yes' else 'No' end  as FQHC,
	case ref when 1 then 'Yes' else 'No' end  as ref,cess,pip,
  c.school, c.district , isnull(c.sodistrict,0) as sodistrict, isNull(c.sfy, 0) as sfy, --->
s.institutionname, s.bedscode
<!--- s.institutionname --->
  from collaborators as c 
left outer join  wrkplan_targethcpo as w on w.targethcpo_id = c.type and w.year2=c.year2 
left outer join nysed_district as d on d.district_id = c.district
left outer join nysed_school as s on s.bedscode=c.school
  where userid = '#session.userid#' and (c.year2 >=1904)
  <!--- and (c.del is null or c.del != 1)
  and o.num = c.type and o.indorg=c.indorg 
  and  c.year2=o.year2  --->
  and (c.del is null or c.del !=1)
  <cfif session.modality EQ 4>
  and c.district is not null
  <cfelse>
  and c.county is not null 
  </cfif>
and isNull(c.sodistrict,0)=1

order by 1 --21

</cfquery>

<cfparam name="form.Q1_1" default="0">
<cfparam name="form.Q1_2" default="0">
<cfparam name="form.Q1_3" default="0">
<cfparam name="form.Q1_4" default="0">
<cfparam name="form.Q1_5" default="0">
<cfparam name="form.Q1_6" default="0">
<cfparam name="form.Q1_7" default="0">
<cfparam name="form.Q1_8" default="0">
<cfparam name="form.Q1_9" default="0">
<cfparam name="form.Q1_10" default="0">
<cfparam name="form.Q1_11" default="0">
<cfparam name="form.Q1_12" default="0">
<cfparam name="form.Q1_13" default="0">
<cfparam name="form.Q1_14" default="0">
<cfparam name="form.Q1_15" default="0">
<cfparam name="form.Q2_9" default="0">
<cfparam name="form.Q2_10" default="0">
<cfparam name="form.Q2_11" default="0">
<cfparam name="form.Q2_12" default="0">
<cfparam name="form.Q2_13" default="0">
<cfparam name="form.Q2_14" default="0">
<cfparam name="form.Q2_15" default="0">
<cfparam name="form.Q2_16" default="0">
<cfparam name="form.Q2_17" default="0">
<cfparam name="form.Q2_18" default="0">
<cfparam name="form.Q2_19" default="0">
<cfparam name="form.Q3_20" default="0">
<cfparam name="form.Q3_21" default="0">
<cfparam name="form.Q3_22" default="0">
<cfparam name="form.Q3_23" default="0">
<cfparam name="form.Q3_24" default="0">
<cfparam name="form.Q4_25" default="0">
<cfparam name="form.Q4_26" default="0">
<cfparam name="form.Q4_27" default="0">
<cfparam name="form.Q4_28" default="0">
<cfparam name="form.Q4_29" default="0">
<cfparam name="form.Q4_30" default="0">
<cfparam name="form.Q4_31" default="0">
<cfparam name="form.Q4_32" default="0">
<cfparam name="form.Q4_33" default="0">
<cfparam name="form.Q4_34" default="0">
<cfparam name="form.Q4_35" default="0">
<cfparam name="form.Q5_36" default="0">
<cfparam name="form.Q5_37" default="0">
<cfparam name="form.Q5_38" default="0">
<cfparam name="form.Q6_39" default="0">
<cfparam name="form.Q6_40" default="0">
<cfparam name="form.Q6_41" default="0">
<cfparam name="form.Q7_42" default="0">
<cfparam name="form.Q7_43" default="0">
<cfparam name="form.Q7_44" default="0">
<cfparam name="form.Q7_45" default="0">
<cfparam name="form.Q7_46" default="0">
<cfparam name="form.Q7_47" default="0">
<cfparam name="show" default="0">

<cfif isdefined("form.dd") and #form.dd# is not ''>
<cfloop index="s" list="#form.del#">
         <CFQUERY NAME="getbline" 
		 DATASOURCE="#application.DataSource#"
         USERNAME="#application.db_username#"
         PASSWORD="#application.db_password#">
	   delete
	   from sp_monthly
	   where district = '#s#' and mo = #session.monum# and year2 = #session.fy#
</CFQUERY>
  <CFQUERY NAME="getbline" 
		 DATASOURCE="#application.DataSource#"
         USERNAME="#application.db_username#"
         PASSWORD="#application.db_password#">
	   delete
	   from sp_mon
	   where bedscode = '#s#' and mon = #session.monum# and year2 = #session.fy#
</CFQUERY>
</cfloop>

</cfif>    


<cfif (isdefined("return") and #return# is not '') or (isdefined("save") and #save# is not '')>
         <CFQUERY NAME="getblink" 
		 DATASOURCE="#application.DataSource#"
         USERNAME="#application.db_username#"
         PASSWORD="#application.db_password#">
	   select *
	   from sp_mon3
	   where userid = '#session.userid#' and mon = #session.monum# and year2 = '#session.fy#'
</CFQUERY>
<cfif getblink.recordcount is 0>
 <CFQUERY NAME="spbas" 
		 DATASOURCE="#application.DataSource#"
         USERNAME="#application.db_username#"
         PASSWORD="#application.db_password#">
	 insert into sp_mon3 (userid,mon,year2,entdt<cfif isdefined("form.tobpoldev")>,tobpoldev</cfif>,nutpoldev,pepoldev<cfif session.fy LT 2012>,CNTRCAGREESFPNMUNI</cfif>)
	 values ('#session.userid#','#session.monum#','#session.fy#',#now()#<cfif isdefined("form.tobpoldev")>,#form.tobpoldev#</cfif>,
	 <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#nutpoldev#">,
	 <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#pepoldev#">
	 <cfif session.fy LT 2012>,<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#CNTRCAGREESFPNMUNI#"></cfif>)
</CFQUERY>
<cfelse>




<CFQUERY NAME="spbas" 
		 DATASOURCE="#application.DataSource#"
         USERNAME="#application.db_username#"
         PASSWORD="#application.db_password#">
	update sp_mon3 set 
	entdt = #now()#,
    <cfif isdefined("form.tobpoldev")>#form.tobpoldev#">,</cfif>
	nutpoldev = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#nutpoldev#">,
	pepoldev = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#pepoldev#">
	<cfif session.fy LT 2012>,
	CNTRCAGREESFPNMUNI = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#CNTRCAGREESFPNMUNI#"></cfif>
	where userid = '#session.userid#' and year2 = '#session.fy#' and mon = #session.monum#
</CFQUERY>
</cfif>
<cfif (isdefined("return") and #return# is not '')>
<cflocation url="monthrepSP.cfm">
</cfif>



</cfif>
<cfif (isdefined("chach") and #chach# is not '')>

<cfif isdefined("form.q")>
<CFQUERY NAME="spbas" 
		 DATASOURCE="#application.DataSource#"
         USERNAME="#application.db_username#"
         PASSWORD="#application.db_password#">
	delete from  sp_monthly
	where district = '#form.sname1#' and year2 = '#session.fy#' and mo = #session.monum#
</CFQUERY>
<cfoutput><cfloop index="x" list="#form.q#">
<cfset frmval='form.' & #x#> 
         <CFQUERY NAME="getbline" 
		 DATASOURCE="#application.DataSource#"
         USERNAME="#application.db_username#"
         PASSWORD="#application.db_password#">
	   select *
	   from sp_monthly
	   where district = '#form.sname1#' and variable = '#x#' and mo = #session.monum#
</CFQUERY>


<cfif #evaluate(frmval)# is 1>
 <CFQUERY NAME="spbas" 
		 DATASOURCE="#application.DataSource#"
         USERNAME="#application.db_username#"
         PASSWORD="#application.db_password#">
	 insert into sp_monthly (userid,district,mo,year2,entdt,variable,value)
	 values ('#session.userid#','#form.sname1#','#session.monum#','#session.fy#',#now()#,'#x#','#evaluate(frmval)#')
</CFQUERY>
<cfelse>
<CFQUERY NAME="spbas" 
		 DATASOURCE="#application.DataSource#"
         USERNAME="#application.db_username#"
         PASSWORD="#application.db_password#">
	update sp_monthly set 
	entdt = #now()#,
	value =  '#evaluate(frmval)#'
	where district = '#form.sname1#' and year2 = '#session.fy#' and variable = '#x#' and mo = #session.monum#
</CFQUERY>

</cfif>
<cfif isdefined("return") and #return# is not ''>
<cflocation url="monthrep.cfm">

</cfif>



</cfloop>
</cfoutput></cfif>
</cfif>
<cfif not isdefined("form.sname1")>
<cfif isdefined("url.id") and #url.id# is not ''>
         <CFQUERY NAME="getblink" 
		 DATASOURCE="#application.DataSource#"
         USERNAME="#application.db_username#"
         PASSWORD="#application.db_password#">
	   select *
	   from sp_monthly
	   where district = '#url.id#' 
</CFQUERY>
<cfset form.sname1 = #getblink.district#>
</cfif></cfif>
<tr rowspan="2"><td><strong>District</strong><p></td><td>
<cfform name="taco" action="" method="post">
<cfif  isDefined("form.sname1") and (not isdefined("save") and (not isdefined("chach")))>
		<cfselect name="sname1" query="Qdistrict_ONLY" value="district" display="district_name" selected="#form.sname1#" queryPosition="below" onchange="form.submit();">
		<option value=""><strong>Please select a District</strong></option>
	</cfselect>
	<cfelse>
		<cfselect name="sname1" query="Qdistrict_ONLY" value="district" display="district_name" queryPosition="below" onchange="form.submit();">
		<option value=""><strong>Please select a District</strong></option>
	</cfselect>
	</cfif><p>
</td>
</tr>

<!---
	<tr><th>Milestones Achieved at Baseline</th><th>Document status. Any changes should be entered in monthly reports</th></tr>
--->

<cfoutput>


<cfloop query="Qcheckboxes1">
<cfif isdefined("form.sname1") and (not isdefined("save")) and (not isdefined("chach")) and (#form.sname1# is not '')>

         <CFQUERY NAME="getbline" 
		 DATASOURCE="#application.DataSource#"
         USERNAME="#application.db_username#"
         PASSWORD="#application.db_password#">
	   select value
	   from sp_monthly sp inner join months m on sp.mo = m.mon_num and sp.year2 = m.year2
	   where district = '#form.sname1#' and variable = '#q#' 
	   and((sp.year2=#session.fy# and sp_rank < #session.rank#) or  (sp.year2 < #session.fy#))
</CFQUERY>	

 <CFQUERY NAME="getbline_init" 
		 DATASOURCE="#application.DataSource#"
         USERNAME="#application.db_username#"
         PASSWORD="#application.db_password#">
	   select value
	   from sp_baseline
	   where district = '#form.sname1#' and variable = '#q#' and userid = '#session.userid#'
	    
</CFQUERY>	
   
         <CFQUERY NAME="getblinenow" 
		 DATASOURCE="#application.DataSource#"
         USERNAME="#application.db_username#"
         PASSWORD="#application.db_password#">
	   select value
	   from sp_monthly
	   where district = '#form.sname1#' and variable = '#q#' and mo = #session.monum# and userid = '#session.userid#'
</CFQUERY>
         <CFQUERY NAME="getlastyr" 
		 DATASOURCE="#application.DataSource#"
         USERNAME="#application.db_username#"
         PASSWORD="#application.db_password#">
	   select value
	   from sp_monthly
	   where district = '#form.sname1#' and variable = '#q#' and year2 < #session.fy# and userid = '#session.userid#'
</CFQUERY>
</cfif>
         <CFQUERY NAME="mon" 
		 DATASOURCE="#application.DataSource#"
         USERNAME="#application.db_username#"
         PASSWORD="#application.db_password#">
	   select *
	   from sp_mon3
	   where userid = '#session.userid#' and mon = #session.monum# and year2 = #session.fy#
	   
	   
</CFQUERY><!--- <body> --->
<input type="hidden" name="q" value="#q#">
<cfif q is 'q1_13' and isdefined("getblinenow.value") and #getblinenow.value# EQ 1>
	<cfset startStat = #getblinenow.value#>
</cfif>
<cfif q is 'q1_14' and isdefined("getblinenow.value") and #getblinenow.value# EQ 1>
	<cfset startStat2 = #getblinenow.value#>
</cfif>
<cfif q is 'q1_15' and isdefined("getblinenow.value") and #getblinenow.value# EQ 1>
	<cfset startStat3 = #getblinenow.value#>
</cfif>
<cfif #q# is not 'q1_13' and #q# is not 'Q1_14' and #q# is not 'Q1_15'>
<tr>
<td align="center"><input type="checkbox" name="#Q#" value="1" <cfif isdefined("getbline.value") and #getbline.value# EQ 1>checked disabled</cfif> <cfif isdefined("getblinenow.value") and #getblinenow.value# EQ 1>checked</cfif> <cfif isdefined("getlastyr.value") and #getlastyr.value# EQ 1 > disabled checked</cfif> <cfif isdefined("getbline_init.value") and #getbline_init.value# EQ 1 > disabled checked</cfif> <cfif #q# is 'q1_13'> onclick="shDetails();"<cfelseif #q# is 'q1_14'> onclick="shDetails2();"<cfelseif #q# is 'q1_15'> onclick="shDetails3();"</cfif>></td>
<td valign="top">#descr#</td>
</tr>
<cfelse>
<tr>
<td align="center">
<input type="checkbox" name="#Q#" value="1" <cfif isdefined("getbline.value") and #getbline.value# EQ 1>checked disabled</cfif> <cfif isdefined("getblinenow.value") and #getblinenow.value# EQ 1>checked</cfif> <cfif isdefined("getbline_init.value") and #getbline_init.value# EQ 1 > disabled checked</cfif> <cfif #q# is 'q1_13'> onclick="shDetails();"<cfelseif #q# is 'q1_14'> onclick="shDetails2();"<cfelseif #q# is 'q1_15'> onclick="shDetails3();"</cfif>></td>
<td valign="top">#descr#<br></td>
</tr>

</cfif>
</cfloop>

<cfif session.fy LT 2012>
<tr>
	<td colspan="3"><b>If a policy was adopted:</b><br>
	<input name="cntrcAgreeSFPnMuni" type = "checkbox" value="1" <cfif form.cntrcAgreeSFPnMuni is 1>checked</cfif>> Check here to indicate that <cfoutput>#session.orgName#</cfoutput> agrees to submit a written copy of the <strong>policy</strong> to Tracey Birmingham (txb06@health.state.ny.us) and copy your Contract Manager
	</td>
</tr>
</cfif>
</cfoutput>

<cfinclude template="sp_sec2_mo.cfm">
<br>
		      <input type="submit" name="chach" value="Add/Update" class="AddButton" onclick="return hypo();">
			  </cfform>         
			  <CFQUERY NAME="getdist" 
		 DATASOURCE="#application.DataSource#"
         USERNAME="#application.db_username#"
         PASSWORD="#application.db_password#">
select distinct district_name,district_id from nysed_district n 
where district_id in (select district from sp_monthly s where userid = '#session.userid#' and year2 = '#session.fy#' and mo = '#session.monum#')
union
select distinct institutionname,bedscode from nysed_school n 
where bedscode in (select district from sp_monthly s where userid = '#session.userid#' and year2 = '#session.fy#' and mo = '#session.monum#')
</cfquery>
<cfif getdist.recordcount is not 0>
<cfform name="skool2" action="" method="post">
<table class="boxy" border=".1" width=800 cellpadding=10>
<th align="left">District</th><th align="left">Delete</th>
<cfoutput query="getdist">
<tr><td><a href="sp_monthly.cfm?id=#district_id#">#getdist.district_name#</a></td>
<td><input name="del" type="Checkbox" value="#district_id#"></td></td></tr></cfoutput>
<tr>
	<td colspan="2" align="right"><input type="Submit" name="dd" value="Delete" class="DelButton"></td>
</tr>
</table>
</cfform></cfif>
			  <cfform name="skool" action="" method="post">
<cfoutput>
<cfif isdefined("form.sname1")>
<input type="hidden" name="sname1" value="#form.sname1#">
</cfif>
<table width=800 border=".1" cellpadding=10 cellspacing="2" class="boxy">
	<!---	<th align="left" height=30 valign="bottom"><h6>Tobacco Policy Development Activities:</th>
	  </tr>

	  <tr>
	  	<td width=805>
<textarea name="tobpoldev" cols=145 rows=14 onBlur="countit(this)"><cfif isdefined("mon.tobpoldev")>#mon.tobpoldev#</cfif>
</textarea>
</td></tr>
	  <tr><td height=30><input type="button" value="Check Spelling" onClick="spell('document.skool.tobpoldev.value', 'document.skool.tobpoldev.value')"></td></tr>
	      <tr>
      <td width="100%" valign="bottom"><div align="right" valign="bottom">This text field has a max of 1950 characters. Characters entered: <cfoutput><input type="text" value="#len(mon.tobpoldev)#" name="tobpoldevcount" size="4" style="border:0;" disabled></cfoutput></td>
    </tr>
--->
		<th align="left" height=30 valign="bottom"><h6>Nutrition Policy Development Activities:</th>

	  <tr>
	  	<td width=700><textarea name="nutpoldev" cols=145 rows=14 onBlur="countit2(this)"><cfif isdefined("mon.nutpoldev")>#mon.nutpoldev#</cfif></textarea>
</td></tr>
	  <tr><td height=30><input type="button" value="Check Spelling" onClick="spell('document.skool.nutpoldev.value', 'document.skool.nutpoldev.value')"></td></tr>
	      <tr>
      <td width="100%" valign="bottom"><div align="right" valign="bottom">This text field has a max of 1950 characters. Characters entered: <cfoutput><input type="text" value="#len(mon.nutpoldev)#" name="nutpoldevcount" size="4" style="border:0;" disabled></cfoutput></td>
    </tr>

		<th align="left" height=30 valign="bottom"><h6>Physical Education Policy Development Activities:</th>
			  <tr>
	  	<td width=700><textarea name="pepoldev" cols=145 rows=14 onBlur="countit3(this)"><cfif isdefined("mon.pepoldev")>#mon.pepoldev#</cfif></textarea>
</td></tr>
	  <tr><td><input type="button" value="Check Spelling" onClick="spell('document.skool.pepoldev.value', 'document.skool.pepoldev.value')">
</td></tr>
	      <tr>
      <td width="100%" valign="bottom"><div align="right" valign="bottom">This text field has a max of 1950 characters. Characters entered: <cfoutput><input type="text" value="#len(mon.pepoldev)#" name="pepoldevcount" size="4" style="border:0;" disabled></cfoutput></td>
    </tr>
		</table>	

<p>
<tr>
		<td colspan="2" align="center">
		      <input type="submit" name="save" value="Save Open Text Entries" class="AddButton">
			  <p></p>
			  <input type="submit" name="return" value="Save and Return to Monthly Reporting" class="AddButton">

         
        </td></tr></cfoutput>
</cfform>
</table>
</td></tr></table>
<script language="javascript">
<cfif isDefined("startStat") and startStat EQ 1>
	showSect();
<cfelse>
	hideSect();
</cfif>
<cfif isDefined("startStat2") and startStat2 EQ 1>
	showSect2();
<cfelse>
	hideSect2();
</cfif>
<cfif isDefined("startStat3") and startStat3 EQ 1>
	showSect3();
<cfelse>
	hideSect3();
</cfif>
</script>

</body>