<cfif isDefined("url.addupd") or isDefined("URL.delline")>
	<cfinclude template="prc_CCAdvoc_PP.cfm">
<cfelseif isDefined("url.id2")>
<cfquery datasource="#application.DataSource#" 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qcheckdata">
select 
b.thcpo,
pp_pol_bit,
pp_pol_det,
pp_pol_cb,
pp_prac_bit,
pp_prac_det,
pp_prac_cb,
pp_sys_bit,
pp_sys_det,
pp_sys_cb,
pp_ed_a,
pp_ed_b,
pp_ed_det,
pp_ftq_a,
pp_ftq_det,
pp_cess_a,
pp_cess_b,
pp_cess_det,
pp_depend_a,PP_depend_b,
pp_cessAss_b,
pp_depend_det,
pp_compliance_a,
pp_compliance_det,
pp_compliance_cb,PP_compliance_cb2,
pp_feedback_a,
PP_feedback_b,
pp_feedback_det,
pp_tfp_a,
pp_tfp_b,
pp_tfp_det,
pp_cessAss_a,
pp_cessAss_b,
pp_cessAss_det,
pp_trans_a,
pp_trans_det,
case 
	 when unit IS NULL then NAME
	 else unit + ' ' + NAME
	end as unitname 


from advocCC_pp b, collaborators c
where c.seq=b.thcpo
and b.userid=<cfqueryparam cfsqltype="cf_sql_varchar" value="#session.userid#">
and b.year2=<cfqueryparam cfsqltype="cf_sql_integer" value="#session.fy#">
<!--- and month2=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.month2#"> --->
and b.seq=<cfqueryparam cfsqltype="cf_sql_integer" value="#url.id2#">
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
     	     var textField = document.getElementById(fieldstat);
     	    if (textField.checked==true) {
                  // show other text box
                  //textField_div.style.display = "block";
                  textField_div.style.display=''

            } else {
            	  // hide other text box
                  //textField_div.style.display = "none";
                 textField_div.style.display='none'
                 // textField.value = "";
            }
      }
      
      function validateMe(){
      	document.cess.action="cess1.cfm?handler=seven&addupd=1&<cfoutput>#session.urltoken#</cfoutput>";
      	return true;
      }
      
 function validateMe2(){
      	document.cess.action="cess1.cfm?handler=seven&addupd=1&<cfoutput>#session.urltoken#</cfoutput>";
      	if(document.cess.PPcollabs.selectedIndex==0){
      		alert('Please make sure to select a Target HCPO')
     	return false;
      	}
      	if (document.cess.PP_prac_bit.checked==true){
      	var status = 0
      	for (i=0; i<document.cess.PP_prac_cb.length; i++){
      	if (document.cess.PP_prac_cb[i].checked==true){
      	status += 1;      	
      	}
      	}
      	if (status == 0){
      	alert('Under Practice, please indicate that at least one practice has actually changed')
      	return false;
      	}
      	}
      	return true;
      }
      
      function deleteentries(){      
      document.cess.action="cess1.cfm?handler=seven&delline=1&<cfoutput>#session.urltoken#</cfoutput>";
      return true;
      }

</script>
<tr>
	<th colspan="3">Policy and Practice Changes</th>
</tr>

<tr>
	<td valign="top" colspan="3">
		
	Target HCPO: 
	<cfif isDefined("URL.id2") and (NOT isDefined("form.newT") OR (isDefined("form.newT") AND form.newT NEQ "new"))>
		<input type="hidden" name="PPcollabs" value="<cfoutput>#Qcheckdata.thcpo#</cfoutput>">
		<strong><cfoutput>#Qcheckdata.unitname#</cfoutput></strong>
	<cfelse>	
	<select name="PPcollabs" >
	<option value="" <cfif NOT isDefined("Qcheckdata")>selected</cfif>>
	<cfoutput>
	<cfloop query="Qcollaborators">
	<option value="#seq#" <cfif isDefined("Qcheckdata") and Qcheckdata.tHCPO EQ seq> selected</cfif>>#unitname#
	</cfloop>
	</cfoutput>
	</select> 
	</cfif>	
	</td>
</tr>

<cfquery datasource="#application.DataSource#" 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qlist">
select a.seq as seq, c.seq as seq2,
case 
	 when unit IS NULL then NAME
	 else unit + ' ' + NAME
	end as unitname 
from advocCC_pp a, collaborators c
where a.userid=c.userid
and c.seq=a.thcpo
and c.userid=<cfqueryparam cfsqltype="cf_sql_varchar" value="#session.userid#">
and a.year2=<cfqueryparam cfsqltype="cf_sql_integer" value="#session.fy#">
and a.month2=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.month2#">

</cfquery>


<cfquery datasource="#application.DataSource#" 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qpol">
select descr, id
from lu_pp_pol
where year2=#session.fy#
and del is null
order by rank
</cfquery>

<cfquery datasource="#application.DataSource#" 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qprac">
select descr, id
from lu_pp_prac
where year2=#session.fy#
and del is null
order by rank
</cfquery>

<cfquery datasource="#application.DataSource#" 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qsys">
select descr, id
from lu_pp_sys
where year2=#session.fy#
and del is null
order by rank
</cfquery>

<cfquery datasource="#application.DataSource#" 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qmon">
select descr, id
from lu_pp_mon
where year2=#session.fy#
and del is null
order by rank
</cfquery>

<cfquery datasource="#application.DataSource#" 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QmonA">
select descr, id
from lu_pp_mon_A
where year2=#session.fy#
and del is null
order by rank
</cfquery>






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
<cfoutput>
<!--- <cfif isDefined("url.activity2")>
	<cfset form.activity2 = url.activity2>
</cfif>	 --->

<!--- <input type="hidden" name="month2" value="#form.month2#">
<input type="hidden" name="activity2" value="#form.activity2#"> --->
</cfoutput>
<input type="hidden" name="newT" value="">
<!--- <input type="hidden" name="month" value="<cfoutput>#form.month2#</cfoutput>">

<input type="hidden" name="month2" value="<cfoutput>#form.month2#</cfoutput>"> --->
<tr><th colspan="2" align="left"><br>Written policy or written standard of care</th></tr>

<tr>
	<td colspan="2">		
	<input type="checkbox" value="1" name="PP_pol_bit" id="PP_pol_bit" <cfif isDefined("QcheckData") and QcheckData.PP_pol_bit EQ 1> checked</cfif> onclick="show_other2 ('PP_pol_bit', 'd_writtenP');">HCPO updated written policy or written standard of care on tobacco dependence treatment this month</td>
	<td>		
</tr>


<tr>
	<td></td>
	<td>		
	<table id="d_writtenP" style="display:none;" class="box">
		<tr><td colspan="2">If yes, which items were included? (Check all that apply)</td></tr>
	<cfoutput>
	<cfloop query="Qpol">
	<tr><td>&nbsp;</td>
	<td><input type="checkbox" name="PP_pol_cb" value="#id#" <cfif isDefined("QcheckData") and listcontains(QcheckData.pp_pol_cb,id)> checked</cfif>>#descr#</td>
	</tr>
	</cfloop>
	</cfoutput>	
	</table>	
	</td>	
</tr>
<tr>
	<td>&nbsp;</td><td>		
	<textarea name="PP_pol_det" cols="130" rows="2"><cfif isDefined("QcheckData")><cfoutput>#QcheckData.pp_pol_det#</cfoutput></cfif></textarea>
	</td>
	<td>	
</tr>

<tr><th colspan="2" align="left"><br>Practices</th></tr>
<tr>
	<td colspan="2">		
	<input type="checkbox" value="1" name="PP_prac_bit" id="PP_prac_bit" <cfif isDefined("QcheckData") and QcheckData.PP_prac_bit EQ 1> checked</cfif>  onclick="show_other2 ('PP_prac_bit', 'd_pract');">HCPO changed practices regarding tobacco dependence identification and treatment this month</td>
	<td>		
</tr>


<tr>
	<td></td>
	<td>		
	<table  id="d_pract" style="display:none;" class="box">
		<tr>
			<td></td>
			<td>Changes to practices this month were made to ensure that:</td>
		</tr>
	<cfoutput>
	<cfloop query="Qprac">
	<tr><td>&nbsp;</td>
	<td><input type="checkbox" name="PP_prac_cb" value="#id#" <cfif isDefined("QcheckData") and listcontains(QcheckData.pp_prac_cb,id)> checked</cfif>>#descr#</td>
	</tr>
	</cfloop>
	</cfoutput>	
	</table>	
	</td>	
</tr>
<tr>
	<td>&nbsp;</td><td>			
	<textarea name="PP_prac_det" cols="130" rows="2"><cfif isDefined("QcheckData")><cfoutput>#QcheckData.pp_prac_det#</cfoutput></cfif></textarea>
	</td>
	<td>	
</tr>



<tr><th colspan="2" align="left"><br>System to document smoking status</th></tr>
<tr>
	<td colspan="2">		
	<input type="checkbox" value="1" name="PP_sys_bit" id="PP_sys_bit" <cfif isDefined("QcheckData") and QcheckData.PP_sys_bit EQ 1> checked</cfif> onclick="show_other2 ('PP_sys_bit', 'd_sys');">HCPO implemented or altered a system this month to document smoking status of every patient.</td>
	<td>		
</tr>


<tr>
	<td></td>
	<td>		
	<table id="d_sys" style="display:none;"  class="box">
		<tr>
			<td></td>
			<td>Which type of system was added or altered this month?</td>
		</tr>
		
	<cfoutput>
	<cfloop query="Qsys">
	<tr><td>&nbsp;</td>
	<td><input type="checkbox" name="pp_sys_cb" value="#id#" <cfif isDefined("QcheckData") and listcontains(QcheckData.pp_sys_cb,id)> checked</cfif>>#descr#</td>
	</tr>
	</cfloop>
	</cfoutput>	
	</table>	
	</td>	
</tr>

<tr>
	<td>&nbsp;</td><td>			
	<textarea name="PP_sys_det" cols="130" rows="2"><cfif isDefined("QcheckData")><cfoutput>#QcheckData.pp_sys_det#</cfoutput></cfif></textarea>
	</td>
	<td>	
</tr>


<tr><th colspan="2" align="left"><br>Cessation education</th></tr>
<tr>
	<td colspan="2">		
	<input type="checkbox" value="1" name="PP_ed_a" <cfif isDefined("QcheckData") and QcheckData.PP_ed_a EQ 1> checked</cfif>>HCPO began offering cessation education to clinicians and staff <font style="text-decoration:underline;">through Cessation Center</font> this month</td>
	<td>		
</tr>
<tr>
	<td colspan="2">		
	<input type="checkbox" value="1" name="PP_ed_b" <cfif isDefined("QcheckData") and QcheckData.PP_ed_b EQ 1> checked</cfif>>HCPO began offering cessation education to clinicians and staff <font style="text-decoration:underline;">on their own</font> this month</td>
	<td>		
</tr>
<tr>
	<td>&nbsp;</td><td>			
	<textarea name="PP_ed_det" cols="130" rows="2"><cfif isDefined("QcheckData")><cfoutput>#QcheckData.pp_ed_det#</cfoutput></cfif></textarea>
	</td>
	<td>	
</tr>

<tr><th colspan="2" align="left"><br>Cessation materials and resources</th></tr>
<tr>
	<td colspan="2">		
	<input type="checkbox" value="1" name="PP_cess_a" <cfif isDefined("QcheckData") and QcheckData.PP_cess_a EQ 1> checked</cfif>>HCPO began offering resources and materials to clinicians and staff to promote counseling with tobacco-using patients <font style="text-decoration:underline;">through Cessation Center</font> this month</td>
	<td>		
</tr>
<tr>
	<td colspan="2">		
	<input type="checkbox" value="1" name="PP_cess_b" <cfif isDefined("QcheckData") and QcheckData.PP_cess_b EQ 1> checked</cfif>>HCPO began offering resources and materials to clinicians and staff to promote counseling with tobacco-using patients <font style="text-decoration:underline;">on their own</font> this month</td>
	<td>		
</tr>
<tr>
	<td>&nbsp;</td><td>			
	<textarea name="PP_cess_det" cols="130" rows="2"><cfif isDefined("QcheckData")><cfoutput>#QcheckData.pp_cess_det#</cfoutput></cfif></textarea>
	</td>
	<td>	
</tr>

<tr><th colspan="2" align="left"><br>Tobacco Dependence Treatment Coordinator</th></tr>
<tr>
	<td colspan="2">		
	<input type="checkbox" value="1" name="PP_depend_a" <cfif isDefined("QcheckData") and QcheckData.PP_depend_a EQ 1> checked</cfif>>HCPO assigned a staff person as the Tobacco Dependence Treatment Coordinator this month</td>
	<td>		
</tr>
<tr>
	<td colspan="2">		
	<input type="checkbox" value="1" name="PP_depend_b" <cfif isDefined("QcheckData") and QcheckData.PP_depend_b EQ 1> checked</cfif>>Tobacco treatment site champion responsibilities are integrated into job description</td>
	<td>		
</tr>
<tr>
	<td>&nbsp;</td><td>			
	<textarea name="PP_depend_det" cols="130" rows="2"><cfif isDefined("QcheckData")><cfoutput>#QcheckData.pp_depend_det#</cfoutput></cfif></textarea>
	</td>
	<td>	
</tr>

<tr><th colspan="2" align="left"><br>Monitoring compliance</th></tr>
<tr>
	<td colspan="2">		
	<input type="checkbox" value="1" name="PP_compliance_a" id="PP_compliance_a" <cfif isDefined("QcheckData") and QcheckData.PP_compliance_a EQ 1> checked</cfif> onclick="show_other2 ('PP_compliance_a', 'd_compliance');">HCPO started or changed assessment of provider compliance with tobacco treatment policy, practice, or guideline this month</td>
	<td>		
</tr>

<tr>
	<td></td>
	<td>		
	<table id="d_compliance" style="display:none;"  class="box">
		<tr>
			<td></td>
			<td>Which compliance method was added or altered this month?</td>
		</tr>
	<cfoutput>
	<cfloop query="Qmon">
	<tr><td>&nbsp;</td>
	<td><input type="checkbox" name="PP_compliance_cb" value="#id#" <cfif isDefined("QcheckData") and listcontains(QcheckData.pp_compliance_cb,id)> checked</cfif>>#descr#</td>
	</tr>
	</cfloop>
	</cfoutput>	
	<tr><td>&nbsp;</td></tr>
	<tr>
			<td></td>
			<td>If yes, what is assessed?</td>
		</tr>
	<cfoutput>
	<cfloop query="Qmona">
	<tr><td>&nbsp;</td>
	<td><input type="checkbox" name="PP_compliance_cb2" value="#id#" <cfif isDefined("QcheckData") and listcontains(QcheckData.pp_compliance_cb2,id)> checked</cfif>>#descr#</td>
	</tr>
	</cfloop>
	</cfoutput>	
	</table>	
	</td>	
</tr>
<tr>
	<td>&nbsp;</td><td>			
	<textarea name="PP_compliance_det" cols="130" rows="2"><cfif isDefined("QcheckData")><cfoutput>#QcheckData.pp_compliance_det#</cfoutput></cfif></textarea>
	</td>
	<td>	
</tr>


<tr><th colspan="2" align="left"><br>Feedback to providers</th></tr>
<tr>
	<td colspan="2">		
	<input type="checkbox" value="1" name="PP_feedback_a" <cfif isDefined("QcheckData") and QcheckData.PP_feedback_a EQ 1> checked</cfif>>HCPO began providing routine feedback to providers <font style="text-decoration:underline;">through Cessation Center</font> this month</td>
	<td>		
</tr>
<tr>
	<td colspan="2">		
	<input type="checkbox" value="1" name="PP_feedback_b" <cfif isDefined("QcheckData") and QcheckData.PP_feedback_b EQ 1> checked</cfif>>HCPO began providing routine feedback to providers <font style="text-decoration:underline;">on their own</font> this month</td>
	<td>		
</tr>
<tr>
	<td>&nbsp;</td><td>			
	<textarea name="PP_feedback_det" cols="130" rows="2"><cfif isDefined("QcheckData")><cfoutput>#QcheckData.pp_feedback_det#</cfoutput></cfif></textarea>
	</td>
	<td>	
</tr>

<tr><th colspan="2" align="left"><br>Fax-to-Quit at discharge</th></tr>
<tr>
	<td colspan="2">		
	<input type="checkbox" value="1" name="PP_ftq_a" <cfif isDefined("QcheckData") and QcheckData.PP_ftq_a EQ 1> checked</cfif>>HCPO instituted Fax-to-Quit at discharge this month</td>
	<td>		
</tr>

<tr>
	<td>&nbsp;</td><td>			
	<textarea name="PP_ftq_det" cols="130" rows="2"><cfif isDefined("QcheckData")><cfoutput>#QcheckData.pp_ftq_det#</cfoutput></cfif></textarea>
	</td>
	<td>	
</tr>

<tr><th colspan="2" align="left"><br>Tobacco-free campus policy</th></tr>
<tr>
	<td colspan="2">		
	<input type="checkbox" value="1" name="PP_tfp_a" <cfif isDefined("QcheckData") and QcheckData.PP_tfp_a EQ 1> checked</cfif>>Passed tobacco-free campus policy this month</td>
	<td>		
</tr>
<tr>
	<td colspan="2">		
	<input type="checkbox" value="1" name="PP_tfp_b" <cfif isDefined("QcheckData") and QcheckData.PP_tfp_b EQ 1> checked</cfif>>Tobacco-free campus policy took effect this month</td>
	<td>		
</tr>
<tr>
	<td>&nbsp;</td><td>			
	<textarea name="PP_tfp_det" cols="130" rows="2"><cfif isDefined("QcheckData")><cfoutput>#QcheckData.pp_tfp_det#</cfoutput></cfif></textarea>
	</td>
	<td>	
</tr>

<tr><th colspan="2" align="left"><br>Cessation assistance for employees</th></tr>
<tr>
	<td colspan="2">		
	<input type="checkbox" value="1" name="PP_cessAss_a" <cfif isDefined("QcheckData") and QcheckData.PP_cessAss_a EQ 1> checked</cfif>>HCPO began offering cessation assistance for employees this month</td>
	<td>		
</tr>
<tr>
	<td colspan="2">		
	<input type="checkbox" value="1" name="PP_cessAss_b" <cfif isDefined("QcheckData") and QcheckData.PP_cessAss_b EQ 1> checked</cfif>>Insurance covers cessation treatment for employees</td>
	<td>		
</tr>
<tr>
	<td>&nbsp;</td><td>			
	<textarea name="PP_cessAss_det" cols="130" rows="2"><cfif isDefined("QcheckData")><cfoutput>#QcheckData.pp_cessAss_det#</cfoutput></cfif></textarea>
	</td>
	<td>	
</tr>

<tr><th colspan="2" align="left"><br>Transition to maintenance phase</th></tr>
<tr>
	<td colspan="2">		
	<input type="checkbox" value="1" name="PP_trans_a" <cfif isDefined("QcheckData") and QcheckData.PP_trans_a EQ 1> checked</cfif>>HCPO transitioned to maintenance phase this month</td>
	<td>		
</tr>
<tr>
	<td>&nbsp;</td><td>			
	<textarea name="PP_trans_det" cols="130" rows="2"><cfif isDefined("QcheckData")><cfoutput>#QcheckData.pp_trans_det#</cfoutput></cfif></textarea>
	</td>
	<td>	
</tr>

<tr>
<td  colspan="2"><input type="submit" value="Save"  class="AddButton"  onclick="return validateMe2();"></td>

</tr>





<cfif Qlist.recordcount GT 0>
<tr>
	<td colspan="2">
		<table class="box">
			<cfoutput>
			<cfloop query="Qlist">
				<tr>
					<td><a href="cess1.cfm?handler=seven&id2=<cfoutput>#Qlist.seq#&#session.urltoken#</cfoutput>">#Qlist.unitname#</a></td>
					<td><input type="checkbox" name="del" value="#Qlist.seq#">Delete?</td>
				</tr>
			</cfloop>
			<cfif Qlist.recordcount  GTE 1>
			<tr><td colspan="2"><input type="submit" value="Delete"  class="DelButton"  onclick="return deleteentries();"></td></tr>
			</cfif>
			</cfoutput>
		</table>
	</td>

</tr>
</cfif>


<script language="javascript">
show_other2 ('PP_pol_bit', 'd_writtenP');
show_other2 ('PP_sys_bit', 'd_sys');
show_other2 ('PP_compliance_a', 'd_compliance');
show_other2 ('PP_prac_bit', 'd_pract');
</script>


<!--- 
<tr>
	<td colspan="2">Do the organization's practices ensure that...</td>
	<td>&nbsp;</td>
</tr>

<tr>
	<td>&nbsp;</td>
	<td>Every patient is screened for tobacco use?</td>
	<td>
	<input type="radio" name="ep_1" value="0" > No<br>
	<input type="radio" name="ep_1" value="1" > Yes<br>
	</td>
</tr>

<tr>
	<td>&nbsp;</td>
	<td>Every tobacco user is provided with brief counseling?</td>
	<td>
	<input type="radio" name="ep_2" value="0" > No<br>
	<input type="radio" name="ep_2" value="1" > Yes<br>
	</td>
</tr>

<tr>
	<td>&nbsp;</td>
	<td>Every tobacco user is provided with a follow-up?</td>
	<td>
	<input type="radio" name="ep_3" value="0" > No<br>
	<input type="radio" name="ep_3" value="1" > Yes<br>
	</td>
</tr>

<tr>
	<td>&nbsp;</td>
	<td>Every tobacco user is offered pharmacotherapy (unless contraindicated)?</td>
	<td>
	<input type="radio" name="ep_4" value="0" > No<br>
	<input type="radio" name="ep_4" value="1" > Yes<br>
	</td>
</tr>

<tr>
	<td>&nbsp;</td>
	<td>Does the organization have an identification system to document the smoking status of every patient?</td>
	<td>
	<input type="radio" name="ep_5" value="0" > No<br>
	<input type="radio" name="ep_5" value="1" > Yes<br>
	</td>
</tr>

<tr>	
	<td colspan="2">Does the organization have a staff person assigned as the Tobacco Dependence Treatment Coordinator?</td>
	<td>
	<input type="radio" name="idSys" value="0" onclick="show_other('d_idSys', 'hide');"> No<br>
	<input type="radio" name="idSys" value="1" onclick="show_other('d_idSys', 'show');"> Yes<br>
	<div id="d_idSys">
	<cfoutput>
	<cfloop query="QidSys">
	&nbsp; <input type="checkbox" name="idSys_det" value="#id#">#descr#<br>
	</cfloop>
	</cfoutput>
	</div>
	</td>
</tr>

<tr>
	<td colspan="2">Does the organization have a staff person assigned as the Tobacco Dependence Treatment Coordinator?</td>
	<td>
	<input type="radio" name="TDTC" value="0" > No<br>
	<input type="radio" name="TDTC" value="1" > Yes<br>
	</td>
</tr>

<tr>
	<td colspan="2">Does the organization provide educational opportunities to clinicians and staff to promote counseling with tobacco-using patients?</td>
	<td>
	<cfoutput>
	<cfloop query="Qcoord">
	&nbsp; <input type="checkbox" name="promote_couns" value="#id#">#descr#<br>
	</cfloop>
	</cfoutput>
	</td>
</tr>

<tr>
	<td colspan="2">Does the organization provide resources and materials to clinicians / staff to promote screening and brief counseling with tobacco-using patients</td>
	<td>
	<cfoutput>
	<cfloop query="Qcoord">
	&nbsp; <input type="checkbox" name="provide_res" value="#id#">#descr#<br>
	</cfloop>
	</cfoutput>
	</td>
</tr>

<tr>
	<td colspan="2">Does the organization assess provider compliance with the tobacco dependence treatment policy, procedure, or guideline?
	<br>If yes, how is compliance assessed?
	</td>
	<td>
	<input type="radio" name="compliance" value="0" onclick="show_other('d_compliance', 'hide');"> No<br>
	<input type="radio" name="compliance" value="1" onclick="show_other('d_compliance', 'show');"> Yes<br>
	<div id="d_compliance">
	<cfoutput>
	<cfloop query="Qcompliance">
	&nbsp; <input type="checkbox" name="compliance_det" value="#id#">#descr#<br>
	</cfloop>
	</cfoutput>
	
	</div>
	
	
	
	</td>
</tr>

<tr>
	<td colspan="2">Does the organization routinely provide feedback (e.g., report cards) to providers?</td>
	<td>
	<input type="radio" name="feedback" value="0" > No<br>
	<input type="radio" name="feedback" value="1" > Yes<br>
	</td>
</tr>

<tr>
	<td colspan="2">Which of the following best describers the current policy regarding outdoor ciarette smoking by staff, patients, and visitors at this health care organization?</td>
	<td>
	<cfoutput>
	<cfloop query="Qpolicies">
	&nbsp; <input type="checkbox" name="policies" value="#id#">#descr#
	<cfif id EQ 2>
	<cfinput type="text" name="policies_date" size="10" validate="date" > (M/D/YYYY)
	</cfif><br>
	</cfloop>
	</cfoutput>
	</td>
</tr>

<tr>
	<td colspan="2">Does the organization offer cessation assistance for employees?</td>
	<td>
	<input type="radio" name="cessAssist" value="0" > No<br>
	<input type="radio" name="cessAssist" value="1" > Yes<br>
	</td>
</tr>

<tr>
	<td colspan="2">Other comments describing policy and practice?</td>
	<td><textarea  name="comments" rows="2" cols="80"></textarea></td>
</tr>
 --->
