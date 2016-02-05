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
	<title>任务详情</title>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/icon.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/default.css">
	<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/common.js"></script>
	<script type="text/javascript" src="core/taskinfo/TaskInfo-view-js.js"></script>
	<script type="text/javascript">

	</script>
</head>
<body class="easyui-layout" fit="true">
	<div region="north" style="height:90px" title="基本信息">
		<form id="ff" method="post">
				<table class="formTable" style="width:90%;">
					<col  width="100px" class="leftCol"/>
					<col width="250px" >
					<col  width="100px" class="leftCol"/>
					<col width="250px" >
					<input type="hidden" name="TASK_SYS_ID" id="idTaskSysId"/>
					<input type="hidden" name="PLAN_CODE" id="idPlanCode"/>
					<input type="hidden" name="REG_ID" id="idRegId"/>						   
				   <tr>
						<td width="15%" align="right" class = "blue" >计划名称</td>
		       			<td width="18%"><input name="plan_name" id="idPlanName" size=20 readonly class="readonly">
		       			</td>                       
		       			<td width="15%" align="right" class="blue" >应用终端号</td>
		       			<td width="18%"><input name="APOS_ID" id="idAposId" size=20 readonly class="readonly">
		       			</td>
			   			<td width="15%" align="right" class="blue" >策略编号</td>      
						<td width="18%"><input name="STRATEGY_ID" id="idStrategyId" size=20 readonly class="readonly">
		   			</tr>
		   			<tr>
						<td width="15%">分支机构</td>
						<td width="18%"><input name="REG_NAME" id="idRegName" size=20 readonly class="readonly">
						<td width="15%">下载开始时间</td>
						<td width="18%"><input name="DOWN_BTIME" id="idDownBtime"  size=20 readonly class="readonly">
						<td width="15%" align="right">下载结束时间</td>
						<td width="18%"><input name="DOWN_ETIME" id="idDownEtime"  size=20 readonly class="readonly">
					</tr>
				</table>
		</form>
	</div>
		<div region="center" split="true" >  
		 <table id="idTaskAppTerminalInfo"></table>
		<!-- <div class="toolbarHeader">
		 <table width="90%" border="0" cellspacing="0" cellpadding="0">
            <tr><td align="right">
            <input type="hidden" name="reg_id" value=""/>
            <input type="button" name="add" value="  增加应用  " onClick="appAdd();"/>&nbsp;&nbsp;
            <input type="button" name="update" value="  修改应用  " onClick="appEdit();"/>&nbsp;&nbsp;
            <input type="button" name="del" value="  删除应用  " onClick="appDel();"/>&nbsp;&nbsp;
            <input type="button" name="del" value="应用参数管理" onClick="appParam();"/>&nbsp;&nbsp;
            </td>
            </tr>
          </table>
          </div>
          -->  
	 </div>
	<div region="south" style="text-align:right;" class="toolbarHeader">
		<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="javascript:window.close()">关闭</a>
	</div>
</body>
</html>
