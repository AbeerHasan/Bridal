//
//  ProductsViewController.swift
//  Bridal
//
//  Created by Abeer Hasan on 28/06/2021.
//

import UIKit

class ProductsViewController: UIViewController {

    @IBOutlet weak var productsTableView: UITableView!
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingIndicator.startAnimating()
        if DataServices.selectedCategory!.products == nil {
            
            DataServices.instance.getProducts(by: "categoryName", value: DataServices.selectedCategory!.title) {[weak self] (products) in
                DispatchQueue.main.async {
                    
                        DataServices.selectedCategory!.products = products
                        self!.productsTableView.reloadData()
                    }
            }
        }else {
            
            print("my products")
        }
        
        productsTableView.delegate = self
        productsTableView.dataSource = self
        
    }
    
    var timer = Timer()
    var counter = 0
    var flage = true
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.stopAnimating), userInfo: nil, repeats: false )
        }
    }
    
    @objc func stopAnimating(){
        self.loadingIndicator.stopAnimating()
    }
    
    
    @IBAction func addProductButtonClicked(_ sender: Any) {
        let mainStoryboard = UIStoryboard(name: "AddProductViewController", bundle: nil)
        guard let signUpVC = mainStoryboard.instantiateViewController(identifier: "AddProductViewController") as? AddProductViewController  else {
            return
        }
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
}

extension ProductsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if DataServices.selectedCategory!.products != nil {
            self.loadingIndicator.stopAnimating()
            return DataServices.selectedCategory!.products!.count
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = productsTableView.dequeueReusableCell(withIdentifier: "ProductCell") as? ProductsTableViewCell else {return UITableViewCell()}
        if let products = DataServices.selectedCategory!.products {
            cell.configurCell(product: products[indexPath.row])
            return cell
        }
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DataServices.selectedProduct = DataServices.selectedCategory!.products![indexPath.row]
        
         let mainStoryboard = UIStoryboard(name: "ProductDetailsViewController", bundle: nil)
         guard let signUpVC = mainStoryboard.instantiateViewController(identifier: "ProductDetailsViewController") as? ProductDetailsViewController  else {
             return
         }
         navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.productsTableView.frame.height / 5
    }
}
