
<cfif isDefined("seq2") and seq2 NEQ "">
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="checkOutreach">
	
	select 
	descr as type, county, target, o.seq
	from OUTREACH as o, lu_outreach_media as m
	where activity = '#activity#'
	and userid = '#session.userid#'
	and month2= '#form.month#'		
	and o.year2= '#form.year#'	
	and o.fk_forum_det=#seq2#
	and o.year2=m.year2
	and o.type=m.num
	
</cfquery>
</cfif>

<tr><td><table class="box">
<tr><th align="left"><a name="outr"></a>Event Promotion, publicity or outreach<br></th></tr>
<tr>
	<th>Type of Promotion Material or medium</th>
	<th>Counties Targeted by that medium</th>
	<th>Target Audience</th>
</tr>

<tr>
	<td>
		<cfselect name="promoMedia_#seq2#" query="QpromoMedia" value="num" display="descr">
		</cfselect>
	</td>
	
	<td>
<cfoutput><select name="promocounty_#seq2#" multiple size="5" class="mlti"></cfoutput>
<cfoutput>
<cfloop query="counties">
<option  value= "#FIPS#">#countyName#
</cfloop></cfoutput>
<option value="88888">Counties beyond catchment area
<option value="99999">Distant from catchment area
</select>
	</td>
	
	<td>
	
	
	<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="strat_campaign_targets_outr">
	select target, seq
	from strat_campaignTarget
	where userid='#session.userid#'
	and activity = '#activity#'
	and year2=#session.fy#
	order by seq	
	</cfquery>
		<cfoutput><select name="promoTarget_#seq2#"></cfoutput>
		<cfif strat_campaign_targets_outr.recordcount GT 0>
			<cfoutput>
			<cfloop query="strat_campaign_targets_outr">
				<cfquery datasource="#application.DataSource#"  		
				 
				password="#application.db_password#"   		
				username="#application.db_username#" name="detail_targets_outr">
				select descrip
				from campaignTarget
				where 
				num in (#strat_campaign_targets_outr.target#)	
				and year2=#session.fy#
			</cfquery>
			<option value="#target#">#valuelist(detail_targets_outr.descrip)#
			</cfloop>
			</cfoutput>
		<cfelse>
			<option value="0">No targets selected in workplan
		</cfif>
	
		</select> 
	</td>
</tr>
<tr><td><cfoutput><input type="Button" value="Add" name="addCollab_bt_#seq2#" onclick="setNewOutreach('add', '#seq2#');" class="AddButton"></cfoutput></td></tr>
<tr><td colspan="3">
<table><tr><td >
<cfif isDefined("checkOutreach") and checkOutreach.recordcount GT 0>
<table border="0" class="box" cellpadding="2" cellspacing="0">
	<tr>
		<th width="100">Type</th>
		<td width="25"></td>
		<th width="200" align="center">Counties</th>
		<th width="100">Target</th>
		<th>Delete</th>
	</tr>
	
	<cfoutput>
	<cfloop query="checkOutreach" >
	<tr  bgcolor="Silver">
		<td> #type#</td>
		<td></td>
		<td>
		<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="countyDetails">
	select CountyName from counties
	where FIPS in (#county#)
	order by 1	
	</cfquery>
		
		#valuelist(countyDetails.countyname)#
		
		</td>
		
		<cfquery datasource="#application.DataSource#"  		
				 
				password="#application.db_password#"   		
				username="#application.db_username#" name="detail_targets_outr">
				select descrip
				from campaignTarget
				where 
				num in (#target#)	
				and year2=#session.fy#
			</cfquery>

	<td>#valuelist(detail_targets_outr.descrip,'<br>')#</td>
		
		
		<!--- <td>#target#</td> --->
		<td align="center"><input type="Checkbox" name="delOut" value="#seq#"></td>
	</tr>
		
	</cfloop> 
	</cfoutput>
	<tr><td colspan="4" align="left"><input type="Button" value="Delete" name="delOUT_bt" onclick="setNewOutreach('delete');" class="DelButton"></td></tr>

</table></td><td>

</cfif>
</td></tr></table>
</td></tr></table></td></tr>
