	$(function(){
	    if(document.getElementById("idStrategyReportTime")){
			$('#idStrategyReportTime').datagrid({
				iconCls:'icon-save',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:true,
				url:'strategyreporttime.do',
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
				 toolbar:[{
				id:'edit',
				text:'修改巡检周期',
				iconCls:'edit_toolbar',
				handler:function(){
				  doEdit();
				}
				},{
				id:'batchedit',
				text:'批量修改策略',
				iconCls:'icon-edit',
				handler:function(){
				   BatchEditStraegy();
				}
				}],
				columns:[[
			{title:'应用终端号',field:'APOS_ID',align:'center',width:100,sortable:true, formatter:function(value,rowData,rowIndex){ 
			          if(value == null || value==''){
			            return '';
			          }else{  
					    var data='<a style="color:blue;" href="javascript:showAposInfo(\''+rowData.APOS_ID+'\')">'+rowData.APOS_ID+'</a>';
                        return data;
                      }    
                    } },
			{title:'主应用商户',field:'MERCH_ID',align:'center',width:120,sortable:true,formatter:function(value,rowData,rowIndex){ 
			         if(value == null || value==''){
			            return '';
			          }else{
					   var	data='<a   style="color:blue;" href="javascript:showMerchInfo(\''+rowData.MERCH_ID+ '\')">'+rowData.MERCH_ID+'</a>';
                       //var data='<input type="button" class="btn_grid" value='+rowData.MERCH_ID+' onclick="showMerchInfo(\''+ rowData.MERCH_ID +'\' , \'' +rowData.REG_ID +'\' , \''+ rowData.SUB_ID + '\')"/>'
                        return data;  
                     }   
                    }},
			{title:'主应用商户名称',field:'MERCH_NAME',align:'center',width:120,sortable:true},
			{title:'主应用终端',field:'TERMINAL_ID',align:'center',width:100,sortable:true},
			
			{title:'STRATEGY_ID',field:'STRATEGY_ID',align:'center',width:100,sortable:true,hidden:true},
			{title:'主机型号',field:'MID',align:'center',width:100,sortable:true},
			{title:'硬件序列号',field:'SERIAL_NO',align:'center',width:100,sortable:true},
			{title:'实体终端状态',field:'DEV_STATUS',align:'center',width:100,sortable:true},
			{title:'装机状态',field:'COMPLET_FLAG',align:'center',width:100,sortable:true},
			{title:'下次报到时间',field:'NEXT_SIGN_TIME',align:'center',width:100,sortable:true},
			{title:'下次报到截止时间',field:'LAST_SIGN_END_TIME',align:'center',width:100,sortable:true},
			{title:'报到间隔周期',field:'INTERVAL_DAYS',align:'center',width:100,sortable:true},
            {title:'所属单位',field:'REG_NAME',align:'center',width:200,sortable:true}
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
			
			 //initDataForMerchInfo('idRegId,regEntireId');//初始化数据
		 }	
			
	
	
		});
		
	
	function showMerchInfo(MERCH_ID){
	      var param ={MERCH_ID:MERCH_ID}
	      openDialogFrame(getRootPath()+"/core/aposquery/MerchInfo-show.jsp",param,"600","200");
	}
	
    
    $.extend($.fn.validatebox.defaults.rules, {
       must_one_two_three : {//验证重拨次数
        validator : function(value,param) {
            return must_one_two_three();
        },
        message:'重拨次数取值范围为1,2,3！'
       }
	 });
	 
	 
     //验证重拨次数
     function must_one_two_three(){
        var frtimes = $('#idFrtimes').val();
        if(frtimes ==1 ||frtimes ==2 ||frtimes ==3 ){
           return true;
        }else {
	       return false;
	    }
     }