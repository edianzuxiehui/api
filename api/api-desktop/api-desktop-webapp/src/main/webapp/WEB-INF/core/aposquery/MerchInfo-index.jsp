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
	<title></title>
	<link rel="stylesheet" type="text/css" href="themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="themes/icon.css">
	<link rel="stylesheet" type="text/css" href="css/default.css">
	<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="js/common.js"></script>
    <script type="text/javascript" src="core/aposquery/AposQuery-js.js"></script>
	<script type="text/javascript">
		
		
		
	
		function queryInfo(){
		       var date=new Date();
		    $('#idMerchInfo').datagrid("clearSelections");
		  	var param="flag="+date.getTime()+"&MERCHID="+escape(escape($.trim($('#idMerchId').val())))+"&MERCH_NAME="+escape(escape($.trim($('#idMerchName').val())))+"&MERCH_ATTR="+escape(escape($.trim($('#idMerchAttr').val())))+"&MERCH_MCC="+escape(escape($.trim($('#idMerchMcc').val())))+"&CONNECTER="+escape(escape($.trim($('#idConnecter').val())))+"&OPER_CALLNO="+escape(escape($.trim($('#idOperCallno').val())))+"&FAX_NO="+escape(escape($.trim($('#idFaxNo').val())))+"&EMAIL="+escape(escape($.trim($('#idEmail').val())))+"&POST_CODE="+escape(escape($.trim($('#idPostCode').val())))+"&MERCH_STATUS="+escape(escape($.trim($('#idMerchStatus').val())))+"&DESC_TXT="+escape(escape($.trim($('#idDescTxt').val())))+"&REG_ID="+escape(escape($.trim($('#idRegId').val())));			
			   $('#idMerchInfo').datagrid('options').url = "listMerchInfo.do?"+param;// 改变它的url  
			   $("#idMerchInfo").datagrid('load');
		}
		function cleardata(){
			$('#queryForm').form('clear');
		}
	</script>
</head>

<body class="easyui-layout" fit="true" >
	    <div region="north" style="height: 95px;position:relative;" title="查询面板"  split="true">  
					<form id="queryForm">
						<table class="formTable" style="width:95%;">
			            <col  width="5%" class="leftCol"/>
						<col width="20%" >
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
								</td> -->
								 <td>商户名称</td>
								<td>
									<input type="text" name="MERCH_NAME" id="idMerchName" maxlength="80" />
								</td>
								</tr>
								<tr>
								
								
								
								<td>分支机构</td>
								<td>
									<input type="hidden" class="easyui-validatebox"    name="REG_ID" id="idRegId" maxlength="8" />
									<input  type="hidden" class="easyui-validatebox"    name="REG_ENTIRE_ID" id="idRegEntireId" />
									<input type="text" class="" class="easyui-validatebox" style="background-color: #EEEEEE"  name="REG_NAME" id="idRegName" readonly="readonly" />
									<input id="idChoose" type="button" class="btn_grid" value="选择" onclick="queryReg('idRegId','idRegName','idRegEntireId')"/>
									<input id="idClear" type="button" class="btn_grid" value="清空" onclick="clearReg('idRegId','idRegName','idRegEntireId')"/>
									
								</td>
								
	                             <td colspan="2">
	                             	<div style="text-align: center;">
							     	<input id="idQuery" type="button" class="btn_grid" value=" 查 询 " onclick="queryInfo()"/>       
							     	<input id="idReset" type="button" class="btn_grid" value=" 重 置 " onclick="cleardata()"/>
							     	</div>
							   </td>
							</tr>
							
					
						</table>
					</form>
	     </div>
		<div region="center"  border="false">  
			<table id="idMerchInfo" ></table>
	    </div>
	     <div region="south" border="false" style="height: 40px;position:relative;background:url('<%=basePath%>images/indexbg.png') repeat;">  
			  <div style="text-align: right;">
				   <a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="confirm()">确定</a>
				   <a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="javascript:window.close()">取消</a>
			   </div>
	     </div>
	   
</body>

</html>
