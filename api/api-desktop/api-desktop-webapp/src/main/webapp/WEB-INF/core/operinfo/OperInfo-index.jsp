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
    <script type="text/javascript" src="js/common.js"></script>
    <script type="text/javascript" src="js/Toolbar.js"></script>
    <script type="text/javascript" src="core/operinfo/OperInfo-js.js"></script>
	<script type="text/javascript">
		function doNew(){
			var retValue=openDialogFrame("<%=basePath%>core/operinfo/OperInfo-add.jsp","","400","300");
			if(retValue=="true"){
				msgShow("新增","新增成功!","info");
				flashTable("idOperInfo");
			}else if(retValue=="false"){
			   msgShow("新增","新增失败!","error");
			}
		}
		
		
		
		function doEdit(){
			var ids=updateValidate("idOperInfo");
		    if(ids){
		    	var retValue=openDialogFrame("<%=basePath%>core/operinfo/OperInfo-edit.jsp",ids,"400","300");
				if(retValue=="true"){
					msgShow("修改","修改成功!","info");
					flashTable("idOperInfo");
				}else if(retValue=="false"){
			       msgShow("修改","修改失败!","error");
			    }
		    }
			
		}
		
		function doDel(){
		 deleteNoteById("idOperInfo","delOperInfo.do", "");
		}
		
		function queryInfo(){
		clearSelect('idOperInfo');
		       var date=new Date();
			var param="flag="+date.getTime()+"&OPERID="+escape(escape($.trim($('#idOperId').val())))+"&NAME="+escape(escape($.trim($('#idName').val())))+"&REG_ID="+escape(escape($.trim($('#idRegId').val())))+"&CREATE_DATE="+escape(escape($.trim($('#idCreateDate').val())))+"&VALID="+escape(escape($.trim($('#idValid').val())));
			   $('#idOperInfo').datagrid('options').url = "listOperInfo.do?"+param;// 改变它的url  
			   $("#idOperInfo").datagrid('load');
		}
		function cleardata(){
			$('#queryForm').form('clear');
		}
	</script>
</head>

<body class="easyui-layout" fit="true">
	    <div region="north" style="height: 50px;position:relative;"   split="true">  
					<form id="queryForm">
						<table class="formTable" style="width:95%;">
				<col width="10%" class="leftCol"/>
				<col width="15%" >
				<col  width="10%" class="leftCol"/>
				<col width="15%" >
				<col  width="10%" class="leftCol"/>
				<col width="22%" >
				<col width="20%">

							<tr>
								<td>操作员编号</td>
								<td>
									<input type="text" size="15" name="OPER_ID" id="idOperId" maxlength="8" />
								</td>
								
								<td>操作员名</td>
								<td>
									<input type="text" size="15" name="NAME" id="idName" maxlength="40" />
								</td>
								<td>分支机构</td>
								<td>
									<input type="hidden" name="REG_ID" id="idRegId"  readonly="readonly" maxlength="8" />
									<input type="text" size="15" class="readonly" readonly   name="REG_NAME" id="idRegName" readonly="readonly" />
									<input id="idChoose" type="button" class="btn_grid" value="选择" onclick="queryReg('idRegId','idRegName');"/>
								</td>
								<td>
								<input id="idQuery" type="button" class="btn_grid" value=" 查询 " onclick="queryInfo()"/>
									<input id="idReset" type="button" class="btn_grid" value=" 重置 " onclick="cleardata()"/>
								</td>
							</tr>
							<!--  						
							<tr>
							<td colspan="6">
								<a href="javascript:void(0)" class="easyui-linkbutton"  icon="icon-search" onclick="queryInfo()">查找</a>
								<a class="easyui-linkbutton" iconCls="icon-redo" href="javascript:void(0);" onclick="cleardata()">重置</a>
							</td>
							</tr>
							-->
						</table>
					</form>
	     </div>
		<div region="center"  border="false">  
			<table id="idOperInfo" ></table>
			<input type="hidden" id="idTmsModuleTitle"  name="tmsModuleTitle">
	    	<input type="hidden" id="idTmsModuleId" name="tmsModuleId">
	    </div>
	      <div region="south" border="false" style="height: 30px;position:relative;background:url('<%=basePath%>images/indexbg.png') repeat;">  
			<div id="toolbar"></div>
	     </div>
</body>

</html>
