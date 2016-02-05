	$(function(){
		  if(document.getElementById("idFactoryInfo")){
			$('#idFactoryInfo').datagrid({
				iconCls:'icon-save',
				fit:true,
				nowrap: false,
				striped: true,
				collapsible:true,
				url:'listFactoryInfo.do',
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
			{title:'厂商编号',field:'FID',width:100,align:'center',sortable:true},
			{title:'厂商名称',field:'F_NAME',width:100,align:'center',sortable:true},
			{title:'厂商地址',field:'F_ADDR',width:150,align:'center',sortable:true},
			{title:'联系人',field:'CONNECTER',width:100,align:'center'},
			{title:'商务电话',field:'BUS_TELE_NO',width:100,align:'center',sortable:true},
			{title:'支持电话',field:'SUP_TELE_NO',width:100,align:'center',sortable:true},
			{title:'传真',field:'FAX_NO',width:100,align:'center',sortable:true},
			{title:'邮政编码',field:'POST_CODE',width:80,align:'center',sortable:true},
			{title:'服务点信息',field:'SUPPORT_INFO',width:80,align:'center',sortable:true,hidden:true},
			{title:'JAVA插件',field:'PLUG_NAME',width:260,align:'center',sortable:true}
				]]
			});
			
			$(".import_toolbar").attr('disabled', true);
			$(".export_toolbar").attr('disabled', true);
		
			}
	
		});
		
    
    
      function checkExistFactoryInfo(fid){
           var len=$.trim(fid).length;
           if(len == 0){
             return;
           }
		    var flag =  checkPKIsExist("fid",fid,"checkExistFactoryInfo");
			if(flag=="true"){
			     $("#idExist").val(flag);
				 msgShow("提示","您所输入的终端厂商编号已经存在，请修改!!!","error");
			}else if(flag ="false") {
				 $("#idExist").val("");
			}
	   }