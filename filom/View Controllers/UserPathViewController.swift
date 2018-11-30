//
//  UserPathViewController.swift
//  filom
//
//  Created by Bastien Beurier on 11/28/18.
//  Copyright © 2018 Bastien Beurier. All rights reserved.
//

import UIKit

import SnapKit

class UserPathViewController: UIViewController {
    
    let horizontalMargin: Float = 20
    let stepViewWidth: CGFloat = 400

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scrollView = UIScrollView()
        scrollView.isDirectionalLockEnabled = true
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { (make) -> Void in
            make.edges.equalToSuperview()
        }
        
        let steps = FilomData.getSteps()
        
        let stepViews = displaySteps(steps: steps, scrollView: scrollView)
        displayTouchOverlays(steps: steps, stepViews: stepViews)
    }
    
    func displaySteps(steps: [UserEvent], scrollView: UIScrollView) -> [UIView] {
        guard steps.count > 0 else { return [] }
        
        var stepViews: [UIView] = []
        
        let firstStepView = createStepView(step: steps.first!)
        stepViews.append(firstStepView)
        scrollView.addSubview(firstStepView)
        
        firstStepView.snp.makeConstraints { (make) -> Void in
            make.left.equalToSuperview().offset(horizontalMargin)
            make.width.equalTo(stepViewWidth)
            make.height.equalTo(stepViewWidth/steps.first!.windowRatio)
            make.centerY.equalToSuperview()
        }
        
        guard steps.count > 1 else { return stepViews }
        
        var previousStepView = firstStepView
        for i in 1..<steps.count - 1 {
            let stepView = createStepView(step: steps[i])
            stepViews.append(stepView)
            scrollView.addSubview(stepView)
            
            stepView.snp.makeConstraints { (make) -> Void in
                make.left.equalTo(previousStepView.snp.right).offset(20)
                make.top.bottom.width.equalTo(previousStepView)
            }
            
            previousStepView = stepView
        }
        
        let lastStepView = createStepView(step: steps.last!)
        stepViews.append(lastStepView)
        scrollView.addSubview(lastStepView)
        
        lastStepView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(previousStepView.snp.right).offset(20)
            make.top.bottom.width.equalTo(previousStepView)
            make.right.equalToSuperview().offset(-20)
        }
        
        return stepViews
    }
    
    func createStepView(step: UserEvent) -> UIView {
        let imageView = UIImageView()
        imageView.layer.borderColor = UIColor.red.cgColor
        imageView.layer.borderWidth = 0.5
        imageView.image = step.image
        imageView.clipsToBounds = true
        return imageView
    }
    
    func displayTouchOverlays(steps: [UserEvent], stepViews: [UIView]) {
        for i in 0..<steps.count {
            displayTouchOverlay(event: steps[i], imageView: stepViews[i])
        }
    }
    
    func displayTouchOverlay(event: UserEvent, imageView: UIView) {
        let touchOverlay = UIView()
        touchOverlay.alpha = 0.7
        touchOverlay.backgroundColor = UIColor.red
        imageView.addSubview(touchOverlay)
        
        touchOverlay.snp.makeConstraints { (make) -> Void in
            let stepHeight = stepViewWidth/event.windowRatio
            make.left.equalTo(event.touchViewOrigin.x * stepViewWidth / event.windowWidth)
            make.top.equalTo(event.touchViewOrigin.y * stepHeight / event.windowHeight)
            make.width.equalTo(event.touchViewSize.width * stepViewWidth / event.windowWidth)
            make.height.equalTo(event.touchViewSize.height * stepHeight / event.windowHeight)
        }
    }

}
