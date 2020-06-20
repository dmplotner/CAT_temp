<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="outCounty">	
	select countyName from counties
	order by 1		
</cfquery>



<cfif isDefined("form.manipOutreach")>

<cfif form.manipOutreach EQ "add">

<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="addOutreach">

insert into OUTREACH
(userid, activity, month2, year2, type, county, target, fk_forum_det)
values
('#session.userid#','#activity#','#form.month#',#form.year#,'#evaluate("form.promoMedia_" & form.insertWhere)#', '#evaluate("form.promocounty_" & form.insertWhere)#', '#evaluate("form.promoTarget_" & form.insertWhere)#',#form.insertWhere# )
 
</cfquery>

<cfelseif form.manipOutreach EQ "delete" and isDefined("form.delOut")>
 
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="delOutreach">

delete from OUTREACH
	where userid = '#session.userid#'
	and activity = '#activity#'
	and month2='#form.month#'
	and year2 = #form.year#
	and seq in (#form.delOut#)
	
</cfquery>
</cfif>
</cfif> 



<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="QpromoMedia">
	select descr, num
	from LU_outreach_media
	where year2=#form.year#	
	order by rank
	
</cfquery>

<input type="Hidden" name="manipOutreach" value="99">
<input type="Hidden" name="insertWhere" value="">
<script language="JavaScript">
function setNewOutreach(process, location){
/*if(process=="add"){
var Counter=0;
for (i=0; i<document.monthlyActivity.promocounty.length; i++){
      // If an element is selected, increment the counter
      if (document.monthlyActivity.promocounty[i].selected == true){
         Counter++;
      }
   }
   // If the counter is greater than 3, display an alert message.
   if (Counter <1){
      alert("You must select at least one county!");
      return false;
}
}
*/
document.monthlyActivity.insertWhere.value = location;
document.monthlyActivity.manipOutreach.value = process;
document.monthlyActivity.action = "monthlyActive.cfm<cfoutput>?#session.urltoken#</cfoutput>#outr";
document.monthlyActivity.submit();

}


</script>


