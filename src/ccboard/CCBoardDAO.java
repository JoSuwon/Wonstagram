package ccboard;

import java.io.PrintStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class CCBoardDAO
{
  Connection con = null;
  ResultSet rs = null;
  PreparedStatement pstmt = null;
  String sql = "";

  private void resourceClose() {
    try {
      if (this.rs != null) this.rs.close();
      if (this.pstmt != null) this.pstmt.close();
      if (this.con != null) this.con.close(); 
    }
    catch (Exception e) { System.out.println("CCBoardDAO 자원해제 실패 : " + e); }
  }

  private Connection getConnection() throws Exception
  {
    Connection con = null;
    Context init = new InitialContext();
    DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/jspbeginner");
    con = ds.getConnection();

    return con;
  }

  public int getMaxNum() {
    int max = 1;
    try
    {
      this.con = getConnection();
      this.sql = "select max(num) from jsp_ccboard";
      this.pstmt = this.con.prepareStatement(this.sql);
      this.rs = this.pstmt.executeQuery();

      if (this.rs.next())
        max = this.rs.getInt(1);
    }
    catch (Exception e) {
      System.out.println("getMaxNum() 메서드 내부에서 에러 : " + e);
    } finally {
      resourceClose();
    }

    return max;
  }

  public int getBoardCount() {
    int count = 0;
    try
    {
      this.con = getConnection();
      this.sql = "select count(num) from jsp_ccboard";
      this.pstmt = this.con.prepareStatement(this.sql);
      this.rs = this.pstmt.executeQuery();

      if (this.rs.next())
        count = this.rs.getInt(1);
    }
    catch (Exception e) {
      System.out.println("getBoardCount 메서드 내부에서 에러 : " + e);
    } finally {
      resourceClose();
    }

    return count;
  }

  public void insertBoard(CCBoardBean boardBean) {
    try {
      int num = 0;
      this.con = getConnection();
      this.sql = "select max(num) from jsp_ccboard";
      this.pstmt = this.con.prepareStatement(this.sql);
      this.rs = this.pstmt.executeQuery();
      if (this.rs.next())
        num = this.rs.getInt(1) + 1;
      else {
        num = 1;
      }

      this.sql = "insert into jsp_ccboard(num,subject,content,id,pw,readcount,re_ref,re_lev,re_seq,secret,main_id)values(?,?,?,?,?,?,?,?,?,?,?)";

      this.pstmt = this.con.prepareStatement(this.sql);
      this.pstmt.setInt(1, num);
      this.pstmt.setString(2, boardBean.getSubject());
      this.pstmt.setString(3, boardBean.getContent());
      this.pstmt.setString(4, boardBean.getId());
      this.pstmt.setString(5, boardBean.getPw());
      this.pstmt.setInt(6, 0);
      this.pstmt.setInt(7, num);
      this.pstmt.setInt(8, 0);
      this.pstmt.setInt(9, 0);
      this.pstmt.setInt(10, boardBean.getSecret());
      this.pstmt.setString(11, boardBean.getId());

      this.pstmt.executeUpdate();
    } catch (Exception e) {
      System.out.println("insertBoard 메서드 내부에서 에러 : " + e);
    } finally {
      resourceClose();
    }
  }

  public void replyBoard(CCBoardBean boardBean) {
    try {
      int num = 0;
      this.con = getConnection();
      this.sql = "select max(num) from jsp_ccboard";
      this.pstmt = this.con.prepareStatement(this.sql);
      this.rs = this.pstmt.executeQuery();
      if (this.rs.next())
        num = this.rs.getInt(1) + 1;
      else {
        num = 1;
      }

      int re_seq = 0;
      this.sql = "select max(re_seq) from jsp_ccboard where re_ref = ?";
      this.pstmt = this.con.prepareStatement(this.sql);
      this.pstmt.setInt(1, boardBean.getRe_ref());
      this.rs = this.pstmt.executeQuery();
      if (this.rs.next()) {
        re_seq = this.rs.getInt(1) + 1;
      }

      this.sql = "insert into jsp_ccboard(num,subject,content,id,pw,readcount,re_ref,re_lev,re_seq,secret,main_id)values(?,?,?,?,?,?,?,?,?,?,?)";

      this.pstmt = this.con.prepareStatement(this.sql);
      this.pstmt.setInt(1, num);
      this.pstmt.setString(2, boardBean.getSubject());
      this.pstmt.setString(3, boardBean.getContent());
      this.pstmt.setString(4, boardBean.getId());
      this.pstmt.setString(5, boardBean.getPw());
      this.pstmt.setInt(6, 0);
      this.pstmt.setInt(7, boardBean.getRe_ref());
      this.pstmt.setInt(8, boardBean.getRe_lev());
      this.pstmt.setInt(9, re_seq);
      this.pstmt.setInt(10, boardBean.getSecret());
      this.pstmt.setString(11, boardBean.getMain_id());

      this.pstmt.executeUpdate();
    } catch (Exception e) {
      System.out.println("replyBoard 메서드 내부에서 에러 : " + e);
    } finally {
      resourceClose();
    }
  }

  public List<CCBoardBean> getBoardList(int startRow, int pageSize, String searchId) {
    List boardList = new ArrayList();
    try
    {
      this.con = getConnection();
      if (searchId.equals("*")) {
        this.sql = "select num, subject, id, date, readcount, secret, re_lev from jsp_ccboard order by re_ref desc, re_seq asc limit ?, ?";
        this.pstmt = this.con.prepareStatement(this.sql);
        this.pstmt.setInt(1, startRow);
        this.pstmt.setInt(2, pageSize);
      } else {
        this.sql = "select num, subject, id, date, readcount, secret, re_lev from jsp_ccboard where main_id = ? order by re_ref desc, re_seq asc limit ?, ?";
        this.pstmt = this.con.prepareStatement(this.sql);
        this.pstmt.setString(1, searchId);
        this.pstmt.setInt(2, startRow);
        this.pstmt.setInt(3, pageSize);
      }
      this.rs = this.pstmt.executeQuery();

      while (this.rs.next()) {
        CCBoardBean boardBean = new CCBoardBean();
        boardBean.setNum(this.rs.getInt(1));
        boardBean.setSubject(this.rs.getString(2));
        boardBean.setId(this.rs.getString(3));
        boardBean.setDate(this.rs.getTimestamp(4));
        boardBean.setReadcount(this.rs.getInt(5));
        boardBean.setSecret(this.rs.getInt(6));
        boardBean.setRe_lev(this.rs.getInt(7));

        boardList.add(boardBean);
      }
    }
    catch (Exception e) {
      System.out.println("getBoardList 메서드 내부에서 에러 : " + e);
    } finally {
      resourceClose();
    }

    return boardList;
  }

  public CCBoardBean getBoard(int num) {
    CCBoardBean boardBean = new CCBoardBean();
    try
    {
      this.con = getConnection();
      this.sql = "select * from jsp_ccboard where num = ?";
      this.pstmt = this.con.prepareStatement(this.sql);
      this.pstmt.setInt(1, num);
      this.rs = this.pstmt.executeQuery();

      if (this.rs.next()) {
        boardBean.setNum(this.rs.getInt(1));
        boardBean.setSubject(this.rs.getString(2));
        boardBean.setContent(this.rs.getString(3));
        boardBean.setId(this.rs.getString(4));
        boardBean.setPw(this.rs.getString(5));
        boardBean.setReadcount(this.rs.getInt(6));
        boardBean.setDate(this.rs.getTimestamp(7));
        boardBean.setRe_ref(this.rs.getInt(8));
        boardBean.setRe_lev(this.rs.getInt(9));
        boardBean.setRe_seq(this.rs.getInt(10));
        boardBean.setSecret(this.rs.getInt(11));
        boardBean.setMain_id(this.rs.getString(12));
      }
    }
    catch (Exception e) {
      System.out.println("getBoard 메서드 내부에서 에러 : " + e);
    } finally {
      resourceClose();
    }

    return boardBean;
  }

  public void updateReadCount(int num) {
    try {
      this.con = getConnection();
      this.sql = "update jsp_ccboard set readcount = readcount + 1 where num = ?";
      this.pstmt = this.con.prepareStatement(this.sql);
      this.pstmt.setInt(1, num);
      this.pstmt.executeUpdate();
    } catch (Exception e) {
      System.out.println("updateReadCount 메서드 내부에서 에러 : " + e);
    } finally {
      resourceClose();
    }
  }

  public void deleteBoard(int num) {
    try {
      this.con = getConnection();
      this.sql = "delete from jsp_ccboard where re_ref = ?";
      this.pstmt = this.con.prepareStatement(this.sql);
      this.pstmt.setInt(1, num);
      this.pstmt.executeUpdate();
    } catch (Exception e) {
      System.out.println("deleteBoard 메서드 내부에서 에러 : " + e);
    } finally {
      resourceClose();
    }
  }

  public void updateBoard(CCBoardBean boardBean) {
    try {
      this.con = getConnection();
      this.sql = "update jsp_ccboard set subject = ?, content = ?, secret = ? where num = ?";
      this.pstmt = this.con.prepareStatement(this.sql);
      this.pstmt.setString(1, boardBean.getSubject());
      this.pstmt.setString(2, boardBean.getContent());
      this.pstmt.setInt(3, boardBean.getSecret());
      this.pstmt.setInt(4, boardBean.getNum());

      this.pstmt.executeUpdate();
    } catch (Exception e) {
      System.out.println("updateBoard 메서드 내부에서 에러 : " + e);
    } finally {
      resourceClose();
    }
  }
}