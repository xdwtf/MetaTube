echo "git clone, Please Wait..."
git clone https://github.com/xdwtf/Fheroku.git /metatube
echo "Trying Requirements..."
cd /metatube
pip3 install -U -r requirements.txt
echo "starting web"
python3 metatube.py
