
<script language="JavaScript">function validate(){
if (ValidateDate(document.monthlyActivity.startDate.value)==false){return false;};
if (ValidateDate(document.monthlyActivity.endDate.value)==false){return false;};
if (ValidateCompareDate(document.monthlyActivity.startDate.value, document.monthlyActivity.endDate.value)==false){return false;};

return true;
}
</script>
<cfif pendStatus EQ "0">
	<cfquery datasource="#application.DataSource#"   password="#application.db_password#"  username="#application.db_username#" name="infrafocusarea">
	select stratfocus
	from useractivities
	where userid='#activityInfo.userid#'
	and activity='#activity#'
	and year2=#session.fy#
	
	</cfquery>
	
	<cfif http_referer DOES NOT CONTAIN "monthlyActive.cfm">
	<cfquery datasource="#application.DataSource#"   password="#application.db_password#"  username="#application.db_username#" name="infraDevDet">
	select stratfocus,staff_time_dev,staff_time_recruit,staff_time_interview
	from infrastruct
	where userid='#activityInfo.userid#'
	and activity='#activity#'
	and month2='#form.month#'
	and year2=#session.fy#
	</cfquery>
	<cfif infraDevDet.recordcount GT 0>
	<cfset form.stratfocus='#infraDevDet.stratfocus#'>
	<cfset form.staff_devel='#infraDevDet.staff_time_dev#'>
	<cfset form.staff_recruit='#infraDevDet.staff_time_recruit#'>
	<cfset form.staff_interview='#infraDevDet.staff_time_interview#'>
	</cfif>
	</cfif>
	<cfif NOT isDefined("form.stratfocus")>
	<cfset form.stratfocus="">
	<cfset form.staff_devel="">
	<cfset form.staff_recruit="">
	<cfset form.staff_interview="">	
	</cfif>
	<!--- <cfparam form.stratfocus default="">
	<cfparam form.staff_devel default="">
	<cfparam form.staff_recruit default="">
	<cfparam form.staff_interview default=""> --->
	<!--- <tr>
		<td>
		<table class="box">
		<tr>
		<td>Strategy Focus:
		</td>
		<td>
			<select name="stratfocus">
				<option value="1" <cfif form.stratfocus EQ "1"> selected</cfif>>Training
				<option value="2" <cfif form.stratfocus EQ "2"> selected</cfif>>Fundraising
				<option value="3" <cfif form.stratfocus EQ "3"> selected</cfif>>Collaboration with NYS TC Regional or Area Partners or Outside agencies
				<option value="4" <cfif form.stratfocus EQ "4"> selected</cfif>>Staffing
			</select>
		</td>
		</td>
		</tr>
		</table>	
	</tr> --->
	
	
	<cfif infrafocusarea.stratfocus EQ "1">
	
	<cfquery datasource="#application.DataSource#"   password="#application.db_password#"  username="#application.db_username#" name="tfoci">
		select descrip, num, heading
		from ITF_list
		where year2=#session.fy#
		order by rank
	</cfquery>
	<cfquery datasource="#application.DataSource#"   password="#application.db_password#"  username="#application.db_username#" name="trecip">
		select descrip, num
		from ITR_list
		where year2=#session.fy#
		order by rank
	</cfquery>
	<cfquery datasource="#application.DataSource#"   password="#application.db_password#"  username="#application.db_username#" name="ttrainer">
		select descrip, num
		from ITT_list
		where year2=#session.fy#
		order by rank
	</cfquery>
	
	
	<cfif isDefined("addActiveMotivation") and form.addActiveMotivation EQ "addT">
	<cfquery datasource="#application.DataSource#"  
	 password="#application.db_password#" 
	 username="#application.db_username#" name="addtraindet">
		insert into infra_training
		(topic, tfocus, trecip, trainer, num_sess, session_len, tot_attend,  sdate, edate, userid, activity, month2, year2)
		values
		('#form.topic#','#form.train_focus#', '#form.train_recip#', '#form.train_trainer#', '#form.train_sess#', '#form.train_len#', '#form.train_attend#', '#form.train_sd#', '#form.train_ed#','#activityInfo.userid#' ,'#activity#','#form.month#',#session.fy#)
		
	</cfquery>

	<cfelseif isDefined("addActiveMotivation") and form.addActiveMotivation EQ "delT">
	<cfquery datasource="#application.DataSource#"  
	 password="#application.db_password#" 
	 username="#application.db_username#" name="deltraindet">
		delete from infra_training
		where userid='#activityInfo.userid#'
		and activity='#activity#'
		and month2='#form.month#'
		and year2=#session.fy#
		and seq in (#form.del_training#)
		
	</cfquery>
	</cfif>
	
	<cfquery datasource="#application.DataSource#"  
	 password="#application.db_password#" 
	 username="#application.db_username#" name="traindet">
		select topic, tfocus, trecip, trainer, num_sess, sdate, edate, session_len, tot_attend,seq 
		from infra_training
		where  userid= '#activityInfo.userid#' 
		and activity = '#activity#'
		and month2='#form.month#'
		and year2 = #session.fy#
		order by seq
	</cfquery>
	<tr>
		<td><a name="train">
</a><h3>Training</h3>
		</td>
	</tr>
	<tr>
		<td>
			<table align="left" cellpadding="10" cellspacing="0" border="0" class="box">
				<tr>
					<th>	Topic
					</th>
					<th>	Training Focus
					</th>
					<th>	Training Recipients
					</th>
					<th>	Trainer
					</th>
					<th>	##Sessions<br>(this month)
					</th>
					<th>	Session Length<br>(hrs/session)
					</th>
					<th>	Total Attendance<br>(if Partner sponsored training)
					</th>
					<th>	Schedule
					</th>
				</tr>
				<tr>
					<th>
					    <cfinput type="Text" name="topic" maxlength="180">
					</th>
					<th>
					    <select name="train_focus" multiple size="5" class="mlti">
						<cfoutput query="tfoci" group="heading">
						<optgroup id="#heading#" label="#heading#">
						<cfoutput>
						<option value="#num#">#descrip#
						</cfoutput>
						</optgroup>
						</cfoutput>	
						</select>
<!--- 						</cfoutput><cfselect name="train_focus" multiple="Yes" query="tfoci" value="num" display="descrip"> 
</cfselect>--->
					</th>
					<th>
					    <cfselect name="train_recip" multiple="Yes" query="trecip" value="num" display="descrip" class="mlti">
</cfselect>
					</th>
					<th>
					    <cfselect name="train_trainer" multiple="Yes" query="ttrainer" value="num" display="descrip" class="mlti">
</cfselect>
					</th>
					<th>
					    <cfinput name="train_sess" type="Text">
					</th>
					<th>
					    <cfinput name="train_len" type="text">
					</th>
					<th>
					    <cfinput name="train_attend" type="text">
					</th>
					<th>	Start Date:
					    <cfinput name="train_sd" validate="date">
							<br>End Date:&nbsp;&nbsp;
					    <cfinput name="train_ed" validate="date">
					</th>
					<th>
					<input type="Button" value="Add" onclick="addMotivation('addT');" class="AddButton">
					</th>
				</tr>
				
	
				<cfif traindet.recordcount GT 0>
				<cfoutput>
				<cfloop query="traindet">
				
	
	<cfquery datasource="#application.DataSource#"  
	 password="#application.db_password#" 
	 username="#application.db_username#" name="focusdet">
		select  descrip as focusdescrip
		from ITF_list
		where num in (#tfocus#)
		and year2=#session.fy#
	</cfquery>
	<cfquery datasource="#application.DataSource#"  
	 password="#application.db_password#" 
	 username="#application.db_username#" name="trainingRecipDet">
		select  descrip as trainingdescrip
		from ITR_list
		where num in (#trecip#)		
		and year2=#session.fy#
	</cfquery>
	<cfquery datasource="#application.DataSource#"  
	 password="#application.db_password#" 
	 username="#application.db_username#" name="trainerDet">
		select  descrip as trainer
		from ITT_list
		where num in (#trainer#)	
		and year2=#session.fy#	
	</cfquery>
				<tr bgcolor="Silver">
				<td>#topic#</td>
				<td>#valuelist(focusdet.focusdescrip, '<br>')#</td>
				<td>#valuelist(trainingRecipDet.trainingdescrip)#</td>
				<td>#valuelist(trainerDet.trainer)#</td>
				<td>#num_sess#</td>
				<td>#session_len#</td>
				<td>#tot_attend#</td>
				<td>#dateformat(sdate, "m/d/yyyy")#~ #dateformat(edate, "m/d/yyyy")#</td>
				<td><input type="Checkbox" value="#seq#" name="del_training"></td>
				</tr>
				</cfloop></cfoutput>
				<tr><td colspan="4"></td><td><input type="Button" value="Delete" onclick="addMotivation('delT');" class="DelButton"></td></tr>
				</cfif>
				
				</table>
			</td>
		</tr>
		
		</cfif>
		
		
	<cfquery datasource="#application.DataSource#"   password="#application.db_password#"  username="#application.db_username#" name="ffoci">
		select descrip, num
		from IFF_list
		where year2=#session.fy#
		order by rank
	</cfquery>
	<cfquery datasource="#application.DataSource#"   password="#application.db_password#"  username="#application.db_username#" name="frespons">
		select descrip, num
		from IFR_list
		where year2=#session.fy#
		order by rank
	</cfquery>
	
				
	<cfif isDefined("addActiveMotivation") and form.addActiveMotivation EQ "addF">
	<cfquery datasource="#application.DataSource#"  
	 password="#application.db_password#" 
	 username="#application.db_username#" name="addtraindet">
		insert into infra_fundr
		(ffocus, fresponse, amt_rcvd,  startdate, enddate, userid, activity, month2, year2)
		values
		('#form.fund_focus#', '#form.fund_response#','#form.fund_dollar#', '#form.fund_sd#', '#form.fund_ed#','#activityInfo.userid#' ,'#activity#','#form.month#',#session.fy#)
		
	</cfquery>

	<cfelseif isDefined("addActiveMotivation") and form.addActiveMotivation EQ "delF">
	<cfquery datasource="#application.DataSource#"  
	 password="#application.db_password#" 
	 username="#application.db_username#" name="deltraindet">
		delete from infra_fundr
		where userid='#activityInfo.userid#'
		and activity='#activity#'
		and month2='#form.month#'
		and year2=#session.fy#
		and seq in (#form.del_fundr#)
		
	</cfquery>
	</cfif>
	
	<cfquery datasource="#application.DataSource#"  
	 password="#application.db_password#" 
	 username="#application.db_username#" name="fundrdet">
		select ffocus, fresponse, amt_rcvd,  startdate, enddate, seq 
		from infra_fundr
		where  userid= '#activityInfo.userid#'
		and activity = '#activity#'
		and month2='#form.month#'
		and year2 = #session.fy#
		order by seq
	</cfquery>

		<cfif infrafocusarea.stratfocus EQ "2">
	<tr>
		<td><a name="fund">
</a><h3>Fundraising</h3>
		</td>
	</tr>
	<tr>
		<td>
			<table align="left" cellpadding="10" cellspacing="0" border="0" class="box">
				<tr>
					<th>	Focus
					</th>
					<th>	Major Responsibility for Activity
					</th>
					<th>	Dollars received or Committed
					</th>
					<th>	Schedule
					</th>
					
				</tr>
				<tr>
					<th>
					    <cfselect name="fund_focus" value="num" display="descrip" query="ffoci"></cfselect>
					</th>
					<th>
					    <cfselect name="fund_response" value="num" display="descrip" query="frespons"></cfselect>
					</th>
					
					<th>
					    <cfinput name="fund_dollar" type="Text">
					</th>
					
					<th>	Start Date:
					    <cfinput name="fund_sd" validate="date">
							<br>End Date:&nbsp;&nbsp;
					    <cfinput name="fund_ed" validate="date">
					</th>
					<th>
					<input type="Button" value="Add" onclick="addMotivation('addF');" class="AddButton">
					</th>
				</tr>
		
	
				<cfif fundrdet.recordcount GT 0>
				<cfoutput>
				<cfloop query="fundrdet">
				
	
	<cfquery datasource="#application.DataSource#"  
	 password="#application.db_password#" 
	 username="#application.db_username#" name="ffocusdet">
		select  descrip as focusdescrip
		from IFF_list
		where num in (#ffocus#)
		and year2=#session.fy#
	</cfquery>
	<cfquery datasource="#application.DataSource#"  
	 password="#application.db_password#" 
	 username="#application.db_username#" name="frespDet">
		select  descrip as responsdescrip
		from IFR_list
		where num in (#fresponse#)		
		and year2=#session.fy#
	</cfquery>
				<tr bgcolor="Silver">
				<td>#valuelist(ffocusdet.focusdescrip)#</td>
				<td>#valuelist(frespDet.responsdescrip)#</td>
				<td>#amt_rcvd#</td>
				<td>#dateformat(startdate, "m/d/yyyy")#~ #dateformat(enddate, "m/d/yyyy")#</td>
				<td><input type="Checkbox" value="#seq#" name="del_fundr"></td>
				</tr>
				</cfloop></cfoutput>
				<tr><td colspan="4"></td><td><input type="Button" value="Delete" onclick="addMotivation('delF');" class="DelButton"></td></tr>
				</cfif>
				
				</table>
			</td>
		</tr>
		
		</cfif>
			<cfif infrafocusarea.stratfocus EQ "3">
		<!--- collaboration section --->
		
	<cfquery datasource="#application.DataSource#"   password="#application.db_password#"  username="#application.db_username#" name="ccollab">
		select descrip, num
		from ICC_list
		where year2=#session.fy#
		order by rank
	</cfquery>
	<cfquery datasource="#application.DataSource#"   password="#application.db_password#"  username="#application.db_username#" name="cpurpose">
		select descrip, num
		from ICP_list
		where year2=#session.fy#
		order by rank
	</cfquery>
	
	<cfquery datasource="#application.DataSource#"   password="#application.db_password#"  username="#application.db_username#" name="ctype">
		select descrip, num
		from ICT_list
		where year2=#session.fy#
		order by rank
	</cfquery>
				
	<cfif isDefined("addActiveMotivation") and form.addActiveMotivation EQ "addC">
	<cfquery datasource="#application.DataSource#"  
	 password="#application.db_password#" 
	 username="#application.db_username#" name="addCollabdet">
		insert into infra_collab
		(collab, purpose, type_inter,  num_inter,  userid, activity, month2, year2)
		values
		('#form.c_collab#', '#form.c_purpose#','#form.c_type#', '#form.c_num#','#activityInfo.userid#' ,'#activity#','#form.month#',#session.fy#)
		
	</cfquery>

	<cfelseif isDefined("addActiveMotivation") and form.addActiveMotivation EQ "delC">
	<cfquery datasource="#application.DataSource#"  
	 password="#application.db_password#" 
	 username="#application.db_username#" name="delCollabdet">
		delete from infra_collab
		where userid='#activityInfo.userid#'
		and activity='#activity#'
		and month2='#form.month#'
		and year2=#session.fy#
		and seq in (#form.del_collab#)
		
	</cfquery>
	</cfif>
	
	<cfquery datasource="#application.DataSource#"  
	 password="#application.db_password#" 
	 username="#application.db_username#" name="collabdet">
		select collab, purpose, type_inter,  num_inter, seq 
		from infra_collab
		where  userid= '#activityInfo.userid#' 
		and activity = '#activity#'
		and month2='#form.month#'
		and year2 = #session.fy#
		order by seq
	</cfquery>

	<tr>
		<td><a name="collab">
</a><h3>Collaboration with NYS TCP Regional or Area Partners or other agencies</h3>
		</td>
	</tr>
	<tr>
		<td>
			<table align="left" cellpadding="10" cellspacing="0" border="0" class="box">
				<tr>
					<th>	Collaborator
					</th>
					<th>	Purpose
					</th>
					<th>	Type of interaction
					</th>
					<th>	Number of suceh interactions
					</th>
					
				</tr>
				<tr>
					<th>
					    <cfselect name="c_collab" value="num" display="descrip" query="ccollab"></cfselect>
					</th>
					<th>
					    <cfselect name="c_purpose" value="num" display="descrip" query="cpurpose"></cfselect>
					</th>
					<th>
					    <cfselect name="c_type" value="num" display="descrip" query="ctype"></cfselect>
					</th>
					
					<th>
					    <cfinput name="c_num" type="Text">
					</th>
					
					
					<th>
					<input type="Button" value="Add" onclick="addMotivation('addC');" class="AddButton">
					</th>
				</tr>
		
	
				<cfif collabdet.recordcount GT 0>
				<cfoutput>
				<cfloop query="collabdet">
				

	<cfquery datasource="#application.DataSource#"  
	 password="#application.db_password#" 
	 username="#application.db_username#" name="ccollabdet">
		select  descrip 
		from ICC_list
		where num in (#collab#)
		and year2=#session.fy#
	</cfquery>
	<cfquery datasource="#application.DataSource#"  
	 password="#application.db_password#" 
	 username="#application.db_username#" name="cpurpDet">
		select  descrip 
		from ICP_list
		where num in (#purpose#)		
		and year2=#session.fy#
	</cfquery>
	<cfquery datasource="#application.DataSource#"  
	 password="#application.db_password#" 
	 username="#application.db_username#" name="ctypeDet">
		select  descrip 
		from ICT_list
		where num in (#type_inter#)		
		and year2=#session.fy#
	</cfquery>
				<tr bgcolor="Silver">
				<td>#valuelist(ccollabdet.descrip)#</td>
				<td>#valuelist(cpurpDet.descrip)#</td>
				<td>#valuelist(ctypeDet.descrip)#</td>
				<td>#num_inter#</td>
				<td><input type="Checkbox" value="#seq#" name="del_collab"></td>
				</tr>
				</cfloop></cfoutput>
				<tr><td colspan="4"></td><td><input type="Button" value="Delete" onclick="addMotivation('delC');" class="DelButton"></td></tr>
				</cfif>
				
				</table>
			</td>
		</tr>
		</cfif>
		<cfif infrafocusarea.stratfocus EQ "4">
		<tr><td>
		<tr>
		<td><a name="staff">
</a><h3>Staffing</h3>
		</td>
	</tr>
	<tr>
		<td>
			<table align="left" cellpadding="10" cellspacing="0" border="0" class="box">
			<tr>
				<td>Time spent developing job descriptions</td>
				<td><cfinput type="text" name="staff_devel" value="#form.staff_devel#"></td>
			</tr>
			<tr>
				<td>Time spent recruiting and advertising for an open position</td>
				<td><cfinput type="text" name="staff_recruit" value="#form.staff_recruit#"></td>
			</tr>
			<tr>
				<td>Time spent interviewing and hiring for an open position</td>
				<td><cfinput type="text" name="staff_interview" value="#form.staff_interview#"></td>
			</tr>
			</table>
		</td>
	</tr>
	</cfif>
	</cfif>
<cfif pendStatus EQ "0">
<tr><td>&nbsp;</td></tr>
<cfinclude template="earnedM.cfm">
<tr><td>&nbsp;</td></tr>
<cfinclude template="tcpsust.cfm">
</cfif>
	<cfinclude template="barriers.cfm">

