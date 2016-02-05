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
    <script type="text/javascript" src="core/parammodel/ParamModel-js.js"></script>
	<script type="text/javascript">
		function doNew(){
			var retValue=openDialogFrame("<%=basePath%>core/parammodel/ParamModel-add.jsp","","400","240");
			if(retValue=="true"){
				msgShow("新增","新增成功!","info");
				flashTable("idParamModel");
			}else if(retValue=="false"){
			   msgShow("新增","新增失败!","error");
			}
		}
		
		
		function doEdit(){
			var ids=updateValidate("idParamModel");
		    if(ids){
		    	if(checkModifyParamModelAuthority()){
			    	var retValue=openDialogFrame("<%=basePath%>core/parammodel/ParamModel-edit.jsp",ids,"400","240");
					if(retValue=="true"){
						msgShow("修改","修改成功!","info");
						flashTable("idParamModel");
					}else if(retValue=="false"){
				       msgShow("修改","修改失败!","error");
				    }
				}else {
					msgShow("没有权限","没有权限修改上级和同级的参数模板","error");
			    }
		    }
			
		}
		
		function doDel(){
	 	
			 deleteNoteById("idParamModel","delParamModel.do", "");
		 /*}else {
		   msgShow("没有权限","没有权限删除上级机构的参数模板","error");
	     }*/
		}
		
		function queryInfo(){
			clearSelect('idParamModel');//防止页面选定一条记录后进行查询，原来的选定还存在，导致修改时选定多条
		    var date=new Date();
			var param="flag="+date.getTime()
				+"&PARAM_MODELID="+escape(escape($.trim($('#idParamModelId').val())))
				+"&PARAM_MODEL_NAME="+escape(escape($.trim($('#idParamModelName').val())))
				+"&CREATE_TIME="+escape(escape($.trim($('#idCreateTime').val())))
				+"&REG_ID="+escape(escape($.trim($('#idRegId').val())))
				+"&APP_ID="+escape(escape($.trim($('#idAppId').val())));
			//alert(param);
			$('#idParamModel').datagrid('options').url = "listParamModel.do?"+param;// 改变它的url  
			$("#idParamModel").datagrid('load');
		}
		function cleardata(){
			$('#queryForm').form('clear');
		}
	</script>
</head>

<body class="easyui-layout" fit="true">
	    <div region="north" style="height: 80px;position:relative;" title=""  split="true">  
					<form id="queryForm">
						<table class="formTable" style="width:95%;">
				<col width="10%" class="leftCol"/>
				<col width="23%" >
				<col  width="8%" class="leftCol"/>
				<col width="25%" >

				<col  width="9%" class="leftCol"/>
				<col width="24%" >
							<tr>
								<td>模板编号</td>
								<td>
									<input type="text" name="PARAM_MODEL_ID" id="idParamModelId" maxlength="10" />
								</td>
								<td>模板名称</td>
								<td>
									<input type="text" name="PARAM_MODEL_NAME" id="idParamModelName" maxlength="30" />
								</td>
								<td>创建时间</td>
								<td>
								<input name="CREATE_TIME" id="idCreateTime" class="Wdate" type="text" onClick="WdatePicker()" readonly>
								</td>
							</tr>
							<tr>

								<td>分支机构</td>
								<td>
									<input type="hidden" class="easyui-validatebox" name="REG_ID" id="idRegId" maxlength="8" />
									<input type="text" class="easyui-validatebox" style="background-color: #EEEEEE" readonly name="REG_ID" id="idRegName" size="15" />
									<input id="idChoose" type="button" class="btn_grid" value="选择" onclick="queryReg('idRegId','idRegName')"/>
								</td>
								<td>应用</td>
								<td>
								    <select class="easyui-validatebox" name="APP_ID" id="idAppId" style="width:56%">
									 <option value="">请选择应用编号</option>
									</select>
								</td>
							<!-- <td>备注</td>
								<td>
									<input type="text" name="DESC_TXT" id="idDescTxt" maxlength="100" />
								</td>  -->	 
							<td colspan="2" align="center">
							     <input id="idQuery" type="button" class="btn_grid" value=" 查 询 " onclick="queryInfo()"/>
							     <input id="idReset" type="button" class="btn_grid" value=" 重 置 " onclick="cleardata()"/>
							</td>
							</tr>
						</table>
					</form>
	     </div>
		<div region="center"  border="false">  
			<table id="idParamModel" ></table>
	    </div>
	      <div region="south" border="false" style="height: 30px;position:relative;background:url('<%=basePath%>images/indexbg.png') repeat;">  
			<div id="toolbar"></div>
	     </div>
</body>
<script language="javascript" type="text/javascript" src="<%=basePath%>js/DatePicker/WdatePicker.js"></script>
</html>
