<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<jsp:directive.page import="com.landi.tms.core.paramitem.service.IParamItemService"/>
<jsp:directive.page import="com.landi.tms.util.SpringBeanLoader"/>
<jsp:directive.page import="org.json.JSONArray"/>
<jsp:directive.page import="com.landi.tms.base.IDto"/> 
<jsp:directive.page import="com.landi.tms.base.impl.*"/> 

<%
	try { 
		IParamItemService ParamItemService = (IParamItemService) SpringBeanLoader.getSpringBean("ParamItemService");
		IDto inDto = new IDtoImpl();System.out.println("group:"+request.getParameter("paramGroup"));
		inDto.put("paramGroup1",request.getParameter("paramGroup"));
		List list=ParamItemService.getParamItemByGroup(inDto);
	  	JSONArray jObj=new JSONArray(list);System.out.println(jObj.toString());
		out.println(jObj.toString());
	} catch (Exception e) {
		e.printStackTrace();
	}
%>
