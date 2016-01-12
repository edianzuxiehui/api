<script language="JScript">
	var errorMsg = "<html:errors />"
	if (errorMsg!=""){
	try
	{
		alert(errorMsg);
		$("#login_msg").html(errorMsg);
	}
	catch(e)
	{
		
		alert(errorMsg);
	}
	}
	
</script>
