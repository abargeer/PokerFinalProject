(** Abstract logic behind any person at the table *)

type hand
(** abstract type representing the two cards *)

type state

val create_hand : Card.card -> Card.card -> hand
val cards_to_ints : Card.card list -> int list
val get_cards : hand -> Card.card * Card.card
val first_card : hand -> Card.card
val second_card : hand -> Card.card

type decision =
  | Fold
  | CheckCall
  | Raise of int
