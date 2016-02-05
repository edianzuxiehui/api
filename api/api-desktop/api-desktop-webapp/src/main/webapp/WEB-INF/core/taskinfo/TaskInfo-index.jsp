<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<jsp:directive.page import="com.landi.tms.util.GlobalConstants"/>
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
    <script type="text/javascript" src="core/taskinfo/TaskInfo-js.js"></script>
	<script type="text/javascript">
		function doNew(){
			var retValue=openDialogFrame("<%=basePath%>core/taskinfo/TaskInfo-add.jsp","","800","650");
			/*if(retValue=="true"){
				msgShow("新增","新增成功!","info");
				flashTable("idTaskInfo");
			}else if(retValue=="false"){
			   msgShow("新增","新增失败!","error");
			}*/
			flashTable('idTaskInfo');
			//$("#idTaskInfo").datagrid('load');
		}
		
		
		function doEdit(){
			var ids=updateValidate("idTaskInfo");
		    if(ids){
		    	var retValue=openDialogFrame("<%=basePath%>core/taskinfo/TaskInfo-edit.jsp",ids,"800","450");
				if(retValue=="true"){
					msgShow("修改","修改成功!","info");
					flashTable("idTaskInfo");
				}else if(retValue=="false"){
			       msgShow("修改","修改失败!","error");
			    }
		    }
			
		}
		
		function doDel(){
		 deleteNoteById("idTaskInfo","delTaskInfo.do", "");
		}
		
		function queryInfo(){
		 	clearSelect('idTaskInfo');//防止页面选定一条记录后进行查询，原来的选定还存在，导致修改时选定多条
		    var date=new Date();
			var param="flag="+date.getTime()+"&PLAN_NAME="+escape(escape($.trim($('#idPlanName').val())))
			+"&SERIALNO="+escape(escape($.trim($('#idSerialNo').val())))
			+"&DEV_ID="+escape(escape($.trim($('#idDevId').val())))
			+"&TASK_STATUS="+escape(escape($.trim($('#idTaskStatus').val())))
			+"&MERCH_ID="+escape(escape($.trim($('#idMerchId').val())))
			+"&TERMINAL_ID="+escape(escape($.trim($('#idTerminalId').val())))
			+"&MID="+escape(escape($.trim($('#idMidSelect').val())))
			+"&FID="+escape(escape($.trim($('#idFidSelect').val())))
			+"&BEGIN_DATE="+escape(escape($.trim($('#idBeginDate').val())))
			+"&END_DATE="+escape(escape($.trim($('#idEndDate').val())));
			$('#idTaskInfo').datagrid('options').url = "listTaskInfo.do?"+param;// 改变它的url  
			//$("#idTaskInfo").datagrid('load');
			flashTable('idTaskInfo');
		}
		function cleardata(){
			$('#queryForm').form('clear');
			$("#idFidSelect").get(0).options[0].selected = true
			$('#idMidSelect').empty();
			var option;
			option = new Option("请选择终端型号","");
			document.getElementById("idMidSelect").options.add(option);
		}
		
		setModuleNameAndIdFromTab('queryForm');
		
	</script>
</head>

<body class="easyui-layout" fit="true">
<script type="text/javascript" src="<%=basePath%>js/DatePicker/WdatePicker.js"></script>
	    <div region="north" style="height: 100px;position:relative;" title=""  split="true">  
			<form id="queryForm">
				<table class="formTable" style="width:95%;">
				<col  width="10%" class="leftCol"/>
				<col width="26%" >
				<col  width="9%" class="leftCol"/>
				<col width="23%" >
				<col  width="7%" class="leftCol"/>
				<col width="25%" >
							<tr>
								<td>计划名称</td>
								<td>
									<input type="text" name="PLAN_NAME" id="idPlanName" maxlength="8" style="width:9em"/>
								</td>
								<td>硬件序列号</td>
								<td>
									<input type="text" name="SERIAL_NO" id="idSerialNo" maxlength="30"  style="width: 150px;"/>
								</td>
								<td>任务状态</td>
								<td>
						          <select name="TASK_STATUS" id="idTaskStatus" style="width:9em">
						        	    <option value=" ">全部</option> 
				                        <option value="<%=GlobalConstants.PLAN_UN_COMPLETE %>">未完成</option>		        	    
						                <option value="<%=GlobalConstants.PLAN_COMPLETE %>">已完成</option>
						          </select>									
								</td>
							</tr>
							<tr>
								<td>主应用商户</td>
								<td>
									<input type="text" name="MERCH_ID" id="idMerchId" maxlength="15" class="readonly" style="width:9em"/>
									<input  type="button" class="btn_grid" value="选择" onclick="selectMerch('idMerchId');"/>
									<input id="idClear" type="button" class="btn_grid" value="清空" onclick="clearMerch('idMerchId')"/>
								</td>
								<td>主应用终端号</td>
								<td>
									<input type="text" name="TERMINAL_ID" id="idTerminalId" maxlength="8" style="width:9em"/>
								</td>
								<td>计划开始时间</td>
								<td><input type="text" name="BEGIN_DATE" id="idBeginDate" class="Wdate" style="width:100px;" type="text"  onClick="WdatePicker({maxDate:'#F{$dp.$D(\'idEndDate\')}'})" readonly="reandonly" >
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
								<td colspan="2">
									<div style="text-align:left;margin-left:80px;">
										<input id="idQuery" type="button" class="btn_grid" value="  查  询  " onclick="queryInfo()"/>
									     <input id="idReset" type="button" class="btn_grid" value="  重  置  " onclick="cleardata()"/>
								     </div>
								</td>
							</tr>
					<!-- 		<tr>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							
							<td>&nbsp;</td>
							<td>
							<input id="idGenPosp" type="button" class="btn_grid" value=" 生 成 通 知 " onclick="genNotice()"/>
							</td>	
							</tr> -->
						</table>
					</form>
	     </div>
		<div region="center"  border="false">  
			<table id="idTaskInfo" ></table>
				<div id="checkDialog" class="easyui-dialog" title="任务审核" 
				style="padding:5px;width:400px;height:200px;"
				>
					<p>是否同意审核？</p>
				</div>
	    </div>
	      <div region="south" border="false" style="height: 30px;position:relative;background:url('<%=basePath%>images/indexbg.png') repeat;">  
			<div id="toolbar"></div>
	     </div>
</body>

</html>
