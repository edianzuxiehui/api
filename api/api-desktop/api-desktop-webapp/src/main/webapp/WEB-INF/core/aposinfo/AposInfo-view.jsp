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
	<script type="text/javascript" src="core/aposinfo/AposInfo-view.js"></script>
  </head>
  
  <body class="easyui-layout">
  	<div region="center">
  		<div class="easyui-layout" fit="true">
			<div region="north" title="应用终端信息" style="height:120px;">
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
								<input type="text" class="easyui-validatebox readonly" name="REG_NAME" id="idRegName" required="true" readonly/>
							</td>
						</tr>
						<!--  
						<tr class="optionalRow">
							
							<td>APMS建议的厂商</td>
							<td>
								<input type="text" class="easyui-validatebox readonly" name="APMS_FACTORY" id="idAPMSFactory" readonly/>
							</td>
							<td>APMS建议的型号</td>
							<td>
								<input type="text" class="easyui-validatebox readonly" name="APMS_MID" id="idAPMSMid" readonly/>
							</td>
						</tr>
						<tr class="optionalRow">
							<td>APMS建议的序列号</td>
							<td>
								<input type="text" class="easyui-validatebox readonly" name="APMS_SERIALNO" id="idAPMSSerialNo" readonly/>
							</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
						-->
					</table>
				</form>
			</div>
			<div region="center">
				<div class="easyui-layout" fit="true">

					<div region="center" border="false">
						<table id="idAposAppInfo"></table>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div region="south" style="text-align:right;height:40px;" class="toolbarHeader">
		<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="back()">返 回</a>
	</div>
  </body>
</html>
