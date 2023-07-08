//
//  ViewController.swift
//  OnboardingPageControl
//
//  Created by Marco Alonso Rodriguez on 08/07/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var fondoDiapositiva: UIView!
    @IBOutlet weak var textoDiapositiva: UILabel!
    @IBOutlet weak var imagenDiapositiva: UIImageView!
    @IBOutlet weak var pageControlDiapositiva: UIPageControl!
    
    var diapositivas = [
        Diapositiva(texto: "El Volkswagen Beetle o Escarabajo es un coche que ha marcado profundamente la historia tanto de Volkswagen como de la industria automotriz. Y para rendir un más que merecido homenaje a este icono de la automoción, en este artículo nos adentraremos en la larga historia de este épico vehículo", color: .blue, imagen: UIImage(named: "vw")!),
        
        Diapositiva(texto: "Su precio contenido en plena recuperación económica tras la Segunda Guerra Mundial lo convirtió al VW Beetle en un auténtico superventas. Tanto fue así que se comercializó a gran escala en Europa hasta 1978, cuando pasó el testigo al Volkswagen Golf", color: .brown, imagen: UIImage(named: "vw1")!),
        
        Diapositiva(texto: "La evolución del VW Escarabajo tardó bastante en llegar, algo lógico debido a la sombra tan alargada del primero. Aún así, este nuevo modelo se presentó en 1997, reinterpretando al clásico pero con unas dimensiones mayores y una imagen mucho más musculosa.", color: .orange, imagen: UIImage(named: "vw2")!),
        
        Diapositiva(texto: "Dicen que no hay dos sin tres, por lo que en 2011 llegó The Beetle, la tercera y última generación del modelo. Esta continuaba la línea de su predecesor, si bien tenía unas líneas más definidas y una silueta más estilizada, resultando en una imagen más deportiva.", color: .red, imagen: UIImage(named: "vw3")!),
        
        Diapositiva(texto: "Desde que la firma europea dejara de fabricar la última generación en 2019 se ha hablado mucho acerca de un posible Volkswagen Escarabajo eléctrico, especialmente gracias al impulso que ha tenido la plataforma modular MEB, creadora de los modelos de la familia ID.", color: .purple, imagen: UIImage(named: "vw4")!),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI(){
        pageControlDiapositiva.numberOfPages = diapositivas.count
        
        fondoDiapositiva.addGestureRecognizer(crearSwipeGRecognizer(for: .left))
        fondoDiapositiva.addGestureRecognizer(crearSwipeGRecognizer(for: .right))
        pageControlDiapositiva.addTarget(self, action: #selector(swipePageControl), for: .valueChanged)
        
    }
    
    @objc func swipePageControl() {
       cambiar()
    }
    
    private func cambiar(){
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear) {
            self.fondoDiapositiva.backgroundColor = self.diapositivas[self.pageControlDiapositiva.currentPage].color
            self.imagenDiapositiva.image = self.diapositivas[self.pageControlDiapositiva.currentPage].imagen
            self.textoDiapositiva.text = self.diapositivas[self.pageControlDiapositiva.currentPage].texto
        }
        
    }
    
    private func crearSwipeGRecognizer(for direccion: UISwipeGestureRecognizer.Direction) -> UISwipeGestureRecognizer {
        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(cambiarDiapositiva(_:)))
        swipeGestureRecognizer.direction = direccion
        return swipeGestureRecognizer
    }

    @objc func cambiarDiapositiva(_ sender: UISwipeGestureRecognizer){
        //Hacia donde quiere avanzar
        switch sender.direction {
        case .down:
            print("Abajo")
        case .left:
            if (pageControlDiapositiva.currentPage >= 0) && (pageControlDiapositiva.currentPage <= diapositivas.count-1) {
                pageControlDiapositiva.currentPage += 1
            }
        case .up:
            print("Arriba")
        case .right:
            if (pageControlDiapositiva.currentPage >= 0) && (pageControlDiapositiva.currentPage <= diapositivas.count-1) {
                pageControlDiapositiva.currentPage -= 1
            }
        default:
            break
        }
        
        cambiar()
        
    }
}

