package mail;

import java.io.PrintStream;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Message.RecipientType;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class MailSend
{
  public void MailSend(String email, String pw)
  {
    Properties prop = System.getProperties();
    prop.put("mail.smtp.starttls.enable", "true");
    prop.put("mail.smtp.host", "smtp.gmail.com");
    prop.put("mail.smtp.auth", "true");
    prop.put("mail.smtp.port", "587");

    Authenticator auth = new MailAuth();

    Session session = Session.getDefaultInstance(prop, auth);

    MimeMessage msg = new MimeMessage(session);
    try
    {
      msg.setSentDate(new Date());

      msg.setFrom(new InternetAddress("wonstagramm@gmail.com", "Wonstagram!"));
      InternetAddress to = new InternetAddress(email);
      msg.setRecipient(Message.RecipientType.TO, to);
      msg.setSubject("��й�ȣ ã�� ��� �����Դϴ�!");
      msg.setText("��й�ȣ ã�� ��� �̸��� �Դϴ�.\n���� ��й�ȣ�� '" + pw + "' �Դϴ�.");

      Transport.send(msg);
    }
    catch (AddressException ae) {
      System.out.println("AddressException : " + ae.getMessage());
    } catch (MessagingException me) {
      System.out.println("MessagingException : " + me.getMessage());
    } catch (UnsupportedEncodingException e) {
      System.out.println("UnsupportedEncodingException : " + e.getMessage());
    }
  }
}