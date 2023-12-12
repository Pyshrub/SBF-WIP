using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class DamageTest : MonoBehaviour
{
    public Camera mainCam;
    public GameObject target;
    public int damageTaken;
    public int currentDamage;

    public Text damageDisplay;
    public GameObject hitEffect;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        damageDisplay.text = ("Total damage: " + damageTaken + "\nLatest hit: " + currentDamage);
        var bottomLeft = mainCam.ScreenToWorldPoint(new Vector2(50, 0));
        var topRight = mainCam.ScreenToWorldPoint(new Vector2((mainCam.pixelWidth * 1.5f) - 100, mainCam.pixelHeight * 1.5f));

        var cameraRect = new Rect(
            bottomLeft.x,
            bottomLeft.y,
            topRight.x,
            topRight.y);
        transform.position = new Vector2(Mathf.Clamp(transform.position.x, cameraRect.xMin, cameraRect.xMax), Mathf.Clamp(transform.position.y, cameraRect.yMin, cameraRect.yMax));

        if (transform.position.x < target.transform.position.x)
        {
            transform.rotation = new Quaternion(transform.rotation.x, 0, transform.rotation.z, transform.rotation.w);
        }
        else
        {
            transform.rotation = new Quaternion(transform.rotation.x, 180, transform.rotation.z, transform.rotation.w);
        }
    }

    private void OnTriggerEnter2D(Collider2D other)
    {
        if(other.gameObject.tag == "weakPunch")
        {
            Debug.Log("Ow");
            Instantiate(hitEffect, other.transform.position, Quaternion.identity);
            GetComponent<Rigidbody2D>().AddForce(Vector2.up * other.GetComponent<DamageCalc>().knockback * 10);
            GetComponent<Rigidbody2D>().AddForce(-transform.right * other.GetComponent<DamageCalc>().knockback * 20);
            damageTaken += other.GetComponent<DamageCalc>().damage;
            currentDamage = other.GetComponent<DamageCalc>().damage;
        }
    }
}
