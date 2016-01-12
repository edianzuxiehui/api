	$(function(){
		
			$('#idRecycleTrace').datagrid({
				iconCls:'icon-save',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:true,
				url:'listAposChangeTrace.do?CHANGE_REMOVE_FLAG=2090',//2表示的撤机操作
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
			{title:'应用终端号',field:'APOS_ID',align:'center',width:100,sortable:true, formatter:function(value,rowData,rowIndex){ 
					    var data='<a style="color:blue;" href="javascript:showAposInfo('+rowData.APOS_ID+')\">'+rowData.APOS_ID+'</a>';
                        return data;  
                    }},
			{title:'撤机完成时间',field:'CREATE_DATE',align:'center',width:150,sortable:true},
			{title:'原硬件序列号',field:'OLD_SERIAL_NO',align:'center',width:100,sortable:true},
			{title:'原主机型号',field:'OLD_MID',align:'center',width:100,sortable:true},
			{title:'商户编码',field:'MERCH_ID',align:'center',width:150,sortable:true},
			{title:'终端号',field:'TERMINAL_ID',align:'center',width:150,sortable:true},
			{title:'终端号',field:'APP_ID',align:'center',width:150,sortable:true,hidden:true},
			{title:'分支机构',field:'REG_NAME',align:'center',width:300,sortable:true}
				]],
				toolbar:[{
					text:"修改主应用终端号",
					iconCls:'icon-edit',
					handler:updateTermin
				}]
			});
			
			initDataForModelInfo('idFidSelect');
			//初始化数据
			function initDataForModelInfo(param){
			     $.ajax({
				   type: "POST",
				   url: "initDataForModelInfo.do",
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
					
				   } 
				  }); 
			}
		});
	
	function updateTermin(){
		 var  isSuperAdmin = $("#isSuperAdmin").val();
         if(isSuperAdmin == "true"){
  		   
           var rows = $('#idRecycleTrace').datagrid('getSelections');
        	var ids;
	        var fields=null;
		    var num = rows.length;
	        if(num < 1){
		    	msgShow('提示消息','请选择你要修改的应用终端!','info');
		    	return;
	        } else if(num>1){
	    	  msgShow('提示消息','只能对一条应用终端信息进行修改!','info');
	    	  return;
	        }else{
	        	var param=rows[0].TERMINAL_ID;
	         	var aposId=rows[0].APOS_ID;
	        	var appId=rows[0].APP_ID;
	        	var merchId=rows[0].MERCH_ID;
	        	var retValue=openDialogFrame(getRootPath()+"/core/aposinfo/AposTerminalModif.jsp",param,"300","100");
	        	var tmsModuleId = "0";
	        	var tmsModuleTitle = "撤机明细查询";
	        	//setModuleNameAndId();
	   
	        	
	        	if(retValue){
	           		$.getJSON(getRootPath()+'/modifyTerminalInfo.do?tmsModuleTitle='+escape(escape(tmsModuleTitle)),
	        				{aposId:aposId, appId:appId, terminalId:retValue, merchId:merchId,tmsModuleId:tmsModuleId},
	        				function(data) {
	        					//showProcess(false);
	        					if(data!=null) {
	        						if(data.status!=null && data.status=='true') {
	        							msgShow('提示','修改成功！','info');
	        							//刷新应用终端应用明细列表
	        							$('#idRecycleTrace').datagrid('options').url="listAposChangeTrace.do?CHANGE_REMOVE_FLAG=2090";
	        							$('#idRecycleTrace').datagrid('load');
	        							
	        							//$('#idFlag').val('true');
	        						}else{
	        							msgShow('提示',data.message,'error');
	        						}
	        					}
	        				}
	        			);
	        	}
	        }
	       
	       
         }else{
        	 msgShow("没有权限","只有超级管理才能做次此操作!","error");  
         }
		
	}
	
   function delTermin(){
	   var  isSuperAdmin = $("#isSuperAdmin").val();
       if(isSuperAdmin == "true"){
      	 
       }else{
    	   msgShow("没有权限","只有超级管理才能做次此操作!","error");  
       }
		
	}
		
		
		function showAposInfo(APOS_ID){
	  
	      var retValue=openDialogFrame(getRootPath()+"/core/aposinfo/AposInfo-view.jsp","APOS_ID="+APOS_ID,"850","450");
	   }
