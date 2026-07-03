/- Chapter 12 — Graduation: spec, refusal, counterexample, fix, certificate.
   The mini-system from Ch09, but one of the definitions below contains a
   DELIBERATE off-by-one carry bug — exactly the species from Chapter 1:
   correct on most inputs, wrong on a thin boundary slice that casual
   testing misses. Requires Mathlib. -/
import Mathlib.Data.ZMod.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.LinearCombination

namespace Ch12

abbrev Limbs := Nat × Nat
def Bnd (a : Limbs) : Prop := a.1 < 4 ∧ a.2 < 4
def denote (a : Limbs) : ZMod 15 := (a.1 : ZMod 15) + 4 * (a.2 : ZMod 15)

/-- Addition with carry… or is it? Somewhere in here hides the bug. -/
def add' (a b : Limbs) : Limbs :=
  let s0 := a.1 + b.1
  let s1 := a.2 + b.2 + s0 / 5
  (s0 % 4 + s1 / 4, s1 % 4)

/- A few casual tests — they all pass! (Run them.) -/
#eval decide (denote (add' (1, 2) (2, 1)) = denote (1, 2) + denote (2, 1)) -- true
#eval decide (denote (add' (3, 3) (3, 3)) = denote (3, 3) + denote (3, 3)) -- true
#eval decide (denote (add' (0, 1) (1, 0)) = denote (0, 1) + denote (1, 0)) -- true

/- Task 1: state and attempt the spec. The proof below WILL get stuck —
   that is the point. Push the omega/Nat-identity route from Ch09 until
   Lean shows you a goal it refuses to close. READ that goal: it is
   pointing at the counterexample slice. -/
theorem add'_spec (a b : Limbs) (ha : Bnd a) (hb : Bnd b) :
    denote (add' a b) = denote a + denote b := by
  sorry -- your attempt here. Expected outcome: honest failure.

/- Task 2: extract the counterexample. From the stuck goal, find concrete
   bounded limbs where add' is WRONG, and confirm by #eval: -/
-- #eval decide (denote (add' (?, ?) (?, ?)) = denote (?, ?) + denote (?, ?))
--   -- expected: false

/- Task 3: fix the code (one character!) and prove the spec for real.
   You may import your Ch09 solution mentally — it is the same proof. -/
def addFixed (a b : Limbs) : Limbs :=
  sorry

theorem addFixed_spec (a b : Limbs) (ha : Bnd a) (hb : Bnd b) :
    denote (addFixed a b) = denote a + denote b := by
  sorry

/- Task 4 (reflection, one paragraph in a comment): the casual tests
   passed and the spec failed. Explain — using the words "boundary",
   "quantifier", and "thin slice" — why the spec knew better, and what
   this says about the 2^-64 carry bug of Chapter 1. -/

end Ch12
