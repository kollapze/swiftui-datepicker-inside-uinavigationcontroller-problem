//
//  ViewController.swift
//  swiftui-datepicker-inside-uinavigationcontroller-problem
//
//  Created by Alexander Krasikov on 19.12.2024.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        let button = UIButton(type: .system)
        button.setTitle("Present UINavigationController", for: .normal)
        button.addTarget(self, action: #selector(presentNavigationController), for: .touchUpInside)

        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

    @objc
    private func presentNavigationController() {
        let navigationController = UINavigationController()
        let datePicker1 = createDatePicker(
            title: "date picker 1",
            action: {
                let datePicker2 = createDatePicker(
                    title: "date picker 2",
                    action: {
                        navigationController.dismiss(animated: true)
                    }
                )
                navigationController.pushViewController(datePicker2, animated: true)
            }
        )

        navigationController.setViewControllers([datePicker1], animated: false)
        present(navigationController, animated: true)
    }
}


private func createDatePicker(title: String, action: @escaping () -> Void) -> UIViewController {
    UIHostingController(rootView: DatePickerContainer(title: title, action: action))
}

private struct DatePickerContainer: View {
    let title: String
    let action: () -> Void

    @State
    private var selectedDate: Date = .now

    var body: some View {
        VStack {
            Text(title)
            DatePicker(
                "",
                selection: $selectedDate,
                displayedComponents: .date
            )
            .datePickerStyle(.graphical)
            Button("action", action: action)
        }
        .padding()
        .background(.mint)
    }
}
