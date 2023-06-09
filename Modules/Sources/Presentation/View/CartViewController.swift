//
//  CartViewController.swift
//  
//
//  Created by Paulo Sigales on 06/06/23.
//

import Combine
import UIKit

class CartViewController: UIViewController {
    
    private var cancellable = Set<AnyCancellable>()
    
    private lazy var cartTopView: UIView = {
        return UIView().container(backgroundColor: .customSecondary, height: 50)
    }()
    
    private lazy var cartLabel: UILabel = {
        return UILabel(textColor: .white,
                       fontSize: 22,
                       fontWeight: .bold,
                       textAlignment: .left)
    }()
    
    private lazy var emptyCart: UIView = {
        return UIView().emptyCart()
    }()
    
    private lazy var tableView: UITableView = {
        return UITableView(dataSource: self, delegate: self, cell: OrderCell.self)
    }()
    
    private lazy var cartBottomView: UIView = {
        return UIView().container(backgroundColor: .customSecondary, height: 50)
    }()
    
    
    private lazy var totalPriceLabel: UILabel = {
        return UILabel(textColor: .white,
                       fontSize: 20,
                       fontWeight: .bold,
                       fontFit: true,
                       textAlignment: .right,
                       width: 150,
                       height: 40)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewCode()
        
        CartViewModel.orderListSubject.sink { orderList in
            if orderList.count == 0 {
                self.tableView.isHidden = true
                
            } else {
                self.tableView.isHidden = false
                self.tableView.reloadData()
            }
        }.store(in: &cancellable)
        
        CartViewModel.cartTotalSubject.sink { total in
            self.totalPriceLabel.text = total.toFormattedCurrency()
        }.store(in: &cancellable)
    }
}

extension CartViewController: ViewCode {
    func buildHierarchy() {
        view.addSubview(cartTopView)
        cartTopView.addSubview(cartLabel)
        view.addSubview(cartTopView)
        view.addSubview(emptyCart)
        view.addSubview(tableView)
        view.addSubview(cartBottomView)
        cartBottomView.addSubview(totalPriceLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            cartTopView.topAnchor.constraint(equalTo: view.topAnchor),
            cartTopView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cartTopView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            cartLabel.topAnchor.constraint(equalTo: cartTopView.topAnchor, constant: 10),
            cartLabel.leadingAnchor.constraint(equalTo: cartTopView.leadingAnchor, constant: 10),
            cartLabel.trailingAnchor.constraint(equalTo: cartTopView.trailingAnchor, constant: -10),
            
            emptyCart.topAnchor.constraint(equalTo: cartTopView.bottomAnchor),
            emptyCart.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyCart.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emptyCart.bottomAnchor.constraint(equalTo: cartBottomView.topAnchor),
            
            tableView.topAnchor.constraint(equalTo: cartTopView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: cartBottomView.topAnchor),
            
            cartBottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cartBottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cartBottomView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            totalPriceLabel.centerYAnchor.constraint(equalTo: cartBottomView.centerYAnchor),
            totalPriceLabel.trailingAnchor.constraint(equalTo: cartBottomView.trailingAnchor, constant: -10)
        ])
    }
    
    func applyAdditionalChanges() {
        view.backgroundColor = UIColor.customSecondary
        cartLabel.text = "carrinho"
    }
}

extension CartViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CartViewModel.orderList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueCell(withType: OrderCell.self, for: indexPath) as? OrderCell else {
            return UITableViewCell()
        }
        
        let order = CartViewModel.orderAtIndex(indexPath.row)
        let orderViewModel = OrderViewModel(order)
        let productViewModel = ProductViewModel(order.product)
        
        cell.configure(with: orderViewModel, and: productViewModel)
        
        return cell
    }
}
