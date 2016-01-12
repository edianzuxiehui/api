	$(function(){
		
			$('#idOperInfo').datagrid({
				//title:'操作员列表',
				//iconCls:'icon-save',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:true,
				url:'listOperInfo.do',
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
			{title:'操作员编号',field:'OPER_ID',align:'center',width:100,sortable:true},
			{title:'实际角色ID',field:'REALROLEID',align:'center',width:100,sortable:true,hidden:true},
			{title:'所属权限组',field:'REALROLENAME',align:'center',width:100,sortable:true},
			{title:'操作员名',field:'NAME',align:'center',width:110,sortable:true},
			{title:'分支机构编号',field:'REG_ID',align:'center',width:100,sortable:true,hidden:true},
			{title:'分支机构',field:'REGNAME',align:'center',width:110,sortable:true},
			{title:'创建日期',field:'CREATE_DATE',align:'center',width:100,sortable:true},
			{title:'状态',field:'VALIDNAME',align:'center',width:70,sortable:true},
			{title:'岗位',field:'OPER_STATION',align:'center',width:70,sortable:true},
			{title:'联系电话',field:'OPER_CALLNO',align:'center',width:110,sortable:true},
			{title:'Email地址',field:'EMAIL',align:'center',width:110,sortable:true},
			{title:'上次访问时间',field:'LASTLOGIN',align:'center',width:110,sortable:true},
			{title:'操作',field:'CREATE_POS_TIME',align:'center',width:100,sortable:true,
				formatter:function(value,rowData,rowIndex){ 
					return '<input type="button" class="btn_grid" value="重置密码" onclick="resetPassWord(\''+rowData.OPER_ID+'\')"/>';
                } 
			}
				]]
			});
			defaultQueryReg();
			$(".import_toolbar").attr('disabled', true);
			$(".export_toolbar").attr('disabled', true);
			var tab = top.tabpanel.tabs('getSelected');
			var moduleTitle=tab.panel('options').title;
	  		var moduleId=tab.panel('options').tabId;
			$("#idTmsModuleTitle").attr("value",moduleTitle);
			$("#idTmsModuleId").attr("value",moduleId);
	
		});
		
		
		function resetPassWord(operId){
			var tab = top.tabpanel.tabs('getSelected');
			var moduleTitle=tab.panel('options').title;
	  		var moduleId=tab.panel('options').tabId;
	  		//setModuleNameAndIdFromTab();
	  		//alert(moduleTitle);
	  		var param="OPER_ID="+operId+"&tmsModuleTitle="+escape(escape($('#idTmsModuleTitle').val()))+"&tmsModuleId="+escape(escape($('#idTmsModuleId').val()));
			$.getJSON('resetOperPWD.do',param,function(jsonData){
				if(jsonData.status=="true"){
					msgShow("修改","密码重置成功!","info");
				}else if(jsonData.status=="false"){
				    msgShow("修改",myObject.message,"error");
				}
				
			});
		}
