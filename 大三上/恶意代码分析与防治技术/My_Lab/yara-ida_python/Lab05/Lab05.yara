rule Detect_Lab05 
{
    meta:
        description = "YARA rule to detect Lab05 malicious code"
    strings:
      
      $x1 = "Get DLL FileName Error,Update Failed" fullword ascii
      $x2 = "Move '%s' To '%s' Failed,Perhaps Other Process Updateing|Updated Same Module"
      $x3 = "Process '%s' Not Found,Uninject Failed" fullword ascii
      $x4 = "Uninject '%s' From Process '%s' " fullword ascii
      $x5 = "error on get process info. " fullword ascii
      $x6 = "Process '%s' Not Found ,Inject Failed" fullword ascii
      $x7 = "Inject '%s' To Process '%s' Failed" fullword ascii
      $x8 = "Old Module Have Been Free,New ModuleName As Old,Will Take Effect Soon." fullword ascii
      $x9 = "You Specify Service Name Not In Svchost\\netsvcs, must be one of following:" fullword ascii
      $x10 = "Uninject '%s' From Process '%s' Failed, Module '%s' Not Found" fullword ascii
      $x11 = "MayBe Inject Mode,You Only Need Close Master Process '%s' To Uninatll This Mode" fullword ascii
      $x12 = "Resume '%s' To '%s' Failed,Update Failed" fullword ascii
      $x13 = "Move '%s' To '%s' Failed,Update Failed" fullword ascii
      $x14 = "Replace Old Service '%s' Failed,Install Cancle" fullword ascii
      $x15 = "Old Module Have Been Free,New ModuleName As Old,Will Take Effect Soon." fullword ascii
      $x16 = "Repair Successfully,Need Reboot Machine!" fullword ascii

      
   condition:
      uint16(0) == 0x5a4d and 
      uint32(uint32(0x3c))==0x00004550 and
      1 of ($x*) and 12 of them
}

