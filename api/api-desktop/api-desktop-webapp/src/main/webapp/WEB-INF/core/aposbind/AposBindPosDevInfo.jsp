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
  <base target="_self">
	<title>实体终端选择</title>
	<link rel="stylesheet" type="text/css" href="themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="themes/icon.css">
	<link rel="stylesheet" type="text/css" href="css/default.css">
	<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="js/common.js"></script>
	<script type="text/javascript">
		function queryInfo(){
		    clearSelect('idPosDevInfo');//防止页面选定一条记录后进行查询，原来的选定还存在，导致修改时选定多条
		    var date=new Date();
			var param="flag="+date.getTime()
						+"&SERIAL_NO="+$.trim($('#idSerialNo').val())+"&DEV_STATUS=0"
						+"&REG_ID="+$('#idRegId').val()
						+"&MID="+$('#idMidSelect').val();			   
			//alert(param);
			$('#idPosDevInfo').datagrid('options').url = "listPosDevInfo.do?"+param;// 改变它的url  
			$("#idPosDevInfo").datagrid('load');
		}
		function cleardata(){
			$('#queryForm').form('clear');
		}
		
		function bindSerialNo(){
			var rows = $('#idPosDevInfo').datagrid('getSelections');
			var ids;
			if(rows){
				var num = rows.length;
			    if(num < 1){
					msgShow('提示消息','请选择你要绑定的实体终端!','info');
			    } else if(num>1){
			    	msgShow('提示消息','只能选择一条记录!','info');
			    }else{
					window.returnValue=rows[0].DEV_ID+"_"+rows[0].MID; 
		 			window.close();
			    }
			}
		
		}
		
		$(function(){
		
			$('#idPosDevInfo').datagrid({
				iconCls:'icon-save',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:true,
				url:'listPosDevInfo.do',
				queryParams:{'DEV_STATUS':'0'},
				sortName: 'KEYID',
				sortOrder: 'desc',
				remoteSort: false,
				idField:'KEYID',
				pageSize:20,
				pagination:true,
				singleSelect:true,
				rownumbers:true,
				frozenColumns:[[
	                {field:'ck',checkbox:true},
	                {field:'FIELDS',title:'FIELDS',hidden:true},
	                {title:'KEYID',field:'KEYID',hidden:true}
				]],
				columns:[[
			{title:'主机型号',field:'MID',align:'center',width:130,sortable:true},
			{title:'序列号',field:'DEV_ID',align:'center',width:120,hidden:true},
			{title:'硬件序列号',field:'SERIAL_NO',align:'center',width:130,sortable:true},
			{title:'入库时间',field:'IN_DATE',align:'center',width:190,sortable:true},
			{title:'分支机构',field:'REG_ID',align:'center',width:200,sortable:true}
				]]
			});
			
			initDataForModelInfo('idFidSelect,idMidSelect');
		});
	</script>
</head>

<body class="easyui-layout" fit="true">
	    <div region="north" style="height: 80px;position:relative;"   split="true">  
			<form id="queryForm">
			   <table class="formTable" style="width:95%;">
				<col width="10%" class="leftCol"/>
				<col width="15" >
				<col  width="10%" class="leftCol"/>
				<col width="25%" >
				<col  width="10%" class="leftCol"/>
				<col width="30%" >
							<tr>

								<td>硬件序列号</td>
								<td>
									<input type="text" name="SERIAL_NO" id="idSerialNo" maxlength="30" />
								</td>
								<td>分支机构</td>
								<td>
									<input type="hidden" class="easyui-validatebox" name="REG_ID" id="idRegId" maxlength="8" />
									<input type="text" class="easyui-validatebox" style="background-color: #EEEEEE" readonly name="REG_ID" id="idRegName" size="15"/>
									<input id="idChoose" type="button" class="btn_grid" value="选择" onclick="queryReg('idRegId','idRegName')"/>
								</td>
								<td></td>	
								<td  align="center">
								</td>
							</tr>
							
							<tr>
								<td>厂商</td>
								<td>
									<select  name="FID" id="idFidSelect" maxlength="15" style="width: 148px;" onchange="changeModelByFID(this.value);">
										<option value="">请选择终端厂商</option>
									</select>
								</td>
											
								<td>主机型号</td>
								<td>
									<select type="text" name="MID" id="idMidSelect" maxlength="20" style="width: 148px;" >
										<option value="">请选择主机型号</option>
									</select>
								</td>
								<td></td>
								<td align="left">
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
	      <div region="south" style="text-align:right;" class="toolbarHeader">  
				<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="bindSerialNo()">绑定</a>
				<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="javascript:window.close()">关闭</a>
	     </div>
</body>

</html>
