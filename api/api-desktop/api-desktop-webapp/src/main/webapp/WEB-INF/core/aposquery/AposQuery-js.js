	$(function(){
	    if(document.getElementById("idAposQuery")){
			$('#idAposQuery').datagrid({
				iconCls:'icon-save',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:true,
				url:'aposquery.do',
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
			{title:'应用终端号',field:'APOS_ID',align:'center',width:100,sortable:true, 
			       formatter:function(value,rowData,rowIndex){ 
			         if(value == null || value==''){
			           return "";
			         }else {
					    var data='<a style="color:blue;" href="javascript:showAposInfo(\''+rowData.APOS_ID+'\')">'+rowData.APOS_ID+'</a>';
                        return data;  
                     }   
                    }
             },
			{title:'主应用商户',field:'MERCH_ID',align:'center',width:120,sortable:true,
			        formatter:function(value,rowData,rowIndex){  
			         if(value == null|| value==''){
			           return "";
			         }else {
					   var	data='<a   style="color:blue;" href="javascript:showMerchInfo(\''+rowData.MERCH_ID+ '\')">'+rowData.MERCH_ID+'</a>';
                       //var data='<input type="button" class="btn_grid" value='+rowData.MERCH_ID+' onclick="showMerchInfo(\''+ rowData.MERCH_ID +'\' , \'' +rowData.REG_ID +'\' , \''+ rowData.SUB_ID + '\')"/>'
                        return data;
                     }  
                    }
              },
			{title:'主应用商户名称',field:'MERCH_NAME',align:'center',width:120,sortable:true},
			{title:'主应用终端',field:'TERMINAL_ID',align:'center',width:100,sortable:true},
			{title:'主机型号',field:'MID',align:'center',width:100,sortable:true},
			{title:'硬件序列号',field:'SERIAL_NO',align:'center',width:100,sortable:true},
			{title:'实体终端状态',field:'DEV_STATUS',align:'center',width:100,sortable:true},
			{title:'装机状态',field:'COMPLET_FLAG',align:'center',width:100,sortable:true},
			{title:'下次报到时间',field:'NEXT_SIGN_TIME',align:'center',width:100,sortable:true},
			{title:'下次报到截止时间',field:'LAST_SIGN_END_TIME',align:'center',width:100,sortable:true},
			{title:'报到间隔周期',field:'INTERVAL_DAYS',align:'center',width:100,sortable:true},
            {title:'分支机构',field:'REG_NAME',align:'center',width:100,sortable:true}
			/*{title:'授权标志',field:'AUTH_FLAG',align:'center',width:100,sortable:true},
			{title:'装机完成状态',field:'COMPLET_FLAG',align:'center',width:100,sortable:true},
			{title:'主叫电话',field:'TELE_NO',align:'center',width:100,sortable:true},
			{title:'布放地址',field:'APOS_ADDR',align:'center',width:100,sortable:true},
			{title:'实体终端编号',field:'DEV_ID',align:'center',width:100,sortable:true},
			{title:'输入时间',field:'INPUT_TIME',align:'center',width:100,sortable:true},
			{title:'上次报到时间',field:'LAST_SIGN_TIME',align:'center',width:100,sortable:true},
			{title:'数据来源',field:'DATA_SOURCE',align:'center',width:100,sortable:true},
			{title:'策略编号',field:'STRATEGY_ID',align:'center',width:100,sortable:true},
			{title:'重试参数',field:'FRTIMES',align:'center',width:100,sortable:true},
			{title:'原关联硬件序列号',field:'OLD_DEV_ID',align:'center',width:100,sortable:true},
			{title:'装机完成时间',field:'CREATE_POS_TIME',align:'center',width:100,sortable:true},
			{title:'应用终端是否可用',field:'APOS_VALID',align:'center',width:100,sortable:true}*/
				]]
			});
		//	 initDataForMerchInfo('idRegId,regEntireId');//初始化数据
		 }	
			
		//商户列表	
		 if(document.getElementById("idMerchInfo")){
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
            initDataForMerchInfo('idRegId,regEntireId');//初始化数据
	     }
		 
		 
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
		
		
		 //初始化商户信息
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
			    //对idMerchStatus进行赋值
			    if(data.idMerchStatus){//data.idMerchStatus的数据格式为--->0:冻结,1:正常,2:注销
			      var  strs1  = data.idMerchStatus.split(",");
			      for(var i = 0 ;i < strs1.length; i++){
			         var strs2 = strs1[i].split(":");
			         option = new Option(strs2[1],strs2[0]);                       
                     document.getElementById("idMerchStatus").options.add(option); 
			      }
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
        window.returnValue = rowData.MERCH_ID;
        window.close();
    }
    //点击确认时主商户赋值
    function confirm(){
      if($('#idMerchInfo').datagrid('getSelected')){
         window.returnValue = $('#idMerchInfo').datagrid('getSelected').MERCH_ID;
      }
        window.close();
    }
    
 
 
 
 