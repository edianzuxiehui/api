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
    <script type="text/javascript" src="core/aposbind/AposBindDev-js.js"></script>
	<script type="text/javascript">
		
		function queryAposInfo(){
			clearSelect('idUnboundAposInfo');
		    var date=new Date();
			var param="flag="+date.getTime()+"&MERCH_ID="+escape(escape($.trim($('#idMerchId').val())))+"&TERMINALID="+escape(escape($.trim($('#idTerminalId').val())));			   
			$('#idUnboundAposInfo').datagrid('options').url = "listUnBoundAposInfo.do?"+param;// 改变它的url  
			$("#idUnboundAposInfo").datagrid('load');
		}
		
		function queryDevInfo(){
		    clearSelect('idPosDevInfo');//防止页面选定一条记录后进行查询，原来的选定还存在，导致修改时选定多条
		    var date=new Date();
			var param="flag="+date.getTime()+"&MID="+escape(escape($.trim($('#idMidSelect').val())))
						+"&SERIAL_NO="+$.trim($('#idSerialNo').val())+"&DEV_STATUS=0"
						+"&REG_ENTIRE_ID="+$('#idRegEntireId').val()
						+"&REG_ID="+$('#idRegId').val();			   
			//alert(param);
			$('#idPosDevInfo').datagrid('options').url = "listPosDevInfo.do?"+param;// 改变它的url  
			$("#idPosDevInfo").datagrid('load');
		}
		function cleardata(queryForm){
			$('#'+queryForm).form('clear');
		}
		
		
		
	</script>
</head>

<body class="easyui-layout" fit="true" >

		<div region="center"  title="应用终端"  split="false"> 
			<div class="easyui-layout" fit="true">
					<div region="north" style="height: 70px;position:relative;"   split="true">  
					<form id="queryFormApos">
						<table class="formTable" style="width:95%;">
							<col  width="90px" class="leftCol"/>
							<col width="250px" >
							<col width="80px" >

											<tr>
											<td>主应用商户</td>
											<td>
												<input type="text" name="MERCH_ID" id="idMerchId" maxlength="20" readonly="readonly" class="readonly" />
												<input  type="button" class="btn_grid" value="选择" onclick="selectMerch('idMerchId');"/>
												<input id="idClear" type="button" class="btn_grid" value="清空" onclick="clearMerch('idMerchId')"/>
											</td>
											<td align="right">
											<input id="idQuery" type="button" class="btn_grid" value=" 查 询 " onclick="queryAposInfo()"/>
											</td>
											</tr>
											<tr>
											<td>主应用终端号</td>
											<td>
												<input type="text" name="TERMINAL_ID" id="idTerminalId" maxlength="8" />
											</td>
											<td align="right">
										     <input id="idReset" type="button" class="btn_grid" value=" 重 置 " onclick="cleardata('queryFormApos')"/>
											</td>
										</tr>
									</table>
								</form>
				     </div>
					<div region="center"  >  
						<table id="idUnboundAposInfo" ></table>
				    </div>
			</div>
		</div>
		<div region="east" style="width: 543px;"  title="实体终端"  split="false"> 
			<div class="easyui-layout" fit="true">
				 <div region="north" style="height: 70px;position:relative;"  split="true">  
					<form id="queryFormDev">
					   <table class="formTable" style="width:95%;">
						<col  width="66px" class="leftCol"/>
						<col width="180px" >
						<col  width="84px" class="leftCol"/>
						<col width="150px" >
						<col width="70px" >
									<tr>
		
											<td>厂商</td>
											<td>
												<select  name="FID" id="idFidSelect" maxlength="15" style="width: 148px;" onchange="changeModelByFID(this.value);">
												   <option value="">请选择终端厂商</option>
												</select>
											</td>
											
											<td>主机型号</td>
											<td>
												<select type="text" name="MID" id="idMidSelect" maxlength="20" style="width: 148px;" >
												 <option value="">请选择主机型号</option>
												</select>
											</td>
											<td align="right">
												<input id="idQuery" type="button" class="btn_grid" value=" 查 询 " onclick="queryDevInfo()"/>
											</td>
										</tr>
										<tr>
										<td>分支机构</td>
										<td>
											<input type="hidden" class="easyui-validatebox" name="REG_ID" id="idRegId" maxlength="8" />
											<input type="hidden" name="REG_ENTIRE_ID" id="idRegEntireId"/>
											<input type="text" class="easyui-validatebox" style="background-color: #EEEEEE" readonly name="REG_ID" id="idRegName" size="15"/>
											<input id="idChoose" type="button" class="btn_grid" value="选择" onclick="queryReg('idRegId','idRegName','idRegEntireId')"/>
										</td>
										<td>硬件序列号</td>
										<td>
											<input type="text" name="SERIAL_NO" id="idSerialNo" maxlength="30" />
										</td>	
										<td  align="right">
									     <input id="idReset" type="button" class="btn_grid" value=" 重 置 " onclick="cleardata('queryFormDev')"/>
										</td>
									</tr>
						
								</table>
							</form>
			     </div>
				<div region="center"  >  
					<table id="idPosDevInfo" ></table>
			    </div>
			</div>
		</div>
	    
	    <!--  
	      <div region="south" style="height: 30px;position:relative;background:url('<%=basePath%>images/indexbg.png') repeat;">  
			<div id="toolbar"></div>
	     </div>-->
	     <div region="south"   style="text-align:right;" class="toolbarHeader">
	    <input type="hidden" id="idTmsModuleTitle"  name="tmsModuleTitle">
	    <input type="hidden" id="idTmsModuleId" name="tmsModuleId">
		<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="aposBindDev();">绑定</a>
		<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="javascript:window.close()">关闭</a>
		</div>
</body>

</html>
