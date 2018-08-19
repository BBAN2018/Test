Shader "GrayFX"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_Mask("Mask",2D) = "mask" {}
		_Color("Base Color",Color) = (1,1,1,1)
		_LuminosityAmount("GrayAmount",Range(0.0,1.0)) = 1.0
	}
	SubShader
	{
		Cull Off ZWrite Off ZTest Always

		Pass
		{
			CGPROGRAM
			#pragma vertex vert_img
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			float4 _Color;
			sampler2D _MainTex;
			sampler2D _Mask;
			fixed _LuminosityAmount;
			
			fixed4 frag(v2f_img i) : COLOR
			{
				fixed4 renderTex = tex2D(_MainTex, i.uv);
				fixed4 finalColor = lerp(renderTex, Luminance(renderTex.rgb), _LuminosityAmount);
				return finalColor;
			}
			
			ENDCG

		}
	}
}
