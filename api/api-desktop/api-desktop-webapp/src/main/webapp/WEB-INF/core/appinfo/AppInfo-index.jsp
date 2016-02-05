<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.landi.tms.base.impl.IDtoImpl"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
IDtoImpl  person =   (IDtoImpl)request.getSession().getAttribute("person");
  String  operId = person.getAsString("OPER_ID");
  
%>
   <%if("00010000".equals(operId)){  //超级管理员%>
	<input id="isSuperAdmin" type="hidden"  value="true"/>
	<%} else {%>
    <input id="isSuperAdmin" type="hidden"  value="false"/>
	<%} %>
                    
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
    <script type="text/javascript" src="core/appinfo/AppInfo-js.js"></script>
    <script type="text/javascript" src="core/appverinfo/AppVerInfo-js.js"></script>
	<script type="text/javascript">
		function doNew(){
			var retValue=openDialogFrame("<%=basePath%>core/appinfo/AppInfo-add.jsp","","350","240");
			if(retValue=="true"){
				msgShow("新增","新增成功!","info");
				flashTable("idAppInfo");
			}else if(retValue=="false"){
			   msgShow("新增","新增失败!","error");
			}
		}
		
		
		
		function doEdit(){
				var ids=updateValidate("idAppInfo");
			    if(ids){
			       //验证是否有修改应用的权限，下级是不可以修改上级的共享的应用的
		           if(checkModifyAppinfoAuthority()){
				    	var retValue=openDialogFrame("<%=basePath%>core/appinfo/AppInfo-edit.jsp",ids,"350","240");
						if(retValue=="true"){
							msgShow("修改","修改成功!","info");
							flashTable("idAppInfo");
						}else if(retValue=="false"){
					       msgShow("修改","修改失败!","error");
					    }
				   }else{
				        msgShow("没有权限","没有权限修改上级的应用","error");
				     
				   }
			    }
		}
		
		function doDel(){
		    var rows = $('#idAppInfo').datagrid('getSelections');
		    var num = rows.length;
		   	if(num < 1){
			  msgShow('提示消息','请选择你要删除的记录!','info');
			  return;
		    }
		   if(check_Multi_Application(rows)){
			     if(checkModifyAppinfoAuthority()){
			     deleteNoteByIdForAppInfo("idAppInfo","delAppInfo.do", "");
			         
			     }else {
			         msgShow("没有权限","没有权限删除上级的共享应用","error");
			     }
		   }else {
		     msgShow("多应用管理器","多应用管理器不能删除","error");
		   }
		}
		
 function deleteNoteByIdForAppInfo(dataTableId, requestURL, confirmMessage){
	
	if (null == confirmMessage || typeof(confirmMessage) == "undefined" || "" == confirmMessage) {
		confirmMessage = "确定删除所选记录?";
		
	}
	var rows = $('#'+dataTableId).datagrid('getSelections');
	var num = rows.length;
	var ids = null;
	var fields=null;
	if(num < 1){
		msgShow('提示消息','请选择你要删除的记录!','info');
	}else{
		$.messager.confirm('确认', confirmMessage, function(r){
			if (r) {
			//$('#idAppVerInfo').datagrid({columns:"",title:"",toolbar:""});
			for(var i = 0; i < num; i++){
				if(null == ids || i == 0){
					ids = $.trim(rows[i].KEYID);
				} else {
				    ids = $.trim(ids) + "," + $.trim(rows[i].KEYID);
				}
			}
				fields=rows[0].FIELDS;
		  	var param=buildDelParamModule(ids,fields);
		 
			$.getJSON(requestURL,param,function(data){
			if (null != data && null != data.status && "" != data.status&&data.status=="true") {
				msgShow('提示消息',data.message,'info');
				flashTable(dataTableId);
			} else {
				if(data.message==null||data.message==""){
					msgShow('提示消息','删除失败！','error');
				}else{
					//alert(111);
					msgShow('提示消息',data.message,'error');
				}
			}
				clearSelect(dataTableId);
			});
	     }
	});
  }
}
		
		
		function queryInfo(){
		       var date=new Date();
		          $('#idAppInfo').datagrid("clearSelections");
			var param="flag="+date.getTime()+"&APPID="+escape(escape($.trim($('#idAppId').val())))+"&APP_NAME="+escape(escape($.trim($('#idAppName').val())))+"&REG_ID="+escape(escape($.trim($('#idRegId').val())))+"&APP_STATUS="+escape(escape($.trim($('#idAppStatus').val())))+"&INPUT_DATE="+escape(escape($.trim($('#idInputDate').val())))+"&SHARE_FLAG="+escape(escape($.trim($('#idShareFlag').val())))+"&DESC_TXT="+escape(escape($.trim($('#idDescTxt').val())));			
			   $('#idAppInfo').datagrid('options').url = "listAppInfo.do?"+param;// 改变它的url  
			   $("#idAppInfo").datagrid('load');
		}
		function cleardata(){
			$('#queryForm').form('clear');
		}
	</script>
</head>

<body class="easyui-layout" fit="true">
	    <div region="north" style="height: 70%;position:relative;"  split="true">  
	                <input type="hidden" id="currentAppInfo" name="currentAppInfo" value="" />
					<form id="queryForm">
						<table class="formTable" style="width:80%;">
						<!--  
		                <col  width="10%" class="leftCol"/>
						<col width="15%" >
						<col  width="10%" class="leftCol"/>
						<col width="15%" >
			           <col  width="10%" class="leftCol"/>
						<col width="30%" >
						<col  width="10%" />
						<col  width="10%" />
						-->
						  <col  width="8%" class="leftCol"/>
						<col width="30%" >
						<col  width="8%" class="leftCol"/>
						<col  width="8%" />
							<tr>
								<td>应用编号</td>
								<td>
									<input type="text" name="APP_ID" id="idAppId" maxlength="8" />
								</td>
								<td>应用名称</td>
								<td>
									<input type="text" name="APP_NAME" id="idAppName" maxlength="30" />
								</td>
							
						
							</tr>
							<tr>
							
								
							<td>分支机构</td>
								<td>
									<input type="hidden" class="easyui-validatebox"    name="REG_ID" id="idRegId" maxlength="8" />
									<input type="text" class="easyui-validatebox" style="background-color: #EEEEEE"  name="REG_NAME" id="idRegName" readonly="readonly" />
									<input id="idChoose" type="button" class="btn_grid" value="选择" onclick="queryReg('idRegId','idRegName')"/>
									<input id="idClear" type="button" class="btn_grid" value="清空" onclick="clearReg('idRegId','idRegName')"/>
								</td>
								<td></td>
							   <td>
							     <input id="idQuery" type="button" class="btn_grid" value="   查 询   " onclick="queryInfo()"/>
							     <input id="idReset" type="button" class="btn_grid" value="   重  置  " onclick="cleardata()"/>
							   </td>
	
							
							</tr>
							<!-- 
							<tr>
								<td>应用状态</td>
								<td>
									<input type="text" name="APP_STATUS" id="idAppStatus" maxlength="1" />
								</td>
								<td>注册日期</td>
								<td>
									<input type="text" name="INPUT_DATE" id="idInputDate" maxlength="17" />
								</td>
								<td>共享标志</td>
								<td>
									<input type="text" name="SHARE_FLAG" id="idShareFlag" maxlength="1" />
								</td>
							</tr>
							<tr>
								<td>备注</td>
								<td>
									<input type="text" name="DESC_TXT" id="idDescTxt" maxlength="100" />
								</td>
							</tr>
						 -->
						</table>
					</form>
	     </div>
        
	     <div region="west" split="true" style="width:540px;padding:2px;" >
	      <table id="idAppInfo" ></table>
	    </div>
		<div region="center" split="true" style="padding:2px;"  border="false"> 
			<div style="height:100%;border:1px #8DB2E3 solid;overflow:auto;">
				<table id="idAppVerInfo" ></table>
			</div>	
	    </div>	    
	      <div region="south" border="false" style="height: 30px;position:relative;background:url('<%=basePath%>images/indexbg.png') repeat;">  
			<div id="toolbar"></div>
	     </div>
</body>

</html>
