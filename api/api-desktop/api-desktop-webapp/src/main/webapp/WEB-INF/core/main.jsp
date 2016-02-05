<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.landi.tms.base.IDto"%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib uri="oscache" prefix="cache" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
IDto person = (IDto) request.getSession().getAttribute("person");
String name = person.getAsString("NAME");
 %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<meta http-equiv="X-UA-Compatible" content="IE=8">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <base href="<%=basePath%>">
      <base target="_self">
    <title>终端管理系统</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="css/default.css">
	<link rel="stylesheet" type="text/css" href="themes/icon.css">
	<link rel="stylesheet" type="text/css" href="css/index.css">
	<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/common.js"></script>
	<script type="text/javascript" src="js/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="PwdTimeTip.js"></script>
  </head>
  <body style="overflow: hidden;background: #eee;">
  <input type="hidden" id="idTmsModuleTitle"  name="tmsModuleTitle">
	<input type="hidden" id="idTmsModuleId" name="tmsModuleId">
    <!-- 
	<div style="width:100% ;height:100%; text-align: center;" ><img src="<%=basePath%>images/main1.jpg" ></div>	
	 -->
	<div id="test" class="easyui-window" closed="true" modal="true" title="修改密码" draggable="false" inline="true" maximizable=false
	 shadow="false" collapsible="false" minimizable="false" style="width:330px;height:300px;" >
	 
	 <div class="easyui-layout" fit="true">
					<div region="center"  fit="true"  >
						<form id="ff" method="post">
						<table class="formTable" style="width:95%;">
					<col  width="130px" class="leftCol"/>
					<col width="200px" >
							<tr>
								<td colspan="2">
										<div style="text-align: left;color: red;width: 100%;height: 10%;background: #eee;padding-top: 5px" id="idMsg" ></div>
								</td>
							</tr>
							<tr>
								<td colspan="2">&nbsp;</td>
							</tr>
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
									<div style="text-align:center;padding-top: 10px">
									&nbsp;&nbsp;&nbsp;&nbsp;
									<input id="idQuery" type="button" class="btn_grid" value="  确   认  " onclick="addOperInfo();"/>
									<input id="idReset" type="button" class="btn_grid" value="  重  置  " onclick="cleardata();"/>
									<input id="idReset" type="button" class="btn_grid" value="  关  闭   " onclick="closeWin();"/>
									</div>
								</td>
							</tr>

						</table>
					    </form>
					</div>
	</div>
	 </div>
 </body>
</html>
