	$(function(){
		
			$('#idPlanAppInfo').datagrid({
				title:'table标题---自己先修改下',
				iconCls:'icon-save',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:true,
				url:'listPlanAppInfo.do',
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
			{title:'计划编号',field:'PLAN_CODE',align:'center',width:100,sortable:true},
			{title:'应用编号',field:'APP_ID',align:'center',width:100,sortable:true},
			{title:'应用版本',field:'APP_VER',align:'center',width:100,sortable:true},
			{title:'参数模板编号',field:'PARAM_MODEL_ID',align:'center',width:100,sortable:true},
			{title:'更新时间',field:'UPDATE_DATE',align:'center',width:100,sortable:true},
			{title:'应用更新标志',field:'APP_UPDATE_FLAG',align:'center',width:100,sortable:true},
			{title:'参数更新标志',field:'PARAM_UPDATE_FLAG',align:'center',width:100,sortable:true},
			{title:'主应用标志',field:'MASTER_APP_FLAG',align:'center',width:100,sortable:true},
			{title:'分支机构编号',field:'REG_ID',align:'center',width:100,sortable:true}
				]]
			});
			
	
		});
		
		
		
		
		
		function addPlanAppInfo(){
			$('#ff').form('submit',{
		        url:'addPlanAppInfo.do',
			    onSubmit:function(){
			        return $(this).form('validate');
			    },
			    success:function(data){
			      var myObject = eval('(' + data + ')');
			       //这种方式直接关闭窗口，返回true或者false给主窗口
			       // window.close();
			       // window.returnValue=myObject.status; 
			        
			        //这种错误情况下方式不关闭窗口	 
			       if(myObject.status=="true"){
						 window.close();
			        	 window.returnValue=myObject.status; 
			        }else if(myObject.status=="false"){
			        	msgShow("新增",myObject.message,"error");
			        	//window.close();
			        }
			    }
			});
		}
		
