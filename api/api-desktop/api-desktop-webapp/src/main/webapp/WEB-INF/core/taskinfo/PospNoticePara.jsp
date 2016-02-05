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
	<title>POS提示信息</title>
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
		
		function addCommunType(){
		 var value=$("#idpsoinfo").val()+'#'+$('input:radio:checked').val();
          parent.window.returnValue = escape(escape(value));
          window.close();
		}

	</script>
</head>
<body class="easyui-layout" fit="true">
					<div region="center"  fit="true" title="POS通知消息设置" >
						<form id="ff" method="post">
						<table class="formTable" style="width:100%;">
				<col  width="150px" class="leftCol"/>
				<col width="250px" >

					   <tr><td width="30%" align="right" class="blue" >POS提示信息:</td>
					       <td width="70%"><textarea rows="10" cols="40" name="posinfo" id="idpsoinfo" class="easyui-validatebox" maxLength="30">该终端有任务，请立即报到!</textarea>
					       </td>
					   </tr>
					   <tr><td width="30%" align="right" class="blue" >是否立即通知</td>
					       <td width="70%">
					       <input type="radio" id="idposptype" name="posptype" value="1" checked>是</input>
					       <input type="radio" id="idposptype" name="posptype" value="0">否</input>
					       </td>
					   </tr>
						</table>
					    </form>
					</div>
					<div region="south"   style="text-align:right;" class="toolbarHeader">
						<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="addCommunType()">确认</a>
						<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="javascript:window.close()">取消</a>
					</div>
</body>
</html>
