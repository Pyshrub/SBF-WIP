using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;

public class MainMenu : MonoBehaviour
{
    public Button fight;
    public Button adventure;
    public Button options;
    public Button extras;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {

    }

    public void extras_clicked()
    {
        SceneManager.LoadScene("ExtrasMenu");
    }

    public void fight_clicked()
    {
        SceneManager.LoadScene("SampleScene"); // REMEMBER: sends player to demo scene
    }
}
