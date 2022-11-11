//
//  DetailSecondViewController.swift
//  ProductList
//
//  Created by darkhan on 11.11.2022.
//

import UIKit
import SnapKit
import Kingfisher

final class DetailSecondViewController: UIViewController {
    
    // MARK: - State
    private var detailProduct: Product
    
    // MARK: - UI
    
    private lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 300)
        layout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView.delegate = self
        collectionView.dataSource = self
//        collectionView.backgroundColor = .red
        return collectionView
    }()
    
    private lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.textColor = .black
        title.text = "Title: \(detailProduct.title)"
        title.textAlignment = .left
        return title
    }()
    
    private lazy var productDescriptionLabel: UILabel = {
        let productDescription = UILabel()
        productDescription.textColor = .black
        productDescription.numberOfLines = 0
        productDescription.text = "Description: \(detailProduct.productDescription)"
        return productDescription
    }()
    
    private lazy var priceLabel: UILabel = {
        let price = UILabel()
        price.textColor = .black
        price.text = "Price: \(detailProduct.price) $"
        return price
    }()
    
    private lazy var categoryLabel: UILabel = {
        let category = UILabel()
        category.textColor = .black
        category.text = "Category: \(detailProduct.category)"
        return category
    }()
    
    private lazy var brandLabel: UILabel = {
        let brand = UILabel()
        brand.textColor = .black
        brand.text = "Brand: \(detailProduct.brand)"
        return brand
    }()
    
    // MARK: - Init
    init(detailProduct: Product) {
        self.detailProduct = detailProduct
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()

        setupViews()
        setupConstraints()
        
        
    }
    
    // MARK: - Setup Navigation bar
    
    private func setupNavigationBar() {
        title = detailProduct.title
        edgesForExtendedLayout = []
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.backgroundColor = .white
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        view.addSubview(titleLabel)
        view.addSubview(productDescriptionLabel)
        view.addSubview(priceLabel)
        view.addSubview(categoryLabel)
        view.addSubview(brandLabel)
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(340)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        productDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(productDescriptionLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(productDescriptionLabel)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(productDescriptionLabel)
        }
        
        brandLabel.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(productDescriptionLabel)
        }
    }
}

// MARK: Extensions UICollectionViewDelegate, UICollectionViewDataSource

extension DetailSecondViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return detailProduct.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! ImageCollectionViewCell
        let imageUrl = detailProduct.images[indexPath.item]
        let url = URL(string: imageUrl)!
        cell.configure(url: url)
        return cell
    }
}
