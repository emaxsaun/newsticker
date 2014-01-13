NewsTicker
==========

About this Plugin:
==========

This is a JW Player Plugin that creates a block of scrolling text on the player, similar to a news ticker.

###[Demo](http://www.pluginsbyethan.com/github/newsticker.html)

Configuration Options:
==========

This plugin supports additional configuration options via flashvars. You can read about the available options below and see examples below.

The following flashvars are supported by both Flash and HTML5:
Flashvar: newsticker.text = Hello, thanks for downloading...feel free to change this message...

This flashvar is used to specify the text that shows up in the ticker. The default is - "Hello, thanks for downloading...feel free to change this message..."
Flashvar: newsticker.scrollspeed = 3

This flashvar is used to specify the speed to scroll the text. By default, the text scrolls from right to left, but you can reverse it by adding a - sign in front of the value. (In HTML5 the - sign does nothing, see below).
Flashvar: newsticker.link = URL

This flashvar is used to specify an optional link to go to when the text is clicked on.
Flashvar: newsticker.linktarget = _blank

This flashvar is used to specify the link target for when the link is clicked on. The default is _blank. The other possible options are _self, _parent, or _top.
Flashvar: newsticker.nobutton = false

If you set this flashvar to true, the dock icon will not be visible.
Flashvar: textcolor = yellow

This is the color of the text. The default is yellow. It accepts any color or hex value.
Flashvar: backgroundcolor = grey

This is the color of the text. The default is grey. It accepts any color or hex value.

The following flashvars are supported by Flash only:
Flashvar: dock = true

If you set this flashvar to false, the dock icon will not be visible.
Flashvar: newsticker.textwidth = 1

This flashvar is used to specify the additional times to mutiply the width of the textbox. This is not needed by HTML5 (see below).

The following flashvars are supported by HTML5 only:
Flashvar: scrolldirection = left

This is the direction that the text scrolls in. By default it is left. It can also be changed to right.
Flashvar: position = bottom

This is the position of the ticker. The default is bottom. It can also be set to top.

Implementing this Plugin:
==========

There are two files that you need to use, newsticker.js and newsticker.swf. Upload these files to your server, they can go anywhere on the server, but make sure you upload both of them to the same directory. Now, inside of your JW Player embed code, make sure that your plugins call points to the full path to the .js file on your server (http://www.yoursite.com/newsticker.js), don't worry about the .swf, it is already referenced in the newsticker.js file. 

Example:
==========

<pre>
&lt;script type=&quot;text/javascript&quot; src=&quot;jwplayer.js&quot;&gt;&lt;/script&gt;
&lt;div id=&quot;player&quot;&gt;&lt;/div&gt;
&lt;script type=&quot;text/javascript&quot;&gt;
jwplayer('player').setup({
&nbsp;&nbsp;'width': '575',
&nbsp;&nbsp;'height': '400',
&nbsp;&nbsp;'file': 'video.mp4'
&nbsp;&nbsp;'image': &quot;video.jpg&quot;,
&nbsp;&nbsp;plugins: {
	&nbsp;&nbsp;&nbsp;&nbsp;&quot;newsticker.js&quot;: {
	&nbsp;&nbsp;}
&nbsp;&nbsp;}
});
&lt;/script&gt;
</pre>

The source code is available in this plugin as well. There is a .as file for Flash, and a .js file for JavaScript. Compiling can be done in ANT, using the Flex SDK, or simply using Flash, as I have included a .fla file as well. The JW6 library is included as well (jwplayer-6-lib.swc). All assets for the images embedded in the plugin are available as well. Publishing the JavaScipt can be simply done with any text editor. Enjoy~! :) 
