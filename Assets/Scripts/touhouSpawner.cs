using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class touhouSpawner : MonoBehaviour
{

    public GameObject bullet;
    bool active = true;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        if (active)
        {
            StartCoroutine(SpawnBullets());
        }
    }

    IEnumerator SpawnBullets()
    {
        active = false;
        for (int i = 0; i < 3; i++)
        {
            Instantiate(bullet, transform.position, Quaternion.Euler(0, 0, 0));
            Instantiate(bullet, transform.position, Quaternion.Euler(0, 0, 15));
            Instantiate(bullet, transform.position, Quaternion.Euler(0, 0, 30));
            yield return new WaitForSeconds(.25f);
        }
        yield return new WaitForSeconds(1f);
        for (int i = 0; i < 3; i++)
        {
            Instantiate(bullet, transform.position, Quaternion.Euler(0, 0, -5));
            Instantiate(bullet, transform.position, Quaternion.Euler(0, 0, 10));
            Instantiate(bullet, transform.position, Quaternion.Euler(0, 0, 25));
            Instantiate(bullet, transform.position, Quaternion.Euler(0, 0, 40));
            yield return new WaitForSeconds(.25f);
        }
        yield return new WaitForSeconds(1f);
        Instantiate(bullet, transform.position, Quaternion.Euler(0, 0, 0));
        Instantiate(bullet, transform.position, Quaternion.Euler(0, 0, 15));
        Instantiate(bullet, transform.position, Quaternion.Euler(0, 0, 30));
        Instantiate(bullet, transform.position, Quaternion.Euler(0, 0, -5));
        Instantiate(bullet, transform.position, Quaternion.Euler(0, 0, 10));
        Instantiate(bullet, transform.position, Quaternion.Euler(0, 0, 25));
        Instantiate(bullet, transform.position, Quaternion.Euler(0, 0, 40));
        yield return new WaitForSeconds(1f);
        active = true;
    }
}
