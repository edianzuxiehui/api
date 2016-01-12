	$(function(){
		
			$('#idParamItem').datagrid({
				//title:'参数项管理',
				iconCls:'icon-save',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:true,
				url:'listParamItem.do',
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
			{title:'参数项编号',field:'PARAM_ID',align:'center',width:120,sortable:true},
			{title:'参数名称',field:'PARAM_NAME',align:'center',width:150,sortable:true},
			{title:'参数数据类型',field:'DATA_TYPE',align:'center',width:100,sortable:true},
			{title:'参数长度',field:'VALUE_LEN',align:'center',width:100,sortable:true},
			{title:'参数组别',field:'PARAM_GROUP',align:'center',width:105,sortable:true},
			{title:'默认值',field:'DEF_VALUE',align:'center',width:210,sortable:true},
			{title:'备注',field:'DESC_TXT',align:'center',width:210,sortable:true}
				]]
			});
			
			var param = window.dialogArguments;
			 if(!param||!param.par){//主界面或增加界面
				 getParamGroup();
			 }
			 
			$(".export_toolbar").attr('disabled', true);		

		});
		
		
		//获取参数组数据
		function getParamGroup(groupId){
			$.getJSON("getParamGroup.do","",function(data){
				//var myObject = eval('(' + data + ')');
			    var option; 
			    //对idAppId进行赋值
			     $.each(data,function(idx,item){ 
		            // option += "<option value=" + data.idOrgId[i].ORG_ID +">" + data.idOrgId[i].ORG_NAME+ "</option>";
			         option = new Option(item.ITEMTEXT,item.ITEMCODE);                       
                     document.getElementById("idParamGroup").options.add(option);
                     if(groupId&&groupId==item.ITEMCODE){
         		    	document.getElementById("idParamGroup").value=groupId;
         		    }
			     });
			});
			
		    

		}
		
