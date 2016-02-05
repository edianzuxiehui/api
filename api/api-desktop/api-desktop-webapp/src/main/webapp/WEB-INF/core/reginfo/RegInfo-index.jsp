<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="dev.trade.common.xml.XMLConfig"%>
<%@page import="com.landi.tms.util.XMLFactory"%>
<%@page import="com.landi.tms.util.GlobalConstants"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
XMLConfig xc = XMLFactory.getXMLHelper(GlobalConstants.XML_CONFIG_KEY);
String rootRegId = xc.getString("/config/rootRegId");
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
    <script type="text/javascript" src="js/Toolbar.js"></script>
    <script type="text/javascript" src="js/common.js"></script>
    <script type="text/javascript" src="core/reginfo/RegInfo-js.js"></script>
	<script type="text/javascript">
		function doNew(){
			var retValue=openDialogFrame("<%=basePath%>core/reginfo/RegInfo-add.jsp","","400","230");
			if(retValue=="true"){
				msgShow("新增","新增成功!","info");
				flashTable("idRegInfo");
			}else if(retValue=="false"){
			   msgShow("新增","新增失败!","error");
			}
		}
		
		
		function doEdit(){
			var ids=updateValidate("idRegInfo");
		    if(ids){
		    	var row = $('#idRegInfo').datagrid('getSelections');
		    	if(row[0].REG_ID!='<%=rootRegId%>'){
		    		var retValue=openDialogFrame("<%=basePath%>core/reginfo/RegInfo-edit.jsp",ids,"400","230");
					if(retValue=="true"){
						msgShow("修改","修改成功!","info");
						flashTable("idRegInfo");
					}else if(retValue=="false"){
				       msgShow("修改","修改失败!","error");
				    }
		    	}else{
		    		msgShow("修改","最上层机构不允许修改!","error");
		    	}
		    	
		    }
			
		}
		
		function doDel(){
		 deleteNoteById("idRegInfo","delRegInfo.do", "");
		}
		function queryInfo(){
		clearSelect('idRegInfo');
		       var date=new Date();
			var param="flag="+date.getTime()+"&REGID="+escape(escape($.trim($('#idRegId').val())))+"&REG_NAME="+escape(escape($.trim($('#idRegName').val())))+"&UP_REG_ID="+escape(escape($.trim($('#idUpRegId').val())))+"&UP_REG_NAME="+escape(escape($.trim($('#idUpRegName').val())));
			   $('#idRegInfo').datagrid('options').url = "listRegInfo.do?"+param;// 改变它的url  
			   $("#idRegInfo").datagrid('load');
		}
		function cleardata(){
			$('#queryForm').form('clear');
		}
		
	</script>
</head>

<body class="easyui-layout" fit="true">
	    <div region="north" style="height: 50px;position:relative;"   split="true">  
					<form id="queryForm">
						<table class="formTable" style="width:95%;">
				<col width="10%" class="leftCol"/>
				<col width="15%" >
				<col  width="10%" class="leftCol"/>
				<col width="15%" >
				<col  width="10%" class="leftCol"/>
				<col width="22%" >
				<col width="20%">

							<tr>
								<td>分支机构编号</td>
								<td>
									<input type="text" size="15" name="REG_ID" id="idRegId" maxlength="8" />
								</td>
								<td>分支机构名称</td>
								<td>
									<input type="text" size="15" name="REG_NAME" id="idRegName" maxlength="30" />
								</td>
								<td>上级分支机构</td>
								<td>
									<input type="hidden" name="UP_REG_ID" id="idUpRegId" maxlength="8" />
									<input type="text" size="15" name="UP_REG_NAME" id="idUpRegName" readonly class="readonly" />
									<input id="idChoose" type="button" class="btn_grid" value="选择" onclick="queryReg('idUpRegId','idUpRegName');"/>
								</td>
								<td>
								<input id="idQuery" type="button" class="btn_grid" value=" 查询 " onclick="queryInfo()"/>
									<input id="idReset" type="button" class="btn_grid" value=" 重置 " onclick="cleardata()"/>
								</td>
							</tr>
							<!--  
							<tr>
							<td colspan="6">
								<a href="javascript:void(0)" class="easyui-linkbutton"  icon="icon-search" onclick="queryInfo()">查找</a>
								<a class="easyui-linkbutton" iconCls="icon-redo" href="javascript:void(0);" onclick="cleardata()">重置</a>
							</td>
							</tr>
							-->
						</table>
					</form>
	     </div>
		<div region="center"  border="false">  
			<table id="idRegInfo" ></table>
	    </div>
	    <!-- 
			<div region="south" border="false" style="height: 30px;position:relative;background:url('<%=basePath%>images/indexbg.png') repeat;">  
			<div id="toolbar"></div>
	     </div>
	     -->
</body>

</html>
