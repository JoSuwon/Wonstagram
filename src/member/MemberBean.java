package member;

public class MemberBean
{
  private String id;
  private String pw;
  private String name;
  private String gender;
  private String email;

  public MemberBean()
  {
  }

  public MemberBean(String id, String pw, String name, String gender, String email)
  {
    this.id = id;
    this.pw = pw;
    this.name = name;
    this.gender = gender;
    this.email = email;
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
  public String getName() {
    return this.name;
  }
  public void setName(String name) {
    this.name = name;
  }
  public String getGender() {
    return this.gender;
  }
  public void setGender(String gender) {
    this.gender = gender;
  }
  public String getEmail() {
    return this.email;
  }
  public void setEmail(String email) {
    this.email = email;
  }
}