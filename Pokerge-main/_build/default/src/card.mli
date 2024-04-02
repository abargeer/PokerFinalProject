(** Representation of a card.

    This module represents the properties each card may have. 

    *)

type card
(** The abstract type of suit of a card. *)

val create_card : string -> string -> card

val get_suit : card -> string
(** Gets the suit of [card] *)

val get_value : card -> string
(** Gets the value of [card] *)

val convert_value_to_string : card -> string
    
val convert_value_to_int : card -> int
    
    
    