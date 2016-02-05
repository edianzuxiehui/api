	$(function(){
		var operRegId;//登录人员regId
			$('#idParamModel').datagrid({
				//title:'参数模板管理',
				iconCls:'icon-save',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:true,
				url:'listParamModel.do',//core/parammodel/data.json
				//sortName: 'REG_NAME',
				//sortOrder: 'desc',
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
			{title:'参数模板编号',field:'PARAM_MODEL_ID',align:'center',width:85,sortable:true},
			{title:'参数模板名称',field:'PARAM_MODEL_NAME',align:'center',width:130,sortable:true},
			//{title:'模板状态',field:'MODEL_STATUS',align:'center',width:70,sortable:true},
			{title:'分支机构',field:'REG_NAME',align:'center',width:160,sortable:true,formatter:function(value,rowData,rowIndex){
				if(value){
					return value;
				}else{
					return rowData.REG_ID;
				}
			}},
			{title:'所属应用id',field:'APP_ID',align:'center',width:120,sortable:true,hidden:true},
			{title:'所属应用',field:'APP_NAME',align:'center',width:130,sortable:true},
			{title:'创建时间',field:'CREATE_TIME',align:'center',width:135,sortable:true},
			{title:'参数模板明细',field:'detail',align:'center',width:90,formatter:function(value,rowData,rowIndex){
						return '<input id="detail'+rowData.KEYID+'" type="button" class="btn_grid" value="详情查看" onclick="javascript:paramModelDefUpdate(\''
						+rowData.PARAM_MODEL_ID+'\',\''+rowData.APP_ID+'\',\''+rowData.REG_ID+'\')\"/>';//appId为00000000时，可能变成0，所以要加单引号
						//return '<div ><a id="detail" href="javascript:void(0)" class="easyui-linkbutton" onclick="javascript:paramModelDefUpdate('+rowData.PARAM_MODEL_ID+')\">明细</a></div>';
			}},
			{title:'参数文件导入',field:'fileimport',align:'center',width:120,formatter:function(value,rowData,rowIndex){
							return '<input id="fileimport'+rowData.KEYID+'" type="button" class="btn_grid" value="参数文件导入" onclick="javascript:importParamFile('+rowData.PARAM_MODEL_ID+','+rowData.REG_ID+')\"/>';
			}},
			{title:'操作',field:'oper',align:'center',width:150,formatter:function(value,rowData,rowIndex){
						return '<input id="copy'+rowData.KEYID+'" type="button" class="btn_grid" value="复制" '
						+'onclick="javascript:paramModelClone(\''+rowData.PARAM_MODEL_ID+'\',\''+rowData.APP_ID+'\')\"/>'
						+'&nbsp;&nbsp;'
						+'<input id="setDefault'+rowData.KEYID+'" type="button" class="btn_grid" value="设置默认" '
						+'onclick="javascript:setDefault(\''+rowData.PARAM_MODEL_ID+'\',\''+rowData.APP_ID+'\',\''+rowData.REG_ID+'\')\"/>';
						
			}},
			{title:'备注',field:'DESC_TXT',align:'center',width:100,sortable:true}				
				]],
				
			onLoadSuccess:function(data){
				//$.parser.parse();//防止formatter动态生成的linkbutton不能生效，且必须在enable、disable之前调用
				//if(isEditAuth()){
				//	$('a.easyui-linkbutton').linkbutton('enable');
				//}else{
				//	$('a.easyui-linkbutton').linkbutton('disable');
				//}
				//$('#detail').linkbutton('enable');//该按钮永远有效
				//getObjectProp(data.rows);
				for(var i = 0;i<data.rows.length;i++){
					var row = data.rows[i];
					if(isEditAuth()&&(data.operRegId===row.REG_ID)){
						$('#detail'+row.KEYID).attr('value','详情修改');
						$('#fileimport'+row.KEYID).attr('disabled',false);
					}else{
						$('#fileimport'+row.KEYID).attr('disabled',true);
					}
					if(isEditAuth()&& (data.operRegId===row.REG_ID||row.SHARE_FLAG=='1') ){//本机构及上级共享应用的模板 能够复制
						$('#copy'+row.KEYID).attr('disabled',false);
					}else{
						$('#copy'+row.KEYID).attr('disabled',true);
					}
					if(isEditAuth()&& (data.operRegId===row.REG_ID &&row.PARAM_MODEL_DEF_FLAG=='0') ){
						$('#setDefault'+row.KEYID).attr('disabled',false);
					}else{
						$('#setDefault'+row.KEYID).attr('disabled',true);
					}
				}
			}
			});
			
			if(!window.dialogArguments){//增加参数模板时
				initDataForDevAppFile('idAppId');
				initDate();
			}
			$(".import_toolbar").attr('disabled', true);
			$(".export_toolbar").attr('disabled', true);
		});
		
	
	//初始化应用下拉框	 
	function initDataForDevAppFile(param){
		    $.ajax({
			   type: "POST",
			   url: "initDataForDevAppFile.do",
			   data: "param="+param,       //idOrgId,idMerchStatus
			  success: function(data){
			    var option; 
			    //对idAppId进行赋值
			   if(data.idAppId){
			     $.each(data.idAppId,function(idx,item){ 
		            // option += "<option value=" + data.idOrgId[i].ORG_ID +">" + data.idOrgId[i].ORG_NAME+ "</option>";
			         option = new Option(item.APP_NAME,item.APP_ID);                       
                     document.getElementById("idAppId").options.add(option);
			     });
			    
			    //修改页面应用不可选
			    var k=window.dialogArguments;//alert(typeof(k.par));
				if(k&&k.par&&typeof(k.par)=='string'){//修改参数模板时
					$("#idAppId").val($("#idAppId1").val());//保证加载完后再设置值
					$("#idAppId").attr("disabled",true);
				}
			  }
			} 
		  }); 
		}
	
 //参数模板明细		
 function paramModelDefUpdate(paramModelId,appId,regId){
 	//alert(paramModelId+","+appId+","+regId);
 	var operRegId = $('#idParamModel').datagrid('getData').operRegId;//获取datagrid中的json数据
 	//alert(operRegId===regId);
    if(isEditAuth()&&(operRegId==regId)){//允许修改
    	var param={'PARAM_MODEL_ID':paramModelId,"APP_ID":appId};
  		var returnValue= openDialogFrame(getRootPath()+'/core/parammodeldetail/ParamModelDetail-index.jsp',param, 850, 600);
  		//alert(returnValue);
    }else{//只能查看
    	var param={'PARAM_MODEL_ID':paramModelId,"APP_ID":appId};
  		var returnValue= openDialogFrame(getRootPath()+'/core/parammodeldetail/ParamModelDetail-index-view.jsp',param, 600, 500);
  	}  
  }
  
  //操作,复制
  function paramModelClone(paramModelId,appId){
      var param={'cloneId':paramModelId,'cloneAppId':appId};
	  openDialogFrame(getRootPath()+'/core/parammodel/ParamModel-clone.jsp',param,"400","240");
	  $('#idParamModel').datagrid('load');
  }  
  function importParamFile(paramModelId,regId){//导入厂商参数文件
    //var param={'paramModelId':paramModelId,'regId':regId};//json方式使用;
	  //alert(tmsJ5ModuleTitle);
    var param = 'paramModelId='+paramModelId+'&regId='+regId+'&tmsModuleId='+tmsJ5ModuleId+'&tmsModuleTitle='+escape(escape(tmsJ5ModuleTitle));
  	var returnValue= openDialogFrame(getRootPath()+'/core/parammodel/importParamModelDetail.jsp',param,450,100);
	$('#idParamModel').datagrid('load');
  }
  
  /*设置默认参数模板*/
  function setDefault(paramModelId,appId,regId){
      $.messager.confirm("设置默认模板","是否要设置为默认模板?",function(r){
    	  if (!r) {
    		  return ;
    	  }
    	  var param={'paramModelId':paramModelId,'appId':appId,'regId':regId};
	  		$.post('setDefaultParamModel.do', param,function(data) {
				var myObject = eval('(' + data + ')');
				if(myObject.status=="true"){
					//window.close();//必须放在成功返回后，否则可能导致不能传递参数
				}else if(myObject.status=="false"){
				 	msgShow("设置默认模板",myObject.message,"error");
				}
		    	self.close();
		    	$('#idParamModel').datagrid('load');
			});	
     });
  }
  
	//验证是否有修改参数模板的权限，下级是不可以修改上级和同级的共享应用的参数模板
	function checkModifyParamModelAuthority(){
	  	var regId = $('#idParamModel').datagrid('getSelected').REG_ID;
		var flag = true;
		$.ajax({
		   type: "POST",
		   url: "checkModifyDevAppFileAuthority.do",
		   data: "REG_ID="+regId,  
		   async: false,    
		  success: function(data){
		          flag = data.authority;
		   } 
		  }); 
		 return flag;
	}  