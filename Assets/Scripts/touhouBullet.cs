using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class touhouBullet : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void FixedUpdate()
    {
        transform.Translate(transform.right * -7 * Time.deltaTime);
    }
}
