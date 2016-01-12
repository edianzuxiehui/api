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
	<title>应用终端移机</title>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/icon.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/default.css">
	<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/easyui-lang-zh_CN.js"></script>
	      <script type="text/javascript" src="<%=basePath%>js/common.js"></script>

		<script type="text/javascript">
		  var k=window.dialogArguments; 
		  
		  
        setModuleNameAndId(); 
		
		function cleardata(){
			$('#ff').form('clear');
		}
		
		function addAppInfo(){
			$('#ff').form('submit',{
		        url:'updateAposInfoForTel.do',
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
								<td>应用终端编号</td>
								<td>
									<span id="aposId"></span><input type="hidden" name="APOS_ID" id="idAposId">
								</td>
							</tr>
							<tr>
								<td>主应用商户</td>
								<td>
									<span id="merch"></span>
								</td>
							</tr>
							<tr>
								<td>主应用终端号</td>
								<td>
									<span id="terminalId"></span>
								</td>
							</tr>
							<tr>
								<td>主叫号码</td>
								<td>
									<input type="text" class="easyui-validatebox"    name="TELE_NO" id="idTeleNo" maxlength="20" style="width: 45%"/>
								</td>
							</tr>
							<tr>
								<td>基站信息</td>
								<td>
									<input type="text" class="easyui-validatebox"    name="SITEINFO" id="idSiteinfo" maxlength="20"  style="width: 45%"/>
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
<script type="text/javascript">
		if(k.par){
		  	var param=k.par;
			$("#aposId").html($.trim(param.APOS_ID));
			var merchName="商户不存在";
			var mName=$.trim(param.MERCH_NAME);
			if(mName&&mName!="null"&&mName!=null){
				merchName=mName;
			}
			$("#merch").html($.trim(param.MERCH_ID)+"("+merchName+")");
			$("#terminalId").html($.trim(param.TERMINAL_ID));
			$("#idAposId").val($.trim(param.APOS_ID));		
			$.getJSON(getRootPath()+"/queryOneAposInfo.do","APOS_ID="+param.APOS_ID,function(data){
					//alert(data.TELE_NO);
					// var myObject = eval('(' + data + ')');
					 //alert(myObject.TELE_NO);
					 //alert(myObject.SITEINFO);
					 
					$("#idTeleNo").val($.trim(data.TELE_NO));
					$("#idSiteinfo").val($.trim(data.SITEINFO));
            }); 
            
         }
</script>
</html>
