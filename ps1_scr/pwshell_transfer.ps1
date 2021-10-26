#catalogs
$DIR_in_dir="D:\appadmin\1\"
$DIR_in_dir_zip="D:\appadmin\2\"
$DIR_out_dir="D:\appadmin\3\"
$DIR_inDir_out="D:\appadmin\a\"
$DIR_inDir_out_arch="D:\appadmin\b\$((Get-Date).ToString('yyyy-MM-dd'))"
$DIR_inDir_in="D:\appadmin\c\"
$DIR_inDir_in_arch="D:\appadmin\d\$((Get-Date).ToString('yyyy-MM-dd'))"

#file extension
$txt="*.txt"
$zip="*.zip"
$rar="*.rar"
$sh="*.sh"

#logs
$DIR_log_out_today="$DIR_inDir_out_arch\log_out_$((Get-Date).ToString('yyyy-MM-dd')).txt"
$DIR_log_in_today="$DIR_inDir_in_arch\log_in_$((Get-Date).ToString('yyyy-MM-dd')).txt"
$DIR_logs="D:\appadmin\logs_$((Get-Date).ToString('yyyy-MM-dd')).log"

#check .txt, .zip, .rar - create dir&logs
#check txt
if (Test-Path -Path $DIR_in_dir$txt -PathType Leaf) {
New-Item -ItemType Directory -Force -Path $DIR_inDir_out_arch
New-Item -ItemType File -Force -Path $DIR_log_out_today
New-Item -ItemType File -Force -Path $DIR_logs
}

#check zip
if (Test-Path -Path $DIR_in_dir_zip$zip -PathType Leaf) {
New-Item -ItemType Directory -Force -Path $DIR_inDir_out_arch
New-Item -ItemType File -Force -Path $DIR_log_out_today
New-Item -ItemType File -Force -Path $DIR_logs
}
#check rar    
if (Test-Path -Path $DIR_in_dir_zip$rar -PathType Leaf) {
New-Item -ItemType Directory -Force -Path $DIR_inDir_out_arch
New-Item -ItemType File -Force -Path $DIR_log_out_today
New-Item -ItemType File -Force -Path $DIR_logs
}

#check txt for sending
if (Test-Path -Path $DIR_inDir_in$sh -PathType Leaf) {
New-Item -ItemType Directory -Force -Path $DIR_inDir_in_arch
New-Item -ItemType File -Force -Path $DIR_log_in_today
New-Item -ItemType File -Force -Path $DIR_logs
}

#Body
#
Start-Transcript -Path $DIR_log_out_today -Append -Force
$filelist_txt = @(Get-ChildItem $DIR_in_dir$txt)
ForEach ($file in $filelist_txt){
    Copy-Item -Path $file.FullName $DIR_inDir_out_arch -Verbose
	Move-Item -Path $file.FullName $DIR_inDir_out -Verbose
    }

#
$filelist_rar = @(Get-ChildItem $DIR_in_dir_zip$zip)
ForEach ($file in $filelist_zip){
    Copy-Item -Path $file.FullName $DIR_inDir_out_arch -Verbose
	Move-Item -Path $file.FullName $DIR_inDir_out -Verbose
    }
#
$filelist_rar = @(Get-ChildItem $DIR_in_dir_zip$rar)
ForEach ($file in $filelist_rar){
    Copy-Item -Path $file.FullName $DIR_inDir_out_arch -Verbose
	Move-Item -Path $file.FullName $DIR_inDir_out -Verbose
    }
Stop-Transcript

Start-Transcript -Path $DIR_log_in_today -Append -Force
#
$filelist_sh = @(Get-ChildItem $DIR_inDir_in$sh)
ForEach ($file in $filelist_sh){
    Copy-Item -Path $file.FullName $DIR_inDir_in_arch -Verbose
	Move-Item -Path $file.FullName $DIR_out_dir -Verbose
    }
Stop-Transcript

#all_logs
$from_log_in = Get-Content -Path $DIR_log_in_today
$from_log_out = Get-Content -Path $DIR_log_out_today
Add-Content -Path $DIR_logs -Value $from_log_in
Add-Content -Path $DIR_logs -Value $from_log_out