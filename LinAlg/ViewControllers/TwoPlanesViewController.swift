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
    
    var initialTransform: Mat2 = .identity
    private(set) var transform: Mat2 = .identity
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        domainView.delegate = self
        codomainView.delegate = self

        addBoth(Vec2(1, 0), color: .gray, userInteractionEnabled: (false, true))
        addBoth(Vec2(0, 1), color: .gray, userInteractionEnabled: (false, true))
        addBoth(.zero, color: .red, userInteractionEnabled: (true, false))
        addBoth(.zero, color: .blue, userInteractionEnabled: (true, false))
        
        [domainView, codomainView].forEach { planeView in
            planeView.gridVectorViews = (planeView.vectorViews[0], planeView.vectorViews[1])
        }

        view.addGestureRecognizer(
            UIPinchGestureRecognizer(target: self, action: #selector(pinchRecognized(_:)))
        )
        
        reset()
        updateNavigationBar()
    }
    
    func addBoth(_ v: Vec2, color: UIColor = .black, userInteractionEnabled: (Bool, Bool) = (false, false)) {
        let v0 = domainView.add(v, color: color)
        let v1 = codomainView.add(transform * v, color: color)
        v0.isUserInteractionEnabled = userInteractionEnabled.0
        v1.isUserInteractionEnabled = userInteractionEnabled.1
        v0.related = v1
        [v0, v1].forEach{ $0.isExclusiveTouch = true }
    }
    
    @IBAction func reset() {
        transform = initialTransform
        
        let (v0, v1) = (domainView.vectorViews[2], domainView.vectorViews[3])
        v0.vector = Vec2(2, 1)
        v1.vector = Vec2(1, 3)
        
        updateMatrix()
        updateVectors()
        
        if animating {
            toggleAnimation()
        }
    }
    
    func updateMatrix() {
        transform.grid.enumerated().forEach { (i, a) in
            matrixComps[i].text = a.roundedString()
        }
    }
    
    func updateVectors() {
        for v in domainView.vectorViews {
            guard let w = v.related else { continue }
            w.vector = transform * v.vector
        }
    }
    
    func updateNavigationBar() {
        navigationItem.rightBarButtonItems = [(animating ? stopButton : playButton), refrButton]
    }
    
    func planeView(_ plane: PlaneView, vectorUpdated vecView: VectorView) {
        let v = vecView.vector
        if plane == domainView {
            updateVectors()
        } else if plane == codomainView {
            if vecView.tag == 0 {
                transform[0, 0] = v[0]
                transform[1, 0] = v[1]
                updateMatrix()
                updateVectors()
            } else if vecView.tag == 1 {
                transform[0, 1] = v[0]
                transform[1, 1] = v[1]
                updateMatrix()
                updateVectors()
            }
        }
    }
    
    @objc func pinchRecognized(_ g: UIPinchGestureRecognizer) {
        let l = (domainView.unitLength * g.scale).bounded(10, 200)
        domainView.unitLength = l
        codomainView.unitLength = l
        g.scale = 1.0
        
        print(l)
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
