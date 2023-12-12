using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;

public class PlayerControl : MonoBehaviour
{
    public bool grounded;
    bool crouching;
    public int jumpHeight = 650;  // Character jump height, defaults to 650
    public int maxPlayerSpeed = 10;
    int playerSpeed = 10;
    public GameObject target;
    public Camera mainCam;
    public bool damaged;
    public bool coolingDown;
    public GameObject hitEffect;
    public GameObject ally;

    public string playerHorizontal;
    public string playerVertical;
    public string playerPunch;
    public string playerStrongPunch;
    public string playerJump;
    public string playerPunchType;
    public string playerGuard;
    public string otherPlayer;
    public string playerUI;
    public string helpUI;
    public string strongUI;
    public string playerHelper;
    public string superAmountUI;
    public string playerSpecial;
    public string playerIconUI;

    public Slider healthUI;
    public Slider helperUI;
    public Slider superUI;
    Image iconUI;
    public Sprite iconSprite;

    public int maxHealth = 500;
    public int health = 500;
    public int helperTimer = 500;
    Animator anim;
    public int currentCharge = 0;
    public int superAmount = 0;
    public Animator superMeter;

    public float cooldown = 0.5f;
    public bool attacking;
    public bool guarding;
    public bool coolingGuard;

    public float rayAmount = 0.9f;

    [SerializeField] bool isDemo = true;

    float hitstun = 0.5f;
    // Start is called before the first frame update
    void Start()
    {
        anim = GetComponent<Animator>();
        health = maxHealth;
        target = GameObject.FindGameObjectWithTag(otherPlayer);
        mainCam = GameObject.FindGameObjectWithTag("MainCamera").GetComponent<Camera>();
        healthUI = GameObject.FindGameObjectWithTag(playerUI).GetComponent<Slider>();
        helperUI = GameObject.FindGameObjectWithTag(helpUI).GetComponent<Slider>();
        superUI = GameObject.FindGameObjectWithTag(strongUI).GetComponent<Slider>();
        superMeter = GameObject.FindGameObjectWithTag(superAmountUI).GetComponent<Animator>();
        iconUI = GameObject.FindGameObjectWithTag(playerIconUI).GetComponent<Image>();
    }

    // Update is called once per frame
    void Update()
    {
        iconUI.sprite = iconSprite;
        superMeter.SetInteger("amount", superAmount);
        anim.SetInteger("superAmount", superAmount);
        if(helperTimer > 500)
        {
            helperTimer = 500;
        }
        healthUI.value = health;
        healthUI.maxValue = maxHealth;
        helperUI.value = helperTimer;
        helperUI.maxValue = 500;
        superUI.value = currentCharge;
        superUI.maxValue = 200;
        if(superAmount == 3)
        {
            currentCharge = 200;
        }
        if(currentCharge >= 200)
        {
            if (superAmount < 3)
            {
                superAmount += 1;
                currentCharge = 0;
            }
            else
            {
                currentCharge = 200;
            }
        }

        if (attacking)
        {
            GetComponent<Rigidbody2D>().velocity = new Vector2(0, GetComponent<Rigidbody2D>().velocity.y);
        }
        else
        {
            playerSpeed = maxPlayerSpeed;
        }

        var bottomLeft = mainCam.ScreenToWorldPoint(Vector2.zero);
        var topRight = mainCam.ScreenToWorldPoint(new Vector2(mainCam.pixelWidth * 1.5f, mainCam.pixelHeight));

        var cameraRect = new Rect(
            bottomLeft.x,
            bottomLeft.y,
            topRight.x,
            topRight.y + 5);
        transform.position = new Vector2(Mathf.Clamp(transform.position.x, cameraRect.xMin, cameraRect.xMax), Mathf.Clamp(transform.position.y, cameraRect.yMin, cameraRect.yMax));
        if (health > 0)
        {
            if (transform.position.x < target.transform.position.x)
            {
                transform.rotation = new Quaternion(transform.rotation.x, 0, transform.rotation.z, transform.rotation.w);
            }
            else
            {
                transform.rotation = new Quaternion(transform.rotation.x, 180, transform.rotation.z, transform.rotation.w);
            }
            if (!damaged)
            {
                if(helperTimer == 500 && Input.GetButtonDown(playerHelper))
                {
                    Instantiate(ally, new Vector2(transform.position.x, transform.position.y - 2), transform.rotation);
                    helperTimer = 0;
                }
                if (Input.GetAxis(playerVertical) > 0)
                {
                    anim.SetBool("facingUp", true);
                }
                else
                {
                    anim.SetBool("facingUp", false);
                }
                if (Input.GetButtonDown(playerJump) && grounded && !attacking)
                {
                    GetComponent<Rigidbody2D>().AddForce(Vector2.up * jumpHeight);
                }

                if (!coolingDown && !attacking)
                {
                    if (Input.GetButtonDown(playerPunch))
                    {
                        StartCoroutine(Punch());
                        StartCoroutine(Cool());
                    }else if (Input.GetButtonDown(playerStrongPunch))
                    {
                        StartCoroutine(StrongPunch());
                        StartCoroutine(Cool());
                    }else if (Input.GetButtonDown(playerSpecial) && superAmount > 0 && grounded)
                    {
                        if(superAmount == 3)
                        {
                            currentCharge = 0;
                        }
                        superAmount -= 1;
                        StartCoroutine(Super());
                        StartCoroutine(Cool());
                    }
                }

                if (!coolingDown && !coolingGuard)
                {
                    if (Input.GetButtonDown(playerGuard))
                    {
                        StartCoroutine(Guard());
                        StartCoroutine(GuardCool());
                    }
                }

                if (Input.GetAxis(playerVertical) < 0)
                {
                    anim.SetBool("crouching", true);
                    crouching = true;
                }
                else
                {
                    anim.SetBool("crouching", false);
                    crouching = false;
                }

                if (grounded)
                {
                    anim.SetBool("jumping", false);
                }
                else
                {
                    anim.SetBool("jumping", true);
                }
                if (!crouching || crouching && !grounded)
                {
                    if (Input.GetAxis(playerHorizontal) != 0)
                    {
                        anim.SetBool("walking", true);
                    }
                    else
                    {
                        anim.SetBool("walking", false);
                    }
                    if (!attacking)
                    {
                        GetComponent<Rigidbody2D>().velocity = new Vector2(Input.GetAxis(playerHorizontal) * playerSpeed, GetComponent<Rigidbody2D>().velocity.y);
                    }
                }
            }
        }
        else
        {
            health = 0;
            anim.SetBool("dead", true);
            if (isDemo)
            {
                StartCoroutine(endDemo());
            }
        }
        RaycastHit2D groundCheck = Physics2D.Raycast(new Vector2(transform.position.x, transform.position.y + rayAmount), Vector2.down, 1f, 1);
        if (groundCheck && groundCheck.transform.tag == "ground")
        {
            grounded = true;
        }
        else
        {
            grounded = false;
        }
    }
    IEnumerator Punch()
    {
        anim.SetBool("punchWeak", true);
        yield return new WaitForSeconds(0.001f);
        anim.SetBool("punchWeak", false);
    }

    IEnumerator StrongPunch()
    {
        anim.SetBool("punchStrong", true);
        yield return new WaitForSeconds(0.001f);
        anim.SetBool("punchStrong", false);
    }

    IEnumerator Super()
    {
        anim.SetBool("super", true);
        yield return new WaitForSeconds(0.001f);
        anim.SetBool("super", false);
    }

    IEnumerator Cool()
    {
        yield return new WaitForSeconds(0.001f);
        coolingDown = true;
        yield return new WaitForSeconds(cooldown);
        coolingDown = false;
    }

    IEnumerator hurt()
    {
        damaged = true;
        anim.SetBool("hurt", true);
        yield return new WaitForSeconds(hitstun);
        anim.SetBool("hurt", false);
        damaged = false;
    }

    IEnumerator endDemo()
    {
        yield return new WaitForSeconds(3f);
        SceneManager.LoadScene("TitleScreen");
    }

    private void OnTriggerEnter2D(Collider2D other)
    {
        if (other.gameObject.tag == playerPunchType && health > 0 && !guarding)
        {
            hitstun = other.GetComponent<DamageCalc>().hitstun;
            if (helperTimer < 500)
            {
                helperTimer += 25;
            }
            StartCoroutine(hurt());
            Instantiate(hitEffect, other.transform.position, Quaternion.identity);
            GetComponent<Rigidbody2D>().velocity = Vector2.zero;
            GetComponent<Rigidbody2D>().AddForce(Vector2.up * other.GetComponent<DamageCalc>().knockback * 10);
            GetComponent<Rigidbody2D>().AddForce(-transform.right * other.GetComponent<DamageCalc>().knockback * 20);
            health -= other.GetComponent<DamageCalc>().damage;
        }else if (other.gameObject.tag == playerPunchType && health > 0 && guarding)
        {
            Instantiate(hitEffect, other.transform.position, Quaternion.identity);
            currentCharge += 20;
        }
    }

    IEnumerator Guard()
    {
        anim.SetBool("shielding", true);
        yield return new WaitForSeconds(0.001f);
        anim.SetBool("shielding", false);
    }

    IEnumerator GuardCool()
    {
        coolingGuard = true;
        yield return new WaitForSeconds(0.75f);
        coolingGuard = false;
    }
}
