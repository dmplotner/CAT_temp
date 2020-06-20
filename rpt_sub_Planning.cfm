<!--- template to collect planning data, by focus area --->

 <cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="maxmonth">
	select max(d.rank) as mmonth, d.mon 
			from monthS as d, planning as A
			where d.mon = a.month2 
			AND  A.userid = '#Guserid#'
			and A.activity = '#Gactivity#'
			and A.year2 = #session.fy#
			and d.rank <= #form.endmonth#
			and d.rank >= #form.stmonth#
			group by d.mon
			order by 1 desc
</cfquery>

<!--- <cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="CurStatus">
	select status
			from #tablename#
			where month2 = '#maxmonth.mon#'
			AND  userid = '#Guserid#'
			and activity = '#Gactivity#'
			and year2 = #session.fy#			
</cfquery> --->
 
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QPlanning">
select
userid,
activity,
P_GOVT_1,
P_GOVT_2,
P_GOVT_2D,
P_GOVT_3,
P_GOVT_4,
P_GOVT_4D,
P_GOVT_5,
P_PM_1,
P_PM_2,
P_PM_2D,
P_PM_3,
P_PM_3D,
P_PM_4,
P_PM_4D,
P_PM_5,
P_PM_6, P_PM_6a, P_PM_6d,
P_PM_7, P_PM_8,
P_CF_1,
P_CF_2,
P_CF_2D,
P_CF_3,
P_CF_4,
P_CF_5,
P_CF_6,
P_MON_1,
P_MON_2,
P_MON_2D,
P_SURVEY_1,
P_SURVEY_2,
P_SURVEY_2D,
P_SURVEY_3,
P_SURVEY_3D,
P_SURVEY_4,
P_SURVEY_4D,
P_SURVEY_5,
P_SURVEY_5D,
P_SURVEY_6,
P_SURVEY_7,
P_SURVEY_8,
P_SURVEY_9,
P_SURVEY_10,
P_PROV_QW_1,
P_PROV_QW_2,
P_PROV_QW_2D,
P_PROV_QW_3,
P_PROV_QW_4,
P_PROV_QW_5,
P_PROV_QW_5D,
P_PROV_QW_6,
P_PROV_QW_7,
P_PROV_PROV_1,
P_PROV_PROV_1D,
P_PROV_PROV_2,
P_PROV_PROV_3,
P_PROV_PROV_4,
P_PROV_PROM_1,
P_PROV_PROM_2,
P_PROV_PROM_2D,
P_PROV_PROM_3,
P_PROV_PROM_4,
P_CESS_1,
P_CESS_2,
P_CESS_2D,
P_CESS_3,
P_CESS_3D,
P_CESS_4,
P_CESS_4D,
P_CESS_5,
P_COMM_1,
P_COMM_2,
P_COMM_2D,
P_COMM_3,
P_COMM_3D,
P_COMM_4,
P_COMM_4D,
P_COMM_5
from planning
where userid='#Guserid#'
and activity = '#Gactivity#'
and year2=#session.fy#
and month2='#maxmonth.mon#'
</cfquery>

<cfif maxmonth.recordcount GT 0>
<!--- <table border=".5" width="100%" cellspacing="0">
<tr><th align="left" width="30%">Strategy Status (<cfoutput>#maxmonth.mon#</cfoutput>)</th>
<td width="70%"><cfoutput>#CurStatus.status#</cfoutput></td>
</tr>
</table> --->

<table border=".5" width="100%" cellspacing="0">
<tr><th colspan="3" align="left">Strategy Planning Data (<cfoutput>#maxmonth.mon#</cfoutput>)</th></tr>


<!--- <tr><td width="65%">government policy-maker voting record, etc. researched</td>
<td width="20%">Yes <input type="checkbox" <cfif isDefined("QPlanning.P_GOVT_1") and QPlanning.P_GOVT_1 eq "1"> checked </cfif>disabled>
                 No <input type="checkbox" <cfif isDefined("QPlanning.P_GOVT_1") and QPlanning.P_GOVT_1 eq "0"> checked </cfif> disabled></td><td>&nbsp;</td></tr>
 --->


<cfswitch expression="#focusareaNum#">
<cfcase value="1">
<!--- GOVT Policy --->
<tr>
	<td valign="top" width="65%">Govt Policy-maker voting record, policy statements and campaign contributors were researched</td>
	<td valign="top" width="20%">
		<input type="checkbox" name="P_GOVT_1" value="1"<cfif isDefined("Qplanning.P_GOVT_1") and Qplanning.P_GOVT_1 EQ "1"> checked</cfif> disabled>Yes
		<input type="checkbox" name="P_GOVT_1" value="0"<cfif (isDefined("Qplanning.P_GOVT_1") and Qplanning.P_GOVT_1 EQ "0") OR NOT isDefined("Qplanning.P_GOVT_1")> checked</cfif> disabled>No
		<input type="checkbox" name="P_GOVT_1" value="2"<cfif (isDefined("Qplanning.P_GOVT_1") and Qplanning.P_GOVT_1 EQ "2")> checked</cfif> disabled>NA
	</td><td>&nbsp;</td>
</tr>

<tr>
	<td valign="top">Plans to carry out the education campaign were finalized</td>
	<td valign="top">
		<input type="checkbox" name="P_GOVT_2" value="1"<cfif isDefined("Qplanning.P_GOVT_2") and Qplanning.P_GOVT_2 EQ "1"> checked</cfif> disabled>Yes
		<input type="checkbox" name="P_GOVT_2" value="0"<cfif (isDefined("Qplanning.P_GOVT_2") and Qplanning.P_GOVT_2 EQ "0") OR NOT isDefined("Qplanning.P_GOVT_2")> checked</cfif> disabled>No
		<input type="checkbox" name="P_GOVT_2" value="2"<cfif (isDefined("Qplanning.P_GOVT_2") and Qplanning.P_GOVT_2 EQ "2")> checked</cfif> disabled>NA
		</td><td>Date:
		<cfif isDefined("Qplanning.P_GOVT_2D") and Qplanning.P_Govt_2d NEQ "1/1/1900"><cfoutput>#dateformat(Qplanning.P_GOVT_2D,'m/d/yyyy')#</cfoutput></cfif>
	</td>
</tr>
<tr>
	<td valign="top">Collaborating advocate organizationsand individualsbeing recruited</td>
	<td valign="top">
		<input type="checkbox" name="P_GOVT_3" value="1"<cfif isDefined("Qplanning.P_GOVT_3") and Qplanning.P_GOVT_3 EQ "1"> checked</cfif> disabled>Yes
		<input type="checkbox" name="P_GOVT_3" value="0"<cfif (isDefined("Qplanning.P_GOVT_3") and Qplanning.P_GOVT_3 EQ "0") OR NOT isDefined("Qplanning.P_GOVT_3")> checked</cfif> disabled>No
		<input type="checkbox" name="P_GOVT_3" value="2"<cfif (isDefined("Qplanning.P_GOVT_3") and Qplanning.P_GOVT_3 EQ "2")> checked</cfif> disabled>NA
	</td><td>&nbsp;</td>
</tr>
<tr>
	<td valign="top">A timeline for the project was outlined</td>
	<td valign="top">
		<input type="checkbox" name="P_GOVT_4" value="1"<cfif isDefined("Qplanning.P_GOVT_4") and Qplanning.P_GOVT_4 EQ "1"> checked</cfif> disabled>Yes
		<input type="checkbox" name="P_GOVT_4" value="0"<cfif (isDefined("Qplanning.P_GOVT_4") and Qplanning.P_GOVT_4 EQ "0") OR NOT isDefined("Qplanning.P_GOVT_4")> checked</cfif> disabled>No
		<input type="checkbox" name="P_GOVT_4" value="2"<cfif (isDefined("Qplanning.P_GOVT_4") and Qplanning.P_GOVT_4 EQ "2")> checked</cfif> disabled>NA
	    </td><td>Date:<cfif isDefined("Qplanning.P_GOVT_4D") and Qplanning.P_Govt_4d NEQ "1/1/1900"><cfoutput>#dateformat(Qplanning.P_GOVT_4D,'m/d/yyyy')#</cfoutput></cfif>
		

	</td>
</tr>
<tr>
	<td valign="top">Meetings with local government personnel being organized</td>
	<td valign="top">
		<input type="checkbox" name="P_GOVT_5" value="1"<cfif isDefined("Qplanning.P_GOVT_5") and Qplanning.P_GOVT_5 EQ "1"> checked</cfif> disabled>Yes
		<input type="checkbox" name="P_GOVT_5" value="0"<cfif (isDefined("Qplanning.P_GOVT_5") and Qplanning.P_GOVT_5 EQ "0") OR NOT isDefined("Qplanning.P_GOVT_5")> checked</cfif> disabled>No
		<input type="checkbox" name="P_GOVT_5" value="2"<cfif (isDefined("Qplanning.P_GOVT_5") and Qplanning.P_GOVT_5 EQ "2")> checked</cfif> disabled>NA
	</td><td>&nbsp;</td>
</tr>

</cfcase>
<!--- Paid Media --->
<cfcase value="2">
<tr>
	<td valign="top" width="65%">Solicitation or RFP to contract with media firm being developed</td>
	<td valign="top" width="20%">
		<input type="checkbox" name="P_PM_1" value="1"<cfif isDefined("Qplanning.P_PM_1") and Qplanning.P_PM_1 EQ "1"> checked</cfif> disabled>Yes
		<input type="checkbox" name="P_PM_1" value="0"<cfif (isDefined("Qplanning.P_PM_1") and Qplanning.P_PM_1 EQ "0") OR NOT isDefined("Qplanning.P_PM_1")> checked</cfif> disabled>No
		<input type="checkbox" name="P_PM_1" value="2"<cfif (isDefined("Qplanning.P_PM_1") and Qplanning.P_PM_1 EQ "2")> checked</cfif> disabled>NA
	</td><td>&nbsp;</td>
</tr>

<tr>
	<td valign="top">Solicitation or RFP to contract with media firm released</td>
	<td valign="top">
		<input type="checkbox" name="P_PM_2" value="1"<cfif isDefined("Qplanning.P_PM_2") and Qplanning.P_PM_2 EQ "1"> checked</cfif> disabled>Yes
		<input type="checkbox" name="P_PM_2" value="0"<cfif (isDefined("Qplanning.P_PM_2") and Qplanning.P_PM_2 EQ "0") OR NOT isDefined("Qplanning.P_PM_2")> checked</cfif> disabled>No
		<input type="checkbox" name="P_PM_2" value="0"<cfif (isDefined("Qplanning.P_PM_2") and Qplanning.P_PM_2 EQ "2")> checked</cfif> disabled>NA
		</td><td>Date:
		<cfif isDefined("Qplanning.P_PM_2d") and Qplanning.P_PM_2d NEQ "1/1/1900"><cfoutput>#dateformat(Qplanning.P_PM_2d,'m/d/yyyy')#</cfoutput></cfif>

	</td>
</tr>

<tr>
	<td valign="top">Media firm researched</td>
	<td valign="top">
		<input type="checkbox" name="P_PM_3" value="1"<cfif isDefined("Qplanning.P_PM_3") and Qplanning.P_PM_3 EQ "1"> checked</cfif> disabled>Yes
		<input type="checkbox" name="P_PM_3" value="0"<cfif (isDefined("Qplanning.P_PM_3") and Qplanning.P_PM_3 EQ "0") OR NOT isDefined("Qplanning.P_PM_3")> checked</cfif> disabled>No
		<input type="checkbox" name="P_PM_3" value="2"<cfif (isDefined("Qplanning.P_PM_3") and Qplanning.P_PM_3 EQ "2")> checked</cfif> disabled>NA
		</td><td>Date:
		<cfif isDefined("Qplanning.P_PM_3d") and Qplanning.P_PM_3d NEQ "1/1/1900"><cfoutput>#dateformat(Qplanning.P_PM_3d,'m/d/yyyy')#</cfoutput></cfif>
	</td>
</tr>

<tr>
	<td valign="top">Contract with media firm signed</td>
	<td valign="top">
		<input type="checkbox" name="P_PM_4" value="1"<cfif isDefined("Qplanning.P_PM_4") and Qplanning.P_PM_4 EQ "1"> checked</cfif> disabled>Yes
		<input type="checkbox" name="P_PM_4" value="0"<cfif (isDefined("Qplanning.P_PM_4") and Qplanning.P_PM_4 EQ "0") OR NOT isDefined("Qplanning.P_PM_4")> checked</cfif> disabled>No
		<input type="checkbox" name="P_PM_4" value="2"<cfif (isDefined("Qplanning.P_PM_4") and Qplanning.P_PM_4 EQ "2")> checked</cfif> disabled>NA
		</td><td>Date:
		<cfif isDefined("Qplanning.P_PM_4d") and Qplanning.P_PM_4d NEQ "1/1/1900"><cfoutput>#dateformat(Qplanning.P_PM_4d,'m/d/yyyy')#</cfoutput></cfif>
	</td>
</tr>

<tr>
	<td valign="top">Meetings with media firm held</td>
	<td valign="top">
		<input type="checkbox" name="P_PM_5" value="1"<cfif isDefined("Qplanning.P_PM_5") and Qplanning.P_PM_5 EQ "1"> checked</cfif> disabled>Yes
		<input type="checkbox" name="P_PM_5" value="0"<cfif (isDefined("Qplanning.P_PM_5") and Qplanning.P_PM_5 EQ "0") OR NOT isDefined("Qplanning.P_PM_5")> checked</cfif> disabled>No
		<input type="checkbox" name="P_PM_5" value="2"<cfif (isDefined("Qplanning.P_PM_5") and Qplanning.P_PM_5 EQ "2")> checked</cfif> disabled>NA
	</td><td>&nbsp;</td>
</tr>

<!--- <tr>
	<td valign="top">Media that will be used in paid media campaign developed and approved</td>
	<td valign="top">
		<input type="checkbox" name="P_PM_6" value="1"<cfif isDefined("Qplanning.P_PM_6") and Qplanning.P_PM_6 EQ "1"> checked</cfif> disabled>Yes
		<input type="checkbox" name="P_PM_6" value="0"<cfif (isDefined("Qplanning.P_PM_6") and Qplanning.P_PM_6 EQ "0") OR NOT isDefined("Qplanning.P_PM_6")> checked</cfif> disabled>No
		<input type="checkbox" name="P_PM_6" value="2"<cfif (isDefined("Qplanning.P_PM_6") and Qplanning.P_PM_6 EQ "2")> checked</cfif> disabled>NA
	</td><td>&nbsp;</td>
</tr> --->


<tr>
	<td valign="top">Media that will be used in paid media campaign developed</td>
	<td valign="top">
		<input type="checkbox" name="P_PM_6" value="1"<cfif isDefined("Qplanning.P_PM_6") and Qplanning.P_PM_6 EQ "1"> checked</cfif> disabled>Yes
		<input type="checkbox" name="P_PM_6" value="0"<cfif (isDefined("Qplanning.P_PM_6") and Qplanning.P_PM_6 EQ "0") OR NOT isDefined("form.P_PM_6")> checked</cfif> disabled>No
<!--- 		<input type="radio" name="P_PM_6" value="2"<cfif (isDefined("form.P_PM_6") and form.P_PM_6 EQ "2")> checked</cfif>>NA --->
	</td><td>Date:
		<cfif isDefined("Qplanning.P_PM_6d") and Qplanning.P_PM_6d NEQ "1/1/1900"><cfoutput>#dateformat(Qplanning.P_PM_6d,'m/d/yyyy')#</cfoutput></cfif>
	</td>
</tr>

<tr>
	<td valign="top">Media that will be used in paid media campaign approved by Area Manager</td>
	<td valign="top">
		<input type="checkbox" name="P_PM_6a" value="1"<cfif isDefined("Qplanning.P_PM_6a") and Qplanning.P_PM_6a EQ "1"> checked</cfif> disabled>Yes
		<input type="checkbox" name="P_PM_6a" value="0"<cfif (isDefined("Qplanning.P_PM_6a") and Qplanning.P_PM_6a EQ "0") OR NOT isDefined("form.P_PM_6a")> checked</cfif> disabled>No
<!--- 		<input type="radio" name="P_PM_6a" value="2"<cfif (isDefined("form.P_PM_6a") and form.P_PM_6a EQ "2")> checked</cfif>>NA --->
	</td><td>Date:
		<cfif isDefined("Qplanning.P_PM_6ad") and Qplanning.P_PM_6ad NEQ "1/1/1900"><cfoutput>#dateformat(Qplanning.P_PM_6ad,'m/d/yyyy')#</cfoutput></cfif>
	</td>
</tr>

<tr>
	<td valign="top">Meetings held with other Community Partners to plan media campaign</td>
	<td valign="top">
		<input type="checkbox" name="P_PM_7" value="1"<cfif isDefined("Qplanning.P_PM_7") and Qplanning.P_PM_7 EQ "1"> checked</cfif> disabled>Yes
		<input type="checkbox" name="P_PM_7" value="0"<cfif (isDefined("Qplanning.P_PM_7") and Qplanning.P_PM_7 EQ "0") OR NOT isDefined("Qplanning.P_PM_7")> checked</cfif> disabled>No
		<input type="checkbox" name="P_PM_7" value="2"<cfif (isDefined("Qplanning.P_PM_7") and Qplanning.P_PM_7 EQ "2")> checked</cfif> disabled>NA
	</td><td>&nbsp;</td>
</tr>

<tr>
	<td valign="top">Meeting held with media outlet to plan media buy</td>
	<td valign="top">
		<input type="checkbox" name="P_PM_8" value="1"<cfif isDefined("Qplanning.P_PM_8") and Qplanning.P_PM_8 EQ "1"> checked</cfif> disabled>Yes
		<input type="checkbox" name="P_PM_8" value="0"<cfif (isDefined("Qplanning.P_PM_8") and Qplanning.P_PM_8 EQ "0") OR NOT isDefined("Qplanning.P_PM_8")> checked</cfif> disabled>No
		<input type="checkbox" name="P_PM_8" value="2"<cfif (isDefined("Qplanning.P_PM_8") and Qplanning.P_PM_8 EQ "2")> checked</cfif> disabled>NA
	</td><td>&nbsp;</td>
</tr>

</cfcase>
<!--- Community Forum  --->
<cfcase value="4">
<tr>
	<td valign="top" width="65%">Formal plan for event or outreach in development</td>
	<td valign="top" width="20%">
		<input type="checkbox" name="P_CF_1" value="1"<cfif isDefined("Qplanning.P_CF_1") and Qplanning.P_CF_1 EQ "1"> checked</cfif> disabled>Yes
		<input type="checkbox" name="P_CF_1" value="0"<cfif (isDefined("Qplanning.P_CF_1") and Qplanning.P_CF_1 EQ "0") OR NOT isDefined("Qplanning.P_CF_1")> checked</cfif> disabled>No
		<input type="checkbox" name="P_CF_1" value="2"<cfif (isDefined("Qplanning.P_CF_1") and Qplanning.P_CF_1 EQ "2")> checked</cfif> disabled>NA
	</td><td>&nbsp;</td>
</tr>
<tr>
	<td valign="top">Formal plan for event or outreach completed</td>
	<td valign="top">
		<input type="checkbox" name="P_CF_2" value="1"<cfif isDefined("Qplanning.P_CF_2") and Qplanning.P_CF_2 EQ "1"> checked</cfif> disabled>Yes
		<input type="checkbox" name="P_CF_2" value="0"<cfif (isDefined("Qplanning.P_CF_2") and Qplanning.P_CF_2 EQ "0") OR NOT isDefined("Qplanning.P_CF_2")> checked</cfif> disabled>No
		<input type="checkbox" name="P_CF_2" value="2"<cfif (isDefined("Qplanning.P_CF_2") and Qplanning.P_CF_2 EQ "2")> checked</cfif> disabled>NA
		</td><td>Date:
		<cfif isDefined("Qplanning.P_CF_2d") and Qplanning.P_CF_2d NEQ "1/1/1900"><cfoutput>#dateformat(Qplanning.P_CF_2d,'m/d/yyyy')#</cfoutput></cfif>
	</td>
</tr>
<tr>
	<td valign="top">Location logistics (location; food; technical needs) in progress</td>
	<td valign="top">
		<input type="checkbox" name="P_CF_3" value="1"<cfif isDefined("Qplanning.P_CF_3") and Qplanning.P_CF_3 EQ "1"> checked</cfif> disabled>Yes
		<input type="checkbox" name="P_CF_3" value="0"<cfif (isDefined("Qplanning.P_CF_3") and Qplanning.P_CF_3 EQ "0") OR NOT isDefined("Qplanning.P_CF_3")> checked</cfif> disabled>No
		<input type="checkbox" name="P_CF_3" value="2"<cfif (isDefined("Qplanning.P_CF_3") and Qplanning.P_CF_3 EQ "2")> checked</cfif> disabled>NA
	</td><td>&nbsp;</td>
</tr>
<tr>
	<td valign="top">Press conference organizing tasks in progress</td>
	<td valign="top">
		<input type="checkbox" name="P_CF_4" value="1"<cfif isDefined("Qplanning.P_CF_4") and Qplanning.P_CF_4 EQ "1"> checked</cfif> disabled>Yes
		<input type="checkbox" name="P_CF_4" value="0"<cfif (isDefined("Qplanning.P_CF_4") and Qplanning.P_CF_4 EQ "0") OR NOT isDefined("Qplanning.P_CF_4")> checked</cfif> disabled>No
		<input type="checkbox" name="P_CF_4" value="2"<cfif (isDefined("Qplanning.P_CF_4") and Qplanning.P_CF_4 EQ "2")> checked</cfif> disabled>NA
	</td><td>&nbsp;</td>
</tr>
<tr>
	<td valign="top">Target audience outreach/recruiting in progress</td>
	<td valign="top">
		<input type="checkbox" name="P_CF_5" value="1"<cfif isDefined("Qplanning.P_CF_5") and Qplanning.P_CF_5 EQ "1"> checked</cfif> disabled>Yes
		<input type="checkbox" name="P_CF_5" value="0"<cfif (isDefined("Qplanning.P_CF_5") and Qplanning.P_CF_5 EQ "0") OR NOT isDefined("Qplanning.P_CF_5")> checked</cfif> disabled>No
		<input type="checkbox" name="P_CF_5" value="2"<cfif (isDefined("Qplanning.P_CF_5") and Qplanning.P_CF_5 EQ "2")> checked</cfif> disabled>NA
	</td><td>&nbsp;</td>
</tr>
<tr>
	<td valign="top">Event speakers/workshop leaders being recruited</td>
	<td valign="top">
		<input type="checkbox" name="P_CF_6" value="1"<cfif isDefined("Qplanning.P_CF_6") and Qplanning.P_CF_6 EQ "1"> checked</cfif> disabled>Yes
		<input type="checkbox" name="P_CF_6" value="0"<cfif (isDefined("Qplanning.P_CF_6") and Qplanning.P_CF_6 EQ "0") OR NOT isDefined("Qplanning.P_CF_6")> checked</cfif> disabled>No
		<input type="checkbox" name="P_CF_6" value="2"<cfif (isDefined("Qplanning.P_CF_6") and Qplanning.P_CF_6 EQ "2")> checked</cfif> disabled>NA
	</td><td>&nbsp;</td>
</tr>

</cfcase>
<!--- Monitoring/Assesment --->
<cfcase value="5">
<tr>
	<td valign="top" width="65%">Assessment method and targets being researched</td>
	<td valign="top" width="20%">
		<input type="checkbox" name="P_MON_1" value="1"<cfif isDefined("Qplanning.P_MON_1") and Qplanning.P_MON_1 EQ "1"> checked</cfif> disabled>Yes
		<input type="checkbox" name="P_MON_1" value="0"<cfif (isDefined("Qplanning.P_MON_1") and Qplanning.P_MON_1 EQ "0") OR NOT isDefined("Qplanning.P_MON_1")> checked</cfif> disabled>No
		<input type="checkbox" name="P_MON_1" value="2"<cfif (isDefined("Qplanning.P_MON_1") and Qplanning.P_MON_1 EQ "2")> checked</cfif> disabled>NA
	</td><td>&nbsp;</td>
</tr>
<tr>
	<td valign="top">Assessment plan finalized</td>
	<td valign="top">
		<input type="checkbox" name="P_MON_2" value="1"<cfif isDefined("Qplanning.P_MON_2") and Qplanning.P_MON_2 EQ "1"> checked</cfif> disabled>Yes
		<input type="checkbox" name="P_MON_2" value="0"<cfif (isDefined("Qplanning.P_MON_2") and Qplanning.P_MON_2 EQ "0") OR NOT isDefined("Qplanning.P_MON_2")> checked</cfif> disabled>No
		<input type="checkbox" name="P_MON_2" value="2"<cfif (isDefined("Qplanning.P_MON_2") and Qplanning.P_MON_2 EQ "2")> checked</cfif> disabled>NA
		</td><td>Date:
		<cfif isDefined("Qplanning.P_MON_2d") and Qplanning.P_MON_2d NEQ "1/1/1900"><cfoutput>#dateformat(Qplanning.P_MON_2d,'m/d/yyyy')#</cfoutput></cfif>
	</td>
</tr>

</cfcase>
<!--- Survey of Public --->
<cfcase value="6">
<tr>
	<td valign="top" width="65%">Survey Instrument in Development</td>
	<td valign="top" width="20%">
		<input type="checkbox" name="P_SURVEY_1" value="1"<cfif isDefined("Qplanning.P_SURVEY_1") and Qplanning.P_SURVEY_1 EQ "1"> checked</cfif> disabled>Yes
		<input type="checkbox" name="P_SURVEY_1" value="0"<cfif (isDefined("Qplanning.P_SURVEY_1") and Qplanning.P_SURVEY_1 EQ "0") OR NOT isDefined("Qplanning.P_SURVEY_1")> checked</cfif> disabled>No
		<input type="checkbox" name="P_SURVEY_1" value="2"<cfif (isDefined("Qplanning.P_SURVEY_1") and Qplanning.P_SURVEY_1 EQ "2")> checked</cfif> disabled>NA
	</td><td>&nbsp;</td>
</tr>
<tr>
	<td valign="top">Survey instrument finalized</td>
	<td valign="top">
		<input type="checkbox" name="P_SURVEY_2" value="1"<cfif isDefined("Qplanning.P_SURVEY_2") and Qplanning.P_SURVEY_2 EQ "1"> checked</cfif> disabled>Yes
		<input type="checkbox" name="P_SURVEY_2" value="0"<cfif (isDefined("Qplanning.P_SURVEY_2") and Qplanning.P_SURVEY_2 EQ "0") OR NOT isDefined("Qplanning.P_SURVEY_2")> checked</cfif> disabled>No
		<input type="checkbox" name="P_SURVEY_2" value="2"<cfif (isDefined("Qplanning.P_SURVEY_2") and Qplanning.P_SURVEY_2 EQ "2")> checked</cfif> disabled>NA
		</td><td>Date:
		<cfif isDefined("Qplanning.P_SURVEY_2d") and Qplanning.P_Survey_2d NEQ "1/1/1900"><cfoutput>#dateformat(Qplanning.P_SURVEY_2d,'m/d/yyyy')#</cfoutput></cfif>
	</td>
</tr>
<tr>
	<td valign="top">Survey instrument submitted to IRB</td>
	<td valign="top">
		<input type="checkbox" name="P_SURVEY_3" value="1"<cfif isDefined("Qplanning.P_SURVEY_1") and Qplanning.P_SURVEY_3 EQ "1"> checked</cfif> disabled>Yes
		<input type="checkbox" name="P_SURVEY_3" value="0"<cfif (isDefined("Qplanning.P_SURVEY_1") and Qplanning.P_SURVEY_3 EQ "0") OR NOT isDefined("Qplanning.P_SURVEY_3")> checked</cfif> disabled>No
		<input type="checkbox" name="P_SURVEY_3" value="2"<cfif (isDefined("Qplanning.P_SURVEY_1") and Qplanning.P_SURVEY_3 EQ "2")> checked</cfif> disabled>NA		
		</td><td>Date:
		<cfif isDefined("Qplanning.P_SURVEY_3d") and Qplanning.P_Survey_3d NEQ "1/1/1900"><cfoutput>#dateformat(Qplanning.P_SURVEY_3d,'m/d/yyyy')#</cfoutput></cfif>
	</td>
</tr>
<tr>
	<td valign="top" width="65%">Survey Piloted</td>
	<td valign="top">
		<input type="checkbox" name="P_SURVEY_4" value="1"<cfif isDefined("Qplanning.P_SURVEY_4") and Qplanning.P_SURVEY_4 EQ "1"> checked</cfif> disabled>Yes
		<input type="checkbox" name="P_SURVEY_4" value="0"<cfif (isDefined("Qplanning.P_SURVEY_4") and Qplanning.P_SURVEY_4 EQ "0") OR NOT isDefined("Qplanning.P_SURVEY_4")> checked</cfif> disabled>No
		<input type="checkbox" name="P_SURVEY_4" value="2"<cfif (isDefined("Qplanning.P_SURVEY_4") and Qplanning.P_SURVEY_4 EQ "2")> checked</cfif> disabled>NA
		</td><td>Date:
		<cfif isDefined("Qplanning.P_SURVEY_4d") and Qplanning.P_SURVEY_4d NEQ "1/1/1900"><cfoutput>#dateformat(Qplanning.P_SURVEY_4d,'m/d/yyyy')#</cfoutput></cfif>
	</td>
</tr>
<tr>
	<td valign="top">Survey revision finalized</td>
	<td valign="top">
		<input type="checkbox" name="P_SURVEY_5" value="1"<cfif isDefined("Qplanning.P_SURVEY_5") and Qplanning.P_SURVEY_5 EQ "1"> checked</cfif> disabled>Yes
		<input type="checkbox" name="P_SURVEY_5" value="0"<cfif (isDefined("Qplanning.P_SURVEY_5") and Qplanning.P_SURVEY_5 EQ "0") OR NOT isDefined("Qplanning.P_SURVEY_5")> checked</cfif> disabled>No
		<input type="checkbox" name="P_SURVEY_5" value="2"<cfif (isDefined("Qplanning.P_SURVEY_5") and Qplanning.P_SURVEY_5 EQ "2")> checked</cfif> disabled>NA
		</td><td>Date:
		<cfif isDefined("Qplanning.P_SURVEY_5d") and Qplanning.P_SURVEY_5d NEQ "1/1/1900"><cfoutput>#dateformat(Qplanning.P_SURVEY_5d,'m/d/yyyy')#</cfoutput></cfif>
	</td>
</tr>
<tr>
	<td valign="top">Survey firms being researched</td>
	<td valign="top">
		<input type="checkbox" name="P_SURVEY_6" value="1"<cfif isDefined("Qplanning.P_SURVEY_6") and Qplanning.P_SURVEY_6 EQ "1"> checked</cfif> disabled>Yes
		<input type="checkbox" name="P_SURVEY_6" value="0"<cfif (isDefined("Qplanning.P_SURVEY_6") and Qplanning.P_SURVEY_6 EQ "0") OR NOT isDefined("Qplanning.P_SURVEY_6")> checked</cfif> disabled>No
		<input type="checkbox" name="P_SURVEY_6" value="2"<cfif (isDefined("Qplanning.P_SURVEY_6") and Qplanning.P_SURVEY_6 EQ "2")> checked</cfif> disabled>NA
	</td><td>&nbsp;</td>
</tr>
<tr>
	<td valign="top">Survey firm contracted</td>
	<td valign="top">
		<input type="checkbox" name="P_SURVEY_7" value="1"<cfif isDefined("Qplanning.P_SURVEY_7") and Qplanning.P_SURVEY_7 EQ "1"> checked</cfif> disabled>Yes
		<input type="checkbox" name="P_SURVEY_7" value="0"<cfif (isDefined("Qplanning.P_SURVEY_7") and Qplanning.P_SURVEY_7 EQ "0") OR NOT isDefined("Qplanning.P_SURVEY_7")> checked</cfif> disabled>No
		<input type="checkbox" name="P_SURVEY_7" value="2"<cfif (isDefined("Qplanning.P_SURVEY_7") and Qplanning.P_SURVEY_7 EQ "2")> checked</cfif> disabled>NA
	</td><td>&nbsp;</td>
</tr>
<tr>
	<td valign="top">Analysis plan being developed</td>
	<td valign="top">
		<input type="checkbox" name="P_SURVEY_8" value="1"<cfif isDefined("Qplanning.P_SURVEY_8") and Qplanning.P_SURVEY_9 EQ "1"> checked</cfif> disabled>Yes
		<input type="checkbox" name="P_SURVEY_8" value="0"<cfif (isDefined("Qplanning.P_SURVEY_8") and Qplanning.P_SURVEY_9 EQ "0") OR NOT isDefined("Qplanning.P_SURVEY_9")> checked</cfif> disabled>No
		<input type="checkbox" name="P_SURVEY_8" value="2"<cfif (isDefined("Qplanning.P_SURVEY_8") and Qplanning.P_SURVEY_9 EQ "2")> checked</cfif> disabled>NA
	</td><td>&nbsp;</td>
</tr>
<tr>
	<td valign="top">Protocol review form (with draft survey) submitted</td>
	<td valign="top">
		<input type="checkbox" name="P_SURVEY_9" value="1"<cfif isDefined("Qplanning.P_SURVEY_9") and Qplanning.P_SURVEY_9 EQ "1"> checked</cfif> disabled>Yes
		<input type="checkbox" name="P_SURVEY_9" value="0"<cfif (isDefined("Qplanning.P_SURVEY_9") and Qplanning.P_SURVEY_9 EQ "0") OR NOT isDefined("Qplanning.P_SURVEY_9")> checked</cfif> disabled>No
		<input type="checkbox" name="P_SURVEY_9" value="2"<cfif (isDefined("Qplanning.P_SURVEY_9") and Qplanning.P_SURVEY_9 EQ "2")> checked</cfif> disabled>NA
	</td><td>&nbsp;</td>
</tr>
<tr>
	<td valign="top">Protocol review form revised- using feedback from TCP regional evaluation specialists - and resubmitted</td>
	<td valign="top">
		<input type="checkbox" name="P_SURVEY_10" value="1"<cfif isDefined("Qplanning.P_SURVEY_10") and Qplanning.P_SURVEY_1 EQ "1"> checked</cfif> disabled>Yes
		<input type="checkbox" name="P_SURVEY_10" value="0"<cfif (isDefined("Qplanning.P_SURVEY_10") and Qplanning.P_SURVEY_1 EQ "0") OR NOT isDefined("Qplanning.P_SURVEY_10")> checked</cfif> disabled>No
		<input type="checkbox" name="P_SURVEY_10" value="2"<cfif (isDefined("Qplanning.P_SURVEY_10") and Qplanning.P_SURVEY_1 EQ "2") OR NOT isDefined("Qplanning.P_SURVEY_10")> checked</cfif> disabled>NA
	</td><td>&nbsp;</td>
</tr>
</cfcase>

<cfcase value="7">
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="activityInfo">
	
	select  typepromo
	from useractivities
	where 
	userid= '#Guserid#' 
	and activity = '#Gactivity#'
	and year2=#session.fy#
</cfquery>


<cfif activityInfo.typepromo EQ "1">
<!--- Provision or promotion of cessation service Q&W --->
<tr>
	<td valign="top" width="65%">Promotional material in development</td>
	<td valign="top" width="20%">
		<input type="checkbox" name="P_PROV_QW_1" value="1"<cfif isDefined("Qplanning.P_PROV_QW_1") and Qplanning.P_PROV_QW_1 EQ "1"> checked</cfif> disabled>Yes
		<input type="checkbox" name="P_PROV_QW_1" value="0"<cfif (isDefined("Qplanning.P_PROV_QW_1") and Qplanning.P_PROV_QW_1 EQ "0") OR NOT isDefined("Qplanning.P_PROV_QW_1")> checked</cfif> disabled>No
		<input type="checkbox" name="P_PROV_QW_1" value="2"<cfif (isDefined("Qplanning.P_PROV_QW_1") and Qplanning.P_PROV_QW_1 EQ "2")> checked</cfif> disabled>NA
	</td><td>&nbsp;</td>
</tr>
<tr>
	<td valign="top">Promotional material finalized</td>
	<td valign="top">
		<input type="checkbox" name="P_PROV_QW_2" value="1"<cfif isDefined("Qplanning.P_PROV_QW_2") and Qplanning.P_PROV_QW_2 EQ "1"> checked</cfif> disabled>Yes
		<input type="checkbox" name="P_PROV_QW_2" value="0"<cfif (isDefined("Qplanning.P_PROV_QW_2") and Qplanning.P_PROV_QW_2 EQ "0") OR NOT isDefined("Qplanning.P_PROV_QW_2")> checked</cfif> disabled>No
		<input type="checkbox" name="P_PROV_QW_2" value="2"<cfif (isDefined("Qplanning.P_PROV_QW_2") and Qplanning.P_PROV_QW_2 EQ "2")> checked</cfif> disabled>NA
		</td><td>Date:<cfif isDefined("Qplanning.p_prov_qw_2d") and Qplanning.P_prov_qw_2d NEQ "1/1/1900"><cfoutput>#dateformat(Qplanning.p_prov_qw_2d,'m/d/yyyy')#</cfoutput></cfif>
	</td>
</tr>
<tr>
	<td valign="top">Agencies/organizations solicited to promote</td>
	<td valign="top">
		<input type="checkbox" name="P_PROV_QW_3" value="1"<cfif isDefined("Qplanning.P_PROV_QW_3") and Qplanning.P_PROV_QW_3 EQ "1"> checked</cfif> disabled>Yes
		<input type="checkbox" name="P_PROV_QW_3" value="0"<cfif (isDefined("Qplanning.P_PROV_QW_1") and Qplanning.P_PROV_QW_3 EQ "0") OR NOT isDefined("Qplanning.P_PROV_QW_3")> checked</cfif> disabled>No
		<input type="checkbox" name="P_PROV_QW_3" value="2"<cfif (isDefined("Qplanning.P_PROV_QW_1") and Qplanning.P_PROV_QW_3 EQ "2")> checked</cfif> disabled>NA
	</td><td>&nbsp;</td>
</tr>
<tr>
	<td valign="top">Media promotional plan in development</td>
	<td valign="top">
		<input type="checkbox" name="P_PROV_QW_4" value="1"<cfif isDefined("Qplanning.P_PROV_QW_4") and Qplanning.P_PROV_QW_4 EQ "1"> checked</cfif> disabled>Yes
		<input type="checkbox" name="P_PROV_QW_4" value="0"<cfif (isDefined("Qplanning.P_PROV_QW_4") and Qplanning.P_PROV_QW_4 EQ "0") OR NOT isDefined("Qplanning.P_PROV_QW_4")> checked</cfif> disabled>No
		<input type="checkbox" name="P_PROV_QW_4" value="2"<cfif (isDefined("Qplanning.P_PROV_QW_4") and Qplanning.P_PROV_QW_4 EQ "2")> checked</cfif> disabled>NA
	</td><td>&nbsp;</td>
</tr>
<tr>
	<td valign="top">Media promotional plan finalized</td>
	<td valign="top">
		<input type="checkbox" name="P_PROV_QW_5" value="1"<cfif isDefined("Qplanning.P_PROV_QW_5") and Qplanning.P_PROV_QW_5 EQ "1"> checked</cfif> disabled>Yes
		<input type="checkbox" name="P_PROV_QW_5" value="0"<cfif (isDefined("Qplanning.P_PROV_QW_5") and Qplanning.P_PROV_QW_5 EQ "0") OR NOT isDefined("Qplanning.P_PROV_QW_5")> checked</cfif> disabled>No
		<input type="checkbox" name="P_PROV_QW_5" value="2"<cfif (isDefined("Qplanning.P_PROV_QW_5") and Qplanning.P_PROV_QW_5 EQ "2")> checked</cfif> disabled>NA
		</td><td>Date:<cfif isDefined("Qplanning.p_prov_qw_5d") and Qplanning.P_prov_qw_5d NEQ "1/1/1900"><cfoutput>#dateformat(Qplanning.p_prov_qw_5d,'m/d/yyyy')#</cfoutput></cfif>
	</td>
</tr>
<tr>
	<td valign="top">Prizes solicited</td>
	<td valign="top">
		<input type="checkbox" name="P_PROV_QW_6" value="1"<cfif isDefined("Qplanning.P_PROV_QW_6") and Qplanning.P_PROV_QW_6 EQ "1"> checked</cfif> disabled>Yes
		<input type="checkbox" name="P_PROV_QW_6" value="0"<cfif (isDefined("Qplanning.P_PROV_QW_6") and Qplanning.P_PROV_QW_6 EQ "0") OR NOT isDefined("Qplanning.P_PROV_QW_6")> checked</cfif> disabled>No
		<input type="checkbox" name="P_PROV_QW_6" value="2"<cfif (isDefined("Qplanning.P_PROV_QW_6") and Qplanning.P_PROV_QW_6 EQ "2")> checked</cfif> disabled>NA
	</td><td>&nbsp;</td>
</tr>
<tr>
	<td valign="top">Dollar ammount committed this month</td>
	<td valign="top">
		<cfif isDefined("Qplanning.P_PROV_QW_7")><cfoutput>$#Qplanning.P_PROV_QW_7#</cfoutput></cfif>
	</td><td>&nbsp;</td>
</tr>

<cfelseif activityInfo.typepromo EQ "2">
<!--- Provision or promotion of cessation service Provision of Cessation Services --->
<tr>
	<td valign="top" width="65%">Assessment of gaps in cessation services availability finalized</td>
	<td valign="top" width="20%">
		<input type="checkbox" name="P_PROV_PROV_1" value="1"<cfif isDefined("Qplanning.P_PROV_PROV_1") and Qplanning.P_PROV_PROV_1 EQ "1"> checked</cfif> disabled>Yes
		<input type="checkbox" name="P_PROV_PROV_1" value="0"<cfif (isDefined("Qplanning.P_PROV_PROV_1") and Qplanning.P_PROV_PROV_1 EQ "0") OR NOT isDefined("Qplanning.P_PROV_PROV_1")> checked</cfif> disabled>No
		<input type="checkbox" name="P_PROV_PROV_1" value="2"<cfif (isDefined("Qplanning.P_PROV_PROV_1") and Qplanning.P_PROV_PROV_1 EQ "2")> checked</cfif> disabled>NA
		</td><td>Date:
		<cfif isDefined("Qplanning.P_PROV_PROV_1d") and Qplanning.P_PROV_PROV_1d NEQ "1/1/1900"><cfoutput>#dateformat(Qplanning.P_PROV_PROV_1d,'m/d/yyyy')#</cfoutput></cfif>
	</td>
</tr>
<tr>
	<td valign="top">Recruitment of cessation program participants underway</td>
	<td valign="top">
		<input type="checkbox" name="P_PROV_PROV_2" value="1"<cfif isDefined("Qplanning.P_PROV_PROV_2") and Qplanning.P_PROV_PROV_2 EQ "1"> checked</cfif> disabled>Yes
		<input type="checkbox" name="P_PROV_PROV_2" value="0"<cfif (isDefined("Qplanning.P_PROV_PROV_2") and Qplanning.P_PROV_PROV_2 EQ "0") OR NOT isDefined("Qplanning.P_PROV_PROV_2")> checked</cfif> disabled>No
		<input type="checkbox" name="P_PROV_PROV_2" value="2"<cfif (isDefined("Qplanning.P_PROV_PROV_2") and Qplanning.P_PROV_PROV_2 EQ "2")> checked</cfif> disabled>NA
	</td><td>&nbsp;</td>
</tr>
<tr>
	<td valign="top">NRT giveaway plan in development</td>
	<td valign="top">
		<input type="checkbox" name="P_PROV_PROV_3" value="1"<cfif isDefined("Qplanning.P_PROV_PROV_3") and Qplanning.P_PROV_PROV_3 EQ "1"> checked</cfif> disabled>Yes
		<input type="checkbox" name="P_PROV_PROV_3" value="0"<cfif (isDefined("Qplanning.P_PROV_PROV_3") and Qplanning.P_PROV_PROV_3 EQ "0") OR NOT isDefined("Qplanning.P_PROV_PROV_3")> checked</cfif> disabled>No
		<input type="checkbox" name="P_PROV_PROV_3" value="2"<cfif (isDefined("Qplanning.P_PROV_PROV_3") and Qplanning.P_PROV_PROV_3 EQ "2")> checked</cfif> disabled>NA
	</td><td>&nbsp;</td>
</tr>
<tr>
	<td valign="top">NRT giveaway promotion in progress</td>
	<td valign="top">
		<input type="checkbox" name="P_PROV_PROV_4" value="1"<cfif isDefined("Qplanning.P_PROV_PROV_4") and Qplanning.P_PROV_PROV_4 EQ "1"> checked</cfif> disabled>Yes
		<input type="checkbox" name="P_PROV_PROV_4" value="0"<cfif (isDefined("Qplanning.P_PROV_PROV_4") and Qplanning.P_PROV_PROV_4 EQ "0") OR NOT isDefined("Qplanning.P_PROV_PROV_4")> checked</cfif> disabled>No
		<input type="checkbox" name="P_PROV_PROV_4" value="2"<cfif (isDefined("Qplanning.P_PROV_PROV_4") and Qplanning.P_PROV_PROV_4 EQ "2")> checked</cfif> disabled>NA
	</td><td>&nbsp;</td>
</tr>

<cfelseif activityInfo.typepromo EQ "3">
<!--- Provision or promotion of cessation service Promotion of specific cessatiom --->
<tr>
	<td valign="top">Promotional plan in development</td>
	<td valign="top">
		<input type="checkbox" name="P_PROV_PROM_1" value="1"<cfif isDefined("Qplanning.P_PROV_PROM_1") and Qplanning.P_PROV_PROM_1 EQ "1"> checked</cfif> disabled>Yes
		<input type="checkbox" name="P_PROV_PROM_1" value="0"<cfif (isDefined("Qplanning.P_PROV_PROM_1") and Qplanning.P_PROV_PROM_1 EQ "0") OR NOT isDefined("Qplanning.P_PROV_PROM_1")> checked</cfif> disabled>No
		<input type="checkbox" name="P_PROV_PROM_1" value="2"<cfif (isDefined("Qplanning.P_PROV_PROM_1") and Qplanning.P_PROV_PROM_1 EQ "2")> checked</cfif> disabled>NA
	</td>&nbsp;<td>
	</td>
</tr>
<tr>
	<td valign="top" width="65%">Promotional plan finalized</td>
	<td valign="top" width="20%">
		<input type="checkbox" name="P_PROV_PROM_2" value="1"<cfif isDefined("Qplanning.P_PROV_PROM_2") and Qplanning.P_PROV_PROM_2 EQ "1"> checked</cfif> disabled>Yes
		<input type="checkbox" name="P_PROV_PROM_2" value="0"<cfif (isDefined("Qplanning.P_PROV_PROM_2") and Qplanning.P_PROV_PROM_2 EQ "0") OR NOT isDefined("Qplanning.P_PROV_PROM_2")> checked</cfif> disabled>No
		<input type="checkbox" name="P_PROV_PROM_2" value="2"<cfif (isDefined("Qplanning.P_PROV_PROM_2") and Qplanning.P_PROV_PROM_2 EQ "2")> checked</cfif> disabled>NA
	</td>
	<td>Date:
		<cfif isDefined("Qplanning.P_PROV_PROM_2d") and Qplanning.P_PROV_PROM_2d NEQ "1/1/1900"><cfoutput>#dateformat(Qplanning.P_PROV_PROM_2d,'m/d/yyyy')#</cfoutput></cfif>&nbsp;</td>
</tr>

<tr>
	<td valign="top">Collaborating agencies/organizations being recruited</td>
	<td valign="top">
		<input type="checkbox" name="P_PROV_PROM_3" value="1"<cfif isDefined("Qplanning.P_PROV_PROM_3") and Qplanning.P_PROV_PROM_3 EQ "1"> checked</cfif> disabled>Yes
		<input type="checkbox" name="P_PROV_PROM_3" value="0"<cfif (isDefined("Qplanning.P_PROV_PROM_3") and Qplanning.P_PROV_PROM_3 EQ "0") OR NOT isDefined("Qplanning.P_PROV_PROM_3")> checked</cfif> disabled>No
		<input type="checkbox" name="P_PROV_PROM_3" value="2"<cfif (isDefined("Qplanning.P_PROV_PROM_3") and Qplanning.P_PROV_PROM_3 EQ "2")> checked</cfif> disabled>NA
	</td><td>&nbsp;</td>
</tr>
<tr>
	<td valign="top">Cessation services directory in development</td>
	<td valign="top">
		<input type="checkbox" name="P_PROV_PROM_4" value="1"<cfif isDefined("Qplanning.P_PROV_PROM_4") and Qplanning.P_PROV_PROM_4 EQ "1"> checked</cfif> disabled>Yes
		<input type="checkbox" name="P_PROV_PROM_4" value="0"<cfif (isDefined("Qplanning.P_PROV_PROM_4") and Qplanning.P_PROV_PROM_4 EQ "0") OR NOT isDefined("Qplanning.P_PROV_PROM_4")> checked</cfif> disabled>No
		<input type="checkbox" name="P_PROV_PROM_4" value="2"<cfif (isDefined("Qplanning.P_PROV_PROM_4") and Qplanning.P_PROV_PROM_4 EQ "2")> checked</cfif> disabled>NA
	</td><td>&nbsp;</td>
</tr>

</cfif>
</cfcase>
<!--- Cessation Centers --->
<cfcase value="8">
<tr>
	<td valign="top" width="65%">Advocacy plan in development</td>
	<td valign="top" width="20%">
		<input type="checkbox" name="P_CESS_1" value="1"<cfif isDefined("Qplanning.P_CESS_1") and Qplanning.P_CESS_1 EQ "1"> checked</cfif> disabled>Yes
		<input type="checkbox" name="P_CESS_1" value="0"<cfif (isDefined("Qplanning.P_CESS_1") and Qplanning.P_CESS_1 EQ "0") OR NOT isDefined("Qplanning.P_CESS_1")> checked</cfif> disabled>No
		<input type="checkbox" name="P_CESS_1" value="2"<cfif (isDefined("Qplanning.P_CESS_1") and Qplanning.P_CESS_1 EQ "2")> checked</cfif> disabled>NA
	</td><td>&nbsp;</td>
</tr>
<tr>
	<td valign="top">Advocacy plan finalized</td>
	<td valign="top">
		<input type="checkbox" name="P_CESS_2" value="1"<cfif isDefined("Qplanning.P_CESS_2") and Qplanning.P_CESS_2 EQ "1"> checked</cfif> disabled>Yes
		<input type="checkbox" name="P_CESS_2" value="0"<cfif (isDefined("Qplanning.P_CESS_2") and Qplanning.P_CESS_2 EQ "0") OR NOT isDefined("Qplanning.P_CESS_2")> checked</cfif> disabled>No
		<input type="checkbox" name="P_CESS_2" value="2"<cfif (isDefined("Qplanning.P_CESS_2") and Qplanning.P_CESS_2 EQ "2")> checked</cfif> disabled>NA
		</td><td>Date:
		<cfif isDefined("Qplanning.P_CESS_2d") and Qplanning.P_cess_2d NEQ "1/1/1900"><cfoutput>#dateformat(Qplanning.P_CESS_2d,'m/d/yyyy')#</cfoutput></cfif>
	</td>
</tr>
<tr>
	<td valign="top">RFP for mini-grant developed</td>
	<td valign="top">
		<input type="checkbox" name="P_CESS_3" value="1"<cfif isDefined("Qplanning.P_CESS_3") and Qplanning.P_CESS_3 EQ "1"> checked</cfif> disabled>Yes
		<input type="checkbox" name="P_CESS_3" value="0"<cfif (isDefined("Qplanning.P_CESS_3") and Qplanning.P_CESS_3 EQ "0") OR NOT isDefined("Qplanning.P_CESS_3")> checked</cfif> disabled>No
		<input type="checkbox" name="P_CESS_3" value="2"<cfif (isDefined("Qplanning.P_CESS_3") and Qplanning.P_CESS_3 EQ "2")> checked</cfif> disabled>NA
		</td><td>Date:
		<cfif isDefined("Qplanning.P_CESS_3d") and Qplanning.P_cess_3d NEQ "1/1/1900"><cfoutput>#dateformat(Qplanning.P_CESS_3d,'m/d/yyyy')#</cfoutput></cfif>
	</td>
</tr>
<tr>
	<td valign="top">RFP for mini-grant released</td>
	<td valign="top">
		<input type="checkbox" name="P_CESS_4" value="1"<cfif isDefined("Qplanning.P_CESS_4") and Qplanning.P_CESS_4 EQ "1"> checked</cfif> disabled>Yes
		<input type="checkbox" name="P_CESS_4" value="0"<cfif (isDefined("Qplanning.P_CESS_4") and Qplanning.P_CESS_4 EQ "0") OR NOT isDefined("Qplanning.P_CESS_4")> checked</cfif> disabled>No
		<input type="checkbox" name="P_CESS_4" value="2"<cfif (isDefined("Qplanning.P_CESS_4") and Qplanning.P_CESS_4 EQ "2")> checked</cfif> disabled>NA
		</td><td>Date:
		<cfif isDefined("Qplanning.P_CESS_4d") and Qplanning.P_cess_4d NEQ "1/1/1900"><cfoutput>#dateformat(Qplanning.P_CESS_4d,'m/d/yyyy')#</cfoutput></cfif>
	</td>
</tr>
<tr>
	<td valign="top">Mini-grant proposals reviewed</td>
	<td valign="top">
		<input type="checkbox" name="P_CESS_5" value="1"<cfif isDefined("Qplanning.P_CESS_5") and Qplanning.P_CESS_5 EQ "1"> checked</cfif> disabled>Yes
		<input type="checkbox" name="P_CESS_5" value="0"<cfif (isDefined("Qplanning.P_CESS_5") and Qplanning.P_CESS_5 EQ "0") OR NOT isDefined("Qplanning.P_CESS_5")> checked</cfif> disabled>No
		<input type="checkbox" name="P_CESS_5" value="2"<cfif (isDefined("Qplanning.P_CESS_5") and Qplanning.P_CESS_5 EQ "2")> checked</cfif> disabled>NA
	</td><td>&nbsp;</td>
</tr>

</cfcase>
<!--- Community and Youth Partners --->
<cfcase value="9">
<tr>
	<td valign="top" width="65%">Advocacy plan in development</td>
	<td valign="top" width="20%">
		<input type="checkbox" name="P_COMM_1" value="1"<cfif isDefined("Qplanning.P_COMM_1") and Qplanning.P_COMM_1 EQ "1"> checked</cfif> disabled>Yes
		<input type="checkbox" name="P_COMM_1" value="0"<cfif (isDefined("Qplanning.P_COMM_1") and Qplanning.P_COMM_1 EQ "0") OR NOT isDefined("Qplanning.P_COMM_1")> checked</cfif> disabled>No
		<input type="checkbox" name="P_COMM_1" value="2"<cfif (isDefined("Qplanning.P_COMM_1") and Qplanning.P_COMM_1 EQ "2")> checked</cfif> disabled>N
	</td><td>&nbsp;</td>
</tr>
<tr>
	<td valign="top">Advocacy plan finalized</td>
	<td valign="top">
		<input type="checkbox" name="P_COMM_2" value="1"<cfif isDefined("Qplanning.P_COMM_2") and Qplanning.P_COMM_2 EQ "1"> checked</cfif> disabled>Yes
		<input type="checkbox" name="P_COMM_2" value="0"<cfif (isDefined("Qplanning.P_COMM_2") and Qplanning.P_COMM_2 EQ "0") OR NOT isDefined("Qplanning.P_COMM_2")> checked</cfif> disabled>No
		<input type="checkbox" name="P_COMM_2" value="2"<cfif (isDefined("Qplanning.P_COMM_2") and Qplanning.P_COMM_2 EQ "2")> checked</cfif> disabled>NA
		</td><td>Date:
		<cfif isDefined("Qplanning.P_COMM_2d") and Qplanning.P_comm_2d NEQ "1/1/1900"><cfoutput>#dateformat(Qplanning.P_COMM_2d,'m/d/yyyy')#</cfoutput></cfif>
		</td>
</tr>
<tr>
	<td valign="top">RFP for minigrant developed</td>
	<td valign="top">
		<input type="checkbox" name="P_COMM_3" value="1"<cfif isDefined("Qplanning.P_COMM_3") and Qplanning.P_COMM_3 EQ "1"> checked</cfif> disabled>Yes
		<input type="checkbox" name="P_COMM_3" value="0"<cfif (isDefined("Qplanning.P_COMM_3") and Qplanning.P_COMM_3 EQ "0") OR NOT isDefined("Qplanning.P_COMM_3")> checked</cfif> disabled>No
		<input type="checkbox" name="P_COMM_3" value="2"<cfif (isDefined("Qplanning.P_COMM_3") and Qplanning.P_COMM_3 EQ "2")> checked</cfif> disabled>NA
		</td><td>Date:
		<cfif isDefined("Qplanning.P_COMM_3d") and Qplanning.P_comm_3d NEQ "1/1/1900"><cfoutput>#dateformat(Qplanning.P_COMM_3d,'m/d/yyyy')#</cfoutput></cfif>
	</td>
</tr>
<tr>
	<td valign="top">RFP for minigrant released</td>
	<td valign="top">
		<input type="checkbox" name="P_COMM_4" value="1"<cfif isDefined("Qplanning.P_COMM_4") and Qplanning.P_COMM_4 EQ "1"> checked</cfif> disabled>Yes
		<input type="checkbox" name="P_COMM_4" value="0"<cfif (isDefined("Qplanning.P_COMM_4") and Qplanning.P_COMM_4 EQ "0") OR NOT isDefined("Qplanning.P_COMM_4")> checked</cfif> disabled>No
		<input type="checkbox" name="P_COMM_4" value="2"<cfif (isDefined("Qplanning.P_COMM_4") and Qplanning.P_COMM_4 EQ "2")> checked</cfif> disabled>NA
		</td><td>Date:
		<cfif isDefined("Qplanning.P_COMM_4d") and Qplanning.P_comm_4d NEQ "1/1/1900"><cfoutput>#dateformat(Qplanning.P_COMM_4d,'m/d/yyyy')#</cfoutput></cfif>
	</td>
</tr>
<tr>
	<td valign="top">Mini-grant proposals reviewed</td>
	<td valign="top">
		<input type="checkbox" name="P_COMM_5" value="1"<cfif isDefined("Qplanning.P_COMM_5") and Qplanning.P_COMM_5 EQ "1"> checked</cfif> disabled>Yes
		<input type="checkbox" name="P_COMM_5" value="0"<cfif (isDefined("Qplanning.P_COMM_5") and Qplanning.P_COMM_5 EQ "0") OR NOT isDefined("Qplanning.P_COMM_5")> checked</cfif> disabled>No
		<input type="checkbox" name="P_COMM_5" value="2"<cfif (isDefined("Qplanning.P_COMM_5") and Qplanning.P_COMM_5 EQ "2")> checked</cfif> disabled>NA
	</td><td>&nbsp;</td>
</tr>
</cfcase>
</cfswitch>
</table>
</cfif>
<!--- <cfinclude template="rpt_collabs.cfm"> --->