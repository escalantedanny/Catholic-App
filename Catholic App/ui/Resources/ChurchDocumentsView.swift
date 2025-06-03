import SwiftUICore
import SwiftUI
struct ChurchDocumentsView: View {
    var body: some View {
            List {
                Section(header: Text("Encíclicas")) {
                    Link("Laudato Si'", destination: URL(string: "https://www.vatican.va/content/francesco/es/encyclicals/documents/papa-francesco_20150524_enciclica-laudato-si.html")!)
                    Link("Evangelii Gaudium", destination: URL(string: "https://www.vatican.va/content/francesco/es/apost_exhortations/documents/papa-francesco_esortazione-ap_20131124_evangelii-gaudium.html")!)
                    Link("Fratelli Tutti", destination: URL(string: "https://www.vatican.va/content/francesco/es/encyclicals/documents/papa-francesco_20201003_enciclica-fratelli-tutti.html")!)
                    Link("Caritas in Veritate", destination: URL(string: "https://www.vatican.va/content/benedict-xvi/es/encyclicals/documents/hf_ben-xvi_enc_20090629_caritas-in-veritate.html")!)
                    Link("Deus Caritas Est", destination: URL(string: "https://www.vatican.va/content/benedict-xvi/es/encyclicals/documents/hf_ben-xvi_enc_20051225_deus-caritas-est.html")!)
                }
                
                Section(header: Text("Concilio Vaticano II")) {
                    Link("Lumen Gentium", destination: URL(string: "https://www.vatican.va/archive/hist_councils/ii_vatican_council/documents/vat-ii_const_19641121_lumen-gentium_sp.html")!)
                    Link("Dei Verbum", destination: URL(string: "https://www.vatican.va/archive/hist_councils/ii_vatican_council/documents/vat-ii_const_19651118_dei-verbum_sp.html")!)
                    Link("Sacrosanctum Concilium", destination: URL(string: "https://www.vatican.va/archive/hist_councils/ii_vatican_council/documents/vat-ii_const_19631204_sacrosanctum-concilium_sp.html")!)
                    Link("Gaudium et Spes", destination: URL(string: "https://www.vatican.va/archive/hist_councils/ii_vatican_council/documents/vat-ii_const_19651207_gaudium-et-spes_sp.html")!)
                }
                
                Section(header: Text("Otros documentos")) {
                    Link("Catecismo de la Iglesia Católica", destination: URL(string: "https://www.vatican.va/archive/catechism_sp/index_sp.html")!)
                    Link("Compendio del Catecismo", destination: URL(string: "https://www.vatican.va/archive/compendium_ccc/documents/archive_2005_compendium-ccc_sp.html")!)
                    Link("Youcat (para jóvenes)", destination: URL(string: "https://www.youcat.org/es/")!)
                    Link("Jubileo 2025", destination: URL(string: "https://www.iubilaeum2025.va/es.html")!)
                    Link("Código de Derecho Canónico", destination: URL(string: "https://www.vatican.va/archive/cod-iuris-canonici/cic_index_sp.html")!)
                }
            }
            .navigationTitle("📚 Documentos Eclesiásticos")
        }
}
