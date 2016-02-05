<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.landi.tms.util.XMLHelper"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<meta http-equiv="X-UA-Compatible" content="IE=8">
<html>
<head>
  <base href="<%=basePath%>">
  <base target="_self">
	<title></title>
	<link rel="stylesheet" type="text/css" href="themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="themes/icon.css">
	<link rel="stylesheet" type="text/css" href="css/default.css">
	<link rel="stylesheet" type="text/css" href="css/zTreeStyle/zTreeStyle.css">
	<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="js/jquery.bgiframe.js"></script>
	<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="js/Toolbar.js"></script>
    <script type="text/javascript" src="js/common.js"></script>
    <script type="text/javascript" src="js/jquery.ztree.all-3.1.min.js"></script>
    <script type="text/javascript" src="core/subrole/Subrole-js.js"></script>
	<script type="text/javascript">
		//新增权限
		function doNew(){
			var retValue=openDialogFrame("<%=basePath%>core/subrole/Subrole-add.jsp","","400","200");
			if(retValue=="true"){
				msgShow("新增","新增成功!","info");
				showSubrole();
			}
		}
		
		//删除权限
		function doDel(){
			
		 	var tree = getTree('roleTree');
		 	//判断当前是否选择了子角色
		 	var nodes = tree.getSelectedNodes();
		 	if(nodes.length==0) {
		 		msgShow("提示","请选择要删除的权限","info");
		 	}else if(nodes.length>1) {
		 		msgShow("提示","只能同时选择一个权限","info");
		 	}else{
		 		if(nodes[0].level==0) {
		 			msgShow("提示","请选择权限节点","info");
		 			return false;
		 		}
		 		//执行删除
		 		$.messager.confirm('确认', "确定删除所选信息吗？", function(r){
		 			if(r) {
		 				var node = nodes[0];
				 		$.getJSON("delSubrole.do",{SUBROLEID:node.id, tmsModuleId:tmsJ5ModuleId, tmsModuleTitle:escape(tmsJ5ModuleTitle)},function(data){
								if (null != data && null != data.status && "" != data.status&&data.status=="true") {
									msgShow('提示消息',data.message,'info');
									//tree.refresh();
									showSubrole();
									resetMenuAndBtn();//刷新菜单树与功能按钮界面
								} else {
									if(data.message==null || data.message=="") {
										msgShow('提示消息',"删除失败",'warning');
									}else{
										msgShow('提示消息',data.message,'warning');
									}
								}
							}
						);
		 			}
		 		});
		 	}
		}
		
	</script>
</head>

<body class="easyui-layout">
	<div region="west" split="false" style="width:300px;padding:2px;" title="所有权限">
		<ul id="roleTree" class="ztree"></ul>		
	</div>
	<div region="center" split="false" style="padding:2px;" >
	
	
	<div class="easyui-layout" split="false" fit="true" style="width:100%;height:100%;">
			
		<div region="center" split="false">
			<div class="easyui-panel" title="系统菜单" tools="#tt" fit="true">
				<span id="tip">请从左边选择权限进行操作</span>
				<ul id="menuTree" class="ztree"></ul>
			</div>
			<div id="tt">
				<input type="button" class="btn_grid" style="margin-right:2px;" value="全选" onclick="checkAll()"/>
				<input type="button" class="btn_grid" style="margin-right:2px;" value="反选" onclick="uncheck()"/>
				<input type="button" class="btn_grid" style="margin-right:2px;" value="全部展开" onclick="expandAll()"/>
				<input type="button" class="btn_grid" value="全部折叠" onclick="collapseAll()"/>
			</div>
		</div>
	
		<div region="south" split="false" style="height:50px;padding:2px;">
			<input type="button" id="btnSaveMenuMap" class="btn_grid" onclick="saveMenuMap()" value="保存菜单权限" disabled/>
			<div>
				点击菜单权限的树节点来修改每个模块的操作功能权限（增加，修改，删除）
			</div>
		</div>
	</div>
	</div>

	<div region="east" split="false" style="width:210px" title="功能按钮设置">
		<div id="buttonMapDiv" style="display:none;">
			<table width="200px" border="0" cellpadding="0" cellspacing="0" style="margin-top:5px;" >
            	<tbody>
            		<tr><td align="center">
            			<input type="button" class="btn_grid" value="全选" onclick="btnmap_checkAll()" />
            			<input type="button" class="btn_grid" value="重置" onclick="btnmap_reset()" />
            		</td></tr>
            		<tr>
            			<td>
            				<HR width="80%" color=#987cb9 SIZE=1>
            			</td>
            		</tr>
    				<tr><td><input style="margin-left:50px;" type="checkbox" name="funButtonName" value="1">增加</td></tr>
    				<tr><td><input style="margin-left:50px;" type="checkbox" name="funButtonName" value="1">修改</td></tr>
    				<tr><td><input style="margin-left:50px;" type="checkbox" name="funButtonName" value="1">删除</td></tr>
  					<tr><td><input style="margin-left:50px;" type="checkbox" name="funButtonName" value="1">导入</td></tr>
    				<tr><td><input style="margin-left:50px;" type="checkbox" name="funButtonName" value="1">导出EXCEL</td></tr>

    				<tr>
            			<td>
            				<HR width="80%" color=#987cb9 SIZE=1>
            			</td>
            		</tr>
					<tr>
						<td>
							<div align="center" style="margin-top:5px;">
								<input type="button" class="btn_grid" style="height:24px;" id="btnMap" onclick="saveButtonMap()" value="保存" />
								<input type="button" class="btn_grid" style="height:24px;" id="btnMapBatch" onclick="saveButtonMapBatch()" value="批量保存" />
								<!-- 
								<a href="javascript:void(0)" id="btnMap" onclick="saveButtonMap()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
      							<a href="javascript:void(0)" id="btnMapBatch" onclick="saveButtonMapBatch()" class="easyui-linkbutton" iconCls="icon-ok">批量保存</a>
      							 -->
    						</div>
    					</td>
    				</tr>
				<tbody>
			</table>
		</div>
	</div>
	<div region="south" border="false" style="height: 30px;position:relative;background:url('<%=basePath%>images/indexbg.png') repeat;">  
		<div id="toolbar"></div>
	</div>
</body>

</html>
