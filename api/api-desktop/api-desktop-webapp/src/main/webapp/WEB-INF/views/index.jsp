<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="resource.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>易点租CRM管理后台</title>
<script type="text/javascript" src="js/index.js"></script>
</head>
<%-- <c:set var="username" value="${user.name}" scope="session" /> 
<input id="myId" name="myId" type="hidden" value="${user.id}" /> --%>
<body class="easyui-layout" scroll="no">
	<!-- begin of header -->
	<div class="wu-header" data-options="region:'north',border:false,split:false">
		<div class="wu-header-left">
			<img src="images/logo_top.png" />
		</div>
		<div class="wu-header-right">
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td align="right" nowrap>
						<table border="0" cellpadding="0" cellspacing="0">
							<tr style="height: 25px;" align="right">
								<td style="" colspan="2">
									<div style="float: right;">
										<div style="float: left; line-height: 25px; margin-left: 50px;">
											<a href="#" class="easyui-linkbutton" data-options="plain:true" style="color: #FFFFFF">
												<strong>${user.name},欢迎你!</strong>
											</a>
											&nbsp;&nbsp;
										</div>
										<div style="float: left; margin-left: 10px;">
											<div style="right: 0px; bottom: 0px;"><!--  iconCls="icon-cog" -->
												<a href="javascript:void(0);" id="control" class="easyui-menubutton" menu="#layout_north_kzmbMenu" iconCls="icon-user"
													style="color: #FFFFFF">个人信息</a>
												&nbsp;&nbsp;
												<a href="#" onclick='logout();' id="logout" class="easyui-linkbutton" data-options="plain:true"
													iconCls="icon-logout" style="color: #FFFFFF">退出系统</a>
											</div>
											<div id="layout_north_kzmbMenu" style="width: 100px; display: none;">
												<div>修改信息</div>
												<div class="menu-sep"></div>
												<div>修改密码</div>
											</div>
											<!-- <div id="layout_north_zxMenu" style="width: 100px; display: none;">
												<div onclick='logout();'>退出系统</div>
											</div> -->
										</div>
										<div style="float: left; margin-left: 8px; margin-right: 5px; margin-top: 5px;">
											<img src="images/layout_button_up.gif" style="cursor: pointer" onclick="panelCollapase()" />
										</div>

									</div>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<!-- end of header -->
	<!-- begin of sidebar -->
	<div class="wu-sidebar" data-options="region:'west',split:false,border:true,title:'导航菜单'">
		<!-- <div class="easyui-accordion" data-options="border:false,fit:true"> -->
				<ul id="menutree" class="easyui-tree" data-options="method:'get',animate:true"></ul>
				<%-- <c:forEach var="module" items="${menuList}" varStatus="i">
				<div title="${module.name}" data-options="iconCls:'icon-application-double'" style="padding: 5px;">
					<ul class="easyui-tree wu-side-tree">
						<c:forEach var="menu" items="${module.menuList}">
							<li iconCls="icon-application-view-tile">
								<a href="javascript:void(0)" data-link="${menu.href}" iframe="0">${menu.name}</a>
							</li>
						</c:forEach>
					</ul>
				</div>
			</c:forEach> --%>
		<!-- 	</div> -->
	</div>
	<!-- end of sidebar -->
	
	<!-- begin of main -->
	<div class="wu-main" data-options="region:'center',split:false">
		<div id="wu-tabs" class="easyui-tabs" data-options="border:false,fit:true">
		<%-- <div title="线索" data-options="href:'all_company',closable:true,cls:'pd3'"></div>
			<c:forEach var="module" items="${menuList}" begin="0" end="0" varStatus="i">
				<c:forEach var="menu" items="${module.menuList}" begin="0" end="0">
					<div title="${menu.name}" data-options="href:'${menu.href}',closable:true,cls:'pd3'"></div>
				</c:forEach>
			</c:forEach> --%>
		</div>
	</div>
	<!-- end of main -->

	<!-- 右侧 -->
	<div class="wu-sidebar" style="width: 300px;"
		data-options="region:'east',split:true,iconCls:'icon-reload',title:'辅助信息',collapsed:true">
		<div class="easyui-accordion" data-options="border:false,fit:true">
			<!-- <div id="tabs" class="easyui-tabs" border="false" style="height: 240px">
				<div title="附加" style="padding: 0px; overflow: hidden; color: red;">
					<div id="layout_east_calendar"></div>
				</div>
			</div> -->
		</div>
	</div>

	<!-- begin of footer -->
	<div class="wu-footer" data-options="region:'south',border:false,split:false">© Copyright Reserved 2014-2015 |
		北京易点淘网络技术有限公司</div>
	<!-- end of footer -->
</body>
</html>
