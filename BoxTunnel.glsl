#ifdef GL_ES
precision mediump float;
#endif

uniform float time;
uniform vec2 mouse;
uniform vec2 resolution;

#define HorizontalAmplitude		0.75
#define VerticleAmplitude		0.76
#define HorizontalSpeed			0.90
#define VerticleSpeed			0.50




vec3 chess( vec2 uv, vec2 pp )
{
    vec2 p = floor( uv * 4.6 + uv/4.7 + uv + 5.9 + (uv-1.01) );
    float t = mod( p.x - p.y + sin(p.x+p.y), 5.);
    vec3 c = vec3(t+pp.x, t+pp.y, t+(pp.x+pp.y));

    return c;
}

vec3 tube( vec2 p, float scrollSpeed, float rotateSpeed )
{    
    float a = 2.0 * atan( p.y, p.x  );
    float po = .5;
    float px = pow( p.x*p.x, po );
    float py = pow( p.y*p.y, po );
    float r = pow( px + py, 1.0/(2.0*po) );    
    vec2 uvp = vec2( 1.0/r + (time*scrollSpeed), a + (time*rotateSpeed));	
    vec3 finalColor = chess( uvp, p ).xyz;
    finalColor *= r;

    return finalColor;
}



void main(void)
{
    vec2 uv = gl_FragCoord.xy / resolution.xy;
    float timeSpeedX = sin(time) * 3.3;
    float timeSpeedY = cos(time) * 2.2;
    vec2 p = uv + vec2( -0.50+cos(timeSpeedX)*.3, -0.5+sin(timeSpeedY)*.3 );

    vec3 finalColor = tube( p , 1.0, 0.0);


    timeSpeedX = time * 0.30001;
    timeSpeedY = time * 0.20001;
    p = uv + vec2( -0.50+cos(timeSpeedX)*0.2, -0.5-sin(timeSpeedY)*0.3 );
    
	
	
	
    gl_FragColor = vec4( finalColor, 1.0 );
}
