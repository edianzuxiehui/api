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
	<title>策略分配</title>
	<link rel="stylesheet" type="text/css" href="themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="themes/icon.css">
	<link rel="stylesheet" type="text/css" href="css/default.css">
	<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="js/common.js"></script>
    <script type="text/javascript" src="core/strategy/strategyDist-js.js"></script>
    <script type="text/javascript" src="core/strategy/strategyBindApos-js.js"></script>
	<script type="text/javascript">
	setModuleNameAndId('ff');
	setModuleNameAndId('ff1');
	//本页面允许的操作功能
  	function onNew() {
		var rows = $('#idStrategyBindApos').datagrid('getSelections');
		if(rows.length < 1){
			msgShow('提示消息','请选择你要进行策略分配的应用终端!','info');
			return;
		}
		var aposIds=null;
		for(var i = 0; i < rows.length; i++){
			if(null == aposIds || i == 0){
				aposIds = $.trim(rows[i].KEYID);
			} else {
				aposIds = $.trim(aposIds) + "," + $.trim(rows[i].KEYID);
			}
		}
		var strategyId=$('#idStrategyId').val();
	  	var tmsModuleId = $("#ff > #idTmsModuleId").val();//alert(tmsModuleId);
		//tmsModuleId = $("#ff").find("#idTmsModuleId").val();alert(tmsModuleId);
		var tmsModuleTitle = $('#ff > #idTmsModuleTitle').val();
		tmsModuleTitle=escape(escape(tmsModuleTitle));
		var param = "APOS_ID="+aposIds+"&STRATEGY_ID="+strategyId+'&tmsModuleId='+tmsModuleId+'&tmsModuleTitle='+tmsModuleTitle;
		//alert(param);
		
		$('#btn1').attr('disabled',true);
		$.getJSON('addStrategyAposBind.do',param,function(data){
			if (null != data && null != data.status && "" != data.status&&data.status=="true") {
				//msgShow('提示消息',data.message,'info');
				//$('#idStrategyBindApos').datagrid('load');
				//$('#idStrategyDist').datagrid('load');
				$.messager.alert('提示消息',data.message,'info',reload);
			} else {
				if(data.message==null||data.message==""){
					msgShow('提示消息','删除失败！','warning');
				}else{
					msgShow('提示消息',data.message,'warning');
				}
			}
				clearSelect('idStrategyBindApos');
				$('#btn1').removeAttr('disabled');
			});
	 }
	 function reload(){
		$('#idStrategyBindApos').datagrid('load');
	    $('#idStrategyDist').datagrid('load');
	 }
	  function onDelete() {
	    var rows = $('#idStrategyDist').datagrid('getSelections');
		var ids = null;
		var fields=null;
		if(rows.length < 1){
			msgShow('提示消息','请选择你要删除策略的记录!','info');
		}else{
			for(var i = 0;i < rows.length;i++){
				if(null == ids || i == 0){
					ids = $.trim(rows[i].KEYID);
				} else {
				    ids = $.trim(ids) + "," + $.trim(rows[i].KEYID);
				}
			}
			fields=rows[0].FIELDS;
		  	var param=buildDelParam(ids,fields);
		  	var tmsModuleId=$('#ff1').find('#idTmsModuleId').val();//alert(tmsModuleId);
		  	//tmsModuleId = $('#ff1 > #idTmsModuleId').val();alert(tmsModuleId);//find方式设置，此方法获取不行
			var tmsModuleTitle = $('#ff1').find('#idTmsModuleTitle').val();
			tmsModuleTitle=escape(escape(tmsModuleTitle));
		  	param = param+'&tmsModuleId='+tmsModuleId+'&tmsModuleTitle='+tmsModuleTitle;
		  	//alert(param);
		  	
		  	$('#btn2').attr('disabled',true);
			$.getJSON('delStrategyAposBind.do',param,function(data){
				if (null != data && null != data.status && "" != data.status&&data.status=="true") {
					//msgShow('提示消息',data.message,'info');
					//$('#idStrategyBindApos').datagrid('load');
					//$('#idStrategyDist').datagrid('load');
					$.messager.alert('提示消息',data.message,'info',reload);
				} else {
					if(data.message==null||data.message==""){
						msgShow('提示消息','删除失败！','warning');
					}else{
						msgShow('提示消息',data.message,'warning');
					}
				}
				clearSelect('idStrategyDist');
				$('#btn2').removeAttr('disabled');
			});
  		}
	  }
	  
		function queryInfo1(){
		    var date=new Date();
			var param="flag="+date.getTime()+"&STRATEGY_ID="+$('#idStrategyId').val()
						+"&APOS_ID="+$('#idAposId1').val()+"&REG_ID="+$('#idRegId1').val()
						;
			$('#idStrategyDist').datagrid('options').url = "strategyDist.do?"+param;// 改变它的url  
			$("#idStrategyDist").datagrid('load');
		}
		function cleardata1(){
			var strategyId = $('#idStrategyId').val();
			$('#ff1').form('clear');
			$('#idStrategyId').val(strategyId);
		}
		
		
 		function queryInfo(){
		    var date=new Date();
			var param="flag="+date.getTime()+"&STRATEGY_ID="+$('#idStrategyId').val()
						+"&APOS_ID="+$('#idAposId').val()+"&REG_ID="+$('#idRegId').val()
						;
			$('#idStrategyBindApos').datagrid('options').url = "strategyAposBind.do?"+param;// 改变它的url  
			$("#idStrategyBindApos").datagrid('load');
		}
		function cleardata(){
			$('#ff').form('clear');
		}
</script>
</head>
<body class="easyui-layout" >
<div region="center" class="easyui-layout" >
	
		<div region="west" class="easyui-layout" icon="icon-reload" style="width:500px;height:470px">
	  		<div region="north" style="height:65px;">
				<form id="ff" method="post">
					<table class="formTable" style="width:90%;">
						<col  width="75px" class="leftCol"/>
						<col width="180px" >
						<col  width="10px" class="leftCol"/>
						<col width="100px" >
                              <tr>
								<td>应用终端编号</td>
								<td>
									<input type="text" name="APOS_ID" id="idAposId" maxlength="10" size="15"/>
								</td>
                               <td  align="left">
							     <input id="idReset" type="button" class="btn_grid" value=" 重 置 " onclick="cleardata()"/>
								</td>
                              	
							</tr>
							<tr>
                              	<td>分支机构</td>
								<td>
									<input type="hidden" class="easyui-validatebox" name="REG_ID" id="idRegId" maxlength="8" />
									<input type="text" class="easyui-validatebox" style="background-color: #EEEEEE" readonly name="REG_ID" id="idRegName" size="15"/>
									<input id="idChoose" type="button" class="btn_grid" value="选择" onclick="queryReg('idRegId','idRegName')"/>
								</td>
                               <td  align="left">
							     <input id="idQuery" type="button" class="btn_grid" value=" 查 询 " onclick="queryInfo()"/>
								</td>
							</tr>
					</table>
				</form>
			</div>
					
			<div region="center">  
				<table id="idStrategyBindApos" ></table>
			</div>
		</div>
		
		<div region="center" style="background:#fafafa;overflow:hidden;width:60px;height:500px;padding-top:170px;">
			<table align="center">
				<tr>	
					<td width="100%">
						<input type="button" id="btn1" value=" &gt;&gt; " onclick="onNew();"/><br/>
						<input type="button" id="btn2" value=" &lt;&lt; " onclick="onDelete();"/>
					</td>
				</tr>
			</table>
		</div>
				
   		<div region="east" class="easyui-layout" style="width:500px;height:470px">
			<div region="north" style="height:65px;">
				<form id="ff1" method="post">
					<table class="formTable" style="width:90%;">
						<col  width="10%" class="leftCol"/>
						<col width="20%" >
						<col  width="5%" class="leftCol"/>
						<col width="15%" >
                              <tr>
								<td>应用终端编号</td>
								<td><input type="hidden" name="STRATEGY_ID" id="idStrategyId"/> <!-- 增加策略分配时使用 -->
									<input type="text" name="APOS_ID" id="idAposId1" maxlength="10" size="15"/>
								</td>
							</tr>
							<tr>	
                               	<td>分支机构</td>
								<td>
									<input type="hidden" class="easyui-validatebox" name="REG_ID" id="idRegId1" maxlength="8" />
									<input type="text" class="easyui-validatebox" style="background-color: #EEEEEE" readonly name="REG_ID" id="idRegName1" size="15"/>
									<input id="idChoose" type="button" class="btn_grid" value="选择" onclick="queryReg('idRegId1','idRegName1')"/>
								</td>
								<td></td>
								
                               <td >
                               	<div style="text-align:left;">
							     <input id="idQuery1" type="button" class="btn_grid" value=" 查 询 " onclick="queryInfo1()"/>
							     <input id="idReset1" type="button" class="btn_grid" value=" 重 置 " onclick="cleardata1()"/>
							     </div>
								</td>
							</tr>
						</table>
					    </form>
					</div>
					
			<div region="center" >  
				<table id="idStrategyDist" ></table>
			</div>	
		</div>
	</div>

	<div region="south" style="text-align:right;" class="toolbarHeader">
		<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="javascript:window.close()">确认</a>
	</div>		
</body>
</html>
