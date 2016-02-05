<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<meta http-equiv="X-UA-Compatible" content="IE=6">
<html>
<head>
  <base href="<%=basePath%>">
  <base target="_self">
	<title>新增任务</title>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/icon.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/default.css">
	<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/common.js"></script>
</head>
<body class="easyui-layout" fit="true">
<!-- 
	<div region="center" id="tt" class="easyui-tabs" tools="#tab-tools" style="width:700px;height:250px;">
		<div title="逐条新增" closable="false" style="overflow:hidden">
			<iframe scrolling="yes" frameborder="0"  src="<%=basePath%>/core/taskinfo/taskinfo-add-detail.jsp" style="width:100%;height:100%;"></iframe>
		</div>
		<div title="批量新增" closable="false" selected="true" style="overflow:hidden">
			<iframe scrolling="yes" frameborder="0"  src="<%=basePath%>/core/taskinfo/taskinfo-add-batch.jsp" style="width:100%;height:100%;"></iframe>
		</div>
	</div>
 -->
 <div region="center" style="width:700px;height:250px;">
		<div title="批量新增" closable="false" selected="true" style="overflow:hidden">
			<iframe scrolling="yes" frameborder="0"  src="<%=basePath%>/core/taskinfo/taskinfo-add-batch.jsp" style="width:100%;height:100%;"></iframe>
		</div>
 </div>
	<div region="south" style="text-align:right;" class="toolbarHeader">
		<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="javascript:window.close()">关闭</a>
	</div>
</body>
</html>
