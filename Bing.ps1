function Save-BingTodayImage()
{
    #API - Bing Today Image
    $bingImageApi ='http://www.bing.com/HPImageArchive.aspx?format=xml&idx=0&n=1&mkt=zh-cn'
    $bingUri = 'http://www.bing.com/'
 
    # Get The Url
    [xml]$bingImageXml = (Invoke-WebRequest -Uri $bingImageApi).Content
    Write-Host " 今日图片故事： $( $bingImageXml.images.image.copyright ) "
    $imgLink = '{0}{1}' -f $bingUri , $bingImageXml.images.image.url
 
    # Download The Image
    $imageDir = "$HOME\Pictures\Bing\"
    if( -not (Test-Path $imageDir) )
    {
        mkdir $imageDir | Out-Null
    }
    $imageFile = Join-Path $imageDir ( '{0}.jpg' -f $bingImageXml.images.image.fullstartdate)
 
    Invoke-WebRequest -Uri $imgLink -OutFile $imageFile
 
    return $imageFile
}
 
Function Set-DesktopWallPaper($imagePath)
{
 Set-ItemProperty -path 'HKCU:\Control Panel\Desktop\' -name wallpaper -value $imagePath
 RUNDLL32.EXE USER32.DLL UpdatePerUserSystemParameters ,1 ,True
}
 
# Get Image From Bing
$image=Save-BingTodayImage
 
# Set WallPaper
Set-DesktopWallPaper -imagePath $image