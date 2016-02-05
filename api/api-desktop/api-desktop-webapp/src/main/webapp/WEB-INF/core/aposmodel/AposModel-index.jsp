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
    <script type="text/javascript" src="core/aposmodel/AposModel-js.js"></script>
	<script type="text/javascript">
	
	$(document).ready(function(){
			$(".import_toolbar").attr('disabled', true);
			$(".export_toolbar").attr('disabled', true);
	
	});
	
	
		function doNew(){
			var retValue=openDialogFrame("<%=basePath%>core/aposmodel/AposModel-add.jsp","","780","500");
			if(retValue=="true"){
				//msgShow("新增","新增成功!","info");
				//flashTable("idAposModel");
			}else if(retValue=="false"){
			    //flashTable("idAposModel");
			   //msgShow("新增","新增失败!","error");
			}
			flashTable("idAposModel");
		}
		
		
		function doEdit(){
			var ids=updateValidate("idAposModel");
		    if(ids){
		    	var retValue=openDialogFrame("<%=basePath%>core/aposmodel/AposModel-edit.jsp",ids,"780","540");
				if(retValue=="true"){
					//msgShow("修改","修改成功!","info");
					//flashTable("idAposModel");
				}else if(retValue=="false"){
			       msgShow("修改","修改失败!","error");
			    }
			    flashTable("idAposModel");
		    }
			
		}
		
		function doDel(){
		 deleteNoteById("idAposModel","delAposModel.do", "");
		}
		
		function queryInfo(){
		       var date=new Date();
		       $('#idAposModel').datagrid("clearSelections");
			var param="flag="+date.getTime()+"&APOS_MODELID="+escape(escape($.trim($('#idAposModelId').val())))+"&APOS_MODEL_NAME="+escape(escape($.trim($('#idAposModelName').val())))+"&REG_ID="+escape(escape($.trim($('#idRegId').val())))+"&APOS_MODEL_STATUS="+escape(escape($.trim($('#idAposModelStatus').val())));			   $('#idAposModel').datagrid('options').url = "listAposModel.do?"+param;// 改变它的url  
			   $("#idAposModel").datagrid('load');
		}
		function cleardata(){
			$('#queryForm').form('clear');
		}
	</script>
</head>

<body class="easyui-layout" fit="true">
	    <div region="north" style="height:80px;position:relative;" title=""  split="true">  
					<form id="queryForm">
						<table class="formTable" style="width:95%;">
				<col  width="5%" class="leftCol"/>
				<col width="15%" >

				<col  width="5%" class="leftCol"/>
				<col width="25%" >

				<col  width="5%" class="leftCol"/>
				<col width="15%" >

							<tr>
								<td>模板编号:</td>
								<td>
									<input type="text" name="APOS_MODEL_ID" id="idAposModelId" maxlength="10" />
								</td>
								<td>模板名称:</td>
								<td>
									<input type="text" name="APOS_MODEL_NAME" id="idAposModelName" maxlength="30" />
								</td>
								<td></td>
								<td></td>
							</tr>
							<tr>
								<td>模板状态:</td>
								
								<td>
								<select name="APOS_MODEL_STATUS" id="idAposModelStatus" style="width:150px">
								<option value="" selected>请选择</option>
								<option value="1">完成</option>
								<option value="0">未完成</option>
								</select>
								</td>
								<td>分支机构:</td>
									<td>

								   <input type="hidden" class="easyui-validatebox"    name="REG_ID" id="idRegId" maxlength="8" />
									<input type="text" class="easyui-validatebox" style="background-color: #EEEEEE"  name="REG_NAME" id="idRegName" readonly="readonly" />
									<input id="idChoose" type="button" class="btn_grid" value="选择" onclick="queryReg('idRegId','idRegName')"/>
									<input id="idClear" type="button" class="btn_grid" value="清空" onclick="clearReg('idRegId','idRegName')"/>
								
								</td>
								<td></td>
								<td>
								<input id="idQuery" type="button" class="btn_grid" value=" 查 询 " onclick="queryInfo()"/>
							     <input id="idReset" type="button" class="btn_grid" value=" 重 置 " onclick="cleardata()"/>
								</td>
							</tr>
						</table>
					</form>
	     </div>
		<div region="center" border="false" >  
			<table id="idAposModel" ></table>
	    </div>
	      <div region="south" border="false" style="height: 30px;position:relative;background:url('<%=basePath%>images/indexbg.png') repeat;">  
			<div id="toolbar"></div>
	     </div>
</body>

</html>
