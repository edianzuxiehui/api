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
    
    <title>由模板生成</title>
    <link rel="stylesheet" type="text/css" href="themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="themes/icon.css">
	<link rel="stylesheet" type="text/css" href="css/default.css">
	<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="js/common.js"></script>
	<script type="text/javascript" src="core/aposinfo/addAposFromAposModel.js"></script>
	
  </head>
  
  <body class="easyui-layout">
  	<div region="north" style="height:140px;">
		<form id="ff" method="post">
			<fieldset id="aposArea" style="padding:6px;width:95%;border:1px solid #46A3FF; color:#CC3300; line-height:2.0; font-size:12px;" align=center>
			<legend>应用终端信息</legend>
			<table class="formTable" style="width:98%;overflow:hidden;">
				<col width="15%" class="leftCol"/>
				<col width="35%" />
				<col width="15%" class="leftCol"/>
				<col width="35%"/>

				<tr>
					<td>应用终端模板<font color="red">*</font></td>
					<td>
						<select  name="APOS_MODEL_ID" id="idAposModelId" class="easyui-validatebox" required="true" style="width:250px">
						   <option value="">请选择应用终端模板</option>
						</select>
					</td>
					<td>分支机构<font color="red">*</font></td>
					<td>
						<input type="hidden" name="REG_ID" id="idRegId" value=""/>
						<input type="hidden" name="REG_ENTIRE_ID" id="idRegEntireId" value=""/>
						<input type="text" class="easyui-validatebox readonly" name="REG_NAME" id="idRegName" required="true" readonly/>
						<input type="button" class="btn_grid" id="idRegSel" value="选择" onclick="queryReg('idRegId','idRegName','idRegEntireId');"/>
						<input type="button" class="btn_grid" id="idRegClr" value="清空" onclick="clearReg('idRegId','idRegName','idRegEntireId');"/>
					</td>
				</tr>
				<tr>
					<td>应用终端数量<font color="red">*</font></td>
					<td>
						<input type="text" class="easyui-validatebox" required="true" validType="numberLessThan[100]" name="APOS_NUM" id="idAposNum" maxlength="3" />
					</td>
					<td>布放地址</td>
					<td>
						<input type="text" class="easyui-validatebox" validType="maxLen[255]" name="APOS_ADDR" id="idAposAddr" maxlength="255" />
					</td>
				</tr>
				<tr>
					<td>策略编号<font color="red">*</font></td>
					<td>
						<input type="text" name="STRATEGY_ID" id="idStrategyId" class="readonly easyui-validatebox" readonly required="true" style="width:162px"/>
						<input type="button" class="btn_grid" value="选择" onclick="selectStrategy()"/>
						<input type="button" class="btn_grid" value="清空" onclick="$('#idStrategyId').val('');"/>
					</td>
					<td></td>
					<td align="left">
						<input type="button" class="btn_grid" style="height:24px;" id="btnAddApos" onclick="addAposFormAposModel()" value="增加应用终端"/>
					</td>
				</tr>
			</table>
			</fieldset>
		</form>
	</div>
	<div region="center">
		<table id="idAposModelAppInfo" title="应用终端模板应用明细" idField="KEYID">
		<thead>
			<tr>
				<th field="APP_ID" align="center" width="100">应用编号</th>
				<th field="APP_NAME" align="center" width="100">应用名称</th>
				<th field="APP_VER" align="center" width="100">应用版本</th>
				<th field="MASTER_FLAG" align="center" width="100">主应用标志</th>
				<th field="PARAM_MODEL_ID" align="center" width="100" formatter="pmFormatter">参数模板</th>
			</tr>
		</thead>
	</table>
	</div>
	<div region="south" style="text-align:right;height:40px;" class="toolbarHeader">
		<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="window.close();">返 回</a>
	</div>
  </body>
</html>
