import h2d.Tile;
import h2d.Bitmap;

class Main extends hxd.App {

	static function main(): Void {
		new Main();
	}

	override function init() {
		var bmp = new Bitmap( Tile.fromColor( 0, s2d.width, s2d.height ), s2d );
		var shader = new MainShader( new h3d.Vector( s2d.width, s2d.height ));
		bmp.addShader( shader );
	}

}

class MainShader extends hxsl.Shader {
	
	static var SRC = {
		@:import h3d.shader.Base2d;
		
		@param var TWO_PI = 6.28318530718;
		@param var iResolution : Vec2;
		
		function fragment() {
			calculatedUV.y = 1 - calculatedUV.y; // Flip y axis
			calculatedUV -= 0.5; // move 0 0 to center of screen
			calculatedUV.x *= iResolution.x / iResolution.y; // remove width height distortion
			
			var st = calculatedUV.xy * 2;
			
			// Number of sides of your shape
			var N = 3;
			
			// Angle and radius from the current pixel
			var a = atan( st.x, st.y ) + PI;
			var r = TWO_PI / float( N );

			// Shaping function that modulate the distance
			var d = cos( floor( .5 + a / r ) * r - a ) * length( st );

			var color = vec3( 1 - smoothstep( .4, .41, d ));

			pixelColor = vec4( color, 1 );

		}
	}
	
	public function new( iResolution:h3d.Vector ) {
		super();
		this.iResolution = iResolution;
	}
}

import haxe.PosInfos;

using haxe.io.Path;

typedef ExamplePluginApi = {
	function hello():Void;
	function stringifyPosition(p:haxe.macro.Expr.Position):String;
	function hijackStaticTest():Void;
}

class Example {
	/** Access plugin API */
	static public var plugin(get,never):ExamplePluginApi;

	static var _plugin:ExamplePluginApi;
	static function get_plugin():ExamplePluginApi {
		if(_plugin == null) {
			try {
				_plugin = eval.vm.Context.loadPlugin(getPluginPath());
			} catch(e:Dynamic) {
				throw 'Failed to load plugin: $e';
			}
		}
		return _plugin;
	}

	static function getPluginPath():String {
		var currentFile = (function(?p:PosInfos) return p.fileName)();
		var srcDir = currentFile.directory().directory();
		return Path.join([srcDir, 'cmxs', Sys.systemName(), 'plugin.cmxs']);
	}
}