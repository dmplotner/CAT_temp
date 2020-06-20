<cfif isDefined("form.donFlush")>
	<cfset toughtimes = #form.donFlush#>
</cfif>
	<cfparam name="toughtimes" default="99">
<link href="ddmenu.css" rel="stylesheet" type="text/css">
<cfform name="submitCollab" action="prc_collaborator.cfm?#session.urltoken#">
  <input type="hidden" name="recordSeq2" value="">
  <input type="Hidden" name="addUser" value="">

  
   <cfquery datasource="#application.DataSource#"  		
	password="#application.db_password#"   		
	username="#application.db_username#" name="collaborators">
  select c.name, c.indOrg, c.traditional, o.type, c.county, 
  c.seq , c.unit, 
case when c.unit IS NULL then c.NAME else c.unit + ' ' + NAME end as unitname , 
  del, case tHCPO when 0 then 'No' when 1 then 'Yes' else '-' end as tHCPO, 
case tLevel 
	when 1 then 'Full' 
	when 2 then 'Limited' 
	when 3 then 'Maintenance'
	when 0 then 'Inactive'
	else '-' end as tLevel, 
	
	case timprovement when 1 then 'Yes' else 'No' end  as timprovement,
  c.school, c.district , isnull(c.sodistrict,0) as sodistrict, isNull(c.sfy, 0) as sfy,
d.district_name,
s.institutionname
  from collaborators as c 
left outer join  orgtype as o on o.indorg=c.indorg and o.num = c.type and o.year2=c.year2 
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
 <cfif session.modality EQ 4>order by 17, 18 --13, 12<Cfelse> order by 8,7,1</cfif>
  
  <!--- union 
  select c.name, c.indOrg, c.traditional, '', c.county, c.seq , 
  c.unit, c.unit as unitname , del, cast(tHCPO as varchar(50)) as tHCPO, 
cast(tLevel as varchar(50)) as tLevel, c.school, 
  c.district from collaborators as c 
  where userid = '#session.userid#' <!--- and c.year2=#session.fy# --->
  <!--- and (c.del is null or c.del != 1) --->
  and c.name is null 
    and (c.del is null or c.del !=1)
  <cfif session.modality EQ 4>
  and c.district is not null
  <cfelse>
  and c.county is not null
  </cfif>
  order by 9,8 --->
  
  </cfquery>
  
<cfquery datasource="#application.DataSource#"  		
	password="#application.db_password#"   		
	username="#application.db_username#" name="collaboratorsSum">
  select isNull(o.type, '-- Not selected --') as type,

sum(case tlevel when 1 then 1 else 0 end) as FullCt,
sum(case tlevel when 2 then 1 else 0 end) as LTdCt,
sum(case tlevel when 3 then 1 else 0 end) as MaintCt,
sum(case tlevel when 0 then 1 else 0 end) as InactCt,
sum(case tlevel when 0 then 0 when 1 then 0 when 2 then 0 when 3 then 0 else 1 end) as noCt

 from collaborators as c left outer join  orgtype as o on o.indorg=c.indorg and o.num = c.type and o.year2=c.year2 
  where userid = '#session.userid#' and (c.year2 >=1904)
 
 and (c.del is null or c.del !=1)
  <cfif session.modality EQ 4>
  and c.district is not null
  <cfelse>
  and c.county is not null
  </cfif>
group by o.type
 order by 1
  
  </cfquery>
  
 
  <cfif CGI.HTTP_REFERER contains "collaborators.cfm" and NOT isDefined("URL.hide")>
    <script type="text/javascript">
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
<cfelseif session.modality EQ 4>
if(document.submitCollab.district.selectedIndex==0){alert("Please select a district."); return false;}

<cfif session.fy GT 2010>
var radio_choice = false; 
for (counter = 0; counter < document.submitCollab.solunch.length; counter++){
if (document.submitCollab.solunch[counter].checked)
radio_choice = true; 
}
if (!radio_choice)
{
alert('Please answer the question about free and reduced lunch status and click \'Add/update\' again.');
return false;
}

</cfif>
if(document.submitCollab.sfy.selectedIndex==0){alert("Please select which reporting period you began working with this school or district."); return false;}

</cfif>
document.submitCollab.addUser.value="add";
} 
</script>
    <cfif isDefined("url.seq")>
		<cfset toughtimes = 1>
		
      <cfquery datasource="#application.DataSource#"  		 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qcollab_UPD">
      select c.name, c.indOrg, c.traditional, c.type, c.county, c.seq , c.unit, 
	  case when c.unit IS NULL then c.NAME else c.unit + ' ' + NAME end as unitname , timprovement,
	  tHCPO, tLevel from collaborators as c where userid = '#session.userid#' 
	  <!--- and c.year2=#session.fy# ---> and c.seq = #url.seq#
      </cfquery>
      <cfif Qcollab_UPD.recordcount GT 0>
        <cfset form.collabname = Qcollab_UPD.name>
        <cfset form.traditional = Qcollab_UPD.traditional>
        <cfset form.collabtype = Qcollab_UPD.type>
        <cfset form.jurisdiction = Qcollab_UPD.county>
        <cfset form.indOrg = Qcollab_UPD.indorg>
        <cfset form.unit = Qcollab_UPD.unit>
        <cfset form.recordSeq = Qcollab_UPD.seq>
        <cfset form.tHCPO = Qcollab_UPD.tHCPO>
        <cfset form.tLevel = Qcollab_UPD.tLevel>
		<cfset form.timprovement = Qcollab_UPD.timprovement>
      </cfif>
    </cfif>
    <cfif isDefined("form.recordSeq2") and form.recordSeq2 EQ "-1">
      <cfset form.collabname = "">
      <cfset form.traditional = "">
      <cfset form.collabtype = "">
      <cfset form.jurisdiction = "">
      <cfset form.indOrg = "">
      <cfset form.unit = "">
      <cfset form.recordSeq = "-1">
      <cfset form.tHCPO = "">
      <cfset form.tLevel = "">
	  <cfset form.timprovement = "">
    </cfif>

    <cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="countyheadache">
    select catchment from contact where userid = '#session.userid#'
    </cfquery>
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
		
    <cfquery datasource="#application.DataSource#" 
	password="#application.db_password#"   		
	username="#application.db_username#" name="orgTypes">
    select type, heading, num from orgType where indOrg =
    <cfif isDefined("form.indOrg") and form.indOrg EQ "1" and session.fy LT 2007>
      1
      <cfelse>
      2
    </cfif>
    and year2=#session.fy# order by 2,1,3
    </cfquery>
    <script language="JavaScript">
var sPath = window.location.pathname;
//var sPage = sPath.substring(sPath.lastIndexOf('\\') + 1);
var sPage = sPath.substring(sPath.lastIndexOf('/') + 1);



function presubmit(){
document.submitCollab.action="collaborators.cfm<cfoutput>?#session.urltoken#</cfoutput>"; 
document.submitCollab.donFlush.value=1;
document.submitCollab.submit();
}

function presubmit2(){
document.submitCollab.action="collaborators.cfm<cfoutput>?#session.urltoken#</cfoutput>"; 
document.submitCollab.donFlush.value=1;
document.submitCollab.recordSeq.value=-2;
document.submitCollab.submit();

}

</script>
    <table class="box" align="left" cellpadding="10" cellspacing="3" border="0" width="100%">
      <cfif isDefined("form.recordSeq")>
        <input type="Hidden" name="recordSeq" value="<cfoutput>#form.recordSeq#</cfoutput>">
      <cfelse>
		<input type="Hidden" name="recordSeq" value="-1">
	</cfif>
      <cfif SESSION.modality NEQ 4>
        <tr>
        <td colspan="4" align="center">
        
        <table class="Table" border="1" width="75%" >
        
        <tr>
          <th colspan="3"><Cfif session.fy GT 2006 and session.modality EQ 1>Target Health Care Provider Organizations (HCPOs):<cfelse>Collaborators: <A HREF="javascript:void(0)"onclick="window.open('#application.basename#/dictionary.cfm##coll','_blank','height=500, width=700,scrollbars=yes')"><img SRC="images/book07.gif"  width="20" height="20" BORDER="0" ALT="Help"></a></cfif></th>
        </tr>
        <cfoutput>
		<cfif session.fy LT 2007 or session.fy LT 1920>
          <tr>
            <td colspan="2" align="center"><input type="Radio" name="indOrg" value="2" onClick="presubmit();" <cfif (isDefined("form.indOrg") and form.indOrg EQ "2") OR (isDefined ("Qcollab_UPD.indorg") and Qcollab_UPD.indorg EQ "2") OR NOT isDefined("form.indOrg")> checked</cfif>>
              Organization&nbsp;&nbsp;&nbsp;&nbsp;
              <input type="Radio" name="indOrg" value="1" onClick="presubmit();" <cfif (isDefined("form.indOrg") and form.indOrg EQ "1") OR (isDefined ("Qcollab_UPD.indorg") and Qcollab_UPD.indorg EQ "1")> checked</cfif>>
              Individual</td>
          </tr>
		  </cfif>
          <tr>
            <td colspan="2"><!--- 	Collaborator Name<cfif session.modality EQ 1> (specifically unit/department name IF one of several units/departments within the same hospital/organization</cfif> --->
              </td>
          </tr>
          <tr>
            <td><cfif session.fy LT 2007 and session.fy GT 1920>Collaborator<cfelse>Target HCPO</cfif></td>
            <td><input type="text" size="50" name="collabName"<cfif isDefined("form.collabName")> value="#form.collabName#"</cfif>>
            </td>
          </tr>
		  
		  
		  
		   <cfif session.modality EQ 1>
              <cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QUnitNames">
              select distinct Unit from collaborators where userid='#session.userid#' and unit != '' order by 1
              </cfquery>
              <tr>
                <td colspan="2"><!--- 	Hospital/organization name IF you have multiple units/departments within this hospital/organization --->
                  Umbrella organization (e.g., hospital which has multiple departments) </td>
              </tr>
              <tr>
                <td>Select from list, or enter a new umbrella organization</td>
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
                  <input type="Text" name="newUnit" size="35">
                </td>
              </tr>
			  </cfif>
		  
		  
		  
          <cfif session.fy LT 2007 and session.fy GT 1920>
		  <tr>
            <td colspan="2" align="center">Non-Traditional?<A HREF="javascript:void(0)"onclick="window.open('#application.basename#/dictionary.cfm##ntc','_blank','height=500, width=700,scrollbars=yes')"><img SRC="images/book07.gif"  width="20" height="20" BORDER="0" ALT="Help"></a>&nbsp;&nbsp;&nbsp;
              <input type="Radio" name="traditional" value="1" <cfif (isDefined("form.traditional") and form.traditional EQ "1")> checked</cfif>>
              Yes&nbsp;&nbsp;&nbsp;&nbsp;
              <input type="Radio" name="traditional" value="0" <cfif (isDefined("form.traditional") and form.traditional EQ "0") OR NOT isDefined("form.traditional")> checked</cfif>>
              No</td>
          </tr>
		  </cfif>
        </cfoutput>
		
        <tr>
          <td>Organization Type</td>
          <td>
		  <cfif session.fy LT 2007>
		  	<select name="collabType">
              <optgroup id="" label="">
              <option value="999"> 
              <cfoutput query="orgTypes" group="heading">
                <optgroup id="#heading#" label="#heading#">
                <cfoutput>
                  <option value="#num#" <cfif isDefined("form.collabType") and listCOntains(form.collabType,num)> selected</cfif>>
                  #type# </cfoutput>
                </optgroup>
              </cfoutput>
            </select>
		  <cfelse>
		  
		 
		  <select name="collabType">
              <option value="999"> 
              <cfoutput query="orgTypes">
                  <option value="#num#" <cfif isDefined("form.collabType") and listCOntains(form.collabType,num)> selected</cfif>>
                  #type# 
              </cfoutput>
            </select>
			 </cfif>
          </td>
        </tr>
		
        <tr>
          <td> County of residence,<br>
            jurisdiction,<br>
            or coverage</td>
          <td><cfselect name="Jurisdiction"  multiple size="6" class="mlti" required="Yes" message="Please select at least one county of Jurisdiction">
              <cfoutput>
                <cfloop query="counties" >
                  <option value="#FIPS#"  <cfif isDefined("form.Jurisdiction") and listContains(form.Jurisdiction,FIPS)> selected</cfif>>#countyName#
                </cfloop>
              </cfoutput>
              <option value="88888" <cfif isDefined("form.Jurisdiction") and listContains(form.Jurisdiction,"88888")> selected</cfif>>Counties beyond catchment area
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
              <td>Level of partner?</td>
              <td><input type="radio" name="tLevel" value="1" <cfif isDefined("form.tLevel") and form.tLevel EQ 1> checked</cfif> >
                Full Partner<br>
                <input type="radio" name="tLevel" value="2" <cfif isDefined("form.tLevel") and form.tLevel EQ 2> checked</cfif> >
                Limited Partner<br>
				<cfif session.fy GT 2008>
				<!--- <input type="radio" name="tLevel" value="3" <cfif isDefined("form.tLevel") and form.tLevel EQ 3> checked</cfif> >
                Maintenance <br> --->
				<input type="radio" name="tLevel" value="0" <cfif isDefined("form.tLevel") and form.tLevel EQ 0> checked</cfif> >
                Inactive <br>
				</cfif>
              </td>
            </tr>
			<cfif session.fy GT 2008>
			<tr>
              <td>Performance Improvement Project?</td>
              <td><input type="radio" name="timprovement" value="1" <cfif isDefined("form.timprovement") and form.timprovement EQ 1> checked</cfif> >
                Yes <br>
                <input type="radio" name="timprovement" value="0" <cfif isDefined("form.timprovement") and form.timprovement EQ 0> checked</cfif> >
                No 
              </td>
            </tr>
           </cfif>
        </cfif>
        
		
		
		<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="selectContact">
        Select orgName, partnerType, agent, grantNum, street1, street2, city, state, zip, contact, title, phone, fax, email, catchment from contact where userid = '#session.userid#'
        </cfquery>
        <!--- Section for School partners --->
<cfelse>
		
		<cfif isDefined("URL.seq")>
				<cfset toughtimes = 1>
		<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="qselectedItem">
        Select 
		isnull(school,999) as school, 
		isnull(district,999) as district, sodistrict, sfy, solunch
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
		
		<tr><td>
        <table class="box" align="center" cellpadding="10" cellspacing="3" border="0" width="80%">
        <tr>
			<th colspan="2">Target Schools/School Districts</th>
		</tr>
        <tr>
          <td>School District:</td>
		  <td><cfoutput>
		          <select name="district" onChange="presubmit();">
                <option value="999" >-Please Select a District-</option>
				<cfloop query="selectdistrict">
                  <option value="#district_id#" <cfif ((isDefined("form.district") and form.district EQ district_id) OR ( isDefined("qselectedItem") and qselectedItem.district EQ district_id))  AND <!---isDefined("form.recordSeq")  and form.recordSeq NEQ -1  and (and ---> toughtimes EQ 1 > Selected</cfif>>#district_name#</option>
                </cfloop>
              </select>
            </cfoutput> </td>
        </tr>
        <tr>
          <td>School Building:</td>
		  <td><cfoutput>
              <select name="school" onChange="checkDsp();">
                <option value="999" >All Schools</option>
                <cfloop query="selectschools">
                  <option value="#BEDSCode#" <cfif ((isDefined("form.school") and form.school EQ BEDSCode) OR  ( isDefined("qselectedItem") and qselectedItem.school EQ BEDSCode)) AND (isDefined("form.recordSeq") and form.recordSeq NEQ -1)> Selected</cfif>>#institutionname#</option>
                </cfloop>
              </select>
            </cfoutput> </td>
        </tr>
		
		<tr>
          <td colspan="2">Check here if school should be treated as a stand-alone district for reporting <cfoutput>
              <input type="checkbox" name="sodistrict" value=1 <cfif (isDefined("form.sodistrict") and form.sodistrict EQ 1) OR (isDefined("qselectedItem.sodistrict") and qselectedItem.sodistrict EQ 1) AND (isDefined("form.recordSeq") and form.recordSeq NEQ -1)>checked</cfif> onClick="presubmit2();">
            </cfoutput> </td>
        </tr>
      
	<tr>
          <td >Free/Reduced Lunch Status of 50% or greater: </td>
		<td>
              <input type="radio" name="solunch" value=1 <cfif ((isDefined("form.solunch") and form.solunch EQ 1) OR ( isDefined("qselectedItem") and qselectedItem.solunch EQ 1) ) and (isDefined("form.recordSeq") and form.recordSeq NEQ -1)> checked</cfif>>  Yes <br>
			<input type="radio" name="solunch" value=0 <cfif ((isDefined("form.solunch") and form.solunch EQ 0) OR ( isDefined("qselectedItem") and qselectedItem.solunch EQ 0) ) and (isDefined("form.recordSeq") and form.recordSeq NEQ -1)> checked</cfif>> No <br>
			<input type="radio" name="solunch" value=2  <cfif ((isDefined("form.solunch") and form.solunch EQ 2) OR ( isDefined("qselectedItem") and qselectedItem.solunch EQ 2) ) and (isDefined("form.recordSeq") and form.recordSeq NEQ -1)> checked</cfif>> Unknown
		</td>
        </tr>
		
		<!--- <tr>
          <td>BEDSCODE:</td>
			<td><cfif isDefined("form.school")><cfoutput>#form.school#</cfoutput>
			<cfelseif isDefined("qselectedItem")><cfoutput>#qselectedItem.school#</cfoutput>
			<cfelseif isDefined("form.district")><cfoutput>#form.district#</cfoutput>
			<cfelseif isDefined("qselectedItem.sodistrict")><cfoutput>#qselectedItem.sodistrict#</cfoutput>
			</cfif></td>
        </tr> --->
    
		
		<tr>
			<td>During what reporting period did you begin working with this school district?</td>
			<td>
			 <cfoutput>
			 <select name="sfy">
				 <option value="">-Please select-</option>
                <cfloop query="selectspyears">
                  <option value="#year2#" <cfif ((isDefined("form.sfy") and form.sfy EQ year2)OR (isDefined("qselectedItem.sfy") and qselectedItem.sfy EQ year2)) AND (isDefined("form.recordSeq") and form.recordSeq NEQ -1)> Selected</cfif>>#dispyr#</option>
                </cfloop>
              </select>
            </cfoutput>
			</td>
		</tr>
       </cfif>
	  <tr>
		<td colspan="2" align="center"><!--- <input type="submit" name="add_collaborator" value="Add Collaborator" onclick="return add();">
<input type="submit" name="add_collaborator" value="Add Collaborator" onclick="return add();" style="background-color: #336633;" >
 --->
        <cfif (session.fy LT 2011 or (session.fy GT 2010 and session.modality NEQ 4) )>  
		<input type="submit" name="add_collaborator" value="Add/Update<!---  <cfif session.fy GT 2006 and session.modality EQ 1>Target HCPO<cfelse>Collaborator</cfif> --->" onclick="return add2();"  class="AddButton" >
		</cfif>
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
              <tr>
                <td colspan="2"><table width="90%" class="box" align="center">
                    <tr>
                      <td >
					   <cfif session.fy GT 2006 and session.modality EQ 1>
					   <strong>Examples</strong>: How to enter Target HCPO Name and Umbrella Organization.
					   <cfelse>
					   How to enter collaborator name and umbrella organization: Examples of three target HCPOs
					   </cfif> <br>
                        <ul>
                          <li class="detlist">Lewis Medical Group: This target HCPO would have a <cfif session.fy GT 2006 and session.modality EQ 1>target HCPO<cfelse>collaborator</cfif> name of Lewis Medical Group, and the field “umbrella organization” would be blank. </li>
                          <li class="detlist">Fulton Hospital, Pulmonary Unit and Internal Medicine Unit: This would be entered as two <cfif session.fy GT 2006 and session.modality EQ 1>Target HCPOs<cfelse>Collaborators</cfif>. The first entry would have a <cfif session.fy GT 2006 and session.modality EQ 1>target HCPO<cfelse>collaborator</cfif> name of Pulmonary Unit with an umbrella organization of Fulton Hospital. A separate <cfif session.fy GT 2006 and session.modality EQ 1>target HCPO<cfelse>collaborator</cfif> entry would be made with a <cfif session.fy GT 2006 and session.modality EQ 1>target HCPO<cfelse>collaborator</cfif> name of Internal Medicine Unit with an umbrella organization of Fulton Hospital. </li>
                          <li class="detlist">Allegany Medical Group, Midtown Clinic: This HCPO would be entered with a <cfif session.fy GT 2006 and session.modality EQ 1>target HCPO<cfelse>collaborator</cfif> name of Midtown Clinic with an umbrella organization of Allegany Medical Group (IF you are working with multiple clinics within the same group). </li>
                        </ul></td>
                    </tr>
                  </table></td>
              </tr>
            <!--- </cfif> --->
          </cfif>
   
  </cfif>

<cfif session.modality EQ 4 and session.fy GTE 2011>
	<tr>
    <td colspan="100%">
	<table>
		<tr><td>
      
	<cfinclude template="sp_baseline.cfm"> 
	</td></tr>
</table></td></tr>
</cfif>



	<tr>
		<td colspan="2" align="center"><!--- <input type="submit" name="add_collaborator" value="Add Collaborator" onclick="return add();">
<input type="submit" name="add_collaborator" value="Add Collaborator" onclick="return add();" style="background-color: #336633;" >
 --->
        <cfif (session.fy GT 2010 and session.modality EQ 4 AND (isDefined("qselectedItem.district") OR (isDefined("form.recordSeq") and (form.recordSeq EQ -1 or form.recordSeq EQ -2))))>  
		<input type="submit" name="add_collaborator" value="Add/Update<!---  <cfif session.fy GT 2006 and session.modality EQ 1>Target HCPO<cfelse>Collaborator</cfif> --->" onclick="return add2();"  class="AddButton" >
		</cfif>
        </td>
      </tr>


  <tr>
    <td colspan="100%"><table>
      <tr>
      <td>
      <br>
	
	<cfif session.fy GT 2010 AND NOT(isDefined("qselectedItem.district") OR (isDefined("form.recordSeq") and form.recordSeq EQ -1))>
      <div> 
	Select a Link below to update a 
	  <cfif session.fy GT 2006 and session.modality EQ 1>Target HCPO<cfelseif session.modality EQ 4>Target School or District<cfelse>collaborator</cfif>, or click on
        <input type="button"  value="Add New <cfif session.fy GT 2006 and session.modality EQ 1>Target HCPO<cfelseif session.modality EQ 4>Target School or District<cfelse>Collaborator</cfif>" onClick="document.submitCollab.recordSeq2.value='-1';document.submitCollab.action='collaborators.cfm<cfoutput>?#session.urltoken#</cfoutput>';document.submitCollab.submit();";>
        to add a new <cfif session.fy GT 2006 and session.modality EQ 1>Target HCPO<cfelseif session.modality EQ 4>Target School or District<cfelse>collaborator</cfif>
		</div>
	</cfif>
      <br>
      <cfif collaborators.recordcount GT 0>
        <table  class="boxy"  border="0" cellpadding="0" cellspacing="0" >
          <cfif session.modality NEQ 4>
            <tr>
              <th width="400"><cfif session.fy LTE 2006>Collaborator Name<cfelse>Target HCPO</cfif></th>
              <cfif session.fy LTE 2006>
			  <th width="80" align="center">Individual<br>
                or<br>
                Organization</th>
              <th width="60">Non-<br>Tradit</th>
			  </cfif>
              <th width="200">Type</th>
              <th width="90">County of Residence,<br>
                Jurisdiction,<br>
                Coverage</th>
              <cfif session.modality EQ 1 
		or session.cessMan EQ 1 
		or session.TCP eq 1 
		or session.Admin EQ 1
		or session.AreaManage EQ 1>
		 <cfif session.fy LTE 2006>
                <th width="20">Target<br>
                  HCPO</th></cfif>
                <th width="80">Partner<br>
                  Level</th>
              </cfif>
			<cfif session.fy GTE 2009>
			<th width="40">PIP</th>
			</cfif>
              <th>Delete</th>
            </tr>
            <tr>
              <td <cfif session.fy LTE 2006>colspan="8"<cfelse>colspan="5"</cfif></td>
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
                  <td><a href="collaborators.cfm?#session.urltoken#&seq=#seq#">
                    <cfif unit NEQ "">
                      #unit# -
                    </cfif>
                    #name# </a></td>
                  <cfif session.fy LTE 2006>
				  <td><cfif indorg EQ 2>
                      Organization
                      <cfelse>
                      Individual
                    </cfif></td>
                  <td align="center">
				  	<cfif traditional EQ 1>Yes<cfelse>No</cfif></td>
					</cfif>
                  <td>#type#</td>
                  <td><cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="countyDetails">
                    select CountyName from counties where FIPS in (#county#) order by 1
                    </cfquery>
                    #valuelist(countyDetails.countyname)#</td>
                  <cfif session.modality EQ 1 
		or session.cessMan EQ 1 
		or session.TCP eq 1 
		or session.Admin EQ 1
		or session.AreaManage EQ 1>
                     <cfif session.fy LTE 2006><td align="center">#tHCPO#</td></cfif>
                    <td align="center">#tLevel#</td>
                  </cfif>
				<cfif session.fy GTE 2009>
				<td align="center">#tImprovement#</td>
				</cfif>
                  <td align="center"><input type="Checkbox" name="Del_box" value="#seq#" <cfif del EQ 1> disabled checked</cfif>></td>
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
              <td <cfif session.fy LTE 2006>colspan="8"<cfelse>colspan="5"</cfif>></td>
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
            <td <cfif session.fy LTE 2006>colspan="8"<cfelse>colspan="6"</cfif>><!--- <input type="Button" name="del_staff" value="Delete" onclick="submit();" >
	<input type="Button" name="del_staff" value="Delete" onclick="submit();" style="background-color: ##663333;" >
	 --->
              <input type="Button" name="del_staff" value="Delete" onclick="submit();" class="DelButton">
            </td>
          </tr>
        </table>
        </td>
        <td></td>
        </tr>

		<!--- <cfinclude template="sp_baseline.cfm"> --->

<!--- <tr>
		<td colspan="2" align="center"><!--- <input type="submit" name="add_collaborator" value="Add Collaborator" onclick="return add();">
<input type="submit" name="add_collaborator" value="Add Collaborator" onclick="return add();" style="background-color: #336633;" >
 --->
        <cfif (session.fy GT 2010 and session.modality EQ 4 )>  
		<input type="submit" name="add_collaborator" value="Add/Update<!---  <cfif session.fy GT 2006 and session.modality EQ 1>Target HCPO<cfelse>Collaborator</cfif> --->" onclick="return add2();"  class="AddButton" >
		</cfif>
        </td>
      </tr> --->

<!--- dptest --->
  </table>
      </cfif>
	
	
<!--- 	<tr>
		<td colspan="2" align="center"><!--- <input type="submit" name="add_collaborator" value="Add Collaborator" onclick="return add();">
<input type="submit" name="add_collaborator" value="Add Collaborator" onclick="return add();" style="background-color: #336633;" >
 --->
        <cfif (session.fy GT 2010 and session.modality EQ 4 )>  
		<input type="submit" name="add_collaborator" value="Add/Update<!---  <cfif session.fy GT 2006 and session.modality EQ 1>Target HCPO<cfelse>Collaborator</cfif> --->" onclick="return add2();"  class="AddButton" >
		</cfif>
        </td>
      </tr> --->
      </table>


</td>
  </tr>


  </table>
  </td>
  </tr>


  </table> 
<input type="Hidden" name="donFlush" value="99">


</cfform>

<table><tr><td><table><tr><td><table><cfif collaborators.recordcount GT 0><table>



		<cfif collaboratorsSum.recordcount GT 0 and session.modality EQ 1>
			<tr><td><br></td></tr>
		<tr>
			<td colspan="2"  align="center">
			<div>Number of HCPOs by partner level and organization type</div>
				<table class="box" cellpadding="10" cellspacing="0"> 
				<tr>
					<th style="border-bottom: 2px solid black; margin:20; padding: 5;" >Organization Type</th>
					<th style="border-bottom: 2px solid black; margin:20; padding: 5;" >Limited</th>
					<th style="border-bottom: 2px solid black; margin:20; padding: 5;" >Full</th>
					<!--- <th style="border-bottom: 2px solid black; margin:20; padding: 5;" >Maintenance</th> --->
					<th style="border-bottom: 2px solid black; margin:20; padding: 5;" >Inactive</th>
					<th style="border-bottom: 2px solid black; margin:20; padding: 5;" >Not Selected</th>
				</tr>
				<cfoutput>
				<cfloop query="CollaboratorsSum">
					<tr>
						<td style="border-bottom: 1px solid black; margin:20; padding: 5;">#Type#</td>
						<td style="border-bottom: 1px solid black; margin:20; padding: 5;" align="center">#LtdCt#</td>
						<td style="border-bottom: 1px solid black; margin:20; padding: 5;" align="center">#FullCt#</td>
						<!--- <td style="border-bottom: 1px solid black; margin:20; padding: 5;" align="center">#MaintCt#</td> --->
						<td style="border-bottom: 1px solid black; margin:20; padding: 5;" align="center">#InactCt#</td>
						<td style="border-bottom: 1px solid black; margin:20; padding: 5;" align="center">#noCt#</td>
					
					</tr>
				</cfloop>
				</cfoutput>
				</table>
			</td>
		</tr>
		</cfif>
		
        </table>
      </cfif>
      </table></td>
  </tr>
  </table>
  </td>
  </tr>
  </table>
<!--- </CFFORM> --->

<cfif session.fy GT 2010 >
<script language="javascript">
<cfif isDefined("qselectedItem.school") and qselectedItem.school EQ '999'>
	showSect();
<cfelseif  isDefined("qselectedItem.school") and qselectedItem.school NEQ '999'>
	hideSect();
<cfelse>
	hideSect();
</cfif>
checkDsp();
</script>
</cfif>
</body>
</html>
