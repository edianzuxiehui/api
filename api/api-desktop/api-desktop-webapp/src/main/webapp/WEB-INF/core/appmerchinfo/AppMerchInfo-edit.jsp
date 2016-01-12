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
		  var k=window.dialogArguments; 
		  if(k.par){
		  	var param=k.par;
			$.getJSON("queryAppMerchInfo.do",param,function(data){
				$.each(data.rows,function(idx,item){
				$("#idMerchId").val($.trim(item.MERCH_ID));
				$("#idOrigId").val($.trim(item.ORIG_ID));
				$("#idSubId").val($.trim(item.SUB_ID));
				$("#idMerchName").val($.trim(item.MERCH_NAME));
				$("#idMerchAttr").val($.trim(item.MERCH_ATTR));
				$("#idMerchMcc").val($.trim(item.MERCH_MCC));
				$("#idTranChannel").val($.trim(item.TRAN_CHANNEL));
				});
            }); 
            
         }
         
		function cleardata(){
			$('#ff').form('clear');
		}
		
		function addAppMerchInfo(){
			$('#ff').form('submit',{
		        url:'updateAppMerchInfo.do',
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
					<div region="center"  title="信息录入" class="divbg">
						<form id="ff" method="post">
						<table class="boxTable"  style="width:100%">
							<tr>
								<td class="boxColEven">商户编码</td>
								<td class="boxColOdd">
									<input type="text" class="easyui-validatebox" required="true" style="width:80%;"  name="MERCH_ID" id="idMerchId" maxlength="15" />
								</td>
							</tr>
							<tr>
								<td class="boxColEven">网络接入服务商号</td>
								<td class="boxColOdd">
									<input type="text" class="easyui-validatebox" required="true" style="width:80%;"  name="ORIG_ID" id="idOrigId" maxlength="255" />
								</td>
							</tr>
							<tr>
								<td class="boxColEven">分店编码</td>
								<td class="boxColOdd">
									<input type="text" class="easyui-validatebox" required="true" style="width:80%;"  name="SUB_ID" id="idSubId" maxlength="5" />
								</td>
							</tr>
							<tr>
								<td class="boxColEven">商户名称</td>
								<td class="boxColOdd">
									<input type="text" class="easyui-validatebox"   name="MERCH_NAME" id="idMerchName" maxlength="80" />
								</td>
							</tr>
							<tr>
								<td class="boxColEven">商户名称</td>
								<td class="boxColOdd">
									<input type="text" class="easyui-validatebox"  style="width:90%;"  name="MERCH_NAME" id="idMerchName" maxlength="80" />
								</td>
							</tr>
							<tr>
								<td class="boxColEven">商户属性</td>
								<td class="boxColOdd">
									<input type="text" class="easyui-validatebox"  style="width:90%;"  name="MERCH_ATTR" id="idMerchAttr" maxlength="1" />
								</td>
							</tr>
							<tr>
								<td class="boxColEven">商户MCC</td>
								<td class="boxColOdd">
									<input type="text" class="easyui-validatebox"  style="width:90%;"  name="MERCH_MCC" id="idMerchMcc" maxlength="4" />
								</td>
							</tr>
							<tr>
								<td class="boxColEven">转接渠道</td>
								<td class="boxColOdd">
									<input type="text" class="easyui-validatebox"  style="width:90%;"  name="TRAN_CHANNEL" id="idTranChannel" maxlength="8" />
								</td>
							</tr>
							
						</table>
					    </form>
					</div>
					<div region="south"   style="text-align:right;" class="toolbarHeader">
						<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="addAppMerchInfo()">Ok</a>
						<a class="easyui-linkbutton" iconCls="icon-redo" href="javascript:void(0)" onclick="cleardata()">reset</a>
						<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0);" onclick="javascript:window.close()">Cancel</a>
					</div>
</body>
</html>
