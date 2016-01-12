<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="com.landi.tms.util.GlobalConstants" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<meta http-equiv="X-UA-Compatible" content="IE=8">
<html>
<head>
  <base href="<%=basePath%>">
	<title>实体终端管理</title>
	<link rel="stylesheet" type="text/css" href="themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="themes/icon.css">
	<link rel="stylesheet" type="text/css" href="css/default.css">
	<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="js/Toolbar.js"></script>
    <script type="text/javascript" src="js/common.js"></script>
    <script type="text/javascript" src="core/posdevinfo/PosDevInfo-js.js"></script>
	<script type="text/javascript">
		function doNew(){
			var retValue=openDialogFrame("<%=basePath%>core/posdevinfo/PosDevInfo-add.jsp","","400","300");
			if(retValue=="true"){
				msgShow("新增","新增成功!","info");
				flashTable("idPosDevInfo");
			}else if(retValue=="false"){
			   msgShow("新增","新增失败!","error");
			}
		}
		
		
		function doEdit(){
			var ids=updateValidate("idPosDevInfo");
		    if(ids){
		    	var retValue=openDialogFrame("<%=basePath%>core/posdevinfo/PosDevInfo-edit.jsp",ids,"400","300");
				if(retValue=="true"){
					msgShow("修改","修改成功!","info");
					flashTable("idPosDevInfo");
				}else if(retValue=="false"){
			       msgShow("修改","修改失败!","error");
			    }
		    }
			
		}
		
		function doDel(){
		 deleteNoteById("idPosDevInfo","delPosDevInfo.do", "");
		}
		
		function queryInfo(){
		    clearSelect('idPosDevInfo');//防止页面选定一条记录后进行查询，原来的选定还存在，导致修改时选定多条
		    var date=new Date();
			var param="flag="+date.getTime()+"&MID="+$('#idMidSelect').val()
						+"&SERIAL_NO="+$.trim($('#idSerialNo').val())+"&DEV_STATUS="+$('#idDevStatus').val()
						+"&REG_ENTIRE_ID="+$('#idRegEntireId').val()
						+"&DESC_TXT="+escape(escape($.trim($('#idDescTxt').val())));			   
			//alert(param);
			$('#idPosDevInfo').datagrid('options').url = "listPosDevInfo.do?"+param;// 改变它的url  
			$("#idPosDevInfo").datagrid('load');
		}
		function cleardata(){
			$('#queryForm').form('clear');
			$('#idChangeStatus').val('');//不添加，默认会置为null
			$('#idDevStatus').val('');
			
		}
	function doImp(){//导入物理终端文件
	  	var returnValue= openDialogFrame(getRootPath()+'/core/posdevinfo/importPosDevInfo.jsp','',450,20);
		$('#idPosDevInfo').datagrid('load');
 	 }	
	</script>
</head>

<body class="easyui-layout" fit="true">
	    <div region="north" style="height: 80px;position:relative;" title=""  split="true">  
			<form id="queryForm">
			   <table class="formTable" style="width:95%;">
				<col width="8%" class="leftCol"/>
				<col width="25" >
				<col  width="8%" class="leftCol"/>
				<col width="15%" >

				<col  width="8%" class="leftCol"/>
				<col width="15%" >
				<col  width="8%" class="leftCol"/>
				<col width="15%" >
							<tr>
								<td>厂商</td>
								<td>
									<select  name="FID" id="idFidSelect" maxlength="15" style="width: 70%" onchange="changeModelByFID(this.value);">
									   <option value="">请选择终端厂商</option>
									</select>
								</td>
								
								<td>主机型号</td>
								<td>
									<select type="text" name="MID" id="idMidSelect" maxlength="20" style="width:100%" >
									 <option value="">请选择主机型号</option>
									</select>
								</td>
								<td>硬件序列号</td>
								<td>
									<input type="text" name="SERIAL_NO" id="idSerialNo" maxlength="30" />
								</td>
								<td>实体终端状态</td>
								<td>
								<select name="DEV_STATUS" id="idDevStatus" style="width: 150">
				                    <option value="">全部</option>
				                    <option value="<%=GlobalConstants.POS_STATUS_NO_INIT  %>" selected>未初始化</option>
				                    <option value="<%=GlobalConstants.POS_STATUS_WILL_INIT  %>" >待初始化</option>
				                    <option value="<%=GlobalConstants.POS_STATUS_HAD_INIT %>" >已初始化</option>
				                    <option value="<%=GlobalConstants.POS_STATUS_CONFIRM %>" >待确认</option>
			                  </select>
                     <!-- <input type="text" name="DEV_STATUS" id="idDevStatus" maxlength="1" /> -->
								</td>
							</tr>
						<!-- 	<tr>
								<td>实体终端编号</td>
								<td>
									<input type="text" name="DEV_ID" id="idDevId" maxlength="12" />
								</td>
								<td>数据来源</td>
								<td>
									<input type="text" name="DATA_SOURCE" id="idDataSource" maxlength="1" />
								</td> 
								<td>入库时间</td>
								<td>
									<input type="text" name="IN_DATE" id="idInDate" maxlength="19" />
								</td> 
								<td>备注</td>
								<td>
									<input type="text" name="DESC_TXT" id="idDescTxt" maxlength="100" />
								</td>
							</tr>
							-->
							<tr>
								<td>分支机构</td>
								<td>
									<input type="hidden" class="easyui-validatebox" name="REG_ID" id="idRegId" maxlength="8" />
									<input type="hidden" name="REG_ENTIRE_ID" id="idRegEntireId"/>
									<input type="text" class="easyui-validatebox" style="background-color: #EEEEEE" readonly name="REG_ID" id="idRegName" size="15"/>
									<input id="idChoose" type="button" class="btn_grid" value="选择" onclick="queryReg('idRegId','idRegName','idRegEntireId')"/>
									</td>
								<td colspan="4" align="center"></td>
								<td colspan="2" align="center">
							     <input id="idQuery" type="button" class="btn_grid" value=" 查 询 " onclick="queryInfo()"/>
							     <input id="idReset" type="button" class="btn_grid" value=" 重 置 " onclick="cleardata()"/>
							</td>
							</tr>
						</table>
					</form>
	     </div>
		<div region="center"  >  
			<table id="idPosDevInfo" ></table>
	    </div>
	      <div region="south" style="height: 30px;position:relative;background:url('<%=basePath%>images/indexbg.png') repeat;">  
			<div id="toolbar"></div>
	     </div>
</body>

</html>
