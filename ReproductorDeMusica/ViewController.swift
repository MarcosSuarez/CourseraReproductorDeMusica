//
//  ViewController.swift
//  ReproductorDeMusica
//
//  Created by Marcos Suarez on 2/9/16.
//  Copyright © 2016 Marcos Suarez. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var labelTitulo: UILabel!
    
    @IBOutlet weak var imagen: UIImageView!
    
    @IBOutlet weak var ruleta: UIPickerView!
    
    let nombreCanciones = ["primera","segunda","tercera","cuarta","quinta","sexta"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Delegado del PickerView
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
    
    @IBAction func shufle(sender: UIButton)
    {
        let posicionActual = ruleta.selectedRowInComponent(0)
        
        var azar = Int(arc4random_uniform(UInt32(nombreCanciones.count)))
        
        // Para minimizar las opciones que se repitan.
        if posicionActual == azar { azar = Int(arc4random_uniform(UInt32(nombreCanciones.count))) }
        
        ruleta.selectRow(azar, inComponent: 0, animated: true)
        
        // PLAY DE LA CANCIÓN:
        print("Canción Nro. \(azar+1) sonando: \(nombreCanciones[azar])")
        // cambio el título.
        labelTitulo.text = nombreCanciones[azar]
        // Muestro el Albúm.
        
        // Suena la canción.
        
    }
    
}

