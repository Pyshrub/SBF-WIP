using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DestroyOverTime : MonoBehaviour
{

    public float deathTimer = 2.0f;
    // Start is called before the first frame update
    void Start()
    {
        StartCoroutine(Delet());
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    IEnumerator Delet()
    {
        yield return new WaitForSeconds(deathTimer);
        Destroy(this.gameObject);
    }
}
