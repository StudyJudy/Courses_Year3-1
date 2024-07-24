rule RuleforLab11_01 {
   meta:
      description = "Lab11-01.exe"
   strings:
      $s1 = "gina.dll" fullword ascii
      $s2 = "msgina32.dll" fullword ascii
      $s3 = "MSGina.dll" fullword wide
      $s4 = "msutil32.sys" fullword wide
      $s5 = "\\msgina32.dll" fullword ascii
   condition:
      uint16(0) == 0x5a4d and 
      uint32(uint32(0x3c))==0x00004550 and filesize < 200KB and
      3 of them
}
rule RuleforLab11_02dll {
   meta:
      description = "Lab11-02.dll"
   strings:
      $s1 = "spoolvxx32.dll" fullword ascii
      $s2 = "THEBAT.EXE" fullword ascii
      $s3 = "\\spoolvxx32.dll" fullword ascii
      $s4 = "Lab11-02.dll" fullword ascii
      $s5 = "\\Lab11-02.ini" fullword ascii
      $s6 = "AppInit_DLLs" fullword ascii 
      $s7 = "RCPT TO: <" fullword ascii 
      $s8 = "MSIMN.EXE" fullword ascii 
   condition:
      uint16(0) == 0x5a4d and 
      uint32(uint32(0x3c))==0x00004550 and filesize < 60KB and
      6 of them
}
rule RuleforLab11_02ini {
   meta:
      description = "Lab11-02.ini"
   strings:
      $s1 = "CHMMXaL@MV@SD@O@MXRHRCNNJ" fullword ascii
   condition:
      uint16(0) == 0x5a4d and 
      uint32(uint32(0x3c))==0x00004550 and filesize < 1KB and
      all of them
}
rule RuleforLab11_03dll {
   meta:
      description = "Lab11-03.dll"
   strings:
      $x1 = "C:\\WINDOWS\\System32\\kernel64x.dll" fullword ascii
      $s2 = "Lab1103dll.dll" fullword ascii
      $s3 = "VWuBh@u" fullword ascii
      $s4 = "5@8D8H8L8" fullword ascii 
      $s5 = "2?3E3S3" fullword ascii 
      $s6 = "2T3[3j3" fullword ascii
      $s7 = "20272?2D2H2L2u2" fullword ascii 
      $s8 = "zzz69806582" fullword ascii
   condition:
      uint16(0) == 0x5a4d and 
      uint32(uint32(0x3c))==0x00004550 and filesize < 100KB and
      1 of ($x*) and 4 of them
}
rule RuleforLab11_03exe {
   meta:
      description = "Lab11-03.exe"
   strings:
      $x1 = "C:\\WINDOWS\\System32\\inet_epar32.dll" fullword ascii
      $s2 = "cisvc.exe" fullword ascii
      $s3 = "C:\\WINDOWS\\System32\\%s" fullword ascii
      $s4 = "Lab11-03.dll" fullword ascii
      $s5 = "net start cisvc" fullword ascii
      $s6 = "COMSPEC" fullword ascii 
      $s7 = "^}%95D" fullword ascii 
      $s8 = "zzz69806582" fullword ascii
   condition:
      uint16(0) == 0x5a4d and 
      uint32(uint32(0x3c))==0x00004550 and filesize < 100KB and
      1 of ($x*) and all of them
}