	$(function(){
				  var k=window.dialogArguments; 
				  var param=k.par;
		  if(param){
		  	$('#PARAM_MODEL_ID').val(param.PARAM_MODEL_ID);
		  	getParamGroup(param.APP_ID,param.PARAM_GROUP);//alert("grpup:"+param.PARAM_GROUP);
		  	//$('#idParamGroup').combobox('setValue',);
		  }else{
		  	msgShow("参数模板明细","传递参数为空!","err");
		  	return;
		  }
		  
		  /*if(k.par){
		  	var param=k.par;//alert(param.PARAM_GROUP);
		  	$('#PARAM_MODEL_ID').val(param.PARAM_MODEL_ID);
		  	$('#PARAM_GROUP').val(param.PARAM_GROUP);
			$.getJSON("queryParamItemNotInParamModelDetailForPage.do",param,function(data){
				$.each(data.rows,function(idx,item){
					$('#idParamItem').datagrid('appendRow',item);
				});
            }); 
         }*/
         
			$('#idParamItem').datagrid({
				title:'参数项管理',
				iconCls:'icon-save',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:true,
				url:'queryParamItemNotInParamModelDetailForPage.do',
				queryParams:param,
				sortName: 'KEYID',
				sortOrder: 'desc',
				remoteSort: false,
				idField:'KEYID',
				pageSize:15,
				pagination:true,
				rownumbers:true,
				frozenColumns:[[
	                {field:'ck',checkbox:true},
	                {field:'FIELDS',title:'FIELDS',hidden:true},
	                {title:'KEYID',field:'KEYID',hidden:true}
				]],
				columns:[[
		    {title:'参数组别',field:'PARAM_GROUP_NAME',align:'center',width:100,sortable:true},
			{title:'参数项ID',field:'PARAM_ID',align:'center',width:80,sortable:true},
			{title:'参数名称',field:'PARAM_NAME',align:'center',width:120,sortable:true},
			{title:'参数数据类型',field:'DATA_TYPE',align:'center',width:90,sortable:true},
			{title:'参数长度',field:'VALUE_LEN',align:'center',width:80,sortable:true},
			{title:'默认值',field:'DEF_VALUE',align:'center',width:130,sortable:true},
			{title:'备注',field:'DESC_TXT',align:'center',width:130,sortable:true}
				]]
			});
		});
		
	     //获取参数组数据
		 function getParamGroup(appId,groupId){
			$('#idParamGroup').combobox({
				//url:'core/paramitem/getParamGroup.jsp',
				url:'getParamGroup.do?APP_ID='+appId,
				valueField:'ITEMCODE',
				textField:'ITEMTEXT',
				onSelect:function(record){//根据参数组获取参数项数据
					var PARAM_MODEL_ID=$('#PARAM_MODEL_ID').val();
					var PARAM_GROUP=$('#idParamGroup').combobox('getValue');//alert("PARAM_GROUP:"+PARAM_GROUP);
					var param = {"PARAM_MODEL_ID":PARAM_MODEL_ID,"PARAM_GROUP":PARAM_GROUP};
				   $('#idParamItem').datagrid('options').queryParams = param; 
				   $("#idParamItem").datagrid('load');
				},
				onLoadSuccess:function(){
					if(groupId){
						$("#idParamGroup").combobox('setValue',groupId);
					}
				}
			});
		};
		
		
  //批量增加参数项	
  function addParamModelDetails(){
	var rows = $('#idParamItem').datagrid('getSelections');//object对象的数组
	var num = rows.length;
	var ids = null;
	var fields=null;
	if(num < 1){
		msgShow('提示消息','请选择数据!','info');
	}else{
	    var tmsModuleTitle= $("#idTmsModuleTitle").val();
   		var tmsModuleId= $("#idTmsModuleId").val();
		var param = {"jsonStr":$.toJSON(rows),"tmsModuleId":tmsModuleId,"tmsModuleTitle":tmsModuleTitle};
		//var param = {"jsonStr":111};注意111前面不能有空格
		//var param = "jsonStr=111";//这种方式不行
		$.post('batchAddParamModelDetail.do', param,function(data) {
			var myObject = eval('(' + data + ')');
			if(myObject.status=="true"){
				window.close();//必须放在成功返回后，否则可能导致不能传递参数
			}else if(myObject.status=="false"){
			 	msgShow("批量新增参数项",myObject.message,"error");
			}
		});	
  }
}