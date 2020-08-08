//
//  ContentView.swift
//  Calculator
//
//  Created by Abhishek on 08/08/2020.
//  Copyright © 2020 apm. All rights reserved.
//

import SwiftUI

extension Color {
    static let offWhite = Color(red: 225 / 255, green: 225 / 255, blue: 235 / 255)
    static let offWhite1 = Color(red: 225 / 255, green: 225 / 255, blue: 245 / 255)
}

enum CalculatorButton: String {
    case zero, decimal ,one , two, three, four, five, six, seven, eight, nine
    case equals, plus, minus, multiply, divide
    case ac, plusMinus, percent
    
    var backgroundColor: Color {
        switch self {
        case .zero, .decimal, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine:
            return .offWhite
        case .ac, .plusMinus, .percent:
            return .offWhite1
        default:
            return .offWhite1
        }
    }
    
    var title: String {
        switch self {
        case .zero: return "0"
        case .one: return "1"
        case .two: return "2"
        case .three: return "3"
        case .four: return "4"
        case .five: return "5"
        case .six: return "6"
        case .seven: return "7"
        case .eight: return "8"
        case .nine: return "9"
        case .decimal: return "."
        case .plus: return "+"
        case .minus: return "-"
        case .divide: return "/"
        case .multiply: return "X"
        case .plusMinus: return "+/-"
        case .percent: return "%"
        case .equals: return "="
            
        default:
            return "AC"
        }
    }
}

class GlobalEnvironment: ObservableObject {
    @Published var display = "0"
    
    func receiveInput(calculatorButton: CalculatorButton) {
        self.display = calculatorButton.title
    }
}

struct ContentView: View {
    @EnvironmentObject var env: GlobalEnvironment
    
    let buttons: [[CalculatorButton]] = [
        [.ac, .plusMinus, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .decimal, .equals]
    ]
    
    var body: some View {
        ZStack (alignment: .bottom){
            Color.offWhite.edgesIgnoringSafeArea(.all)
            VStack(spacing: 12) {
                HStack {
                    Spacer()
                    Text(env.display).foregroundColor(.white)
                        .font(.system(size: 64))
                }.padding()
                
                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 12){
                        ForEach(row, id: \.self) {button in
                            CalculatorButtonView(button: button)
                        }
                    }
                }
            }.padding(.bottom)
        }
    }
}

struct CalculatorButtonView: View {
    var button: CalculatorButton
    @EnvironmentObject var env: GlobalEnvironment
    
    var body: some View{
        Button(action: {
            self.env.receiveInput(calculatorButton: self.button)
        }) {
            Text(button.title)
                .font(.system(size: 32))
                .frame(width: self.buttonWidth(button: button), height: (UIScreen.main.bounds.width - 5 * 12) / 4)
                .foregroundColor(.gray)
                .background(button.backgroundColor)
                .cornerRadius(self.buttonWidth(button: button))
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
            .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
            
        }
    }
    
    private func buttonWidth(button: CalculatorButton) -> CGFloat {
        if button == .zero {
            return (UIScreen.main.bounds.width - 4 * 12) / 4 * 2
        }
        return (UIScreen.main.bounds.width - 5 * 12) / 4
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(GlobalEnvironment())
    }
}
