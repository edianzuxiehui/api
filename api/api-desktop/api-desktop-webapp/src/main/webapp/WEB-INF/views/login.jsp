<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>易点租CRM管理后台</title>
<link href="plugin/login/css/zice.style.css" rel="stylesheet" type="text/css" />
<link href="plugin/login/css/buttons.css" rel="stylesheet" type="text/css" />
<link href="plugin/login/css/icon.css" rel="stylesheet" type="text/css" />
<link href="plugin/login/css/tipsy.css" rel="stylesheet" type="text/css" media="all" />
<style type="text/css">
html {
	background-image: none;
}

label.iPhoneCheckLabelOn span {
	padding-left: 0px
}

#versionBar {
	background-color: #212121;
	position: fixed;
	width: 100%;
	height: 45px;
	bottom: 0;
	left: 0;
	text-align: center;
	line-height: 45px;
	z-index: 11;
	-webkit-box-shadow: black 0px 10px 10px -10px inset;
	-moz-box-shadow: black 0px 10px 10px -10px inset;
	box-shadow: black 0px 10px 10px -10px inset;
}

.copyright {
	text-align: center;
	font-size: 12px;
	color: #CCC;
}

.copyright a {
	color: #CCC;
	text-decoration: none
}

#login .logo {
	width: 500px;
	height: 50px;
}
</style>
</head>
<body>
	<div id="alertMessage"></div>
	<div id="successLogin"></div>
	<div class="text_success">
		<img src="plugin/login/images/loader_green.gif" alt="Please wait" />
		<span>登陆成功!请稍后....</span>
	</div>
	<div id="login">
		<div class="inner">
			<div class="logo">
				<img src="plugin/login/images/logo_edianzu.png" />
			</div>
			<div class="formLogin">
				<form name="formLogin" id="formLogin" action="permission/login" method="post">
					<div class="tip">
						<input id="email" name="email" type="text" value='' title="邮箱" class="userName"  iscookie="true"
							nullmsg="请输入邮箱!" />
					</div>
					<div class="tip">
						<input id="password" name="password" type="password" value="edianzu" title="密码" class="password"  nullmsg="请输入密码!" />
					</div>
					<div class="loginButton">
						<div style="float: left; margin-left: -9px;">
                            <input type="checkbox" id="on_off" name="on_off" checked="ture" class="on_off_checkbox" value="0" />
                            <span class="f_help">是否记住用户名 ?</span>
                        </div>
						<div style="float: center;">
							<div>
								<ul class="uibutton-group">
									<li>
										<a class="uibutton normal" href="#" id="btn_login">登录</a>
									</li>
									<li>
										<div style="width:30px">&nbsp;</div>
									</li>
									<li>
										<a class="uibutton normal" href="#" id="btn_reset">重置</a>
									</li>
								</ul>
							</div>
						</div>
						<div class="clear"></div>
					</div>
				</form>
			</div>
		</div>
		<div class="shadow"></div>
	</div>
	<!--Login div-->
	<div class="clear"></div>
	<div id="versionBar">
		<div class="copyright">
			© Copyright Reserved 2014-2015 |
			<a href="http://www.edianzu.cn" title="">北京易点淘网络技术有限公司</a>
			<!-- <span class="tip"><a href="http://www.edianzu.cn" title="">北京易点淘网络技术有限公司 </a> (推荐使用IE8+,谷歌浏览器可以获得更快,更安全的页面响应速度) </span> -->
		</div>
	</div>
	
	<!-- Link JScript-->
	<script type="text/javascript" src="plugin/jquery/jquery-1.8.3.min.js"></script>
<!-- 	<script type="text/javascript" src="plugin/jquery/jquery.form.js"></script> -->
	<script type="text/javascript" src="plugin/jquery/jquery.cookie.js"></script>
	<script type="text/javascript" src="plugin/jquery/jquery.md5.js"></script>
	<script type="text/javascript" src="plugin/login/js/jquery-jrumble.js"></script>
	<script type="text/javascript" src="plugin/login/js/jquery.tipsy.js"></script>
	<script type="text/javascript" src="plugin/login/js/iphone.check.js"></script>
	<script type="text/javascript" src="js/login.js"></script>
</body>
</html>