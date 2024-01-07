//
//  PanGestureViewController.swift
//  gestureRecognizerTest
//
//  Created by Brandon Suarez on 12/27/23.
//

import UIKit

class PanGestureViewController: UIViewController {

    
    let square = UIView()
    let indicationLabel = UILabel()
    let resetButton = UIButton()
    var onApear: () -> Void = {}
    
    var initialCenter = CGPoint()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        onApear()
    }
    
    func setupController() {
        view.backgroundColor = .white
        title = "Pan Gesture"
        setupSquareView()
        setupLabel()
        setupButton()
        setupAddButton()
    }

}

extension PanGestureViewController {
    func setupSquareView() {
        square.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        square.center = view.center
        square.layer.cornerRadius = 10
        square.backgroundColor = .systemYellow
        
        //Gesture Recognizer
        square.isUserInteractionEnabled = true
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        square.addGestureRecognizer(gesture)
        
        view.addSubview(square)
    }
    
    @objc func handlePanGesture(_ gestureRecognizer: UIPanGestureRecognizer) {
        guard gestureRecognizer.view != nil else { return }
        let gesturesView = gestureRecognizer.view
        let translation = gestureRecognizer.translation(in: gesturesView?.superview)
        
        if gestureRecognizer.state == .began {
            initialCenter = gesturesView!.center
        }
        
        if gestureRecognizer.state != .cancelled {
            let newCenter = CGPoint(x: initialCenter.x + translation.x, y: initialCenter.y + translation.y)
            print("The new Center is -> X: \(newCenter.x), Y:\(newCenter.y)")
            gesturesView?.center = newCenter
        } else {
            gesturesView?.center = initialCenter
        }
    }
}

extension PanGestureViewController {
    func setupLabel() {
        
        indicationLabel.font = .systemFont(ofSize: 16, weight: .regular)
        indicationLabel.text = "Press The Button to reset the square's center, move the Yellow Square by"
        indicationLabel.numberOfLines = 4
        
        // data structures.
        // system design.
        // behavioral interview.
        // Pure swift.
        
        // 45 days to 3 months.
        // 8 hrs to 20hrs week.
        // close to 8000
        
        
        view.addSubview(indicationLabel)
        
        indicationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            indicationLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            indicationLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 15),
            indicationLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -15)
        ])
    }
    
    func setupButton() {
        
        resetButton.backgroundColor = .systemBlue
        resetButton.setTitle("Reset", for: .normal)
        resetButton.titleLabel?.textColor = .white
        
        resetButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        resetButton.layer.cornerRadius = 10
        resetButton.addTarget(self, action: #selector(didPressResetButton), for: .touchUpInside)
        
        view.addSubview(resetButton)
        
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            resetButton.heightAnchor.constraint(equalToConstant: 30),
            resetButton.widthAnchor.constraint(equalToConstant: 100),
            resetButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 200),
            resetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc func didPressResetButton() {
        // Button Animation
        UIView.animate(withDuration: 0.1) { [unowned self] in
            self.resetButton.transform = CGAffineTransform.identity.scaledBy(x: 0.95, y: 0.95)
        } completion: { _ in
            UIView.animate(withDuration: 0.1) {
                self.resetButton.transform = CGAffineTransform.identity.scaledBy(x: 1.0, y: 1.0)
            }
        }
        
        // Reset View's Center
        UIView.animate(withDuration: 0.5) { [unowned self] in
            self.square.center = view.center
            print("Square view center reseted")
        }
    }
    
    // MARK: - Add Button
    
    func setupAddButton() {
        let rightButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton))
        navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc func didTapAddButton() {
        let viewController = SwipeGestureViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}
