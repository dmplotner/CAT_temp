<cfif ((isdefined("url.usid") and session.userid EQ url.usid ) or (not isDefined("url.usid")))>
	<cfset read=0>
<cfelse>
	<cfset read=1>
</cfif>


<script>
 function setLoc(sect){
    <!---   if (!(isInteger(document.EOYStatus.retailnum.value) && (document.EOYStatus.retailnum.value != '') && isInteger(document.EOYStatus.orgnum.value) && (document.EOYStatus.orgnum.value != '')  && isInteger(document.EOYStatus.agnum1.value) && (document.EOYStatus.agnum1.value != '' ) && isInteger(document.EOYStatus.agnum2.value) && (document.EOYStatus.agnum2.value != '') && isInteger(document.EOYStatus.govtnum.value) && (document.EOYStatus.govtnum.value != ''))){
      alert ('Please make sure all numeric fields have integer values, and not text or blanks.');
      return false;
      }
       document.EOYStatus.sect.value=sect; 
	 <cfif SESSION.areamanage EQ "1" OR SESSION.admin EQ "1" OR SESSION.TCP EQ "1" OR SESSION.CessMan contains "1" or session.areamanage EQ 1 or session.admin eq 1>
	 document.EOYStatus.btn.value='tcp';
	 <cfelse>
	 document.EOYStatus.btn.value='partner';
	 </cfif>
      checkContAmt(); --->
	document.EOYStatus.submit();
      }
	     function setLoc2(sect){
        <!---  document.EOYStatus.sect.value=sect; 
		<cfif SESSION.areamanage EQ "1" OR SESSION.admin EQ "1" OR SESSION.TCP EQ "1" OR SESSION.CessMan contains "1" or session.areamanage EQ 1 or session.admin eq 1>
	 		document.EOYStatus.btn.value='tcp';
		 <cfelse>
	 		document.EOYStatus.btn.value='partner';
	 	</cfif> --->
		 document.EOYStatus.submit();
      }
</script>
</script>


<cfoutput>
<!--- <div align="center"><h3>Partner End-of-Year Report for Fiscal Year #evaluate(session.fy-1)# - #session.fy#</h3></div> --->
<!--- <table  class="Table2" width="90%">
 --->

<table  width="80%" border=".2" align="center" class="box">
	<tr>
	<td colspan="2">
	<div align="center" style="font-weight: bold">SMART outcome 1</div><br>
	<ul >
<cfif session.fy EQ 2008>
<li style="font-family: verdana, helvetica, sans-serif;
	font-size: 11px;
	color: ##003366;
	background-color: ##FFF8DC;">Grantees <strong>funded at $95,000</strong>: SMART outcome 1: By November 30, 2008, Cohort 1 schools (6-7 schools selected for intervention in years 1 and 2 of the contract) will have 1) reviewed and approved a comprehensive tobacco-free policy, 2) an implementation and enforcement plan in place, 3) communication strategies in place, 4) completed a 3-month and 12-month post-implementation on-site observation and 5) completed a 3-month and 12-month post-implementation staff survey.</li>
<li style="font-family: verdana, helvetica, sans-serif;
	font-size: 11px;
	color: ##003366;
	background-color: ##FFF8DC;">Grantees <strong>funded at $125,000</strong>: SMART outcome 1: By November 30, 2008, Cohort 1 schools (12-14 schools selected for intervention in years 1 and 2 of the contract) will have 1) reviewed and approved a comprehensive tobacco-free policy, 2) an implementation and enforcement plan in place, 3) communication strategies in place, 4) completed a 3-month and 12-month post-implementation on-site observation and 5) completed a 3-month and 12-month post-implementation staff survey.</li>
<li style="font-family: verdana, helvetica, sans-serif;
	font-size: 11px;
	color: ##003366;
	background-color: ##FFF8DC;">Grantees <strong>funded at $175,000</strong>: SMART outcome 1: By November 30, 2008, Cohort 1 schools (up to 25 schools selected for intervention in years 1 and 2 of the contract) will have 1) reviewed and approved a comprehensive tobacco-free policy, 2) an implementation and enforcement plan in place, 3) communication strategies in place, 4) completed a 3-month and 12-month post-implementation on-site observation and 5) completed a 3-month and 12-month post-implementation staff survey.</li>



<cfelse>



<li style="font-family: verdana, helvetica, sans-serif;
	font-size: 11px;
	color: ##003366;
	background-color: ##FFF8DC;"><strong>For grantees funded at $95,000</strong>:  By November 30,2007,  6 – 7 schools selected for intervention in years 1 & 2 of the contract will have 1) a commitment from school administration to establish tobacco-free grounds; 2) a team or committee to address the issue; 3) an implementation timeline, 4) completed an on-site observation, and 5) assessed existing tobacco-free policies.</li>
<li style="font-family: verdana, helvetica, sans-serif;
	font-size: 11px;
	color: ##003366;
	background-color: ##FFF8DC;"><strong>For grantees funded at $125,000</strong>: By November 30,2007,  12 – 14 schools selected for intervention in years 1 & 2 of the contract will have 1) a commitment from school administration to establish tobacco-free grounds; 2) a team or committee to address the issue; 3) an implementation timeline, 4) completed an on-site observation, and 5) assessed existing tobacco-free policies.</li>
<li style="font-family: verdana, helvetica, sans-serif;
	font-size: 11px;
	color: ##003366;
	background-color: ##FFF8DC;"><strong>For grantees funded at $175,000</strong>: By November 30,2007,  up to 25 schools selected for intervention in years 1 & 2 of the contract will have 1) a commitment from school administration to establish tobacco-free grounds; 2) a team or committee to address the issue; 3) an implementation timeline, 4) completed an on-site observation, and 5) assessed existing tobacco-free policies.</li>
	
</cfif>
	
	</td>
</tr>
<tr>
	<td>Status of<br>SMART Outcome 1</td>
	<td>
		<input type="radio" name="sm1_status" value="1" <cfif (isdefined("url.usid") and session.userid NEQ url.usid )> disabled </cfif><cfif QRptbasics.sm1_status EQ 1> checked</cfif>>Met<br>
		<input type="radio" name="sm1_status" value="0" <cfif (isdefined("url.usid") and session.userid NEQ url.usid )> disabled </cfif> <cfif QRptbasics.sm1_status EQ 0> checked</cfif>>Unmet
	</td>
</tr>

<tr>
	<td>Progress summary</td>
	<td><textarea name="sm1_progress" rows="5" cols="75" <cfif (isdefined("url.usid") and session.userid NEQ url.usid )> readonly class="readonly"</cfif>>#QRptbasics.sm1_progress#</textarea></td>
</tr>
<tr>
	<td>Barriers</td>
	<td><textarea name="sm1_barrier" rows="5" cols="75" <cfif (isdefined("url.usid") and session.userid NEQ url.usid )> readonly class="readonly"</cfif>>#QRptbasics.sm1_barrier#</textarea></td>
</tr>
<tr>
	<td>Actions to address barriers</td>
	<td><textarea name="sm1_actions" rows="5" cols="75" <cfif (isdefined("url.usid") and session.userid NEQ url.usid )> readonly class="readonly"</cfif>>#QRptbasics.sm1_actions#</textarea></td>
</tr>
<cfif ((isdefined("url.usid") and session.userid EQ url.usid ) or (not isDefined("url.usid")) AND (QRptbasics.recordcount EQ 0 OR QRptbasics.complete NEQ 1))>
<tr>
	<td>&nbsp;</td>
	<td><input type="button" value="Check Spelling" onClick="spell('document.EOYStatus.sm1_progress.value', 'document.EOYStatus.sm1_barrier.value', 'document.EOYStatus.sm1_actions.value')">
	</td>
</tr>
</cfif>


</table>
<cfif ((isdefined("url.usid") and session.userid EQ url.usid ) or (not isDefined("url.usid")) AND (QRptbasics.recordcount EQ 0 OR QRptbasics.complete NEQ 1))>

<div align="left">
	<input type="button" value="Save" class="AddButton" onClick="checkContAmt();">
</div>
</cfif>
<TABLE class="box" WIDTH="70%"><TR><TD>
<U>TCP Feedback</U><br>
Outcome-specific comments: <br>
<cfif read is 0><textarea name="sm1_feedback" cols=130 rows=5 readonly class="readonly">#QRptdetails2.sm1_feedback#</textarea>
<cfelse>
<textarea name="sm1_feedback" cols=130 rows=5>#QRptdetails2.sm1_feedback#</textarea>
</cfif>
</TD></TR></TABLE>
<div align="left">
<cfif read is 0>
	<input type="button" value="Save" class="AddButton" onClick="setLoc('sv1');">
	<cfelse>
	<input type="button" value="Save" class="AddButton" onClick="setLoc2('sv1');">
</cfif>
</div>

<p></p>

<table  width="80%" border=".2" align="center" class="box">

<tr>
	<td colspan="2">
	<cfif session.fy LT 2008>
	<div align="center" style="font-weight: bold">SMART outcome 2</div><br>
	
By November 30, #session.fy#, 25% of the schools in the catchment area, in addition to schools selected for years 1 & 2, will have been contacted to begin the administrative commitment process for years 3 & 4 of the contract.
	
	<cfelse>
	<div align="center" style="font-weight: bold">SMART outcome 2</div><br>
	<ul >
<li style="font-family: verdana, helvetica, sans-serif;
	font-size: 11px;
	color: ##003366;
	background-color: ##FFF8DC;"><strong>For grantees funded at $95,000</strong>: By November 30,2008,  Cohort 2 schools (3-6 schools selected for intervention in year 3 of the contract) will have 1) a commitment from school administration to establish tobacco-free grounds; 2) a team or committee to address the issue; 3) an implementation timeline, 4) completed an on-site observation, and 5) assessed existing tobacco-free policies.</li>
<li style="font-family: verdana, helvetica, sans-serif;
	font-size: 11px;
	color: ##003366;
	background-color: ##FFF8DC;"><strong>For grantees funded at $125,000</strong>: By November 30,2008,  Cohort 2 schools (5-10 schools selected for intervention in year 3) of the contract will have 1) a commitment from school administration to establish tobacco-free grounds; 2) a team or committee to address the issue; 3) an implementation timeline, 4) completed an on-site observation, and 5) assessed existing tobacco-free policies. </li>
<li style="font-family: verdana, helvetica, sans-serif;
	font-size: 11px;
	color: ##003366;
	background-color: ##FFF8DC;"><strong>For grantees funded at $175,000</strong>: By November 30,2008,  Cohort 2 schools (5 to 15 schools selected for intervention in year 3 of the contract) will have 1) a commitment from school administration to establish tobacco-free grounds; 2) a team or committee to address the issue; 3) an implementation timeline, 4) completed an on-site observation, and 5) assessed existing tobacco-free policies.</li>
</ul>
	

	
	</cfif>
	
	</td>
</tr>
<tr>
	<td>Status of<br>SMART Outcome 2</td>
	<td>
		<input type="radio" name="sm2_status" value="1"  <cfif (isdefined("url.usid") and session.userid NEQ url.usid )> disabled </cfif><cfif QRptbasics.sm2_status EQ 1> checked</cfif>>Met<br>
		<input type="radio" name="sm2_status" value="0"  <cfif (isdefined("url.usid") and session.userid NEQ url.usid )> disabled </cfif><cfif QRptbasics.sm2_status EQ 0> checked</cfif>>Unmet
	</td>
</tr>

<tr>
	<td>Progress summary</td>
	<td><textarea name="sm2_progress" rows="5" cols="75"  <cfif (isdefined("url.usid") and session.userid NEQ url.usid )> readonly class="readonly"</cfif>>#QRptbasics.sm2_progress#</textarea></td>
</tr>
<tr>
	<td>Barriers</td>
	<td><textarea name="sm2_barrier" rows="5" cols="75" <cfif (isdefined("url.usid") and session.userid NEQ url.usid )> readonly class="readonly"</cfif>>#QRptbasics.sm2_barrier#</textarea></td>
</tr>
<tr>
	<td>Actions to address barriers</td>
	<td><textarea name="sm2_actions" rows="5" cols="75" <cfif (isdefined("url.usid") and session.userid NEQ url.usid )> readonly class="readonly"</cfif>>#QRptbasics.sm2_actions#</textarea></td>
</tr>
<cfif ((isdefined("url.usid") and session.userid EQ url.usid ) or (not isDefined("url.usid")) AND (QRptbasics.recordcount EQ 0 OR QRptbasics.complete NEQ 1))>
<tr>
	<td>&nbsp;</td>
	<td><input type="button" value="Check Spelling" onClick="spell('document.EOYStatus.sm2_progress.value', 'document.EOYStatus.sm2_barrier.value', 'document.EOYStatus.sm2_actions.value')">
	</td>
</tr>
</cfif>
</table>




<cfif ((isdefined("url.usid") and session.userid EQ url.usid ) or (not isDefined("url.usid")) AND (QRptbasics.recordcount EQ 0 OR QRptbasics.complete NEQ 1))>

<div align="left">
	<input type="button" value="Save" class="AddButton" onClick="checkContAmt();">
</div>
</cfif>
<TABLE class="box" WIDTH="70%"><TR><TD>
<U>TCP Feedback</U><br>
Outcome-specific comments:<br>
<cfif read is 0><textarea name="sm2_feedback" cols=130 rows=5 readonly class="readonly">#QRptdetails2.sm2_feedback#</textarea>
<cfelse>
<textarea name="sm2_feedback" cols=130 rows=5>#QRptdetails2.sm2_feedback#</textarea>
</cfif>
</TD></TR></TABLE>
<div align="left">
<cfif read is 0>
	<input type="button" value="Save" class="AddButton" onClick="setLoc('sv2');">
	<cfelse>
	<input type="button" value="Save" class="AddButton" onClick="setLoc2('sv2');">
</cfif>
</div>

<p></p>

<table  width="80%" border=".2" align="center" class="box">

<tr>
	<td colspan="2">
	<div align="center" style="font-weight: bold">SMART outcome 3</div><br>
SMART Outcome 3: By November 20, 2008, 25% of the schools in the catchment area, in addition to Cohort 2 schools (those selected for year 3), will have been contacted to begin the administrative commitment process for year 4 of the contract.
	</td>
</tr>
<tr>
	<td>Status of<br>SMART Outcome 3</td>
	<td>
		<input type="radio" name="sm3_status" value="1"  <cfif (isdefined("url.usid") and session.userid NEQ url.usid )> disabled </cfif><cfif QRptbasics.sm3_status EQ 1> checked</cfif>>Met<br>
		<input type="radio" name="sm3_status" value="0"  <cfif (isdefined("url.usid") and session.userid NEQ url.usid )> disabled </cfif><cfif QRptbasics.sm3_status EQ 0> checked</cfif>>Unmet
	</td>
</tr>

<tr>
	<td>Progress summary</td>
	<td><textarea name="sm3_progress" rows="5" cols="75" <cfif (isdefined("url.usid") and session.userid NEQ url.usid )> readonly class="readonly"</cfif>>#QRptbasics.sm3_progress#</textarea></td>
</tr>
<tr>
	<td>Barriers</td>
	<td><textarea name="sm3_barrier" rows="5" cols="75" <cfif (isdefined("url.usid") and session.userid NEQ url.usid )> readonly class="readonly"</cfif>>#QRptbasics.sm3_barrier#</textarea></td>
</tr>
<tr>
	<td>Actions to address barriers</td>
	<td><textarea name="sm3_actions" rows="5" cols="75" <cfif (isdefined("url.usid") and session.userid NEQ url.usid )> readonly class="readonly"</cfif>>#QRptbasics.sm3_actions#</textarea></td>
</tr>
<cfif ((isdefined("url.usid") and session.userid EQ url.usid ) or (not isDefined("url.usid")) AND (QRptbasics.recordcount EQ 0 OR QRptbasics.complete NEQ 1))>
<tr>
	<td>&nbsp;</td>
	<td><input type="button" value="Check Spelling" onClick="spell('document.EOYStatus.sm3_progress.value', 'document.EOYStatus.sm3_barrier.value', 'document.EOYStatus.sm3_actions.value')">
	</td>
</tr>
</cfif>


</table>
<cfif ((isdefined("url.usid") and session.userid EQ url.usid ) or (not isDefined("url.usid")) AND (QRptbasics.recordcount EQ 0 OR QRptbasics.complete NEQ 1))>

<div align="left">
	<input type="button" value="Save" class="AddButton" onClick="checkContAmt();">
</div>
</cfif>
<TABLE class="box" WIDTH="70%"><TR><TD>
<U>TCP Feedback</U><br>
Outcome-specific comments: <br>
<cfif read is 0><textarea name="sm3_feedback" cols=130 rows=5 readonly class="readonly">#QRptdetails2.sm3_feedback#</textarea>
<cfelse>
<textarea name="sm3_feedback" cols=130 rows=5>#QRptdetails2.sm3_feedback#</textarea>
</cfif>
</TD></TR></TABLE>
<div align="left">
<cfif read is 0>
	<input type="button" value="Save" class="AddButton" onClick="setLoc('sv3');">
	<cfelse>
	<input type="button" value="Save" class="AddButton" onClick="setLoc2('sv3');">
</cfif>
</div>

<p></p>

<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QinsEOYcb">
insert into sp_eoy_cb
(YEAR2, USERID, SNAME)
select #SESSION.fy#, '<cfif isdefined("usid")>#usid#<cfelse>#session.userid#</cfif>', bedscode 
from v_SP_EOY_grid
where userid = '<cfif isdefined("usid")>#usid#<cfelse>#session.userid#</cfif>'
and year2=#SESSION.fy#
and bedscode not in 
(select sname 
from sp_eoy_cb
where userid = '<cfif isdefined("usid")>#usid#<cfelse>#session.userid#</cfif>'
and year2=#SESSION.fy#) 
<!---and 
 not(
acp1=0 and acp2=0 and acp3=0
and spp1=0 and spp2=0 and spp2=0 and spp4=0
and tarp1=0 and tarp2=0 and tarp3=0 and tarp4=0 and tarp5=0
and taip1=0 and taip2=0 and taip3=0
and qob=0 and qsurv=0
) --->
</cfquery>


<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QdispEOYcb">
select case isNull(co.sfy, 0) when 0 then 1 else 0 end  as stat, 

case isNull(co.sfy, 0) when 0 then 'No FY Data'
when 1904 then 'FY 2005-2006'
else 'FY ' + cast((co.sfy-1) as varchar)+  '-' + cast(co.sfy as varchar)
end as sfy,

case  when v.bedscode like '%0000' then 1 else 0 end as distlvl,


--c.seq as cbseq, 
c.cb_yr, 
--v.year2, 
v.userid, v.bedscode, v.institutionname, nd.district_name,

case sum(acp1) when 0 then 0 else 1 end as acp1,
case sum(acp2) when 0 then 0 else 1 end as acp2,
case sum(acp3) when 0 then 0 else 1 end as acp3,
case sum(spp1) when 0 then 0 else 1 end as spp1,
case sum(spp2) when 0 then 0 else 1 end as spp2,
case sum(spp3) when 0 then 0 else 1 end as spp3,
case sum(spp4) when 0 then 0 else 1 end as spp4,
case sum(tarp1) when 0 then 0 else 1 end as tarp1,
case sum(tarp2) when 0 then 0 else 1 end as tarp2,
case sum(tarp3) when 0 then 0 else 1 end as tarp3,
case sum(tarp4) when 0 then 0 else 1 end as tarp4,
case sum(tarp5) when 0 then 0 else 1 end as tarp5,
case sum(taip1) when 0 then 0 else 1 end as taip1,
case sum(taip2) when 0 then 0 else 1 end as taip2,
case sum(taip3) when 0 then 0 else 1 end as taip3,
case sum(taip5) when 0 then 0 else 1 end as taip5,
case sum(qob)   when 0 then 0 else 1 end as qob,
case sum(qsurv) when 0 then 0 else 1 end as qsurv,
filler

from
collaborators as co, nysed_school as ns, nysed_district as nd, v_SP_EOY_grid  as v
left outer join sp_eoy_cb as c on c.sname=v.bedscode and c.year2=v.year2 and
c.userid=v.userid 
where 
v.bedscode=ns.bedscode
and ns.district = nd.district_id

and (
co.school= v.bedscode or 
(v.bedscode like '%0000' and v.bedscode like co.district + '%' and (co.school like '9%' or co.school is null))
)
--and c.sname=v.bedscode
--and c.year2=v.year2
and v.userid = '<cfif isdefined("usid")>#usid#<cfelse>#session.userid#</cfif>'
and v.year2 <=#SESSION.fy#

and co.del is null
and v.userid=co.userid

<!--- and not(
acp1=0 and acp2=0 and acp3=0
and spp1=0 and spp2=0 and spp2=0 and spp4=0
and tarp1=0 and tarp2=0 and tarp3=0 and tarp4=0 and tarp5=0
and taip1=0 and taip2=0 and taip3=0
and qob=0 and qsurv=0
) --->
and 
(isNull(co.sfy, 0) !=0 
OR 
(isNull(co.sfy, 0)=0 
and co.school not in (select school from collaborators c3 where co.school=c3.school and co.district=c3.district and isNull(c3.sfy, 0) !=0)
and co.district not in (select district from collaborators c4 where co.school=c4.school and co.district=c4.district and isNull(c4.sfy, 0) !=0)
)
)
group by 
co.sfy, --c.seq , 
c.cb_yr, --v.year2, 
v.userid, v.bedscode, v.institutionname, v.filler, nd.district_name
having max(isNull(co.sfy, 1901))>1900
--order by 1 asc, 11, 3 desc, 10
order by --1 asc, 
8, 3 desc, 7
</cfquery>





<table width="80%" border=".2" align="center" class="box">
<tr>
	<td colspan= "<cfif session.fy LT 2008>19<cfelse>21</cfif>">
		<div align="center" style="font-weight: bold">Progress with target schools and districts<br><br></div>

	<ul >
	<li style="font-family: verdana, helvetica, sans-serif;
	font-size: 11px;
	color: ##003366;
	background-color: ##FFF8DC;">
	The grid below displays progress milestones per school or district, based on Monthly Strategy Report entries.  The last two columns reflect quarterly data.
	</li>
	<li style="font-family: verdana, helvetica, sans-serif;
	font-size: 11px;
	color: ##003366;
	background-color: ##FFF8DC;">
	If progress milestones are missing from the grid below, please ensure that you entered that information on the correct monthly report. If you need to update your data in CAT, you will need to request an extension for the appropriate fiscal year.
	</li>
	<cfif session.fy LT 2008>
	<li style="font-family: verdana, helvetica, sans-serif;
	font-size: 11px;
	color: ##003366;
	background-color: ##FFF8DC;">
	Please click in the left-most column to indicate your year 1 & 2 schools.  
	</li>
	
	<li style="font-family: verdana, helvetica, sans-serif;
	font-size: 11px;
	color: ##003366;
	background-color: ##FFF8DC;">
	If the progress checkmarks are not correct, please edit your Monthly Strategy Reports and this screen will reflect those updates
	</li>
	</cfif>
	</ul></td>
</tr>
<tr valign="bottom">
	<cfif session.fy LT 2008>
	<th>Check here<br>for Yr 1 &amp; 2<br>schools</th>
	<cfelse>
	<th>Fiscal Year<Br>started working<br>with school</th>
	</cfif>
	<th>District / School</th>
	<!--- <th <!--- bgcolor="##CCCCCC" --->><img src="images/vert1.gif"></th>
	<th><img src="images/vert2.gif"></th>
	<th <!--- bgcolor="##CCCCCC" --->><img src="images/vert3.gif"></th>
	<th><img src="images/vert4.gif"></th>
	<th <!--- bgcolor="##CCCCCC" --->><img src="images/vert5.gif"></th>
	<th <!--- bgcolor="##CCCCCC" --->><img src="images/vert6.gif"></th>
	<th <!--- bgcolor="##CCCCCC" --->><img src="images/vert7.gif"></th>
	<th><img src="images/vert8.gif"></th>
	<th <!--- bgcolor="##CCCCCC" --->><img src="images/vert9.gif"></th>
	<th <!--- bgcolor="##CCCCCC" --->><img src="images/vert10.gif"></th>
	<th <!--- bgcolor="##CCCCCC" --->><img src="images/vert11.gif"></th>
	<th <!--- bgcolor="##CCCCCC" --->><img src="images/vert12.gif"></th>
	<th <!--- bgcolor="##CCCCCC" --->><img src="images/vert13.gif"></th>
	<th><img src="images/vert14.gif"></th>
	<th <!--- bgcolor="##CCCCCC" --->>
		<cfif session.fy LT 2008>
			<img src="images/vert15.gif">
		<cfelse>
			<img src="images/vert15c.gif">
		</cfif>
	</th>
	<th><img src="images/vert16.gif"></th>
	<th <!--- bgcolor="##CCCCCC" --->><img src="images/vert17.gif"></th> --->
	
	<th <!--- bgcolor="##CCCCCC" --->><img src="images/img1.gif"></th>
	<th><img src="images/img2.gif"></th>
	<th <!--- bgcolor="##CCCCCC" --->><img src="images/img3.gif"></th>
	<th><img src="images/img4.gif"></th>
	<th <!--- bgcolor="##CCCCCC" --->><img src="images/img5.gif"></th>
	<th <!--- bgcolor="##CCCCCC" --->><img src="images/img6.gif"></th>
	<th <!--- bgcolor="##CCCCCC" --->><img src="images/img7.gif"></th>
	<th><img src="images/img8.gif"></th>
	<th <!--- bgcolor="##CCCCCC" --->><img src="images/img9.gif"></th>
	<th <!--- bgcolor="##CCCCCC" --->><img src="images/img10.gif"></th>
	<th <!--- bgcolor="##CCCCCC" --->><img src="images/img11.gif"></th>
	<th <!--- bgcolor="##CCCCCC" --->><img src="images/img12.gif"></th>
	<th <!--- bgcolor="##CCCCCC" --->><img src="images/img13.gif"></th>
	<th><img src="images/img14.gif"></th>
	<th <!--- bgcolor="##CCCCCC" --->>
		<cfif session.fy LT 2008>
			<img src="images/vert15.gif">
		<cfelse>
			<img src="images/img15.gif">
		</cfif>
	</th>
	<th><img src="images/img16.gif"></th>
	<th <!--- bgcolor="##CCCCCC" --->><img src="images/img17.gif"></th>
	<cfif session.fy GTE 2008>
	<th><img src="images/img18.gif"></th>
	<th><img src="images/img19.gif"></th>
	
	
	</cfif>
	
	
</tr>
<cfset cntHead=0>

<cfset cnt1=0>
<cfset cnt2=0>
<cfset cnt3=0>
<cfset cnt4=0>
<cfset cnt5=0>
<cfset cnt6=0>
<cfset cnt7=0>

<cfif isDefined("usid")>
	<input type="hidden" name="usid" value="#usid#">
</cfif>

<cfset cnt8=0>
<cfset cnt9=0>
<cfset cnt10=0>
<cfset cnt11=0>
<cfset cnt12=0>
<cfset cnt13=0>
<cfset cnt14=0>
<cfset cnt15=0>
<cfset cnt16=0>
<cfset cnt17=0>

<cfset cnt18=0>
<cfset cnt19=0>

<cfloop query="QdispEOYcb">
	<cfset temp18 = tarp5 + taip2 + qob + qsurv>
	<cfset temp19 = acp2 + spp1 + tarp1 + taip2 + qob>
<!--- <tr>
	<td align="center"><input type="checkbox" name="yr1_2" value="#cbseq#" onClick="countcb();" <cfif listfind(QRptbasics.cbseq, #cbseq#)> checked</cfif> ></td>
	<td><cfif right(bedscode,4) EQ "0000"><strong>#institutionName#</strong><cfelse>#institutionName#</cfif></td>
	<td  bgcolor="##CCCCCC"><input type="checkbox" name="inactiv"  <cfif acp1 EQ 1> checked onclick='this.checked = true;'<cfelse> onclick='this.checked = false;'</cfif>></td>
	<td><input type="checkbox" name="inactiv"  <cfif acp2 EQ 1> checked onclick='this.checked = true;'<cfelse> onclick='this.checked = false;'</cfif>></td>
	<td bgcolor="##CCCCCC"><input type="checkbox" name="inactiv"  <cfif acp3 EQ 1> checked onclick='this.checked = true;'<cfelse> onclick='this.checked = false;'</cfif>></td>
	<td><input type="checkbox" name="inactiv"  <cfif spp1 EQ 1> checked onclick='this.checked = true;'<cfelse> onclick='this.checked = false;'</cfif>></td>
	<td bgcolor="##CCCCCC"><input type="checkbox" name="inactiv"  <cfif spp2 EQ 1> checked onclick='this.checked = true;'<cfelse> onclick='this.checked = false;'</cfif>></td>
	<td bgcolor="##CCCCCC"><input type="checkbox" name="inactiv"  <cfif spp3 EQ 1> checked onclick='this.checked = true;'<cfelse> onclick='this.checked = false;'</cfif>></td>
	<td bgcolor="##CCCCCC"><input type="checkbox" name="inactiv"  <cfif spp4 EQ 1> checked onclick='this.checked = true;'<cfelse> onclick='this.checked = false;'</cfif>></td>
	<td><input type="checkbox" name="inactiv"  <cfif tarp1 EQ 1> checked onclick='this.checked = true;'<cfelse> onclick='this.checked = false;'</cfif>></td>
	<td bgcolor="##CCCCCC"><input type="checkbox" name="inactiv"  <cfif tarp2 EQ 1> checked onclick='this.checked = true;'<cfelse> onclick='this.checked = false;'</cfif>></td>
	<td bgcolor="##CCCCCC"><input type="checkbox" name="inactiv"  <cfif tarp3 EQ 1> checked onclick='this.checked = true;'<cfelse> onclick='this.checked = false;'</cfif>></td>
	<td bgcolor="##CCCCCC"><input type="checkbox" name="inactiv"  <cfif tarp4 EQ 1> checked onclick='this.checked = true;'<cfelse> onclick='this.checked = false;'</cfif>></td>
	<td bgcolor="##CCCCCC"><input type="checkbox" name="inactiv"  <cfif tarp5 EQ 1> checked onclick='this.checked = true;'<cfelse> onclick='this.checked = false;'</cfif>></td>
	<td bgcolor="##CCCCCC"><input type="checkbox" name="inactiv"  <cfif taip1 EQ 1> checked onclick='this.checked = true;'<cfelse> onclick='this.checked = false;'</cfif>></td>
	<td><input type="checkbox" name="inactiv"  <cfif taip2 EQ 1> checked onclick='this.checked = true;'<cfelse> onclick='this.checked = false;'</cfif>></td>
	<td bgcolor="##CCCCCC"><input type="checkbox" name="inactiv"  <cfif taip3 EQ 1> checked onclick='this.checked = true;'<cfelse> onclick='this.checked = false;'</cfif>></td>
	<td><input type="checkbox" name="inactiv"  <cfif qob EQ 1> checked onclick='this.checked = true;'<cfelse> onclick='this.checked = false;'</cfif>></td>
	<td bgcolor="##CCCCCC"><input type="checkbox" name="inactiv"  <cfif qsurv EQ 1> checked onclick='this.checked = true;'<cfelse> onclick='this.checked = false;'</cfif>></td>
</tr> --->
 <cfif cntHead NEQ 0 and (cntHead MOD 30) EQ 0>
<tr valign="bottom">
	<cfif session.fy LT 2008>
	<th>Check here<br>for Yr 1 &amp; 2<br>schools</th>
	<cfelse>
	<th>Fiscal Year<Br>started working<br>with school</th>
	</cfif>
	<th>District / School</th>
	<th <!--- bgcolor="##CCCCCC" --->><img src="images/img1.gif"></th>
	<th><img src="images/img2.gif"></th>
	<th <!--- bgcolor="##CCCCCC" --->><img src="images/img3.gif"></th>
	<th><img src="images/img4.gif"></th>
	<th <!--- bgcolor="##CCCCCC" --->><img src="images/img5.gif"></th>
	<th <!--- bgcolor="##CCCCCC" --->><img src="images/img6.gif"></th>
	<th <!--- bgcolor="##CCCCCC" --->><img src="images/img7.gif"></th>
	<th><img src="images/img8.gif"></th>
	<th <!--- bgcolor="##CCCCCC" --->><img src="images/img9.gif"></th>
	<th <!--- bgcolor="##CCCCCC" --->><img src="images/img10.gif"></th>
	<th <!--- bgcolor="##CCCCCC" --->><img src="images/img11.gif"></th>
	<th <!--- bgcolor="##CCCCCC" --->><img src="images/img12.gif"></th>
	<th <!--- bgcolor="##CCCCCC" --->><img src="images/img13.gif"></th>
	<th><img src="images/img14.gif"></th>
	<th <!--- bgcolor="##CCCCCC" --->>
		<cfif session.fy LT 2008>
			<img src="images/vert15.gif">
		<cfelse>
			<img src="images/img15.gif">
		</cfif>
	</th>
	<th><img src="images/img16.gif"></th>
	<th <!--- bgcolor="##CCCCCC" --->><img src="images/img17.gif"></th>
	<cfif session.fy GTE 2008>
	<th><img src="images/img18.gif"></th>
	<th><img src="images/img19.gif"></th>
	</cfif>
</tr>
</cfif> 

<tr>
	<cfif session.fy LT 2008>
	<td align="center"><input type="checkbox" name="yr1_2" value="#cbseq#" onClick="countcb();" <cfif listfind(QRptbasics.cbseq, #cbseq#)> checked</cfif> ></td>
	<cfelse>
	<td align="center">#QdispEOYcb.sfy#</td>
	</cfif>
	<td><cfif right(bedscode,4) EQ "0000"><strong>#district_name#</strong><cfelse>#district_name#: #institutionName#</cfif></td>
	<td align="center"  <!--- bgcolor="##CCCCCC" --->><cfif acp1 EQ 1>&radic;<cfelse>&nbsp;</cfif></td>
	<td align="center"><cfif acp2 EQ 1>&radic;<cfelse>&nbsp;</cfif></td>
	<td align="center" <!--- bgcolor="##CCCCCC" --->><cfif acp3 EQ 1>&radic;<cfelse>&nbsp;</cfif></td>
	<td align="center"><cfif spp1 EQ 1>&radic;<cfelse>&nbsp;</cfif></td>
	<td align="center" <!--- bgcolor="##CCCCCC" --->><cfif spp2 EQ 1>&radic;<cfelse>&nbsp;</cfif></td>
	<td align="center" <!--- bgcolor="##CCCCCC" --->><cfif spp3 EQ 1>&radic;<cfelse>&nbsp;</cfif></td>
	<td align="center" <!--- bgcolor="##CCCCCC" --->><cfif spp4 EQ 1>&radic;<cfelse>&nbsp;</cfif></td>
	<td align="center"><cfif tarp1 EQ 1>&radic;<cfelse>&nbsp;</cfif></td>
	<td align="center" <!--- bgcolor="##CCCCCC" --->><cfif tarp2 EQ 1>&radic;<cfelse>&nbsp;</cfif></td>
	<td align="center" <!--- bgcolor="##CCCCCC" --->><cfif tarp3 EQ 1>&radic;<cfelse>&nbsp;</cfif></td>
	<td align="center" <!--- bgcolor="##CCCCCC" --->><cfif tarp4 EQ 1>&radic;<cfelse>&nbsp;</cfif></td>
	<td align="center" <!--- bgcolor="##CCCCCC" --->><cfif tarp5 EQ 1>&radic;<cfelse>&nbsp;</cfif></td>
	<td align="center" <!--- bgcolor="##CCCCCC" --->><cfif taip1 EQ 1>&radic;<cfelse>&nbsp;</cfif></td>
	<td align="center"><cfif taip2 EQ 1>&radic;<cfelse>&nbsp;</cfif></td>
	<td align="center" <!--- bgcolor="##CCCCCC" --->><cfif taip5 EQ 1>&radic;<cfelse>&nbsp;</cfif></td>
	<td align="center"><cfif qob EQ 1>&radic;<cfelse>&nbsp;</cfif></td>
	<td align="center" <!--- bgcolor="##CCCCCC" --->><cfif qsurv EQ 1>&radic;<cfelse>&nbsp;</cfif></td>
	
	<cfif session.fy GTE 2008>
	<td>#temp18#</td>
	<td>#temp19#</td>
	</cfif>
</tr>

<cfif acp1 EQ 1> <cfset cnt1=cnt1 + 1> </cfif>
<cfif acp2 EQ 1> <cfset cnt2=cnt2 + 1> </cfif>
<cfif acp3 EQ 1> <cfset cnt3=cnt3 + 1> </cfif>
<cfif spp1 EQ 1> <cfset cnt4=cnt4 + 1> </cfif>
<cfif spp2 EQ 1> <cfset cnt5=cnt5 + 1> </cfif>
<cfif spp3 EQ 1> <cfset cnt6=cnt6 + 1> </cfif>
<cfif spp4 EQ 1> <cfset cnt7=cnt7 + 1> </cfif>
<cfif tarp1 EQ 1> <cfset cnt8=cnt8 + 1> </cfif>
<cfif tarp2 EQ 1> <cfset cnt9=cnt9 + 1> </cfif>
<cfif tarp3 EQ 1> <cfset cnt10=cnt10 + 1> </cfif>
<cfif tarp4 EQ 1> <cfset cnt11=cnt11 + 1> </cfif>
<cfif tarp5 EQ 1> <cfset cnt12=cnt12 + 1> </cfif>
<cfif taip1 EQ 1> <cfset cnt13=cnt13 + 1> </cfif>
<cfif taip2 EQ 1> <cfset cnt14=cnt14 + 1> </cfif>
<!--- <cfif taip3 EQ 1> <cfset cnt15=cnt15 + 1> </cfif> --->
<cfif taip5 EQ 1> <cfset cnt15=cnt15 + 1> </cfif>
<cfif qob EQ 1> <cfset cnt16=cnt16 + 1> </cfif>
<cfif qsurv EQ 1> <cfset cnt17=cnt17 + 1> </cfif>


<cfif temp18 GTE 1> <cfset cnt18=cnt18 + 1> </cfif>
<cfif temp19 GTE 1> <cfset cnt19=cnt19 + 1> </cfif> 
<cfset cntHead = cntHead +1>
</cfloop>



<tr>
	<cfif session.fy LT 2008>
		<td>Total:<input style="background-color:##CCCCCC; text-align:center; color:##0000CC" type="text" size="4" name="cntcb" disabled></td>
	<cfelse>
		<td>&nbsp;</td>
	</cfif>
	<td align="center">#QdispEOYcb.recordcount#</td>
	<td align="center" <!--- bgcolor="##CCCCCC" --->>#cnt1#</td>
	<td align="center">#cnt2#</td>
	<td align="center" <!--- bgcolor="##CCCCCC" --->>#cnt3#</td>
	<td align="center">#cnt4#</td>
	<td align="center" <!--- bgcolor="##CCCCCC" --->>#cnt5#</td>
	<td align="center" <!--- bgcolor="##CCCCCC" --->>#cnt6#</td>
	<td align="center" <!--- bgcolor="##CCCCCC" --->>#cnt7#</td>
	<td align="center">#cnt8#</td>
	<td align="center" <!--- bgcolor="##CCCCCC" --->>#cnt9#</td>
	<td align="center" <!--- bgcolor="##CCCCCC" --->>#cnt10#</td>
	<td align="center" <!--- bgcolor="##CCCCCC" --->>#cnt11#</td>
	<td align="center" <!--- bgcolor="##CCCCCC" --->>#cnt12#</td>
	<td align="center" <!--- bgcolor="##CCCCCC" --->>#cnt13#</td>
	<td align="center">#cnt14#</td>
	<td align="center" <!--- bgcolor="##CCCCCC" --->>#cnt15#</td>
	<td align="center">#cnt16#</td>
	<td align="center" <!--- bgcolor="##CCCCCC" --->>#cnt17#</td>
	<cfif session.fy GTE 2008>
	<td><!--- #cnt18# --->-</td>
	<td><!--- #cnt19# --->-</td>
	</cfif>
</tr>

</table>



<p></p>

<cfif ((isdefined("url.usid") and session.userid EQ url.usid ) or (not isDefined("url.usid")) AND (QRptbasics.recordcount EQ 0 OR QRptbasics.complete NEQ 1))>

<table>
<tr><td>
	<!--- <div align="left"> --->
	<input type="button" value="Save" class="AddButton" onClick="checkContAmt();">
<!--- </div> --->
</td></tr>

</table>

<cfelse>
<script language="javascript">
	<!--- disableme(); --->
	</script>
</cfif>
<br>


</cfoutput>