<cfset rptfy=2007>

<cfif url.type is 'all'>

<cfquery datasource="#application.DataSource#"

	password="#application.db_password#"
	username="#application.db_username#" name="cons">
	select
c.orgname,
m.descrip,
c.grantnum as [Contract number],
c.coordfname,
c.coordlname,
c.coordpref,
c.coordphone,
c.coordemail,
c.coordfname2,
c.coordlname2,
c.coordpref2,
c.coordphone2,
c.coordemail2,
c.catchment,
cc.contact,
c.addlemail
from contact c, security s, contact cc, modality m
where c.partnertype = m.modality
and c.userid = s.userid
and c.cmanager=cc.userid
and c.cmanager <> 'dplotner'
and (s.del is null or s.del !=1)
and (s.endyear is null or s.endyear > '7/1/#session.fy#')
and (c.email is null or (c.email not like '%rti.org' and NOT(c.coordemail like '%health.state.ny.us%' OR c.email  like '%health.state.ny.us%')  and NOT(c.coordemail like '%health.ny.gov%' OR c.email  like '%health.ny.gov%')))
--and c.seq > 243
and c.userid <> 'RoswellParkCP' and c.userid <> 'LOlson'
and c.partnertype !=4
and c.partnertype !=5

order by descrip,c.orgname

</cfquery>
<cfelseif url.type is 'sp'>
<cfquery datasource="#application.DataSource#"

	password="#application.db_password#"
	username="#application.db_username#" name="cons">
	select

m.descrip,

c.orgname,

c.grantnum as [Contract number],

c.contact as coord,
c.phone,
c.email,

c.catchment,

r.region,

cc.contact,

c.addlemail

from contact c, security s, contact cc, modality m, region r, area a

where c.partnertype = m.modality

and c.userid = s.userid

and c.cmanager=cc.userid

and c.area=a.num

and a.year2=2009

and r.year2=2009

and r.num=a.region

and (s.del is null or s.del !=1)

and (s.endyear is null or s.endyear > '7/1/#session.fy#')

and c.grantnum is not null

and c.partnertype =4

order by c.orgname

</cfquery>

</cfif>
<cfcontent type="application/vnd.ms-excel">
<!---
 <br><hr><br>
<div align="center">Mini-grants</div>
    <cfset mimetype="application/vnd.openxmlformats-officedocument.wordprocessingml.document">
	<cfheader name="Content-Disposition" value="filename=conlst.xls">--->
<!--- <cfheader name="Content-Disposition" value="attachment; filename=conlst.xls">
 ---><table border="1" align="center" class="box" width="80%" >

<tr>
	<th>Program Name</th>
	<th>Program Area</th>
	<cfif url.type is 'all'>
	<th>Project Coordinator #1 First Name</th>
	<th>Project Coordinator #1 Last Name</th>
	<cfelseif url.type is 'sp'>
	<th>Project Coordinator Name</th>
	</cfif>
	<th>Project Coordinator #1 Title</th>
	<th>Project Coordinator #1 Phone</th>
	<th>Project Coordinator #1 Email</th>

	<cfif url.type is 'all'>
	<th>Project Coordinator #2 First Name</th>
	<th>Project Coordinator #2 Last Name</th>
	<cfelseif url.type is 'sp'>
	<th>Project Coordinator Name</th>
	</cfif>
	<th>Project Coordinator #2 Title</th>
	<th>Project Coordinator #2 Phone</th>
	<th>Project Coordinator #2 Email</th>

	<th>Additional Email</th>
	<th>County or Counties Served</th>
	<th>Contract Manager</th>
</tr>



<cfoutput query="cons">
	<cfquery datasource="#application.DataSource#"

	password="#application.db_password#"
	username="#application.db_username#" name="counts">
	select countyName, FIPS from counties
	where FIPS in <cfif cons.catchment NEQ "">(#cons.catchment#)<cfelse>(0)</cfif>

	</cfquery>


<tr>
	<td>#cons.orgname#</td>
	<td>#cons.descrip#</td>
	<cfif url.type is 'all'>
	<td>#cons.coordfname#</td>
	<td>#cons.coordlname#</td>
	<td>#cons.coordpref#</td>
	<td>#cons.coordphone#</td>
	<td>#cons.coordemail#</td>
	<cfelseif url.type is 'sp'>
	<td>#cons.coord#</td>
	<td>#cons.phone#</td>
	<td>#cons.email#	</td>
	</cfif>


	<cfif url.type is 'all'>
	<td>#cons.coordfname2#</td>
	<td>#cons.coordlname2#</td>
	<td>#cons.coordpref2#</td>
	<td>#cons.coordphone2#</td>
	<td>#cons.coordemail2#</td>
	<cfelseif url.type is 'sp'>
	<td>#cons.coord#</td>
	<td>#cons.phone#</td>
	<td>#cons.email#	</td>
	</cfif>
	<td>#cons.addlemail#	</td>
	<td>#valuelist(counts.countyName)#</td>
	<td>#cons.contact#</td>
</tr>
</cfoutput>



