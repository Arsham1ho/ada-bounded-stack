with Ada.Text_IO; use Ada.Text_IO;
with Bounded_Stack;

procedure Stack_Demo is

   package Int_Stack is new Bounded_Stack (Item => Integer);
   use Int_Stack;

   S     : Stack;
   Value : Integer;

begin
   Put_Line ("Pushing 1 .. 5");
   for I in 1 .. 5 loop
      Push (S, I);
   end loop;

   Put_Line ("Depth after pushes:" & Depth'Image (Size (S)));
   Put_Line ("Top of stack:" & Integer'Image (Peek (S)));

   Put_Line ("Popping everything back off:");
   while not Is_Empty (S) loop
      Pop (S, Value);
      Put_Line ("  popped" & Integer'Image (Value));
   end loop;

   Put_Line ("Empty again: " & Boolean'Image (Is_Empty (S)));

   --  Deliberately provoke the precondition. Built with -gnata, this raises
   --  Assertion_Error at the call rather than corrupting the stack quietly.
   Put_Line ("Popping an empty stack, to show the precondition firing:");
   Pop (S, Value);

exception
   when others =>
      Put_Line ("  caught: precondition violated, as intended");
end Stack_Demo;
