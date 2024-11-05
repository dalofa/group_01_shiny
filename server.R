library("shiny")
library("bslib")
source(file = "app_functions.R")
# Define the Server (Backend)
server <- function(input, output) {
  # store the DNA sequence in a reactive expressions to pass it around
  dna_seq <- reactive({
    value = gene_dna(length = input$n_bases,
             base_probs = c(input$prob_A,
                            input$prob_T,
                            input$prob_C,
                            input$prob_G))
    })
  rna_seq <- reactive({
    value = transcribe_dna(dna_seq())
  })
  aa_seq <- reactive({
    value = translate_rna(rna_seq())
  })
  
  # Extract the values from the reactive variables to display them
  # This requires calling them as "functions" with the ()
  output$dna <- renderText({
    dna_seq()
  })
  # Transcirbe the value
  output$rna <- renderText({
    rna_seq()
  })
  
  output$aa_pep <- renderText({
    aa_seq()
  })
}