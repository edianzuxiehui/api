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
				pagination:true,
				rownumbers:true,
				//onDblClickRow:doubleClickMerch,
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
			{title:'分支机构',field:'REG_NAME',align:'center',width:130,sortable:true}//,
			//{title:'商户属性',field:'MERCH_ATTR',align:'center',width:100,sortable:true},
			//{title:'商户MCC',field:'MERCH_MCC',align:'center',width:100,sortable:true},
			//{title:'联系人',field:'CONNECTER',align:'center',width:100,sortable:true},
			//{title:'联系电话',field:'OPER_CALLNO',align:'center',width:120,sortable:true},
			//{title:'传真',field:'FAX_NO',align:'center',width:100,sortable:true},
			//{title:'Email地址',field:'EMAIL',align:'center',width:100,sortable:true},
			//{title:'邮政编码',field:'POST_CODE',align:'center',width:110,sortable:true}
		//	{title:'商户状态',field:'MERCH_STATUS',align:'center',width:100,sortable:true},
		
				]],
				//onLoadSuccess:function(data){
				//},
				toolbar:[{
					text:"选中",
					iconCls:'icon-add',
					handler:addMerchSelect
				}]
				/*,
				onSelect:function(rowIndex, data){
					var index = $('#idMerchInfoForSelect').datagrid('getRowIndex',data);
	      			if(index==-1){
	      				$('#idMerchInfoForSelect').datagrid('appendRow',data);
	      			}
				},
				onUnselect:function(rowIndex, data){
				      	var index = $('#idMerchInfoForSelect').datagrid('getRowIndex',data);
				    	$('#idMerchInfoForSelect').datagrid('deleteRow',index);
				},
				onLoadSuccess:function(data){
				}*/
			});
            initDataForMerchInfo('idOrgId');//初始化数据
	
			
			$('#idMerchInfoForSelect').datagrid({
				title:'已选商户资料列表',
				iconCls:'icon-save',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:true,
				sortName: 'MERCH_ID',
				sortOrder: 'desc',
				remoteSort: false,
				idField:'MERCH_ID',
				rownumbers:true,
				/*
				frozenColumns:[[
	                {field:'FIELDS',title:'FIELDS',hidden:true},
	                {title:'KEYID',field:'KEYID',hidden:true}
				]],
				*/
				columns:[[
			{title:'商户编号',field:'MERCH_ID',align:'center',width:130,sortable:true},
			{title:'商户名称/分店',field:'MERCH_NAME',align:'center',width:120,sortable:true},
			//{title:'网络接入服务商',field:'ORG_NAME',align:'center',width:150,sortable:true},
			//{title:'分店编号',field:'SUB_ID',align:'center',width:100,sortable:true},
			{title:'分支机构',field:'REG_NAME',align:'center',width:100,sortable:true},
			{title:'操作',field:'CONNECTER',align:'center',width:65,
				formatter:function(value,rowData,rowIndex){ 
                       var a='<input type="button" class="btn_grid" value=" 删除 " onclick="deleteRow(\''+ rowData.MERCH_ID+ '\')"/>';
                        return a;  
                    }
			}
			//{title:'商户属性',field:'MERCH_ATTR',align:'center',width:100,sortable:true},
			//{title:'商户MCC',field:'MERCH_MCC',align:'center',width:100,sortable:true},
			//{title:'联系人',field:'CONNECTER',align:'center',width:100,sortable:true},
			//{title:'联系电话',field:'OPER_CALLNO',align:'center',width:120,sortable:true},
			//{title:'传真',field:'FAX_NO',align:'center',width:100,sortable:true},
			//{title:'Email地址',field:'EMAIL',align:'center',width:100,sortable:true},
			//{title:'邮政编码',field:'POST_CODE',align:'center',width:110,sortable:true}
		//	{title:'商户状态',field:'MERCH_STATUS',align:'center',width:100,sortable:true},
		
				]],
				onLoadSuccess:function(data){
				}
			});
			var k=window.dialogArguments; 
		  	if(k.par){
		  		var param=k.par;
		  		url ="listMerchInfo.do?"+param;
		  		$('#idMerchInfoForSelect').datagrid('options').url = url;// 改变它的url  
			    $("#idMerchInfoForSelect").datagrid('load');
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
    
    function addMerchSelect(){
    	var selectRows = $('#idMerchInfo').datagrid('getSelections');
    	var num = selectRows.length;
    	var merchs = new Array();
      	if(num>0){
      		$.each(selectRows,function(index,row){
      			var rowIndex = $('#idMerchInfoForSelect').datagrid('getRowIndex',row.MERCH_ID);
      			if(rowIndex==-1){
      				$('#idMerchInfoForSelect').datagrid('appendRow',row);
      			}else{
      				if(merchs.length<3){
      					merchs.push(row.MERCH_ID);
      				}
      			}
      		});
      		var length = merchs.length;
      		if(length>0){
      			msgShow("选择","成功选择商户，其中商户"+merchs.join(", ")+"等已选择","info");
      		}else{
      			msgShow("选择","成功选择商户！","info");
      		}
      	}else{
      		msgShow("选择","请在商户资料列表中选择商户！","info");
      	}
    }
    
    function deleteRow(rowData){
      	var rowIndex = $('#idMerchInfoForSelect').datagrid('getRowIndex',rowData);
    	$('#idMerchInfoForSelect').datagrid('deleteRow',rowIndex);
    }
    
    //点击确认时主商户赋值
    function confirm(){
    	var selectRows = $('#idMerchInfoForSelect').datagrid('getRows');
    	var selectMerchRows = $('#idMerchInfo').datagrid('getRows');
    	var num=selectRows.length;
    	if(num<1){
    		msgShow("选择","请选择商户！","info");
    		return false;
    	}
    	
      if(selectRows){
      	if(selectRows.length>1){
      		var returnValue ="";
      		$.each(selectRows,function(index,row){
      			if(index>0){
      				returnValue += ","; 
      			}
      			returnValue += row.MERCH_ID;
      		});
      		window.returnValue = returnValue;
      	}else{
      				//alert(11);
      				//window.returnValue = "single_"+$('#idMerchInfo').datagrid('getSelected').MERCH_ID+"_"+$('#idMerchInfo').datagrid('getSelected').MERCH_NAME;
      				//window.returnValue = "single_"+$('#idMerchInfoForSelect').datagrid('getRows').MERCH_ID+"_"+$('#idMerchInfoForSelect').datagrid('getRows').MERCH_NAME;
      				
      				
      	     		var returnValue ="";
      	      		$.each(selectRows,function(index,row){
      	      			if(index>0){
      	      				returnValue += "_"; 
      	      			}
      	      			returnValue += row.MERCH_ID+"_"+row.MERCH_NAME;
      	      		});
      	      		window.returnValue = "single_"+returnValue;
      	}
      }
        window.close();
    }
    
 
 
 
 