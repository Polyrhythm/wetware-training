Shader "Hidden/VacuumShaders/The Amazing Wireframe/Mobile/Vertex Lit/Cutout/Wire Only" 
{
	Properties 
	{   
		//Tag            
		[V_WIRE_Tag] _V_WIRE_Tag("", float) = 0    
		
		//Rendering Options
		[V_WIRE_RenderingOptions_VertexLit] _V_WIRE_RenderingOptions_VertexLitEnumID("", float) = 0
		
			 
		//Base 
		[HideInInspector] _Color("Color (RGB)", color) = (1, 1, 1, 1)
		[HideInInspector] _MainTex("Base (RGB)", 2D) = "white"{}			
		
		[HideInInspector] _Cutoff("    Alpha cutoff", range(0, 1)) = 0.5

				 
		//Wire Options
		[V_WIRE_Title] _V_WIRE_Title_W_Options("Wire Visual Options", float) = 0  
		
		[Enum(Screen Space,0,Fixed,1)] _V_WIRE_FixedSize("Size", float) = 0
		[V_WIRE_PositiveFloat] _V_WIRE_Size("    Value", Float) = 0.5
		[V_WIRE_HDRColor] _V_WIRE_Color("", color) = (0, 0, 0, 1)
		_V_WIRE_WireTex("Texture (RGB) Trans (A)", 2D) = "white"{}
		[V_WIRE_UVScroll] _V_WIRE_WireTex_Scroll("    ", vector) = (0, 0, 0, 0)
		[Enum(UV0,0,UV1,1)] _V_WIRE_WireTex_UVSet("    UV Set", float) = 0

		//Vertex Color
		[V_WIRE_VertexColor] _V_WIRE_WireVertexColor("Vertex Color", Float) = 0

		//Light
		[V_WIRE_IncludeLight] _V_WIRE_IncludeLightEnumID ("", float) = 0

		//Transparency          
		[V_WIRE_Title]		  _V_WIRE_Transparency_M_Options("Wire Transparency Options", float) = 0  
		[V_WIRE_Transparency] _V_WIRE_TransparencyEnumID("", float) = 0 				
		[HideInInspector]	  _V_WIRE_TransparentTex_Invert("    ", float) = 0
		[HideInInspector]	  _V_WIRE_TransparentTex_Alpha_Offset("    ", Range(-1, 1)) = 0
			
		//Distance Fade  
	    [V_WIRE_DistanceFade]  _V_WIRE_DistanceFade ("Distance Fade", Float) = 0
		[HideInInspector] _V_WIRE_DistanceFadeStart("", Float) = 5
		[HideInInspector] _V_WIRE_DistanceFadeEnd("", Float) = 10 

		//Dynamic Mask
		[V_WIRE_Title]		 _V_WIRE_Title_M_Options("Dynamic Mask Options", float) = 0  
		[V_WIRE_DynamicMask] _V_WIRE_DynamicMaskEnumID("", float) = 0
		[HideInInspector]    _V_WIRE_DynamicMaskInvert("", float) = 0
		[HideInInspector]    _V_WIRE_DynamicMaskEffectsBaseTexEnumID("", int) = 0
		[HideInInspector]    _V_WIRE_DynamicMaskEffectsBaseTexInvert("", float) = 0	
	} 
	    
	Category      
	{
		Tags { "Queue"="AlphaTest" 
		       "IgnoreProjector"="True" 
			   "RenderType"="TransparentCutout" 
			 }    
		LOD 150 
	 
		SubShader  
		{			    
		 
			// Vertex Lit, emulated in shaders (4 lights max, no specular)
			Pass  
			{
				Tags { "LightMode" = "Vertex" }
				Lighting On 

				CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag
				#pragma target 3.0


				#pragma multi_compile_fog


				#ifdef UNITY_PASS_DEFERRED
					#define V_WIRE_LIGHT_ON
				#else
					#pragma shader_feature V_WIRE_LIGHT_OFF V_WIRE_LIGHT_ON
				#endif
				#pragma shader_feature V_WIRE_TRANSPARENCY_OFF V_WIRE_TRANSPARENCY_ON

				#pragma shader_feature V_WIRE_DYNAMIC_MASK_OFF V_WIRE_DYNAMI_MASK_PLANE V_WIRE_DYNAMIC_MASK_SPHERE 

				
				
				#define V_WIRE_CUTOUT 
				#define V_WIRE_CUTOUT_HALF
				#define V_WIRE_SAME_COLOR
				#define V_WIRE_NO_COLOR_BLACK

				#include "../cginc/Wireframe_VertexLit.cginc"
				
				ENDCG
			}
		 
			// Lightmapped 
			Pass 
			{
				Tags { "LightMode" = "VertexLM" }

				CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag
				#pragma target 3.0


				#pragma multi_compile_fog


				#ifdef UNITY_PASS_DEFERRED
					#define V_WIRE_LIGHT_ON
				#else
					#pragma shader_feature V_WIRE_LIGHT_OFF V_WIRE_LIGHT_ON
				#endif
				#pragma shader_feature V_WIRE_TRANSPARENCY_OFF V_WIRE_TRANSPARENCY_ON

				#pragma shader_feature V_WIRE_DYNAMIC_MASK_OFF V_WIRE_DYNAMI_MASK_PLANE V_WIRE_DYNAMIC_MASK_SPHERE 


				#define V_WIRE_LIGHTMAP_ON
				#define V_WIRE_CUTOUT 
				#define V_WIRE_CUTOUT_HALF
				#define V_WIRE_SAME_COLOR
				#define V_WIRE_NO_COLOR_BLACK

				#include "../cginc/Wireframe_VertexLit.cginc"

				 
				ENDCG         
			}    
		     
			// Lightmapped, encoded as RGBM
			Pass 
	 		{
				Tags { "LightMode" = "VertexLMRGBM" }

				CGPROGRAM
				#pragma vertex vert 
				#pragma fragment frag 
				#pragma target 3.0


				#pragma multi_compile_fog 

				#ifdef UNITY_PASS_DEFERRED
					#define V_WIRE_LIGHT_ON
				#else
					#pragma shader_feature V_WIRE_LIGHT_OFF V_WIRE_LIGHT_ON
				#endif
				#pragma shader_feature V_WIRE_TRANSPARENCY_OFF V_WIRE_TRANSPARENCY_ON
				
				#pragma shader_feature V_WIRE_DYNAMIC_MASK_OFF V_WIRE_DYNAMI_MASK_PLANE V_WIRE_DYNAMIC_MASK_SPHERE 
			  

				#define V_WIRE_LIGHTMAP_ON
				#define V_WIRE_CUTOUT 
				#define V_WIRE_CUTOUT_HALF
				#define V_WIRE_SAME_COLOR
				#define V_WIRE_NO_COLOR_BLACK

				#include "../cginc/Wireframe_VertexLit.cginc"
				 
				ENDCG
			}    
			 
			// Pass to render object as a shadow caster
			Pass  
			{ 
				Name "ShadowCaster"
				Tags { "LightMode" = "ShadowCaster" }
		
				CGPROGRAM 
				#pragma vertex vert     
				#pragma fragment frag 
				#pragma multi_compile_shadowcaster 
				#include "UnityCG.cginc"   
				#pragma target 3.0

				#pragma shader_feature V_WIRE_TRANSPARENCY_OFF V_WIRE_TRANSPARENCY_ON

				#pragma shader_feature V_WIRE_DYNAMIC_MASK_OFF V_WIRE_DYNAMI_MASK_PLANE V_WIRE_DYNAMIC_MASK_SPHERE 

			 
				#define V_WIRE_CUTOUT
				#define V_WIRE_CUTOUT_HALF
				#define V_WIRE_NO_COLOR_BLACK

				#include "../cginc/Wireframe_Shadow.cginc" 			
				ENDCG 
			}
		}
	}

	FallBack Off
}
 
