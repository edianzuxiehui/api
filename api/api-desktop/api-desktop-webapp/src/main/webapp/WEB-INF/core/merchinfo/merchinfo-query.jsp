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
	<title>选择商户</title>
	<link rel="stylesheet" type="text/css" href="themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="themes/icon.css">
	<link rel="stylesheet" type="text/css" href="css/default.css">
	<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="js/common.js"></script>
    <script type="text/javascript" src="core/merchinfo/MerchInfo-js.js"></script>
	<script type="text/javascript">
		function queryMerch(){
			var rows = $('#idMerchInfo').datagrid('getSelections');
		 	if(rows.length==0) {
		 		msgShow("提示","请选择商户","info");
		 	}else if(rows.length>1) {
		 		msgShow("提示","只能选择一个商户","info");
		 	}else{
		 		var o = new Object();
		 		o.merchId = rows[0].MERCH_ID;
		 		o.merchName = rows[0].MERCH_NAME;
		 		window.returnValue=o; 
		 		window.close();
		 	}
		}
		
		
		function queryInfo(){
		       var date=new Date();
		    $('#idMerchInfo').datagrid("clearSelections");
		  	var param="flag="+date.getTime()+"&MERCHID="+escape(escape($.trim($('#idMerchId').val())))+"&MERCH_NAME="+escape(escape($.trim($('#idMerchName').val())))+"&MERCH_MCC="+escape(escape($.trim($('#idMerchMcc').val())))+"&REG_ID="+escape(escape($.trim($('#idRegId').val())));			
			//var param="flag="+date.getTime()+"&MERCH_ID="+escape(escape($.trim($('#idMerchId').val())))+"&ORG_ID="+escape(escape($.trim($('#idOrgId').val())))+"&SUB_ID="+escape(escape($.trim($('#idSubId').val())))+"&MERCH_NAME="+escape(escape($.trim($('#idMerchName').val())))+"&MERCH_ATTR="+escape(escape($.trim($('#idMerchAttr').val())))+"&MERCH_MCC="+escape(escape($.trim($('#idMerchMcc').val())))+"&CONNECTER="+escape(escape($.trim($('#idConnecter').val())))+"&OPER_CALLNO="+escape(escape($.trim($('#idOperCallno').val())))+"&FAX_NO="+escape(escape($.trim($('#idFaxNo').val())))+"&EMAIL="+escape(escape($.trim($('#idEmail').val())))+"&POST_CODE="+escape(escape($.trim($('#idPostCode').val())))+"&MERCH_STATUS="+escape(escape($.trim($('#idMerchStatus').val())))+"&DESC_TXT="+escape(escape($.trim($('#idDescTxt').val())))+"&REG_ID="+escape(escape($.trim($('#idRegId').val())));			
			   $('#idMerchInfo').datagrid('options').url = "listMerchInfo.do?"+param;// 改变它的url  
			   $("#idMerchInfo").datagrid('load');
		}
	</script>
</head>

<body class="easyui-layout" fit="true" >
	    <div region="north" style="height: 95px;position:relative;" title="查询面板"  split="true">  
					<form id="queryForm">
						<table class="formTable" style="width:95%;">
			            <col  width="5%" class="leftCol"/>
						<col width="5%" >
			           <col  width="10%" class="leftCol"/>
						<col width="20%" >
						<col  width="5%" />
						<col  width="5%" />

							<tr>
								<td>商户编号</td>
								<td>
									<input type="text" name="MERCH_ID" id="idMerchId" maxlength="15" />
								</td>
								<!--  
							   <td>网络接入服务商</td>
								<td>
									<select type="text" name="ORG_ID" id="idOrgId" maxlength="255"  >
									  <option value="">请选择网络接入服务商</option>
									</select>
								</td>
								-->
								</tr>
								<tr>
								
								 <td>商户名称</td>
								<td>
									<input type="text" name="MERCH_NAME" id="idMerchName" maxlength="80" />
								</td>
								
								<td>分支机构</td>
								<td>
									<input type="hidden" class="easyui-validatebox"    name="REG_ID" id="idRegId" maxlength="8" />
									<input type="text" class="easyui-validatebox" style="background-color: #EEEEEE"  name="REG_NAME" id="idRegName" readonly="readonly" />
									<input id="idChoose" type="button" class="btn_grid" value="选择" onclick="queryReg('idRegId','idRegName')"/>
									<input id="idClear" type="button" class="btn_grid" value="清空" onclick="clearReg('idRegId','idRegName')"/>
								</td>
								
	                             <td>
							     <input id="idQuery" type="button" class="btn_grid" value=" 查 询 " onclick="queryInfo()"/>
								</td>
							   <td>
							     <input id="idReset" type="button" class="btn_grid" value=" 重 置 " onclick="cleardata()"/>
							   </td>
							</tr>
							
							<!-- 
							<tr>
								<td>分店编码</td>
								<td>
									<input type="text" name="SUB_ID" id="idSubId" maxlength="5" />
								</td>
								
								
								<td>商户属性</td>
								<td>
									<input type="text" name="MERCH_ATTR" id="idMerchAttr" maxlength="1" />
								</td>
								<td>商户MCC</td>
								<td>
									<input type="text" name="MERCH_MCC" id="idMerchMcc" maxlength="4" />
								</td>
							</tr>
							<tr>
								<td>联系人</td>
								<td>
									<input type="text" name="CONNECTER" id="idConnecter" maxlength="40" />
								</td>
								<td>联系电话</td>
								<td>
									<input type="text" name="OPER_CALLNO" id="idOperCallno" maxlength="20" />
								</td>
								<td>传真</td>
								<td>
									<input type="text" name="FAX_NO" id="idFaxNo" maxlength="20" />
								</td>
							</tr>
							<tr>
								<td>Email地址</td>
								<td>
									<input type="text" name="EMAIL" id="idEmail" maxlength="80" />
								</td>
								<td>邮政编码</td>
								<td>
									<input type="text" name="POST_CODE" id="idPostCode" maxlength="6" />
								</td>
								<td>商户状态</td>
								<td>
									<input type="text" name="MERCH_STATUS" id="idMerchStatus" maxlength="5" />
								</td>
							</tr>
							<tr>
								<td>备注</td>
								<td>
									<input type="text" name="DESC_TXT" id="idDescTxt" maxlength="100" />
								</td>
							</tr>
							<tr>
							</tr>
							 -->
						</table>
					</form>
	     </div>
		<div region="center"  >  
			<table id="idMerchInfo" ></table>
	    </div>
	    <div region="south"   style="text-align:right;" class="toolbarHeader">
						<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="queryMerch();">确认</a>
						<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="javascript:window.close()">取消</a>
		</div>
</body>


</html>
