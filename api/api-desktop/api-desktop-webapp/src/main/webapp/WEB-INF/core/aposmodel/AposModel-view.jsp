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
  <base target="_self">
	<title></title>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/icon.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/default.css">
	<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/easyui-lang-zh_CN.js"></script>
	      <script type="text/javascript" src="<%=basePath%>js/common.js"></script>
           <script type="text/javascript" src="core/aposmodel/AposModel-js.js"></script>
           
		<script type="text/javascript">
		
		
		 var k=window.dialogArguments; 
		  if(k.par){
		  	var param=k.par;
		  	//alert(param.APOS_MODEL_ID);
			$.getJSON("queryAposModel.do",param,function(data){
				$.each(data.rows,function(idx,item){
			$("#idAposModelId").val($.trim(item.APOS_MODEL_ID));
			$("#idAposModelName").val($.trim(item.APOS_MODEL_NAME));
			$("#idRegId").val($.trim(item.REG_ID));
			$("#idRegName").val($.trim(item.REGNAME));
				});
            }); 
            
            $(function(){
			$('#idPosModeldetailview').datagrid({
				iconCls:'icon-save',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:true,
				url:'listAposModelAppInfo.do',
				queryParams:param,
				sortName: 'KEYID',
				sortOrder: 'desc',
				remoteSort: false,
				idField:'KEYID',
				pageSize:5,
				pagination:false,
				rownumbers:true,
				frozenColumns:[[
	                {field:'ck',checkbox:true},
	                {field:'FIELDS',title:'FIELDS',hidden:true},
	                {title:'KEYID',field:'KEYID',hidden:true}
				]],
				columns:[[
			{title:'应用编号',field:'APP_ID',align:'center',width:100,sortable:true},
			{title:'应用名称',field:'APP_NAME',align:'center',width:150,sortable:true},
			{title:'主应用标志',field:'MASTER_FLAG',align:'center',width:100,sortable:true},
			{title:'应用版本',field:'APP_VER',align:'center',width:100,sortable:true},
			{title:'参数模板',field:'PARAM_MODEL_ID',align:'center',width:130,formatter:function(value,rowData,rowIndex){
			             data='<a id="modelId" style="color:blue;" href="javascript:paramModelDefView(\''+rowData.PARAM_MODEL_ID+'\',\''+rowData.APP_ID+'\')\">'+rowData.PARAM_MODEL_ID+'</a>';
			             return data;
			             }}
				]]
			});
			
	
		});
         }
		
		 
		function cleardata(){
			$('#ff').form('clear');
		}
		
		

		

	</script>
</head>
<body class="easyui-layout" fit="true" >
		<div region="north"  title="应用模板详细信息" style="height: 170px">
					<div class="easyui-layout" fit="true"  >
					<div region="center"   >
							<form id="ff" method="post">
							<fieldset id="modelArea" disabled="true" style="padding:8px;width:90%;border:1px solid #46A3FF; color:#CC3300; line-height:2.0; font-size:12px;" align=center><legend>基本信息</legend>  
							<table class="formTable" style="width:100%;">
							<col  width="100px" class="leftCol"/>
							<col width="250px" >
							<col  width="100px" class="leftCol"/>
							<col width="150px" >
										<tr>
											<td><div style="text-align: right;">终端模板编号</div></td>
											<td>
												<input type="text" class="readonly" required="true" readonly  required="true"   name="APOS_MODEL_ID" id="idAposModelId" maxlength="10" />
											</td>
											
											<td><div style="text-align: right;">终端模板名称</div></td>
											<td>
												<input type="text" class="easyui-validatebox" required="true"   name="APOS_MODEL_NAME" id="idAposModelName" maxlength="30" />
											</td>
										</tr>
										<tr>
											<td>分支机构</td>
											<td>
											    <input type="hidden" name="REG_ID" id="idRegId"  readonly="readonly" maxlength="8" />
												<input type="text" class="readonly" readonly   name="REG_NAME" id="idRegName" readonly="readonly" />
												
											</td>
											<td>&nbsp;</td>
											<td>
											</td>
										</tr>
									</table>
									</fieldset>
								    </form>
                                   
						</div>
					</div>
		</div>
		<div region="center" split="true" >  
			<table id="idPosModeldetailview" ></table>
	    </div>
					<div region="south"   style="text-align:right;" class="toolbarHeader">
						<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="javascript:window.close()">关闭</a>
					</div>
</body>
</html>
