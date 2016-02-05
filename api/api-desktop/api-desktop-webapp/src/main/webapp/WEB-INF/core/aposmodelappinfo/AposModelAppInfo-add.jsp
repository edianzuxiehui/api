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
		
		function addAposModelAppInfo(){
			$('#ff').form('submit',{
		        url:'addAposModelAppInfo.do',
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
									<input type="text" class="easyui-validatebox" required="true"   name="SYS_ID" id="idSysId" maxlength="10" />
								</td>
							</tr>
							<tr>
								<td>应用终端模板编号</td>
								<td>
									<input type="text" class="easyui-validatebox"    name="APOS_MODEL_ID" id="idAposModelId" maxlength="10" />
								</td>
							</tr>
							<tr>
								<td>应用编号</td>
								<td>
									<input type="text" class="easyui-validatebox"    name="APP_ID" id="idAppId" maxlength="8" />
								</td>
							</tr>
							<tr>
								<td>主应用标志</td>
								<td>
									<input type="text" class="easyui-validatebox"    name="MASTER_APP_FLAG" id="idMasterAppFlag" maxlength="1" />
								</td>
							</tr>
							<tr>
								<td>应用版本</td>
								<td>
									<input type="text" class="easyui-validatebox"    name="APP_VER" id="idAppVer" maxlength="30" />
								</td>
							</tr>
							<tr>
								<td>参数模板编号</td>
								<td>
									<input type="text" class="easyui-validatebox"    name="PARAM_MODEL_ID" id="idParamModelId" maxlength="10" />
								</td>
							</tr>
							<tr>
								<td>应用更新标志</td>
								<td>
									<input type="text" class="easyui-validatebox"    name="APP_UPDATE_FLAG" id="idAppUpdateFlag" maxlength="2" />
								</td>
							</tr>
							<tr>
								<td>参数更新标志</td>
								<td>
									<input type="text" class="easyui-validatebox"    name="PARAM_UPDATE_FLAG" id="idParamUpdateFlag" maxlength="2" />
								</td>
							</tr>
							<tr>
								<td>备注</td>
								<td>
									<input type="text" class="easyui-validatebox"    name="DESC_TXT" id="idDescTxt" maxlength="100" />
								</td>
							</tr>
							<tr>
								<td>分支机构编号</td>
								<td>
									<input type="text" class="easyui-validatebox"    name="REG_ID" id="idRegId" maxlength="8" />
								</td>
							</tr>
						</table>
					    </form>
					</div>
					<div region="south"   style="text-align:right;" class="toolbarHeader">
						<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="addAposModelAppInfo()">确认</a>
						<a class="easyui-linkbutton" iconCls="icon-redo" href="javascript:void(0)" onclick="cleardata()">重置</a>
						<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="javascript:window.close()">取消</a>
					</div>
</body>
</html>
