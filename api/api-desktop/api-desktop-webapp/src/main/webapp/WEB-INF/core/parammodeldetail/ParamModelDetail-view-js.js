	$(function(){
		
		  var k=window.dialogArguments; 
		  var param=k.par;
		  if(param){
		  	$('#PARAM_MODEL_ID').val(param.PARAM_MODEL_ID);
		  	//alert(param.APP_ID);
		  }else{
		  	msgShow("参数模板","传递参数为空!","err");
		  	return;
		  }
         
		var lastIndex;
			$('#idParamModelDetail-view').datagrid({
				title:'参数模板明细',
				iconCls:'icon-save',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:true,
				url:'listParamModelDetail.do',
				queryParams:param,
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
			{title:'参数组',field:'GROUP_NAME',align:'center',width:80,sortable:true},
			{title:'参数项编号',field:'PARAM_ID',align:'center',width:80,sortable:true},
			{title:'参数项名称',field:'PARAM_NAME',align:'center',width:150,sortable:true},
			{title:'参数长度',field:'VALUE_LEN',align:'center',width:60,sortable:true},
			{title:'参数值',field:'PARAM_VALUE',align:'center',width:160,editor:"text"}
				]]
			});
			
			getParamGroup(param.APP_ID);
		});
			
		//获取参数组数据
		function getParamGroup(appId){
			$('#idParamGroup').combobox({
				//url:'core/paramitem/getParamGroup.jsp',
				url:'getParamGroup.do?APP_ID='+appId,
				valueField:'ITEMCODE',
				textField:'ITEMTEXT',
				onLoadSuccess:function(){//默认选中值
					//alert(q);
					var value = $('#idParamGroup').combobox('getData')[0].ITEMCODE;//alert(value);
					$('#idParamGroup').combobox('select',value);
				},
				onSelect:function(record){//根据参数组获取参数项数据
					$('#idParamId').combobox({
						url:'queryParamItem.do?PARAM_GROUP='+record.ITEMCODE,
						valueField:'PARAM_ID',
						textField:'PARAM_NAME'
					});
				}	
			});
		};
	
