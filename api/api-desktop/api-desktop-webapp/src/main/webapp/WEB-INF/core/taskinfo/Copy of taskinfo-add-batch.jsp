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
	<title>批量新增任务</title>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/icon.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/default.css">
	<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/common.js"></script>
	<script type="text/javascript" src="core/taskinfo/taskInfo-add-batch-js.js"></script>
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
			       		 updateRow(myObject.aposTaskList);
			       		 msgShow("新增",myObject.message,"info");
			       		 //window.close();
			        }else if(myObject.status=="false"){
			        	msgShow("新增",myObject.message,"error");
			        }
			    }
			});
		}

		function updateRow(aposTaskList){
			var rows = $('#idAposDetail').datagrid('getData').rows;//getObjectProp(rows[0]);
			for(var i=0;i<rows.length;i++){
				//$('#idAposDetail').datagrid('deleteRow',i);//不能先删后加
				for(var j=0;j<aposTaskList.length;j++){
					if(rows[i].APOS_ID==aposTaskList[j].aposId){
						rows[i].taskDetail = "<a href=\"javascript:taskDetail('"+aposTaskList[j].taskSysId+"','"+aposTaskList[j].aposId+"')\">任务明细</a>";
						$('#idAposDetail').datagrid('updateRow',{'index':i,'row':rows[i]});	
						break;
					}
				}
			}
		}
	</script>
</head>
<body class="easyui-layout" fit="true">
	<div region="north" style="height:120px" title="基本信息">
		<form id="ff" method="post">
				<table class="formTable" style="width:90%;">
					<col  width="100px" class="leftCol"/>
					<col width="250px" >
					<col  width="100px" class="leftCol"/>
					<col width="250px" >
					<input type="hidden" name="devIds" id="idDevIds">
		            <input type="hidden" name="aposIds" id="idAposIds">
		            <input type="hidden" name="aposMids" id="idAposMids"> 
					<input type="hidden" name="PLAN_CODE" id="idPlanCode" value="">
					<tr>
						<td width="15%" align="right" class = "blue" >计划:</td>
		       			<td width="35%">
		       				   <input class="easyui-validatebox" required="true" style="background-color: #EEEEEE" name="plan_name" id="idPlanName" size=15 readonly class="readonly">
		                       <input name="reset" type="button" class="btn_grid" value="选择" onClick="selectPlan()">
		                </td>                       
		       			<td colspan="2" align="center">
		                       <input name="reset" type="button" class="btn_grid" value="应  用  终  端  选  择" onClick="selectApos()">
		                </td>
		   			</tr>
		   			<tr>
			   			<td width="15%" align="right" class="blue" >策略编号</td>      
						<td>
							<input class="easyui-validatebox" required="true" style="background-color: #EEEEEE" name="STRATEGY_ID" id="idStrategyId" size=15 readonly >
		                    <input name="reset" type="button" class="btn_grid" value="选择" onClick="selectStrategy()">
						</td>
								<td>分支机构</td>
								<td>
									<input type="hidden" class="easyui-validatebox"  required="true" name="REG_ID" id="idRegId" maxlength="8" />
									<input type="hidden" name="REG_ENTIRE_ID" id="idRegEntireId"/>
									<input type="text" class="easyui-validatebox"  required="true" style="background-color: #EEEEEE" readonly name="REG_ID" id="idRegName" />
									<input id="idChoose" type="button" class="btn_grid" value="选择" onclick="queryReg('idRegId','idRegName','idRegEntireId');"/>
									<input id="idClear" type="button" class="btn_grid" value="清空" onclick="clearReg('idRegId','idRegName','idRegEntireId');"/>
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
				       <td colspan="4" align="center">
				         <input type="button" id="planAdd" name="planAdd" class="btn_grid" value="增 加 计 划 分 配" onClick="addTaskInfo()">
				       </td>
		   			</tr>
				</table>
		</form>
	</div>
	<div region="center" style="height:30px;position:relative;" title="计划应用信息">  
		<table id="idTaskBatch" ></table>
	</div>
	<div region="south" style="height:170px;position:relative;" title="应用终端信息">  
		<table id="idAposDetail" ></table>
	</div>	    
</body>
</html>
