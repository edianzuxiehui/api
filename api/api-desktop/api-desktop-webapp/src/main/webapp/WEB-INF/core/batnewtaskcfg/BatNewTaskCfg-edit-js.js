var processFlag =false;//用于控制进度条

		$(function(){
		     //var parammodelId=$('#idPlanCode').val();
		     //alert(parammodelId);
			$('#idTaskDetail').datagrid({
				iconCls:'icon-save',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:true,
				//url:'listPlanAppInfoForTask.do',//第一次进去无数据，不需要加载
				sortName: 'KEYID',
				sortOrder: 'desc',
				remoteSort: false,
				idField:'KEYID',
				//pageSize:20,
				//pagination:true,
				rownumbers:true,
				frozenColumns:[[
	                {field:'ck',checkbox:true},
	                {field:'FIELDS',title:'FIELDS',hidden:true},
	                {title:'KEYID',field:'KEYID',hidden:true}
				]],
				
				columns:[[
			{title:'应用编号',field:'APP_ID',align:'center',width:100,sortable:true},
			{title:'应用名称',field:'APP_NAME',align:'center',width:100,sortable:true},
			{title:'主应用标志',field:'MASTER_APP_FLAG',align:'center',width:100,sortable:true},
			{title:'应用版本',field:'APP_VER',align:'center',width:100,sortable:true},
			{title:'参数标志',field:'PARAM_UPDATE_FLAG',align:'center',width:60,sortable:true},
			{title:'应用标志',field:'APP_UPDATE_FLAG',align:'center',width:60,sortable:true},
			{title:'参数模板',field:'PARAM_MODEL_ID',align:'center',width:100,formatter:function(value,rowData,rowIndex){
			             data='<a id="modelId" style="color:blue;" href="javascript:paramModelDefView(\''+rowData.PARAM_MODEL_ID+'\')\">'+rowData.PARAM_MODEL_ID+'</a>';
			             return data;
			             }}
				]]
			});
					
			init();
		});
		
  function selectPlan(){//选择计划
		var regId = $('#idRegId').val();
		var regName = $('#idRegName').val();
		var regEntireId = $('#idRegEntireId').val();
		var param = {"REG_ID":regId,"REG_NAME":regName,"REG_ENTIRE_ID":regEntireId};
	  var retValue = openDialogFrame(getRootPath()+'/core/batnewtaskcfg/PlanDef-index.jsp',param,"800","650");   
	if(retValue!=undefined){
		$('#idPlanCode').val(retValue.planCode);
		$('#idPlanName').val(retValue.planName);
		
		$('#idTaskDetail').datagrid('options').url="listPlanAppInfoForTask.do?PLAN_CODE="+retValue.planCode;  	
		$('#idTaskDetail').datagrid('load');	
	}
  }
  		
  //选择策略
  function selectStrategy(){  
	var retValue = openDialogFrame(getRootPath()+'/core/taskinfo/Strategy-index.jsp','',"800","650");   
	if(retValue!=undefined){
		var plan = retValue.split("_");
		$('#idStrategyId').val(plan[0]);
	}	
  }
  	//查看计划的参数模板明细
   function paramModelDefView(paramModelId){//alert(paramModelId);
		var param={'PARAM_MODEL_ID':paramModelId};
		var returnValue= openDialogFrame(getRootPath()+'/core/parammodeldetail/ParamModelDetail-index-view.jsp',param, 1000, 600);
	}
		
	//初始化应用下拉框	 
	function initDataForDevAppFile(appId,appVer){
		    $.ajax({
			   type: "POST",
			   url: "initDataForDevAppFile.do",
			   data: "param=idAppId",       //idOrgId,idMerchStatus
			  success: function(data){
			    var option; 
			    //对idAppId进行赋值
			   if(data.idAppId){
			     $.each(data.idAppId,function(idx,item){ 
		            // option += "<option value=" + data.idOrgId[i].ORG_ID +">" + data.idOrgId[i].ORG_NAME+ "</option>";
			         option = new Option(item.APP_NAME,item.APP_ID);                       
                   document.getElementById("idQueryAppId").options.add(option);
			     });
			     if(appId){
			    	 $("#idQueryAppId").val(appId);
			     }
			     changeAppVerInfo(appId,appVer);
			  }
			} 
		  }); 
		}
	function changeAppVerInfo(appId,appVer){
		if(!appId){
			$("#idQueryAppVer").empty();
			option = new Option("请选择应用版本","");
			document.getElementById("idQueryAppVer").options.add(option);
			
		    if(processFlag){
		    	showProcess(false);//防止进度条一直存在
		    }
			processFlag = true;			   
			return false;
		}
		   $.ajax({
			   type: "POST",
			   url: "listAppverForCombox.do",
			   data: "APP_ID="+appId,       
			  success: function(data){
			   var option;
			   $("#idQueryAppVer").empty();
			   
			   option = new Option("请选择应用版本","");
			   document.getElementById("idQueryAppVer").options.add(option);
			   
			   if(data){
				   data=eval("("+data+")");
			     $.each(data,function(idx,item){ 
			         option = new Option(item.APP_VER,item.APP_VER);  
                     document.getElementById("idQueryAppVer").options.add(option);
			     });
			    }
			     if(appVer){
			    	 $("#idQueryAppVer").val(appVer);
			     }
		    	 if(processFlag){
		    		 showProcess(false);//防止进度条一直存在
		    	 }
		    	 processFlag = true;
			   } 
			  }); 
			
		}		
		
		
		function init(){
				 var k=window.dialogArguments; 
				 if(k&&k.par){//queryBatNewTaskCfg.do验证是否可以修改，所以要放在加载型号、厂家等信息前面
					 var updateParam=k.par;
				     $.ajax({
						   type: "POST",
						   url: "queryBatNewTaskCfg.do",
						   data:updateParam, //参数可以是idFidSelect,idMidSelect,idDllDir
						   beforeSend :function(){
							   	 var k=window.dialogArguments; 
								 if(k&&k.par){
							    	showProcess(true,"修改终端任务定制","加载终端任务定制信息中...");
							     }
							    },	
							    success: function(data){
						data = eval('(' + data + ')');
				       if(data.status && data.status=="false"){
				           $.messager.alert("修改",data.message,"error",function(){
				        		self.close();
				           });
				        	return false;
				        }
				      
				       //alert('1');alert(myObject.rows);
						$.each(data.rows,function(idx,item){
							$("#idTabNo").val($.trim(item.TAB_NO));
							$("#idRegId").val($.trim(item.REG_ID));
							$("#idRegEntireId").val($.trim(item.REG_ENTIRE_ID));
							$("#idRegName").val($.trim(item.REG_NAME));
							$("#idQueryRegId").val($.trim(item.QUERY_REG_ID));
							$("#idQueryRegEntireId").val($.trim(item.QUERY_REG_ENTIRE_ID));
							$("#idQueryRegName").val($.trim(item.QUERY_REG_NAME));
							$("#idQueryRegId").val($.trim(item.QUERY_REG_ID));
							$("#idStrategyId").val($.trim(item.STRATEGY_ID));
							$("#idPlanCode").val($.trim(item.PLAN_CODE));
							$("#idPlanName").val($.trim(item.PLAN_CODE));
				            					
							$('#idTaskDetail').datagrid('options').url="listPlanAppInfoForTask.do?PLAN_CODE="+item.PLAN_CODE;  	
							$('#idTaskDetail').datagrid('load');	
						});
						
						//初始化应用列表	
						var appId = data.rows[0].QUERY_APP_ID;
						var appVer = data.rows[0].QUERY_APP_VER;					
						initDataForDevAppFile(appId,appVer);
			            
						//初始化厂家型号
						var mid = data.rows[0].QUERY_MID;
						var fid = data.rows[0].QUERY_FID;
			            initFidData(fid,mid);
			            var beginSerial = data.rows[0].QUERY_BEGIN_SERIAL_NO;
						var endSerial = data.rows[0].QUERY_END_SERIAL_NO;
						$("#idQueryBeginSerialNo").val($.trim(beginSerial));
						$("#idQueryEndSerialNo").val($.trim(endSerial));
						//初始化通讯参数值
						var mode = data.rows[0].QUERY_CONTACT_TYPE;
						var ip = data.rows[0].QUERY_ADDRESS;
						var port = data.rows[0].QUERY_PORT;
						var mobile = data.rows[0].QUERY_MOBILE;
						$("#idMode").val(mode);
						$("#idIP").val(ip);
						$("#idPort").val(port);
						$("#idMobile").val(mobile);
					    }
					}); 
		         }
		}
		
		//初始化厂家型号数据，reffer to ModelInfo-js.js
		function initFidData(fid,mid){
			$.ajax({
			   type: "POST",
			   url: "initDataForModelInfo.do",
			   data: "param=idFidSelect", //参数可以是idFidSelect,idMidSelect,idDllDir
			   success: function(data){ 
			     if(data.idFidSelect){//对idFidSelect(厂商）进行赋值
				     var option;
				     for(var i = 0 ; i< data.idFidSelect.length; i++){
				        option  = new Option(data.idFidSelect[i].F_NAME,data.idFidSelect[i].FID);                       
	                   document.getElementById("idFidSelect").options.add(option);
	                 //  option += "<option value=" + data.idFidSelect[i].FID +">" + data.idFidSelect[i].F_NAME+ "</option>";
				     }
				     //$("#idFidSelect").append(option);
			     }
			     if(fid){
				    $("#idFidSelect").val(fid);
			     }
			     changeModelByFID(fid,mid);
			     } 
			  }); 
		}
		
        //根据厂商(FID)改变主机型号
        function changeModelByFID(fid,mid){
              if(fid==""){
               $("#idMidSelect").empty();
			    option = new Option("请选择主机型号","");
			    document.getElementById("idMidSelect").options.add(option);
               return;
              }
		   	   $.ajax({
			   type: "POST",
			   url: "getModelInfoByFID.do",
			   data: "FID="+fid,       
			  success: function(data){
				   var option;
				   $("#idMidSelect").empty();
				   
				   option = new Option("请选择主机型号","");
				   document.getElementById("idMidSelect").options.add(option);
				   
				   if(data.idMidSelect){
				     $.each(data.idMidSelect,function(idx,item){ 
				         option = new Option(item.MID_NAME,item.MID);  
	                    document.getElementById("idMidSelect").options.add(option);
				     });
				    }
				   if(mid){
					   $("#idMidSelect").val(mid);
				   }
			    	 if(processFlag){
			    		 showProcess(false);//防止进度条一直存在
			    	 }
			    	 processFlag = true;
			   } 
			  }); 
		}