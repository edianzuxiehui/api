	$(function(){
		
		  var k=window.dialogArguments; 
		  var param=k.par;
		  if(param){
		  	$('#idAposId').val(param.APOS_ID);
		  	$('#idAppId').val(param.APP_ID);
		  }else{
		  	msgShow("提示信息","传递参数为空!","warning");
		  	return false;
		  }
         
		var lastIndex;
			$('#idAposAppParam').datagrid({
				title:'参数明细',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:true,
				url:'listAposAppParam.do',
				queryParams:param,
				sortName: 'PARAM_ID',
				sortOrder: 'asc',
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
			{title:'参数项ID',field:'PARAM_ID',align:'center',width:100,sortable:true},
			{title:'参数名称',field:'PARAM_NAME',align:'center',width:150,sortable:true},
			{title:'参数长度',field:'VALUE_LEN',align:'center',width:100,sortable:true},
			{title:'参数值',field:'PARAM_VALUE',align:'center',width:150,sortable:true}
				]]
			});
			
			getParamGroup(param.APP_ID);
		});
			
		//获取参数组数据
		function getParamGroup(appId){
			$('#idParamGroup').combobox({
				url:'getParamGroup.do?APP_ID='+appId,
				valueField:'ITEMCODE',
				textField:'ITEMTEXT',
				onLoadSuccess:function(){//默认选中值
					var value = $('#idParamGroup').combobox('getData')[0].ITEMCODE;
					$('#idParamGroup').combobox('select',value);
				}
			});
		};
	
