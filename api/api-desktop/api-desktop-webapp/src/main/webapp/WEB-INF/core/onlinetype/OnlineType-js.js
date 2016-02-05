	$(function(){
		
			$('#idOnlineType').datagrid({
				title:'table标题---自己先修改下',
				iconCls:'icon-save',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:true,
				url:'listOnlineType.do',
				sortName: 'KEYID',
				sortOrder: 'desc',
				remoteSort: false,
				idField:'KEYID',
				pageSize:20,
				pagination:true,
				rownumbers:true,
				frozenColumns:[[
	                {field:'ck',checkbox:true},
	                {field:'FIELDS',title:'FIELDS',hidden:true},
	                {title:'KEYID',field:'KEYID',hidden:true}
				]],
				columns:[[
			{title:'交易类型(pos联机交易)',field:'TRAN_TYPE',align:'center',width:100,sortable:true},
			{title:'交易名称',field:'TRAN_NAME',align:'center',width:100,sortable:true}
				]]
			});
			
	
		});
		
