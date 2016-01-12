	$(function(){
			$('#idRealrole').datagrid({
				title:'权限组',
				//iconCls:'icon-save',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:true,
				url:'listRealrole.do',
				sortName: 'KEYID',
				sortOrder: 'desc',
				remoteSort: false,
				idField:'KEYID',
				pageSize:20,
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
					{title:'分支机构',field:'REG_NAME',align:'center',width:200,sortable:true}
				]],
				//onClickRow:showRealSub,
				//onSelect:showRealSub,
				onClickRow:selectRow,
				onSelect:showRealSub,
				onLoadSuccess:genRealSubGrid
			});
			
			$(".edit_toolbar").attr('disabled', true); //修改不可用
			$(".import_toolbar").attr('disabled', true);
			$(".export_toolbar").attr('disabled', true);
		});
		
	function selectRow(rowIndex,rowData) {
		//$('#idRealrole').datagrid("clearSelections");
		$('#idRealrole').datagrid('selectRow',rowIndex);	
	}
	function genRealSubGrid(data) {
		
		$('#idRealsub').datagrid({
			title:'权限组-权限映射',
			//iconCls:'icon-save',
			fit:true,
			nowrap: false,
			striped: true,
			collapsible:true,
			//url:'listRealsub.do'+param,
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
				{title:'权限组编号',field:'REALROLEID',align:'center',width:100,sortable:true},
				{title:'权限组名称',field:'REALROLENAME',align:'center',width:150,sortable:true},
				{title:'权限编号',field:'SUBROLEID',align:'center',width:100,sortable:true},
				{title:'权限名称',field:'SUBROLENAME',align:'center',width:150,sortable:true},
				{title:'分支机构编号',field:'REG_ID',align:'center',width:100,sortable:true,hidden:true}
			]],
			toolbar:[{
				text:"增加权限",
				iconCls:'icon-add',
				handler:addRealSub
			},'-',{
				text:"删除权限",
				iconCls:'icon-remove',
				handler:delRealSub
			}]
		});
	
		var param = "";
		if(data.total>0) {
			//$('#idRealrole').datagrid("clearSelections");
			//$('#idRealrole').datagrid('selectRow',0);
			var rowData = data.rows[0];
			var realroleid = rowData.REALROLEID;
			var realrolename = rowData.NAME;
			var reg_id = rowData.REG_ID;
			$('#currentRealRole').val(realroleid+"_"+realrolename+"_"+reg_id);//设置隐藏域，记录当前选择的实际角色
			
			param += "?flag="+(new Date()).getTime();
			param += "&REALROLEID="+realroleid;
			
			
			$('#idRealsub').datagrid('options').url = "listRealsub.do"+param;
			$("#idRealsub").datagrid('load');
		}
	}
		
	function showRealSub(rowIndex,rowData) {
		//$('#idRealrole').datagrid("clearSelections");
		//$('#idRealrole').datagrid('selectRow',rowIndex);
		
		var date = new Date();
		var realroleid = rowData.REALROLEID;
		var realrolename = rowData.NAME;
		var reg_id = rowData.REG_ID;
		$('#currentRealRole').val(realroleid+"_"+realrolename+"_"+reg_id);//设置隐藏域，记录当前选择的实际角色
		var param="";
		param += "flag="+date.getTime();
		param += "&REALROLEID="+realroleid;
		$('#idRealsub').datagrid('options').url = "listRealsub.do?"+param;
		$("#idRealsub").datagrid('load');
	}

	function addRealSub() {//增加子角色
		var currentRealRole = $('#currentRealRole').val();
		if(currentRealRole!="") {
			var params = currentRealRole.split('_');
			var realroleid = params[0];
			var realrolename = params[1];
			var reg_id = params[2];
			var obj = new Object();
			obj.realroleid= realroleid;
			obj.realrolename = realrolename;
			obj.reg_id = reg_id;
			var retValue=openDialogFrame("Realsub-add.jsp",obj,"400","200");
			if(retValue=="true"){
				msgShow("新增","新增成功!","info");
				flashTable("idRealsub");
			}else if(retValue=="false"){
			   msgShow("新增","新增失败!","error");
			}
		}else{
			msgShow("提示","请在左侧列表中选择权限组","info");
		}
	}
	
	function delRealSub() {//删除子角色
		deleteNoteById("idRealsub","delRealsub.do", "");
		//$('#currentRealRole').val('');//重置隐藏域
	}		
