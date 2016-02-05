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
	<title>策略选择</title>
	<link rel="stylesheet" type="text/css" href="themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="themes/icon.css">
	<link rel="stylesheet" type="text/css" href="css/default.css">
	<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="js/common.js"></script>
    <script type="text/javascript" src="core/taskinfo/Strategy-js.js"></script>
	<script type="text/javascript">
		setModuleNameAndId("queryForm");
		function queryInfo(){
		       clearSelect('idStrategy');//防止页面选定一条记录后进行查询，原来的选定还存在，导致修改时选定多条
		       var date=new Date();
				var param="flag="+date.getTime()//+"&STRATEGY_ID="+$('#idStrategyId').val()
					+"&STRA_BDATE="+$('#idStraBdate').val()+"&STRA_EDATE="+$('#idStraEdate').val()
					+"&REG_ID="+escape(escape($.trim($('#idRegId').val())))
					+"&DESC_TXT="+escape(escape($.trim($('#idDescTxt').val())))
					+"&POS_FLAG="+escape(escape($.trim($('#idPosFlag').val())));			   
			   $('#idStrategy').datagrid('options').url = "listStrategyForTask.do?"+param;// 改变它的url  
			   $("#idStrategy").datagrid('load');
		}
		function cleardata(){
			$('#queryForm').form('clear');
		}
		function retStrategyInfo(){
			var rows = $('#idStrategy').datagrid('getSelections');
		 	if(rows.length==0) {
		 		msgShow("提示","请选择策略","info");
		 	}else if(rows.length>1) {
		 		msgShow("提示","只能选择一个策略","info");
		 	}else{
		 		if($('#idStraFlag').val()=='changeStra'){
		 			var taskSysIds = $('#idTaskSysIds').val();
          			var aposIds = $('#idAposIds').val();//alert(taskSysIds+","+aposIds);alert(rows[0].STRATEGY_ID);
		 			var tmsModuleTitle= $("#idTmsModuleTitle").val();
   					var tmsModuleId= $("#idTmsModuleId").val();
   					//alert(tmsJ5ModuleId);alert(tmsModuleId);
		 			var param = {'STRATEGY_ID':rows[0].STRATEGY_ID,'taskSysIds':taskSysIds,'aposIds':aposIds,'tmsModuleId':tmsModuleId,'tmsModuleTitle':tmsModuleTitle};
		 			$.post('changeStra.do',param,function(data) {
			      		var myObject = eval('(' + data + ')');
				       if(myObject.status=="true"){
				       		 msgShow("策略重新分配",myObject.message,"info");
				       		 window.returnValue=rows[0].STRATEGY_ID;
				       		 window.close();
				        }else if(myObject.status=="false"){
				        	msgShow("策略重新分配",myObject.message,"error");
				        }
					});
		 		}else{
			 		window.returnValue=rows[0].STRATEGY_ID; 
			 		window.close();
		 		}
		 	}
		}
	</script>
</head>

<body class="easyui-layout" fit="true">
	    <div region="north" style="height: 100px;position:relative;" title="查询面板"  split="true">  
			<form id="queryForm">
				<table class="formTable" style="width:95%;">
				<col  width="8%" class="leftCol"/>
				<col width="17%" >
				<col  width="8%" class="leftCol"/>
				<col width="17%" >
				<col  width="8%" class="leftCol"/>
				<col width="17%" >
				<col  width="8%" class="leftCol"/>
				<col width="17%" >
				<input type="hidden" name="straFlag" id="idStraFlag" />
				<input type="hidden" name="taskSysIds" id="idTaskSysIds" />
				<input type="hidden" name="aposIds" id="idAposIds" />
							<tr>
								<td>接入方式</td><!-- (1代表电话接入,0代表tcp接入) -->
								<td>
				                  <select name="POS_FLAG" id="idPosFlag" style="width:145">
				     				<option selected value="">所有</option>
							          <option value="1">电话接入</option>
							          <option value="0">tcp接入</option>
				                  </select>
								</td>	
								<td>策略开始日期</td>
								<td>
									<input type="text" name="STRA_BDATE" id="idStraBdate" class="Wdate" readonly onClick="WdatePicker()"/>
								</td>
								<td>策略结束日期</td>
								<td>
									<input type="text" name="STRA_EDATE" id="idStraEdate" class="Wdate" readonly onClick="WdatePicker()"/>
								</td>
							</tr>
							<tr>
							   <td>分支机构</td>
								<td>
									<input type="hidden" class="easyui-validatebox" name="REG_ID" id="idRegId" maxlength="8" />
									<input type="hidden" class="easyui-validatebox" name="REG_ENTIRE_ID" id="idRegEntireId" />
									<input type="text" class="easyui-validatebox" style="background-color: #EEEEEE"  name="REG_NAME" id="idRegName" readonly="readonly" size="15"/>
									<input id="idChoose" type="button" class="btn_grid" value="选择" onclick="queryReg('idRegId','idRegName','idRegEntireId')"/>
								</td>
								<td>备注</td>
								<td>
									<input type="text" name="DESC_TXT" id="idDescTxt" maxlength="100" />
								</td>
							<td colspan="2">
							     <input id="idQuery" type="button" class="btn_grid" value=" 查 询 " onclick="queryInfo()"/>
							     <input id="idReset" type="button" class="btn_grid" value=" 重 置 " onclick="cleardata()"/>
							</td>
							</tr>
						</table>
					</form>
	     </div>
		<div region="center"  >  
			<table id="idStrategy" ></table>
	    </div>
	      <div region="south" style="text-align:right;height: 30px;position:relative;background:url('<%=basePath%>images/indexbg.png') repeat;">  
	     	<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="retStrategyInfo()">确认</a>
			<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="javascript:window.close()">取消</a>
	     </div>
</body>
<script language="javascript" type="text/javascript" src="<%=basePath%>js/DatePicker/WdatePicker.js"></script>
</html>
