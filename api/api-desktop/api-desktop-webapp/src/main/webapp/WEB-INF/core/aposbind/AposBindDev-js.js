	$(function(){
		
			$('#idUnboundAposInfo').datagrid({
				//title:'未绑定型号的应用终端',
				iconCls:'icon-save',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:true,
				url:'listUnBoundAposInfo.do',
				sortName: 'KEYID',
				sortOrder: 'desc',
				remoteSort: false,
				idField:'KEYID',
				pageSize:20,
				pagination:true,
				singleSelect:true,
				rownumbers:false,
				frozenColumns:[[
	                {field:'ck',checkbox:true},
	                {field:'FIELDS',title:'FIELDS',hidden:true},
	                {title:'KEYID',field:'KEYID',hidden:true}
				]],
				columns:[[
			{title:'应用终端号',field:'APOS_ID',align:'center',width:80,sortable:true,
					formatter:function(value,rowData,rowIndex){ 
                        var a='<a style=\'color:red\'   href="javascript:showAposDetail(\''+ value+ '\')">'+ value+ '</a>'
                        return a;  
                    }  
			},
			{title:'主应用商户号',field:'MERCH_ID',align:'center',width:110,sortable:true},
			{title:'主应用商户名称',field:'MERCH_NAME',align:'center',width:110,sortable:true},
			{title:'主应用终端号',field:'TERMINAL_ID',align:'center',width:80,sortable:true},
			{title:'分支机构',field:'REG_NAME',align:'center',width:130,sortable:true}
				]]
			});
			defaultQueryReg();
			$('#idPosDevInfo').datagrid({
				//title:'实体终端选择',
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
			{title:'主机型号',field:'MID',align:'center',width:110,sortable:true},
			{title:'序列号',field:'DEV_ID',align:'center',width:120,hidden:true},
			{title:'硬件序列号',field:'SERIAL_NO',align:'center',width:120,sortable:true},
			{title:'入库时间',field:'IN_DATE',align:'center',width:130,sortable:true},
			{title:'分支机构',field:'REG_ID',align:'center',width:130,sortable:true}
				]]
			});
			
			initDataForModelInfo('idFidSelect,idMidSelect');
			
			var k=window.dialogArguments; 
			if(k.tmsModuleTitle&&k.tmsModuleId){
				$("#idTmsModuleTitle").attr("value",k.tmsModuleTitle);
			   	$("#idTmsModuleId").attr("value",k.tmsModuleId);
			}
	
		});
		 
		function showAposDetail(apos_id){
			var retValue=openDialogFrame(getRootPath()+"/core/aposinfo/AposInfo-view.jsp","APOS_ID="+apos_id,"850","450");
		}
		
		
		function aposBindDev(){
			var rowsapos = $('#idUnboundAposInfo').datagrid('getSelections');
			var rowsdev = $('#idPosDevInfo').datagrid('getSelections');
			
			var ids = null;
			var fields=null;
			if(rowsapos.length < 1){
				msgShow('提示消息','请选择你要绑定的应用终端!','info');
			}else if(rowsdev.length < 1){
				msgShow('提示消息','请选择你要绑定的实体终端!','info');
			}else{
				param ="APOSID=" + rowsapos[0].APOS_ID+"&DEVID=" + rowsdev[0].DEV_ID+"&MID=" + rowsdev[0].MID;
			  	param += "&tmsModuleTitle="+escape(escape($('#idTmsModuleTitle').val()))+"&tmsModuleId="+escape(escape($('#idTmsModuleId').val()));
			  	$.getJSON("aposBindDev.do",param,function(data){
			  		if(data.status =="false"){
			  			msgShow('提示消息',data.message,'info');
			  		}else{
			  			window.returnValue = "true";
			  			window.close();
			  		}
				});
			  		
			}
		}