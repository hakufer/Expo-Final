# Cargar paquetes necesarios
library(shiny)
library(shinydashboard)
library(ggplot2)
library(dplyr)

# Definir la interfaz de usuario para el dashboard
ui <- dashboardPage(
  dashboardHeader(title = "Reporte Migración"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Migración Venezolana", tabName = "migracion_venezolana", icon = icon("globe"))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "migracion_venezolana",
              fluidPage(
                # Primera Sección: Añadir el Texto Descriptivo del Contexto
                box(
                  title = "Contexto de la Migración Venezolana",
                  width = 12,
                  solidHeader = TRUE,
                  status = "primary",
                  collapsible = TRUE,
                  p("Los patrones de migración regional estuvieron influenciados por desarrollos políticos y de seguridad, especialmente las elecciones presidenciales de Venezuela el 28 de julio de 2024."),
                  p("Los países de América del Sur están a la espera de un potencial aumento de flujos de población migrante venezolana después de los resultados de las elecciones, marcando el 10 de enero como una fecha importante (inicio del nuevo mandato de Maduro)."),
                  tags$ul(
                    tags$li("Argentina y Ecuador tomaron medidas para flexibilizar el ingreso y la regularización (septiembre 2024)."),
                    tags$li("Chile y Perú tomaron medidas para dificultar el acceso."),
                    tags$li("Solo Colombia y Brasil observaron un aumento de población venezolana hasta ahora.")
                  )
                ),
                
                # Segunda Sección: Añadir el Texto Descriptivo de las Tendencias Clave
                box(
                  title = "Tendencias Clave",
                  width = 12,
                  solidHeader = TRUE,
                  status = "primary",
                  collapsible = TRUE,
                  p("Reducción del 71% en la migración irregular a través del Darién en comparación con el tercer trimestre de 2023, atribuida a controles fronterizos más estrictos en Panamá."),
                  p("Tensiones diplomáticas tras las elecciones en Venezuela afectaron los servicios consulares y las políticas migratorias en países anfitriones como Panamá, Perú y República Dominicana."),
                  p("Se observaron cambios significativos en los flujos migratorios en México, Colombia, Ecuador y Perú."),
                  p("Muchos venezolanos utilizaron países de tránsito como Colombia para acceder a vuelos internacionales o servicios no disponibles en Venezuela.")
                ),
                
                # Tercera Sección: Cargar Imágenes
                tabBox(
                  width = 12,
                  tabPanel("Entradas y Salidas de Migrantes Venezolanos en América Latina", 
                           imageOutput("imagenEntradasSalidas")),
                  tabPanel("Rutas Principales en Centroamérica", 
                           imageOutput("imagenRutaCentroamerica")),
                  tabPanel("Entradas Irregulares - Darién", 
                           imageOutput("imagenEntradasIrregulares")),
                  tabPanel("Proporción Nacionalidades - Darién", 
                           imageOutput("imagenNacionalidadesDarien")),
                  tabPanel("Rutas Migración en Suramérica", 
                           imageOutput("imagenRutasSuramerica"))
                )
              )
      )
    )
  )
)

# Definir el servidor para el dashboard
server <- function(input, output) {
  
  # Lista de imágenes a cargar
  images <- list(
    "imagenEntradasSalidas" = "www/EntradasySalidas.png",
    "imagenRutaCentroamerica" = "www/ruta_centroamerica.png",
    "imagenEntradasIrregulares" = "www/entradas_irregulares.png",
    "imagenNacionalidadesDarien" = "www/nacionaliades_en_la_entrada_darien.png",
    "imagenRutasSuramerica" = "www/rutas_en_suramerica.png"
  )
  
  # Función genérica para renderizar las imágenes
  lapply(names(images), function(image_name) {
    output[[image_name]] <- renderImage({
      file_path <- images[[image_name]]
      if (file.exists(file_path)) {
        list(src = file_path,
             contentType = "image/png",
             width = 600,
             height = 400,
             alt = paste("Imagen para", image_name))
      } else {
        stop(paste("El archivo no se encontró en la ruta:", file_path))
      }
    }, deleteFile = FALSE)
  })
}

# Ejecutar la aplicación shiny
shinyApp(ui = ui, server = server)

