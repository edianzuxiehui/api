/*	var k = window.dialogArguments; 
	$(function(){
		  if(document.getElementById("idAppVerInfo")){
		    var url = 'listAppVerInfo.do?APP_ID='+k.par.appId;
			$('#idAppVerInfo').datagrid({
				title:'应用版本明细列表',
				iconCls:'icon-save',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:true,
				url:url,
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
			{title:'应用编号',field:'APP_ID',align:'center',width:120,sortable:true},
			{title:'应用版本',field:'APP_VER',align:'center',width:120,sortable:true},
			{title:'所属机构',field:'REG_NAME',align:'center',width:120,sortable:true},
			{title:'备注',field:'DESC_TXT',align:'center',width:120,sortable:true}
				]]
			});
			
			
			
		 }
	
		});
		*/
		
		
		
		
		   function initDataForAppVerInfo(param){
		    $.ajax({
			   type: "POST",
			   url: "initDataForAppVerInfo.do",
			   data: "param="+param,       //idOrgId
			  success: function(data){
			    if(data.idRegId){
			       var str  = data.idRegId.split("(");
			       $("#idRegId").val(str[1].substring(0,str[1].length-1));
			       $("#idRegName").val(data.idRegId);
			    }
			   } 
			  }); 
			
	      }
	      
	      
	      	//验证是否有修改应用版本的权限，下级是不可以修改上级的共享的应用的
	  function  checkModifyAppverinfoAuthority() {
	  		var regName = $('#idAppVerInfo').datagrid('getSelected').REG_NAME;
			var str = regName.split("(");//得到regId;
			var regId = str[1].substring(0,str[1].length-1);
			var flag = true;
			$.ajax({
			   type: "POST",
			   url: "checkModifyAppverinfoAuthority.do",
			   data: "REG_ID="+regId, 
			   async: false,
			  success: function(data){
			      flag = data.authority;
			   } 
			  }); 
			  return flag;
	}
	
	//验证appversion是否存在
	function checkAppVerinfoExist(appver){
	    var appid = $('#idAppId').val();
	    var len=$.trim(appver).length;
        if(len == 0){
             return;
        }
	    if(appid == '')
	     return;
	    $.ajax({
			   type: "POST",
			   url: "checkAppVerinfoExist.do",
			   async: false,
			   data: "APP_ID="+appid +"&APP_VER="+appver, 
			  success: function(data){
			        if(data.exist){
			          $('#idExist').val(data.exist);
			          msgShow("新增",'该应用版本已经存在!!!',"error");
			        }else {
			           $('#idExist').val("");
			        }
			      
			   } 
		 }); 
	}
	
	
	  
		function addAppVerInfo(){
		    var  APP_ID = $('#currentAppInfo').val();
			var retValue=openDialogFrame(getRootPath()+"/core/appverinfo/AppVerInfo-add.jsp",escape(escape(APP_ID)),"400","200");
			if(retValue=="true"){
				msgShow("新增","新增成功!","info");
				flashTable("idAppVerInfo");
			}else if(retValue=="false"){
			   msgShow("新增","新增失败!","error");
			}
		}
		
		
		function updateAppVerInfo(){
			var ids=updateValidate("idAppVerInfo");
		    if(ids){
		       if(checkModifyAppverinfoAuthority()){
			    	var retValue=openDialogFrame(getRootPath()+"/core/appverinfo/AppVerInfo-edit.jsp",ids,"400","200");
					if(retValue=="true"){
						msgShow("修改","修改成功!","info");
						flashTable("idAppVerInfo");
					}else if(retValue=="false"){
				       msgShow("修改","修改失败!","error");
				    }
			   }else {
			        msgShow("没有权修改","没有权利修改别的机构的版本!","error");  
			   
			   }
		    }
			
		}
		
		function deleteAppVerInfo(){
		   var rows = $('#idAppVerInfo').datagrid('getSelections');
		   var num = rows.length;
	       if(num < 1){
		     msgShow('提示消息','请选择你要删除的记录!','info');
		     return ;
		   }
		  if(checkModifyAppverinfoAuthority()){
		  	 var rows = $("#idAppVerInfo").datagrid('getSelections');
		  	 var num = rows.length;
		  	 var delFlag=false;
		  	 $.each(rows,function(i,row){
		  	 	if(row.APP_VER_DEF_FLAG =='默认'){
                   delFlag=true;
                   msgShow('提示消息','默认版本不能删除,请将其他版本设置为默认版本，然后再删除!','warning');
		  	 	}
		  	 }); 
		  	 if(!delFlag)deleteNoteById("idAppVerInfo","delAppVerInfo.do", "");
		  }else {
		      msgShow("没有权限","没有权限删除其他机构的应用版本!","error");  
		  }  
		}
		
	function setDefaultValidate(rows,num,ids){
        if(rows[0].APP_VER_DEF_FLAG =='默认'){
                 msgShow('提示消息','所选版本已经是默认版本!','info');
               return;
              }
              
		for(var i = 0; i < num; i++){
			if(null == ids || i == 0){
				ids = rows[i].KEYID;
				} else {
				ids = ids + "," + rows[i].KEYID;
				
			}
		}	
		fields=rows[0].FIELDS;
  	    return buildDelParam(ids,fields);
   }

		
	
      function setDefalutAppVerInfo(){
            var rows = $("#idAppVerInfo").datagrid('getSelections');
         	var ids;
	        var fields=null;
		    var num = rows.length;
	        if(num < 1){
		    	msgShow('提示消息','请选择你要设置的默认版本!','info');
		    	return;
	        } else if(num>1){
	    	  msgShow('提示消息','只能有一个默认版本!','info');
	    	  return;
	       }else{
	           if(checkModifyAppverinfoAuthority()){
				  var ids = setDefaultValidate(rows,num,ids);
				      if(ids){
				      $.ajax({
						   type: "POST",
						   url: "setDefaultAppVerInfo.do",
						   data: ids+"&tmsModuleTitle="+tmsJ5ModuleTitle+"&tmsModuleId="+tmsJ5ModuleId+"&isSetDefault="+"true", 
						   async: false,
						   success: function(data){
							    if(data.status){
							      msgShow('提示消息','设置默认版本成功!','info');
							      $("#idAppVerInfo").datagrid('load');
							    }else {
							      msgShow('提示消息','设置默认版本出错!','info');
							   } 
						   }
						  }); 
				      }
				}else {
				        msgShow("没有权限","没有权限设置其他机构默认版本!","error");  
				   
				   }
			   
			}
   
       }
       
       
         function removeDefalutAppVerInfo(){
            var  isSuperAdmin = $("#isSuperAdmin").val();
            if(isSuperAdmin == "true"){
	            var rows = $("#idAppVerInfo").datagrid('getSelections');
	         	var ids;
		        var fields=null;
			    var num = rows.length;
		        if(num < 1){
			    	msgShow('提示消息','请选择你要去除的默认版本!','info');
			    	return;
		        } else if(num>1){
		    	  msgShow('提示消息','只能去除一个默认版本!','info');
		    	  return;
		    	} 
		         
				  var ids = removeDefaultValidate(rows,num,ids);
				      if(ids){
				      $.ajax({
						   type: "POST",
						   url: "setDefaultAppVerInfo.do",
						   data: ids+"&tmsModuleTitle="+tmsJ5ModuleTitle+"&tmsModuleId="+tmsJ5ModuleId, 
						   async: false,
						   success: function(data){
							    if(data.status){
							      msgShow('提示消息','去除默认版本成功!','info');
							      $("#idAppVerInfo").datagrid('load');
							    }else {
							      msgShow('提示消息','去除默认版本出错!','info');
							   } 
						   }
						  }); 
				      }
            }else {
			    msgShow("没有权限","只有超级管理才能去除默认版本!","error");  
			}
        }
       



	function removeDefaultValidate(rows,num,ids){
	        if(rows[0].APP_VER_DEF_FLAG !='默认'){
                  msgShow('提示消息','所选版本不是默认版本!','info');
                return;
               }
               
			for(var i = 0; i < num; i++){
				if(null == ids || i == 0){
					ids = rows[i].KEYID;
					} else {
					ids = ids + "," + rows[i].KEYID;
					
				}
			}	
			fields=rows[0].FIELDS;
		  	return buildDelParam(ids,fields);
      }

	
        