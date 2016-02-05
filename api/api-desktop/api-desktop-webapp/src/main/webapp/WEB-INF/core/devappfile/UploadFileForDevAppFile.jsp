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
	<title>上传文件</title>
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
		 
		function cleardata(){
			$('#ff').form('clear');
		}
		 var k = window.dialogArguments;
		 var object = {status:false};
		 window.returnValue = object;
		function uploadFileForDevAppFile(){
		      var files = $("input[name^='uploadFile[']");
		      var flagFile = "";
		      for(var i=0; i < files.length; i++){
		          if(files[i].value!=""){
                    flagFile = "有文件了";
                    break;
                 }
		      }
		      if(flagFile == ""){
		          msgShow("上传的文件","请选择上传文件","error");
		          return;
		      }
			$('#ff').form('submit',{
		        url:'uploadFileForDevAppFile.do'+"?"+k.par,
			    onSubmit:function(){
			         showProcess(true,"上传文件","文件上传中...");
			      // return $(this).form('validate');
			    },
			    success:function(data){
		         object = eval('(' + data + ')');
         		 window.returnValue = object;
         		 showProcess(false);
	  			 window.close();
			    }
			    });
		}
	</script>
</head>
<body class="easyui-layout" fit="true" onload="initDataForDevAppFile('idTempFilePath')">
					<div region="center"  fit="true" title="信息录入" >
						 <form id="ff" method="post"  enctype="multipart/form-data" >
						<table class="formTable" style="width:100%;">
			<tr align="left">
			  <td >上传文件夹<input id="idTempFilePath" type="text" value="" size="25%" readonly="readonly"  >
			  <input type="button" value="增加按钮" onclick="addFile();"  /></td>
			</tr>	
            <tr align="left">
			 <td  id="more"><font color="red">*</font><input type="file" name="uploadFile[0].file" size="30%"   class="easyui-validatebox"/></td>
			

			
			</tr>
	        <!-- 
			<p><input type="file" name="myfile" value="浏览文件..." size="40" /></p>
			
			<p>密钥归属:<select name="regFlag" style="width: 250" onchange="selectReg();">
			<option value="00000000">总公司密钥</option>
			<option value="xxxxxxxx">分公司密钥</option>
			</select></p>			
			<p>MD5校验码输入：<input type="text" id="md51" size="40"></p>
			<div id="reg1" style="display: none"><p>所属单位:<input name="regId" size="14" readonly class="readonly" value="">
                       <input name="reset" type="button" value="选择"  class="blueBtn" onClick="selectParent()"></p>
			</div>
		 -->
	   
                <!--  <tr>
								<td>应用编号</td>
								<td>
								    <select   class="easyui-validatebox" required="true" name="APP_ID" id="idAppId"  onchange="changeAppVerInfo(this.value);" style="width: 50%">
									 <option value="">请选择应用编号</option>
									</select>
								</td>
							</tr>
							<tr>
								<td>应用版本</td>
								<td>
									<select  class="easyui-validatebox" required="true"   name="APP_VER" id="idAppVer" style="width: 50%" >
									 <option value="">请选择应用版本</option>
									</select>
								</td>
							</tr>
							<tr>
								<td>主机型号</td>
								<td>
	                               <select class="easyui-validatebox" required="true" name="MID" id="idMid" maxlength="20" style="width: 33%" >
									<option value="">请选择主机型号</option>
									</select>
									<input type="button" class="btn_grid" value="上传文件" onclick="upLoadFile();"/>							
							    </td>
							</tr>
							<tr>
								<td>程序文件路径</td>
								<td>
									<input type="text" class="easyui-validatebox"    name="APP_FILE_PATH" id="idAppFilePath" maxlength="100" />
								</td>
							</tr>
							<tr>
								<td>实际程序名</td>
								<td>
									<input type="text" class="easyui-validatebox"    name="REAL_APPNAME" id="idRealAppname" maxlength="32" />
								</td>
							</tr>
							<tr>
								<td>实际版本号</td>
								<td>
									<input type="text" class="easyui-validatebox"    name="REAL_APPVER" id="idRealAppver" maxlength="32" />
								</td>
							</tr>
							<tr>
								<td>分支机构编号</td>
								<td>
									<input type="text" class="easyui-validatebox"    name="REG_ID" id="idRegId" maxlength="8" />
								</td>
							</tr>
							<tr>
								<td>备注</td>
								<td>
									<input type="text" class="easyui-validatebox"    name="DESC_TXT" id="idDescTxt" maxlength="100" />
								</td>
							</tr>
							-->
						</table>
					    </form>
					</div>
					<div region="south"   style="text-align:right;" class="toolbarHeader">
						<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="uploadFileForDevAppFile();">上传文件</a>
						<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="window.close();">取消</a>
					</div>
</body>
</html>
