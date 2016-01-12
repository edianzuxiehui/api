	$(function(){
		
			$('#idAposModel').datagrid({
				iconCls:'icon-save',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:true,
				url:'listAposModel.do',
				sortName: 'KEYID',
				sortOrder: 'desc',
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
			{title:'模板编号',field:'APOS_MODEL_ID',align:'center',width:200,sortable:true},
			{title:'模板名称',field:'APOS_MODEL_NAME',align:'center',width:200,sortable:true},
			{title:'分支机构',field:'REGNAME',align:'center',width:200,sortable:true},
			{title:'模板状态',field:'STATUS',align:'center',width:200,sortable:true},
			{title:'模板明细',field:'detail',align:'center',width:300,formatter:function(value,rowData,rowIndex){
						return '<input type="button" class="btn_grid" value="详细信息" onclick="javascript:aposmodel_detail(\''+rowData.APOS_MODEL_ID+'\')\ "/>';
						}}
				]],
				rowStyler:function(rowIndex,rowData){
				if(rowData.APOS_MODEL_STATUS=="0"){
					return 'color:#FF0000;';
				}
			    }
			});
			
	
		});
		
		
		function initData(param){
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
			    }
			   } 
			  }); 
			
		}
		
		function aposmodel_detail(aposmodelId){
		//alert(aposmodelId.valueOf());
		var param={'APOS_MODEL_ID':aposmodelId};
  		var returnValue= openDialogFrame(getRootPath()+"/core/aposmodel/AposModel-view.jsp",param,"650","400");
		}
		
		
		
		function changeAppVerInfo(appId){

			  
			
			
		   	   $.ajax({
			   type: "POST",
			   url: "listAppverForCombox.do",
			   data: "APP_ID="+appId, 
			   async:false,  
			  success: function(data){
			   var option;
			   $("#idAppVer").empty();
			   
			   option = new Option("请选择应用版本","");
			   document.getElementById("idAppVer").options.add(option);
			   
			   if(data!=null){
			   data=eval("("+data+")");
			    for(var i=0;i<data.length;i=i+1) {
			         option = new Option(data[i].APP_VER,data[i].APP_VER);  
                     document.getElementById("idAppVer").options.add(option);
			     }
			    }
			   } 
			  });
				
				
			  $.ajax({
			   type: "POST",
			   url: "getParamModuleName.do",
			   data: "APP_ID="+appId,
			   async:false, 
			  success: function(data){
			   var option;
			  $("#idparamodId").empty();
			   
			   option = new Option("请选择参数模板","");
			   document.getElementById("idparamodId").options.add(option);
			   
			   if(data.idparamodId){
			     $.each(data.idparamodId,function(idx,item){ 
			         option = new Option(item.PARAMMODEL_NAME,item.PARAM_MODEL_ID);  
                     document.getElementById("idparamodId").options.add(option);
			     });
			    }
			   } 
			  });
			  
			if($('#idAppId').val()=='00000000'){
			$('input[name="masterFlag"]').get(1).checked = true;
			}
			   
		}	
		
	//load param_model_detail
		$(function(){
		     var parammodelId=$('#idAposModelId').val();
			$('#idParamModeldetail').datagrid({
				iconCls:'icon-save',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:true,
				url:'listAposModelAppInfo.do?parammodelId='+parammodelId,
				sortName: 'KEYID',
				sortOrder: 'desc',
				remoteSort: false,
				idField:'KEYID',
				pageSize:10,
				pagination:false,
				rownumbers:true,
				frozenColumns:[[
	                {field:'ck',checkbox:true},
	                {field:'FIELDS',title:'FIELDS',hidden:true},
	                {title:'KEYID',field:'KEYID',hidden:true}
				]],
				columns:[[
			{title:'应用编号',field:'APP_ID',align:'center',width:100,sortable:true},
			{title:'应用名称',field:'APP_NAME',align:'center',width:100,sortable:true},
			{title:'主应用标志',field:'MASTER_FLAG',align:'center',width:100,sortable:true},
			{title:'应用版本',field:'APP_VER',align:'center',width:100,sortable:true},
			{title:'参数模板',field:'PARAM_MODEL_ID',align:'center',width:100,formatter:function(value,rowData,rowIndex){
			             data='<a id="modelId" style="color:blue;" href="javascript:paramModelDefUpdate(\''+rowData.PARAM_MODEL_ID+'\',\''+rowData.APP_ID+'\')\">'+rowData.PARAM_MODEL_ID+'</a>';
			             return data;
			             }},
			{title:'操作',field:'DESC_TXT',align:'center',width:100,formatter:function(value,rowData,rowIndex){
						//var myObject = eval(rowData); 
						//alert(rowData.PARAM_ID);
						//return '';
						//注意KEYID含特殊字符/，必须多加'处理
						var data='';
						if(rowData.APP_ID!='00000000'){
						data='<input id="del" type="button" class="btn_grid" value="删除" onclick="javascript:delModelInfoDetail(\''+rowData.KEYID+'\')\"/>';
						 }
						 return data
						;
						}}
				]]
			});
			
	
		});
		
		

		
		//删除行记录
		function delModelInfoDetail(sysid){
				var rows = $('#idParamModeldetail').datagrid('getRows');//返回当前页的行
				var tmsModuleTitle = escape(escape($("#idTmsModuleTitle").val()));
		        var tmsModuleId= $("#idTmsModuleId").val();
				for(var i=0;i<rows.length;i++){
					if(rows[i].KEYID===sysid){
					//alert(i);alert(rows[i].PARAM_MODEL_ID);alert(rows[i].PARAM_VALUE);
						$.post('delAposModelAppInfo.do?tmsModuleTitle='+tmsModuleTitle, {"SYS_ID":sysid,"tmsModuleId":tmsModuleId},function(data) {
							var index = $('#idParamModeldetail').datagrid('getRowIndex', rows[i]);
							$('#idParamModeldetail').datagrid('deleteRow', index);
                            $("#idvposModelMod").attr('disabled',true);
		                    $("#idvposModelAdd").attr('disabled',false);
		                 $("#idAppId").val("");
					        	 $("#idAppVer").empty();
					        	 option = new Option("请选择应用版本","");
					             document.getElementById("idAppVer").options.add(option);
					              $("#idparamodId").empty();
					              option = new Option("请选择应用模板","");
					               document.getElementById("idparamodId").options.add(option); 
							msgShow("删除","删除成功!","info");
						});
						break;
					}
				}
		
		}

		//更新页面删除
		function delUpModelInfoDetail(sysid){
				var rows = $('#idParamModeldetailedit').datagrid('getRows');//返回当前页的行
				var tmsModuleTitle = escape(escape($("#idTmsModuleTitle").val()));
		        var tmsModuleId= $("#idTmsModuleId").val();
				for(var i=0;i<rows.length;i++){
					if(rows[i].KEYID===sysid){
					//alert(i);alert(rows[i].PARAM_MODEL_sID);alert(rows[i].PARAM_VALUE);
						$.post('delAposModelAppInfo.do?tmsModuleTitle='+tmsModuleTitle, {"SYS_ID":sysid,"tmsModuleId":tmsModuleId},function(data) {
							var index = $('#idParamModeldetailedit').datagrid('getRowIndex', rows[i]);
							$('#idParamModeldetailedit').datagrid('deleteRow', index);
						    $("#idvposModelMod").attr('disabled',true);
		                    $("#idvposModelAdd").attr('disabled',false);
		                    $("#idAppId").attr('disabled',false);	
					     $("#idAppId").val("");
					        	 $("#idAppVer").empty();
					        	 option = new Option("请选择应用版本","");
					             document.getElementById("idAppVer").options.add(option);
					              $("#idparamodId").empty();
					              option = new Option("请选择应用模板","");
					               document.getElementById("idparamodId").options.add(option); 
							
							msgShow("删除","删除成功!","info");
						});
						break;
					}
				}
		
		}
		
		
		//更新页面点击grid的修改
		function updateModelInfoDetail(sysid){
		
		var rows = $('#idParamModeldetailedit').datagrid('getRows');//返回当前页的行
		$("#idvposModelMod").attr('disabled',false);
		$("#idvposModelAdd").attr('disabled',true);
				for(var i=0;i<rows.length;i++){
					if(rows[i].KEYID===sysid){
					$("#idSysId").val(sysid);
					$("#idAppId").val(rows[i].APP_ID);
					$("#idhAppid").val(rows[i].APP_ID);
					$("#idAppId").toggleClass("easyui-validatebox");
					changeAppVerInfo(rows[i].APP_ID);
					
					$("#idAppVer").val(rows[i].APP_VER);
					$("#idparamodId").val(rows[i].SRC_PARAM_MODEL_ID);
					$("#idSparamodId").val(rows[i].PARAM_MODEL_ID);
					$.each($("input[name='masterFlag']"),function(){
		                if($(this).val()==rows[i].MASTER_APP_FLAG)
		                {
		                    $(this).attr("checked","checked");
		                }
		            });
					/*
					if(rows[i].MASTER_APP_FLAG=="1"){
					$('input[name="masterFlag"]').attr("checked","1");
					}else{
					$('input[name="masterFlag"]').attr("checked","0");
					}*/
					$("#idAppId").attr('disabled',true);
						break;
						
					}
				}
		
		}
		
		
		//更新页面的修改应用模板明细按钮
		function modAposModelAppInfo(){
					$('#ffdetail').form('submit',{
		        url:'updateAposModelAppInfo.do',
			    onSubmit:function(){
			        return $(this).form('validate');
			    },
			    success:function(data){
			      var myObject = eval('(' + data + ')');
			       //这种方式直接关闭窗口，返回true或者false给主窗口
			       // window.close();
			       // window.returnValue=myObject.status; 
			        
			        //这种错误情况下方式不关闭窗口	 
			       if(myObject.status=="true"){
						 //window.close();
			        	 //window.returnValue=myObject.status; 
			        	 //刷新datagrid
			        $("#idvposModelMod").attr('disabled',true);
		            $("#idvposModelAdd").attr('disabled',false);
		            $("#idAppId").attr('disabled',false);
		            	 $("#idAppId").val("");
					        	 $("#idAppVer").empty();
					        	 option = new Option("请选择应用版本","");
					             document.getElementById("idAppVer").options.add(option);
					             $("#idparamodId").empty();
					             option = new Option("请选择应用模板","");
					             document.getElementById("idparamodId").options.add(option); 
			        	 $('#idParamModeldetailedit').datagrid('reload',{APOS_MODEL_ID:$('#idAposModelId').val()});
			        }else if(myObject.status=="false"){
			        	msgShow("新增",myObject.message,"error");
			        	//window.close();
			        }
			    }
			});
		
		
		}
		
		
		
		
		
	    function paramModelDefUpdate(paramModelId,appId){
		    	var param={'PARAM_MODEL_ID':paramModelId,"APP_ID":appId};
		  		var returnValue= openDialogFrame(getRootPath()+'/core/parammodeldetail/ParamModelDetail-index.jsp',param, 800, 600);
		  		//alert(returnValue);
		  }
		
		
	     function paramModelDefView(paramModelId,appId){
		    	var param={'PARAM_MODEL_ID':paramModelId,"APP_ID":appId};
		  		var returnValue= openDialogFrame(getRootPath()+'/core/parammodeldetail/ParamModelDetail-index-view.jsp',param, 600, 500);
		  		//alert(returnValue);
		  }
		
		//add posmodeldetail
		 function addAposModelAppInfo(){
		     

			$('#ffdetail').form('submit',{
		        url:'addAposModelAppInfo.do',
			    onSubmit:function(){
			        return $(this).form('validate');
			    },
			    success:function(data){
			      var myObject = eval('(' + data + ')');
			       //这种方式直接关闭窗口，返回true或者false给主窗口
			       // window.close();
			       // window.returnValue=myObject.status; 
			        
			        //这种错误情况下方式不关闭窗口	 
			       if(myObject.status=="true"){
						 //window.close();
			        	 //window.returnValue=myObject.status; 
			        	 //刷新datagrid
			        	 //initData('idAppId,idMid');
			        	 $("#idAppId").val("");
					        	 $("#idAppVer").empty();
					        	 option = new Option("请选择应用版本","");
					             document.getElementById("idAppVer").options.add(option);
					              $("#idparamodId").empty();
					              option = new Option("请选择应用模板","");
					               document.getElementById("idparamodId").options.add(option); 
			        	 $('#idParamModeldetail').datagrid('reload',{APOS_MODEL_ID:$('#idAposModelId').val()});
			        }else if(myObject.status=="false"){
			        	msgShow("新增",myObject.message,"error");
			        	//window.close();
			        }
			    }
			});
		}
		
		
		 //修改页面的增加操作
	  function addAposModelAppInfoedit(){
			if($("#idAppId").val()==""){
				msgShow("消息","请选择应用","info");
				} 
				
			else {		
					
			$('#ffdetail').form('submit',{
		        url:'addAposModelAppInfo.do',
			    onSubmit:function(){
			        return $(this).form('validate');
			    },
			    success:function(data){
			      var myObject = eval('(' + data + ')');
			       //这种方式直接关闭窗口，返回true或者false给主窗口
			       // window.close();
			       // window.returnValue=myObject.status; 
			        
			        //这种错误情况下方式不关闭窗口	 
			       if(myObject.status=="true"){
						 //window.close();
			        	 //window.returnValue=myObject.status; 
			        	 //刷新datagrid
			        	 $("#idAppId").val("");
					        	 $("#idAppVer").empty();
					        	 option = new Option("请选择应用版本","");
					             document.getElementById("idAppVer").options.add(option);
					              $("#idparamodId").empty();
					              option = new Option("请选择应用模板","");
					               document.getElementById("idparamodId").options.add(option); 
			        	 $('#idParamModeldetailedit').datagrid('reload',{APOS_MODEL_ID:$('#idAposModelId').val()});
			        }else if(myObject.status=="false"){
			        	msgShow("新增",myObject.message,"error");
			        	//window.close();
			        }
			    }
			});
		  }
		}
		
	    function checkAposModel(flag){
		var param={APOS_MODEL_ID:$('#idAposModelId').val(),FLAG:flag};
		$.getJSON("checkMasterAppInfo.do",param,function(data){
			      if(data.status=="true"){
						 window.close();
			        	 window.returnValue=myObject.status; 
			        }else if(data.status=="false"){
			        	msgShow("新增",data.message,"error");
			        }else {
			        window.close();
			        }
		
		  });
		}
		
		
		
		  function QueryReg(){
  			    $.ajax({
			   type: "POST",
			   url: "initDataForMerchInfo.do",
			   data: "param=idRegId,regEntireId",       //idOrgId,idMerchStatus
			    success: function(data){
			    if(data.idRegId&&data.regEntireId){
			       var str  = data.idRegId.split("(");
			       $("#idRegId").val(str[1].substring(0,str[1].length-1));
			       $("#idRegName").val(data.idRegId);
			       $("#idRegEntirId").val(data.regEntireId);
			        $("#sidRegEntirId").val(data.regEntireId);
			    }
			  
			   } 
			  }); 
  }
		
