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
	<title>参数模板复制</title>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/icon.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/default.css">
	<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/common.js"></script>
	<script type="text/javascript" src="core/parammodel/ParamModel-js.js"></script>
	<script type="text/javascript">
	$(function(){
		  var k=window.dialogArguments; 
		  var param=k.par;
		  if(param){//alert(param.cloneId);
		  	$('#cloneId').val(param.cloneId);//alert($('#cloneId').val());
		  	$('#cloneAppId').val(param.cloneAppId);//alert($('#cloneId').val());
		  }else{
		  	msgShow("参数模板","传递参数为空!","err");
		  	return;
		  }

			$.ajax({
			   type:"POST",
			   url:"getMaxId.do",
			   data:"sequeceId=PARAM_MODEL_ID",		
			   success:function(data){
					$('#idParamModelId').val(data);
			   },
			   error:function(data){
			   		msgShow("错误",data,"error");
			   }
			});
			initDataForDevAppFile('idAppId');
			
		});
		setModuleNameAndId();
		 		 
		function cleardata(){
			var paramModelId = $('#idParamModelId').val();
			var cloneId = $('#cloneId').val();
			var cloneAppId = $('#cloneAppId').val();
			$('#ff').form('clear');
			$('#idParamModelId').val(paramModelId);
			$('#cloneId').val(cloneId);
			$('#cloneAppId').val(cloneAppId);
			$('#idAppId').val("");
			$('#idParamModelName').focus();
		}
		
		function addParamModel(){
			$('#ff').form('submit',{
		        url:'cloneParamModel.do',
			    onSubmit:function(){
			    	var cloneAppId = $('#cloneAppId').val();
			    	var appId = $('#idAppId').val();
			    	if(cloneAppId!=''&&appId!=''&&cloneAppId!=appId
			    			&&(cloneAppId=='00000000'||appId=='00000000')){
			    		msgShow("参数模板复制","TMS管理器应用和子应用的模板不能相互复制!","info");
			    		return false;
			    	}
			        return $(this).form('validate');
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
			        	msgShow("参数模板复制",myObject.message,"error");
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
				<col  width="30%" class="leftCol"/>
				<col width="70%" >
					<input type="hidden" name="cloneId" id="cloneId" />
					<input type="hidden" name="cloneAppId" id="cloneAppId" />
							<tr>
								<td>参数模板编号<font color="red">*</font></td>
								<td>
									<input type="text" class="easyui-validatebox" required="true" validType="numberorchar" name="PARAM_MODEL_ID" id="idParamModelId" style="background-color: #EEEEEE" readonly maxlength="10" />
								</td>
							</tr>
							<tr>
								<td>参数模板名称<font color="red">*</font></td>
								<td>
									<input type="text" class="easyui-validatebox" required="true" onkeyup="return limitMaxByte(this,this.maxlength)" name="PARAM_MODEL_NAME" id="idParamModelName" maxlength="30" />
								</td>
							</tr>
							<tr>
								<td>分支机构<font color="red">*</font></td>
								<td>
									<input type="hidden" class="easyui-validatebox"  required="true" name="REG_ID" id="idRegId" maxlength="8" />
									<input type="text" class="easyui-validatebox"  required="true" style="background-color: #EEEEEE" readonly name="REG_ID" id="idRegName" />
									<input id="idChoose" type="button" class="btn_grid" value="选择" onclick="queryReg('idRegId','idRegName');"/>
									<input id="idClear" type="button" class="btn_grid" value="清空" onclick="clearReg('idRegId','idRegName');"/>
								</td>
							</tr>
							<tr>
								<td>应用<font color="red">*</font></td>
								<td>
								    <select   class="easyui-validatebox" required="true" name="APP_ID" id="idAppId" style="width:53%">
									 <option value="">请选择应用</option>
									</select>
								</td>
							</tr>
							<tr>
								<td>备注</td>
								<td>
									<textarea rows="3" cols="25" class="easyui-validatebox" onkeyup="return limitMaxByte(this,this.maxlength)" name="DESC_TXT" id="idDescTxt" maxlength="100"></textarea>
								</td>
							</tr>
						</table>
					    </form>
					</div>
					<div region="south"   style="text-align:right;" class="toolbarHeader">
						<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="addParamModel()">确认</a>
						<a class="easyui-linkbutton" iconCls="icon-redo" href="javascript:void(0)" onclick="cleardata()">重置</a>
						<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="javascript:window.close()">取消</a>
					</div>
</body>
</html>
