function Test-TerminalUnicodeSupport {
    return (
        $Host.UI.SupportsVirtualTerminal -and
        [Console]::OutputEncoding.CodePage -eq 65001
    )
}

# function Supports-Unicode {
#     # 判断是否 UTF-8
#     $isUtf8 = $Host.UI.RawUI.OutputEncoding.WebName -eq "utf-8"

#     # 判断是否支持 ANSI
#     # Windows Terminal / VSCode Terminal / ConHost 最新版 都支持 VT
#     $ansiOk = $env:WT_SESSION -or $env:TERM_PROGRAM -or ([Console]::IsOutputRedirected -eq $false)

#     return ($isUtf8 -and $ansiOk)
# }
