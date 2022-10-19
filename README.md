# Genetic_Algorithm

## Problem definition

The Set-Covering problem consists of finding the minimum number of sets that contain all the elements of all the given sets. There are many applications for this type of problem, the main ones being the location of services, selection of files from a database, simplification of Boolean expressions, balancing of production lines, among others.

**General problem**

Let:

$$ A = (a_{ij}) \quad \text{a binary matrix} $$

$$ C = (c_j) \quad \text{a vector} $$  

$$ M = \{ 1,...,m \} $$ 

Set Covering Problem:

$$ \text{min}(z) = \sum _{j=1}^n c_jx_j $$

With the restrictions

$$ \sum_{j=1}^n a_{ij}x_j \geq 1 \quad \forall i \in M $$
