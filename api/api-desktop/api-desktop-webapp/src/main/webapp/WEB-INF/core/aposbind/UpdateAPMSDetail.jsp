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
	<title>更新APMS同步数据</title>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/icon.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/default.css">
	<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/common.js"></script>
	<script type="text/javascript">
	$(function() {
		var k=window.dialogArguments; 
	   	if(k.tmsModuleTitle&&k.tmsModuleId){
	   		$("#idTmsModuleTitle").attr("value",k.tmsModuleTitle);
	   		$("#idTmsModuleId").attr("value",k.tmsModuleId);
	   	}
	   	//$('#idModelTab').attr('src',"<%=basePath%>core/aposinfo/addAposFromAppDetail.jsp");
	   	//$('#idDetailTab').attr('src',"<%=basePath%>core/aposinfo/addAposFromAppDetail.jsp");
	   	window.frames["idUpdateDev"].location.href="<%=basePath%>core/aposbind/UpdateAPMSDev-edit.jsp";
	   	window.frames["idUpdateApos"].location.href="<%=basePath%>core/aposbind/UpdateAPMSApos-edit.jsp";	
	   	
	   	
	   	$('#tt').tabs({
			fit:true
		});
	   	$('#tt').tabs('disableTab',1);
	   	
	});
		
	</script>
</head>
<body >
	<div id="tt" >
		<input type="hidden" name="tmsModuleId" id="idTmsModuleId" value=""/>
		<input type="hidden" name="tmsModuleTitle" id="idTmsModuleTitle" value=""/>
		<input type="hidden" id="idMid" name="Mid"/> 
		<div title="更新实体终端信息">  
			<iframe id="idUpdateDev" name="DetailTab" scrolling="no" frameborder="0"  src="" style="width:100%;height:100%;"></iframe>
		</div>
		<div title="更新应用终端信息">
			<iframe id="idUpdateApos" name="ModelTab" scrolling="no" frameborder="0"  src="" style="width:100%;height:100%;"></iframe>
		</div>  
		
	</div>
</body>
</html>
