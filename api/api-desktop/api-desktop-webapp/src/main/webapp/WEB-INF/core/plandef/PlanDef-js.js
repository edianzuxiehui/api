	$(function(){
		
			$('#idPlanDef').datagrid({
				iconCls:'icon-save',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:true,
				url:'listPlanDef.do',
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
			{title:'计划编号',field:'PLAN_CODE',align:'center',width:100,sortable:true},
			{title:'计划名称',field:'PLAN_NAME',align:'center',width:200},
			{title:'创建日期',field:'CREATE_DATE',align:'center',width:150,sortable:true},
			{title:'计划状态',field:'STATUS_NAME',align:'center',width:100,sortable:true},
			{title:'有效时间',field:'VALID_DATE',align:'center',width:150,sortable:true},
			{title:'分支机构',field:'REG_NAME',align:'center',width:200,sortable:true},
			{title:'详细信息',field:'DESC_TXT',align:'center',width:180,formatter:function(value,rowData,rowIndex){
						//var myObject = eval(rowData); 
						//alert(rowData.PARAM_ID);
						//return '';
						//注意KEYID含特殊字符/，必须多加'处理
						var data='';
						data='<input id="iddetail" type="button" class="btn_grid" value="详情" onclick="javascript:showPlanAppInfo(\''+rowData.KEYID+'\')\"/>';
						 return data;
						}}
				]],
				rowStyler:function(rowIndex,rowData){
				if(rowData.PLAN_STATUS=="0"){
					return 'color:#FF0000;';
				}
			    }
			});
			
	
		});
		
		
		
		function showPlanAppInfo(sysid){
		//打开新窗口
		//alert(222);
		var retValue=openDialogFrame(getRootPath()+"/core/plandef/PlanDef-view.jsp",sysid,"800","600");
		
		}
		
		
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

		
		
		function changeAppVerInfo(appId){
			  // add by zz 去除应用版本与参数模版的备注提示 @2012年9月17日 14:34:26
			  document.getElementById("app_msg").innerHTML='';
			  document.getElementById("param_msg").innerHTML='';
			  $('#desc_msg').css('display','none');
			  
			  
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
			   
			   option = new Option("请选择应用模板","");
			   option1=new Option("空模板","T000000000");
			   document.getElementById("idparamodId").options.add(option);
			   document.getElementById("idparamodId").options.add(option1);
			   if(data.idparamodId){
			     $.each(data.idparamodId,function(idx,item){ 
			         option = new Option(item.PARAMMODEL_NAME,item.PARAM_MODEL_ID);  
                     document.getElementById("idparamodId").options.add(option);
			     });
			    }
			   } 
			  });
			  
			if($('#idAppId').val()=='00000000'){
			$('input[name="MASTER_APP_FLAG"]').get(1).checked = true;
			
			}else{
			$('input[name="MASTER_APP_FLAG"]').get(0).checked = true;
			}
			    
			  
		}	
		
		
		
		
		//新增应用的datagrid
		
		$(function(){
		     var parammodelId=$('#idPlanCode').val();
		     //alert(parammodelId);
			$('#idPlanAppInfo').datagrid({
				iconCls:'icon-save',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:true,
				url:'listPlanAppInfo.do',
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
			{title:'参数标志',field:'PARAM_FLAG',align:'center',width:60,sortable:true},
			{title:'应用标志',field:'APP_FLAG',align:'center',width:60,sortable:true},
			{title:'参数模板',field:'PARAM_MODEL_ID',align:'center',width:100,formatter:function(value,rowData,rowIndex){
			             var data="";
			             if(rowData.PARAM_MODEL_ID!=""&&rowData.PARAM_MODEL_ID!=null){
			          
			             data='<a id="modelId" style="color:blue;" href="javascript:paramModelDefUpdate(\''+rowData.PARAM_MODEL_ID+'\',\''+rowData.APP_ID+'\')\">'+rowData.PARAM_MODEL_ID+'</a>';
			             }
			             return data;
			             }},
			{title:'操作',field:'DESC_TXT',align:'center',width:80,formatter:function(value,rowData,rowIndex){
						//var myObject = eval(rowData); 
						//alert(rowData.PARAM_ID);
						//return '';
						//注意KEYID含特殊字符/，必须多加'处理
						var data='';
						data='<input id="del" type="button" class="btn_grid" value="删除" onclick="javascript:delPlanAppInfo(\''+rowData.KEYID+'\')\"/>';
						 return data;
						}}
				]]
				
			});
			
	
		});
		
		//新增计划定义的应用明细
		function addPlanAppInfo(){
		  if(checkform()){
			$('#ffdetail').form('submit',{
		        url:'addPlanAppInfo.do',
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
			        	 window.returnValue=myObject.status; 
			        	 $('#idPlanAppInfo').datagrid('reload',{PLAN_CODE:$('#idPlanCode').val()});
			        	 
			        	 $("#idAppId").val("");
			        	 $("#idAppVer").empty();
			        	 option = new Option("请选择应用版本","");
			             document.getElementById("idAppVer").options.add(option);
			              $("#idparamodId").empty();
			              option = new Option("请选择应用模板","");
			               document.getElementById("idparamodId").options.add(option);
			        	 //$("#idAppVer").val("");
			        	// $("#idparamodId").val("");
			        	$("#idUpdateDate").val('0000-00-00 00:00:00'); 
			        	 $("#idChangePlanStatus").val("1");
			        	 
			        	 // add by zz 去除应用版本与参数模版的备注提示 @2012年9月17日 14:30:46
			        	 document.getElementById("app_msg").innerHTML='';
			        	 document.getElementById("param_msg").innerHTML='';
			        	 $('#desc_msg').css('display','none');
			        	 
			        	 msgShow("新增","新增计划应用成功","info");
			        }else if(myObject.status=="false"){
			        	msgShow("新增",myObject.message,"error");
			        	//window.close();
			        }
			    }
			});
			}
		}
		


		
		
	     function paramModelDefUpdate(paramModelId,appId){
	            //alert(appId);
		    	//var param={'PARAM_MODEL_ID':paramModelId,"APP_ID":appId};
		  		//var returnValue= openDialogFrame('../parammodeldetail/ParamModelDetail-index.jsp',param, 800, 600);
		  		var param={'PARAM_MODEL_ID':paramModelId,"APP_ID":appId};
  		          var returnValue= openDialogFrame(getRootPath()+'/core/parammodeldetail/ParamModelDetail-index.jsp',param, 800, 600);
		  		//alert(returnValue);
		  }
		
		
	     function paramModelDefView(paramModelId,appId){
		    	var param={'PARAM_MODEL_ID':paramModelId,"APP_ID":appId};
		  		var returnValue= openDialogFrame(getRootPath()+'/core/parammodeldetail/ParamModelDetail-index-view.jsp',param, 600, 500);
		  		//alert(returnValue);
		  }
		
		
				//删除行记录
		function delPlanAppInfo(sysid){
				var rows = $('#idPlanAppInfo').datagrid('getRows');//返回当前页的行
				var tmsModuleTitle = escape(escape($("#idTmsModuleTitle").val()));
		        var tmsModuleId= $("#idTmsModuleId").val();
				for(var i=0;i<rows.length;i++){
					if(rows[i].KEYID===sysid){
					    var parm=sysid.split("/");
						$.post('delPlanAppInfo.do?tmsModuleTitle='+tmsModuleTitle, {"PLAN_CODE":parm[0],"APP_ID":parm[1],"tmsModuleId":tmsModuleId},function(data) {
							var index = $('#idPlanAppInfo').datagrid('getRowIndex', rows[i]);
							$('#idPlanAppInfo').datagrid('deleteRow', index);
							$("#idChangePlanStatus").val("1");
				        	 $("#idAppId").val("");
					        	 $("#idAppVer").empty();
					        	 option = new Option("请选择应用版本","");
					             document.getElementById("idAppVer").options.add(option);
					              $("#idparamodId").empty();
					              option = new Option("请选择应用模板","");
					               document.getElementById("idparamodId").options.add(option);
				        	 $("#idAppId").attr('disabled',false);	
				        	 $("#idvposModelMod").attr('disabled',true);
		                     $("#idvposModelAdd").attr('disabled',false);					
							//msgShow("删除","删除成功!","info");
						});
						break;
					}
				}
		
		}
		
		//修改行记录
		
		function modPlanAppInfoedit(sysid){
		var rows = $('#idPlanAppInfo').datagrid('getRows');//返回当前页的行
		$("#idvposModelMod").attr('disabled',false);
		$("#idvposModelAdd").attr('disabled',true);
				for(var i=0;i<rows.length;i++){
					if(rows[i].KEYID===sysid){
					//alert(sysid);
					//alert(i);alert(rows[i].PARAM_MODEL_ID);alert(rows[i].PARAM_VALUE);
					$("#idkeyId").val(sysid);
					var par=sysid.split("/");
					$("#idAppId").val(par[1]);
					//$("#idhAppid").val(rows[i].APP_ID);
					changeAppVerInfo(rows[i].APP_ID);
					$("#idAppId").attr('disabled',true);
					$("#idAppVer").val(rows[i].APP_VER);
					$("#idparamodId").val(rows[i].SRC_PARAM_MODEL_ID);
				    $("#idAppUpdateFlag").val((rows[i].APP_UPDATE_FLAG).trim());  
		            $("#idParamUpdateFlag").val((rows[i].PARAM_UPDATE_FLAG).trim()); 
		            $("#idUpdateDate").val((rows[i].UPDATE_DATE).trim());
		            $("#idSparamodId").val(rows[i].PARAM_MODEL_ID);
					$.each($("input[name='MASTER_APP_FLAG']"),function(){
		                if($(this).val()==rows[i].MASTER_APP_FLAG)
		                {
		                    $(this).attr("checked","checked");
		                }});
  
						break;
					}
				}
		
		}
		
		
				//更新页面的修改应用模板明细按钮
		function modPlanAppInfo(){
		    if(checkform()){
			 $('#ffdetail').form('submit',{
		        url:'updatePlanAppInfo.do',
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
			        //$("#idAppVer").val("");
					        	 $("#idAppVer").empty();
					        	 option = new Option("请选择应用版本","");
					             document.getElementById("idAppVer").options.add(option);
					              $("#idparamodId").empty();
					              option = new Option("请选择应用模板","");
					               document.getElementById("idparamodId").options.add(option); 
					$("#idUpdateDate").val('0000-00-00 00:00:00'); 
					
					// add by zz 去除应用版本与参数模版的备注提示 @2012年9月17日 14:34:26
			        document.getElementById("app_msg").innerHTML='';
			        document.getElementById("param_msg").innerHTML='';
			        $('#desc_msg').css('display','none');
					              	 
					$("#idvposModelMod").attr('disabled',true);
					$("#idvposModelAdd").attr('disabled',false);
		            $("#idAppId").attr('disabled',false);
			        $('#idPlanAppInfo').datagrid('reload',{PLAN_CODE:$('#idPlanCode').val()});
			        }else if(myObject.status=="false"){
			        	msgShow("新增",myObject.message,"error");
			        	//window.close();
			        }
			    }
			});
		  }
		}
		
		
		function checkform(){
		      if($("#idAppId").val()==""){
		      	msgShow("信息","请选择应用","info");
	           return false;
		      }
		      var masterflag=$('input[name="MASTER_APP_FLAG"][checked]').val();
		      //alert($('input[name="MASTER_APP_FLAG"][checked]').val());
	         if(masterflag=='1'&&$("#idAppUpdateFlag").val()=='4'){
	           msgShow("信息","主应用更新标志不能为删除","info");
	           return false;
	          }  
			 if($("#idAppId").val()=='00000000'&&$("#idAppUpdateFlag").val()=='4'){
			    msgShow("信息","多应用管理器应用更新标志不能为删除!","info");
				return false;
			  }
			 if($("#idAppUpdateFlag").val()=='0'&&$("#idParamUpdateFlag").val()!='1'){//应用不更新、参数必须新增
			    	msgShow("信息","应用不更新,则参数更新标志必须为新增!","info");
			    	return false;
			    }
			   if($("#idAppUpdateFlag").val()=='1'&&$("#idParamUpdateFlag").val()!='1'){//应用删除、参数必须删除
			    	msgShow("信息","应用更新,则参数更新标志必须为更新!","info");
			    	return false;
			    }  
			 
			 	if($("#idAppUpdateFlag").val()=='4'&&$("#idParamUpdateFlag").val()!='4'){//应用删除、参数必须删除
			    	msgShow("信息","应用删除,则参数更新标志必须为删除!","info");
			    	return false;
			    } 
			 
			 return true; 		 
		
		}
		
		
		function checkPlanStatus(){
		  		var param={PLAN_CODE:$('#idPlanCode').val()};
		  		//alert($("#idChangePlanStatus").val());
		  		//if($("#idChangePlanStatus").val()=="1"){
		         $.getJSON("checkPlanStatus.do",param,function(data){
		         //alert(data);
			      //var myObject = eval('(' + data + ')');
			      if(data.status=="true"){
						 window.close();
			        	 window.returnValue=data.status; 
			        }else if(data.status=="false"){
			        	//msgShow("新增",data.message,"error");
			        	window.close();
			        }
		          });
		//  } else{
		  // window.close();
		  //}
		
		
		}
		
	function checkmodright(ids){
		  var flag =false ;
		  $.ajax({
			   type: "POST",
			   async:false,
			   url: "checkPlanAssign.do",
			   data:ids , 
			   success: function(data){
			   var myObject = eval('(' + data + ')');
			   	if(myObject.status=="true"){
			   		flag = true;
			   	}else{
			   		flag = false;
			   	}
			   }
		 }); 
		 return flag;
		   
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
  		  

		function showAppMsg(){
			$('#desc_msg').css('display','block');
			var APP_ID = $('#idAppId').val();
			var APP_VER = $('#idAppVer').val();
			if(APP_VER==""){
				document.getElementById("app_msg").innerHTML='';
				if(document.getElementById("param_msg").innerHTML==''){
					$('#desc_msg').css('display','none');
				}
			}else{
				var param ="APP_ID=" + APP_ID+"&APP_VER=" + APP_VER;
				$.getJSON("queryAppVerInfo.do",param,function(data){
					if(data.rows[0].DESC_TXT==null){
						document.getElementById("app_msg").innerHTML='备注:该应用版本无备注';
					}else{
						document.getElementById("app_msg").innerHTML='备注:'+data.rows[0].DESC_TXT;
					}
					
				});
			}
			
		}
		
		function showParamMsg(){
			$('#desc_msg').css('display','block');
			var PARAM_MODEL_ID = $('#idparamodId').val();
			if(PARAM_MODEL_ID==""){
				document.getElementById("param_msg").innerHTML='';
				if(document.getElementById("app_msg").innerHTML==''){
					$('#desc_msg').css('display','none');
				}
			}else if(PARAM_MODEL_ID=="T000000000"){
				document.getElementById("param_msg").innerHTML='备注:选择的参数模版为空模版';
			}else{
				var param="PARAM_MODEL_ID="+PARAM_MODEL_ID;
				$.getJSON("queryParamModel.do",param,function(data){
					if(data.rows[0].DESC_TXT==null){
						document.getElementById("param_msg").innerHTML='备注:参数模版无备注';
					}else{
						document.getElementById("param_msg").innerHTML='备注:'+data.rows[0].DESC_TXT;
					}
					
				});
			}
			
		}
				
		
		