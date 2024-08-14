
import SwiftUI

struct ToastView: View {
    var style: ToastStyle
    var message: String
    var width = CGFloat.infinity
    var onCancelTapped: (() -> Void)
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            Image(systemName: style.iconFileName)
                .foregroundColor(style.themeColor)
            Text(message)
                .font(Font.caption)
            
            Spacer(minLength: 10)
            
            Button {
                onCancelTapped()
            } label: {
                Image(systemName: "xmark")
                    .foregroundColor(style.themeColor)
            }
        }
        .padding()
        .frame(minWidth: 0, maxWidth: width)
        .cornerRadius(8)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Material.regular)
        )
        .padding(.horizontal, 16)
        .transition(.slide)
    }
}

#Preview {
    struct Preview: View {
        @State private var toast: Toast? = nil
        
        var body: some View {
            ZStack {
                LinearGradient(colors: [.blue, .orange], startPoint: .top, endPoint: .leading).ignoresSafeArea()
                Text("P")
            }
                .onAppear() {
                    ToastStyle.errorColor = .purple
                    toast = .init(style: .error, message: "Esto qué carajo es")
                }
                .toastView(toast: $toast)
        }
    }
    return Preview()
}

struct ToastModifier: ViewModifier {
    
    @Binding var toast: Toast?
    @State private var workItem: DispatchWorkItem?
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(
                ZStack {
                    mainToastView()
                        .offset(y: 32)
                }.animation(.spring(), value: toast)
            )
            .onChange(of: toast) { _, value in
                showToast()
            }
    }
    
    @ViewBuilder func mainToastView() -> some View {
        if let toast = toast {
            VStack {
                ToastView(
                    style: toast.style,
                    message: toast.message,
                    width: toast.width
                ) {
                    dismissToast()
                }.transition(.scale)
                Spacer()
            }
            .transition(
                .asymmetric(
                    insertion: .push(from: .top),
                    removal: .push(from: .bottom)
                )
            )
        }
    }
    
    private func showToast() {
        guard let toast = toast, toast.performHapticFeedbacks else { return }
        
        switch toast.style {
        case .error:
            UINotificationFeedbackGenerator().notificationOccurred(.error)
        case .warning:
            UINotificationFeedbackGenerator().notificationOccurred(.warning)
        case .success:
            UINotificationFeedbackGenerator().notificationOccurred(.success)
        case .info:
            UIImpactFeedbackGenerator(style: .light)
                .impactOccurred()
        }
        
        if toast.duration > 0 {
            workItem?.cancel()
            
            let task = DispatchWorkItem {
                dismissToast()
            }
            
            workItem = task
            DispatchQueue.main.asyncAfter(deadline: .now() + toast.duration, execute: task)
        }
    }
    
    private func dismissToast() {
        withAnimation {
            toast = nil
        }
        
        workItem?.cancel()
        workItem = nil
    }
}

extension View {
    
    func toastView(toast: Binding<Toast?>) -> some View {
        self.modifier(ToastModifier(toast: toast))
    }
}
