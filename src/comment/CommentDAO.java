package comment;

import java.io.PrintStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class CommentDAO
{
  private Connection con = null;
  private PreparedStatement pstmt = null;
  private String sql = "";
  private ResultSet rs = null;

  private Connection getConnection() throws Exception {
    Connection con = null;
    Context init = new InitialContext();
    DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/jspbeginner");
    con = ds.getConnection();

    return con;
  }

  private void resourceClose() {
    try {
      if (this.rs != null) this.rs.close();
      if (this.pstmt != null) this.pstmt.close();
      if (this.con != null) this.con.close(); 
    }
    catch (Exception e) { System.out.println("CCBoardDAO 자원해제 실패 : " + e); }
  }

  public int insertComment(CommentBean commentBean)
  {
    int num = 0;
    try
    {
      this.con = getConnection();
      this.sql = "insert into jsp_comment (feedNum, id, content) values (?,?,?)";
      this.pstmt = this.con.prepareStatement(this.sql, 1);
      this.pstmt.setInt(1, commentBean.getFeedNum());
      this.pstmt.setString(2, commentBean.getId());
      this.pstmt.setString(3, commentBean.getContent());

      this.pstmt.executeUpdate();
      this.rs = this.pstmt.getGeneratedKeys();
      if (this.rs.next())
        num = this.rs.getInt(1);
    }
    catch (Exception e) {
      System.out.println("insertComment 메서드 내부에서 에러 : " + e);
    } finally {
      resourceClose();
    }

    return num;
  }

  public ArrayList<CommentBean> getCommentList(int feedNum) {
    ArrayList commentArr = new ArrayList();
    try
    {
      this.con = getConnection();
      this.sql = "select * from jsp_comment where feedNum = ?";
      this.pstmt = this.con.prepareStatement(this.sql);
      this.pstmt.setInt(1, feedNum);

      this.rs = this.pstmt.executeQuery();
      while (this.rs.next()) {
        CommentBean commentBean = new CommentBean();
        commentBean.setFeedNum(this.rs.getInt(1));
        commentBean.setNum(this.rs.getInt(2));
        commentBean.setId(this.rs.getString(3));
        commentBean.setContent(this.rs.getString(4));
        commentBean.setDate(this.rs.getTimestamp(5));

        commentArr.add(commentBean);
      }
    } catch (Exception e) {
      System.out.println("getCommentList 메서드 내부에서 에러 : " + e);
    } finally {
      resourceClose();
    }

    return commentArr;
  }

  public void deleteComment(int num) {
    try {
      this.con = getConnection();
      this.sql = "delete from jsp_comment where num = ?";
      this.pstmt = this.con.prepareStatement(this.sql);
      this.pstmt.setInt(1, num);
      this.pstmt.executeUpdate();
    } catch (Exception e) {
      System.out.println("deleteComment 메서드 내부에서 에러 : " + e);
    } finally {
      resourceClose();
    }
  }

  public CommentBean getComment(int num) {
    CommentBean commentBean = new CommentBean();
    try
    {
      this.con = getConnection();
      this.sql = "select * from jsp_comment where num = ?";
      this.pstmt = this.con.prepareStatement(this.sql);
      this.pstmt.setInt(1, num);
      this.rs = this.pstmt.executeQuery();

      if (this.rs.next()) {
        commentBean.setFeedNum(this.rs.getInt(1));
        commentBean.setNum(this.rs.getInt(2));
        commentBean.setId(this.rs.getString(3));
        commentBean.setContent(this.rs.getString(4));
        commentBean.setDate(this.rs.getTimestamp(5));
      }
    } catch (Exception e) {
      System.out.println("getComment 메서드 내부에서 에러 : " + e);
    } finally {
      resourceClose();
    }

    return commentBean;
  }
}