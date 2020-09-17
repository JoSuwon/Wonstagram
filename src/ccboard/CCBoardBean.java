package ccboard;

import java.sql.Timestamp;

public class CCBoardBean
{
  private int num;
  private String subject;
  private String content;
  private String id;
  private String pw;
  private int readcount;
  private Timestamp date;
  private int re_ref;
  private int re_lev;
  private int re_seq;
  private int secret;
  private String main_id;

  public CCBoardBean()
  {
  }

  public CCBoardBean(int num, String subject, String content, String id, String pw, int readcount, Timestamp date, int re_ref, int re_lev, int re_seq, int secret, String main_id)
  {
    this.num = num;
    this.subject = subject;
    this.content = content;
    this.id = id;
    this.pw = pw;
    this.readcount = readcount;
    this.date = date;
    this.re_ref = re_ref;
    this.re_lev = re_lev;
    this.re_seq = re_seq;
    this.secret = secret;
    this.main_id = id;
  }

  public String getMain_id()
  {
    return this.main_id;
  }
  public void setMain_id(String main_id) {
    this.main_id = main_id;
  }
  public int getNum() {
    return this.num;
  }
  public void setNum(int num) {
    this.num = num;
  }
  public String getSubject() {
    return this.subject;
  }
  public void setSubject(String subject) {
    this.subject = subject;
  }
  public String getContent() {
    return this.content;
  }
  public void setContent(String content) {
    this.content = content;
  }
  public String getId() {
    return this.id;
  }
  public void setId(String id) {
    this.id = id;
  }
  public String getPw() {
    return this.pw;
  }
  public void setPw(String pw) {
    this.pw = pw;
  }
  public int getReadcount() {
    return this.readcount;
  }
  public void setReadcount(int readcount) {
    this.readcount = readcount;
  }
  public Timestamp getDate() {
    return this.date;
  }
  public void setDate(Timestamp date) {
    this.date = date;
  }
  public int getRe_ref() {
    return this.re_ref;
  }
  public void setRe_ref(int re_ref) {
    this.re_ref = re_ref;
  }
  public int getRe_lev() {
    return this.re_lev;
  }
  public void setRe_lev(int re_lev) {
    this.re_lev = re_lev;
  }
  public int getRe_seq() {
    return this.re_seq;
  }
  public void setRe_seq(int re_seq) {
    this.re_seq = re_seq;
  }
  public int getSecret() {
    return this.secret;
  }
  public void setSecret(int secret) {
    this.secret = secret;
  }
}