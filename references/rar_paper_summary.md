# Rubrics as Rewards (RaR) Paper Summary

Source: arXiv:2507.17746.

This document paraphrases the four design principles from the Rubrics
as Rewards paper and shows how they map to the 9-cell Trinity grid in
`skills/trinity_rubric/SKILL.md`. No direct quotation exceeds 14 words.

## The four design principles

The RaR paper identifies four properties a good rubric needs to have.
Paraphrased:

1. **Coverage.** A rubric must address all dimensions of quality the
   user cares about for the task. If a dimension is missing from the
   rubric, the rubric will reward outputs that fail on that dimension.

2. **Self-contained.** A rubric must be applicable by a reader who has
   only the rubric and the artifact in front of them. If applying the
   rubric requires looking up tribal knowledge or unwritten norms, two
   different reviewers will disagree on the same artifact.

3. **Importance.** A rubric must weight high-stakes properties higher
   than low-stakes ones. A rubric that treats every property as equal
   in weight will reward outputs that pile up easy properties at the
   expense of difficult ones.

4. **Reference Guidance.** A rubric should provide examples or
   references that show what each property looks like in practice.
   Without references, reviewers calibrate to their own priors and
   the rubric drifts.

## Mapping to the Trinity grid

The Trinity grid uses three of the four principles (Coverage,
Self-contained, Importance) as sub-axes. The fourth principle
(Reference Guidance) is met at the rubric-design level: each cell's
rationale in `skills/trinity_rubric/SKILL.md` includes a worked example.

| Trinity sub-axis | RaR principle |
|---|---|
| Coverage | Coverage |
| Self-contained | Self-contained |
| Importance | Importance |
| (rubric-level) | Reference Guidance |

The three Trinity axes (Pathos, Ethos, Logos) are CE_RD_OS-specific
contributions, not from the RaR paper. They classify what kind of
quality is being evaluated:

- **Pathos**: mission and role quality.
- **Ethos**: source and citation quality.
- **Logos**: rubric application quality.

3 axes by 3 sub-axes equals 9 cells, the basic Trinity grid.

## Boolean-atomic mode rationale

The RaR paper, together with arXiv:2503.23339 (Adaptive Precise Boolean
Rubrics) and arXiv:2507.18624 (Apple/CMU Checklists), supports
boolean-atomic mode as the default for mechanical evaluation. Boolean
checklists outperform free-form judging on structured tasks because:

1. Boolean cells give zero-ambiguity yes-or-no signals.
2. Aggregation across boolean cells is mathematically clean.
3. Reviewer disagreement is easier to localize (which cell did we
   disagree on?) than with continuous scores.

CE_RD_OS uses boolean-atomic for ingest-time source acceptance and
publish-readiness gates. Continuous (scaled_0_1) mode is reserved for
consequential outputs where granular distinction matters.

## OpenRubrics extension

arXiv:2510.07743 (OpenRubrics) addresses synthetic rubric generation
in novel domains. CE_RD_OS does not currently use synthetic rubric
generation; the Trinity grid is the canonical rubric. OpenRubrics is
cited here as a reference for v0.2 work where synthetic rubrics may
be needed.

## What this document does NOT do

- Does not reproduce the RaR paper. Paraphrases only.
- Does not claim the Trinity grid is identical to the RaR rubric.
  The Trinity grid is a CE_RD_OS-specific composition that uses
  RaR's design principles.
- Does not implement the rubric. See `skills/trinity_rubric/SKILL.md`
  for the implementation.

## Citation block

- arXiv:2507.17746, Rubrics as Rewards (RaR).
- arXiv:2503.23339, Adaptive Precise Boolean Rubrics.
- arXiv:2507.18624, Apple/CMU Checklists.
- arXiv:2510.07743, OpenRubrics.

End rar_paper_summary.
