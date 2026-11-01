package shaders;

import flixel.system.FlxAssets.FlxShader;

class FilmShader extends FlxShader
{
	@:glFragmentSource('
		#pragma header
		uniform float uTime;

		float hash(vec2 p)
		{
			p = fract(p * vec2(123.34, 456.21));
			p += dot(p, p + 45.32);
			return fract(p.x * p.y);
		}

		void main()
		{
			float t = mod(floor(uTime * 24.0), 100.0);
			vec2 uv = openfl_TextureCoordv;

			uv.y += (hash(vec2(t, 1.0)) - 0.5) * 0.003;
			uv.x += (hash(vec2(t, 2.0)) - 0.5) * 0.002;

			vec3 col = texture2D(bitmap, uv).rgb;

			float g = dot(col, vec3(0.299, 0.587, 0.114));
			vec3 sepia = vec3(g * 1.1, g * 0.95, g * 0.78);
			col = mix(col, sepia, 0.35);

			vec2 gp = floor(uv * vec2(480.0, 270.0));
			col += (hash(gp + t * 1.37) - 0.5) * 0.14;

			vec2 dg = uv * vec2(70.0, 40.0);
			vec2 id = floor(dg);
			vec2 f = fract(dg) - 0.5;
			float dust = step(0.9975, hash(id + t * 0.73)) * smoothstep(0.18, 0.0, length(f));
			col = mix(col, vec3(1.0), dust * 0.8);

			float sx = hash(vec2(t, 3.0));
			float sOn = step(0.65, hash(vec2(t, 4.0)));
			float sy = hash(vec2(t, 5.0));
			float scratch = smoothstep(0.0018, 0.0, abs(uv.x - sx)) * step(abs(uv.y - sy), 0.35) * sOn;
			col += scratch * 0.35;

			col *= 1.0 + (hash(vec2(t, 6.0)) - 0.5) * 0.08;

			vec2 d = uv - 0.5;
			col *= 1.0 - dot(d, d) * 0.9;

			gl_FragColor = vec4(col, 1.0);
		}
	')
	public function new() { super(); }
}
