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

    var disco = [Album]()
    
    private var reproductor: AVAudioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Delegado del PickerView
        ruleta.delegate = self
        
        // DISCOS
        disco = [ Album(titulo: "Caballo Viejo", archivo: "", imagen: UIImage(named: "SimonDiaz")!),
                  Album(titulo: "Me gustas tú", archivo: "", imagen: UIImage(named: "ManuChao")!),
                  Album(titulo: "De música ligera", archivo: "", imagen: UIImage(named: "SodaEstereo")!),
                  Album(titulo: "Párate y mira", archivo: "", imagen: UIImage(named: "LosPericos")!),
                  Album(titulo: "El matador", archivo: "", imagen: UIImage(named: "Cadillacs")!),
                  Album(titulo: "Sólo se vive una vez", archivo: "", imagen: UIImage(named: "azucar")!),
                  Album(titulo: "Mirala miralo", archivo: "", imagen: UIImage(named: "AleGuzman")!),
                  Album(titulo: "Me haces tanto bien", archivo: "", imagen: UIImage(named: "amistades")!),
                  Album(titulo: "Cumpleaños Feliz", archivo: "", imagen: UIImage(named: "Tambor")!),
                  Album(titulo: "HighWay to Hell", archivo: "", imagen: UIImage(named: "ACDC")!) ]
        
        // Control de volumen
        //reproductor.volume = Float(0.5)
    }
    
    
    func cargarMusica(nombreCancion: String)
    {
        // Encontrar el path
        let sonidoURL = NSBundle.mainBundle().URLForResource(nombreCancion, withExtension: "mp3")
        // Conexión con reproductor
        do {
            try reproductor = AVAudioPlayer(contentsOfURL: sonidoURL!)
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
        //cargarMusica(album[row])
        // mostrar carátula.
        imagen.image = disco[row].imagen
        // Iniciar la canción
        //if !reproductor.playing { reproductor.play() }
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
        
        // cambio el título.
        labelTitulo.text = disco[azar].titulo
        // Muestrar carátula.
        imagen.image = disco[azar].imagen
        // Suena la canción.
        
    }
    
}

