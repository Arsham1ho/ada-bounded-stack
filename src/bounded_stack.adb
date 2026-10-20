package body Bounded_Stack is

   function Size (S : Stack) return Depth is (S.Top);

   function Is_Empty (S : Stack) return Boolean is (S.Top = 0);

   function Is_Full (S : Stack) return Boolean is (S.Top = Max_Depth);

   procedure Push (S : in out Stack; Value : Item) is
   begin
      S.Top := S.Top + 1;
      S.Items (S.Top) := Value;
   end Push;

   procedure Pop (S : in out Stack; Value : out Item) is
   begin
      Value := S.Items (S.Top);
      S.Top := S.Top - 1;
   end Pop;

   function Peek (S : Stack) return Item is (S.Items (S.Top));

end Bounded_Stack;
