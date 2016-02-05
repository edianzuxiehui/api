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
    <script type="text/javascript" src="core/modelrelation/ModelRelation-js.js"></script>
	<script type="text/javascript">
		function doNew(){
			var retValue=openDialogFrame("<%=basePath%>core/modelrelation/ModelRelation-add.jsp","","470","280");
			if(retValue=="true"){
				msgShow("新增","新增成功!","info");
				flashTable("idModelRelation");
			}else if(retValue=="false"){
			   msgShow("新增","新增失败!","error");
			}
		}
		
		
		function doEdit(){
			var ids=updateValidate("idModelRelation");
		    if(ids){
		    	var retValue=openDialogFrame("<%=basePath%>core/modelrelation/ModelRelation-edit.jsp",ids,"470","280");
				if(retValue=="true"){
					msgShow("修改","修改成功!","info");
					flashTable("idModelRelation");
				}else if(retValue=="false"){
			       msgShow("修改","修改失败!","error");
			    }
		    }
			
		}
		
		function doDel(){
		 deleteNoteById("idModelRelation","delModelRelation.do", "");
		}
		
		function queryInfo(){
		    var date=new Date();
		    $('#idModelRelation').datagrid("clearSelections");
		    var param="flag="+date.getTime()+"&MID="+escape(escape($.trim($('#idMidSelect').val())))+"&FID="+escape(escape($.trim($('#idFidSelect').val())))+"&ERP_MODELID="+$.trim($('#erpModelId').val());	
			//var param="flag="+date.getTime()+"&MID="+escape(escape($.trim($('#idMid').val())))+"&MID_NAME="+escape(escape($.trim($('#idMidName').val())))+"&FID="+escape(escape($.trim($('#idFid').val())))+"&BASE_CONFIG="+escape(escape($.trim($('#idBaseConfig').val())))+"&OPT_CONFIG="+escape(escape($.trim($('#idOptConfig').val())))+"&DLL_DIR="+escape(escape($.trim($('#idDllDir').val())))+"&APP_DIR="+escape(escape($.trim($('#idAppDir').val())));
		    $('#idModelRelation').datagrid('options').url = "listModelRelation.do?"+param;// 改变它的url  
			$("#idModelRelation").datagrid('load');
		}
		function cleardata(){
		    $("#idFidSelect").get(0).options[0].selected = true
			$('#idMidSelect').empty();
		    var option;
		    option = new Option("请选择主机型号","");
		    document.getElementById("idMidSelect").options.add(option);
		    $('#erpModelId').val('');
		}
		
		
		function doImp(){//导入文件
	  	var returnValue= openDialogFrame(getRootPath()+'/core/modelrelation/importERPModelInfo.jsp','',470,120);
		$('#idModelRelation').datagrid('load');
 	 }	
	</script>
</head>

<body class="easyui-layout" fit="true" >
	    <div region="north" style="height: 46px;position:relative;"  split="true">  
					<form id="queryForm">
						<table class="formTable" style="width:95%;">
						<col  width="7%" class="leftCol"/>
						<col width="12%" >
						<col  width="3%" class="leftCol"/>
						<col width="12%" >
						<col  width="6%" class="leftCol"/>
						<col width="12%" >
						<col  width="4%" />
						<col  width="4%" />
							<tr>
								<td>ERP终端型号</td>
								<td>
									<input  name="ERP_MODEL_ID" id="erpModelId" maxlength="4" />
								</td>
								<td>厂商</td>
								<td>
									<select  name="FID" id="idFidSelect" maxlength="15" style="width: 70%" onchange="changeModelByFID(this.value);">
									   <option value="">请选择终端厂商</option>
									</select>
								</td>
								<td>主机型号</td>
								<td>
									<select  name="MID" id="idMidSelect" maxlength="20" style="width: 70%" >
									 <option value="">请选择主机型号</option>
									</select>
								</td>
								
								
							   <td>
							     <input id="idQuery" type="button" class="btn_grid" value=" 查 询 " onclick="queryInfo()"/>
								</td>
							   <td>
							     <input id="idReset" type="button" class="btn_grid" value=" 重 置 " onclick="cleardata()"/>
							     
							   </td>
							
							
							
							</tr>
							<!-- 	<td>可选配置</td>
								<td>
									<input type="text" name="OPT_CONFIG" id="idOptConfig" maxlength="100" />
								</td>
								
								
									<tr>
								<td>基本配置</td>
								<td>
									<input type="text" name="BASE_CONFIG" id="idBaseConfig" maxlength="100" />
								</td>
							
								<td>厂商DLL路径</td>
								<td>
									<input type="text" name="DLL_DIR" id="idDllDir" maxlength="200" />
								</td>
							</tr>
							<tr>
								<td>应用程序目录</td>
								<td>
									<input type="text" name="APP_DIR" id="idAppDir" maxlength="200" />
								</td>
							</tr>
						      <td>主机型号名称</td>
								<td>
									<input type="text" name="MID_NAME" id="idMidName" maxlength="20" />
								</td>
								 -->
						</table>
					</form>
	     </div>
		<div region="center" border="false" >  
			<table id="idModelRelation" ></table>
	    </div>
	      <div region="south" border="false" style="height: 30px;position:relative;background:url('<%=basePath%>images/indexbg.png') repeat;">  
			<div id="toolbar"></div>
	     </div>
</body>

</html>
