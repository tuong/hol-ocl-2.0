theory Employee_AnalysisModel_UMLPart_generated_generated imports "../src/UML_Main"   "../src/compiler/OCL_compiler_static"   "../src/compiler/OCL_compiler_generator_dynamic" begin

(* 1 ************************************ 0 + 0 *)

(* 2 ************************************ 0 + 1 *)
text{*  *}

(* 3 ************************************ 1 + 1 *)
text{* 
   \label{ex:employee-analysis:uml}  *}

(* 4 ************************************ 2 + 1 *)
section{* Introduction *}

(* 5 ************************************ 3 + 1 *)
text{* 

  For certain concepts like classes and class-types, only a generic
  definition for its resulting semantics can be given. Generic means,
  there is a function outside HOL that ``compiles'' a concrete,
  closed-world class diagram into a ``theory'' of this data model,
  consisting of a bunch of definitions for classes, accessors, method,
  casts, and tests for actual types, as well as proofs for the
  fundamental properties of these operations in this concrete data
  model.  *}

(* 6 ************************************ 4 + 1 *)
text{* 
   Such generic function or ``compiler'' can be implemented in
  Isabelle on the ML level.  This has been done, for a semantics
  following the open-world assumption, for UML 2.0
  in~\cite{brucker.ea:extensible:2008-b, brucker:interactive:2007}. In
  this paper, we follow another approach for UML 2.4: we define the
  concepts of the compilation informally, and present a concrete
  example which is verified in Isabelle/HOL.  *}

(* 7 ************************************ 5 + 1 *)
subsection{* Outlining the Example *}

(* 8 ************************************ 6 + 1 *)
text{*  *}

(* 9 ************************************ 7 + 1 *)
text{* 
   We are presenting here an ``analysis-model'' of the (slightly
modified) example Figure 7.3, page 20 of
the OCL standard~\cite{omg:ocl:2012}.
Here, analysis model means that associations
were really represented as relation on objects on the state---as is
intended by the standard---rather by pointers between objects as is
done in our ``design model'' (see \autoref{ex:employee-design:uml}).
To be precise, this theory contains the formalization of the data-part
covered by the UML class model (see \autoref{fig:person-ana}): *}

(* 10 ************************************ 8 + 1 *)
text{*  *}

(* 11 ************************************ 9 + 1 *)
text{* 

\begin{figure}
  \centering\scalebox{.3}{\includegraphics{figures/person.png}}%
  \caption{A simple UML class model drawn from Figure 7.3,
  page 20 of~\cite{omg:ocl:2012}. \label{fig:person-ana}}
\end{figure}
 *}

(* 12 ************************************ 10 + 1 *)
text{* 
   This means that the association (attached to the association class
\inlineocl{EmployeeRanking}) with the association ends \inlineocl+boss+ and \inlineocl+employees+ is implemented
by the attribute  \inlineocl+boss+ and the operation \inlineocl+employees+ (to be discussed in the OCL part
captured by the subsequent theory).
 *}

(* 13 ************************************ 11 + 1 *)
section{* Example Data-Universe and its Infrastructure *}

(* 14 ************************************ 12 + 1 *)
text{* 
   Our data universe  consists in the concrete class diagram just of node's,
and implicitly of the class object. Each class implies the existence of a class
type defined for the corresponding object representations as follows:  *}

(* 15 ************************************ 13 + 8 *)
datatype ty\<E>\<X>\<T>\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n = mk\<E>\<X>\<T>\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n "oid" "nat option" "int option" "unit option" "bool option" "oid list list option"
datatype ty\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n = mk\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n "ty\<E>\<X>\<T>\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n" "int option"
datatype ty\<E>\<X>\<T>\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t = mk\<E>\<X>\<T>\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n "ty\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n"
                        | mk\<E>\<X>\<T>\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t "oid" "unit option" "bool option" "oid list list option"
datatype ty\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t = mk\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t "ty\<E>\<X>\<T>\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t" "nat option" "int option"
datatype ty\<E>\<X>\<T>\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y = mk\<E>\<X>\<T>\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t "ty\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t"
                        | mk\<E>\<X>\<T>\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n "ty\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n"
                        | mk\<E>\<X>\<T>\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y "oid"
datatype ty\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y = mk\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y "ty\<E>\<X>\<T>\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y" "unit option" "bool option" "oid list list option"
datatype ty\<E>\<X>\<T>\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y = mk\<E>\<X>\<T>\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y "ty\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y"
                        | mk\<E>\<X>\<T>\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t "ty\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t"
                        | mk\<E>\<X>\<T>\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n "ty\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n"
                        | mk\<E>\<X>\<T>\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y "oid"
datatype ty\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y = mk\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y "ty\<E>\<X>\<T>\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y"

(* 16 ************************************ 21 + 1 *)
text{* 
   Now, we construct a concrete ``universe of OclAny types'' by injection into a
sum type containing the class types. This type of OclAny will be used as instance
for all respective type-variables.  *}

(* 17 ************************************ 22 + 1 *)
datatype \<AA> = in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n "ty\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n"
                        | in\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t "ty\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t"
                        | in\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y "ty\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y"
                        | in\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y "ty\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y"

(* 18 ************************************ 23 + 1 *)
text{* 
   Having fixed the object universe, we can introduce type synonyms that exactly correspond
to OCL types. Again, we exploit that our representation of OCL is a ``shallow embedding'' with a
one-to-one correspondance of OCL-types to types of the meta-language HOL.  *}

(* 19 ************************************ 24 + 7 *)
type_synonym Void = "\<AA> Void"
type_synonym Boolean = "\<AA> Boolean"
type_synonym Integer = "\<AA> Integer"
type_synonym Real = "\<AA> Real"
type_synonym String = "\<AA> String"
type_synonym '\<alpha> val' = "(\<AA>, '\<alpha>) val"
type_notation val' ("\<cdot>(_)")

(* 20 ************************************ 31 + 4 *)
type_synonym Person = "\<langle>\<langle>ty\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rangle>\<^sub>\<bottom>\<rangle>\<^sub>\<bottom>"
type_synonym Planet = "\<langle>\<langle>ty\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<rangle>\<^sub>\<bottom>\<rangle>\<^sub>\<bottom>"
type_synonym Galaxy = "\<langle>\<langle>ty\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y\<rangle>\<^sub>\<bottom>\<rangle>\<^sub>\<bottom>"
type_synonym OclAny = "\<langle>\<langle>ty\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y\<rangle>\<^sub>\<bottom>\<rangle>\<^sub>\<bottom>"

(* 21 ************************************ 35 + 3 *)
type_synonym Sequence_Person = "(\<AA>, ty\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n option option Sequence\<^sub>b\<^sub>a\<^sub>s\<^sub>e) val"
type_synonym Set_Person = "(\<AA>, ty\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n option option Set\<^sub>b\<^sub>a\<^sub>s\<^sub>e) val"
type_synonym Set_Sequence_Planet = "(\<AA>, ty\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t option option Sequence\<^sub>b\<^sub>a\<^sub>s\<^sub>e Set\<^sub>b\<^sub>a\<^sub>s\<^sub>e) val"

(* 22 ************************************ 38 + 0 *)

(* 23 ************************************ 38 + 1 *)
text{* 
   To reuse key-elements of the library like referential equality, we have
to show that the object universe belongs to the type class ``oclany,'' \ie,
 each class type has to provide a function @{term oid_of} yielding the object id (oid) of the object.  *}

(* 24 ************************************ 39 + 4 *)
instantiation ty\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n :: object
begin
  definition oid_of_ty\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_def : "oid_of = (\<lambda> mk\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n t _ \<Rightarrow> (case t of (mk\<E>\<X>\<T>\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (t) (_) (_) (_) (_) (_)) \<Rightarrow> t))"
  instance ..
end
instantiation ty\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t :: object
begin
  definition oid_of_ty\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_def : "oid_of = (\<lambda> mk\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t t _ _ \<Rightarrow> (case t of (mk\<E>\<X>\<T>\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t (t) (_) (_) (_)) \<Rightarrow> t
    | (mk\<E>\<X>\<T>\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (t)) \<Rightarrow> (oid_of (t))))"
  instance ..
end
instantiation ty\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y :: object
begin
  definition oid_of_ty\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_def : "oid_of = (\<lambda> mk\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y t _ _ _ \<Rightarrow> (case t of (mk\<E>\<X>\<T>\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y (t)) \<Rightarrow> t
    | (mk\<E>\<X>\<T>\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (t)) \<Rightarrow> (oid_of (t))
    | (mk\<E>\<X>\<T>\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t (t)) \<Rightarrow> (oid_of (t))))"
  instance ..
end
instantiation ty\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y :: object
begin
  definition oid_of_ty\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_def : "oid_of = (\<lambda> mk\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y t \<Rightarrow> (case t of (mk\<E>\<X>\<T>\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y (t)) \<Rightarrow> t
    | (mk\<E>\<X>\<T>\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (t)) \<Rightarrow> (oid_of (t))
    | (mk\<E>\<X>\<T>\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t (t)) \<Rightarrow> (oid_of (t))
    | (mk\<E>\<X>\<T>\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y (t)) \<Rightarrow> (oid_of (t))))"
  instance ..
end

(* 25 ************************************ 43 + 1 *)
instantiation \<AA> :: object
begin
  definition oid_of_\<AA>_def : "oid_of = (\<lambda> in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n Person \<Rightarrow> oid_of Person
    | in\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t Planet \<Rightarrow> oid_of Planet
    | in\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y Galaxy \<Rightarrow> oid_of Galaxy
    | in\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y OclAny \<Rightarrow> oid_of OclAny)"
  instance ..
end

(* 26 ************************************ 44 + 1 *)
section{* Instantiation of the Generic Strict Equality *}

(* 27 ************************************ 45 + 1 *)
text{* 
   We instantiate the referential equality
on @{text "Person"} and @{text "OclAny"}  *}

(* 28 ************************************ 46 + 4 *)
defs(overloaded) StrictRefEq\<^sub>O\<^sub>b\<^sub>j\<^sub>e\<^sub>c\<^sub>t_\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n : "(x::\<cdot>Person) \<doteq> y \<equiv> StrictRefEq\<^sub>O\<^sub>b\<^sub>j\<^sub>e\<^sub>c\<^sub>t x y"
defs(overloaded) StrictRefEq\<^sub>O\<^sub>b\<^sub>j\<^sub>e\<^sub>c\<^sub>t_\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t : "(x::\<cdot>Planet) \<doteq> y \<equiv> StrictRefEq\<^sub>O\<^sub>b\<^sub>j\<^sub>e\<^sub>c\<^sub>t x y"
defs(overloaded) StrictRefEq\<^sub>O\<^sub>b\<^sub>j\<^sub>e\<^sub>c\<^sub>t_\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y : "(x::\<cdot>Galaxy) \<doteq> y \<equiv> StrictRefEq\<^sub>O\<^sub>b\<^sub>j\<^sub>e\<^sub>c\<^sub>t x y"
defs(overloaded) StrictRefEq\<^sub>O\<^sub>b\<^sub>j\<^sub>e\<^sub>c\<^sub>t_\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y : "(x::\<cdot>OclAny) \<doteq> y \<equiv> StrictRefEq\<^sub>O\<^sub>b\<^sub>j\<^sub>e\<^sub>c\<^sub>t x y"

(* 29 ************************************ 50 + 1 *)
lemmas[simp,code_unfold] = StrictRefEq\<^sub>O\<^sub>b\<^sub>j\<^sub>e\<^sub>c\<^sub>t_\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n
                            StrictRefEq\<^sub>O\<^sub>b\<^sub>j\<^sub>e\<^sub>c\<^sub>t_\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t
                            StrictRefEq\<^sub>O\<^sub>b\<^sub>j\<^sub>e\<^sub>c\<^sub>t_\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y
                            StrictRefEq\<^sub>O\<^sub>b\<^sub>j\<^sub>e\<^sub>c\<^sub>t_\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y

(* 30 ************************************ 51 + 1 *)
text{* 
   For each Class \emph{C}, we will have a casting operation \inlineocl{.oclAsType($C$)},
   a test on the actual type \inlineocl{.oclIsTypeOf($C$)} as well as its relaxed form
   \inlineocl{.oclIsKindOf($C$)} (corresponding exactly to Java's \verb+instanceof+-operator.
 *}

(* 31 ************************************ 52 + 1 *)
text{* 
   Thus, since we have two class-types in our concrete class hierarchy, we have
two operations to declare and to provide two overloading definitions for the two static types.
 *}

(* 32 ************************************ 53 + 1 *)
section{* OclAsType *}

(* 33 ************************************ 54 + 1 *)
subsection{* Definition *}

(* 34 ************************************ 55 + 4 *)
consts OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n :: "'\<alpha> \<Rightarrow> \<cdot>Person" ("(_) .oclAsType'(Person')")
consts OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t :: "'\<alpha> \<Rightarrow> \<cdot>Planet" ("(_) .oclAsType'(Planet')")
consts OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y :: "'\<alpha> \<Rightarrow> \<cdot>Galaxy" ("(_) .oclAsType'(Galaxy')")
consts OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y :: "'\<alpha> \<Rightarrow> \<cdot>OclAny" ("(_) .oclAsType'(OclAny')")

(* 35 ************************************ 59 + 16 *)
defs(overloaded) OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person : "(x::\<cdot>Person) .oclAsType(Person) \<equiv> x"
defs(overloaded) OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet : "(x::\<cdot>Planet) .oclAsType(Person) \<equiv> (\<lambda>\<tau>. (case (x (\<tau>)) of \<bottom> \<Rightarrow> (invalid (\<tau>))
    | \<lfloor>\<bottom>\<rfloor> \<Rightarrow> (null (\<tau>))
    | \<lfloor>\<lfloor>(mk\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t ((mk\<E>\<X>\<T>\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (Person))) (_) (_))\<rfloor>\<rfloor> \<Rightarrow> \<lfloor>\<lfloor>Person\<rfloor>\<rfloor>
    | _ \<Rightarrow> (invalid (\<tau>))))"
defs(overloaded) OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy : "(x::\<cdot>Galaxy) .oclAsType(Person) \<equiv> (\<lambda>\<tau>. (case (x (\<tau>)) of \<bottom> \<Rightarrow> (invalid (\<tau>))
    | \<lfloor>\<bottom>\<rfloor> \<Rightarrow> (null (\<tau>))
    | \<lfloor>\<lfloor>(mk\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y ((mk\<E>\<X>\<T>\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (Person))) (_) (_) (_))\<rfloor>\<rfloor> \<Rightarrow> \<lfloor>\<lfloor>Person\<rfloor>\<rfloor>
    | _ \<Rightarrow> (invalid (\<tau>))))"
defs(overloaded) OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny : "(x::\<cdot>OclAny) .oclAsType(Person) \<equiv> (\<lambda>\<tau>. (case (x (\<tau>)) of \<bottom> \<Rightarrow> (invalid (\<tau>))
    | \<lfloor>\<bottom>\<rfloor> \<Rightarrow> (null (\<tau>))
    | \<lfloor>\<lfloor>(mk\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y ((mk\<E>\<X>\<T>\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (Person))))\<rfloor>\<rfloor> \<Rightarrow> \<lfloor>\<lfloor>Person\<rfloor>\<rfloor>
    | _ \<Rightarrow> (invalid (\<tau>))))"
defs(overloaded) OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet : "(x::\<cdot>Planet) .oclAsType(Planet) \<equiv> x"
defs(overloaded) OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy : "(x::\<cdot>Galaxy) .oclAsType(Planet) \<equiv> (\<lambda>\<tau>. (case (x (\<tau>)) of \<bottom> \<Rightarrow> (invalid (\<tau>))
    | \<lfloor>\<bottom>\<rfloor> \<Rightarrow> (null (\<tau>))
    | \<lfloor>\<lfloor>(mk\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y ((mk\<E>\<X>\<T>\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t (Planet))) (_) (_) (_))\<rfloor>\<rfloor> \<Rightarrow> \<lfloor>\<lfloor>Planet\<rfloor>\<rfloor>
    | _ \<Rightarrow> (invalid (\<tau>))))"
defs(overloaded) OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny : "(x::\<cdot>OclAny) .oclAsType(Planet) \<equiv> (\<lambda>\<tau>. (case (x (\<tau>)) of \<bottom> \<Rightarrow> (invalid (\<tau>))
    | \<lfloor>\<bottom>\<rfloor> \<Rightarrow> (null (\<tau>))
    | \<lfloor>\<lfloor>(mk\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y ((mk\<E>\<X>\<T>\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t (Planet))))\<rfloor>\<rfloor> \<Rightarrow> \<lfloor>\<lfloor>Planet\<rfloor>\<rfloor>
    | _ \<Rightarrow> (invalid (\<tau>))))"
defs(overloaded) OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person : "(x::\<cdot>Person) .oclAsType(Planet) \<equiv> (\<lambda>\<tau>. (case (x (\<tau>)) of \<bottom> \<Rightarrow> (invalid (\<tau>))
    | \<lfloor>\<bottom>\<rfloor> \<Rightarrow> (null (\<tau>))
    | \<lfloor>\<lfloor>Person\<rfloor>\<rfloor> \<Rightarrow> \<lfloor>\<lfloor>(mk\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t ((mk\<E>\<X>\<T>\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (Person))) (None) (None))\<rfloor>\<rfloor>))"
defs(overloaded) OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy : "(x::\<cdot>Galaxy) .oclAsType(Galaxy) \<equiv> x"
defs(overloaded) OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny : "(x::\<cdot>OclAny) .oclAsType(Galaxy) \<equiv> (\<lambda>\<tau>. (case (x (\<tau>)) of \<bottom> \<Rightarrow> (invalid (\<tau>))
    | \<lfloor>\<bottom>\<rfloor> \<Rightarrow> (null (\<tau>))
    | \<lfloor>\<lfloor>(mk\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y ((mk\<E>\<X>\<T>\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y (Galaxy))))\<rfloor>\<rfloor> \<Rightarrow> \<lfloor>\<lfloor>Galaxy\<rfloor>\<rfloor>
    | _ \<Rightarrow> (invalid (\<tau>))))"
defs(overloaded) OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person : "(x::\<cdot>Person) .oclAsType(Galaxy) \<equiv> (\<lambda>\<tau>. (case (x (\<tau>)) of \<bottom> \<Rightarrow> (invalid (\<tau>))
    | \<lfloor>\<bottom>\<rfloor> \<Rightarrow> (null (\<tau>))
    | \<lfloor>\<lfloor>Person\<rfloor>\<rfloor> \<Rightarrow> \<lfloor>\<lfloor>(mk\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y ((mk\<E>\<X>\<T>\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (Person))) (None) (None) (None))\<rfloor>\<rfloor>))"
defs(overloaded) OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet : "(x::\<cdot>Planet) .oclAsType(Galaxy) \<equiv> (\<lambda>\<tau>. (case (x (\<tau>)) of \<bottom> \<Rightarrow> (invalid (\<tau>))
    | \<lfloor>\<bottom>\<rfloor> \<Rightarrow> (null (\<tau>))
    | \<lfloor>\<lfloor>Planet\<rfloor>\<rfloor> \<Rightarrow> \<lfloor>\<lfloor>(mk\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y ((mk\<E>\<X>\<T>\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t (Planet))) (None) (None) (None))\<rfloor>\<rfloor>))"
defs(overloaded) OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny : "(x::\<cdot>OclAny) .oclAsType(OclAny) \<equiv> x"
defs(overloaded) OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person : "(x::\<cdot>Person) .oclAsType(OclAny) \<equiv> (\<lambda>\<tau>. (case (x (\<tau>)) of \<bottom> \<Rightarrow> (invalid (\<tau>))
    | \<lfloor>\<bottom>\<rfloor> \<Rightarrow> (null (\<tau>))
    | \<lfloor>\<lfloor>Person\<rfloor>\<rfloor> \<Rightarrow> \<lfloor>\<lfloor>(mk\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y ((mk\<E>\<X>\<T>\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (Person))))\<rfloor>\<rfloor>))"
defs(overloaded) OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet : "(x::\<cdot>Planet) .oclAsType(OclAny) \<equiv> (\<lambda>\<tau>. (case (x (\<tau>)) of \<bottom> \<Rightarrow> (invalid (\<tau>))
    | \<lfloor>\<bottom>\<rfloor> \<Rightarrow> (null (\<tau>))
    | \<lfloor>\<lfloor>Planet\<rfloor>\<rfloor> \<Rightarrow> \<lfloor>\<lfloor>(mk\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y ((mk\<E>\<X>\<T>\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t (Planet))))\<rfloor>\<rfloor>))"
defs(overloaded) OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy : "(x::\<cdot>Galaxy) .oclAsType(OclAny) \<equiv> (\<lambda>\<tau>. (case (x (\<tau>)) of \<bottom> \<Rightarrow> (invalid (\<tau>))
    | \<lfloor>\<bottom>\<rfloor> \<Rightarrow> (null (\<tau>))
    | \<lfloor>\<lfloor>Galaxy\<rfloor>\<rfloor> \<Rightarrow> \<lfloor>\<lfloor>(mk\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y ((mk\<E>\<X>\<T>\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y (Galaxy))))\<rfloor>\<rfloor>))"

(* 36 ************************************ 75 + 4 *)
definition "OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_\<AA> = (\<lambda> (in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (Person)) \<Rightarrow> \<lfloor>Person\<rfloor>
    | (in\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t ((mk\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t ((mk\<E>\<X>\<T>\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (Person))) (_) (_)))) \<Rightarrow> \<lfloor>Person\<rfloor>
    | (in\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y ((mk\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y ((mk\<E>\<X>\<T>\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (Person))) (_) (_) (_)))) \<Rightarrow> \<lfloor>Person\<rfloor>
    | (in\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y ((mk\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y ((mk\<E>\<X>\<T>\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (Person)))))) \<Rightarrow> \<lfloor>Person\<rfloor>
    | _ \<Rightarrow> None)"
definition "OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_\<AA> = (\<lambda> (in\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t (Planet)) \<Rightarrow> \<lfloor>Planet\<rfloor>
    | (in\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y ((mk\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y ((mk\<E>\<X>\<T>\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t (Planet))) (_) (_) (_)))) \<Rightarrow> \<lfloor>Planet\<rfloor>
    | (in\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y ((mk\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y ((mk\<E>\<X>\<T>\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t (Planet)))))) \<Rightarrow> \<lfloor>Planet\<rfloor>
    | (in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (Person)) \<Rightarrow> \<lfloor>(mk\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t ((mk\<E>\<X>\<T>\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (Person))) (None) (None))\<rfloor>
    | _ \<Rightarrow> None)"
definition "OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_\<AA> = (\<lambda> (in\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y (Galaxy)) \<Rightarrow> \<lfloor>Galaxy\<rfloor>
    | (in\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y ((mk\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y ((mk\<E>\<X>\<T>\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y (Galaxy)))))) \<Rightarrow> \<lfloor>Galaxy\<rfloor>
    | (in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (Person)) \<Rightarrow> \<lfloor>(mk\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y ((mk\<E>\<X>\<T>\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (Person))) (None) (None) (None))\<rfloor>
    | (in\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t (Planet)) \<Rightarrow> \<lfloor>(mk\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y ((mk\<E>\<X>\<T>\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t (Planet))) (None) (None) (None))\<rfloor>
    | _ \<Rightarrow> None)"
definition "OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_\<AA> = Some o (\<lambda> (in\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y (OclAny)) \<Rightarrow> OclAny
    | (in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (Person)) \<Rightarrow> (mk\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y ((mk\<E>\<X>\<T>\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (Person))))
    | (in\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t (Planet)) \<Rightarrow> (mk\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y ((mk\<E>\<X>\<T>\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t (Planet))))
    | (in\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y (Galaxy)) \<Rightarrow> (mk\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y ((mk\<E>\<X>\<T>\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y (Galaxy)))))"

(* 37 ************************************ 79 + 1 *)
lemmas[simp,code_unfold] = OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person
                            OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet
                            OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy
                            OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny

(* 38 ************************************ 80 + 1 *)
subsection{* Context Passing *}

(* 39 ************************************ 81 + 64 *)
lemma cp_OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny_OclAny : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>OclAny)))::\<cdot>OclAny) .oclAsType(OclAny)))))"
by(rule cpI1, simp)
lemma cp_OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy_OclAny : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Galaxy)))::\<cdot>OclAny) .oclAsType(OclAny)))))"
by(rule cpI1, simp)
lemma cp_OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet_OclAny : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Planet)))::\<cdot>OclAny) .oclAsType(OclAny)))))"
by(rule cpI1, simp)
lemma cp_OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person_OclAny : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Person)))::\<cdot>OclAny) .oclAsType(OclAny)))))"
by(rule cpI1, simp)
lemma cp_OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny_Galaxy : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>OclAny)))::\<cdot>Galaxy) .oclAsType(OclAny)))))"
by(rule cpI1, simp add: OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy)
lemma cp_OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy_Galaxy : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Galaxy)))::\<cdot>Galaxy) .oclAsType(OclAny)))))"
by(rule cpI1, simp add: OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy)
lemma cp_OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet_Galaxy : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Planet)))::\<cdot>Galaxy) .oclAsType(OclAny)))))"
by(rule cpI1, simp add: OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy)
lemma cp_OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person_Galaxy : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Person)))::\<cdot>Galaxy) .oclAsType(OclAny)))))"
by(rule cpI1, simp add: OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy)
lemma cp_OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny_Planet : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>OclAny)))::\<cdot>Planet) .oclAsType(OclAny)))))"
by(rule cpI1, simp add: OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet)
lemma cp_OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy_Planet : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Galaxy)))::\<cdot>Planet) .oclAsType(OclAny)))))"
by(rule cpI1, simp add: OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet)
lemma cp_OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet_Planet : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Planet)))::\<cdot>Planet) .oclAsType(OclAny)))))"
by(rule cpI1, simp add: OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet)
lemma cp_OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person_Planet : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Person)))::\<cdot>Planet) .oclAsType(OclAny)))))"
by(rule cpI1, simp add: OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet)
lemma cp_OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny_Person : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>OclAny)))::\<cdot>Person) .oclAsType(OclAny)))))"
by(rule cpI1, simp add: OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person)
lemma cp_OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy_Person : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Galaxy)))::\<cdot>Person) .oclAsType(OclAny)))))"
by(rule cpI1, simp add: OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person)
lemma cp_OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet_Person : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Planet)))::\<cdot>Person) .oclAsType(OclAny)))))"
by(rule cpI1, simp add: OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person)
lemma cp_OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person_Person : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Person)))::\<cdot>Person) .oclAsType(OclAny)))))"
by(rule cpI1, simp add: OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person)
lemma cp_OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny_OclAny : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>OclAny)))::\<cdot>OclAny) .oclAsType(Galaxy)))))"
by(rule cpI1, simp add: OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny)
lemma cp_OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy_OclAny : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Galaxy)))::\<cdot>OclAny) .oclAsType(Galaxy)))))"
by(rule cpI1, simp add: OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny)
lemma cp_OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet_OclAny : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Planet)))::\<cdot>OclAny) .oclAsType(Galaxy)))))"
by(rule cpI1, simp add: OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny)
lemma cp_OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person_OclAny : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Person)))::\<cdot>OclAny) .oclAsType(Galaxy)))))"
by(rule cpI1, simp add: OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny)
lemma cp_OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny_Galaxy : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>OclAny)))::\<cdot>Galaxy) .oclAsType(Galaxy)))))"
by(rule cpI1, simp)
lemma cp_OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy_Galaxy : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Galaxy)))::\<cdot>Galaxy) .oclAsType(Galaxy)))))"
by(rule cpI1, simp)
lemma cp_OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet_Galaxy : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Planet)))::\<cdot>Galaxy) .oclAsType(Galaxy)))))"
by(rule cpI1, simp)
lemma cp_OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person_Galaxy : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Person)))::\<cdot>Galaxy) .oclAsType(Galaxy)))))"
by(rule cpI1, simp)
lemma cp_OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny_Planet : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>OclAny)))::\<cdot>Planet) .oclAsType(Galaxy)))))"
by(rule cpI1, simp add: OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet)
lemma cp_OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy_Planet : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Galaxy)))::\<cdot>Planet) .oclAsType(Galaxy)))))"
by(rule cpI1, simp add: OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet)
lemma cp_OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet_Planet : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Planet)))::\<cdot>Planet) .oclAsType(Galaxy)))))"
by(rule cpI1, simp add: OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet)
lemma cp_OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person_Planet : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Person)))::\<cdot>Planet) .oclAsType(Galaxy)))))"
by(rule cpI1, simp add: OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet)
lemma cp_OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny_Person : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>OclAny)))::\<cdot>Person) .oclAsType(Galaxy)))))"
by(rule cpI1, simp add: OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person)
lemma cp_OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy_Person : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Galaxy)))::\<cdot>Person) .oclAsType(Galaxy)))))"
by(rule cpI1, simp add: OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person)
lemma cp_OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet_Person : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Planet)))::\<cdot>Person) .oclAsType(Galaxy)))))"
by(rule cpI1, simp add: OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person)
lemma cp_OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person_Person : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Person)))::\<cdot>Person) .oclAsType(Galaxy)))))"
by(rule cpI1, simp add: OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person)
lemma cp_OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny_OclAny : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>OclAny)))::\<cdot>OclAny) .oclAsType(Planet)))))"
by(rule cpI1, simp add: OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny)
lemma cp_OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy_OclAny : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Galaxy)))::\<cdot>OclAny) .oclAsType(Planet)))))"
by(rule cpI1, simp add: OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny)
lemma cp_OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet_OclAny : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Planet)))::\<cdot>OclAny) .oclAsType(Planet)))))"
by(rule cpI1, simp add: OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny)
lemma cp_OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person_OclAny : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Person)))::\<cdot>OclAny) .oclAsType(Planet)))))"
by(rule cpI1, simp add: OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny)
lemma cp_OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny_Galaxy : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>OclAny)))::\<cdot>Galaxy) .oclAsType(Planet)))))"
by(rule cpI1, simp add: OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy)
lemma cp_OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy_Galaxy : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Galaxy)))::\<cdot>Galaxy) .oclAsType(Planet)))))"
by(rule cpI1, simp add: OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy)
lemma cp_OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet_Galaxy : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Planet)))::\<cdot>Galaxy) .oclAsType(Planet)))))"
by(rule cpI1, simp add: OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy)
lemma cp_OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person_Galaxy : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Person)))::\<cdot>Galaxy) .oclAsType(Planet)))))"
by(rule cpI1, simp add: OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy)
lemma cp_OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny_Planet : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>OclAny)))::\<cdot>Planet) .oclAsType(Planet)))))"
by(rule cpI1, simp)
lemma cp_OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy_Planet : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Galaxy)))::\<cdot>Planet) .oclAsType(Planet)))))"
by(rule cpI1, simp)
lemma cp_OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet_Planet : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Planet)))::\<cdot>Planet) .oclAsType(Planet)))))"
by(rule cpI1, simp)
lemma cp_OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person_Planet : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Person)))::\<cdot>Planet) .oclAsType(Planet)))))"
by(rule cpI1, simp)
lemma cp_OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny_Person : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>OclAny)))::\<cdot>Person) .oclAsType(Planet)))))"
by(rule cpI1, simp add: OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person)
lemma cp_OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy_Person : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Galaxy)))::\<cdot>Person) .oclAsType(Planet)))))"
by(rule cpI1, simp add: OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person)
lemma cp_OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet_Person : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Planet)))::\<cdot>Person) .oclAsType(Planet)))))"
by(rule cpI1, simp add: OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person)
lemma cp_OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person_Person : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Person)))::\<cdot>Person) .oclAsType(Planet)))))"
by(rule cpI1, simp add: OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person)
lemma cp_OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny_OclAny : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>OclAny)))::\<cdot>OclAny) .oclAsType(Person)))))"
by(rule cpI1, simp add: OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny)
lemma cp_OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy_OclAny : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Galaxy)))::\<cdot>OclAny) .oclAsType(Person)))))"
by(rule cpI1, simp add: OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny)
lemma cp_OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet_OclAny : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Planet)))::\<cdot>OclAny) .oclAsType(Person)))))"
by(rule cpI1, simp add: OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny)
lemma cp_OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person_OclAny : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Person)))::\<cdot>OclAny) .oclAsType(Person)))))"
by(rule cpI1, simp add: OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny)
lemma cp_OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny_Galaxy : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>OclAny)))::\<cdot>Galaxy) .oclAsType(Person)))))"
by(rule cpI1, simp add: OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy)
lemma cp_OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy_Galaxy : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Galaxy)))::\<cdot>Galaxy) .oclAsType(Person)))))"
by(rule cpI1, simp add: OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy)
lemma cp_OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet_Galaxy : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Planet)))::\<cdot>Galaxy) .oclAsType(Person)))))"
by(rule cpI1, simp add: OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy)
lemma cp_OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person_Galaxy : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Person)))::\<cdot>Galaxy) .oclAsType(Person)))))"
by(rule cpI1, simp add: OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy)
lemma cp_OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny_Planet : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>OclAny)))::\<cdot>Planet) .oclAsType(Person)))))"
by(rule cpI1, simp add: OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet)
lemma cp_OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy_Planet : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Galaxy)))::\<cdot>Planet) .oclAsType(Person)))))"
by(rule cpI1, simp add: OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet)
lemma cp_OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet_Planet : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Planet)))::\<cdot>Planet) .oclAsType(Person)))))"
by(rule cpI1, simp add: OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet)
lemma cp_OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person_Planet : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Person)))::\<cdot>Planet) .oclAsType(Person)))))"
by(rule cpI1, simp add: OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet)
lemma cp_OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny_Person : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>OclAny)))::\<cdot>Person) .oclAsType(Person)))))"
by(rule cpI1, simp)
lemma cp_OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy_Person : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Galaxy)))::\<cdot>Person) .oclAsType(Person)))))"
by(rule cpI1, simp)
lemma cp_OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet_Person : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Planet)))::\<cdot>Person) .oclAsType(Person)))))"
by(rule cpI1, simp)
lemma cp_OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person_Person : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Person)))::\<cdot>Person) .oclAsType(Person)))))"
by(rule cpI1, simp)

(* 40 ************************************ 145 + 1 *)
lemmas[simp,code_unfold] = cp_OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny_OclAny
                            cp_OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy_OclAny
                            cp_OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet_OclAny
                            cp_OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person_OclAny
                            cp_OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny_Galaxy
                            cp_OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy_Galaxy
                            cp_OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet_Galaxy
                            cp_OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person_Galaxy
                            cp_OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny_Planet
                            cp_OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy_Planet
                            cp_OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet_Planet
                            cp_OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person_Planet
                            cp_OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny_Person
                            cp_OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy_Person
                            cp_OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet_Person
                            cp_OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person_Person
                            cp_OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny_OclAny
                            cp_OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy_OclAny
                            cp_OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet_OclAny
                            cp_OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person_OclAny
                            cp_OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny_Galaxy
                            cp_OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy_Galaxy
                            cp_OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet_Galaxy
                            cp_OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person_Galaxy
                            cp_OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny_Planet
                            cp_OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy_Planet
                            cp_OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet_Planet
                            cp_OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person_Planet
                            cp_OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny_Person
                            cp_OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy_Person
                            cp_OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet_Person
                            cp_OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person_Person
                            cp_OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny_OclAny
                            cp_OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy_OclAny
                            cp_OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet_OclAny
                            cp_OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person_OclAny
                            cp_OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny_Galaxy
                            cp_OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy_Galaxy
                            cp_OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet_Galaxy
                            cp_OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person_Galaxy
                            cp_OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny_Planet
                            cp_OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy_Planet
                            cp_OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet_Planet
                            cp_OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person_Planet
                            cp_OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny_Person
                            cp_OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy_Person
                            cp_OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet_Person
                            cp_OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person_Person
                            cp_OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny_OclAny
                            cp_OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy_OclAny
                            cp_OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet_OclAny
                            cp_OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person_OclAny
                            cp_OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny_Galaxy
                            cp_OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy_Galaxy
                            cp_OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet_Galaxy
                            cp_OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person_Galaxy
                            cp_OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny_Planet
                            cp_OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy_Planet
                            cp_OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet_Planet
                            cp_OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person_Planet
                            cp_OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny_Person
                            cp_OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy_Person
                            cp_OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet_Person
                            cp_OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person_Person

(* 41 ************************************ 146 + 1 *)
subsection{* Execution with Invalid or Null as Argument *}

(* 42 ************************************ 147 + 32 *)
lemma OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny_invalid : "((invalid::\<cdot>OclAny) .oclAsType(OclAny)) = invalid"
by(simp)
lemma OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy_invalid : "((invalid::\<cdot>Galaxy) .oclAsType(OclAny)) = invalid"
by(rule ext, simp add: OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy bot_option_def invalid_def)
lemma OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet_invalid : "((invalid::\<cdot>Planet) .oclAsType(OclAny)) = invalid"
by(rule ext, simp add: OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet bot_option_def invalid_def)
lemma OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person_invalid : "((invalid::\<cdot>Person) .oclAsType(OclAny)) = invalid"
by(rule ext, simp add: OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person bot_option_def invalid_def)
lemma OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny_null : "((null::\<cdot>OclAny) .oclAsType(OclAny)) = null"
by(simp)
lemma OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy_null : "((null::\<cdot>Galaxy) .oclAsType(OclAny)) = null"
by(rule ext, simp add: OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy bot_option_def null_fun_def null_option_def)
lemma OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet_null : "((null::\<cdot>Planet) .oclAsType(OclAny)) = null"
by(rule ext, simp add: OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet bot_option_def null_fun_def null_option_def)
lemma OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person_null : "((null::\<cdot>Person) .oclAsType(OclAny)) = null"
by(rule ext, simp add: OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person bot_option_def null_fun_def null_option_def)
lemma OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny_invalid : "((invalid::\<cdot>OclAny) .oclAsType(Galaxy)) = invalid"
by(rule ext, simp add: OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny bot_option_def invalid_def)
lemma OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy_invalid : "((invalid::\<cdot>Galaxy) .oclAsType(Galaxy)) = invalid"
by(simp)
lemma OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet_invalid : "((invalid::\<cdot>Planet) .oclAsType(Galaxy)) = invalid"
by(rule ext, simp add: OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet bot_option_def invalid_def)
lemma OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person_invalid : "((invalid::\<cdot>Person) .oclAsType(Galaxy)) = invalid"
by(rule ext, simp add: OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person bot_option_def invalid_def)
lemma OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny_null : "((null::\<cdot>OclAny) .oclAsType(Galaxy)) = null"
by(rule ext, simp add: OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny bot_option_def null_fun_def null_option_def)
lemma OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy_null : "((null::\<cdot>Galaxy) .oclAsType(Galaxy)) = null"
by(simp)
lemma OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet_null : "((null::\<cdot>Planet) .oclAsType(Galaxy)) = null"
by(rule ext, simp add: OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet bot_option_def null_fun_def null_option_def)
lemma OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person_null : "((null::\<cdot>Person) .oclAsType(Galaxy)) = null"
by(rule ext, simp add: OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person bot_option_def null_fun_def null_option_def)
lemma OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny_invalid : "((invalid::\<cdot>OclAny) .oclAsType(Planet)) = invalid"
by(rule ext, simp add: OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny bot_option_def invalid_def)
lemma OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy_invalid : "((invalid::\<cdot>Galaxy) .oclAsType(Planet)) = invalid"
by(rule ext, simp add: OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy bot_option_def invalid_def)
lemma OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet_invalid : "((invalid::\<cdot>Planet) .oclAsType(Planet)) = invalid"
by(simp)
lemma OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person_invalid : "((invalid::\<cdot>Person) .oclAsType(Planet)) = invalid"
by(rule ext, simp add: OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person bot_option_def invalid_def)
lemma OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny_null : "((null::\<cdot>OclAny) .oclAsType(Planet)) = null"
by(rule ext, simp add: OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny bot_option_def null_fun_def null_option_def)
lemma OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy_null : "((null::\<cdot>Galaxy) .oclAsType(Planet)) = null"
by(rule ext, simp add: OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy bot_option_def null_fun_def null_option_def)
lemma OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet_null : "((null::\<cdot>Planet) .oclAsType(Planet)) = null"
by(simp)
lemma OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person_null : "((null::\<cdot>Person) .oclAsType(Planet)) = null"
by(rule ext, simp add: OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person bot_option_def null_fun_def null_option_def)
lemma OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny_invalid : "((invalid::\<cdot>OclAny) .oclAsType(Person)) = invalid"
by(rule ext, simp add: OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny bot_option_def invalid_def)
lemma OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy_invalid : "((invalid::\<cdot>Galaxy) .oclAsType(Person)) = invalid"
by(rule ext, simp add: OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy bot_option_def invalid_def)
lemma OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet_invalid : "((invalid::\<cdot>Planet) .oclAsType(Person)) = invalid"
by(rule ext, simp add: OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet bot_option_def invalid_def)
lemma OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person_invalid : "((invalid::\<cdot>Person) .oclAsType(Person)) = invalid"
by(simp)
lemma OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny_null : "((null::\<cdot>OclAny) .oclAsType(Person)) = null"
by(rule ext, simp add: OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny bot_option_def null_fun_def null_option_def)
lemma OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy_null : "((null::\<cdot>Galaxy) .oclAsType(Person)) = null"
by(rule ext, simp add: OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy bot_option_def null_fun_def null_option_def)
lemma OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet_null : "((null::\<cdot>Planet) .oclAsType(Person)) = null"
by(rule ext, simp add: OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet bot_option_def null_fun_def null_option_def)
lemma OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person_null : "((null::\<cdot>Person) .oclAsType(Person)) = null"
by(simp)

(* 43 ************************************ 179 + 1 *)
lemmas[simp,code_unfold] = OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny_invalid
                            OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy_invalid
                            OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet_invalid
                            OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person_invalid
                            OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny_null
                            OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy_null
                            OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet_null
                            OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person_null
                            OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny_invalid
                            OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy_invalid
                            OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet_invalid
                            OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person_invalid
                            OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny_null
                            OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy_null
                            OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet_null
                            OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person_null
                            OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny_invalid
                            OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy_invalid
                            OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet_invalid
                            OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person_invalid
                            OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny_null
                            OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy_null
                            OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet_null
                            OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person_null
                            OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny_invalid
                            OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy_invalid
                            OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet_invalid
                            OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person_invalid
                            OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny_null
                            OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy_null
                            OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet_null
                            OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person_null

(* 44 ************************************ 180 + 1 *)
subsection{* Validity and Definedness Properties *}

(* 45 ************************************ 181 + 6 *)
lemma OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person_defined : 
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Person) .oclAsType(Planet)))"
  using isdef
by(auto simp: OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person foundation16 null_option_def bot_option_def) 
lemma OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person_defined : 
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Person) .oclAsType(Galaxy)))"
  using isdef
by(auto simp: OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person foundation16 null_option_def bot_option_def) 
lemma OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet_defined : 
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Planet) .oclAsType(Galaxy)))"
  using isdef
by(auto simp: OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet foundation16 null_option_def bot_option_def) 
lemma OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person_defined : 
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Person) .oclAsType(OclAny)))"
  using isdef
by(auto simp: OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person foundation16 null_option_def bot_option_def) 
lemma OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet_defined : 
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Planet) .oclAsType(OclAny)))"
  using isdef
by(auto simp: OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet foundation16 null_option_def bot_option_def) 
lemma OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy_defined : 
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Galaxy) .oclAsType(OclAny)))"
  using isdef
by(auto simp: OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy foundation16 null_option_def bot_option_def) 

(* 46 ************************************ 187 + 1 *)
subsection{* Up Down Casting *}

(* 47 ************************************ 188 + 6 *)
lemma up\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_down\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_cast0 : 
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> (((X::\<cdot>Person) .oclAsType(Planet)) .oclAsType(Person)) \<triangleq> X"
  using isdef
by(auto simp: OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet foundation22 foundation16 null_option_def bot_option_def split: ty\<E>\<X>\<T>\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n.split ty\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n.split) 
lemma up\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_down\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_cast0 : 
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> (((X::\<cdot>Person) .oclAsType(Galaxy)) .oclAsType(Person)) \<triangleq> X"
  using isdef
by(auto simp: OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy foundation22 foundation16 null_option_def bot_option_def split: ty\<E>\<X>\<T>\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n.split ty\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n.split) 
lemma up\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_down\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_cast0 : 
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> (((X::\<cdot>Person) .oclAsType(OclAny)) .oclAsType(Person)) \<triangleq> X"
  using isdef
by(auto simp: OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny foundation22 foundation16 null_option_def bot_option_def split: ty\<E>\<X>\<T>\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n.split ty\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n.split) 
lemma up\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_down\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_cast0 : 
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> (((X::\<cdot>Planet) .oclAsType(Galaxy)) .oclAsType(Planet)) \<triangleq> X"
  using isdef
by(auto simp: OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy foundation22 foundation16 null_option_def bot_option_def split: ty\<E>\<X>\<T>\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t.split ty\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t.split) 
lemma up\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_down\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_cast0 : 
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> (((X::\<cdot>Planet) .oclAsType(OclAny)) .oclAsType(Planet)) \<triangleq> X"
  using isdef
by(auto simp: OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny foundation22 foundation16 null_option_def bot_option_def split: ty\<E>\<X>\<T>\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t.split ty\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t.split) 
lemma up\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_down\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_cast0 : 
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> (((X::\<cdot>Galaxy) .oclAsType(OclAny)) .oclAsType(Galaxy)) \<triangleq> X"
  using isdef
by(auto simp: OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny foundation22 foundation16 null_option_def bot_option_def split: ty\<E>\<X>\<T>\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y.split ty\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y.split) 

(* 48 ************************************ 194 + 6 *)
lemma up\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_down\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_cast : 
shows "(((X::\<cdot>Person) .oclAsType(Planet)) .oclAsType(Person)) = X"
  apply(rule ext, rename_tac \<tau>)
  apply(rule foundation22[THEN iffD1])
  apply(case_tac "\<tau> \<Turnstile> (\<delta> (X))", simp add: up\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_down\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_cast0)
  apply(simp add: defined_split, elim disjE)
  apply((erule StrongEq_L_subst2_rev, simp, simp)+)
done 
lemma up\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_down\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_cast : 
shows "(((X::\<cdot>Person) .oclAsType(Galaxy)) .oclAsType(Person)) = X"
  apply(rule ext, rename_tac \<tau>)
  apply(rule foundation22[THEN iffD1])
  apply(case_tac "\<tau> \<Turnstile> (\<delta> (X))", simp add: up\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_down\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_cast0)
  apply(simp add: defined_split, elim disjE)
  apply((erule StrongEq_L_subst2_rev, simp, simp)+)
done 
lemma up\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_down\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_cast : 
shows "(((X::\<cdot>Person) .oclAsType(OclAny)) .oclAsType(Person)) = X"
  apply(rule ext, rename_tac \<tau>)
  apply(rule foundation22[THEN iffD1])
  apply(case_tac "\<tau> \<Turnstile> (\<delta> (X))", simp add: up\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_down\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_cast0)
  apply(simp add: defined_split, elim disjE)
  apply((erule StrongEq_L_subst2_rev, simp, simp)+)
done 
lemma up\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_down\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_cast : 
shows "(((X::\<cdot>Planet) .oclAsType(Galaxy)) .oclAsType(Planet)) = X"
  apply(rule ext, rename_tac \<tau>)
  apply(rule foundation22[THEN iffD1])
  apply(case_tac "\<tau> \<Turnstile> (\<delta> (X))", simp add: up\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_down\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_cast0)
  apply(simp add: defined_split, elim disjE)
  apply((erule StrongEq_L_subst2_rev, simp, simp)+)
done 
lemma up\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_down\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_cast : 
shows "(((X::\<cdot>Planet) .oclAsType(OclAny)) .oclAsType(Planet)) = X"
  apply(rule ext, rename_tac \<tau>)
  apply(rule foundation22[THEN iffD1])
  apply(case_tac "\<tau> \<Turnstile> (\<delta> (X))", simp add: up\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_down\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_cast0)
  apply(simp add: defined_split, elim disjE)
  apply((erule StrongEq_L_subst2_rev, simp, simp)+)
done 
lemma up\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_down\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_cast : 
shows "(((X::\<cdot>Galaxy) .oclAsType(OclAny)) .oclAsType(Galaxy)) = X"
  apply(rule ext, rename_tac \<tau>)
  apply(rule foundation22[THEN iffD1])
  apply(case_tac "\<tau> \<Turnstile> (\<delta> (X))", simp add: up\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_down\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_cast0)
  apply(simp add: defined_split, elim disjE)
  apply((erule StrongEq_L_subst2_rev, simp, simp)+)
done 

(* 49 ************************************ 200 + 6 *)
lemma down\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_up\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_cast : 
assumes def_X: "X = ((Y::\<cdot>Person) .oclAsType(Planet))"
shows "(\<tau> \<Turnstile> ((not ((\<upsilon> (X)))) or ((X .oclAsType(Person)) .oclAsType(Planet)) \<doteq> X))"
  apply(case_tac "(\<tau> \<Turnstile> ((not ((\<upsilon> (X))))))", rule foundation25, simp)
by(rule foundation25', simp add: def_X up\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_down\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_cast StrictRefEq\<^sub>O\<^sub>b\<^sub>j\<^sub>e\<^sub>c\<^sub>t_sym) 
lemma down\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_up\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_cast : 
assumes def_X: "X = ((Y::\<cdot>Person) .oclAsType(Galaxy))"
shows "(\<tau> \<Turnstile> ((not ((\<upsilon> (X)))) or ((X .oclAsType(Person)) .oclAsType(Galaxy)) \<doteq> X))"
  apply(case_tac "(\<tau> \<Turnstile> ((not ((\<upsilon> (X))))))", rule foundation25, simp)
by(rule foundation25', simp add: def_X up\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_down\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_cast StrictRefEq\<^sub>O\<^sub>b\<^sub>j\<^sub>e\<^sub>c\<^sub>t_sym) 
lemma down\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_up\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_cast : 
assumes def_X: "X = ((Y::\<cdot>Person) .oclAsType(OclAny))"
shows "(\<tau> \<Turnstile> ((not ((\<upsilon> (X)))) or ((X .oclAsType(Person)) .oclAsType(OclAny)) \<doteq> X))"
  apply(case_tac "(\<tau> \<Turnstile> ((not ((\<upsilon> (X))))))", rule foundation25, simp)
by(rule foundation25', simp add: def_X up\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_down\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_cast StrictRefEq\<^sub>O\<^sub>b\<^sub>j\<^sub>e\<^sub>c\<^sub>t_sym) 
lemma down\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_up\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_cast : 
assumes def_X: "X = ((Y::\<cdot>Planet) .oclAsType(Galaxy))"
shows "(\<tau> \<Turnstile> ((not ((\<upsilon> (X)))) or ((X .oclAsType(Planet)) .oclAsType(Galaxy)) \<doteq> X))"
  apply(case_tac "(\<tau> \<Turnstile> ((not ((\<upsilon> (X))))))", rule foundation25, simp)
by(rule foundation25', simp add: def_X up\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_down\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_cast StrictRefEq\<^sub>O\<^sub>b\<^sub>j\<^sub>e\<^sub>c\<^sub>t_sym) 
lemma down\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_up\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_cast : 
assumes def_X: "X = ((Y::\<cdot>Planet) .oclAsType(OclAny))"
shows "(\<tau> \<Turnstile> ((not ((\<upsilon> (X)))) or ((X .oclAsType(Planet)) .oclAsType(OclAny)) \<doteq> X))"
  apply(case_tac "(\<tau> \<Turnstile> ((not ((\<upsilon> (X))))))", rule foundation25, simp)
by(rule foundation25', simp add: def_X up\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_down\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_cast StrictRefEq\<^sub>O\<^sub>b\<^sub>j\<^sub>e\<^sub>c\<^sub>t_sym) 
lemma down\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_up\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_cast : 
assumes def_X: "X = ((Y::\<cdot>Galaxy) .oclAsType(OclAny))"
shows "(\<tau> \<Turnstile> ((not ((\<upsilon> (X)))) or ((X .oclAsType(Galaxy)) .oclAsType(OclAny)) \<doteq> X))"
  apply(case_tac "(\<tau> \<Turnstile> ((not ((\<upsilon> (X))))))", rule foundation25, simp)
by(rule foundation25', simp add: def_X up\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_down\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_cast StrictRefEq\<^sub>O\<^sub>b\<^sub>j\<^sub>e\<^sub>c\<^sub>t_sym) 

(* 50 ************************************ 206 + 1 *)
subsection{* Const *}

(* 51 ************************************ 207 + 16 *)
lemma OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny_const : "(const ((X::\<cdot>OclAny))) \<Longrightarrow> (const (X .oclAsType(OclAny)))"
by(simp add: const_def, (metis (no_types) OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny prod.collapse bot_option_def invalid_def null_fun_def null_option_def)?)
lemma OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy_const : "(const ((X::\<cdot>Galaxy))) \<Longrightarrow> (const (X .oclAsType(OclAny)))"
by(simp add: const_def, (metis (no_types) OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy prod.collapse bot_option_def invalid_def null_fun_def null_option_def)?)
lemma OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet_const : "(const ((X::\<cdot>Planet))) \<Longrightarrow> (const (X .oclAsType(OclAny)))"
by(simp add: const_def, (metis (no_types) OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet prod.collapse bot_option_def invalid_def null_fun_def null_option_def)?)
lemma OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person_const : "(const ((X::\<cdot>Person))) \<Longrightarrow> (const (X .oclAsType(OclAny)))"
by(simp add: const_def, (metis (no_types) OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person prod.collapse bot_option_def invalid_def null_fun_def null_option_def)?)
lemma OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny_const : "(const ((X::\<cdot>OclAny))) \<Longrightarrow> (const (X .oclAsType(Galaxy)))"
by(simp add: const_def, (metis (no_types) OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny prod.collapse bot_option_def invalid_def null_fun_def null_option_def)?)
lemma OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy_const : "(const ((X::\<cdot>Galaxy))) \<Longrightarrow> (const (X .oclAsType(Galaxy)))"
by(simp add: const_def, (metis (no_types) OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy prod.collapse bot_option_def invalid_def null_fun_def null_option_def)?)
lemma OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet_const : "(const ((X::\<cdot>Planet))) \<Longrightarrow> (const (X .oclAsType(Galaxy)))"
by(simp add: const_def, (metis (no_types) OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet prod.collapse bot_option_def invalid_def null_fun_def null_option_def)?)
lemma OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person_const : "(const ((X::\<cdot>Person))) \<Longrightarrow> (const (X .oclAsType(Galaxy)))"
by(simp add: const_def, (metis (no_types) OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person prod.collapse bot_option_def invalid_def null_fun_def null_option_def)?)
lemma OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny_const : "(const ((X::\<cdot>OclAny))) \<Longrightarrow> (const (X .oclAsType(Planet)))"
by(simp add: const_def, (metis (no_types) OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny prod.collapse bot_option_def invalid_def null_fun_def null_option_def)?)
lemma OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy_const : "(const ((X::\<cdot>Galaxy))) \<Longrightarrow> (const (X .oclAsType(Planet)))"
by(simp add: const_def, (metis (no_types) OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy prod.collapse bot_option_def invalid_def null_fun_def null_option_def)?)
lemma OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet_const : "(const ((X::\<cdot>Planet))) \<Longrightarrow> (const (X .oclAsType(Planet)))"
by(simp add: const_def, (metis (no_types) OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet prod.collapse bot_option_def invalid_def null_fun_def null_option_def)?)
lemma OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person_const : "(const ((X::\<cdot>Person))) \<Longrightarrow> (const (X .oclAsType(Planet)))"
by(simp add: const_def, (metis (no_types) OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person prod.collapse bot_option_def invalid_def null_fun_def null_option_def)?)
lemma OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny_const : "(const ((X::\<cdot>OclAny))) \<Longrightarrow> (const (X .oclAsType(Person)))"
by(simp add: const_def, (metis (no_types) OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny prod.collapse bot_option_def invalid_def null_fun_def null_option_def)?)
lemma OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy_const : "(const ((X::\<cdot>Galaxy))) \<Longrightarrow> (const (X .oclAsType(Person)))"
by(simp add: const_def, (metis (no_types) OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy prod.collapse bot_option_def invalid_def null_fun_def null_option_def)?)
lemma OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet_const : "(const ((X::\<cdot>Planet))) \<Longrightarrow> (const (X .oclAsType(Person)))"
by(simp add: const_def, (metis (no_types) OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet prod.collapse bot_option_def invalid_def null_fun_def null_option_def)?)
lemma OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person_const : "(const ((X::\<cdot>Person))) \<Longrightarrow> (const (X .oclAsType(Person)))"
by(simp add: const_def, (metis (no_types) OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person prod.collapse bot_option_def invalid_def null_fun_def null_option_def)?)

(* 52 ************************************ 223 + 1 *)
lemmas[simp,code_unfold] = OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny_const
                            OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy_const
                            OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet_const
                            OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person_const
                            OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny_const
                            OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy_const
                            OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet_const
                            OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person_const
                            OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny_const
                            OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy_const
                            OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet_const
                            OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person_const
                            OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny_const
                            OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy_const
                            OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet_const
                            OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person_const

(* 53 ************************************ 224 + 1 *)
section{* OclIsTypeOf *}

(* 54 ************************************ 225 + 1 *)
subsection{* Definition *}

(* 55 ************************************ 226 + 4 *)
consts OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n :: "'\<alpha> \<Rightarrow> Boolean" ("(_) .oclIsTypeOf'(Person')")
consts OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t :: "'\<alpha> \<Rightarrow> Boolean" ("(_) .oclIsTypeOf'(Planet')")
consts OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y :: "'\<alpha> \<Rightarrow> Boolean" ("(_) .oclIsTypeOf'(Galaxy')")
consts OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y :: "'\<alpha> \<Rightarrow> Boolean" ("(_) .oclIsTypeOf'(OclAny')")

(* 56 ************************************ 230 + 16 *)
defs(overloaded) OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person : "(x::\<cdot>Person) .oclIsTypeOf(Person) \<equiv> (\<lambda>\<tau>. (case (x (\<tau>)) of \<bottom> \<Rightarrow> (invalid (\<tau>))
    | \<lfloor>\<bottom>\<rfloor> \<Rightarrow> (true (\<tau>))
    | \<lfloor>\<lfloor>(mk\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n ((mk\<E>\<X>\<T>\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (_) (_) (_) (_) (_) (_))) (_))\<rfloor>\<rfloor> \<Rightarrow> (true (\<tau>))))"
defs(overloaded) OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet : "(x::\<cdot>Planet) .oclIsTypeOf(Person) \<equiv> (\<lambda>\<tau>. (case (x (\<tau>)) of \<bottom> \<Rightarrow> (invalid (\<tau>))
    | \<lfloor>\<bottom>\<rfloor> \<Rightarrow> (true (\<tau>))
    | \<lfloor>\<lfloor>(mk\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t ((mk\<E>\<X>\<T>\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (_))) (_) (_))\<rfloor>\<rfloor> \<Rightarrow> (true (\<tau>))
    | _ \<Rightarrow> (false (\<tau>))))"
defs(overloaded) OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy : "(x::\<cdot>Galaxy) .oclIsTypeOf(Person) \<equiv> (\<lambda>\<tau>. (case (x (\<tau>)) of \<bottom> \<Rightarrow> (invalid (\<tau>))
    | \<lfloor>\<bottom>\<rfloor> \<Rightarrow> (true (\<tau>))
    | \<lfloor>\<lfloor>(mk\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y ((mk\<E>\<X>\<T>\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (_))) (_) (_) (_))\<rfloor>\<rfloor> \<Rightarrow> (true (\<tau>))
    | _ \<Rightarrow> (false (\<tau>))))"
defs(overloaded) OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny : "(x::\<cdot>OclAny) .oclIsTypeOf(Person) \<equiv> (\<lambda>\<tau>. (case (x (\<tau>)) of \<bottom> \<Rightarrow> (invalid (\<tau>))
    | \<lfloor>\<bottom>\<rfloor> \<Rightarrow> (true (\<tau>))
    | \<lfloor>\<lfloor>(mk\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y ((mk\<E>\<X>\<T>\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (_))))\<rfloor>\<rfloor> \<Rightarrow> (true (\<tau>))
    | _ \<Rightarrow> (false (\<tau>))))"
defs(overloaded) OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet : "(x::\<cdot>Planet) .oclIsTypeOf(Planet) \<equiv> (\<lambda>\<tau>. (case (x (\<tau>)) of \<bottom> \<Rightarrow> (invalid (\<tau>))
    | \<lfloor>\<bottom>\<rfloor> \<Rightarrow> (true (\<tau>))
    | \<lfloor>\<lfloor>(mk\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t ((mk\<E>\<X>\<T>\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t (_) (_) (_) (_))) (_) (_))\<rfloor>\<rfloor> \<Rightarrow> (true (\<tau>))
    | _ \<Rightarrow> (false (\<tau>))))"
defs(overloaded) OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy : "(x::\<cdot>Galaxy) .oclIsTypeOf(Planet) \<equiv> (\<lambda>\<tau>. (case (x (\<tau>)) of \<bottom> \<Rightarrow> (invalid (\<tau>))
    | \<lfloor>\<bottom>\<rfloor> \<Rightarrow> (true (\<tau>))
    | \<lfloor>\<lfloor>(mk\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y ((mk\<E>\<X>\<T>\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t (_))) (_) (_) (_))\<rfloor>\<rfloor> \<Rightarrow> (true (\<tau>))
    | _ \<Rightarrow> (false (\<tau>))))"
defs(overloaded) OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny : "(x::\<cdot>OclAny) .oclIsTypeOf(Planet) \<equiv> (\<lambda>\<tau>. (case (x (\<tau>)) of \<bottom> \<Rightarrow> (invalid (\<tau>))
    | \<lfloor>\<bottom>\<rfloor> \<Rightarrow> (true (\<tau>))
    | \<lfloor>\<lfloor>(mk\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y ((mk\<E>\<X>\<T>\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t (_))))\<rfloor>\<rfloor> \<Rightarrow> (true (\<tau>))
    | _ \<Rightarrow> (false (\<tau>))))"
defs(overloaded) OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person : "(x::\<cdot>Person) .oclIsTypeOf(Planet) \<equiv> (\<lambda>\<tau>. (case (x (\<tau>)) of \<bottom> \<Rightarrow> (invalid (\<tau>))
    | \<lfloor>\<bottom>\<rfloor> \<Rightarrow> (true (\<tau>))
    | _ \<Rightarrow> (false (\<tau>))))"
defs(overloaded) OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy : "(x::\<cdot>Galaxy) .oclIsTypeOf(Galaxy) \<equiv> (\<lambda>\<tau>. (case (x (\<tau>)) of \<bottom> \<Rightarrow> (invalid (\<tau>))
    | \<lfloor>\<bottom>\<rfloor> \<Rightarrow> (true (\<tau>))
    | \<lfloor>\<lfloor>(mk\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y ((mk\<E>\<X>\<T>\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y (_))) (_) (_) (_))\<rfloor>\<rfloor> \<Rightarrow> (true (\<tau>))
    | _ \<Rightarrow> (false (\<tau>))))"
defs(overloaded) OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny : "(x::\<cdot>OclAny) .oclIsTypeOf(Galaxy) \<equiv> (\<lambda>\<tau>. (case (x (\<tau>)) of \<bottom> \<Rightarrow> (invalid (\<tau>))
    | \<lfloor>\<bottom>\<rfloor> \<Rightarrow> (true (\<tau>))
    | \<lfloor>\<lfloor>(mk\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y ((mk\<E>\<X>\<T>\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y (_))))\<rfloor>\<rfloor> \<Rightarrow> (true (\<tau>))
    | _ \<Rightarrow> (false (\<tau>))))"
defs(overloaded) OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person : "(x::\<cdot>Person) .oclIsTypeOf(Galaxy) \<equiv> (\<lambda>\<tau>. (case (x (\<tau>)) of \<bottom> \<Rightarrow> (invalid (\<tau>))
    | \<lfloor>\<bottom>\<rfloor> \<Rightarrow> (true (\<tau>))
    | _ \<Rightarrow> (false (\<tau>))))"
defs(overloaded) OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet : "(x::\<cdot>Planet) .oclIsTypeOf(Galaxy) \<equiv> (\<lambda>\<tau>. (case (x (\<tau>)) of \<bottom> \<Rightarrow> (invalid (\<tau>))
    | \<lfloor>\<bottom>\<rfloor> \<Rightarrow> (true (\<tau>))
    | _ \<Rightarrow> (false (\<tau>))))"
defs(overloaded) OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny : "(x::\<cdot>OclAny) .oclIsTypeOf(OclAny) \<equiv> (\<lambda>\<tau>. (case (x (\<tau>)) of \<bottom> \<Rightarrow> (invalid (\<tau>))
    | \<lfloor>\<bottom>\<rfloor> \<Rightarrow> (true (\<tau>))
    | \<lfloor>\<lfloor>(mk\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y ((mk\<E>\<X>\<T>\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y (_))))\<rfloor>\<rfloor> \<Rightarrow> (true (\<tau>))
    | _ \<Rightarrow> (false (\<tau>))))"
defs(overloaded) OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person : "(x::\<cdot>Person) .oclIsTypeOf(OclAny) \<equiv> (\<lambda>\<tau>. (case (x (\<tau>)) of \<bottom> \<Rightarrow> (invalid (\<tau>))
    | \<lfloor>\<bottom>\<rfloor> \<Rightarrow> (true (\<tau>))
    | _ \<Rightarrow> (false (\<tau>))))"
defs(overloaded) OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet : "(x::\<cdot>Planet) .oclIsTypeOf(OclAny) \<equiv> (\<lambda>\<tau>. (case (x (\<tau>)) of \<bottom> \<Rightarrow> (invalid (\<tau>))
    | \<lfloor>\<bottom>\<rfloor> \<Rightarrow> (true (\<tau>))
    | _ \<Rightarrow> (false (\<tau>))))"
defs(overloaded) OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy : "(x::\<cdot>Galaxy) .oclIsTypeOf(OclAny) \<equiv> (\<lambda>\<tau>. (case (x (\<tau>)) of \<bottom> \<Rightarrow> (invalid (\<tau>))
    | \<lfloor>\<bottom>\<rfloor> \<Rightarrow> (true (\<tau>))
    | _ \<Rightarrow> (false (\<tau>))))"

(* 57 ************************************ 246 + 4 *)
definition "OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_\<AA> = (\<lambda> (in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (Person)) \<Rightarrow> (((((\<lambda>x _. \<lfloor>\<lfloor>x\<rfloor>\<rfloor>)) (Person))::\<cdot>Person) .oclIsTypeOf(Person))
    | (in\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t (Planet)) \<Rightarrow> (((((\<lambda>x _. \<lfloor>\<lfloor>x\<rfloor>\<rfloor>)) (Planet))::\<cdot>Planet) .oclIsTypeOf(Person))
    | (in\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y (Galaxy)) \<Rightarrow> (((((\<lambda>x _. \<lfloor>\<lfloor>x\<rfloor>\<rfloor>)) (Galaxy))::\<cdot>Galaxy) .oclIsTypeOf(Person))
    | (in\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y (OclAny)) \<Rightarrow> (((((\<lambda>x _. \<lfloor>\<lfloor>x\<rfloor>\<rfloor>)) (OclAny))::\<cdot>OclAny) .oclIsTypeOf(Person)))"
definition "OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_\<AA> = (\<lambda> (in\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t (Planet)) \<Rightarrow> (((((\<lambda>x _. \<lfloor>\<lfloor>x\<rfloor>\<rfloor>)) (Planet))::\<cdot>Planet) .oclIsTypeOf(Planet))
    | (in\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y (Galaxy)) \<Rightarrow> (((((\<lambda>x _. \<lfloor>\<lfloor>x\<rfloor>\<rfloor>)) (Galaxy))::\<cdot>Galaxy) .oclIsTypeOf(Planet))
    | (in\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y (OclAny)) \<Rightarrow> (((((\<lambda>x _. \<lfloor>\<lfloor>x\<rfloor>\<rfloor>)) (OclAny))::\<cdot>OclAny) .oclIsTypeOf(Planet))
    | (in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (Person)) \<Rightarrow> (((((\<lambda>x _. \<lfloor>\<lfloor>x\<rfloor>\<rfloor>)) (Person))::\<cdot>Person) .oclIsTypeOf(Planet)))"
definition "OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_\<AA> = (\<lambda> (in\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y (Galaxy)) \<Rightarrow> (((((\<lambda>x _. \<lfloor>\<lfloor>x\<rfloor>\<rfloor>)) (Galaxy))::\<cdot>Galaxy) .oclIsTypeOf(Galaxy))
    | (in\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y (OclAny)) \<Rightarrow> (((((\<lambda>x _. \<lfloor>\<lfloor>x\<rfloor>\<rfloor>)) (OclAny))::\<cdot>OclAny) .oclIsTypeOf(Galaxy))
    | (in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (Person)) \<Rightarrow> (((((\<lambda>x _. \<lfloor>\<lfloor>x\<rfloor>\<rfloor>)) (Person))::\<cdot>Person) .oclIsTypeOf(Galaxy))
    | (in\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t (Planet)) \<Rightarrow> (((((\<lambda>x _. \<lfloor>\<lfloor>x\<rfloor>\<rfloor>)) (Planet))::\<cdot>Planet) .oclIsTypeOf(Galaxy)))"
definition "OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_\<AA> = (\<lambda> (in\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y (OclAny)) \<Rightarrow> (((((\<lambda>x _. \<lfloor>\<lfloor>x\<rfloor>\<rfloor>)) (OclAny))::\<cdot>OclAny) .oclIsTypeOf(OclAny))
    | (in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (Person)) \<Rightarrow> (((((\<lambda>x _. \<lfloor>\<lfloor>x\<rfloor>\<rfloor>)) (Person))::\<cdot>Person) .oclIsTypeOf(OclAny))
    | (in\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t (Planet)) \<Rightarrow> (((((\<lambda>x _. \<lfloor>\<lfloor>x\<rfloor>\<rfloor>)) (Planet))::\<cdot>Planet) .oclIsTypeOf(OclAny))
    | (in\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y (Galaxy)) \<Rightarrow> (((((\<lambda>x _. \<lfloor>\<lfloor>x\<rfloor>\<rfloor>)) (Galaxy))::\<cdot>Galaxy) .oclIsTypeOf(OclAny)))"

(* 58 ************************************ 250 + 1 *)
lemmas[simp,code_unfold] = OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person
                            OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet
                            OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy
                            OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny

(* 59 ************************************ 251 + 1 *)
subsection{* Context Passing *}

(* 60 ************************************ 252 + 64 *)
lemma cp_OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny_OclAny : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>OclAny)))::\<cdot>OclAny) .oclIsTypeOf(OclAny)))))"
by(rule cpI1, simp)
lemma cp_OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy_OclAny : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Galaxy)))::\<cdot>OclAny) .oclIsTypeOf(OclAny)))))"
by(rule cpI1, simp)
lemma cp_OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet_OclAny : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Planet)))::\<cdot>OclAny) .oclIsTypeOf(OclAny)))))"
by(rule cpI1, simp)
lemma cp_OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person_OclAny : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Person)))::\<cdot>OclAny) .oclIsTypeOf(OclAny)))))"
by(rule cpI1, simp)
lemma cp_OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny_Galaxy : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>OclAny)))::\<cdot>Galaxy) .oclIsTypeOf(OclAny)))))"
by(rule cpI1, simp add: OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy)
lemma cp_OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy_Galaxy : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Galaxy)))::\<cdot>Galaxy) .oclIsTypeOf(OclAny)))))"
by(rule cpI1, simp add: OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy)
lemma cp_OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet_Galaxy : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Planet)))::\<cdot>Galaxy) .oclIsTypeOf(OclAny)))))"
by(rule cpI1, simp add: OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy)
lemma cp_OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person_Galaxy : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Person)))::\<cdot>Galaxy) .oclIsTypeOf(OclAny)))))"
by(rule cpI1, simp add: OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy)
lemma cp_OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny_Planet : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>OclAny)))::\<cdot>Planet) .oclIsTypeOf(OclAny)))))"
by(rule cpI1, simp add: OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet)
lemma cp_OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy_Planet : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Galaxy)))::\<cdot>Planet) .oclIsTypeOf(OclAny)))))"
by(rule cpI1, simp add: OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet)
lemma cp_OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet_Planet : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Planet)))::\<cdot>Planet) .oclIsTypeOf(OclAny)))))"
by(rule cpI1, simp add: OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet)
lemma cp_OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person_Planet : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Person)))::\<cdot>Planet) .oclIsTypeOf(OclAny)))))"
by(rule cpI1, simp add: OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet)
lemma cp_OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny_Person : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>OclAny)))::\<cdot>Person) .oclIsTypeOf(OclAny)))))"
by(rule cpI1, simp add: OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person)
lemma cp_OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy_Person : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Galaxy)))::\<cdot>Person) .oclIsTypeOf(OclAny)))))"
by(rule cpI1, simp add: OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person)
lemma cp_OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet_Person : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Planet)))::\<cdot>Person) .oclIsTypeOf(OclAny)))))"
by(rule cpI1, simp add: OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person)
lemma cp_OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person_Person : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Person)))::\<cdot>Person) .oclIsTypeOf(OclAny)))))"
by(rule cpI1, simp add: OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person)
lemma cp_OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny_OclAny : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>OclAny)))::\<cdot>OclAny) .oclIsTypeOf(Galaxy)))))"
by(rule cpI1, simp add: OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny)
lemma cp_OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy_OclAny : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Galaxy)))::\<cdot>OclAny) .oclIsTypeOf(Galaxy)))))"
by(rule cpI1, simp add: OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny)
lemma cp_OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet_OclAny : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Planet)))::\<cdot>OclAny) .oclIsTypeOf(Galaxy)))))"
by(rule cpI1, simp add: OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny)
lemma cp_OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person_OclAny : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Person)))::\<cdot>OclAny) .oclIsTypeOf(Galaxy)))))"
by(rule cpI1, simp add: OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny)
lemma cp_OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny_Galaxy : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>OclAny)))::\<cdot>Galaxy) .oclIsTypeOf(Galaxy)))))"
by(rule cpI1, simp)
lemma cp_OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy_Galaxy : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Galaxy)))::\<cdot>Galaxy) .oclIsTypeOf(Galaxy)))))"
by(rule cpI1, simp)
lemma cp_OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet_Galaxy : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Planet)))::\<cdot>Galaxy) .oclIsTypeOf(Galaxy)))))"
by(rule cpI1, simp)
lemma cp_OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person_Galaxy : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Person)))::\<cdot>Galaxy) .oclIsTypeOf(Galaxy)))))"
by(rule cpI1, simp)
lemma cp_OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny_Planet : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>OclAny)))::\<cdot>Planet) .oclIsTypeOf(Galaxy)))))"
by(rule cpI1, simp add: OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet)
lemma cp_OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy_Planet : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Galaxy)))::\<cdot>Planet) .oclIsTypeOf(Galaxy)))))"
by(rule cpI1, simp add: OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet)
lemma cp_OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet_Planet : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Planet)))::\<cdot>Planet) .oclIsTypeOf(Galaxy)))))"
by(rule cpI1, simp add: OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet)
lemma cp_OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person_Planet : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Person)))::\<cdot>Planet) .oclIsTypeOf(Galaxy)))))"
by(rule cpI1, simp add: OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet)
lemma cp_OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny_Person : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>OclAny)))::\<cdot>Person) .oclIsTypeOf(Galaxy)))))"
by(rule cpI1, simp add: OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person)
lemma cp_OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy_Person : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Galaxy)))::\<cdot>Person) .oclIsTypeOf(Galaxy)))))"
by(rule cpI1, simp add: OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person)
lemma cp_OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet_Person : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Planet)))::\<cdot>Person) .oclIsTypeOf(Galaxy)))))"
by(rule cpI1, simp add: OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person)
lemma cp_OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person_Person : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Person)))::\<cdot>Person) .oclIsTypeOf(Galaxy)))))"
by(rule cpI1, simp add: OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person)
lemma cp_OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny_OclAny : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>OclAny)))::\<cdot>OclAny) .oclIsTypeOf(Planet)))))"
by(rule cpI1, simp add: OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny)
lemma cp_OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy_OclAny : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Galaxy)))::\<cdot>OclAny) .oclIsTypeOf(Planet)))))"
by(rule cpI1, simp add: OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny)
lemma cp_OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet_OclAny : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Planet)))::\<cdot>OclAny) .oclIsTypeOf(Planet)))))"
by(rule cpI1, simp add: OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny)
lemma cp_OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person_OclAny : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Person)))::\<cdot>OclAny) .oclIsTypeOf(Planet)))))"
by(rule cpI1, simp add: OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny)
lemma cp_OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny_Galaxy : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>OclAny)))::\<cdot>Galaxy) .oclIsTypeOf(Planet)))))"
by(rule cpI1, simp add: OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy)
lemma cp_OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy_Galaxy : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Galaxy)))::\<cdot>Galaxy) .oclIsTypeOf(Planet)))))"
by(rule cpI1, simp add: OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy)
lemma cp_OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet_Galaxy : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Planet)))::\<cdot>Galaxy) .oclIsTypeOf(Planet)))))"
by(rule cpI1, simp add: OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy)
lemma cp_OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person_Galaxy : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Person)))::\<cdot>Galaxy) .oclIsTypeOf(Planet)))))"
by(rule cpI1, simp add: OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy)
lemma cp_OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny_Planet : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>OclAny)))::\<cdot>Planet) .oclIsTypeOf(Planet)))))"
by(rule cpI1, simp)
lemma cp_OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy_Planet : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Galaxy)))::\<cdot>Planet) .oclIsTypeOf(Planet)))))"
by(rule cpI1, simp)
lemma cp_OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet_Planet : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Planet)))::\<cdot>Planet) .oclIsTypeOf(Planet)))))"
by(rule cpI1, simp)
lemma cp_OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person_Planet : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Person)))::\<cdot>Planet) .oclIsTypeOf(Planet)))))"
by(rule cpI1, simp)
lemma cp_OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny_Person : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>OclAny)))::\<cdot>Person) .oclIsTypeOf(Planet)))))"
by(rule cpI1, simp add: OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person)
lemma cp_OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy_Person : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Galaxy)))::\<cdot>Person) .oclIsTypeOf(Planet)))))"
by(rule cpI1, simp add: OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person)
lemma cp_OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet_Person : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Planet)))::\<cdot>Person) .oclIsTypeOf(Planet)))))"
by(rule cpI1, simp add: OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person)
lemma cp_OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person_Person : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Person)))::\<cdot>Person) .oclIsTypeOf(Planet)))))"
by(rule cpI1, simp add: OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person)
lemma cp_OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny_OclAny : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>OclAny)))::\<cdot>OclAny) .oclIsTypeOf(Person)))))"
by(rule cpI1, simp add: OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny)
lemma cp_OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy_OclAny : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Galaxy)))::\<cdot>OclAny) .oclIsTypeOf(Person)))))"
by(rule cpI1, simp add: OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny)
lemma cp_OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet_OclAny : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Planet)))::\<cdot>OclAny) .oclIsTypeOf(Person)))))"
by(rule cpI1, simp add: OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny)
lemma cp_OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person_OclAny : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Person)))::\<cdot>OclAny) .oclIsTypeOf(Person)))))"
by(rule cpI1, simp add: OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny)
lemma cp_OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny_Galaxy : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>OclAny)))::\<cdot>Galaxy) .oclIsTypeOf(Person)))))"
by(rule cpI1, simp add: OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy)
lemma cp_OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy_Galaxy : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Galaxy)))::\<cdot>Galaxy) .oclIsTypeOf(Person)))))"
by(rule cpI1, simp add: OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy)
lemma cp_OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet_Galaxy : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Planet)))::\<cdot>Galaxy) .oclIsTypeOf(Person)))))"
by(rule cpI1, simp add: OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy)
lemma cp_OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person_Galaxy : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Person)))::\<cdot>Galaxy) .oclIsTypeOf(Person)))))"
by(rule cpI1, simp add: OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy)
lemma cp_OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny_Planet : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>OclAny)))::\<cdot>Planet) .oclIsTypeOf(Person)))))"
by(rule cpI1, simp add: OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet)
lemma cp_OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy_Planet : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Galaxy)))::\<cdot>Planet) .oclIsTypeOf(Person)))))"
by(rule cpI1, simp add: OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet)
lemma cp_OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet_Planet : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Planet)))::\<cdot>Planet) .oclIsTypeOf(Person)))))"
by(rule cpI1, simp add: OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet)
lemma cp_OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person_Planet : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Person)))::\<cdot>Planet) .oclIsTypeOf(Person)))))"
by(rule cpI1, simp add: OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet)
lemma cp_OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny_Person : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>OclAny)))::\<cdot>Person) .oclIsTypeOf(Person)))))"
by(rule cpI1, simp)
lemma cp_OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy_Person : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Galaxy)))::\<cdot>Person) .oclIsTypeOf(Person)))))"
by(rule cpI1, simp)
lemma cp_OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet_Person : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Planet)))::\<cdot>Person) .oclIsTypeOf(Person)))))"
by(rule cpI1, simp)
lemma cp_OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person_Person : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Person)))::\<cdot>Person) .oclIsTypeOf(Person)))))"
by(rule cpI1, simp)

(* 61 ************************************ 316 + 1 *)
lemmas[simp,code_unfold] = cp_OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny_OclAny
                            cp_OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy_OclAny
                            cp_OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet_OclAny
                            cp_OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person_OclAny
                            cp_OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny_Galaxy
                            cp_OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy_Galaxy
                            cp_OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet_Galaxy
                            cp_OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person_Galaxy
                            cp_OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny_Planet
                            cp_OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy_Planet
                            cp_OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet_Planet
                            cp_OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person_Planet
                            cp_OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny_Person
                            cp_OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy_Person
                            cp_OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet_Person
                            cp_OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person_Person
                            cp_OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny_OclAny
                            cp_OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy_OclAny
                            cp_OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet_OclAny
                            cp_OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person_OclAny
                            cp_OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny_Galaxy
                            cp_OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy_Galaxy
                            cp_OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet_Galaxy
                            cp_OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person_Galaxy
                            cp_OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny_Planet
                            cp_OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy_Planet
                            cp_OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet_Planet
                            cp_OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person_Planet
                            cp_OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny_Person
                            cp_OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy_Person
                            cp_OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet_Person
                            cp_OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person_Person
                            cp_OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny_OclAny
                            cp_OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy_OclAny
                            cp_OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet_OclAny
                            cp_OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person_OclAny
                            cp_OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny_Galaxy
                            cp_OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy_Galaxy
                            cp_OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet_Galaxy
                            cp_OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person_Galaxy
                            cp_OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny_Planet
                            cp_OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy_Planet
                            cp_OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet_Planet
                            cp_OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person_Planet
                            cp_OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny_Person
                            cp_OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy_Person
                            cp_OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet_Person
                            cp_OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person_Person
                            cp_OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny_OclAny
                            cp_OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy_OclAny
                            cp_OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet_OclAny
                            cp_OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person_OclAny
                            cp_OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny_Galaxy
                            cp_OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy_Galaxy
                            cp_OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet_Galaxy
                            cp_OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person_Galaxy
                            cp_OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny_Planet
                            cp_OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy_Planet
                            cp_OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet_Planet
                            cp_OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person_Planet
                            cp_OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny_Person
                            cp_OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy_Person
                            cp_OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet_Person
                            cp_OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person_Person

(* 62 ************************************ 317 + 1 *)
subsection{* Execution with Invalid or Null as Argument *}

(* 63 ************************************ 318 + 32 *)
lemma OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny_invalid : "((invalid::\<cdot>OclAny) .oclIsTypeOf(OclAny)) = invalid"
by(rule ext, simp add: bot_option_def invalid_def)
lemma OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy_invalid : "((invalid::\<cdot>Galaxy) .oclIsTypeOf(OclAny)) = invalid"
by(rule ext, simp add: OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy bot_option_def invalid_def)
lemma OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet_invalid : "((invalid::\<cdot>Planet) .oclIsTypeOf(OclAny)) = invalid"
by(rule ext, simp add: OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet bot_option_def invalid_def)
lemma OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person_invalid : "((invalid::\<cdot>Person) .oclIsTypeOf(OclAny)) = invalid"
by(rule ext, simp add: OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person bot_option_def invalid_def)
lemma OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny_null : "((null::\<cdot>OclAny) .oclIsTypeOf(OclAny)) = true"
by(rule ext, simp add: bot_option_def null_fun_def null_option_def)
lemma OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy_null : "((null::\<cdot>Galaxy) .oclIsTypeOf(OclAny)) = true"
by(rule ext, simp add: OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy bot_option_def null_fun_def null_option_def)
lemma OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet_null : "((null::\<cdot>Planet) .oclIsTypeOf(OclAny)) = true"
by(rule ext, simp add: OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet bot_option_def null_fun_def null_option_def)
lemma OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person_null : "((null::\<cdot>Person) .oclIsTypeOf(OclAny)) = true"
by(rule ext, simp add: OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person bot_option_def null_fun_def null_option_def)
lemma OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny_invalid : "((invalid::\<cdot>OclAny) .oclIsTypeOf(Galaxy)) = invalid"
by(rule ext, simp add: OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny bot_option_def invalid_def)
lemma OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy_invalid : "((invalid::\<cdot>Galaxy) .oclIsTypeOf(Galaxy)) = invalid"
by(rule ext, simp add: bot_option_def invalid_def)
lemma OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet_invalid : "((invalid::\<cdot>Planet) .oclIsTypeOf(Galaxy)) = invalid"
by(rule ext, simp add: OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet bot_option_def invalid_def)
lemma OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person_invalid : "((invalid::\<cdot>Person) .oclIsTypeOf(Galaxy)) = invalid"
by(rule ext, simp add: OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person bot_option_def invalid_def)
lemma OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny_null : "((null::\<cdot>OclAny) .oclIsTypeOf(Galaxy)) = true"
by(rule ext, simp add: OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny bot_option_def null_fun_def null_option_def)
lemma OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy_null : "((null::\<cdot>Galaxy) .oclIsTypeOf(Galaxy)) = true"
by(rule ext, simp add: bot_option_def null_fun_def null_option_def)
lemma OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet_null : "((null::\<cdot>Planet) .oclIsTypeOf(Galaxy)) = true"
by(rule ext, simp add: OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet bot_option_def null_fun_def null_option_def)
lemma OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person_null : "((null::\<cdot>Person) .oclIsTypeOf(Galaxy)) = true"
by(rule ext, simp add: OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person bot_option_def null_fun_def null_option_def)
lemma OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny_invalid : "((invalid::\<cdot>OclAny) .oclIsTypeOf(Planet)) = invalid"
by(rule ext, simp add: OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny bot_option_def invalid_def)
lemma OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy_invalid : "((invalid::\<cdot>Galaxy) .oclIsTypeOf(Planet)) = invalid"
by(rule ext, simp add: OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy bot_option_def invalid_def)
lemma OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet_invalid : "((invalid::\<cdot>Planet) .oclIsTypeOf(Planet)) = invalid"
by(rule ext, simp add: bot_option_def invalid_def)
lemma OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person_invalid : "((invalid::\<cdot>Person) .oclIsTypeOf(Planet)) = invalid"
by(rule ext, simp add: OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person bot_option_def invalid_def)
lemma OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny_null : "((null::\<cdot>OclAny) .oclIsTypeOf(Planet)) = true"
by(rule ext, simp add: OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny bot_option_def null_fun_def null_option_def)
lemma OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy_null : "((null::\<cdot>Galaxy) .oclIsTypeOf(Planet)) = true"
by(rule ext, simp add: OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy bot_option_def null_fun_def null_option_def)
lemma OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet_null : "((null::\<cdot>Planet) .oclIsTypeOf(Planet)) = true"
by(rule ext, simp add: bot_option_def null_fun_def null_option_def)
lemma OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person_null : "((null::\<cdot>Person) .oclIsTypeOf(Planet)) = true"
by(rule ext, simp add: OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person bot_option_def null_fun_def null_option_def)
lemma OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny_invalid : "((invalid::\<cdot>OclAny) .oclIsTypeOf(Person)) = invalid"
by(rule ext, simp add: OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny bot_option_def invalid_def)
lemma OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy_invalid : "((invalid::\<cdot>Galaxy) .oclIsTypeOf(Person)) = invalid"
by(rule ext, simp add: OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy bot_option_def invalid_def)
lemma OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet_invalid : "((invalid::\<cdot>Planet) .oclIsTypeOf(Person)) = invalid"
by(rule ext, simp add: OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet bot_option_def invalid_def)
lemma OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person_invalid : "((invalid::\<cdot>Person) .oclIsTypeOf(Person)) = invalid"
by(rule ext, simp add: bot_option_def invalid_def)
lemma OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny_null : "((null::\<cdot>OclAny) .oclIsTypeOf(Person)) = true"
by(rule ext, simp add: OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny bot_option_def null_fun_def null_option_def)
lemma OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy_null : "((null::\<cdot>Galaxy) .oclIsTypeOf(Person)) = true"
by(rule ext, simp add: OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy bot_option_def null_fun_def null_option_def)
lemma OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet_null : "((null::\<cdot>Planet) .oclIsTypeOf(Person)) = true"
by(rule ext, simp add: OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet bot_option_def null_fun_def null_option_def)
lemma OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person_null : "((null::\<cdot>Person) .oclIsTypeOf(Person)) = true"
by(rule ext, simp add: bot_option_def null_fun_def null_option_def)

(* 64 ************************************ 350 + 1 *)
lemmas[simp,code_unfold] = OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny_invalid
                            OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy_invalid
                            OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet_invalid
                            OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person_invalid
                            OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny_null
                            OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy_null
                            OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet_null
                            OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person_null
                            OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny_invalid
                            OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy_invalid
                            OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet_invalid
                            OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person_invalid
                            OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny_null
                            OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy_null
                            OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet_null
                            OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person_null
                            OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny_invalid
                            OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy_invalid
                            OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet_invalid
                            OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person_invalid
                            OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny_null
                            OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy_null
                            OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet_null
                            OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person_null
                            OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny_invalid
                            OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy_invalid
                            OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet_invalid
                            OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person_invalid
                            OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny_null
                            OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy_null
                            OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet_null
                            OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person_null

(* 65 ************************************ 351 + 1 *)
subsection{* Validity and Definedness Properties *}

(* 66 ************************************ 352 + 16 *)
lemma OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person_defined : 
assumes isdef: "\<tau> \<Turnstile> (\<upsilon> (X))"
shows "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Person) .oclIsTypeOf(Person)))"
  apply(insert isdef[simplified foundation18'], simp only: OclValid_def, subst cp_defined)
by(auto simp: cp_defined[symmetric ] bot_option_def OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person split: option.split ty\<E>\<X>\<T>\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n.split ty\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n.split) 
lemma OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet_defined : 
assumes isdef: "\<tau> \<Turnstile> (\<upsilon> (X))"
shows "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Planet) .oclIsTypeOf(Person)))"
  apply(insert isdef[simplified foundation18'], simp only: OclValid_def, subst cp_defined)
by(auto simp: cp_defined[symmetric ] bot_option_def OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet split: option.split ty\<E>\<X>\<T>\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t.split ty\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t.split) 
lemma OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy_defined : 
assumes isdef: "\<tau> \<Turnstile> (\<upsilon> (X))"
shows "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Galaxy) .oclIsTypeOf(Person)))"
  apply(insert isdef[simplified foundation18'], simp only: OclValid_def, subst cp_defined)
by(auto simp: cp_defined[symmetric ] bot_option_def OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy split: option.split ty\<E>\<X>\<T>\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y.split ty\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y.split) 
lemma OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny_defined : 
assumes isdef: "\<tau> \<Turnstile> (\<upsilon> (X))"
shows "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>OclAny) .oclIsTypeOf(Person)))"
  apply(insert isdef[simplified foundation18'], simp only: OclValid_def, subst cp_defined)
by(auto simp: cp_defined[symmetric ] bot_option_def OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny split: option.split ty\<E>\<X>\<T>\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y.split ty\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y.split) 
lemma OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet_defined : 
assumes isdef: "\<tau> \<Turnstile> (\<upsilon> (X))"
shows "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Planet) .oclIsTypeOf(Planet)))"
  apply(insert isdef[simplified foundation18'], simp only: OclValid_def, subst cp_defined)
by(auto simp: cp_defined[symmetric ] bot_option_def OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet split: option.split ty\<E>\<X>\<T>\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t.split ty\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t.split) 
lemma OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy_defined : 
assumes isdef: "\<tau> \<Turnstile> (\<upsilon> (X))"
shows "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Galaxy) .oclIsTypeOf(Planet)))"
  apply(insert isdef[simplified foundation18'], simp only: OclValid_def, subst cp_defined)
by(auto simp: cp_defined[symmetric ] bot_option_def OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy split: option.split ty\<E>\<X>\<T>\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y.split ty\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y.split) 
lemma OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny_defined : 
assumes isdef: "\<tau> \<Turnstile> (\<upsilon> (X))"
shows "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>OclAny) .oclIsTypeOf(Planet)))"
  apply(insert isdef[simplified foundation18'], simp only: OclValid_def, subst cp_defined)
by(auto simp: cp_defined[symmetric ] bot_option_def OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny split: option.split ty\<E>\<X>\<T>\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y.split ty\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y.split) 
lemma OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person_defined : 
assumes isdef: "\<tau> \<Turnstile> (\<upsilon> (X))"
shows "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Person) .oclIsTypeOf(Planet)))"
  apply(insert isdef[simplified foundation18'], simp only: OclValid_def, subst cp_defined)
by(auto simp: cp_defined[symmetric ] bot_option_def OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person split: option.split ty\<E>\<X>\<T>\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n.split ty\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n.split) 
lemma OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy_defined : 
assumes isdef: "\<tau> \<Turnstile> (\<upsilon> (X))"
shows "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Galaxy) .oclIsTypeOf(Galaxy)))"
  apply(insert isdef[simplified foundation18'], simp only: OclValid_def, subst cp_defined)
by(auto simp: cp_defined[symmetric ] bot_option_def OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy split: option.split ty\<E>\<X>\<T>\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y.split ty\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y.split) 
lemma OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny_defined : 
assumes isdef: "\<tau> \<Turnstile> (\<upsilon> (X))"
shows "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>OclAny) .oclIsTypeOf(Galaxy)))"
  apply(insert isdef[simplified foundation18'], simp only: OclValid_def, subst cp_defined)
by(auto simp: cp_defined[symmetric ] bot_option_def OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny split: option.split ty\<E>\<X>\<T>\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y.split ty\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y.split) 
lemma OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person_defined : 
assumes isdef: "\<tau> \<Turnstile> (\<upsilon> (X))"
shows "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Person) .oclIsTypeOf(Galaxy)))"
  apply(insert isdef[simplified foundation18'], simp only: OclValid_def, subst cp_defined)
by(auto simp: cp_defined[symmetric ] bot_option_def OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person split: option.split ty\<E>\<X>\<T>\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n.split ty\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n.split) 
lemma OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet_defined : 
assumes isdef: "\<tau> \<Turnstile> (\<upsilon> (X))"
shows "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Planet) .oclIsTypeOf(Galaxy)))"
  apply(insert isdef[simplified foundation18'], simp only: OclValid_def, subst cp_defined)
by(auto simp: cp_defined[symmetric ] bot_option_def OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet split: option.split ty\<E>\<X>\<T>\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t.split ty\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t.split) 
lemma OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny_defined : 
assumes isdef: "\<tau> \<Turnstile> (\<upsilon> (X))"
shows "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>OclAny) .oclIsTypeOf(OclAny)))"
  apply(insert isdef[simplified foundation18'], simp only: OclValid_def, subst cp_defined)
by(auto simp: cp_defined[symmetric ] bot_option_def OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny split: option.split ty\<E>\<X>\<T>\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y.split ty\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y.split) 
lemma OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person_defined : 
assumes isdef: "\<tau> \<Turnstile> (\<upsilon> (X))"
shows "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Person) .oclIsTypeOf(OclAny)))"
  apply(insert isdef[simplified foundation18'], simp only: OclValid_def, subst cp_defined)
by(auto simp: cp_defined[symmetric ] bot_option_def OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person split: option.split ty\<E>\<X>\<T>\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n.split ty\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n.split) 
lemma OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet_defined : 
assumes isdef: "\<tau> \<Turnstile> (\<upsilon> (X))"
shows "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Planet) .oclIsTypeOf(OclAny)))"
  apply(insert isdef[simplified foundation18'], simp only: OclValid_def, subst cp_defined)
by(auto simp: cp_defined[symmetric ] bot_option_def OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet split: option.split ty\<E>\<X>\<T>\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t.split ty\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t.split) 
lemma OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy_defined : 
assumes isdef: "\<tau> \<Turnstile> (\<upsilon> (X))"
shows "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Galaxy) .oclIsTypeOf(OclAny)))"
  apply(insert isdef[simplified foundation18'], simp only: OclValid_def, subst cp_defined)
by(auto simp: cp_defined[symmetric ] bot_option_def OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy split: option.split ty\<E>\<X>\<T>\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y.split ty\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y.split) 

(* 67 ************************************ 368 + 16 *)
lemma OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person_defined' : 
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Person) .oclIsTypeOf(Person)))"
by(rule OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person_defined[OF isdef[THEN foundation20]]) 
lemma OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet_defined' : 
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Planet) .oclIsTypeOf(Person)))"
by(rule OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet_defined[OF isdef[THEN foundation20]]) 
lemma OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy_defined' : 
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Galaxy) .oclIsTypeOf(Person)))"
by(rule OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy_defined[OF isdef[THEN foundation20]]) 
lemma OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny_defined' : 
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>OclAny) .oclIsTypeOf(Person)))"
by(rule OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny_defined[OF isdef[THEN foundation20]]) 
lemma OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet_defined' : 
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Planet) .oclIsTypeOf(Planet)))"
by(rule OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet_defined[OF isdef[THEN foundation20]]) 
lemma OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy_defined' : 
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Galaxy) .oclIsTypeOf(Planet)))"
by(rule OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy_defined[OF isdef[THEN foundation20]]) 
lemma OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny_defined' : 
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>OclAny) .oclIsTypeOf(Planet)))"
by(rule OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny_defined[OF isdef[THEN foundation20]]) 
lemma OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person_defined' : 
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Person) .oclIsTypeOf(Planet)))"
by(rule OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person_defined[OF isdef[THEN foundation20]]) 
lemma OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy_defined' : 
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Galaxy) .oclIsTypeOf(Galaxy)))"
by(rule OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy_defined[OF isdef[THEN foundation20]]) 
lemma OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny_defined' : 
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>OclAny) .oclIsTypeOf(Galaxy)))"
by(rule OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny_defined[OF isdef[THEN foundation20]]) 
lemma OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person_defined' : 
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Person) .oclIsTypeOf(Galaxy)))"
by(rule OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person_defined[OF isdef[THEN foundation20]]) 
lemma OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet_defined' : 
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Planet) .oclIsTypeOf(Galaxy)))"
by(rule OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet_defined[OF isdef[THEN foundation20]]) 
lemma OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny_defined' : 
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>OclAny) .oclIsTypeOf(OclAny)))"
by(rule OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny_defined[OF isdef[THEN foundation20]]) 
lemma OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person_defined' : 
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Person) .oclIsTypeOf(OclAny)))"
by(rule OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person_defined[OF isdef[THEN foundation20]]) 
lemma OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet_defined' : 
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Planet) .oclIsTypeOf(OclAny)))"
by(rule OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet_defined[OF isdef[THEN foundation20]]) 
lemma OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy_defined' : 
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Galaxy) .oclIsTypeOf(OclAny)))"
by(rule OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy_defined[OF isdef[THEN foundation20]]) 

(* 68 ************************************ 384 + 1 *)
subsection{* Up Down Casting *}

(* 69 ************************************ 385 + 6 *)
lemma actualType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_larger_staticType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t : 
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> ((X::\<cdot>Person) .oclIsTypeOf(Planet)) \<triangleq> false"
  using isdef
by(auto simp: OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person foundation22 foundation16 null_option_def bot_option_def) 
lemma actualType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_larger_staticType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y : 
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> ((X::\<cdot>Person) .oclIsTypeOf(Galaxy)) \<triangleq> false"
  using isdef
by(auto simp: OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person foundation22 foundation16 null_option_def bot_option_def) 
lemma actualType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_larger_staticType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y : 
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> ((X::\<cdot>Person) .oclIsTypeOf(OclAny)) \<triangleq> false"
  using isdef
by(auto simp: OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person foundation22 foundation16 null_option_def bot_option_def) 
lemma actualType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_larger_staticType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y : 
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> ((X::\<cdot>Planet) .oclIsTypeOf(Galaxy)) \<triangleq> false"
  using isdef
by(auto simp: OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet foundation22 foundation16 null_option_def bot_option_def) 
lemma actualType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_larger_staticType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y : 
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> ((X::\<cdot>Planet) .oclIsTypeOf(OclAny)) \<triangleq> false"
  using isdef
by(auto simp: OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet foundation22 foundation16 null_option_def bot_option_def) 
lemma actualType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_larger_staticType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y : 
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> ((X::\<cdot>Galaxy) .oclIsTypeOf(OclAny)) \<triangleq> false"
  using isdef
by(auto simp: OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy foundation22 foundation16 null_option_def bot_option_def) 

(* 70 ************************************ 391 + 10 *)
lemma down_cast_type\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_from_Planet_to_Person : 
assumes istyp: "\<tau> \<Turnstile> ((X::\<cdot>Planet) .oclIsTypeOf(Planet))"
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> (X .oclAsType(Person)) \<triangleq> invalid"
  using istyp isdef
  apply(auto simp: OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet foundation22 foundation16 null_option_def bot_option_def split: ty\<E>\<X>\<T>\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t.split ty\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t.split)
by(simp add: OclValid_def false_def true_def) 
lemma down_cast_type\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_from_Galaxy_to_Person : 
assumes istyp: "\<tau> \<Turnstile> ((X::\<cdot>Galaxy) .oclIsTypeOf(Galaxy))"
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> (X .oclAsType(Person)) \<triangleq> invalid"
  using istyp isdef
  apply(auto simp: OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy foundation22 foundation16 null_option_def bot_option_def split: ty\<E>\<X>\<T>\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y.split ty\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y.split)
by(simp add: OclValid_def false_def true_def) 
lemma down_cast_type\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_from_OclAny_to_Person : 
assumes istyp: "\<tau> \<Turnstile> ((X::\<cdot>OclAny) .oclIsTypeOf(OclAny))"
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> (X .oclAsType(Person)) \<triangleq> invalid"
  using istyp isdef
  apply(auto simp: OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny foundation22 foundation16 null_option_def bot_option_def split: ty\<E>\<X>\<T>\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y.split ty\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y.split)
by(simp add: OclValid_def false_def true_def) 
lemma down_cast_type\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_from_Galaxy_to_Person : 
assumes istyp: "\<tau> \<Turnstile> ((X::\<cdot>Galaxy) .oclIsTypeOf(Planet))"
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> (X .oclAsType(Person)) \<triangleq> invalid"
  using istyp isdef
  apply(auto simp: OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy foundation22 foundation16 null_option_def bot_option_def split: ty\<E>\<X>\<T>\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y.split ty\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y.split)
by(simp add: OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy OclValid_def false_def true_def) 
lemma down_cast_type\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_from_OclAny_to_Person : 
assumes istyp: "\<tau> \<Turnstile> ((X::\<cdot>OclAny) .oclIsTypeOf(Planet))"
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> (X .oclAsType(Person)) \<triangleq> invalid"
  using istyp isdef
  apply(auto simp: OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny foundation22 foundation16 null_option_def bot_option_def split: ty\<E>\<X>\<T>\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y.split ty\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y.split)
by(simp add: OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny OclValid_def false_def true_def) 
lemma down_cast_type\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_from_OclAny_to_Person : 
assumes istyp: "\<tau> \<Turnstile> ((X::\<cdot>OclAny) .oclIsTypeOf(Galaxy))"
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> (X .oclAsType(Person)) \<triangleq> invalid"
  using istyp isdef
  apply(auto simp: OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny foundation22 foundation16 null_option_def bot_option_def split: ty\<E>\<X>\<T>\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y.split ty\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y.split)
by(simp add: OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny OclValid_def false_def true_def) 
lemma down_cast_type\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_from_Galaxy_to_Planet : 
assumes istyp: "\<tau> \<Turnstile> ((X::\<cdot>Galaxy) .oclIsTypeOf(Galaxy))"
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> (X .oclAsType(Planet)) \<triangleq> invalid"
  using istyp isdef
  apply(auto simp: OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy foundation22 foundation16 null_option_def bot_option_def split: ty\<E>\<X>\<T>\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y.split ty\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y.split)
by(simp add: OclValid_def false_def true_def) 
lemma down_cast_type\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_from_OclAny_to_Planet : 
assumes istyp: "\<tau> \<Turnstile> ((X::\<cdot>OclAny) .oclIsTypeOf(OclAny))"
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> (X .oclAsType(Planet)) \<triangleq> invalid"
  using istyp isdef
  apply(auto simp: OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny foundation22 foundation16 null_option_def bot_option_def split: ty\<E>\<X>\<T>\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y.split ty\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y.split)
by(simp add: OclValid_def false_def true_def) 
lemma down_cast_type\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_from_OclAny_to_Planet : 
assumes istyp: "\<tau> \<Turnstile> ((X::\<cdot>OclAny) .oclIsTypeOf(Galaxy))"
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> (X .oclAsType(Planet)) \<triangleq> invalid"
  using istyp isdef
  apply(auto simp: OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny foundation22 foundation16 null_option_def bot_option_def split: ty\<E>\<X>\<T>\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y.split ty\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y.split)
by(simp add: OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny OclValid_def false_def true_def) 
lemma down_cast_type\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_from_OclAny_to_Galaxy : 
assumes istyp: "\<tau> \<Turnstile> ((X::\<cdot>OclAny) .oclIsTypeOf(OclAny))"
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> (X .oclAsType(Galaxy)) \<triangleq> invalid"
  using istyp isdef
  apply(auto simp: OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny foundation22 foundation16 null_option_def bot_option_def split: ty\<E>\<X>\<T>\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y.split ty\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y.split)
by(simp add: OclValid_def false_def true_def) 

(* 71 ************************************ 401 + 1 *)
subsection{* Const *}

(* 72 ************************************ 402 + 1 *)
section{* OclIsKindOf *}

(* 73 ************************************ 403 + 1 *)
subsection{* Definition *}

(* 74 ************************************ 404 + 4 *)
consts OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n :: "'\<alpha> \<Rightarrow> Boolean" ("(_) .oclIsKindOf'(Person')")
consts OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t :: "'\<alpha> \<Rightarrow> Boolean" ("(_) .oclIsKindOf'(Planet')")
consts OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y :: "'\<alpha> \<Rightarrow> Boolean" ("(_) .oclIsKindOf'(Galaxy')")
consts OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y :: "'\<alpha> \<Rightarrow> Boolean" ("(_) .oclIsKindOf'(OclAny')")

(* 75 ************************************ 408 + 16 *)
defs(overloaded) OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person : "(x::\<cdot>Person) .oclIsKindOf(Person) \<equiv> (x .oclIsTypeOf(Person))"
defs(overloaded) OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet : "(x::\<cdot>Planet) .oclIsKindOf(Person) \<equiv> (x .oclIsTypeOf(Person))"
defs(overloaded) OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy : "(x::\<cdot>Galaxy) .oclIsKindOf(Person) \<equiv> (x .oclIsTypeOf(Person))"
defs(overloaded) OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny : "(x::\<cdot>OclAny) .oclIsKindOf(Person) \<equiv> (x .oclIsTypeOf(Person))"
defs(overloaded) OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet : "(x::\<cdot>Planet) .oclIsKindOf(Planet) \<equiv> (x .oclIsTypeOf(Planet)) or (x .oclIsKindOf(Person))"
defs(overloaded) OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy : "(x::\<cdot>Galaxy) .oclIsKindOf(Planet) \<equiv> (x .oclIsTypeOf(Planet)) or (x .oclIsKindOf(Person))"
defs(overloaded) OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny : "(x::\<cdot>OclAny) .oclIsKindOf(Planet) \<equiv> (x .oclIsTypeOf(Planet)) or (x .oclIsKindOf(Person))"
defs(overloaded) OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person : "(x::\<cdot>Person) .oclIsKindOf(Planet) \<equiv> (x .oclIsTypeOf(Planet)) or (x .oclIsKindOf(Person))"
defs(overloaded) OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy : "(x::\<cdot>Galaxy) .oclIsKindOf(Galaxy) \<equiv> (x .oclIsTypeOf(Galaxy)) or (x .oclIsKindOf(Planet))"
defs(overloaded) OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny : "(x::\<cdot>OclAny) .oclIsKindOf(Galaxy) \<equiv> (x .oclIsTypeOf(Galaxy)) or (x .oclIsKindOf(Planet))"
defs(overloaded) OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person : "(x::\<cdot>Person) .oclIsKindOf(Galaxy) \<equiv> (x .oclIsTypeOf(Galaxy)) or (x .oclIsKindOf(Planet))"
defs(overloaded) OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet : "(x::\<cdot>Planet) .oclIsKindOf(Galaxy) \<equiv> (x .oclIsTypeOf(Galaxy)) or (x .oclIsKindOf(Planet))"
defs(overloaded) OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny : "(x::\<cdot>OclAny) .oclIsKindOf(OclAny) \<equiv> (x .oclIsTypeOf(OclAny)) or (x .oclIsKindOf(Galaxy))"
defs(overloaded) OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person : "(x::\<cdot>Person) .oclIsKindOf(OclAny) \<equiv> (x .oclIsTypeOf(OclAny)) or (x .oclIsKindOf(Galaxy))"
defs(overloaded) OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet : "(x::\<cdot>Planet) .oclIsKindOf(OclAny) \<equiv> (x .oclIsTypeOf(OclAny)) or (x .oclIsKindOf(Galaxy))"
defs(overloaded) OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy : "(x::\<cdot>Galaxy) .oclIsKindOf(OclAny) \<equiv> (x .oclIsTypeOf(OclAny)) or (x .oclIsKindOf(Galaxy))"

(* 76 ************************************ 424 + 4 *)
definition "OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_\<AA> = (\<lambda> (in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (Person)) \<Rightarrow> (((((\<lambda>x _. \<lfloor>\<lfloor>x\<rfloor>\<rfloor>)) (Person))::\<cdot>Person) .oclIsKindOf(Person))
    | (in\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t (Planet)) \<Rightarrow> (((((\<lambda>x _. \<lfloor>\<lfloor>x\<rfloor>\<rfloor>)) (Planet))::\<cdot>Planet) .oclIsKindOf(Person))
    | (in\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y (Galaxy)) \<Rightarrow> (((((\<lambda>x _. \<lfloor>\<lfloor>x\<rfloor>\<rfloor>)) (Galaxy))::\<cdot>Galaxy) .oclIsKindOf(Person))
    | (in\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y (OclAny)) \<Rightarrow> (((((\<lambda>x _. \<lfloor>\<lfloor>x\<rfloor>\<rfloor>)) (OclAny))::\<cdot>OclAny) .oclIsKindOf(Person)))"
definition "OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_\<AA> = (\<lambda> (in\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t (Planet)) \<Rightarrow> (((((\<lambda>x _. \<lfloor>\<lfloor>x\<rfloor>\<rfloor>)) (Planet))::\<cdot>Planet) .oclIsKindOf(Planet))
    | (in\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y (Galaxy)) \<Rightarrow> (((((\<lambda>x _. \<lfloor>\<lfloor>x\<rfloor>\<rfloor>)) (Galaxy))::\<cdot>Galaxy) .oclIsKindOf(Planet))
    | (in\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y (OclAny)) \<Rightarrow> (((((\<lambda>x _. \<lfloor>\<lfloor>x\<rfloor>\<rfloor>)) (OclAny))::\<cdot>OclAny) .oclIsKindOf(Planet))
    | (in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (Person)) \<Rightarrow> (((((\<lambda>x _. \<lfloor>\<lfloor>x\<rfloor>\<rfloor>)) (Person))::\<cdot>Person) .oclIsKindOf(Planet)))"
definition "OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_\<AA> = (\<lambda> (in\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y (Galaxy)) \<Rightarrow> (((((\<lambda>x _. \<lfloor>\<lfloor>x\<rfloor>\<rfloor>)) (Galaxy))::\<cdot>Galaxy) .oclIsKindOf(Galaxy))
    | (in\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y (OclAny)) \<Rightarrow> (((((\<lambda>x _. \<lfloor>\<lfloor>x\<rfloor>\<rfloor>)) (OclAny))::\<cdot>OclAny) .oclIsKindOf(Galaxy))
    | (in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (Person)) \<Rightarrow> (((((\<lambda>x _. \<lfloor>\<lfloor>x\<rfloor>\<rfloor>)) (Person))::\<cdot>Person) .oclIsKindOf(Galaxy))
    | (in\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t (Planet)) \<Rightarrow> (((((\<lambda>x _. \<lfloor>\<lfloor>x\<rfloor>\<rfloor>)) (Planet))::\<cdot>Planet) .oclIsKindOf(Galaxy)))"
definition "OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_\<AA> = (\<lambda> (in\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y (OclAny)) \<Rightarrow> (((((\<lambda>x _. \<lfloor>\<lfloor>x\<rfloor>\<rfloor>)) (OclAny))::\<cdot>OclAny) .oclIsKindOf(OclAny))
    | (in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (Person)) \<Rightarrow> (((((\<lambda>x _. \<lfloor>\<lfloor>x\<rfloor>\<rfloor>)) (Person))::\<cdot>Person) .oclIsKindOf(OclAny))
    | (in\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t (Planet)) \<Rightarrow> (((((\<lambda>x _. \<lfloor>\<lfloor>x\<rfloor>\<rfloor>)) (Planet))::\<cdot>Planet) .oclIsKindOf(OclAny))
    | (in\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y (Galaxy)) \<Rightarrow> (((((\<lambda>x _. \<lfloor>\<lfloor>x\<rfloor>\<rfloor>)) (Galaxy))::\<cdot>Galaxy) .oclIsKindOf(OclAny)))"

(* 77 ************************************ 428 + 1 *)
lemmas[simp,code_unfold] = OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person
                            OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet
                            OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy
                            OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny

(* 78 ************************************ 429 + 1 *)
subsection{* Context Passing *}

(* 79 ************************************ 430 + 64 *)
lemma cp_OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person_Person : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Person)))::\<cdot>Person) .oclIsKindOf(Person)))))"
by(simp only: OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person, simp only: cp_OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person_Person)
lemma cp_OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet_Person : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Planet)))::\<cdot>Person) .oclIsKindOf(Person)))))"
by(simp only: OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person, simp only: cp_OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet_Person)
lemma cp_OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy_Person : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Galaxy)))::\<cdot>Person) .oclIsKindOf(Person)))))"
by(simp only: OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person, simp only: cp_OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy_Person)
lemma cp_OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny_Person : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>OclAny)))::\<cdot>Person) .oclIsKindOf(Person)))))"
by(simp only: OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person, simp only: cp_OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny_Person)
lemma cp_OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person_Planet : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Person)))::\<cdot>Planet) .oclIsKindOf(Person)))))"
by(simp only: OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet, simp only: cp_OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person_Planet)
lemma cp_OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet_Planet : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Planet)))::\<cdot>Planet) .oclIsKindOf(Person)))))"
by(simp only: OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet, simp only: cp_OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet_Planet)
lemma cp_OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy_Planet : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Galaxy)))::\<cdot>Planet) .oclIsKindOf(Person)))))"
by(simp only: OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet, simp only: cp_OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy_Planet)
lemma cp_OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny_Planet : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>OclAny)))::\<cdot>Planet) .oclIsKindOf(Person)))))"
by(simp only: OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet, simp only: cp_OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny_Planet)
lemma cp_OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person_Galaxy : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Person)))::\<cdot>Galaxy) .oclIsKindOf(Person)))))"
by(simp only: OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy, simp only: cp_OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person_Galaxy)
lemma cp_OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet_Galaxy : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Planet)))::\<cdot>Galaxy) .oclIsKindOf(Person)))))"
by(simp only: OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy, simp only: cp_OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet_Galaxy)
lemma cp_OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy_Galaxy : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Galaxy)))::\<cdot>Galaxy) .oclIsKindOf(Person)))))"
by(simp only: OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy, simp only: cp_OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy_Galaxy)
lemma cp_OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny_Galaxy : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>OclAny)))::\<cdot>Galaxy) .oclIsKindOf(Person)))))"
by(simp only: OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy, simp only: cp_OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny_Galaxy)
lemma cp_OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person_OclAny : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Person)))::\<cdot>OclAny) .oclIsKindOf(Person)))))"
by(simp only: OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny, simp only: cp_OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person_OclAny)
lemma cp_OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet_OclAny : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Planet)))::\<cdot>OclAny) .oclIsKindOf(Person)))))"
by(simp only: OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny, simp only: cp_OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet_OclAny)
lemma cp_OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy_OclAny : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Galaxy)))::\<cdot>OclAny) .oclIsKindOf(Person)))))"
by(simp only: OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny, simp only: cp_OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy_OclAny)
lemma cp_OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny_OclAny : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>OclAny)))::\<cdot>OclAny) .oclIsKindOf(Person)))))"
by(simp only: OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny, simp only: cp_OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny_OclAny)
lemma cp_OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet_Planet : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Planet)))::\<cdot>Planet) .oclIsKindOf(Planet)))))"
  apply(simp only: OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet)
  apply((rule cpI2[where f = "op or"], (rule allI)+, rule cp_OclOr)+)
  apply(simp only: cp_OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet_Planet)
by(simp only: cp_OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet_Planet)
lemma cp_OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy_Planet : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Galaxy)))::\<cdot>Planet) .oclIsKindOf(Planet)))))"
  apply(simp only: OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet)
  apply((rule cpI2[where f = "op or"], (rule allI)+, rule cp_OclOr)+)
  apply(simp only: cp_OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy_Planet)
by(simp only: cp_OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy_Planet)
lemma cp_OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny_Planet : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>OclAny)))::\<cdot>Planet) .oclIsKindOf(Planet)))))"
  apply(simp only: OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet)
  apply((rule cpI2[where f = "op or"], (rule allI)+, rule cp_OclOr)+)
  apply(simp only: cp_OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny_Planet)
by(simp only: cp_OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny_Planet)
lemma cp_OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person_Planet : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Person)))::\<cdot>Planet) .oclIsKindOf(Planet)))))"
  apply(simp only: OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet)
  apply((rule cpI2[where f = "op or"], (rule allI)+, rule cp_OclOr)+)
  apply(simp only: cp_OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person_Planet)
by(simp only: cp_OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person_Planet)
lemma cp_OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet_Galaxy : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Planet)))::\<cdot>Galaxy) .oclIsKindOf(Planet)))))"
  apply(simp only: OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy)
  apply((rule cpI2[where f = "op or"], (rule allI)+, rule cp_OclOr)+)
  apply(simp only: cp_OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet_Galaxy)
by(simp only: cp_OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet_Galaxy)
lemma cp_OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy_Galaxy : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Galaxy)))::\<cdot>Galaxy) .oclIsKindOf(Planet)))))"
  apply(simp only: OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy)
  apply((rule cpI2[where f = "op or"], (rule allI)+, rule cp_OclOr)+)
  apply(simp only: cp_OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy_Galaxy)
by(simp only: cp_OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy_Galaxy)
lemma cp_OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny_Galaxy : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>OclAny)))::\<cdot>Galaxy) .oclIsKindOf(Planet)))))"
  apply(simp only: OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy)
  apply((rule cpI2[where f = "op or"], (rule allI)+, rule cp_OclOr)+)
  apply(simp only: cp_OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny_Galaxy)
by(simp only: cp_OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny_Galaxy)
lemma cp_OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person_Galaxy : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Person)))::\<cdot>Galaxy) .oclIsKindOf(Planet)))))"
  apply(simp only: OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy)
  apply((rule cpI2[where f = "op or"], (rule allI)+, rule cp_OclOr)+)
  apply(simp only: cp_OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person_Galaxy)
by(simp only: cp_OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person_Galaxy)
lemma cp_OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet_OclAny : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Planet)))::\<cdot>OclAny) .oclIsKindOf(Planet)))))"
  apply(simp only: OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny)
  apply((rule cpI2[where f = "op or"], (rule allI)+, rule cp_OclOr)+)
  apply(simp only: cp_OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet_OclAny)
by(simp only: cp_OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet_OclAny)
lemma cp_OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy_OclAny : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Galaxy)))::\<cdot>OclAny) .oclIsKindOf(Planet)))))"
  apply(simp only: OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny)
  apply((rule cpI2[where f = "op or"], (rule allI)+, rule cp_OclOr)+)
  apply(simp only: cp_OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy_OclAny)
by(simp only: cp_OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy_OclAny)
lemma cp_OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny_OclAny : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>OclAny)))::\<cdot>OclAny) .oclIsKindOf(Planet)))))"
  apply(simp only: OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny)
  apply((rule cpI2[where f = "op or"], (rule allI)+, rule cp_OclOr)+)
  apply(simp only: cp_OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny_OclAny)
by(simp only: cp_OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny_OclAny)
lemma cp_OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person_OclAny : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Person)))::\<cdot>OclAny) .oclIsKindOf(Planet)))))"
  apply(simp only: OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny)
  apply((rule cpI2[where f = "op or"], (rule allI)+, rule cp_OclOr)+)
  apply(simp only: cp_OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person_OclAny)
by(simp only: cp_OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person_OclAny)
lemma cp_OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet_Person : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Planet)))::\<cdot>Person) .oclIsKindOf(Planet)))))"
  apply(simp only: OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person)
  apply((rule cpI2[where f = "op or"], (rule allI)+, rule cp_OclOr)+)
  apply(simp only: cp_OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet_Person)
by(simp only: cp_OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet_Person)
lemma cp_OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy_Person : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Galaxy)))::\<cdot>Person) .oclIsKindOf(Planet)))))"
  apply(simp only: OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person)
  apply((rule cpI2[where f = "op or"], (rule allI)+, rule cp_OclOr)+)
  apply(simp only: cp_OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy_Person)
by(simp only: cp_OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy_Person)
lemma cp_OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny_Person : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>OclAny)))::\<cdot>Person) .oclIsKindOf(Planet)))))"
  apply(simp only: OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person)
  apply((rule cpI2[where f = "op or"], (rule allI)+, rule cp_OclOr)+)
  apply(simp only: cp_OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny_Person)
by(simp only: cp_OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny_Person)
lemma cp_OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person_Person : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Person)))::\<cdot>Person) .oclIsKindOf(Planet)))))"
  apply(simp only: OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person)
  apply((rule cpI2[where f = "op or"], (rule allI)+, rule cp_OclOr)+)
  apply(simp only: cp_OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person_Person)
by(simp only: cp_OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person_Person)
lemma cp_OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy_Galaxy : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Galaxy)))::\<cdot>Galaxy) .oclIsKindOf(Galaxy)))))"
  apply(simp only: OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy)
  apply((rule cpI2[where f = "op or"], (rule allI)+, rule cp_OclOr)+)
  apply(simp only: cp_OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy_Galaxy)
by(simp only: cp_OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy_Galaxy)
lemma cp_OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny_Galaxy : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>OclAny)))::\<cdot>Galaxy) .oclIsKindOf(Galaxy)))))"
  apply(simp only: OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy)
  apply((rule cpI2[where f = "op or"], (rule allI)+, rule cp_OclOr)+)
  apply(simp only: cp_OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny_Galaxy)
by(simp only: cp_OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny_Galaxy)
lemma cp_OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person_Galaxy : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Person)))::\<cdot>Galaxy) .oclIsKindOf(Galaxy)))))"
  apply(simp only: OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy)
  apply((rule cpI2[where f = "op or"], (rule allI)+, rule cp_OclOr)+)
  apply(simp only: cp_OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person_Galaxy)
by(simp only: cp_OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person_Galaxy)
lemma cp_OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet_Galaxy : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Planet)))::\<cdot>Galaxy) .oclIsKindOf(Galaxy)))))"
  apply(simp only: OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy)
  apply((rule cpI2[where f = "op or"], (rule allI)+, rule cp_OclOr)+)
  apply(simp only: cp_OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet_Galaxy)
by(simp only: cp_OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet_Galaxy)
lemma cp_OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy_OclAny : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Galaxy)))::\<cdot>OclAny) .oclIsKindOf(Galaxy)))))"
  apply(simp only: OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny)
  apply((rule cpI2[where f = "op or"], (rule allI)+, rule cp_OclOr)+)
  apply(simp only: cp_OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy_OclAny)
by(simp only: cp_OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy_OclAny)
lemma cp_OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny_OclAny : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>OclAny)))::\<cdot>OclAny) .oclIsKindOf(Galaxy)))))"
  apply(simp only: OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny)
  apply((rule cpI2[where f = "op or"], (rule allI)+, rule cp_OclOr)+)
  apply(simp only: cp_OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny_OclAny)
by(simp only: cp_OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny_OclAny)
lemma cp_OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person_OclAny : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Person)))::\<cdot>OclAny) .oclIsKindOf(Galaxy)))))"
  apply(simp only: OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny)
  apply((rule cpI2[where f = "op or"], (rule allI)+, rule cp_OclOr)+)
  apply(simp only: cp_OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person_OclAny)
by(simp only: cp_OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person_OclAny)
lemma cp_OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet_OclAny : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Planet)))::\<cdot>OclAny) .oclIsKindOf(Galaxy)))))"
  apply(simp only: OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny)
  apply((rule cpI2[where f = "op or"], (rule allI)+, rule cp_OclOr)+)
  apply(simp only: cp_OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet_OclAny)
by(simp only: cp_OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet_OclAny)
lemma cp_OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy_Person : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Galaxy)))::\<cdot>Person) .oclIsKindOf(Galaxy)))))"
  apply(simp only: OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person)
  apply((rule cpI2[where f = "op or"], (rule allI)+, rule cp_OclOr)+)
  apply(simp only: cp_OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy_Person)
by(simp only: cp_OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy_Person)
lemma cp_OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny_Person : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>OclAny)))::\<cdot>Person) .oclIsKindOf(Galaxy)))))"
  apply(simp only: OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person)
  apply((rule cpI2[where f = "op or"], (rule allI)+, rule cp_OclOr)+)
  apply(simp only: cp_OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny_Person)
by(simp only: cp_OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny_Person)
lemma cp_OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person_Person : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Person)))::\<cdot>Person) .oclIsKindOf(Galaxy)))))"
  apply(simp only: OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person)
  apply((rule cpI2[where f = "op or"], (rule allI)+, rule cp_OclOr)+)
  apply(simp only: cp_OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person_Person)
by(simp only: cp_OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person_Person)
lemma cp_OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet_Person : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Planet)))::\<cdot>Person) .oclIsKindOf(Galaxy)))))"
  apply(simp only: OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person)
  apply((rule cpI2[where f = "op or"], (rule allI)+, rule cp_OclOr)+)
  apply(simp only: cp_OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet_Person)
by(simp only: cp_OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet_Person)
lemma cp_OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy_Planet : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Galaxy)))::\<cdot>Planet) .oclIsKindOf(Galaxy)))))"
  apply(simp only: OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet)
  apply((rule cpI2[where f = "op or"], (rule allI)+, rule cp_OclOr)+)
  apply(simp only: cp_OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy_Planet)
by(simp only: cp_OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy_Planet)
lemma cp_OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny_Planet : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>OclAny)))::\<cdot>Planet) .oclIsKindOf(Galaxy)))))"
  apply(simp only: OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet)
  apply((rule cpI2[where f = "op or"], (rule allI)+, rule cp_OclOr)+)
  apply(simp only: cp_OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny_Planet)
by(simp only: cp_OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny_Planet)
lemma cp_OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person_Planet : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Person)))::\<cdot>Planet) .oclIsKindOf(Galaxy)))))"
  apply(simp only: OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet)
  apply((rule cpI2[where f = "op or"], (rule allI)+, rule cp_OclOr)+)
  apply(simp only: cp_OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person_Planet)
by(simp only: cp_OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person_Planet)
lemma cp_OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet_Planet : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Planet)))::\<cdot>Planet) .oclIsKindOf(Galaxy)))))"
  apply(simp only: OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet)
  apply((rule cpI2[where f = "op or"], (rule allI)+, rule cp_OclOr)+)
  apply(simp only: cp_OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet_Planet)
by(simp only: cp_OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet_Planet)
lemma cp_OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny_OclAny : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>OclAny)))::\<cdot>OclAny) .oclIsKindOf(OclAny)))))"
  apply(simp only: OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny)
  apply((rule cpI2[where f = "op or"], (rule allI)+, rule cp_OclOr)+)
  apply(simp only: cp_OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny_OclAny)
by(simp only: cp_OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny_OclAny)
lemma cp_OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person_OclAny : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Person)))::\<cdot>OclAny) .oclIsKindOf(OclAny)))))"
  apply(simp only: OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny)
  apply((rule cpI2[where f = "op or"], (rule allI)+, rule cp_OclOr)+)
  apply(simp only: cp_OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person_OclAny)
by(simp only: cp_OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person_OclAny)
lemma cp_OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet_OclAny : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Planet)))::\<cdot>OclAny) .oclIsKindOf(OclAny)))))"
  apply(simp only: OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny)
  apply((rule cpI2[where f = "op or"], (rule allI)+, rule cp_OclOr)+)
  apply(simp only: cp_OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet_OclAny)
by(simp only: cp_OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet_OclAny)
lemma cp_OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy_OclAny : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Galaxy)))::\<cdot>OclAny) .oclIsKindOf(OclAny)))))"
  apply(simp only: OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny)
  apply((rule cpI2[where f = "op or"], (rule allI)+, rule cp_OclOr)+)
  apply(simp only: cp_OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy_OclAny)
by(simp only: cp_OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy_OclAny)
lemma cp_OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny_Person : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>OclAny)))::\<cdot>Person) .oclIsKindOf(OclAny)))))"
  apply(simp only: OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person)
  apply((rule cpI2[where f = "op or"], (rule allI)+, rule cp_OclOr)+)
  apply(simp only: cp_OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny_Person)
by(simp only: cp_OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny_Person)
lemma cp_OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person_Person : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Person)))::\<cdot>Person) .oclIsKindOf(OclAny)))))"
  apply(simp only: OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person)
  apply((rule cpI2[where f = "op or"], (rule allI)+, rule cp_OclOr)+)
  apply(simp only: cp_OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person_Person)
by(simp only: cp_OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person_Person)
lemma cp_OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet_Person : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Planet)))::\<cdot>Person) .oclIsKindOf(OclAny)))))"
  apply(simp only: OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person)
  apply((rule cpI2[where f = "op or"], (rule allI)+, rule cp_OclOr)+)
  apply(simp only: cp_OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet_Person)
by(simp only: cp_OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet_Person)
lemma cp_OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy_Person : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Galaxy)))::\<cdot>Person) .oclIsKindOf(OclAny)))))"
  apply(simp only: OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person)
  apply((rule cpI2[where f = "op or"], (rule allI)+, rule cp_OclOr)+)
  apply(simp only: cp_OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy_Person)
by(simp only: cp_OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy_Person)
lemma cp_OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny_Planet : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>OclAny)))::\<cdot>Planet) .oclIsKindOf(OclAny)))))"
  apply(simp only: OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet)
  apply((rule cpI2[where f = "op or"], (rule allI)+, rule cp_OclOr)+)
  apply(simp only: cp_OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny_Planet)
by(simp only: cp_OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny_Planet)
lemma cp_OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person_Planet : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Person)))::\<cdot>Planet) .oclIsKindOf(OclAny)))))"
  apply(simp only: OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet)
  apply((rule cpI2[where f = "op or"], (rule allI)+, rule cp_OclOr)+)
  apply(simp only: cp_OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person_Planet)
by(simp only: cp_OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person_Planet)
lemma cp_OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet_Planet : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Planet)))::\<cdot>Planet) .oclIsKindOf(OclAny)))))"
  apply(simp only: OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet)
  apply((rule cpI2[where f = "op or"], (rule allI)+, rule cp_OclOr)+)
  apply(simp only: cp_OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet_Planet)
by(simp only: cp_OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet_Planet)
lemma cp_OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy_Planet : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Galaxy)))::\<cdot>Planet) .oclIsKindOf(OclAny)))))"
  apply(simp only: OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet)
  apply((rule cpI2[where f = "op or"], (rule allI)+, rule cp_OclOr)+)
  apply(simp only: cp_OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy_Planet)
by(simp only: cp_OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy_Planet)
lemma cp_OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny_Galaxy : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>OclAny)))::\<cdot>Galaxy) .oclIsKindOf(OclAny)))))"
  apply(simp only: OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy)
  apply((rule cpI2[where f = "op or"], (rule allI)+, rule cp_OclOr)+)
  apply(simp only: cp_OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny_Galaxy)
by(simp only: cp_OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny_Galaxy)
lemma cp_OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person_Galaxy : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Person)))::\<cdot>Galaxy) .oclIsKindOf(OclAny)))))"
  apply(simp only: OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy)
  apply((rule cpI2[where f = "op or"], (rule allI)+, rule cp_OclOr)+)
  apply(simp only: cp_OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person_Galaxy)
by(simp only: cp_OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person_Galaxy)
lemma cp_OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet_Galaxy : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Planet)))::\<cdot>Galaxy) .oclIsKindOf(OclAny)))))"
  apply(simp only: OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy)
  apply((rule cpI2[where f = "op or"], (rule allI)+, rule cp_OclOr)+)
  apply(simp only: cp_OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet_Galaxy)
by(simp only: cp_OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet_Galaxy)
lemma cp_OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy_Galaxy : "(cp (p)) \<Longrightarrow> (cp ((\<lambda>x. (((p ((x::\<cdot>Galaxy)))::\<cdot>Galaxy) .oclIsKindOf(OclAny)))))"
  apply(simp only: OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy)
  apply((rule cpI2[where f = "op or"], (rule allI)+, rule cp_OclOr)+)
  apply(simp only: cp_OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy_Galaxy)
by(simp only: cp_OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy_Galaxy)

(* 80 ************************************ 494 + 1 *)
lemmas[simp,code_unfold] = cp_OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny_OclAny
                            cp_OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy_OclAny
                            cp_OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet_OclAny
                            cp_OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person_OclAny
                            cp_OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny_Galaxy
                            cp_OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy_Galaxy
                            cp_OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet_Galaxy
                            cp_OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person_Galaxy
                            cp_OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny_Planet
                            cp_OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy_Planet
                            cp_OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet_Planet
                            cp_OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person_Planet
                            cp_OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny_Person
                            cp_OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy_Person
                            cp_OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet_Person
                            cp_OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person_Person
                            cp_OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny_OclAny
                            cp_OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy_OclAny
                            cp_OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet_OclAny
                            cp_OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person_OclAny
                            cp_OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny_Galaxy
                            cp_OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy_Galaxy
                            cp_OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet_Galaxy
                            cp_OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person_Galaxy
                            cp_OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny_Planet
                            cp_OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy_Planet
                            cp_OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet_Planet
                            cp_OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person_Planet
                            cp_OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny_Person
                            cp_OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy_Person
                            cp_OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet_Person
                            cp_OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person_Person
                            cp_OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny_OclAny
                            cp_OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy_OclAny
                            cp_OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet_OclAny
                            cp_OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person_OclAny
                            cp_OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny_Galaxy
                            cp_OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy_Galaxy
                            cp_OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet_Galaxy
                            cp_OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person_Galaxy
                            cp_OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny_Planet
                            cp_OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy_Planet
                            cp_OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet_Planet
                            cp_OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person_Planet
                            cp_OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny_Person
                            cp_OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy_Person
                            cp_OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet_Person
                            cp_OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person_Person
                            cp_OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny_OclAny
                            cp_OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy_OclAny
                            cp_OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet_OclAny
                            cp_OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person_OclAny
                            cp_OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny_Galaxy
                            cp_OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy_Galaxy
                            cp_OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet_Galaxy
                            cp_OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person_Galaxy
                            cp_OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny_Planet
                            cp_OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy_Planet
                            cp_OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet_Planet
                            cp_OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person_Planet
                            cp_OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny_Person
                            cp_OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy_Person
                            cp_OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet_Person
                            cp_OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person_Person

(* 81 ************************************ 495 + 1 *)
subsection{* Execution with Invalid or Null as Argument *}

(* 82 ************************************ 496 + 32 *)
lemma OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person_invalid : "((invalid::\<cdot>Person) .oclIsKindOf(Person)) = invalid"
by(simp only: OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person_invalid)
lemma OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person_null : "((null::\<cdot>Person) .oclIsKindOf(Person)) = true"
by(simp only: OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person_null)
lemma OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet_invalid : "((invalid::\<cdot>Planet) .oclIsKindOf(Person)) = invalid"
by(simp only: OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet_invalid)
lemma OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet_null : "((null::\<cdot>Planet) .oclIsKindOf(Person)) = true"
by(simp only: OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet_null)
lemma OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy_invalid : "((invalid::\<cdot>Galaxy) .oclIsKindOf(Person)) = invalid"
by(simp only: OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy_invalid)
lemma OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy_null : "((null::\<cdot>Galaxy) .oclIsKindOf(Person)) = true"
by(simp only: OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy_null)
lemma OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny_invalid : "((invalid::\<cdot>OclAny) .oclIsKindOf(Person)) = invalid"
by(simp only: OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny_invalid)
lemma OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny_null : "((null::\<cdot>OclAny) .oclIsKindOf(Person)) = true"
by(simp only: OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny_null)
lemma OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet_invalid : "((invalid::\<cdot>Planet) .oclIsKindOf(Planet)) = invalid"
by(simp only: OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet_invalid OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet_invalid, simp)
lemma OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet_null : "((null::\<cdot>Planet) .oclIsKindOf(Planet)) = true"
by(simp only: OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet_null OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet_null, simp)
lemma OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy_invalid : "((invalid::\<cdot>Galaxy) .oclIsKindOf(Planet)) = invalid"
by(simp only: OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy_invalid OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy_invalid, simp)
lemma OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy_null : "((null::\<cdot>Galaxy) .oclIsKindOf(Planet)) = true"
by(simp only: OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy_null OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy_null, simp)
lemma OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny_invalid : "((invalid::\<cdot>OclAny) .oclIsKindOf(Planet)) = invalid"
by(simp only: OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny_invalid OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny_invalid, simp)
lemma OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny_null : "((null::\<cdot>OclAny) .oclIsKindOf(Planet)) = true"
by(simp only: OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny_null OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny_null, simp)
lemma OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person_invalid : "((invalid::\<cdot>Person) .oclIsKindOf(Planet)) = invalid"
by(simp only: OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person_invalid OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person_invalid, simp)
lemma OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person_null : "((null::\<cdot>Person) .oclIsKindOf(Planet)) = true"
by(simp only: OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person_null OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person_null, simp)
lemma OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy_invalid : "((invalid::\<cdot>Galaxy) .oclIsKindOf(Galaxy)) = invalid"
by(simp only: OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy_invalid OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy_invalid, simp)
lemma OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy_null : "((null::\<cdot>Galaxy) .oclIsKindOf(Galaxy)) = true"
by(simp only: OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy_null OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy_null, simp)
lemma OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny_invalid : "((invalid::\<cdot>OclAny) .oclIsKindOf(Galaxy)) = invalid"
by(simp only: OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny_invalid OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny_invalid, simp)
lemma OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny_null : "((null::\<cdot>OclAny) .oclIsKindOf(Galaxy)) = true"
by(simp only: OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny_null OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny_null, simp)
lemma OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person_invalid : "((invalid::\<cdot>Person) .oclIsKindOf(Galaxy)) = invalid"
by(simp only: OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person_invalid OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person_invalid, simp)
lemma OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person_null : "((null::\<cdot>Person) .oclIsKindOf(Galaxy)) = true"
by(simp only: OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person_null OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person_null, simp)
lemma OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet_invalid : "((invalid::\<cdot>Planet) .oclIsKindOf(Galaxy)) = invalid"
by(simp only: OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet_invalid OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet_invalid, simp)
lemma OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet_null : "((null::\<cdot>Planet) .oclIsKindOf(Galaxy)) = true"
by(simp only: OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet_null OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet_null, simp)
lemma OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny_invalid : "((invalid::\<cdot>OclAny) .oclIsKindOf(OclAny)) = invalid"
by(simp only: OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny_invalid OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny_invalid, simp)
lemma OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny_null : "((null::\<cdot>OclAny) .oclIsKindOf(OclAny)) = true"
by(simp only: OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny_null OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny_null, simp)
lemma OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person_invalid : "((invalid::\<cdot>Person) .oclIsKindOf(OclAny)) = invalid"
by(simp only: OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person_invalid OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person_invalid, simp)
lemma OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person_null : "((null::\<cdot>Person) .oclIsKindOf(OclAny)) = true"
by(simp only: OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person_null OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person_null, simp)
lemma OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet_invalid : "((invalid::\<cdot>Planet) .oclIsKindOf(OclAny)) = invalid"
by(simp only: OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet_invalid OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet_invalid, simp)
lemma OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet_null : "((null::\<cdot>Planet) .oclIsKindOf(OclAny)) = true"
by(simp only: OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet_null OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet_null, simp)
lemma OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy_invalid : "((invalid::\<cdot>Galaxy) .oclIsKindOf(OclAny)) = invalid"
by(simp only: OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy_invalid OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy_invalid, simp)
lemma OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy_null : "((null::\<cdot>Galaxy) .oclIsKindOf(OclAny)) = true"
by(simp only: OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy_null OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy_null, simp)

(* 83 ************************************ 528 + 1 *)
lemmas[simp,code_unfold] = OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny_invalid
                            OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy_invalid
                            OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet_invalid
                            OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person_invalid
                            OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny_null
                            OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy_null
                            OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet_null
                            OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person_null
                            OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny_invalid
                            OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy_invalid
                            OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet_invalid
                            OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person_invalid
                            OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny_null
                            OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy_null
                            OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet_null
                            OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person_null
                            OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny_invalid
                            OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy_invalid
                            OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet_invalid
                            OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person_invalid
                            OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny_null
                            OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy_null
                            OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet_null
                            OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person_null
                            OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny_invalid
                            OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy_invalid
                            OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet_invalid
                            OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person_invalid
                            OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny_null
                            OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy_null
                            OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet_null
                            OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person_null

(* 84 ************************************ 529 + 1 *)
subsection{* Validity and Definedness Properties *}

(* 85 ************************************ 530 + 16 *)
lemma OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person_defined : 
assumes isdef: "\<tau> \<Turnstile> (\<upsilon> (X))"
shows "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Person) .oclIsKindOf(Person)))"
by(simp only: OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person, rule OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person_defined[OF isdef]) 
lemma OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet_defined : 
assumes isdef: "\<tau> \<Turnstile> (\<upsilon> (X))"
shows "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Planet) .oclIsKindOf(Person)))"
by(simp only: OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet, rule OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet_defined[OF isdef]) 
lemma OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy_defined : 
assumes isdef: "\<tau> \<Turnstile> (\<upsilon> (X))"
shows "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Galaxy) .oclIsKindOf(Person)))"
by(simp only: OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy, rule OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy_defined[OF isdef]) 
lemma OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny_defined : 
assumes isdef: "\<tau> \<Turnstile> (\<upsilon> (X))"
shows "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>OclAny) .oclIsKindOf(Person)))"
by(simp only: OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny, rule OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny_defined[OF isdef]) 
lemma OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet_defined : 
assumes isdef: "\<tau> \<Turnstile> (\<upsilon> (X))"
shows "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Planet) .oclIsKindOf(Planet)))"
by(simp only: OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet, rule defined_or_I[OF OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet_defined[OF isdef], OF OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet_defined[OF isdef]]) 
lemma OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy_defined : 
assumes isdef: "\<tau> \<Turnstile> (\<upsilon> (X))"
shows "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Galaxy) .oclIsKindOf(Planet)))"
by(simp only: OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy, rule defined_or_I[OF OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy_defined[OF isdef], OF OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy_defined[OF isdef]]) 
lemma OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny_defined : 
assumes isdef: "\<tau> \<Turnstile> (\<upsilon> (X))"
shows "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>OclAny) .oclIsKindOf(Planet)))"
by(simp only: OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny, rule defined_or_I[OF OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny_defined[OF isdef], OF OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny_defined[OF isdef]]) 
lemma OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person_defined : 
assumes isdef: "\<tau> \<Turnstile> (\<upsilon> (X))"
shows "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Person) .oclIsKindOf(Planet)))"
by(simp only: OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person, rule defined_or_I[OF OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person_defined[OF isdef], OF OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person_defined[OF isdef]]) 
lemma OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy_defined : 
assumes isdef: "\<tau> \<Turnstile> (\<upsilon> (X))"
shows "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Galaxy) .oclIsKindOf(Galaxy)))"
by(simp only: OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy, rule defined_or_I[OF OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy_defined[OF isdef], OF OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy_defined[OF isdef]]) 
lemma OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny_defined : 
assumes isdef: "\<tau> \<Turnstile> (\<upsilon> (X))"
shows "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>OclAny) .oclIsKindOf(Galaxy)))"
by(simp only: OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny, rule defined_or_I[OF OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny_defined[OF isdef], OF OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny_defined[OF isdef]]) 
lemma OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person_defined : 
assumes isdef: "\<tau> \<Turnstile> (\<upsilon> (X))"
shows "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Person) .oclIsKindOf(Galaxy)))"
by(simp only: OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person, rule defined_or_I[OF OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person_defined[OF isdef], OF OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person_defined[OF isdef]]) 
lemma OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet_defined : 
assumes isdef: "\<tau> \<Turnstile> (\<upsilon> (X))"
shows "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Planet) .oclIsKindOf(Galaxy)))"
by(simp only: OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet, rule defined_or_I[OF OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet_defined[OF isdef], OF OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet_defined[OF isdef]]) 
lemma OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny_defined : 
assumes isdef: "\<tau> \<Turnstile> (\<upsilon> (X))"
shows "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>OclAny) .oclIsKindOf(OclAny)))"
by(simp only: OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny, rule defined_or_I[OF OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny_defined[OF isdef], OF OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny_defined[OF isdef]]) 
lemma OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person_defined : 
assumes isdef: "\<tau> \<Turnstile> (\<upsilon> (X))"
shows "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Person) .oclIsKindOf(OclAny)))"
by(simp only: OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person, rule defined_or_I[OF OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person_defined[OF isdef], OF OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person_defined[OF isdef]]) 
lemma OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet_defined : 
assumes isdef: "\<tau> \<Turnstile> (\<upsilon> (X))"
shows "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Planet) .oclIsKindOf(OclAny)))"
by(simp only: OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet, rule defined_or_I[OF OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet_defined[OF isdef], OF OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet_defined[OF isdef]]) 
lemma OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy_defined : 
assumes isdef: "\<tau> \<Turnstile> (\<upsilon> (X))"
shows "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Galaxy) .oclIsKindOf(OclAny)))"
by(simp only: OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy, rule defined_or_I[OF OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy_defined[OF isdef], OF OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy_defined[OF isdef]]) 

(* 86 ************************************ 546 + 16 *)
lemma OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person_defined' : 
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Person) .oclIsKindOf(Person)))"
by(rule OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person_defined[OF isdef[THEN foundation20]]) 
lemma OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet_defined' : 
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Planet) .oclIsKindOf(Person)))"
by(rule OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet_defined[OF isdef[THEN foundation20]]) 
lemma OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy_defined' : 
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Galaxy) .oclIsKindOf(Person)))"
by(rule OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy_defined[OF isdef[THEN foundation20]]) 
lemma OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny_defined' : 
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>OclAny) .oclIsKindOf(Person)))"
by(rule OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny_defined[OF isdef[THEN foundation20]]) 
lemma OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet_defined' : 
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Planet) .oclIsKindOf(Planet)))"
by(rule OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet_defined[OF isdef[THEN foundation20]]) 
lemma OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy_defined' : 
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Galaxy) .oclIsKindOf(Planet)))"
by(rule OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy_defined[OF isdef[THEN foundation20]]) 
lemma OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny_defined' : 
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>OclAny) .oclIsKindOf(Planet)))"
by(rule OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny_defined[OF isdef[THEN foundation20]]) 
lemma OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person_defined' : 
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Person) .oclIsKindOf(Planet)))"
by(rule OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person_defined[OF isdef[THEN foundation20]]) 
lemma OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy_defined' : 
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Galaxy) .oclIsKindOf(Galaxy)))"
by(rule OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy_defined[OF isdef[THEN foundation20]]) 
lemma OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny_defined' : 
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>OclAny) .oclIsKindOf(Galaxy)))"
by(rule OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny_defined[OF isdef[THEN foundation20]]) 
lemma OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person_defined' : 
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Person) .oclIsKindOf(Galaxy)))"
by(rule OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person_defined[OF isdef[THEN foundation20]]) 
lemma OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet_defined' : 
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Planet) .oclIsKindOf(Galaxy)))"
by(rule OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet_defined[OF isdef[THEN foundation20]]) 
lemma OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny_defined' : 
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>OclAny) .oclIsKindOf(OclAny)))"
by(rule OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny_defined[OF isdef[THEN foundation20]]) 
lemma OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person_defined' : 
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Person) .oclIsKindOf(OclAny)))"
by(rule OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person_defined[OF isdef[THEN foundation20]]) 
lemma OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet_defined' : 
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Planet) .oclIsKindOf(OclAny)))"
by(rule OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet_defined[OF isdef[THEN foundation20]]) 
lemma OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy_defined' : 
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Galaxy) .oclIsKindOf(OclAny)))"
by(rule OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy_defined[OF isdef[THEN foundation20]]) 

(* 87 ************************************ 562 + 1 *)
subsection{* Up Down Casting *}

(* 88 ************************************ 563 + 4 *)
lemma actual_eq_static\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n : 
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> ((X::\<cdot>Person) .oclIsKindOf(Person))"
  apply(simp only: OclValid_def, insert isdef)
  apply(simp only: OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person)
  apply(auto simp: foundation16 bot_option_def split: option.split ty\<E>\<X>\<T>\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n.split ty\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n.split)
by((simp_all add: false_def true_def OclOr_def OclAnd_def OclNot_def)?) 
lemma actual_eq_static\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t : 
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> ((X::\<cdot>Planet) .oclIsKindOf(Planet))"
  apply(simp only: OclValid_def, insert isdef)
  apply(simp only: OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet, subst (1) cp_OclOr, simp only: OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet)
  apply(auto simp: cp_OclOr[symmetric ] foundation16 bot_option_def OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet split: option.split ty\<E>\<X>\<T>\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t.split ty\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t.split ty\<E>\<X>\<T>\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n.split ty\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n.split)
by((simp_all add: false_def true_def OclOr_def OclAnd_def OclNot_def)?) 
lemma actual_eq_static\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y : 
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> ((X::\<cdot>Galaxy) .oclIsKindOf(Galaxy))"
  apply(simp only: OclValid_def, insert isdef)
  apply(simp only: OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy, subst (1) cp_OclOr, simp only: OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy, subst (2 1) cp_OclOr, simp only: OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy)
  apply(auto simp: cp_OclOr[symmetric ] foundation16 bot_option_def OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy split: option.split ty\<E>\<X>\<T>\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y.split ty\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y.split ty\<E>\<X>\<T>\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n.split ty\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n.split ty\<E>\<X>\<T>\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t.split ty\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t.split)
by((simp_all add: false_def true_def OclOr_def OclAnd_def OclNot_def)?) 
lemma actual_eq_static\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y : 
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> ((X::\<cdot>OclAny) .oclIsKindOf(OclAny))"
  apply(simp only: OclValid_def, insert isdef)
  apply(simp only: OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny, subst (1) cp_OclOr, simp only: OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny, subst (2 1) cp_OclOr, simp only: OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny, subst (3 2 1) cp_OclOr, simp only: OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny)
  apply(auto simp: cp_OclOr[symmetric ] foundation16 bot_option_def OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny split: option.split ty\<E>\<X>\<T>\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y.split ty\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y.split ty\<E>\<X>\<T>\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n.split ty\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n.split ty\<E>\<X>\<T>\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t.split ty\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t.split ty\<E>\<X>\<T>\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y.split ty\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y.split)
by((simp_all add: false_def true_def OclOr_def OclAnd_def OclNot_def)?) 

(* 89 ************************************ 567 + 6 *)
lemma actualKind\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_larger_staticKind\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t : 
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> ((X::\<cdot>Person) .oclIsKindOf(Planet))"
  apply(simp only: OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person)
by(rule foundation25', rule actual_eq_static\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n[OF isdef]) 
lemma actualKind\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_larger_staticKind\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y : 
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> ((X::\<cdot>Person) .oclIsKindOf(Galaxy))"
  apply(simp only: OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person)
by(rule foundation25', rule actualKind\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_larger_staticKind\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t[OF isdef]) 
lemma actualKind\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_larger_staticKind\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y : 
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> ((X::\<cdot>Person) .oclIsKindOf(OclAny))"
  apply(simp only: OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person)
by(rule foundation25', rule actualKind\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_larger_staticKind\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y[OF isdef]) 
lemma actualKind\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_larger_staticKind\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y : 
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> ((X::\<cdot>Planet) .oclIsKindOf(Galaxy))"
  apply(simp only: OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet)
by(rule foundation25', rule actual_eq_static\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t[OF isdef]) 
lemma actualKind\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_larger_staticKind\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y : 
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> ((X::\<cdot>Planet) .oclIsKindOf(OclAny))"
  apply(simp only: OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet)
by(rule foundation25', rule actualKind\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_larger_staticKind\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y[OF isdef]) 
lemma actualKind\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_larger_staticKind\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y : 
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> ((X::\<cdot>Galaxy) .oclIsKindOf(OclAny))"
  apply(simp only: OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy)
by(rule foundation25', rule actual_eq_static\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y[OF isdef]) 

(* 90 ************************************ 573 + 6 *)
lemma not_OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_then_Planet_OclIsTypeOf_others_unfold : 
assumes isdef: "(\<tau> \<Turnstile> (\<delta> (X)))"
assumes iskin: "(\<tau> \<Turnstile> ((X::\<cdot>Planet) .oclIsKindOf(Person)))"
shows "(\<tau> \<Turnstile> ((X::\<cdot>Planet) .oclIsTypeOf(Person)))"
  using iskin
  apply(simp only: OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet)
done 
lemma not_OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_then_Galaxy_OclIsTypeOf_others_unfold : 
assumes isdef: "(\<tau> \<Turnstile> (\<delta> (X)))"
assumes iskin: "(\<tau> \<Turnstile> ((X::\<cdot>Galaxy) .oclIsKindOf(Person)))"
shows "(\<tau> \<Turnstile> ((X::\<cdot>Galaxy) .oclIsTypeOf(Person)))"
  using iskin
  apply(simp only: OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy)
done 
lemma not_OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_then_OclAny_OclIsTypeOf_others_unfold : 
assumes isdef: "(\<tau> \<Turnstile> (\<delta> (X)))"
assumes iskin: "(\<tau> \<Turnstile> ((X::\<cdot>OclAny) .oclIsKindOf(Person)))"
shows "(\<tau> \<Turnstile> ((X::\<cdot>OclAny) .oclIsTypeOf(Person)))"
  using iskin
  apply(simp only: OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny)
done 
lemma not_OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_then_Galaxy_OclIsTypeOf_others_unfold : 
assumes isdef: "(\<tau> \<Turnstile> (\<delta> (X)))"
assumes iskin: "(\<tau> \<Turnstile> ((X::\<cdot>Galaxy) .oclIsKindOf(Planet)))"
shows "((\<tau> \<Turnstile> ((X::\<cdot>Galaxy) .oclIsTypeOf(Planet))) \<or> (\<tau> \<Turnstile> ((X::\<cdot>Galaxy) .oclIsTypeOf(Person))))"
  using iskin
  apply(simp only: OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy)
  apply(erule foundation26[OF OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy_defined'[OF isdef], OF OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy_defined'[OF isdef]])
  apply(simp)
  apply(drule not_OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_then_Galaxy_OclIsTypeOf_others_unfold[OF isdef], blast)
done 
lemma not_OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_then_OclAny_OclIsTypeOf_others_unfold : 
assumes isdef: "(\<tau> \<Turnstile> (\<delta> (X)))"
assumes iskin: "(\<tau> \<Turnstile> ((X::\<cdot>OclAny) .oclIsKindOf(Planet)))"
shows "((\<tau> \<Turnstile> ((X::\<cdot>OclAny) .oclIsTypeOf(Planet))) \<or> (\<tau> \<Turnstile> ((X::\<cdot>OclAny) .oclIsTypeOf(Person))))"
  using iskin
  apply(simp only: OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny)
  apply(erule foundation26[OF OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny_defined'[OF isdef], OF OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny_defined'[OF isdef]])
  apply(simp)
  apply(drule not_OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_then_OclAny_OclIsTypeOf_others_unfold[OF isdef], blast)
done 
lemma not_OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_then_OclAny_OclIsTypeOf_others_unfold : 
assumes isdef: "(\<tau> \<Turnstile> (\<delta> (X)))"
assumes iskin: "(\<tau> \<Turnstile> ((X::\<cdot>OclAny) .oclIsKindOf(Galaxy)))"
shows "((\<tau> \<Turnstile> ((X::\<cdot>OclAny) .oclIsTypeOf(Galaxy))) \<or> ((\<tau> \<Turnstile> ((X::\<cdot>OclAny) .oclIsTypeOf(Person))) \<or> (\<tau> \<Turnstile> ((X::\<cdot>OclAny) .oclIsTypeOf(Planet)))))"
  using iskin
  apply(simp only: OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny)
  apply(erule foundation26[OF OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny_defined'[OF isdef], OF OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny_defined'[OF isdef]])
  apply(simp)
  apply(drule not_OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_then_OclAny_OclIsTypeOf_others_unfold[OF isdef], blast)
done 

(* 91 ************************************ 579 + 6 *)
lemma not_OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_then_Planet_OclIsTypeOf_others : 
assumes iskin: "\<not> \<tau> \<Turnstile> ((X::\<cdot>Planet) .oclIsKindOf(Person))"
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> ((X::\<cdot>Planet) .oclIsTypeOf(Planet))"
  using actual_eq_static\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t[OF isdef]
  apply(simp only: OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet)
  apply(erule foundation26[OF OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet_defined'[OF isdef], OF OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet_defined'[OF isdef]])
  apply(simp)
  apply(simp add: iskin)
done 
lemma not_OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_then_Galaxy_OclIsTypeOf_others : 
assumes iskin: "\<not> \<tau> \<Turnstile> ((X::\<cdot>Galaxy) .oclIsKindOf(Person))"
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "(\<tau> \<Turnstile> ((X::\<cdot>Galaxy) .oclIsTypeOf(Galaxy)) \<or> \<tau> \<Turnstile> ((X::\<cdot>Galaxy) .oclIsTypeOf(Planet)))"
  using actual_eq_static\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y[OF isdef]
  apply(simp only: OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy)
  apply(erule foundation26[OF OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy_defined'[OF isdef], OF OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy_defined'[OF isdef]])
  apply(simp)
  apply(simp only: OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy)
  apply(erule foundation26[OF OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy_defined'[OF isdef], OF OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy_defined'[OF isdef]])
  apply(simp)
  apply(simp add: iskin)
done 
lemma not_OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_then_OclAny_OclIsTypeOf_others : 
assumes iskin: "\<not> \<tau> \<Turnstile> ((X::\<cdot>OclAny) .oclIsKindOf(Person))"
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "(\<tau> \<Turnstile> ((X::\<cdot>OclAny) .oclIsTypeOf(OclAny)) \<or> (\<tau> \<Turnstile> ((X::\<cdot>OclAny) .oclIsTypeOf(Galaxy)) \<or> \<tau> \<Turnstile> ((X::\<cdot>OclAny) .oclIsTypeOf(Planet))))"
  using actual_eq_static\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y[OF isdef]
  apply(simp only: OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny)
  apply(erule foundation26[OF OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny_defined'[OF isdef], OF OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny_defined'[OF isdef]])
  apply(simp)
  apply(simp only: OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny)
  apply(erule foundation26[OF OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny_defined'[OF isdef], OF OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny_defined'[OF isdef]])
  apply(simp)
  apply(simp only: OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny)
  apply(erule foundation26[OF OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny_defined'[OF isdef], OF OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny_defined'[OF isdef]])
  apply(simp)
  apply(simp add: iskin)
done 
lemma not_OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_then_Galaxy_OclIsTypeOf_others : 
assumes iskin: "\<not> \<tau> \<Turnstile> ((X::\<cdot>Galaxy) .oclIsKindOf(Planet))"
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> ((X::\<cdot>Galaxy) .oclIsTypeOf(Galaxy))"
  using actual_eq_static\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y[OF isdef]
  apply(simp only: OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy)
  apply(erule foundation26[OF OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy_defined'[OF isdef], OF OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy_defined'[OF isdef]])
  apply(simp)
  apply(simp add: iskin)
done 
lemma not_OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_then_OclAny_OclIsTypeOf_others : 
assumes iskin: "\<not> \<tau> \<Turnstile> ((X::\<cdot>OclAny) .oclIsKindOf(Planet))"
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "(\<tau> \<Turnstile> ((X::\<cdot>OclAny) .oclIsTypeOf(OclAny)) \<or> \<tau> \<Turnstile> ((X::\<cdot>OclAny) .oclIsTypeOf(Galaxy)))"
  using actual_eq_static\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y[OF isdef]
  apply(simp only: OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny)
  apply(erule foundation26[OF OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny_defined'[OF isdef], OF OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny_defined'[OF isdef]])
  apply(simp)
  apply(simp only: OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny)
  apply(erule foundation26[OF OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny_defined'[OF isdef], OF OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny_defined'[OF isdef]])
  apply(simp)
  apply(simp add: iskin)
done 
lemma not_OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_then_OclAny_OclIsTypeOf_others : 
assumes iskin: "\<not> \<tau> \<Turnstile> ((X::\<cdot>OclAny) .oclIsKindOf(Galaxy))"
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> ((X::\<cdot>OclAny) .oclIsTypeOf(OclAny))"
  using actual_eq_static\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y[OF isdef]
  apply(simp only: OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny)
  apply(erule foundation26[OF OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny_defined'[OF isdef], OF OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny_defined'[OF isdef]])
  apply(simp)
  apply(simp add: iskin)
done 

(* 92 ************************************ 585 + 10 *)
lemma down_cast_kind\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_from_Planet_to_Person : 
assumes iskin: "\<not> \<tau> \<Turnstile> ((X::\<cdot>Planet) .oclIsKindOf(Person))"
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> (X .oclAsType(Person)) \<triangleq> invalid"
  apply(insert not_OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_then_Planet_OclIsTypeOf_others[OF iskin, OF isdef])
  apply(rule down_cast_type\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_from_Planet_to_Person, simp only: , simp only: isdef)
done 
lemma down_cast_kind\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_from_Galaxy_to_Person : 
assumes iskin: "\<not> \<tau> \<Turnstile> ((X::\<cdot>Galaxy) .oclIsKindOf(Person))"
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> (X .oclAsType(Person)) \<triangleq> invalid"
  apply(insert not_OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_then_Galaxy_OclIsTypeOf_others[OF iskin, OF isdef], elim disjE)
  apply(rule down_cast_type\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_from_Galaxy_to_Person, simp only: , simp only: isdef)
  apply(rule down_cast_type\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_from_Galaxy_to_Person, simp only: , simp only: isdef)
done 
lemma down_cast_kind\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_from_OclAny_to_Person : 
assumes iskin: "\<not> \<tau> \<Turnstile> ((X::\<cdot>OclAny) .oclIsKindOf(Person))"
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> (X .oclAsType(Person)) \<triangleq> invalid"
  apply(insert not_OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_then_OclAny_OclIsTypeOf_others[OF iskin, OF isdef], elim disjE)
  apply(rule down_cast_type\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_from_OclAny_to_Person, simp only: , simp only: isdef)
  apply(rule down_cast_type\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_from_OclAny_to_Person, simp only: , simp only: isdef)
  apply(rule down_cast_type\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_from_OclAny_to_Person, simp only: , simp only: isdef)
done 
lemma down_cast_kind\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_from_Galaxy_to_Planet : 
assumes iskin: "\<not> \<tau> \<Turnstile> ((X::\<cdot>Galaxy) .oclIsKindOf(Planet))"
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> (X .oclAsType(Planet)) \<triangleq> invalid"
  apply(insert not_OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_then_Galaxy_OclIsTypeOf_others[OF iskin, OF isdef])
  apply(rule down_cast_type\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_from_Galaxy_to_Planet, simp only: , simp only: isdef)
done 
lemma down_cast_kind\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_from_Galaxy_to_Person : 
assumes iskin: "\<not> \<tau> \<Turnstile> ((X::\<cdot>Galaxy) .oclIsKindOf(Planet))"
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> (X .oclAsType(Person)) \<triangleq> invalid"
  apply(insert not_OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_then_Galaxy_OclIsTypeOf_others[OF iskin, OF isdef])
  apply(rule down_cast_type\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_from_Galaxy_to_Person, simp only: , simp only: isdef)
done 
lemma down_cast_kind\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_from_OclAny_to_Planet : 
assumes iskin: "\<not> \<tau> \<Turnstile> ((X::\<cdot>OclAny) .oclIsKindOf(Planet))"
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> (X .oclAsType(Planet)) \<triangleq> invalid"
  apply(insert not_OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_then_OclAny_OclIsTypeOf_others[OF iskin, OF isdef], elim disjE)
  apply(rule down_cast_type\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_from_OclAny_to_Planet, simp only: , simp only: isdef)
  apply(rule down_cast_type\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_from_OclAny_to_Planet, simp only: , simp only: isdef)
done 
lemma down_cast_kind\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_from_OclAny_to_Person : 
assumes iskin: "\<not> \<tau> \<Turnstile> ((X::\<cdot>OclAny) .oclIsKindOf(Planet))"
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> (X .oclAsType(Person)) \<triangleq> invalid"
  apply(insert not_OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_then_OclAny_OclIsTypeOf_others[OF iskin, OF isdef], elim disjE)
  apply(rule down_cast_type\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_from_OclAny_to_Person, simp only: , simp only: isdef)
  apply(rule down_cast_type\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_from_OclAny_to_Person, simp only: , simp only: isdef)
done 
lemma down_cast_kind\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_from_OclAny_to_Galaxy : 
assumes iskin: "\<not> \<tau> \<Turnstile> ((X::\<cdot>OclAny) .oclIsKindOf(Galaxy))"
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> (X .oclAsType(Galaxy)) \<triangleq> invalid"
  apply(insert not_OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_then_OclAny_OclIsTypeOf_others[OF iskin, OF isdef])
  apply(rule down_cast_type\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_from_OclAny_to_Galaxy, simp only: , simp only: isdef)
done 
lemma down_cast_kind\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_from_OclAny_to_Person : 
assumes iskin: "\<not> \<tau> \<Turnstile> ((X::\<cdot>OclAny) .oclIsKindOf(Galaxy))"
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> (X .oclAsType(Person)) \<triangleq> invalid"
  apply(insert not_OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_then_OclAny_OclIsTypeOf_others[OF iskin, OF isdef])
  apply(rule down_cast_type\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_from_OclAny_to_Person, simp only: , simp only: isdef)
done 
lemma down_cast_kind\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_from_OclAny_to_Planet : 
assumes iskin: "\<not> \<tau> \<Turnstile> ((X::\<cdot>OclAny) .oclIsKindOf(Galaxy))"
assumes isdef: "\<tau> \<Turnstile> (\<delta> (X))"
shows "\<tau> \<Turnstile> (X .oclAsType(Planet)) \<triangleq> invalid"
  apply(insert not_OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_then_OclAny_OclIsTypeOf_others[OF iskin, OF isdef])
  apply(rule down_cast_type\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_from_OclAny_to_Planet, simp only: , simp only: isdef)
done 

(* 93 ************************************ 595 + 1 *)
subsection{* Const *}

(* 94 ************************************ 596 + 1 *)
section{* OclAllInstances *}

(* 95 ************************************ 597 + 1 *)
text{* 
   To denote OCL-types occuring in OCL expressions syntactically---as, for example,  as
``argument'' of \inlineisar{oclAllInstances()}---we use the inverses of the injection
functions into the object universes; we show that this is sufficient ``characterization.''  *}

(* 96 ************************************ 598 + 4 *)
definition "Person = OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_\<AA>"
definition "Planet = OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_\<AA>"
definition "Galaxy = OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_\<AA>"
definition "OclAny = OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_\<AA>"

(* 97 ************************************ 602 + 1 *)
lemmas[simp,code_unfold] = Person_def
                            Planet_def
                            Galaxy_def
                            OclAny_def

(* 98 ************************************ 603 + 1 *)
lemma OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_\<AA>_some : "(OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_\<AA> (x)) \<noteq> None"
by(simp add: OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_\<AA>_def)

(* 99 ************************************ 604 + 3 *)
lemma OclAllInstances_generic\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_exec : 
shows "(OclAllInstances_generic (pre_post) (OclAny)) = (\<lambda>\<tau>. (Abs_Set\<^sub>b\<^sub>a\<^sub>s\<^sub>e (\<lfloor>\<lfloor>Some ` OclAny ` (ran ((heap ((pre_post (\<tau>))))))\<rfloor>\<rfloor>)))"
  proof - let ?S1 = "(\<lambda>\<tau>. OclAny ` (ran ((heap ((pre_post (\<tau>)))))))" show ?thesis
  proof - let ?S2 = "(\<lambda>\<tau>. ((?S1) (\<tau>)) - {None})" show ?thesis
  proof - have B: "(\<And>\<tau>. ((?S2) (\<tau>)) \<subseteq> ((?S1) (\<tau>)))" by(auto) show ?thesis
  proof - have C: "(\<And>\<tau>. ((?S1) (\<tau>)) \<subseteq> ((?S2) (\<tau>)))" by(auto simp: OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_\<AA>_some) show ?thesis
  apply(simp add: OclValid_def del: OclAllInstances_generic_def OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny)
by(insert equalityI[OF B, OF C], simp) qed qed qed qed
lemma OclAllInstances_at_post\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_exec : 
shows "(OclAllInstances_at_post (OclAny)) = (\<lambda>\<tau>. (Abs_Set\<^sub>b\<^sub>a\<^sub>s\<^sub>e (\<lfloor>\<lfloor>Some ` OclAny ` (ran ((heap ((snd (\<tau>))))))\<rfloor>\<rfloor>)))"
  unfolding OclAllInstances_at_post_def
by(rule OclAllInstances_generic\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_exec) 
lemma OclAllInstances_at_pre\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_exec : 
shows "(OclAllInstances_at_pre (OclAny)) = (\<lambda>\<tau>. (Abs_Set\<^sub>b\<^sub>a\<^sub>s\<^sub>e (\<lfloor>\<lfloor>Some ` OclAny ` (ran ((heap ((fst (\<tau>))))))\<rfloor>\<rfloor>)))"
  unfolding OclAllInstances_at_pre_def
by(rule OclAllInstances_generic\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_exec) 

(* 100 ************************************ 607 + 1 *)
subsection{* OclIsTypeOf *}

(* 101 ************************************ 608 + 2 *)
lemma ex_ssubst : "(\<forall>x \<in> B. (s (x)) = (t (x))) \<Longrightarrow> (\<exists>x \<in> B. (P ((s (x))))) = (\<exists>x \<in> B. (P ((t (x)))))"
by(simp)
lemma ex_def : "x \<in> \<lceil>\<lceil>\<lfloor>\<lfloor>Some ` (X - {None})\<rfloor>\<rfloor>\<rceil>\<rceil> \<Longrightarrow> (\<exists>y. x = \<lfloor>\<lfloor>y\<rfloor>\<rfloor>)"
by(auto)

(* 102 ************************************ 610 + 21 *)
lemma Person_OclAllInstances_generic_OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n : "\<tau> \<Turnstile> (UML_Set.OclForall ((OclAllInstances_generic (pre_post) (Person))) (OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))"
  apply(simp add: OclValid_def del: OclAllInstances_generic_def)
  apply(simp only: UML_Set.OclForall_def refl if_True OclAllInstances_generic_defined[simplified OclValid_def])
  apply(simp only: OclAllInstances_generic_def)
  apply(subst (1 2 3) Abs_Set\<^sub>b\<^sub>a\<^sub>s\<^sub>e_inverse, simp add: bot_option_def)
  apply(subst (1 2 3) ex_ssubst[where s = "(\<lambda>x. (((\<lambda>_. x) .oclIsTypeOf(Person)) (\<tau>)))" and t = "(\<lambda>_. (true (\<tau>)))"])
  apply(intro ballI actual_eq_static\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n[simplified OclValid_def, simplified OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person])
  apply(drule ex_def, erule exE, simp)
by(simp)
lemma Person_OclAllInstances_at_post_OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n : 
shows "\<tau> \<Turnstile> (UML_Set.OclForall ((OclAllInstances_at_post (Person))) (OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))"
  unfolding OclAllInstances_at_post_def
by(rule Person_OclAllInstances_generic_OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n) 
lemma Person_OclAllInstances_at_pre_OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n : 
shows "\<tau> \<Turnstile> (UML_Set.OclForall ((OclAllInstances_at_pre (Person))) (OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))"
  unfolding OclAllInstances_at_pre_def
by(rule Person_OclAllInstances_generic_OclIsTypeOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n) 
lemma Planet_OclAllInstances_generic_OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t1 : 
assumes [simp]: "(\<And>x. (pre_post ((x , x))) = x)"
shows "(\<exists>\<tau>. \<tau> \<Turnstile> (UML_Set.OclForall ((OclAllInstances_generic (pre_post) (Planet))) (OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t)))"
  apply(rule exI[where x = "\<tau>\<^sub>0"], simp add: \<tau>\<^sub>0_def OclValid_def del: OclAllInstances_generic_def)
  apply(simp only: UML_Set.OclForall_def refl if_True OclAllInstances_generic_defined[simplified OclValid_def])
  apply(simp only: OclAllInstances_generic_def)
  apply(subst (1 2 3) Abs_Set\<^sub>b\<^sub>a\<^sub>s\<^sub>e_inverse, simp add: bot_option_def)
by(simp) 
lemma Planet_OclAllInstances_at_post_OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t1 : 
shows "(\<exists>\<tau>. \<tau> \<Turnstile> (UML_Set.OclForall ((OclAllInstances_at_post (Planet))) (OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t)))"
  unfolding OclAllInstances_at_post_def
by(rule Planet_OclAllInstances_generic_OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t1, simp) 
lemma Planet_OclAllInstances_at_pre_OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t1 : 
shows "(\<exists>\<tau>. \<tau> \<Turnstile> (UML_Set.OclForall ((OclAllInstances_at_pre (Planet))) (OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t)))"
  unfolding OclAllInstances_at_pre_def
by(rule Planet_OclAllInstances_generic_OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t1, simp) 
lemma Planet_OclAllInstances_generic_OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t2 : 
assumes [simp]: "(\<And>x. (pre_post ((x , x))) = x)"
shows "(\<exists>\<tau>. \<tau> \<Turnstile> (not ((UML_Set.OclForall ((OclAllInstances_generic (pre_post) (Planet))) (OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t)))))"
  proof - fix oid a show ?thesis
  proof - let ?t0 = "(state.make ((Map.empty (oid \<mapsto> (in\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t ((mk\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t ((mk\<E>\<X>\<T>\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (a))) (None) (None))))))) (Map.empty))" show ?thesis
  apply(rule exI[where x = "(?t0 , ?t0)"], simp add: OclValid_def del: OclAllInstances_generic_def)
  apply(simp only: UML_Set.OclForall_def refl if_True OclAllInstances_generic_defined[simplified OclValid_def])
  apply(simp only: OclAllInstances_generic_def OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_\<AA>_def)
  apply(subst (1 2 3) Abs_Set\<^sub>b\<^sub>a\<^sub>s\<^sub>e_inverse, simp add: bot_option_def)
by(simp add: state.make_def OclNot_def) qed qed
lemma Planet_OclAllInstances_at_post_OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t2 : 
shows "(\<exists>\<tau>. \<tau> \<Turnstile> (not ((UML_Set.OclForall ((OclAllInstances_at_post (Planet))) (OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t)))))"
  unfolding OclAllInstances_at_post_def
by(rule Planet_OclAllInstances_generic_OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t2, simp) 
lemma Planet_OclAllInstances_at_pre_OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t2 : 
shows "(\<exists>\<tau>. \<tau> \<Turnstile> (not ((UML_Set.OclForall ((OclAllInstances_at_pre (Planet))) (OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t)))))"
  unfolding OclAllInstances_at_pre_def
by(rule Planet_OclAllInstances_generic_OclIsTypeOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t2, simp) 
lemma Galaxy_OclAllInstances_generic_OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y1 : 
assumes [simp]: "(\<And>x. (pre_post ((x , x))) = x)"
shows "(\<exists>\<tau>. \<tau> \<Turnstile> (UML_Set.OclForall ((OclAllInstances_generic (pre_post) (Galaxy))) (OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y)))"
  apply(rule exI[where x = "\<tau>\<^sub>0"], simp add: \<tau>\<^sub>0_def OclValid_def del: OclAllInstances_generic_def)
  apply(simp only: UML_Set.OclForall_def refl if_True OclAllInstances_generic_defined[simplified OclValid_def])
  apply(simp only: OclAllInstances_generic_def)
  apply(subst (1 2 3) Abs_Set\<^sub>b\<^sub>a\<^sub>s\<^sub>e_inverse, simp add: bot_option_def)
by(simp) 
lemma Galaxy_OclAllInstances_at_post_OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y1 : 
shows "(\<exists>\<tau>. \<tau> \<Turnstile> (UML_Set.OclForall ((OclAllInstances_at_post (Galaxy))) (OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y)))"
  unfolding OclAllInstances_at_post_def
by(rule Galaxy_OclAllInstances_generic_OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y1, simp) 
lemma Galaxy_OclAllInstances_at_pre_OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y1 : 
shows "(\<exists>\<tau>. \<tau> \<Turnstile> (UML_Set.OclForall ((OclAllInstances_at_pre (Galaxy))) (OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y)))"
  unfolding OclAllInstances_at_pre_def
by(rule Galaxy_OclAllInstances_generic_OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y1, simp) 
lemma Galaxy_OclAllInstances_generic_OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y2 : 
assumes [simp]: "(\<And>x. (pre_post ((x , x))) = x)"
shows "(\<exists>\<tau>. \<tau> \<Turnstile> (not ((UML_Set.OclForall ((OclAllInstances_generic (pre_post) (Galaxy))) (OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y)))))"
  proof - fix oid a show ?thesis
  proof - let ?t0 = "(state.make ((Map.empty (oid \<mapsto> (in\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y ((mk\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y ((mk\<E>\<X>\<T>\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t (a))) (None) (None) (None))))))) (Map.empty))" show ?thesis
  apply(rule exI[where x = "(?t0 , ?t0)"], simp add: OclValid_def del: OclAllInstances_generic_def)
  apply(simp only: UML_Set.OclForall_def refl if_True OclAllInstances_generic_defined[simplified OclValid_def])
  apply(simp only: OclAllInstances_generic_def OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_\<AA>_def)
  apply(subst (1 2 3) Abs_Set\<^sub>b\<^sub>a\<^sub>s\<^sub>e_inverse, simp add: bot_option_def)
by(simp add: state.make_def OclNot_def) qed qed
lemma Galaxy_OclAllInstances_at_post_OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y2 : 
shows "(\<exists>\<tau>. \<tau> \<Turnstile> (not ((UML_Set.OclForall ((OclAllInstances_at_post (Galaxy))) (OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y)))))"
  unfolding OclAllInstances_at_post_def
by(rule Galaxy_OclAllInstances_generic_OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y2, simp) 
lemma Galaxy_OclAllInstances_at_pre_OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y2 : 
shows "(\<exists>\<tau>. \<tau> \<Turnstile> (not ((UML_Set.OclForall ((OclAllInstances_at_pre (Galaxy))) (OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y)))))"
  unfolding OclAllInstances_at_pre_def
by(rule Galaxy_OclAllInstances_generic_OclIsTypeOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y2, simp) 
lemma OclAny_OclAllInstances_generic_OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y1 : 
assumes [simp]: "(\<And>x. (pre_post ((x , x))) = x)"
shows "(\<exists>\<tau>. \<tau> \<Turnstile> (UML_Set.OclForall ((OclAllInstances_generic (pre_post) (OclAny))) (OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y)))"
  apply(rule exI[where x = "\<tau>\<^sub>0"], simp add: \<tau>\<^sub>0_def OclValid_def del: OclAllInstances_generic_def)
  apply(simp only: UML_Set.OclForall_def refl if_True OclAllInstances_generic_defined[simplified OclValid_def])
  apply(simp only: OclAllInstances_generic_def)
  apply(subst (1 2 3) Abs_Set\<^sub>b\<^sub>a\<^sub>s\<^sub>e_inverse, simp add: bot_option_def)
by(simp) 
lemma OclAny_OclAllInstances_at_post_OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y1 : 
shows "(\<exists>\<tau>. \<tau> \<Turnstile> (UML_Set.OclForall ((OclAllInstances_at_post (OclAny))) (OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y)))"
  unfolding OclAllInstances_at_post_def
by(rule OclAny_OclAllInstances_generic_OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y1, simp) 
lemma OclAny_OclAllInstances_at_pre_OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y1 : 
shows "(\<exists>\<tau>. \<tau> \<Turnstile> (UML_Set.OclForall ((OclAllInstances_at_pre (OclAny))) (OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y)))"
  unfolding OclAllInstances_at_pre_def
by(rule OclAny_OclAllInstances_generic_OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y1, simp) 
lemma OclAny_OclAllInstances_generic_OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y2 : 
assumes [simp]: "(\<And>x. (pre_post ((x , x))) = x)"
shows "(\<exists>\<tau>. \<tau> \<Turnstile> (not ((UML_Set.OclForall ((OclAllInstances_generic (pre_post) (OclAny))) (OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y)))))"
  proof - fix oid a show ?thesis
  proof - let ?t0 = "(state.make ((Map.empty (oid \<mapsto> (in\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y ((mk\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y ((mk\<E>\<X>\<T>\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y (a))))))))) (Map.empty))" show ?thesis
  apply(rule exI[where x = "(?t0 , ?t0)"], simp add: OclValid_def del: OclAllInstances_generic_def)
  apply(simp only: UML_Set.OclForall_def refl if_True OclAllInstances_generic_defined[simplified OclValid_def])
  apply(simp only: OclAllInstances_generic_def OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_\<AA>_def)
  apply(subst (1 2 3) Abs_Set\<^sub>b\<^sub>a\<^sub>s\<^sub>e_inverse, simp add: bot_option_def)
by(simp add: state.make_def OclNot_def) qed qed
lemma OclAny_OclAllInstances_at_post_OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y2 : 
shows "(\<exists>\<tau>. \<tau> \<Turnstile> (not ((UML_Set.OclForall ((OclAllInstances_at_post (OclAny))) (OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y)))))"
  unfolding OclAllInstances_at_post_def
by(rule OclAny_OclAllInstances_generic_OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y2, simp) 
lemma OclAny_OclAllInstances_at_pre_OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y2 : 
shows "(\<exists>\<tau>. \<tau> \<Turnstile> (not ((UML_Set.OclForall ((OclAllInstances_at_pre (OclAny))) (OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y)))))"
  unfolding OclAllInstances_at_pre_def
by(rule OclAny_OclAllInstances_generic_OclIsTypeOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y2, simp) 

(* 103 ************************************ 631 + 1 *)
subsection{* OclIsKindOf *}

(* 104 ************************************ 632 + 12 *)
lemma Person_OclAllInstances_generic_OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n : "\<tau> \<Turnstile> (UML_Set.OclForall ((OclAllInstances_generic (pre_post) (Person))) (OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))"
  apply(simp add: OclValid_def del: OclAllInstances_generic_def OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Person)
  apply(simp only: UML_Set.OclForall_def refl if_True OclAllInstances_generic_defined[simplified OclValid_def])
  apply(simp only: OclAllInstances_generic_def)
  apply(subst (1 2 3) Abs_Set\<^sub>b\<^sub>a\<^sub>s\<^sub>e_inverse, simp add: bot_option_def)
  apply(subst (1 2 3) ex_ssubst[where s = "(\<lambda>x. (((\<lambda>_. x) .oclIsKindOf(Person)) (\<tau>)))" and t = "(\<lambda>_. (true (\<tau>)))"])
  apply(intro ballI actual_eq_static\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n[simplified OclValid_def])
  apply(drule ex_def, erule exE, simp)
by(simp)
lemma Person_OclAllInstances_at_post_OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n : 
shows "\<tau> \<Turnstile> (UML_Set.OclForall ((OclAllInstances_at_post (Person))) (OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))"
  unfolding OclAllInstances_at_post_def
by(rule Person_OclAllInstances_generic_OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n) 
lemma Person_OclAllInstances_at_pre_OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n : 
shows "\<tau> \<Turnstile> (UML_Set.OclForall ((OclAllInstances_at_pre (Person))) (OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))"
  unfolding OclAllInstances_at_pre_def
by(rule Person_OclAllInstances_generic_OclIsKindOf\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n) 
lemma Planet_OclAllInstances_generic_OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t : "\<tau> \<Turnstile> (UML_Set.OclForall ((OclAllInstances_generic (pre_post) (Planet))) (OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t))"
  apply(simp add: OclValid_def del: OclAllInstances_generic_def OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Planet)
  apply(simp only: UML_Set.OclForall_def refl if_True OclAllInstances_generic_defined[simplified OclValid_def])
  apply(simp only: OclAllInstances_generic_def)
  apply(subst (1 2 3) Abs_Set\<^sub>b\<^sub>a\<^sub>s\<^sub>e_inverse, simp add: bot_option_def)
  apply(subst (1 2 3) ex_ssubst[where s = "(\<lambda>x. (((\<lambda>_. x) .oclIsKindOf(Planet)) (\<tau>)))" and t = "(\<lambda>_. (true (\<tau>)))"])
  apply(intro ballI actual_eq_static\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t[simplified OclValid_def])
  apply(drule ex_def, erule exE, simp)
by(simp)
lemma Planet_OclAllInstances_at_post_OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t : 
shows "\<tau> \<Turnstile> (UML_Set.OclForall ((OclAllInstances_at_post (Planet))) (OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t))"
  unfolding OclAllInstances_at_post_def
by(rule Planet_OclAllInstances_generic_OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t) 
lemma Planet_OclAllInstances_at_pre_OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t : 
shows "\<tau> \<Turnstile> (UML_Set.OclForall ((OclAllInstances_at_pre (Planet))) (OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t))"
  unfolding OclAllInstances_at_pre_def
by(rule Planet_OclAllInstances_generic_OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t) 
lemma Galaxy_OclAllInstances_generic_OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y : "\<tau> \<Turnstile> (UML_Set.OclForall ((OclAllInstances_generic (pre_post) (Galaxy))) (OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y))"
  apply(simp add: OclValid_def del: OclAllInstances_generic_def OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Galaxy)
  apply(simp only: UML_Set.OclForall_def refl if_True OclAllInstances_generic_defined[simplified OclValid_def])
  apply(simp only: OclAllInstances_generic_def)
  apply(subst (1 2 3) Abs_Set\<^sub>b\<^sub>a\<^sub>s\<^sub>e_inverse, simp add: bot_option_def)
  apply(subst (1 2 3) ex_ssubst[where s = "(\<lambda>x. (((\<lambda>_. x) .oclIsKindOf(Galaxy)) (\<tau>)))" and t = "(\<lambda>_. (true (\<tau>)))"])
  apply(intro ballI actual_eq_static\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y[simplified OclValid_def])
  apply(drule ex_def, erule exE, simp)
by(simp)
lemma Galaxy_OclAllInstances_at_post_OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y : 
shows "\<tau> \<Turnstile> (UML_Set.OclForall ((OclAllInstances_at_post (Galaxy))) (OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y))"
  unfolding OclAllInstances_at_post_def
by(rule Galaxy_OclAllInstances_generic_OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y) 
lemma Galaxy_OclAllInstances_at_pre_OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y : 
shows "\<tau> \<Turnstile> (UML_Set.OclForall ((OclAllInstances_at_pre (Galaxy))) (OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y))"
  unfolding OclAllInstances_at_pre_def
by(rule Galaxy_OclAllInstances_generic_OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y) 
lemma OclAny_OclAllInstances_generic_OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y : "\<tau> \<Turnstile> (UML_Set.OclForall ((OclAllInstances_generic (pre_post) (OclAny))) (OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y))"
  apply(simp add: OclValid_def del: OclAllInstances_generic_def OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_OclAny)
  apply(simp only: UML_Set.OclForall_def refl if_True OclAllInstances_generic_defined[simplified OclValid_def])
  apply(simp only: OclAllInstances_generic_def)
  apply(subst (1 2 3) Abs_Set\<^sub>b\<^sub>a\<^sub>s\<^sub>e_inverse, simp add: bot_option_def)
  apply(subst (1 2 3) ex_ssubst[where s = "(\<lambda>x. (((\<lambda>_. x) .oclIsKindOf(OclAny)) (\<tau>)))" and t = "(\<lambda>_. (true (\<tau>)))"])
  apply(intro ballI actual_eq_static\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y[simplified OclValid_def])
  apply(drule ex_def, erule exE, simp)
by(simp)
lemma OclAny_OclAllInstances_at_post_OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y : 
shows "\<tau> \<Turnstile> (UML_Set.OclForall ((OclAllInstances_at_post (OclAny))) (OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y))"
  unfolding OclAllInstances_at_post_def
by(rule OclAny_OclAllInstances_generic_OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y) 
lemma OclAny_OclAllInstances_at_pre_OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y : 
shows "\<tau> \<Turnstile> (UML_Set.OclForall ((OclAllInstances_at_pre (OclAny))) (OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y))"
  unfolding OclAllInstances_at_pre_def
by(rule OclAny_OclAllInstances_generic_OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y) 

(* 105 ************************************ 644 + 18 *)
lemma Person_OclAllInstances_generic_OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t : "\<tau> \<Turnstile> (UML_Set.OclForall ((OclAllInstances_generic (pre_post) (Person))) (OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t))"
  apply(simp add: OclValid_def del: OclAllInstances_generic_def OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person)
  apply(simp only: UML_Set.OclForall_def refl if_True OclAllInstances_generic_defined[simplified OclValid_def])
  apply(simp only: OclAllInstances_generic_def)
  apply(subst (1 2 3) Abs_Set\<^sub>b\<^sub>a\<^sub>s\<^sub>e_inverse, simp add: bot_option_def)
  apply(subst (1 2 3) ex_ssubst[where s = "(\<lambda>x. (((\<lambda>_. x) .oclIsKindOf(Planet)) (\<tau>)))" and t = "(\<lambda>_. (true (\<tau>)))"])
  apply(intro ballI actualKind\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_larger_staticKind\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t[simplified OclValid_def])
  apply(drule ex_def, erule exE, simp)
by(simp)
lemma Person_OclAllInstances_at_post_OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t : 
shows "\<tau> \<Turnstile> (UML_Set.OclForall ((OclAllInstances_at_post (Person))) (OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t))"
  unfolding OclAllInstances_at_post_def
by(rule Person_OclAllInstances_generic_OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t) 
lemma Person_OclAllInstances_at_pre_OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t : 
shows "\<tau> \<Turnstile> (UML_Set.OclForall ((OclAllInstances_at_pre (Person))) (OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t))"
  unfolding OclAllInstances_at_pre_def
by(rule Person_OclAllInstances_generic_OclIsKindOf\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t) 
lemma Person_OclAllInstances_generic_OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y : "\<tau> \<Turnstile> (UML_Set.OclForall ((OclAllInstances_generic (pre_post) (Person))) (OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y))"
  apply(simp add: OclValid_def del: OclAllInstances_generic_def OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person)
  apply(simp only: UML_Set.OclForall_def refl if_True OclAllInstances_generic_defined[simplified OclValid_def])
  apply(simp only: OclAllInstances_generic_def)
  apply(subst (1 2 3) Abs_Set\<^sub>b\<^sub>a\<^sub>s\<^sub>e_inverse, simp add: bot_option_def)
  apply(subst (1 2 3) ex_ssubst[where s = "(\<lambda>x. (((\<lambda>_. x) .oclIsKindOf(Galaxy)) (\<tau>)))" and t = "(\<lambda>_. (true (\<tau>)))"])
  apply(intro ballI actualKind\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_larger_staticKind\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y[simplified OclValid_def])
  apply(drule ex_def, erule exE, simp)
by(simp)
lemma Person_OclAllInstances_at_post_OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y : 
shows "\<tau> \<Turnstile> (UML_Set.OclForall ((OclAllInstances_at_post (Person))) (OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y))"
  unfolding OclAllInstances_at_post_def
by(rule Person_OclAllInstances_generic_OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y) 
lemma Person_OclAllInstances_at_pre_OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y : 
shows "\<tau> \<Turnstile> (UML_Set.OclForall ((OclAllInstances_at_pre (Person))) (OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y))"
  unfolding OclAllInstances_at_pre_def
by(rule Person_OclAllInstances_generic_OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y) 
lemma Person_OclAllInstances_generic_OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y : "\<tau> \<Turnstile> (UML_Set.OclForall ((OclAllInstances_generic (pre_post) (Person))) (OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y))"
  apply(simp add: OclValid_def del: OclAllInstances_generic_def OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person)
  apply(simp only: UML_Set.OclForall_def refl if_True OclAllInstances_generic_defined[simplified OclValid_def])
  apply(simp only: OclAllInstances_generic_def)
  apply(subst (1 2 3) Abs_Set\<^sub>b\<^sub>a\<^sub>s\<^sub>e_inverse, simp add: bot_option_def)
  apply(subst (1 2 3) ex_ssubst[where s = "(\<lambda>x. (((\<lambda>_. x) .oclIsKindOf(OclAny)) (\<tau>)))" and t = "(\<lambda>_. (true (\<tau>)))"])
  apply(intro ballI actualKind\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_larger_staticKind\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y[simplified OclValid_def])
  apply(drule ex_def, erule exE, simp)
by(simp)
lemma Person_OclAllInstances_at_post_OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y : 
shows "\<tau> \<Turnstile> (UML_Set.OclForall ((OclAllInstances_at_post (Person))) (OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y))"
  unfolding OclAllInstances_at_post_def
by(rule Person_OclAllInstances_generic_OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y) 
lemma Person_OclAllInstances_at_pre_OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y : 
shows "\<tau> \<Turnstile> (UML_Set.OclForall ((OclAllInstances_at_pre (Person))) (OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y))"
  unfolding OclAllInstances_at_pre_def
by(rule Person_OclAllInstances_generic_OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y) 
lemma Planet_OclAllInstances_generic_OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y : "\<tau> \<Turnstile> (UML_Set.OclForall ((OclAllInstances_generic (pre_post) (Planet))) (OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y))"
  apply(simp add: OclValid_def del: OclAllInstances_generic_def OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet)
  apply(simp only: UML_Set.OclForall_def refl if_True OclAllInstances_generic_defined[simplified OclValid_def])
  apply(simp only: OclAllInstances_generic_def)
  apply(subst (1 2 3) Abs_Set\<^sub>b\<^sub>a\<^sub>s\<^sub>e_inverse, simp add: bot_option_def)
  apply(subst (1 2 3) ex_ssubst[where s = "(\<lambda>x. (((\<lambda>_. x) .oclIsKindOf(Galaxy)) (\<tau>)))" and t = "(\<lambda>_. (true (\<tau>)))"])
  apply(intro ballI actualKind\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_larger_staticKind\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y[simplified OclValid_def])
  apply(drule ex_def, erule exE, simp)
by(simp)
lemma Planet_OclAllInstances_at_post_OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y : 
shows "\<tau> \<Turnstile> (UML_Set.OclForall ((OclAllInstances_at_post (Planet))) (OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y))"
  unfolding OclAllInstances_at_post_def
by(rule Planet_OclAllInstances_generic_OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y) 
lemma Planet_OclAllInstances_at_pre_OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y : 
shows "\<tau> \<Turnstile> (UML_Set.OclForall ((OclAllInstances_at_pre (Planet))) (OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y))"
  unfolding OclAllInstances_at_pre_def
by(rule Planet_OclAllInstances_generic_OclIsKindOf\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y) 
lemma Planet_OclAllInstances_generic_OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y : "\<tau> \<Turnstile> (UML_Set.OclForall ((OclAllInstances_generic (pre_post) (Planet))) (OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y))"
  apply(simp add: OclValid_def del: OclAllInstances_generic_def OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet)
  apply(simp only: UML_Set.OclForall_def refl if_True OclAllInstances_generic_defined[simplified OclValid_def])
  apply(simp only: OclAllInstances_generic_def)
  apply(subst (1 2 3) Abs_Set\<^sub>b\<^sub>a\<^sub>s\<^sub>e_inverse, simp add: bot_option_def)
  apply(subst (1 2 3) ex_ssubst[where s = "(\<lambda>x. (((\<lambda>_. x) .oclIsKindOf(OclAny)) (\<tau>)))" and t = "(\<lambda>_. (true (\<tau>)))"])
  apply(intro ballI actualKind\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_larger_staticKind\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y[simplified OclValid_def])
  apply(drule ex_def, erule exE, simp)
by(simp)
lemma Planet_OclAllInstances_at_post_OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y : 
shows "\<tau> \<Turnstile> (UML_Set.OclForall ((OclAllInstances_at_post (Planet))) (OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y))"
  unfolding OclAllInstances_at_post_def
by(rule Planet_OclAllInstances_generic_OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y) 
lemma Planet_OclAllInstances_at_pre_OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y : 
shows "\<tau> \<Turnstile> (UML_Set.OclForall ((OclAllInstances_at_pre (Planet))) (OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y))"
  unfolding OclAllInstances_at_pre_def
by(rule Planet_OclAllInstances_generic_OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y) 
lemma Galaxy_OclAllInstances_generic_OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y : "\<tau> \<Turnstile> (UML_Set.OclForall ((OclAllInstances_generic (pre_post) (Galaxy))) (OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y))"
  apply(simp add: OclValid_def del: OclAllInstances_generic_def OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy)
  apply(simp only: UML_Set.OclForall_def refl if_True OclAllInstances_generic_defined[simplified OclValid_def])
  apply(simp only: OclAllInstances_generic_def)
  apply(subst (1 2 3) Abs_Set\<^sub>b\<^sub>a\<^sub>s\<^sub>e_inverse, simp add: bot_option_def)
  apply(subst (1 2 3) ex_ssubst[where s = "(\<lambda>x. (((\<lambda>_. x) .oclIsKindOf(OclAny)) (\<tau>)))" and t = "(\<lambda>_. (true (\<tau>)))"])
  apply(intro ballI actualKind\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_larger_staticKind\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y[simplified OclValid_def])
  apply(drule ex_def, erule exE, simp)
by(simp)
lemma Galaxy_OclAllInstances_at_post_OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y : 
shows "\<tau> \<Turnstile> (UML_Set.OclForall ((OclAllInstances_at_post (Galaxy))) (OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y))"
  unfolding OclAllInstances_at_post_def
by(rule Galaxy_OclAllInstances_generic_OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y) 
lemma Galaxy_OclAllInstances_at_pre_OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y : 
shows "\<tau> \<Turnstile> (UML_Set.OclForall ((OclAllInstances_at_pre (Galaxy))) (OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y))"
  unfolding OclAllInstances_at_pre_def
by(rule Galaxy_OclAllInstances_generic_OclIsKindOf\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y) 

(* 106 ************************************ 662 + 1 *)
section{* The Accessors *}

(* 107 ************************************ 663 + 1 *)
text{*  *}

(* 108 ************************************ 664 + 1 *)
text{* 
  \label{sec:eam-accessors} *}

(* 109 ************************************ 665 + 1 *)
subsection{* Definition *}

(* 110 ************************************ 666 + 1 *)
text{* 
   We start with a oid for the association; this oid can be used
in presence of association classes to represent the association inside an object,
pretty much similar to the \inlineisar+Employee_DesignModel_UMLPart+, where we stored
an \verb+oid+ inside the class as ``pointer.''  *}

(* 111 ************************************ 667 + 1 *)
ML{* val oidPerson_0_boss = 0 *}

(* 112 ************************************ 668 + 1 *)
definition "oid\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_0_\<b>\<o>\<s>\<s> = 0"

(* 113 ************************************ 669 + 1 *)
text{* 
   From there on, we can already define an empty state which must contain
for $\mathit{oid}_{Person}\mathcal{BOSS}$ the empty relation (encoded as association list, since there are
associations with a Sequence-like structure). *}

(* 114 ************************************ 670 + 5 *)
definition "eval_extract x f = (\<lambda>\<tau>. (case x \<tau> of \<lfloor>\<lfloor>obj\<rfloor>\<rfloor> \<Rightarrow> (f ((oid_of (obj))) (\<tau>))
    | _ \<Rightarrow> invalid \<tau>))"
definition "in_pre_state = fst"
definition "in_post_state = snd"
definition "reconst_basetype = (\<lambda>x _. \<lfloor>\<lfloor>x\<rfloor>\<rfloor>)"
definition "reconst_basetype\<^sub>V\<^sub>o\<^sub>i\<^sub>d x = Abs_Void\<^sub>b\<^sub>a\<^sub>s\<^sub>e o (reconst_basetype (x))"

(* 115 ************************************ 675 + 1 *)
text{* 
   The @{text pre_post}-parameter is configured with @{text fst} or
@{text snd}, the @{text to_from}-parameter either with the identity @{term id} or
the following combinator @{text switch}:  *}

(* 116 ************************************ 676 + 2 *)
ML{* val switch2_01 = (fn [x0 , x1] => (x0 , x1)) *}
ML{* val switch2_10 = (fn [x0 , x1] => (x1 , x0)) *}

(* 117 ************************************ 678 + 3 *)
definition "switch\<^sub>2_01 = (\<lambda> [x0 , x1] \<Rightarrow> (x0 , x1))"
definition "switch\<^sub>2_10 = (\<lambda> [x0 , x1] \<Rightarrow> (x1 , x0))"
definition "deref_assocs pre_post to_from assoc_oid f oid = (\<lambda>\<tau>. (case (assocs ((pre_post (\<tau>))) (assoc_oid)) of \<lfloor>S\<rfloor> \<Rightarrow> (f ((deref_assocs_list (to_from) (oid) (S))) (\<tau>))
    | _ \<Rightarrow> (invalid (\<tau>))))"

(* 118 ************************************ 681 + 4 *)
definition "deref_oid\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n fst_snd f oid = (\<lambda>\<tau>. (case (heap (fst_snd \<tau>) (oid)) of \<lfloor>in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n obj\<rfloor> \<Rightarrow> f obj \<tau>
    | _ \<Rightarrow> invalid \<tau>))"
definition "deref_oid\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t fst_snd f oid = (\<lambda>\<tau>. (case (heap (fst_snd \<tau>) (oid)) of \<lfloor>in\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t obj\<rfloor> \<Rightarrow> f obj \<tau>
    | _ \<Rightarrow> invalid \<tau>))"
definition "deref_oid\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y fst_snd f oid = (\<lambda>\<tau>. (case (heap (fst_snd \<tau>) (oid)) of \<lfloor>in\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y obj\<rfloor> \<Rightarrow> f obj \<tau>
    | _ \<Rightarrow> invalid \<tau>))"
definition "deref_oid\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y fst_snd f oid = (\<lambda>\<tau>. (case (heap (fst_snd \<tau>) (oid)) of \<lfloor>in\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y obj\<rfloor> \<Rightarrow> f obj \<tau>
    | _ \<Rightarrow> invalid \<tau>))"

(* 119 ************************************ 685 + 1 *)
definition "deref_assocs\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_0_\<b>\<o>\<s>\<s> fst_snd f = (deref_assocs (fst_snd) (switch\<^sub>2_01) (oid\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_0_\<b>\<o>\<s>\<s>) (f)) \<circ> oid_of"

(* 120 ************************************ 686 + 1 *)
text{* 
   pointer undefined in state or not referencing a type conform object representation  *}

(* 121 ************************************ 687 + 14 *)
definition "select\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<s>\<a>\<l>\<a>\<r>\<y> f = (\<lambda> (mk\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (_) (\<bottom>)) \<Rightarrow> null
    | (mk\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (_) (\<lfloor>x_\<s>\<a>\<l>\<a>\<r>\<y>\<rfloor>)) \<Rightarrow> (f (x_\<s>\<a>\<l>\<a>\<r>\<y>)))"
definition "select\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<w>\<o>\<r>\<m>\<h>\<o>\<l>\<e> f = (\<lambda> (mk\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t (_) (\<bottom>) (_)) \<Rightarrow> null
    | (mk\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t (_) (\<lfloor>x_\<w>\<o>\<r>\<m>\<h>\<o>\<l>\<e>\<rfloor>) (_)) \<Rightarrow> (f (x_\<w>\<o>\<r>\<m>\<h>\<o>\<l>\<e>)))"
definition "select\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<w>\<e>\<i>\<g>\<h>\<t> f = (\<lambda> (mk\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t (_) (_) (\<bottom>)) \<Rightarrow> null
    | (mk\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t (_) (_) (\<lfloor>x_\<w>\<e>\<i>\<g>\<h>\<t>\<rfloor>)) \<Rightarrow> (f (x_\<w>\<e>\<i>\<g>\<h>\<t>)))"
definition "select\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y\<s>\<o>\<u>\<n>\<d> f = (\<lambda> (mk\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y (_) (\<bottom>) (_) (_)) \<Rightarrow> null
    | (mk\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y (_) (\<lfloor>x_\<s>\<o>\<u>\<n>\<d>\<rfloor>) (_) (_)) \<Rightarrow> (f (x_\<s>\<o>\<u>\<n>\<d>)))"
definition "select\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y\<m>\<o>\<v>\<i>\<n>\<g> f = (\<lambda> (mk\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y (_) (_) (\<bottom>) (_)) \<Rightarrow> null
    | (mk\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y (_) (_) (\<lfloor>x_\<m>\<o>\<v>\<i>\<n>\<g>\<rfloor>) (_)) \<Rightarrow> (f (x_\<m>\<o>\<v>\<i>\<n>\<g>)))"
definition "select\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d> f = (\<lambda> (mk\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y (_) (_) (_) (\<bottom>)) \<Rightarrow> null
    | (mk\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y (_) (_) (_) (\<lfloor>x_\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d>\<rfloor>)) \<Rightarrow> (f (x_\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d>)))"
definition "select\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<w>\<o>\<r>\<m>\<h>\<o>\<l>\<e> f = (\<lambda> (mk\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n ((mk\<E>\<X>\<T>\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (_) (\<bottom>) (_) (_) (_) (_))) (_)) \<Rightarrow> null
    | (mk\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n ((mk\<E>\<X>\<T>\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (_) (\<lfloor>x_\<w>\<o>\<r>\<m>\<h>\<o>\<l>\<e>\<rfloor>) (_) (_) (_) (_))) (_)) \<Rightarrow> (f (x_\<w>\<o>\<r>\<m>\<h>\<o>\<l>\<e>)))"
definition "select\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<w>\<e>\<i>\<g>\<h>\<t> f = (\<lambda> (mk\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n ((mk\<E>\<X>\<T>\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (_) (_) (\<bottom>) (_) (_) (_))) (_)) \<Rightarrow> null
    | (mk\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n ((mk\<E>\<X>\<T>\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (_) (_) (\<lfloor>x_\<w>\<e>\<i>\<g>\<h>\<t>\<rfloor>) (_) (_) (_))) (_)) \<Rightarrow> (f (x_\<w>\<e>\<i>\<g>\<h>\<t>)))"
definition "select\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<s>\<o>\<u>\<n>\<d> f = (\<lambda> (mk\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n ((mk\<E>\<X>\<T>\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (_) (_) (_) (\<bottom>) (_) (_))) (_)) \<Rightarrow> null
    | (mk\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n ((mk\<E>\<X>\<T>\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (_) (_) (_) (\<lfloor>x_\<s>\<o>\<u>\<n>\<d>\<rfloor>) (_) (_))) (_)) \<Rightarrow> (f (x_\<s>\<o>\<u>\<n>\<d>)))"
definition "select\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<m>\<o>\<v>\<i>\<n>\<g> f = (\<lambda> (mk\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n ((mk\<E>\<X>\<T>\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (_) (_) (_) (_) (\<bottom>) (_))) (_)) \<Rightarrow> null
    | (mk\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n ((mk\<E>\<X>\<T>\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (_) (_) (_) (_) (\<lfloor>x_\<m>\<o>\<v>\<i>\<n>\<g>\<rfloor>) (_))) (_)) \<Rightarrow> (f (x_\<m>\<o>\<v>\<i>\<n>\<g>)))"
definition "select\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d> f = (\<lambda> (mk\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n ((mk\<E>\<X>\<T>\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (_) (_) (_) (_) (_) (\<bottom>))) (_)) \<Rightarrow> null
    | (mk\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n ((mk\<E>\<X>\<T>\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (_) (_) (_) (_) (_) (\<lfloor>x_\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d>\<rfloor>))) (_)) \<Rightarrow> (f (x_\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d>)))"
definition "select\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<s>\<o>\<u>\<n>\<d> f = (\<lambda> (mk\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t ((mk\<E>\<X>\<T>\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t (_) (\<bottom>) (_) (_))) (_) (_)) \<Rightarrow> null
    | (mk\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t ((mk\<E>\<X>\<T>\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t (_) (\<lfloor>x_\<s>\<o>\<u>\<n>\<d>\<rfloor>) (_) (_))) (_) (_)) \<Rightarrow> (f (x_\<s>\<o>\<u>\<n>\<d>))
    | (mk\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t ((mk\<E>\<X>\<T>\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (person))) (_) (_)) \<Rightarrow> (select\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<s>\<o>\<u>\<n>\<d> (f) (person)))"
definition "select\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<m>\<o>\<v>\<i>\<n>\<g> f = (\<lambda> (mk\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t ((mk\<E>\<X>\<T>\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t (_) (_) (\<bottom>) (_))) (_) (_)) \<Rightarrow> null
    | (mk\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t ((mk\<E>\<X>\<T>\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t (_) (_) (\<lfloor>x_\<m>\<o>\<v>\<i>\<n>\<g>\<rfloor>) (_))) (_) (_)) \<Rightarrow> (f (x_\<m>\<o>\<v>\<i>\<n>\<g>))
    | (mk\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t ((mk\<E>\<X>\<T>\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (person))) (_) (_)) \<Rightarrow> (select\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<m>\<o>\<v>\<i>\<n>\<g> (f) (person)))"
definition "select\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d> f = (\<lambda> (mk\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t ((mk\<E>\<X>\<T>\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t (_) (_) (_) (\<bottom>))) (_) (_)) \<Rightarrow> null
    | (mk\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t ((mk\<E>\<X>\<T>\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t (_) (_) (_) (\<lfloor>x_\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d>\<rfloor>))) (_) (_)) \<Rightarrow> (f (x_\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d>))
    | (mk\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t ((mk\<E>\<X>\<T>\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (person))) (_) (_)) \<Rightarrow> (select\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d> (f) (person)))"

(* 122 ************************************ 701 + 1 *)
definition "select\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<b>\<o>\<s>\<s> = select_object_any\<^sub>S\<^sub>e\<^sub>t"

(* 123 ************************************ 702 + 14 *)
consts dot_0_\<b>\<o>\<s>\<s> :: "(\<AA>, '\<alpha>) val \<Rightarrow> \<cdot>Person" ("(_) .boss")
consts dot_0_\<b>\<o>\<s>\<s>at_pre :: "(\<AA>, '\<alpha>) val \<Rightarrow> \<cdot>Person" ("(_) .boss@pre")
consts dot\<s>\<a>\<l>\<a>\<r>\<y> :: "(\<AA>, '\<alpha>) val \<Rightarrow> Integer" ("(_) .salary")
consts dot\<s>\<a>\<l>\<a>\<r>\<y>at_pre :: "(\<AA>, '\<alpha>) val \<Rightarrow> Integer" ("(_) .salary@pre")
consts dot\<w>\<o>\<r>\<m>\<h>\<o>\<l>\<e> :: "(\<AA>, '\<alpha>) val \<Rightarrow> (\<AA>, nat option option) val" ("(_) .wormhole")
consts dot\<w>\<o>\<r>\<m>\<h>\<o>\<l>\<e>at_pre :: "(\<AA>, '\<alpha>) val \<Rightarrow> (\<AA>, nat option option) val" ("(_) .wormhole@pre")
consts dot\<w>\<e>\<i>\<g>\<h>\<t> :: "(\<AA>, '\<alpha>) val \<Rightarrow> Integer" ("(_) .weight")
consts dot\<w>\<e>\<i>\<g>\<h>\<t>at_pre :: "(\<AA>, '\<alpha>) val \<Rightarrow> Integer" ("(_) .weight@pre")
consts dot\<s>\<o>\<u>\<n>\<d> :: "(\<AA>, '\<alpha>) val \<Rightarrow> Void" ("(_) .sound")
consts dot\<s>\<o>\<u>\<n>\<d>at_pre :: "(\<AA>, '\<alpha>) val \<Rightarrow> Void" ("(_) .sound@pre")
consts dot\<m>\<o>\<v>\<i>\<n>\<g> :: "(\<AA>, '\<alpha>) val \<Rightarrow> Boolean" ("(_) .moving")
consts dot\<m>\<o>\<v>\<i>\<n>\<g>at_pre :: "(\<AA>, '\<alpha>) val \<Rightarrow> Boolean" ("(_) .moving@pre")
consts dot\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d> :: "(\<AA>, '\<alpha>) val \<Rightarrow> Set_Sequence_Planet" ("(_) .outer'_world")
consts dot\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d>at_pre :: "(\<AA>, '\<alpha>) val \<Rightarrow> Set_Sequence_Planet" ("(_) .outer'_world@pre")

(* 124 ************************************ 716 + 30 *)
defs(overloaded) dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_0_\<b>\<o>\<s>\<s> : "(x::\<cdot>Person) .boss \<equiv> (eval_extract (x) ((deref_oid\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (in_post_state) ((deref_assocs\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_0_\<b>\<o>\<s>\<s> (in_post_state) ((select\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<b>\<o>\<s>\<s> ((deref_oid\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (in_post_state) (reconst_basetype))))))))))"
defs(overloaded) dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<s>\<a>\<l>\<a>\<r>\<y> : "(x::\<cdot>Person) .salary \<equiv> (eval_extract (x) ((deref_oid\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (in_post_state) ((select\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<s>\<a>\<l>\<a>\<r>\<y> (reconst_basetype))))))"
defs(overloaded) dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_0_\<b>\<o>\<s>\<s>at_pre : "(x::\<cdot>Person) .boss@pre \<equiv> (eval_extract (x) ((deref_oid\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (in_pre_state) ((deref_assocs\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_0_\<b>\<o>\<s>\<s> (in_pre_state) ((select\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<b>\<o>\<s>\<s> ((deref_oid\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (in_pre_state) (reconst_basetype))))))))))"
defs(overloaded) dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<s>\<a>\<l>\<a>\<r>\<y>at_pre : "(x::\<cdot>Person) .salary@pre \<equiv> (eval_extract (x) ((deref_oid\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (in_pre_state) ((select\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<s>\<a>\<l>\<a>\<r>\<y> (reconst_basetype))))))"
defs(overloaded) dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<w>\<o>\<r>\<m>\<h>\<o>\<l>\<e> : "(x::\<cdot>Planet) .wormhole \<equiv> (eval_extract (x) ((deref_oid\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t (in_post_state) ((select\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<w>\<o>\<r>\<m>\<h>\<o>\<l>\<e> (reconst_basetype))))))"
defs(overloaded) dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<w>\<e>\<i>\<g>\<h>\<t> : "(x::\<cdot>Planet) .weight \<equiv> (eval_extract (x) ((deref_oid\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t (in_post_state) ((select\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<w>\<e>\<i>\<g>\<h>\<t> (reconst_basetype))))))"
defs(overloaded) dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<w>\<o>\<r>\<m>\<h>\<o>\<l>\<e>at_pre : "(x::\<cdot>Planet) .wormhole@pre \<equiv> (eval_extract (x) ((deref_oid\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t (in_pre_state) ((select\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<w>\<o>\<r>\<m>\<h>\<o>\<l>\<e> (reconst_basetype))))))"
defs(overloaded) dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<w>\<e>\<i>\<g>\<h>\<t>at_pre : "(x::\<cdot>Planet) .weight@pre \<equiv> (eval_extract (x) ((deref_oid\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t (in_pre_state) ((select\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<w>\<e>\<i>\<g>\<h>\<t> (reconst_basetype))))))"
defs(overloaded) dot\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y\<s>\<o>\<u>\<n>\<d> : "(x::\<cdot>Galaxy) .sound \<equiv> (eval_extract (x) ((deref_oid\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y (in_post_state) ((select\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y\<s>\<o>\<u>\<n>\<d> (reconst_basetype\<^sub>V\<^sub>o\<^sub>i\<^sub>d))))))"
defs(overloaded) dot\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y\<m>\<o>\<v>\<i>\<n>\<g> : "(x::\<cdot>Galaxy) .moving \<equiv> (eval_extract (x) ((deref_oid\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y (in_post_state) ((select\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y\<m>\<o>\<v>\<i>\<n>\<g> (reconst_basetype))))))"
defs(overloaded) dot\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d> : "(x::\<cdot>Galaxy) .outer_world \<equiv> (eval_extract (x) ((deref_oid\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y (in_post_state) ((select\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d> ((select_object\<^sub>S\<^sub>e\<^sub>t ((select_object\<^sub>S\<^sub>e\<^sub>q ((deref_oid\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t (in_post_state) (reconst_basetype))))))))))))"
defs(overloaded) dot\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y\<s>\<o>\<u>\<n>\<d>at_pre : "(x::\<cdot>Galaxy) .sound@pre \<equiv> (eval_extract (x) ((deref_oid\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y (in_pre_state) ((select\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y\<s>\<o>\<u>\<n>\<d> (reconst_basetype\<^sub>V\<^sub>o\<^sub>i\<^sub>d))))))"
defs(overloaded) dot\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y\<m>\<o>\<v>\<i>\<n>\<g>at_pre : "(x::\<cdot>Galaxy) .moving@pre \<equiv> (eval_extract (x) ((deref_oid\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y (in_pre_state) ((select\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y\<m>\<o>\<v>\<i>\<n>\<g> (reconst_basetype))))))"
defs(overloaded) dot\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d>at_pre : "(x::\<cdot>Galaxy) .outer_world@pre \<equiv> (eval_extract (x) ((deref_oid\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y (in_pre_state) ((select\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d> ((select_object\<^sub>S\<^sub>e\<^sub>t ((select_object\<^sub>S\<^sub>e\<^sub>q ((deref_oid\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t (in_pre_state) (reconst_basetype))))))))))))"
defs(overloaded) dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<w>\<o>\<r>\<m>\<h>\<o>\<l>\<e> : "(x::\<cdot>Person) .wormhole \<equiv> (eval_extract (x) ((deref_oid\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (in_post_state) ((select\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<w>\<o>\<r>\<m>\<h>\<o>\<l>\<e> (reconst_basetype))))))"
defs(overloaded) dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<w>\<e>\<i>\<g>\<h>\<t> : "(x::\<cdot>Person) .weight \<equiv> (eval_extract (x) ((deref_oid\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (in_post_state) ((select\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<w>\<e>\<i>\<g>\<h>\<t> (reconst_basetype))))))"
defs(overloaded) dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<s>\<o>\<u>\<n>\<d> : "(x::\<cdot>Person) .sound \<equiv> (eval_extract (x) ((deref_oid\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (in_post_state) ((select\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<s>\<o>\<u>\<n>\<d> (reconst_basetype\<^sub>V\<^sub>o\<^sub>i\<^sub>d))))))"
defs(overloaded) dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<m>\<o>\<v>\<i>\<n>\<g> : "(x::\<cdot>Person) .moving \<equiv> (eval_extract (x) ((deref_oid\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (in_post_state) ((select\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<m>\<o>\<v>\<i>\<n>\<g> (reconst_basetype))))))"
defs(overloaded) dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d> : "(x::\<cdot>Person) .outer_world \<equiv> (eval_extract (x) ((deref_oid\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (in_post_state) ((select\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d> ((select_object\<^sub>S\<^sub>e\<^sub>t ((select_object\<^sub>S\<^sub>e\<^sub>q ((deref_oid\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t (in_post_state) (reconst_basetype))))))))))))"
defs(overloaded) dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<w>\<o>\<r>\<m>\<h>\<o>\<l>\<e>at_pre : "(x::\<cdot>Person) .wormhole@pre \<equiv> (eval_extract (x) ((deref_oid\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (in_pre_state) ((select\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<w>\<o>\<r>\<m>\<h>\<o>\<l>\<e> (reconst_basetype))))))"
defs(overloaded) dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<w>\<e>\<i>\<g>\<h>\<t>at_pre : "(x::\<cdot>Person) .weight@pre \<equiv> (eval_extract (x) ((deref_oid\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (in_pre_state) ((select\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<w>\<e>\<i>\<g>\<h>\<t> (reconst_basetype))))))"
defs(overloaded) dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<s>\<o>\<u>\<n>\<d>at_pre : "(x::\<cdot>Person) .sound@pre \<equiv> (eval_extract (x) ((deref_oid\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (in_pre_state) ((select\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<s>\<o>\<u>\<n>\<d> (reconst_basetype\<^sub>V\<^sub>o\<^sub>i\<^sub>d))))))"
defs(overloaded) dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<m>\<o>\<v>\<i>\<n>\<g>at_pre : "(x::\<cdot>Person) .moving@pre \<equiv> (eval_extract (x) ((deref_oid\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (in_pre_state) ((select\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<m>\<o>\<v>\<i>\<n>\<g> (reconst_basetype))))))"
defs(overloaded) dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d>at_pre : "(x::\<cdot>Person) .outer_world@pre \<equiv> (eval_extract (x) ((deref_oid\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (in_pre_state) ((select\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d> ((select_object\<^sub>S\<^sub>e\<^sub>t ((select_object\<^sub>S\<^sub>e\<^sub>q ((deref_oid\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t (in_pre_state) (reconst_basetype))))))))))))"
defs(overloaded) dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<s>\<o>\<u>\<n>\<d> : "(x::\<cdot>Planet) .sound \<equiv> (eval_extract (x) ((deref_oid\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t (in_post_state) ((select\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<s>\<o>\<u>\<n>\<d> (reconst_basetype\<^sub>V\<^sub>o\<^sub>i\<^sub>d))))))"
defs(overloaded) dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<m>\<o>\<v>\<i>\<n>\<g> : "(x::\<cdot>Planet) .moving \<equiv> (eval_extract (x) ((deref_oid\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t (in_post_state) ((select\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<m>\<o>\<v>\<i>\<n>\<g> (reconst_basetype))))))"
defs(overloaded) dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d> : "(x::\<cdot>Planet) .outer_world \<equiv> (eval_extract (x) ((deref_oid\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t (in_post_state) ((select\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d> ((select_object\<^sub>S\<^sub>e\<^sub>t ((select_object\<^sub>S\<^sub>e\<^sub>q ((deref_oid\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t (in_post_state) (reconst_basetype))))))))))))"
defs(overloaded) dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<s>\<o>\<u>\<n>\<d>at_pre : "(x::\<cdot>Planet) .sound@pre \<equiv> (eval_extract (x) ((deref_oid\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t (in_pre_state) ((select\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<s>\<o>\<u>\<n>\<d> (reconst_basetype\<^sub>V\<^sub>o\<^sub>i\<^sub>d))))))"
defs(overloaded) dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<m>\<o>\<v>\<i>\<n>\<g>at_pre : "(x::\<cdot>Planet) .moving@pre \<equiv> (eval_extract (x) ((deref_oid\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t (in_pre_state) ((select\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<m>\<o>\<v>\<i>\<n>\<g> (reconst_basetype))))))"
defs(overloaded) dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d>at_pre : "(x::\<cdot>Planet) .outer_world@pre \<equiv> (eval_extract (x) ((deref_oid\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t (in_pre_state) ((select\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d> ((select_object\<^sub>S\<^sub>e\<^sub>t ((select_object\<^sub>S\<^sub>e\<^sub>q ((deref_oid\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t (in_pre_state) (reconst_basetype))))))))))))"

(* 125 ************************************ 746 + 1 *)
lemmas dot_accessor = dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_0_\<b>\<o>\<s>\<s>
                            dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<s>\<a>\<l>\<a>\<r>\<y>
                            dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_0_\<b>\<o>\<s>\<s>at_pre
                            dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<s>\<a>\<l>\<a>\<r>\<y>at_pre
                            dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<w>\<o>\<r>\<m>\<h>\<o>\<l>\<e>
                            dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<w>\<e>\<i>\<g>\<h>\<t>
                            dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<w>\<o>\<r>\<m>\<h>\<o>\<l>\<e>at_pre
                            dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<w>\<e>\<i>\<g>\<h>\<t>at_pre
                            dot\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y\<s>\<o>\<u>\<n>\<d>
                            dot\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y\<m>\<o>\<v>\<i>\<n>\<g>
                            dot\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d>
                            dot\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y\<s>\<o>\<u>\<n>\<d>at_pre
                            dot\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y\<m>\<o>\<v>\<i>\<n>\<g>at_pre
                            dot\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d>at_pre
                            dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<w>\<o>\<r>\<m>\<h>\<o>\<l>\<e>
                            dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<w>\<e>\<i>\<g>\<h>\<t>
                            dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<s>\<o>\<u>\<n>\<d>
                            dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<m>\<o>\<v>\<i>\<n>\<g>
                            dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d>
                            dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<w>\<o>\<r>\<m>\<h>\<o>\<l>\<e>at_pre
                            dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<w>\<e>\<i>\<g>\<h>\<t>at_pre
                            dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<s>\<o>\<u>\<n>\<d>at_pre
                            dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<m>\<o>\<v>\<i>\<n>\<g>at_pre
                            dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d>at_pre
                            dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<s>\<o>\<u>\<n>\<d>
                            dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<m>\<o>\<v>\<i>\<n>\<g>
                            dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d>
                            dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<s>\<o>\<u>\<n>\<d>at_pre
                            dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<m>\<o>\<v>\<i>\<n>\<g>at_pre
                            dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d>at_pre

(* 126 ************************************ 747 + 1 *)
subsection{* Context Passing *}

(* 127 ************************************ 748 + 1 *)
lemmas[simp,code_unfold] = eval_extract_def

(* 128 ************************************ 749 + 30 *)
lemma cp_dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_0_\<b>\<o>\<s>\<s> : "(cp ((\<lambda>X. (X::\<cdot>Person) .boss)))"
by(auto simp: dot_accessor cp_def)
lemma cp_dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<s>\<a>\<l>\<a>\<r>\<y> : "(cp ((\<lambda>X. (X::\<cdot>Person) .salary)))"
by(auto simp: dot_accessor cp_def)
lemma cp_dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_0_\<b>\<o>\<s>\<s>at_pre : "(cp ((\<lambda>X. (X::\<cdot>Person) .boss@pre)))"
by(auto simp: dot_accessor cp_def)
lemma cp_dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<s>\<a>\<l>\<a>\<r>\<y>at_pre : "(cp ((\<lambda>X. (X::\<cdot>Person) .salary@pre)))"
by(auto simp: dot_accessor cp_def)
lemma cp_dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<w>\<o>\<r>\<m>\<h>\<o>\<l>\<e> : "(cp ((\<lambda>X. (X::\<cdot>Planet) .wormhole)))"
by(auto simp: dot_accessor cp_def)
lemma cp_dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<w>\<e>\<i>\<g>\<h>\<t> : "(cp ((\<lambda>X. (X::\<cdot>Planet) .weight)))"
by(auto simp: dot_accessor cp_def)
lemma cp_dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<w>\<o>\<r>\<m>\<h>\<o>\<l>\<e>at_pre : "(cp ((\<lambda>X. (X::\<cdot>Planet) .wormhole@pre)))"
by(auto simp: dot_accessor cp_def)
lemma cp_dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<w>\<e>\<i>\<g>\<h>\<t>at_pre : "(cp ((\<lambda>X. (X::\<cdot>Planet) .weight@pre)))"
by(auto simp: dot_accessor cp_def)
lemma cp_dot\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y\<s>\<o>\<u>\<n>\<d> : "(cp ((\<lambda>X. (X::\<cdot>Galaxy) .sound)))"
by(auto simp: dot_accessor cp_def)
lemma cp_dot\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y\<m>\<o>\<v>\<i>\<n>\<g> : "(cp ((\<lambda>X. (X::\<cdot>Galaxy) .moving)))"
by(auto simp: dot_accessor cp_def)
lemma cp_dot\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d> : "(cp ((\<lambda>X. (X::\<cdot>Galaxy) .outer_world)))"
by(auto simp: dot_accessor cp_def)
lemma cp_dot\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y\<s>\<o>\<u>\<n>\<d>at_pre : "(cp ((\<lambda>X. (X::\<cdot>Galaxy) .sound@pre)))"
by(auto simp: dot_accessor cp_def)
lemma cp_dot\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y\<m>\<o>\<v>\<i>\<n>\<g>at_pre : "(cp ((\<lambda>X. (X::\<cdot>Galaxy) .moving@pre)))"
by(auto simp: dot_accessor cp_def)
lemma cp_dot\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d>at_pre : "(cp ((\<lambda>X. (X::\<cdot>Galaxy) .outer_world@pre)))"
by(auto simp: dot_accessor cp_def)
lemma cp_dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<w>\<o>\<r>\<m>\<h>\<o>\<l>\<e> : "(cp ((\<lambda>X. (X::\<cdot>Person) .wormhole)))"
by(auto simp: dot_accessor cp_def)
lemma cp_dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<w>\<e>\<i>\<g>\<h>\<t> : "(cp ((\<lambda>X. (X::\<cdot>Person) .weight)))"
by(auto simp: dot_accessor cp_def)
lemma cp_dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<s>\<o>\<u>\<n>\<d> : "(cp ((\<lambda>X. (X::\<cdot>Person) .sound)))"
by(auto simp: dot_accessor cp_def)
lemma cp_dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<m>\<o>\<v>\<i>\<n>\<g> : "(cp ((\<lambda>X. (X::\<cdot>Person) .moving)))"
by(auto simp: dot_accessor cp_def)
lemma cp_dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d> : "(cp ((\<lambda>X. (X::\<cdot>Person) .outer_world)))"
by(auto simp: dot_accessor cp_def)
lemma cp_dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<w>\<o>\<r>\<m>\<h>\<o>\<l>\<e>at_pre : "(cp ((\<lambda>X. (X::\<cdot>Person) .wormhole@pre)))"
by(auto simp: dot_accessor cp_def)
lemma cp_dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<w>\<e>\<i>\<g>\<h>\<t>at_pre : "(cp ((\<lambda>X. (X::\<cdot>Person) .weight@pre)))"
by(auto simp: dot_accessor cp_def)
lemma cp_dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<s>\<o>\<u>\<n>\<d>at_pre : "(cp ((\<lambda>X. (X::\<cdot>Person) .sound@pre)))"
by(auto simp: dot_accessor cp_def)
lemma cp_dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<m>\<o>\<v>\<i>\<n>\<g>at_pre : "(cp ((\<lambda>X. (X::\<cdot>Person) .moving@pre)))"
by(auto simp: dot_accessor cp_def)
lemma cp_dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d>at_pre : "(cp ((\<lambda>X. (X::\<cdot>Person) .outer_world@pre)))"
by(auto simp: dot_accessor cp_def)
lemma cp_dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<s>\<o>\<u>\<n>\<d> : "(cp ((\<lambda>X. (X::\<cdot>Planet) .sound)))"
by(auto simp: dot_accessor cp_def)
lemma cp_dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<m>\<o>\<v>\<i>\<n>\<g> : "(cp ((\<lambda>X. (X::\<cdot>Planet) .moving)))"
by(auto simp: dot_accessor cp_def)
lemma cp_dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d> : "(cp ((\<lambda>X. (X::\<cdot>Planet) .outer_world)))"
by(auto simp: dot_accessor cp_def)
lemma cp_dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<s>\<o>\<u>\<n>\<d>at_pre : "(cp ((\<lambda>X. (X::\<cdot>Planet) .sound@pre)))"
by(auto simp: dot_accessor cp_def)
lemma cp_dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<m>\<o>\<v>\<i>\<n>\<g>at_pre : "(cp ((\<lambda>X. (X::\<cdot>Planet) .moving@pre)))"
by(auto simp: dot_accessor cp_def)
lemma cp_dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d>at_pre : "(cp ((\<lambda>X. (X::\<cdot>Planet) .outer_world@pre)))"
by(auto simp: dot_accessor cp_def)

(* 129 ************************************ 779 + 1 *)
lemmas[simp,code_unfold] = cp_dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_0_\<b>\<o>\<s>\<s>
                            cp_dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<s>\<a>\<l>\<a>\<r>\<y>
                            cp_dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_0_\<b>\<o>\<s>\<s>at_pre
                            cp_dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<s>\<a>\<l>\<a>\<r>\<y>at_pre
                            cp_dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<w>\<o>\<r>\<m>\<h>\<o>\<l>\<e>
                            cp_dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<w>\<e>\<i>\<g>\<h>\<t>
                            cp_dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<w>\<o>\<r>\<m>\<h>\<o>\<l>\<e>at_pre
                            cp_dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<w>\<e>\<i>\<g>\<h>\<t>at_pre
                            cp_dot\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y\<s>\<o>\<u>\<n>\<d>
                            cp_dot\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y\<m>\<o>\<v>\<i>\<n>\<g>
                            cp_dot\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d>
                            cp_dot\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y\<s>\<o>\<u>\<n>\<d>at_pre
                            cp_dot\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y\<m>\<o>\<v>\<i>\<n>\<g>at_pre
                            cp_dot\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d>at_pre
                            cp_dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<w>\<o>\<r>\<m>\<h>\<o>\<l>\<e>
                            cp_dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<w>\<e>\<i>\<g>\<h>\<t>
                            cp_dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<s>\<o>\<u>\<n>\<d>
                            cp_dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<m>\<o>\<v>\<i>\<n>\<g>
                            cp_dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d>
                            cp_dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<w>\<o>\<r>\<m>\<h>\<o>\<l>\<e>at_pre
                            cp_dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<w>\<e>\<i>\<g>\<h>\<t>at_pre
                            cp_dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<s>\<o>\<u>\<n>\<d>at_pre
                            cp_dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<m>\<o>\<v>\<i>\<n>\<g>at_pre
                            cp_dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d>at_pre
                            cp_dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<s>\<o>\<u>\<n>\<d>
                            cp_dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<m>\<o>\<v>\<i>\<n>\<g>
                            cp_dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d>
                            cp_dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<s>\<o>\<u>\<n>\<d>at_pre
                            cp_dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<m>\<o>\<v>\<i>\<n>\<g>at_pre
                            cp_dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d>at_pre

(* 130 ************************************ 780 + 1 *)
subsection{* Execution with Invalid or Null as Argument *}

(* 131 ************************************ 781 + 60 *)
lemma dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_0_\<b>\<o>\<s>\<s>_invalid : "(invalid::\<cdot>Person) .boss = invalid"
by(rule ext, simp add: dot_accessor bot_option_def invalid_def)
lemma dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_0_\<b>\<o>\<s>\<s>_null : "(null::\<cdot>Person) .boss = invalid"
by(rule ext, simp add: dot_accessor bot_option_def null_fun_def null_option_def)
lemma dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<s>\<a>\<l>\<a>\<r>\<y>_invalid : "(invalid::\<cdot>Person) .salary = invalid"
by(rule ext, simp add: dot_accessor bot_option_def invalid_def)
lemma dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<s>\<a>\<l>\<a>\<r>\<y>_null : "(null::\<cdot>Person) .salary = invalid"
by(rule ext, simp add: dot_accessor bot_option_def null_fun_def null_option_def)
lemma dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_0_\<b>\<o>\<s>\<s>at_pre_invalid : "(invalid::\<cdot>Person) .boss@pre = invalid"
by(rule ext, simp add: dot_accessor bot_option_def invalid_def)
lemma dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_0_\<b>\<o>\<s>\<s>at_pre_null : "(null::\<cdot>Person) .boss@pre = invalid"
by(rule ext, simp add: dot_accessor bot_option_def null_fun_def null_option_def)
lemma dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<s>\<a>\<l>\<a>\<r>\<y>at_pre_invalid : "(invalid::\<cdot>Person) .salary@pre = invalid"
by(rule ext, simp add: dot_accessor bot_option_def invalid_def)
lemma dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<s>\<a>\<l>\<a>\<r>\<y>at_pre_null : "(null::\<cdot>Person) .salary@pre = invalid"
by(rule ext, simp add: dot_accessor bot_option_def null_fun_def null_option_def)
lemma dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<w>\<o>\<r>\<m>\<h>\<o>\<l>\<e>_invalid : "(invalid::\<cdot>Planet) .wormhole = invalid"
by(rule ext, simp add: dot_accessor bot_option_def invalid_def)
lemma dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<w>\<o>\<r>\<m>\<h>\<o>\<l>\<e>_null : "(null::\<cdot>Planet) .wormhole = invalid"
by(rule ext, simp add: dot_accessor bot_option_def null_fun_def null_option_def)
lemma dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<w>\<e>\<i>\<g>\<h>\<t>_invalid : "(invalid::\<cdot>Planet) .weight = invalid"
by(rule ext, simp add: dot_accessor bot_option_def invalid_def)
lemma dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<w>\<e>\<i>\<g>\<h>\<t>_null : "(null::\<cdot>Planet) .weight = invalid"
by(rule ext, simp add: dot_accessor bot_option_def null_fun_def null_option_def)
lemma dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<w>\<o>\<r>\<m>\<h>\<o>\<l>\<e>at_pre_invalid : "(invalid::\<cdot>Planet) .wormhole@pre = invalid"
by(rule ext, simp add: dot_accessor bot_option_def invalid_def)
lemma dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<w>\<o>\<r>\<m>\<h>\<o>\<l>\<e>at_pre_null : "(null::\<cdot>Planet) .wormhole@pre = invalid"
by(rule ext, simp add: dot_accessor bot_option_def null_fun_def null_option_def)
lemma dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<w>\<e>\<i>\<g>\<h>\<t>at_pre_invalid : "(invalid::\<cdot>Planet) .weight@pre = invalid"
by(rule ext, simp add: dot_accessor bot_option_def invalid_def)
lemma dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<w>\<e>\<i>\<g>\<h>\<t>at_pre_null : "(null::\<cdot>Planet) .weight@pre = invalid"
by(rule ext, simp add: dot_accessor bot_option_def null_fun_def null_option_def)
lemma dot\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y\<s>\<o>\<u>\<n>\<d>_invalid : "(invalid::\<cdot>Galaxy) .sound = invalid"
by(rule ext, simp add: dot_accessor bot_option_def invalid_def)
lemma dot\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y\<s>\<o>\<u>\<n>\<d>_null : "(null::\<cdot>Galaxy) .sound = invalid"
by(rule ext, simp add: dot_accessor bot_option_def null_fun_def null_option_def)
lemma dot\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y\<m>\<o>\<v>\<i>\<n>\<g>_invalid : "(invalid::\<cdot>Galaxy) .moving = invalid"
by(rule ext, simp add: dot_accessor bot_option_def invalid_def)
lemma dot\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y\<m>\<o>\<v>\<i>\<n>\<g>_null : "(null::\<cdot>Galaxy) .moving = invalid"
by(rule ext, simp add: dot_accessor bot_option_def null_fun_def null_option_def)
lemma dot\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d>_invalid : "(invalid::\<cdot>Galaxy) .outer_world = invalid"
by(rule ext, simp add: dot_accessor bot_option_def invalid_def)
lemma dot\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d>_null : "(null::\<cdot>Galaxy) .outer_world = invalid"
by(rule ext, simp add: dot_accessor bot_option_def null_fun_def null_option_def)
lemma dot\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y\<s>\<o>\<u>\<n>\<d>at_pre_invalid : "(invalid::\<cdot>Galaxy) .sound@pre = invalid"
by(rule ext, simp add: dot_accessor bot_option_def invalid_def)
lemma dot\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y\<s>\<o>\<u>\<n>\<d>at_pre_null : "(null::\<cdot>Galaxy) .sound@pre = invalid"
by(rule ext, simp add: dot_accessor bot_option_def null_fun_def null_option_def)
lemma dot\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y\<m>\<o>\<v>\<i>\<n>\<g>at_pre_invalid : "(invalid::\<cdot>Galaxy) .moving@pre = invalid"
by(rule ext, simp add: dot_accessor bot_option_def invalid_def)
lemma dot\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y\<m>\<o>\<v>\<i>\<n>\<g>at_pre_null : "(null::\<cdot>Galaxy) .moving@pre = invalid"
by(rule ext, simp add: dot_accessor bot_option_def null_fun_def null_option_def)
lemma dot\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d>at_pre_invalid : "(invalid::\<cdot>Galaxy) .outer_world@pre = invalid"
by(rule ext, simp add: dot_accessor bot_option_def invalid_def)
lemma dot\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d>at_pre_null : "(null::\<cdot>Galaxy) .outer_world@pre = invalid"
by(rule ext, simp add: dot_accessor bot_option_def null_fun_def null_option_def)
lemma dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<w>\<o>\<r>\<m>\<h>\<o>\<l>\<e>_invalid : "(invalid::\<cdot>Person) .wormhole = invalid"
by(rule ext, simp add: dot_accessor bot_option_def invalid_def)
lemma dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<w>\<o>\<r>\<m>\<h>\<o>\<l>\<e>_null : "(null::\<cdot>Person) .wormhole = invalid"
by(rule ext, simp add: dot_accessor bot_option_def null_fun_def null_option_def)
lemma dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<w>\<e>\<i>\<g>\<h>\<t>_invalid : "(invalid::\<cdot>Person) .weight = invalid"
by(rule ext, simp add: dot_accessor bot_option_def invalid_def)
lemma dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<w>\<e>\<i>\<g>\<h>\<t>_null : "(null::\<cdot>Person) .weight = invalid"
by(rule ext, simp add: dot_accessor bot_option_def null_fun_def null_option_def)
lemma dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<s>\<o>\<u>\<n>\<d>_invalid : "(invalid::\<cdot>Person) .sound = invalid"
by(rule ext, simp add: dot_accessor bot_option_def invalid_def)
lemma dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<s>\<o>\<u>\<n>\<d>_null : "(null::\<cdot>Person) .sound = invalid"
by(rule ext, simp add: dot_accessor bot_option_def null_fun_def null_option_def)
lemma dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<m>\<o>\<v>\<i>\<n>\<g>_invalid : "(invalid::\<cdot>Person) .moving = invalid"
by(rule ext, simp add: dot_accessor bot_option_def invalid_def)
lemma dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<m>\<o>\<v>\<i>\<n>\<g>_null : "(null::\<cdot>Person) .moving = invalid"
by(rule ext, simp add: dot_accessor bot_option_def null_fun_def null_option_def)
lemma dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d>_invalid : "(invalid::\<cdot>Person) .outer_world = invalid"
by(rule ext, simp add: dot_accessor bot_option_def invalid_def)
lemma dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d>_null : "(null::\<cdot>Person) .outer_world = invalid"
by(rule ext, simp add: dot_accessor bot_option_def null_fun_def null_option_def)
lemma dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<w>\<o>\<r>\<m>\<h>\<o>\<l>\<e>at_pre_invalid : "(invalid::\<cdot>Person) .wormhole@pre = invalid"
by(rule ext, simp add: dot_accessor bot_option_def invalid_def)
lemma dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<w>\<o>\<r>\<m>\<h>\<o>\<l>\<e>at_pre_null : "(null::\<cdot>Person) .wormhole@pre = invalid"
by(rule ext, simp add: dot_accessor bot_option_def null_fun_def null_option_def)
lemma dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<w>\<e>\<i>\<g>\<h>\<t>at_pre_invalid : "(invalid::\<cdot>Person) .weight@pre = invalid"
by(rule ext, simp add: dot_accessor bot_option_def invalid_def)
lemma dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<w>\<e>\<i>\<g>\<h>\<t>at_pre_null : "(null::\<cdot>Person) .weight@pre = invalid"
by(rule ext, simp add: dot_accessor bot_option_def null_fun_def null_option_def)
lemma dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<s>\<o>\<u>\<n>\<d>at_pre_invalid : "(invalid::\<cdot>Person) .sound@pre = invalid"
by(rule ext, simp add: dot_accessor bot_option_def invalid_def)
lemma dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<s>\<o>\<u>\<n>\<d>at_pre_null : "(null::\<cdot>Person) .sound@pre = invalid"
by(rule ext, simp add: dot_accessor bot_option_def null_fun_def null_option_def)
lemma dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<m>\<o>\<v>\<i>\<n>\<g>at_pre_invalid : "(invalid::\<cdot>Person) .moving@pre = invalid"
by(rule ext, simp add: dot_accessor bot_option_def invalid_def)
lemma dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<m>\<o>\<v>\<i>\<n>\<g>at_pre_null : "(null::\<cdot>Person) .moving@pre = invalid"
by(rule ext, simp add: dot_accessor bot_option_def null_fun_def null_option_def)
lemma dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d>at_pre_invalid : "(invalid::\<cdot>Person) .outer_world@pre = invalid"
by(rule ext, simp add: dot_accessor bot_option_def invalid_def)
lemma dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d>at_pre_null : "(null::\<cdot>Person) .outer_world@pre = invalid"
by(rule ext, simp add: dot_accessor bot_option_def null_fun_def null_option_def)
lemma dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<s>\<o>\<u>\<n>\<d>_invalid : "(invalid::\<cdot>Planet) .sound = invalid"
by(rule ext, simp add: dot_accessor bot_option_def invalid_def)
lemma dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<s>\<o>\<u>\<n>\<d>_null : "(null::\<cdot>Planet) .sound = invalid"
by(rule ext, simp add: dot_accessor bot_option_def null_fun_def null_option_def)
lemma dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<m>\<o>\<v>\<i>\<n>\<g>_invalid : "(invalid::\<cdot>Planet) .moving = invalid"
by(rule ext, simp add: dot_accessor bot_option_def invalid_def)
lemma dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<m>\<o>\<v>\<i>\<n>\<g>_null : "(null::\<cdot>Planet) .moving = invalid"
by(rule ext, simp add: dot_accessor bot_option_def null_fun_def null_option_def)
lemma dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d>_invalid : "(invalid::\<cdot>Planet) .outer_world = invalid"
by(rule ext, simp add: dot_accessor bot_option_def invalid_def)
lemma dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d>_null : "(null::\<cdot>Planet) .outer_world = invalid"
by(rule ext, simp add: dot_accessor bot_option_def null_fun_def null_option_def)
lemma dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<s>\<o>\<u>\<n>\<d>at_pre_invalid : "(invalid::\<cdot>Planet) .sound@pre = invalid"
by(rule ext, simp add: dot_accessor bot_option_def invalid_def)
lemma dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<s>\<o>\<u>\<n>\<d>at_pre_null : "(null::\<cdot>Planet) .sound@pre = invalid"
by(rule ext, simp add: dot_accessor bot_option_def null_fun_def null_option_def)
lemma dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<m>\<o>\<v>\<i>\<n>\<g>at_pre_invalid : "(invalid::\<cdot>Planet) .moving@pre = invalid"
by(rule ext, simp add: dot_accessor bot_option_def invalid_def)
lemma dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<m>\<o>\<v>\<i>\<n>\<g>at_pre_null : "(null::\<cdot>Planet) .moving@pre = invalid"
by(rule ext, simp add: dot_accessor bot_option_def null_fun_def null_option_def)
lemma dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d>at_pre_invalid : "(invalid::\<cdot>Planet) .outer_world@pre = invalid"
by(rule ext, simp add: dot_accessor bot_option_def invalid_def)
lemma dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d>at_pre_null : "(null::\<cdot>Planet) .outer_world@pre = invalid"
by(rule ext, simp add: dot_accessor bot_option_def null_fun_def null_option_def)

(* 132 ************************************ 841 + 1 *)
subsection{* Representation in States *}

(* 133 ************************************ 842 + 30 *)
lemma defined_mono_dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_0_\<b>\<o>\<s>\<s> : "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Person) .boss)) \<Longrightarrow> \<tau> \<Turnstile> (\<delta> (X))"
  apply(case_tac "\<tau> \<Turnstile> (X \<triangleq> invalid)", insert StrongEq_L_subst2[where P = "(\<lambda>x. (\<delta> (x .boss)))" and \<tau> = "\<tau>" and x = "X" and y = "invalid"], simp add: foundation16' dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_0_\<b>\<o>\<s>\<s>_invalid)
  apply(case_tac "\<tau> \<Turnstile> (X \<triangleq> null)", insert StrongEq_L_subst2[where P = "(\<lambda>x. (\<delta> (x .boss)))" and \<tau> = "\<tau>" and x = "X" and y = "null"], simp add: foundation16' dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_0_\<b>\<o>\<s>\<s>_null)
by(simp add: defined_split)
lemma defined_mono_dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<s>\<a>\<l>\<a>\<r>\<y> : "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Person) .salary)) \<Longrightarrow> \<tau> \<Turnstile> (\<delta> (X))"
  apply(case_tac "\<tau> \<Turnstile> (X \<triangleq> invalid)", insert StrongEq_L_subst2[where P = "(\<lambda>x. (\<delta> (x .salary)))" and \<tau> = "\<tau>" and x = "X" and y = "invalid"], simp add: foundation16' dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<s>\<a>\<l>\<a>\<r>\<y>_invalid)
  apply(case_tac "\<tau> \<Turnstile> (X \<triangleq> null)", insert StrongEq_L_subst2[where P = "(\<lambda>x. (\<delta> (x .salary)))" and \<tau> = "\<tau>" and x = "X" and y = "null"], simp add: foundation16' dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<s>\<a>\<l>\<a>\<r>\<y>_null)
by(simp add: defined_split)
lemma defined_mono_dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_0_\<b>\<o>\<s>\<s>at_pre : "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Person) .boss@pre)) \<Longrightarrow> \<tau> \<Turnstile> (\<delta> (X))"
  apply(case_tac "\<tau> \<Turnstile> (X \<triangleq> invalid)", insert StrongEq_L_subst2[where P = "(\<lambda>x. (\<delta> (x .boss@pre)))" and \<tau> = "\<tau>" and x = "X" and y = "invalid"], simp add: foundation16' dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_0_\<b>\<o>\<s>\<s>at_pre_invalid)
  apply(case_tac "\<tau> \<Turnstile> (X \<triangleq> null)", insert StrongEq_L_subst2[where P = "(\<lambda>x. (\<delta> (x .boss@pre)))" and \<tau> = "\<tau>" and x = "X" and y = "null"], simp add: foundation16' dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_0_\<b>\<o>\<s>\<s>at_pre_null)
by(simp add: defined_split)
lemma defined_mono_dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<s>\<a>\<l>\<a>\<r>\<y>at_pre : "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Person) .salary@pre)) \<Longrightarrow> \<tau> \<Turnstile> (\<delta> (X))"
  apply(case_tac "\<tau> \<Turnstile> (X \<triangleq> invalid)", insert StrongEq_L_subst2[where P = "(\<lambda>x. (\<delta> (x .salary@pre)))" and \<tau> = "\<tau>" and x = "X" and y = "invalid"], simp add: foundation16' dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<s>\<a>\<l>\<a>\<r>\<y>at_pre_invalid)
  apply(case_tac "\<tau> \<Turnstile> (X \<triangleq> null)", insert StrongEq_L_subst2[where P = "(\<lambda>x. (\<delta> (x .salary@pre)))" and \<tau> = "\<tau>" and x = "X" and y = "null"], simp add: foundation16' dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<s>\<a>\<l>\<a>\<r>\<y>at_pre_null)
by(simp add: defined_split)
lemma defined_mono_dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<w>\<o>\<r>\<m>\<h>\<o>\<l>\<e> : "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Planet) .wormhole)) \<Longrightarrow> \<tau> \<Turnstile> (\<delta> (X))"
  apply(case_tac "\<tau> \<Turnstile> (X \<triangleq> invalid)", insert StrongEq_L_subst2[where P = "(\<lambda>x. (\<delta> (x .wormhole)))" and \<tau> = "\<tau>" and x = "X" and y = "invalid"], simp add: foundation16' dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<w>\<o>\<r>\<m>\<h>\<o>\<l>\<e>_invalid)
  apply(case_tac "\<tau> \<Turnstile> (X \<triangleq> null)", insert StrongEq_L_subst2[where P = "(\<lambda>x. (\<delta> (x .wormhole)))" and \<tau> = "\<tau>" and x = "X" and y = "null"], simp add: foundation16' dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<w>\<o>\<r>\<m>\<h>\<o>\<l>\<e>_null)
by(simp add: defined_split)
lemma defined_mono_dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<w>\<e>\<i>\<g>\<h>\<t> : "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Planet) .weight)) \<Longrightarrow> \<tau> \<Turnstile> (\<delta> (X))"
  apply(case_tac "\<tau> \<Turnstile> (X \<triangleq> invalid)", insert StrongEq_L_subst2[where P = "(\<lambda>x. (\<delta> (x .weight)))" and \<tau> = "\<tau>" and x = "X" and y = "invalid"], simp add: foundation16' dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<w>\<e>\<i>\<g>\<h>\<t>_invalid)
  apply(case_tac "\<tau> \<Turnstile> (X \<triangleq> null)", insert StrongEq_L_subst2[where P = "(\<lambda>x. (\<delta> (x .weight)))" and \<tau> = "\<tau>" and x = "X" and y = "null"], simp add: foundation16' dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<w>\<e>\<i>\<g>\<h>\<t>_null)
by(simp add: defined_split)
lemma defined_mono_dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<w>\<o>\<r>\<m>\<h>\<o>\<l>\<e>at_pre : "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Planet) .wormhole@pre)) \<Longrightarrow> \<tau> \<Turnstile> (\<delta> (X))"
  apply(case_tac "\<tau> \<Turnstile> (X \<triangleq> invalid)", insert StrongEq_L_subst2[where P = "(\<lambda>x. (\<delta> (x .wormhole@pre)))" and \<tau> = "\<tau>" and x = "X" and y = "invalid"], simp add: foundation16' dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<w>\<o>\<r>\<m>\<h>\<o>\<l>\<e>at_pre_invalid)
  apply(case_tac "\<tau> \<Turnstile> (X \<triangleq> null)", insert StrongEq_L_subst2[where P = "(\<lambda>x. (\<delta> (x .wormhole@pre)))" and \<tau> = "\<tau>" and x = "X" and y = "null"], simp add: foundation16' dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<w>\<o>\<r>\<m>\<h>\<o>\<l>\<e>at_pre_null)
by(simp add: defined_split)
lemma defined_mono_dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<w>\<e>\<i>\<g>\<h>\<t>at_pre : "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Planet) .weight@pre)) \<Longrightarrow> \<tau> \<Turnstile> (\<delta> (X))"
  apply(case_tac "\<tau> \<Turnstile> (X \<triangleq> invalid)", insert StrongEq_L_subst2[where P = "(\<lambda>x. (\<delta> (x .weight@pre)))" and \<tau> = "\<tau>" and x = "X" and y = "invalid"], simp add: foundation16' dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<w>\<e>\<i>\<g>\<h>\<t>at_pre_invalid)
  apply(case_tac "\<tau> \<Turnstile> (X \<triangleq> null)", insert StrongEq_L_subst2[where P = "(\<lambda>x. (\<delta> (x .weight@pre)))" and \<tau> = "\<tau>" and x = "X" and y = "null"], simp add: foundation16' dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<w>\<e>\<i>\<g>\<h>\<t>at_pre_null)
by(simp add: defined_split)
lemma defined_mono_dot\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y\<s>\<o>\<u>\<n>\<d> : "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Galaxy) .sound)) \<Longrightarrow> \<tau> \<Turnstile> (\<delta> (X))"
  apply(case_tac "\<tau> \<Turnstile> (X \<triangleq> invalid)", insert StrongEq_L_subst2[where P = "(\<lambda>x. (\<delta> (x .sound)))" and \<tau> = "\<tau>" and x = "X" and y = "invalid"], simp add: foundation16' dot\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y\<s>\<o>\<u>\<n>\<d>_invalid)
  apply(case_tac "\<tau> \<Turnstile> (X \<triangleq> null)", insert StrongEq_L_subst2[where P = "(\<lambda>x. (\<delta> (x .sound)))" and \<tau> = "\<tau>" and x = "X" and y = "null"], simp add: foundation16' dot\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y\<s>\<o>\<u>\<n>\<d>_null)
by(simp add: defined_split)
lemma defined_mono_dot\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y\<m>\<o>\<v>\<i>\<n>\<g> : "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Galaxy) .moving)) \<Longrightarrow> \<tau> \<Turnstile> (\<delta> (X))"
  apply(case_tac "\<tau> \<Turnstile> (X \<triangleq> invalid)", insert StrongEq_L_subst2[where P = "(\<lambda>x. (\<delta> (x .moving)))" and \<tau> = "\<tau>" and x = "X" and y = "invalid"], simp add: foundation16' dot\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y\<m>\<o>\<v>\<i>\<n>\<g>_invalid)
  apply(case_tac "\<tau> \<Turnstile> (X \<triangleq> null)", insert StrongEq_L_subst2[where P = "(\<lambda>x. (\<delta> (x .moving)))" and \<tau> = "\<tau>" and x = "X" and y = "null"], simp add: foundation16' dot\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y\<m>\<o>\<v>\<i>\<n>\<g>_null)
by(simp add: defined_split)
lemma defined_mono_dot\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d> : "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Galaxy) .outer_world)) \<Longrightarrow> \<tau> \<Turnstile> (\<delta> (X))"
  apply(case_tac "\<tau> \<Turnstile> (X \<triangleq> invalid)", insert StrongEq_L_subst2[where P = "(\<lambda>x. (\<delta> (x .outer_world)))" and \<tau> = "\<tau>" and x = "X" and y = "invalid"], simp add: foundation16' dot\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d>_invalid)
  apply(case_tac "\<tau> \<Turnstile> (X \<triangleq> null)", insert StrongEq_L_subst2[where P = "(\<lambda>x. (\<delta> (x .outer_world)))" and \<tau> = "\<tau>" and x = "X" and y = "null"], simp add: foundation16' dot\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d>_null)
by(simp add: defined_split)
lemma defined_mono_dot\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y\<s>\<o>\<u>\<n>\<d>at_pre : "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Galaxy) .sound@pre)) \<Longrightarrow> \<tau> \<Turnstile> (\<delta> (X))"
  apply(case_tac "\<tau> \<Turnstile> (X \<triangleq> invalid)", insert StrongEq_L_subst2[where P = "(\<lambda>x. (\<delta> (x .sound@pre)))" and \<tau> = "\<tau>" and x = "X" and y = "invalid"], simp add: foundation16' dot\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y\<s>\<o>\<u>\<n>\<d>at_pre_invalid)
  apply(case_tac "\<tau> \<Turnstile> (X \<triangleq> null)", insert StrongEq_L_subst2[where P = "(\<lambda>x. (\<delta> (x .sound@pre)))" and \<tau> = "\<tau>" and x = "X" and y = "null"], simp add: foundation16' dot\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y\<s>\<o>\<u>\<n>\<d>at_pre_null)
by(simp add: defined_split)
lemma defined_mono_dot\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y\<m>\<o>\<v>\<i>\<n>\<g>at_pre : "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Galaxy) .moving@pre)) \<Longrightarrow> \<tau> \<Turnstile> (\<delta> (X))"
  apply(case_tac "\<tau> \<Turnstile> (X \<triangleq> invalid)", insert StrongEq_L_subst2[where P = "(\<lambda>x. (\<delta> (x .moving@pre)))" and \<tau> = "\<tau>" and x = "X" and y = "invalid"], simp add: foundation16' dot\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y\<m>\<o>\<v>\<i>\<n>\<g>at_pre_invalid)
  apply(case_tac "\<tau> \<Turnstile> (X \<triangleq> null)", insert StrongEq_L_subst2[where P = "(\<lambda>x. (\<delta> (x .moving@pre)))" and \<tau> = "\<tau>" and x = "X" and y = "null"], simp add: foundation16' dot\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y\<m>\<o>\<v>\<i>\<n>\<g>at_pre_null)
by(simp add: defined_split)
lemma defined_mono_dot\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d>at_pre : "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Galaxy) .outer_world@pre)) \<Longrightarrow> \<tau> \<Turnstile> (\<delta> (X))"
  apply(case_tac "\<tau> \<Turnstile> (X \<triangleq> invalid)", insert StrongEq_L_subst2[where P = "(\<lambda>x. (\<delta> (x .outer_world@pre)))" and \<tau> = "\<tau>" and x = "X" and y = "invalid"], simp add: foundation16' dot\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d>at_pre_invalid)
  apply(case_tac "\<tau> \<Turnstile> (X \<triangleq> null)", insert StrongEq_L_subst2[where P = "(\<lambda>x. (\<delta> (x .outer_world@pre)))" and \<tau> = "\<tau>" and x = "X" and y = "null"], simp add: foundation16' dot\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d>at_pre_null)
by(simp add: defined_split)
lemma defined_mono_dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<w>\<o>\<r>\<m>\<h>\<o>\<l>\<e> : "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Person) .wormhole)) \<Longrightarrow> \<tau> \<Turnstile> (\<delta> (X))"
  apply(case_tac "\<tau> \<Turnstile> (X \<triangleq> invalid)", insert StrongEq_L_subst2[where P = "(\<lambda>x. (\<delta> (x .wormhole)))" and \<tau> = "\<tau>" and x = "X" and y = "invalid"], simp add: foundation16' dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<w>\<o>\<r>\<m>\<h>\<o>\<l>\<e>_invalid)
  apply(case_tac "\<tau> \<Turnstile> (X \<triangleq> null)", insert StrongEq_L_subst2[where P = "(\<lambda>x. (\<delta> (x .wormhole)))" and \<tau> = "\<tau>" and x = "X" and y = "null"], simp add: foundation16' dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<w>\<o>\<r>\<m>\<h>\<o>\<l>\<e>_null)
by(simp add: defined_split)
lemma defined_mono_dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<w>\<e>\<i>\<g>\<h>\<t> : "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Person) .weight)) \<Longrightarrow> \<tau> \<Turnstile> (\<delta> (X))"
  apply(case_tac "\<tau> \<Turnstile> (X \<triangleq> invalid)", insert StrongEq_L_subst2[where P = "(\<lambda>x. (\<delta> (x .weight)))" and \<tau> = "\<tau>" and x = "X" and y = "invalid"], simp add: foundation16' dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<w>\<e>\<i>\<g>\<h>\<t>_invalid)
  apply(case_tac "\<tau> \<Turnstile> (X \<triangleq> null)", insert StrongEq_L_subst2[where P = "(\<lambda>x. (\<delta> (x .weight)))" and \<tau> = "\<tau>" and x = "X" and y = "null"], simp add: foundation16' dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<w>\<e>\<i>\<g>\<h>\<t>_null)
by(simp add: defined_split)
lemma defined_mono_dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<s>\<o>\<u>\<n>\<d> : "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Person) .sound)) \<Longrightarrow> \<tau> \<Turnstile> (\<delta> (X))"
  apply(case_tac "\<tau> \<Turnstile> (X \<triangleq> invalid)", insert StrongEq_L_subst2[where P = "(\<lambda>x. (\<delta> (x .sound)))" and \<tau> = "\<tau>" and x = "X" and y = "invalid"], simp add: foundation16' dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<s>\<o>\<u>\<n>\<d>_invalid)
  apply(case_tac "\<tau> \<Turnstile> (X \<triangleq> null)", insert StrongEq_L_subst2[where P = "(\<lambda>x. (\<delta> (x .sound)))" and \<tau> = "\<tau>" and x = "X" and y = "null"], simp add: foundation16' dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<s>\<o>\<u>\<n>\<d>_null)
by(simp add: defined_split)
lemma defined_mono_dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<m>\<o>\<v>\<i>\<n>\<g> : "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Person) .moving)) \<Longrightarrow> \<tau> \<Turnstile> (\<delta> (X))"
  apply(case_tac "\<tau> \<Turnstile> (X \<triangleq> invalid)", insert StrongEq_L_subst2[where P = "(\<lambda>x. (\<delta> (x .moving)))" and \<tau> = "\<tau>" and x = "X" and y = "invalid"], simp add: foundation16' dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<m>\<o>\<v>\<i>\<n>\<g>_invalid)
  apply(case_tac "\<tau> \<Turnstile> (X \<triangleq> null)", insert StrongEq_L_subst2[where P = "(\<lambda>x. (\<delta> (x .moving)))" and \<tau> = "\<tau>" and x = "X" and y = "null"], simp add: foundation16' dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<m>\<o>\<v>\<i>\<n>\<g>_null)
by(simp add: defined_split)
lemma defined_mono_dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d> : "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Person) .outer_world)) \<Longrightarrow> \<tau> \<Turnstile> (\<delta> (X))"
  apply(case_tac "\<tau> \<Turnstile> (X \<triangleq> invalid)", insert StrongEq_L_subst2[where P = "(\<lambda>x. (\<delta> (x .outer_world)))" and \<tau> = "\<tau>" and x = "X" and y = "invalid"], simp add: foundation16' dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d>_invalid)
  apply(case_tac "\<tau> \<Turnstile> (X \<triangleq> null)", insert StrongEq_L_subst2[where P = "(\<lambda>x. (\<delta> (x .outer_world)))" and \<tau> = "\<tau>" and x = "X" and y = "null"], simp add: foundation16' dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d>_null)
by(simp add: defined_split)
lemma defined_mono_dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<w>\<o>\<r>\<m>\<h>\<o>\<l>\<e>at_pre : "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Person) .wormhole@pre)) \<Longrightarrow> \<tau> \<Turnstile> (\<delta> (X))"
  apply(case_tac "\<tau> \<Turnstile> (X \<triangleq> invalid)", insert StrongEq_L_subst2[where P = "(\<lambda>x. (\<delta> (x .wormhole@pre)))" and \<tau> = "\<tau>" and x = "X" and y = "invalid"], simp add: foundation16' dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<w>\<o>\<r>\<m>\<h>\<o>\<l>\<e>at_pre_invalid)
  apply(case_tac "\<tau> \<Turnstile> (X \<triangleq> null)", insert StrongEq_L_subst2[where P = "(\<lambda>x. (\<delta> (x .wormhole@pre)))" and \<tau> = "\<tau>" and x = "X" and y = "null"], simp add: foundation16' dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<w>\<o>\<r>\<m>\<h>\<o>\<l>\<e>at_pre_null)
by(simp add: defined_split)
lemma defined_mono_dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<w>\<e>\<i>\<g>\<h>\<t>at_pre : "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Person) .weight@pre)) \<Longrightarrow> \<tau> \<Turnstile> (\<delta> (X))"
  apply(case_tac "\<tau> \<Turnstile> (X \<triangleq> invalid)", insert StrongEq_L_subst2[where P = "(\<lambda>x. (\<delta> (x .weight@pre)))" and \<tau> = "\<tau>" and x = "X" and y = "invalid"], simp add: foundation16' dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<w>\<e>\<i>\<g>\<h>\<t>at_pre_invalid)
  apply(case_tac "\<tau> \<Turnstile> (X \<triangleq> null)", insert StrongEq_L_subst2[where P = "(\<lambda>x. (\<delta> (x .weight@pre)))" and \<tau> = "\<tau>" and x = "X" and y = "null"], simp add: foundation16' dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<w>\<e>\<i>\<g>\<h>\<t>at_pre_null)
by(simp add: defined_split)
lemma defined_mono_dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<s>\<o>\<u>\<n>\<d>at_pre : "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Person) .sound@pre)) \<Longrightarrow> \<tau> \<Turnstile> (\<delta> (X))"
  apply(case_tac "\<tau> \<Turnstile> (X \<triangleq> invalid)", insert StrongEq_L_subst2[where P = "(\<lambda>x. (\<delta> (x .sound@pre)))" and \<tau> = "\<tau>" and x = "X" and y = "invalid"], simp add: foundation16' dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<s>\<o>\<u>\<n>\<d>at_pre_invalid)
  apply(case_tac "\<tau> \<Turnstile> (X \<triangleq> null)", insert StrongEq_L_subst2[where P = "(\<lambda>x. (\<delta> (x .sound@pre)))" and \<tau> = "\<tau>" and x = "X" and y = "null"], simp add: foundation16' dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<s>\<o>\<u>\<n>\<d>at_pre_null)
by(simp add: defined_split)
lemma defined_mono_dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<m>\<o>\<v>\<i>\<n>\<g>at_pre : "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Person) .moving@pre)) \<Longrightarrow> \<tau> \<Turnstile> (\<delta> (X))"
  apply(case_tac "\<tau> \<Turnstile> (X \<triangleq> invalid)", insert StrongEq_L_subst2[where P = "(\<lambda>x. (\<delta> (x .moving@pre)))" and \<tau> = "\<tau>" and x = "X" and y = "invalid"], simp add: foundation16' dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<m>\<o>\<v>\<i>\<n>\<g>at_pre_invalid)
  apply(case_tac "\<tau> \<Turnstile> (X \<triangleq> null)", insert StrongEq_L_subst2[where P = "(\<lambda>x. (\<delta> (x .moving@pre)))" and \<tau> = "\<tau>" and x = "X" and y = "null"], simp add: foundation16' dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<m>\<o>\<v>\<i>\<n>\<g>at_pre_null)
by(simp add: defined_split)
lemma defined_mono_dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d>at_pre : "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Person) .outer_world@pre)) \<Longrightarrow> \<tau> \<Turnstile> (\<delta> (X))"
  apply(case_tac "\<tau> \<Turnstile> (X \<triangleq> invalid)", insert StrongEq_L_subst2[where P = "(\<lambda>x. (\<delta> (x .outer_world@pre)))" and \<tau> = "\<tau>" and x = "X" and y = "invalid"], simp add: foundation16' dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d>at_pre_invalid)
  apply(case_tac "\<tau> \<Turnstile> (X \<triangleq> null)", insert StrongEq_L_subst2[where P = "(\<lambda>x. (\<delta> (x .outer_world@pre)))" and \<tau> = "\<tau>" and x = "X" and y = "null"], simp add: foundation16' dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d>at_pre_null)
by(simp add: defined_split)
lemma defined_mono_dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<s>\<o>\<u>\<n>\<d> : "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Planet) .sound)) \<Longrightarrow> \<tau> \<Turnstile> (\<delta> (X))"
  apply(case_tac "\<tau> \<Turnstile> (X \<triangleq> invalid)", insert StrongEq_L_subst2[where P = "(\<lambda>x. (\<delta> (x .sound)))" and \<tau> = "\<tau>" and x = "X" and y = "invalid"], simp add: foundation16' dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<s>\<o>\<u>\<n>\<d>_invalid)
  apply(case_tac "\<tau> \<Turnstile> (X \<triangleq> null)", insert StrongEq_L_subst2[where P = "(\<lambda>x. (\<delta> (x .sound)))" and \<tau> = "\<tau>" and x = "X" and y = "null"], simp add: foundation16' dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<s>\<o>\<u>\<n>\<d>_null)
by(simp add: defined_split)
lemma defined_mono_dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<m>\<o>\<v>\<i>\<n>\<g> : "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Planet) .moving)) \<Longrightarrow> \<tau> \<Turnstile> (\<delta> (X))"
  apply(case_tac "\<tau> \<Turnstile> (X \<triangleq> invalid)", insert StrongEq_L_subst2[where P = "(\<lambda>x. (\<delta> (x .moving)))" and \<tau> = "\<tau>" and x = "X" and y = "invalid"], simp add: foundation16' dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<m>\<o>\<v>\<i>\<n>\<g>_invalid)
  apply(case_tac "\<tau> \<Turnstile> (X \<triangleq> null)", insert StrongEq_L_subst2[where P = "(\<lambda>x. (\<delta> (x .moving)))" and \<tau> = "\<tau>" and x = "X" and y = "null"], simp add: foundation16' dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<m>\<o>\<v>\<i>\<n>\<g>_null)
by(simp add: defined_split)
lemma defined_mono_dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d> : "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Planet) .outer_world)) \<Longrightarrow> \<tau> \<Turnstile> (\<delta> (X))"
  apply(case_tac "\<tau> \<Turnstile> (X \<triangleq> invalid)", insert StrongEq_L_subst2[where P = "(\<lambda>x. (\<delta> (x .outer_world)))" and \<tau> = "\<tau>" and x = "X" and y = "invalid"], simp add: foundation16' dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d>_invalid)
  apply(case_tac "\<tau> \<Turnstile> (X \<triangleq> null)", insert StrongEq_L_subst2[where P = "(\<lambda>x. (\<delta> (x .outer_world)))" and \<tau> = "\<tau>" and x = "X" and y = "null"], simp add: foundation16' dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d>_null)
by(simp add: defined_split)
lemma defined_mono_dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<s>\<o>\<u>\<n>\<d>at_pre : "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Planet) .sound@pre)) \<Longrightarrow> \<tau> \<Turnstile> (\<delta> (X))"
  apply(case_tac "\<tau> \<Turnstile> (X \<triangleq> invalid)", insert StrongEq_L_subst2[where P = "(\<lambda>x. (\<delta> (x .sound@pre)))" and \<tau> = "\<tau>" and x = "X" and y = "invalid"], simp add: foundation16' dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<s>\<o>\<u>\<n>\<d>at_pre_invalid)
  apply(case_tac "\<tau> \<Turnstile> (X \<triangleq> null)", insert StrongEq_L_subst2[where P = "(\<lambda>x. (\<delta> (x .sound@pre)))" and \<tau> = "\<tau>" and x = "X" and y = "null"], simp add: foundation16' dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<s>\<o>\<u>\<n>\<d>at_pre_null)
by(simp add: defined_split)
lemma defined_mono_dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<m>\<o>\<v>\<i>\<n>\<g>at_pre : "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Planet) .moving@pre)) \<Longrightarrow> \<tau> \<Turnstile> (\<delta> (X))"
  apply(case_tac "\<tau> \<Turnstile> (X \<triangleq> invalid)", insert StrongEq_L_subst2[where P = "(\<lambda>x. (\<delta> (x .moving@pre)))" and \<tau> = "\<tau>" and x = "X" and y = "invalid"], simp add: foundation16' dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<m>\<o>\<v>\<i>\<n>\<g>at_pre_invalid)
  apply(case_tac "\<tau> \<Turnstile> (X \<triangleq> null)", insert StrongEq_L_subst2[where P = "(\<lambda>x. (\<delta> (x .moving@pre)))" and \<tau> = "\<tau>" and x = "X" and y = "null"], simp add: foundation16' dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<m>\<o>\<v>\<i>\<n>\<g>at_pre_null)
by(simp add: defined_split)
lemma defined_mono_dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d>at_pre : "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Planet) .outer_world@pre)) \<Longrightarrow> \<tau> \<Turnstile> (\<delta> (X))"
  apply(case_tac "\<tau> \<Turnstile> (X \<triangleq> invalid)", insert StrongEq_L_subst2[where P = "(\<lambda>x. (\<delta> (x .outer_world@pre)))" and \<tau> = "\<tau>" and x = "X" and y = "invalid"], simp add: foundation16' dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d>at_pre_invalid)
  apply(case_tac "\<tau> \<Turnstile> (X \<triangleq> null)", insert StrongEq_L_subst2[where P = "(\<lambda>x. (\<delta> (x .outer_world@pre)))" and \<tau> = "\<tau>" and x = "X" and y = "null"], simp add: foundation16' dot\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<o>\<u>\<t>\<e>\<r>095\<w>\<o>\<r>\<l>\<d>at_pre_null)
by(simp add: defined_split)

(* 134 ************************************ 872 + 2 *)
lemma is_repr_dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_0_\<b>\<o>\<s>\<s> : 
assumes def_dot: "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Person) .boss))"
shows "(is_represented_in_state (in_post_state) (X .boss) (Person) (\<tau>))"
  apply(insert defined_mono_dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_0_\<b>\<o>\<s>\<s>[OF def_dot, simplified foundation16])
  apply(case_tac "(X (\<tau>))", simp add: bot_option_def)
  proof - fix a0 show "(X (\<tau>)) \<noteq> null \<Longrightarrow> (X (\<tau>)) = (Some (a0)) \<Longrightarrow> ?thesis"
  apply(case_tac "a0", simp add: null_option_def bot_option_def, clarify)
  proof - fix a show "(X (\<tau>)) = (Some ((Some (a)))) \<Longrightarrow> ?thesis"
  apply(case_tac "(heap ((in_post_state (\<tau>))) ((oid_of (a))))", simp add: invalid_def bot_option_def)
  apply(insert def_dot, simp add: dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_0_\<b>\<o>\<s>\<s> is_represented_in_state_def select\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<b>\<o>\<s>\<s>_def deref_oid\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_def in_post_state_def defined_def OclValid_def false_def true_def invalid_def bot_fun_def split: split_if_asm)
  proof - fix b show "(X (\<tau>)) = (Some ((Some (a)))) \<Longrightarrow> (heap ((in_post_state (\<tau>))) ((oid_of (a)))) = (Some (b)) \<Longrightarrow> ?thesis"
  apply(insert def_dot[simplified foundation16], auto simp: dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_0_\<b>\<o>\<s>\<s> is_represented_in_state_def deref_oid\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_def bot_option_def null_option_def)
  apply(case_tac "b", simp_all add: invalid_def bot_option_def)
  apply(simp add: deref_assocs\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_0_\<b>\<o>\<s>\<s>_def deref_assocs_def)
  apply(case_tac "(assocs ((in_post_state (\<tau>))) (oid\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_0_\<b>\<o>\<s>\<s>))", simp add: invalid_def bot_option_def, simp add: select\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<b>\<o>\<s>\<s>_def)
  proof - fix r typeoid          let ?t = "(Some ((Some (r)))) \<in> (Some o OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_\<AA>) ` (ran ((heap ((in_post_state (\<tau>))))))"
          let ?sel_any = "(select_object_any\<^sub>S\<^sub>e\<^sub>t ((deref_oid\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (in_post_state) (reconst_basetype))))" show "((?sel_any) (typeoid) (\<tau>)) = (Some ((Some (r)))) \<Longrightarrow> ?t"
  proof - fix aa show "\<tau> \<Turnstile> (\<delta> (((?sel_any) (aa)))) \<Longrightarrow> ((?sel_any) (aa) (\<tau>)) = (Some ((Some (r)))) \<Longrightarrow> ?t"
  apply(drule select_object_any_exec\<^sub>S\<^sub>e\<^sub>t[simplified foundation22], erule exE)
  proof - fix e show "((?sel_any) (aa) (\<tau>)) = (Some ((Some (r)))) \<Longrightarrow> ((?sel_any) (aa) (\<tau>)) = (deref_oid\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (in_post_state) (reconst_basetype) (e) (\<tau>)) \<Longrightarrow> ?t"
  apply(simp add: deref_oid\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_def)
  apply(case_tac "(heap ((in_post_state (\<tau>))) (e))", simp add: invalid_def bot_option_def, simp)
  proof - fix aaa show "(case aaa of (in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (obj)) \<Rightarrow> (reconst_basetype (obj) (\<tau>))
    | _ \<Rightarrow> (invalid (\<tau>))) = (Some ((Some (r)))) \<Longrightarrow> (heap ((in_post_state (\<tau>))) (e)) = (Some (aaa)) \<Longrightarrow> ?t"
  apply(case_tac "aaa", auto simp: invalid_def bot_option_def image_def ran_def)
  apply(rule exI[where x = "(in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (r))"], simp add: OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_\<AA>_def Let_def reconst_basetype_def split: split_if_asm)
by(rule) qed 
  apply_end((blast)+)
 qed 
  apply_end(simp_all only: )
  apply_end(simp add: foundation16 bot_option_def null_option_def)
 qed qed qed qed 
  apply_end(simp_all)
 qed
lemma is_repr_dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_0_\<b>\<o>\<s>\<s>at_pre : 
assumes def_dot: "\<tau> \<Turnstile> (\<delta> ((X::\<cdot>Person) .boss@pre))"
shows "(is_represented_in_state (in_pre_state) (X .boss@pre) (Person) (\<tau>))"
  apply(insert defined_mono_dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_0_\<b>\<o>\<s>\<s>at_pre[OF def_dot, simplified foundation16])
  apply(case_tac "(X (\<tau>))", simp add: bot_option_def)
  proof - fix a0 show "(X (\<tau>)) \<noteq> null \<Longrightarrow> (X (\<tau>)) = (Some (a0)) \<Longrightarrow> ?thesis"
  apply(case_tac "a0", simp add: null_option_def bot_option_def, clarify)
  proof - fix a show "(X (\<tau>)) = (Some ((Some (a)))) \<Longrightarrow> ?thesis"
  apply(case_tac "(heap ((in_pre_state (\<tau>))) ((oid_of (a))))", simp add: invalid_def bot_option_def)
  apply(insert def_dot, simp add: dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_0_\<b>\<o>\<s>\<s>at_pre is_represented_in_state_def select\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<b>\<o>\<s>\<s>_def deref_oid\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_def in_pre_state_def defined_def OclValid_def false_def true_def invalid_def bot_fun_def split: split_if_asm)
  proof - fix b show "(X (\<tau>)) = (Some ((Some (a)))) \<Longrightarrow> (heap ((in_pre_state (\<tau>))) ((oid_of (a)))) = (Some (b)) \<Longrightarrow> ?thesis"
  apply(insert def_dot[simplified foundation16], auto simp: dot\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_0_\<b>\<o>\<s>\<s>at_pre is_represented_in_state_def deref_oid\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_def bot_option_def null_option_def)
  apply(case_tac "b", simp_all add: invalid_def bot_option_def)
  apply(simp add: deref_assocs\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_0_\<b>\<o>\<s>\<s>_def deref_assocs_def)
  apply(case_tac "(assocs ((in_pre_state (\<tau>))) (oid\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_0_\<b>\<o>\<s>\<s>))", simp add: invalid_def bot_option_def, simp add: select\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<b>\<o>\<s>\<s>_def)
  proof - fix r typeoid          let ?t = "(Some ((Some (r)))) \<in> (Some o OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_\<AA>) ` (ran ((heap ((in_pre_state (\<tau>))))))"
          let ?sel_any = "(select_object_any\<^sub>S\<^sub>e\<^sub>t ((deref_oid\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (in_pre_state) (reconst_basetype))))" show "((?sel_any) (typeoid) (\<tau>)) = (Some ((Some (r)))) \<Longrightarrow> ?t"
  proof - fix aa show "\<tau> \<Turnstile> (\<delta> (((?sel_any) (aa)))) \<Longrightarrow> ((?sel_any) (aa) (\<tau>)) = (Some ((Some (r)))) \<Longrightarrow> ?t"
  apply(drule select_object_any_exec\<^sub>S\<^sub>e\<^sub>t[simplified foundation22], erule exE)
  proof - fix e show "((?sel_any) (aa) (\<tau>)) = (Some ((Some (r)))) \<Longrightarrow> ((?sel_any) (aa) (\<tau>)) = (deref_oid\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (in_pre_state) (reconst_basetype) (e) (\<tau>)) \<Longrightarrow> ?t"
  apply(simp add: deref_oid\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_def)
  apply(case_tac "(heap ((in_pre_state (\<tau>))) (e))", simp add: invalid_def bot_option_def, simp)
  proof - fix aaa show "(case aaa of (in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (obj)) \<Rightarrow> (reconst_basetype (obj) (\<tau>))
    | _ \<Rightarrow> (invalid (\<tau>))) = (Some ((Some (r)))) \<Longrightarrow> (heap ((in_pre_state (\<tau>))) (e)) = (Some (aaa)) \<Longrightarrow> ?t"
  apply(case_tac "aaa", auto simp: invalid_def bot_option_def image_def ran_def)
  apply(rule exI[where x = "(in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (r))"], simp add: OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_\<AA>_def Let_def reconst_basetype_def split: split_if_asm)
by(rule) qed 
  apply_end((blast)+)
 qed 
  apply_end(simp_all only: )
  apply_end(simp add: foundation16 bot_option_def null_option_def)
 qed qed qed qed 
  apply_end(simp_all)
 qed

(* 135 ************************************ 874 + 1 *)
section{* A Little Infra-structure on Example States *}

(* 136 ************************************ 875 + 1 *)
text{*  *}

(* 137 ************************************ 876 + 1 *)
text{* 

The example we are defining in this section comes from the figure~\ref{fig:eam1_system-states}.
\begin{figure}
\includegraphics[width=\textwidth]{figures/pre-post.pdf}
\caption{(a) pre-state $\sigma_1$ and
  (b) post-state $\sigma_1'$.}
\label{fig:eam1_system-states}
\end{figure}
 *}

(* 138 ************************************ 877 + 1 *)
lemmas [simp,code_unfold] = state.defs
                            const_ss

(* 139 ************************************ 878 + 1 *)
lemmas[simp,code_unfold] = OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Planet
                            OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_Galaxy
                            OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny
                            OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Galaxy
                            OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_OclAny
                            OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person
                            OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_OclAny
                            OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person
                            OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Planet
                            OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person
                            OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Planet
                            OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Galaxy

(* 140 ************************************ 879 + 2 *)
definition "(typecheck_instance_bad_head_on_lhs\<^sub>P\<^sub>1\<^sub>_\<^sub>X\<^sub>0\<^sub>_\<^sub>X092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>P092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>e092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>r092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>s092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>o092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>n\<^sub>9\<^sub>_\<^sub>X092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>P092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>e092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>r092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>s092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>o092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>n\<^sub>8\<^sub>_\<^sub>X092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>P092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>e092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>r092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>s092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>o092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>n\<^sub>7\<^sub>_\<^sub>X092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>P092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>e092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>r092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>s092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>o092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>n\<^sub>6\<^sub>_\<^sub>X092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>P092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>e092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>r092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>s092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>o092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>n\<^sub>5\<^sub>_\<^sub>X092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>P092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>e092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>r092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>s092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>o092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>n\<^sub>4\<^sub>_\<^sub>X092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>P092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>e092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>r092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>s092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>o092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>n\<^sub>3\<^sub>_\<^sub>X092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>P092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>e092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>r092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>s092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>o092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>n\<^sub>2\<^sub>_\<^sub>X092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>P092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>e092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>r092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>s092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>o092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>n\<^sub>1 (P1) (X0) (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9) (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n8) (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n7) (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6) (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5) (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4) (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3) (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2) (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1)) = ()"
definition "typecheck_instance_extra_variables_on_rhs\<^sub>P\<^sub>1\<^sub>_\<^sub>X\<^sub>0\<^sub>_\<^sub>X092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>P092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>e092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>r092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>s092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>o092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>n\<^sub>9\<^sub>_\<^sub>X092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>P092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>e092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>r092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>s092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>o092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>n\<^sub>8\<^sub>_\<^sub>X092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>P092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>e092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>r092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>s092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>o092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>n\<^sub>7\<^sub>_\<^sub>X092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>P092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>e092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>r092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>s092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>o092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>n\<^sub>6\<^sub>_\<^sub>X092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>P092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>e092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>r092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>s092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>o092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>n\<^sub>5\<^sub>_\<^sub>X092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>P092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>e092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>r092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>s092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>o092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>n\<^sub>4\<^sub>_\<^sub>X092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>P092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>e092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>r092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>s092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>o092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>n\<^sub>3\<^sub>_\<^sub>X092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>P092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>e092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>r092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>s092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>o092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>n\<^sub>2\<^sub>_\<^sub>X092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>P092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>e092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>r092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>s092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>o092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>n\<^sub>1 = (\<lambda>P1 X0 X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9 X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n8 X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n7 X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6 X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5 X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4 X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3 X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2 X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1. (P1 , P1 , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n7 , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n7 , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2 , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2))"

(* 141 ************************************ 881 + 11 *)
definition "oid1 = 1"
definition "oid2 = 2"
definition "oid3 = 3"
definition "oid4 = 4"
definition "oid5 = 5"
definition "oid6 = 6"
definition "oid7 = 7"
definition "oid8 = 8"
definition "oid9 = 9"
definition "oid10 = 10"
definition "oid11 = 11"

(* 142 ************************************ 892 + 22 *)
definition "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n = (mk\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n ((mk\<E>\<X>\<T>\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (oid1) (None) (None) (None) (None) (None))) (\<lfloor>1300\<rfloor>))"
definition "(X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1::\<cdot>Person) = ((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>))"
definition "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n = (mk\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n ((mk\<E>\<X>\<T>\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (oid2) (None) (None) (None) (None) (None))) (\<lfloor>1800\<rfloor>))"
definition "(X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2::\<cdot>Person) = ((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>))"
definition "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n = (mk\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n ((mk\<E>\<X>\<T>\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (oid3) (None) (None) (None) (None) (None))) (None))"
definition "(X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3::\<cdot>Person) = ((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>))"
definition "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n = (mk\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n ((mk\<E>\<X>\<T>\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (oid4) (None) (None) (None) (None) (None))) (\<lfloor>2900\<rfloor>))"
definition "(X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4::\<cdot>Person) = ((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>))"
definition "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n = (mk\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n ((mk\<E>\<X>\<T>\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (oid5) (None) (None) (None) (None) (None))) (\<lfloor>3500\<rfloor>))"
definition "(X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5::\<cdot>Person) = ((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>))"
definition "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n = (mk\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n ((mk\<E>\<X>\<T>\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (oid6) (None) (None) (None) (None) (None))) (\<lfloor>2500\<rfloor>))"
definition "(X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6::\<cdot>Person) = ((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>))"
definition "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n7\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y = (mk\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n ((mk\<E>\<X>\<T>\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (oid7) (None) (None) (None) (None) (None))) (\<lfloor>3200\<rfloor>))"
definition "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n7 = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n7\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(OclAny))"
definition "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n8\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y = (mk\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y ((mk\<E>\<X>\<T>\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y (oid8))))"
definition "(X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n8::\<cdot>OclAny) = ((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n8\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y\<rfloor>\<rfloor>))"
definition "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n = (mk\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n ((mk\<E>\<X>\<T>\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (oid9) (None) (None) (None) (None) (None))) (\<lfloor>0\<rfloor>))"
definition "(X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9::\<cdot>Person) = ((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>))"
definition "X0\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n = (mk\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n ((mk\<E>\<X>\<T>\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (oid10) (None) (None) (None) (None) (\<lfloor>[[oid11]]\<rfloor>))) (None))"
definition "(X0::\<cdot>Person) = ((\<lambda>_. \<lfloor>\<lfloor>X0\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>))"
definition "P1\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t = (mk\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t ((mk\<E>\<X>\<T>\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t (oid11) (None) (None) (\<lfloor>[[oid11] , [oid11]]\<rfloor>))) (None) (None))"
definition "(P1::\<cdot>Planet) = ((\<lambda>_. \<lfloor>\<lfloor>P1\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t\<rfloor>\<rfloor>))"

(* 143 ************************************ 914 + 1 *)
ML{* (Ty'.check ([(OCL.Writeln , "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1 .boss \<cong> Set{ X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2 }") , (OCL.Writeln , "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1 /* unnamed attribute */ \<cong> Set{}") , (OCL.Writeln , "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2 .boss \<cong> Set{ X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2 }") , (OCL.Writeln , "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2 /* unnamed attribute */ \<cong> Set{ X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1 , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2 }") , (OCL.Writeln , "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3 .boss \<cong> Set{}") , (OCL.Writeln , "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3 /* unnamed attribute */ \<cong> Set{}") , (OCL.Writeln , "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4 .boss \<cong> Set{}") , (OCL.Writeln , "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4 /* unnamed attribute */ \<cong> Set{}") , (OCL.Writeln , "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5 .boss \<cong> Set{}") , (OCL.Writeln , "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5 /* unnamed attribute */ \<cong> Set{}") , (OCL.Writeln , "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6 .boss \<cong> Set{ X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n7 }") , (OCL.Writeln , "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6 /* unnamed attribute */ \<cong> Set{}") , (OCL.Writeln , "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n7 .boss \<cong> Set{ X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n7 }") , (OCL.Writeln , "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n7 /* unnamed attribute */ \<cong> Set{ X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6 , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n7 }") , (OCL.Writeln , "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9 .boss \<cong> Set{}") , (OCL.Writeln , "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9 /* unnamed attribute */ \<cong> Set{}") , (OCL.Writeln , "X0 .boss \<cong> Set{}") , (OCL.Writeln , "X0 /* unnamed attribute */ \<cong> Set{}")]) (" error(s)")) *}

(* 144 ************************************ 915 + 2 *)
definition "(typecheck_instance_bad_head_on_lhs092060\<^sub>s\<^sub>i\<^sub>g\<^sub>m\<^sub>a062092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>1\<^sub>_\<^sub>o\<^sub>b\<^sub>j\<^sub>e\<^sub>c\<^sub>t\<^sub>4\<^sub>_092060\<^sub>s\<^sub>i\<^sub>g\<^sub>m\<^sub>a062092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>1\<^sub>_\<^sub>o\<^sub>b\<^sub>j\<^sub>e\<^sub>c\<^sub>t\<^sub>2\<^sub>_092060\<^sub>s\<^sub>i\<^sub>g\<^sub>m\<^sub>a062092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>1\<^sub>_\<^sub>o\<^sub>b\<^sub>j\<^sub>e\<^sub>c\<^sub>t\<^sub>1\<^sub>_092060\<^sub>s\<^sub>i\<^sub>g\<^sub>m\<^sub>a062092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>1\<^sub>_\<^sub>o\<^sub>b\<^sub>j\<^sub>e\<^sub>c\<^sub>t\<^sub>0 (\<sigma>\<^sub>1_object4) (\<sigma>\<^sub>1_object2) (\<sigma>\<^sub>1_object1) (\<sigma>\<^sub>1_object0)) = ()"
definition "typecheck_instance_extra_variables_on_rhs092060\<^sub>s\<^sub>i\<^sub>g\<^sub>m\<^sub>a062092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>1\<^sub>_\<^sub>o\<^sub>b\<^sub>j\<^sub>e\<^sub>c\<^sub>t\<^sub>4\<^sub>_092060\<^sub>s\<^sub>i\<^sub>g\<^sub>m\<^sub>a062092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>1\<^sub>_\<^sub>o\<^sub>b\<^sub>j\<^sub>e\<^sub>c\<^sub>t\<^sub>2\<^sub>_092060\<^sub>s\<^sub>i\<^sub>g\<^sub>m\<^sub>a062092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>1\<^sub>_\<^sub>o\<^sub>b\<^sub>j\<^sub>e\<^sub>c\<^sub>t\<^sub>1\<^sub>_092060\<^sub>s\<^sub>i\<^sub>g\<^sub>m\<^sub>a062092060094\<^sub>s\<^sub>u\<^sub>b062\<^sub>1\<^sub>_\<^sub>o\<^sub>b\<^sub>j\<^sub>e\<^sub>c\<^sub>t\<^sub>0 = (\<lambda>\<sigma>\<^sub>1_object4 \<sigma>\<^sub>1_object2 \<sigma>\<^sub>1_object1 \<sigma>\<^sub>1_object0. (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5))"

(* 145 ************************************ 917 + 4 *)
definition "oid12 = 12"
definition "oid13 = 13"
definition "oid14 = 14"
definition "oid15 = 15"

(* 146 ************************************ 921 + 8 *)
definition "\<sigma>\<^sub>1_object0\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n = (mk\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n ((mk\<E>\<X>\<T>\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (oid12) (None) (None) (None) (None) (None))) (\<lfloor>1000\<rfloor>))"
definition "(\<sigma>\<^sub>1_object0::\<cdot>Person) = ((\<lambda>_. \<lfloor>\<lfloor>\<sigma>\<^sub>1_object0\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>))"
definition "\<sigma>\<^sub>1_object1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n = (mk\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n ((mk\<E>\<X>\<T>\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (oid13) (None) (None) (None) (None) (None))) (\<lfloor>1200\<rfloor>))"
definition "(\<sigma>\<^sub>1_object1::\<cdot>Person) = ((\<lambda>_. \<lfloor>\<lfloor>\<sigma>\<^sub>1_object1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>))"
definition "\<sigma>\<^sub>1_object2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n = (mk\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n ((mk\<E>\<X>\<T>\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (oid14) (None) (None) (None) (None) (None))) (\<lfloor>2600\<rfloor>))"
definition "(\<sigma>\<^sub>1_object2::\<cdot>Person) = ((\<lambda>_. \<lfloor>\<lfloor>\<sigma>\<^sub>1_object2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>))"
definition "\<sigma>\<^sub>1_object4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n = (mk\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n ((mk\<E>\<X>\<T>\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (oid15) (None) (None) (None) (None) (None))) (\<lfloor>2300\<rfloor>))"
definition "(\<sigma>\<^sub>1_object4::\<cdot>Person) = ((\<lambda>_. \<lfloor>\<lfloor>\<sigma>\<^sub>1_object4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>))"

(* 147 ************************************ 929 + 1 *)
ML{* (Ty'.check ([(OCL.Writeln , "\<sigma>\<^sub>1_object0 .boss \<cong> Set{ \<sigma>\<^sub>1_object1 }") , (OCL.Writeln , "\<sigma>\<^sub>1_object0 /* unnamed attribute */ \<cong> Set{}") , (OCL.Writeln , "\<sigma>\<^sub>1_object1 .boss \<cong> Set{}") , (OCL.Writeln , "\<sigma>\<^sub>1_object1 /* unnamed attribute */ \<cong> Set{ \<sigma>\<^sub>1_object0 }") , (OCL.Writeln , "\<sigma>\<^sub>1_object2 .boss \<cong> Set{ /*5*/ }") , (OCL.Writeln , "\<sigma>\<^sub>1_object2 /* unnamed attribute */ \<cong> Set{ \<sigma>\<^sub>1_object4 }") , (OCL.Writeln , "\<sigma>\<^sub>1_object4 .boss \<cong> Set{ \<sigma>\<^sub>1_object2 }") , (OCL.Writeln , "\<sigma>\<^sub>1_object4 /* unnamed attribute */ \<cong> Set{}")]) (" error(s)")) *}

(* 148 ************************************ 930 + 1 *)
locale state_\<sigma>\<^sub>1 =
fixes "oid12" :: "nat"
fixes "oid13" :: "nat"
fixes "oid14" :: "nat"
fixes "oid5" :: "nat"
fixes "oid15" :: "nat"
fixes "oid9" :: "nat"
assumes distinct_oid: "(distinct ([oid12 , oid13 , oid14 , oid5 , oid15 , oid9]))"
fixes "\<sigma>\<^sub>1_object0\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n" :: "ty\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n"
fixes "\<sigma>\<^sub>1_object0" :: "\<cdot>Person"
assumes \<sigma>\<^sub>1_object0_def: "\<sigma>\<^sub>1_object0 = (\<lambda>_. \<lfloor>\<lfloor>\<sigma>\<^sub>1_object0\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)"
fixes "\<sigma>\<^sub>1_object1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n" :: "ty\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n"
fixes "\<sigma>\<^sub>1_object1" :: "\<cdot>Person"
assumes \<sigma>\<^sub>1_object1_def: "\<sigma>\<^sub>1_object1 = (\<lambda>_. \<lfloor>\<lfloor>\<sigma>\<^sub>1_object1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)"
fixes "\<sigma>\<^sub>1_object2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n" :: "ty\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n"
fixes "\<sigma>\<^sub>1_object2" :: "\<cdot>Person"
assumes \<sigma>\<^sub>1_object2_def: "\<sigma>\<^sub>1_object2 = (\<lambda>_. \<lfloor>\<lfloor>\<sigma>\<^sub>1_object2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)"
fixes "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n" :: "ty\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n"
fixes "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5" :: "\<cdot>Person"
assumes X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5_def: "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5 = (\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)"
fixes "\<sigma>\<^sub>1_object4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n" :: "ty\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n"
fixes "\<sigma>\<^sub>1_object4" :: "\<cdot>Person"
assumes \<sigma>\<^sub>1_object4_def: "\<sigma>\<^sub>1_object4 = (\<lambda>_. \<lfloor>\<lfloor>\<sigma>\<^sub>1_object4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)"
fixes "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n" :: "ty\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n"
fixes "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9" :: "\<cdot>Person"
assumes X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9_def: "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9 = (\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)"
begin
definition "\<sigma>\<^sub>1 = (state.make ((Map.empty (oid12 \<mapsto> (in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object0\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))) (oid13 \<mapsto> (in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))) (oid14 \<mapsto> (in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))) (oid5 \<mapsto> (in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))) (oid15 \<mapsto> (in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))) (oid9 \<mapsto> (in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))) ((map_of_list ([(oid\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_0_\<b>\<o>\<s>\<s> , (List.map ((\<lambda>(x , y). [x , y]) o switch\<^sub>2_01) ([[[oid12] , [oid2]] , [[oid14] , [oid4]] , [[oid15] , [oid3]]])))]))))"

lemma dom_\<sigma>\<^sub>1 : "(dom ((heap (\<sigma>\<^sub>1)))) = {oid12 , oid13 , oid14 , oid5 , oid15 , oid9}"
by(auto simp: \<sigma>\<^sub>1_def)

lemmas[simp,code_unfold] = dom_\<sigma>\<^sub>1

lemma perm_\<sigma>\<^sub>1 : "\<sigma>\<^sub>1 = (state.make ((Map.empty (oid9 \<mapsto> (in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))) (oid15 \<mapsto> (in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))) (oid5 \<mapsto> (in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))) (oid14 \<mapsto> (in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))) (oid13 \<mapsto> (in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))) (oid12 \<mapsto> (in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object0\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))) ((assocs (\<sigma>\<^sub>1))))"
  apply(simp add: \<sigma>\<^sub>1_def)
  apply(subst (1) fun_upd_twist, metis distinct_oid distinct_length_2_or_more)
  apply(subst (2) fun_upd_twist, metis distinct_oid distinct_length_2_or_more)
  apply(subst (1) fun_upd_twist, metis distinct_oid distinct_length_2_or_more)
  apply(subst (3) fun_upd_twist, metis distinct_oid distinct_length_2_or_more)
  apply(subst (2) fun_upd_twist, metis distinct_oid distinct_length_2_or_more)
  apply(subst (1) fun_upd_twist, metis distinct_oid distinct_length_2_or_more)
  apply(subst (4) fun_upd_twist, metis distinct_oid distinct_length_2_or_more)
  apply(subst (3) fun_upd_twist, metis distinct_oid distinct_length_2_or_more)
  apply(subst (2) fun_upd_twist, metis distinct_oid distinct_length_2_or_more)
  apply(subst (1) fun_upd_twist, metis distinct_oid distinct_length_2_or_more)
  apply(subst (5) fun_upd_twist, metis distinct_oid distinct_length_2_or_more)
  apply(subst (4) fun_upd_twist, metis distinct_oid distinct_length_2_or_more)
  apply(subst (3) fun_upd_twist, metis distinct_oid distinct_length_2_or_more)
  apply(subst (2) fun_upd_twist, metis distinct_oid distinct_length_2_or_more)
  apply(subst (1) fun_upd_twist, metis distinct_oid distinct_length_2_or_more)
by(simp)

lemma \<sigma>\<^sub>1_OclAllInstances_generic_exec_Person : 
assumes [simp]: "(Person ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object0\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Person ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Person ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Person ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Person ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Person ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(\<And>a. (pre_post ((mk (a)))) = a)"
shows "(mk (\<sigma>\<^sub>1)) \<Turnstile> (OclAllInstances_generic (pre_post) (Person)) \<doteq> Set{\<sigma>\<^sub>1_object0 , \<sigma>\<^sub>1_object1 , \<sigma>\<^sub>1_object2 , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5 , \<sigma>\<^sub>1_object4 , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9}"
  apply(subst perm_\<sigma>\<^sub>1)
  apply(simp only: state.make_def \<sigma>\<^sub>1_object0_def \<sigma>\<^sub>1_object1_def \<sigma>\<^sub>1_object2_def X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5_def \<sigma>\<^sub>1_object4_def X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9_def)
  apply(subst state_update_vs_allInstances_generic_tc, simp, simp, (metis distinct_oid distinct_length_2_or_more)?, simp only: assms, blast, simp, rule const_StrictRefEq\<^sub>S\<^sub>e\<^sub>t_including, simp, simp, simp, rule OclIncluding_cong, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def)
  apply(subst state_update_vs_allInstances_generic_tc, simp, simp, (metis distinct_oid distinct_length_2_or_more)?, simp only: assms, blast, simp, rule const_StrictRefEq\<^sub>S\<^sub>e\<^sub>t_including, simp, simp, simp, rule OclIncluding_cong, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def)
  apply(subst state_update_vs_allInstances_generic_tc, simp, simp, (metis distinct_oid distinct_length_2_or_more)?, simp only: assms, blast, simp, rule const_StrictRefEq\<^sub>S\<^sub>e\<^sub>t_including, simp, simp, simp, rule OclIncluding_cong, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def)
  apply(subst state_update_vs_allInstances_generic_tc, simp, simp, (metis distinct_oid distinct_length_2_or_more)?, simp only: assms, blast, simp, rule const_StrictRefEq\<^sub>S\<^sub>e\<^sub>t_including, simp, simp, simp, rule OclIncluding_cong, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def)
  apply(subst state_update_vs_allInstances_generic_tc, simp, simp, (metis distinct_oid distinct_length_2_or_more)?, simp only: assms, blast, simp, rule const_StrictRefEq\<^sub>S\<^sub>e\<^sub>t_including, simp, simp, simp, rule OclIncluding_cong, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def)
  apply(subst state_update_vs_allInstances_generic_tc, simp, simp, (metis distinct_oid distinct_length_2_or_more)?, simp only: assms, blast, simp, rule const_StrictRefEq\<^sub>S\<^sub>e\<^sub>t_including, simp, simp, simp, rule OclIncluding_cong, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def)
  apply(rule state_update_vs_allInstances_generic_empty)
by(simp_all only: assms, (simp_all add: OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_\<AA>_def)?) 

lemma \<sigma>\<^sub>1_OclAllInstances_at_post_exec_Person : 
assumes [simp]: "(Person ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object0\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Person ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Person ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Person ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Person ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Person ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
shows "(st , \<sigma>\<^sub>1) \<Turnstile> (OclAllInstances_at_post (Person)) \<doteq> Set{\<sigma>\<^sub>1_object0 , \<sigma>\<^sub>1_object1 , \<sigma>\<^sub>1_object2 , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5 , \<sigma>\<^sub>1_object4 , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9}"
  unfolding OclAllInstances_at_post_def
by(rule \<sigma>\<^sub>1_OclAllInstances_generic_exec_Person, simp_all only: assms, simp_all) 

lemma \<sigma>\<^sub>1_OclAllInstances_at_pre_exec_Person : 
assumes [simp]: "(Person ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object0\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Person ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Person ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Person ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Person ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Person ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
shows "(\<sigma>\<^sub>1 , st) \<Turnstile> (OclAllInstances_at_pre (Person)) \<doteq> Set{\<sigma>\<^sub>1_object0 , \<sigma>\<^sub>1_object1 , \<sigma>\<^sub>1_object2 , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5 , \<sigma>\<^sub>1_object4 , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9}"
  unfolding OclAllInstances_at_pre_def
by(rule \<sigma>\<^sub>1_OclAllInstances_generic_exec_Person, simp_all only: assms, simp_all) 

lemma \<sigma>\<^sub>1_OclAllInstances_generic_exec_Planet : 
assumes [simp]: "(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object0\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(\<lambda>_. \<lfloor>(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object0\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>\<sigma>\<^sub>1_object0\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Planet))"
assumes [simp]: "(\<lambda>_. \<lfloor>(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>\<sigma>\<^sub>1_object1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Planet))"
assumes [simp]: "(\<lambda>_. \<lfloor>(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>\<sigma>\<^sub>1_object2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Planet))"
assumes [simp]: "(\<lambda>_. \<lfloor>(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Planet))"
assumes [simp]: "(\<lambda>_. \<lfloor>(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>\<sigma>\<^sub>1_object4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Planet))"
assumes [simp]: "(\<lambda>_. \<lfloor>(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Planet))"
assumes [simp]: "(\<And>a. (pre_post ((mk (a)))) = a)"
shows "(mk (\<sigma>\<^sub>1)) \<Turnstile> (OclAllInstances_generic (pre_post) (Planet)) \<doteq> Set{\<sigma>\<^sub>1_object0 .oclAsType(Planet) , \<sigma>\<^sub>1_object1 .oclAsType(Planet) , \<sigma>\<^sub>1_object2 .oclAsType(Planet) , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5 .oclAsType(Planet) , \<sigma>\<^sub>1_object4 .oclAsType(Planet) , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9 .oclAsType(Planet)}"
  apply(subst perm_\<sigma>\<^sub>1)
  apply(simp only: state.make_def \<sigma>\<^sub>1_object0_def \<sigma>\<^sub>1_object1_def \<sigma>\<^sub>1_object2_def X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5_def \<sigma>\<^sub>1_object4_def X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9_def)
  apply(subst state_update_vs_allInstances_generic_tc, simp, simp, (metis distinct_oid distinct_length_2_or_more)?, simp only: assms, blast, simp, rule const_StrictRefEq\<^sub>S\<^sub>e\<^sub>t_including, simp del: OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person, simp del: OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person, simp, rule OclIncluding_cong, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def)
  apply(subst state_update_vs_allInstances_generic_tc, simp, simp, (metis distinct_oid distinct_length_2_or_more)?, simp only: assms, blast, simp, rule const_StrictRefEq\<^sub>S\<^sub>e\<^sub>t_including, simp del: OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person, simp del: OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person, simp, rule OclIncluding_cong, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def)
  apply(subst state_update_vs_allInstances_generic_tc, simp, simp, (metis distinct_oid distinct_length_2_or_more)?, simp only: assms, blast, simp, rule const_StrictRefEq\<^sub>S\<^sub>e\<^sub>t_including, simp del: OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person, simp del: OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person, simp, rule OclIncluding_cong, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def)
  apply(subst state_update_vs_allInstances_generic_tc, simp, simp, (metis distinct_oid distinct_length_2_or_more)?, simp only: assms, blast, simp, rule const_StrictRefEq\<^sub>S\<^sub>e\<^sub>t_including, simp del: OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person, simp del: OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person, simp, rule OclIncluding_cong, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def)
  apply(subst state_update_vs_allInstances_generic_tc, simp, simp, (metis distinct_oid distinct_length_2_or_more)?, simp only: assms, blast, simp, rule const_StrictRefEq\<^sub>S\<^sub>e\<^sub>t_including, simp del: OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person, simp del: OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person, simp, rule OclIncluding_cong, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def)
  apply(subst state_update_vs_allInstances_generic_tc, simp, simp, (metis distinct_oid distinct_length_2_or_more)?, simp only: assms, blast, simp, rule const_StrictRefEq\<^sub>S\<^sub>e\<^sub>t_including, simp del: OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person, simp del: OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person, simp, rule OclIncluding_cong, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def)
  apply(rule state_update_vs_allInstances_generic_empty)
by(simp_all only: assms, (simp_all add: OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_\<AA>_def)?) 

lemma \<sigma>\<^sub>1_OclAllInstances_at_post_exec_Planet : 
assumes [simp]: "(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object0\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(\<lambda>_. \<lfloor>(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object0\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>\<sigma>\<^sub>1_object0\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Planet))"
assumes [simp]: "(\<lambda>_. \<lfloor>(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>\<sigma>\<^sub>1_object1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Planet))"
assumes [simp]: "(\<lambda>_. \<lfloor>(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>\<sigma>\<^sub>1_object2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Planet))"
assumes [simp]: "(\<lambda>_. \<lfloor>(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Planet))"
assumes [simp]: "(\<lambda>_. \<lfloor>(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>\<sigma>\<^sub>1_object4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Planet))"
assumes [simp]: "(\<lambda>_. \<lfloor>(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Planet))"
shows "(st , \<sigma>\<^sub>1) \<Turnstile> (OclAllInstances_at_post (Planet)) \<doteq> Set{\<sigma>\<^sub>1_object0 .oclAsType(Planet) , \<sigma>\<^sub>1_object1 .oclAsType(Planet) , \<sigma>\<^sub>1_object2 .oclAsType(Planet) , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5 .oclAsType(Planet) , \<sigma>\<^sub>1_object4 .oclAsType(Planet) , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9 .oclAsType(Planet)}"
  unfolding OclAllInstances_at_post_def
by(rule \<sigma>\<^sub>1_OclAllInstances_generic_exec_Planet, simp_all only: assms, simp_all) 

lemma \<sigma>\<^sub>1_OclAllInstances_at_pre_exec_Planet : 
assumes [simp]: "(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object0\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(\<lambda>_. \<lfloor>(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object0\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>\<sigma>\<^sub>1_object0\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Planet))"
assumes [simp]: "(\<lambda>_. \<lfloor>(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>\<sigma>\<^sub>1_object1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Planet))"
assumes [simp]: "(\<lambda>_. \<lfloor>(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>\<sigma>\<^sub>1_object2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Planet))"
assumes [simp]: "(\<lambda>_. \<lfloor>(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Planet))"
assumes [simp]: "(\<lambda>_. \<lfloor>(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>\<sigma>\<^sub>1_object4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Planet))"
assumes [simp]: "(\<lambda>_. \<lfloor>(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Planet))"
shows "(\<sigma>\<^sub>1 , st) \<Turnstile> (OclAllInstances_at_pre (Planet)) \<doteq> Set{\<sigma>\<^sub>1_object0 .oclAsType(Planet) , \<sigma>\<^sub>1_object1 .oclAsType(Planet) , \<sigma>\<^sub>1_object2 .oclAsType(Planet) , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5 .oclAsType(Planet) , \<sigma>\<^sub>1_object4 .oclAsType(Planet) , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9 .oclAsType(Planet)}"
  unfolding OclAllInstances_at_pre_def
by(rule \<sigma>\<^sub>1_OclAllInstances_generic_exec_Planet, simp_all only: assms, simp_all) 

lemma \<sigma>\<^sub>1_OclAllInstances_generic_exec_Galaxy : 
assumes [simp]: "(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object0\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(\<lambda>_. \<lfloor>(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object0\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>\<sigma>\<^sub>1_object0\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Galaxy))"
assumes [simp]: "(\<lambda>_. \<lfloor>(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>\<sigma>\<^sub>1_object1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Galaxy))"
assumes [simp]: "(\<lambda>_. \<lfloor>(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>\<sigma>\<^sub>1_object2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Galaxy))"
assumes [simp]: "(\<lambda>_. \<lfloor>(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Galaxy))"
assumes [simp]: "(\<lambda>_. \<lfloor>(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>\<sigma>\<^sub>1_object4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Galaxy))"
assumes [simp]: "(\<lambda>_. \<lfloor>(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Galaxy))"
assumes [simp]: "(\<And>a. (pre_post ((mk (a)))) = a)"
shows "(mk (\<sigma>\<^sub>1)) \<Turnstile> (OclAllInstances_generic (pre_post) (Galaxy)) \<doteq> Set{\<sigma>\<^sub>1_object0 .oclAsType(Galaxy) , \<sigma>\<^sub>1_object1 .oclAsType(Galaxy) , \<sigma>\<^sub>1_object2 .oclAsType(Galaxy) , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5 .oclAsType(Galaxy) , \<sigma>\<^sub>1_object4 .oclAsType(Galaxy) , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9 .oclAsType(Galaxy)}"
  apply(subst perm_\<sigma>\<^sub>1)
  apply(simp only: state.make_def \<sigma>\<^sub>1_object0_def \<sigma>\<^sub>1_object1_def \<sigma>\<^sub>1_object2_def X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5_def \<sigma>\<^sub>1_object4_def X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9_def)
  apply(subst state_update_vs_allInstances_generic_tc, simp, simp, (metis distinct_oid distinct_length_2_or_more)?, simp only: assms, blast, simp, rule const_StrictRefEq\<^sub>S\<^sub>e\<^sub>t_including, simp del: OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person, simp del: OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person, simp, rule OclIncluding_cong, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def)
  apply(subst state_update_vs_allInstances_generic_tc, simp, simp, (metis distinct_oid distinct_length_2_or_more)?, simp only: assms, blast, simp, rule const_StrictRefEq\<^sub>S\<^sub>e\<^sub>t_including, simp del: OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person, simp del: OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person, simp, rule OclIncluding_cong, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def)
  apply(subst state_update_vs_allInstances_generic_tc, simp, simp, (metis distinct_oid distinct_length_2_or_more)?, simp only: assms, blast, simp, rule const_StrictRefEq\<^sub>S\<^sub>e\<^sub>t_including, simp del: OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person, simp del: OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person, simp, rule OclIncluding_cong, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def)
  apply(subst state_update_vs_allInstances_generic_tc, simp, simp, (metis distinct_oid distinct_length_2_or_more)?, simp only: assms, blast, simp, rule const_StrictRefEq\<^sub>S\<^sub>e\<^sub>t_including, simp del: OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person, simp del: OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person, simp, rule OclIncluding_cong, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def)
  apply(subst state_update_vs_allInstances_generic_tc, simp, simp, (metis distinct_oid distinct_length_2_or_more)?, simp only: assms, blast, simp, rule const_StrictRefEq\<^sub>S\<^sub>e\<^sub>t_including, simp del: OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person, simp del: OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person, simp, rule OclIncluding_cong, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def)
  apply(subst state_update_vs_allInstances_generic_tc, simp, simp, (metis distinct_oid distinct_length_2_or_more)?, simp only: assms, blast, simp, rule const_StrictRefEq\<^sub>S\<^sub>e\<^sub>t_including, simp del: OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person, simp del: OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person, simp, rule OclIncluding_cong, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def)
  apply(rule state_update_vs_allInstances_generic_empty)
by(simp_all only: assms, (simp_all add: OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_\<AA>_def)?) 

lemma \<sigma>\<^sub>1_OclAllInstances_at_post_exec_Galaxy : 
assumes [simp]: "(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object0\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(\<lambda>_. \<lfloor>(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object0\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>\<sigma>\<^sub>1_object0\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Galaxy))"
assumes [simp]: "(\<lambda>_. \<lfloor>(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>\<sigma>\<^sub>1_object1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Galaxy))"
assumes [simp]: "(\<lambda>_. \<lfloor>(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>\<sigma>\<^sub>1_object2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Galaxy))"
assumes [simp]: "(\<lambda>_. \<lfloor>(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Galaxy))"
assumes [simp]: "(\<lambda>_. \<lfloor>(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>\<sigma>\<^sub>1_object4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Galaxy))"
assumes [simp]: "(\<lambda>_. \<lfloor>(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Galaxy))"
shows "(st , \<sigma>\<^sub>1) \<Turnstile> (OclAllInstances_at_post (Galaxy)) \<doteq> Set{\<sigma>\<^sub>1_object0 .oclAsType(Galaxy) , \<sigma>\<^sub>1_object1 .oclAsType(Galaxy) , \<sigma>\<^sub>1_object2 .oclAsType(Galaxy) , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5 .oclAsType(Galaxy) , \<sigma>\<^sub>1_object4 .oclAsType(Galaxy) , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9 .oclAsType(Galaxy)}"
  unfolding OclAllInstances_at_post_def
by(rule \<sigma>\<^sub>1_OclAllInstances_generic_exec_Galaxy, simp_all only: assms, simp_all) 

lemma \<sigma>\<^sub>1_OclAllInstances_at_pre_exec_Galaxy : 
assumes [simp]: "(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object0\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(\<lambda>_. \<lfloor>(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object0\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>\<sigma>\<^sub>1_object0\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Galaxy))"
assumes [simp]: "(\<lambda>_. \<lfloor>(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>\<sigma>\<^sub>1_object1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Galaxy))"
assumes [simp]: "(\<lambda>_. \<lfloor>(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>\<sigma>\<^sub>1_object2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Galaxy))"
assumes [simp]: "(\<lambda>_. \<lfloor>(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Galaxy))"
assumes [simp]: "(\<lambda>_. \<lfloor>(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>\<sigma>\<^sub>1_object4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Galaxy))"
assumes [simp]: "(\<lambda>_. \<lfloor>(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Galaxy))"
shows "(\<sigma>\<^sub>1 , st) \<Turnstile> (OclAllInstances_at_pre (Galaxy)) \<doteq> Set{\<sigma>\<^sub>1_object0 .oclAsType(Galaxy) , \<sigma>\<^sub>1_object1 .oclAsType(Galaxy) , \<sigma>\<^sub>1_object2 .oclAsType(Galaxy) , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5 .oclAsType(Galaxy) , \<sigma>\<^sub>1_object4 .oclAsType(Galaxy) , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9 .oclAsType(Galaxy)}"
  unfolding OclAllInstances_at_pre_def
by(rule \<sigma>\<^sub>1_OclAllInstances_generic_exec_Galaxy, simp_all only: assms, simp_all) 

lemma \<sigma>\<^sub>1_OclAllInstances_generic_exec_OclAny : 
assumes [simp]: "(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object0\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(\<lambda>_. \<lfloor>(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object0\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>\<sigma>\<^sub>1_object0\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(OclAny))"
assumes [simp]: "(\<lambda>_. \<lfloor>(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>\<sigma>\<^sub>1_object1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(OclAny))"
assumes [simp]: "(\<lambda>_. \<lfloor>(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>\<sigma>\<^sub>1_object2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(OclAny))"
assumes [simp]: "(\<lambda>_. \<lfloor>(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(OclAny))"
assumes [simp]: "(\<lambda>_. \<lfloor>(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>\<sigma>\<^sub>1_object4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(OclAny))"
assumes [simp]: "(\<lambda>_. \<lfloor>(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(OclAny))"
assumes [simp]: "(\<And>a. (pre_post ((mk (a)))) = a)"
shows "(mk (\<sigma>\<^sub>1)) \<Turnstile> (OclAllInstances_generic (pre_post) (OclAny)) \<doteq> Set{\<sigma>\<^sub>1_object0 .oclAsType(OclAny) , \<sigma>\<^sub>1_object1 .oclAsType(OclAny) , \<sigma>\<^sub>1_object2 .oclAsType(OclAny) , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5 .oclAsType(OclAny) , \<sigma>\<^sub>1_object4 .oclAsType(OclAny) , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9 .oclAsType(OclAny)}"
  apply(subst perm_\<sigma>\<^sub>1)
  apply(simp only: state.make_def \<sigma>\<^sub>1_object0_def \<sigma>\<^sub>1_object1_def \<sigma>\<^sub>1_object2_def X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5_def \<sigma>\<^sub>1_object4_def X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9_def)
  apply(subst state_update_vs_allInstances_generic_tc, simp, simp, (metis distinct_oid distinct_length_2_or_more)?, simp only: assms, blast, simp, rule const_StrictRefEq\<^sub>S\<^sub>e\<^sub>t_including, simp del: OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person, simp del: OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person, simp, rule OclIncluding_cong, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def)
  apply(subst state_update_vs_allInstances_generic_tc, simp, simp, (metis distinct_oid distinct_length_2_or_more)?, simp only: assms, blast, simp, rule const_StrictRefEq\<^sub>S\<^sub>e\<^sub>t_including, simp del: OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person, simp del: OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person, simp, rule OclIncluding_cong, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def)
  apply(subst state_update_vs_allInstances_generic_tc, simp, simp, (metis distinct_oid distinct_length_2_or_more)?, simp only: assms, blast, simp, rule const_StrictRefEq\<^sub>S\<^sub>e\<^sub>t_including, simp del: OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person, simp del: OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person, simp, rule OclIncluding_cong, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def)
  apply(subst state_update_vs_allInstances_generic_tc, simp, simp, (metis distinct_oid distinct_length_2_or_more)?, simp only: assms, blast, simp, rule const_StrictRefEq\<^sub>S\<^sub>e\<^sub>t_including, simp del: OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person, simp del: OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person, simp, rule OclIncluding_cong, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def)
  apply(subst state_update_vs_allInstances_generic_tc, simp, simp, (metis distinct_oid distinct_length_2_or_more)?, simp only: assms, blast, simp, rule const_StrictRefEq\<^sub>S\<^sub>e\<^sub>t_including, simp del: OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person, simp del: OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person, simp, rule OclIncluding_cong, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def)
  apply(subst state_update_vs_allInstances_generic_tc, simp, simp, (metis distinct_oid distinct_length_2_or_more)?, simp only: assms, blast, simp, rule const_StrictRefEq\<^sub>S\<^sub>e\<^sub>t_including, simp del: OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person, simp del: OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person, simp, rule OclIncluding_cong, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def)
  apply(rule state_update_vs_allInstances_generic_empty)
by(simp_all only: assms, (simp_all add: OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_\<AA>_def)?) 

lemma \<sigma>\<^sub>1_OclAllInstances_at_post_exec_OclAny : 
assumes [simp]: "(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object0\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(\<lambda>_. \<lfloor>(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object0\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>\<sigma>\<^sub>1_object0\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(OclAny))"
assumes [simp]: "(\<lambda>_. \<lfloor>(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>\<sigma>\<^sub>1_object1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(OclAny))"
assumes [simp]: "(\<lambda>_. \<lfloor>(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>\<sigma>\<^sub>1_object2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(OclAny))"
assumes [simp]: "(\<lambda>_. \<lfloor>(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(OclAny))"
assumes [simp]: "(\<lambda>_. \<lfloor>(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>\<sigma>\<^sub>1_object4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(OclAny))"
assumes [simp]: "(\<lambda>_. \<lfloor>(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(OclAny))"
shows "(st , \<sigma>\<^sub>1) \<Turnstile> (OclAllInstances_at_post (OclAny)) \<doteq> Set{\<sigma>\<^sub>1_object0 .oclAsType(OclAny) , \<sigma>\<^sub>1_object1 .oclAsType(OclAny) , \<sigma>\<^sub>1_object2 .oclAsType(OclAny) , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5 .oclAsType(OclAny) , \<sigma>\<^sub>1_object4 .oclAsType(OclAny) , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9 .oclAsType(OclAny)}"
  unfolding OclAllInstances_at_post_def
by(rule \<sigma>\<^sub>1_OclAllInstances_generic_exec_OclAny, simp_all only: assms, simp_all) 

lemma \<sigma>\<^sub>1_OclAllInstances_at_pre_exec_OclAny : 
assumes [simp]: "(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object0\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(\<lambda>_. \<lfloor>(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object0\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>\<sigma>\<^sub>1_object0\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(OclAny))"
assumes [simp]: "(\<lambda>_. \<lfloor>(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>\<sigma>\<^sub>1_object1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(OclAny))"
assumes [simp]: "(\<lambda>_. \<lfloor>(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>\<sigma>\<^sub>1_object2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(OclAny))"
assumes [simp]: "(\<lambda>_. \<lfloor>(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(OclAny))"
assumes [simp]: "(\<lambda>_. \<lfloor>(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>\<sigma>\<^sub>1_object4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(OclAny))"
assumes [simp]: "(\<lambda>_. \<lfloor>(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(OclAny))"
shows "(\<sigma>\<^sub>1 , st) \<Turnstile> (OclAllInstances_at_pre (OclAny)) \<doteq> Set{\<sigma>\<^sub>1_object0 .oclAsType(OclAny) , \<sigma>\<^sub>1_object1 .oclAsType(OclAny) , \<sigma>\<^sub>1_object2 .oclAsType(OclAny) , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5 .oclAsType(OclAny) , \<sigma>\<^sub>1_object4 .oclAsType(OclAny) , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9 .oclAsType(OclAny)}"
  unfolding OclAllInstances_at_pre_def
by(rule \<sigma>\<^sub>1_OclAllInstances_generic_exec_OclAny, simp_all only: assms, simp_all) 

ML{* (Ty'.check ([]) (" error(s)")) *}
end

(* 149 ************************************ 931 + 1 *)
locale state_\<sigma>\<^sub>1' =
fixes "oid1" :: "nat"
fixes "oid2" :: "nat"
fixes "oid3" :: "nat"
fixes "oid4" :: "nat"
fixes "oid6" :: "nat"
fixes "oid7" :: "nat"
fixes "oid8" :: "nat"
fixes "oid9" :: "nat"
assumes distinct_oid: "(distinct ([oid1 , oid2 , oid3 , oid4 , oid6 , oid7 , oid8 , oid9]))"
fixes "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n" :: "ty\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n"
fixes "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1" :: "\<cdot>Person"
assumes X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1_def: "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1 = (\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)"
fixes "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n" :: "ty\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n"
fixes "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2" :: "\<cdot>Person"
assumes X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2_def: "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2 = (\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)"
fixes "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n" :: "ty\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n"
fixes "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3" :: "\<cdot>Person"
assumes X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3_def: "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3 = (\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)"
fixes "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n" :: "ty\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n"
fixes "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4" :: "\<cdot>Person"
assumes X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4_def: "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4 = (\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)"
fixes "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n" :: "ty\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n"
fixes "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6" :: "\<cdot>Person"
assumes X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6_def: "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6 = (\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)"
fixes "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n7\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y" :: "ty\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y"
fixes "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n7" :: "\<cdot>OclAny"
assumes X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n7_def: "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n7 = (\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n7\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y\<rfloor>\<rfloor>)"
fixes "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n8\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y" :: "ty\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y"
fixes "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n8" :: "\<cdot>OclAny"
assumes X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n8_def: "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n8 = (\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n8\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y\<rfloor>\<rfloor>)"
fixes "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n" :: "ty\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n"
fixes "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9" :: "\<cdot>Person"
assumes X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9_def: "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9 = (\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)"
begin
definition "\<sigma>\<^sub>1' = (state.make ((Map.empty (oid1 \<mapsto> (in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))) (oid2 \<mapsto> (in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))) (oid3 \<mapsto> (in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))) (oid4 \<mapsto> (in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))) (oid6 \<mapsto> (in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))) (oid7 \<mapsto> (in\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n7\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y))) (oid8 \<mapsto> (in\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n8\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y))) (oid9 \<mapsto> (in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))) ((map_of_list ([(oid\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_0_\<b>\<o>\<s>\<s> , (List.map ((\<lambda>(x , y). [x , y]) o switch\<^sub>2_01) ([[[oid1] , [oid2]] , [[oid2] , [oid2]] , [[oid6] , [oid6]] , [[oid7] , [oid6]]])))]))))"

lemma dom_\<sigma>\<^sub>1' : "(dom ((heap (\<sigma>\<^sub>1')))) = {oid1 , oid2 , oid3 , oid4 , oid6 , oid7 , oid8 , oid9}"
by(auto simp: \<sigma>\<^sub>1'_def)

lemmas[simp,code_unfold] = dom_\<sigma>\<^sub>1'

lemma perm_\<sigma>\<^sub>1' : "\<sigma>\<^sub>1' = (state.make ((Map.empty (oid9 \<mapsto> (in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))) (oid8 \<mapsto> (in\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n8\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y))) (oid7 \<mapsto> (in\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n7\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y))) (oid6 \<mapsto> (in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))) (oid4 \<mapsto> (in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))) (oid3 \<mapsto> (in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))) (oid2 \<mapsto> (in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))) (oid1 \<mapsto> (in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))) ((assocs (\<sigma>\<^sub>1'))))"
  apply(simp add: \<sigma>\<^sub>1'_def)
  apply(subst (1) fun_upd_twist, metis distinct_oid distinct_length_2_or_more)
  apply(subst (2) fun_upd_twist, metis distinct_oid distinct_length_2_or_more)
  apply(subst (1) fun_upd_twist, metis distinct_oid distinct_length_2_or_more)
  apply(subst (3) fun_upd_twist, metis distinct_oid distinct_length_2_or_more)
  apply(subst (2) fun_upd_twist, metis distinct_oid distinct_length_2_or_more)
  apply(subst (1) fun_upd_twist, metis distinct_oid distinct_length_2_or_more)
  apply(subst (4) fun_upd_twist, metis distinct_oid distinct_length_2_or_more)
  apply(subst (3) fun_upd_twist, metis distinct_oid distinct_length_2_or_more)
  apply(subst (2) fun_upd_twist, metis distinct_oid distinct_length_2_or_more)
  apply(subst (1) fun_upd_twist, metis distinct_oid distinct_length_2_or_more)
  apply(subst (5) fun_upd_twist, metis distinct_oid distinct_length_2_or_more)
  apply(subst (4) fun_upd_twist, metis distinct_oid distinct_length_2_or_more)
  apply(subst (3) fun_upd_twist, metis distinct_oid distinct_length_2_or_more)
  apply(subst (2) fun_upd_twist, metis distinct_oid distinct_length_2_or_more)
  apply(subst (1) fun_upd_twist, metis distinct_oid distinct_length_2_or_more)
  apply(subst (6) fun_upd_twist, metis distinct_oid distinct_length_2_or_more)
  apply(subst (5) fun_upd_twist, metis distinct_oid distinct_length_2_or_more)
  apply(subst (4) fun_upd_twist, metis distinct_oid distinct_length_2_or_more)
  apply(subst (3) fun_upd_twist, metis distinct_oid distinct_length_2_or_more)
  apply(subst (2) fun_upd_twist, metis distinct_oid distinct_length_2_or_more)
  apply(subst (1) fun_upd_twist, metis distinct_oid distinct_length_2_or_more)
  apply(subst (7) fun_upd_twist, metis distinct_oid distinct_length_2_or_more)
  apply(subst (6) fun_upd_twist, metis distinct_oid distinct_length_2_or_more)
  apply(subst (5) fun_upd_twist, metis distinct_oid distinct_length_2_or_more)
  apply(subst (4) fun_upd_twist, metis distinct_oid distinct_length_2_or_more)
  apply(subst (3) fun_upd_twist, metis distinct_oid distinct_length_2_or_more)
  apply(subst (2) fun_upd_twist, metis distinct_oid distinct_length_2_or_more)
  apply(subst (1) fun_upd_twist, metis distinct_oid distinct_length_2_or_more)
by(simp)

lemma \<sigma>\<^sub>1'_OclAllInstances_generic_exec_Person : 
assumes [simp]: "(Person ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Person ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Person ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Person ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Person ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Person ((in\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n7\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y)))) \<noteq> None"
assumes [simp]: "(Person ((in\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n8\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y)))) = None"
assumes [simp]: "(Person ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(\<lambda>_. \<lfloor>(Person ((in\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n7\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n7\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y\<rfloor>\<rfloor>)::\<cdot>OclAny)) .oclAsType(Person))"
assumes [simp]: "(\<And>a. (pre_post ((mk (a)))) = a)"
shows "(mk (\<sigma>\<^sub>1')) \<Turnstile> (OclAllInstances_generic (pre_post) (Person)) \<doteq> Set{X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1 , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2 , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3 , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4 , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6 , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n7 .oclAsType(Person) , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9}"
  apply(subst perm_\<sigma>\<^sub>1')
  apply(simp only: state.make_def X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1_def X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2_def X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3_def X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4_def X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6_def X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n7_def X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9_def)
  apply(subst state_update_vs_allInstances_generic_tc, simp, simp, (metis distinct_oid distinct_length_2_or_more)?, simp only: assms, blast, simp, rule const_StrictRefEq\<^sub>S\<^sub>e\<^sub>t_including, simp del: OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny, simp del: OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny, simp, rule OclIncluding_cong, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def)
  apply(subst state_update_vs_allInstances_generic_tc, simp, simp, (metis distinct_oid distinct_length_2_or_more)?, simp only: assms, blast, simp, rule const_StrictRefEq\<^sub>S\<^sub>e\<^sub>t_including, simp del: OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny, simp del: OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny, simp, rule OclIncluding_cong, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def)
  apply(subst state_update_vs_allInstances_generic_tc, simp, simp, (metis distinct_oid distinct_length_2_or_more)?, simp only: assms, blast, simp, rule const_StrictRefEq\<^sub>S\<^sub>e\<^sub>t_including, simp del: OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny, simp del: OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny, simp, rule OclIncluding_cong, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def)
  apply(subst state_update_vs_allInstances_generic_tc, simp, simp, (metis distinct_oid distinct_length_2_or_more)?, simp only: assms, blast, simp, rule const_StrictRefEq\<^sub>S\<^sub>e\<^sub>t_including, simp del: OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny, simp del: OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny, simp, rule OclIncluding_cong, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def)
  apply(subst state_update_vs_allInstances_generic_tc, simp, simp, (metis distinct_oid distinct_length_2_or_more)?, simp only: assms, blast, simp, rule const_StrictRefEq\<^sub>S\<^sub>e\<^sub>t_including, simp del: OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny, simp del: OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny, simp, rule OclIncluding_cong, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def)
  apply(subst state_update_vs_allInstances_generic_tc, simp, simp, (metis distinct_oid distinct_length_2_or_more)?, simp only: assms, blast, simp, rule const_StrictRefEq\<^sub>S\<^sub>e\<^sub>t_including, simp del: OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny, simp del: OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny, simp, rule OclIncluding_cong, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def)
  apply(subst state_update_vs_allInstances_generic_ntc, simp, simp, (metis distinct_oid distinct_length_2_or_more)?, simp only: assms, simp, rule const_StrictRefEq\<^sub>S\<^sub>e\<^sub>t_including, simp del: OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny, simp del: OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny, simp)
  apply(subst state_update_vs_allInstances_generic_tc, simp, simp, (metis distinct_oid distinct_length_2_or_more)?, simp only: assms, blast, simp, rule const_StrictRefEq\<^sub>S\<^sub>e\<^sub>t_including, simp del: OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny, simp del: OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_OclAny, simp, rule OclIncluding_cong, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def)
  apply(rule state_update_vs_allInstances_generic_empty)
by(simp_all only: assms, (simp_all add: OclAsType\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n_\<AA>_def)?) 

lemma \<sigma>\<^sub>1'_OclAllInstances_at_post_exec_Person : 
assumes [simp]: "(Person ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Person ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Person ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Person ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Person ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Person ((in\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n7\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y)))) \<noteq> None"
assumes [simp]: "(Person ((in\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n8\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y)))) = None"
assumes [simp]: "(Person ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(\<lambda>_. \<lfloor>(Person ((in\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n7\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n7\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y\<rfloor>\<rfloor>)::\<cdot>OclAny)) .oclAsType(Person))"
shows "(st , \<sigma>\<^sub>1') \<Turnstile> (OclAllInstances_at_post (Person)) \<doteq> Set{X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1 , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2 , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3 , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4 , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6 , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n7 .oclAsType(Person) , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9}"
  unfolding OclAllInstances_at_post_def
by(rule \<sigma>\<^sub>1'_OclAllInstances_generic_exec_Person, simp_all only: assms, simp_all) 

lemma \<sigma>\<^sub>1'_OclAllInstances_at_pre_exec_Person : 
assumes [simp]: "(Person ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Person ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Person ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Person ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Person ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Person ((in\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n7\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y)))) \<noteq> None"
assumes [simp]: "(Person ((in\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n8\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y)))) = None"
assumes [simp]: "(Person ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(\<lambda>_. \<lfloor>(Person ((in\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n7\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n7\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y\<rfloor>\<rfloor>)::\<cdot>OclAny)) .oclAsType(Person))"
shows "(\<sigma>\<^sub>1' , st) \<Turnstile> (OclAllInstances_at_pre (Person)) \<doteq> Set{X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1 , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2 , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3 , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4 , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6 , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n7 .oclAsType(Person) , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9}"
  unfolding OclAllInstances_at_pre_def
by(rule \<sigma>\<^sub>1'_OclAllInstances_generic_exec_Person, simp_all only: assms, simp_all) 

lemma \<sigma>\<^sub>1'_OclAllInstances_generic_exec_Planet : 
assumes [simp]: "(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Planet ((in\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n7\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y)))) = None"
assumes [simp]: "(Planet ((in\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n8\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y)))) = None"
assumes [simp]: "(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(\<lambda>_. \<lfloor>(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Planet))"
assumes [simp]: "(\<lambda>_. \<lfloor>(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Planet))"
assumes [simp]: "(\<lambda>_. \<lfloor>(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Planet))"
assumes [simp]: "(\<lambda>_. \<lfloor>(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Planet))"
assumes [simp]: "(\<lambda>_. \<lfloor>(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Planet))"
assumes [simp]: "(\<lambda>_. \<lfloor>(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Planet))"
assumes [simp]: "(\<And>a. (pre_post ((mk (a)))) = a)"
shows "(mk (\<sigma>\<^sub>1')) \<Turnstile> (OclAllInstances_generic (pre_post) (Planet)) \<doteq> Set{X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1 .oclAsType(Planet) , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2 .oclAsType(Planet) , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3 .oclAsType(Planet) , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4 .oclAsType(Planet) , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6 .oclAsType(Planet) , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9 .oclAsType(Planet)}"
  apply(subst perm_\<sigma>\<^sub>1')
  apply(simp only: state.make_def X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1_def X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2_def X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3_def X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4_def X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6_def X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9_def)
  apply(subst state_update_vs_allInstances_generic_tc, simp, simp, (metis distinct_oid distinct_length_2_or_more)?, simp only: assms, blast, simp, rule const_StrictRefEq\<^sub>S\<^sub>e\<^sub>t_including, simp del: OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person, simp del: OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person, simp, rule OclIncluding_cong, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def)
  apply(subst state_update_vs_allInstances_generic_tc, simp, simp, (metis distinct_oid distinct_length_2_or_more)?, simp only: assms, blast, simp, rule const_StrictRefEq\<^sub>S\<^sub>e\<^sub>t_including, simp del: OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person, simp del: OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person, simp, rule OclIncluding_cong, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def)
  apply(subst state_update_vs_allInstances_generic_tc, simp, simp, (metis distinct_oid distinct_length_2_or_more)?, simp only: assms, blast, simp, rule const_StrictRefEq\<^sub>S\<^sub>e\<^sub>t_including, simp del: OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person, simp del: OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person, simp, rule OclIncluding_cong, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def)
  apply(subst state_update_vs_allInstances_generic_tc, simp, simp, (metis distinct_oid distinct_length_2_or_more)?, simp only: assms, blast, simp, rule const_StrictRefEq\<^sub>S\<^sub>e\<^sub>t_including, simp del: OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person, simp del: OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person, simp, rule OclIncluding_cong, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def)
  apply(subst state_update_vs_allInstances_generic_tc, simp, simp, (metis distinct_oid distinct_length_2_or_more)?, simp only: assms, blast, simp, rule const_StrictRefEq\<^sub>S\<^sub>e\<^sub>t_including, simp del: OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person, simp del: OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person, simp, rule OclIncluding_cong, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def)
  apply(subst state_update_vs_allInstances_generic_ntc, simp, simp, (metis distinct_oid distinct_length_2_or_more)?, simp only: assms, simp, rule const_StrictRefEq\<^sub>S\<^sub>e\<^sub>t_including, simp del: OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person, simp del: OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person, simp)
  apply(subst state_update_vs_allInstances_generic_ntc, simp, simp, (metis distinct_oid distinct_length_2_or_more)?, simp only: assms, simp, rule const_StrictRefEq\<^sub>S\<^sub>e\<^sub>t_including, simp del: OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person, simp del: OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person, simp)
  apply(subst state_update_vs_allInstances_generic_tc, simp, simp, (metis distinct_oid distinct_length_2_or_more)?, simp only: assms, blast, simp, rule const_StrictRefEq\<^sub>S\<^sub>e\<^sub>t_including, simp del: OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person, simp del: OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_Person, simp, rule OclIncluding_cong, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def)
  apply(rule state_update_vs_allInstances_generic_empty)
by(simp_all only: assms, (simp_all add: OclAsType\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>e\<^sub>t_\<AA>_def)?) 

lemma \<sigma>\<^sub>1'_OclAllInstances_at_post_exec_Planet : 
assumes [simp]: "(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Planet ((in\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n7\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y)))) = None"
assumes [simp]: "(Planet ((in\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n8\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y)))) = None"
assumes [simp]: "(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(\<lambda>_. \<lfloor>(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Planet))"
assumes [simp]: "(\<lambda>_. \<lfloor>(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Planet))"
assumes [simp]: "(\<lambda>_. \<lfloor>(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Planet))"
assumes [simp]: "(\<lambda>_. \<lfloor>(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Planet))"
assumes [simp]: "(\<lambda>_. \<lfloor>(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Planet))"
assumes [simp]: "(\<lambda>_. \<lfloor>(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Planet))"
shows "(st , \<sigma>\<^sub>1') \<Turnstile> (OclAllInstances_at_post (Planet)) \<doteq> Set{X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1 .oclAsType(Planet) , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2 .oclAsType(Planet) , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3 .oclAsType(Planet) , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4 .oclAsType(Planet) , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6 .oclAsType(Planet) , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9 .oclAsType(Planet)}"
  unfolding OclAllInstances_at_post_def
by(rule \<sigma>\<^sub>1'_OclAllInstances_generic_exec_Planet, simp_all only: assms, simp_all) 

lemma \<sigma>\<^sub>1'_OclAllInstances_at_pre_exec_Planet : 
assumes [simp]: "(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Planet ((in\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n7\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y)))) = None"
assumes [simp]: "(Planet ((in\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n8\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y)))) = None"
assumes [simp]: "(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(\<lambda>_. \<lfloor>(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Planet))"
assumes [simp]: "(\<lambda>_. \<lfloor>(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Planet))"
assumes [simp]: "(\<lambda>_. \<lfloor>(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Planet))"
assumes [simp]: "(\<lambda>_. \<lfloor>(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Planet))"
assumes [simp]: "(\<lambda>_. \<lfloor>(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Planet))"
assumes [simp]: "(\<lambda>_. \<lfloor>(Planet ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Planet))"
shows "(\<sigma>\<^sub>1' , st) \<Turnstile> (OclAllInstances_at_pre (Planet)) \<doteq> Set{X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1 .oclAsType(Planet) , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2 .oclAsType(Planet) , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3 .oclAsType(Planet) , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4 .oclAsType(Planet) , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6 .oclAsType(Planet) , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9 .oclAsType(Planet)}"
  unfolding OclAllInstances_at_pre_def
by(rule \<sigma>\<^sub>1'_OclAllInstances_generic_exec_Planet, simp_all only: assms, simp_all) 

lemma \<sigma>\<^sub>1'_OclAllInstances_generic_exec_Galaxy : 
assumes [simp]: "(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Galaxy ((in\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n7\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y)))) = None"
assumes [simp]: "(Galaxy ((in\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n8\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y)))) = None"
assumes [simp]: "(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(\<lambda>_. \<lfloor>(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Galaxy))"
assumes [simp]: "(\<lambda>_. \<lfloor>(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Galaxy))"
assumes [simp]: "(\<lambda>_. \<lfloor>(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Galaxy))"
assumes [simp]: "(\<lambda>_. \<lfloor>(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Galaxy))"
assumes [simp]: "(\<lambda>_. \<lfloor>(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Galaxy))"
assumes [simp]: "(\<lambda>_. \<lfloor>(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Galaxy))"
assumes [simp]: "(\<And>a. (pre_post ((mk (a)))) = a)"
shows "(mk (\<sigma>\<^sub>1')) \<Turnstile> (OclAllInstances_generic (pre_post) (Galaxy)) \<doteq> Set{X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1 .oclAsType(Galaxy) , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2 .oclAsType(Galaxy) , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3 .oclAsType(Galaxy) , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4 .oclAsType(Galaxy) , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6 .oclAsType(Galaxy) , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9 .oclAsType(Galaxy)}"
  apply(subst perm_\<sigma>\<^sub>1')
  apply(simp only: state.make_def X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1_def X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2_def X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3_def X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4_def X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6_def X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9_def)
  apply(subst state_update_vs_allInstances_generic_tc, simp, simp, (metis distinct_oid distinct_length_2_or_more)?, simp only: assms, blast, simp, rule const_StrictRefEq\<^sub>S\<^sub>e\<^sub>t_including, simp del: OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person, simp del: OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person, simp, rule OclIncluding_cong, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def)
  apply(subst state_update_vs_allInstances_generic_tc, simp, simp, (metis distinct_oid distinct_length_2_or_more)?, simp only: assms, blast, simp, rule const_StrictRefEq\<^sub>S\<^sub>e\<^sub>t_including, simp del: OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person, simp del: OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person, simp, rule OclIncluding_cong, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def)
  apply(subst state_update_vs_allInstances_generic_tc, simp, simp, (metis distinct_oid distinct_length_2_or_more)?, simp only: assms, blast, simp, rule const_StrictRefEq\<^sub>S\<^sub>e\<^sub>t_including, simp del: OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person, simp del: OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person, simp, rule OclIncluding_cong, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def)
  apply(subst state_update_vs_allInstances_generic_tc, simp, simp, (metis distinct_oid distinct_length_2_or_more)?, simp only: assms, blast, simp, rule const_StrictRefEq\<^sub>S\<^sub>e\<^sub>t_including, simp del: OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person, simp del: OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person, simp, rule OclIncluding_cong, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def)
  apply(subst state_update_vs_allInstances_generic_tc, simp, simp, (metis distinct_oid distinct_length_2_or_more)?, simp only: assms, blast, simp, rule const_StrictRefEq\<^sub>S\<^sub>e\<^sub>t_including, simp del: OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person, simp del: OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person, simp, rule OclIncluding_cong, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def)
  apply(subst state_update_vs_allInstances_generic_ntc, simp, simp, (metis distinct_oid distinct_length_2_or_more)?, simp only: assms, simp, rule const_StrictRefEq\<^sub>S\<^sub>e\<^sub>t_including, simp del: OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person, simp del: OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person, simp)
  apply(subst state_update_vs_allInstances_generic_ntc, simp, simp, (metis distinct_oid distinct_length_2_or_more)?, simp only: assms, simp, rule const_StrictRefEq\<^sub>S\<^sub>e\<^sub>t_including, simp del: OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person, simp del: OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person, simp)
  apply(subst state_update_vs_allInstances_generic_tc, simp, simp, (metis distinct_oid distinct_length_2_or_more)?, simp only: assms, blast, simp, rule const_StrictRefEq\<^sub>S\<^sub>e\<^sub>t_including, simp del: OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person, simp del: OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_Person, simp, rule OclIncluding_cong, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def)
  apply(rule state_update_vs_allInstances_generic_empty)
by(simp_all only: assms, (simp_all add: OclAsType\<^sub>G\<^sub>a\<^sub>l\<^sub>a\<^sub>x\<^sub>y_\<AA>_def)?) 

lemma \<sigma>\<^sub>1'_OclAllInstances_at_post_exec_Galaxy : 
assumes [simp]: "(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Galaxy ((in\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n7\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y)))) = None"
assumes [simp]: "(Galaxy ((in\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n8\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y)))) = None"
assumes [simp]: "(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(\<lambda>_. \<lfloor>(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Galaxy))"
assumes [simp]: "(\<lambda>_. \<lfloor>(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Galaxy))"
assumes [simp]: "(\<lambda>_. \<lfloor>(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Galaxy))"
assumes [simp]: "(\<lambda>_. \<lfloor>(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Galaxy))"
assumes [simp]: "(\<lambda>_. \<lfloor>(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Galaxy))"
assumes [simp]: "(\<lambda>_. \<lfloor>(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Galaxy))"
shows "(st , \<sigma>\<^sub>1') \<Turnstile> (OclAllInstances_at_post (Galaxy)) \<doteq> Set{X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1 .oclAsType(Galaxy) , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2 .oclAsType(Galaxy) , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3 .oclAsType(Galaxy) , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4 .oclAsType(Galaxy) , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6 .oclAsType(Galaxy) , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9 .oclAsType(Galaxy)}"
  unfolding OclAllInstances_at_post_def
by(rule \<sigma>\<^sub>1'_OclAllInstances_generic_exec_Galaxy, simp_all only: assms, simp_all) 

lemma \<sigma>\<^sub>1'_OclAllInstances_at_pre_exec_Galaxy : 
assumes [simp]: "(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(Galaxy ((in\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n7\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y)))) = None"
assumes [simp]: "(Galaxy ((in\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n8\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y)))) = None"
assumes [simp]: "(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(\<lambda>_. \<lfloor>(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Galaxy))"
assumes [simp]: "(\<lambda>_. \<lfloor>(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Galaxy))"
assumes [simp]: "(\<lambda>_. \<lfloor>(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Galaxy))"
assumes [simp]: "(\<lambda>_. \<lfloor>(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Galaxy))"
assumes [simp]: "(\<lambda>_. \<lfloor>(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Galaxy))"
assumes [simp]: "(\<lambda>_. \<lfloor>(Galaxy ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(Galaxy))"
shows "(\<sigma>\<^sub>1' , st) \<Turnstile> (OclAllInstances_at_pre (Galaxy)) \<doteq> Set{X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1 .oclAsType(Galaxy) , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2 .oclAsType(Galaxy) , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3 .oclAsType(Galaxy) , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4 .oclAsType(Galaxy) , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6 .oclAsType(Galaxy) , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9 .oclAsType(Galaxy)}"
  unfolding OclAllInstances_at_pre_def
by(rule \<sigma>\<^sub>1'_OclAllInstances_generic_exec_Galaxy, simp_all only: assms, simp_all) 

lemma \<sigma>\<^sub>1'_OclAllInstances_generic_exec_OclAny : 
assumes [simp]: "(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(OclAny ((in\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n7\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y)))) \<noteq> None"
assumes [simp]: "(OclAny ((in\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n8\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y)))) \<noteq> None"
assumes [simp]: "(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(\<lambda>_. \<lfloor>(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(OclAny))"
assumes [simp]: "(\<lambda>_. \<lfloor>(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(OclAny))"
assumes [simp]: "(\<lambda>_. \<lfloor>(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(OclAny))"
assumes [simp]: "(\<lambda>_. \<lfloor>(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(OclAny))"
assumes [simp]: "(\<lambda>_. \<lfloor>(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(OclAny))"
assumes [simp]: "(\<lambda>_. \<lfloor>(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(OclAny))"
assumes [simp]: "(\<And>a. (pre_post ((mk (a)))) = a)"
shows "(mk (\<sigma>\<^sub>1')) \<Turnstile> (OclAllInstances_generic (pre_post) (OclAny)) \<doteq> Set{X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1 .oclAsType(OclAny) , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2 .oclAsType(OclAny) , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3 .oclAsType(OclAny) , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4 .oclAsType(OclAny) , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6 .oclAsType(OclAny) , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n7 , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n8 , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9 .oclAsType(OclAny)}"
  apply(subst perm_\<sigma>\<^sub>1')
  apply(simp only: state.make_def X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1_def X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2_def X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3_def X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4_def X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6_def X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n7_def X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n8_def X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9_def)
  apply(subst state_update_vs_allInstances_generic_tc, simp, simp, (metis distinct_oid distinct_length_2_or_more)?, simp only: assms, blast, simp, rule const_StrictRefEq\<^sub>S\<^sub>e\<^sub>t_including, simp del: OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person, simp del: OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person, simp, rule OclIncluding_cong, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def)
  apply(subst state_update_vs_allInstances_generic_tc, simp, simp, (metis distinct_oid distinct_length_2_or_more)?, simp only: assms, blast, simp, rule const_StrictRefEq\<^sub>S\<^sub>e\<^sub>t_including, simp del: OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person, simp del: OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person, simp, rule OclIncluding_cong, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def)
  apply(subst state_update_vs_allInstances_generic_tc, simp, simp, (metis distinct_oid distinct_length_2_or_more)?, simp only: assms, blast, simp, rule const_StrictRefEq\<^sub>S\<^sub>e\<^sub>t_including, simp del: OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person, simp del: OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person, simp, rule OclIncluding_cong, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def)
  apply(subst state_update_vs_allInstances_generic_tc, simp, simp, (metis distinct_oid distinct_length_2_or_more)?, simp only: assms, blast, simp, rule const_StrictRefEq\<^sub>S\<^sub>e\<^sub>t_including, simp del: OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person, simp del: OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person, simp, rule OclIncluding_cong, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def)
  apply(subst state_update_vs_allInstances_generic_tc, simp, simp, (metis distinct_oid distinct_length_2_or_more)?, simp only: assms, blast, simp, rule const_StrictRefEq\<^sub>S\<^sub>e\<^sub>t_including, simp del: OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person, simp del: OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person, simp, rule OclIncluding_cong, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def)
  apply(subst state_update_vs_allInstances_generic_tc, simp, simp, (metis distinct_oid distinct_length_2_or_more)?, simp only: assms, blast, simp, rule const_StrictRefEq\<^sub>S\<^sub>e\<^sub>t_including, simp del: OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person, simp del: OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person, simp, rule OclIncluding_cong, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def)
  apply(subst state_update_vs_allInstances_generic_tc, simp, simp, (metis distinct_oid distinct_length_2_or_more)?, simp only: assms, blast, simp, rule const_StrictRefEq\<^sub>S\<^sub>e\<^sub>t_including, simp del: OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person, simp del: OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person, simp, rule OclIncluding_cong, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def)
  apply(subst state_update_vs_allInstances_generic_tc, simp, simp, (metis distinct_oid distinct_length_2_or_more)?, simp only: assms, blast, simp, rule const_StrictRefEq\<^sub>S\<^sub>e\<^sub>t_including, simp del: OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person, simp del: OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_Person, simp, rule OclIncluding_cong, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def, (simp only: assms[symmetric ])?, simp add: valid_def OclValid_def bot_fun_def bot_option_def)
  apply(rule state_update_vs_allInstances_generic_empty)
by(simp_all only: assms, (simp_all add: OclAsType\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y_\<AA>_def)?) 

lemma \<sigma>\<^sub>1'_OclAllInstances_at_post_exec_OclAny : 
assumes [simp]: "(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(OclAny ((in\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n7\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y)))) \<noteq> None"
assumes [simp]: "(OclAny ((in\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n8\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y)))) \<noteq> None"
assumes [simp]: "(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(\<lambda>_. \<lfloor>(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(OclAny))"
assumes [simp]: "(\<lambda>_. \<lfloor>(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(OclAny))"
assumes [simp]: "(\<lambda>_. \<lfloor>(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(OclAny))"
assumes [simp]: "(\<lambda>_. \<lfloor>(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(OclAny))"
assumes [simp]: "(\<lambda>_. \<lfloor>(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(OclAny))"
assumes [simp]: "(\<lambda>_. \<lfloor>(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(OclAny))"
shows "(st , \<sigma>\<^sub>1') \<Turnstile> (OclAllInstances_at_post (OclAny)) \<doteq> Set{X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1 .oclAsType(OclAny) , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2 .oclAsType(OclAny) , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3 .oclAsType(OclAny) , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4 .oclAsType(OclAny) , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6 .oclAsType(OclAny) , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n7 , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n8 , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9 .oclAsType(OclAny)}"
  unfolding OclAllInstances_at_post_def
by(rule \<sigma>\<^sub>1'_OclAllInstances_generic_exec_OclAny, simp_all only: assms, simp_all) 

lemma \<sigma>\<^sub>1'_OclAllInstances_at_pre_exec_OclAny : 
assumes [simp]: "(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(OclAny ((in\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n7\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y)))) \<noteq> None"
assumes [simp]: "(OclAny ((in\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n8\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y)))) \<noteq> None"
assumes [simp]: "(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) \<noteq> None"
assumes [simp]: "(\<lambda>_. \<lfloor>(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(OclAny))"
assumes [simp]: "(\<lambda>_. \<lfloor>(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(OclAny))"
assumes [simp]: "(\<lambda>_. \<lfloor>(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(OclAny))"
assumes [simp]: "(\<lambda>_. \<lfloor>(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(OclAny))"
assumes [simp]: "(\<lambda>_. \<lfloor>(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(OclAny))"
assumes [simp]: "(\<lambda>_. \<lfloor>(OclAny ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n))))\<rfloor>) = ((((\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)::\<cdot>Person)) .oclAsType(OclAny))"
shows "(\<sigma>\<^sub>1' , st) \<Turnstile> (OclAllInstances_at_pre (OclAny)) \<doteq> Set{X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1 .oclAsType(OclAny) , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2 .oclAsType(OclAny) , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3 .oclAsType(OclAny) , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4 .oclAsType(OclAny) , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6 .oclAsType(OclAny) , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n7 , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n8 , X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9 .oclAsType(OclAny)}"
  unfolding OclAllInstances_at_pre_def
by(rule \<sigma>\<^sub>1'_OclAllInstances_generic_exec_OclAny, simp_all only: assms, simp_all) 

ML{* (Ty'.check ([]) (" error(s)")) *}
end

(* 150 ************************************ 932 + 1 *)
locale pre_post_\<sigma>\<^sub>1_\<sigma>\<^sub>1' =
fixes "oid1" :: "nat"
fixes "oid2" :: "nat"
fixes "oid3" :: "nat"
fixes "oid4" :: "nat"
fixes "oid5" :: "nat"
fixes "oid6" :: "nat"
fixes "oid7" :: "nat"
fixes "oid8" :: "nat"
fixes "oid9" :: "nat"
fixes "oid12" :: "nat"
fixes "oid13" :: "nat"
fixes "oid14" :: "nat"
fixes "oid15" :: "nat"
assumes distinct_oid: "(distinct ([oid1 , oid2 , oid3 , oid4 , oid5 , oid6 , oid7 , oid8 , oid9 , oid12 , oid13 , oid14 , oid15]))"
fixes "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n" :: "ty\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n"
fixes "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1" :: "\<cdot>Person"
assumes X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1_def: "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1 = (\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)"
fixes "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n" :: "ty\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n"
fixes "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2" :: "\<cdot>Person"
assumes X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2_def: "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2 = (\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)"
fixes "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n" :: "ty\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n"
fixes "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3" :: "\<cdot>Person"
assumes X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3_def: "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3 = (\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)"
fixes "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n" :: "ty\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n"
fixes "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4" :: "\<cdot>Person"
assumes X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4_def: "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4 = (\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)"
fixes "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n" :: "ty\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n"
fixes "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5" :: "\<cdot>Person"
assumes X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5_def: "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5 = (\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)"
fixes "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n" :: "ty\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n"
fixes "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6" :: "\<cdot>Person"
assumes X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6_def: "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6 = (\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)"
fixes "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n7\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y" :: "ty\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y"
fixes "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n7" :: "\<cdot>OclAny"
assumes X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n7_def: "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n7 = (\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n7\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y\<rfloor>\<rfloor>)"
fixes "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n8\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y" :: "ty\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y"
fixes "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n8" :: "\<cdot>OclAny"
assumes X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n8_def: "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n8 = (\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n8\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y\<rfloor>\<rfloor>)"
fixes "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n" :: "ty\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n"
fixes "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9" :: "\<cdot>Person"
assumes X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9_def: "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9 = (\<lambda>_. \<lfloor>\<lfloor>X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)"
fixes "\<sigma>\<^sub>1_object0\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n" :: "ty\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n"
fixes "\<sigma>\<^sub>1_object0" :: "\<cdot>Person"
assumes \<sigma>\<^sub>1_object0_def: "\<sigma>\<^sub>1_object0 = (\<lambda>_. \<lfloor>\<lfloor>\<sigma>\<^sub>1_object0\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)"
fixes "\<sigma>\<^sub>1_object1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n" :: "ty\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n"
fixes "\<sigma>\<^sub>1_object1" :: "\<cdot>Person"
assumes \<sigma>\<^sub>1_object1_def: "\<sigma>\<^sub>1_object1 = (\<lambda>_. \<lfloor>\<lfloor>\<sigma>\<^sub>1_object1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)"
fixes "\<sigma>\<^sub>1_object2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n" :: "ty\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n"
fixes "\<sigma>\<^sub>1_object2" :: "\<cdot>Person"
assumes \<sigma>\<^sub>1_object2_def: "\<sigma>\<^sub>1_object2 = (\<lambda>_. \<lfloor>\<lfloor>\<sigma>\<^sub>1_object2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)"
fixes "\<sigma>\<^sub>1_object4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n" :: "ty\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n"
fixes "\<sigma>\<^sub>1_object4" :: "\<cdot>Person"
assumes \<sigma>\<^sub>1_object4_def: "\<sigma>\<^sub>1_object4 = (\<lambda>_. \<lfloor>\<lfloor>\<sigma>\<^sub>1_object4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n\<rfloor>\<rfloor>)"

assumes \<sigma>\<^sub>1: "(state_\<sigma>\<^sub>1 (oid12) (oid13) (oid14) (oid5) (oid15) (oid9) (\<sigma>\<^sub>1_object0\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n) (\<sigma>\<^sub>1_object0) (\<sigma>\<^sub>1_object1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n) (\<sigma>\<^sub>1_object1) (\<sigma>\<^sub>1_object2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n) (\<sigma>\<^sub>1_object2) (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n) (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5) (\<sigma>\<^sub>1_object4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n) (\<sigma>\<^sub>1_object4) (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n) (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9))"

assumes \<sigma>\<^sub>1': "(state_\<sigma>\<^sub>1' (oid1) (oid2) (oid3) (oid4) (oid6) (oid7) (oid8) (oid9) (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n) (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1) (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n) (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2) (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n) (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3) (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n) (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4) (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n) (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6) (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n7\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y) (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n7) (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n8\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y) (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n8) (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n) (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9))"
begin
interpretation state_\<sigma>\<^sub>1: state_\<sigma>\<^sub>1 "oid12" "oid13" "oid14" "oid5" "oid15" "oid9" "\<sigma>\<^sub>1_object0\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n" "\<sigma>\<^sub>1_object0" "\<sigma>\<^sub>1_object1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n" "\<sigma>\<^sub>1_object1" "\<sigma>\<^sub>1_object2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n" "\<sigma>\<^sub>1_object2" "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n" "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5" "\<sigma>\<^sub>1_object4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n" "\<sigma>\<^sub>1_object4" "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n" "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9"
by(rule \<sigma>\<^sub>1)

interpretation state_\<sigma>\<^sub>1': state_\<sigma>\<^sub>1' "oid1" "oid2" "oid3" "oid4" "oid6" "oid7" "oid8" "oid9" "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n" "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1" "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n" "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2" "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n" "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3" "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n" "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4" "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n" "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6" "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n7\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y" "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n7" "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n8\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y" "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n8" "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n" "X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9"
by(rule \<sigma>\<^sub>1')

lemma basic_\<sigma>\<^sub>1_\<sigma>\<^sub>1'_wff : 
assumes [simp]: "(oid_of ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) = oid1"
assumes [simp]: "(oid_of ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) = oid2"
assumes [simp]: "(oid_of ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) = oid3"
assumes [simp]: "(oid_of ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) = oid4"
assumes [simp]: "(oid_of ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) = oid5"
assumes [simp]: "(oid_of ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) = oid6"
assumes [simp]: "(oid_of ((in\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n7\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y)))) = oid7"
assumes [simp]: "(oid_of ((in\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n8\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y)))) = oid8"
assumes [simp]: "(oid_of ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) = oid9"
assumes [simp]: "(oid_of ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object0\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) = oid12"
assumes [simp]: "(oid_of ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) = oid13"
assumes [simp]: "(oid_of ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) = oid14"
assumes [simp]: "(oid_of ((in\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n (\<sigma>\<^sub>1_object4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)))) = oid15"
shows "(WFF ((state_\<sigma>\<^sub>1.\<sigma>\<^sub>1 , state_\<sigma>\<^sub>1'.\<sigma>\<^sub>1')))"
  proof - have [simp]: "oid1 \<noteq> oid2" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid1 \<noteq> oid3" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid1 \<noteq> oid4" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid1 \<noteq> oid5" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid1 \<noteq> oid6" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid1 \<noteq> oid7" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid1 \<noteq> oid8" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid1 \<noteq> oid9" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid1 \<noteq> oid12" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid1 \<noteq> oid13" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid1 \<noteq> oid14" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid1 \<noteq> oid15" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid2 \<noteq> oid1" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid2 \<noteq> oid3" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid2 \<noteq> oid4" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid2 \<noteq> oid5" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid2 \<noteq> oid6" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid2 \<noteq> oid7" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid2 \<noteq> oid8" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid2 \<noteq> oid9" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid2 \<noteq> oid12" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid2 \<noteq> oid13" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid2 \<noteq> oid14" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid2 \<noteq> oid15" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid3 \<noteq> oid1" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid3 \<noteq> oid2" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid3 \<noteq> oid4" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid3 \<noteq> oid5" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid3 \<noteq> oid6" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid3 \<noteq> oid7" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid3 \<noteq> oid8" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid3 \<noteq> oid9" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid3 \<noteq> oid12" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid3 \<noteq> oid13" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid3 \<noteq> oid14" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid3 \<noteq> oid15" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid4 \<noteq> oid1" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid4 \<noteq> oid2" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid4 \<noteq> oid3" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid4 \<noteq> oid5" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid4 \<noteq> oid6" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid4 \<noteq> oid7" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid4 \<noteq> oid8" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid4 \<noteq> oid9" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid4 \<noteq> oid12" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid4 \<noteq> oid13" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid4 \<noteq> oid14" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid4 \<noteq> oid15" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid5 \<noteq> oid1" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid5 \<noteq> oid2" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid5 \<noteq> oid3" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid5 \<noteq> oid4" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid5 \<noteq> oid6" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid5 \<noteq> oid7" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid5 \<noteq> oid8" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid5 \<noteq> oid9" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid5 \<noteq> oid12" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid5 \<noteq> oid13" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid5 \<noteq> oid14" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid5 \<noteq> oid15" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid6 \<noteq> oid1" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid6 \<noteq> oid2" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid6 \<noteq> oid3" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid6 \<noteq> oid4" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid6 \<noteq> oid5" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid6 \<noteq> oid7" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid6 \<noteq> oid8" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid6 \<noteq> oid9" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid6 \<noteq> oid12" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid6 \<noteq> oid13" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid6 \<noteq> oid14" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid6 \<noteq> oid15" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid7 \<noteq> oid1" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid7 \<noteq> oid2" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid7 \<noteq> oid3" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid7 \<noteq> oid4" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid7 \<noteq> oid5" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid7 \<noteq> oid6" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid7 \<noteq> oid8" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid7 \<noteq> oid9" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid7 \<noteq> oid12" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid7 \<noteq> oid13" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid7 \<noteq> oid14" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid7 \<noteq> oid15" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid8 \<noteq> oid1" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid8 \<noteq> oid2" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid8 \<noteq> oid3" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid8 \<noteq> oid4" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid8 \<noteq> oid5" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid8 \<noteq> oid6" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid8 \<noteq> oid7" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid8 \<noteq> oid9" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid8 \<noteq> oid12" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid8 \<noteq> oid13" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid8 \<noteq> oid14" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid8 \<noteq> oid15" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid9 \<noteq> oid1" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid9 \<noteq> oid2" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid9 \<noteq> oid3" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid9 \<noteq> oid4" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid9 \<noteq> oid5" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid9 \<noteq> oid6" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid9 \<noteq> oid7" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid9 \<noteq> oid8" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid9 \<noteq> oid12" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid9 \<noteq> oid13" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid9 \<noteq> oid14" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid9 \<noteq> oid15" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid12 \<noteq> oid1" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid12 \<noteq> oid2" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid12 \<noteq> oid3" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid12 \<noteq> oid4" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid12 \<noteq> oid5" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid12 \<noteq> oid6" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid12 \<noteq> oid7" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid12 \<noteq> oid8" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid12 \<noteq> oid9" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid12 \<noteq> oid13" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid12 \<noteq> oid14" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid12 \<noteq> oid15" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid13 \<noteq> oid1" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid13 \<noteq> oid2" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid13 \<noteq> oid3" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid13 \<noteq> oid4" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid13 \<noteq> oid5" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid13 \<noteq> oid6" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid13 \<noteq> oid7" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid13 \<noteq> oid8" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid13 \<noteq> oid9" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid13 \<noteq> oid12" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid13 \<noteq> oid14" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid13 \<noteq> oid15" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid14 \<noteq> oid1" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid14 \<noteq> oid2" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid14 \<noteq> oid3" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid14 \<noteq> oid4" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid14 \<noteq> oid5" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid14 \<noteq> oid6" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid14 \<noteq> oid7" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid14 \<noteq> oid8" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid14 \<noteq> oid9" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid14 \<noteq> oid12" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid14 \<noteq> oid13" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid14 \<noteq> oid15" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid15 \<noteq> oid1" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid15 \<noteq> oid2" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid15 \<noteq> oid3" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid15 \<noteq> oid4" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid15 \<noteq> oid5" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid15 \<noteq> oid6" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid15 \<noteq> oid7" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid15 \<noteq> oid8" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid15 \<noteq> oid9" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid15 \<noteq> oid12" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid15 \<noteq> oid13" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
  proof - have [simp]: "oid15 \<noteq> oid14" by(metis distinct_oid distinct_length_2_or_more) show ?thesis
by(auto simp: WFF_def state_\<sigma>\<^sub>1.\<sigma>\<^sub>1_def state_\<sigma>\<^sub>1'.\<sigma>\<^sub>1'_def) qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed qed

lemma oid1\<sigma>\<^sub>1\<sigma>\<^sub>1'_\<sigma>\<^sub>1'_OclIsNew : 
assumes [simp]: "(oid_of (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)) = oid1"
shows "(state_\<sigma>\<^sub>1.\<sigma>\<^sub>1 , state_\<sigma>\<^sub>1'.\<sigma>\<^sub>1') \<Turnstile> (OclIsNew (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1))"
  apply(simp add: state_\<sigma>\<^sub>1.\<sigma>\<^sub>1_def state_\<sigma>\<^sub>1'.\<sigma>\<^sub>1'_def X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n1_def OclIsNew_def OclValid_def oid_of_option_def)
by((metis distinct_oid distinct_length_2_or_more)?) 

lemma oid2\<sigma>\<^sub>1\<sigma>\<^sub>1'_\<sigma>\<^sub>1'_OclIsNew : 
assumes [simp]: "(oid_of (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)) = oid2"
shows "(state_\<sigma>\<^sub>1.\<sigma>\<^sub>1 , state_\<sigma>\<^sub>1'.\<sigma>\<^sub>1') \<Turnstile> (OclIsNew (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2))"
  apply(simp add: state_\<sigma>\<^sub>1.\<sigma>\<^sub>1_def state_\<sigma>\<^sub>1'.\<sigma>\<^sub>1'_def X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n2_def OclIsNew_def OclValid_def oid_of_option_def)
by((metis distinct_oid distinct_length_2_or_more)?) 

lemma oid3\<sigma>\<^sub>1\<sigma>\<^sub>1'_\<sigma>\<^sub>1'_OclIsNew : 
assumes [simp]: "(oid_of (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)) = oid3"
shows "(state_\<sigma>\<^sub>1.\<sigma>\<^sub>1 , state_\<sigma>\<^sub>1'.\<sigma>\<^sub>1') \<Turnstile> (OclIsNew (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3))"
  apply(simp add: state_\<sigma>\<^sub>1.\<sigma>\<^sub>1_def state_\<sigma>\<^sub>1'.\<sigma>\<^sub>1'_def X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n3_def OclIsNew_def OclValid_def oid_of_option_def)
by((metis distinct_oid distinct_length_2_or_more)?) 

lemma oid4\<sigma>\<^sub>1\<sigma>\<^sub>1'_\<sigma>\<^sub>1'_OclIsNew : 
assumes [simp]: "(oid_of (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)) = oid4"
shows "(state_\<sigma>\<^sub>1.\<sigma>\<^sub>1 , state_\<sigma>\<^sub>1'.\<sigma>\<^sub>1') \<Turnstile> (OclIsNew (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4))"
  apply(simp add: state_\<sigma>\<^sub>1.\<sigma>\<^sub>1_def state_\<sigma>\<^sub>1'.\<sigma>\<^sub>1'_def X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n4_def OclIsNew_def OclValid_def oid_of_option_def)
by((metis distinct_oid distinct_length_2_or_more)?) 

lemma oid5\<sigma>\<^sub>1\<sigma>\<^sub>1'_\<sigma>\<^sub>1_OclIsDeleted : 
assumes [simp]: "(oid_of (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)) = oid5"
shows "(state_\<sigma>\<^sub>1.\<sigma>\<^sub>1 , state_\<sigma>\<^sub>1'.\<sigma>\<^sub>1') \<Turnstile> (OclIsDeleted (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5))"
  apply(simp add: state_\<sigma>\<^sub>1.\<sigma>\<^sub>1_def state_\<sigma>\<^sub>1'.\<sigma>\<^sub>1'_def X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n5_def OclIsDeleted_def OclValid_def oid_of_option_def)
by((metis distinct_oid distinct_length_2_or_more)?) 

lemma oid6\<sigma>\<^sub>1\<sigma>\<^sub>1'_\<sigma>\<^sub>1'_OclIsNew : 
assumes [simp]: "(oid_of (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)) = oid6"
shows "(state_\<sigma>\<^sub>1.\<sigma>\<^sub>1 , state_\<sigma>\<^sub>1'.\<sigma>\<^sub>1') \<Turnstile> (OclIsNew (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6))"
  apply(simp add: state_\<sigma>\<^sub>1.\<sigma>\<^sub>1_def state_\<sigma>\<^sub>1'.\<sigma>\<^sub>1'_def X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n6_def OclIsNew_def OclValid_def oid_of_option_def)
by((metis distinct_oid distinct_length_2_or_more)?) 

lemma oid7\<sigma>\<^sub>1\<sigma>\<^sub>1'_\<sigma>\<^sub>1'_OclIsNew : 
assumes [simp]: "(oid_of (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n7\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y)) = oid7"
shows "(state_\<sigma>\<^sub>1.\<sigma>\<^sub>1 , state_\<sigma>\<^sub>1'.\<sigma>\<^sub>1') \<Turnstile> (OclIsNew (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n7))"
  apply(simp add: state_\<sigma>\<^sub>1.\<sigma>\<^sub>1_def state_\<sigma>\<^sub>1'.\<sigma>\<^sub>1'_def X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n7_def OclIsNew_def OclValid_def oid_of_option_def)
by((metis distinct_oid distinct_length_2_or_more)?) 

lemma oid8\<sigma>\<^sub>1\<sigma>\<^sub>1'_\<sigma>\<^sub>1'_OclIsNew : 
assumes [simp]: "(oid_of (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n8\<^sub>O\<^sub>c\<^sub>l\<^sub>A\<^sub>n\<^sub>y)) = oid8"
shows "(state_\<sigma>\<^sub>1.\<sigma>\<^sub>1 , state_\<sigma>\<^sub>1'.\<sigma>\<^sub>1') \<Turnstile> (OclIsNew (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n8))"
  apply(simp add: state_\<sigma>\<^sub>1.\<sigma>\<^sub>1_def state_\<sigma>\<^sub>1'.\<sigma>\<^sub>1'_def X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n8_def OclIsNew_def OclValid_def oid_of_option_def)
by((metis distinct_oid distinct_length_2_or_more)?) 

lemma oid9\<sigma>\<^sub>1\<sigma>\<^sub>1'_\<sigma>\<^sub>1_OclIsMaintained : 
assumes [simp]: "(oid_of (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)) = oid9"
shows "(state_\<sigma>\<^sub>1.\<sigma>\<^sub>1 , state_\<sigma>\<^sub>1'.\<sigma>\<^sub>1') \<Turnstile> (OclIsMaintained (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9))"
  apply(simp add: state_\<sigma>\<^sub>1.\<sigma>\<^sub>1_def state_\<sigma>\<^sub>1'.\<sigma>\<^sub>1'_def X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9_def OclIsMaintained_def OclValid_def oid_of_option_def)
by((metis distinct_oid distinct_length_2_or_more)?) 

lemma oid9\<sigma>\<^sub>1\<sigma>\<^sub>1'_\<sigma>\<^sub>1'_OclIsMaintained : 
assumes [simp]: "(oid_of (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)) = oid9"
shows "(state_\<sigma>\<^sub>1.\<sigma>\<^sub>1 , state_\<sigma>\<^sub>1'.\<sigma>\<^sub>1') \<Turnstile> (OclIsMaintained (X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9))"
  apply(simp add: state_\<sigma>\<^sub>1.\<sigma>\<^sub>1_def state_\<sigma>\<^sub>1'.\<sigma>\<^sub>1'_def X\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n9_def OclIsMaintained_def OclValid_def oid_of_option_def)
by((metis distinct_oid distinct_length_2_or_more)?) 

lemma oid12\<sigma>\<^sub>1\<sigma>\<^sub>1'_\<sigma>\<^sub>1_OclIsDeleted : 
assumes [simp]: "(oid_of (\<sigma>\<^sub>1_object0\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)) = oid12"
shows "(state_\<sigma>\<^sub>1.\<sigma>\<^sub>1 , state_\<sigma>\<^sub>1'.\<sigma>\<^sub>1') \<Turnstile> (OclIsDeleted (\<sigma>\<^sub>1_object0))"
  apply(simp add: state_\<sigma>\<^sub>1.\<sigma>\<^sub>1_def state_\<sigma>\<^sub>1'.\<sigma>\<^sub>1'_def \<sigma>\<^sub>1_object0_def OclIsDeleted_def OclValid_def oid_of_option_def)
by((metis distinct_oid distinct_length_2_or_more)?) 

lemma oid13\<sigma>\<^sub>1\<sigma>\<^sub>1'_\<sigma>\<^sub>1_OclIsDeleted : 
assumes [simp]: "(oid_of (\<sigma>\<^sub>1_object1\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)) = oid13"
shows "(state_\<sigma>\<^sub>1.\<sigma>\<^sub>1 , state_\<sigma>\<^sub>1'.\<sigma>\<^sub>1') \<Turnstile> (OclIsDeleted (\<sigma>\<^sub>1_object1))"
  apply(simp add: state_\<sigma>\<^sub>1.\<sigma>\<^sub>1_def state_\<sigma>\<^sub>1'.\<sigma>\<^sub>1'_def \<sigma>\<^sub>1_object1_def OclIsDeleted_def OclValid_def oid_of_option_def)
by((metis distinct_oid distinct_length_2_or_more)?) 

lemma oid14\<sigma>\<^sub>1\<sigma>\<^sub>1'_\<sigma>\<^sub>1_OclIsDeleted : 
assumes [simp]: "(oid_of (\<sigma>\<^sub>1_object2\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)) = oid14"
shows "(state_\<sigma>\<^sub>1.\<sigma>\<^sub>1 , state_\<sigma>\<^sub>1'.\<sigma>\<^sub>1') \<Turnstile> (OclIsDeleted (\<sigma>\<^sub>1_object2))"
  apply(simp add: state_\<sigma>\<^sub>1.\<sigma>\<^sub>1_def state_\<sigma>\<^sub>1'.\<sigma>\<^sub>1'_def \<sigma>\<^sub>1_object2_def OclIsDeleted_def OclValid_def oid_of_option_def)
by((metis distinct_oid distinct_length_2_or_more)?) 

lemma oid15\<sigma>\<^sub>1\<sigma>\<^sub>1'_\<sigma>\<^sub>1_OclIsDeleted : 
assumes [simp]: "(oid_of (\<sigma>\<^sub>1_object4\<^sub>P\<^sub>e\<^sub>r\<^sub>s\<^sub>o\<^sub>n)) = oid15"
shows "(state_\<sigma>\<^sub>1.\<sigma>\<^sub>1 , state_\<sigma>\<^sub>1'.\<sigma>\<^sub>1') \<Turnstile> (OclIsDeleted (\<sigma>\<^sub>1_object4))"
  apply(simp add: state_\<sigma>\<^sub>1.\<sigma>\<^sub>1_def state_\<sigma>\<^sub>1'.\<sigma>\<^sub>1'_def \<sigma>\<^sub>1_object4_def OclIsDeleted_def OclValid_def oid_of_option_def)
by((metis distinct_oid distinct_length_2_or_more)?) 
end

(* 151 ************************************ 933 + 5 *)
axiomatization where dot\<c>\<o>\<n>\<t>\<e>\<n>\<t>\<s>_def:
"(((\<tau> \<Turnstile> ((\<delta> (self))))) \<Longrightarrow> (\<tau> \<Turnstile> ((\<delta> (((UML_Logic.false)) implies ((((UML_Logic.StrongEq) (result)) ((((UML_Logic.OclIf) (((UML_Logic.StrictRefEq) ((Employee_AnalysisModel_UMLPart_generated.dot_0_\<b>\<o>\<s>\<s>) (self))) (UML_Types.null_class.null))) (((UML_Set.OclIncluding) (UML_Set.mtSet)) ((Employee_AnalysisModel_UMLPart_generated.dot\<s>\<a>\<l>\<a>\<r>\<y>) (self)))) (((UML_Set.OclIncluding) ((Employee_AnalysisModel_UMLPart_generated.dot\<c>\<o>\<n>\<t>\<e>\<n>\<t>\<s>) ((Employee_AnalysisModel_UMLPart_generated.dot_0_\<b>\<o>\<s>\<s>) (self)))) ((Employee_AnalysisModel_UMLPart_generated.dot\<s>\<a>\<l>\<a>\<r>\<y>) (self)))) and UML_Logic.true))))))) \<Longrightarrow> ((\<tau> \<Turnstile> (self .contents() \<triangleq> result))) = (if ((\<tau> \<Turnstile> ((\<delta> (self))))) then (\<tau> \<Turnstile> (((UML_Logic.false)) implies ((((UML_Logic.StrongEq) (result)) ((((UML_Logic.OclIf) (((UML_Logic.StrictRefEq) ((Employee_AnalysisModel_UMLPart_generated.dot_0_\<b>\<o>\<s>\<s>) (self))) (UML_Types.null_class.null))) (((UML_Set.OclIncluding) (UML_Set.mtSet)) ((Employee_AnalysisModel_UMLPart_generated.dot\<s>\<a>\<l>\<a>\<r>\<y>) (self)))) (((UML_Set.OclIncluding) ((Employee_AnalysisModel_UMLPart_generated.dot\<c>\<o>\<n>\<t>\<e>\<n>\<t>\<s>) ((Employee_AnalysisModel_UMLPart_generated.dot_0_\<b>\<o>\<s>\<s>) (self)))) ((Employee_AnalysisModel_UMLPart_generated.dot\<s>\<a>\<l>\<a>\<r>\<y>) (self)))) and UML_Logic.true)))) else (\<tau> \<Turnstile> (result \<triangleq> invalid)))"
defs(overloaded) dot\<c>\<o>\<n>\<t>\<e>\<n>\<t>\<s>_Planet : "(x::\<cdot>Planet) .contents() \<equiv> x .oclAsType(Person) .contents()"
defs(overloaded) dot\<c>\<o>\<n>\<t>\<e>\<n>\<t>\<s>_Galaxy : "(x::\<cdot>Galaxy) .contents() \<equiv> x .oclAsType(Person) .contents()"
defs(overloaded) dot\<c>\<o>\<n>\<t>\<e>\<n>\<t>\<s>_OclAny : "(x::\<cdot>OclAny) .contents() \<equiv> x .oclAsType(Person) .contents()"
ML{* (Ty'.check ([]) (" error(s)")) *}

(* 152 ************************************ 938 + 0 *)

(* 153 ************************************ 938 + 1 *)
thm dot\<c>\<o>\<n>\<t>\<e>\<n>\<t>\<s>_def

(* 154 ************************************ 939 + 0 *)

(* 155 ************************************ 939 + 3 *)
axiomatization where Person_aat_pre_def:
"(\<tau> \<Turnstile> (UML_Set.OclForall ((OclAllInstances_at_pre (Person))) ((\<lambda>self. ((UML_Logic.OclImplies) ((UML_Logic.OclNot) (((UML_Logic.StrictRefEq) ((Employee_AnalysisModel_UMLPart_generated.dot_0_\<b>\<o>\<s>\<s>at_pre) (self))) (UML_Types.null_class.null)))) (((UML_Logic.StrongEq) ((Employee_AnalysisModel_UMLPart_generated.dot\<s>\<a>\<l>\<a>\<r>\<y>at_pre) (self))) ((Employee_AnalysisModel_UMLPart_generated.dot\<s>\<a>\<l>\<a>\<r>\<y>at_pre) ((Employee_AnalysisModel_UMLPart_generated.dot_0_\<b>\<o>\<s>\<s>at_pre) (self))))))))"
axiomatization where Person_a_def:
"(\<tau> \<Turnstile> (UML_Set.OclForall ((OclAllInstances_at_post (Person))) ((\<lambda>self. ((UML_Logic.OclImplies) ((UML_Logic.OclNot) (((UML_Logic.StrictRefEq) ((Employee_AnalysisModel_UMLPart_generated.dot_0_\<b>\<o>\<s>\<s>) (self))) (UML_Types.null_class.null)))) (((UML_Logic.StrongEq) ((Employee_AnalysisModel_UMLPart_generated.dot\<s>\<a>\<l>\<a>\<r>\<y>) (self))) ((Employee_AnalysisModel_UMLPart_generated.dot\<s>\<a>\<l>\<a>\<r>\<y>) ((Employee_AnalysisModel_UMLPart_generated.dot_0_\<b>\<o>\<s>\<s>) (self))))))))"
ML{* (Ty'.check ([]) (" error(s)")) *}

(* 156 ************************************ 942 + 1 *)
thm Person_aat_pre_def Person_a_def

(* 157 ************************************ 943 + 0 *)

(* 158 ************************************ 943 + 3 *)
axiomatization where Planet_Aat_pre_def:
"(\<tau> \<Turnstile> (UML_Set.OclForall ((OclAllInstances_at_pre (Planet))) ((\<lambda>self. ((UML_Logic.OclAnd) (UML_Logic.true)) (((UML_Integer.OclLe\<^sub>I\<^sub>n\<^sub>t\<^sub>e\<^sub>g\<^sub>e\<^sub>r) ((Employee_AnalysisModel_UMLPart_generated.dot\<w>\<e>\<i>\<g>\<h>\<t>at_pre) (self))) (UML_Integer.OclInt0))))))"
axiomatization where Planet_A_def:
"(\<tau> \<Turnstile> (UML_Set.OclForall ((OclAllInstances_at_post (Planet))) ((\<lambda>self. ((UML_Logic.OclAnd) (UML_Logic.true)) (((UML_Integer.OclLe\<^sub>I\<^sub>n\<^sub>t\<^sub>e\<^sub>g\<^sub>e\<^sub>r) ((Employee_AnalysisModel_UMLPart_generated.dot\<w>\<e>\<i>\<g>\<h>\<t>) (self))) (UML_Integer.OclInt0))))))"
ML{* (Ty'.check ([]) (" error(s)")) *}

(* 159 ************************************ 946 + 1 *)
thm Planet_Aat_pre_def Planet_A_def

end