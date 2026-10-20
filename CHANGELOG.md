# Changelog

This file reconstructs the UMLD history from the Git commit log. Dates are
commit dates. The project did not use release tags during this period.

## 1.0.0 — 2026-10-07

- Add `labelpos=above|below|left|right` to assembly connectors.
- Add release, build, and user documentation.
- Remove stale generated figures, PDFs, the obsolete website configuration,
  and the unmaintained French v1.0 manual.
- Update bundled examples and the English manual to the current UMLD command
  names.
- Apply the stereotype placement/background keys consistently to control-node
  relationships.
- Restore the TikZ diamond shape for n-ary association nodes and respect local
  note colours for pointed-note markers.
- Stop the nesting arrow declaration from typesetting placeholder dots into
  TeX's null font.

## 2024-10-06

- Rename relationship stereotype positioning options to `st:pos` and
  `st:anchor`.
- Add `st:fill` for a background behind relationship stereotypes.

## 2024-05-04

- Distinguish pure-virtual operations (`\umlpvirt`) from virtual operations
  (`\umlvirt`) and render their UML constraints explicitly.

## 2024-04-22

- Rename composition shortcuts from the abbreviated `compo` spelling to
  `compos`, including the HV, VH, HVH, VHV, and control-node variants.

## 2024-04-21

- Correct `\umlstatic` rendering.
- Adjust default colours and line rendering.

## 2024-04-17

- Use consistent, scaled modern arrow tips.
- Add `\umlcon`, `\umlpvirt`, `\umlvirt`, `\umloverrd`, and `\umlquery` for UML
  constraints and operation modifiers.
- Keep the `abstract` stereotype visible on abstract classes.

## 2024-04-16

- Add true two-compartment enumerations with `\umlenum`.
- Revise the default colours of class, object, sequence, and use-case diagrams.

## 2024-04-14

- Italicize abstract class and interface names and underline object names.
- Improve actor proportions and add the `head` colour option.
- Remove the spacing left behind by `no ddots` and draw sequence lifelines as
  dashed lines.
- Resolve interactions between `pgfkeys`, TikZ environments, and TeX line
  endings.

## 2024-04-13

- Fork TikZ-UML 1.0 as TikZ-UMLD.
- Add static object diagrams through `umlobjdiag`, `\umlobj`, and
  `\umlsimpleobj`.
- Correct sequence-object names and identifiers, multi-line calls, and self
  calls.
- Use `etoolbox` for robust comparisons.
- Add independent placement of relationship stereotypes.
- Import the original English and French manuals and examples.
