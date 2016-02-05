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
	<title>权限选择</title>
	<link rel="stylesheet" type="text/css" href="themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="themes/icon.css">
	<link rel="stylesheet" type="text/css" href="css/default.css">
	<link rel="stylesheet" type="text/css" href="css/zTreeStyle/zTreeStyle.css">
	<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="js/common.js"></script>
    <script type="text/javascript" src="js/jquery.ztree.all-3.1.min.js"></script>

	<script type="text/javascript">
		
		//创建子角色树 begin
		function showSubrole(reg_id) {
			var setting = {
				view: {
					showLine: false
				}
			};
			$.getJSON("getsubrole.do",{reg_id:reg_id},function(data) {
				if(data!=null) {
					var zNodes = data;
					buildTree('roleTree',setting,zNodes);
				}else{
					msgShow('提示消息','载入角色节点数据失败！','warning');
				}
			});
		}
		
		//页面加载完毕显示子系统角色树
		$(document).ready(function(){
			var reg_id = "";
			
			var darg = window.dialogArguments;
			if(darg.par!=undefined) {
				reg_id = darg.par.substring(darg.par.indexOf('reg_id=')+7);
			}
			
			showSubrole(reg_id);
		});
		//创建子角色树 end	
		
		function chooseSubrole() {
			var tree = getTree('roleTree');
			var nodes = tree.getSelectedNodes();
			if(nodes.length==0) {
				msgShow('提示','请选择角色','info');
			}else if(nodes.length>1) {
				msgShow('提示','只能选择一个角色','info');
			}else{
				var node = nodes[0];
				if(node.level!=1) {
					msgShow('提示','请选择角色','info');
					return false;
				}
				window.returnValue = node.id+"_"+node.name.substring(0,node.name.indexOf('('));
				window.close();
			}
		}
	</script>
</head>

<body class="easyui-layout">
	<div region="center" split="true" style="padding:2px;">
		<ul id="roleTree" class="ztree"></ul>
	</div>
	<div region="south" style="text-align:right;" class="toolbarHeader">  
		<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="chooseSubrole()">确认</a>
		<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="javascript:window.close()">取消</a>
	</div>
</body>

</html>
