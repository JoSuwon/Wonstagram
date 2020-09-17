package mail;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class MailAuth extends Authenticator
{
  PasswordAuthentication pa;

  public MailAuth()
  {
    String mail_id = "wonstagramm@gmail.com";
    String mail_pw = "fkfkwpql1";

    this.pa = new PasswordAuthentication(mail_id, mail_pw);
  }

  public PasswordAuthentication getPasswordAuthentication() {
    return this.pa;
  }
}