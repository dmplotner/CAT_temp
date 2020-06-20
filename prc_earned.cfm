<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="checkEMedia">
	
	select userid from earnedMedia 
	where activity = '#form.oldRpt#'
	and userid = '#form.rptuserid#'
	and month2= '#form.month#'		
	and year2= '#form.year#'	
	
</cfquery>

<cfif checkEMedia.recordcount EQ "0">
<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="insEMedia">

		insert into earnedMedia (activity, userid, month2, year2)
		values('#form.oldRpt#','#form.rptuserid#', '#form.month#', '#form.year#')
</cfquery>
</cfif>


<cfquery datasource="#application.DataSource#"  		
	 
	password="#application.db_password#"   		
	username="#application.db_username#" name="updEMedia">
	update earnedMedia
	set recruit1=<cfif isDefined("form.recruit1")>1<cfelse>0</cfif>, 
	recruit2=<cfif isDefined("form.recruit2")>1<cfelse>0</cfif>, 
	recruit3=<cfif isDefined("form.recruit3")>1<cfelse>0</cfif>, 
	recruit4=<cfif isDefined("form.recruit4")>1<cfelse>0</cfif>, 
	recruit5=<cfif isDefined("form.recruit5")>1<cfelse>0</cfif>, 
	<!--- intTrain= #form.internalTraining#, 
	numberTrained = <cfif isDefined("form.numTrained") and form.numTrained NEQ "">#numTrained#<cfelse> NULL</cfif>,
	hoursTrained= <cfif isDefined("form.lenTrained") and form.lenTrained NEQ "">#lenTrained#<cfelse> NULL</cfif>, --->	
	mediabarriers = '#form.mbarriers#',
	mediaSuccesses = '#form.msuccesses#'
	where activity = '#form.oldRpt#'
	and userid = '#form.rptuserid#'
	and month2= '#form.month#'		
	and year2= '#form.year#'
	
	
</cfquery>

