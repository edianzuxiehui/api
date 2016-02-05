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
	<title>修改程序文件</title>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/icon.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/default.css">
	<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/common.js"></script>
    <script type="text/javascript" src="core/devappfile/DevAppFile-js.js"></script>

		<script type="text/javascript">
		  var k=window.dialogArguments; 
		  if(k.par){
		  	var param=k.par;
			$.getJSON("queryDevAppFile.do",param,function(data){
				$.each(data.rows,function(idx,item){
			$("#idAppId").val($.trim(item.APP_ID));
			$("#idAppName").val($.trim(item.APP_NAME));
			$("#idAppVer").val($.trim(item.APP_VER));
			$("#idMid").val($.trim(item.MID));
			$("#idAppFilePath").val($.trim(item.APP_FILE_PATH));
			$("#idRealAppname").val($.trim(item.REAL_APPNAME));
			$("#idRealAppver").val($.trim(item.REAL_APPVER));
			$("#idRegId").val($.trim(item.REG_ID));
			$("#idDescTxt").val($.trim(item.DESC_TXT));
				});
            }); 
            
         }
		setModuleNameAndId();  

		function cleardata(){
			$('#ff').form('clear');
		}
		
		function addDevAppFile(){
			$('#ff').form('submit',{
		        url:'updateDevAppFile.do',
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
<body class="easyui-layout" fit="true"  >
					<div region="center"  fit="true" title="信息录入" >
						<form id="ff" method="post">
						<table class="formTable" style="width:100%;">
			              <col  width="30%" class="leftCol"/>
				          <col width="70%" >
				             
							<tr>
								<td>应用编号<font color="red">*</font></td>
								<td>
									<input type="text" class="easyui-validatebox" required="true"   name="APP_ID" id="idAppId" maxlength="8" readonly="readonly" style="background-color: #EEEEEE;width: 50%"/>
								</td>
							</tr>
							<tr>
								<td>应用名称<font color="red">*</font></td>
								<td>
									<input type="text" class="easyui-validatebox" required="true"   name="APP_NAME" id="idAppName"  readonly="readonly" style="background-color: #EEEEEE;width: 50%"/>
								</td>
							</tr>
							<tr>
								<td>应用版本<font color="red">*</font></td>
								<td>
									<input type="text" class="easyui-validatebox" required="true"   name="APP_VER" id="idAppVer" maxlength="30" readonly="readonly" style="background-color: #EEEEEE;width: 50%" />
								</td>
							</tr>
							<tr>
								<td>终端型号名称<font color="red">*</font></td>
								<td>
									<input type="text" class="easyui-validatebox" required="true"   name="MID" id="idMid" maxlength="20" readonly="readonly" style="background-color: #EEEEEE;width: 33%" />
									<input type="button" class="btn_grid" value="上传文件" onclick="openUpLoadPage('update_devAppFile');"/>	
								</td>
							</tr>
							<tr>
								<td>备注</td>
								<td>
									<textarea type="text" class="easyui-validatebox"    name="DESC_TXT" id="idDescTxt" maxlength="100"   style="width: 250px"></textarea>
								</td>
							</tr>
						</table>
						
						<div id="uploadSuccess" style="display: none;">
							<table class="formTable" style="width:100%;" >
								  <col  width="30%" class="leftCol"/>
				                  <col width="70%" >
								
							
							<tr>
								<td>实际程序名</td>
								<td>
									<input type="text" class="easyui-validatebox"    name="REAL_APPNAME" id="idRealAppname" maxlength="32"  style="background-color: #EEEEEE;width: 50%"  />
								</td>
							</tr>
							<tr>
								<td>实际版本号</td>
								<td>
									<input type="text" class="easyui-validatebox"    name="REAL_APPVER" id="idRealAppver" maxlength="32"  style="background-color: #EEEEEE;width: 50%" />
								</td>
							</tr>
							
							 <tr>	
								<td>程序文件路径</td>
								<td>
								  <input   id="idTempFilePath" name="tempFilePath" maxlength="100" type="hidden" /><!-- 临时目录 -->
									<input type="text" class="easyui-validatebox"  name="APP_FILE_PATH"  id="idAppFilePath"  readonly="readonly"     maxlength="100" style="background-color: #EEEEEE;width: 50%" />
								</td>
							</tr> 
							    <input name="APP_DIR" id="idAppDir" type="hidden"/><!-- 厂商目录 -->
						        <input  id="idDeletePath" name="deletePath" type="hidden"/> <!-- 删除临时文件的目录 -->
						</table>
						</div>
					    </form>
					</div>
					<div region="south"   style="text-align:right;" class="toolbarHeader">
						<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="addDevAppFile();return false">确认</a>
						<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="cancel();">取消</a>
					</div>
</body>
</html>
