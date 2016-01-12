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
	<title>详细信息</title>
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
		  if(k.par){
		    var bk = '                    ';
		  	var param=k.par;
			$.getJSON("queryPosUploadErrorList.do",param,function(data){
				$.each(data.rows,function(idx,item){
			$("#idAposId").val($.trim(item.APOS_ID));
			$("#idOccurDate").val($.trim(item.OCCUR_DATE));
			$("#idAposDesc").val($.trim(item.APOS_DESC));
			$("#idDevPosDesc").val($.trim(item.DEV_POS_DESC));
			$("#idScallno").val($.trim(item.SCALLNO));
			$("#idPcallno").val($.trim(item.PCALLNO));
			
			//$("#idSsiteinfo").val($.trim(item.SSITEINFO));
			//$("#idPsiteinfo").val($.trim(item.PSITEINFO));
			var ssit = $.trim(item.SSITEINFO)+bk;
			$('#yys1').val('运营商:'+ssit.substr(5,5)+'\n区   域:'+ssit.substr(10,5)+'\n基   站:'+ssit.substr(15,5));
			
			var psit = $.trim(item.PSITEINFO)+bk;
			$('#yys2').val('运营商:'+psit.substr(5,5)+'\n区   域:'+psit.substr(10,5)+'\n基   站:'+psit.substr(15,5));
			
			$("#idDescTxt").val($.trim(item.DESC_TXT));
			$("#idOnlineId").val($.trim(item.ONLINE_ID));
			$("#idRegId").val($.trim(item.REG_NAME));
				});
            }); 
            
         }
		 

	</script>
</head>
<body class="easyui-layout" fit="true">
					<div region="center"  fit="true" title="错误详细信息" >
						<form id="ff" method="post">
						<table class="formTable" style="width:100%;">
				<col  width="100px" class="leftCol"/>
				<col width="200px" >
				<col  width="100px" class="leftCol"/>
				<col width="200px" >
							<tr>
								<td>应用终端号</td>
								<td>
									<input type="text" class="readonly" readonly="readonly"    name="APOS_ID" id="idAposId" size="24" />
								</td>
								<td>发生日期</td>
								<td>
									<input type="text" class="readonly" readonly="readonly"    name="OCCUR_DATE" id="idOccurDate" size="24" />
								</td>
							</tr>
							
							<tr>
								<td>原主叫号码</td>
								<td>
									<input type="text" class="readonly" readonly="readonly"    name="SCALLNO" id="idScallno" size="24" />
								</td>
								<td>本次上送主叫号码</td>
								<td>
									<input type="text" class="readonly" readonly="readonly"    name="PCALLNO" id="idPcallno" size="24" />
								</td>
							</tr>
							<tr>
								<td>原基站信息</td>
								<td>
									<textarea    rows="4" cols="30" class="readonly" readonly="readonly"  style="background-color:#EEEEEE;"  id="yys1"/></textarea>
									
								</td>
								<td>本次上送基站信息</td>
								<td>
									<textarea    rows="4" cols="30" class="readonly" readonly="readonly"  style="background-color:#EEEEEE;"   id="yys2"/></textarea>
									
								</td>
							</tr>
							<tr>
								<td>联机交易编号</td>
								<td>
									<input type="text" class="readonly" readonly="readonly"    name="ONLINE_ID" id="idOnlineId" size="24"  />
								</td>

								<td>分支机构</td>
								<td>
									<input type="text" class="readonly" readonly="readonly"    name="REG_ID" id="idRegId" size="24" />
								</td>
							</tr>
							<tr>
								<td>异常信息说明</td>
								<td colspan="3">
									<textarea    rows="2" cols="94" class="readonly" readonly="readonly" style="background-color:#EEEEEE;"  name="DESC_TXT" id="idDescTxt" size="24"/></textarea>
								</td>
							</tr>
							
							<tr>
								<td>应用终端情况描述</td>
								<td colspan="3">
									<textarea    rows="6" cols="94" class="readonly" readonly="readonly"  style="background-color:#EEEEEE;"   name="APOS_DESC" id="idAposDesc"  /></textarea>
								</td>
							</tr>
							
							<tr>
								<td>POS应用上送情况描述</td>
								<td colspan="3">
									<textarea    rows="6" cols="94" class="readonly" readonly="readonly"  style="background-color:#EEEEEE;"   name="DEV_POS_DESC" id="idDevPosDesc"/></textarea>
								</td>
							</tr>
						</table>
					    </form>
					</div>
					<div region="south"   style="text-align:right;" class="toolbarHeader">
						<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="javascript:window.close()">关闭</a>
					</div>
</body>
</html>
