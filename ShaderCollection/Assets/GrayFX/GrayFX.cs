using System.Collections;
using UnityEngine;

[ExecuteInEditMode]
public class GrayFX : MonoBehaviour {

	public Shader m_Shader;
	public Material mat;
	public Material m_Mat
	{
		get
		{
			if(!mat)
			{
				mat = new Material(m_Shader);
			}
			return mat;
		}
	}
	[Range(0,1)]public float GrayAmount = 1;

	void OnRenderImage(RenderTexture src, RenderTexture dest)
	{
		if(m_Mat)
		{
			m_Mat.SetFloat("_LuminosityAmount",GrayAmount);
			Graphics.Blit(src,dest,m_Mat);
		}
	}
}
