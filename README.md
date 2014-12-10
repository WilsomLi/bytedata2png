bytedata2png
============

It's a bytedata to png tool by lua language.

这是用LUA脚本写的解析二进制文件中的PNG图片。现有部分手游是把资源打包在一起的（如仙侠道），而且没采用任何压缩算法，
而PNG图片有固定数据结构，可根据PNG和END索引到图片文件的头和尾位置，然后读取生成新的PNG图。
