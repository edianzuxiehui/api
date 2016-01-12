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
	<script type="text/javascript" src="core/posextraconfirm/PosExtraConfirm-view.js"></script>
  </head>
  
  <body class="easyui-layout">
  	<div region="north" title="实体终端信息" style="height:100px;">
  		<table class="formTable" style="width:98%;overflow:hidden;">
			<col width="15%" class="leftCol"/>
			<col width="35%" />
			<col width="15%" class="leftCol"/>
			<col width="35%"/>
			<tr>
				<td>主机型号</td>
				<td>
					<input type="text" name="MID" id="idMid" readonly/>
				</td>
				<td>硬件序列号</td>
				<td>
					<input type="text" name="SERIAL_NO" id="idSerialNo" readonly/>
				</td>
			</tr>
			<tr>
				<td>入库时间</td>
				<td>
					<input type="text" name="IN_DATE" id="idInDate" readonly/>
				</td>
				<td>备注</td>
				<td>
					<input type="text" name="DESC_TXT" id="idDescTxt" readonly/>
				</td>
			</tr>
		</table>
  	</div>
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
								<input type="text" class="easyui-validatebox readonly" name="REG_NAME" id="idRegName" required="true" readonly/>
							</td>
						</tr>
						<tr>
							
							<td>布放地址</td>
							<td>
								<input type="text" class="easyui-validatebox readonly" name="APOS_ADDR" id="idAposAddr" maxlength="255" readonly/>
							</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
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
