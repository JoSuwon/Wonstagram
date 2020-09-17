package comment;

import java.sql.Timestamp;

public class CommentBean
{
  private int feedNum;
  private int num;
  private String id;
  private String content;
  private Timestamp date;

  public int getFeedNum()
  {
    return this.feedNum;
  }
  public void setFeedNum(int feedNum) {
    this.feedNum = feedNum;
  }
  public int getNum() {
    return this.num;
  }
  public void setNum(int num) {
    this.num = num;
  }
  public String getId() {
    return this.id;
  }
  public void setId(String id) {
    this.id = id;
  }
  public String getContent() {
    return this.content;
  }
  public void setContent(String content) {
    this.content = content;
  }
  public Timestamp getDate() {
    return this.date;
  }
  public void setDate(Timestamp date) {
    this.date = date;
  }
}