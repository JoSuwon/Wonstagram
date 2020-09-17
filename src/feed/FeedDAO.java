package feed;

import java.io.File;
import java.io.PrintStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class FeedDAO
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
    catch (Exception e) { System.out.println("CCBoardDAO �ڿ����� ���� : " + e); }
  }

  public void insertFeed(FeedBean feedBean)
  {
    try {
      this.con = getConnection();
      this.sql = "insert into jsp_feed (id, address, imgLocation, content) values (?,?,?,?)";
      this.pstmt = this.con.prepareStatement(this.sql);
      this.pstmt.setString(1, feedBean.getId());
      this.pstmt.setString(2, feedBean.getAddress());
      this.pstmt.setString(3, feedBean.getImgLocation());
      this.pstmt.setString(4, feedBean.getContent());
      this.pstmt.executeUpdate();
    } catch (Exception e) {
      System.out.println("insertFeed �޼��� ���ο��� ���� : " + e);
    } finally {
      resourceClose();
    }
  }

  public ArrayList<FeedBean> getFeedList(String id) {
    ArrayList feedArr = new ArrayList();
    try
    {
      this.con = getConnection();
      this.sql = "select * from jsp_feed where id = ? order by num desc";
      this.pstmt = this.con.prepareStatement(this.sql);
      this.pstmt.setString(1, id);
      this.rs = this.pstmt.executeQuery();

      while (this.rs.next()) {
        FeedBean feedBean = new FeedBean();
        feedBean.setNum(this.rs.getInt("num"));
        feedBean.setId(this.rs.getString("id"));
        feedBean.setAddress(this.rs.getString("address"));
        feedBean.setImgLocation(this.rs.getString("imgLocation"));
        feedBean.setContent(this.rs.getString("content"));
        feedBean.setDate(this.rs.getTimestamp("date"));

        feedArr.add(feedBean);
      }
    } catch (Exception e) {
      System.out.println("getFeedList �޼��� ���ο��� ���� : " + e);
    } finally {
      resourceClose();
    }

    return feedArr;
  }

  public FeedBean getFeed(int num) {
    FeedBean feedBean = new FeedBean();
    try
    {
      this.con = getConnection();
      this.sql = "select * from jsp_feed where num = ?";
      this.pstmt = this.con.prepareStatement(this.sql);
      this.pstmt.setInt(1, num);
      this.rs = this.pstmt.executeQuery();

      if (this.rs.next()) {
        feedBean.setNum(this.rs.getInt(1));
        feedBean.setId(this.rs.getString(2));
        feedBean.setAddress(this.rs.getString(3));
        feedBean.setImgLocation(this.rs.getString(4));
        feedBean.setContent(this.rs.getString(5));
        feedBean.setDate(this.rs.getTimestamp(6));
      }
    } catch (Exception e) {
      System.out.println("getFeed �޼��� ���ο��� ���� : " + e);
    } finally {
      resourceClose();
    }

    return feedBean;
  }

  public void deleteFeed(int num) {
    try {
      String imgLocation = "";
      this.con = getConnection();

      this.sql = "select imgLocation from jsp_feed where num = ?";
      this.pstmt = this.con.prepareStatement(this.sql);
      this.pstmt.setInt(1, num);
      this.rs = this.pstmt.executeQuery();
      if (this.rs.next()) {
        imgLocation = this.rs.getString(1);
      }
      String uploadPath = "C:/Users/JOSUWON/Desktop/ITWILL/workspace_jsp6/JSPProject/WebContent/upload/";
      File f = new File(uploadPath + imgLocation);
      File f2 = new File(uploadPath + "tn_" + imgLocation);
      deleteFile(f);
      deleteFile(f2);

      this.sql = "delete from jsp_feed where num = ?";
      this.pstmt = this.con.prepareStatement(this.sql);
      this.pstmt.setInt(1, num);
      this.pstmt.executeUpdate();

      this.sql = "delete from jsp_comment where feedNum = ?";
      this.pstmt = this.con.prepareStatement(this.sql);
      this.pstmt.setInt(1, num);
      this.pstmt.executeUpdate();

      this.sql = "delete from jsp_like where feedNum = ?";
      this.pstmt = this.con.prepareStatement(this.sql);
      this.pstmt.setInt(1, num);
      this.pstmt.executeUpdate();
    } catch (Exception e) {
      System.out.println("deleteFeed �޼��� ���ο��� ���� : " + e);
    } finally {
      resourceClose();
    }
  }

  public void deleteFile(File f) {
    if (f.exists()) {
      if (f.delete())
        System.out.println("���� ���� ����");
      else
        System.out.println("���� ���� ����");
    }
    else
      System.out.println("������ �������� �ʽ��ϴ�.");
  }

  public ArrayList<FeedBean> searchFeed(String column, String val)
  {
    ArrayList feedArr = new ArrayList();
    try
    {
      this.con = getConnection();
      if (column.equals("id")) {
        this.sql = "select * from jsp_feed where id = ?";
        this.pstmt = this.con.prepareStatement(this.sql);
        this.pstmt.setString(1, val);
      } else if (column.equals("tag")) {
        this.sql = ("select * from jsp_feed where content like '%#" + val + "%'");
        this.pstmt = this.con.prepareStatement(this.sql);
      }

      this.rs = this.pstmt.executeQuery();

      while (this.rs.next()) {
        FeedBean feedBean = new FeedBean();
        feedBean.setNum(this.rs.getInt(1));
        feedBean.setId(this.rs.getString(2));
        feedBean.setAddress(this.rs.getString(3));
        feedBean.setImgLocation(this.rs.getString(4));
        feedBean.setContent(this.rs.getString(5));
        feedBean.setDate(this.rs.getTimestamp(6));

        feedArr.add(feedBean);
      }
    } catch (Exception e) {
      System.out.println("searchFeed �޼��� ���ο��� ���� : " + e);
    } finally {
      resourceClose();
    }

    return feedArr;
  }
}