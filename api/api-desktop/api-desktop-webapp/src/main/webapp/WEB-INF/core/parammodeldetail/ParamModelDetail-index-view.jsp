<%@ page language="java" pageEncoding="UTF-8"%>
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
	<title>参数模板明细查看</title>
	<link rel="stylesheet" type="text/css" href="themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="themes/icon.css">
	<link rel="stylesheet" type="text/css" href="css/default.css">
	<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="js/common.js"></script>
    <script type="text/javascript" src="core/parammodeldetail/ParamModelDetail-view-js.js"></script>
	<script type="text/javascript">
		function queryInfo(){
		    var date=new Date();
		    var PARAM_MODEL_ID=$('#PARAM_MODEL_ID').val();
		    var PARAM_GROUP = $('#idParamGroup').combobox('getValue');
		    var PARAM_ID = $('#idParamId').combobox('getValue');
		    //var PARAM_VALUE=$('#PARAM_VALUE').val();
		    //alert(escape(PARAM_VALUE));alert(escape(escape(PARAM_VALUE)));
		    //PARAM_VALUE= escape(escape(PARAM_VALUE));
			var param="flag="+date.getTime()+"&PARAM_MODEL_ID="+PARAM_MODEL_ID+"&PARAM_GROUP="+PARAM_GROUP+"&PARAM_ID="+PARAM_ID;//+"&PARAM_VALUE="+PARAM_VALUE;
			$('#idParamModelDetail-view').datagrid('options').url = "listParamModelDetail.do?"+param; // 改变它的url  
			$("#idParamModelDetail-view").datagrid('load');
		}
		function cleardata(){
			$('#ff').form('clear');
		}
	</script>
</head>

<body class="easyui-layout" fit="true">
	    <div region="north" style="height:50px;position:relative;padding-top:7px" title=""  split="true"> 
	   		<input type="hidden" name="PARAM_MODEL_ID" id="PARAM_MODEL_ID" value=""> 
			<form id="ff">
			 <table>
			 	<col  width="15%" align="right"/>
				<col  width="15%" align="left">
				<col  width="15%"  align="right"/>
				<col  width="15%" align="left">
				<col  width="15%"  align="right"/>
				<col  width="15%" align="left">
				<tr>
					  <td style="vertical-align:middle">
					  	<div style="text-align: right;">参数组</div>
					  </td>
					  <td>
					    <select id="idParamGroup" class="easyui-combobox" name="PARAM_GROUP" style="width:125px;" panelHeight="auto">
						</select>
					  </td>
					  <td style="vertical-align:middle"><div style="text-align: right;">参数项</div></td>
					  <td>
						 <select id="idParamId" class="easyui-combobox" name="PARAM_ID" style="width:135px;" panelHeight="300px">
						 </select>
					  </td>
					  <td style="vertical-align:middle" colspan="2">
					  <div style="text-align:center;">
					  	<input id="idQuery" type="button" class="btn_grid" value=" 查 询 " onclick="queryInfo()"/>
					  	<input id="idReset" type="button" class="btn_grid" value=" 重 置 " onclick="cleardata()"/>
					  	</div>
					  </td>
				  </tr>
			</table>
			</form>
	     </div>
	     
		<div region="center"  >  
			<table id="idParamModelDetail-view" ></table>
	    </div>
		<div region="south"   style="text-align:right;" class="toolbarHeader">
			<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="javascript:window.close()">确认</a>
		</div>	  	    
</body>

</html>
