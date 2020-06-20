<tr><td colspan="2">
<cfoutput>
<table class="box">
<tr><th colspan="3" align="left">Impacts on policy/practice implementation this month:</td></tr>

<tr>
<td>Did Decision-maker(s) take action this month?
</td><td><input type="radio" value="1" name="impact_action" <cfif isDefined("form.impact_action") and form.impact_action EQ "1"> checked</cfif>>Yes
<input type="radio" value="0" name="impact_action" <cfif (isDefined("form.impact_action") and form.impact_action NEQ "1") or NOT isDefined("form.impact_action")> checked</cfif>>No
</td>
<td valign="top">If Yes, please describe:<br><textarea cols="40" rows="5" name="impact_action_txt" ><cfif isDefined("form.impact_action_txt") and  isDefined("form.impact_action") and form.impact_action EQ "1">#impact_action_txt#</cfif></textarea></td></tr>
<!--- <cfif activityInfo.strategy EQ "8" OR activityInfo.strategy EQ "9">
 ---><tr>
<td>Was a new policy/practice/resolution implemented or strengthened this month?
</td><td><input type="radio" value="1" name="impact_imp" <cfif isDefined("form.impact_imp") and form.impact_imp EQ "1"> checked</cfif>>Yes
<input type="radio" value="0" name="impact_imp" <cfif (isDefined("form.impact_imp") and form.impact_imp NEQ "1") or NOT isDefined("form.impact_imp")> checked</cfif>>No
</td>
<td valign="top">If Yes, please describe:<br><textarea cols="40" rows="5"  name="impact_imp_txt" ><cfif isDefined("form.impact_imp_txt") and  isDefined("form.impact_imp") and form.impact_imp EQ "1">#impact_imp_txt#</cfif></textarea></td></tr>
<!--- </cfif> --->
</table>
</cfoutput>
</td></tr>
