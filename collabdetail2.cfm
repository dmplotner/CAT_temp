<link href="ddmenu.css" rel="stylesheet" type="text/css">

<cfform name="submitCollab" action="prc_collaborator2.cfm?#session.urltoken#">
  <input type="hidden" name="recordSeq2" value="">
  <input type="Hidden" name="addUser" value="">

   <cfquery datasource="#application.DataSource#"  		
	password="#application.db_password#"   		
	username="#application.db_username#" name="collaborators">
  select case cess when 1 then '2008-2009' else
case min(h.year2) when null then ''
else
cast(min(h.year2)-1 as varchar)  + '-' + cast(min(h.year2) as varchar)
end
end as maint,
c.name, c.indOrg, c.traditional, w.targethcpo as type, c.county, 
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
  c.school, c.district , isnull(c.sodistrict,0) as sodistrict, isNull(c.sfy, 0) as sfy,
d.district_name,
s.institutionname
  from collaborators as c 
left outer join monthly_targethcpo as h on h.seq=c.seq and adcomm3=1
left outer join  wrkplan_targethcpo as w on w.targethcpo_id = c.type and w.year2=c.year2 
left outer join nysed_district as d on d.district_id = c.district
left outer join nysed_school as s on s.bedscode=c.school
  where c.userid = '#session.userid#' and (c.year2 >=1904)
  <!--- and (c.del is null or c.del != 1)
  and o.num = c.type and o.indorg=c.indorg 
  and  c.year2=o.year2  --->
  and (c.del is null or c.del !=1)
  <cfif session.modality EQ 4>
  and c.district is not null
  <cfelse>
  and c.county is not null
  </cfif>
group by 
c.name, c.indOrg, c.traditional, w.targethcpo, c.county,c.seq, c.unit, 
case when c.unit IS NULL then c.NAME else c.unit + ' ' + NAME end, 
del, case tHCPO when 0 then 'No' when 1 then 'Yes' else '-' end, 
case tLevel 
	when 1 then 'Potential' 
	when 2 then 'Limited' 
	when 3 then 'Full'
	else '-' end, 
	entdt,
	case FQHC when 1 then 'Yes' else 'No' end,
	case ref when 1 then 'Yes' else 'No' end,cess,pip,
  c.school, c.district , isnull(c.sodistrict,0), isNull(c.sfy, 0),
d.district_name,s.institutionname
 <cfif session.modality EQ 4>order by 17, 18 --13, 12<Cfelse> order by 9,8,7,1</cfif>

  
  </cfquery>
  
<cfquery datasource="#application.DataSource#"  		
	password="#application.db_password#"   		
	username="#application.db_username#" name="collaboratorsSum">
  select isNull(o.targethcpo, '-- Not selected --') as type,

sum(case tlevel when 1 then 1 else 0 end) as PotCt,
sum(case tlevel when 2 then 1 else 0 end) as LTdCt,
sum(case tlevel when 3 then 1 else 0 end) as FullCt,
sum(case tlevel when 0 then 0 when 1 then 0 when 2 then 0 when 3 then 0 else 1 end) as noCt

 from collaborators as c left outer join  wrkplan_targethcpo as o on o.targethcpo_id = c.type and o.year2=c.year2 
  where userid = '#session.userid#' and (c.year2 >=1904)
 
 and (c.del is null or c.del !=1)
  <cfif session.modality EQ 4>
  and c.district is not null
  <cfelse>
  and c.county is not null
  </cfif>
group by o.targethcpo
 order by 1
  
  </cfquery>
  
 
  <cfif CGI.HTTP_REFERER contains "collaborators.cfm" and NOT isDefined("URL.hide")>
    <script type="text/javascript">
    function toggle_visibility1(id) {
	     var emr = document.submitCollab.emr.checked;
	     var oth = document.submitCollab.other.checked;
		if( emr == true){
		   document.submitCollab.other.checked = false;}
		     
		   if(oth == true){
		   document.submitCollab.emr.checked = false;}
		  }
    function toggle_visibility2(id) {
 	     var e = document.getElementById(id);
	     var emr2 = document.submitCollab.emr2.checked;
	     var oth2 = document.submitCollab.other2.checked;
		   
		 if( emr2 == true || oth2 == true){
		
       if(e.style.display == 'block')
          e.style.display = 'none';
       else
          e.style.display = 'block';
		  }
		if( emr2 == true){
		   document.submitCollab.other2.checked = false;}
		     
		   if(oth2 == true){
		   document.submitCollab.emr2.checked = false;}
		  }
		  
function add(){
if (document.submitCollab.collabName.value==""){
alert('Please choose a collaborator name');
return false;
}
if (document.submitCollab.collabType.value==999){
alert('Please choose a collaborator type');
return false;
}
document.submitCollab.addUser.value="add";
} 
function buh(){

if((document.submitCollab.docsys.checked == true)||(document.submitCollab.docsys2.checked == true))
{
document.submitCollab.advise_ident.disabled = false;
document.submitCollab.assess_ident.disabled = false;
document.submitCollab.assarr_ident.disabled = false;

}	
}
function buh2(){

if(document.submitCollab.writpol.checked == true)
{
document.submitCollab.ask.disabled = false;
document.submitCollab.train.disabled = false;
document.submitCollab.advise_writpol.disabled = false;
document.submitCollab.assess_writpol.disabled = false;
document.submitCollab.assarr_writpol.disabled = false;

}	
}
function add2(){
<cfif session.modality NEQ 4 AND (session.fy LT 2007 and session.fy GT 1920)>
var radio_choice = false;
// Loop from zero to the one minus the number of radio button selections
for (counter = 0; counter < document.submitCollab.indOrg.length; counter++)
{
// If a radio button has been selected it will return true
// (If not it will return false)
if (document.submitCollab.indOrg[counter].checked)
radio_choice = true; 
}

if (!radio_choice)
{
alert('Please indicate if this collaborator is an individual or organization');
return false;
}
<cfelseif session.modality EQ 4 and session.fy GT 2010>

if(document.submitCollab.district.selectedIndex == 0){
alert('Please select a district.');
return false;
}

var radio_choice = false; 
for (counter = 0; counter < document.submitCollab.solunch.length; counter++){
if (document.submitCollab.solunch[counter].checked)
radio_choice = true; 
}
if (!radio_choice)
{
alert('Please indicate the level of free and reduced lunch.');
return false;
}

if(document.submitCollab.sfy.selectedIndex == 0){
alert('Please indicate what reporting period you began working with this school district.');
return false;
}
<cfelseif session.modality EQ 1 and session.fy GT 2010>
if(document.submitCollab.collabName.value.length == 0){
alert('Please indicate a target HCPO name.');
return false;
}
if(document.submitCollab.collabType.selectedIndex == 0){
alert('Please indicate an organization type.');
return false;
}
if(document.submitCollab.Jurisdiction.options[document.submitCollab.Jurisdiction.selectedIndex].value == ""){
alert('Please indicate a county.');
return false;
}
radio_choice = false; 
for (counter = 0; counter < document.submitCollab.tLevel.length; counter++)
{
// If a radio button has been selected it will return true
// (If not it will return false)
if (document.submitCollab.tLevel[counter].checked)
radio_choice = true; 
}

if (!radio_choice)
{
alert('Please indicate Level of HCPO involvement.');
return false;
}
radio_choice = false; 
for (counter = 0; counter < document.submitCollab.fqhc.length; counter++)
{
// If a radio button has been selected it will return true
// (If not it will return false)
if (document.submitCollab.fqhc[counter].checked)
radio_choice = true; 
}

if (!radio_choice)
{
alert('Please indicate if this is a Federally Qualified Health Center.');
return false;
}
radio_choice = false; 
for (counter = 0; counter < document.submitCollab.ref.length; counter++)
{
// If a radio button has been selected it will return true
// (If not it will return false)
if (document.submitCollab.ref[counter].checked)
radio_choice = true; 
}

if (!radio_choice)
{
alert('Please indicate if this is a referral from health plan.');
return false;
}
<cfelseif session.modality EQ 4>
if(document.submitCollab.district.selectedIndex==0){alert("Please select a district."); return false;}
if(document.submitCollab.sfy.selectedIndex==0){alert("Please select which fiscal year you began working with this school or district."); return false;}
</cfif>
document.submitCollab.addUser.value="add";
} 
</script>
    <cfif isDefined("url.seq")>
      <cfquery datasource="#application.DataSource#"  		 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qcollab_UPD">
      select c.name, c.indOrg, c.traditional, c.type, c.county, c.seq , c.unit, pip,
	  case when c.unit IS NULL then c.NAME else c.unit + ' ' + NAME end as unitname , FQHC,ref,cess,writpol,ask,advise_writpol,assess_writpol,train,assarr_writpol,advise_ident,assess_ident,assarr_ident,
	  
	  isnull(idsys,0)as idsys,
	  isnull(docsys,0)as docsys,
	  isnull(idsys2,0)as idsys2,
	  isnull(docsys2,0)as docsys2, 
	  
	  other2,staff,fback,campus,
	  tHCPO, tLevel from collaborators as c where userid = '#session.userid#' 
	  <!--- and c.year2=#session.fy# ---> and c.seq = #url.seq#
      </cfquery>
      <cfif Qcollab_UPD.recordcount GT 0>
        <cfset form.collabname = Qcollab_UPD.name>
        <cfset form.traditional = Qcollab_UPD.traditional>
        <cfset form.targethcpo = Qcollab_UPD.type>
        <cfset form.jurisdiction = Qcollab_UPD.county>
        <cfset form.indOrg = Qcollab_UPD.indorg>
        <cfset form.unit = Qcollab_UPD.unit>
        <cfset form.recordSeq = Qcollab_UPD.seq>
        <cfset form.tHCPO = Qcollab_UPD.tHCPO>
        <cfset form.tLevel = Qcollab_UPD.tLevel>
		<cfset form.FQHC = Qcollab_UPD.FQHC>
		<cfset form.ref = Qcollab_UPD.ref>
		<cfset form.cess = Qcollab_UPD.cess>
		<cfset form.writpol = Qcollab_UPD.writpol>
		<cfset form.ask = Qcollab_UPD.ask>
		<cfset form.advise_ident = Qcollab_UPD.advise_ident>
		<cfset form.assess_ident = Qcollab_UPD.assess_ident>
		<cfset form.assarr_ident = Qcollab_UPD.assarr_ident>
		<cfset form.advise_writpol = Qcollab_UPD.advise_writpol>
		<cfset form.assess_writpol = Qcollab_UPD.assess_writpol>
		<cfset form.assarr_writpol = Qcollab_UPD.assarr_writpol>
		<cfset form.train = Qcollab_UPD.train>
		<cfset form.idsys = Qcollab_UPD.idsys>
		<cfset form.docsys = Qcollab_UPD.docsys>
		<cfset form.idsys2 = Qcollab_UPD.idsys2>
		<cfset form.docsys2 = Qcollab_UPD.docsys2>
		<cfset form.other2 = Qcollab_UPD.other2>
		<cfset form.staff = Qcollab_UPD.staff>
		<cfset form.fback = Qcollab_UPD.fback> 
		<cfset form.campus = Qcollab_UPD.campus>   
		<cfset form.pip = Qcollab_UPD.pip> 		
		</cfif>
		<cfelse>
				<cfset form.pip = ''> 		

    </cfif>
	<cfparam name="form.pip" default="">
<!---     <cfif isDefined("form.recordSeq2") and form.recordSeq2 EQ "-1">
      <cfset form.collabname = "">
      <cfset form.traditional = "">
      <cfset form.collabtype = "">
      <cfset form.jurisdiction = "">
      <cfset form.indOrg = "">
      <cfset form.unit = "">
      <cfset form.recordSeq = "">
      <cfset form.tHCPO = "">
      <cfset form.tLevel = "">
	  <cfset form.FQHC = "">
	  	  <cfoutput>#form.tlevel#</cfoutput>

    </cfif>
 --->    <cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="countyheadache">
    select catchment from contact where userid = '#session.userid#'
    </cfquery>
	<cfif countyheadache.catchment is ''>
<cflocation url="nocounty.cfm">
<cfelse>
    <cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="counties">
    select CountyName, FIPS from counties where FIPS in
    <cfif isDefined("countyheadache.catchment")>
      (#valuelist(countyheadache.catchment)#)
      <cfelse>
      (0)
    </cfif>
    order by 1
    </cfquery>
	</cfif>
    <cfquery datasource="#application.DataSource#" 
	password="#application.db_password#"   		
	username="#application.db_username#" name="orgTypes">
    select * from wrkplan_TargetHCPO
    where year2=#session.fy# order by targethcpo
    </cfquery>
    <script language="JavaScript">
var sPath = window.location.pathname;
//var sPage = sPath.substring(sPath.lastIndexOf('\\') + 1);
var sPage = sPath.substring(sPath.lastIndexOf('/') + 1);



function presubmit(){
document.submitCollab.action=sPage+'<cfoutput>?#session.urltoken#</cfoutput>';
document.submitCollab.submit();
}


</script>
    <table class="boxy" align="left" cellpadding="10" cellspacing="3" border="0" width="100%">
      <cfif isDefined("form.recordSeq")>
        <input type="Hidden" name="recordSeq" value="<cfoutput>#form.recordSeq#</cfoutput>">

      </cfif>  <input type="hidden" name="entdt" value="<cfoutput>#Now()#</cfoutput>">
      <cfif SESSION.modality NEQ 4>
        <tr>
        <td colspan="4" align="center">
        
        <table class="box" border="1" width="75%" >
        
        <tr>
          <th colspan="3"><Cfif session.fy GT 2006 and session.modality EQ 1>Target Health Care Provider Organizations (HCPOs):<cfelse>Collaborators: <A HREF="javascript:void(0)"onclick="window.open('#application.basename#/dictionary.cfm##coll','_blank','height=500, width=700,scrollbars=yes')"><img SRC="images/book07.gif"  width="20" height="20" BORDER="0" ALT="Help"></a></cfif></th>
        </tr>
        <cfoutput>
          <tr>
            <td colspan="2"><!--- 	Collaborator Name<cfif session.modality EQ 1> (specifically unit/department name IF one of several units/departments within the same hospital/organization</cfif> --->
              </td>
          </tr>
          <tr>
            <td>Target HCPO</td>
            <td><input type="text" size="50" name="collabName"<cfif isDefined("form.collabName")> value="#form.collabName#"</cfif>>
            </td>
          </tr>
        </cfoutput>
		
        <tr>
          <td>Organization Type</td>
          <td>
 
		 
		  <select name="collabType">
			  <option value="">-Please select an organization type-</option>
              <cfif not isdefined("form.targethcpo")><option value="999">Select one</cfif> 
              <cfoutput query="orgTypes">
                  <option value="#targetHCPO_ID#" <cfif isDefined("form.targetHCPO") and listCOntains(form.targetHCPO,targetHCPO_ID)> selected</cfif>>
                  #targetHCPO# 
              </cfoutput>
            </select>

          </td>
        </tr>
		
        <tr>
          <td> County<!---  of residence,<br>
            jurisdiction,<br>
            or coverage ---></td>
          <td><cfselect name="Jurisdiction"  <!--- multiple size="6"  class="mlti"---> required="Yes" message="Please select at least one county of Jurisdiction">
              <cfoutput>
				<cfif counties.recordcount GT 1><option value="">-Please select a county-</option></cfif>
                <cfloop query="counties" >
                  <option value="#FIPS#"  <cfif isDefined("form.Jurisdiction") and listContains(form.Jurisdiction,FIPS)> selected</cfif>>#countyName#
                </cfloop>
              </cfoutput>
              <cfif session.fy LT 2009>
					<option value="99999" <cfif isDefined("form.Jurisdiction") and listContains(form.Jurisdiction,"99999")> selected</cfif>>Distant from catchment area
				</cfif>
            </cfselect>
          </td>
        </tr>
        <cfif session.modality EQ 1>
			<input type="hidden" name="tHCPO" value="1">
          <!--- <tr>
            <td>Target HCPO?</td>
            <td><input type="radio" name="tHCPO" value="1" <cfif isDefined("form.tHCPO") and form.tHCPO EQ 1> checked</cfif> onClick="presubmit();">
              Yes<br>
              <input type="radio" name="tHCPO" value="0" <cfif isDefined("form.tHCPO") and form.tHCPO EQ 0> checked</cfif> onClick="presubmit();">
              No </td>
          </tr> --->
          <!--- <cfif isDefined("form.tHCPO") and form.tHCPO EQ 1> --->
            <tr>
              <td>Level of HCPO involvement?</td>
              <td><input type="radio" name="tLevel" value="1" <cfif isDefined("form.tLevel") and form.tLevel EQ 1> checked</cfif> >
                Potential Partner<br>
                <input type="radio" name="tLevel" value="2" <cfif isDefined("form.tLevel") and form.tLevel EQ 2> checked</cfif> >
                Limited Partner<br>
				<!--- <input type="radio" name="tLevel" value="3" <cfif isDefined("form.tLevel") and form.tLevel EQ 3> checked</cfif> >
                Maintenance <br> --->
				<input type="radio" name="tLevel" value="3" <cfif isDefined("form.tLevel") and form.tLevel EQ 3> checked</cfif> >
                Full Partner <br>
              </td>
            </tr>
			<tr>
              <td>Federally Qualified Health Center?</td>
              <td><input type="radio" name="fqhc" value="1" <cfif isDefined("form.FQHC") and form.FQHC EQ 1> checked</cfif> >
                Yes <br>
                <input type="radio" name="fqhc" value="0" <cfif isDefined("form.FQHC") and form.FQHC EQ 0> checked</cfif> >
                No 
              </td>
            </tr>
			<tr>
              <td>Referral from health plan?</td>
              <td><input type="radio" name="ref" value="1" <cfif isDefined("form.ref") and form.ref EQ 1> checked</cfif> >
                Yes <br>
                <input type="radio" name="ref" value="0" <cfif isDefined("form.ref") and form.ref EQ 0> checked</cfif> >
                No 
              </td>
            
			<cfif session.fy LTE 2010>
			</tr>
						<tr>
              <td>HCPO worked with Cessation Center prior to August 2009</td>
              <td><input type="radio" name="cess" value="1" <cfif isDefined("form.cess") and form.cess EQ 1> checked</cfif> >
                Yes, HCPO in maintenance phase<br>
                <input type="radio" name="cess" value="2" <cfif isDefined("form.cess") and form.cess EQ 2> checked</cfif> >
                Yes, not in maintenance phase<br>
                <input type="radio" name="cess" value="0" <cfif isDefined("form.cess") and form.cess EQ 0> checked</cfif> >
                No            </td>
            </tr>
			</cfif>
			   <tr>
          <th colspan="3">BASELINE DATA FOR THIS HCPO<br>Document status. Newly implemented changes should be entered in monthly reports.</th>
        </tr>
							   <tr>
          <td colspan="3">Identification system to document smoking status of every patient (ASK)
<br>&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="idsys" value=1  <cfif isdefined("form.idsys") and #form.idsys# eq 1>checked</cfif>>EMR<br>

          &nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="idsys2" value=1  <cfif isdefined("form.idsys2") and #form.idsys2# eq 1>checked</cfif>>Other System<br>
		 </td></tr>
        </tr>
							   <tr>
          <td colspan="3">System to document tobacco dependence treatment for every tobacco user 
<br>&nbsp;&nbsp;&nbsp;&nbsp;
<input type="checkbox" name="docsys" value=1  onclick="buh();" <cfif isdefined("form.docsys") and #form.docsys# eq 1>checked</cfif>>EMR<br>
          &nbsp;&nbsp;&nbsp;&nbsp;
<input type="checkbox" name="docsys2" value=1  onclick="buh();" <cfif isdefined("form.docsys2") and #form.docsys2# eq 1>checked</cfif>>Other System<br>
		 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;What specifically is included?<br>
		  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="advise_ident" value=1 <cfif isdefined("form.advise_ident") and #form.advise_ident# eq 1>checked</cfif> <cfif ((not isdefined("form.docsys") or #form.docsys# is '' or #form.docsys# is 0)AND (not isdefined("form.docsys2") or #form.docsys2# is '') or #form.docsys2# is 0) >disabled</cfif>>Tobacco user was advised to quit and provided brief counseling (ADVISE) <br>
		  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="assess_ident" value=1 <cfif isdefined("form.assess_ident") and #form.assess_ident# eq 1>checked</cfif> <cfif  ((not isdefined("form.docsys") or #form.docsys# is '' or #form.docsys# is 0)AND (not isdefined("form.docsys2") or #form.docsys2# is '' or #form.docsys2# is 0)) >disabled</cfif>>Tobacco user was assessed for willingness to quit (ASSESS) <br>
		  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="assarr_ident" value=1 <cfif isdefined("form.assarr_ident") and #form.assarr_ident# eq 1>checked</cfif> <cfif  ((not isdefined("form.docsys") or #form.docsys# is '' or #form.docsys# is 0)AND (not isdefined("form.docsys2") or #form.docsys2# is '' or #form.docsys2# is 0)) >disabled</cfif>>Tobacco user ready to quit was assisted and provided follow-up (ASSIST/ARRANGE) <br>
	     </div>
		 </td></tr>

   			   <tr>
          <td colspan="3"><input type="checkbox" name="writpol" value=1  onclick="buh2();" <cfif isdefined("form.writpol") and #form.writpol# eq 1>checked</cfif>>Written policy or written standard of care on tobacco dependence treatment
If yes, what is included? 
<br>&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="ask" value=1 <cfif isdefined("form.ask") and #form.ask# eq 1>checked</cfif> <cfif not isdefined("form.writpol") or #form.writpol# is ''>disabled</cfif>>Every patient will be screened for tobacco use (ASK)<br>

          &nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="advise_writpol" value=1 <cfif isdefined("form.advise_writpol") and #form.advise_writpol# eq 1>checked</cfif> <cfif not isdefined("form.writpol") or #form.writpol# is ''>disabled</cfif>>Every tobacco user will be advised to quit and provided brief counseling (ADVISE)<br>

          &nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="assess_writpol" value=1 <cfif isdefined("form.assess_writpol") and #form.assess_writpol# eq 1>checked</cfif> <cfif not isdefined("form.writpol") or #form.writpol# is ''>disabled</cfif>>Every tobacco user will be assessed for willingness to quit (ASSESS)<br>

          &nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="assarr_writpol" value=1 <cfif isdefined("form.assarr_writpol") and #form.assarr_writpol# eq 1>checked</cfif> <cfif not isdefined("form.writpol") or #form.writpol# is ''>disabled</cfif>>Every tobacco user ready to quit will be assisted and provided follow-up (ASSIST/ ARRANGE)<br>

          &nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="train" value=1 <cfif isdefined("form.train") and #form.train# eq 1>checked</cfif> <cfif isdefined("form.train") and #form.train# eq 1>checked</cfif> <cfif not isdefined("form.writpol") or #form.writpol# is ''>disabled</cfif>>Providers will receive ongoing cessation training
</td>
        </tr>

					   <tr>
          <td colspan="3"><input type="checkbox" name="staff" value=1 <cfif isdefined("form.staff") and #form.staff# eq 1>checked</cfif>>Staff person assigned as Tobacco Dependence Treatment Coordinator
</td></tr>
					   <tr>
          <td colspan="3"><input type="checkbox" name="fback" value=1 <cfif isdefined("form.fback") and #form.fback# eq 1>checked</cfif>>HCPO provides feedback to providers regarding documentation of tobacco dependence treatment
</td></tr>
					   <tr>
          <td colspan="3"><input type="checkbox" name="campus" value=1 <cfif isdefined("form.campus") and #form.campus# eq 1>checked</cfif>>Tobacco-free campus policy in effect (including grounds)
        <cfoutput>  <tr><td colspan="3"><cfinput name="pip" type="text" value="#form.pip#" size=4 required="no" message="You must enter a number" validate="integer"> Number of providers that have completed PIP stages A, B, and C</cfoutput>
           </cfif>
        
		
		
		<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="selectContact">
        Select orgName, partnerType, agent, grantNum, street1, street2, city, state, zip, contact, title, phone, fax, email, catchment from contact where userid = '#session.userid#'
        </cfquery>
        <!--- Section for School partners --->
<cfelse>
		
		<cfif isDefined("URL.seq")>
		<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="qselectedItem">
        Select 
		isnull(school,999) as school, 
		isnull(district,999) as district, sodistrict, sfy
		from collaborators 
		where userid = '#session.userid#'
		and seq = #url.seq#
        </cfquery>
		
		</cfif>
        <cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="selectcatchment">
        select catchment from contact where userid='#session.userid#'
        </cfquery>
		
        <cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="selectdistrict">
        select d.district_id, d.district_name 
		from nysed_district as d, nysed_county as c 
		where c.fips in (#selectcatchment.catchment#)
		and c.county_id = left(d.district_id, 2)
		order by d.district_name
        </cfquery>
		
				
        <cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="selectschools">
        select BEDSCODE, institutionName from nysed_school 
		where 
        <cfif isDefined("form.district")>
          district= rtrim('#form.district#')
          <cfelseif  isDefined("qselectedItem.school") and qselectedItem.school NEQ 999>
		  	district=rtrim('#qselectedItem.district#')
		  <cfelse>
         district= '0'
        </cfif>
		and (BEDSCode NOT LIKE '%0000')
		ORDER BY institutionName
        </cfquery>
		
		<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="selectspyears">
        select distinct year2,  cast((year2-1) as varchar) + '-' + cast(year2 as varchar)as dispyr
		
		from area 
		where 
        year2 > 2006
		union
		select 1904, '2005-2006'
		ORDER BY 1
        </cfquery>
   

       </cfif>
	  <tr>
		<td colspan="2" align="center"><!--- <input type="submit" name="add_collaborator" value="Add Collaborator" onclick="return add();">
<input type="submit" name="add_collaborator" value="Add Collaborator" onclick="return add();" style="background-color: #336633;" >
 --->
          <input type="submit" name="add_collaborator" value="Add/Update<!---  <cfif session.fy GT 2006 and session.modality EQ 1>Target HCPO<cfelse>Collaborator</cfif> --->" onclick="return add2();"  class="AddButton" >
        </td>
      </tr>
	  
	  
	   <cfif session.modality EQ 1>
            <!---   <cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QUnitNames">
              select distinct Unit from collaborators where userid='#session.userid#' and unit != '' order by 1
              </cfquery>
              <tr>
                <td colspan="2"><!--- 	Hospital/organization name IF you have multiple units/departments within this hospital/organization --->
                  Umbrella organization (e.g., hospital which has multiple departments) </td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td><cfif QUnitNames.recordcount GT 1 OR (QUnitNames.recordcount EQ 1 and QUnitNames.unit NEQ "")>
                    <cfoutput>
                      <select name="unit">
                        <option value="">
                        <cfloop query="QUnitNames">
                          <option value="#unit#" <cfif isDefined ("form.unit") and form.unit EQ "#UNIT#"> selected</cfif>>#unit#
                        </cfloop>
                      </select>
&nbsp;-OR-&nbsp; </cfoutput>
                  </cfif>
                  <input type="Text" name="newUnit">
                </td>
              </tr> --->
      
            <!--- </cfif> --->
          </cfif>
   
  </cfif>

  <tr>
    <td colspan="100%"><table>
    <tr>
      <td>
      <br>
        <cfif not isDefined("form.add_collaborator") and not isdefined("url.seq")>
    <div> Select a Link below to update a 
	  Target HCPO, or click on
        <input type="button"  value="Add New Target HCPO" onClick="document.submitCollab.recordSeq2.value='-1';document.submitCollab.action='collaborators.cfm<cfoutput>?#session.urltoken#</cfoutput>';document.submitCollab.submit();";>
        to add a new Target HCPO</div>
      <br></cfif>
      <cfif collaborators.recordcount GT 0>
        <table  class="BOX"  align="center" border="0" cellpadding="3" cellspacing="0" >
          <cfif session.modality NEQ 4>
            <tr>
              <th width="400">Target HCPO</th>
			<th width="40" >Maintenance?</th>
              <cfif session.fy LTE 2006>
			  <th width="80" align="center">Individual<br>
                or<br>
                Organization</th>
              <th width="60">Non-<br>Tradit</th>
			  </cfif>
              <th width="200" >Type</th>
              <th width="90" align="left">County</th>
              <th width="90">Level</th>
			<th width="70">Date Entered</th>
              <th>Delete</th>
            </tr>
            <cfset delline=0>
            <cfoutput>
              <cfloop query="collaborators" >
                <cfif  del EQ 1>
                  <cfset delline=delline + 1>
                  <cfif delline EQ 1>
                    <tr>
                      <td><br>
                        <br></td>
                    </tr>
                    <tr bgcolor="Silver">
                      <th <cfif session.fy LTE 2006>colspan="8"<cfelse>colspan="5"</cfif> align="left">Deleted Collaborators:</th>
                    </tr>
                    <tr bgcolor="Silver">
                      <td <cfif session.fy LTE 2006>colspan="8"<cfelse>colspan="5"</cfif>><br></td>
                    </tr>
                  </cfif>
                </cfif>
                <tr <cfif del EQ 1>bgcolor="Silver"</cfif>>
                  <td><span style="text-align:left; "><a href="collaborators.cfm?#session.urltoken#&seq=#seq#"></span>
                    <cfif unit NEQ "">
                      #unit# -
                    </cfif>
                    #name# </a>&nbsp;</td>
					<td >#maint#</td>
                  <td>#type#&nbsp;</td> 
                  <td><cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="countyDetails">
                    select CountyName from counties where FIPS in (<cfif len(county)>#county#<cfelse>0</cfif>) order by 1
                    </cfquery>
                    <cfif countyDetails.recordcount NEQ 0>#valuelist(countyDetails.countyname)#</cfif></td>
                  <cfif session.modality EQ 1 
		or session.cessMan EQ 1 
		or session.TCP eq 1 
		or session.Admin EQ 1
		or session.AreaManage EQ 1>
                     <cfif session.fy LTE 2006><td align="center">#tHCPO#&nbsp;</td></cfif>
                    <td align="center">#tLevel#&nbsp;</td>
                  </cfif>

				<td align="center">#dateformat(entdt,"mm/dd/yyyy")#&nbsp;</td>

                  <td align="center"><input type="Checkbox" name="Del_box" value="#seq#" <cfif del EQ 1> disabled checked</cfif>>&nbsp;</td>
                </tr>
              </cfloop>
            </cfoutput>
            <!--- School Partner --->
            <cfelse>
            <tr>
              <th width="450">Target School or District</th>
              <th>Delete</th>
            </tr>
            <tr>
              <td <cfif session.fy LTE 2006>colspan="8"<cfelse>colspan="5"</cfif>><hr></td>
            </tr>
            <cfset delline=0>
            <cfoutput>
              <cfloop query="collaborators" >
                <cfif district EQ "">
                  <cfset district = 0>
                </cfif>
                <cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="selectschools">
                select
                <cfif school NEQ "" and School NEQ 999>
                  d.district_name + ': ' + s.InstitutionName
                  <cfelse>
                  d.district_name
                </cfif>
                as name from
                <cfif school NEQ "" and School NEQ 999>
                  nysed_school as s, nysed_district as d
                  <cfelse>
                  nysed_district as d
                </cfif>
                where
                <cfif school NEQ "" and School NEQ 999>
                  s.bedscode='#school#' 
				  and s.district=d.district_id				  
                  <cfelse>
                  ((district_id='0' + '#district#') OR (district_id='#district#'))
                </cfif>
                </cfquery>
				
				
				
				
				
				
                <cfif  del EQ 1>
                  <cfset delline=delline + 1>
                  <cfif delline EQ 1>
                    <tr>
                      <td><br>
                        <br></td>
                    </tr>
                    <tr bgcolor="Silver">
                      <th colspan="2" align="left">Deleted Collaborators:</th>
                    </tr>
                    <tr bgcolor="Silver">
                      <td colspan="2"><br></td>
                    </tr>
                  </cfif>
                </cfif>
                <tr <cfif del EQ 1>bgcolor="Silver"</cfif>>
                  <td><a href="collaborators.cfm?#session.urltoken#&seq=#seq#">#selectschools.name#</a> <cfif collaborators.sodistrict EQ 1 and collaborators.school NEQ "999">(Stand-alone as district for reporting)</cfif></td>
                  <td align="center"><input type="Checkbox" name="Del_box" value="#seq#" <cfif del EQ 1> disabled checked</cfif>></td>
                </tr>
              </cfloop>
            </cfoutput>
          </cfif>
          <tr>
            <td <cfif session.fy LTE 2006>colspan="8"<cfelse>colspan="6"</cfif> align="right"><!--- <input type="Button" name="del_staff" value="Delete" onclick="submit();" >
	<input type="Button" name="del_staff" value="Delete" onclick="submit();" style="background-color: ##663333;" >
	 --->
              <input type="Button" name="del_staff" value="Delete" onclick="submit();" class="DelButton">
            </td>
          </tr>
        </table>
        </td>
        <td></td>
        </tr>
	<!--- 	<cfif collaboratorsSum.recordcount GT 0 and session.modality EQ 1>
			<tr><td><br></td></tr>
		<tr>
			<td colspan="2"  align="center">
			<div>Number of HCPOs by partner level and organization type</div>
				<table class="box" cellpadding="10" cellspacing="0"> 
				<tr>
					<th style="border-bottom: 2px solid black; margin:20; padding: 5;" >Organization Type</th>
					<th style="border-bottom: 2px solid black; margin:20; padding: 5;" >Potential</th>
					<th style="border-bottom: 2px solid black; margin:20; padding: 5;" >Limited</th>
					<!--- <th style="border-bottom: 2px solid black; margin:20; padding: 5;" >Maintenance</th> --->
					<th style="border-bottom: 2px solid black; margin:20; padding: 5;" >Full</th>
					<th style="border-bottom: 2px solid black; margin:20; padding: 5;" >Not Selected</th>
				</tr>
				<cfoutput>
				<cfloop query="CollaboratorsSum">
					<tr>
						<td style="border-bottom: 1px solid black; margin:20; padding: 5;">#Type#</td>
						<td style="border-bottom: 1px solid black; margin:20; padding: 5;" align="center">#PotCt#</td>
						<td style="border-bottom: 1px solid black; margin:20; padding: 5;" align="center">#LtdCt#</td>
						<!--- <td style="border-bottom: 1px solid black; margin:20; padding: 5;" align="center">#MaintCt#</td> --->
						<td style="border-bottom: 1px solid black; margin:20; padding: 5;" align="center">#FullCt#</td>
						<td style="border-bottom: 1px solid black; margin:20; padding: 5;" align="center">#noCt#</td>
					
					</tr>
				</cfloop>
				</cfoutput>
				</table>
			</td>
		</tr>
		</cfif> --->
		
        </table>
      </cfif>
      </table></td>
  </tr>
  </table>
  </td>
  </tr>
  </table>
</CFFORM>
</body>
</html>
