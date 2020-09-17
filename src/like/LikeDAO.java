package like;

import java.io.PrintStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class LikeDAO
{
  private Connection con = null;
  private String sql = "";
  private PreparedStatement pstmt = null;
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
    catch (Exception e) { System.out.println("자원해제 에러 : " + e); }

  }

  public boolean doYouLike(int feedNum, String id)
  {
    boolean result = false;
    try
    {
      this.con = getConnection();
      this.sql = "select * from jsp_like where feedNum = ? and id = ?";
      this.pstmt = this.con.prepareStatement(this.sql);
      this.pstmt.setInt(1, feedNum);
      this.pstmt.setString(2, id);
      this.rs = this.pstmt.executeQuery();

      if (this.rs.next())
        result = true;
    }
    catch (Exception e) {
      System.out.println("doYouLike 메서드 내부에서 에러 : " + e);
    } finally {
      resourceClose();
    }

    return result;
  }

  public void likeOn(int feedNum, String id) {
    try {
      this.con = getConnection();
      this.sql = "select * from jsp_like where feedNum = ? and id = ?";
      this.pstmt = this.con.prepareStatement(this.sql);
      this.pstmt.setInt(1, feedNum);
      this.pstmt.setString(2, id);
      this.rs = this.pstmt.executeQuery();

      if (this.rs.next()) {
        return;
      }
      this.sql = "insert into jsp_like values(?,?)";
      this.pstmt = this.con.prepareStatement(this.sql);
      this.pstmt.setInt(1, feedNum);
      this.pstmt.setString(2, id);
      this.pstmt.executeUpdate();
    }
    catch (Exception e) {
      System.out.println("likeOn 메서드 내부에서 에러 : " + e);
    } finally {
      resourceClose();
    }
  }

  public void likeOff(int feedNum, String id) {
    try {
      this.con = getConnection();
      this.sql = "select * from jsp_like where feedNum = ? and id = ?";
      this.pstmt = this.con.prepareStatement(this.sql);
      this.pstmt.setInt(1, feedNum);
      this.pstmt.setString(2, id);
      this.rs = this.pstmt.executeQuery();

      if (!this.rs.next()) {
        return;
      }
      this.sql = "delete from jsp_like where feedNum = ? and id = ?";
      this.pstmt = this.con.prepareStatement(this.sql);
      this.pstmt.setInt(1, feedNum);
      this.pstmt.setString(2, id);
      this.pstmt.executeUpdate();
    }
    catch (Exception e) {
      System.out.println("likeOff 메서드 내부에서 에러 : " + e);
    } finally {
      resourceClose();
    }
  }

  public ArrayList<String> getLikeList(int feedNum) {
    ArrayList likeArr = new ArrayList();
    try
    {
      this.con = getConnection();
      this.sql = "select id from jsp_like where feedNum = ?";
      this.pstmt = this.con.prepareStatement(this.sql);
      this.pstmt.setInt(1, feedNum);
      this.rs = this.pstmt.executeQuery();

      while (this.rs.next())
        likeArr.add(this.rs.getString(1));
    }
    catch (Exception e) {
      System.out.println("getLikeList 메서드 내부에서 에러 : " + e);
    } finally {
      resourceClose();
    }

    return likeArr;
  }
}