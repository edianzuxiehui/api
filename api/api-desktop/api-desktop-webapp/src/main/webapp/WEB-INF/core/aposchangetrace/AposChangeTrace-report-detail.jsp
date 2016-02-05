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
  <base target="_self">
	<title>统计明细</title>
	<link rel="stylesheet" type="text/css" href="themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="themes/icon.css">
	<link rel="stylesheet" type="text/css" href="css/default.css">
	<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="js/common.js"></script>
    <script type="text/javascript" src="core/aposchangetrace/AposChangeTrace-report-detail-js.js"></script>
	<script type="text/javascript">
		function queryInfo(){
			if($('#idBeginDate').val()!="" && $('#idEndDate').val()!="" && $('#idBeginDate').val()>$('#idEndDate').val()){
				msgShow("提示","选择的开始时间大于结束时间，请重新选择!","info");
			}else{	
		 	    clearSelect('idAposChangeTraceReportDetail');//防止页面选定一条记录后进行查询，原来的选定还存在，导致修改时选定多条
		        var date=new Date();
				var param="flag="+date.getTime()+"&REG_ID="+$.trim($('#idRegEntireId').val())
					+"&queryFlag="+$.trim($('#idQueryFlag').val())
					+"&BEGIN_DATE="+$('#idBeginDate').val()+"&END_DATE="+$('#idEndDate').val();			   
				$('#idAposChangeTraceReportDetail').datagrid('options').url = "listAposChangeTraceReportDetail.do?"+param;// 改变它的url  
				$("#idAposChangeTraceReportDetail").datagrid('load');
			}
		}
		function cleardata(){
			var queryFlag = $('#idQueryFlag').val();
			$('#queryForm').form('clear');
			$('#idQueryFlag').val(queryFlag);
		}
	</script>
</head>

<body class="easyui-layout" fit="true">
<script language="javascript" type="text/javascript" src="<%=basePath%>js/DatePicker/WdatePicker.js"></script>
	<!-- 
	<div region="north" style="height: 100px;position:relative;" title="查询面板"  split="true">  
		<form id="queryForm">
			<table class="formTable" style="width:95%;">
				<col  width="10%" class="leftCol"/>
				<col width="10%" >
				<col  width="10%" class="leftCol"/>
				<col width="10%" >
				<col  width="10%" class="leftCol"/>
				<col width="30%" >
				<col  width="20%" class="leftCol"/>
				<input type="hidden" id="idQueryFlag" name="queryFlag"/>
							<tr>
								<td>开始日期</td>
								<td>
									<input type="text" name="BEGIN_DATE" id="idBeginDate" maxlength="19" class="Wdate readonly" readonly onClick="WdatePicker()" />
								</td>
								<td>结束日期</td>
								<td>
									<input type="text" name="END_DATE" id="idEndDate" maxlength="19" class="Wdate readonly" readonly onClick="WdatePicker()" />
								</td>
								<td>分支机构</td>
								<td>
									<input type="hidden" class="easyui-validatebox" name="REG_ID" id="idRegId" maxlength="8" />
									<input type="hidden" name="REG_ENTIRE_ID" id="idRegEntireId"/>
									<input type="text" class="" style="background-color: #EEEEEE"  name="REG_NAME" id="idRegName" readonly="readonly" size="20"/>
									<input id="idChoose" type="button" class="btn_grid" value="选择" onclick="queryReg('idRegId','idRegName')"/>
									<input id="idClear" type="button" class="btn_grid" value="清空" onclick="clearReg('idRegId','idRegName')"/>
								</td>
								<td>
								<input id="idQuery" type="button" class="btn_grid" value=" 查 询 " onclick="queryInfo()"/>
								<input id="idReset" type="button" class="btn_grid" value=" 重 置 " onclick="cleardata()"/>
								</td>
							</tr>
						</table>
					</form>
	     </div>
	     -->
		<div region="center"  >  
			<table id="idAposChangeTraceReportDetail" ></table>
	    </div>
		<div region="south"   style="text-align:right;" class="toolbarHeader">
			<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="javascript:window.close()">关闭</a>
		</div>	   
</body>

</html>
