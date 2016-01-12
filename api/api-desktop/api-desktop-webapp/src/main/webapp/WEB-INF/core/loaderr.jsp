<%@ page language="java" contentType="text/html;charset=utf-8" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<HTML>
<HEAD>
<TITLE>错误
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<SCRIPT>
function backValue(value) {
		parent.window.returnValue = value ;
		parent.window.close();
}
function fnInit(){
    //alert(1111);
	//var msg = window.dialogArguments;
	var msg="<html:errors />";
	//alert(msg);
	oArgs.innerHTML = msg;
}
window.onload=fnInit;
</SCRIPT>
<style type="text/css">
td{
	font-size:12px;font-weight:bold;
}
span{
	font-size:12px;
}
</style>
</HEAD>
<BODY BGCOLOR="menu" 
LINK="#FFFFFF" VLINK="#808080" ALINK="#000000" leftmargin="0" topmargin="0" rightmargin="0" scroll="no" BGPROPERTIES="FIXED" marginwidth="0" marginheight="0">
<table width="100%" height="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td align="center">&nbsp;</td>
  </tr>
  <tr> 
    <td align="center"> <table width="90%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td align="right"><img src="images/error.gif" width="64" height="64" hspace="20" align="absmiddle"></td>
          <td width="100%">错误:<span ID="oArgs"></SPAN></td>
        </tr>
      </table></td>
  </tr>
  <tr> 
    <td height="50" align="center">
	<table width="95%" border="0" cellspacing="0" cellpadding="0">
        <tr align="center"> 
          <td> 
            <hr>
          </td>
        </tr>
        <tr> 
          <td align="right"><button accesskey="Y" onClick="window.close()">确 定(<u>Y</u>)</button></td>
        </tr>
      </table></td>
  </tr>
</table>
</BODY>
</HTML>
