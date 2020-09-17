package relation;

import java.io.PrintStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class RelationDAO
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

  public boolean doYouFollow(String id, String targetId)
  {
    boolean result = false;
    try
    {
      this.con = getConnection();
      this.sql = "select * from jsp_relation where id =? and targetId = ?";
      this.pstmt = this.con.prepareStatement(this.sql);
      this.pstmt.setString(1, id);
      this.pstmt.setString(2, targetId);
      this.rs = this.pstmt.executeQuery();

      if (this.rs.next())
        result = true;
    }
    catch (Exception e) {
      System.out.println("doYouFollow 메서드 내부에서 에러 : " + e);
    } finally {
      resourceClose();
    }

    return result;
  }

  public void followOn(String id, String targetId) {
    try {
      this.con = getConnection();
      this.sql = "select * from jsp_relation where id=? and targetId=?";
      this.pstmt = this.con.prepareStatement(this.sql);
      this.pstmt.setString(1, id);
      this.pstmt.setString(2, targetId);
      this.rs = this.pstmt.executeQuery();

      if (this.rs.next()) return;
      this.sql = "insert into jsp_relation (id, targetId) values (?,?)";
      this.pstmt = this.con.prepareStatement(this.sql);
      this.pstmt.setString(1, id);
      this.pstmt.setString(2, targetId);

      this.pstmt.executeUpdate();
    } catch (Exception e) {
      System.out.println("followOn 메서드 내부에서 에러 : " + e);
    } finally {
      resourceClose();
    }
  }

  public void followOff(String id, String targetId) {
    try {
      this.con = getConnection();
      this.sql = "select * from jsp_relation where id = ? and targetId = ?";
      this.pstmt = this.con.prepareStatement(this.sql);
      this.pstmt.setString(1, id);
      this.pstmt.setString(2, targetId);
      this.rs = this.pstmt.executeQuery();

      if (!this.rs.next()) return;

      this.sql = "delete from jsp_relation where id = ? and targetId = ?";
      this.pstmt = this.con.prepareStatement(this.sql);
      this.pstmt.setString(1, id);
      this.pstmt.setString(2, targetId);

      this.pstmt.executeUpdate();
    } catch (Exception e) {
      System.out.println("followOff 메서드 내부에서 에러 : " + e);
    } finally {
      resourceClose();
    }
  }

  public ArrayList<String> getFollowerList(String targetId) {
    ArrayList followerArr = new ArrayList();
    try
    {
      this.con = getConnection();
      this.sql = "select id from jsp_relation where targetId = ?";
      this.pstmt = this.con.prepareStatement(this.sql);
      this.pstmt.setString(1, targetId);
      this.rs = this.pstmt.executeQuery();

      while (this.rs.next())
        followerArr.add(this.rs.getString(1));
    }
    catch (Exception e) {
      System.out.println("getFollowerList 메서드 내부에서 에러 : " + e);
    } finally {
      resourceClose();
    }

    return followerArr;
  }

  public ArrayList<String> getFollowingList(String id) {
    ArrayList followingArr = new ArrayList();
    try
    {
      this.con = getConnection();
      this.sql = "select targetId from jsp_relation where id = ?";
      this.pstmt = this.con.prepareStatement(this.sql);
      this.pstmt.setString(1, id);
      this.rs = this.pstmt.executeQuery();

      while (this.rs.next())
        followingArr.add(this.rs.getString(1));
    }
    catch (Exception e) {
      System.out.println("getFollowerList 메서드 내부에서 에러 : " + e);
    } finally {
      resourceClose();
    }

    return followingArr;
  }
}