<cfif isDefined("url.addupdBL") or isDefined("URL.delline")>
	<cfinclude template="prc_CCAdvoc_baseline.cfm">
<cfelseif isDefined("url.id3")>
<cfquery datasource="#application.DataSource#" 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qcheckdata">

select
b.thcpo,
b.year2, month2,
writtenP, writtenP_det,
ep_1, ep_2, ep_3, ep_4, ep_5, 
idSys, idSys_det,
TDTC,
promote_couns,
provide_res,
compliance, compliance_det,
feedback, 
policies, policies_date,
cess_assist,
comments,
case 
	 when unit IS NULL then NAME
	 else unit + ' ' + NAME
	end as unitname 

from advocCC_baselines b, collaborators c
where c.seq=b.thcpo
and b.userid=<cfqueryparam cfsqltype="cf_sql_varchar" value="#session.userid#">
and b.year2=<cfqueryparam cfsqltype="cf_sql_integer" value="#session.fy#">
<!--- and month2=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.month2#"> --->
and b.seq=<cfqueryparam cfsqltype="cf_sql_integer" value="#url.id3#">
<!--- and strategy=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.activity2#"> --->
</cfquery>


</cfif>



<script language="javascript">
      function show_other (divname, shide) {
             var textField_div = document.getElementById(divname);
            if ( shide == 'show' ) {
                  // show other text box
                  textField_div.style.display = "block";

            } else {
                  // hide other text box
                  textField_div.style.display = "none";
                 // textField.value = "";
            }
      }
     function show_other2 (fieldstat, divname) {
     	     var textField_div = document.getElementById(divname);
     	     var textField = eval(fieldstat);
     	     
     	    if (textField[1].checked==true) {
     	         // show other text box
                  textField_div.style.display = "block";
                  //textField_div.style.display=''

            } else {
            	  // hide other text box
                 textField_div.style.display = "none";
                 //textField_div.style.display='none'
                 // textField.value = "";
            }
      }

      function validateMe(){
      	document.cess.action="cess1.cfm?handler=six&addupdBL=1&<cfoutput>#session.urltoken#</cfoutput>";
      	return true;
      }

function validateMe2(){
      	document.cess.action="cess1.cfm?handler=six&addupdBL=1&<cfoutput>#session.urltoken#</cfoutput>";
      	
      	if(document.cess.BLcollabs.selectedIndex==0){
      		alert('Please make sure to select a Target HCPO')
     	return false;
      	}
      	return true;
      }

      function deleteentries(){      
      document.cess.action="cess1.cfm?handler=six&delline=1&<cfoutput>#session.urltoken#</cfoutput>";
      return true;
      }


function checkpolBL(){
if (document.cess.polBL[0].checked){
 for (i = 0; i < document.cess.polBL.length; i++){
  document.cess.polBL[i].checked = false;
  document.cess.polBL[i].disabled = true;
}
document.cess.polBL[0].checked = true;
document.cess.polBL[0].disabled = false;
}
else{
for (i = 0; i < document.cess.polBL.length; i++){
 document.cess.polBL[i].disabled = false;
}
}

}
</script>

<!--- <cfquery datasource="#application.DataSource#"  	
			
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qcollaborators_PIP">
	select name, type, county, seq,
	case 
	 when unit IS NULL then NAME
	 else unit + ' ' + NAME
	end as unitname 
	  from collaborators 
	where  userid = '#session.userid#'
	and (del is null or del != 1)
	and timprovement=1
	order by 5
	
</cfquery> --->

<cfquery datasource="#application.DataSource#" 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QlistBL">
select a.seq as seq, c.seq as seq2,
case 
	 when unit IS NULL then NAME
	 else unit + ' ' + NAME
	end as unitname , month2, a.year2
from advocCC_baselines a, collaborators c
where a.userid=c.userid
and c.seq=a.thcpo
and c.userid=<cfqueryparam cfsqltype="cf_sql_varchar" value="#session.userid#">
order by case 
	 when unit IS NULL then NAME
	 else unit + ' ' + NAME
	end

<!--- and a.year2=<cfqueryparam cfsqltype="cf_sql_integer" value="#session.fy#">
and a.month2=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.month2#"> --->

</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QcollaboratorsNoBaseline">
	select name, type, county, seq,
	case 
	 when unit IS NULL then NAME
	 else unit + ' ' + NAME
	end as unitname 
	  from collaborators 
	where  userid = '#session.userid#'
	and (del is null or del != 1)
	and seq not in (select thcpo from advocCC_baselines)
	order by 5
	
</cfquery>
<tr>
	<th colspan="3">Baseline Assessment</th>
</tr>
<tr>
	
	<td valign="top" colspan="3">Target HCPO: 
	<cfif isDefined("URL.id3") and (NOT isDefined("form.newT") OR (isDefined("form.newT") AND form.newT NEQ "new"))>
		<input type="hidden" name="BLcollabs" value="<cfoutput>#Qcheckdata.thcpo#</cfoutput>">
		<strong><cfoutput>#Qcheckdata.unitname#</cfoutput></strong>
	<cfelse>	
	<select name="BLcollabs">
	<option value="" selected>
	<cfoutput>
	<cfloop query="QcollaboratorsNoBaseline">
	<option value="#seq#">#unitname#
	</cfloop>
	</cfoutput>
	</select> 
	</cfif>	
	</td>
</tr>


<cfquery datasource="#application.DataSource#" 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QWrittenP">
select descr, id
from lu_baseline_written
where year2=#session.fy#
and del is null
order by rank
</cfquery>

<cfquery datasource="#application.DataSource#" 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QidSys">
select descr, id
from lu_baseline_idsys
where year2=#session.fy#
and del is null
order by rank
</cfquery>

<cfquery datasource="#application.DataSource#" 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qcoord">
select descr, id
from lu_baseline_coord
where year2=#session.fy#
and del is null
order by rank
</cfquery>

<cfquery datasource="#application.DataSource#" 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qcompliance">
select descr, id
from lu_baseline_compliance
where year2=#session.fy#
and del is null
order by rank
</cfquery>

<cfquery datasource="#application.DataSource#" 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qpolicies">
select descr, id
from lu_baseline_policies
where year2=#session.fy#
and del is null
order by rank
</cfquery>

<input type="hidden" name="newT" value="">
<!--- <input type="hidden" name="month" value="<cfoutput>#Qcheckdata.month2#</cfoutput>"> --->

<tr>
	<td colspan="2">Does the organization have a written policy or written standard of care on tobacco dependence treatment?</td>
	<td>
	<input type="radio" name="writtenP" id="writtenP" value="0" onclick="show_other('d_writtenP', 'hide');"  <cfif isDefined("QcheckData") and QcheckData.writtenP EQ 0> checked</cfif>> No<br>
	<input type="radio" name="writtenP" id = "writtenP" value="1" onclick="show_other('d_writtenP', 'show');" <cfif isDefined("QcheckData") and QcheckData.writtenP EQ 1> checked</cfif>> Yes<br>
	<div id="d_writtenP">
		<br>Does the written policy, procedure, or guideline include:<br>
	<cfoutput>
	<cfloop query="QWrittenP">
	&nbsp; <input type="checkbox" name="writtenP_det" value="#id#" <cfif isDefined("QcheckData") and listcontains(QcheckData.writtenP_det,id)> checked</cfif>>#descr#<br>
	</cfloop>
	</cfoutput>	
	</div>
	
	
	
	</td>
</tr>

<tr>
	<td colspan="2">Do the organization's practices ensure that...</td>
	<td>&nbsp;</td>
</tr>

<tr>
	<td>&nbsp;</td>
	<td>Every patient is screened for tobacco use?</td>
	<td>
	<input type="radio" name="ep_1" value="0"  <cfif isDefined("QcheckData") and QcheckData.ep_1 EQ 0> checked</cfif>> No<br>
	<input type="radio" name="ep_1" value="1"  <cfif isDefined("QcheckData") and QcheckData.ep_1 EQ 1> checked</cfif>> Yes<br>
	</td>
</tr>

<tr>
	<td>&nbsp;</td>
	<td>Every tobacco user is provided with brief counseling?</td>
	<td>
	<input type="radio" name="ep_2" value="0"  <cfif isDefined("QcheckData") and QcheckData.ep_2 EQ 0> checked</cfif>> No<br>
	<input type="radio" name="ep_2" value="1"  <cfif isDefined("QcheckData") and QcheckData.ep_2 EQ 1> checked</cfif>> Yes<br>
	</td>
</tr>
<tr>
	<td>&nbsp;</td>
	<td>Every tobacco user is provided a referral?</td>
	<td>
	<input type="radio" name="ep_3" value="0"  <cfif isDefined("QcheckData") and QcheckData.ep_3 EQ 0> checked</cfif>> No<br>
	<input type="radio" name="ep_3" value="1"  <cfif isDefined("QcheckData") and QcheckData.ep_3 EQ 1> checked</cfif>> Yes<br>
	</td>
</tr>

<tr>
	<td>&nbsp;</td>
	<td>Every tobacco user is provided follow-up?</td>
	<td>
	<input type="radio" name="ep_4" value="0"  <cfif isDefined("QcheckData") and QcheckData.ep_4 EQ 0> checked</cfif>> No<br>
	<input type="radio" name="ep_4" value="1"  <cfif isDefined("QcheckData") and QcheckData.ep_4 EQ 1> checked</cfif>> Yes<br>
	</td>
</tr>

<tr>
	<td>&nbsp;</td>
	<td>Every tobacco user is offered pharmacotherapy (unless contraindicated)?</td>
	<td>
	<input type="radio" name="ep_5" value="0"  <cfif isDefined("QcheckData") and QcheckData.ep_5 EQ 0> checked</cfif>> No<br>
	<input type="radio" name="ep_5" value="1"  <cfif isDefined("QcheckData") and QcheckData.ep_5 EQ 1> checked</cfif>> Yes<br>
	</td>
</tr>

<!--- <tr>
	<td>&nbsp;</td>
	<td>Does the organization have an identification system to document the smoking status of every patient?</td>
	<td>
	<input type="radio" name="ep_6" value="0" <cfif isDefined("QcheckData") and QcheckData.ep_6 EQ 0> checked</cfif> > No<br>
	<input type="radio" name="ep_6" value="1" <cfif isDefined("QcheckData") and QcheckData.ep_6 EQ 1> checked</cfif>> Yes<br>
	</td>
</tr> --->

<tr>	
	<td colspan="2">Does the organization have an identification system to document the smoking status of every patient?</td>
	<td>
	<input type="radio" name="idSys" value="0" onclick="show_other('d_idSys', 'hide');" <cfif isDefined("QcheckData") and QcheckData.idSys EQ 0> checked</cfif>> No<br>
	<input type="radio" name="idSys" value="1" onclick="show_other('d_idSys', 'show');" <cfif isDefined("QcheckData") and QcheckData.idSys EQ 1> checked</cfif>> Yes<br>
	<div id="d_idSys">
		<br>If yes, <strong>select all that apply</strong><br>
	<cfoutput>
	<cfloop query="QidSys">
	&nbsp; <input type="checkbox" name="idSys_det" value="#id#" <cfif isDefined("QcheckData") and listcontains(QcheckData.idSys_det,id)> checked</cfif>>#descr#<br>
	</cfloop>
	</cfoutput>
	</div>
	</td>
</tr>

<tr>
	<td colspan="2">Does the organization have a staff person assigned as the Tobacco Dependence Treatment Coordinator?</td>
	<td>
	<input type="radio" name="TDTC" value="0"  <cfif isDefined("QcheckData") and QcheckData.tdtc EQ 0> checked</cfif>> No<br>
	<input type="radio" name="TDTC" value="1"  <cfif isDefined("QcheckData") and QcheckData.tdtc EQ 1> checked</cfif>> Yes<br>
	</td>
</tr>

<tr>
	<td colspan="2">Does the organization provide cessation education to clinicians and staff to promote counseling with tobacco-using patients?</td>
	<td>
	<cfoutput>
	<cfloop query="Qcoord">
	&nbsp; <input type="radio" name="promote_couns" value="#id#" <cfif isDefined("QcheckData") and listcontains(QcheckData.promote_couns,id)> checked</cfif>>#descr#<br>
	</cfloop>
	</cfoutput>
	</td>
</tr>

<tr>
	<td colspan="2">Does the organization provide resources and materials to clinicians / staff to promote screening and brief counseling with tobacco-using patients</td>
	<td>
	<cfoutput>
	<cfloop query="Qcoord">
	&nbsp; <input type="radio" name="provide_res" value="#id#" <cfif isDefined("QcheckData") and listcontains(QcheckData.provide_res,id)> checked</cfif>>#descr#<br>
	</cfloop>
	</cfoutput>
	</td>
</tr>

<tr>
	<td colspan="2">Does the organization assess provider compliance with the tobacco dependence treatment policy, procedure, or guideline?
	<br>If yes, how is compliance assessed?
	</td>
	<td>
	<input type="radio" name="compliance" value="0" onclick="show_other('d_compliance', 'hide');" <cfif isDefined("QcheckData") and QcheckData.compliance EQ 0> checked</cfif>> No<br>
	<input type="radio" name="compliance" value="1" onclick="show_other('d_compliance', 'show');" <cfif isDefined("QcheckData") and QcheckData.compliance EQ 1> checked</cfif>> Yes<br>
	<div id="d_compliance">
	<br>If yes, <strong>select all that apply</strong><br>
	<cfoutput>
	<cfloop query="Qcompliance">
	&nbsp; <input type="checkbox" name="compliance_det" value="#id#" <cfif isDefined("QcheckData") and listcontains(QcheckData.compliance_det,id)> checked</cfif>>#descr#<br>
	</cfloop>
	</cfoutput>
	
	</div>
	
	
	
	</td>
</tr>

<tr>
	<td colspan="2">Does the organization routinely provide feedback (e.g., report cards) to providers?</td>
	<td>
	<input type="radio" name="feedback" value="0"  <cfif isDefined("QcheckData") and QcheckData.feedback EQ 0> checked</cfif>> No<br>
	<input type="radio" name="feedback" value="1"  <cfif isDefined("QcheckData") and QcheckData.feedback EQ 1> checked</cfif>> Yes<br>
	</td>
</tr>

<tr>
	<td colspan="2">Which of the following best describes the current policy regarding outdoor cigarette smoking by staff, patients, and visitors at this health care organization?</td>
	<td nowrap="yes">
	<cfoutput>
	<cfloop query="Qpolicies">
	&nbsp; 
	<input type="checkbox" name="polBL" value="#id#" <cfif isDefined("QcheckData") and listcontains(QcheckData.policies,id)> checked</cfif> onClick="checkpolBL();">#descr#
	
	<cfif id EQ 1>
	<br>&nbsp;&nbsp;&nbsp;what is the effective date of this policy?<input type="text" name="polBLdate" size="12" <cfif isDefined("QcheckData") and QcheckData.policies_date NEQ "">value="<cfoutput>#dateformat(QcheckData.policies_date, 'm/d/yyyy')#</cfoutput>"</cfif>> (M/D/YYYY)<br>
	</cfif><br>
	</cfloop>
	</cfoutput>
	</td>
</tr>

<tr>
	<td colspan="2">Does the organization offer cessation assistance for employees?</td>
	<td>
	<input type="radio" name="cess_Assist" value="0"  <cfif isDefined("QcheckData") and QcheckData.cess_assist EQ 0> checked</cfif>> No<br>
	<input type="radio" name="cess_Assist" value="1"  <cfif isDefined("QcheckData") and QcheckData.cess_assist EQ 1> checked</cfif>> Yes<br>
	</td>
</tr>

<tr>
	<td colspan="2">Other comments describing policy and practice?</td>
	<td><textarea  name="comments" rows="5" cols="80"><cfif isDefined("QcheckData")><cfoutput>#QcheckData.comments#</cfoutput></cfif></textarea></td>
</tr>
<tr>
<td  colspan="3"><input type="Submit" value="Save"  class="AddButton" onclick="return validateMe2();"></td>

</tr>



<cfif QlistBL.recordcount GT 0>
<tr>
	<td colspan="3">
		<table class="box">
			<cfoutput>
			<cfloop query="QlistBL">
				<tr>
					<td><a href="cess1.cfm?handler=six&id3=<cfoutput>#QlistBL.seq#&#session.urltoken#</cfoutput>">#QlistBL.unitname# (#QlistBL.month2# FY#QlistBL.year2-1#-#QlistBL.year2#)</a></td>
					<td><input type="checkbox" name="del" value="#QlistBL.seq#">Delete?</td>
				</tr>
			</cfloop>
			<cfif QlistBL.recordcount  GTE 1>
			<tr><td colspan="2"><input type="submit" value="Delete"  class="DelButton"  onclick="return deleteentries();"></td></tr>
			</cfif>
			</cfoutput>
		</table>
	</td>

</tr>
</cfif>


<script language="javascript">
show_other2 ('document.cess.writtenP', 'd_writtenP');
show_other2 ('document.cess.idSys', 'd_idSys');
show_other2 ('document.cess.compliance', 'd_compliance');
checkpolBL();
</script>
