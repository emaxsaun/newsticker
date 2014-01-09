package {
	import com.longtailvideo.jwplayer.events.*;
	import com.longtailvideo.jwplayer.plugins.*;
	import com.longtailvideo.jwplayer.player.*;
	import com.longtailvideo.jwplayer.view.components.*;
	
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.text.*
	import flash.net.*;
	import flash.geom.*;
	
	import flash.filters.BlurFilter;
	
	public class NewsTicker extends Sprite implements IPlugin6 {
		private var api:IPlayer;
		private var player:IPlayer;
		private var pluginConfig:PluginConfig;
		private var textBox:TextField;
		private var textBack:Sprite;
		private var textBack2:Sprite;
		private var maskedClip:MovieClip;
		
		[Embed(source="controlbar.png")]
		private const ControlbarIcon:Class;
		
		[Embed(source="icon.png")]
		private const Icon:Class;
		
		/** Reference to embed icon **/
		private var skinIcon:DisplayObject;
		/** Remenber if dock button is active or not. **/
		private var showing:Boolean;
		/** Reference to the dock button **/
		private var dockButton:DockButton;
		/** Reference to the clip on stage. **/
		private var controlIcon:DisplayObject;
		
		/** Let the player know what the name of your plugin is. **/
		public function get id():String { return "newsticker"; }
		
		/** Let the player know what version of the player you are targeting. **/
		public function get target():String {
			return "6.0";
		}
		
		/** List with configuration settings. **/
		public var defaultConfig:Object = {
			position:'over',
			size:'0',
			text:'Hello, thanks for downloading...feel free to change this message...',
			scrollspeed:'3',
			link:'',
			textwidth:'1',
			nobutton:'false',
			linktarget:'_blank',
			textcolor:'0xFFFF00',
			backgroundcolor:'0x666666'
		};

		/** Constructor **/
		public function NewsTicker() {
			textBack = new Sprite();
			addChild(textBack);
			textBox = new TextField();
			textBox.defaultTextFormat = new TextFormat('_sans',14,0x000000,true);
			textBox.x = 0;
			textBox.y = 0;
			addChild(textBox);
			textBack2 = new Sprite();
			addChild(textBack2);
			textBack2.alpha = 0;
			showing = false;
			maskedClip = new MovieClip();
			maskedClip.x = 0;
			maskedClip.y = 0;
			addChild(maskedClip);
		}
		
		/* Called by the player after the plugin has been created. */
		public function initPlugin(player:IPlayer, config:PluginConfig):void {
			api = player;
			player = player;
			this.player = player;
			var nobutton:String = config['nobutton'];
			var linktarget:String = config['linktarget'];

				if(nobutton != "true"){
					skinIcon = player.skin.getSkinElement("newsTicker", "dockIcon");
					if (skinIcon == null) 
					{
						skinIcon = new Icon();
					}
					dockButton = player.controls.dock.addButton(skinIcon, "NewsTicker", dockHandler) as DockButton;
				}
				if(nobutton == "true"){}
			
			var speed = config['scrollspeed'];
			
			textBack2.addEventListener(MouseEvent.MOUSE_OVER,function():void {
				config['scrollspeed'] = 0;});
			
			textBack2.addEventListener(MouseEvent.MOUSE_OUT,function():void {
				config['scrollspeed'] = speed;});
			
			if(config['textwidth'] == null){
				config['textwidth'] = 1;
			}
			
			if(config['link'] == null){
				//Make the Pointer Go Away
				textBack2.buttonMode = false;
				textBack2.useHandCursor = false;
				textBack2.removeEventListener(MouseEvent.MOUSE_DOWN,function():void {
				}
			);
			}
			
			if(config['link'] != null){
				//Add the Pointer
				textBack2.buttonMode = true;
				textBack2.useHandCursor = true;
				textBack2.addEventListener(MouseEvent.MOUSE_DOWN,function():void {
				//go to link
				navigateToURL(new URLRequest(config['link']), linktarget);}
			);
			}
			
			var blur_amt=1.3;
			var filtersArray:Array = new Array();
			var blur_filter:BlurFilter = new BlurFilter(blur_amt, blur_amt);
			filtersArray.push(blur_filter);
			textBox.filters = filtersArray;
			textBox.antiAliasType = "advanced";
			
			if(config['text'] == null){
				textBox.text = 'Hello, thanks for downloading...feel free to change this message...';
			} else {
				textBox.text = config['text'];
			}
			
			//light color
			function getLightColor():uint {
				if (config['textcolor']) {
					return config['textcolor'];
				} else {
					return 0xFFFF00;
				}
			};
			
			//front color
			function getFrontColor():uint {
				if (config['backgroundcolor']) {
					return config['backgroundcolor'];
				} else {
					return 0x666666;
				}
			};

			textBox.textColor = getLightColor();
			
			textBox.width = (stage.stageWidth)*config['textwidth'];
			textBox.selectable = false;
			textBox.height = 20;
			
			if (player.config.playlist == 'right') {
				textBack.graphics.beginGradientFill("linear",[getFrontColor(),0x000000],[0.50,0.75],[127,255],new Matrix(0,1,1,1,width,0),"reflect");
				textBack.graphics.drawRect(0,0,stage.stageWidth - Number(player.config.playlistsize),20);
				textBack.graphics.endFill();
			}
			
			else {
			
			textBack.graphics.beginGradientFill("linear",[getFrontColor(),0x000000],[0.50,0.75],[127,255],new Matrix(0,1,1,1,width,0),"reflect");
			textBack.graphics.drawRect(0,0,999999,20);
			textBack.graphics.endFill();
			
			}
			
			textBack2.graphics.beginGradientFill("linear",[getFrontColor(),0x000000],[0.50,0.75],[127,255],new Matrix(0,1,1,1,width,0),"reflect");
			textBack2.graphics.drawRect(0,0,999999,20);
			textBack2.graphics.endFill();
			
			player.addEventListener(PlaylistEvent.JWPLAYER_PLAYLIST_ITEM,playlistHandler);
			
			//if right, draw mask
			if (player.config.playlist == 'right') {
				drawMask();
			}
			
			//if left, draw the other mask
			if (player.config.playlist == 'left') {
				drawMask2();
			}
			
			function drawMask():void {
				maskedClip.graphics.clear();
				maskedClip.graphics.beginFill(0xFFFFFF,1);
				maskedClip.graphics.drawRect(0,0,stage.stageWidth - Number(player.config.playlistsize),20)
				maskedClip.graphics.endFill();
			}
			
			function drawMask2():void {
				maskedClip.graphics.clear();
				maskedClip.graphics.beginFill(0xFFFFFF,1);
				maskedClip.graphics.drawRect(0,0,999999,20);
				maskedClip.graphics.endFill();
			}
			
			/** playlists  */
	        function playlistHandler(evt:PlaylistEvent):void {
    	        if(player.playlist.currentItem['newsticker.text'] && 
        	        player.playlist.currentItem['newsticker.link'] != config['text']) {
            	    textBox.text = player.playlist.currentItem['newsticker.text'];
					config['link'] = player.playlist.currentItem['newsticker.link'];
					
					if(config['link'] == null){
					//Make the Pointer Go Away
					textBack2.buttonMode = false;
					textBack2.useHandCursor = false;
					textBack2.removeEventListener(MouseEvent.MOUSE_DOWN,function():void {});
					}
			
					if(config['link'] != null){
					//Add the Pointer
					textBack2.buttonMode = true;
					textBack2.useHandCursor = true;
					textBack2.addEventListener(MouseEvent.MOUSE_DOWN,function():void {
					//go to link
					navigateToURL(new URLRequest(player.playlist.currentItem['newsticker.link']), linktarget);});
					}
    	        }
        	}
			
			//scrolling
			this.addEventListener(Event.ENTER_FRAME,EnterFrame);
			function EnterFrame(event:Event):void {
				if(config['scrollspeed'] == null){
					textBox.x -= 3;
				} else {
					textBox.x -= config['scrollspeed'];
				}
				if(textBox.x < -(textBox.width)) {
					textBox.x = stage.stageWidth;
				}
				
				if(textBox.x > (stage.stageWidth)) {
					textBox.x = -(textBox.width);
				}
			}
		}
		
		/* When the player resizes itself, it sets the x/y coordinates of all components and plugins. */		
		public function resize(wid:Number, hei:Number):void {
			if (player.config.fullscreen) {
				textBox.y = hei - textBox.height;
				textBack.y = hei - textBack.height;
				textBack2.y = hei - textBack.height;
				maskedClip.y = hei - textBox.height;
				if (player.config.playlist == 'right'){
				maskedClip.alpha = 0;
				textBox.mask = null;
				textBack.width = stage.stageWidth;
				textBack2.width = stage.stageWidth;
				}
			} else {
				textBox.y = hei - textBox.height;
				textBack.y = hei - textBack.height;
				textBack2.y = hei - textBack.height;
				maskedClip.y = hei - textBox.height;
				maskedClip.x = 0;
				if (player.config.playlist == 'right'){
				maskedClip.alpha = 100;
				textBox.mask = maskedClip;
				textBack.width = stage.stageWidth - Number(player.config.playlistsize);
				textBack2.width = stage.stageWidth - Number(player.config.playlistsize);
				}
				if (player.config.playlist == 'left'){
				textBox.mask = maskedClip;
				}
			}
		}
		
		/** Dock icon is clicked; toggle on/off. **/
		private function dockHandler(evt:MouseEvent):void 
		{
			if (showing) 
			{
				dockButton.alpha = 1;
				textBox.visible = true;
				textBack.visible = true;
			} else 
			{
				dockButton.alpha = 0.75
				textBox.visible = false;
				textBack.visible = false;
			}
			//Not Showing
			showing = !showing;
		}
		
		/** Controlbar button icon is clicked; toggle on/off. **/
		private function controlHandler(evt:MouseEvent):void 
		{
			if (showing) 
			{
				controlIcon.alpha = 1;
				textBox.visible = true;
				textBack.visible = true;
			} else 
			{
				controlIcon.alpha = 0.50;
				textBox.visible = false;
				textBack.visible = false;
			}
			showing = !showing;
		}
	}
}