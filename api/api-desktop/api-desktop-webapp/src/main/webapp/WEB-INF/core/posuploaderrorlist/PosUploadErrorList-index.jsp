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
    <script type="text/javascript" src="core/posuploaderrorlist/PosUploadErrorList-js.js"></script>
    
	<script type="text/javascript">
		
		function queryInfo(){
			if($('#idBeginDate').val()!="" && $('#idEndDate').val()!="" && $('#idBeginDate').val()>$('#idEndDate').val()){
				msgShow("提示","选择的开始时间大于结束时间，请重新选择!","info");
			}else{
		 	   	clearSelect('idPosUploadErrorList');//防止页面选定一条记录后进行查询，原来的选定还存在，导致修改时选定多条
		       	var date=new Date();
				var param="flag="+date.getTime()+"&APOSID="+escape(escape($.trim($('#idAposId').val())))+"&BEGIN_DATE="+escape(escape($.trim($('#idBeginDate').val())))+"&END_DATE="+escape(escape($.trim($('#idEndDate').val())))+"&REG_ID="+escape(escape($.trim($('#idRegId').val())));
				$('#idPosUploadErrorList').datagrid('options').url = "listPosUploadErrorList.do?"+param;// 改变它的url  
				$("#idPosUploadErrorList").datagrid('load');
			}
		}
		function cleardata(){
			$('#queryForm').form('clear');
		}
	</script>
</head>

<body class="easyui-layout" fit="true">
<script language="javascript" type="text/javascript" src="<%=basePath%>js/DatePicker/WdatePicker.js"></script>
	    <div region="north" style="height: 70px;position:relative;"   split="true">  
					<form id="queryForm">
						<table class="formTable" style="width:95%;">
				<col width="8%" class="leftCol"/>
				<col width="20%" >
				<col  width="10%" class="leftCol"/>
				<col width="32%" >
				<col width="30%">

							<tr>
								<td>应用终端号</td>
								<td>
									<input type="text" name="APOS_ID" id="idAposId" maxlength="10" />
								</td>
								<td>分支机构</td>
								<td>
									<input type="hidden" name="REG_ID" id="idRegId" maxlength="8" />
									<input type="text" name="REG_NAME" id="idRegName" readonly class="readonly" />
									<input type="button" class="btn_grid" value="选择" onclick="queryReg('idRegId','idRegName');"/>
									<input type="button" class="btn_grid" value="清空" onclick="clearReg('idRegId','idRegName');"/>
								</td>
								<td >
								</td>
							</tr>
							<!-- 
							<tr>
							    <td>原主叫号码</td>
								<td>
									<input type="text" name="SCALLNO" id="idScallno" maxlength="16" />
								</td>
								<td>上送主叫号码</td>
								<td>
									<input type="text" name="PCALLNO" id="idPcallno" maxlength="16" />
								</td>
								<td >
								</td>
							
							</tr> -->
							<tr>
								<td>开始日期</td>
								<td>
									<input type="text" name="BEGIN_DATE" id="idBeginDate" maxlength="19" class="Wdate readonly" readonly onClick="WdatePicker()" />
								</td>
								<td >结束日期</td>
								<td >
									<input type="text" name="END_DATE" id="idEndDate" maxlength="19" class="Wdate readonly" readonly onClick="WdatePicker()" />
								</td>
								<td >
							     <input id="idQuery" type="button" class="btn_grid" value=" 查 询 " onclick="queryInfo()"/>
							     <input id="idReset" type="button" class="btn_grid" value=" 重 置 " onclick="cleardata()"/>
								</td>
							</tr>
						</table>
					</form>
	     </div>
		<div region="center"  >  
			<table id="idPosUploadErrorList" ></table>
	    </div>
</body>

</html>
