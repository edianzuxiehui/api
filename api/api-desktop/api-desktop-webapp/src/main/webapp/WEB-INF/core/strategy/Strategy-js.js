	$(function(){
		
			$('#idStrategy').datagrid({
				//title:'策略定义及分配',
				iconCls:'icon-save',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:true,
				url:'listStrategy.do',
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
			//{title:'策略编号',field:'STRATEGY_ID',align:'center',width:100,sortable:true},
			{title:'策略开始日期',field:'STRA_BDATE',align:'center',width:100,sortable:true},
			{title:'策略结束日期',field:'STRA_EDATE',align:'center',width:100,sortable:true},
			{title:'区间开始时间',field:'STRA_BTIME',align:'center',width:100,sortable:true},
			{title:'区间结束时间',field:'STRA_ETIME',align:'center',width:100,sortable:true},
			{title:'接入方式',field:'POS_FLAG',align:'center',width:100,sortable:true},
			{title:'策略类型',field:'STRATEGY_TYPE',align:'center',width:100,sortable:true},
			{title:'可接入台数',field:'AVAILABLE',align:'center',width:100,sortable:true},
			{title:'分支机构',field:'REG_NAME',align:'center',width:160,sortable:true},
			//{title:'操作',field:'oper',align:'center',width:70,formatter:function(value,rowData,rowIndex){
				//		return '<input id="oper'+rowData.STRATEGY_ID+'" type="button" class="btn_grid" value="分配" onclick="javascript:bindApos(\''+rowData.KEYID+'\')\"/>';
					//	}},
			{title:'策略状态',field:'STRA_STATUS',align:'center',width:100,sortable:true},
			{title:'预计接入台数',field:'CAPABILITY',align:'center',width:100,sortable:true},
			{title:'分散间隔(秒)',field:'SEPARATE_SECOND',align:'center',width:100,sortable:true},
			{title:'报到间隔周期(天)',field:'INTERVAL_DAYS',align:'center',width:100,sortable:true},
			{title:'允许终端最迟报到间隔(分钟)',field:'ONLINE_DELAY',align:'center',width:150,sortable:true},
			{title:'上次分配时间',field:'CURRENT_TIMES',align:'center',width:160,sortable:true},
			{title:'每台终端完成联机下载所使用时间(分)',field:'ABILITY',align:'center',width:150,sortable:true},
			{title:'失败重试次数',field:'FRTIMES',align:'center',width:100,sortable:true},
			//{title:'已分配线路数',field:'DTLINES',align:'center',width:100,sortable:true},
			{title:'备注',field:'DESC_TXT',align:'center',width:100,sortable:true}
				]],
			onLoadSuccess:function(data){
				for(var i = 0;i<data.rows.length;i++){
					var row = data.rows[i];
					if(isEditAuth()
							&&row.AVAILABLE>0
							){
						if(row.STRATEGY_TYPE=='下载策略'){
							$('#oper'+row.STRATEGY_ID).attr('disabled',true);
						}else{
							$('#oper'+row.STRATEGY_ID).attr('disabled',false);
						}
					}else{
						$('#oper'+row.STRATEGY_ID).attr('disabled',true);
					}
				}
			}				
			});
			
			regGetCapability();
			$(".import_toolbar").attr('disabled', true);
			$(".export_toolbar").attr('disabled', true);
		});

  function getCapability(event){
  	if(checkCapability()==true){
  		var beginDate = $('#idStraBtime').val();
  		var endDate = $('#idStraEtime').val();
  		var posFlag =$('#idPosFlag').val();
  		var ability =$('#idAbility').val();
  		var capability =$('#idCapability').val();
  		var capability1 =$('#idCapability1').val();
  		var regId =$('#idRegId').val();

		//修改TCP接入或电话接入修改显示文字
		if(posFlag==='1'){
			//alert($('#posFlagTxt').text());
			$('#posFlagTxt').html("<div style='text-align:right'>拨号接入线路数</div>");
		}else if(posFlag==='0'){
			$('#posFlagTxt').html("<div style='text-align:right'>TCP接入并发数</div>");
		}
		//alert(capability1);alert(capability);
  		if(event&&event.data&&event.data=='capability'
  			&&parseInt(capability1)<parseInt(capability)){
  			msgShow('策略','预计接入台数不能大于允许接入台数','info');
			$('#idCapability').val('')
			return false;
		}
  		var param;
		if(event&&event.data&&event.data==='capability'){//alert(event.data);
		  param={"STRA_BDATETIME":beginDate,"STRA_EDATETIME":endDate,"POS_FLAGE":posFlag,"ABILITY":ability,"REG_ID":regId,"CAPABILITY":capability};
		}else{//alert('event');
		 param={"STRA_BDATETIME":beginDate,"STRA_EDATETIME":endDate,"POS_FLAGE":posFlag,"ABILITY":ability,"REG_ID":regId};
		}
	    
		$.getJSON('calculateCapability.do', param,function(data) {//alert(event);alert(event.data);
			//getObjectProp(event);
			if(data.status&&data.status=="false"
				&&event&&event.type=='change'){//防止弹出多个提示框，只有改变机构的时候才弹
				msgShow('策略',data.message,'error');
				$('#idDtlines').val('');
				$('#idCapability1').val('');
				return false;
			}
			
			if(event&&event.data&&event.data!='capability'){//alert('1');
				$('#idCapability1').val(data.CAPABILITY1);
			}else if(event&&event.data&&event.data!='ability'){//alert('2');
				$('#idSeparateSecond').val(data.SEPARATE_SECOND);
			}else if(event&&!event.data){//alert('3');
				$('#idCapability1').val(data.CAPABILITY1);
			}else{
				//alert('4');
			}
			$('#idAbility').val(data.ABILITY);
			$('#idDtlines').val(data.DTLINES);	
			
			/*
			if(event&&event.data&&event.data!='capability'){
				$('#idCapability1').val(data.CAPABILITY1);
			}else if(event&&event.data&&event.data!='ability'){
				$('#idAbility').val(data.ABILITY);
			}else if(event==null||event.data==null){
				$('#idCapability1').val(data.CAPABILITY1);
				$('#idAbility').val(data.ABILITY);
			}
			$('#idSeparateSecond').val(data.SEPARATE_SECOND);
			$('#idDtlines').val(data.DTLINES);	
			*/
			
			var newCapability =$('#idCapability1').val();
	  		if(parseInt(newCapability)<parseInt(capability)){//防止预计接入终端数计算后修改日期
				$('#idCapability').val('')
				return false;
			}
		});
  	}
  }
  
  function checkCapability(){
     //$('#idStraBdate').validatebox('isValid');
    return ($('#idStraBtime').val()!="")&&($('#idStraEtime').val()!="")&&compareDate($('#idStraEtime').val(),$('#idStraBtime').val())
    //&&$('#idAbility').validatebox('isValid');
  }
  
  function regGetCapability(){//注册getCapability()方法
	  $('#idStraBtime').bind('focusin',getCapability);//change事件不起作用？？
	  $('#idStraEtime').bind('focusin',getCapability);
	  $('#idPosFlag').bind('change',getCapability);
	  $('#idCapability').bind('keyup','capability',getCapability);
	  $('#idAbility').bind('change','ability',getCapability);
	  $('#idDtlines').bind('focus',getCapability);
	  $('#idRegId').bind('change',getCapability);
  }
  
  	//分配
	function bindApos(keyid){
		var rows = $('#idStrategy').datagrid('getRows');//返回当前页的行
		for(var i=0;i<rows.length;i++){
			if(rows[i].KEYID==keyid){
				var param = {'STRATEGY_ID':rows[i].STRATEGY_ID};//'page=1&straId='+straId+'&status='+status+'&regId='+regId+'&available='+available+'&task=1;
				var returnValue= openDialogFrame(getRootPath()+'/core/strategy/strategyDist.jsp',param,1050,500);
				$('#idStrategy').datagrid('load');
				break;
			}
		}
	}  
	
    //重写queryReg方法,在机构选择完，触发修改线路数
   function queryReg(regId,regName,regEntireId){
	var retValue=openDialogFrame(getRootPath()+"/core/reginfo/RegInfo-query.jsp","","400","300");
	if(retValue!=undefined){
		$('#'+regId).val(retValue.reg_id);
		$('#'+regName).val(retValue.reg_name);
		if(regEntireId!=undefined) {
			$('#'+regEntireId).val(retValue.reg_entire_id);
		}
		$('#idRegId').change();
	}
  }
   
   function onStrategyTypeChange(){//若为下载策略，则报道间隔周期为1天
	   var strategyType =$('#idStrategyType').val();
		if(strategyType=='1'){
			$('#idIntervalDays').val("30");
			$('#idIntervalDays').attr("readonly",false);
			$('#idIntervalDays').css('background-color','#FFFFFF');
		}else if(strategyType=='0'){
			$('#idIntervalDays').val("1");
			$('#idIntervalDays').attr("readonly",true);
			$('#idIntervalDays').css('background-color','#EEEEEE');
			
		}
   }