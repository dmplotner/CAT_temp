<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
<title>CAT</title>

<cfinclude template="CATstruct.cfm">
<script language="JavaScript">



function flip(){

for(var i = 0; i < document.submitContact.catchment.length; i++){ 
document.submitContact.catchment[i].selected = true;
}
if (isdefined(document.submitContact.catchment)=="undefined"){
alert('Please select at least one county within your catchment area!');
return false;
}
}
</script>

<table class="box2" align="left" cellpadding="10" cellspacing="3" border="0" width="100%">	
<cfform name="submitContact" action="prc_contact.cfm?#session.urltoken#">
<!--- <table align="left" cellpadding="10" cellspacing="0" border="0" style="border:15px ridge #ff0000">	 --->	

	

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="partnerTypes">
	select heading, type, rank from partnerTypes
	where year2=#session.fy#
	order by 1, 2
	
</cfquery>



<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="indTypes">
	select type 
	from indType
	where year2=#session.fy#
	order by 1
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="selectContact">
	Select
	orgName, 
	partnerType, 
	agent, agentName, agentPhone, agentEmail, 
	grantNum, 
	street1, 
	street2, 
	city, 
	state, 
	zip, 
	contact, 
	title, 
	phone, 
	fax, 
	email, 
	website, vouchers, 
	catchment
	from contact
	where 
	userid = '#session.userid#'
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="counties">
	select countyName, FIPS from counties 
	where
	<cfoutput><cfif (selectContact.recordcount GT 0) and (selectContact.catchment NEQ "")>  FIPS NOT IN (<cfloop list="#selectContact.catchment#" index="mycounty">'#mycounty#', </cfloop>'0') and </cfif></cfoutput>
	FIPS < 88888 order by 2
	
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="catchmentCounties">
	select countyName, FIPS from counties 
	where FIPS in <cfif (selectContact.recordcount GT 0) and (selectContact.catchment NEQ "")>(#selectContact.catchment#)<cfelse>(0)</cfif>
	
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="partnerTypes">
	select distinct heading, num 
	from partnerTypes
	where year2=#session.fy#
	order by num
</cfquery>

<table class="box" cellpadding="10" cellspacing="0" border="0" width="100%"  >

<tr><th colspan="4"> Contact Information:</th></tr>
<tr><td>Partner Organization Name</td><td colspan="3"><cfinput type="text" name="orgName" value ="#selectContact.orgName#" required="Yes" maxlength="180" size="75"><br>(i.e.  Big NY City Reality Check, Rural Area Tobacco-free Community Partnership)</td></tr> 
<tr><td>Partner Type</td><td>


<cfselect name="partnerType" required="Yes">
 <cfoutput>
 <cfloop query="partnerTypes">
 	<option value="#num#" <cfif selectContact.partnerType EQ "#num#"> selected</cfif>>#heading#
 </cfloop> 
 </cfoutput> 
   
</cfselect>
</td></tr> 




<tr><td>Grant Number</td><td><cfinput type="text" name="grant" value ="#selectContact.grantNum#" maxlength="180" size="50"></td></tr>
<tr><td>Street Address</td><td><cfinput type="text" name="street1" value ="#selectContact.street1#" maxlength="180" size="50"></td></tr>
<tr><td align="right">(continued)</td><td><cfinput type="text" name="street2" value ="#selectContact.street2#" maxlength="180" size="50"></td></tr>
<tr><td>City</td><td><cfinput type="text" name="city" value ="#selectContact.city#" maxlength="180" size="50"></td></tr>

<input type="Hidden" name="us_states" value="NY">

<tr><td>Zip</td><td><cfinput type="text" name="zip" validate="zipcode" value ="#selectContact.zip#" maxlength="180" ></td></tr>
<tr><td>Primary Contact Person </td><td><cfinput type="text" name="contact" value ="#selectContact.contact#" maxlength="180" ></td></tr>
<tr><td>Title</td><td><cfinput type="text" name="title" value ="#selectContact.title#" maxlength="180" size="50">(i.e. Project Coordinator, Project Manager)</td></tr>
<tr><td>Phone </td><td><cfinput type="text" name="phone"  value ="#selectContact.phone#" maxlength="180" ></td></tr>
<tr><td>Fax</td><td><cfinput type="text" name="fax" value ="#selectContact.fax#" maxlength="180" ></td></tr> 
<tr><td>E-mail address</td><td><cfinput type="text" name="email" value ="#selectContact.email#" maxlength="180" size="50"></td></tr>
<tr><td>Website</td><td><cfinput type="text" name="website" value ="#selectContact.website#" maxlength="180" size="50"></td></tr>

<tr><td>Fiscal Agent </td><td><cfinput type="text" name="agent" value ="#selectContact.agent#" maxlength="180" size="50"></td></tr> 

<tr><td>Fiscal Agent Name </td><td><cfinput type="text" name="agentname" value ="#selectContact.agentname#" maxlength="180" size="50"></td></tr> 

<tr><td>(Agent)Phone </td><td><cfinput type="text" name="agentPhone" value ="#selectContact.agentPhone#" maxlength="180" ></td></tr> 
<tr><td>(Agent)E-mail </td><td><cfinput type="text" name="agentEmail" value ="#selectContact.agentEmail#" maxlength="180" size="50"></td></tr> 
<tr><td>Vouchers</td><td>
<cfif selectContact.vouchers EQ 1>
	<cfinput type="radio" name="vouchers" value ="1" checked required="yes" message="Please select a value for vouchers">Monthly 
	<cfinput type="radio" name="vouchers" value ="2" required="yes" message="Please select a value for vouchers">Quarterly
<cfelseif selectContact.vouchers EQ 2>
	<cfinput type="radio" name="vouchers" value ="1" required="yes" message="Please select a value for vouchers">Monthly 
	<cfinput type="radio" name="vouchers" value ="2"  checked required="yes" message="Please select a value for vouchers">Quarterly

<cfelse>
	<cfinput type="radio" name="vouchers" value ="1" required="yes" message="Please select a value for vouchers">Monthly 
	<cfinput type="radio" name="vouchers" value ="2" required="yes" message="Please select a value for vouchers">Quarterly

</cfif>


<!--- 	<input type="radio" name="vouchers" value ="1" <cfif selectContact.vouchers EQ 1> checked</cfif>>Monthly <input type="radio" name="vouchers" value ="2" <cfif selectContact.vouchers EQ 2> checked</cfif>>Quarterly
 --->	</td></tr> 
<tr><td align="center"  valign="top" colspan="2">
<table class="Table" width="70%" cellpadding="10" border=0>
<tr><th colspan="3">Catchment area</th></tr>
<tr>
<td align="right" valign="top">
NY Counties: <br><select name="allcounties" multiple size="5" class="mlti">
<cfoutput>
<cfloop query="counties">
<option value="#countyName#">#countyName#
</cfloop> 
</cfoutput>
</select>
</td>
<td align="center"><NOBR> 
    <input type="button" style="width:90" onclick="moveDualList( this.form.allcounties,  this.form.catchment, false )"    name="Add     >>"  value="Add       >>" class="AddButton">     <BR>



    <NOBR>   
	<input type="button" style="width:90" onclick="moveDualList( this.form.catchment, this.form.allcounties,  false )"    name="<<  Remove"  value="<<   Remove">     <BR>



    <!--- <NOBR> 
	    <input type="button" style="width:90" onclick="moveDualList( this.form.allcounties,  this.form.catchment, true  )"    name="Add All >>"  value="Add All >>">     <BR>



    <NOBR>
    <input type="button" style="width:90" onclick="moveDualList( this.form.catchment, this.form.allcounties,  true  )"     name="<<Remove All "  value="<<Remove All ">     <BR>

    </NOBR> --->

  </td>

<td align="left"  valign="top">



Counties in your Catchment Area:<br><cfselect name="catchment" multiple size="5"  required="Yes" message="Please specify at least one county in your catchment area" class="mlti">
<cfoutput>
<cfloop list="#valuelist(catchmentCounties.countyName)#" index="county">
<option value="#county#">#county#
</cfloop> 
</cfoutput>
</cfselect>

</td></tr> 
</table>
</td></tr>





<tr><td><input type="submit" name="upd_contact_bt" value="Submit" onclick="flip();" ></td></tr>
</table></td></tr>



</cfform></table>

</body>

</html>
