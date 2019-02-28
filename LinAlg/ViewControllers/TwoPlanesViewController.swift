//
//  DetailViewController.swift
//  LinAlg
//
//  Created by Taketo Sano on 2019/02/26.
//  Copyright © 2019 Taketo Sano. All rights reserved.
//

import UIKit

class TwoPlanesViewController: UIViewController, PlaneViewDelegate {

    @IBOutlet weak var domainView: PlaneView!
    @IBOutlet weak var codomainView: PlaneView!
    
    @IBOutlet var playButton: UIBarButtonItem!
    @IBOutlet var stopButton: UIBarButtonItem!
    @IBOutlet var refrButton: UIBarButtonItem!
    @IBOutlet var matrixComps: [UITextField] = []
    
    var timer: Timer?
    var animating: Bool = false

    var transform: Mat2 = .identity
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        domainView.delegate = self
        codomainView.delegate = self

        let (e0, e1) = codomainView.gridVectorViews
        [e0, e1].forEach{ e in e.isUserInteractionEnabled = true }
        
        add(.zero, color: .red)
        add(.zero, color: .blue)
        
        view.addGestureRecognizer(
            UIPinchGestureRecognizer(target: self, action: #selector(pinchRecognized(_:)))
        )
        
        refresh()
        updateNavigationBar()
    }
    
    func updateNavigationBar() {
        navigationItem.rightBarButtonItems = [(animating ? stopButton : playButton), refrButton]
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
                matrixComps[0].text = v[0].roundedString()
                matrixComps[2].text = v[1].roundedString()
                updateCodomain()
            } else if vecView.tag == 1 {
                transform[0, 1] = v[0]
                transform[1, 1] = v[1]
                matrixComps[1].text = v[0].roundedString()
                matrixComps[3].text = v[1].roundedString()
                updateCodomain()
            }
        }
    }
    
    @objc func pinchRecognized(_ g: UIPinchGestureRecognizer) {
        let l = (domainView.unitLength * g.scale).bounded(20, 160)
        domainView.unitLength = l
        codomainView.unitLength = l
        g.scale = 1.0
        
        print(l)
    }
    
    @IBAction func refresh() {
        let (v0, v1) = (domainView.vectorViews[2], domainView.vectorViews[3])
        v0.vector = Vec2(2, 1)
        v1.vector = Vec2(1, 3)
        
        let (e0, e1) = codomainView.gridVectorViews
        e0.vector = Vec2(1, 0)
        e1.vector = Vec2(0, 1)

        if animating {
            toggleAnimation()
        }
    }
    
    @IBAction func toggleAnimation() {
        animating = !animating
        
        if animating {
            timer = Timer.scheduledTimer(timeInterval: 1.0/60, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
        } else {
            timer!.invalidate()
            timer = nil
        }
        
        domainView.isUserInteractionEnabled = !animating
        updateNavigationBar()
    }
    
    @objc func timerFired() {
        let (v0, v1) = (domainView.vectorViews[2], domainView.vectorViews[3])
        v0.vector =  Mat2.rotation(0.05) * v0.vector
        v1.vector =  Mat2.rotation(-0.08) * v1.vector
    }
}
