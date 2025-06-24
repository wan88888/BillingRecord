//
//  ContentView.swift
//  BillingRecord
//
//  Created by wan on 2025/6/24.
//

import SwiftUI

// 交易类型枚举
enum TransactionType: String, CaseIterable, Hashable {
    case income = "收入"
    case expense = "支出"
    
    var color: Color {
        switch self {
        case .income:
            return .green
        case .expense:
            return .red
        }
    }
    
    var icon: String {
        switch self {
        case .income:
            return "plus.circle.fill"
        case .expense:
            return "minus.circle.fill"
        }
    }
}

// 交易数据模型
struct Transaction: Identifiable {
    let id = UUID()
    let type: TransactionType
    let amount: Double
    let description: String
    let date: Date
}

struct ContentView: View {
    @State private var transactions: [Transaction] = []
    @State private var showingAddTransaction = false
    @State private var newAmount = ""
    @State private var newDescription = ""
    @State private var selectedType: TransactionType = .expense
    
    // 计算总余额
    private var totalBalance: Double {
        transactions.reduce(0) { total, transaction in
            switch transaction.type {
            case .income:
                return total + transaction.amount
            case .expense:
                return total - transaction.amount
            }
        }
    }
    
    // 格式化金额显示
    private func formatAmount(_ amount: Double) -> String {
        return String(format: "¥%.2f", amount)
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // 余额显示区域
                VStack {
                    Text("当前余额")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    Text(formatAmount(totalBalance))
                        .font(.system(size: 36, weight: .bold, design: .rounded))
                        .foregroundColor(totalBalance >= 0 ? .green : .red)
                        .padding(.top, 8)
                }
                .padding(.vertical, 30)
                .frame(maxWidth: .infinity)
                .background(Color(.systemGray6))
                
                // 交易列表
                List {
                    if transactions.isEmpty {
                        VStack(spacing: 16) {
                            Image(systemName: "list.bullet.clipboard")
                                .font(.system(size: 50))
                                .foregroundColor(.secondary)
                            
                            Text("暂无交易记录")
                                .font(.headline)
                                .foregroundColor(.secondary)
                            
                            Text("点击右上角的 + 按钮开始记录")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 50)
                        .listRowBackground(Color.clear)
                    } else {
                        ForEach(transactions.sorted(by: { $0.date > $1.date })) { transaction in
                            TransactionRow(transaction: transaction)
                        }
                        .onDelete(perform: deleteTransaction)
                    }
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("账单记录")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddTransaction = true
                    }) {
                        Image(systemName: "plus")
                            .font(.title2)
                    }
                }
            }
        }
        .sheet(isPresented: $showingAddTransaction) {
            AddTransactionView(
                amount: $newAmount,
                description: $newDescription,
                selectedType: $selectedType,
                onSave: addTransaction,
                onCancel: {
                    showingAddTransaction = false
                    resetForm()
                }
            )
        }
    }
    
    // 添加交易
    private func addTransaction() {
        guard let amount = Double(newAmount), amount > 0 else { return }
        
        let transaction = Transaction(
            type: selectedType,
            amount: amount,
            description: newDescription.isEmpty ? "未备注" : newDescription,
            date: Date()
        )
        
        transactions.append(transaction)
        showingAddTransaction = false
        resetForm()
    }
    
    // 删除交易
    private func deleteTransaction(at offsets: IndexSet) {
        let sortedTransactions = transactions.sorted(by: { $0.date > $1.date })
        let transactionsToDelete = offsets.map { sortedTransactions[$0] }
        
        for transaction in transactionsToDelete {
            if let index = transactions.firstIndex(where: { $0.id == transaction.id }) {
                transactions.remove(at: index)
            }
        }
    }
    
    // 重置表单
    private func resetForm() {
        newAmount = ""
        newDescription = ""
        selectedType = .expense
    }
}

// 交易行视图
struct TransactionRow: View {
    let transaction: Transaction
    
    private func formatAmount(_ amount: Double) -> String {
        return String(format: "%.2f", amount)
    }
    
    var body: some View {
        HStack {
            // 类型图标
            Image(systemName: transaction.type.icon)
                .foregroundColor(transaction.type.color)
                .font(.title2)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(transaction.description)
                    .font(.headline)
                
                Text(transaction.date, style: .date)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            // 金额显示
            VStack(alignment: .trailing) {
                Text("\(transaction.type == .income ? "+" : "-")¥\(formatAmount(transaction.amount))")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(transaction.type.color)
                
                Text(transaction.type.rawValue)
                    .font(.caption)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 2)
                    .background(transaction.type.color.opacity(0.1))
                    .foregroundColor(transaction.type.color)
                    .cornerRadius(8)
            }
        }
        .padding(.vertical, 8)
    }
}

// 添加交易视图
struct AddTransactionView: View {
    @Binding var amount: String
    @Binding var description: String
    @Binding var selectedType: TransactionType
    let onSave: () -> Void
    let onCancel: () -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("交易类型")) {
                    Picker("交易类型", selection: $selectedType) {
                        Text("收入").tag(TransactionType.income)
                        Text("支出").tag(TransactionType.expense)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    // 显示选中类型的图标和颜色提示
                    HStack {
                        Image(systemName: selectedType.icon)
                            .foregroundColor(selectedType.color)
                            .font(.title2)
                        Text("已选择: \(selectedType.rawValue)")
                            .foregroundColor(selectedType.color)
                            .font(.headline)
                        Spacer()
                    }
                    .padding(.vertical, 8)
                }
                
                Section(header: Text("金额")) {
                    TextField("输入金额", text: $amount)
                        .keyboardType(.decimalPad)
                        .font(.title2)
                }
                
                Section(header: Text("备注")) {
                    TextField("输入备注信息（可选）", text: $description)
                        .font(.body)
                }
            }
            .navigationTitle("添加交易")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("取消") {
                        onCancel()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("保存") {
                        onSave()
                    }
                    .disabled(amount.isEmpty || Double(amount) == nil || Double(amount)! <= 0)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
