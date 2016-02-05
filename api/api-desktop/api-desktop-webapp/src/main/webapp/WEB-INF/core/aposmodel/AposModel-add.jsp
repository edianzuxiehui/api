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
	<title>新增应用终端模板</title>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/icon.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/default.css">
	<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/easyui-lang-zh_CN.js"></script>
	      <script type="text/javascript" src="<%=basePath%>js/common.js"></script>
           <script type="text/javascript" src="core/aposmodel/AposModel-js.js"></script>
           
		<script type="text/javascript">
		
		//window.onbeforeunload=checkAposModel;
		  setModuleNameAndId("ffdetail");
		  setModuleNameAndId();
		 
		function cleardata(){
			$('#ff').form('clear');
		}
		
		
			$(document).ready(function(){
			/*
			$.ajax({
			   type:"POST",
			   url:"getMaxId.do",
			   data:"sequeceId=APOSMODULEID",		
			   success:function(data){
					$('#idAposModelId').val(data);
			   },
			   error:function(data){
			   		msgShow("错误",data,"error");
			   }
			}); */
			getSequence('APOSMODULEID','idAposModelId');
			QueryReg();
			$('#idrvposModelAdd').attr('disabled',true);
			$('#idAppId').attr('disabled',true);
			$('#idAppVer').attr('disabled',true);
			$('#idparamodId').attr('disabled',true);
			//$('#sidRegEntirId').val($('#idRegEntirId').val());
			
		});
		
		function addAposModel(){
			$('#ff').form('submit',{
		        url:'addAposModel.do',
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
			        	 window.returnValue=myObject.status; 
			        	 var idAposModelId = $('#idAposModelId').val();
			        	 $('#appArea').attr('disabled',false);
			        	 $('#modelArea').attr('disabled',true);
			        	 $('#vposModelAdd').attr('disabled',true);
			        	 $('#idAposModelId').val(idAposModelId);
			        	 $('#idChoose').attr('disabled',true);
			        	 $('#idClear').attr('disabled',true);
			        	 $('#idAposModelName').attr('disabled',true);
			        	 $('#idAposmodel').val($('#idAposModelId').val());
			        	 $('#sidRegId').val($('#idRegId').val());
							$('#idrvposModelAdd').attr('disabled',false);
							$('#idAppId').attr('disabled',false);
							$('#idAppVer').attr('disabled',false);
							$('#idparamodId').attr('disabled',false);
			        	 $('#sidRegEntirId').val($('#idRegEntirId').val());
			        	initData('idAppId,idMid');
			        	 msgShow("新增","新增应用参数模板成功","info");
			        }else if(myObject.status=="false"){
			        	msgShow("新增",myObject.message,"error");
			        	//window.close();
			        }
			    }
			});
		}
			//window.onbeforeunload=checkAposModel;
	</script>
</head>
<body class="easyui-layout" fit="true"  >
		<div region="north"  title="信息录入" style="height: 270px">
					<div class="easyui-layout" fit="true"  >
					<div region="center"   >
							<form id="ff" method="post">
							<fieldset id="modelArea" style="padding:6px;width:95%;border:1px solid #46A3FF; color:#CC3300; line-height:2.0; font-size:12px;" align=center><legend>基本信息</legend>  
							<table class="formTable" style="width:100%;">
							<col  width="100px" class="leftCol"/>
							<col width="200px" >
							<col  width="100px" class="leftCol"/>
							<col width="200px" >
										<tr>
											<td>终端模板编号<font color="red">*</font></td>
											<td>
												<input type="text" class="readonly" required="true" readonly  required="true"   name="APOS_MODEL_ID" id="idAposModelId" maxlength="10" />
											</td>
											
											<td>终端模板名称<font color="red">*</font></td>
											<td>
												<input type="text" class="easyui-validatebox" required="true"   name="APOS_MODEL_NAME" id="idAposModelName" maxlength="30" validType="maxLen[30]"/>
											</td>
										</tr>
										<tr>
											<td>分支机构<font color="red">*</font></td>
											<td>
												<input type="hidden"   name="REG_ID" id="idRegId" maxlength="8" />
												<input type="hidden"   name="REG_ENTIRE_ID" id="idRegEntirId" maxlength="50" />
												<input type="text" class="easyui-validatebox" style="background-color: #EEEEEE" required="true"   name="REG_NAME" id="idRegName" readonly="readonly" />
												<input id="idChoose" type="button" class="btn_grid" value="选择" onclick="queryReg('idRegId','idRegName','idRegEntirId');"/>
												<input id="idClear" type="button" class="btn_grid" value="清空" onclick="clearReg('idRegId','idRegName','idRegEntirId');"/>
											</td>
											<td>&nbsp;</td>
											<td>
			        <input type="button" id="idvposModelAdd" name="vposModelAdd" value="添加基本信息" class="btn_grid" onClick="addAposModel()" > 
			        &nbsp;&nbsp;
											</td>
										</tr>
									</table>
									</fieldset>
								    </form>
                                   <form id="ffdetail" method="post">
                                 
									<fieldset id="appArea" disabled="true" style="padding:6px;width:95%;border:1px solid #46A3FF; color:#CC3300; line-height:2.0; font-size:12px;" align=center><legend>模板应用信息</legend>   
										<table class="formTable" style="width:100%;">
								<col  width="100px" class="leftCol"/>
								<col width="250px" >
								<col  width="100px" class="leftCol"/>
								<col width="250px" >
								<tr>
								  <input type="hidden" id="idAposmodel" name="APOS_MODEL_ID">
                                  <input type="hidden" name="sREG_ID" id="sidRegId"  readonly="readonly" maxlength="8" />
                                  <input type="hidden" name="sREG_ENTIRE_ID" id="sidRegEntirId" maxlength="50" />
								</tr>
											<tr>
												<td>应用<font color="red">*</font></td>
												<td>
												    <select   class="easyui-validatebox" required="true" name="APP_ID" id="idAppId"  onchange="changeAppVerInfo(this.value);" style="width: 80%">
													 <option value="">请选择应用编号</option>
													</select>
												</td>
												
												<td>应用版本<font color="red">*</font></td>
												<td>
												<select  class="easyui-validatebox" required="true"   name="APP_VER" id="idAppVer" style="width: 80%" >
													 <option value="">请选择应用版本</option>
													</select>
												</td>
											</tr>
											<tr>
												<td>参数模板<font color="red">*</font></td>
												<td>
												<select  class="easyui-validatebox" required="true"   name="parammodname" id="idparamodId" style="width: 80%" >
													 <option value="">请选择参数模板</option>
													</select>
												</td>
												<td>主应用</td>
												<td>
												 <input type="radio" id="idMasterflag" name="masterFlag" value="1" checked="checked" /><label class="label" for="splittrue">是</label>
				                                 <input type="radio" id="idMasterflag" name="masterFlag" value="0" /><label class="label" for="splitflase">否</label>
												</td>
											</tr>
											
												<tr>
												<td>&nbsp;</td>
												<td>
												&nbsp;
												</td>
												<td>&nbsp;</td>
												<td>
				                                <input type="button" id="idrvposModelAdd" name="vposModelAdd" value="添加模板明细" class="btn_grid" onClick="addAposModelAppInfo()" > 
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
			<table id="idParamModeldetail" ></table>
	    </div>
					<div region="south"   style="text-align:right;" class="toolbarHeader">
						<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="checkAposModel('confirm')">确认</a>
						<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="checkAposModel()">取消</a>
					</div>
</body>
</html>
