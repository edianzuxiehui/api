<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<meta http-equiv="X-UA-Compatible" content="IE=8">

<HTML>
	<meta http-equiv="Content-Type " content="text/html;   charset=UTF-8 ">
	<BODY>
		<%			
			String str=request.getParameter("str");//System.out.println(str);
			str= new String(str.getBytes("ISO-8859-1"),"UTF-8");//这个是关键,System.out.println(str);
			ServletOutputStream ouputStream = null;
			try{
			  response.reset();
			  //System.out.println("request:"+request.getCharacterEncoding());
			  //System.out.println("response:"+response.getCharacterEncoding());
			  response.setCharacterEncoding("gb2312");//修改文件类型为UTF-8->ANSI
		      response.setHeader("Content-disposition", "attachment; filename=import.txt");
		      response.setContentType("application/notepad");
		      ouputStream = response.getOutputStream();
			  ouputStream.print(str+"\r\n");
			}catch(Exception e){			
			e.printStackTrace();
			}finally{
				if(ouputStream!=null){
					ouputStream.close();
				}
			}					
			//out.print(" <script> alert( '导出文件成功! ');window.close(); </script> ");
		  String SERVER="tomcat";//ArtConf.getPropertie("SERVER");
		  if(SERVER==null||SERVER.trim().equalsIgnoreCase("tomcat")){
		  		out.clear();
				out = pageContext.pushBody();
		  }	
		%>
	</BODY>
</HTML>
