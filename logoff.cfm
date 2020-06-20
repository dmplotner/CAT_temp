
<!--- <CFSET SESSION.LoggedIn=""> --->
<!--- <cfset getPageContext().getSession().invalidate()>  --->
 <cfscript>
StructClear(Session);
</cfscript> 
<cflogout>


<cflocation  addtoken="No" url="../login/login.cfm">