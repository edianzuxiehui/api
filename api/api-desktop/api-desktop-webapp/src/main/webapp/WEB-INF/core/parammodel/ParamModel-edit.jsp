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
	<title>修改参数模板</title>
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
		  var k=window.dialogArguments; 
		  if(k.par){
		  	var param=k.par;
			$.getJSON("queryParamModel.do",param,function(data){
				$.each(data.rows,function(idx,item){
			$("#idParamModelId").val($.trim(item.PARAM_MODEL_ID));
			$("#idParamModelName").val($.trim(item.PARAM_MODEL_NAME));
			$("#idCreateTime").val($.trim(item.CREATE_TIME));
			$("#idModelStatus").val($.trim(item.MODEL_STATUS));
			$("#idRegId").val($.trim(item.REG_ID));
			$("#idRegName").val($.trim(item.REG_NAME));
			$("#idAppId1").val($.trim(item.APP_ID));
			initDataForDevAppFile('idAppId');//初始化应用列表
			$("#idDescTxt").val($.trim(item.DESC_TXT));
				});
            }); 
         }
		 setModuleNameAndId(); 

		function cleardata(){
			$('#ff').form('clear');
		}
		
		function addParamModel(){
			$('#ff').form('submit',{
		        url:'updateParamModel.do',
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
						 window.close();
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
	<div region="center"  fit="true" title="信息录入" >
		<form id="ff" method="post">
			<table class="formTable" style="width:100%;">
				<col  width="30%" class="leftCol"/>
				<col width="70%" >
				
				<!-- 下拉框数据异步加载，存在延时，为了显示下拉框需而设置临时元素 -->
				<input type="hidden" id="idAppId1" name="APP_ID1"/>
				
							<tr>
								<td>参数模板编号<font color="red">*</font></td>
								<td>
									<input type="text" class="readonly" required="true" name="PARAM_MODEL_ID" id="idParamModelId" maxlength="10" />
								</td>
							</tr>
							<tr>
								<td>参数模板名称<font color="red">*</font></td>
								<td>
									<input type="text" class="easyui-validatebox" required="true" onkeyup="return limitMaxByte(this,this.maxlength)" name="PARAM_MODEL_NAME" id="idParamModelName" maxlength="30" />
								</td>
							</tr>
					<!-- 		<tr>
								<td>模板状态</td>
								<td>
									<input type="text" class="easyui-validatebox"    name="MODEL_STATUS" id="idModelStatus" maxlength="1" />
								</td>
							</tr> -->
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
								    <select name="APP_ID" id="idAppId" style="width:53%">
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
						<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="javascript:window.close()">取消</a>
					</div>
</body>
</html>
