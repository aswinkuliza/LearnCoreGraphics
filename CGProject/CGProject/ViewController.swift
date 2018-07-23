//
//  ViewController.swift
//  CGProject
//
//  Created by kuliza310 on 7/5/18.
//  Copyright © 2018 kuliza310. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var taggesture: UITapGestureRecognizer!
    private var greenLayer: CALayer {
        let layer = CALayer()
        layer.backgroundColor = UIColor.green.cgColor
        layer.bounds = view.bounds
        layer.position = CGPoint(x: 100, y: 100)
        layer.anchorPoint = CGPoint(x: 1.0, y: 0.5)
        return layer
    }

    private var redLayer: CALayer {
        let layer = CALayer()
        layer.bounds = view.bounds
        layer.backgroundColor = UIColor.red.cgColor
        layer.position = CGPoint(x: 100, y: 100)
        layer.bounds = view.bounds
        layer.anchorPoint = CGPoint(x: 0.0, y: 1.0)
        return layer
    }

    @IBAction func tapped(_ sender: UITapGestureRecognizer) {
        let view = FanView()
        view.center = sender.location(in: self.view)
        self.view.addSubview(view)

    }

    private var blueLayer: CALayer {
        let layer = CALayer()
        layer.backgroundColor = UIColor.blue.cgColor
        layer.bounds = view.bounds
        layer.position = CGPoint(x: 100, y: 100)
        layer.anchorPoint = CGPoint.zero
        return layer
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        alignLayersAboutApoint()
        view.backgroundColor = UIColor.red
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    private func alignLayersAboutApoint() {
        view.layer.addSublayer(greenLayer)
        view.layer.addSublayer(blueLayer)
        view.layer.addSublayer(redLayer)
    }
}
