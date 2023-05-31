//
//  AddSubscriptionView.swift
//  kiwi R
//
//  Created by jarvis on 2023/5/21.
//

import SwiftUI

struct AddSubscriptionView: View {
    
    //@Binding 属性包装的 isPresented 和 onAdd，以便在视图之间进行状态传递和操作
    @Binding var isPresented: Bool
    var onAdd: (URL) -> Void
    
    //输入订阅地址
    @State private var urlInput: String = ""
    
    @State private var showErrorAlert = false
    
    
    var body: some View {
        NavigationView{
            VStack{
                TextField("请输入订阅源",text: $urlInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                                        
                Button("Add"){
                    addSubscription()
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(10)
                .disabled(!isValidURL(urlInput))
                
                
            }
            .padding()
            .navigationTitle("添加订阅")
            .navigationBarItems(leading: cancelButton)
            .alert(isPresented: $showErrorAlert) {
                Alert(title: Text("Error"), message: Text("Invalid URL"), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    //取消
    private var cancelButton: some View{
        Button("Cancel") {
                    isPresented = false
                }
    }
    //添加
    private func addSubscription() {
            guard let url = URL(string: urlInput) else {
                showErrorAlert = true
                return
            }

            onAdd(url)
            isPresented = false
        }
    
    private func isValidURL(_ string: String) -> Bool {
            let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
            let matches = detector?.matches(in: string, options: [], range: NSRange(location: 0, length: string.utf16.count))

            if let match = matches?.first {
                return match.range.length == string.utf16.count
            } else {
                return false
            }
        }
}

struct AddSubscriptionView_Previews: PreviewProvider {
    static var previews: some View {
        AddSubscriptionView(isPresented: .constant(true), onAdd: { _ in })
    }
}
