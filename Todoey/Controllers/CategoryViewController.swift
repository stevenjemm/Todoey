//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Steven Jemmott on 20/05/2018.
//  Copyright © 2018 Steven Jemmott. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    var categoryArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let reuseIdentifier = "categoryCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
        
    }
    
    // MARK: - Data Manipulation Methods
    
    // MARK: - Interactions
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        var textField = UITextField()
        
        let action = UIAlertAction(title: "Add Category", style: .default) { alert in
            if let newCategory = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
                let category = Category(context: self.context)
                category.name = newCategory
                self.categoryArray.append(category)
                
                //TODO:- Save Category to database
                self.saveCategories()
            }
        }
        
        // Add Textfield to alert cntroller
        alertController.addTextField { alertTextField in
            alertTextField.placeholder = "Add new Category"
            textField = alertTextField
        }
        
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
    func saveCategories() {
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        do {
            categoryArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context: \(error)")
        }
        
        tableView.reloadData()
    }
    
    
    // MARK: - TableView Datasource Methods
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    // MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        let category = categoryArray[indexPath.row]
        
        cell.textLabel?.text = category.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destination.selectedCategory = categoryArray[indexPath.row]
        }
        
        if segue.identifier == "goToItems" {
        }
    }
    
}
