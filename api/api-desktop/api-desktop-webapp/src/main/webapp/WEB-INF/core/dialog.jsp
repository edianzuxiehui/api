<%@ page language="java" contentType="text/html;charset=gb2312" %>

<html>
<head>
<%-- ����frame�Ի��򣬵��÷�����ο�funlib�е�openDialogFrame���� --%>
<title><%=request.getParameter("title")%>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</title>
	<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="js/common.js"></script>
<script language="JavaScript">
function getDialogFrmae(){
  if (dialogframe.subframe != null){
    return dialogframe.subframe;
  }
  else{
    return dialogframe;
  }
}

function defaultAction(actionName) {
  try {
    execFrameAction(getDialogFrmae(),actionName);
  }
  catch (e) {
    if (isNoObjectError(e)) {
      return true;
    }
    else
      showError(e);
  }
}

function setDialogButton(id,actionName) {
  var isExsit = methodIsExsit(getDialogFrmae(),actionName)
                var btn = document.getElementById(id);
  //btn.setEnabled(isExsit);
}

function loadAction() {
  setBody();
  setDialogButton('btnConfirm','onConfirm()');
  setDialogButton('btnApply','onSave()');
  dloading();
}

function viewHtml() {
  url = dialogframe.location;
  //dialogframe.location = "view-source:" + url;
}

function dloading() {
  document.all.tDialog.style.display ="block";
  document.all.tLoading.style.display ="none";
}

function setBody() {
  if(navigator.appName.indexOf('Microsoft') != -1){
    if(navigator.appVersion.indexOf('6.0') != -1){
      document.all.dialogframe.style.overflow="auto";
    }
  }
}
</script>

</head>
<body bgcolor="#FFFFFF" class="dialogBg" onload="loadAction()" style="overflow:hidden">
<table width="100%"  height="100%" border="0" cellpadding="0" cellspacing="0" id="tDialog">

<tr id="hideArea"><td height="1" bgcolor="#FFFFFF"></td></tr>

<tr><td height="100%">

<iframe name="dialogframe" marginwidth=0 marginheight=0 frameborder=0 scrolling="auto" style="width:100%;height:100%;" src="<%=request.getParameter("src")%>"></iframe>

</td></tr>
<tr id="toolbar"><td>

 <table width="100%" border="0" cellSpacing=0>
 <tr>
  <td height="1" bgcolor="#999999" colspan="2"></td>
 </tr>
 <tr>
  <td height="1" bgcolor="#eeeeee" colspan="2"></td>
 </tr>
 <tr>
  <td>
   <TABLE cellSpacing=0><TBODY><TR onselectstart="return false" height="40">
     <TD width="100%"></TD>
     <TD>
     <button  id=btnConfirm title="ȷ��" onclick="dialogframe.onConfirm()" class="blueBtn">
     <IMG src="images/buttons/button_yes.gif" width="16" height=20 align=absMiddle>&nbsp;ȷ ��
     </button>
     </TD>
     <TD><IMG width=20 src="images/spacer.gif" align=absMiddle></TD>
     <TD>
     <button  id=btnCancel title="ȡ��" onclick="window.close()" class="blueBtn">
     <IMG src="images/buttons/button_cancel.gif" width="16" height=20 align=absMiddle>&nbsp;ȡ ��
     </button>
     </TD>
     <TD><IMG width=5 src="images/spacer.gif" align=absMiddle></TD>
   </TR></TBODY></TABLE>
  </td>
  <td></td>
 </tr>
 </table>

</td></tr>
</table>
</body>
</html>
