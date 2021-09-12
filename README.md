# ggsource [![CircleCI](https://circleci.com/gh/Chris1221/ggsource/tree/main.svg?style=svg)](https://circleci.com/gh/Chris1221/ggsource/tree/main)

Recover source code from exported PDFs. Use `ggsource::ggsave` instead of `ggplot2::ggsave`, and you can use `ggsource::ggsource` to quickly re-open whatever file was used to generate the plot in Rstudio.

https://user-images.githubusercontent.com/8516981/132992508-0dd4ee74-10e4-4d60-b80b-9918bab9535c.mp4

## 🛠️ Installation 

```{r}
devtools::install_github("Chris1221/ggsource")
library(ggsource)
```

> Note: The package intentionally masks `ggplot2::ggsave`. There's no reason to use `ggplot2::ggsave` if you're using `ggsource`, as the export functionality is the same and, on error, `ggsource` defaults to `ggplot2::ggsave` anyway.

You must also install `ExifTool` if it not already installed on your system. See [here](https://exiftool.org/install.html) for how to do that. 

## 📊 Usage

The default way of using `ggsource` is within RStudio. You won't need to specify any additional arguments, and `ggsource::ggsave` will function as a drop in replacement of `ggplot2::ggsave` with the additional benefit of being able to use `ggsource::ggsource` to re-open the file. 

However, you can also customise the package to your particular set up, whether or not it revolves around the rstudioapi. 

#### Option 1: Within RStudio

Open a file (`my_plot.R`) in RStudio and create a plot. Save it using `ggsource::ggsave` (which will automatically mask `ggplot2::ggsave`).

`my_plot.R`: 

```{R}
library(ggplot2)
p = ggplot(mpg, aes(displ, hwy, colour = class)) + 
  geom_point()

ggsave("my_plot.pdf", p)
```

Now at any point in the future, you can re-open `my_plot.R` with `ggsource`. 

```{R}
ggsource("my_plot.pdf")
```

This will open `my_plot.R` in RStudio.

#### Option 2: Outside of RStudio

`ggsource::ggsave` uses the `rstudioapi` to automatically detect the open file path. To override this, you can specify the scriptname (or arbitrary string, `ggsource::ggsave` doesn't care) that you want to save within the PDF. `ggsource::ggsource` will then just return the path that you gave it in the first place. 

```{R}
ggsave("my_plot.pdf", p, scriptname = "my_plot.R")
ggsource("my_plot.pdf", interactive = FALSE)
```

Will return `my_plot.R`. 

## ❓ FAQ

> How does this work?

PDF is a very flexible document format. It supports the addition of arbitrary tags that can contain any kind of metadata. We define a new meta tag that contains the name of the file currently open in RStudio.

> Will this work with PNG / TIFF / JPG?

No. Only PDF.

> ExifTool is not installing correctly, can you help?

No. There is extensive documentation on how to install the program [here](https://exiftool.org/).
