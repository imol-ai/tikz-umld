# TikZ-UMLD

TikZ-UMLD is a LaTeX package for drawing UML diagrams with TikZ. It is a
fork of Nicolas Kielbasiewicz's TikZ-UML 1.0 and retains its support for class,
package, use-case, state, sequence, and component diagrams. UMLD adds object
diagrams, proper two-compartment enumerations, UML constraints and operation
modifiers, pointed notes, more control over relationship stereotypes, and a
collection of rendering and compatibility fixes.

Version 1.0.0 is the first prepared TikZ-UMLD release.

## Installation

Until a CTAN release is available, put `tikz-umld.sty` next to your document or
in a directory searched by TeX. Then load it with:

```tex
\usepackage{tikz-umld}
```

TikZ-UMLD requires `tikz`, `ifthen`, `xstring`, `calc`, `pgfopts`, and
`etoolbox`. The package loads the required TikZ libraries itself.

## Small example

```tex
\documentclass{standalone}
\usepackage{tikz-umld}

\begin{document}
\begin{tikzpicture}
  \umlabstract{Shape}{}{
    \umlpvirt{area(): real}
  }
  \umlclass[x=5]{Circle}{radius: real}{
    \umloverrd{area(): real}
  }
  \umlinherit{Circle}{Shape}
  \umlnote[x=5,y=-3,px=0,py=-1]{Circle}{Radius must be positive.}
\end{tikzpicture}
\end{document}
```

## UMLD additions

- Static object diagrams with `umlobjdiag`, `\umlobj`, and `\umlsimpleobj`.
- Two-compartment enumerations with `\umlenum`.
- Constraints and operation modifiers: `\umlcon`, `\umlstatic`, `\umlpvirt`,
  `\umlvirt`, `\umloverrd`, and `\umlquery`.
- Pointed notes using the `px` and `py` options.
- Relationship stereotype placement and backing with `st:pos`, `st:anchor`,
  and `st:fill`.
- Actor head colour through `head`, and assembly-connector label placement
  through `labelpos=above|below|left|right`.
- Improved abstract/interface/object typography, arrow tips, sequence-object
  naming, dashed lifelines, and several sequence-diagram fixes.
- Composition shortcuts use `compos`, for example `\umlcompos` and
  `\umlVHVunicompos`.

The English manual documents the complete inherited interface and the UMLD
extensions. `examples/full.tex` is a worked example (a radiation simulation)
with use-case, sequence, state-machine and class diagrams.

## Building the documentation and examples

From the repository root:

```sh
make check
```

The build uses `latexmk` and writes generated files to `build/`. Individual
targets are `make manual` and `make examples`.

`make release-archive` rebuilds everything, refreshes the checked-in manual
PDF, and creates `build/tikz-umld.tar.gz` with the required top-level
directory. `make ctan-archive` is an alias for this final release archive.

## History and authorship

TikZ-UMLD is maintained by David Imolai. It is derived from TikZ-UML by Nicolas
Kielbasiewicz. See [CHANGELOG.md](CHANGELOG.md) for the reconstructed history of
UMLD-specific changes.

## License

TikZ-UMLD is distributed under the GNU Affero General Public License, version 3
or later. See [LICENSE.md](LICENSE.md). Its origin in TikZ-UML 1.0 is recorded
in [NOTICE.md](NOTICE.md).
