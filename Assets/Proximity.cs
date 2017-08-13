using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Proximity : MonoBehaviour {

    private GameObject _playerGameObject;
    private GameObject[] _walls;
    private Renderer[] _renderers;

    private void Start() {
        //Set up references
        _playerGameObject = GameObject.FindWithTag("Player");
        _walls = GameObject.FindGameObjectsWithTag("Wall");
        _renderers = new Renderer[_walls.Length];
        for (int i = 0; i < _walls.Length; i++) {
            _renderers[i] = _walls[i].GetComponent<Renderer>();
        }
    }

    private void Update() {
        foreach (var ren in _renderers) {
            ren.sharedMaterial.SetVector("_PlayerPosition", _playerGameObject.transform.position);  
        }
    }
}
