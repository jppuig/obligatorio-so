with Ada.Text_IO; use Ada.Text_IO;
with Ada.Calendar;
with Ada.Calendar.Formatting;

--  Juan Pedro Puig - 281088
--  Pedro Azambuja - 270218

package body Aleatorio is
   function Generador return Numero_Rango is
      Random_Seed : constant Integer := Integer(Ada.Calendar.Formatting.Second(Ada.Calendar.Clock)) mod 3 + 1;
      Random_Num : Numero_Rango;
   begin
      Random_Num := Numero_Rango(Random_Seed);
      return Random_Num;
   end Generador;
end Aleatorio;
