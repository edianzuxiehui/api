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
	<title>修改商户</title>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/icon.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/default.css">
	<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/easyui-lang-zh_CN.js"></script>
	      <script type="text/javascript" src="<%=basePath%>js/common.js"></script>
    <script type="text/javascript" src="core/communtype/CommunType-js.js"></script>

		<script type="text/javascript">
		  var k=window.dialogArguments; 
		  if(k.par){
		  	var param=k.par;
			$.getJSON("queryCommunType.do",param,function(data){
				$.each(data.rows,function(idx,item){
			$("#idSysId").val($.trim(item.SYS_ID));
			$("#idCommunType").val($.trim(item.COMMUN_TYPE));
			$("#idCommunDetail").val($.trim(item.COMMUN_DETAIL));
				});
            }); 
            
         }
		  

		function cleardata(){
			$('#ff').form('clear');
		}
		
		function addCommunType(){
			$('#ff').form('submit',{
		        url:'updateCommunType.do',
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
				<col  width="150px" class="leftCol"/>
				<col width="250px" >
				<input type="hidden"  name="SYS_ID" id="idSysId" />
							<tr>
								<td>通讯方式</td>
								<td>
									<input type="text" class="easyui-validatebox"    name="COMMUN_TYPE" id="idCommunType" maxlength="100" />
								</td>
							</tr>
							<tr>		
								<td>通讯配置</td>
								<td>
									<input type="text" class="easyui-validatebox"    name="COMMUN_DETAIL" id="idCommunDetail" maxlength="100" />
								</td>
							</tr>
						</table>
					    </form>
					</div>
					<div region="south"   style="text-align:right;" class="toolbarHeader">
						<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="addCommunType()">确认</a>
						<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="javascript:window.close()">取消</a>
					</div>
</body>
</html>
