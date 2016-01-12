	$(function(){
		
			
			defaultQueryReg();
			$('#idPosDevInfo').datagrid({
				title:'实体终端选择',
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
				rownumbers:false,
				singleSelect:true,
				frozenColumns:[[
	                {field:'ck',checkbox:true},
	                {field:'FIELDS',title:'FIELDS',hidden:true},
	                {title:'KEYID',field:'KEYID',hidden:true}
				]],
				columns:[[
			{title:'主机型号',field:'MID',align:'center',width:150,sortable:true},
			{title:'DEV_ID',field:'DEV_ID',align:'center',width:150,sortable:true,hidden:true},
			{title:'硬件序列号',field:'SERIAL_NO',align:'center',width:150,sortable:true},
			{title:'入库时间',field:'IN_DATE',align:'center',width:180,sortable:true},
			{title:'分支机构',field:'REG_ID',align:'center',width:200,sortable:true}
				]]
			});
			
			initDataForModelInfo('idFidSelect,idMidSelect');
			
			var k=window.dialogArguments; 
			if(k.tmsModuleTitle&&k.tmsModuleId){
				$("#idTmsModuleTitle").attr("value",k.tmsModuleTitle);
			   	$("#idTmsModuleId").attr("value",k.tmsModuleId);
			}
			if(k.par){
		  		var param=k.par;
		  		$('#oldMID').html(param.oldMID);
		  		$('#oldSno').html(param.oldSno);
		  	}
	
		});
		 
		function showAposDetail(apos_id){
			var retValue=openDialogFrame(getRootPath()+"/core/aposinfo/AposInfo-view.jsp","APOS_ID="+apos_id,"850","450");
		}
		
		
		function selectDev(){
			var rowsdev = $('#idPosDevInfo').datagrid('getSelections');
			if(rowsdev.length < 1){
				msgShow('提示消息','请选择你要绑定的实体终端!','info');
			}else{
				window.returnValue=rowsdev[0].DEV_ID+"_"+rowsdev[0].MID;
				window.close();
			}
		}