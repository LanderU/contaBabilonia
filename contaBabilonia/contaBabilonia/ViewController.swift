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
    
    func showErrorMessage (titulo : String! , mensage: String!){
        
        let alert: UIAlertController = UIAlertController(title: titulo, message: mensage, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title : "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)

    
    }// End function
    
    
    
    // Función para parar el segue
   override func shouldPerformSegueWithIdentifier(identifier: String , sender: AnyObject!) -> Bool {
    let identifier = "checkTextFields"
    if identifier == "checkTextFields" {
            if (self.nombreUsuario.text!.isEmpty) {
                
                //Mostramos el mensaje de error en una ventana emergente
                showErrorMessage("Error", mensage: "Empty USERNAME")
                
                // Detenemos el segue
                
                return false
            }
                
            else {
         
                return true
            }
        }
        //debug
        //print("Salto aquí")
        return true
    }

    
    // Acción de pulsar el botón de GO
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
        
        } else {
            // Si venimos de pulsar el botón Sign Up registramos el usuario y avanzamos si el usuario no existe y si la contraseña la ha puesto bien las dos veces.
            if(password.text! == repeatTextField.text!){
                    print(password.text!)
                    print(repeatTextField.text!)
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
    
}// Class

