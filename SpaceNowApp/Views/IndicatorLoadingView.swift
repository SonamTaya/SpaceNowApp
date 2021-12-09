//
//  IndicatorLoadingView.swift
//  SpaceNowApp
//
//  Created by sonam taya on 7/12/21.
//

import UIKit

class IndicatorLoadingView: UIView {
    
    // MARK: - Subviews
    
    let blurBackgroundView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        let blurBgView = UIVisualEffectView(effect: blurEffect)
        return blurBgView
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.startAnimating()
        return indicator
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.systemGray
        label.text = "Loading..."
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = 25
        return stackView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupView() {
        backgroundColor = .clear
        
        insertSubview(blurBackgroundView, at: 0)
        addSubview(stackView)
        [label, activityIndicator].forEach { stackView.addArrangedSubview($0) }
        
        setupLayouts()
    }
    
    private func setupLayouts() {
        blurBackgroundView.bindEdgesToSuperview()
        stackView.makeCenter(in: self)
    }
}
