<%@ page language="java" pageEncoding="UTF-8"%>
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
	<title>导入参数项文件</title>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/icon.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/default.css">
	<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/common.js"></script>
	<script type="text/javascript">
    setModuleNameAndId();
    function onConfirm(){
			$('#ff').form('submit',{
		        url:'importParamItem.do',
			    onSubmit:function(){
			    	showProcess(true,"导入参数项","参数文件导入中...");
			    	var ret = $(this).form('validate');
			    	if(!ret){
			    		showProcess(false);//防止进度条一直存在
			    	}
			        return ret;
			    },
			    success:function(data){
			    	showProcess(false);
			      var myObject = eval('(' + data + ')');
			       if(myObject.status=="true"){
			    	   $.messager.alert('文件导入',myObject.message,'info',function(){self.close();}); 
			        }else if(myObject.status=="false"){
			        	msgShow("文件导入",myObject.message,"error");
			        	//window.close();
			        }
			    }
			    });
    }
    
	function downLoad(){
        var str = "参数组别(值：如主控参数,其他参数等),参数编码(若系统自动编码该字段放空),参数名称,参数类型(值：数字或文本),参数长度,默认值,参数描述"
    	                +"\r\n例子：其他参数,,参数1,文本,3,201,公共支付交易类参数项"
    	                +"\r\n      其他参数,,菜单名称1,文本,14,委托,公共支付交易类参数项";
    	//location.href="../../export.jsp?str="+encodeURIComponent(str);
    	
  	  str = escape(escape(str));
	  var name = escape(escape("参数项"));
	  var txtOrExcel ='txt';
	  window.open(getRootPath()+"/formatDownLoad.do?str="+str+"&txtOrExcel="+txtOrExcel+"&name="+name);
    }
</SCRIPT>
</head>
<body class="easyui-layout" fit="true">
		<div region="center"  fit="true" title="" >
			<form id="ff" method="post" enctype="multipart/form-data" >
				<table class="formTable" style="width:100%;">
		            <tr align="left">
						<td width="15%" align="right" class="blue" >导入文件:</td>
						<td width="85%">
				     		<input type="file" name="formFile" id="file" size=20>&nbsp;<input type="button" name="b" value="导入格式下载" onclick="downLoad()">
					    </td>
					</tr>
				</table>
			</form>
		</div>
		<div region="south"   style="text-align:right;" class="toolbarHeader">
			<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="onConfirm();">导入</a>
			<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="javascript:window.close()">取消</a>
		</div>
</body>
</html>
