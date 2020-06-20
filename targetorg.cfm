  <cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="GetTarget">
SELECT keyNum as targetNum, target
  FROM monitorTarget 
  where year2=#session.fy#
 order by 1
 
</cfquery>

  
  <tr>
      <td> <a name="sto"></a>Select Target Organizations</td></tr><tr><td>
         <select name="target2" onChange="alterTarget('sto');">
            <option value="0">Select Target
            <cfoutput query="getTarget" >
               <option value="#targetNum#" <cfif isDefined("form.target2") and form.target2 EQ targetNum> Selected</cfif>>#target#
            </cfoutput>
         </select>
      </td>
</tr>