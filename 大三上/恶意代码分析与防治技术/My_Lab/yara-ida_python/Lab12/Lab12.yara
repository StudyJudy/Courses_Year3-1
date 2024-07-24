rule RuleforLab12_01exe {
   meta:
      description = " Lab12-01.exe"
   strings:
      $s1 = "Lab12-01.dll" fullword ascii
      $s2 = "\"WWSh T@" fullword ascii
      $s3 = "YYh `@" fullword ascii 
      $s4 = "[Sh$T@" fullword ascii
      $s5 = "RichLu" fullword ascii
   condition:
      uint16(0) == 0x5a4d and 
      uint32(uint32(0x3c))==0x00004550 and filesize < 100KB and
      all of them
}
rule RuleforLab12_01dll {
   meta:
      description = "Lab12-01.dll"
   strings:
      $s1 = ":5:[:u:|:" fullword ascii 
      $s2 = "Press OK to reboot" fullword ascii
      $s3 = ">.>4><>Z>`>q>" fullword ascii
      $s4 = "9C9M9U9[9c9l9u9" fullword ascii
      $s5 = "0<0Q0u0" fullword ascii
      $s6 = "4b4h4v4" fullword ascii
      $s7 = "1$1,14181@1" fullword ascii
      $s8 = "0K0d0n0y0" fullword ascii
   condition:
      uint16(0) == 0x5a4d and 
      uint32(uint32(0x3c))==0x00004550 and filesize < 100KB and
      5 of them
}
rule RuleforLab12_02 {
   meta:
      description = "Lab12-02.exe"
   strings:
      $s1 = "\\svchost.exe" fullword ascii
$s2 = "wqstLKla143$a7(354 -a'4/\"5(./a\" --LKAAA" fullword ascii
condition:
uint16(0) == 0x5a4d and 
uint32(uint32(0x3c))==0x00004550 and filesize < 200KB and
8 of them
}
rule RuleforLab12_03{
   meta:
      description = "Lab12-03.exe"
   strings:
      $s1 = "practicalmalwareanalysis.log" fullword ascii
      $s2 = "[Window: " fullword ascii
      $s3 = "[BACKSPACE]" fullword ascii
      $s4 = "BACKSPACE" fullword ascii 
      $s5 = "YYh P@" fullword ascii 
      $s6 = "[ENTER]" fullword ascii
      $s7 = "[CTRL]" fullword ascii
      $s8 = "0B=8S@" fullword ascii
      $s9 = "[SHIFT]" fullword ascii
      $s10 = "[CAPS LOCK]" fullword ascii
   condition:
      uint16(0) == 0x5a4d and 
uint32(uint32(0x3c))==0x00004550 and filesize < 70KB and
      all of them
}
rule RuleforLab12_04 {
   meta:
      description = "Lab12-04.exe"
   strings:
      $s1 = "\\system32\\wupdmgrd.exe" fullword ascii
      $s2 = "\\system32\\wupdmgr.exe" fullword ascii
      $s3 = "http://www.practicalmalwareanalysis.com/updater.exe" fullword ascii
      $s4 = "\\winup.exe" fullword ascii
      $s5 = "SeDebugPrivilege" fullword ascii 
      $s6 = "<not real>" fullword ascii
   condition:
      uint16(0) == 0x5a4d and 
uint32(uint32(0x3c))==0x00004550 and filesize < 100KB and
      all of them
}