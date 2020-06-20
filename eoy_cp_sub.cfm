
<script language=javascript type='text/javascript'> 
function hidediv(pass) { 
var divs = document.getElementsByTagName('div'); 
for(i=0;i<divs.length;i++){ 
if(divs[i].id.match(pass)){//if they are 'see' divs 
if (document.getElementById) // DOM3 = IE5, NS6 
divs[i].style.visibility="hidden";// show/hide 
else 
if (document.layers) // Netscape 4 
document.layers[divs[i]].display = 'hidden'; 
else // IE 4 
document.all.hideShow.divs[i].visibility = 'hidden'; 
} 
} 
} 

function showdiv(pass) { 
var divs = document.getElementsByTagName('div'); 
for(i=0;i<divs.length;i++){ 
if(divs[i].id.match(pass)){ 
if (document.getElementById) 
divs[i].style.visibility="visible"; 
else 
if (document.layers) // Netscape 4 
document.layers[divs[i]].display = 'visible'; 
else // IE 4 
document.all.hideShow.divs[i].visibility = 'visible'; 
} 
} 
} 
</script> 

 <script language="javascript">
  function show_other (fieldstat, divname) {

          var textField_div = document.getElementById(divname);

            if (fieldstat.checked==true) {

                  textField_div.style.display=''

 

            } else {

                 textField_div.style.display='none'

            }

      }
 function setSave(){
      document.EOYStatus.compPartner.value=1;
      }
      function setSave2(){
      document.EOYStatus.compTCP.value=1;
      }
 

</script>
<script language="javascript">
function show_other2 (fieldstat, divname) {

          var textField_div = document.getElementById(divname);

          var textField = document.getElementById(fieldstat);

         if (textField.checked==true) {

                  textField_div.style.display=''

 

            } else {

                 textField_div.style.display='none'

            }

      }
      
      function Delfn(delthis){
     document.EOYStatus.deleteOpt.value=delthis; 
      checkContAmt();
      }
      
      function isInteger(nval){
      	return (nval.toString().search(/^-?[0-9]+$/) == 0);
      	
	<!--- 	var new_msg = "true"
		inputStr = nval.toString()
		for (var i = 0; i < inputStr.length; i++)
			{
			var oneChar = inputStr.charAt(i)			
			if ((oneChar < "0" || oneChar > "9") )
					{
						new_msg = "false"
					}
			}

		if (new_msg == "true"){return true;}
		else return false; --->
		
	}
      
      function setLoc(sect){
      if (!(isInteger(document.EOYStatus.retailnum.value) && (document.EOYStatus.retailnum.value != '') && isInteger(document.EOYStatus.orgnum.value) && (document.EOYStatus.orgnum.value != '') && isInteger(document.EOYStatus.govtnum.value) && (document.EOYStatus.govtnum.value != '') && isInteger(document.EOYStatus.qline1.value) && (document.EOYStatus.qline1.value != '') && isInteger(document.EOYStatus.qline2.value) && (document.EOYStatus.qline2.value != '')&& isInteger(document.EOYStatus.qlinenum.value) && (document.EOYStatus.qlinenum.value != ''))){
      alert ('Please make sure all numeric fields have integer values, and not text or blanks.');
      return false;
      }
       document.EOYStatus.sect.value=sect; 
	 <cfif SESSION.areamanage EQ "1" OR SESSION.admin EQ "1" OR SESSION.TCP EQ "1" OR SESSION.CessMan contains "1" or session.areamanage EQ 1 or session.admin eq 1>
	 document.EOYStatus.btn.value='tcp';
	 <cfelse>
	 document.EOYStatus.btn.value='partner';
	 </cfif>
      checkContAmt();
      }
	     function setLoc2(sect){
         document.EOYStatus.sect.value=sect; 
		<cfif SESSION.areamanage EQ "1" OR SESSION.admin EQ "1" OR SESSION.TCP EQ "1" OR SESSION.CessMan contains "1" or session.areamanage EQ 1 or session.admin eq 1>
	 		document.EOYStatus.btn.value='tcp';
		 <cfelse>
	 		document.EOYStatus.btn.value='partner';
	 	</cfif>
		 document.EOYStatus.submit();
      }
</script>
<cfif (not isdefined("session.modality") or #session.modality# is '') and isdefined("modal")>
<cfswitch expression="#modal#">
<cfcase value="cc">
<cfset session.modality = 1>
</cfcase>
<cfcase value="cp">
<cfset session.modality = 2>
</cfcase>
<cfcase value="yp">
<cfset session.modality = 3>
</cfcase>
</cfswitch>
</cfif>
<cfif session.areamanage EQ 1 or session.cessman contains 1 or session.admin is 1>
<cfset read = 1>
<cfelse>
<cfset read = 0>
</cfif>

<!--- <cfform  action="upd_eoybasic.cfm?#session.urltoken#" name="EOYStatus"> --->
	<input type="hidden" name="deleteOpt" value=""> 
	<input type="hidden" name="sect" value=""> 
	<input type="hidden" name="btn" value=""> 
	<input type="hidden" name="compPartner" value="0"> 
	<input type="hidden" name="compTCP" value="0">
	<cfinput type="hidden" name="read" value="#read#">
	<cfif isdefined("usid")>
	<cfoutput><input type="hidden" name="usid" value="#usid#"></cfoutput></cfif>
<cfoutput>
<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="retail">
SELECT    distinct t.target,  cast(u.JPS_orgs as varchar(1000)) as JPS_orgs
FROM         dbo.PRPChange AS m INNER JOIN
                      dbo.user_target_org AS t ON m.userid = t.userid AND m.year2 = t.year2 AND m.stakeholders = t.seq INNER JOIN
                      dbo.months AS mo ON m.month2 = mo.Mon and m.year2 = mo.year2 INNER JOIN
                      dbo.userActivities AS u ON m.userid = u.userid AND m.activity = u.activity AND m.year2 = u.year2 INNER JOIN
                      dbo.objectives AS o ON u.objective = o.ID
WHERE     (u.del IS NULL) AND (u.year2 = '#session.fy#') AND (o.groupName = 'retail') AND (m.channel = 1 or m.channel = 4 or m.channel = 5) 
AND (u.strategy IN (8, 9)) 
AND ((u.userid='SHARED' and m.activity in (#quotedvaluelist(QUsershared.activity)#)) 
OR  <cfif isdefined("usid")>u.userid='#usid#'<cfelse>u.userid='#session.userid#' </cfif>)
order by 1
</cfquery>
<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="gpme">
SELECT     distinct t.target,  cast(u.JPS_orgs as varchar(1000)) as JPS_orgs
FROM         dbo.PRPChange AS m INNER JOIN
                      dbo.user_target_org AS t ON m.userid = t.userid AND m.year2 = t.year2 AND m.stakeholders = t.seq INNER JOIN
                      dbo.months AS mo ON m.month2 = mo.Mon and m.year2 = mo.year2 INNER JOIN
                      dbo.userActivities AS u ON m.userid = u.userid AND m.activity = u.activity AND m.year2 = u.year2 INNER JOIN
                      dbo.objectives AS o ON u.objective = o.ID
where    (u.del IS NULL) AND (u.year2 = '#session.fy#') AND (o.groupName = 'retail') AND (m.channel = 2) AND (u.strategy IN (1)) 
AND ((u.userid='SHARED' and m.activity in (#quotedvaluelist(QUsershared.activity)#)) 
OR  <cfif isdefined("usid")>u.userid='#usid#'<cfelse>u.userid='#session.userid#' </cfif>)

order by 1
</cfquery>


<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="gpme2">

SELECT     distinct t.target,  cast(u.JPS_orgs as varchar(1000)) as JPS_orgs
FROM         dbo.PRPChange AS m INNER JOIN
                      dbo.user_target_org AS t ON m.userid = t.userid AND m.year2 = t.year2 AND m.stakeholders = t.seq INNER JOIN
                      dbo.months AS mo ON m.month2 = mo.Mon and m.year2 = mo.year2 INNER JOIN
                      dbo.userActivities AS u ON m.userid = u.userid AND m.activity = u.activity AND m.year2 = u.year2 INNER JOIN
                      dbo.objectives AS o ON u.objective = o.ID
where    (u.del IS NULL) AND (u.year2 = '#session.fy#') AND (o.groupName = 'retail') 
AND (m.channel = 2) AND (u.strategy IN (8,9,11)) AND u.targetGroup in (5,6) 
AND ((u.userid='SHARED' and m.activity in (#quotedvaluelist(QUsershared.activity)#)) 
OR <cfif isdefined("usid")>u.userid='#usid#'<cfelse>u.userid='#session.userid#' </cfif>)

order by 1
</cfquery>



<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="promo">
SELECT     distinct t.target,  cast(u.JPS_orgs as varchar(1000)) as JPS_orgs
FROM         dbo.PRPChange AS m INNER JOIN
                      dbo.user_target_org AS t ON m.userid = t.userid AND m.year2 = t.year2 AND m.stakeholders = t.seq INNER JOIN
                      dbo.months AS mo ON m.month2 = mo.Mon and m.year2 = mo.year2 INNER JOIN
                      dbo.userActivities AS u ON m.userid = u.userid AND m.activity = u.activity AND m.year2 = u.year2 INNER JOIN
                      dbo.objectives AS o ON u.objective = o.ID
WHERE     (u.del IS NULL) AND (u.year2 = '#session.fy#') AND (o.groupName = 'sponspromo') AND (m.channel in (1,4,5)) AND (u.strategy IN (8,9)) 
AND ((u.userid='SHARED' and m.activity in (#quotedvaluelist(QUsershared.activity)#)) 
OR  <cfif isdefined("usid")>u.userid='#usid#'<cfelse>u.userid='#session.userid#' </cfif>)
order by 1
</cfquery>
<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="smokefree">
SELECT     distinct t.target, cast(u.JPS_orgs as varchar(1000)) as JPS_orgs
FROM         dbo.PRPChange AS m INNER JOIN
                      dbo.user_target_org AS t ON m.userid = t.userid AND m.year2 = t.year2 AND m.stakeholders = t.seq INNER JOIN
                      dbo.months AS mo ON m.month2 = mo.Mon and m.year2 = mo.year2 INNER JOIN
                      dbo.userActivities AS u ON m.userid = u.userid AND m.activity = u.activity AND m.year2 = u.year2 INNER JOIN
                      dbo.objectives AS o ON u.objective = o.ID
WHERE     (u.del IS NULL) AND (u.year2 = '#session.fy#') AND (o.groupName = 'mud') AND (m.channel in (1,4,5)) AND (u.strategy IN (8,9)) 
AND ((u.userid='SHARED' and m.activity in (#quotedvaluelist(QUsershared.activity)#)) 
OR  <cfif isdefined("usid")>u.userid='#usid#'<cfelse>u.userid='#session.userid#' </cfif>)
order by 1
</cfquery>
<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="outdoor">
SELECT     distinct t.target,  cast(u.JPS_orgs as varchar(1000)) as JPS_orgs
FROM         dbo.PRPChange AS m INNER JOIN
                      dbo.user_target_org AS t ON m.userid = t.userid AND m.year2 = t.year2 AND m.stakeholders = t.seq INNER JOIN
                      dbo.months AS mo ON m.month2 = mo.Mon and m.year2 = mo.year2 INNER JOIN
                      dbo.userActivities AS u ON m.userid = u.userid AND m.activity = u.activity AND m.year2 = u.year2 INNER JOIN
                      dbo.objectives AS o ON u.objective = o.ID
WHERE     (u.del IS NULL) AND (u.year2 = '#session.fy#') AND (o.groupName = 'outdoor') AND (m.channel in (1,4,5)) AND (u.strategy IN (1,8,9)) 
AND ((u.userid='SHARED' and m.activity in (#quotedvaluelist(QUsershared.activity)#)) 
OR  <cfif isdefined("usid")>u.userid='#usid#'<cfelse>u.userid='#session.userid#' </cfif>)
order by 1
</cfquery>

<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="smart8">
select 
	sum(case sust_1 when 1 then 1 else 0 end) as sust1, 
sum(case sust_2 when 1 then 1 else 0 end) as sust2,  
sum(case sust_3 when 1 then 1 else 0 end) as sust3, 
sum(case sust_4 when 1 then 1 else 0 end) as sust4
	from infra_monthly
	where 
	<cfif isdefined("usid")>userid='#usid#'<cfelse>userid='#session.userid#' </cfif>	
	and year2= '#session.fy#'
</cfquery>

<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="getdeets">
SELECT     *
FROM         dbo.eoy_details 
where 
(year2 = '#session.fy#') AND <cfif isdefined("usid")>userid='#usid#'<cfelse>userid='#session.userid#' </cfif>
</cfquery>

<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="getcustom">
SELECT     *
FROM         dbo.eoy_custom
where 
(year2 = '#session.fy#') AND <cfif isdefined("usid")>userid='#usid#'<cfelse>userid='#session.userid#' </cfif>
</cfquery>


<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Audit1">
	select dtstmp
	from eoy_audit
	where 
<cfif isdefined("usid")>userid = '#usid#'<cfelse>userid = '#session.userid#'</cfif>
and type='partner'
and year2=#session.fy#
order by 1 desc
</cfquery>

<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Audit2">
	select dtstmp
	from eoy_audit
	where 
<cfif isdefined("usid")>userid = '#usid#'<cfelse>userid = '#session.userid#'</cfif>
and type='TCP'
and year2=#session.fy#

order by 1 desc
</cfquery>

<p></p>
<table  width="70%">
<tr><td>
<div align="center"><h3>Reporting by SMART Outcome</h3></div>
</td></tr>
</table>
<table  width="70%" border=".2" class="box">
<tr>
	<td colspan="2"><a name="sv1"></a>
	
	<cfif session.fy GT 2008><div align="center"><h3>SMART Outcome 1</h3></div></cfif>
<strong><span style="text-decoration : underline;">Retail Policies:</span> By July 31, #session.fy#, <input type="text" name="retailnum" size=4 value="<cfif getdeets.retailnum EQ ''>0<cfelse>#getdeets.retailnum#</cfif>" <cfif read is 1>readonly class="readonly"</cfif>> ## of retailers in your catchment area will have adopted a policy to rearrange, reduce or eliminate tobacco advertising in their retail store. 
</strong>	</td>
</tr>

<tr>
	<td colspan="2">
<tr><td colspan=2><table width="90%" border=".2" align="center" class="box">
<tr><td>
<tr><th colspan=2>Retail advocacy policies with a target of retailers </th></tr>
<tr valign="bottom">
<th width="60%">Target org name</th>
	<th>Joint partners (if applicable)</th>
	</tr>
<cfloop query="retail">
<tr>
	<td>#target#</td>
	<td align="center">#jps_orgs# &nbsp;</td>
	</tr></cfloop>
	<tr>
	<td colspan="2"><h6>Total ## Org Policies: #retail.recordcount#</td>
	</tr>
	</table></td></tr>




<tr>
	<td>Status of outcome</td>
	<td width="85%">Select "Met" if the number of policies adopted (in the table above) is at least as high as the projected number.<br>
		<input type="radio" name="retailstatus" value="1" <cfif getdeets.retailstatus EQ 1> checked</cfif> <cfif read is 1>disabled</cfif>>Met<br>
		<input type="radio" name="retailstatus" value="0" <cfif getdeets.retailstatus EQ 0> checked</cfif> <cfif read is 1>disabled</cfif>>Unmet
	</td>
</tr>

<tr>
	<td>Progress summary</td>
	<td><textarea name="retailprogress" rows="5" cols="110" <cfif read is 1>readonly class="readonly"</cfif>>#getdeets.retailprogress#</textarea></td>
</tr>
<tr>
	<td>Barriers</td>
	<td><textarea name="retailbarriers" rows="5" cols="110" <cfif read is 1>readonly class="readonly"</cfif>>#getdeets.retailbarriers#</textarea></td>
</tr>
<cfif session.fy eq 2008>
<tr>
	<td>Plans to address barriers in the upcoming fiscal year</td>
	<td><textarea name="retailactions" rows="5" cols="110" <cfif read is 1>readonly class="readonly"</cfif>>#getdeets.retailactions#</textarea></td>
</tr>
</cfif>
<cfif read is 0>
<tr>
	<td>&nbsp;</td>
	<td><input type="button" value="Check Spelling" onClick="spell('document.EOYStatus.retailprogress.value', 'document.EOYStatus.retailbarriers.value'<cfif session.fy LT 2009>, 'document.EOYStatus.retailactions.value'</cfif>)">
	</td>
</tr>
</cfif>
</table>

<TABLE class="box" WIDTH="70%"><TR><TD>
<U>TCP Feedback</U><br>
Outcome-specific comments: <br>
<cfif read is 0><textarea name="retailfeedback" cols=130 rows=5 readonly class="readonly">#getdeets.retailfeedback#</textarea>
<cfelse>
<textarea name="retailfeedback" cols=130 rows=5>#getdeets.retailfeedback#</textarea>
</cfif></TD></TR></TABLE>
<div align="left">
<cfif read is 0>
	<input type="button" value="Save" class="AddButton" onClick="setLoc('sv1');">
	<cfelse>
	<input type="button" value="Save" class="AddButton" onClick="setLoc2('sv1');">
</cfif>
</div>

<p></p>
<table  width="70%" border=".2" class="box">
<cfif session.fy GT 2008><tr><td colspan="2"><div align="center"><h3>SMART Outcome 2</h3></div></td></tr></cfif>
<tr>
	<td colspan="2"><a name="sv2"></a>
<strong><span style="text-decoration : underline;">Retail Municipality Resolutions:</span> By July 31, #session.fy# at least one (1) municipality in each county will adopt a resolution opposing tobacco advertising and promotion in the retail environment.	</strong></td>
</tr>

<tr>
	<td colspan="2">
<tr><td colspan=2><table width="90%" border=".2" align="center" class="box">
<tr><th colspan=2>Retail Government Policy Maker Education Resolutions </th></tr>
<tr valign="bottom">
<th width="60%">Target org name</th>
	
	<th>Joint partners (if applicable)</th>
	</tr>
<cfloop query="gpme">
<tr>
	<td>#target#</td>
	
	<td align="center">#jps_orgs# &nbsp;</td>
	</tr>
	</cfloop>
	<tr>
	<td colspan="2"><h6>Total ## Org Resolutions: #gpme.recordcount#</td>
	
	</tr>
	</table></td></tr>




<tr>
	<td>Status of outcome</td>
	<td width="85%">Select "Met" if the table above shows at least one municipality resolution in each county.<br>
		<input type="radio" name="munistatus" value="1" <cfif getdeets.munistatus EQ 1> checked</cfif> <cfif read is 1>disabled</cfif>>Met<br>
		<input type="radio" name="munistatus" value="0" <cfif getdeets.munistatus EQ 0> checked</cfif> <cfif read is 1>disabled</cfif>>Unmet
	</td>
</tr>

<tr>
	<td>Progress summary</td>
	<td><textarea name="muniprogress" rows="5" cols="110" <cfif read is 1>readonly class="readonly"</cfif>>#getdeets.muniprogress#</textarea></td>
</tr>
<tr>
	<td>Barriers</td>
	<td><textarea name="munibarriers" rows="5" cols="110" <cfif read is 1>readonly class="readonly"</cfif>>#getdeets.munibarriers#</textarea></td>
</tr>
<cfif session.fy EQ 2008>
<tr>
	<td>Plans to address barriers in the upcoming fiscal year</td>
	<td><textarea name="muniactions" rows="5" cols="110" <cfif read is 1>readonly class="readonly"</cfif>>#getdeets.muniactions#</textarea></td>
</tr>
</cfif>
<cfif read is 0>
<tr>
	<td>&nbsp;</td>
	<td><input type="button" value="Check Spelling" onClick="spell('document.EOYStatus.muniprogress.value', 'document.EOYStatus.munibarriers.value'<cfif session.fy LT 2009>, 'document.EOYStatus.muniactions.value'</cfif>)">
	</td>
</tr>
</cfif>
</table>

<TABLE class="box" WIDTH="70%"><TR><TD>
<U>TCP Feedback</U><br>
Outcome-specific comments: <br>
<cfif read is 0>
<textarea name="munifeedback" cols=130 rows=5 readonly class="readonly">#getdeets.munifeedback#</textarea>
<cfelse>
<textarea name="munifeedback" cols=130 rows=5>#getdeets.munifeedback#</textarea>
</cfif></TD></TR></TABLE>
<div align="left">
<cfif read is 0>
	<input type="button" value="Save" class="AddButton" onClick="setLoc('sv2');">
	<cfelse>
	<input type="button" value="Save" class="AddButton" onClick="setLoc2('sv2');">
</cfif>
</div>




<cfif session.fy GT 2008>

<p></p>
<table  width="70%" border=".2" class="box">
<cfif session.fy GT 2008><tr><td colspan="2"><div align="center"><h3>SMART Outcome 3</h3></div></td></tr></cfif>
<tr>
	<td colspan="2"><a name="sv2a"></a>
<strong><span style="text-decoration : underline;">Retail Community Organization Resolutions:</span> By July 31, #session.fy# obtain at least one community based organization or institution resolution per county opposing tobacco advertising and promotion in the retail environment and calling on retailers to make voluntary changes.	</strong></td>
</tr>

<tr>
	<td colspan="2">
<tr><td colspan=2><table width="90%" border=".2" align="center" class="box">
<tr><th colspan=2>Retail resolutions by community organizations </th></tr>
<tr valign="bottom">
<th width="60%">Target org name</th>
	
	<th>Joint partners (if applicable)</th>
	</tr>
<cfloop query="gpme2">
<tr>
	<td>#target#</td>
	
	<td align="center">#jps_orgs# &nbsp;</td>
	</tr>
	</cfloop>
	<tr>
	<td colspan="2"><h6>Total ## Org Resolutions: #gpme2.recordcount#</td>
	
	</tr>
	</table></td></tr>




<tr>
	<td>Status of outcome</td>
	<td width="85%">Select "Met" if the table above shows at least one community organization resolution per county.<br>
		<input type="radio" name="munistatus2" value="1" <cfif getdeets.munistatus2 EQ 1> checked</cfif> <cfif read is 1>disabled</cfif>>Met<br>
		<input type="radio" name="munistatus2" value="0" <cfif getdeets.munistatus2 EQ 0> checked</cfif> <cfif read is 1>disabled</cfif>>Unmet
	</td>
</tr>

<tr>
	<td>Progress summary</td>
	<td><textarea name="muniprogress2" rows="5" cols="110" <cfif read is 1>readonly class="readonly"</cfif>>#getdeets.muniprogress2#</textarea></td>
</tr>
<tr>
	<td>Barriers</td>
	<td><textarea name="munibarriers2" rows="5" cols="110" <cfif read is 1>readonly class="readonly"</cfif>>#getdeets.munibarriers2#</textarea></td>
</tr>

<cfif read is 0>
<tr>
	<td>&nbsp;</td>
	<td><input type="button" value="Check Spelling" onClick="spell('document.EOYStatus.muniprogress2.value', 'document.EOYStatus.munibarriers2.value')">
	</td>
</tr>
</cfif>
</table>

<TABLE class="box" WIDTH="70%"><TR><TD>
<U>TCP Feedback</U><br>
Outcome-specific comments: <br>
<cfif read is 0>
<textarea name="munifeedback2" cols=130 rows=5 readonly class="readonly">#getdeets.munifeedback2#</textarea>
<cfelse>
<textarea name="munifeedback2" cols=130 rows=5>#getdeets.munifeedback2#</textarea>
</cfif></TD></TR></TABLE>
<div align="left">
<cfif read is 0>
	<input type="button" value="Save" class="AddButton" onClick="setLoc('sv2a');">
	<cfelse>
	<input type="button" value="Save" class="AddButton" onClick="setLoc2('sv2a');">
</cfif>
</div>
</cfif>

<p></p>
<table  width="70%" border=".2" class="box">
	<cfif session.fy GT 2008><tr><td colspan="2"><div align="center"><h3>SMART Outcome 4</h3></div></td></tr></cfif>
<tr>
	<td colspan="2"><a name="sv3"></a>
<strong><span style="text-decoration : underline;">Signage Enforcement:  </span>
<!--- Select "Met" if the ordinance was identified, the entity responsible for signage was identified and support and technical assistance was provided to signage enforcing entity in each county.
 --->
      By July 31, #session.fy#, at least one (1) local ordinance or law regulating signage, per county, will be regularly enforced.
<!--- By July 31, 2008, at least one (1) existing local ordinance or law regulating signage, per county, will be enforced against a violation involving tobacco advertising. --->
</tr>
</strong></td></tr>




<tr>
	<td>Status of outcome</td>
	<td width="85%">
	Select "Met" if the ordinance was identified, the entity responsible for signage was identified and support and technical assistance was provided to signage enforcing entity in each county<br>
	<!--- Select "Met" if at least one local ordinance or law was enforced per county.<br> --->
		<input type="radio" name="ordistatus" value="1" <cfif getdeets.ordistatus EQ 1> checked</cfif> <cfif read is 1>disabled</cfif>>Met<br>
		<input type="radio" name="ordistatus" value="0" <cfif getdeets.ordistatus EQ 0> checked</cfif> <cfif read is 1>disabled</cfif>>Unmet
	</td>
</tr>

<tr>
	<td>Progress summary</td>
	<td><textarea name="ordiprogress" rows="5" cols="110" <cfif read is 1>readonly class="readonly"</cfif>>#getdeets.ordiprogress#</textarea></td>
</tr>
<tr>
	<td>Barriers</td>
	<td><textarea name="ordibarriers" rows="5" cols="110" <cfif read is 1>readonly class="readonly"</cfif>>#getdeets.ordibarriers#</textarea></td>
</tr>
<cfif session.fy EQ 2008>
<tr>
	<td>Plans to address barriers in the upcoming fiscal year</td>
	<td><textarea name="ordiactions" rows="5" cols="110" <cfif read is 1>readonly class="readonly"</cfif>>#getdeets.ordiactions#</textarea></td>
</tr>
</cfif>
<cfif read is 0>
<tr>
	<td>&nbsp;</td>
	<td><input type="button" value="Check Spelling" onClick="spell('document.EOYStatus.ordiprogress.value', 'document.EOYStatus.ordibarriers.value'<cfif session.fy LT 2009>, 'document.EOYStatus.ordiactions.value'</cfif>)">
	</td>
</tr>
</cfif>
</table>

<TABLE class="box" WIDTH="70%"><TR><TD>
<U>TCP Feedback</U><br>
Outcome-specific comments: <br>
<cfif read is 0><textarea name"ordifeedback" cols=130 rows=5 readonly class="readonly">#getdeets.ordifeedback#</textarea>
<cfelse>
<textarea name="ordifeedback" cols=130 rows=5>#getdeets.ordifeedback#</textarea>
</cfif></TD></TR></TABLE>

<div align="left">
<cfif read is 0>
	<input type="button" value="Save" class="AddButton" onClick="setLoc('sv3');">
	<cfelse>
	<input type="button" value="Save" class="AddButton" onClick="setLoc2('sv3');">
</cfif>
</div>


<p></p>
<table  width="70%" border=".2" class="box">
<cfif session.fy GT 2008><tr><td colspan="2"><div align="center"><h3>SMART Outcome 5</h3></div></td></tr></cfif>
<tr>
	<td colspan="2"><a name="sv4"></a>
	
<strong><span style="text-decoration : underline;">Sponsorship and Promotion Policies:</span> By July 31, #session.fy#, <input type="text" name="orgnum" size=4 value="<cfif getdeets.orgnum EQ ''>0<cfelse>#getdeets.orgnum#</cfif>" <cfif read is 1>readonly class="readonly"</cfif>>  ## of organizations, venues and events in the catchment area will have adopted a written policy prohibiting tobacco company corporate giving, commercial sponsorship, and promotion. </strong></tr>

<tr>
	<td colspan="2">
<tr><td colspan=2><table width="90%" border=".2" align="center" class="box">
<tr><th colspan=2>Sponsorship, promotion, and corporate giving policies </th></tr>
<tr valign="bottom">
<th width=60%>Target org name</th>
	<th>Joint partners (if applicable)</th>
	</tr>
<cfloop query="promo">
<tr>
	<td>#target#</td>
	<td align="center">#jps_orgs# &nbsp;</td>
	</tr></cfloop>

	<tr>
	<td colspan="2"><h6>Total ## Org Policies: #promo.recordcount#</td>
	</tr>
	</table></td></tr>




<tr>
	<td>Status of outcome</td>
	<td colspan="85%">Select "Met" if the number of policies adopted (in the table above) is at least as high as the projected number.<br>
		<input type="radio" name="orgstatus" value="1" <cfif getdeets.orgstatus EQ 1> checked</cfif> <cfif read is 1>disabled</cfif>>Met<br>
		<input type="radio" name="orgstatus" value="0" <cfif getdeets.orgstatus EQ 0> checked</cfif> <cfif read is 1>disabled</cfif>>Unmet
	</td>
</tr>

<tr>
	<td>Progress summary</td>
	<td><textarea name="orgprogress" rows="5" cols="110" <cfif read is 1>readonly class="readonly"</cfif>>#getdeets.orgprogress#</textarea></td>
</tr>
<tr>
	<td>Barriers</td>
	<td><textarea name="orgbarriers" rows="5" cols="110" <cfif read is 1>readonly class="readonly"</cfif>>#getdeets.orgbarriers#</textarea></td>
</tr>
<cfif session.fy EQ 2008>
<tr>
	<td>Plans to address barriers in the upcoming fiscal year</td>
	<td><textarea name="orgactions" rows="5" cols="110" <cfif read is 1>readonly class="readonly"</cfif>>#getdeets.orgactions#</textarea></td>
</tr>
</cfif>
<cfif read is 0>
<tr>
	<td>&nbsp;</td>
	<td><input type="button" value="Check Spelling" onClick="spell('document.EOYStatus.orgprogress.value', 'document.EOYStatus.orgbarriers.value'<cfif session.fy LT 2009>, 'document.EOYStatus.orgactions.value'</cfif>)">
	</td>
</tr>
</cfif>
</table>

<TABLE class="box" WIDTH="70%"><TR><TD>
<U>TCP Feedback</U><br>
Outcome-specific comments: <br>
<cfif read is 0><textarea name="orgfeedback" cols=130 rows=5 readonly class="readonly">#getdeets.orgfeedback#</textarea>
<cfelse>
<textarea name="orgfeedback" cols=130 rows=5>#getdeets.orgfeedback#</textarea>
</cfif></TD></TR></TABLE>
<div align="left">
<cfif read is 0>
	<input type="button" value="Save" class="AddButton" onClick="setLoc('sv4');">
	<cfelse>
	<input type="button" value="Save" class="AddButton" onClick="setLoc2('sv4');">
</cfif>
</div>

<p></p>
<table  width="70%" border=".2" class="box">
<cfif session.fy GT 2008><tr><td colspan="2"><div align="center"><h3>SMART Outcome 6</h3></div></td></tr></cfif>
<tr>
	<td colspan="2"><a name="sv5"></a>
<strong><span style="text-decoration : underline;">Multi-Unit Dwelling Policy:</span> By July 31, #session.fy#, at least 1 multi-unit dwelling in the catchment area will have adopted a smoke-free policy.</strong><tr>
	<td colspan="2">
<tr><td colspan=2><table width="90%" border=".2" align="center" class="box">
<tr><th colspan=2>Multi-unit dwelling policy </th></tr>
<tr valign="bottom">
<th width="60%">Target org name</th>
	<th>Joint partners (if applicable)</th>
	</tr>
<cfloop query="smokefree">
<tr>
	<td>#target#</td>
	<td align="center">#jps_orgs# &nbsp;</td>
	</tr></cfloop>

	<tr>
	<td colspan="2"><h6>Total ## Org Policies: #smokefree.recordcount#</td>
	</tr>
	</table></td></tr>




<tr>
	<td>Status of outcome</td>
	<td colspan="85%">Select "Met" if the table above shows at least one policy.<br>
		<input type="radio" name="multistatus" value="1" <cfif getdeets.multistatus EQ 1> checked</cfif> <cfif read is 1>disabled</cfif>>Met<br>
		<input type="radio" name="multistatus" value="0" <cfif getdeets.multistatus EQ 0> checked</cfif> <cfif read is 1>disabled</cfif>>Unmet
	</td>
</tr>

<tr>
	<td>Progress summary</td>
	<td><textarea name="multiprogress" rows="5" cols="110" <cfif read is 1>readonly class="readonly"</cfif>>#getdeets.multiprogress#</textarea></td>
</tr>
<tr>
	<td>Barriers</td>
	<td><textarea name="multibarriers" rows="5" cols="110" <cfif read is 1>readonly class="readonly"</cfif>>#getdeets.multibarriers#</textarea></td>
</tr>
<cfif session.fy EQ 2008>
<tr>
	<td>Plans to address barriers in the upcoming fiscal year</td>
	<td><textarea name="multiactions" rows="5" cols="110" <cfif read is 1>readonly class="readonly"</cfif>>#getdeets.multiactions#</textarea></td>
</tr>
</cfif>
<cfif read is 0><tr>
	<td>&nbsp;</td>
	<td><input type="button" value="Check Spelling" onClick="spell('document.EOYStatus.multiprogress.value', 'document.EOYStatus.multibarriers.value'<cfif session.fy LT 2009>, 'document.EOYStatus.multiactions.value'</cfif>)">
	</td>
</tr>
</cfif>
</table>

<!--- <script language="javascript">
function calcAdj(){
tempval=document.EOYStatus.qline2.value * (10/12);
tempval=Math.round(tempval);
document.EOYStatus.qlinenumAdj.value=tempval;
}
</script> --->

<TABLE class="box" WIDTH="70%"><TR><TD>
<U>TCP Feedback</U><br>
Outcome-specific comments: <br>
<cfif read is 0><textarea name="multifeedback" cols=130 rows=5 readonly class="readonly">#getdeets.multifeedback#</textarea>
<cfelse>
<textarea name="multifeedback" cols=130 rows=5>#getdeets.multifeedback#</textarea>
</cfif></TD></TR></TABLE>
<div align="left">
<cfif read is 0>
	<input type="button" value="Save" class="AddButton" onClick="setLoc('sv5');">
	<cfelse>
	<input type="button" value="Save" class="AddButton" onClick="setLoc2('sv5');">
</cfif>
</div>

<p></p>
<table  width="71%" border=".2" class="box">
<cfif session.fy GT 2008><tr><td colspan="2"><div align="center"><h3>SMART Outcome 7</h3></div></td></tr></cfif>

<tr>
	<td colspan="2"><a name="sv6"></a>

<div id="set_of_links">
<strong><span style="text-decoration : underline;">Quitline:</span> By July 31, #session.fy#, the number of smokers in the catchment area who call the New York State Smokers' Quitline will increase from <input type="text" name="qline1" size=6 value="<cfif getdeets.qline1 EQ ''>0<cfelse>#getdeets.qline1#</cfif>" <cfif read is 1>readonly class="readonly"</cfif>> to <input type="text" name="qline2" value="<cfif getdeets.qline2 EQ ''>0<cfelse>#getdeets.qline2#</cfif>" size=6 <cfif read is 1>readonly class="readonly"</cfif><!---  onChange="calcAdj();" --->>.
</strong><br>
<!--- Projected number for first 10 months of fiscal year (CAT will calculate this based on your full fiscal year target number): <input type="text" readonly class="readonly" name="qlinenumAdj" value="" size=6>
 --->
      <!--- <input type="hidden" value="1" name="qline" > Partner addressed this optional outcome  ---></td>
</tr>


<table border="1"  width="70%" border=".2" class="box">
 <tr>
	<td colspan="2">
Number of callers to the New York State Smokers' Quitline during FY #evaluate(session.fy -1)#-#session.fy# in catchment area: <input type="text" name="qlinenum" value="<cfif getdeets.qlinenum EQ ''>0<cfelse>#getdeets.qlinenum#</cfif>" size=6 <cfif read is 1>readonly class="readonly"</cfif>> 	</td>
</tr> 
<tr>
	<td>Status of outcome</td>
	<td width="85%">Select "Met" if the actual number of callers was at least as high as the projected number.<br>
		<input type="radio" name="qlinestatus" value="1" <cfif getdeets.qlinestatus EQ 1> checked</cfif> <cfif read is 1>disabled</cfif>>Met<br>
		<input type="radio" name="qlinestatus" value="0" <cfif getdeets.qlinestatus EQ 0> checked</cfif> <cfif read is 1>disabled</cfif>>Unmet
	</td>
</tr>

<tr>
	<td>Progress summary</td>
	<td><textarea name="qlineprogress" rows="5" cols="110" <cfif read is 1>readonly class="readonly"</cfif>>#getdeets.qlineprogress#</textarea></td>
</tr>
<tr>
	<td>Barriers</td>
	<td><textarea name="qlinebarriers" rows="5" cols="110" <cfif read is 1>readonly class="readonly"</cfif>>#getdeets.qlinebarriers#</textarea></td>
</tr>
<cfif session.fy EQ 2008>
<tr>
	<td>Plans to address barriers in the upcoming fiscal year</td>
	<td><textarea name="qlineactions" rows="5" cols="110" <cfif read is 1>readonly class="readonly"</cfif>>#getdeets.qlineactions#</textarea></td>
</tr>
</cfif>
<cfif read is 0>
<tr>
	<td>&nbsp;</td>
	<td><input type="button" value="Check Spelling" onClick="spell('document.EOYStatus.qlineprogress.value', 'document.EOYStatus.qlinebarriers.value'<cfif session.fy LT 2009>, 'document.EOYStatus.qlineactions.value'</cfif>)">
	</td>
</tr>
</cfif><TR><TD colspan=2>
<U>TCP Feedback</U><br>
Outcome-specific comments: <br>
<cfif read is 0>
<textarea name="qlinefeedback" cols=130 rows=5 readonly class="readonly">#getdeets.qlinefeedback#</textarea>
<cfelse>
<textarea name="qlinefeedback" cols=130 rows=5>#getdeets.qlinefeedback#</textarea>
</cfif></TD></TR></TABLE>
<div align="left">
<cfif read is 0>
	<input type="button" value="Save" class="AddButton" onClick="setLoc('sv6');">
	<cfelse>
	<input type="button" value="Save" class="AddButton" onClick="setLoc2('sv6');">
</cfif>
</div>
</div>
<p></p>
<table  width="70%" border=".2" class="box">
	<cfif session.fy GT 2008><tr><td colspan="2"><div align="center"><h3>SMART Outcome 8</h3></div></td></tr></cfif>
<tr>
	<td colspan="2"><a name="sv7"></a>
<strong><span style="text-decoration : underline;">Infrastructure:  </span> Coordinator will participate in meetings, conferences and trainings, network with other partners and partner agencies and complete TCP sustainability tasks in order to enhance program functioning, staff development, and support.	</strong></td>
</tr>
<tr><td colspan=2><table width="50%" border=".2" align="center" class="box">
<tr><td>
<tr valign="bottom">
<th>Conducted sustainability activity?</th>
	<th>Sustainability activities</th>
	</tr>
	</cfoutput>
<cfoutput query="smart8">
<tr>
	<td align="center"><cfif #sust1# GT 0>&radic;<cfelse>&nbsp;</cfif></td>
	<td>Corresponded with local legislators</td>
	</tr>
	<tr>
	<td align="center"><cfif #sust2#  GT 0>&radic;<cfelse>&nbsp;</cfif></td>
	<td>Submitted letter to the editor</td>
	</tr>
	<tr>
	<td align="center"><cfif #sust3#  GT 0>&radic;<cfelse>&nbsp;</cfif></td>
	<td>Met with media representatives</td>
	</tr>
	<tr>
	<td align="center"><cfif #sust4#  GT 0>&radic;<cfelse>&nbsp;</cfif></td>
	<td>Made in-person legislative visit</td>
	</tr></cfoutput>
	</table></td></tr>
<cfoutput>
<tr>
	<td>Status of outcome</td>
	<td width="85%">
	<cfif session.fy GT 2008>Select ‘Met’ if you participated in meetings, conferences, trainings, and networking AND if 3 out of 4 sustainability activities are checked in the table above.</cfif><br>
		<input type="radio" name="coordstatus" value="1" <cfif getdeets.coordstatus EQ 1> checked</cfif> <cfif read is 1>disabled</cfif>>Met<br>
		<input type="radio" name="coordstatus" value="0" <cfif getdeets.coordstatus EQ 0> checked</cfif> <cfif read is 1>disabled</cfif>>Unmet
	</td>
</tr>

<tr>
	<td>Progress summary</td>
	<td><textarea name="coordprogress" rows="5" cols="110" <cfif read is 1>readonly class="readonly"</cfif>>#getdeets.coordprogress#</textarea></td>
</tr>
<tr>
	<td>Barriers</td>
	<td><textarea name="coordbarriers" rows="5" cols="110" <cfif read is 1>readonly class="readonly"</cfif>>#getdeets.coordbarriers#</textarea></td>
</tr>
<cfif session.fy EQ 2008>
<tr>
	<td>Plans to address barriers in the upcoming fiscal year</td>
	<td><textarea name="coordactions" rows="5" cols="110" <cfif read is 1>readonly class="readonly"</cfif>>#getdeets.coordbarriers#</textarea></td>
</tr>
</cfif>

<cfif read is 0>
<tr>
	<td>&nbsp;</td>
	<td><input type="button" value="Check Spelling" onClick="spell('document.EOYStatus.coordprogress.value', 'document.EOYStatus.coordbarriers.value'<cfif session.fy LT 2009>, 'document.EOYStatus.coordactions.value'</cfif>)">
	</td>
</tr>
</cfif>
</table>

<TABLE class="box" WIDTH="70%"><TR><TD>
<U>TCP Feedback</U><br>
Outcome-specific comments: <br>
<cfif read is 0><textarea name="coordfeedback" cols=130 rows=5 readonly class="readonly">#getdeets.coordfeedback#</textarea>
<cfelse>
<textarea name="coordfeedback" cols=130 rows=5>#getdeets.coordfeedback#</textarea>
</cfif></TD></TR></TABLE>
<div align="left">
<cfif read is 0>
	<input type="button" value="Save" class="AddButton" onClick="setLoc('sv7');">
	<cfelse>
	<input type="button" value="Save" class="AddButton" onClick="setLoc2('sv7');">
</cfif>
</div>

<p></p>
<!--- <cfset read=0> --->
 
<table border="1" width="71%" border=".2" class="box">
<cfif session.fy GT 2008><tr><td colspan="2"><div align="center"><h3>SMART Outcome 9 (Optional)</h3></div></td></tr></cfif>
<tr>
	<td colspan="2"><a name="sv8"></a>
<div id="set_of_links2">
<strong><span style="text-decoration : underline;">Outdoor policies: </span>	By July 31, #session.fy#, <input type="text" name="govtnum" value="<cfif getdeets.govtnum EQ ''>0<cfelse>#getdeets.govtnum#</cfif>" size=4 <cfif read is 1>readonly class="readonly"</cfif>> ## of governmental, private, or other organizations will adopt policies prohibiting tobacco use in outdoor areas. 
</strong><br>
<div id="div2" class="divs">
      <input type="checkbox" value="1" name="govt" id="govt" onclick="show_other (this, 'tab2');"  <cfif getdeets.govt EQ 1> checked</cfif> <cfif read is 1>disabled</cfif>> Partner addressed this optional outcome </td>
</tr>

</div>

<table border="1" id="tab2" style="display:none"  width="70%" border=".2" class="box">

	<td colspan="2">
<tr><td colspan=2><table width="90%" border=".2" align="center" class="box">
<tr><th colspan=2>Outdoor policies </th></tr>
<tr valign="bottom">
<th width="60%">Target org name</th>
	<th>Joint partners (if applicable)</th>
	</tr>
<cfloop query="outdoor">
<tr>
	<td>#target#</td>
	<td align="center">#jps_orgs# &nbsp;</td>
	</tr></cfloop>
	<tr>
	<td colspan="2">Total ## Org Policies: #outdoor.recordcount#</td>
	</tr>
	</table></td></tr>


<tr>
	<td>Status of outcome</td>
	<td colspan="85%">Select "Met" if the number of policies in the table above is at least as high as the projected number.<br>
		<input type="radio" name="govtstatus" value="1" <cfif getdeets.govtstatus EQ 1> checked</cfif> <cfif read is 1>disabled</cfif>>Met<br>
		<input type="radio" name="govtstatus" value="0" <cfif getdeets.govtstatus EQ 0> checked</cfif> <cfif read is 1>disabled</cfif>>Unmet
	</td>
</tr>

<tr>
	<td>Progress summary</td>
	<td><textarea name="govtprogress" rows="5" cols="110" <cfif read is 1>readonly class="readonly"</cfif>>#getdeets.govtprogress#</textarea></td>
</tr>
<tr>
	<td>Barriers</td>
	<td><textarea name="govtbarriers" rows="5" cols="110" <cfif read is 1>readonly class="readonly"</cfif>>#getdeets.govtbarriers#</textarea></td>
</tr>
<cfif session.fy  EQ 2008>
<tr>
	<td>Plans to address barriers in the upcoming fiscal year</td>
	<td><textarea name="govtactions" rows="5" cols="110" <cfif read is 1>readonly class="readonly"</cfif>>#getdeets.govtactions#</textarea></td>
</tr>
</cfif>
<cfif #read# is 0>
<tr>
	<td>&nbsp;</td>
	<td><input type="button" value="Check Spelling" onClick="spell('document.EOYStatus.govtprogress.value', 'document.EOYStatus.govtbarriers.value'<cfif session.fy LT 2009>, 'document.EOYStatus.govtactions.value'</cfif>)">
	</td>
</tr>
</cfif>
<TR><TD colspan=2>
<U>TCP Feedback</U><br>
Outcome-specific comments: <br>
<cfif #read# is 0><textarea name="govtfeedback" cols=130 rows=5 readonly class="readonly">#getdeets.govtfeedback#</textarea>
<cfelse>
<textarea name="govtfeedback" cols=130 rows=5>#getdeets.govtfeedback#</textarea>
</cfif></TD></TR></TABLE>
<div align="left">
<cfif read is 0>
	<input type="button" value="Save" class="AddButton" onClick="setLoc('sv8');">
	<cfelse>
	<input type="button" value="Save" class="AddButton" onClick="setLoc2('sv8');">
</cfif>
</div>
</div>

<cfif session.fy eq 2008>
<p></p>
<table border="1" width="71%" border=".2" class="box">
<tr>
	<td colspan="2"><a name="sv9"></a>
<div id="set_of_links3">
<strong><span style="text-decoration : underline;">Local cigarette tax: </span> By July 31, 2008, at least one county will levy a local cigarette excise tax. </strong><br>	

<div id="div3" class="divs">
 <input type="checkbox" value="1" name="excise" id="excise" <cfif getdeets.excise EQ 1> checked</cfif> onclick="show_other (this, 'tab3');" <cfif read is 1>disabled</cfif>> Partner addressed this optional outcome </td></tr>

</div>
<table border="1" id="tab3" style="display:none"  width="70%" border=".2" class="box">

<tr>
	<td>Status of outcome</td>
	<td colspan="85%">Select "Met" if at least one county levied a local cigarette excise tax.<br>
		<input type="radio" name="excisestatus" value="1" <cfif getdeets.excisestatus EQ 1> checked</cfif> <cfif read is 1>disabled</cfif>>Met<br>
		<input type="radio" name="excisestatus" value="0" <cfif getdeets.excisestatus EQ 0> checked</cfif> <cfif read is 1>disabled</cfif>>Unmet
	</td>
</tr>

<tr>
	<td>Progress summary</td>
	<td><textarea name="exciseprogress" rows="5" cols="110" <cfif read is 1>readonly class="readonly"</cfif>>#getdeets.exciseprogress#</textarea></td>
</tr>
<tr>
	<td>Barriers</td>
	<td><textarea name="excisebarriers" rows="5" cols="110" <cfif read is 1>readonly class="readonly"</cfif>>#getdeets.excisebarriers#</textarea></td>
</tr>
<tr>
	<td>Plans to address barriers in the upcoming fiscal year</td>
	<td><textarea name="exciseactions" rows="5" cols="110" <cfif read is 1>readonly class="readonly"</cfif>>#getdeets.exciseactions#</textarea></td>
</tr>
<cfif #read# is 0>
<tr>
	<td>&nbsp;</td>
	<td><input type="button" value="Check Spelling" onClick="spell('document.EOYStatus.exciseprogress.value', 'document.EOYStatus.excisebarriers.value'<cfif session.fy LT 2009>, 'document.EOYStatus.exciseactions.value'</cfif>)">
	</td>
</tr>
</cfif>
<TR><TD colspan=2>
<U>TCP Feedback</U><br>
Outcome-specific comments: <br>
<cfif #read# is 0><textarea name="excisefeedback" cols=130 rows=5 readonly class="readonly">#getdeets.excisefeedback#</textarea>
<cfelse>
<textarea name="excisefeedback" cols=130 rows=5>#getdeets.excisefeedback#</textarea>
</cfif></TD></TR>
</TABLE>
<div align="left">
<cfif read is 0>
	<input type="button" value="Save" class="AddButton" onClick="setLoc('sv9');">
	<cfelse>
	<input type="button" value="Save" class="AddButton" onClick="setLoc2('sv9');">
</cfif>
</div></div>
</cfif>
<!--- 

<p></p>
<table  width="80%" border=".2" class="box">
<tr>
	<td colspan="2">SMART Outcome:	</td><a name="sv10"></a>
</tr>
<tr>
	<td>Status of outcome</td>
	<td>
		<input type="radio" name="sm1_status" value="1" <cfif QRptbasics.sm1_status EQ 1> checked</cfif>>Met<br>
		<input type="radio" name="sm1_status" value="0" <cfif QRptbasics.sm1_status EQ 0> checked</cfif>>Unmet
	</td>
</tr>

<tr>
	<td>Progress summary</td>
	<td><textarea name="sm1_progress" rows="5" cols="75">#QRptbasics.sm1_progress#</textarea></td>
</tr>
<tr>
	<td>Barriers</td>
	<td><textarea name="sm1_barrier" rows="5" cols="75">#QRptbasics.sm1_barrier#</textarea></td>
</tr>
<tr>
	<td>Plans to address barriers in the upcoming fiscal year</td>
	<td><textarea name="sm1_actions" rows="5" cols="75">#QRptbasics.sm1_actions#</textarea></td>
</tr>
<cfif ((isdefined("url.usid") and session.userid EQ url.usid ) or (not isDefined("url.usid")) AND (QRptbasics.recordcount EQ 0 OR QRptbasics.complete NEQ 1))>
<tr>
	<td>&nbsp;</td>
	<td><input type="button" value="Check Spelling" onClick="spell('document.EOYStatus.sm1_progress.value', 'document.EOYStatus.sm1_barrier.value', 'document.EOYStatus.sm1_actions.value')">
	</td>
</tr>
</cfif>
</table>

<TABLE class="box" WIDTH="80%"><TR><TD>
<U>TCP Feedback</U><br>
Outcome specific comments: <br>
<textarea name="TCP10" cols=100 rows=5></textarea></TD></TR></TABLE>
<cfif ((isdefined("url.usid") and session.userid EQ url.usid ) or (not isDefined("url.usid")) AND (QRptbasics.recordcount EQ 0 OR QRptbasics.complete NEQ 1))>

<div align="left">
	<input type="button" value="Save" class="AddButton" onClick="setLoc('sv10');">
</div>
</cfif>
 --->
<p></p>






<!--- blocked out add new outcome code.. wasn''t working... needs fixin. --->


<table border="1" width="70%" border=".2" class="box">
<tr>
	<td colspan="2"><a name="sv11"></a>
		<strong><span style="text-decoration : underline;">Additional outcomes: </span>If you need to enter any SMART outcomes not listed above, please enter them in the text box below.	
	</strong></td>
<tr>
	<td colspan="2">
<textarea name="customcomment" rows="5" cols="110" <cfif read is 1>readonly class="readonly"</cfif>>#getdeets.customcomment#</textarea>
</td></tr>
<TR><TD colspan=2>
<U>TCP Feedback</U><br>
Outcome-specific comments: <br>
<cfif #read# is 0><textarea name="customfeedback" cols=130 rows=5 readonly class="readonly">#getdeets.customfeedback#</textarea>
<cfelse>
<textarea name="customfeedback" cols=130 rows=5>#getdeets.customfeedback#</textarea>
</cfif></TD></TR>
<tr><td colspan="2">
<div align="left">
<cfif read is 0>
	<input type="button" value="Save" class="AddButton" onClick="setLoc('sv11');">
	<cfelse>
	<input type="button" value="Save" class="AddButton" onClick="setLoc2('sv11');">
</cfif>
</div>
</td></tr>


<tr>
	<td colspan="2">
	<CFIF getdeets.Partner_status GT 0 and NOT(listcontains(session.newExt_5, (session.def_fy-1)) or listcontains(session.newExt_5, (session.def_fy)))>
	<input type="button" value="EOY Report Submitted" class="DelButton" disabled>
		<cfelse>
	
	<input type="button" value="Submit EOY Report" class="AddButton" onClick="setSave(); setLoc2('sv99');"  <cfif isDefined("usid")> disabled</cfif>>
	</CFIF>
	<cfif Audit1.recordcount GT 0>
	<br><cfloop query="Audit1">
	Submitted #dateformat(Audit1.dtstmp, "m/d/yyyy")# <br>
	</cfloop>
	</cfif>
	</td>
</tr>




</TABLE>









<p></p>
<TABLE class="box" WIDTH="70%">
	<tr><td><div align="center"><h3>TCP Feedback</h3></div><div align="center"><h4>To be completed by TCP staff after partner completes EOY report</h4></div></td></tr>

<TR><TD><a name="sv12"></a>
<cfif session.fy EQ 2008>If End-of-Year (EOY) Report is NOT complete, items to be addressed are checked below. <br>Entries in this EOY Report: <br><cfelse>If End-of-Year (EOY) Report is not complete to TCP satisfaction, items to be addressed are described below.</cfif>
<cfif session.fy EQ 2008>
<input type="checkbox" name="TCP1" <cfif read is 0 or  getdeets.eoycomplete EQ 1>disabled</cfif> value=1 <cfif getdeets.tcp1 EQ 1> checked</cfif>> Are not consistent with CAT reporting<br>
<input type="checkbox" name="TCP2" <cfif read is 0 or  getdeets.eoycomplete EQ 1>disabled</cfif> value=1 <cfif getdeets.tcp2 EQ 1> checked</cfif>> Do not accurately reflect the partner's progress this past contract year<br>
<input type="checkbox" name="TCP3" <cfif read is 0 or  getdeets.eoycomplete EQ 1>disabled</cfif> value=1 <cfif getdeets.tcp3 EQ 1> checked</cfif>> Do not include actions to address barriers that are consistent with next year's work plan<br>
<input type="checkbox" name="TCP4" <cfif read is 0 or  getdeets.eoycomplete EQ 1>disabled</cfif> value=1 <cfif getdeets.tcp4 EQ 1> checked</cfif>> Do not describe how 2008-2009 activities will build on 2007-2008 successes<br>
</cfif>
<p>
<cfif session.fy EQ 2008>
<cfif read is 0 or  getdeets.eoycomplete EQ 1>
<input type="hidden" name="TCP1" value="<cfoutput>#getdeets.tcp1#</cfoutput>">
<input type="hidden" name="TCP2" value="<cfoutput>#getdeets.tcp2#</cfoutput>">
<input type="hidden" name="TCP3" value="<cfoutput>#getdeets.tcp3#</cfoutput>">
<input type="hidden" name="TCP4" value="<cfoutput>#getdeets.tcp4#</cfoutput>">
</cfif>
</cfif>


EOY Report feedback: <br>
<cfif read is 0><textarea name="tcpfeedback" cols=130 rows=5 readonly class="readonly">#getdeets.tcpfeedback#</textarea>
<cfelse>
<textarea name="tcpfeedback" cols=130 rows=5>#getdeets.tcpfeedback#</textarea>
</cfif></p>
Is EOY complete to TCP satisfaction, including all recommended edits?<br>
<cfif read is 0>
<input type="checkbox" name="EOYcomplete" value=1 <cfif getdeets.eoycomplete EQ 1>checked</cfif> disabled> Yes<br>
<cfelse>
<input type="checkbox" name="EOYcomplete" <cfif getdeets.eoycomplete EQ 1>checked disabled</cfif> value=1> Yes<br>
</cfif>
<cfif getdeets.eoy_dt is not ''>
<input type="hidden" name="eoy_dt" value="#getdeets.eoy_dt#">
(#dateformat(getdeets.eoy_dt,"mm/dd/yyyy")#)</cfif>

</TD></TR></TABLE>
<cfif isdefined("usid")>
<tr>
	<td colspan="2"><input type="button" value="Check Spelling" onClick="spell('document.EOYStatus.retailfeedback.value','document.EOYStatus.munifeedback.value','document.EOYStatus.ordifeedback.value','document.EOYStatus.orgfeedback.value','document.EOYStatus.multifeedback.value','document.EOYStatus.qlinefeedback.value','document.EOYStatus.coordfeedback.value','document.EOYStatus.govtfeedback.value','document.EOYStatus.excisefeedback.value','document.EOYStatus.customfeedback.value','document.EOYStatus.tcpfeedback.value')">
	</td>
</tr>
</cfif>
<tr><Td>
<cfif isdefined("usid")>

<div align="left">
	<input  type="button" value="Save" class="AddButton" onClick="setLoc('sv12');">
</div>


<tr>
	<td colspan="2">
		<div align="left">
			
			
<CFIF getdeets.TCP_status GT 0>
	<input type="button" value="Feedback Submitted" class="DelButton"  onClick="setSave2(); setLoc2('sv99');">
		<cfelse>
	
	<input type="button" value="Submit Feedback" class="AddButton" onClick="setSave2(); setLoc2('sv99');">
	</CFIF>

<cfif Audit2.recordcount GT 0>
	<br><cfloop query="Audit2">
	Reviewed #dateformat(Audit2.dtstmp, "m/d/yyyy")# <br>
	</cfloop>
	</cfif>
</div>
</td>
</tr>


</cfif></Td></tr></cfoutput>
<!--- </cfform> --->

<script language="javascript">

<!--- show_other2 ('qline', 'tab1'); --->
show_other2 ('govt', 'tab2');
<cfif session.fy LT 2009>
show_other2 ('excise', 'tab3');
</cfif>
<!--- calcAdj(); --->
</script>  