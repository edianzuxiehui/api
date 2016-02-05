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
	<title>逐条新增任务</title>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/icon.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/default.css">
	<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/common.js"></script>
	<script type="text/javascript" src="core/taskinfo/taskInfo-add-detail-js.js"></script>
	<script type="text/javascript">
		setModuleNameAndId();
		function cleardata(){
			$('#ff').form('clear');
		}
		
		function addTaskInfo(){
			$('#ff').form('submit',{
		        url:'addTaskInfo.do',
			    onSubmit:function(){
			        return $(this).form('validate');
			    },
			    success:function(data){
			      var myObject = eval('(' + data + ')');
			       //这种方式直接关闭窗口，返回true或者false给主窗口
			       // window.close();
			       // window.returnValue=myObject.status; 
			        
			        //这种错误情况下方式不关闭窗口	 
			       if(myObject.status=="true"){
			             msgShow("新增",myObject.message,"info");
						 window.close();
			        }else if(myObject.status=="false"){
			        	msgShow("新增",myObject.message,"error");
			        	//window.close();
			        }
			    }
			});
		}

	</script>
</head>
<body class="easyui-layout" fit="true">
	<div region="north" style="height:145px" title="">
		<form id="ff" method="post">
<fieldset id="modelArea" style="padding:6px;width:96%;border:1px solid #46A3FF; color:#CC3300; line-height:2.0; font-size:12px;" align=center><legend>基本信息</legend>  
				<table class="formTable" style="width:90%;">
					<col  width="15%" class="leftCol"/>
					<col width="40%" >
					<col  width="15%" class="leftCol"/>
					<col width="30%" >
				    <input type="hidden" name="devIds" id="idDevIds">
				    <input type="hidden" name="aposMids" id="idAposMids"><!-- 为了提示程序文件未上传提示型号信息时减少数据库查询 -->					
					<input type="hidden" name="PLAN_CODE" id="idPlanCode" value="">
					<tr>
						<td width="15%" align="right" class = "blue" >计划<font color="red">*</font></td>
		       			<td width="35%">
		       				   <input class="easyui-validatebox" required="true" style="background-color: #EEEEEE" name="plan_name" id="idPlanName" size=15 readonly class="readonly">
		                       <input name="reset" type="button" class="btn_grid" value="选择" onClick="selectPlan()">
		                </td>                       
		       			<td width="15%" align="right" class="blue" >应用终端<font color="red">*</font></td>
		       			<td width="35%">
		       				   <input class="easyui-validatebox" required="true" style="background-color: #EEEEEE" name="aposIds" id="idAposIds" size=15 readonly class="readonly">
		                       <input name="reset" type="button" class="btn_grid" value="选择" onClick="selectApos()">
		                </td>
		   			</tr>
		   			<tr>
				       <td width="15%" align="right" class="blue" >硬件序列号</td>
				       <td width="35%">
				         <input type="text" name="serNo" id="idserNo" size=21 maxlength="40" readonly class="readonly">
				       </td> 
			   			<td width="15%" align="right" class="blue" >策略编号<font color="red">*</font></td>      
						<td>
							<input class="easyui-validatebox" required="true" style="background-color: #EEEEEE" name="STRATEGY_ID" id="idStrategyId" size=15 readonly >
		                    <input name="reset" type="button" class="btn_grid" value="选择" onClick="selectStrategy()">
						</td>
					</tr>
							<!--  
										<td>下载开始时间</td>
										<td>
											<input type="text" class="easyui-validatebox"    name="DOWN_BTIME" id="idDownBtime" maxlength="19" />
										</td>
									</tr>
									<tr>
										<td>下载结束时间</td>
										<td>
											<input type="text" class="easyui-validatebox"    name="DOWN_ETIME" id="idDownEtime" maxlength="19" />
										</td>
				 -->					
					<tr>
								<td>分支机构<font color="red">*</font></td>
								<td>
									<input type="hidden" class="easyui-validatebox"  required="true" name="REG_ID" id="idRegId" maxlength="8" />
									<input type="hidden" name="REG_ENTIRE_ID" id="idRegEntireId"/>
									<input type="text" class="easyui-validatebox"  required="true" style="background-color: #EEEEEE" readonly name="REG_ID" id="idRegName" />
									<input id="idChoose" type="button" class="btn_grid" value="选择" onclick="queryReg('idRegId','idRegName','idRegEntireId');"/>
								</td>
				       <td colspan="2" align="center">
				         <input type="button" id="planAdd" name="planAdd" class="btn_grid" value="增 加 计 划 分 配" onClick="addTaskInfo()">
				         <input type="hidden" name="vpos_plancodeList" id="vpos_plancodeList"> 
				       </td>
		   			</tr>
				</table>
			</fieldset>
		</form>
	</div>
	<div region="center" split="true" >  
		<table id="idTaskDetail" ></table>
	</div>
	    
</body>
</html>
