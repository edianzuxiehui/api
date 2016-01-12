	$(function(){
		
			$('#idRegInfo').datagrid({
				//title:'分支机构管理',
				iconCls:'icon-save',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:true,
				url:'listRegInfo.do',
				sortName: 'KEYID',
				sortOrder: 'asc',
				remoteSort: false,
				singleSelect:true,
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
			{title:'分支机构编号',field:'REG_ID',align:'center',width:150,sortable:true},
			{title:'分支机构名称',field:'REG_NAME',align:'center',width:250,sortable:true},
			{title:'上级分支机构ID',field:'UP_REG_ID',align:'center',width:250,sortable:true,hidden:true},
			{title:'上级分支机构',field:'UPREGNAME',align:'center',width:250,sortable:true},
			{title:'ERP分支机构编号',field:'ERP_REG_ID',align:'center',width:100,sortable:true,hidden:true},
			{title:'备注',field:'DESC_TXT',align:'center',width:250,sortable:true}
				]]
			});
			$(".import_toolbar").attr('disabled', true);
			$(".export_toolbar").attr('disabled', true);
	
		});
		
		
	
		
