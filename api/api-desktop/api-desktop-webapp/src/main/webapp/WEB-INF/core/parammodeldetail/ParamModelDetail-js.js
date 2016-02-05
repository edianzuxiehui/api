	var lastIndex;
	var validParamValueFlag = true;//用于防止一行编辑验证值有问题，点击其他行，出现2行可编辑
	$(function(){
		
		  var k=window.dialogArguments; 
		  var param=k.par;
		  if(param){
		  	$('#PARAM_MODEL_ID').val(param.PARAM_MODEL_ID);
		  	$('#APP_ID').val(param.APP_ID);
		  }else{
		  	msgShow("参数模板","传递参数为空!","err");
		  	return;
		  }
		  /*if(k.par){
		  	var param=k.par;//alert(param.PARAM_MODEL_ID);
		  	$('#PARAM_MODEL_ID').attr('value',param.PARAM_MODEL_ID);
		  	//alert($('#PARAM_MODEL_ID').val());
			$.getJSON("listParamModelDetail.do",param,function(data){//不能采用此方式,因为rows,page此时为空
				$.each(data.rows,function(idx,item){
					$('#idParamModelDetail').datagrid('appendRow',item);
				});
            }); 
            
         }*/
         
			$('#idParamModelDetail').datagrid({
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
				singleSelect: true,
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
			{title:'参数组',field:'GROUP_NAME',align:'center',width:100,sortable:true},
			{title:'参数项编号',field:'PARAM_ID',align:'center',width:80,sortable:true},
			{title:'参数名称',field:'PARAM_NAME',align:'center',width:180,sortable:true},
			{title:'参数数据类型',field:'DATA_TYPE',align:'center',width:90,sortable:true},
			{title:'参数长度',field:'VALUE_LEN',align:'center',width:60,sortable:true},
			{title:'参数值',field:'PARAM_VALUE',align:'center',width:203,editor:"text"},
			{title:'操作',field:'oper',align:'center',width:70,formatter:function(value,rowData,rowIndex){
						//var myObject = eval(rowData); 
						//alert(rowData.PARAM_ID);
						//return '';
						//注意KEYID含特殊字符/，必须多加'处理
						//return '<input id="update" type="button" class="btn_grid" value="更新" onclick="javascript:updateParamModelDetail(\''+rowData.KEYID+'\')\"/>'
						return '<input id="del" type="button" class="btn_grid" value="删除" onclick="javascript:delParamModelDetail(\''+rowData.KEYID+'\')\"/>'
						;
						}}
				]],
			toolbar:[{
					id:'btnBatchAddParamModelDetail',
					text:'手工批量增加参数',
					iconCls:'icon-ok',
					handler:function(){     
						batchAddParamModelDetail();
					}},
					{
						id:'btnBatchDelParamModelDetail',
						text:'批量删除参数',
						iconCls:'icon-remove',
						handler:function(){     
							batchDelParamModelDetail();
						}
				}],
				onClickCell:function(rowIndex, field, value){
					//alert('onclickCell'+lastIndex);//alert(value);
					$('#idParamModelDetail').datagrid('endEdit', lastIndex);
					if(field=='PARAM_VALUE'&&(validParamValueFlag||rowIndex==lastIndex)){//rowIndex==lastIndex用于防止编辑一行有问题，直接点另一行删除时，出现不能继续编辑的bug
						$('#idParamModelDetail').datagrid('beginEdit', rowIndex);
						lastIndex = rowIndex;
						$(".datagrid-editable-input").off();
						$(".datagrid-editable-input").keydown(function(e){
							if(e.which == 13){
								$('#idParamModelDetail').datagrid('endEdit', rowIndex);
							}
						})
					}
				},
				onAfterEdit:function(rowIndex, rowData, changes){//参数值修改退出时,要能自动提交,不需点击更新按钮,只有一行数据时点其他列提交
					if(validParamValue(rowData,rowIndex)){//alert('commit:'+rowIndex);
						updateParamModelDetail(rowData.KEYID);
					}
				}			
			});
			
			getParamGroup(param.APP_ID);

			//$('#dataType').validatebox({//要放到此位置 ,添加的时候为什么不会验证，页面添加也不会验证？？？  
			//	required:true  
			//});	
			
		});

  function validParamValueFail(rowIndex){
	  //alert(lastIndex+","+rowIndex);
      $('#idParamModelDetail').datagrid('endEdit', lastIndex);
	  $('#idParamModelDetail').datagrid('beginEdit', rowIndex);
	  lastIndex = rowIndex;
	  validParamValueFlag = false;
  }
  //验证参数值
  function validParamValue(rowData,rowIndex) {
    //参数配置中不允许配置商户号、终端号
    if(rowData.PARAM_ID=="01000001"||rowData.PARAM_ID=="01000005"){
    	msgShow("参数模板明细","终端号、商户号请在应用里修改!","info");
    	validParamValueFail(rowIndex);
    	return false;
    }
//    alert("paramValue="+form1.param_Value.value);
    var paramValue = Trim(rowData.PARAM_VALUE);
    if(paramValue==""&&rowData.PARAM_ID!="16000006"&&rowData.PARAM_ID!="16000007"){
    	msgShow("参数模板明细","参数值不能为空","info");
    	validParamValueFail(rowIndex);
    	return false;
    }
    var i=paramValue.indexOf("]]");
    if(i>-1){
    	msgShow("参数模板明细","不能输入]]字符","info");
    	validParamValueFail(rowIndex);
    	return false;
    }
    var j=paramValue.indexOf("[]");
    if(j>-1){
    	msgShow("参数模板明细","不能输入[]字符","info");
    	validParamValueFail(rowIndex);
    	return false;
    }
    var k=paramValue.indexOf("{}");
    if(k>-1){
    	msgShow("参数模板明细","不能输入{}字符","info");
    	validParamValueFail(rowIndex);
    	return false;
    }
    var len=rowData.VALUE_LEN;
    //alert(paramValue);alert(paramValue.length);alert(rowData.VALUE_LEN);alert(getMaxLength(rowData.PARAM_VALUE));
    if(getMaxLength(paramValue)>len){//注意这里paramValue不能用rowData.PARAM_VALUE代替!!!!
      msgShow("参数模板明细","参数值长度不能大于参数长度！","info");
	  validParamValueFail(rowIndex);
      return false;
    }
    
    var type = rowData.DATA_TYPE;
    if (type=="数字"){
    	if (!(/^\d+(\.\d+)?$/i.test(paramValue))){
    		msgShow("参数模板明细","参数值请输入数字","info");
    		validParamValueFail(rowIndex);
    		return false;
    	}
    }
    if(rowData.PARAM_ID=="12000017"){
    	if(paramValue.length<10){
    		msgShow("参数模板明细","TPDU参数必须大于等于10位","info");
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
	//if($.trim(paramGroup)===""){
	//    	msgShow("参数模板明细","请选择参数组!","info");
	 //   	return false;
	//}
    var paramModelId = $('#paramModelId').val();
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
    	msgShow("参数模板明细","终端号、商户号请在应用里添加!","info");
    	return false;
    }
//    alert("paramValue="+form1.param_Value.value);
    var paramValue = Trim(form1.PARAM_VALUE.value);
    if(paramValue==""&&paramId!="16000006"&&paramId!="16000007"){
    	msgShow("参数模板明细","请输入参数值","info");
    	return false;
    }
    var i=paramValue.indexOf("]]");
    if(i>-1){
    	msgShow("参数模板明细","不能输入]]字符","info");
    	return false;
    }
    var j=paramValue.indexOf("[]");
    if(j>-1){
    	msgShow("","不能输入[]字符","info");
    	return false;
    }
    var k=paramValue.indexOf("{}");
    if(k>-1){
    	msgShow("参数模板明细","不能输入{}字符","info");
    	return false;
    }
    var len=Trim(form1.valueLen.value);
    if(getMaxLength(form1.PARAM_VALUE.value)>len){
      msgShow("参数模板明细","参数值长度不能大于参数长度！","info");
      form1.PARAM_VALUE.focus();
      return false;
    }
    
    var type = Trim(form1.dataType.value);
    if (type=="数字"){
    	if (!(/^\d+(\.\d+)?$/i.test(paramValue))){
    		msgShow("参数模板明细","参数值请输入数字","info");
    		return false;
    	}
    }
    if(paramId=="12000017"){
    	if(paramValue.length<10){
    		msgShow("参数模板明细","TPDU参数必须大于等于10位","info");
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
		function addParamModelDetail(){
			//乱码
			var tmsModuleTitle= $("#idTmsModuleTitle").val();
			tmsModuleTitle = escape(tmsModuleTitle);
			$("#idTmsModuleTitle").val(tmsModuleTitle);
			
			$('#ff').form('submit',{
		        url:'addParamModelDetail.do',
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
			       		//var item = myObject.paramItem;//参数项信息
			       		//var keyid=$('#PARAM_MODEL_ID').val()+'/'+item.PARAM_ID;
			       		//item.oper='';
			       		//item.oper='<input id="update" type="button" class="btn_grid" value="更新" onclick="javascript:updateParamModelDetail(\''+keyid+'\')\"/>'
						//+'<input id="del" type="button" class="btn_grid" value="删除" onclick="javascript:delParamModelDetail(\''+keyid+'\')\"/>';
						//$('#idParamModelDetail').datagrid('appendRow',item);//该方式少查询数据库，但会导致新增数据无法删除、修改，能否改进？？？
						$('#idParamModelDetail').datagrid('load');//该方式多查询数据库
			        }else if(myObject.status=="false"){
			        	msgShow("新增","新增失败","error");
			        	//window.close();
			        }
			        $('#PARAM_VALUE').val('');
			        $('#idParamGroup').combobox('select',$('#idParamGroup').combobox('getValue'));//添加成功后重新加载参数项列表
			        $('#idShowTypeAndLen').html('');
					}
			});
			
			//乱码
			tmsModuleTitle = unescape(tmsModuleTitle);
			$("#idTmsModuleTitle").val(tmsModuleTitle);
		}

		
		function batchDelParamModelDetail(){
			var obj=new Object();
			var paramModelId=$('#PARAM_MODEL_ID').val();
			obj.PARAM_MODEL_ID=paramModelId;
			var rows = $('#idParamModelDetail').datagrid('getSelections');
			var num = rows.length;
			var ids = null;
			var fields=null;
			if(num < 1){
				msgShow('提示消息','请选择你要删除的记录!','info');
			}else{
				$.messager.confirm('确认', '确定删除所选记录?', function(r){
					if (r) {
						for(var i = 0; i < num; i++){
							if(null == ids || i == 0){
								ids = $.trim(rows[i].PARAM_ID);
							} else {
							    ids = $.trim(ids) + "," + $.trim(rows[i].PARAM_ID);
							}
						}
						obj.PARAM_ID=ids;
						var tmsModuleTitle= $("#idTmsModuleTitle").val();
		   				var tmsModuleId= $("#idTmsModuleId").val();
		   				obj.tmsModuleTitle=tmsModuleTitle;
		   				obj.tmsModuleId=tmsModuleId;
						$.post('delParamModelDetail.do',obj,function(data) {
							$('#idParamModelDetail').datagrid('load');
							msgShow("删除","删除成功!","info");
						});
						
						
					
				   }
				});
				
				
			
		
			}
		}

		//批量为参数模板增加参数项
		function batchAddParamModelDetail(){
			var APP_ID = $('#APP_ID').val()
			var PARAM_MODEL_ID=$('#PARAM_MODEL_ID').val();//alert("PARAM_MODEL_ID:"+PARAM_MODEL_ID);
			var PARAM_GROUP=$('#idParamGroup').combobox('getValue');//alert("PARAM_GROUP:"+PARAM_GROUP);
			var ids = {"PARAM_MODEL_ID":PARAM_MODEL_ID,"PARAM_GROUP":PARAM_GROUP,"APP_ID":APP_ID};
			//var ids = {PARAM_MODEL_ID:123,PARAM_GROUP:2};
			var url=getRootPath()+'/core/parammodeldetail/ParamItem-index.jsp';
			var ret = openDialogFrame(url,ids,"850","600");//alert(ret);
			$('#idParamModelDetail').datagrid('load');
			getParamGroup(APP_ID);
				
		}				
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
					$('#idParamGroup').combobox('select',value);//使用select方法才能触发onSelect事件,setValue方法不行,$('#idParamGroup').combobox('setValue',value);
				},
				onSelect:function(record){//根据参数组获取参数项数据
					var PARAM_MODEL_ID=$('#PARAM_MODEL_ID').val();
					$('#idParamId').combobox({
						url:'queryParamItemNotInParamModelDetail.do?PARAM_GROUP='+record.ITEMCODE+'&PARAM_MODEL_ID='+PARAM_MODEL_ID,
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
							//form1.showTypeAndLen.innerHTML="xxxxxx";
							//"<label>"+rec.DATA_TYPE+"("+rec.VALUE_LEN+")"+"</lable>";
							
						}
					});
				}	
			});
		};

	//修改参数模板明细
	function updateParamModelDetail(keyid){
		$('#idParamModelDetail').datagrid('acceptChanges');//使修改的值生效
		var rows = $('#idParamModelDetail').datagrid('getRows');//返回当前页的行
		for(var i=0;i<rows.length;i++){
			if(rows[i].KEYID===keyid){
			//alert(i);alert(rows[i].PARAM_MODEL_ID);alert(rows[i].PARAM_VALUE);
			//{"PARAM_MODEL_ID":rows[i].PARAM_MODEL_ID,"PARAM_ID":rows[i].PARAM_ID,"PARAM_VALUE":rows[i].PARAM_VALUE};
			    var tmsModuleTitle= $("#idTmsModuleTitle").val();
   				var tmsModuleId= $("#idTmsModuleId").val();
   				rows[i].tmsModuleTitle=tmsModuleTitle;
   				rows[i].tmsModuleId=tmsModuleId;
				$.post('updateParamModelDetail.do', rows[i],function(data) {
					
				});
				break;
			}
		}
	
	}
	
	//删除参数模板明细
	function delParamModelDetail(keyid){//alert(keyid);
		var rows = $('#idParamModelDetail').datagrid('getRows');//返回当前页的行
		for(var i=0;i<rows.length;i++){
			if(rows[i].KEYID===keyid){
			    if(rows[i].PARAM_ID=="01000001"||rows[i].PARAM_ID=="01000005"){
			    	msgShow("参数模板明细","终端号、商户号请在应用里删除!","info");
			    	return false;
			    }
			//alert(i);alert(rows[i].PARAM_MODEL_ID);alert(rows[i].PARAM_VALUE);
			//{"PARAM_MODEL_ID":rows[i].PARAM_MODEL_ID,"PARAM_ID":rows[i].PARAM_ID};
				var tmsModuleTitle= $("#idTmsModuleTitle").val();
   				var tmsModuleId= $("#idTmsModuleId").val();
   				rows[i].tmsModuleTitle=tmsModuleTitle;
   				rows[i].tmsModuleId=tmsModuleId;
				$.post('delParamModelDetail.do',rows[i],function(data) {
					//var index = $('#idParamModelDetail').datagrid('getRowIndex', rows[i]);
					//$('#idParamModelDetail').datagrid('deleteRow', index);
					$('#idParamModelDetail').datagrid('load');
					msgShow("删除","删除成功!","info");
					$('#idParamGroup').combobox('select',$('#idParamGroup').combobox('getValue'));//添加成功后重新加载参数项列表
				});
				break;
			}
		}
	
	}
	
	
	
	
	
