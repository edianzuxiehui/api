	var lastIndex;
	var validParamValueFlag = true;//用于防止一行编辑验证值有问题，点击其他行，出现2行可编辑
	$(function(){
		  var k=window.dialogArguments; 
		  if(!k.par){
		  	msgShow("任务参数","传递参数为空!","err");
          	return ;
          }
		  	var param=k.par;//alert(param);//TASK_SYS_ID=&PLAN_CODE=&APOS_ID=&APP_ID=
		  	var idTaskSysId = param.substring(param.lastIndexOf('TASK_SYS_ID=')+12,param.lastIndexOf('&PLAN_CODE='));
		  	var idPlanCode = param.substring(param.lastIndexOf('PLAN_CODE=')+10,param.lastIndexOf('&APOS_ID='));
		  	var idAposId = param.substring(param.lastIndexOf('APOS_ID=')+8,param.lastIndexOf('&APP_ID='));
		  	var idAppId= param.substring(param.lastIndexOf('APP_ID=')+7);
		  	//alert(idTaskSysId); alert(idPlanCode);alert(idAposId);alert(idRegId);
            $('#idTaskSysId').val(idTaskSysId);
          	$('#idPlanCode').val(idPlanCode);
          	$('#idAposId').val(idAposId);
		  	$('#idAppId').val(idAppId);
		  	         
		  	param={'TASK_SYS_ID':idTaskSysId,'APP_ID':idAppId};
			$('#idTaskPosAppParam').datagrid({
				title:'参数模板明细',
				iconCls:'icon-save',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:true,
				url:'listTaskPosAppParam.do',
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
		    {title:'参数组',field:'GROUP_NAME',align:'center',width:90,sortable:true},
			{title:'参数项编码',field:'PARAM_ID',align:'center',width:80,sortable:true},
			{title:'参数名称',field:'PARAM_NAME',align:'center',width:150,sortable:true},
			{title:'参数长度',field:'VALUE_LEN',align:'center',width:70,sortable:true},
			{title:'参数值',field:'PARAM_VALUE',align:'center',width:260,editor:"text"},
			{title:'操作',field:'oper',align:'center',width:80,formatter:function(value,rowData,rowIndex){
						return '<input id="del" type="button" class="btn_grid" value="删除" onclick="javascript:delTaskParamDetail(\''+rowData.KEYID+'\')\"/>'
						;
						}}
				]],
				onClickCell:function(rowIndex, field, value){
					//alert('onclickCell'+lastIndex);//alert(value);
					$('#idTaskPosAppParam').datagrid('endEdit', lastIndex);
					if(field=='PARAM_VALUE'&&(validParamValueFlag||rowIndex==lastIndex)){//rowIndex==lastIndex用于防止编辑一行有问题，直接点另一行删除时，出现不能继续编辑的bug
						$('#idTaskPosAppParam').datagrid('beginEdit', rowIndex);
						lastIndex = rowIndex;
					}
				},
				onAfterEdit:function(rowIndex, rowData, changes){//参数值修改退出时,要能自动提交,不需点击更新按钮,只有一行数据时点其他列提交
					if(validParamValue(rowData,rowIndex)){//alert('commit:'+rowIndex);
						updateTaskParamDetail(rowData.KEYID);
					}
				}		
			});
			
			getParamGroup(param.APP_ID);

		});
		
		
  function validParamValueFail(rowIndex){
      $('#idTaskPosAppParam').datagrid('endEdit', lastIndex);
	  $('#idTaskPosAppParam').datagrid('beginEdit', rowIndex);
	  lastIndex = rowIndex;
	  validParamValueFlag = false;
  }
  //验证参数值
  function validParamValue(rowData,rowIndex) {
    var paramId = rowData.PARAM_ID;
    //参数配置中不允许配置商户号、终端号
    if(paramId=="01000001"||paramId=="01000005"){
    	msgShow("任务参数明细","终端号、商户号请在应用里修改!","info");
    	validParamValueFail(rowIndex);
    	return false;
    }
//    alert("paramValue="+form1.param_Value.value);
    var paramValue = Trim(rowData.PARAM_VALUE);
    if(paramValue==""){
    	msgShow("任务参数明细","请输入参数值","info");
    	validParamValueFail(rowIndex);
    	return false;
    }
    var i=paramValue.indexOf("]]");
    if(i>-1){
    	msgShow("任务参数明细","不能输入]]字符","info");
    	validParamValueFail(rowIndex);
    	return false;
    }
    var j=paramValue.indexOf("[]");
    if(j>-1){
    	msgShow("任务参数明细","不能输入[]字符","info");
    	validParamValueFail(rowIndex);
    	return false;
    }
    var k=paramValue.indexOf("{}");
    if(k>-1){
    	msgShow("任务参数明细","不能输入{}字符","info");
    	validParamValueFail(rowIndex);
    	return false;
    }
    var len=rowData.VALUE_LEN;
    if(getMaxLength(paramValue)>len){
      msgShow("任务参数明细","参数值长度不能大于参数长度！","info");
      validParamValueFail(rowIndex);
      return false;
    }
    
    var type = rowData.DATA_TYPE;
    if (type=="数字"){
    	if (!(/^\d+(\.\d+)?$/i.test(paramValue))){
    		msgShow("任务参数明细","参数值请输入数字","info");
    		validParamValueFail(rowIndex);
    		return false;
    	}
    }
    if(paramId=="12000017"){
    	if(paramValue.length<10){
    		msgShow("任务参数明细","TPDU参数必须大于等于10位","info");
    		validParamValueFail(rowIndex);
    		return false;
    	}
    }
    validParamValueFlag = true;
    return true;
}
  //增加参数项验证
  function checkParamItem() {
    var form1=$('#ff')[0]; 
	//var paramGroup=$('#idParamGroup').combobox('getValue');
	//if(paramGroup===""){
	//    	msgShow("任务参数明细","请选择参数组!","info");
	//    	return false;
	//}
    var paramId = $('#idParamId').combobox('getValue');
    var paramName = $('#idParamId').combobox('getText');
    if($.trim(paramId)===""){
    	msgShow("参数模板明细","请选择参数项!","info");
    	return false;
    }
    if(paramId==paramName){
		msgShow("任务参数明细","参数项不存在，不能自己手工输入!","info");
		return false;
    }
    
    //参数配置中不允许配置商户号、终端号
    if(paramId=="01000001"||paramId=="01000005"){
    	msgShow("任务参数明细","终端号、商户号请在应用里添加!","info");
    	return false;
    }
//    alert("paramValue="+form1.param_Value.value);
    var paramValue = Trim(form1.PARAM_VALUE.value);
    if(paramValue==""){
    	msgShow("任务参数明细","请输入参数值","info");
    	return false;
    }
    var i=paramValue.indexOf("]]");
    if(i>-1){
    	msgShow("任务参数明细","不能输入]]字符","info");
    	return false;
    }
    var j=paramValue.indexOf("[]");
    if(j>-1){
    	msgShow("任务参数明细","不能输入[]字符","info");
    	return false;
    }
    var k=paramValue.indexOf("{}");
    if(k>-1){
    	msgShow("任务参数明细","不能输入{}字符","info");
    	return false;
    }
    var len=Trim(form1.valueLen.value);
    if(getMaxLength(form1.PARAM_VALUE.value)>len){
      msgShow("任务参数明细","参数值长度不能大于参数长度！","info");
      form1.PARAM_VALUE.focus();
      return false;
    }
    
    var type = Trim(form1.dataType.value);
    if (type=="数字"){
    	if (!(/^\d+(\.\d+)?$/i.test(paramValue))){
    		msgShow("任务参数明细","参数值请输入数字","info");
    		return false;
    	}
    }
    if(paramId=="12000017"){
    	if(paramValue.length<10){
    		msgShow("任务参数明细","TPDU参数必须大于等于10位","info");
    		return false;
    	}
    }
    //alert(paramValue);
    //paramValue =paramValue.replace(/&/g,"]]");
    //paramValue =encodeURIComponent(paramValue);
     paramValue= escape(paramValue);
     form1.PARAM_VALUE_ENCODING.value = paramValue;//解决中文乱码问题
    return true;
}
		//为参数模板增加参数项
		function addTaskParamDetail(){
			//乱码
			var tmsModuleTitle= $("#idTmsModuleTitle").val();
			tmsModuleTitle = escape(tmsModuleTitle);
			$("#idTmsModuleTitle").val(tmsModuleTitle);
			
			$('#ff').form('submit',{
		        url:'addTaskPosAppParam.do',
			    onSubmit:function(){
			        //return $(this).form('validate');
			        return checkParamItem();
			    },
			    success:function(data){
			    //{"status":"true","paramItem":{"DESC_TXT":"主机IP|主机端口(127.0.0.1|10001)","PARAM_GROUP":"12","DEF_VALUE":"127.0.0.1|10001","PARAM_NAME":"以太网通讯参数","PARAM_ID":"20000002","DATA_TYPE":"0","VALUE_LEN":80}}
			    
			      var myObject = eval('(' + data + ')');
			       //这种方式直接关闭窗口，返回true或者false给主窗口
			       // window.close();
			       // window.returnValue=myObject.status; 
			        
			        //这种错误情况下方式不关闭窗口	 
			       if(myObject.status=="true"){
						$('#idTaskPosAppParam').datagrid('load');//该方式多查询数据库
			        }else if(myObject.status=="false"){
			        	msgShow("新增","新增失败","error");
			        	//window.close();
			        }
			        $('#PARAM_VALUE').val('');
			        $('#idParamGroup').combobox('select',$('#idParamGroup').combobox('getValue'));//添加成功后重新加载参数项列表
			    }
			});
			
			//乱码
			tmsModuleTitle = unescape(tmsModuleTitle);
			$("#idTmsModuleTitle").val(tmsModuleTitle);
		}

		//获取参数组数据
		function getParamGroup(appId){
			$('#idParamGroup').combobox({
				//url:'core/paramitem/getParamGroup.jsp',
				url:'getParamGroup.do?APP_ID='+appId,
				valueField:'ITEMCODE',
				textField:'ITEMTEXT',
				onLoadSuccess:function(){//默认选中值
					var value = $('#idParamGroup').combobox('getData')[0].ITEMCODE;//alert(value);
					$('#idParamGroup').combobox('select',value);
				},
				onSelect:function(record){//根据参数组获取参数项数据
					var taskSysId=$('#idTaskSysId').val();
					var appId=$('#idAppId').val();//alert(taskSysId+","+appId);alert();
					var url = 'queryParamItemNotInTaskPosAppParam.do?PARAM_GROUP='+record.ITEMCODE+'&TASK_SYS_ID='+taskSysId+'&APP_ID='+appId;
					$('#idParamId').combobox({
						url:url,
						valueField:'PARAM_ID',
						textField:'PARAM_NAME',
						onSelect:function(rec){//根据参数项填充 参数类型、参数长度、参数值
							var form1=$('#ff')[0]; 
							form1.PARAM_VALUE.value=rec.DEF_VALUE;
							if(rec.DEF_VALUE==null){
								form1.PARAM_VALUE.value='';
							}
							form1.valueLen.value=rec.VALUE_LEN;
							form1.dataType.value=rec.DATA_TYPE;
							var showValue="("+rec.DATA_TYPE+"/"+rec.VALUE_LEN+")";
							$("#idShowTypeAndLen").html(showValue);
						}
					});
				}	
			});
		};

	//修改任务参数明细
	function updateTaskParamDetail(keyid){
		$('#idTaskPosAppParam').datagrid('acceptChanges');//使修改的值生效
		var rows = $('#idTaskPosAppParam').datagrid('getRows');//返回当前页的行
		for(var i=0;i<rows.length;i++){
			if(rows[i].KEYID===keyid){
				//{"TASK_SYS_ID":rows[i].TASK_SYS_ID,"APP_ID":rows[i].APP_ID,"PARAM_ID":rows[i].PARAM_ID,"PARAM_VALUE":rows[i].PARAM_VALUE}
				var tmsModuleTitle= $("#idTmsModuleTitle").val();
   				var tmsModuleId= $("#idTmsModuleId").val();
   				rows[i].tmsModuleTitle=tmsModuleTitle;
   				rows[i].tmsModuleId=tmsModuleId;
				$.post('updateTaskPosAppParam.do',rows[i] ,function(data) {
					
				});
				break;
			}
		}
	
	}
	
	//删除任务参数明细
	function delTaskParamDetail(keyid){//alert(keyid);
		var rows = $('#idTaskPosAppParam').datagrid('getRows');//返回当前页的行
		for(var i=0;i<rows.length;i++){
			if(rows[i].KEYID===keyid){
			    if(rows[i].PARAM_ID=="01000001"||rows[i].PARAM_ID=="01000005"){
			    	msgShow("任务参数明细","终端号、商户号请在应用里删除!","info");
			    	return false;
			    }
			//alert(i);
			//alert(rows[i].TASK_SYS_ID);alert(rows[i].APP_ID);
			//{"TASK_SYS_ID":rows[i].TASK_SYS_ID,"APP_ID":rows[i].APP_ID,"PARAM_ID":rows[i].PARAM_ID}
				var tmsModuleTitle= $("#idTmsModuleTitle").val();
   				var tmsModuleId= $("#idTmsModuleId").val();
   				rows[i].tmsModuleTitle=tmsModuleTitle;
   				rows[i].tmsModuleId=tmsModuleId;
				$.post('delTaskPosAppParam.do',rows[i] ,function(data) {
					//var index = $('#idTaskPosAppParam').datagrid('getRowIndex', rows[i]);
					//$('#idTaskPosAppParam').datagrid('deleteRow', index);
					msgShow("删除","删除成功!","info");
					$('#idTaskPosAppParam').datagrid('load');
					$('#idParamGroup').combobox('select',$('#idParamGroup').combobox('getValue'));//添加成功后重新加载参数项列表
				});
				break;
			}
		}
	
	}	
