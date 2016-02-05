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
    <script type="text/javascript" src="js/Toolbar.js"></script>
    <script type="text/javascript" src="js/common.js"></script>
    <script type="text/javascript" src="core/recyclepos/RecyclePos-js.js"></script>
	<script type="text/javascript">


		function queryInfo(){
				clearSelect('idAposInfo');
		       var date=new Date();
				var param="flag="+date.getTime()+"&REG_ID="+escape(escape($.trim($('#idRegId').val())))+"&COMPLET_FLAG="+escape(escape($.trim($('#idCompletFlag').val())))+"&MERCH_ID="+escape(escape($.trim($('#idMerchId').val())))+"&TERMINALID="+escape(escape($.trim($('#idTerminalId').val())))+"&MID="+escape(escape($.trim($('#idMidSelect').val())))+"&FID="+escape(escape($.trim($('#idFidSelect').val())));			   
				$('#idAposInfo').datagrid('options').url = "listRecyePos.do?"+param;// 改变它的url  
			   $("#idAposInfo").datagrid('load');
		}
		function cleardata(){
			$('#queryForm').form('clear');
			$("#idFidSelect").get(0).options[0].selected = true
			$('#idMidSelect').empty();
			var option;
			option = new Option("请选择终端型号","");
			document.getElementById("idMidSelect").options.add(option);
		}
	</script>
</head>

<body class="easyui-layout" fit="true">
	    <div region="north" style="height: 80px;position:relative;overflow: hidden;"   split="true">  
					<form id="queryForm">
						<table class="formTable" style="width:100%;">
							<col  width="10%" class="leftCol"/>
							<col width="20%" >
							<col  width="10%" class="leftCol"/>
							<col width="20%" >
							<col  width="10%" class="leftCol"/>
							<col width="20%" >
							<tr>
								<td><div style="text-align: right;">厂商</div></td>
								<td>
									<select  name="FID" id="idFidSelect" maxlength="15" style="width:120px;" onchange="changeModelByFID(this.value);">
									   <option value="">请选择终端厂商</option>
									</select>
								</td>
								<td><div style="text-align: right;">终端型号</div></td>
								<td>
									<select  name="MID" id="idMidSelect" maxlength="20" style="width:120px;" >
									 <option value="">请选择终端型号</option>
									</select>
								</td>
								<td>分支机构编号</td>
								<td>
									<input type="hidden" class="easyui-validatebox"    name="REG_ID" id="idRegId" maxlength="8" />
									<input  type="hidden" class="easyui-validatebox"    name="REG_ENTIRE_ID" id="idRegEntireId" />
									<input type="text" class="" class="easyui-validatebox" style="background-color: #EEEEEE"  name="REG_NAME" id="idRegName" readonly="readonly" />
									<input id="idChoose" type="button" class="btn_grid" value="选择" onclick="queryReg('idRegId','idRegName','idRegEntireId')"/>
									<input id="idClear" type="button" class="btn_grid" value="清空" onclick="clearReg('idRegId','idRegName','idRegEntireId')"/>
								</td>
							</tr>
								<tr>
								<td>主应用终端号</td>
								<td>
									<input type="text" name="TERMINAL_ID" id="idTerminalId" maxlength="8" />
								</td>
								<td>主应用商户</td>
								<td>
									<input type="text" name="MERCH_ID" id="idMerchId" maxlength="1"class="readonly" readonly="readonly"/>	
									<input  type="button" class="btn_grid" value="选择" onclick="selectMerch('idMerchId');"/>
									<input id="idClear" type="button" class="btn_grid" value="清空" onclick="clearMerch('idMerchId')"/>
								</td>
								 <td>
								 </td>
							   	 <td>
							   	 <input id="idQuery" type="button" class="btn_grid" value=" 查 询 " onclick="queryInfo()"/>
							     <input id="idReset" type="button" class="btn_grid" value=" 重 置 " onclick="cleardata()"/>
							   	 </td>
							</tr>
						</table>
					</form>
	     </div>
		<div region="center"  >  
			<table id="idAposInfo" ></table>
	    </div>
	    <!--  
	      <div region="south" style="height: 30px;position:relative;background:url('<%=basePath%>images/indexbg.png') repeat;">  
			<div id="toolbar"></div>
	     </div>-->
</body>

</html>
