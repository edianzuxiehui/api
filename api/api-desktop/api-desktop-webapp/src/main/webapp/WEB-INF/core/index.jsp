<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.landi.tms.base.IDto"%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib uri="oscache" prefix="cache"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%
	IDto person = (IDto) request.getSession().getAttribute("person");
	String name = person.getAsString("NAME");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<meta http-equiv="X-UA-Compatible" content="IE=8">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>">
<base target="_self">
<title>终端管理系统</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">



<link rel="stylesheet" type="text/css" href="themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="css/default.css">
<link rel="stylesheet" type="text/css" href="themes/icon.css">
<link rel="stylesheet" type="text/css" href="css/index.css">
<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="js/jquery.bgiframe.js"></script>
<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="js/common.js"></script>
<script type="text/javascript" src="js/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="js/outlook.js"></script>
<script type="text/javascript">

		function getRootPath(){
		    var strFullPath=window.document.location.href;
		    var strPath=window.document.location.pathname;
		    var pos=strFullPath.indexOf(strPath);
		    var prePath=strFullPath.substring(0,pos);
		    var postPath=strPath.substring(0,strPath.substr(1).indexOf('/')+1);
		    return(prePath+postPath);
		}		
		
		function openPc(){
			//window.open ('pcTool.html','pc套件','height=100%,width=100%,top=0,left=0,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no') 
              window.open (getRootPath()+'/loadPcTool.do','pc套件','height=100%,width=100%,top=0,left=0,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no')
		// var retr=openDialogOnlyClose('loadPcTool.do','pc套件',
			setTimeout(closeLink,10);
		}
		function openPc1(){
		}
		function closeLink(){
			$('#pclink').attr('onclick','');
			$('#pclink').unbind('click',openPc);
		}
		function openLink(){
			$('#pclink').bind('click',openPc);
		}
		
		function updatePWD(){
	$('#ff').form('clear');
	//window.open(getRootPath()+"/core/operinfo/ChangePWDInIndex.jsp");
	$('#oldpwd').validatebox('remove'); 
	$('#newpwd').validatebox('remove'); 
	$('#confimpwd').validatebox('remove'); 
	$('#test').window('open');
	$('#oldpwd').validatebox('reduce'); 
	$('#newpwd').validatebox('reduce'); 
	$('#confimpwd').validatebox('reduce'); 
}

function closeWin(){
	$('#test').window('close');
}

function addOperInfo(){
		$("#idTmsModuleTitle").attr("value","密码修改");
		$("#idTmsModuleId").attr("value",0);
    if($('#newpwd').attr('value') != $('#confimpwd').attr('value')){
    	msgShow("提示","两次输入新密码不一致!","info");
    	return;
    }
    var param="tmsModuleTitle="+escape(escape($('#idTmsModuleTitle').val()))+"&tmsModuleId="+escape(escape($('#idTmsModuleId').val()));	
	$('#ff').form('submit',{
        url:'updateOperPWD.do?'+param,
	    onSubmit:function(){
	        return $(this).form('validate');
	    },
	    success:function(data){
	      var myObject = eval('(' + data + ')');
	      if(myObject.status=="true"){
	    	  	 closeWin();
	    	  	 //alert("密码修改成功!");
	    	  	 msgShow("修改密码","修改密码成功,请记住新密码!","info");
	    	  	//window.location.reload(); 
				 //$('#ff').form('clear');
	      }else if(myObject.status=="false"){
	        	msgShow("修改密码",myObject.message,"error");
	      }
	    }
	});
	//window.location.reload(); 
	
}
function cleardata(){
	$('#ff').form('clear');
}
	function relogin(){
	 //alert(2);
	 var appRoot=getRootPath()+"/";
	 
	 window.location=appRoot+'logout.jsp';
	 
	}
    </script>

</head>

<body class="easyui-layout" fit="true" id="bdLayout">
	<input type="hidden" id="idTmsModuleTitle" name="tmsModuleTitle">
	<input type="hidden" id="idTmsModuleId" name="tmsModuleId">
	<div region="north" style="height: 80px; border: 0px">
		<div class="easyui-layout" fit="true">
			<div region="center" border="false" style="background: url('<%=basePath%>images/logo_bg5_1.png')">
				<div style="height:100%;width:100%;BACKGROUND: url('<%=basePath%>images/logo_bg5.gif') no-repeat"></div>
			</div>

			<div region="south" border="false" style="height: 30px;">
				<div class="easyui-layout" fit="true">
					<div region="center" border="false">

						<!--nav,start-->
						<div class="menu_navcc">
							<div class="clearfix" style="height:100%;width:100%;background:url('<%=basePath%>images/index/nav_bg.gif') repeat-x">
								<table>
									<tr style="color: white">
										<c:forEach items="${requestScope.rootMenuList}" var="rootMenu" varStatus="status">
											<td><c:if test="${status.index==0}">
													<a id="menu_${rootMenu.MODULEID}" refId="${rootMenu.MODULEID}" class="button" disabled="disabled"> ${rootMenu.NAME} </a>
													<input type="hidden" id="idHidaccordMenu" value="${rootMenu.MODULEID}">
												</c:if> <c:if test="${status.index!=0}">
													<a id="menu_${rootMenu.MODULEID}" class="button" refId="${rootMenu.MODULEID}"> ${rootMenu.NAME} </a>
												</c:if></td>
											<td>|</td>
										</c:forEach>
									</tr>
								</table>



								<div class="menu_nav_right"></div>
							</div>
						</div>
						<!--nav,end-->



						<div style="position: absolute; bottom: 0; right: 0">
							<a class="button">当前用户：<b><a href="javascript:void(0)" onclick="updatePWD()"><%=name%></b></font>
							</a> <a class="easyui-linkbutton" plain="true" iconCls="icon-indexundo" onclick="javascript:relogin();return false;"><font style="color: white">重新登录</font></a>
							<!--  
							<a id="pclink"  class="easyui-linkbutton" plain="true" iconCls="icon-indexredo" onclick="openPc()"><font style="color:white">PC套件</font></a>
							-->
						</div>

					</div>
				</div>
				<!-- south结束-->
			</div>
		</div>
	</div>
	<div region="south" id="tenp" border="false" style="height:20px;text-align:center;padding:0px;position:relative;background:url('<%=basePath%>images/indexbg.png')">(建议在IE8、分辨率1024*768以上使用)</div>

	<div region="west" title="导航菜单" style="width: 170px; padding: 0px; overflow: hidden; border-bottom-width: 0px;">
		<div class="easyui-accordion" fit="true" border="false" id="nav">
			<c:forEach items="${requestScope.accordList}" var="accordMenu" varStatus="status">
				<div title="${accordMenu.NAME}" iconCls="${accordMenu.IMG_PATH}" style="overflow: auto; padding: 10px;">
					<div style="padding: 5px; text-align: center">
						<c:forEach items="${accordMenu.subList}" var="subMenu">
							<a style="text-decoration: none;" ref="${subMenu.MODULEID}" onclick="addTab('${subMenu.MODULEID}','${subMenu.NAME}','${subMenu.ROUTE}','icon-tip','${subMenu.BUTTONMAP}')" bmap="'${subMenu.BUTTONMAP}'" rel="${subMenu.ROUTE}">
								<div style="width: 110px; border: 0px dashed FFFFFF; background: FFFFFF; cursor: pointer; text-align: center" onmouseover="changeColor(this,${subMenu.MODULEID})" onmouseout="changeColor2(this,${subMenu.MODULEID})" onclick="addTab('${subMenu.MODULEID}','${subMenu.NAME}','${subMenu.ROUTE}','icon-tip','${subMenu.BUTTONMAP}')">
									<a style="text-decoration: none;" ref="${subMenu.MODULEID}" onclick="addTab('${subMenu.MODULEID}','${subMenu.NAME}','${subMenu.ROUTE}','icon-tip','${subMenu.BUTTONMAP}')" bmap="${subMenu.BUTTONMAP}" rel="${subMenu.ROUTE}"> <img style="width: 60px; border: 0px" id="imgid${subMenu.MODULEID}" showSrc="${subMenu.IMG_PATH}" hideSrc="${subMenu.HIDE_IMG_PATH}" src="${subMenu.IMG_PATH}"><br>${subMenu.NAME}
									</a>
								</div>
							</a>
							<br>
						</c:forEach>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>


	<div id="mainPanle" region="center" style="background: #eee; overflow: hidden:hidden; border: 0px">
		<div class="easyui-layout" fit="true">
			<div region="center" style="position:relative;background:url('<%=basePath%>images/indexbg.png') repeat;border:0px">
				<div id="tabs" class="easyui-tabs" fit="true" border="false">
					<div title="欢迎使用" style="padding: 0px; overflow: hidden; background: #f0ebf2; text-align: center">
						<iframe scrolling="auto" frameborder="0" src="main.jsp" style="width: 100%; height: 100%;" name="tabFrame" id="idTabFrame"></iframe>
					</div>
				</div>
			</div>
		</div>
	</div>


	<div id="test" class="easyui-window" closed="true" modal="true" title="修改密码" draggable="false" inline="true" maximizable=false collapsible="false" minimizable="false" style="width: 330px; height: 200px;">

		<div class="easyui-layout" fit="true">
			<div region="center" fit="true">
				<form id="ff" method="post">
					<table class="formTable" style="width: 95%;">
						<col width="130px" class="leftCol" />
						<col width="200px">
						<tr>
							<td colspan="2">&nbsp;</td>
						</tr>
						<tr>
							<td><div style="text-align: right;">
									旧密码<font color="red">*</font>
								</div></td>
							<td><input type="hidden" id="focus" /> <input type="password" class="easyui-validatebox" validType="safepass" required="true" name="OLDPWD" id="oldpwd" maxlength="20" /></td>
						</tr>
						<tr>
							<td><div style="text-align: right;">
									新密码<font color="red">*</font>
								</div></td>
							<td><input type="password" class="easyui-validatebox" validType="safepass" required="true" name="NEWPWD" id="newpwd" maxlength="20" /></td>
						</tr>
						<tr>
							<td><div style="text-align: right;">
									确认新密码<font color="red">*</font>
								</div></td>
							<td><input type="password" class="easyui-validatebox" validType="equalTo['#newpwd']" required="true" name="CONFIMPWD" id="confimpwd" maxlength="20" /> <input type="hidden" name="OPER_ID" id="idOperId" maxlength="8" value="<%=person.getAsString("OPER_ID")%>" /></td>
						</tr>
						<tr>
							<td colspan="2">
								<div style="text-align: center; padding-top: 10px">
									&nbsp;&nbsp;&nbsp;&nbsp; <input id="idQuery" type="button" class="btn_grid" value="  确   认  " onclick="addOperInfo();" /> <input id="idReset" type="button" class="btn_grid" value="  重  置  " onclick="cleardata();" /> <input id="idReset" type="button" class="btn_grid" value="  关  闭   " onclick="closeWin();" />
								</div>
							</td>
						</tr>

					</table>
				</form>
			</div>
		</div>
	</div>

	<!-- 右键菜单 -->
	<div id="mm" class="easyui-menu" style="width: 150px;">
		<div id="mm-tabupdate">刷新</div>
		<div class="menu-sep"></div>
		<div id="mm-tabclose">关闭</div>
		<div id="mm-tabcloseall">全部关闭</div>
		<div id="mm-tabcloseother">除此之外全部关闭</div>
		<div class="menu-sep"></div>
		<div id="mm-tabcloseright">当前页右侧全部关闭</div>
		<div id="mm-tabcloseleft">当前页左侧全部关闭</div>
		<div class="menu-sep"></div>
		<div id="mm-exit">退出</div>
	</div>
	<%
		if (request.getAttribute("rootMenuList") == null
				|| ((List) request.getAttribute("rootMenuList")).size() == 0) {
	%>
	<script type="text/javascript">
			msgShow('提示','您当前未拥有管理平台的任何权限，请联系管理员分配','info');
		</script>
	<%
		}
	%>
</body>
</html>
