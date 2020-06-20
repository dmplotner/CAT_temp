<html>
<head>
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
      if (!(isInteger(document.EOYStatus.retailnum.value) && (document.EOYStatus.retailnum.value != '') && isInteger(document.EOYStatus.orgnum.value) && (document.EOYStatus.orgnum.value != '')  && isInteger(document.EOYStatus.agnum1.value) && (document.EOYStatus.agnum1.value != '' ) && isInteger(document.EOYStatus.agnum2.value) && (document.EOYStatus.agnum2.value != '') && isInteger(document.EOYStatus.govtnum.value) && (document.EOYStatus.govtnum.value != ''))){
      alert ('Please make sure all numeric fields have integer values, and not text or blanks. After you correct this, please click “Save” again to save your entries.');
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
      
      function setSave(){
      document.EOYStatus.compPartner.value=1;
      }
      function setSave2(){
      document.EOYStatus.compTCP.value=1;
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

</head>
<body onload="javascript:hidediv('256')">

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
SELECT     distinct t.target, cast(u.JPS_orgs as varchar(1000)) as JPS_orgs
FROM         dbo.PRPChange AS m INNER JOIN
                      dbo.user_target_org AS t ON m.userid = t.userid AND m.year2 = t.year2 AND m.stakeholders = t.seq INNER JOIN
                      dbo.months AS mo ON m.month2 = mo.Mon and m.year2 = mo.year2 INNER JOIN
                      dbo.userActivities AS u ON m.userid = u.userid AND m.activity = u.activity AND m.year2 = u.year2 INNER JOIN
                      dbo.objectives AS o ON u.objective = o.ID
WHERE     (u.del IS NULL) AND (u.year2 = '#session.fy#') AND (o.groupName = 'retail') AND (m.channel = 1 OR m.channel = 4 OR m.channel = 5) AND (u.strategy IN (8, 9)) AND 
((u.userid='SHARED' and m.activity in (#quotedvaluelist(QUsershared.activity)#)) OR  
(<cfif isdefined("usid")>u.userid='#usid#'<cfelse>u.userid='#session.userid#' </cfif> and t.target not in (
select distinct t.target
FROM         dbo.PRPChange AS m INNER JOIN
                      dbo.user_target_org AS t ON m.userid = t.userid AND m.year2 = t.year2 AND m.stakeholders = t.seq INNER JOIN
                      dbo.months AS mo ON m.month2 = mo.Mon INNER JOIN
                      dbo.userActivities AS u ON m.userid = u.userid AND m.activity = u.activity AND m.year2 = u.year2 INNER JOIN
                      dbo.objectives AS o ON u.objective = o.ID
WHERE     (u.del IS NULL) AND (u.year2 = '#session.fy#') AND (o.groupName = 'retail') AND (m.channel in (1,4,5)) AND (u.strategy IN (8, 9)) AND 
(u.userid='SHARED' and m.activity in (#quotedvaluelist(QUsershared.activity)#))
)))
order by 1
</cfquery>
<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="promo">
SELECT     distinct t.target,  cast(u.JPS_orgs as varchar(1000)) as JPS_orgs
FROM         dbo.PRPChange AS m INNER JOIN
                      dbo.user_target_org AS t ON m.userid = t.userid AND m.year2 = t.year2 AND m.stakeholders = t.seq INNER JOIN
                      dbo.months AS mo ON m.month2 = mo.Mon INNER JOIN
                      dbo.userActivities AS u ON m.userid = u.userid AND m.activity = u.activity AND m.year2 = u.year2 INNER JOIN
                      dbo.objectives AS o ON u.objective = o.ID
WHERE     (u.del IS NULL) AND (u.year2 = '#session.fy#') AND (o.groupName = 'sponspromo') AND (m.channel in (1,4,5)) AND (u.strategy IN (8,9)) AND ((u.userid='SHARED' and m.activity in (#quotedvaluelist(QUsershared.activity)#)) OR <cfif isdefined("usid")>u.userid='#usid#'<cfelse>u.userid='#session.userid#' </cfif>)
order by 1
</cfquery>
<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="outdoor">
SELECT     distinct t.target,  cast(u.JPS_orgs as varchar(1000)) as JPS_orgs
FROM         dbo.PRPChange AS m INNER JOIN
                      dbo.user_target_org AS t ON m.userid = t.userid AND m.year2 = t.year2 AND m.stakeholders = t.seq INNER JOIN
                      dbo.months AS mo ON m.month2 = mo.Mon INNER JOIN
                      dbo.userActivities AS u ON m.userid = u.userid AND m.activity = u.activity AND m.year2 = u.year2 INNER JOIN
                      dbo.objectives AS o ON u.objective = o.ID
WHERE     (u.del IS NULL) AND (u.year2 = '#session.fy#') AND (o.groupName = 'outdoor') AND (m.channel in (1,4,5)) AND (u.strategy IN (1,8,9)) 
AND ((u.userid='SHARED' and m.activity in (#quotedvaluelist(QUsershared.activity)#)) 
OR <cfif isdefined("usid")>u.userid='#usid#'<cfelse>u.userid='#session.userid#' </cfif>)
order by 1
</cfquery>





<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="mags">
SELECT     distinct t.target,  cast(u.JPS_orgs as varchar(1000)) as JPS_orgs
FROM         dbo.PRPChange AS m INNER JOIN
                      dbo.user_target_org AS t ON m.userid = t.userid AND m.year2 = t.year2 AND m.stakeholders = t.seq INNER JOIN
                      dbo.months AS mo ON m.month2 = mo.Mon INNER JOIN
                      dbo.userActivities AS u ON m.userid = u.userid AND m.activity = u.activity AND m.year2 = u.year2 INNER JOIN
                      dbo.objectives AS o ON u.objective = o.ID
WHERE     (u.del IS NULL) AND (u.year2 = '#session.fy#') AND (o.groupName = 'magazine') AND (m.channel = 2) AND (u.strategy IN (8,9)) 
AND ((u.userid='SHARED' and m.activity in (#quotedvaluelist(QUsershared.activity)#)) 
OR <cfif isdefined("usid")>u.userid='#usid#'<cfelse>u.userid='#session.userid#' </cfif>)
order by 1
</cfquery>
<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="movies">
SELECT     distinct t.target, cast(u.JPS_orgs as varchar(1000)) as JPS_orgs
FROM         dbo.PRPChange AS m INNER JOIN
                      dbo.user_target_org AS t ON m.userid = t.userid AND m.year2 = t.year2 AND m.stakeholders = t.seq INNER JOIN
                      dbo.months AS mo ON m.month2 = mo.Mon INNER JOIN
                      dbo.userActivities AS u ON m.userid = u.userid AND m.activity = u.activity AND m.year2 = u.year2 INNER JOIN
                      dbo.objectives AS o ON u.objective = o.ID
WHERE     (u.del IS NULL) AND (u.year2 = '#session.fy#') AND (o.groupName = 'movies') AND (m.channel = 2) AND (u.strategy IN (1,8,9)) 
AND ((u.userid='SHARED' and m.activity in (#quotedvaluelist(QUsershared.activity)#))
OR <cfif isdefined("usid")>u.userid='#usid#'<cfelse>u.userid='#session.userid#' </cfif>)
order by 1
</cfquery>
<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="mpaa">
select distinct a.activity, m.mon,m.rank, t.target,
	--t.target, numMeet, numPhone, numEmail, 
	numLetters,a.numpet	
	from DirEdAct as a, useractivities as u, user_target_org as t, objectives o, months m	
where
	a.userid= u.userid
	and a.year2 = #session.fy#
	and u.year2=a.year2
	and t.year2=u.year2
	and t.seq=a.target
	and u.activity=a.activity
	and u.userid=a.userid
	and u.del is null
	and u.del is null
	and u.objective=o.id
	and u.year2=o.year2
	and (u.targetgroup like '%22%' and u.strategy=9)
	and o.groupname='Movies'
	and t.target = 'Motion Picture Assocation of America'
	AND ((u.userid='SHARED' and u.activity in (#quotedvaluelist(QUsershared.activity)#))
	OR <cfif isdefined("usid")>u.userid='#usid#'<cfelse>u.userid='#session.userid#' </cfif>)
	and m.mon=a.month2
	order by m.rank
</cfquery>

<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="gpme">
SELECT     distinct t.target,  cast(u.JPS_orgs as varchar(1000)) as JPS_orgs
FROM         dbo.PRPChange AS m INNER JOIN
                      dbo.user_target_org AS t ON m.userid = t.userid AND m.year2 = t.year2 AND m.stakeholders = t.seq INNER JOIN
                      dbo.months AS mo ON m.month2 = mo.Mon INNER JOIN
                      dbo.userActivities AS u ON m.userid = u.userid AND m.activity = u.activity AND m.year2 = u.year2 INNER JOIN
                      dbo.objectives AS o ON u.objective = o.ID
where    (u.del IS NULL) AND (u.year2 = '#session.fy#') AND (o.groupName = 'retail') AND (m.channel = 2) AND (u.strategy IN (1)) 
AND ((u.userid='SHARED' and m.activity in (#quotedvaluelist(QUsershared.activity)#)) 
OR <cfif isdefined("usid")>u.userid='#usid#'<cfelse>u.userid='#session.userid#' </cfif>)

order by 1
</cfquery>

<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="gpme2">
SELECT     distinct t.target,  cast(u.JPS_orgs as varchar(1000)) as JPS_orgs
FROM         dbo.PRPChange AS m INNER JOIN
                      dbo.user_target_org AS t ON m.userid = t.userid AND m.year2 = t.year2 AND m.stakeholders = t.seq INNER JOIN
                      dbo.months AS mo ON m.month2 = mo.Mon INNER JOIN
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
<!--- <table  class="Table2" width="90%">
 --->
<p></p>
<table  width="70%">
<tr><td>
<div align="center"><h3>Reporting by SMART Outcome</h3></div>
</td></tr>
</table>
<table  width="70%" border=".2" class="box">
<tr>
	<td colspan="2"><a name="sv1"></a><br>
	<cfif session.fy GT 2008><div align="center"><h3>SMART Outcome 1</h3></div></cfif>
	
	<i>Enter projected number from your workplan</i><br>
<strong><strong><span style="text-decoration : underline;">Retail Policies:</span></strong> By July 31, #session.fy#, <input type="text" name="retailnum" value="<cfif getdeets.retailnum EQ ''>0<cfelse>#getdeets.retailnum#</cfif>" size=4 <cfif read is 1>readonly class="readonly"</cfif> <cfif read is 1>readonly class="readonly"</cfif>> ## of retailers in your catchment area will have adopted a policy to rearrange, reduce or eliminate tobacco advertising in their retail store. 
</strong>	</td>
</tr>

<tr>
	<td colspan="2">
<tr><td colspan=2><table width="90%" border=".2" align="center" class="box">
<tr><th colspan=3>Retail advocacy policies entered with a target of tobacco retailers:</th></tr>
<tr><td>
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
	<td colspan=2><h6>Total ## Org Policies: #retail.recordcount#</td>
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
<cfif session.fy EQ 2008>
<tr>
	<td>Plans to address barriers in the upcoming fiscal year</td>
	<td><textarea name="retailactions" rows="5" cols="110" <cfif read is 1>readonly class="readonly"</cfif>>#getdeets.retailactions#</textarea></td>
</tr>
</cfif>
<cfif read is 0><tr>
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



<!--- inserted 7/15/08 dmp --->
<p></p>
<table  width="70%" border=".2" class="box">
<cfif session.fy GT 2008>
	<tr><td colspan="2"><div align="center"><h3>SMART Outcome 2</h3></div></td></tr>
</cfif>
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
	<td colspan="2"><strong>Total ## Org Resolutions: #gpme.recordcount#</strong></td>
	
	</tr>
	</table></td></tr>

<tr>
	<td>Status of outcome</td>
	<td width="85%">Select "Met" if the table above shows at least one municipality resolution per county.<br>
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
<cfif read is 0><tr>
	<td>&nbsp;</td>
	<td><input type="button" value="Check Spelling" onClick="spell('document.EOYStatus.muniprogress.value', 'document.EOYStatus.munibarriers.value'<cfif session.fy LT 2009>, 'document.EOYStatus.muniactions.value'</cfif>)">
	</td>
</tr>
</cfif>
</table>

<TABLE class="box" WIDTH="70%"><TR><TD>
<U>TCP Feedback</U><br>
Outcome-specific comments: <br>
<cfif read is 0><textarea name="munifeedback" cols=130 rows=5 readonly class="readonly">#getdeets.munifeedback#</textarea>
<cfelse>
<textarea name="munifeedback" cols=130 rows=5>#getdeets.munifeedback#</textarea>
</cfif>
</TD></TR></TABLE>
<div align="left">
<cfif read is 0>
	<input type="button" value="Save" class="AddButton" onClick="setLoc('sv2');">
	<cfelse>
	<input type="button" value="Save" class="AddButton" onClick="setLoc2('sv2');">
</cfif>
</div>

<!--- wrong code! --->
<!--- <table  width="70%" border=".2" class="box">
<tr>
	<td colspan="2">
<strong>By July 31, 2008, at least one (1) existing local ordinance or law regulating signage, per county, will be enforced against a violation involving tobacco advertising.</tr>
</strong></td></tr>
<tr>
	<td>Status of outcome</td>
	<td width="85%">Select "Met" if at least one local ordinance or law was enforced.<br>
		<input type="radio" name="ordistatus" value="1" <cfif getdeets.ordistatus EQ 1> checked</cfif>>Met<br>
		<input type="radio" name="ordistatus" value="0" <cfif getdeets.ordistatus EQ 0> checked</cfif>>Unmet
	</td>
</tr>
<tr>
	<td>Progress summary</td>
	<td><textarea name="ordiprogress" rows="5" cols="110">#getdeets.ordiprogress#</textarea></td>
</tr>
<tr>
	<td>Barriers</td>
	<td><textarea name="ordibarriers" rows="5" cols="110">#getdeets.ordibarriers#</textarea></td>
</tr>
<tr>
	<td>Plans to address barriers in the upcoming fiscal year</td>
	<td><textarea name="ordiactions" rows="5" cols="110">#getdeets.ordiactions#</textarea></td>
</tr>
<cfif ((isdefined("url.usid") and session.userid EQ url.usid ) or (not isDefined("url.usid")) AND (QRptbasics.recordcount EQ 0 OR QRptbasics.complete NEQ 1))>
<tr>
	<td>&nbsp;</td>
	<td><input type="button" value="Check Spelling" onClick="spell('document.EOYStatus.ordiprogress.value', 'document.EOYStatus.ordibarriers.value', 'document.EOYStatus.ordiactions.value')">
	</td>
</tr>
</cfif>
</table>
<TABLE class="box" WIDTH="70%"><TR><TD>
<U>TCP Feedback</U><br>
Outcome specific comments: <br>
<cfif SESSION.CessMan is "0"><textarea name="ordifeedback" cols=130 rows=5 readonly>#getdeets.ordifeedback#</textarea>
<cfelse>
<textarea name="ordifeedback" cols=130 rows=5>#getdeets.ordifeedback#</textarea>
</cfif>

</TD></TR></TABLE>
<cfif ((isdefined("url.usid") and session.userid EQ url.usid ) or (not isDefined("url.usid")) AND (QRptbasics.recordcount EQ 0 OR QRptbasics.complete NEQ 1))>

<div align="left">
	<input type="button" value="Save" class="AddButton" onClick="checkContAmt();">
</div>
</cfif> --->


<!--- added for 2009 --->
<p></p>
<table  width="70%" border=".2" class="box">
<cfif session.fy GT 2008>
	<tr><td colspan="2"><div align="center"><h3>SMART Outcome 3</h3></div></td></tr>
</cfif>
<tr>
	<td colspan="2"><a name="sv2a"></a>
<strong><span style="text-decoration : underline;">Retail Community Organization Resolutions:</span> By July 31, #session.fy# obtain at least one community based organization or institution resolution per county opposing tobacco advertising and promotion in the retail environment and calling on retailers to make voluntary changes.	</strong></td>
</tr>

<tr>
	<td colspan="2">
<tr><td colspan=2><table width="90%" border=".2" align="center" class="box">
<tr><th colspan=2>Retail resolutions by community organizations</th></tr>
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
	<td colspan="2"><strong>Total ## Org Resolutions: #gpme2.recordcount#</strong></td>
	
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

<cfif read is 0><tr>
	<td>&nbsp;</td>
	<td><input type="button" value="Check Spelling" onClick="spell('document.EOYStatus.muniprogress2.value', 'document.EOYStatus.munibarriers2.value')">
	</td>
</tr>
</cfif>
</table>

<TABLE class="box" WIDTH="70%"><TR><TD>
<U>TCP Feedback</U><br>
Outcome-specific comments: <br>
<cfif read is 0><textarea name="munifeedback2" cols=130 rows=5 readonly class="readonly">#getdeets.munifeedback2#</textarea>
<cfelse>
<textarea name="munifeedback2" cols=130 rows=5>#getdeets.munifeedback2#</textarea>
</cfif>
</TD></TR></TABLE>
<div align="left">
<cfif read is 0>
	<input type="button" value="Save" class="AddButton" onClick="setLoc('sv2a');">
	<cfelse>
	<input type="button" value="Save" class="AddButton" onClick="setLoc2('sv2a');">
</cfif>
</div>
<!--- end New 2009 --->

<p></p>
<table  width="70%" border=".2" class="box">
<cfif session.fy GT 2008>
<tr><td colspan="2"><div align="center"><h3>SMART Outcome 4</h3></div></td></tr>
</cfif>
<tr>
	<td colspan="2"><a name="sv99"></a><strong><span style="text-decoration : underline;">Sponsorship and Promotion Policies:</span></strong><br>
		<i>Enter projected number from your workplan</i><br>
<strong>By July 31, #session.fy#, <input type="text" name="orgnum" value="<cfif getdeets.orgnum EQ ''>0<cfelse>#getdeets.orgnum#</cfif>" size=4 <cfif read is 1>readonly class="readonly"</cfif>>  ## of organizations, venues and events in the catchment area will have adopted a written policy prohibiting tobacco company corporate giving, commercial sponsorship, and promotion. </tr>
</strong>
<tr>
	<td colspan="2">
<tr><td colspan=2><table width="90%" border=".2" align="center" class="box">
<tr><th colspan=3>Sponsorship, promotion, and corporate giving policies </th>
<tr valign="bottom">
<th width="60%">Target org name</th>
	<th>Joint partners (if applicable)</th>
	</tr>
<cfloop query="promo">
<tr>
	<td>#target#</td>
	<td align="center">#jps_orgs# &nbsp;</td>
	</tr></cfloop>

	<tr>
	<td colspan=2><strong>Total ## Org Policies: #promo.recordcount#</strong></td>
	</tr>
	</table></td></tr>




<tr>
	<td>Status of outcome</td>
	<td width="85%">Select "Met" if the number of policies adopted (in the table above) is at least as high as the projected number.<br>
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
<cfif ((isdefined("url.usid") and session.userid EQ url.usid ) or (not isDefined("url.usid")) AND (QRptbasics.recordcount EQ 0 OR QRptbasics.complete NEQ 1))>
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
<cfif read is 0>
<textarea name="orgfeedback" cols=130 rows=5 readonly class="readonly">#getdeets.orgfeedback#</textarea>
<cfelse>
<textarea name="orgfeedback" cols=130 rows=5>#getdeets.orgfeedback#</textarea>
</cfif></TD></TR></TABLE>
<div align="left">
<cfif read is 0>
	<input type="button" value="Save" class="AddButton" onClick="setLoc('sv99');">
	<cfelse>
	<input type="button" value="Save" class="AddButton" onClick="setLoc2('sv99');">
</cfif>
</div>

<p></p>
<table  width="70%" border=".2" class="box">
	<cfif session.fy GT 2008>
		<tr><td colspan="2"><div align="center"><h3>SMART outcome 5</h3></div></td></tr>
	</cfif>
<tr>
	<td colspan="2"><a name="sv3"></a><strong><span style="text-decoration : underline;">Magazine Mailing to AG:</span></strong><br>
		<i>Enter projected number from your workplan</i><br>
	<strong>By <cfif session.fy LT 2009>March<cfelse>July 31</cfif>, #session.fy#, <input type="text" name="agnum1" size=6 value="<cfif getdeets.agnum1 EQ ''>0<cfelse>#getdeets.agnum1#</cfif>" <cfif read is 1>readonly class="readonly"</cfif>> letters will be sent to the AG requesting the expansion of the Tobacco Advertisement Free Magazine Arrangement to include Ebony, Essence, Jet, Field and Stream, Outdoor Life and Popular Science in magazines delivered to schools. </strong>
<tr>
	<td colspan="2">
		<i>Enter the number of letters that you sent to the AG regarding magazines</i><br>
	<input type="text" name="agnum2" size=6 value="<cfif getdeets.agnum2 EQ ''>0<cfelse>#getdeets.agnum2#</cfif>" <cfif read is 1>readonly class="readonly"</cfif>> Number of letters sent to AG  
<tr>
	<td>Status of outcome</td>
	<td width="85%">Select "Met" if the number of letters sent is at least as high as the projected number.<br>
		<input type="radio" name="agstatus" value="1" <cfif getdeets.agstatus EQ 1> checked</cfif> <cfif read is 1>disabled</cfif>>Met<br>
		<input type="radio" name="agstatus" value="0" <cfif getdeets.agstatus EQ 0> checked</cfif> <cfif read is 1>disabled</cfif>>Unmet
	</td>
</tr>

<tr>
	<td>Progress summary</td>
	<td><textarea name="agprogress" rows="5" cols="110" <cfif read is 1>readonly class="readonly"</cfif>>#getdeets.agprogress#</textarea></td>
</tr>
<tr>
	<td>Barriers</td>
	<td><textarea name="agbarriers" rows="5" cols="110" <cfif read is 1>readonly class="readonly"</cfif>>#getdeets.agbarriers#</textarea></td>
</tr>
<cfif session.fy EQ 2008>
<tr>
	<td>Plans to address barriers in the upcoming fiscal year</td>
	<td><textarea name="agactions" rows="5" cols="110" <cfif read is 1>readonly class="readonly"</cfif>>#getdeets.agactions#</textarea></td>
</tr>
</cfif>
<cfif read is 0>
<tr>
	<td>&nbsp;</td>
	<td><input type="button" value="Check Spelling" onClick="spell('document.EOYStatus.agprogress.value', 'document.EOYStatus.agbarriers.value'<cfif session.fy LT 2009>, 'document.EOYStatus.agactions.value'</cfif>)">
	</td>
</tr>
</cfif>
</table>

<TABLE class="box" WIDTH="70%"><TR><TD>
<U>TCP Feedback</U><br>
Outcome-specific comments: <br>
<cfif read is 0>
<textarea name="agfeedback" cols=130 rows=5 readonly class="readonly">#getdeets.agfeedback#</textarea>
<cfelse>
<textarea name="agfeedback" cols=130 rows=5>#getdeets.agfeedback#</textarea>
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
<cfif session.fy GT 2008><tr><Td colspan="2"><div align="center"><h3>SMART outcome 6</h3></div></Td></tr></cfif>
<tr>
	<td colspan="2"><a name="sv4"></a>
<strong><span style="text-decoration : underline;">Magazine Resolution– School Board/Parent Group:</span> By <cfif session.fy LT 2009>March<cfelse>July 31</cfif>, #session.fy#, at least 1 school board or parent group per county will adopt a resolution supporting the expansion of the Tobacco Advertisement Free Magazine Arrangement to include Ebony, Essence, Jet, Field and Stream, Outdoor Life and Popular Science.<tr>
</strong>	<td colspan="2">
<tr><td colspan=2><table width="90%" border=".2" align="center" class="box">
<tr><th colspan=2>Magazine Advocacy resolutions </th>
<tr valign="bottom">
<th width="60%">Target org name</th>
	<th>Joint partners (if applicable)</th>
	</tr>
<cfloop query="mags">
<tr>
	<td>#target#</td>
	<td align="center">#jps_orgs# &nbsp;</td>
	</tr></cfloop>
	<tr>
	<td colspan=2><strong>Total ## Org Resolutions: #mags.recordcount#</strong></td>
	</tr>
	</table></td></tr>




<tr>
	<td>Status of outcome</td>
	<td width="85%">Select "Met" if the table above shows at least one resolution per county in your catchment area.<br>
		<input type="radio" name="sbstatus" value="1" <cfif getdeets.sbstatus EQ 1> checked</cfif> <cfif read is 1>disabled</cfif>>Met<br>
		<input type="radio" name="sbstatus" value="0" <cfif getdeets.sbstatus EQ 0> checked</cfif> <cfif read is 1>disabled</cfif>>Unmet
	</td>
</tr>

<tr>
	<td>Progress summary</td>
	<td><textarea name="sbprogress" rows="5" cols="110" <cfif read is 1>readonly class="readonly"</cfif>>#getdeets.sbprogress#</textarea></td>
</tr>
<tr>
	<td>Barriers</td>
	<td><textarea name="sbbarriers" rows="5" cols="110" <cfif read is 1>readonly class="readonly"</cfif>>#getdeets.sbbarriers#</textarea></td>
</tr>
<cfif session.fy EQ 2008>
<tr>
	<td>Plans to address barriers in the upcoming fiscal year</td>
	<td><textarea name="sbactions" rows="5" cols="110" <cfif read is 1>readonly class="readonly"</cfif>>#getdeets.sbactions#</textarea></td>
</tr></cfif>
<cfif read is 0>
<tr>
	<td>&nbsp;</td>
	<td><input type="button" value="Check Spelling" onClick="spell('document.EOYStatus.sbprogress.value', 'document.EOYStatus.sbbarriers.value'<cfif session.fy LT 2009>, 'document.EOYStatus.sbactions.value'</cfif>)">
	</td>
</tr>
</cfif>
</table>

<TABLE class="box" WIDTH="70%"><TR><TD>
<U>TCP Feedback</U><br>
Outcome-specific comments: <br>
<cfif read is 0>
<textarea name="sbfeedback" cols=130 rows=5 readonly class="readonly">#getdeets.sbfeedback#</textarea>
<cfelse>
<textarea name="sbfeedback" cols=130 rows=5>#getdeets.sbfeedback#</textarea>
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
<cfif session.fy GT 2008>
<tr><td colspan="2"><div align="center"><h3>SMART outcome 7</h3></td></tr>
</cfif>
<tr>
	<td colspan="2"><a name="sv5"></a>
<strong><span style="text-decoration : underline;">SFM Resolution - Municipality/Parent Group:</span> By July 31, #session.fy# at least 1 municipality or parent group will adopt a Smokefree Movie (SFM) resolution <cfif session.fy GT 2008> and this resolution will be mailed to MPAA, movie studios, and the Attorney General’s office</cfif>.	</td>
</strong></tr>
	<td colspan="2">
<tr><td colspan=2><table width="90%" border=".2" align="center" class="box">
<tr><th colspan=2>Movie resolutions  </th>
<tr valign="bottom">
<th width="60%">Target org name</th>
	<th>Joint partners (if applicable)</th>
	</tr>
<cfloop query="movies">
<tr>
	<td>#target#</td>
	<td align="center">#jps_orgs# &nbsp;</td>
	</tr></cfloop>

	<tr>
	<td colspan=2><strong>Total ## Org resolutions: #movies.recordcount#</strong></td>
	</tr>
	</table></td></tr>

<tr>
	<td>Status of outcome</td>
	<td width="85%">Select "Met" if the table above shows at least one resolution<cfif session.fy GT 2008> and all resolutions were mailed to MPAA, movie studios, and the Attorney General’s office</cfif>.<br>
		<input type="radio" name="sfmstatus" value="1" <cfif getdeets.sfmstatus EQ 1> checked</cfif> <cfif read is 1>disabled</cfif>>Met<br>
		<input type="radio" name="sfmstatus" value="0" <cfif getdeets.sfmstatus EQ 0> checked</cfif> <cfif read is 1>disabled</cfif>>Unmet
	</td>
</tr>

<tr>
	<td>Progress summary</td>
	<td><textarea name="sfmprogress" rows="5" cols="110" <cfif read is 1>readonly class="readonly"</cfif>>#getdeets.sfmprogress#</textarea></td>
</tr>
<tr>
	<td>Barriers</td>
	<td><textarea name="sfmbarriers" rows="5" cols="110" <cfif read is 1>readonly class="readonly"</cfif>>#getdeets.sfmbarriers#</textarea></td>
</tr>
<cfif session.fy EQ 2008>
<tr>
	<td>Plans to address barriers in the upcoming fiscal year</td>
	<td><textarea name="sfmactions" rows="5" cols="110" <cfif read is 1>readonly class="readonly"</cfif>>#getdeets.sfmactions#</textarea></td>
</tr>
</cfif>
<cfif read is 0>
<tr>
	<td>&nbsp;</td>
	<td><input type="button" value="Check Spelling" onClick="spell('document.EOYStatus.sfmprogress.value', 'document.EOYStatus.sfmbarriers.value'<cfif session.fy LT 2009>, 'document.EOYStatus.sfmactions.value'</cfif>)">
	</td>
</tr>
</cfif>
</table>

<TABLE class="box" WIDTH="70%"><TR><TD>
<U>TCP Feedback</U><br>
Outcome-specific comments: <br>
<cfif read is 0><textarea name="sfmfeedback" cols=130 rows=5 readonly class="readonly">#getdeets.sfmfeedback#</textarea>
<cfelse>
<textarea name="sfmfeedback" cols=130 rows=5>#getdeets.sfmfeedback#</textarea>
</cfif></TD></TR></TABLE>
<div align="left">
<cfif read is 0>
	<input type="button" value="Save" class="AddButton" onClick="setLoc('sv5');">
	<cfelse>
	<input type="button" value="Save" class="AddButton" onClick="setLoc2('sv5');">
</cfif>
</div>

<cfif session.fy EQ 2008>
<p></p>
<table  width="70%" border=".2" class="box">
<tr>
	<td colspan="2"><a name="sv6"></a>
<strong><span style="text-decoration : underline;">SFM Resolution Mailing to AG:</span> By July 31, 2008, all resolutions obtained by partners will be mailed to MPAA, movie studios, and the Attorney General's office.	</td>
</strong></tr>
	<td colspan="2">

<!--- suppressed table as per BBown comments 7/15/08 dmp --->
<!--- <tr><td colspan=2><table width="50%" border=".2" align="center" class="box">
<tr><td colspan=4>Smoke-free movie mailings to MPAA and AG
<tr valign="bottom">
<th>Mailings to MPAA/AG </th>
<th>Letters/petitions </th>
	<th>Month</th>
	</tr>
	<cfset sums = 0>
<cfloop query="mpaa">
<cfset tot = #numletters# + #numpet#>
<tr>
	<td>#activity#</td>
	<td align="center">#evaluate(tot)#</td>
	<td align="center">#mon#</td>

	</tr>
<cfset sums = #sums# + #tot#>	
	</cfloop>
	<tr>
	<td align="left">Total:</td>
	<td align="center">#sums#</td>
	<td align="center">&nbsp;</td>
	</tr>
	</table></td></tr>
 --->

<tr>
	<td>Status of outcome</td>
	<td width="85%">Select "Met" if all resolutions obtained were mailed to the MPAA, movie studios, and the Attorney General's office.<br>
		<input type="radio" name="mpaastatus" value="1" <cfif getdeets.mpaastatus EQ 1> checked</cfif> <cfif read is 1>disabled</cfif>>Met<br>
		<input type="radio" name="mpaastatus" value="0" <cfif getdeets.mpaastatus EQ 0> checked</cfif> <cfif read is 1>disabled</cfif>>Unmet
	</td>
</tr>

<tr>
	<td>Progress summary</td>
	<td><textarea name="mpaaprogress" rows="5" cols="110" <cfif read is 1>readonly class="readonly"</cfif>>#getdeets.mpaaprogress#</textarea></td>
</tr>
<tr>
	<td>Barriers</td>
	<td><textarea name="mpaabarriers" rows="5" cols="110" <cfif read is 1>readonly class="readonly"</cfif>>#getdeets.mpaabarriers#</textarea></td>
</tr>
<tr>
	<td>Plans to address barriers in the upcoming fiscal year</td>
	<td><textarea name="mpaaactions" rows="5" cols="110" <cfif read is 1>readonly class="readonly"</cfif>>#getdeets.mpaaactions#</textarea></td>
</tr>
<cfif read is 0><tr>
	<td>&nbsp;</td>
	<td><input type="button" value="Check Spelling" onClick="spell('document.EOYStatus.mpaaprogress.value', 'document.EOYStatus.mpaabarriers.value'<cfif session.fy LT 2009>, 'document.EOYStatus.mpaaactions.value'</cfif>)">
	</td>
</tr>
</cfif>
</table>

<TABLE class="box" WIDTH="70%"><TR><TD>
<U>TCP Feedback</U><br>
Outcome-specific comments: <br>
<cfif read is 0><textarea name="mpaafeedback" cols=130 rows=5 readonly style="readonly" class="readonly">#getdeets.mpaafeedback#</textarea>
<cfelse>
<textarea name="mpaafeedback" cols=130 rows=5>#getdeets.mpaafeedback#</textarea>
</cfif></TD></TR></TABLE>
<div align="left">
<cfif read is 0>
	<input type="button" value="Save" class="AddButton" onClick="setLoc('sv6');">
	<cfelse>
	<input type="button" value="Save" class="AddButton" onClick="setLoc2('sv6');">
</cfif>
</div>
</cfif>



<p></p>
<table  width="70%" border=".2" class="box">
	<cfif session.fy GT 2008>
		<tr><td colspan="2"><div align="center"><h3>SMART Outcome 8</h3></div></td></tr>
	</cfif>
<tr>
	<td colspan="2"><a name="sv7"></a>
<strong><span style="text-decoration : underline;">Infrastructure:</span> Coordinator will participate in meetings, conferences and trainings, network with other partners and partner agencies and complete TCP sustainability tasks in order to enhance program functioning, staff development, and support.</strong></td>
</tr>
</cfoutput>
<tr><td colspan=2><table width="50%" border=".2" align="center" class="box">
<tr><td>
<tr valign="bottom">
<th>Conducted sustainability activity?</th>
	<th>Sustainability activities</th>
	</tr>
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
	Select "Met" <cfif Session.fy EQ 2008>if you participated in meetings, conferences, trainings, networking, and sustainability tasks<cfelse>if you participated in meetings, conferences, trainings, and networking AND if 3 out of 4 sustainability activities are checked in the table above</cfif>.<br>
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
	<td><textarea name="coordactions" rows="5" cols="110" <cfif read is 1>readonly class="readonly"</cfif>>#getdeets.coordactions#</textarea></td>
</tr>
</cfif>
<cfif read is 0><tr>
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



<!--- <cfset read = 0> --->
<p></p>
<table  width="70%" border=".2" class="box">
	<cfif session.fy GT 2008>
		<tr><td colspan="2"><div align="center"><h3>SMART Outcome 9</h3></div></td></tr>
	</cfif>
<tr>
	<td colspan="2">
	<a name="sv8"></a>
<div id="set_of_links"><strong><span style="text-decoration : underline;">Outdoor Policies:</span></strong><br>
	<i>Enter projected number from your workplan</i><br>
<strong>By July 31, #session.fy#, <input type="text" name="govtnum" value="<cfif getdeets.govtnum EQ ''>0<cfelse>#getdeets.govtnum#</cfif>" size=4 <cfif read is 1>readonly class="readonly"</cfif>> ## of governmental, private, or other organizations will adopt policies prohibiting tobacco use in outdoor areas.
</strong>	<br>
<div id="div" class="divs">
      <input type="checkbox" value="1" name="govt" id="govt" <cfif getdeets.govt EQ 1> checked</cfif> onclick="show_other (this, 'tab1');" <cfif read is 1>disabled</cfif>> Partner addressed this optional outcome </td>
</tr>

</div>
<table border="1" id="tab1" style="display:none"  width="70%" border=".2" class="box">


	<td colspan="2">
<tr><td colspan=2><table id="256c" width="50%" border=".2" align="center" class="box">
<tr><th colspan=2>Outdoor policies</th></tr>
<tr valign="bottom">
<th>Target org name </th>
	<th>Joint partners (if applicable)</th>
	</tr>
<cfloop query="outdoor">
<tr>
	<td>#target#</td>
	<td align="center">#jps_orgs#</td>

	</tr></cfloop>
	<tr>
	<td colspan=2 align="left"><strong>Total ## Org Policies: #outdoor.recordcount#</strong></td>
		
	</tr>
	</table></td></tr>
</div>
<tr>
	<td>Status of outcome</td>
	<td width="85%">Select "Met" if the table above shows at least as many policies as your projected target.<br>
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
<cfif session.fy EQ 2008>
<tr>
	<td>Plans to address barriers in the upcoming fiscal year</td>
	<td><textarea name="govtactions" rows="5" cols="110" <cfif read is 1>readonly class="readonly"</cfif>>#getdeets.govtactions#</textarea></td>
</tr>
</cfif>
<cfif read is 0><tr>
	<td>&nbsp;</td>
	<td><input type="button" value="Check Spelling" onClick="spell('document.EOYStatus.govtprogress.value', 'document.EOYStatus.govtbarriers.value'<cfif session.fy LT 2009>, 'document.EOYStatus.govtactions.value'</cfif>)">
	</td>
</tr>
</cfif>
<TR><TD colspan=2>
<U>TCP Feedback</U><br>
Outcome-specific comments: <br>
<cfif read is 0><textarea name="govtfeedback" cols=130 rows=5 readonly class="readonly">#getdeets.govtfeedback#</textarea>
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
<p></p>
<!--- <table  width="80%" border=".2" class="box">
<tr>
	<td colspan="2">SMART Outcome:	</td>
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
	<input type="button" value="Save" class="AddButton" onClick="checkContAmt();">
</div>
</cfif>

 --->
 <p></p>







<!--- temp. suppressed due to functionality issues 7/15/08 dmp --->
<!--- 
 <table border="1" width="70%" border=".2" class="box">
<tr>
	<td colspan="2">
<input type="text" name="newoutcome" size=60> <input type="submit" value="Add new outcome" onClick="checkContAmt();">	
</td></tr></table>
<cfset cnt = 0>
<cfloop query="getcustom">
<cfset cnt = cnt + 1>
<cfif getcustom.outcome is not ''>
<table border="1" width="70%" border=".2" class="box">
<input type="hidden" name="newoutcome" value="#getcustom.outcome#">
<tr>
	<td colspan="2">
<strong>#getcustom.outcome#</strong></td>
</tr>
<tr>
	<td>Status of outcome</td>
	<td colspan="85%">
		<input type="radio" name="customstatus_#getcustom.outcome#" value="1" <cfif getcustom.customstatus EQ 1> checked</cfif>>Met<br>
		<input type="radio" name="customstatus_#getcustom.outcome#" value="0" <cfif getcustom.customstatus EQ 0> checked</cfif>>Unmet
	</td>
</tr>

<tr>
	<td>Progress summary</td>
	<td><textarea name="customprogress_#getcustom.outcome#" rows="5" cols="110">#customprogress#</textarea></td>
</tr>
<tr>
	<td>Barriers</td>
	<td><textarea name="custombarriers_#getcustom.outcome#" rows="5" cols="110">#custombarriers#</textarea></td>
</tr>
<tr>
	<td>Plans to address barriers in the upcoming fiscal year</td>
	<td><textarea name="customactions_#getcustom.outcome#" rows="5" cols="110">#customactions#</textarea></td>
</tr>
<cfif ((isdefined("url.usid") and session.userid EQ url.usid ) or (not isDefined("url.usid")) AND (QRptbasics.recordcount EQ 0 OR QRptbasics.complete NEQ 1))>
<tr>
	<td>&nbsp;</td>
	<td><input type="button" value="Check Spelling" onClick="spell('document.EOYStatus.customprogress_#getcustom.outcome#.value', 'document.EOYStatus.custombarriers_#getcustom.outcome#.value', 'document.customactions_#getcustom.outcome#.value')">
	</td>
</tr>
</cfif>
<TR><TD colspan=2>
<U>TCP Feedback</U><br>
Outcome specific comments: <br>
<cfif SESSION.CessMan is "0"><textarea name="customfeedback-#getcustom.outcome#" cols=130 rows=5 readonly>#customfeedback#</textarea>
<cfelse>
<textarea name="customfeedback_#getcustom.outcome#" cols=130 rows=5>#customfeedback#</textarea>
</cfif></TD></TR></TABLE>
<cfif ((isdefined("url.usid") and session.userid EQ url.usid ) or (not isDefined("url.usid")) AND (QRptbasics.recordcount EQ 0 OR QRptbasics.complete NEQ 1))>

<div align="left">
	<input type="button" value="Save" class="AddButton" onClick="checkContAmt();">
</div><p></p>
</cfif></cfif></cfloop></table>

 --->


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
<a name="sv9"></a>
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
	<td colspan="2"><input type="button" value="Check Spelling" onClick="spell('document.EOYStatus.retailfeedback.value','document.EOYStatus.munifeedback.value','document.EOYStatus.agfeedback.value','document.EOYStatus.orgfeedback.value','document.EOYStatus.sbfeedback.value','document.EOYStatus.sfmfeedback.value','document.EOYStatus.mpaafeedback.value','document.EOYStatus.govtfeedback.value','document.EOYStatus.coordfeedback.value','document.EOYStatus.customfeedback.value','document.EOYStatus.tcpfeedback.value')">
	</td>
</tr>

<tr><Td>

<cfif isdefined("usid")>
<div align="left">
	<input  type="button" value="Save" class="AddButton" onClick="setLoc('sv12');">
</div>
</cfif></Td></tr>

<tr>
	<td colspan="2">
		<div align="left">
			
<cfif isdefined("usid")>			
<CFIF getdeets.TCP_status GT 0>
	<input type="button" value="Feedback Submitted" class="DelButton"  onClick="setSave2(); setLoc2('sv99');">
		<cfelse>
	
	<input type="button" value="Submit Feedback" class="AddButton" onClick="setSave2(); setLoc2('sv99');">
	</CFIF>
</cfif>
<cfif Audit2.recordcount GT 0>
	<br><cfloop query="Audit2">
	Reviewed #dateformat(Audit2.dtstmp, "m/d/yyyy")# <br>
	</cfloop>
	</cfif>
</div>
</td>
</tr>
</cfif>

</cfoutput>
<!--- </cfform> --->
</body></html>

<script language="javascript">

show_other2 ('govt', 'tab1');
</script>

