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
	<title>导入厂家参数文件</title>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/icon.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/default.css">
	<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/common.js"></script>
	<script type="text/javascript">
	/*$(function(){//一定要在文档加载完后进行，不然alert($("#idRegId").val())为undefined
		  var k=window.dialogArguments;////k.par为这种形式：var param={'paramModelId':paramModelId,'regId':regId};
		  if(k.par){
		  	var param=k.par;//alert(param.paramModelId);alert(param.regId);
			$("#idParamModelId").val(param.paramModelId);
			$("#idRegId").val(param.regId);//alert($("#idRegId").val());
          }else{
          	self.close();
          }
        });
    function onConfirm(){
      	var form1=$("#ff")[0];
    	if($("#file").val()==""){
    		alert("请选择参数文件");
    		return;
    	}
    	var str="importParamModelDetail.do?regId="+$("#idRegId").val()+"&paramModelId="+$("#idParamModelId").val();
    	//alert(str);
    	form1.action=str;//不能少，不然参数不能传递
     	form1.submit();
     	};
     	*/
    function onConfirm(){
     		var k=window.dialogArguments;
			$('#ff').form('submit',{
		        url:'importParamModelDetail.do'+"?"+k.par,//k.par为这种形式：var param = 'paramModelId='+paramModelId+'&regId='+regId;
			    onSubmit:function(){
			    	showProcess(true,"导入参数模板明细","参数模板明细文件导入中...");
			    	var ret = $(this).form('validate');
			    	if(!ret){
			    		showProcess(false);//防止进度条一直存在
			    	}
			        return ret;
			    },
			    success:function(data){
			    	showProcess(false);
			      var myObject = eval('(' + data + ')');
			       if(myObject.status=="true"){//alert(myObject.message);
			       		//msgShow("文件导入",myObject.message,"info"); 
			    	   $.messager.alert('文件导入',myObject.message,'info',function(){self.close();}); 
			       }else if(myObject.status=="false"){
			        	msgShow("文件导入",myObject.message,"error");
			        	//window.close();
			        }			       
			    }
			    });
    }
    
	function downLoad(){
	    var str = "8字节参数标签+参数值,如\r\n"
    	                +"010000450\r\n"
    	                +"010000490003\r\n"
    	                +"01000012059188888888\r\n";
    	//location.href="../../export.jsp?str="+encodeURIComponent(str);
	  	  str = escape(escape(str));
		  var name = escape(escape("参数模板"));
		  var txtOrExcel ='txt';
		  window.open(getRootPath()+"/formatDownLoad.do?str="+str+"&txtOrExcel="+txtOrExcel+"&name="+name);
	}
</SCRIPT>
</head>
<body class="easyui-layout" fit="true">
		<div region="center"  fit="true" title="" >
			<form id="ff" method="post" action="importParamModelDetail.do" enctype="multipart/form-data" >
			<!-- <inpu type="hidden" name="paramModelId" id="idParamModelId" value="11">
			<inpu type="hidden" name="regId" id="idRegId" value="222"> -->
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
