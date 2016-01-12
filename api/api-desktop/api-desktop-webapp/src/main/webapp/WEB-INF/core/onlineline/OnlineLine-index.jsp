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
    <script type="text/javascript" src="core/onlineline/OnlineLine-js.js"></script>
	<script type="text/javascript">
		function doNew(){
			var retValue=openDialogFrame("<%=basePath%>core/onlineline/OnlineLine-add.jsp","","600","300");
			if(retValue=="true"){
				msgShow("新增","新增成功!","info");
				flashTable("idOnlineLine");
			}else if(retValue=="false"){
			   msgShow("新增","新增失败!","error");
			}
		}
		
		
		function doEdit(){
			var ids=updateValidate("idOnlineLine");
		    if(ids){
		    	var retValue=openDialogFrame("<%=basePath%>core/onlineline/OnlineLine-edit.jsp",ids,"600","300");
				if(retValue=="true"){
					msgShow("修改","修改成功!","info");
					flashTable("idOnlineLine");
				}else if(retValue=="false"){
			       msgShow("修改","修改失败!","error");
			    }
		    }
			
		}
		
		function doDel(){
		 deleteNoteById("idOnlineLine","delOnlineLine.do", "");
		}
		
		function queryInfo(){
		    if($('#idTranBeginDate').val()!="" && $('#idTranCompletDate').val()!="" && $('#idTranBeginDate').val()>$('#idTranCompletDate').val()){
				msgShow("提示","选择的交易开始时间大于交易结束时间，请重新选择!","info");
				return;
			}
		 	   clearSelect('idOnlineLine');//防止页面选定一条记录后进行查询，原来的选定还存在，导致修改时选定多条
		       var date=new Date();
			   var param="flag="+date.getTime()+"&SYS_ID="+escape(escape($.trim($('#idSysId').val())))+"&TERMINALID="+escape(escape($.trim($('#idTerminalId').val())))+"&MERCH_ID="+escape(escape($.trim($('#idMerchId').val())))+"&TRAN_TYPE="+escape(escape($.trim($('#idTranType').val())))+"&TRAN_RESULT="+escape(escape($.trim($('#idTranResult').val())))+"&TRAN_BEGIN_DATE="+escape(escape($.trim($('#idTranBeginDate').val())))+"&TRAN_COMPLET_DATE="+escape(escape($.trim($('#idTranCompletDate').val())))+"&UP_APP_INFO="+escape(escape($.trim($('#idUpAppInfo').val())))+"&UP_DEV_INFO="+escape(escape($.trim($('#idUpDevInfo').val())))+"&UP_SITE_INFO="+escape(escape($.trim($('#idUpSiteInfo').val())))+"&TELE_NO="+escape(escape($.trim($('#idTeleNo').val())))+"&REG_ID="+escape(escape($.trim($('#idRegId').val())))+"&REG_ENTIRE_ID="+escape(escape($.trim($('#idRegEntireId').val())))+"&ERROR_INFO="+escape(escape($.trim($('#idErrorInfo').val())))+"&SERIAL_NO="+escape(escape($.trim($('#idSerialNo').val())));			  
			    $('#idOnlineLine').datagrid('options').url = "listOnlineLine.do?"+param;// 改变它的url  
			  //$('#idOnlineLine').datagrid('options').url = "listOnlineLine.do?"+param;// 改变它的url  
			   $("#idOnlineLine").datagrid('load');
		}
		
			function doexport(){
		      if($('#idTranBeginDate').val()!="" && $('#idTranCompletDate').val()!="" && $('#idTranBeginDate').val()>$('#idTranCompletDate').val()){
				msgShow("提示","选择的交易开始时间大于交易结束时间，请重新选择!","info");
				return;
			}
		 	   clearSelect('idOnlineLine');//防止页面选定一条记录后进行查询，原来的选定还存在，导致修改时选定多条
		       var date=new Date();
			   var param="oper=exp"+"flag="+date.getTime()+"&SYS_ID="+escape(escape($.trim($('#idSysId').val())))+"&TERMINALID="+escape(escape($.trim($('#idTerminalId').val())))+"&MERCH_ID="+escape(escape($.trim($('#idMerchId').val())))+"&TRAN_TYPE="+escape(escape($.trim($('#idTranType').val())))+"&TRAN_RESULT="+escape(escape($.trim($('#idTranResult').val())))+"&TRAN_BEGIN_DATE="+escape(escape($.trim($('#idTranBeginDate').val())))+"&TRAN_COMPLET_DATE="+escape(escape($.trim($('#idTranCompletDate').val())))+"&UP_APP_INFO="+escape(escape($.trim($('#idUpAppInfo').val())))+"&UP_DEV_INFO="+escape(escape($.trim($('#idUpDevInfo').val())))+"&UP_SITE_INFO="+escape(escape($.trim($('#idUpSiteInfo').val())))+"&TELE_NO="+escape(escape($.trim($('#idTeleNo').val())))+"&REG_ID="+escape(escape($.trim($('#idRegId').val())))+"&REG_ENTIRE_ID="+escape(escape($.trim($('#idRegEntireId').val())))+"&ERROR_INFO="+escape(escape($.trim($('#idErrorInfo').val())))+"&SERIAL_NO="+escape(escape($.trim($('#idSerialNo').val())));			  
			  //  $('#idOnlineLine').datagrid('options').url = "listOnlineLine.do?"+param;// 改变它的url  
			  //$('#idOnlineLine').datagrid('options').url = "listOnlineLine.do?"+param;// 改变它的url  
			   //$("#idOnlineLine").datagrid('load');
			    window.open(getRootPath()+"/listOnlineLine.do?"+param);
	}
		
		function cleardata(){
			$('#queryForm').form('clear');
		}
	</script>
</head>

<body class="easyui-layout" fit="true">
	    <div region="north" style="height: 70%;position:relative;" split="true">  
					<form id="queryForm">
						<table class="formTable" style="width:95%;">
				<col  width="10%" class="leftCol"/>
				<col width="25%" >
				
				<col  width="10%" class="leftCol"/>
				<col width="25%" >
				
				<col  width="8%" class="leftCol"/>
				<col width="8%" >
				
				<col width="10%" />

			
							<tr>
							  <td>交易开始时间</td>
								<td>
									 <input name="TRAN_BEGIN_DATE" id="idTranBeginDate" class="Wdate" type="text"  onClick="WdatePicker()" readonly="reandonly" >
									
								</td>
							
								<td>交易结束时间</td>
								<td>
									 <input name="TRAN_COMPLET_DATE" id="idTranCompletDate" class="Wdate" type="text"  onClick="WdatePicker()" readonly="reandonly" >
								
								</td>
								
								
							
								<td>交易类型</td>
								<td>
									<select  name="TRAN_TYPE" id="idTranType" maxlength="4" >
									<option value=" ">全部交易</option>
									</select>
								</td>
								
							
							   <td>主应用终端号</td>
								<td>  
	                               <input type="text" name="TERMINAL_ID" id="idTerminalId" maxlength="8"  />
	                            </td>
							
							</tr>
						
							<tr>
								  <td>分支机构</td>
								<td>
								
									<input type="hidden" class="easyui-validatebox"    name="REG_ID" id="idRegId" maxlength="8" />
									<input  type="hidden" class="easyui-validatebox"    name="REG_ENTIRE_ID" id="idRegEntireId" />
									<input type="text" class="" class="easyui-validatebox" style="background-color: #EEEEEE"  name="REG_NAME" id="idRegName" readonly="readonly" />
									<input id="idChoose" type="button" class="btn_grid" value="选择" onclick="queryReg('idRegId','idRegName','idRegEntireId')"/>
									<input id="idClear" type="button" class="btn_grid" value="清空" onclick="clearReg('idRegId','idRegName','idRegEntireId')"/>
									
								</td>
									     <td>主商户号</td>
								<td>
								
									<input type="text" name="MERCH_ID" id="idMerchId" maxlength="1"  readonly="readonly" class="readonly"/>	
									<input  type="button" class="btn_grid" value="选择" onclick="selectMerch('idMerchId');"/>
									<input id="idClear" type="button" class="btn_grid" value="清空" onclick="clearMerch('idMerchId')"/>
								</td>
						
								<td>交易结果</td>
								<td>
									<select  name="TRAN_RESULT" id="idTranResult" maxlength="2" />
									<option value="">全部</option> 
									<option value="00">成功</option> 
                                   	<option value="exception">失败</option> 
                                   	</select>
								</td>
							 
								
						       <td colspan="2">
						       	<div style="text-align: center;">
						       	<input id="idQuery" type="button" class="btn_grid" value="查 询 " onclick="queryInfo()"/>
							     <input id="idReset" type="button" class="btn_grid" value="重 置 " onclick="cleardata()"/>
							     <input id="idExport" type="button" class="btn_grid" value="导 出" onclick="doexport()"/>
							     </div>
							   </td>
							</tr>
						</table>
					</form>
	     </div>
		<div region="center" border="false" >  
			<table id="idOnlineLine" ></table>
	    </div>
	    <!-- 
	      <div region="south" style="height: 30px;position:relative;background:url('<%=basePath%>images/indexbg.png') repeat;">  
			<div id="toolbar"></div>
	     </div> -->
</body>
<script type="text/javascript" src="<%=basePath%>js/DatePicker/WdatePicker.js"></script>

</html>
