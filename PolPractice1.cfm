<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
<title>CAT</title>
<cfset form.userid='dplotner'>
<cfset form.month='december'>
<cfset form.month2='december'>
<cfset form.activity2='test20'>
<cfset form.myFA='Advocating with Organizational Decision-makers – Ces Ctrs'>
<cfset form.handler="one">
<cfset form.rpt="8">
<cfif isDefined("url.q")>
	<cfset form.Q=url.q>
</cfif>

<cfinclude template="catstruct.cfm">
<table class="box" width="100%"><tr><td>
<br><br><br>
<script language="JavaScript">
function add(actvalue){
document.cess.dofunction.value=actvalue;
return true;
}

function setCollab(){
document.cess.dofunction.value="modify";
document.cess.submit();
}

function toggle(){
document.cess.org_id_show.value="1";
document.cess.submit();
}


function disableme(){
if ((typeof(document.cess.sub_1)!="undefined")){
document.cess.sub_1.disabled=true;
}
if ((typeof(document.cess.sub_2)!="undefined")){
document.cess.sub_2.disabled=true;
}
}
</script>

<!--- <cfparam name="form.month2" default=form.month> --->
<cfif isDefined("form.collabs") and form.collabs NEQ "">
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QcheckPPrecord">
select userid 
from chcopp
where year2=#session.fy#
and q='#form.Q#'
and userid='#session.userid#'
and collab_id=#form.collabs#
</cfquery>
<cfif QcheckPPrecord.recordcount EQ 0>
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QcheckPPrMaxYr">
	select max(year2) as maxyr from chcopp 
	where userid='#session.userid#'	
	and collab_id=#form.collabs#	
</cfquery>
<cfif QcheckPPrMaxYr.maxyr GT 1950 >

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QcheckPPrMax">
	insert into chcopp
	(userid,q,year2,collab_id,rb1, rb2, rb3, 
rb4, rb5, rb6, rb7, rb8, rb9, rb10, rb11, rb12, rb13, 
rb14, rb15, rb16, rb16t, org_id, org_id_a, compliance, 
compliance_a, strategy, comments )
	select userid, '#form.Q#', #session.fy#, collab_id, rb1, rb2, rb3, rb4, rb5, rb6, rb7, rb8, rb9, rb10, rb11, 
	rb12, rb13, rb14, rb15, rb16, rb16t,
	org_id, org_id_a, compliance, compliance_a, strategy, comments
	from chcopp 
	where year2=#QcheckPPrMaxYr.maxyr#
	and userid='#session.userid#'
	and collab_id=#form.collabs#
	and q=
	(select max(q) from chcopp 
	where year2=#QcheckPPrMaxYr.maxyr#
	and userid='#session.userid#'
	<cfif QcheckPPrMaxYr.maxyr EQ session.fy>
	and q <= #form.Q#
	</cfif>
	and collab_id=#form.collabs#)
	
</cfquery>
</cfif>
</cfif>
</cfif>
<cfif isDefined("form.dofunction")>
<cfif form.dofunction EQ "addPractice">
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QcheckPP">
select userid
from chcopp
where
userid='#session.userid#'
and collab_id=#form.collabs#
and year2=#session.fy#
and q='#form.Q#'
</cfquery>

<cfif QcheckPP.recordcount NEQ 0>
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QInsPP">
update chcopp
set 
rb1=#form.rb1#, 
<cfif isDefined("form.rb2")>rb2=#form.rb2#<cfelse>rb2=2</cfif>, 
<cfif isDefined("form.rb3")>rb3=#form.rb3#<cfelse>rb3=2</cfif>, 
<cfif isDefined("form.rb4")>rb4=#form.rb4#<cfelse>rb4=2</cfif>, 
<cfif isDefined("form.rb5")>rb5=#form.rb5#<cfelse>rb5=2</cfif>, 
<cfif isDefined("form.rb6")>rb6=#form.rb6#<cfelse>rb6=2</cfif>, 
<cfif isDefined("form.rb7")>rb7=#form.rb7#<cfelse>rb7=2</cfif>, 
rb8=#form.rb8#, 
rb9=#form.rb9#, 
rb10=#form.rb10#, 
<cfif isDefined("form.org_id")>org_id='#form.org_id#',</cfif> 
<cfif isDefined("form.compliance")>compliance='#form.compliance#',</cfif> 
<cfif isDefined("form.org_id_a")>org_id_a='#form.org_id_a#', </cfif> 
<cfif isDefined("form.compliance_a")>compliance_a='#form.compliance_a#',</cfif> 
rb11=#form.rb11#,
rb12=#form.rb12#, 
rb13=#form.rb13#, 
rb14=#form.rb14#, 
<cfif isDefined("form.comments")>comments='#htmleditformat(form.comments)#',</cfif>
<cfif isDefined("form.rb16")>rb16=#form.rb16#, </cfif>
<cfif isDefined("form.rb16t")>rb16t=<cfif form.rb16t NEQ ''>'#form.rb16t#'<cfelse>NULL</cfif>, </cfif>
rb15=#form.rb15#
where
userid='#session.userid#'
and collab_id=#form.collabs#
and year2=#session.fy#
and q='#form.Q#'
</cfquery>

<cfelse>
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QInsPP">
insert into chcopp
(userid, Q, year2, strategy, collab_id, rb1, 
rb2, rb3, rb4, rb5, rb6, rb7, 
rb8, rb9, rb10, rb11, rb12, rb13, rb14, rb15,
<cfif isDefined("form.org_id")>org_id,</cfif> 
<cfif isDefined("form.compliance")>compliance,</cfif>
<cfif isDefined("form.comments")>comments,</cfif>
<cfif isDefined("form.rb16")>rb16, </cfif>
<cfif isDefined("form.rb16t")>rb16t, </cfif>
 org_id_a, compliance_a)
values
('#session.userid#', '#form.Q#', #session.fy#, #form.rpt#,
#form.collabs#, #form.rb1#,
<cfif form.rb1 EQ 0>
2,2,2,2,2,2,
<cfelse>
#form.rb2#,#form.rb3#,#form.rb4#,#form.rb5#,#form.rb6#,#form.rb7#,
</cfif>
#form.rb8#,#form.rb9#,#form.rb10#,#form.rb11#, 
#form.rb12#, #form.rb13#, #form.rb14#, #form.rb15#, 
<cfif isDefined("form.org_id")>'#form.org_id#',</cfif>
<cfif isDefined("form.compliance")>'#form.compliance#',</cfif> 
<cfif isDefined("form.comments")>'#htmleditformat(form.comments)#',</cfif>
<cfif isDefined("form.rb16")>#form.rb16#, </cfif>
<cfif isDefined("form.rb16t")><cfif form.rb16t NEQ ''>'#form.rb16t#'<cfelse>NULL</cfif>, </cfif>
'#form.org_id_a#', '#form.compliance_a#'
)
</cfquery>
</cfif>
<cfset form.collabs = "">
<cfelseif form.dofunction EQ "modify" and form.collabs NEQ "">

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QSelPP_mod">
	select  
	collab_id, rb1, rb2, rb3, rb4, rb5, rb6, rb7, rb8, rb9, rb10, rb11, 
	rb12, rb13, rb14, rb15, rb16, rb16t, org_id, compliance, org_id_a, compliance_a, comments
	from chcopp as a, collaborators as b
	where 
	a.userid='#session.userid#'
	and a.year2=#session.fy#
	and a.q='#form.q#'
	and a.collab_id=b.seq
	and a.strategy = #form.rpt#
	and b.seq = #form.collabs#	
</cfquery>



<cfif QSelPP_mod.recordcount  NEQ 0>

<cfset form.collabs= '#QSelPP_mod.collab_id#'>
<cfset form.rb1= '#QSelPP_mod.rb1#'>
<cfset form.rb2= '#QSelPP_mod.rb2#'>
<cfset form.rb3= '#QSelPP_mod.rb3#'>
<cfset form.rb4= '#QSelPP_mod.rb5#'>
<cfset form.rb5= '#QSelPP_mod.rb5#'>
<cfset form.rb6= '#QSelPP_mod.rb6#'>
<cfset form.rb7= '#QSelPP_mod.rb7#'>
<cfset form.rb8= '#QSelPP_mod.rb8#'>
<cfset form.rb9= '#QSelPP_mod.rb9#'>
<cfset form.rb10= '#QSelPP_mod.rb10#'>
<cfset form.rb11= '#QSelPP_mod.rb11#'>

<cfset form.rb12= '#QSelPP_mod.rb12#'>
<cfset form.rb13= '#QSelPP_mod.rb13#'>
<cfset form.rb14= '#QSelPP_mod.rb14#'>
<cfset form.rb15= '#QSelPP_mod.rb15#'>
<cfset form.rb16= '#QSelPP_mod.rb16#'>
<cfset form.rb16t= '#QSelPP_mod.rb16t#'>
<cfif isDefined("QSelPP_mod.org_id")><cfset form.org_id= '#QSelPP_mod.org_id#'></cfif>
<cfif isDefined("QSelPP_mod.compliance")><cfset form.compliance= '#QSelPP_mod.compliance#'></cfif> 
<cfif isDefined("QSelPP_mod.comments") and NOT isDefined("form.comments")><cfset form.comments= '#QSelPP_mod.comments#'></cfif> 
<cfset form.org_id_a= '#QSelPP_mod.org_id_a#'>
<cfset form.compliance_a= '#QSelPP_mod.compliance_a#'>
<cfset form.org_id_show=1>
</cfif>




<cfelseif form.dofunction EQ "delPractice" and isDefined("form.delPP")>
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QDelPP">
delete from chcopp
where seq in (#form.delPP#)
</cfquery>
<cfset form.collabs = "">
</cfif>




</cfif>








<!--- Processing before return --->

<!--- 
<cfif isDefined("form.barriers") and isDefined("form.userid")>
<cfset prog_num = 'progress'&form.dofunction>
<cfset suc_num = 'success'&form.dofunction>
<cfset bar_num = 'barriers'&form.dofunction>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="CheckProg">
	select userid
	from advoc
	where userid = '#form.userid#'
			and activity = '#form.rpt#'
			and month2='#form.month#'
			and year2=#form.year#
</cfquery>

<cfif CheckProg.recordcount LT 1>
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="InsNewProg">
	Insert into advoc
	(userid, activity, month2, year2)
	values
	('#form.userid#','#form.activity2#','#form.month#',#form.year#)
</cfquery>
</cfif>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="UpdProg">
	Update advoc
	set #prog_num# = '#form.Activityprogress#', 
	#suc_num#='#successes#', 
	#bar_num#='#barriers#'
			where userid = '#form.userid#'
			and activity = '#form.activity2#'
			and month2='#form.month#'
			and year2=#form.year#

</cfquery>
	
			
</cfif>


</cfif>


</cfif> --->

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QSelPP">
	select  
	collab_id, rb1, rb2, rb3, rb4, rb5, rb6, rb7, rb8, rb9, rb10, rb11, 
	rb12, rb13, rb14, rb15, rb16, rb16t,
	isNull(org_id, 0) as org_id, compliance, org_id_a, compliance_a, a.seq, name, unit, comments
	from chcopp as a, collaborators as b
	where 
	a.userid='#session.userid#'
	and a.year2=#session.fy#
	and a.q='#form.q#'
	and a.collab_id=b.seq
	and a.strategy = #form.rpt#
	<cfif isDefined("form.collabs") and form.Collabs NEQ ""> and a.collab_id != #form.collabs#</cfif>
	
</cfquery>



<!--- <cfoutput>
select  
	collab_id, rb1, rb2, rb3, rb4, rb5, rb6, rb7, rb8, rb9, rb10, rb11, org_id, compliance, org_id_a, compliance_a, a.seq, name
	from chcopp as a, collaborators as b
	where 
	a.userid='#session.userid#'
	and a.year2=#session.fy#
	and a.month2='#form.month2#'
	and a.collab_id=b.seq
	and a.strategy = #form.rpt#
</cfoutput> --->

<!--- <cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QSelMG">
	select  
	collab_id, funded_service, amount, award_date, a.seq, name
	from chco_mgf as a, collaborators as b
	where 
	a.userid='#session.userid#'
	and a.year2=#session.fy#
	and a.month2='#form.month2#'	
	and a.collab_id=b.seq
	and a.strategy = #form.rpt#
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QSelAC">
	select  
	collab_id, method, contact_date, material, a.seq, name
	from cchco_ac as a, collaborators as b
	where 
	a.userid='#session.userid#'
	and a.year2=#session.fy#
	and a.month2='#form.month2#'	
	and a.collab_id=b.seq
	and a.strategy = #form.rpt#
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QSelTRAIN">
	select  
	training, train_date, method, credit, type_credit, num_attendees, material,seq
	from cchco_train
	where 
	userid='#session.userid#'
	and year2=#session.fy#
	and month2='#form.month2#'	
	and strategy = #form.rpt#
	
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QSelTA">
	select  
	collab_id, ta_date, method, num_ta, material, a.seq, name
	from cchco_ta as a, collaborators as b
	where 
	a.userid='#session.userid#'
	and a.year2=#session.fy#
	and a.month2='#form.month2#'	
	and a.collab_id=b.seq
	and a.strategy = #form.rpt#
</cfquery> --->

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qcollaborators">
	select Unit, name, seq ,
	case 
	 when unit IS NULL then NAME
	 else unit + ' ' + NAME
	end as unitname 
	from collaborators 
	where  userid = '#session.userid#'	
	and (del is null or del != 1)
	order by 4
</cfquery>
 
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qident">
	select id, descr
	from lu_chcopp_id
	where year2=#session.fy#
	order by rank
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qfeedback">
	select id, descr
	from lu_chcopp_feedback 
	where year2=#session.fy#
	order by rank
</cfquery>
<!---
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QACMethods">
	select id, descr
	from lu_cchco_commit_method 
	order by rank
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QACMaterials">
	select id, descr
	from lu_cchco_materials
	order by rank
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QTAMethod">
	select id, descr
	from lu_cchco_ta_method
	order by rank
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QTrainMethod">
	select id, descr
	from lu_cchco_train_method
	order by rank
</cfquery>

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QTrainCredit">
	select id, descr
	from lu_cchco_train_credit
	order by rank
</cfquery>
 --->


<table class="box" width="80%" align="center">
<cfoutput>
<tr>
	<th align="left">Quarterly Report for Q#form.q# <!--- #form.month# ---></th>
</tr>

<tr>
	<th align="left">Cessation Center Focus Area Policy and Practice Measures</th>
</tr>
</cfoutput>
</table>


<cfform name="cess" action="PolPractice1.cfm?#session.urltoken#">
<!--- <input type="Hidden" name="rpt" value="<cfoutput>#form.rpt#</cfoutput>">
<input type="Hidden" name="month2" value="<cfoutput>#form.month2#</cfoutput>">
<input type="Hidden" name="month" value="<cfoutput>#form.month#</cfoutput>">
<input type="Hidden" name="myFA" value="<cfoutput>#form.myFA#</cfoutput>">
<input type="Hidden" name="activity2" value="<cfoutput>#form.activity2#</cfoutput>"> --->
<input type="hidden" name="dofunction" value="">
<input type="Hidden" name="org_id_show" value="">
<!--- <input type="Hidden" name="handler" value="<cfoutput>#form.handler#</cfoutput>">
<input type="Hidden" name="year" value="<cfoutput>#form.year#</cfoutput>"> --->


<cfoutput>
<input type="Hidden" name="q" value="#form.q#">
<cfset PreserveExclude = "dofunction,org_id_show,collabs,rb1,rb2,rb3,rb4,rb5,rb6,rb7,org_id_a,org_id,rb8,rb9,rb10,compliance_a,compliance,rb11,rb12,rb13,rb14,rb15,rb16,rb16t,delPP,MCcollabs,MGservice,MCamount,MGdate,delMG,ACollabs,ACmethod,ACdate,ACMaterial,delAC,TRTrain,TRDate,TRMethod,TRCredit,TRTypeCredit,TRNum,TRMaterial,delTRAIN,delTrainCollabDet,TACollabs,TAdate,TAMethod,TANum,TAMaterial,delTA,activityprogress,successes,barriers,prcSeq,updline,q,comments">
<cfif IsDefined("form.fieldnames")>
     <cfloop list="#form.fieldnames#" index="f">
          <cfif NOT IsDefined("PreserveExclude")
               OR ListFindNoCase(PreserveExclude, f) IS 0>
               <cfif f does not contain "TRCollabName_" and f does not contain "TRCollabAttend_">
			   	<cfset FEval = "ListLast(form." & f & ")">
               	<!--- <input name="#f#" type="Hidden" value="#Evaluate(FEval)#"> --->
				<input name="#f#" type="Hidden" value="#Form[f]#">
			   </cfif>
          </cfif>
     </cfloop>
</cfif>

</cfoutput>




<!--- <div align="center">Cessation Center Focus Area Process Measures</div> --->
<!--- <cfif isDefined("form.handler") and form.handler EQ "one"> --->
<!--- <div align="center">Policy and Practice</div> --->
<table border=".2" align="center" class="box" width="80%">
<tr>
	<th colspan="2">Target Health Care Organizations' Policy and Practice</th>
</tr>
<tr>
	<td>Target HCPO</td>
	<td>
	<!--- <select name="collabs" onchange="setCollab();">
	<option value="">
	<cfoutput>
	<cfloop query="Qcollaborators">
	<option value="#seq#"<cfif isDefined("form.collabs") and form.collabs EQ SEQ>selected</cfif>>#unit# #name#
	</cfloop>
	</cfoutput>
	</select>  --->
	
		
	<cfoutput>
	<cfif isDefined("form.collabs") and form.collabs NEQ "" >
	<cfloop query="Qcollaborators">
	<cfif isDefined("form.collabs") and form.collabs EQ SEQ>
	<input type="hidden" name="collabs" value="#seq#">#unit# #name#	
	</cfif>
	</cfloop>
	<cfelse>
	<select name="collabs" onchange="setCollab();">
	<option value="">
	<cfoutput>
	<cfloop query="Qcollaborators">
	<option value="#seq#"<cfif isDefined("form.collabs") and form.collabs EQ SEQ>selected</cfif>>#unit# #name#
	</cfloop>
	</cfoutput>
	</select> 
	</cfif>
	</cfoutput>
	
	</td>
</tr>
<cfif isDefined("form.collabs") and form.collabs NEQ "">

<tr>
	<td>
	<cfif session.fy LT 2008>
	Does organization have a written policy, procedure or guideline on tobacco dependence treatment?
	<cfelse>
	Does the organization have a written policy or written standard of care on tobacco dependence treatment?	
	</cfif>
	</td>
	<td>
		<input type="Radio" name="rb1" value="1"<cfif isDefined("form.org_id_show") and form.org_id_show EQ "1" and form.rb1 EQ "1">checked</cfif> onClick="toggle();">Yes&nbsp;&nbsp;&nbsp;
		<input type="Radio" name="rb1" value="0" <cfif (isDefined("form.org_id_show") and ((form.org_id_show EQ "1" and form.rb1 EQ "0") or form.org_id_show NEQ "1")) or Not isDefined("form.org_id_show")>checked</cfif>  onClick="toggle();">No
	</td>
</tr>
<cfif <!--- isDefined("form.org_id_show") and form.org_id_show EQ "1" and ---> isDefined("form.rb1") and form.rb1 EQ "1">
<tr>
	<td colspan="2">Does the organization's written policy, procedure, or guideline include...</td>
</tr>
<tr>
	<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Every patient is screened for tobacco use?</td>
	<td nowrap>
		<input type="Radio" name="rb2" value="1" <cfif isDefined("form.org_id_show") and isDefined("form.rb2") and form.org_id_show EQ "1" and form.rb2 EQ "1">checked</cfif>>Yes&nbsp;&nbsp;&nbsp;
		<input type="Radio" name="rb2" value="0" <cfif isDefined("form.org_id_show") and isDefined("form.rb2") and form.org_id_show EQ "1" and form.rb2 EQ "0">checked</cfif> >No &nbsp;&nbsp;&nbsp;
		<input type="Radio" name="rb2" value="2" <cfif (isDefined("form.org_id_show") and isDefined("form.rb2") and ((form.org_id_show EQ "1" and form.rb2 EQ "2") or form.org_id_show NEQ "1")) or Not isDefined("form.rb2")>checked</cfif>>NA
	</td>
</tr>
<tr>
	<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Every tobacco user is provided with brief counseling?</td>
	<td>
		<input type="Radio" name="rb3" value="1" <cfif isDefined("form.org_id_show") and isDefined("form.rb3") and form.org_id_show EQ "1" and form.rb3 EQ "1">checked</cfif> >Yes&nbsp;&nbsp;&nbsp;
		<input type="Radio" name="rb3" value="0" <cfif isDefined("form.org_id_show") and isDefined("form.rb3") and form.org_id_show EQ "1" and form.rb3 EQ "0">checked</cfif>  >No &nbsp;&nbsp;&nbsp;
		<input type="Radio" name="rb3" value="2" <cfif (isDefined("form.org_id_show") and isDefined("form.rb3") and ((form.org_id_show EQ "1" and form.rb3 EQ "2") or form.org_id_show NEQ "1")) or Not isDefined("form.rb3")>checked</cfif>>NA
	</td>
</tr>
<tr>
	<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Providers receive ongoing tobacco dependence treatment training?</td>
	<td>
		<input type="Radio" name="rb4" value="1" <cfif isDefined("form.org_id_show")  and isDefined("form.rb4") and form.org_id_show EQ "1" and form.rb4 EQ "1">checked</cfif> >Yes&nbsp;&nbsp;&nbsp;
		<input type="Radio" name="rb4" value="0"  <cfif isDefined("form.org_id_show")  and isDefined("form.rb4") and form.org_id_show EQ "1" and form.rb4 EQ "0">checked</cfif> >No &nbsp;&nbsp;&nbsp;
		<input type="Radio" name="rb4" value="2" <cfif (isDefined("form.org_id_show")  and isDefined("form.rb4") and ((form.org_id_show EQ "1" and form.rb4 EQ "2") or form.org_id_show NEQ "1")) or Not isDefined("form.rb4")>checked</cfif>>NA
	</td>
</tr>
<tr>
	<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;A procedure for giving feedback to providers?</td>
	<td>
		<input type="Radio" name="rb5" value="1" <cfif isDefined("form.org_id_show")  and isDefined("form.rb5") and form.org_id_show EQ "1" and form.rb5 EQ "1">checked</cfif> >Yes&nbsp;&nbsp;&nbsp;
		<input type="Radio" name="rb5" value="0"  <cfif isDefined("form.org_id_show")  and isDefined("form.rb5") and form.org_id_show EQ "1" and form.rb5 EQ "0">checked</cfif> >No &nbsp;&nbsp;&nbsp;
		<input type="Radio" name="rb5" value="2" <cfif (isDefined("form.org_id_show")  and isDefined("form.rb5") and ((form.org_id_show EQ "1" and form.rb5 EQ "2") or form.org_id_show NEQ "1")) or Not isDefined("form.rb5")>checked</cfif>>NA
	</td>
</tr>
<tr>
	<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;A procedure for providing follow up and referrals to tobacco users?</td>
	<td>
		<input type="Radio" name="rb6" value="1" <cfif isDefined("form.org_id_show")  and isDefined("form.rb6") and form.org_id_show EQ "1" and form.rb6 EQ "1">checked</cfif> >Yes&nbsp;&nbsp;&nbsp;
		<input type="Radio" name="rb6" value="0"  <cfif isDefined("form.org_id_show")  and isDefined("form.rb6") and form.org_id_show EQ "1" and form.rb6 EQ "0">checked</cfif> >No &nbsp;&nbsp;&nbsp;
		<input type="Radio" name="rb6" value="2" <cfif (isDefined("form.org_id_show")  and isDefined("form.rb6") and ((form.org_id_show EQ "1" and form.rb6 EQ "2") or form.org_id_show NEQ "1")) or Not isDefined("form.rb6")>checked</cfif>>NA
	</td>
</tr>
<tr>
	<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Offer pharmacotherapy to tobacco users unless contraindicated?</td>
	<td>
		<input type="Radio" name="rb7" value="1" <cfif isDefined("form.org_id_show")  and isDefined("form.rb7") and form.org_id_show EQ "1" and form.rb7 EQ "1">checked</cfif> >Yes&nbsp;&nbsp;&nbsp;
		<input type="Radio" name="rb7" value="0" <cfif isDefined("form.org_id_show")  and isDefined("form.rb7") and form.org_id_show EQ "1" and form.rb7 EQ "0">checked</cfif>  >No &nbsp;&nbsp;&nbsp;
		<input type="Radio" name="rb7" value="2" <cfif (isDefined("form.org_id_show")  and isDefined("form.rb7") and ((form.org_id_show EQ "1" and form.rb7 EQ "2") or form.org_id_show NEQ "1")) or Not isDefined("form.rb7")>checked</cfif>>NA
	</td>
</tr>
</cfif>
<tr>
	<td colspan="2">Do the organization's practices ensure that...</td>
</tr>
<tr>
	<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Every patient is screened for tobacco use?</td>
	<td nowrap>
		<input type="Radio" name="rb12" value="0" <cfif isDefined("form.org_id_show") and form.org_id_show EQ "1" and isdefined("form.rb12") and form.rb12 EQ "0">checked</cfif> >Not at all<br>
		<input type="Radio" name="rb12" value="3" <cfif isDefined("form.org_id_show") and form.org_id_show EQ "1" and isdefined("form.rb12") and form.rb12 EQ "3">checked</cfif> >Partially<br>
		<input type="Radio" name="rb12" value="1" <cfif isDefined("form.org_id_show") and form.org_id_show EQ "1" and isdefined("form.rb12") and form.rb12 EQ "1">checked</cfif>>Completely<br>
		<input type="Radio" name="rb12" value="2" <cfif (isDefined("form.org_id_show") and ((form.org_id_show EQ "1" and isdefined("form.rb12") and form.rb12 EQ "2") or form.org_id_show NEQ "1")) or Not isDefined("form.org_id_show")>checked</cfif>>Don't Know
	</td>
</tr>
<tr>
	<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Every tobacco user is provided with brief counseling?</td>
	<td nowrap>
		<input type="Radio" name="rb13" value="0" <cfif isDefined("form.org_id_show") and form.org_id_show EQ "1" and isdefined("form.rb13") and form.rb13 EQ "0">checked</cfif> >Not at all<br>
		<input type="Radio" name="rb13" value="3" <cfif isDefined("form.org_id_show") and form.org_id_show EQ "1"  and isdefined("form.rb13") and form.rb13 EQ "3">checked</cfif> >Partially<br>
		<input type="Radio" name="rb13" value="1" <cfif isDefined("form.org_id_show") and form.org_id_show EQ "1"  and isdefined("form.rb13") and form.rb13 EQ "1">checked</cfif>>Completely<br>
		<input type="Radio" name="rb13" value="2" <cfif (isDefined("form.org_id_show") and ((form.org_id_show EQ "1" and isdefined("form.rb13")  and form.rb13 EQ "2") or form.org_id_show NEQ "1")) or Not isDefined("form.org_id_show")>checked</cfif>>Don't Know
	</td>
</tr>

<cfif session.fy GTE 2007>
<tr>
	<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Follow up and referrals are provided to tobacco users?</td>
	<td nowrap>
		<input type="Radio" name="rb15" value="0" <cfif isDefined("form.org_id_show") and form.org_id_show EQ "1" and isdefined("form.rb15") and form.rb15 EQ "0">checked</cfif> >Not at all<br>
		<input type="Radio" name="rb15" value="3" <cfif isDefined("form.org_id_show") and form.org_id_show EQ "1" and isdefined("form.rb15") and form.rb15 EQ "3">checked</cfif> >Partially<br>
		<input type="Radio" name="rb15" value="1" <cfif isDefined("form.org_id_show") and form.org_id_show EQ "1" and isdefined("form.rb15") and form.rb15 EQ "1">checked</cfif>>Completely<br>
		<input type="Radio" name="rb15" value="2" <cfif (isDefined("form.org_id_show") and ((form.org_id_show EQ "1" and isdefined("form.rb15") and form.rb15 EQ "2") or form.org_id_show NEQ "1")) or Not isDefined("form.org_id_show")>checked</cfif>>Don't Know
	</td>
</tr>
</cfif>

<tr>
	<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Pharmacotherapy is offered to tobacco users unless contraindicated?</td>
	<td nowrap>
		<input type="Radio" name="rb14" value="0" <cfif isDefined("form.org_id_show") and form.org_id_show EQ "1"  and isdefined("form.rb14") and form.rb14 EQ "0">checked</cfif> >Not at all<br>
		<input type="Radio" name="rb14" value="3" <cfif isDefined("form.org_id_show") and form.org_id_show EQ "1" and isdefined("form.rb14") and form.rb14 EQ "3">checked</cfif> >Partially <br>
		<input type="Radio" name="rb14" value="1" <cfif isDefined("form.org_id_show") and form.org_id_show EQ "1" and isdefined("form.rb14") and form.rb14 EQ "1">checked</cfif>>Completely<br>
		<input type="Radio" name="rb14" value="2" <cfif (isDefined("form.org_id_show") and ((form.org_id_show EQ "1" and isdefined("form.rb14") and form.rb14 EQ "2") or form.org_id_show NEQ "1")) or Not isDefined("form.org_id_show")>checked</cfif>>Don't Know
	</td>
</tr>
<cfif session.fy LT 2007>
<tr>
	<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;There is a procedure for providing follow up and referrals to tobacco users?</td>
	<td nowrap>
		<input type="Radio" name="rb15" value="0" <cfif isDefined("form.org_id_show") and form.org_id_show EQ "1" and isdefined("form.rb15") and form.rb15 EQ "0">checked</cfif> >Not at all<br>
		<input type="Radio" name="rb15" value="3" <cfif isDefined("form.org_id_show") and form.org_id_show EQ "1" and isdefined("form.rb15") and form.rb15 EQ "3">checked</cfif> >Partially<br>
		<input type="Radio" name="rb15" value="1" <cfif isDefined("form.org_id_show") and form.org_id_show EQ "1" and isdefined("form.rb15") and form.rb15 EQ "1">checked</cfif>>Completely<br>
		<input type="Radio" name="rb15" value="2" <cfif (isDefined("form.org_id_show") and ((form.org_id_show EQ "1" and isdefined("form.rb15") and form.rb15 EQ "2") or form.org_id_show NEQ "1")) or Not isDefined("form.org_id_show")>checked</cfif>>Don't Know
	</td>
</tr>
</cfif>


<tr>
	<td>Does organization have an identification system to <cfif session.fy LT 2007>assess<cfelse>document</cfif> the smoking status of every patient? If yes, select type:</td>
	<td>
		<input type="Radio" name="org_id_a" value="1" <cfif isDefined("form.org_id_show") and form.org_id_show EQ "1" and form.org_id_a EQ "1">checked</cfif>  onclick="toggle();">Yes&nbsp;&nbsp;&nbsp;
		<input type="Radio" name="org_id_a" value="0" <cfif (isDefined("form.org_id_show") and ((form.org_id_show EQ "1" and form.org_id_a EQ "0") or form.org_id_show NEQ "1")) or Not isDefined("form.org_id_show")>checked</cfif> onclick="toggle();">No
	</td>
</tr>
<cfif isDefined("form.org_id_show") and form.org_id_show EQ "1" and form.org_id_a EQ "1">
<tr>
	<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;If yes, select type(s):</td>
	<td>
		<select  name="org_id" multiple size="4" class="mlti">
		<cfoutput>
		<cfloop query="Qident">
		<option value="#id#"<cfif isDefined("form.org_id") and listContains(form.org_id, id)> selected</cfif>>#descr#
		</cfloop>
		</cfoutput>
		</select>
	</td>
		
</tr>
</cfif>

<tr>
	<td>Does the organization have a staff person assigned as the Tobacco Dependence Treatment Coordinator?</td>
	<td>
		<input type="Radio" name="rb8" value="1"<cfif isDefined("form.org_id_show") and form.org_id_show EQ "1" and form.rb8 EQ "1">checked</cfif>>Yes&nbsp;&nbsp;&nbsp;
		<input type="Radio" name="rb8" value="0" <cfif (isDefined("form.org_id_show") and ((form.org_id_show EQ "1" and form.rb8 EQ "0") or form.org_id_show NEQ "1")) or Not isDefined("form.org_id_show")>checked</cfif>>No
	</td>
</tr>

<tr>
	<td>Does the organization provide educational opportunities to clinicians and staff to promote counseling with tobacco-using patients?</td>
	<td>
		<input type="Radio" name="rb9" value="2"<cfif isDefined("form.org_id_show") and form.org_id_show EQ "1" and form.rb9 EQ "2">checked</cfif>>Yes, coordinated on their own<br>
		<input type="Radio" name="rb9" value="1"<cfif isDefined("form.org_id_show") and form.org_id_show EQ "1" and form.rb9 EQ "1">checked</cfif>>Yes, coordinated by the Cessation Center<br>
		<input type="Radio" name="rb9" value="0" <cfif (isDefined("form.org_id_show") and ((form.org_id_show EQ "1" and form.rb9 EQ "0") or form.org_id_show NEQ "1")) or Not isDefined("form.org_id_show")>checked</cfif>>No
	</td>
</tr>
<tr>
	<td>Does the organization provide resources and materials to clinicians/staff to promote screening and brief counseling with tobacco-using patients?</td>
	<td>
		<input type="Radio" name="rb10" value="2"<cfif isDefined("form.org_id_show") and form.org_id_show EQ "1" and form.rb10 EQ "2">checked</cfif>>Yes, on their own<br>
		<input type="Radio" name="rb10" value="1"<cfif isDefined("form.org_id_show") and form.org_id_show EQ "1" and form.rb10 EQ "1">checked</cfif>>Yes, through the Cessation Center<br>
		<input type="Radio" name="rb10" value="0" <cfif (isDefined("form.org_id_show") and ((form.org_id_show EQ "1" and form.rb10 EQ "0") or form.org_id_show NEQ "1")) or Not isDefined("form.org_id_show")>checked</cfif>>No
	</td>
</tr>


<tr>
	<td>Does the organization assess provider compliance with the tobacco dependence treatment policy, procedure, or guideline?<br>If yes, how is compliance assessed?</td>
	<td>
		<input type="Radio" name="compliance_a" value="1"<cfif isDefined("form.org_id_show") and form.org_id_show EQ "1" and form.compliance_a EQ "1">checked</cfif> onclick="toggle();">Yes&nbsp;&nbsp;&nbsp;
		<input type="Radio" name="compliance_a" value="0" <cfif (isDefined("form.org_id_show") and ((form.org_id_show EQ "1" and form.compliance_a EQ "0") or form.org_id_show NEQ "1")) or Not isDefined("form.org_id_show")>checked</cfif> onclick="toggle();">No
	</td>
</tr>
<cfif isDefined("form.org_id_show") and form.org_id_show EQ "1" and form.compliance_a EQ "1"><tr>
	<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;If yes, how is compliance assessed?</td>
	<td>
		<select  name="compliance" multiple size="4" class="mlti">
		<cfoutput>
		<cfloop query="Qfeedback">
		<option value="#id#"<cfif isDefined("form.compliance") and listContains(form.compliance, id)> selected</cfif>>#descr#
		</cfloop>
		</cfoutput>
		</select>
	</td>
</tr>
</cfif>

<tr>
	<td>Does the organization routinely provide feedback (e.g. report cards) to providers?</td>
	<td>
		<input type="Radio" name="rb11" value="1"<cfif isDefined("form.org_id_show") and form.org_id_show EQ "1" and form.rb11 EQ "1">checked</cfif>>Yes&nbsp;&nbsp;&nbsp;
		<input type="Radio" name="rb11" value="0" <cfif (isDefined("form.org_id_show") and ((form.org_id_show EQ "1" and form.rb11 EQ "0") or form.org_id_show NEQ "1")) or Not isDefined("form.org_id_show")>checked</cfif>>No
	</td>
</tr>

<tr>
<td colspan="2">
<table  border=".2" align="center" class="box" width="100%">
<tr>
<td rowspan="5" width="50%">
Which of the following best describes the current policy regarding
outdoor cigarette smoking by staff, patients, and visitors at this health care
organization?
</td>
<td>
		<input type="Radio" name="rb16" value="1"<cfif isDefined("form.rb16") and form.rb16 EQ "1">checked</cfif>>No smoking is allowed anywhere outside on health care organization grounds. 
		<br><br>(If yes, what is the effective date of this policy?)
		
		<cfif isDefined("form.rb16t")>
			<cfinput type="text" name="rb16t" value="#dateformat(form.rb16t, 'm/d/yyyy')#" validate="date" message="Please enter a valid date format">
		<cfelse>
			<cfinput type="text" name="rb16t" validate="date" message="Please enter a valid date format">
		</cfif>(M/D/YYYY)
</td>
</tr>
<tr>
	<td>
	<input type="Radio" name="rb16" value="2"<cfif isDefined("form.rb16") and form.rb16 EQ "2">checked</cfif>>Smoking is allowed outdoors, but only in designated areas
	</td>
</tr>
<tr>
	<td>
	<input type="Radio" name="rb16" value="3"<cfif isDefined("form.rb16") and form.rb16 EQ "3">checked</cfif>>Smoking is allowed anywhere on the grounds outdoors
	</td>
</tr>
<tr>
	<td>
	<input type="Radio" name="rb16" value="4"<cfif isDefined("form.rb16") and form.rb16 EQ "4">checked</cfif>>There is no policy regarding smoking outdoors
	</td>
</tr>
<tr>
	<td>
	<input type="Radio" name="rb16" value="5"<cfif isDefined("form.rb16") and form.rb16 EQ "5">checked</cfif>>Don't know
	</td>
</tr>


</table>
</td></tr>


<tr>
	<td colspan="2">
	Additional comments:
	<textarea name="comments" cols="150" rows="5"><cfif isDefined("form.comments")><cfoutput>#form.comments#</cfoutput></cfif></textarea>
	</td>
</tr>
<tr><td colspan="2" align="left"><input type="Submit" name="sub_1" value="Add (or Update)" onclick="return add('addpractice');" class="AddButton"></td></tr>
</cfif>
</table>


<br>

<cfif QSelPP.recordcount GT 0>
<table align="center" class="box" width="80%"  border=".1">

<tr>
	
	<td rowspan="2" valign="top">Target HCPO</td>
	<td rowspan="2" valign="top">Written policy, procedure or guideline?</td>
	<td colspan="6" valign="top">Does the organization's written policy procedure or guideline include...</td>
	<td rowspan="2" valign="top">Identification system?</td>
	<td rowspan="2" valign="top" width="57">Delete?</td>
</tr>	
<tr>
	<td valign="top">Every patient is screened for tobacco use?</td>
	<td valign="top">Every tobacco user is provided with brief counseling?</td>
	<td valign="top">Providers receive ongoing training?</td>
	<td valign="top">A procedure for giving feedback to providers?</td>
	<td valign="top">A procedure for providing follow up and referrals to tobacco users?</td>
	<td valign="top">Offer pharmacotherapy to tobacco users unless contraindicated?</td>	
</tr>	



<cfoutput>

<cfloop query="QSelPP">

<tr bgcolor="Silver">
	
	<td>#QSelPP.Unit# #QSelPP.name#</td>
	<td><cfif QSelPP.rb1 EQ 1>YES<cfelse>NO</cfif></td>
	<td><cfif QSelPP.rb2 EQ 1>YES<cfelseif QSelPP.rb2 EQ 2>NA<cfelse>NO</cfif></td>
	<td><cfif QSelPP.rb3 EQ 1>YES<cfelseif QSelPP.rb3 EQ 2>NA<cfelse>NO</cfif></td>
	<td><cfif QSelPP.rb4 EQ 1>YES<cfelseif QSelPP.rb4 EQ 2>NA<cfelse>NO</cfif></td>
	<td><cfif QSelPP.rb5 EQ 1>YES<cfelseif QSelPP.rb5 EQ 2>NA<cfelse>NO</cfif></td>
	<td><cfif QSelPP.rb6 EQ 1>YES<cfelseif QSelPP.rb6 EQ 2>NA<cfelse>NO</cfif></td>
	<td><cfif QSelPP.rb7 EQ 1>YES<cfelseif QSelPP.rb7 EQ 2>NA<cfelse>NO</cfif></td>
	
<cfif QSelPP.org_id_a EQ "1">
	<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QPP_det_id">
	select id, descr
	from lu_chcopp_id
	where id in (#QSelPP.org_id#)
	and year2=#session.fy#
	order by rank
	</cfquery>
	<td>#valueList(QPP_det_id.descr, '<br>')#</td>
<cfelse>
	<td>NO</td>
</cfif>
	<td>Delete<input type="Checkbox" name="delPP" value="#QSelPP.seq#"></td>
</tr>

</cfloop>
<tr>
	<td colspan="10" align="right"><input type="Submit" name="sub_2" value="Delete" onclick="return add('delpractice');" class="DelButton"></td>
	<!--- <td><input type="Submit" value="Select to Edit" onclick="return add('modpractice');"></td> --->
</tr>
</cfoutput>
</table>
<br>
<table align="center" class="box" width="80%"  border=".1">
<tr>
	<td valign="top" rowspan="2">Target HCPO</td>
	<td colspan="4">Do the organization's practices ensure that...</td>
</tr>
<tr>
	<td valign="top">Every patient is screened for tobacco use?</td>
	<td valign="top">Every tobacco user is provided with brief counseling?</td>
	<td valign="top">Pharmacotherapy is offered to tobacco users unless contraindicated?</td>
	<td valign="top">There is a procedure for providing follow up and referrals to tobacco users?</td>
</tr>
<cfloop query="QselPP">
<tr bgcolor="Silver">
	<td><cfoutput>#QSelPP.Unit# #QSelPP.name#</cfoutput></td>
	<td>
		<cfif QselPP.rb12 EQ 0>
			Not at all
		<cfelseif QselPP.rb12 EQ 3>
			Partially
		<cfelseif QselPP.rb12 EQ 1>
			Completely
		<cfelse>
			Don't Know
		</cfif>
	</td>
	<td>
		<cfif QselPP.rb13 EQ 0>
			Not at all
		<cfelseif QselPP.rb13 EQ 3>
			Partially
		<cfelseif QselPP.rb13 EQ 1>
			Completely
		<cfelse>
			Don't Know
		</cfif>
	</td>
	<td>
		<cfif QselPP.rb14 EQ 0>
			Not at all
		<cfelseif QselPP.rb14 EQ 3>
			Partially
		<cfelseif QselPP.rb14 EQ 1>
			Completely
		<cfelse>
			Don't Know
		</cfif>
	</td>
	<td>
		<cfif QselPP.rb15 EQ 0>
			Not at all
		<cfelseif QselPP.rb15 EQ 3>
			Partially
		<cfelseif QselPP.rb15 EQ 1>
			Completely
		<cfelse>
			Don't Know
		</cfif>
	</td>
</tr>
</cfloop>
</table>

<br>
<table align="center" class="box" width="80%"  border=".1">
<tr>	
	<td valign="top">Target HCPO</td>
	<td valign="top">Tobacco Dependence Treatment Coordinator?</td>
	<td valign="top">Educational opportunities to staff to promote counseling?</td>
	<td valign="top">Resources and materials to staff to promote screening and counseling?</td>
	<td valign="top">Assess provider compliance?</td>
	<td valign="top">Feedback to providers?</td>
	<!--- <td valign="top">Delete?</td> --->
	<!--- <td valign="top">Select to Edit</td> --->
</tr>
<cfoutput>
<cfloop query="QSelPP">

<tr bgcolor="Silver">
	<td>#QSelPP.Unit# #QSelPP.name#</td>
	<td><cfif QSelPP.rb8 EQ 1>YES<cfelse>NO</cfif></td>
	<td><cfif QSelPP.rb9 EQ 1>YES, coordinated by the Cessation Center<cfelseif QSelPP.rb9 EQ 2>YES, coordinated on their own<cfelse>NO</cfif></td>
	<td><cfif QSelPP.rb10 EQ 1>YES, coordinated by the Cessation Center<cfelseif QSelPP.rb10 EQ 2>YES, coordinated on their own<cfelse>NO</cfif></td>
	
<cfif QSelPP.compliance_a EQ "1" and QSelPP.compliance NEQ "">
	<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QPP_det_feedback">
	select id, descr
	from lu_chcopp_feedback
	where id in (#QSelPP.compliance#)
	and year2=#session.fy#
	order by rank
</cfquery>
	<td>#ValueList(QPP_det_feedback.descr, '<br>')#</td>
<cfelse>
	<td>NO</td>
</cfif>
	
	
	
	<td><cfif QSelPP.rb11 EQ 1>YES<cfelse>NO</cfif></td>
	
	<!--- <td align="center"><input type="Radio" name="updline" value="#QSelPP.seq#"></td> --->
</tr>
</cfloop>
</cfoutput>

</table>
<br>
<table align="center" class="box" width="80%"  border=".1">
<tr>	
	<td valign="top" width="15%">Target HCPO</td>
	<td valign="top">Comments</td>
</tr>
<cfoutput>
<cfloop query="QSelPP">
<tr bgcolor="Silver">
	<td valign="top" >#QSelPP.Unit# #QSelPP.name#</td>
	<td valign="top" >#QSelPP.comments#&nbsp;</td>
</tr>

</cfloop>
</cfoutput>
</table>
</cfif>


<br><br>

<input type="Hidden" name="prcSeq" value="">


</cfform>

</td></tr></table>
<cfquery datasource="#application.DataSource#"  			 
	password="#application.db_password#"   		
	username="#application.db_username#" name="Qext">
	select userid from quarterly_extensions
	where userid = '#session.userid#'	
</cfquery>

<!--- <cfif Qext.recordcount EQ 0>
<cfif (((session.fy NEQ session.def_fy and Q NEQ 4 ) OR  <!--- session.fy EQ session.def_fy OR  --->

(form.Q EQ 1 and DateCompare(createDate(session.fy-1, 12, 15),Dateformat(now())) LT 0)
OR 
(form.Q EQ 2 and DateCompare(createDate(session.fy, 3, 15),Dateformat(now())) LT 0)
OR 
(form.Q EQ 3 and DateCompare(createDate(session.fy, 6, 15),Dateformat(now())) LT 0)
OR 
(form.Q EQ 4 and DateCompare(createDate(session.fy, 9, 15),Dateformat(now())) LT 0)
<!--- AND session.userid NEQ 'QHC' --->
) )>
	<script language="JavaScript">
	disableme();
	</script>	
</cfif>
</cfif>
 --->

</body>
<cfinclude template="quarterly_extm.cfm">
</html>
