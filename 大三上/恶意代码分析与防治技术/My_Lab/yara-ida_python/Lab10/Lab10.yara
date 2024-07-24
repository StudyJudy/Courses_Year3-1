rule RukeforLab10_01exe {
   meta:
      description = "Lab10-01.exe"
   strings:
      $s1 = "C:\\Windows\\System32\\Lab10-01.sys" fullword ascii
      $s2 = "Hello World!" fullword wide
      $s3 = "RegWriterApp Version 1.0" fullword wide
      $s4 = "REGWRITERAPP" fullword wide
      $s5 = "RegWriterApp" fullword wide
      $s6 = "System" fullword wide
      $s7 = "Copyright (C) 2011" fullword wide 
   condition:
      uint16(0) == 0x5a4d and 
      uint32(uint32(0x3c))==0x00004550 and filesize < 80KB and
      all of them
}

rule RukeforLab10_01sys {
   meta:
      description = "Lab10-01.sys"
   strings:
      $s1 = "c:\\winddk\\7600.16385.1\\src\\general\\regwriter\\wdm\\sys\\objfre_wxp_x86\\i386\\sioctl.pdb" fullword ascii
      $s2 = "Lab10-01.sys" fullword wide
      $s3 = "Important System Driver" fullword wide
      $s4 = "\\Registry\\Machine\\SOFTWARE\\Policies\\Microsoft\\WindowsFirewall" fullword wide
      $s5 = "\\Registry\\Machine\\SOFTWARE\\Policies\\Microsoft" fullword wide
      $s6 = "6.1.7600.16385 built by: WinDDK" fullword wide 
      $s7 = " ABC Corp." fullword wide
   condition:
      uint16(0) == 0x5a4d and 
      uint32(uint32(0x3c))==0x00004550 and filesize < 10KB and
      all of them
}
rule RukeforLab10_02 {
   meta:
      description = "Lab10-02.exe"
   strings:
      $s1 = "C:\\Windows\\System32\\Mlwx486.sys" fullword ascii
      $s2 = "c:\\winddk\\7600.16385.1\\src\\general\\rootkit\\wdm\\sys\\objfre_wxp_x86\\i386\\sioctl.pdb" fullword ascii
      $s3 = "SIOCTL.sys" fullword wide
      $s4 = "Failed to open service manager." fullword ascii
      $s5 = "Failed to start service." fullword ascii
      $s6 = "Sample IOCTL Driver" fullword wide
      $s7 = "\"WWShtT@" fullword ascii
      $s8 = "VWuBhhT@" fullword ascii
      $s9 = "486 WS Driver" fullword ascii
      $s10 = "6.1.7600.16385 built by: WinDDK" fullword wide 
      $s11 = "KeServiceDescriptorTable" fullword wide 
      $s16 = "Failed to create service." fullword ascii
   condition:
      uint16(0) == 0x5a4d and 
      uint32(uint32(0x3c))==0x00004550 and filesize < 100KB and
      6 of them
}
rule RukeforLab10_03exe {
   meta:
      description = "Lab10-03.exe"
   strings:
      $s1 = "C:\\Windows\\System32\\Lab10-03.sys" fullword ascii
      $s2 = "http://www.malwareanalysisbook.com/ad.html" fullword wide
      $s3 = "Process Helper" fullword ascii
      $s4 = "\\\\.\\ProcHelper" fullword ascii
   condition:
      uint16(0) == 0x5a4d and 
      uint32(uint32(0x3c))==0x00004550 and filesize < 70KB and
      all of them
}
rule RukeforLab10_03sys {
   meta:
      description = "Lab10-03.sys"
   strings:
      $s1 = "c:\\winddk\\7600.16385.1\\src\\general\\rootkitprochide\\wdm\\sys\\objfre_wxp_x86\\i386\\sioctl.pdb" fullword ascii
      $s2 = "Lab10-03.sys" fullword wide
      $s3 = "Important Process Helper" fullword wide
      $s4 = "\\DosDevices\\ProcHelper" fullword wide
      $s5 = "\\Device\\ProcHelper" fullword wide
      $s6 = "6.1.7600.16385 built by: WinDDK" fullword wide 
      $s7 = " ABC Corp." fullword wide
   condition:
      uint16(0) == 0x5a4d and 
      uint32(uint32(0x3c))==0x00004550 and filesize < 10KB and
      all of them
}