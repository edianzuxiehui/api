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
    <script type="text/javascript" src="core/paramitem/ParamItem-js.js"></script>
	<script type="text/javascript">
		function doNew(){
			var retValue=openDialogFrame("<%=basePath%>core/paramitem/ParamItem-add.jsp","","400","300");
			if(retValue=="true"){
				msgShow("新增","新增成功!","info");
				flashTable("idParamItem");
			}else if(retValue=="false"){
				msgShow("新增","新增失败!","error");
			}
		}
		
		
		function doEdit(){
			var ids=updateValidate("idParamItem");
		    if(ids){
		    	var retValue=openDialogFrame("<%=basePath%>core/paramitem/ParamItem-edit.jsp",ids,"400","300");
				if(retValue=="true"){
					msgShow("修改","修改成功!","info");
					flashTable("idParamItem");
				}
		    }
			
		}
		
		function doDel(){
		 deleteNoteById("idParamItem","delParamItem.do", "");
		}
		
		function queryInfo(){
			clearSelect('idParamItem');//防止页面选定一条记录后进行查询，原来的选定还存在，导致修改时选定多条
		    var date=new Date();
		    var idParamGroup = $('#idParamGroup').combobox('getValue');//alert(idParamGroup);
			var param="flag="+date.getTime()+"&PARAM_ID="+escape(escape($.trim($('#idParamId').val())))+"&PARAM_NAME="+escape(escape($.trim($('#idParamName').val())))+"&DATA_TYPE="+escape(escape($.trim($('#idDataType').val())))+"&VALUE_LEN="+$('#idValueLen').val()+"&PARAM_GROUP="+idParamGroup+"&DEF_VALUE="+escape(escape($.trim($('#idDefValue').val())))+"&DESC_TXT="+escape(escape($.trim($('#idDescTxt').val())));			   
			$('#idParamItem').datagrid('options').url = "listParamItem.do?"+param;// 改变它的url  
			$("#idParamItem").datagrid('load');
		}
		function cleardata(){
			$('#queryForm').form('clear');
		}
		
	function doImp(){//导入参数项文件
	  	var returnValue= openDialogFrame(getRootPath()+'/core/paramitem/importParamItem.jsp','',450,20);
		$('#idParamItem').datagrid('load');
 	 }	
	</script>
</head>

<body class="easyui-layout" fit="true">
	    <div region="north" style="height:50px;position:relative;" title=""  split="true">  
					<form id="queryForm">
						<table class="formTable" style="width:95%;">
				<col  width="8%" class="leftCol"/>
				<col width="20%" >

				<col  width="8%" class="leftCol"/>
				<col width="20%" >

				<col  width="8%" class="leftCol"/>
				<col width="20%" >

							<tr>
								<td>参数组别</td>
								<td>
									<select id="idParamGroup" class="easyui-combobox" name="PARAM_GROUP" style="width:145px;" panelHeight="auto">
									</select>
									<!-- <input type="text" name="PARAM_GROUP" id="idParamGroup" maxlength="2" /> -->
								</td>
								<td>参数项编号</td>
								<td>
									<input type="text" name="PARAM_ID" id="idParamId" maxlength="8" />
								</td>
								<td>参数名称</td>
								<td>
									<input type="text" name="PARAM_NAME" id="idParamName" maxlength="40" />
								</td>
								<td colspan="2" align="center">
								     <input id="idQuery" type="button" class="btn_grid" value=" 查 询 " onclick="queryInfo()"/>
								     <input id="idReset" type="button" class="btn_grid" value=" 重 置 " onclick="cleardata()"/>
								</td>
							</tr>
				<!--        <tr>
								<td>默认值</td>
								<td>
									<input type="text" name="DEF_VALUE" id="idDefValue" maxlength="1024" />
								</td>
								<td>备注</td>
								<td>
									<input type="text" name="DESC_TXT" id="idDescTxt" maxlength="100" />
								</td>
							</tr> -->
						</table>
					</form>
	     </div>
		<div region="center"  >  
			<table id="idParamItem" ></table>
	    </div>
	      <div region="south" style="height: 30px;position:relative;background:url('<%=basePath%>images/indexbg.png') repeat;">  
			<div id="toolbar"></div>
	     </div>
</body>

</html>
