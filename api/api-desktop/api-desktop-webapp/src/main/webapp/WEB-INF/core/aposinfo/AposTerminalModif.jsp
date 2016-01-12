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
  <base target="_self" >
	<title></title>
	<link rel="stylesheet" type="text/css" href="themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="themes/icon.css">
	<link rel="stylesheet" type="text/css" href="css/default.css">
	<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="js/common.js"></script>
	<script type="text/javascript">
		  
	
		function updateTerModify(){
		//alert($("#queryForm").form('validate'));
			if($("#queryForm").form('validate')){
				window.close();
			 	window.returnValue=$("#idTerminalId").val(); 
			}
			
		}
	</script>
</head>

<body class="easyui-layout" fit="true">
	    <div region="center" style="height: 70px;" title="修改终端号"  split="true">  
					<form id="queryForm">
						<table class="formTable" style="width:95%;">
		               		<tr>
		               			<td><div style="text-align: right;">终端号<font color="red">*</font></div></td>
		               			<td><input type="text" class="easyui-validatebox" required="true" validType="numberCharFixLength[8]" name="TERMINAL_ID" id="idTerminalId" maxlength="8"/></td>
		               		</tr>
						</table>
					</form>
	     </div>
	    <div region="south" style="text-align:right;" class="toolbarHeader">
	    	<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="updateTerModify()">确认</a>
			<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="javascript:window.close()">取消</a>
	    </div>
</body>
	<script type="text/javascript">
 var k=window.dialogArguments; 
		   if(k.par){
		  	var param=k.par;
		  //	alert(param);
		  	if(param&&param!=null&param!="null"){
		  		$("#idTerminalId").val(param); 
		  	}
		   }
</script>

</html>
