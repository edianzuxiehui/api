		//新增应用的datagrid
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
		initDataForDevAppFile('idAppId');//初始化应用列表	
		initFidData();
		defaultQueryReg1();
		});

		function defaultQueryReg1(){
			    $.ajax({
			   type: "POST",
			   url: "initDataForMerchInfo.do",
			   data: "param=idRegId,regEntireId",    
			    success: function(data){
			    if(data.idRegId&&data.regEntireId){
			       var str  = data.idRegId.split("(");
			       $("#idRegId").val(str[1].substring(0,str[1].length-1));
			       $("#idRegName").val(data.idRegId);
			       $("#idRegEntireId").val(data.regEntireId);
			       $("#idQueryRegId").val(str[1].substring(0,str[1].length-1));
			       $("#idQueryRegName").val(data.idRegId);
			       $("#idQueryRegEntireId").val(data.regEntireId);
			    }
			   } 
			  }); 
		}		
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
                    document.getElementById("idQueryAppId").options.add(option);
			     });
			  }
			} 
		  }); 
		}
	function changeAppVerInfo(appId){
		if(!appId){
			$("#idQueryAppVer").empty();
			   option = new Option("请选择应用版本","");
			   document.getElementById("idQueryAppVer").options.add(option);
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
			   } 
			  }); 
		}		
		
	//初始化厂家型号数据，reffer to ModelInfo-js.js
	function initFidData(){
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
		   } 
		  }); 
	}		