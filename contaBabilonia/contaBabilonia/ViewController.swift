//
//  ViewController.swift
//  contaBabilonia
//
//  Created by Lander on 10/12/15.
//  Copyright © 2015 Lander. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // Cerramos la app
    
    
    @IBAction func salir(sender: UIBarButtonItem) {
    
        exit(0)
        
    }//salir
    
    // Añadimos los controles para hacer que se vean los distintos botones en función de cual pulsemos.
    
    // Referencia al botón Sign In
    @IBOutlet weak var signInButton: UIButton!
    
    // Referencia al botón Sign up
    @IBOutlet weak var signUpButton: UIButton!
    
    // Referencia al stack View que incluye el usuario y el password
    @IBOutlet weak var usernamePassStackView: UIStackView!
    
    // Referencia al text field para repetir el password
    @IBOutlet weak var repeatTextField: UITextField!
    
    // Referencia al botón de acceder
    @IBOutlet weak var goButton: UIButton!
    
    //Ocultamos el botón de sign up al pulsar sign in y mostramos los stack view correspondientes a esta opción
    @IBAction func touchSignIn(sender: UIButton) {
        // Ocultamos el botón
        signUpButton.hidden = true
        // Mostramos el stack view oculto por defecto al iniciar la app
        usernamePassStackView.hidden = false
        // Mostramos el botón para ingresar
        goButton.hidden = false
    } //touch sign in
    // Método que hace lo mismo que el anterior pero enseñamos además el textField repetir para que agregue de nuevo el password.
    @IBAction func touchSignUp(sender: UIButton) {
        // Ocultamos el botón
        signInButton.hidden = true
        // Mostramos el stack view oculto por defecto al iniciar la app
        usernamePassStackView.hidden = false
        // Text Field repetir
        repeatTextField.hidden = false
        // Mostramos el botón para ingresar
        goButton.hidden = false
        
    } //touch sign up
    
}// Class

