# next-kong
An arcade game for the ZX Spectrum Next based off of [ped7g's SpecBong tutorial](https://github.com/ped7g/SpecBong).

### Converting images to nxi and nxp

1. Resize and convert to uncompressed 8-bit bmp.
`convert norway.jpg -resize 320x256 -background black -gravity center -extent 320x256 -colors 256 -depth 8 -compress none bmp:norway.bmp`
2. Fix palette with the [zxnext bmp tools](https://github.com/stefanbylund/zxnext_bmp_tools).
`nextbmp norway.bmp`
3. Convert to nxi and nxp.
`nextraw -columns -sep-palette norway.bmp`

### How to run in the CSpect Emulator

1. Download CSpect from <http://cspect.org>.
2. Optionally download distro sd card images from <http://www.zxspectrumnext.online>.
3. Install Mono if you are on Linux or OSX.
4. Extract CSpect zip.
5. Run `(mono) CSpect.exe -w3 -zxnext`.
6. Press F2.
7. Select whichever nex file you want to run.
