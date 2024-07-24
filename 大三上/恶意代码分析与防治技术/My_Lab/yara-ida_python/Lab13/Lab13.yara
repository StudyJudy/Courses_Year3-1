rule RuleforLab13_01exe 
{
   meta:
      description = "Lab13-01.exe"
   strings:   
      $s1 = "Mozilla/4.0" fullword ascii
      $s2 = "http://%s/%s/"fullword ascii

   condition:
      uint16(0) == 0x5a4d and 
      uint32(uint32(0x3c))==0x00004550 and filesize < 100KB and
      all of them
}

rule RuleforLab13_02exe 
{
   meta:
      description = "Lab13-02.exe"
   strings:   
      $s1 = "temp" fullword ascii
      $s2 = "GDI32.dll" fullword ascii
      $s3 = "GetLastActivePopup" fullword ascii
      $s4 = "GetActiveWindow" fullword ascii
   condition:
      uint16(0) == 0x5a4d and 
      uint32(uint32(0x3c))==0x00004550 and filesize < 100KB and
      all of them
}

rule RuleforLab13_03exe 
{
   meta:
      description = "Lab13-03.exe"
   strings:   
      $s1 = "cmd.exe" fullword ascii
      $s2 = "Empty key" fullword ascii
      $s3 = "Incorrect key length" fullword ascii
      $s4 = "Incorrect block length" fullword ascii
   condition:
      uint16(0) == 0x5a4d and 
      uint32(uint32(0x3c))==0x00004550 and filesize < 100KB and
      all of them
}