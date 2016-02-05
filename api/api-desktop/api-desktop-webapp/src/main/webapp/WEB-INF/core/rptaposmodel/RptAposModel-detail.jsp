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
  <base target="_self">
	<title>统计明细</title>
	<link rel="stylesheet" type="text/css" href="themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="themes/icon.css">
	<link rel="stylesheet" type="text/css" href="css/default.css">
	<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="js/common.js"></script>
    <script type="text/javascript" src="core/rptaposmodel/RptAposModel-detail.js"></script>
</head>

<body class="easyui-layout" fit="true">
	<div region="center"  >  
		<table id="idRptAposModelDetail"></table>
	</div>
	<div region="south" style="text-align:right;height:40px;" class="toolbarHeader">
		<a class="easyui-linkbutton"  href="javascript:void(0)" onclick="doExportForModel();">导出excel</a>&nbsp;&nbsp;
		<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="window.close();">关 闭</a>
	</div>
</body>
</html>
