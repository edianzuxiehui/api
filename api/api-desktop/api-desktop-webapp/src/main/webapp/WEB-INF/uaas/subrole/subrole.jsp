<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<meta http-equiv="X-UA-Compatible" content="IE=8">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>终端管理系统</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	

	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" type="text/css" href="<%=basePath %>themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath %>css/default.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath %>themes/icon.css">
	<script type="text/javascript" src="<%=basePath %>js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="<%=basePath %>js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="<%=basePath %>js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=basePath %>js/easyui-lang-zh_CN.js"></script>
	<link rel="stylesheet" href="<%=basePath %>css/demo.css" type="text/css">
	<link rel="stylesheet" href="<%=basePath %>css/zTreeStyle/zTreeStyle.css" type="text/css">

	<script type="text/javascript" src="<%=basePath %>js/jquery.ztree.core-3.1.js"></script>
	<script type="text/javascript" src="<%=basePath %>js/jquery.ztree.excheck-3.1.js"></script>
	<script type="text/javascript" src="<%=basePath %>js/common.js"></script>
	<SCRIPT type="text/javascript">
     	   function showprop(id){
	   
	   		   $(function(){
				//单位树
				var appRoot="<%=basePath%>";
				$("#menutree").css("display","block"); 
				var geturl1=appRoot+"getmenutree.do?realroleid="+id;
				//alert(geturl);
				var setting; 
				var zNodes =[ 				]; 
				setting = {
				check: {
				enable: true
			    },
			    chkStyle: "checkbox",
			    chkboxType: { "Y" : "ps", "N" : "ps" },
				async: { //异步加载
				enable: true,
				url: geturl1,//异步加载URL
				autoParam: ["id=dwid"]//需要传递的参数
				}
				}; 
				$.fn.zTree.init($("#menutree"), setting, null);//初始化树对象
				});
	   
	    
	   }
     
	   

				
			
			//var appRoot=getRootPath()+"/";
			var appRoot="<%=basePath%>";
			//alert(appRoot);
			var geturl=appRoot+"getsubrole.do";	
			var zNodes =[ 
				{name:"终端管理系统", id:"-1", isParent:true} //初始化一个顶层默认节点 
				];
			var setting = {
			async: {
				enable: true,
				url: geturl,
				autoParam:["id=dwid"],
				otherParam:{"otherParam":"zTreeAsyncTest"}
			}
		};
			
				$(document).ready(function(){
			$.fn.zTree.init($("#treedw"), setting,zNodes);
		});		
				
		//-->
	</SCRIPT>
 </HEAD>

<BODY>
   <div class="easyui-layout" fit="true">  
	<div  region="west" style="width:400px;padding1:1px;">
		<ul id="treedw" class="ztree"></ul>
	</div>
	<div  region="center" id="showright">
		<ul class="info">
			<li class="title"><h2>请从左边选择角色进行操作</h2>
				<ul id="menutree" class="ztree" style="display:none">
				</ul>

			</li>
		</ul>
	</div>
</div>
</BODY>
</HTML>
