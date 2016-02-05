	$(function(){
		  if(document.getElementById("idMerchInfo")){
			$('#idMerchInfo').datagrid({
				iconCls:'icon-save',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:true,
				url:'listMerchInfo.do',
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
			{title:'商户编号',field:'MERCH_ID',align:'center',width:130,sortable:true},
			{title:'商户名称',field:'MERCH_NAME',align:'center',width:150,sortable:true},
			//{title:'网络接入服务商',field:'ORG_NAME',align:'center',width:150,sortable:true},
			//{title:'分店编号',field:'SUB_ID',align:'center',width:100,sortable:true},
			{title:'分支机构',field:'REG_NAME',align:'center',width:240,sortable:true},
			//{title:'商户属性',field:'MERCH_ATTR',align:'center',width:100,sortable:true},
			{title:'商户MCC',field:'MERCH_MCC',align:'center',width:60,sortable:true},
			{title:'联系人',field:'CONNECTER',align:'center',width:100,sortable:true},
			{title:'联系电话',field:'OPER_CALLNO',align:'center',width:130,sortable:true},
			//{title:'传真',field:'FAX_NO',align:'center',width:100,sortable:true},
			//{title:'Email地址',field:'EMAIL',align:'center',width:100,sortable:true},
		//	{title:'邮政编码',field:'POST_CODE',align:'center',width:110,sortable:true}
		//	{title:'商户状态',field:'MERCH_STATUS',align:'center',width:100,sortable:true},
			{title:'商户地址',field:'MERCH_ADDR',align:'center',width:200,sortable:true},
			{title:'备注',field:'DESC_TXT',align:'center',width:100,sortable:true}

				]]
			});
            //initDataForMerchInfo('idRegId,regEntireId');//初始化数据
	     }
	      
		});
		
		 function initDataForMerchInfo(param){
		    $.ajax({
			   type: "POST",
			   url: "initDataForMerchInfo.do",
			   data: "param="+param,       //idOrgId,idMerchStatus
			  success: function(data){
			    var option; 
			   /* 
			    //对idOrgId进行赋值
			   if(data.idOrgId){
			     $.each(data.idOrgId,function(idx,item){ 
		            // option += "<option value=" + data.idOrgId[i].ORG_ID +">" + data.idOrgId[i].ORG_NAME+ "</option>";
			         option = new Option(item.ORG_NAME,item.ORG_ID);                       
                     document.getElementById("idOrgId").options.add(option);
			     });
			    }*/
			    /*
			     //对idMerchStatus进行赋值
			    if(data.idMerchStatus){//data.idMerchStatus的数据格式为--->0:冻结,1:正常,2:注销
			      var  strs1  = data.idMerchStatus.split(",");
			      for(var i = 0 ;i < strs1.length; i++){
			         var strs2 = strs1[i].split(":");
			         option = new Option(strs2[1],strs2[0]);                       
                     document.getElementById("idMerchStatus").options.add(option); 
			      }
			      $("#idMerchStatus").attr("value",'1'); 
			    }
			    */
			    /*
			    if(data.idRegId){
			       var str  = data.idRegId.split("(");
			       $("#idRegId").val(str[1].substring(0,str[1].length-1));
			       $("#idRegName").val(data.idRegId);
			    }
			    */
			    
			     if(data.idRegId){
			       var str  = data.idRegId.split("(");
			       $("#idRegId").val(str[1].substring(0,str[1].length-1));
			       $("#idRegName").val(data.idRegId);
			      
			    }
			    
			    if(data.regEntireId){
			       $("#idRegEntireId").val(data.regEntireId);
			    }
			  
			   } 
			  }); 
			
		}
  
       function checkExistMerchInfo(){
  
		var  merchId = $("#idMerchId").val();
		
		  var len=$.trim(merchId).length;
           if(len == 0){
             return;
           }
	    var flag =  checkPKIsExist("merchId",merchId,"checkExistMerchInfo");
		if(flag=="true"){
		   //  $("#idExist").val(flag);
			// msgShow("提示","您所输入的商户编码已经存在，请修改333!!!","error");
			 return true;
		}else if(flag ="false") {
			// $("#idExist").val("");
			return false;
		}
	   }
   
	
		
