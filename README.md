# Pokemon Battle App

You can view the live app at the following link: [Deployed
App](https://maviswong295-pokemon-battle.share.connect.posit.cloud)

## Motivation

**Target audience: Pokemon lovers**

From Generation 1-9, there are a total of 1025 different Pokemons. The
Pokemon Battle App is designed for Pokemon fans to find and compare
different Pokemons to help them make informed decisions when building
teams or strategizing for battles. Users can search for Generation 1-9
Pokemons by their attributes, the app will return the picture of the
Pokemon as well as its battle stats, allowing users to explore how
different Pokemon would measure up against each other in battle
scenarios.

## App Description

The Pokemon Battle App is an interactive Shiny web application that
allows users to:

-   Select two Pokemon based on generation, type, legendary status and
    name.

-   View detailed stats and abilities for each selected Pokemon.

-   Compare the Pokemon side by side using visual bar charts.

-   Reset selections to explore different Pokemon matchups.

## Dashboard Demo

Here is a walkthrough of the app:

![](img/demo.gif)

## Installation Instructions

#### Prerequisites

To run this app locally, you will need to install R and RStudio. Follow
the installation instructions in the links below.

-   R (<https://cran.r-project.org/>)

-   RStudio (<https://posit.co/download/rstudio-desktop/>)

#### Installing R packages

After installing R & RStudio, run the following code in the console to
install the required R pacakges.

```         
install.packages(c("shiny", "dplyr", "shinyjs"))
```

#### Running the App

1.  **Clone the repository** to your local machine.

```git clone https://github.com/MavisWong295/pokemon_battle```

2. Open the repository in RStudio.
3. Run the following command in the R console:

```runApp("app.R")```

4. The app will launch in your viewer window. You should see a link similar to the one shown below in the console. You can use it to launch the app in your browser.
```Listening on http://127.0.0.1:6612```

# License

`pokemon_battle` was created by Mavis Wong([\@MavisWong295](https://github.com/MavisWong295)). It is licensed under the terms of the **MIT license**.
