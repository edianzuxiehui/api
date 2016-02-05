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
    <script type="text/javascript" src="core/merchinfo/MerchInfo-js.js"></script>
	<script type="text/javascript">
		function doNew(){
			var retValue=openDialogFrame("<%=basePath%>core/merchinfo/MerchInfo-add.jsp","","600","260");
			if(retValue=="true"){
				msgShow("新增","新增成功!","info");
				flashTable("idMerchInfo");
			}else if(retValue=="false"){
			   msgShow("新增","新增失败!","error");
			}
		}
		
		
		function doEdit(){
			var ids=updateValidate("idMerchInfo");
		    if(ids){
		    	var retValue=openDialogFrame("<%=basePath%>core/merchinfo/MerchInfo-edit.jsp",ids,"600","260");
				if(retValue=="true"){
					msgShow("修改","修改成功!","info");
					flashTable("idMerchInfo");
				}else if(retValue=="false"){
			       msgShow("修改","修改失败!","error");
			    }
		    }
			
		}
		
		function doDel(){
		 deleteNoteById("idMerchInfo","delMerchInfo.do", "");
		}
		
		function queryInfo(){
		       var date=new Date();
		    $('#idMerchInfo').datagrid("clearSelections");
		  	var param="flag="+date.getTime()+"&MERCHID="+escape(escape($.trim($('#idMerchId').val())))+"&ORG_ID="+escape(escape($.trim($('#idOrgId').val())))+"&SUB_ID="+escape(escape($.trim($('#idSubId').val())))+"&MERCH_NAME="+escape(escape($.trim($('#idMerchName').val())))+"&MERCH_ATTR="+escape(escape($.trim($('#idMerchAttr').val())))+"&MERCH_MCC="+escape(escape($.trim($('#idMerchMcc').val())))+"&CONNECTER="+escape(escape($.trim($('#idConnecter').val())))+"&OPER_CALLNO="+escape(escape($.trim($('#idOperCallno').val())))+"&FAX_NO="+escape(escape($.trim($('#idFaxNo').val())))+"&EMAIL="+escape(escape($.trim($('#idEmail').val())))+"&POST_CODE="+escape(escape($.trim($('#idPostCode').val())))+"&MERCH_STATUS="+escape(escape($.trim($('#idMerchStatus').val())))+"&DESC_TXT="+escape(escape($.trim($('#idDescTxt').val())))+"&REG_ID="+escape(escape($.trim($('#idRegId').val())))+"&REG_ENTIRE_ID="+escape(escape($.trim($('#idRegEntireId').val())));			
			//var param="flag="+date.getTime()+"&MERCH_ID="+escape(escape($.trim($('#idMerchId').val())))+"&ORG_ID="+escape(escape($.trim($('#idOrgId').val())))+"&SUB_ID="+escape(escape($.trim($('#idSubId').val())))+"&MERCH_NAME="+escape(escape($.trim($('#idMerchName').val())))+"&MERCH_ATTR="+escape(escape($.trim($('#idMerchAttr').val())))+"&MERCH_MCC="+escape(escape($.trim($('#idMerchMcc').val())))+"&CONNECTER="+escape(escape($.trim($('#idConnecter').val())))+"&OPER_CALLNO="+escape(escape($.trim($('#idOperCallno').val())))+"&FAX_NO="+escape(escape($.trim($('#idFaxNo').val())))+"&EMAIL="+escape(escape($.trim($('#idEmail').val())))+"&POST_CODE="+escape(escape($.trim($('#idPostCode').val())))+"&MERCH_STATUS="+escape(escape($.trim($('#idMerchStatus').val())))+"&DESC_TXT="+escape(escape($.trim($('#idDescTxt').val())))+"&REG_ID="+escape(escape($.trim($('#idRegId').val())));			
			   $('#idMerchInfo').datagrid('options').url = "listMerchInfo.do?"+param;// 改变它的url  
			   $("#idMerchInfo").datagrid('load');
			   $("#excelRegId").val($("#idRegId").val());
			   $("#excelMerchId").val($("#idMerchId").val());
			   $("#excelMerchName").val($("#idMerchName").val());
		}
		function cleardata(){
			$('#queryForm').form('clear');
		}
		
		 /*
		 输入参数为表头title,查询的sql语句的Id,页面参数,queryInfo,sql取值的
		 */
		 function doExport(title,sqlId,queryInfo,sqlcols,filename){
		 	var title=escape(escape("商户编号,商户名称/分店,分支机构,商户MCC ,联系人,联系电话,商户地址,备注"));
			var sqlId="listMerchInfo";
			
			var queryInfo="{'merch_Id':'"+$("#idMerchId").val()+"','merchName':'"+$("#idMerchName").val()+"','regId':'"+$("#excelRegId").val()+"'}";
			var sqlcols="MERCH_ID,MERCH_NAME,REG_NAME,MERCH_MCC,CONNECTER,OPER_CALLNO,MERCH_ADDR,DESC_TXT";
			var filename="merchInfo";
			
			
			  var param={'title':title,'sqlId':sqlId,'queryInfo':queryInfo,'sqlcols':sqlcols,'filename':filename};
			  var param="title="+title+"&sqlId="+sqlId+"&queryInfo="+queryInfo+"&sqlcols="+sqlcols+"&filename="+filename
			  window.open(getRootPath()+"/exportMerchInfo.do?"+param);
		 
		 }
		 //批量导入商户
		 function doImp(){
		      var returnValue= openDialogFrame(getRootPath()+'/core/merchinfo/importMerchinfo.jsp','',580,90);
		      $('#idMerchInfo').datagrid('load');
		 }
	</script>
</head>

<body class="easyui-layout" fit="true" >
	    <div region="north" style="height: 70%;position:relative;" split="true">  
					<form id="queryForm">
						<table class="formTable" style="width:85%;">
						<input type="hidden" name="REG_ID" id="excelRegId"/>
						<input type="hidden" name="MERCH_ID" id="excelMerchId"/>
						<input type="hidden" name="MERCH_NAME" id="excelMerchName"/>
			            <col  width="8%" class="leftCol"/>
						<col width="30%" >
						<col  width="8%" class="leftCol"/>
						<col  width="8%" />
							<tr>
								<td>商户编号</td>
								<td>
									<input type="text" name="MERCH_ID" id="idMerchId" maxlength="15" />
								</td>
							    <td>商户名称</td>
								<td>
									<input type="text" name="MERCH_NAME" id="idMerchName" maxlength="80" />
								</td>
							
								</tr>
								<tr>
							
								<td>分支机构</td>
								<td>
									<input type="hidden" class="easyui-validatebox"    name="REG_ID" id="idRegId" maxlength="8" />
									<input type="hidden" class="easyui-validatebox"    name="REG_ENTIRE_ID" id="idRegEntireId" maxlength="8" />
									<input type="text" class="easyui-validatebox" style="background-color: #EEEEEE"  name="REG_NAME" id="idRegName" readonly="readonly" />
									<input id="idChoose" type="button" class="btn_grid" value=" 选 择 " onclick="queryReg('idRegId','idRegName','idRegEntireId')"/>
									<input id="idClear" type="button"  class="btn_grid" value=" 清 空 " onclick="clearReg('idRegId','idRegName','idRegEntireId')"/>
								</td>
								<td>
								  <td colspan="2">
											 <div style="text-align: center;">
										     <input id="idQuery" type="button" class="btn_grid" value=" 查 询 " onclick="queryInfo()"/>
										     <input id="idReset" type="button" class="btn_grid" value=" 重 置 " onclick="cleardata()"/>
										     </div>
							       </td>
								
								
								
								<td></td>
								<td></td>
	                           
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
		<div region="center"  border="false">  
			<table id="idMerchInfo" ></table>
	    </div>
	      <div region="south" border="false" style="height: 30px;position:relative;background:url('<%=basePath%>images/indexbg.png') repeat;">  
			<div id="toolbar"></div>
	     </div>
</body>

</html>
