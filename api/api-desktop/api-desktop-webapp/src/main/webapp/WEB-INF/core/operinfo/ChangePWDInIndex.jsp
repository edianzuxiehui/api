<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.landi.tms.base.IDto"%>
<%@page import="com.landi.tms.base.impl.IDtoImpl"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
IDto outDto = new IDtoImpl();
IDto person = (IDto) request.getSession().getAttribute("person");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<meta http-equiv="X-UA-Compatible" content="IE=8">
<html>
<head>
  <base href="<%=basePath%>">
  <base target="_self">
	<title>修改密码</title>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/icon.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/default.css">
	<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/easyui-lang-zh_CN.js"></script>
	      <script type="text/javascript" src="<%=basePath%>js/common.js"></script>

		<script type="text/javascript">
		
		
		//setModuleNameAndIdFromTab();
		
		function cleardata(){
			$('#ff').form('clear');
		}
		
		function addOperInfo(){
		    if($('#newpwd').attr('value') != $('#confimpwd').attr('value')){
		    	msgShow("提示","两次输入新密码不一致!","info");
		    	return;
		    }
				
			$('#ff').form('submit',{
		        url:'updateOperPWD.do',
			    onSubmit:function(){
			        return $(this).form('validate');
			    },
			    success:function(data){
			      var myObject = eval('(' + data + ')');
			      if(myObject.status=="true"){
						 msgShow("修改","修改密码成功!","info");
						 $('#ff').form('clear');
			      }else if(myObject.status=="false"){
			        	msgShow("修改",myObject.message,"error");
			      }
			    }
			});
		}
		function cleardata(){
			$('#ff').form('clear');
		}
		
		function close(){
		//window.parent.close();
		//window.opener.close();
		//window.parent.closeWin();
		window.parent.parent.document.getElecmentById("test").window('close');
		
			//$('#w').window('close');
		}

	</script>
</head>
<body class="easyui-layout" fit="true">
					<div region="center"  fit="true"  >
						<form id="ff" method="post">
						<table class="formTable" style="width:95%;">
					<col  width="100px" class="leftCol"/>
					<col width="200px" >
							<tr>
								<td><div style="text-align: right;">旧密码<font color="red">*</font></div></td>
								<td>
									<input type="hidden"  id="focus"/>
									<input type="password" class="easyui-validatebox" validType="safepass" required="true"   name="OLDPWD" id="oldpwd" maxlength="20"  />
								</td>
							</tr>
							<tr>
								<td><div style="text-align: right;">新密码<font color="red">*</font></div></td>
								<td>
									<input type="password" class="easyui-validatebox" validType="safepass"  required="true"   name="NEWPWD" id="newpwd" maxlength="20" />
								</td>
							</tr>
							<tr>
								<td><div style="text-align: right;">确认新密码<font color="red">*</font></div></td>
								<td>
									<input type="password" class="easyui-validatebox" validType="equalTo['#newpwd']"  required="true"  name="CONFIMPWD" id="confimpwd" maxlength="20" />
									<input type="hidden"     name="OPER_ID" id="idOperId" maxlength="8" value="<%=person.getAsString("OPER_ID") %>" />
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<div style="text-align:center;">
									<input id="idQuery" type="button" class="btn_grid" value=" 确 认 " onclick="addOperInfo();"/>
									<input id="idReset" type="button" class="btn_grid" value=" 重 置 " onclick="cleardata();"/>
									<input id="idReset" type="button" class="btn_grid" value=" 关 闭  " onclick="close();"/>
									</div>
								</td>
							</tr>

						</table>
					    </form>
					</div>
</body>
</html>
