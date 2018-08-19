
using UnityEngine;
using System.Collections;

[ExecuteInEditMode]
public class MotionBlurFX : MonoBehaviour {

	public Shader blurShader = null;	

	public Material m_Material = null;
	protected Material material {
		get {
			if (m_Material == null) {
				m_Material = new Material(blurShader);
				m_Material.hideFlags = HideFlags.DontSave;
			}
			return m_Material;
		} 
	}
	
	protected void OnDisable() {
		if( m_Material ) {
			DestroyImmediate( m_Material );
		}
	}	
	
	// --------------------------------------------------------
	
	protected void Start()
	{
		// Disable if we don't support image effects
		if (!SystemInfo.supportsImageEffects) {
			enabled = false;
			return;
		}
		// Disable if the shader can't run on the users graphics card
		if (!blurShader || !material.shader.isSupported) {
			enabled = false;
			return;
		}
	}

	void OnRenderImage (RenderTexture source, RenderTexture destination) 
	{		
		if(!blurShader)
			return;

		RenderTexture BufferTex = source;

		Graphics.Blit(source, destination,material);
	}	
}
