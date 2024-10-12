from PIL import Image, ImageFont, ImageDraw
import sys

text = ' '.join(sys.argv[1:])

font = ImageFont.truetype('arialbd.ttf', 15)
size = font.getsize(text)
image = Image.new('1', size, 1)
draw = ImageDraw.Draw(image)
draw.text((0, 0), text, font=font)
for rownum in range(size[1]):
    line = []
    for colnum in range(size[0]):
        if image.getpixel((colnum, rownum)): line.append(' '),
        else: line.append('#'),
    print(''.join(line))