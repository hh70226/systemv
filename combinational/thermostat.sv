module top_module (
    input too_cold,
    input too_hot,
    input mode,
    input fan_on,
    output heater,
    output aircon,
    output fan
); 
   // mode = 1 in winter and 0 in summer, 1 = heater can turn on, 0 = aircon can turn on
    assign heater = too_cold & mode;
    assign aircon = too_hot & ~mode;
    assign fan = fan_on | & too_hot & ~mode | too_cold & mode;

endmodule