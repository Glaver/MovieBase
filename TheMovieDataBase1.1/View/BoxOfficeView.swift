//
//  BudgetView.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 15/10/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//

import SwiftUI

struct BoxOfficeView: View {

    var budget: Int
    var revenue: Int

    var lengtBudget: Int = 0
    var lenghtRevenue: Int = 0

    var body: some View {
        if budget != 0 && revenue != 0 {
            VStack(alignment: .leading, spacing: 15) {
                budgetView
                revenueView
            }
            .padding(15)
        } else if budget != 0 && revenue == 0 {
            VStack(alignment: .leading, spacing: 15) { budgetView }
        } else {
            //Text(" ")
        }
    }

    var budgetView: some View {
        VStack {
            Text(LocalizedStringKey("Budget"))
                .font(.system(size: 22))
                .bold()
                .padding(10)
            Text(" $" + String(budget.formattedWithSeparator))
                .bold()
                .frame(width: 200, height: 30)
                .background(Color.blue.opacity(0.9))
                .cornerRadius(10)
                .shadow(color: Color.blue.opacity(0.9), radius: 20, x: 10, y: 10)

        }
    }

    var revenueView: some View {
        VStack {
            Text(LocalizedStringKey("Revenue"))
                .font(.system(size: 22))
                .bold()
                .padding(10)
            Text(" $" + String(revenue.formattedWithSeparator))
                .bold()
                .frame(width: 350, height: 30)
                .background(Color.green.opacity(0.9))
                .cornerRadius(10)
                .shadow(color: Color.green.opacity(0.9), radius: 20, x: 10, y: 10)
        }
    }

    init(budget: Int, revenue: Int) {
        self.budget = budget
        self.revenue = revenue
    }
}

//struct BudgetView_Previews: PreviewProvider {
//    static var previews: some View {
//        BudgetView()
//    }
//}
extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        return formatter
    }()
}

extension Numeric {
    var formattedWithSeparator: String { Formatter.withSeparator.string(for: self) ?? "" }
}
