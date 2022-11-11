//
//  ImageCollectionViewCell.swift
//  ProductList
//
//  Created by darkhan on 11.11.2022.
//

import UIKit
import SnapKit
import Kingfisher

class ImageCollectionViewCell: UICollectionViewCell {
    // MARK: - UI
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(productImageView)
        productImageView.snp.makeConstraints { make in
            make.width.equalTo(UIScreen.main.bounds.width)
            make.height.equalTo(300)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        productImageView.image = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public
    
    public func configure(url: URL) {
        productImageView.kf.setImage(with: url)
        productImageView.contentMode = .scaleAspectFit
    }
}
