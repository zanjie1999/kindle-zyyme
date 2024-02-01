cd `dirname $0`
rm wininfo_screenshot_*.txt
mv screenshot_*.png screenshot
dot_clean .
dot_clean **
find . -name '._*' -exec rm {} \;