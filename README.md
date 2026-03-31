# survkit

> The only R package that combines Cox-adjusted survival curves with integrated risk tables

Designed for clinical and biomedical research, survkit supports time-to-event analysis workflows using patient-level data. It enables researchers to generate Kaplan-Meier and Cox-adjusted survival curves with appropriate statistical treatment of censoring and uncertainty.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

---

## The Gap in Existing Tools

**survminer:** Great KM curves + risk tables, but cannot do adjusted curves with risk tables  
**ggadjustedcurves:** Great adjusted curves, but no risk tables  
**survkit:** Adjusted curves WITH risk tables in a single function call  

This gap is especially relevant in clinical studies where adjusted survival estimates must be presented alongside interpretable patient risk information.

---

## Installation
```r
pak::pak("evtadlock/survkit")
```

Dependencies install automatically: survival, ggplot2, patchwork, rlang

## Quick Start
```r
library(survkit)
library(survival)

# Basic Kaplan-Meier curve
survkit(lung, "time", "status", "sex")

# Cox-adjusted curves (what others cannot do cleanly)
survkit(lung, "time", "status", "sex", 
        adjust_for = c("age", "ph.ecog"))
```

## Why survkit?

| Feature | survminer | ggadjustedcurves | survkit |
|---------|-----------|------------------|---------|
| KM + risk table | Yes | No | Yes |
| Adjusted + risk table | No | No | Yes |
| Unified API | No | No | Yes |
| Publication styling | Limited | Limited | Yes |

## Key Features

- **Unified interface** for both Kaplan-Meier and Cox-adjusted survival curves
- **Automatic risk tables** perfectly aligned with curves
- **Statistically rigorous** - censor marks only on observed data, not predictions
- **Publication-ready styling** - viridis colors, golden ratio dimensions, 600 DPI optimization
- **Full customization** - line widths, censor marks, CI transparency, colors, text sizes

## Examples

### Basic Kaplan-Meier
```r
survkit(lung, "time", "status", "sex")
```

Features:
- Step functions (observed data)
- Censor marks (+ symbols)
- Confidence ribbons
- Risk table below

### Cox-Adjusted Curves
```r
survkit(lung, "time", "status", "sex",
        adjust_for = c("age", "ph.ecog"),
        title = "Survival by Sex",
        subtitle = "Adjusted for Age and ECOG Performance Status")
```

Features:
- Smooth predictions at reference covariate values
- No censor marks (statistically inappropriate for predictions)
- Confidence ribbons (prediction uncertainty)
- Risk table (observed data context)

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

### Save at 600 DPI
```r
p <- survkit(lung, "time", "status", "sex",
             title = "Overall Survival by Sex")

save_survkit("figure1_survival.png", p, width = 10, dpi = 600)
```

## Customization Options

| Parameter | Default | Description |
|-----------|---------|-------------|
| line_width | 1.2 | Width of survival curves |
| censor_shape | 3 | Shape for censor marks (see ?pch) |
| censor_size | 3 | Size of censor marks |
| censor_stroke | 1.5 | Stroke width for censor marks |
| conf_int | TRUE | Show confidence intervals |
| conf_int_alpha | 0.2 | Transparency of CI ribbons |
| viridis_option | "viridis" | Color palette ("magma", "plasma", etc.) |
| risk_table_height | 0.25 | Proportion of plot for risk table |
| risk_table_text_size | 4 | Text size in risk table |

## Statistical Design

survkit makes statistically principled decisions aligned with survival analysis methodology:

- **Censor marks** appear only on Kaplan-Meier curves (observed censoring events)
- **Cox-adjusted curves** display prediction uncertainty via confidence intervals, not censoring
- **Risk tables** always reflect observed data, providing interpretability alongside modeled estimates

These choices ensure alignment with best practices in time-to-event analysis.

## Built for Researchers
Created to solve a real workflow problem in survival analysis: producing Cox-adjusted survival curves with risk tables for medical journals.
Used in clinical research contexts including cardiovascular outcomes and multiple sclerosis progression analysis, where time-to-event modeling and adjusted survival estimates are required.

## Citation

If you use survkit in your research, please cite:
```
Tadlock, E. (2026). survkit: Survival Curves with Integrated Risk Tables.
R package version 0.1.0. https://github.com/evtadlock/survkit
```

## License

MIT License - Evelyn Tadlock

## Acknowledgments

Built to solve a real problem in survival analysis visualization: the lack of a clean solution for Cox-adjusted curves with risk tables.
