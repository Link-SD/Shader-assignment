Shader "SD/Real Wall" {
	Properties{
		_MainTex("Base (RGB)", 2D) = "white" {} 
	    _PlayerPosition("Player Position", vector) = (0,0,0,0) 
		_VisibleDistance("Visibility Distance", float) = 10.0

	}
		SubShader{
		Tags{ "RenderType" = "Transparent" "Queue" = "Transparent" }
			Pass{
			Blend SrcAlpha OneMinusSrcAlpha
			LOD 200

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			uniform sampler2D _MainTex;
			uniform float4 _PlayerPosition;
			uniform float _VisibleDistance;

			struct vertexInput {
				float4 vertex : POSITION;
				float4 texcoord : TEXCOORD0;
			};
			struct vertexOutput {
				float4 pos : SV_POSITION;
				float4 position_in_world_space : TEXCOORD0;
				float4 tex : TEXCOORD1;
			};

			vertexOutput vert(vertexInput input)
			{
				vertexOutput output;
				output.pos = UnityObjectToClipPos(input.vertex);
				output.position_in_world_space = mul(unity_ObjectToWorld, input.vertex);
				output.tex = input.texcoord;
				return output;
			}

			float4 frag(vertexOutput input) : COLOR
			{
				float dist = distance(input.position_in_world_space, _PlayerPosition);

				if (dist < _VisibleDistance) {
					return tex2D(_MainTex, float4(input.tex)); // Visible
				}
				else {
					float4 tex = tex2D(_MainTex, float4(input.tex)); 
					tex.a = 0.0;
					return tex;
				}
			}
			ENDCG
		}
	}
}