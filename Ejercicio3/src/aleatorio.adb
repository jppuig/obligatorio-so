with Ada.Text_IO;

package body Aleatorio is

   package Random_IO is new Ada.Text_IO.Float_IO (Num => Float);
   package Integer_IO is new Ada.Text_IO.Integer_IO (Num => Integer);

   function Num_Aleatorio (Min : Integer; Max : Integer) return Integer is
      Gen_Float : Float;
      Gen_Integer : Integer;
   begin
      Random_IO.Get (Item => Gen_Float);
      Gen_Integer := Integer (Gen_Float);

      -- Ajustar el número generado al rango deseado
      Gen_Integer := Gen_Integer mod (Max - Min + 1) + Min;

      return Gen_Integer;
   end Num_Aleatorio;

end Aleatorio;
