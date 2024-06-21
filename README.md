# [Practical Web DataBase Design](https://link.springer.com/book/10.1007/978-1-4302-5377-8)

This README file presents my hands-on project inspired by the database concepts covered in the book.
I've also developed example applications as described in the text.
This repository is the result of a collaborative effort during a 6-month mentorship program led by [Eng.Ahmed Emad](https://www.linkedin.com/in/ahmed-emad-abdelall/).

## Book E-commerce Example
- The Entity Relation Diagram Representing The System.

<p align="center">
    <img src="ERD.png">
</p>
<h3 align="center">E-Commerce ERD Diagram</h3>

- Decomposing The Many To Many Relations Into Separate Table.

  <p align="center">
    <img src="ERD decomposing ManyToMany relations.png">
</p>
<h3 align="center">E-Commerce ERD Decomposed Diagram</h3>

- A Denormalized Version Of The Diagram 
> Here is Redundant info, but it offers a **Better Performance** by avoiding joining many tables.

  <p align="center">
    <img src="ERD denormalized.png">
</p>
<h3 align="center">E-Commerce ERD Denormalized Diagram</h3>

## Index:
- [Tables Creation Scripts](TablesDDLScripts.sql)
- [Random Data Generation Procedures up to 2 million record per table to test performance](dataGenerationProcedures)
- [Some Common Queries, e.g., top-selling products And Daily or Monthly Reports](sampleQueries)
- [Some Optimization Techniques](QueriesOptimizationTechniques)
