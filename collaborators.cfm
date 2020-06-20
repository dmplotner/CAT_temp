<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
<title>CAT</title>

<script language="javascript">
function disableme(){
for(var intloop=0; intloop <document.submitCollab.length; intloop++){
	if(document.submitCollab[intloop].type=='textarea'){
	document.submitCollab[intloop].readOnly = true;
	}
	else
document.submitCollab[intloop].disabled=true;
}
}
</script>
<cfinclude template="CATstruct.cfm">
 <cfif #session.fy# GTE '2010' and session.modality NEQ 4>
<cfinclude template="collabdetail2.cfm">
<cfelse>
<cfinclude template="collabdetail.cfm">
</cfif>
<cfif session.fy LT session.def_fy AND session.prevyr NEQ 1 AND NOT (SESSION.areamanage EQ "1" OR SESSION.admin EQ "1" OR SESSION.TCP EQ "1")>
<script language="JavaScript">
	disableme();
</script>
</cfif>
