<!--- template to collect planning data, by focus area --->
 <cfif http_referer DOES NOT CONTAIN "monthlyActive.cfm">
 <!--- <cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="maxmonth">
	select max(d.rank) as mmonth, d.mon 
			from monthS as d, planning as A
			where d.mon = a.month2 
			AND  A.userid = '#activityInfo.userid#'
			and A.activity = '#activity#'
			and A.year2 = #form.year#			
			group by d.mon
			order by 1 desc
</cfquery> --->
 
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QPlanning">
select
userid,
activity,
P_GOVT_1,
P_GOVT_2,
P_GOVT_3,
P_GOVT_4,

P_PM_1,
P_PM_2,
P_PM_3,

P_CF_1,
P_CF_2,
P_CF_3,

P_MON_1,
P_MON_2,


P_SURVEY_1,
P_SURVEY_2,
P_SURVEY_3,
P_SURVEY_4,
P_SURVEY_5,

P_COMM_1,
P_COMM_2,
P_COMM_3,
P_COMM_4,
P_COMM_4_num,

P_PROV_1,
P_PROV_2,
P_PROV_3

from planning
where userid='#activityInfo.userid#'
and activity = '#activity#'
and year2=#session.fy#
and month2='#form.monthdisplay#'
</cfquery>

<cfset form.P_GOVT_1=Qplanning.P_GOVT_1> 
<cfset form.P_GOVT_2=Qplanning.P_GOVT_2> 
<cfset form.P_GOVT_3=Qplanning.P_GOVT_3> 
<cfset form.P_GOVT_4=Qplanning.P_GOVT_4> 
<cfset form.P_PM_1=Qplanning.P_PM_1> 
<cfset form.P_PM_2=Qplanning.P_PM_2> 
<cfset form.P_PM_3=Qplanning.P_PM_3> 
<cfset form.P_CF_1=Qplanning.P_CF_1> 
<cfset form.P_CF_2=Qplanning.P_CF_2> 
<cfset form.P_CF_3=Qplanning.P_CF_3> 

<cfset form.P_MON_1=Qplanning.P_MON_1> 
<cfset form.P_MON_2=Qplanning.P_MON_2> 

<cfset form.P_SURVEY_1=Qplanning.P_SURVEY_1> 
<cfset form.P_SURVEY_2=Qplanning.P_SURVEY_2> 
<cfset form.P_SURVEY_3=Qplanning.P_SURVEY_3> 
<cfset form.P_SURVEY_4=Qplanning.P_SURVEY_4> 
<cfset form.P_SURVEY_5=Qplanning.P_SURVEY_5> 

<cfset form.P_PROV_1=Qplanning.P_PROV_1> 
<cfset form.P_PROV_2=Qplanning.P_PROV_2> 
<cfset form.P_PROV_3=Qplanning.P_PROV_3> 

<cfset form.P_COMM_1=Qplanning.P_COMM_1> 
<cfset form.P_COMM_2=Qplanning.P_COMM_2> 
<cfset form.P_COMM_3=Qplanning.P_COMM_3> 
<cfset form.P_COMM_4=Qplanning.P_COMM_4> 
<cfset form.P_COMM_4_num=Qplanning.P_COMM_4_num> 
</cfif> 


<table class="box" >


<tr><th colspan="2">Strategy Planning Data</th></tr>
<tr><td colspan="2" align="left">
Please check the boxes for all planning activities that were conducted this month.
</td></tr>
<INPUT type="hidden" name="SWITCHEXPR" value="<CFOUTPUT>#activityInfo.strategy#</CFOUTPUT>">
<cfswitch expression="#activityInfo.strategy#">
<cfcase value="1">
<!--- GOVT Policy --->
<tr>
	<td valign="top" colspan="2"><input type="checkbox" name="P_GOVT_1" value="1"<cfif isDefined("form.P_GOVT_1") and form.P_GOVT_1 EQ "1"> checked</cfif>>
	Researched policy-maker voting record, policy statements and campaign contributors
	</td>
	
</tr>

<tr>
	<td valign="top" colspan="2"><input type="checkbox" name="P_GOVT_2" value="1"<cfif isDefined("form.P_GOVT_2") and form.P_GOVT_2 EQ "1"> checked</cfif>>
	Developed content of educational campaign</td>
	
</tr>

<tr>
	<td valign="top" colspan="2"><input type="checkbox" name="P_GOVT_3" value="1"<cfif isDefined("form.P_GOVT_3") and form.P_GOVT_3 EQ "1"> checked</cfif>>
	Recruited collaborating organizations and individuals for education effort</td>
	
</tr>

<tr>
	<td valign="top" colspan="2"><input type="checkbox" name="P_GOVT_4" value="1"<cfif isDefined("form.P_GOVT_4") and form.P_GOVT_4 EQ "1"> checked</cfif>>
	Scheduled meetings with policy-makers (If you actually held meetings this month, make sure the strategy is in "ongoing" status and report the meetings below)
	</td>
	
</tr>



</cfcase>
<!--- Paid Media --->
<cfcase value="2">
<tr>
	<td valign="top" colspan="2"><input type="checkbox" name="P_PM_1" value="1"<cfif isDefined("form.P_PM_1") and form.P_PM_1 EQ "1"> checked</cfif>>
	Worked with media firm (on ad selection, development, and/or buys) </td>
	
</tr>
<tr>
	<td valign="top" colspan="2"><input type="checkbox" name="P_PM_2" value="1"<cfif isDefined("form.P_PM_2") and form.P_PM_2 EQ "1"> checked</cfif>>
	Worked with other partners to plan media campaign
	</td>
	
</tr>
<tr>
	<td valign="top" colspan="2"><input type="checkbox" name="P_PM_3" value="1"<cfif isDefined("form.P_PM_3") and form.P_PM_3 EQ "1"> checked</cfif>>
	Submitted media campaign content for Modality Manager approval
	</td>
	
</tr>

</cfcase>
<!--- Community Forum  --->
<cfcase value="4">
<tr>
	<td valign="top" colspan="2"><input type="checkbox" name="P_CF_1" value="1"<cfif isDefined("form.P_CF_1") and form.P_CF_1 EQ "1"> checked</cfif>>
	Worked on logistics (location, food, technical needs, development of materials, etc.)
	</td>
	
</tr>
<tr>
	<td valign="top" colspan="2"><input type="checkbox" name="P_CF_2" value="1"<cfif isDefined("form.P_CF_2") and form.P_CF_2 EQ "1"> checked</cfif>>
	Recruited or conducted outreach to target audience
	</td>
	
</tr>
<tr>
	<td valign="top" colspan="2"><input type="checkbox" name="P_CF_3" value="1"<cfif isDefined("form.P_CF_3") and form.P_CF_3 EQ "1"> checked</cfif>>
	Recruited event speakers/workshop leaders
	</td>
	
</tr>
</cfcase>
<!--- Monitoring/Assesment --->
<cfcase value="5">
<tr>
	<td valign="top" colspan="2"><input type="checkbox" name="P_MON_1" value="1"<cfif isDefined("form.P_MON_1") and form.P_MON_1 EQ "1"> checked</cfif>>
	Worked to determine assessment method and targets
	</td>
	
</tr>
<tr>
	<td valign="top" colspan="2"><input type="checkbox" name="P_MON_2" value="1"<cfif isDefined("form.P_MON_2") and form.P_MON_2 EQ "1"> checked</cfif>>
	Worked on developing tool to be used for monitoring/assessment
	</td>
	
</tr>

</cfcase>
<!--- Survey of Public --->
<cfcase value="6">
<tr>
	<td valign="top" colspan="2"><input type="checkbox" name="P_SURVEY_1" value="1"<cfif isDefined("form.P_SURVEY_1") and form.P_SURVEY_1 EQ "1"> checked</cfif>>
	Worked on developing survey instrument
	</td>	
</tr>

<tr>
	<td valign="top" colspan="2"><input type="checkbox" name="P_SURVEY_2" value="1"<cfif isDefined("form.P_SURVEY_2") and form.P_SURVEY_2 EQ "1"> checked</cfif>>
	Worked with survey firm
	</td>	
</tr>

<tr>
	<td valign="top" colspan="2"><input type="checkbox" name="P_SURVEY_3" value="1"<cfif isDefined("form.P_SURVEY_3") and form.P_SURVEY_3 EQ "1"> checked</cfif>>
	Worked on Protocol Review Form (PRF)
	</td>	
</tr>

<tr>
	<td valign="top" colspan="2"><input type="checkbox" name="P_SURVEY_4" value="1"<cfif isDefined("form.P_SURVEY_4") and form.P_SURVEY_4 EQ "1"> checked</cfif>>
	Submitted PRF and survey instrument for TSERT approval
	</td>	
</tr>

<tr>
	<td valign="top" colspan="2"><input type="checkbox" name="P_SURVEY_5" value="1"<cfif isDefined("form.P_SURVEY_5") and form.P_SURVEY_5 EQ "1"> checked</cfif>>
	Submitted PRF and survey instrument for IRB approval
	</td>	
</tr>

</cfcase>
<cfcase value="7">
<tr>
	<td valign="top" colspan="2"><input type="checkbox" name="P_PROV_1" value="1"<cfif isDefined("form.P_PROV_1") and form.P_PROV_1 EQ "1"> checked</cfif>>
	Assessment of gaps in cessation services availability finalized
	</td>	
</tr>
<tr>
	<td valign="top" colspan="2"><input type="checkbox" name="P_PROV_2" value="1"<cfif isDefined("form.P_PROV_2") and form.P_PROV_2 EQ "1"> checked</cfif>>
	Recruitment of cessation program in participants underway
	</td>	
</tr>
<tr>
	<td valign="top" colspan="2"><input type="checkbox" name="P_PROV_3" value="1"<cfif isDefined("form.P_PROV_3") and form.P_SURVEY_5 EQ "1"> checked</cfif>>
	NRT giveaway plan in development
	</td>	
</tr>
<!---
<cfif activityInfo.typepromo EQ "1">
 <!--- Provision or promotion of cessation service Q&W --->
<tr>
	<td valign="top">Promotional material in development</td>
	<td valign="top">
		<input type="radio" name="P_PROV_QW_1" value="1"<cfif isDefined("form.P_PROV_QW_1") and form.P_PROV_QW_1 EQ "1"> checked</cfif>>Yes
		<input type="radio" name="P_PROV_QW_1" value="0"<cfif (isDefined("form.P_PROV_QW_1") and form.P_PROV_QW_1 EQ "0" or (form.P_PROV_QW_1 NEQ "1" and form.P_PROV_QW_1 NEQ "2")) OR NOT isDefined("form.P_PROV_QW_1")> checked</cfif>>No
		<input type="radio" name="P_PROV_QW_1" value="2"<cfif (isDefined("form.P_PROV_QW_1") and form.P_PROV_QW_1 EQ "2")> checked</cfif>>NA
	</td>
</tr>
<tr>
	<td valign="top">Promotional material finalized</td>
	<td valign="top">
		<input type="radio" name="P_PROV_QW_2" value="1"<cfif isDefined("form.P_PROV_QW_2") and form.P_PROV_QW_2 EQ "1"> checked</cfif>>Yes
		<input type="radio" name="P_PROV_QW_2" value="0"<cfif (isDefined("form.P_PROV_QW_2") and form.P_PROV_QW_2 EQ "0" or (form.P_PROV_QW_2 NEQ "1" and form.P_PROV_QW_2 NEQ "2")) OR NOT isDefined("form.P_PROV_QW_2")> checked</cfif>>No
		<input type="radio" name="P_PROV_QW_2" value="2"<cfif (isDefined("form.P_PROV_QW_2") and form.P_PROV_QW_2 EQ "2")> checked</cfif>>NA
		<br>Date (mm/dd/yyyy):<cfif isDefined("form.p_prov_qw_2d") and form.p_prov_qw_2d NEQ "1/1/1900">
					<cfinput name="P_PROV_QW_2d" type="text" value="#dateformat(form.p_prov_qw_2d,'m/d/yyyy')#" validate="date" message="Please enter dates in the format 'mm/dd/yyyy'">	
				<cfelse>
					<cfinput name="P_PROV_QW_2d" type="text" validate="date" message="Please enter dates in the format 'mm/dd/yyyy'">	
				</cfif>
			
	</td>
</tr>
<tr>
	<td valign="top">Agencies/organizations solicited to promote</td>
	<td valign="top">
		<input type="radio" name="P_PROV_QW_3" value="1"<cfif isDefined("form.P_PROV_QW_3") and form.P_PROV_QW_3 EQ "1"> checked</cfif>>Yes
		<input type="radio" name="P_PROV_QW_3" value="0"<cfif (isDefined("form.P_PROV_QW_3") and form.P_PROV_QW_3 EQ "0" or (form.P_PROV_QW_3 NEQ "1" and form.P_PROV_QW_3 NEQ "2")) OR NOT isDefined("form.P_PROV_QW_3")> checked</cfif>>No
		<input type="radio" name="P_PROV_QW_3" value="2"<cfif (isDefined("form.P_PROV_QW_3") and form.P_PROV_QW_3 EQ "2")> checked</cfif>>NA
	</td>
</tr>
<tr>
	<td valign="top">Media promotional plan in development</td>
	<td valign="top">
		<input type="radio" name="P_PROV_QW_4" value="1"<cfif isDefined("form.P_PROV_QW_4") and form.P_PROV_QW_4 EQ "1"> checked</cfif>>Yes
		<input type="radio" name="P_PROV_QW_4" value="0"<cfif (isDefined("form.P_PROV_QW_4") and form.P_PROV_QW_4 EQ "0" or (form.P_PROV_QW_4 NEQ "1" and form.P_PROV_QW_4 NEQ "2")) OR NOT isDefined("form.P_PROV_QW_4")> checked</cfif>>No
		<input type="radio" name="P_PROV_QW_4" value="2"<cfif (isDefined("form.P_PROV_QW_4") and form.P_PROV_QW_4 EQ "2")> checked</cfif>>NA
	</td>
</tr>
<tr>
	<td valign="top">Media promotional plan finalized</td>
	<td valign="top">
		<input type="radio" name="P_PROV_QW_5" value="1"<cfif isDefined("form.P_PROV_QW_5") and form.P_PROV_QW_5 EQ "1"> checked</cfif>>Yes
		<input type="radio" name="P_PROV_QW_5" value="0"<cfif (isDefined("form.P_PROV_QW_5") and form.P_PROV_QW_5 EQ "0" or (form.P_PROV_QW_5 NEQ "1" and form.P_PROV_QW_5 NEQ "2")) OR NOT isDefined("form.P_PROV_QW_5")> checked</cfif>>No
		<input type="radio" name="P_PROV_QW_5" value="2"<cfif (isDefined("form.P_PROV_QW_5") and form.P_PROV_QW_5 EQ "2")> checked</cfif>>NA		
		<br>Date (mm/dd/yyyy):<cfif isDefined("form.p_prov_qw_5d") and form.p_prov_qw_5d NEQ "1/1/1900">
					<cfinput name="P_PROV_QW_5d" type="text" value="#dateformat(form.p_prov_qw_5d,'m/d/yyyy')#" validate="date" message="Please enter dates in the format 'mm/dd/yyyy'">	
				<cfelse>
					<cfinput name="P_PROV_QW_5d" type="text" validate="date" message="Please enter dates in the format 'mm/dd/yyyy'">	
				</cfif>
	</td>
</tr>
<tr>
	<td valign="top">Prizes solicited</td>
	<td valign="top">
		<input type="radio" name="P_PROV_QW_6" value="1"<cfif isDefined("form.P_PROV_QW_6") and form.P_PROV_QW_6 EQ "1"> checked</cfif>>Yes
		<input type="radio" name="P_PROV_QW_6" value="0"<cfif (isDefined("form.P_PROV_QW_6") and form.P_PROV_QW_6 EQ "0" or (form.P_PROV_QW_6 NEQ "1" and form.P_PROV_QW_6 NEQ "2")) OR NOT isDefined("form.P_PROV_QW_6")> checked</cfif>>No
		<input type="radio" name="P_PROV_QW_6" value="2"<cfif (isDefined("form.P_PROV_QW_6") and form.P_PROV_QW_6 EQ "2")> checked</cfif>>NA
	</td>
</tr>
<tr>
	<td valign="top">Dollar amount committed this month</td>
	<td valign="top">
		<cfif isDefined("form.P_PROV_QW_7")>
			$<cfinput name="P_PROV_QW_7" type="text" validate="float" value="#form.P_PROV_QW_7#" message="Please enter a numeric amount for dollars( no symbols)'">	
		<cfelse>
			$<cfinput name="P_PROV_QW_7" type="text" validate="float" message="Please enter a numeric amount for dollars( no symbols)'">	
		</cfif>
	</td>
</tr>

<cfelseif activityInfo.typepromo EQ "2">
<!--- Provision or promotion of cessation service Provision of Cessation Services --->
<tr>
	<td valign="top">Assessment of gaps in cessation services availability finalized</td>
	<td valign="top">
		<input type="radio" name="P_PROV_PROV_1" value="1"<cfif isDefined("form.P_PROV_PROV_1") and form.P_PROV_PROV_1 EQ "1"> checked</cfif>>Yes
		<input type="radio" name="P_PROV_PROV_1" value="0"<cfif (isDefined("form.P_PROV_PROV_1") and form.P_PROV_PROV_1 EQ "0" or (form.P_PROV_PROV_1 NEQ "1" and form.P_PROV_PROV_1 NEQ "2")) OR NOT isDefined("form.P_PROV_PROV_1")> checked</cfif>>No
		<input type="radio" name="P_PROV_PROV_1" value="2"<cfif (isDefined("form.P_PROV_PROV_1") and form.P_PROV_PROV_1 EQ "2")> checked</cfif>>NA
		<br>Date (mm/dd/yyyy):
		<cfif isDefined("form.P_PROV_PROV_1d") and form.p_prov_prov_1d NEQ "1/1/1900">
					<cfinput name="P_PROV_PROV_1d" type="text" value="#dateformat(form.P_PROV_PROV_1d,'m/d/yyyy')#" validate="date" message="Please enter dates in the format 'mm/dd/yyyy'">	
				<cfelse>
					<cfinput name="P_PROV_PROV_1d" type="text" validate="date" message="Please enter dates in the format 'mm/dd/yyyy'">	
				</cfif>

	</td>
</tr>
<tr>
	<td valign="top">Recruitment of cessation program participants underway</td>
	<td valign="top">
		<input type="radio" name="P_PROV_PROV_2" value="1"<cfif isDefined("form.P_PROV_PROV_2") and form.P_PROV_PROV_2 EQ "1"> checked</cfif>>Yes
		<input type="radio" name="P_PROV_PROV_2" value="0"<cfif (isDefined("form.P_PROV_PROV_2") and form.P_PROV_PROV_2 EQ "0" or (form.P_PROV_PROV_2 NEQ "1" and form.P_PROV_PROV_2 NEQ "2")) OR NOT isDefined("form.P_PROV_PROV_2")> checked</cfif>>No
		<input type="radio" name="P_PROV_PROV_2" value="2"<cfif (isDefined("form.P_PROV_PROV_2") and form.P_PROV_PROV_2 EQ "2")> checked</cfif>>NA
	</td>
</tr>
<tr>
	<td valign="top">NRT giveaway plan in development</td>
	<td valign="top">
		<input type="radio" name="P_PROV_PROV_3" value="1"<cfif isDefined("form.P_PROV_PROV_3") and form.P_PROV_PROV_3 EQ "1"> checked</cfif>>Yes
		<input type="radio" name="P_PROV_PROV_3" value="0"<cfif (isDefined("form.P_PROV_PROV_3") and form.P_PROV_PROV_3 EQ "0" or (form.P_PROV_PROV_3 NEQ "1" and form.P_PROV_PROV_3 NEQ "2")) OR NOT isDefined("form.P_PROV_PROV_3")> checked</cfif>>No
		<input type="radio" name="P_PROV_PROV_3" value="2"<cfif (isDefined("form.P_PROV_PROV_3") and form.P_PROV_PROV_3 EQ "2")> checked</cfif>>NA
	</td>
</tr>
<tr>
	<td valign="top">NRT giveaway promotion in progress</td>
	<td valign="top">
		<input type="radio" name="P_PROV_PROV_4" value="1"<cfif isDefined("form.P_PROV_PROV_4") and form.P_PROV_PROV_4 EQ "1"> checked</cfif>>Yes
		<input type="radio" name="P_PROV_PROV_4" value="0"<cfif (isDefined("form.P_PROV_PROV_4") and form.P_PROV_PROV_4 EQ "0" or (form.P_PROV_PROV_4 NEQ "1" and form.P_PROV_PROV_4 NEQ "2")) OR NOT isDefined("form.P_PROV_PROV_4")> checked</cfif>>No
		<input type="radio" name="P_PROV_PROV_4" value="2"<cfif (isDefined("form.P_PROV_PROV_4") and form.P_PROV_PROV_4 EQ "2")> checked</cfif>>NA
	</td>
</tr>

<cfelseif activityInfo.typepromo EQ "3">
<!--- Provision or promotion of cessation service Promotion of specific cessatiom --->


<tr>
	<td valign="top">Promotional plan in development</td>
	<td valign="top">
		<input type="radio" name="P_PROV_PROM_2" value="1"<cfif isDefined("form.P_PROV_PROM_2") and form.P_PROV_PROM_2 EQ "1"> checked</cfif>>Yes
		<input type="radio" name="P_PROV_PROM_2" value="0"<cfif (isDefined("form.P_PROV_PROM_2") and form.P_PROV_PROM_2 EQ "0" or (form.P_PROV_PROM_2 NEQ "1" and form.P_PROV_PROM_2 NEQ "2")) OR NOT isDefined("form.P_PROV_PROM_2")> checked</cfif>>No
		<input type="radio" name="P_PROV_PROM_2" value="2"<cfif (isDefined("form.P_PROV_PROM_2") and form.P_PROV_PROM_2 EQ "2")> checked</cfif>>NA
		

	</td>
</tr>

<tr>
	<td valign="top">Promotional plan finalized</td>
	<td valign="top">
		<input type="radio" name="P_PROV_PROM_1" value="1"<cfif isDefined("form.P_PROV_PROM_1") and form.P_PROV_PROM_1 EQ "1"> checked</cfif>>Yes
		<input type="radio" name="P_PROV_PROM_1" value="0"<cfif (isDefined("form.P_PROV_PROM_1") and form.P_PROV_PROM_1 EQ "0" or (form.P_PROV_PROM_1 NEQ "1" and form.P_PROV_PROM_1 NEQ "2")) OR NOT isDefined("form.P_PROV_PROM_1")> checked</cfif>>No
		<input type="radio" name="P_PROV_PROM_1" value="2"<cfif (isDefined("form.P_PROV_PROM_1") and form.P_PROV_PROM_1 EQ "2")> checked</cfif>>NA
		<br>Date (mm/dd/yyyy):
		<cfif isDefined("form.P_PROV_PROM_2d") and form.p_prov_prom_2d NEQ "1/1/1900">
					<cfinput name="P_PROV_PROM_2d" type="text" value="#dateformat(form.P_PROV_PROM_2d,'m/d/yyyy')#" validate="date" message="Please enter dates in the format 'mm/dd/yyyy'">	
				<cfelse>
					<cfinput name="P_PROV_PROM_2d" type="text" validate="date" message="Please enter dates in the format 'mm/dd/yyyy'">	
				</cfif>
	</td>
</tr>
<tr>
	<td valign="top">Collaborating agencies/organizations being recruited</td>
	<td valign="top">
		<input type="radio" name="P_PROV_PROM_3" value="1"<cfif isDefined("form.P_PROV_PROM_3") and form.P_PROV_PROM_3 EQ "1"> checked</cfif>>Yes
		<input type="radio" name="P_PROV_PROM_3" value="0"<cfif (isDefined("form.P_PROV_PROM_3") and form.P_PROV_PROM_3 EQ "0" or (form.P_PROV_PROM_3 NEQ "1" and form.P_PROV_PROM_3 NEQ "2")) OR NOT isDefined("form.P_PROV_PROM_3")> checked</cfif>>No
		<input type="radio" name="P_PROV_PROM_3" value="2"<cfif (isDefined("form.P_PROV_PROM_3") and form.P_PROV_PROM_3 EQ "2")> checked</cfif>>NA
	</td>
</tr>
<tr>
	<td valign="top">Cessation services directory in development</td>
	<td valign="top">
		<input type="radio" name="P_PROV_PROM_4" value="1"<cfif isDefined("form.P_PROV_PROM_4") and form.P_PROV_PROM_4 EQ "1"> checked</cfif>>Yes
		<input type="radio" name="P_PROV_PROM_4" value="0"<cfif (isDefined("form.P_PROV_PROM_4") and form.P_PROV_PROM_4 EQ "0" or (form.P_PROV_PROM_4 NEQ "1" and form.P_PROV_PROM_4 NEQ "2")) OR NOT isDefined("form.P_PROV_PROM_4")> checked</cfif>>No
		<input type="radio" name="P_PROV_PROM_4" value="2"<cfif (isDefined("form.P_PROV_PROM_4") and form.P_PROV_PROM_4 EQ "2")> checked</cfif>>NA
	</td>
</tr>

</cfif> --->
</cfcase>
<!--- Cessation Centers --->
<!--- <cfcase value="8"> --->
<!--- <tr>
	<td valign="top">Advocacy plan in development</td>
	<td valign="top">
		<input type="radio" name="P_CESS_1" value="1"<cfif isDefined("form.P_CESS_1") and form.P_CESS_1 EQ "1"> checked</cfif>>Yes
		<input type="radio" name="P_CESS_1" value="0"<cfif (isDefined("form.P_CESS_1") and form.P_CESS_1 EQ "0" or (form.P_CESS_1 NEQ "1" and form.P_CESS_1 NEQ "2")) OR NOT isDefined("form.P_CESS_1")> checked</cfif>>No
		<input type="radio" name="P_CESS_1" value="2"<cfif (isDefined("form.P_CESS_1") and form.P_CESS_1 EQ "2")> checked</cfif>>NA
	</td>
</tr>
<tr>
	<td valign="top">Advocacy plan finalized</td>
	<td valign="top">
		<input type="radio" name="P_CESS_2" value="1"<cfif isDefined("form.P_CESS_2") and form.P_CESS_2 EQ "1"> checked</cfif>>Yes
		<input type="radio" name="P_CESS_2" value="0"<cfif (isDefined("form.P_CESS_2") and form.P_CESS_2 EQ "0" or (form.P_CESS_2 NEQ "1" and form.P_CESS_2 NEQ "2")) OR NOT isDefined("form.P_CESS_2")> checked</cfif>>No
		<input type="radio" name="P_CESS_2" value="2"<cfif (isDefined("form.P_CESS_2") and form.P_CESS_2 EQ "2")> checked</cfif>>NA
		Date (mm/dd/yyyy):
		<cfif isDefined("form.P_CESS_2d") and form.p_cess_2d NEQ "1/1/1900">
					<cfinput name="P_CESS_2d" type="text" value="#dateformat(form.P_CESS_2d,'m/d/yyyy')#" validate="date" message="Please enter dates in the format 'mm/dd/yyyy'">	
				<cfelse>
					<cfinput name="P_CESS_2d" type="text" validate="date" message="Please enter dates in the format 'mm/dd/yyyy'">	
				</cfif>

	</td>
</tr>
<tr>
	<td valign="top">RFP for mini-grant developed</td>
	<td valign="top">
		<input type="radio" name="P_CESS_3" value="1"<cfif isDefined("form.P_CESS_3") and form.P_CESS_3 EQ "1"> checked</cfif>>Yes
		<input type="radio" name="P_CESS_3" value="0"<cfif (isDefined("form.P_CESS_3") and form.P_CESS_3 EQ "0" or (form.P_CESS_3 NEQ "1" and form.P_CESS_3 NEQ "2")) OR NOT isDefined("form.P_CESS_3")> checked</cfif>>No
		<input type="radio" name="P_CESS_3" value="2"<cfif (isDefined("form.P_CESS_3") and form.P_CESS_3 EQ "2")> checked</cfif>>NA
		Date (mm/dd/yyyy):
		<cfif isDefined("form.P_CESS_3d") and form.p_cess_3d NEQ "1/1/1900">
					<cfinput name="P_CESS_3d" type="text" value="#dateformat(form.P_CESS_3d,'m/d/yyyy')#" validate="date" message="Please enter dates in the format 'mm/dd/yyyy'">	
				<cfelse>
					<cfinput name="P_CESS_3d" type="text" validate="date" message="Please enter dates in the format 'mm/dd/yyyy'">	
				</cfif>

	</td>
</tr>
<tr>
	<td valign="top">RFP for mini-grant released</td>
	<td valign="top">
		<input type="radio" name="P_CESS_4" value="1"<cfif isDefined("form.P_CESS_4") and form.P_CESS_4 EQ "1"> checked</cfif>>Yes
		<input type="radio" name="P_CESS_4" value="0"<cfif (isDefined("form.P_CESS_4") and form.P_CESS_4 EQ "0" or (form.P_CESS_4 NEQ "1" and form.P_CESS_4 NEQ "2")) OR NOT isDefined("form.P_CESS_4")> checked</cfif>>No
		<input type="radio" name="P_CESS_4" value="2"<cfif (isDefined("form.P_CESS_4") and form.P_CESS_4 EQ "2")> checked</cfif>>NA
		Date (mm/dd/yyyy):
		<cfif isDefined("form.P_CESS_4d") and form.p_cess_4d NEQ "1/1/1900">
					<cfinput name="P_CESS_4d" type="text" value="#dateformat(form.P_CESS_4d,'m/d/yyyy')#" validate="date" message="Please enter dates in the format 'mm/dd/yyyy'">	
				<cfelse>
					<cfinput name="P_CESS_4d" type="text" validate="date" message="Please enter dates in the format 'mm/dd/yyyy'">	
				</cfif>

	</td>
</tr>
<tr>
	<td valign="top">Mini-grant proposals reviewed</td>
	<td valign="top">
		<input type="radio" name="P_CESS_5" value="1"<cfif isDefined("form.P_CESS_5") and form.P_CESS_5 EQ "1"> checked</cfif>>Yes
		<input type="radio" name="P_CESS_5" value="0"<cfif (isDefined("form.P_CESS_5") and form.P_CESS_5 EQ "0" or (form.P_CESS_5 NEQ "1" and form.P_CESS_5 NEQ "2")) OR NOT isDefined("form.P_CESS_5")> checked</cfif>>No
		<input type="radio" name="P_CESS_5" value="2"<cfif (isDefined("form.P_CESS_5") and form.P_CESS_5 EQ "2")> checked</cfif>>NA
	</td>
</tr> --->

<!--- </cfcase> --->
<!--- Community and Youth Partners --->
<cfcase value="9;8" delimiters=";">
<tr>
	<td valign="top" colspan="2"><input type="checkbox" name="P_COMM_1" value="1"<cfif isDefined("form.P_COMM_1") and form.P_COMM_1 EQ "1"> checked</cfif>>
	Worked on developing advocacy plan</td>
	
</tr>
<tr>
	<td valign="top" colspan="2"><input type="checkbox" name="P_COMM_2" value="1"<cfif isDefined("form.P_COMM_2") and form.P_COMM_2 EQ "1"> checked</cfif>>
	Worked to recruit collaborating organizations and individuals for advocacy effort</td>
	
</tr>
<tr>
	<td valign="top" colspan="2"><input type="checkbox" name="P_COMM_3" value="1"<cfif isDefined("form.P_COMM_3") and form.P_COMM_3 EQ "1"> checked</cfif>>
	Scheduled meetings with decision-makers (If you actually held meetings this month, make sure the strategy is in “ongoing” status and report on them below.)</td>
	
</tr>
<tr>
	<td valign="top" colspan="2"><input type="checkbox" name="P_COMM_4" value="1"<cfif isDefined("form.P_COMM_4") and form.P_COMM_4 EQ "1"> checked</cfif>>
	Sent mass mailing to introduce topic to targets prior to advocacy</td>
	
</tr>

<tr>
	<td valign="top" colspan="2">
	Number of mailings sent: &nbsp;&nbsp;&nbsp;
	 <cfif isDefined("form.P_COMM_4_num")>
	<cfinput type="text" name="P_COMM_4_num" value="#form.P_COMM_4_num#" validate="integer" message="Please enter an integer without commas for number of mass mailings"></td>
	<cfelse>
	<cfinput type="text" name="P_COMM_4_num" validate="integer" message="Please enter an integer without commas for number of mass mailings">
	</cfif>
</tr>

</cfcase>
</cfswitch>
</table>
