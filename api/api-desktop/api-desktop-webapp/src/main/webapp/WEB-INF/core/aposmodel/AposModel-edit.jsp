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
	<title>修改应用终端模板</title>
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
		  
		  setModuleNameAndId("ffdetail");
		  setModuleNameAndId();
		  if(k.par){
		  	var param=k.par;
		  	//alert(param);
			$.getJSON("queryAposModel.do",param,function(data){
				$.each(data.rows,function(idx,item){
			$("#idAposModelId").val($.trim(item.APOS_MODEL_ID));
			$("#idAposmodel").val($.trim(item.APOS_MODEL_ID));
			$("#idAposModelName").val($.trim(item.APOS_MODEL_NAME));
			$("#idRegId").val($.trim(item.REG_ID));
			$("#idRegName").val($.trim(item.REGNAME));
			$("#idRegEntirId").val($.trim(item.REG_ENTIRE_ID));
			$("#sidRegId").val($.trim(item.REG_ID));
			$("#sidRegEntirId").val($.trim(item.REG_ENTIRE_ID));
				});
            });
            
                   
            }
            /*
            alert(document.getElementById("idAposModelName"));
            alert($("#idAposModelName").val());
            $("#idvposModelMod").attr('disabled',true);
            */
            
            
            $(function(){
             $("#idvposModelMod").attr('disabled',true);
            initData('idAppId,idMid');
            $('#idParamModeldetailedit').datagrid({
				iconCls:'icon-save',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:true,
				url:'listAposModelAppInfo.do?'+param,
				sortName: 'KEYID',
				sortOrder: 'desc',
				remoteSort: false,
				idField:'KEYID',
				pageSize:10,
				pagination:false,
				rownumbers:true,
				frozenColumns:[[
	                {field:'ck',checkbox:true},
	                {field:'FIELDS',title:'FIELDS',hidden:true},
	                {title:'KEYID',field:'KEYID',hidden:true}
				]],
				columns:[[
			{title:'应用编号',field:'APP_ID',align:'center',width:100,sortable:true},
			{title:'应用名称',field:'APP_NAME',align:'center',width:100,sortable:true},
			{title:'主应用标志',field:'MASTER_FLAG',align:'center',width:100,sortable:true},
			{title:'应用版本',field:'APP_VER',align:'center',width:100,sortable:true},
			{title:'参数模板',field:'PARAM_MODEL_ID',align:'center',width:100,formatter:function(value,rowData,rowIndex){
			             data='<a id="modelId" style="color:blue;" href="javascript:paramModelDefUpdate(\''+rowData.PARAM_MODEL_ID+'\',\''+rowData.APP_ID+'\')\">'+rowData.PARAM_MODEL_ID+'</a>';
			             return data;
			             }},
			{title:'操作',field:'detail',align:'center',width:100,formatter:function(value,rowData,rowIndex){
                        var data='<input id="del" type="button" class="btn_grid" value="修改" onclick="javascript:updateModelInfoDetail(\''+rowData.KEYID+'\')\"/>';
						if(rowData.APP_ID!='00000000'){
						data+='<input id="del" type="button" class="btn_grid" value="删除" onclick="javascript:delUpModelInfoDetail(\''+rowData.KEYID+'\')\"/>';
						 } 
						 return data;
			             }}             
				]]
			});
            }); 
            
		  

		function cleardata(){
			$('#ff').form('clear');
		}
		
		function addAposModel(){
			$('#ff').form('submit',{
		        url:'updateAposModel.do',
			    onSubmit:function(){
			        return $(this).form('validate');
			    },
			    success:function(data){
			      var myObject = eval('(' + data + ')');
			       //这种方式直接关闭窗口，返回true或者false给主窗口
			       // window.close();
			       // window.returnValue=myObject.status; 
			        
			        //这种错误情况下方式不关闭窗口	 
			       if(myObject.status=="true"){
						 //window.close();
			        	 window.returnValue=myObject.status; 
			        	msgShow("消息","修改应用参数模板成功","info"); 
			        }else if(myObject.status=="false"){
			        	msgShow("修改",myObject.message,"error");
			        	//window.close();
			        }
			    }
			});
		}

	</script>
</head>
<body class="easyui-layout" fit="true">
					<div region="north"  title="信息录入" style="height: 270px">
					<div class="easyui-layout" fit="true"  >
					<div region="center"   >
							<form id="ff" method="post">
							<fieldset id="modelArea" style="padding:8px;width:95%;border:1px solid #46A3FF; color:#CC3300; line-height:2.0; font-size:12px;" align=center><legend>基本信息</legend>  
							<table class="formTable" style="width:100%;">
							<col  width="100px" class="leftCol"/>
							<col width="250px" >
							<col  width="100px" class="leftCol"/>
							<col width="250px" >
										<tr>
											<td>终端模板编号<font color="red">*</font></td>
											<td>
												<input type="text" class="readonly" required="true" readonly  required="true"   name="APOS_MODEL_ID" id="idAposModelId" maxlength="10" />
											</td>
											
											<td>终端模板名称<font color="red">*</font></td>
											<td>
												<input type="text" class="easyui-validatebox" required="true"   name="APOS_MODEL_NAME" id="idAposModelName" maxlength="30" validType="maxLen[30]"/>
											</td>
										</tr>
										<tr>
											<td>分支机构<font color="red">*</font></td>
											<td>
								    <input type="hidden" class="easyui-validatebox"    name="REG_ID" id="idRegId" maxlength="8" />
								    <input type="hidden"   name="REG_ENTIRE_ID" id="idRegEntirId" maxlength="50" />
									<input type="text" class="easyui-validatebox" style="background-color: #EEEEEE" required="true"   name="REG_NAME" id="idRegName" readonly="readonly" />
									<!-- 
									<input id="idChoose" type="button" class="btn_grid" value="选择"  onclick="queryReg('idRegId','idRegName','idRegEntirId');"/>
									<input id="idClear" type="button" class="btn_grid" value="清空" onclick="clearReg('idRegId','idRegName','idRegEntirId');"/></td>
										 -->
											<td>&nbsp;</td>
											<td>
			        <input type="button" id="idAposModelAdd" name="vposModelAdd" value="修改基本信息" class="btn_grid" onClick="addAposModel()" > 
			        &nbsp;&nbsp;
											</td>
										</tr>
									</table>
									</fieldset>
								    </form>
                                   <form id="ffdetail" method="post">
                                 
									<fieldset id="appArea"  style="padding:8px;width:95%;border:1px solid #46A3FF; color:#CC3300; line-height:2.0; font-size:12px;" align=center><legend>模板应用信息</legend>   
										<table class="formTable" style="width:100%;">
								<col  width="100px" class="leftCol"/>
								<col width="250px" >
								<col  width="100px" class="leftCol"/>
								<col width="250px" >
								<tr>
								  <input type="hidden" id="idAposmodel" name="APOS_MODEL_ID">
                                  <input type="hidden" name="sREG_ID" id="sidRegId"  readonly="readonly" maxlength="8" />
                                  <input type="hidden" name="sREG_ENTIRE_ID" id="sidRegEntirId" maxlength="50" />
                                  <input type="hidden" id="idSysId" name="SYS_ID">
                                  <input type="hidden" id="idhAppid" name="APPID">
                                  <input type="hidden" id="idSparamodId" name="SPARAMEID">
								</tr>
											<tr>
												<td>应用<font color="red">*</font></td>
												<td>
												    <select   required="true" name="APP_ID" id="idAppId"  onchange="changeAppVerInfo(this.value);" style="width: 80%">
													 <option value="">请选择应用</option>
													</select>
												</td>
												
												<td>应用版本<font color="red">*</font></td>
												<td>
												<select  class="easyui-validatebox" required="true"   name="APP_VER" id="idAppVer" style="width: 80%" >
													 <option value="">请选择应用版本</option>
													</select>
												</td>
											</tr>
											<tr>
												<td>参数模板<font color="red">*</font></td>
												<td>
												<select  class="easyui-validatebox" required="true"   name="parammodname" id="idparamodId" style="width: 80%" >
													 <option value="">请选择参数模板</option>
													</select>
												</td>
												<td>主应用</td>
												<td>
												 <input type="radio" id="idMasterflag" name="masterFlag" value="1" checked="checked" /><label class="label" for="splittrue">是</label>
				                                 <input type="radio" id="idMasterflag" name="masterFlag" value="0" /><label class="label" for="splitflase">否</label>
												</td>
											</tr>
											
												<tr>
												<td>&nbsp;</td>
												<td>
												<input type="button" id="idvposModelMod"  name="vposModelMod"  value="修改模板明细" class="btn_grid" onClick="modAposModelAppInfo()" > 
				        &nbsp;&nbsp;
												</td>
												<td>&nbsp;</td>
												<td>
				                                <input type="button" id="idvposModelAdd" name="vposModelAdd" value="添加模板明细" class="btn_grid" onClick="addAposModelAppInfoedit()" > 
				        &nbsp;&nbsp;
												</td>
											</tr>
										</table>
										</fieldset>
										</form>
						</div>
					</div>
		</div>
		<div region="center" split="true" >  
			<table id="idParamModeldetailedit" ></table>
	    </div>
					<div region="south"   style="text-align:right;" class="toolbarHeader">
						<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="checkAposModel('confirm')">确认</a>
						<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="checkAposModel()">取消</a>
					</div>
</body>
</html>
