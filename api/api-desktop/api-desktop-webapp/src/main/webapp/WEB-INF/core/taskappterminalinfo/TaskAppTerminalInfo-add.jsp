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
	<title>新增任务应用信息</title>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/icon.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/default.css">
	<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/common.js"></script>
	<script type="text/javascript" src="core/taskappterminalinfo/TaskAppTerminalInfo-js.js"></script>
	<script type="text/javascript">
	$(function(){
		  var k=window.dialogArguments; 
		  if(k.par){
          	var param=k.par;
          	$('#idTaskSysId').val(param.taskSysId);//alert($('#idTaskSysId').val());
          	$('#idPlanCode').val(param.planCode);
          	$('#idAposId').val(param.aposId);
          	$('#idRegId').val(param.regId);
          	$('#idRegEntireId').val(param.regEntireId);
          }
          initDataForDevAppFile('idAppId');
	 });  
	setModuleNameAndId();
	
		function cleardata(){
			$('#ff').form('clear');
		}
		
		function addTaskAppTerminalInfo(){
			$('#ff').form('submit',{
		        url:'addTaskAppTerminalInfo.do',
			    onSubmit:function(){
			        return validApp()&& $(this).form('validate');
			    },
			    success:function(data){
			      var myObject = eval('(' + data + ')');
			       //这种方式直接关闭窗口，返回true或者false给主窗口
			       // window.close();
			       // window.returnValue=myObject.status; 
			        
			        //这种错误情况下方式不关闭窗口	 
			       if(myObject.status=="true"){
						 window.close();
			        	 window.returnValue=myObject.status; 
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
	<div region="center"  fit="true" title="信息录入" >
		<form id="ff" method="post">
			<table class="formTable" style="width:100%;">
				<col  width="35%" class="leftCol"/>
				<col width="65%" >
				<input type="hidden" name="TASK_SYS_ID" id="idTaskSysId"/>
				<input type="hidden" name="PLAN_CODE" id="idPlanCode"/>
				<input type="hidden" name="APOS_ID" id="idAposId"/>
				<input type="hidden" name="REG_ID" id="idRegId"/>
				<input type="hidden" name="REG_ENTIRE_ID" id="idRegEntireId"/>
							<tr>
								<td>应用<font color="red">*</font></td>
								<td>
								    <select   class="easyui-validatebox" required="true" name="APP_ID" id="idAppId"  onchange="changeAppVerInfo(this.value);getAposMerchTermAc2AppId(this.value);" style="width:50%">
									 <option value="">请选择应用</option>
									</select>
									
								</td>
							</tr>
							<tr>
								<td>应用版本<font color="red">*</font></td>
								<td>
									<select  class="easyui-validatebox" required="true" name="APP_VER" id="idAppVer" style="width: 50%" >
									 <option value="">请选择应用版本</option>
									</select>
								</td>
							</tr>
							<tr>
								<td>参数模板编号</td>
								<td>
													<select  class="easyui-validatebox" required="true"  name="PARAM_MODEL_ID" id="idParamModelId" style="width: 50%" >
													 <option value="">请选择参数模板</option>
													</select>
								</td>
							</tr>
							<tr>
								<td>更新时间</td>
								<td>
									<input name="UPDATE_DATE" id="idUpdateDate" required="true" class="Wdate" type="text" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly/>
									<input type="button" value="立即更新" class="btn_grid" onClick="$('#idUpdateDate').val('0000-00-00 00:00:00');">
								</td>
							</tr>
							<tr>
								<td>主应用标志</td>
								<td>
									<select name="MASTER_APP_FLAG" id="idMasterAppFlag" class="easyui-validatebox" required="true" style="width:120">
			                          <option value="1">是</option>   
			                          <option value="0" selected>否</option>                       
			                       </select>
								</td>
							</tr>
							<tr>
								<td>应用更新标志</td>
								<td>
									<select  name="APP_UPDATE_FLAG" id="idAppUpdateFlag" class="easyui-validatebox" required="true" style="width:120">
			                          <option value="0" >不更新</option>   
			                          <option value="1" selected>更新</option>                  
			                          <option value="4">删除</option>                         
			                       </select>
								</td>
							</tr>
							<tr>
								<td>参数更新标志</td>
								<td>
									<select name="PARAM_UPDATE_FLAG" id="idParamUpdateFlag" class="easyui-validatebox" required="true" style="width:120"> 
			                          <option value="1" selected>更新</option>                  
			                          <option value="4">删除</option>                       
			                       </select>
								</td>
							</tr>
							<tr>
								<td>商户编码</td>
								<td>
									<input type="hidden" name="MERCH_ID" id="idMerchId" maxlength="15" />
									<input type="text" style="background-color: #EEEEEE" readonly name="MERCH_NAME" id="idMerchName" maxlength="15" />
									<input id="idChoose" type="button" class="btn_grid" value="选择" onclick="selMerch();"/>
								</td>
							</tr>
						<!-- <tr>
								<td>分店编码</td>
								<td>
									<input type="text" class="readonly" readonly name="SUB_ID" id="idSubId" maxlength="5" />
								</td>
							</tr> -->
							<tr>
								<td>终端号</td>
								<td>
									<input type="text" name="TERMINAL_ID" id="idTerminalId" maxlength="8" />
								</td>
							</tr>
							<!--<tr>
								<td>机构代码</td>
								<td>
									<input type="text" class="easyui-validatebox"  required="true"  name="ORG_ID" id="idOrgId" maxlength="255" />
								</td>
							</tr> -->
							<tr>
								<td>备注</td>
								<td>
									<input type="text" class="easyui-validatebox" onkeyup="return limitMaxByte(this,this.maxlength)" name="DESC_TXT" id="idDescTxt" maxlength="6" />
								</td>
							</tr>
						</table>
					    </form>
					</div>
					<div region="south"   style="text-align:right;" class="toolbarHeader">
						<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="addTaskAppTerminalInfo()">确认</a>
						<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="javascript:window.close()">取消</a>
					</div>
</body>
<script language="javascript" type="text/javascript" src="<%=basePath%>js/DatePicker/WdatePicker.js"></script>
</html>
