--  A bounded stack with the safety conditions written into the spec rather
--  than left to the caller to remember.
--
--  Ada lets the contract live in the interface: Capacity is constrained by the
--  type, Push has a precondition that the stack is not full, Pop one that it
--  is not empty, and both state what the depth must be afterwards. A caller
--  that violates one of these is wrong at the point of the call, not three
--  frames deeper when something overflows.

generic
   type Item is private;
package Bounded_Stack is

   Max_Depth : constant := 64;

   subtype Depth is Natural range 0 .. Max_Depth;

   type Stack is private;

   function Size (S : Stack) return Depth;
   function Is_Empty (S : Stack) return Boolean;
   function Is_Full (S : Stack) return Boolean;

   procedure Push (S : in out Stack; Value : Item)
     with Pre  => not Is_Full (S),
          Post => Size (S) = Size (S'Old) + 1 and then not Is_Empty (S);

   procedure Pop (S : in out Stack; Value : out Item)
     with Pre  => not Is_Empty (S),
          Post => Size (S) = Size (S'Old) - 1 and then not Is_Full (S);

   function Peek (S : Stack) return Item
     with Pre => not Is_Empty (S);

private

   type Item_Array is array (1 .. Max_Depth) of Item;

   type Stack is record
      Items : Item_Array;
      Top   : Depth := 0;
   end record;

end Bounded_Stack;
