<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>
			CAT
		</title>
		<cfinclude template="CATstruct.cfm">
		<script type="text/javascript">
<!-- This script and many more are available free online at -->

<!-- The JavaScript Source!! http://javascript.internet.com -->

<!-- Original:  Fred P -->

<!-- Begin

// Compare two options within a list by VALUES

function compareOptionValues(a, b)

{

  // Radix 10: for numeric values

  // Radix 36: for alphanumeric values

  var sA = parseInt( a.value, 36 );

  var sB = parseInt( b.value, 36 );

  return sA - sB;

}



// Compare two options within a list by TEXT

function compareOptionText(a, b)

{

  // Radix 10: for numeric values

  // Radix 36: for alphanumeric values

  var sA = parseInt( a.text, 36 );

  var sB = parseInt( b.text, 36 );

  return sA - sB;

}



// Dual list move function

function moveDualList( srcList, destList, moveAll )

{

  // Do nothing if nothing is selected

  if (  ( srcList.selectedIndex == -1 ) && ( moveAll == false )   )

  {

    return;

  }



  newDestList = new Array( destList.options.length );



  var len = 0;



  for( len = 0; len < destList.options.length; len++ )

  {

    if ( destList.options[ len ] != null )

    {

      newDestList[ len ] = new Option( destList.options[ len ].text, destList.options[ len ].value, destList.options[ len ].defaultSelected, destList.options[ len ].selected );

    }

  }



  for( var i = 0; i < srcList.options.length; i++ )

  {

    if ( srcList.options[i] != null && ( srcList.options[i].selected == true || moveAll ) )

    {

       // Statements to perform if option is selected



       // Incorporate into new list

       newDestList[ len ] = new Option( srcList.options[i].text, srcList.options[i].value, srcList.options[i].defaultSelected, srcList.options[i].selected );

       len++;

    }

  }



  // Sort out the new destination list

  newDestList.sort( compareOptionValues );   // BY VALUES

  //newDestList.sort( compareOptionText );   // BY TEXT



  // Populate the destination with the items from the new array

  for ( var j = 0; j < newDestList.length; j++ )

  {

    if ( newDestList[ j ] != null )

    {

      destList.options[ j ] = newDestList[ j ];

    }

  }



  // Erase source list selected elements

  for( var i = srcList.options.length - 1; i >= 0; i-- )

  {

    if ( srcList.options[i] != null && ( srcList.options[i].selected == true || moveAll ) )

    {

       // Erase Source

       //srcList.options[i].value = "";

       //srcList.options[i].text  = "";

       srcList.options[i]       = null;

    }

  }



} // End of moveDualList()

//  End -->
function replaceContent() {
if (document.submitContact.partnerType.value == 5)
{
     document.getElementById("paco").innerHTML = "Active counties"}
	 else
	 {
     document.getElementById("paco").innerHTML = "Catchment area"}

}

</script>
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
			<cfform name="submitContact" action="prc_contact2.cfm?#session.urltoken#">
				<!--- <table align="left" cellpadding="10" cellspacing="0" border="0" style="border:15px ridge #ff0000">	 --->
				<cfquery datasource="#application.DataSource#"

	password="#application.db_password#"
	username="#application.db_username#" name="test">
select catchment
from contact
where userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
</cfquery>

				<cfquery datasource="#application.DataSource#"

	password="#application.db_password#"
	username="#application.db_username#" name="indTypes">
	select type
	from indType
	where year2=<cfqueryPARAM value = "#session.fy#" CFSQLType = "CF_SQL_INTEGER">
	order by 1
</cfquery>
				<cfquery datasource="#application.DataSource#"

	password="#application.db_password#"
	username="#application.db_username#" name="selectContact">
	Select *
	from contact
	where
	userid = <cfqueryparam value="#session.userid#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">
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
	select distinct heading, num,rank
	from partnerTypes
	where year2=<cfqueryPARAM value = "#session.fy#" CFSQLType = "CF_SQL_INTEGER">
	order by rank
</cfquery>
				<table class="box2" cellpadding="10" cellspacing="5" width="100%"  >
					<cfoutput>
						<tr>
							<th colspan="2" align="left">
								<h3>
								Contact Information:
							</th>
						</tr>
						<tr>
							<td width="25%">
								Program Name
							</td>
							<td colspan="2">
								<cfinput type="text" name="orgName" value ="#selectContact.orgName#" required="Yes" maxlength="180" size="75">
							</td>
						</tr>
						<tr>
							<td>
								Program Area
							</td>
							<td colspan="2">
								<cfif #session.admin# is 1>
									<cfoutput>
										<cfselect name="partnerType" required="Yes" onchange="replaceContent()">
											<cfloop query="partnerTypes">
												<option value="#num#"
												<cfif selectContact.partnerType EQ "#num#">
													selected
												</cfif>
												>#heading#
											</cfloop>
										</cfselect>
									</cfoutput>
								<cfelse>
									<cfif isdefined("selectcontact.partnertype")>
										<input type="hidden" name="partnertype" value="#selectcontact.partnertype#">
									</cfif>
									<cfloop query="partnerTypes">
										<cfif selectContact.partnerType EQ "#num#">
											#heading#
										</cfif>
									</cfloop>
								</cfif>
							</td>
						</tr>
						<tr>
							<td>
								Organization Name
							</td>
							<td colspan="2">
								<!--- <cfif #session.admin# is 1> --->
								<cfinput type="text" name="orgName2" value ="#selectContact.orgName2#" required="Yes" maxlength="180" size="75">
								<!--- <cfelse>
									#selectContact.orgName2#
									</cfif> --->
							</td>
						</tr>
						<tr>
							<td>
								Contract Number
							</td>
							<td colspan="2">
								<cfif #session.admin# is 1>
									<cfinput type="text" name="grant" value ="#selectContact.grantnum#" required="Yes" maxlength="180" size="50">
								<cfelse>
									#selectContact.grantnum#
									<input type="hidden" name="grant" value="#selectcontact.grantnum#">
								</cfif>
							</td>
						</tr>
						<tr>
							<td>
								Project Coordinator ##1 Name *
							</td>
							<!--- <td width="20">
								<cfif #session.admin# is 1> --->
							<td colspan=2 align="left">
								<table align="left">
									<tr>
										<td align="left">
											<div style="font-style:italic;font-size:11px;">
												First Name
											</div>
											<cfinput type="text" name="coordfname" value ="#selectContact.coordfname#" maxlength="180" size="20">
										</td>
										<td align="left">
											<div style="font-style:italic;font-size:11px;">
												Last Name
											</div>
											<cfinput type="text" name="coordlname" value ="#selectContact.coordlname#" maxlength="180" size="20">
										</td>
									</tr>
								</table>
								<!--- <cfelse>
									<input type="hidden" name="coordfname" value="#selectcontact.coordfname#">
									<input type="hidden" name="coordlname" value="#selectcontact.coordlname#">
									<cfset coordname = #selectcontact.coordfname# & ' ' & #selectcontact.coordlname#>
									#coordname#
									</cfif> --->
							</td>
						</tr>
						<tr>
							<td>
								Project Coordinator ##1 Title *
							</td>
							<!--- <td width="20">
								<cfif #session.admin# is 1> --->
							<td colspan=2 align="left">
								<table align="left">
									<tr>
										<td align="left">
											<cfinput type="text" name="coordpref" value ="#selectContact.coordpref#" maxlength="180" size="50">
										</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td>
								Project Coordinator ##1 Phone *
							</td>
							<td colspan="2">
								<!--- <cfif #session.admin# is 1> --->
								<cfinput type="text" name="coordphone" value ="#selectContact.coordphone#" required="Yes" maxlength="180" size="50">
								<!--- <cfelse>
									#selectContact.coordphone#
									</cfif> --->
							</td>
						</tr>
						<tr>
							<td>
								Project Coordinator ##1 E-mail Address *
							</td>
							<td colspan="2">
								<!--- <cfif #session.admin# is 1> --->
								<cfinput type="text" name="coordemail" value ="#selectContact.coordemail#" required="Yes" maxlength="180" size="50">
								<!--- <cfelse>
									#selectContact.coordemail#
									</cfif> --->
							</td>
						</tr>
						<tr>
							<td>
								Project Coordinator ##2 Name *
							</td>
							<!--- <td width="20">
								<cfif #session.admin# is 1> --->
							<td colspan=2 align="left">
								<table align="left">
									<tr>
										<td align="left">
											<div style="font-style:italic;font-size:11px;">
												First Name
											</div>
											<cfinput type="text" name="coordfname2" value ="#selectContact.coordfname2#" maxlength="180" size="20">
										</td>
										<td align="left">
											<div style="font-style:italic;font-size:11px;">
												Last Name
											</div>
											<cfinput type="text" name="coordlname2" value ="#selectContact.coordlname2#" maxlength="180" size="20">
										</td>
									</tr>
								</table>
								<!--- <cfelse>
									<input type="hidden" name="coordfname" value="#selectcontact.coordfname#">
									<input type="hidden" name="coordlname" value="#selectcontact.coordlname#">
									<cfset coordname = #selectcontact.coordfname# & ' ' & #selectcontact.coordlname#>
									#coordname#
									</cfif> --->
							</td>
						</tr>
						<tr>
							<td>
								Project Coordinator ##2 Title *
							</td>
							<!--- <td width="20">
								<cfif #session.admin# is 1> --->
							<td colspan=2 align="left">
								<table align="left">
									<tr>
										<td align="left">
											<cfinput type="text" name="coordpref2" value ="#selectContact.coordpref2#" maxlength="180" size="50">
										</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td>
								Project Coordinator ##2 Phone *
							</td>
							<td colspan="2">
								<!--- <cfif #session.admin# is 1> --->
								<cfinput type="text" name="coordphone2" value ="#selectContact.coordphone2#" required="Yes" maxlength="180" size="50">
								<!--- <cfelse>
									#selectContact.coordphone#
									</cfif> --->
							</td>
						</tr>
						<tr>
							<td>
								Project Coordinator ##2 E-mail address *
							</td>
							<td colspan="2">
								<!--- <cfif #session.admin# is 1> --->
								<cfinput type="text" name="coordemail2" value ="#selectContact.coordemail2#" required="Yes" maxlength="180" size="50">
								<!--- <cfelse>
									#selectContact.coordemail#
									</cfif> --->
							</td>
						</tr>
						<tr>
							<td>
								Supervisor Name *
							</td>
							<td colspan=2 align="left">
								<table align="left">
									<tr>
										<td align="left">
											<div style="font-style:italic;font-size:11px;">
												First Name
											</div>
											<cfinput type="text" name="superfname2" value ="#selectContact.superfname2#" maxlength="180" size="20">
										</td>
										<td align="left">
											<div style="font-style:italic;font-size:11px;">
												Last Name
											</div>
											<cfinput type="text" name="superlname2" value ="#selectContact.superlname2#" maxlength="180" size="20">
										</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td>
								Supervisor Phone *
							</td>
							<td colspan="2">
								<cfinput type="text" name="superphone2" value ="#selectContact.superphone2#" required="Yes" maxlength="180" size="50">
							</td>
						</tr>
						<tr>
							<td>
								Supervisor E-mail Address *
							</td>
							<td colspan="2">
								<cfinput type="text" name="superemail2" value ="#selectContact.superemail2#" required="Yes" maxlength="180" size="50">
							</td>
						</tr>
						<!--- <tr><td colspan="2">
							* This information will be shared with TCP and used for all programmatic communications.
							This information can be updated directly in CAT.
							To update other contact information (your mailing address, your fiscal contact, etc.),
							please contact TCP directly at <a href="mailto:dlt03@health.state.ny.us">dlt03@health.state.ny.us</a>.
							</td></tr> --->
						<tr>
							<th>
								Information below is for contract/fiscal purposes only
							</th>
						</tr>
						<tr>
							<td>
								Contract PI Name
							</td>
							<td colspan=2 align="left">
								<table align="left">
									<tr>
										<td align="left">
											<div style="font-style:italic;font-size:11px;">
												First Name
											</div>
											<cfinput type="text" name="PIfname" value ="#selectContact.PIfname#" maxlength="180" size="20">
										</td>
										<td align="left">
											<div style="font-style:italic;font-size:11px;">
												Last Name
											</div>
											<cfinput type="text" name="PIlname" value ="#selectContact.PIlname#" maxlength="180" size="20">
											<!--- <cfelse>
												<input type="hidden" name="superfname" value="#selectcontact.superfname#">
												<input type="hidden" name="superlname" value="#selectcontact.superlname#">
												<cfset supername = #selectcontact.superfname# & '' & #selectcontact.superlname#>
												#supername#
												</cfif> --->
								</table>
							</td>
						</tr>
						<tr>
							<td>
								Contract PI Phone
							</td>
							<td colspan="2">
								<!---  <cfif #session.admin# is 1> --->
								<cfinput type="text" name="PIPhone" value ="#selectContact.PIPhone#" required="Yes" maxlength="180" size="50">
								<!--- <cfelse>
									#selectContact.superPhone#
									</cfif> --->
						<tr>
							<td>
								Contract PI E-mail address
							</td>
							<td colspan="2">
								<!--- <cfif #session.admin# is 1> --->
								<cfinput type="text" name="PIEmail" value ="#selectContact.PIEmail#" required="Yes" maxlength="180" size="50">
								<!--- <cfelse>
									#selectContact.superEmail#
									</cfif> --->
						<tr>
							<th>
								Optional: Fiscal Staff Contract Info
								<br>
								(if different from above)
							</th>
						</tr>
						<tr>
							<td>
								Fiscal Staff Name
							</td>
							<td colspan=2 align="left">
								<table align="left">
									<tr>
										<td align="left">
											<div style="font-style:italic;font-size:11px;">
												First Name
											</div>
											<cfinput type="text" name="fiscalfname2" value ="#selectContact.fiscalfname2#" maxlength="180" size="20">
										</td>
										<td align="left">
											<div style="font-style:italic;font-size:11px;">
												Last Name
											</div>
											<cfinput type="text" name="fiscallname2" value ="#selectContact.fiscallname2#" maxlength="180" size="20">
										</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td>
								Fiscal Staff Phone
							</td>
							<td colspan="2">
								<cfinput type="text" name="fiscalphone2" value ="#selectContact.fiscalphone2#" maxlength="180" size="50">
							</td>
						</tr>
						<tr>
							<td>
								Fiscal Staff E-mail Address
							</td>
							<td colspan="2">
								<cfinput type="text" name="fiscalemail2" value ="#selectContact.fiscalemail2#" maxlength="180" size="50">
							</td>
						</tr>
						<tr>
							<td>
								<!--- Email addresses for additional coordinators or CAT users --->
								Email addresses for additional coordinators or CAT users (these addresses will not be used by TCP for programmatic communications):
							</td>
							<td colspan="2">
								<cfinput type="text" name="addlEmail" value ="#selectContact.addlEmail#" maxlength="180" size="50">
							</td>
						</tr>
						<tr>
							<td colspan=3>
								<cfif isdefined("selectcontact.btccomm") and #selectcontact.btccomm# is 1>
									<cfinput type="checkbox" name="btccomm" value="1" checked>
								<cfelse>
									<cfinput type="checkbox" name="btccomm" value="1" >
								</cfif>
								<!--- Email addresses for additional coordinators or CAT users --->
								Please check box if the email addresses for additional coordinators/CAT users should receive BTC communications.
							</td>
							<td colspan="2">
							</td>
						</tr>
					</cfoutput>
					<tr>
						<td align="center"  valign="top" colspan="2">
							<table class="box" width="70%" cellpadding="10" border=0>
								<tr>
									<th colspan="3">
										<div id="paco">
											County or counties served
										</div>
									</th>
								</tr>
								<tr>
									<td align="right" valign="top">
										NY Counties:
										<br>
										<select name="allcounties" multiple size="5" class="mlti">
											<cfoutput>
												<cfloop query="counties">
													<option value="#countyName#">
														#countyName#
												</cfloop>
											</cfoutput>
										</select>
									</td>
									<td align="center">
										<NOBR>
										<input type="button" style="width:90" onclick="moveDualList( this.form.allcounties,  this.form.catchment, false )"    name="Add     >>"  value="Add       >>" class="AddButton">
										<BR>
										<NOBR>
										<input type="button" style="width:90" onclick="moveDualList( this.form.catchment, this.form.allcounties,  false )"    name="<<  Remove"  value="<<   Remove">
										<BR>
										<!--- <NOBR>
											<input type="button" style="width:90" onclick="moveDualList( this.form.allcounties,  this.form.catchment, true  )"    name="Add All >>"  value="Add All >>">     <BR>
											<NOBR>
											<input type="button" style="width:90" onclick="moveDualList( this.form.catchment, this.form.allcounties,  true  )"     name="<<Remove All "  value="<<Remove All ">     <BR>
											</NOBR> --->
									</td>
									<td align="left"  valign="top">
										County or counties served:
										<br>
										<cfselect name="catchment" multiple size="5"  required="Yes" message="Please specify at least one county in your catchment area" class="mlti">
											<cfoutput>
												<cfloop list="#valuelist(catchmentCounties.countyName)#" index="county">
													<option value="#county#">
														#county#
												</cfloop>
											</cfoutput>
										</cfselect>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr><td><input type="submit" name="upd_contact_bt" value="Submit" onclick="flip();" ></td></tr>
				</table>
				</td></tr>
			</cfform>
		</table>
		</body>
</html>
