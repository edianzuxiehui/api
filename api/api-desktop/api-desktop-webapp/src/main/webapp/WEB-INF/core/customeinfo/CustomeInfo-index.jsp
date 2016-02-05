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
    <script type="text/javascript" src="core/customeinfo/CustomeInfo-js.js"></script>
	<script type="text/javascript">
		function doNew(){
			var retValue=openDialogFrame("<%=basePath%>core/customeinfo/CustomeInfo-add.jsp","","500","250");
			if(retValue=="true"){
				msgShow("新增","新增成功!","info");
				flashTable("idCustomeInfo");
			}else if(retValue=="false"){
			   msgShow("新增","新增失败!","error");
			}
		}
		
		
		function doEdit(){
			var ids=updateValidate("idCustomeInfo");
		    if(ids){
		    	var retValue=openDialogFrame("<%=basePath%>core/customeinfo/CustomeInfo-edit.jsp",ids,"500","250");
				if(retValue=="true"){
					msgShow("修改","修改成功!","info");
					flashTable("idCustomeInfo");
				}else if(retValue=="false"){
			       msgShow("修改","修改失败!","error");
			    }
		    }
			
		}
		
		function doDel(){
		 deleteNoteById("idCustomeInfo","delCustomeInfo.do", "");
		}
		
		function queryInfo(){
		 	   clearSelect('idCustomeInfo');//防止页面选定一条记录后进行查询，原来的选定还存在，导致修改时选定多条
		       var date=new Date();
			var param="flag="+date.getTime()+"&LASTLOGIN="+escape(escape($.trim($('#idLastlogin').val())))+"&CUSTOMEID="+escape(escape($.trim($('#idCustomeId').val())))+"&CUSTOME_NAME="+escape(escape($.trim($('#idCustomeName').val())));			   
			$('#idCustomeInfo').datagrid('options').url = "listCustomeInfo.do?"+param;// 改变它的url  
			   $("#idCustomeInfo").datagrid('load');
		}
		function cleardata(){
			$('#queryForm').form('clear');
		}
	</script>
</head>

<body class="easyui-layout" fit="true">
<script language="javascript" type="text/javascript" src="<%=basePath%>js/DatePicker/WdatePicker.js"></script>
	    <div region="north" style="height: 50px;position:relative;"   split="true">  
					<form id="queryForm">
						<table class="formTable" style="width:95%;">
				<col  width="80px" class="leftCol"/>
				<col width="200px" >

				<col  width="80px" class="leftCol"/>
				<col width="200px" >

				<col width="150px" >

							<tr>
								<td>客服编号</td>
								<td>
									<input type="text" name="CUSTOME_ID" id="idCustomeId"  maxlength="8" />
								</td>
								<td>客服用户名</td>
								<td>
									<input type="text" name="CUSTOME_NAME" id="idCustomeName" maxlength="30" />
								</td>
								<td >
							     <input id="idQuery" type="button" class="btn_grid" value=" 查 询 " onclick="queryInfo()"/>
							     <input id="idReset" type="button" class="btn_grid" value=" 重 置 " onclick="cleardata()"/>
							</td>
							</tr>
						</table>
					</form>
	     </div>
		<div region="center" border="false" >  
			<table id="idCustomeInfo" ></table>
	    </div>
	      <div region="south" border="false" style="height: 30px;position:relative;background:url('<%=basePath%>images/indexbg.png') repeat;">  
			<div id="toolbar"></div>
	     </div>
</body>

</html>
