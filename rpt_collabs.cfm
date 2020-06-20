<cfquery datasource="#application.DataSource#"  	 
	password="#application.db_password#"   		
	username="#application.db_username#" 
	name="QCollabList">
	select distinct collaborators, month2, progress
			from #tablename#
			<!--- where month2 in(#QuotedValuelist(Qmonlist.mon)#) --->
			where month2='#thisRptMon#'
			AND  userid = '#Guserid#'
			and activity = '#Gactivity#'
			and year2 = #session.fy#			
</cfquery>



<cfif qcollabList.recordcount GT 0 and  trim(qcollabList.progress) NEQ "">
<br>
<table border=".5" width="100%" cellspacing="0">
<tr><th colspan="2" align="left">Collaborators </th></tr>
<cfoutput query="qcollabList">
<tr>
	<td>#month2#</td>
	<td>
		<cfif collaborators EQ "">N/A
		<cfelse>
		<cfquery datasource="#application.DataSource#"  	 
			password="#application.db_password#"   		
			username="#application.db_username#" 
			name="QCollabName">
			select isNull(unit,'')+' ' + name as collabs
			from collaborators 
			where seq in (#collaborators#)	
		</cfquery>
		#valuelist(QCollabName.collabs, ";&nbsp;&nbsp;")#
		</cfif>
		
	</td>
</tr>
</cfoutput>
</table>
</cfif>
