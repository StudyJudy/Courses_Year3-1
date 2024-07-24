rule RuleforLab07_01 
{
   meta:
      description = " Lab07_01.exe"
   strings:
      $s1 = "http://www.malwareanalysisbook.com" fullword ascii
      $s2 = "MalService" fullword ascii
      $s3 = "Internet Explorer 8.0" fullword ascii 
      $s4 = "HGL345" fullword ascii
   condition:
      uint16(0) == 0x5a4d and 
      uint32(uint32(0x3c))==0x00004550 and filesize < 70KB and
      all of them
}

rule RuleforLab07_02
{
   meta:
      description = "Lab07-02.exe"
   strings:
      $s1 = "http://www.malwareanalysisbook.com/ad.html" fullword wide
   condition:
      uint16(0) == 0x5a4d and 
      uint32(uint32(0x3c))==0x00004550 and filesize < 50KB and
      1 of them
}
rule RuleforLab07_03dll
{
   meta:
      description = "Lab07-03.dll"
   strings:
      $s1 = "SADFHUHF" fullword ascii
      $s2 = "127.26.152.13" fullword ascii
      $s3 = "141G1[1l1" fullword ascii
      $s4 = "1Y2a2g2r2" fullword ascii
   condition:
      uint16(0) == 0x5a4d and 
      uint32(uint32(0x3c))==0x00004550 and filesize < 500KB and
      all of them
rule RuleforLab07_03exe
{
   meta:
      description = "Lab07-03.exe"
   strings:
      $x1 = "C:\\windows\\system32\\kerne132.dll" fullword ascii
      $x2 = "C:\\Windows\\System32\\Kernel32.dll" fullword ascii
      $s3 = "kerne132.dll" fullword ascii
      $s4 = "Lab07-03.dll" fullword ascii
      $s5 = "WARNING_THIS_WILL_DESTROY_YOUR_MACHINE" fullword ascii
   condition:
      uint16(0) == 0x5a4d and 
      uint32(uint32(0x3c))==0x00004550 and filesize < 50KB and
      1 of ($x*) and all of them
}