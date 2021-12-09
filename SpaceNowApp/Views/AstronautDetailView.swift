//
//  AstronautDetailView.swift
//  SpaceNowApp
//
//  Created by sonam taya on 8/12/21.
//

import UIKit

class AstronautDetailView: UIView {
    // MARK: - Subviews
    
    let viewBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        return view
    }()
    
    let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    let viewContent: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let imageViewAstronaut: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 15
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()
    
    let labelNationality: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 17)
        lbl.textColor = .systemGray
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let labelDOB: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 17)
        lbl.textColor = .systemGray
        lbl.numberOfLines = 0
        lbl.sizeToFit()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let labelBio: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 17)
        lbl.textColor = .systemGray
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
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
        
        insertSubview(viewBackground, at: 0)

        addSubview(scrollView)
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        scrollView.addSubview(viewContent)
        viewContent.addSubview(imageViewAstronaut)
        viewContent.addSubview(stackView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: self.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: self.rightAnchor),
            scrollView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            viewContent.topAnchor.constraint(equalTo: scrollView.topAnchor),
            viewContent.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            viewContent.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            viewContent.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            viewContent.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),

            imageViewAstronaut.topAnchor.constraint(equalTo: viewContent.topAnchor, constant: 30),
            imageViewAstronaut.centerXAnchor.constraint(equalTo: viewContent.centerXAnchor),
            imageViewAstronaut.heightAnchor.constraint(equalToConstant: 120),
            imageViewAstronaut.widthAnchor.constraint(equalToConstant: 120),
            
            stackView.topAnchor.constraint(equalTo: imageViewAstronaut.bottomAnchor, constant: 30),
            stackView.leftAnchor.constraint(equalTo: viewContent.leftAnchor, constant: 30),
            stackView.rightAnchor.constraint(equalTo: viewContent.rightAnchor, constant: -30),
            stackView.bottomAnchor.constraint(equalTo: viewContent.bottomAnchor, constant: -30),
        ])
        
        [ labelNationality, labelDOB, labelBio].forEach{ stackView.addArrangedSubview($0) }
        
        setupLayouts()
    }
        
    private func setupLayouts() {
        viewBackground.bindEdgesToSuperview()
    }
}
