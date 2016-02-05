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
	<title></title>
	<link rel="stylesheet" type="text/css" href="themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="themes/icon.css">
	<link rel="stylesheet" type="text/css" href="css/default.css">
	<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="js/Toolbar.js"></script>
    <script type="text/javascript" src="js/common.js"></script>
    <script type="text/javascript" src="core/onlinetype/OnlineType-js.js"></script>
	<script type="text/javascript">
		function doNew(){
			var retValue=openDialogFrame("<%=basePath%>core/onlinetype/OnlineType-add.jsp","","600","300");
			if(retValue=="true"){
				msgShow("新增","新增成功!","info");
				flashTable("idOnlineType");
			}else if(retValue=="false"){
			   msgShow("新增","新增失败!","error");
			}
		}
		
		
		function doEdit(){
			var ids=updateValidate("idOnlineType");
		    if(ids){
		    	var retValue=openDialogFrame("<%=basePath%>core/onlinetype/OnlineType-edit.jsp",ids,"600","300");
				if(retValue=="true"){
					msgShow("修改","修改成功!","info");
					flashTable("idOnlineType");
				}else if(retValue=="false"){
			       msgShow("修改","修改失败!","error");
			    }
		    }
			
		}
		
		function doDel(){
		 deleteNoteById("idOnlineType","delOnlineType.do", "");
		}
		
		function queryInfo(){
		 	   clearSelect('idOnlineType');//防止页面选定一条记录后进行查询，原来的选定还存在，导致修改时选定多条
		       var date=new Date();
			var param="flag="+date.getTime()+"&TRAN_TYPE="+escape(escape($.trim($('#idTranType').val())))+"&TRAN_NAME="+escape(escape($.trim($('#idTranName').val())));			   $('#idOnlineType').datagrid('options').url = "listOnlineType.do?"+param;// 改变它的url  
			   $("#idOnlineType").datagrid('load');
		}
		function cleardata(){
			$('#queryForm').form('clear');
		}
	</script>
</head>

<body class="easyui-layout" fit="true">
	    <div region="north" style="height: 100px;position:relative;" title="查询面板"  split="true">  
					<form id="queryForm">
						<table class="formTable" style="width:95%;">
				<col  width="50px" class="leftCol"/>
				<col width="250px" >

				<col  width="50px" class="leftCol"/>
				<col width="250px" >

				<col  width="50px" class="leftCol"/>
				<col width="250px" >

							<tr>
								<td>交易类型(pos联机交易)</td>
								<td>
									<input type="text" name="TRAN_TYPE" id="idTranType" maxlength="4" />
								</td>
								<td>交易名称</td>
								<td>
									<input type="text" name="TRAN_NAME" id="idTranName" maxlength="16" />
								</td>
							</tr>
						
							<tr>
							<td colspan="6">
							     <input id="idQuery" type="button" class="btn_grid" value=" 查 询 " onclick="queryInfo()"/>
							     <input id="idReset" type="button" class="btn_grid" value=" 重 置 " onclick="cleardata()"/>
							</td>
							</tr>
						</table>
					</form>
	     </div>
		<div region="center"  border="false">  
			<table id="idOnlineType" ></table>
	    </div>
	      <div region="south" border="false" style="height: 30px;position:relative;background:url('<%=basePath%>images/indexbg.png') repeat;">  
			<div id="toolbar"></div>
	     </div>
</body>

</html>
