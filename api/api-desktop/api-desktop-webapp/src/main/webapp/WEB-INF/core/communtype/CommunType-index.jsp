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
    <script type="text/javascript" src="core/communtype/CommunType-js.js"></script>
	<script type="text/javascript">
		function doNew(){
			var retValue=openDialogFrame("<%=basePath%>core/communtype/CommunType-add.jsp","","400","150");
			if(retValue=="true"){
				msgShow("新增","新增成功!","info");
				flashTable("idtableCommunType");
			}else if(retValue=="false"){
			   msgShow("新增","新增失败!","error");
			}
		}
		
		
		function doEdit(){
			var ids=updateValidate("idtableCommunType");
		    if(ids){
		    	var retValue=openDialogFrame("<%=basePath%>core/communtype/CommunType-edit.jsp",ids,"400","150");
				if(retValue=="true"){
					msgShow("修改","修改成功!","info");
					flashTable("idtableCommunType");
				}else if(retValue=="false"){
			       msgShow("修改","修改失败!","error");
			    }
		    }
			
		}
		
		function doDel(){
		 deleteNoteById("idtableCommunType","delCommunType.do", "");
		}
		
		function queryInfo(){
		 	   clearSelect('idtableCommunType');//防止页面选定一条记录后进行查询，原来的选定还存在，导致修改时选定多条
		 	  
		       var date=new Date();
			var param="flag="+date.getTime()+"&SYS_ID="+escape(escape($.trim($('#idSysId').val())))+"&COMMUN_TYPE="+escape(escape($.trim($('#idCommunType').val())))+"&COMMUN_DETAIL="+escape(escape($.trim($('#idCommunDetail').val())));		
				   $('#idtableCommunType').datagrid('options').url = "listCommunType.do?"+param;// 改变它的url  
			   $("#idtableCommunType").datagrid('load');
		}
		function cleardata(){
			$('#queryForm').form('clear');
		}
	</script>
</head>

<body class="easyui-layout" fit="true">

	    <div region="north" style="height: 70px;position:relative;" title="查询面板"  split="true">  
					<form id="queryForm">
				<table class="formTable" style="width:95%;">
				<col  width="50px" class="leftCol"/>
				<col width="200px" >

				<col  width="50px" class="leftCol"/>
				<col width="200px" >
                <col  width="50px" class="leftCol"/>
				<col width="200px" >


							<tr>
								
								<td>通讯方式</td>
								<td>
									<input type="text" name="COMMUN_TYPE" id="idCommunType" maxlength="100" />
								</td>
								<td>通讯配置</td>
								<td>
									<input type="text" name="COMMUN_DETAIL" id="idCommunDetail" maxlength="100" />
								</td>
						
							<td>
							     <input id="idQuery" type="button" class="btn_grid" value=" 查 询 " onclick="queryInfo()"/>
							 </td>
							 <td>
							     <input id="idReset" type="button" class="btn_grid" value=" 重 置 " onclick="cleardata()"/>
							</td>
							
						</table>
					</form>
	     </div>
		<div region="center" >  
			<table id="idtableCommunType" ></table>
	    </div>
	      <div region="south" style="height: 30px;position:relative;background:url('<%=basePath%>images/indexbg.png') repeat;">  
			<div id="toolbar"></div>
	     </div>
</body>

</html>
