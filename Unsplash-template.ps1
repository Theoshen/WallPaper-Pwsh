function Save-UnsplashRandomImage() {
    # Unsplash API - Random Photo
    $unsplashImageApi = 'https://api.unsplash.com/photos/random?client_id=YourAPIAccessKey&orientation=landscape&q=1'

    # Get The Url
    $jsonResponse = Invoke-RestMethod -Uri $unsplashImageApi -Method Get
    $imageUrl = $jsonResponse.urls.raw

    # Download The Imagey
    $imageDir = "$HOME\Pictures\Unsplash\"
    if (-not (Test-Path $imageDir)) {
        mkdir $imageDir | Out-Null
    }
    $timestamp = Get-Date -Format "yyyyMMddHHmmss"
    $imageFileName = "image_$timestamp.jpg"
    $imageFile = Join-Path $imageDir $imageFileName

    Invoke-WebRequest -Uri $imageUrl -OutFile $imageFile

    return $imageFile
}
 
Function Set-DesktopWallPaper($imagePath) {
    Set-ItemProperty -path 'HKCU:\Control Panel\Desktop\' -name wallpaper -value $imagePath
    RUNDLL32.EXE USER32.DLL UpdatePerUserSystemParameters , 1 , True
}
 
# Get Image From Unsplash
$image = Save-UnsplashRandomImage
 
# Set WallPaper
Set-DesktopWallPaper -imagePath $image