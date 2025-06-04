import SwiftUI

struct HowToPrayView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("how_to_pray_title")
                    .font(.title)
                    .bold()
                    .padding(.bottom, 8)

                Group {
                    Text("pray_op_1")
                    Text("pray_op_2")
                    Text("pray_op_3")
                    Text("pray_op_4")
                    Text("pray_op_5")
                    Text("pray_op_6")
                    Text("pray_op_7")
                    Text("pray_op_8")
                }
                .font(.body)
            }
            .padding()
        }
        .background(Color(.systemBackground))
    }
}

#Preview {
    HowToPrayView()
        .environment(\.colorScheme, .dark)
}
