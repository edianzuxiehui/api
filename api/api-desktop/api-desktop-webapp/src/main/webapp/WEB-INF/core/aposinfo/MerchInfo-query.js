	$(function(){
		  if(document.getElementById("idMerchInfo")){
			$('#idMerchInfo').datagrid({
				title:'商户资料列表',
				//iconCls:'icon-save',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:true,
				url:'listMerchInfo.do',
				sortName: 'KEYID',
				sortOrder: 'desc',
				remoteSort: false,
				singleSelect:true,
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
			{title:'商户编号',field:'MERCH_ID',align:'center',width:130,sortable:true},
			{title:'商户名称',field:'MERCH_NAME',align:'center',width:150,sortable:true},
			//{title:'网络接入服务商',field:'ORG_NAME',align:'center',width:150,sortable:true},
			//{title:'分店编号',field:'SUB_ID',align:'center',width:100,sortable:true},
			{title:'分支机构',field:'REG_NAME',align:'center',width:130,sortable:true},
			//{title:'商户属性',field:'MERCH_ATTR',align:'center',width:100,sortable:true},
			{title:'商户MCC',field:'MERCH_MCC',align:'center',width:100,sortable:true},
			{title:'联系人',field:'CONNECTER',align:'center',width:100,sortable:true},
			{title:'联系电话',field:'OPER_CALLNO',align:'center',width:120,sortable:true},
			//{title:'传真',field:'FAX_NO',align:'center',width:100,sortable:true},
			//{title:'Email地址',field:'EMAIL',align:'center',width:100,sortable:true},
			{title:'邮政编码',field:'POST_CODE',align:'center',width:110,sortable:true}
		//	{title:'商户状态',field:'MERCH_STATUS',align:'center',width:100,sortable:true},
		//	{title:'备注',field:'DESC_TXT',align:'center',width:100,sortable:true},
		
				]]
			});
			//defaultQueryReg();//初始化分支机构
	     }
	      
		});
