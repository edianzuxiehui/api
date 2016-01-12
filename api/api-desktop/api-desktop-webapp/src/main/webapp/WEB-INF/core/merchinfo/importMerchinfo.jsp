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
	<title>商户导入</title>
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
             var value = $("#file").val(); 
             var txtOrExcel =  value.split(".")[value.split(".").length-1].toLocaleLowerCase();
             if("xls" != txtOrExcel && "txt" != txtOrExcel){
                msgShow("导入的文件","导入文件格式必须是txt或excel","error");
                return;
             }
             if( "xlsx" == txtOrExcel){
                msgShow("导入的文件","目前系统中excel导入商户功能只支持03版本","error");
                return;
             }
			$('#ff').form('submit',{
		        url:'importMerchInfo.do?txtOrExcel='+txtOrExcel,
			    onSubmit:function(){
			        return $(this).form('validate');
			    },
			    success:function(data){
			      var myObject = eval('(' + data + ')');
			       if(myObject.status=="true"){
			       		msgShow('文件导入',myObject.message,'info'); 
						window.close();
			        }else if(myObject.status=="false"){
			        	msgShow("文件导入",myObject.message,"error");
			        	//window.close();
			        }
			    }
			    });
    }
    
	function downLoad(txtOrExcel){
	  var str = escape(escape("商户编号|商户名称|分支机构编号|商户MCC|联系人|联系电话|商户地址"));
	  var name = escape(escape("商户资料"));
	  window.open(getRootPath()+"/formatDownLoad.do?str="+str+"&txtOrExcel="+txtOrExcel+"&name="+name);
  
    }
    function downLoadEcel(){
	  window.open(getRootPath()+"/formatDownLoad.do?txtOrExcel=merch");
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
				     		<input type="file" name="formFile" id="file" size=20>&nbsp;<input type="button" name="b" value="文本格式下载" onclick="downLoad('txt')">
				     		<input type="button" name="b" value="excel格式下载" onclick="downLoadEcel()">
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

