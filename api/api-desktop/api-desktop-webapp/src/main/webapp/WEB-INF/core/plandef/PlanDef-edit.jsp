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
	<title>修改计划定义</title>
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
		  var k=window.dialogArguments; 
		  setModuleNameAndId("ffdetail");
		  setModuleNameAndId();
		  if(k.par){
		  	var param=k.par;
		  	//alert(param);
			$.getJSON("queryPlanDef.do",param,function(data){
				$.each(data.rows,function(idx,item){
			$("#idPlanCode").val($.trim(item.PLAN_CODE));
			$("#idPlanName").val($.trim(item.PLAN_NAME));
			//$("#idCreateDate").val($.trim(item.CREATE_DATE));
			$("#idPlanStatus").val($.trim(item.PLAN_STATUS));
			$("#idPlanType").val($.trim(item.PLAN_TYPE));
			$("#idValidDate").val($.trim(item.VALID_DATE));
			$("#idRegId").val($.trim(item.REG_ID));
			$("#sidRegId").val($.trim(item.REG_ID));
			$("#idRegName").val($.trim(item.REG_NAME));
			$("#idDescTxt").val($.trim(item.DESC_TXT));
			$("#sidPlanCode").val($.trim(item.PLAN_CODE));
			$("#idRegEntirId").val($.trim(item.REG_ENTIRE_ID));
			$("#sidRegEntirId").val($.trim(item.REG_ENTIRE_ID));
				});
            }); 

            
            }
            
            //datagrid的数据
            $(function(){
		    var parammodelId=$('#idPlanCode').val();
		    $("#idvposModelMod").attr('disabled',true);
            initData('idAppId,idMid');
		     //alert(parammodelId);
			$('#idPlanAppInfo').datagrid({
				iconCls:'icon-save',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:true,
				url:'listPlanAppInfo.do?'+param,
				sortName: 'KEYID',
				sortOrder: 'desc',
				remoteSort: false,
				idField:'KEYID',
				pageSize:10,
				pagination:false,
				rownumbers:true,
				frozenColumns:[[
	                {field:'ck',checkbox:true},
	                {field:'FIELDS',title:'FIELDS',hidden:true},
	                {title:'KEYID',field:'KEYID',hidden:true}
				]],
				columns:[[
			{title:'应用编号',field:'APP_ID',align:'center',width:100,sortable:true},
			{title:'应用名称',field:'APP_NAME',align:'center',width:100,sortable:true},
			{title:'主应用标志',field:'MASTER_FLAG',align:'center',width:80,sortable:true},
			{title:'应用版本',field:'APP_VER',align:'center',width:100,sortable:true},
			{title:'参数标志',field:'PARAM_FLAG',align:'center',width:60,sortable:true},
			{title:'应用标志',field:'APP_FLAG',align:'center',width:60,sortable:true},
			{title:'参数模板',field:'PARAM_MODEL_ID',align:'center',width:100,formatter:function(value,rowData,rowIndex){
			             var data="";
			             if(rowData.PARAM_MODEL_ID!=""&&rowData.PARAM_MODEL_ID!=null){
			             data='<a id="modelId" style="color:blue;" href="javascript:paramModelDefUpdate(\''+rowData.PARAM_MODEL_ID+'\',\''+rowData.APP_ID+'\')\">'+rowData.PARAM_MODEL_ID+'</a>';
			             }
			             return data;
			             }},
			{title:'操作',field:'DESC_TXT',align:'center',width:100,formatter:function(value,rowData,rowIndex){
						//var myObject = eval(rowData); 
						//alert(rowData.PARAM_ID);
						//return '';
						//注意KEYID含特殊字符/，必须多加'处理
						var data='';
						data='<input id="del" type="button" class="btn_grid" value="修改" onclick="javascript:modPlanAppInfoedit(\''+rowData.KEYID+'\')\"/> <input id="del" type="button" class="btn_grid" value="删除" onclick="javascript:delPlanAppInfo(\''+rowData.KEYID+'\')\"/>';
						 return data;
						}}
				]]
			});
			
	
		});
            
		  

		function cleardata(){
			$('#ff').form('clear');
		}
		
		function modPlanDef(){
			$('#ff').form('submit',{
		        url:'updatePlanDef.do',
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
						 msgShow("修改","修改成功!","info");
			        	 window.returnValue=myObject.status; 
			        }else if(myObject.status=="false"){
			        	msgShow("修改",myObject.message,"error");
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
							<fieldset id="modelArea" style="padding:8px;width:95%;border:1px solid #46A3FF; color:#CC3300; line-height:1.0; font-size:12px;" align=center><legend>基本信息</legend>  
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
												<input type="text" class="easyui-validatebox" required="true"   name="PLAN_NAME" id="idPlanName" maxlength="40" validType="maxLen[40]"/>
											</td>
										</tr>
										<tr>
											<td>分支机构<font color="red">*</font></td>
											<td>
											<input type="hidden" class="easyui-validatebox"    name="REG_ID" id="idRegId" maxlength="8" />
											<input type="hidden"   name="REG_ENTIRE_ID" id="idRegEntirId" maxlength="50" />
											<input type="text" class="easyui-validatebox" style="background-color: #EEEEEE" required="true"   name="REG_NAME" id="idRegName" readonly="readonly" />
											<!-- 
											<input id="idChoose" type="button" class="btn_grid" value="选择" onclick="queryReg('idRegId','idRegName','idRegEntirId');"/>
											<input id="idClear" type="button" class="btn_grid" value="清空" onclick="clearReg('idRegId','idRegName','idRegEntirId');"/>
										     -->
										    </td>	
										<td>有效时间<font color="red">*</font></td>
										<td>
										<input name="VALID_DATE" id="idValidDate" class="Wdate" type="text" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'%y-%M-{%d+1}'})" readonly>
										</td>
										</tr>
										<tr>
											
											<td>备注</td>
											<td>
                                             <textarea rows="3" cols="45" required="false"   name="DESC_TXT" id="idDescTxt" maxlength="100" validType="maxLen[100]"/></textarea>
											</td>
											<td>&nbsp;</td>
											<td>
				                                <input type="button" id="idmodplandef" name="modplandef" value="修改计划定义" class="btn_grid" onClick="modPlanDef()" > 
				        &nbsp;&nbsp;
												</td>
										</tr>

									</table>
									</fieldset>
								    </form>
                                   <form id="ffdetail" method="post" name="form1">
                                 
									<fieldset id="appArea"  style="padding:8px;width:95%;border:1px solid #46A3FF; color:#CC3300; line-height:1.0; font-size:12px;" align=center><legend>计划应用信息</legend>   
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
                                  <input type="hidden" id="idkeyId" name="KEY_ID" />
                                  <input type="hidden" id="idSparamodId" name="SPARAMEID">
								</tr>
											<tr>
												<td>应用<font color="red">*</font></td>
												<td>
												    <select    required="true" name="APP_ID" id="idAppId"  onchange="changeAppVerInfo(this.value);" style="width: 60%">
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
												<select  class="easyui-validatebox" required="true"   name="APP_VER" id="idAppVer" style="width: 60%" onchange="showAppMsg();" >
													 <option value="">请选择应用版本</option>
													</select>
												</td>
												
												<td>参数模板<font color="red">*</font></td>
												<td>
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
					                          <option value="1" >更新</option> 
					                          <option value="0" >不更新</option>   
					                          <option value="4">删除</option>                     
					                       </select>
											
											</td>
											</tr>
												<tr>
												<td>参数更新标志<font color="red">*</font></td>
												<td>
											<select id="idParamUpdateFlag" name="PARAM_UPDATE_FLAG"  style="width:200" >
				                          <option value="1" >更新</option>                  
				                          <option value="4">删除</option>                        
				                       </select>
												</td>
												<td>&nbsp;</td>
												<td>
				                                
												</td>
											</tr>
											<tr>
												<td>&nbsp;</td>
												<td>
		                                     <input type="button" id="idvposModelMod" name="vposModelMod" value="修改计划应用" class="btn_grid" onClick="modPlanAppInfo()" > 
				        &nbsp;&nbsp;
												</td>
												<td>&nbsp;</td>
												<td>
										        <input type="button" id="idvposModelAdd" name="vposModelAdd" value="添加计划应用" class="btn_grid" onClick="addPlanAppInfo()" > 
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
