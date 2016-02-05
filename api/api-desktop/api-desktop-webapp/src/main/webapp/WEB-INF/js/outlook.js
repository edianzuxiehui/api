
//**********************************左侧菜单************************************
 var _menus="";
 var tabpanel;
$(function(){
	//InitLeftMenu();
	tabClose();
	tabCloseEven();
	InitFirstBindMenu();
	$("#nav").accordion({animate:false});
  			
})

//初始化左侧
function InitLeftMenu() {
	$("#nav").accordion({animate:false});
	
   	clearAccordMenu();
	
	$.getJSON('accordMenu.do?menuId='+$("#idHidaccordMenu").val(), function(json) {
        	_menus=json.msg;
	     $.each(_menus.menus, function(i, n) {
			var menulist ='';
			menulist +='<div style="padding:5px;text-align:center" >';
	        $.each(n.menus, function(j, o) {
	            var ourl=o.url;
	            var oicon=o.icon;
	            var otitle=o.menuname;
	            var obmap=o.buttonmap;
	            var moduleImg=o.img;
	            var hidImg=moduleImg.substr(0,moduleImg.indexOf("."))+"-over"+moduleImg.substr(moduleImg.lastIndexOf("."));
	            //if(otitle=='密码修改'){
				//	menulist += '<li><div><a ref="'+o.menuid+'" href="javascript:addTab(\''+otitle+'\',\''+ourl+'\',\''+oicon+'\',\''+obmap+'\')" bmap="'+o.buttonmap+'" rel="' + o.url + '" target="_blank"><span class="icon '+o.icon+'" >&nbsp;</span><span class="nav2">' + o.menuname + '</span></a></div></li> ';
				//}else{
					menulist += '<a style="text-decoration:none;" ref="'+o.menuid+'" href="javascript:addTab(\''+o.menuid+'\',\''+otitle+'\',\''+ourl+'\',\''+oicon+'\',\''+obmap+'\')" bmap="'+o.buttonmap+'" rel="' + o.url + '" ><div style="width:150px;border:0px dashed FFFFFF; background:FFFFFF;cursor:pointer; text-align:center" onmouseover="changeColor(this)"  onmouseout="changeColor2(this)"><a style="text-decoration:none;" ref="'+o.menuid+'" href="javascript:addTab(\''+o.menuid+'\',\''+otitle+'\',\''+ourl+'\',\''+oicon+'\',\''+obmap+'\')" bmap="'+o.buttonmap+'" rel="' + o.url + '" ><img style="width:60px;border:0px" id="imgid'+o.menuid+'" showSrc="'+o.img+'" hideSrc="'+hidImg+'" src="'+o.img+'"><br>'+o.menuname+'</a></div></a> <br>';
				//}
	        })
			menulist += '</div>';
			
			//alert(n.menuname);
			//alert(menulist);
			$('#nav').accordion('add', {
	            title: $.trim(n.menuname),
	            content: menulist,
	            iconCls: n.icon
	        });
	
	    });
	    
	    
	    $('.easyui-accordion li a').click(function(){
		var tabTitle = $(this).children('.nav').text();

		var url = $(this).attr("rel");
		var menuid = $(this).attr("ref");
		var bMap = $(this).attr("bmap");
		var icon = getIcon(menuid,icon);

		//addTab(menuid,tabTitle,url,icon,bMap);
		//addTab(tabTitle,url,icon);
		$('.easyui-accordion li div').removeClass("selected");
		$(this).parent().addClass("selected");
	}).hover(function(){
		$(this).parent().addClass("hover");
	},function(){
		$(this).parent().removeClass("hover");
	});

	//选中第一个
	var panels = $('#nav').accordion('panels');
	if(panels[0]){
		var t = panels[0].panel('options').title;
    	$('#nav').accordion('select', t);
	}
        	    
   	}); 
   	
}
	function changeColor(obj,mId){
		obj.style.backgroundColor='#cfe3fd';
		var imgId="imgid"+mId;
		$("#"+imgId).attr("src",document.getElementById(imgId).hideSrc);
	}

	function changeColor2(obj,mId){
		obj.style.backgroundColor='FFFFFF';
		var imgId="imgid"+mId;
		$("#"+imgId).attr("src",document.getElementById(imgId).showSrc);
	}






//初始化左侧
function InitLeftMenuById(menuId) {
				
	$("#nav").accordion({animate:false});
	
	clearAccordMenu();

	$.getJSON('accordMenu.do?menuId='+menuId, function(json) {
			if(json.status){
				alert(json.message);
				window.location.href="login.jsp";
				return;
			}
	
        	_menus=json.msg;
	     $.each(_menus.menus, function(i, n) {
			var menulist ='';
			menulist +='<div style="padding:5px;text-align:center" >';
	        $.each(n.menus, function(j, o) {
	            var ourl=o.url;
	            var oicon=o.icon;
	            var otitle=o.menuname;
	            var obmap=o.buttonmap;
	            var moduleImg=o.img;
	            var hidImg=moduleImg.substr(0,moduleImg.indexOf("."))+"-over"+moduleImg.substr(moduleImg.lastIndexOf("."));
	            //if(otitle=='密码修改'){
				//	menulist += '<li><div><a ref="'+o.menuid+'" href="javascript:addTab(\''+otitle+'\',\''+ourl+'\',\''+oicon+'\',\''+obmap+'\')" bmap="'+o.buttonmap+'" rel="' + o.url + '" target="_blank"><span class="icon '+o.icon+'" >&nbsp;</span><span class="nav2">' + o.menuname + '</span></a></div></li> ';
				//}else{
				//menulist += '<a style="text-decoration:none;" ref="'+o.menuid+'" href="javascript:addTab(\''+o.menuid+'\',\''+otitle+'\',\''+ourl+'\',\''+oicon+'\',\''+obmap+'\')" bmap="'+o.buttonmap+'" rel="' + o.url + '" ><div style="width:120px;border:0px dashed FFFFFF; background:FFFFFF;cursor:pointer; text-align:center" onmouseover="changeColor(this,\''+o.menuid+'\')"  onmouseout="changeColor2(this,\''+o.menuid+'\')"><a style="text-decoration:none;" ref="'+o.menuid+'" href="javascript:addTab(\''+o.menuid+'\',\''+otitle+'\',\''+ourl+'\',\''+oicon+'\',\''+obmap+'\')" bmap="'+o.buttonmap+'" rel="' + o.url + '" ><img style="width:60px;border:0px" id="imgid'+o.menuid+'" showSrc="'+o.img+'" hideSrc="'+hidImg+'" src="'+o.img+'"><br>'+o.menuname+'</a></div></a> <br>';
					
					menulist += '<a style="text-decoration:none;" ref="'+o.menuid+'"onclick="addTab(\''+o.menuid+'\',\''+otitle+'\',\''+ourl+'\',\''+oicon+'\',\''+obmap+'\')"  bmap="'+o.buttonmap+'" rel="' + o.url + '" ><div style="width:120px;border:0px dashed FFFFFF; background:FFFFFF;cursor:pointer; text-align:center" onmouseover="changeColor(this,\''+o.menuid+'\')"  onmouseout="changeColor2(this,\''+o.menuid+'\')" onclick="addTab(\''+o.menuid+'\',\''+otitle+'\',\''+ourl+'\',\''+oicon+'\',\''+obmap+'\')"><a style="text-decoration:none;" ref="'+o.menuid+'" onclick="addTab(\''+o.menuid+'\',\''+otitle+'\',\''+ourl+'\',\''+oicon+'\',\''+obmap+'\')"  bmap="'+o.buttonmap+'" rel="' + o.url + '" ><img style="width:60px;border:0px" id="imgid'+o.menuid+'" showSrc="'+o.img+'" hideSrc="'+hidImg+'" src="'+o.img+'"><br>'+o.menuname+'</a></div></a> <br>';
					//menulist += '<a style="text-decoration:none;" ref="'+o.menuid+'" onclick="addTab(\''+o.menuid+'\',\''+otitle+'\',\''+ourl+'\',\''+oicon+'\',\''+obmap+'\')" bmap="'+o.buttonmap+'" rel="' + o.url + '" ><div style="width:120px;border:0px dashed FFFFFF; background:FFFFFF;cursor:pointer; text-align:center" onmouseover="changeColor(this,\''+o.menuid+'\')"  onmouseout="changeColor2(this,\''+o.menuid+'\')"><a style="text-decoration:none;" ref="'+o.menuid+'" onclick="addTab(\''+o.menuid+'\',\''+otitle+'\',\''+ourl+'\',\''+oicon+'\',\''+obmap+'\')" bmap="'+o.buttonmap+'" rel="' + o.url + '" ><img style="width:60px;border:0px" id="imgid'+o.menuid+'" showSrc="'+o.img+'" hideSrc="'+hidImg+'" src="'+o.img+'"><br>'+o.menuname+'</a></div></a> <br>';
				//}
	        })
			menulist += '</div>';
				//alert(menulist);
			$('#nav').accordion('add', {
	            title: $.trim(n.menuname),
	            content: menulist,
	            iconCls: n.icon
	        });
	
	    });
	    
	    
	    $('.easyui-accordion li a').click(function(){
		var tabTitle = $(this).children('.nav').text();

		var url = $(this).attr("rel");
		var menuid = $(this).attr("ref");
		var bMap = $(this).attr("bmap");
		var icon = getIcon(menuid,icon);

		//addTab(menuid,tabTitle,url,icon,bMap);
		//addTab(tabTitle,url,icon);
		$('.easyui-accordion li div').removeClass("selected");
		$(this).parent().addClass("selected");
	}).hover(function(){
		$(this).parent().addClass("hover");
	},function(){
		$(this).parent().removeClass("hover");
	});

	//选中第一个
	var panels = $('#nav').accordion('panels');
	if(panels[0]){
		var t = panels[0].panel('options').title;
    	$('#nav').accordion('select', t);
	}
	
	
	
	//------设置菜单是否可以用

		var distagMenu=$("a[id^=menu_]").get();
		$.each(distagMenu,function (i,d){
		if(d.id=="menu_"+menuId){
			$('#'+d.id).addClass("curSelMenu");
			$('#'+d.id).attr("disabled","dsiabled");
			$('#'+d.id).attr('onclick','');
			$('#'+d.id).unbind("click");
		}else{
			$('#'+d.id).removeClass("curSelMenu");
			$('#'+d.id).removeAttr("disabled");
			$('#'+d.id).addClass("");
			$('#'+d.id).unbind("click");
			$('#'+d.id).attr('onclick','');
			$('#'+d.id).bind("click",{menuId:$("#"+d.id).attr("refId")},bindMenuClick);
		}
	});
	
        	    
   	}); 
   	
}

function InitFirstBindMenu(){
		var menuId=$("#idHidaccordMenu").val();
		var distagMenu=$("a[id^=menu_]").get();
		$.each(distagMenu,function (i,d){
		if(d.id=="menu_"+menuId){
			$('#'+d.id).addClass("curSelMenu");
			$('#'+d.id).attr("disabled","dsiabled");
			$('#'+d.id).attr('onclick','');
			$('#'+d.id).unbind("click");
		}else{
			$('#'+d.id).removeClass("curSelMenu");
			$('#'+d.id).removeAttr("disabled");
			$('#'+d.id).addClass("");
			$('#'+d.id).unbind("click");
			$('#'+d.id).attr('onclick','');
			$('#'+d.id).bind("click",{menuId:$("#"+d.id).attr("refId")},bindMenuClick);
		}
	});

}


function bindMenuClick(event){
	$("#nav").accordion({animate:false});
	clearAccordMenu();
	var menuId=event.data.menuId;
	$.ajax({url:"accordMenu.do",data:"menuId="+menuId,type:"POST",ansync:false,dataType:"json", success:function(json) {
			if(json.status){
				alert(json.message);
				window.location.href="login.jsp";
				return;
			}
	
        	_menus=json.msg;
	     $.each(_menus.menus, function(i, n) {
			var menulist ='';
			menulist +='<div style="padding:5px;text-align:center" >';
	        $.each(n.menus, function(j, o) {
	            var ourl=o.url;
	            var oicon=o.icon;
	            var otitle=o.menuname;
	            var obmap=o.buttonmap;
	            var moduleImg=o.img;
	            var hidImg=moduleImg.substr(0,moduleImg.indexOf("."))+"-over"+moduleImg.substr(moduleImg.lastIndexOf("."));
	            //if(otitle=='密码修改'){
				//	menulist += '<li><div><a ref="'+o.menuid+'" href="javascript:addTab(\''+otitle+'\',\''+ourl+'\',\''+oicon+'\',\''+obmap+'\')" bmap="'+o.buttonmap+'" rel="' + o.url + '" target="_blank"><span class="icon '+o.icon+'" >&nbsp;</span><span class="nav2">' + o.menuname + '</span></a></div></li> ';
				//}else{
				//menulist += '<a style="text-decoration:none;" ref="'+o.menuid+'" href="javascript:addTab(\''+o.menuid+'\',\''+otitle+'\',\''+ourl+'\',\''+oicon+'\',\''+obmap+'\')" bmap="'+o.buttonmap+'" rel="' + o.url + '" ><div style="width:120px;border:0px dashed FFFFFF; background:FFFFFF;cursor:pointer; text-align:center" onmouseover="changeColor(this,\''+o.menuid+'\')"  onmouseout="changeColor2(this,\''+o.menuid+'\')"><a style="text-decoration:none;" ref="'+o.menuid+'" href="javascript:addTab(\''+o.menuid+'\',\''+otitle+'\',\''+ourl+'\',\''+oicon+'\',\''+obmap+'\')" bmap="'+o.buttonmap+'" rel="' + o.url + '" ><img style="width:60px;border:0px" id="imgid'+o.menuid+'" showSrc="'+o.img+'" hideSrc="'+hidImg+'" src="'+o.img+'"><br>'+o.menuname+'</a></div></a> <br>';
					
					menulist += '<a style="text-decoration:none;" ref="'+o.menuid+'"onclick="addTab(\''+o.menuid+'\',\''+otitle+'\',\''+ourl+'\',\''+oicon+'\',\''+obmap+'\')"  bmap="'+o.buttonmap+'" rel="' + o.url + '" ><div style="width:120px;border:0px dashed FFFFFF; background:FFFFFF;cursor:pointer; text-align:center" onmouseover="changeColor(this,\''+o.menuid+'\')"  onmouseout="changeColor2(this,\''+o.menuid+'\')" onclick="addTab(\''+o.menuid+'\',\''+otitle+'\',\''+ourl+'\',\''+oicon+'\',\''+obmap+'\')"><a style="text-decoration:none;" ref="'+o.menuid+'" onclick="addTab(\''+o.menuid+'\',\''+otitle+'\',\''+ourl+'\',\''+oicon+'\',\''+obmap+'\')"  bmap="'+o.buttonmap+'" rel="' + o.url + '" ><img style="width:60px;border:0px" id="imgid'+o.menuid+'" showSrc="'+o.img+'" hideSrc="'+hidImg+'" src="'+o.img+'"><br>'+o.menuname+'</a></div></a> <br>';
					//menulist += '<a style="text-decoration:none;" ref="'+o.menuid+'" onclick="addTab(\''+o.menuid+'\',\''+otitle+'\',\''+ourl+'\',\''+oicon+'\',\''+obmap+'\')" bmap="'+o.buttonmap+'" rel="' + o.url + '" ><div style="width:120px;border:0px dashed FFFFFF; background:FFFFFF;cursor:pointer; text-align:center" onmouseover="changeColor(this,\''+o.menuid+'\')"  onmouseout="changeColor2(this,\''+o.menuid+'\')"><a style="text-decoration:none;" ref="'+o.menuid+'" onclick="addTab(\''+o.menuid+'\',\''+otitle+'\',\''+ourl+'\',\''+oicon+'\',\''+obmap+'\')" bmap="'+o.buttonmap+'" rel="' + o.url + '" ><img style="width:60px;border:0px" id="imgid'+o.menuid+'" showSrc="'+o.img+'" hideSrc="'+hidImg+'" src="'+o.img+'"><br>'+o.menuname+'</a></div></a> <br>';
				//}
	        })
			menulist += '</div>';
				//alert(menulist);
			$('#nav').accordion('remove',$.trim(n.menuname));
			$('#nav').accordion('add', {
	            title: $.trim(n.menuname),
	            content: menulist,
	            iconCls: n.icon
	        });
	
	    });
	    
	    
	    $('.easyui-accordion li a').click(function(){
		var tabTitle = $(this).children('.nav').text();

		var url = $(this).attr("rel");
		var menuid = $(this).attr("ref");
		var bMap = $(this).attr("bmap");
		var icon = getIcon(menuid,icon);

		//addTab(menuid,tabTitle,url,icon,bMap);
		//addTab(tabTitle,url,icon);
		$('.easyui-accordion li div').removeClass("selected");
		$(this).parent().addClass("selected");
	}).hover(function(){
		$(this).parent().addClass("hover");
	},function(){
		$(this).parent().removeClass("hover");
	});

	//选中第一个
	var panels = $('#nav').accordion('panels');
	if(panels[0]){
		var t = panels[0].panel('options').title;
    	$('#nav').accordion('select', t);
	}
	
	
	
	//------设置菜单是否可以用

		var distagMenu=$("a[id^=menu_]").get();
		$.each(distagMenu,function (i,d){
		if(d.id=="menu_"+menuId){
			$('#'+d.id).addClass("curSelMenu");
			$('#'+d.id).attr("disabled","dsiabled");
			$('#'+d.id).attr('onclick','');
			$('#'+d.id).unbind("click");
		}else{
			$('#'+d.id).removeClass("curSelMenu");
			$('#'+d.id).removeAttr("disabled");
			$('#'+d.id).addClass("");
			$('#'+d.id).unbind("click");
			$('#'+d.id).attr('onclick','');
			$('#'+d.id).bind("click",{menuId:$("#"+d.id).attr("refId")},bindMenuClick);
		}
	});
	
   }     	    
   	}); 

}

function clearAccordMenu(){
   var pp = $('#nav').accordion('panels');
   var vt="";
    $.each(pp, function(i, n) {
        if (n) {
            var t = n.panel('options').title;
            vt+=$.trim(t)+",";
           //$('#nav').accordion('remove', $.trim(t));
        }
    });
    vt=vt.substring(0,vt.lastIndexOf(","));
    var aryvt=vt.split(",");
     $.each(aryvt, function(i, ary) {
        if (ary) {
           $('#nav').accordion('remove', $.trim(ary));
        }
    });
}





//获取左侧导航的图标
function getIcon(menuid){
	var icon = 'icon ';
	$.each(_menus.menus, function(i, n) {
		 $.each(n.menus, function(j, o) {
		 	if(o.menuid==menuid){
				icon += o.icon;
			}
		 })
	})

	return icon;
}




//addTab(menuid,tabTitle,url,icon,bMap);
//@item : 标签页对象(id,title,html,closable,disabled,icon)
//function addTab(id,tabTitle,url,icon,bMap){
	//top.tabpanel.addTab({title:tabTitle,id:id, html:createFrame(url),btnMap:bMap,icon:icon});
//}





function addTab(mid,subtitle,url,icon,bmap){
	     if(!$('#tabs').tabs('exists',subtitle)){
			$('#tabs').tabs('add',{
				title:subtitle,
				//href:url,
				content:createFrame(url),
				closable:true,
				//icon:icon,
				bMap:bmap,
				tabId:mid
			});
		}else{
			$('#tabs').tabs('select',subtitle);
			$('#mm-tabupdate').click();
		}
	    tabpanel=$('#tabs');
		tabClose();
		//selectTabRef();

}






function createFrame(url)
{
	var s = '<iframe scrolling="auto" frameborder="0"  src="'+url+'" style="width:100%;height:100%;" name="tabFrame" id="idTabFrame"></iframe>';
	return s;
}


//弹出信息窗口 title:标题 msgString:提示信息 msgType:信息类型 [error,info,question,warning]
function msgShow(title, msgString, msgType) {
	$.messager.alert(title, msgString, msgType);
}


//点击一个tab的时候就刷新一次
function selectTabRef(){

$('.tabs-inner').live('click',function(){  
 var subtitle = $(this).children("span").text();   
 if($(this).next().is('.tabs-close')){     
           var currTab = $('#tabs').tabs('getTab', subtitle);   
           var iframe = $(currTab.panel('options').content);   
           var src = iframe.attr('src');     
           refreshTab({tabTitle:subtitle,url:src} );       
    }else{ 
             $('#tabs').tabs('select',title);} 
     });

}


 function refreshTab(cfg){         
     var refresh_tab = cfg.tabTitle?$('#tabs').tabs('getTab',cfg.tabTitle):$('#tabs').tabs('getSelected');       
          if(refresh_tab && refresh_tab.find('iframe').length > 0){        
              var _refresh_ifram = refresh_tab.find('iframe')[0];        
               var refresh_url = cfg.url?cfg.url:_refresh_ifram.src;         
                 _refresh_ifram.contentWindow.location.href=refresh_url;  
           }      
  } 






function tabClose()
{


	/*双击关闭TAB选项卡*/
	$(".tabs-inner").dblclick(function(){
		var subtitle = $(this).children(".tabs-closable").text();
		$('#tabs').tabs('close',subtitle);
		
		//---双击关闭TAB选项卡 获取到bmap对象，进行对按钮设置
		var pp = $('#tabs').tabs('getSelected');   
		//var bMap=pp.panel('options').bMap;
		//setToolbarButton(bMap);
		
	})
	
	/*单击关闭TAB选项卡，重载他的方法*/
	$(".tabs-close").click(function(){
		var subtitle = $(this).children(".tabs-closable").text();
		$('#tabs').tabs('close',subtitle);
		
		//---双击关闭TAB选项卡 获取到bmap对象，进行对按钮设置
		var pp = $('#tabs').tabs('getSelected');   
		//var bMap=pp.panel('options').bMap;
		//setToolbarButton(bMap);
		
	})
	
	/*
	$('.tabs-selected').dblclick(function(){
				var subtitle = $(this).children(".tabs-closable").text();
			$('#tabs').tabs('close',subtitle);
			
			//---双击关闭TAB选项卡 获取到bmap对象，进行对按钮设置
			var pp = $('#tabs').tabs('getSelected');   
					
		})	
		
		$('.tabs-selected').click(function(){
		var subtitle =$(this).children(".tabs-closable").text();
		//alert(subtitle);
				//var pp = $('#tabs').tabs('getSelected');   
				//var bMap=pp.panel('options').bMap;
				//alert(bMap);
				//setToolbarButton(bMap);
				
		})
		
*/

	
	
	

	/*为选项卡绑定右键*/
	$(".tabs-inner").bind('contextmenu',function(e){
		$('#mm').menu('show', {
			left: e.pageX,
			top: e.pageY
		});

		var subtitle =$(this).children(".tabs-closable").text();

		$('#mm').data("currtab",subtitle);
		$('#tabs').tabs('select',subtitle);
		return false;
	});
}
//绑定右键菜单事件
function tabCloseEven()
{
	//刷新
	$('#mm-tabupdate').click(function(){
		var currTab = $('#tabs').tabs('getSelected');
		var url = $(currTab.panel('options').content).attr('src');
		if(url){
			$('#tabs').tabs('update',{
				tab:currTab,
				options:{
					content:createFrame(url)
				}
			})
		}

	})
	//关闭当前
	$('#mm-tabclose').click(function(){
		var currtab_title = $('#mm').data("currtab");
		if(currtab_title){
			$('#tabs').tabs('close',currtab_title);
		}
	})
	//全部关闭
	$('#mm-tabcloseall').click(function(){
		$('.tabs-inner span').each(function(i,n){
			var t = $(n).text();
			if(t!="欢迎使用"&&t){
				$('#tabs').tabs('close',t);
			}
		});
	});
	//关闭除当前之外的TAB
	$('#mm-tabcloseother').click(function(){
		$('#mm-tabcloseright').click();
		$('#mm-tabcloseleft').click();
	});
	//关闭当前右侧的TAB
	$('#mm-tabcloseright').click(function(){
		var nextall = $('.tabs-selected').nextAll();
		if(nextall.length==0){
			//msgShow('系统提示','后边没有啦~~','error');
			//alert('后边没有啦~~');
			return false;
		}
		nextall.each(function(i,n){
			var t=$('a:eq(0) span',$(n)).text();
			if(t!="欢迎使用"&&t){
				$('#tabs').tabs('close',t);
			}
		});
		return false;
	});
	//关闭当前左侧的TAB
	$('#mm-tabcloseleft').click(function(){
		var prevall = $('.tabs-selected').prevAll();
		if(prevall.length==0){
			//alert('到头了，前边没有啦~~');
			return false;
		}
		prevall.each(function(i,n){
			var t=$('a:eq(0) span',$(n)).text();
			if(t!="欢迎使用"&&t){
				$('#tabs').tabs('close',t);
			}
		});
		return false;
	});

	//退出
	$("#mm-exit").click(function(){
		$('#mm').menu('hide');
	})
}


