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
	<title>新增应用</title>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/icon.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/default.css">
	<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/easyui-lang-zh_CN.js"></script>
	      <script type="text/javascript" src="<%=basePath%>js/common.js"></script>
    <script type="text/javascript" src="core/appinfo/AppInfo-js.js"></script>

		<script type="text/javascript">
		setModuleNameAndId();
		
		function cleardata(){
			$('#ff').form('clear');
		}
		
		function addAppInfo(){

		 if(($('#idExist').val())=='true'){
		       msgShow("新增",'该应用已经存在',"error");
		       return ;
		   }
			$('#ff').form('submit',{
		        url:'addAppInfo.do',
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
<body class="easyui-layout" fit="true" onload="initDataForAppInfo('idRegId');">
					<div region="center"  fit="true" title="信息录入" >
						<form id="ff" method="post" >
						<table class="formTable" style="width:100%;">
				<col  width="90px" class="leftCol"/>
				<col width="250px" >

							<tr>
								<td>应用编号<font color="red">*</font></td>
								<td>
								 
									<input  onchange="checkAppInfoExist();" type="text" class="easyui-validatebox" required="true" validType="numAndLen[8]"  name="APP_ID" id="idAppId" maxlength="8" style="width: 45%" />
								      <input id="idExist" value="" type="hidden" >
								</td>
							</tr>
							<tr>
								<td>应用名称<font color="red">*</font></td>
								<td>
									<input type="text" class="easyui-validatebox"   validType="maxLen[45]" required="true"  name="APP_NAME" id="idAppName" maxlength="30" style="width: 45%"/>
								</td>
							</tr>
							<tr>
								<td>分支机构<font color="red">*</font></td>
								<td>
									<input type="hidden" class="easyui-validatebox"    name="REG_ID" id="idRegId" maxlength="8" />
									<input type="text" class="easyui-validatebox" style="background-color: #EEEEEE"  name="REG_NAME" id="idRegName" readonly="readonly"  required="true"/>
									<input id="idChoose" type="button" class="btn_grid" value="选择" onclick="queryReg('idRegId','idRegName')"/>

								</td>
							</tr>
							<!-- 
							<tr>
								<td>应用状态</td>
								<td>
									<input type="text" class="easyui-validatebox"    name="APP_STATUS" id="idAppStatus" maxlength="1" style="width: 45%"/>
								</td>
							</tr>
							<tr>
								<td>注册日期</td>
								<td>
									<input type="text" class="easyui-validatebox"    name="INPUT_DATE" id="idInputDate" maxlength="17" style="width: 45%"/>
								</td>
							</tr>
							
							 -->
							<tr>
								<td>共享标志<font color="red">*</font></td>
								<td>
									<input type="radio"  name="SHARE_FLAG" id="idShareFlag"value="0" checked>不共享
   		                            <input type="radio" name="SHARE_FLAG" id="idShareFlag" value="1">共享
								</td>
							</tr>
							<tr>
								<td>备注</td>
								<td>
									<textarea type="text" class="easyui-validatebox"   validType="maxLen[100]"  name="DESC_TXT" id="idDescTxt" maxlength="100" style="width: 150px"></textarea>
								</td>
							</tr>
						</table>
					    </form>
					</div>
					<div region="south"   style="text-align:right;" class="toolbarHeader">
						<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="addAppInfo()">确认</a>
						<a class="easyui-linkbutton" iconCls="icon-redo" href="javascript:void(0)" onclick="cleardata()">重置</a>
						<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="javascript:window.close()">取消</a>
					</div>
</body>
</html>
