<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
	<script type="text/javascript" src="zTree.js"></script>
	<script type="text/javascript">
		//新增子角色
		function doNew(){
			var tree = $.fn.zTree.getZTreeObj('roleTree');
			var nodes = tree.getSelectedNodes();
			if(nodes.length==0 || nodes[0].level==0) {
				msgShow('提示','请选择子系统','info');
			}else{
				var sysid;
				if(nodes[0].level==1) {
					sysid = nodes[0].id;
				}else{
					sysid = nodes[0].getParentNode().id;
				}
				var param = new Object();
				param.sysid = sysid
				var retValue=openDialogFrame("<%=basePath%>core/subrole/Subrole-add.jsp",param,"600","300");
				if(retValue=="true"){
					msgShow("新增","新增成功!","info");
					//刷新树
					refreshTree('roleTree');
				}
			}
		}
		
		//删除子角色
		function doDel(){
			
		 	var tree = $.fn.zTree.getZTreeObj('roleTree');
		 	//判断当前是否选择了子角色
		 	var nodes = tree.getSelectedNodes();
		 	if(nodes.length==0) {
		 		msgShow("提示","请选择要删除的子角色","info");
		 	}else if(nodes.length>1) {
		 		msgShow("提示","只能同时选择一个子角色","info");
		 	}else{
		 		//执行删除
		 		$.messager.confirm('确认', "确定删除所选信息吗？", function(r){
		 			if(r) {
		 				var node = nodes[0];
				 		$.getJSON("delSubrole.do","SUBROLEID="+node.id,function(data){
								if (null != data && null != data.status && "" != data.status&&data.status=="true") {
									msgShow('提示消息',data.message,'info');
									refreshTree('roleTree');
								} else {
									msgShow('提示消息','删除失败！','warning');
								}
							}
						);
		 			}
		 		});
		 	}
		}
		function refreshTree(treeId) {
			var tree = $.fn.zTree.getZTreeObj(treeId);
			var node = tree.getNodes()[0];//取得根节点
			tree.reAsyncChildNodes(node,'refresh',false);
		}
		
		//创建子角色树 begin
		function showSubrole() {
			var setting = {
				data: {
					simpleData: {
						enable: true
					}
				},
				view: {
					showLine: false
				},
				callback: {
					onClick: function(event,treeId,treeNode,clickFlag) {
						if(treeNode.level==2) {
							var subroleid = treeNode.id;
							var sysid = treeNode.getParentNode().id;
							var sysname = treeNode.getParentNode().name;
							var deptId = treeNode.deptId;
							showMenu(sysid,subroleid,sysname,deptId);//显示菜单树
							$('#buttonMapDiv').css('display','');//显示功能按钮设置
							initButtonMap();
						}
					},
					onAsyncSuccess: function(event,treeId,treeNode,msg) {
						var tree = $.fn.zTree.getZTreeObj(treeId);
						if(treeNode.level==0) {
							tree.reAsyncChildNodes(treeNode.children[0],'refresh',false);
						}
					}
				},
				async: {
					enable: true,
					url:"getsubrole.do",
					autoParam:["id", "level=lv"]
				}
			};
	
			var zNodes =[
				{ id:"-1", name:"所有子系统角色", open:true, isParent:true}
			];
			
			$.fn.zTree.init($("#roleTree"), setting, zNodes);
			//展开角色树节点
			refreshTree('roleTree');
		}
		
		//页面加载完毕显示子系统角色树
		$(document).ready(function(){
			showSubrole();
		});
		//创建子角色树 end		
		
		//显示子系统菜单
		function showMenu(sysid,subroleid,sysname,deptId) {
			$('#tip').hide();
			$("#menuTree").css("display","block"); 
			$('#btnMenu').css("display","");
			$('#note').css('display','');
			var zNodes =[{id:sysid, name:sysname+'菜单', subroleid:subroleid, open:true, isParent:true, nocheck:true}]; 
			var setting = {
				check: {
					enable: true
		    	},
		    	chkStyle: "checkbox",
		    	chkboxType: { "Y" : "ps", "N" : "ps" },
				async: { //异步加载
					enable: true,
					url: "getmenutree.do",
					autoParam: ["id","level=lv"],//需要传递的参数
					otherParam:['sysid',sysid,'subroleid',subroleid,'deptId',deptId]//传递参数 子系统ID,子角色ID,部门ID
				},
				callback: {
					onClick: function(event,treeId,treeNode,clickFlag) {
						if(treeNode.level!=0) {
							var moduleid = treeNode.id;//模块ID
							var subroleid = treeNode.subroleid;//子角色ID
							var deptId = treeNode.deptId;//部门ID
							var buttonMap = treeNode.buttonMap;//功能操作位图
							setupButtonMap(moduleid,subroleid,buttonMap,deptId);
						}
					}
				}
			};
			$.fn.zTree.init($("#menuTree"), setting, zNodes);//初始化树对象
			refreshTree('menuTree');//刷新树
		}
		
		//显示操作功能权限设置窗口
		function setupButtonMap(moduleid,subroleid,buttonMap,deptId) {
			var chk = $('[name=funButtonName]');//取得功能checkbox
			buttonMap = $.trim(buttonMap);
			for(var i=0;i<buttonMap.length;i++) {
				if(chk[i].value==buttonMap.substring(i,i+1)) {
					chk[i].checked = true;
				}else{
					chk[i].checked = false;
				}
			}
			//$('#btnMap').show();
			//$('#btnMapBatch').show();
		}
		
		//初始化功能权限
		function initButtonMap() {
			var chk = $('[name=funButtonName]');//取得功能checkbox
			for(var i=0;i<chk.length;i++) {
				chk[i].checked = false;
			}
			//$('#btnMap').hide();
			//$('#btnMapBatch').hide();
		}
		
		//保存菜单权限
		function saveMenuMap() {
			showProcess(true,"稍等", "正在保存中……");
			
			//获取菜单树当前选中的节点，寻找逻辑为：按层级遍历，如果当前节点为全选节点，将当前节点加入全选列表，停止遍历其子节点；
			//如果当前节点为半选节点，将当前节点加入半选列表，需要继续遍历其子节点
			var tree = $.fn.zTree.getZTreeObj('menuTree');
			var node = tree.getNodes()[0];//取得根节点
			var sysid = node.id; //子系统ID
			var nodeIdObj = new Object();
			nodeIdObj.checkList = "";
			nodeIdObj.halfList = "";
			var children = node.children;
			for(var i=0;i<children.length;i++) {
				travelNodes(children[i],nodeIdObj);
			}
			var subroleid = children[0].subroleid;
			var deptId = children[0].deptId;
			var param = "check="+nodeIdObj.checkList.substring(0,nodeIdObj.checkList.length-1);
			param += "&half="+nodeIdObj.halfList.substring(0,nodeIdObj.halfList.length-1);
			param += "&subroleid="+subroleid;
			param += "&deptId="+deptId;
			param += "&sysid="+sysid;
			$.getJSON("saveMenuAuthor.do",param,function(data){
					showProcess(false);
					
					if (null!=data && null!=data.status && data.status=="true") {
						msgShow('提示消息',"模块权限保存成功",'info');
						refreshTree('menuTree');
						//var tree = $.fn.zTree.getZTreeObj('menuTree');
						//tree.refresh();
					}else{
						msgShow('提示消息','模块权限保存失败','warning');
					}
				});
			
		}
		
		//递归遍历节点
		function travelNodes(node,nodeIdObj) {
			//node为当前树节点,checkList为全选列表,halfList为半选列表
			var status = node.getCheckStatus();
			if(status.checked==true) {//节点为选中状态
				if(status.half==true) {//半选
					nodeIdObj.halfList += node.id+",";
					var children = node.children;
					for(var i=0;i<children.length;i++) {
						travelNodes(children[i],nodeIdObj);
					}
				}else{//全选
					nodeIdObj.checkList += node.id+",";//将当前节点加入全选列表，停止遍历其子节点
				}
			}
		}
		
		//保存功能按钮授权
		function saveButtonMap() {
			var tree = $.fn.zTree.getZTreeObj('menuTree');
			var nodes = tree.getSelectedNodes();
			if(nodes.length==0) {
				msgShow('信息提示','请选择子系统菜单树的菜单节点','info');
			}else if(nodes.length>1) {
				msgShow('信息提示','只能选择一个菜单节点','info');
			}else{
				var node = nodes[0];
				if(node.level==0) {
					msgShow('信息提示','请选择菜单节点','info');
				}else if(node.checkedOld!=true) {
					msgShow('信息提示','该菜单未授权','info');
				}else{
					//执行保存
					var btnmap = getButtonMap();
					
					var param = "";
					param += "moduleid="+node.id;
					param += "&subroleid="+node.subroleid;
					param += "&buttonmap="+btnmap;
					$.getJSON('updateSubroleFunc.do',param,function(data) {
						//保存后处理
						if (null!=data && null!=data.status && data.status=="true") {
							msgShow('提示信息','保存成功','info');
							node.buttonMap = btnmap;
							tree.updateNode(node);
						}
					});
				}
			}
		}
		
		//批量保存功能按钮授权
		function saveButtonMapBatch() {
			var tree = $.fn.zTree.getZTreeObj('menuTree');
			var root = tree.getNodes()[0];
			var dNodes = root.children;
			var ids = "";
			for(var i=0;i<dNodes.length;i++) {
				if(dNodes[i].checkedOld==true) {
					ids += ","+dNodes[i].id;
				}
			}
			if(ids!="") ids = ids.substring(1,ids.length);
			if(ids=="") {
				msgShow('提示消息','当前子系统角色未有任何菜单权限，无法批量设置功能操作权限','info');
			}else{
				var btnmap = getButtonMap();
				var param = "";
				param += "ids="+ids;
				param += "&subroleid="+root.subroleid;
				param += "&buttonmap="+btnmap;
				param += "&sysid="+root.id;
				
				$.getJSON('updateSubroleFuncBatch.do',param,function(data) {
						//保存后处理
						if (null!=data && null!=data.status && data.status=="true") {
							msgShow('提示信息','保存成功','info');
							//node.buttonMap = btnmap;
							//tree.updateNode(node);
							refreshTree('menuTree');
						}
					});
			}
		}
		
		function getButtonMap() {
			var retmap="";
			var chk = $('[name=funButtonName]');//取得功能checkbox
			for(var i=0;i<chk.length;i++) {
				if(chk[i].checked) {
					retmap += chk[i].value;
				}else{
					retmap += "0";
				}
			}
			return retmap;
		}
	</script>
</head>

<body class="easyui-layout">
	<div region="west" split="true" style="width:300px;padding:2px;" title="所有角色">
		<ul id="roleTree" class="ztree"></ul>		
	</div>
	<div region="center" split="true" style="padding:2px;" title="系统菜单">
		<div style="height:85%;width:100%;overflow:auto;border:1px solid #D6E3F3;">
			<span id="tip">请从左边选择角色进行操作</span>
			<ul id="menuTree" class="ztree"></ul>
		</div>
		<a href="javascript:void(0)" id="btnMenu" onclick="saveMenuMap()" class="easyui-linkbutton" iconCls="icon-ok" style="margin-left:10px;margin-top:5px;margin-bottom:5px;;display:none;">保存菜单权限</a> 
		<div id="note" style="display:none;">
			点击菜单权限的树节点来修改每个模块的操作功能权限（增加，修改，删除）
		</div>
	</div>
	<div region="east" split="true" style="width:300px" title="功能按钮设置">
		<div id="buttonMapDiv" style="display:none;">
			<table width="250" border="0" cellpadding="0" cellspacing="0" style="margin-top:5px;" >
            	<tbody>
    				<tr><td><input style="margin-left:50px;" type="checkbox" name="funButtonName" value="1">增加</td></tr>
    				<tr><td><input style="margin-left:50px;" type="checkbox" name="funButtonName" value="1">修改</td></tr>
    				<tr><td><input style="margin-left:50px;" type="checkbox" name="funButtonName" value="1">删除</td></tr>
  					<tr><td><input style="margin-left:50px;" type="checkbox" name="funButtonName" value="1">导入</td></tr>
    				<tr><td><input style="margin-left:50px;" type="checkbox" name="funButtonName" value="1">导出到EXCEL</td></tr>
    				<tr><td><input style="margin-left:50px;" type="checkbox" name="funButtonName" value="1">未用</td></tr>
    				<tr><td><input style="margin-left:50px;" type="checkbox" name="funButtonName" value="1">未用</td></tr>
    				<tr><td><input style="margin-left:50px;" type="checkbox" name="funButtonName" value="1">未用</td></tr>
					<tr>
						<td>
							<div align="center" style="margin-top:5px;">
								<a href="javascript:void(0)" id="btnMap" onclick="saveButtonMap()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
      							<a href="javascript:void(0)" id="btnMapBatch" onclick="saveButtonMapBatch()" class="easyui-linkbutton" iconCls="icon-ok">批量保存</a>
    						</div>
    					</td>
    				</tr>
				<tbody>
			</table>
		</div>
	</div>
	<div region="south" style="height: 30px;position:relative;background:url('<%=basePath%>images/indexbg.png') repeat;">  
		<div id="toolbar"></div>
	</div>
</body>

</html>
