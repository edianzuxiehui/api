	$(function(){
			var k=window.dialogArguments;
			if(k.par!=undefined) {
				$('#idAposNum').val(k.par.aposNum);	
			}
			
			$('#idStrategy').datagrid({
				title:'策略选择',
				//iconCls:'icon-save',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:true,
				url:'listStrategy.do',
				queryParams:{STRATEGY_TYPE:'1',REMAIN:'1'},
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
			//{title:'策略编号',field:'STRATEGY_ID',align:'center',width:100,sortable:true},
			{title:'策略开始日期',field:'STRA_BDATE',align:'center',width:100,sortable:true},
			{title:'策略结束日期',field:'STRA_EDATE',align:'center',width:100,sortable:true},
			{title:'区间开始时间',field:'STRA_BTIME',align:'center',width:100,sortable:true},
			{title:'区间结束时间',field:'STRA_ETIME',align:'center',width:100,sortable:true},
			//{title:'接入方式',field:'POS_FLAG',align:'center',width:100,sortable:true},
			{title:'可接入台数',field:'AVAILABLE',align:'center',width:100,sortable:true},
			{title:'所属单位',field:'REG_NAME',align:'center',width:100,sortable:true},
			//{title:'策略状态',field:'STRA_STATUS',align:'center',width:100,sortable:true},
			{title:'分散间隔(秒)',field:'SEPARATE_SECOND',align:'center',width:100,sortable:true}
			//{title:'报到间隔周期(天)',field:'INTERVAL_DAYS',align:'center',width:100,sortable:true},
			//{title:'允许终端最迟报到间隔(分钟)',field:'ONLINE_DELAY',align:'center',width:150,sortable:true},
			//{title:'上次分配时间',field:'CURRENT_TIMES',align:'center',width:100,sortable:true},
			//{title:'备注',field:'DESC_TXT',align:'center',width:100,sortable:true}
				]]			
			});
			
		});