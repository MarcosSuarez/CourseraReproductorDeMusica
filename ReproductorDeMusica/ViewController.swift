//
//  ViewController.swift
//  ReproductorDeMusica
//
//  Created by Marcos Suarez on 2/9/16.
//  Copyright © 2016 Marcos Suarez. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var labelTitulo: UILabel!
    
    @IBOutlet weak var imagen: UIImageView!
    
    @IBOutlet weak var ruleta: UIPickerView!
    
    let nombreCanciones = ["primera","segunda","tercera","cuarta","quinta","sexta"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ruleta.delegate = self
    }
    
    //MARK: PickerView RULETA
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        // Cantidad de Columnas.
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // Cantidad de Filas.
        return nombreCanciones.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // Entrega String dependiendo de la fila y columna.
        return nombreCanciones[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("Canción seleccionada: \(nombreCanciones[row])")
    }

    // MARK: VOLUMEN
    @IBAction func volumen(sender: UISlider) {
        print("volumen en \(sender.value * 100)%")
    }
    
    // MARK: BOTONES
    @IBAction func detener(sender: UIButton) {
        print("presionado DETENER")
    }

    @IBAction func tocar(sender: UIButton) {
        print("presionado TOCAR")
    }
    
    @IBAction func pausar(sender: UIButton) {
        print("Presionado PAUSAR")
    }
    
    @IBAction func shufle(sender: UIButton) {
        print("presionado SHUFLE")
    }
    
}

