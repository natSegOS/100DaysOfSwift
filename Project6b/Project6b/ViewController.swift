//
//  ViewController.swift
//  Project6b
//
//  Created by Nathan Segura on 3/7/22.
//  Copyright © 2022 Nathan Segura. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Here I create several labels and customize them
        let label1 = UILabel()
        label1.translatesAutoresizingMaskIntoConstraints = false // This line of code means I don't want the label to be formatted automatically; I want to format it myself, or manually
        label1.backgroundColor = .red
        label1.text = "THESE"
        label1.sizeToFit()
        
        let label2 = UILabel()
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.backgroundColor = .cyan
        label2.text = "ARE"
        label2.sizeToFit()
        
        let label3 = UILabel()
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.backgroundColor = .yellow
        label3.text = "SOME"
        label3.sizeToFit()
        
        let label4 = UILabel()
        label4.translatesAutoresizingMaskIntoConstraints = false
        label4.backgroundColor = .green
        label4.text = "AWESOME"
        label4.sizeToFit()
        
        let label5 = UILabel()
        label5.translatesAutoresizingMaskIntoConstraints = false
        label5.backgroundColor = .orange
        label5.text = "LABELS"
        label5.sizeToFit()
        
        // After I've created the labels, I add them to the view (what the user is currently seeing on their screen)
        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(label3)
        view.addSubview(label4)
        view.addSubview(label5)
        
// VISUAL FORMAT LANGUAGE ...
//        // I create a dictionary of views to reference them using visual format language (VHL)
//        let viewsDictionary = ["label1": label1, "label2": label2, "label3": label3, "label4": label4, "label5": label5]
//
//        for label in viewsDictionary.keys {
//            // The "H" means I want to format the labels horizontally
//            // The "|" symbol means I want to constrain the label at either the left or right edge of the view
//            // Whatever is inside the brackets [] is what I want to format
//            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[\(label)]|", options: [], metrics: nil, views: viewsDictionary))
//        }
//
//        // This metrics dictionary is used for customizing things with Visual Format Language (VFL). I am customizing the labelHeight to be 88 pixels
//        let metrics = ["labelHeight": 88]
//
//        // The "V" means to format vertically
//        // The "-" between each label is a way of saying that I want a space between each label
//        // Everything inside the parentheses () is the size I want something to be
//        // The "labelHeight" is referencing the value in the metrics dictionary above (about 88 pixels)
//        // The "@999" is setting the priority of the size. 1000 is the default, meaning it absolutely has to be that size, but 999 is saying it's really important but optional, so it must be as close to 88 pixels as possible
//        // All the other labels that have "label1" inside the parentheses: (label1) must have the same height as label1
//        // The dash at the end: -(>=10)- is saying that there must be a space that is at least 10 pixels high from the bottom
//
//        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[label1(labelHeight@999)]-[label2(label1)]-[label3(label1)]-[label4(label1)]-[label5(label1)]-(>=10)-|", options: [], metrics: metrics, views: viewsDictionary))
        
        // Here I declare a variable named "previous" to hold the previous label in a loop
        var previous: UILabel?

        // I go through all the labels
        for label in [label1, label2, label3, label4, label5] {
            // I set the width of the label to the width of the screen
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true

            // I set the height of the label to be about 1/5 (0.2) of the main view's height, subtracted by 10 pixels for spacing
            label.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.2, constant: -10)

            // I check if the previous label exists because there is no label before the first one
            if let previous = previous {

                // I position the label to be 10 pixels away from the last label
                label.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 10).isActive = true
            } else {

                // I position the first label to be in a safe place at the top of the screen where nothing covers it
                label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
            }
            
            // I set the previous label to be the current label after I have finished configuring it
            previous = label
        }
    }
}
