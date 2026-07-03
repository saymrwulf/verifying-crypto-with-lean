/- Chapter 12 — solutions: the full arc. -/
import Mathlib.Data.ZMod.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.LinearCombination

namespace Ch12

abbrev Limbs := Nat × Nat
def Bnd (a : Limbs) : Prop := a.1 < 4 ∧ a.2 < 4
def denote (a : Limbs) : ZMod 15 := (a.1 : ZMod 15) + 4 * (a.2 : ZMod 15)

def add' (a b : Limbs) : Limbs :=
  let s0 := a.1 + b.1
  let s1 := a.2 + b.2 + s0 / 5      -- ← the bug: carry threshold 5, not 4
  (s0 % 4 + s1 / 4, s1 % 4)

/- Task 1: the attempt gets stuck because the Nat identity that closed
   Ch09's proof is FALSE for add': omega refuses
     (add' a b).1 + 4*(add' a b).2 + 15*junk = (a.1+4*a.2)+(b.1+4*b.2)
   and its failure is concentrated where s0/5 ≠ s0/4 — that is,
   a.1 + b.1 = 4 exactly (within our bounds, s0 ≤ 6, and 4 is the only
   value where the two divisions disagree: 4/4 = 1 but 4/5 = 0).
   The carry is simply DROPPED on that slice. -/

/- Task 2: the counterexample the stuck goal points at. -/
#eval decide (denote (add' (2, 0) (2, 0)) = denote (2, 0) + denote (2, 0))
  -- false:  add' (2,0) (2,0) = (0,0) — the dropped carry lost the value 4.
#eval denote (add' (2, 0) (2, 0))            -- 0   (wrong)
#eval denote (2, 0) + denote (2, 0)          -- 4   (truth)

/- Note how thin the slice is: of the 256 bounded input pairs, exactly
   the ones with a.1 + b.1 = 4 misbehave — none of which appeared in the
   casual tests. This is the 2^-64 carry bug of Chapter 1, at toy scale. -/

/- Task 3: the one-character fix, and the proof from Ch09 goes through
   verbatim — the certificate exists again because the code is right. -/
def addFixed (a b : Limbs) : Limbs :=
  let s0 := a.1 + b.1
  let s1 := a.2 + b.2 + s0 / 4      -- carry threshold restored
  (s0 % 4 + s1 / 4, s1 % 4)

theorem addFixed_spec (a b : Limbs) (ha : Bnd a) (hb : Bnd b) :
    denote (addFixed a b) = denote a + denote b := by
  obtain ⟨ha1, ha2⟩ := ha
  obtain ⟨hb1, hb2⟩ := hb
  have key : (addFixed a b).1 + 4 * (addFixed a b).2
           + 15 * ((a.2 + b.2 + (a.1 + b.1) / 4) / 4)
           = (a.1 + 4 * a.2) + (b.1 + 4 * b.2) := by
    simp only [addFixed]
    omega
  have := congrArg (fun n : Nat => (n : ZMod 15)) key
  push_cast at this
  rw [show (15 : ZMod 15) = 0 by decide] at this
  simp only [zero_mul, add_zero] at this
  simp only [denote]
  linear_combination this

/- Task 4 (reflection): The casual tests sampled comfortable interior
   points; the bug lives on the BOUNDARY of the carry condition — the
   THIN SLICE where a.1 + b.1 equals exactly 4. A test suite touches
   finitely many points and missed the slice entirely; the spec's
   universal QUANTIFIER covers the slice by construction, so the proof
   had to fail — and its failure pointed straight at the guilty inputs.
   Chapter 1's 2^-64 carry bug is this same story with a slice so thin
   that random testing would need centuries to land on it. The
   quantifier does not get luckier or unluckier; it just covers
   everything. That is the entire value proposition of this book. -/

end Ch12
