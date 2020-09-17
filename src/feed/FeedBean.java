package feed;

import java.sql.Timestamp;

public class FeedBean
{
  private int num;
  private String id;
  private String address;
  private String imgLocation;
  private String content;
  private Timestamp date;

  public int getNum()
  {
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
  public String getAddress() {
    return this.address;
  }
  public void setAddress(String address) {
    this.address = address;
  }
  public String getImgLocation() {
    return this.imgLocation;
  }
  public void setImgLocation(String imgLocation) {
    this.imgLocation = imgLocation;
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