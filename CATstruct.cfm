<link rel="stylesheet" href="ddmenu.css" type="text/css">
<link rel="stylesheet" type="text/css" href="ddlevelsfiles/ddlevelsmenu-base.css" />
<link rel="stylesheet" type="text/css" href="ddlevelsfiles/ddlevelsmenu-topbar.css" />
<link rel="stylesheet" type="text/css" href="ddlevelsfiles/ddlevelsmenu-sidebar.css" />
<script type="text/javascript" src="ddlevelsfiles/ddlevelsmenu.js">
<SCRIPT LANGUAGE="JavaScript" SRC="date.js"></SCRIPT>
</head><body>

<cfif  (isDefined("SESSION.areamanage") and SESSION.areamanage EQ "1")OR (isDefined("SESSION.admin") and SESSION.admin EQ "1" )OR (isDefined("SESSION.TCP") and SESSION.TCP EQ "1") >
		<cfif Not isDefined("session.cessman") or (isDefined("session.cessman") and session.cessman NEQ 4)>
			<!--- <cfif session.userid eq "dplotner">
			<cfset session.fy =2010> --->
			<cfparam name="session.fy" default=2015>
	</cfif></cfif><!--- </cfif> --->
<cfparam name="session.fy" default=2015>

<cfparam name="session.fy" default="session.def_fy">
<cfset counter=50>
<cfset session.initiative = ''>
<script language="JavaScript">

function isdefined( variable)
{
return (typeof(window[variable]) == "undefined")? false: true;
}

function doSpell2(fldname) {
    window.open("./activedit/inc/spellchecker/window.cfm?<cfoutput>#session.urltoken#</cfoutput>&jsvar=document."+fldname, null,
        "height=230,width=450,status=no,toolbar=no,menubar=no,location=no,_blank");
}




function ValidateDate(datein){
	if (isDate(datein, 'M/d/yyyy')==false){
	alert('Please enter all dates in the format m/d/yyyy');
	return false;
	}
	return true;
}

function ValidateCompareDate(date1, date2){
	if (compareDates(date1, 'M/d/yyyy', date2, 'M/d/yyyy')==1){
	alert('Please make sure date ranges are valid - start dates are earlier than end dates');
	return false;
	}
	return true;
}

function IsNumeric(sText)

{
   var ValidChars = "0123456789.";
   var IsNumber=true;
   var Char;


   for (i = 0; i < sText.length && IsNumber == true; i++)
      {
      Char = sText.charAt(i);
      if (ValidChars.indexOf(Char) == -1)
         {
         IsNumber = false;
         }
      }
   return IsNumber;

   }

function ValidateForm(){
	var dt=document.frmSample.txtDate
	if (isDate(dt.value)==false){
		dt.focus()
		return false
	}
    return true
 }

function Trim(s)
{
  // Remove leading spaces and carriage returns

  while ((s.substring(0,1) == ' ') || (s.substring(0,1) == '\n') || (s.substring(0,1) == '\r'))
  {
    s = s.substring(1,s.length);
  }

  // Remove trailing spaces and carriage returns

  while ((s.substring(s.length-1,s.length) == ' ') || (s.substring(s.length-1,s.length) == '\n') || (s.substring(s.length-1,s.length) == '\r'))
  {
    s = s.substring(0,s.length-1);
  }
  return s;
}
</script><cfif #session.userid# is 'nsarris' or #session.userid# is 'twills' or #session.userid# is 'dplotner'>
<cfquery  NAME="QsetAdminFY"
		 			DATASOURCE="#application.DataSource#"
         			USERNAME="#application.db_username#"
         			PASSWORD="#application.db_password#">
                  select sp_fy , sp_nextyr, sp_prevyr, fy, nextyr, prevyr from admin
                  --where fy = 2019
</cfquery>
<cfelse>
<cfquery  NAME="QsetAdminFY"
		 			DATASOURCE="#application.DataSource#"
         			USERNAME="#application.db_username#"
         			PASSWORD="#application.db_password#">
                  select sp_fy , sp_nextyr, sp_prevyr, fy, nextyr, prevyr from admin

</cfquery>
</cfif>

<cfquery  NAME="QcheckDispFY"
		 			DATASOURCE="#application.DataSource#"
         			USERNAME="#application.db_username#"
         			PASSWORD="#application.db_password#">
			select isnull(datepart(yyyy,startyear), 1904) as styear from security where userid = '#session.userid#'
</cfquery>

<cfquery  NAME="QsetDispFY"
		 			DATASOURCE="#application.DataSource#"
         			USERNAME="#application.db_username#"
         			PASSWORD="#application.db_password#">

			select distinct year2,
			cast((year2-1) as varchar) + '-' + cast(year2 as varchar) as display
			from area
			where year2 != 1904


			<!--- and year2 > #QcheckDispFY.styear#
			and year2 < 2017 --->

<!---
<cfif isdefined("session.origuserid") and (#session.origUserID# is not 'nsarris' and #session.origUserID# is not 'twills')>
and year2 <> 2019
</cfif>
--->

				 union
			select 2015, '2014-2015'


			order by 2

</cfquery>



<cfquery  NAME="QsetATFAC"
		 			DATASOURCE="#application.DataSource#"
         			USERNAME="#application.db_username#"
         			PASSWORD="#application.db_password#">

select userid from contact where partnertype in (2,3) and userid = '#session.userid#'

</cfquery>

<cfparam name="session.fy" default="#session.def_fy#">

<div class="NavBar">
  <table width=100%  border="0" cellspacing="0" cellpadding="0" bgcolor="#333366">
    <tr align="center" valign="middle">
      <TD valign="middle" width="15%"><!-- Begin Heading table -->
        <table width="90%" align="center" border=0>
          <tr>
            <td nowrap colspan="5"><font color="White"><br>
              <cfoutput>#session.orgName#</cfoutput></font></td>
          </tr>
          <tr>

            <cfparam name="session.fy" default="#session.def_fy#">
            <cfif isDefined("form.useryr")>
              <cfif form.useryr NEQ session.fy>
                <cfset session.fy = form.useryr>
                <cflocation addtoken="yes" url="welcome.cfm">
              </cfif>
            </cfif>
            <cfset thistemp=GetFileFromPath(CGI.PATH_TRANSLATED)>
            <cfif isDefined("session.urltoken")>
              <cfset thistemp = thistemp&'?'&session.urltoken>
            </cfif>


<cfform  name="prcYr"  action="#thistemp#">
              <td nowrap><font color="White">
                </font>

<!--- new code 			   <cfoutput>select distinct year2,
			cast((year2-1) as varchar) + '-' + cast(year2 as varchar) as display
			from area
			where year2 != 1904
			<cfif session.cessMan EQ 4 or session.modality EQ 4>
			AND  year2 > 2006
			</cfif>

			<cfif session.cessMan EQ 4 or session.modality EQ 4>
			and year2 >= #QcheckDispFY.styear#
			<cfif QsetAdminFY.sp_nextyr EQ 1>
			and year2 <= (#session.def_fy# + 1)
			<cfelse>
			and year2 <= #session.def_fy#
			</cfif>
			<cfelseif (session.tcp EQ 1 OR session.AreaManage EQ 1 or session.admin EQ 1 or session.StateManage EQ 1 or session.regionManage EQ 1) >
			<cfif QsetAdminFY.nextyr EQ 1>
			and year2 <= (#session.def_fy# + 1)
			<cfelse>
			and year2 <= #session.def_fy#
			</cfif>
			<cfelse>
			and year2 >= 2010
			</cfif>
			<cfif (session.cessMan EQ 4 or session.modality EQ 4 OR session.tcp EQ 1 OR session.AreaManage EQ 1 or session.admin EQ 1 or session.StateManage EQ 1 or session.regionManage EQ 1) and QcheckDispFY.styear EQ 1904>
			union
			select 1904, '2005-2006 (SP)'

			<cfif NOT(session.cessMan EQ 4 or session.modality EQ 4)>
			<!--- union
			select 2010, '2009-2010' 	 --->
			</cfif>
			</cfif>

			order by 2
			</cfoutput>--->
				   <select name="useryr" onChange="submit();">
				   <CFOUTPUT>
				   <option value = ""> -please select-  </option>
<!---  <cfif session.userid EQ 'bridgesYP' or session.userid EQ 'TPACC2'>
					<option value = '2014' <cfif
					session.fy EQ 2014> selected</cfif>>2013-2014</option>
<cfelse> --->

				   <cfloop query="QsetDispFY">
				   	<option value="#year2#" <cfif session.fy EQ year2> selected</cfif>>#display#</OPTION>
				   </cfloop>
<!--- </cfif> --->
				   </CFOUTPUT>
				<!---    <cfif QsetATFAC.recordcount GT 0 or session.userid is 'test_cc' or session.userid is 'dplotner' or session.userid is 'mchambard' or session.userid is 'nsarris' or session.userid is 'lolson'
				    or session.userid is 'eas10'  or session.userid is 'hbb01'  or session.userid is 'hrc01'  or session.userid is 'vxc04'  or session.userid is 'christina.peluso'  or session.userid is 'sep06'  or session.userid is 'hxr03'  or session.userid is 'yct01'  or session.userid is 'julie.wright'
				   or (isDefined("session.origUserID") and (session.origUserID is 'test_cc' or session.origUserID is 'dplotner' or session.origUserID is 'mchambard' or session.origUserID is 'nsarris' or session.origUserID is 'lolson'
				   or  session.origUserid is 'eas10'  or session.origUserid is 'hbb01'  or session.origUserid is 'hrc01'  or session.origUserid is 'vxc04'  or session.origUserid is 'christina.peluso'  or session.origUserid is 'sep06'  or session.origUserid is 'hxr03'  or session.origUserid is 'yct01'  or session.origUserid is 'julie.wright' ) )

				   >
<option value = '2016'<cfif session.fy EQ 2016> selected</cfif>>2015-2016</option>
</cfif> --->
<!--- <cfif
session.userid is 'test_cc' or session.userid is 'dplotner'  or session.userid is 'twills' or session.userid is 'mchambard' or session.userid is 'nsarris' or session.userid is 'lolson'	or (isDefined("session.origUserID") and (session.origUserID is 'test_cc' or session.origUserID is 'dplotner' or session.origUserID is 'twills' or session.origUserID is 'mchambard' or session.origUserID is 'nsarris' or session.origUserID is 'lolson'))>
<option value = '2017'<cfif session.fy EQ 2017> selected</cfif>>2016-2017</option>
</cfif> --->

<!---
<cfif (SESSION.areamanage EQ "1" OR SESSION.admin EQ "1" OR SESSION.TCP EQ "1" OR SESSION.CessMan CONTAINS "1") AND NOT (SESSION.modality EQ "2"  OR SESSION.modality EQ "3")>
	<option value="2018" <cfif session.fy EQ 2018> selected</cfif>>2017-2018</OPTION>
</cfif>
--->
					</select>


<!--- end new code --->

              </td>
            </cfform>
            <td width="10%" align="right"><a href="welcome.cfm"><img src="./images/cat5.gif" width="80" height="78" alt="CAT logo" border="0"></a> </td>
            <td align="center"><a href="welcome.cfm" STYLE="text-decoration: none"><font size="-2" color="#FFFFFF">New York State<br>
              Tobacco Control Program</font><br>
              <font color="White" size="+2"><strong>Community Activity Tracking</strong></font></a>

            </td>
            <td width="25%"><a href="welcome.cfm"><img src="./images/doh.jpg" width="128" height="44" alt="" border="0"></a> </td>
            <td nowrap align="right"><a href="logoff.cfm" class="topNav">Logoff</a></td>
          </tr>
        </table>
        <!-- End Heading table -->
      </TD>
    </tr>

    <tr>
      <td colspan="15" height="5"></td>
    </tr>
  </table>

  <!-- End universal horizontal navbar   -->
</div>



<div id="ddtopmenubar" class="mattsalmonmenu ">
<ul>


	<cfif session.userid NEQ "mCase" AND session.userid NEQ "mgallagher">


	<cfif session.readOnly EQ 0>
	<li><a href="admin_m.cfm?<cfoutput>#session.urltoken#</cfoutput>" rel="ddsubmenu7">Administration</a></li>
	<cfif session.fy GTE '2010' and #session.modality# is not 4>
            <li><a href="cat_work.cfm?<cfoutput>#session.urltoken#</cfoutput>" <cfif #session.fy# GTE '2010' and #session.modality# is not 4><cfelse> rel="ddsubmenu8"</cfif>>Work Plan</a></li>
    <cfelse>
            <cfif session.fy LT 2011 OR session.modality NEQ 4>
				<li><a href="Annual_m.cfm?<cfoutput>#session.urltoken#</cfoutput>" rel="ddsubmenu8">Annual Plans</a></li>
			</cfif>
   	</cfif>
	</cfif>
	<cfif isdefined("session.fy") and #session.fy# is '2010' and SESSION.modality NEQ 4>
            <li><a href="monthrep.cfm?<cfoutput>#session.urltoken#</cfoutput>">Monthly Reporting</a></li>
	<cfelse>
           <!--- <cfif session.fy LT 2011 or session.userid EQ 'dplotner'> ---><li><a href="activ_list.cfm?<cfoutput>#session.urltoken#</cfoutput>">Monthly Reporting</a></li><!--- </cfif> --->
	</cfif>
	</cfif>






	<li><a href="reports.cfm?<cfoutput>#session.urltoken#</cfoutput>" rel="ddsubmenu9">Reports</a></li>
	<cfif session.fy LT 2010 AND (session.cntMan EQ 1 OR ((SESSION.modality NEQ 1 AND SESSION.modality NEQ 4) or SESSION.TCP EQ "1"  or  SESSION.admin EQ "1" or  SESSION.areamanage EQ "1") and session.cessman NEQ 4 and session.cessman NEQ 1)>
              <li><a href="Evaluations.cfm?<cfoutput>#session.urltoken#</cfoutput>">Local Level Evaluation</a></li>
    </cfif>
	<cfif (session.fy LT 2011 and (session.cntMan EQ 1 OR ((SESSION.modality EQ 4 or SESSION.TCP EQ "1" or  SESSION.admin EQ "1" or  SESSION.areamanage EQ "1") and session.cessman NEQ 1  and session.cessman NEQ 2 and session.cessman NEQ 3))) >
             <li><a href="qsp_menu.cfm">School Policy Outcomes</a></li>
    </cfif>
    <cfif session.fy LT 2010 AND (session.cntMan EQ 1 OR ((SESSION.modality EQ 1 or SESSION.TCP EQ "1"  or  SESSION.admin EQ "1" or  SESSION.areamanage EQ "1") and session.cessman NEQ 4  and session.cessman NEQ 2 and session.cessman NEQ 3))>
         <li><a href="qcess_menu.cfm?<cfoutput>#session.urltoken#</cfoutput>">Cessation Center Outcomes</a></li>
    </cfif>
	<!--- <li><a href="other_m.cfm?<cfoutput>#session.urltoken#</cfoutput>" rel="ddsubmenu10">Other</a></li> --->
</div>



<script type="text/javascript">
ddlevelsmenu.setup("ddtopmenubar", "topbar") //ddlevelsmenu.setup("mainmenuid", "topbar|sidebar")
</script>



<ul id="ddsubmenu7" class="ddsubmenustyle">

<cfif #session.fy# GTE '2010' and #session.modality# is not 4>
	<li><a href="cat_wrkplan.cfm?<cfoutput>#session.urltoken#</cfoutput>">Contact Info</a></li>
		<cfif (session.fy GT 1920 AND session.fy LT 2007) and session.modality NEQ 5>
			<li><a href="collaborators.cfm?<cfoutput>#session.urltoken#</cfoutput>"Collaborators</a></li>
		<cfelseif  (session.modality NEQ 2 and session.modality NEQ 3 and session.modality NEQ 5)>
			<cfif !(session.modality EQ 1 and session.fy GTE 2013)>
			<li><a href="collaborators.cfm?<cfoutput>#session.urltoken#</cfoutput>"><cfif session.modality EQ 1>Target HCPOs<cfelseif session.modality EQ 4>Target Schools and Districts<cfelse>Collaborators</cfif></a></li>
			</cfif>
		</cfif>
		<cfif SESSION.admin EQ "1">
			<li><a href="announcements.cfm?<cfoutput>#session.urltoken#</cfoutput>">Edit Announcements</a></li>
			<li><a href="admin.cfm?<cfoutput>#session.urltoken#</cfoutput>">Update Users</a></li>
			<cfif session.fy LT 2010><li><a href="extension_manager.cfm?<cfoutput>#session.urltoken#</cfoutput>">Extensions</a></li></cfif>
			<li><a href="./cfforum/admin">Bulletin Board Admin</a></li>
		</cfif>
		<cfif SESSION.areamanage EQ "1" OR SESSION.admin EQ "1" OR SESSION.TCP EQ "1" >
			<li><a href="alteruser.cfm?<cfoutput>#session.urltoken#</cfoutput>">View Contractor Data</a></li>
		</cfif>
	<cfif SESSION.areamanage EQ "1" OR SESSION.admin EQ "1" OR SESSION.TCP EQ "1" >
		<li><a href="AM_Feedback_list.cfm?<cfoutput>#session.urltoken#</cfoutput>"><cfif session.fy LTE 2008>Area<Cfelse>Contract</cfif> Manager Feedback</a></li>
	</cfif>
		<cfif ((session.fy eq "2009" and now() GTE "5/15/2009"))>
			<cfif SESSION.areamanage EQ "1" OR SESSION.admin EQ "1" OR SESSION.TCP EQ "1" OR SESSION.CessMan CONTAINS "1" or session.areamanage EQ 1 or session.admin eq 1>
				<li><a href="AM_EOY_Feedback_list.cfm?<cfoutput>#session.urltoken#</cfoutput>">TCP EOY Feedback
			<cfelseif now() GTE "12/15/2009">
				<cfif session.modality eq 1>
					<li><a href="cc_eoy_progress.cfm?modality=cc&<cfoutput>#session.urltoken#</cfoutput>">EOY Reports</a></li>
				<cfelseif session.modality eq 2>
					<li><a href="cp_eoy_progress.cfm?modality=cp&<cfoutput>#session.urltoken#</cfoutput>">EOY Reports</a></li>
				<cfelseif session.modality eq 3>
					<li><a href="yp_eoy_progress.cfm?modality=yp&<cfoutput>#session.urltoken#</cfoutput>">EOY Reports</a></li>
				<cfelseif session.modality eq 4>
					<li><a href="eoy_progress.cfm?modality=sp&<cfoutput>#session.urltoken#</cfoutput>">EOY Reports</a></li>
				</cfif>
			</cfif>
</cfif>

<cfif session.userid EQ "bmarkatos" or session.userid EQ "dplotner" or session.userid EQ "kmcaleer" or session.userid EQ "nsarris">
	<li><a href="./qbrowser/">Query Tool</a></li>
</cfif>

<cfelse>

	<li><a href="cat_wrkplan.cfm?<cfoutput>#session.urltoken#</cfoutput>">Contact Info</a></li>
<cfif (session.fy GT 1920 AND session.fy LT 2007)>
	<li><a href="collaborators.cfm?<cfoutput>#session.urltoken#</cfoutput>">Collaborators</a></li>
<cfelseif session.modality NEQ 2 and session.modality NEQ 3>
	<li><a href="collaborators.cfm?<cfoutput>#session.urltoken#</cfoutput>"><cfif session.modality EQ 1>Target HCPOs<cfelseif session.modality EQ 4>Target Schools and Districts<cfelse>Collaborators</cfif></a></li>
</cfif>
	<cfif SESSION.admin EQ "1">
		<li><a href="announcements.cfm?<cfoutput>#session.urltoken#</cfoutput>">Edit Announcements</a></li>
		<li><a href="admin.cfm?<cfoutput>#session.urltoken#</cfoutput>">Update Users</a></li>
		<cfif session.fy LT 2010><li><a href="extension_manager.cfm?<cfoutput>#session.urltoken#</cfoutput>">Extensions</a></li></cfif>
		<li><a href="./cfforum/admin">Bulletin Board Admin</a></li>
	</cfif>
	<cfif SESSION.areamanage EQ "1" OR SESSION.admin EQ "1" OR SESSION.TCP EQ "1" >
		<li><a href="alteruser.cfm?<cfoutput>#session.urltoken#</cfoutput>">View Contractor Data</a></li>
	</cfif>
	<cfif SESSION.areamanage EQ "1" OR SESSION.admin EQ "1" OR SESSION.TCP EQ "1" >
		<li><a href="AM_Feedback_list.cfm?<cfoutput>#session.urltoken#</cfoutput>"><cfif session.fy LTE 2008>Area<Cfelse>Contract</cfif> Manager Feedback</a></li>
	</cfif>
	<cfif ((session.fy eq "2009" and now() GTE "5/15/2009"))>
	<cfif SESSION.areamanage EQ "1" OR SESSION.admin EQ "1" OR SESSION.TCP EQ "1" OR SESSION.CessMan CONTAINS "1" or session.areamanage EQ 1 or session.admin eq 1>
		<li><a href="AM_EOY_Feedback_list.cfm?<cfoutput>#session.urltoken#</cfoutput>">TCP EOY Feedback</a></li>
	<cfelse>
	</cfif>
</cfif>
<cfif session.userid EQ "bmarkatos" or session.userid EQ "dplotner" or session.userid EQ "kmcaleer" or session.userid EQ "nsarris">
	<li><a href="./qbrowser/">Query Tool</a></li>
</cfif>
</cfif>
</ul>



<ul id="ddsubmenu8" class="ddsubmenustyle">
<cfif #session.fy# GTE '2010' and #session.modality# is not 4>
	<!---<li><a href="cat_work.cfm?<cfoutput>#session.urltoken#</cfoutput>">Enter Work Plan</a></li>--->
<cfelse>
	<li><a href="cat_annual.cfm?<cfoutput>#session.urltoken#</cfoutput>">New Strategy</a></li>
	<li><a href="annual_list.cfm?<cfoutput>#session.urltoken#</cfoutput>">Edit Strategy</a></li>
	<li><a href="rem_strategy.cfm?<cfoutput>#session.urltoken#</cfoutput>">Delete Strategy</a></li>
</cfif>
</ul>

<ul id="ddsubmenu9" class="ddsubmenustyle">
<cfif SESSION.userid EQ "kcdavis" OR SESSION.userid EQ "dplotner" or SESSION.userid EQ "lxk03" or SESSION.userid EQ "dvx06" or SESSION.userid EQ "bmarkatos" or SESSION.userid EQ "rav02">
	<li><a href="kevin.cfm?<cfoutput>#session.urltoken#</cfoutput>">PM Report</a></li>
</cfif>
<cfif session.cntMan EQ 1 OR (session.modality NEQ 4 and session.modality NEQ 1) or session.admin EQ 1 or session.tcp EQ 1 or session.areamanage EQ 1 or session.statemanage EQ 1 or session.regionmanage EQ 1><cfif session.cntMan EQ 1 OR session.cessman NEQ 4>
	<cfif session.fy LT 2010>
		<li><a href="reporthandler_mod.cfm?<cfoutput>#session.urltoken#</cfoutput>">Youth Partners, Cessation Centers and Community Partnerships</a></li>
	<cfelse>
		<li><a href="reporthandler_mod2.cfm?<cfoutput>#session.urltoken#</cfoutput>"><cfif session.fy gte 2015>ATFC<cfelse>Reality Check and Community Partnerships</cfif><cfif session.fy LT 2012> and Colleges 4 Change</cfif></a></li>
	</cfif>
</cfif>

<cfif session.userid EQ 'dplotner' OR session.userid EQ 'nsarris'   or session.userid EQ 'aal07' or session.userid eq 'djf05'>
	<li><a href="reporthandler_modSP.cfm?<cfoutput>#session.urltoken#</cfoutput>">School Policy Partners</a></li>
</cfif>

</cfif>
<cfif session.fy GTE 2010>
	<cfif session.cntMan EQ 1 OR session.modality EQ 1 or session.admin EQ 1 or session.tcp EQ 1 or session.areamanage EQ 1 or session.statemanage EQ 1 or session.regionmanage EQ 1>
		<cfif session.cntMan EQ 1 OR session.cessman NEQ 4 OR  session.origUserID EQ "amw06">
			<li><a href="reporthandler_mod3.cfm?<cfoutput>#session.urltoken#</cfoutput>"><cfif session.fy gte 2015>Health Systems Change<cfelse>Cessation Centers</cfif></a></li>
		</cfif>
	</cfif>
</cfif>

<cfif session.userid NEQ 'mgallagher'>


<cfif session.cntMan EQ 1 OR session.modality EQ 4 or session.admin EQ 1 or session.tcp EQ 1 or session.areamanage EQ 1 or session.statemanage EQ 1 or session.regionmanage EQ 1>

	<cfif session.userid EQ 'dplotner' OR session.userid EQ 'nsarris'   or session.userid EQ 'aal07' or session.userid eq 'djf05'>
	<li><a href="reporthandler_modSP.cfm?<cfoutput>#session.urltoken#</cfoutput>">School Policy Partners</a></li>
	</cfif>
</cfif>
<cfif session.modality NEQ 4>
	<li><a href="histdata.cfm?<cfoutput>#session.urltoken#</cfoutput>">First 5 years CAT data</a></li>
</cfif>
</cfif>
<!--- <cfif session.modality EQ 4 or session.admin EQ 1 or session.tcp EQ 1 or session.areamanage EQ 1 or session.statemanage EQ 1 or session.regionmanage EQ 1>
	<cfif session.cessman DOES NOT CONTAIN 1 and session.cessman DOES NOT CONTAIN 2 and session.cessman DOES NOT CONTAIN 3 and session.cessman DOES NOT CONTAIN 5>
		<li><a href="SPreport.cfm?<cfoutput>session.urltoken</cfoutput>">School Staff Tobacco Survey Summary Reports</a></li>
	</cfif>
</cfif> --->
</ul>



<ul id="ddsubmenu10" class="ddsubmenustyle">
<li><a href="welcome.cfm?<cfoutput>#session.urltoken#</cfoutput>">Announcements</a></li>
<li><a href="./cfforum/login.cfm?userid=<cfoutput>#session.userid#</cfoutput>">Bulletin Board</a></li>
<!--- <li><a href="Contacts.cfm?<cfoutput>#session.urltoken#</cfoutput>">Contacts</a></li> --->
<!--- <li><a href="./manual/NYTCP Strategic Plan 2008-2010.doc">2008-2010 TCP Work Plan</a></li> --->
<!--- <li><a href="./manual/Non TCP Staff Contact List 100209.doc">TCP Staff List</a></li> --->
<cfif session.userid  EQ 'dplotner' or session.userid  EQ 'girlando'>
	<li><a href="tempreprts.cfm?userid=<cfoutput>#session.userid#</cfoutput>">Demo Reports</a></li>
</cfif>
</ul>
