//
//  DetailViewController.swift
//  LinAlg
//
//  Created by Taketo Sano on 2019/02/26.
//  Copyright © 2019 Taketo Sano. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, PlaneViewDelegate {

    @IBOutlet weak var domainView: PlaneView!
    @IBOutlet weak var codomainView: PlaneView!
    
    var transform: Mat2 = .identity

    override func viewDidLoad() {
        super.viewDidLoad()
        
        domainView.delegate = self
        codomainView.delegate = self

        let (e0, e1) = codomainView.gridVectorViews
        [e0, e1].forEach{ e in e.isUserInteractionEnabled = true }
        
        add(Vec2(2, 1), color: .red)
        add(Vec2(1, 2), color: .blue)
        
        view.addGestureRecognizer(
            UIPinchGestureRecognizer(target: self, action: #selector(pinchRecognized(_:)))
        )
    }
    
    func add(_ v: Vec2, color: UIColor = .black) {
        let v1 = domainView.add(v, color: color)
        let v2 = codomainView.add(transform * v, color: color)
        v1.isUserInteractionEnabled = true
        v1.related = v2
    }
    
    func updateCodomain() {
        for v1 in domainView.vectorViews {
            guard let v2 = v1.related else { continue }
            v2.vector = transform * v1.vector
        }
    }
    
    func planeView(_ plane: PlaneView, vectorUpdated vecView: VectorView) {
        let v = vecView.vector
        if plane == domainView {
            if let vecView2 = vecView.related {
                let w = transform * v
                vecView2.vector = w
            }
        } else if plane == codomainView {
            if vecView.tag == 0 {
                transform[0, 0] = v[0]
                transform[1, 0] = v[1]
                updateCodomain()
            } else if vecView.tag == 1 {
                transform[0, 1] = v[0]
                transform[1, 1] = v[1]
                updateCodomain()
            }
        }
    }
    
    @objc func pinchRecognized(_ g: UIPinchGestureRecognizer) {
        let l = domainView.unitLength * g.scale
        domainView.unitLength = l
        codomainView.unitLength = l
        g.scale = 1.0
    }
}
