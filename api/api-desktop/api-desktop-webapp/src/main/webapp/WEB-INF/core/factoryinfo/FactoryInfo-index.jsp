<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>

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
	<link rel="stylesheet" type="text/css" href="css/button.css">
	<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="js/Toolbar.js"></script>
    <script type="text/javascript" src="js/common.js"></script>
    <script type="text/javascript" src="core/factoryinfo/FactoryInfo-js.js"></script>
	<script type="text/javascript">
		function doNew(){

			
			var retValue=openDialogFrame("<%=basePath%>core/factoryinfo/FactoryInfo-add.jsp","","600","260");
			if(retValue=="true"){
				msgShow("新增","新增成功!","info");
				flashTable("idFactoryInfo");
			}
		}
		
		
		function doEdit(){
			var ids=updateValidate("idFactoryInfo");
		    if(ids){
		    	var retValue=openDialogFrame("<%=basePath%>core/factoryinfo/FactoryInfo-edit.jsp",ids,"600","260");
				if(retValue=="true"){
					msgShow("修改","修改成功!","info");
					flashTable("idFactoryInfo");
				}
		    }
			
		}
		
		
		
		function doDel(){
		    var rows = $('#idFactoryInfo').datagrid('getSelections');
		    var num = rows.length;
		    var ids = null;
		    if(num < 1){
			  msgShow('提示消息','请选择你要删除的记录!','info');
			  return;
		    }
		    for(var i = 0; i < num; i++){
				if(null == ids || i == 0){
					ids = $.trim(rows[i].KEYID);
				} else {
				    ids = $.trim(ids) + "," + $.trim(rows[i].KEYID);
				}
			}
		    var data = checkFactoryExistModel(ids);
		  if(!data.exist){
		     deleteNoteById("idFactoryInfo","delFactoryInfo.do", "");
		  }else {
		   	 if(data.message){
		   	   msgShow('提示消息',data.message,'info');
		   	 }
		  }
		 
		} 
		//验证----厂商是否型号不允许删除
		function  checkFactoryExistModel(fid){
		       var message ;
		   	   $.ajax({
			   type: "POST",
			   url: "checkFactoryExistModel.do",
			   data: "FID="+fid,  
			   async:false,     
			  success: function(data){
			     message = data;
			   } 
			  });
			  return message;
		}
		
		function queryInfo(){
		       var date=new Date();
		     $('#idFactoryInfo').datagrid("clearSelections");
			var param="flag="+date.getTime()+"&FID_S="+escape(escape($.trim($('#idFid').val())))+"&F_NAME="+escape(escape($.trim($('#idFName').val())))+"&F_ADDR="+escape(escape($.trim($('#idFAddr').val())))+"&CONNECTER="+escape(escape($.trim($('#idConnecter').val())))+"&BUS_TELE_NO="+escape(escape($.trim($('#idBusTeleNo').val())))+"&SUP_TELE_NO="+escape(escape($.trim($('#idSupTeleNo').val())))+"&FAX_NO="+escape(escape($.trim($('#idFaxNo').val())))+"&POST_CODE="+escape(escape($.trim($('#idPostCode').val())))+"&SUPPORT_INFO="+escape(escape($.trim($('#idSupportInfo').val())))+"&PLUG_NAME="+escape(escape($.trim($('#idPlugName').val())));			  
			 $('#idFactoryInfo').datagrid('options').url = "listFactoryInfo.do?"+param;// 改变它的url  
			   $("#idFactoryInfo").datagrid('load');
		}
		function cleardata(){
			$('#queryForm').form('clear');
		}
		
	</script>
</head>

<body class="easyui-layout" fit="true">
	    <div region="north" style="height: 46px;position:relative;"   split="true">  
					<form id="queryForm">
						<table class="formTable" style="width:95%;">
			    		<col  width="10%" class="leftCol"/>
						<col width="20%" >
						<col  width="10%" class="leftCol"/>
						<col width="20%" >
						<col />
						<col />
						<tr>
							<td><div style="text-align: right;">厂商编号</div></td>
							<td>
                               <input type="text" name="FID" id="idFid" maxlength="15" />
							</td>
							<td><div style="text-align: right;">厂商名称</div></td>
							<td>	<input type="text" name="F_NAME" id="idFName" maxlength="30" />
							</td>
							
						 
	                          <td colspan="2">
		                          	<div style="text-align: left;">
								     <input id="idQuery" type="button" class="btn_grid" value=" 查 询  " onclick="queryInfo()"/>
								      <input id="idReset" type="reset" class="btn_grid" value=" 重 置  "/>
								      <input id="idBack" type="button" class="btn_grid" value=" 返 回  " onclick="javascript:cleardata();backTable('idFactoryInfo','listFactoryInfo');"/>
								     </div>
								</td>
						
						</tr>
						  <!--
						  
						  <td>厂商地址</td>
								<td>
									<input type="text" name="F_ADDR" id="idFAddr" maxlength="200" />
								</td>
							<tr>
								<td>联系人</td>
								<td>
									<input type="text" name="CONNECTER" id="idConnecter" maxlength="40" />
								</td>
								<td>商务电话</td>
								<td>
									<input type="text" name="BUS_TELE_NO" id="idBusTeleNo" maxlength="20" />
								</td>
								<td>支持电话</td>
								<td>
									<input type="text" name="SUP_TELE_NO" id="idSupTeleNo" maxlength="20" />
								</td>
							</tr>
							<tr>
								<td>传真</td>
								<td>
									<input type="text" name="FAX_NO" id="idFaxNo" maxlength="20" />
								</td>
								<td>邮政编码</td>
								<td>
									<input type="text" name="POST_CODE" id="idPostCode" maxlength="6" />
								</td>
								<td>服务点信息</td>
								<td>
									<input type="text" name="SUPPORT_INFO" id="idSupportInfo" maxlength="200" />
								</td>
							</tr>
							<tr>
								<td>JAVA插件</td>
								<td>
									<input type="text" name="PLUG_NAME" id="idPlugName" maxlength="100" />
								</td>
							</tr>
						  -->
							
						</table>
					</form>
	     </div>
		<div region="center"  border="false">  
			<table id="idFactoryInfo" ></table>
	    </div>
	      <div region="south" style="height: 30px;position:relative;background:url('<%=basePath%>images/indexbg.png') repeat;" border="false">  
			<div id="toolbar"></div>
	     </div>
</body>

</html>
