<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="oscache" prefix="cache" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<meta http-equiv="X-UA-Compatible" content="IE=8">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>OSCACHE</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
  </head>
  
  <body>
  <cache:flush scope="application" ></cache:flush>
  清楚application下面所有的缓存。
  </body>
</html>
