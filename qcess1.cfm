
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
<title>CAT</title>

<cfinclude template="catstruct.cfm">
<table class="box" width="100%"><tr><td>
<script language="JavaScript">
function disableme(){
for(var intloop=0; intloop <document.QCess.length; intloop++){
		if(document.Qcess[intloop].type=='textarea'){
	document.Qcess[intloop].readOnly = true;
	}
	else
document.QCess[intloop].disabled=true;
}
}

function add(actvalue){
document.QCess.dofunction.value=actvalue;
return true;
}

function validate_one(direction){
if(document.QCess.BCIQR_1.selectedIndex==0){
alert("Please select a collaborator");
return false;
}
if(document.QCess.BCIQR_2.value==""){
alert("Please enter a valid number for of patients screened");
return false;
}
if(document.QCess.BCIQR_2a.value==""){
alert("Please enter a valid number of patients in sample");
return false;
}
if(document.QCess.BCIQR_4.value==""){
alert("Please enter a valid number of patients identified as tobacco users");
return false;
}
<cfif session.fy LT 2008>
if(document.QCess.BCIQR_4a.value==""){
alert("Please enter a valid number of patients identified as tobacco users");
return false;
}
</cfif>
if(document.QCess.BCIQR_6.value==""){
alert("Please enter a valid number of users receiving brief inteventions");
return false;
}
if(document.QCess.BCIQR_8.selectedIndex==0){
alert("Please select a method of obtaining tobacco user information");
return false;
}
if (validateRanges()==false){
return false;
}
add(direction);
}

function validate_two(direction){
<cfif session.fy LTE 2008>
if(document.QCess.quitline_referrals.value==""){
alert("Please enter a valid number for FAX-to_Quit referrals");
return false;
}
</cfif>
add(direction);
}

function validate_four(direction){
if(document.QCess.six_mos_contact.value==""){
alert("Please enter a valid number for number of individuals contacted for 6 month follow-up");
return false;
}
if(document.QCess.seven_d_abst_six.value==""){
alert("Please enter a valid number for number reporting 7 day abstinence rate at 6 month follow-up");
return false;
}
if(document.QCess.twelve_mos_contact.value==""){
alert("Please enter a valid number for number of individuals contacted for 12 month follow-up");
return false;
}
if(document.QCess.seven_d_abst_twelve.value==""){
alert("Please enter a valid number for number reporting 7 day abstinence rate at 12 month follow-up");
return false;
}

if(Number(document.QCess.six_mos_contact.value)>Number(document.QCess.calc_1.value)){
alert("The number of individuals contacted this quarter may not exceed the number that reached the 6 month follow-up");
return false;
}
if(Number(document.QCess.seven_d_abst_six.value)>Number(document.QCess.six_mos_contact.value)){
alert("The number of individuals reporting 7 day abstinence this quarter may not exceed the number that were contacted");
return false;
}
if(Number(document.QCess.twelve_mos_contact.value)>Number(document.QCess.calc_3.value)){
alert("The number of individuals contacted this quarter may not exceed the number that reached the 12 month follow-up");
return false;
}
if(Number(document.QCess.seven_d_abst_twelve.value)>Number(document.QCess.twelve_mos_contact.value)){
alert("The number of individuals reporting 7 day abstinence this quarter may not exceed the number that were contacted");
return false;
}
add(direction);
}

function validate_five(direction){
if(document.QCess.annual_collab.selectedIndex==0){
alert("Please select a collaborator");
return false;
}
if(document.QCess.patient_pop.value==""){
alert("Please enter a valid number for total patient population");
return false;
}
if(document.QCess.annual_type.selectedIndex==0){
alert("Please select a type of data used");
return false;
}
add(direction);
}
<cfif session.fy LT 2008>
function calc_screened_val(){
if ((document.QCess.BCIQR_2.value!="")&&(document.QCess.BCIQR_2.value!="")){
document.QCess.BCIQR_3.value=100*document.QCess.BCIQR_2.value/document.QCess.BCIQR_2a.value;
}
else document.QCess.BCIQR_3.value="NA";
}

function calc_users_val(){
if ((document.QCess.BCIQR_4.value!="NA")&&(document.QCess.BCIQR_2.value!="")){
document.QCess.BCIQR_5.value=100*document.QCess.BCIQR_4.value/document.QCess.BCIQR_2.value;
}
else document.QCess.BCIQR_5.value="NA";
}

function calc_interv_val(){
if ((document.QCess.BCIQR_6.value!="")&&(document.QCess.BCIQR_4a.value!="")){
document.QCess.BCIQR_7.value=100*document.QCess.BCIQR_6.value/document.QCess.BCIQR_4a.value;
}
else document.QCess.BCIQR_7.value="NA";
}
</cfif>

function validateRanges(){
if (parseInt(document.QCess.BCIQR_2.value) > parseInt(document.QCess.BCIQR_2a.value)){
alert("The number of patients screened for tobacco use (Ask) cannot be larger than the number of patients in the sample.");
return false;
}
if (parseInt(document.QCess.BCIQR_4.value) > parseInt(document.QCess.BCIQR_2a.value)){
alert("The number of patients identified as tobacco users cannot be larger than the number of patients in the sample.");
return false;
}
if (parseInt(document.QCess.BCIQR_9.value) > parseInt(document.QCess.BCIQR_4.value)){
alert("The number of of tobacco users who receive brief advice to quit (Advise) cannot be larger than the number of patients identified as tobacco users.");
return false;
}
if (parseInt(document.QCess.BCIQR_6.value) > parseInt(document.QCess.BCIQR_4.value)){
alert("The number of tobacco users receiving brief interventions (Assess, Assist, Arrange) cannot be larger than the number of patients identified as tobacco users.");
return false;
}
return true;
}
</script>
<cfif isDefined("url.q")>
	<cfset form.Q=url.q>
</cfif>



<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qext">
	select userid from quarterly_extensions
	where userid = '#session.userid#'	
</cfquery>




<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qcalc_1">
	select sum(enrolled) as calc_one
	from ICIQ
	where userid='#session.userid#'
	and
	<cfif form.q EQ "1">
	year2=(#evaluate(session.fy-1)#)
	and q=3
	<cfelseif form.q EQ "2">
	year2=(#evaluate(session.fy-1)#)
	and q=4
	<cfelseif form.q EQ "3">
	year2=#session.fy#
	and q=1
	<cfelseif form.q EQ "4">
	year2=#session.fy#
	and q=2
	</cfif>	
</cfquery>



<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qcalc_2">
	select sum(enrolled) as calc_three
	from ICIQ
	where userid='#session.userid#'
	and
	<cfif form.q EQ "1">
	year2=(#session.fy#-1)
	and q=1
	<cfelseif form.q EQ "2">
	year2=(#session.fy#-1)
	and q=2
	<cfelseif form.q EQ "3">
	year2=(#session.fy#-1)
	and q=3
	<cfelseif form.q EQ "4">
	year2=(#session.fy#-1)
	and q=4
	</cfif>	
</cfquery>









<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QCatchmentCount">
	
	select catchment 
	from contact
	where userid='#session.userid#'
</cfquery>

<cfset NumCounties = ListLen(QCatchmentCount.catchment)>
<cfset NumCols=NumCounties + 4>


<cfif CGI.http_referer DOES NOT CONTAIN "QCess1.cfm">
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QselICIQ">
	select *
	from ICIQ
	where userid='#session.userid#'
	and year2='#session.fy#'
	and q='#form.q#'
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QselICIQ2">
	select *
	from ICIQ2
	where userid='#session.userid#'
	and year2='#session.fy#'
	and q='#form.q#'
</cfquery>

<cfif QselICIQ2.recordcount GT 0>
<cfoutput>
<cfset form.six_mos_contact="#QselICIQ2.six_mos_contact#">
<cfset form.seven_d_abst_six="#QselICIQ2.seven_d_abst_six#">
<cfset form.twelve_mos_contact="#QselICIQ2.twelve_mos_contact#">
<cfset form.seven_d_abst_twelve="#QselICIQ2.seven_d_abst_twelve#">
</cfoutput>


</cfif>



<cfif QselICIQ.recordcount GT 0>
<cfoutput>
<cfset form.enrolled="#QselICIQ.enrolled#">
<cfset form.dist_p="#QselICIQ.dist_p#">
<cfset form.dist_g="#QselICIQ.dist_g#">
<cfset form.dist_lo="#QselICIQ.dist_lo#">
<cfset form.dist_in="#QselICIQ.dist_in#">
<cfset form.dist_n="#QselICIQ.dist_n#">
<cfset form.dist_z="#QselICIQ.dist_z#">
<cfset form.dist_p2="#QselICIQ.dist_p2#">
<cfset form.dist_g2="#QselICIQ.dist_g2#">
<cfset form.dist_lo2="#QselICIQ.dist_lo2#">
<cfset form.dist_in2="#QselICIQ.dist_in2#">
<cfset form.dist_n2="#QselICIQ.dist_n2#">
<cfset form.dist_z2="#QselICIQ.dist_z2#">
<cfset form.no_intense="#QselICIQ.no_intense#">
<cfset form.dist_c="#QselICIQ.dist_c#">
<cfset form.dist_c2="#QselICIQ.dist_c2#">


</cfoutput>

</cfif>

</cfif>
 
<cfif isDefined("form.dofunction")>

<cfif form.dofunction EQ "addBCIQR">
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QinsBCIQR">
	insert into BCIQR
	(userid, q, year2, collab_id, num_screened, screen_sample, num_id, id_sample, num_interv,  method, num_advise)
	values
	('#session.userid#','#form.Q#','#session.fy#','#form.BCIQR_1#',
	<cfif form.BCIQR_2 NEQ "">'#form.BCIQR_2#'<cfelse>NULL</cfif>,
	<cfif form.BCIQR_2a NEQ "">'#form.BCIQR_2a#'<cfelse>NULL</cfif>,
	<cfif form.BCIQR_4 NEQ "">'#form.BCIQR_4#'<cfelse>NULL</cfif>,
	<cfif session.fy LT 2008 and isDefined("form.BCIQR_4a") and  form.BCIQR_4a NEQ "" >'#form.BCIQR_4a#'<cfelse>NULL</cfif>, 
	<cfif form.BCIQR_6 NEQ "">'#form.BCIQR_6#'<cfelse>NULL</cfif>,
	'#form.BCIQR_8#',
	 <cfif isDefined("form.BCIQR_9") and  form.BCIQR_9 NEQ "">'#form.BCIQR_9#'<cfelse>NULL</cfif>)
</cfquery>


<cfelseif form.dofunction EQ "delBCIQR" AND isDefined("form.delBCIQR")>
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QdelBCIQR">
	delete from BCIQR
	where userid='#session.userid#'
	and seq in (#form.delBCIQR#)
</cfquery>

<cfelseif form.dofunction EQ "addQuitline">
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QaddQuitline_1">
	insert into Quitline_master
	(userid, month2, year2 <CFIF SESSION.FY lte 2008>, FTQ, REFERR_CNT</CFIF>) 
	values
	('#session.userid#', '#form.quitline_month#', '#session.fy#'<CFIF SESSION.FY lte 2008>, '#form.quitline_referrals#' , '#form.referr_cnt#'</CFIF>)
	</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QaddQuitline_2">
	select max(seq) as seq
	from Quitline_master
	where userid='#session.userid#'
	and month2='#form.quitline_month#'
	and year2='#session.fy#'
</cfquery>

<cfif session.fy LTE 2008>
<CFLOOP LIST="#form.FieldNames#" INDEX="FormField">
    <cfif formfield contains "CntyCall_">
		<cfquery datasource="#application.DataSource#"  		
		 
		password="#application.db_password#"   		
		username="#application.db_username#" name="QaddQuitline_3">
		insert into Quitline_county
		(userid, month2, year2, master_key, county, num_calls)
		values
		('#session.userid#', '#form.quitline_month#', '#session.fy#', '#QaddQuitline_2.seq#', '#right(formfield, 5)#', 
		
			<cfif evaluate("form."&formfield) NEQ "">'#evaluate("form."&formfield)#'<cfelse>NULL</cfif>  )
		</cfquery>
	</cfif>
</CFLOOP>
<cfelse>

<CFLOOP LIST="#form.FieldNames#" INDEX="FormField">
	
    <cfif formfield contains "F2Q_">
	
		<cfquery datasource="#application.DataSource#"  		
		 
		password="#application.db_password#"   		
		username="#application.db_username#" name="QaddQuitline_3">
		insert into Quitline_county
		(userid, month2, year2, master_key, county, f2q	)
		values
		('#session.userid#', '#form.quitline_month#', '#session.fy#', '#QaddQuitline_2.seq#', '#right(formfield, 5)#', 
					<cfif evaluate("form."&formfield) NEQ "">'#evaluate("form."&formfield)#'<cfelse>NULL</cfif>	 )
		</cfquery>
	</cfif>
</CFLOOP>

<CFLOOP LIST="#form.FieldNames#" INDEX="FormField">
    <cfif formfield contains "refer_">
		<cfquery datasource="#application.DataSource#"  		
		 
		password="#application.db_password#"   		
		username="#application.db_username#" name="QaddQuitline_3">
		update Quitline_county
		set refer=<cfif evaluate("form."&formfield) NEQ "">'#evaluate("form."&formfield)#'<cfelse>NULL</cfif>
		where 
		master_key='#QaddQuitline_2.seq#'
		and county='#right(formfield, 5)#'
		and userid='#session.userid#'
		and month2='#form.quitline_month#'
		and year2='#session.fy#'
		
		</cfquery>
	</cfif>
</CFLOOP>
</cfif>

<cfelseif form.dofunction EQ "delQuitline">
		<cfif isDefined("form.delQuitline")>
		<cfquery datasource="#application.DataSource#"  		
		 
		password="#application.db_password#"   		
		username="#application.db_username#" name="QdelQuitline">
		delete
		from
		Quitline_master
		where  userid='#session.userid#'
		and seq in (#form.delQuitline#)
		</cfquery>
		</cfif>
		
<cfelseif form.dofunction EQ "saveQ">
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QcheckQ">
	select userid 
	from ICIQ
	where userid='#session.userid#'
	and Q=#form.Q#
	and year2='#session.fy#'
</cfquery>

<cfif QcheckQ.recordcount EQ 0>
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QinsICIQ">
	Insert into ICIQ
	(userid, q, year2, enrolled, 
	dist_p, dist_g, dist_lo, dist_in, dist_n, dist_z 
<cfif session.fy GT 2006>,dist_p2, dist_g2, dist_lo2, dist_in2, dist_n2, dist_z2, dist_c, dist_c2</cfif>
	<!--- , compl_1, compl_2, compl_3, compl_4, compl_5, cum_6, cum_12 --->, no_intense)
	values
	('#session.userid#', '#form.q#', '#session.fy#', <cfif isDefined("form.enrolled")>'#form.enrolled#'<cfelse>Null</cfif>,
	<cfif isDefined("form.dist_p")> '#form.dist_p#'<cfelse>NULL</cfif>,
	<cfif isDefined("form.dist_g")> '#form.dist_g#'<cfelse>NULL</cfif>,
	<cfif isDefined("form.dist_lo")> '#form.dist_lo#'<cfelse>NULL</cfif>,
	<cfif isDefined("form.dist_In")> '#form.dist_In#'<cfelse>NULL</cfif>,
	<cfif isDefined("form.dist_n")> '#form.dist_n#'<cfelse>NULL</cfif>,
	<cfif isDefined("form.dist_z")> '#form.dist_z#'<cfelse>NULL</cfif>
	<cfif session.fy GT 2006>,
	<cfif isDefined("form.dist_p2")>'#form.dist_p2#'<cfelse>NULL</cfif>,
	<cfif isDefined("form.dist_g2")>'#form.dist_g2#'<cfelse>NULL</cfif>,
	<cfif isDefined("form.dist_lo2")>'#form.dist_lo2#'<cfelse>NULL</cfif>,
	<cfif isDefined("form.dist_In2")>'#form.dist_In2#'<cfelse>NULL</cfif>,
	<cfif isDefined("form.dist_n2")>'#form.dist_n2#'<cfelse>NULL</cfif>,
	<cfif isDefined("form.dist_z2")>'#form.dist_z2#'<cfelse>NULL</cfif>,
	<cfif isDefined("form.dist_c")>'#form.dist_c#'<cfelse>NULL</cfif>,
	<cfif isDefined("form.dist_c2")>'#form.dist_c2#'<cfelse>NULL</cfif>
	</cfif>
	<!--- ,'#form.compl_1#','#form.compl_2#','#form.compl_3#','#form.compl_4#','#form.compl_5#','#form.cum_6#','#form.cum_12#' --->
	<cfif isDefined("form.no_intense")>, #form.no_intense#<cfelse>,0</cfif>)
</cfquery>
<cfelse>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QupdICIQ">
	update ICIQ
	set
	<cfif isDefined("form.enrolled")>enrolled='#form.enrolled#', </cfif>
	<cfif isDefined("form.dist_p")>dist_p='#form.dist_p#', </cfif>
	<cfif isDefined("form.dist_g")>dist_g='#form.dist_g#', </cfif>
	<cfif isDefined("form.dist_lo")>dist_lo='#form.dist_lo#', </cfif>
	<cfif isDefined("form.dist_In")>dist_in='#form.dist_In#', </cfif>
	<cfif isDefined("form.dist_n")>dist_n='#form.dist_n#', </cfif>
	<cfif isDefined("form.dist_z")>dist_z='#form.dist_z#',</cfif>
	<cfif isDefined("form.dist_p2")>dist_p2='#form.dist_p2#', </cfif>
	<cfif isDefined("form.dist_g2")>dist_g2='#form.dist_g2#', </cfif>
	<cfif isDefined("form.dist_lo2")>dist_lo2='#form.dist_lo2#', </cfif>
	<cfif isDefined("form.dist_In2")>dist_in2='#form.dist_In2#', </cfif>
	<cfif isDefined("form.dist_n2")>dist_n2='#form.dist_n2#', </cfif>
	<cfif isDefined("form.dist_z2")>dist_z2='#form.dist_z2#',</cfif>
	
	<cfif isDefined("form.dist_c")>dist_c='#form.dist_c#', </cfif>
	<cfif isDefined("form.dist_c2")>dist_c2='#form.dist_c2#',</cfif>
	<!--- , 
	compl_1='#form.compl_1#', 
	compl_2='#form.compl_2#', 
	compl_3='#form.compl_3#', 
	compl_4='#form.compl_4#', 
	compl_5='#form.compl_5#', 
	cum_6='#form.cum_6#', 
	cum_12='#form.cum_12#' --->
	no_intense=<cfif isDefined("form.no_intense")>#form.no_intense#<cfelse>null</cfif>,
	userid='#session.userid#'
	where userid='#session.userid#'
	and Q='#form.Q#'
	and year2='#session.fy#'
</cfquery>
</cfif>



<cfelseif form.dofunction EQ "saveQ2">
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QcheckQ2">
	select userid 
	from ICIQ2
	where userid='#session.userid#'
	and Q=#form.Q#
	and year2='#session.fy#'
</cfquery>

<cfif QcheckQ2.recordcount EQ 0>
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QinsICIQ2">
	Insert into ICIQ2
	(userid, q, year2, 	six_mos_contact, seven_d_abst_six, twelve_mos_contact, seven_d_abst_twelve)
	values
	('#session.userid#', '#form.q#', 
	'#session.fy#', 
	<cfif isDefined("form.six_mos_contact")>'#form.six_mos_contact#'<cfelse>null</cfif>, 
	<cfif isDefined("form.seven_d_abst_six")>'#form.seven_d_abst_six#'<cfelse>null</cfif>,
	<cfif isDefined("form.twelve_mos_contact")>'#form.twelve_mos_contact#'<cfelse>null</cfif>,
	<cfif isDefined("form.seven_d_abst_twelve")>'#form.seven_d_abst_twelve#'<cfelse>null</cfif>)
</cfquery>
<cfelse>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QupdICIQ2">
	update ICIQ2
	set
	<cfif isDefined("form.six_mos_contact")>six_mos_contact='#form.six_mos_contact#', </cfif>
	<cfif isDefined("form.seven_d_abst_six")>seven_d_abst_six='#form.seven_d_abst_six#', </cfif>
	<cfif isDefined("form.twelve_mos_contact")>twelve_mos_contact='#form.twelve_mos_contact#', </cfif>
	<cfif isDefined("form.seven_d_abst_twelve")>seven_d_abst_twelve='#form.seven_d_abst_twelve#',</cfif>
	userid='#session.userid#'
	where userid='#session.userid#'
	and Q='#form.Q#'
	and year2='#session.fy#'
</cfquery>
</cfif>

<cfelseif form.dofunction EQ "addAnnual">
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QaddAnnual">
	insert into AROD
	(userid, year2, collab_id, patient_pop, type)
	values
	('#session.userid#', #session.fy#, '#form.annual_collab#', '#form.patient_pop#', '#form.annual_type#')
	
</cfquery>
<cfelseif form.dofunction EQ "delAnnual">
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QdelAnnual">
	delete from AROD
	where userid='#session.userid#'
	and seq in (#form.delAnnual#)	
</cfquery>
</cfif>

</cfif>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qcollaborators">
	select name, seq ,
	case 
	 when unit IS NULL then NAME
	 else unit + ' ' + NAME
	end as unitname 
	from collaborators 
	where  userid = '#session.userid#'	
	and (del is null or del !=1)
	and tlevel=1
	order by 3
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QBCIQR_method">
	select id, descr
	from lu_q_cess_method
	where year2=#session.fy#
	order by rank
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QBCIQR">
select collab_id, num_screened, screen_sample, num_id, num_advise, id_sample, num_interv, isNull(method, 9999) as method2, seq
from BCIQR
where q='#form.q#'
and year2=#session.fy#
and userid='#session.userid#'	
order by seq
</cfquery>

<cfform name="QCess">
<input type="Hidden" name="dofunction" value="">
<cfoutput><input type="Hidden" name="q" value="#form.q#"></cfoutput>

<!--- <cfoutput>

<cfif IsDefined("form.fieldnames")>
     <cfloop list="#form.fieldnames#" index="f">
          <cfif NOT IsDefined("PreserveExclude")
               OR ListFindNoCase(PreserveExclude, f) IS 0>
               <cfset FEval = "ListLast(form." & f & ")">
               <input name="#f#" type="Hidden" value="#Evaluate(FEval)#">
          </cfif>
     </cfloop>
</cfif>

</cfoutput>
 --->

<table width="80%" border=".2" align="center" class="box">
<tr>
	<th colspan="9">Brief Cessation Interventions Quarterly Report (Quarter<cfoutput>#form.Q#</cfoutput>)</th>
</tr>
<tr>
	<th>Target HCPO</th>
	<th># of patients in sample</th>
	<th width="8%"># patients screened for tobacco use (Ask)</th>
	
<cfif session.fy LT 2008>
	<th width="8%">% patients screened for tobacco use</th>
</cfif>
	<th width="8%"># patients identified as tobacco users</th>
	
<cfif session.fy LT 2008>
	<th width="8%">% patients identified as tobacco users</th>
<cfelse>
	<th width="8%"># of tobacco users who receive brief advice to quit (Advise)</th>
</cfif>
	<th width="8%"># of tobacco users receiving brief interventions (<cfif session.fy LT 2008>Advise, </cfif>Assess, Assist, Arrange)</th>
	<!--- <th># of tobacco users in sample</th> --->
<cfif session.fy LT 2008>
	<th># of tobacco users in sample</th>
	<th width="8%">% of tobacco users receiving brief interventions (Advise, Assess, Assist, Arrange)</th>
</cfif>
<th>Method of obtaining tobacco user information</th>
	<th>&nbsp;</th>
</tr>
<tr>
	<td>
	<select name="BCIQR_1">
	<option value="" selected>
	<cfoutput>
	<cfloop query="Qcollaborators">
	<option value="#seq#">#unitname#
	</cfloop>
	</cfoutput>
	</select> 
	</td>
	<cfif session.fy LT 2008>
	<td align="center"><cfinput name="BCIQR_2a" type="Text" size="4" validate="integer" message="Please enter a valid number for sample size"></td>
	<td align="center"><cfinput name="BCIQR_2" type="Text" size="4" validate="integer" message="Please enter a valid number for number of patients screened" ></td>
	<cfelse>
	<td align="center"><cfinput name="BCIQR_2a" type="Text" size="4" validate="integer" message="Please enter a valid number for sample size" onChange="calc_screened_val();"></td>
	<td align="center"><cfinput name="BCIQR_2" type="Text" size="4" validate="integer" message="Please enter a valid number for number of patients screened" onChange="calc_screened_val();"></td>
	</cfif>
<cfif session.fy LT 2008>
	<td align="center"><input name="BCIQR_3" type="Text" size="4" disabled></td>
</cfif>

<cfif session.fy LT 2008>
	<td align="center"><cfinput name="BCIQR_4" type="Text" size="4" validate="integer" message="Please enter a valid number for number of patients identified as tobacco users"></td>
<cfelse>
	<td align="center"><cfinput name="BCIQR_4" type="Text" size="4" validate="integer" message="Please enter a valid number for number of patients identified as tobacco users" onChange="calc_users_val();"></td>
</cfif>
<cfif session.fy LT 2008>
	<td align="center"><input name="BCIQR_5" type="Text" size="4" disabled></td>
<cfelse>
	<td align="center"><input name="BCIQR_9" type="Text" size="4"  validate="integer" message="Please enter a valid number for number of users who receive brief advice to quite (Advise)" ></td>
</cfif>

<cfif session.fy LT 2008>
	<td align="center"><cfinput name="BCIQR_6" type="Text" size="4" validate="integer" message="Please enter a valid number for number of users receiving brief interventions" ></td>
 	<td align="center"><cfinput name="BCIQR_4a" type="Text" size="4" validate="integer" message="Please enter a valid number for sample size" ></td> 
<cfelse>
	<td align="center"><cfinput name="BCIQR_6" type="Text" size="4" validate="integer" message="Please enter a valid number for number of users receiving brief interventions" onChange="calc_interv_val();"></td>
<!---  	<td align="center"><cfinput name="BCIQR_4a" type="Text" size="4" validate="integer" message="Please enter a valid number for sample size" onChange="calc_users_val();calc_interv_val();"></td> --->
 </cfif>
<cfif session.fy LT 2008>
	<td align="center"><input name="BCIQR_7" type="Text" size="4" disabled></td>
</cfif>
	<td>
	<select name="BCIQR_8">
	<option value="" selected>
	<cfoutput>
	<cfloop query="QBCIQR_method">
	<option value="#id#">#descr#
	</cfloop>
	</cfoutput>
	</select> 
	</td>
</tr><tr>
	<td align="left"><input type="submit" value="Add" onclick="return validate_one('addBCIQR');" class="AddButton"></td>
	
</tr>
<cfif QBCIQR.recordcount GT 0>
<cfoutput>
<cfloop query="QBCIQR">
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QCollab_name">
select name,
case 
	 when unit IS NULL then NAME
	 else unit + ' ' + NAME
	end as unitname 
	from collaborators 
	where seq = '#QBCIQR.collab_id#'
	order by 2
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qmethod_name">
select  descr
	from lu_q_cess_method
	where id in (#QBCIQR.method2#)
	and year2=#session.fy#
	order by rank
</cfquery>
<tr bgcolor="Silver">
	<td>#QCollab_name.unitname#</td>
	<td>#QBCIQR.screen_sample#</td>
	<td>#QBCIQR.num_screened#</td>
<cfif session.fy LT 2008>
	<td><cfif QBCIQR.screen_sample NEQ "0">#numberformat(evaluate(100*QBCIQR.num_screened/QBCIQR.screen_sample),"9.99")#%<cfelse>N/A</cfif></td>
</cfif>
	<td>#QBCIQR.num_id#</td>
	
<cfif session.fy LT 2008>
	<td><cfif QBCIQR.num_screened NEQ "0">#numberformat(evaluate(100*QBCIQR.num_id/QBCIQR.num_screened),"9.99")#%<cfelse>N/A</cfif></td>
<cfelse>
	<td>#QBCIQR.num_advise#</td>
</cfif>
	<td>#QBCIQR.num_interv#</td>
<cfif session.fy LT 2008>
	<td>#QBCIQR.id_sample#</td>

	<td><cfif QBCIQR.id_sample NEQ "0">#numberformat(evaluate(100*QBCIQR.num_interv/QBCIQR.id_sample),"9.99")#%<cfelse>N/A</cfif></td>
</cfif>
	<td>#valueList(Qmethod_name.descr, '<br>')#*</td>
	<td>Delete<input name="delBCIQR" type="checkbox" value="#QBCIQR.seq#"></td>
</tr>
</cfloop>
</cfoutput>
<tr>
	<td colspan="11" align="left"><input type="submit" value="Delete" onclick="return add('delBCIQR');" class="DelButton"></td>
</tr>
</cfif>
</table>

<br><br><hr><br><br>







<cfoutput>
<cfif session.fy LTE 2008>
<table width="80%" border=".2" align="center" class="box">
<tr>
	<th colspan="#NumCols#">NYS Quitline Data</th>
</tr>
<tr>
	<th rowspan="2" >Month</th>
	<th rowspan="2" >FAX-to-Quit referrals generated from Cessation Center catchment area</th>
	<th rowspan="2" >## Health care provider Quitline referrals</th>
	
	<th colspan="#NumCounties#">## of calls to the NYS Quitline<br>(per county in catchment area)</th>
	<td>&nbsp;</td>
</tr>
<tr>
	<cfloop list="#QCatchmentCount.catchment#" index="cntyID">
	<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QCountyName">	
	select countyName
	from counties
	where fips='#cntyID#'
	</cfquery>
	<td>#QCountyName.countyName#</td>
	</cfloop>
	<td>&nbsp;</td>
</tr>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QMonths">	
	select mon, mon_num
	from months
	where quarter='#form.q#' and year2 = #session.fy#
	order by rank
	</cfquery>

<tr>
	<td><cfselect name="quitline_month" query="QMonths" display="mon" value="mon"></cfselect></td>
	<td><cfinput name="quitline_referrals" type="text" validate="integer" message="Please enter a valid number of referrals"></td>
	<td><cfinput name="referr_cnt" type="text" validate="integer" message="Please enter a valid number of referrals"></td>
	<cfloop list="#QCatchmentCount.catchment#" index="cntyID">
	<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QCountyName2">	
	select FIPS
	from counties
	where fips='#cntyID#'
	</cfquery>
	<td><cfinput type="Text" name="CntyCall_#QCountyName2.FIPS#" validate="integer" message="Please enter a valid number of calls"></td>
	</cfloop>
	<td>&nbsp;</td></tr><tr>
	<td colspan="#evaluate(NumCounties + 5)#" align="left"><input type="submit" value="Add" onclick="return validate_two('addQuitline');" class="AddButton"></td>

</tr>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QdispQuitline">
	select month2, FTQ, q.seq, referr_cnt     
	
	from Quitline_master as q, months as m
	where userid='#session.userid#'
	and q.year2='#session.fy#'
	and m.mon=q.month2
	and m.year2 = q.year2
	order by m.rank
</cfquery>
<cfif QdispQuitline.recordcount GT 0>
<CFLOOP query="QdispQuitline">
    <tr bgcolor="Silver">
		<td>#QdispQuitline.month2#</td>
		<td>#QdispQuitline.FTQ#</td>
		<td>#QdispQuitline.referr_cnt#</td>
		<cfquery datasource="#application.DataSource#"  		
		 
		password="#application.db_password#"   		
		username="#application.db_username#" name="QdispQuitline_2">
		select distinct
		county, num_calls
		from Quitline_county
		where userid='#session.userid#'
		and year2='#session.fy#'
		and master_key='#QdispQuitline.seq#'
		order by 1
		</cfquery>
		
		<cfloop list="#QCatchmentCount.catchment#" index="cntyID">
		<cfloop query="QdispQuitline_2">
			<cfif QdispQuitline_2.county EQ cntyID>
				<td>#QdispQuitline_2.num_calls#</td>				
			</cfif>		
		</cfloop>		
		</cfloop>
		<td>Delete<input type="Checkbox" name="delQuitline" value="#QdispQuitline.seq#"</td>
		
	</tr>
</CFLOOP>
<tr>
	<td colspan="#NumCols#" align="left"><input type="submit" value="Delete" onclick="return add('delQuitline');" class="DelButton"></td>
</tr>
</cfif>
<tr>

</tr>
</table>
<cfelse><!--- FY GT 2008 --->

<table width="80%" border=".2" align="center" class="box">
<tr>
	<th colspan="#NumCols#">NYS Quitline Data</th>
</tr>
<tr>
	<th rowspan="2" >Month</th>
	<th rowspan="2"  colspan="2">&nbsp;</th>
	
	<th colspan="#NumCounties#">Counties</th>
	<td>&nbsp;</td>
</tr>
<tr>
	<cfloop list="#QCatchmentCount.catchment#" index="cntyID">
	<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QCountyName">	
	select countyName
	from counties
	where fips='#cntyID#'
	</cfquery>
	<td>#QCountyName.countyName#</td>
	</cfloop>
	<td>&nbsp;</td>
</tr>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QMonths">	
	select mon, mon_num
	from months
	where quarter='#form.q#' and year2 = #session.fy#
	order by rank
	</cfquery>

<tr>
	<td rowspan="2"><cfselect name="quitline_month" query="QMonths" display="mon" value="mon"></cfselect></td>
	<td colspan="2">Fax-to-Quit referrals generated from Cessation Center catchment area</td>
	<cfloop list="#QCatchmentCount.catchment#" index="cntyID">
	<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QCountyName2">	
	select FIPS
	from counties
	where fips='#cntyID#'
	</cfquery>
	<td><cfinput type="Text" name="F2Q_#QCountyName2.FIPS#" validate="integer" message="Please enter a valid number of calls"></td>
	</cfloop>
	<td>&nbsp;</td></tr>

<tr>
		<td colspan="2">## Health care provider Quitline referrals</td>
	<cfloop list="#QCatchmentCount.catchment#" index="cntyID">
	<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QCountyName2">	
	select FIPS
	from counties
	where fips='#cntyID#'
	</cfquery>
	<td><cfinput type="Text" name="Refer_#QCountyName2.FIPS#" validate="integer" message="Please enter a valid number of calls"></td>
	</cfloop>
	<td>&nbsp;</td></tr><tr>
	<td colspan="#evaluate(NumCounties + 5)#" align="left"><input type="submit" value="Add" onclick="return validate_two('addQuitline');" class="AddButton"></td>

</tr>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QdispQuitline">
	select month2, FTQ, q.seq, referr_cnt     
	
	from Quitline_master as q, months as m
	where userid='#session.userid#'
	and year2='#session.fy#'
	and m.mon=q.month2
	and m.year2 = q.year2
	order by m.rank
</cfquery>
<cfif QdispQuitline.recordcount GT 0>
<CFLOOP query="QdispQuitline">
    <tr bgcolor="Silver">
		<td>#QdispQuitline.month2#</td>
		<td colspan="2" nowrap="yes">Fax-to-Quit Referrals<br>HCP Quitline Referals</td>
		<cfquery datasource="#application.DataSource#"  		
		 
		password="#application.db_password#"   		
		username="#application.db_username#" name="QdispQuitline_2">
		select distinct
		county, f2q, refer
		from Quitline_county
		where userid='#session.userid#'
		and year2='#session.fy#'
		and master_key='#QdispQuitline.seq#'
		order by 1
		</cfquery>
		
		<cfloop list="#QCatchmentCount.catchment#" index="cntyID">
		<cfloop query="QdispQuitline_2">
			<cfif QdispQuitline_2.county EQ cntyID>
				<td>#QdispQuitline_2.f2q#<br>#QdispQuitline_2.refer#</td>				
			</cfif>		
		</cfloop>		
		</cfloop>
		<td>Delete<input type="Checkbox" name="delQuitline" value="#QdispQuitline.seq#"</td>
		
	</tr>
</CFLOOP>
<tr>
	<td colspan="#NumCols#" align="left"><input type="submit" value="Delete" onclick="return add('delQuitline');" class="DelButton"></td>
</tr>
</cfif>
<tr>

</tr>
</table>
</cfif>






</cfoutput>
<br><br><hr><br><br>

<table width="80%" border=".2" align="center" class="box">
<tr>
	<th colspan="9">Intensive Cessation Interventions Quarterly Report-Delivery of Services (Quarter <cfoutput>#form.q#</cfoutput>)</th>
</tr>
<tr>
	<td colspan="9">
	<input type="checkbox" name="no_intense" value="1"  <cfif isDefined("form.no_intense") and form.no_intense EQ 1>checked</cfif>  onClick="submit();">
	We did not conduct any intensive interventions this quarter.
	</td>
</tr>

<cfif NOT isDefined("form.no_intense") OR (isDefined("form.no_intense") and form.no_intense NEQ 1)>
<tr>
	<td rowspan="3">&nbsp;</td>
	<th colspan="7">Units of Specific Types of Pharmacotherapy Distributed</th>
	<td rowspan="3"># of individuals completing treatment (i.e. group or individual counseling) paid for by NYS TCP this quarter</td>
</tr>
<tr>
	<th colspan="6">Unit=one-week supply</th>
	<th rowspan="1">Unit=30 day supply</th>
</tr>
<tr>
	
	<td align="center">Patch</td>
	<td align="center">Gum</td>
	<td align="center">Lozenge</td>
	<td align="center">Inhaler</td>
	<td align="center" nowrap>Nasal Spray</td>
	<td align="center">Bupropion/Zyban/Wellbutrin</td>
	<td align="center">Chantix</td>
</tr>
<tr>
	<td>Provided by Cessation Ctr to Individuals</td>

	<td align="center">
		<cfif isDefined("form.dist_p")>
			<cfinput name="dist_p" type="Text" size="4" value="#form.dist_p#" validate="float" message="Please enter numeric values only">
		<cfelse>
			<cfinput name="dist_p" type="Text" size="4" validate="float" message="Please enter numeric values only">
		</cfif>
	</td>
	
	
	
	<td align="center">
		<cfif isDefined("form.dist_g")>
			<cfinput name="dist_g" type="Text" size="4" value="#form.dist_g#" validate="float" message="Please enter numeric values only">	
		<cfelse>
			<cfinput name="dist_g" type="Text" size="4" validate="float" message="Please enter numeric values only">	
		</cfif>
	</td>
	
	
	<td align="center">
		<cfif isDefined("form.dist_Lo")>
			<cfinput name="dist_Lo" type="Text" size="4" value="#form.dist_Lo#" validate="float" message="Please enter numeric values only">
		<cfelse>
			<cfinput name="dist_Lo" type="Text" size="4" validate="float" message="Please enter numeric values only">
		</cfif>
	</td>
	
	
	<td align="center">
		<cfif isDefined("form.dist_In")>
			<cfinput name="dist_In" type="Text" size="4" value="#form.dist_In#" validate="float" message="Please enter numeric values only">
		<cfelse>
			<cfinput name="dist_In" type="Text" size="4" validate="float" message="Please enter numeric values only">
		</cfif>
	</td>
	
	
	<td align="center">
		<cfif isDefined("form.dist_n")>
			<cfinput name="dist_n" type="Text" size="4" value="#form.dist_n#" validate="float" message="Please enter numeric values only">
		<cfelse>
			<cfinput name="dist_n" type="Text" size="4" validate="float" message="Please enter numeric values only">
		</cfif>
	</td>
	
	
	<td align="center">
		<cfif isDefined("form.dist_z")>
			<cfinput name="dist_z" type="Text" size="4" value="#form.dist_z#" validate="float" message="Please enter numeric values only">
		<cfelse>
			<cfinput name="dist_z" type="Text" size="4" validate="float" message="Please enter numeric values only">
		</cfif>
	</td>
	<td align="center">
		<cfif isDefined("form.dist_c")>
			<cfinput name="dist_c" type="Text" size="4" value="#form.dist_c#" validate="float" message="Please enter numeric values only">
		<cfelse>
			<cfinput name="dist_c" type="Text" size="4" validate="float" message="Please enter numeric values only">
		</cfif>
	</td>
	
	
	<td align="center">
		<cfif isDefined("form.enrolled")>
			<cfinput name="enrolled" type="Text" size="4" value="#form.enrolled#" validate="float" message="Please enter numeric values only">
		<cfelse>
			<cfinput name="enrolled" type="Text" size="4" validate="float" message="Please enter numeric values only">
		</cfif>
	</td>
	
	
</tr>

<cfif session.fy GT 2006>
<tr>
	<td>Provided by Cessation Ctr to Organizations</td>

	<td align="center">
		<cfif isDefined("form.dist_p2")>
			<cfinput name="dist_p2" type="Text" size="4" value="#form.dist_p2#" validate="float" message="Please enter numeric values only">
		<cfelse>
			<cfinput name="dist_p2" type="Text" size="4" validate="float" message="Please enter numeric values only">
		</cfif>
	</td>
	
	
	
	<td align="center">
		<cfif isDefined("form.dist_g2")>
			<cfinput name="dist_g2" type="Text" size="4" value="#form.dist_g2#" validate="float" message="Please enter numeric values only">	
		<cfelse>
			<cfinput name="dist_g2" type="Text" size="4" validate="float" message="Please enter numeric values only">	
		</cfif>
	</td>
	
	
	<td align="center">
		<cfif isDefined("form.dist_Lo2")>
			<cfinput name="dist_Lo2" type="Text" size="4" value="#form.dist_Lo2#" validate="float" message="Please enter numeric values only">
		<cfelse>
			<cfinput name="dist_Lo2" type="Text" size="4" validate="float" message="Please enter numeric values only">
		</cfif>
	</td>
	
	
	<td align="center">
		<cfif isDefined("form.dist_In2")>
			<cfinput name="dist_In2" type="Text" size="4" value="#form.dist_In2#" validate="float" message="Please enter numeric values only">
		<cfelse>
			<cfinput name="dist_In2" type="Text" size="4" validate="float" message="Please enter numeric values only">
		</cfif>
	</td>
	
	
	<td align="center">
		<cfif isDefined("form.dist_n2")>
			<cfinput name="dist_n2" type="Text" size="4" value="#form.dist_n2#" validate="float" message="Please enter numeric values only">
		<cfelse>
			<cfinput name="dist_n2" type="Text" size="4" validate="float" message="Please enter numeric values only">
		</cfif>
	</td>
	
	
	<td align="center">
		<cfif isDefined("form.dist_z2")>
			<cfinput name="dist_z2" type="Text" size="4" value="#form.dist_z2#" validate="float" message="Please enter numeric values only">
		<cfelse>
			<cfinput name="dist_z2" type="Text" size="4" validate="float" message="Please enter numeric values only">
		</cfif>
	</td>
	<td align="center">
		<cfif isDefined("form.dist_c2")>
			<cfinput name="dist_c2" type="Text" size="4" value="#form.dist_c2#" validate="float" message="Please enter numeric values only">
		<cfelse>
			<cfinput name="dist_c2" type="Text" size="4" validate="float" message="Please enter numeric values only">
		</cfif>
	</td>
	<td>&nbsp;</td>
	</tr>
</cfif>
</cfif>
<tr>
	<td colspan="9" align="left"><input type="Submit" value="Save/Update" onclick="return add('saveQ');"></td>
</tr>
</table>
<br><br><hr><br><br>
<table width="80%" border=".2" align="center" class="box">
<tr>
	<th colspan="9">Intensive Cessation Interventions Quarterly Report - Participant Follow-up (Quarter <cfoutput>#form.q#</cfoutput>)</th>
</tr>
<tr>
	<td>&nbsp;</td>
	<td># individuals that reached 6-month follow-up point during this quarter</td>
	<td># individuals successfully contacted for 6-month follow-up this quarter</td>
	<td># reporting 7-day abstinence at 6-month follow-up this quarter</td>
	<td>7-day abstinence rate at 6 months this quarter</td>
	<td># individuals that reached 12-month follow-up point during this quarter</td>
	<td># individuals successfully contacted for 12-month follow-up this quarter</td>
	<td># reporting 7-day abstinence at 12-month follow-up this quarter</td>
	<td>7-day abstinence rate at 12 months this quarter</td>
	
</tr>

<cfif isDefined("Qcalc_1.calc_one") and Qcalc_1.calc_one NEQ "">
	<cfset calc_two=Qcalc_1.calc_one>
<cfelse>
	<cfset calc_two="NA">
</cfif>

<cfif isDefined("Qcalc_2.calc_three") and Qcalc_2.calc_three NEQ "">
	<cfset calc_four=Qcalc_2.calc_three>
<cfelse>
	<cfset calc_four="NA">
</cfif>

<input type="Hidden" name="h_two" value="<cfoutput>#calc_two#</cfoutput>">
<input type="Hidden" name="h_four" value="<cfoutput>#calc_four#</cfoutput>">
<script language="JavaScript">
function calc_two_val(){
if ((document.QCess.h_two.value!="NA")&&(document.QCess.seven_d_abst_six.value!="")){
document.QCess.calc_2.value=Math.round(1000*document.QCess.seven_d_abst_six.value/document.QCess.h_two.value)/10 + '%';
}
else document.QCess.calc_2.value="NA";

}

function calc_four_val(){
if ((document.QCess.h_four.value!="NA")&&(document.QCess.seven_d_abst_twelve.value!="")){
document.QCess.calc_4.value=Math.round(1000*document.QCess.seven_d_abst_twelve.value/document.QCess.h_four.value)/10 + '%';
}
else document.QCess.calc_4.value="NA";

}

</script>
<tr>
	<td>Cessation Ctr Catchment Area</td>
	<td align="center"><input name="calc_1" type="text" size="4" disabled value="<cfoutput>#calc_two#</cfoutput>"></td>
	
	<td align="center">
		<cfif calc_two EQ "NA">
			<input name="six_mos_contact" type="text" size="4" disabled value="0">
		<cfelseif isDefined("form.six_mos_contact")>
			<cfinput name="six_mos_contact" type="text" size="4" value="#form.six_mos_contact#" validate="integer" message="Please enter a valid number of individuals">
		<cfelse>
			<cfinput name="six_mos_contact" type="text" size="4"  validate="integer" message="Please enter a valid number of individuals">
		</cfif>
	</td>
	
	<td align="center">
		<cfif calc_two EQ "NA">
			<input name="seven_d_abst_six" type="text" size="4" disabled value="0">
		<cfelseif isDefined("form.seven_d_abst_six")>
			<cfinput name="seven_d_abst_six" type="text" size="4" onChange="calc_two_val();" value="#form.seven_d_abst_six#" validate="integer" message="Please enter a valid number of individuals">
		<cfelse>
			<cfinput name="seven_d_abst_six" type="text" size="4" onChange="calc_two_val();" validate="integer" message="Please enter a valid number of individuals">
		</cfif>
	</td>
	
	<td align="center"><input name="calc_2" type="text" size="7" disabled value=""></td>
	<td align="center"><input name="calc_3" type="text" size="4" disabled value="<cfoutput>#calc_four#</cfoutput>"></td>
	
	<td align="center">
		<cfif calc_four EQ "NA">
			<input name="twelve_mos_contact" type="text" size="4" disabled value="0">
		<cfelseif isDefined("form.twelve_mos_contact")>
			<cfinput name="twelve_mos_contact" type="text" size="4" value="#form.twelve_mos_contact#" validate="integer" message="Please enter a valid number of individuals">
		<cfelse>
			<cfinput name="twelve_mos_contact" type="text" size="4" validate="integer" message="Please enter a valid number of individuals">
		</cfif>
	</td>
	
	<td align="center">	
		<cfif calc_four EQ "NA">
			<input name="seven_d_abst_twelve" type="text" size="4" disabled value="0">
		<cfelseif isDefined("form.seven_d_abst_twelve")>
			<cfinput name="seven_d_abst_twelve" type="text" size="4" onChange="calc_four_val();" value="#form.seven_d_abst_twelve#" validate="integer" message="Please enter a valid number of individuals">
		<cfelse>
			<cfinput name="seven_d_abst_twelve" type="text" size="4" onChange="calc_four_val();"  validate="integer" message="Please enter a valid number of individuals">
		</cfif>
	</td>
	
	<td align="center"><input name="calc_4" type="text" size="7" disabled value=""></td>
	</tr>
<tr>
	<td colspan="9" align="left">
<input type="Submit" value="Save/Update" onclick="return validate_four('saveQ2');">
	<!--- <button title="Save/Update">Save/Update</button> --->
	</td>
</tr>
	
</table>


<!---
<br><br><br>
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QannualType">
	select id, descr 
	from lu_annual_type
	where year2='#session.fy#'
	order by rank
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QannualDet">
	select c.name, a.patient_pop,b.descr , a.seq
	from lu_annual_type as b, arod as a, collaborators as c
	where 
	a.collab_id=c.seq
	and a.type=b.id
	and a.year2=b.year2
	and a.year2='#session.fy#'
	and a.userid='#session.userid#'	
	order by a.seq
</cfquery>
<table width="80%" border=".2" align="center" class="box">
<tr>
	<th colspan="4">Annual Report Outcome data to be supplied by each Cessation Center</th>
</tr>
<tr>
	<th>Collaborator</th>
	<th>Total patient population</th>
	<th>Type of data used</th>
	<th>&nbsp;</th>
</tr>
<tr>
	<td>
	<select name="annual_collab">
	<option value="" selected>
	<cfoutput>
	<cfloop query="Qcollaborators">
	<option value="#seq#">#name#
	</cfloop>
	</cfoutput>
	</select> 
	</td>
	<td><cfinput name="patient_pop" type="Text" validate="integer" message="Please enter a valid number for the patient population"></td>
	<td>
	<select name="annual_type">
	<option value="" selected>
	<cfoutput>
	<cfloop query="QannualType">
	<option value="#id#">#descr#
	</cfloop>
	</cfoutput>
	</select> 
	</td>
	<td><input type="Submit" value="Add" onclick="return validate_five('addAnnual');"></td>
</tr>

<cfif QannualDet.recordcount GT 0>
<cfoutput>
<cfloop query="QannualDet">
<tr bgcolor="Silver">
	<td>#name#</td>
	<td>#patient_pop#</td>
	<td>#descr#</td>
	<td>Delete<input name="delAnnual" type="Checkbox" value="#seq#"></td>
</tr>
</cfloop>
<tr>
	<td colspan="4" align="right"><input type="Submit" value="Delete" onclick="return add('delAnnual');"></td>
</tr>
</cfoutput>
</cfif>
</table>
--->
</cfform>
<script language="JavaScript">
calc_two_val();
calc_four_val();
</script>

<!--- 
<cfif Qext.recordcount EQ 0>
<cfif (<!--- session.fy NEQ session.def_fy OR session.fy EQ session.def_fy OR  --->
(session.fy NEQ session.def_fy and Q NEQ 4 ) or
(form.Q EQ 1 and DateCompare(createDate(session.fy-1, 12, 15),Dateformat(now())) LT 0)
OR 
(form.Q EQ 2 and DateCompare(createDate(session.fy, 3, 15),Dateformat(now())) LT 0)
OR 
(form.Q EQ 3 and DateCompare(createDate(session.fy, 6, 15),Dateformat(now())) LT 0)
OR 
(form.Q EQ 4 and DateCompare(createDate(session.fy, 9, 15),Dateformat(now())) LT 0)
<!--- AND session.userid NEQ 'QHC' --->
)>
	<script language="JavaScript">
	disableme();
	</script>
</cfif>
</cfif> --->
</td></tr></table>
 
<cfinclude template="quarterly_extm.cfm"> 
</html>