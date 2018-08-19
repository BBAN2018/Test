using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class GrayMaskFX : MonoBehaviour
{
    [Range(0,1000)] public float Size = 0;

    void OnDrawGizmosSelected()
    {
         transform.localScale = Vector2.one * Size;
    }
}
