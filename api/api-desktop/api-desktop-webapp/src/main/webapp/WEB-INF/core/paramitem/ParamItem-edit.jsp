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
	<title>修改参数项</title>
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
		
		function cleardata(){
			$('#ff').form('clear');
		}
		
		function addParamItem(){
			$('#ff').form('submit',{
		        url:'updateParamItem.do',
			    onSubmit:function(){
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
			        //alert(myObject.status);
			        if(myObject.status=="true"){
						 window.close();
			        	 window.returnValue=myObject.status; 
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

							<tr>
								<td>参数项编号</td>
								<td>
									<input type="text" class="readonly" readonly name="PARAM_ID" id="idParamId" maxlength="8" />
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
									<input type="text" class="easyui-validatebox" required validType="integer" name="VALUE_LEN" id="idValueLen"  />
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
									<textarea class="easyui-validatebox" rows="3" cols="25" onkeyup="return limitMaxByte(this,this.maxLength)" name="DESC_TXT" id="idDescTxt" maxLength="100"></textarea>
								</td>
							</tr>
						</table>
					    </form>
					</div>
					<div region="south"   style="text-align:right;" class="toolbarHeader">
						<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="addParamItem()">确认</a>
						<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="javascript:window.close()">取消</a>
					</div>
</body>
	<script type="text/javascript">
		  var k=window.dialogArguments; 
		  if(k.par){
		  	var param=k.par;
			$.getJSON("queryParamItem.do",param,function(data){
				$.each(data,function(idx,item){
					$("#idParamId").val($.trim(item.PARAM_ID));
					$("#idParamName").val($.trim(item.PARAM_NAME));
					$("#idDataType").val($.trim(item.DATA_TYPE));
					$("#idValueLen").val(item.VALUE_LEN);
					
					//$("#idParamGroup").combobox('setValue',$.trim(item.PARAM_GROUP));
					getParamGroup($.trim(item.PARAM_GROUP));
					
					$("#idDefValue").val($.trim(item.DEF_VALUE));
					$("#idDescTxt").val($.trim(item.DESC_TXT));
				});
            }); 
         }
</script>
</html>
