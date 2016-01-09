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
/*
    @IBAction func touchGo(sender: UIButton) {
        
        // Creamos la constante para el usuario.
        let usuario = PFUser()
        //En función de que botón vengamos el botón go se comportará de una manera o de otra.
        if (flagButton){
            // Venimos del botón sign in, por lo tanto comprobamos que el usuario está en Parse
            PFUser.logInWithUsernameInBackground(nombreUsuario.text!, password:password.text!) {
                (user: PFUser?, error: NSError?) -> Void in
                if user != nil {
                    // Tenemos al usuario por lo tanto avanzamos al tableView
                } else {
                    // Mostramos el mensaje de error en un textLabel?
                
                                                   }
            }
    // done
        
        } else {
            // Si venimos de pulsar el botón Sign Up registramos el usuario y avanzamos si el usuario no existe y si la contraseña la ha puesto bien las dos veces.
            if(password.text! == repeatTextField.text!){
                PFUser.logInWithUsernameInBackground(nombreUsuario.text!, password:password.text!) {
                    (user: PFUser?, error: NSError?) -> Void in
                    if user != nil {
                        // Error el usuario ya lo tenemos en nuestro server
                        print("El usuario ya está creado")
                    } else {
                        // The login failed. Check error to see why.
                        usuario.username = self.nombreUsuario.text!
                        usuario.password = self.password.text!
                        usuario.signUpInBackgroundWithBlock {
                            (succeeded: Bool, error: NSError?) -> Void in
                            if let error = error {
                                let _ = error.userInfo["error"] as? NSString
                                // Show the errorString somewhere and let the user try again.
                                print("No se puede registrar el usuario")
                            } else{
                                print("Pasamos al tableview")
                            } // End if
                            
                        }// signUp
                        
                    }// End if
                }
            }else {
               print("Contraseñas no coinciden")
            }//end if
        }// end if
        
    }// touch GO
*/
    
    
    // Función para parar el segue hacemos las comprobaciones dentro de la función.
    
   override func shouldPerformSegueWithIdentifier(identifier: String , sender: AnyObject!) -> Bool {
        // Constante para hacer las comprobaciones en Parse
        let usuario = PFUser()
        let identifier = "checkTextFields"
        
        if identifier == "checkTextFields" {
            if (flagButton) {
                // venimos del botón sign in por lo tanto hacemos las comprobaciones para este botón
                // USERNAME --> EMPTY
                // PASSWORD --> EMPTY
                // OBJETO NO ESTÁ EN PARSE
                
                // Comprobación del nombreUsuario vacio
                if (nombreUsuario.text!.isEmpty){
                    
                    // Mensaje de alerta
                    
                    showErrorMessage("Empty USERNAME")
                    
                    // Detenemos el segue
                    
                    return false
                    
                } // end if
                
                // Comprobación password vacio
                if(password.text!.isEmpty){
                    // Mensaje de alerta
                    
                    showErrorMessage("Empty PASSWORD")
                    
                    // Detenemos el segue
                    
                    return false
                    
                } // end if
                
                // Comprobación de si encontramos el objeto en Parse
                // Flag para saber si devuelve objeto o no parse
                var avanzar: Bool = true
                
                PFUser.logInWithUsernameInBackground(nombreUsuario.text!, password:password.text!) {
                    (user: PFUser?, error: NSError?) -> Void in
                    if user == nil {
                        // No encontramos el usuario.
                        avanzar = false
                    } // end if
               
                } // end loginWith...
                
                // Comprobamos para avanzar al tableView o cortar
                if (avanzar) {
                    return true
                }else {
                    showErrorMessage("User NOT registered/bad login")
                    return false
                } // end if
                
            
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
                    
                    return false
                    
                } // end if
                
                // Comprobación password vacio
                if(password.text!.isEmpty){
                    // Mensaje de alerta
                    
                    showErrorMessage("Empty PASSWORD")
                    
                    // Detenemos el segue
                    
                    return false
                    
                } // end if
                
                // Comprobación repeatPassword vacio
                
                if(repeatTextField.text!.isEmpty){
                    
                    // Mensaje de alerta
                    
                    showErrorMessage("Please repeat your password")
                    
                    // Detenemos el segue
                    
                    return false
                
                } // end if
                
                if (password.text! != repeatTextField.text!){
                    // Contraseñas no coinciden
                    
                    showErrorMessage("Please, fill with the same password")
                    
                    // Detenemos el segue
                    
                    return false
                
                } else {
                    
                    // Comprobamos si el objeto ya exite en parse
                    var seguir1 : Bool = true
                    var seguir2 : Bool = true
                    PFUser.logInWithUsernameInBackground(nombreUsuario.text!, password:password.text!) {
                        (user: PFUser?, error: NSError?) -> Void in
                        if user != nil {
                            // Error el usuario ya lo tenemos en nuestro server
                           seguir1 = false
                        } else {
                            // The login failed. Check error to see why.
                            usuario.username = self.nombreUsuario.text!
                            usuario.password = self.password.text!
                            usuario.signUpInBackgroundWithBlock {
                                (succeeded: Bool, error: NSError?) -> Void in
                                if let error = error {
                                    let _ = error.userInfo["error"] as? NSString
                                    // Show the errorString somewhere and let the user try again.
                                    seguir2 = false
                                } // End if
                                
                            }// end signUpIn...
                            
                        }// End if
                    } // end loginwith...
                    
                    // Comprobación de si el usuario ya está en parse
                    if(!seguir1){
                        // Mostramos menaje de error
                        
                        showErrorMessage("The user is already registered")
                        // Paramos el segue
                        
                        return false
                    }// end if
                    
                    // Comprobación de si por algún motivo no se ha podido registrar el usuario
                    if(!seguir2){
                        // Error inesperado?
                        showErrorMessage("Unexpected error")
                        return false
                        
                    } // end if
                
                } // end if comprobar contraseñas

            
            } //end if flagButton
     
            
        } // end if
        
        // Transición normal al tableView
        
        return true
        
    } // end function
    
}// Class

