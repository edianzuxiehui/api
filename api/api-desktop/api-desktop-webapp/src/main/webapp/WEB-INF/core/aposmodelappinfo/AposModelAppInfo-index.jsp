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
    <script type="text/javascript" src="core/aposmodelappinfo/AposModelAppInfo-js.js"></script>
	<script type="text/javascript">
		function doNew(){
			var retValue=openDialogFrame("<%=basePath%>core/aposmodelappinfo/AposModelAppInfo-add.jsp","","600","300");
			if(retValue=="true"){
				msgShow("新增","新增成功!","info");
				flashTable("idAposModelAppInfo");
			}else if(retValue=="false"){
			   msgShow("新增","新增失败!","error");
			}
		}
		
		
		function doEdit(){
			var ids=updateValidate("idAposModelAppInfo");
		    if(ids){
		    	var retValue=openDialogFrame("<%=basePath%>core/aposmodelappinfo/AposModelAppInfo-edit.jsp",ids,"600","300");
				if(retValue=="true"){
					msgShow("修改","修改成功!","info");
					flashTable("idAposModelAppInfo");
				}else if(retValue=="false"){
			       msgShow("修改","修改失败!","error");
			    }
		    }
			
		}
		
		function doDel(){
		 deleteNoteById("idAposModelAppInfo","delAposModelAppInfo.do", "");
		}
		
		function queryInfo(){
		       var date=new Date();
			var param="flag="+date.getTime()+"&SYS_ID="+escape(escape($.trim($('#idSysId').val())))+"&APOS_MODEL_ID="+escape(escape($.trim($('#idAposModelId').val())))+"&APP_ID="+escape(escape($.trim($('#idAppId').val())))+"&MASTER_APP_FLAG="+escape(escape($.trim($('#idMasterAppFlag').val())))+"&APP_VER="+escape(escape($.trim($('#idAppVer').val())))+"&PARAM_MODEL_ID="+escape(escape($.trim($('#idParamModelId').val())))+"&APP_UPDATE_FLAG="+escape(escape($.trim($('#idAppUpdateFlag').val())))+"&PARAM_UPDATE_FLAG="+escape(escape($.trim($('#idParamUpdateFlag').val())))+"&DESC_TXT="+escape(escape($.trim($('#idDescTxt').val())))+"&REG_ID="+escape(escape($.trim($('#idRegId').val())));			   $('#idAposModelAppInfo').datagrid('options').url = "listAposModelAppInfo.do?"+param;// 改变它的url  
			   $("#idAposModelAppInfo").datagrid('load');
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
								<td>系统内部编号(使用序列生成的编号)</td>
								<td>
									<input type="text" name="SYS_ID" id="idSysId" maxlength="10" />
								</td>
								<td>应用终端模板编号</td>
								<td>
									<input type="text" name="APOS_MODEL_ID" id="idAposModelId" maxlength="10" />
								</td>
								<td>应用编号</td>
								<td>
									<input type="text" name="APP_ID" id="idAppId" maxlength="8" />
								</td>
							</tr>
							<tr>
								<td>主应用标志</td>
								<td>
									<input type="text" name="MASTER_APP_FLAG" id="idMasterAppFlag" maxlength="1" />
								</td>
								<td>应用版本</td>
								<td>
									<input type="text" name="APP_VER" id="idAppVer" maxlength="30" />
								</td>
								<td>参数模板编号</td>
								<td>
									<input type="text" name="PARAM_MODEL_ID" id="idParamModelId" maxlength="10" />
								</td>
							</tr>
							<tr>
								<td>应用更新标志</td>
								<td>
									<input type="text" name="APP_UPDATE_FLAG" id="idAppUpdateFlag" maxlength="2" />
								</td>
								<td>参数更新标志</td>
								<td>
									<input type="text" name="PARAM_UPDATE_FLAG" id="idParamUpdateFlag" maxlength="2" />
								</td>
								<td>备注</td>
								<td>
									<input type="text" name="DESC_TXT" id="idDescTxt" maxlength="100" />
								</td>
							</tr>
							<tr>
								<td>分支机构编号</td>
								<td>
									<input type="text" name="REG_ID" id="idRegId" maxlength="8" />
								</td>
							</tr>
						
							<tr>
							<td colspan="6">
								<a href="javascript:void(0)" class="easyui-linkbutton"  icon="icon-search" onclick="queryInfo()">查找</a>
								<a class="easyui-linkbutton" iconCls="icon-redo" href="javascript:void(0);" onclick="cleardata()">重置</a>
							</td>
							</tr>
						</table>
					</form>
	     </div>
		<div region="center" border="false" >  
			<table id="idAposModelAppInfo" ></table>
	    </div>
	      <div region="south" border="false" style="height: 30px;position:relative;background:url('<%=basePath%>images/indexbg.png') repeat;">  
			<div id="toolbar"></div>
	     </div>
</body>

</html>
