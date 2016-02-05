	function queryMerch() {
		var retValue=openDialogFrame(getRootPath()+"/core/aposinfo/MerchInfo-query.jsp","","800","450");
		if(retValue!=undefined) {
			$('#idMerchId').val(retValue.merchId);
			$('#idMerchName').val(retValue.merchName);
		}
	}
	
	function clearMerch() {
		$('#idMerchId').val('');
		$('#idMerchName').val('');
	}
	
	//详情
	function viewAposDetail(aposId, devId) {
		var param = {APOS_ID:aposId, DEV_ID:devId, VIEW_FLAG:'true'};
		var retValue=openDialogFrame(getRootPath()+"/core/posextraconfirm/PosExtraConfirm-view.jsp",param,"850","450");
	}
	//终端补登确认
	function posExtraConfirm(aposId, devId) {
		var param = {APOS_ID:aposId, DEV_ID:devId, tmsModuleId:tmsJ5ModuleId, tmsModuleTitle:escape(tmsJ5ModuleTitle)};
		$.getJSON('addPosExtraConfirm.do',param,function(data){
			if(data!=null) {
				if(data.status!=null && data.status=='true') {
					msgShow('提示消息','终端补登确认成功！','info');
					$('#idPosExtraConfirmInfo').datagrid('load');
				}else{
					msgShow('提示消息',data.message,'error');
				}
			}
		});
	}
	//批量终端补登确认
	function posExtraConfirmBatch() {
		var rows = $('#idPosExtraConfirmInfo').datagrid('getSelections');
		var num = rows.length;
		var ids = null;
		var fields=null;
		if(num < 1){
			msgShow('提示消息','请选择记录!','info');
		}else{
  			for(var i = 0; i < num; i++){
				if(null == ids || i == 0){
					ids = rows[i].KEYID;
				} else {
					ids = ids + "," + rows[i].KEYID;	
				}
			}
			fields=rows[0].FIELDS;
		  	var param= buildDelParam(ids,fields);
		  	param += '&tmsModuleId='+tmsJ5ModuleId;
		  	param += '&tmsModuleTitle='+escape(escape(tmsJ5ModuleTitle));
		  	$.getJSON("addPosExtraConfirmBatch.do",param,function(data){
		  		if(data!=null) {
					if(data.status!=null && data.status=='true') {
						msgShow('提示消息','终端补登确认成功！','info');
						$('#idPosExtraConfirmInfo').datagrid('load');
					}else{
						msgShow('提示消息',data.message,'error');
					}
				}
		  	});
  		}
	}
	
	$(function(){
			//设置模块ID、模块名，以记录日志
			tmsJ5ModuleTitle=top.tabpanel.tabs('getSelected').panel('options').title;
  			tmsJ5ModuleId=top.tabpanel.tabs('getSelected').panel('options').tabId;
  			//alert(tmsJ5ModuleTitle+"_"+tmsJ5ModuleId);
			//初始化查询条件
			initDataForModelInfo('idFidSelect');
		
			$('#idPosExtraConfirmInfo').datagrid({
				//title:'终端补登确认',
				//iconCls:'icon-save',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:true,
				url:'listPosExtraConfirm.do',
				sortName: 'KEYID',
				sortOrder: 'desc',
				remoteSort: false,
				idField:'KEYID',
				pageSize:10,
				pagination:true,
				rownumbers:true,
				toolbar:[{
					text:'批量确认',
					iconCls:'icon-ok',
					handler:function(){
						posExtraConfirmBatch();
					}
				}],
				frozenColumns:[[
	                {field:'ck',checkbox:true},
	                {field:'FIELDS',title:'FIELDS',hidden:true},
	                {title:'KEYID',field:'KEYID',hidden:true}
				]],
				columns:[[
			{title:'应用终端号',field:'APOS_ID',align:'center',width:100,sortable:true},
			//{title:'实体终端编号',field:'DEV_ID',align:'center',width:100,sortable:true},
			{title:'终端型号',field:'MID',align:'center',width:100,sortable:true},
			{title:'硬件序列号',field:'SERIAL_NO',align:'center',width:100,sortable:true},
			
			{title:'主应用商户号',field:'MERCH_ID',align:'center',width:100,sortable:true},
			{title:'主应用商户名称',field:'MERCH_NAME',align:'center',width:100,sortable:true},
			{title:'主应用终端号',field:'TERMINAL_ID',align:'center',width:100,sortable:true},
			{title:'单位编码',field:'REG_ID',align:'center',width:100,sortable:true,hidden:true},
			{title:'分支机构',field:'REG_NAME',align:'center',width:150,sortable:true},
			{title:'布放地址',field:'APOS_ADDR',align:'center',width:150,sortable:true},
			{title:'操作',field:'DETAIL',align:'center',width:150,sortable:true,
				formatter:function(value,rowData,rowIndex) {
					var txt = '<input type="button" class="btn_grid" value="明细" onclick="viewAposDetail(\''+rowData.APOS_ID+'\',\''+rowData.DEV_ID+'\')"/>';
					txt += '<input type="button" class="btn_grid" style="margin-left:2px;" value="确认" onclick="posExtraConfirm(\''+rowData.APOS_ID+'\',\''+rowData.DEV_ID+'\')"/>';
					return txt;
				}
			}
				]]
			});
			
			//defaultQueryReg();//初始化分支机构
	
		});
		
