<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="getdeets">
SELECT     *
FROM         dbo.eoy_details 
where 
(year2 = '#session.fy#') AND <cfif isdefined("usid")>userid='#usid#'<cfelse>userid='#session.userid#' </cfif>
</cfquery>

<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Audit2">
	select dtstmp
	from eoy_audit
	where 
<cfif isdefined("usid")>userid = '#usid#'<cfelse>userid = '#session.userid#'</cfif>
and type='TCP'
order by 1 desc
</cfquery>

<!--- <cfset read= 0> --->



<cfoutput>
<a name="sv9"></a>
<br>
<TABLE class="box" WIDTH="70%">
	<tr><td><div align="center"><h3>TCP Feedback</h3></div><div align="center"><h4>To be completed by TCP staff after partner completes EOY report</h4></div></td></tr>

<TR><TD><a name="sv12"></a>
If End-of-Year (EOY) Report is NOT complete, items to be addressed are checked below. <br>Entries in this EOY Report: <br>
<input type="checkbox" name="TCP1" <cfif read is 0 or  getdeets.eoycomplete EQ 1>disabled</cfif> value=1 <cfif getdeets.tcp1 EQ 1> checked</cfif>> Are not consistent with CAT reporting<br>
<input type="checkbox" name="TCP2" <cfif read is 0 or  getdeets.eoycomplete EQ 1>disabled</cfif> value=1 <cfif getdeets.tcp2 EQ 1> checked</cfif>> Do not accurately reflect the partner's progress this past contract year<br>
<input type="checkbox" name="TCP3" <cfif read is 0 or  getdeets.eoycomplete EQ 1>disabled</cfif> value=1 <cfif getdeets.tcp3 EQ 1> checked</cfif>> Do not include actions to address barriers that are consistent with next year's work plan<br>
<input type="checkbox" name="TCP4" <cfif read is 0 or  getdeets.eoycomplete EQ 1>disabled</cfif> value=1 <cfif getdeets.tcp4 EQ 1> checked</cfif>> Do not describe how 2008-2009 activities will build on 2007-2008 successes<br>
<p>

<cfif read is 0 or  getdeets.eoycomplete EQ 1>
<input type="hidden" name="TCP1" value="<cfoutput>#getdeets.tcp1#</cfoutput>">
<input type="hidden" name="TCP2" value="<cfoutput>#getdeets.tcp2#</cfoutput>">
<input type="hidden" name="TCP3" value="<cfoutput>#getdeets.tcp3#</cfoutput>">
<input type="hidden" name="TCP4" value="<cfoutput>#getdeets.tcp4#</cfoutput>">
</cfif>


EOY Report feedback: <br>
<cfif read is 0><textarea name="tcpfeedback" cols=130 rows=5 readonly class="readonly">#getdeets.tcpfeedback#</textarea>
<cfelse>
<textarea name="tcpfeedback" cols=130 rows=5>#getdeets.tcpfeedback#</textarea>
</cfif></p>
Is EOY complete to TCP satisfaction, including all recommended edits?<br>
<cfif read is 0>
<input type="checkbox" name="EOYcomplete" value=1 <cfif getdeets.eoycomplete EQ 1>checked</cfif> disabled> Yes<br>
<cfelse>
<input type="checkbox" name="EOYcomplete" <cfif getdeets.eoycomplete EQ 1>checked disabled</cfif> value=1> Yes<br>
</cfif>
<cfif getdeets.eoy_dt is not ''>
<input type="hidden" name="eoy_dt" value="#getdeets.eoy_dt#">
(#dateformat(getdeets.eoy_dt,"mm/dd/yyyy")#)</cfif>

</TD></TR></TABLE>
</cfoutput>
<cfif isdefined("usid")>
<tr>
	<!--- <td colspan="2"><input type="button" value="Check Spelling" onClick="spell('document.EOYStatus.retailfeedback.value','document.EOYStatus.munifeedback.value','document.EOYStatus.agfeedback.value','document.EOYStatus.orgfeedback.value','document.EOYStatus.sbfeedback.value','document.EOYStatus.sfmfeedback.value','document.EOYStatus.mpaafeedback.value','document.EOYStatus.govtfeedback.value','document.EOYStatus.coordfeedback.value','document.EOYStatus.customfeedback.value','document.EOYStatus.tcpfeedback.value')">
	 --->
	<td colspan="2"><input type="button" value="Check Spelling" onClick="spell('document.EOYStatus.sm1_feedback.value','document.EOYStatus.sm2_feedback.value','document.EOYStatus.sm3_feedback.value','document.EOYStatus.tcpfeedback.value')">
	</td>
</tr>
</cfif>

<tr><Td>
<cfif isdefined("usid")>

<div align="left">
	<!--- <input  type="button" value="Save" class="AddButton" onClick="setLoc('sv12');"> --->
	<input  type="submit" value="Save" class="AddButton" ><br>
<CFIF getdeets.TCP_status GT 0>
	<input type="submit" value="Feedback Submitted" class="DelButton"  onClick="setSave2();">
<cfelse>
	<input type="submit" value="Submit Feedback" class="AddButton" onClick="setSave2();">
</CFIF>
</cfif>

<cfif Audit2.recordcount GT 0>
<cfoutput>
	<br><cfloop query="Audit2">
	Reviewed #dateformat(Audit2.dtstmp, "m/d/yyyy")# <br>
	</cfloop>
</cfoutput>
</cfif>

	
</div>
</Td></tr>
