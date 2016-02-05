	$(function(){
		   if(document.getElementById("idAppInfo")){
			$('#idAppInfo').datagrid({
				iconCls:'icon-save',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:true,
				url:'listAppInfo.do',
				sortName: 'KEYID',
				sortOrder: 'desc',
				remoteSort: false,
				idField:'KEYID',
				pageSize:20,
				pagination:true,
				rownumbers:true,
				onClickRow:getAppverInfo,
			   // onClickCell:function(rowIndex, field, value){
			   //  alert(rowIndex);
			   //  },
			//  onClickCell:showAppverInfo,
				frozenColumns:[[
	                {field:'ck',checkbox:true},
	                {field:'FIELDS',title:'FIELDS',hidden:true},
	                {title:'KEYID',field:'KEYID',hidden:true}
				]],
				columns:[[
			{title:'应用编号',field:'APP_ID',align:'center',width:100,sortable:true},
			{title:'应用名称',field:'APP_NAME',align:'center',width:110,sortable:true},
			{title:'分支机构',field:'REG_NAME',align:'center',width:160,sortable:true},
			//{title:'应用状态',field:'APP_STATUS',align:'center',width:100,sortable:true},
			{title:'共享标志',field:'SHARE_FLAG2',align:'center',width:100,sortable:true}
			//{title:'注册日期',field:'INPUT_DATE',align:'center',width:200,sortable:true},
			
			/*{title:'应用版本明细',field:'APP_VER_DETAIL',align:'center',width:120,sortable:true,
			 formatter:function(value,rowData,rowIndex){ 
                        var a='<input type="button" class="btn_grid" value="应用版本明细" onclick="showAppverInfo(\''+ rowData.APP_ID+ '\')"/>'
                       // var k=createButton();
                        return a;  
                    }  
			}  */
			//{title:'备注',field:'DESC_TXT',align:'center',width:200,sortable:true}
				]]
			});
		}	
	   //  initDataForAppInfo('idRegId');
	   
	      	$(".import_toolbar").attr('disabled', true);
			$(".export_toolbar").attr('disabled', true);
		});

    function  getAppverInfo(rowIndex, rowData){
                
       			//$('#idAppVerInfo').datagrid("clearSelections");
				//$('#idAppVerInfo').datagrid('selectRow',rowIndex);
				
	           $('#idAppVerInfo').datagrid({
				title:"应用编号为"+rowData.APP_ID+'版本信息',
				iconCls:'icon-save',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:true,
				url:'listAppVerInfo.do?APP_ID='+escape(escape(rowData.APP_ID)),
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
			{title:'应用编号',field:'APP_ID',align:'center',width:80,sortable:true},
			{title:'应用版本',field:'APP_VER',align:'center',width:60,sortable:true},
			{title:'分支机构',field:'REG_NAME',align:'center',width:140,sortable:true},
			{title:'默认版本',field:'APP_VER_DEF_FLAG',align:'center',width:60,sortable:true},
			{title:'备注',field:'DESC_TXT',align:'center',width:200,sortable:true}
				]], 
				  
					toolbar:[{
					text:"增加",
					iconCls:'icon-add',
					handler:addAppVerInfo
				},{
					text:"修改",
					iconCls:'icon-edit',
					handler:updateAppVerInfo
				},{
					text:"设置默认版本",
					iconCls:'edit_toolbar',
					handler:setDefalutAppVerInfo
				},{
					text:"去除默认版本",
					iconCls:'edit_toolbar',
					handler:removeDefalutAppVerInfo
				},{
					text:"删除",
					iconCls:'icon-remove',
					handler:deleteAppVerInfo
				}]
			});
			$('#currentAppInfo').val(rowData.APP_ID);//设置隐藏域，记录当前选择应用
			
        
    }
  
  
  
  
  
   function initDataForAppInfo(param){
		    $.ajax({
			   type: "POST",
			   url: "initDataForAppInfo.do",
			   data: "param="+param,       //idOrgId,idMerchStatus
			  success: function(data){
			    if(data.idRegId){
			       var str  = data.idRegId.split("(");
			       $("#idRegId").val(str[1].substring(0,str[1].length-1));
			       $("#idRegName").val(data.idRegId);
			    }
			     if(data.idAppId){
			       $("#idAppId").val(data.idAppId);
			    
			    }
			   } 
			  }); 
			
	}
	
	//验证是否有修改应用的权限，下级是不可以修改上级的共享的应用的
	function  checkModifyAppinfoAuthority() {
	  		var regName = $('#idAppInfo').datagrid('getSelected').REG_NAME;
			var str = regName.split("(");//得到regId;
			var regId = str[1].substring(0,str[1].length-1);
			var flag = true;
			$.ajax({
			   type: "POST",
			   url: "checkModifyAppinfoAuthority.do",
			   data: "REG_ID="+regId,  
			   async: false,    
			  success: function(data){
			          flag = data.authority;
			   } 
			  }); 
			 return flag;
	}
	
	//多主控管理器不能被删除
	function check_Multi_Application(rows){
	    var num = rows.length;
	    var ids = null;
	    var flag = true;
	
		for(i=0 ; i< num; i++){
		      if($.trim(rows[i].KEYID)== '00000000'){
		        flag = false;
		         break;
		      }
		}
		return  flag;
	}
	
	//验证appversion是否存在
	function checkAppInfoExist(){
	    var appid = $('#idAppId').val();
	    var len=$.trim(appid).length;
           if(len == 0||len<8){
             return;
           }
	    $.ajax({
			   type: "POST",
			   url: "checkAppInfoExist.do",
			   data: "APP_ID="+appid, 
			   async: false,
			  success: function(data){
			        if(data.exist){
			          $('#idExist').val(data.exist);
			          msgShow("新增",'该应用'+appid+'已经存在',"error");
			        }else {
			           $('#idExist').val("");
			        }
			      
			   } 
		 }); 
	}
	
	
	
	
        