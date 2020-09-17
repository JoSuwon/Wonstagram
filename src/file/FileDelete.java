package file;

import java.io.File;
import java.io.PrintStream;

public class FileDelete extends Thread
{
  File f = null;

  public File getF() { return this.f; } 
  public void setF(File f) { this.f = f; }

  public void run()
  {
    int limit = 20;
    while ((!this.f.delete()) && (limit > 0)) {
      synchronized (this) {
        try {
          wait(250L);
        } catch (InterruptedException e) {
          e.printStackTrace();
        }
      }
      limit--;
    }
    if (!this.f.exists()) System.out.println("ªË¡¶øœ∑·µ "); else
      System.out.println("ªË¡¶ æ»µ ");
  }
}