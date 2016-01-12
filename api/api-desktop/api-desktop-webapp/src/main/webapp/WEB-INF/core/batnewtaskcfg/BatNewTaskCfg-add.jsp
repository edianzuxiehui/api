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
<title>增加终端任务定制</title>
<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/icon.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/default.css">
<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/jquery.bgiframe.js"></script>
<script type="text/javascript" src="<%=basePath%>js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="<%=basePath%>js/common.js"></script>
<script type="text/javascript" src="<%=basePath%>js/sim.js"></script>
<script type="text/javascript" src="core/batnewtaskcfg/BatNewTaskCfg-add-js.js"></script>
<script type="text/javascript">
	setModuleNameAndId();
	initTxfy();
	function cleardata() {
		$('#ff').form('clear');
	}

	function addBatNewTaskCfg() {
		var type = 0;
		var idQueryBeginSerialNo = $('#idQueryBeginSerialNo').val();
		var idQueryEndSerialNo = $('#idQueryEndSerialNo').val()
		if (idQueryBeginSerialNo && idQueryBeginSerialNo != ""
				&& idQueryEndSerialNo && idQueryEndSerialNo != "") {
			type = 1;
		} else {
			if (!idQueryBeginSerialNo && !idQueryEndSerialNo) {
				type = 1;
			}
		}
		if (type == 1) {
			var date = new Date();

			//属于ff1表单内容，需要另外提交
			var param = "flag=" + date.getTime() + "&QUERY_REG_ID="
					+ $('#idQueryRegId').val() + "&QUERY_REG_ENTIRE_ID="
					+ $('#idQueryRegEntireId').val() + "&QUERY_APP_ID="
					+ $('#idQueryAppId').val() + "&QUERY_APP_VER="
					+ $('#idQueryAppVer').val() + "&QUERY_FID="
					+ $('#idFidSelect').val() + "&QUERY_MID="
					+ $('#idMidSelect').val() + "&QUERY_BEGIN_SERIAL_NO="
					+ $.trim(idQueryBeginSerialNo) + "&QUERY_END_SERIAL_NO="
					+ $.trim(idQueryEndSerialNo) + "&MODE="
					+ $.trim($('#idMode').val()) + "&IP="
					+ $.trim($('#idIP').val()) + "&PORT="
					+ $.trim($('#idPort').val()) + "&MOBILE="
					+ $.trim($('#idMobile').val());
			//alert(param);
			$('#ff').form('submit', {

				url : 'addBatNewTaskCfg.do?' + param,
				onSubmit : function() {
					return $(this).form('validate');
				},
				success : function(data) {
					var myObject = eval('(' + data + ')');
					//这种方式直接关闭窗口，返回true或者false给主窗口
					// window.close();
					// window.returnValue=myObject.status; 

					//这种错误情况下方式不关闭窗口	 
					if (myObject.status == "true") {
						window.close();
						window.returnValue = myObject.status;
					} else if (myObject.status == "false") {
						msgShow("新增", myObject.message, "error");
						//window.close();
					}
				}
			});
		} else {
			alert("请填写完整终端序列号区间");
		}
	}
</script>
</head>
<body class="easyui-layout" fit="true">
	<div region="north" style="height: 180px" title="基本信息">
		<div style="height: 50px;">
			<form id="ff" method="post">
				<table class="formTable" style="width: 90%;">
					<col width="100px" class="leftCol" />
					<col width="250px">
					<col width="100px" class="leftCol" />
					<col width="250px">
					<input type="hidden" name="PLAN_CODE" id="idPlanCode" value="">
					<input type="hidden" name="REG_ID" id="idRegId" maxlength="8" />
					<input type="hidden" name="REG_NAME" id="idRegName" maxlength="8" />
					<input type="hidden" name="REG_ENTIRE_ID" id="idRegEntireId" />
					<tr>
						<td width="15%" align="right" class="blue">计划<font color="red">*</font></td>
						<td width="35%"><input class="easyui-validatebox" required="true" style="background-color: #EEEEEE" name="plan_name" id="idPlanName" size=15 readonly class="readonly"> <input name="reset" type="button" class="btn_grid" value="选择" onClick="selectPlan()"></td>
						<td width="15%" align="right" class="blue">策略编号<font color="red">*</font></td>
						<td><input class="easyui-validatebox" required="true" style="background-color: #EEEEEE" name="STRATEGY_ID" id="idStrategyId" size=15 readonly> <input name="reset" type="button" class="btn_grid" value="选择" onClick="selectStrategy()"></td>
					</tr>
				</table>
			</form>
		</div>
		<div style="height: 100px;">
			<table id="idTaskDetail"></table>
		</div>
	</div>
	<div region="center" split="true" title="应用终端选择">
		<form id="ff1" method="post">
			<table class="formTable" style="width: 90%;">
				<col width="15%" class="leftCol" />
				<col width="40%">
				<col width="20%" class="leftCol" />
				<col width="25%">
				<tr>
					<td>应用</td>
					<td><select class="easyui-validatebox" name="QUERY_APP_ID" id="idQueryAppId" style="width: 80%" onchange="changeAppVerInfo(this.value)">
							<option value="">请选择应用</option>
					</select></td>
					<td>应用版本</td>
					<td><select class="easyui-validatebox" name="QUERY_APP_VER" id="idQueryAppVer" style="width: 100%">
							<option value="">请选择应用版本</option>
					</select></td>
				</tr>
				<tr>
					<td>厂商</td>
					<td><select name="QUERY_FID" id="idFidSelect" maxlength="15" style="width: 80%" onchange="changeModelByFID(this.value);">
							<option value="">请选择终端厂商</option>
					</select></td>
					<td>主机型号</td>
					<td><select type="text" class="easyui-validatebox" name="QUERY_MID" id="idMidSelect" maxlength="20" style="width: 100%">
							<option value="">请选择主机型号</option>
					</select></td>
				<tr>
				<tr>
					<td>查询分支机构</td>
					<td><input type="hidden" name="QUERY_REG_ENTIRE_ID" id="idQueryRegEntireId" /> <input type="hidden" name="QUERY_REG_ID" id="idQueryRegId" maxlength="8" /> <input type="text" class="easyui-validatebox" style="background-color: #EEEEEE" readonly name="Query_REG_NAME" id="idQueryRegName" size="21" /> <input id="idChoose" type="button" class="btn_grid" value="选择" onclick="queryReg('idQueryRegId','idQueryRegName','idQueryRegEntireId');" /></td>
					<td></td>
					<td></td>
				</tr>
				<tr>
					<td>终端序列号区间</td>
					<td colspan="2"><input type="text" name="QUERY_BEGIN_SERIAL_NO" id="idQueryBeginSerialNo" style="width: 35%" maxlength="25" /> 至 <input type="text" name="QUERY_END_SERIAL_NO" id="idQueryEndSerialNo" style="width: 35%" maxlength="25" /></td>
					<td style="text-align: center;"></td>
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
				</tr>
				<tr><td>端口</td>
				<td><select type="text" name="Port" id="idPort" maxlength="20">
						<option value="">请选择端口</option>
					
				</select></td>
				<td>电话号码</td>
				<td><select type="text" name="Mobile" id="idMobile" maxlength="20">
						<option value="">请选择电话号码</option>
				</select></td>
				</tr>
				</table>
		</form>
	</div>
	<div region="south" style="text-align:right;" class="toolbarHeader">
		<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="addBatNewTaskCfg()">确定</a>
		<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="javascript:window.close()">关闭</a>
	</div>	    
</body>
</html>
