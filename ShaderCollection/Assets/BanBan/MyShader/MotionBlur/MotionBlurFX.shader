Shader "Ban/MotionBlurFX" 
{
	Properties 
	{
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("MainTex", 2D) = "white" {}
		_MaskAmount("MaskAmount" , Range(0,1)) = 0
	}
	SubShader 
	{
		Tags {"Queue" = "Transparent" "RenderType"="Transparent" }
		LOD 300

		Cull Off
		Zwrite Off
		Blend SrcAlpha OneMinusSrcAlpha
		Pass
		{
		CGPROGRAM
	
		#pragma vertex vert_img
		#pragma fragment frag
		#include "UnityCG.cginc"

		float _MaskAmount;
		fixed4 _Color;
		sampler2D _MainTex;

		fixed4 frag(v2f_img i) : COLOR
		{
			fixed4 Col = tex2D(_MainTex,i.uv);
			fixed4 FinalCol = Col * _Color;

			if((FinalCol.r + FinalCol.g + FinalCol.b)/3 < _MaskAmount)
			{
				return fixed4(1,0,0,1);
				discard;
			}

			return FinalCol;
		}

		ENDCG
	}
	}
	FallBack "Diffuse"
}
