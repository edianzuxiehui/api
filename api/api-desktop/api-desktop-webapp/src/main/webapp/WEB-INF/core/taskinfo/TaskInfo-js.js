	$(function(){
		
			$('#idTaskInfo').datagrid({
				//title:'任务管理',
				iconCls:'icon-save',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:true,
				url:'listTaskInfo.do',
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
			//{title:'系统内部编号(使用序列生成的编号)',field:'TASK_SYS_ID',align:'center',width:100,sortable:true},
	               {title:'<input id="checkAllList" type="checkbox">',field:'TASK_STATUS_FLAG',formatter:function(value,rowData,rowIndex){
	            	   //alert(value);
	                	var opt = '<input id="checkbox'+rowData.TASK_SYS_ID+'" type="checkbox" name="ck"'; 
	                    if(value=='1'){//这里判断是不是选 
	                		opt = '<input id="checkbox'+rowData.TASK_SYS_ID+'" type="checkbox" name="ck" disabled="true"'; 
	                    } 
	                    return opt ; 
	                }},
			{title:'计划名称',field:'PLAN_NAME',align:'center',width:90,sortable:true},
			{title:'应用终端号',field:'APOS_ID',align:'center',width:80,sortable:true},
			{title:'硬件序列号',field:'SERIAL_NO',align:'center',width:100,sortable:true},
			{title:'主应用商户号',field:'MERCH_ID',align:'center',width:120,sortable:true,
				formatter:function(value,rowData,rowIndex){ 
			         if(value == null || value==''){
			            return '';
			          }else{
					   var	data='<a   style="color:blue;" href="javascript:showMerchInfo(\''+rowData.MERCH_ID+ '\')">'+rowData.MERCH_ID+'</a>';
                       //var data='<input type="button" class="btn_grid" value='+rowData.MERCH_ID+' onclick="showMerchInfo(\''+ rowData.MERCH_ID +'\' , \'' +rowData.REG_ID +'\' , \''+ rowData.SUB_ID + '\')"/>'
                        return data;  
                     }   
                 }
            },
			{title:'主应用商户名称',field:'MERCH_NAME',align:'center',width:120,sortable:true},
			{title:'主应用终端号',field:'TERMINAL_ID',align:'center',width:90,sortable:true},
			{title:'任务复制',field:'copy',align:'center',width:85,formatter:function(value,rowData,rowIndex){
						return '<input id="copy'+rowData.TASK_SYS_ID+'" type="button" class="btn_grid" value="任务复制" onclick="javascript:copyTask(\''+rowData.TASK_SYS_ID+'\',\''+rowData.APOS_ID+'\',\''+rowData.STRATEGY_ID+'\')\"/>';
						}},
			{title:'审核状态',field:'CHECK_STATUS',align:'center',width:70,sortable:true,formatter:function(value,rowData,rowIndex){
						if(value=='同意'||value=='1'||value=='否决'||value=='0'){
							return value;
						}else if(value=='未审核'||value=='2'){
							return '<input id="check'+rowData.TASK_SYS_ID+'" type="button" class="btn_grid" value="审 核" onclick="javascript:checkTask(\''+rowData.TASK_SYS_ID+'\')\"/>';
						}
						}},
			{title:'详情',field:'detail',align:'center',width:70,formatter:function(value,rowData,rowIndex){
						return '<input id="detail'+rowData.TASK_SYS_ID+'" type="button" class="btn_grid" value="详情" onclick="javascript:taskDetail(\''+rowData.KEYID+'\')\"/>';
						}},	
			//{title:'创建日期',field:'CREATE_DATE',align:'center',width:130,sortable:true},
			{title:'计划开始时间',field:'DOWN_BTIME',align:'center',width:130,sortable:true},
			{title:'任务状态',field:'TASK_STATUS',align:'center',width:80,sortable:true},
			{title:'实际完成时间',field:'COMP_DATE',align:'center',width:130,sortable:true},
			{title:'操作员',field:'NAME',align:'center',width:100,sortable:true}					
			//{title:'策略编号',field:'STRATEGY_ID',align:'center',width:100,sortable:true},
			//{title:'下载开始时间',field:'DOWN_BTIME',align:'center',width:100,sortable:true},
			//{title:'下载结束时间',field:'DOWN_ETIME',align:'center',width:100,sortable:true}
				]],
			rowStyler:function(rowIndex,rowData) {
					if(rowData.TASK_STATUS=='主商户未配置') {
						return 'color:#FF3030;';
					}
						//return 'color:#0000CD;';
				},				
			toolbar:[{
					id:'btnChangeStra',
					text:'策略重新分配',
					iconCls:'icon-ok',
					handler:function(){     
						changeStra();
					}
				},
				{
					id:'btnGenPosp',
					text:'生成通知',
					iconCls:'icon-ok',
					handler:function(){     
						genNotice();
					}
				}],
			onLoadSuccess:function(data){
				$('#idTaskInfo').datagrid('clearSelections');//防止点刷新按钮后，勾选状态不对
				$('#checkAllList').removeAttr('checked');
				for(var i = 0;i<data.rows.length;i++){
					var row = data.rows[i];
					//alert(row.TASK_SYS_ID);
					if(isEditAuth()&&row.TASK_STATUS=='已完成'){
						$('#copy'+row.TASK_SYS_ID).attr('disabled',false);
					}else{
						$('#copy'+row.TASK_SYS_ID).attr('disabled',true);
					}
					//alert(row.TAB_NO);
					if(isEditAuth()&&row.TAB_NO!=null&&row.TAB_NO!='null'&&row.TASK_STATUS=='未完成'){
						$('#check'+row.TASK_SYS_ID).attr('disabled',false);
					}else{
						$('#check'+row.TASK_SYS_ID).attr('disabled',true);
					}
				}
			},
			onClickCell:function(rowIndex, field, value){//改变checkbox勾选状态
				//alert('onClickCell');
				//getObjectProp(event.srcElement);
				if(field=='TASK_STATUS_FLAG'&&event.srcElement.nodeName=='INPUT'){//checkbox点击，默认就会改变选中状态，所以在onClickRow事件后需要再处理
					var rows = $('#idTaskInfo').datagrid('getRows')
					var taskId = rows[rowIndex].TASK_SYS_ID;//alert(taskId);
					var checked = $('#checkbox'+taskId).attr('checked');//alert(checked);
					if(checked==undefined){
						$('#checkbox'+taskId).attr('checked',true);
					}else{
						$('#checkbox'+taskId).removeAttr('checked');
					}
				}
			},
			onClickRow:function(rowIndex, rowData){//改变checkbox勾选状态
				//alert('onClickRow');
					var rows = $('#idTaskInfo').datagrid('getRows')
					var taskId = rows[rowIndex].TASK_SYS_ID;//alert(taskId);
					var disabled = $('#checkbox'+taskId).attr('disabled');//alert(disabled);
					if(disabled==undefined){
						var checked = $('#checkbox'+taskId).attr('checked');//alert(checked);
						if(checked==undefined){
							$('#checkbox'+taskId).attr('checked',true);
						}else{
							$('#checkbox'+taskId).removeAttr('checked');
						}
					}else{//disabled的checkbox不能选中
						$('#idTaskInfo').datagrid('unselectRow',rowIndex);
					}
			},
			onSortColumn:function(sort, order){//点击列排序
				$('#idTaskInfo').datagrid('clearSelections');
			}
			
			});
			initDataForModelInfo('idFidSelect');
			
			$('#checkDialog').dialog('close');
			$(".import_toolbar").attr('disabled', true);
			$(".export_toolbar").attr('disabled', true);
			
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
			
			$('#checkAllList').off('click');
			$('#checkAllList').on('click',function(){
				selrows = $('#idTaskInfo').datagrid('getSelections');
				if(selrows && selrows.length>0){ //清空全部选择
					for(i=0;i<selrows.length;i++){
						var taskId = selrows[i].TASK_SYS_ID;
						$('#checkbox'+taskId).removeAttr('checked');
					}
					$('#idTaskInfo').datagrid('clearSelections');
					$('#checkAllList').removeAttr('checked');
				}else{
					$('#checkAllList').removeAttr('checked');
					$('#checkAllList').attr('checked',true);
					var rows = $('#idTaskInfo').datagrid('getRows')
					for(i=0;i<rows.length;i++){
						row = rows[i]
						var taskId = row.TASK_SYS_ID;
						var disabled = $('#checkbox'+taskId).attr('disabled');
						if(disabled==undefined){
							$('#checkbox'+taskId).attr('checked',true);
							$('#idTaskInfo').datagrid('selectRow',i);
						}
					}
				}
			});
			
		});
		
	
	function showMerchInfo(MERCH_ID){
	      var param ={MERCH_ID:MERCH_ID}
	      openDialogFrame(getRootPath()+"/core/aposquery/MerchInfo-show.jsp",param,"600","200");
	}
				
  //任务复制
  function copyTask(taskSysId,aposId,strategyId){
    $.messager.confirm('任务复制', '要进行任务复制?', function(r){
    	if(r){
    		var tmsModuleTitle= $("#idTmsModuleTitle").val();
   			var tmsModuleId= $("#idTmsModuleId").val();
	      var param={'TASK_SYS_ID':taskSysId,'APOS_ID':aposId,'STRATEGY_ID':strategyId,"tmsModuleId":tmsModuleId,"tmsModuleTitle":escape(tmsModuleTitle)};
		  $.getJSON('copyTask.do',param,function(data){
			if (null != data && null != data.status && "" != data.status&&data.status=="true") {
				msgShow('提示消息',data.message,'info');
			} else {
				if(data.message==null||data.message==""){
					msgShow('提示消息','任务复制失败！','warning');
				}else{
					msgShow('提示消息',data.message,'warning');
				}
			}
			flashTable("idTaskInfo");
		 });	
		}	  
	});
  } 
  
  function taskDetail(keyid){//任务详情查看
      var param={'keyid':keyid};
	  openDialogFrame(getRootPath()+'/core/taskinfo/TaskInfo-view.jsp',param,"800","450");    
  }
  
  		//任务审核
		function check(keyid,checkStatus){
			var rows = $('#idTaskInfo').datagrid('getRows');//返回当前页的行
			//alert('rows.length'+rows.length);
			//alert(keyid);
			for(var i=0;i<rows.length;i++){
				if(rows[i].TASK_SYS_ID===keyid){
	   				rows[i].tmsModuleTitle=tmsJ5ModuleTitle;//index页面直接取tmsJ5ModuleTitle值
	   				rows[i].tmsModuleId=tmsJ5ModuleId;
					rows[i].CHECK_STATUS = checkStatus;
					$.post('checkTask.do', rows[i],function(data) {
						$('#checkDialog').dialog('close');
						var obj = eval('(' + data + ')');
						if(obj.status&&obj.status=="true"){
							msgShow('审核',obj.message,'info');
							
							//页面显示要变为名称
							if(checkStatus=='0'){
								checkStatus="否决";
							}else if(checkStatus=='1'){
								checkStatus="同意";
							}else if(checkStatus=='2'){
								checkStatus="未审核";
							}
							rows[i].CHECK_STATUS = checkStatus;
							$('#idTaskInfo').datagrid('updateRow',{'index':i,'row':rows[i]});
						}else if(obj.status&&obj.status=="false"){
							msgShow('审核',obj.message,'error');
						}
						flashTable("idTaskInfo");
					});
					break;
				}
			}
		};	
	function checkTask(keyid){//审核
		$('#checkDialog').dialog({
				buttons:[{
					text:'同意',
					iconCls:'icon-ok',
					handler:function(){check(keyid,'1');}
				},{
					text:'不同意',
					handler:function(){check(keyid,'0');}
				},{
					text:'取消',
					handler:function(){
						$('#checkDialog').dialog('close');
					}
				}]
			});
	}  
  
  	//策略重新分配
	function changeStra(){
		var rows = $('#idTaskInfo').datagrid('getSelections');
		var ids;
		var fields=null;
		if(rows){
			if(rows.length < 1){
				msgShow('提示消息','请选择你要进行策略重新分配的记录!','info');
				return ;
			}else{
				for(var i = 0; i < rows.length; i++){
					if(null == ids || i == 0){
						ids = rows[i].KEYID;
					} else {
						ids = ids + "," + rows[i].KEYID;
					}
				}	
				fields=rows[0].FIELDS;
			}
			var param =  buildDelParam(ids,fields);//alert('param:'+param);
			//alert(param);//TASK_SYS_ID=&PLAN_CODE=&APOS_ID=&REG_ID=&REG_ENTIRE_ID=&PLAN_NAME=
		  	var taskSysIds = param.substring(param.lastIndexOf('TASK_SYS_ID=')+12,param.lastIndexOf('&PLAN_CODE='));
		  	var aposIds = param.substring(param.lastIndexOf('APOS_ID=')+8,param.lastIndexOf('&REG_ID='));
		    var param = {'flag':'changeStra','aposIds':aposIds,'taskSysIds':taskSysIds};
			var retValue = openDialogFrame(getRootPath()+'/core/taskinfo/Strategy-index.jsp',param,"800","650");
			if(retValue!=undefined){
				flashTable("idTaskInfo");
			}
			
  		}  
  	}
  //从页面选中计划生成数据到通知表
  function genNotice(){
  
  	var rows = $('#idTaskInfo').datagrid('getSelections');
	var num = rows.length;
	var ids = null;
	var fields=null;
	if(num < 1){
		msgShow('提示消息','请选择你要生成通知的记录!','info');
	}else{
		$.messager.confirm('确认', "请确认要生成POSP通知吗?", function(r){
			if (r) {
			for(var i = 0; i < num; i++){
				if(null == ids || i == 0){
					ids = $.trim(rows[i].KEYID);
				} else {
				    ids = $.trim(ids) + "," + $.trim(rows[i].KEYID);
				}
			}
			fields=rows[0].FIELDS;
		  	var param=buildDelParam(ids,fields);
		  	
		  	//打开窗口选择TMS参数，如果不做设置，那么消息参数为空
		  /*	
		  	retValue=openDialogFrame(getRootPath()+"/core/taskinfo/PospNoticePara.jsp","","400","300");
		  	if(retValue == "" || retValue == null || retValue == undefined) {
  	    	   return;
  	          }
  	          param=param+"&posinfo="+retValue;
		  	*/
		  	     //url: genPospNotice.do
		  	 	var tmsModuleTitle = escape(escape($("#idTmsModuleTitle").val()));
		        var tmsModuleId= $("#idTmsModuleId").val();   
		        //alert(tmsModuleId); 
		        param=param+"&tmsModuleTitle="+tmsModuleTitle+"&tmsModuleId="+tmsModuleId
				$.getJSON("genPospNotice.do",param,function(data){
				if (null != data && null != data.status && "" != data.status&&data.status=="true") {
					msgShow('提示消息','生成posp通知成功!','info');
					flashTable("idTaskInfo");
					//clearSelect('idTaskInfo');
					//$('#idTaskInfo').datagrid('clearSelections');
						//alert(222);
					//flashTable(dataTableId);
				} else {
					if(data.message==null||data.message==""){
						msgShow('提示消息','生成posp通知失败！','warning');
						//clearSelect('idTaskInfo');
						//flashTable("idTaskInfo");
					}else{
						msgShow('提示消息',data.message,'warning');
					}
				}
			});
		  }
		});
	  }
	  
	  
	  
  }
  
  