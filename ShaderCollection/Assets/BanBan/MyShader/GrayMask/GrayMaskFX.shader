Shader "Ban/GrayMaskFX" {
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_Color("Color",Color) = (0,0,0,0)
		_MaskTex("Mask",2D) = "mask"{}
		_GrayAmount("GrayAmount",Range(0,1)) = 1
	}

		SubShader
		{
			Tags{ "Queue" = "Overlay" 
			"RenderType" = "Transparent"}

			Cull Off
			Lighting Off
			ZWrite Off
			Blend SrcAlpha OneMinusSrcAlpha
			GrabPass{"_GrabTex"}

			LOD 100

			Pass
			{
				CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag

				#include "UnityCG.cginc"

			float _GrayAmount;
			float4 _Color;
			sampler2D _GrabTex;
			sampler2D _MainTex;
			sampler2D _MaskTex;
			float4 _GrabTexture_TexelSize;

			struct appdata
			{
				fixed4 vertex : POSITION;
				fixed4 uv : TEXCOORD0;
				float4 color : COLOR;
			};

			struct v2f
			{
				fixed4 vertex : SV_POSITION;
				fixed4 uv : TEXCOORD0;
				fixed4 uvs : TEXCOORD1;
				float4 color : COLOR;
			};

			v2f vert(appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = ComputeScreenPos(o.vertex);
				o.uv.zw = v.uv.zw;
				o.uvs = v.uv;
				return o;
			}

			fixed4 frag(v2f i) : COLOR
			{
				fixed4 uv = i.uv;
				fixed4 col = tex2D(_GrabTex, uv);
				col.rgb = lerp(col.rgb, Luminance(col.rgb), _GrayAmount);
				col *= _Color;
				fixed4 mask = tex2D(_MaskTex, i.uvs);
				col.a = mask.a;

				return col;
			}

			ENDCG
		}
	}
}
