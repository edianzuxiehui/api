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
	<title>新增应用终端</title>
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
	   	window.frames["ModelTab"].location.href="<%=basePath%>core/aposinfo/addAposFromAposModel.jsp";
	   	window.frames["DetailTab"].location.href="<%=basePath%>core/aposinfo/addAposFromAppDetail.jsp";
		
		$('#tt').tabs({
			fit:true,
			onSelect:function(title){
				if($.trim(title)=="由明细生成") {
					var aposId = window.frames["DetailTab"].document.getElementById('idAposId').value;
					if($.trim(aposId)=="") {
						//获取应用终端号
			 			$.ajax({
			   				type:"POST",
			   				url:"getMaxId.do",
			   				data:{sequeceId:'APOS_ID'},
			   				success:function(data){
								window.frames["DetailTab"].document.getElementById('idAposId').value=data;
			   				},
			   				error:function(data){
			   					msgShow("获取Id错误",data,"error");
			   				}
						});
					}					
				}
			}
		});
	});
	function beforeUnload() {
		var title = $('#tt').tabs('getSelected').panel('options').title;
		if(title=='由明细生成') {
			window.frames["DetailTab"].doCheck(event);
		}
	}
	</script>
</head>
<body onbeforeunload="beforeUnload()">
	<div id="tt" >
		<div title="由模板生成" cache="true">
			<iframe id="idModelTab" name="ModelTab" scrolling="no" frameborder="0"  src="" style="width:100%;height:100%;"></iframe>
		</div>  
		<div title="由明细生成" cache="true">  
			<iframe id="idDetailTab" name="DetailTab" scrolling="no" frameborder="0"  src="" style="width:100%;height:100%;"></iframe>
		</div>
	</div>
</body>
</html>
