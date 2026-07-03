# Verifying Cryptography with Lean 4

**A hands-on curriculum for undergraduates with zero formal-verification
background** — from `1 + 1 = 2` to reading (and extending) real,
machine-checked proofs that production elliptic-curve code is correct.

This is the educational companion to a family of verification projects in
which the arithmetic core of Ed25519 (from
[curve25519-dalek](https://github.com/dalek-cryptography/curve25519-dalek)
and three production forks) and the Pasta curves' field layer were
machine-checked in Lean 4 against models extracted from the actual Rust
sources:

| Companion project | What is verified there |
|---|---|
| [dalek-ed25519-verified](https://github.com/saymrwulf/dalek-ed25519-verified) | field 𝔽ₚ + Edwards group law + scalar foundations, upstream dalek |
| [anza-ed25519-verified](https://github.com/saymrwulf/anza-ed25519-verified) | same layers, Solana's fork, its own extraction |
| [risc0-ed25519-verified](https://github.com/saymrwulf/risc0-ed25519-verified) | same layers, RISC Zero's fork |
| [betrusted-ed25519-verified](https://github.com/saymrwulf/betrusted-ed25519-verified) | same layers, Betrusted's fork |
| [pasta-pallas-verified](https://github.com/saymrwulf/pasta-pallas-verified) | Pallas modulus primality (Lucas/Pratt), Montgomery foundations |
| [formal-verification-control](https://github.com/saymrwulf/formal-verification-control) | the method: invariants, terrain map, failure map, tooling |

## The book

**[`main.pdf`](main.pdf)** — twelve chapters + interlude + three
appendices, 106 pages, full color, built with LaTeX/TikZ from the sources
in this repo. No prior Lean or formal methods assumed; high-school algebra
and a little programming suffice.

1. **Why Verify?** — the carry bug testing cannot find
2. **Meet Lean** — programs, types, inductive data
3. **Propositions as Types** — Curry–Howard: proofs *are* programs
4. **Tactics** — proving as a dialogue with the goal state
5. **Numbers and Automation** — `omega`, `ring`, `norm_num`, `decide`, and the `simp` discipline
6. **Modular Arithmetic** — clock worlds, fields, why 2²⁵⁵ − 19
7. **Primality Certificates** — convincing a paranoid kernel a 77-digit number is prime
8. **From Rust to Lean** — the Charon/Aeneas extraction pipeline
9. **The Denotation Bridge** — the commuting square at the heart of it all
   — ***Interlude*** — a complete verification, entirely by hand, then re-enacted in Lean line by line
10. **Verifying a Field** — the full campaign, told honestly (including the crash)
11. **Honesty and Axioms** — `#print axioms`, hollow certificates, trusted bases
12. **The Pyramid** — group law, scalars, signatures, and where you come in

Appendices: **A** — the pen-and-paper toolkit (recipe cards with drills);
**B** — guided walkthroughs of every exercise-file hole; **C** — a tour of
the real repositories. Plus a glossary and a thirteen-week course plan.

The didactic machinery, deliberately heavy:

- **Pen-and-paper worked examples in every chapter** — computations with
  the *real* constants (2²⁵⁵−19, radix 2⁵¹, the fold constant 19, the
  actual 254-squaring inversion chain, the true Pratt tree
  p−1 = 2²·3·65147·Q), because the real numbers carry the real arguments.
  Highlights: inverting 19 modulo the 77-digit prime in five lines of
  Euclid; a fully hand-checked primality certificate for 97; the ×19 fold
  derived at the real weights; the 16p subtraction constant audited to the
  bit (8 fails by 151); the complete Bernstein–Lange completeness chain.
- **Solutions immediately after every exercise set** — each one leads with
  the *pathway* (how a person finds the answer) before the answer itself.
- Boxed **Big idea / Try it / Pitfall / Aha / Checkpoint** elements, TikZ
  figures throughout.

Everything the book claims about the companion projects reflects their
actual, auditable state — including open frontiers.

## The exercises (they run!)

`exercises/ChNN.lean` are working files with `sorry` holes;
`solutions/ChNN.lean` are complete. **Every solution file compiles with
zero errors** against the pinned toolchain (Lean `v4.30.0-rc2`, Mathlib
`5450b53e`); solutions to proof exercises contain no `sorry`.

Setup (one-time, ~5 min + Mathlib cache download):

```bash
# 1. install elan (Lean version manager) if you haven't:
curl https://elan.lean-lang.org/elan-init.sh -sSf | sh
# 2. fetch the Mathlib build cache (do NOT build Mathlib yourself):
cd verifying-crypto-with-lean
lake exe cache get
# 3. open the folder in VS Code with the "Lean 4" extension, or:
lake build Solutions   # compiles all solution files as a check
```

Chapters 2–4 need no Mathlib at all — you can start them with any Lean 4
install while the cache downloads.

## Building the book

Any TeX Live ≥ 2023 with `tikz`, `tcolorbox`, `listings`, `lmodern`:

```bash
pdflatex main.tex && pdflatex main.tex   # twice for the TOC
```

## Honesty ledger

In the spirit of Chapter 11:

- All `solutions/*.lean` were compiled (and their `#eval` outputs checked
  against their comments) at authoring time with the pinned versions above.
- Exercise templates compile with `sorry` warnings only.
- The book's claims about the companion projects (what is proven, what is
  frontier) mirror those repos' own READMEs and TRUSTED-BASE ledgers at the
  time of writing; the repos, not this book, are the source of truth.
- The PDF in the repo is built from the committed sources by the command
  above; rebuild it yourself if you don't trust binaries (good instinct).
- The three named solution certificates were kernel-audited
  (coherence pass 2, 2026-07-03): `Ch09.add_spec` depends on
  `[propext, Classical.choice, Quot.sound]`; `Ch09.mulVal_spec` and
  `Ch12.addFixed_spec` on `[propext, Quot.sound]` only. The Interlude's
  "compiled and axiom-audited" phrase shipped one pass before its audit
  had actually been run — caught by the verification projects' own
  coherence process and made true; recorded here in the spirit of
  Chapter 11.
