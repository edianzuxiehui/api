	$(function(){
		    if(document.getElementById("idOnlineLine")){
			$('#idOnlineLine').datagrid({
				iconCls:'icon-save',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:true,
				url:'listOnlineLine.do',
				sortName: 'KEYID',
				sortOrder: 'desc',
				remoteSort: false,
				idField:'KEYID',
				pageSize:10,
				pagination:true,
				rownumbers:true,
				frozenColumns:[[
	                //{field:'ck',checkbox:true},
	                {field:'FIELDS',title:'FIELDS',hidden:true},
	                {title:'KEYID',field:'KEYID',hidden:true}
				]],
				columns:[[
           	{title:'应用终端号',field:'APOS_ID',align:'center',width:100,sortable:true},
            {title:'应用编号',field:'APP_ID',align:'center',width:70,sortable:true},
            {title:'应用名称',field:'APP_NAME',align:'center',width:120,sortable:true},
            {title:'主应用商户号',field:'MERCH_ID',align:'center',width:120,sortable:true},
            {title:'主应用商户名称',field:'MERCH_NAME',align:'center',width:120,sortable:true},
			{title:'主应用终端号',field:'TERMINAL_ID',align:'center',width:100,sortable:true},
			{title:'硬件序列号',field:'SERIAL_NO',align:'center',width:100,sortable:true},
			{title:'交易类型',field:'TRAN_TYPE',align:'center',width:100,sortable:true},
			{title:'交易结果',field:'TRAN_RESULT',align:'center',width:80,sortable:true},
			{title:'交易开始时间',field:'TRAN_BEGIN_DATE',align:'center',width:90,sortable:true},
			{title:'交易结束时间',field:'TRAN_COMPLET_DATE',align:'center',width:90,sortable:true},
			{title:'备注',field:'ERROR_INFO',align:'center',width:150,sortable:true,		
				formatter:function(value,rowData,rowIndex) {
				if(value=="[-1]-[]") {
					return '动态库返回出错';
				}else{
					return value;
				}
			}},
			{title:'分支机构',field:'REG_NAME',align:'center',width:200,sortable:true}
				]]
			});
			
			initData4OnlineLine("idTranType");
		  }
	
		});
		
		//初始化数据
		function initData4OnlineLine(param){
		     $.ajax({
			   type: "POST",
			   url: "initData4OnlineLine.do",
			   data: "param="+param, //参数可以是idTranType
			   success: function(data){ 
			     if(data.idTranType){//对idTranType(厂商）进行赋值
				     var option;
				     for(var i = 0 ; i< data.idTranType.length; i++){
				     	if(data.idTranType[i].TRAN_TYPE!='2090'){
					        option  = new Option(data.idTranType[i].TRAN_NAME,data.idTranType[i].TRAN_TYPE);                       
	                        document.getElementById("idTranType").options.add(option);
				     	}
				     }
			      }
			      
			      if(data.idRegId&&data.regEntireId){
				       var str  = data.idRegId.split("(");
				       $("#idRegId").val(str[1].substring(0,str[1].length-1));
				       $("#idRegName").val(data.idRegId);
				       $("#idRegEntireId").val(data.regEntireId);
			    }
			  }
			  }); 
		 }
       
		
		
