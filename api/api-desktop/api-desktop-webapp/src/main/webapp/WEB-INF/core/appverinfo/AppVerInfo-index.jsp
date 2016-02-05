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
   <!--  <script type="text/javascript" src="js/Toolbar.js"></script> -->
    <script type="text/javascript" src="js/common.js"></script>
    <script type="text/javascript" src="core/appverinfo/AppVerInfo-js.js"></script>
	<script type="text/javascript">
		function doNew(){
			var retValue=openDialogFrame("<%=basePath%>core/appverinfo/AppVerInfo-add.jsp",k,"350","200");//k在AppVerInfo-js.js里面
			if(retValue=="true"){
				msgShow("新增","新增成功!","info");
				flashTable("idAppVerInfo");
			}else if(retValue=="false"){
			   msgShow("新增","新增失败!","error");
			}
		}
		
		
		function doEdit(){
			var ids=updateValidate("idAppVerInfo");
		    if(ids){
		       if(checkModifyAppverinfoAuthority()){
			    	var retValue=openDialogFrame("<%=basePath%>core/appverinfo/AppVerInfo-edit.jsp",ids,"350","200");
					if(retValue=="true"){
						msgShow("修改","修改成功!","info");
						flashTable("idAppVerInfo");
					}else if(retValue=="false"){
				       msgShow("修改","修改失败!","error");
				    }
			   }else {
			        msgShow("没有权修改","没有权利修改别的机构的版本!","error");  
			   
			   }
		    }
			
		}
		
		function doDel(){
		   var rows = $('#idAppVerInfo').datagrid('getSelections');
		   var num = rows.length;
	       if(num < 1){
		     msgShow('提示消息','请选择你要删除的记录!','info');
		     return ;
		   }
		  if(checkModifyAppverinfoAuthority()){
		    deleteNoteById("idAppVerInfo","delAppVerInfo.do", "");
		  }else {
		      msgShow("没有权限","没有权限删除其他机构的应用版本!","error");  
		  }  
		}
		/*
		function queryInfo(){
		       var date=new Date();
			var param="flag="+date.getTime()+"&APP_ID="+escape(escape($.trim($('#idAppId').val())))+"&APP_VER="+escape(escape($.trim($('#idAppVer').val())))+"&REG_ID="+escape(escape($.trim($('#idRegId').val())))+"&DESC_TXT="+escape(escape($.trim($('#idDescTxt').val())));			  
			$('#idAppVerInfo').datagrid('options').url = "listAppVerInfo.do?"+param;// 改变它的url  
			   $("#idAppVerInfo").datagrid('load');
		}
		function cleardata(){
			$('#queryForm').form('clear');
		}*/
	</script>
</head>

<body class="easyui-layout" fit="true">
<!--  
							    	

   <!--
	    <div region="north" style="height: 100px;position:relative;" title="查询面板"  split="true">  
					<form id="queryForm">
						<table class="formTable" style="width:95%;">
				<col  width="50px" class="leftCol"/>
				<col width="250px" >

				<col  width="50px" class="leftCol"/>
				<col width="250px" >

				<col  width="50px" class="leftCol"/>
				<col width="250px" >

							<tr>
								<td>应用编号</td>
								<td>
									<input type="text" name="APP_ID" id="idAppId" maxlength="8" />
								</td>
								<td>应用版本</td>
								<td>
									<input type="text" name="APP_VER" id="idAppVer" maxlength="30" />
								</td>
								<td>分支机构编号</td>
								<td>
									<input type="text" name="REG_ID" id="idRegId" maxlength="8" />
								</td>
							</tr>
							<tr>
								<td>备注</td>
								<td>
									<input type="text" name="DESC_TXT" id="idDescTxt" maxlength="100" />
								</td>
							</tr>
						
							<tr>
							<td colspan="6">
								<a href="javascript:void(0)" class="easyui-linkbutton"  icon="icon-search" onclick="queryInfo()">查找</a>
								<a class="easyui-linkbutton" iconCls="icon-redo" href="javascript:void(0);" onclick="cleardata()">重置</a>
							</td>
							</tr>
						</table>
					</form>
	     </div>
	     
	       -->
		<div region="center"  border="false">  
			<table id="idAppVerInfo" ></table>
	    </div>
	      <div region="south" style="height: 40px;position:relative;background:url('<%=basePath%>images/indexbg.png') repeat;">  
			<div id="toolbar" align="center">
				<input type="button"  value="增加" class="btn_grid"  onclick="doNew();"  style="width:80; height:30" />
				<input type="button"  value="修改" class="btn_grid" onclick="doEdit();"  style="width:80; height:30"/>
				<input type="button" value="删除" class="btn_grid" onclick="doDel();"   style="width:80; height:30"/> 

			   </div>
	     </div>
</body>

</html>
