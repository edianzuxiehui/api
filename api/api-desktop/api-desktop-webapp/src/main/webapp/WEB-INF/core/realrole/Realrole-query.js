	$(function(){
			var k=window.dialogArguments;
			var param = k.par;
			var query = "";
			if(param!=null) {
				$('#idInclude').val(param.include);
				query = "?INCLUDE="+param.include;
			}
			
			$('#idRealrole').datagrid({
				title:'权限组管理',
				//iconCls:'icon-save',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:true,
				url:'listRealrole.do'+query,
				sortName: 'KEYID',
				sortOrder: 'desc',
				remoteSort: false,
				idField:'KEYID',
				pageSize:10,
				pagination:true,
				rownumbers:true,
				singleSelect:true,
				frozenColumns:[[
	                {field:'ck',checkbox:true},
	                {field:'FIELDS',title:'FIELDS',hidden:true},
	                {title:'KEYID',field:'KEYID',hidden:true}
				]],
				columns:[[
					{title:'权限组编号',field:'REALROLEID',align:'center',width:100,sortable:true},
					{title:'权限组名称',field:'NAME',align:'center',width:100,sortable:true},
					{title:'分支机构编号',field:'REG_ID',align:'center',width:100,sortable:true,hidden:true},
					{title:'所属机构',field:'REG_NAME',align:'center',width:200,sortable:true}
				]]
			});
			
		});