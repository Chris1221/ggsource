# ggsource 

Recover source code from exported PDFs. Use `ggsource::ggsave` instead of `ggplot2::ggsave`, and you can use `ggsource::ggsource` to quickly re-open whatever file was used to generate the plot in Rstudio.

**This is currently ONLY coded to work within the Rstudio framework, assuming that the `rstudioapi` is available. A more complete solution will be available when I have time to clean it up.**

## Installation 

```{r}
devtools::install_github("Chris1221/ggsource")
library(ggsource)
```

> Note: The package intentionally masks `ggplot2::ggsave`. There's no reason to use `ggplot2::ggsave` if you're using `ggsource`, as the export functionality is the same and, on error, `ggsource` defaults to `ggplot2::ggsave` anyway.

## Usage

### Step 1: Open a file in RStudio and create a plot

`my_plot.R`: 

```{r}
library(ggplot2)
p = ggplot(mpg, aes(displ, hwy, colour = class)) + 
  geom_point()
```

### Step 2: Save the plot with `ggsource`

```{r}
library(ggsource) # will mask ggplot2::ggsave

ggsave("my_plot.pdf", p)
```

### Step 3: Source the file used to create the plot

```{r}
ggsource("my_plot.pdf")
```

This will open `my_plot.R` in RStudio.

## FAQ

> How does this work?

PDF is a very flexible document format. It supports the addition of arbitrary tags that can contain any kind of metadata. We define a new meta tag that contains the name of the file currently open in RStudio.

> Will this work with PNG / TIFF / JPG?

No. Only PDF.

> Will this work outside of RStudio?

You can use this outside of RStudio to associate the name of any file to the PDF, but the current functionality for actually opening the plot is restricted to RStudio. I have plans to make this a more general solution, opening the file in `$EDITOR` when you're in a command line environment, for example.

> ExifTool is not installing correctly, can you help?

No. There is extensive documentation on how to install the program [here](https://exiftool.org/).
