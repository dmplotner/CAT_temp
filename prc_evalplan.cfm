<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="checkRecord">
	select distinct userid
	from EvalM
	where 
	userid='#session.userid#'
	and methodname = '#htmleditformat(form.methodname)#'
	and year2=#session.fy#
	
</cfquery>

<cfif checkRecord.recordcount GT 0>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>CAT</title>


<cfinclude template="CATstruct.cfm">

<SCRIPT language="JavaScript">
function CANCEL(){
document.prceval.action="evalplan.cfm<cfoutput>?#session.urltoken#</cfoutput>";
document.prceval.submit();
}
</SCRIPT>

<cfform  name="prceval" action="prc_evalplan2.cfm">
<cfoutput>
<cfif IsDefined("form.fieldnames")>
     <cfloop list="#form.fieldnames#" index="f">
             	<cfset FEval = "ListLast(form." & f & ")">
               	<!--- <input name="#f#" type="Hidden" value="#Evaluate(htmlEditformat(FEval))#">
				#f#:  #Evaluate(htmlEditformat(FEval))#<br>
				#f#: #Form[f]# <br><br> --->
				<input name="#f#" type="Hidden" value="#Form[f]#">
          
     </cfloop>
	 
</cfif>
</cfoutput>
<br>
<table width="75%" class="box">
<tr><td>
You are viewing this screen because you made changes to an existing Evaluation Method.  You can choose to submit this Evaluation Method, or cancel it.  Submitting will send a message to your TSERT Evaluation Specialist, indicating that you have made changes to an existing Evaluation Method.
</td></tr>
</table>
<!--- You have indicated that this Evaluation Method has been formally approved by your TSERT Evaluation Specialist. <br>
You can choose to submit this Evaluation Method, or cancel it. <br>
Submitting will send a message to your TSERT Evaluation Specialist, <br>
indicating that you have either added an Evaluation Method or made a change to a previously approved Evaluation Method.<br>
 --->
 
<br>
<br>
<textarea name="explanationOfChanges" cols="80" rows="5">If you are changing this Evaluation Method, please explain what you are changing and why.</textarea><br><br>

<input type="button" value="Cancel" onclick="CANCEL();"  style="width:400"><br><br>
<input type="submit" value="Submit Evaluation Method" style="width:400">
</cfform>
<cfelse>

<cfquery datasource="#application.DataSource#"  	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QgetSpec">
	select area from security
	where userid='#session.userid#'
</cfquery>

<cfquery datasource="#application.DataSource#"  	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QUserInfo">
select c.orgname, c.contact, s.area, a.region, c.coordemail as email
from contact as c, security as s, area as a
where c.userid='#session.userid#'	
and c.userid=s.userid
and s.area=a.num
and a.year2=#session.fy#
</cfquery>

<cfquery datasource="#application.DataSource#"  	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QgetSpec2">
	select  region  from area
	where num='#QgetSpec.area#'
	and year2=#session.fy#
</cfquery>
<cfif QgetSpec2.region EQ 2 OR QgetSpec2.region EQ 3>
<!--- central and capital regions (2,3) --->
	<cfset TSERT_SPEC= "aal07@health.state.ny.us">
<cfelse>
<!--- western and metro regions (1,4)--->
	<!--- <cfset TSERT_SPEC= "dxv06@health.state.ny.us"> --->
	<cfset TSERT_SPEC= "aal07@health.state.ny.us">
</cfif>
	
	
<cfmail from="dplotner@rti.org" cc="dplotner@rti.org" to="#TSERT_SPEC#" subject="#htmleditformat(QUserInfo.orgname)# Evaluation Plan Modification" type="HTML">
You are being contacted because you serve as the evaluation specialist for #htmleditformat(QUserInfo.orgname)#
(#htmleditformat(QUserInfo.contact)#, #QUserInfo.email#). They have added a new FY<cfif session.fy EQ 1904>2005-2006<cfelse>#evaluate(session.fy-1)#-#session.fy#</cfif> Evaluation Project ( <cfif isDefined("form.methodname")>"#htmleditformat(form.methodname)#"</cfif>). Please review this evaluation plan, and provide feedback to the partner.
</cfmail>

<cfinclude template="prcEvalPlanDet.cfm">
</cfif>