<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="dev.trade.common.xml.XMLConfig"%>
<%@page import="com.landi.tms.util.XMLFactory"%>
<%@page import="com.landi.tms.util.GlobalConstants"%>
<%@page import="com.landi.tms.base.IDto"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
IDto person = (IDto) request.getSession().getAttribute("person");
String regId = person.getAsString("REG_ID");
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
    <script type="text/javascript" src="core/subreglinenum/SubRegLineNum-js.js"></script>
	<script type="text/javascript">
		function doNew(){
			if(<%=regId%> == <%=rootRegId %>){
				var maxnum=$("#idSubRegLineNum").datagrid('getData').MAXNUM;
				var retValue=openDialogFrame("<%=basePath%>core/subreglinenum/SubRegLineNum-add.jsp?maxnum="+maxnum,"","400","150");
				if(retValue=="true"){
					msgShow("新增","新增成功!","info");
					flashTable("idSubRegLineNum");
				}else if(retValue=="false"){
				   msgShow("新增","新增失败!","error");
				}
			}else{
				msgShow("提示","只有总公司登录人员可以操作!","error");
			}
		}
		
		
		function doEdit(){
		
			if(<%=regId%> == <%=rootRegId %>){
				var ids=updateValidate("idSubRegLineNum");
			    if(ids){
			    	var retValue=openDialogFrame("<%=basePath%>core/subreglinenum/SubRegLineNum-edit.jsp",ids,"400","150");
					if(retValue=="true"){
						msgShow("修改","修改成功!","info");
						flashTable("idSubRegLineNum");
					}else if(retValue=="false"){
				       msgShow("修改","修改失败!","error");
				    }
			    }
			}else{
				msgShow("提示","只有总公司登录人员可以操作!","error");
			}
			
			
		}
		
		function doDel(){
			if(<%=regId%> == <%=rootRegId %>){
				deleteNoteById("idSubRegLineNum","delSubRegLineNum.do", "");
			}else{
				msgShow("提示","只有总公司登录人员可以操作!","error");
			}
		 
		}
		
		function queryInfo(){
		 	   clearSelect('idSubRegLineNum');//防止页面选定一条记录后进行查询，原来的选定还存在，导致修改时选定多条
		       var date=new Date();
			var param="flag="+date.getTime()+"&REG_ID="+escape(escape($.trim($('#idRegId').val())));			   
			$('#idSubRegLineNum').datagrid('options').url = "listSubRegLineNum.do?"+param;// 改变它的url  
			   $("#idSubRegLineNum").datagrid('load');
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
				<col  width="100px" class="leftCol"/>
				<col width="250px" >
				<col width="250px" >

							<tr>
								<td>分支机构</td>
								<td>
									<input type="hidden" class="easyui-validatebox"    name="REG_ID" id="idRegId" maxlength="8" />
									<input type="text" class="easyui-validatebox" style="background-color: #EEEEEE"  name="REG_NAME" id="idRegName" readonly="readonly" />
									<input id="idChoose" type="button" class="btn_grid" value="选择" onclick="queryReg('idRegId','idRegName')"/>
									<input id="idClear" type="button" class="btn_grid" value="清空" onclick="clearReg('idRegId','idRegName')"/>
								</td>
								<td>
								<input id="idQuery" type="button" class="btn_grid" value=" 查 询 " onclick="queryInfo()"/>
							     <input id="idReset" type="button" class="btn_grid" value=" 重 置 " onclick="cleardata()"/>
								</td>
							</tr>
						</table>
					</form>
	     </div>
		<div region="center"  border="false">  
			<table id="idSubRegLineNum" ></table>
	    </div>
	      <div region="south" border="false" style="height: 30px;position:relative;background:url('<%=basePath%>images/indexbg.png') repeat;">  
			<div id="toolbar"></div>
	     </div>
</body>

</html>
