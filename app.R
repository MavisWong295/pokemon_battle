library(shiny)
library(dplyr)
library(shinyjs)


df <- read.csv("data/pokemon_data.csv") |> 
  mutate(type2= case_when(type2 == "" ~ 'NA',
                          type2 != "" ~ type2))
g <- unique(df$generation)
t1 <- unique(df$type1)
t2 <- unique(df$type2)
l <- unique(df$special_group)
n <- df$name

ui <- fluidPage(
  useShinyjs(),
  tags$head(
    tags$style(HTML("
      .title-1 {
        background-color: #CC0000;
        color: white;
        font-size: 36px;
        font-family: 'Arial', sans-serif;
        padding: 20px;
        text-align: center;
        margin-bottom: 30px}
        
      .column-1 {
        text-align: center;
        color: white;
        background-color: black;
        display: flex;
        margin-left: 5px;
        margin-right: 5px;
        flex-direction: row; 
        justify-content: space-evenly;
        align-items: center;
        padding: 10px;
      }
      .column-content {
        text-align: center;
        color: black;
        background-color: #FFCC00; 
        padding-left:10px;
        padding-right:10px;
        padding-top:1px;
        padding-bottom:1px;
        margin-left: 5px;
        margin-right: 5px
      }
      .plot-content {
        margin-bottom: 30px;
        padding:30px;
      }
 
      .text-1 {
        text-align: left;
      }
      .text-2 {
        text-align: right;
      }
      .img{
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
      }
      .pokemon-card {
        border: 3px solid #444;  
        border-radius: 10px;    
        padding: 15px;           
        margin: 10px;            
        background-color: #f9f9f9; 
        box-shadow: 3px 3px 10px rgba(0, 0, 0, 0.2); 
      }
      


    "))),
  
  div(class = "title-1", "Pokemon Battle"),
  sidebarPanel(width=3,
               fluidRow(
                 column(6,
                        fluidRow(div(class= "column-1", h4("Pokemon 1:"))),
                        fluidRow(div(class= "column-content", 
                                     selectInput("gen1", "Generation", choices = c(Choose='', g), selectize=TRUE))),
                        fluidRow(div(class= "column-content", 
                                     selectInput("legend1", "Special Pokemon?", choices = c(Choose='', l), selectize=TRUE))),
                        fluidRow(div(class= "column-content",
                                     selectInput("type1_1", "Type 1:", choices = c(Choose='', t1), selectize=TRUE))),
                        fluidRow(div(class= "column-content",
                                     selectInput("type2_1", "Type 2:", choices = c(Choose='', t2), selectize=TRUE))),
                        fluidRow(div(class= "column-content", 
                                     selectInput('name1', "Select your pokemon:", choices = c(Choose='', n), selectize=TRUE))),
                        fluidRow(div(class= "column-content", 
                                     checkboxInput("reset1", "Reset", value = FALSE)))),
                 column(6,
                        fluidRow(div(class= "column-1",h4("Pokemon 2:"))),
                        fluidRow(div(class= "column-content",
                                     selectInput("gen2", "Generation", choices = c(Choose='', g), selectize=TRUE))),
                        fluidRow(div(class= "column-content",
                                     selectInput("legend2", "Special Pokemon?", choices = c(Choose='', l), selectize=TRUE))),
                        fluidRow(div(class= "column-content",
                                     selectInput("type1_2", "Type 1:", choices = c(Choose='', t1), selectize=TRUE))),
                        fluidRow(div(class= "column-content",
                                     selectInput("type2_2", "Type 2:", choices = c(Choose='', t2), selectize=TRUE))),
                        fluidRow(div(class= "column-content",
                                     selectInput('name2', "Select your pokemon:", choices = c(Choose='', n), selectize=TRUE))),
                        fluidRow(div(class= "column-content", checkboxInput("reset2", "Reset", value = FALSE))))
               )),
  
  
  mainPanel(width=9,
            column(6, div(class= "pokemon-card",
                          fluidRow(
                            column(6,
                                   fluidRow(
                                     column(6, uiOutput("name_1")), 
                                     column(6,div(class='text-1', h5(textOutput("Name1"))))),
                                   fluidRow(
                                     column(6, uiOutput("gen_1")),  
                                     column(6, div(class='text-1', h5(textOutput("Gen1"))))),
                                   fluidRow(
                                     column(6, uiOutput("type_1")), 
                                     column(6, div(class='text-1', h5(textOutput("Type1"))))),
                                   fluidRow( 
                                     column(6, uiOutput("ability_1")), 
                                     column(6, div(class='text-1',h5(textOutput("Ability1"))))),
                                   fluidRow(
                                     column(6, uiOutput("legend_1")), 
                                     column(6, div(class='text-1', h5(textOutput("Cat1")))))),
                            column(6, div(class='img', imageOutput("img1", height='240px')))), 
                          plotOutput("stat1", height = "300px", width='29vw'))),
            
            
            
            column(6,div(class= "pokemon-card",
                         fluidRow(
                           column(6,
                                  fluidRow(
                                    column(6, uiOutput("name_2")), 
                                    column(6, div(class='text-1', h5(textOutput("Name2"))))),
                                  fluidRow(
                                    column(6, uiOutput("gen_2")),  
                                    column(6, div(class='text-1', h5(textOutput("Gen2"))))),
                                  fluidRow(
                                    column(6, uiOutput("type_2")), 
                                    column(6, div(class='text-1', h5(textOutput("Type2"))))),
                                  fluidRow( 
                                    column(6, uiOutput("ability_2")), 
                                    column(6, div(class='text-1',h5(textOutput("Ability2"))))),
                                  fluidRow(
                                    column(6, uiOutput("legend_2")), 
                                    column(6, div(class='text-1', h5(textOutput("Cat2")))))),
                           column(6, div(class='img', imageOutput("img2", height='240px')))), 
                         plotOutput("stat2", height = "300px",width='29vw')))
  ))









server <- function(input, output, session) {
  
  # Pokemon 1
  observe({
    if (input$gen1 == ""){g1 = g} else{g1=input$gen1}
    if (input$type1_1 == ""){t11 = t1} else{t11=input$type1_1}
    if (input$type2_1 == ""){t21 = t2} else{t21=input$type2_1}
    if (input$legend1 == ""){l1 = l} else{l1=input$legend1}
    
    data1 <- df |> 
      filter(generation %in% g1,
             type1 %in% t11,
             type2 %in% t21,
             special_group %in% l1)
    
    updateSelectInput(session, 'type1_1', choices = c(Choose='', unique(data1$type1)), selected = input$type1_1)
    updateSelectInput(session, 'type2_1', choices = c(Choose='', unique(data1$type2)), selected = input$type2_1)
    updateSelectInput(session, 'legend1', choices = c(Choose='', unique(data1$special_group)), selected = input$legend1)
    updateSelectInput(session, 'name1', choices = c(Choose='', unique(data1$name)), selected = input$name1)
    
    observeEvent(input$reset1,{
      if (input$reset1==TRUE){
        shinyjs::reset("gen1")
        shinyjs::reset("type1_1")
        shinyjs::reset("type2_1")
        shinyjs::reset("legend1")
        shinyjs::reset("name1")
        shinyjs::reset("reset1")}
    })
    
    data1 <- df |> 
      filter(name == input$name1) |> 
      mutate(type2= case_when(type2 == "NA" ~ '', type2 != "NA" ~ type2))
    
    
    stats1 <- data1 |> select(hp, attack, defense, sp_atk, sp_def, speed)
    
    output$name_1 <- renderUI({req(input$name1)
      div(class= "text-2", h5("Name:"))})
    output$Name1 <- renderText({req(input$name1) 
      data1$name})
    
    output$gen_1 <- renderUI({req(input$name1)
      div(class= "text-2", h5("Generation:"))})
    output$Gen1 <- renderText({req(input$name1) 
      data1$generation})
    
    output$type_1 <- renderUI({req(input$name1)
      div(class= "text-2", h5("Type:"))})
    output$Type1 <- renderText({req(input$name1) 
      paste0(data1$type1, " / ", data1$type2)})
    
    output$ability_1 <- renderUI({req(input$name1)
      div(class= "text-2", h5("Ability:"))})
    output$Ability1 <- renderText({req(input$name1) 
      paste0(data1$ability1, " / ", data1$ability2, " / ", data1$hidden_ability)})
    
    output$legend_1 <- renderUI({req(input$name1)
      div(class= "text-2", h5("Legendary:"))})
    output$Cat1 <- renderText({req(input$name1) 
      data1$special_group})
    
    output$img1 <- renderImage({req(input$name1)
      list(src = paste0("data/",data1$Image), width=180, height=170)})
    
    output$stat1 <- renderPlot({req(input$name1) 
      par(bg = "lightgray", mar = c(4, 6, 2, 3))
      bp1 <- barplot(
        as.numeric(stats1), 
        names.arg = c("Speed", "Sp. Def", "Sp. Atk","Defense", "Attack", "HP" ),
        horiz=TRUE, 
        xlim = c(0, 255), 
        col=c("pink", "lightgreen","steelblue","yellow", "orange","red"), 
        border="black", 
        las=1, 
        axes=FALSE)
      axis(1, at = c(0, 50, 100, 150, 200, 255), col.axis = "black", col = "black")
      text(as.numeric(stats1) + 20, bp1, labels = as.numeric(stats1), col = "black")  
    })
    
    
    
    
    # Pokemon 2
    if (input$gen2 == ""){g2 = g} else{g2=input$gen2}
    if (input$type1_2 == ""){t12 = t1} else{t12=input$type1_2}
    if (input$type2_2 == ""){t22 = t2} else{t22=input$type2_2}
    if (input$legend2 == ""){l2 = l} else{l2=input$legend2}
    
    data2 <- df |> 
      filter(generation %in% g2,
             type1 %in% t12,
             type2 %in% t22,
             special_group %in% l2)
    
    updateSelectInput(session, 'type1_2', choices = c(Choose='', unique(data2$type1)), selected = input$type1_2)
    updateSelectInput(session, 'type2_2', choices = c(Choose='', unique(data2$type2)), selected = input$type2_2)
    updateSelectInput(session, 'legend2', choices = c(Choose='', unique(data2$special_group)), selected = input$legend2)
    updateSelectInput(session, 'name2', choices = c(Choose='', unique(data2$name)), selected = input$name2)
    
    observeEvent(input$reset2, {
      if (input$reset2==TRUE){
        shinyjs::reset("gen2")
        shinyjs::reset("type1_2")
        shinyjs::reset("type2_2")
        shinyjs::reset("legend2")
        shinyjs::reset("name2")
        shinyjs::reset("reset2")}
    })
    
    data2 <- df |> 
      filter(name == input$name2) |> 
      mutate(type2= case_when(type2 == "NA" ~ '', type2 != "NA" ~ type2))
    
    stats2 <- data2 |> select(hp, attack, defense, sp_atk, sp_def, speed)
    
    output$name_2 <- renderUI({req(input$name2)
      div(class= "text-2", h5("Name:"))})
    output$Name2 <- renderText({req(input$name2) 
      data2$name})
    
    output$gen_2 <- renderUI({req(input$name2)
      div(class= "text-2", h5("Generation:"))})
    output$Gen2 <- renderText({req(input$name2) 
      data2$generation})
    
    output$type_2 <- renderUI({req(input$name2)
      div(class= "text-2", h5("Type:"))})
    output$Type2 <- renderText({req(input$name2) 
      paste0(data2$type1, " / ", data2$type2)})
    
    output$ability_2 <- renderUI({req(input$name2)
      div(class= "text-2", h5("Ability:"))})
    output$Ability2 <- renderText({req(input$name2) 
      paste0(data2$ability1, " / ", data2$ability2, " / ", data2$hidden_ability)})
    
    output$legend_2 <- renderUI({req(input$name2)
      div(class= "text-2", h5("Legendary:"))})
    output$Cat2 <- renderText({req(input$name2) 
      data2$special_group})
    
    output$img2 <- renderImage({req(input$name2)
      list(src = paste0("data/",data2$Image), width = 180, height=170)})
    
    
    output$stat2 <- renderPlot({req(input$name2) 
      par(bg = "lightgray", mar = c(4, 6, 2, 3))
      bp2 <- barplot(
        as.numeric(stats2), 
        names.arg = c("Speed", "Sp. Def", "Sp. Atk","Defense", "Attack", "HP" ), 
        horiz=TRUE, 
        xlim = c(0, 255), 
        col=c("pink", "lightgreen","steelblue","yellow", "orange","red"), 
        border="black",
        las=1, 
        axes=FALSE
      )
      axis(1, at = c(0, 50, 100, 150, 200, 255), col.axis = "black", col = "black")
      text(as.numeric(stats2) + 20, bp2, labels = as.numeric(stats2), col = "black")  
    })
    
  })
}

shinyApp(ui, server)