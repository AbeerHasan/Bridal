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
        productsTableView.delegate = self
        productsTableView.dataSource = self
        if DataServices.selectedCategory!.products == nil {
            loadingIndicator.startAnimating()
            DataServices.instance.getProducts(by: "categoryName", value: DataServices.selectedCategory!.title) {[weak self] (products) in
                if products.count > 0 {
                    DataServices.selectedCategory!.products = products
                    DispatchQueue.main.async {
                        self!.productsTableView.reloadData()
                    }
                }
                self!.loadingIndicator.stopAnimating()
            }
        }else {
            
            print("No category")
        }
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
        return self.productsTableView.frame.height / 4.5
    }
}
