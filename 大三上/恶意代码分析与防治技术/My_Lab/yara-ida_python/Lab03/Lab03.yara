rule Detect_Lab03 {
    meta:
        description = "YARA rule to detect Lab03 malicious code"
    strings:
        $url = "www.practicalmalwareanalysis.com"
        $registry_key = "HKEY_MACHINE\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Run\\VideoDriver"
        $mutex = "WinVMX32"
        $file_creation = "C:\\WINDOWS\\system32\\vmx32to64.exe"
        $export_function = "installA"
        $svchost_exe = "svchost.exe"
        $practicalmalwareanalysis_log = "practicalmalwareanalysis.log"
        $keyboard_strings = /\\[CTRL]|\\[ENTER\\]|\\[BACKSPACE\\]|\\[TAB\\]|\\[DEL\\]|\\[CAPS LOCK]/
        $cmd = "cmd.exe"
        $del = "/c del"
        $http_string = "HTTP/1.0"
        $command_strings = /DOWNLOAD|UPLOAD/
        $regedit = "SOFTWARE\\Microsoft \\XPS"
    condition:
        any of ($url, $registry_key, $mutex, $file_creation,$export_function,$svchost_exe,$practicalmalwareanalysis_log,$keyboard_strings,$cmd,$del,$http_string,$command_strings,$regedit)
}

