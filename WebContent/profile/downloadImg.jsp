<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.FileNotFoundException"%>
<%@page import="java.io.File"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.InputStream"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
	
<%
	request.setCharacterEncoding("utf-8");
	String imgLocation = request.getParameter("imgLocation");
	String orgfilename = imgLocation;
	
	String root = request.getSession().getServletContext().getRealPath("/");
	String savePath = root + "upload";
	
	
	InputStream in = null;
	OutputStream os = null;
	File file = null;
	boolean skip = false;
	String client = "";
	
	try {
		try {
			file = new File(savePath, imgLocation);
			in = new FileInputStream(file);
		}catch(FileNotFoundException fe) {
			skip = true;
		}
		
		client = request.getHeader("User-Agent");
		
		response.reset();
		response.setContentType("application/octet-stream");
		response.setHeader("Content-Description", "JSP Generated Data");
		
		if(!skip) {
			// IE
			if(client.indexOf("MSIE") != -1) {
				response.setHeader ("Content-Disposition", "attachment; filename="+new String(orgfilename.getBytes("KSC5601"),"ISO8859_1"));
			} else {
				orgfilename = new String(orgfilename.getBytes("utf-8"),"iso-8859-1");
				 
                response.setHeader("Content-Disposition", "attachment; filename=\"" + orgfilename + "\"");
                response.setHeader("Content-Type", "application/octet-stream; charset=utf-8");
			}
			
			response.setHeader ("Content-Length", ""+file.length() );
			 
			os = response.getOutputStream();
			byte b[] = new byte[(int)file.length()];
			int leng = 0;
			 
			while( (leng = in.read(b)) > 0 ){
			    os.write(b,0,leng);
			}
			
		} else {
			response.setContentType("text/html;charset=UTF-8");
			out.println("<script>alert('파일을 찾을 수 없습니다.');history.back();</script>");
		}
		
		in.close();
		os.close();
		
	} catch(Exception e) {
		e.printStackTrace();
	}
%>