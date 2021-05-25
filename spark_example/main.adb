with Ada.Text_IO;
with Small_Ex;

procedure Main is

begin
 Ada.Text_IO.Put_Line(Small_Ex.Saturated_Counter(2)'Image);
 Ada.Text_IO.Put_Line(Small_Ex.Saturated_Counter(15)'Image);
 for i in Small_Ex.Value_Type'Range loop
  Ada.Text_IO.Put_Line(Small_Ex.Saturated_Counter(i)'Image);
 end loop;
end Main;
