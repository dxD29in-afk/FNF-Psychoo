package shaders;

import flixel.system.FlxAssets.FlxShader;

class RetroShader extends FlxShader
{
	@:glFragmentSource('
		#pragma header
		void main()
		{
			vec2 uv = openfl_TextureCoordv;
			vec4 col = texture2D(bitmap, uv);
			float line = sin(uv.y * 240.0 * 6.28318) * 0.5 + 0.5;
			col.rgb *= 0.88 + 0.12 * line;
			vec2 d = uv - 0.5;
			col.rgb *= 1.0 - dot(d, d) * 0.8;
			gl_FragColor = col;
		}
	')
	public function new() { super(); }
}