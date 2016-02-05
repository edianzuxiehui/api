	$(function(){
		//商户列表	
			$('#idMerchInfo').datagrid({
				title:'商户资料列表',
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
				pageSize:20,
				singleSelect:true,
				pagination:true,
				rownumbers:true,
				onDblClickRow:doubleClickMerch,
				frozenColumns:[[
	                {field:'ck',checkbox:true},
	                {field:'FIELDS',title:'FIELDS',hidden:true},
	                {title:'KEYID',field:'KEYID',hidden:true}
				]],
				columns:[[
			{title:'商户编号',field:'MERCH_ID',align:'center',width:130,sortable:true},
			{title:'商户名称/分店',field:'MERCH_NAME',align:'center',width:150,sortable:true},
			//{title:'网络接入服务商',field:'ORG_NAME',align:'center',width:150,sortable:true},
			//{title:'分店编号',field:'SUB_ID',align:'center',width:100,sortable:true},
			{title:'分支机构',field:'REG_NAME',align:'center',width:130,sortable:true},
			//{title:'商户属性',field:'MERCH_ATTR',align:'center',width:100,sortable:true},
			{title:'商户MCC',field:'MERCH_MCC',align:'center',width:100,sortable:true},
			{title:'联系人',field:'CONNECTER',align:'center',width:100,sortable:true},
			{title:'联系电话',field:'OPER_CALLNO',align:'center',width:120,sortable:true},
			//{title:'传真',field:'FAX_NO',align:'center',width:100,sortable:true},
			//{title:'Email地址',field:'EMAIL',align:'center',width:100,sortable:true},
			{title:'邮政编码',field:'POST_CODE',align:'center',width:110,sortable:true}
		//	{title:'商户状态',field:'MERCH_STATUS',align:'center',width:100,sortable:true},
		
				]]
			});
            initDataForMerchInfo('idOrgId');//初始化数据
	
		});
		
		
		 //初始化商户信息
		 function initDataForMerchInfo(param){
		    $.ajax({
			   type: "POST",
			   url: "initDataForMerchInfo.do",
			   data: "param="+param,       //idOrgId,idMerchStatus
			  success: function(data){
			    var option; 
			    //对idOrgId进行赋值
			   if(data.idOrgId){
			     $.each(data.idOrgId,function(idx,item){ 
		            // option += "<option value=" + data.idOrgId[i].ORG_ID +">" + data.idOrgId[i].ORG_NAME+ "</option>";
			         option = new Option(item.ORG_NAME,item.ORG_ID);                       
                     document.getElementById("idOrgId").options.add(option);
			     });
			    }
			    //对idMerchStatus进行赋值
			    if(data.idMerchStatus){//data.idMerchStatus的数据格式为--->0:冻结,1:正常,2:注销
			      var  strs1  = data.idMerchStatus.split(",");
			      for(var i = 0 ;i < strs1.length; i++){
			         var strs2 = strs1[i].split(":");
			         option = new Option(strs2[1],strs2[0]);                       
                     document.getElementById("idMerchStatus").options.add(option); 
			      }
			    }
			    
			    if(data.idRegId){
			       var str  = data.idRegId.split("(");
			       $("#idRegId").val(str[1].substring(0,str[1].length-1));
			       $("#idRegName").val(data.idRegId);
			    }
			  
			   } 
			  }); 
			
		}
	
	function showMerchInfo(MERCH_ID){
	      var param ={MERCH_ID:MERCH_ID}
	      openDialogFrame(getRootPath()+"/core/aposquery/MerchInfo-show.jsp",param,"600","200");
	}
	
	function showAposInfo(APOS_ID){
	  
	   var retValue=openDialogFrame(getRootPath()+"/core/aposinfo/AposInfo-view.jsp","APOS_ID="+APOS_ID,"850","450");
	}
	
	//双击时给主商户赋值
    function  doubleClickMerch(rowIndex, rowData){
        window.returnValue = rowData.MERCH_ID+"_"+rowData.MERCH_NAME;
        window.close();
    }
    //点击确认时主商户赋值
    function confirm(){
      if($('#idMerchInfo').datagrid('getSelected')){
         window.returnValue = $('#idMerchInfo').datagrid('getSelected').MERCH_ID+"_"+$('#idMerchInfo').datagrid('getSelected').MERCH_NAME;
      }
        window.close();
    }
    
 
 
 
 