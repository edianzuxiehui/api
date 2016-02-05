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
	<title></title>
	<link rel="stylesheet" type="text/css" href="themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="themes/icon.css">
	<link rel="stylesheet" type="text/css" href="css/default.css">
	<link rel="stylesheet" type="text/css" href="themes/default/style.css">
	<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="js/Toolbar.js"></script>
    <script type="text/javascript" src="js/common.js"></script>
    <script type="text/javascript" src="core/rptplancomp/RptPlancomp-js.js"></script>
	<script type="text/javascript">
		function doNew(){
			var retValue=openDialogFrame("<%=basePath%>core/rptplancomp/RptPlancomp-add.jsp","","600","300");
			if(retValue=="true"){
				msgShow("新增","新增成功!","info");
				flashTable("idRptPlancomp");
			}else if(retValue=="false"){
			   msgShow("新增","新增失败!","error");
			}
		}
		
		
			$(document).ready(function(){
			     initDataForAppInfo('idRegId,idRegEntireId')
		         var d=new Date();
		         var starttm = d.Format("YYYY-MM-DD hh:mm:ss");  
		         $("#idEndDate").val(starttm);
		         
		        });
		
		
		function doEdit(){
			var ids=updateValidate("idRptPlancomp");
		    if(ids){
		    	var retValue=openDialogFrame("<%=basePath%>core/rptplancomp/RptPlancomp-edit.jsp",ids,"600","300");
				if(retValue=="true"){
					msgShow("修改","修改成功!","info");
					flashTable("idRptPlancomp");
				}else if(retValue=="false"){
			       msgShow("修改","修改失败!","error");
			    }
		    }
			
		}
		
		function doDel(){
		 deleteNoteById("idRptPlancomp","delRptPlancomp.do", "");
		}
		
		function queryInfo(){
		 	   // clearSelect('idRptPlancomp');//防止页面选定一条记录后进行查询，原来的选定还存在，导致修改时选定多条
		       // var date=new Date();
			// var param="flag="+date.getTime()+"&PLAN_CODE="+escape(escape($.trim($('#idPlanCode').val())))+"&REG_ENTIRE_ID="+escape(escape($.trim($('#idRegEntireId').val())))+"&BEGINDATE="+$('#idBeginDate').val()+"&ENDDATE="+$('#idEndDate').val()+"&TASK_UNDO="+$('#idTaskUndo').val()+"&ask_flag=1";			   
			   // $('#idRptPlancomp').datagrid('options').url = "listRptPlancomp.do?"+param;// 改变它的url  
			   // $("#idRptPlancomp").datagrid('load');
			  $("#Idquerytm").html('( '+$('#idBeginDate').val()+'--'+$('#idEndDate').val()+')');
			  $("#tbl").empty();
			  $("#idtblhead").show();
			  //$('#idplanbody').layout('collapse','north');  
			  $("#tbl").append('<thead bgcolor="#EEEEEE"> <th width="10%">计划代码</th><th width="10%">计划名称</th><th width="10%">任务总数</th><th width="10%">已完成数</th><th width="10%">未完成数</th><th width="10%">执行率</th></thead>');
			   var  param="PLAN_CODE="+escape(escape($.trim($('#idPlanCode').val())))+"&REG_ENTIRE_ID="+escape(escape($.trim($('#idRegEntireId').val())))+"&BEGINDATE="+escape(escape($.trim($('#idBeginDate').val())))+"&ENDDATE="+$('#idEndDate').val()+"&ask_flag=1";			   
			  $.getJSON("listRptPlancomp.do?"+param, function(data){
				$.each(data, function(i,item){
				$("#tbl").append('<tr ><td>'+item.PLAN_CODE+'</td><td>'+item.PLAN_NAME+'</td><td>'+item.ALLCOUNT+'</td><td align="center">'+item.COMPLET+'</td><td align="center">'+item.UNCOMPLET+'</td><td align="center">'+item.RATE+'</td></tr>');
			  });
			});      
			   
			   
		}
		function cleardata(){
			$('#queryForm').form('clear');
			     initDataForAppInfo('idRegId,idRegEntireId')
		         var d=new Date();
		         var starttm = d.Format("YYYY-MM-DD hh:mm:ss");  
		         $("#idEndDate").val(starttm);
		}
	</script>
</head>

<body class="easyui-layout"  id="idplanbody">
<script type="text/javascript" src="<%=basePath%>js/DatePicker/WdatePicker.js"></script>
	    <div region="north" style="height: 70px;position:relative;background:#EEEEEE" title=""  split="true">  
					<form id="queryForm">
						<table class="formTable" style="width:98%;">
				<col width="8%" class="leftCol"/>
				<col width="22%" >
				<col  width="8%" class="leftCol"/>
				<col width="22%" >
				<col width="25%" >
				<col width="15%">
		                 <tr>
								<td>计划名称</td>
								<td>
									<input type="hidden"  name="PLAN_CODE" id="idPlanCode" maxlength="8" />
									<input type="text"  style="background-color: #EEEEEE"  name="PLAN_NAME" id="idPlanName" readonly="readonly" />
									<input type="button" class="btn_grid" value="选择" onclick="queryPlan('idPlanCode','idPlanName')"/>
									<input type="button" class="btn_grid" value="清除" onclick="clearPlan('idPlanCode','idPlanName')"/>
								</td>
								<td>分支机构</td>
								<td>
									<input type="hidden" class="easyui-validatebox"    name="REG_ID" id="idRegId" maxlength="8" />
									<input type="hidden"   name="REG_ENTIRE_ID" id="idRegEntireId" maxlength="50" />
									<input type="text" class="easyui-validatebox" style="background-color: #EEEEEE"  name="REG_NAME" id="idRegName" readonly="readonly" />
									<input id="idChoose" type="button" class="btn_grid" value="选择" onclick="queryReg('idRegId','idRegName','idRegEntireId')"/>

								</td>
								<td>&nbsp;</td>
								</tr>
								<tr>
								
								<td>任务完成开始时间</td>
								<td>
								<input name="BEGINDATE" id="idBeginDate" class="Wdate" type="text" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"  readonly="reandonly" >
								</td>
								<td>任务完成结束时间</td>
								<td>
								<input name="ENDDATE" id="idEndDate" class="Wdate" type="text"  onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly="reandonly" >
								</td>
								<td>
								 <input id="idQuery" type="button" class="btn_grid" value=" 查 询 " onclick="queryInfo()"/>
							     <input id="idReset" type="button" class="btn_grid" value=" 重 置 " onclick="cleardata()"/>
							     <input id="idToExcel" type="button" class="btn_grid" value="导出Excel" onclick="doexport()"/>
								</td>
						
							</tr>
						</table>
					</form>
	     </div>
		<div region="center" style="text-align:center" >  
			<table width="90%"  border="0" cellspacing="0" cellpadding="5"  >
			  <tr>
			    <td align="center" class="reportTitle" height="50" colspan="2" > 任务完成情况统计 </td>
			  </tr>
			  <tr id="idtblhead"style="display:none">
			    <td colspan="2"> 查询日期：<label id="Idquerytm"></label> </td>
			  </tr>
			</table>
			
			<table width="90%"  border="0" cellspacing="0" cellpadding="5" class="report" id="tbl" >
			
			</table>
	    </div>
	      <div region="south" style="height: 30px;position:relative;background:url('<%=basePath%>images/indexbg.png') repeat;">  
	     </div>
</body>

</html>
