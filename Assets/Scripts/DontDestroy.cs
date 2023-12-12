using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class DontDestroy : MonoBehaviour
{
    AudioSource mySource;
    // Start is called before the first frame update
    void Start()
    {
        DontDestroyOnLoad(this);
        mySource = GetComponent<AudioSource>();
    }

    // Update is called once per frame
    void Update()
    {
        Debug.Log(SceneManager.GetActiveScene().name);
        if (SceneManager.GetActiveScene().name == "TitleScreen" || SceneManager.GetActiveScene().name == "MainMenu")
        {
            if (!mySource.isPlaying)
            {
                mySource.Play();
            }
        }
        else
        {
            mySource.Stop();
        }
    }
}
