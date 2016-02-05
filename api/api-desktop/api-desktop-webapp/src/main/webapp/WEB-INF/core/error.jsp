<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style type="text/css">
.align-center {
	position: fixed;
	left: 50%;
	top: 50%;
	margin-left: width/2;
	margin-top: height/2;
}
</style>
<script type="text/javascript">
	var i = 5;
	var intervalid;
	intervalid = setInterval("countDown()", 1000);
	function countDown() {
		if (i == 0) {
			//window.location.href = "login";
			clearInterval(intervalid);
		}
		document.getElementById("second").innerHTML = i;
		i--;
	}
</script>
<div> <!-- class="align-center" -->
	<center>
		<br>
		<h3>
			<font color="red"><%-- ${message} --%><%request.getParameter("message"); %></font>
		</h3>
		<p>
			将在
			<span id="second">5</span>
			秒后前往登录页面
		</p>
		如果不跳转,请点击
		<a href="login">
			<font color="red"> 这里  </font>
		</a>
		登录
		<br>
		<br>
		<br>
		<br>
		<br>
	</center>
</div>

