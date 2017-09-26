package net.pezzato.sdcardcid;

import java.io.BufferedReader;
import java.io.FileReader;

public class SdcardCid extends org.qtproject.qt5.android.bindings.QtActivity {
  private static SdcardCid m_instance;

  public SdcardCid() {
    m_instance = this;
  }

  public static String getCIDString(String id) {
    String result = "";
    try {
      BufferedReader input = new BufferedReader(new FileReader("/sys/block/mmcblk" + id + "/device/cid"));
      result =  input.readLine();
    } catch (Exception e) {
    }
    return result;
  }
}
