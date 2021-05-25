package body Small_Ex is
pragma Spark_Mode(on);

 function Saturated_Counter(x: in Value_Type) return Value_Type is
  --r: Value_Type;
 begin
  if x < Value_Type'Last then
   return x + 1;
  else
   return x;
  end if;
  --return r;
 end Saturated_Counter;

end Small_Ex;
