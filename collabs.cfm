<cfset collabstring = #dispgenActive.collaborators#>

<cfif collabstring EQ "">
	<cfset collabstring="0">
</cfif>

<cfif isDefined("form.manipCollab")>

<cfif form.manipCollab EQ "add">
<cfset collabstring = collabstring & "," & form.actCollborators>
<cfoutput><cf_removeDuplicates list='#collabstring#'></cfoutput>
<cfset collabstring = deDupedList>


<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="selcollaborators">

update #tablename#
set	collaborators = '#collabstring#'
	where (userid = '#session.userid#' or userid='SHARED')
	and activity = '#activity#'
	and month2='#form.month#'
	and year2 = #form.year#
	
</cfquery>

<cfelseif form.manipCollab EQ "delete" and isDefined("form.del_box")>
<cfset collabArray = ListToArray(collabstring)>
<!--- <cfoutput>#collabstring#<br></cfoutput> --->
<cfloop from="#ArrayLen(collabArray)#"  to="1" index="i" step="-1"> 
   <cfif listfind(form.del_box,collabArray[i])>
   <cfoutput>	#ArrayDeleteAt(collabArray,i)#</cfoutput>
   </cfif>
 </cfloop> 
 <cfset collablist = ArrayToList(collabArray)>
 <cfoutput>
 <cf_removeDuplicates list='#collablist#'>
 </cfoutput>
<cfset collablist = deDupedList>

 
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="upcollaborators">

update #tablename#
set	collaborators = '#collablist#'
	where (userid = '#session.userid#' or userid='SHARED')
	and activity = '#activity#'
	and month2='#form.month#'
	and year2 = #form.year#
	
</cfquery>




</cfif>


</cfif> 
<script language="JavaScript">
function setNewCollab(process){
if((process == "add")&&(document.monthlyActivity.actCollborators.value=="")){
alert('Please select a collaborator');
return false;
}


document.monthlyActivity.manipCollab.value = process;

if( _CF_checkmonthlyActivity(document.monthlyActivity)==true){
document.monthlyActivity.submit();
}
}


</script>



<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="revcollaborators">

select collaborators
from #tablename#
where (userid = '#session.userid#' or userid='SHARED') 
	and activity = '#activity#'
	and month2='#form.month#'
	and year2 = #form.year#
	
</cfquery>




<cfif isDefined("revcollaborators.collaborators") and revcollaborators.collaborators NEQ "">
<cfset collabstring =   revcollaborators.collaborators>
<cfelse>
<cfset collabstring = "0">
</cfif>

<input type="hidden" name="manipCollab" value="">
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="collaborators">
	select name, type, county, seq,
	case 
	 when unit IS NULL then NAME
	 else unit + ' ' + NAME
	end as unitname 
	  from collaborators 
	where  userid = '#session.userid#'
	order by 5
	
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="localcollaborators">
	<!--- select name, type, county, seq from collaborators
	where  userid = <cfoutput>'#session.userid#'
	 and seq in (#collabstring#)</cfoutput>
	 order by 1 --->
	 
	 select c.name,  o.type, c.county, c.seq,
	 case 
	 when c.unit IS NULL then c.NAME
	 else c.unit + ' ' + c.NAME
	end as unitname 
	 
	 from collaborators as c, orgtype as o
	where  (userid = '#session.userid#' OR userid='SHARED')
	and o.num = c.type 
	 and c.seq in (#collabstring#)
	 and o.indorg=c.indorg
	 and c.year2=o.year2
	 order by 1
</cfquery>


<tr><td><table border ="1" class="box">
<tr><td>Collaborators:<A HREF="javascript:void(0)"onclick="window.open('<cfoutput>#application.basename#</cfoutput>/dictionary.cfm##col','_blank','height=500, width=700,scrollbars=yes')"><img SRC="images/book07.gif"  width="20" height="20" BORDER="0" ALT="Help"></a> 
<cfif collaborators.recordcount EQ 0>
<br>You have no collaborators.<br>Please add a collaborator to your master list<br>using the button to the right
<cfelse>
<cfselect query="collaborators" value="seq" display="unitname" name="actCollborators">
<option value="" selected>-Select a Collaborator-</option> 
</cfselect>
<input type="Button" value="Add" name="addCollab_bt" onclick="setNewCollab('add');" class="AddButton"></td>
</cfif>
<td><input type="Button" value="Add New Collaborator" name="addNewCollab_bt" 
ONCLICK="window.open('<cfoutput>#application.basename#</cfoutput>/add_collabs.cfm', 'Collaborator', 'scrollbars=1,width=700,height=500')" class="AddButton">
<!--- onclick="window.open('http://pubdevelopment.rti.org/nytobacco/collaborators.cfm','Add New Collaborator','width=400,height=200');">  --->
</td></tr>
<tr><td>
<table><tr><td>
<cfif localcollaborators.recordcount GT 0>
<table border="0" cellspacing="0" class="box">
	<tr>
		<th width="100">Collaborator Name</th>
		<th width="200" align="center">Category</th>
		<th width="100">County</th>
		<th>Delete</th>
	</tr>
	
	<cfoutput>
	<cfloop query="localcollaborators" >
	<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="countynames">
	select countyname from counties where FIPS in (#county#)
	</cfquery>
	<tr  bgcolor="Silver">
		<td> #unitname#</td>
		<td> #type#</td>
		<td>#valuelist(countynames.countyname, ',<br>')#</td>
		<td align="center"><input type="Checkbox" name="Del_box" value="#seq#"></td>
	</tr>
		
	</cfloop> 
	</cfoutput>
	<tr><td colspan="3"></td><td><input type="Button" value="Delete" name="delCollab_bt" onclick="setNewCollab('delete');" class="DelButton"></td></tr>

</table></td><td>

</td></cfif>
</tr></table>
</td></tr></table></td></tr>
