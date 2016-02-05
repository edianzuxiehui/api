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
	<title>选择权限组</title>
	<link rel="stylesheet" type="text/css" href="themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="themes/icon.css">
	<link rel="stylesheet" type="text/css" href="css/default.css">
	<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="js/common.js"></script>
    <script type="text/javascript" src="core/realrole/Realrole-query.js"></script>
	<script type="text/javascript">
		function cleardata() {
			$('#queryForm').form('clear');
		}
		
		function queryInfo() {
			var date=new Date();
			var param="flag="+date.getTime()+"&REALROLEID="+escape(escape($.trim($('#idRealroleId').val())))
							+"&REALROLENAME="+escape(escape($.trim($('#idRealroleName').val())))
							+"&INCLUDE="+$.trim($('#idInclude').val());
			$('#idRealrole').datagrid('options').url = "listRealrole.do?"+param;
			$("#idRealrole").datagrid('load');
		}
		
		function chooseRealrole() {
			var row = $('#idRealrole').datagrid('getSelected');
			if(row==null) {
				msgShow("提示","请选择权限组","info");
			}else{
			    window.returnValue=row.REALROLEID+"_"+row.NAME;
			    window.close();
			}
		}
	</script>
</head>

<body class="easyui-layout" fit="true">
	    <div region="north" style="padding:2px;height:60px;">
	    	<form id="queryForm">
						<table style="width:95%;height:50px;">
							<tr>
								<td>权限组编号</td>
								<td>
									<input type="hidden" name="INCLUDE" id="idInclude" value="0"/>
									<input type="text" name="REALROLEID" id="idRealroleId" maxlength="10" />
								</td>
								<td>权限组名称</td>
								<td>
									<input type="text" name="REALROLENAME" id="idRealroleName" maxlength="20" />
								</td>
								<td>
									<a href="javascript:void(0)" class="easyui-linkbutton"  icon="icon-search" onclick="queryInfo()">查找</a>
									<a class="easyui-linkbutton" iconCls="icon-redo" href="javascript:void(0);" onclick="cleardata()">重置</a>
								</td>
							</tr>
						</table>
					</form>
	    </div>
	    <div region="center" style="padding:2px;">
	    	<table id="idRealrole"></table>
	    </div>
	    <div region="south" style="text-align:right;" class="toolbarHeader">
	    	<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="chooseRealrole()">确认</a>
			<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="javascript:window.close()">取消</a>
	    </div>
</body>

</html>
