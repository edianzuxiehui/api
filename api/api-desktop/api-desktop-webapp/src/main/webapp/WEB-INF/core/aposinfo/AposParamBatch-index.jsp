<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
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
<script type="text/javascript" src="core/aposinfo/AposParamBatch-index.js"></script>
<script type="text/javascript" src="js/sim.js"></script>
<script type="text/javascript">

	function queryInfo() {
		//$('#idPosParamBatch').
		 //msgShow('提示','注意必选参数','info');
		var idFidSelect= escape(escape($("#idFidSelect").val()));
		//alert("["+idFidSelect+"]");
		if(idFidSelect==""){
			msgShow('提示消息','请选择终端厂商!','info');
			return;
		}
		var idMidSelect= escape(escape($("#idMidSelect").val()));
		if(idMidSelect==""){
			msgShow('提示消息','请选择主机型号!','info');
			return;
		}
		var idAppId= escape(escape($("#idAppId").val()));
		if(idAppId==""){
			msgShow('提示消息','请选择应用编号!','info');
			return;
		}
		var idAppVer= escape(escape($("#idAppVer").val()));
		if(idAppVer==""){
			msgShow('提示消息','请选择程序版本!','info');
			return;
		}
		
		clearSelect('idPosParamBatch');//防止页面选定一条记录后进行查询，原来的选定还存在，导致修改时选定多条
		$('#idPosParamBatch').datagrid('loadData', { total: 0, rows: [] });//清空下方DateGrid 

		var date = new Date();
		var param = "REG_ID=" + escape(escape($.trim($('#idRegId').val())))
				+ "&APP_ID=" + escape(escape($.trim($('#idAppId').val())))
				+ "&APP_VER="
				+ escape(escape($.trim($('#idAppVer').val())))
				+ "&MODE="
				+ escape(escape($.trim($('#idMode').val())))
				+ "&IP=" + escape(escape($.trim($('#idIP').val())))
				+ "&PORT=" + escape(escape($.trim($('#idPort').val())))
				+ "&MOBILE=" + escape(escape($.trim($('#idMobile').val())))
				+ "&MID=" + escape(escape($.trim($('#idMidSelect').val())))
				+ "&FID=" + escape(escape($.trim($('#idFidSelect').val())));
				
		$('#idPosParamBatch').datagrid('options').url = "queryAppBatchParams.do?"
				+ param;// 改变它的url
		$('#idQueryBatch').attr('disabled',true);
		$("#idPosParamBatch").datagrid('load');
		$('#idQueryBatch').attr('disabled',false);
	}
	function cleardata() {
		$('#queryForm').form('clear');
		$("#idFidSelect").get(0).options[0].selected = true
		$('#idMidSelect').empty();
		var option;
		option = new Option("请选择主机型号", "");
		document.getElementById("idMidSelect").options.add(option);
		$("#idAppId").get(0).options[0].selected = true;
		$("#idAppVer").get(0).options[0].selected = true;
		
		$("#idMode").get(0).options[0].selected = true;
		$("#idIP").get(0).options[0].selected = true;
		$("#idPort").get(0).options[0].selected = true;
		$("#idMobile").get(0).options[0].selected = true;
		
	}
	
	 
	 function doEdit(){
		 changeBatchParamValues();
	 }
	</script>
</head>

<body class="easyui-layout" fit="true">
	<div region="north" style="height: 75px; position: relative;" split="true">
		<form id="queryForm">
			<table class="formTable" style="width: 95%;">
				<col width="70px" class="leftCol" />
				<col width="150px">

				<col width="70px" class="leftCol" />
				<col width="150px">

				<col width="70px" class="leftCol" />
				<col width="150px">

				<col width="70px" class="leftCol" />
				<col width="150px">

				<tr>
					<td><div style="text-align: right;">厂商</div></td>
					<td><select name="FID" id="idFidSelect" maxlength="15" style="width: 120px;" onchange="changeModelByFID(this.value);">
							<option value="">请选择终端厂商</option>
					</select></td>
					<td><div style="text-align: right;">主机型号</div></td>
					<td><select name="MID" id="idMidSelect" maxlength="20" style="width: 120px;">
							<option value="">请选择主机型号</option>
					</select></td>

					<td><div style="text-align: right;">应用编号</div></td>
					<td><select type="text" name="APP_ID" id="idAppId" maxlength="8" onchange="changeAppVerInfo(this.value);">
							<option value="">请选择应用编号</option>
					</select></td>

					<td><div style="text-align: right;">程序版本</div></td>
					<td><select type="text" name="Version" id="idAppVer" maxlength="20">
							<option value="">请选择程序版本</option>
					</select></td>


				</tr>
				<tr>

					<td><div style="text-align: right;">通讯方式</div></td>
					<td><select type="text" name="Mode" id="idMode" maxlength="20">
							<option value="">请选择通讯方式</option>
					</select></td>

					<td>IP地址</td>
					<td><select type="text" name="IP" id="idIP" maxlength="20">
							<option value="">请选择IP地址</option>
						
					</select></td>
					<td>端口</td>
					<td><select type="text" name="Port" id="idPort" maxlength="20">
							<option value="">请选择端口</option>
						
					</select></td>
					<td>电话号码</td>
					<td><select type="text" name="Mobile" id="idMobile" maxlength="20">
							<option value="">请选择电话号码</option>
						
					</select></td>

					<!-- <td>业务参数</td>
					<td><select type="text" name="YwParam" id="idYwParam" maxlength="20">
							<option value="">请选择业务参数</option>
						
					</select></td> -->
					<td colspan="2">
						<div style="text-align: center;">
							<input type="button" class="btn_grid" id="idQueryBatch" onclick="queryInfo()" style="height: 24px;" value=" 查 询 " /> <input type="button" class="btn_grid" onclick="cleardata()" style="height: 24px;" value=" 重 置 " />
						</div>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div region="center" border="false">
		<table id="idPosParamBatch"></table>
		<input type="hidden" id="idTmsModuleTitle"  name="tmsModuleTitle">
	    	<input type="hidden" id="idTmsModuleId" name="tmsModuleId">
	</div>
	
	<div region="south" border="false" style="height: 30px;position:relative;background:url('<%=basePath%>images/indexbg.png') repeat;">
		<div id="toolbar"></div>
	</div>
</body>

</html>
