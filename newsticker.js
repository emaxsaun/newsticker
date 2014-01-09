jwplayer().registerPlugin('newsticker', '6.0', function(player, config, newsticker){
	//set up
	function setup(evt) {
		//html5 mode only
		if (player.getRenderingMode() == "html5"){
		var theBody = document.getElementById(player.id);
		var playerWidthPX2 = player.getHeight();
		var playerWidthPX = parseFloat(playerWidthPX2);
		var playerHeightPX2 = player.getWidth();
		var playerHeightPX = parseFloat(playerHeightPX2);
		var bg = document.createElement("div");
		bg.setAttribute('id', 'bg');
		bg.style.height = 20 + "px";
		bg.style.width = player.getWidth() + "px";
		if (config.backgroundcolor == null){
		bg.style.background = "#666666";
		} else {
		bg.style.background = config.backgroundcolor;
		}
		bg.style.opacity = "0.55";
		bg.style.position = "absolute";
		bg.style.zIndex = "999";
		bg.width = player.getWidth();
		bg.height = 24;
		var newsticker1 = document.createElement("marquee");
		newsticker1.setAttribute('id', 'newsticker1');
		if (config.textcolor == null){
		newsticker1.style.color = "#FFFF00";
		} else {
		newsticker1.style.color = config.textcolor;
		}
		if (config.text == null){
		newsticker1.innerHTML = "Hello, thanks for downloading...feel free to change this message...";
		} else {
		newsticker1.innerHTML = config.text;
		}
		if (config.scrollspeed == null){
		newsticker1.setAttribute('scrollamount', '6');
		} else {
		newsticker1.setAttribute('scrollamount',config.scrollspeed);
		}
		if (config.scrolldirection == null){
		newsticker1.setAttribute('direction', 'left');
		}
		if (config.scrolldirection == "right"){
		newsticker1.setAttribute('direction','right');
		}
		if (config.scrolldirection == "up"){
		newsticker1.setAttribute('direction', 'left');
		}
		if (config.scrolldirection == "down"){
		newsticker1.setAttribute('direction', 'left');
		}
		newsticker1.style.fontSize = '14px';
		newsticker1.style.fontWeight = 'bold';
		newsticker1.style.cursor = "default";
		newsticker1.style.fontFamily = 'arial,_sans';
		newsticker1.style.position = "absolute";
		newsticker1.style.zIndex = "1000";
		if (config.position == "top"){
		newsticker1.style.top = playerHeightPX - playerHeightPX + 2 +"px";
		bg.style.top = playerHeightPX - playerHeightPX + "px";
		}
		theBody.appendChild(bg);
		theBody.appendChild(newsticker1);
		newsticker1.onmouseup = function(){
		if (config.link != null){
		newsticker1.style.cursor = "pointer";
		window.open(config.link,config.linktarget);
		}
		}
		newsticker1.onmouseover = function(){
		newsticker1.setAttribute('scrollamount', '0');
		}
		newsticker1.onmouseout = function(){
		if (config.scrollspeed != null){
		newsticker1.setAttribute('scrollamount',config.scrollspeed);
		} else {
		newsticker1.setAttribute('scrollamount','6');
		}
		}
		}
	}
	player.onReady(setup);
	var txt = new String("is_on");
    this.resize = function(width, height) {
		player.addButton("data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAdCAYAAADLnm6HAAAACXBIWXMAAA7DAAAOwwHHb6hkAAAABGdBTUEAALGOfPtRkwAAACBjSFJNAAB6JQAAgIMAAPn/AACA6QAAdTAAAOpgAAA6mAAAF2+SX8VGAAABeUlEQVR42mL8//8/w0ACgABiYhhgABBAA+4AgABigdIOUFoAiPWh7IlA/AGLHgcsYg+g2ABqBoyPDShAMQh8AAggBlAa+I8d9EPl0DE2UI9HDh/YDxBA+KKgAIgDSAhNAXKiACCACKWB+SQY7ECOAwACiIUIX60HYkciQ+AAWrpIwKJuAjStgMAFgACCxet5AnFVgJQGsKlNwJJWHHCYhaIOIICY4KkRP6hHcvUHHLmALAAQQEwkJLD5tCgHAAKIlIIIFAL91HYAQADhc8AGHFnTgJoOAAggfA6YiJaqKcrvuABAABGKgkAiEihFACCACDkAZHkimWYLECMOEEBMRJRiG6CFB6lAH09ihgOAACI2FxSCSy0aAIAAIiUbJtIiPQAEECkOAIVAI7UdABBAsMqogcjiFZYW+IlQe5AYcwECiHGgG6UAATTgbUKAABpwBwAEECgNnBlIBwAEEOP/AU4EAAE04FEAEECgKGAcSAcABNCAhwBAgAEAT8sXNkFY65kAAAAASUVORK5CYII%3D", 
            "NewsTicker", 
            function() { NewsTickerToggle(); }, 
            "newstickerdock");
	if (config.nobutton == "true" || config.nobutton == true){
		player.removeButton("newstickerdock");
	}
	var theBg = document.getElementById('bg');
	var theNt = document.getElementById('newsticker1');
	theNt.style.visibility = "visible";
	theBg.style.visibility = "visible"
	if (config.position == "top" || config.position == top){
		newsticker1.style.top = player.getHeight() - player.getHeight() + 2 +"px";
		bg.style.top = player.getHeight() - player.getHeight() +"px";
		newsticker1.style.width = player.getWidth()+"px";
		bg.style.width = player.getWidth()+"px";
	} else {
	if(player.getFullscreen() == true){
		newsticker1.style.top = player.getHeight() - 20 +"px";
		bg.style.top = player.getHeight() - 20 +"px";
		newsticker1.style.width = player.getWidth()+"px";
		bg.style.width = player.getWidth()+"px";
	} else if(player.getFullscreen() == false){
		newsticker1.style.top = player.getHeight() - 20 +"px";
		bg.style.top = player.getHeight() - 20 +"px";
		newsticker1.style.width = player.getWidth()+"px";
		bg.style.width = player.getWidth()+"px";
	}
	}
	NewsTickerToggle = function(){
	if(theNt.style.visibility == "visible" && theBg.style.visibility == "visible"){
		theNt.style.visibility = "hidden";
		theBg.style.visibility = "hidden";
		txt = "is_off";
		} else {
		theNt.style.visibility = "visible";
		theBg.style.visibility = "visible";
		txt = "is_on";
		}
	}
	if(player.getFullscreen() == true && txt == "is_off") {
	theNt.style.visibility = "hidden";
	theBg.style.visibility = "hidden";
	} 
	if(player.getFullscreen() == false && txt == "is_off"){
	theNt.style.visibility = "hidden";
	theBg.style.visibility = "hidden";
	}
	if(player.getFullscreen() == true && txt == "is_on") {
	theNt.style.visibility = "visible";
	theBg.style.visibility = "visible";
	} 
	if(player.getFullscreen() == false && txt == "is_on"){
	theNt.style.visibility = "visible";
	theBg.style.visibility = "visible";
	}
	};
	//fall back to flash
}, './newsticker.swf');