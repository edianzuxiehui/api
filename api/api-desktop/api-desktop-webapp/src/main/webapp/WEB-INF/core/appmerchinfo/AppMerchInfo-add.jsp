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
	<title>新增商户</title>
	<link rel="stylesheet" type="text/css" href="themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="themes/icon.css">
	<link rel="stylesheet" type="text/css" href="css/default.css">
	<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/easyui-lang-zh_CN.js"></script>
	 <script type="text/javascript" src="<%=basePath%>js/common.js"></script>

		<script type="text/javascript">
		function cleardata(){
			$('#ff').form('clear');
		}
		
		function addAppMerchInfo(){
			$('#ff').form('submit',{
		        url:'addAppMerchInfo.do',
			    onSubmit:function(){
			        return $(this).form('validate');
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
					<div region="center"  title="信息录入" >
						<form id="ff" method="post">
						
						<table class="formTable"  style="width:100%">
						    <col width="50px" class="leftCol" />
                            <col width="250px" />
							<tr>
								<td>商户编码</td>
								<td >
									<input type="text" class="easyui-validatebox" required="true"   name="MERCH_ID" id="idMerchId" maxlength="15" size="25"/>
								</td>
							</tr>
							<tr>
								<td >网络接入服务商号</td>
								<td >
									<input type="text" class="easyui-validatebox" required="true"   name="ORIG_ID" id="idOrigId" maxlength="255" />
								</td>
							</tr>
							<tr>
								<td >分店编码</td>
								<td >
									<input type="text" class="easyui-validatebox" required="true"   name="SUB_ID" id="idSubId" maxlength="5" />
								</td>
							</tr>
							<tr>
								<td >商户名称</td>
								<td >
									<input type="text" class="easyui-validatebox"   name="MERCH_NAME" id="idMerchName" maxlength="80" />
								</td>
							</tr>
						</table>
					    </form>
					</div>
					<div region="south"   style="text-align:right;" class="toolbarHeader">
						<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0);" onclick="addAppMerchInfo()">Ok</a>
						<a class="easyui-linkbutton" iconCls="icon-redo" href="javascript:void(0);" onclick="cleardata()">reset</a>
						<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0);" onclick="javascript:window.close()">Cancel</a>
					</div>
</body>
</html>
