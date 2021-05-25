package Small_Ex is

pragma Spark_Mode(On);

  type Value_Type is range 0 .. 15;

  function Saturated_Counter(x: in Value_Type) return Value_Type
    with Post =>
     (if x = 15 then
        Saturated_Counter'Result = x
      else Saturated_Counter'Result = x + 1);

end Small_Ex;
