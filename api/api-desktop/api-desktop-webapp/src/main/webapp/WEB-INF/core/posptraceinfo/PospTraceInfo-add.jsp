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
	<title>新增商户</title>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/icon.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/default.css">
	<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/easyui-lang-zh_CN.js"></script>
	      <script type="text/javascript" src="<%=basePath%>js/common.js"></script>

		<script type="text/javascript">
		 
		function cleardata(){
			$('#ff').form('clear');
		}
		
		function addPospTraceInfo(){
			$('#ff').form('submit',{
		        url:'addPospTraceInfo.do',
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
			        	msgShow("新增",myObject.message,"error");
			        	//window.close();
			        }
			    }
			});
		}

	</script>
</head>
<body class="easyui-layout" fit="true">
					<div region="center"  fit="true" title="信息录入" >
						<form id="ff" method="post">
						<table class="formTable" style="width:100%;">
				<col  width="50px" class="leftCol"/>
				<col width="250px" >

							<tr>
								<td>通知流水号</td>
								<td>
									<input type="text" class="easyui-validatebox" required="true"   name="POSP_TRACE_ID" id="idPospTraceId" maxlength="10" />
								</td>
							</tr>
							<tr>
								<td>商户编码</td>
								<td>
									<input type="text" class="easyui-validatebox"    name="MERCH_ID" id="idMerchId" maxlength="15" />
								</td>
							</tr>
							<tr>
								<td>终端号</td>
								<td>
									<input type="text" class="easyui-validatebox"    name="TERMINAL_ID" id="idTerminalId" maxlength="8" />
								</td>
							</tr>
							<tr>
								<td>应用终端号</td>
								<td>
									<input type="text" class="easyui-validatebox"    name="APOS_ID" id="idAposId" maxlength="10" />
								</td>
							</tr>
							<tr>
								<td>硬件序列号</td>
								<td>
									<input type="text" class="easyui-validatebox"    name="SERIAL_NO" id="idSerialNo" maxlength="30" />
								</td>
							</tr>
							<tr>
								<td>任务分配id</td>
								<td>
									<input type="text" class="easyui-validatebox"    name="TASK_SYS_ID" id="idTaskSysId" maxlength="10" />
								</td>
							</tr>
							<tr>
								<td>通知信息</td>
								<td>
									<input type="text" class="easyui-validatebox"    name="POSP_NOTICEE_INFO" id="idPospNoticeeInfo" maxlength="400" />
								</td>
							</tr>
							<tr>
								<td>同步标记</td>
								<td>
									<input type="text" class="easyui-validatebox"    name="POSP_SYNC_FLAG" id="idPospSyncFlag" maxlength="1" />
								</td>
							</tr>
							<tr>
								<td>同步时间</td>
								<td>
									<input type="text" class="easyui-validatebox"    name="POSP_SYNC_TIME" id="idPospSyncTime" maxlength="19" />
								</td>
							</tr>
							<tr>
								<td>同步批次号</td>
								<td>
									<input type="text" class="easyui-validatebox"    name="POSP_SYNC_BATCHID" id="idPospSyncBatchid" maxlength="10" />
								</td>
							</tr>
						</table>
					    </form>
					</div>
					<div region="south"   style="text-align:right;" class="toolbarHeader">
						<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="addPospTraceInfo()">确认</a>
						<a class="easyui-linkbutton" iconCls="icon-redo" href="javascript:void(0)" onclick="cleardata()">重置</a>
						<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="javascript:window.close()">取消</a>
					</div>
</body>
</html>
