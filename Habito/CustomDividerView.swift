//
//  CustomDividerView.swift
//  Habito
//
//  Created by Maks Winters on 04.12.2023.
//

import SwiftUI

struct CustomDividerView: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .padding()
            .foregroundStyle(.white)
            .opacity(0.3)
    }
}

#Preview {
    CustomDividerView()
}
