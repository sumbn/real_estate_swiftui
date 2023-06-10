//
//  ExtensionView.swift
//  AuthenWithFirebase
//
//  Created by daktech on 5/10/23.
//

import Foundation
import SwiftUI


extension View {
    func showToast(_ message: String) {
        guard let view = UIApplication.shared.windows.first?.rootViewController?.view else {
            return
        }
        
    }
}

extension View {
    @ViewBuilder
    func toast(isPresented: Binding<Bool>, message: String) -> some View {
        ZStack {
            self
            if isPresented.wrappedValue {
                ToastView(message: message)
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.3))
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                isPresented.wrappedValue = false
            }
        }
    }
}

struct ToastView: View {
    let message: String
    
    var body: some View {
        Text(message)
            .padding()
            .background(Color.black.opacity(0.8))
            .foregroundColor(.white)
            .cornerRadius(10)
    }
}
