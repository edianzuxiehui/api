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
	<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="js/Toolbar.js"></script><!-- 这个有用不能去啊，去了就出bug了，具体情况你自己看看吧，这个一时半伙说不清楚 -->
    <script type="text/javascript" src="js/common.js"></script>
    <script type="text/javascript" src="core/strategyreporttime/StrategyReportTime-js.js"></script>
    <script type="text/javascript" src="core/aposquery/AposQuery-js.js"></script>
	<script type="text/javascript">
		function doEdit(){
			 
			var ids=updateValidate("idStrategyReportTime");
		    if(ids){
		    	var retValue=openDialogFrame("<%=basePath%>core/strategyreporttime/StrategyReportTime-edit.jsp",ids,"400","260");
				if(retValue=="true"){
					msgShow("修改","修改成功!","info");
					//flashTable("idAposModel");
				}else if(retValue=="false"){
			       msgShow("修改","修改失败!","error");
			    }
			    flashTable("idStrategyReportTime");
		    }
			
		}
		//批量分配
	  function BatchEditStraegy(){
		  	var rows = $('#idStrategyReportTime').datagrid('getSelections');
			if(rows.length < 1){
				msgShow('提示消息','请选择你要进行策略分配的应用终端!','info');
				return;
			}
		    var straId;
		    var aposIds;
		    for(var i = 0; i < rows.length; i++){
			    if(null == aposIds || i == 0){
					aposIds = $.trim(rows[i].KEYID);
				} else {
					aposIds = $.trim(aposIds) + "," + $.trim(rows[i].KEYID);
				}
			}   
		   var retValue=openDialogFrame("<%=basePath%>core/strategyreporttime/strategy.jsp",aposIds,"800","400");
		    if( null != retValue){
			   if ( null != retValue.status) {
					msgShow('提示消息',retValue.message,'info');
					flashTable("idStrategyReportTime");
				} else {
					if(retValue.message!= null&& retValue.message !=" " ){
						msgShow('提示消息',retValue.message,'warning');
					}
				}
			    
			   }
		}
		
		function queryInfo(){
		 	   clearSelect('idStrategyReportTime');//防止页面选定一条记录后进行查询，原来的选定还存在，导致修改时选定多条
		       var date=new Date();
			var param="flag="+date.getTime()+"&APOSID="+escape(escape($.trim($('#idAposId').val())))+"&REG_ID="+escape(escape($.trim($('#idRegId').val())))+"&REG_ENTIRE_ID="+escape(escape($.trim($('#idRegEntireId').val())))+"&SERIALNO="+escape(escape($.trim($('#idSerialNo').val())))+"&COMPLET_FLAG="+escape(escape($.trim($('#idCompletFlag').val())))+"&ORG_ID="+escape(escape($.trim($('#idOrgId').val())))+"&TERMINALID="+escape(escape($.trim($('#idTerminalId').val())))+"&MERCH_ID="+escape(escape($.trim($('#idMerchId').val())));			
			   $('#idStrategyReportTime').datagrid('options').url = "strategyreporttime.do?"+param;// 改变它的url  
			   $("#idStrategyReportTime").datagrid('load');
		}
		function cleardata(){
			$('#queryForm').form('clear');
		}
		
	</script>
</head>

<body class="easyui-layout" fit="true">
	    <div region="north" style="height: 70%;position:relative;"   split="true">  
					<form id="queryForm">
				<table class="formTable" style="width:95%;">
				<col  width="8%" class="leftCol"/>
				<col width="11%" >

			    <col  width="8%" class="leftCol"/>
				<col width="27%" >

		        <col  width="10%" class="leftCol"/>
				<col width="11%" >
				<col  width="8%" class="leftCol"/>

							<tr>
								<td>应用终端号</td>
								<td>
									<input type="text" name="APOS_ID" id="idAposId" maxlength="10" style="width: 100%"/>
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
	                               <input type="text" name="TERMINAL_ID" id="idTerminalId" maxlength="8" style="width: 100%"/></td>
								
							</tr>
							<tr>
							  <td>硬件序列号</td>
								<td>
									<input type="text" name="SERIAL_NO" id="idSerialNo" maxlength="30" style="width: 100%"/>
								</td>
							 
								
							     <td>主商户号</td>
								<td>
								
									<input type="text" name="MERCH_ID" id="idMerchId" maxlength="1" readonly="readonly" class="readonly"/>	
									<input  type="button" class="btn_grid" value="选择" onclick="selectMerch('idMerchId');"/>
									<input id="idClear" type="button" class="btn_grid" value="清空" onclick="clearMerch('idMerchId')"/>
								</td>
						    	 <td>完成状态</td>
								<td>
									<select  name="COMPLET_FLAG" id="idCompletFlag" maxlength="1"  style="width: 100%">
									     	<option value="">请选择</option>
		          	                    	<option  value="0">未完成</option>
		          	                     	<option value="1">已完成</option>
                                    </select>									
								</td>
								<td>
							     <input id="idQuery" type="button" class="btn_grid" value=" 查 询 " onclick="queryInfo()"/>
							     <input id="idReset" type="button" class="btn_grid" value=" 重 置 " onclick="cleardata()"/>
							   </td>
							</tr>
						</table>
					</form>
	     </div>
		<div region="center"  >  
			<table id="idStrategyReportTime"></table>
	    </div>
	  
</body>

</html>
