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
    <script type="text/javascript" src="core/posextraconfirm/PosExtraConfirm-js.js"></script>
	<script type="text/javascript">		
		function queryInfo(){
			var date=new Date();
			var param="flag="+date.getTime();
			param += "&SERIAL_NO="+escape(escape($.trim($('#idSerialNo').val())));
			param += "&MERCH_ID="+escape(escape($.trim($('#idMerchId').val())));
			param += "&REG_ID="+escape(escape($.trim($('#idRegId').val())));
			param += "&TERMINAL_ID="+escape(escape($.trim($('#idTerminalId').val())));
			param += "&APOS_ID="+escape(escape($.trim($('#idAposId').val())));
			param += "&MID="+escape(escape($.trim($('#idMidSelect').val())));
			$('#idPosExtraConfirmInfo').datagrid('options').url = "listPosExtraConfirm.do?"+param;// 改变它的url
			$("#idPosExtraConfirmInfo").datagrid('load');
		}
		function cleardata(){
			$('#queryForm').form('clear');
		}
	</script>
</head>

<body class="easyui-layout" fit="true">
	    <div region="north" style="height: 100px;position:relative;" split="true">  
					<form id="queryForm">
						<table class="formTable" style="width:95%;">
				<col width="70px" class="leftCol"/>
				<col width="100px" />

				<col width="80px" class="leftCol"/>
				<col width="100x" />

				<col width="80px" class="leftCol"/>
				<col width="250px" />
							<tr>
								<td>应用终端号</td>
								<td>
									<input type="text" name="APOS_ID" id="idAposId" maxlength="10" />
								</td>
								<td>主应用终端号</td>
								<td>
									<input type="text" name="TERMINAL_ID" id="idTerminalId" maxlength="8" />
								</td>
								<td>主应用商户号</td>
								<td>
									<input type="hidden" name="MERCH_ID" id="idMerchId" value=""/>
									<input type="text" class="easyui-validatebox readonly" name="MERCH_NAME" id="idMerchName" readonly/>
									<input type="button" class="btn_grid" value="选择" id="btn_queryMerch" onclick="queryMerch();"/>
									<input type="button" class="btn_grid" value="清空" id="btn_clearMerch" onclick="clearMerch();"/>
								</td>
								
							</tr>
							<tr>
								<td>终端厂商</td>
								<td>
									<select id="idFidSelect" name="FID" onchange="changeModelByFID(this.value)" style="width:145px;">
										<option value="">请选择终端厂商</option>
									</select>
								</td>
								<td>终端型号</td>
								<td>
									<select name="MID" id="idMidSelect" style="width:145px;">
										<option value="">请选择终端型号</option>
									</select>
								</td>
								<td>分支机构</td>
								<td>
									<input type="hidden" name="REG_ID" id="idRegId" value=""/>
									<input type="hidden" name="REG_ENTIRE_ID" id="idRegEntireId" value=""/>
									<input type="text" name="REG_NAME" id="idRegName" readonly class="readonly" />
									<input type="button" class="btn_grid" value="选择" onclick="queryReg('idRegId','idRegName','idRegEntireId');"/>
									<input type="button" class="btn_grid" value="清空" onclick="clearReg('idRegId','idRegName','idRegEntireId');"/>
								</td>
								
							</tr>
							<tr>
								<td>硬件序列号</td>
								<td>
									<input type="text" name="SERIAL_NO" id="idSerialNo" />
								</td>
								<td colspan="3">&nbsp;</td>
								<td align="left">
									<input type="button" class="btn_grid" onclick="queryInfo()" style="height:24px;" value=" 查 询 " />
									<input type="button" class="btn_grid" onclick="cleardata()" style="height:24px;" value=" 重 置 " />
								</td>
							</tr>
						</table>
					</form>
	     </div>
		<div region="center"  >  
			<table id="idPosExtraConfirmInfo" ></table>
	    </div>
</body>

</html>
