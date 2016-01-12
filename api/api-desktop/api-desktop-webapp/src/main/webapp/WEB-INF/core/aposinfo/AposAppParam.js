$(function(){
	setModuleNameAndId();//设置模块ID、模块名隐藏域
	
	var k=window.dialogArguments;
	var param=k.par;
	if(param){
		$('#idAposId').val(param.APOS_ID);
		$('#idAppId').val(param.APP_ID);
	}else{
		msgShow("信息提示","传递参数为空!","error");
		return;
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
		singleSelect:true,
		frozenColumns:[[
	    	{field:'ck',checkbox:true},
	        {field:'FIELDS',title:'FIELDS',hidden:true},
			{title:'KEYID',field:'KEYID',hidden:true}
		]],
		columns:[[
			{title:'参数项ID',field:'PARAM_ID',align:'center',width:150,sortable:true},
			{title:'参数名称',field:'PARAM_NAME',align:'center',width:150,sortable:true},
			{title:'参数长度',field:'VALUE_LEN',align:'center',width:150,sortable:true},
			{title:'参数值',field:'PARAM_VALUE',align:'center',width:250,editor:{type:'text'}},
			{title:'操作',field:'OPERATE',align:'center',width:120,
				formatter:function(value,rowData,rowIndex){
					//商户号、商户名称、终端号不可删除
					//'01000001','01000002','01000005'
					if(rowData.PARAM_ID=='01000001' || rowData.PARAM_ID=='01000002' || rowData.PARAM_ID=='01000005') 
						return '';
					else
						return '<input id="del" type="button" class="btn_grid" value="删除" onclick="javascript:delAposAppParam(\''+rowData.KEYID+'\')"/>';
				}
			}
		]],
		//onClickRow:function(rowIndex){
			//if(lastIndex!=rowIndex) {
			//	$('#idAposAppParam').datagrid('endEdit', lastIndex);
			//	$('#idAposAppParam').datagrid('beginEdit', rowIndex);
			//}
			//lastIndex = rowIndex;
		//},
		onClickCell:function(rowIndex,field,value) {
			if(field=='PARAM_VALUE') {
				var rows = $('#idAposAppParam').datagrid('getRows');
				//商户号、终端号不可修改
				if(rows[rowIndex].PARAM_ID!='01000001' && rows[rowIndex].PARAM_ID!='01000002') {
					$('#idAposAppParam').datagrid('endEdit', lastIndex);
					$('#idAposAppParam').datagrid('beginEdit', rowIndex);
					
					lastIndex = rowIndex;
				}else{
					$('#idAposAppParam').datagrid('endEdit', lastIndex);
				}
			}else{
				$('#idAposAppParam').datagrid('endEdit', lastIndex);
			}
		},
		onAfterEdit:function(rowIndex, rowData, changes){//参数值修改退出时,要能自动提交,不需点击更新按钮
			updateAposAppParam(rowData);
		},
		onUnselect:function(rowIndex, rowData){//参数值修改退出时,要能自动提交,不需点击更新按钮（只有一行数据时点其他列提交）
			updateAposAppParam(rowData);
		}				
	});
			
	getParamGroup();
});

	//修改参数
	function updateAposAppParam(rowData){
		var rows = $('#idAposAppParam').datagrid('getChanges','updated');
		if(rows.length==0) return false;//没有修改的数据
		var paramValue = $.trim(rowData.PARAM_VALUE);
		if(paramValue=="") {
			msgShow('提示','参数值不能为空或空格','info');
			$('#idAposAppParam').datagrid('rejectChanges');//取消修改
			return false;
		}
		if(!limitMaxLenB(rowData.PARAM_VALUE,rowData.VALUE_LEN)) {
			$('#idAposAppParam').datagrid('rejectChanges');//取消修改
			return false;
		}
		var tmsModuleId = $("#idTmsModuleId").val();
		var tmsModuleTitle = $("#idTmsModuleTitle").val();
		var param = {tmsModuleId:tmsModuleId, tmsModuleTitle:escape(tmsModuleTitle), APOS_ID:rowData.APOS_ID, APP_ID:rowData.APP_ID, PARAM_ID:rowData.PARAM_ID, PARAM_VALUE:escape(paramValue)};
		$.getJSON('updateAposAppParam.do',param,function(data){
			if(data!=null) {
				if(data.status!=null && data.status=='true') {
					$('#idAposAppParam').datagrid('acceptChanges');//使修改的值生效
				}else{
					$('#idAposAppParam').datagrid('rejectChanges');//取消修改
					msgShow('提示','更新参数值出错！','error');
				}
			}
		});
	}
	
	//获取参数组数据
	function getParamGroup(appId){
		var appId = $('#idAppId').val();
		var aposId = $('#idAposId').val();
		
		$('#idParamGroup').combobox({
			url:'getParamGroup.do?APP_ID='+appId,
			valueField:'ITEMCODE',
			textField:'ITEMTEXT',
			onLoadSuccess:function(){//默认选中值
				var value = $('#idParamGroup').combobox('getData')[0].ITEMCODE;
				$('#idParamGroup').combobox('select',value);
			},
			onSelect:function(record){//根据参数组获取参数项数据
				$('#idParamId').combobox({
					url:'listParamItemForCombox.do?PARAM_GROUP='+record.ITEMCODE+'&APOS_ID='+aposId+'&APP_ID='+appId,
					valueField:'PARAM_ID',
					textField:'PARAM_NAME',
					onSelect:function(rec){//根据参数项填充 参数类型、参数长度、默认值
						if(rec.DEF_VALUE==null) {
							$('#idDefValue').val('');
						}else{
							$('#idDefValue').val(rec.DEF_VALUE);
						}
						$('#idValueLen').val(rec.VALUE_LEN);
						$('#idDataType').val(rec.DATA_TYPE);
						$('#idDataTypeAlias').val(rec.DATA_TYPE_ALIAS);
					}
				});
			}	
		});
	};
	
	//为参数模板增加参数项
	function addAposAppParam(){

		$('#ff').form('submit',{
	        url:'addAposAppParam.do',
		    onSubmit:function(){
		        return $('#ff').form('validate');
		    },
		    success:function(data){
		    
		      var myObject = eval('(' + data + ')');
		        
		       if(myObject.status=="true"){
		       		//msgShow("新增","新增成功","info");
					$('#idAposAppParam').datagrid('load');
					//$('#idParamGroup').combobox('select',$('#idParamGroup').combobox('getValue'));//添加成功后重新加载参数项列表
					cleardata();
		        }else if(myObject.status=="false"){
		        	msgShow("新增","新增失败","error");
		        }
		    }
		});
	}
	
	//删除参数
	function delAposAppParam(keyid){
		var tmsModuleId = $("#idTmsModuleId").val();
		var tmsModuleTitle = $("#idTmsModuleTitle").val();
		$.getJSON('delAposAppParam.do',{KEYID:keyid, tmsModuleId:tmsModuleId, tmsModuleTitle:escape(tmsModuleTitle)},function(data) {
			if(data!=null) {
				if(data.status!=null && data.status=='true') {
					$('#idAposAppParam').datagrid('load');
					//$('#idParamGroup').combobox('select',$('#idParamGroup').combobox('getValue'));//刷新参数项下拉列表
					cleardata();
					msgShow('提示','删除成功！','info');
				}else{
					if(data.message!=null) {
						msgShow("提示",data.message,"error");
					}else{
						msgShow("提示","删除失败!","error");
					}
				}
			
			}
		});
	}	
