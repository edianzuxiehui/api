	$(function(){
		
			$('#idAppMerchInfo').datagrid({
				title:'table标题---自己先修改下',
				iconCls:'icon-save',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:true,
				url:'listAppMerchInfo.do',
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
				columns:[[
					
			 {field:'opt',title:'操作',width:100,align:'center',  
                    formatter:function(value,rec,index){ 
                       
                        var a='<input type="button" class="btn_grid" value="详细信息" onclick="showDetail(\''+ rec.KEYID + '\')"/>'
                       // var k=createButton();
                        return a;  
                    }  
             } ,
			{title:'商户编码',field:'MERCH_ID',width:100,sortable:true},
			{title:'网络接入服务商号',field:'ORIG_ID',width:100,sortable:true},
			{title:'分店编码',field:'SUB_ID',width:100,sortable:true},
			{title:'商户名称',field:'MERCH_NAME',width:100,sortable:true},
			{title:'商户属性',field:'MERCH_ATTR',width:100,sortable:true},
			{title:'商户MCC',field:'MERCH_MCC',width:100,sortable:true},
			{title:'转接渠道',field:'TRAN_CHANNEL',width:100,sortable:true},
			{title:'客户号',field:'CUSTOM_ID',width:100,sortable:true},
			{title:'支付渠道',field:'PAY_CHANNEL',width:100,sortable:true},
			{title:'交易类型',field:'TRAN_TYPE',width:100,sortable:true},
			{title:'联系人',field:'CONNECTER',width:100,sortable:true},
			{title:'联系电话',field:'CALL_NO',width:100,sortable:true},
			{title:'传真',field:'FAX_NO',width:100,sortable:true},
			{title:'EMAIL',field:'EMAIL_ADDR',width:100,sortable:true},
			{title:'地址',field:'MERCH_ADDR',width:100,sortable:true},
			{title:'邮政编码',field:'POST_CODE',width:100,sortable:true},
			{title:'商户状态',field:'MERCH_STATUS',width:100,sortable:true},
			{title:'营业开始时间',field:'BUSS_TIME',width:100,sortable:true},
			{title:'营业结束时间',field:'CLOSE_TIME',width:100,sortable:true},
			{title:'数据来源',field:'DATA_ORIG',width:100,sortable:true},
			{title:'备用项1',field:'REF_1',width:100,sortable:true},
			{title:'备用项2',field:'REF_2',width:100,sortable:true},
			{title:'备用项3',field:'REF_3',width:100,sortable:true},
			{title:'分支机构',field:'REG_ID',width:100,sortable:true},
			{title:'BMS商户序号',field:'MERCHANTID',width:100,sortable:true},
			{title:'BMS分店序号',field:'SUBMERCHANTNO',width:100,sortable:true},
			{title:'地区码',field:'AREACODE',width:100,sortable:true}
				]]
			});
			
	
		});
		
		
		function createButton(){
		    var  divBtn='<div class="buttons"> <button type="submit" class="positive" onclick="javascript:alert(111)"><img src="apply2.png" alt=""/> 详细信息  </button>  </div>';
           return divBtn
		}
		
		function showDetail(keyId){
			   alert(keyId);
		}
		
		
		function resize(){
			$('#idMerchant').datagrid('resize', {
				width:document.body.clientWidth+200,
				height:450
			});
		}
		function getSelected(){
			var selected = $('#idMerchant').datagrid('getSelected');
			if (selected){
				alert(selected.id+":"+selected.name+":"+selected.addr+":"+selected.col4);
			}
		}
		function getSelections(){
			var ids = [];
			var rows = $('#idMerchant').datagrid('getSelections');
			for(var i=0;i<rows.length;i++){
				ids.push(rows[i].id);
			}
			alert(ids.join(':'));
		}
		function clearSelections(){
			$('#idMerchant').datagrid('clearSelections');
		}
		function selectRow(){
			$('#idMerchant').datagrid('selectRow',2);
		}
		function selectRecord(){
			$('#idMerchant').datagrid('selectRecord','002');
		}
		function unselectRow(){
			$('#idMerchant').datagrid('unselectRow',2);
		}
		function mergeCells(){
			$('#idMerchant').datagrid('mergeCells',{
				index:2,
				field:'addr',
				rowspan:2,
				colspan:2
			});
		}
		

