	$(function(){
	
	//新增广告信息时,选择的应用列表应去除多应用管理器应用
		  var k=window.dialogArguments; 
		  var url="listAppInfo.do";
		  if(k.par){
		  		var param=k.par;
		  		url+="?"+param;
		   }
	
		   if(document.getElementById("idAppInfo")){
			$('#idAppInfo').datagrid({
				title:'应用列表',
				//iconCls:'icon-save',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:true,
				url:url,
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
					{title:'应用编号',field:'APP_ID',align:'center',width:100,sortable:true},
					{title:'应用名称',field:'APP_NAME',align:'center',width:110,sortable:true},
					{title:'所属单位',field:'REG_NAME',align:'center',width:250,sortable:true},
					//{title:'应用状态',field:'APP_STATUS',align:'center',width:100,sortable:true},
					{title:'共享标志',field:'SHARE_FLAG2',align:'center',width:100,sortable:true}
					//{title:'注册日期',field:'INPUT_DATE',align:'center',width:200,sortable:true}
				]]
			});
		}	
	   
		});