# survkit

> Publication-ready survival curves with integrated risk tables

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## The Problem

Existing R packages struggle with a common need: **Cox-adjusted survival curves WITH risk tables**.

- `survminer::ggsurvplot()` — Great for Kaplan-Meier + risk tables, but doesn't handle adjusted curves
- `survminer::ggadjustedcurves()` — Great for adjusted curves, but **no risk tables**
- Manual patchwork solutions — Fragile, inconsistent, time-consuming

## The Solution

`survkit` provides a **unified interface** for both Kaplan-Meier and Cox-adjusted survival curves with perfectly aligned risk tables.
```r
library(survkit)
library(survival)

# Kaplan-Meier with risk table
survkit(lung, "time", "status", "sex")

# Cox-adjusted with risk table (this is what others can't do!)
survkit(lung, "time", "status", "sex", 
        adjust_for = c("age", "ph.ecog"))
```

## Installation
```r
# Install from GitHub
devtools::install_github("yourusername/survkit")
```

## Key Features

- **Unified API** — Same function for KM and adjusted curves
- **Automatic risk tables** — Perfectly aligned, always
- **Statistically rigorous** — Censor marks only where appropriate (KM only, not on predictions)
- **Publication-ready styling** — Viridis colors, golden ratio dimensions, 600 DPI optimization
- **Full customization** — Line widths, censor marks, CI transparency, colors, text sizes

## Quick Examples

### Basic Kaplan-Meier
```r
survkit(lung, "time", "status", "sex")
```

**Features:**
- Step functions (observed data)
- Censor marks (+ symbols)
- Confidence ribbons
- Risk table below

---

### Cox-Adjusted Curves
```r
survkit(lung, "time", "status", "sex",
        adjust_for = c("age", "ph.ecog"),
        title = "Survival by Sex",
        subtitle = "Adjusted for Age and ECOG Performance Status")
```

**Features:**
- Smooth predictions at reference covariate values
- No censor marks (statistically inappropriate for predictions)
- Confidence ribbons (prediction uncertainty)
- Risk table (observed data context)

---

### Side-by-Side Comparison
```r
library(patchwork)

p1 <- survkit(lung, "time", "status", "sex",
              title = "Unadjusted")

p2 <- survkit(lung, "time", "status", "sex",
              adjust_for = c("age", "ph.ecog"),
              title = "Adjusted")

p1 | p2
```

---

### Custom Styling
```r
survkit(lung, "time", "status", "sex",
        line_width = 2,              # Thicker lines
        censor_size = 5,             # Larger censor marks
        censor_shape = 1,            # Circle instead of plus
        conf_int_alpha = 0.3,        # More visible CI
        viridis_option = "plasma",   # Different color palette
        risk_table_text_size = 5)    # Larger risk table text
```

---

### Save at 600 DPI with Golden Ratio
```r
p <- survkit(lung, "time", "status", "sex",
             title = "Overall Survival by Sex")

save_survkit("figure1_survival.png", p, width = 10, dpi = 600)
```

## Customization Options

| Parameter | Default | Description |
|-----------|---------|-------------|
| `line_width` | 1.2 | Width of survival curves |
| `censor_shape` | 3 | Shape for censor marks (see `?pch`) |
| `censor_size` | 3 | Size of censor marks |
| `censor_stroke` | 1.5 | Stroke width for censor marks |
| `conf_int` | TRUE | Show confidence intervals |
| `conf_int_alpha` | 0.2 | Transparency of CI ribbons |
| `viridis_option` | "viridis" | Color palette ("magma", "plasma", etc.) |
| `risk_table_height` | 0.25 | Proportion of plot for risk table |
| `risk_table_text_size` | 4 | Text size in risk table |

## Why survkit?

| Feature | survival | survminer | ggadjustedcurves | **survkit** |
|---------|----------|-----------|------------------|-------------|
| KM curves | Yes (base R) | Yes | No | Yes |
| Cox-adjusted | Yes (base R) | Manual | Yes | Yes |
| Risk tables | No | Yes (KM only) | No | Yes |
| **Adjusted + Risk table** | No | No | No | **Yes** |
| ggplot2 styling | No | Yes | Yes | Yes |
| Unified API | No | No | No | Yes |

## Design Philosophy

`survkit` makes **statistically principled decisions**:

- **Censor marks** appear only on Kaplan-Meier curves (observed censoring events)
- **Cox-adjusted curves** show prediction uncertainty through confidence intervals, not censoring (which doesn't exist for predictions)
- **Risk tables** always show observed data, providing context even for adjusted analyses

## Citation

If you use survkit in your research, please cite:
```
Tadlock, E. (2026). survkit: Survival Curves with Integrated Risk Tables.
R package version 0.1.0. https://github.com/yourusername/survkit
```

## License

MIT © Evelyn Tadlock

## Acknowledgments

Built to solve a real problem in survival analysis visualization: the lack of a clean solution for Cox-adjusted curves with risk tables.
