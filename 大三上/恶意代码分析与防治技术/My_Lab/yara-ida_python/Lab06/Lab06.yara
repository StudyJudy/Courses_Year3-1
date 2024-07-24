
rule RuleforLab06_01{
   meta:
      description = "Lab06-01.exe"
   strings:
      $s1 = "Success: Internet Connection" fullword ascii
      $s2 = "Error 1.1: No Internet" fullword ascii
      $s3 = "InternetGetConnectedState" fullword ascii
   condition:
      uint16(0) == 0x5a4d and 
      uint32(uint32(0x3c))==0x00004550 and filesize < 100KB and
      all of them
}