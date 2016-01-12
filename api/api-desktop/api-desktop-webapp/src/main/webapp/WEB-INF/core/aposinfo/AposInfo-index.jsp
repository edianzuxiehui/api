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
	<title>应用终端生成</title>
	<link rel="stylesheet" type="text/css" href="themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="themes/icon.css">
	<link rel="stylesheet" type="text/css" href="css/default.css">
	<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="js/Toolbar.js"></script>
    <script type="text/javascript" src="js/common.js"></script>
    <script type="text/javascript" src="core/aposinfo/AposInfo-js.js"></script>
	<script type="text/javascript">
		function doNew(){
			var retValue=openDialogFrame("<%=basePath%>core/aposinfo/AposInfo-add.jsp","","960","550");
			if(retValue=='true'){
				//msgShow("新增","新增成功!","info");
				flashTable("idAposInfo");
			}else if(retValue=="false"){
			   	//msgShow("新增","新增失败!","error");
			}else if(retValue=="model") {//由模板生成应用终端返回
				msgShow("提示消息","成功添加应用终端","info");
			    flashTable("idAposInfo");
			}
		}
		
		
		function doEdit(){
			var ids=updateValidate("idAposInfo");
		    if(ids){
		    	//---- 当前查询不会出现已绑定的列表数据，故将代码注释
		    	//增加记录修改权限检查
		    	//var rowData = $('#idAposInfo').datagrid('getSelected');
		    	//如果该应用终端与实体终端已做绑定，不可修改
		    	//if(rowData.MID!=null && rowData.DEV_ID!=null) {
		    	//	msgShow("修改","该应用终端已绑定，不可修改","info");
		    	//	return false;
		    	//}
		    	//----
		    	
		    	var retValue=openDialogFrame("<%=basePath%>core/aposinfo/AposInfo-edit.jsp",ids,"920","550");
				if(retValue=="true"){
					//msgShow("修改","修改成功!","info");
					flashTable("idAposInfo");
				}else if(retValue=="false"){
			    	//msgShow("修改","修改失败!","error");
			    }
		    }
			
		}
		
		function doDel(){
			//---- 当前查询不会出现已绑定的列表数据，故将代码注释
			//删除权限检查，已绑定的应用终端不可删除
			//var aposList = "";
			//var rows = $('#idAposInfo').datagrid('getSelections');
			//if(rows!=null) {
			//	for(var i=0; i<rows.length; i++) {
			//		if(rows[i].MID!=null && rows[i].DEV_ID!=null) {//找到已绑定的应用终端，记录其应用终端号
			//			aposList += ","+rows[i].APOS_ID;
			//		}
			//	}
			//}
			//if(aposList!="") {
			//	msgShow("删除","应用终端["+aposList.substring(1)+"]已绑定，不可删除","info");
			//	return false;
			//}
			//----
			
			deleteNoteById("idAposInfo","delAposInfo.do", "");
		}
		
		function queryInfo(){
			var date=new Date();
			var param="flag="+date.getTime();
			param += "&APOS_ID="+escape(escape($.trim($('#idAposId').val())));
			param += "&MERCH_ID="+escape(escape($.trim($('#idMerchId').val())));
			param += "&REG_ID="+escape(escape($.trim($('#idRegId').val())));
			param += "&TERMINAL_ID="+escape(escape($.trim($('#idTerminalId').val())));
			param += "&DATA_SOURCE="+escape(escape($('#idDataSource').val()));
			$('#idAposInfo').datagrid('options').url = "listAposInfo.do?"+param;// 改变它的url
			//flashTable("idAposInfo");
			$("#idAposInfo").datagrid('load');
		}
		function cleardata(){
			$('#queryForm').form('clear');
			$('#idDataSource').val('');
		}
	</script>
</head>

<body class="easyui-layout" fit="true">
	    <div region="north" style="height: 75px;position:relative;" split="true">  
					<form id="queryForm">
						<table class="formTable" style="width:95%;">
				<col  width="70px" class="leftCol"/>
				<col width="100px" >

				<col  width="70px" class="leftCol"/>
				<col width="200px" >

				<col  width="60px" class="leftCol"/>
				<col width="250px" >

							<tr>
								<td>应用终端号</td>
								<td>
									<input type="text" name="APOS_ID" id="idAposId" maxlength="10" />
								</td>
								
								
								<td>分支机构</td>
								<td>
									<input type="hidden" name="REG_ID" id="idRegId" value=""/>
									<input type="hidden" name="REG_ENTIRE_ID" id="idRegEntireId" value=""/>
									<input type="text" name="REG_NAME" id="idRegName" readonly class="readonly" />
									<input type="button" class="btn_grid" value="选择" onclick="queryReg('idRegId','idRegName','idRegEntireId');"/>
									<input type="button" class="btn_grid" value="清空" onclick="clearReg('idRegId','idRegName','idRegEntireId');"/>
								</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								
							</tr>
							<tr>
								<td>主应用商户编号</td>
								<td>
									<input type="text" name="MERCH_ID" id="idMerchId" maxlength="15" />
								</td>
								<td>主应用终端</td>
								<td>
									<input type="text" name="TERMINAL_ID" id="idTerminalId" maxlength="8" />
								</td>
								<td colspan="2">
									<div style="text-align:left;">
										<input type="button" class="btn_grid" onclick="queryInfo()" style="height:24px;" value=" 查 询 " />      
										<input type="button" class="btn_grid" onclick="cleardata()" style="height:24px;" value=" 重 置 " />
									</div>
								</td>
							</tr>
						</table>
					</form>
	     </div>
		<div region="center"  border="false">  
			<table id="idAposInfo" ></table>
	    </div>
	      <div region="south" border="false" style="height: 30px;position:relative;background:url('<%=basePath%>images/indexbg.png') repeat;">  
			<div id="toolbar"></div>
	     </div>
</body>

</html>
