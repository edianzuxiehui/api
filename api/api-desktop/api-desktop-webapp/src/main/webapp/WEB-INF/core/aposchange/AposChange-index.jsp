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
    <script type="text/javascript" src="core/aposchange/AposChange-js.js"></script>
	<script type="text/javascript">
		function doNew(){
			var retValue=openDialogFrame("<%=basePath%>core/aposbind/AposBindMID.jsp","","800","500");
			if(retValue=="true"){
				msgShow("绑定","绑定成功!","info");
				flashTable("idAposInfo");
			}else if(retValue=="false"){
			   msgShow("新增","新增失败!","error");
			}
		}
		
		
		function doEdit(){
			flashTable("idAposInfo");
		}
		
//		function doDel(){
//		 	msgShow("删除","本模块不提供删除操作","warning");
//		}
		
		function queryInfo(){
				clearSelect('idAposInfo');
		       var date=new Date();
				var param="flag="+date.getTime()+"&APOSID="+escape(escape($.trim($('#idAposId').val())))+"&REG_ID="+escape(escape($.trim($('#idRegId').val())))+"&AUTH_FLAG="+escape(escape($.trim($('#idAuthFlag').val())))+"&MERCH_ID="+escape(escape($.trim($('#idMerchId').val())))+"&TERMINALID="+escape(escape($.trim($('#idTerminalId').val())));			   
				$('#idAposInfo').datagrid('options').url = "listChangeableAposInfo.do?"+param;// 改变它的url  
			   $("#idAposInfo").datagrid('load');
		}
		function cleardata(){
			$('#queryForm').form('clear');
		}
	</script>
</head>

<body class="easyui-layout" fit="true">
	    <div region="north" style="height: 80px;position:relative;"   split="true">  
					<form id="queryForm">
						<table class="formTable" style="width:95%;">
				<col width="10%" class="leftCol"/>
				<col width="20%" >
				<col  width="8%" class="leftCol"/>
				<col width="32%" >
				<col  width="8%" class="leftCol"/>
				<col width="32%" >
				

							<tr>
								<td>应用终端号</td>
								<td>
									<input type="text" name="APOS_ID" id="idAposId" maxlength="10" />
								</td>
								<td>分支机构</td>
								<td>
									<input type="hidden" name="REG_ID" id="idRegId" maxlength="8" />
									<input type="text" name="REG_NAME" id="idRegName" class="readonly" readonly="readonly"  />
									<input id="idChoose" type="button" class="btn_grid" value="选择" onclick="queryReg('idRegId','idRegName');"/>
									<input id="idClear" type="button" class="btn_grid" value="清空" onclick="clearReg('idRegId','idRegName');"/>
								</td>
								<td>授权状态</td>
								<td>
									<select type="text" name="AUTH_FLAG" id="idAuthFlag" maxlength="20" style="width: 50%" >
									 	<option value="">全部</option>
									 	<option value="0">未授权</option>
									 	<option value="1">允许换机</option>
									 	<option value="2">本机换本机</option>
									</select>
								</td>
							</tr>
								<tr>
								<td>主应用终端号</td>
								<td>
									<input type="text" name="TERMINAL_ID" id="idTerminalId" maxlength="8" />
								</td>
								<td>主应用商户</td>
								<td>
									<input type="text" name="MERCH_ID" id="idMerchId" maxlength="20" readonly="readonly" class="readonly"  />
									<input  type="button" class="btn_grid" value="选择" onclick="selectMerch('idMerchId');"/>
									<input id="idClear" type="button" class="btn_grid" value="清空" onclick="clearMerch('idMerchId')"/>
								</td>
								
								<td></td>
								<td>
								<input id="idQuery" type="button" class="btn_grid" value=" 查 询 " onclick="queryInfo()"/>
							     <input id="idReset" type="button" class="btn_grid" value=" 重 置 " onclick="cleardata()"/>
								</td>
							</tr>
						</table>
					</form>
	     </div>
		<div region="center"  border="false">  
			<table id="idAposInfo" ></table>
	    </div>
	    <!--  
	      <div region="south" style="height: 30px;position:relative;background:url('<%=basePath%>images/indexbg.png') repeat;">  
			<div id="toolbar"></div>
	     </div>-->
</body>

</html>
