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
  <base target="_self" >
	<title></title>
	<link rel="stylesheet" type="text/css" href="themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="themes/icon.css">
	<link rel="stylesheet" type="text/css" href="css/default.css">
	<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="js/common.js"></script>
    <script type="text/javascript" src="core/aposinfo/AppInfo-query.js"></script>
	<script type="text/javascript">
	function chooseApp() {
		var row = $('#idAppInfo').datagrid('getSelected');
		if(row==null) {
			msgShow("提示","请选择应用","info");
		}else{
		    window.returnValue=row.APP_ID+"_"+row.APP_NAME;
		    window.close();
		}
	}
		
		function queryInfo(){
			var date=new Date();
		    $('#idAppInfo').datagrid("clearSelections");
			var param="flag="+date.getTime()+"&APPID="+escape(escape($.trim($('#idAppId').val())))+"&APP_NAME="+escape(escape($.trim($('#idAppName').val())));			
			$('#idAppInfo').datagrid('options').url = "listAppInfo.do?"+param;// 改变它的url  
			$("#idAppInfo").datagrid('load');
		}
		function cleardata(){
			$('#queryForm').form('clear');
		}
	</script>
</head>

<body class="easyui-layout" fit="true">
	    <div region="north" style="height: 70px;" title="查询面板"  split="true">  
					<form id="queryForm">
						<table class="formTable" style="width:95%;">
		                <col  width="60" class="leftCol"/>
						<col width="100" >
						<col  width="60" class="leftCol"/>
						<col width="100" >
			           <col  width="60" class="leftCol"/>
						<col width="100" >
                 
							<tr>
								<td>应用编号</td>
								<td>
									<input type="text" name="APP_ID" id="idAppId" maxlength="8" />
								</td>
								<td>应用名称</td>
								<td>
									<input type="text" name="APP_NAME" id="idAppName" maxlength="30" />
								</td>
							   <td>
							     <input id="idQuery" type="button" class="btn_grid" value=" 查 询 " onclick="queryInfo()"/>
								</td>
							   <td>
							     <input id="idReset" type="button" class="btn_grid" value=" 重 置 " onclick="cleardata()"/>
							   </td>
							
							</tr>
						</table>
					</form>
	     </div>
		<div region="center"  >  
			<table id="idAppInfo" ></table>
	    </div>
	    <div region="south" style="text-align:right;" class="toolbarHeader">
	    	<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="chooseApp()">确认</a>
			<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="javascript:window.close()">取消</a>
	    </div>
</body>

</html>
