<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<body>
	<h2>
		您好!
		<br>
		这是crm-mobile-webapp模块。
	</h2>
	
	<img alt="test" src="E:\play\tomcat\webapps\risk\ef402c139662a96e4d4d2e9bf17b19b6.jpg">
	<form action="customer/uploadRemarkFiles" method="post" enctype="multipart/form-data">
		<input type="text" name="content" />
		<input type="text" name="applyId" />
		<input type="file" name="multipartFile" />
		<input type="hidden" name="token" value="f204ad42e8ac982c656423ecd1041ed3">
		<input type="hidden" name="logId" value="4">
		
		<input type="file" name="multipartFile" />
		<input type="hidden" name="token" value="f204ad42e8ac982c656423ecd1041ed3">
		<input type="hidden" name="logId" value="4">
		
		<input type="file" name="multipartFile" />
		<input type="hidden" name="token" value="f204ad42e8ac982c656423ecd1041ed3">
		<input type="hidden" name="logId" value="4">
		
		<input type="submit" value="上传" />
	</form>
	<form action="permission/login" method="post">
		<input type="text" name="email" value="xiehui@edianzu.cn"/>
		<input type="text" name="password" value="e10adc3949ba59abbe56e057f20f883e"/>
		<input type="submit" value="登陆" />
	</form>
</body>
</html>
