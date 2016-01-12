<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<meta http-equiv="X-UA-Compatible" content="IE=8">
<html>
<head>
  <base href="<%=basePath%>">
	<title></title>
	<link rel="stylesheet" type="text/css" href="themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="themes/icon.css">
	<link rel="stylesheet" type="text/css" href="css/default.css">
	<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="js/Toolbar.js"></script>
    <script type="text/javascript" src="js/common.js"></script>
    <script type="text/javascript" src="core/realrole/Realrole-js.js"></script>
	<script type="text/javascript">
		function doNew(){
			var retValue=openDialogFrame("<%=basePath%>core/realrole/Realrole-add.jsp","","400","200");
			if(retValue=="true"){
				msgShow("新增","新增成功!","info");
				flashTable("idRealrole");
			}else if(retValue=="false"){
			   msgShow("新增","新增失败!","error");
			}
		}
		
		function doDel(){
			deleteNoteById("idRealrole","delRealrole.do", "");
			$('#currentRealRole').val('');//重置隐藏域
		}
	</script>
</head>

<body class="easyui-layout" fit="true">
	    <div region="west" style="padding:2px;width:470px;">
	    	<table id="idRealrole"></table>
	    </div>
	    <div region="center" style="padding:2px;" border="false">
	    	<input type="hidden" id="currentRealRole" name="currentRealRole" value="" />
	    	<table id="idRealsub"></table>
	    </div>
	      <div region="south" border="false" style="height: 30px;position:relative;background:url('<%=basePath%>images/indexbg.png') repeat;">  
			<div id="toolbar"></div>
	     </div>
</body>

</html>
