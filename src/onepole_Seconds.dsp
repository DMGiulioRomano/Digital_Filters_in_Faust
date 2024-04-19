// import Standard Faust library 
// https://github.com/grame-cncm/faustlibraries/ 
import("stdfaust.lib"); 
  
 // (G)  = give amplitude 1-0 (open-close) for the lowpass cut 
 // (T) = Frequency in Seconds
 OPF(T, x) = OPFFBcircuit ~ _  
     with{ 
         g(x) = x / (1.0 + x); 
         G = g(tan((1 / T) * ma.PI / ma.SR)); 
         OPFFBcircuit(y) = x * G + (y * (1 - G)); 
         }; 
  
 process = _ : OPF(10) <: si.bus(2);