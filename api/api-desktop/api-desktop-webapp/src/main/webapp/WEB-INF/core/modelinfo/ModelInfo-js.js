	$(function(){
	
	       // it.button.attr('disabled', dis);
	  
		   if(document.getElementById('idModelInfo')){
			$('#idModelInfo').datagrid({
				iconCls:'icon-save',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:true,
				url:'listModelInfo.do',
				sortName: 'KEYID',
				sortOrder: 'desc',
				remoteSort: false,
				idField:'KEYID',
				pageSize:10,
				pagination:true,
				rownumbers:true,
				onLoadSuccess:loadTest,
				frozenColumns:[[
	                {field:'ck',checkbox:true},
	                {field:'FIELDS',title:'FIELDS',hidden:true},
	                {title:'KEYID',field:'KEYID',hidden:true}
				]],
				columns:[[
			{title:'终端型号',field:'MID',align:'center',width:150,sortable:true},
			{title:'终端型号名称',field:'MID_NAME',align:'center',width:100,sortable:true},
			{title:'厂商',field:'F_NAME',align:'center',width:150,sortable:true},
			{title:'基本配置',field:'BASE_CONFIG',align:'center',width:150,sortable:true},
			{title:'可选配置',field:'OPT_CONFIG',align:'center',width:150,sortable:true},
			{title:'应用程序目录',field:'APP_DIR',align:'center',width:150,sortable:true},
			{title:'厂商DLL路径',field:'DLL_DIR',align:'center',width:240,sortable:true}
	
				]]
			});
			  //初始化数据
			  initDataForModelInfo('idFidSelect');
		   	$(".import_toolbar").attr('disabled', true);
			$(".export_toolbar").attr('disabled', true);
		   }	
		});
		
		function loadTest(){
		   $('#idModelInfo').datagrid("clearSelections");
		
		}
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
				 
				 if(data.idDllDir){//
				   $("#idDllDir").val(data.idDllDir);
				   $("#dllDirDefaultValue").val(data.idDllDir);
				}
				
			   } 
			  }); 
		}




		 $.extend($.fn.validatebox.defaults.rules, {
		     dllStart: {
		        validator: function (value, param) {
		            return $("#idDllDir").val().startWith(document.getElementById("dllDirDefaultValue").value);
		        },
		      message: function(){
		        return  'DLL路径需'+document.getElementById("dllDirDefaultValue").value+'开头';
		      }
		    },
	        ismodelChars : {// 请输字母数字-的组合！added by linjc
               validator : function(value) {
               return  /^[0-9a-zA-Z-]+$/i.test(value);
             },
              message : '请输字母数字-的组合！'
            }
		    
		  });
 
         //根据厂商(FID)改变主机型号
         function changeModelByFID(fid){
              
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
			   //记录用户所选择型号的值
			   var idMidSelect =  $("#idMidSelect").val();
			   
			   $("#idMidSelect").empty();
			   option = new Option("请选择主机型号","");
			   document.getElementById("idMidSelect").options.add(option);
			   
			   if(data.idMidSelect){
			     $.each(data.idMidSelect,function(idx,item){ 
			         option = new Option(item.MID_NAME,item.MID);  
                     document.getElementById("idMidSelect").options.add(option);
			     });
			    }
			    if(idMidSelect!=" "){//选中原先用户的型号
				   $("#idMidSelect").attr("value",idMidSelect);
			    }
			   } 
			  }); 
		}

         function checkExistModelInfo(mid){
           var len=$.trim(mid).length;
           if(len == 0){
             return;
           }
		    var flag =  checkPKIsExist("mid",mid,"checkExistModelInfo");
			if(flag=="true"){
			     $("#idExist").val(flag);
				 msgShow("提示","您所输入的主机型号已经存在，请修改!!!","error");
			}else if(flag ="false") {
				 $("#idExist").val("");
			}
	   }
	   	   function deleteNoteByIdForModel(dataTableId, requestURL, confirmMessage){
	
		if (null == confirmMessage || typeof(confirmMessage) == "undefined" || "" == confirmMessage) {
			confirmMessage = "确定删除所选记录?";
		}
		var rows = $('#'+dataTableId).datagrid('getSelections');
		var num = rows.length;
		var ids = null;
		var fields=null;
		if(num < 1){
			msgShow('提示消息','请选择你要删除的记录!','info');
		}else{
			$.messager.confirm('确认', confirmMessage, function(r){
				if (r) {
				for(var i = 0; i < num; i++){
					if(null == ids || i == 0){
						ids = $.trim(rows[i].KEYID);
					} else {
					    ids = $.trim(ids) + "," + $.trim(rows[i].KEYID);
					}
				}
					fields=rows[0].FIELDS;
		  	
		  	var param=buildDelParamModule(ids,fields);
			$.getJSON(requestURL,param,function(data){
			if (null != data && null != data.status && "" != data.status&&data.status=="true") {
				msgShow('提示消息',data.message,'info');
				flashTable(dataTableId);
				 changeModelByFID($('#idFidSelect').val());
			} else {
				if(data.message==null||data.message==""){
					msgShow('提示消息','删除失败！','error');
				}else{
					msgShow('提示消息',data.message,'error');
				}
			}
				clearSelect(dataTableId);
			});
			
	 }
	 });
   }
  }
	   
	 