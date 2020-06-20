
<tr><td>
<table class="box">
<tr>
	<td colspan="2">Did this strategy support TCP sustainability efforts? &nbsp;&nbsp;&nbsp;&nbsp;
		<input type="radio" name="tcpsust" value="1" s <cfif isDefined("form.tcpsust") and form.tcpsust EQ "1"> checked</cfif>>Yes
		&nbsp;<input type="radio" name="tcpsust" value="0" <cfif not isdefined("form.tcpsust") OR (isDefined("form.tcpsust") and (form.tcpsust EQ "0" OR form.tcpsust EQ ""))> checked</cfif>>No
	 </td>
</tr>
<tr>
	<td colspan="2">If yes, please describe:</td>
</tr>
<tr>
	<td colspan="2">
	<textarea name="tcpsust_text" cols="120" rows="8" ><cfif isdefined("form.tcpsust_text")><cfoutput>#form.tcpsust_text#</cfoutput></cfif></textarea>
	</td>
</tr>

</table>
</td></tr>