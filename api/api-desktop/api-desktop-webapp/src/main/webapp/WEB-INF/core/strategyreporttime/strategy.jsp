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
	<title>策略分配</title>
	<link rel="stylesheet" type="text/css" href="themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="themes/icon.css">
	<link rel="stylesheet" type="text/css" href="css/default.css">
	<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="js/common.js"></script>
    <script type="text/javascript" src="core/strategyreporttime/strategy-js.js"></script>
	<script type="text/javascript">
	//本页面允许的操作功能
   // var k = window.dialogArguments; 
//	k.par.appId;
   
	
  	function confirm() {
		var row = $('#idStrategy').datagrid('getSelected');
		var ids = null;
		var fields=null;
		if(row == null){
			msgShow('提示消息','请选择策略!','info');
			return;
		}
	    var k=window.dialogArguments; 
		var strategyId = row.KEYID;
		var param = "APOS_ID="+aposIds+"&STRATEGY_ID="+strategyId+"&tmsModuleTitle="+k.tmsModuleTitle+"&tmsModuleId="+k.tmsModuleId;
			 $.ajax({
			   type: "POST",
			   url: "addStrategyAposBind.do",
			   data: param,       
			    success: function(data){
			      //flashTable("idStrategy");
			      window.returnValue = eval('(' + data+')');
			      window.close();
			   } 
			  }); 
			
	 }
	 

</script>
</head>
<body class="easyui-layout" >
 
		<div region="center"  >  
			<table id="idStrategy" ></table>
	    </div>
	      <div region="south" style="text-align:right;" style="height: 30px;position:relative;background:url('<%=basePath%>images/indexbg.png') repeat;">  
					<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="confirm()">确认</a>
				    <a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="javascript:window.close()">取消</a>
	     </div>
</body>
</html>
