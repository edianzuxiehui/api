	$(function(){
		
			$('#idMonitor').datagrid({
				//title:'监控信息',
				iconCls:'icon-save',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:true,
				url:'listMonitor.do',
				sortName: 'trandate',
				sortOrder: 'desc',
				remoteSort: false,
				idField:'seqno',
				rownumbers:true,
				columns:[[
			{title:'序列号',field:'seqno',align:'center',width:100,sortable:true},
			{title:'终端序列号',field:'terminalseq',align:'center',width:100,sortable:true},
			{title:'交易类型',field:'trantype',align:'center',width:100,sortable:true},
			{title:'交易时间',field:'trandate',align:'center',width:100,sortable:true},
			{title:'商户号',field:'merchid',align:'center',width:120,sortable:true},
			{title:'终端号',field:'terminalid',align:'center',width:100,sortable:true},
			{title:'结果',field:'result',align:'center',width:100,sortable:true},
			{title:'进度',field:'progress',align:'center',width:100,sortable:true},
			{title:'分支机构',field:'reg_id',align:'center',width:100,sortable:true},
			{title:'错误原因',field:'reason',align:'center',width:200,sortable:true}
			
				]]
			});
			
			reLoadDate();
	
		});
		
		function reLoadDate(){
			//$("#idMonitor").datagrid('reload');
			$.getJSON('listMonitor.do', function(json) {
				$("#idMonitor").datagrid('loadData',json);
			});
			
			setTimeout("reLoadDate()",3000);
		}