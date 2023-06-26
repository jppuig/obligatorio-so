package Aleatorio is
   subtype Numero_Rango is Integer range 1 .. 3;

   function Generador return Numero_Rango;
end Aleatorio;
