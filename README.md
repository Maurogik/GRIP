GRIP
====

GNU Recursive Interpretation Processor


Known problems
==

- possibility to define a predicate with more than 1 '=' character :
  pred=rio=rio is a valid instruction

- possibility to call a predicate with more than one parenthesis pair
  pred()pred() is interpretated pred(")pred(")

- not only ',' is a separator in predicates' arguments