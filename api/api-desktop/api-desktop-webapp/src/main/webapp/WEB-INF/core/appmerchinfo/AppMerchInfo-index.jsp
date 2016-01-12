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
	<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/Toolbar.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/common.js"></script>
    <script type="text/javascript" src="<%=basePath%>core/appmerchinfo/AppMerchInfo-js.js"></script>
        <script type="text/javascript" src="<%=basePath%>js/TabPanel.js"></script>
	<script type="text/javascript">
		function doNew(){
			var retValue=openDialogFrame("<%=basePath%>core/appmerchinfo/AppMerchInfo-add.jsp","","700","300");
			if(retValue=="true"){
				msgShow("新增","新增成功!","info");
				flashTable("idAppMerchInfo");
			}
		}
		
		
		function doEdit(){
			var ids=updateValidate("idAppMerchInfo");
		    if(ids){
		    	var retValue=openDialogFrame("<%=basePath%>core/appmerchinfo/AppMerchInfo-edit.jsp",ids,"600","300");
				if(retValue=="true"){
					msgShow("修改","修改成功!","info");
					flashTable("idAppMerchInfo");
				}
		    }
			
		}
		
		function doDel(){
		 deleteNoteById("idAppMerchInfo","delAppMerchInfo.do", "");
		}
		
		function queryInfo(){
		       var date=new Date();
			var param="flag="+date.getTime()+"&MERCH_ID="+escape(escape($.trim($('#idMerchId').val())))+"&ORIG_ID="+escape(escape($.trim($('#idOrigId').val())))+"&SUB_ID="+escape(escape($.trim($('#idSubId').val())))+"&MERCH_NAME="+escape(escape($.trim($('#idMerchname').val())))+"&MERCH_ATTR="+escape(escape($.trim($('#idMerchAttr').val())))+"&MERCH_MCC="+escape(escape($.trim($('#idMerchMcc').val())));
					alert(param);	   
			$('#idAppMerchInfo').datagrid('options').url = "listAppMerchInfo.do?"+param;// 改变它的url  
			   $("#idAppMerchInfo").datagrid('load');
		}
		function cleardata(){
			$('#queryForm').form('clear');
		}
	</script>
</head>

<body class="easyui-layout" fit="true">
	    <div region="north" style="height: 130px;position:relative;overflow-y:hidden" title="查询面板"  split="true">  
						<form id="queryForm">
						<table class="formTable" style="width:95%;">
						    <col width="50px" class="leftCol" />
                            <col width="250px" />
                            <col width="100px" class="leftCol" />
                            <col width="250px" />
                            <col width="50px" class="leftCol" />
                            <col width="250px" />
							<tr>
								<td >商户编码</td>
								<td >
									<input type="text" name="MERCH_ID" id="idMerchid" maxlength="15" />
								</td>
								<td >网络接入服务商号</td>
								<td >
									<input type="text" name="ORIG_ID" id="idOrigid" maxlength="255" />
								</td>
								<td >分店编码</td>
								<td >
									<input type="text" name="SUB_ID" id="idSubid" maxlength="5" />
								</td>
							</tr>
							<tr>
								<td >商户名称</td>
								<td >
									<input type="text" name="MERCH_NAME" id="idMerchname" maxlength="80" />
								</td>
								<td >商户属性</td>
								<td >
									<input type="text" name="MERCH_ATTR" id="idMerchattr" maxlength="1" />
								</td>
								<td >商户MCC</td>
								<td >
									<input type="text" name="MERCH_MCC" id="idMerchmcc" maxlength="4" />
								</td>
							</tr>
							
						
							<tr>
							<td colspan="6">
								<a href="javascript:void(0);" class="easyui-linkbutton"  icon="icon-search" onclick="queryInfo()">查找</a>
								<a class="easyui-linkbutton" iconCls="icon-redo" href="javascript:void(0);" onclick="cleardata()">重置</a>
							</td>
							</tr>
						</table>
				</form>
	     </div>
		<div region="center" border="false" >  
			<table id="idAppMerchInfo" ></table>
	    </div>
	      <div region="south" border="false" style="height: 32px;position:relative;background:url('<%=basePath%>images/indexbg.png') repeat;">  
			<div id="toolbar"></div>
	     </div>
</body>

</html>
