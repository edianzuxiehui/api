	$(function(){
		  var k=window.dialogArguments; 
		  if(!k.par){
		  	msgShow("任务参数","传递参数为空!","err");
          	return ;
          }
		  	var param=k.par;//getObjectProp(param);
		  	$('#idTaskSysId').val(param.TASK_SYS_ID);
		  	$('#idAppId').val(param.APP_ID);
			var lastIndex;
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
	        {title:'参数组',field:'GROUP_NAME',align:'center',width:100,sortable:true},
			{title:'参数项编码',field:'PARAM_ID',align:'center',width:100,sortable:true},
			{title:'参数名称',field:'PARAM_NAME',align:'center',width:185,sortable:true},
			{title:'参数长度',field:'VALUE_LEN',align:'center',width:100,sortable:true},
			{title:'参数值',field:'PARAM_VALUE',align:'center',width:250,editor:"text"}
				]]			
			});
			
			
			 //if(param.APP_ID){//主界面或增加界面
				// getParamGroup(param.APP_ID);
			// }
			
			initDataForParamInfo(param.APP_ID);
			 
			
		});
	
	
	
	//初始化数据
	function initDataForParamInfo(appId){
	     $.ajax({
		   type: "POST",
		   url: "getParamGroup.do?FLAG=1",
		   data: "APP_ID="+appId, //参数可以是idFidSelect,idMidSelect,idDllDir
		   success: function(data){ 
		     if(data){//对idFidSelect(厂商）进行赋值
		    	 var json = eval('(' + data + ')');
		    	 var option;
			     
			     for(var i = 0 ; i< json.length; i++){
			        option  = new Option(json[i].ITEMTEXT,json[i].ITEMCODE);                       
                    document.getElementById("idParamGroup").options.add(option);
                  //  option += "<option value=" + data.idFidSelect[i].FID +">" + data.idFidSelect[i].F_NAME+ "</option>";
			     }
			     //$("#idFidSelect").append(option);
		     }
		   } 
		  }); 
	}
	
	
	
	function changeParamByGroup(paramGroup){
		if(paramGroup==""){
			 $("#idParamId").empty();
		}else{
	     $.ajax({
			   type: "POST",
			   url: "queryParamItem.do",
			   data: "PARAM_GROUP="+paramGroup, //参数可以是idFidSelect,idMidSelect,idDllDir
			   success: function(data){ 
			     if(data){//对idFidSelect(厂商）进行赋值
			    	 var json = eval('(' + data + ')');
			    	 var option;
			    	  $("#idParamId").empty();
				     for(var i = 0 ; i< json.length; i++){
				        option  = new Option(json[i].PARAM_NAME,json[i].PARAM_ID);                       
	                    document.getElementById("idParamId").options.add(option);
	                  //  option += "<option value=" + data.idFidSelect[i].FID +">" + data.idFidSelect[i].F_NAME+ "</option>";
				     }
				     //$("#idFidSelect").append(option);
			     }
			   } 
			  }); 
	     
	 }
		
	}
	
		//获取参数组数据
		function getParamGroup(appId){
			$('#idParamGroup').combobox({
				//url:'core/paramitem/getParamGroup.jsp',
				url:'getParamGroup.do?FLAG=1&APP_ID='+appId,
				valueField:'ITEMCODE',
				textField:'ITEMTEXT',
				onLoadSuccess:function(){//默认选中值
					//alert(q);
					var value = $('#idParamGroup').combobox('getData')[0].ITEMCODE;//alert(value);
					$('#idParamGroup').combobox('select',value);
				},
				onSelect:function(record){//根据参数组获取参数项数据
					var value = record.ITEMCODE;
					if(value==''){
						$('#idParamId').combobox('loadData',new Array());
					}else{
						$('#idParamId').combobox({
							url:'queryParamItem.do?PARAM_GROUP='+record.ITEMCODE,
							valueField:'PARAM_ID',
							textField:'PARAM_NAME'
						});
					}
				}	
			});
		};