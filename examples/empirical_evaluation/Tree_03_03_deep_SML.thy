theory Tree_03_03_deep imports  "../../src/OCL_class_diagram_generator" begin
generation_syntax [ deep
                      (generation_semantics [ analysis (*, oid_start 10*) ])
                      skip_export
                      (THEORY Tree_03_03_generated)
                      (IMPORTS ["../../../src/OCL_main", "../../../src/OCL_class_diagram_static"]
                               "../../../src/OCL_class_diagram_generator")
                      SECTION
                      [ in SML module_name M (no_signatures) ]
                      (output_directory "./doc") ]

Class Aazz End
Class Bbyy End
Class Ccxx End
Class Ddww < Aazz End
Class Eevv < Aazz End
Class Ffuu < Aazz End
Class Ggtt < Ddww End
Class Hhss < Ddww End
Class Iirr < Ddww End
Class Jjqq < Eevv End
Class Kkpp < Eevv End
Class Lloo < Eevv End
Class Mmnn < Ffuu End
Class Nnmm < Ffuu End
Class Ooll < Ffuu End
Class Ppkk < Bbyy End
Class Qqjj < Bbyy End
Class Rrii < Bbyy End
Class Sshh < Ppkk End
Class Ttgg < Ppkk End
Class Uuff < Ppkk End
Class Vvee < Qqjj End
Class Wwdd < Qqjj End
Class Xxcc < Qqjj End
Class Yybb < Rrii End
Class Zzaa < Rrii End
Class Baba < Rrii End
Class Bbbb < Ccxx End
Class Bcbc < Ccxx End
Class Bdbd < Ccxx End
Class Bebe < Bbbb End
Class Bfbf < Bbbb End
Class Bgbg < Bbbb End
Class Bhbh < Bcbc End
Class Bibi < Bcbc End
Class Bjbj < Bcbc End
Class Bkbk < Bdbd End
Class Blbl < Bdbd End
Class Bmbm < Bdbd End

(* 39 *)

generation_syntax deep flush_all

end