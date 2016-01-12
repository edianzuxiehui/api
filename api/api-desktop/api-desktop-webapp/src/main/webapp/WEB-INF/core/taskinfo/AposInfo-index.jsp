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
<base target="_self">
<title>应用终端选择</title>
<link rel="stylesheet" type="text/css" href="themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="themes/icon.css">
<link rel="stylesheet" type="text/css" href="css/default.css">
<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="js/jquery.bgiframe.js"></script>
<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="js/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="js/common.js"></script>
<script type="text/javascript" src="core/taskinfo/AposInfo-js.js"></script>
<script type="text/javascript" src="js/sim.js"></script>
<script type="text/javascript">
	function queryInfo() {
		var date = new Date();
		var param = "flag=" + date.getTime() + "&APOS_ID="
				+ $.trim($('#idAposId').val()) + "&SERIAL_NO="
				+ $.trim($('#idSerialNo').val()) + "&REG_ID="
				+ escape(escape($.trim($('#idRegId').val())))
				+ "&REG_ENTIRE_ID="
				+ escape(escape($.trim($('#idRegEntireId').val())))
				+ "&MERCH_ID=" + $.trim($('#idMerchId').val())
				+ "&TERMINAL_ID=" + $.trim($('#idTerminalId').val()) + "&MID="
				+ $.trim($('#idMidSelect').val()) + "&FID="
				+ $.trim($('#idFidSelect').val()) + "&MODE="
				+ $.trim($('#idMode').val()) + "&IP="
				+ $.trim($('#idIP').val()) + "&PORT="
				+ $.trim($('#idPort').val()) + "&MOBILE="
				+ $.trim($('#idMobile').val()) + "&APPID="
				+ $.trim($('#idAppId').val());
		$('#idAposInfo').datagrid('options').url = "listAposInfoForTask.do?"
				+ param;// 改变它的url  
		$("#idAposInfo").datagrid('load');
	}
	function cleardata() {
		$('#queryForm').form('clear');
		$("#idFidSelect").get(0).options[0].selected = true
		$('#idMidSelect').empty();
		var option;
		option = new Option("请选择主机型号", "");
		document.getElementById("idMidSelect").options.add(option);
	}
	function retAposInfo() {
		var rows = $('#idAposInfo').datagrid('getSelections');
		var batchFlag = $('#idBatchFlag').val();
		if (rows.length == 0) {
			msgShow("提示", "请选择应用终端", "info");
		} else {
			if (batchFlag == null || batchFlag == '') {//逐条增加
				if (rows.length > 1) {
					msgShow("提示", "只能选择一个应用终端", "info");
					return false;
				} else {
					window.returnValue = rows[0].APOS_ID + '_' + rows[0].DEV_ID
							+ '_' + rows[0].SERIAL_NO + '_' + rows[0].MID;
				}
			} else {
				var aposList = "";
				for ( var i = 0; i < rows.length; i++) {
					aposList += rows[i].APOS_ID + '_' + rows[i].DEV_ID + '_'
							+ rows[i].SERIAL_NO + '_' + rows[i].MID + ",";
				}//alert(aposList);
				if (aposList.length > 0) {
					aposList = aposList.substring(0, aposList.length - 1);
				}//alert(aposList);
				window.returnValue = aposList;
			}
			window.close();

		 	}
		}
	</script>
</head>

<body class="easyui-layout" fit="true">
	<div region="north" style="height: 130px; position: relative;" title="查询面板" split="true">
		<form id="queryForm">
			<table class="formTable" style="width: 95%;">
				<col width="8%" class="leftCol" />
				<col width="17%">
				<col width="8%" class="leftCol" />
				<col width="17%">
				<col width="10%" class="leftCol" />
				<col width="15%">
				<col width="8%" class="leftCol" />
				<col width="17%">
				<input type="hidden" name="BatchFlag" id="idBatchFlag" value="">
				<tr>
					<td>应用终端号</td>
					<td><input type="text" name="APOS_ID" id="idAposId" maxlength="10" /></td>

					<td>硬件序列号</td>
					<td><input type="text" name="SERIAL_NO" id="idSerialNo" maxlength="30" /></td>
					<td>主应用终端号</td>
					<td><input type="text" name="TERMINAL_ID" id="idTerminalId" maxlength="8" /></td>
					<td>分支机构</td>
					<td><input type="hidden" class="easyui-validatebox" name="REG_ID" id="idRegId" maxlength="8" /> <input type="hidden" class="easyui-validatebox" name="REG_ENTIRE_ID" id="idRegEntireId" /> <input type="text" class="easyui-validatebox" style="background-color: #EEEEEE" name="REG_NAME" id="idRegName" readonly="readonly" size="15" /> <input id="idChoose" type="button" class="btn_grid" value="选择" onclick="queryReg('idRegId','idRegName','idRegEntireId')" /></td>
				</tr>
				<tr>

					<td>主商户号</td>
					<td><input type="text" name="MERCH_ID" id="idMerchId" maxlength="1" readonly="readonly" class="readonly" size="15" /> <input type="button" class="btn_grid" value="选择" onclick="selectMerch('idMerchId');" /></td>
					<td><div style="text-align: right;">厂商</div></td>
					<td><select name="FID" id="idFidSelect" maxlength="15" style="width: 120px;" onchange="changeModelByFID(this.value);">
							<option value="">请选择终端厂商</option>
					</select></td>
					<td><div style="text-align: right;">主机型号</div></td>
					<td><select name="MID" id="idMidSelect" maxlength="20" style="width: 120px;">
							<option value="">请选择主机型号</option>
					</select></td>
					<td><div style="text-align: right;">应用编号</div></td>
					<td><select type="text" name="APP_ID" id="idAppId" maxlength="8">
							<option value="">请选择应用编号</option>
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

					<td><input id="idQuery" type="button" class="btn_grid" value=" 查 询 " onclick="queryInfo()" /></td>
					<td><input id="idReset" type="button" class="btn_grid" value=" 重 置 " onclick="cleardata()" /></td>
				</tr>
			</table>
		</form>
	</div>
	<div region="center">
		<table id="idAposInfo"></table>
	</div>
	<div region="south" style="text-align:right;height: 30px;position:relative;background:url('<%=basePath%>images/indexbg.png') repeat;">
		<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="retAposInfo()">确认</a> <a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="javascript:window.close()">取消</a>
	</div>
</body>

</html>
