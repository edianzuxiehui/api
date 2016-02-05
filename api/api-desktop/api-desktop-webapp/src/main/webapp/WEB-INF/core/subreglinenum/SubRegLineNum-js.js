	$(function(){
		
			$('#idSubRegLineNum').datagrid({
				iconCls:'icon-save',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:true,
				url:'listSubRegLineNum.do',
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
				{title:'分支机构',field:'REG_NAME',align:'center',width:400,sortable:true},
				{title:'分公司线路数',field:'LINE_NUMBER',align:'center',width:400,sortable:true}
			
				]]
			});
			$(".import_toolbar").attr('disabled', true);
			$(".export_toolbar").attr('disabled', true);
	
		});
		
		
		
		function queryOneLevelReg(regId,regName){
			var retValue=openDialogFrame(getRootPath()+"/core/reginfo/RegInfo-queryonelevel.jsp","","400","300");
			if(retValue!=undefined){
				//var reg = retValue.split("_");/
				$('#'+regId).val(retValue.reg_id);
				$('#'+regName).val(retValue.reg_name);
			}
  		}
		function clearOneLevelReg(regId,regName){
			$('#'+regId).val('');
			$('#'+regName).val('');
		}
		
