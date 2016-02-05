	$(function(){
		  var k=window.dialogArguments; 
		  if(!k.par){
          	return ;
          }
		  var param = k.par;
		 $('#idRegId').val(param.REG_ID);
		 $('#idRegName').val(param.REG_NAME);
		 $('#idRegEntireId').val(param.REG_ENTIRE_ID);
		 if(param.batchFlag){
			 $('#idBatchFlag').val(param.batchFlag);
		 }
		 	
		  $('#idAposInfo').datagrid({
				title:'应用终端列表',
				iconCls:'icon-save',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:true,
				url:'listAposInfoForTask.do',
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
			{title:'应用终端号',field:'APOS_ID',align:'center',width:80,sortable:true},
			{title:'分支机构',field:'REG_NAME',align:'center',width:220,sortable:true},
			{title:'主应用商户',field:'MERCH_NAME',align:'center',width:120,sortable:true,formatter:function(value,rowData,rowIndex){
					if(!value){
						return rowData.MERCH_ID;
					}
					return value;
	             }},
			{title:'主应用终端',field:'TERMINAL_ID',align:'center',width:85,sortable:true},
			{title:'主机型号',field:'MID',align:'center',width:90,sortable:true},
			{title:'硬件序列号',field:'SERIAL_NO',align:'center',width:100,sortable:true},
			{title:'上次报到时间',field:'LAST_SIGN_TIME',align:'center',width:100,sortable:true},
			{title:'下次报到时间',field:'NEXT_SIGN_TIME',align:'center',width:100,sortable:true},
			{title:'布放地址',field:'APOS_ADDR',align:'center',width:100,sortable:true}
				]]
			});
		  
		  initDataForModelInfo('idFidSelect,idAppId');
		  
			//初始化数据
			function initDataForModelInfo(param){
			     $.ajax({
				   type: "POST",
				   url: "initDataForBatchParams.do",
				   data: "param="+param, //参数可以是idFidSelect,idMidSelect,idDllDir
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
				     if(data.idMidSelect){ //对idMidSelect(主机型号）进行赋值
					     for(var i = 0 ; i< data.idMidSelect.length; i++){
					        option=new Option(data.idMidSelect[i].MID_NAME,data.idMidSelect[i].MID);                       
	                        document.getElementById("idMidSelect").options.add(option);
					     }
					 } 
				     if (data.idAppId) {
						$.each(data.idAppId, function(idx, item) {
							// option += "<option value=" + data.idOrgId[i].ORG_ID +">"
							// + data.idOrgId[i].ORG_NAME+ "</option>";
							option = new Option(item.APP_NAME, item.APP_ID);
							document.getElementById("idAppId").options.add(option);
						});
					 }
				   } 
				  }); 
			}
		  
		});
		
