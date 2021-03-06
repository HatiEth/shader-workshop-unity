﻿Shader "Workshop/WorkshopSurfaceShader" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_SecondaryTex ("Secondary Texture (RGB)", 2D) = "white" {}

		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		_Metallic ("Metallic", Range(0,1)) = 0.0

		_TexBlend ("Texture Blending", Range(0, 1)) = 0.0
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;
		sampler2D _SecondaryTex;

		struct Input {
			float2 uv_MainTex;
		};

		half _Glossiness;
		half _Metallic;
		half _TexBlend;

		fixed4 _Color;

		void surf (Input IN, inout SurfaceOutputStandard o) {
			fixed4 mainTex = tex2D (_MainTex, IN.uv_MainTex) * _Color; // Sample Main Texture @uv_MainTex
			fixed4 secTex = tex2D (_SecondaryTex, IN.uv_MainTex) * _Color; // Sample Secondary Texture @uv_MainTex

			o.Albedo = lerp(mainTex.rgb, secTex.rgb, _TexBlend);
			// Metallic and smoothness come from slider variables
			o.Metallic = _Metallic;
			o.Smoothness = _Glossiness;
			o.Alpha = mainTex.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
