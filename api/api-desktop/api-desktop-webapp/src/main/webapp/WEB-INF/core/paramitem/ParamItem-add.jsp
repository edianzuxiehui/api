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
	<title>新增参数项</title>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/icon.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/default.css">
	<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/common.js"></script>
	<script type="text/javascript" src="core/paramitem/ParamItem-js.js"></script>
		<script type="text/javascript">
		setModuleNameAndId();
		$(document).ready(function(){
			$.ajax({
			   type:"POST",
			   url:"getMaxId.do",
			   data:"sequeceId=PARAM_ID",		
			   success:function(data){
					$('#idParamId').val(data);
			   },
			   error:function(data){
			   		msgShow("错误",data,"error");
			   }
			});
		});
		function cleardata(){
			var paramId = $('#idParamId').val();
			$('#ff').form('clear');
			$('#idParamId').val(paramId);
			$('#idParamName').focus();
		}
		
		function addParamItem(){
			$('#ff').form('submit',{
		        url:'addParamItem.do',
			    onSubmit:function(){
			    	var paramGroup=$.trim($('#idParamGroup').val());
			    	
			    	var retFlag = $(this).form('validate');
			    	if(retFlag){
					    //根据选择数据类型，验证输入默认值
					    var dataType = $('#idDataType').combobox('getValue');
					    if(dataType=='1'){//数字型
					    	var defValue = $('#idDefValue').val();
					    	if(!(/^\d+(\.\d+)?$/i.test(defValue))){
					    		msgShow("默认值","请输入数字!","info");
					    		retFlag = false;
					    	}
					    }			    		
			    	}
			        return retFlag;	
			    },
			    success:function(data){
			      var myObject = eval('(' + data + ')');
			        	// window.close();
			        	// window.returnValue=myObject.status; 
			        	 
			      if(myObject.status=="true"){
						 window.close();
			        	 window.returnValue=myObject.status; 
			        }else if(myObject.status=="false"){
			        	msgShow("新增参数项",myObject.message,"error");
			        	//window.close();
			        }
			    }
			});
		}
		function check(value){//参数项唯一性验证
			if($.trim($('#idParamId').val())!=''){
				var flag =  checkPKIsExist("PARAM_ID",value,"isParamItemUnique");
				if(flag=="true"){
					msgShow("提示","您所输入的参数项编码已经存在，请修改!!!","error");
				}else if(flag ="false") {
					
				}else{
					msgShow("提示","验证输入参数项编码异常，请联系管理员!!!","error");
				}
			}
		}
	</script>
</head>
<body class="easyui-layout" fit="true">
	<div region="center"  fit="true" title="信息录入" >
		<form id="ff" method="post">
			<table class="formTable" style="width:100%;">
				<col  width="30%" class="leftCol"/>
				<col width="70%" >

							<tr>
								<td>参数项编号<font color="red">*</font></td>
								<td>
									<input type="text" class="easyui-validatebox" required="true" validType="numberFixLength[8]" name="PARAM_ID" id="idParamId" maxlength="8" onchange="check(this.value)"/>
								</td>
							</tr>
							<tr>
								<td>参数名称<font color="red">*</font></td>
								<td>
									<input type="text" class="easyui-validatebox" required="true" onkeyup="return limitMaxByte(this,this.maxlength)" name="PARAM_NAME" id="idParamName" maxlength="40" />
								</td>
							</tr>
							<tr>
								<td>参数数据类型<font color="red">*</font></td>
								<td>
				                  <select name="DATA_TYPE" id="idDataType" class="easyui-combobox" required="true" style="width:145" panelHeight="auto" editable="false">
							          <option value="<%=com.landi.tms.util.GlobalConstants.DATA_TYPE_CHAR %>">文本</option>
							          <option value="<%=com.landi.tms.util.GlobalConstants.DATA_TYPE_INT %>">数字</option>
				                  </select>
								</td>
							</tr>
							<tr>
								<td>参数长度<font color="red">*</font></td>
								<td>
									<input type="text" class="easyui-validatebox" required="true" validType="integer" name="VALUE_LEN" id="idValueLen"  />
								</td>
							</tr>
							<tr>
								<td>参数组别<font color="red">*</font></td>
								<td>
									<select  id="idParamGroup" name="PARAM_GROUP" style="width:145px;" panelHeight="90px">
									</select>
								</td>
							</tr>
							<tr>
								<td>默认值<font color="red">*</font></td>
								<td>
									<input type="text" class="easyui-validatebox" required="true" validType="maxLen[$('#idValueLen').val()]" name="DEF_VALUE" id="idDefValue" maxlength="1024" />
								</td>
							</tr>
							<tr>
								<td>备注</td>
								<td>
									<textarea class="easyui-validatebox" rows="3" cols="25" onkeyup="return limitMaxByte(this,this.maxlength)" name="DESC_TXT" id="idDescTxt" maxlength="100"></textarea>
								</td>
							</tr>
						</table>
					    </form>
					</div>
					<div region="south"   style="text-align:right;" class="toolbarHeader">
						<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="addParamItem()">确认</a>
						<a class="easyui-linkbutton" iconCls="icon-redo" href="javascript:void(0)" onclick="cleardata()">重置</a>
						<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="javascript:window.close()">取消</a>
					</div>
</body>
</html>
