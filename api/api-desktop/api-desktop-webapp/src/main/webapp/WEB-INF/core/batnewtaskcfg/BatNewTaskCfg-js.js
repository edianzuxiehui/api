	$(function(){
		
			$('#idBatNewTaskCfg').datagrid({
				//title:'终端任务定制',
				iconCls:'icon-save',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:true,
				url:'listBatNewTaskCfg.do',
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
			{title:'任务批次号',field:'TAB_NO',align:'center',width:100,sortable:true},
			//{title:'策略编号',field:'STRATEGY_ID',align:'center',width:100,sortable:true},
			{title:'计划名称',field:'PLAN_NAME',align:'center',width:100,sortable:true},
			{title:'应用名称',field:'APP_NAME',align:'center',width:100,sortable:true},
			{title:'应用版本',field:'QUERY_APP_VER',align:'center',width:100,sortable:true},
			{title:'查询厂商',field:'F_NAME',align:'center',width:80,sortable:true},
			{title:'查询主机型号',field:'QUERY_MID',align:'center',width:100,sortable:true},
			{title:'查询分支机构',field:'QUERY_REG_NAME',align:'center',width:150,sortable:true},
			{title:'查询起始序列号',field:'QUERY_BEGIN_SERIAL_NO',align:'center',width:120,sortable:true},
			{title:'查询结束序列号',field:'QUERY_END_SERIAL_NO',align:'center',width:120,sortable:true},
			{title:'通讯方式',field:'QUERY_CONTACT_TYPE',align:'center',width:120,sortable:true},
			{title:'IP地址',field:'QUERY_ADDRESS',align:'center',width:120,sortable:true},
			{title:'端口',field:'QUERY_PORT',align:'center',width:120,sortable:true},
			{title:'电话号码',field:'QUERY_MOBILE',align:'center',width:120,sortable:true},
			{title:'执行状态',field:'RUN_STATUS',align:'center',width:250,sortable:true,formatter:function(value,rowData,rowIndex){
				if(value=='已执行'||value=='1'){
					if(rowData.CHECK_STATUS=='未审核'){
						return '<input id="downLoadGen'+rowData.KEYID+'" type="button" class="btn_grid" value="生成任务下载" onclick="javascript:downLoadGen(\''+rowData.TAB_NO+'\')\"/>'
						+'<input id="downLoadNotGen'+rowData.KEYID+'" type="button" class="btn_grid" value="未生成任务下载" onclick="javascript:downLoadNotGen(\''+rowData.TAB_NO+'\')\"/>';
					}else{
						return '已执行';
					}
				}else if(value=='未执行'||value=='0'){
					return value;
				}
				}},
			{title:'审核状态',field:'CHECK_STATUS',align:'center',width:100,sortable:true,formatter:function(value,rowData,rowIndex){
						if(value=='同意'||value=='1'||value=='否决'||value=='0'){
							return value;
						}else if(value=='未审核'||value=='2'){
							if(rowData.RUN_STATUS=='已执行'){
								return '<input id="check'+rowData.KEYID+'" type="button" class="btn_grid" value="审 核" onclick="javascript:checkBatNewTaskCfg(\''+rowData.KEYID+'\')\"/>';
							}else{
								return '不能审核';
							}
						}
						}},
			{title:'审核人',field:'CHECK_OPER_NAME',align:'center',width:100,sortable:true},
			{title:'审核时间',field:'CHECK_TIME',align:'center',width:130,sortable:true},
			{title:'操作员',field:'NAME',align:'center',width:100,sortable:true},
			{title:'满足条件的记录数',field:'SATISFY_COUNT_NUM',align:'center',width:100,sortable:true},
			{title:'实际生成记录数',field:'REAL_GEN_COUNT',align:'center',width:100,sortable:true},
			{title:'创建日期',field:'CREATE_DATE',align:'center',width:130,sortable:true}
				]],
				
		   onLoadSuccess:function(data){
				for(var i = 0;i<data.rows.length;i++){
					var row = data.rows[i];
					
					if(isEditAuth()&& row.CHECK_STATUS=='未审核'){
						$('#doExport'+row.KEYID).attr('disabled',false);
					}else{
						$('#doExport'+row.KEYID).attr('disabled',true);
					}
					
					if(isEditAuth()&& row.RUN_STATUS=='已执行'){
						$('#check'+row.KEYID).attr('disabled',false);
					}else{
						$('#check'+row.KEYID).attr('disabled',true);
					}
					
					if(row.SATISFY_COUNT_NUM==0||row.SATISFY_COUNT_NUM==row.REAL_GEN_COUNT){
						$('#downLoadNotGen'+row.KEYID).attr('disabled',true);
					}
					if(row.REAL_GEN_COUNT==0){
						$('#downLoadGen'+row.KEYID).attr('disabled',true);
					}
					
				}
			}
			});
			
			$('#checkDialog').dialog('close');
			initFidData();
			$(".import_toolbar").attr('disabled', true);
			$(".export_toolbar").attr('disabled', true);
		});
		
		function check(keyid,checkStatus){
			var rows = $('#idBatNewTaskCfg').datagrid('getRows');//返回当前页的行
			//alert('rows.length'+rows.length);
			for(var i=0;i<rows.length;i++){
				if(rows[i].KEYID===keyid){
	   				rows[i].tmsModuleTitle=tmsJ5ModuleTitle;//index页面直接取tmsJ5ModuleTitle值
	   				rows[i].tmsModuleId=tmsJ5ModuleId;
					rows[i].CHECK_STATUS = checkStatus;
					$.post('checkBatNewTaskCfg.do', rows[i],function(data) {
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
							$('#idBatNewTaskCfg').datagrid('updateRow',{'index':i,'row':rows[i]});
						}else if(obj.status&&obj.status=="false"){
							msgShow('审核',obj.message,'error');
						}
						//$('#idBatNewTaskCfg').datagrid('load');
					});
					break;
				}
			}
		};	
	function checkBatNewTaskCfg(keyid){//审核
		//$('#checkDialog').dialog('open');
		
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
	
		//初始化厂家型号数据，reffer to ModelInfo-js.js
		function initFidData(){
			     $.ajax({
				   type: "POST",
				   url: "initDataForModelInfo.do",
				   data: "param=idFidSelect", //参数可以是idFidSelect,idMidSelect,idDllDir
				   beforeSend :function(){
				   	 var k=window.dialogArguments; 
					 if(k&&k.par){
				    	showProcess(true,"加载终端型号","加载终端型号中...");
				     }
				    },
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
					  showProcess(false);//防止进度条一直存在
					 
				   }
				   });  	

		}

		function downLoadGen(tabNo){
			var fileName =tabNo+"-genTask.xls";
			fileName = escape(escape(fileName));
			var ret = window.open(getRootPath()+"/downFile.do?fileName="+fileName);//getObjectProp(ret);
		}
		function downLoadNotGen(tabNo){
			var fileName =tabNo+"-unGenTask.xls";
			fileName = escape(escape(fileName));
	    	var ret = window.open(getRootPath()+"/downFile.do?fileName="+fileName);//getObjectProp(ret);
		}	
		
	/*导出待审核任务明细，支持根据终端任务定制导出和全部导出*/	
	/*function exportExcel(keyid){
		var rows = $('#idBatNewTaskCfg').datagrid('getRows');
		//alert('rows.length'+rows.length);
		var tabNo = '';
		//getObjectProp(keyid);
		if(keyid!=undefined){
			for(var i=0;i<rows.length;i++){
				if(rows[i].KEYID===keyid){
					tabNo = rows[i].TAB_NO;
					break;
				}
			}
		}
		var title=escape(escape("计划名称,应用终端号,硬件序列号,主应用商户号,主应用终端号,计划开始时间,计划结束时间,分支机构"));
		var sqlId="exportTaskInfoExcel";
		var queryInfo="{'tabNo':'"+tabNo+"'}";
		var sqlcols="PLAN_NAME,APOS_ID,SERIAL_NO,MERCH_ID,TERMINAL_ID,DOWN_BTIME,DOWN_ETIME,REG_NAME";
		var filename="taskInfo";
				
		//var param={'title':title,'sqlId':sqlId,'queryInfo':queryInfo,'sqlcols':sqlcols,'filename':filename};
		var param="title="+title+"&sqlId="+sqlId+"&queryInfo="+queryInfo+"&sqlcols="+sqlcols+"&filename="+filename
		window.open(getRootPath()+"/exportExcel.do?"+param);
	}	*/	