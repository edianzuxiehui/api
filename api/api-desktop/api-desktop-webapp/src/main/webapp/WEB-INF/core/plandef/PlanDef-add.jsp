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
  
	<title>新增计划定义</title>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/icon.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/default.css">
	<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/easyui-lang-zh_CN.js"></script>
	      <script type="text/javascript" src="<%=basePath%>js/common.js"></script>
	      <script type="text/javascript" src="core/plandef/PlanDef-js.js"></script>
	      

		<script type="text/javascript">
		$(document).ready(function(){
		getSequence('PLANDEFID','idPlanCode');
		QueryReg();
		$('#sidRegEntirId').val($('#idRegEntirId').val());
		var d=new Date();
		setModuleNameAndId("ffdetail");
		setModuleNameAndId();
		var starttm = d.Format("YYYY-MM-DD HH:mm:ss");  
		//$("#idCreateDate").val(starttm);
	    var dp=new Date(new Date().getTime()+15*24 * 60 *60*1000);
		var endtm = dp.Format("YYYY-MM-DD HH:mm:ss"); 
		$("#idValidDate").val(endtm);
		$('#idrvposModelAdd').attr('disabled',true);
		$('#idAppId').attr('disabled',true);
		$('#idAppVer').attr('disabled',true);
		$('#idparamodId').attr('disabled',true);
		$('#idUpdateDate').attr('disabled',true);		
		$('#idAppUpdateFlag').attr('disabled',true);
		$('#idParamUpdateFlag').attr('disabled',true);
		
		});
		
		function test(){
		var aa=confirm("确定要关闭?");
		if(aa){
		window.close();
		}
		
		}
		
		
		//window.onbeforeunload=test;
		//window.onbeforeunload=checkPlanStatus;
		
		
		 
		function cleardata(){
			$('#ff').form('clear');
		}
		
		function addPlanDef(){
			$('#ff').form('submit',{
		        url:'addPlanDef.do',
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
						 //window.close();
						  //$('#modelArea').attr('disabled',true);
						  $('#idaddplandef').attr('disabled',true);
			        	  $('#idChoose').attr('disabled',true);
			        	  $('#idClear').attr('disabled',true);
			        	  $('#idPlanName').attr('disabled',true);
			        	  $('#idDescTxt').attr('disabled',true);
			        	  $('#idValidDate').attr('disabled',true);
			        	  
						  $('#appArea').attr('disabled',false);
						  $('#sidRegId').val($('#idRegId').val());
						  $('#sidRegEntirId').val($('#idRegEntirId').val());
						  $("#sidPlanCode").val($("#idPlanCode").val());
							$('#idrvposModelAdd').attr('disabled',false);
							$('#idAppId').attr('disabled',false);
							$('#idAppVer').attr('disabled',false);
							$('#idparamodId').attr('disabled',false);
							$('#idUpdateDate').attr('disabled',false);		
							$('#idAppUpdateFlag').attr('disabled',false);
							$('#idParamUpdateFlag').attr('disabled',false);
						  initData('idAppId,idMid');
						  msgShow("新增","新增计划成功","info");
			        	 //window.returnValue=myObject.status; 
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
<div region="north"  title="应用程序定义" style="height: 380px">
					<div class="easyui-layout" fit="true"  >
					<div region="center"   >
							<form id="ff" method="post">
							<fieldset id="modelArea" style="padding:8px;width:90%;border:1px solid #46A3FF; color:#CC3300; line-height:1.0; font-size:12px;" align=center><legend>基本信息</legend>  
							<table class="formTable" style="width:100%;">
							<col  width="100px" class="leftCol"/>
							<col width="250px" >
							<col  width="100px" class="leftCol"/>
							<col width="250px" >
										<tr>
											<td>计划编号<font color="red">*</font></td>
											<td>
												<input type="text" class="readonly" required="true" readonly  required="true"   name="PLAN_CODE" id="idPlanCode" maxlength="8" />
											</td>
											
											<td>计划名称<font color="red">*</font></td>
											<td>
												<input type="text" class="easyui-validatebox" required="true"   name="PLAN_NAME" id="idPlanName" maxlength="40" validType="maxLen[40]" />
											</td>
										</tr>
										<tr>
											<td>分支机构<font color="red">*</font></td>
											<td>
											<input type="hidden" class="easyui-validatebox"    name="REG_ID" id="idRegId" maxlength="8" />
											<input type="hidden"   name="REG_ENTIRE_ID" id="idRegEntirId" maxlength="50" />
											<input type="text" class="easyui-validatebox" style="background-color: #EEEEEE" required="true"   name="REG_NAME" id="idRegName" readonly="readonly" />
											<input id="idChoose" type="button" class="btn_grid" value="选择" onclick="queryReg('idRegId','idRegName','idRegEntirId');"/>
											<input id="idClear" type="button" class="btn_grid" value="清空" onclick="clearReg('idRegId','idRegName','idRegEntirId');"/>
									        </td>
										<td>有效时间<font color="red">*</font></td>
										<td>
										<input name="VALID_DATE" id="idValidDate" class="Wdate" type="text" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'%y-%M-{%d+1}'})" readonly>
										</td>
										</tr>
										<tr>

											<td>备注</td>
											<td>
                                            <textarea rows="3" cols="45" type="text" required="false"   name="DESC_TXT" id="idDescTxt" maxlength="100"  validType="maxLen[100]"></textarea>
											</td>
											<td>&nbsp;</td>
												<td>
				                                <input type="button" id="idaddplandef" name="addplandef" value="添加计划定义" class="btn_grid" onClick="addPlanDef()" > 
				        &nbsp;&nbsp;
												</td>
										</tr>

									</table>
									</fieldset>
								    </form>
                                   <form id="ffdetail" method="post" name="form1">
                                 
									<fieldset id="appArea" disabled="true" style="padding:8px;width:90%;border:1px solid #46A3FF; color:#CC3300; line-height:1.0; font-size:12px;" align=center><legend>计划应用信息</legend>   
										<table class="formTable" style="width:100%;">
								<col  width="100px" class="leftCol"/>
								<col width="250px" >
								<col  width="100px" class="leftCol"/>
								<col width="250px" >
								<tr>
								  <input type="hidden" id="sidPlanCode" name="S_PLAN_CODE">
                                  <input type="hidden" name="sREG_ID" id="sidRegId"  readonly="readonly" maxlength="8" />
                                  <input type="hidden" name="sREG_ENTIRE_ID" id="sidRegEntirId" maxlength="50" />
                                  <input type="hidden" id="idChangePlanStatus" name="ChangePlanStatus"  value="0" /> 
								</tr>
											<tr>
												<td>应用<font color="red">*</font></td>
												<td>
												    <select   class="easyui-validatebox" required="true" name="APP_ID" id="idAppId"  onchange="changeAppVerInfo(this.value);" style="width: 80%">
													 <option value="">请选择应用</option>
													</select>
												</td>
												
												<td>主应用</td>
												<td>
												 <input type="radio" id="idMasterflag" name="MASTER_APP_FLAG" value="1" checked="checked" /><label class="label" for="splittrue">是</label>
				                                 <input type="radio" id="idMasterflag" name="MASTER_APP_FLAG" value="0" /><label class="label" for="splitflase">否</label>
												</td>
												
											</tr>
											<tr>
												<td>应用版本<font color="red">*</font></td>
												<td>
												<select  class="easyui-validatebox" required="true"   name="APP_VER" id="idAppVer" style="width: 80%" onchange="showAppMsg();" >
													 <option value="">请选择应用版本</option>
													</select>
												</td>
											
												<td>参数模板<font color="red">*</font></td>
												<td style="width: 235px;">
												<select  class="easyui-validatebox" required="true"   name="PARAM_MODEL_ID" id="idparamodId" style="width: 250px;" onchange="showParamMsg();" >
													 <option value="">请选择参数模板</option>
													</select>
												</td>
											</tr>
											<tr id="desc_msg" style="display: none;">
												<td></td>
												<td >
													<span  id="app_msg" style="color: red;width: 145px; font: 12px;align-text:left;"></span>
												</td>
												
												<td></td>
												<td >
													<span  id="param_msg" style="color: red;width: 145px; font: 12px;align-text:left;"></span>
												</td>
											</tr>
											<tr>
											<td>更新时间<font color="red">*</font></td>
											<td>
										 <input type="text" id="idUpdateDate" name="UPDATE_DATE" class="Wdate" type="text" value="0000-00-00 00:00:00" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'%y-%M-%d'})" readonly> 
                                          <input type="button" value="立即更新" onClick="form1.UPDATE_DATE.value='0000-00-00 00:00:00';" class="blueBtn">
											</td>
											<td>应用更新标志<font color="red">*</font></td>
											<td>
											 <select id="idAppUpdateFlag" name="APP_UPDATE_FLAG"  style="width:120" >
					                          <option value="0" >不更新</option>   
					                          <option value="1" selected>更新</option>                  
					                          <option value="4">删除</option>                     
					                       </select>
											
											</td>
											</tr>
												<tr>
												<td>参数更新标志<font color="red">*</font></td>
												<td>
											<select id="idParamUpdateFlag" name="PARAM_UPDATE_FLAG"  style="width:200" >
				                          <option value="1" selected>更新</option>                  
				                          <option value="4">删除</option>                        
				                       </select>
												</td>
												<td>&nbsp;</td>
												<td>
				                                <input type="button" id="idrvposModelAdd" name="vposModelAdd" value="添加计划应用" class="btn_grid" onClick="addPlanAppInfo()" > 
				        &nbsp;&nbsp;
												</td>
											</tr>
										</table>
										</fieldset>
										</form>
						</div>
					</div>
		</div>
		<div region="center" split="true" >  
			<table id="idPlanAppInfo" ></table>
	    </div>
					<div region="south"   style="text-align:right;" class="toolbarHeader">
						<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="checkPlanStatus()">确认</a>
						<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="checkPlanStatus()">取消</a>
					</div>





					
</body>
<script language="javascript" type="text/javascript" src="<%=basePath%>js/DatePicker/WdatePicker.js"></script>
</html>
