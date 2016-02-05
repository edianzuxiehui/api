<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.landi.tms.base.impl.IDtoImpl"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
IDtoImpl  person =   (IDtoImpl)request.getSession().getAttribute("person");
  String  operId = person.getAsString("OPER_ID");
  
%>
   <%if("00010000".equals(operId)){  //超级管理员%>
	<input id="isSuperAdmin" type="hidden"  value="true"/>
	<%} else {%>
    <input id="isSuperAdmin" type="hidden"  value="false"/>
	<%} %>
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
    <script type="text/javascript" src="core/recycletrace/RecycleTrace-js.js"></script>
	<script type="text/javascript">
	
		
		function queryInfo(){
			if($('#idBeginDate').val()!="" && $('#idEndDate').val()!="" && $('#idBeginDate').val()>$('#idEndDate').val()){
				msgShow("提示","选择的开始时间大于结束时间，请重新选择!","info");
			}else{	
		 	    clearSelect('idRecycleTrace');//防止页面选定一条记录后进行查询，原来的选定还存在，导致修改时选定多条
		        var date=new Date();
				var param="flag="+date.getTime()+"&REG_ID="+escape(escape($.trim($('#idRegId').val())))+"&BEGIN_DATE="+escape(escape($.trim($('#idBeginDate').val())))+"&END_DATE="+escape(escape($.trim($('#idEndDate').val())))+"&CHANGE_REMOVE_FLAG=2090";		////2表示的撤机操作
				param+="&TERMINAL_ID="+$.trim($('#idTerminalId').val())+"&MID="+escape(escape($.trim($('#idMidSelect').val())))+"&FID="+escape(escape($.trim($('#idFidSelect').val())));	   
				$('#idRecycleTrace').datagrid('options').url = "listAposChangeTrace.do?"+param;// 改变它的url  
				$("#idRecycleTrace").datagrid('load');
			}
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
	    <div region="north" style="height: 75%;position:relative;overflow: hidden;"   split="true">  
					<form id="queryForm">
						<table class="formTable" style="width:95%;">
							<col  width="7%" class="leftCol"/>
							<col width="15%" >
							<col  width="7%" class="leftCol"/>
							<col width="15%" >
							<col  width="7%" class="leftCol"/>
							<col width="18%" >
							<col  width="7%" class="leftCol"/>
							<col width="15%" >
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
								<td>分支机构</td>
								<td>
									<input type="hidden" class="easyui-validatebox"    name="REG_ID" id="idRegId" maxlength="8" />
									<input  type="hidden" class="easyui-validatebox"    name="REG_ENTIRE_ID" id="idRegEntireId" />
									<input type="text" class="" class="easyui-validatebox" style="background-color: #EEEEEE"  name="REG_NAME" id="idRegName" readonly="readonly" />
									<input id="idChoose" type="button" class="btn_grid" value="选择" onclick="queryReg('idRegId','idRegName','idRegEntireId')"/>
									<input id="idClear" type="button" class="btn_grid" value="清空" onclick="clearReg('idRegId','idRegName','idRegEntireId')"/>
									
								</td>
								<td>主应用终端号</td>
								<td>
									<input type="text" name="TERMINAL_ID" id="idTerminalId" maxlength="8"/>
								</td>
							</tr>
							<tr>
								<td>开始日期</td>
								<td>
									<input type="text" name="BEGIN_DATE" id="idBeginDate" maxlength="19" class="Wdate readonly" readonly onClick="WdatePicker()" />
								</td>
								<td>结束日期</td>
								<td >
									<input type="text" name="END_DATE" id="idEndDate" maxlength="19" class="Wdate readonly" readonly onClick="WdatePicker()" />
								</td>	
								<td></td>
								<td></td>							
								<td></td>
								<td>
									<input id="idQuery" type="button" class="btn_grid" value=" 查 询 " onclick="queryInfo()"/>
									<input id="idReset" type="button" class="btn_grid" value=" 重 置 " onclick="cleardata()"/>
								</td>
							</tr>
						</table>
					</form>
	     </div>
		<div region="center"  >  
			<table id="idRecycleTrace" ></table>
	    </div>
</body>
    <script language="javascript" type="text/javascript" src="<%=basePath%>js/DatePicker/WdatePicker.js"></script>

</html>
