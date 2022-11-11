//
//  ViewController.swift
//  ProductList
//
//  Created by darkhan on 11.11.2022.
//

import UIKit

final class ViewController: UIViewController {
    // MARK: - UI
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ProductTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = 100
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
        
    }()
    
    // MARK: - State
    
    private var products = [Product]()
    private let cellIdentifier = "cellId"
    
    // MARK: - Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        setupNavigationBar()
        
        loadProducts()
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        view.addSubview(tableView)
    }
    
    // MARK: - Setup Contraints
    
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - Setup Navigation bar
    
    private func setupNavigationBar() {
        title = "Products"
    }
    
    // MARK: - Load Products
    
    private func loadProducts() {
        Service.sharedInstanse.fetchingAPIData() { [weak self] products in
            guard let self = self else {
                return
            }
            
            self.products = products
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? ProductTableViewCell else {
            return UITableViewCell()
        }
        
        let title = products[indexPath.row].title
        let price = "\(products[indexPath.row].price) $"
        let urlString = products[indexPath.row].images.first
        let url = URL(string: urlString!)
        cell.configureCell(title: title, price: price, imageUrl: url!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailView = DetailSecondViewController(detailProduct: products[indexPath.row])
        navigationController?.pushViewController(detailView, animated: true)
    }
}
