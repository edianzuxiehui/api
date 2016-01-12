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
	<link rel="stylesheet" type="text/css" href="<%=basePath%>js/DatePicker/skin/WdatePicker.css.css">
	<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.min.js"></script>
	<script language="javascript" type="text/javascript" src="<%=basePath%>js/DatePicker/WdatePicker.js"></script>
	<script type="text/javascript" src="js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="js/Toolbar.js"></script>
    <script type="text/javascript" src="js/common.js"></script>
    <script type="text/javascript" src="core/posadvertising/PosAdvertising-js.js"></script>
	<script type="text/javascript">
		function doNew(){
			var retValue=openDialogFrame("<%=basePath%>core/posadvertising/PosAdvertising-add.jsp","","500","300");
			if(retValue=="true"){
				msgShow("新增","新增成功!","info");
				flashTable("idPosAdvertising");
			}else if(retValue=="false"){
			   msgShow("新增","新增失败!","error");
			}
		}
		
		
		function doEdit(){
			var ids=updateValidate("idPosAdvertising");
		    if(ids){
		    	var retValue=openDialogFrame("<%=basePath%>core/posadvertising/PosAdvertising-edit.jsp",ids,"500","300");
				if(retValue=="true"){
					msgShow("修改","修改成功!","info");
					flashTable("idPosAdvertising");
				}else if(retValue=="false"){
			       msgShow("修改","修改失败!","error");
			    }
		    }
			
		}
		
		function doDel(){
		 deleteNoteById("idPosAdvertising","delPosAdvertising.do", "");
		}
		
		function queryInfo(){
		 	   clearSelect('idPosAdvertising');//防止页面选定一条记录后进行查询，原来的选定还存在，导致修改时选定多条
		       var date=new Date();
			var param="flag="+date.getTime()+"&SYS_ID="+escape(escape($.trim($('#idSysId').val())))+"&APP_ID="+escape(escape($.trim($('#idAppId').val())))+"&MERCH_ID="+escape(escape($.trim($('#idMerchId').val())))+"&REG_ID="+escape(escape($.trim($('#idRegId').val())))+"&AD_CONTENT="+escape(escape($.trim($('#idAdContent').val())))+"&END_DATE="+escape(escape($.trim($('#idEndDate').val())))+"&MERCH_FLAG="+escape(escape($.trim($('#idMerchFlag').val())))+"&APP_FLAG="+escape(escape($.trim($('#idAppFlag').val())));			   
			$('#idPosAdvertising').datagrid('options').url = "listPosAdvertising.do?"+param;// 改变它的url  
			$("#idPosAdvertising").datagrid('load');
		}
		function cleardata(){
			$('#queryForm').form('clear');
		}
		
		
	</script>
</head>

<body class="easyui-layout" fit="true">
<script language="javascript" type="text/javascript" src="<%=basePath%>js/DatePicker/WdatePicker.js"></script>
	    <div region="north" style="height: 80px;position:relative;"   split="true">  
					<form id="queryForm">
						<table class="formTable" style="width:95%;">
				<col width="4%" class="leftCol"/>
				<col width="42%" >
				<col  width="7%" class="leftCol"/>
				<col width="30%" >
				<col width="17%">

							<tr>
								<td>应用</td>
								<td>
									<input type="hidden" name="APP_ID" id="idAppId" maxlength="8" />
									<input type="hidden" name="APP_FLAG" id="idAppFlag" maxlength="8" />
									<input type="text" name="APP_NAME" id="idAppName" readonly class="readonly"/>
									<input type="button" class="btn_grid" value="选择" onclick="queryApp('idAppId','idAppName','idAppFlag');"/>
									<input type="button" class="btn_grid" value="清空" onclick="clearApp('idAppId','idAppName','idAppFlag');"/>
									<input type="button" class="btn_grid" value="所有应用" onclick="allApp('idAppId','idAppName','idAppFlag');"/>
								</td>
								<td>分支机构</td>
								<td>
									<input type="hidden" name="REG_ID" id="idRegId" maxlength="8" />
									<input type="text" name="REG_NAME" id="idRegName" class="readonly" readonly="readonly" />
									<input id="idChoose" type="button" class="btn_grid" value="选择" onclick="queryReg('idRegId','idRegName');"/>
									<input id="idClear" type="button" class="btn_grid" value="清空" onclick="clearReg('idRegId','idRegName');"/>
								</td>
								<TD></TD>
							</tr>
							<tr>
								<td>商户</td>
								<td>
									<input type="hidden"    name="MERCH_ID" id="idMerchId"  />
									<input type="hidden"    name="MERCH_FLAG" id="idMerchFlag"  />
									<input type="text" class="easyui-validatebox readonly" readonly="readonly"   name="MERCH_NAME" id="idMerchName"  />
									<input  type="button" class="btn_grid" value="选择" onclick="selectMerchInfo('idMerchId','idMerchName','idMerchFlag');"/>
									<input id="idClear" type="button" class="btn_grid" value="清空" onclick="clearMerchInfo('idMerchId','idMerchName','idMerchFlag')"/>
									<input id="idAllMerch" type="button" class="btn_grid" value="所有商户" onclick="allMerchInfo('idMerchFlag','idMerchName')"/>
								</td>
								<td>结束时间</td>
								<td>
									<input type="text" name="END_DATE" id="idEndDate" maxlength="19" class="Wdate readonly" readonly onClick="WdatePicker()" />
								</td>
								<td>
								<input id="idQuery" type="button" class="btn_grid" value=" 查 询 " onclick="queryInfo()"/>
							     <input id="idReset" type="button" class="btn_grid" value=" 重 置 " onclick="cleardata()"/>
								</td>
							</tr>
						</table>
					</form>
	     </div>
		<div region="center"  border="false">  
			<table id="idPosAdvertising" ></table>
	    </div>
	      <div region="south" border="false" style="height: 30px;position:relative;background:url('<%=basePath%>images/indexbg.png') repeat;">  
			<div id="toolbar"></div>
	     </div>
</body>

</html>
