/- Chapter 9 — The Denotation Bridge: exercises.
   A complete miniature of the verified-field story, small enough to hold
   in your head: TWO limbs, radix FOUR, modulus 15. Because 16 ≡ 1
   (mod 15), the top carry folds back with weight 1 — a toy version of
   2^255 ≡ 19 (mod p). Requires Mathlib. -/
import Mathlib.Data.ZMod.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.LinearCombination

namespace Ch09

/-- Two limbs, each meant to hold a base-4 digit. -/
abbrev Limbs := Nat × Nat

/-- The bounds invariant: both limbs are genuine base-4 digits. -/
def Bnd (a : Limbs) : Prop := a.1 < 4 ∧ a.2 < 4

/- 9.A: write the denotation — "what field element do these limbs MEAN?"
   Positional notation in base 4, read on the clock face of ZMod 15. -/
def denote (a : Limbs) : ZMod 15 :=
  sorry

-- sanity: denote (3, 2) should be 11; denote (1, 0) should be 1
-- #eval denote (3, 2)   -- expected: 11

/-- Addition with carry, machine-style: limb sums, then carry
    propagation, then the TOP carry (weight 16 ≡ 1) folds into limb 0. -/
def add (a b : Limbs) : Limbs :=
  let s0 := a.1 + b.1
  let s1 := a.2 + b.2 + s0 / 4
  (s0 % 4 + s1 / 4, s1 % 4)

/- 9.B: the commuting square for add — your first denotation proof!
   Route (both clauses of the two-clause shape):
   • bounds clause: `simp only [add]` then `omega`.
   • value clause: first prove the NAT identity
       (add a b).1 + 4 * (add a b).2 + 15 * junk = (a.1+4*a.2)+(b.1+4*b.2)
     for the right `junk` (omega finds div/mod facts by itself once you
     unfold), then cast to ZMod 15 with push_cast and use that 15 = 0
     on the clock: (15 : ZMod 15) = 0 is `by decide`. -/
theorem add_spec (a b : Limbs) (ha : Bnd a) (hb : Bnd b) :
    ((add a b).1 < 5 ∧ (add a b).2 < 4)
    ∧ denote (add a b) = denote a + denote b := by
  sorry

/-- Multiplication, fold already applied: the column of weight 16 —
    a.2*b.2 — re-enters at weight 1 because 16 ≡ 1 (mod 15).
    (We return the VALUE; re-limbing it is exercise 9.D.) -/
def mulVal (a b : Limbs) : Nat :=
  a.1 * b.1 + a.2 * b.2 + 4 * (a.1 * b.2 + a.2 * b.1)

/- 9.C: the fold theorem — the essence of every mul proof in this book.
   Hint: the Nat identity
     mulVal a b + 15 * (a.2 * b.2) = (a.1 + 4*a.2) * (b.1 + 4*b.2)
   is pure algebra: `ring` proves it. Then cast as in 9.B.
   Notice: NO bounds hypotheses needed — denotation doesn't care! -/
theorem mulVal_spec (a b : Limbs) :
    ((mulVal a b : Nat) : ZMod 15) = denote a * denote b := by
  sorry

/- 9.D (paper, from the chapter): find two DISTINCT limb pairs with the
   same denotation, and check by #eval that add treats them
   interchangeably as far as denotation goes. -/

end Ch09
