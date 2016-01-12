<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript" src="plugin/jquery/jquery.md5.js"></script>
<script type="text/javascript" src="js/user/user_manager.js"></script>
<input id="sId" name="sId" type="hidden" value="${param.userId}" />
<div class="easyui-layout" style="width: 100%; height: 100%;">
	<!-- Begin of toolbar -->
	<div id="wu-toolbar-user" style="padding: 5px;">
		<label>部门：</label>
		<input id="departmentCombotree" name="departmentCombotree" class="easyui-combotree"
			data-options="method:'get',required:false" style="width: 180px;">
		<!-- <input type="hidden" id="departmentId_user" name="departmentId_user" > -->
		<%-- <select id="departmentId" name="departmentId" panelHeight="auto" style="width: 100px">
				<option value="">全部</option>
				<c:if test="${departmentList != null}">
					<c:forEach var="department" items="${departmentList}">
						<option value="${department.id}">${department.name}</option>
					</c:forEach>
				</c:if>
			</select> --%>

		<label>成员状态：</label>
		<select id="statusId" name="statusId" panelHeight="auto" style="width: 100px">
			<option value="">全部</option>
			<c:if test="${statusList != null}">
				<c:forEach var="status" items="${statusList}">
					<option value="${status.id}">${status.name}</option>
				</c:forEach>
			</c:if>
		</select>

		<label>排序：</label>
		<select id="sortId" name="sortId" panelHeight="auto" style="width: 100px">
			<c:if test="${sortList != null}">
				<c:forEach var="sort" items="${sortList}">
					<option value="${sort.id}">${sort.name}</option>
				</c:forEach>
			</c:if>
		</select>

		<label>关键字：</label>
		<input class="wu-text" id="keyword" name="keyword" style="width: 100px; height: 20px">
		<c:forEach var="rightlist" items="${$rightList}">
			<c:if test="${rightlist.href=='permission/queryUser'}">
				<a href="#" class="easyui-linkbutton" id="btn_searchUser">查 询</a>
			</c:if>
			<c:if test="${rightlist.href=='permission/createUser'}">
				<a href="#" class="easyui-linkbutton" id="btn_showCreateUserDialog">新增成员</a>
			</c:if>
			<c:if test="${rightlist.href=='permission/modifyUser'}">
				<input type="hidden" id="modifyUserRight" name="modifyUserRight" value="1" />
			</c:if>
		</c:forEach>
	</div>
	<!-- End of toolbar -->
	<table id="wu-datagrid-user" class="easyui-datagrid" toolbar="#wu-toolbar-user" ></table>
</div>

<!-- Modal Window -->
<div id="createUserDialog" class="easyui-dialog" title="新增成员" data-options="modal:true,closed:true"
	style="width: 330px; height: 360px; padding: 3px;">
	<form id="createUserForm" class="ui-form" method="post">
		<table cellspacing="3" cellpadding="3" border=0>
			<tbody>
				<tr>
					<td>
						<span style="color: red">姓名：</span>
					</td>
					<td>
						<input type="text" id="cUName" name="cUName" style="width: 180px;" />
					</td>
				</tr>

				<tr>
					<td>
						<span style="color: red">部门：</span>
					</td>
					<td>
						<input id="cDepartmentCombotree" name="cDepartmentCombotree" class="easyui-combotree"
							data-options="method:'get',required:false" style="width: 180px;">
						<%-- <select id="cDepartmentId" name="cDepartmentId" panelHeight="auto" style="width: 180px">
							<c:if test="${departmentList != null}">
								<c:forEach var="department" items="${departmentList}">
									<option value="${department.id}">${department.name}</option>
								</c:forEach>
							</c:if>
						</select> --%>
					</td>
				</tr>

				<tr>
					<td>
						<span style="color: red">职称：</span>
					</td>
					<td>
						<select id="cUTitleId" name="cUTitleId" panelHeight="auto" style="width: 180px">
							<!-- <option value=""></option> -->
							<c:if test="${titleList != null}">
								<c:forEach var="title" items="${titleList}">
									<option value="${title.id}">${title.name}</option>
								</c:forEach>
							</c:if>
						</select>
					</td>
				</tr>
				<tr>
					<td>
						<span style="color: red">登录邮箱：</span>
					</td>
					<td>
						<input id="cUEmail" name="cUEmail" style="width: 180px" />
					</td>
				</tr>

				<tr>
					<td>
						<span style="color: red">登录密码：</span>

					</td>
					<td>
						<input id="cUPassword" name="cUPassword" style="width: 180px" value="edianzu" />
					</td>
				</tr>

				<tr>
					<td>
						<span style="color: red">手机号码：</span>
					</td>
					<td>
						<input id="cUPhone" name="cUPhone" style="width: 180px" />
					</td>
				</tr>
				<tr>
					<td>
						<span style="color: red">用户角色：</span>
					</td>
					<td>
						<select id="cURoleId" name="cURoleId" panelHeight="auto" style="width: 180px">
							<c:if test="${rolePage.roleList != null}">
								<c:forEach var="role" items="${rolePage.roleList}">
									<c:if test="${role.id != 1}"> selected 
										<option value="${role.id}">${role.name}</option>
									</c:if>
								</c:forEach>
							</c:if>
						</select>
					</td>
				</tr>
				<tr>
					<td>
						<span style="color: red">用户状态：</span>
					</td>
					<td>
						<%-- <select id="cStatusId" name="cStatusId" panelHeight="auto" style="width: 180px">--%>
						<c:if test="${statusList != null}">
							<c:forEach var="status" items="${statusList}" varStatus="i">
								<input type="radio" name="cUStatusId" id="cUStatusId${i.count-1}" value="${status.id}"
									<c:if test="${status.id == 1}"> checked="checked" </c:if>
									style="vertical-align: middle; margin-top: -2px; margin-bottom: 1px;" />${status.name}
								<%-- <option value="${status.id}" <c:if test="${status.id == 1}"> selected </c:if>>${status.name}</option> --%>
							</c:forEach>
						</c:if>
						<!-- </select> -->
					</td>
				</tr>
				<tr>
					<td class="value" colspan="2" height="10px"></td>
				</tr>
			</tbody>
		</table>
		<div align="center">
			<input type="button" id="btn_createUserCancel" value="取消 " />
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" id="btn_createUser" value="确定 " />
		</div>
	</form>
</div>

<!-- Modal Window -->
<div id="modifyUserDialog" class="easyui-dialog" title="编辑成员" data-options="modal:true,closed:true"
	style="width: 330px; height: 360px; padding: 3px;">
	<form id="modifyUserForm" class="ui-form" method="post">
		<table cellspacing="3" cellpadding="3" border=0>
			<tbody>
				<tr>
					<td>
						<span style="color: red">姓名：</span>
					</td>
					<td>
						<input id="mUId" name="mUId" type="hidden" value="" />
						<input type="text" id="mUName" name="mUName" style="width: 180px;" />
					</td>
				</tr>

				<tr>
					<td>
						<span style="color: red">部门：</span>
					</td>
					<td>
						<input id="mDepartmentCombotree" name="mDepartmentCombotree" class="easyui-combotree"
							data-options="method:'get',required:false" style="width: 180px;">
						<%-- <select id="mDepartmentId" name="mDepartmentId" panelHeight="auto" style="width: 180px">
							<c:if test="${departmentList != null}">
								<c:forEach var="department" items="${departmentList}">
									<option value="${department.id}">${department.name}</option>
								</c:forEach>
							</c:if>
						</select> --%>
					</td>
				</tr>

				<tr>
					<td>
						<span style="color: red">职称：</span>
					</td>
					<td>
						<select id="mUTitleId" name="mUTitleId" panelHeight="auto" style="width: 180px">
							<!-- <option value=""></option> -->
							<c:if test="${titleList != null}">
								<c:forEach var="title" items="${titleList}">
									<option value="${title.id}">${title.name}</option>
								</c:forEach>
							</c:if>
						</select>
					</td>
				</tr>
				<tr>
					<td>
						<span style="color: red">登录邮箱：</span>
					</td>
					<td>
						<input id="mUEmail" name="mUEmail" style="width: 180px" />
					</td>
				</tr>

				<tr>
					<td>
						<span style="color: red">登录密码：</span>
					</td>
					<td>
						<input id="mUPassword" name="mUPassword" style="width: 180px" />
					</td>
				</tr>

				<tr>
					<td>
						<span style="color: red">手机号码：</span>
					</td>
					<td>
						<input id="mUPhone" name="mUPhone" style="width: 180px" />
					</td>
				</tr>
				<tr>
					<td>
						<span style="color: red">用户角色：</span>
					</td>
					<td>
						<select id="mURoleId" name="mURoleId" panelHeight="auto" style="width: 180px">
							<c:if test="${rolePage.roleList != null}">
								<c:forEach var="role" items="${rolePage.roleList}">
									<c:if test="${role.id != 1}"> selected 
										<option value="${role.id}">${role.name}</option>
									</c:if>
								</c:forEach>
							</c:if>
						</select>
					</td>
				</tr>
				<tr>
					<td>
						<span style="color: red">用户状态：</span>
					</td>
					<td>
						<c:if test="${statusList != null}">
							<c:forEach var="status" items="${statusList}" varStatus="i">
								<input type="radio" name="mUStatusId" id="mUStatusId${i.count-1}" value="${status.id}"
									style="vertical-align: middle; margin-top: -2px; margin-bottom: 1px;" />${status.name}
							</c:forEach>
						</c:if>
						<%-- <select id="mStatusId" name="mStatusId" panelHeight="auto" style="width: 180px">
							<c:if test="${statusList != null}">
								<c:forEach var="status" items="${statusList}">
									<option value="${status.id}">${status.name}</option>
								</c:forEach>
							</c:if>
						</select> --%>
					</td>
				</tr>
				<tr>
					<td class="value" colspan="2" height="10px"></td>
				</tr>
			</tbody>
		</table>
		<div align="center">
			<input type="button" id="btn_modifyUserCancel" value="取消 " />
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" id="btn_modifyUser" value="确定 " />
			<!-- <a href="javascript:void(0)" class="easyui-linkbutton" id="btn_modifyCancel"
				onclick="$('#modifyUserDialog').window('close')" >取消</a>
			<a href="#" class="easyui-linkbutton" id="btn_modifyUser" >确定</a> -->
		</div>
	</form>
</div>
