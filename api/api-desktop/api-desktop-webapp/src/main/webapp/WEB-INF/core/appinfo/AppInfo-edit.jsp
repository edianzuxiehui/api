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
	<title>修改应用</title>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/icon.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/default.css">
	<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/easyui-lang-zh_CN.js"></script>
	      <script type="text/javascript" src="<%=basePath%>js/common.js"></script>
    <script type="text/javascript" src="core/appinfo/AppInfo-js.js"></script>

		<script type="text/javascript">
		  var k=window.dialogArguments; 
		  if(k.par){
		  	var param=k.par;
			$.getJSON("queryAppInfo.do",param,function(data){
				$.each(data.rows,function(idx,item){
			$("#idAppId").val($.trim(item.APP_ID));
			$("#idAppName").val($.trim(item.APP_NAME));
			$("#idRegId").val($.trim(item.REG_ID));
			$("#idAppStatus").val($.trim(item.APP_STATUS));
			$("#idInputDate").val($.trim(item.INPUT_DATE));
			$("#idShareFlag").val($.trim(item.SHARE_FLAG));
		    $("#idRegName").val($.trim(item.REG_NAME)+"("+$.trim(item.REG_ID)+")");
			
			
			if($.trim(item.SHARE_FLAG)== 0){
			  $("#idShareFlag1").attr("checked",true);
			}else {
			  $("#idShareFlag2").attr("checked",true);
			  
			}
			$("#idDescTxt").val($.trim(item.DESC_TXT));
				});
            }); 
            
         }
		  
        setModuleNameAndId(); 
		
		function cleardata(){
			$('#ff').form('clear');
		}
		
		function addAppInfo(){
			$('#ff').form('submit',{
		        url:'updateAppInfo.do',
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
				<col  width="90px" class="leftCol"/>
				<col width="250px" >

							<tr>
								<td>应用编号<font color="red">*</font></td>
								<td>
									<input type="text" class="easyui-validatebox" required="true" validType="maxLen[8]" readonly="readonly" name="APP_ID" id="idAppId" maxlength="8"  style="background-color: #EEEEEE;width: 45%"/>
								</td>
							</tr>
							<tr>
								<td>应用名称<font color="red">*</font></td>
								<td>
									<input type="text" class="easyui-validatebox"  required="true" validType="maxLen[30]" name="APP_NAME" id="idAppName" maxlength="30" style="width: 45%"/>
								</td>
							</tr>
							<tr>
								<td>分支机构<font color="red">*</font></td>
								<td>
									<input type="hidden" class="easyui-validatebox"    name="REG_ID" id="idRegId" maxlength="8" />
									<input type="text" class="easyui-validatebox" style="background-color: #EEEEEE"  name="REG_NAME" id="idRegName" readonly="readonly"  required="true" />
									<input id="idChoose" type="button" class="btn_grid" value="选择" onclick="queryReg('idRegId','idRegName')"/>
								</td>
							</tr>
							<!--  
							<tr>
								<td>应用状态</td>
								<td>
									<input type="text" class="easyui-validatebox"    name="APP_STATUS" id="idAppStatus" maxlength="1" style="width: 45%"/>
								</td>
							</tr>
							<tr>
								<td>注册日期</td>
								<td>
									<input type="text" class="easyui-validatebox"    name="INPUT_DATE" id="idInputDate" maxlength="17"  style="width: 45%"/>
								</td>
							</tr>
							
							-->
							<tr>
								<td>共享标志<font color="red">*</font></td>
								<td>
	                                <input type="radio"  name="SHARE_FLAG" id="idShareFlag1"value="0" checked>不共享
   		                            <input type="radio" name="SHARE_FLAG" id="idShareFlag2" value="1">共享						
   		                            
   		                         </td>
							</tr>
							<tr>
								<td>备注</td>
								<td>
									<textarea type="text" class="easyui-validatebox"  validType="maxLen[100]"  name="DESC_TXT" id="idDescTxt" maxlength="100" style="width: 150px" ></textarea>
								</td>
							</tr>
						</table>
					    </form>
					</div>
					<div region="south"   style="text-align:right;" class="toolbarHeader">
						<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="addAppInfo()">确认</a>
						<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="javascript:window.close()">取消</a>
					</div>
</body>
</html>
