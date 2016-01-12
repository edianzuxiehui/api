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
  <div region="center">
    <div class="easyui-layout" fit="true">
				<div region="north" title="应用终端信息" style="height:130px;">
					<form id="ff" method="post">
						<table class="formTable" style="width:98%;overflow:hidden;">
							<col width="15%" class="leftCol"/>
							<col width="35%" />
							<col width="15%" class="leftCol"/>
							<col width="35%"/>

							<tr>
								<td>应用终端模板</td>
								<td>
									<select  name="APOS_MODEL_ID" id="idAposModelId" class="easyui-validatebox" required="true" style="width:150px">
									   <option value="">请选择应用终端模板</option>
									</select>
								</td>
								<td>分支机构</td>
								<td>
									<input type="hidden" name="REG_ID" id="idRegId" value=""/>
									<input type="hidden" name="REG_ENTIRE_ID" id="idRegEntireId" value=""/>
									<input type="text" class="easyui-validatebox readonly" name="REG_NAME" id="idRegName" required="true" readonly/>
									<input type="button" class="btn_grid" id="idRegSel" value="选择" onclick="queryReg('idRegId','idRegName','idRegEntireId');"/>
									<input type="button" class="btn_grid" id="idRegClr" value="清空" onclick="clearReg('idRegId','idRegName','idRegEntireId');"/>
								</td>
							</tr>
							<tr>
								<td>应用终端数量</td>
								<td>
									<input type="text" class="easyui-validatebox" required="true" validType="integer" name="APOS_NUM" id="idAposNum" maxlength="3" />
								</td>
								<td>布放地址</td>
								<td>
									<input type="text" class="easyui-validatebox" validType="maxLen[255]" name="APOS_ADDR" id="idAposAddr" maxlength="255" />
								</td>
							</tr>
							<tr>
								<td>策略编号</td>
								<td>
									<input type="text" name="STRATEGY_ID" id="idStrategyId" class="readonly easyui-validatebox" readonly required="true" />
									<input type="button" class="btn_grid" value="选择" onclick="selectStrategy()"/>
									<input type="button" class="btn_grid" value="清空" onclick="$('#idStrategyId').val('');"/>
								</td>
								<td colspan="2" align="left">
									<input type="button" class="btn_grid" style="height:24px;" id="btnAddApos" onclick="addAposFormAposModel()" value="增加应用终端"/>
								</td>
							</tr>
						</table>
					</form>
				</div>
				
				<div region="center">
					<table id="idAposModelAppInfo"></table>
				</div>
			</div>
			
	</div>
	<div region="south" style="text-align:right;height:40px;" class="toolbarHeader">
		<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="javascript:window.close();">返 回</a>
	</div>
  </body>
</html>
