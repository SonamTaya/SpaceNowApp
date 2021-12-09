//
//  AstronautDetailViewController.swift
//  SpaceNowApp
//
//  Created by sonam taya on 7/12/21.
//

import UIKit
import Nuke

class AstronautDetailViewController: UIViewController {
    
    // MARK: - Variables and Properties
    private var viewModel: AstronautsViewModel?
    
    var url : URL?{
        didSet {
            viewModel = AstronautsViewModel(delegate: self)
            viewModel?.fetchAstronautDetail(with: url!)
            setupViews()
        }
    }
    
    // MARK: - Subviews
    
    let loadingView: IndicatorLoadingView = {
        let view = IndicatorLoadingView()
        return view
    }()
    
    let customView = AstronautDetailView()
    
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Setup
    
    private func setupViews() {
        [customView, loadingView].forEach { view.addSubview($0) }
        setupLayouts()
    }
    
    private func setupLayouts() {
        customView.constraints(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        loadingView.constraints(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
    }
    
}

// MARK: - EXTENSION ViewModelDelegates

extension AstronautDetailViewController : ViewModelDelegate {
    func fetchDidSucceed() {
        loadingView.removeFromSuperview()
        customView.labelNationality.text = "Nationality: \(viewModel?.astronautDetail?.nationality ?? "")"
        customView.labelDOB.text = "Date of birth: \(viewModel?.astronautDetail?.date_of_birth ?? "")"
        customView.labelBio.text = "Bio: \(viewModel?.astronautDetail?.bio ?? "")"
        if let imageUrl = URL(string: viewModel?.astronautDetail?.profile_image_thumbnail ?? "") {
            Nuke.loadImage(with: imageUrl, into: customView.imageViewAstronaut)
        }
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = viewModel?.astronautDetail?.name ?? ""
    }
    
    func fetchDidFail(with title: String, description: String) {
        showAlert(withTitle:title, withMessage: description)
        loadingView.removeFromSuperview()
    }
}
