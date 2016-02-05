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
    <script type="text/javascript" src="core/posptraceinfo/PospTraceInfo-js.js"></script>
	<script type="text/javascript">
			   $(document).ready(function(){
			     initDataForAppInfo('idRegId,idRegEntireId');
			     //initDataForDevAppFile('idMid');
		         var d=new Date();
		         var starttm = d.Format("YYYY-MM-DD");  
		         var dp=new Date(new Date().getTime()+1*24 * 60 *60*1000);
		         
		         $("#idBeginDate").val(starttm);
		         $("#idEndDate").val(dp.Format("YYYY-MM-DD"));
		        });
	
	
		function doNew(){
			var retValue=openDialogFrame("<%=basePath%>core/posptraceinfo/PospTraceInfo-add.jsp","","500","250");
			if(retValue=="true"){
				msgShow("新增","新增成功!","info");
				flashTable("idPospTraceInfo");
			}else if(retValue=="false"){
			   msgShow("新增","新增失败!","error");
			}
		}
		
		
		function doEdit(){
			var ids=updateValidate("idPospTraceInfo");
		    if(ids){
		    	var retValue=openDialogFrame("<%=basePath%>core/posptraceinfo/PospTraceInfo-edit.jsp",ids,"600","300");
				if(retValue=="true"){
					msgShow("修改","修改成功!","info");
					flashTable("idPospTraceInfo");
				}else if(retValue=="false"){
			       msgShow("修改","修改失败!","error");
			    }
		    }
			
		}
		
		function doDel(){
		 deleteNoteById("idPospTraceInfo","delPospTraceInfo.do", "");
		}
		
		function queryInfo(){
		 	   clearSelect('idPospTraceInfo');//防止页面选定一条记录后进行查询，原来的选定还存在，导致修改时选定多条
		       var date=new Date();
			var param="flag="+date.getTime()+"&POSP_TRACE_ID="+escape(escape($.trim($('#idPospTraceId').val())))+"&MERCH_ID="+escape(escape($.trim($('#idMerchId').val())))+"&TERMINAL_ID="+escape(escape($.trim($('#idTerminalId').val())))+"&SERIAL_NO="+escape(escape($.trim($('#idSerialNo').val())))+"&TASK_SYS_ID="+escape(escape($.trim($('#idTaskSysId').val())))+"&POSP_NOTICEE_INFO="+escape(escape($.trim($('#idPospNoticeeInfo').val())))+"&POSP_SYNC_FLAG="+escape(escape($.trim($('#idPospSyncFlag').val())))+"&POSP_SYNC_TIME="+escape(escape($.trim($('#idPospSyncTime').val())))+"&POSP_SYNC_BATCHID="+escape(escape($.trim($('#idPospSyncBatchid').val())))+"&REG_ENTIRE_ID="+escape(escape($.trim($('#idRegEntireId').val())))
			+"&BEGIN_DATE="+escape(escape($.trim($('#idBeginDate').val())))+"&END_DATE="+escape(escape($.trim($('#idEndDate').val())))+"&MID="+escape(escape($.trim($('#idMidSelect').val())))+"&FID="+escape(escape($.trim($('#idFidSelect').val())));			   
			$('#idPospTraceInfo').datagrid('options').url = "listPospTraceInfo.do?"+param;// 改变它的url  
			   $("#idPospTraceInfo").datagrid('load');
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
<script type="text/javascript" src="<%=basePath%>js/DatePicker/WdatePicker.js"></script>
	    <div region="north" style="height: 75px;position:relative;overflow: hidden;" title=""  split="true">  
					<form id="queryForm">
						<table class="formTable" style="width:100%;">
						<col  width="7%" class="leftCol"/>
						<col width="13%" >
						<col  width="7%" class="leftCol"/>
						<col width="18%" >
						<col  width="7%" class="leftCol"/>
						<col width="16%" >
						<col  width="7%" class="leftCol"/>
						<col width="25%" >
							<tr>
								<td>终端号</td>
								<td>
									<input type="text" name="TERMINAL_ID" id="idTerminalId" maxlength="8"  style="width:100px;"/>
								</td>
								<td>主应用商户</td>
								<td>
									<input type="text" name="MERCH_ID" id="idMerchId" maxlength="20" readonly="readonly" class="readonly"  />
									<input  type="button" class="btn_grid" value="选择" onclick="selectMerch('idMerchId');"/>
									<input id="idClear" type="button" class="btn_grid" value="清空" onclick="clearMerch('idMerchId')"/>
								</td>
								<td>分支机构</td>
								<td>
									<input type="hidden" class="easyui-validatebox"    name="REG_ID" id="idRegId" maxlength="8" />
									<input type="hidden"   name="REG_ENTIRE_ID" id="idRegEntireId" maxlength="50" />
									<input type="text" class="easyui-validatebox" style="background-color: #EEEEEE"  name="REG_NAME" id="idRegName" readonly="readonly" />
									<input id="idChoose" type="button" class="btn_grid" value="选择" onclick="queryReg('idRegId','idRegName','idRegEntireId')"/>
								</td>
								<td>建立时间</td>
								<td>
									<input type="text" name="BEGIN_DATE" id="idBeginDate" class="Wdate" style="width:100px;" type="text"  onClick="WdatePicker()" readonly="reandonly" >
								     至<input type="text" name="END_DATE" id="idEndDate" class="Wdate" style="width:100px;" type="text"  onClick="WdatePicker({minDate:'#F{$dp.$D(\'idBeginDate\')}'})" readonly="reandonly" >
								</td>
							</tr>
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
								<td>硬件序列号</td>
								<td>
									<input type="text" name="SERIAL_NO" id="idSerialNo" maxlength="30" />
								</td>
								<td>同步标记</td>
								<td>
									<select type="text" name="POSP_SYNC_FLAG" id="idPospSyncFlag" maxlength="1" style="width: 100px" >
									 	<option value="">全部</option>
									 	<option value="0">未同步</option>
									 	<option value="1">已同步</option>
									</select>
									<input id="idQuery" type="button" class="btn_grid" style="margin-left: 20px;" value=" 查 询 " onclick="queryInfo()"/>
							     <input id="idReset" type="button" class="btn_grid" value=" 重 置 " onclick="cleardata()"/>
								</td>
							</tr>
						</table>
					</form>
	     </div>
		<div region="center"  >  
			<table id="idPospTraceInfo" ></table>
	    </div>

</body>

</html>
