//
//  ViewController.swift
//  ReproductorDeMusica
//
//  Created by Marcos Suarez on 2/9/16.
//  Copyright © 2016 Marcos Suarez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelTitulo: UILabel!
    
    @IBOutlet weak var imagen: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func volumen(sender: UISlider) {
    }
    
    @IBAction func detener(sender: UIButton) {
    }

    @IBAction func tocar(sender: UIButton) {
    }
    
    @IBAction func pausar(sender: UIButton) {
    }
    
    @IBAction func shufle(sender: UIButton) {
    }
    
}

