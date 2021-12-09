//
//  AstronautsViewController.swift
//  SpaceNowApp
//
//  Created by sonam taya on 7/12/21.
//

import UIKit

class AstronautsViewController: UIViewController {
  
    // MARK: - Variables and Properties
    
    private var viewModel: AstronautsViewModel?
    private let refreshControl = UIRefreshControl()

    // MARK: - Lifecycles

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = AstronautsViewModel(delegate: self)
        viewModel?.fetchAstronauts(with: URL(string: "\(baseUrlString)astronaut/")!)
        setupViews()
    }
    
    // MARK: - Subviews
    
    let loadingView: IndicatorLoadingView = {
        let view = IndicatorLoadingView()
        return view
    }()
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        // Add Refresh Control to Table View
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.systemGray]
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing please wait ...", attributes: attributes)
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        if #available(iOS 10.0, *) {
            table.refreshControl = refreshControl
        } else {
            table.addSubview(refreshControl)
        }
        return table
    }()
    
    // MARK: - Setup
    
    private func setupViews() {

        let button: UIButton = UIButton(type: .custom)
        button.setImage(UIImage(named: "sortBlack"), for: .normal)
        button.addTarget(self, action: #selector(sortButtonPressed), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.backButtonTitle = ""
        navigationItem.title = "Astronauts"
        [tableView, loadingView].forEach { view.addSubview($0) }

        setupLayouts()
    }
    
    private func setupLayouts() {
        tableView.constraints(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        loadingView.constraints(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        setupTableView()
    }
    
     func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(AstronautsTableViewCell.nib, forCellReuseIdentifier: AstronautsTableViewCell.reuseIdentifier)
    }
    
    // MARK: - Button Actions

    @objc private func refreshData(_ sender: Any) {
        viewModel?.fetchAstronauts(with: URL(string: "\(baseUrlString)astronaut/")!)
    }
    
    @objc func sortButtonPressed() {
           print("Sort button pressed")
        viewModel?.astronautData = viewModel?.astronautData?.sorted { $0.name.lowercased() < $1.name.lowercased() }
        tableView.reloadData()
       }
    
}

// MARK: - EXTENSION Tableview datasource and delegates

extension AstronautsViewController : UITableViewDelegate,UITableViewDataSource {
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.astronautData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AstronautsTableViewCell.reuseIdentifier, for: indexPath) as? AstronautsTableViewCell else { fatalError("Error dequeuing AstronautsTableViewCell") }
        if let info = viewModel?.astronautData?[indexPath.row] {
            cell.configureCell(with: info)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = AstronautDetailViewController()
        if let info = viewModel?.astronautData?[indexPath.row] {
            viewController.url = URL(string: "\(baseUrlString)astronaut/\(info.id)")
        }
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}

// MARK: - EXTENSION ViewModelDelegates

extension AstronautsViewController : ViewModelDelegate {
    func fetchDidSucceed() {
        print("SUCCEED*********************", self.viewModel?.astronautData?.count ?? 0)
        tableView.reloadData()
        self.refreshControl.endRefreshing()
        loadingView.removeFromSuperview()
    }
    
    func fetchDidFail(with title: String, description: String) {
        print("failure******************", title,description)
        showAlert(withTitle:title, withMessage: description)
        viewModel?.astronautData = nil
        tableView.reloadData()
        self.refreshControl.endRefreshing()
        loadingView.removeFromSuperview()
    }
    
}
