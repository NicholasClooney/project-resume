# Typst Resume Generator

This branch explores a clean-room rewrite of the resume builder using [Typst](https://typst.app) instead of Eleventy/Nunjucks. The goal is to keep the resume data in YAML and render a polished PDF with Typst’s modern typesetting pipeline.

## Prerequisites

- Rust toolchain (for installing the Typst CLI)
- Typst CLI: `cargo install typst-cli` or download a prebuilt binary from the Typst releases page

## Project Layout

- `data/cv.yaml` — canonical resume data (mirrors the Eleventy branch structure)
- `src/resume.typ` — Typst template that reads the YAML data and lays out the resume
- `typst.toml` — project metadata and default output location
- `Makefile` — helper targets for building, watching, and cleaning artifacts
- `build/` — generated artifacts (ignored in version control)

## Usage

```bash
# Optional: expose cargo-installed binaries
export PATH="$HOME/.cargo/bin:$PATH"

# Compile the resume once
make build

# Or run Typst in watch mode while editing
make watch

# Remove generated files
make clean
```

The default output path is `build/resume.pdf`. Open it in Preview (macOS), Skim, or any PDF viewer to review layout changes.

## Next Steps

- Evaluate custom fonts and fallbacks for brand alignment
- Flesh out print-versus-screen specific layout tweaks (e.g., margins, color palette)
- Investigate exporting HTML versions alongside the PDF if distribution requires both
