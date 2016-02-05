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
		
		function addOnlineLine(){
			$('#ff').form('submit',{
		        url:'addOnlineLine.do',
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
								<td>系统内部编号(使用序列生成的编号)</td>
								<td>
									<input type="text" class="easyui-validatebox" required="true"   name="SYS_ID" id="idSysId" maxlength="50" />
								</td>
							</tr>
							<tr>
								<td>客服编号</td>
								<td>
									<input type="text" class="easyui-validatebox"    name="CUSTOME_ID" id="idCustomeId" maxlength="30" />
								</td>
							</tr>
							<tr>
								<td>应用终端号</td>
								<td>
									<input type="text" class="easyui-validatebox"    name="APOS_ID" id="idAposId" maxlength="10" />
								</td>
							</tr>
							<tr>
								<td>交易类型(pos联机交易)</td>
								<td>
									<input type="text" class="easyui-validatebox"    name="TRAN_TYPE" id="idTranType" maxlength="4" />
								</td>
							</tr>
							<tr>
								<td>交易结果</td>
								<td>
									<input type="text" class="easyui-validatebox"    name="TRAN_RESULT" id="idTranResult" maxlength="2" />
								</td>
							</tr>
							<tr>
								<td>交易开始时间</td>
								<td>
									<input type="text" class="easyui-validatebox"    name="TRAN_BEGIN_DATE" id="idTranBeginDate" maxlength="19" />
								</td>
							</tr>
							<tr>
								<td>交易结束时间</td>
								<td>
									<input type="text" class="easyui-validatebox"    name="TRAN_COMPLET_DATE" id="idTranCompletDate" maxlength="19" />
								</td>
							</tr>
							<tr>
								<td>上送应用信息</td>
								<td>
									<input type="text" class="easyui-validatebox"    name="UP_APP_INFO" id="idUpAppInfo" maxlength="500" />
								</td>
							</tr>
							<tr>
								<td>上送硬件信息</td>
								<td>
									<input type="text" class="easyui-validatebox"    name="UP_DEV_INFO" id="idUpDevInfo" maxlength="80" />
								</td>
							</tr>
							<tr>
								<td>上送基站信息</td>
								<td>
									<input type="text" class="easyui-validatebox"    name="UP_SITE_INFO" id="idUpSiteInfo" maxlength="20" />
								</td>
							</tr>
							<tr>
								<td>主叫电话</td>
								<td>
									<input type="text" class="easyui-validatebox"    name="TELE_NO" id="idTeleNo" maxlength="20" />
								</td>
							</tr>
							<tr>
								<td>分支机构编号</td>
								<td>
									<input type="text" class="easyui-validatebox"    name="REG_ID" id="idRegId" maxlength="8" />
								</td>
							</tr>
							<tr>
								<td>分支机构全称编号</td>
								<td>
									<input type="text" class="easyui-validatebox"    name="REG_ENTIRE_ID" id="idRegEntireId" maxlength="50" />
								</td>
							</tr>
							<tr>
								<td>错误信息</td>
								<td>
									<input type="text" class="easyui-validatebox"    name="ERROR_INFO" id="idErrorInfo" maxlength="255" />
								</td>
							</tr>
							<tr>
								<td>硬件序列号</td>
								<td>
									<input type="text" class="easyui-validatebox"    name="SERIAL_NO" id="idSerialNo" maxlength="30" />
								</td>
							</tr>
						</table>
					    </form>
					</div>
					<div region="south"   style="text-align:right;" class="toolbarHeader">
						<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="addOnlineLine()">确认</a>
						<a class="easyui-linkbutton" iconCls="icon-redo" href="javascript:void(0)" onclick="cleardata()">重置</a>
						<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="javascript:window.close()">取消</a>
					</div>
</body>
</html>
