$text = Get-Content $args[0]
foreach ($line in $text) {
  code --install-extension $line
}
