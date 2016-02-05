	$(function(){
		  var k=window.dialogArguments; 
		  if(!k.par){
          	return ;
          }
		  	var param=k.par;//alert(param);//TASK_SYS_ID=&PLAN_CODE=&APOS_ID=&REG_ID=&REG_ENTIRE_ID=&PLAN_NAME=
		  	var idTaskSysId = param.substring(param.lastIndexOf('TASK_SYS_ID=')+12,param.lastIndexOf('&PLAN_CODE='));
		  	var idPlanCode = param.substring(param.lastIndexOf('PLAN_CODE=')+10,param.lastIndexOf('&APOS_ID='));
		  	var idAposId = param.substring(param.lastIndexOf('APOS_ID=')+8,param.lastIndexOf('&REG_ID='));
		  	var idRegId= param.substring(param.lastIndexOf('REG_ID=')+7,param.lastIndexOf('&PLAN_NAME='));
		  	//var idRegEntireId= param.substring(param.lastIndexOf('REG_ENTIRE_ID=')+14,param.lastIndexOf('&PLAN_NAME='));
		  	var idPlanName= param.substring(param.lastIndexOf('PLAN_NAME=')+10);
		  	idPlanName=unescape(unescape(idPlanName));
		  	//alert(idTaskSysId); alert(idPlanCode);alert(idAposId);alert(idRegId);
            $('#idTaskSysId').val(idTaskSysId);
          	$('#idPlanCode').val(idPlanCode);
          	$('#idAposId').val(idAposId);
		  	$('#idRegId').val(idRegId);
		  	//$('#idRegEntireId').val(idRegEntireId);
		  	$('#idPlanName').val(idPlanName);

		  	param ={'TASK_SYS_ID':idTaskSysId};//为什么要这种方式后台才能取到参数？？？？？？
		  	
			$.getJSON("queryTaskInfo.do",param,function(data){
				$.each(data.rows,function(idx,item){
					$("#idStrategyId").val($.trim(item.STRATEGY_ID));
					$("#idRegName").val($.trim(item.REG_NAME));
					$("#idDownBtime").val($.trim(item.DOWN_BTIME));
					$("#idDownEtime").val(item.DOWN_ETIME);
					$("#idRegEntireId").val(item.REG_ENTIRE_ID);
				});
		     }); 
			  
			var lastIndex;
			$('#idTaskAppTerminalInfo').datagrid({
				title:'任务应用明细',
				iconCls:'icon-save',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:true,
				url:'listTaskAppTerminalInfo.do',
				queryParams:param,
				sortName: 'KEYID',
				sortOrder: 'desc',
				remoteSort: false,
				idField:'KEYID',
				//pageSize:20,
				pagination:false,
				//rownumbers:true,
				frozenColumns:[[
	                {field:'ck',checkbox:true},
	                {field:'FIELDS',title:'FIELDS',hidden:true},
	                {title:'KEYID',field:'KEYID',hidden:true}
				]],
				columns:[[
			//{title:'计划编号',field:'PLAN_CODE',align:'center',width:100,sortable:true},
			//{title:'应用终端号',field:'APOS_ID',align:'center',width:100,sortable:true},
			{title:'应用编号',field:'APP_ID',align:'center',width:80,sortable:true},
			{title:'应用名称',field:'APP_NAME',align:'center',width:100,sortable:true},
			{title:'应用版本',field:'APP_VER',align:'center',width:90,sortable:true},
			{title:'主应用标志',field:'MASTER_APP_FLAG_NAME',align:'center',width:80,sortable:true},
			//{title:'参数模板编号',field:'PARAM_MODEL_ID',align:'center',width:100,sortable:true},
			{title:'应用更新标志',field:'APP_UPDATE_FLAG_NAME',align:'center',width:85,sortable:true},
			{title:'参数更新标志',field:'PARAM_UPDATE_FLAG_NAME',align:'center',width:85,sortable:true},
			{title:'商户编码',field:'MERCH_ID',align:'center',width:130,formatter:function(value,rowData,rowIndex){
						if(value.indexOf('T')>=0){//自动生成的商户号不显示
							return "";
						}
						return value;
						}},
			{title:'终端号',field:'TERMINAL_ID',align:'center',width:100,editor:"text"},
			//{title:'分店编码',field:'SUB_ID',align:'center',width:100},
			{title:'更新时间',field:'UPDATE_DATE',align:'center',width:100,sortable:true},
//			{title:'分支机构编号',field:'REG_ID',align:'center',width:100,sortable:true},
//			{title:'机构代码',field:'ORG_ID',align:'center',width:100,sortable:true},
			{title:'备注',field:'DESC_TXT',align:'center',width:100,sortable:true}
				]],
				toolbar:[{
					id:'btnadd',
					text:'增加应用',
					iconCls:'icon-add',
					handler:function(){     
			            var idTaskSysId = $('#idTaskSysId').val();
			          	var idPlanCode = $('#idPlanCode').val();
			          	var idAposId = $('#idAposId').val();
					  	var idRegId = $('#idRegId').val();
					  	var idRegEntireId = $('#idRegEntireId').val();
					  	//var idPlanName = $('#idPlanName').val();
				      var param={'taskSysId':idTaskSysId,'planCode':idPlanCode,'aposId':idAposId,'regId':idRegId,'regEntireId':idRegEntireId,'srcFlag':'addTerm'};//srcFlag用于区别修改应用(应用下拉框不可选)
					  openDialogFrame(getRootPath()+'/core/taskappterminalinfo/TaskAppTerminalInfo-add.jsp',param,"500","370");
					  flashTable("idTaskAppTerminalInfo");
				  }
				},{
					id:'btnsave',
					text:'修改应用',
					disabled:false,
					iconCls:'icon-edit',
					handler:function(){   
						var ids=updateValidate("idTaskAppTerminalInfo");
					    if(ids){ 
					    	var retValue=openDialogFrame(getRootPath()+"/core/taskappterminalinfo/TaskAppTerminalInfo-edit.jsp",ids,"500","370");
							if(retValue=="true"){
								msgShow("修改","修改成功!","info");
								flashTable("idTaskAppTerminalInfo");
							}else if(retValue=="false"){
						       msgShow("修改","修改失败!","error");
						    }
					    }
				  }
				},{
					id:'btncut',
					text:'删除应用',
					iconCls:'icon-remove',
					handler:function(){
						deleteNoteById("idTaskAppTerminalInfo","delTaskAppTerminalInfo.do", "");
					}
				},'-',{
					id:'btnsave',
					text:'应用参数管理',
					disabled:false,
					iconCls:'icon-edit',
					handler:function(){   
						var ids=updateValidate("idTaskAppTerminalInfo");
					    if(ids){
					    	var retValue=openDialogFrame(getRootPath()+"/core/taskposappparam/TaskPosAppParam-index.jsp",ids,"800","450");
							if(retValue=="true"){
								msgShow("修改","修改成功!","info");
								flashTable("idTaskAppTerminalInfo");
							}else if(retValue=="false"){
						       msgShow("修改","修改失败!","error");
						    }
					    }
				  }
				}]
				/*,
				onAfterEdit:function(rowIndex, rowData, changes){//参数值修改退出时,要能自动提交,不需点击更新按钮
					$('#idTaskAppTerminalInfo').datagrid('acceptChanges');//使修改的值生效
					//getObjectProp(rowData);
					alert(','+rowData.MERCH_ID+','+rowData.TERMINAL_ID+',');
					if(rowData.MERCH_ID&&rowData.MERCH_ID!=null&&rowData.MERCH_ID!=''
						&&rowData.TERMINAL_ID&&rowData.TERMINAL_ID!=null&&rowData.TERMINAL_ID!=''){//商户终端号都填写完整时提交
						updateTaskAppTerm(rowData.KEYID);				
					}
				},
				onUnselect:function(rowIndex, rowData){//参数值修改退出时,要能自动提交,不需点击更新按钮（只有一行数据时点其他列提交）
					$('#idTaskAppTerminalInfo').datagrid('acceptChanges');//使修改的值生效
					alert(','+rowData.MERCH_ID+','+rowData.TERMINAL_ID+',');
					if(rowData.MERCH_ID&&rowData.MERCH_ID!=null&&rowData.MERCH_ID!=''
						&&rowData.TERMINAL_ID&&rowData.TERMINAL_ID!=null&&rowData.TERMINAL_ID!=''){//商户终端号都填写完整时提交
						updateTaskAppTerm(rowData.KEYID);				
					}
				},
				onClickCell:function(rowIndex, field, value){//参数值修改退出时,要能自动提交,不需点击更新按钮（只有一行数据时点其他列提交）
					//alert(field);alert(value);
					if(field=='MERCH_ID'||field=='TERMINAL_ID'){
						$(this).datagrid('endEdit', lastIndex);
						$(this).datagrid('beginEdit', rowIndex);//允许编辑才能修改 商户号、分店号
						lastIndex = rowIndex;
						if(field=='MERCH_ID'){
							var retValue=openDialogFrame(getRootPath()+"/core/merchinfo/merchinfo-query.jsp","","800","500");
							if(retValue!=undefined){
								var reg = retValue.split("_");
								var row = $(this).datagrid('getData').rows[rowIndex];
								//getObjectProp(row);
								row.MERCH_ID=reg[0];//alert(row.MERCH_ID);
								row.SUB_ID=reg[2];
								$(this).datagrid('acceptChanges');//触发onAfterEdit事件,使修改的值在页面显示
							}
						}
					}
				}	*/				
			});

		});
		
	/*修改商户终端号
	function updateTaskAppTerm(keyid){
		$('#idTaskAppTerminalInfo').datagrid('acceptChanges');//使修改的值生效
		var rows = $('#idTaskAppTerminalInfo').datagrid('getRows');//返回当前页的行
		for(var i=0;i<rows.length;i++){
			//getObjectProp(rows[i]);
			if(rows[i].KEYID===keyid){
			//alert(rows[i].APP_VER);
				$.post('updateTaskAppTerminalInfo.do', rows[i],function(data) {
					
				});
				break;
			}
		}
	}*/
