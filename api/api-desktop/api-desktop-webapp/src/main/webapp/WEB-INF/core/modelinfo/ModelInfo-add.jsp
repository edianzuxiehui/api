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
	<title>新增终端型号</title>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/icon.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/default.css">
	<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/common.js"></script>
    <script type="text/javascript" src="core/modelinfo/ModelInfo-js.js"></script>
	  

		<script type="text/javascript">
		setModuleNameAndId();
		   
		function cleardata(){
			$('#ff').form('clear');
		}
		
		function addModelInfo(){
		     if($("#idExist").val() =="true"){
		       msgShow("提示","您所输入的主机型号已经存在，请修改!!!","error");
		       return;
		    }
		    var appDir=$("#idAppDir").val();
		    if( appDir==""){
		    	msgShow("提示","请输入应用程序目录!!!","error");
		        return;
		    }else{
		    	var start = appDir.substr(0,1);
		    	var end = appDir.substr(appDir.length-1,appDir.length);
		    	if(start !="/"){
		    		appDir = "/"+appDir;
		    	}
		    	if(end != "/"){
		    		appDir = appDir+"/";
		    	}
		    
		    	var checkFlag = checkPKIsExist('appDir',appDir,'checkExistAppDir');
		    	if(checkFlag!='false'){
		    		msgShow("提示","已经存在应用程序目录为["+appDir+"]的型号，请重新输入目录!!!","error");
		        	return;
		    	}
		    }
		    
			$('#ff').form('submit',{
		        url:'addModelInfo.do',
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
			        	msgShow("新增",myObject.message,"error");
			        	//window.close();
			        }
			    }
			});
		}
	</script>
</head>
<body class="easyui-layout" fit="true" onload="initDataForModelInfo('idFidSelect,idDllDir');">
					<div region="center"  fit="true" title="信息录入" >
						<form id="ff" method="post">
						<table class="formTable" style="width:100%;" align="center">
							<col  width="100px" class="leftCol"/>
							<col width="200px" > 

							<tr>
								<td>终端型号<font color="red">*</font></td>
								<td>
									<input type="text" class="easyui-validatebox" required="true" validType="isNull"  name="MID" id="idMid" maxlength="20"  onchange="checkExistModelInfo(this.value);"/>
									 <input type="hidden"  value="" id="idExist">
								</td>
							</tr>
							<tr>
								<td>终端型号名称<font color="red">*</font></td>
								<td>
									<input type="text" class="easyui-validatebox"   required="true"  validType="maxLenAndNotNull[20]"  name="MID_NAME" id="idMidName" maxlength="20" />
								</td>
							</tr>
							<tr>
								<td>终端厂商<font color="red">*</font></td>
								<td>
									<select type="text"  class="easyui-validatebox"   required="true"   name="FID" id="idFidSelect" maxlength="15" style="width:146px"  >
									  <option value="">请选择终端厂商</option>
									</select>
								</td>
							</tr>
							<tr>
								<td>基本配置</td>
								<td>
									<input type="text" class="easyui-validatebox" validType="maxLen[100]"   name="BASE_CONFIG" id="idBaseConfig" maxlength="100"  style="width:200px" />
								</td>
							</tr>
							<tr>
								<td>可选配置</td>
								<td>
									<input type="text" class="easyui-validatebox"  validType="maxLen[50]"  name="OPT_CONFIG" id="idOptConfig" maxlength="100"  style="width:200px"/>
								</td>
							</tr>
							<tr>
								<td>应用程序目录<font color="red">*</font></td>
								<td>
									<input type="text" class="easyui-validatebox"   required="true"  validType="noBlank"   name="APP_DIR" id="idAppDir" maxlength="200" style="width:200px"/>
								</td>
							</tr>
							<tr>
								<td>厂商DLL路径<font color="red">*</font></td>
								<td>
									<input type="text" class="easyui-validatebox"   required="true" validType="dllStart"  name="DLL_DIR" id="idDllDir" maxlength="200"  style="width:200px"/>
                                    <input  type="hidden" value ="" id="dllDirDefaultValue" style="width: 50%">
								</td>
							</tr>
							
						</table>
					    </form>
					</div>
					<div region="south"   style="text-align:right;" class="toolbarHeader">
						<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="addModelInfo()">确认</a>
						<a class="easyui-linkbutton" iconCls="icon-redo" href="javascript:void(0)" onclick="cleardata()">重置</a>
						<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="javascript:window.close()">取消</a>
					</div>
</body>
</html>
