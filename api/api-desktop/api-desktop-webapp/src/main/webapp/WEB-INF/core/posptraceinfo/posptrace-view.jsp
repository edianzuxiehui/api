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
	<title>POSP通知信息</title>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/icon.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/default.css">
	<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/easyui-lang-zh_CN.js"></script>
	      <script type="text/javascript" src="<%=basePath%>js/common.js"></script>

		<script type="text/javascript">
		  var k=window.dialogArguments; 
		  if(k.par){
		  	var param=k.par;
			$.getJSON("queryPospTraceInfo.do",param,function(data){
				$.each(data.rows,function(idx,item){
			$("#idPospTraceId").val($.trim(item.POSP_TRACE_ID));
			$("#idMerchId").val($.trim(item.MERCHNAME));
			$("#idTerminalId").val($.trim(item.TERMINAL_ID));
			$("#idAposId").val($.trim(item.APOS_ID));
			$("#idSerialNo").val($.trim(item.SERIAL_NO));
			$("#idTaskSysId").val($.trim(item.TASK_SYS_ID));
			$("#idPospNoticeeInfo").val($.trim(item.POSP_NOTICEE_INFO));
			$("#idSyncFlag").val($.trim(item.SYNC_FLAG));
			$("#idPospSyncTime").val($.trim(item.POSP_SYNC_TIME));
			$("#idPospSyncBatchid").val($.trim(item.POSP_SYNC_BATCHID));
			$("#idCreateDate").val($.trim(item.CREATE_DATE));
			$("#idMid").val($.trim(item.MID_NAME));
			$("#idReg").val($.trim(item.REG_NAME));			
				});
            }); 
            
         }
		  

		function cleardata(){
			$('#ff').form('clear');
		}
		
		function addPospTraceInfo(){
			$('#ff').form('submit',{
		        url:'updatePospTraceInfo.do',
			    onSubmit:function(){
			        return $(this).form('validate');
			    },
			    success:function(data){
			      var myObject = eval('(' + data + ')');
			       //这种方式直接关闭窗口，返回true或者false给主窗口
			       // window.close();
			       // window.returnValue=myObject.status; 
			        
			        //这种错误情况下方式不关闭窗口	 
			       if(myObject.status=="true"){
						 window.close();
			        	 window.returnValue=myObject.status; 
			        }else if(myObject.status=="false"){
			        	msgShow("修改",myObject.message,"error");
			        	//window.close();
			        }
			    }
			});
		}

	</script>
</head>
<body class="easyui-layout" fit="true">
					<div region="center"  fit="true" title="POSP通知信息" >
						<form id="ff" method="post">
						<table class="formTable" style="width:100%;">
				<col  width="120px" class="leftCol"/>
				<col width="250px" >
				<col  width="120px" class="leftCol"/>
				<col width="250px" >
							<tr>
								<td>通知流水号</td>
								<td>
									<input type="text" class="readonly" required="true"   name="POSP_TRACE_ID" id="idPospTraceId" maxlength="10" />
								</td>
								<td>同步标记</td>
								<td>
									<input type="text" class="readonly"    name="SYNC_FLAG" id="idSyncFlag" maxlength="1" />
								</td>
							</tr>
							<tr>
								<td>商户</td>
								<td>
									<input type="text" class="readonly"    name="MERCH_ID" id="idMerchId" maxlength="15" />
								</td>
								<td>同步时间</td>
								<td>
									<input type="text" class="readonly"    name="POSP_SYNC_TIME" id="idPospSyncTime" maxlength="19" />
								</td>
							</tr>
							<tr>
								<td>终端号</td>
								<td>
									<input type="text" class="readonly"    name="TERMINAL_ID" id="idTerminalId" maxlength="8" />
								</td>
								<td>建立时间</td>
								<td>
									<input type="text" class="readonly"    name="CREATE_DATE" id="idCreateDate" maxlength="19" />
								</td>							
							</tr>
							<tr>
								<td>应用终端号</td>
								<td>
									<input type="text" class="readonly"    name="APOS_ID" id="idAposId" maxlength="10" />
								</td>
								<td>分支机构</td>
								<td>
									<input type="text" class="readonly"    name="REG_NAME" id="idReg" maxlength="30" />
								</td>						
							</tr>
							<tr>
								<td>硬件序列号</td>
								<td>
									<input type="text" class="readonly"    name="SERIAL_NO" id="idSerialNo" maxlength="30" />
								</td>
								<td>主机型号</td>
								<td>
									<input type="text" class="readonly"    name="MID_NAME" id="idMid" maxlength="20" />
								</td>								
							</tr>
							<tr>
								<td>任务分配id</td>
								<td>
									<input type="text" class="readonly"    name="TASK_SYS_ID" id="idTaskSysId" maxlength="10" />
								</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>									
							</tr>
							<tr>
								<td>通知信息</td>
								<td >
									<textarea rows="16" cols="60" class="readonly"    name="POSP_NOTICEE_INFO" id="idPospNoticeeInfo" maxlength="400" >
									</textarea>
								</td>
							</tr>
						</table>
					    </form>
					</div>
					<div region="south"   style="text-align:right;" class="toolbarHeader">
						<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="javascript:window.close()">关闭</a>
					</div>
</body>
</html>
