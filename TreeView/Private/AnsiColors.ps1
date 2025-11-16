# ANSI Color Map
$esc = [char]27

$script:AnsiColors = @{
    Default = ""
    Blue    = "$esc[34m"
    Green   = "$esc[32m"
    Yellow  = "$esc[33m"
    Red     = "$esc[31m"
    Cyan    = "$esc[36m"
    White   = "$esc[37m"
    Reset   = "$esc[0m"
}
