<%@page import="file.FileDelete"%>
<%@page import="feed.FeedDAO"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.io.File"%>
<%@page import="java.awt.Graphics2D"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="javax.media.jai.JAI"%>
<%@page import="javax.media.jai.RenderedOp"%>
<%@page import="java.awt.image.renderable.ParameterBlock"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	request.setCharacterEncoding("utf-8");

	ServletContext ctx = getServletContext();
	String realPath = ctx.getRealPath("upload/profileImg");
	
	int max = 100 * 1024 * 1024;
	
	MultipartRequest multi = new MultipartRequest(request, realPath, max, "utf-8", new DefaultFileRenamePolicy());
	
	String id = (String)session.getAttribute("id");
	String profileImg = "";
	
	Enumeration e = multi.getFileNames();
	
	
	String name = (String)e.nextElement();
	profileImg = multi.getFilesystemName(name);
	
	// 이 클래스에 변환할 이미지를 담습니다. ( 이미지는 ParameterBlock 통해서만 담을 수 있습니다. )
    ParameterBlock pd = new ParameterBlock();
    pd.add(realPath + "\\" + profileImg);
    RenderedOp rOp = JAI.create("fileload", pd);
    
    int thumbHeight = (int)((float)rOp.getHeight()/(float)(rOp.getWidth()/500f));
	
    BufferedImage bi = rOp.getAsBufferedImage(); // 불러올 이미지를 BufferedImage에 담습니다.
    // thumb라는 이미지 버퍼를 생성합니다. 이미지 버퍼 사이즈는 250 * 250 으로 설정합니다.
    BufferedImage thumb = new BufferedImage(500, thumbHeight, BufferedImage.TYPE_INT_RGB); 
	
    // thumb라는 이미지 버퍼에 원본 이미지를 정해진 버퍼 사이즈인 250 * 250 사이즈에 담아 그립니다.
    Graphics2D g = thumb.createGraphics();
    g.drawImage(bi, 0, 0, 500, thumbHeight, null);
	
    // 출력할 위치와 파일 이름을 설정한 후 썸네일 이미지를 생성합니다. ( 확장자는 jpg입니다. )
    File file = new File(realPath + "/profileImg_" + id.toLowerCase() + ".jpg");
    ImageIO.write(thumb, "jpg", file);
    
    
    //원본프로필사진 삭제
    File f = new File(realPath + "/" + profileImg);
    
    System.out.println(f.getName() + " 업로드된 원본파일 삭제 시도(profileImgUpdate.jsp)");
    //System.out.println(realPath + "/" + profileImg);
    System.out.println(f.getAbsoluteFile());
    if(f.exists()) {
    	System.gc();
		if(f.delete()) {
			System.out.println("파일 삭제 성공");
		} else {
			System.out.println("파일 삭제 실패");
		}
	} else {
		System.out.println("파일이 존재하지 않습니다.");
	}
    /* FileDelete fileDeleteThread = new FileDelete();
	fileDeleteThread.setF(f);
	fileDeleteThread.start(); */
	
    //System.out.println("-----------------------");
    
    response.sendRedirect("/JSPProject/profile/profile.jsp?id=" + id);
%>