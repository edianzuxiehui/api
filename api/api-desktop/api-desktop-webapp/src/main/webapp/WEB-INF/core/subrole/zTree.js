//建立zTree
//----------------------
//treeId 为页面中放置zTree的目标ul的id
//option 为zTree的选项配置，保留默认配置时{}
//zNodes 为zTree的初始化节点数据，为一JSONARRAY：对于同步加载（一次性加载），zNodes包含所有节点数据；对于异步加载，zNodes可能为null，或者为根节点数据	
//----------------------
function buildTree(treeId, option, zNodes) {
	alert(1);
	//默认option配置
	var setting = {
		data: {//采用简单JSON数据
			simpleData: {
				enable: true
			}
		},
		check: {
			enable: false,//默认不生成复选框
			chkStyle: "checkbox",
			chkboxType: { "Y" : "ps", "N" : "ps" }
		}
	};
	setting = $.extend(setting, option);
	$.fn.zTree.init($("#"+treeId), setting, zNodes);//初始化生成
	
}