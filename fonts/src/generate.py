from os import listdir
from os.path import join
import fontforge

iconDir = "icons"

font = fontforge.font()

for fileName in listdir(iconDir):
    charCode = int(fileName.split(".")[0], 16)

    c = font.createChar(charCode)
    c.importOutlines(join(iconDir, fileName))
    c.left_side_bearing = 15
    c.right_side_bearing = 15

font.fullname = "SystemIcons Bold"
font.familyname = "SystemIcons"
font.fontname = "SystemIcons-Bold"

font.generate("icons.ttf")
