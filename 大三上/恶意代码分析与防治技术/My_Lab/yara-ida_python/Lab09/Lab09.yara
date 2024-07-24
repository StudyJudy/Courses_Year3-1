rule RuleforLab090101
{
   meta:
      description = " Lab09_01.exe"
   strings:
      $s1="http://www.practicalmalwareanalysis.com" fullword ascii
      $s2="SOFTWARE\\Microsoft \\XPS" fullword ascii
      $s3="Configuration" fullword ascii
      $s4="SLEEP" fullword ascii 
      $s5="UPLOAD" fullword ascii
      $s6="DOWNLOAD" fullword ascii
      $s7="CMD" fullword ascii
      $s8="NOTHING" fullword ascii
      $s9="JanFebMarAprMayJunJulAugSepOctNovDec" fullword ascii
      $s10="SunMonTueWedThuFriSat" fullword ascii
      $s11="HTTP/1.0" fullword ascii
      $s12="%SYSTEMROOT%\\system32\\" fullword ascii
      $s13="runtime error" fullword ascii
      $s14="TLOSS error" fullword ascii
      $s15="SING error" fullword ascii
      $s17="command.com" fullword ascii
      $s18="COMSPEC" fullword ascii
      $s19=" (8PX" fullword ascii
      $s20="700WP" fullword ascii
      $s21="ppxxxx"fullword ascii
      $s22="(null)" fullword ascii
      $s23=".com" fullword ascii
      $s24=".bat" fullword ascii
      $s25="-in" fullword ascii
      $s26="-re" fullword ascii
   condition:
      uint16(0) == 0x5a4d and 
      uint32(uint32(0x3c))==0x00004550 and filesize < 70KB and
      all of them
}

rule RuleforLab090102
{
   meta:
      description = " DLL1.dll"
   strings:
      $s1="JanFebMarAprMayJunJulAugSepOctNovDec" fullword ascii
      $s2="SunMonTueWedThuFriSat" fullword ascii
      $s3="DLL 1 mystery data"fullword ascii
   condition:
      uint16(0) == 0x5a4d and 
      uint32(uint32(0x3c))==0x00004550 and filesize < 60KB and
      all of them
}

rule RuleforLab090201
{
   meta:
      description = " Lab09_02.exe"
   strings:
      $s1="runtime error "fullword ascii
      $s2="TLOSS error" fullword ascii
      $s3="SING error" fullword ascii
      $s4="DOMAIN error"fullword ascii
      $s6="GetLastActivePopup" fullword ascii
      $s7="GetActiveWindow" fullword ascii
      $s8="cmd" fullword ascii
      $s9="- floating point not loaded" fullword ascii
      $s10="- not enough space for stdio initialization" fullword ascii
      $s11="- not enough space for _onexit/atexit table"fullword ascii
      $s12="abnormal program termination" fullword ascii
      $s13="R6028" fullword ascii
      $s14="Runtime Error!" fullword ascii
      $s15="Program: "fullword ascii
      $s16="- unexpected multithread lock error" fullword ascii
      $s17="- pure virtual function call" fullword ascii
      $s18="- unable to open console device" fullword ascii
   condition:
      uint16(0) == 0x5a4d and 
      uint32(uint32(0x3c))==0x00004550 and filesize < 70KB and
      all of them
}

rule RuleforLab090202
{
   meta:
      description = " DLL2.dll"
   strings:
      $s1="JanFebMarAprMayJunJulAugSepOctNovDec" fullword ascii
      $s2="SunMonTueWedThuFriSat" fullword ascii
      $s3="DLL2Print" fullword ascii
      $s4="DLL2ReturnJ" fullword ascii
      $s5="temp.txt" fullword ascii
      $s6="DLL 2 mystery data" fullword ascii
   condition:
      uint16(0) == 0x5a4d and 
      uint32(uint32(0x3c))==0x00004550 and filesize < 60KB and
      all of them
}

rule RuleforLab090301
{
   meta:
      description = " Lab09_03.exe"
   strings:
      $s1="DLL3GetStructure" fullword ascii
      $s2="DLL3Print" fullword ascii
      $s3="malwareanalysisbook.com" fullword ascii
      $s4="DLL3.dll" fullword ascii
      $s5="DLL1.dll" fullword ascii
      $s6="DLL2.dll" fullword ascii
   condition:
      uint16(0) == 0x5a4d and 
      uint32(uint32(0x3c))==0x00004550 and filesize < 70KB and
      all of them
}

rule RuleforLab090302
{
   meta:
      description = " DLL3.dll"
   strings:
      $s1="JanFebMarAprMayJunJulAugSepOctNovDec" fullword ascii
      $s2="SunMonTueWedThuFriSat" fullword ascii
      $s3="DLL3Print" fullword ascii
      $s4="DLL3GetStructure" fullword ascii
      $s5="DLL3.dll" fullword ascii
      $s6="DLL 3 mystery data" fullword ascii
   condition:
      uint16(0) == 0x5a4d and 
      uint32(uint32(0x3c))==0x00004550 and filesize < 70KB and
      all of them
}