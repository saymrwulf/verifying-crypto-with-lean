/- Chapter 9 — solutions. -/
import Mathlib.Data.ZMod.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.LinearCombination

namespace Ch09

abbrev Limbs := Nat × Nat

def Bnd (a : Limbs) : Prop := a.1 < 4 ∧ a.2 < 4

-- 9.A: positional notation, base 4, on the clock face of ZMod 15.
def denote (a : Limbs) : ZMod 15 := (a.1 : ZMod 15) + 4 * (a.2 : ZMod 15)

#eval denote (3, 2)   -- 11
#eval denote (1, 0)   -- 1

def add (a b : Limbs) : Limbs :=
  let s0 := a.1 + b.1
  let s1 := a.2 + b.2 + s0 / 4
  (s0 % 4 + s1 / 4, s1 % 4)

-- 9.B: the commuting square for add.
theorem add_spec (a b : Limbs) (ha : Bnd a) (hb : Bnd b) :
    ((add a b).1 < 5 ∧ (add a b).2 < 4)
    ∧ denote (add a b) = denote a + denote b := by
  obtain ⟨ha1, ha2⟩ := ha
  obtain ⟨hb1, hb2⟩ := hb
  constructor
  · -- bounds clause: pure integer bookkeeping.
    simp only [add]
    omega
  · -- value clause: Nat identity first, then cast to the clock face.
    have key : (add a b).1 + 4 * (add a b).2
             + 15 * ((a.2 + b.2 + (a.1 + b.1) / 4) / 4)
             = (a.1 + 4 * a.2) + (b.1 + 4 * b.2) := by
      simp only [add]
      omega
    have := congrArg (fun n : Nat => (n : ZMod 15)) key
    push_cast at this
    rw [show (15 : ZMod 15) = 0 by decide] at this
    simp only [zero_mul, add_zero] at this
    simp only [denote]
    linear_combination this

def mulVal (a b : Limbs) : Nat :=
  a.1 * b.1 + a.2 * b.2 + 4 * (a.1 * b.2 + a.2 * b.1)

-- 9.C: the fold theorem — no bounds hypotheses needed.
theorem mulVal_spec (a b : Limbs) :
    ((mulVal a b : Nat) : ZMod 15) = denote a * denote b := by
  have key : mulVal a b + 15 * (a.2 * b.2)
           = (a.1 + 4 * a.2) * (b.1 + 4 * b.2) := by
    simp only [mulVal]
    ring
  have := congrArg (fun n : Nat => (n : ZMod 15)) key
  push_cast at this
  rw [show (15 : ZMod 15) = 0 by decide] at this
  simp only [zero_mul, add_zero] at this
  simp only [denote]
  linear_combination this

/- 9.D: (19,…) has no meaning here, but e.g. denote (3, 3) = 3 + 12 = 15 = 0
   and denote (0, 0) = 0 — a collision. Check interchangeability: -/
#eval denote (add (3, 3) (1, 2))   -- 9
#eval denote (add (0, 0) (1, 2))   -- 9 — same, as denotation demands

end Ch09
