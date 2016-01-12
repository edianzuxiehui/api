	var k = window.dialogArguments;
	var aposIds = k.par;
	$(function(){
			$('#idStrategy').datagrid({
				iconCls:'icon-save',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:true,
				url:'listStrategy4StrateReportTime.do?apposIdRow='+aposIds.split(",").length,
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
			{title:'策略编号',field:'STRATEGY_ID',align:'center',width:100,sortable:true},
			{title:'策略开始日期',field:'STRA_BDATE',align:'center',width:100,sortable:true},
			{title:'策略结束日期',field:'STRA_EDATE',align:'center',width:100,sortable:true},
			{title:'区间开始时间',field:'STRA_BTIME',align:'center',width:100,sortable:true},
			{title:'区间结束时间',field:'STRA_ETIME',align:'center',width:100,sortable:true},
			{title:'可接入台数',field:'AVAILABLE',align:'center',width:100,sortable:true},
			{title:'分支机构',field:'REG_NAME',align:'center',width:100,sortable:true},
			{title:'预计接入台数',field:'CAPABILITY',align:'center',width:100,sortable:true},
			{title:'分散间隔(秒)',field:'SEPARATE_SECOND',align:'center',width:100,sortable:true},
			{title:'策略状态',field:'STRA_STATUS',align:'center',width:100,sortable:true}
			
				]]
				
			});
		});