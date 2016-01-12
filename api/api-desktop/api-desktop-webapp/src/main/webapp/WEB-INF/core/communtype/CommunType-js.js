	$(function(){
		 if(document.getElementById("idtableCommunType")){
			$('#idtableCommunType').datagrid({
				title:'通行方式配置列表',
				iconCls:'icon-save',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:true,
				url:'listCommunType.do',
				sortName: 'KEYID',
				sortOrder: 'desc',
				remoteSort: false,
				idField:'KEYID',
				pageSize:10,
				pagination:true,
				rownumbers:true,
				frozenColumns:[[
	                {field:'ck',checkbox:true},
	                {field:'FIELDS',title:'FIELDS',hidden:true},
	                {title:'KEYID',field:'KEYID',hidden:true}
				]],
				columns:[[
			//{title:'系统内部编号(使用序列生成的编号)',field:'SYS_ID',align:'center',width:100,sortable:true},
			{title:'通讯方式',field:'COMMUN_TYPE',align:'center',width:500,sortable:true},
			{title:'通讯配置',field:'COMMUN_DETAIL',align:'center',width:500,sortable:true}
				]]
			});
			}
	
		});
		
