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
    <title>由明细生成</title>
    <link rel="stylesheet" type="text/css" href="themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="themes/icon.css">
	<link rel="stylesheet" type="text/css" href="css/default.css">
	<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="js/common.js"></script>
    <script type="text/javascript" src="core/aposinfo/AposInfo-com.js"></script>
	<script type="text/javascript" src="core/aposinfo/addAposFromAppDetail.js"></script>
  </head>
  
  <body class="easyui-layout">
  	<div region="north" style="height:290px;">
		<form id="ff" method="post">
			<fieldset id="aposArea" style="padding:6px;width:95%;border:1px solid #46A3FF; color:#CC3300; line-height:2.0; font-size:12px;" align=center>
				<legend>应用终端信息</legend>
				<table class="formTable" style="width:98%;overflow:hidden;">
					<col width="15%" class="leftCol"/>
					<col width="35%" />
					<col width="15%" class="leftCol"/>
					<col width="35%"/>
					<tr>
						<td>应用终端号</td>
						<td>
							<input type="text" name="APOS_ID" id="idAposId" value="" class="easyui-validatebox readonly" required="true" readonly/>							
						</td>
						<td>分支机构<font color="red">*</font></td>
						<td>
							<input type="hidden" name="REG_ID" id="idRegId" value=""/>
							<input type="hidden" name="REG_ENTIRE_ID" id="idRegEntireId" value=""/>
							<input type="text" class="easyui-validatebox readonly" name="REG_NAME" id="idRegName" required="true" readonly/>
							<input type="button" class="btn_grid" value="选择" id="btnRegSel" onclick="queryReg('idRegId','idRegName','idRegEntireId');"/>
							<input type="button" class="btn_grid" value="清空" id="btnRegClr" onclick="clearReg('idRegId','idRegName','idRegEntireId');"/>
						</td>
					</tr>
					<tr>
						<td>布放地址</td>
						<td>
							<input type="text" class="easyui-validatebox" validType="maxLen[255]" name="APOS_ADDR" id="idAposAddr" maxlength="255" />
						</td>
						<td>策略编号<font color="red">*</font></td>
						<td>
							<input type="hidden" name="flag" id="idFlag" value="" />
							<input type="text" name="STRATEGY_ID" id="idStrategyId" class="readonly easyui-validatebox" readonly required="true" />
							<input type="button" class="btn_grid" id="btnStraSel" value="选择" onclick="selectStrategy()"/>
							<input type="button" class="btn_grid" id="btnStraClr" value="清空" onclick="$('#idStrategyId').val('');"/>
						</td>
					</tr>
					<tr>
						<td colspan="4" align="center">
							<input type="button" class="btn_grid" style="height:24px;" onclick="addAposFromDetail()" id="btnAddApos" value="增加应用终端"/>
						</td>
					</tr>
				</table>
			</fieldset>
		</form>
		
		<form id="dd" method="post">
			<fieldset id="appArea" style="padding:6px;width:95%;border:1px solid #46A3FF; color:#CC3300; line-height:2.0; font-size:12px;" align=center>
				<legend>应用终端应用明细</legend>
				<table class="formTable" style="width:98%;overflow:hidden;">
					<col width="15%" class="leftCol"/>
					<col width="35%" />
					<col width="15%" class="leftCol"/>
					<col width="35%"/>
					<tr>
						<td>应用<font color="red">*</font></td>
						<td>
							<input type="hidden" name="APP_ID" id="idAppId" value=""/>
							<input type="text" name="APP_NAME" id="idAppName" readonly class="readonly easyui-validatebox" required="true" />
							<input type="button" class="btn_grid" value="选择" id="btnQueryApp" onclick="queryApp('idAppId','idAppName');"/>
							<input type="button" class="btn_grid" value="清空" id="btnClearApp" onclick="clearApp('idAppId','idAppName');"/>
						</td>
						<td>应用版本<font color="red">*</font></td>
						<td>
							<select name="APP_VER" id="idAppVer" style="width:200px;" class="easyui-validatebox" required="true">
								<option value="">请选择应用版本</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>参数模板<font color="red">*</font></td>
						<td>
							<input type="hidden" name="SRC_MODEL_ID" id="idSrcModelId" value=""/>
							<select name="PARAM_MODEL_ID" id="idParamModelId" style="width:230px;" class="easyui-validatebox" required="true">
								<option value="">请选择参数模板</option>
							</select>
						</td>
						<td>主应用标志</td>
						<td>
							<select name="MASTER_APP_FLAG" id="idMasterAppFlag" style="width:150px;">
								<option value="0">否</option>
								<option value="1">是</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>商户</td>
						<td>
							<input type="hidden" name="MERCH_ID" id="idMerchId" value=""/>
							<input type="text" class="easyui-validatebox readonly" name="MERCH_NAME" id="idMerchName" readonly/>
							<input type="button" class="btn_grid" value="选择" id="btn_queryMerch" onclick="queryMerch();"/>
							<input type="button" class="btn_grid" value="清空" id="btn_clearMerch" onclick="clearMerch();"/>
						</td>
						<td>终端号</td>
						<td>
							<input type="text" class="easyui-validatebox" validType="numberCharFixLength[8]" name="TERMINAL_ID" id="idTerminalId" maxlength="8"/>
						</td>
					</tr>
					<tr>
						<td colspan="4" style="text-align:center;height:35px;">
							<input type="button" class="btn_grid" style="height:24px;" id="btnAddAppInfo" disabled onclick="addAposAppInfo()" value="增加应用明细" />
							<input type="button" class="btn_grid" style="height:24px;" id="btnUpdateAppInfo" onclick="updateAposAppInfo()" disabled value="修改应用明细"/>
						</td>
					</tr>
				</table>
			</fieldset>
		</form>
	</div>
  	<div region="center" style="overflow:hidden;">
  		<table id="idAposAppInfo"></table>
	</div>
	<div region="south" style="text-align:right;height:40px;" class="toolbarHeader">
		<input type="hidden" id="idIsCheck" value=""/>
		<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="doBack()">返 回</a>
	</div>
  </body>
</html>
