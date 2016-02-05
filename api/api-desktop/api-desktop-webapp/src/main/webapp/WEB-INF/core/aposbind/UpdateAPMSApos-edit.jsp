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
    <base target="_self" >
    <title></title>
    <link rel="stylesheet" type="text/css" href="themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="themes/icon.css">
	<link rel="stylesheet" type="text/css" href="css/default.css">
	<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="js/common.js"></script>
    <script type="text/javascript" src="core/aposinfo/AposInfo-com.js"></script>
	<script type="text/javascript" src="core/aposinfo/AposInfo-edit.js"></script>
	<script type="text/javascript" src="core/aposbind/UpdateAPMSComm-js.js"></script>
  </head>
  
  <body class="easyui-layout" >
  	<div region="center">
  		<div class="easyui-layout" fit="true">
			<div region="north" title="应用终端信息" style="height:100px;">
				<form id="ff" method="post">
					<table class="formTable" style="width:98%;overflow:hidden;">
						<col width="15%" class="leftCol"/>
						<col width="35%" />
						<col width="15%" class="leftCol"/>
						<col width="35%"/>
						<tr>
							<td>应用终端号</td>
							<td>
								<input type="hidden" name="flag" id="idFlag" value="" />
								<input type="text" name="APOS_ID" id="idAposId" value="" class="easyui-validatebox readonly" required="true" readonly/>							
							</td>
							<td>分支机构</td>
							<td>
								<input type="hidden" name="REG_ID" id="idRegId" value=""/>
								<input type="hidden" name="REG_ENTIRE_ID" id="idRegEntireId" value=""/>
								<input type="text" class="easyui-validatebox readonly" name="REG_NAME" id="idRegName" required="true" readonly/>
							</td>
						</tr>
						<tr>
							
							<td>布放地址</td>
							<td>
								<input type="text" class="easyui-validatebox" validType="maxLen[255]" name="APOS_ADDR" id="idAposAddr" maxlength="255" />
							</td>
							<td>&nbsp;</td>
							<td align="left">
								<input type="button" class="btn_grid" style="height:24px;" onclick="updateApos()" value="修改应用终端"/>
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div region="south" title="策略分配" style="height:70px;">
				<form id="ss" method="post">
					<table class="formTable" style="width:98%;overflow:hidden;">
						<col width="35%">
						<col width="35%"/>
						<col width="35%"/>
						
						<tr id="idStrategyInfo">
							<td>
								策略
								<input type="text" name="STRATEGY_ID" id="idStrategyId" class="readonly" readonly/>
							</td>
							<td>
								下次报到时间
								<input type="text" name="NEXT_SIGN_TIME" id="idNextSignTime" class="readonly" readonly/>
							</td>
							<td>
								周期
								<input type="text" name="INTERVAL_DAYS" id="idIntervalDays" class="readonly" readonly/>
							</td>
						</tr>
					</table>
					
				</form>
			</div>
			<div region="center">
				<div class="easyui-layout" fit="true">
					<div region="north" style="height:150px;" title="应用终端应用明细">
						<form id="dd" method="post">
					<table class="formTable" style="width:98%;overflow:hidden;">
						<col width="15%" class="leftCol"/>
						<col width="35%" />
						<col width="15%" class="leftCol"/>
						<col width="35%"/>
						<tr>
							<td>应用</td>
							<td>
								<input type="hidden" name="APP_ID" id="idAppId" value=""/>
								<input type="text" name="APP_NAME" id="idAppName" readonly class="readonly easyui-validatebox" required="true" />
								<input type="button" class="btn_grid" value="选择" id="btnQueryApp" onclick="queryApp('idAppId','idAppName');"/>
								<input type="button" class="btn_grid" value="清空" id="btnClearApp" onclick="clearApp('idAppId','idAppName');"/>
							</td>
							<td>应用版本</td>
							<td>
								<select name="APP_VER" id="idAppVer" style="width:150px;" class="easyui-validatebox" required="true">
									<option value="">请选择应用版本</option>
								</select>
							</td>
						</tr>
						<tr>
							<td>参数模板</td>
							<td>
								<input type="hidden" name="SRC_MODEL_ID" id="idSrcModelId" value=""/>
								<select name="PARAM_MODEL_ID" id="idParamModelId" style="width:150px;" class="easyui-validatebox" required="true">
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
							<td colspan="4" style="text-align:center;">
								<input type="button" class="btn_grid" style="height:24px;" id="btnAddAppInfo" onclick="addAposAppInfo()" value="添加应用明细"/>
								<input type="button" class="btn_grid" style="height:24px;" id="btnUpdateAppInfo" onclick="updateAposAppInfo()" disabled value="修改应用明细"/>
							</td>
						</tr>
					</table>
				</form>
					</div>
					<div region="center" border="false">
						<table id="idAposAppInfo"></table>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div region="south" style="text-align:right;height:45px;" class="toolbarHeader">
		<input type="button" id="idBackBtn" class="btn_grid" style="height:30px;font-size: 15px;" value=" 上一步 " onclick="doBack()"/>
		<input type="button" id="idFinishBtn" class="btn_grid" style="height:30px;font-size: 15px;" value=" 完 成 " onclick="doFinish()"/>
	</div>
  </body>
</html>
