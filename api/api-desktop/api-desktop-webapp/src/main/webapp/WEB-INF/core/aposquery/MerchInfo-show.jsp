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
	<title>查看商户</title>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/icon.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/default.css">
	<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/easyui-lang-zh_CN.js"></script>
	 <script type="text/javascript" src="<%=basePath%>js/common.js"></script>
    <script type="text/javascript" src="core/aposquery/AposQuery-js.js"></script>

		<script type="text/javascript">
		
		  var k=window.dialogArguments; 
		 
		  
		  if(k.par.MERCH_ID){
		    //initDataForMerchInfo('idMerchStatus');
		  	var param=k.par;
			$.getJSON("queryMerchInfo.do",param,function(data){
				$.each(data.rows,function(idx,item){
			$("#idMerchId").val($.trim(item.MERCH_ID));
		//	$("#idOrgId").val($.trim(item.ORG_ID));
		//	$("#idOrgName").val($.trim(item.ORG_NAME));
		//	$("#idSubId").val($.trim(item.SUB_ID));
			$("#idMerchName").val($.trim(item.MERCH_NAME));
		//	$("#idMerchAttr").val($.trim(item.MERCH_ATTR));
			$("#idMerchMcc").val($.trim(item.MERCH_MCC));
			$("#idConnecter").val($.trim(item.CONNECTER));
			$("#idOperCallno").val($.trim(item.OPER_CALLNO));
		//	$("#idFaxNo").val($.trim(item.FAX_NO));
		//	$("#idEmail").val($.trim(item.EMAIL));
		//	$("#idPostCode").val($.trim(item.POST_CODE));
		//	$("#idMerchStatus").val($.trim(item.MERCH_STATUS));
			$("#idDescTxt").val($.trim(item.DESC_TXT));
			$("#idRegId").val($.trim(item.REG_ID));
			$("#idRegName").val($.trim(item.REG_NAME)+"("+$.trim(item.REG_ID)+")");
			
				});
            }); 
            
         }
		  


	</script>
</head>
<body class="easyui-layout" fit="true">
					<div region="center"  fit="true" title="商户信息" >
						<form id="ff" method="post">
					<table class="formTable" style="width:100%;">
			            <col  width="5%" class="leftCol"/>
						<col width="10%" >
						<col  width="3%" class="leftCol"/>
						<col width="10%" >
							<tr>
								<td>商户编码</td>
								<td>
									<input type="text" class="easyui-validatebox" required="true"  style="background-color: #EEEEEE" name="MERCH_ID" id="idMerchId" maxlength="15" readonly="readonly"/>
								</td>
								
								<td>商户名称</td>
								<td>
									<input type="text" class="easyui-validatebox"  validType="maxLen[80]" required="true"  style="background-color: #EEEEEE" readonly="readonly" name="MERCH_NAME" id="idMerchName" maxlength="80" />
								</td>
							</tr>
							<tr>
							<!-- 
								<td>分店编号</td>
								<td>
									<input type="text"  required="true"   name="SUB_ID" id="idSubId" maxlength="5" readonly="readonly" style="background-color: #EEEEEE"/>
								</td>
							
								<td>商户属性</td>
								<td>
									<input type="text" class="easyui-validatebox"    name="MERCH_ATTR" id="idMerchAttr" maxlength="1" />
								</td> -->
								
								<td>分支机构</td>
								<td>
									<input type="hidden" class="easyui-validatebox"    name="REG_ID" id="idRegId" maxlength="8" />
									<input type="text" class="easyui-validatebox" style="background-color: #EEEEEE"  name="REG_NAME" id="idRegName" readonly="readonly" />
							<!--  
								<td>网络接入服务商</td>
								<td>
									<input type="hidden" id="idOrgId" type="text" readonly="readonly"  class="easyui-validatebox"  required="true"   name="ORG_ID"/>
									<input  id="idOrgName" type="text" readonly="readonly"  class="easyui-validatebox"  style="background-color: #EEEEEE"  required="true" />
								</td>-->
								
								<td>商户MCC</td>
								<td>
									<input type="text"  style="background-color: #EEEEEE" readonly="readonly"   name="MERCH_MCC" id="idMerchMcc"  />
								</td>
							</tr>
							<tr><!-- 
						        <td>商户状态</td>
								<td>
								   <select   disabled= "true"  name="MERCH_STATUS"   id="idMerchStatus" style="background-color: #EEEEEE;"  style="width: 70%"   >
									 <option value="">请选择商户状态</option>
							       </select>
								</td> -->
								 <td>联系人</td>
								<td>
									<input type="text"   style="background-color: #EEEEEE" readonly="readonly"   name="CONNECTER" id="idConnecter"  />
								</td>
					            <td>联系电话</td>
								<td>
									<input type="text" class="easyui-validatebox" style="background-color: #EEEEEE" readonly="readonly"  name="OPER_CALLNO" id="idOperCallno" />
								</td>
							</tr>
							<tr>
							  	<!-- 
								
								
								 <td>传真</td>
								<td>
									<input type="text" class="easyui-validatebox"  style="background-color: #EEEEEE" readonly="readonly" name="FAX_NO" id="idFaxNo" />
								</td>
						 
							<tr>
								<td>Email地址</td>
								<td>
									<input type="text"  style="background-color: #EEEEEE" readonly="readonly"  name="EMAIL" id="idEmail" />
								</td>
								
								<td>邮政编码</td>
								<td>
									<input type="text" style="background-color: #EEEEEE" readonly="readonly"  name="POST_CODE" id="idPostCode" />
								</td>
							</tr>-->
							
								<td>备注</td>
								<td>
									<textarea type="text" cols="25" style="background-color: #EEEEEE" readonly="readonly" name="DESC_TXT" id="idDescTxt" ></textarea>
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
