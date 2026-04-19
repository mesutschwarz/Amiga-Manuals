$ErrorActionPreference = 'Stop'

$src = "c:\Users\Monster\Desktop\WShell-html\html-doc\ARexx.html"
$outDir = "c:\Users\Monster\Desktop\WShell-html\html-doc\markdown"

if (-not (Test-Path $outDir)) {
  New-Item -ItemType Directory -Path $outDir | Out-Null
}

$raw = Get-Content -Raw $src
$styleBlock = [regex]::Match($raw, '(?is)<style[^>]*>(.*?)</style>').Groups[1].Value
$body = [regex]::Match($raw, '(?is)<body[^>]*>(.*)</body>').Groups[1].Value

$classStyles = @{}
if ($styleBlock -ne '') {
  foreach ($m in [regex]::Matches($styleBlock, '(?is)\.(s\d+)\s*\{([^}]*)\}')) {
    $className = $m.Groups[1].Value
    $ruleText = $m.Groups[2].Value
    $isBold = $ruleText -match 'font-weight\s*:\s*bold'
    $isItalic = $ruleText -match 'font-style\s*:\s*italic'
    if ($isBold -or $isItalic) {
      $classStyles[$className] = [pscustomobject]@{ Bold = $isBold; Italic = $isItalic }
    }
  }
}

function Apply-ClassStyleMarkers([string]$html, [hashtable]$styles) {
  return [regex]::Replace(
    $html,
    '(?is)<(?<tag>span|a)\b(?<pre>[^>]*)\bclass="(?<cls>[^"]*)"(?<post>[^>]*)>(?<inner>.*?)</\k<tag>>',
    {
      param($m)
      $classes = $m.Groups['cls'].Value -split '\s+'
      $inner = $m.Groups['inner'].Value
      $bold = $false
      $italic = $false

      foreach ($c in $classes) {
        if ($styles.ContainsKey($c)) {
          if ($styles[$c].Bold) { $bold = $true }
          if ($styles[$c].Italic) { $italic = $true }
        }
      }

      if (-not $bold -and -not $italic) {
        return $inner
      }

      $open = ''
      $close = ''
      if ($bold) { $open += '**'; $close = '**' + $close }
      if ($italic) { $open += '*'; $close = '*' + $close }
      return $open + $inner + $close
    }
  )
}

$text = $body -replace '(?is)<script.*?</script>', ''
$text = Apply-ClassStyleMarkers $text $classStyles
$text = [regex]::Replace($text, '(?is)<(b|strong)\b[^>]*>(.*?)</\1>', { param($m) '**' + $m.Groups[2].Value + '**' })
$text = [regex]::Replace($text, '(?is)<(i|em)\b[^>]*>(.*?)</\1>', { param($m) '*' + $m.Groups[2].Value + '*' })
$text = $text -replace '(?is)<style.*?</style>', ''
$text = $text -replace '(?i)</(h1|h2|h3|h4|p|li|ol|ul|div|table|tr|td)>', "`n"
$text = $text -replace '(?i)<br\s*/?>', "`n"
$text = $text -replace '(?is)<[^>]+>', ' '

Add-Type -AssemblyName System.Web
$text = [System.Web.HttpUtility]::HtmlDecode($text)
$text = $text -replace "`r", ''
$text = $text -replace [regex]::Escape([string][char]0x200C), ''
$text = $text -replace ([string][char]0x00C2 + [string][char]0x00A9), [string][char]0x00A9
$text = $text -replace ([string][char]0x00C2 + [string][char]0x00A3), [string][char]0x00A3

$lines = $text -split "`n" |
  ForEach-Object {
    $line = ($_ -replace '\s+', ' ').Trim()
    $line = $line -replace '\*\*\*([^*]*?\S)\s+\*\*\*', '***$1***'
    $line = $line -replace '\*\*\s+([^*].*?\S)\s+\*\*', '**$1**'
    $line = $line -replace '\*\*\s+([^*].*?[^\s])\s+\*\*', '**$1**'
    $line = $line -replace '\*\*([^*]*?\S)\s+\*\*', '**$1**'
    $line = $line -replace '\*\s+([^*].*?\S)\s+\*', '*$1*'
    $line = $line -replace '\*\s+([^*].*?[^\s])\s+\*', '*$1*'
    $line = $line -replace '\*([^*]*?\S)\s+\*', '*$1*'
    $line = $line -replace '(\*{1,3}[^*]+\*{1,3})([A-Za-z])', '$1 $2'
    $line = $line -replace '([A-Za-z])(\*{1,3}[^*]+\*{1,3})', '$1 $2'
    $line
  } |
  Where-Object { $_ -ne '' }

function Is-NoiseLine([string]$s) {
  if ($s -match '^(i|ii|iii|iv|v|vi|vii|viii|ix|x)$') { return $true }
  if ($s -match '^\d+$') { return $true }
  if ($s -match '^\.+\d*$') { return $true }
  if ($s -match '^[\*#•·]+$') { return $true }
  if ($s -match '^ARexx User''s Reference Manual$') { return $true }
  if ($s -match '^Table of Contents(\s+ARexx User''s Reference Manual)?$') { return $true }
  return $false
}

function Format-Line([string]$s, [bool]$inCode) {
  $line = $s

  if ($line -match '^[•\*]\s*') { return @("- " + ($line -replace '^[•\*]\s*', '').Trim(), $false) }
  if ($line -match '^[A-Z]-\d+\s+.+') { return @('## ' + $line, $false) }
  if ($line -match '^\d+-\d+\s+.+') { return @('## ' + $line, $false) }
  if ($line -match '^\d+\s+[A-Za-z].+') { return @('## ' + $line, $false) }
  if ($line -cmatch '^[A-Z][A-Z0-9_]{2,}$') { return @('### ' + $line, $false) }
  if ($line -cmatch '^[A-Z][A-Za-z0-9''()/:-]*( [A-Z0-9][A-Za-z0-9''()/:-]*){0,7}$' -and $line.Length -le 70) {
    return @('## ' + $line, $false)
  }
  if ($line -match '^Usage:\s*(.+)$') {
    return @('**Usage:** ' + '`' + $Matches[1] + '`', $false)
  }
  if ($line -match '^(Example|Examples|See Also):') { return @('**' + $line + '**', $false) }
  if ($line -match '^[A-Z][A-Z0-9_]+\(\)$') { return @('### ' + $line, $false) }

  return @($line, $false)
}

function Is-CodeLine([string]$line) {
  if ($line -eq '') { return $false }
  if ($line -match '^#{1,6}\s') { return $false }
  if ($line -match '^\*\*(Usage|Example|Examples|See Also)') { return $false }
  if ($line -match '^[-•]\s') { return $false }
  if ($line -match '^\d+\s') { return $false }
  if ($line -match '^[A-Z][A-Za-z ]{0,40}$' -and $line -notmatch '\(') { return $false }

  $trimmed = $line.Trim()
  if ($trimmed.Length -gt 140) { return $false }

  $wordCount = ($trimmed -split '\s+' | Where-Object { $_ -ne '' }).Count
  if ($wordCount -gt 18) { return $false }

  if ($trimmed -match "(?i)^'\\*.*\\*'$") { return $true }
  if ($trimmed -match '(?i)\bI\*') { return $true }
  if ($trimmed -match '(?i)==>') { return $true }
  if ($trimmed -match '(?i)^\s*(address|arg|break|call|do|drop|echo|else|end|exit|if|interpret|iterate|leave|nop|numeric|options|otherwise|parse|procedure|pull|push|queue|return|say|select|shell|signal|then|trace|upper|when)\b') { return $true }
  if ($trimmed -match '(?i)^\s*[a-z][a-z0-9_.]*\s*=\s*[^\s].*$') { return $true }
  if ($trimmed -match "(?i)^\\s*'.+'\\s+'.+'.*$") { return $true }

  return $false
}

$bounds = @()
for ($i = 0; $i -lt $lines.Count; $i++) {
  $s = $lines[$i]
  if ($s -cmatch '^Chapter\s+\d+\s+[A-Z]' -or $s -cmatch '^Appendix\s+[A-Z]\s+[A-Z]') {
    $bounds += [pscustomobject]@{ Index = $i; Title = $s }
  }
}

if ($bounds.Count -gt 0 -and $bounds[0].Index -gt 0) {
  $front = @('# Front Matter', '')
  foreach ($line in $lines[0..($bounds[0].Index - 1)]) {
    if (Is-NoiseLine $line) { continue }
    $front += $line
    $front += ''
  }
  Set-Content -Path (Join-Path $outDir '00-front-matter.md') -Value $front -Encoding UTF8
}

for ($b = 0; $b -lt $bounds.Count; $b++) {
  $start = $bounds[$b].Index
  $end = if ($b -lt $bounds.Count - 1) { $bounds[$b + 1].Index - 1 } else { $lines.Count - 1 }
  $title = $bounds[$b].Title

  $safe = $title.ToLower()
  $safe = $safe -replace '[^a-z0-9\s-]', ''
  $safe = $safe -replace '\s+', '-'

  if ($title -cmatch '^Chapter\s+(\d+)') {
    $num = [int]$Matches[1]
    $file = ('chapter-{0:d2}.md' -f $num)
  }
  elseif ($title -cmatch '^Appendix\s+([A-Z])') {
    $letter = $Matches[1].ToLower()
    $file = ('appendix-{0}.md' -f $letter)
  }
  else {
    $file = "$safe.md"
  }

  $out = @('# ' + $title, '')
  $inCode = $false
  $codeBlock = @()

  for ($i = $start + 1; $i -le $end; $i++) {
    $line = $lines[$i]

    if (Is-NoiseLine $line) { continue }
    if ($line -cmatch '^Chapter\s+\d+\s+[A-Z]' -or $line -cmatch '^Appendix\s+[A-Z]\s+[A-Z]') { continue }

    $res = Format-Line $line $inCode
    if ($res[0] -match '^([*#•·-])$') {
      continue
    }
    if ($res[0] -match '^#{1,6}\s*$') {
      $out += $line
      $out += ''
      continue
    }
    if (Is-CodeLine $res[0]) {
      $codeLine = $res[0]
      $codeLine = $codeLine -replace '\*\*\*([^*]+)\*\*\*', '$1'
      $codeLine = $codeLine -replace '\*\*([^*]+)\*\*', '$1'
      $codeBlock += $codeLine
      continue
    }

    if ($codeBlock.Count -gt 0) {
      $out += '```rexx'
      $out += ''
      foreach ($cl in $codeBlock) {
        $out += $cl
      }
      $out += '```'
      $out += ''
      $codeBlock = @()
    }

    $out += $res[0]
    $inCode = [bool]$res[1]
    $out += ''
  }

  if ($codeBlock.Count -gt 0) {
    $out += '```rexx'
    $out += ''
    foreach ($cl in $codeBlock) {
      $out += $cl
    }
    $out += '```'
    $out += ''
  }

  Set-Content -Path (Join-Path $outDir $file) -Value $out -Encoding UTF8
}

Get-ChildItem $outDir -File | Sort-Object Name | Select-Object -ExpandProperty Name
