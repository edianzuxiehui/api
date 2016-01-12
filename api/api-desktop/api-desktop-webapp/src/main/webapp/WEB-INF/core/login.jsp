<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<HTML xmlns="http://www.w3.org/1999/xhtml">
<head>
<TITLE>用户登录</TITLE>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String root = path;
%>

<script type="text/javascript" src="<%=basePath%>js/md5.js"></script>
<LINK href="<%=basePath%>images/login/User_Login.css" type="text/css"
	rel="stylesheet">
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>themes/default/easyui.css">
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>themes/icon.css">
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>css/default.css">
<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/jquery.bgiframe.js"></script>
<script type="text/javascript"
	src="<%=basePath%>js/jquery.easyui.min.js"></script>
<script type="text/javascript"
	src="<%=basePath%>js/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="<%=basePath%>js/Toolbar.js"></script>
<script type="text/javascript" src="<%=basePath%>js/common.js"></script>
<script language="JavaScript">
	if (window != top)
		top.location.href = location.href;
</script>
<script type="text/javascript">
	function Login() {
		if ((document.getElementById("loginname").value) != "") {
			if (document.getElementById("pwd").value == "") {
				document.getElementById("login_msg").innerHTML = "请输入密码！";
				document.getElementById("pwd").focus();
			} else {
				login_();
				return true;
			}
		} else {
			document.getElementById("login_msg").innerHTML = "请输入用户名！";
			document.getElementById("loginname").focus();
			return false;
		}
	}

	function login_() {
		var email = $('#loginname').val();
		var password = $('#pwd').val();
		$
				.ajax({
					type : "POST",
					url : "permission/login",
					async : false,
					data : "email=" + email + "&password=" + password,
					success : function(data) {
						var parsedJson = eval(data);
						if (parsedJson.code != 0) {
							document.getElementById("login_msg").innerHTML = parsedJson.message;
						} else {
							var retValue = openDialogFrame(getRootPath()
									+ "/core/index.jsp",
									"token=" + parsedJson.data + "&t=1", "850", "450");
						}
					}
				});
	}

	function init() {
		var errorMsg = "<html:errors />"
		if (errorMsg != "") {
			try {
				document.getElementById("login_msg").innerHTML = errorMsg;
			} catch (e) {
				alert(errorMsg);
			}
		}

	}

	function keyEvent() {
		var event = arguments.callee.caller.arguments[0] || window.event;//消除浏览器差异   
		if (event.keyCode == 13) {
			Login();
		}

	}
</script>
</head>
<BODY id=userlogin_body onload="init()">
	<DIV></DIV>

	<DIV id=user_login>
		<DL>
			<DD id=user_top>
				<UL>
					<LI class=user_top_l></LI>
					<LI class=user_top_c></LI>
					<LI class=user_top_r></LI>
				</UL>
			<DD id=user_main>
				<UL>
					<LI class=user_main_l></LI>
					<LI class=user_main_c>
						<DIV class=user_main_box>
							<form name="loginForm" id="loginForm">
								<table>
									<tr>
										<td class=user_main_text><b style="height: 100px">用户名：
										</b></td>
										<td class=user_main_input_username colspan="2"><INPUT
											class=TxtUserNameCssClass id="loginname" name="email"
											value="" maxlength="50"></td>
									</tr>
									<tr>
										<td class=user_main_text><b style="height: 100px">密&nbsp;&nbsp;&nbsp;码：
										</b></td>
										<td class=user_main_input_password colspan="2"><INPUT
											type="password" class=TxtPasswordCssClass id="pwd"
											name="password" value="" onkeyup="keyEvent();" maxlength="20">
										</td>
									</tr>

									<tr>
								</table>
								<table>
									<td colspan="2" style="height: 50px; width: 500px">
										<div id="login_msg"
											style="color: red; font: 12px; align-text: center; height: 50px;"></div>
									</td>
									</tr>
								</table>
							</form>
						</DIV>
					</LI>
					<LI class=user_main_r><INPUT class=IbtnEnterCssClass
						id=IbtnEnter
						style="BORDER-TOP-WIDTH: 0px; BORDER-LEFT-WIDTH: 0px; BORDER-BOTTOM-WIDTH: 0px; BORDER-RIGHT-WIDTH: 0px"
						hidefocus="true" onclick="Login();" type=image
						src="images/login/user_botton.gif" name=IbtnEnter></LI>
				</UL>
			<DD id=user_bottom>
				<UL>
					<LI class=user_bottom_l></LI>
					<LI class=user_bottom_c></LI>
					<LI class=user_bottom_r></LI>
				</UL>
			</DD>
		</DL>
	</DIV>


	</FORM>
</BODY>
</html>
