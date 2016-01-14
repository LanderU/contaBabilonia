//
//  ViewController.swift
//  contaBabilonia
//
//  Created by Lander on 10/12/15.
//  Copyright © 2015 Lander. All rights reserved.
//

import UIKit

import Parse

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
    
    //Referencia al textField para quedarnos con el nombre de usuario
    @IBOutlet weak var nombreUsuario: UITextField!
    // Referencia al passord
    @IBOutlet weak var password: UITextField!
    
    // Variable para saber de que botón venimos 
    var flagButton : Bool = true

    
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
        // Le cambiamos el valor a la variable para poder hacer el registro
        flagButton = false
        
    } //touch sign up
    
    //Función mensaje de error
    
    func showErrorMessage (mensage: String!){
        
        let alert: UIAlertController = UIAlertController(title: "ERROR", message: mensage, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title : "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)

    
    }// End function

    
     // Acción de pulsar el botón de GO
    
    @IBAction func touchGo(sender: UIButton) {
        let usuario = PFUser()
        if (flagButton) {
            // venimos del botón sign in por lo tanto hacemos las comprobaciones para este botón
            // USERNAME --> EMPTY
            // PASSWORD --> EMPTY
            // OBJETO NO ESTÁ EN PARSE
            
            // Comprobación del nombreUsuario vacio
            if (nombreUsuario.text!.isEmpty){
                
                // Mensaje de alerta
                
                showErrorMessage("Empty USERNAME")
                
                
            } // end if
            
            // Comprobación password vacio
            if(password.text!.isEmpty){
                // Mensaje de alerta
                
                showErrorMessage("Empty PASSWORD")
                
                
            } // end if
            
            // Comprobación de si encontramos el objeto en Parse
            PFUser.logInWithUsernameInBackground(nombreUsuario.text!, password:password.text!) {
                (user: PFUser?, error: NSError?) -> Void in
                if user != nil {
                    // Encontramos al usuario
                    // Forzamos el segue
                 self.performSegueWithIdentifier("salto", sender: nil)
                    
                }else{
                    // No encontramos
                    self.showErrorMessage("Bad User/Login")
                    
                }// end if
                
                
            } // end loginWith...
            
            
        } else {
            // Comprobamos lo siguiente
            // USERNAME --> EMPTY
            // PASSWORD --> EMPTY
            // SECONDPASS --> EMPTY
            // PASSWORD != REPEATPASSWORD
            // USUARIO YA EN PARSE
            // Comprobación del nombreUsuario vacio
            
            //Comprobación nombre de usuario
            if (nombreUsuario.text!.isEmpty){
                
                // Mensaje de alerta
                
                showErrorMessage("Empty USERNAME")
                
                // Detenemos el segue
                
                
            } // end if
            
            // Comprobación password vacio
            if(password.text!.isEmpty){
                // Mensaje de alerta
                
                showErrorMessage("Empty PASSWORD")
                
                // Detenemos el segue
                
                
            } // end if
            
            // Comprobación repeatPassword vacio
            
            if(repeatTextField.text!.isEmpty){
                
                // Mensaje de alerta
                
                showErrorMessage("Please repeat your password")
                
                // Detenemos el segue
                
                
            } // end if
            
            if (password.text! != repeatTextField.text!){
                // Contraseñas no coinciden
                
                showErrorMessage("Please, fill with the same password")
                
                // Detenemos el segue
                
                
            } else {
                // Comprobamos en parse que si el usuario existe ya
                PFUser.logInWithUsernameInBackground(nombreUsuario.text!, password:password.text!) {
                    (user: PFUser?, error: NSError?) -> Void in
                    if user != nil {
                        // Error el usuario ya lo tenemos en nuestro server
                        self.showErrorMessage("The user is already registered")
                    } else {
                        // The login failed. Check error to see why.
                        usuario.username = self.nombreUsuario.text!
                        usuario.password = self.password.text!
                        // Forzamos el segue
                        self.performSegueWithIdentifier("salto", sender: nil)

                        usuario.signUpInBackgroundWithBlock {
                            (succeeded: Bool, error: NSError?) -> Void in
                            if let error = error {
                                let _ = error.userInfo["error"] as? NSString
                                // Show the errorString somewhere and let the user try again.
                                self.showErrorMessage("Unexpected Error")
                            } // End if
                            
                        }// end signUpIn...
                        
                    }// End if
                } // end loginwith...
                
            } // end if comprobar contraseñas
            
            
        } //end if flagButton
    }// en touchGo
    
   

    
    
    // Función para parar el segue.    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject!) -> Bool {
       // El segue está parado a no ser que lo forcemos
        return false
    } // end function

    
}// Class

