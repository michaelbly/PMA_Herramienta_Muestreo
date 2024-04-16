library(markdown)

navbarPage(
  title = div(
    style = "display: flex; justify-content: space-between; align-items: center; width: 100%;",
    div("WFP COL | Herramienta de Muestreo", style="font-size: 25px; margin-top: 13px; margin-left: 0px; color: white; font-family: 'Open Sans';"), # Title on the left
  ),
  tags$head(
    tags$style(HTML("
        .navbar-default {
          background-color: #b1b1b3 !important;
        }
        .navbar .navbar-header .navbar-brand {
          padding-top: 0;
        }
        .navbar .navbar-header {
          flex-grow: 1;
        }
        .nav-tabs > li > a {
          font-size: 20px; /* Font size for tab titles */
          font-weight: bold; /* Make tab titles bold */}")),
    tags$style(
      ".btn-custom_5.active, .btn-custom_5:active, .btn-custom_5:focus, .btn-custom_5:hover {
      background: #B1B1B3 !important;
      color: #FFF !important;}",
      ".btn-custom_5 {border-color: #0D4A4F; color: #B1B1B3; background: #FFF; height: 5vh; font-size: 2.3vh !important; width: 28vh;}"
    ),
    tags$style(HTML("
      #rightLogo {
        height: 50px; /* Maintain the logo height */
        padding: 0px 0px 0px 0; /* Adjust padding as needed */
        float: right; /* Float right to keep it to the right of the tabs */}")),
    tags$script(HTML("
      $(document).ready(function() {
        // Create the logo image element
        var logoHtml = '<img src=\"wfp_logo.png\" id=\"rightLogo\">';
        // Append the logo to the navbar container
        $('.navbar .container-fluid').append(logoHtml);});"))
  ),
  
  windowTitle = "PMA COL | Herramienta de Muestreo",
           
           tabPanel("Introducción",
                    fluidRow(
                      column(width = 1),
                      column(width = 11,
                      h1("Instrucciones"),
                      align = "left"
                    )),
                    fluidRow(
                      column(1,
                             br()
                      ),
                      column(5,
                             h3("1) Defina tu metodología de muestreo"),
                             
                             p(strong("Muestreo aleatorio:"),"Muestreo aleatorio simple, una muestra aleatoria directamente del marco de muestreo que consiste en cada unidad de la población de interés, garantizando así la misma probabilidad de que cada unidad sea seleccionada."),
                             p(strong("Asignación aleatoria simple:"),"Asigna las encuestas en función del tamaño de la unidad proporcionada (por ejemplo, ciudades), para utilizarla si falta información sobre cada unidad de análisis."),
                             p(strong("Muestreo por conglomerados:"),"Los conglomerados, o Unidades Primarias de Muestreo (UPM), se seleccionan primero aleatoriamente, antes de seleccionar aleatoriamente un número determinado de unidades (por ejemplo, hogares) en cada conglomerado."),
                             p(strong("Estratificada:"),"Si se selecciona, se pedirá una variable que caracterice la estratificación del muestreo para estratificar la muestra."),
                             
                             br(),
                             
                             h3("2) Cargue su base de datos de la población"),
                             p("La aplicación sólo acepta archivos .csv; cada fila del csv debe ser la unidad primaria de muestreo.",strong("Las cabeceras del conjunto de datos NO deben contener caracteres especiales.")),
                             p("Cuando se cargue el archivo, dependiendo del tipo de muestreo cargado anteriormente, habrá que especificar algunos parámetros:")
                      ),
                      column(1,br()),
                      column(5,
                             h3("3) Defina sus parámetros de muestreo"),
                             p(strong("Nivel de confianza:"),"El nivel de confianza deseado."),
                             p(strong("Margen de error:"),"El margen de error deseado."),
                             p(strong("Proporción:"),"La proporción esperada en la muestra."),
                             p(strong("Buffer:"),"El porcentaje de búfer deseado."),
                             p(strong("Tamaño del conglomerado:"),"El número mínimo de entrevistas a realizar por conglomerado."),
                             p(strong("ICC:"),"Correlación intracluster: valor medio estimado en evaluaciones anteriores = 0,06."),
                             
                             br(),
                             
                             h3("4) Defina tu marco de muestreo"),
                             p("Al cargar el fichero, dependiendo del tipo de muestreo cargado anteriormente, habrá que especificar algunos parámetros:"),
                             p(strong("Cluster:"),"La variable que incluye el nombre de cada conglomerado, no debe haber duplicados en esta columna."),
                             p(strong("Estratificación:"),"La variable de los datos que define la estratificación."),
                             p(strong("Población:"),"La variable en los datos que define el número de población por UPM..",strong("Debe ser > 0 y > al tamaño del conglomerado.")),
                             
                             br(),
                             
                             h3("5) Muestreo"),
                             p(strong("Una vez definidos todos los parámetros, pulse Aplicar.")),
                             p("Cuando aparezca el objetivo en la pestaña, vaya a la pestaña 'Muestreo' y pulse '¡Muestrear! A continuación, podrá descargar la lista de unidades muestreadas y el resumen del muestreo.")
                      )
                    )
           ),
  tabPanel("Marco de muestreo",
           column(width = 6,
                  fluidRow(
                    column(width = 2),
                    column(width = 8, align="center",
                           style="color: #B1B1B3; font-size: 3vh; font-weight: bold;",  # Add font-weight: bold
                           HTML('1) Defina tu metodología de muestreo:')
                    ),
                    column(width = 2)
                  ),
                  
                  fluidRow(
                    style = "margin-top: 4vh; margin-bottom: 0vh;",
                    column(width = 1),
                    column(width = 5,
                           radioGroupButtons(
                             inputId = "samp_type",
                             label = div(tags$span("Modo de muestreo:", style = "color: #000000; font-size: 2.4vh;"), style = "text-align: center;"),
                             choices = c("Muestreo aleatorio", "Asignacion aleatoria simple", "Muestreo por conglomerados"),
                             width = "95%",
                             individual = F,
                             status = "custom_5",
                             direction = "vertical")),
                    
                    column(width = 5,
                           radioGroupButtons(
                             inputId = "stratified",
                             label = div(tags$span("Estratificacion:", style = "color: #000000; font-size: 2.4vh;"), style = "text-align: center;"),
                             choices = c("No etratificado", "Estratificado"),
                             width = "95%",
                             individual = F,
                             status = "custom_5",
                             direction = "vertical")),
                    
                    column(width = 1)
                  ), #CLOSE FLUIDROW WITH SAMPLING METHODOLOGY INPUTS
                  
                  fluidRow(
                    style = "margin-top: 8vh; margin-bottom: 0vh;",
                    column(width = 2),
                    column(width = 8, align="center",
                           style="color: #B1B1B3; font-size: 3vh; font-weight: bold;",  # Add font-weight: bold
                           HTML('2) Upload your population dataset:')
                    ),
                    column(width = 2)
                  ),
                  
                  fluidRow(
                    style = "margin-top: 0vh; margin-bottom: 0vh;",
                    column(width = 2),
                    column(width = 8, align="center",
                           fileInput('popdata', '',accept=c('text/csv', 'text/comma-separated-values,text/plain'))),
                    column(width = 2)
                  ),
                  
                  fluidRow(
                    style = "margin-top: 1vh; margin-bottom: 0vh;",
                    
                    actionButton("f_apply", "Aplicar",width ="300",style="color: #fff; background-color: #B1B1B3; border-color: #B1B1B3"),
                    align = "center"
                  ),
                  
                  fluidRow(
                    style = "margin-top: 8vh; margin-bottom: 0vh;",
                    
                    DT::dataTableOutput("target_frame")
                  )
                  
                  ), #CLOSE COLUMN ON THE LEFT
           
           
           column(width = 6,
                  fluidRow(
                  style = "margin-top: 0vh; margin-bottom: 0vh;",
                  column(width = 2),
                  column(width = 8, align="center",
                         style="color: #B1B1B3; font-size: 3vh; font-weight: bold;",  # Add font-weight: bold
                         HTML('3) Defina sus parámetros de muestreo:')),
                  column(width = 2)
                  ),
                  
                  fluidRow(
                    style = "margin-top: 4vh; margin-bottom: 0vh;",
                    column(width = 1),
                    column(width = 5,
                           numericInput('conf_level', 'Nivel de confianza:',0.95,min=0.70,	max=0.99, step =0.005)),
                    column(width = 5,
                           numericInput('e_marg', 'Margen de error:',0.05,min=0.01,	max=0.25, step =0.005))
                  ),
                  
                  fluidRow(
                    style = "margin-top: 1vh; margin-bottom: 0vh;",
                    column(width = 1),
                    column(width = 5,
                           numericInput('pror', 'Proporcion',0.5,min=0.01,	max=1, step =0.05)),
                    column(width = 5,
                           numericInput('buf', 'Buffer',0.05,min=0.00,	max=0.50, step =0.01))
                  ),
                  
                  conditionalPanel(condition = "input.samp_type == 'Muestreo por conglomerados'",
                                   fluidRow(
                                     style = "margin-top: 1vh; margin-bottom: 0vh;",
                                     column(width = 1),
                                     column(width = 5,
                                            numericInput('cls', 'Cluster size',5,min=2, step =1)),
                                     column(width = 5,
                                            numericInput('ICC', 'ICC',0.06,min=0.01,	max=0.5, step =0.01))
                                   )
                  ),
                  
                  
              conditionalPanel(condition = "input.samp_type == 'Muestreo por conglomerados'|| input.samp_type =='Asignacion aleatoria simple' || input.stratified=='Estratificado'",
                                   
                  fluidRow(
                    style = "margin-top: 8vh; margin-bottom: 0vh;",
                    column(width = 2),
                    column(width = 8, align="center",
                           style="color: #B1B1B3; font-size: 3vh; font-weight: bold;",  # Add font-weight: bold
                           HTML('4) Defina su marco de muestreo:')),
                    column(width = 2)
                  ),
                  
                  fluidRow(
                    style = "margin-top: 1vh; margin-bottom: 0vh;",
                    column(width = 1),
                    column(width = 5,
                           conditionalPanel(condition = "input.samp_type == 'Muestreo por conglomerados'|input.samp_type =='Asignacion aleatoria simple'",
                                            selectInput('colpop', 'Población de referencia', choices = NULL)
                           )),
                    column(width = 5,
                           conditionalPanel(condition = "input.samp_type == 'Muestreo por conglomerados'",
                                            selectInput('col_psu', 'Clúster de referencia', choices = NULL)
                           ))
                  ),
                  
                  fluidRow(
                    style = "margin-top: 1vh; margin-bottom: 0vh;",
                    column(width = 1),
                    column(width = 5,
                           conditionalPanel(condition = "input.stratified=='Estratificado'",
                                            selectInput('strata', 'Estrato de referencia', choices = NULL, multiple = F)
                           )),
                    column(width = 5)
                  )
                  
              )
                  
                  
                  ), #CLOSE COLUMN ON THE RIGHT
           
  ),
  
  
           tabPanel("Muestra", 
                    sidebarLayout(
                      sidebarPanel(width = 2, align = "center",
                               fluidRow(
                                 style = "margin-top: 0.5vh; margin-bottom: 0vh;",
                                 actionButton("desButton", "MUESTRAR",width ="95%",style="color: #fff; background-color: #f24c02; border-color: #f24c02"),
                               ),
                               fluidRow(
                                 style = "margin-top: 2vh; margin-bottom: 0vh;",
                                 downloadButton("downloadBtn2", "Download Resumen")
                               ),
                               fluidRow(
                                 style = "margin-top: 2vh; margin-bottom: 0vh;",
                                 downloadButton("downloadBtn", "Download MUESTRA")
                               )
                        ),
                      
                      mainPanel(
                        fluidRow(
                          style = "margin-top: 5vh; margin-bottom: 5vh;",
                          column(width = 2),
                          column(width = 8, align="center",
                                 style="color: #B1B1B3; font-size: 4vh; font-weight: bold;",  # Add font-weight: bold
                                 HTML('Resumen del muestreo:')),
                          column(width = 2)
                        ),
                        DT::dataTableOutput("test_1"),

                        
                        fluidRow(
                          style = "margin-top: 10vh; margin-bottom: 0vh;",
                          column(width = 2),
                          column(width = 8, align="center",
                                 style="color: #B1B1B3; font-size: 4vh; font-weight: bold;",  # Add font-weight: bold
                                 HTML('Muestra Final:')),
                          column(width = 2)
                        ),
                        DT::dataTableOutput("sampling_output")
                      )
                    )
           ),
  div(
    style = "display: flex; justify-content: space-between; align-items: center; width: 100%;",
    img(src = 'wfp_logo.png', style = "height: 60px; margin-left: 12vw; padding-right: 10px; padding-bottom: 13px; padding-top: 0.4vh;") # Logo on the right
    # Title on the left
  )
) #CLOSE NAVBARPAGE


