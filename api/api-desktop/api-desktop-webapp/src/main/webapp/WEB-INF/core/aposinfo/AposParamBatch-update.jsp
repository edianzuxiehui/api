<%@ page language="java" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<meta http-equiv="X-UA-Compatible" content="IE=8">
<html>
<head>
<base href="<%=basePath%>">
<base target="_self">
<title>批量修改应用终端应用参数项</title>
<link rel="stylesheet" type="text/css" href="themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="themes/icon.css">
<link rel="stylesheet" type="text/css" href="css/default.css">
<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="js/jquery.bgiframe.js"></script>
<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="js/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="js/common.js"></script>
<script type="text/javascript" src="core/aposinfo/AposParamBatch-update.js"></script>
<script type="text/javascript">		

</script>
</head>

<body class="easyui-layout" fit="true">
	
	<div region="center">
		<table id="idBatchParamModelDetail"></table>
		<input type="hidden" id="idTmsModuleTitle"  name="tmsModuleTitle">
	    <input type="hidden" id="idTmsModuleId" name="tmsModuleId">
	</div>
	<div region="south" style="text-align: right;" class="toolbarHeader">
		<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="javascript:window.close()">关闭</a>
	</div>
</body>

</html>
