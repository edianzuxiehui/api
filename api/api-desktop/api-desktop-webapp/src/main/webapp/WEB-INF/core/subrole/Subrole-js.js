		//创建子角色树 begin
		function showSubrole() {
			var setting = {
				view: {
					showLine: false
				},
				callback: {
					onClick: function(event,treeId,treeNode,clickFlag) {
						if(treeNode.level==1) {
							var subroleid = treeNode.id;
							var sysid = treeNode.getParentNode().id;
							var sysname = treeNode.getParentNode().name;
							var deptId = treeNode.deptId;
							$('#tip').hide();
							showMenu(sysid,subroleid,sysname,deptId);//显示菜单树
							$('#btnSaveMenuMap').attr('disabled',false);
							$('#buttonMapDiv').css('display','');//显示功能按钮设置
							initButtonMap();
						}else{
							resetMenuAndBtn();
						}
					}
				}
			};
			$.getJSON("getsubrole.do","",function(data) {
				if(data!=null) {
					var zNodes = data;
					buildTree('roleTree',setting,zNodes);
				}else{
					msgShow('提示消息','载入权限数据失败！','warning');
				}
			});
		}
		
		function resetMenuAndBtn() {
			//重置菜单树与功能按钮设置区域
			//$('#tip').show();
			showMenu('0','0','','0');
			$('#btnSaveMenuMap').attr('disabled',true);
			$('#buttonMapDiv').css('display','none');
			initButtonMap();
		}
		
		//页面加载完毕显示子系统角色树
		$(document).ready(function(){
			showSubrole();
			$(".edit_toolbar").attr('disabled', true); //修改不可用
			$(".import_toolbar").attr('disabled', true);
			$(".export_toolbar").attr('disabled', true);
		});
		//创建子角色树 end		
		
		//显示子系统菜单
		function showMenu(sysid,subroleid,sysname,deptId) {
			//$('#tip').hide();
			var setting = {
				check: {
					enable: true
		    	},
				callback: {
					onClick: function(event,treeId,treeNode,clickFlag) {
						var moduleid = treeNode.id;//模块ID
						var subroleid = treeNode.subroleid;//子角色ID
						var deptId = treeNode.deptId;//部门ID
						var buttonMap = treeNode.buttonMap;//功能操作位图
						//var opMap = treeNode.opMap;
						//setupButtonMap(moduleid,subroleid,buttonMap,deptId,opMap);
						setupButtonMap(moduleid,subroleid,buttonMap,deptId);
					}
				}
			};
			$.getJSON('getmenutree.do',{sysid:sysid, subroleid:subroleid, deptId:deptId},function(data) {
				if(data!=null) {
					var zNodes = data;
					buildTree('menuTree',setting,zNodes);
				}else{
					msgShow('提示消息','载入菜单节点数据失败！','warning');
				}
			});
			
		}
		
		function collapseAll() {
			var zTree = getTree("menuTree")
			if(zTree)
				zTree.expandAll(false);
		}
		function expandAll() {
			var zTree = getTree("menuTree")
			if(zTree)
				zTree.expandAll(true);
		}
		function checkAll() {
			var zTree = getTree('menuTree');
			if(zTree)
				zTree.checkAllNodes(true);
		}
		function uncheck() {//取消选中
			var zTree = getTree('menuTree');
			if(zTree)
				zTree.checkAllNodes(false);
		}
		
		//显示操作功能权限设置窗口
		function setupButtonMap(moduleid,subroleid,buttonMap,deptId) {
			//查询数据库获取opMap
			$.getJSON('queryButtonMap.do',{MODULEID:moduleid},function(data) {
				if(data!=null) {
					if(data.status!=null && data.status == 'true') {
						var opMap = $.trim(data.buttonmap);
						buttonMap = $.trim(buttonMap);
						var chk = $('[name=funButtonName]');//取得功能checkbox
						for(var i=0;i<chk.length;i++) {//以checkbox的个数为循环长度
							if(opMap.substring(i,i+1)=="0") {
								chk[i].disabled = true;
								chk[i].checked = false;
							}else{
								chk[i].disabled = false;
								if(chk[i].value==buttonMap.substring(i,i+1)) {
									chk[i].checked = true;
								}else{
									chk[i].checked = false;
								}
							}
						}
					}else{
						msgShow('提示消息',data.message,'error');
					}
				}
			});

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
			var tree = getTree('menuTree'); 
			if(!tree) return false;
			
			var node = tree.getNodes()[0];//取得根节点
			var sysid = node.sysid; //子系统ID
			var subroleid = node.subroleid;
			var deptId = node.deptId;
			
			var list = "";
			var nodes = tree.getCheckedNodes(true);
			for(var i=0; i<nodes.length; i++) {
				list += nodes[i].id+",";
			}
			if(list!="") list = list.substring(0,list.length-1);
			var param = {subroleid:subroleid, deptId:deptId, sysid:sysid, check:list, tmsModuleId:tmsJ5ModuleId, tmsModuleTitle:escape(tmsJ5ModuleTitle)};
			
			showProcess(true,"稍等", "正在保存中……");
			
			$.getJSON("saveMenuAuthor.do",param,function(data){
					showProcess(false);
					
					if (null!=data && null!=data.status && data.status=="true") {
						msgShow('提示消息',"模块权限保存成功",'info');
						tree.refresh();
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
			var tree = getTree('menuTree');
			var nodes = tree.getSelectedNodes();
			if(nodes.length==0) {
				msgShow('信息提示','请选择系统菜单树的菜单节点','info');
			}else if(nodes.length>1) {
				msgShow('信息提示','只能选择一个菜单节点','info');
			}else{
				var node = nodes[0];
				if(node.checkedOld!=true) {
					msgShow('信息提示','该菜单未授权','info');
				}else{
					//执行保存
					var btnmap = getButtonMap();
					
					$.getJSON('updateSubroleFunc.do',{moduleid:node.id, subroleid:node.subroleid, buttonmap: btnmap, tmsModuleId:tmsJ5ModuleId, tmsModuleTitle:escape(tmsJ5ModuleTitle)},
						function(data) {
							//保存后处理
							if (null!=data && null!=data.status && data.status=="true") {
								msgShow('提示信息','保存成功','info');
								node.buttonMap = btnmap;
								tree.updateNode(node);
							}
						}
					);
				}
			}
		}
		
		//批量保存功能按钮授权
		function saveButtonMapBatch() {
			var tree = getTree('menuTree');
			
			var dNodes = tree.getNodesByParam('checkedOld',true,null);//获取已经授权的模块节点
			var ids = "";
			for(var i=0;i<dNodes.length;i++) {
				ids += ","+dNodes[i].id;
			}
			if(ids!="") ids = ids.substring(1,ids.length);
			if(ids=="") {
				msgShow('提示消息','当前权限未有任何模块授权，无法批量设置功能操作权限','info');
			}else{
				var btnmap = getButtonMap();
				var param = {ids:ids, subroleid: dNodes[0].subroleid, buttonmap:btnmap, sysid: dNodes[0].sysid, tmsModuleId:tmsJ5ModuleId, tmsModuleTitle:escape(tmsJ5ModuleTitle)};
				
				$.getJSON('updateSubroleFuncBatch.do',param,function(data) {
						//保存后处理
						if (null!=data && null!=data.status && data.status=="true") {
							msgShow('提示信息','保存成功','info');
							for(var i=0;i<dNodes.length;i++) {
								dNodes[i].buttonMap = btnmap;
								tree.updateNode(dNodes[i]);
							}
						}
					});
			}
		}
		
		//取得当前设置的buttonmap值
		function getButtonMap() {
			var retmap="";
			var chk = $('[name=funButtonName]');//取得功能checkbox
			for(var i=0;i<chk.length;i++) {
				if(chk[i].checked && chk[i].disabled==false) {
					retmap += chk[i].value;
				}else{
					retmap += "0";
				}
			}
			//确保buttonmap值为8位0、1串
			for(var i=chk.length; i<8; i++) {
				retmap += "0";
			}
			return retmap;
		}
		
		//buttonmap全选
		function btnmap_checkAll() {
			$('[name=funButtonName]').each(function() {
				if(!this.disabled)
					this.checked = true;
			});
			
		}
		
		//buttonmap重置
		function btnmap_reset() {
			$('[name=funButtonName]').each(function() {
				if(!this.disabled)
					this.checked = false;
			});
		}