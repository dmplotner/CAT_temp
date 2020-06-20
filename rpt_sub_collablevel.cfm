<tr>
<td>
Statewide/Regional/Area <br>Collaboration?</td>	
<td colspan="3">
<table width="100%">
<tr>
<!--- <td  width="33%">Statewide Initiative?   Yes <input type="checkbox" <cfif QGenDescrip.state EQ "1"> checked </cfif>disabled> No <input type="checkbox" <cfif QGenDescrip.state EQ "0"> checked </cfif> disabled>
 --->
 <td  width="33%">Statewide Initiative?   Yes <input type="checkbox" <cfif state EQ "1"> checked </cfif>disabled> No <input type="checkbox" <cfif QGenDescrip.state EQ "0"> checked </cfif> disabled>


</td>
<!--- <td width="33%">Regional?  Yes <input type="checkbox" <cfif QGenDescrip.tcpregional EQ "1"> checked </cfif> disabled> No <input type="checkbox" <cfif QGenDescrip.tcpregional EQ "0"> checked </cfif> disabled></td>
<td>Area?  Yes <input type="checkbox" <cfif QGenDescrip.tcparea EQ "1"> checked </cfif> disabled> No <input type="checkbox" <cfif QGenDescrip.tcparea EQ "0"> checked </cfif> disabled></td>
 --->
 <td width="33%">Regional?  Yes <input type="checkbox" <cfif tcpregional EQ "1"> checked </cfif> disabled> No <input type="checkbox" <cfif QGenDescrip.tcpregional EQ "0"> checked </cfif> disabled></td>
<td>Area?  Yes <input type="checkbox" <cfif tcparea EQ "1"> checked </cfif> disabled> No <input type="checkbox" <cfif QGenDescrip.tcparea EQ "0"> checked </cfif> disabled></td>
</tr>

<cfif QGenDescrip.state EQ "1" and QGenDescrip.campName NEQ "">
<cfquery datasource="#application.DataSource#" 		 
		password="#application.db_password#"   		
		username="#application.db_username#" 
		name="QPartnerSharedAct">
		select  descrip
		from  state_initiatives
		<!--- where num=#QGenDescrip.campName# --->
		where num=#campName#
		and year2=#session.rptyr#
</cfquery>
<cfif QPartnerSharedAct.recordcount GT 0>
<tr>
<td colspan="3">
<cfoutput>#QPartnerSharedAct.descrip#</cfoutput>

</td>
</tr>
</cfif>
</cfif>
</table>
</td>


</tr>

</table>
<br>
