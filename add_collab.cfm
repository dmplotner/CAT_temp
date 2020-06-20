<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
<title>Add Collaborator</title>
<script type="text/javascript">
function add(){
document.submitContact.addUser.value="add";
document.submitContact.submit();
}

function finished(){
document.submitContact.returnToForm.value="done";
document.submitContact.submit();
}

</script>

<cfif isDefined("form.adduser") AND form.adduser EQ "add">
<cfoutput>
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="insertCollab">
	insert into collaborators (name, indOrg, traditional, type, county, userid, year2)
	values
	('#form.collabName#', '#form.indOrg#', '#form.traditional#', '#form.collabtype#', '#form.jurisdiction#', '#session.userid#', #session.fy#)
</cfquery>
</cfoutput>
</cfif>

<cfif isDefined("form.del_box")>
<cfoutput>
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="deleteCollab">
	delete from collaborators 
	where seq in (#form.del_box#) and userid = '#session.userid#'
	
</cfquery>
</cfoutput>
</cfif>





	 

<table align="left" cellpadding="10" cellspacing="0" border="0" class="box">		


<!--- <cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="partnerTypes">
	select heading, type, rank from partnerTypes
	order by 1, 2
	
</cfquery> --->

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="counties">
	select countyName from counties order by 1
	
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="collaborators">
	select name, indOrg, traditional, type, county, seq from collaborators 
	where  userid = <cfoutput>'#session.userid#'</cfoutput>
	order by 1
	
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="orgTypes">
	select type 
	from orgType
	where year2=#session.fy#
	order by 1
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="indTypes">
	select type 
	from indType
	where year2=#session.fy#
	order by 1
</cfquery>




<cfform name="submitContact" action="add_collab.cfm?#session.urltoken#">
<input type="Hidden" name="addUser" value ="">
<input type="Hidden" name="returnToForm" value ="">


<tr><td colspan="4" align="center"><table  frame="box" border="1" >
<tr><th colspan="3">Collaborators<A HREF="javascript:void(0)"onclick="window.open('<cfoutput>#application.basename#</cfoutput>/dictionary.cfm###col','_blank','height=500, width=700,scrollbars=yes')"><img SRC="images/book07.gif"  width="20" height="20" BORDER="0" ALT="Help"></a></th></tr>
<tr><td>Collaborator Name</td><td><input type="text" name="collabName"></td></tr>
<tr><td colspan="2" align="center"><input type="Radio" name="indOrg" value="Individual">Individual&nbsp;&nbsp;&nbsp;&nbsp;<input type="Radio" name="indOrg" value="Organization">Organization</td></tr>
<tr><td colspan="2" align="center">Non-Traditional?&nbsp;&nbsp;&nbsp;<input type="Radio" name="traditional" value="1">Yes&nbsp;&nbsp;&nbsp;&nbsp;<input type="Radio" name="traditional" value="0">No</td></tr>
<tr><td>Type:</td><td>
<select name="collabType">
<cfoutput><cfloop query="orgTypes">
	<option>#type#
</cfloop></cfoutput>

</select></td></tr>
<tr><td>County of residence/Jurisdiction/Coverage</td><td>
<cfselect name="Jurisdiction" required="Yes" message="Please select at least one county of jurisdiction">
<cfoutput><cfloop query="counties">
	<option>#countyName#
</cfloop></cfoutput>

</cfselect></td></tr>
<tr><td colspan="2" align="center"><input type="Button" name="add_collaborator" value="Add Collaborator" onclick="add();" class="AddButton"></td></tr>
</table></td></tr>
<tr><td colspan="3">
<table><tr><td></cfform>
<cfform name="deleteContact" action="add_collab.cfm?#session.urltoken#">
<cfif collaborators.recordcount GT 0>
<table border="0">
	<tr>
		<th width="100">Collaborator Name</th>
		<th width="200" align="center">Individual or Organization</th>
		<th width="100">Non-Traditional</th>
		<th width="100">Type</th>
		<th width="100">County of Residence/Jurisdiction/Coverage*</th>
		<th>Delete</th>
		
	</tr>
	
	<cfoutput>
	<cfloop query="collaborators" >
	<tr  bgcolor="Silver">
		<td> #name#</td>
		<td> #indOrg#</td>
		<td>#traditional#</td>
		<td>#type#</td>
		<td>#county#</td>
		<td align="center"><input type="Checkbox" name="Del_box" value="#seq#"></td>
	</tr>
	</cfloop> 
	</cfoutput>
	
</table></td><td>
<input type="Button" name="del_staff" value="Delete" onclick="submit();" class="DelButton" >
<input type="Button" name="return" value="Return" onclick="finished();" >
</td></tr></table>
</cfif>



</cfform>

</table></td></tr>	

<cfif isDefined("form.returnToForm") AND form.returnToForm EQ "done">
<script language="JavaScript" type="text/javascript">
<!--

window.opener.location.reload();
  window.opener = self;
  window.close();
// -->
</script>

</cfif>

</body>

</html>
