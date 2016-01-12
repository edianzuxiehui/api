<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
	String upid = request.getParameter("upid");
	if(upid == null || upid.trim().equals("")){
		upid = "1";
	}
 %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<meta http-equiv="X-UA-Compatible" content="IE=8">
<html>
<head>
  <base href="<%=basePath%>">
  <base target="_self">
	<title>选择分支机构</title>
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
	 	//创建分支机构树
		$(document).ready(function(){
			//取后台数据，以json返回zNodes
			$.getJSON("getRegInfoUpdate.do",{OLDUPID:$("#idOldUpRegId").attr("value")},function(data){
					if (null != data) {
						createTree(data);
					} else {
						msgShow('提示消息','载入分支机构信息失败！','warning');
					}
				}
			);
			
			
		});
		
		function createTree(zNodes) {
			var setting = {
				data: {
					simpleData: {
						enable: true
					}
				}
			};			
			$.fn.zTree.init($("#regTree"), setting, zNodes);
		}
		function queryReg(){
		
			var tree = $.fn.zTree.getZTreeObj('regTree');
		 	//判断当前是否选择了子角色
		 	var nodes = tree.getSelectedNodes();
		 	if(nodes.length==0) {
		 		msgShow("提示","请选择分支机构","info");
		 	}else if(nodes.length>1) {
		 		msgShow("提示","只能选择一个分支机构","info");
		 	}else{
		 		var returnObj = new Object();
		 		returnObj.reg_id=nodes[0].id;
		 		returnObj.reg_name=nodes[0].name+"("+nodes[0].id+")";
		 		returnObj.reg_entire_id=nodes[0].entire_id;
		 		window.returnValue=returnObj;
		 		window.close();
		 	}
		}
		
	</script>
</head>

<body class="easyui-layout" fit="true">  
		<div region="center" split="true" style="width:300px;padding:2px;"   >  
			<ul id="regTree" class="ztree"></ul>
	    </div>
	    <div region="south"   style="text-align:right;" class="toolbarHeader">
	   					<input type="hidden" name="OLD_UP_REG_ID" id="idOldUpRegId" value="<%=upid %>"/>
						<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="queryReg();">确认</a>
						<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="javascript:window.close()">取消</a>
		</div>
	    
</body>

</html>
