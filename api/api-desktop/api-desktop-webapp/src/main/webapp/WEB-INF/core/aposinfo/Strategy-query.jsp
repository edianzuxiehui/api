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
	<title>策略管理</title>
	<link rel="stylesheet" type="text/css" href="themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="themes/icon.css">
	<link rel="stylesheet" type="text/css" href="css/default.css">
	<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="js/common.js"></script>
    <script type="text/javascript" src="core/aposinfo/Strategy-query.js"></script>
	<script type="text/javascript">
	function chooseStrategy() {
		var row = $('#idStrategy').datagrid('getSelected');
		if(row==null) {
			msgShow("提示","请选择策略","info");
		}else{
			var aposNum = $('#idAposNum').val();
			if(aposNum!='') {
				var available = row.AVAILABLE;
				if(parseInt(aposNum)>parseInt(available)) {
					msgShow('提示','该策略剩余可接入数小于应用终端生成数量['+available+'<'+aposNum+']，请重新选择其他策略','info');
					return false;
				}
			}
			
			var strategyId = row.KEYID.substring(0,row.KEYID.indexOf('/'));
		    window.returnValue=strategyId;
		    window.close();
		}
	}
	</script>
</head>

<body class="easyui-layout" fit="true">
		<div region="center"  >  
			<table id="idStrategy" ></table>
	    </div>
	    <div region="south" style="text-align:right;" class="toolbarHeader">
	    	<input type="hidden" name="APOS_NUM" id="idAposNum" value="" />
	    	<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="chooseStrategy()">确认</a>
			<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="javascript:window.close()">取消</a>
	    </div>
</body>

</html>
