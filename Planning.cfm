<cfif session.fy LT 1920 OR session.fy GT 2006>
	<cfinclude template="planning_new.cfm">
<cfelse>
<!--- template to collect planning data, by focus area --->
 <cfif http_referer DOES NOT CONTAIN "monthlyActive.cfm">
 <cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="maxmonth">
	select max(d.rank) as mmonth, d.mon 
			from monthS as d, planning as A
			where d.mon = a.month2  and d.year2 = a.year2
			AND  A.userid = '#activityInfo.userid#'
			and A.activity = '#activity#'
			and A.year2 = #form.year#			
			group by d.mon
			order by 1 desc
</cfquery>
 
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
P_PM_6,P_PM_6a, P_PM_6d, P_PM_6ad,
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
where userid='#activityInfo.userid#'
and activity = '#activity#'
and year2=#session.fy#
and month2='#maxmonth.mon#'
</cfquery>

<cfset form.P_GOVT_1=Qplanning.P_GOVT_1> 
<cfset form.P_GOVT_2=Qplanning.P_GOVT_2> 
<cfset form.P_GOVT_2D=Qplanning.P_GOVT_2D> 
<cfset form.P_GOVT_3=Qplanning.P_GOVT_3> 
<cfset form.P_GOVT_4=Qplanning.P_GOVT_4> 
<cfset form.P_GOVT_4D=Qplanning.P_GOVT_4D> 
<cfset form.P_GOVT_5=Qplanning.P_GOVT_5> 
<cfset form.P_PM_1=Qplanning.P_PM_1> 
<cfset form.P_PM_2=Qplanning.P_PM_2> 
<cfset form.P_PM_2D=Qplanning.P_PM_2D> 
<cfset form.P_PM_3=Qplanning.P_PM_3> 
<cfset form.P_PM_3D=Qplanning.P_PM_3D> 
<cfset form.P_PM_4=Qplanning.P_PM_4> 
<cfset form.P_PM_4D=Qplanning.P_PM_4D> 
<cfset form.P_PM_5=Qplanning.P_PM_5> 
<cfset form.P_PM_6=Qplanning.P_PM_6> 
<cfset form.P_PM_6a=Qplanning.P_PM_6a> 
<cfset form.P_PM_6d=Qplanning.P_PM_6d>
<cfset form.P_PM_6ad=Qplanning.P_PM_6ad> 
<cfset form.P_PM_7=Qplanning.P_PM_7> 
<cfset form.P_PM_8=Qplanning.P_PM_8> 
<cfset form.P_CF_1=Qplanning.P_CF_1> 
<cfset form.P_CF_2=Qplanning.P_CF_2> 
<cfset form.P_CF_2D=Qplanning.P_CF_2D> 
<cfset form.P_CF_3=Qplanning.P_CF_3> 
<cfset form.P_CF_4=Qplanning.P_CF_4> 
<cfset form.P_CF_5=Qplanning.P_CF_5> 
<cfset form.P_CF_6=Qplanning.P_CF_6> 

<cfset form.P_MON_1=Qplanning.P_MON_1> 
<cfset form.P_MON_2=Qplanning.P_MON_2> 
<cfset form.P_MON_2D=Qplanning.P_MON_2D> 
<cfset form.P_SURVEY_1=Qplanning.P_SURVEY_1> 
<cfset form.P_SURVEY_2=Qplanning.P_SURVEY_2> 
<cfset form.P_SURVEY_2D=Qplanning.P_SURVEY_2D> 
<cfset form.P_SURVEY_3=Qplanning.P_SURVEY_3> 
<cfset form.P_SURVEY_3D=Qplanning.P_SURVEY_3D> 
<cfset form.P_SURVEY_4=Qplanning.P_SURVEY_4> 
<cfset form.P_SURVEY_4D=Qplanning.P_SURVEY_4D> 
<cfset form.P_SURVEY_5=Qplanning.P_SURVEY_5> 
<cfset form.P_SURVEY_5D=Qplanning.P_SURVEY_5D> 
<cfset form.P_SURVEY_6=Qplanning.P_SURVEY_6> 
<cfset form.P_SURVEY_7=Qplanning.P_SURVEY_7>
<cfset form.P_SURVEY_8=Qplanning.P_SURVEY_8> 
<cfset form.P_SURVEY_9=Qplanning.P_SURVEY_9> 
<cfset form.P_SURVEY_10=Qplanning.P_SURVEY_10> 
<cfset form.P_PROV_QW_1=Qplanning.P_PROV_QW_1> 
<cfset form.P_PROV_QW_2=Qplanning.P_PROV_QW_2> 
<cfset form.P_PROV_QW_2D=Qplanning.P_PROV_QW_2D> 
<cfset form.P_PROV_QW_3=Qplanning.P_PROV_QW_3> 
<cfset form.P_PROV_QW_4=Qplanning.P_PROV_QW_4> 
<cfset form.P_PROV_QW_5=Qplanning.P_PROV_QW_5> 
<cfset form.P_PROV_QW_5D=Qplanning.P_PROV_QW_5D> 
<cfset form.P_PROV_QW_6=Qplanning.P_PROV_QW_6> 
<cfset form.P_PROV_QW_7=Qplanning.P_PROV_QW_7> 
<cfset form.P_PROV_PROV_1=Qplanning.P_PROV_PROV_1> 
<cfset form.P_PROV_PROV_1D=Qplanning.P_PROV_PROV_1D> 
<cfset form.P_PROV_PROV_2=Qplanning.P_PROV_PROV_2> 
<cfset form.P_PROV_PROV_3=Qplanning.P_PROV_PROV_3> 
<cfset form.P_PROV_PROV_4=Qplanning.P_PROV_PROV_4> 
<cfset form.P_PROV_PROM_1=Qplanning.P_PROV_PROM_1> 
<cfset form.P_PROV_PROM_2=Qplanning.P_PROV_PROM_2> 
<cfset form.P_PROV_PROM_2D=Qplanning.P_PROV_PROM_2D> 
<cfset form.P_PROV_PROM_3=Qplanning.P_PROV_PROM_3> 
<cfset form.P_PROV_PROM_4=Qplanning.P_PROV_PROM_4> 
<cfset form.P_CESS_1=Qplanning.P_CESS_1> 
<cfset form.P_CESS_2=Qplanning.P_CESS_2> 
<cfset form.P_CESS_2D=Qplanning.P_CESS_2D> 
<cfset form.P_CESS_3=Qplanning.P_CESS_3> 
<cfset form.P_CESS_3D=Qplanning.P_CESS_3D> 
<cfset form.P_CESS_4=Qplanning.P_CESS_4> 
<cfset form.P_CESS_4D=Qplanning.P_CESS_4D> 
<cfset form.P_CESS_5=Qplanning.P_CESS_5> 
<cfset form.P_COMM_1=Qplanning.P_COMM_1> 
<cfset form.P_COMM_2=Qplanning.P_COMM_2> 
<cfset form.P_COMM_2D=Qplanning.P_COMM_2D> 
<cfset form.P_COMM_3=Qplanning.P_COMM_3> 
<cfset form.P_COMM_3D=Qplanning.P_COMM_3D> 
<cfset form.P_COMM_4=Qplanning.P_COMM_4> 
<cfset form.P_COMM_4D=Qplanning.P_COMM_4D> 
<cfset form.P_COMM_5=Qplanning.P_COMM_5>

</cfif> 

<!---
<cfparam name="P_GOVT_1" default="">
<cfparam name="P_GOVT_2" default="">
<cfparam name="P_GOVT_2D" default="">
<cfparam name="P_GOVT_3" default="">
<cfparam name="P_GOVT_4" default="">
<cfparam name="P_GOVT_4D" default="">
<cfparam name="P_GOVT_5" default="">
<cfparam name="P_PM_1" default="">
<cfparam name="P_PM_2" default="">
<cfparam name="P_PM_2D" default="">
<cfparam name="P_PM_3" default="">
<cfparam name="P_PM_3D" default="">
<cfparam name="P_PM_4" default="">
<cfparam name="P_PM_4D" default="">
<cfparam name="P_PM_5" default="">
<cfparam name="P_PM_6" default="">
<cfparam name="P_PM_7" default="">
<cfparam name="P_CF_1" default="">
<cfparam name="P_CF_2" default="">
<cfparam name="P_CF_2D" default="">
<cfparam name="P_CF_3" default="">
<cfparam name="P_CF_4" default="">
<cfparam name="P_CF_5" default="">
<cfparam name="P_CF_6" default="">
<cfparam name="P_MON_1" default="">
<cfparam name="P_MON_2" default="">
<cfparam name="P_MON_2D" default="">
<cfparam name="P_SURVEY_1" default="">
<cfparam name="P_SURVEY_2" default="">
<cfparam name="P_SURVEY_2D" default="">
<cfparam name="P_SURVEY_3" default="">
<cfparam name="P_SURVEY_3D" default="">
<cfparam name="P_SURVEY_4" default="">
<cfparam name="P_SURVEY_4D" default="">
<cfparam name="P_SURVEY_5" default="">
<cfparam name="P_SURVEY_5D" default="">
<cfparam name="P_SURVEY_6" default="">
<cfparam name="P_SURVEY_7" default="">
<cfparam name="P_SURVEY_8" default="">
<cfparam name="P_SURVEY_9" default="">
<cfparam name="P_SURVEY_10" default="">
<cfparam name="P_PROV_QW_1" default="">
<cfparam name="P_PROV_QW_2" default="">
<cfparam name="P_PROV_QW_2D" default="">
<cfparam name="P_PROV_QW_3" default="">
<cfparam name="P_PROV_QW_4" default="">
<cfparam name="P_PROV_QW_5" default="">
<cfparam name="P_PROV_QW_5D" default="">
<cfparam name="P_PROV_QW_6" default="">
<cfparam name="P_PROV_QW_7" default="">
<cfparam name="P_PROV_PROV_1" default="">
<cfparam name="P_PROV_PROV_1D" default="">
<cfparam name="P_PROV_PROV_2" default="">
<cfparam name="P_PROV_PROV_3" default="">
<cfparam name="P_PROV_PROV_4" default="">
<cfparam name="P_PROV_PROM_1" default="">
<cfparam name="P_PROV_PROM_2" default="">
<cfparam name="P_PROV_PROM_2D" default="">
<cfparam name="P_PROV_PROM_3" default="">
<cfparam name="P_PROV_PROM_4" default="">
<cfparam name="P_CESS_1" default="">
<cfparam name="P_CESS_2" default="">
<cfparam name="P_CESS_2D" default="">
<cfparam name="P_CESS_3" default="">
<cfparam name="P_CESS_3D" default="">
<cfparam name="P_CESS_4" default="">
<cfparam name="P_CESS_4D" default="">
<cfparam name="P_CESS_5" default="">
<cfparam name="P_COMM_1" default="">
<cfparam name="P_COMM_2" default="">
<cfparam name="P_COMM_2D" default="">
<cfparam name="P_COMM_3" default="">
<cfparam name="P_COMM_3D" default="">
<cfparam name="P_COMM_4" default="">
<cfparam name="P_COMM_4D" default="">
<cfparam name="P_COMM_5" default="">
--->

<table class="box" >


<tr><th colspan="2">Strategy Planning Data</th></tr>
<cfswitch expression="#activityInfo.strategy#">
<cfcase value="1">
<!--- GOVT Policy --->
<tr>
	<td valign="top">Govt Policy-maker voting record, policy statements and campaign contributors were researched</td>
	<td valign="top">
		<input type="radio" name="P_GOVT_1" value="1"<cfif isDefined("form.P_GOVT_1") and form.P_GOVT_1 EQ "1"> checked</cfif>>Yes
		<input type="radio" name="P_GOVT_1" value="0"<cfif (isDefined("form.P_GOVT_1") and form.P_GOVT_1 EQ "0" or (form.P_GOVT_1 NEQ "1" and form.P_GOVT_1 NEQ "2")) OR NOT isDefined("form.P_GOVT_1")> checked</cfif>>No
		<input type="radio" name="P_GOVT_1" value="2"<cfif (isDefined("form.P_GOVT_1") and form.P_GOVT_1 EQ "2")> checked</cfif>>NA
	</td>
</tr>

<tr>
	<td valign="top">Plans to carry out the education campaign were finalized</td>
	<td valign="top">
		<input type="radio" name="P_GOVT_2" value="1"<cfif isDefined("form.P_GOVT_2") and form.P_GOVT_2 EQ "1"> checked</cfif>>Yes
		<input type="radio" name="P_GOVT_2" value="0"<cfif (isDefined("form.P_GOVT_2") and form.P_GOVT_2 EQ "0" or (form.P_GOVT_2 NEQ "1" and form.P_GOVT_2 NEQ "2")) OR NOT isDefined("form.P_GOVT_2")> checked</cfif>>No
		<input type="radio" name="P_GOVT_2" value="2"<cfif (isDefined("form.P_GOVT_2") and form.P_GOVT_2 EQ "2")> checked</cfif>>NA
		<br>Date (mm/dd/yyyy):
		<cfif isDefined("form.P_GOVT_2D") and form.p_govt_2d NEQ "1/1/1900">
					<cfinput name="P_GOVT_2D" type="text" value="#dateformat(form.P_GOVT_2D,'m/d/yyyy')#" validate="date" message="Please enter dates in the format 'mm/dd/yyyy'">	
				<cfelse>
					<cfinput name="P_GOVT_2D" type="text" validate="date" message="Please enter dates in the format 'mm/dd/yyyy'">	
				</cfif>
	</td>
</tr>
<tr>
	<td valign="top">Collaborating advocate organizations and individuals being recruited</td>
	<td valign="top">
		<input type="radio" name="P_GOVT_3" value="1"<cfif isDefined("form.P_GOVT_3") and form.P_GOVT_3 EQ "1"> checked</cfif>>Yes
		<input type="radio" name="P_GOVT_3" value="0"<cfif (isDefined("form.P_GOVT_3") and form.P_GOVT_3 EQ "0" or (form.P_GOVT_3 NEQ "1" and form.P_GOVT_3 NEQ "2")) OR NOT isDefined("form.P_GOVT_3")> checked</cfif>>No
		<input type="radio" name="P_GOVT_3" value="2"<cfif (isDefined("form.P_GOVT_3") and form.P_GOVT_3 EQ "2")> checked</cfif>>NA
	</td>
</tr>
<tr>
	<td valign="top">A timeline for the project was outlined</td>
	<td valign="top">
		<input type="radio" name="P_GOVT_4" value="1"<cfif isDefined("form.P_GOVT_4") and form.P_GOVT_4 EQ "1"> checked</cfif>>Yes
		<input type="radio" name="P_GOVT_4" value="0"<cfif (isDefined("form.P_GOVT_4") and form.P_GOVT_4 EQ "0" or (form.P_GOVT_4 NEQ "1" and form.P_GOVT_4 NEQ "2")) OR NOT isDefined("form.P_GOVT_4")> checked</cfif>>No
		<input type="radio" name="P_GOVT_4" value="2"<cfif (isDefined("form.P_GOVT_4") and form.P_GOVT_4 EQ "2")> checked</cfif>>NA
	    <br>Date (mm/dd/yyyy):<cfif isDefined("form.P_GOVT_4D") and form.p_govt_4d NEQ "1/1/1900">
					<cfinput name="P_GOVT_4D" type="text" value="#dateformat(form.P_GOVT_4D,'m/d/yyyy')#" validate="date" message="Please enter dates in the format 'mm/dd/yyyy'">	
				<cfelse>
					<cfinput name="P_GOVT_4D" type="text" validate="date" message="Please enter dates in the format 'mm/dd/yyyy'">	
				</cfif>
		

	</td>
</tr>
<tr>
	<td valign="top">Meetings with local government personnel being organized</td>
	<td valign="top">
		<input type="radio" name="P_GOVT_5" value="1"<cfif isDefined("form.P_GOVT_5") and form.P_GOVT_5 EQ "1"> checked</cfif>>Yes
		<input type="radio" name="P_GOVT_5" value="0"<cfif (isDefined("form.P_GOVT_5") and form.P_GOVT_5 EQ "0" or (form.P_GOVT_5 NEQ "1" and form.P_GOVT_5 NEQ "2")) OR NOT isDefined("form.P_GOVT_5")> checked</cfif>>No
		<input type="radio" name="P_GOVT_5" value="2"<cfif (isDefined("form.P_GOVT_5") and form.P_GOVT_5 EQ "2")> checked</cfif>>NA
	</td>
</tr>

</cfcase>
<!--- Paid Media --->
<cfcase value="2">
<tr>
	<td valign="top">Solicitation or RFP to contract with media firm being developed</td>
	<td valign="top">
		<input type="radio" name="P_PM_1" value="1"<cfif isDefined("form.P_PM_1") and form.P_PM_1 EQ "1"> checked</cfif>>Yes
		<input type="radio" name="P_PM_1" value="0"<cfif (isDefined("form.P_PM_1") and form.P_PM_1 EQ "0" or (form.P_PM_1 NEQ "1" and form.P_PM_1 NEQ "2"))OR NOT isDefined("form.P_PM_1") > checked</cfif>>No
				<input type="radio" name="P_PM_1" value="2"<cfif (isDefined("form.P_PM_1") and form.P_PM_1 EQ "2") > checked</cfif>>NA
	</td>
</tr>

<tr>
	<td valign="top">Solicitation or RFP to contract with media firm released</td>
	<td valign="top">
		<input type="radio" name="P_PM_2" value="1"<cfif isDefined("form.P_PM_2") and form.P_PM_2 EQ "1"> checked</cfif>>Yes
		<input type="radio" name="P_PM_2" value="0"<cfif (isDefined("form.P_PM_2") and form.P_PM_2 EQ "0" or (form.P_PM_2 NEQ "1" and form.P_PM_2 NEQ "2")) OR NOT isDefined("form.P_PM_2") > checked</cfif>>No
		<input type="radio" name="P_PM_2" value="2"<cfif (isDefined("form.P_PM_2") and form.P_PM_2 EQ "2")> checked</cfif>>NA
		<br>Date (mm/dd/yyyy):
		<cfif isDefined("form.P_PM_2d") and form.p_pm_2d NEQ "1/1/1900">
					<cfinput name="P_PM_2d" type="text" value="#dateformat(form.P_PM_2d,'m/d/yyyy')#" validate="date" message="Please enter dates in the format 'mm/dd/yyyy'">	
				<cfelse>
					<cfinput name="P_PM_2d" type="text" validate="date" message="Please enter dates in the format 'mm/dd/yyyy'">	
				</cfif>

	</td>
</tr>

<tr>
	<td valign="top">Media firm researched</td>
	<td valign="top">
		<input type="radio" name="P_PM_3" value="1"<cfif isDefined("form.P_PM_3") and form.P_PM_3 EQ "1"> checked</cfif>>Yes
		<input type="radio" name="P_PM_3" value="0"<cfif (isDefined("form.P_PM_3") and form.P_PM_3 EQ "0" or (form.P_PM_3 NEQ "1" and form.P_PM_3 NEQ "2")) OR NOT isDefined("form.P_PM_3")> checked</cfif>>No
				<input type="radio" name="P_PM_3" value="2"<cfif (isDefined("form.P_PM_3") and form.P_PM_3 EQ "2")> checked</cfif>>NA
		<br>Date (mm/dd/yyyy):
		<cfif isDefined("form.P_PM_3d") and form.p_pm_3d NEQ "1/1/1900">
					<cfinput name="P_PM_3d" type="text" value="#dateformat(form.P_PM_3d,'m/d/yyyy')#" validate="date" message="Please enter dates in the format 'mm/dd/yyyy'">	
				<cfelse>
					<cfinput name="P_PM_3d" type="text" validate="date" message="Please enter dates in the format 'mm/dd/yyyy'">	
				</cfif>
		
	</td>
</tr>

<tr>
	<td valign="top">Contract with media firm signed</td>
	<td valign="top">
		<input type="radio" name="P_PM_4" value="1"<cfif isDefined("form.P_PM_4") and form.P_PM_4 EQ "1"> checked</cfif>>Yes
		<input type="radio" name="P_PM_4" value="0"<cfif (isDefined("form.P_PM_4") and form.P_PM_4 EQ "0" or (form.P_PM_4 NEQ "1" and form.P_PM_4 NEQ "2")) OR NOT isDefined("form.P_PM_4")> checked</cfif>>No
				<input type="radio" name="P_PM_4" value="2"<cfif (isDefined("form.P_PM_4") and form.P_PM_4 EQ "2")> checked</cfif>>NA
		<br>Date (mm/dd/yyyy):
		<cfif isDefined("form.P_PM_4d") and form.p_pm_4d NEQ "1/1/1900">
					<cfinput name="P_PM_4d" type="text" value="#dateformat(form.P_PM_4d,'m/d/yyyy')#" validate="date" message="Please enter dates in the format 'mm/dd/yyyy'">	
				<cfelse>
					<cfinput name="P_PM_4d" type="text" validate="date" message="Please enter dates in the format 'mm/dd/yyyy'">	
				</cfif>
	
	</td>
</tr>

<tr>
	<td valign="top">Meetings with media firm held</td>
	<td valign="top">
		<input type="radio" name="P_PM_5" value="1"<cfif isDefined("form.P_PM_5") and form.P_PM_5 EQ "1"> checked</cfif>>Yes
		<input type="radio" name="P_PM_5" value="0"<cfif (isDefined("form.P_PM_5") and form.P_PM_5 EQ "0" or (form.P_PM_5 NEQ "1" and form.P_PM_5 NEQ "2")) OR NOT isDefined("form.P_PM_5")> checked</cfif>>No
		<input type="radio" name="P_PM_5" value="2"<cfif (isDefined("form.P_PM_5") and form.P_PM_5 EQ "2")> checked</cfif>>NA
	</td>
</tr>

<tr>
	<td valign="top">Media that will be used in paid media campaign developed</td>
	<td valign="top">
		<input type="radio" name="P_PM_6" value="1"<cfif isDefined("form.P_PM_6") and form.P_PM_6 EQ "1"> checked</cfif>>Yes
		<input type="radio" name="P_PM_6" value="0"<cfif (isDefined("form.P_PM_6") and form.P_PM_6 EQ "0" or (form.P_PM_6 NEQ "1" and form.P_PM_6 NEQ "2")) OR NOT isDefined("form.P_PM_6")> checked</cfif>>No
<!--- 		<input type="radio" name="P_PM_6" value="2"<cfif (isDefined("form.P_PM_6") and form.P_PM_6 EQ "2")> checked</cfif>>NA --->
	<br>Date:
		<cfif isDefined("form.P_PM_6d") and form.p_pm_6d NEQ "1/1/1900">
					<cfinput name="P_PM_6d" type="text" value="#dateformat(form.P_PM_6d,'m/d/yyyy')#" validate="date" message="Please enter dates in the format 'mm/dd/yyyy'">	
				<cfelse>
					<cfinput name="P_PM_6d" type="text" validate="date" message="Please enter dates in the format 'mm/dd/yyyy'">	
				</cfif>
	</td>
</tr>

<tr>
	<td valign="top">Media that will be used in paid media campaign approved by Area Manager</td>
	<td valign="top">
		<input type="radio" name="P_PM_6a" value="1"<cfif isDefined("form.P_PM_6a") and form.P_PM_6a EQ "1"> checked</cfif>>Yes
		<input type="radio" name="P_PM_6a" value="0"<cfif (isDefined("form.P_PM_6a") and form.P_PM_6a EQ "0" or (form.P_PM_6a NEQ "1" and form.P_PM_6a NEQ "2")) OR NOT isDefined("form.P_PM_6a")> checked</cfif>>No
<!--- 		<input type="radio" name="P_PM_6a" value="2"<cfif (isDefined("form.P_PM_6a") and form.P_PM_6a EQ "2")> checked</cfif>>NA --->
	<br>Date (mm/dd/yyyy):
		<cfif isDefined("form.P_PM_6ad") and form.p_pm_6ad NEQ "1/1/1900">
					<cfinput name="P_PM_6ad" type="text" value="#dateformat(form.P_PM_6ad,'m/d/yyyy')#" validate="date" message="Please enter dates in the format 'mm/dd/yyyy'">	
				<cfelse>
					<cfinput name="P_PM_6ad" type="text" validate="date" message="Please enter dates in the format 'mm/dd/yyyy'">	
				</cfif>
	</td>
</tr>

<tr>
	<td valign="top">Meetings held with other Community Partners to plan media campaign</td>
	<td valign="top">
		<input type="radio" name="P_PM_7" value="1"<cfif isDefined("form.P_PM_7") and form.P_PM_7 EQ "1"> checked</cfif>>Yes
		<input type="radio" name="P_PM_7" value="0"<cfif (isDefined("form.P_PM_7") and form.P_PM_7 EQ "0" or (form.P_PM_7 NEQ "1" and form.P_PM_7 NEQ "2")) OR NOT isDefined("form.P_PM_7")> checked</cfif>>No
		<input type="radio" name="P_PM_7" value="2"<cfif (isDefined("form.P_PM_7") and form.P_PM_7 EQ "2")> checked</cfif>>NA		
	</td>
</tr>

<tr>
	<td valign="top">Meeting held with media outlet to plan media buy</td>
	<td valign="top">
		<input type="radio" name="P_PM_8" value="1"<cfif isDefined("form.P_PM_8") and form.P_PM_8 EQ "1"> checked</cfif>>Yes
		<input type="radio" name="P_PM_8" value="0"<cfif (isDefined("form.P_PM_8") and form.P_PM_8 EQ "0" or (form.P_PM_8 NEQ "1" and form.P_PM_8 NEQ "2")) OR NOT isDefined("form.P_PM_8")> checked</cfif>>No
		<input type="radio" name="P_PM_8" value="2"<cfif (isDefined("form.P_PM_8") and form.P_PM_8 EQ "2")> checked</cfif>>NA		
	</td>
</tr>

</cfcase>
<!--- Community Forum  --->
<cfcase value="4">
<tr>
	<td valign="top">Formal plan for event or outreach in development</td>
	<td valign="top">
		<input type="radio" name="P_CF_1" value="1"<cfif isDefined("form.P_CF_1") and form.P_CF_1 EQ "1"> checked</cfif>>Yes
		<input type="radio" name="P_CF_1" value="0"<cfif (isDefined("form.P_CF_1") and form.P_CF_1 EQ "0" or (form.P_CF_1 NEQ "1" and form.P_CF_1 NEQ "2")) OR NOT isDefined("form.P_CF_1")> checked</cfif>>No
		<input type="radio" name="P_CF_1" value="2"<cfif (isDefined("form.P_CF_1") and form.P_CF_1 EQ "2")> checked</cfif>>NA
	</td>
</tr>
<tr>
	<td valign="top">Formal plan for event or outreach completed</td>
	<td valign="top">
		<input type="radio" name="P_CF_2" value="1"<cfif isDefined("form.P_CF_2") and form.P_CF_2 EQ "1"> checked</cfif>>Yes
		<input type="radio" name="P_CF_2" value="0"<cfif (isDefined("form.P_CF_2") and form.P_CF_2 EQ "0" or (form.P_CF_2 NEQ "1" and form.P_CF_2 NEQ "2")) OR NOT isDefined("form.P_CF_2")> checked</cfif>>No
		<input type="radio" name="P_CF_2" value="2"<cfif (isDefined("form.P_CF_2") and form.P_CF_2 EQ "2")> checked</cfif>>NA
		<br>Date (mm/dd/yyyy):
		<cfif isDefined("form.P_CF_2d") and form.p_cf_2d NEQ "1/1/1900">
					<cfinput name="P_CF_2d" type="text" value="#dateformat(form.P_CF_2d,'m/d/yyyy')#" validate="date" message="Please enter dates in the format 'mm/dd/yyyy'">	
				<cfelse>
					<cfinput name="P_CF_2d" type="text" validate="date" message="Please enter dates in the format 'mm/dd/yyyy'">	
				</cfif>

	</td>
</tr>
<tr>
	<td valign="top">Location logistics (location; food; technical needs) in progress</td>
	<td valign="top">
		<input type="radio" name="P_CF_3" value="1"<cfif isDefined("form.P_CF_3") and form.P_CF_3 EQ "1"> checked</cfif>>Yes
		<input type="radio" name="P_CF_3" value="0"<cfif (isDefined("form.P_CF_3") and form.P_CF_3 EQ "0" or (form.P_CF_3 NEQ "1" and form.P_CF_3 NEQ "2")) OR NOT isDefined("form.P_CF_3")> checked</cfif>>No
		<input type="radio" name="P_CF_3" value="2"<cfif (isDefined("form.P_CF_3") and form.P_CF_3 EQ "2")> checked</cfif>>NA		
	</td>
</tr>
<tr>
	<td valign="top">Press conference organizing tasks in progress</td>
	<td valign="top">
		<input type="radio" name="P_CF_4" value="1"<cfif isDefined("form.P_CF_4") and form.P_CF_4 EQ "1"> checked</cfif>>Yes
		<input type="radio" name="P_CF_4" value="0"<cfif (isDefined("form.P_CF_4") and form.P_CF_4 EQ "0" or (form.P_CF_4 NEQ "1" and form.P_CF_4 NEQ "2")) OR NOT isDefined("form.P_CF_4")> checked</cfif>>No
		<input type="radio" name="P_CF_4" value="2"<cfif (isDefined("form.P_CF_4") and form.P_CF_4 EQ "2")> checked</cfif>>NA
	</td>
</tr>
<tr>
	<td valign="top">Target audience outreach/recruiting in progress</td>
	<td valign="top">
		<input type="radio" name="P_CF_5" value="1"<cfif isDefined("form.P_CF_5") and form.P_CF_5 EQ "1"> checked</cfif>>Yes
		<input type="radio" name="P_CF_5" value="0"<cfif (isDefined("form.P_CF_5") and form.P_CF_5 EQ "0" or (form.P_CF_5 NEQ "1" and form.P_CF_5 NEQ "2")) OR NOT isDefined("form.P_CF_5")> checked</cfif>>No
		<input type="radio" name="P_CF_5" value="2"<cfif (isDefined("form.P_CF_5") and form.P_CF_5 EQ "2")> checked</cfif>>NA		
	</td>
</tr>
<tr>
	<td valign="top">Event speakers/workshop leaders being recruited</td>
	<td valign="top">
		<input type="radio" name="P_CF_6" value="1"<cfif isDefined("form.P_CF_6") and form.P_CF_6 EQ "1"> checked</cfif>>Yes
		<input type="radio" name="P_CF_6" value="0"<cfif (isDefined("form.P_CF_6") and form.P_CF_6 EQ "0" or (form.P_CF_6 NEQ "1" and form.P_CF_6 NEQ "2")) OR NOT isDefined("form.P_CF_6")> checked</cfif>>No
		<input type="radio" name="P_CF_6" value="2"<cfif isDefined("form.P_CF_6") and form.P_CF_6 EQ "2"> checked</cfif>>NA	
	</td>
</tr>

</cfcase>
<!--- Monitoring/Assesment --->
<cfcase value="5">
<tr>
	<td valign="top">Assessment method and targets being researched</td>
	<td valign="top">
		<input type="radio" name="P_MON_1" value="1"<cfif isDefined("form.P_MON_1") and form.P_MON_1 EQ "1"> checked</cfif>>Yes
		<input type="radio" name="P_MON_1" value="0"<cfif (isDefined("form.P_MON_1") and form.P_MON_1 EQ "0" or (form.P_MON_1 NEQ "1" and form.P_MON_1 NEQ "2")) OR NOT isDefined("form.P_MON_1")> checked</cfif>>No
		<input type="radio" name="P_MON_1" value="2"<cfif isDefined("form.P_MON_1") and form.P_MON_1 EQ "2"> checked</cfif>>NA
	</td>
</tr>
<tr>
	<td valign="top">Assessment plan finalized</td>
	<td valign="top">
		<input type="radio" name="P_MON_2" value="1"<cfif isDefined("form.P_MON_2") and form.P_MON_2 EQ "1"> checked</cfif>>Yes
		<input type="radio" name="P_MON_2" value="0"<cfif (isDefined("form.P_MON_2") and form.P_MON_2 EQ "0" or (form.P_MON_2 NEQ "1" and form.P_MON_2 NEQ "2")) OR NOT isDefined("form.P_MON_2")> checked</cfif>>No
		<input type="radio" name="P_MON_2" value="2"<cfif isDefined("form.P_MON_2") and form.P_MON_2 EQ "2"> checked</cfif>>NA
		<br>Date (mm/dd/yyyy):
		<cfif isDefined("form.P_MON_2d") and form.p_mon_2d NEQ "1/1/1900">
					<cfinput name="P_MON_2d" type="text" value="#dateformat(form.P_MON_2d,'m/d/yyyy')#" validate="date" message="Please enter dates in the format 'mm/dd/yyyy'">	
				<cfelse>
					<cfinput name="P_MON_2d" type="text" validate="date" message="Please enter dates in the format 'mm/dd/yyyy'">	
				</cfif>
	</td>
</tr>

</cfcase>
<!--- Survey of Public --->
<cfcase value="6">
<tr>
	<td valign="top">Survey Instrument in Development</td>
	<td valign="top">
		<input type="radio" name="P_SURVEY_1" value="1"<cfif isDefined("form.P_SURVEY_1") and form.P_SURVEY_1 EQ "1"> checked</cfif>>Yes
		<input type="radio" name="P_SURVEY_1" value="0"<cfif (isDefined("form.P_SURVEY_1") and form.P_SURVEY_1 EQ "0" or (form.P_SURVEY_1 NEQ "1" and form.P_SURVEY_1 NEQ "2")) OR NOT isDefined("form.P_SURVEY_1")> checked</cfif>>No
		<input type="radio" name="P_SURVEY_1" value="2"<cfif (isDefined("form.P_SURVEY_1") and form.P_SURVEY_1 EQ "2") > checked</cfif>>NA
	</td>
</tr>
<tr>
	<td valign="top">Survey instrument finalized</td>
	<td valign="top">
		<input type="radio" name="P_SURVEY_2" value="1"<cfif isDefined("form.P_SURVEY_2") and form.P_SURVEY_2 EQ "1"> checked</cfif>>Yes
		<input type="radio" name="P_SURVEY_2" value="0"<cfif (isDefined("form.P_SURVEY_2") and form.P_SURVEY_2 EQ "0" or (form.P_SURVEY_2 NEQ "1" and form.P_SURVEY_2 NEQ "2")) OR NOT isDefined("form.P_SURVEY_2")> checked</cfif>>No
		<input type="radio" name="P_SURVEY_2" value="2"<cfif isDefined("form.P_SURVEY_2") and form.P_SURVEY_2 EQ "2"> checked</cfif>>NA
		<br>Date (mm/dd/yyyy):
		<cfif isDefined("form.P_SURVEY_2d") and form.p_survey_2d NEQ "1/1/1900">
					<cfinput name="P_SURVEY_2d" type="text" value="#dateformat(form.P_SURVEY_2d,'m/d/yyyy')#" validate="date" message="Please enter dates in the format 'mm/dd/yyyy'">	
				<cfelse>
					<cfinput name="P_SURVEY_2d" type="text" validate="date" message="Please enter dates in the format 'mm/dd/yyyy'">	
				</cfif>

			</td>
</tr>
<tr>
	<td valign="top">Survey instrument submitted to IRB</td>
	<td valign="top">
		<input type="radio" name="P_SURVEY_3" value="1"<cfif isDefined("form.P_SURVEY_3") and form.P_SURVEY_3 EQ "1"> checked</cfif>>Yes
		<input type="radio" name="P_SURVEY_3" value="0"<cfif (isDefined("form.P_SURVEY_3") and form.P_SURVEY_3 EQ "0" or (form.P_SURVEY_3 NEQ "1" and form.P_SURVEY_3 NEQ "2")) OR NOT isDefined("form.P_SURVEY_3")> checked</cfif>>No
		<input type="radio" name="P_SURVEY_3" value="2"<cfif isDefined("form.P_SURVEY_3") and form.P_SURVEY_3 EQ "2"> checked</cfif>>NA
		<br>Date (mm/dd/yyyy):
		<cfif isDefined("form.P_SURVEY_3d") and form.p_survey_3d NEQ "1/1/1900">
					<cfinput name="P_SURVEY_3d" type="text" value="#dateformat(form.P_SURVEY_3d,'m/d/yyyy')#" validate="date" message="Please enter dates in the format 'mm/dd/yyyy'">	
				<cfelse>
					<cfinput name="P_SURVEY_3d" type="text" validate="date" message="Please enter dates in the format 'mm/dd/yyyy'">	
				</cfif>

			</td>
</tr>
<tr>
	<td valign="top">Survey Piloted</td>
	<td valign="top">
		<input type="radio" name="P_SURVEY_4" value="1"<cfif isDefined("form.P_SURVEY_4") and form.P_SURVEY_4 EQ "1"> checked</cfif>>Yes
		<input type="radio" name="P_SURVEY_4" value="0"<cfif (isDefined("form.P_SURVEY_4") and form.P_SURVEY_4 EQ "0" or (form.P_SURVEY_4 NEQ "1" and form.P_SURVEY_4 NEQ "2")) OR NOT isDefined("form.P_SURVEY_4")> checked</cfif>>No
		<input type="radio" name="P_SURVEY_4" value="2"<cfif (isDefined("form.P_SURVEY_4") and form.P_SURVEY_4 EQ "2")> checked</cfif>>NA		
		<br>Date (mm/dd/yyyy):
		<cfif isDefined("form.P_SURVEY_4d") and form.p_survey_4d NEQ "1/1/1900">
					<cfinput name="P_SURVEY_4d" type="text" value="#dateformat(form.P_SURVEY_4d,'m/d/yyyy')#" validate="date" message="Please enter dates in the format 'mm/dd/yyyy'">	
				<cfelse>
					<cfinput name="P_SURVEY_4d" type="text" validate="date" message="Please enter dates in the format 'mm/dd/yyyy'">	
				</cfif>

			</td>
</tr>
<tr>
	<td valign="top">Survey revision finalized</td>
	<td valign="top">
		<input type="radio" name="P_SURVEY_5" value="1"<cfif isDefined("form.P_SURVEY_5") and form.P_SURVEY_5 EQ "1"> checked</cfif>>Yes
		<input type="radio" name="P_SURVEY_5" value="0"<cfif (isDefined("form.P_SURVEY_5") and form.P_SURVEY_5 EQ "0" or (form.P_SURVEY_5 NEQ "1" and form.P_SURVEY_5 NEQ "2")) OR NOT isDefined("form.P_SURVEY_5")> checked</cfif>>No
		<input type="radio" name="P_SURVEY_5" value="2"<cfif (isDefined("form.P_SURVEY_5") and form.P_SURVEY_5 EQ "2")> checked</cfif>>NA
		<br>Date (mm/dd/yyyy):
		<cfif isDefined("form.P_SURVEY_5d") and form.p_survey_5d NEQ "1/1/1900">
					<cfinput name="P_SURVEY_5d" type="text" value="#dateformat(form.P_SURVEY_5d,'m/d/yyyy')#" validate="date" message="Please enter dates in the format 'mm/dd/yyyy'">	
				<cfelse>
					<cfinput name="P_SURVEY_5d" type="text" validate="date" message="Please enter dates in the format 'mm/dd/yyyy'">	
				</cfif>
		

	</td>
</tr>
<tr>
	<td valign="top">Survey firms being researched</td>
	<td valign="top">
		<input type="radio" name="P_SURVEY_6" value="1"<cfif isDefined("form.P_SURVEY_6") and form.P_SURVEY_6 EQ "1"> checked</cfif>>Yes
		<input type="radio" name="P_SURVEY_6" value="0"<cfif (isDefined("form.P_SURVEY_6") and form.P_SURVEY_6 EQ "0" or (form.P_SURVEY_6 NEQ "1" and form.P_SURVEY_6 NEQ "2")) OR NOT isDefined("form.P_SURVEY_6")> checked</cfif>>No
		<input type="radio" name="P_SURVEY_6" value="2"<cfif (isDefined("form.P_SURVEY_6") and form.P_SURVEY_6 EQ "2")> checked</cfif>>NA
	</td>
</tr>
<tr>
	<td valign="top">Survey firm contracted</td>
	<td valign="top">
		<input type="radio" name="P_SURVEY_7" value="1"<cfif isDefined("form.P_SURVEY_7") and form.P_SURVEY_7 EQ "1"> checked</cfif>>Yes
		<input type="radio" name="P_SURVEY_7" value="0"<cfif (isDefined("form.P_SURVEY_7") and form.P_SURVEY_7 EQ "0" or (form.P_SURVEY_7 NEQ "1" and form.P_SURVEY_7 NEQ "2")) OR NOT isDefined("form.P_SURVEY_7")> checked</cfif>>No
		<input type="radio" name="P_SURVEY_7" value="2"<cfif (isDefined("form.P_SURVEY_7") and form.P_SURVEY_7 EQ "2")> checked</cfif>>NA
	</td>
</tr>
<tr>
	<td valign="top">Analysis plan being developed</td>
	<td valign="top">
		<input type="radio" name="P_SURVEY_8" value="1"<cfif isDefined("form.P_SURVEY_8") and form.P_SURVEY_9 EQ "1"> checked</cfif>>Yes
		<input type="radio" name="P_SURVEY_8" value="0"<cfif (isDefined("form.P_SURVEY_8") and form.P_SURVEY_9 EQ "0" or (form.P_SURVEY_9 NEQ "1" and form.P_SURVEY_9 NEQ "2")) OR NOT isDefined("form.P_SURVEY_9")> checked</cfif>>No
		<input type="radio" name="P_SURVEY_8" value="2"<cfif (isDefined("form.P_SURVEY_8") and form.P_SURVEY_9 EQ "2")> checked</cfif>>NA
	</td>
</tr>
<tr>
	<td valign="top">Protocol review form (with draft survey) submitted</td>
	<td valign="top">
		<input type="radio" name="P_SURVEY_9" value="1"<cfif isDefined("form.P_SURVEY_9") and form.P_SURVEY_9 EQ "1"> checked</cfif>>Yes
		<input type="radio" name="P_SURVEY_9" value="0"<cfif (isDefined("form.P_SURVEY_9") and form.P_SURVEY_9 EQ "0" or (form.P_SURVEY_9 NEQ "1" and form.P_SURVEY_9 NEQ "2")) OR NOT isDefined("form.P_SURVEY_9")> checked</cfif>>No
		<input type="radio" name="P_SURVEY_9" value="2"<cfif (isDefined("form.P_SURVEY_9") and form.P_SURVEY_9 EQ "2")> checked</cfif>>NA
	</td>
</tr>
<tr>
	<td valign="top">Protocol review form revised- using feedback from TCP regional evaluation specialists - and resubmitted</td>
	<td valign="top">
		<input type="radio" name="P_SURVEY_10" value="1"<cfif isDefined("form.P_SURVEY_10") and form.P_SURVEY_10 EQ "1"> checked</cfif>>Yes
		<input type="radio" name="P_SURVEY_10" value="0"<cfif (isDefined("form.P_SURVEY_10") and form.P_SURVEY_10 EQ "0" or (form.P_SURVEY_10 NEQ "1" and form.P_SURVEY_10 NEQ "2")) OR NOT isDefined("form.P_SURVEY_10")> checked</cfif>>No
		<input type="radio" name="P_SURVEY_10" value="2"<cfif (isDefined("form.P_SURVEY_10") and form.P_SURVEY_10 EQ "2")> checked</cfif>>NA
	</td>
</tr>


</cfcase>
<cfcase value="7">
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

</cfif>
</cfcase>
<!--- Cessation Centers --->
<cfcase value="8">
<tr>
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
</tr>

</cfcase>
<!--- Community and Youth Partners --->
<cfcase value="9">
<tr>
	<td valign="top">Advocacy plan in development</td>
	<td valign="top">
		<input type="radio" name="P_COMM_1" value="1"<cfif isDefined("form.P_COMM_1") and form.P_COMM_1 EQ "1"> checked</cfif>>Yes
		<input type="radio" name="P_COMM_1" value="0"<cfif (isDefined("form.P_COMM_1") and form.P_COMM_1 EQ "0" or (form.P_COMM_1 NEQ "1" and form.P_COMM_1 NEQ "2")) OR NOT isDefined("form.P_COMM_1")> checked</cfif>>No
		<input type="radio" name="P_COMM_1" value="2"<cfif (isDefined("form.P_COMM_1") and form.P_COMM_1 EQ "2")> checked</cfif>>NA
	</td>
</tr>
<tr>
	<td valign="top">Advocacy plan finalized</td>
	<td valign="top">
		<input type="radio" name="P_COMM_2" value="1"<cfif isDefined("form.P_COMM_2") and form.P_COMM_2 EQ "1"> checked</cfif>>Yes
		<input type="radio" name="P_COMM_2" value="0"<cfif (isDefined("form.P_COMM_2") and form.P_COMM_2 EQ "0" or (form.P_COMM_2 NEQ "1" and form.P_COMM_2 NEQ "2")) OR NOT isDefined("form.P_COMM_2")> checked</cfif>>No
		<input type="radio" name="P_COMM_2" value="2"<cfif (isDefined("form.P_COMM_2") and form.P_COMM_2 EQ "2")> checked</cfif>>NA
		Date (mm/dd/yyyy):
		<cfif isDefined("form.P_COMM_2d") and form.p_comm_2d NEQ "1/1/1900">
					<cfinput name="P_COMM_2d" type="text" value="#dateformat(form.P_COMM_2d,'m/d/yyyy')#" validate="date" message="Please enter dates in the format 'mm/dd/yyyy'">	
				<cfelse>
					<cfinput name="P_COMM_2d" type="text" validate="date" message="Please enter dates in the format 'mm/dd/yyyy'">	
				</cfif>

	</td>
</tr>
<tr>
	<td valign="top">RFP for minigrant developed</td>
	<td valign="top">
		<input type="radio" name="P_COMM_3" value="1"<cfif isDefined("form.P_COMM_3") and form.P_COMM_3 EQ "1"> checked</cfif>>Yes
		<input type="radio" name="P_COMM_3" value="0"<cfif (isDefined("form.P_COMM_3") and form.P_COMM_3 EQ "0" or (form.P_COMM_3 NEQ "1" and form.P_COMM_3 NEQ "2")) OR NOT isDefined("form.P_COMM_3")> checked</cfif>>No
		<input type="radio" name="P_COMM_3" value="2"<cfif (isDefined("form.P_COMM_3") and form.P_COMM_3 EQ "2")> checked</cfif>>NA
		Date (mm/dd/yyyy):
		<cfif isDefined("form.P_COMM_3d") and form.p_comm_3d NEQ "1/1/1900">
					<cfinput name="P_COMM_3d" type="text" value="#dateformat(form.P_COMM_3d,'m/d/yyyy')#" validate="date" message="Please enter dates in the format 'mm/dd/yyyy'">	
				<cfelse>
					<cfinput name="P_COMM_3d" type="text" validate="date" message="Please enter dates in the format 'mm/dd/yyyy'">	
				</cfif>

	</td>
</tr>
<tr>
	<td valign="top">RFP for minigrant released</td>
	<td valign="top">
		<input type="radio" name="P_COMM_4" value="1"<cfif isDefined("form.P_COMM_4") and form.P_COMM_4 EQ "1"> checked</cfif>>Yes
		<input type="radio" name="P_COMM_4" value="0"<cfif (isDefined("form.P_COMM_4") and form.P_COMM_4 EQ "0" or (form.P_COMM_4 NEQ "1" and form.P_COMM_4 NEQ "2")) OR NOT isDefined("form.P_COMM_4")> checked</cfif>>No
		<input type="radio" name="P_COMM_4" value="2"<cfif (isDefined("form.P_COMM_4") and form.P_COMM_4 EQ "2")> checked</cfif>>NA
		Date (mm/dd/yyyy):
		<cfif isDefined("form.P_COMM_4d") and form.p_comm_4d NEQ "1/1/1900">
					<cfinput name="P_COMM_4d" type="text" value="#dateformat(form.P_COMM_4d,'m/d/yyyy')#" validate="date" message="Please enter dates in the format 'mm/dd/yyyy'">	
				<cfelse>
					<cfinput name="P_COMM_4d" type="text" validate="date" message="Please enter dates in the format 'mm/dd/yyyy'">	
				</cfif>

	</td>
</tr>
<tr>
	<td valign="top">Mini-grant proposals reviewed</td>
	<td valign="top">
		<input type="radio" name="P_COMM_5" value="1"<cfif isDefined("form.P_COMM_5") and form.P_COMM_5 EQ "1"> checked</cfif>>Yes
		<input type="radio" name="P_COMM_5" value="0"<cfif (isDefined("form.P_COMM_5") and form.P_COMM_5 EQ "0" or (form.P_COMM_5 NEQ "1" and form.P_COMM_5 NEQ "2")) OR NOT isDefined("form.P_COMM_5")> checked</cfif>>No
		<input type="radio" name="P_COMM_5" value="2"<cfif (isDefined("form.P_COMM_5") and form.P_COMM_5 EQ "2")> checked</cfif>>NA
	</td>
</tr>
</cfcase>
</cfswitch>
</table>
</cfif>