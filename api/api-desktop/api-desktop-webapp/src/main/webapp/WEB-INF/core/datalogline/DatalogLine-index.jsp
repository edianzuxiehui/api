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
    <script type="text/javascript" src="js/Toolbar.js"></script>
    <script type="text/javascript" src="js/common.js"></script>
    <script type="text/javascript" src="core/datalogline/DatalogLine-js.js"></script>
    
	<script type="text/javascript">
		function doNew(){
			var retValue=openDialogFrame("<%=basePath%>core/datalogline/DatalogLine-add.jsp","","600","300");
			if(retValue=="true"){
				msgShow("新增","新增成功!","info");
				flashTable("idDatalogLine");
			}
		}
		
		
		function doEdit(){
			var ids=updateValidate("idDatalogLine");
		    if(ids){
		    	var retValue=openDialogFrame("<%=basePath%>core/datalogline/DatalogLine-edit.jsp",ids,"600","300");
				if(retValue=="true"){
					msgShow("修改","修改成功!","info");
					flashTable("idDatalogLine");
				}
		    }
			
		}
		
		function doDel(){
		 deleteNoteById("idDatalogLine","delDatalogLine.do", "");
		}
		
		function queryInfo(){
		   if($('#idBeginDate').val()!="" && $('#idEndDate').val()!="" && $('#idBeginDate').val()>$('#idEndDate').val()){
				msgShow("提示","选择的开始时间大于结束时间，请重新选择!","info");
				return;
			}
		
		       var date=new Date();
			var param="flag="+date.getTime()+"&beginDate="+escape(escape($.trim($('#idBeginDate').val())))+"&endDate="+escape(escape($.trim($('#idEndDate').val())))+"&REG_ID="+escape(escape($.trim($('#idRegId').val())));		
			   $('#idDatalogLine').datagrid('options').url = "listDatalogLine.do?"+param;// 改变它的url  
			   $("#idDatalogLine").datagrid('load');
		}
		function cleardata(){
			$('#queryForm').form('clear');
		}
	</script>
</head>

<body class="easyui-layout" fit="true">

	    <div region="north" style="height: 70%;position:relative;" split="true">  
					<form id="queryForm">
						<table class="formTable" style="width:80%;">
						<col  width="8%" class="leftCol"/>
				        <col width="27%" >
				        <col  width="8%" class="leftCol"/>
				        <col width="8%" >
				      
							<tr>
								<td>开始时间</td>
								<td>
								   <input name="beginDate" id="idBeginDate" class="Wdate" type="text"  onClick="WdatePicker()" readonly="reandonly" >
								</td>
								<td>结束时间</td>
								<td>
									<input name="endDate" id="idEndDate" validType='dateNotEarlier[$("#idBeginDate").val()]' class="Wdate" type="text"  onClick="WdatePicker()" readonly="reandonly" >
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
								<td>
									<input id="idQuery" type="button" class="btn_grid" value=" 查 询 " onclick="queryInfo()"/>
								</td>
							    <td>
							     <input id="idReset" type="button" class="btn_grid" value=" 重 置 " onclick="cleardata()"/>
							   </td>
							
							</tr>
						</table>
					</form>
	     </div>
		<div region="center" border="false" >  
			<table id="idDatalogLine" ></table>
	    </div>
	     
</body>
<script type="text/javascript" src="<%=basePath%>js/DatePicker/WdatePicker.js"></script>

</html>
