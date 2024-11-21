//PART 3 mod

// CSE140L  
// What does this do? 
// When does "z" go high? 
/**
date and month function.  counters that increment
every time the hour rolls over from 23 back to 0. 
 day counter will be modulo 28, 30, or
31, depending on the current value of the month counter.

**/
 module ct_mod_d (
  input             clk, 
                    rst, 
                    en,
  input logic [6:0] TMonth,
  output logic[6:0] ct_out,
  output logic      z);

  logic [6:0] next_ct;
/*  always_ff @(posedge clk)
    if(rst)
	  ct_out <= 0;
	else if(en)
	  ct_out <= (ct_out+1)%N;	  // modulo operator
    else 						  // optional
	  ct_out <= ct_out; 
*/

   always_ff @(posedge clk)     // sequential
     ct_out <= next_ct;    

   always_comb 	                // combo
     if(rst) 
	   next_ct = 0;
	 else if(en)
        if (TMonth == 1)
	   next_ct = (ct_out + 1)%28;
        else if (TMonth == 3 || TMonth == 5 || TMonth == 8 || TMonth == 10)
        next_ct = (ct_out + 1)%30;
        else 
        next_ct = (ct_out + 1)%31;
	 else 
	   next_ct = ct_out; 


/*
    else if(en)
	  if(ct_out==N-1)
	    ct_out <= 0;
	  else
	    ct_out <= ct_out+1

    always_ff @(posedge clk) a <= a+1;

     posedge clk arrives:   tempa = a+1;
	    complete all temps before moving on
	 a = tempa

	 in --> a --> b	--> c --> out
	 1	    1     0     0      0
	 0      1     1     0      0
	 0      0     1     1 

     c++    c=c+1   c<=c+1  
     
      if(c==d) ...	   if c.eq.d
      if(c<=d) ... 	   if c.le.d
        
	  assign c=c+1;    always_comb c = c+1; 

      always_comb begin
		#10ns c = c+1; 
      end


*/

  always_comb 
  if (TMonth == 1) 
  z = ct_out==(28-1);   // always @(*)   // always @(ct_out)
  else if (TMonth == 3 || TMonth == 5 || TMonth == 8 || TMonth == 10)
  z = ct_out==(30-1);
  else 
  z= ct_out==(31-1);




endmodule



