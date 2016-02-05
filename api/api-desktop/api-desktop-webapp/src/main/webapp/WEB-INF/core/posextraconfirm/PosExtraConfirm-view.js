//返回
function back() {
	window.close();
}

//查看参数-明细表
function viewAppParam(apos_id,app_id) {
	var param = {APOS_ID:apos_id, APP_ID:app_id};
	var retValue=openDialogFrame(getRootPath()+"/core/aposinfo/AposAppParam-view.jsp",param,"850","450");
}

$(function(){
	//获取参数
	var k=window.dialogArguments;
	var param = k.par;
	$.getJSON('queryPosDevInfo.do',param,function(data){
		$.each(data.rows,function(idx,item){
			$("#idMid").val($.trim(item.MID));
			$("#idSerialNo").val($.trim(item.SERIAL_NO));
			$("#idInDate").val($.trim(item.IN_DATE));
			$("#idDescTxt").val($.trim(item.DESC_TXT));
		})
	});
	$.getJSON("queryAposInfo.do",param,function(data){
		$.each(data.rows,function(idx,item){
			$('#idAposId').val(item.APOS_ID);
			$('#idRegId').val(item.REG_ID);
			$('#idRegName').val(item.REG_NAME);
			$('#idAposAddr').val(item.APOS_ADDR);
			
			//加载应用终端应用明细
			$('#idAposAppInfo').datagrid({
				url:"listAposAppInfo.do?APOS_ID="+item.APOS_ID,
				//iconCls:'icon-save',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:false,
				sortName: 'KEYID',
				sortOrder: 'desc',
				remoteSort: false,
				idField:'KEYID',
				rownumbers:true,
				pagination:true,
				pageSize:20,
				singleSelect:true,
				frozenColumns:[[
			              {field:'ck',checkbox:true},
			              {field:'FIELDS',title:'FIELDS',hidden:true},
			              {title:'KEYID',field:'KEYID',hidden:true}
				]],
				columns:[[
					{title:'应用编号',field:'APP_ID',align:'center',width:100,sortable:true},
					{title:'应用名称',field:'APP_NAME',align:'center',width:100,sortable:true,
						formatter:function(value,rowData,rowIndex) {
							if(rowData.MASTER_APP_FLAG=='1') {
								return value+'(主应用)';
							}else{
								return value;
							}
						}
					},
					{title:'应用版本',field:'APP_VER',align:'center',width:100,sortable:true},
					{title:'应用参数',field:'PARAM_MODEL_ID',align:'center',width:100,sortable:true,
						formatter:function(value,rowData,rowIndex) {
							return '<input type="button" class="btn_grid" onclick="viewAppParam(\''+rowData.APOS_ID+'\',\''+rowData.APP_ID+'\')" value="查看参数"/>';
						}
					},
					{title:'商户编号',field:'MERCH_ID',align:'center',width:100,sortable:true,
						styler:function(value,rowData,rowIndex){
							if(value!=null && value.length<15) {
								return "color:#ccc;";
							}
						}
					},
					{title:'商户名称',field:'MERCH_NAME',align:'center',width:100,sortable:true},
					{title:'终端号',field:'TERMINAL_ID',align:'center',width:100,sortable:true}
				]]
			});
		});
	});
});