/- Chapter 4 — solutions. -/

namespace Ch04

def myAdd : Nat → Nat → Nat
  | m, Nat.zero   => m
  | m, Nat.succ n => Nat.succ (myAdd m n)

theorem and_swap (P Q : Prop) : P ∧ Q → Q ∧ P := by
  intro h
  constructor
  · exact h.2
  · exact h.1

theorem zero_myAdd (n : Nat) : myAdd 0 n = n := by
  induction n with
  | zero => rfl
  | succ k ih =>
    simp only [myAdd]
    rw [ih]

theorem succ_myAdd (m n : Nat) : myAdd (Nat.succ m) n = Nat.succ (myAdd m n) := by
  induction n with
  | zero => rfl
  | succ k ih =>
    simp only [myAdd]
    rw [ih]

/- zero case: "m + 0 is m by definition, and 0 + m is m by 4.1a."
   succ case: "both sides step to a successor — the left by definition,
   the right by 4.1b — and the induction hypothesis matches the insides." -/
theorem myAdd_comm (m n : Nat) : myAdd m n = myAdd n m := by
  induction n with
  | zero => simp only [myAdd]; rw [zero_myAdd]
  | succ k ih =>
    simp only [myAdd]
    rw [succ_myAdd, ih]

/- 4.3: the wrong step was the last one: 4*b + b is 5*b, not 6*b. -/
theorem calc_repair (a b : Nat) (h : a = 2 * b) : a + a + b = 5 * b := by
  calc a + a + b = 2 * a + b       := by omega
       _         = 2 * (2 * b) + b := by rw [h]
       _         = 4 * b + b       := by omega
       _         = 5 * b           := by omega

end Ch04
