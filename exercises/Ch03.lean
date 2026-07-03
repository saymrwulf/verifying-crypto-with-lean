/- Chapter 3 — Propositions as Types: exercises.
   Rules of the game: TERM MODE ONLY — no `by`, no tactics.
   Your toolkit: fun ... => ..., function application, And.intro,
   h.1 / h.2, Or.inl / Or.inr, match ... with. -/

namespace Ch03

variable (P Q R : Prop)

-- Warm-ups from the Try It box ---------------------------------------------

/- W1: "if P then (Q implies P)". A constant function. -/
theorem const_imp : P → Q → P :=
  sorry

/- W2: a conjunction gives a disjunction (pick a side). -/
theorem and_to_or : P ∧ Q → P ∨ Q :=
  sorry

/- W3: modus ponens — "calling a function". -/
theorem modus_ponens : P → (P → Q) → Q :=
  sorry

-- Numbered exercises --------------------------------------------------------

/- 3.1: reassociate evidence with h.1, h.2, And.intro. -/
theorem and_assoc' : (P ∧ Q) ∧ R → P ∧ (Q ∧ R) :=
  sorry

/- 3.2: case analysis on which side holds.
   Shape: fun h => match h with
          | Or.inl p => ...
          | Or.inr q => ... -/
theorem or_swap : P ∨ Q → Q ∨ P :=
  sorry

/- 3.3: Not P is DEFINED as P → False. Unfold it in your head, and this
   becomes a two-argument function. Afterwards, write in a comment the
   one-sentence description of the program you wrote. -/
theorem not_not_intro : P → ¬¬P :=
  sorry

end Ch03
