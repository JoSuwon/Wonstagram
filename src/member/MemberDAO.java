package member;

import java.io.PrintStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDAO
{
  Connection con = null;
  ResultSet rs = null;
  PreparedStatement pstmt = null;
  String sql = "";

  private void resourceClose() {
    try {
      if (this.pstmt != null) this.pstmt.close();
      if (this.rs != null) this.rs.close();
      if (this.con != null) this.con.close(); 
    }
    catch (Exception e) { System.out.println("MemberDAO 자원해제 실패 : " + e); }
  }

  private Connection getConnection() throws Exception
  {
    Connection con = null;
    Context init = new InitialContext();
    DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/jspbeginner");
    con = ds.getConnection();

    return con;
  }

  public void insertMember(MemberBean memberBean) {
    try {
      this.con = getConnection();
      this.sql = "insert into jsp_member(id,pw,name,gender,email) values(?,?,?,?,?)";
      this.pstmt = this.con.prepareStatement(this.sql);
      this.pstmt.setString(1, memberBean.getId());
      this.pstmt.setString(2, memberBean.getPw());
      this.pstmt.setString(3, memberBean.getName());
      this.pstmt.setString(4, memberBean.getGender());
      this.pstmt.setString(5, memberBean.getEmail());

      this.pstmt.executeUpdate();
    } catch (Exception e) {
      System.out.println("insertMember 메서드 내부 에러 : " + e);
    } finally {
      resourceClose();
    }
  }

  public boolean idCheck(String id) {
    boolean result = false;
    try {
      this.con = getConnection();
      this.sql = "select * from jsp_member where id = ?";
      this.pstmt = this.con.prepareStatement(this.sql);
      this.pstmt.setString(1, id);

      this.rs = this.pstmt.executeQuery();
      if (this.rs.next())
        result = true;
    }
    catch (Exception e) {
      System.out.println("idCheck 메서드 내부 에러 : " + e);
    } finally {
      resourceClose();
    }

    return result;
  }

  public boolean pwCheck(String id, String pw) {
    boolean result = false;
    try {
      this.con = getConnection();
      this.sql = "select * from jsp_member where id = ? and pw = ?";
      this.pstmt = this.con.prepareStatement(this.sql);
      this.pstmt.setString(1, id);
      this.pstmt.setString(2, pw);
      this.rs = this.pstmt.executeQuery();

      if (this.rs.next()) {
        result = true;
        return result;
      }
    } catch (Exception e) {
      System.out.println("pwCheck 메서드 내부에서 에러 : " + e);
    } finally {
      resourceClose(); } resourceClose();

    return result;
  }

  public int loginCheck(String id, String pw) {
    int result = 0;
    try
    {
      this.con = getConnection();
      this.sql = "select * from jsp_member where id = ? and pw = ?";
      this.pstmt = this.con.prepareStatement(this.sql);
      this.pstmt.setString(1, id);
      this.pstmt.setString(2, pw);
      this.rs = this.pstmt.executeQuery();
      int i;
      if (this.rs.next()) {
        result = 1;
        return result;
      }

      this.sql = "select * from jsp_member where id = ?";
      this.pstmt = this.con.prepareStatement(this.sql);
      this.pstmt.setString(1, id);
      this.rs = this.pstmt.executeQuery();
      if (this.rs.next()) {
        result = 2;
        return result;
      }
    } catch (Exception e) {
      System.out.println("loginCheck 메서드 내부 에러 : " + e);
    } finally {
      resourceClose(); } resourceClose();

    return 0;
  }

  public MemberBean selectMember(String id) {
    MemberBean memberBean = new MemberBean();
    try {
      this.con = getConnection();
      this.sql = "select * from jsp_member where id = ?";
      this.pstmt = this.con.prepareStatement(this.sql);
      this.pstmt.setString(1, id);
      this.rs = this.pstmt.executeQuery();
      if (this.rs.next()) {
        String _id = this.rs.getString("id");
        String _pw = this.rs.getString("pw");
        String _name = this.rs.getString("name");
        String _gender = this.rs.getString("gender");
        String _email = this.rs.getString("email");
        memberBean.setId(_id);
        memberBean.setPw(_pw);
        memberBean.setName(_name);
        memberBean.setGender(_gender);
        memberBean.setEmail(_email);
      }
    } catch (Exception e) {
      System.out.println("selectMember 메서드 내부 에러 : " + e);
    } finally {
      resourceClose();
    }
    return memberBean;
  }

  public void modifyMember(MemberBean memberBean) {
    String id = memberBean.getId();
    String pw = memberBean.getPw();
    String name = memberBean.getName();
    String gender = memberBean.getGender();
    String email = memberBean.getEmail();
    try {
      this.con = getConnection();
      this.sql = "update jsp_member set pw = ?, gender = ?, email = ? where id = ?";
      this.pstmt = this.con.prepareStatement(this.sql);
      this.pstmt.setString(1, pw);
      this.pstmt.setString(2, gender);
      this.pstmt.setString(3, email);
      this.pstmt.setString(4, id);
      this.pstmt.executeUpdate();
    } catch (Exception e) {
      System.out.println("modifyMember 메서드 내부에서 에러 : " + e);
    } finally {
      resourceClose();
    }
  }

  public ArrayList<MemberBean> findId(String name) {
    ArrayList arr = new ArrayList();
    try
    {
      this.con = getConnection();
      this.sql = "select id from jsp_member where name = ?";
      this.pstmt = this.con.prepareStatement(this.sql);
      this.pstmt.setString(1, name);
      this.rs = this.pstmt.executeQuery();

      while (this.rs.next()) {
        MemberBean memberBean = new MemberBean();
        memberBean.setId(this.rs.getString(1));

        arr.add(memberBean);
      }
    } catch (Exception e) {
      System.out.println("findId 메서드 내부에서 에러 : " + e);
    } finally {
      resourceClose();
    }

    return arr;
  }

  public String findPw(String id, String email) {
    String pw = "";
    try
    {
      this.con = getConnection();
      this.sql = "select pw from jsp_member where id = ? and email = ?";
      this.pstmt = this.con.prepareStatement(this.sql);
      this.pstmt.setString(1, id);
      this.pstmt.setString(2, email);
      this.rs = this.pstmt.executeQuery();

      if (this.rs.next())
        pw = this.rs.getString(1);
    }
    catch (Exception e) {
      System.out.println("findPw 메서드 내부에서 에러 : " + e);
    } finally {
      resourceClose();
    }

    return pw;
  }
}