<CFQUERY NAME="Qgrantee"
		 DATASOURCE="#application.DataSource#"
         USERNAME="#application.db_username#"
         PASSWORD="#application.db_password#">


select
c.orgname2,
m.descrip,
c.orgname ,
c.grantnum,
c.coordpref ,
c.coordfname ,
c.coordlname ,
c.coordphone,
case
	when charIndex(';',c.coordemail) >0 then
		left(c.coordemail,charIndex(';',c.coordemail)-1)
	when charIndex(',',c.coordemail) >0 then
		left(c.coordemail,charIndex(',',c.coordemail)-1)
	else c.coordemail
end as coordemail,
c.coordpref2 ,
c.coordfname2 ,
c.coordlname2 ,
c.coordphone2,
case
	when charIndex(';',c.coordemail2) >0 then
		left(c.coordemail2,charIndex(';',c.coordemail2)-1)
	when charIndex(',',c.coordemail2) >0 then
		left(c.coordemail2,charIndex(',',c.coordemail2)-1)
	else c.coordemail2
end as coordemail2,
c.PIfname ,
c.PIlname ,
c.PIphone,
case
	when charIndex(';',c.PIemail) >0 then
		left(c.PIemail,charIndex(';',c.PIemail)-1)
	when charIndex(',',c.PIemail) >0 then
		left(c.PIemail,charIndex(',',c.PIemail)-1)
	else c.PIemail
end as PIemail ,
c.superfname2,
c.superlname2,
c.superphone2,
case
	when charIndex(';',c.superemail2) >0 then
		left(c.superemail2,charIndex(';',c.superemail2)-1)
	when charIndex(',',c.superemail2) >0 then
		left(c.superemail2,charIndex(',',c.superemail2)-1)
	else c.superemail2
end as superemail2,

case
	when charIndex(';',c.fiscalemail2) >0 then
		left(c.fiscalemail2,charIndex(';',c.fiscalemail2)-1)
	when charIndex(',',c.fiscalemail2) >0 then
		left(c.fiscalemail2,charIndex(',',c.fiscalemail2)-1)
	else c.fiscalemail2
end as fiscalemail2,
c.fiscalfname2,
c.fiscallname2,
c.fiscalphone2,

case
	when charIndex(';',c.addlemail) >0 then
		left(c.addlemail,charIndex(';',c.addlemail)-1)
	when charIndex(',',c.addlemail) >0 then
		left(c.addlemail,charIndex(',',c.addlemail)-1)
	else c.addlemail
end as addlemail,
c.countylist as Counties,
r.region,
cc.contact,
case isnull(c.btccomm,0) when 0 then 'No' else 'Yes' end as btccomm
from contact c, security s, contact cc, modality m, region r, area a
where c.partnertype = m.modality
and c.userid = s.userid
and c.cmanager=cc.userid
and isNull(c.area,1)=a.num
and a.year2=2009
and r.year2=2009
and r.num=a.region
and (s.del is null or s.del !=1)
and c.grantnum is not null
--and c.seq > 243
<!--- and c.email  not like '%health.state.ny.us'
and c.email is not null
and c.email  not like '%rti.org' --->
-- and (c.email is null or (c.email not like '%rti.org' and c.email not like '%health.state.ny.us%'))
and (c.email is null or (c.email not like '%rti.org' and NOT(c.coordemail like '%health.state.ny.us%' OR c.email  like '%health.state.ny.us%')  and NOT(c.coordemail like '%health.ny.gov%' OR c.email  like '%health.ny.gov%')))

and (s.del is null or s.del !=1)
and (s.endyear is null or s.endyear > '7/1/#session.fy#')

--and c.suppress is null
--and s.startyear is not null
--and c.partnertype !=4
and c.partnertype not in (4,5)
and c.userid <> 'RoswellParkCP' and c.userid <> 'LOlson'
order by 2, 3, c.seq

</CFQUERY>



<!--- Import the POI tag library. --->
<cfimport taglib="./poi/" prefix="poi" />


<!---
	Create an excel document and store binary data into REQUEST variable
	(if we also/or wanted to save this to disk, we could have supplied a
	"file" attribute). We are going to supply our branded template for
	this report by using the "template" attribute in the document tag.
--->

<poi:document name="REQUEST.ExcelData">

	<!--- Define style classes. --->
	<poi:classes>

		<poi:class
			name="title"
			style="font-family: arial ; color: black ; font-size: 13pt ; text-align: left ; font-weight:bold; "
			/>

			<poi:class
			name="title2"
			style="font-family: arial ; color: black ; font-size: 18pt ; text-align: center ; font-weight:bold; "
			/>
		<poi:class
			name="heading"
			style="font-family: arial ; color: black ; font-size: 10pt ; text-align: left ; font-weight:bold;"
			/>

		<poi:class
			name="header"
			style="font-family: arial ; background-color: lime ; color: black ; font-size: 12pt ; border-bottom: solid 3px green ; border-top: 2px solid white ;"
			/>




	</poi:classes>

	<!--- Define Sheets. --->
	<poi:sheets>


	<cfoutput>




		<poi:sheet
			name="Contractor Data">

			<!---
				Define global column styles.

				NOTE: Because our branded template has an image, we do NOT
				want to use the column width style. This will cause the image
				to be resized if it is in a cell that get's resized.
			--->
			 <poi:columns>
				<poi:column style="width: 150px ;" />
				<poi:column style="width: 150px ;" />
				<poi:column style="width: 150px ;" />
				<poi:column style="width: 150px ;" />
				<poi:column style="width: 150px ;" />
				<poi:column style="width: 150px ;" />
				<poi:column style="width: 150px ;" />
				<poi:column style="width: 150px ;" />
				<poi:column style="width: 200px ;" />
				<poi:column style="width: 150px ;" />
				<poi:column style="width: 150px ;" />
				<poi:column style="width: 150px ;" />
				<poi:column style="width: 150px ;" />
				<poi:column style="width: 200px ;" />
				<poi:column style="width: 150px ;" />
				<poi:column style="width: 150px ;" />
				<poi:column style="width: 150px ;" />
				<poi:column style="width: 200px ;" />
				<poi:column style="width: 150px ;" />
				<poi:column style="width: 150px ;" />
				<poi:column style="width: 150px ;" />
				<poi:column style="width: 200px ;" />
				<poi:column style="width: 150px ;" />
				<poi:column style="width: 150px ;" />
				<poi:column style="width: 150px ;" />
				<poi:column style="width: 150px ;" />

				<poi:column style="width: 200px ;" />
				<poi:column style="width: 150px ;" />
				<poi:column style="width: 150px ;" />
				<poi:column style="width: 150px ;" />

			</poi:columns>




			<!---
				Title row. Start on the second (2nd) row since the first row
				of our branded template has our corporate logo on it.
			--->
			<poi:row class="title">

<poi:cell  value="Program name" />
<poi:cell  value="Program Area" />
<poi:cell  value="Organization name" />
<poi:cell  value="Contract number" />
<poi:cell  value="Project coordinator ##1 title" />
<poi:cell  value="Project coordinator ##1 first name" />
<poi:cell  value="Project coordinator ##1 last name" />
<poi:cell  value="Project coordinator ##1 phone" />
<poi:cell  value="Project coordinator ##1 email" />
<poi:cell  value="Project coordinator ##2 title" />
<poi:cell  value="Project coordinator ##2 first name" />
<poi:cell  value="Project coordinator ##2 last name" />
<poi:cell  value="Project coordinator ##2 phone" />
<poi:cell  value="Project coordinator ##2 email" />
<poi:cell  value="Supervisor first name" />
<poi:cell  value="Supervisor last name" />
<poi:cell  value="Supervisor phone" />
<poi:cell  value="Supervisor email" />
<poi:cell  value="Contract PI first name" />
<poi:cell  value="Contract PI last name" />
<poi:cell  value="Contract PI phone" />
<poi:cell  value="Contract PI email" />

<poi:cell  value="Fiscal Staff first name" />
<poi:cell  value="Fiscal Staff last name" />
<poi:cell  value="Fiscal Staff phone" />
<poi:cell  value="Fiscal Staff email" />

<poi:cell  value="Additional email" />

<poi:cell  value="Additional Coordinators Receive BTC Communications" />

<poi:cell  value="Counties" />


<poi:cell  value="Contract manager" />
</poi:row>

<cfloop query="Qgrantee">

			<poi:row >


<poi:cell  value="#orgname#" />
<poi:cell  value="#descrip#" />
<poi:cell  value="#orgname2#" />
<poi:cell  value="#grantnum#" />

<poi:cell  value="#coordpref#" />
<poi:cell  value="#coordfname#" />
<poi:cell  value="#coordlname#" />
<poi:cell  value="#coordphone#" />
<poi:cell  value="#coordemail#" />


<poi:cell  value="#coordpref2#" />
<poi:cell  value="#coordfname2#" />
<poi:cell  value="#coordlname2#" />
<poi:cell  value="#coordphone2#" />
<poi:cell  value="#coordemail2#" />

<poi:cell  value="#superfname2#" />
<poi:cell  value="#superlname2#" />
<poi:cell  value="#superphone2#" />
<poi:cell  value="#superemail2#" />

<poi:cell  value="#PIfname#" />
<poi:cell  value="#PIlname#" />
<poi:cell  value="#PIphone#" />
<poi:cell  value="#PIemail#" />

<poi:cell  value="#fiscalfname2#" />
<poi:cell  value="#fiscallname2#" />
<poi:cell  value="#fiscalphone2#" />
<poi:cell  value="#fiscalemail2#" />

<poi:cell  value="#addlemail#" />


<poi:cell  value="#btccomm#" />

<poi:cell  value="#Counties#" />

<poi:cell  value="#contact#" />
			</poi:row>
		</cfloop>


</poi:sheet>
</cfoutput>
</poi:sheets>

</poi:document>




<!--- Tell the browser to expect an Excel file attachment. --->
<cfheader
	name="content-disposition"
	value="attachment; filename=ContractorList.xls"
	/>

<!---
	Tell browser the length of the byte array output stream.
	This will help the browser provide download duration to
	the user.
--->
<cfheader
	name="content-length"
	value="#REQUEST.ExcelData.Size()#"
	/>

<!--- Stream the binary data to the user. --->
<cfcontent
	type="application/excel"
	variable="#REQUEST.ExcelData.ToByteArray()#"
	/>

