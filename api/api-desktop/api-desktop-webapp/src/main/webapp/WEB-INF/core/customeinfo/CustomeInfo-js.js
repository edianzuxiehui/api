	$(function(){
		
			$('#idCustomeInfo').datagrid({
				//title:'客服资料管理',
				iconCls:'icon-save',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:true,
				url:'listCustomeInfo.do',
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
			{title:'客服编号',field:'CUSTOME_ID',align:'center',width:180,sortable:true},
			{title:'客服用户名',field:'CUSTOME_NAME',align:'center',width:220,sortable:true},
			{title:'客服有效期',field:'VALIDDATE',align:'center',width:250,sortable:true},
			{title:'客服可用次数',field:'RETRY_TIME',align:'center',width:130,sortable:true},
			{title:'上次访问时间',field:'LASTLOGIN',align:'center',width:230,sortable:true}
				]]
			});
			$(".import_toolbar").attr('disabled', true);
			$(".export_toolbar").attr('disabled', true);
	
		});
		
