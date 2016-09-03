//
//  ViewController.swift
//  ReproductorDeMusica
//
//  Created by Marcos Suarez on 2/9/16.
//  Copyright © 2016 Marcos Suarez. All rights reserved.
//

import UIKit
import AVFoundation

struct Album {
    let titulo: String
    let archivo: String
    let imagen: UIImage
}

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var labelTitulo: UILabel!
    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var ruleta: UIPickerView!

    @IBOutlet weak var controlVolumen: UISlider!
    
    var disco = [Album]()
    
    private var reproductor: AVAudioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Delegado del PickerView
        ruleta.delegate = self
        
        // DISCOS
        disco = [ Album(titulo: "Could you Be Loved", archivo: "CouldYouBeLoved", imagen: UIImage(named: "BobMarley")!),
                  Album(titulo: "Loco", archivo: "Loco", imagen: UIImage(named: "Loco")!),
                  Album(titulo: "Voy A Beber", archivo: "VoyABeber", imagen: UIImage(named: "VoyABeber")!),
                  Album(titulo: "Prrum.. Cosculluela", archivo: "Prrum", imagen: UIImage(named: "PrrumCosculluela")!),
                  Album(titulo: "Bailando", archivo: "Bailando", imagen: UIImage(named: "Bailando")!),
                  Album(titulo: "Batender", archivo: "Batender", imagen: UIImage(named: "Batender")!),
                  Album(titulo: "Temperatura Chino y Nacho", archivo: "Temperatura", imagen: UIImage(named: "TemperaturaChinoYnacho")!),
                  Album(titulo: "Macarena", archivo: "Macarena", imagen: UIImage(named: "Macarena")!)]
        
        // Cargamos la canción inicial.
        cargarMusica("CouldYouBeLoved")
    }
    
    // MARK: Cargar Música
    func cargarMusica(nombreCancion: String)
    {
        // Evitamos cargar la misma música que esta sonando.
        guard nombreCancion != disco[ruleta.selectedRowInComponent(0)].titulo else { return }
        
        // Encontrar el path
        let sonidoURL = NSBundle.mainBundle().URLForResource(nombreCancion, withExtension: "mp3")
        // Conexión con reproductor
        do {
            try reproductor = AVAudioPlayer(contentsOfURL: sonidoURL!)
            reproductor.volume = controlVolumen.value
            reproductor.play()
        } catch {
            print("Error al cargar el archivo: \(sonidoURL)")
        }
    }
    
    //MARK: PickerView RULETA
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        // Cantidad de Columnas.
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // Cantidad de Filas.
        return disco.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // Entrega String dependiendo de la fila y columna.
        return disco[row].titulo
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        // Se ha seleccionado una fila en el pickerView.
        labelTitulo.text = disco[row].titulo
        // cargar musica.
        cargarMusica(disco[row].archivo)
        // mostrar carátula.
        imagen.image = disco[row].imagen
    }
    
    // MARK: VOLUMEN
    @IBAction func volumen(sender: UISlider) {
        reproductor.volume = Float(sender.value / 100)
        print("volumen en \(sender.value)%")
    }
    
    // MARK: BOTONES
    @IBAction func detener(sender: UIButton) {
        print("presionado DETENER")
        if reproductor.playing {
            reproductor.currentTime = 0
            reproductor.stop()
        }
    }

    @IBAction func tocar(sender: UIButton) {
        print("presionado TOCAR")
        if !reproductor.playing { reproductor.play() }
    }
    
    @IBAction func pausar(sender: UIButton) {
        print("Presionado PAUSAR")
        if reproductor.playing { reproductor.pause() }
    }
    
    @IBAction func shufle(sender: UIButton)
    {
        let posicionActual = ruleta.selectedRowInComponent(0)
        
        var azar = Int(arc4random_uniform(UInt32(disco.count)))
        
        // Para minimizar las opciones que se repitan.
        if posicionActual == azar { azar = Int(arc4random_uniform(UInt32(disco.count))) }
        
        ruleta.selectRow(azar, inComponent: 0, animated: true)
        
        // PLAY DE LA CANCIÓN:
        cargarMusica(disco[azar].archivo)
        
        // cambio el título.
        labelTitulo.text = disco[azar].titulo
        // Muestrar carátula.
        imagen.image = disco[azar].imagen
        // Suena la canción.
        
    }
    
}

