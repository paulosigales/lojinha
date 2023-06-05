//
//  ListViewController.swift
//  
//
//  Created by Paulo Sigales on 03/06/23.
//

import UIKit
import Combine

public class ListViewController: UIViewController {
    
    private var viewModel: ListViewModel = ListViewModel()
    private var cancellable: AnyCancellable?
    
    private lazy var collectionView: UICollectionView = {
        return UICollectionView(dataSource: self, delegate: self, cell: UICollectionViewCell.self)
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        return UIActivityIndicatorView().defaultIndicator()
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupViewCode()
        setupNavigation()
        fetchProductList()
    }
}

extension ListViewController {
    
    private func setupNavigation() {
        title = "Lojinha"
        navigationController?.setAppearance()
        
        self.setCartButton(with: 0)
    }
    
    private func setCartButton(with itemCount: Int) {
        let badgeText: String = itemCount > 0 ? "\(itemCount)" : "0"
        let cartImage: CartImage = itemCount > 0 ? .cart : .cartEmpty

        let cartButton = UIBarButtonItem(withBadgeText: badgeText,
                                     cartImage: cartImage,
                                     target: self,
                                     action: #selector(goToCart))

        navigationItem.rightBarButtonItem = cartButton
    }
    
    @objc private func goToCart() {
        
    }
}

extension ListViewController {
    
    private func fetchProductList() {
        self.collectionView.isHidden = true
        self.activityIndicator.startAnimating()
        
        cancellable = viewModel.fetchProductList()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                    case .finished:
                        self?.collectionView.isHidden = false
                        self?.activityIndicator.stopAnimating()
                    case .failure(let error):
                        self?.handleFetchError(error)
                }
            }, receiveValue: { [weak self] _ in
                self?.collectionView.setContentOffset(.zero, animated: false)
                self?.collectionView.reloadData()
            })
    }
    
    private func handleFetchError(_ error: Error) {
        print("Error fetching products: \(error)")
    }
}

extension ListViewController: ViewCode {
    func buildHierarchy() {
        view.addSubview(collectionView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func applyAdditionalChanges() {
        view.backgroundColor = UIColor.customBackground
    }
}

extension ListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection()
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueCell(withType: ProductCell.self, for: indexPath) as? ProductCell else {
            return UICollectionViewCell()
        }
        
        let productViewModel = viewModel.productViewModelAt(indexPath.row)
        cell.configure(with: productViewModel)
        
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let productViewModel = viewModel.productViewModelAt(indexPath.row)
        let productViewController = ProductViewController(viewModel: productViewModel)
        self.present(productViewController, animated: true)
    }
}

extension ListViewController: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 2, height: 100)
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

